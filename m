Return-Path: <linux-kernel+bounces-534472-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BAB9A46726
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 17:57:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 68EFA7A66F6
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 16:56:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52F56223328;
	Wed, 26 Feb 2025 16:56:48 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1DDB8BE5;
	Wed, 26 Feb 2025 16:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740589008; cv=none; b=dTNWlcn4TQUPESVrHjYIgk9zcIN4j7nxbZLaUDLSPOXU/XpeDMr3S4iyooo8xPWKqGFYyWGR9w7ZhTsYoc762Dag8sIaffqYVhriTmCWZp6Xd1vlnAMmRb7e0GrkB2QDmV2yQZil37bn776vpc0ZKful5aEkBtKC7pKYjOKKL6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740589008; c=relaxed/simple;
	bh=aZDXeRG6Tv3oHJ75HiBSg1cMMCX7EbM0Tt8WZ07i38g=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Fwccmc1zaVVNTglFJi4JKVQWFEijuX9zdXn4coEPND19CqCB/U1KavCGbmYv0Bn+bsO9jSEqUxE6/GUd4BZUp6Kn0kSkWY3zzyJT4CpxarfCUB63hyz04UDm1DTqvms7Uf1Nv26P1DBlJN9zCNKrkHaDY5o7OgKMVrhWP6RHgWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82C58C4CED6;
	Wed, 26 Feb 2025 16:56:45 +0000 (UTC)
Date: Wed, 26 Feb 2025 11:57:26 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: James Bottomley <James.Bottomley@hansenpartnership.com>, Greg KH
 <gregkh@linuxfoundation.org>, Miguel Ojeda
 <miguel.ojeda.sandonis@gmail.com>, Ventura Jack <venturajack85@gmail.com>,
 "H. Peter Anvin" <hpa@zytor.com>, Alice Ryhl <aliceryhl@google.com>, Linus
 Torvalds <torvalds@linux-foundation.org>, Gary Guo <gary@garyguo.net>,
 airlied@gmail.com, boqun.feng@gmail.com, david.laight.linux@gmail.com,
 hch@infradead.org, ksummit@lists.linux.dev, linux-kernel@vger.kernel.org,
 rust-for-linux@vger.kernel.org, Ralf Jung <post@ralfj.de>, Josh Poimboeuf
 <jpoimboe@redhat.com>
Subject: Re: C aggregate passing (Rust kernel policy)
Message-ID: <20250226115726.27530000@gandalf.local.home>
In-Reply-To: <ylsffirqsrogli5fqlyhklhy6s54ngolvk5hj5fnpn3ceglyii@cgcvtm4ohtra>
References: <CAH5fLghEMtT663SNogAGad-qk7umefGeBKbm+QjKKzoskjOubw@mail.gmail.com>
	<5E3FEDC4-DBE3-45C7-A331-DAADD3E7EB42@zytor.com>
	<2rrp3fmznibxyg3ocvsfasfnpwfp2skhf4x7ihrnvm72lemykf@lwp2jkdbwqgm>
	<CAFJgqgS-SMMEE2FktuCUimdGkPWMV3HB2Eg38SiUDQK1U8=rNg@mail.gmail.com>
	<CANiq72mOp0q1xgAHod1Y_mX86OESzdDsgSghtQCwe6iksNt-sA@mail.gmail.com>
	<f2bf76553c666178505cb9197659303a39faf7aa.camel@HansenPartnership.com>
	<2025022611-work-sandal-2759@gregkh>
	<16127450a24e9df8112a347fe5f6df9c9cca2926.camel@HansenPartnership.com>
	<20250226110033.53508cbf@gandalf.local.home>
	<9c443013493f8f380f9c4d51b1eeeb9d29b208a3.camel@HansenPartnership.com>
	<ylsffirqsrogli5fqlyhklhy6s54ngolvk5hj5fnpn3ceglyii@cgcvtm4ohtra>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable


[ Adding Josh ]

On Wed, 26 Feb 2025 11:47:09 -0500
Kent Overstreet <kent.overstreet@linux.dev> wrote:

> On Wed, Feb 26, 2025 at 11:42:41AM -0500, James Bottomley wrote:
> > On Wed, 2025-02-26 at 11:00 -0500, Steven Rostedt wrote: =20
> > > On Wed, 26 Feb 2025 09:45:53 -0500
> > > James Bottomley <James.Bottomley@HansenPartnership.com> wrote:
> > >  =20
> > > > > From some other rust boot system work, I know that the quality of
> > > > > a=C2=A0  =20
> > > > simple backtrace in rust where you just pick out addresses you
> > > > think you know in the stack and print them as symbols can sometimes
> > > > be rather misleading, which is why you need an unwinder to tell you
> > > > exactly what happened. =20
> > >=20
> > > One thing I learned at GNU Cauldron last year is that the kernel
> > > folks use the term "unwinding" incorrectly. Unwinding to the compiler
> > > folks mean having full access to all the frames and variables and
> > > what not for all the previous functions.
> > >=20
> > > What the kernel calls "unwinding" the compiler folks call "stack
> > > walking". That's a much easier task than doing an unwinding, and that
> > > is usually all we need when something crashes. =20
> >=20
> > Well, that's not the whole story.  We do have at least three unwinders
> > in the code base.  You're right in that we don't care about anything
> > other than the call trace embedded in the frame, so a lot of unwind
> > debug information isn't relevant to us and the unwinders ignore it.  In
> > the old days we just used to use the GUESS unwinder which looks for
> > addresses inside the text segment in the stack and prints them in
> > order.  Now we (at least on amd64) use the ORC unwinder because it
> > gives better traces:
> >=20
> > https://docs.kernel.org/arch/x86/orc-unwinder.html =20

Note, both myself and Josh (creator of ORC) were arguing with the GCC folks
until we all figured out we were talking about two different things. Once
they said "Oh, you mean stack walking. Yeah that can work" and the
arguments stopped. Lessons learned that day was that compiler folks take
the term "unwinding" to mean much more than kernel folks, and since we have
compiler folks on this thread, I'd figure I would point that out.

We still use the term "unwinder" in the kernel, but during the sframe
meetings, we need to point out that we all just care about stack walking.

>=20
> More accurate perhaps, but I still don't see it working reliably - I'm x
> still having to switch all my test setups (and users) to frame pointers
> if I want to be able to debug reliably.

Really? The entire point of ORC was to have accurate stack traces so that
live kernel patching can work. If there's something incorrect, then please
report it.

-- Steve

