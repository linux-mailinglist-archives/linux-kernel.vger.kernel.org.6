Return-Path: <linux-kernel+bounces-326048-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BBD09761C4
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 08:44:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D731289CD6
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 06:44:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE7F5189BB9;
	Thu, 12 Sep 2024 06:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MLHbJ/kg"
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B932318BC1C;
	Thu, 12 Sep 2024 06:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726123452; cv=none; b=m0a7DEZl2Wf18pSX9cM/GKOxRI4vLARybeHYDCEuaPGKfq4YkHKrQjWmedaoCt1VUhjm+BhnWk41R8YAeMsF97UjmNXnzEWQ2oO81lCBwBaiaH8rffqSh+btMgR8no8PgJ22tEW4rCZLnPpdwHke/oMWn+HAZMI/7TwC6k2MI8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726123452; c=relaxed/simple;
	bh=z1ni0FIjjWPhSA+Q1iNuKBMOEcDQCRWjIyZ3dFM7cEw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UacNVuW+kuj/ziIwBtEYf51OJ51AYph73aYCfN37PnR/MJjZ+DUNAnKC0JVHdLx3exEs1+OIA0VfR62Hldkx2W7L0VlbjcCZPYAOl4y3iCeOy61GhnpySH4BLf0YywcV6Oxk+64kFcJNwj0J/4ECD+DspT3R6aZXc4P6bN1MWy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MLHbJ/kg; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-7a7f8b0b7d0so30838585a.2;
        Wed, 11 Sep 2024 23:44:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726123449; x=1726728249; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cXBZHn1B8vjCRl1SZPjKQQZgwTON+FrvCPw47Wz5pco=;
        b=MLHbJ/kg4zYnMfw8vs53KIY+e9PDD/Kuy0iTxU7PQZybvC3NDcCkUoFO+i7PyI3QVq
         TC4xiEgK090wj0eJlb00csM+FVjeApZ+YBdLfun62+U3A48Uz1bctbWbjdis42BQXwx7
         g8ouxad9plNtvBNpDidrMgZcseh42F+XCTuaax64Wwa3+A2YNndQrttFP/t0KJqnARgR
         nAGmlvP0Yu4xvNV/71BWRJQgxQ4PWj6JqAZRrJD2jGYJ7r4ADt1cPCUVa+EHhYUglqsD
         BITwnbUqvJf91CqXffLrsxQFkLMdNwb5vVkWh7387LF6/consf+Jb8DVLKlCBazcXi6f
         2BjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726123449; x=1726728249;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cXBZHn1B8vjCRl1SZPjKQQZgwTON+FrvCPw47Wz5pco=;
        b=dkzyEGrTnoJlbsf/bvgJdq6LLZcmptvgc3NDtKxZAqBjsRfMWE1CDNHTjYpLzlND6s
         6cdQd/0aDgtWarn26R8ZazBlocK/p/S8gFJgwYl27fk6qvhV3J4kDOyzUhIH173stD4a
         8kodcHWgNWIWp96ZwEyTctW1+xzQfGyaAFN4LgrlmE5MS9rUMFsvr0HeRwKpRUzeLUGr
         Ta+AQj/o9/1rycF94OhqniTSDaHTFiRIfUftetw2CEnMYon2/vBQsAuyayo04T15qyEN
         +78kIT55JZ3oVzRpSg/u8SHVG7TjHiSrtSppTRnQUAQpxSLtTe6yO9ueuDKBLGxkiH4/
         Nhjg==
X-Forwarded-Encrypted: i=1; AJvYcCVrdba2+EEXE63mg81wgiefVhBLiDXAP8dNZ3t7e9G3AppINBTSAEgTG/yBc6gtR0pvU2L+bvr4NVJ/01g=@vger.kernel.org
X-Gm-Message-State: AOJu0YxzaaUr8eCZZc+2zMx8oCGXgI0mMAkv/cLmTtZiEKQVjzKVZb8Q
	8l1r7h59KX33uNZwrglWZ5bZEXV/9vyFhXdhbIxIo3zoSKSZAMky
X-Google-Smtp-Source: AGHT+IEyUjQ2Gpp9kdigVBolZ1fzVGPdA0gSynzaIcZbV+UW2haz7OLMCqvibjgqn0KbELzi2Mq4yg==
X-Received: by 2002:a05:620a:294a:b0:7a9:ad18:11e9 with SMTP id af79cd13be357-7a9e5f7c6e1mr318022185a.59.1726123449356;
        Wed, 11 Sep 2024 23:44:09 -0700 (PDT)
Received: from fauth2-smtp.messagingengine.com (fauth2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-45822f95895sm49706281cf.89.2024.09.11.23.44.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Sep 2024 23:44:08 -0700 (PDT)
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfauth.phl.internal (Postfix) with ESMTP id E38311200072;
	Thu, 12 Sep 2024 02:44:07 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Thu, 12 Sep 2024 02:44:07 -0400
X-ME-Sender: <xms:t43iZibFAnZBGqs0DABSwkFZEaUV5h-4futo94B4A7Z4otPAOeA2XQ>
    <xme:t43iZlYxTLcYdQjeIWGbZaI3i2Sgl1vbERdkLpdkPl2mQRrQqqokGiOFDtqRqzhC5
    BTSlSUCHfM1vHUaBQ>
X-ME-Received: <xmr:t43iZs-dbIZFib3fP6redjuw7JI7IUPwCkwS6QNbJK4ciP2zneO3FEdu0NSyZg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudejvddgudduudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddv
    necuhfhrohhmpeeuohhquhhnucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilh
    drtghomheqnecuggftrfgrthhtvghrnhepffeljeelheevleetleetudfghfehvdekgfdv
    heefieffiefhiefgvddtuefhtdetnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghdpgh
    hithhhuhgsrdgtohhmnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghi
    lhhfrhhomhepsghoqhhunhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqie
    elvdeghedtieegqddujeejkeehheehvddqsghoqhhunhdrfhgvnhhgpeepghhmrghilhdr
    tghomhesfhhigihmvgdrnhgrmhgvpdhnsggprhgtphhtthhopedvuddpmhhouggvpehsmh
    htphhouhhtpdhrtghpthhtoheplhihuhguvgesrhgvughhrghtrdgtohhmpdhrtghpthht
    oheprhhushhtqdhfohhrqdhlihhnuhigsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtg
    hpthhtohepuggrkhhrsehrvgguhhgrthdrtghomhdprhgtphhtthhopegrihhrlhhivggu
    sehrvgguhhgrthdrtghomhdprhgtphhtthhopehmihhnghhosehrvgguhhgrthdrtghomh
    dprhgtphhtthhopeifihhllheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhonhhg
    mhgrnhesrhgvughhrghtrdgtohhmpdhrtghpthhtohepphgvthgvrhiisehinhhfrhgrug
    gvrggurdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgv
    rhhnvghlrdhorhhg
X-ME-Proxy: <xmx:t43iZkqXvhOFuFVLlEP16QiZKNbcloH5XQk6LV8eJpH7KaYB4YWNEg>
    <xmx:t43iZtqqjoSNtdYLTETCiOAYGYcWeu3xqPs3K4oTS0pSOLkamWLYVg>
    <xmx:t43iZiQ3HawRt8UNYGDpZTB_VpZ82q9L8LbVxfwDkKgAIhxZgEvGxw>
    <xmx:t43iZtpjyAcPrSJBKDIvmTZRi7eCrZhwdeWK2cYuLsC49uXFh36iHQ>
    <xmx:t43iZq4ssXs9t95tT4mvclFFQpHAgI9y6AROeF0EbIkke8vD2ZFKib8P>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 12 Sep 2024 02:44:07 -0400 (EDT)
Date: Wed, 11 Sep 2024 23:44:03 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: Lyude Paul <lyude@redhat.com>
Cc: rust-for-linux@vger.kernel.org, Danilo Krummrich <dakr@redhat.com>,
	airlied@redhat.com, Ingo Molnar <mingo@redhat.com>,
	Will Deacon <will@kernel.org>, Waiman Long <longman@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Wedson Almeida Filho <wedsonaf@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@samsung.com>,
	Alice Ryhl <aliceryhl@google.com>, Asahi Lina <lina@asahilina.net>,
	Valentin Obst <kernel@valentinobst.de>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v4 1/3] rust: Introduce irq module
Message-ID: <ZuKNszXSw-LbgW1e@boqun-archlinux>
References: <20240912005539.175428-1-lyude@redhat.com>
 <20240912005539.175428-2-lyude@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240912005539.175428-2-lyude@redhat.com>

On Wed, Sep 11, 2024 at 08:55:32PM -0400, Lyude Paul wrote:
> This introduces a module for dealing with interrupt-disabled contexts,
> including the ability to enable and disable interrupts
> (with_irqs_disabled()) - along with the ability to annotate functions as
> expecting that IRQs are already disabled on the local CPU.
> 
> Signed-off-by: Lyude Paul <lyude@redhat.com>
> 
> ---
> 
> V2:
> * Actually make it so that we check whether or not we have interrupts
>   disabled with debug assertions
> * Fix issues in the documentation (added suggestions, missing periods, made
>   sure that all rustdoc examples compile properly)
> * Pass IrqDisabled by value, not reference
> * Ensure that IrqDisabled is !Send and !Sync using
>   PhantomData<(&'a (), *mut ())>
> * Add all of the suggested derives from Benno Lossin
> 
> V3:
> * Use `impl` for FnOnce bounds in with_irqs_disabled()
> * Use higher-ranked trait bounds for the lifetime of with_irqs_disabled()
> * Wording changes in the documentation for the module itself
> 
> V4:
> * Use the actual unsafe constructor for IrqDisabled in
>   with_irqs_disabled()
> * Fix comment style in with_irqs_disabled example
> * Check before calling local_irq_restore() in with_irqs_disabled that
>   interrupts are still disabled. It would have been nice to do this from a
>   Drop implementation like I hoped, but I realized rust doesn't allow that
>   for types that implement Copy.
> * Document that interrupts can't be re-enabled within the `cb` provided to
>   `with_irqs_disabled`, and link to the github issue I just filed about
>   this that describes the solution for this.
> 
> Signed-off-by: Lyude Paul <lyude@redhat.com>
> ---
>  rust/helpers.c     | 23 ++++++++++++
>  rust/kernel/irq.rs | 90 ++++++++++++++++++++++++++++++++++++++++++++++
>  rust/kernel/lib.rs |  1 +
>  3 files changed, 114 insertions(+)
>  create mode 100644 rust/kernel/irq.rs
> 
> diff --git a/rust/helpers.c b/rust/helpers.c
> index 92d3c03ae1bd5..c6109358675ae 100644
> --- a/rust/helpers.c
> +++ b/rust/helpers.c

You need to rebase on rust-next, which has the helper split changes.

> @@ -26,6 +26,7 @@
>  #include <linux/device.h>
>  #include <linux/err.h>
>  #include <linux/errname.h>
> +#include <linux/irqflags.h>
>  #include <linux/gfp.h>
>  #include <linux/highmem.h>
>  #include <linux/mutex.h>
> @@ -85,6 +86,28 @@ void rust_helper_spin_unlock(spinlock_t *lock)
>  }
>  EXPORT_SYMBOL_GPL(rust_helper_spin_unlock);
>  
> +unsigned long rust_helper_local_irq_save(void)
> +{
> +	unsigned long flags;
> +
> +	local_irq_save(flags);
> +
> +	return flags;
> +}
> +EXPORT_SYMBOL_GPL(rust_helper_local_irq_save);
> +
> +void rust_helper_local_irq_restore(unsigned long flags)
> +{
> +	local_irq_restore(flags);
> +}
> +EXPORT_SYMBOL_GPL(rust_helper_local_irq_restore);
> +
> +bool rust_helper_irqs_disabled(void)
> +{
> +	return irqs_disabled();
> +}
> +EXPORT_SYMBOL_GPL(rust_helper_irqs_disabled);
> +
>  void rust_helper_init_wait(struct wait_queue_entry *wq_entry)
>  {
>  	init_wait(wq_entry);
> diff --git a/rust/kernel/irq.rs b/rust/kernel/irq.rs
> new file mode 100644
> index 0000000000000..8dd153ba10bde
> --- /dev/null
> +++ b/rust/kernel/irq.rs
> @@ -0,0 +1,90 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +//! Interrupt controls
> +//!
> +//! This module allows Rust code to control processor interrupts. [`with_irqs_disabled()`] may be
> +//! used for nested disables of interrupts, whereas [`IrqDisabled`] can be used for annotating code
> +//! that requires interrupts to be disabled.
> +
> +use bindings;
> +use core::marker::*;
> +
> +/// A token that is only available in contexts where IRQs are disabled.
> +///
> +/// [`IrqDisabled`] is marker made available when interrupts are not active. Certain functions take
> +/// an [`IrqDisabled`] in order to indicate that they may only be run in IRQ-free contexts.
> +///
> +/// This is a marker type; it has no size, and is simply used as a compile-time guarantee that
> +/// interrupts are disabled where required.
> +///
> +/// This token can be created by [`with_irqs_disabled`]. See [`with_irqs_disabled`] for examples and
> +/// further information.
> +#[derive(Copy, Clone, Debug, Ord, Eq, PartialOrd, PartialEq, Hash)]
> +pub struct IrqDisabled<'a>(PhantomData<(&'a (), *mut ())>);
> +

Maybe define this as:

	pub struct IrqDisabled<'a>(PhantomData<(&'a (), NotThreadSafe)>);

or
	pub struct IrqDisabled<'a>(PhantomData<&'a ()>, NotThreadSafe);

once `NotThreadSafe` is in mainline:

	https://lore.kernel.org/rust-for-linux/20240808-alice-file-v9-1-2cb7b934e0e1@google.com/

this probably will go in at v6.13, so would your patchset I assume. (But
it would be tricky since you will have a dependency at the vfs next
branch).

> +impl IrqDisabled<'_> {
> +    /// Create a new [`IrqDisabled`] without disabling interrupts.

This is a bit confusing: users could read it as they can create a new
[`IrqDisabled`] even irq is enabled. How about:

	Creates a new [`IrqDisabled`] token in an interrupt disabled context.

?

> +    ///
> +    /// This creates an [`IrqDisabled`] token, which can be passed to functions that must be run
> +    /// without interrupts. If debug assertions are enabled, this function will assert that
> +    /// interrupts are disabled upon creation. Otherwise, it has no size or cost at runtime.
> +    ///
> +    /// # Panics
> +    ///
> +    /// If debug assertions are enabled, this function will panic if interrupts are not disabled
> +    /// upon creation.
> +    ///
> +    /// # Safety
> +    ///
> +    /// This function must only be called in contexts where it is already known that interrupts have
> +    /// been disabled for the current CPU, as the user is making a promise that they will remain

s/as/and ?

> +    /// disabled at least until this [`IrqDisabled`] is dropped.
> +    pub unsafe fn new() -> Self {
> +        // SAFETY: FFI call with no special requirements
> +        debug_assert!(unsafe { bindings::irqs_disabled() });
> +
> +        Self(PhantomData)
> +    }
> +}
> +
> +/// Run the closure `cb` with interrupts disabled on the local CPU.
> +///
> +/// This creates an [`IrqDisabled`] token, which can be passed to functions that must be run
> +/// without interrupts. Note that interrupts must be disabled for the entire duration of `cb`, they
> +/// cannot be re-enabled. In the future, this may be expanded on
> +/// [as documented here](https://github.com/Rust-for-Linux/linux/issues/1115).
> +///
> +/// # Examples
> +///
> +/// Using [`with_irqs_disabled`] to call a function that can only be called with interrupts
> +/// disabled:
> +///
> +/// ```
> +/// use kernel::irq::{IrqDisabled, with_irqs_disabled};
> +///
> +/// // Requiring interrupts be disabled to call a function
> +/// fn dont_interrupt_me(_irq: IrqDisabled<'_>) {
> +///     // When this token is available, IRQs are known to be disabled. Actions that rely on this
> +///     // can be safely performed
> +/// }
> +///
> +/// // Disabling interrupts. They'll be re-enabled once this closure completes.

Rather than "re-enabled", I would put "restored" here, since it's
local_irq_restore() other than local_irq_enable().

> +/// with_irqs_disabled(|irq| dont_interrupt_me(irq));
> +/// ```
> +#[inline]
> +pub fn with_irqs_disabled<T>(cb: impl for<'a> FnOnce(IrqDisabled<'a>) -> T) -> T {
> +    // SAFETY: FFI call with no special requirements
> +    let flags = unsafe { bindings::local_irq_save() };
> +
> +    // SAFETY: We just disabled IRQs using `local_irq_save()`
> +    let ret = cb(unsafe { IrqDisabled::new() });
> +
> +    // Confirm that IRQs are still enabled now that the callback has finished
> +    // SAFETY: FFI call with no special requirements
> +    debug_assert!(unsafe { bindings::irqs_disabled() });
> +

(Technically, we should check whether `flags` ==
`arch_local_save_flags()`, but maybe I'm just being paranoid here. Would
an architecture have different flags but both indicating irq is
disabled?)

[Cc Thomas as well]

Regards,
Boqun

> +    // SAFETY: `flags` comes from our previous call to local_irq_save
> +    unsafe { bindings::local_irq_restore(flags) };
> +
> +    ret
> +}
> diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
> index 274bdc1b0a824..ead3a7ca5ba11 100644
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
> 2.46.0
> 

