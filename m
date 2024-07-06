Return-Path: <linux-kernel+bounces-243158-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D783929298
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jul 2024 12:34:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 33CC4282CD4
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jul 2024 10:34:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7918B6FE21;
	Sat,  6 Jul 2024 10:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="OB+Aflby"
Received: from mail-40134.protonmail.ch (mail-40134.protonmail.ch [185.70.40.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A24F6F30B
	for <linux-kernel@vger.kernel.org>; Sat,  6 Jul 2024 10:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720262045; cv=none; b=OGJOrdjUSZI/QoundDLrs/hWMjboPgeiFMIFmBiVXSkyF1QHRkc1dBX8ol+4Gqv77xSUwFMXke099/R4FnBYJUZM3p+HTFYBd5ODUlitTYmbfc8ZxFdcJ04xnjGkTIO8oaLrON+5Pco539mxjpUSnJOYm8M1/UGviQS2Ch/h2Zk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720262045; c=relaxed/simple;
	bh=pKmz2MSXbsXY1TVYCOFk40qxUqMYq2ihZ17VzYmJj74=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CiffbVn2AtY48P7ovesOa5EV4ME2h6k4+IZfSDvSjDst7l+ugdc7EGFzNqtRcDP60BvdpdvvdzIhaqIH4Y9+HCz4zcWQyOeCIasIraLNY9XA3gHcxEIhwfx99/sKHnaj5+GspHIRq4LTvXCcbGSDeR9l5xJ4/LdActmWMf/03pQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=OB+Aflby; arc=none smtp.client-ip=185.70.40.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1720262035; x=1720521235;
	bh=eV2kqn2oW0bpvGpk8bMOJksVw0Q08ALVrHBIpfM92Vo=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=OB+AflbyK2jD1nUL4txPo7amN/5ubcw/iziZEfcZL/t1h+fUX5jNWxy/eB8BS0Vmn
	 PllL8+tNcB22V6s0FW58sjfZH7qUYw/waIpk2Z8+r2eh9zdnOM/XZ8h7L4IQAXpucu
	 xYtCUiWYzRrejhj7CtG4xgvVximR8oTzshoLHyBZEbki5n/VCrUyvpgCsl+38u4osp
	 qAlPwBp5FLfXrEXIuovCVsMm40uVky8e5aajR+blggzsi9TEoG0qv6lVqU/oUfFkoP
	 0fmVDqurkHeoJ6YJc6Rz4XSqGHT8XPoosQ4cFysGvwdY6DM+IrqkFd8PWZvnw8Q5CC
	 7wp/FBLRHPi/w==
Date: Sat, 06 Jul 2024 10:33:49 +0000
To: Danilo Krummrich <dakr@redhat.com>, ojeda@kernel.org, alex.gaynor@gmail.com, wedsonaf@gmail.com, boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com, a.hindborg@samsung.com, aliceryhl@google.com
From: Benno Lossin <benno.lossin@proton.me>
Cc: daniel.almeida@collabora.com, faith.ekstrand@collabora.com, boris.brezillon@collabora.com, lina@asahilina.net, mcanal@igalia.com, zhiw@nvidia.com, acurrid@nvidia.com, cjia@nvidia.com, jhubbard@nvidia.com, airlied@redhat.com, ajanulgu@redhat.com, lyude@redhat.com, linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org
Subject: Re: [PATCH 01/20] rust: alloc: add `Allocator` trait
Message-ID: <37d87244-fbef-414c-a726-60839b305040@proton.me>
In-Reply-To: <20240704170738.3621-2-dakr@redhat.com>
References: <20240704170738.3621-1-dakr@redhat.com> <20240704170738.3621-2-dakr@redhat.com>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: 20d835e43020bd428b00f8fd1af6b48b1aba063f
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 04.07.24 19:06, Danilo Krummrich wrote:
> Add a kernel specific `Allocator` trait, that in contrast to the one in
> Rust's core library doesn't require unstable features and supports GFP
> flags.
>=20
> Subsequent patches add the following trait implementors: `Kmalloc`,
> `Vmalloc` and `KVmalloc`.
>=20
> Signed-off-by: Danilo Krummrich <dakr@redhat.com>
> ---
>  rust/kernel/alloc.rs | 73 ++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 73 insertions(+)
>=20
> diff --git a/rust/kernel/alloc.rs b/rust/kernel/alloc.rs
> index 531b5e471cb1..462e00982510 100644
> --- a/rust/kernel/alloc.rs
> +++ b/rust/kernel/alloc.rs
> @@ -11,6 +11,7 @@
>  /// Indicates an allocation error.
>  #[derive(Copy, Clone, PartialEq, Eq, Debug)]
>  pub struct AllocError;
> +use core::{alloc::Layout, ptr, ptr::NonNull};
>=20
>  /// Flags to be used when allocating memory.
>  ///
> @@ -71,3 +72,75 @@ pub mod flags {
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
> +/// [`Allocator`] is designed to be implemented on ZSTs; its safety requ=
irements to not allow for
> +/// keeping a state throughout an instance.

Why do the functions take `&self` if it is forbidden to have state? I
would remove the receiver in that case.

> +///
> +/// # Safety
> +///
> +/// Memory returned from an allocator must point to a valid memory buffe=
r and remain valid until
> +/// its explicitly freed.
> +///
> +/// Copying, cloning, or moving the allocator must not invalidate memory=
 blocks returned from this
> +/// allocator. A copied, cloned or even new allocator of the same type m=
ust behave like the same
> +/// allocator, and any pointer to a memory buffer which is currently all=
ocated may be passed to any
> +/// other method of the allocator.

If you provide no receiver methods, then I think we can remove this
requirement.

> +pub unsafe trait Allocator {
> +    /// Allocate memory based on `layout` and `flags`.
> +    ///
> +    /// On success, returns a buffer represented as `NonNull<[u8]>` that=
 satisfies the size an

typo "an" -> "and"

> +    /// alignment requirements of layout, but may exceed the requested s=
ize.

Also if it may exceed the size, then I wouldn't call that "satisfies the
size [...] requirements".

> +    ///
> +    /// This function is equivalent to `realloc` when called with a NULL=
 pointer and an `old_size`
> +    /// of `0`.

This is only true for the default implementation and could be
overridden, since it is not a requirement of implementing this trait to
keep it this way. I would remove this sentence.

> +    fn alloc(&self, layout: Layout, flags: Flags) -> Result<NonNull<[u8]=
>, AllocError> {

Instead of using the `Flags` type from the alloc module, we should have
an associated `Flags` type in this trait.

Similarly, it might also be a good idea to let the implementer specify a
custom error type.

> +        // SAFETY: Passing a NULL pointer to `realloc` is valid by it's =
safety requirements and asks
> +        // for a new memory allocation.
> +        unsafe { self.realloc(ptr::null_mut(), 0, layout, flags) }
> +    }
> +
> +    /// Re-allocate an existing memory allocation to satisfy the request=
ed `layout`. If the
> +    /// requested size is zero, `realloc` behaves equivalent to `free`.

This is not guaranteed by the implementation.

> +    ///
> +    /// If the requested size is larger than `old_size`, a successful ca=
ll to `realloc` guarantees
> +    /// that the new or grown buffer has at least `Layout::size` bytes, =
but may also be larger.
> +    ///
> +    /// If the requested size is smaller than `old_size`, `realloc` may =
or may not shrink the
> +    /// buffer; this is implementation specific to the allocator.
> +    ///
> +    /// On allocation failure, the existing buffer, if any, remains vali=
d.
> +    ///
> +    /// The buffer is represented as `NonNull<[u8]>`.
> +    ///
> +    /// # Safety
> +    ///
> +    /// `ptr` must point to an existing and valid memory allocation crea=
ted by this allocator
> +    /// instance of a size of at least `old_size`.
> +    ///
> +    /// Additionally, `ptr` is allowed to be a NULL pointer; in this cas=
e a new memory allocation is
> +    /// created.
> +    unsafe fn realloc(
> +        &self,
> +        ptr: *mut u8,
> +        old_size: usize,

Why not request the old layout like the std Allocator's grow/shrink
functions do?

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
> +    unsafe fn free(&self, ptr: *mut u8) {

`ptr` should be `NonNull<u8>`.

> +        // SAFETY: `ptr` is guaranteed to be previously allocated with t=
his `Allocator` or NULL.
> +        // Calling `realloc` with a buffer size of zero, frees the buffe=
r `ptr` points to.
> +        let _ =3D unsafe { self.realloc(ptr, 0, Layout::new::<()>(), Fla=
gs(0)) };

Why does the implementer have to guarantee this?

> +    }
> +}
> --
> 2.45.2
>=20

More general questions:
- are there functions in the kernel to efficiently allocate zeroed
  memory? In that case, the Allocator trait should also have methods
  that do that (with a iterating default impl).
- I am not sure putting everything into the single realloc function is a
  good idea, I like the grow/shrink methods of the std allocator. Is
  there a reason aside from concentrating the impl to go for only a
  single realloc function?

---
Cheers,
Benno


