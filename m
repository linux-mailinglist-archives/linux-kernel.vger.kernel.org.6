Return-Path: <linux-kernel+bounces-262927-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D7CAD93CEC3
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 09:23:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 075721C216AC
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 07:23:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 567DA176258;
	Fri, 26 Jul 2024 07:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="gWB9JoTo"
Received: from mail-4322.protonmail.ch (mail-4322.protonmail.ch [185.70.43.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A941FA2A;
	Fri, 26 Jul 2024 07:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721978596; cv=none; b=Y45+Zu1OKY9VaNITszw6NAkJrZymWIj+0rH/8hL+blaS1fqzay8OTpGc1RfIMET6tyxJ9jbvQ/235o0P8G7qZ92e7Dr8hTGQ94k5mmNxnfqayT8h+knuKt9ElvBvXW5FQ3jCDFZg0EVIdqNeOY6M+OZ3GN4QtxiUSwCchyfLJ9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721978596; c=relaxed/simple;
	bh=/HSVDOvX35VxeQgw/Ror3T/qSi+sW+BQlem4nb87F9M=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BlOuTLxLus0EX636Ngcfb9qrmxrQuDaeRP7J/1R3JncbzipE+zpHDd1MNQzVzf6OR5RPQ2WALm3/QtAf5NDdcQCLu4pnE6fzVOclegIAWw45DDWStCM1Mr/2XMfDhHOt5HQK1Ozx859jiKYkr25QvM9CpoQyFInep7nlevayIkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=gWB9JoTo; arc=none smtp.client-ip=185.70.43.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1721978591; x=1722237791;
	bh=sTO8VOoESIExkdWO+kUm0Zi8HVb8pOSPklEylD50mzQ=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=gWB9JoToQXyMOgx1FHrCaLQjXl5AaGneELD7ruYiJwKB8vp33ckF8b8vo4XJIjVRs
	 TCCKjtk3Z+KwSyiosp46oYDZhz0OgMTr4NmvBwgtPJt62Kxs69zgQDRVtCFgBuHwgf
	 sxr3oiS/eN+U/6G+u1Cb/lJL6fH8tx94B68FknuuDqVVfQN9rDWANaY7ad/wKNfMBH
	 cOUrf61jjTv5mdZEXzfFhHqWGvC2bTjuQZdQZYZJQzc5JCWtZiuUDfkWwGkkI7CTkA
	 Cq2Kfy2OhFB7S2m+CGgwaPpKF4kpXrdVezHJnipMbbr94zKVK2FHJrNopxmIMUWuHH
	 4+fIENefoA/xQ==
Date: Fri, 26 Jul 2024 07:23:07 +0000
To: Lyude Paul <lyude@redhat.com>, rust-for-linux@vger.kernel.org
From: Benno Lossin <benno.lossin@proton.me>
Cc: Danilo Krummrich <dakr@redhat.com>, airlied@redhat.com, Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>, Waiman Long <longman@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@samsung.com>, Alice Ryhl <aliceryhl@google.com>, Martin Rodriguez Reboredo <yakoyoku@gmail.com>, FUJITA Tomonori <fujita.tomonori@gmail.com>, Aakash Sen Sharma <aakashsensharma@gmail.com>, Valentin Obst <kernel@valentinobst.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] rust: Introduce irq module
Message-ID: <b1190e12-f3a6-41cb-a925-ee011650ed60@proton.me>
In-Reply-To: <20240725222822.1784931-2-lyude@redhat.com>
References: <20240725222822.1784931-1-lyude@redhat.com> <20240725222822.1784931-2-lyude@redhat.com>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: 757d4963eeb7c111d075df476ee5b4813c8c4e7a
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 26.07.24 00:27, Lyude Paul wrote:
> This introduces a module for dealing with interrupt-disabled contexts,
> including the ability to enable and disable interrupts
> (with_irqs_disabled()) - along with the ability to annotate functions as
> expecting that IRQs are already disabled on the local CPU.
>=20
> Signed-off-by: Lyude Paul <lyude@redhat.com>
> ---
>  rust/helpers.c     | 14 +++++++++
>  rust/kernel/irq.rs | 74 ++++++++++++++++++++++++++++++++++++++++++++++
>  rust/kernel/lib.rs |  1 +
>  3 files changed, 89 insertions(+)
>  create mode 100644 rust/kernel/irq.rs
>=20
> diff --git a/rust/helpers.c b/rust/helpers.c
> index 87ed0a5b60990..12ac32de820b5 100644
> --- a/rust/helpers.c
> +++ b/rust/helpers.c
> @@ -69,6 +69,20 @@ void rust_helper_spin_unlock(spinlock_t *lock)
>  }
>  EXPORT_SYMBOL_GPL(rust_helper_spin_unlock);
>=20
> +unsigned long rust_helper_local_irq_save(void) {
> +=09unsigned long flags;
> +
> +=09local_irq_save(flags);
> +
> +=09return flags;
> +}
> +EXPORT_SYMBOL_GPL(rust_helper_local_irq_save);
> +
> +void rust_helper_local_irq_restore(unsigned long flags) {
> +=09local_irq_restore(flags);
> +}
> +EXPORT_SYMBOL_GPL(rust_helper_local_irq_restore);
> +
>  void rust_helper_init_wait(struct wait_queue_entry *wq_entry)
>  {
>  =09init_wait(wq_entry);
> diff --git a/rust/kernel/irq.rs b/rust/kernel/irq.rs
> new file mode 100644
> index 0000000000000..8a540bd6123f7
> --- /dev/null
> +++ b/rust/kernel/irq.rs
> @@ -0,0 +1,74 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +//! Interrupt controls
> +//!
> +//! This module allows Rust code to control processor interrupts. [`with=
_irqs_disabled()`] may be
> +//! used for nested disables of interrupts, whereas [`IrqDisabled`] can =
be used for annotating code
> +//! that requires that interrupts already be disabled.
> +
> +use bindings;
> +use core::marker::*;
> +
> +/// A guarantee that IRQs are disabled on this CPU
> +///
> +/// An [`IrqDisabled`] represents a guarantee that interrupts will remai=
n disabled on the current CPU
> +/// until the lifetime of the object ends. However, it does not disable =
or enable interrupts on its
> +/// own - see [`with_irqs_disabled()`] for that.
> +///
> +/// This object has no cost at runtime (TODO: =E2=80=A6except if whateve=
r kernel compile-time option that
> +/// would assert IRQs are enabled or not is enabled - in which case we s=
hould actually verify that
> +/// they're enabled).
> +///
> +/// # Examples
> +///
> +/// If you want to ensure that a function may only be invoked within con=
texts where interrupts are
> +/// disabled, you can do so by requiring that a reference to this type b=
e passed. You can also
> +/// create this type using unsafe code in order to indicate that it's kn=
own that interrupts are
> +/// already disabled on this CPU
> +///
> +/// ```
> +/// use kernel::irq::{IrqDisabled, disable_irqs};
> +///
> +/// // Requiring interrupts be disabled to call a function
> +/// fn dont_interrupt_me(_irq: &IrqDisabled<'_>) { }

I would expect the function to take `IrqDisabled` by value instead of by
reference.

> +///
> +/// // Disabling interrupts. They'll be re-enabled once this closure com=
pletes.
> +/// disable_irqs(|irq| dont_interrupt_me(&irq));

Because then you don't need a borrow (`&`) here.

> +/// ```
> +pub struct IrqDisabled<'a>(PhantomData<&'a ()>);

You would also need to `#[derive(Clone, Copy)]` and since we're at it, I
would also add `Debug, Ord, Eq, PartialOrd, PartialEq, Hash`.
The last ones are important if we want to have structs that can only
exist while IRQs are disabled. I don't know if that makes sense, but I
think it's fine to add the derives now.

Another thing, I am wondering if we want this to be invariant over the
lifetime, I don't have a good reason, but I still think we should
consider it.

> +
> +impl<'a> IrqDisabled<'a> {
> +    /// Create a new [`IrqDisabled`] without disabling interrupts
> +    ///
> +    /// If debug assertions are enabled, this function will check that i=
nterrupts are disabled.
> +    /// Otherwise, it has no cost at runtime.

I don't see a check in the function below.

> +    ///
> +    /// # Safety
> +    ///
> +    /// This function must only be called in contexts where it is alread=
y known that interrupts have
> +    /// been disabled for the current CPU, as the user is making a promi=
se that they will remain
> +    /// disabled at least until this [`IrqDisabled`] is dropped.
> +    pub unsafe fn new() -> Self {
> +        Self(PhantomData)
> +    }

What about adding a function here (taking `self` or `&self`, it doesn't
matter if you derived `Copy`) that checks if IRQs are disabled when
debug assertions are on?

> +}
> +
> +/// Run the closure `cb` with interrupts disabled on the local CPU.
> +///
> +/// Interrupts will be re-enabled once the closure returns. If interrupt=
s were already disabled on
> +/// this CPU, this is a no-op.
> +#[inline]
> +pub fn with_irqs_disabled<T, F>(cb: F) -> T
> +where
> +    F: FnOnce(IrqDisabled<'_>) -> T,
> +{
> +    // SAFETY: FFI call with no special requirements

I vaguely remember that there were some problems with sleeping in IRQ
disabled contexts, is that me just misremembering (eg confusing it with
atomic context), or do we need to watch out for that?
Because if that is the case, then we would need to use klint.

> +    let flags =3D unsafe { bindings::local_irq_save() };
> +
> +    let ret =3D cb(IrqDisabled(PhantomData));
> +
> +    // SAFETY: `flags` comes from our previous call to local_irq_save
> +    unsafe { bindings::local_irq_restore(flags) };

Just to make sure, this function only enables interrupts, if they were
enabled before the call to `local_irq_save` above, right?

---
Cheers,
Benno

> +
> +    ret
> +}
> diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
> index e6b7d3a80bbce..37835ccd51087 100644
> --- a/rust/kernel/lib.rs
> +++ b/rust/kernel/lib.rs
> @@ -36,6 +36,7 @@
>  pub mod firmware;
>  pub mod init;
>  pub mod ioctl;
> +pub mod irq;
>  #[cfg(CONFIG_KUNIT)]
>  pub mod kunit;
>  #[cfg(CONFIG_NET)]
> --
> 2.45.2
>=20


