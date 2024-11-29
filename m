Return-Path: <linux-kernel+bounces-418344-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41D7B9D609F
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 15:41:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C7A8CB2497A
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 14:41:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C2891DEFC7;
	Fri, 22 Nov 2024 14:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="FM5wsDLX"
Received: from smtp-bc0a.mail.infomaniak.ch (smtp-bc0a.mail.infomaniak.ch [45.157.188.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 486B613AA4E
	for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 14:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.157.188.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732286413; cv=none; b=jr+/U/bqUDtjrVAtD8wAsF42MwBQDnOwINIXER7XfOP9EKSDjxRdVZawEULZ3v6l/X6Vpe8rSDVLyOPhoFhZwizEMZit2MsL1XQjGYGZO6ccpDxqezCJJ60mpBuwHZKO6H/OFBP5RE/in6J3qRN6DbKiwzoHAr2R+7QxYteC5U4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732286413; c=relaxed/simple;
	bh=apRtCBU1pS/XutrV3xbNQz6+67PghbyHR49RJBva0bY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=C3cpsTjNS9ALrCzkS4gZpbgHgu/VKx3Rs3+PllgJ97n1ZYEellOZLxPQqfFvX2i3c+nPRFrUNPWrGq6y5ia1Sn9/9ugjKb0xnBGyZVlyOkIoxUVLsIBCQUv07ncnSTkA/84T8P9Ju8yfWbtdiVwzYnZB0Ev6aZBhF5FQoV3X8BQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=FM5wsDLX; arc=none smtp.client-ip=45.157.188.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-3-0000.mail.infomaniak.ch (unknown [IPv6:2001:1600:4:17::246b])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4XvyKB6KwSzcS2;
	Fri, 22 Nov 2024 15:34:06 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1732286046;
	bh=qrbMeIvoqfDB7rznGcWt/v6+wjhOfu4JkdrgrSKd1mA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FM5wsDLXJNQzCAtjQJCHr5I6wqKX2evC4m3sIIty243+ZqX2JqXDi9QAYLbQzeB++
	 Ag1pIoqnuQJjGAKuKrZlEve4b0T2tbCoZQVS4Y+NS3vt/nY2vN1Pj2BmBimUgYPiKJ
	 gzcraYf8N/4QYkN0OE/75qjJTzWTVUCtpFu7E7Jw=
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4XvyKB1N26zlKG;
	Fri, 22 Nov 2024 15:34:06 +0100 (CET)
From: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To: Eric Paris <eparis@redhat.com>,
	Paul Moore <paul@paul-moore.com>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	"Serge E . Hallyn" <serge@hallyn.com>
Cc: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	Ben Scarlato <akhna@google.com>,
	Casey Schaufler <casey@schaufler-ca.com>,
	Charles Zaffery <czaffery@roblox.com>,
	Francis Laniel <flaniel@linux.microsoft.com>,
	James Morris <jmorris@namei.org>,
	Jann Horn <jannh@google.com>,
	Jeff Xu <jeffxu@google.com>,
	Jorge Lucangeli Obes <jorgelo@google.com>,
	Kees Cook <kees@kernel.org>,
	Konstantin Meskhidze <konstantin.meskhidze@huawei.com>,
	Matt Bobrowski <mattbobrowski@google.com>,
	Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>,
	Phil Sutter <phil@nwl.cc>,
	Praveen K Paladugu <prapal@linux.microsoft.com>,
	Robert Salvet <robert.salvet@roblox.com>,
	Shervin Oloumi <enlightened@google.com>,
	Song Liu <song@kernel.org>,
	Tahera Fahimi <fahimitahera@gmail.com>,
	audit@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org
Subject: [PATCH v3 03/23] landlock: Factor out check_access_path()
Date: Fri, 22 Nov 2024 15:33:33 +0100
Message-ID: <20241122143353.59367-4-mic@digikod.net>
In-Reply-To: <20241122143353.59367-1-mic@digikod.net>
References: <20241122143353.59367-1-mic@digikod.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha

Merge check_access_path() into current_check_access_path() and make
hook_path_mknod() use it.

Cc: Günther Noack <gnoack@google.com>
Signed-off-by: Mickaël Salaün <mic@digikod.net>
Link: https://lore.kernel.org/r/20241122143353.59367-4-mic@digikod.net
---

Changes since v1:
- Rebased on the TCP patch series.
- Remove inlining removal which was merged.
---
 security/landlock/fs.c | 32 +++++++++++---------------------
 1 file changed, 11 insertions(+), 21 deletions(-)

diff --git a/security/landlock/fs.c b/security/landlock/fs.c
index e31b97a9f175..d911c924843f 100644
--- a/security/landlock/fs.c
+++ b/security/landlock/fs.c
@@ -908,28 +908,22 @@ static bool is_access_to_paths_allowed(
 	return allowed_parent1 && allowed_parent2;
 }
 
-static int check_access_path(const struct landlock_ruleset *const domain,
-			     const struct path *const path,
-			     access_mask_t access_request)
-{
-	layer_mask_t layer_masks[LANDLOCK_NUM_ACCESS_FS] = {};
-
-	access_request = landlock_init_layer_masks(
-		domain, access_request, &layer_masks, LANDLOCK_KEY_INODE);
-	if (is_access_to_paths_allowed(domain, path, access_request,
-				       &layer_masks, NULL, 0, NULL, NULL))
-		return 0;
-	return -EACCES;
-}
-
 static int current_check_access_path(const struct path *const path,
-				     const access_mask_t access_request)
+				     access_mask_t access_request)
 {
 	const struct landlock_ruleset *const dom = get_current_fs_domain();
+	layer_mask_t layer_masks[LANDLOCK_NUM_ACCESS_FS] = {};
 
 	if (!dom)
 		return 0;
-	return check_access_path(dom, path, access_request);
+
+	access_request = landlock_init_layer_masks(
+		dom, access_request, &layer_masks, LANDLOCK_KEY_INODE);
+	if (is_access_to_paths_allowed(dom, path, access_request, &layer_masks,
+				       NULL, 0, NULL, NULL))
+		return 0;
+
+	return -EACCES;
 }
 
 static access_mask_t get_mode_access(const umode_t mode)
@@ -1414,11 +1408,7 @@ static int hook_path_mknod(const struct path *const dir,
 			   struct dentry *const dentry, const umode_t mode,
 			   const unsigned int dev)
 {
-	const struct landlock_ruleset *const dom = get_current_fs_domain();
-
-	if (!dom)
-		return 0;
-	return check_access_path(dom, dir, get_mode_access(mode));
+	return current_check_access_path(dir, get_mode_access(mode));
 }
 
 static int hook_path_symlink(const struct path *const dir,
-- 
2.47.0


