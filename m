Return-Path: <linux-kernel+bounces-286892-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 04D00952014
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 18:33:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 08C172894AA
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 16:32:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7FFF1B9B3E;
	Wed, 14 Aug 2024 16:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="Jr+E9Sdp"
Received: from mail-40134.protonmail.ch (mail-40134.protonmail.ch [185.70.40.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3173C1B5816;
	Wed, 14 Aug 2024 16:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723653162; cv=none; b=Th15YX1Bf2njJ2YPGYpvUhpuQkm8viAOmQeHOrZ30OUDl39+wExUKxOd67uxmzFYIUo2GwEYpogMV+2Roaw/ATRtsV0UZDwt75F9njldObVex5ds8xmYFRrCsx8e0mOTbDfcwT3SCT9rSF2zVWglW3gjnh+laWY+cZ2OpgIBvQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723653162; c=relaxed/simple;
	bh=YYEs76+BWZ0Oj8YVGf2Fub642KbnoevLFK2XkEvq30k=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pskZ2pWWZHFBnYUOravFcm5yRsm8i+mU+2Y8Kr/2ZWeMuc6Z7Y4XBno6YBSMkYXmn0fHsGH20pWd2IUXwsEbPShkESy6gjJHJC84IonyMksD6517sJ7UE63qpfXM9oP57j2uzjjzBb+a5drJYOyGti/9NLlDNCnUN49VOhYG70I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=Jr+E9Sdp; arc=none smtp.client-ip=185.70.40.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1723653159; x=1723912359;
	bh=HzRjnEYxCgd5sweSvuIswq75tHrQWV8FRv4rbaoLB8o=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=Jr+E9SdpuUvEJBPiSuhavO9knHg4/Jmoz3U6JzWGbxUA0VXUyt09BFa8+h1IKllu/
	 pqqSKEufaHwz7Oxv2AZXLRY0CrJIwsRcaPWiJUw31Vb/UahypkScE2+y4iMwVH1Egk
	 SK64dQ0qcjzR8S/Gvd3coWeLb9+44yJISQCUsE06HHPiovw9zSrYrhDzLchMeMqeYJ
	 beAn3yGqTbKW7/dzlFFBh4DSusxb1MnerNUaFi1EUPAY1ChenpU4chrskkSbBOFzSY
	 1Kdy9EC84BUTht6TiUVEySLxpx7umeuJNGFcTKyvF4e1lsa83C1vEa0PRd3QwnnAQZ
	 jvawIdMVHa1lw==
Date: Wed, 14 Aug 2024 16:32:34 +0000
To: Danilo Krummrich <dakr@kernel.org>, ojeda@kernel.org, alex.gaynor@gmail.com, wedsonaf@gmail.com, boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com, a.hindborg@samsung.com, aliceryhl@google.com, akpm@linux-foundation.org
From: Benno Lossin <benno.lossin@proton.me>
Cc: daniel.almeida@collabora.com, faith.ekstrand@collabora.com, boris.brezillon@collabora.com, lina@asahilina.net, mcanal@igalia.com, zhiw@nvidia.com, cjia@nvidia.com, jhubbard@nvidia.com, airlied@redhat.com, ajanulgu@redhat.com, lyude@redhat.com, linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v5 06/26] rust: alloc: implement `Vmalloc` allocator
Message-ID: <c9d57e77-8748-4e58-a39b-7a23f750ceda@proton.me>
In-Reply-To: <20240812182355.11641-7-dakr@kernel.org>
References: <20240812182355.11641-1-dakr@kernel.org> <20240812182355.11641-7-dakr@kernel.org>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: 514667304e528ccd1bc15957b6357b3f74a19a4b
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 12.08.24 20:22, Danilo Krummrich wrote:
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
>  rust/kernel/alloc/allocator.rs      | 28 ++++++++++++++++++++++++++++
>  rust/kernel/alloc/allocator_test.rs |  1 +
>  3 files changed, 36 insertions(+)
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
> index b46883d87715..fdda22c6983f 100644
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
> +
>  /// Returns a proper size to alloc a new object aligned to `new_layout`'=
s alignment.
>  fn aligned_size(new_layout: Layout) -> usize {
>      // Customized layouts from `Layout::from_size_align()` can have size=
 < align, so pad first.
> @@ -55,6 +62,9 @@ impl ReallocFunc {
>      // INVARIANT: `krealloc` satisfies the type invariants.
>      const KREALLOC: Self =3D Self(bindings::krealloc);
>=20
> +    // INVARIANT: `vrealloc` satisfies the type invariants.
> +    const VREALLOC: Self =3D Self(bindings::vrealloc);
> +
>      /// # Safety
>      ///
>      /// This method has the same safety requirements as `Allocator::real=
loc`.
> @@ -132,6 +142,24 @@ unsafe fn alloc_zeroed(&self, layout: Layout) -> *mu=
t u8 {
>      }
>  }
>=20
> +unsafe impl Allocator for Vmalloc {

Missing SAFETY comment.

> +    unsafe fn realloc(

Does this need `#[inline]`?

> +        ptr: Option<NonNull<u8>>,
> +        layout: Layout,
> +        flags: Flags,
> +    ) -> Result<NonNull<[u8]>, AllocError> {
> +        // TODO: Support alignments larger than PAGE_SIZE.
> +        if layout.align() > bindings::PAGE_SIZE {
> +            pr_warn!("Vmalloc does not support alignments larger than PA=
GE_SIZE yet.\n");
> +            return Err(AllocError);

I think here we should first try to use `build_error!`, most often the
alignment will be specified statically, so it should get optimized away.

How difficult will it be to support this? (it is a weird requirement,
but I dislike just returning an error...)

---
Cheers,
Benno

> +        }
> +
> +        // SAFETY: If not `None`, `ptr` is guaranteed to point to valid =
memory, which was previously
> +        // allocated with this `Allocator`.
> +        unsafe { ReallocFunc::VREALLOC.call(ptr, layout, flags) }
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


