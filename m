Return-Path: <linux-kernel+bounces-189146-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 78CFD8CEBCA
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 23:26:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA8CB1C20FEE
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 21:26:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9286885934;
	Fri, 24 May 2024 21:26:49 +0000 (UTC)
Received: from mail.hallyn.com (mail.hallyn.com [178.63.66.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4D2983CBD
	for <linux-kernel@vger.kernel.org>; Fri, 24 May 2024 21:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.63.66.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716586009; cv=none; b=u9kRHbx4RIX6lTdd2rcf7+0DlaIzeCSzHMjmXhdbRVnsrdqYBkfJIeYBNKR1qPXoF0GpL+H0aA5rjUnFEDVS6lC/Vj7v2Y9rikAnbbT8V0OUXRhh8/HcXbxNamnD8xJw6HKTK0SuidPc+QarrVxqexqz6OY78TTpz+ahHOPbfr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716586009; c=relaxed/simple;
	bh=Y9aA0Gsb5W36p00f5D+3pMCVJ0axlxd07C2qmHqIpYQ=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=XEkn665E2Q7h/PGSWRjT7Lfd0uQG7ycMzbjrdbXH5Lcxa9h82IcMjyRd0Z8nK4vqOX10PzaErYguEGxDEyURkxn9f/u+HXwlN5JmCWwam/Kml8HX/pjeB+pYdXqLeVlixLcef8X++5/jDCO5XxJF1uxlLUq9l7yD2ubK43J9zXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hallyn.com; spf=pass smtp.mailfrom=mail.hallyn.com; arc=none smtp.client-ip=178.63.66.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hallyn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.hallyn.com
Received: by mail.hallyn.com (Postfix, from userid 1001)
	id 6ABA034F; Fri, 24 May 2024 16:26:38 -0500 (CDT)
Date: Fri, 24 May 2024 16:26:38 -0500
From: "Serge E. Hallyn" <serge@hallyn.com>
To: lkml <linux-kernel@vger.kernel.org>, Andy Lutomirski <luto@kernel.org>,
	"Eric W. Biederman" <ebiederm@xmission.com>,
	Tycho Andersen <tycho@tycho.pizza>
Subject: [PATCH 1/1] user_namespace map_write: allow CAP_SETUID/CAP_SETGID
Message-ID: <20240524212638.GA1898944@mail.hallyn.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Before 41c21e351e a task with CAP_SETUID could write to /proc/self/uid_map, or
a task with CAP_SETGID to gid_map.  41c21e351e was an important fix in checking
the capabilities against the opener of the file rather than the writer's
namespace, but it erred in replacing CAP_SETXID with CAP_SYS_ADMIN.  This means
that a task with CAP_SETXID is no longer able to configure its user.  The
argument in the commit message that:

  Changing uid/gid/projid mappings doesn't change your id within the
  namespace; it reconfigures the namespace.

is disputed: First, privilege was needed, the patch only switched the needed
capabilitiy.  Secondly, creating and configuring a new namespace while
getting to choose uids from the parent namespace to bind into the child
namespace is in fact akin to being able to setuid to the newly mapped
uids.

This patch fixes that regression.  Since in the meantime a system
may have started using CAP_SYS_ADMIN, support either now, to avoid
regressing other programs.

Signed-off-by: Serge Hallyn <serge@hallyn.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>
Fixes: 41c21e351e ("userns: Changing any namespace id mappings should require privileges")
---
 kernel/user_namespace.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/kernel/user_namespace.c b/kernel/user_namespace.c
index 0b0b95418b16..8fbf1ef337bb 100644
--- a/kernel/user_namespace.c
+++ b/kernel/user_namespace.c
@@ -920,6 +920,17 @@ static bool verify_root_map(const struct file *file,
 	return true;
 }
 
+static inline bool map_write_allowed(struct file *file, struct user_namespace *map_ns, int cap_setid)
+{
+	// if the cap is -1, then anyone is allowed to write
+	if (!cap_valid(cap_setid))
+		return true;
+
+	// Otherwise, require either cap_setid or CAP_SYS_ADMIN
+	return (file_ns_capable(file, map_ns, cap_setid) ||
+		file_ns_capable(file, map_ns, CAP_SYS_ADMIN));
+}
+
 static ssize_t map_write(struct file *file, const char __user *buf,
 			 size_t count, loff_t *ppos,
 			 int cap_setid,
@@ -974,7 +985,7 @@ static ssize_t map_write(struct file *file, const char __user *buf,
 	/*
 	 * Adjusting namespace settings requires capabilities on the target.
 	 */
-	if (cap_valid(cap_setid) && !file_ns_capable(file, map_ns, CAP_SYS_ADMIN))
+	if (!map_write_allowed(file, map_ns, cap_setid))
 		goto out;
 
 	/* Parse the user data */
-- 
2.34.1


