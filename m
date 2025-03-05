Return-Path: <linux-kernel+bounces-547031-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C2062A501F2
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 15:29:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 35AAA7A6587
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 14:28:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AC4324C094;
	Wed,  5 Mar 2025 14:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pHJo0CdC"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 977D1248885;
	Wed,  5 Mar 2025 14:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741184957; cv=none; b=hJNpjxxOXLZybOlgNT4DWtjdIi91oTbXEim4YaNoWvzB2px1AJSPzORod8lfIlFjZFC+7U78PE4pOo/PzM+cXHbg0w9LzuA73rBKATcET/9T295Bu4rU0Hwlqm4OkJhrbfLcRAdny+2PbcptJSlqey8needanzuhLbMELa0hPu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741184957; c=relaxed/simple;
	bh=JcJd3AqdUS4XqV6T35zyrr6dnBW/DcHSWA376S/EZyY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=GvIajcZUX+gk3zmclEJ3rB39FA5M7OSQhZ2JPExNMswROt4aYgIiZL/RgYrVVlHmmw/7A9ZiusgAz8Z0Q6VvUCZdyNIbkzj/L4tb3/kbuiMsspUr0Py05B6d9WZfyibf/HnA7zoGNd4wQmv3s5i+NucDlvBta7/jaoSM1pD+xJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pHJo0CdC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FD92C4CED1;
	Wed,  5 Mar 2025 14:29:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741184957;
	bh=JcJd3AqdUS4XqV6T35zyrr6dnBW/DcHSWA376S/EZyY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=pHJo0CdCFrLgDity4W0mVKdlme6qs3ygkfL0p1UpDLMJgxDIQuSYSHCksunwjsu2i
	 OghybJ5zG2YW7x2wG73E3bqdPE6BKt1mtHECo09+K00Q14smjIZtzAYogAjt5+fUZ1
	 usE+L5cgEhIFFs/JEmKaWxTb4DxY3FA/SiGjhtbPVWc5OLoQLYP43w21YTedh+uv7E
	 QJ7sls42o/0FOMl6Z4vm7kf326/fWIjSpaZGO9j4T3fSAcHLK80c3W6qMA/xX8ssWV
	 E/7O8flXO2F4T7ssamELTTLD/sTSm7PERn17ayAzhKIiJ2VV5RVDUX5wyVV3u6Y6rm
	 SMcXJHoAkpJqQ==
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
In-Reply-To: <D88DTO6ZIXMN.26SWTE440RP9K@proton.me> (Benno Lossin's message of
	"Wed, 05 Mar 2025 13:55:03 +0000")
References: <20250304225245.2033120-1-benno.lossin@proton.me>
	<qEIYcaF5eMmpiaRI_4rpApjyuiQMjms1LdZhmHXO5l9_HqN32upj8ZVbCnvI3hfDDTJeYT_9N7z3kyvOR-whRg==@protonmail.internalid>
	<20250304225245.2033120-17-benno.lossin@proton.me>
	<8734frd5v6.fsf@kernel.org>
	<cfBHbY6fYqucI2hjDXGCsolI6TkEE4AY7gT8hW-0z0P7BvaCe6dBzLpH9IFHRl5HgrPiBo8rMKGRWlP9M7x85A==@protonmail.internalid>
	<D88DTO6ZIXMN.26SWTE440RP9K@proton.me>
User-Agent: mu4e 1.12.7; emacs 29.4
Date: Wed, 05 Mar 2025 15:29:05 +0100
Message-ID: <87wmd38sb2.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Benno Lossin" <benno.lossin@proton.me> writes:

> On Wed Mar 5, 2025 at 1:22 PM CET, Andreas Hindborg wrote:
>> "Benno Lossin" <benno.lossin@proton.me> writes:
>>
>>> To synchronize the kernel's version of pin-init with the user-space
>>> version, introduce support for `std` and `alloc`. While the kernel uses
>>> neither, the user-space version has to support both. Thus include the
>>> required `#[cfg]`s and additional code.
>>>
>>> Signed-off-by: Benno Lossin <benno.lossin@proton.me>
>>> ---
>>>  rust/pin-init/src/__internal.rs |  27 ++++++
>>>  rust/pin-init/src/alloc.rs      | 158 ++++++++++++++++++++++++++++++++
>>>  rust/pin-init/src/lib.rs        |  17 ++--
>>>  3 files changed, 196 insertions(+), 6 deletions(-)
>>>  create mode 100644 rust/pin-init/src/alloc.rs
>>>
>>> diff --git a/rust/pin-init/src/__internal.rs b/rust/pin-init/src/__internal.rs
>>> index 74086365a18a..27d4a8619c04 100644
>>> --- a/rust/pin-init/src/__internal.rs
>>> +++ b/rust/pin-init/src/__internal.rs
>>> @@ -186,6 +186,33 @@ pub fn init<E>(self: Pin<&mut Self>, init: impl PinInit<T, E>) -> Result<Pin<&mu
>>>      }
>>>  }
>>>
>>> +#[test]
>>
>> I think the kunit support we have in the pipeline will pick this up?
>
> Is that support also enabled for crates outside of the `kernel` crate?
> I would argue it shouldn't and then this isn't a problem.

Re conversation about moving pin_init out of the kernel, we should
distinguish between vendored crates and crates that is part of the
kernel. This one is now vendored and tests are not meant to be run by
the kernel build system and infrastructure. Other crates will be
different, living in the kernel.

>
>>> +fn stack_init_reuse() {
>>> +    use ::std::{borrow::ToOwned, println, string::String};
>>> +    use core::pin::pin;
>>> +
>>> +    #[derive(Debug)]
>>> +    struct Foo {
>>> +        a: usize,
>>> +        b: String,
>>> +    }
>>> +    let mut slot: Pin<&mut StackInit<Foo>> = pin!(StackInit::uninit());
>>> +    let value: Result<Pin<&mut Foo>, core::convert::Infallible> =
>>> +        slot.as_mut().init(crate::init!(Foo {
>>> +            a: 42,
>>> +            b: "Hello".to_owned(),
>>> +        }));
>>> +    let value = value.unwrap();
>>> +    println!("{value:?}");
>>> +    let value: Result<Pin<&mut Foo>, core::convert::Infallible> =
>>> +        slot.as_mut().init(crate::init!(Foo {
>>> +            a: 24,
>>> +            b: "world!".to_owned(),
>>> +        }));
>>> +    let value = value.unwrap();
>>> +    println!("{value:?}");
>>> +}
>>> +
>>
>> [...]
>>
>>> diff --git a/rust/pin-init/src/lib.rs b/rust/pin-init/src/lib.rs
>>> index 55d8953620f0..1fdca35906a0 100644
>>> --- a/rust/pin-init/src/lib.rs
>>> +++ b/rust/pin-init/src/lib.rs
>>> @@ -204,8 +204,8 @@
>>>  //! [structurally pinned fields]:
>>>  //!     https://doc.rust-lang.org/std/pin/index.html#pinning-is-structural-for-field
>>>  //! [stack]: crate::stack_pin_init
>>> -//! [`Arc<T>`]: ../kernel/sync/struct.Arc.html
>>> -//! [`Box<T>`]: ../kernel/alloc/struct.KBox.html
>>> +//! [`Arc<T>`]: https://doc.rust-lang.org/stable/alloc/sync/struct.Arc.html
>>> +//! [`Box<T>`]: https://doc.rust-lang.org/stable/alloc/boxed/struct.Box.html
>>
>> Now these will render incorrect in the kernel docs, right?
>
> What do you mean by that? The link will resolve to the std versions of
> `Arc` and `Box`. But that is also what this crate will support, as it
> doesn't know about the kernel's own alloc.

I mean that if I render the kernel documentation, go to `pin_init` and
click the `Arc<T>` link, I end up in `std`. But I am in the kernel, so
not what I would expect.

But I guess there is no easy solution? Being a kernel developer, I would
prefer a kernel first approach. Can't have it all, I guess.

>
>>>  //! [`impl PinInit<Foo>`]: PinInit
>>>  //! [`impl PinInit<T, E>`]: PinInit
>>>  //! [`impl Init<T, E>`]: Init
>>> @@ -239,6 +239,11 @@
>>>  #[doc(hidden)]
>>>  pub mod macros;
>>>
>>> +#[cfg(any(feature = "std", feature = "alloc"))]
>>> +mod alloc;
>>> +#[cfg(any(feature = "std", feature = "alloc"))]
>>> +pub use alloc::InPlaceInit;
>>
>> Do we really need to have this entire file sitting dead in the kernel
>> tree? If you are not building the user space version from the kernel
>> sources, I don't think we need it here. Even when you want to sync
>> between the two repositories, it should be easy to handle an entire file
>> being not present on one side.
>
> I do have a script that does the commit porting, you can find it at [1].
> So I could easily add that file there. However, I think it also is
> important that it's easy to remember which files are synchronized and
> which files aren't. At the moment it's very simple, the synchronized
> files are:
> - README.md
> - CONTRIBUTING.md
> - src/*
> - internal/src/*
> - examples/*
>
> If I introduce special cases for files in src, I fear that I might get
> confused at some point, making a change that shouldn't be done etc.
>
> I understand your worry about the dead file, but at the same time, I
> think it's vital to keep the pattern of synchronized files as simple as
> possible.

I don't agree about this one - but I am not the one that has to do the
work. I would prefer we don't keep dead user space code in the kernel
tree, and I would ask that you consider if you can find a solution for
that which works for you. If not, I will live with the dead code.


Best regards,
Andreas Hindborg




