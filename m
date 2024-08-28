Return-Path: <linux-kernel+bounces-304209-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76911961BD9
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 04:09:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D91F0B21A04
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 02:09:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EE7941A8F;
	Wed, 28 Aug 2024 02:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Xrs5srBi"
Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com [95.215.58.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98F4D45945
	for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 02:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724810946; cv=none; b=g8pVATQ/n9V8mZSRJ+r6ARx8R0SfS+gUv6Ukc1zu1G7vOVMGAgknstDipyZf1c7K1ttpjlqv7uU5B+qX4WhjDwNhHnocZ/oDliD3mmA10dbs/nOr2pToRqtMm55891N/ukA+G42drrduwY99JTy8FqLhUOYBqsw1XZY+up6pNTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724810946; c=relaxed/simple;
	bh=sUp+zVk3RdAiyV897/ahnmxld48BwN+AwbNzru8HVr8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UJFuSOvFKTcfx0FNIwDGZ4hK2XdSL0nTef3YbwB18Js9VRGDGMHOt/oW+9NK2ule8fCS7slZ8dKHOkxHuI4jw77xwynCTWJrvdoass+7zPJyAHl6B6Gg+hvHg/Gp3KGp5+BTkyEOOlcs2PblZKPgeyolsW/f5BFxADB6/dIlIS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Xrs5srBi; arc=none smtp.client-ip=95.215.58.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1724810940;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=CnEoiZhFWRxD12IldvUuHbRSFbA2zADViizcYTgWYrQ=;
	b=Xrs5srBiHt15m5ou0RQ7KvfLQQdcX0Ay93Ae3RbEFBc1K9hHzmKKOCjjb50UhCf3vUg+GC
	zdh4dV/Br9IfmyNnI8esCj7Hxc6c5Mpm+cEjDg/0l0/f7NMc67bQgJB6mNXYBVLXT4XAn7
	vzN8vKV0eiApTGX+6f0W0Hnf1ntwIlE=
From: Yuntao Wang <yuntao.wang@linux.dev>
To: linux-kernel@vger.kernel.org,
	x86@kernel.org
Cc: Dave Hansen <dave.hansen@linux.intel.com>,
	Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Nadav Amit <nadav.amit@gmail.com>,
	Yuntao Wang <yuntao.wang@linux.dev>
Subject: [PATCH] x86/mm/tlb: Correct the comments in flush_tlb_mm_range() and arch_tlbbatch_flush()
Date: Wed, 28 Aug 2024 10:07:41 +0800
Message-ID: <20240828020741.99869-1-yuntao.wang@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Commit 4c1ba3923e6c ("x86/mm/tlb: Unify flush_tlb_func_local() and
flush_tlb_func_remote()") unified flush_tlb_func_local() and
flush_tlb_func_remote() into flush_tlb_func(). However, in commit
4ce94eabac16 ("x86/mm/tlb: Flush remote and local TLBs concurrently"),
the newly introduced comments still refer to flush_tlb_func_local() when
they should use flush_tlb_func().

Correct these comments.

Signed-off-by: Yuntao Wang <yuntao.wang@linux.dev>
---
 arch/x86/mm/tlb.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/mm/tlb.c b/arch/x86/mm/tlb.c
index 44ac64f3a047..8b874ec90536 100644
--- a/arch/x86/mm/tlb.c
+++ b/arch/x86/mm/tlb.c
@@ -1021,7 +1021,7 @@ void flush_tlb_mm_range(struct mm_struct *mm, unsigned long start,
 	/*
 	 * flush_tlb_multi() is not optimized for the common case in which only
 	 * a local TLB flush is needed. Optimize this use-case by calling
-	 * flush_tlb_func_local() directly in this case.
+	 * flush_tlb_func() directly in this case.
 	 */
 	if (cpumask_any_but(mm_cpumask(mm), cpu) < nr_cpu_ids) {
 		flush_tlb_multi(mm_cpumask(mm), info);
@@ -1254,7 +1254,7 @@ void arch_tlbbatch_flush(struct arch_tlbflush_unmap_batch *batch)
 	/*
 	 * flush_tlb_multi() is not optimized for the common case in which only
 	 * a local TLB flush is needed. Optimize this use-case by calling
-	 * flush_tlb_func_local() directly in this case.
+	 * flush_tlb_func() directly in this case.
 	 */
 	if (cpumask_any_but(&batch->cpumask, cpu) < nr_cpu_ids) {
 		flush_tlb_multi(&batch->cpumask, info);
-- 
2.46.0


