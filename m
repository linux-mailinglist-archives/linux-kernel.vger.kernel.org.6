Return-Path: <linux-kernel+bounces-343569-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4ACCF989CC0
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 10:27:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 104A62847A7
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 08:27:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 582FE178383;
	Mon, 30 Sep 2024 08:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="mQpRWTdn"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 384444204B
	for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 08:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727684853; cv=none; b=ajre9FI+9W3U2cQC5npD3C4ijIIC1FPCutC6/wzznWQhbWLpfOLMDg9rhmDKIXFvc0R+dJnMGc5O3WP0H5FRUlFxUVecRwFHVupe07bYrMgIz4N/StaQysieYivNa56ZR3D1GGpZ6ECOuH0v+nwb3OlOQ5ZQGflgebtocoV9tkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727684853; c=relaxed/simple;
	bh=j3jEZzukQCCrjPaiemf0yyawKBJnG9j3t1byq24eLJQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pQuhY1R7QMSlk6htGb8Weo4KTqanVynQturpZghZIRnO/UiANjLILXqvHfxDJDU2b5dwPd1FZqU5JvzOVg+xzgAyA9/danDeBwuGrvRocuHwhbSHf/t2aWDLmXEGsr5V9VeRyy4m40Y6o/+clu8KyKmBh3ducdT09mOEkfQ+h8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=mQpRWTdn; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Bfd2nelzpYITZNnm0JQqpwMOHvm3jmX7RrfGFgeC3TU=; b=mQpRWTdncEPGM2mCsY5WbTyq20
	faxhsTmz/Tn7Hzz3XGenJBneXLlqysSNLPlkeUc22hPgSQrJlBZTNjEpr6ELzG0IkXSGqoMXuKlMW
	V6vPkeXNMYFpZpjWtGDomSrTStINarGKZVtRPUHvUIduOUMCe+cJ8IKGEFRa6Q7u9qMW92WWhlPKL
	iChawNFuEElX7VNZkJIrDb31MDFSWptto3UoDcyC/iivARat8CpiqH8BwZkPsYfmL9WsoS/9Dbc95
	FSUHkhr2S33Drv7iRvQwcPNr6d60mm6FrqWPuiDHh7QD5RaOSPA6/4eSydkelz+qdd+0x5pH/upW5
	H1h1QhUw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1svBkb-0000000GmBg-3lQn;
	Mon, 30 Sep 2024 08:27:26 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 1D4CB300754; Mon, 30 Sep 2024 10:27:26 +0200 (CEST)
Date: Mon, 30 Sep 2024 10:27:26 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	alyssa.milburn@intel.com, scott.d.constable@intel.com,
	Joao Moreira <joao@overdrivepizza.com>,
	Andrew Cooper <andrew.cooper3@citrix.com>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	"Jose E. Marchesi" <jose.marchesi@oracle.com>,
	"H.J. Lu" <hjl.tools@gmail.com>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Sami Tolvanen <samitolvanen@google.com>,
	Nathan Chancellor <nathan@kernel.org>, ojeda@kernel.org,
	Kees Cook <kees@kernel.org>
Subject: Re: [PATCH 11/14] llvm: kCFI pointer stuff
Message-ID: <20240930082726.GF5594@noisy.programming.kicks-ass.net>
References: <20240927194856.096003183@infradead.org>
 <20240927194925.498161564@infradead.org>
 <CAADnVQKQED2pit_DcpDWPuueHH3RLXe4pB++tU888EU=8UrNpA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAADnVQKQED2pit_DcpDWPuueHH3RLXe4pB++tU888EU=8UrNpA@mail.gmail.com>

On Sun, Sep 29, 2024 at 10:53:05AM -0700, Alexei Starovoitov wrote:

> > +  // Extend the kCFI meta-data with a byte that has a bit set for each argument
> > +  // register that contains a pointer. Specifically for x86_64, which has 6
> > +  // argument registers:
> > +  //
> > +  //   bit0 - rdi
> > +  //   bit1 - rsi
> > +  //   bit2 - rdx
> > +  //   bit3 - rcx
> > +  //   bit4 - r8
> > +  //   bit5 - r9
> > +  //
> > +  // bit6 will denote any pointer on stack (%rsp), and all 7 bits set will
> > +  // indicate vararg or any other 'unknown' configuration. Leaving bit7 for
> > +  // error states.
> > +  //
> > +  // XXX: should be conditional on some new x86_64 specific 'bhi' argument.
> > +  EmitAndCountInstruction(MCInstBuilder(X86::MOV8ri)
> > +                 .addReg(X86::AL)
> > +                 .addImm(getKCFIPointerArgs(F)));
> 
> If I'm reading this correctly it will be an 8-bit move which
> doesn't clear upper bits.
> If consumer is in assembly it's ok-ish,
> but it's an argument to __bhi_args_foo functions,
> so should be properly zero extended per call convention.

These kCFI 'instructions' are never executed. Their sole purpose is to
encode the immediates. They are instructions because they live in .text
and having them this way makes disassemly work nicely. As such, we've
taken to using the 1 byte move instruction to carry them with the least
amounts of bytes.

The consumer is the kernel instruction decoder, we take the immediate
and use that.

