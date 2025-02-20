Return-Path: <linux-kernel+bounces-522986-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 45E54A3D0DB
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 06:36:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 86C57189DF62
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 05:36:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73C2B1E7C2B;
	Thu, 20 Feb 2025 05:36:06 +0000 (UTC)
Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDD231DF975
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 05:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740029764; cv=none; b=R1LoTehyqw0ENLAi+qzxD7CfquQjRyy8Z60s7tXMiEe9Y0fOUY3qgsotGQR4C3DBS+HQi2vRPsgWx7EGA83rtfR71tnWkQ2dIWHIZqIb928pLevV2vSsn3g/mlTnv+93QNZCzPtHceJaP35BcEMY/VH58A2T+JeNjMoQ29TCq9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740029764; c=relaxed/simple;
	bh=RG+nIHafzsu6KH0sZ7fNOwFi7KXBGFLymx/SA4HIhmw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=BS2BA/5TJcvR17b5EmoXguDV5A22gdou45GONrZ2apMiWzoc+5G8eDGjJp1LsXTxmKwW6r4WZFosfgRPjz6dYAvbZpyqQsfk/t9mbToeb/QdS925tJUOHI4Aoj8swLnMqgKECnXlsxCzKJ0MunKEPuREFobJmdI/kE/a8py4XaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-3c9ff7000001d7ae-ba-67b6bba6ff58
From: Byungchul Park <byungchul@sk.com>
To: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Cc: kernel_team@skhynix.com,
	akpm@linux-foundation.org,
	ying.huang@intel.com,
	vernhao@tencent.com,
	mgorman@techsingularity.net,
	hughd@google.com,
	willy@infradead.org,
	david@redhat.com,
	peterz@infradead.org,
	luto@kernel.org,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	rjgolo@gmail.com
Subject: [RFC PATCH v12 03/26] riscv/tlb: add APIs manipulating tlb batch's arch data
Date: Thu, 20 Feb 2025 14:20:04 +0900
Message-Id: <20250220052027.58847-4-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250220052027.58847-1-byungchul@sk.com>
References: <20250220052027.58847-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrGLMWRmVeSWpSXmKPExsXC9ZZnke6y3dvSDRZ2ilnMWb+GzeLzhn9s
	Fi82tDNafF3/i9ni6ac+FovLu+awWdxb85/V4vyutawWO5buY7K4dGABk8Xx3gNMFvPvfWaz
	2LxpKrPF8SlTGS1+/wAqPjlrMouDgMf31j4Wj52z7rJ7LNhU6rF5hZbH4j0vmTw2repk89j0
	aRK7x7tz59g9Tsz4zeIx72Sgx/t9V9k8tv6y82iceo3N4/MmuQC+KC6blNSczLLUIn27BK6M
	HWvvshRcE6p48vgfUwPjK/4uRk4OCQETiW9rm9lh7GWH7rKC2GwC6hI3bvxkBrFFBMwkDrb+
	AathFrjLJHGgnw3EFhYIlbh44jFYDYuAqsSulvdgNq+AqcTZXxNZIWbKS6zecAAszgk058eM
	XrBeIaCadwsuMXUxcgHVvGeTmP95PxtEg6TEwRU3WCYw8i5gZFjFKJSZV5abmJljopdRmZdZ
	oZecn7uJERj6y2r/RO9g/HQh+BCjAAejEg/vjNZt6UKsiWXFlbmHGCU4mJVEeNvqt6QL8aYk
	VlalFuXHF5XmpBYfYpTmYFES5zX6Vp4iJJCeWJKanZpakFoEk2Xi4JRqYJQ1XSmtdOvglDaX
	t5zPrGM6rSYosl3bwZXhXXrfZ2rwM8v9+vxcN3QvzYha+YXpdU2K1LWfmtPv892V5GdRT977
	NDpv072Oib/zd9Vkdf93zHxue3/3dskbV+5UPZ1n/S/Ta89mkc08FzleRXW7rtK7uGE7Ewf/
	phWRHBuW6DVFnW+wKK0t/a/EUpyRaKjFXFScCAAdaBcNeQIAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrLLMWRmVeSWpSXmKPExsXC5WfdrLts97Z0g+3HeSzmrF/DZvF5wz82
	ixcb2hktvq7/xWzx9FMfi8XhuSdZLS7vmsNmcW/Nf1aL87vWslrsWLqPyeLSgQVMFsd7DzBZ
	zL/3mc1i86apzBbHp0xltPj9A6j45KzJLA6CHt9b+1g8ds66y+6xYFOpx+YVWh6L97xk8ti0
	qpPNY9OnSewe786dY/c4MeM3i8e8k4Ee7/ddZfNY/OIDk8fWX3YejVOvsXl83iQXwB/FZZOS
	mpNZllqkb5fAlbFj7V2WgmtCFU8e/2NqYHzF38XIySEhYCKx7NBdVhCbTUBd4saNn8wgtoiA
	mcTB1j/sIDazwF0miQP9bCC2sECoxMUTj8FqWARUJXa1vAezeQVMJc7+msgKMVNeYvWGA2Bx
	TqA5P2b0gvUKAdW8W3CJaQIj1wJGhlWMIpl5ZbmJmTmmesXZGZV5mRV6yfm5mxiBgbys9s/E
	HYxfLrsfYhTgYFTi4X3weGu6EGtiWXFl7iFGCQ5mJRHetvot6UK8KYmVValF+fFFpTmpxYcY
	pTlYlMR5vcJTE4QE0hNLUrNTUwtSi2CyTBycUg2Mmf8unnOzMWgPtpv7YNm9NR7ndtyzjxBm
	c8/cdf0O+6fgDUe0CtYuZuboz4h4eTNl9azm2iSGtbU8d+6+azryIF5NqXPh7kMBmdk9jyN6
	3Q+on9C1iov6canheVYog9OKibGBF3+xdcZyzheWfpq1ovml+qLM23wnX+7kTuUqb9z9W3XJ
	toptSizFGYmGWsxFxYkAIR/GaGACAAA=
X-CFilter-Loop: Reflected
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

A new mechanism, LUF(Lazy Unmap Flush), defers tlb flush until folios
that have been unmapped and freed, eventually get allocated again.  It's
safe for folios that had been mapped read only and were unmapped, since
the contents of the folios don't change while staying in pcp or buddy
so we can still read the data through the stale tlb entries.

This is a preparation for the mechanism that needs to recognize
read-only tlb entries by separating tlb batch arch data into two, one is
for read-only entries and the other is for writable ones, and merging
those two when needed.

It also optimizes tlb shootdown by skipping CPUs that have already
performed tlb flush needed since.  To support it, added APIs
manipulating arch data for riscv.

Signed-off-by: Byungchul Park <byungchul@sk.com>
---
 arch/riscv/include/asm/tlbflush.h | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/arch/riscv/include/asm/tlbflush.h b/arch/riscv/include/asm/tlbflush.h
index 72e5599349529..1dc7d30273d59 100644
--- a/arch/riscv/include/asm/tlbflush.h
+++ b/arch/riscv/include/asm/tlbflush.h
@@ -8,6 +8,7 @@
 #define _ASM_RISCV_TLBFLUSH_H
 
 #include <linux/mm_types.h>
+#include <linux/cpumask.h>
 #include <asm/smp.h>
 #include <asm/errata_list.h>
 
@@ -65,6 +66,33 @@ void arch_tlbbatch_add_pending(struct arch_tlbflush_unmap_batch *batch,
 void arch_flush_tlb_batched_pending(struct mm_struct *mm);
 void arch_tlbbatch_flush(struct arch_tlbflush_unmap_batch *batch);
 
+static inline void arch_tlbbatch_clear(struct arch_tlbflush_unmap_batch *batch)
+{
+	cpumask_clear(&batch->cpumask);
+
+}
+
+static inline void arch_tlbbatch_fold(struct arch_tlbflush_unmap_batch *bdst,
+		struct arch_tlbflush_unmap_batch *bsrc)
+{
+	cpumask_or(&bdst->cpumask, &bdst->cpumask, &bsrc->cpumask);
+
+}
+
+static inline bool arch_tlbbatch_need_fold(struct arch_tlbflush_unmap_batch *batch,
+		struct mm_struct *mm)
+{
+	return !cpumask_subset(mm_cpumask(mm), &batch->cpumask);
+
+}
+
+static inline bool arch_tlbbatch_done(struct arch_tlbflush_unmap_batch *bdst,
+		struct arch_tlbflush_unmap_batch *bsrc)
+{
+	return !cpumask_andnot(&bdst->cpumask, &bdst->cpumask, &bsrc->cpumask);
+
+}
+
 extern unsigned long tlb_flush_all_threshold;
 #else /* CONFIG_MMU */
 #define local_flush_tlb_all()			do { } while (0)
-- 
2.17.1


