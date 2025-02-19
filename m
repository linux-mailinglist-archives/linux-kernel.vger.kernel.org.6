Return-Path: <linux-kernel+bounces-522190-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 00CA6A3C734
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 19:17:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D36E0168A12
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 18:17:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6845B1FECC1;
	Wed, 19 Feb 2025 18:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="bOHkZNQi"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDC3E8468
	for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 18:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739989073; cv=none; b=kl3UdJQ8bmRvLLvjXvI3RTCXZir/38OAJLp4To+rsriHzTwm9k3ljd43lRvQ0z9Bc7iuYbV2ko53rf7jVgX1dJJEr7H5HtZeFsqINNLCUtOgpnIxLcedRFciu8vaesKjJ/h7GXwGSJ/jy7KCPmtIxh8IDXPPTJejpG34Nl67W/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739989073; c=relaxed/simple;
	bh=lU37Sg6PyrahHfNfLKPAqzxcihSuzQ+txq8x46xqlqo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kXDR5baONuGZa5AtFx9AYuMG1VPrHXOQ15ZisLX3VaWfspbL2ujNWfAg+ZHfoHYfEXnUnnkLFmUB01gINt9A6Gc/30FAlkyB2YLJW1NCX9U6KdT/a2CHpjGsDwzUxnEdq6ORCi0hW18WXUZs0WQfZWHwuVCeZNKaMcN93ApE+8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=bOHkZNQi; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=eWBQAAMPddjj3Cdkgcm0As+9ccEQtRdteotwa1RXgiM=; b=bOHkZNQiBmMVoDkhxwgFuEaR4z
	sainPE4DoS5CJ0fd6E8tpE9EEnTBakROwxK2mhUabp6bVMIq4xtUUvRgIe2xjo2vSK3KAqvFIpaSc
	vp2NcIAoHJqir5UjWXwkzYVcDZ6Nvvf8ZDCMplq01SvAyZimQ/tF7AAA3GkU3SrVOrRxnLOWPTN9h
	3LuD5cqGW4lG5FcdS+cm2N1rGSE1dFfHLS0q1cRwaEVvzDWcBX8VbqspvA8Nka7TI95M8KBfC3jP9
	0dCUpAo7PeJD17jQBFMlEhX1BKwK56+ABm7uLGB7abCr8TuZzsrVQ3zSiAhvTHIPAuLEOdyZi+6Ue
	uZ0G3ciQ==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tkode-00000006mrh-0HjA;
	Wed, 19 Feb 2025 18:17:38 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 5096B300787; Wed, 19 Feb 2025 19:17:37 +0100 (CET)
Date: Wed, 19 Feb 2025 19:17:37 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Kees Cook <kees@kernel.org>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, alyssa.milburn@intel.com,
	scott.d.constable@intel.com, joao@overdrivepizza.com,
	andrew.cooper3@citrix.com, jpoimboe@kernel.org,
	jose.marchesi@oracle.com, hjl.tools@gmail.com,
	ndesaulniers@google.com, samitolvanen@google.com, nathan@kernel.org,
	ojeda@kernel.org, alexei.starovoitov@gmail.com, mhiramat@kernel.org,
	jmill@asu.edu
Subject: Re: [PATCH v3 04/10] x86/traps: Allow custom fixups in handle_bug()
Message-ID: <20250219181737.GC23004@noisy.programming.kicks-ass.net>
References: <20250219162107.880673196@infradead.org>
 <20250219163514.688460830@infradead.org>
 <202502190953.53EA878FF@keescook>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202502190953.53EA878FF@keescook>

On Wed, Feb 19, 2025 at 09:55:10AM -0800, Kees Cook wrote:

> > @@ -340,6 +343,9 @@ static noinstr bool handle_bug(struct pt
> >  		break;
> >  	}
> >  
> > +	if (!handled && regs->ip != addr)
> > +		regs->ip = addr;
> 
> Can you add a comment above this just to help with people scanning
> through this code in the future, maybe:
> 
> 	/* Restore failure location if we're not continuing execution. */
> 
> 
> > +
> >  	if (regs->flags & X86_EFLAGS_IF)
> >  		raw_local_irq_disable();
> >  	instrumentation_end();

Done.

