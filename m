Return-Path: <linux-kernel+bounces-271756-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 86E4F9452EE
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 20:40:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 315F61F251FB
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 18:40:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C97F914A619;
	Thu,  1 Aug 2024 18:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="e2Oel1Nu"
Received: from mail-40133.protonmail.ch (mail-40133.protonmail.ch [185.70.40.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B222014A4F8;
	Thu,  1 Aug 2024 18:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722537523; cv=none; b=W3GaD6/FGzTxuguVTnE9Z/AHrfw2m2Nga0gxcSjmL5h7N9xRR6O/rPvsWXoo5A1d5DHhEHsWJDFnEJIWdufr4d993gYMdw7g2yRR5/P3gbymuX4uNyaU2cmfFAGxGBjlyWOTjB3qXqEouPNwclWVuuV9p+3aTgyixeyYgtVw57A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722537523; c=relaxed/simple;
	bh=0wA1I5pw5uMJ7CwgBZx+Bkz88j+ObQ2NSGu6oAhojPM=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EsVRZHmx9G8LcuNHh1lVEgZOR3UKyLeMHwqBv3pAYjZ17gp/ctTHIa+C+zaVt8n6m+4JtgW2+i5l6tM2L5E6wvlxJ5kVqwCGP4IUvnRJPNeEzoZee7LzFXj3CuyKXNSiXEayPIYQ3MMjCWVke0xZqyJOhx1DSa7cdpYwx0khtfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=e2Oel1Nu; arc=none smtp.client-ip=185.70.40.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=tpusvpg7arbntd277skf5e4uz4.protonmail; t=1722537518; x=1722796718;
	bh=msNfM+n09dyreTa6/jFHnrjM2fYU7OZAlqKTBUbkzBA=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=e2Oel1NuX6s7aIzvYSsdw8ob9WFjL2sa2tub3LArGS4lnHBJuWt5niUllUS84DsLJ
	 WttCHlEkkxYb0To/5iKo3gEHb5QeAqRo2I4TUZnN13KAIaaWJITGNgQfhAOM/4n4dx
	 ypu7Fda/19BLRBYSEY9igf5tflK2zVsozP/ZDzVHgxP+53pJpSHMnffIxCHEHFjpTh
	 BSViOfP2oOCxH9sbhavyY/0fmuDv3hnXkzET5FDR7YppBiY/iBuaU8zpxZVi6DqX9I
	 Ggvs4eatMPUjZ210UAL3YGrAnk+akZOXXPAvWpfngKJfWHfyj8a1xio0MQXXLLGpen
	 E7XKcmTwGTOng==
Date: Thu, 01 Aug 2024 18:38:35 +0000
To: Lyude Paul <lyude@redhat.com>, rust-for-linux@vger.kernel.org
From: Benno Lossin <benno.lossin@proton.me>
Cc: Danilo Krummrich <dakr@redhat.com>, airlied@redhat.com, Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>, Waiman Long <longman@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@samsung.com>, Alice Ryhl <aliceryhl@google.com>, Martin Rodriguez Reboredo <yakoyoku@gmail.com>, Valentin Obst <kernel@valentinobst.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/3] rust: sync: Add SpinLockIrq
Message-ID: <0117ba2d-75f6-4291-9108-35607aab0f1b@proton.me>
In-Reply-To: <028a84fded53be13d1b2d53e877a958f6f08c24a.camel@redhat.com>
References: <20240731224027.232642-1-lyude@redhat.com> <20240731224027.232642-4-lyude@redhat.com> <991a7dd2-f8a8-402d-a651-eafd857c540d@proton.me> <028a84fded53be13d1b2d53e877a958f6f08c24a.camel@redhat.com>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: e9cd9f11c106d26650f4faa8ff12ecf207845322
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01.08.24 19:10, Lyude Paul wrote:
> On Thu, 2024-08-01 at 10:29 +0000, Benno Lossin wrote:
>> On 01.08.24 00:35, Lyude Paul wrote:
>>> +unsafe impl super::Backend for SpinLockIrqBackend {
>>> +    type State =3D bindings::spinlock_t;
>>> +    type GuardState =3D ();
>>> +    type Context<'a> =3D IrqDisabled<'a>;
>>> +
>>> +    unsafe fn init(
>>> +        ptr: *mut Self::State,
>>> +        name: *const core::ffi::c_char,
>>> +        key: *mut bindings::lock_class_key,
>>> +    ) {
>>> +        // SAFETY: The safety requirements ensure that `ptr` is valid =
for writes, and `name` and
>>> +        // `key` are valid for read indefinitely.
>>> +        unsafe { bindings::__spin_lock_init(ptr, name, key) }
>>> +    }
>>> +
>>> +    unsafe fn lock(ptr: *mut Self::State) -> Self::GuardState {
>>> +        // SAFETY: The safety requirements of this function ensure tha=
t `ptr` points to valid
>>> +        // memory, and that it has been initialised before.
>>> +        unsafe { bindings::spin_lock(ptr) }
>>
>> Should this really be the same function as `SpinLock`? (ie is there not
>> a special version that expects IRQ to already be disabled? eg this could
>> add additional debug calls)
>=20
> Yes, unless there's some spinlock API function I missed (I checked right
> before sending this response) we don't really have a variant of spin_lock=
*()
> that assumes IRQs are disabled. You really just have:
>=20
> spin_lock() - Grab lock, no IRQ changes
>=20
> spin_lock_irq() - Grab lock, unconditionally disable IRQs (regardless of
> current flags) until spin_unlock_irq()
>=20
> spin_lock_irqsave() - Grab lock, save IRQ flags and restore upon
> spin_unlock_irqrestore()

I see, I have very limited knowledge of the C side and using the same
function for both seemed strange.

> Usually lockdep is the one to actually warn about the interrupt state bei=
ng
> incorrect, as it will throw up a warning if you grab a spinlock in both a=
n
> interrupt enabled and disabled context (which means you are forgetting to
> disable interrupts before lock acquisition somewhere).

Cool.

> As well, I think having further debug calls would be unneeded? As of righ=
t now
> there's only really two entrypoints for getting IrqDisabled:
> with_irqs_disabled(), and IrqDisabled::new(). And since IrqDisabled::new(=
) now
> has a debug assertion for disabled interrupts, that means all paths to
> creating IrqDisabled are either already guaranteed to disable interrupts =
- or
> would be making use of the debug assertion for verifying interrupt state.

Yes, but if you eg call some FFI function in the meantime it might
re-enable IRQs (or just a plain old bug in the Rust side). I don't know
how expensive this will be for debug builds, if it is too much, we could
try to introduce different levels of debugging.
But as you already said above, we don't need it for `SpinLockIrq`, since
lockdep should take care of that.

---
Cheers,
Benno


