Return-Path: <linux-kernel+bounces-318978-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D116196F616
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 15:58:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3F271B21AFD
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 13:58:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D8D01CF290;
	Fri,  6 Sep 2024 13:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="dVuEmOKn"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F80D1A270
	for <linux-kernel@vger.kernel.org>; Fri,  6 Sep 2024 13:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725631072; cv=none; b=BlTgztXtiGD19JjskA/ylBG5Qs8WG9Wk6NCiAUpye7tzS0yoCH9dej7K+Hn3tbGqrtYehJpOgy33/ojIBMZ8D9YFylB3MUurd2DW70f5IEB07rvPhxRs8igmq7yz7NrbpAowX9rrKtGnoIKq3P2SrQf47XL16emWwaTjyPeYoV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725631072; c=relaxed/simple;
	bh=bOIQkqX7zxu/ddPCTuOPMwTM0hvwuejCP9PBAec6rcY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YIcyGWs9VrG9Xr/7VdKKL4MufbyCtJT8Jev3SisLKWXDrzBrQjgh3hPfrM3Sr96kVqKLqLbmW6NeTdpriBkvIG1w8alRNsHr61u1Vm2G4YULdYwhhlJu/QJL0WPZ2IipURDBHJJK4h9O1suAbZU8z/b0HdB1jz/vnGZzc42m0ic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b=dVuEmOKn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2359FC4CEC4;
	Fri,  6 Sep 2024 13:57:51 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="dVuEmOKn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1725631069;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=eVji+rszu06foO1e6CakulF0N2byoXPnMimNShIBYe8=;
	b=dVuEmOKn0Yk1JiHrrco01DA24HYjdC4awNSSHS0nKBUqxoGoEpbDurNaBcgVQe9c6erqgC
	cpt0f0OdgGsXdAX9CNZP0my5WgLzZCXLvvvnixo05G7SV/XHJ/BOTRxM2DsZ0v/4Z6Xh58
	qG8+xmK/ZQCVWqiIoCggTBYekd+LAps=
Received: 
	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id ca54950d (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 6 Sep 2024 13:57:49 +0000 (UTC)
Date: Fri, 6 Sep 2024 15:57:47 +0200
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>,
	linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	Nicholas Piggin <npiggin@gmail.com>,
	Naveen N Rao <naveen@kernel.org>,
	Vincenzo Frascino <vincenzo.frascino@arm.com>,
	Andrei Vagin <avagin@gmail.com>
Subject: Re: [PATCH 1/2] powerpc/vdso: Fix VDSO data access when running in a
 non-root time namespace
Message-ID: <ZtsKW3LLfwmz7icC@zx2c4.com>
References: <700dbf296d02e32376329774be35cfbead08041d.1725611321.git.christophe.leroy@csgroup.eu>
 <87r09x3r9v.fsf@mail.lhotse>
 <ZtsG9Q6vKD9XOsZN@zx2c4.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZtsG9Q6vKD9XOsZN@zx2c4.com>

On Fri, Sep 06, 2024 at 03:43:17PM +0200, Jason A. Donenfeld wrote:
> On Fri, Sep 06, 2024 at 10:23:08PM +1000, Michael Ellerman wrote:
> > Christophe Leroy <christophe.leroy@csgroup.eu> writes:
> > > When running in a non-root time namespace, the global VDSO data page
> > > is replaced by a dedicated namespace data page and the global data
> > > page is mapped next to it. Detailed explanations can be found at
> > > commit 660fd04f9317 ("lib/vdso: Prepare for time namespace support").
> > >
> > > When it happens, __kernel_get_syscall_map and __kernel_get_tbfreq
> > > and __kernel_sync_dicache don't work anymore because they read 0
> > > instead of the data they need.
> > >
> > > To address that, clock_mode has to be read. When it is set to
> > > VDSO_CLOCKMODE_TIMENS, it means it is a dedicated namespace data page
> > > and the global data is located on the following page.
> > >
> > > Add a macro called get_realdatapage which reads clock_mode and add
> > > PAGE_SIZE to the pointer provided by get_datapage macro when
> > > clock_mode is equal to VDSO_CLOCKMODE_TIMENS. Use this new macro
> > > instead of get_datapage macro except for time functions as they handle
> > > it internally.
> > >
> > > Fixes: 74205b3fc2ef ("powerpc/vdso: Add support for time namespaces")
> > > Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
> >  
> > Oops.
> > 
> > I guess it should also have:
> > 
> >   Cc: stable@vger.kernel.org # v5.13+
> >   Reported-by: Jason A. Donenfeld <Jason@zx2c4.com>
> >   Closes: https://lore.kernel.org/all/ZtnYqZI-nrsNslwy@zx2c4.com/
> > 
> > Jason how do you want to handle this?
> > 
> > I can put patch 1 in a topic branch that we both merge? Then you can
> > apply patch 2 on top of that merge in your tree.
> > 
> > Or we could both apply patch 1 to our trees, it might lead to a conflict
> > but it wouldn't be anything drastic.
> 
> The merge window for 6.12 is pretty soon. Why don't I just take this in
> my random.git tree (with your ack) as a prereq to the ppc vDSO work.
> It'll slide in _before_ Christophe's other commits, and then the
> separate vgetrandom fixup will be squashed in the right place there.
> 
> And then it'll hit stable when that's submitted for 6.12. It's an old
> bug that nobody noticed, and time namespaces are kind of obscure, so I
> think waiting a week and a half for the merge window to open is probably
> fine.

So I've just done this (preliminarily, pending Michael's approval), and
it comes out decently clean and everything works fine. The commit
sequence becomes:

...
c206cd11e7f2 selftests: vDSO: ensure vgetrandom works in a time namespace
...
e59cc170924c powerpc/vdso: Fix VDSO data access when running in a non-root time namespace
887e7a77dc99 mm: Define VM_DROPPABLE for powerpc/32
f2ee39ec52c2 powerpc/vdso32: Add crtsavres
994148e87080 powerpc/vdso: Refactor CFLAGS for CVDSO build
c49ec121a6dd powerpc/vdso: Wire up getrandom() vDSO implementation on VDSO32 <-- fixed up
a8a5e16cde32 powerpc/vdso: Wire up getrandom() vDSO implementation on VDSO64

So I'm happy with this.

Jason

