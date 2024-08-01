Return-Path: <linux-kernel+bounces-270883-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CC01994469D
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 10:28:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 848EE281A87
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 08:28:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0EB016E88E;
	Thu,  1 Aug 2024 08:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YQZI8ihF"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3410416DEB2
	for <linux-kernel@vger.kernel.org>; Thu,  1 Aug 2024 08:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722500904; cv=none; b=nDeoem1BwcAaqwsp3xHa4Zx0VgIYBCZAg8U8+wSiF4PXR3hbj5ZBspES0S1+5fETysiycQl8AG/OqjAu4ZgMB8tPV2z5FwADDwGzm7Zb8AeBXbFPAGrM307MpIVSRdEuql1Ko+KmTUIk1MPlbc8rd0rlVFbaO5eJQQgY7uyp2Fs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722500904; c=relaxed/simple;
	bh=RtsW5WWTyWJIL27AcTCugxjnVd2s4/R7JlgMY9UajKk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cG9a0PB6I2h9hv8A3k5VFudvidiq3VNFefo+dRV7tJDCag0o85BnnJPFT913it3mFpTj81FvN+5729mbXWBqoaN/zJ5/AiozCXmhsaHb8tTN9vZathgxbDCaGgS3qE0GjfEYeABDe2M8bzafDFv8ZlvgqZxfe+Q4FSdkKX/c3Mw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YQZI8ihF; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-428e1915e18so2813015e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 01 Aug 2024 01:28:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722500901; x=1723105701; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ojSR7rF9TxK4zY2qobnr+4uxfHaQxVITngCaPWYPV8k=;
        b=YQZI8ihFNSfDuku64Ou9K51iGuJGc9zv4KQiuzEFSTLV7wzZb2/o8ualoN0uZUhAOz
         p4FNvGZusldlAW48l1BNIDnzwDD+G4BYgi/SU3cNuwVFjbpTa8FVD3+KxE7AJihirdC/
         l76t5G5JpFtItK+uhTdxZA3AykAUU40MaTpy3Xj++g8Yy7PN4Pkc56aaV//kEQzkRsXo
         +XOe3S5r+ICu40ueq/mxkN9acquy2oYHYYZbnTKQe4O1g9gVA/JIAaISjw5znvHVaK+/
         +dNBoGOM2qEWr9tm6P3u2P84cLoGtjYOi9WFSMLzDAtOMBef6eJipmL2d9iApNyutuMX
         6vCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722500901; x=1723105701;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ojSR7rF9TxK4zY2qobnr+4uxfHaQxVITngCaPWYPV8k=;
        b=mSXKD3NE2npIwxUbYUVt5wvkb94VOSP2kgnep0b+rbur4DVheggJq+yI4y0JDKgyoe
         OtbdW6cZd+/Igc8ZCshX5WTr//HzdrkTA+BoG2ewridZ+uti52pOWfUeWxyWfWZgiqhR
         xdxa1LJNc5Nu5rcZ5OFq51nbxB3kMBbUCuRrtYd1XB/ctyFMKVfkkAYGrWJd2O3FyFdV
         6/YsM9fHgos356JEQ9E5wx0VyBviRjuiBZ9dDvHP49VJIx2nLsDQ1WgtZj0s1wfK2GmS
         81RieFvUz6TrIs8FXu/QyZMgFB4GZs0qvphUHfs59aPkJ5aiDTPSo7Zg78DRLXJJJ+E+
         R2KA==
X-Forwarded-Encrypted: i=1; AJvYcCVg1LiidDc4Vip2R9ToVd2YRKMKl1rU7xsqMO+VFo5qkWZvcW9yy7P0929KOc18L13Fht7eQLLKcJL5uEvivZnmubCqSSQ6sZ7xNztE
X-Gm-Message-State: AOJu0Yy5OE8uTK6K2jUucsDysHIFPXm/xAngdUGV7tHIUCjjHkdVM9s8
	vhqpadk5cNd6yA53bG4cwsUUKgmvEFoHbZhJCst81MjCutvoPanK+Er0kvyL3dBdNxnC+Lu6tgo
	CeT+nreygM3M4DXmRzQFQ+dMX7wZLKnF09vyt
X-Google-Smtp-Source: AGHT+IFlHvNyLOkNGilTJsUR27sYt/UML/5/UGX3BBsKWn8Zf6ZLf3lpfWpigR7D708NAF2f+Zvc+KIKjlUVPpSpWME=
X-Received: by 2002:a05:6000:c0a:b0:367:9279:c401 with SMTP id
 ffacd0b85a97d-36baadef49fmr1115684f8f.34.1722500901119; Thu, 01 Aug 2024
 01:28:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240801000641.1882-1-dakr@kernel.org> <20240801000641.1882-5-dakr@kernel.org>
In-Reply-To: <20240801000641.1882-5-dakr@kernel.org>
From: Alice Ryhl <aliceryhl@google.com>
Date: Thu, 1 Aug 2024 10:28:09 +0200
Message-ID: <CAH5fLggM5X7M9fTJE7C2afSHehK8b72XGKAgsEcn3Xm632s_Gg@mail.gmail.com>
Subject: Re: [PATCH v3 04/25] rust: alloc: implement `Allocator` for `Kmalloc`
To: Danilo Krummrich <dakr@kernel.org>
Cc: ojeda@kernel.org, alex.gaynor@gmail.com, wedsonaf@gmail.com, 
	boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com, 
	benno.lossin@proton.me, a.hindborg@samsung.com, akpm@linux-foundation.org, 
	daniel.almeida@collabora.com, faith.ekstrand@collabora.com, 
	boris.brezillon@collabora.com, lina@asahilina.net, mcanal@igalia.com, 
	zhiw@nvidia.com, acurrid@nvidia.com, cjia@nvidia.com, jhubbard@nvidia.com, 
	airlied@redhat.com, ajanulgu@redhat.com, lyude@redhat.com, 
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 1, 2024 at 2:07=E2=80=AFAM Danilo Krummrich <dakr@kernel.org> w=
rote:
> +/// Returns a proper size to alloc a new object aligned to `new_layout`'=
s alignment.
>  fn aligned_size(new_layout: Layout) -> usize {

This comment could potentially be moved to the previous patch that
defined the function.

> +struct ReallocFunc(
> +    // INVARIANT: One of the following `krealloc`, `vrealloc`, `kvreallo=
c`.
> +    unsafe extern "C" fn(*const core::ffi::c_void, usize, u32) -> *mut c=
ore::ffi::c_void,
> +);

In this case, the comment would usually be formatted with markdown.

/// # Invariants
///
/// Must contain one of the following: `krealloc`, `vrealloc`, `kvrealloc`.

The // INVARIANT: syntax is used when constructing an instance to
argue why the documentented invariants are satisfied.

> +impl ReallocFunc {
> +    fn krealloc() -> Self {
> +        Self(bindings::krealloc)
> +    }

Technically this should have an // INVARIANT: explaining why the
invariants are satisfied by this new value.

> +
> +    // SAFETY: `call` has the exact same safety requirements as `Allocat=
or::realloc`.
> +    unsafe fn call(

Similarly to the above, the // SAFETY: syntax is used when arguing why
the preconditions are satisfied, but when explaining what the
preconditions are, we usually use this syntax instead:

/// # Safety
///
/// This method has the same safety requirements as `Allocator::realloc`.

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
> +        // SAFETY: `ptr` is valid by the safety requirements of this fun=
ction.
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
> +
> +unsafe impl Allocator for Kmalloc {
> +    unsafe fn realloc(
> +        ptr: Option<NonNull<u8>>,
> +        layout: Layout,
> +        flags: Flags,
> +    ) -> Result<NonNull<[u8]>, AllocError> {
> +        let realloc =3D ReallocFunc::krealloc();
> +
> +        // SAFETY: If not `None`, `ptr` is guaranteed to point to valid =
memory, which was previously
> +        // allocated with this `Allocator`.
> +        unsafe { realloc.call(ptr, layout, flags) }
> +    }
> +}
> +
>  unsafe impl GlobalAlloc for Kmalloc {
>      unsafe fn alloc(&self, layout: Layout) -> *mut u8 {
>          // SAFETY: `ptr::null_mut()` is null and `layout` has a non-zero=
 size by the function safety
> --
> 2.45.2
>

