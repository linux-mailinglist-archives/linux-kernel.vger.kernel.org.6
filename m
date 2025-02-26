Return-Path: <linux-kernel+bounces-533740-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DB4C1A45E2B
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 13:07:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 67175189C1CF
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 12:06:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F7C821B1AC;
	Wed, 26 Feb 2025 12:03:50 +0000 (UTC)
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 971AD217F36
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 12:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740571429; cv=none; b=n5rP52bFyPQWr6x8Po+N3fpTfyoe/FaplFfFloZD5CcdoVxET3zGvBJ4MCtFP42yDmxdlB9E2BEvumw4qlap8HQKvRoSrFXT6rXbEmDm9NijsngamuHGX2OElCHLhfzji778vyV9JyElBuCsexExVHUVZCAf5oet2Pe/TToUJiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740571429; c=relaxed/simple;
	bh=0BBSYQnODNFil1DqFNuJDdSbdVSvanO3ceYzebX3EEU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=Mts8HjyqVD354Qi3DqO8HfSbi9EMOSlnG+iE35BR/0SoJ49NXHmC8SSPo5flVuHggkcz6dpkc7W6qXQdnkStxPxH18/vR9pH2U3s74h+q8G4sYVmjUNeJ2+OYGdkmUEHdbsfZxSbjRTt+MBTLaj8ctSa/Uqv8momuLhLqIA9XoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-3e1ff7000001d7ae-f6-67bf03226ffd
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
Subject: [RFC PATCH v12 based on v6.14-rc4 01/25] x86/tlb: add APIs manipulating tlb batch's arch data
Date: Wed, 26 Feb 2025 21:03:12 +0900
Message-Id: <20250226120336.29565-1-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250226113024.GA1935@system.software.com>
References: <20250226113024.GA1935@system.software.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrMLMWRmVeSWpSXmKPExsXC9ZZnoa4S8/50gy2LxS3mrF/DZvF5wz82
	i6/rfzFbPP3Ux2JxedccNot7a/6zWpzftZbVYsfSfUwWlw4sYLI43nuAyWL+vc9sFps3TWW2
	OD5lKqPF7x9z2Bz4PL639rF47Jx1l91jwaZSj80rtDw2repk89j0aRK7x7tz59g9Tsz4zeLx
	ft9VNo+tv+w8GqdeY/P4vEkugCeKyyYlNSezLLVI3y6BK6P3wxO2gidCFUun8DUwfufvYuTk
	kBAwkVh6+Ds7jP33218wm01AXeLGjZ/MILaIgJnEwdY/QHEuDmaBZUwSe080sIEkhAXSJPa2
	HgazWQRUJZ5fvM0IYvMKmEocblrPBDFUXmL1hgNggzgFLCSmTdnGAmILCZhL/Pm1jwlkqITA
	fTaJu297GCEaJCUOrrjBMoGRdwEjwypGocy8stzEzBwTvYzKvMwKveT83E2MwKBeVvsnegfj
	pwvBhxgFOBiVeHgfnNmbLsSaWFZcmXuIUYKDWUmElzNzT7oQb0piZVVqUX58UWlOavEhRmkO
	FiVxXqNv5SlCAumJJanZqakFqUUwWSYOTqkGRtmrSaGVnJtKb742aGc825wkM8FCfIf925cL
	it83PGs3jztpsED/a5Fl8IbFCrMXWp5+apDw4fSEW3k6PVFT7AXzWVTMHXmsL4hJ3i+P/5Mu
	psF1vp5p624f66Dw3QLzBf5LfJ+4QbneTmnNJsVFh2sLTlg3hvhy2qXd2fb/4DJ2D26vAs5j
	SizFGYmGWsxFxYkA1yTHI2YCAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrFLMWRmVeSWpSXmKPExsXC5WfdrKvEvD/dYPN0Hos569ewWXze8I/N
	4uv6X8wWTz/1sVgcnnuS1eLyrjlsFvfW/Ge1OL9rLavFjqX7mCwuHVjAZHG89wCTxfx7n9ks
	Nm+aymxxfMpURovfP+awOfB7fG/tY/HYOesuu8eCTaUem1doeWxa1cnmsenTJHaPd+fOsXuc
	mPGbxeP9vqtsHotffGDy2PrLzqNx6jU2j8+b5AJ4o7hsUlJzMstSi/TtErgyej88YSt4IlSx
	dApfA+N3/i5GTg4JAROJv9/+soPYbALqEjdu/GQGsUUEzCQOtv4BinNxMAssY5LYe6KBDSQh
	LJAmsbf1MJjNIqAq8fzibUYQm1fAVOJw03omiKHyEqs3HAAbxClgITFtyjYWEFtIwFziz699
	TBMYuRYwMqxiFMnMK8tNzMwx1SvOzqjMy6zQS87P3cQIDNFltX8m7mD8ctn9EKMAB6MSD++D
	M3vThVgTy4orcw8xSnAwK4nwcmbuSRfiTUmsrEotyo8vKs1JLT7EKM3BoiTO6xWemiAkkJ5Y
	kpqdmlqQWgSTZeLglGpg3Hc1sXj3rrN9zTy/fJkZrDsf6uy/IM/K4+AWFHgo0m7e3IXmKk78
	7devnHynG1MkufbI++cr+SVmbZ0n+dG+u/3Exq1HnfQvv99csZd3l8EMXbWIPD9Pz1C5d1ev
	ZMw/sy560kX9TK5bq5c2/bw/6/TmwyuL9woeevgsSPLzx8CT3ZWLFlZYSCmxFGckGmoxFxUn
	AgAUVfMcTQIAAA==
X-CFilter-Loop: Reflected
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

A new mechanism, LUF(Lazy Unmap Flush), defers tlb flush until folios
that have been unmapped and freed, eventually get allocated again.  It's
safe for folios that had been mapped read-only and were unmapped, since
the contents of the folios wouldn't change while staying in pcp or buddy
so we can still read the data through the stale tlb entries.

This is a preparation for the mechanism that needs to recognize
read-only tlb entries by separating tlb batch arch data into two, one is
for read-only entries and the other is for writable ones, and merging
those two when needed.

It also optimizes tlb shootdown by skipping CPUs that have already
performed tlb flush needed since.  To support it, added APIs
manipulating arch data for x86.

Signed-off-by: Byungchul Park <byungchul@sk.com>
---
 arch/x86/include/asm/tlbflush.h | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/arch/x86/include/asm/tlbflush.h b/arch/x86/include/asm/tlbflush.h
index 02fc2aa06e9e0..c27e61bd274a5 100644
--- a/arch/x86/include/asm/tlbflush.h
+++ b/arch/x86/include/asm/tlbflush.h
@@ -5,6 +5,7 @@
 #include <linux/mm_types.h>
 #include <linux/mmu_notifier.h>
 #include <linux/sched.h>
+#include <linux/cpumask.h>
 
 #include <asm/processor.h>
 #include <asm/cpufeature.h>
@@ -294,6 +295,29 @@ static inline void arch_flush_tlb_batched_pending(struct mm_struct *mm)
 
 extern void arch_tlbbatch_flush(struct arch_tlbflush_unmap_batch *batch);
 
+static inline void arch_tlbbatch_clear(struct arch_tlbflush_unmap_batch *batch)
+{
+	cpumask_clear(&batch->cpumask);
+}
+
+static inline void arch_tlbbatch_fold(struct arch_tlbflush_unmap_batch *bdst,
+		struct arch_tlbflush_unmap_batch *bsrc)
+{
+	cpumask_or(&bdst->cpumask, &bdst->cpumask, &bsrc->cpumask);
+}
+
+static inline bool arch_tlbbatch_need_fold(struct arch_tlbflush_unmap_batch *batch,
+		struct mm_struct *mm)
+{
+	return !cpumask_subset(mm_cpumask(mm), &batch->cpumask);
+}
+
+static inline bool arch_tlbbatch_done(struct arch_tlbflush_unmap_batch *bdst,
+		struct arch_tlbflush_unmap_batch *bsrc)
+{
+	return !cpumask_andnot(&bdst->cpumask, &bdst->cpumask, &bsrc->cpumask);
+}
+
 static inline bool pte_flags_need_flush(unsigned long oldflags,
 					unsigned long newflags,
 					bool ignore_access)

base-commit: d082ecbc71e9e0bf49883ee4afd435a77a5101b6
-- 
2.17.1


