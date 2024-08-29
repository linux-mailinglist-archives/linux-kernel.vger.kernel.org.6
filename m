Return-Path: <linux-kernel+bounces-307529-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 673A6964E94
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 21:15:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1EEAE281886
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 19:15:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB8491B8E82;
	Thu, 29 Aug 2024 19:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="kPZBJh/6"
Received: from mail-4316.protonmail.ch (mail-4316.protonmail.ch [185.70.43.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D82D91B8E80;
	Thu, 29 Aug 2024 19:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724958870; cv=none; b=jark9VOsS8cuFGwzLJNYvb5jX0kvkKzUBWOY2xC1SAVR4qZZG4BkkyIkOvzX60CmKhkTNAsi9GOwkVhXw3tW80C5LYnuIyNLypNrRPxowjC/6YHKVDUUo5lYk/ctZA4xE8rR2u2CCIJHb6atjuU9SpzOodJTtIXcYZ9fBSwWPos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724958870; c=relaxed/simple;
	bh=+S/v/JXrxoRwiiJPbWsW00yHVIHkbazDZHHtQE06DzQ=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kwH+gL2NaZCbsX9YmzYZ+/4bRqkQoqLq/jfUe+OoW5LEyIh+FzmMxuCEWdN6PzK/4GXSzJ6VD7FrGOaWOZus3dhI23VFCwoTUuMGOiKD2T+/h6E7PRQDlXigYZwFq9vuicuUNDTZU6XHlBh86Y8QWPDcinvUWqR0lvPziTVQuOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=kPZBJh/6; arc=none smtp.client-ip=185.70.43.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1724958865; x=1725218065;
	bh=rSQRReVdO27pYSz1tbezXuKTcJpVLS4AVUyjhTuHuus=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=kPZBJh/6H2IHEAQ6MN8+RGFc2MfCDdvbwUwuxa7PvV0eaC7ZqNUwHpDnTF9UntnB3
	 pu2XgmSH6R193/rjim90MS2PW0Ba3z2rYnaAyvEp9Jl2JQ+5xtqbsguuhrSfrr4sQ8
	 2aj4gl1DDRV9TqpPT0gdAro2OVAbjeL1yjKRfe9xLm8Sr3ulnAdoS41GhOvDgfRDNV
	 6hrigPzynqBMHu0Qz3g7G7Qm0LCCJlVDSE8oV7xVdQ+GAVLAIh7u0OAFiVtMFL1FuI
	 G0VchCfDEQXfU+U/2TYFyKXvZ5hLU3mMQ5FaVHbE0b+fwfQEYWIWl6Loru5m+8bCir
	 kbyV1URwnUVoA==
Date: Thu, 29 Aug 2024 19:14:18 +0000
To: Danilo Krummrich <dakr@kernel.org>, ojeda@kernel.org, alex.gaynor@gmail.com, wedsonaf@gmail.com, boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com, a.hindborg@samsung.com, aliceryhl@google.com, akpm@linux-foundation.org
From: Benno Lossin <benno.lossin@proton.me>
Cc: daniel.almeida@collabora.com, faith.ekstrand@collabora.com, boris.brezillon@collabora.com, lina@asahilina.net, mcanal@igalia.com, zhiw@nvidia.com, cjia@nvidia.com, jhubbard@nvidia.com, airlied@redhat.com, ajanulgu@redhat.com, lyude@redhat.com, linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v6 22/26] rust: alloc: implement `Cmalloc` in module allocator_test
Message-ID: <e3ccbf52-224e-4869-992b-4fcaa0ec3410@proton.me>
In-Reply-To: <20240816001216.26575-23-dakr@kernel.org>
References: <20240816001216.26575-1-dakr@kernel.org> <20240816001216.26575-23-dakr@kernel.org>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: 8e16d31e33690d1f27de194ee7a7143192184df7
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 16.08.24 02:11, Danilo Krummrich wrote:
> So far the kernel's `Box` and `Vec` types can't be used by userspace
> test cases, since all users of those types (e.g. `CString`) use kernel
> allocators for instantiation.
>=20
> In order to allow userspace test cases to make use of such types as
> well, implement the `Cmalloc` allocator within the allocator_test module
> and type alias all kernel allocators to `Cmalloc`. The `Cmalloc`
> allocator uses libc's realloc() function as allocator backend.
>=20
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>
> ---
>  rust/kernel/alloc/allocator_test.rs | 178 ++++++++++++++++++++++++++--
>  1 file changed, 171 insertions(+), 7 deletions(-)
>=20
> diff --git a/rust/kernel/alloc/allocator_test.rs b/rust/kernel/alloc/allo=
cator_test.rs
> index 1b2642c547ec..7fff308d02dc 100644
> --- a/rust/kernel/alloc/allocator_test.rs
> +++ b/rust/kernel/alloc/allocator_test.rs
> @@ -2,20 +2,184 @@
>=20

Could add a short paragraph as the module description why this module
exists? Would probably be enough to paste the commit message.

>  #![allow(missing_docs)]
>=20
> -use super::{AllocError, Allocator, Flags};
> +use super::{flags::*, AllocError, Allocator, Flags};
>  use core::alloc::Layout;
> +use core::cmp;
> +use core::mem;
> +use core::ptr;
>  use core::ptr::NonNull;
>=20
> -pub struct Kmalloc;
> +pub struct Cmalloc;
> +pub type Kmalloc =3D Cmalloc;
>  pub type Vmalloc =3D Kmalloc;
>  pub type KVmalloc =3D Kmalloc;
>=20
> -unsafe impl Allocator for Kmalloc {
> +extern "C" {
> +    #[link_name =3D "aligned_alloc"]
> +    fn libc_aligned_alloc(align: usize, size: usize) -> *mut core::ffi::=
c_void;
> +
> +    #[link_name =3D "free"]
> +    fn libc_free(ptr: *mut core::ffi::c_void);
> +}
> +
> +struct CmallocData {
> +    // The actual size as requested through `Cmalloc::alloc` or `Cmalloc=
::realloc`.
> +    size: usize,
> +    // The offset from the pointer returned to the caller of `Cmalloc::a=
lloc` or `Cmalloc::realloc`
> +    // to the actual base address of the allocation.
> +    offset: usize,
> +}
> +
> +impl Cmalloc {
> +    /// Adjust the size and alignment such that we can additionally stor=
e `CmallocData` right
> +    /// before the actual data described by `layout`.
> +    ///
> +    /// Example:
> +    ///
> +    /// For `CmallocData` assume an alignment of 8 and a size of 16.
> +    /// For `layout` assume and alignment of 16 and a size of 64.

This looks like you want it rendered as bulletpoints (but it won't).

> +    ///
> +    /// 0                16               32                            =
                   96
> +    /// |----------------|----------------|-----------------------------=
-------------------|
> +    ///        empty         CmallocData                         data

Can you put this inside of '```'? Then it will render nicely in markdown
(don't forget to specify the type 'text')

> +    ///
> +    /// For this example the returned `Layout` has an alignment of 32 an=
d a size of 96.
> +    fn layout_adjust(layout: Layout) -> Result<Layout, AllocError> {
> +        let layout =3D layout.pad_to_align();
> +
> +        // Ensure that `CmallocData` fits into half the alignment. Addit=
ionally, this guarantees
> +        // that advancing a pointer aligned to `align` by `align / 2` we=
 still satisfy or exceed
> +        // the alignment requested through `layout`.
> +        let align =3D cmp::max(
> +            layout.align(),
> +            mem::size_of::<CmallocData>().next_power_of_two(),
> +        ) * 2;
> +
> +        // Add the additional space required for `CmallocData`.
> +        let size =3D layout.size() + mem::size_of::<CmallocData>();
> +
> +        Ok(Layout::from_size_align(size, align)
> +            .map_err(|_| AllocError)?
> +            .pad_to_align())
> +    }
> +
> +    fn alloc_store_data(layout: Layout) -> Result<NonNull<u8>, AllocErro=
r> {
> +        let requested_size =3D layout.size();
> +
> +        let layout =3D Self::layout_adjust(layout)?;
> +        let min_align =3D layout.align() / 2;
> +
> +        // SAFETY: Returns either NULL or a pointer to a memory allocati=
on that satisfies or
> +        // exceeds the given size and alignment requirements.
> +        let raw_ptr =3D unsafe { libc_aligned_alloc(layout.align(), layo=
ut.size()) } as *mut u8;
> +
> +        let priv_ptr =3D NonNull::new(raw_ptr).ok_or(AllocError)?;
> +
> +        // SAFETY: Advance the pointer by `min_align`. The adjustments f=
rom `Self::layout_adjust`
> +        // ensure that after this operation the original size and alignm=
ent requirements are still
> +        // satisfied or exceeded.

This SAFETY comment should address why it's OK to call `add`. You
justify something different, namely why the allocation still satisfies
the requirements of `layout`. That is something that this function
should probably guarantee.

> +        let ptr =3D unsafe { priv_ptr.as_ptr().add(min_align) };
> +
> +        // SAFETY: `min_align` is greater than or equal to the size of `=
CmallocData`, hence we
> +        // don't exceed the allocation boundaries.
> +        let data_ptr: *mut CmallocData =3D unsafe { ptr.sub(mem::size_of=
::<CmallocData>()) }.cast();
> +
> +        let data =3D CmallocData {
> +            size: requested_size,
> +            offset: min_align,
> +        };
> +
> +        // SAFETY: `data_ptr` is properly aligned and within the allocat=
ion boundaries reserved for
> +        // `CmallocData`.
> +        unsafe { data_ptr.write(data) };
> +
> +        NonNull::new(ptr).ok_or(AllocError)
> +    }
> +
> +    /// # Safety
> +    ///
> +    /// `ptr` must have been previously allocated with `Self::alloc_stor=
e_data`.

You additionally need that you have shared access to the pointee.

> +    unsafe fn data<'a>(ptr: NonNull<u8>) -> &'a CmallocData {
> +        // SAFETY: `Self::alloc_store_data` stores the `CmallocData` rig=
ht before the address
> +        // returned to callers of `Self::alloc_store_data`.
> +        let data_ptr: *mut CmallocData =3D
> +            unsafe { ptr.as_ptr().sub(mem::size_of::<CmallocData>()) }.c=
ast();
> +
> +        // SAFETY: The `CmallocData` has been previously stored at this =
offset with
> +        // `Self::alloc_store_data`.
> +        unsafe { &*data_ptr }
> +    }
> +
> +    /// # Safety
> +    ///
> +    /// This function must not be called more than once for the same all=
ocation.
> +    ///
> +    /// `ptr` must have been previously allocated with `Self::alloc_stor=
e_data`.

You additionally need that you have exclusive access to the pointee.

> +    unsafe fn free_read_data(ptr: NonNull<u8>) {
> +        // SAFETY: `ptr` has been created by `Self::alloc_store_data`.
> +        let data =3D unsafe { Self::data(ptr) };
> +
> +        // SAFETY: `ptr` has been created by `Self::alloc_store_data`.
> +        let priv_ptr =3D unsafe { ptr.as_ptr().sub(data.offset) };
> +
> +        // SAFETY: `priv_ptr` has previously been allocatored with this =
`Allocator`.
> +        unsafe { libc_free(priv_ptr.cast()) };
> +    }
> +}
> +
> +unsafe impl Allocator for Cmalloc {
> +    fn alloc(layout: Layout, flags: Flags) -> Result<NonNull<[u8]>, Allo=
cError> {
> +        if layout.size() =3D=3D 0 {
> +            return Ok(NonNull::slice_from_raw_parts(NonNull::dangling(),=
 0));
> +        }
> +
> +        let ptr =3D Self::alloc_store_data(layout)?;
> +
> +        if flags.contains(__GFP_ZERO) {
> +            // SAFETY: `Self::alloc_store_data` guarantees that `ptr` po=
ints to memory of at least
> +            // `layout.size()` bytes.
> +            unsafe { ptr.as_ptr().write_bytes(0, layout.size()) };
> +        }

This makes me wonder, what other flags should we handle for this
allocator?

> +
> +        Ok(NonNull::slice_from_raw_parts(ptr, layout.size()))
> +    }
> +
>      unsafe fn realloc(
> -        _ptr: Option<NonNull<u8>>,
> -        _layout: Layout,
> -        _flags: Flags,
> +        ptr: Option<NonNull<u8>>,
> +        layout: Layout,
> +        flags: Flags,
>      ) -> Result<NonNull<[u8]>, AllocError> {
> -        panic!();
> +        let src: NonNull<u8> =3D if let Some(src) =3D ptr {
> +            src.cast()

Why the cast?

> +        } else {
> +            return Self::alloc(layout, flags);
> +        };

You should be able to write this instead:

    let Some(src) =3D ptr else {
        return Self::alloc(layout, flags);
    };

> +
> +        if layout.size() =3D=3D 0 {
> +            // SAFETY: `src` has been created by `Self::alloc_store_data=
`.

This is not true, consider:

    let ptr =3D alloc(size =3D 0);
    free(ptr)

Alloc will return a dangling pointer due to the first if statement and
then this function will pass it to `free_read_data`, even though it
wasn't created by `alloc_store_data`.
This isn't forbidden by the `Allocator` trait function's safety
requirements.

> +            unsafe { Self::free_read_data(src) };
> +
> +            return Ok(NonNull::slice_from_raw_parts(NonNull::dangling(),=
 0));
> +        }
> +
> +        let dst =3D Self::alloc(layout, flags)?;
> +
> +        // SAFETY: `src` has been created by `Self::alloc_store_data`.
> +        let data =3D unsafe { Self::data(src) };

Same issue here, if the allocation passed in is zero size. I think you
have no other choice than to allocate even for zero size requests...
Otherwise how would you know that they are zero-sized.

---
Cheers,
Benno

> +
> +        // SAFETY: `src` has previously been allocated with this `Alloca=
tor`; `dst` has just been
> +        // newly allocated. Copy up to the smaller of both sizes.
> +        unsafe {
> +            ptr::copy_nonoverlapping(
> +                src.as_ptr(),
> +                dst.as_ptr().cast(),
> +                cmp::min(layout.size(), data.size),
> +            )
> +        };
> +
> +        // SAFETY: `src` has been created by `Self::alloc_store_data`.
> +        unsafe { Self::free_read_data(src) };
> +
> +        Ok(dst)
>      }
>  }
> --
> 2.46.0
>=20


