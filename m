Return-Path: <linux-kernel+bounces-276558-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D84E94953D
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 18:07:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C03471F222CE
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 16:07:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95A2F383A2;
	Tue,  6 Aug 2024 16:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="DK9UsCwg"
Received: from mail-4322.protonmail.ch (mail-4322.protonmail.ch [185.70.43.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E3D72EB10;
	Tue,  6 Aug 2024 16:06:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722960383; cv=none; b=aJP65VOSQtpAcf/sRh2BaRGA6Cx+vdFJ6wGcubARZfzfp7NOdtrmuy5M2xgMdrvylzzVBRWImZDHibsp7hbnc35PkmNU4+vZRBOc6vk+EuO/78QiBbqxhR1Arx31CrIzs8M9AvGZTp2ke9L06a4ESc3qkxw8bzOBXae06YNPNM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722960383; c=relaxed/simple;
	bh=ymbZa+/qXj1Pp3mytnNK/X5NKedqcGp12zClIcs+U50=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fbgNQ2BbH6z8ywtwcFNmI/a9RRMT7CKmrHEltXbv0ko347pQh5zO4bvKXjWC4ktkzkAp5bqNF60QGmdneDlRl9rQa/aiSCpXKb2Enxmes/O6bAqewASJRbW4AZWsVuHJKqRkNj00XHKNSt0hjE8/TxLil+Msw7fzc5sUKO+VjmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=DK9UsCwg; arc=none smtp.client-ip=185.70.43.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1722960380; x=1723219580;
	bh=mlhTAM6ZiLpoZgUUpSWbqGvf2fRVZ9P9Bjbr6GNY4yk=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=DK9UsCwgE8AotX3XYEaS+lkaXI/0SdEdIPah+KAbNMS8s49hAYzjpt8iNG6T9Hfh3
	 ybn01IzeGDMDOfpM8PjhNr4FFlZE9TiQcyEbZ8Fh++utferc3utkdQUp9T3BV/7BOY
	 sGFd+Na5KFx8pD5YA3Z8iMaBR+y425tE/muQgqmxYq3F1xL7G8u9ac7LF9Hf/HdNYL
	 Djb8QL6EZOU1fiGTvaK2m0Evgc2iTSDzOQeljxxwSQOJgEvT9US0R/sODP4s/JUrDv
	 hf4on8QkTVmdGIR99PagNC1t3HvZBOv+NDmJknKQmVQldI14oQd9g82dlS9OQzHYHD
	 fp39lAgncBK8Q==
Date: Tue, 06 Aug 2024 16:06:14 +0000
To: Danilo Krummrich <dakr@kernel.org>, ojeda@kernel.org, alex.gaynor@gmail.com, wedsonaf@gmail.com, boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com, a.hindborg@samsung.com, aliceryhl@google.com, akpm@linux-foundation.org
From: Benno Lossin <benno.lossin@proton.me>
Cc: daniel.almeida@collabora.com, faith.ekstrand@collabora.com, boris.brezillon@collabora.com, lina@asahilina.net, mcanal@igalia.com, zhiw@nvidia.com, acurrid@nvidia.com, cjia@nvidia.com, jhubbard@nvidia.com, airlied@redhat.com, ajanulgu@redhat.com, lyude@redhat.com, linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v4 02/28] rust: alloc: separate `aligned_size` from `krealloc_aligned`
Message-ID: <10c87505-bf27-4685-af10-6c15fcf8c854@proton.me>
In-Reply-To: <20240805152004.5039-3-dakr@kernel.org>
References: <20240805152004.5039-1-dakr@kernel.org> <20240805152004.5039-3-dakr@kernel.org>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: ff23bda0148e35d5412c6c8021c32c60276fbda6
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 05.08.24 17:19, Danilo Krummrich wrote:
> Separate `aligned_size` from `krealloc_aligned`.
>=20
> Subsequent patches implement `Allocator` derivates, such as `Kmalloc`,
> that require `aligned_size` and replace the original `krealloc_aligned`.
>=20
> Reviewed-by: Alice Ryhl <aliceryhl@google.com>
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>
> ---
>  rust/kernel/alloc/allocator.rs | 27 ++++++++++++++++++---------
>  1 file changed, 18 insertions(+), 9 deletions(-)
>=20
> diff --git a/rust/kernel/alloc/allocator.rs b/rust/kernel/alloc/allocator=
.rs
> index e6ea601f38c6..e7b7eba84acb 100644
> --- a/rust/kernel/alloc/allocator.rs
> +++ b/rust/kernel/alloc/allocator.rs
> @@ -8,27 +8,36 @@
>=20
>  struct KernelAllocator;
>=20
> -/// Calls `krealloc` with a proper size to alloc a new object aligned to=
 `new_layout`'s alignment.
> -///
> -/// # Safety
> -///
> -/// - `ptr` can be either null or a pointer which has been allocated by =
this allocator.
> -/// - `new_layout` must have a non-zero size.
> -pub(crate) unsafe fn krealloc_aligned(ptr: *mut u8, new_layout: Layout, =
flags: Flags) -> *mut u8 {
> +/// Returns a proper size to alloc a new object aligned to `new_layout`'=
s alignment.
> +fn aligned_size(new_layout: Layout) -> usize {
>      // Customized layouts from `Layout::from_size_align()` can have size=
 < align, so pad first.
>      let layout =3D new_layout.pad_to_align();
>=20
>      // Note that `layout.size()` (after padding) is guaranteed to be a m=
ultiple of `layout.align()`
>      // which together with the slab guarantees means the `krealloc` will=
 return a properly aligned
>      // object (see comments in `kmalloc()` for more information).
> -    let size =3D layout.size();
> +    layout.size()
> +}
>=20
> +/// Calls `krealloc` with a proper size to alloc a new object aligned to=
 `new_layout`'s alignment.
> +///
> +/// # Safety
> +///
> +/// - `ptr` can be either null or a pointer which has been allocated by =
this allocator.
> +/// - `new_layout` must have a non-zero size.
> +pub(crate) unsafe fn krealloc_aligned(ptr: *mut u8, new_layout: Layout, =
flags: Flags) -> *mut u8 {
>      // SAFETY:
>      // - `ptr` is either null or a pointer returned from a previous `k{r=
e}alloc()` by the
>      //   function safety requirement.
>      // - `size` is greater than 0 since it's from `layout.size()` (which=
 cannot be zero according
>      //   to the function safety requirement)
> -    unsafe { bindings::krealloc(ptr as *const core::ffi::c_void, size, f=
lags.0) as *mut u8 }
> +    unsafe {
> +        bindings::krealloc(
> +            ptr as *const core::ffi::c_void,
> +            aligned_size(new_layout),

Can you move the safe operation outside of the `unsafe` block?

With that changed,

Reviewed-by: Benno Lossin <benno.lossin@proton.me>

---
Cheers,
Benno

> +            flags.0,
> +        ) as *mut u8
> +    }
>  }
>=20
>  unsafe impl GlobalAlloc for KernelAllocator {
> --
> 2.45.2
>=20


