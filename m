Return-Path: <linux-kernel+bounces-522370-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F11F6A3C946
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 21:08:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD8941776EA
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 20:08:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3AFC22AE42;
	Wed, 19 Feb 2025 20:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="kroR2kYM"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 258781C1F08
	for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 20:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739995688; cv=none; b=GLEfeLhpykSNf/gZSuq9RGRPzgPE7QLq18i8azKWGGVClt1RWyoMQGnGpk6Vxk5JmSD9wo3FFWEhRWbOEUzoswBILEkDWBvzDgIIDw1MdQQSJlsk5cHredU1RLu0bYGfEZZmrxQq1tHW/czClWlkYXnW0RcQgp9kSYRFefCDdHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739995688; c=relaxed/simple;
	bh=VQ6no0JSjJW2mYGS6zYRZ5qGFQxfxW7dm8MbROLLEv0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KTdmZ9kf8ouk3br6npEGg5MTjNn+9c1hVSVXdCraRK9nlD8R+lFkuFMTSbkek0WPYA/2iQEjGnn55XuhjcVieMDI9ztNHgXVPxU2PStwxvTGaiAuyTCwXZ6xk5vQjsMOXywRMQEQkgPu6w5ShtqtkUIN0F7bOYnCEJQuwL28xaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=kroR2kYM; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=c0j4I2tUr1U6Mk6tegLamwqOzyEMJ1kDXHabcbeMEcU=; b=kroR2kYMLrGUcO7Enm7PyJqYZn
	IupkgI/8jaL7YqYvvXuaXTj+5CW9TvauhI4STbTD0nL6OUu2IeKa92u7WSnSxkBz7NTNz7qrUwBa/
	Yr7AOPw9i3vyviF1zivooR7zs51jJX2AHxzlfQLYyvQAQAOiXFdtCn/fiw+JYhdpgJZLyIgGAYFIn
	DeGEw3oIP5asVXsGhhcLZQssqij3+iw/tKPu2qvbty6wc/BiG44/E4UHVvNT6UP/aiDsCX61eSjF2
	9QyFe8ArH+rtRgxYoaLvtaTi9fTgdnI4Ixjd7MhgtpkvLFYKIoE3TlhPxbiPBxtV39gn+pnwzyhQW
	k/zw2gcw==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tkqMP-00000002JtT-18zb;
	Wed, 19 Feb 2025 20:07:57 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id B70CF300783; Wed, 19 Feb 2025 21:07:56 +0100 (CET)
Date: Wed, 19 Feb 2025 21:07:56 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Andrew Cooper <andrew.cooper3@citrix.com>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, alyssa.milburn@intel.com,
	scott.d.constable@intel.com, joao@overdrivepizza.com,
	jpoimboe@kernel.org, jose.marchesi@oracle.com, hjl.tools@gmail.com,
	ndesaulniers@google.com, samitolvanen@google.com, nathan@kernel.org,
	ojeda@kernel.org, kees@kernel.org, alexei.starovoitov@gmail.com,
	mhiramat@kernel.org, jmill@asu.edu
Subject: Re: [PATCH v3 07/10] x86/ibt: Add paranoid FineIBT mode
Message-ID: <20250219200756.GF23004@noisy.programming.kicks-ass.net>
References: <20250219162107.880673196@infradead.org>
 <20250219163515.040300905@infradead.org>
 <dc7c570e-153e-4e46-ae40-d1590682d50c@citrix.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <dc7c570e-153e-4e46-ae40-d1590682d50c@citrix.com>

On Wed, Feb 19, 2025 at 05:31:39PM +0000, Andrew Cooper wrote:
> On 19/02/2025 4:21 pm, Peter Zijlstra wrote:
> > --- a/arch/x86/include/asm/cfi.h
> > +++ b/arch/x86/include/asm/cfi.h
> > @@ -1116,6 +1129,52 @@ extern u8 fineibt_caller_end[];
> >  
> >  #define fineibt_caller_jmp (fineibt_caller_size - 2)
> >  
> > +/*
> > + * Since FineIBT does hash validation on the callee side it is prone to
> > + * circumvention attacks where a 'naked' ENDBR instruction exists that
> > + * is not part of the fineibt_preamble sequence.
> > + *
> > + * Notably the x86 entry points must be ENDBR and equally cannot be
> > + * fineibt_preamble.
> > + *
> > + * The fineibt_paranoid caller sequence adds additional caller side
> > + * hash validation. This stops such circumvetion attacks dead, but at the cost
> > + * of adding a load.
> > + *
> > + * <fineibt_paranoid_start>:
> > + *  0:   41 ba 78 56 34 12       mov    $0x12345678, %r10d
> > + *  6:   45 3b 53 f7             cmp    -0x9(%r11), %r10d
> > + *  a:   4d 8d 5b <f0>           lea    -0x10(%r11), %r11
> > + *  e:   75 fd                   jne    d <fineibt_paranoid_start+0xd>
> > + * 10:   41 ff d3                call   *%r11
> > + * 13:   90                      nop
> > + *
> > + * Notably LEA does not modify flags and can be reordered with the CMP,
> > + * avoiding a dependency. Again, using a non-taken (backwards) branch
> > + * for the failure case, abusing LEA's immediate 0xf0 as LOCK prefix for the
> > + * JCC.d8, causing #UD.
> > + */
> 
> I don't know what to say.  This is equal parts horrifying and beautiful.
> 
> > +asm(	".pushsection .rodata				\n"
> > +	"fineibt_paranoid_start:			\n"
> > +	"	movl	$0x12345678, %r10d		\n"
> > +	"	cmpl	-9(%r11), %r10d			\n"
> > +	"	lea	-0x10(%r11), %r11		\n"
> > +	"	jne	fineibt_paranoid_start+0xd	\n"
> 
> Maybe `jne . - 3` ?
> 
> Or perhaps `1: jne 1b - 1` ?
> 
> Both seem marginally less fragile than tying the reference to
> fineibt_paranoid_start.

Right, so I initially had '. - 3' (and '. - 7' in
fineibt_preamble_start), but I ended up going with this form because
that's what you end up with if you run it through an assembler and
disassembler.

So I figured this form was easier to compare vs disassembly, which is
what most people will see if they ever look at this.

Anyway, I'm happy to go '. - 3' again if that's preferred.

