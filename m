Return-Path: <linux-kernel+bounces-358800-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D19E9983FB
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 12:39:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C0151F27622
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 10:39:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BECD1C2308;
	Thu, 10 Oct 2024 10:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="QTVi215i"
Received: from mail-40133.protonmail.ch (mail-40133.protonmail.ch [185.70.40.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 023E61C1AB3
	for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 10:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728556778; cv=none; b=rkpFNxpIs9hIsGtY4optf0S10bFpKo50v7nkiEYfylH/BPmLzwv1LMnrKFwuY82LIEs+xl9vx8qqEMRwkCGz6NFcbOx0VKUIwQDt7xp2CfQilq7rtml7ViA6h2pgJTQy4+syc4U9BfQXuQF2/YWkXDzOby03rHt3CXcGkhA9Vgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728556778; c=relaxed/simple;
	bh=unWCd8Bj7m5kV38bwAaZ3iSQ42tE4Qa+3WqM5c4Oq40=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=McTfNNEpAJLoOVhHbMEyEKd3CwBMgxlRBjP3GRVYdPAXtJ8g9Q9nItcEMCmPVILfuCIoIY21joPoGqF1/xUpFiKlqcZuquYn1W38loE3rvutfNc72PUkUJ4bFz3oCuUTpAJekYiPNumDLIFtH+d1+//qRuR7nVdX42q3Z2Vuy3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=QTVi215i; arc=none smtp.client-ip=185.70.40.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=jqhjdjlg5vhhpffs2lm7ksfmp4.protonmail; t=1728556773; x=1728815973;
	bh=8Zf+6OnIHBMtlXd7FzOuX7ORu081uulAtd21bEUsr2c=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=QTVi215iA8LsutOzi6GKPp9pTSVybknFvKR5OCEBCbFu8lS5kmvabZzwD/NnQw2X9
	 YTzuS2/iNPQhiYUfJEB+q9c9j/iojAYh70XfKjGRUav0jzwdbt5GriAQYMt2wvNtkK
	 N7QrDlgLYUb+cpWgfuP0FCWAIMWRy+HjCInmC5hkBL2Xzat9IyAhFDOzcLUCYeRdrr
	 36R06mAHAsV9v+Bu2T7iif2jS5PnZSgOppSc97240cTC7PPFCSAqdcNDz6b/uGiUKf
	 X2YjBFggWmncxoaeuI2cxjoppwsziq7A5OAZapb2LWjSvpyRMLwX1v18/RmPJrE9EB
	 Psk7OJxDPbi1g==
Date: Thu, 10 Oct 2024 10:39:27 +0000
To: Alice Ryhl <aliceryhl@google.com>, Miguel Ojeda <ojeda@kernel.org>
From: Benno Lossin <benno.lossin@proton.me>
Cc: Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, Andreas Hindborg <a.hindborg@kernel.org>
Subject: Re: [PATCH v4] rust: add global lock support
Message-ID: <1f688070-66bd-450b-ba5d-b929de64ecf0@proton.me>
In-Reply-To: <20240930-static-mutex-v4-1-c59555413127@google.com>
References: <20240930-static-mutex-v4-1-c59555413127@google.com>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: 0bb8459485997070a8fe7cd17fff164fccb4da71
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 30.09.24 15:11, Alice Ryhl wrote:
> diff --git a/rust/kernel/sync/lock/global.rs b/rust/kernel/sync/lock/glob=
al.rs
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
> +///     static MY_COUNTER: Mutex<u32> =3D unsafe { uninit };
> +///     value: 0;
> +/// }
> +///
> +/// fn increment_counter() -> u32 {
> +///     let mut guard =3D MY_COUNTER.lock();
> +///     *guard +=3D 1;
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
> +///     static MY_MUTEX: Mutex<()> =3D unsafe { uninit };
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
> +///         let my_counter =3D self.my_counter.as_mut(guard);
> +///         *my_counter +=3D 1;
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

The docs here don't mention that you still need to call `.init()`
manually (though the examples show it nicely). I don't know if we want
macros to have a `# Safety` section.

> +#[macro_export]
> +macro_rules! global_lock {
> +    {
> +        $(#[$meta:meta])* $pub:vis static $name:ident: $kind:ident<$valu=
ety:ty> =3D unsafe { uninit };
> +        value: $value:expr;

I would find it more natural to use `=3D` instead of `:` here, since then
it would read as a normal statement with the semicolon at the end.
Another alternative would be to use `,` instead of `;`, but that doesn't
work nicely with the static keyword above (although you could make the
user write it in another {}, but that also isn't ideal...).

Using `=3D` instead of `:` makes my editor put the correct amount of
indentation there, `:` adds a lot of extra spaces.

> +        wrapper: $wrapper:ident;
> +        $( name: $lname:literal; )?
> +        $(
> +            guard: $guard:ident;
> +            locked_by: $locked_by:ident;
> +        )?
> +    } =3D> {
> +        $crate::macros::paste! {
> +            type [< __static_lock_ty_ $name >] =3D $valuety;
> +            const [< __static_lock_init_ $name >]: [< __static_lock_ty_ =
$name >] =3D $value;

Why are these two items outside of the `mod` below?
Also why do you need to define the type alias? You could just use
`$valuety`, right?

Also,

    error: type `__static_lock_ty_VALUE` should have an upper camel case na=
me
       --> rust/kernel/sync/lock/global.rs:100:18
        |
    100 |               type [< __static_lock_ty_ $name >] =3D $valuety;
        |                    ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ help: convert th=
e identifier to upper camel case: `StaticLockTyValue`

The same error affects the `wrapper` type forwarding below.


> +
> +            #[allow(unused_pub)]

    error: unknown lint: `unused_pub`
       --> rust/kernel/sync/lock/global.rs:103:21
        |
    103 |               #[allow(unused_pub)]
        |                       ^^^^^^^^^^ help: did you mean: `unused_mut`

Though I also get

    error: methods `init` and `lock` are never used
       --> rust/kernel/sync/lock/global.rs:128:42
        |
    122 | /                 impl $wrapper {
    123 | |                     /// Initialize the global lock.
    124 | |                     ///
    125 | |                     /// # Safety
    ...   |
    128 | |                     pub(crate) unsafe fn init(&'static self) {
        | |                                          ^^^^
    ...   |
    142 | |                     pub(crate) fn lock(&'static self) -> $crate=
::global_lock_inner!(guard $kind, $valuety $(, $guard)?) {
        | |                                   ^^^^
    ...   |
    146 | |                     }
    147 | |                 }
        | |_________________- methods in this implementation

But that is governed by the `dead_code` lint.

> +            mod [< __static_lock_mod_ $name >] {
> +                use super::[< __static_lock_ty_ $name >] as Val;
> +                use super::[< __static_lock_init_ $name >] as INIT;
> +                type Backend =3D $crate::global_lock_inner!(backend $kin=
d);
> +                type GuardTyp =3D $crate::global_lock_inner!(guard $kind=
, Val $(, $guard)?);

`GuardTyp` is only used once, so you should be able to just inline it.
`Backend` is used twice, but I don't know if we need a type alias for
it.

> +
> +                /// # Safety
> +                ///
> +                /// Must be used to initialize `super::$name`.
> +                pub(super) const unsafe fn new() -> $wrapper {

Why is this function not associated to `$wrapper`?

> +                    let state =3D $crate::types::Opaque::uninit();

Why not add

    const INIT: $valuety =3D $value;

here instead of outside the mod.

> +                    $wrapper {
> +                        // SAFETY: The user of this macro promises to ca=
ll `init` before calling
> +                        // `lock`.
> +                        inner: unsafe {
> +                            $crate::sync::lock::Lock::global_lock_helper=
_new(state, INIT)
> +                        }
> +                    }
> +                }
> +
> +                /// Wrapper type for a global lock.
> +                pub(crate) struct $wrapper {

How can the wrapper struct be `pub(crate)` when the constant might be
global `pub`?

    error: type `__static_lock_wrapper_INIT` is more private than the item =
`INIT`                                                                     =
                                                                           =
          =20
       --> rust/kernel/sync/lock/global.rs:206:14
        |                                   =20
    206 |               };                      =20
        |                ^ static `INIT` is reachable at visibility `pub`
        |                =20

The functions should probably just be `pub`.

---
Cheers,
Benno

> +                    inner: $crate::sync::lock::Lock<Val, Backend>,
> +                }
> +
> +              =20


