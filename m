Return-Path: <linux-kernel+bounces-175352-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 359218C1E73
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 08:53:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6623B1C215E0
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 06:53:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C9E715FA85;
	Fri, 10 May 2024 06:52:32 +0000 (UTC)
Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D647F153BE2
	for <linux-kernel@vger.kernel.org>; Fri, 10 May 2024 06:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715323952; cv=none; b=kyRlxer+jpILvRcYp2tN4sVgXZ6Wsc1z0GfbLMmWkFIy1BhGVFlIowHRqokuDK/kgvwicipzz6fAz2ex4gByMV9lwo1wHGjzdnrxMamkCEuT51iovwc9LS/tjaDwaAsVRqZ4abBxvcwSokayc0DbdMl0le0pwoI4iitwdTMGR5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715323952; c=relaxed/simple;
	bh=jv1iOoprSwRFH5w9Z/PANDJyKvnOZy0dQlWzrKJ6O5k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=gUdSQMUOVGf7k4fGmW3gMEO8OSBzkML+hqnYXgS1Pg0B5f+lH+efrxhp0EyHNLYacDuxVyiRJU9VCBJuh3+PnqtrjIwcErT29mEH8TXztMlXTFdYBU2tKJ2OwOvaM04irV4yatfmP4kafDadKLnSaCZFbh+GVB49Dq/Bey7Ov6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-d6dff70000001748-ce-663dc42165ab
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
Subject: [PATCH v10 03/12] riscv, tlb: add APIs manipulating tlb batch's arch data
Date: Fri, 10 May 2024 15:51:57 +0900
Message-Id: <20240510065206.76078-4-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240510065206.76078-1-byungchul@sk.com>
References: <20240510065206.76078-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrGLMWRmVeSWpSXmKPExsXC9ZZnka7iEds0g3MP5SzmrF/DZvF5wz82
	ixcb2hktvq7/xWzx9FMfi8XlXXPYLO6t+c9qcX7XWlaLHUv3MVlcOrCAyeJ47wEmi/n3PrNZ
	bN40ldni+JSpjBa/fwAVn5w1mcVBwON7ax+Lx85Zd9k9Fmwq9di8Qstj8Z6XTB6bVnWyeWz6
	NInd4925c+weJ2b8ZvGYdzLQ4/2+q2weW3/ZeTROvcbm8XmTXABfFJdNSmpOZllqkb5dAlfG
	8nX3GAs+ClQc/beKvYFxGV8XIyeHhICJxJ0bjaww9vzjvxhBbDYBdYkbN34yg9giAmYSB1v/
	sIPYzAJ3mSQO9LOB2MICQRL/bn0Ei7MIqEpc7r4GFucVMJX40/SEHWKmvMTqDQfA5nACzfmw
	bAYTiC0EVNPxYCLQLi6gmvdsEu9n/4BqkJQ4uOIGywRG3gWMDKsYhTLzynITM3NM9DIq8zIr
	9JLzczcxAkN/We2f6B2Mny4EH2IU4GBU4uHdsdkmTYg1say4MvcQowQHs5IIb1WNdZoQb0pi
	ZVVqUX58UWlOavEhRmkOFiVxXqNv5SlCAumJJanZqakFqUUwWSYOTqkGRsbqeR9+rt6wsrS+
	tiZp0caE2BNhIRPnnlY+4OUhJXZ7w0UJq81fhadflTkZIGZm51Nx9Eb8Ro7fM9pXs5eyZKxR
	WNHvKfZZQ0qatfyDmfLZjonFJWdDPLeu00n7t7n5Tcyu2++Tq0OCj/SL3Sn8wWb35uyGROa4
	GbsUDlQffya542OWCVNqoRJLcUaioRZzUXEiAN+vQop5AgAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrLLMWRmVeSWpSXmKPExsXC5WfdrKt4xDbN4OFhIYs569ewWXze8I/N
	4sWGdkaLr+t/MVs8/dTHYnF47klWi8u75rBZ3Fvzn9Xi/K61rBY7lu5jsrh0YAGTxfHeA0wW
	8+99ZrPYvGkqs8XxKVMZLX7/ACo+OWsyi4Ogx/fWPhaPnbPusnss2FTqsXmFlsfiPS+ZPDat
	6mTz2PRpErvHu3Pn2D1OzPjN4jHvZKDH+31X2TwWv/jA5LH1l51H49RrbB6fN8kF8Edx2aSk
	5mSWpRbp2yVwZSxfd4+x4KNAxdF/q9gbGJfxdTFyckgImEjMP/6LEcRmE1CXuHHjJzOILSJg
	JnGw9Q87iM0scJdJ4kA/G4gtLBAk8e/WR7A4i4CqxOXua2BxXgFTiT9NT9ghZspLrN5wAGwO
	J9CcD8tmMIHYQkA1HQ8mMk5g5FrAyLCKUSQzryw3MTPHVK84O6MyL7NCLzk/dxMjMJCX1f6Z
	uIPxy2X3Q4wCHIxKPLw7NtukCbEmlhVX5h5ilOBgVhLhraqxThPiTUmsrEotyo8vKs1JLT7E
	KM3BoiTO6xWemiAkkJ5YkpqdmlqQWgSTZeLglGpgNNC4p2bbwPvpx8oDdYE3Pv7J/r9wzkeF
	5vlcp60juLkDmWYfTPFY//KYhsOnQM0N3x6K3X7t+YfxwIS7CbvVW3Wv6jTu9VmlKLE9tLtk
	350fvw/svB+meUdhW9a/qclF0pI9zNZ6q3XNDhZtzItqOc3g7bxR9XztgenrLN6KTxN2NVp5
	4T7jSyWW4oxEQy3mouJEAMaRpBZgAgAA
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


