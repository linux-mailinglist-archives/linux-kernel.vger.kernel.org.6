Return-Path: <linux-kernel+bounces-546955-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 43EEDA5011E
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 14:55:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3488F16B90B
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 13:55:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A024424886C;
	Wed,  5 Mar 2025 13:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=proton.me header.i=@proton.me header.b="APkCaIdc"
Received: from mail-40133.protonmail.ch (mail-40133.protonmail.ch [185.70.40.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4312243955
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 13:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741182914; cv=none; b=UFFpI9Cq/Y2mtYk7K5uIeb+qhOFUjt7YiZxj6YP6rsjCzzCu8ugZcvZ6oJ53VwrYwObtHHKTtBq4st/lHEYiiMpsQSxCbLMUMOq4TsN44FSAmYo3ZMW7G4DYiXt/fYZIcMUWlrd8siolQRATPZuyJpkeA4BQzrZfxCrdWWVHAJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741182914; c=relaxed/simple;
	bh=lxn/ISYLtLolpUg3cD1NNu0tzs5f5F6c3XgSUA+EVnI=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tKaNZOzZ7pfljFVVqXNUQMUWRAn2YYBvKXUz5vhuJzhkT2fBMmD0/0ONAbiwoB5sKuqIDHP9N9KL/dakWx265oRaJgteOFKUi1FlJREixPRQxNe/dmuzKRa1TmvIFyL5mTvvL/3keb93uHfFLwd0J76mn2GrQ6P2s2BuOYeaNU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=APkCaIdc; arc=none smtp.client-ip=185.70.40.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1741182910; x=1741442110;
	bh=9I2t8Jen9Sp/023mOypECwCKp+A0wRlfzVIzsvmaau4=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=APkCaIdcU843vEtDvd9gTzgTOr6ZQuq48GLkAUILiXsFA7Jh7wfgftRU/ineiHXvP
	 BCUrfoOrMfJ75lUpSP0VilwMqOUrZHuNShBS/8CA88E+mNT9HMKWTZfsJ5up93lT0n
	 mLXSNBUGmC3zWRLCPY6BbFVArA+dfveCI//FXFdxWQqm0QRhu7/wFvJW7tNYjSo9Dd
	 A5WDK6Tbo6Wd7+P+t7Q0TOBesK4E+FxFHPftySnDWaQjKNsahE21cx9vx8a1Qq2lb3
	 bvxdGeXtZ0Cw1/c3pNfZ+saaDdKvGuGBBLh/uvUdM5nZxWqj3NZ/HgZuIIbKYNjm0A
	 ZL789plEoiIuQ==
Date: Wed, 05 Mar 2025 13:55:03 +0000
To: Andreas Hindborg <a.hindborg@kernel.org>
From: Benno Lossin <benno.lossin@proton.me>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org
Subject: Re: [PATCH 16/22] rust: pin-init: add `std` and `alloc` support from the user-space version
Message-ID: <D88DTO6ZIXMN.26SWTE440RP9K@proton.me>
In-Reply-To: <8734frd5v6.fsf@kernel.org>
References: <20250304225245.2033120-1-benno.lossin@proton.me> <qEIYcaF5eMmpiaRI_4rpApjyuiQMjms1LdZhmHXO5l9_HqN32upj8ZVbCnvI3hfDDTJeYT_9N7z3kyvOR-whRg==@protonmail.internalid> <20250304225245.2033120-17-benno.lossin@proton.me> <8734frd5v6.fsf@kernel.org>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: 2482b951e84ad25537860ad8dffc2fa0918366c0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Wed Mar 5, 2025 at 1:22 PM CET, Andreas Hindborg wrote:
> "Benno Lossin" <benno.lossin@proton.me> writes:
>
>> To synchronize the kernel's version of pin-init with the user-space
>> version, introduce support for `std` and `alloc`. While the kernel uses
>> neither, the user-space version has to support both. Thus include the
>> required `#[cfg]`s and additional code.
>>
>> Signed-off-by: Benno Lossin <benno.lossin@proton.me>
>> ---
>>  rust/pin-init/src/__internal.rs |  27 ++++++
>>  rust/pin-init/src/alloc.rs      | 158 ++++++++++++++++++++++++++++++++
>>  rust/pin-init/src/lib.rs        |  17 ++--
>>  3 files changed, 196 insertions(+), 6 deletions(-)
>>  create mode 100644 rust/pin-init/src/alloc.rs
>>
>> diff --git a/rust/pin-init/src/__internal.rs b/rust/pin-init/src/__inter=
nal.rs
>> index 74086365a18a..27d4a8619c04 100644
>> --- a/rust/pin-init/src/__internal.rs
>> +++ b/rust/pin-init/src/__internal.rs
>> @@ -186,6 +186,33 @@ pub fn init<E>(self: Pin<&mut Self>, init: impl Pin=
Init<T, E>) -> Result<Pin<&mu
>>      }
>>  }
>>
>> +#[test]
>
> I think the kunit support we have in the pipeline will pick this up?

Is that support also enabled for crates outside of the `kernel` crate?
I would argue it shouldn't and then this isn't a problem.

>> +fn stack_init_reuse() {
>> +    use ::std::{borrow::ToOwned, println, string::String};
>> +    use core::pin::pin;
>> +
>> +    #[derive(Debug)]
>> +    struct Foo {
>> +        a: usize,
>> +        b: String,
>> +    }
>> +    let mut slot: Pin<&mut StackInit<Foo>> =3D pin!(StackInit::uninit()=
);
>> +    let value: Result<Pin<&mut Foo>, core::convert::Infallible> =3D
>> +        slot.as_mut().init(crate::init!(Foo {
>> +            a: 42,
>> +            b: "Hello".to_owned(),
>> +        }));
>> +    let value =3D value.unwrap();
>> +    println!("{value:?}");
>> +    let value: Result<Pin<&mut Foo>, core::convert::Infallible> =3D
>> +        slot.as_mut().init(crate::init!(Foo {
>> +            a: 24,
>> +            b: "world!".to_owned(),
>> +        }));
>> +    let value =3D value.unwrap();
>> +    println!("{value:?}");
>> +}
>> +
>
> [...]
>
>> diff --git a/rust/pin-init/src/lib.rs b/rust/pin-init/src/lib.rs
>> index 55d8953620f0..1fdca35906a0 100644
>> --- a/rust/pin-init/src/lib.rs
>> +++ b/rust/pin-init/src/lib.rs
>> @@ -204,8 +204,8 @@
>>  //! [structurally pinned fields]:
>>  //!     https://doc.rust-lang.org/std/pin/index.html#pinning-is-structu=
ral-for-field
>>  //! [stack]: crate::stack_pin_init
>> -//! [`Arc<T>`]: ../kernel/sync/struct.Arc.html
>> -//! [`Box<T>`]: ../kernel/alloc/struct.KBox.html
>> +//! [`Arc<T>`]: https://doc.rust-lang.org/stable/alloc/sync/struct.Arc.=
html
>> +//! [`Box<T>`]: https://doc.rust-lang.org/stable/alloc/boxed/struct.Box=
.html
>
> Now these will render incorrect in the kernel docs, right?

What do you mean by that? The link will resolve to the std versions of
`Arc` and `Box`. But that is also what this crate will support, as it
doesn't know about the kernel's own alloc.

>>  //! [`impl PinInit<Foo>`]: PinInit
>>  //! [`impl PinInit<T, E>`]: PinInit
>>  //! [`impl Init<T, E>`]: Init
>> @@ -239,6 +239,11 @@
>>  #[doc(hidden)]
>>  pub mod macros;
>>
>> +#[cfg(any(feature =3D "std", feature =3D "alloc"))]
>> +mod alloc;
>> +#[cfg(any(feature =3D "std", feature =3D "alloc"))]
>> +pub use alloc::InPlaceInit;
>
> Do we really need to have this entire file sitting dead in the kernel
> tree? If you are not building the user space version from the kernel
> sources, I don't think we need it here. Even when you want to sync
> between the two repositories, it should be easy to handle an entire file
> being not present on one side.

I do have a script that does the commit porting, you can find it at [1].
So I could easily add that file there. However, I think it also is
important that it's easy to remember which files are synchronized and
which files aren't. At the moment it's very simple, the synchronized
files are:
- README.md
- CONTRIBUTING.md
- src/*
- internal/src/*
- examples/*

If I introduce special cases for files in src, I fear that I might get
confused at some point, making a change that shouldn't be done etc.

I understand your worry about the dead file, but at the same time, I
think it's vital to keep the pattern of synchronized files as simple as
possible.

[1]: https://github.com/Rust-for-Linux/pin-init/commit/7eda8fda7cb48883511d=
b4b5f4fff8d574eef25a

---
Cheers,
Benno


