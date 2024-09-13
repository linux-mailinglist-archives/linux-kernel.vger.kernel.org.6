Return-Path: <linux-kernel+bounces-328534-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C685978557
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 18:02:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 621C81C216A9
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 16:02:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CDE76BFA3;
	Fri, 13 Sep 2024 16:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="YJc0Miu9"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3006A36AF8
	for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2024 16:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726243327; cv=none; b=ZC47hOYToliKUxLOBRY+RL7YW6Fr/vwhsnpirRkKJDg8thc5kq90lB3/bvtn6c9h1J32woUaMDMwOrsruddesMOWnlcIBqxEtBNb7UdwyvuZ2UqmkblHj1k5n1mxwuSAQZKQ66ygIDvQDsTjPKIZeTcyfMTjRFY/rUbaBEcRWBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726243327; c=relaxed/simple;
	bh=K/mhLJMvEunhzXXiJGi7I4liWcDDWB1oFDZjpS7m/1U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DWU49kjzbXVbARGR058UIQkUWsN0Vo5Y4xGpg4ignjxBd8P4WheqnvfbZSZ3oY1/lqbWbOrCLuCQ6hayXIgx5ZjKWW3v7TtAJMVhOHezu5cv+uhlG7onFklVfZwguKAKs+63q161oYOFjHPoPdvNLIMg1j7Jq8bK6l9m9SV5Dlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch; spf=none smtp.mailfrom=ffwll.ch; dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b=YJc0Miu9; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ffwll.ch
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-42cbc22e1c4so9979225e9.2
        for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2024 09:02:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google; t=1726243322; x=1726848122; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ucXoPNM5iv3Z48KoYnoRdXBOJh2joZhrnD0xMJKeank=;
        b=YJc0Miu9xw5h331yoGJkkg2TvwQi8OApfCuq83cloj4+rFhJIKW+4ml1lnIXnPo8Ow
         M3Xv536g90S0W/6INvD0tEqggaH7EvZ2UswNW8A/ZlmyoJXDQ68GJuzwO8B635+IGRlN
         wVgxTrMA0yoffrNNygMA5IYpT1mOi/FOw5a0c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726243322; x=1726848122;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ucXoPNM5iv3Z48KoYnoRdXBOJh2joZhrnD0xMJKeank=;
        b=FIPyJiNf7na6I2T3ZPSHWqqU5YtjvgFdKtpW1TqYha5xN5Lc33f69mu7ZRSbab6eQc
         vYdQnXr1QfDMI3x1skhmnsZOKnLOEsfsl0jp5NkJ/AWiZjJIQrFfZp7jUYInLroNBf8c
         7wL9Bd9/7kql5JZ1Yk0H23OI8j9PwzfaW6xY9F/uGRILtMEy9S56Him/s27UT4NkanP2
         YVViEO41OerF/Vhu61NPdurXThnnnX0POfRB7d6OI1CLSqrj61l7jx8OYzrZKBj4VJBd
         W/KDXO+oB1SP/mGXrsBMofneKqhLNIFowPzF4pbuxbWhD1kqwL9j+ea+zx5PSY6xe4v9
         2XSA==
X-Forwarded-Encrypted: i=1; AJvYcCUQNWbfkvLjCi8gWf4qPlCyoRyr7Wl+JhnXvYiXNZ0GjNDoBGCp/igHsHSzF/+bR30/G26FOSEjdemI+tg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxMnhC0d4Cd4y83sTEhKhAaOjt6+U8TYG5gJwMgE/UsSXvDW2Q0
	QXlJrlo7wVamirqiuR+tWNHLim6oUjl3XGFLI3mQ4Uf79xLL5i9csL2Qd1ThLP8=
X-Google-Smtp-Source: AGHT+IHQUhB1vBWL4HY6/Iwwa8tGpvaiq4QI+ygJWY509coLxHJRlQfjU4LUgCLAmRnuO4nujPiNfQ==
X-Received: by 2002:a05:600c:1d17:b0:42b:a7c7:5667 with SMTP id 5b1f17b1804b1-42d964d8563mr25882725e9.25.1726243321922;
        Fri, 13 Sep 2024 09:02:01 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:5485:d4b2:c087:b497])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42d9b054f97sm30579215e9.4.2024.09.13.09.02.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Sep 2024 09:02:00 -0700 (PDT)
Date: Fri, 13 Sep 2024 18:01:58 +0200
From: Simona Vetter <simona.vetter@ffwll.ch>
To: Alice Ryhl <aliceryhl@google.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@samsung.com>,
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] rust: add global lock support
Message-ID: <ZuRh9niSrX6E5CWq@phenom.ffwll.local>
Mail-Followup-To: Alice Ryhl <aliceryhl@google.com>,
	Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@samsung.com>,
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240910-static-mutex-v3-1-5bebd11bdf3b@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240910-static-mutex-v3-1-5bebd11bdf3b@google.com>
X-Operating-System: Linux phenom 6.9.12-amd64 

On Tue, Sep 10, 2024 at 02:23:34PM +0000, Alice Ryhl wrote:
> Add support for creating global variables that are wrapped in a mutex or
> spinlock. Optionally, the macro can generate a special LockedBy type
> that does not require a runtime check.
> 
> The implementation here is intended to replace the global mutex
> workaround found in the Rust Binder RFC [1]. In both cases, the global
> lock must be initialized before first use. The macro is unsafe to use
> for the same reason.
> 
> The separate initialization step is required because bindgen refuses to
> expose __ARCH_SPIN_LOCK_UNLOCKED to Rust as a compile-time constant. It
> just generates an `extern "C"` global reference instead. In the future,
> we could expose the value of __ARCH_SPIN_LOCK_UNLOCKED to Rust in a way
> that Rust can understand. This would remove the need for a separate
> initialization step.

Yeah it's just a raw C struct initializer, I wouldn't even know how to
move that to rust.

An absolute horrible idea, and I didn't try whether it's even possible:
- put all the global locks of a type into a special linker section (we
  need a macro anyway for them).
- patch them up with a horrible linker script objtool patching with an
  example lock initialized by the C macro.

Even worse idea, on most architectures/config it's all zeros. Iirc the one
I've found that might matter a bit is CONFIG_SMP=n with some lock
debugging enabled. We could make rust support conditional on those, and
then maybe a build-time check that it's actually all set to 0 ...

Requiring the unsafe init just feels a bit disappointing to me, when the C
side (including lockdep annotations) tries really hard to make global
locks a one-liner.

Cheers, Sima

> 
> Link: https://lore.kernel.org/rust-for-linux/20231101-rust-binder-v1-2-08ba9197f637@google.com/#Z31drivers:android:context.rs [1]
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>
> ---
> I've been having some trouble with the kunit tests. The import of
> __static_lock_ty_$name fails when I try with kunit, but copying the same
> code into a sample does not reproduce the error. Suggestions would be
> appreciated.
> ---
> Changes in v3:
> - Rewrite to provide a macro instead.
> - Link to v2: https://lore.kernel.org/r/20240827-static-mutex-v2-1-17fc32b20332@google.com
> 
> Changes in v2:
> - Require `self: Pin<&Self>` and recommend `Pin::static_ref`.
> - Other doc improvements including new example.
> - Link to v1: https://lore.kernel.org/r/20240826-static-mutex-v1-1-a14ee71561f3@google.com
> ---
>  rust/kernel/sync.rs             |   1 +
>  rust/kernel/sync/lock.rs        |  31 +++++-
>  rust/kernel/sync/lock/global.rs | 237 ++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 268 insertions(+), 1 deletion(-)
> 
> diff --git a/rust/kernel/sync.rs b/rust/kernel/sync.rs
> index 0ab20975a3b5..2e97e22715db 100644
> --- a/rust/kernel/sync.rs
> +++ b/rust/kernel/sync.rs
> @@ -14,6 +14,7 @@
>  
>  pub use arc::{Arc, ArcBorrow, UniqueArc};
>  pub use condvar::{new_condvar, CondVar, CondVarTimeoutResult};
> +pub use lock::global::global_lock;
>  pub use lock::mutex::{new_mutex, Mutex};
>  pub use lock::spinlock::{new_spinlock, SpinLock};
>  pub use locked_by::LockedBy;
> diff --git a/rust/kernel/sync/lock.rs b/rust/kernel/sync/lock.rs
> index f6c34ca4d819..3ae7a278016d 100644
> --- a/rust/kernel/sync/lock.rs
> +++ b/rust/kernel/sync/lock.rs
> @@ -7,12 +7,14 @@
>  
>  use super::LockClassKey;
>  use crate::{init::PinInit, pin_init, str::CStr, types::Opaque, types::ScopeGuard};
> -use core::{cell::UnsafeCell, marker::PhantomData, marker::PhantomPinned};
> +use core::{cell::UnsafeCell, marker::PhantomData, marker::PhantomPinned, pin::Pin};
>  use macros::pin_data;
>  
>  pub mod mutex;
>  pub mod spinlock;
>  
> +pub(super) mod global;
> +
>  /// The "backend" of a lock.
>  ///
>  /// It is the actual implementation of the lock, without the need to repeat patterns used in all
> @@ -117,6 +119,33 @@ pub fn new(t: T, name: &'static CStr, key: &'static LockClassKey) -> impl PinIni
>              }),
>          })
>      }
> +
> +    /// # Safety
> +    ///
> +    /// Before any other method on this lock is called, `global_lock_helper_init` must be called.
> +    #[doc(hidden)]
> +    pub const unsafe fn global_lock_helper_new(state: Opaque<B::State>, data: T) -> Self {
> +        Self {
> +            state,
> +            data: UnsafeCell::new(data),
> +            _pin: PhantomPinned,
> +        }
> +    }
> +
> +    /// # Safety
> +    ///
> +    /// * This lock must have been created using `global_lock_helper_new`.
> +    /// * Must only be called once for each lock.
> +    #[doc(hidden)]
> +    pub unsafe fn global_lock_helper_init(
> +        self: Pin<&Self>,
> +        name: &'static CStr,
> +        key: &'static LockClassKey,
> +    ) {
> +        // SAFETY: The pointer to `state` is valid for the duration of this call, and both `name`
> +        // and `key` are valid indefinitely.
> +        unsafe { B::init(self.state.get(), name.as_char_ptr(), key.as_ptr()) }
> +    }
>  }
>  
>  impl<T: ?Sized, B: Backend> Lock<T, B> {
> diff --git a/rust/kernel/sync/lock/global.rs b/rust/kernel/sync/lock/global.rs
> new file mode 100644
> index 000000000000..c1eb25d37abd
> --- /dev/null
> +++ b/rust/kernel/sync/lock/global.rs
> @@ -0,0 +1,237 @@
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
> +/// * `guard` specifies the name of the guard type.
> +/// * `locked_by` specifies the name of the `LockedBy` type.
> +///
> +/// # Examples
> +///
> +/// A global counter.
> +///
> +/// ```
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
> +/// ```
> +///
> +/// A global mutex used to protect all instances of a given struct.
> +///
> +/// ```
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
> +
> +            #[allow(unused_pub)]
> +            mod [< __static_lock_mod_ $name >] {
> +                use super::[< __static_lock_ty_ $name >] as Val;
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
> +                            $crate::sync::lock::Lock::global_lock_helper_new(state, $value)
> +                        }
> +                    }
> +                }
> +
> +                /// Wrapper type for a global lock.
> +                pub struct $wrapper {
> +                    inner: $crate::sync::lock::Lock<Val, Backend>,
> +                }
> +
> +                impl $wrapper {
> +                    /// Initialize the global lock.
> +                    ///
> +                    /// # Safety
> +                    ///
> +                    /// This method must not be called more than once.
> +                    pub unsafe fn init(&'static self) {
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
> +                    pub fn lock(&'static self) -> GuardTyp {
> +                        $crate::global_lock_inner!(new_guard $($guard)? {
> +                            self.inner.lock()
> +                        })
> +                    }
> +                }
> +
> +                $(
> +                pub struct $guard($crate::sync::lock::Guard<'static, Val, Backend>);
> +
> +                impl ::core::ops::Deref for $guard {
> +                    type Target = Val;
> +                    fn deref(&self) -> &Val {
> +                        &self.0
> +                    }
> +                }
> +
> +                impl ::core::ops::DerefMut for $guard {
> +                    fn deref_mut(&mut self) -> &mut Val {
> +                        &mut self.0
> +                    }
> +                }
> +
> +                pub struct $locked_by<T: ?Sized>(::core::cell::UnsafeCell<T>);
> +
> +                impl<T> $locked_by<T> {
> +                    pub fn new(val: T) -> Self {
> +                        Self(::core::cell::UnsafeCell::new(val))
> +                    }
> +                }
> +
> +                impl<T: ?Sized> $locked_by<T> {
> +                    pub fn as_ref<'a>(&'a self, _guard: &'a $guard) -> &'a T {
> +                        // SAFETY: The lock is globally unique, so there can only be one guard.
> +                        unsafe { &*self.0.get() }
> +                    }
> +
> +                    pub fn as_mut<'a>(&'a self, _guard: &'a mut $guard) -> &'a mut T {
> +                        // SAFETY: The lock is globally unique, so there can only be one guard.
> +                        unsafe { &mut *self.0.get() }
> +                    }
> +
> +                    pub fn get_mut(&mut self) -> &mut T {
> +                        self.0.get_mut()
> +                    }
> +                }
> +                )?
> +            }
> +
> +            use [< __static_lock_mod_ $name >]::$wrapper;
> +            $( use [< __static_lock_mod_ $name >]::{$guard, $locked_by}; )?
> +
> +            $(#[$meta])*
> +            $pub static $name: $wrapper = {
> +                // SAFETY: We are using this to initialize $name.
> +                unsafe { [< __static_lock_mod_ $name >]::new() }
> +            };
> +        }
> +    };
> +
> +    {
> +        $(#[$meta:meta])* $pub:vis static $name:ident: $kind:ident<$valuety:ty> = unsafe { uninit };
> +        value: $value:expr;
> +        $( name: $lname:literal; )?
> +        $(
> +            guard: $guard:ident;
> +            locked_by: $locked_by:ident;
> +        )?
> +    } => {
> +        $crate::macros::paste! {
> +            $crate::global_lock! {
> +                $(#[$meta])* $pub static $name: $kind<$valuety> = unsafe { uninit };
> +                value: $value;
> +                wrapper: [< __static_lock_wrapper_ $name >];
> +                $( name: $lname; )?
> +                $( guard: $guard; locked_by: $locked_by; )?
> +            }
> +        }
> +    }
> +}
> +pub use global_lock;
> +
> +#[doc(hidden)]
> +#[macro_export]
> +macro_rules! global_lock_inner {
> +    (backend Mutex) => { $crate::sync::lock::mutex::MutexBackend };
> +    (backend SpinLock) => { $crate::sync::lock::spinlock::SpinLockBackend };
> +    (guard Mutex, $val:ty) => {
> +        $crate::sync::lock::Guard<'static, $val, $crate::sync::lock::mutex::MutexBackend>
> +    };
> +    (guard SpinLock, $val:ty) => {
> +        $crate::sync::lock::Guard<'static, $val, $crate::sync::lock::spinlock::SpinLockBackend>
> +    };
> +    (guard $kind:ident, $val:ty, $name:ident) => { $name };
> +    (new_guard { $val:expr }) => { $val };
> +    (new_guard $name:ident { $val:expr }) => { $name($val) };
> +}
> 
> ---
> base-commit: 93dc3be19450447a3a7090bd1dfb9f3daac3e8d2
> change-id: 20240826-static-mutex-a4b228e0e6aa
> 
> Best regards,
> -- 
> Alice Ryhl <aliceryhl@google.com>
> 

-- 
Simona Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch

