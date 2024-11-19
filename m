Return-Path: <linux-kernel+bounces-414620-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3661C9D2B04
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 17:34:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 656F8B3085D
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 16:33:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 351651D1F71;
	Tue, 19 Nov 2024 16:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="GKzbyzi9"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D9801D0E10
	for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2024 16:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732033929; cv=none; b=iyjcYV7+O3aS6Y738pa+RmaJ5WpBOciQEhGk5AvWCdAZEw3hARG7MEmXm6qvX9W92wcwjQPw/6mQl568w0TRtp/p+huOhOGDm8yxhLguNxVUYxn12XJSFbWZ7d3e5sLee4bGdRxU8rdVVjch05H/deR627ZIQc98u477qlfl9UY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732033929; c=relaxed/simple;
	bh=Yka98/1DnkN8a40MMGm5+Yi0sw49U0PbphlXtS9eM/8=;
	h=Message-Id:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=tHjvwKX3C6e9jmsgbnNEwRekf3BrdCCWUGZgHH3tfexLjYLu9EyQcjCtQKGbK9k9xNHyTlYnLak7YQdApfe+8TzUGljb+5USchwIRYv5fauNIZ0fz3vJQrxqe1gW/luE5QLRTsfZRLxE7smu8n6xTJgg8eUdpx5NdBOUQyCpg1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=GKzbyzi9; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
	Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To;
	bh=peG4b29NN3VgAAfzJZTqvQ0ALZJTfu1tNGwDQ2J9tYc=; b=GKzbyzi9LbtJ3E/7EQ1m4Ke98i
	q9ZgIy6mKBCPvg9nryo3ZgPraXS7sDSxFbdhQpBX0h9rDWzJfkClnO+hPl8/JiHdztwNHjmdOQIOo
	obL4ziROeUvJF7bdqXwtefgqolHG4gRyaRQn2kD+3NETHZgTz9CJDUmz6cNQgg2hVnf4P9GPGMGWb
	ijV6nq+Pj3I539RjJTPudq3YNi2BA8CtGfVhurEBIREZWXzKKOHHT3gX80jkM7dRRaHV2y6QDaO1L
	CdU6u40aKeeLwnJVUebBTxYxn296AmiVThFOjLvWFgf2XvI09EwKZln+OnE1iJ/FbokEVbOMimpqn
	Qg/CaAag==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tDR91-00000000MTS-1Hx0;
	Tue, 19 Nov 2024 16:32:03 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 0)
	id E677730119B; Tue, 19 Nov 2024 17:32:02 +0100 (CET)
Message-Id: <20241119163035.648739178@infradead.org>
User-Agent: quilt/0.65
Date: Tue, 19 Nov 2024 17:25:31 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: x86@kernel.org, "To:riel"@surriel.com
Cc: linux-kernel@vger.kernel.org,
 peterz@infradead.org
Subject: [PATCH 4/7] x86/mm: Remove mm argument from unuse_temporary_mm() again
References: <20241119162527.952745944@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

Now that unuse_temporary_mm() lives in tlb.c it can access loaded_mm.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/include/asm/mmu_context.h |    2 +-
 arch/x86/kernel/alternative.c      |    2 +-
 arch/x86/mm/tlb.c                  |    8 +++++---
 3 files changed, 7 insertions(+), 5 deletions(-)

--- a/arch/x86/include/asm/mmu_context.h
+++ b/arch/x86/include/asm/mmu_context.h
@@ -268,6 +268,6 @@ typedef struct {
 } temp_mm_state_t;
 
 extern temp_mm_state_t use_temporary_mm(struct mm_struct *mm);
-extern void unuse_temporary_mm(struct mm_struct *mm, temp_mm_state_t prev_state);
+extern void unuse_temporary_mm(temp_mm_state_t prev_state);
 
 #endif /* _ASM_X86_MMU_CONTEXT_H */
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -1874,7 +1874,7 @@ static void *__text_poke(text_poke_f fun
 	 * instruction that already allows the core to see the updated version.
 	 * Xen-PV is assumed to serialize execution in a similar manner.
 	 */
-	unuse_temporary_mm(poking_mm, prev);
+	unuse_temporary_mm(prev);
 
 	/*
 	 * Flushing the TLB might involve IPIs, which would require enabled
--- a/arch/x86/mm/tlb.c
+++ b/arch/x86/mm/tlb.c
@@ -720,13 +720,15 @@ temp_mm_state_t use_temporary_mm(struct
 	return temp_state;
 }
 
-void unuse_temporary_mm(struct mm_struct *mm, temp_mm_state_t prev_state)
+void unuse_temporary_mm(temp_mm_state_t prev_state)
 {
 	lockdep_assert_irqs_disabled();
-	switch_mm_irqs_off(NULL, prev_state.mm, current);
 
 	/* Clear the cpumask, to indicate no TLB flushing is needed anywhere */
-	cpumask_clear_cpu(raw_smp_processor_id(), mm_cpumask(mm));
+	cpumask_clear_cpu(smp_processor_id(),
+			  mm_cpumask(this_cpu_read(cpu_tlbstate.loaded_mm)));
+
+	switch_mm_irqs_off(NULL, prev_state.mm, current);
 
 	/*
 	 * Restore the breakpoints if they were disabled before the temporary mm



