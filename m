Return-Path: <linux-kernel+bounces-237985-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C4369241B5
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 17:01:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 906EB1C2317A
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 15:01:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D5C61BBBF4;
	Tue,  2 Jul 2024 15:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="LMnmq1BZ"
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC1B71BBBDD
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jul 2024 15:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719932430; cv=none; b=ObCbr8daD1iN/5rfnqOw+ppERsAUjbYfjnMqsR9VL1sizuIvz0Tb8KPVVDx7wkH7mKlHv4y3U822djPJNTVhnQUHjvzI6xIw80IWbtr+C7s/8R+NqakJOhP465eqSMsN5b7Ad/T1hQSoP5Jjfo+KdWMdZe9aHiAYKSWxjCvcQ6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719932430; c=relaxed/simple;
	bh=onnPUMSPdcMeb2P+LxVLpLHZYrff8ueM75bmNfHuAFA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rZqCJD91ni8DeM8UzBzKMRT1CtBG5TgqGokD7raPm7ucQoTOhq5xPZbHfnoG2/MUi+mi91BabVeqPUISLj8m44cbr05yyvgdS6GfU2MxTgZvC30W9mm0Wj/43s8NcIODdXSjXsDGtypN0N7Az53L1icqTMv8oOae3nqplL4A5KU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=LMnmq1BZ; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:
	Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=HT85tArOXtaRnXCBCgyxPKfbL7lM00ED4dcauG6uHIY=; b=LMnmq1BZVOa77QmHew6rpAVYEu
	Q4GD/NW7P3+7lUcRArQlyUyXVz66S7FyR/FD2I2PGrfhz1aGuHe8/hab+1PbACAkDUYxrQxabBJ6W
	zid7QGYrQcmqeBuCMcNc6wj7XTV90V5FFZvQ7Al4l/5mFDgzIOnm4xioYuXnMPZX4AOkTECHAWLtm
	VhmrxzHptzlxRfrDXyMxIW3Sqqbuj55Ga1sHVH3+ZVeReyHIcMrdZAfO3jSeDBfD7DjzIj2uBz/0p
	en8gxSGMeG3SV1du9ItZrO5IjAD1HZGnktzRAId+KRfCFgYzp20LSdOD/omgYlacffTFXYAOir5Pe
	2V60JcAg==;
Received: from [84.69.19.168] (helo=localhost)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1sOezJ-00ALZH-6S; Tue, 02 Jul 2024 17:00:09 +0200
From: Tvrtko Ursulin <tursulin@igalia.com>
To: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org,
	kernel-dev@igalia.com,
	Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
	Huang Ying <ying.huang@intel.com>,
	Mel Gorman <mgorman@suse.de>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Rik van Riel <riel@surriel.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Dave Hansen <dave.hansen@intel.com>,
	Andi Kleen <ak@linux.intel.com>,
	Michal Hocko <mhocko@suse.com>,
	David Rientjes <rientjes@google.com>
Subject: [PATCH v2] mm/numa_balancing: Teach mpol_to_str about the balancing mode
Date: Tue,  2 Jul 2024 16:00:06 +0100
Message-ID: <20240702150006.35206-1-tursulin@igalia.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>

Since balancing mode was added in
bda420b98505 ("numa balancing: migrate on fault among multiple bound nodes"),
it was possible to set this mode but it wouldn't be shown in
/proc/<pid>/numa_maps since there was no support for it in the
mpol_to_str() helper.

Furthermore, because the balancing mode sets the MPOL_F_MORON flag, it
would be displayed as 'default' due a workaround introduced a few years
earlier in
8790c71a18e5 ("mm/mempolicy.c: fix mempolicy printing in numa_maps").

To tidy this up we implement two changes:

First we introduce a new internal flag MPOL_F_KERNEL and with it mark the
kernel's internal default and fallback policies (for tasks and/or VMAs
with no explicit policy set). By doing this we generalise the current
special casing and replace the incorrect 'default' with the correct
'bind'.

Secondly, we add a string representation and corresponding handling for
MPOL_F_NUMA_BALANCING. We do this by adding a sparse mapping array of
flags to names. With the sparseness being the downside, but with the
advantage of generalising and removing the "policy" from flags display.

End result:

$ numactl -b -m 0-1,3 cat /proc/self/numa_maps
555559580000 bind=balancing:0-1,3 file=/usr/bin/cat mapped=3 active=0 N0=3 kernelpagesize_kB=16
...

v2:
 * Fully fix by introducing MPOL_F_KERNEL.

Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Fixes: bda420b98505 ("numa balancing: migrate on fault among multiple bound nodes")
References: 8790c71a18e5 ("mm/mempolicy.c: fix mempolicy printing in numa_maps")
Cc: Huang Ying <ying.huang@intel.com>
Cc: Mel Gorman <mgorman@suse.de>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Rik van Riel <riel@surriel.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: Dave Hansen <dave.hansen@intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Michal Hocko <mhocko@suse.com>
Cc: David Rientjes <rientjes@google.com>
---
 include/uapi/linux/mempolicy.h |  1 +
 mm/mempolicy.c                 | 44 ++++++++++++++++++++++++----------
 2 files changed, 32 insertions(+), 13 deletions(-)

diff --git a/include/uapi/linux/mempolicy.h b/include/uapi/linux/mempolicy.h
index 1f9bb10d1a47..bcf56ce9603b 100644
--- a/include/uapi/linux/mempolicy.h
+++ b/include/uapi/linux/mempolicy.h
@@ -64,6 +64,7 @@ enum {
 #define MPOL_F_SHARED  (1 << 0)	/* identify shared policies */
 #define MPOL_F_MOF	(1 << 3) /* this policy wants migrate on fault */
 #define MPOL_F_MORON	(1 << 4) /* Migrate On protnone Reference On Node */
+#define MPOL_F_KERNEL   (1 << 5) /* Kernel's internal policy */
 
 /*
  * These bit locations are exposed in the vm.zone_reclaim_mode sysctl
diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index aec756ae5637..8ecc6d9f100a 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -134,6 +134,7 @@ enum zone_type policy_zone = 0;
 static struct mempolicy default_policy = {
 	.refcnt = ATOMIC_INIT(1), /* never free it */
 	.mode = MPOL_LOCAL,
+	.flags = MPOL_F_KERNEL,
 };
 
 static struct mempolicy preferred_node_policy[MAX_NUMNODES];
@@ -3095,7 +3096,7 @@ void __init numa_policy_init(void)
 		preferred_node_policy[nid] = (struct mempolicy) {
 			.refcnt = ATOMIC_INIT(1),
 			.mode = MPOL_PREFERRED,
-			.flags = MPOL_F_MOF | MPOL_F_MORON,
+			.flags = MPOL_F_MOF | MPOL_F_MORON | MPOL_F_KERNEL,
 			.nodes = nodemask_of_node(nid),
 		};
 	}
@@ -3150,6 +3151,12 @@ static const char * const policy_modes[] =
 	[MPOL_PREFERRED_MANY]  = "prefer (many)",
 };
 
+static const char * const policy_flags[] = {
+	[ilog2(MPOL_F_STATIC_NODES)] = "static",
+	[ilog2(MPOL_F_RELATIVE_NODES)] = "relative",
+	[ilog2(MPOL_F_NUMA_BALANCING)] = "balancing",
+};
+
 #ifdef CONFIG_TMPFS
 /**
  * mpol_parse_str - parse string to mempolicy, for tmpfs mpol mount option.
@@ -3293,17 +3300,18 @@ int mpol_parse_str(char *str, struct mempolicy **mpol)
  * @pol:  pointer to mempolicy to be formatted
  *
  * Convert @pol into a string.  If @buffer is too short, truncate the string.
- * Recommend a @maxlen of at least 32 for the longest mode, "interleave", the
- * longest flag, "relative", and to display at least a few node ids.
+ * Recommend a @maxlen of at least 42 for the longest mode, "weighted
+ * interleave", the longest flag, "balancing", and to display at least a few
+ * node ids.
  */
 void mpol_to_str(char *buffer, int maxlen, struct mempolicy *pol)
 {
 	char *p = buffer;
 	nodemask_t nodes = NODE_MASK_NONE;
 	unsigned short mode = MPOL_DEFAULT;
-	unsigned short flags = 0;
+	unsigned long flags = 0;
 
-	if (pol && pol != &default_policy && !(pol->flags & MPOL_F_MORON)) {
+	if (!(pol->flags & MPOL_F_KERNEL)) {
 		mode = pol->mode;
 		flags = pol->flags;
 	}
@@ -3328,15 +3336,25 @@ void mpol_to_str(char *buffer, int maxlen, struct mempolicy *pol)
 	p += snprintf(p, maxlen, "%s", policy_modes[mode]);
 
 	if (flags & MPOL_MODE_FLAGS) {
-		p += snprintf(p, buffer + maxlen - p, "=");
+		unsigned int bit, cnt = 0;
 
-		/*
-		 * Currently, the only defined flags are mutually exclusive
-		 */
-		if (flags & MPOL_F_STATIC_NODES)
-			p += snprintf(p, buffer + maxlen - p, "static");
-		else if (flags & MPOL_F_RELATIVE_NODES)
-			p += snprintf(p, buffer + maxlen - p, "relative");
+		for_each_set_bit(bit, &flags, ARRAY_SIZE(policy_flags)) {
+			if (bit <= ilog2(MPOL_F_KERNEL))
+				continue;
+
+			if (cnt == 0)
+				p += snprintf(p, buffer + maxlen - p, "=");
+			else
+				p += snprintf(p, buffer + maxlen - p, ",");
+
+			if (WARN_ON_ONCE(!policy_flags[bit]))
+				p += snprintf(p, buffer + maxlen - p, "bit%u",
+					      bit);
+			else
+				p += snprintf(p, buffer + maxlen - p,
+					      policy_flags[bit]);
+			cnt++;
+		}
 	}
 
 	if (!nodes_empty(nodes))
-- 
2.44.0


