Return-Path: <linux-kernel+bounces-263678-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B3FE393D931
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 21:40:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6ACA72852EE
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 19:39:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 840054F218;
	Fri, 26 Jul 2024 19:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="AMjGAgxN"
Received: from mail-40131.protonmail.ch (mail-40131.protonmail.ch [185.70.40.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2FD1558B7
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 19:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722022774; cv=none; b=KBBJ+ns/3urGg2GeTurd7PRQN6Se1PhnWJJVojaiiPFASyjX9udYkpSLdBawP2esRnS08lkwmIb5pgHfrHVOMu1Cgxrjemr8xOAxuTL5TB1Mci+rjy8pglSt7B/j8v+iQRt3cUdKXMoxuOkbeDnoI1WZU93U2lZGqCSGGIOraHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722022774; c=relaxed/simple;
	bh=62U4+bWig64bnMLO3oPXd0vpFUKH0MjnH+RQce02Spg=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=E1gHARNDEkLaCacP8QC5XMSkXh974sH4hK1srSHMtYEdQf2/OjC7hEPwsaH2dXcPOM8AccMHTP9AaRYEaAPGbrwJwhyBFSUO1VH1OaqnBhocEzKjfY7GXXjOaha+vFwWzURQLkTRceckjyPeKzA6Ruz0Gb6hGXYGwPBCys74O9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=AMjGAgxN; arc=none smtp.client-ip=185.70.40.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1722022769; x=1722281969;
	bh=0UXYH9oIE8hMaPimIJfwDFmAOj+/BaOEDEyDFmRuGrw=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=AMjGAgxNil5H8pPfQqLQYdVbQBP+Of+xPSPCzjWxf7wHSmfrudJY1TsOr3J6xXKOO
	 kEjiJJnDdH5umJaKfguzzicJ0/YIan9/tgDLh0nnx9ovdcAIhOXjObyVe9TgIKIqI6
	 5MNPiGbTD0T9QtXAjfthKT6zl3yuSuliFKTb+jZD3DoHSgRxsz59ZoI2JcDBL36SNm
	 Y421hk1wQFJiTvVAxOs0Rz/GhGzvmApRtghOx1FwONYyImqlCvGmwceOrqCEHNo19J
	 sJnAoztSLULZdV/BZNXwgnf+9IvLBFmoM4rH42I8OXGw67Y1Jbq6YwDn7TZMigzQCP
	 rcKFQxJVYYqSw==
Date: Fri, 26 Jul 2024 19:39:21 +0000
To: Lyude Paul <lyude@redhat.com>, rust-for-linux@vger.kernel.org
From: Benno Lossin <benno.lossin@proton.me>
Cc: Danilo Krummrich <dakr@redhat.com>, airlied@redhat.com, Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>, Waiman Long <longman@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@samsung.com>, Alice Ryhl <aliceryhl@google.com>, Martin Rodriguez Reboredo <yakoyoku@gmail.com>, FUJITA Tomonori <fujita.tomonori@gmail.com>, Aakash Sen Sharma <aakashsensharma@gmail.com>, Valentin Obst <kernel@valentinobst.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] rust: Introduce irq module
Message-ID: <6e13df3f-6132-43c3-aaba-98b9b9ddd48e@proton.me>
In-Reply-To: <27110c6b7d4674e1003417fc8b5a03bde1eed4ef.camel@redhat.com>
References: <20240725222822.1784931-1-lyude@redhat.com> <20240725222822.1784931-2-lyude@redhat.com> <b1190e12-f3a6-41cb-a925-ee011650ed60@proton.me> <27110c6b7d4674e1003417fc8b5a03bde1eed4ef.camel@redhat.com>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: 84e4c3cf0f199084a01cd46c693fdb89e5ff0a82
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 26.07.24 20:18, Lyude Paul wrote:
> On Fri, 2024-07-26 at 07:23 +0000, Benno Lossin wrote:
>> On 26.07.24 00:27, Lyude Paul wrote:
>>> +}
>>> +
>>> +/// Run the closure `cb` with interrupts disabled on the local CPU.
>>> +///
>>> +/// Interrupts will be re-enabled once the closure returns. If interru=
pts were already disabled on
>>> +/// this CPU, this is a no-op.
>>> +#[inline]
>>> +pub fn with_irqs_disabled<T, F>(cb: F) -> T
>>> +where
>>> +    F: FnOnce(IrqDisabled<'_>) -> T,
>>> +{
>>> +    // SAFETY: FFI call with no special requirements
>>
>> I vaguely remember that there were some problems with sleeping in IRQ
>> disabled contexts, is that me just misremembering (eg confusing it with
>> atomic context), or do we need to watch out for that?
>=20
> You're correct - sleeping isn't allowed in no-irq contexts.
>=20
>> Because if that is the case, then we would need to use klint.
>=20
> Ok - I've never used klint before but I'm happy to look into it and try t=
o
> implement something for it.

I am not 100% up to date, last time I heard Gary (the maintainer/author
of klint) talk about it, I remember that it wasn't fully ready for this
stuff. Don't know if this has changed in the meantime.
I don't think this is anything that you can do much, since it's rather
complex, so I will just ping Gary on the status.

> FWIW too: I assume we would still want klint anyway, but I think it's at =
least
> worth mentioning the kernel does have a compile option for WARNing on sle=
eps
> in sleepless contexts

So the plan always was to not make it a hard error. Essentially instead
of having `unsafe` littered al over the place when you switch context,
klint would ensure (like the borrow checker for ownership) that
everything is fine.

>>> +    let flags =3D unsafe { bindings::local_irq_save() };
>>> +
>>> +    let ret =3D cb(IrqDisabled(PhantomData));
>>> +
>>> +    // SAFETY: `flags` comes from our previous call to local_irq_save
>>> +    unsafe { bindings::local_irq_restore(flags) };
>>
>> Just to make sure, this function only enables interrupts, if they were
>> enabled before the call to `local_irq_save` above, right?
>=20
> Correct - `local_irq_save()` only saves the CPU's current IRQ flags. So i=
f
> interrupts were already disabled in the context we call `local_irq_save()=
`, we
> end up restoring the same IRQ-disabled flags on the processor when we get=
 to
> `local_irq_restore()`. This is also why the closure interface for this is
> necessary - to ensure that nested interrupt flag saves are always undone =
in
> the reverse order to ensure this assumption always holds.

Thanks, that was exactly what I assumed.

---
Cheers,
Benno


