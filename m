Return-Path: <linux-kernel+bounces-568617-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B9158A69873
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 19:54:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4A4107A439B
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 18:53:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA5F020C469;
	Wed, 19 Mar 2025 18:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SpEhMqcq"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 295D4849C;
	Wed, 19 Mar 2025 18:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742410471; cv=none; b=IqqMWi4J4GuW/KiomGUyXma9hza8/b7lrbDK9keqEUP3C5nacQkkWAJy+U6ZJffohLIs7GOeeVXiLbOnACD3xzyFTAdqG/fTiPYRjkvTtxxx07kSHVJDzU3nbzLZb6NIPmgFpdlqJOhCcabAca8oowABuRS+rCoDeW10Hey+x64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742410471; c=relaxed/simple;
	bh=1q+Y9VsKrfJ8yBdk8fa2vQw7JVef2Si/SygyGAVdK3w=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=KoggvAJSxTe047Ajr7Qf5q8mwyWQ9muwoKXPhkHWEz4AOpekohMdfaABMs+j/L/rsqqVy/zY4HryPDbyxdA9EAsZJV/LVItaCKkXEJrIkagqqGVSTlC/LdnZmxCli02UeyIjH+OW7GN9KSoubvCwu3phWFYNytMu4/+VHCtEh+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SpEhMqcq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DEC3C4CEE9;
	Wed, 19 Mar 2025 18:54:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742410470;
	bh=1q+Y9VsKrfJ8yBdk8fa2vQw7JVef2Si/SygyGAVdK3w=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=SpEhMqcqBXfoZkEb797GDg0jcpUDhC41fpslkiy1W4je/hPixxG2Qw686gmOZqi4c
	 S94xrw309irZCGlDNDKegdt3RkARbOIDwqVNT18Q0lHPsBGR+sRPXJ4FKxYuU+XPpd
	 ncuFN58SSndE/1rn4NtM9j7xuC5uIad98Cx7KhGA/qpmeujp44EKQqt/nkZj1Ti41K
	 edR6r4oFLzQExXBnUDIiCfCdf+XkZFQlp0entzsNCcB3M3d4WsQzcHyTlWs01GyPU1
	 9Md4GMhgsOOQo17wOlprrabq6d0BQ3ez9L1E17IF56kWyvr53ZKey4eJK+bedfMNSy
	 nMAr7dxjc+UTA==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: "Alice Ryhl" <aliceryhl@google.com>
Cc: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,  "Alexander Viro"
 <viro@zeniv.linux.org.uk>,  "Arnd Bergmann" <arnd@arndb.de>,  "Miguel
 Ojeda" <ojeda@kernel.org>,  "Boqun Feng" <boqun.feng@gmail.com>,  "Gary
 Guo" <gary@garyguo.net>,  =?utf-8?Q?Bj=C3=B6rn?= Roy Baron
 <bjorn3_gh@protonmail.com>,
  "Benno Lossin" <benno.lossin@proton.me>,  "Trevor Gross"
 <tmgross@umich.edu>,  "Danilo Krummrich" <dakr@kernel.org>,  "Matthew
 Maurer" <mmaurer@google.com>,  "Lee Jones" <lee@kernel.org>,
  <linux-kernel@vger.kernel.org>,  <rust-for-linux@vger.kernel.org>
Subject: Re: [PATCH 1/5] rust: iov: add iov_iter abstractions for ITER_SOURCE
In-Reply-To: <20250311-iov-iter-v1-1-f6c9134ea824@google.com> (Alice Ryhl's
	message of "Tue, 11 Mar 2025 14:25:12 +0000")
References: <20250311-iov-iter-v1-0-f6c9134ea824@google.com>
	<v6RopSmSHmV8uiLBqkIh2II4bCry2OIo_7opQKqq2H4DftxIuRvY2YaLdhLUKw-Ndyv8MpHCgBbBEQntdLU9DQ==@protonmail.internalid>
	<20250311-iov-iter-v1-1-f6c9134ea824@google.com>
User-Agent: mu4e 1.12.7; emacs 29.4
Date: Wed, 19 Mar 2025 19:54:18 +0100
Message-ID: <871pushmw5.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Alice Ryhl" <aliceryhl@google.com> writes:

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

Don't we have some kind of `build_assert` macro to do this? If not,
maybe we should.

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

How did you arrive at this conclusion? In the discussions with Ralph on
the coherent allocator thread, we arrived at conflicting answers.

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

I don't think this safety requirement is enough. Could you give the
argument without deferring to this type in `std`?

> +unsafe impl<'data> Send for IovIterSource<'data> {}
> +// SAFETY: This struct is essentially just a fancy `std::io::Cursor<&[u8]>`, and that type is safe
> +// to share across thread boundaries.

Same as above.

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

Why?

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
> +    /// Read data from this IO vector.
> +    ///
> +    /// Returns the number of bytes that have been copied.
> +    #[inline]
> +    pub fn copy_from_iter(&mut self, out: &mut [u8]) -> usize {
> +        // SAFETY: We will not write uninitialized bytes to `out`.

You don't know what you are reading from user space. That could be
uninit bytes?

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

I'm not entirely sure about the following, so please enlighten me:

What is the `'data` here? Will it be feely assignable by the caller?
Because it's not elided to the lifetime of `&self`, right? If not, I
think the source `IovIterSouce` and associated buffers might go away
before the result of the clone dies.


Best regards,
Andreas Hindborg



