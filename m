Return-Path: <linux-kernel+bounces-197371-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 308018D69CF
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 21:33:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 519541C21382
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 19:33:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 944CB156F5D;
	Fri, 31 May 2024 19:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U7EWM7n0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D871312E68;
	Fri, 31 May 2024 19:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717184032; cv=none; b=U7G7XyHuVzdIKxIQ+QGA7sgZisNt+NCQfqMJgZZrdvdsbqTbRUt8wKJDosIBQQyCo/iZtWvG2Z49TScrlHJXd2Xglkpajqww2U771FiPkLvx2NSfvfjcuVKtIIDLK9bN466r13CozOstlWN+T80a9ZBMvV+KjXMBv2PsttVcw3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717184032; c=relaxed/simple;
	bh=ynP7rBKdIUVM0oV4Zv6jh4YhAzJrbo8yccG/vKPQ09I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WJkiNSMlFNSvUnoSXsn8pfOVWb/6UfHZ3ew6ftb9sMzlFiDieoA5ZUrXAop+b/bG8AyCkhAxmsjiGUNk/Mm9pNgOxm6E3IEArgrEPnE7T9bbQeVltn5O/Spf8G2b/9BSgRn6AlEp/TivretHdf0UumsQK0cyTLUDxfSNmhZ+o00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U7EWM7n0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71FDFC116B1;
	Fri, 31 May 2024 19:33:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717184032;
	bh=ynP7rBKdIUVM0oV4Zv6jh4YhAzJrbo8yccG/vKPQ09I=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=U7EWM7n0mEPhcNRAnvoq1IMAs5HKWT3InRTFcLbBPOKaRsPXXCOKZYmKUVD2Ma9kz
	 vD+43dVT5gjxhOSCBdvzZ85cviIP6IXlRhw5rYIjwDnEYKSa83m7T8lphvHRSRvnbJ
	 gsaCHhyKec/0+qHliKH2i2fNpiw63v9sm4vQJ76hO23YRBIewVfZMNTNCYKVLRbCwu
	 GccmvxHiOawRxox3+B54HcXPQYCfgo+4WC50+bb/xOJ2EpCrLQZZxi8+ioY9xfjJve
	 N9UNT3+YMWJe+cIZ8jbPYHa0PS7YB2wnTmn+xhFar4ZKLJdRvXSfD8fJ7qVFnOjmMR
	 v+COhJ5BG+pDQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 1DE27CE3ED6; Fri, 31 May 2024 12:33:52 -0700 (PDT)
Date: Fri, 31 May 2024 12:33:52 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: "Maciej W. Rozycki" <macro@orcam.me.uk>
Cc: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Arnd Bergmann <arnd@kernel.org>, linux-alpha@vger.kernel.org,
	Arnd Bergmann <arnd@arndb.de>,
	Richard Henderson <richard.henderson@linaro.org>,
	Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
	Matt Turner <mattst88@gmail.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Marc Zyngier <maz@kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	linux-kernel@vger.kernel.org, Michael Cree <mcree@orcon.net.nz>,
	Frank Scheiner <frank.scheiner@web.de>
Subject: Re: [PATCH 00/14] alpha: cleanups for 6.10
Message-ID: <7b0a434c-2165-45a0-8507-e7f992094705@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20240503081125.67990-1-arnd@kernel.org>
 <272a909522f2790a30b9a8be73ab7145bf06d486.camel@physik.fu-berlin.de>
 <alpine.DEB.2.21.2405280041550.23854@angie.orcam.me.uk>
 <aa397ad5-a08a-48a1-a9c0-75cfd5f6a3a5@paulmck-laptop>
 <alpine.DEB.2.21.2405291432450.23854@angie.orcam.me.uk>
 <5567ab2e-80af-4c5f-bebb-d979e8a34f49@paulmck-laptop>
 <alpine.DEB.2.21.2405310432190.23854@angie.orcam.me.uk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.2405310432190.23854@angie.orcam.me.uk>

On Fri, May 31, 2024 at 04:56:28AM +0100, Maciej W. Rozycki wrote:
> On Wed, 29 May 2024, Paul E. McKenney wrote:
> 
> > >  Mind that the read-modify-write sequence that software does for sub-word 
> > > write accesses with original Alpha hardware is precisely what hardware 
> > > would have to do anyway and support for that was deliberately omitted by 
> > > the architecture designers from the ISA to give it performance advantages 
> > > quoted in the architecture manual.  The only difference here is that with 
> > > hardware read-modify-write operations atomicity for sub-word accesses is 
> > > guaranteed by the ISA, however for software read-modify-write it has to be 
> > > explictly coded using the usual load-locked/store-conditional sequence in 
> > > a loop.  I don't think it's a big deal really, it should be trivial to do 
> > > in the relevant accessors, along with the memory barriers that are needed 
> > > anyway for EV56+ and possibly other ports such as the MIPS one.
> > 
> > There shouldn't be any memory barriers required, and don't EV56+ have
> > single-byte loads and stores?
> 
>  I should have commented on this in my original reply.
> 
>  You're the RCU expert so you know the answer.  I don't.  If it's OK for
> successive writes to get reordered, or readers to see a stale value, then 
> you don't need memory barriers.  Otherwise you do.  Whether byte accesses 
> are available or not does not matter, the CPU *will* do reordering if it's 
> allowed to (or more specifically, it won't do anything to prevent it from 
> happening, especially in SMP configurations; I can't remember offhand if 
> there are cases with UP).  Also adjacent byte writes may be merged, but I 
> suppose it does not matter, or does it?

RCU uses whichever wrapper is required.  For example, if ordering is
required, it might use smp_store_release() and smp_load_acquire().
If ordering does not matter, it might use WRITE_ONCE() and READ_ONCE().
If tearing/fusing/merging does not matter, as in there are not concurrent
accesses, it uses plain C-language loads and stores.

>  NB MIPS has similar architectural arrangements (and a bunch of barriers 
> defined in the ISA), it's just most implementations are actually strongly 
> ordered, so most people can't see the effects of this.  With MIPS I know 
> for sure there are cases of UP reordering, but they only really matter for 
> MMIO use cases and not regular memory.

Any given architecture is required to provide architecture-specific
implementations of the various functions that meet the requirements of
Linux-kernel memory model.  See tools/memory-model for more information.

							Thanx, Paul

