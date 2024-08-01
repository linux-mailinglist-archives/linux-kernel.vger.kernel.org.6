Return-Path: <linux-kernel+bounces-270904-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E69C79446D9
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 10:43:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A980285A5E
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 08:43:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C64716E89C;
	Thu,  1 Aug 2024 08:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="s0Yv4vH3"
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EF0C16EB5A
	for <linux-kernel@vger.kernel.org>; Thu,  1 Aug 2024 08:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722501801; cv=none; b=fBhF4E+83Qa1sbzXkmn/kZSNAYjCsB51lYc4MeriKzvLyL89neenrgjQr07WCo1FxayGsal87A9pBOtnuHSHnnkwxgLzn4VZR3NFrWNF1leV6wDVm89SBGFzJ5sYNTkaLYNjEqiHSZ5EcvNH080xMHrOCyK13xG/S+VKwV9O840=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722501801; c=relaxed/simple;
	bh=YpfUPoMyJ2Qi6FjWPKXYwaaW5Amqw9wZMYibb+kjjJA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=j23Gfoap/hF4TzGF0mOYiWARlQ+86PfUEC0JFKCHG9sMxrxj0PlVqYdafx+cenAXxWF+cLpl4BT0MHWFNJTU9D15OP135j/k+7E4gHWN81QiQ4gdBq2qqRBJ+7Bjkp8PGBGainYK5YiykHYsfJsvVUUm2kj2ClQFVh3F7LHICsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=s0Yv4vH3; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-52fc4388a64so11199609e87.1
        for <linux-kernel@vger.kernel.org>; Thu, 01 Aug 2024 01:43:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722501798; x=1723106598; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=057qsfQo25vgSdyD+iBQubS+WGiFw59ECgKt87tVL5A=;
        b=s0Yv4vH33mP2ttUQoXb+sOvVPIYpWalveiHBFWObxHz9vUAne8eaUEL9MNZ0u7wjBA
         n6r5KxXDrTD4KLygyDpMRDShMY/hE6KDtaim/mhsztr9kWzng8aj/98CWVQHr3viDEbP
         /winImSwflf6P8l3VBjhfBFNY5s6v8+x786XyRZAcWsi+Hwu9oq0jKkED4B0cU+whqZ/
         uJwCQtawcSYiou4kRG0zVOsQDRYs9iCTxxvQKoOWEBHBFU/+XkMACD8i+BuPJa3h7IAB
         YCnwKKjASGXXTn+9Rumj+4cdXscMebJGefDARolmft2E7054uqaPA0RYKfpxF9GshNhx
         QiVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722501798; x=1723106598;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=057qsfQo25vgSdyD+iBQubS+WGiFw59ECgKt87tVL5A=;
        b=daVZpvt3revern7KLWLptnR3+RmH5W/+V/KBZnIbRw4+Juj2K0tAaTdkpk78WmkgIw
         5Qybb7XFObsyk1n0yIIVSg/egQXprIyJQ7Dh8+v94SdYi1qa3uTyo0GzPH/NZFkUyYw8
         RlNTjIEYQaEw2Np6ezPMvsyjaLnVk0vdIma4/P72fvpIE5MbGpFbCUDl+l7O2JWih8rc
         WTLv6J86hbcgov1kYv43hgEiDcgEcZCcs/b9MOglbWYdQcWC8VWAC80f+G4UZ1Qunqd5
         W/hAvkilF3gu7RI6W8H27EWZnB2wbygaEKHvB/TjfEvYmLBiB67SWtbCd81MBopEtBBz
         yvkw==
X-Forwarded-Encrypted: i=1; AJvYcCWcITMKpyuMEKZUNIv+g+1YIcXBYS1dvhIEMp9Izxa9lOPh2cWcVpwdvMD98R5VCnvdO/qughhA1iNkQfyvpeaJHeEuVqu8V0JUqByw
X-Gm-Message-State: AOJu0YxlONa0cDo8OA6H6jwOklrhRVt+UaqhVMOesDVZpW5wJfzoljxF
	5iHlYrOestO9TE7ASkCMNKX2tuEzvzvE/IQFQAC+NwGmNzFBhlW9Imklq/xWKz72d4/YxND8EkD
	X31yg7ZkKPKC/brEBIwv9yyqVVU1Hc8cu7NDA
X-Google-Smtp-Source: AGHT+IENcEymBHeQ//Di7A/pvJi5huPTzBOnLqISBj+H9wlfHEJY13Wl4uiIRucbmw7OOtQPbn95aJ6SQzpDE5dbI48=
X-Received: by 2002:ac2:55a7:0:b0:52f:441:bdd9 with SMTP id
 2adb3069b0e04-530b61bc022mr813511e87.34.1722501797458; Thu, 01 Aug 2024
 01:43:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240801000641.1882-1-dakr@kernel.org> <20240801000641.1882-7-dakr@kernel.org>
In-Reply-To: <20240801000641.1882-7-dakr@kernel.org>
From: Alice Ryhl <aliceryhl@google.com>
Date: Thu, 1 Aug 2024 10:43:05 +0200
Message-ID: <CAH5fLgiXpojYs3B68toTK+S18mnfRnChtwkve4_eWLXt_417rA@mail.gmail.com>
Subject: Re: [PATCH v3 06/25] rust: alloc: implement `Vmalloc` allocator
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
> Implement `Allocator` for `Vmalloc`, the kernel's virtually contiguous
> allocator, typically used for larger objects, (much) larger than page
> size.
>
> All memory allocations made with `Vmalloc` end up in `vrealloc()`.
>
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>

One nit below, but.

Reviewed-by: Alice Ryhl <aliceryhl@google.com>

>  rust/helpers.c                      |  8 ++++++++
>  rust/kernel/alloc/allocator.rs      | 24 ++++++++++++++++++++++++
>  rust/kernel/alloc/allocator_test.rs |  1 +
>  3 files changed, 33 insertions(+)
>
> diff --git a/rust/helpers.c b/rust/helpers.c
> index 92d3c03ae1bd..4c628986f0c9 100644
> --- a/rust/helpers.c
> +++ b/rust/helpers.c
> @@ -33,6 +33,7 @@
>  #include <linux/sched/signal.h>
>  #include <linux/slab.h>
>  #include <linux/spinlock.h>
> +#include <linux/vmalloc.h>
>  #include <linux/wait.h>
>  #include <linux/workqueue.h>
>
> @@ -200,6 +201,13 @@ rust_helper_krealloc(const void *objp, size_t new_si=
ze, gfp_t flags)
>  }
>  EXPORT_SYMBOL_GPL(rust_helper_krealloc);
>
> +void * __must_check __realloc_size(2)
> +rust_helper_vrealloc(const void *p, size_t size, gfp_t flags)
> +{
> +       return vrealloc(p, size, flags);
> +}
> +EXPORT_SYMBOL_GPL(rust_helper_vrealloc);
> +
>  /*
>   * `bindgen` binds the C `size_t` type as the Rust `usize` type, so we c=
an
>   * use it in contexts where Rust expects a `usize` like slice (array) in=
dices.
> diff --git a/rust/kernel/alloc/allocator.rs b/rust/kernel/alloc/allocator=
.rs
> index 397ae5bcc043..e9a3d0694f41 100644
> --- a/rust/kernel/alloc/allocator.rs
> +++ b/rust/kernel/alloc/allocator.rs
> @@ -16,6 +16,12 @@
>  /// `bindings::krealloc`.
>  pub struct Kmalloc;
>
> +/// The virtually contiguous kernel allocator.
> +///
> +/// The vmalloc allocator allocates pages from the page level allocator =
and maps them into the
> +/// contiguous kernel virtual space.
> +pub struct Vmalloc;
> +
>  /// Returns a proper size to alloc a new object aligned to `new_layout`'=
s alignment.
>  fn aligned_size(new_layout: Layout) -> usize {
>      // Customized layouts from `Layout::from_size_align()` can have size=
 < align, so pad first.
> @@ -58,6 +64,10 @@ fn krealloc() -> Self {
>          Self(bindings::krealloc)
>      }
>
> +    fn vrealloc() -> Self {
> +        Self(bindings::vrealloc)
> +    }

Technically needs an

// INVARIANT: The function pointer is vrealloc.
Self(bindings::vrealloc)

> +
>      // SAFETY: `call` has the exact same safety requirements as `Allocat=
or::realloc`.
>      unsafe fn call(
>          &self,
> @@ -136,6 +146,20 @@ unsafe fn alloc_zeroed(&self, layout: Layout) -> *mu=
t u8 {
>      }
>  }
>
> +unsafe impl Allocator for Vmalloc {
> +    unsafe fn realloc(
> +        ptr: Option<NonNull<u8>>,
> +        layout: Layout,
> +        flags: Flags,
> +    ) -> Result<NonNull<[u8]>, AllocError> {
> +        let realloc =3D ReallocFunc::vrealloc();
> +
> +        // SAFETY: If not `None`, `ptr` is guaranteed to point to valid =
memory, which was previously
> +        // allocated with this `Allocator`.
> +        unsafe { realloc.call(ptr, layout, flags) }
> +    }
> +}
> +
>  #[global_allocator]
>  static ALLOCATOR: Kmalloc =3D Kmalloc;
>
> diff --git a/rust/kernel/alloc/allocator_test.rs b/rust/kernel/alloc/allo=
cator_test.rs
> index 4785efc474a7..e7bf2982f68f 100644
> --- a/rust/kernel/alloc/allocator_test.rs
> +++ b/rust/kernel/alloc/allocator_test.rs
> @@ -7,6 +7,7 @@
>  use core::ptr::NonNull;
>
>  pub struct Kmalloc;
> +pub type Vmalloc =3D Kmalloc;
>
>  unsafe impl Allocator for Kmalloc {
>      unsafe fn realloc(
> --
> 2.45.2
>

