Return-Path: <linux-kernel+bounces-183341-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20F138C97D2
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 04:18:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 04E6F1C2142D
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 02:18:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA729DF58;
	Mon, 20 May 2024 02:17:57 +0000 (UTC)
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E7D8C136
	for <linux-kernel@vger.kernel.org>; Mon, 20 May 2024 02:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716171477; cv=none; b=nS6m2mp/VG2oadtCujpr6MhYovLx8ZO8G/JrjqPqSSdAYExjV85A+udVbn0VtxVVjADhBVuDSIOut6AE8Ia9O9jBpjDCzRVc9E2lpCP7pGpbNlKwfCU608lF225iANPwXO5y9rYyJ+3KrgiotI1TvvtXaUs/5mfLBEVPloFXTDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716171477; c=relaxed/simple;
	bh=jv1iOoprSwRFH5w9Z/PANDJyKvnOZy0dQlWzrKJ6O5k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=lS89TmNHhaGjzjuRwDCbAFdo8qTIAKwUUhw8/0Chs8HAwwJxS/RdTBibv8575zR+gkdmQetPACP7U8180HvfCNt9fxnGd3MPpSc24xWjUGCvFAm9OK53Q69xgNqQXDG6TUQ0M9nBnz3ns0W2kkqxtwO8YktuT+k6KcFJijBMqHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-d6dff70000001748-a4-664ab2c82afd
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
Subject: [RESEND PATCH v10 03/12] riscv, tlb: add APIs manipulating tlb batch's arch data
Date: Mon, 20 May 2024 11:17:25 +0900
Message-Id: <20240520021734.21527-4-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240520021734.21527-1-byungchul@sk.com>
References: <20240520021734.21527-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrGLMWRmVeSWpSXmKPExsXC9ZZnke6JTV5pBgd22ljMWb+GzeLzhn9s
	Fi82tDNafF3/i9ni6ac+FovLu+awWdxb85/V4vyutawWO5buY7K4dGABk8Xx3gNMFvPvfWaz
	2LxpKrPF8SlTGS1+/wAqPjlrMouDgMf31j4Wj52z7rJ7LNhU6rF5hZbH4j0vmTw2repk89j0
	aRK7x7tz59g9Tsz4zeIx72Sgx/t9V9k8tv6y82iceo3N4/MmuQC+KC6blNSczLLUIn27BK6M
	5evuMRZ8FKg4+m8VewPjMr4uRk4OCQETiecXfrLC2IebzrGB2GwC6hI3bvxkBrFFBMwkDrb+
	YQexmQXuMkkc6AerERaIlLhyuR8sziKgKnHhwVQWEJtXwFTi7Kt3jBAz5SVWbzgANocTaM6M
	VTvBaoSAan4c/Qo0hwuo5j2bxIv2qywQDZISB1fcYJnAyLuAkWEVo1BmXlluYmaOiV5GZV5m
	hV5yfu4mRmDoL6v9E72D8dOF4EOMAhyMSjy8Ox55pgmxJpYVV+YeYpTgYFYS4d20BSjEm5JY
	WZValB9fVJqTWnyIUZqDRUmc1+hbeYqQQHpiSWp2ampBahFMlomDU6qB0dzQNv9bhHdLzLGn
	0/LP3mnRbP8lfS/+++J/jhOnzTBYxym/38m7yez3xq+W0h4cbZ/5pjHeNr95asVZF1fGaZdc
	Eo/lCi9v04rnkXhfyLR5juETx8ZtB5rufFllIKhxP+8S2xWX97U/l6i+3zPpnHWrrYjX4Sc9
	/3msuu7dlv3/YpfCvVvaMUosxRmJhlrMRcWJAGJSZnd5AgAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrLLMWRmVeSWpSXmKPExsXC5WfdrHtik1eawcNvhhZz1q9hs/i84R+b
	xYsN7YwWX9f/YrZ4+qmPxeLw3JOsFpd3zWGzuLfmP6vF+V1rWS12LN3HZHHpwAImi+O9B5gs
	5t/7zGaxedNUZovjU6YyWvz+AVR8ctZkFgdBj++tfSweO2fdZfdYsKnUY/MKLY/Fe14yeWxa
	1cnmsenTJHaPd+fOsXucmPGbxWPeyUCP9/uusnksfvGByWPrLzuPxqnX2Dw+b5IL4I/isklJ
	zcksSy3St0vgyli+7h5jwUeBiqP/VrE3MC7j62Lk5JAQMJE43HSODcRmE1CXuHHjJzOILSJg
	JnGw9Q87iM0scJdJ4kA/WI2wQKTElcv9YHEWAVWJCw+msoDYvAKmEmdfvWOEmCkvsXrDAbA5
	nEBzZqzaCVYjBFTz4+hXtgmMXAsYGVYximTmleUmZuaY6hVnZ1TmZVboJefnbmIEBvKy2j8T
	dzB+uex+iFGAg1GJh3fDbc80IdbEsuLK3EOMEhzMSiK8m7YAhXhTEiurUovy44tKc1KLDzFK
	c7AoifN6hacmCAmkJ5akZqemFqQWwWSZODilGhh5QlaWJ0SXfXt1V6+JVTbxymsnGeed0R3c
	90163954nhTNI2XXrRy37k2vkQX/2QKnbXv9TvC0aRed+98m7Cf74tHUG1Uz3BYFParzzBUT
	Dlva1iExLeWCVBTrqwAp6yeBdyZubV12X9O4bv7ML5PeRysadp/WW7eql0c0TTc/8+RViwM7
	PiuxFGckGmoxFxUnAgCiDQqAYAIAAA==
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
 arch/riscv/include/asm/tlbflush.h | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/arch/riscv/include/asm/tlbflush.h b/arch/riscv/include/asm/tlbflush.h
index 4112cc8d1d69..480c082ccde3 100644
--- a/arch/riscv/include/asm/tlbflush.h
+++ b/arch/riscv/include/asm/tlbflush.h
@@ -8,6 +8,7 @@
 #define _ASM_RISCV_TLBFLUSH_H
 
 #include <linux/mm_types.h>
+#include <linux/cpumask.h>
 #include <asm/smp.h>
 #include <asm/errata_list.h>
 
@@ -55,6 +56,26 @@ void arch_tlbbatch_add_pending(struct arch_tlbflush_unmap_batch *batch,
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
+static inline bool arch_tlbbatch_done(struct arch_tlbflush_unmap_batch *bdst,
+		struct arch_tlbflush_unmap_batch *bsrc)
+{
+	return !cpumask_andnot(&bdst->cpumask, &bdst->cpumask, &bsrc->cpumask);
+
+}
+
 #else /* CONFIG_SMP && CONFIG_MMU */
 
 #define flush_tlb_all() local_flush_tlb_all()
-- 
2.17.1


