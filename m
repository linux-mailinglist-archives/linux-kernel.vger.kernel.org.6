Return-Path: <linux-kernel+bounces-524979-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6001EA3E96D
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 01:55:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A580E3B328D
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 00:54:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B604878F5E;
	Fri, 21 Feb 2025 00:54:14 +0000 (UTC)
Received: from shelob.surriel.com (shelob.surriel.com [96.67.55.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D88792BB04
	for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 00:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=96.67.55.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740099254; cv=none; b=N7eZTYNqtTDpZmZMNMxniG48v1A2wfvspLuzmdS7LyENY6FpohwTaW+gT5e5FJ7oUynWB9/hpl3kfR8DvmhbBMKOcC8kvCaAQvhaQuyKkp0z6/LkIYshmCIkrO1+k2YfRNd8rWzyIHQEWHUNIHfaa2vONggaYuKXfo4AQ5AJTUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740099254; c=relaxed/simple;
	bh=mE7rUQ+5LK/IsjTrC99jexKW4L6ce1g963rB8ogany8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=icUmhHzH2rehgf4mJNicyZrv3F25JneKaLRpD1X7+GkLmq22RXpGAOV3B3/ocY0Rsv1I+M7BIIi6NNRwAiVG1xLBGhMBN3Y89SViTpYcz9d5uub3hbN0Az1DhNwvXaMUa2pIimPk1vi6t6XGKKlw6O++bp4NyyOMMPPElq4VltY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=surriel.com; spf=pass smtp.mailfrom=shelob.surriel.com; arc=none smtp.client-ip=96.67.55.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=surriel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shelob.surriel.com
Received: from fangorn.home.surriel.com ([10.0.13.7])
	by shelob.surriel.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.97.1)
	(envelope-from <riel@shelob.surriel.com>)
	id 1tlHIZ-000000003Qf-1ILt;
	Thu, 20 Feb 2025 19:53:47 -0500
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
	Manali.Shukla@amd.com,
	Rik van Riel <riel@surriel.com>
Subject: [PATCH v12 08/16] x86/mm: use broadcast TLB flushing for page reclaim TLB flushing
Date: Thu, 20 Feb 2025 19:53:07 -0500
Message-ID: <20250221005345.2156760-9-riel@surriel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250221005345.2156760-1-riel@surriel.com>
References: <20250221005345.2156760-1-riel@surriel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: riel@surriel.com

In the page reclaim code, we only track the CPU(s) where the TLB needs
to be flushed, rather than all the individual mappings that may be getting
invalidated.

Use broadcast TLB flushing when that is available.

This is a temporary hack to ensure that the PCID context for
tasks in the next patch gets properly flushed from the page
reclaim code, because the IPI based flushing in arch_tlbbatch_flush
only flushes the currently loaded TLB context on each CPU.

Patch 10 replaces this with the actual mechanism used to do
broadcast TLB flushing from the page reclaim code.

Signed-off-by: Rik van Riel <riel@surriel.com>
Tested-by: Manali Shukla <Manali.Shukla@amd.com>
Tested-by: Brendan Jackman <jackmanb@google.com>
Tested-by: Michael Kelley <mhklinux@outlook.com>
---
 arch/x86/mm/tlb.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/x86/mm/tlb.c b/arch/x86/mm/tlb.c
index 2d7ed0fda61f..16839651f67f 100644
--- a/arch/x86/mm/tlb.c
+++ b/arch/x86/mm/tlb.c
@@ -1326,7 +1326,9 @@ void arch_tlbbatch_flush(struct arch_tlbflush_unmap_batch *batch)
 	 * a local TLB flush is needed. Optimize this use-case by calling
 	 * flush_tlb_func_local() directly in this case.
 	 */
-	if (cpumask_any_but(&batch->cpumask, cpu) < nr_cpu_ids) {
+	if (cpu_feature_enabled(X86_FEATURE_INVLPGB)) {
+		invlpgb_flush_all_nonglobals();
+	} else if (cpumask_any_but(&batch->cpumask, cpu) < nr_cpu_ids) {
 		flush_tlb_multi(&batch->cpumask, info);
 	} else if (cpumask_test_cpu(cpu, &batch->cpumask)) {
 		lockdep_assert_irqs_enabled();
-- 
2.47.1


