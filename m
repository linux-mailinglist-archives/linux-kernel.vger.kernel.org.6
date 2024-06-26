Return-Path: <linux-kernel+bounces-230076-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18039917818
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 07:28:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C6C8428187D
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 05:28:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D5811442FF;
	Wed, 26 Jun 2024 05:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eBcJYk8K"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4CED13B78F
	for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 05:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719379707; cv=none; b=YJDAxTq5Ox8uZCeXgDDg/bdYNIFzhM2ZaVMK8C0T9nxMoXF0cxP35fiCauqhjsbMt/tR/kcvijBVR3ctCdIx0IGd5Naok65VMqBF/YDUqDMyqZU8WVRVXXgB15u4lPFy2Q+Wr5HSE+EWna7Eq1fLq99XnxHiRUX5ixagVyFHilE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719379707; c=relaxed/simple;
	bh=rqvpwGnwCz/5/nM+Oyft7aY3opgZC7aeRKPqywUNgz0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l+song4O7LeiBqfOU03AAPVG/QyrXSZirbBpwl4ZVpqh/DjP5Q/GF08w83BJhS83Mb/JFeDmzkLUwjiCmXuQOxknc5lDpmUrXgE3zBrro6NVkvCL/RGZDEGKfIHsidcVhICq2VUoMdiKg9HB1Ud3bJ4ABEYoLzm+KMgV5u9ZX/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eBcJYk8K; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B129FC32782;
	Wed, 26 Jun 2024 05:28:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719379707;
	bh=rqvpwGnwCz/5/nM+Oyft7aY3opgZC7aeRKPqywUNgz0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eBcJYk8KFkywu/s+sFOzCwHlTfDaLc6knkzfZ5mgldRS6rdlBwIhSZeIPih8umtde
	 Rp2i3k661MimgzEGkTVxa7dflVYLBIyxIE9PsEgMtkegtovQnf2hWwNwYEe25urdTh
	 2+yKBhu81/9vYBJajc8nmXh4vRNyGF8jyupNESO4F1t8Oumkw5lhlXX+FRc+ko/l0P
	 4vlpdoUpNAs0pwo4WZKeflmjITHwGyigllRxs87JYrqxTivVYda5uZi+lRz+1of+PT
	 ne5QXHbhVGYfq2R8+6WjvWkC5YeGGolbuby+IEPcTuIxUIp8iF9BSaxGajzJaptg2x
	 LtCqSAjeIENsw==
Date: Tue, 25 Jun 2024 22:28:25 -0700
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: "Paul E. McKenney" <paulmck@kernel.org>
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
Subject: Re: [PATCH v5 1/3] x86/syscall: Mark exit[_group] syscall handlers
 __noreturn
Message-ID: <20240626052825.27gt6ij3fhu6iolc@treble>
References: <cover.1715059256.git.jpoimboe@kernel.org>
 <9ad251f6258adde596fb1f4d6826309b9f239ed3.1715059256.git.jpoimboe@kernel.org>
 <31af8226-8357-493e-a280-465f91b58d35@paulmck-laptop>
 <4b97c5c8-73ac-417d-8b1c-61ccd0768bda@paulmck-laptop>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4b97c5c8-73ac-417d-8b1c-61ccd0768bda@paulmck-laptop>

On Tue, Jun 25, 2024 at 07:21:34PM -0700, Paul E. McKenney wrote:
> On Tue, May 07, 2024 at 07:38:32AM -0700, Paul E. McKenney wrote:
> > On Mon, May 06, 2024 at 10:30:04PM -0700, Josh Poimboeuf wrote:
> > > The direct-call syscall dispatch function doesn't know that the exit()
> > > and exit_group() syscall handlers don't return, so the call sites aren't
> > > optimized accordingly.
> > > 
> > > Fix that by marking those exit syscall declarations __noreturn.
> > > 
> > > Fixes the following warnings:
> > > 
> > >   vmlinux.o: warning: objtool: x64_sys_call+0x2804: __x64_sys_exit() is missing a __noreturn annotation
> > >   vmlinux.o: warning: objtool: ia32_sys_call+0x29b6: __ia32_sys_exit_group() is missing a __noreturn annotation
> > > 
> > > Fixes: 7390db8aea0d ("x86/bhi: Add support for clearing branch history at syscall entry")
> > > Reported-by: "Paul E. McKenney" <paulmck@kernel.org>
> > > Closes: https://lkml.kernel.org/lkml/6dba9b32-db2c-4e6d-9500-7a08852f17a3@paulmck-laptop
> > > Tested-by: Paul E. McKenney <paulmck@kernel.org>
> > 
> > Just reaffirming my Tested-by, and thank you!
> 
> And just following up, given that I do not yet see this in -next.  Any
> chance of this making the upcoming merge window?

Sorry for my slowness!  I'm traveling this week but let me repost this
(with your Tested-by) and grab somebody to merge it.

-- 
Josh

