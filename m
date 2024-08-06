Return-Path: <linux-kernel+bounces-276604-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A71A59495F3
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 18:54:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5BD762821EC
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 16:54:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DDFB4EB45;
	Tue,  6 Aug 2024 16:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="PRxwg9+P"
Received: from mail-40134.protonmail.ch (mail-40134.protonmail.ch [185.70.40.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 217B54AEF4
	for <linux-kernel@vger.kernel.org>; Tue,  6 Aug 2024 16:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722963260; cv=none; b=Vy0xWQyDbMt3Dd/6ZEVw2bm/FE1IQE8Xg1bqx3JhNN234MJAynVpy1hWTsRWfYWtqxG62BlBScfRMjxmrJWfXn6Q+8vnlN2gI2NGlXT9YsTsoPPSYpo6xudcLGGBdN/UDaykUJyhqbAlKpXFYbBnYVSad9GDQvaR0I/iuYrvLoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722963260; c=relaxed/simple;
	bh=YS9rbKdLk8vd/TfnSYA6rbAgcnoYyLKSyQLlujWMzl8=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FDxdRoxO4/PGGmRfIQmACGZIMw50z2FUvQUxwAKDW6/KYlDWQ+2rVRdLK77JvZkZ/Gv26VN/5lJ0bsWSjXzhOJu90Ycskj4oyXBd5OYnXBKbreAS5XaQHuepJT7ogcR+C/UHhxcG2zzMnmxlVn2E4iktEi8IZx2M3ag/vVNDFZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=PRxwg9+P; arc=none smtp.client-ip=185.70.40.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1722963256; x=1723222456;
	bh=JyaLofqIf3cc8LFmc/BZCxfEIWaUzKwUqRl9VTHoZS0=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=PRxwg9+PqydYPaCBNDPXBzrb10m+Ioy4IB01yG48JRYf6yMf9fVB9vrLwIyOiBXLy
	 tFLWjU8n3LiDeVkltb/54eOGF7gTJVMtsLM8T8Z1M6hOQPTaCHJ78dFZgFJMybXnMt
	 l+P4V9MfgZRVFlxrt3GHc8bvVkhQJbobcS/e7Go3bHPMOXv8PxIA0XZ0Q48EJu+usa
	 WR9x16UA9n01pbX4uXunSwitaOLTJO+MhGJpJQi2UbEoLvdT6Q6Ou5lIsIBQiy5vPh
	 r0aNPN4BHiAhT95e/lvGylyhfgsMJ+ORdJmUcl8W3TdDGbaAU49XiMzc8zTfmc2Eog
	 aoTU/vnNuGAcQ==
Date: Tue, 06 Aug 2024 16:54:10 +0000
To: Danilo Krummrich <dakr@kernel.org>, ojeda@kernel.org, alex.gaynor@gmail.com, wedsonaf@gmail.com, boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com, a.hindborg@samsung.com, aliceryhl@google.com, akpm@linux-foundation.org
From: Benno Lossin <benno.lossin@proton.me>
Cc: daniel.almeida@collabora.com, faith.ekstrand@collabora.com, boris.brezillon@collabora.com, lina@asahilina.net, mcanal@igalia.com, zhiw@nvidia.com, acurrid@nvidia.com, cjia@nvidia.com, jhubbard@nvidia.com, airlied@redhat.com, ajanulgu@redhat.com, lyude@redhat.com, linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v4 05/28] rust: alloc: add module `allocator_test`
Message-ID: <7f4b91e6-aae8-4e17-9fcd-4b1d0b2de9a0@proton.me>
In-Reply-To: <20240805152004.5039-6-dakr@kernel.org>
References: <20240805152004.5039-1-dakr@kernel.org> <20240805152004.5039-6-dakr@kernel.org>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: 2ee00e2816ba67eeed385eac8e0a32473e2a9116
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 05.08.24 17:19, Danilo Krummrich wrote:
> `Allocator`s, such as `Kmalloc`, will be used by e.g. `Box` and `Vec` in
> subsequent patches, and hence this dependency propagates throughout the
> whole kernel.
>=20
> Add the `allocator_test` module that provides an empty implementation
> for all `Allocator`s in the kernel, such that we don't break the
> `rusttest` make target in subsequent patches.

This is confusing, since you are talking about both our new `Allocator`
trait, allocators and the `alloc` crate `Allocator`.

> Reviewed-by: Alice Ryhl <aliceryhl@google.com>
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>
> ---
>  rust/kernel/alloc.rs                |  9 +++++++--
>  rust/kernel/alloc/allocator_test.rs | 19 +++++++++++++++++++
>  2 files changed, 26 insertions(+), 2 deletions(-)
>  create mode 100644 rust/kernel/alloc/allocator_test.rs
>=20
> diff --git a/rust/kernel/alloc.rs b/rust/kernel/alloc.rs
> index bc01a17df5e0..942e2755f217 100644
> --- a/rust/kernel/alloc.rs
> +++ b/rust/kernel/alloc.rs
> @@ -2,12 +2,17 @@
>=20
>  //! Extensions to the [`alloc`] crate.
>=20
> -#[cfg(not(test))]
> -#[cfg(not(testlib))]
> +#[cfg(not(any(test, testlib)))]
>  pub mod allocator;
>  pub mod box_ext;
>  pub mod vec_ext;
>=20
> +#[cfg(any(test, testlib))]
> +pub mod allocator_test;
> +
> +#[cfg(any(test, testlib))]
> +pub use self::allocator_test as allocator;
> +
>  /// Indicates an allocation error.
>  #[derive(Copy, Clone, PartialEq, Eq, Debug)]
>  pub struct AllocError;
> diff --git a/rust/kernel/alloc/allocator_test.rs b/rust/kernel/alloc/allo=
cator_test.rs
> new file mode 100644
> index 000000000000..4785efc474a7
> --- /dev/null
> +++ b/rust/kernel/alloc/allocator_test.rs
> @@ -0,0 +1,19 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#![allow(missing_docs)]
> +
> +use super::{AllocError, Allocator, Flags};
> +use core::alloc::Layout;
> +use core::ptr::NonNull;
> +
> +pub struct Kmalloc;
> +
> +unsafe impl Allocator for Kmalloc {
> +    unsafe fn realloc(
> +        _ptr: Option<NonNull<u8>>,
> +        _layout: Layout,
> +        _flags: Flags,
> +    ) -> Result<NonNull<[u8]>, AllocError> {
> +        panic!();

Does `build_error!()` also work? If yes, then I would prefer that.

---
Cheers,
Benno

> +    }
> +}
> --
> 2.45.2
>=20


