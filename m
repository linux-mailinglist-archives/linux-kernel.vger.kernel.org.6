Return-Path: <linux-kernel+bounces-365831-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 12BC799EAAD
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 14:57:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F5C6287CF3
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 12:57:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBE72170A3A;
	Tue, 15 Oct 2024 12:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="phBFZuoq"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50A621C07C2;
	Tue, 15 Oct 2024 12:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728997051; cv=none; b=l7Z0WxUQDpuceFiWAzMqir6bWmYHmVYKLKxi8dq+aJOt5eF6zzz+fUp2/U0Hf6tBi6ujyvyoBCNFFcZfTXD6xlvOermIw62JgBfAwXF9ixkqLJ2oTHESOEZrfPO1w5bW3vlH58ClXFxo00GDobbMVn526ZGUsSdljDDMZGT0VrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728997051; c=relaxed/simple;
	bh=dJpNpg4JPPY/O0b3QgBOKSll0jihj67BoIw2p0+2iwQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=aO+4T3D8Mmv+3aXHudsLVVcaUG1QTqlwxa50XjvIYXUPYAEL4+6+xrh0DyYjjjjxj1J5GilEoLz3Y87wxqVi1Ehu9/q2AV8OjVSoPPAEPCMZt9aGAGRtrKzOkZNullzqJJZTP/N7AOrbhg9DnZFCEKVRkYxhSYaCUAfaVU+MYIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=phBFZuoq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5F30C4CEC6;
	Tue, 15 Oct 2024 12:57:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728997051;
	bh=dJpNpg4JPPY/O0b3QgBOKSll0jihj67BoIw2p0+2iwQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=phBFZuoqq4PHSpip/KCjeH3DkV757wLi4CS4RL/n5rArdFNtAqDNKG9z+v0Fk+rAB
	 BZnoB/60dkbf6FJaj1A1Ckhb4NcXVzc9wCvgLXRdbKISeQmTMh3f3GGr2LED9q4la5
	 DjzBND+2d+l3tgraqeVK6L0Oewt7sHPJVb49BFCVtfK20gyai9SHoDzXDAtTzAo70J
	 CRaRGqQkX0jaXlLEOzoWyAhfomX10XoHM1YOEOpjhX/H/YUkuNbK9NzRoDRLyCcpDG
	 oJREAJvRsP56VP78ejYGrfZ18rVyoJnH+U5kGbWk+XX7LscG1GEYvSiY8PHuMcZAaG
	 TQlxE+wXIvy5Q==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: Boqun Feng <boqun.feng@gmail.com>
Cc: Lyude Paul <lyude@redhat.com>,  Thomas Gleixner <tglx@linutronix.de>,
  rust-for-linux@vger.kernel.org,  Danilo Krummrich <dakr@redhat.com>,
  airlied@redhat.com,  Ingo Molnar <mingo@redhat.com>,  Will Deacon
 <will@kernel.org>,  Waiman Long <longman@redhat.com>,  Peter Zijlstra
 <peterz@infradead.org>,  linux-kernel@vger.kernel.org,  Benno Lossin
 <benno.lossin@proton.me>,  Daniel Almeida <daniel.almeida@collabora.com>,
  Gary Guo <gary@garyguo.net>,  Miguel Ojeda <ojeda@kernel.org>,  Alex
 Gaynor <alex.gaynor@gmail.com>,  Wedson Almeida Filho
 <wedsonaf@gmail.com>,  =?utf-8?Q?Bj=C3=B6rn?= Roy Baron
 <bjorn3_gh@protonmail.com>,
  Andreas Hindborg <a.hindborg@samsung.com>,  Alice Ryhl
 <aliceryhl@google.com>,  Trevor Gross <tmgross@umich.edu>,  Martin
 Rodriguez Reboredo <yakoyoku@gmail.com>,  Valentin Obst
 <kernel@valentinobst.de>
Subject: Re: [PATCH v6 3/3] rust: sync: Add SpinLockIrq
In-Reply-To: <ZwPXSs62WY0qNLr6@boqun-archlinux> (Boqun Feng's message of "Mon,
	7 Oct 2024 05:42:50 -0700")
References: <20240916213025.477225-1-lyude@redhat.com>
	<20240916213025.477225-4-lyude@redhat.com> <8734lew7jn.ffs@tglx>
	<0a802e5fc0623ac8ae4653a398d0dfd73c479b96.camel@redhat.com>
	<59803e6abd88dc29c402ff2b7ed020e45f4df1df.camel@redhat.com>
	<ZwPXSs62WY0qNLr6@boqun-archlinux>
Date: Tue, 15 Oct 2024 14:57:11 +0200
Message-ID: <87sesxa5i0.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Boqun Feng <boqun.feng@gmail.com> writes:

> On Sat, Oct 05, 2024 at 02:19:38PM -0400, Lyude Paul wrote:
>> On Fri, 2024-10-04 at 14:48 -0400, Lyude Paul wrote:
>> > 
>> > FWIW: I agree we want things to map C closely wherever we can, but part of the
>> > reason of having rust in the kernel at all is to take advantage of the
>> > features it provides us that aren't in C - so there's always going to be
>> > differences in some places. This being said though, I'm more then happy to
>> > minimize those as much as possible and explore ways to figure out how to make
>> > it so that correctly using these interfaces is as obvious and not-error prone
>> > as possible. The last thing I want is to encourage bad patterns in drivers
>> > that maintainers have to deal with the headaches of for ages to come,
>> > especially when rust should be able to help with this as opposed to harm :).
>> 
>> I was thinking about this a bit more today and I realized I might actually
>> have a better solution that I think would actually map a lot closer to the C
>> primitives and I feel a bit silly it didn't occur to me before.
>> 
>> What if instead of with_interrupts_disabled, we extended Lock so that types
>> like SpinLockIrq that require a context like IrqDisabled can require the use
>> of two new methods:
>> 
>> * first_lock<R>(&self, cb: impl for<'a> FnOnce(Guard<'a, T, B>, B::Context<'a>) -> R) -> R
>
> I think you really want to use a `&mut T` instead of `Guard<'a, T, B>`,
> otherwise people can do:
>
> 	let g = lock1.first_lock(|guard, _ctx| { guard });
> 	// here the lock is held, but the interrupts might be enabled.

Is it impossible to limit the lifetime of the guard such that it cannot
be returned from `first_lock`?

BR Andreas


