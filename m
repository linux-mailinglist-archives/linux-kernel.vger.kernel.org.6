Return-Path: <linux-kernel+bounces-547369-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 15404A50651
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 18:27:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3DDF817161D
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 17:27:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DFB42512ED;
	Wed,  5 Mar 2025 17:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OfFEt9AA"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A922F24CEDF;
	Wed,  5 Mar 2025 17:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741195635; cv=none; b=PQwO2En5arLDCEs8EBcgeatsz69rYBSlWj/U+GFDuyV1InfWW7vxu5joHfe4Ls1KVoAhcl57r/lLueOEan5typgXUsLC0YpOvGJucHQ5F9jUm0O/7Lb+n8ixFLXdwwGeghJ1Vxmzvp/Aj/lxQZiXQ1s3OOTKohlVvvMs0c0dpO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741195635; c=relaxed/simple;
	bh=vLkceGu5hYKNQITI1o+vScaHt0sK/onC6UV0cg6UPKM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Hm5e9cKzMjAiYW+hmF/Rg+8h/KAc3N0bH5QXhsGLKD/jVBmXARNDLS56MJB3p/9tHev9ad7ni5bjDze5devnp0bHryLiav1q9nnINjVtnxrWaFTupVXC5yEzW7j1DiOo447ifuH+j1n04aGxgciUtrPZ7q8Od+/PK9GhxPlR5qw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OfFEt9AA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6233C4CED1;
	Wed,  5 Mar 2025 17:27:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741195635;
	bh=vLkceGu5hYKNQITI1o+vScaHt0sK/onC6UV0cg6UPKM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=OfFEt9AAPmZdN36nVnNR/RqRXaui/Bqc1EgsqKT9FEX3hUArvsa3fX8Zt7uh8IZJk
	 tq3ZQOVFvv/iwI1Vmgg0+ZiVAkoKvxMZYB0byK8igmci42shWzl2hmMiUOFVk7z2VO
	 Q/1G4SHBABdeMdqBCPSstBtLYHrbkc+0rPxDnIXN4d+c0KiwCD89nridrttlOStPJs
	 04kqMSRKSTy4lSaMDhP+QE3oxKgH/s004jM8hJ/brpO8QntUfGHFIHZ9slxNIS0vkG
	 abPV+YcjF0i+0EGmR6G9NiX9IQJRxqQ4cpaqGIl5lt3E2FZFvK43BGRRUSNcv5g75z
	 gyXDeV496MsaQ==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: "Benno Lossin" <benno.lossin@proton.me>
Cc: "Miguel Ojeda" <ojeda@kernel.org>,  "Alex Gaynor"
 <alex.gaynor@gmail.com>,  "Boqun Feng" <boqun.feng@gmail.com>,  "Gary Guo"
 <gary@garyguo.net>,  =?utf-8?Q?Bj=C3=B6rn?= Roy Baron
 <bjorn3_gh@protonmail.com>,  "Alice
 Ryhl" <aliceryhl@google.com>,  "Trevor Gross" <tmgross@umich.edu>,
  "Danilo Krummrich" <dakr@kernel.org>,  <linux-kernel@vger.kernel.org>,
  <rust-for-linux@vger.kernel.org>
Subject: Re: [PATCH 16/22] rust: pin-init: add `std` and `alloc` support
 from the user-space version
In-Reply-To: <D88FBMCD9J1Z.1SMOBNLK6G6UH@proton.me> (Benno Lossin's message of
	"Wed, 05 Mar 2025 15:05:28 +0000")
References: <20250304225245.2033120-1-benno.lossin@proton.me>
	<qEIYcaF5eMmpiaRI_4rpApjyuiQMjms1LdZhmHXO5l9_HqN32upj8ZVbCnvI3hfDDTJeYT_9N7z3kyvOR-whRg==@protonmail.internalid>
	<20250304225245.2033120-17-benno.lossin@proton.me>
	<8734frd5v6.fsf@kernel.org>
	<cfBHbY6fYqucI2hjDXGCsolI6TkEE4AY7gT8hW-0z0P7BvaCe6dBzLpH9IFHRl5HgrPiBo8rMKGRWlP9M7x85A==@protonmail.internalid>
	<D88DTO6ZIXMN.26SWTE440RP9K@proton.me> <87wmd38sb2.fsf@kernel.org>
	<M3hCr1lA6T2tY1uelvZpw6KGYb7MDZo7T4id-iMIFbo5vV2RF2qYj5iKyFC7k-GfL7YDcciSYh86eIckphVYVQ==@protonmail.internalid>
	<D88FBMCD9J1Z.1SMOBNLK6G6UH@proton.me>
User-Agent: mu4e 1.12.7; emacs 29.4
Date: Wed, 05 Mar 2025 18:27:08 +0100
Message-ID: <871pvb8k2b.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

"Benno Lossin" <benno.lossin@proton.me> writes:

> On Wed Mar 5, 2025 at 3:29 PM CET, Andreas Hindborg wrote:
>> "Benno Lossin" <benno.lossin@proton.me> writes:
>>> On Wed Mar 5, 2025 at 1:22 PM CET, Andreas Hindborg wrote:
>>>> "Benno Lossin" <benno.lossin@proton.me> writes:
>>>>> To synchronize the kernel's version of pin-init with the user-space
>>>>> version, introduce support for `std` and `alloc`. While the kernel us=
es
>>>>> neither, the user-space version has to support both. Thus include the
>>>>> required `#[cfg]`s and additional code.
>>>>>
>>>>> Signed-off-by: Benno Lossin <benno.lossin@proton.me>
>>>>> ---
>>>>>  rust/pin-init/src/__internal.rs |  27 ++++++
>>>>>  rust/pin-init/src/alloc.rs      | 158 ++++++++++++++++++++++++++++++=
++
>>>>>  rust/pin-init/src/lib.rs        |  17 ++--
>>>>>  3 files changed, 196 insertions(+), 6 deletions(-)
>>>>>  create mode 100644 rust/pin-init/src/alloc.rs
>>>>>
>>>>> diff --git a/rust/pin-init/src/__internal.rs b/rust/pin-init/src/__in=
ternal.rs
>>>>> index 74086365a18a..27d4a8619c04 100644
>>>>> --- a/rust/pin-init/src/__internal.rs
>>>>> +++ b/rust/pin-init/src/__internal.rs
>>>>> @@ -186,6 +186,33 @@ pub fn init<E>(self: Pin<&mut Self>, init: impl =
PinInit<T, E>) -> Result<Pin<&mu
>>>>>      }
>>>>>  }
>>>>>
>>>>> +#[test]
>>>>
>>>> I think the kunit support we have in the pipeline will pick this up?
>>>
>>> Is that support also enabled for crates outside of the `kernel` crate?
>>> I would argue it shouldn't and then this isn't a problem.
>>
>> Re conversation about moving pin_init out of the kernel, we should
>> distinguish between vendored crates and crates that is part of the
>> kernel. This one is now vendored and tests are not meant to be run by
>> the kernel build system and infrastructure. Other crates will be
>> different, living in the kernel.
>
> Yes, but I wouldn't necessarily call this category "vendored"; e.g. we
> could write a crate that is kernel-only, but doesn't actually have any
> code that requires kernel infrastructure. How about we call these
> kernel-agnostic crates? :)

Sounds good to me =F0=9F=91=8D

>
>>>>> +fn stack_init_reuse() {
>>>>> +    use ::std::{borrow::ToOwned, println, string::String};
>>>>> +    use core::pin::pin;
>>>>> +
>>>>> +    #[derive(Debug)]
>>>>> +    struct Foo {
>>>>> +        a: usize,
>>>>> +        b: String,
>>>>> +    }
>>>>> +    let mut slot: Pin<&mut StackInit<Foo>> =3D pin!(StackInit::unini=
t());
>>>>> +    let value: Result<Pin<&mut Foo>, core::convert::Infallible> =3D
>>>>> +        slot.as_mut().init(crate::init!(Foo {
>>>>> +            a: 42,
>>>>> +            b: "Hello".to_owned(),
>>>>> +        }));
>>>>> +    let value =3D value.unwrap();
>>>>> +    println!("{value:?}");
>>>>> +    let value: Result<Pin<&mut Foo>, core::convert::Infallible> =3D
>>>>> +        slot.as_mut().init(crate::init!(Foo {
>>>>> +            a: 24,
>>>>> +            b: "world!".to_owned(),
>>>>> +        }));
>>>>> +    let value =3D value.unwrap();
>>>>> +    println!("{value:?}");
>>>>> +}
>>>>> +
>>>>
>>>> [...]
>>>>
>>>>> diff --git a/rust/pin-init/src/lib.rs b/rust/pin-init/src/lib.rs
>>>>> index 55d8953620f0..1fdca35906a0 100644
>>>>> --- a/rust/pin-init/src/lib.rs
>>>>> +++ b/rust/pin-init/src/lib.rs
>>>>> @@ -204,8 +204,8 @@
>>>>>  //! [structurally pinned fields]:
>>>>>  //!     https://doc.rust-lang.org/std/pin/index.html#pinning-is-stru=
ctural-for-field
>>>>>  //! [stack]: crate::stack_pin_init
>>>>> -//! [`Arc<T>`]: ../kernel/sync/struct.Arc.html
>>>>> -//! [`Box<T>`]: ../kernel/alloc/struct.KBox.html
>>>>> +//! [`Arc<T>`]: https://doc.rust-lang.org/stable/alloc/sync/struct.A=
rc.html
>>>>> +//! [`Box<T>`]: https://doc.rust-lang.org/stable/alloc/boxed/struct.=
Box.html
>>>>
>>>> Now these will render incorrect in the kernel docs, right?
>>>
>>> What do you mean by that? The link will resolve to the std versions of
>>> `Arc` and `Box`. But that is also what this crate will support, as it
>>> doesn't know about the kernel's own alloc.
>>
>> I mean that if I render the kernel documentation, go to `pin_init` and
>> click the `Arc<T>` link, I end up in `std`. But I am in the kernel, so
>> not what I would expect.
>>
>> But I guess there is no easy solution? Being a kernel developer, I would
>> prefer a kernel first approach. Can't have it all, I guess.
>
> I could change the link depending on the `kernel` cfg, so
>
>     #![cfg_attr(kernel, doc =3D "[`Arc<T>`]: https://rust.docs.kernel.org=
..")]
>     #![cfg_attr(not(kernel), doc =3D "[`Arc<T>`]: https://doc.rust-lang.o=
rg...")]
>
> But if anyone visits the documentation on `docs.rs`, then they will get
> the user-space one... What do you think?

That would be nice. I think kernel developers would read the docs via
rust.docs.kernel.org, if they read them online (myself being my only
reference, so not enough sample size).


Best regards,
Andreas Hindborg



