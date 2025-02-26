Return-Path: <linux-kernel+bounces-534542-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 97AA9A4684B
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 18:42:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A11E18860A0
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 17:42:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C141225785;
	Wed, 26 Feb 2025 17:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="uBX08G3r"
Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com [91.218.175.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5EE42248B9
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 17:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740591709; cv=none; b=GivZlvhN7SXxbTExAlsjJ83ynMzqWd3VzzwlaT+TkqwC64QecC+gnJplp6AI1HACVUKY6retRH+0oJsA6BxauDc0po3m9F2u2+gWd73Q961o5+Mbg33HNZ3hOy80UKCUPB4BbpaAxgazCypZwcbOEwbaHpYBAY9CogdA3+SSSlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740591709; c=relaxed/simple;
	bh=F1fm5AbZ3HNUz/Nj9rrGexucCZHmsXis/sgMR3ZkbNc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IUIyAqXr14FYW/rRjepzMOrBsV1+l26bebSxaAqghgc9Gyh7ArDYXGsWuINxqTaDOfrQ4z7NB144ZrIyTcd4wK8ySj9i6gpyy2bii20fBLumMET390QBHJU3VL3h18DV+47eaNjorhdfS19HxYNopnyPFeUPIwxdiBfeupClJsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=uBX08G3r; arc=none smtp.client-ip=91.218.175.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Wed, 26 Feb 2025 12:41:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1740591695;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LacZ+GVTa9QlMyWBHLDLvTEMaP9C/9n3aDDQj2YV9kM=;
	b=uBX08G3r95FkGvKm7sLtS+I2Zpb2uT7EzS7xFPWqu7DxUc04P1Z6WLuR2E9eSQQHHyGaLq
	I+4eJO6dQHOGyUvEXp7r/EbJ79UR0JCc4bQAFey0guncKUgHPru1/DZRlQ41nM00RMBa1H
	tsoNvDhdPt2TTrKFAqEwjh10/iK/LHQ=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: James Bottomley <James.Bottomley@hansenpartnership.com>, 
	Greg KH <gregkh@linuxfoundation.org>, Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>, 
	Ventura Jack <venturajack85@gmail.com>, "H. Peter Anvin" <hpa@zytor.com>, 
	Alice Ryhl <aliceryhl@google.com>, Linus Torvalds <torvalds@linux-foundation.org>, 
	Gary Guo <gary@garyguo.net>, airlied@gmail.com, boqun.feng@gmail.com, 
	david.laight.linux@gmail.com, hch@infradead.org, ksummit@lists.linux.dev, 
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, Ralf Jung <post@ralfj.de>, 
	Josh Poimboeuf <jpoimboe@redhat.com>
Subject: Re: C aggregate passing (Rust kernel policy)
Message-ID: <olxh7iwz5yjuuqwpbzgohrl3dkcurbmzij3o2dbha5mtkr2ipn@wtee4jjj7ope>
References: <2rrp3fmznibxyg3ocvsfasfnpwfp2skhf4x7ihrnvm72lemykf@lwp2jkdbwqgm>
 <CAFJgqgS-SMMEE2FktuCUimdGkPWMV3HB2Eg38SiUDQK1U8=rNg@mail.gmail.com>
 <CANiq72mOp0q1xgAHod1Y_mX86OESzdDsgSghtQCwe6iksNt-sA@mail.gmail.com>
 <f2bf76553c666178505cb9197659303a39faf7aa.camel@HansenPartnership.com>
 <2025022611-work-sandal-2759@gregkh>
 <16127450a24e9df8112a347fe5f6df9c9cca2926.camel@HansenPartnership.com>
 <20250226110033.53508cbf@gandalf.local.home>
 <9c443013493f8f380f9c4d51b1eeeb9d29b208a3.camel@HansenPartnership.com>
 <ylsffirqsrogli5fqlyhklhy6s54ngolvk5hj5fnpn3ceglyii@cgcvtm4ohtra>
 <20250226115726.27530000@gandalf.local.home>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250226115726.27530000@gandalf.local.home>
X-Migadu-Flow: FLOW_OUT

On Wed, Feb 26, 2025 at 11:57:26AM -0500, Steven Rostedt wrote:
> 
> [ Adding Josh ]
> 
> On Wed, 26 Feb 2025 11:47:09 -0500
> Kent Overstreet <kent.overstreet@linux.dev> wrote:
> 
> > On Wed, Feb 26, 2025 at 11:42:41AM -0500, James Bottomley wrote:
> > > On Wed, 2025-02-26 at 11:00 -0500, Steven Rostedt wrote:  
> > > > On Wed, 26 Feb 2025 09:45:53 -0500
> > > > James Bottomley <James.Bottomley@HansenPartnership.com> wrote:
> > > >   
> > > > > > From some other rust boot system work, I know that the quality of
> > > > > > a    
> > > > > simple backtrace in rust where you just pick out addresses you
> > > > > think you know in the stack and print them as symbols can sometimes
> > > > > be rather misleading, which is why you need an unwinder to tell you
> > > > > exactly what happened.  
> > > > 
> > > > One thing I learned at GNU Cauldron last year is that the kernel
> > > > folks use the term "unwinding" incorrectly. Unwinding to the compiler
> > > > folks mean having full access to all the frames and variables and
> > > > what not for all the previous functions.
> > > > 
> > > > What the kernel calls "unwinding" the compiler folks call "stack
> > > > walking". That's a much easier task than doing an unwinding, and that
> > > > is usually all we need when something crashes.  
> > > 
> > > Well, that's not the whole story.  We do have at least three unwinders
> > > in the code base.  You're right in that we don't care about anything
> > > other than the call trace embedded in the frame, so a lot of unwind
> > > debug information isn't relevant to us and the unwinders ignore it.  In
> > > the old days we just used to use the GUESS unwinder which looks for
> > > addresses inside the text segment in the stack and prints them in
> > > order.  Now we (at least on amd64) use the ORC unwinder because it
> > > gives better traces:
> > > 
> > > https://docs.kernel.org/arch/x86/orc-unwinder.html  
> 
> Note, both myself and Josh (creator of ORC) were arguing with the GCC folks
> until we all figured out we were talking about two different things. Once
> they said "Oh, you mean stack walking. Yeah that can work" and the
> arguments stopped. Lessons learned that day was that compiler folks take
> the term "unwinding" to mean much more than kernel folks, and since we have
> compiler folks on this thread, I'd figure I would point that out.
> 
> We still use the term "unwinder" in the kernel, but during the sframe
> meetings, we need to point out that we all just care about stack walking.
> 
> > 
> > More accurate perhaps, but I still don't see it working reliably - I'm x
> > still having to switch all my test setups (and users) to frame pointers
> > if I want to be able to debug reliably.
> 
> Really? The entire point of ORC was to have accurate stack traces so that
> live kernel patching can work. If there's something incorrect, then please
> report it.

It's been awhile since I've looked at one, I've been just automatically
switching back to frame pointers for awhile, but - I never saw
inaccurate backtraces, just failure to generate a backtrace - if memory
serves.

When things die down a bit more I might be able to switch back and see
if I get something reportable, I'm still in bug crunching mode :)

