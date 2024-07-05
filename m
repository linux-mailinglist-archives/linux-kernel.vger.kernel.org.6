Return-Path: <linux-kernel+bounces-242640-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A0D1928ABA
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 16:32:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C416828328E
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 14:32:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D05D16B386;
	Fri,  5 Jul 2024 14:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="ibShQAqn"
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C7B3146A8A
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jul 2024 14:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720189953; cv=none; b=Te9AGCErodt5RU0XzrpejMZA3kZBec+B49/i+p/FManP6mGn0HU2/gdAVDbxvw7LSb9nMz7Y46FVEYtcl24jcUMw+df1LsTnYEVyUFAXGUgXwO2mrAGQGCKTTFG1zWZpcHjMiEsaeAIDFFf14ds+sqPEDmpxv2dxRlfYkoUHrgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720189953; c=relaxed/simple;
	bh=9H/O2JY4DV6l2HQGm8/l2N3lTP0ROhBdceH6cdS5zsk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=s4Ol+aWYpxj92Hioqwchm44lslE9941oEXNaFxbCFTHnizNmr1NUNa4ldyagoz/9+P2MgIotfLOu552jI/5tISFk7gMoTGIcBKfUfDV3s3PIHfCdJkrtDtK/h4LxvT5etdeDp/hxQaLhpLcnT4V8C6uqUvoHTwIAHPq3kG6j6sY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=ibShQAqn; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=vlhZyqR/0gBL25Tskih19pvHfLCMomlyzy7IQpXMJFc=; b=ibShQAqn8rMZi0rHJYdxrpgBNp
	Dc/vBE6tzbu6t4UzIrLp8uxUpBrXsI1TJ5rP3mHPdrkRqlyEjzZJDMLD8MI+ksgbHtJFGyHEK59uz
	KXSTe+/otO9hGmMmGeOUsn7oPBohNzo0V4oKl8kQUEXNad2LxB5RLpSax9EQEbaj0ochtT6SbhsAP
	5RsJpwRKKqU6VsdJrqqyM6VdQyPovE/ZeqJd/Hs1f7cGRJ0CMZmykeTvmBR4SESy1RqHYzLFbi9eC
	mgWC6yOfjEzvFAKhwqpq5/frOIYED6RkUuFpDavhVXZ5+z6Z9Pl21sA3fuIdqXTeFiPmBSPjoIEuh
	t1F7weyA==;
Received: from [84.69.19.168] (helo=localhost)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1sPjz3-00BSmD-VJ; Fri, 05 Jul 2024 16:32:22 +0200
From: Tvrtko Ursulin <tursulin@igalia.com>
To: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org,
	kernel-dev@igalia.com,
	Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
	Huang Ying <ying.huang@intel.com>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 2/3] mm/mempolicy: Use flags lookup array in mpol_to_str
Date: Fri,  5 Jul 2024 15:32:17 +0100
Message-ID: <20240705143218.21258-3-tursulin@igalia.com>
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

Generalise displaying of flags in mpol_to_str() with the benefit of
removing the knowledge of which flags are mutually exclusive and which are
not.

Also add a warning for unknown flags which slightly "hardens" against
possible future omissions to add handling for new stuff, as had happened
in bda420b98505.

Simplify by switching to scnprintf while at it.

Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
References: bda420b98505 ("numa balancing: migrate on fault among multiple bound nodes")
Cc: Huang Ying <ying.huang@intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
---
 mm/mempolicy.c | 58 +++++++++++++++++++++++++++++++++-----------------
 1 file changed, 39 insertions(+), 19 deletions(-)

diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index 1bfb6c73a39c..77488878d8ca 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -3150,6 +3150,17 @@ static const char * const policy_modes[] =
 	[MPOL_PREFERRED_MANY]  = "prefer (many)",
 };
 
+/*
+ * Lookup array containing only uapi flags where the lowest user flag starts at
+ * array index zero.
+ */
+#define MPOL_FLAG_STR_INDEX(f) (ilog2(f) - __builtin_ffs(MPOL_MODE_FLAGS) + 1)
+static const char * const policy_flags[] = {
+	[MPOL_FLAG_STR_INDEX(MPOL_F_STATIC_NODES)] = "static",
+	[MPOL_FLAG_STR_INDEX(MPOL_F_RELATIVE_NODES)] = "relative",
+	[MPOL_FLAG_STR_INDEX(MPOL_F_NUMA_BALANCING)] = "balancing",
+};
+
 #ifdef CONFIG_TMPFS
 /**
  * mpol_parse_str - parse string to mempolicy, for tmpfs mpol mount option.
@@ -3302,14 +3313,21 @@ void mpol_to_str(char *buffer, int maxlen, struct mempolicy *pol)
 	char *p = buffer;
 	nodemask_t nodes = NODE_MASK_NONE;
 	unsigned short mode = MPOL_DEFAULT;
-	unsigned short flags = 0;
+	unsigned int bit, cnt;
+	unsigned long flags = 0;
+	int res;
 
 	if (pol &&
 	    pol != &default_policy &&
 	    !(pol >= &preferred_node_policy[0] &&
 	      pol <= &preferred_node_policy[MAX_NUMNODES - 1])) {
 		mode = pol->mode;
-		flags = pol->flags;
+		/*
+		 * Filter out internal flags and also move user flags to lsb for
+		 * easy lookup, matching the policy_flags[] indices.
+		 */
+		flags = (pol->flags & MPOL_MODE_FLAGS) >>
+			__ffs(MPOL_MODE_FLAGS);
 	}
 
 	switch (mode) {
@@ -3329,29 +3347,31 @@ void mpol_to_str(char *buffer, int maxlen, struct mempolicy *pol)
 		return;
 	}
 
-	p += snprintf(p, maxlen, "%s", policy_modes[mode]);
+	res = scnprintf(p, maxlen, "%s", policy_modes[mode]);
+	p += res;
+	maxlen -= res;
 
-	if (flags & MPOL_MODE_FLAGS) {
-		p += snprintf(p, buffer + maxlen - p, "=");
+	cnt = 0;
+	for_each_set_bit(bit, &flags,
+			 __fls(MPOL_MODE_FLAGS) - __ffs(MPOL_MODE_FLAGS) + 1) {
+		char prefix;
 
-		/*
-		 * Static and relative are mutually exclusive.
-		 */
-		if (flags & MPOL_F_STATIC_NODES)
-			p += snprintf(p, buffer + maxlen - p, "static");
-		else if (flags & MPOL_F_RELATIVE_NODES)
-			p += snprintf(p, buffer + maxlen - p, "relative");
+		if (WARN_ON_ONCE(bit >= ARRAY_SIZE(policy_flags) ||
+				 !policy_flags[bit]))
+			continue;
 
-		if (flags & MPOL_F_NUMA_BALANCING) {
-			if (hweight16(flags & MPOL_MODE_FLAGS) > 1)
-				p += snprintf(p, buffer + maxlen - p, "|");
-			p += snprintf(p, buffer + maxlen - p, "balancing");
-		}
+		if (cnt++ == 0)
+			prefix = '=';
+		else
+			prefix = '|';
+
+		res = scnprintf(p, maxlen, "%c%s", prefix, policy_flags[bit]);
+		p += res;
+		maxlen -= res;
 	}
 
 	if (!nodes_empty(nodes))
-		p += scnprintf(p, buffer + maxlen - p, ":%*pbl",
-			       nodemask_pr_args(&nodes));
+		scnprintf(p, maxlen, ":%*pbl", nodemask_pr_args(&nodes));
 }
 
 #ifdef CONFIG_SYSFS
-- 
2.44.0


