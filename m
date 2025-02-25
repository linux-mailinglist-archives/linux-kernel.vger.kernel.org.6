Return-Path: <linux-kernel+bounces-532244-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 610A2A44A87
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 19:36:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 47ADB19E0052
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 18:35:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C26F11FDA65;
	Tue, 25 Feb 2025 18:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cfkXcT3W"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C65B1A5BAC
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 18:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740508425; cv=none; b=iRcBCH0uIRQIzqZ9Rlt+qqUxPw/VE4KkTZCqe/wM2J0Hxk3ymhjDkCDlclslztxS2hyWLEFiAO1Fku23T9UfizzNzBgaq1xqe4ugDgflYZYS7BJfla0Z1H9NbeANGbAfz1GLT5v3wf2CD872Qf2dX3bWt0/z+b3/azOR18OM9ng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740508425; c=relaxed/simple;
	bh=8LSNEsv5PLyXQZmXyxMfaDowdwhsfLZkNeWsF5iFW4A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NQvfojTfP/Ih4YdUva0s+w7pSjozr1jZ3KGl3z2isqB0gXqMIg0AGJqkyQ8+h8ZFJTxRRD3A9UGyffD25JN5SLB5oknH9I4EjwqPMGZ8l9KdXW/+VaefKsoctZpCGhm+0P92FeLLmb8+4L00wBxjgX3yAcUfNFTO62p33lsXJqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cfkXcT3W; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D815C4CEDD;
	Tue, 25 Feb 2025 18:33:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740508424;
	bh=8LSNEsv5PLyXQZmXyxMfaDowdwhsfLZkNeWsF5iFW4A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cfkXcT3WVzH0+MDpgLAHoaYON+/B7JVKGOYIEXdsMyR3Qgi126ZoV6SMfPdvtVsie
	 vlPzrVNwBl/yNcUDsElxXE9rDQFgiggvSy+Xm2xZesPu8fhjIOHoZ+Bju8ebYooNHo
	 oRHnqV4WpplvZ1mFnOpmBAYSqgaGyzuCkcTtX4B621pYh15ApoO+GGadwID32wJdjZ
	 rhkAES4qy0RbXdVKgpvA4jXDDZxtDVogo89EWmkoJ2hlVtFCxklulguh/ie6YN4Nzq
	 OHG3RtNTkA4YGW/aea3HOrg5twtAWLXV5gcEgmQYViI8O7zk/W9DNdX1Yo+Ubxa2HR
	 0RyuKWh/xvlaQ==
Date: Tue, 25 Feb 2025 10:33:41 -0800
From: Kees Cook <kees@kernel.org>
To: David Laight <david.laight.linux@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
	linux-kernel@vger.kernel.org, alyssa.milburn@intel.com,
	scott.d.constable@intel.com, joao@overdrivepizza.com,
	andrew.cooper3@citrix.com, jpoimboe@kernel.org,
	jose.marchesi@oracle.com, hjl.tools@gmail.com,
	ndesaulniers@google.com, samitolvanen@google.com, nathan@kernel.org,
	ojeda@kernel.org, alexei.starovoitov@gmail.com, mhiramat@kernel.org,
	jmill@asu.edu
Subject: Re: [PATCH v4 06/10] x86/traps: Decode LOCK Jcc.d8 #UD
Message-ID: <202502251033.B8216DDA3@keescook>
References: <20250224123703.843199044@infradead.org>
 <20250224124200.486463917@infradead.org>
 <20250224214612.5569d62c@pumpkin>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250224214612.5569d62c@pumpkin>

On Mon, Feb 24, 2025 at 09:46:12PM +0000, David Laight wrote:
> On Mon, 24 Feb 2025 13:37:09 +0100
> Peter Zijlstra <peterz@infradead.org> wrote:
> 
> > Because overlapping code sequences are all the rage.
> > 
> > Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> > Reviewed-by: Kees Cook <kees@kernel.org>
> > ---
> >  arch/x86/include/asm/bug.h |    2 ++
> >  arch/x86/kernel/traps.c    |   26 +++++++++++++++++++++++---
> >  2 files changed, 25 insertions(+), 3 deletions(-)
> > 
> > --- a/arch/x86/include/asm/bug.h
> > +++ b/arch/x86/include/asm/bug.h
> > @@ -17,6 +17,7 @@
> >   * In clang we have UD1s reporting UBSAN failures on X86, 64 and 32bit.
> >   */
> >  #define INSN_ASOP		0x67
> > +#define INSN_LOCK		0xf0
> >  #define OPCODE_ESCAPE		0x0f
> >  #define SECOND_BYTE_OPCODE_UD1	0xb9
> >  #define SECOND_BYTE_OPCODE_UD2	0x0b
> > @@ -26,6 +27,7 @@
> >  #define BUG_UD1			0xfffd
> >  #define BUG_UD1_UBSAN		0xfffc
> >  #define BUG_EA			0xffea
> > +#define BUG_LOCK		0xfff0
> >  
> >  #ifdef CONFIG_GENERIC_BUG
> >  
> > --- a/arch/x86/kernel/traps.c
> > +++ b/arch/x86/kernel/traps.c
> > @@ -97,6 +97,7 @@ __always_inline int is_valid_bugaddr(uns
> >   * If it's a UD1, further decode to determine its use:
> >   *
> >   * FineIBT:      ea                      (bad)
> > + * FineIBT:      0f 75 f9                lock jne . - 6
>                     ^^ nibble swapped

Oh, good catch!

-- 
Kees Cook

