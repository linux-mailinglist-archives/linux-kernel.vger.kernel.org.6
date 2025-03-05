Return-Path: <linux-kernel+bounces-547116-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0795FA5032B
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 16:08:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9A2191885D5B
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 15:05:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C42D124EF93;
	Wed,  5 Mar 2025 15:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=proton.me header.i=@proton.me header.b="YA14R8F1"
Received: from mail-10631.protonmail.ch (mail-10631.protonmail.ch [79.135.106.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3696C24EF7A
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 15:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.31
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741187137; cv=none; b=Ve49pJt5ofNES/gzSY5b6Esuv41dnsx1YqU+dOB1Q0u1TPpgbzjJO2+gjgCLlxgHtjx6jeJFOApV5iot3eiSJQkqj14pp/QNN4x/fgjY3Q8tvqGKS10dMCEujWEJODBUUvuXXdGnn5D5zuucMTZLEbl5NiUUzwpgJj1MSxtC9r8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741187137; c=relaxed/simple;
	bh=8RvW8PLSR9hlKJzKdN6TL1CqNsKjMatfYVskUYC14Z4=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SnHHVrirdbYT/UDIsaCwkh/6FM6qJkhNC3rrrzOvBgxQJJ0C6MEmwRoAcxDGfN78oj4PsYXeIgQ2zrdPvTFM3zbH7/Rry4q33jjH9m7uaOcgrGPUcQ82+bZ70c4XYEkvn638JrAHx4rxDDwgsegen5dLsyO/JM0JdWdDB8cdjZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=YA14R8F1; arc=none smtp.client-ip=79.135.106.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1741187132; x=1741446332;
	bh=fJj90wwgiBZuVeTeFzRJ0Mi4XzEcPosSwZ3Yr3bpaWA=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=YA14R8F1J9MEFzelKBDYrO/sA0S35YwKvS7JMBVBn7njG/tUhnOpw4dKlYmdmmlcR
	 rHDbqYMkLiil5zqB4SckpgF2ppSuPV9Y5H7d9zuKnie8u/L1srffKyzpPuv56ZzkBZ
	 EKPTezlL7xSDy6vVcjBb9ERD48C1sOwgrGk39vbhJqxIv8Og2Lr+bdoYt7Wsj6YVGi
	 Ixm2lvTnbZ/6xST1TnXuNyLh2O/rwXVw4x6wTMnRuVlYUiyvVW+gnXDmW+5KTAYu63
	 DFKAJii/4cKNKsxI4+0aLrVWldaaA70fUW2MIp+vGCfhn8bUPCNnvwyxaZucLL7yPR
	 48R90JWfgiOLA==
Date: Wed, 05 Mar 2025 15:05:28 +0000
To: Andreas Hindborg <a.hindborg@kernel.org>
From: Benno Lossin <benno.lossin@proton.me>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org
Subject: Re: [PATCH 16/22] rust: pin-init: add `std` and `alloc` support from the user-space version
Message-ID: <D88FBMCD9J1Z.1SMOBNLK6G6UH@proton.me>
In-Reply-To: <87wmd38sb2.fsf@kernel.org>
References: <20250304225245.2033120-1-benno.lossin@proton.me> <qEIYcaF5eMmpiaRI_4rpApjyuiQMjms1LdZhmHXO5l9_HqN32upj8ZVbCnvI3hfDDTJeYT_9N7z3kyvOR-whRg==@protonmail.internalid> <20250304225245.2033120-17-benno.lossin@proton.me> <8734frd5v6.fsf@kernel.org> <cfBHbY6fYqucI2hjDXGCsolI6TkEE4AY7gT8hW-0z0P7BvaCe6dBzLpH9IFHRl5HgrPiBo8rMKGRWlP9M7x85A==@protonmail.internalid> <D88DTO6ZIXMN.26SWTE440RP9K@proton.me> <87wmd38sb2.fsf@kernel.org>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: d91415b88143040a76c6f62f0c173e5d7bd54616
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Wed Mar 5, 2025 at 3:29 PM CET, Andreas Hindborg wrote:
> "Benno Lossin" <benno.lossin@proton.me> writes:
>> On Wed Mar 5, 2025 at 1:22 PM CET, Andreas Hindborg wrote:
>>> "Benno Lossin" <benno.lossin@proton.me> writes:
>>>> To synchronize the kernel's version of pin-init with the user-space
>>>> version, introduce support for `std` and `alloc`. While the kernel use=
s
>>>> neither, the user-space version has to support both. Thus include the
>>>> required `#[cfg]`s and additional code.
>>>>
>>>> Signed-off-by: Benno Lossin <benno.lossin@proton.me>
>>>> ---
>>>>  rust/pin-init/src/__internal.rs |  27 ++++++
>>>>  rust/pin-init/src/alloc.rs      | 158 +++++++++++++++++++++++++++++++=
+
>>>>  rust/pin-init/src/lib.rs        |  17 ++--
>>>>  3 files changed, 196 insertions(+), 6 deletions(-)
>>>>  create mode 100644 rust/pin-init/src/alloc.rs
>>>>
>>>> diff --git a/rust/pin-init/src/__internal.rs b/rust/pin-init/src/__int=
ernal.rs
>>>> index 74086365a18a..27d4a8619c04 100644
>>>> --- a/rust/pin-init/src/__internal.rs
>>>> +++ b/rust/pin-init/src/__internal.rs
>>>> @@ -186,6 +186,33 @@ pub fn init<E>(self: Pin<&mut Self>, init: impl P=
inInit<T, E>) -> Result<Pin<&mu
>>>>      }
>>>>  }
>>>>
>>>> +#[test]
>>>
>>> I think the kunit support we have in the pipeline will pick this up?
>>
>> Is that support also enabled for crates outside of the `kernel` crate?
>> I would argue it shouldn't and then this isn't a problem.
>
> Re conversation about moving pin_init out of the kernel, we should
> distinguish between vendored crates and crates that is part of the
> kernel. This one is now vendored and tests are not meant to be run by
> the kernel build system and infrastructure. Other crates will be
> different, living in the kernel.

Yes, but I wouldn't necessarily call this category "vendored"; e.g. we
could write a crate that is kernel-only, but doesn't actually have any
code that requires kernel infrastructure. How about we call these
kernel-agnostic crates? :)

>>>> +fn stack_init_reuse() {
>>>> +    use ::std::{borrow::ToOwned, println, string::String};
>>>> +    use core::pin::pin;
>>>> +
>>>> +    #[derive(Debug)]
>>>> +    struct Foo {
>>>> +        a: usize,
>>>> +        b: String,
>>>> +    }
>>>> +    let mut slot: Pin<&mut StackInit<Foo>> =3D pin!(StackInit::uninit=
());
>>>> +    let value: Result<Pin<&mut Foo>, core::convert::Infallible> =3D
>>>> +        slot.as_mut().init(crate::init!(Foo {
>>>> +            a: 42,
>>>> +            b: "Hello".to_owned(),
>>>> +        }));
>>>> +    let value =3D value.unwrap();
>>>> +    println!("{value:?}");
>>>> +    let value: Result<Pin<&mut Foo>, core::convert::Infallible> =3D
>>>> +        slot.as_mut().init(crate::init!(Foo {
>>>> +            a: 24,
>>>> +            b: "world!".to_owned(),
>>>> +        }));
>>>> +    let value =3D value.unwrap();
>>>> +    println!("{value:?}");
>>>> +}
>>>> +
>>>
>>> [...]
>>>
>>>> diff --git a/rust/pin-init/src/lib.rs b/rust/pin-init/src/lib.rs
>>>> index 55d8953620f0..1fdca35906a0 100644
>>>> --- a/rust/pin-init/src/lib.rs
>>>> +++ b/rust/pin-init/src/lib.rs
>>>> @@ -204,8 +204,8 @@
>>>>  //! [structurally pinned fields]:
>>>>  //!     https://doc.rust-lang.org/std/pin/index.html#pinning-is-struc=
tural-for-field
>>>>  //! [stack]: crate::stack_pin_init
>>>> -//! [`Arc<T>`]: ../kernel/sync/struct.Arc.html
>>>> -//! [`Box<T>`]: ../kernel/alloc/struct.KBox.html
>>>> +//! [`Arc<T>`]: https://doc.rust-lang.org/stable/alloc/sync/struct.Ar=
c.html
>>>> +//! [`Box<T>`]: https://doc.rust-lang.org/stable/alloc/boxed/struct.B=
ox.html
>>>
>>> Now these will render incorrect in the kernel docs, right?
>>
>> What do you mean by that? The link will resolve to the std versions of
>> `Arc` and `Box`. But that is also what this crate will support, as it
>> doesn't know about the kernel's own alloc.
>
> I mean that if I render the kernel documentation, go to `pin_init` and
> click the `Arc<T>` link, I end up in `std`. But I am in the kernel, so
> not what I would expect.
>
> But I guess there is no easy solution? Being a kernel developer, I would
> prefer a kernel first approach. Can't have it all, I guess.

I could change the link depending on the `kernel` cfg, so

    #![cfg_attr(kernel, doc =3D "[`Arc<T>`]: https://rust.docs.kernel.org..=
.")]
    #![cfg_attr(not(kernel), doc =3D "[`Arc<T>`]: https://doc.rust-lang.org=
...")]

But if anyone visits the documentation on `docs.rs`, then they will get
the user-space one... What do you think?

>>>>  //! [`impl PinInit<Foo>`]: PinInit
>>>>  //! [`impl PinInit<T, E>`]: PinInit
>>>>  //! [`impl Init<T, E>`]: Init
>>>> @@ -239,6 +239,11 @@
>>>>  #[doc(hidden)]
>>>>  pub mod macros;
>>>>
>>>> +#[cfg(any(feature =3D "std", feature =3D "alloc"))]
>>>> +mod alloc;
>>>> +#[cfg(any(feature =3D "std", feature =3D "alloc"))]
>>>> +pub use alloc::InPlaceInit;
>>>
>>> Do we really need to have this entire file sitting dead in the kernel
>>> tree? If you are not building the user space version from the kernel
>>> sources, I don't think we need it here. Even when you want to sync
>>> between the two repositories, it should be easy to handle an entire fil=
e
>>> being not present on one side.
>>
>> I do have a script that does the commit porting, you can find it at [1].
>> So I could easily add that file there. However, I think it also is
>> important that it's easy to remember which files are synchronized and
>> which files aren't. At the moment it's very simple, the synchronized
>> files are:
>> - README.md
>> - CONTRIBUTING.md
>> - src/*
>> - internal/src/*
>> - examples/*
>>
>> If I introduce special cases for files in src, I fear that I might get
>> confused at some point, making a change that shouldn't be done etc.
>>
>> I understand your worry about the dead file, but at the same time, I
>> think it's vital to keep the pattern of synchronized files as simple as
>> possible.
>
> I don't agree about this one - but I am not the one that has to do the
> work. I would prefer we don't keep dead user space code in the kernel
> tree, and I would ask that you consider if you can find a solution for
> that which works for you. If not, I will live with the dead code.

I will see if I can come up with a solution.

---
Cheers,
Benno


