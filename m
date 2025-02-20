Return-Path: <linux-kernel+bounces-522980-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 91D97A3D0D5
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 06:35:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 88C2A189D930
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 05:36:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 817491E04AE;
	Thu, 20 Feb 2025 05:35:53 +0000 (UTC)
Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DAF51A9B4E
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 05:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740029753; cv=none; b=CobzEq+D0qvQ3jBKLuMbDzpKkOVW3DWu7UieYfe0xt201AdsW8IPaMglZU8HovTtHp4sKwOsLAoSnpK3G8lXR78H+twcZLAbXJE+3JMvYXRmQwwa1RpWm9vOh4iVW6JqESuI1LToU/Mcv34Qmax8blTce+npjmjF/Ubz89lIvMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740029753; c=relaxed/simple;
	bh=Uv8nmFZOuubSU+ZBEWrLcFBd4mHzwTof9syrfb7FABA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=dp2vvMrOXjzhmTbTuzLvwrPUaWdltjPUVuwVyMc5s5kRHlWj43nuh6NTlkrF6enAIxjWKMbUZl4C7A+gnwDjnhbtIvStdMe7K7Q+1cqOURfKKANddv+wb9f+Yaw3D0Sx4uKzohLgVjBwkJeD8TYniuVxhme6VbLa1IK7I8HtGSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-3c9ff7000001d7ae-b0-67b6bba6f406
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
Subject: [RFC PATCH v12 01/26] x86/tlb: add APIs manipulating tlb batch's arch data
Date: Thu, 20 Feb 2025 14:20:02 +0900
Message-Id: <20250220052027.58847-2-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250220052027.58847-1-byungchul@sk.com>
References: <20250220052027.58847-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrGLMWRmVeSWpSXmKPExsXC9ZZnoe6y3dvSDZ6fFbSYs34Nm8XnDf/Y
	LF5saGe0+Lr+F7PF0099LBaXd81hs7i35j+rxflda1ktdizdx2Rx6cACJovjvQeYLObf+8xm
	sXnTVGaL41OmMlr8/gFUfHLWZBYHAY/vrX0sHjtn3WX3WLCp1GPzCi2PxXteMnlsWtXJ5rHp
	0yR2j3fnzrF7nJjxm8Vj3slAj/f7rrJ5bP1l59E49Rqbx+dNcgF8UVw2Kak5mWWpRfp2CVwZ
	85edZCpYLVTxYeVs1gbGw/xdjJwcEgImEu97FjDD2DO/TWAHsdkE1CVu3PgJFhcRMJM42PoH
	LM4scJdJ4kA/G4gtLBAsMenaXbA4i4CqxKfj58HqeQVMJdZd/wk1U15i9YYDYDYn0JwfM3rB
	eoWAat4tuMTUxcgFVPOeTeL6ud1sEA2SEgdX3GCZwMi7gJFhFaNQZl5ZbmJmjoleRmVeZoVe
	cn7uJkZg6C+r/RO9g/HTheBDjAIcjEo8vDNat6ULsSaWFVfmHmKU4GBWEuFtq9+SLsSbklhZ
	lVqUH19UmpNafIhRmoNFSZzX6Ft5ipBAemJJanZqakFqEUyWiYNTqoExoOvliaW8hz33Pz6v
	zD9x0r+mSVLV2nx/f349Ndd0tbjFZKNN7r9Pii2qjF4dev9q7IzC9n5OcXtVBS+vqf5tvvLe
	aY9/SF+vzzosk/Gk433kss8pfGG+hwuapeS01vLXSRu5+/ou/uFwcfI/JS7p7q+zeGQEXz8p
	DpCZULx3Neu9HzMKqrqVWIozEg21mIuKEwEGxIPeeQIAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrLLMWRmVeSWpSXmKPExsXC5WfdrLts97Z0g1dn2C3mrF/DZvF5wz82
	ixcb2hktvq7/xWzx9FMfi8XhuSdZLS7vmsNmcW/Nf1aL87vWslrsWLqPyeLSgQVMFsd7DzBZ
	zL/3mc1i86apzBbHp0xltPj9A6j45KzJLA6CHt9b+1g8ds66y+6xYFOpx+YVWh6L97xk8ti0
	qpPNY9OnSewe786dY/c4MeM3i8e8k4Ee7/ddZfNY/OIDk8fWX3YejVOvsXl83iQXwB/FZZOS
	mpNZllqkb5fAlTF/2UmmgtVCFR9WzmZtYDzM38XIySEhYCIx89sEdhCbTUBd4saNn8wgtoiA
	mcTB1j9gcWaBu0wSB/rZQGxhgWCJSdfugsVZBFQlPh0/D1bPK2Aqse46RK+EgLzE6g0HwGxO
	oDk/ZvSC9QoB1bxbcIlpAiPXAkaGVYwimXlluYmZOaZ6xdkZlXmZFXrJ+bmbGIGBvKz2z8Qd
	jF8uux9iFOBgVOLhffB4a7oQa2JZcWXuIUYJDmYlEd62+i3pQrwpiZVVqUX58UWlOanFhxil
	OViUxHm9wlMThATSE0tSs1NTC1KLYLJMHJxSDYyLDJd0m/osX1s1z2FRbiejiZPpyu//m6Qf
	b+s8WVDScbZqitCFH5t0O/bFyD5p/Z7PPHXx7NKgdqX1vdkXlfoCnLOV1ha4F6Z3Cz3Mvrq2
	y+HEtc5DT2x/HtB5VTm3JC7j9X7nW9uXsn/YKxb55rmm75PMQyrCYlxSAsfc7+v2sKl0p5sv
	ilRiKc5INNRiLipOBAAe/tirYAIAAA==
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
index 69e79fff41b80..0ae9564c7301e 100644
--- a/arch/x86/include/asm/tlbflush.h
+++ b/arch/x86/include/asm/tlbflush.h
@@ -5,6 +5,7 @@
 #include <linux/mm_types.h>
 #include <linux/mmu_notifier.h>
 #include <linux/sched.h>
+#include <linux/cpumask.h>
 
 #include <asm/processor.h>
 #include <asm/cpufeature.h>
@@ -293,6 +294,29 @@ static inline void arch_flush_tlb_batched_pending(struct mm_struct *mm)
 
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
-- 
2.17.1


