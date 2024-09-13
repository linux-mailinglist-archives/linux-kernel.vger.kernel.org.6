Return-Path: <linux-kernel+bounces-328267-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A726297813A
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 15:34:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 27A8F1F26019
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 13:34:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 432D31DA62F;
	Fri, 13 Sep 2024 13:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="Op/BD4Ey"
Received: from mail-40133.protonmail.ch (mail-40133.protonmail.ch [185.70.40.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9437F43144
	for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2024 13:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726234432; cv=none; b=K0m2evIpyT/vlxZKmsPYzrp5IT0o7+kppjvbC64euA3hs+ns55vwljCB40MWdfJfpRP1v1kpOfkKtT8Ti2c3I8uHSPEzkR8y5XyxSqVAk8Q3XZCkZYZSQ3BHn2b4kub5Ewcn7X1PLeV//S4FaVQ51hjvI5/nhoU7dzSJ8Mc8duw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726234432; c=relaxed/simple;
	bh=hnObRO+BR0d8TtaxjbeGnkgGTtnOe0unp/BiDBKXZVo=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=n3TkmJ38htN0yhuzdlhJLC6WlMGhJOyekbgpi1mhUGS1pC3b6jIkKnO6jKarM38QKQgIfsCWfP+YtGeRUzfL26Lx7JrsbJnkQCRdm2d/PzyMXLtWp0Wf1KDPUJB6Y6K7HO768A/t4Ql7fijJpv4I0i5JvkvmILhVlx06Rg28HM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=Op/BD4Ey; arc=none smtp.client-ip=185.70.40.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1726234426; x=1726493626;
	bh=T6OFiEYeegJIf9cPUv8SH8bEszc9kqwNM4Y0cpIi5Sk=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=Op/BD4EyB6aV5cIBD3bMTqSvgwxg/Xmcu6RhWPU7BAYppO5fqYWz3go3deBu9e+a7
	 bHesSrqDBfhhdCS/KMnR7kblwmMjiLYINCj/89TrvyeFLUkZl0Mid36316UmCjOYk9
	 xeYUw5UI3193hZ06BcQ+Vh5C4KKTsjVR9z+3XdifT6/iBZfmxV1vexckTHKuEysdzy
	 2ZJbI5meFiP5/cpFZjC7HxhZS4g09EE8ng9XItx/ekpJNvOnMBRbeo2j+gBDIdRYsK
	 MNOyS2sLwH7nHk8vKA5tDrCHEVQcWRnB+2f4X2zcNWJvznLnhXRz016wuR/sA1lEZ9
	 SVtI/YeQKvgUQ==
Date: Fri, 13 Sep 2024 13:33:43 +0000
To: Lyude Paul <lyude@redhat.com>, rust-for-linux@vger.kernel.org
From: Benno Lossin <benno.lossin@proton.me>
Cc: Danilo Krummrich <dakr@redhat.com>, airlied@redhat.com, Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>, Waiman Long <longman@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@samsung.com>, Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, FUJITA Tomonori <fujita.tomonori@gmail.com>, Valentin Obst <kernel@valentinobst.de>
Subject: Re: [PATCH v5 1/3] rust: Introduce irq module
Message-ID: <9e2716d8-ec2c-403b-9a3d-ae9784eb9e6f@proton.me>
In-Reply-To: <20240912190540.53221-2-lyude@redhat.com>
References: <20240912190540.53221-1-lyude@redhat.com> <20240912190540.53221-2-lyude@redhat.com>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: 9bb89ce0d14944f3480f9531b3aa3766f34559aa
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 12.09.24 21:04, Lyude Paul wrote:
> This introduces a module for dealing with interrupt-disabled contexts,
> including the ability to enable and disable interrupts
> (with_irqs_disabled()) - along with the ability to annotate functions as
> expecting that IRQs are already disabled on the local CPU.
>=20
> Signed-off-by: Lyude Paul <lyude@redhat.com>
>=20
> ---
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
>=20
> V3:
> * Use `impl` for FnOnce bounds in with_irqs_disabled()
> * Use higher-ranked trait bounds for the lifetime of with_irqs_disabled()
> * Wording changes in the documentation for the module itself
>=20
> V4:
> * Use the actual unsafe constructor for IrqDisabled in
>   with_irqs_disabled()
> * Fix comment style in with_irqs_disabled example
> * Check before calling local_irq_restore() in with_irqs_disabled that
>   interrupts are still disabled. It would have been nice to do this from =
a
>   Drop implementation like I hoped, but I realized rust doesn't allow tha=
t
>   for types that implement Copy.
> * Document that interrupts can't be re-enabled within the `cb` provided t=
o
>   `with_irqs_disabled`, and link to the github issue I just filed about
>   this that describes the solution for this.
>=20
> V5:
> * Rebase against rust-next for the helpers split
> * Fix typo (enabled -> disabled) - Dirk
>=20
> Signed-off-by: Lyude Paul <lyude@redhat.com>
> ---
>  rust/helpers/helpers.c |  1 +
>  rust/helpers/irq.c     | 22 +++++++++++
>  rust/kernel/irq.rs     | 90 ++++++++++++++++++++++++++++++++++++++++++
>  rust/kernel/lib.rs     |  1 +
>  4 files changed, 114 insertions(+)
>  create mode 100644 rust/helpers/irq.c
>  create mode 100644 rust/kernel/irq.rs

This looks pretty good, I have two documentation improvements below,
with those fixed:

Reviewed-by: Benno Lossin <benno.lossin@proton.me>

> diff --git a/rust/kernel/irq.rs b/rust/kernel/irq.rs
> new file mode 100644
> index 0000000000000..0673087161f08
> --- /dev/null
> +++ b/rust/kernel/irq.rs
> @@ -0,0 +1,90 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +//! Interrupt controls
> +//!
> +//! This module allows Rust code to control processor interrupts. [`with=
_irqs_disabled()`] may be
> +//! used for nested disables of interrupts, whereas [`IrqDisabled`] can =
be used for annotating code
> +//! that requires interrupts to be disabled.
> +
> +use bindings;
> +use core::marker::*;
> +
> +/// A token that is only available in contexts where IRQs are disabled.
> +///
> +/// [`IrqDisabled`] is marker made available when interrupts are not act=
ive. Certain functions take
> +/// an [`IrqDisabled`] in order to indicate that they may only be run in=
 IRQ-free contexts.

I feel like "indicate" is not strong enough, how about using "require"?

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



> +/// Run the closure `cb` with interrupts disabled on the local CPU.
> +///
> +/// This creates an [`IrqDisabled`] token, which can be passed to functi=
ons that must be run
> +/// without interrupts. Note that interrupts must be disabled for the en=
tire duration of `cb`, they
> +/// cannot be re-enabled. In the future, this may be expanded on
> +/// [as documented here](https://github.com/Rust-for-Linux/linux/issues/=
1115).
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
> +///     // When this token is available, IRQs are known to be disabled. =
Actions that rely on this
> +///     // can be safely performed
> +/// }
> +///
> +/// // Disabling interrupts. They'll be re-enabled once this closure com=
pletes.

Please change this to be "Disables interrupts, their previous state will
be restored once the closure completes.".
ie it is important to stress that this can be nested. Please also add
this in a paragraph above the examples.

---
Cheers,
Benno

> +/// with_irqs_disabled(|irq| dont_interrupt_me(irq));
> +/// ```
> +#[inline]
> +pub fn with_irqs_disabled<T>(cb: impl for<'a> FnOnce(IrqDisabled<'a>) ->=
 T) -> T {
> +    // SAFETY: FFI call with no special requirements
> +    let flags =3D unsafe { bindings::local_irq_save() };
> +
> +    // SAFETY: We just disabled IRQs using `local_irq_save()`
> +    let ret =3D cb(unsafe { IrqDisabled::new() });
> +
> +    // Confirm that IRQs are still disabled now that the callback has fi=
nished
> +    // SAFETY: FFI call with no special requirements
> +    debug_assert!(unsafe { bindings::irqs_disabled() });
> +
> +    // SAFETY: `flags` comes from our previous call to local_irq_save
> +    unsafe { bindings::local_irq_restore(flags) };
> +
> +    ret
> +}
> diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
> index f10b06a78b9d5..df10c58e95c19 100644
> --- a/rust/kernel/lib.rs
> +++ b/rust/kernel/lib.rs
> @@ -36,6 +36,7 @@
>  pub mod firmware;
>  pub mod init;
>  pub mod ioctl;
> +pub mod irq;
>  #[cfg(CONFIG_KUNIT)]
>  pub mod kunit;
>  pub mod list;
> --
> 2.46.0
>=20


