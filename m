Return-Path: <linux-kernel+bounces-243159-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5385892929A
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jul 2024 12:37:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 18DC32825BB
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jul 2024 10:37:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D932A6F06B;
	Sat,  6 Jul 2024 10:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="WwetU0sB"
Received: from mail-40131.protonmail.ch (mail-40131.protonmail.ch [185.70.40.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 874745695
	for <linux-kernel@vger.kernel.org>; Sat,  6 Jul 2024 10:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720262228; cv=none; b=Dzk60LaMmsGFtQP+uYtMtll8/6Ah+8BeYSUJwZEIUJ3QhkuVAp8NSRS2p/K2YY3PsPtUfSuYtbWWO7cfOOmIRoH0Umj7eJVqce4Xjl4C2B9yQxG2o0DOlQeP00T2dUMG/UM6PBccMrU+hihCphOpi36jMohkBhOLs53PjoitDqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720262228; c=relaxed/simple;
	bh=ak1MiwVC7DL5GRpVTZ3qPO0dgRlceI+xALCMmMuK+qc=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NaPF+FUarAwjKIKuYHm73wLtI+gyEL6EPRvjgr/8iE6LXaMnd0GDZLGcEUT/bAMMZLzS6TXpUs6BVMmbxBozw636u4+uR818q1RHjU4kpMCH5QD9Sh+eqVuUNHygdrpdMZz2CGEcNUNScJ2VlAxbLhRPfwgS/agajFrerPzubbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=WwetU0sB; arc=none smtp.client-ip=185.70.40.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1720262224; x=1720521424;
	bh=d5zWGPfRfblVjg4t2TgxqrBDoVfb2JhIB/PRQhpwxG0=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=WwetU0sBDX5/tk3aKV+0U0UyZF7p+4xdrMdXiCacXK38rHVR5waLzxou97chgMW5+
	 LWRYs7+HZ7SDz/2Z3xiobIYRXYtd+p6vIErSgn0LloIQ5yozyHPcjila37nKnsz1et
	 ZYLTdoLU24MuUCorlFuxqLqJfQnBZhvYtXyH3mSd418o08Y/V1TcyggRqlpdlUEer3
	 iLtDwqdlzh6Frvix8sASanyC/YTDStw4nCM83wtbA78a1lne3+vu6csRtGbcPewfTX
	 2+Jx+LHO9T/6qXEBZGFZSLjqHYTk1JUsAJd4oiuexusgYabL1NQqNxNqY9mwHCwGEP
	 C3nVwXNysZAUg==
Date: Sat, 06 Jul 2024 10:37:00 +0000
To: Danilo Krummrich <dakr@redhat.com>, ojeda@kernel.org, alex.gaynor@gmail.com, wedsonaf@gmail.com, boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com, a.hindborg@samsung.com, aliceryhl@google.com
From: Benno Lossin <benno.lossin@proton.me>
Cc: daniel.almeida@collabora.com, faith.ekstrand@collabora.com, boris.brezillon@collabora.com, lina@asahilina.net, mcanal@igalia.com, zhiw@nvidia.com, acurrid@nvidia.com, cjia@nvidia.com, jhubbard@nvidia.com, airlied@redhat.com, ajanulgu@redhat.com, lyude@redhat.com, linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org
Subject: Re: [PATCH 04/20] rust: alloc: implement `Allocator` for `Kmalloc`
Message-ID: <033c72ba-fb31-4eff-b98c-5c5d35057280@proton.me>
In-Reply-To: <20240704170738.3621-5-dakr@redhat.com>
References: <20240704170738.3621-1-dakr@redhat.com> <20240704170738.3621-5-dakr@redhat.com>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: fe3bbef5f705ba42d091a458c33063a8d756b426
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 04.07.24 19:06, Danilo Krummrich wrote:
> @@ -48,20 +57,54 @@ pub(crate) unsafe fn krealloc_aligned(ptr: *mut u8, n=
ew_layout: Layout, flags: F
>      }
>  }
>=20
> +unsafe impl Allocator for Kmalloc {
> +    unsafe fn realloc(
> +        &self,
> +        old_ptr: *mut u8,
> +        _old_size: usize,
> +        layout: Layout,
> +        flags: Flags,
> +    ) -> Result<NonNull<[u8]>, AllocError> {
> +        let size =3D aligned_size(layout);
> +
> +        // SAFETY: `src` is guaranteed to point to valid memory with a s=
ize of at least
> +        // `old_size`, which was previously allocated with this `Allocat=
or` or NULL.
> +        let raw_ptr =3D unsafe {
> +            // If `size =3D=3D 0` and `old_ptr !=3D NULL` `krealloc()` f=
rees the memory behind the
> +            // pointer.
> +            bindings::krealloc(old_ptr.cast(), size, flags.0).cast()
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
>  unsafe impl GlobalAlloc for Kmalloc {

Since you remove `alloc` entirely at the end of this series, do we even
need this?
If not, it would be best to just leave the implementation as-is until a
patch removes it entirely.

---
Cheers,
Benno

>      unsafe fn alloc(&self, layout: Layout) -> *mut u8 {
> -        // SAFETY: `ptr::null_mut()` is null and `layout` has a non-zero=
 size by the function safety
> -        // requirement.
> -        unsafe { krealloc_aligned(ptr::null_mut(), layout, GFP_KERNEL) }
> +        let this: &dyn Allocator =3D self;
> +
> +        match this.alloc(layout, GFP_KERNEL) {
> +            Ok(ptr) =3D> ptr.as_ptr().cast(),
> +            Err(_) =3D> ptr::null_mut(),
> +        }
>      }


