Return-Path: <linux-kernel+bounces-286835-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A2AF951FBC
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 18:22:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B1AB8B2B0D2
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 16:13:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F6461B9B21;
	Wed, 14 Aug 2024 16:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="PnrlFts0"
Received: from mail-40133.protonmail.ch (mail-40133.protonmail.ch [185.70.40.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60D6E1B9B31;
	Wed, 14 Aug 2024 16:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723652002; cv=none; b=mUUw0roJg7x2RkFcu1073Qrr1lW7m2En8wwjzRhdJRPrLs946s+shLbGkLgXryG+SnRP1mwXdEItT9BD1BveUWInGxdSDmkI3okdH+0csR/rBPjVd7eSTdMRJBJkhvntrzPyPWLDKEqPa3Yjh+FPKjp8NHDEMER7VuzzAbavVrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723652002; c=relaxed/simple;
	bh=xQ3lmrQxhKeZFgf+yik63kyuhH+PVnGed45rUs5piSo=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SoXLhstpje0++uOLgWstf/O3nBAx6DO0ZsYQqC/3buFoKCDHlk73d3ZN8Pd4Olt11/g4WMCDEfhREwlyV4JCWyUdYFUR3ccFoQxiQuThYqyjSZ9LjeAaoj/EiztptwkUyAK4Zf+kjcQexovKwL9LvSgQwE+qa26Ls+TZr++t3Vk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=PnrlFts0; arc=none smtp.client-ip=185.70.40.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1723651992; x=1723911192;
	bh=xgUscqXXYtwDOlu+dM+bPEi3GjHXvIJyy7e+gW0dRD4=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=PnrlFts0ErI2yAsgLbggDypo8LPX0CsBWM7jblway8hx9km1tTfFUaQ8/tgYSgXbU
	 Xr6+zR7yeeVC6O3jQnvDemt6RG9VhF/AwtA3W7iyP6Sl5rVjWrXORnjx6p9Bc9Jf5l
	 AUwzdKcQMtBToxeOu7IkfkNdcOHpRvOSn6t9YjA/hsnEf8NZUhBa39piN/GQIf3IX5
	 7hs6SfbTPTKsbS+DFT1yqbHUXKGiph/KTAh76MJyjxmb1s+WlwXtXh+ZPmR7QquAAG
	 VDfPfbh77RXjuzyWk4WzedXZFUENsQoO//7adD7XhNHRu9Xf4RCmIfSRHJ+BQFtB9h
	 yK0v8+u166dTw==
Date: Wed, 14 Aug 2024 16:13:06 +0000
To: Danilo Krummrich <dakr@kernel.org>, ojeda@kernel.org, alex.gaynor@gmail.com, wedsonaf@gmail.com, boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com, a.hindborg@samsung.com, aliceryhl@google.com, akpm@linux-foundation.org
From: Benno Lossin <benno.lossin@proton.me>
Cc: daniel.almeida@collabora.com, faith.ekstrand@collabora.com, boris.brezillon@collabora.com, lina@asahilina.net, mcanal@igalia.com, zhiw@nvidia.com, cjia@nvidia.com, jhubbard@nvidia.com, airlied@redhat.com, ajanulgu@redhat.com, lyude@redhat.com, linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v5 01/26] rust: alloc: add `Allocator` trait
Message-ID: <cfcdaa42-6a62-4a17-a8dc-2382e88774dc@proton.me>
In-Reply-To: <20240812182355.11641-2-dakr@kernel.org>
References: <20240812182355.11641-1-dakr@kernel.org> <20240812182355.11641-2-dakr@kernel.org>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: fb4aacd9e1618193c3c420b9aaebbdc5d458f11e
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 12.08.24 20:22, Danilo Krummrich wrote:
> Add a kernel specific `Allocator` trait, that in contrast to the one in
> Rust's core library doesn't require unstable features and supports GFP
> flags.
>=20
> Subsequent patches add the following trait implementors: `Kmalloc`,
> `Vmalloc` and `KVmalloc`.
>=20
> Reviewed-by: Alice Ryhl <aliceryhl@google.com>
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>
> ---
>  rust/kernel/alloc.rs | 81 ++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 81 insertions(+)
>=20
> diff --git a/rust/kernel/alloc.rs b/rust/kernel/alloc.rs
> index 1966bd407017..194745498a75 100644
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
> @@ -86,3 +87,83 @@ pub mod flags {
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
> +///
> +/// In order to be able to support `#[derive(SmartPointer)]` later on, w=
e need to avoid a design
> +/// that requires an `Allocator` to be instantiated, hence its functions=
 must not contain any kind
> +/// of `self` parameter.
> +///
> +/// # Safety
> +///
> +/// Memory returned from an allocator must point to a valid memory buffe=
r and remain valid until
> +/// it is explicitly freed.

I wouldn't say that an allocator "returns memory", and in general I
don't think the structure of the safety comment here is nice, how about
the following: we put "Implementers must ensure that all trait functions
abide by the guarantees documented in the `# Guarantees` sections."...

> +///
> +/// Any pointer to a memory buffer which is currently allocated must be =
valid to be passed to any
> +/// other [`Allocator`] function of the same type.
> +///
> +/// If `realloc` is called with:
> +///   - a size of zero, the given memory allocation, if any, must be fre=
ed
> +///   - `None`, a new memory allocation must be created
> +pub unsafe trait Allocator {
> +    /// Allocate memory based on `layout` and `flags`.
> +    ///
> +    /// On success, returns a buffer represented as `NonNull<[u8]>` that=
 satisfies the layout
> +    /// constraints (i.e. minimum size and alignment as specified by `la=
yout`).
> +    ///
> +    /// This function is equivalent to `realloc` when called with `None`=
.

... Then we can add this here:

    /// # Guarantees
    ///
    /// When the return value is `Ok(ptr)`, then `ptr` is
    /// - valid for writes (and reads after the memory has been initialized=
) for `layout.size()` bytes,
    ///   until it is passed to [`Allocator::free`] or [`Allocator::realloc=
`],
    /// - aligned to `layout.align()`,
    /// - is valid for reads, if `flags.contains(flags::__GFP_ZERO)`,

Do we need to handle other flags?
Also IIRC the memory given to us by C is considered initialized by Rust
(though it has a non-deterministic value), so we might have an
unconditional "valid for reads". Am I correct?


> +    fn alloc(layout: Layout, flags: Flags) -> Result<NonNull<[u8]>, Allo=
cError> {
> +        // SAFETY: Passing `None` to `realloc` is valid by it's safety r=
equirements and asks for a
> +        // new memory allocation.
> +        unsafe { Self::realloc(None, layout, flags) }
> +    }
> +
> +    /// Re-allocate an existing memory allocation to satisfy the request=
ed `layout`. If the
> +    /// requested size is zero, `realloc` behaves equivalent to `free`.

I don't think we want to include the second sentence in the short
description of this function, please add an empty line in between.

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
> +    /// If `ptr =3D Some(p)`, then `p` must point to an existing and val=
id memory allocation created

I don't like the single `=3D` (I might have written it in haste myself),
how about `=3D=3D` or we use if-let syntax?

> +    /// by this allocator. The alignment encoded in `layout` must be sma=
ller than or equal to the
> +    /// alignment requested in the previous `alloc` or `realloc` call of=
 the same allocation.
> +    ///
> +    /// Additionally, `ptr` is allowed to be `None`; in this case a new =
memory allocation is
> +    /// created.

This Safety section does not talk about the case `layout.size() =3D=3D 0`,
but it should have the same requirement as `free()`.

Also add a `# Guarantees` section here:

    /// # Guarantees
    ///
    /// This function has the same guarantees as [`Allocator::alloc`]. When=
 `ptr =3D=3D Some(p)`, then it
    /// additionally has the following:
    /// - when `Ok(ret_ptr)` is the return value, then
    ///   `ret_ptr[0..min(layout.size(), old_size)] =3D=3D p[0..min(layout.=
size(), old_size)]`, where
    ///   `old_size` is the size of the allocation that `p` points at.
    /// - when the return value is `Err(AllocError)`, then `p` is still val=
id.

---
Cheers,
Benno

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
ted by this `Allocator` and
> +    /// must not be a dangling pointer.
> +    ///
> +    /// The memory allocation at `ptr` must never again be read from or =
written to.
> +    unsafe fn free(ptr: NonNull<u8>) {
> +        // SAFETY: The caller guarantees that `ptr` points at a valid al=
location created by this
> +        // allocator. We are passing a `Layout` with the smallest possib=
le alignment, so it is
> +        // smaller than or equal to the alignment previously used with t=
his allocation.
> +        let _ =3D unsafe { Self::realloc(Some(ptr), Layout::new::<()>(),=
 Flags(0)) };
> +    }
> +}
> --
> 2.45.2
>=20


