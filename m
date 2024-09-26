Return-Path: <linux-kernel+bounces-340489-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB1E3987411
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 15:02:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A03D4287A8A
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 13:02:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 221DB3FB9F;
	Thu, 26 Sep 2024 13:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="MdcN3bxi"
Received: from mail-4322.protonmail.ch (mail-4322.protonmail.ch [185.70.43.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DAE43A1B6
	for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 13:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727355715; cv=none; b=gn0WCQlX0R5xBA+v//95A1Why4x6M66AzeBx6lDnnZoPHewJTEWxt/q+m2TbSucgBGcYx3e9UOXs5M8xeC70m7QMf76AAltrREIHv95WWKHLbUIpjEkWs1ETuv+zEpc2Jl72Q80luEGMDSBvxM7TLfrGkrAC5Cp6DZWRR1ZeK40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727355715; c=relaxed/simple;
	bh=OXHeZK2qk4v7prSpNji70gCfJgp96GTUw3/beMdUJ20=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Dykhwzv2ghJyV0kEjnxx61lX4Wz15YkX2nE/E+0YNymzwKZ4KeclEWCkxloJPoUeRKLgoVC3oaN7YSFjaiWbyG6ijo5PnGopvEJDxpupLbkpY9RldksI/hGjEjQyhBx2gsAlc+chEH96bsftT7MG+1ACPOPXpvLwggK3u9Ldrps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=MdcN3bxi; arc=none smtp.client-ip=185.70.43.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1727355708; x=1727614908;
	bh=Ni2tbyqOCaidLloef4UUNDZ9jQLw7Tbtr+Fe40Nyt9k=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=MdcN3bxiKQV7IztkVwYihHWencm5ejs4fWLMev+sd7mX7LfYTwhlD78H11Is5Afhz
	 CeKOrzVJvjWw2zpqvI5W6iVP86OEs3G/6lLY0WBA08cIkz6TrbF+vvntC37QUmP4GM
	 eKy15/vDU3dWjSPKS97LCXlK3IsYyQaiah/Xpe3qDpdZUSf43cFB8Umdw4VIXXX181
	 erMvU5pjZj60BbM1mT4WmUWUZfBr6iuO89TJ3YJcDg9dUaRnAccVbFWjdpTXqiZB8G
	 XDWyPXmnciV1GKk9nW9MNxr2LDkStAx+140qg0o5BsPtdtJjdAVycy/WHQ/ncTSqCR
	 ZWY5cdcLl/g2w==
Date: Thu, 26 Sep 2024 13:00:58 +0000
To: Danilo Krummrich <dakr@kernel.org>, ojeda@kernel.org, alex.gaynor@gmail.com, wedsonaf@gmail.com, boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com, a.hindborg@samsung.com, aliceryhl@google.com, akpm@linux-foundation.org
From: Benno Lossin <benno.lossin@proton.me>
Cc: daniel.almeida@collabora.com, faith.ekstrand@collabora.com, boris.brezillon@collabora.com, lina@asahilina.net, mcanal@igalia.com, zhiw@nvidia.com, cjia@nvidia.com, jhubbard@nvidia.com, airlied@redhat.com, ajanulgu@redhat.com, lyude@redhat.com, linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v7 04/26] rust: alloc: implement `Allocator` for `Kmalloc`
Message-ID: <15f42ddd-b011-4136-b2e4-bc266fab25b6@proton.me>
In-Reply-To: <20240911225449.152928-5-dakr@kernel.org>
References: <20240911225449.152928-1-dakr@kernel.org> <20240911225449.152928-5-dakr@kernel.org>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: f5651060dc2251b4113e5c3c4cb39c1e915fcbd3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 12.09.24 00:52, Danilo Krummrich wrote:
> +/// # Invariants
> +///
> +/// One of the following `krealloc`, `vrealloc`, `kvrealloc`.
> +struct ReallocFunc(
> +    unsafe extern "C" fn(*const core::ffi::c_void, usize, u32) -> *mut c=
ore::ffi::c_void,
> +);
> +
> +impl ReallocFunc {
> +    // INVARIANT: `krealloc` satisfies the type invariants.
> +    const KREALLOC: Self =3D Self(bindings::krealloc);
> +
> +    /// # Safety
> +    ///
> +    /// This method has the same safety requirements as [`Allocator::rea=
lloc`].
> +    ///
> +    /// # Guarantees
> +    ///
> +    /// This method has the same guarantees as `Allocator::realloc`. Add=
itionally
> +    /// - it accepts any pointer to a valid memory allocation allocated =
by this function.
> +    /// - memory allocated by this function remains valid until it is pa=
ssed to this function.
> +    unsafe fn call(
> +        &self,
> +        ptr: Option<NonNull<u8>>,
> +        layout: Layout,
> +        flags: Flags,
> +    ) -> Result<NonNull<[u8]>, AllocError> {
> +        let size =3D aligned_size(layout);
> +        let ptr =3D match ptr {
> +            Some(ptr) =3D> ptr.as_ptr(),
> +            None =3D> ptr::null(),
> +        };
> +
> +        // SAFETY:
> +        // - `self.0` is one of `krealloc`, `vrealloc`, `kvrealloc` and =
thus only requires that
> +        //   `ptr` is NULL or valid.
> +        // - `ptr` is either NULL or valid by the safety requirements of=
 this function.
> +        //
> +        // GUARANTEE:
> +        // - `self.0` is one of `krealloc`, `vrealloc`, `kvrealloc`.
> +        // - Those functions provide the guarantees of this function.
> +        let raw_ptr =3D unsafe {
> +            // If `size =3D=3D 0` and `ptr !=3D NULL` the memory behind =
the pointer is freed.
> +            self.0(ptr.cast(), size, flags.0).cast()
> +        };
> +
> +        let ptr =3D if size =3D=3D 0 {
> +            NonNull::dangling()
> +        } else {
> +            NonNull::new(raw_ptr).ok_or(AllocError)?
> +        };
> +
> +        Ok(NonNull::slice_from_raw_parts(ptr, size))
> +    }
> +}

I remember asking you to split this into a different commit. I think you
argued that it would be better to keep it in the same commit when
bisecting. I don't think that applies in this case, are there any other
disadvantages?

---
Cheers,
Benno

> +
> +// SAFETY: `realloc` delegates to `ReallocFunc::call`, which guarantees =
that
> +// - memory remains valid until it is explicitly freed,
> +// - passing a pointer to a valid memory allocation is OK,
> +// - `realloc` satisfies the guarantees, since `ReallocFunc::call` has t=
he same.
> +unsafe impl Allocator for Kmalloc {
> +    #[inline]
> +    unsafe fn realloc(
> +        ptr: Option<NonNull<u8>>,
> +        layout: Layout,
> +        flags: Flags,
> +    ) -> Result<NonNull<[u8]>, AllocError> {
> +        // SAFETY: `ReallocFunc::call` has the same safety requirements =
as `Allocator::realloc`.
> +        unsafe { ReallocFunc::KREALLOC.call(ptr, layout, flags) }
> +    }
> +}


> +
>  unsafe impl GlobalAlloc for Kmalloc {
>      unsafe fn alloc(&self, layout: Layout) -> *mut u8 {
>          // SAFETY: `ptr::null_mut()` is null and `layout` has a non-zero=
 size by the function safety
> --
> 2.46.0
>=20


