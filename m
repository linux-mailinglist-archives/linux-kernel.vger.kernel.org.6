Return-Path: <linux-kernel+bounces-513423-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E58EAA34A60
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 17:43:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6384D3B27DE
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 16:32:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47BBD27FE8C;
	Thu, 13 Feb 2025 16:21:36 +0000 (UTC)
Received: from shelob.surriel.com (shelob.surriel.com [96.67.55.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 573E520126C
	for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 16:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=96.67.55.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739463695; cv=none; b=pJrZxunuOe4OdJE7suWGryXKqUZRQMODupZfInCtTt2YYdTXDSJAuceWyFvfzAotrjvRrNt+C/YsaiqXOee7bh6DNi4Akt6cR7kBNtNQi69gIKZ0SCAQ0XDxvJMTihhgJyG09PnEUU1Tc5pk7+K5jUVJM1jICuMePZ2gUOuQics=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739463695; c=relaxed/simple;
	bh=czRLfE4pB5zLObdux1trbCLYsIC5xXPC9035hdEhvBc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lf5EOP7iNP2twAqaqs5EiNlpZrUa7VGXynN1aXkTHXJhs8TtErMCihiMF0oPuRU9HHgFRvtieMRq7fGkQNsHai29M4Lf8PrUiRnC1oAAwqI+HDD70Vj145cLcOpuOTEMYyTJ0UL7TkQAx517yLooYl72rmh2k9jUSzwViJ6msvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=surriel.com; spf=pass smtp.mailfrom=shelob.surriel.com; arc=none smtp.client-ip=96.67.55.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=surriel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shelob.surriel.com
Received: from fangorn.home.surriel.com ([10.0.13.7])
	by shelob.surriel.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.97.1)
	(envelope-from <riel@shelob.surriel.com>)
	id 1tibr7-000000003xx-0bsl;
	Thu, 13 Feb 2025 11:14:25 -0500
From: Rik van Riel <riel@surriel.com>
To: x86@kernel.org
Cc: linux-kernel@vger.kernel.org,
	bp@alien8.de,
	peterz@infradead.org,
	dave.hansen@linux.intel.com,
	zhengqi.arch@bytedance.com,
	nadav.amit@gmail.com,
	thomas.lendacky@amd.com,
	kernel-team@meta.com,
	linux-mm@kvack.org,
	akpm@linux-foundation.org,
	jackmanb@google.com,
	jannh@google.com,
	mhklinux@outlook.com,
	andrew.cooper3@citrix.com,
	Rik van Riel <riel@surriel.com>,
	Dave Hansen <dave.hansen@intel.com>
Subject: [PATCH v11 03/12] x86/mm: consolidate full flush threshold decision
Date: Thu, 13 Feb 2025 11:13:54 -0500
Message-ID: <20250213161423.449435-4-riel@surriel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250213161423.449435-1-riel@surriel.com>
References: <20250213161423.449435-1-riel@surriel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: riel@surriel.com

Reduce code duplication by consolidating the decision point
for whether to do individual invalidations or a full flush
inside get_flush_tlb_info.

Signed-off-by: Rik van Riel <riel@surriel.com>
Suggested-by: Dave Hansen <dave.hansen@intel.com>
Tested-by: Michael Kelley <mhklinux@outlook.com>
---
 arch/x86/mm/tlb.c | 41 +++++++++++++++++++----------------------
 1 file changed, 19 insertions(+), 22 deletions(-)

diff --git a/arch/x86/mm/tlb.c b/arch/x86/mm/tlb.c
index ffc25b348041..924ac2263725 100644
--- a/arch/x86/mm/tlb.c
+++ b/arch/x86/mm/tlb.c
@@ -1009,6 +1009,15 @@ static struct flush_tlb_info *get_flush_tlb_info(struct mm_struct *mm,
 	info->initiating_cpu	= smp_processor_id();
 	info->trim_cpumask	= 0;
 
+	/*
+	 * If the number of flushes is so large that a full flush
+	 * would be faster, do a full flush.
+	 */
+	if ((end - start) >> stride_shift > tlb_single_page_flush_ceiling) {
+		info->start = 0;
+		info->end = TLB_FLUSH_ALL;
+	}
+
 	return info;
 }
 
@@ -1026,17 +1035,8 @@ void flush_tlb_mm_range(struct mm_struct *mm, unsigned long start,
 				bool freed_tables)
 {
 	struct flush_tlb_info *info;
+	int cpu = get_cpu();
 	u64 new_tlb_gen;
-	int cpu;
-
-	cpu = get_cpu();
-
-	/* Should we flush just the requested range? */
-	if ((end == TLB_FLUSH_ALL) ||
-	    ((end - start) >> stride_shift) > tlb_single_page_flush_ceiling) {
-		start = 0;
-		end = TLB_FLUSH_ALL;
-	}
 
 	/* This is also a barrier that synchronizes with switch_mm(). */
 	new_tlb_gen = inc_mm_tlb_gen(mm);
@@ -1089,22 +1089,19 @@ static void do_kernel_range_flush(void *info)
 
 void flush_tlb_kernel_range(unsigned long start, unsigned long end)
 {
-	/* Balance as user space task's flush, a bit conservative */
-	if (end == TLB_FLUSH_ALL ||
-	    (end - start) > tlb_single_page_flush_ceiling << PAGE_SHIFT) {
-		on_each_cpu(do_flush_tlb_all, NULL, 1);
-	} else {
-		struct flush_tlb_info *info;
+	struct flush_tlb_info *info;
 
-		preempt_disable();
-		info = get_flush_tlb_info(NULL, start, end, 0, false,
-					  TLB_GENERATION_INVALID);
+	guard(preempt)();
 
+	info = get_flush_tlb_info(NULL, start, end, PAGE_SHIFT, false,
+				  TLB_GENERATION_INVALID);
+
+	if (info->end == TLB_FLUSH_ALL)
+		on_each_cpu(do_flush_tlb_all, NULL, 1);
+	else
 		on_each_cpu(do_kernel_range_flush, info, 1);
 
-		put_flush_tlb_info();
-		preempt_enable();
-	}
+	put_flush_tlb_info();
 }
 
 /*
-- 
2.47.1


