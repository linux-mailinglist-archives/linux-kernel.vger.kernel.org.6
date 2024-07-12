Return-Path: <linux-kernel+bounces-250092-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 739E092F427
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 04:45:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 03A2F1F229D0
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 02:45:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B67CBF9D9;
	Fri, 12 Jul 2024 02:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sent.com header.i=@sent.com header.b="nZefoTlK";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="MTIp+Eg2"
Received: from fhigh3-smtp.messagingengine.com (fhigh3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D80DF945A
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2024 02:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720752311; cv=none; b=aGEL2MzQgV2dMFPsFXfbsJyrQ9p6LFLh0ipYAYJbMT/Sn/hC2N6p6bdrhlkIregD7u8mL7gw6jmw6sDbfTwneKmIiQzTgf4kc2i85gEnWZE2N62ZiNYFT0FHoMI8wxQleyej2ltQeEWFHO74NY3OuBtO6Ym3DN/yy3e/gNnoIy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720752311; c=relaxed/simple;
	bh=c0nRaAa/DcrhA+LAqIClyN3TmqGUz4A01EWlnFq00zs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ttxuLrtGAxDrW4uVMj+5Fraz05tOLBYVTcQwJsK71u3BaIx6zENifI+PgvhWO5OOkxQmMxwE9O0VXQMLgHwGcCmQMPlsdDa+a3DMzIWo3xWhbStHoVcGXw/JlAPRuyY9eLUQ7e+gu3BkcPmNHglHAgMN9LMfpMItFTKCW1VjHA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sent.com; spf=pass smtp.mailfrom=sent.com; dkim=pass (2048-bit key) header.d=sent.com header.i=@sent.com header.b=nZefoTlK; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=MTIp+Eg2; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sent.com
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id DC88711403D2;
	Thu, 11 Jul 2024 22:45:08 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Thu, 11 Jul 2024 22:45:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sent.com; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to; s=fm2; t=1720752308;
	 x=1720838708; bh=to4wnXa/PHhQKWIeEkU0XgFAJrxVOY/Z7C32sHOwamo=; b=
	nZefoTlKwQe9WlVRNw7pzFUFeLBTgJkzPIKJJcV7IkC8gOOEOkpF/+sUO4S9C4Jk
	1C2FaybJ4DXMwA7Pez1e80TZ3vZc8awY36g8T3RuZtpvx92qWbrUohOL6q1juGt5
	5ZXBFk0mcJsAFUMM+IkE4Rjs8GjRRdll7kSkl+v6VlXTMr3wPoPl6TMEp5VY3NfV
	WEBOxvHbTZSM/rFmP/EhwvWIP5kXhcFPP0HV/6EOI0mJq5VQHyfUQBWIRC8/wiiG
	KTjRsswYWjfhH6w/2cZ1cagkZx43LbrJAHHgUPP0WaqqEJcVkKE+R8C/EYAFiCA6
	KdNztpxOHA3QrIjFj5GURA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1720752308; x=
	1720838708; bh=to4wnXa/PHhQKWIeEkU0XgFAJrxVOY/Z7C32sHOwamo=; b=M
	TIp+Eg20hq6uumef+91PiN0qYVH0tM/c8uB8w49KQCgTFTGrGtWPWdZe15NWsy6n
	T0AA5SOVHVb9WJKmUZoI4mmIHgcTavU/OFrpxgZdneIAOfE2kwsFTLxBoj3xq7ql
	UwC/ALDV6I/LMKPKwn7XUD1g31YN8bzInB5V2FdVVBX54OGWcLIYfuyyd1nOybWL
	8bI1hXYwvT+OMpNzRJQuWYHV74FdETCbCSSSx8Fy352mPoWFqzigFMv0TC0pkTV0
	hH3VPQXGcus4psENBuTi/tiMXGh/nqRVyAbipDYxmCLqpQ0TFdz3s14ZXIq9Vy/n
	p/NKrviCBDq2kFrzFVFgg==
X-ME-Sender: <xms:s5iQZmZzscTBVeqkiw1HNAs1TY7KeLe9eB3u23lVPSc5iK0TuKgZPA>
    <xme:s5iQZpbiOUuTI56OUePARE3ba5IC4UqqMsUbetU7AxwVFxM8WPeADhMnDQBRxYQ8n
    1OLBo6uqAjXlefgjw>
X-ME-Received: <xmr:s5iQZg-W4PaSFRYoF8yODKNZtp8dzaGvD5U3rc0V3S2RZnHSIGyJKcdAsEW7hYaDhu0_cqv5UNwPzANcBkPv6ALtUg8voVB24hYM3o3YMlMtQ-NoB97wXusX>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrfeehgdeigecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvfevufffkffojghfrhgggfestdekredtredttdenucfhrhhomhepkghiucgj
    rghnuceoiihirdihrghnsehsvghnthdrtghomheqnecuggftrfgrthhtvghrnhepudfgfe
    elhfekiefgtedvudfghfduffefieefffejvefhlefhhffgkedtfeevhfevnecuvehluhhs
    thgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepiihirdihrghnsehsvg
    hnthdrtghomh
X-ME-Proxy: <xmx:s5iQZorKKIE2dPmJjo44QetEisTcKSwjoj-g0VM20ldUhiuTgYs68A>
    <xmx:s5iQZhr90UNyPdEk4oCtzXKK2HYcXn5h7OfW6JP6pM0bWfT5nMF5WQ>
    <xmx:s5iQZmS8rOpbYCvtFCSMMp7emUAOgxXxgC1-X_SeqLj2hEPCZYuQvA>
    <xmx:s5iQZhqgm_MYYxsQao0U84hCVX6w_-Xc39l-oUnDMJBEXVbx2ukPnA>
    <xmx:tJiQZlI-2Ws8X1OBY6x_OcoeffxcE-nstTk3KtGPBN63QhIowPgmvgEB>
Feedback-ID: iccd040f4:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 11 Jul 2024 22:45:07 -0400 (EDT)
From: Zi Yan <zi.yan@sent.com>
To: David Hildenbrand <david@redhat.com>,
	"Huang, Ying" <ying.huang@intel.com>,
	linux-mm@kvack.org
Cc: Zi Yan <ziy@nvidia.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH 2/3] memory tiering: introduce folio_has_cpupid() check
Date: Thu, 11 Jul 2024 22:44:54 -0400
Message-ID: <20240712024455.163543-3-zi.yan@sent.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240712024455.163543-1-zi.yan@sent.com>
References: <20240712024455.163543-1-zi.yan@sent.com>
Reply-To: Zi Yan <ziy@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Zi Yan <ziy@nvidia.com>

Instead of open coded check for if memory tiering mode is on and a folio
is in the top tier memory, use a function to encapsulate the check.

Signed-off-by: Zi Yan <ziy@nvidia.com>
---
 include/linux/memory-tiers.h |  8 ++++++++
 kernel/sched/fair.c          |  3 +--
 mm/huge_memory.c             |  6 ++----
 mm/memory-tiers.c            | 17 +++++++++++++++++
 mm/memory.c                  |  3 +--
 mm/mprotect.c                |  3 +--
 6 files changed, 30 insertions(+), 10 deletions(-)

diff --git a/include/linux/memory-tiers.h b/include/linux/memory-tiers.h
index 0dc0cf2863e2..10c127d461c4 100644
--- a/include/linux/memory-tiers.h
+++ b/include/linux/memory-tiers.h
@@ -73,6 +73,10 @@ static inline bool node_is_toptier(int node)
 }
 #endif
 
+
+bool folio_has_cpupid(struct folio *folio);
+
+
 #else
 
 #define numa_demotion_enabled	false
@@ -151,5 +155,9 @@ static inline struct memory_dev_type *mt_find_alloc_memory_type(int adist,
 static inline void mt_put_memory_types(struct list_head *memory_types)
 {
 }
+static inline bool folio_has_cpupid(struct folio *folio)
+{
+	return true;
+}
 #endif	/* CONFIG_NUMA */
 #endif  /* _LINUX_MEMORY_TIERS_H */
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 8a5b1ae0aa55..03de808cb3cc 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -1840,8 +1840,7 @@ bool should_numa_migrate_memory(struct task_struct *p, struct folio *folio,
 	 * The pages in slow memory node should be migrated according
 	 * to hot/cold instead of private/shared.
 	 */
-	if (sysctl_numa_balancing_mode & NUMA_BALANCING_MEMORY_TIERING &&
-	    !node_is_toptier(src_nid)) {
+	if (!folio_has_cpupid(folio)) {
 		struct pglist_data *pgdat;
 		unsigned long rate_limit;
 		unsigned int latency, th, def_th;
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 07d9dde4ca33..8c11d6da4b36 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -1705,8 +1705,7 @@ vm_fault_t do_huge_pmd_numa_page(struct vm_fault *vmf)
 	 * For memory tiering mode, cpupid of slow memory page is used
 	 * to record page access time.  So use default value.
 	 */
-	if (!(sysctl_numa_balancing_mode & NUMA_BALANCING_MEMORY_TIERING) ||
-	    node_is_toptier(nid))
+	if (folio_has_cpupid(folio))
 		last_cpupid = folio_last_cpupid(folio);
 	target_nid = numa_migrate_prep(folio, vmf, haddr, nid, &flags);
 	if (target_nid == NUMA_NO_NODE)
@@ -2059,8 +2058,7 @@ int change_huge_pmd(struct mmu_gather *tlb, struct vm_area_struct *vma,
 		    toptier)
 			goto unlock;
 
-		if (sysctl_numa_balancing_mode & NUMA_BALANCING_MEMORY_TIERING &&
-		    !toptier)
+		if (!folio_has_cpupid(folio))
 			folio_xchg_access_time(folio,
 					       jiffies_to_msecs(jiffies));
 	}
diff --git a/mm/memory-tiers.c b/mm/memory-tiers.c
index 4775b3a3dabe..7f0360d4e3a0 100644
--- a/mm/memory-tiers.c
+++ b/mm/memory-tiers.c
@@ -6,6 +6,7 @@
 #include <linux/memory.h>
 #include <linux/memory-tiers.h>
 #include <linux/notifier.h>
+#include <linux/sched/sysctl.h>
 
 #include "internal.h"
 
@@ -50,6 +51,22 @@ static const struct bus_type memory_tier_subsys = {
 	.dev_name = "memory_tier",
 };
 
+/**
+ * folio_has_cpupid - check if a folio has cpupid information
+ * @folio: folio to check
+ *
+ * folio's _last_cpupid field is repurposed by memory tiering. In memory
+ * tiering mode, cpupid of slow memory folio (not toptier memory) is used to
+ * record page access time.
+ *
+ * Return: the folio _last_cpupid is used as cpupid
+ */
+bool folio_has_cpupid(struct folio *folio)
+{
+	return !(sysctl_numa_balancing_mode & NUMA_BALANCING_MEMORY_TIERING) ||
+	       node_is_toptier(folio_nid(folio));
+}
+
 #ifdef CONFIG_MIGRATION
 static int top_tier_adistance;
 /*
diff --git a/mm/memory.c b/mm/memory.c
index dceb62f3fa34..96c2f5b3d796 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -5344,8 +5344,7 @@ static vm_fault_t do_numa_page(struct vm_fault *vmf)
 	 * For memory tiering mode, cpupid of slow memory page is used
 	 * to record page access time.  So use default value.
 	 */
-	if ((sysctl_numa_balancing_mode & NUMA_BALANCING_MEMORY_TIERING) &&
-	    !node_is_toptier(nid))
+	if (!folio_has_cpupid(folio))
 		last_cpupid = (-1 & LAST_CPUPID_MASK);
 	else
 		last_cpupid = folio_last_cpupid(folio);
diff --git a/mm/mprotect.c b/mm/mprotect.c
index 222ab434da54..787c3c2bf1b6 100644
--- a/mm/mprotect.c
+++ b/mm/mprotect.c
@@ -161,8 +161,7 @@ static long change_pte_range(struct mmu_gather *tlb,
 				if (!(sysctl_numa_balancing_mode & NUMA_BALANCING_NORMAL) &&
 				    toptier)
 					continue;
-				if (sysctl_numa_balancing_mode & NUMA_BALANCING_MEMORY_TIERING &&
-				    !toptier)
+				if (!folio_has_cpupid(folio))
 					folio_xchg_access_time(folio,
 						jiffies_to_msecs(jiffies));
 			}
-- 
2.43.0


