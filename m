Return-Path: <linux-kernel+bounces-350052-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BB1C998FF25
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 10:58:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E8B421C22FD8
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 08:58:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F836145324;
	Fri,  4 Oct 2024 08:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="nf8gL2Pg"
Received: from mail-4316.protonmail.ch (mail-4316.protonmail.ch [185.70.43.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0DCC81ACA;
	Fri,  4 Oct 2024 08:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728032306; cv=none; b=QnpCf19Oiwi6Ly+MDVMb6kOQPXc4kP9VvWu4psrDE2YoY6gBTAUExSMNUwze4dcVfciJHusj2W7/xUnS8vP2CrL/BB7uUhoR+ap98DNKzNkBQjS9NLhQfH+/ftgD/0dG6wI+aSbituMdkntSG4jCQKFw+RA41+Ndg5EhS15L4bQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728032306; c=relaxed/simple;
	bh=WOeAc7PFWVtSdjXedkq/dF5zgKbwz9xsLzK/vtFgejE=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gujHgBnVbS/YnGnqmYd94qOp8VU3O61t/hUwyqvBYUiNKa2FAeBEiRWifQqjzj1+guSa79zUNyoz8++SBvjHR1FpE5unmPRsaIimvkJAZESLTfa00SE6ORMFsKtYHloMPaNZOBDLYJtPqOsTxLzERUQusHs7oP6EfL8UojnYuAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=nf8gL2Pg; arc=none smtp.client-ip=185.70.43.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1728032301; x=1728291501;
	bh=o2BBn2+oVbm1eBSGco/IfqEOVhAZC2crj7VG3KHRDKg=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=nf8gL2PgN+4rWerveD/cy7pc1xZjdN5+Q+iPVS6dzZ2Ez+EYAVNcrMp6j45URvSN3
	 vTql2tbqb/1jROx0X6CNRoi5gAVuYPjsdj3/HF4Kp23NX36zn54QA93HBTZ/oDF8kr
	 ItSoMMwPpaBy/BNi8xkSorzh7JNZNPg8AaTXtg1kFcOREMG2i3kQgXv7/ZZWqbeVK3
	 5iPP2LP9mpDg1eZLjZdmu4LxTrsf0OY95cPGRFxR9lHKqxpLoOt2P57LWfpph+iluH
	 4yFclGUlDB4PBlxSGlvj4s8SWqNY/Q3c1arUqnBEfQhqPQc9no+UecyKZ6JKxpEv+k
	 WKSOkiJ65scRg==
Date: Fri, 04 Oct 2024 08:58:18 +0000
To: Thomas Gleixner <tglx@linutronix.de>, Lyude Paul <lyude@redhat.com>, rust-for-linux@vger.kernel.org
From: Benno Lossin <benno.lossin@proton.me>
Cc: Danilo Krummrich <dakr@redhat.com>, airlied@redhat.com, Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>, Waiman Long <longman@redhat.com>, Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org, Daniel Almeida <daniel.almeida@collabora.com>, Gary Guo <gary@garyguo.net>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@samsung.com>, Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, FUJITA Tomonori <fujita.tomonori@gmail.com>, Valentin Obst <kernel@valentinobst.de>
Subject: Re: [PATCH v6 1/3] rust: Introduce irq module
Message-ID: <aa573189-e42d-4d62-84a3-dda9fbed0b33@proton.me>
In-Reply-To: <875xqaw92u.ffs@tglx>
References: <20240916213025.477225-1-lyude@redhat.com> <20240916213025.477225-2-lyude@redhat.com> <875xqaw92u.ffs@tglx>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: 701864195eaf2eebb654cd4f7558785a2e7d1e41
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 02.10.24 22:20, Thomas Gleixner wrote:
> On Mon, Sep 16 2024 at 17:28, Lyude Paul wrote:
>>  rust/helpers/helpers.c |  1 +
>>  rust/helpers/irq.c     | 22 ++++++++++
>>  rust/kernel/irq.rs     | 96 ++++++++++++++++++++++++++++++++++++++++++
>=20
> irq is a patently bad name for this as it might get confused or conflict
> with actual interrupt related functions irq_.....
>=20
> The C naming is not ideal either but it's all about the CPU local
> interrupt enable/disable, while irq_*() is related to actual interrupt
> handling and chips.
>=20
> So can we please have some halfways sensible mapping to the C namings?

What do you suggest? `local_irq.rs`?

>> +/// Run the closure `cb` with interrupts disabled on the local CPU.
>> +///
>> +/// This disables interrupts, creates an [`IrqDisabled`] token and pass=
es it to `cb`. The previous
>> +/// interrupt state will be restored once the closure completes. Note t=
hat interrupts must be
>> +/// disabled for the entire duration of `cb`, they cannot be re-enabled=
. In the future, this may be
>> +/// expanded on [as documented here](https://github.com/Rust-for-Linux/=
linux/issues/1115).
>> +///
>> +/// # Examples
>> +///
>> +/// Using [`with_irqs_disabled`] to call a function that can only be ca=
lled with interrupts
>> +/// disabled:
>> +///
>> +/// ```
>> +/// use kernel::irq::{IrqDisabled, with_irqs_disabled};
>> +///
>> +/// // Requiring interrupts be disabled to call a function
>> +/// fn dont_interrupt_me(_irq: IrqDisabled<'_>) {
>> +///     // When this token is available, IRQs are known to be disabled.=
 Actions that rely on this
>> +///     // can be safely performed
>> +/// }
>> +///
>> +/// // Disables interrupts, their previous state will be restored once =
the closure completes.
>> +/// with_irqs_disabled(|irq| dont_interrupt_me(irq));
>> +/// ```
>> +#[inline]
>> +pub fn with_irqs_disabled<T>(cb: impl for<'a> FnOnce(IrqDisabled<'a>) -=
> T) -> T {
>> +    // SAFETY: FFI call with no special requirements
>> +    let flags =3D unsafe { bindings::local_irq_save() };
>> +
>> +    // SAFETY: We just disabled IRQs using `local_irq_save()`
>> +    let ret =3D cb(unsafe { IrqDisabled::new() });
>=20
> What's the point of the IrqDisabled::new() here? The above just disabled
> them, no?

Yes, the above disabled them (the functions in `bindings` are exactly
the C functions [or helper functions, if the C function is static
inline]).

The point of `IrqDisabled` is that it is a token type signifying simply
by its existence that interrupts are disabled. The `new` function is a
way to create the token without touching the current interrupt status.

Lyude mentioned that she has a use case where C calls a Rust function
with IRQ already disabled and thus we need a way to create the token in
an unchecked manner.

>> +    // Confirm that IRQs are still disabled now that the callback has f=
inished
>> +    // SAFETY: FFI call with no special requirements
>> +    debug_assert!(unsafe { bindings::irqs_disabled() });
>=20
> And here you open code the check which is in IrqDisabled::new()
>=20
> So I'd rather see this as:
>=20
>    token =3D unsafe { IrqDisabled::new() };
>    let ret =3D cb(token);
>    assert_valid(token);
>=20
> I might misunderstand rust here, but the provided code does not make
> sense to me.

The purpose of this check is to catch any dumb implementations of the
closure `cb` passed to the function. For example

    with_irqs_disabled(|irq| {
        let guard =3D spin_lock_irq.lock(irq); // lock a spinlock with IRQ =
disabled
        unsafe { enable_irq() };
        drop(guard); // unlock it with IRQ being enabled
    });

The debug assert would catch this error.


Of course we can move the debug assert into its own function taking the
token. I think it's a good idea.

---
Cheers,
Benno


