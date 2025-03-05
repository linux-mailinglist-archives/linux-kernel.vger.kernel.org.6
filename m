Return-Path: <linux-kernel+bounces-546769-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 45395A4FE89
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 13:23:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 519627A4B3F
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 12:22:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE15A245018;
	Wed,  5 Mar 2025 12:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UdYVsiAi"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AB1C230BC6;
	Wed,  5 Mar 2025 12:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741177386; cv=none; b=B/Ogu2yatUZ9ZxXkQUxx5ZTvLa+umZjkooVumDzK+erXbkv4X032tkZw3tI1vejGBg07riVoluOOJo1XHNXdbovGJitnKmfpxZPrDGfZutUZItKtN0BufB0lsRNUD7qKuWSt44y0+YeXC7TLpQ8yUlHmCjrql2ur7riS+KSNc9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741177386; c=relaxed/simple;
	bh=s/9I1InuYpZxK//KrKXsxt+XDSwpdDwGwl+90MDRa4o=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=tZ6b1vdrL4GRIO888db1GiRPL2kiaiB78TbxnblvhBmUNk/N3YD7D3usiFCcJG1hpc4qGENPCOZ0IWX5HHRm5zO/kVNntrfB3Z41Xbx8/Ekf7DsVylVrCp3SQHQvZUMmSmIHctzaqM+Hof8/BEJUCfEpBSM85BsQTgKzAbpbDto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UdYVsiAi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 309B3C4CEE2;
	Wed,  5 Mar 2025 12:23:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741177385;
	bh=s/9I1InuYpZxK//KrKXsxt+XDSwpdDwGwl+90MDRa4o=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=UdYVsiAiket9rKVXzmxwgRkSNbUbJP0lrRcZQ/Dx4Yu8Gc3+6nK3LI7drWbanrI4d
	 UD3ho32DWS+UkLIUAURh6+0qq2RGTpwkv6f5dW/dyMDnF50SrXrESJ/5pYx/pA1dzK
	 i/gOgiHwj5cnOm+309DeSN4od4bhxFUyRTGJ9rXV62Cr/mLbLmVkpNnRyqzpHLGhbU
	 gk6CgENSvmHtYEX58vV1TEizo3qBbEaPhux9UrleQgQZPQ0X5loVgbuhZSReRkCiFK
	 ifaR/ezjldHS7FfIl17oaAV94YSeht7BlKPtdiOiiP9nOIQ2QngwJpoR4sBh8rzVQK
	 ZFzFRGYOvWEUA==
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
In-Reply-To: <20250304225245.2033120-17-benno.lossin@proton.me> (Benno
	Lossin's message of "Tue, 04 Mar 2025 22:55:32 +0000")
References: <20250304225245.2033120-1-benno.lossin@proton.me>
	<qEIYcaF5eMmpiaRI_4rpApjyuiQMjms1LdZhmHXO5l9_HqN32upj8ZVbCnvI3hfDDTJeYT_9N7z3kyvOR-whRg==@protonmail.internalid>
	<20250304225245.2033120-17-benno.lossin@proton.me>
User-Agent: mu4e 1.12.7; emacs 29.4
Date: Wed, 05 Mar 2025 13:22:37 +0100
Message-ID: <8734frd5v6.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Benno Lossin" <benno.lossin@proton.me> writes:

> To synchronize the kernel's version of pin-init with the user-space
> version, introduce support for `std` and `alloc`. While the kernel uses
> neither, the user-space version has to support both. Thus include the
> required `#[cfg]`s and additional code.
>
> Signed-off-by: Benno Lossin <benno.lossin@proton.me>
> ---
>  rust/pin-init/src/__internal.rs |  27 ++++++
>  rust/pin-init/src/alloc.rs      | 158 ++++++++++++++++++++++++++++++++
>  rust/pin-init/src/lib.rs        |  17 ++--
>  3 files changed, 196 insertions(+), 6 deletions(-)
>  create mode 100644 rust/pin-init/src/alloc.rs
>
> diff --git a/rust/pin-init/src/__internal.rs b/rust/pin-init/src/__internal.rs
> index 74086365a18a..27d4a8619c04 100644
> --- a/rust/pin-init/src/__internal.rs
> +++ b/rust/pin-init/src/__internal.rs
> @@ -186,6 +186,33 @@ pub fn init<E>(self: Pin<&mut Self>, init: impl PinInit<T, E>) -> Result<Pin<&mu
>      }
>  }
>
> +#[test]

I think the kunit support we have in the pipeline will pick this up?

> +fn stack_init_reuse() {
> +    use ::std::{borrow::ToOwned, println, string::String};
> +    use core::pin::pin;
> +
> +    #[derive(Debug)]
> +    struct Foo {
> +        a: usize,
> +        b: String,
> +    }
> +    let mut slot: Pin<&mut StackInit<Foo>> = pin!(StackInit::uninit());
> +    let value: Result<Pin<&mut Foo>, core::convert::Infallible> =
> +        slot.as_mut().init(crate::init!(Foo {
> +            a: 42,
> +            b: "Hello".to_owned(),
> +        }));
> +    let value = value.unwrap();
> +    println!("{value:?}");
> +    let value: Result<Pin<&mut Foo>, core::convert::Infallible> =
> +        slot.as_mut().init(crate::init!(Foo {
> +            a: 24,
> +            b: "world!".to_owned(),
> +        }));
> +    let value = value.unwrap();
> +    println!("{value:?}");
> +}
> +

[...]

> diff --git a/rust/pin-init/src/lib.rs b/rust/pin-init/src/lib.rs
> index 55d8953620f0..1fdca35906a0 100644
> --- a/rust/pin-init/src/lib.rs
> +++ b/rust/pin-init/src/lib.rs
> @@ -204,8 +204,8 @@
>  //! [structurally pinned fields]:
>  //!     https://doc.rust-lang.org/std/pin/index.html#pinning-is-structural-for-field
>  //! [stack]: crate::stack_pin_init
> -//! [`Arc<T>`]: ../kernel/sync/struct.Arc.html
> -//! [`Box<T>`]: ../kernel/alloc/struct.KBox.html
> +//! [`Arc<T>`]: https://doc.rust-lang.org/stable/alloc/sync/struct.Arc.html
> +//! [`Box<T>`]: https://doc.rust-lang.org/stable/alloc/boxed/struct.Box.html

Now these will render incorrect in the kernel docs, right?

>  //! [`impl PinInit<Foo>`]: PinInit
>  //! [`impl PinInit<T, E>`]: PinInit
>  //! [`impl Init<T, E>`]: Init
> @@ -239,6 +239,11 @@
>  #[doc(hidden)]
>  pub mod macros;
>
> +#[cfg(any(feature = "std", feature = "alloc"))]
> +mod alloc;
> +#[cfg(any(feature = "std", feature = "alloc"))]
> +pub use alloc::InPlaceInit;

Do we really need to have this entire file sitting dead in the kernel
tree? If you are not building the user space version from the kernel
sources, I don't think we need it here. Even when you want to sync
between the two repositories, it should be easy to handle an entire file
being not present on one side.


Best regards,
Andreas Hindborg



