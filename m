Return-Path: <linux-kernel+bounces-544276-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B86DA4DF8F
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 14:45:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B6EC13B356F
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 13:45:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B11C32054E2;
	Tue,  4 Mar 2025 13:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KIWXcXBm"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFF7620469F;
	Tue,  4 Mar 2025 13:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741095851; cv=none; b=PSMa1cTiX9kIe6sHI/3xYg4qfsxYLHQ4DR3gupOaae3BLK2i8qrCfMCL1tJQ1cs2iJbfKmYyYjhLsjvV/kqFEG9TDI4bCr+sP/tZmMET4J5FlkzZKMvXpk2pHXL9guFDihhFyYbs4Qke+HxCqKVyuNIzNmRp1Ejc1r7juWgjx+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741095851; c=relaxed/simple;
	bh=yniI/zUBKnpp3li+eEXmoILiIoVM6nSrypH9r4g1WLI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=np/64Wko7nTn+SIJBsGC/gCl3N686eQX0hT/TDvOLaZ/Ijeey/XCqPUPuHi2PdFpJHfcGUjog41tZcb5uP7MWaZvFV/3Le66aAJ5Y7P6poSb0LczkGjq/SONpHbc8MpiDja3JKKT6G/P4ISI8/rRkSXGCvRoOcNY1nI+Ist+DiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KIWXcXBm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DB9CC4AF09;
	Tue,  4 Mar 2025 13:44:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741095850;
	bh=yniI/zUBKnpp3li+eEXmoILiIoVM6nSrypH9r4g1WLI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=KIWXcXBmPFmvT2w+szLK0UrGdej1WC+U4IV3Npemn8RpctAF1OpWvuzCzcysdA/Tv
	 0b1NkCEohVwnhRw3jG7kCUR4te/XrvjIzvLbicHjBV9Smz5ezaC5CkqaYaKh6nnviB
	 RWyp3e8hN2WqJmFNeSoOUgMHkBez2Wi7USqJOMkRMblVNY40jKxjqMfDduaegO9c+K
	 e5RwtbOijrnNvTtuHp4IKZKYujwVgBoMl0t9jwdVPmFB5oT3f6yl6MhyTwtCTnpBh2
	 pD7rQnPwt2s5uDyrm+s6f359g3F7TAk9GhfXCBM/WM6QynJGtnkKeBZVbuWk/jRhMl
	 ziwKYuOPxg+6w==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: "Daniel Almeida" <daniel.almeida@collabora.com>
Cc: <ojeda@kernel.org>,  <alex.gaynor@gmail.com>,  <boqun.feng@gmail.com>,
  <gary@garyguo.net>,  <bjorn3_gh@protonmail.com>,
  <benno.lossin@proton.me>,  <tmgross@umich.edu>,
  <rust-for-linux@vger.kernel.org>,  <linux-kernel@vger.kernel.org>,
  "Alice Ryhl" <aliceryhl@google.com>
Subject: Re: [PATCH v2] rust: irq: add support for request_irq()
In-Reply-To: <20250122163932.46697-1-daniel.almeida@collabora.com> (Daniel
	Almeida's message of "Wed, 22 Jan 2025 13:39:30 -0300")
References: <u-vC1KbeOK3Fd2PClzinb8LmqS_dntOW-pOSmZIFWotCZeTOg30xR_GYUc4oReAKZeuuu7ZaXWzfeTkpGMlr0A==@protonmail.internalid>
	<20250122163932.46697-1-daniel.almeida@collabora.com>
User-Agent: mu4e 1.12.7; emacs 29.4
Date: Tue, 04 Mar 2025 14:43:20 +0100
Message-ID: <87cyewhpxj.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Daniel Almeida" <daniel.almeida@collabora.com> writes:

> Add support for registering IRQ handlers in Rust.
>
> IRQ handlers are extensively used in drivers when some peripheral wants to
> obtain the CPU attention. Registering a handler will make the system invoke the
> passed-in function whenever the chosen IRQ line is triggered.
>
> Both regular and threaded IRQ handlers are supported through a Handler (or
> ThreadedHandler) trait that is meant to be implemented by a type that:
>
> a) provides a function to be run by the system when the IRQ fires and,
>
> b) holds the shared data (i.e.: `T`) between process and IRQ contexts.
>
> The requirement that T is Sync derives from the fact that handlers might run
> concurrently with other processes executing the same driver, creating the
> potential for data races.
>
> Ideally, some interior mutability must be in place if T is to be mutated. This
> should usually be done through the in-flight SpinLockIrq type.
>
> Co-developed-by: Alice Ryhl <aliceryhl@google.com>
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>
> Signed-off-by: Daniel Almeida <daniel.almeida@collabora.com>

What is the base commit to apply this patch to? I am getting some
compiler errors when trying it out:

    error[E0308]: mismatched types
      --> /home/aeh/src/linux-rust/linux/rust/kernel/irq/request.rs:240:21
        |
    237 |                 bindings::request_irq(
        |                 --------------------- arguments to this function are incorrect
    ...
    240 |                     flags.0,
        |                     ^^^^^^^ expected `usize`, found `u64`
        |

[...]

> diff --git a/rust/kernel/irq.rs b/rust/kernel/irq.rs
> new file mode 100644
> index 000000000000..3ab83c5bdb83
> --- /dev/null
> +++ b/rust/kernel/irq.rs
> @@ -0,0 +1,6 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +//! IRQ abstractions

We could do with a longer story here. Also, missing a period.

> +
> +/// IRQ allocation and handling
> +pub mod request;
> diff --git a/rust/kernel/irq/request.rs b/rust/kernel/irq/request.rs
> new file mode 100644
> index 000000000000..61e7d4a8f555
> --- /dev/null
> +++ b/rust/kernel/irq/request.rs
> @@ -0,0 +1,517 @@
> +// SPDX-License-Identifier: GPL-2.0
> +// SPDX-FileCopyrightText: Copyright 2025 Collabora ltd.
> +
> +//! IRQ allocation and handling
> +
> +use core::marker::PhantomPinned;
> +use core::ptr::addr_of_mut;
> +
> +use init::pin_init_from_closure;
> +
> +use crate::error::to_result;
> +use crate::prelude::*;
> +use crate::str::CStr;
> +
> +/// Flags to be used when registering IRQ handlers.
> +///
> +/// They can be combined with the operators `|`, `&`, and `!`.
> +///
> +/// Values can be used from the [`flags`] module.
> +#[derive(Clone, Copy)]
> +pub struct Flags(u64);
> +
> +impl core::ops::BitOr for Flags {
> +    type Output = Self;
> +    fn bitor(self, rhs: Self) -> Self::Output {
> +        Self(self.0 | rhs.0)
> +    }
> +}
> +
> +impl core::ops::BitAnd for Flags {
> +    type Output = Self;
> +    fn bitand(self, rhs: Self) -> Self::Output {
> +        Self(self.0 & rhs.0)
> +    }
> +}
> +
> +impl core::ops::Not for Flags {
> +    type Output = Self;
> +    fn not(self) -> Self::Output {
> +        Self(!self.0)
> +    }
> +}
> +
> +/// The flags that can be used when registering an IRQ handler.
> +pub mod flags {
> +    use super::Flags;
> +
> +    use crate::bindings;
> +
> +    /// Use the interrupt line as already configured.
> +    pub const TRIGGER_NONE: Flags = Flags(bindings::IRQF_TRIGGER_NONE as _);

What is the reason for the `as _` in all these? Should the flag type be
something else?

> +
> +    /// The interrupt is triggered when the signal goes from low to high.
> +    pub const TRIGGER_RISING: Flags = Flags(bindings::IRQF_TRIGGER_RISING as _);
> +
> +    /// The interrupt is triggered when the signal goes from high to low.
> +    pub const TRIGGER_FALLING: Flags = Flags(bindings::IRQF_TRIGGER_FALLING as _);
> +
> +    /// The interrupt is triggered while the signal is held high.
> +    pub const TRIGGER_HIGH: Flags = Flags(bindings::IRQF_TRIGGER_HIGH as _);
> +
> +    /// The interrupt is triggered while the signal is held low.
> +    pub const TRIGGER_LOW: Flags = Flags(bindings::IRQF_TRIGGER_LOW as _);
> +
> +    /// Allow sharing the irq among several devices.
> +    pub const SHARED: Flags = Flags(bindings::IRQF_SHARED as _);
> +
> +    /// Set by callers when they expect sharing mismatches to occur.

What is a sharing mismatch?

> +    pub const PROBE_SHARED: Flags = Flags(bindings::IRQF_PROBE_SHARED as _);
> +
> +    /// Flag to mark this interrupt as timer interrupt.

The "Flag to ..." strikes me as odd when most of the other descriptions
have a different wording.

> +    pub const TIMER: Flags = Flags(bindings::IRQF_TIMER as _);
> +
> +    /// Interrupt is per cpu.
> +    pub const PERCPU: Flags = Flags(bindings::IRQF_PERCPU as _);
> +
> +    /// Flag to exclude this interrupt from irq balancing.
> +    pub const NOBALANCING: Flags = Flags(bindings::IRQF_NOBALANCING as _);
> +
> +    /// Interrupt is used for polling (only the interrupt that is registered
> +    /// first in a shared interrupt is considered for performance reasons).
> +    pub const IRQPOLL: Flags = Flags(bindings::IRQF_IRQPOLL as _);
> +
> +    /// Interrupt is not reenabled after the hardirq handler finished. Used by
> +    /// threaded interrupts which need to keep the irq line disabled until the
> +    /// threaded handler has been run.
> +    pub const ONESHOT: Flags = Flags(bindings::IRQF_ONESHOT as _);
> +
> +    /// Do not disable this IRQ during suspend. Does not guarantee that this
> +    /// interrupt will wake the system from a suspended state.
> +    pub const NO_SUSPEND: Flags = Flags(bindings::IRQF_NO_SUSPEND as _);
> +
> +    /// Force enable it on resume even if [`NO_SUSPEND`] is set.

Perhaps: Force enable the interrupt even if ...

> +    pub const FORCE_RESUME: Flags = Flags(bindings::IRQF_FORCE_RESUME as _);
> +
> +    /// Interrupt cannot be threaded.
> +    pub const NO_THREAD: Flags = Flags(bindings::IRQF_NO_THREAD as _);
> +
> +    /// Resume IRQ early during syscore instead of at device resume time.
> +    pub const EARLY_RESUME: Flags = Flags(bindings::IRQF_EARLY_RESUME as _);
> +
> +    /// If the IRQ is shared with a NO_SUSPEND user, execute this interrupt

Please link `NO_SUSPEND`.

> +    /// handler after suspending interrupts. For system wakeup devices users
> +    /// need to implement wakeup detection in their interrupt handlers.
> +    pub const COND_SUSPEND: Flags = Flags(bindings::IRQF_COND_SUSPEND as _);
> +
> +    /// Don't enable IRQ or NMI automatically when users request it. Users will
> +    /// enable it explicitly by `enable_irq` or `enable_nmi` later.
> +    pub const NO_AUTOEN: Flags = Flags(bindings::IRQF_NO_AUTOEN as _);
> +
> +    /// Exclude from runnaway detection for IPI and similar handlers, depends on
> +    /// `PERCPU`.
> +    pub const NO_DEBUG: Flags = Flags(bindings::IRQF_NO_DEBUG as _);
> +}
> +
> +/// The value that can be returned from an IrqHandler or a ThreadedIrqHandler.
> +pub enum IrqReturn {

I learned recently that if you choose the right representation here, you
don't need to cast here and when you call `Handler::handle_irq`. I think
`#[repr(u32)]` is the one to use here.

> +    /// The interrupt was not from this device or was not handled.
> +    None = bindings::irqreturn_IRQ_NONE as _,
> +
> +    /// The interrupt was handled by this device.
> +    Handled = bindings::irqreturn_IRQ_HANDLED as _,
> +}
> +
> +/// Callbacks for an IRQ handler.
> +pub trait Handler: Sync {
> +    /// The actual handler function. As usual, sleeps are not allowed in IRQ
> +    /// context.
> +    fn handle_irq(&self) -> IrqReturn;
> +}

What is the reason for moving away from the following:


    pub trait Handler {
        /// The context data associated with and made available to the handler.
        type Data: ForeignOwnable;

        /// Called from interrupt context when the irq happens.
        fn handle_irq(data: <Self::Data as ForeignOwnable>::Borrowed<'_>) -> Return;
    }


I think we will run into problems if we want to pass `Arc<Foo>` as the
handler. I don't think we can `impl Handler for Arc<Foo>` in a driver
crate, since both `Handler` and `Arc` are defined in external crates


[...]

> +#[pin_data(PinnedDrop)]
> +pub struct ThreadedRegistration<T: ThreadedHandler> {
> +    irq: u32,
> +    #[pin]
> +    handler: T,
> +    #[pin]
> +    /// Pinned because we need address stability so that we can pass a pointer
> +    /// to the callback.
> +    _pin: PhantomPinned,
> +}

As others have mentioned, I wonder if we can avoid the code duplication
that makes up most of the rest of this patch.


Best regards,
Andreas Hindborg



