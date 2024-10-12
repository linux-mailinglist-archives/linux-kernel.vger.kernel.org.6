Return-Path: <linux-kernel+bounces-362160-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 05CF999B1B6
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Oct 2024 09:39:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 72AD7B21EB6
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Oct 2024 07:39:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C42F14D6ED;
	Sat, 12 Oct 2024 07:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mnNuHiw9"
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E460148314;
	Sat, 12 Oct 2024 07:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728718667; cv=none; b=V9PWuqf+6nFHye6abxFYa1p+wl3NqshOZoXuj8xniU+2xYBrZvWvPODY8sQ7z6Dg6dUst/FKvnbRT3WPJaqUM67+UruvIPohmE8UI8Id85kA5R4VLpIHrq9av5V2UhYSPLNzAVcRa1KSsRFJuCfFiJOCdBpX32k6Gy2tn31BQlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728718667; c=relaxed/simple;
	bh=uitkqDe+ng5uQIwFCrP6kpvbU6X4JquuC3NVWtohspA=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=k2CA7mktX4aDOKkYgrPwRmqZiPazhEtifMCvYgIYlYKya2q7Xz0+BXuox8DpHyyfjUfW0CmDKvWsvFTFNbcKmOx9/1WaqXJOqIOXmkctvF/LjqsGs8qQTJQxBTy0f94vBQrCsXL8n2Wj7I/tECVTwkoypbBT6GG/DU1lpsnHTdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mnNuHiw9; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5c9625cfe4dso189691a12.0;
        Sat, 12 Oct 2024 00:37:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728718664; x=1729323464; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0Xnxym3NoNpmXbxMGs8fX8uofI5EH9aRkRpq/wTs5B4=;
        b=mnNuHiw9kzvt/YqyxWFccvwAZekODODehbG04VgXq36EuT20WuA4ke3DpyqspSxk9b
         3YHo6a7rU7+l+w3qsHMY/zoecct4iqfobd7WHf+bOvoNqX89WzFHjyldVmVP/QVVSLmq
         BOol6EK5VJ5UOcwdX8NmHuwAknwesRN62+YvhosaF1q5Vhni8xPXWVJS4g06gjfTyX0E
         Z9KHMdIyq+CE3OGuv1bcspe+utAVcJbjta0jEh+6TMjznzB1/9C7oj2AMb4HMCYj5LTh
         PeMH+d9QmZ4VZ2msQBju1zW9E5sVgMYrMM6phrg7OoFOhAklmNKXA+QNPsFZxyxrjpgN
         Ak3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728718664; x=1729323464;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0Xnxym3NoNpmXbxMGs8fX8uofI5EH9aRkRpq/wTs5B4=;
        b=PVpki9xrOearm2tarMqI39GEAyHbs+CTaMHF0W70eEXqdY8zsop+q3vSlNu9EkhOpe
         zNNB7n23GSd2wxrtYeg/d1bdYDJhnm90CrdS+cptWgOwDwraRPWDtOGJbXWGf/Ckq7Le
         ycSllSGlMR5P3yQVNs2RG1rzNzxHqIq4TvCo5MZ+HBzVSh5p8wHuikgMKJojMPZaasi5
         Gk3pUjf/ReTeKH9vZiPou4gcdKI6tNo6jpDIZryNn6Nlthxr/vII4ihJGoEniLHgCRHs
         A+6RCe+NqjQH8Ztzpr1TmCdbkIZcOXn0uDNdBzsU6pjNkwHuJDKry45tJoLpbfNKwXdc
         Xx9g==
X-Forwarded-Encrypted: i=1; AJvYcCVstCpttzNg7/lSldIMtWsA7d6lIOFqzqdf3DHZN+crX+349yxeGDJFL6FmTrp1/b/zIR6wQKjwP+Q0PPDw41w=@vger.kernel.org, AJvYcCWvUPIDfvogtv+oxTnJOpaIOmOGvI7r42UlCxTDc1xRrK+Umr1IHQx3368Kk1ie9/ZKNdV0z3+Ke4lYL7Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywjb2ffpiSjPlN0pzg9IBAuGH7qCm3LvyfeaVFQHes2XOMfkI12
	+G5Op9FT2oSg6vWks+9bdfwgamIFjZv/DpBtOXBx/hqKp727p76i
X-Google-Smtp-Source: AGHT+IGaklo6FzJASAqciLOAL6ltV6mkRWs7c6/5kCidnQqtYJ7dZSCBWVxUGKg2SLhpgw1spIFbpw==
X-Received: by 2002:a17:907:1b16:b0:a99:482c:b2b9 with SMTP id a640c23a62f3a-a99e3b757e9mr186085066b.29.1728718663173;
        Sat, 12 Oct 2024 00:37:43 -0700 (PDT)
Received: from ?IPV6:2003:df:bf0d:b400:7350:36ae:6e0c:c598? (p200300dfbf0db400735036ae6e0cc598.dip0.t-ipconnect.de. [2003:df:bf0d:b400:7350:36ae:6e0c:c598])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a99a7f25dc6sm294267366b.72.2024.10.12.00.37.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 12 Oct 2024 00:37:42 -0700 (PDT)
Message-ID: <60a962ef-90b7-4669-9c5c-0aade73c1fd6@gmail.com>
Date: Sat, 12 Oct 2024 09:37:42 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] rust: transmute: Add implementation for FromBytes
 trait
To: Christian dos Santos de Lima <christiansantoslima21@gmail.com>,
 rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
 Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>,
 Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
 =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <benno.lossin@proton.me>,
 Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
 Trevor Gross <tmgross@umich.edu>, ~lkcamp/patches@lists.sr.ht
References: <20241012070121.110481-1-christiansantoslima21@gmail.com>
Content-Language: de-AT-frami
From: Dirk Behme <dirk.behme@gmail.com>
In-Reply-To: <20241012070121.110481-1-christiansantoslima21@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12.10.24 09:01, Christian dos Santos de Lima wrote:
> Add implementation and documentation for FromBytes trait.
> 
> Add new feature block in order to allow using ToBytes
> and bound to from_bytes_mut function. I'm adding this feature
> because is possible create a value with disallowed bit pattern
> and as_byte_mut could create such value by mutating the array and
> acessing the original value. So adding ToBytes this can be avoided.
> 
> Link: https://github.com/Rust-for-Linux/linux/issues/1119
> Signed-off-by: Christian dos Santos de Lima <christiansantoslima21@gmail.com>


Applying this on top of rust-next which has

https://github.com/Rust-for-Linux/linux/commit/ce1c54fdff7c4556b08f5b875a331d8952e8b6b7

I'm getting

error[E0405]: cannot find trait `AsBytes` in this scope
    --> rust/kernel/uaccess.rs:360:21
     |
360 |     pub fn write<T: AsBytes>(&mut self, value: &T) -> Result {
     |                     ^^^^^^^ not found in this scope

error: aborting due to 1 previous error

Additionally, could you review the two examples? They don't build. And 
they look identical? Is this intended?

And at several places there seem to miss a space after //.

./scripts/checkpatch.pl --codespell reports

WARNING: 'acessing' may be misspelled - perhaps 'accessing'?
#12:
acessing the original value. So adding ToBytes this can be avoided.
^^^^^^^^

WARNING: 'initiliazed' may be misspelled - perhaps 'initialized'?
#167: FILE: rust/kernel/transmute.rs:103:
+        //Safety: Guarantee that all values are initiliazed
                                                  ^^^^^^^^^^^

WARNING: 'initiliazed' may be misspelled - perhaps 'initialized'?
#179: FILE: rust/kernel/transmute.rs:111:
+    //Safety: Guarantee that all values are initiliazed
                                              ^^^^^^^^^^^

WARNING: 'initiliazed' may be misspelled - perhaps 'initialized'?
#184: FILE: rust/kernel/transmute.rs:116:
+        //Safety: Guarantee that all values are initiliazed
                                                  ^^^^^^^^^^^

Best regards

Dirk

> ---
> changes in v2:
>       - Rollback the implementation for the macro in the repository and add implementation of functions in trait
> ---
>   rust/kernel/lib.rs       |   2 +
>   rust/kernel/transmute.rs | 120 ++++++++++++++++++++++++++++-----------
>   2 files changed, 88 insertions(+), 34 deletions(-)
> 
> diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
> index dc37aef6a008..5215f5744e12 100644
> --- a/rust/kernel/lib.rs
> +++ b/rust/kernel/lib.rs
> @@ -18,6 +18,8 @@
>   #![feature(lint_reasons)]
>   #![feature(new_uninit)]
>   #![feature(unsize)]
> +#![feature(portable_simd)]
> +#![feature(trivial_bounds)]
>   
>   // Ensure conditional compilation based on the kernel configuration works;
>   // otherwise we may silently break things like initcall handling.
> diff --git a/rust/kernel/transmute.rs b/rust/kernel/transmute.rs
> index 1c7d43771a37..bce42cc7265e 100644
> --- a/rust/kernel/transmute.rs
> +++ b/rust/kernel/transmute.rs
> @@ -2,6 +2,7 @@
>   
>   //! Traits for transmuting types.
>   
> +use core::simd::ToBytes;
>   /// Types for which any bit pattern is valid.
>   ///
>   /// Not all types are valid for all values. For example, a `bool` must be either zero or one, so
> @@ -9,15 +10,58 @@
>   ///
>   /// It's okay for the type to have padding, as initializing those bytes has no effect.
>   ///
> +/// # Example
> +///
> +/// This example is how to use the FromBytes trait
> +/// ```
> +/// // Initialize a slice of bytes
> +/// let foo = &[1, 2, 3, 4];
> +///
> +/// //Use the function implemented by trait in integer type
> +/// let result = u8::from_bytes(foo);
> +///
> +/// assert_eq!(*result, 0x4030201);
> +/// ```
>   /// # Safety
>   ///
>   /// All bit-patterns must be valid for this type. This type must not have interior mutability.
> -pub unsafe trait FromBytes {}
> +pub unsafe trait FromBytes {
> +    ///Get an imutable slice of bytes and converts to a reference to Self
> +    unsafe fn from_bytes(slice_of_bytes: &[u8]) -> &Self;
> +    /// Get a mutable slice of bytes and converts to a reference to Self
> +    ///
> +    /// # Safety
> +    ///
> +    ///  Bound ToBytes in order to avoid use with disallowed bit patterns
> +    unsafe fn from_bytes_mut(slice_of_bytes: &mut [u8]) -> &mut Self
> +    where
> +        Self: ToBytes;
> +}
>   
> +//Get a reference of slice of bytes and converts into a reference of integer or a slice with a defined size
>   macro_rules! impl_frombytes {
>       ($($({$($generics:tt)*})? $t:ty, )*) => {
>           // SAFETY: Safety comments written in the macro invocation.
> -        $(unsafe impl$($($generics)*)? FromBytes for $t {})*
> +        $(unsafe impl$($($generics)*)? FromBytes for $t {
> +            unsafe fn from_bytes(slice_of_bytes: &[u8]) -> &Self
> +            {
> +                unsafe {
> +                    let slice_ptr = slice_of_bytes.as_ptr() as *const Self;
> +                    &*slice_ptr
> +                }
> +            }
> +
> +            unsafe fn from_bytes_mut(slice_of_bytes: &mut [u8]) -> &mut Self
> +            where
> +                Self: ToBytes,
> +            {
> +                unsafe {
> +                    let slice_ptr = slice_of_bytes.as_mut_ptr() as *mut Self;
> +                    &mut *slice_ptr
> +                }
> +
> +            }
> +        })*
>       };
>   }
>   
> @@ -28,44 +72,52 @@ macro_rules! impl_frombytes {
>   
>       // SAFETY: If all bit patterns are acceptable for individual values in an array, then all bit
>       // patterns are also acceptable for arrays of that type.
> -    {<T: FromBytes>} [T],
>       {<T: FromBytes, const N: usize>} [T; N],
>   }
>   
> -/// Types that can be viewed as an immutable slice of initialized bytes.
> +/// Get a reference of slice of bytes and converts into a reference of an array of integers
>   ///
> -/// If a struct implements this trait, then it is okay to copy it byte-for-byte to userspace. This
> -/// means that it should not have any padding, as padding bytes are uninitialized. Reading
> -/// uninitialized memory is not just undefined behavior, it may even lead to leaking sensitive
> -/// information on the stack to userspace.
> +/// Types for which any bit pattern is valid.
>   ///
> -/// The struct should also not hold kernel pointers, as kernel pointer addresses are also considered
> -/// sensitive. However, leaking kernel pointers is not considered undefined behavior by Rust, so
> -/// this is a correctness requirement, but not a safety requirement.
> +/// Not all types are valid for all values. For example, a `bool` must be either zero or one, so
> +/// reading arbitrary bytes into something that contains a `bool` is not okay.
>   ///
> -/// # Safety
> +/// It's okay for the type to have padding, as initializing those bytes has no effect.
>   ///
> -/// Values of this type may not contain any uninitialized bytes. This type must not have interior
> -/// mutability.
> -pub unsafe trait AsBytes {}
> -
> -macro_rules! impl_asbytes {
> -    ($($({$($generics:tt)*})? $t:ty, )*) => {
> -        // SAFETY: Safety comments written in the macro invocation.
> -        $(unsafe impl$($($generics)*)? AsBytes for $t {})*
> -    };
> -}
> -
> -impl_asbytes! {
> -    // SAFETY: Instances of the following types have no uninitialized portions.
> -    u8, u16, u32, u64, usize,
> -    i8, i16, i32, i64, isize,
> -    bool,
> -    char,
> -    str,
> +/// # Example
> +///
> +/// This example is how to use the FromBytes trait
> +/// ```
> +/// // Initialize a slice of bytes
> +/// let foo = &[1, 2, 3, 4];
> +///
> +/// //Use the function implemented by trait in integer type
> +/// let result = <[u32]>::from_bytes(slice_of_bytes);
> +///
> +/// assert_eq!(*result, 0x4030201);
> +/// ```
> +// SAFETY: If all bit patterns are acceptable for individual values in an array, then all bit
> +// patterns are also acceptable for arrays of that type.
> +unsafe impl<T: FromBytes> FromBytes for [T] {
> +    unsafe fn from_bytes(slice_of_bytes: &[u8]) -> &Self {
> +        //Safety: Guarantee that all values are initiliazed
> +        unsafe {
> +            let slice_ptr = slice_of_bytes.as_ptr() as *const T;
> +            let slice_len = slice_of_bytes.len() / core::mem::size_of::<T>();
> +            core::slice::from_raw_parts(slice_ptr, slice_len)
> +        }
> +    }
>   
> -    // SAFETY: If individual values in an array have no uninitialized portions, then the array
> -    // itself does not have any uninitialized portions either.
> -    {<T: AsBytes>} [T],
> -    {<T: AsBytes, const N: usize>} [T; N],
> +    //Safety: Guarantee that all values are initiliazed
> +    unsafe fn from_bytes_mut(slice_of_bytes: &mut [u8]) -> &mut Self
> +    where
> +        Self: ToBytes,
> +    {
> +        //Safety: Guarantee that all values are initiliazed
> +        unsafe {
> +            let slice_ptr = slice_of_bytes.as_mut_ptr() as *mut T;
> +            let slice_len = slice_of_bytes.len() / core::mem::size_of::<T>();
> +            core::slice::from_raw_parts_mut(slice_ptr, slice_len)
> +        }
> +    }
>   }


