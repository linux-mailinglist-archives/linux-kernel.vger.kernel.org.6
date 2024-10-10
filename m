Return-Path: <linux-kernel+bounces-360131-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D3E29994FB
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 00:13:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A0A141F247E4
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 22:13:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7644E1E500F;
	Thu, 10 Oct 2024 22:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="Sd5gxSJR"
Received: from mail-4316.protonmail.ch (mail-4316.protonmail.ch [185.70.43.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25AA2188CAE;
	Thu, 10 Oct 2024 22:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728598427; cv=none; b=J9v9+BPF4MG4Bf7Sg3CvkmWGUKkXufMgY1Fo0bBN4HuKaDtxa7H+wZzjCByvobIWOYrqjbwi7PQN/mJShkFP8Q+gmbdLlj2opaUx0V7wh4AmLavXZV9tpkT2aPCKS9KPhQoC9XZp1zvQmGwp3kzUN1499/4DHiJyYMK5tSa2AFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728598427; c=relaxed/simple;
	bh=q22wwYQiO2VBHxPxIvpjGVjClYz7q9lpvsiZ1RggzOY=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CfI9UCgvhtv8LLx3W9QUCJSk2/EY3UyKBuOG7/eEOmBn24IKvZpNNrNmRCsUJfhTvsJoRaHDErI6E+xtUrJV2GjpL93vLVe9KqNS/I4CQqH3CxH8lASsRlLY+zG2Fc+ZAh9/+bd0yikwa6RGP6fJgCW7R1TCvxTxzsFeDy7ut5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=Sd5gxSJR; arc=none smtp.client-ip=185.70.43.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1728598422; x=1728857622;
	bh=+rMiRA5IGnx43R0jh0vX1MDX6tE0GA9S/kOdoqjvBoE=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=Sd5gxSJRm6Gmn5ZrqDy5+4V74ZwR0oMKvcHdHeDLJZ+9f6BYU+gRNBT+ttCgL97dO
	 Rp9bJjZqJAEkI2QSHKVU+a8sZ03Yu5AMvjqYdUCLC+g0GtsWgzNBY/88S4gZOo9C6K
	 StqVqHXMWWmTrWD3+wRAyY1bNk9OLKwIJ3T13H/5fv5Ep8VbCaCw0oRZrpDN1ANi1d
	 aY1QoT9kOJZbQz4CI4UgyH7vL4adhjMFQjDXHZG5C70IWIcA9I9PElGJ/bR2FgHYmN
	 R7yTmWZvcNaqp6Qfvt1W6ecxWcnkRbTKnVYuQUyRdeAvy8JOX5jzHx9eMbQ0XCdvAm
	 la/btuLplOHkA==
Date: Thu, 10 Oct 2024 22:13:38 +0000
To: Alice Ryhl <aliceryhl@google.com>
From: Benno Lossin <benno.lossin@proton.me>
Cc: Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, Andreas Hindborg <a.hindborg@kernel.org>
Subject: Re: [PATCH v4] rust: add global lock support
Message-ID: <2f3e6cac-1642-489b-b045-32211e296137@proton.me>
In-Reply-To: <CAH5fLghsozD0qeTygBM0-WDgXRwtGcsc6B3bT1794QMx3=vSTg@mail.gmail.com>
References: <20240930-static-mutex-v4-1-c59555413127@google.com> <1f688070-66bd-450b-ba5d-b929de64ecf0@proton.me> <CAH5fLghsozD0qeTygBM0-WDgXRwtGcsc6B3bT1794QMx3=vSTg@mail.gmail.com>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: 61040bb2d23b0698a75bc8ccb8b41e541a39e674
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 10.10.24 12:53, Alice Ryhl wrote:
> On Thu, Oct 10, 2024 at 12:39=E2=80=AFPM Benno Lossin <benno.lossin@proto=
n.me> wrote:
>>
>> On 30.09.24 15:11, Alice Ryhl wrote:
>>> diff --git a/rust/kernel/sync/lock/global.rs b/rust/kernel/sync/lock/gl=
obal.rs
>>> new file mode 100644
>>> index 000000000000..fc02fac864f6
>>> --- /dev/null
>>> +++ b/rust/kernel/sync/lock/global.rs
>>> @@ -0,0 +1,260 @@
>>> +// SPDX-License-Identifier: GPL-2.0
>>> +
>>> +// Copyright (C) 2024 Google LLC.
>>> +
>>> +//! Support for defining statics containing locks.
>>> +
>>> +/// Defines a global lock.
>>> +///
>>> +/// Supports the following options:
>>> +///
>>> +/// * `value` specifies the initial value in the global lock.
>>> +/// * `wrapper` specifies the name of the wrapper struct.
>>> +/// * `guard` specifies the name of the guard type.
>>> +/// * `locked_by` specifies the name of the `LockedBy` type.
>>> +///
>>> +/// # Examples
>>> +///
>>> +/// A global counter.
>>> +///
>>> +/// ```
>>> +/// # mod ex {
>>> +/// # use kernel::prelude::*;
>>> +/// kernel::sync::global_lock! {
>>> +///     // SAFETY: Initialized in module initializer before first use.
>>> +///     static MY_COUNTER: Mutex<u32> =3D unsafe { uninit };
>>> +///     value: 0;
>>> +/// }
>>> +///
>>> +/// fn increment_counter() -> u32 {
>>> +///     let mut guard =3D MY_COUNTER.lock();
>>> +///     *guard +=3D 1;
>>> +///     *guard
>>> +/// }
>>> +///
>>> +/// impl kernel::Module for MyModule {
>>> +///     fn init(_module: &'static ThisModule) -> Result<Self> {
>>> +///         // SAFETY: called exactly once
>>> +///         unsafe { MY_COUNTER.init() };
>>> +///
>>> +///         Ok(MyModule {})
>>> +///     }
>>> +/// }
>>> +/// # struct MyModule {}
>>> +/// # }
>>> +/// ```
>>> +///
>>> +/// A global mutex used to protect all instances of a given struct.
>>> +///
>>> +/// ```
>>> +/// # mod ex {
>>> +/// # use kernel::prelude::*;
>>> +/// kernel::sync::global_lock! {
>>> +///     // SAFETY: Initialized in module initializer before first use.
>>> +///     static MY_MUTEX: Mutex<()> =3D unsafe { uninit };
>>> +///     value: ();
>>> +///     guard: MyGuard;
>>> +///     locked_by: LockedByMyMutex;
>>> +/// }
>>> +///
>>> +/// /// All instances of this struct are protected by `MY_MUTEX`.
>>> +/// struct MyStruct {
>>> +///     my_counter: LockedByMyMutex<u32>,
>>> +/// }
>>> +///
>>> +/// impl MyStruct {
>>> +///     /// Increment the counter in this instance.
>>> +///     ///
>>> +///     /// The caller must hold the `MY_MUTEX` mutex.
>>> +///     fn increment(&self, guard: &mut MyGuard) -> u32 {
>>> +///         let my_counter =3D self.my_counter.as_mut(guard);
>>> +///         *my_counter +=3D 1;
>>> +///         *my_counter
>>> +///     }
>>> +/// }
>>> +///
>>> +/// impl kernel::Module for MyModule {
>>> +///     fn init(_module: &'static ThisModule) -> Result<Self> {
>>> +///         // SAFETY: called exactly once
>>> +///         unsafe { MY_MUTEX.init() };
>>> +///
>>> +///         Ok(MyModule {})
>>> +///     }
>>> +/// }
>>> +/// # struct MyModule {}
>>> +/// # }
>>> +/// ```
>>
>> The docs here don't mention that you still need to call `.init()`
>> manually (though the examples show it nicely). I don't know if we want
>> macros to have a `# Safety` section.
>>
>>> +#[macro_export]
>>> +macro_rules! global_lock {
>>> +    {
>>> +        $(#[$meta:meta])* $pub:vis static $name:ident: $kind:ident<$va=
luety:ty> =3D unsafe { uninit };
>>> +        value: $value:expr;
>>
>> I would find it more natural to use `=3D` instead of `:` here, since the=
n
>> it would read as a normal statement with the semicolon at the end.
>> Another alternative would be to use `,` instead of `;`, but that doesn't
>> work nicely with the static keyword above (although you could make the
>> user write it in another {}, but that also isn't ideal...).
>>
>> Using `=3D` instead of `:` makes my editor put the correct amount of
>> indentation there, `:` adds a lot of extra spaces.
>=20
> That seems sensible.
>=20
>>> +        wrapper: $wrapper:ident;
>>> +        $( name: $lname:literal; )?
>>> +        $(
>>> +            guard: $guard:ident;
>>> +            locked_by: $locked_by:ident;
>>> +        )?
>>> +    } =3D> {
>>> +        $crate::macros::paste! {
>>> +            type [< __static_lock_ty_ $name >] =3D $valuety;
>>> +            const [< __static_lock_init_ $name >]: [< __static_lock_ty=
_ $name >] =3D $value;
>>
>> Why are these two items outside of the `mod` below?
>> Also why do you need to define the type alias? You could just use
>> `$valuety`, right?
>=20
> Because they might access things that are in scope here, but not in
> scope inside the module.

Right... That's rather annoying...

>> Also,
>>
>>     error: type `__static_lock_ty_VALUE` should have an upper camel case=
 name
>>        --> rust/kernel/sync/lock/global.rs:100:18
>>         |
>>     100 |               type [< __static_lock_ty_ $name >] =3D $valuety;
>>         |                    ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ help: convert=
 the identifier to upper camel case: `StaticLockTyValue`
>>
>> The same error affects the `wrapper` type forwarding below.
>>
>>
>>> +
>>> +            #[allow(unused_pub)]
>>
>>     error: unknown lint: `unused_pub`
>>        --> rust/kernel/sync/lock/global.rs:103:21
>>         |
>>     103 |               #[allow(unused_pub)]
>>         |                       ^^^^^^^^^^ help: did you mean: `unused_m=
ut`
>=20
> Uhhh. This is the lint for when you mark a function pub but don't
> actually export it from the crate. But now I can't find the lint
> anywhere ... I'm so confused.

Maybe you mean `unreachable_pub`?

>> Though I also get
>>
>>     error: methods `init` and `lock` are never used
>>        --> rust/kernel/sync/lock/global.rs:128:42
>>         |
>>     122 | /                 impl $wrapper {
>>     123 | |                     /// Initialize the global lock.
>>     124 | |                     ///
>>     125 | |                     /// # Safety
>>     ...   |
>>     128 | |                     pub(crate) unsafe fn init(&'static self)=
 {
>>         | |                                          ^^^^
>>     ...   |
>>     142 | |                     pub(crate) fn lock(&'static self) -> $cr=
ate::global_lock_inner!(guard $kind, $valuety $(, $guard)?) {
>>         | |                                   ^^^^
>>     ...   |
>>     146 | |                     }
>>     147 | |                 }
>>         | |_________________- methods in this implementation
>>
>> But that is governed by the `dead_code` lint.
>=20
> I guess I have to look into the lints again. I did not get this lint.

I just put a `global_lock!` invocation into `lib.rs` and didn't use any
of the functions. But maybe we want that to error?

>>> +            mod [< __static_lock_mod_ $name >] {
>>> +                use super::[< __static_lock_ty_ $name >] as Val;
>>> +                use super::[< __static_lock_init_ $name >] as INIT;
>>> +                type Backend =3D $crate::global_lock_inner!(backend $k=
ind);
>>> +                type GuardTyp =3D $crate::global_lock_inner!(guard $ki=
nd, Val $(, $guard)?);
>>
>> `GuardTyp` is only used once, so you should be able to just inline it.
>> `Backend` is used twice, but I don't know if we need a type alias for
>> it.
>=20
> They're both used twice. Inlining them makes the lines really long.

Ah I missed the one on try_lock. It's fine to keep them.

>>> +                    $wrapper {
>>> +                        // SAFETY: The user of this macro promises to =
call `init` before calling
>>> +                        // `lock`.
>>> +                        inner: unsafe {
>>> +                            $crate::sync::lock::Lock::global_lock_help=
er_new(state, INIT)
>>> +                        }
>>> +                    }
>>> +                }
>>> +
>>> +                /// Wrapper type for a global lock.
>>> +                pub(crate) struct $wrapper {
>>
>> How can the wrapper struct be `pub(crate)` when the constant might be
>> global `pub`?
>>
>>     error: type `__static_lock_wrapper_INIT` is more private than the it=
em `INIT`
>>        --> rust/kernel/sync/lock/global.rs:206:14
>>         |
>>     206 |               };
>>         |                ^ static `INIT` is reachable at visibility `pub=
`
>>         |
>>
>> The functions should probably just be `pub`.
>=20
> I used to do that, but got some errors about `pub` being unused. I'll
> look into this again.

Maybe the `unreachable_pub` lint can help?

---
Cheers,
Benno


