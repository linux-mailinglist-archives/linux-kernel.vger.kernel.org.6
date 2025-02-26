Return-Path: <linux-kernel+bounces-533739-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BB1AA45E29
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 13:06:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 877D11793AC
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 12:06:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B4D421B1A0;
	Wed, 26 Feb 2025 12:03:50 +0000 (UTC)
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 940BA21772D
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 12:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740571429; cv=none; b=FWkgqdTCt1ZZpCfSSoJFoaN4YOovUpwn/AxI0/Cw0stuYtKwGH6ErbpX4/b3v0Aj6UIxhRUPBbXWEHs+gFQR/ccbfN+CRKZI+0uisFUbUMLnTlHRpOSM8d01ajqPFp+0Z2BH28sbibBBplAPYKXMlqW/YziiaWoZoDkG+ns9Oi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740571429; c=relaxed/simple;
	bh=RG+nIHafzsu6KH0sZ7fNOwFi7KXBGFLymx/SA4HIhmw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=MuVTUZMsCCzX2+YDJZ1LjLJFfu+pPrfzV4zGbQZ8AczHiwBYuyG29TumHtptKrRB0r5GWy8jD07DUThRxcihye9bCGM64bIb2T0mwxhC2qW6GazpJh3fu6ldt54ZI23divANaBnKeWrRRQzjRyZ4DW7OeIb7W/BqtWpkP9QFj/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-3e1ff7000001d7ae-00-67bf0322bf9e
From: Byungchul Park <byungchul@sk.com>
To: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Cc: kernel_team@skhynix.com,
	akpm@linux-foundation.org,
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
	rjgolo@gmail.com
Subject: [RFC PATCH v12 based on v6.14-rc4 03/25] riscv/tlb: add APIs manipulating tlb batch's arch data
Date: Wed, 26 Feb 2025 21:03:14 +0900
Message-Id: <20250226120336.29565-3-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250226120336.29565-1-byungchul@sk.com>
References: <20250226113024.GA1935@system.software.com>
 <20250226120336.29565-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrMLMWRmVeSWpSXmKPExsXC9ZZnka4S8/50g46pkhZz1q9hs/i84R+b
	xdf1v5gtnn7qY7G4vGsOm8W9Nf9ZLc7vWstqsWPpPiaLSwcWMFkc7z3AZDH/3mc2i82bpjJb
	HJ8yldHi9485bA58Ht9b+1g8ds66y+6xYFOpx+YVWh6bVnWyeWz6NInd4925c+weJ2b8ZvF4
	v+8qm8fWX3YejVOvsXl83iQXwBPFZZOSmpNZllqkb5fAlbFj7V2WgmtCFU8e/2NqYHzF38XI
	ySEhYCIxYdMHNhh78YnTYDabgLrEjRs/mUFsEQEziYOtf9i7GLk4mAWWMUnsPdEAViQskCHR
	f2I/O4jNIqAqMbF1L2sXIwcHr4CpxPcN5hAz5SVWbzgANocTaM6nacfAWoUEkiV2/v7DBDJT
	QuA+m8TzvvesEA2SEgdX3GCZwMi7gJFhFaNQZl5ZbmJmjoleRmVeZoVecn7uJkZgUC+r/RO9
	g/HTheBDjAIcjEo8vA/O7E0XYk0sK67MPcQowcGsJMLLmbknXYg3JbGyKrUoP76oNCe1+BCj
	NAeLkjiv0bfyFCGB9MSS1OzU1ILUIpgsEwenVANj/Hzjbvdwn806nk28n7711UZUe6T+yX6x
	1U3zvFFDU/UMPt9os5JAy4g/JeULc3/L/FJdcfjPBRPh97u+bF150p9D7dhxhTO2eoyZ6w57
	zLeUyHV+LrRj8kGrg8u282yt8PSdId+u5Cs0fV+u4UfG1zlir16omG/9+d/WmDW4XO5krN+D
	z1JKLMUZiYZazEXFiQCHrFxAZgIAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrFLMWRmVeSWpSXmKPExsXC5WfdrKvEvD/d4M4KAYs569ewWXze8I/N
	4uv6X8wWTz/1sVgcnnuS1eLyrjlsFvfW/Ge1OL9rLavFjqX7mCwuHVjAZHG89wCTxfx7n9ks
	Nm+aymxxfMpURovfP+awOfB7fG/tY/HYOesuu8eCTaUem1doeWxa1cnmsenTJHaPd+fOsXuc
	mPGbxeP9vqtsHotffGDy2PrLzqNx6jU2j8+b5AJ4o7hsUlJzMstSi/TtErgydqy9y1JwTaji
	yeN/TA2Mr/i7GDk5JARMJBafOM0GYrMJqEvcuPGTGcQWETCTONj6h72LkYuDWWAZk8TeEw1g
	RcICGRL9J/azg9gsAqoSE1v3snYxcnDwCphKfN9gDjFTXmL1hgNgcziB5nyadgysVUggWWLn
	7z9MExi5FjAyrGIUycwry03MzDHVK87OqMzLrNBLzs/dxAgM0WW1fybuYPxy2f0QowAHoxIP
	74Mze9OFWBPLiitzDzFKcDArifByZu5JF+JNSaysSi3Kjy8qzUktPsQozcGiJM7rFZ6aICSQ
	nliSmp2aWpBaBJNl4uCUamC8b7pDp87Q/FDLVWEh/bvTGf4f+7Buus8uhoOLSqabT5zR8Ell
	TuDG8pSY6LMFwbziKy99neTONN9DR3t69BOxd3Zsz+yk1t2R5eS167+5xPCdXavwoX2fPDme
	WK3Y95iheek0j/7c2L9GW7qfzii4V8gsF/KX805rTmbHIs+qIrYIyR/HVxgpsRRnJBpqMRcV
	JwIAI6pn4k0CAAA=
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


