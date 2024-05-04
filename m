Return-Path: <linux-kernel+bounces-168760-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 604BC8BBD47
	for <lists+linux-kernel@lfdr.de>; Sat,  4 May 2024 18:48:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 167D2280ED4
	for <lists+linux-kernel@lfdr.de>; Sat,  4 May 2024 16:48:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33B7E5A117;
	Sat,  4 May 2024 16:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qQ0ytSik"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77A2A1BF3F
	for <linux-kernel@vger.kernel.org>; Sat,  4 May 2024 16:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714841300; cv=none; b=HAYQByS+E7jxWk7nig+uzsnGkk4aUb8yoOo/WT7e0CP0MxB+Vr1Kf9mRaCzFqGFylKRRGAa48y2ckkE1YGPiCpO6oGK2Ck/KJCCoO70ppZQT2McZhXEfU56/mKd5zrzOeBq2d+2eZFSIENacPrZP5eK0c/QKPUuLGwxoeEnMdUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714841300; c=relaxed/simple;
	bh=hzmuApgUeE9+Dxlg8pNgJTMxe+ZT+sG3KcYHyhAHSWY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iiy9KnJGY9QYPNeqDfZCOExR7UHCb1FuNK4DVLB/o7czVhR1uflQWV+Eb8js++N09zMuKOXBaf7vZUhsMKwtTXyyvUWadqrrOHHYTNQhw/jTaT3K8BlEBewMynRYXZEOz/xopLRe9sAMiPOjKlFyKVYCSFjDoNnYmSzm94NBI/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qQ0ytSik; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F4214C072AA;
	Sat,  4 May 2024 16:48:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714841300;
	bh=hzmuApgUeE9+Dxlg8pNgJTMxe+ZT+sG3KcYHyhAHSWY=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=qQ0ytSik8cZamdTyhd2rYvF/01WFzKWLgMq3mtTlNU4FAa3IpbyoXmm9xMiHf1ctq
	 GFXXlrgE0jiz842g+zyYbvkv4sQzJRGz0kfShLc9a1Isn9BLCiLGhezm5wT9UFub7K
	 bIMSPrxwqM3O4KV5URi5ZKgFEFK+3SPcJsR+lG6SP19Wsp39Ewf8baddE/+ke33kRV
	 EObMj1fy+4uv8CGRJeMIkcE6dG7RbCllnN1ajVecjHOT/nqZYMSXLFah2VIMjNpQhP
	 52ToIlvI1dH/lo3UwCoVpSojr2YL2Qf4h8BT1pBvOWWhlRiHuXjOZwvC1Q0WjZhYyh
	 XWXmVMFLzIk+Q==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 994BDCE0C56; Sat,  4 May 2024 09:48:19 -0700 (PDT)
Date: Sat, 4 May 2024 09:48:19 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Daniel Sneddon <daniel.sneddon@linux.intel.com>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Alexandre Chartre <alexandre.chartre@oracle.com>,
	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sean Christopherson <seanjc@google.com>,
	Andrew Cooper <andrew.cooper3@citrix.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Nikolay Borisov <nik.borisov@suse.com>,
	KP Singh <kpsingh@kernel.org>, Waiman Long <longman@redhat.com>,
	Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH v4 3/5] x86/syscall: Mark exit[_group] syscall handlers
 __noreturn
Message-ID: <8c2d9a20-d3ff-4cdb-946a-2651ee37e272@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <3b99cb2919c88ab3d353337423b2f0f1b9173f0a.1713559768.git.jpoimboe@kernel.org>
 <0c410ba5-0e42-43b6-80b8-a69c5419a97d@paulmck-laptop>
 <20240421052540.w7gtahoko2qerhqq@treble>
 <CAJzB8QF_+51+rrJmq3iXkaAbmbbyKYVf0m_LpQCRSLS_FgHUMQ@mail.gmail.com>
 <CAJzB8QFx344hSSYy4jigtmQX+KfSpFOn+18WAfZAeym5LUMoKg@mail.gmail.com>
 <CAJzB8QFxfCCYTMfEYidB+PYvDV5J2zbdsnpyQR-gS-D-0y2gEA@mail.gmail.com>
 <20240503195653.5wkdfwno7nybepqc@treble>
 <20240503204417.2kxp2i3xjdmtapxq@treble>
 <a8d0a893-25ec-4119-abb5-c65adda51b49@paulmck-laptop>
 <20240503234834.y3gfp5qthporsx7m@treble>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240503234834.y3gfp5qthporsx7m@treble>

On Fri, May 03, 2024 at 04:48:34PM -0700, Josh Poimboeuf wrote:
> On Fri, May 03, 2024 at 04:33:00PM -0700, Paul E. McKenney wrote:
> > Does arch/x86/entry/syscall_32.c need the following additional patch?
> > 
> > A quick smoke test passes, but perhaps I am just getting lucky...
> > 
> > 							Thanx, Paul
> > 
> > ------------------------------------------------------------------------
> > 
> > diff --git a/arch/x86/entry/syscall_32.c b/arch/x86/entry/syscall_32.c
> > index aab31760b4e3e..d9ae910ea6f33 100644
> > --- a/arch/x86/entry/syscall_32.c
> > +++ b/arch/x86/entry/syscall_32.c
> > @@ -14,9 +14,13 @@
> >  #endif
> >  
> >  #define __SYSCALL(nr, sym) extern long __ia32_##sym(const struct pt_regs *);
> > +#define __SYSCALL_NORETURN(nr, sym) extern long __noreturn __ia32_##sym(const struct pt_regs *);
> >  #include <asm/syscalls_32.h>
> >  #undef __SYSCALL
> >  
> > +#undef __SYSCALL_NORETURN
> > +#define __SYSCALL_NORETURN __SYSCALL
> > +
> >  #define __SYSCALL(nr, sym) __ia32_##sym,
> >  const sys_call_ptr_t ia32_sys_call_table[] = {
> >  #include <asm/syscalls_32.h>
> 
> Ah, yeah, that looks right.

And the overnight testing went well, so...

For your three patches and this one:

Tested-by: Paul E. McKenney <paulmck@kernel.org>

