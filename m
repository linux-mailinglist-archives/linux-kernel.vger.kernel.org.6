Return-Path: <linux-kernel+bounces-409223-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BBD779C8928
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 12:43:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 811ED284766
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 11:43:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D9691F9400;
	Thu, 14 Nov 2024 11:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="DJ4Ssf5B"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 964861F8185
	for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 11:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731584596; cv=none; b=PdT9scrmxTnweCXR6z1klp2JyznAdYR/b86GCAJ2/TlxtAAhfGvhsMQ7sU6HBW+y3ZoOTLxdXjTYkL4YIxHMRslFEeF82vy5VONkEC7uacGzE2GUyjmG/9b79ALsKU8cX9U88dLV4qtUcgUsB+35VTW6AYNkztV7fWLfR/pmCuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731584596; c=relaxed/simple;
	bh=c7GXOwm87U/RMLNgN05PsYW204x5lYucKz/+G29oHIs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nvNEQ/s2Qv/KJfc+kL9sJyvhylzEmRA4yVZBIMO5T4OXyloxVwZVSelVn4qaL9lmOYu+WlPeLmnE+3Ou9jpUDdvkxcTp3JywxsKfMDxiEOmxfJoTM6lQSKtwNc5fDTuX2yaCXtwSkP9Ddrc2KKsA4rgOKs8Zxr6Kyqdh+ZHpzZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=DJ4Ssf5B; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=KTGkrkiAlgVGT3mBdVTPJiuKbHOp6dm+tc/6MjUAEr0=; b=DJ4Ssf5B34n8C3rJ9KhSUbmu2N
	HWU9Sh3WliCmHefC2EiFxat0Q+rAcA4ChLDo2QpPXnpXIAv9jj5n8GdSxEWGZHCvQ7pGbllQbP1cu
	zi+n5wZ3RM/0lgVp/xA4bGdSfzJbnWkfOOrPoGwPuNAQdBmBn0cUBHVOSGS/9Ea7ugMN2zVetzVVO
	ksJzlAXNB94zYhHArG2DOZpyZNgdR3pvBqETwq91pAp1valBjdeZ1D70e2vWIKXuNF6kRoFPBuKEJ
	V9VfUDDAWAmzMNUB5HeeW5z4EbmHsZpsTq12oYXAtuCVaYHFxyCiwh6+C5Ffj6By2tHwi/2t+cqvJ
	FaTus+7g==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tBYFh-00000000fFd-2uhE;
	Thu, 14 Nov 2024 11:43:09 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 5BAAE300472; Thu, 14 Nov 2024 12:43:09 +0100 (CET)
Date: Thu, 14 Nov 2024 12:43:09 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Rik van Riel <riel@surriel.com>
Cc: Borislav Petkov <bp@alien8.de>, linux-kernel@vger.kernel.org,
	dave.hansen@linux.intel.com, luto@kernel.org, tglx@linutronix.de,
	mingo@redhat.com, x86@kernel.org, kernel-team@meta.com,
	hpa@zytor.com, bigeasy@linutronix.de
Subject: Re: [PATCh 0/3] x86,tlb: context switch optimizations
Message-ID: <20241114114309.GF38972@noisy.programming.kicks-ass.net>
References: <20241109003727.3958374-1-riel@surriel.com>
 <20241113095550.GBZzR3pg-RhJKPDazS@fat_crate.local>
 <20241113095557.2d60a073@imladris.surriel.com>
 <20241114113617.GO6497@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241114113617.GO6497@noisy.programming.kicks-ass.net>

On Thu, Nov 14, 2024 at 12:36:17PM +0100, Peter Zijlstra wrote:
> On Wed, Nov 13, 2024 at 09:55:57AM -0500, Rik van Riel wrote:
> >  arch/x86/kernel/alternative.c | 11 +++--------
> >  1 file changed, 3 insertions(+), 8 deletions(-)
> > 
> > diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
> > index d17518ca19b8..f3caf5bc4df9 100644
> > --- a/arch/x86/kernel/alternative.c
> > +++ b/arch/x86/kernel/alternative.c
> > @@ -1830,6 +1830,9 @@ static inline void unuse_temporary_mm(temp_mm_state_t prev_state)
> >  	lockdep_assert_irqs_disabled();
> >  	switch_mm_irqs_off(NULL, prev_state.mm, current);
> >  
> > +	/* Force a TLB flush next time poking_mm is used. */
> > +	inc_mm_tlb_gen(poking_mm);
> > +
> >  	/*
> >  	 * Restore the breakpoints if they were disabled before the temporary mm
> >  	 * was loaded.
> > @@ -1940,14 +1943,6 @@ static void *__text_poke(text_poke_f func, void *addr, const void *src, size_t l
> >  	 */
> >  	unuse_temporary_mm(prev);
> >  
> > -	/*
> > -	 * Flushing the TLB might involve IPIs, which would require enabled
> > -	 * IRQs, but not if the mm is not used, as it is in this point.
> > -	 */
> > -	flush_tlb_mm_range(poking_mm, poking_addr, poking_addr +
> > -			   (cross_page_boundary ? 2 : 1) * PAGE_SIZE,
> > -			   PAGE_SHIFT, false);
> > -
> >  	if (func == text_poke_memcpy) {
> >  		/*
> >  		 * If the text does not match what we just wrote then something is
> 
> So I really don't like this.
> 
> Yes it avoids the immediate problem, but we're now sending IPIs where we
> shoulnd't be.
> 
> Fundamentally this whole text_poke thing is set up such that only a
> single CPU will have this magical mapping with the aliasses. Having it
> send IPIs is crazy.

I'm thinking the better fix is to make unuse_temporary_mm() explicitly
clear the bit if we don't want switch_mm() to do it.

