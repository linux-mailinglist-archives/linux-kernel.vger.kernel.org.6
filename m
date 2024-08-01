Return-Path: <linux-kernel+bounces-270929-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 246B094472F
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 10:56:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF3722859E7
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 08:56:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7E8316F8F3;
	Thu,  1 Aug 2024 08:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="y3ja27kM"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0610616F8EB
	for <linux-kernel@vger.kernel.org>; Thu,  1 Aug 2024 08:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722502566; cv=none; b=c2xlBZ0uFgyHfwhamiz7kI582SXQeAa7DhTjqQPT2g3Q1wA8eUgTKQhNeNtQwcFkTyAZFKvF/0IjU4X64TYdClCjyXaz/8UaMrkTB3NXGY+K3FAio34kkLoP7iUoVnkIEp3onPNF3yKr8Ox1NnLlDEhF6GL+/UCwbZQhmmyXBOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722502566; c=relaxed/simple;
	bh=ygjuQzlKtmom8H6z2RDt4YGrv3yabu5jpfpA4qC8M7A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Km75MpCwr9nD8d7oY018Kqp83Fp0ZCZlzBSF/wXbbrnWebnno9qjERU0UIFaE8whXA/YcTnSWsadw3v/hbhzk5A5zVYaQaOMI3QTWSHdjgmPWjwm72XIoe4hDDnPHfSqvTGJIQ/cVPMlNnoQFSdJ+63JJir7Mj5OgCMv+M46sS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=y3ja27kM; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-428e0d184b4so3652245e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 01 Aug 2024 01:56:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722502563; x=1723107363; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fqO6Iix0wCIf9YemqZbokzS5RPd4qkoavIabrTwRodw=;
        b=y3ja27kMWIQpCMX/SrIrZh9SAhCcdy2sfmSQqFr+MupugU9YwRXnh4/VFfMvjt6RHN
         GitgrzR5TvKGXqCPn940oXL8nrw9yiQG+nhNV/Xx8bX17kbY78/tQdMdBQ1rbifNcJ4f
         686i56epkhQIhbIOpK051jxlwmkcVeEg10QA2LpI6XAXmroWGgAFgKL4lTI3KZEil6JW
         pnAufjhBfkPDGSJLvN+OQ2Y07lx6qYu1ld5x3Ctnfi81879Iosr3zu2jbYubjxDtr8xl
         eAi14MsHS20zcocueFefXkAvlB+DFtOiz3u5KvEuPHoHd4umvc5CKlP7B6rSA/qpm7pY
         4tPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722502563; x=1723107363;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fqO6Iix0wCIf9YemqZbokzS5RPd4qkoavIabrTwRodw=;
        b=EOaJUJZ/mAUVuNmdq2lJiTajHE9HQFzCWu5ILfj2iwC045JOoRelf+LUFiQEVJFoTc
         qaImI9WYygFbZ9HBB18SuOV/+V7DExMfXA+fQ7w/mmwRwnRzEwGYvVWp52kh69kyfuMs
         Xzu/0xg6nkpFxdi6oBmgJxxvOh98sZcViyRYpn109u50sGAlQzXIVxLtsFPeIR0mpnyi
         D6RYnnKDY6cghyk+LJKxpdlDeivJAzkiOha2F4scW7k5U9g7PQ1XrgvJxeNANNc6cw0m
         ztIRLEHP0WYTzzBdEuQVylKI3r1+UetW40BWR3KhINJ3rWhMd7awlRypm4Iuuvzx+DrX
         HHbQ==
X-Forwarded-Encrypted: i=1; AJvYcCWFsOl4Wc87JeHsAsbs5z34RmtmkqCPQJD+t8aH4n120622bBeLP02PYj/hzzPF+9ipdkWwm8umw7JRqdc/HZ6vZwUDzS36RPWyWCsG
X-Gm-Message-State: AOJu0YxKg5g5EJDzhmwcz2pQTcrdj8QfDP1ic7BYKChPc31awmQ1LwzQ
	Rst74Rtrt2c7PTP7J+vR0y08Za/LxFTRqvBMnmJGT1L9+9c7rssqEqFSlczibl13TvKRD0x1ZQU
	i1n6VuAF1k9G/weFr6iqS/QYXJNM1phRiULiT
X-Google-Smtp-Source: AGHT+IEJnIJSJM3c7ZxrjSpwo8kICD2epumG5XB51tiQWpb0SXEaiAk6zGgcS2+tg6CW5rhLO+jt6TupjzpSK0lZoh8=
X-Received: by 2002:a5d:47af:0:b0:367:8f29:f7ae with SMTP id
 ffacd0b85a97d-36baaf507cfmr1372748f8f.49.1722502562925; Thu, 01 Aug 2024
 01:56:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240801000641.1882-1-dakr@kernel.org> <20240801000641.1882-10-dakr@kernel.org>
In-Reply-To: <20240801000641.1882-10-dakr@kernel.org>
From: Alice Ryhl <aliceryhl@google.com>
Date: Thu, 1 Aug 2024 10:55:51 +0200
Message-ID: <CAH5fLggjs8t2c1GVFdQu6gULjG_oYx7299m4NedQFS+hOgFfTw@mail.gmail.com>
Subject: Re: [PATCH v3 09/25] rust: alloc: implement kernel `Box`
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
>
> `Box` provides the simplest way to allocate memory for a generic type
> with one of the kernel's allocators, e.g. `Kmalloc`, `Vmalloc` or
> `KVmalloc`.
>
> In contrast to Rust's `Box` type, the kernel `Box` type considers the
> kernel's GFP flags for all appropriate functions, always reports
> allocation failures through `Result<_, AllocError>` and remains
> independent from unstable features.
>
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>
>
> [...]
>
> +    /// Constructs a `Box<T, A>` from a raw pointer.
> +    ///
> +    /// # Safety
> +    ///
> +    /// `raw` must point to valid memory, previously allocated with `A`,=
 and at least the size of
> +    /// type `T`.
> +    #[inline]
> +    pub const unsafe fn from_raw_alloc(raw: *mut T, alloc: PhantomData<A=
>) -> Self {
> +        // SAFETY: Safe by the requirements of this function.
> +        Box(unsafe { Unique::new_unchecked(raw) }, alloc)
> +    }

I don't think it makes sense to take the PhantomData as a parameter.
You can always create a PhantomData value out of thin air.

Box(unsafe { Unique::new_unchecked(raw) }, PhantomData)

> +    /// Consumes the `Box<T, A>`, returning a wrapped raw pointer and `P=
hantomData` of the allocator
> +    /// it was allocated with.
> +    pub fn into_raw_alloc(b: Self) -> (*mut T, PhantomData<A>) {
> +        let b =3D ManuallyDrop::new(b);
> +        let alloc =3D unsafe { ptr::read(&b.1) };
> +        (b.0.as_ptr(), alloc)
> +    }

I don't think there's any need to have this function. The caller can
always create the PhantomData themselves. I would just keep into_raw
only.

> +    /// Converts a `Box<T>` into a `Pin<Box<T>>`.
> +    #[inline]
> +    pub fn into_pin(b: Self) -> Pin<Self>
> +    where
> +        A: 'static,
> +    {
> +        // SAFETY: It's not possible to move or replace the insides of a=
 `Pin<Box<T>>` when
> +        // `T: !Unpin`, so it's safe to pin it directly without any addi=
tional requirements.
> +        unsafe { Pin::new_unchecked(b) }
> +    }

In the standard library, this functionality is provided using the From
trait rather than an inherent method. I think it makes sense to match
std here.

> +impl<T, A> Drop for Box<T, A>
> +where
> +    T: ?Sized,
> +    A: Allocator,
> +{
> +    fn drop(&mut self) {
> +        let ptr =3D self.0.as_ptr();
> +
> +        // SAFETY: We need to drop `self.0` in place, before we free the=
 backing memory.
> +        unsafe { core::ptr::drop_in_place(ptr) };
> +
> +        // SAFETY: `ptr` is always properly aligned, dereferenceable and=
 points to an initialized
> +        // instance of `T`.
> +        if unsafe { core::mem::size_of_val(&*ptr) } !=3D 0 {
> +            // SAFETY: `ptr` was previously allocated with `A`.
> +            unsafe { A::free(self.0.as_non_null().cast()) };
> +        }

You just destroyed the value by calling `drop_in_place`, so `ptr` no
longer points at an initialized instance of `T`. Please compute
whether the allocation has non-zero size before you call
`drop_in_place`.

Also, in normal Rust this code would leak the allocation on panic in
the destructor. We may not care, but it's worth taking into account if
anybody else copies this code to a different project with a different
panic configuration.

> +impl<T: 'static, A> ForeignOwnable for crate::alloc::Box<T, A>
> +where
> +    A: Allocator,
> +{
> +    type Borrowed<'a> =3D &'a T;
> +
> +    fn into_foreign(self) -> *const core::ffi::c_void {
> +        crate::alloc::Box::into_raw(self) as _
> +    }
> +
> +    unsafe fn borrow<'a>(ptr: *const core::ffi::c_void) -> &'a T {
> +        // SAFETY: The safety requirements for this function ensure that=
 the object is still alive,
> +        // so it is safe to dereference the raw pointer.
> +        // The safety requirements of `from_foreign` also ensure that th=
e object remains alive for
> +        // the lifetime of the returned value.
> +        unsafe { &*ptr.cast() }
> +    }
> +
> +    unsafe fn from_foreign(ptr: *const core::ffi::c_void) -> Self {
> +        // SAFETY: The safety requirements of this function ensure that =
`ptr` comes from a previous
> +        // call to `Self::into_foreign`.
> +        unsafe { crate::alloc::Box::from_raw(ptr as _) }
> +    }
> +}

You may want to also implement ForeignOwnable for Pin<Box<T>>. See:
https://lore.kernel.org/all/20240730-foreign-ownable-pin-box-v1-1-b1d70cdae=
541@google.com/

Alice

