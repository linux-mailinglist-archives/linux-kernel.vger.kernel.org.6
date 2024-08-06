Return-Path: <linux-kernel+bounces-276556-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B2A394953A
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 18:06:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AC6671F2583B
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 16:06:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18B233C08A;
	Tue,  6 Aug 2024 16:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="HOfVHbYE"
Received: from mail-4316.protonmail.ch (mail-4316.protonmail.ch [185.70.43.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D293D15CB;
	Tue,  6 Aug 2024 16:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722960241; cv=none; b=TTsLt6RRD6/6izhQfvhhcYCREd+kUmjTNri4VhycjWsoEn016u6gUydu9lp+XX+RoAXj5ROAHtlwO9hJEkvrthJ7SHg0uJtBb4hPOvX2X/5mME5KWlwaWxloo1H+fn9/CcwnvhQawGHAS0eiP67iJahaXJNNb4t1BsmoQ1/Y0Uk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722960241; c=relaxed/simple;
	bh=k0tOVGYJ2n9MFoo5jwcKLkuAD0PT9GDLWfjKmKs/RHY=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KLprvJjocjEM3mxsY7m2nWnB2qf7nvB0k7w1iGdFgcS3KRnj3Ueuadw5qGxx7EYlWRXhrbKGFd44/o07O+I1jsBJw6naJJ5IldDo6q/HbaVxm1A4RXGUVikIaI54IpTKTftpsRiUzf3MYZF5lEHQE1eSGEA16Da8zesPf4IUNQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=HOfVHbYE; arc=none smtp.client-ip=185.70.43.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=xju4hktstrby3iwr73rebshaee.protonmail; t=1722960236; x=1723219436;
	bh=S/XzYL9OYUvsdAXy34uRW7jYo0ZLNghR29paIaLIkrM=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=HOfVHbYEocUjFUnqXjTb1mAmOOFX7mF/+vPjl13CfX9lE13Dpt1ri8YJmwCmPOD/y
	 GI4gDQwACQlij+AkAR9QPE8TKDFFhe54yuCbFK5K42MNLhEDYZZnUr5cTSEsHAtfje
	 p4JKNc8NglKIbYJhM5GpRR4yUPgYdreLMCVnh3BLsKZgld70knIivw7qfDltSRWs5K
	 NlMHs8ddNexY65mw2yhvgyvFXXlykBSDAyvo2Eedf3wYh5CpDh1n6WqBQgH1uJTqKM
	 KxoZXhQO8YlgEQZn4HF3uXpwKqjg1PaDV05CF9o8+SUbwXMY792zrWyQYzZTFsnZOQ
	 jkZWMrrY7B0Tg==
Date: Tue, 06 Aug 2024 16:03:49 +0000
To: Danilo Krummrich <dakr@kernel.org>, ojeda@kernel.org, alex.gaynor@gmail.com, wedsonaf@gmail.com, boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com, a.hindborg@samsung.com, aliceryhl@google.com, akpm@linux-foundation.org
From: Benno Lossin <benno.lossin@proton.me>
Cc: daniel.almeida@collabora.com, faith.ekstrand@collabora.com, boris.brezillon@collabora.com, lina@asahilina.net, mcanal@igalia.com, zhiw@nvidia.com, acurrid@nvidia.com, cjia@nvidia.com, jhubbard@nvidia.com, airlied@redhat.com, ajanulgu@redhat.com, lyude@redhat.com, linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v4 01/28] rust: alloc: add `Allocator` trait
Message-ID: <470b5f70-b592-43a7-81ba-c7f1c852b9f3@proton.me>
In-Reply-To: <20240805152004.5039-2-dakr@kernel.org>
References: <20240805152004.5039-1-dakr@kernel.org> <20240805152004.5039-2-dakr@kernel.org>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: fad6beb5255ffe4da875a8202e88a00e79e1da8b
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 05.08.24 17:19, Danilo Krummrich wrote:
> Add a kernel specific `Allocator` trait, that in contrast to the one in
> Rust's core library doesn't require unstable features and supports GFP
> flags.
>=20
> Subsequent patches add the following trait implementors: `Kmalloc`,
> `Vmalloc` and `KVmalloc`.
>=20
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>
> ---
>  rust/kernel/alloc.rs | 79 ++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 79 insertions(+)
>=20
> diff --git a/rust/kernel/alloc.rs b/rust/kernel/alloc.rs
> index 1966bd407017..8a71a589469d 100644
> --- a/rust/kernel/alloc.rs
> +++ b/rust/kernel/alloc.rs
> @@ -11,6 +11,7 @@
>  /// Indicates an allocation error.
>  #[derive(Copy, Clone, PartialEq, Eq, Debug)]
>  pub struct AllocError;
> +use core::{alloc::Layout, ptr::NonNull};
>=20
>  /// Flags to be used when allocating memory.
>  ///
> @@ -86,3 +87,81 @@ pub mod flags {
>      /// small allocations.
>      pub const GFP_NOWAIT: Flags =3D Flags(bindings::GFP_NOWAIT);
>  }
> +
> +/// The kernel's [`Allocator`] trait.
> +///
> +/// An implementation of [`Allocator`] can allocate, re-allocate and fre=
e memory buffer described
> +/// via [`Layout`].
> +///
> +/// [`Allocator`] is designed to be implemented as a ZST; [`Allocator`] =
functions do not operate on
> +/// an object instance.

This will prevent us from implementing arena-type allocators [^1]. Do we
want/need those?
I have heard that some people use them in embedded systems, but I can't=20
say for sure. But this is a rather big design decision, so we should
discuss it now.

[^1]: For those who don't know what I mean by that here is a quick
sketch (without handling flags and optimizations):

    pub struct ArenaAlloc<const SIZE: usize> {
        memory: Opaque<[u8; SIZE]>,
        head: Cell<usize>,
    }

    impl<const SIZE: usize> ArenaAlloc<SIZE> {
        pub fn new() -> Self {
            Self {
                memory: Opaque::uninit(),
                head: 0,
            }
        }
    }

    impl<const SIZE: usize> Allocator for ArenaAlloc<SIZE> {
        fn alloc(&self, layout: Layout, _flags: Flags) -> Result<NonNull<u8=
>, AllocError> {
            let head =3D self.head.get();
            if head + layout.size() >=3D SIZE {
                return Err(AllocError);
            }
            let ptr =3D self.memory.get();
            let ptr =3D ptr.cast::<u8>();
            let ptr =3D unsafe { ptr.add(head) };
            self.head.set(head + layout.size());
            unsafe { NonNull::new_unchecked(ptr) }
        }

        unsafe fn realloc(
            &self,
            ptr: Option<NonNull<u8>>,
            old_layout: Layout, // Note that we also need `old_layout`!
            layout: Layout,
            flags: Flags
        ) -> Result<NonNull<u8>, AllocError> {
            let new =3D self.alloc(layout, flags)?;
            let Some(ptr) =3D ptr else { return Ok(new); };
            unsafe { core::ptr::copy_nonoverlapping(ptr.as_ptr(), new.as_pt=
r(), old_layout.size()) };
            self.free(ptr);
            Ok(new)
        }

        fn free(&self, ptr: NonNull<u8>) { /* noop */ }
    }

> +///
> +/// In order to be able to support `#[derive(SmartPointer)]` later on, w=
e need to avoid a design
> +/// that requires an `Allocator` to be instantiated, hence its functions=
 must not contain any kind
> +/// of `self` parameter.

Ah I see, so since `#[derive(SmartPointer)]` needs `Box` to only consist
of one non ZST field... I skimmed the RFC discussion and it seems like a
problem that *might* be solved in the future, but probably not in the
(very) near future. I guess this is just a bullet that we have to bite.
We can always have an `ArenaBox` that can deal with that (although
without `DispatchFromDyn`).
We should revisit this when `#[derive(SmartPointer)]` becomes advanced
enough.

> +///
> +/// # Safety
> +///
> +/// Memory returned from an allocator must point to a valid memory buffe=
r and remain valid until
> +/// it is explicitly freed.
> +///
> +/// Any pointer to a memory buffer which is currently allocated must be =
valid to be passed to any
> +/// other [`Allocator`] function of the same type. The same applies for =
a NULL pointer.
> +///
> +/// If `realloc` is called with:
> +///   - a size of zero, the given memory allocation, if any, must be fre=
ed
> +///   - a NULL pointer, a new memory allocation must be created
> +pub unsafe trait Allocator {
> +    /// Allocate memory based on `layout` and `flags`.
> +    ///
> +    /// On success, returns a buffer represented as `NonNull<[u8]>` that=
 satisfies the layout
> +    /// constraints (i.e. minimum size and alignment as specified by `la=
yout`).
> +    ///
> +    /// This function is equivalent to `realloc` when called with a NULL=
 pointer.
> +    fn alloc(layout: Layout, flags: Flags) -> Result<NonNull<[u8]>, Allo=
cError> {
> +        // SAFETY: Passing a NULL pointer to `realloc` is valid by it's =
safety requirements and asks
> +        // for a new memory allocation.
> +        unsafe { Self::realloc(None, layout, flags) }
> +    }
> +
> +    /// Re-allocate an existing memory allocation to satisfy the request=
ed `layout`. If the
> +    /// requested size is zero, `realloc` behaves equivalent to `free`.
> +    ///
> +    /// If the requested size is larger than the size of the existing al=
location, a successful call
> +    /// to `realloc` guarantees that the new or grown buffer has at leas=
t `Layout::size` bytes, but
> +    /// may also be larger.
> +    ///
> +    /// If the requested size is smaller than the size of the existing a=
llocation, `realloc` may or
> +    /// may not shrink the buffer; this is implementation specific to th=
e allocator.
> +    ///
> +    /// On allocation failure, the existing buffer, if any, remains vali=
d.
> +    ///
> +    /// The buffer is represented as `NonNull<[u8]>`.
> +    ///
> +    /// # Safety
> +    ///
> +    /// `Some(ptr)` must point to an existing and valid memory allocatio=
n created by this allocator

This is the wrong way around, `ptr: Option<NonNull<u8>>`, so
`Some(ptr): Option<Option<NonNull<u8>>>`. Instead I would write
"If `ptr =3D Some(p)`, then `p` must point to...".

> +    /// instance. The alignment encoded in `layout` must be smaller than=
 or equal to the alignment
> +    /// requested in the previous `alloc` or `realloc` call of the same =
allocation.
> +    ///
> +    /// Additionally, `ptr` is allowed to be `None`; in this case a new =
memory allocation is
> +    /// created.
> +    ///
> +    unsafe fn realloc(
> +        ptr: Option<NonNull<u8>>,
> +        layout: Layout,
> +        flags: Flags,
> +    ) -> Result<NonNull<[u8]>, AllocError>;
> +
> +    /// Free an existing memory allocation.
> +    ///
> +    /// # Safety
> +    ///
> +    /// `ptr` must point to an existing and valid memory allocation crea=
ted by this `Allocator`
> +    /// instance.

Additionally, you need "The memory allocation at `ptr` must never again
be read from or written to.".

---
Cheers,
Benno

> +    unsafe fn free(ptr: NonNull<u8>) {
> +        // SAFETY: `ptr` is guaranteed to be previously allocated with t=
his `Allocator` or NULL.
> +        // Calling `realloc` with a buffer size of zero, frees the buffe=
r `ptr` points to.
> +        let _ =3D unsafe { Self::realloc(Some(ptr), Layout::new::<()>(),=
 Flags(0)) };
> +    }
> +}
> --
> 2.45.2
>=20


