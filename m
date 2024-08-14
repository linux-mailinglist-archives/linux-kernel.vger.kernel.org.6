Return-Path: <linux-kernel+bounces-286951-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 284B59520BA
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 19:12:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D1481282C48
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 17:12:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C71751BBBD1;
	Wed, 14 Aug 2024 17:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PYUHDZgb"
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20FB128DC3;
	Wed, 14 Aug 2024 17:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723655515; cv=none; b=f48yAJcN94oesdyC+LP4/X0wfVgW0GIUcAHNufmE7tBKquhgmeOEUsvTaVb++G4Xy/L071kUsoqoVMQkDkWF76Ib6OYIrByz3aI+cmPsTaBnwGeohVLHCqQC8dEUQk/3wxCnxvC0AyZaaYsrEhgkB6iNr6luubiau4kHll79/4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723655515; c=relaxed/simple;
	bh=bEbceaEmRw0HaGMqhzMDnM4i18vjCyOtaCkHXpNA5UM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tjzlv3JaZ71gNOSUcfNS3OyPH5/zyeXnWP9+f7vwTIIPwjJY41r+gkYzkEBinMJLFmRYG0n3bMtcXje/T+z3LoGBjdiR0GXGU6t/YQwrlP7tGTrz72a2cSA5H1GYroGM7VUGWwYc8ZenkSu9dubmY7Q+Bd2UDkO7J6TPAeKmXG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PYUHDZgb; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-7a1d81dc0beso2552285a.2;
        Wed, 14 Aug 2024 10:11:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723655513; x=1724260313; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AAQbdE/vLxHleFr0bTuR1KvjFDW+ZSeQno8d4GhHEWg=;
        b=PYUHDZgbo3CdxVFlXddlKzWHh3mzLKHry+S46gpsDce4Q6Lr9oFcLRex2CUzEZtAUq
         I5CkPr2uGnEhdstQ7ZZIQ4zEtkGojS6GRO+V2CK8lf7ne5dE3lIcGJfeJE1WzK2K4m7v
         wMcs33kq9k2KirXXuglDAMu+raeJZn66/rOtmllyNmToRfoyG/4b+YbbFlAEIVc3ujgX
         nBdvARfEZiUCZpxuIIkjSt0mjikjRsbfRNp7kWwtdrzJuzngy5QQ8dPC7Zb1Zn9lcNqJ
         UUThg3XwGA0oBiYKluraqqazGYL1noblSjnBXOQx120dt0YwOeCtweDVGfZnWGI6uPKV
         1pHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723655513; x=1724260313;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AAQbdE/vLxHleFr0bTuR1KvjFDW+ZSeQno8d4GhHEWg=;
        b=R1Ak0p/MOSqk6XZhb/8jpi0XZjP4YPj59P5ItdzbBOT14mxYB4Jc7t/OKRpVSmSsR1
         8W8DseCH40WjdaTz8Op4hERjpWxmd8xFazMBAWj1XeB6hSxX2A8BHYjAmDDm2BtaeLL3
         tD3lhU/sKE0Xb+VgkD24Gth8daVlDJQeVoQISVSFMaISgHG0FzfSp5Bh5q95ir0j83Js
         Kf6wrZhwpPd1DvVQlF+SLxSIecUw8UbolviMlGltG5IsmY2rYGm/wIM5LA4dpU9mudrd
         Ne14p9ey0gsZuN8eNK9NxRoxw1oivuh/9dl7H0dXQeiY3vzz7SJkFGdR2YTXARRORZP2
         RoHQ==
X-Forwarded-Encrypted: i=1; AJvYcCWo4+yVR5LQ1IYdHNLxA5O5tiZ9LnZEyj/GbyhgR1O7WOH+O1/Ff8QnJoe6V3RyaEzK6jDg+pFqCLQfFRyJJCH+Llek//FKpdd21lTD
X-Gm-Message-State: AOJu0YzkMEe1CqvyjXiyiG+IRbGfo/XEDxniV+FcUsw4iQhJ+3qQWTOC
	UM94p/SP4m8PD8mXdvi8s2f8ezS1BScmHYRYIDt5+or+TOaMI3LO
X-Google-Smtp-Source: AGHT+IETE0HeuxhHBnh4z1kg3S87FAXK+wgo/SRChdzQHeRrIC1wLw6FpFPnLnyx6+d1t3NsGoUuUA==
X-Received: by 2002:a05:620a:2906:b0:79d:7cfb:884e with SMTP id af79cd13be357-7a4ee31ce62mr425651685a.4.1723655512826;
        Wed, 14 Aug 2024 10:11:52 -0700 (PDT)
Received: from fauth2-smtp.messagingengine.com (fauth2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a4c7d820c0sm457795985a.65.2024.08.14.10.11.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Aug 2024 10:11:52 -0700 (PDT)
Received: from phl-compute-03.internal (phl-compute-03.nyi.internal [10.202.2.43])
	by mailfauth.nyi.internal (Postfix) with ESMTP id 7D1A11200068;
	Wed, 14 Aug 2024 13:11:51 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Wed, 14 Aug 2024 13:11:51 -0400
X-ME-Sender: <xms:V-W8ZluiOmWmTAm-U1zAbaJWROohZ7VjblsnB2WayTtlHtYMNhqDwQ>
    <xme:V-W8Zuf-rqVP32WXfuzykVO80MPDvJ5o1QTDSpTDY5a_2l5LYLG9MDfxms6OMuWno
    eQtdyLW78rE6ElRfg>
X-ME-Received: <xmr:V-W8Zoxq2gqhHECQcdK-vAXpkvPoHt8fKc3bupFb8O1kY3-cRyPWCDVs5Mdu_A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddruddtgedgudduudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddv
    necuhfhrohhmpeeuohhquhhnucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilh
    drtghomheqnecuggftrfgrthhtvghrnhephedugfduffffteeutddvheeuveelvdfhleel
    ieevtdeguefhgeeuveeiudffiedvnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepsghoqhhunhdomhgvshhmthhprghuthhhphgvrhhsohhnrghl
    ihhthidqieelvdeghedtieegqddujeejkeehheehvddqsghoqhhunhdrfhgvnhhgpeepgh
    hmrghilhdrtghomhesfhhigihmvgdrnhgrmhgvpdhnsggprhgtphhtthhopedvuddpmhho
    uggvpehsmhhtphhouhhtpdhrtghpthhtoheplhihuhguvgesrhgvughhrghtrdgtohhmpd
    hrtghpthhtoheprhhushhtqdhfohhrqdhlihhnuhigsehvghgvrhdrkhgvrhhnvghlrdho
    rhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrd
    horhhgpdhrtghpthhtohepuggrkhhrsehrvgguhhgrthdrtghomhdprhgtphhtthhopegr
    ihhrlhhivggusehrvgguhhgrthdrtghomhdprhgtphhtthhopehmihhnghhosehrvgguhh
    grthdrtghomhdprhgtphhtthhopeifihhllheskhgvrhhnvghlrdhorhhgpdhrtghpthht
    oheplhhonhhgmhgrnhesrhgvughhrghtrdgtohhmpdhrtghpthhtohepphgvthgvrhiise
    hinhhfrhgruggvrggurdhorhhg
X-ME-Proxy: <xmx:V-W8ZsORrMDs7V25awyLXnPB3CTq6j0-5_e_PvDclBr66qamRp5gSA>
    <xmx:V-W8Zl8Gd8pE6Aws6N2l6RDgbj0SO-7IvzUvOHviQQtZ7_6p1n7wRQ>
    <xmx:V-W8ZsWs4eZ_Ur0t2_fztzh-mAlozK-mF-OcKXa6lA_QyfYGo0gvvg>
    <xmx:V-W8ZmcfiZ1xbf0ZqSdVczDoMwTb31MWWMZdqJ4r8m4jjCP8KL8bVQ>
    <xmx:V-W8Zre1PZNYN6g5o8iyULDKg_aA0fE5hVGea3L9gJp4sXCZWedPctib>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 14 Aug 2024 13:11:50 -0400 (EDT)
Date: Wed, 14 Aug 2024 10:10:23 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: Lyude Paul <lyude@redhat.com>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
	Danilo Krummrich <dakr@redhat.com>, airlied@redhat.com,
	Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
	Waiman Long <longman@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Wedson Almeida Filho <wedsonaf@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@samsung.com>,
	Alice Ryhl <aliceryhl@google.com>,
	FUJITA Tomonori <fujita.tomonori@gmail.com>,
	Aakash Sen Sharma <aakashsensharma@gmail.com>,
	Valentin Obst <kernel@valentinobst.de>
Subject: Re: [PATCH v3 1/3] rust: Introduce irq module
Message-ID: <Zrzk_1mQ9q_dmKvn@boqun-archlinux>
References: <20240802001452.464985-1-lyude@redhat.com>
 <20240802001452.464985-2-lyude@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240802001452.464985-2-lyude@redhat.com>

On Thu, Aug 01, 2024 at 08:10:00PM -0400, Lyude Paul wrote:
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
> ---
>  rust/helpers.c     | 22 ++++++++++++
>  rust/kernel/irq.rs | 84 ++++++++++++++++++++++++++++++++++++++++++++++
>  rust/kernel/lib.rs |  1 +
>  3 files changed, 107 insertions(+)
>  create mode 100644 rust/kernel/irq.rs
> 
> diff --git a/rust/helpers.c b/rust/helpers.c
> index 92d3c03ae1bd5..42de410f92d63 100644
> --- a/rust/helpers.c
> +++ b/rust/helpers.c
> @@ -85,6 +85,28 @@ void rust_helper_spin_unlock(spinlock_t *lock)
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
> index 0000000000000..b52f8073e5cd0
> --- /dev/null
> +++ b/rust/kernel/irq.rs
> @@ -0,0 +1,84 @@
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
> +impl IrqDisabled<'_> {
> +    /// Create a new [`IrqDisabled`] without disabling interrupts.
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
> +/// without interrupts.
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
> +///     /* When this token is available, IRQs are known to be disabled. Actions that rely on this
> +///      * can be safely performed
> +///      */

           ^^^^

The comment format is weird here, you can just use //.

> +/// }
> +///
> +/// // Disabling interrupts. They'll be re-enabled once this closure completes.
> +/// with_irqs_disabled(|irq| dont_interrupt_me(irq));
> +/// ```
> +#[inline]
> +pub fn with_irqs_disabled<T>(cb: impl for<'a> FnOnce(IrqDisabled<'a>) -> T) -> T {
> +    // SAFETY: FFI call with no special requirements
> +    let flags = unsafe { bindings::local_irq_save() };
> +
> +    let ret = cb(IrqDisabled(PhantomData));

I would recommend use `IrqDisabled::new()` here since you're
constructing an `IrqDisabled` under the assumption that IRQ is disabled
(via local_irq_save()). Alternatively, you could add a "# Invariants"
section of `IrqDisabled` (saying the existence of this type means the
IRQ is disabled), and add a "// INVARIANTS " comment here. Thoughts?

Regards,
Boqun

> +
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
> 2.45.2
> 
> 

