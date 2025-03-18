Return-Path: <linux-kernel+bounces-566875-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 492CFA67DD0
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 21:13:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E4733B5E66
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 20:13:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33CB62116FE;
	Tue, 18 Mar 2025 20:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zpj9rGkq"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DCF81C5F3F;
	Tue, 18 Mar 2025 20:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742328787; cv=none; b=SgjVSeHW8rdpcNbPXsX1FdLawn2syFOq+jFMGaXDg+nV5nv7BL1zsNLJiTPciAYuq5CzBsqYlIZMbJ/p+4v9P1SsVFA3cGYpXXjmgGcr4Z1+9yEorf6KxuWCT2QfKWGuP4YtivhwbHy5KRj7skluCMfJznH5CtZuQg9vPNehG2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742328787; c=relaxed/simple;
	bh=/knEF0guqSOeoMQAPj8xw00aC7XkPldoxcZPhDGnIqw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WlnvzDG1iV5P/lv47oTHbKGBeLgYpm34Ad98KwE0dtAy26UVF+84bR4VEZWF/UCsGGmI44wZxSDgSk90lJSqE/i9Cdo8IpnbyuZkCl9xqy0gVpAsDfKoVc+aj3hQdCscH950rb8aCWUaVY54ttXObUpjHknI+7ZBMOoYYbgCsos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zpj9rGkq; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-ab78e6edb99so934325166b.2;
        Tue, 18 Mar 2025 13:13:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742328784; x=1742933584; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+8svpLKvB6wZO5NP+nLCuQJd0zpfjUO62j2bUZj/+dM=;
        b=Zpj9rGkqdKAGgu8BxN86rfqDLXPcriH9HB0CLoO8pM9pdLqvuExc2PU6y6fEISjZv4
         qU5ZDDbgoSmEnhAaxeAW6R4X5poJphDpZfOM12FebOqCDXVL4PU1k77p1ngJV7FDqnVd
         yRTf7JXKAwv+s6veH6uyQnbLBdjbOa9XhOKSGblP+4BSXetq3v618cZk4MoSNLiK8tc6
         px/38iofU77OvrnfHDJbYFOATnI7ekwYzTF/PaETIM1BNrqmuBlBtVM6G1BJZMaLbxzm
         k+hZQPnY7P1mlSkzT+sbO30/J+hrlgP20DxLN1CMrpnmvAZm0Auea4XgFziahJ/Ob8ve
         eC2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742328784; x=1742933584;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+8svpLKvB6wZO5NP+nLCuQJd0zpfjUO62j2bUZj/+dM=;
        b=Wm/AC52eUF3aZiuiRq2Pd2fIBRnhqObdiRciN/ufQzuTyqDw/GZ/3FIEvR6JFyF8lF
         zNmt6ZxHQysPVT1sjB5Ksvi2GS5Zrc50v92/hPyfH7Y4Tp2MJSNGKhb8nQW+NSwhhyC6
         OAeWcEPTjq/QDj6ub8fN0WyEyCQl8PILl42txRuWCxnkoTzBW6tb1Q1uCIu7Pu+OxYiY
         OR5C1ObVgPEDDhkxPlmo/doXTUwqtyaoMkjju1eu0eFDMiDWq+NS41t7LIY0+GeFfjwI
         TOU8IRC8C4yV84KnoeXUQvUXVCVTABUcZD/gbmg8Mvr1DhRhwv6X4eUCXoAuZIpKxR5t
         x3EA==
X-Forwarded-Encrypted: i=1; AJvYcCXTjmz24j6orI32ZmMojdqu6BGUoShozKE1zFjs65E+/qIKcSuov9NeDKbLxtLuIBGXyGZzIloAbCR/c2v/9M0=@vger.kernel.org, AJvYcCXkA89jhLWzHJ3leSdxR/GLDdnlz9eErCGNNZo6p2owUsKz5pYs5o5r+45FkY/Ei23GnA9kXL9fHJ0s+4A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzq1YWc/SxrHRxAgnYTispE2i9u2KnGWzVgVQ2mYnGwJ8tPhj4a
	cv/nxK6QHRREbOGiHAdnLm84ppvQSvdQCi+f7Lj4HKsU1vmO0rla
X-Gm-Gg: ASbGnctrE/eCZnOX4SpDWmmz9KpVi6JgZKBLwQZcD0/WoMGrFf0OJJ0zpKS/U3nItUX
	VzeT/Zkypr45CguLGUTrs60GrKx+UMkwwrYw6V6W3EheB2W1ecGCFCzyU84ZZF+cP2kT75K6Sj2
	6+PHtu9wX24hqcMmrii2nVKzlM5CcZXhqJkK2Yfe4Ci9eudCrSV00Gp9xxZmfRJ5veMg4IUp+aG
	tEli0M7NvTXUhqbZTpy5MRBdhGQycuog8KU6Y2iVhFiIeORqT18taJc5fGqwp8WuLog7Ym1SpqP
	3qOS5BIvZsNvX/WNLXtkpTHA/aH/+cohvGggZiODyW1wmjraXocPwE1SUBy3pxFmPiak0SDQmcm
	SoAGyDNef
X-Google-Smtp-Source: AGHT+IEih5PPbGW303DwvPnaiIJ82tx/gYZKhfbTc7QmbLW7Iemm29mn/aZPJz75DE6oKj3W5l+YLw==
X-Received: by 2002:a17:907:7241:b0:abf:4708:8644 with SMTP id a640c23a62f3a-ac330444cb9mr1969810966b.43.1742328783458;
        Tue, 18 Mar 2025 13:13:03 -0700 (PDT)
Received: from [10.1.1.5] (93-82-55-26.adsl.highway.telekom.at. [93.82.55.26])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac3146aed4fsm891156266b.26.2025.03.18.13.13.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Mar 2025 13:13:02 -0700 (PDT)
Message-ID: <439baec2-dba8-4dab-abb5-faa14fbda943@gmail.com>
Date: Tue, 18 Mar 2025 21:13:01 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/5] rust: iov: add iov_iter abstractions for ITER_DEST
To: Alice Ryhl <aliceryhl@google.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Alexander Viro <viro@zeniv.linux.org.uk>, Arnd Bergmann <arnd@arndb.de>,
 Miguel Ojeda <ojeda@kernel.org>
Cc: Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
 =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <benno.lossin@proton.me>,
 Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>,
 Danilo Krummrich <dakr@kernel.org>, Matthew Maurer <mmaurer@google.com>,
 Lee Jones <lee@kernel.org>, linux-kernel@vger.kernel.org,
 rust-for-linux@vger.kernel.org
References: <20250311-iov-iter-v1-0-f6c9134ea824@google.com>
 <20250311-iov-iter-v1-2-f6c9134ea824@google.com>
Content-Language: en-US, de-DE
From: Christian Schrefl <chrisi.schrefl@gmail.com>
In-Reply-To: <20250311-iov-iter-v1-2-f6c9134ea824@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Alice

On 11.03.25 3:25 PM, Alice Ryhl wrote:
> This adds abstractions for the iov_iter type in the case where
> data_source is ITER_DEST. This will make Rust implementations of
> fops->read_iter possible.
> 
> This series only has support for using existing IO vectors created by C
> code. Additional abstractions will be needed to support the creation of
> IO vectors in Rust code.
> 
> These abstractions make the assumption that `struct iov_iter` does not
> have internal self-references, which implies that it is valid to move it
> between different local variables, and that you can make a copy of it to
> get two IO vectors into the same buffers.
> 
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>
> ---
>  rust/kernel/iov.rs | 140 ++++++++++++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 139 insertions(+), 1 deletion(-)
> 
> diff --git a/rust/kernel/iov.rs b/rust/kernel/iov.rs
> index 4498f65e1f65bd964909810c020db3a9f8fae389..dc32c27c5c76d059562fd7c6b9d4b178a8ea7c81 100644
> --- a/rust/kernel/iov.rs
> +++ b/rust/kernel/iov.rs
> @@ -7,7 +7,12 @@
>  //! C headers: [`include/linux/iov_iter.h`](srctree/include/linux/iov_iter.h),
>  //! [`include/linux/uio.h`](srctree/include/linux/uio.h)
>  
> -use crate::{bindings, prelude::*, types::Opaque};
> +use crate::{
> +    alloc::{Allocator, Flags},
> +    bindings,
> +    prelude::*,
> +    types::Opaque,
> +};
>  use core::{marker::PhantomData, mem::MaybeUninit, slice};
>  
>  const ITER_SOURCE: bool = bindings::ITER_SOURCE != 0;
> @@ -168,3 +173,136 @@ fn clone(&self) -> IovIterSource<'data> {
>          unsafe { core::ptr::read(self) }
>      }
>  }
> +
> +/// An IO vector that acts as a destination for data.
> +///
> +/// # Invariants
> +///
> +/// Must hold a valid `struct iov_iter` with `data_source` set to `ITER_DEST`. The buffers
> +/// referenced by the IO vector must be valid for writing for the duration of `'data`.
> +///
> +/// Note that if the IO vector is backed by a userspace pointer, it is always considered valid for
> +/// writing.
> +#[repr(transparent)]
> +pub struct IovIterDest<'data> {
> +    iov: Opaque<bindings::iov_iter>,
> +    /// Represent to the type system that this value contains a pointer to writable data it does
> +    /// not own.
> +    _source: PhantomData<&'data mut [u8]>,
> +}

It might be a bit nicer to add a (private) struct 'IovIter' that implements the common operations.
Then 'IovIterDest' and 'IovIterSource' could store that struct and forward the implementations to 
it.
But I'm not sure if that's really much better.

> +
> +// SAFETY: This struct is essentially just a fancy `std::io::Cursor<&mut [u8]>`, and that type is
> +// safe to send across thread boundaries.
> +unsafe impl<'data> Send for IovIterDest<'data> {}
> +// SAFETY: This struct is essentially just a fancy `std::io::Cursor<&mut [u8]>`, and that type is
> +// safe to share across thread boundaries.
> +unsafe impl<'data> Sync for IovIterDest<'data> {}
> +
> +impl<'data> IovIterDest<'data> {
> +    /// Obtain an `IovIterDest` from a raw pointer.
> +    ///
> +    /// # Safety
> +    ///
> +    /// * For the duration of `'iov`, the `struct iov_iter` must remain valid and must not be
> +    ///   accessed except through the returned reference.
> +    /// * For the duration of `'data`, the buffers backing this IO vector must be valid for
> +    ///   writing.
> +    #[track_caller]
> +    #[inline]
> +    pub unsafe fn from_raw<'iov>(ptr: *mut bindings::iov_iter) -> &'iov mut IovIterDest<'data> {
> +        // SAFETY: The caller ensures that `ptr` is valid.
> +        let data_source = unsafe { (*ptr).data_source };
> +        assert_eq!(data_source, ITER_DEST);
> +
> +        // SAFETY: The caller ensures the struct invariants for the right durations.
> +        unsafe { &mut *ptr.cast::<IovIterDest<'data>>() }
> +    }
> +
> +    /// Access this as a raw `struct iov_iter`.
> +    #[inline]
> +    pub fn as_raw(&mut self) -> *mut bindings::iov_iter {
> +        self.iov.get()
> +    }
> +
> +    /// Returns the number of bytes available in this IO vector.
> +    ///
> +    /// Note that this may overestimate the number of bytes. For example, reading from userspace
> +    /// memory could fail with EFAULT, which will be treated as the end of the IO vector.
> +    #[inline]
> +    pub fn len(&self) -> usize {
> +        // SAFETY: It is safe to access the `count` field.
> +        unsafe {
> +            (*self.iov.get())
> +                .__bindgen_anon_1
> +                .__bindgen_anon_1
> +                .as_ref()
> +                .count
> +        }
> +    }
> +
> +    /// Returns whether there are any bytes left in this IO vector.
> +    ///
> +    /// This may return `true` even if there are no more bytes available. For example, reading from
> +    /// userspace memory could fail with EFAULT, which will be treated as the end of the IO vector.
> +    #[inline]
> +    pub fn is_empty(&self) -> bool {
> +        self.len() == 0
> +    }
> +
> +    /// Advance this IO vector by `bytes` bytes.
> +    ///
> +    /// If `bytes` is larger than the size of this IO vector, it is advanced to the end.
> +    #[inline]
> +    pub fn advance(&mut self, bytes: usize) {
> +        // SAFETY: `self.iov` is a valid IO vector.
> +        unsafe { bindings::iov_iter_advance(self.as_raw(), bytes) };
> +    }
> +
> +    /// Advance this IO vector backwards by `bytes` bytes.
> +    ///
> +    /// # Safety
> +    ///
> +    /// The IO vector must not be reverted to before its beginning.
> +    #[inline]
> +    pub unsafe fn revert(&mut self, bytes: usize) {
> +        // SAFETY: `self.iov` is a valid IO vector, and `bytes` is in bounds.
> +        unsafe { bindings::iov_iter_revert(self.as_raw(), bytes) };
> +    }
> +
> +    /// Write data to this IO vector.
> +    ///
> +    /// Returns the number of bytes that were written. If this is shorter than the provided slice,
> +    /// then no more bytes can be written.
> +    #[inline]
> +    pub fn copy_to_iter(&mut self, input: &[u8]) -> usize {
> +        // SAFETY: `input` is valid for `input.len()` bytes.
> +        unsafe { bindings::_copy_to_iter(input.as_ptr().cast(), input.len(), self.as_raw()) }
> +    }
> +
> +    /// Utility for implementing `read_iter` given the full contents of the file.
> +    ///
> +    /// The full contents of the file being read from is represented by `contents`. This call will
> +    /// write the appropriate sub-slice of `contents` and update the file position in `ppos` so
> +    /// that the file will appear to contain `contents` even if takes multiple reads to read the
> +    /// entire file.
> +    #[inline]
> +    pub fn simple_read_from_buffer(&mut self, ppos: &mut i64, contents: &[u8]) -> Result<usize> {
> +        if *ppos < 0 {
> +            return Err(EINVAL);
> +        }
> +        let Ok(pos) = usize::try_from(*ppos) else {
> +            return Ok(0);
> +        };
> +        if pos >= contents.len() {
> +            return Ok(0);
> +        }
> +
> +        // BOUNDS: We just checked that `pos < contents.len()` above.
> +        let num_written = self.copy_to_iter(&contents[pos..]);
> +
> +        // OVERFLOW: pos+num_written <= contents.len() <= isize::MAX <= i64::MAX
> +        *ppos = (pos + num_written) as i64;
> +
> +        Ok(num_written)
> +    }
> +}


Cheers
Christian

