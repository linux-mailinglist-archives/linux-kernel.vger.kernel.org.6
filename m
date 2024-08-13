Return-Path: <linux-kernel+bounces-285165-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EF81950A07
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 18:21:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3242A1C2040D
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 16:21:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDD501A0AF7;
	Tue, 13 Aug 2024 16:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Mh1M55+i";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="tqRyrMnt"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D25561FCF
	for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 16:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723566081; cv=none; b=jb/7nHCSTRRd6zfAoeN/lvQbd5t/8e3Kh28eQqNBiObJyNth5FHATKioOlvuMaAOqr4dnmdMfoIdgmpfQ6RFxAdylYVBu4463RY4ZWE7I69IL0YatW+NNGu1GOGOTg7Ekxvn/pIMqYphcY6Tvg5fOqmfFDP9YJjzZC7AMS9gqng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723566081; c=relaxed/simple;
	bh=ec2Y88GKcqBElDXZQ6VXSShsweGwMpQ7ZAAIeymdwO4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=F3vTy2n3AQGgRKixuzg4rvxZ9y9M/+S07Cy8mmPdq0IJ2r79oG4JJ4ajtv0iiDKBs3IT8VMh1AFATUeGp8idn7Gw1iFQnSyLhhZ+NrEl6RWtHMgUU6C9B75hGUaE1TO57kJT3wiIhpVAYQm4vOAa4wZ6/b07jOmb3/fIRzcJZ7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Mh1M55+i; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=tqRyrMnt; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1723566077;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HAKPHQsZux3wxh3xmm9uAGYbZH+n0Hgy3pKz2mw64e8=;
	b=Mh1M55+iPTITmaz0wpIGxowXK8eNbjXOy/FeL6nSbilYCTBL79iHv5fitogHZ19EycP1Nh
	Wb97+9vDO/bBHwqLd4izptTTXnx47hAfsXHp+Df4OgC9MoO22kqnYI43mkcg4MnUJOREkm
	A9Nm5/3XNYja5HXx+lVxvZ7o6dmBsZSRABvwxz1MjU1niaU9hzil8ETw6QVpTFg+xTdFMH
	5uFGiJGhYAxDdw36suwo8RIMC+flOl9SSbHfgBH/zCdc1DGxSHFS6TrYdYhWpCnGTu4RNX
	4VTrPmk22P358fkhIByixsnUVcDbAUbZ9RZ+SpBccOsP5iih30GyHkPy1IbLGQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1723566077;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HAKPHQsZux3wxh3xmm9uAGYbZH+n0Hgy3pKz2mw64e8=;
	b=tqRyrMntA5wH1A86GziXKM1W3AY6SIzu+8ps+KhvIFX/xVcRaaZ8DD4xtE3ji+32KDJSeE
	i0yQCzJL9ESY1PAA==
To: Daniel Thompson <daniel.thompson@linaro.org>
Cc: Florian Rommel <mail@florommel.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 "H . Peter Anvin" <hpa@zytor.com>, Jason Wessel
 <jason.wessel@windriver.com>, Douglas Anderson <dianders@chromium.org>,
 Lorena Kretzschmar <qy15sije@cip.cs.fau.de>, Stefan Saecherl
 <stefan.saecherl@fau.de>, Peter Zijlstra <peterz@infradead.org>,
 Christophe JAILLET <christophe.jaillet@wanadoo.fr>, Randy Dunlap
 <rdunlap@infradead.org>, Masami Hiramatsu <mhiramat@kernel.org>, Andrew
 Morton <akpm@linux-foundation.org>, Christophe Leroy
 <christophe.leroy@csgroup.eu>, Geert Uytterhoeven
 <geert+renesas@glider.be>, kgdb-bugreport@lists.sourceforge.net,
 x86@kernel.org, linux-kernel@vger.kernel.org, Kees Cook <kees@kernel.org>
Subject: Re: [PATCH v2 2/2] x86/kgdb: fix hang on failed breakpoint removal
In-Reply-To: <20240813113147.GA6016@aspen.lan>
References: <20240812174338.363838-1-mail@florommel.de>
 <20240812174338.363838-3-mail@florommel.de> <871q2tsbaq.ffs@tglx>
 <20240813113147.GA6016@aspen.lan>
Date: Tue, 13 Aug 2024 18:21:16 +0200
Message-ID: <87wmkkpf5v.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Daniel!

On Tue, Aug 13 2024 at 12:31, Daniel Thompson wrote:
> On Mon, Aug 12, 2024 at 11:04:13PM +0200, Thomas Gleixner wrote:
>> Btw, kgdb_skipexception() is a gross nisnomer because it rewinds the
>> instruction pointer to the exception address and does not skip anything,
>> but that's an orthogonal issue though it could be cleaned up along the
>> way...
>
> kgdb_skipexception() is not a directive from debug core to architecture.
> It is a question to the archictecture: should the debug core skip normal
> debug exception handling and resume immediately?.

Ah. This code is so exceptionally intuitive ....

> It allows an architecture to direct the debug core to ignore a spurious
> trap that, according to the comments, can occur on some
> (micro)architectures when we have already restored the original
> not-a-breakpoint instruction.

Potentially due to the lack of sync_core() after the copy.

And of course the removal can fail as Florian discussed.

> Florian's patch changes things so that we will also skip debug exception
> handling if we can successfully poke to the text section. I don't think
> it is sufficient on its own since the text_mutex could be owned by the
> core that is stuck trapping on the int3 that we can't remove.

I was asking exactly that:

>  What guarantees the release of text mutex?

:)

>> Aside of that the same problem exists on PowerPC.  So you can move the
>> attempt to remove the breakpoint into the generic code, no?
>
> Getting the debug core to track breakpoints that are stuck on would be a
> good improvement.
>
> We would be able to use that logic to retry the removal of stuck
> breakpoint once other SMP cores are running again. That would be great
> for architectures like arm64 that use spin-with-irqsave locking in their
> noinstr text_poke() machinery.
>
> However it won't solve the problem for x86 since it uses mutex locking.
>
> A partial solution might be to get kgdb_arch_remove_breakpoint() to
> disregard the text_mutex completely if kdb_continue_catastrophic is set
> (and adding stuck breakpoints to the reasons to inhibit a continue).

The interrupted owner of text_mutex might be in the middle of modifying
the poking_mm page tables or in the worst case modifying the code which
kgdb wants to play with.

Dragons are guaranteed.

> This is a partial solution in the sense that it is not safe: we will
> simply tell the kernel dev driving the debugger that they are
> responsible for the safety of the continue and then disable the safety
> rails.
>
> I haven't yet come up with a full fix that doesn't require
> text_poke_kgdb() to not require text_mutex to be free. I did note that
> comment in __text_poke() that says calling get_locked_pte() "is not
> really needed, but this allows to avoid open-coding" but I got a bit lost
> trying to figure out other locks and nesting concerns.

So there are no other locks involved. The PTE lock is not strictly
required because the access to poking_mm is fully serialized.

You'd need to add a separate kgdb_poking_mm and kgdb_poking_addr. Now
make __text_poke() take a @mm and @pokeaddr argument and let it operate
on them. But that solves only part of the problem:

   1) A concurrent modification of the same code will result in
      undefined behaviour. Not sure whether that's actually an issue,
      but I would not bet on it.

   2) switch_mm() and the related code are not reentrancy safe either

   3) TLB flushing. That can't use tlb_flush_mm_range() simply because
      that's not reentrant.

Which makes me wonder about #2. As this stuff can run in NMI context,
then even if text_mutex is uncontended, then tlb_flush_mm_range() might
be what had been interrupted, so reentrancy would be fatal. 

That's all a horrorshow as you can't play with CR0.WP either at least
not when CR4.CET is set.

So if you can force disable CET when KGDB is enabled, then you might get
away with:

     bp->code = *p;
     clear_cr0_wp();
     *p = int3;
     set_cr0_wp();

Though the hardening people might not be really happy about this.

But let's take a step back. Installing a breakpoint is done by the
debugger. The debugger knows the original code, right?

So why cant the debugger provide a trampoline:

   ORIG_OP		// with fixed up displacements
   JMP NEXT_INSN

Now you stick that into a trampoline page slot and then patch the INT3
in. Now on removal can be a two stage approach:

    bp->state = INACTIVE;
    kick_breakpoint_gc();

breakpoint_gc() removes the breakpoint and invalidates the trampoline
from a safe context and up to that point kgdb_skipexception() can do:

bool kgdb_skip_exception(int exception, struct pt_regs *regs)
{
	  struct kgdb_bkpt *bp;

	  if (exception != 3)
		  return false;

	  bp = kgdb_get_inactive_breakpoint(--regs->ip, BP_BREAKPOINT);
	  if (bp)
                    regs->ip = bp->trampoline;
          return true;
}

Hmm?

Thanks,

        tglx

