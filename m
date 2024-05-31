Return-Path: <linux-kernel+bounces-196564-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C4A148D5E16
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 11:20:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A7C91F273B1
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 09:20:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 263B18286D;
	Fri, 31 May 2024 09:20:25 +0000 (UTC)
Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22DAC7C6EB
	for <linux-kernel@vger.kernel.org>; Fri, 31 May 2024 09:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717147224; cv=none; b=ckgN9msi75wG+sRmuFxylyD9y1j4p1T1JlA3Jl/cMT9NZq9+Vbq4Djvt7G9dZuZxRAlio5s8nTbUhqVELxCuWJL7OBgTi9pv34+/Ku0DFyRytTYWYsIq5yCnjMQDlBxQEEcrRjJ219D2tTkV8PXwT5vOULFZCYnywjjiB7ww6V4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717147224; c=relaxed/simple;
	bh=6cD35mEyKwclK8bRNTmdyMxP37PfjcwjlbBbEy4ouTo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=G6WllNORW06lMz8q5gDOev/yHjGJ0Rxv2YoGMQQQZhP2455aHuG/EOpbl/1KK7w37io7kVssS2oASoqm7jNzIrdfpcB02DTGKPZUyNJ2X9lsHo/542gNHY5O2hp0E6uukDaubGKB+VQ3hVQDWh1wCCSHzu5K3n7vVMLf+EDbySg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-d85ff70000001748-43-6659964b11d6
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
Subject: [PATCH v11 01/12] x86/tlb: add APIs manipulating tlb batch's arch data
Date: Fri, 31 May 2024 18:19:50 +0900
Message-Id: <20240531092001.30428-2-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240531092001.30428-1-byungchul@sk.com>
References: <20240531092001.30428-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrCLMWRmVeSWpSXmKPExsXC9ZZnka7PtMg0g+3bGC3mrF/DZvF5wz82
	ixcb2hktvq7/xWzx9FMfi8XlXXPYLO6t+c9qcX7XWlaLHUv3MVlcOrCAyeJ47wEmi/n3PrNZ
	bN40ldni+JSpjBa/fwAVn5w1mcVBwON7ax+Lx85Zd9k9Fmwq9di8Qstj8Z6XTB6bVnWyeWz6
	NInd4925c+weJ2b8ZvGYdzLQ4/2+q2weW3/ZeTROvcbm8XmTXABfFJdNSmpOZllqkb5dAlfG
	yf4NTAVvBCrOPJ3H3sA4h6+LkZNDQsBEYvWz+8ww9oRPDWA2m4C6xI0bP8FsEQEziYOtf9hB
	bGaBu0wSB/rZuhg5OIQF/CX+7rMGMVkEVCUu76oHqeAVMJVo/vuVDWKivMTqDQfApnACTTnw
	9w4jiC0EVLPofy+QzQVU855NYl3/DagGSYmDK26wTGDkXcDIsIpRKDOvLDcxM8dEL6MyL7NC
	Lzk/dxMjMOyX1f6J3sH46ULwIUYBDkYlHt6Aiog0IdbEsuLK3EOMEhzMSiK8v9KBQrwpiZVV
	qUX58UWlOanFhxilOViUxHmNvpWnCAmkJ5akZqemFqQWwWSZODilGhi1nhddOdE/89khh6lu
	F7/bL9I+ZbTRzuWBU9PijsntB26wnX6yTsyt7ZXu7MzS/d8jc+4x7DGRUGfa3GcQNGf5OhvD
	JYJrFb+LLbDRPOO69YjQhx2n7sbIHv+y4kr8F7/Qb8omyxSm9ti+MOBQ8nj++lXg7wz5pX4T
	yrtO3/r4brPIfo/DUtNvK7EUZyQaajEXFScCADKmY6d3AgAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrNLMWRmVeSWpSXmKPExsXC5WfdrOs9LTLNYOZZY4s569ewWXze8I/N
	4sWGdkaLr+t/MVs8/dTHYnF47klWi8u75rBZ3Fvzn9Xi/K61rBY7lu5jsrh0YAGTxfHeA0wW
	8+99ZrPYvGkqs8XxKVMZLX7/ACo+OWsyi4Ogx/fWPhaPnbPusnss2FTqsXmFlsfiPS+ZPDat
	6mTz2PRpErvHu3Pn2D1OzPjN4jHvZKDH+31X2TwWv/jA5LH1l51H49RrbB6fN8kF8Edx2aSk
	5mSWpRbp2yVwZZzs38BU8Eag4szTeewNjHP4uhg5OSQETCQmfGpgBrHZBNQlbtz4CWaLCJhJ
	HGz9ww5iMwvcZZI40M/WxcjBISzgL/F3nzWIySKgKnF5Vz1IBa+AqUTz369sEBPlJVZvOAA2
	hRNoyoG/dxhBbCGgmkX/exknMHItYGRYxSiSmVeWm5iZY6pXnJ1RmZdZoZecn7uJERjEy2r/
	TNzB+OWy+yFGAQ5GJR7egIqINCHWxLLiytxDjBIczEoivL/SgUK8KYmVValF+fFFpTmpxYcY
	pTlYlMR5vcJTE4QE0hNLUrNTUwtSi2CyTBycUg2MmxuYsyT7ap1nPP+7V7Xyzpl9Sf/tTm84
	v3r/p6Kfc2bMvhWe+8R51ctnF+M3eDnkqbouWPFyqmZS+7/fmfUqdbsWbU1U+Jeiq8vKXKAw
	IzBshs0+p38RIZMm3J8mWm7eGfi2Q2W6lFnO9LBQbdaoiae/6EhrbmlXP74y6UlsyCSBlUWX
	yo8dUWIpzkg01GIuKk4EALuE7ydeAgAA
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
 arch/x86/include/asm/tlbflush.h | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/arch/x86/include/asm/tlbflush.h b/arch/x86/include/asm/tlbflush.h
index 25726893c6f4..a14f77c5cdde 100644
--- a/arch/x86/include/asm/tlbflush.h
+++ b/arch/x86/include/asm/tlbflush.h
@@ -5,6 +5,7 @@
 #include <linux/mm_types.h>
 #include <linux/mmu_notifier.h>
 #include <linux/sched.h>
+#include <linux/cpumask.h>
 
 #include <asm/processor.h>
 #include <asm/cpufeature.h>
@@ -293,6 +294,23 @@ static inline void arch_flush_tlb_batched_pending(struct mm_struct *mm)
 
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


