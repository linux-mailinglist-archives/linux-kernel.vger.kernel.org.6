Return-Path: <linux-kernel+bounces-196565-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF0D08D5E17
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 11:21:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1DBF11C2496C
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 09:21:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5118312F392;
	Fri, 31 May 2024 09:20:26 +0000 (UTC)
Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB0017BB13
	for <linux-kernel@vger.kernel.org>; Fri, 31 May 2024 09:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717147225; cv=none; b=Vf4VGPPRCndLkDEmLLoY6whHDM77mIcPyEuZD6VYPyl5T4PHqCvNrQJ+NU0M/XfPKhtl03lP3r/vaDPyLo4L28thNJwu60d1VTtDFcXdE+RGGZ1V0VHagLzbAqXeIBZeKP+QRNsWv08NpDSaQ3cJqtuH3xZ9/y1XzYuippTFJe4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717147225; c=relaxed/simple;
	bh=YJAFmZWtLvcH8pFtBPWK54VZrMSw+NmMMId1iaASfD0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=r014dwoJvC1P8KZ2XW/fN+E7h60vkuGdmKyuPQLRcmas2FHrCmGGj+qSQezU8WcUf994wmwLXCq1WIKAZvfo5G6Ogn91P8Nqm4s3MPp68yODsKdfdf+u686K+O0MGzDwxG0gNdGOzG6NjVisOiIfAMA5YT5wU4ZPFlILARwgYcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-d85ff70000001748-4d-6659964bdba7
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
Subject: [PATCH v11 03/12] riscv, tlb: add APIs manipulating tlb batch's arch data
Date: Fri, 31 May 2024 18:19:52 +0900
Message-Id: <20240531092001.30428-4-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240531092001.30428-1-byungchul@sk.com>
References: <20240531092001.30428-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrKLMWRmVeSWpSXmKPExsXC9ZZnka7PtMg0g/fv2CzmrF/DZvF5wz82
	ixcb2hktvq7/xWzx9FMfi8XlXXPYLO6t+c9qcX7XWlaLHUv3MVlcOrCAyeJ47wEmi/n3PrNZ
	bN40ldni+JSpjBa/fwAVn5w1mcVBwON7ax+Lx85Zd9k9Fmwq9di8Qstj8Z6XTB6bVnWyeWz6
	NInd4925c+weJ2b8ZvGYdzLQ4/2+q2weW3/ZeTROvcbm8XmTXABfFJdNSmpOZllqkb5dAlfG
	xn1vmAsmC1Zsff+BsYHxIF8XIyeHhICJxMXG1+ww9rypd8FsNgF1iRs3fjKD2CICZhIHW/+A
	xZkF7jJJHOhn62Lk4BAWCJJ4u04BJMwioCqxbuNyJhCbV8BUYuKZ46wQI+UlVm84ADaGE2jM
	gb93GEFsIaCaRf97gWwuoJrPbBLbV35ig2iQlDi44gbLBEbeBYwMqxiFMvPKchMzc0z0Mirz
	Miv0kvNzNzECA39Z7Z/oHYyfLgQfYhTgYFTi4Q2oiEgTYk0sK67MPcQowcGsJML7Kx0oxJuS
	WFmVWpQfX1Sak1p8iFGag0VJnNfoW3mKkEB6YklqdmpqQWoRTJaJg1OqgVHSue20+pTPDu9a
	f0uZBXKyFt8yuHklfinDHp3F6X12OhO7lP2bNkxqiPwY+E0wopuVs3RBXm7BxX2tV3Yu9eE+
	lWD46FbQjl0iQr9tQpUYHd2dUh51VDfM+W9reqbK8OF3nt+PTgin1MbIJHfdNn8jsMSY68Vr
	ixV81xfrLJkyMSxCuV3qnhJLcUaioRZzUXEiAOq8YAd4AgAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrDLMWRmVeSWpSXmKPExsXC5WfdrOs9LTLNYNIhS4s569ewWXze8I/N
	4sWGdkaLr+t/MVs8/dTHYnF47klWi8u75rBZ3Fvzn9Xi/K61rBY7lu5jsrh0YAGTxfHeA0wW
	8+99ZrPYvGkqs8XxKVMZLX7/ACo+OWsyi4Ogx/fWPhaPnbPusnss2FTqsXmFlsfiPS+ZPDat
	6mTz2PRpErvHu3Pn2D1OzPjN4jHvZKDH+31X2TwWv/jA5LH1l51H49RrbB6fN8kF8Edx2aSk
	5mSWpRbp2yVwZWzc94a5YLJgxdb3HxgbGA/ydTFyckgImEjMm3qXHcRmE1CXuHHjJzOILSJg
	JnGw9Q9YnFngLpPEgX62LkYODmGBIIm36xRAwiwCqhLrNi5nArF5BUwlJp45zgoxUl5i9YYD
	YGM4gcYc+HuHEcQWAqpZ9L+XcQIj1wJGhlWMIpl5ZbmJmTmmesXZGZV5mRV6yfm5mxiBYbys
	9s/EHYxfLrsfYhTgYFTi4Q2oiEgTYk0sK67MPcQowcGsJML7Kx0oxJuSWFmVWpQfX1Sak1p8
	iFGag0VJnNcrPDVBSCA9sSQ1OzW1ILUIJsvEwSnVwHg42PNpzP13QlUnL8yfe4BVVKN3scNv
	tu0GnCuSvDTrjxv9kf59MuV2NMsyI6NdByeV33m+4WrHMf/5vDfeSTO+D7SYdfWx1+3XaufN
	dym+lU/8lmS7j/nU0nCvKpsOmw3ezQwiQvMXH62a1BxZrPZH7ejZpFlrl876UldrnHv70S73
	RfrcLuVKLMUZiYZazEXFiQCTcEXWXwIAAA==
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
index 72e559934952..c0bfb9b2bf54 100644
--- a/arch/riscv/include/asm/tlbflush.h
+++ b/arch/riscv/include/asm/tlbflush.h
@@ -8,6 +8,7 @@
 #define _ASM_RISCV_TLBFLUSH_H
 
 #include <linux/mm_types.h>
+#include <linux/cpumask.h>
 #include <asm/smp.h>
 #include <asm/errata_list.h>
 
@@ -65,6 +66,26 @@ void arch_tlbbatch_add_pending(struct arch_tlbflush_unmap_batch *batch,
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
 extern unsigned long tlb_flush_all_threshold;
 #else /* CONFIG_MMU */
 #define local_flush_tlb_all()			do { } while (0)
-- 
2.17.1


