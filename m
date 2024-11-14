Return-Path: <linux-kernel+bounces-409217-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4BA29C8914
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 12:36:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8FEEB283774
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 11:36:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BC8B1F8F17;
	Thu, 14 Nov 2024 11:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="nvhg/y+T"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBFB81F8909
	for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 11:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731584193; cv=none; b=Nle9VeymFjuUWSSYFGGhWkYmkKQJd2TMq+q63wkLuZ6H7a7BRY5HySQdLqz+9mQAShffRM5ZUsckw5/iKrwAK9Jc7I5Dkd5XFMSM/bbsiKKBYRzGZYF4h8+cBfoNFghYEDa08fYqgg48kM3/tMUT4gZ3Ax/WsUrrAzvB+GxlqJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731584193; c=relaxed/simple;
	bh=Fq2idYlc6ipRSYkL/AaCq8RoLiwSJU1hJ8nz59BMHio=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZVHISO4Z+06sAnT+46WC8s1hG/6Tm06QlaKnXd5LxC+spiwEn1ChKtFBgdf4YG1bbub9HQxeqafH83aFmEm/pNb4g+2F6qmFvxnJeH5IxDUgEN0RJXN9hv9UTNG12XJWJ96kmLdeDSIMumMmnQ9sUJbj69FQTdgbjmlkDOomAtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=nvhg/y+T; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=nNbTl4YNrxWj/WxFew1ipd4yslxAIAgr5z2mXkO4ZA8=; b=nvhg/y+T4MWfmBVXiLOrv03RsB
	RtwjqFehtYYuQkh5QoFuWBmp/ON/B3Ecb9aN2+XBCNZKzQ3nkOIFWvlXqux0IKQOTBgB+8Bj3Vvy6
	/TOsIaZ8bR4ILIiNDtnFKTbOsqSxgdeR6JS6wvqw7qEkr0x7jV50CaK0tLx7xMlsYvT5UmlCDU+T9
	wdcUcmPybblG8aJVgYYc33qoty9NMoshJfCTKUnOHAHNFbiYI3FAEwSi5YBL4rsX99nWuageQgjpb
	k7whENZG7yA/GIpI8Yped9YXZSpqdtv5Qf6WexikFzI4aQJS31y/rTUxjKzmqHeq3WhpGzya9Txri
	iB9POQoA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tBY94-000000000jF-2cqx;
	Thu, 14 Nov 2024 11:36:19 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id BEFE3300472; Thu, 14 Nov 2024 12:36:17 +0100 (CET)
Date: Thu, 14 Nov 2024 12:36:17 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Rik van Riel <riel@surriel.com>
Cc: Borislav Petkov <bp@alien8.de>, linux-kernel@vger.kernel.org,
	dave.hansen@linux.intel.com, luto@kernel.org, tglx@linutronix.de,
	mingo@redhat.com, x86@kernel.org, kernel-team@meta.com,
	hpa@zytor.com, bigeasy@linutronix.de
Subject: Re: [PATCh 0/3] x86,tlb: context switch optimizations
Message-ID: <20241114113617.GO6497@noisy.programming.kicks-ass.net>
References: <20241109003727.3958374-1-riel@surriel.com>
 <20241113095550.GBZzR3pg-RhJKPDazS@fat_crate.local>
 <20241113095557.2d60a073@imladris.surriel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241113095557.2d60a073@imladris.surriel.com>

On Wed, Nov 13, 2024 at 09:55:57AM -0500, Rik van Riel wrote:
>  arch/x86/kernel/alternative.c | 11 +++--------
>  1 file changed, 3 insertions(+), 8 deletions(-)
> 
> diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
> index d17518ca19b8..f3caf5bc4df9 100644
> --- a/arch/x86/kernel/alternative.c
> +++ b/arch/x86/kernel/alternative.c
> @@ -1830,6 +1830,9 @@ static inline void unuse_temporary_mm(temp_mm_state_t prev_state)
>  	lockdep_assert_irqs_disabled();
>  	switch_mm_irqs_off(NULL, prev_state.mm, current);
>  
> +	/* Force a TLB flush next time poking_mm is used. */
> +	inc_mm_tlb_gen(poking_mm);
> +
>  	/*
>  	 * Restore the breakpoints if they were disabled before the temporary mm
>  	 * was loaded.
> @@ -1940,14 +1943,6 @@ static void *__text_poke(text_poke_f func, void *addr, const void *src, size_t l
>  	 */
>  	unuse_temporary_mm(prev);
>  
> -	/*
> -	 * Flushing the TLB might involve IPIs, which would require enabled
> -	 * IRQs, but not if the mm is not used, as it is in this point.
> -	 */
> -	flush_tlb_mm_range(poking_mm, poking_addr, poking_addr +
> -			   (cross_page_boundary ? 2 : 1) * PAGE_SIZE,
> -			   PAGE_SHIFT, false);
> -
>  	if (func == text_poke_memcpy) {
>  		/*
>  		 * If the text does not match what we just wrote then something is

So I really don't like this.

Yes it avoids the immediate problem, but we're now sending IPIs where we
shoulnd't be.

Fundamentally this whole text_poke thing is set up such that only a
single CPU will have this magical mapping with the aliasses. Having it
send IPIs is crazy.

