Return-Path: <linux-kernel+bounces-533716-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DE8BCA45E12
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 13:02:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BBA0F3AAFEC
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 12:01:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 103CD219A93;
	Wed, 26 Feb 2025 12:01:49 +0000 (UTC)
Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6007619259A
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 12:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740571308; cv=none; b=QTGQYHQF3TYEwcsOZMR0eS0zMR+GdjWYrTAc5aSEXperV/2JgeSTmKg/ogRlzZiz95OInnXagxMm3nny9LKdSptN/wBaixi18qLH+V7N0gsoR/CJlpLJKd1bpSr4Xne6NrZRb+D2J30Ba+SlrTUhCMRLDaA6W1qo4WrGt/gI4M0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740571308; c=relaxed/simple;
	bh=eqanYBzOnIhYHHJZpP3RWErKeNhi48iVN+PV/yYa9vA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=p66DqkY/6Fv9viE79JM+a+b74rhBhzhL0LlBMHfMUy6CtZnFnysv3uPajb9FzhirYFltnjmjzY+a5Gw/yZQcW8TPoI9FGJioC2rE4xWP0r55+n1zDwkmhiIh0it4P+DSTbZQeNYk0Fxkf5meaP/xQZeIpbUPj6EJHpxU3HSOAX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-3e1ff7000001d7ae-d1-67bf02a6bbce
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
Subject: [RFC PATCH v12 based on mm-unstable as of Feb 21, 2025 03/25]  riscv/tlb: add APIs manipulating tlb batch's arch data
Date: Wed, 26 Feb 2025 21:01:10 +0900
Message-Id: <20250226120132.28469-3-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250226120132.28469-1-byungchul@sk.com>
References: <20250226113342.GB1935@system.software.com>
 <20250226120132.28469-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrCLMWRmVeSWpSXmKPExsXC9ZZnke4ypv3pBr8uSFrMWb+GzeLzhn9s
	Fl/X/2K2ePqpj8Xi8q45bBb31vxntTi/ay2rxY6l+5gsLh1YwGRxvPcAk8X8e5/ZLDZvmsps
	cXzKVEaL3z/msDnweXxv7WPx2DnrLrvHgk2lHptXaHlsWtXJ5rHp0yR2j3fnzrF7nJjxm8Xj
	/b6rbB5bf9l5NE69xubxeZNcAE8Ul01Kak5mWWqRvl0CV8bO1RMYC64JVSzduoipgfEVfxcj
	J4eEgInEv3cvGWHsZ3ves4PYbALqEjdu/GQGsUUEzCQOtv4BinNxMAssY5LYe6KBDSQhLFAn
	sXvjY1YQm0VAVeLN6c1gcV4BU4n+U49ZIIbKS6zecABsECfQoH+7f4MtEBJIlmhZ/5sFZKiE
	wG02iaY/i6EaJCUOrrjBMoGRdwEjwypGocy8stzEzBwTvYzKvMwKveT83E2MwLBeVvsnegfj
	pwvBhxgFOBiVeHgfnNmbLsSaWFZcmXuIUYKDWUmElzNzT7oQb0piZVVqUX58UWlOavEhRmkO
	FiVxXqNv5SlCAumJJanZqakFqUUwWSYOTqkGRt22/ftbTKxcGS9PbhBdtaKhPNREYsaG/8yn
	XTVPcZQ9DuluKovnUF6utEK9K8y+a8NuxbebP2Zqmx8WWDJd49aZ/3cfOrPKWbVUiB1c/T7D
	0IS9MfhW3+oM/5CLLz+19m6JzeGtEtD6uML36+8fLgc/PZ6obie+2O7uhAcXdtmGPHIt8rhy
	WomlOCPRUIu5qDgRAFq0F5lnAgAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrNLMWRmVeSWpSXmKPExsXC5WfdrLuMaX+6wbMDfBZz1q9hs/i84R+b
	xdf1v5gtnn7qY7E4PPckq8XlXXPYLO6t+c9qcX7XWlaLHUv3MVlcOrCAyeJ47wEmi/n3PrNZ
	bN40ldni+JSpjBa/f8xhc+D3+N7ax+Kxc9Zddo8Fm0o9Nq/Q8ti0qpPNY9OnSewe786dY/c4
	MeM3i8f7fVfZPBa/+MDksfWXnUfj1GtsHp83yQXwRnHZpKTmZJalFunbJXBl7Fw9gbHgmlDF
	0q2LmBoYX/F3MXJySAiYSDzb854dxGYTUJe4ceMnM4gtImAmcbD1D1Cci4NZYBmTxN4TDWwg
	CWGBOondGx+zgtgsAqoSb05vBovzCphK9J96zAIxVF5i9YYDYIM4gQb92/0bbIGQQLJEy/rf
	LBMYuRYwMqxiFMnMK8tNzMwx1SvOzqjMy6zQS87P3cQIDNJltX8m7mD8ctn9EKMAB6MSD++D
	M3vThVgTy4orcw8xSnAwK4nwcmbuSRfiTUmsrEotyo8vKs1JLT7EKM3BoiTO6xWemiAkkJ5Y
	kpqdmlqQWgSTZeLglGpgZDaarrH8x1nXjrBzh1j523t3bN2yYur6m4t62OVecSxhFUxuudg5
	j7X3dqFD20HfrIofHKxv0+eE8evw+zN+kDj7jUFQXW7GwSWmIl86Vyb0xAd2/mQRM1zzbruN
	tvrhOv1/hf5TDDw0k3dv28WlKKwTNaHcJCJslqPtRv/QjZlVp9U2XSlXYinOSDTUYi4qTgQA
	k/WaE04CAAA=
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
index ce0dd0fed7646..cecd8e7e2a3bd 100644
--- a/arch/riscv/include/asm/tlbflush.h
+++ b/arch/riscv/include/asm/tlbflush.h
@@ -8,6 +8,7 @@
 #define _ASM_RISCV_TLBFLUSH_H
 
 #include <linux/mm_types.h>
+#include <linux/cpumask.h>
 #include <asm/smp.h>
 #include <asm/errata_list.h>
 
@@ -64,6 +65,33 @@ void arch_tlbbatch_add_pending(struct arch_tlbflush_unmap_batch *batch,
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


