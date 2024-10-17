Return-Path: <linux-kernel+bounces-369881-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CA9DD9A23F1
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 15:35:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE8181C21B35
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 13:35:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D86881DE3BE;
	Thu, 17 Oct 2024 13:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X77h9FIX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E89C1DDA24;
	Thu, 17 Oct 2024 13:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729172105; cv=none; b=ohMmTPdiklhqckWnlUo0C8dwhxY32QMklXRSKd0FfdTugrT5m0I+xGHFukmoPc2wdr0hTtDZAeVoTSpI7MbbY/Nhm84EaHpObagh60dnMv7GZcKW0uFdxadHngcaFkIv5bruPKZPyEIa7zN+y5aVmqWxPCSwC01S+esNdDPu6qw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729172105; c=relaxed/simple;
	bh=gWbAqmaxL1IFulKClwhBJngA0SJkHNiuvWOaDGaZeqQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=lDImMWpU8KrtzyoS3rB0gSaVsyZshyKQLUUEz/YjpBDBTqXlX8QLycv3nWRickEb6xrB0L4Mni+1uInwdw9SLtljy/SVOa6qzkgx+FOWJA6T7DR2C6E6hixgJi2mWWcTuuCiwOGpiMtxj5iTbMlY/TKiZJSVKgSD87+1/piqwUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X77h9FIX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FEABC4CED1;
	Thu, 17 Oct 2024 13:34:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729172104;
	bh=gWbAqmaxL1IFulKClwhBJngA0SJkHNiuvWOaDGaZeqQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=X77h9FIX3v+yVIz4IwReAXtOanS5K4w0tZBpxuVJUkIiNzZ5HAUz+bxtziSPZtUgM
	 mksiJv1HP6xbKfCf1cC4Pjy7O6XiFuKEKZM2IGdGnbJK1xl+FhpkPP66ZPDv5bbAAD
	 s+RZbexs8jPhfO26E58M3zUid8VEl1c1K0kkbFxORilbSY9ONPr46m0FBboIwvnsBM
	 VkcZkjXKUx8k3eDGbNFRkqC+XDBdUKG6KBfCb/nWPEe3+dU7iLA1+ddxesFx5Qti/N
	 A9dqqvqa7Y8NalQZ2ntfCeqEUbLott3tNsS1/Q6+k4NSjjqQcA2AfRCeM6EPnyA4Gk
	 nMxE34je70jIQ==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: Lyude Paul <lyude@redhat.com>
Cc: Boqun Feng <boqun.feng@gmail.com>,  Thomas Gleixner
 <tglx@linutronix.de>,  rust-for-linux@vger.kernel.org,  Danilo Krummrich
 <dakr@redhat.com>,  airlied@redhat.com,  Ingo Molnar <mingo@redhat.com>,
  Will Deacon <will@kernel.org>,  Waiman Long <longman@redhat.com>,  Peter
 Zijlstra <peterz@infradead.org>,  linux-kernel@vger.kernel.org,  Benno
 Lossin <benno.lossin@proton.me>,  Daniel Almeida
 <daniel.almeida@collabora.com>,  Gary Guo <gary@garyguo.net>,  Miguel
 Ojeda <ojeda@kernel.org>,  Alex Gaynor <alex.gaynor@gmail.com>,  Wedson
 Almeida Filho <wedsonaf@gmail.com>,  =?utf-8?Q?Bj=C3=B6rn?= Roy Baron
 <bjorn3_gh@protonmail.com>,  Andreas Hindborg <a.hindborg@samsung.com>,
  Alice Ryhl <aliceryhl@google.com>,  Trevor Gross <tmgross@umich.edu>,
  Martin Rodriguez Reboredo <yakoyoku@gmail.com>,  Valentin Obst
 <kernel@valentinobst.de>
Subject: Re: [PATCH v6 3/3] rust: sync: Add SpinLockIrq
In-Reply-To: <b33299c95e6f0031b6c4099cb1cff7d25462d687.camel@redhat.com>
	(Lyude Paul's message of "Wed, 16 Oct 2024 16:57:38 -0400")
References: <20240916213025.477225-1-lyude@redhat.com>
	<20240916213025.477225-4-lyude@redhat.com> <8734lew7jn.ffs@tglx>
	<0a802e5fc0623ac8ae4653a398d0dfd73c479b96.camel@redhat.com>
	<59803e6abd88dc29c402ff2b7ed020e45f4df1df.camel@redhat.com>
	<ZwPXSs62WY0qNLr6@boqun-archlinux> <87sesxa5i0.fsf@kernel.org>
	<Zw7N4RKzWAS9qi4I@Boquns-Mac-mini.local>
	<Zw7O1Wn7cwHDcCQl@Boquns-Mac-mini.local>
	<b33299c95e6f0031b6c4099cb1cff7d25462d687.camel@redhat.com>
Date: Thu, 17 Oct 2024 15:34:50 +0200
Message-ID: <87a5f2svid.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Lyude Paul <lyude@redhat.com> writes:

> On Tue, 2024-10-15 at 13:21 -0700, Boqun Feng wrote:
>> On Tue, Oct 15, 2024 at 01:17:37PM -0700, Boqun Feng wrote:
>> > On Tue, Oct 15, 2024 at 02:57:11PM +0200, Andreas Hindborg wrote:
>> > > Boqun Feng <boqun.feng@gmail.com> writes:
>> > > 
>> > > > On Sat, Oct 05, 2024 at 02:19:38PM -0400, Lyude Paul wrote:
>> > > > > On Fri, 2024-10-04 at 14:48 -0400, Lyude Paul wrote:
>> > > > > > 
>> > > > > > FWIW: I agree we want things to map C closely wherever we can, but part of the
>> > > > > > reason of having rust in the kernel at all is to take advantage of the
>> > > > > > features it provides us that aren't in C - so there's always going to be
>> > > > > > differences in some places. This being said though, I'm more then happy to
>> > > > > > minimize those as much as possible and explore ways to figure out how to make
>> > > > > > it so that correctly using these interfaces is as obvious and not-error prone
>> > > > > > as possible. The last thing I want is to encourage bad patterns in drivers
>> > > > > > that maintainers have to deal with the headaches of for ages to come,
>> > > > > > especially when rust should be able to help with this as opposed to harm :).
>> > > > > 
>> > > > > I was thinking about this a bit more today and I realized I might actually
>> > > > > have a better solution that I think would actually map a lot closer to the C
>> > > > > primitives and I feel a bit silly it didn't occur to me before.
>> > > > > 
>> > > > > What if instead of with_interrupts_disabled, we extended Lock so that types
>> > > > > like SpinLockIrq that require a context like IrqDisabled can require the use
>> > > > > of two new methods:
>> > > > > 
>> > > > > * first_lock<R>(&self, cb: impl for<'a> FnOnce(Guard<'a, T, B>, B::Context<'a>) -> R) -> R
>> > > > 
>> > > > I think you really want to use a `&mut T` instead of `Guard<'a, T, B>`,
>> > > > otherwise people can do:
>> > > > 
>> > > > 	let g = lock1.first_lock(|guard, _ctx| { guard });
>> > > > 	// here the lock is held, but the interrupts might be enabled.
>> > > 
>> > > Is it impossible to limit the lifetime of the guard such that it cannot
>> > > be returned from `first_lock`?
>> > > 
>> > 
>> > I was wrong saying the original doesn't work, because it has a
>> > `for<'a>`, that means `'a` is lifetime of the closure, which cannot
>> > outlive the return value `R`. So this signature might be valid.
>> > 
>> 
>> But another problem is that with this signature, `cb` can drop the lock,
>> which is not expected, because the lock dropping should be done by
>> `first_lock` itself.
>
> I thought we agreed on switching this to &mut though? In which case dropping
> the guard doesn't really matter

I think we arrived the following over on Zulip [1]:

pub fn lock_with_new<U>(&self, cb: impl FnOnce(&mut Guard<'_, T, Backend>, IrqDisabled<'a>) -> U) -> U


Best regards,
Andreas


[1] https://rust-for-linux.zulipchat.com/#narrow/channel/288089-General/topic/Spinlocks.20with.20IRQs.3F/near/477072424



