Return-Path: <linux-kernel+bounces-342471-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 21816988F65
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Sep 2024 15:31:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 498ED1C20B09
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Sep 2024 13:31:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6058188014;
	Sat, 28 Sep 2024 13:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="JMWGX9sf"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF258C8DF
	for <linux-kernel@vger.kernel.org>; Sat, 28 Sep 2024 13:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727530285; cv=none; b=RjCEiXVUiEiY90y1CrecEgLNg9Q2Q82DdguSG0+Bzg+22KXBhoWKf1FahTNBnDfZMoyogodHjk+OTTRb73WwA43I1ar0yT9h73qVB3ubs032gpD/VcJ6RLW/c/Ujqx37+UZI2iyFgIKEJkpqZ5HJOzuSvKJ2mzSE0FnN7kIQiEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727530285; c=relaxed/simple;
	bh=LbZsTRAlB7jsXws4637asyXQKwtUK+5v9ZClVjEBUi4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nSUs7XMkapn2IV2+GmufAWdBxNgnjln/yOG3uvDsIXxyT5OMSoYn0JyICREZQ43z/V3ACqz07bHerButciIQ5U7nSccr5VhsSROlB0NEMlZYHUwHTorNcpkqbw6HEvtrkVeC+S52C3J4n/Ve6gdV0nm0rdIByePu/FR1CQbZEtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=JMWGX9sf; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=oNmWZpR+4wN8DEFvjDQJ2iVf4wwDsGeXGTFBgKXmZ2E=; b=JMWGX9sfL5ww64LfzEARqVtNHf
	Oyw1FOUiz4IltGWKUHXiY8uD9JXhXJuTGGxfSMf4OQ7RMiD+PzvJSUxP2mGwlpBJEUvNU87ZrynNa
	r85PfucemuJf8LBxvJc1aWa4lHcJHpuyIIro7d9f7m8BAGo/Fsof4LuBkVGQuSHlRZwU8m2ozQc2S
	jcDpkTI+jgxgpf/q5GjpPaWBFmHs8graGoXuTiUduWpxTxTYWbIJrKiAcxFaSzV1XJNMWFHmOxg8i
	OTIId6bmYVuLT4VViTr5Kg62WNrrMkabhkJsznk8hxLtH46XN5N2to+UGESe5FN9gUk5B2DpNeIE6
	IBSHXLSQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1suXXX-00000002Vwp-05Po;
	Sat, 28 Sep 2024 13:31:15 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 8ED4B300848; Sat, 28 Sep 2024 15:31:14 +0200 (CEST)
Date: Sat, 28 Sep 2024 15:31:14 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, alyssa.milburn@intel.com,
	scott.d.constable@intel.com, joao@overdrivepizza.com,
	andrew.cooper3@citrix.com, jose.marchesi@oracle.com,
	hjl.tools@gmail.com, ndesaulniers@google.com,
	samitolvanen@google.com, nathan@kernel.org, ojeda@kernel.org,
	kees@kernel.org, alexei.starovoitov@gmail.com
Subject: Re: [PATCH 01/14] x86/cfi: Wreck things...
Message-ID: <20240928133114.GE19439@noisy.programming.kicks-ass.net>
References: <20240927194856.096003183@infradead.org>
 <20240927194924.390462812@infradead.org>
 <20240927231527.em2a4cjbnpos6c4u@treble>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240927231527.em2a4cjbnpos6c4u@treble>

On Fri, Sep 27, 2024 at 04:15:27PM -0700, Josh Poimboeuf wrote:
> On Fri, Sep 27, 2024 at 09:48:57PM +0200, Peter Zijlstra wrote:
> > vmlinux.o: warning: objtool: .export_symbol+0x3c9f0: data relocation to !ENDBR: entry_untrain_ret+0x0
> > 
> > Which states that while these functions are exported and (directly)
> > callable, they cannot be called indirectly. There are two solutions:
> 
> IIRC, exported symbols are by far the most common "need" for ENDBR.  But
> presumably the vast majority of them aren't being indirect called.
> 
> >  - exclude the .export_symbol section from validation; effectively
> >    saying that having linkable but not indirectly callable exports are
> >    fine by default, or
> 
> This is confusingly inconsistent IMO.

Yes. OTOH less indirectly callable functions is more better, no?

> >  - make all of those use SYM_TYPED_FUNC_START to restore the
> >    traditional (and expected, but less secure?) behaviour.
> 
> Why not just make SYM_FUNC_START imply "typed"?  That's consistent with
> what the compiler does anyway right?

It is indeed what the compiler does (unless __nocfi attribute is
employed), but it requires that there is a C declaration of the function
-- which is true for all exported functions but not necessary for all
SYM_FUNC_START() symbols per-se.

Also, it would make all ASM functions indirectly callable by default --
which I'm not sure is a good idea, I would much rather we keep this
explicit.

> Even better, require exported+indirect-called symbols to use
> EXPORT_SYMBOL_TYPED, otherwise they get sealed.  I suppose we'd need to
> add some module-to-vmlinux ENDBR validation to make sure modules don't
> get broken by this.

So I like this idea. but yeah, this is going to be a bit tricky to
validate.

Anyway, I think I'll do an initial patch moving all the EXPORT'ed
symbols over to SYM_TYPED_FUNC_START() for now, and we can look at
adding extra EXPORT magic on top of all that later on.

