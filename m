Return-Path: <linux-kernel+bounces-276614-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EF956949609
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 19:00:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D8D21F22E5F
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 17:00:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F18B481C4;
	Tue,  6 Aug 2024 17:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="GQxbqjmZ"
Received: from mail-4322.protonmail.ch (mail-4322.protonmail.ch [185.70.43.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 273BC34CD8
	for <linux-kernel@vger.kernel.org>; Tue,  6 Aug 2024 17:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722963636; cv=none; b=k6Vryje49mVORPcu/u5KY1W+TdUVy1AinDtdQpzFWAvUHfMX2F0xfXsM4uwyeznRpDlA+veTVg8D08lm/3qsu+KX0BoAb+Y8FT6StGPRdbvwS9f+NaFVPN0vCmQrCY7ILUG8kX4ZVAEXpwOYdG25y1myHjgCRu5F7JqriRkIbos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722963636; c=relaxed/simple;
	bh=bQVZBvnxjPptFlh9gAx7UhEr45KLbvAqhbKlShH90FI=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=t916dc1hmAW9+RuyhiOaQAjclkplfw9/+7aJ1fKy0dkoubZy7MLhKa03Z1Z5uiIjG/S4T6ITC3q8mHSFdpAkt2uFgjRF2cbIMZVOuVs3OPL96CgqN+/JFBA5Ib/Dx4rX+USDiKarNfRM7qmXOMVHrToW7BI78hKNqjmijWn3QUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=GQxbqjmZ; arc=none smtp.client-ip=185.70.43.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1722963631; x=1723222831;
	bh=NIEcKfgadTZh0kNRg05u+3nH5Xy+VxOaSmfkkT347rU=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=GQxbqjmZEDoi65FP028FrB9um2wuA1hrfASYc20HjVmY7YenU0Ae8CHvh53tgkp06
	 IXMxma13LwqWmuPHCKBnol9jvjrR6LVFGiO35bf0vqYMaMjS5e1jFIzrugweNrE3Bj
	 tM90QhR3pYA958Y9NlTAYPyFS+e0HmLKlqdYvsVMb6N2kEumIjmdcIfUZ8W+3OY1KV
	 sJJGBba/oAycTdE9KwvGxHAueaIOPz6zkON26xKsfG1/lquV7iVL0jM9VkaNJJPBtD
	 yihvSlZOl1G9XOpP+xhxkwDw3cJHBHxiIbytGMg+k7KtoLxBCn0fv/g4+UQ3VBuB6l
	 qwckLppSHce8w==
Date: Tue, 06 Aug 2024 17:00:24 +0000
To: Danilo Krummrich <dakr@kernel.org>, ojeda@kernel.org, alex.gaynor@gmail.com, wedsonaf@gmail.com, boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com, a.hindborg@samsung.com, aliceryhl@google.com, akpm@linux-foundation.org
From: Benno Lossin <benno.lossin@proton.me>
Cc: daniel.almeida@collabora.com, faith.ekstrand@collabora.com, boris.brezillon@collabora.com, lina@asahilina.net, mcanal@igalia.com, zhiw@nvidia.com, acurrid@nvidia.com, cjia@nvidia.com, jhubbard@nvidia.com, airlied@redhat.com, ajanulgu@redhat.com, lyude@redhat.com, linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v4 06/28] rust: alloc: implement `Vmalloc` allocator
Message-ID: <9c144953-819d-44fa-9bb5-af6fa93a5042@proton.me>
In-Reply-To: <20240805152004.5039-7-dakr@kernel.org>
References: <20240805152004.5039-1-dakr@kernel.org> <20240805152004.5039-7-dakr@kernel.org>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: 0890d966cb92e9d75463d347488d1209ade4142f
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 05.08.24 17:19, Danilo Krummrich wrote:
> Implement `Allocator` for `Vmalloc`, the kernel's virtually contiguous
> allocator, typically used for larger objects, (much) larger than page
> size.
>=20
> All memory allocations made with `Vmalloc` end up in `vrealloc()`.
>=20
> Reviewed-by: Alice Ryhl <aliceryhl@google.com>
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>
> ---
>  rust/helpers.c                      |  7 +++++++
>  rust/kernel/alloc/allocator.rs      | 32 +++++++++++++++++++++++++++++
>  rust/kernel/alloc/allocator_test.rs |  1 +
>  3 files changed, 40 insertions(+)
>=20
> diff --git a/rust/helpers.c b/rust/helpers.c
> index 9f7275493365..7406943f887d 100644
> --- a/rust/helpers.c
> +++ b/rust/helpers.c
> @@ -33,6 +33,7 @@
>  #include <linux/sched/signal.h>
>  #include <linux/slab.h>
>  #include <linux/spinlock.h>
> +#include <linux/vmalloc.h>
>  #include <linux/wait.h>
>  #include <linux/workqueue.h>
>=20
> @@ -199,6 +200,12 @@ void *rust_helper_krealloc(const void *objp, size_t =
new_size, gfp_t flags)
>  }
>  EXPORT_SYMBOL_GPL(rust_helper_krealloc);
>=20
> +void *rust_helper_vrealloc(const void *p, size_t size, gfp_t flags)
> +{
> +=09return vrealloc(p, size, flags);
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
> index c6ad1dd59dd0..bb55895cbd03 100644
> --- a/rust/kernel/alloc/allocator.rs
> +++ b/rust/kernel/alloc/allocator.rs
> @@ -9,6 +9,7 @@
>=20
>  use crate::alloc::{AllocError, Allocator};
>  use crate::bindings;
> +use crate::pr_warn;
>=20
>  /// The contiguous kernel allocator.
>  ///
> @@ -16,6 +17,12 @@
>  /// `bindings::krealloc`.
>  pub struct Kmalloc;
>=20
> +/// The virtually contiguous kernel allocator.
> +///
> +/// The vmalloc allocator allocates pages from the page level allocator =
and maps them into the
> +/// contiguous kernel virtual space.
> +pub struct Vmalloc;

One thing that I should also have mentioned for `Kmalloc`, do we want
these types to also have values? I don't think that we need them to be,
so we could declare them as `pub enum Vmalloc {}`.

> +
>  /// Returns a proper size to alloc a new object aligned to `new_layout`'=
s alignment.
>  fn aligned_size(new_layout: Layout) -> usize {
>      // Customized layouts from `Layout::from_size_align()` can have size=
 < align, so pad first.
> @@ -61,6 +68,11 @@ fn krealloc() -> Self {
>          Self(bindings::krealloc)
>      }
>=20
> +    // INVARIANT: `vrealloc` satisfies the type invariants.

This should be moved down a line.

---
Cheers,
Benno

> +    fn vrealloc() -> Self {
> +        Self(bindings::vrealloc)
> +    }
> +
>      /// # Safety
>      ///
>      /// This method has the exact same safety requirements as `Allocator=
::realloc`.
> @@ -141,6 +153,26 @@ unsafe fn alloc_zeroed(&self, layout: Layout) -> *mu=
t u8 {
>      }
>  }
>=20
> +unsafe impl Allocator for Vmalloc {
> +    unsafe fn realloc(
> +        ptr: Option<NonNull<u8>>,
> +        layout: Layout,
> +        flags: Flags,
> +    ) -> Result<NonNull<[u8]>, AllocError> {
> +        let realloc =3D ReallocFunc::vrealloc();
> +
> +        // TODO: Support alignments larger than PAGE_SIZE.
> +        if layout.align() > bindings::PAGE_SIZE {
> +            pr_warn!("Vmalloc does not support alignments larger than PA=
GE_SIZE yet.\n");
> +            return Err(AllocError);
> +        }
> +
> +        // SAFETY: If not `None`, `ptr` is guaranteed to point to valid =
memory, which was previously
> +        // allocated with this `Allocator`.
> +        unsafe { realloc.call(ptr, layout, flags) }

I am a bit confused, for `Kmalloc`, you manually returned
`NonNull::dangling` when allocating a zero-sized allocation, but here
you don't?

---
Cheers,
Benno

> +    }
> +}
> +
>  #[global_allocator]
>  static ALLOCATOR: Kmalloc =3D Kmalloc;
>=20
> diff --git a/rust/kernel/alloc/allocator_test.rs b/rust/kernel/alloc/allo=
cator_test.rs
> index 4785efc474a7..e7bf2982f68f 100644
> --- a/rust/kernel/alloc/allocator_test.rs
> +++ b/rust/kernel/alloc/allocator_test.rs
> @@ -7,6 +7,7 @@
>  use core::ptr::NonNull;
>=20
>  pub struct Kmalloc;
> +pub type Vmalloc =3D Kmalloc;
>=20
>  unsafe impl Allocator for Kmalloc {
>      unsafe fn realloc(
> --
> 2.45.2
>=20


