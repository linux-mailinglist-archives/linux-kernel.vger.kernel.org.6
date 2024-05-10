Return-Path: <linux-kernel+bounces-175351-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A4A38C1E72
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 08:53:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9AADD1F2252E
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 06:53:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 434B115F302;
	Fri, 10 May 2024 06:52:31 +0000 (UTC)
Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEA85155354
	for <linux-kernel@vger.kernel.org>; Fri, 10 May 2024 06:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715323950; cv=none; b=jTHwSZWdKsLZFU8CZHCwVn/iuGMD3aVSg+S4hBSuv1dgL4eDmYsoHxSOT/o0RpkRrDkUioTkDrC7jamQo7cNzStBGCrcS0ZhWzpVQhQTfsI5kwxEU5XpCroy73iXnGk1OS0suF99kMzSMyg5MeSV9oDbbL65+Q9Vbe8iKZUXGYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715323950; c=relaxed/simple;
	bh=O/HKlBeE1Ln5d0Jibamkt6l0z7BEfyyJZYoMpvhJjIo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=pChzzjHydnC6u1aIutLZogkPoloGG+vFmLpV0EQNCcn71QOSgGCtkrT+PbR+CRJFz+0Tex4SKjqgHH3Qj9XZcsB/d3YyQPXoBsJkovbdVX/jdt2SWotM26/UmMutLiQE0F/sO/J9aoCwxYVK1XZcHAUHtKB8yIzOpfWE3D4/c+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-d6dff70000001748-d3-663dc4210637
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
Subject: [PATCH v10 04/12] x86/tlb, riscv/tlb, mm/rmap: separate arch_tlbbatch_clear() out of arch_tlbbatch_flush()
Date: Fri, 10 May 2024 15:51:58 +0900
Message-Id: <20240510065206.76078-5-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240510065206.76078-1-byungchul@sk.com>
References: <20240510065206.76078-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrGLMWRmVeSWpSXmKPExsXC9ZZnka7iEds0gzXnFCzmrF/DZvF5wz82
	ixcb2hktvq7/xWzx9FMfi8XlXXPYLO6t+c9qcX7XWlaLHUv3MVlcOrCAyeJ47wEmi/n3PrNZ
	bN40ldni+JSpjBa/fwAVn5w1mcVBwON7ax+Lx85Zd9k9Fmwq9di8Qstj8Z6XTB6bVnWyeWz6
	NInd4925c+weJ2b8ZvGYdzLQ4/2+q2weW3/ZeTROvcbm8XmTXABfFJdNSmpOZllqkb5dAlfG
	o18T2Avu81WsmbiHtYFxKk8XIyeHhICJxOvGt2ww9q+Wp6wgNpuAusSNGz+ZQWwRATOJg61/
	2EFsZoG7TBIH+sHqhQWKJdZsPQBmswioSlzq7GYCsXkFTCWWNz1ghJgpL7F6wwGwOZxAcz4s
	mwFWIwRU0/FgIlANF1DNezaJnvPX2SEaJCUOrrjBMoGRdwEjwypGocy8stzEzBwTvYzKvMwK
	veT83E2MwNBfVvsnegfjpwvBhxgFOBiVeHh3bLZJE2JNLCuuzD3EKMHBrCTCW1VjnSbEm5JY
	WZValB9fVJqTWnyIUZqDRUmc1+hbeYqQQHpiSWp2ampBahFMlomDU6qB0fvfUYM0u7jVeiuX
	Vz9Ise7smlok11CxukSPyUt5XnOvldRbdU6rHa7F137uiFg+zV/U+qVv4xYRgzzVdzF6DpcV
	Q70mnvrQum7Xo0Bu6Tal/6rVP8+23RE5bmbn9zbo1f32n7166oyrvqdn7Frow7LQ3o55qvtn
	L76Nflxrv+XscJ2zZ1eaEktxRqKhFnNRcSIAet1+x3kCAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrLLMWRmVeSWpSXmKPExsXC5WfdrKt4xDbN4Ol7EYs569ewWXze8I/N
	4sWGdkaLr+t/MVs8/dTHYnF47klWi8u75rBZ3Fvzn9Xi/K61rBY7lu5jsrh0YAGTxfHeA0wW
	8+99ZrPYvGkqs8XxKVMZLX7/ACo+OWsyi4Ogx/fWPhaPnbPusnss2FTqsXmFlsfiPS+ZPDat
	6mTz2PRpErvHu3Pn2D1OzPjN4jHvZKDH+31X2TwWv/jA5LH1l51H49RrbB6fN8kF8Edx2aSk
	5mSWpRbp2yVwZTz6NYG94D5fxZqJe1gbGKfydDFyckgImEj8annKCmKzCahL3LjxkxnEFhEw
	kzjY+ocdxGYWuMskcaCfDcQWFiiWWLP1AJjNIqAqcamzmwnE5hUwlVje9IARYqa8xOoNB8Dm
	cALN+bBsBliNEFBNx4OJjBMYuRYwMqxiFMnMK8tNzMwx1SvOzqjMy6zQS87P3cQIDORltX8m
	7mD8ctn9EKMAB6MSD++OzTZpQqyJZcWVuYcYJTiYlUR4q2qs04R4UxIrq1KL8uOLSnNSiw8x
	SnOwKInzeoWnJggJpCeWpGanphakFsFkmTg4pRoYrUq/Se5wY/gcFDRDdW5RKZf8FrlQtXUc
	yZofHI8zzp5mLR3hvE/2nMmeLsUfOzT8H//51+skt/g0pzv/sWOKgkvfFzd8kd7p2/znnGfP
	NSPrXdzOJdd1wn8ZzS56sJP/hfbjlauebfN8+OWCX/I3gabz88/KTw+7ua9VgrGhvieqP3Ne
	1UlXJZbijERDLeai4kQAZoPofWACAAA=
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

This is a preparation for the mechanism that requires to avoid redundant
tlb flush by manipulating tlb batch's arch data.  To achieve that, we
need to separate the part clearing the tlb batch's arch data out of
arch_tlbbatch_flush().

Signed-off-by: Byungchul Park <byungchul@sk.com>
---
 arch/riscv/mm/tlbflush.c | 1 -
 arch/x86/mm/tlb.c        | 2 --
 mm/rmap.c                | 1 +
 3 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/riscv/mm/tlbflush.c b/arch/riscv/mm/tlbflush.c
index 07d743f87b3f..9cbd27148357 100644
--- a/arch/riscv/mm/tlbflush.c
+++ b/arch/riscv/mm/tlbflush.c
@@ -234,5 +234,4 @@ void arch_tlbbatch_flush(struct arch_tlbflush_unmap_batch *batch)
 {
 	__flush_tlb_range(&batch->cpumask, FLUSH_TLB_NO_ASID, 0,
 			  FLUSH_TLB_MAX_SIZE, PAGE_SIZE);
-	cpumask_clear(&batch->cpumask);
 }
diff --git a/arch/x86/mm/tlb.c b/arch/x86/mm/tlb.c
index 44ac64f3a047..24bce69222cd 100644
--- a/arch/x86/mm/tlb.c
+++ b/arch/x86/mm/tlb.c
@@ -1265,8 +1265,6 @@ void arch_tlbbatch_flush(struct arch_tlbflush_unmap_batch *batch)
 		local_irq_enable();
 	}
 
-	cpumask_clear(&batch->cpumask);
-
 	put_flush_tlb_info();
 	put_cpu();
 }
diff --git a/mm/rmap.c b/mm/rmap.c
index 2608c40dffad..cf8a99a49aef 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -649,6 +649,7 @@ void try_to_unmap_flush(void)
 		return;
 
 	arch_tlbbatch_flush(&tlb_ubc->arch);
+	arch_tlbbatch_clear(&tlb_ubc->arch);
 	tlb_ubc->flush_required = false;
 	tlb_ubc->writable = false;
 }
-- 
2.17.1


