Return-Path: <linux-kernel+bounces-286874-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 50789951FD6
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 18:26:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EF4411F21244
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 16:25:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BD831BA89E;
	Wed, 14 Aug 2024 16:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="Ulx/uw1l"
Received: from mail-40133.protonmail.ch (mail-40133.protonmail.ch [185.70.40.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BBF71B580F
	for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 16:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723652507; cv=none; b=rn1E6hRUBB0/MFHYs8pa+ZIT/744RSUf7K/h+Hem8nheXuBAfKNPl5BLrUzkrlIc5DidmsEz8X+kgYE+OCeM4GZzQ2ZLAaGgcvt5dI0HdOqAUHPBZa9ia02haP+BphuhR4R8wheTueAfmTUhfWrEf72Gv1GikusfYHpj7OEIGPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723652507; c=relaxed/simple;
	bh=qSd3Yu0puK8QYil0g2p98vy6vXReDpvc6N6QZl1jFxc=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aNg1eLea4074HwQ1exhKre+Lib6481aOwo8cRFTkfRPjTytrp9TFUmjgsV1kp2aNjJfqpq4vmqzJhnnn8HMlJE7+JYaQvFXjV6nVRVYPWiHcE5JDUprdf0t4EjUXmy9B6PmF8LwUUfD5yfsTev9kA/OZxuZD52uUZ7Hry8thqGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=Ulx/uw1l; arc=none smtp.client-ip=185.70.40.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1723652503; x=1723911703;
	bh=ElW81nmuMyFcuZd2JqycrXTbrMuJCQ7ZGEOPKGn1daE=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=Ulx/uw1luVlvnZVatvsit6Ewncx8dEqF5VdKfivVbLRrAdqmff3mUDAUzQjmd/NIN
	 C+XadT+1qHplji3kN6w+l4gyZ8myA4gbAffticbqJwu+9hgWM586Favht1ZFnDB/yH
	 uvEEqitk837jX/JGOVprAj0SoZ9hygnM8t1D9XoUcjaGRVER/uvDSQdbfL2KlKQvpR
	 jmZ/CX1HM8Yv4LfHGl/rHLtXes8p47GOu9ojqbLUeKZbsJ/sThjulTnUvD1g8AJ9VU
	 dGHH2UXE/Z0SZsMWAygTZFj1qRgrUTaYioUrgq/EVg7vmjs36z4ff5pZ3iqWbQX1Cw
	 VQWXYc3Q+a8cA==
Date: Wed, 14 Aug 2024 16:21:38 +0000
To: Danilo Krummrich <dakr@kernel.org>, ojeda@kernel.org, alex.gaynor@gmail.com, wedsonaf@gmail.com, boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com, a.hindborg@samsung.com, aliceryhl@google.com, akpm@linux-foundation.org
From: Benno Lossin <benno.lossin@proton.me>
Cc: daniel.almeida@collabora.com, faith.ekstrand@collabora.com, boris.brezillon@collabora.com, lina@asahilina.net, mcanal@igalia.com, zhiw@nvidia.com, cjia@nvidia.com, jhubbard@nvidia.com, airlied@redhat.com, ajanulgu@redhat.com, lyude@redhat.com, linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v5 04/26] rust: alloc: implement `Allocator` for `Kmalloc`
Message-ID: <b6b3d965-c1d4-4c18-8db4-2e7c19f10a15@proton.me>
In-Reply-To: <20240812182355.11641-5-dakr@kernel.org>
References: <20240812182355.11641-1-dakr@kernel.org> <20240812182355.11641-5-dakr@kernel.org>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: 430524bf5337709f1be1026acca337e58d87b3a5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 12.08.24 20:22, Danilo Krummrich wrote:
> +    /// # Safety
> +    ///
> +    /// This method has the same safety requirements as `Allocator::real=
loc`.

Please make this a link.

> +    unsafe fn call(
> +        &self,
> +        ptr: Option<NonNull<u8>>,
> +        layout: Layout,
> +        flags: Flags,
> +    ) -> Result<NonNull<[u8]>, AllocError> {
> +        let size =3D aligned_size(layout);
> +        let ptr =3D match ptr {
> +            Some(ptr) =3D> ptr.as_ptr(),
> +            None =3D> ptr::null(),
> +        };
> +
> +        // SAFETY: `ptr` is either NULL or valid by the safety requireme=
nts of this function.
> +        let raw_ptr =3D unsafe {
> +            // If `size =3D=3D 0` and `ptr !=3D NULL` the memory behind =
the pointer is freed.
> +            self.0(ptr.cast(), size, flags.0).cast()
> +        };
> +
> +        let ptr =3D if size =3D=3D 0 {

Why do you do this check *after* calling `self.0`?

---
Cheers,
Benno

> +            NonNull::dangling()
> +        } else {
> +            NonNull::new(raw_ptr).ok_or(AllocError)?
> +        };
> +
> +        Ok(NonNull::slice_from_raw_parts(ptr, size))
> +    }
> +}


