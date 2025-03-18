Return-Path: <linux-kernel+bounces-566873-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C94C2A67DC8
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 21:11:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 269551663C4
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 20:11:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D08FF21149C;
	Tue, 18 Mar 2025 20:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KJrhF322"
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 137D81F3BBF;
	Tue, 18 Mar 2025 20:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742328654; cv=none; b=sA42MQqLngM0l2eAM7Su9GSGXc6ZU2/UIk/DrP3kAYgAuWEMxZxtXPSgPdQoDfELjoRz9/o5WERwqiG/Loxnt6K3aYwS591wYGLrbIYjuocFZGdhhvVSJkH7l5imm36PQ3TLDSlKMhDBsegs7RIjwe6IKeULIuRa4NHJBlclcU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742328654; c=relaxed/simple;
	bh=MuOtSCFgT6oU2AfS4IrhM0OgvY3M4O39QSynVA19Lr0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sa+Phar+DRnsI+F63vbDkwCbUp4GjfMtjqOKvMrY350+CaJ/fNuYClauTZ6/UuMMLWPlw046sSTxX/XoabRn5euCJAxSUfzdoXB+FlJebLKNGBtk4v3YHMfFTL3pUnovgJgAKsoBAyvUs1EPIfz54Ob6wY/Y/NwROGSSKEo+66s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KJrhF322; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5e5cded3e2eso8794753a12.0;
        Tue, 18 Mar 2025 13:10:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742328650; x=1742933450; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mY0uTsE5W1MbRnFgT/d+FEqF/DZDYn9yCiKZzqzSmlc=;
        b=KJrhF322O0aN7CreZTdZD/fS1dhO+GAKkqrZQelIRyBsVWqwewyrUF95VcA4rxokLq
         pxk3mEBWfPv9a/7godxBwzgjbvE1n/+t/6TMioJDP4Uh7YEVNqzITKACex1+LDGC93x6
         fPJesJM+SPMIrT7DQJUVxGLBdKlTYx8mKe4gxDwEIzbpSHXyyeAqzG8pD0E2PYg+ssjP
         1MgRzPYTzat6oRpL/uVL9Juh9UaFRXDIsctGE2DnJLeuI5M5Ct5FjcMAlh8rQdycqbnt
         +AJMIMQoczrZF1UEqfUUVqVb4vMn/CH3ZsXyEiPFexL3efplFd9//W8zdzEZeKs9tlZY
         B7IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742328650; x=1742933450;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mY0uTsE5W1MbRnFgT/d+FEqF/DZDYn9yCiKZzqzSmlc=;
        b=gePiDWxdTuuGuwUuIWStyBqvRj1yxza0du+igILcMTHxlcGRH6mAPfXGXcFOYTEI5J
         J8t48KQLKHyGyDMyDUASIWIdOUEUO5V8zmigztyiDp9utzbtM7XN7Jqse2Y/WM+fuswK
         EVvNYrv2R5WQJQt7p+gpy2w575qw/mqUuJTtL8imaCtYrMuTYQ0S3CKt9lCQpNX07cem
         c6ElqUpmFsFufglwIGCR1uwY46q+/c55G3kNQ2Fx0r6iIrK5FsQb4QNvErI8X9H0842P
         5xmvjYKYnizeLAFooDuvHPlNt/l8Jhpmj22QQ5tOFVs8oYyAEoD/vyuT8UDrgjV+S83w
         5bOg==
X-Forwarded-Encrypted: i=1; AJvYcCV2KabocyGexbNjV2h61RQpJVhNQXHoiyW3JP/WYwjuOpLReDENubzK5XDk2518UKySHMS+Z/1uZKVTsTMHJkA=@vger.kernel.org, AJvYcCWrXS3Z1djUbmcOIRVqhrkWY/iZZkmY68j96kT2gOHLVSFfWw2r1uTKPwAvndKnRelvWDciJMSfNgJAc0A=@vger.kernel.org
X-Gm-Message-State: AOJu0YyEkbTcom6XtqXCj7Lef61tDnp3Crx8jRgdtxlGtMfqZACiIvAL
	52ag3teAXEgMrZM+aP56yA2k/oN6g6ualwSGLEclIZxmZgk1QoO2
X-Gm-Gg: ASbGncsLlj+ITIzCMIOesJwQCNA9QCaGZi0yfAJ+7Zi4qgJvRHp+OniLlNVfkxV0GsG
	REjlohQZ15JT7OaTdY8UNm7pBL2L5lh/tHqiGK+CtXSe5wd43L+doDvzaFJXp2oQ141F38hx88g
	zOqdzqjrlyDfoOnw1yft1pHg2Vnhpz9w/N/QcSWueA96m5TMrWBkmBEetn9aPTBQdQhBII4mstq
	WK1KL43eemMr4D+NF2umgLP2ciDr2hX5QReGt9D6w0nH0LHkNslqN/GmJ7gG/iNDjuX5D1zvJKn
	U+MUZGXpxW6bnYAs8X9wArNMpteJT3rPi1S3ktRu9+9Fj4i3qpaVhr4r69HXy/4egKRSl84kB3M
	aKu/1kiio
X-Google-Smtp-Source: AGHT+IFWib8MSZ6xi4u+fbeJ9cQuBQYTxvfhxqqj+550jUZ+pU7bmki+LtZfhKd/IZwPgZ0RpKwGhw==
X-Received: by 2002:a05:6402:348b:b0:5e4:a88a:64e with SMTP id 4fb4d7f45d1cf-5eb80cdc9d9mr55922a12.5.1742328649944;
        Tue, 18 Mar 2025 13:10:49 -0700 (PDT)
Received: from [10.1.1.5] (93-82-55-26.adsl.highway.telekom.at. [93.82.55.26])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5e816ad394fsm8380457a12.58.2025.03.18.13.10.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Mar 2025 13:10:49 -0700 (PDT)
Message-ID: <123de698-190f-460c-af8c-e51bcd948c0f@gmail.com>
Date: Tue, 18 Mar 2025 21:10:47 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] rust: iov: add iov_iter abstractions for ITER_SOURCE
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
 <20250311-iov-iter-v1-1-f6c9134ea824@google.com>
Content-Language: en-US, de-DE
From: Christian Schrefl <chrisi.schrefl@gmail.com>
In-Reply-To: <20250311-iov-iter-v1-1-f6c9134ea824@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Alice

On 11.03.25 3:25 PM, Alice Ryhl wrote:
> This adds abstractions for the iov_iter type in the case where
> data_source is ITER_SOURCE. This will make Rust implementations of
> fops->write_iter possible.
> 
> This series only has support for using existing IO vectors created by C
> code. Additional abstractions will be needed to support the creation of
> IO vectors in Rust code.
> 
> These abstractions make the assumption that `struct iov_iter` does not
> have internal self-references, which implies that it is valid to move it
> between different local variables, and that you can make a copy of it to
> get two IO vectors into the same buffers.

Would it make sense to add comments in the C side `struct iov_iter` for
these assumptions?

> 
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>
> ---
>  rust/kernel/iov.rs | 170 +++++++++++++++++++++++++++++++++++++++++++++++++++++
>  rust/kernel/lib.rs |   1 +
>  2 files changed, 171 insertions(+)
> 
> diff --git a/rust/kernel/iov.rs b/rust/kernel/iov.rs
> new file mode 100644
> index 0000000000000000000000000000000000000000..4498f65e1f65bd964909810c020db3a9f8fae389
> --- /dev/null
> +++ b/rust/kernel/iov.rs
> @@ -0,0 +1,170 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +// Copyright (C) 2025 Google LLC.
> +
> +//! IO vectors.
> +//!
> +//! C headers: [`include/linux/iov_iter.h`](srctree/include/linux/iov_iter.h),
> +//! [`include/linux/uio.h`](srctree/include/linux/uio.h)
> +
> +use crate::{bindings, prelude::*, types::Opaque};
> +use core::{marker::PhantomData, mem::MaybeUninit, slice};
> +
> +const ITER_SOURCE: bool = bindings::ITER_SOURCE != 0;
> +const ITER_DEST: bool = bindings::ITER_DEST != 0;
> +
> +// Compile-time assertion for the above constants.
> +const _: () = {
> +    if ITER_SOURCE == ITER_DEST {
> +        panic!("ITER_DEST and ITER_SOURCE should be different.");
> +    }
> +};
> +
> +/// An IO vector that acts as a source of data.
> +///
> +/// # Invariants
> +///
> +/// Must hold a valid `struct iov_iter` with `data_source` set to `ITER_SOURCE`. The buffers
> +/// referenced by the IO vector must be valid for reading for the duration of `'data`.
> +///
> +/// Note that if the IO vector is backed by a userspace pointer, it is always considered valid for
> +/// reading.
> +#[repr(transparent)]
> +pub struct IovIterSource<'data> {
> +    iov: Opaque<bindings::iov_iter>,
> +    /// Represent to the type system that this value contains a pointer to readable data it does
> +    /// not own.
> +    _source: PhantomData<&'data [u8]>,
> +}
> +
> +// SAFETY: This struct is essentially just a fancy `std::io::Cursor<&[u8]>`, and that type is safe
> +// to send across thread boundaries.
> +unsafe impl<'data> Send for IovIterSource<'data> {}
> +// SAFETY: This struct is essentially just a fancy `std::io::Cursor<&[u8]>`, and that type is safe
> +// to share across thread boundaries.
> +unsafe impl<'data> Sync for IovIterSource<'data> {}
> +
> +impl<'data> IovIterSource<'data> {
> +    /// Obtain an `IovIterSource` from a raw pointer.
> +    ///
> +    /// # Safety
> +    ///
> +    /// * For the duration of `'iov`, the `struct iov_iter` must remain valid and must not be
> +    ///   accessed except through the returned reference.
> +    /// * For the duration of `'data`, the buffers backing this IO vector must be valid for
> +    ///   reading.
> +    #[track_caller]
> +    #[inline]
> +    pub unsafe fn from_raw<'iov>(ptr: *mut bindings::iov_iter) -> &'iov mut IovIterSource<'data> {
> +        // SAFETY: The caller ensures that `ptr` is valid.
> +        let data_source = unsafe { (*ptr).data_source };
> +        assert_eq!(data_source, ITER_SOURCE);
> +
> +        // SAFETY: The caller ensures the struct invariants for the right durations.
> +        unsafe { &mut *ptr.cast::<IovIterSource<'data>>() }
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

Maybe add a C helper to avoid having to use '__bindgen_anon_1'?

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
> +    /// Read data from this IO vector.
> +    ///
> +    /// Returns the number of bytes that have been copied.
> +    #[inline]
> +    pub fn copy_from_iter(&mut self, out: &mut [u8]) -> usize {
> +        // SAFETY: We will not write uninitialized bytes to `out`.
> +        let out = unsafe { &mut *(out as *mut [u8] as *mut [MaybeUninit<u8>]) };
> +
> +        self.copy_from_iter_raw(out).len()
> +    }
> +
> +    /// Read data from this IO vector and append it to a vector.
> +    ///
> +    /// Returns the number of bytes that have been copied.
> +    #[inline]
> +    pub fn copy_from_iter_vec<A: Allocator>(
> +        &mut self,
> +        out: &mut Vec<u8, A>,
> +        flags: Flags,
> +    ) -> Result<usize> {
> +        out.reserve(self.len(), flags)?;
> +        let len = self.copy_from_iter_raw(out.spare_capacity_mut()).len();
> +        // SAFETY: The next `len` bytes of the vector have been initialized.
> +        unsafe { out.set_len(out.len() + len) };
> +        Ok(len)
> +    }
> +
> +    /// Read data from this IO vector into potentially uninitialized memory.
> +    ///
> +    /// Returns the sub-slice of the output that has been initialized. If the returned slice is
> +    /// shorter than the input buffer, then the entire IO vector has been read.
> +    #[inline]
> +    pub fn copy_from_iter_raw(&mut self, out: &mut [MaybeUninit<u8>]) -> &mut [u8] {
> +        // SAFETY: `out` is valid for `out.len()` bytes.
> +        let len =
> +            unsafe { bindings::_copy_from_iter(out.as_mut_ptr().cast(), out.len(), self.as_raw()) };
> +
> +        // SAFETY: We just initialized the first `len` bytes of `out`.
> +        unsafe { slice::from_raw_parts_mut(out.as_mut_ptr().cast(), len) }
> +    }
> +}
> +
> +impl<'data> Clone for IovIterSource<'data> {
> +    #[inline]
> +    fn clone(&self) -> IovIterSource<'data> {
> +        // SAFETY: This duplicates the bytes inside the `Opaque` value exactly. Since `struct
> +        // iov_iter` does not have any internal self references, that is okay.
> +        //
> +        // Since this IO vector only reads from the backing buffers, having multiple IO vectors to
> +        // the same source can't lead to data races on the backing buffers.
> +        unsafe { core::ptr::read(self) }
> +    }
> +}
> diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
> index 398242f92a961c3a445d681c65449047a847968a..de9d6e797953cb69637eef127997b1f357f3f90b 100644
> --- a/rust/kernel/lib.rs
> +++ b/rust/kernel/lib.rs
> @@ -53,6 +53,7 @@
>  pub mod init;
>  pub mod io;
>  pub mod ioctl;
> +pub mod iov;
>  pub mod jump_label;
>  #[cfg(CONFIG_KUNIT)]
>  pub mod kunit;
> 

Cheers
Christian


