Return-Path: <linux-kernel+bounces-309693-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 86523966F62
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Aug 2024 07:21:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E8AF1B22C11
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Aug 2024 05:21:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A229E13C90A;
	Sat, 31 Aug 2024 05:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="W/YAWbwr"
Received: from mail-4322.protonmail.ch (mail-4322.protonmail.ch [185.70.43.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED49713AD16;
	Sat, 31 Aug 2024 05:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725081703; cv=none; b=jX4cha/Ui9Q+biYhOl6DJ3zH9vjshWEsMk2kfQ8JXSN4vb/mG9DHXwN+H2NJ1+o29OyruOUzjFqk6OUgWInmWEoi2/v7hfvRznRfzPZOPvBrGFL7jmFq1dYN3QLAE4kkam9oHQm+ZJww12DyLgfoAmAv9ZRaFq7zDgARZ6ArWzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725081703; c=relaxed/simple;
	bh=IqYefaBEZFnaqAoFRZKSo6lqVtBx3PHy4lb38p++5Y4=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nDmextBgkxJ50k8jWxIbeURqAHLRA7YQeptR7uP4bIMjDVyqXxck95pkYD32QiJ0wGojtNzDjcD8taQuEqC2fBFfUNYG/U2JMGVmlYtRxZFBuyplopmNb7xJ/YgsBVNOedZNFIOrtY6b+MYhHumJP7zi9GlfZkDt9tmzRBhNYlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=W/YAWbwr; arc=none smtp.client-ip=185.70.43.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1725081691; x=1725340891;
	bh=A1VfMnXiPQMxx6pH7IkEaSr4ATlFOI5jIKJBkF14eNU=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=W/YAWbwrZSWnf9/vXBG4eoa31RuA45gYISApJakLAWYvGj2QMiLnuBa9nH24CuRV7
	 n0YTJYctCxt2mQCIFI92rM1RQSx9p+/OBYsywG3KR88RCBUMWUpUvPmM9dl0Q+oNAw
	 +uwUQDMvlioc6OSVUODIInwdCLr+LONc7Rq5KN/OvIu/tBphZJigT6/ymJUakaJTDG
	 1T7IYMAWdi/UOtxqHupmSVfGE6ZdGewt1rGs2idunt402Sgct/qITFgboSnwKhH/JT
	 Orl571FhGVmolRzfEJLz3ZbBvuOclaOzp8E7KqYjZOvtYlXVg57+9Sky2ddFexXgeU
	 fcrcpCd7acPlQ==
Date: Sat, 31 Aug 2024 05:21:25 +0000
To: Danilo Krummrich <dakr@kernel.org>, ojeda@kernel.org, alex.gaynor@gmail.com, wedsonaf@gmail.com, boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com, a.hindborg@samsung.com, aliceryhl@google.com, akpm@linux-foundation.org
From: Benno Lossin <benno.lossin@proton.me>
Cc: daniel.almeida@collabora.com, faith.ekstrand@collabora.com, boris.brezillon@collabora.com, lina@asahilina.net, mcanal@igalia.com, zhiw@nvidia.com, cjia@nvidia.com, jhubbard@nvidia.com, airlied@redhat.com, ajanulgu@redhat.com, lyude@redhat.com, linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v6 06/26] rust: alloc: implement `Vmalloc` allocator
Message-ID: <808973f5-2c3b-4373-a41b-29e54f3ca4fa@proton.me>
In-Reply-To: <20240816001216.26575-7-dakr@kernel.org>
References: <20240816001216.26575-1-dakr@kernel.org> <20240816001216.26575-7-dakr@kernel.org>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: 46553616bdf28661d31b7f7ab2333e02362d697b
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 16.08.24 02:10, Danilo Krummrich wrote:
> @@ -63,6 +73,9 @@ impl ReallocFunc {
>      // INVARIANT: `krealloc` satisfies the type invariants.
>      const KREALLOC: Self =3D Self(bindings::krealloc);
>=20
> +    // INVARIANT: `vrealloc` satisfies the type invariants.
> +    const VREALLOC: Self =3D Self(bindings::vrealloc);
> +
>      /// # Safety
>      ///
>      /// This method has the same safety requirements as [`Allocator::rea=
lloc`].
> @@ -141,6 +154,25 @@ unsafe fn alloc_zeroed(&self, layout: Layout) -> *mu=
t u8 {
>      }
>  }
>=20
> +unsafe impl Allocator for Vmalloc {

The same safety comment as with `Kmalloc` should fit here (and with
`KVmalloc` too).

---
Cheers,
Benno

> +    #[inline]
> +    unsafe fn realloc(
> +        ptr: Option<NonNull<u8>>,
> +        layout: Layout,
> +        flags: Flags,
> +    ) -> Result<NonNull<[u8]>, AllocError> {
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
> 2.46.0
>=20


