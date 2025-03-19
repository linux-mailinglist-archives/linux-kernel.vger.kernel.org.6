Return-Path: <linux-kernel+bounces-568509-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A4B3A69690
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 18:32:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 78FFD3BEDDD
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 17:31:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E356A1EE029;
	Wed, 19 Mar 2025 17:31:57 +0000 (UTC)
Received: from shelob.surriel.com (shelob.surriel.com [96.67.55.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F34DC1BD9E6
	for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 17:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=96.67.55.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742405517; cv=none; b=WDQf0ilRRGQZPZ6ZfpdUOhMGe9W+Kf22bj5uRLeT+Rhmsn0I5Qz3wTDFV5H0XcgM9WYN3scexBgi82to5k/g2oVo+8hW5EtSzJyFOJR1QaBqF5oXBlUWx2JABja88F5fmHRuyQylof7+P1zyNBrFMVesRIRoom8RTXgkSx3pyP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742405517; c=relaxed/simple;
	bh=0GR4unQdxRr9111k2d6AhxcyY4LL3oqEiRsFmekZv8w=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=dgGWYgBeoSe+9uEG8J+bIwZmGYhW1Mq6SiJb4eFNFxGT3b7SYejEGHL+6pyvtgp9RRub4mpvuUUB7CC7UYuL7RCfpHZmwDuFEVqeASSXc5Pwvan/ULGQemt71kAIAiRcidPt5zg0u4YaGxwVyMiFoiHspISw0XmB4xXzMOgZErY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=surriel.com; spf=pass smtp.mailfrom=shelob.surriel.com; arc=none smtp.client-ip=96.67.55.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=surriel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shelob.surriel.com
Received: from [2601:18c:8180:83cc:5a47:caff:fe78:8708] (helo=fangorn)
	by shelob.surriel.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.97.1)
	(envelope-from <riel@shelob.surriel.com>)
	id 1tuxAP-000000007z4-0Yrz;
	Wed, 19 Mar 2025 13:25:21 -0400
Date: Wed, 19 Mar 2025 13:25:20 -0400
From: Rik van Riel <riel@surriel.com>
To: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Borislav Petkov <bp@alien8.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org, kernel-team@meta.com, Vinay
 Banakar <vny@google.com>, Brendan Jackman <jackmanb@google.com>
Subject: [PATCH] x86/mm: only do broadcast flush from reclaim if pages were
 unmapped
Message-ID: <20250319132520.6b10ad90@fangorn>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: riel@surriel.com

Track whether pages were unmapped from any mm (even ones with a currently empty
mm_cpumask) by the reclaim code, to figure out whether or not broadcast TLB
flush should be done when reclaim finishes.

The reason any mm must be tracked, and not only ones contributing to the
tlbbatch cpumask, is that broadcast ASIDs are expected to be kept up to
date even on CPUs where the mm is not currently active.

This change allows reclaim to avoid doing TLB flushes when only clean page
cache pages and/or slab memory were reclaimed, which is fairly common.

Signed-off-by: Rik van Riel <riel@surriel.com>
---
This is a simpler alternative to the code that was in my invlpgb series before,
and it seems to capture most of the benefit due to how common it is to reclaim
only page cache.

 arch/x86/include/asm/tlbbatch.h | 5 +++++
 arch/x86/include/asm/tlbflush.h | 1 +
 arch/x86/mm/tlb.c               | 3 ++-
 3 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/tlbbatch.h b/arch/x86/include/asm/tlbbatch.h
index 1ad56eb3e8a8..d24f893de4b7 100644
--- a/arch/x86/include/asm/tlbbatch.h
+++ b/arch/x86/include/asm/tlbbatch.h
@@ -10,6 +10,11 @@ struct arch_tlbflush_unmap_batch {
 	 * the PFNs being flushed..
 	 */
 	struct cpumask cpumask;
+	/*
+	 * Set if pages were unmapped from any mm, even one that does not
+	 * have active CPUs in its cpumask.
+	 */
+	bool unmapped_pages;
 };
 
 #endif /* _ARCH_X86_TLBBATCH_H */
diff --git a/arch/x86/include/asm/tlbflush.h b/arch/x86/include/asm/tlbflush.h
index 7cad283d502d..a9af8759de34 100644
--- a/arch/x86/include/asm/tlbflush.h
+++ b/arch/x86/include/asm/tlbflush.h
@@ -353,6 +353,7 @@ static inline void arch_tlbbatch_add_pending(struct arch_tlbflush_unmap_batch *b
 {
 	inc_mm_tlb_gen(mm);
 	cpumask_or(&batch->cpumask, &batch->cpumask, mm_cpumask(mm));
+	batch->unmapped_pages = true;
 	mmu_notifier_arch_invalidate_secondary_tlbs(mm, 0, -1UL);
 }
 
diff --git a/arch/x86/mm/tlb.c b/arch/x86/mm/tlb.c
index 3e2c6e2f5134..e459d97ef397 100644
--- a/arch/x86/mm/tlb.c
+++ b/arch/x86/mm/tlb.c
@@ -1632,8 +1632,9 @@ void arch_tlbbatch_flush(struct arch_tlbflush_unmap_batch *batch)
 	 * a local TLB flush is needed. Optimize this use-case by calling
 	 * flush_tlb_func_local() directly in this case.
 	 */
-	if (cpu_feature_enabled(X86_FEATURE_INVLPGB)) {
+	if (cpu_feature_enabled(X86_FEATURE_INVLPGB) && batch->unmapped_pages) {
 		invlpgb_flush_all_nonglobals();
+		batch->unmapped_pages = false;
 	} else if (cpumask_any_but(&batch->cpumask, cpu) < nr_cpu_ids) {
 		flush_tlb_multi(&batch->cpumask, info);
 	} else if (cpumask_test_cpu(cpu, &batch->cpumask)) {
-- 
2.48.1


