Return-Path: <linux-kernel+bounces-525659-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31CC5A3F2D8
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 12:21:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7FF757AC3E0
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 11:19:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D29F207E1E;
	Fri, 21 Feb 2025 11:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qUMwypBu"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBE3F209663;
	Fri, 21 Feb 2025 11:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740136827; cv=none; b=Z1T/y2mjfYMb/8uTUbFhZt2lDVmT1lkjZgGTSfMw2XMSp28G6nfAd0dsg5kl9ALyhrBJcmtxaWKpFcm4cT07tQVn9yLqUcLKIi610VHP7dSDqW36MiykwF/H+TyPDXGDTV8SxwKL/hgX24iecvVfWDbFdMhWbWL6PeNiFtUgUa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740136827; c=relaxed/simple;
	bh=uwrptfZQzR8vm3LwuylnJoiSnoBFnYe+OC5GIF2p1Bw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZG2sw0+rHhYzjeUC3D9AWgU2pJqTMicA9adKjqJH6kzu/GxSGycPz4NprdkAKEuDxiwhC4oSN+ALaNrFftY28tKppqQ12LJlriHpgNmtjLQ7PT0FemcIovWwQUOhnbd/WCKppNT9eOiaOeKPqbHtjOs2LF4Nng3irIACPkj88A8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qUMwypBu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B078C4CED6;
	Fri, 21 Feb 2025 11:20:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740136827;
	bh=uwrptfZQzR8vm3LwuylnJoiSnoBFnYe+OC5GIF2p1Bw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qUMwypBu/fKYQCW+249jHHx/HqxvFxgByl5kaqE8QGFbM0KakwjmDN43KzOayAzms
	 LFcMl3C9TNs8TpHG8XxcOLCz9YvMn23zQGl+5Den4XoI7tM6948guHdVQK+LwZyxt6
	 BwKedziN4jQNWdrFpXhWKL80TWBMeUfcWE26pqsKzIEOEY2z+Nm4xadl5LjO9mpwrP
	 qsAAVorKr5BZ2b6NB6BMRp3oEqvGEN5ENiyJUwPufTJS1jGRymvYYCYVPKRa8uK/He
	 Uhj6Pi2QKxR3J6SY48uS+i+6+l21NTx5FF7MdoH2H9kxUYt79rUuQDg7ZIACatTo/1
	 WlInyDNRIuY9g==
Date: Fri, 21 Feb 2025 12:20:24 +0100
From: Frederic Weisbecker <frederic@kernel.org>
To: Andreas Hindborg <a.hindborg@kernel.org>
Cc: Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Thomas Gleixner <tglx@linutronix.de>,
	Miguel Ojeda <ojeda@kernel.org>, Danilo Krummrich <dakr@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	Lyude Paul <lyude@redhat.com>, Guangbo Cui <2407018371@qq.com>,
	Dirk Behme <dirk.behme@gmail.com>,
	Daniel Almeida <daniel.almeida@collabora.com>,
	Tamir Duberstein <tamird@gmail.com>, rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 00/14] hrtimer Rust API
Message-ID: <Z7hheOSAuKdhq-1C@pavilion.home>
References: <aIJ0ymzdUceCN05hwJpth4erH5u2SHYzYl52wGeT3uiO9bdk92ZkEmEEq9a9NXsInJYSz9uziwq-1fvdsXoeDA==@protonmail.internalid>
 <20250218-hrtimer-v3-v6-12-rc2-v8-0-48dedb015eb3@kernel.org>
 <877c5mci3p.fsf@kernel.org>
 <5kF-NYTBZbEqnnQud5LKnRXO0lfM0i6I2PoeFrpKDhCYwUuk_bG2Li1T1Nuv82r3VFD8adTcdx7yenXSIfTwmw==@protonmail.internalid>
 <Z7eYp_vZo5yDVOdI@pavilion.home>
 <87frk7hera.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87frk7hera.fsf@kernel.org>

Le Fri, Feb 21, 2025 at 09:40:41AM +0100, Andreas Hindborg a écrit :
> "Frederic Weisbecker" <frederic@kernel.org> writes:
> 
> > Le Wed, Feb 19, 2025 at 12:02:50PM +0100, Andreas Hindborg a écrit :
> >> "Andreas Hindborg" <a.hindborg@kernel.org> writes:
> >>
> >> > This series adds support for using the `hrtimer` subsystem from Rust code.
> >> >
> >> > The series adds support for timer mode and clock source configuration during
> >> > timer initialization. Examples and functionality to execute closures at timer
> >> > expiration has been removed, as these depend on either atomics [3] or
> >> > `SpinLockIrq` [4], which are still being worked on.
> >> >
> >> > This series is a dependency for unmerged features of the Rust null block driver
> >> > [1], and for rkvms [2].
> >> >
> >>
> >> @ timer subsystem maintainers: did you discuss how you want to set up
> >> maintenance for this yet? As mentioned, I'm happy stepping up to
> >> maintain this, but if you want to handle it with existing resources that
> >> is perfectly fine as well.
> >
> > You're the best candidate to maintain this code since you wrote it :-)
> >
> > Also I personally have near zero skills in Rust as of today so all I can do
> > is to vaguely keep an eye on the binding's interface and keep in touch
> > with the changes.
> >
> > So I suggest you to add a new entry with you as a maintainer (I suggested
> > something similar to Fujita for some other timer related things) but please
> > keep us Cc'ed for future changes.
> 
> Alright, lets do that.
> 
> Do you want to pick future changes to this directly form list or would
> you prefer that I send you a PR with changes?

I was thinking the patchset would be better routed towards the Rust tree?

How do you guys proceed usually with bindings tree maintainance?

I read yesterday Linus saying that Rust bindings are users of existing
kernel infrastructure just like any other driver. I personally think it's
more than that, and probably he does to, but anyway he has a point in that
they are not changing the core infrastructures. Functionally they are
eventually new API users.

Adding to that, Rust bindings require quite some specific knowledge that
is mostly to be found among the Rust tree developers for now (and not much
shared elsewhere I suspect), I think it's a better idea that you guys handle
this hrtimer binding within the Rust tree. You'll be more flexible and people
applying the related patches will know what they are doing.

What do you think?

> 
> We are probably going to have a new iteration anyway, as discussion
> picked up again.

Ok.

Thanks.

> 
> 
> Best regards,
> Andreas Hindborg
> 
> 
> 

