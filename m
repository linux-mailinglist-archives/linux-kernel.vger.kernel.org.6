Return-Path: <linux-kernel+bounces-269551-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 84708943429
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 18:31:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A2DE1F2291C
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 16:31:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77D651B29D3;
	Wed, 31 Jul 2024 16:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="iAtxGUxb"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95E4012E4D
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 16:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722443471; cv=none; b=o0tmiSoejbz8qv6+gSxZgDw9HzmgnIFpnaWWEAedOINXXq1/5GdKtQD4LgrkIa4gTQCH0z0ESn3Bna+wTKtNN5TpiBptgSwp+MXT1vDalzy9x3dMIjEw2Lr8lg04AMyLYJZdPp0nEIPn+7nPhrzUyw9v0nOVqIDBUre6YsXG20o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722443471; c=relaxed/simple;
	bh=i6lbpbvRoLrQ3TtcRBtQnBF8eR9Em8zrZ+vk5wulf2M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fpEpwNG4XH/uK5ozmyCLSKp3FjA+ZwJ0EWsk5VKAV0K1alFo2iMMTEwPJ3FGm/qfqhOgy+/uMik1+1n1iyOPS0lNqSMtuqcgW+HAbCFO8r3TpPWmDH9StsKI3DrVm42Gzf+O/SS7HJgiqYRDdIz4ouIcViJUPJ+p/jVPTGTZbo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=iAtxGUxb; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=jh6eGH3wnwRYpBMUc9b82uLGc8Q0MdL/UipWVU49jS0=; b=iAtxGUxb+0Rht7jBcTy1NrYcdp
	Di2SJH11HKYfcSHJeyhVCYbQk+jCYKAjlSem3vvVdMZoSSP5QeJJnuDXcOQlJJrARm8TcoITpK/ap
	cxBHyZkAs0aJNeFnx2oih1HboRfYe96YdGrOeYKhE064E5iq0fs89trMm2KaAk3f7QEvlpcukJIin
	NnhgJCo4YIR228HanuuBJKpxozK/+i1xKsytTrM1+fsAJJUc3qgqvTiC9Lwk6mAvSUHArVp6rzIQK
	wJ/XXAagalnVfV1IB285fm3vq8X/WWdK+BLOLRhyAR6FEm+9HZS4bZabBbvctAo4VoQnRzxHEHdZG
	3Opa9zTw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sZCEE-0000000GKro-05de;
	Wed, 31 Jul 2024 16:31:06 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 41C35300820; Wed, 31 Jul 2024 18:31:05 +0200 (CEST)
Date: Wed, 31 Jul 2024 18:31:05 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Guenter Roeck <linux@roeck-us.net>, Jens Axboe <axboe@kernel.dk>,
	Andy Lutomirski <luto@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Peter Anvin <hpa@zytor.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	the arch/x86 maintainers <x86@kernel.org>
Subject: Re: Linux 6.11-rc1
Message-ID: <20240731163105.GG33588@noisy.programming.kicks-ass.net>
References: <b7ecddb7-4486-4b2d-9179-82250cf830e7@roeck-us.net>
 <CAHk-=wj2BYPvYQAQa-pyT3hERcd2pVw+rL5kw7Y=-8PA3JTDAg@mail.gmail.com>
 <20240730192237.GR33588@noisy.programming.kicks-ass.net>
 <231e7a2e-7e2e-4b82-b084-8943b2236de0@kernel.dk>
 <20240730193841.GS33588@noisy.programming.kicks-ass.net>
 <daef7867-b548-4acb-b8bf-0bdeb057d6a4@roeck-us.net>
 <20240731122002.GE33588@noisy.programming.kicks-ass.net>
 <87mslx67dm.ffs@tglx>
 <20240731155551.GF33588@noisy.programming.kicks-ass.net>
 <CAHk-=wjhQ-TTg40xSP5dP0a1_90LMbxhvX0bsVBdv3wpQN2xQQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wjhQ-TTg40xSP5dP0a1_90LMbxhvX0bsVBdv3wpQN2xQQ@mail.gmail.com>

On Wed, Jul 31, 2024 at 09:17:44AM -0700, Linus Torvalds wrote:
> On Wed, 31 Jul 2024 at 08:55, Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > Right, so Thomas found that i386-pti fails to map the entire entry text.
> > Specifically pti_clone_pgtable() hard relies -- and does not verify --
> > that the start address is aligned to the given granularity.
> >
> > Now, i386 does not align __entry_text_start, and so the termination
> > condition goes sideways and pte_clone_entry() does not always work right
> > and it becomes a games of code layout roulette.
> 
> Lovely.

:-)

This fixes the alignment assumptions and makes it all go again.

diff --git a/arch/x86/mm/pti.c b/arch/x86/mm/pti.c
index 2e69abf4f852..bfdf5f45b137 100644
--- a/arch/x86/mm/pti.c
+++ b/arch/x86/mm/pti.c
@@ -374,14 +374,14 @@ pti_clone_pgtable(unsigned long start, unsigned long end,
 			 */
 			*target_pmd = *pmd;
 
-			addr += PMD_SIZE;
+			addr = round_up(addr + 1, PMD_SIZE);
 
 		} else if (level == PTI_CLONE_PTE) {
 
 			/* Walk the page-table down to the pte level */
 			pte = pte_offset_kernel(pmd, addr);
 			if (pte_none(*pte)) {
-				addr += PAGE_SIZE;
+				addr = round_up(addr + 1, PAGE_SIZE);
 				continue;
 			}
 
@@ -401,7 +401,7 @@ pti_clone_pgtable(unsigned long start, unsigned long end,
 			/* Clone the PTE */
 			*target_pte = *pte;
 
-			addr += PAGE_SIZE;
+			addr = round_up(addr + 1, PAGE_SIZE);
 
 		} else {
 			BUG();

