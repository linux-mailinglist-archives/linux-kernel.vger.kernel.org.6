Return-Path: <linux-kernel+bounces-395050-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E3189BB7CD
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 15:30:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 02C03285AE5
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 14:30:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42AF21B21A1;
	Mon,  4 Nov 2024 14:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="rAhEW1ko"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25ABD17B428
	for <linux-kernel@vger.kernel.org>; Mon,  4 Nov 2024 14:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730730601; cv=none; b=lnFM1UABkRxblDZ2udHBOF0JiDNB7n2BdhrHh0XXAhh6qAIT0WquCPXoO4aWr1IugK3JV7ruwdnJq6/ZNebv74Vr+cnLeZ7J/S+NumOtnacVyRVtK2rBtCi8wQFBCaZAGk5ccp/dw/rnU/uID9D9p11yMUJOeyXUiMw7A2lO2RM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730730601; c=relaxed/simple;
	bh=78JxXVMu8D98x7ixcMyfUiTSVm7iqOh0y7JOIzqGGBw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tXxptcaldGzE3LqV+k304iJJYkzQFrPISrqOEe5APETNeckOmP0Uak0PPOUhi7YMnWRNFLcFQdvRCFuvf7N1v4BEgbKkqdVCOWwn12hGPJKQqVDYj6dRqk6ycM4ngYskO3g+wl/n4NR26+TEfxnBq8gPeFaT+OUEDq8UWOSxFfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=rAhEW1ko; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=DqVc+7fEDa9hrMbW4NCEftqGuUhZwEhix7cq9nYHxTY=; b=rAhEW1koCe1WxT+feWWXrDpvHQ
	C+xo9fnHOo1SBIbo1Cd5xXRZCnnpEfWBKLLXuLDqmaZ9FKH5HLYdMcSy+snjGt1aojHKLKFCxNSeH
	RYOK5x40QCNPVNOvq4RFfKZqLsXrMedC1enQks0zb+hfkekmgyc8AM1nU7ljM9zBPEDA2cLf5pPL6
	//Hzo0JInIl1luqRYlGReoSlxciO+3BA/3+TSEerm2QzLul/ZuWXlB9ZwN0JeNhi9a+fBJA/3nIMx
	zQ8+CQee44fmKVkAshJjG5qGdp7AU0dQa6kRzScOLfxC8hLDk7z4xyaPkO2xX7rydGRm7mzdPbx6U
	8eZNafHA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1t7y5Z-0000000BM0g-3gb8;
	Mon, 04 Nov 2024 14:29:54 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 4034F30073F; Mon,  4 Nov 2024 15:29:53 +0100 (CET)
Date: Mon, 4 Nov 2024 15:29:53 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Borislav Petkov <bp@alien8.de>
Cc: david.kaplan@amd.com, jpoimboe@redhat.com, linux-kernel@vger.kernel.org,
	x86@kernel.org
Subject: Re: [RFC][PATCH 2/2] x86: Clean up default rethunk warning
Message-ID: <20241104142953.GG24862@noisy.programming.kicks-ass.net>
References: <20241007083210.043925135@infradead.org>
 <20241007083844.119369498@infradead.org>
 <20241104114728.GTZyi0UHYKx-ZHL4kh@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241104114728.GTZyi0UHYKx-ZHL4kh@fat_crate.local>

On Mon, Nov 04, 2024 at 12:47:28PM +0100, Borislav Petkov wrote:
> On Mon, Oct 07, 2024 at 10:32:12AM +0200, Peter Zijlstra wrote:
> > -	.section .text..__x86.indirect_thunk
> > +#define WARN_ONCE							\
> 
> This should be in the asm section of arch/x86/include/asm/bug.h so that other
> asm code can use it. It will come in handy...
> 
> > +	1: ALTERNATIVE "", "ud2", X86_FEATURE_ALWAYS ;			\
> 
> ... but uff, you can't because of this ALTERNATIVE. This is a conditional
> WARN_ONCE.  Yuck.
> 
> I guess ALT_WARN_ONCE or so...

Yeah, Josh already said similar things.

> > +	ASM_BUGTABLE_FLAGS(1b, 0, 0, BUGFLAG_WARNING | BUGFLAG_ONCE) ;	\
> > +	REACHABLE
> >  
> > +	.section .text..__x86.indirect_thunk
> >  
> >  .macro POLINE reg
> >  	ANNOTATE_INTRA_FUNCTION_CALL
> > @@ -382,16 +387,15 @@ SYM_FUNC_END(call_depth_return_thunk)
> >  SYM_CODE_START(__x86_return_thunk)
> >  	UNWIND_HINT_FUNC
> >  	ANNOTATE_NOENDBR
> > -#if defined(CONFIG_MITIGATION_UNRET_ENTRY) || \
> > -    defined(CONFIG_MITIGATION_SRSO) || \
> > -    defined(CONFIG_MITIGATION_CALL_DEPTH_TRACKING)
> > -	ALTERNATIVE __stringify(ANNOTATE_UNRET_SAFE; ret), \
> > -		   "jmp warn_thunk_thunk", X86_FEATURE_ALWAYS
> > -#else
> > +
> > +#ifdef CONFIG_X86_64
> > +	WARN_ONCE
> > +#endif
> 
> And you can add an empty 32-bit WARN_ONCE macro so that we don't have this
> ifdeffery here where ifdeffery gives the last drop of making this file totally
> unreadable...

I just realized all the rethunk crap is 64bit only anyway. So it don't
matter.

But the reason I did this is that we never rewrite thunk calls on 32bit
(really, we should just strip all mitigation shit from it and leave it
to rot).


