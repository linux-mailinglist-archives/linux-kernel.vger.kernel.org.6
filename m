Return-Path: <linux-kernel+bounces-574230-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BF6BA6E24A
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 19:29:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E6CC8167BF9
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 18:29:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45560264A87;
	Mon, 24 Mar 2025 18:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.net header.i=@posteo.net header.b="Jio6aTEk"
Received: from mout01.posteo.de (mout01.posteo.de [185.67.36.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A22713C3F6
	for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 18:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.67.36.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742840976; cv=none; b=QVkPREm9eJdkbXyJ4T/OxW+g1EAFkQrtZqKHIYr5YHBDFnTGoGXaZUeKV8ZfJSKJRTcdWaFLJ+v8x0YuFQXG6gCBnfRdluKVqtpkl3uAK6kDe8Drphm7/ue2HB+6Op0BQlch7/3j9IsGKwcHz4/WtCxGwAxg1yIV99XVXOBMN5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742840976; c=relaxed/simple;
	bh=ET4b3AaYE8Ghc/W+tl4x1TdMZ5xfmseummAar90bY94=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=M1WXFMeOjdNSL2oohJrtjZBOdKAvSsEoH8sH8jeLe+5awhN2BE7pFa2RavvUwBMfDRSHrfpKeKzepa5kF6gVcDQXHFjgrpV/CRQ809TMGf25pA+Hkp8CmL7ZOLMJwHZtsRmftpoFJqlpzI5Km05CYPyVT5csf5UePqufpTivzbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.net; spf=pass smtp.mailfrom=posteo.net; dkim=pass (2048-bit key) header.d=posteo.net header.i=@posteo.net header.b=Jio6aTEk; arc=none smtp.client-ip=185.67.36.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.net
Received: from submission (posteo.de [185.67.36.169]) 
	by mout01.posteo.de (Postfix) with ESMTPS id 00E4F24002B
	for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 19:29:26 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
	t=1742840967; bh=ET4b3AaYE8Ghc/W+tl4x1TdMZ5xfmseummAar90bY94=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:From;
	b=Jio6aTEk1qtcDU+YObeSnJg6KCEhBPxz2pICHEscwOIp03oSyJB78N1vlPJwxOrom
	 9UkLBsdgYQkH+znfnLmUg3gl8O6iiZDmtl6IJU9U1DERwR43h3G9U0tRqfBZ/xZpnj
	 zk4ji2MHtSZ336EINFjTCxcpJoD3WZsUVOtPf8g9xocIw8o+vBQGMfLcwtN8Avw6sc
	 yf5xCCoIbKHpYKWG+Z78P3Ejyg5+xITnqkUXIJSv/xAJ2siUUZoHEhTUP1JAaLhybJ
	 /XqHmasKzt3AoAHFJdHY+bMfuLeVrZUo1G8K7u7vVb3X+8de6eBuEzHvKt6REZL9Zv
	 t53xoK8UviKjw==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4ZM1mM3SgSz9rxG;
	Mon, 24 Mar 2025 19:29:23 +0100 (CET)
From: Charalampos Mitrodimas <charmitro@posteo.net>
To: Daniel Almeida <daniel.almeida@collabora.com>
Cc: Miguel Ojeda <ojeda@kernel.org>,  Alex Gaynor <alex.gaynor@gmail.com>,
  Boqun Feng <boqun.feng@gmail.com>,  Gary Guo <gary@garyguo.net>,
  =?utf-8?Q?Bj=C3=B6rn?=
 Roy Baron <bjorn3_gh@protonmail.com>,  Benno Lossin
 <benno.lossin@proton.me>,  Andreas Hindborg <a.hindborg@kernel.org>,
  Alice Ryhl <aliceryhl@google.com>,  Trevor Gross <tmgross@umich.edu>,
  Sumit Semwal <sumit.semwal@linaro.org>,  Christian =?utf-8?Q?K=C3=B6nig?=
 <christian.koenig@amd.com>,  Boris Brezillon
 <boris.brezillon@collabora.com>,  linux-kernel@vger.kernel.org,
  rust-for-linux@vger.kernel.org,  dri-devel@lists.freedesktop.org,  Asahi
 Lina <lina@asahilina.net>
Subject: Re: [PATCH 2/2] rust: drm: Add GPUVM abstraction
In-Reply-To: <20250324-gpuvm-v1-2-7f8213eebb56@collabora.com> (Daniel
	Almeida's message of "Mon, 24 Mar 2025 12:13:55 -0300")
References: <20250324-gpuvm-v1-0-7f8213eebb56@collabora.com>
	<20250324-gpuvm-v1-2-7f8213eebb56@collabora.com>
Date: Mon, 24 Mar 2025 18:29:22 +0000
Message-ID: <m2pli62sfx.fsf@posteo.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Daniel Almeida <daniel.almeida@collabora.com> writes:

> +/// The object returned after a call to [`GpuVm::lock`].
> +///
> +/// This object has access to operations that modify the VM's interval t=
ree.
> +pub struct LockedGpuVm<'a, T: DriverGpuVm> {
> +    gpuvm: &'a GpuVm<T>,
> +}
> +
> +impl<T: DriverGpuVm> LockedGpuVm<'_, T> {
> +    /// Finds the [`GpuVmBo`] object that connects `obj` to this VM.
> +    ///
> +    /// If found, increases the reference count of the GpuVmBo object
> +    /// accordingly.
> +    pub fn find_bo(&mut self, obj: &DriverObject<T>) -> Option<ARef<GpuV=
mBo<T>>> {
> +        // SAFETY: LockedGpuVm implies the right locks are held.
> +        let p =3D unsafe {
> +            bindings::drm_gpuvm_bo_find(
> +                self.gpuvm.gpuvm() as *mut _,
> +                obj.gem_obj() as *const _ as *mut _,
> +            )
> +        };
> +        if p.is_null() {
> +            None
> +        } else {
> +            // SAFETY: All the drm_gpuvm_bo objects in this GpuVm are al=
ways allocated by us as GpuVmBo<T>.
> +            let p =3D unsafe { crate::container_of!(p, GpuVmBo<T>, bo) a=
s *mut GpuVmBo<T> };
> +            // SAFETY: We checked for NULL above, and the types ensure t=
hat
> +            // this object was created by vm_bo_alloc_callback<T>.
> +            Some(unsafe { ARef::from_raw(NonNull::new_unchecked(p)) })
> +        }

Hi Daniel,

This is mostly eye candy=E2=80=94maybe we can simplify it to just:
    if p.is_null() {
       return None;
    }

    // SAFETY: All the drm_gpuvm_bo objects in this GpuVm are always alloca=
ted by us as GpuVmBo<T>.
    let p =3D unsafe { crate::container_of!(p, GpuVmBo<T>, bo) as *mut GpuV=
mBo<T> };
    // SAFETY: We checked for NULL above, and the types ensure that
    // this object was created by vm_bo_alloc_callback<T>.
    Some(unsafe { ARef::from_raw(NonNull::new_unchecked(p)) })


Same with `fn obtain_bo`?

--
C. Mitrodimas

> +    }
> +
> +    /// Obtains the [`GpuVmBo`] object that connects `obj` to this VM.
> +    ///
> +    /// This connection is unique, so an instane of [`GpuVmBo`] will be
> +    /// allocated for `obj` once, and that instance will be returned fro=
m that
> +    /// point forward.
> +    pub fn obtain_bo(&mut self, obj: &DriverObject<T>) -> Result<ARef<Gp=
uVmBo<T>>> {
> +        // SAFETY: LockedGpuVm implies the right locks are held.
> +        let p =3D unsafe {
> +            bindings::drm_gpuvm_bo_obtain(
> +                self.gpuvm.gpuvm() as *mut _,
> +                obj.gem_obj() as *const _ as *mut _,
> +            )
> +        };
> +        if p.is_null() {
> +            Err(ENOMEM)
> +        } else {
> +            // SAFETY: Container invariant is guaranteed for GpuVmBo obj=
ects for this GpuVm.
> +            let p =3D unsafe { crate::container_of!(p, GpuVmBo<T>, bo) a=
s *mut GpuVmBo<T> };
> +            // SAFETY: We checked for NULL above, and the types ensure t=
hat
> +            // this object was created by vm_bo_alloc_callback<T>.
> +            Ok(unsafe { ARef::from_raw(NonNull::new_unchecked(p)) })
> +        }
> +    }

