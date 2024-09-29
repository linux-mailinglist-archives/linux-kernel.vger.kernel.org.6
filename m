Return-Path: <linux-kernel+bounces-343243-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E482F989884
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 02:00:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 052891C20F90
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 00:00:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1253B5103F;
	Mon, 30 Sep 2024 00:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kBzETnlr"
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EEFF2570;
	Mon, 30 Sep 2024 00:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727654415; cv=none; b=bxD4albXN2Y+bGiWWyYbeq+GnaanzA0gB06x5vFHjTmVsg6+J7+yAMua5NEzaceKoQ/hJywftGhksClRZ7ULck576FYGK9w25boY5XDq1IAULhnnTv0jHlEvolsW3yCWcalPG5oLqSpXVx+IYxAoom8XRM27hY9E3JWGPbRSnbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727654415; c=relaxed/simple;
	bh=SayAUjz0AZGapHPt8EslXsgQdiUNTUnB/xz4c7hxnX4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OAa0sKjeTbyY5S0gR0lNqx9PSLvyYSvqW/oX0X/XvWfKtQUyJAPUglF6kZKKcFIJo/Q2q9LELARWpgdrnsUK4KYH3ytDueswnvRtIeWdwCqFXEBCdy5UuPGfDHoav+hvwjK9qyXE4qW0+a42JOgdghbUR4CWQGBFfp3Hl8LVZk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kBzETnlr; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-6cb37b34a87so27500866d6.0;
        Sun, 29 Sep 2024 17:00:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727654412; x=1728259212; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L3pqwaqCamqZTcEWfoxM9HlB2CO53QZZVZtUQFwo/Ag=;
        b=kBzETnlrSDIGCXV+hbDwxVx6p3pNMpxu36dJuHjYS8KmnkX2Q0df28+TocVZN1t5Ug
         SdSQ3f5D5EcLl5JmIazt3KtR+VDaS6PdSQmniGEaxJx+QN3Y0MvrUBw0nmPQJdpOtOrC
         kc03brGO7QhF514SEjy66WK0e6fYxxDW4GaT03m0RY79CgNkSBLghh6s4l4YSslgyPi2
         lWuK2fy+GeJ6scYzLIBbuTc8VNL8m15RoiDa1Vt4dFlHIyWP441CcNt41GWESdRaCipw
         htfqb7/BmO/AXSp82nso6WX3KSuDstRy4ZF5gxHu66WxulUkkZ2UI8ppD+MzSRwfkIn2
         yptA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727654412; x=1728259212;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L3pqwaqCamqZTcEWfoxM9HlB2CO53QZZVZtUQFwo/Ag=;
        b=AZY0XF1Qgk1De/L3KgSroD02q4N5FPc+REjvDgxyq/VAcs23z/3LbpaMG89vuaoisw
         MDzk6fUVZed6q8T6f4xRta+9qZO63BK2+31aBGICHgtS6qhC1yjrhMrU9w/kTzOwxUWe
         8zxaZ7kI96JNl25KrX/cshDqURE9VCIn59WFk7qwIIUODM5B8nOZAcVbf6HQPCQphZDA
         +U9M9zk1HUsIXo+hjFhqHpR7nwDhHDMft8GShlqorIQdOpLXf/r4nhu818SS0DJXERyz
         /FcEQM8X4JtKofj+QNEQ5nxRixdbwLbk/DuIHz132/poHKthMuanCH8sdWE545sfBDg9
         xo+A==
X-Forwarded-Encrypted: i=1; AJvYcCXV8vviGTXlGnbsjpjWJlXMrbqjjmEvGgDoL1SURXdMpoJn2y9kNr6piGTW/Qvg+/xtHNxx1fScjDpM9eU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzTyRCn4Z9uy67zzzlmOJWRddwzor8KUG1HRUpYT+aRzEzCy8WV
	a6ppMpvIJlwAee8PdnyGPovHGuUdnoYYYCbDkyC+KzpiBiP5ZNgm
X-Google-Smtp-Source: AGHT+IFbyMceHVS2H7Xnb4T6G/v+fNR+lhz3/DKUzD4IwqrCckByIlKy3Ji8+H+aIcJSdJUR7zJK4Q==
X-Received: by 2002:a0c:f6cd:0:b0:6cb:3b9b:1673 with SMTP id 6a1803df08f44-6cb3b9b1732mr135392326d6.49.1727654412220;
        Sun, 29 Sep 2024 17:00:12 -0700 (PDT)
Received: from fauth-a1-smtp.messagingengine.com (fauth-a1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6cb3b6905efsm35388916d6.138.2024.09.29.17.00.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Sep 2024 17:00:11 -0700 (PDT)
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfauth.phl.internal (Postfix) with ESMTP id 2797C1200043;
	Sun, 29 Sep 2024 20:00:11 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Sun, 29 Sep 2024 20:00:11 -0400
X-ME-Sender: <xms:C-r5ZgiJ_-RdOcQf16h8wR96i_PDqxrt9br1S7SSKRpSMjJe9Ce2Hw>
    <xme:C-r5ZpCkQKG2G5fT64yf_0nWJkXVS_StRYs1l4Zx1bNTRFiTik0bII9fJ7f1AWVTt
    jKdU_YMWMXoks6Buw>
X-ME-Received: <xmr:C-r5ZoHJf0gQd5vMBt6nRoLR8ShJCEm3AeBdPkht5LP0JyAIqTfR1xZ6nQrWJg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvddugedgfedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomhepuehoqhhunhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrd
    gtohhmqeenucggtffrrghtthgvrhhnpeehudfgudffffetuedtvdehueevledvhfelleei
    vedtgeeuhfegueevieduffeivdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpegsohhquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhi
    thihqdeiledvgeehtdeigedqudejjeekheehhedvqdgsohhquhhnrdhfvghngheppehgmh
    grihhlrdgtohhmsehfihigmhgvrdhnrghmvgdpnhgspghrtghpthhtohepvdefpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopehlhihuuggvsehrvgguhhgrthdrtghomhdprh
    gtphhtthhopehruhhsthdqfhhorhdqlhhinhhugiesvhhgvghrrdhkvghrnhgvlhdrohhr
    ghdprhgtphhtthhopegurghkrhesrhgvughhrghtrdgtohhmpdhrtghpthhtoheprghirh
    hlihgvugesrhgvughhrghtrdgtohhmpdhrtghpthhtohepmhhinhhgohesrhgvughhrght
    rdgtohhmpdhrtghpthhtohepfihilhhlsehkvghrnhgvlhdrohhrghdprhgtphhtthhope
    hlohhnghhmrghnsehrvgguhhgrthdrtghomhdprhgtphhtthhopehpvghtvghriiesihhn
    fhhrrgguvggrugdrohhrghdprhgtphhtthhopehtghhlgieslhhinhhuthhrohhnihigrd
    guvg
X-ME-Proxy: <xmx:C-r5ZhQeQpNvvNWh9tZLhYkCZoLoY14Agjrj4Bd-zXbOQMBtLL02aQ>
    <xmx:C-r5ZtyK4GiQ9-yCVIPL6dtWk1zT-A589XqiQO1pTaKmkh3BDrUW1g>
    <xmx:C-r5Zv5jE7BBuRzxt2qC3KqATTyPr_Nv1MeUOuUHKLRYrsWTQ36rjw>
    <xmx:C-r5ZqxY3UhIcRpjnByrv7mPxEfO16Vs-em_ttjuPKM0RQatDnYFnA>
    <xmx:C-r5ZhgWKtPA6CcO1UQhUj5PzO8-P54PcKS6xNxS38ESfHzw6IFM3N-k>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 29 Sep 2024 20:00:10 -0400 (EDT)
Date: Sun, 29 Sep 2024 16:59:14 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: Lyude Paul <lyude@redhat.com>
Cc: rust-for-linux@vger.kernel.org, Danilo Krummrich <dakr@redhat.com>,
	airlied@redhat.com, Ingo Molnar <mingo@redhat.com>,
	Will Deacon <will@kernel.org>, Waiman Long <longman@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
	Benno Lossin <benno.lossin@proton.me>,
	Daniel Almeida <daniel.almeida@collabora.com>,
	Gary Guo <gary@garyguo.net>, Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Wedson Almeida Filho <wedsonaf@gmail.com>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Andreas Hindborg <a.hindborg@samsung.com>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	Martin Rodriguez Reboredo <yakoyoku@gmail.com>,
	Valentin Obst <kernel@valentinobst.de>
Subject: Re: [PATCH v6 3/3] rust: sync: Add SpinLockIrq
Message-ID: <Zvnp0v-x1JZxnjmN@boqun-archlinux>
References: <20240916213025.477225-1-lyude@redhat.com>
 <20240916213025.477225-4-lyude@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240916213025.477225-4-lyude@redhat.com>

On Mon, Sep 16, 2024 at 05:28:06PM -0400, Lyude Paul wrote:
> A variant of SpinLock that is expected to be used in noirq contexts, and
> thus requires that the user provide an kernel::irq::IrqDisabled to prove
> they are in such a context upon lock acquisition. This is the rust
> equivalent of spin_lock_irqsave()/spin_lock_irqrestore().
> 
> Signed-off-by: Lyude Paul <lyude@redhat.com>
> Reviewed-by: Benno Lossin <benno.lossin@proton.me>
> Reviewed-by: Daniel Almeida <daniel.almeida@collabora.com>
> Reviewed-by: Gary Guo <gary@garyguo.net>

Reviewed-by: Boqun Feng <boqun.feng@gmail.com>

Regards,
Boqun

> 
> ---
> 
> V2:
> * s/IrqSpinLock/SpinLockIrq/
> * Implement `lock::Backend` now that we have `Context`
> * Add missing periods
> * Make sure rustdoc examples compile correctly
> * Add documentation suggestions
> 
> ---
>  rust/kernel/sync.rs               |   2 +-
>  rust/kernel/sync/lock/spinlock.rs | 104 ++++++++++++++++++++++++++++++
>  2 files changed, 105 insertions(+), 1 deletion(-)
> 
> diff --git a/rust/kernel/sync.rs b/rust/kernel/sync.rs
> index 0ab20975a3b5d..b028ee325f2a6 100644
> --- a/rust/kernel/sync.rs
> +++ b/rust/kernel/sync.rs
> @@ -15,7 +15,7 @@
>  pub use arc::{Arc, ArcBorrow, UniqueArc};
>  pub use condvar::{new_condvar, CondVar, CondVarTimeoutResult};
>  pub use lock::mutex::{new_mutex, Mutex};
> -pub use lock::spinlock::{new_spinlock, SpinLock};
> +pub use lock::spinlock::{new_spinlock, new_spinlock_irq, SpinLock, SpinLockIrq};
>  pub use locked_by::LockedBy;
>  
>  /// Represents a lockdep class. It's a wrapper around C's `lock_class_key`.
> diff --git a/rust/kernel/sync/lock/spinlock.rs b/rust/kernel/sync/lock/spinlock.rs
> index 97d85a5576615..47c71d779062a 100644
> --- a/rust/kernel/sync/lock/spinlock.rs
> +++ b/rust/kernel/sync/lock/spinlock.rs
> @@ -3,6 +3,7 @@
>  //! A kernel spinlock.
>  //!
>  //! This module allows Rust code to use the kernel's `spinlock_t`.
> +use kernel::irq::*;
>  
>  /// Creates a [`SpinLock`] initialiser with the given name and a newly-created lock class.
>  ///
> @@ -116,3 +117,106 @@ unsafe fn unlock(ptr: *mut Self::State, _guard_state: &Self::GuardState) {
>          unsafe { bindings::spin_unlock(ptr) }
>      }
>  }
> +
> +/// Creates a [`SpinLockIrq`] initialiser with the given name and a newly-created lock class.
> +///
> +/// It uses the name if one is given, otherwise it generates one based on the file name and line
> +/// number.
> +#[macro_export]
> +macro_rules! new_spinlock_irq {
> +    ($inner:expr $(, $name:literal)? $(,)?) => {
> +        $crate::sync::SpinLockIrq::new(
> +            $inner, $crate::optional_name!($($name)?), $crate::static_lock_class!())
> +    };
> +}
> +pub use new_spinlock_irq;
> +
> +/// A spinlock that may be acquired when interrupts are disabled.
> +///
> +/// A version of [`SpinLock`] that can only be used in contexts where interrupts for the local CPU
> +/// are disabled. It requires that the user acquiring the lock provide proof that interrupts are
> +/// disabled through [`IrqDisabled`].
> +///
> +/// For more info, see [`SpinLock`].
> +///
> +/// # Examples
> +///
> +/// The following example shows how to declare, allocate initialise and access a struct (`Example`)
> +/// that contains an inner struct (`Inner`) that is protected by a spinlock.
> +///
> +/// ```
> +/// use kernel::{
> +///     sync::{new_spinlock_irq, SpinLockIrq},
> +///     irq::{with_irqs_disabled, IrqDisabled}
> +/// };
> +///
> +/// struct Inner {
> +///     a: u32,
> +///     b: u32,
> +/// }
> +///
> +/// #[pin_data]
> +/// struct Example {
> +///     c: u32,
> +///     #[pin]
> +///     d: SpinLockIrq<Inner>,
> +/// }
> +///
> +/// impl Example {
> +///     fn new() -> impl PinInit<Self> {
> +///         pin_init!(Self {
> +///             c: 10,
> +///             d <- new_spinlock_irq!(Inner { a: 20, b: 30 }),
> +///         })
> +///     }
> +/// }
> +///
> +/// // Accessing an `Example` from a function that can only be called in no-irq contexts
> +/// fn noirq_work(e: &Example, irq: IrqDisabled<'_>) {
> +///     assert_eq!(e.c, 10);
> +///     assert_eq!(e.d.lock_with(irq).a, 20);
> +/// }
> +///
> +/// // Allocate a boxed `Example`
> +/// let e = Box::pin_init(Example::new(), GFP_KERNEL)?;
> +///
> +/// // Accessing an `Example` from a context where IRQs may not be disabled already.
> +/// let b = with_irqs_disabled(|irq| {
> +///     noirq_work(&e, irq);
> +///     e.d.lock_with(irq).b
> +/// });
> +/// assert_eq!(b, 30);
> +/// # Ok::<(), Error>(())
> +/// ```
> +pub type SpinLockIrq<T> = super::Lock<T, SpinLockIrqBackend>;
> +
> +/// A kernel `spinlock_t` lock backend that is acquired in no-irq contexts.
> +pub struct SpinLockIrqBackend;
> +
> +unsafe impl super::Backend for SpinLockIrqBackend {
> +    type State = bindings::spinlock_t;
> +    type GuardState = ();
> +    type Context<'a> = IrqDisabled<'a>;
> +
> +    unsafe fn init(
> +        ptr: *mut Self::State,
> +        name: *const core::ffi::c_char,
> +        key: *mut bindings::lock_class_key,
> +    ) {
> +        // SAFETY: The safety requirements ensure that `ptr` is valid for writes, and `name` and
> +        // `key` are valid for read indefinitely.
> +        unsafe { bindings::__spin_lock_init(ptr, name, key) }
> +    }
> +
> +    unsafe fn lock(ptr: *mut Self::State) -> Self::GuardState {
> +        // SAFETY: The safety requirements of this function ensure that `ptr` points to valid
> +        // memory, and that it has been initialised before.
> +        unsafe { bindings::spin_lock(ptr) }
> +    }
> +
> +    unsafe fn unlock(ptr: *mut Self::State, _guard_state: &Self::GuardState) {
> +        // SAFETY: The safety requirements of this function ensure that `ptr` is valid and that the
> +        // caller is the owner of the spinlock.
> +        unsafe { bindings::spin_unlock(ptr) }
> +    }
> +}
> -- 
> 2.46.0
> 

