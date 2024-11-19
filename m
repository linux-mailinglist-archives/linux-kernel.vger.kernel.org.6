Return-Path: <linux-kernel+bounces-414614-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 588EE9D2B1A
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 17:38:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5E633B2EA89
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 16:32:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1A071D0F6B;
	Tue, 19 Nov 2024 16:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="L9nncVOG"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC6821D04A9
	for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2024 16:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732033927; cv=none; b=n+3C69Eb+9HMdzdFS9pQar1wIroZ/bgF5leIyWIzpjT3E/bT8bW2DxRXPzl0KYKZqCElDLJVswW6NIHtt+YXECwYVvId7meQ/n8KbJauI/S45gQdPPw8Msnsu6L14NzCWpxFyLmsTk+dVYpRLfk9eMnCaSpECZPjNePC/w0M+UQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732033927; c=relaxed/simple;
	bh=aaLJwwXEQB5gZe/QJah9bx2V1s2F0e/ZLvGyqbZdTWY=;
	h=Message-Id:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=RgJc/ItEyoR5r2/FwDdT/BE8+h4PWmGOn5f6ayF70q1x4GdpErwnylX+i+H1EcHmWebSqCVR19gHSf43koTkbrTD9638iNpEMDTDxze3h/0QKJeKBZaiX7akFeHJ05ivZB0vgUatmfJotGzmrTrJWEu+sKIT5H50LNnKAmSEYOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=L9nncVOG; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
	Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To;
	bh=iKHnr1Xsc+ED8W7SLp96C55Yt4mBqADdvf/siSHY3aM=; b=L9nncVOGYnDFMkaGvhplOHhiAb
	kXzkBlKj3Hvg+sdwoqqWV7CrXEdRf2a6AUJyH/rqypjd5TCUdQ4QqgfqqKGemesQ0bFMgyhz9n2Uv
	49a2vBRqij+i8oemll4YeuoBzLzM9kwJisUBU5KtGOnZUPldSNc5FgtmIRdVCK28Qyha1I9v/dz1w
	G7/NGwXkS/8Yvs8PknAUdDOjrgXPehBn10LlfkgIYbWOj/1Ox9v+R4UEwQJHy4+kg+O0VrlNoonAn
	VwMRg+3snncL4CE8LQwTFnGjZqUGef9ibeBgsFhgcr/NMbjM5kKJQpfwPqWM2lrkyHTmFc4wpkZ81
	wx9JMprg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tDR90-00000004IUJ-3IZ5;
	Tue, 19 Nov 2024 16:32:04 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 0)
	id EEE01301D99; Tue, 19 Nov 2024 17:32:02 +0100 (CET)
Message-Id: <20241119163035.877939834@infradead.org>
User-Agent: quilt/0.65
Date: Tue, 19 Nov 2024 17:25:33 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: x86@kernel.org, "To:riel"@surriel.com
Cc: linux-kernel@vger.kernel.org,
 peterz@infradead.org,
 Andy Lutomirski <luto@kernel.org>
Subject: [PATCH 6/7] x86/efi: Make efi_enter/leave_mm use the temporary_mm machinery
References: <20241119162527.952745944@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Andy Lutomirski <luto@kernel.org>

This should be considerably more robust.  It's also necessary for optimized
for_each_possible_lazymm_cpu() on x86 -- without this patch, EFI calls in
lazy context would remove the lazy mm from mm_cpumask().

Signed-off-by: Andy Lutomirski <luto@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/3efc4cfd1d7c45a32752ced389d6666be15cde56.1641659630.git.luto@kernel.org
---
 arch/x86/platform/efi/efi_64.c |    9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

--- a/arch/x86/platform/efi/efi_64.c
+++ b/arch/x86/platform/efi/efi_64.c
@@ -54,7 +54,7 @@
  * 0xffff_ffff_0000_0000 and limit EFI VA mapping space to 64G.
  */
 static u64 efi_va = EFI_VA_START;
-static struct mm_struct *efi_prev_mm;
+static temp_mm_state_t efi_temp_mm_state;
 
 /*
  * We need our own copy of the higher levels of the page tables
@@ -476,15 +476,12 @@ void __init efi_dump_pagetable(void)
  */
 static void efi_enter_mm(void)
 {
-	efi_prev_mm = current->active_mm;
-	current->active_mm = &efi_mm;
-	switch_mm(efi_prev_mm, &efi_mm, NULL);
+	efi_temp_mm_state = use_temporary_mm(&efi_mm);
 }
 
 static void efi_leave_mm(void)
 {
-	current->active_mm = efi_prev_mm;
-	switch_mm(&efi_mm, efi_prev_mm, NULL);
+	unuse_temporary_mm(efi_temp_mm_state);
 }
 
 void arch_efi_call_virt_setup(void)



