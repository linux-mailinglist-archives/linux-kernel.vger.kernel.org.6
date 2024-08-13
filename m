Return-Path: <linux-kernel+bounces-284200-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 329E394FE65
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 09:08:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE09E284F94
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 07:08:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E89A46522;
	Tue, 13 Aug 2024 07:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="ROdq3i8o"
Received: from mail-40134.protonmail.ch (mail-40134.protonmail.ch [185.70.40.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 823322E416
	for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 07:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723532882; cv=none; b=MrFPrDd1IG+jwxIwgxNevBIjrWDkR76pHjxE8XIFW4UHPsnWcyNHnFWxeTvBH1nXe4Z5iP6gxIvPN/vcZlhBVTWKj8Ay+JJEld4rPbg0DmweCgpfGCxu/gkx/qx1yWUxJ4mNFoE9NUY7GwzkjgVTUKCalrNHgGEh7kP021rXTFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723532882; c=relaxed/simple;
	bh=CKiEzcNiSzJ5SMT2Tecd7+fK0cL6q6Fdizj3flMFZ/s=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SSN2r82Vzo4EVjtGcYWVhqqlpTPVAfivJLnza0fW9n7oqPcmQcBYDRxM5Dk6mosy/mjFcDMXwD/1Prp6QlRJT0KREMMeBVtITSwwWfAzTQAAHYjkDvIwEjdLSbOnKecsQ9pDeRP/LIRWwhED2ErcKtgDkUcQ0aNo8PbYyBewx0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com; spf=pass smtp.mailfrom=protonmail.com; dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b=ROdq3i8o; arc=none smtp.client-ip=185.70.40.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1723532872; x=1723792072;
	bh=T5x8NVZw/qsD8mpPBKY64eVeJFmEgIuSLK51Dio3QRo=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=ROdq3i8oyW4DuG2cEJVbg9ixccGOIHOqyHQ+8+gAz4cUg9skH/VjJMtkQ1y+JEkjb
	 HmXO5/ymK8VQGVcoLJTWi+F7HltLyTLYJgnd8MSHPRicaUeVrRteRk6oDIzZYrfBIg
	 EUf7JGIgszfzZdgjwuXYMOb6kdaoKKP3/4Uuyihd+u95nrkdlvd86c51DAyRoB1PZy
	 iSLWqb0BvOQ9hcWxREFrlcVyhQfk2kDu6rCO36oTgfQqa0O0Zat56FgThbxQ/rPjlr
	 K6RoeB4qAdT/CK+u177coHtd3VcUNRzKNf+YtGi3HLYC8khANg7dFQ7E3YWca62G77
	 CTIIA7b+fAI0Q==
Date: Tue, 13 Aug 2024 07:07:46 +0000
To: Danilo Krummrich <dakr@kernel.org>, ojeda@kernel.org, alex.gaynor@gmail.com, wedsonaf@gmail.com, boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com, benno.lossin@proton.me, a.hindborg@samsung.com, aliceryhl@google.com, akpm@linux-foundation.org
From: Heghedus Razvan <heghedus.razvan@protonmail.com>
Cc: daniel.almeida@collabora.com, faith.ekstrand@collabora.com, boris.brezillon@collabora.com, lina@asahilina.net, mcanal@igalia.com, zhiw@nvidia.com, cjia@nvidia.com, jhubbard@nvidia.com, airlied@redhat.com, ajanulgu@redhat.com, lyude@redhat.com, linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v5 22/26] rust: alloc: implement `Cmalloc` in module allocator_test
Message-ID: <D3ELEO3QFEZQ.2X1WF8Y3IVNQ0@protonmail.com>
In-Reply-To: <20240812182355.11641-23-dakr@kernel.org>
References: <20240812182355.11641-1-dakr@kernel.org> <20240812182355.11641-23-dakr@kernel.org>
Feedback-ID: 1233518:user:proton
X-Pm-Message-ID: ed9c6c2815a3741e3af224b54093291a3cbededc
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Mon Aug 12, 2024 at 9:23 PM EEST, Danilo Krummrich wrote:
> So far the kernel's `Box` and `Vec` types can't be used by userspace
> test cases, since all users of those types (e.g. `CString`) use kernel
> allocators for instantiation.
>
> In order to allow userspace test cases to make use of such types as
> well, implement the `Cmalloc` allocator within the allocator_test module
> and type alias all kernel allocators to `Cmalloc`. The `Cmalloc`
> allocator uses libc's realloc() function as allocator backend.
>
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>
> ---
> I know, having an `old_size` parameter would indeed help implementing `Cm=
alloc`.
>
> However, I really don't want test infrastructure to influence the design =
of
> kernel internal APIs.
>
> It's on the test infrastructure to find a way to deal with it, even if it=
's more
> complicated.
> ---
>  rust/kernel/alloc/allocator_test.rs | 175 ++++++++++++++++++++++++++--
>  1 file changed, 168 insertions(+), 7 deletions(-)
>
> diff --git a/rust/kernel/alloc/allocator_test.rs b/rust/kernel/alloc/allo=
cator_test.rs
> index 1b2642c547ec..7a20e64431ea 100644
> --- a/rust/kernel/alloc/allocator_test.rs
> +++ b/rust/kernel/alloc/allocator_test.rs
> @@ -2,20 +2,181 @@
>
>  #![allow(missing_docs)]
>
> -use super::{AllocError, Allocator, Flags};
> +use super::{flags::*, AllocError, Allocator, Flags};
>  use core::alloc::Layout;
> +use core::cmp;
> +use core::mem;
> +use core::ptr;
>  use core::ptr::NonNull;
>
> -pub struct Kmalloc;
> +pub struct Cmalloc;
> +pub type Kmalloc =3D Cmalloc;
>  pub type Vmalloc =3D Kmalloc;
>  pub type KVmalloc =3D Kmalloc;
>
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
> +    ///
> +    /// 0                16               32                            =
                   96
> +    /// |----------------|----------------|-----------------------------=
-------------------|
> +    ///        empty         CmallocData                         data
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
> +        } else {
> +            return Self::alloc(layout, flags);
> +        };
> +
> +        if layout.size() =3D=3D 0 {
> +            // SAFETY: `src` has been created by `Self::alloc_store_data=
`.
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
At this point should we free the src? Or is the original pointer expected t=
o remain valid?

> +        Ok(dst)
>      }
>  }
> --
> 2.45.2



