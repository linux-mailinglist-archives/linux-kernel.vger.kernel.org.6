Return-Path: <linux-kernel+bounces-358816-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EB101998437
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 12:53:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 730651F25270
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 10:53:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 170421C1AD9;
	Thu, 10 Oct 2024 10:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="G2Barmaw"
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A5181C1723
	for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 10:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728557597; cv=none; b=H1wS+Xo79HjApsGpB7RvCyMCSvZu7T6lbB6bjvRLyaI6uHKarw0GTqOEC7lcnnCX4m4UZzGF2is6PrzJ86akFUZQYTxpxz9CkCgay2IsAakaeO8JtDbptGB4Wv1wN4S8l9UHLk1lyDtAXmwpQ98YeucIKKA2aQZ52XEW5tJHP8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728557597; c=relaxed/simple;
	bh=wr4g7WrAaVt4FSNmramjcqwrwexM5YywBWOycd1WeY8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=u/miif8jQ8X8Ba5xk/ZSW9iAAseajBkiaohih1saGntWWZZGi/7FVnrRhH1aVhMv9t7nTx0vK3YfBXpFPwedLJZ52z6l7D8mwVGabHau78kQl4Nl5Rs0RT3CWX96uOaJfIbWFpSGmxz3hrC1QL6gsjtgHJ9kLe2WL+pVkk8f+GA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=G2Barmaw; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-5398996acbeso879024e87.1
        for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 03:53:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728557594; x=1729162394; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PTjiIlIDmkW31NEt7dU34CDwKHTtnQ3rlMBj2piyMko=;
        b=G2BarmawVHrATtIqn5JIWuktlKs3udv4xTMH5JrrJZFlbiUHgPkeMbHjIRs9K75iEW
         OwweNogKkezXu9AEdXDPnzrJTcu+s+9no+DDMDQ8RQSOAd+Dln0ksqvXGQP3JTWIeUG/
         HFV4cTH/KiRrQBe+JsrUu9D6IivQVrh1pIXCt+dXDd0s7SwQPf+Xa4jTSSgMymPIOVvL
         9bXMbFc0IXw5V6Ijt+zJahgkN/F5eudhigsGTgexXjYpD2Qa5sUOfoVp+paVQo8ripFB
         OTyF/RZX/Aqsq3FgO6mExLLw2OvdfvPXDdL8FovZ0aEqJ1MbzjNkd7Sq7QpACic+cIHp
         cStw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728557594; x=1729162394;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PTjiIlIDmkW31NEt7dU34CDwKHTtnQ3rlMBj2piyMko=;
        b=I06XwGmbc3dxwS6mbo9CQN6KynmKX+0YMVuy8xeyduyZRbXY2DjlWjEhnQpjv1u/89
         Yr6/5+i96n2aK/IpPS7LkAxh2ZAnJC8MdtMNEwLrkr1g6XHqYJTU9G+qwjY7D5vFIh0u
         L1PNGlYzde43WoRo9v7/2dsI5q7LGF5ZieRJSAcMdw8XLOpt96z2XMIgr/v1QkCP4xxO
         DtyZk/WUtqXX4VDxLSgrY2zKpTC7ZM3XfYN6QBix8xf/tKJ4+H+DPC1u1hkWU6iVk4iH
         Z6fyXzsxY1g5SW+ytqfDY8CeNMDMkicuKB+bZRNLWuoLIT3Jzt6zjg55X5MAm4cEm24X
         A82g==
X-Forwarded-Encrypted: i=1; AJvYcCVCKC2+VX1z/DHMkJGXL1LbshD0Iktpd+mSJCgLtb5Foc0n/L8llEZNdZJ4VUspp4HPm7f6Au8qwI+lN0g=@vger.kernel.org
X-Gm-Message-State: AOJu0YzfkyDmPfgXbkno82X6WzJHFQza5gWV4lg1YNlWrIXSyE3JbhQH
	uh9RClQ/xAni6dngUQQmTSkEmsH9i1RPXs0oWOEO17C5Xd1aOIR59X/eBxQEOw4y0UOtIsv3ZtV
	s1heITfsFAW8qPCilG6P7i6lBi5KNFh/SQr9c
X-Google-Smtp-Source: AGHT+IHMSK5vZNHeTCpbHkyx4RZBnFDj8afuIKVUzp/n5MwooCpNDogKA0UTCJR9J9QEr/qtTHU3gSe1ObZxoJZ/fAQ=
X-Received: by 2002:a05:6512:1096:b0:535:65ce:e901 with SMTP id
 2adb3069b0e04-539c488cb22mr3749513e87.4.1728557593434; Thu, 10 Oct 2024
 03:53:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240930-static-mutex-v4-1-c59555413127@google.com> <1f688070-66bd-450b-ba5d-b929de64ecf0@proton.me>
In-Reply-To: <1f688070-66bd-450b-ba5d-b929de64ecf0@proton.me>
From: Alice Ryhl <aliceryhl@google.com>
Date: Thu, 10 Oct 2024 12:53:00 +0200
Message-ID: <CAH5fLghsozD0qeTygBM0-WDgXRwtGcsc6B3bT1794QMx3=vSTg@mail.gmail.com>
Subject: Re: [PATCH v4] rust: add global lock support
To: Benno Lossin <benno.lossin@proton.me>
Cc: Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Andreas Hindborg <a.hindborg@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 10, 2024 at 12:39=E2=80=AFPM Benno Lossin <benno.lossin@proton.=
me> wrote:
>
> On 30.09.24 15:11, Alice Ryhl wrote:
> > diff --git a/rust/kernel/sync/lock/global.rs b/rust/kernel/sync/lock/gl=
obal.rs
> > new file mode 100644
> > index 000000000000..fc02fac864f6
> > --- /dev/null
> > +++ b/rust/kernel/sync/lock/global.rs
> > @@ -0,0 +1,260 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +
> > +// Copyright (C) 2024 Google LLC.
> > +
> > +//! Support for defining statics containing locks.
> > +
> > +/// Defines a global lock.
> > +///
> > +/// Supports the following options:
> > +///
> > +/// * `value` specifies the initial value in the global lock.
> > +/// * `wrapper` specifies the name of the wrapper struct.
> > +/// * `guard` specifies the name of the guard type.
> > +/// * `locked_by` specifies the name of the `LockedBy` type.
> > +///
> > +/// # Examples
> > +///
> > +/// A global counter.
> > +///
> > +/// ```
> > +/// # mod ex {
> > +/// # use kernel::prelude::*;
> > +/// kernel::sync::global_lock! {
> > +///     // SAFETY: Initialized in module initializer before first use.
> > +///     static MY_COUNTER: Mutex<u32> =3D unsafe { uninit };
> > +///     value: 0;
> > +/// }
> > +///
> > +/// fn increment_counter() -> u32 {
> > +///     let mut guard =3D MY_COUNTER.lock();
> > +///     *guard +=3D 1;
> > +///     *guard
> > +/// }
> > +///
> > +/// impl kernel::Module for MyModule {
> > +///     fn init(_module: &'static ThisModule) -> Result<Self> {
> > +///         // SAFETY: called exactly once
> > +///         unsafe { MY_COUNTER.init() };
> > +///
> > +///         Ok(MyModule {})
> > +///     }
> > +/// }
> > +/// # struct MyModule {}
> > +/// # }
> > +/// ```
> > +///
> > +/// A global mutex used to protect all instances of a given struct.
> > +///
> > +/// ```
> > +/// # mod ex {
> > +/// # use kernel::prelude::*;
> > +/// kernel::sync::global_lock! {
> > +///     // SAFETY: Initialized in module initializer before first use.
> > +///     static MY_MUTEX: Mutex<()> =3D unsafe { uninit };
> > +///     value: ();
> > +///     guard: MyGuard;
> > +///     locked_by: LockedByMyMutex;
> > +/// }
> > +///
> > +/// /// All instances of this struct are protected by `MY_MUTEX`.
> > +/// struct MyStruct {
> > +///     my_counter: LockedByMyMutex<u32>,
> > +/// }
> > +///
> > +/// impl MyStruct {
> > +///     /// Increment the counter in this instance.
> > +///     ///
> > +///     /// The caller must hold the `MY_MUTEX` mutex.
> > +///     fn increment(&self, guard: &mut MyGuard) -> u32 {
> > +///         let my_counter =3D self.my_counter.as_mut(guard);
> > +///         *my_counter +=3D 1;
> > +///         *my_counter
> > +///     }
> > +/// }
> > +///
> > +/// impl kernel::Module for MyModule {
> > +///     fn init(_module: &'static ThisModule) -> Result<Self> {
> > +///         // SAFETY: called exactly once
> > +///         unsafe { MY_MUTEX.init() };
> > +///
> > +///         Ok(MyModule {})
> > +///     }
> > +/// }
> > +/// # struct MyModule {}
> > +/// # }
> > +/// ```
>
> The docs here don't mention that you still need to call `.init()`
> manually (though the examples show it nicely). I don't know if we want
> macros to have a `# Safety` section.
>
> > +#[macro_export]
> > +macro_rules! global_lock {
> > +    {
> > +        $(#[$meta:meta])* $pub:vis static $name:ident: $kind:ident<$va=
luety:ty> =3D unsafe { uninit };
> > +        value: $value:expr;
>
> I would find it more natural to use `=3D` instead of `:` here, since then
> it would read as a normal statement with the semicolon at the end.
> Another alternative would be to use `,` instead of `;`, but that doesn't
> work nicely with the static keyword above (although you could make the
> user write it in another {}, but that also isn't ideal...).
>
> Using `=3D` instead of `:` makes my editor put the correct amount of
> indentation there, `:` adds a lot of extra spaces.

That seems sensible.

> > +        wrapper: $wrapper:ident;
> > +        $( name: $lname:literal; )?
> > +        $(
> > +            guard: $guard:ident;
> > +            locked_by: $locked_by:ident;
> > +        )?
> > +    } =3D> {
> > +        $crate::macros::paste! {
> > +            type [< __static_lock_ty_ $name >] =3D $valuety;
> > +            const [< __static_lock_init_ $name >]: [< __static_lock_ty=
_ $name >] =3D $value;
>
> Why are these two items outside of the `mod` below?
> Also why do you need to define the type alias? You could just use
> `$valuety`, right?

Because they might access things that are in scope here, but not in
scope inside the module.

> Also,
>
>     error: type `__static_lock_ty_VALUE` should have an upper camel case =
name
>        --> rust/kernel/sync/lock/global.rs:100:18
>         |
>     100 |               type [< __static_lock_ty_ $name >] =3D $valuety;
>         |                    ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ help: convert =
the identifier to upper camel case: `StaticLockTyValue`
>
> The same error affects the `wrapper` type forwarding below.
>
>
> > +
> > +            #[allow(unused_pub)]
>
>     error: unknown lint: `unused_pub`
>        --> rust/kernel/sync/lock/global.rs:103:21
>         |
>     103 |               #[allow(unused_pub)]
>         |                       ^^^^^^^^^^ help: did you mean: `unused_mu=
t`

Uhhh. This is the lint for when you mark a function pub but don't
actually export it from the crate. But now I can't find the lint
anywhere ... I'm so confused.

> Though I also get
>
>     error: methods `init` and `lock` are never used
>        --> rust/kernel/sync/lock/global.rs:128:42
>         |
>     122 | /                 impl $wrapper {
>     123 | |                     /// Initialize the global lock.
>     124 | |                     ///
>     125 | |                     /// # Safety
>     ...   |
>     128 | |                     pub(crate) unsafe fn init(&'static self) =
{
>         | |                                          ^^^^
>     ...   |
>     142 | |                     pub(crate) fn lock(&'static self) -> $cra=
te::global_lock_inner!(guard $kind, $valuety $(, $guard)?) {
>         | |                                   ^^^^
>     ...   |
>     146 | |                     }
>     147 | |                 }
>         | |_________________- methods in this implementation
>
> But that is governed by the `dead_code` lint.

I guess I have to look into the lints again. I did not get this lint.

> > +            mod [< __static_lock_mod_ $name >] {
> > +                use super::[< __static_lock_ty_ $name >] as Val;
> > +                use super::[< __static_lock_init_ $name >] as INIT;
> > +                type Backend =3D $crate::global_lock_inner!(backend $k=
ind);
> > +                type GuardTyp =3D $crate::global_lock_inner!(guard $ki=
nd, Val $(, $guard)?);
>
> `GuardTyp` is only used once, so you should be able to just inline it.
> `Backend` is used twice, but I don't know if we need a type alias for
> it.

They're both used twice. Inlining them makes the lines really long.

> > +
> > +                /// # Safety
> > +                ///
> > +                /// Must be used to initialize `super::$name`.
> > +                pub(super) const unsafe fn new() -> $wrapper {
>
> Why is this function not associated to `$wrapper`?
>
> > +                    let state =3D $crate::types::Opaque::uninit();
>
> Why not add
>
>     const INIT: $valuety =3D $value;
>
> here instead of outside the mod.

Because it might reference things that are only in scope outside of the mod=
ule.

> > +                    $wrapper {
> > +                        // SAFETY: The user of this macro promises to =
call `init` before calling
> > +                        // `lock`.
> > +                        inner: unsafe {
> > +                            $crate::sync::lock::Lock::global_lock_help=
er_new(state, INIT)
> > +                        }
> > +                    }
> > +                }
> > +
> > +                /// Wrapper type for a global lock.
> > +                pub(crate) struct $wrapper {
>
> How can the wrapper struct be `pub(crate)` when the constant might be
> global `pub`?
>
>     error: type `__static_lock_wrapper_INIT` is more private than the ite=
m `INIT`
>        --> rust/kernel/sync/lock/global.rs:206:14
>         |
>     206 |               };
>         |                ^ static `INIT` is reachable at visibility `pub`
>         |
>
> The functions should probably just be `pub`.

I used to do that, but got some errors about `pub` being unused. I'll
look into this again.

Alice

