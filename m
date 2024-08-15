Return-Path: <linux-kernel+bounces-288645-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 14674953CE7
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 23:47:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 68D40B21127
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 21:47:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7ECBB155A53;
	Thu, 15 Aug 2024 21:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="PFiyFLzA"
Received: from mail-4316.protonmail.ch (mail-4316.protonmail.ch [185.70.43.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C08F3154429;
	Thu, 15 Aug 2024 21:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723758387; cv=none; b=GgUTIfIQYsoSPhJLopvA4e9VRWecZYR60H5GXhvuEhZH8BdkVWn+PPMiy5J0fbUPE8oIARwjds72rlAPMKVqvVm0kiaZn7uj5yVErr7h08bbHP7jQg66A2QrpJfoBhsnCE5YhDhserlURDMxePVth4t1cFTXE8mCGFOfxGVvAHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723758387; c=relaxed/simple;
	bh=j7Erq4h7U03NAMay0BWV7O7VgiDqnixNfZnouEQQQoE=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nChA5lKAromRAMhQUIxpqOuvsLG2v6J8G8hctT0nWVcjrA+xCphjqY6YvCV5UAgLKVCuT36VQ3GOOTf9tfMeIwOWKpeszZIMfxxxFNaD1C43Jdk9C8OEIaJvlvtaFXjC9s/kQuvxOGKYMdpOPAAzv06ZTdQSEYQrNJGDiQmMveQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=PFiyFLzA; arc=none smtp.client-ip=185.70.43.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1723758383; x=1724017583;
	bh=t/ejGhWmZxG2OPtIvfNb0VQHYWjXGoFBVjOxUmUcCjs=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=PFiyFLzAN1jgo+dZiEFd1dWdSaPka9/FCwGE6sGC68VSw2mm+Mv0bEs+oNTJ7UEjF
	 1qtfL2YHMd6qwNOsFyRh8S3TWaohsM4jS7TXWwOmWZIq9PNjc421b0IpfP5lBAUHuH
	 anDEEu6n9y8ElXRfXbW8LdodrMgARbYS6UygDevArj5PyrSotFw76HiW+glr/QrZp7
	 TkI30zDIMnmY/Xb1p9OPTwc/DidzCzKJbzaV+vzR4GQ7SFOilkTfUfxYjBJQ98GOXB
	 vD2W3aoCGg3h6yI954UmaXXSo6MfW0Gv0CHCu+pRFviHN/+KqEDhpzx4RlHxiTE0Xy
	 tF/xN0Yty19wg==
Date: Thu, 15 Aug 2024 21:46:15 +0000
To: Lyude Paul <lyude@redhat.com>, Boqun Feng <boqun.feng@gmail.com>
From: Benno Lossin <benno.lossin@proton.me>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, Danilo Krummrich <dakr@redhat.com>, airlied@redhat.com, Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>, Waiman Long <longman@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@samsung.com>, Alice Ryhl <aliceryhl@google.com>, FUJITA Tomonori <fujita.tomonori@gmail.com>, Aakash Sen Sharma <aakashsensharma@gmail.com>, Valentin Obst <kernel@valentinobst.de>, Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v3 1/3] rust: Introduce irq module
Message-ID: <eac5371d-7192-421d-bf11-630a417ca351@proton.me>
In-Reply-To: <28e54d4b18e6949e638fa1a0ee46624d774bf81e.camel@redhat.com>
References: <20240802001452.464985-1-lyude@redhat.com> <Zr0QyN8sQ6W2hPoJ@boqun-archlinux> <9855f198-858d-4e3f-9259-cd9111900c0c@proton.me> <Zr0aUwTqJXOxE-ju@boqun-archlinux> <Zr2JryyeoZPn3JGC@boqun-archlinux> <2b139d06-c0e0-4896-8747-d62499aec82f@proton.me> <Zr4mjM9w16Qlef5B@boqun-archlinux> <40793a9622ba6d9aea8b42f4c8711b6cfa5788e4.camel@redhat.com> <28e54d4b18e6949e638fa1a0ee46624d774bf81e.camel@redhat.com>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: ab96009b266110b9f84ca6cedab79268aacae882
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 15.08.24 23:31, Lyude Paul wrote:
> On Thu, 2024-08-15 at 17:05 -0400, Lyude Paul wrote:
>> The type system approach is slightly more complicated, but I'm now reali=
zing
>> it is probably the correct solution actually. Thanks for pointing that o=
ut!
>>
>> So: Functions like wait_event_lock_interruptible_irq() work because they=
 drop
>> the spinlock in question before re-enabling interrupts, then re-disable
>> interrupts and re-acquire the lock before checking the condition. This i=
s
>> where a soundness issue with my current series lies.
>>
>> For the sake of explanation, let's pretend we have an imaginary rust fun=
ction
>> "irqs_on_and_sleep(irq: IrqDisabled<'_>)" that re-enables IRQs explicitl=
y,
>> sleeps, then turns them back on. This leads to a soundness issue if we h=
ave
>> IrqDisabled be `Copy`:
>>
>> with_irqs_disabled(|irq| {
>>   let some_guard =3D some_spinlockirq.lock_with(irq);
>>   // ^ Let's call this type Guard<'1, =E2=80=A6>
>>
>>   irqs_on_and_sleep(irq);
>>   // ^ because `irq` is just copied here, the lifetime '1 doesn't end he=
re.
>>   // Since we re-enabled interrupts while holding a SpinLockIrq, we woul=
d
>>   // potentially deadlock here.
>>
>>   some_function(some_guard.some_data);
>> });
>>
>> So - I'm thinking we might want to make it so that IrqDisabled does not =
have
>> `Copy` - and that resources acquired with it should share the lifetime o=
f an
>> immutable reference to it. Let's now pretend `.lock_with()` takes an &'1
>> IrqDisabled, and the irqs_on_and_sleep() function from before returns an
>> IrqDisabled.
>>
>> with_irqs_disabled(|irq| { // <- still passed by value here
>>   let some_guard =3D some_spinlockirq.lock_with(&irq); // <- Guard<'1, =
=E2=80=A6>
>>
>>   let irq =3D irqs_on_and_sleep(irq); // The lifetime of '1 ends here
>>
>>   some_function(some_guard.some_data);
>>   // Success! ^ this fails to compile, as '1 no longer lives long enough
>>   // for the guard to still be usable.
>>   // Deadlock averted :)
>> )}
>>
>> Then if we were to add bindings for things like
>> wait_event_lock_interruptible_irq() - we could have those take both the
>> IrqDisabled token and the Guard<'1, =E2=80=A6> by value - and then retur=
n them
>> afterwards. Which I believe would fix the soundness issue :)
>>
>> How does that sound to everyone?
>=20
> I should note though - after thinking about this for a moment, I realized=
 that
> there are still some issues with this. For instance: Since
> with_irqs_disabled() can still be nested, a nested with_irqs_disabled() c=
all
> could create another IrqDisabled with its own lifetime - and thus we woul=
dn't
> be able to do this same lifetime trick with any resources acquired outsid=
e the
> nested call.
>=20
> Granted - we -do- still have lockdep for this, so in such a situation wit=
h a
> lockdep-enabled kernel we would certainly get a warning when this happens=
. I
> think one option we might have if we wanted to go a bit further with safe=
ty
> here: maybe we could do something like this:
>=20
>=20
> pub fn with_irqs_disabled<T>(cb: impl for<'a> FnOnce(IrqDisabled<'a>) -> =
T) -> T {
>   // With this function, we would assert that IRQs are not enabled at the=
 start
>   =E2=80=A6
> }
>=20
> (I am a bit new to HRTBs, so the syntax here might not be right - but
> hopefully you can still follow what I mean)
>=20
> pub fn with_nested_irqs_disabled<T>(
>   irq: impl for<'a> Option<&'a mut IrqDisabled<'a>>,

This doesn't make sense, since `impl` can only be used on traits and
`Option` is not a trait.

>   cb: impl for<'a> FnOnce(IrqDisabled<'a>) -> T,
> ) -> T {
>   // With this function, we would assert that IRQs are disabled=20
>   // if irq.is_some(), otherwise we would assert they're disabled
>   // Since we require a mutable reference, this would still invalidate an=
y
>   // borrows which rely on the previous IrqDisabled token
>   =E2=80=A6
> }

I don't see the utility of this, if you already have an `IrqDisabled`,
then you don't need to call `with_irqs_disabled`. If you don't have one,
irqs still might be disabled, but you don't know.

> Granted - I have no idea how ergonomic something like this would be since=
 on
> the C side of things: we don't really require that the user know the prio=
r IRQ
> state for things like irqsave/irqrestore functions.

I think ergonomically, this is a bad idea, since it will infect a lot of
functions that don't care about IRQ.

---
Cheers,
Benno


