Return-Path: <linux-kernel+bounces-359188-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE14A99887A
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 15:58:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B9E962829FD
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 13:58:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 574381C9ED0;
	Thu, 10 Oct 2024 13:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Kof3JD6L"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 981B01C4604;
	Thu, 10 Oct 2024 13:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728568672; cv=none; b=Bu/3E8VsJyePUSGxCS5xzWOiQcTnoxeg4HocqiRZ4UXi2q/I5May3FtiuLO/UTIr4IU379/aCsU3RhtlQlLtJDLG81tMR1hs01rbh7lE4U3cEhuqg6KB5lsioYIoeRzlyglBZSaJO0VOINyZtc42PDclUjFXk5XLCkzBLG4jE44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728568672; c=relaxed/simple;
	bh=1VOERIfuRjOGynKShPT+L4ReBaV8/6F0QtPqzUFkntw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=EnxLdMXIYYS6BtyVZcJNmu2ClFtqZpq7i4GbKwZtKIMjyXNF+xToxsx8mVkbXqMjdIk825EMo2kCyAv34AGUwGwf/Stc6fgZf3vrU+97gEai96rUK4NPrF1dBbfCAd+eV9LnNpHZqNTxmjgP+LJlFrMb74vnCT4SsauRoq8WDpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Kof3JD6L; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A5E9C4CECC;
	Thu, 10 Oct 2024 13:57:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728568672;
	bh=1VOERIfuRjOGynKShPT+L4ReBaV8/6F0QtPqzUFkntw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=Kof3JD6LF2HWVqHef4MzDmJORRcOCQH+u5IABkZF3qUqqfH0sxveq7xusHLzWctxB
	 EmUhG8txkVrSJDOtuEJnljz0boUZGN4zHfhmBnSivLctpfj2vJgSUbg/6ETfahcj4l
	 LC1EgvNv1FoiNmG/K+sw+oQXqbvh8nFaYoc10v9N/rjXM4swK+3f+F0ezE2JZ1Pj4p
	 W3TxPeaL9KcnzZQh3dDTV/R0F9n3VPiJaSWDGlAaEJzJXDFZfpCpt2NibR1hlRatSB
	 m9rb+24GISmFIXrOYqxPqFmFCgPDn5wMcHiQcdJXrcQLblZDkDw1zWABRGlEoSkbc1
	 gxBfKGlMToJog==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: Alice Ryhl <aliceryhl@google.com>
Cc: Miguel Ojeda <ojeda@kernel.org>,  Boqun Feng <boqun.feng@gmail.com>,
  Gary Guo <gary@garyguo.net>,  =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>,  Benno Lossin <benno.lossin@proton.me>,
  rust-for-linux@vger.kernel.org,  linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] rust: add global lock support
In-Reply-To: <20240930-static-mutex-v4-1-c59555413127@google.com> (Alice
	Ryhl's message of "Mon, 30 Sep 2024 13:11:17 +0000")
References: <20240930-static-mutex-v4-1-c59555413127@google.com>
Date: Thu, 10 Oct 2024 15:57:38 +0200
Message-ID: <87r08okqlp.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Hi Alice,

Alice Ryhl <aliceryhl@google.com> writes:

> Add support for creating global variables that are wrapped in a mutex or
> spinlock. Optionally, the macro can generate a special LockedBy type
> that does not require a runtime check.
>
> The implementation here is intended to replace the global mutex
> workaround found in the Rust Binder RFC [1]. In both cases, the global
> lock must be initialized before first use. The macro is unsafe to use
> for the same reason.
>
> The separate initialization step is required because it is tricky to
> access the value of __ARCH_SPIN_LOCK_UNLOCKED from Rust. Doing so will
> require changes to the C side. That change will happen as a follow-up to
> this patch.

Why is this a challenge? It seems to work with locks that are not
global.

[...]

> diff --git a/rust/kernel/sync/lock/global.rs b/rust/kernel/sync/lock/global.rs
> new file mode 100644
> index 000000000000..fc02fac864f6
> --- /dev/null
> +++ b/rust/kernel/sync/lock/global.rs
> @@ -0,0 +1,260 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +// Copyright (C) 2024 Google LLC.
> +
> +//! Support for defining statics containing locks.
> +
> +/// Defines a global lock.
> +///
> +/// Supports the following options:
> +///
> +/// * `value` specifies the initial value in the global lock.
> +/// * `wrapper` specifies the name of the wrapper struct.

Could you add an example to demonstrate when using `wrapper` option
would be useful?

> +/// * `guard` specifies the name of the guard type.
> +/// * `locked_by` specifies the name of the `LockedBy` type.
> +///
> +/// # Examples
> +///
> +/// A global counter.
> +///
> +/// ```
> +/// # mod ex {
> +/// # use kernel::prelude::*;
> +/// kernel::sync::global_lock! {
> +///     // SAFETY: Initialized in module initializer before first use.
> +///     static MY_COUNTER: Mutex<u32> = unsafe { uninit };
> +///     value: 0;
> +/// }
> +///
> +/// fn increment_counter() -> u32 {
> +///     let mut guard = MY_COUNTER.lock();
> +///     *guard += 1;
> +///     *guard
> +/// }
> +///
> +/// impl kernel::Module for MyModule {
> +///     fn init(_module: &'static ThisModule) -> Result<Self> {
> +///         // SAFETY: called exactly once
> +///         unsafe { MY_COUNTER.init() };
> +///
> +///         Ok(MyModule {})
> +///     }
> +/// }
> +/// # struct MyModule {}
> +/// # }
> +/// ```
> +///
> +/// A global mutex used to protect all instances of a given struct.
> +///
> +/// ```
> +/// # mod ex {
> +/// # use kernel::prelude::*;
> +/// kernel::sync::global_lock! {
> +///     // SAFETY: Initialized in module initializer before first use.
> +///     static MY_MUTEX: Mutex<()> = unsafe { uninit };
> +///     value: ();
> +///     guard: MyGuard;
> +///     locked_by: LockedByMyMutex;
> +/// }
> +///
> +/// /// All instances of this struct are protected by `MY_MUTEX`.
> +/// struct MyStruct {
> +///     my_counter: LockedByMyMutex<u32>,
> +/// }
> +///
> +/// impl MyStruct {
> +///     /// Increment the counter in this instance.
> +///     ///
> +///     /// The caller must hold the `MY_MUTEX` mutex.
> +///     fn increment(&self, guard: &mut MyGuard) -> u32 {
> +///         let my_counter = self.my_counter.as_mut(guard);
> +///         *my_counter += 1;
> +///         *my_counter
> +///     }
> +/// }
> +///
> +/// impl kernel::Module for MyModule {
> +///     fn init(_module: &'static ThisModule) -> Result<Self> {
> +///         // SAFETY: called exactly once
> +///         unsafe { MY_MUTEX.init() };
> +///
> +///         Ok(MyModule {})
> +///     }
> +/// }
> +/// # struct MyModule {}
> +/// # }
> +/// ```
> +#[macro_export]
> +macro_rules! global_lock {
> +    {
> +        $(#[$meta:meta])* $pub:vis static $name:ident: $kind:ident<$valuety:ty> = unsafe { uninit };
> +        value: $value:expr;
> +        wrapper: $wrapper:ident;
> +        $( name: $lname:literal; )?
> +        $(
> +            guard: $guard:ident;
> +            locked_by: $locked_by:ident;
> +        )?
> +    } => {
> +        $crate::macros::paste! {
> +            type [< __static_lock_ty_ $name >] = $valuety;
> +            const [< __static_lock_init_ $name >]: [< __static_lock_ty_ $name >] = $value;
> +
> +            #[allow(unused_pub)]
> +            mod [< __static_lock_mod_ $name >] {
> +                use super::[< __static_lock_ty_ $name >] as Val;
> +                use super::[< __static_lock_init_ $name >] as INIT;
> +                type Backend = $crate::global_lock_inner!(backend $kind);
> +                type GuardTyp = $crate::global_lock_inner!(guard $kind, Val $(, $guard)?);
> +
> +                /// # Safety
> +                ///
> +                /// Must be used to initialize `super::$name`.
> +                pub(super) const unsafe fn new() -> $wrapper {
> +                    let state = $crate::types::Opaque::uninit();
> +                    $wrapper {
> +                        // SAFETY: The user of this macro promises to call `init` before calling
> +                        // `lock`.
> +                        inner: unsafe {
> +                            $crate::sync::lock::Lock::global_lock_helper_new(state, INIT)
> +                        }
> +                    }
> +                }
> +
> +                /// Wrapper type for a global lock.
> +                pub(crate) struct $wrapper {
> +                    inner: $crate::sync::lock::Lock<Val, Backend>,
> +                }
> +
> +                impl $wrapper {
> +                    /// Initialize the global lock.
> +                    ///
> +                    /// # Safety
> +                    ///
> +                    /// This method must not be called more than once.
> +                    pub(crate) unsafe fn init(&'static self) {
> +                        // SAFETY:
> +                        // * This type can only be created by `new`.
> +                        // * Caller promises to not call this method more than once.
> +                        unsafe {
> +                            $crate::sync::lock::Lock::global_lock_helper_init(
> +                                ::core::pin::Pin::static_ref(&self.inner),
> +                                $crate::optional_name!($($lname)?),
> +                                $crate::static_lock_class!(),
> +                            );
> +                        }
> +                    }
> +
> +                    /// Lock this global lock.
> +                    pub(crate) fn lock(&'static self) -> GuardTyp {
> +                        $crate::global_lock_inner!(new_guard $($guard)? {
> +                            self.inner.lock()
> +                        })
> +                    }
> +
> +                    /// Lock this global lock.

"Try to lock..." ?

Best regards,
Andreas


