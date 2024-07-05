Return-Path: <linux-kernel+bounces-242642-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31C00928ABB
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 16:32:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B1B34286808
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 14:32:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E880D16C690;
	Fri,  5 Jul 2024 14:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="b3GATmHf"
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D90D514EC59
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jul 2024 14:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720189955; cv=none; b=YDjawBANhviIoIa5W2smhWiQ16t8pcdjqRZI8k2rhiEq858R6k1tW40+sXikVSjq/WmpgSGB5rNdhayj/y9/wQS+jWP/8aj7fixYn1kr/AICRYW4NOALfhydS0qBrx6ng8aWUfY4KaaZGoXl4e+T+JxmQXY3KUL8voHcXE4MS9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720189955; c=relaxed/simple;
	bh=nRT+7uGsgvVH044fBhhlruyNOC/hoIX0xrUTGlz2j2o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mAdQsU5LeAvSFHOBj5badI0/rGVTJH5OkF3sJo78J/rjOnHD+bZeQBBvG/4Id0mvdBekq2HCCU1MW1MIVW43bVYtRNEHA885ndOtVJ9wPs8bj/d9vT35qRSsF4TXs6pNyIXrBsFvJhfQZH0aqKqdXOUSuMlCc4MKAdtARFJU2sU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=b3GATmHf; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=X9c/u6IuXuq2ptbPAeOOtmwLogxWpVC5JfaFfXThbYE=; b=b3GATmHfgG6uiSUsA/BE4oaTAc
	ocRd/ku6O1BJr3nnBdT4hcU7LTOId5yDdR8quv89XJuYtuk/RhaYVhxyZlCJUePqHHWIsL6nogU0q
	//UXJUizDKBktOW78ckQXBeHvDXF13kjrBRr57dlNq+rIzW34X7A/3SDdNzhEK9T+dk3Sj3ZI8QGb
	4TdwwsrggRXgY4xmqwKm/5GPjboSfKt18S21gDeC6yDcutJJiG0QsVeent6LyKQ3VmJPgHvlIGo4t
	uNEfO8WCwyOo6qFdr3Rmnx7uCnrWRdrmhgen/Ywt0JrZN+ahZFuSExlpsNYvtMMZP6tl+i7Tk7nER
	53YrOwxA==;
Received: from [84.69.19.168] (helo=localhost)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1sPjz4-00BSmO-LD; Fri, 05 Jul 2024 16:32:22 +0200
From: Tvrtko Ursulin <tursulin@igalia.com>
To: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org,
	kernel-dev@igalia.com,
	Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
	Huang Ying <ying.huang@intel.com>,
	Hugh Dickins <hughd@google.com>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 3/3] mm/numa_balancing: Allow setting numa balancing for tmpfs
Date: Fri,  5 Jul 2024 15:32:18 +0100
Message-ID: <20240705143218.21258-4-tursulin@igalia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240705143218.21258-1-tursulin@igalia.com>
References: <20240705143218.21258-1-tursulin@igalia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>

Since MPOL_F_NUMA_BALANCING was added some time ago, lets also recognise
it as a valid tmpfs mount option.

As an extension to the exiting format:

  mpol=<mode>[=<flag>][:nodelist]

Multiple flags are added in a list separated by vertical bars, such as:

  mpol=<mode>[=<flag>[|<flag>]...][:nodelist]

For example:

 $ mount none -t tmpfs mnt -o mpol=bind=balancing:2,0
 $ mount | grep mpol
 none on ... type tmpfs (rw,relatime,mpol=bind=balancing:0,2)

Or:

 $ mount none mnt -t tmpfs -o "mpol=bind=balancing|static:1,0"
 $ mount | grep mpol
 none on ... type tmpfs (rw,relatime,mpol=bind=balancing|static:0-1)

I am not sure to be honest if this is useful for tmpfs, but is just an
asymmetry I noticed while doing stuff in this area.

Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Cc: Huang Ying <ying.huang@intel.com>
Cc: Hugh Dickins <hughd@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
---
 mm/mempolicy.c | 55 +++++++++++++++++++++++++++++++++++++++-----------
 1 file changed, 43 insertions(+), 12 deletions(-)

diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index 77488878d8ca..c69bf5438731 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -3162,6 +3162,47 @@ static const char * const policy_flags[] = {
 };
 
 #ifdef CONFIG_TMPFS
+static int mpol_lookup_flag(char *str)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(policy_flags); i++) {
+		if (policy_flags[i] && !strcmp(str, policy_flags[i]))
+			return BIT(i + __ffs(MPOL_MODE_FLAGS));
+	}
+
+	return -1;
+}
+
+static bool mpol_parse_flags(char *str, int *mode, unsigned short *flags)
+{
+	char buf[128], *opt;
+	int flag;
+
+	/* Make a local copy since caller wants the original untouched. */
+	if (WARN_ON_ONCE(strscpy(buf, str, sizeof(buf)) < 0))
+		return false;
+
+	str = buf;
+	for (;;) {
+		opt = strsep(&str, "|");
+
+		if (!opt)
+			break;
+		else if (*opt == '\0')
+			continue;
+
+		flag = mpol_lookup_flag(opt);
+		if (flag < 0)
+			return false;
+		*flags |= flag;
+	}
+
+	*mode |= *flags;
+
+	return sanitize_mpol_flags(mode, flags) == 0;
+}
+
 /**
  * mpol_parse_str - parse string to mempolicy, for tmpfs mpol mount option.
  * @str:  string containing mempolicy to parse
@@ -3247,18 +3288,8 @@ int mpol_parse_str(char *str, struct mempolicy **mpol)
 	}
 
 	mode_flags = 0;
-	if (flags) {
-		/*
-		 * Currently, we only support two mutually exclusive
-		 * mode flags.
-		 */
-		if (!strcmp(flags, "static"))
-			mode_flags |= MPOL_F_STATIC_NODES;
-		else if (!strcmp(flags, "relative"))
-			mode_flags |= MPOL_F_RELATIVE_NODES;
-		else
-			goto out;
-	}
+	if (flags && !mpol_parse_flags(flags, &mode, &mode_flags))
+		goto out;
 
 	new = mpol_new(mode, mode_flags, &nodes);
 	if (IS_ERR(new))
-- 
2.44.0


