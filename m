Return-Path: <linux-kernel+bounces-271044-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BF659448CE
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 11:52:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E2EF0B23AF8
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 09:52:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C28FE170A2F;
	Thu,  1 Aug 2024 09:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="b2cJsUQ3"
Received: from mail-40133.protonmail.ch (mail-40133.protonmail.ch [185.70.40.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD93F16F267
	for <linux-kernel@vger.kernel.org>; Thu,  1 Aug 2024 09:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722505916; cv=none; b=nRw8HcT2viVYMGXfdNUN25Es2b/+72jepmc0Scom9aX+/9NKtKLnWPMPY5xWUhc1Lg17GYFlQaPjUD4nJiSoO7o5+0HcfbOsZc15D8O9IWtL1NuXMU7yqfi4Tbxlzy3IzcPiXnIlq7M/5CeGb4iWuObCTW24oqFmiXF24eIBJaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722505916; c=relaxed/simple;
	bh=C0XskGYrLDrhcCXqOfPqyQyVpf+egCNTgLPIQb3I1yk=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AfP24M1cRErrMgH3kZxS78H525QfbPBI8WIPILZSBgBq9sMAndkFCWACHbFAw68BMy7sr+odSUXu85Hy2+rin0nANVMbByjcG9AuTbuIhHCfGe54h6CyMHDmzSVoGu/o+RKhvTXTDJD15jte/6sY6MrQwZtvfpbqt3dDoPeRpEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=b2cJsUQ3; arc=none smtp.client-ip=185.70.40.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1722505912; x=1722765112;
	bh=OsALYCvwycr9yaVJAEsEdc+8bx1pn8I8QF3Sig1b9pQ=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=b2cJsUQ3Erl6Yt8ZUptbGYnacRtKmojhltsJaehpPIyHXHd8G4nc8EBkhOrsXv5w5
	 3W89pjPvQWuzY8rVGn2rDwtyhVRERqhQn9iEEpk+S/WfL0Hi0Ea14Tyc7hI+MMj+so
	 tV/9jucayp3rGoZwaJqkaESoNPX6L3fizVG+VUtqGLa4bKAgJiG0XiWYOnnelpASUb
	 /3FFlWEEUceIzkSnJKKsVoUuLe/lpRlOYMUx+T0BLmeLrzk+qrw0raGpJ60YW12rM1
	 0matb/0kszE2EX2d33HG1J3V2R0meDdWUINboTCO8Nv3hgZuPnfsNc9Prsz3fnNMsU
	 z/6Jtzdl2USmQ==
Date: Thu, 01 Aug 2024 09:51:48 +0000
To: Lyude Paul <lyude@redhat.com>, rust-for-linux@vger.kernel.org
From: Benno Lossin <benno.lossin@proton.me>
Cc: Danilo Krummrich <dakr@redhat.com>, airlied@redhat.com, Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>, Waiman Long <longman@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@samsung.com>, Alice Ryhl <aliceryhl@google.com>, Martin Rodriguez Reboredo <yakoyoku@gmail.com>, FUJITA Tomonori <fujita.tomonori@gmail.com>, Aakash Sen Sharma <aakashsensharma@gmail.com>, Valentin Obst <kernel@valentinobst.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] rust: Introduce irq module
Message-ID: <fadbccec-a51e-47ff-9c96-0aab043048c8@proton.me>
In-Reply-To: <20240731224027.232642-2-lyude@redhat.com>
References: <20240731224027.232642-1-lyude@redhat.com> <20240731224027.232642-2-lyude@redhat.com>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: 8d17ec62b62256f40fe96b053a23b4e3bb1a8715
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01.08.24 00:35, Lyude Paul wrote:
> This introduces a module for dealing with interrupt-disabled contexts,
> including the ability to enable and disable interrupts
> (with_irqs_disabled()) - along with the ability to annotate functions as
> expecting that IRQs are already disabled on the local CPU.
>=20
> V2:
> * Actually make it so that we check whether or not we have interrupts
>   disabled with debug assertions
> * Fix issues in the documentation (added suggestions, missing periods, ma=
de
>   sure that all rustdoc examples compile properly)
> * Pass IrqDisabled by value, not reference
> * Ensure that IrqDisabled is !Send and !Sync using
>   PhantomData<(&'a (), *mut ())>
> * Add all of the suggested derives from Benno Lossin

Changelogs are not recorded in the commit message, instead you can put
them either in the cover letter or underneath the "---" that is below
the tags.

> Signed-off-by: Lyude Paul <lyude@redhat.com>
> ---

ie here (anything that you put here will not be included in the final
commit message).

>  rust/helpers.c     | 22 ++++++++++++
>  rust/kernel/irq.rs | 87 ++++++++++++++++++++++++++++++++++++++++++++++
>  rust/kernel/lib.rs |  1 +
>  3 files changed, 110 insertions(+)
>  create mode 100644 rust/kernel/irq.rs
>=20
> diff --git a/rust/helpers.c b/rust/helpers.c
> index 87ed0a5b60990..b0afe14372ae3 100644
> --- a/rust/helpers.c
> +++ b/rust/helpers.c
> @@ -69,6 +69,28 @@ void rust_helper_spin_unlock(spinlock_t *lock)
>  }
>  EXPORT_SYMBOL_GPL(rust_helper_spin_unlock);
>=20
> +unsigned long rust_helper_local_irq_save(void)
> +{
> +=09unsigned long flags;
> +
> +=09local_irq_save(flags);
> +
> +=09return flags;
> +}
> +EXPORT_SYMBOL_GPL(rust_helper_local_irq_save);
> +
> +void rust_helper_local_irq_restore(unsigned long flags)
> +{
> +=09local_irq_restore(flags);
> +}
> +EXPORT_SYMBOL_GPL(rust_helper_local_irq_restore);
> +
> +bool rust_helper_irqs_disabled(void)
> +{
> +=09return irqs_disabled();
> +}
> +EXPORT_SYMBOL_GPL(rust_helper_irqs_disabled);
> +
>  void rust_helper_init_wait(struct wait_queue_entry *wq_entry)
>  {
>  =09init_wait(wq_entry);
> diff --git a/rust/kernel/irq.rs b/rust/kernel/irq.rs
> new file mode 100644
> index 0000000000000..e50110f92f3fa
> --- /dev/null
> +++ b/rust/kernel/irq.rs
> @@ -0,0 +1,87 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +//! Interrupt controls
> +//!
> +//! This module allows Rust code to control processor interrupts. [`with=
_irqs_disabled()`] may be
> +//! used for nested disables of interrupts, whereas [`IrqDisabled`] can =
be used for annotating code
> +//! that requires that interrupts already be disabled.

My intuition is telling me "requires that interrupts are already
disabled." sounds more natural, but I might be wrong.

> +
> +use bindings;
> +use core::marker::*;
> +
> +/// A token that is only available in contexts where IRQs are disabled.
> +///
> +/// [`IrqDisabled`] is marker made available when interrupts are not act=
ive. Certain functions take
> +/// an `IrqDisabled` in order to indicate that they may only be run in I=
RQ-free contexts.
> +///
> +/// This is a marker type; it has no size, and is simply used as a compi=
le-time guarantee that
> +/// interrupts are disabled where required.
> +///
> +/// This token can be created by [`with_irqs_disabled`]. See [`with_irqs=
_disabled`] for examples and
> +/// further information.
> +#[derive(Copy, Clone, Debug, Ord, Eq, PartialOrd, PartialEq, Hash)]
> +pub struct IrqDisabled<'a>(PhantomData<(&'a (), *mut ())>);
> +
> +impl IrqDisabled<'_> {
> +    /// Create a new [`IrqDisabled`] without disabling interrupts.
> +    ///
> +    /// This creates an [`IrqDisabled`] token, which can be passed to fu=
nctions that must be run
> +    /// without interrupts. If debug assertions are enabled, this functi=
on will assert that
> +    /// interrupts are disabled upon creation. Otherwise, it has no size=
 or cost at runtime.
> +    ///
> +    /// # Panics
> +    ///
> +    /// If debug assertions are enabled, this function will panic if int=
errupts are not disabled
> +    /// upon creation.
> +    ///
> +    /// # Safety
> +    ///
> +    /// This function must only be called in contexts where it is alread=
y known that interrupts have
> +    /// been disabled for the current CPU, as the user is making a promi=
se that they will remain
> +    /// disabled at least until this [`IrqDisabled`] is dropped.

This is a bit verbose for taste, what about:
"Must only be called in contexts where interrupts are disabled for the
current CPU. Additionally they must remain disabled at least until the
returned value is dropped."

Importantly the second sentence is not 100% clear from your version.
Feel free to take mine (with modifications).

> +    pub unsafe fn new() -> Self {

Do we need this to be public? Ie do you (or someone you know) have a
usecase for this? If not, then we can start with this function being
private and make it public when necessary.

> +        // SAFETY: FFI call with no special requirements
> +        debug_assert!(unsafe { bindings::irqs_disabled() });
> +
> +        Self(PhantomData)
> +    }
> +}
> +
> +/// Run the closure `cb` with interrupts disabled on the local CPU.
> +///
> +/// This creates an [`IrqDisabled`] token, which can be passed to functi=
ons that must be run
> +/// without interrupts.
> +///
> +/// # Examples
> +///
> +/// Using [`with_irqs_disabled`] to call a function that can only be cal=
led with interrupts
> +/// disabled:
> +///
> +/// ```
> +/// use kernel::irq::{IrqDisabled, with_irqs_disabled};
> +///
> +/// // Requiring interrupts be disabled to call a function
> +/// fn dont_interrupt_me(_irq: IrqDisabled<'_>) {
> +///     /* When this token is available, IRQs are known to be disabled. =
Actions that rely on this
> +///      * can be safely performed
> +///      */
> +/// }
> +///
> +/// // Disabling interrupts. They'll be re-enabled once this closure com=
pletes.
> +/// with_irqs_disabled(|irq| dont_interrupt_me(irq));
> +/// ```
> +#[inline]
> +pub fn with_irqs_disabled<'a, T, F>(cb: F) -> T
> +where
> +    F: FnOnce(IrqDisabled<'a>) -> T,

You can use this as the signature:
   =20
    pub fn with_irqs_disabled<'a, T>(cb: impl FnOnce(IrqDisabled<'a>) -> T)=
 -> T

Not sure if we have any convention for this, but I personally think this
version is easier to parse.

---
Cheers,
Benno

> +{
> +    // SAFETY: FFI call with no special requirements
> +    let flags =3D unsafe { bindings::local_irq_save() };
> +
> +    let ret =3D cb(IrqDisabled(PhantomData));
> +
> +    // SAFETY: `flags` comes from our previous call to local_irq_save
> +    unsafe { bindings::local_irq_restore(flags) };
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


