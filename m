Return-Path: <linux-kernel+bounces-343566-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CFC3989CB0
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 10:23:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B1D44B24F66
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 08:23:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0A1F175D4C;
	Mon, 30 Sep 2024 08:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="eG+SaZwg"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DB654204B
	for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 08:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727684604; cv=none; b=E05TV3nemVypYl59ADoeHuVH2z1ZiikwVML6fUFZkutoL8DJfRsr3qVjZjW0540lS8XLlS6gkwaig2Avjjm4BwImNn9+I3fCUPqjcOrt12aYJZJqbVQTf7EoZS7g2dIWEHLLCeR2iIImYu6qGy3xyqVsFZz+GWBoUhBUyn+kM3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727684604; c=relaxed/simple;
	bh=5IeQZYmKWVwVpXF2ge65ifJ5soS1TAgFApejTBwvtuU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CyBn4ofKmrs2ATj26KbDhFR7GeElIYAiYMIz6B7qdup7IfAC2MGLFATjmeotUTjKE3UPGm1erfDnBnr6/Bl0UnqKgGvG5aGog1XbkapZjIyahpgT0I5UqFLbPQ5b1RK+5OQir9Jhz6p7bJiKUAmQ+HhNR3yP+deGvxw+hnuHzzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=eG+SaZwg; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=DDMtqsfYVHp17n3EhjNXbAlMnq1kFjC/saio3kxltlk=; b=eG+SaZwgUYoHhWKEApSA+FmitE
	vLS8fAAADpPG+OQIxJNq4pbYoyhj3d0Zp5X7N7W1kAu9XaXuumylXjJ+4rIO03DdULuM04w9mXdsq
	qjn35QaAnOgWHYTM0vXLfHdqp6EjDMuQeYa7xAhQbE4em5l2oUXd5wSPJlMIF3nejlDjrWQXguZ2b
	EEe4yInYLpZxzl9mywuU8Y980Y/Mqap1mLgGw4ujJ6i1yGHwur1VO2HWKHsQcjKzHkENoqlkuPJZ1
	2hHqHq0gfKbY4Z/cSzOEITY8O1ga/qc6XQK33MO6pjMoGNOXoJrtBPJlSAeg7tuNuzIKsW2QMcDPi
	DLfpV2MA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1svBgY-0000000GliN-0vod;
	Mon, 30 Sep 2024 08:23:15 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 3F545300754; Mon, 30 Sep 2024 10:23:14 +0200 (CEST)
Date: Mon, 30 Sep 2024 10:23:14 +0200
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
Subject: Re: [PATCH 09/14] x86/ibt: Implement IBT+
Message-ID: <20240930082314.GE5594@noisy.programming.kicks-ass.net>
References: <20240927194856.096003183@infradead.org>
 <20240927194925.283644921@infradead.org>
 <CAADnVQ+qDAzjyRuN6sdpw8RjB4XQ1EyyMJ_uYXeDspbW58fC3A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAADnVQ+qDAzjyRuN6sdpw8RjB4XQ1EyyMJ_uYXeDspbW58fC3A@mail.gmail.com>

On Sun, Sep 29, 2024 at 10:38:58AM -0700, Alexei Starovoitov wrote:
> On Fri, Sep 27, 2024 at 12:50 PM Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > --- a/arch/x86/net/bpf_jit_comp.c
> > +++ b/arch/x86/net/bpf_jit_comp.c
> > @@ -555,6 +555,8 @@ static int emit_patch(u8 **pprog, void *
> >
> >  static int emit_call(u8 **pprog, void *func, void *ip)
> >  {
> > +       if (is_endbr(func))
> > +               func += ENDBR_INSN_SIZE;
> >         return emit_patch(pprog, func, ip, 0xE8);
> >  }
> >
> > @@ -562,11 +564,13 @@ static int emit_rsb_call(u8 **pprog, voi
> >  {
> >         OPTIMIZER_HIDE_VAR(func);
> >         ip += x86_call_depth_emit_accounting(pprog, func, ip);
> > -       return emit_patch(pprog, func, ip, 0xE8);
> > +       return emit_call(pprog, func, ip);
> >  }
> >
> >  static int emit_jump(u8 **pprog, void *func, void *ip)
> >  {
> > +       if (is_endbr(func))
> > +               func += ENDBR_INSN_SIZE;
> >         return emit_patch(pprog, func, ip, 0xE9);
> >  }
> 
> Makes sense, but it feels like it's fixing the existing bug
> that we somehow didn't notice earlier?

Before all this func()+0 was a valid call address -- as it's been
forever.

While it is true that with the introduction of ENDBR some compilers will
do direct calls to func()+4 to avoid the ENDBR (less instructions, more
faster etc..) this was very much an optional thing.

Notably, up until this point we would use a 4 byte NOP to seal(*)
functions, specifically so that anybody doing direct calls to func()+0
would continue to work.

These patches however change all that by sealing with a 4 byte UD1
instruction, which makes direct calls to func()+0 fatal. As such, we
must guarantee all direct calls are to func()+4. So what used to be an
optimization is now a strict requirement.

Indirect calls still go to func()+0 (or func()-16 for FineIBT) and will
go *bang* if !ENDBR or UD1 (depending on the hardware having CET/IBT
support).

(*) with sealing we mean the explicit action of disallowing indirect
calls to a given function.

