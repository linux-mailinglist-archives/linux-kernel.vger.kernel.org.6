Return-Path: <linux-kernel+bounces-273611-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26DC3946B76
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Aug 2024 01:22:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 78379281BBF
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Aug 2024 23:22:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C858712D214;
	Sat,  3 Aug 2024 23:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mT2XpuJX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10EF514A84;
	Sat,  3 Aug 2024 23:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722727345; cv=none; b=gEH9EDZqnRGvzpBdOn1wLt1B/mkHKA/dYOn3ZNk7jYhjThKQ3b4GFYaBe2OrbmofyfRGDX7Om/Oj9wmdARJDAKN6dHtIJ/MQbk5rnYUpGWP/AoEebxFBiMFFKa5eBkjEt12oERypFHn7NHDPleWacz2KGZeOM3pffjHgBgYpAtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722727345; c=relaxed/simple;
	bh=7DAqEyc+B3FW6qi+j1yhzRctjhcUhMsrnfy3PslD1zQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DWHJgjp9rXK/0zOyf+6A22NVWwrXHhgRvkAvAP5VPZY8Gb+GcYHuzycLlAa2JkI8kKqA/FalUJveMGzBhUvFhjIV9XDbR+gQdYCK5/cl41eL8GiyqFbivv9aF4I/9gTBSt0NZnGPFXfXW3xjzlCIp0CwKWCsBwyMIoKQAzU/xig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mT2XpuJX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DA48C116B1;
	Sat,  3 Aug 2024 23:22:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722727344;
	bh=7DAqEyc+B3FW6qi+j1yhzRctjhcUhMsrnfy3PslD1zQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=mT2XpuJXkiav8oaAalMIZj7B97yM3fGkBj5Z0PgIe4sO5lF7QKb8da8c5lF0kGMld
	 CSq788AkMlSjyvIthNaXthkdsqGH1M+3wqUn+2T8toUUMSRq5Qijq2W6STrHIcQTzf
	 95/mmBixC1miJIqG5TFhyF24LEgazwSLPPVrAz+zh1WhiprjiarivpWB616Efc9Swy
	 TWrXd/CpMNVPfjH0ZJqyOBpt9fyAqyri4RTpOu27oBrJEEG6nNgEwyerPrgx1bb+ga
	 /7uck/ANNqZEhjkOZ3eUaxbQsWYLgsoq0r8oz0rvuPQNOhzEQiNfqaYEv1w3nEMqNq
	 t5Eed80G++5Og==
Message-ID: <2ddc08c1-ac38-4cc6-a102-2ad336d6b617@kernel.org>
Date: Sun, 4 Aug 2024 01:22:20 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] rust: kernel: add `drop_contents` to `BoxExt`
To: Benno Lossin <benno.lossin@proton.me>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>,
 Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng
 <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
 =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Andreas Hindborg <a.hindborg@samsung.com>, Alice Ryhl
 <aliceryhl@google.com>, rust-for-linux@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240803141639.3237686-1-benno.lossin@proton.me>
Content-Language: en-US
From: Danilo Krummrich <dakr@kernel.org>
In-Reply-To: <20240803141639.3237686-1-benno.lossin@proton.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/3/24 4:16 PM, Benno Lossin wrote:
> Sometimes (see [1]) it is necessary to drop the value inside of a
> `Box<T>`, but retain the allocation. For example to reuse the allocation
> in the future.
> Introduce a new function `drop_contents` that turns a `Box<T>` into
> `Box<MaybeUninit<T>>` by dropping the value.

Is this (and the stuff in patch 2) used somewhere? Otherwise, I think it
would probably make sense to base this work on top of my allocator work.

> 
> Signed-off-by: Benno Lossin <benno.lossin@proton.me>
> Link: https://lore.kernel.org/rust-for-linux/20240418-b4-rbtree-v3-5-323e134390ce@google.com/ [1]
> ---
>   rust/kernel/alloc/box_ext.rs | 26 +++++++++++++++++++++++++-
>   1 file changed, 25 insertions(+), 1 deletion(-)
> 
> diff --git a/rust/kernel/alloc/box_ext.rs b/rust/kernel/alloc/box_ext.rs
> index 829cb1c1cf9e..076d5de5f47d 100644
> --- a/rust/kernel/alloc/box_ext.rs
> +++ b/rust/kernel/alloc/box_ext.rs
> @@ -4,7 +4,7 @@
>   
>   use super::{AllocError, Flags};
>   use alloc::boxed::Box;
> -use core::mem::MaybeUninit;
> +use core::{mem::MaybeUninit, ptr, result::Result};
>   
>   /// Extensions to [`Box`].
>   pub trait BoxExt<T>: Sized {
> @@ -17,6 +17,22 @@ pub trait BoxExt<T>: Sized {
>       ///
>       /// The allocation may fail, in which case an error is returned.
>       fn new_uninit(flags: Flags) -> Result<Box<MaybeUninit<T>>, AllocError>;
> +
> +    /// Drops the contents, but keeps the allocation.
> +    ///
> +    /// # Examples
> +    ///
> +    /// ```
> +    /// use kernel::alloc::{flags, box_ext::BoxExt};
> +    /// let value = Box::new([0; 32], flags::GFP_KERNEL)?;
> +    /// assert_eq!(*value, [0; 32]);
> +    /// let value = Box::drop_contents(value);
> +    /// // Now we can re-use `value`:
> +    /// let value = Box::write(value, [1; 32]);
> +    /// assert_eq!(*value, [1; 32]);
> +    /// # Ok::<(), Error>(())
> +    /// ```
> +    fn drop_contents(this: Self) -> Box<MaybeUninit<T>>;
>   }
>   
>   impl<T> BoxExt<T> for Box<T> {
> @@ -53,4 +69,12 @@ fn new_uninit(flags: Flags) -> Result<Box<MaybeUninit<T>>, AllocError> {
>           // zero-sized types, we use `NonNull::dangling`.
>           Ok(unsafe { Box::from_raw(ptr) })
>       }
> +
> +    fn drop_contents(this: Self) -> Box<MaybeUninit<T>> {
> +        let ptr = Box::into_raw(this);
> +        // SAFETY: `ptr` is valid, because it came from `Box::into_raw`.
> +        unsafe { ptr::drop_in_place(ptr) };
> +        // SAFETY: `ptr` is valid, because it came from `Box::into_raw`.
> +        unsafe { Box::from_raw(ptr.cast()) }
> +    }
>   }

