Return-Path: <linux-kernel+bounces-284656-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4FD89503B7
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 13:32:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D4A7E1C220A4
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 11:32:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4FFD1991B1;
	Tue, 13 Aug 2024 11:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gbHQ7U4f"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05B2D198E90
	for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 11:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723548714; cv=none; b=WFEj88JOi74SesQUnIJEc0TLTZ5PBAb15IiG/+32FdKBWkJ0FJQNGH+NwlLUbRcJ/Q4/I3hoxDj1t2vjnHqZKc/m6M2nOfMUsjDduxFejHwYXvWiZBZkm2Tgmk6F/fm/q2jfhcIbBfIDhRChMaLACdi17ByuAfZtTSw1/aARBS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723548714; c=relaxed/simple;
	bh=bKJN58332eEPwHmuuCZBeW+iQklNzLnXOqXG/o8tp6A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mQdYtDtfhPt3v9yFY8GKzM49RlF8WWMHzREi/vEI9srpAKBxzEY9y1HlXedp+NsBBPJGIHCJSpFf3fStF+hibCzTYgslnMnK65w1upNZ6TZHyHjtSpeQZIxHhdATAPoEWa0fXZVsE4PAq+vNEJiLiC/1RTstNGXBPayOsrnRhoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=gbHQ7U4f; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4281c164408so39911115e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 04:31:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1723548710; x=1724153510; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Gs9stsBHW0oE3faAYAhWRtfdBQIXzmozHZWQfxW+8lc=;
        b=gbHQ7U4fb4M+jQiEcUCTRArQepL6TxFOXd0eTBD11Yw0HSAem9HrZgU229n2Opecbj
         fLYKVVVwNPgUi5/AvYcJFD2hc+FOdydEkpd5TASDzRi+ZooyI0kdlJtUvzoFnTqYk11N
         oBfdC+zL1fB+73ZVGXEeR8RbXGtS0vNvuwjUUos9xExCS+Bfq6aLQNlBHOtPOsgc7HN1
         INBMycAeTOUo+2s+i+1oEHarSK13QPUIQ4BDJrHRICvOvPW6vxde2xu1SfWAqTacHY6P
         1ZSZy4Iq1XRvoeRFigBojL1pdgAlCaR826qqs3JY4ODYXDhcfKGpGQqvMM8slpcDFikF
         xZeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723548710; x=1724153510;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Gs9stsBHW0oE3faAYAhWRtfdBQIXzmozHZWQfxW+8lc=;
        b=UoIia7VFX1Oh2uegY53n5/dV3wzXPmzSafHDQoo74+uLFDVLvq4YzLaKHGKbHC8Epx
         K84P4slQQLV9jN6wAKMucecO+urCYjCbnFCkisCYHKw8c52gM7GtFjJIzUCo8ok1CXe5
         dqLgq8uBuxKV/EoZxAcaXQIHR7nTWzRfUGrJki+LCbFfb1jMiMbWzsgaof/dW/wtihb9
         WtADIZ+IGiSpMzRCe7PqX3Dp7AUblbzEzm8uj6FY91YbmxR02XnjSf4ZYtSZYTEyBfx7
         HBI2uGEGc2/aTB3EAqbdO9VNqRO9wXwCUS8GgJ60sFLkXFydULXsxjOV1VS9B0u7+uZG
         6/7w==
X-Forwarded-Encrypted: i=1; AJvYcCVxlGi3kIS9vbSmYrUULIMZS6BcyN0Onng9tDnSfg08kore1tLMTyHkaWQq+BBCuK3CIIcX923qsiI2EcaRRNyLKSBMbQT+b4lIUsyc
X-Gm-Message-State: AOJu0Yx35HX1lXSsmIMvXvSfwEYwVkBibB5iK3ugcpAHOn2VphzGMRi3
	DmDiv0qG30+59ktRvsVtgdgDDjTgE060oXFAt/nAFFgQKz8UaY2aBUc32mvLemo=
X-Google-Smtp-Source: AGHT+IHQlvfEGqaODA7diW4pLtkWS6mwQ+sPk5IQb2adhJT6xoj7fDrXZBIaRH1x9Ak/K+6DiUFhRA==
X-Received: by 2002:a05:600c:3b8f:b0:426:5b29:b5c8 with SMTP id 5b1f17b1804b1-429d486e809mr25229855e9.28.1723548710225;
        Tue, 13 Aug 2024 04:31:50 -0700 (PDT)
Received: from aspen.lan (aztw-34-b2-v4wan-166919-cust780.vm26.cable.virginm.net. [82.37.195.13])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4293e41496dsm199444885e9.23.2024.08.13.04.31.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Aug 2024 04:31:49 -0700 (PDT)
Date: Tue, 13 Aug 2024 12:31:47 +0100
From: Daniel Thompson <daniel.thompson@linaro.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Florian Rommel <mail@florommel.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H . Peter Anvin" <hpa@zytor.com>,
	Jason Wessel <jason.wessel@windriver.com>,
	Douglas Anderson <dianders@chromium.org>,
	Lorena Kretzschmar <qy15sije@cip.cs.fau.de>,
	Stefan Saecherl <stefan.saecherl@fau.de>,
	Peter Zijlstra <peterz@infradead.org>,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Randy Dunlap <rdunlap@infradead.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	kgdb-bugreport@lists.sourceforge.net, x86@kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] x86/kgdb: fix hang on failed breakpoint removal
Message-ID: <20240813113147.GA6016@aspen.lan>
References: <20240812174338.363838-1-mail@florommel.de>
 <20240812174338.363838-3-mail@florommel.de>
 <871q2tsbaq.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <871q2tsbaq.ffs@tglx>

On Mon, Aug 12, 2024 at 11:04:13PM +0200, Thomas Gleixner wrote:
> Florian!
>
> On Mon, Aug 12 2024 at 19:43, Florian Rommel wrote:
> > On x86, occasionally, the removal of a breakpoint (i.e., removal of
> > the int3 instruction) fails because the text_mutex is taken by another
> > CPU (mainly due to the static_key mechanism, I think).
>
> Either you know it or not. Speculation is reserved for CPUs.
>
> > The function kgdb_skipexception catches exceptions from these spurious
> > int3 instructions, bails out of KGDB, and continues execution from the
> > previous PC address.
> >
> > However, this led to an endless loop between the int3 instruction and
> > kgdb_skipexception since the int3 instruction (being still present)
> > triggered again.  This effectively caused the system to hang.
> >
> > With this patch, we try to remove the concerned spurious int3
> > instruction in kgdb_skipexception before continuing execution.  This
> > may take a few attempts until the concurrent holders of the text_mutex
> > have released it, but eventually succeeds and the kernel can continue.
>
> What guarantees the release of text mutex?
>
> > Signed-off-by: Florian Rommel <mail@florommel.de>
> > ---
> >  arch/x86/kernel/kgdb.c | 24 ++++++++++++++++++++++++
> >  1 file changed, 24 insertions(+)
> >
> > diff --git a/arch/x86/kernel/kgdb.c b/arch/x86/kernel/kgdb.c
> > index 64c332151af7..585a7a72af74 100644
> > --- a/arch/x86/kernel/kgdb.c
> > +++ b/arch/x86/kernel/kgdb.c
> > @@ -723,7 +723,31 @@ void kgdb_arch_exit(void)
> >  int kgdb_skipexception(int exception, struct pt_regs *regs)
>
> Btw, kgdb_skipexception() is a gross nisnomer because it rewinds the
> instruction pointer to the exception address and does not skip anything,
> but that's an orthogonal issue though it could be cleaned up along the
> way...

kgdb_skipexception() is not a directive from debug core to architecture.
It is a question to the archictecture: should the debug core skip normal
debug exception handling and resume immediately?.

It allows an architecture to direct the debug core to ignore a spurious
trap that, according to the comments, can occur on some
(micro)architectures when we have already restored the original
not-a-breakpoint instruction.

Florian's patch changes things so that we will also skip debug exception
handling if we can successfully poke to the text section. I don't think
it is sufficient on its own since the text_mutex could be owned by the
core that is stuck trapping on the int3 that we can't remove.


> >  {
> >  	if (exception == 3 && kgdb_isremovedbreak(regs->ip - 1)) {
> > +		struct kgdb_bkpt *bpt;
> > +		int i, error;
> > +
> >  		regs->ip -= 1;
> > +
> > +		/*
> > +		 * Try to remove the spurious int3 instruction.
> > +		 * These int3s can result from failed breakpoint removals
> > +		 * in kgdb_arch_remove_breakpoint.
> > +		 */
> > +		for (bpt = NULL, i = 0; i < KGDB_MAX_BREAKPOINTS; i++) {
> > +			if (kgdb_break[i].bpt_addr == regs->ip &&
> > +			    kgdb_break[i].state == BP_REMOVED &&
> > +			    (kgdb_break[i].type == BP_BREAKPOINT ||
> > +			     kgdb_break[i].type == BP_POKE_BREAKPOINT)) {
> > +				bpt = &kgdb_break[i];
> > +				break;
> > +			}
> > +		}
>
> Seriously? The KGBD core already walked that array in
> kgdb_isremovedbreak() just so you can walk it again here.
>
> struct kkgdb_bkpt *kgdb_get_removed_breakpoint(unsigned long addr)
> {
>         struct kgdb_bkpt *bp = kgdb_break;
>
> 	for (int i = 0; i < KGDB_MAX_BREAKPOINTS; i++, bp++) {
> 		if (bp>.state == BP_REMOVED && bp->kgdb_bpt_addr == addr)
> 			return bp;
> 	}
> 	return NULL;
> }
>
> bool kgdb_isremovedbreak(unsigned long addr)
> {
>         return !!kgdb_get_removed_breakpoint(addr);
> }
>
> bool kgdb_rewind_exception(int exception, struct pt_regs *regs)
> {
>         struct kgdb_bkpt *bp;
>
> 	if (exception != 3)
>         	return false;
>
>         bp = kgdb_get_removed_breakpoint(--regs->ip);
>         if (!bp || !bp->type == BP_BREAKPOINT)
>         	return false;
>
> Hmm?
>
> > +		error = kgdb_arch_remove_breakpoint(bpt);
> > +		if (error)
> > +			pr_err("skipexception: breakpoint remove failed: %lx\n",
> > +			       bpt->bpt_addr);
>
> Lacks curly brackets. See Documentation.
>
> 	return !error;
>
> Aside of that the same problem exists on PowerPC.  So you can move the
> attempt to remove the breakpoint into the generic code, no?

Getting the debug core to track breakpoints that are stuck on would be a
good improvement.

We would be able to use that logic to retry the removal of stuck
breakpoint once other SMP cores are running again. That would be great
for architectures like arm64 that use spin-with-irqsave locking in their
noinstr text_poke() machinery.

However it won't solve the problem for x86 since it uses mutex locking.

A partial solution might be to get kgdb_arch_remove_breakpoint() to
disregard the text_mutex completely if kdb_continue_catastrophic is set
(and adding stuck breakpoints to the reasons to inhibit a continue).
This is a partial solution in the sense that it is not safe: we will
simply tell the kernel dev driving the debugger that they are
responsible for the safety of the continue and then disable the safety
rails.

I haven't yet come up with a full fix that doesn't require
text_poke_kgdb() to not require text_mutex to be free. I did note that
comment in __text_poke() that says calling get_locked_pte() "is not
really needed, but this allows to avoid open-coding" but I got a bit lost
trying to figure out other locks and nesting concerns.


Daniel.


[1] I try to avoid calling them "users" because

