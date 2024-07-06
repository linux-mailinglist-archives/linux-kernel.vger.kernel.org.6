Return-Path: <linux-kernel+bounces-243160-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7087292929D
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jul 2024 12:41:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 56BDB1C20E1B
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jul 2024 10:41:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDB1E7172F;
	Sat,  6 Jul 2024 10:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="BISU96iq"
Received: from mail-4316.protonmail.ch (mail-4316.protonmail.ch [185.70.43.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 581FF5695;
	Sat,  6 Jul 2024 10:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720262502; cv=none; b=Misl5ALD0/fhH4P6kkaR7+mGwho1AanU1xXaj+nRC68tyUqvpWC4PdU+J6zCeyEkVoKMwT9w4aSX83b6CkXJo4pQ6mvRwWkaS8JF9VLVKWgp8YSQGJV7bH2ICj6IBzFZwCT2vYgnasbL3j28n0BRF02JZT/pXSRXFn2Tt8jvYO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720262502; c=relaxed/simple;
	bh=IJpjHkSPHZUsM3sBRTmM30fDfJnR3b8cLdQHNE7PHwI=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=q40quXAGfpoMJzNpVpbowNxdOaUXQ/Gw7RP3iR8cS66ATFOs0YEefQbRs0NZIu6JXMdRv5xHeeSlXPEABMSfIf6P/qYU0Imv3MQ1vbnJbvtH63Ql+OKJGjx9nWSoyqv4Oml30IDT6UozIkLR6cVPsnvqXaBSWhijODHtJvPSN+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=BISU96iq; arc=none smtp.client-ip=185.70.43.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1720262493; x=1720521693;
	bh=w4h8NQSUQv78RzPLs46A/v8/4gFfYSJVkRa/3pfdLa4=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=BISU96iqzVfwxZZ4KKpV0mrKB57o7HBIW+unDSKiZBGezBRvY3+Pnn1vAFBtY8WUk
	 TnX2tScvHUlaaCQC03Z3O5UrMOzZaPzSxPAKqJtOUswBMcv4kzfwe+Z0QqYROwuQGr
	 Jyj1LMpU4UnO4a0F/ATvoNoSdHZ8SD743USpZJt+l+pNo5GNQAvfbCMFbmfACXMH7g
	 SyyonGq42CcO9EQdXnED++rocaA2DxtDZdq/7FyOE2fxcHPajGmEsOos4YjJNaWmzW
	 QGocEuekT5jpu/sIbKGWhSbsE0j5fVGeRCFDFjxYuE4HFVoE1EwK3aZqbU1wHqnMP5
	 OKGvBedP9oDMQ==
Date: Sat, 06 Jul 2024 10:41:28 +0000
To: Danilo Krummrich <dakr@redhat.com>, ojeda@kernel.org, alex.gaynor@gmail.com, wedsonaf@gmail.com, boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com, a.hindborg@samsung.com, aliceryhl@google.com
From: Benno Lossin <benno.lossin@proton.me>
Cc: daniel.almeida@collabora.com, faith.ekstrand@collabora.com, boris.brezillon@collabora.com, lina@asahilina.net, mcanal@igalia.com, zhiw@nvidia.com, acurrid@nvidia.com, cjia@nvidia.com, jhubbard@nvidia.com, airlied@redhat.com, ajanulgu@redhat.com, lyude@redhat.com, linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org
Subject: Re: [PATCH 07/20] rust: alloc: implement `Vmalloc` allocator
Message-ID: <596c6446-eca4-46a8-91c5-e71e92c61062@proton.me>
In-Reply-To: <20240704170738.3621-8-dakr@redhat.com>
References: <20240704170738.3621-1-dakr@redhat.com> <20240704170738.3621-8-dakr@redhat.com>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: b26e30de595f87380eaa36b76b9b95b4582c341f
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 04.07.24 19:06, Danilo Krummrich wrote:
> @@ -112,6 +118,55 @@ unsafe fn alloc_zeroed(&self, layout: Layout) -> *mu=
t u8 {
>      }
>  }
>=20
> +unsafe impl Allocator for Vmalloc {
> +    unsafe fn realloc(
> +        &self,
> +        src: *mut u8,
> +        old_size: usize,
> +        layout: Layout,
> +        flags: Flags,
> +    ) -> Result<NonNull<[u8]>, AllocError> {
> +        let mut size =3D aligned_size(layout);
> +
> +        let dst =3D if size =3D=3D 0 {
> +            // SAFETY: `src` is guaranteed to be previously allocated wi=
th this `Allocator` or NULL.
> +            unsafe { bindings::vfree(src.cast()) };
> +            NonNull::dangling()
> +        } else if size <=3D old_size {
> +            size =3D old_size;
> +            NonNull::new(src).ok_or(AllocError)?
> +        } else {
> +            // SAFETY: `src` is guaranteed to point to valid memory with=
 a size of at least
> +            // `old_size`, which was previously allocated with this `All=
ocator` or NULL.
> +            let dst =3D unsafe { bindings::__vmalloc_noprof(size as u64,=
 flags.0) };
> +
> +            // Validate that we actually allocated the requested memory.
> +            let dst =3D NonNull::new(dst.cast()).ok_or(AllocError)?;
> +
> +            if !src.is_null() {
> +                // SAFETY: `src` is guaranteed to point to valid memory =
with a size of at least
> +                // `old_size`; `dst` is guaranteed to point to valid mem=
ory with a size of at least
> +                // `size`.
> +                unsafe {
> +                    core::ptr::copy_nonoverlapping(
> +                        src,
> +                        dst.as_ptr(),
> +                        core::cmp::min(old_size, size),
> +                    )
> +                };
> +
> +                // SAFETY: `src` is guaranteed to be previously allocate=
d with this `Allocator` or
> +                // NULL.
> +                unsafe { bindings::vfree(src.cast()) }
> +            }
> +
> +            dst
> +        };

If we had not a single realloc, but shrink/grow/free/alloc, then we
would not need these checks here, I personally would prefer that, what
do you guys think?=20

---
Cheers,
Benno

> +
> +        Ok(NonNull::slice_from_raw_parts(dst, size))
> +    }
> +}
> +
>  #[global_allocator]
>  static ALLOCATOR: Kmalloc =3D Kmalloc;
>=20
> diff --git a/rust/kernel/alloc/allocator_test.rs b/rust/kernel/alloc/allo=
cator_test.rs
> index 3a0abe65491d..b2d7db492ba6 100644
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


