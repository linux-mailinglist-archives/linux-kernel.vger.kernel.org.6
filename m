Return-Path: <linux-kernel+bounces-570538-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D3298A6B1C8
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 00:46:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4F8ED1893311
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 23:46:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C49E122A81D;
	Thu, 20 Mar 2025 23:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=proton.me header.i=@proton.me header.b="BNoka6ad"
Received: from mail-10630.protonmail.ch (mail-10630.protonmail.ch [79.135.106.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A76BB22AE4E
	for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 23:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742514286; cv=none; b=RNMOfHJyuDkuSI8jnwKg/xZRjpxJZb2eZG8s2ZTe9D3wOPhVkJEGBk6k3H8GCtin2ONhaxrYqb17eRcNzEnEMQ3odk3ltXpq7d+5TTPHySyaly+g1sbbpkS+h84jKQJV+Cc71t1dDuSvcvtVs49H+Za1XOcre82I5OtF3z2fe+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742514286; c=relaxed/simple;
	bh=e51m5SUVi+CNdTemJuEbVhgeIiXuMUA/InJ2W6O5BOg=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=US7gcOYCl+LKUS+cfww6RNVfLIw8BLTSvCbYVdTI/Pl3xYITa69qs9UPr7fdUxjzliN9K7Jd99Xv6tzdCwvoT9x0AgSX3alUqzNXYrrfuKjSqdhQMHuj0/b2oEQ56EEPiWdw/isSS6u4Un/nzVzqyROQyv1EajPjCeUJI/OzCXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=BNoka6ad; arc=none smtp.client-ip=79.135.106.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=3bsknuqdbbcahpectb3oapoztm.protonmail; t=1742514279; x=1742773479;
	bh=3HdnJ7Wws//caW7Bhr/0Lr6q/m6AyDxuwu5pVOC28Yk=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=BNoka6adqJ5R7dVVWmRtox69+MZYf/hm9CM2W8xk9dQ2sXqwdFATD/4XyB6BczCNv
	 e26M5qbrSJi3qUfhpY3Wb5tKRsIRLK9UaBkr1KoP913/s6EA+7QOGnetuL6VkVtrZY
	 Yy7a1p1xjimwhpKtwFfi7eCkwEsnMLmKK29PE4wo1QezFp+CQS6jI+x9hVUGTz4pNA
	 4nEd7aO5tsqkg4BuxCVkw7n+hN35tf1bUqorvPGPaBjfoXzcKaB5N270a7cBsesEgj
	 DgL5VYOSN5Cr/Vsh5Wj5AUjczpnNr+ygUy6lL/8KSY8RxVu4vre0lwJMn6wi0eS5qJ
	 ddywhgdAMYQiQ==
Date: Thu, 20 Mar 2025 23:44:31 +0000
To: Danilo Krummrich <dakr@kernel.org>, bhelgaas@google.com, gregkh@linuxfoundation.org, rafael@kernel.org, ojeda@kernel.org, alex.gaynor@gmail.com, boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com, a.hindborg@kernel.org, aliceryhl@google.com, tmgross@umich.edu
From: Benno Lossin <benno.lossin@proton.me>
Cc: linux-pci@vger.kernel.org, rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/4] rust: platform: impl TryFrom<&Device> for &platform::Device
Message-ID: <D8LHR6S7X0XT.32HULT1QFYKUX@proton.me>
In-Reply-To: <20250320222823.16509-5-dakr@kernel.org>
References: <20250320222823.16509-1-dakr@kernel.org> <20250320222823.16509-5-dakr@kernel.org>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: 82a975e55ac5dbcccb5f349c2c1de8326b205e26
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Thu Mar 20, 2025 at 11:27 PM CET, Danilo Krummrich wrote:
> @@ -234,6 +234,24 @@ fn as_ref(&self) -> &device::Device {
>      }
>  }
> =20
> +impl TryFrom<&device::Device> for &Device {
> +    type Error =3D kernel::error::Error;
> +
> +    fn try_from(dev: &device::Device) -> Result<Self, Self::Error> {
> +        if dev.bus_type_raw() !=3D addr_of!(bindings::platform_bus_type)=
 {
> +            return Err(EINVAL);
> +        }
> +
> +        // SAFETY: We've just verified that the bus type of `dev` equals
> +        // `bindings::platform_bus_type`, hence `dev` must be embedded i=
n a valid
> +        // `struct platform_device`.

Same change here as in patch 3. With that:

Reviewed-by: Benno Lossin <benno.lossin@proton.me>

---
Cheers,
Benno

> +        let pdev =3D unsafe { container_of!(dev.as_raw(), bindings::plat=
form_device, dev) };
> +
> +        // SAFETY: `pdev` is a valid pointer to a `struct platform_devic=
e`.
> +        Ok(unsafe { &*pdev.cast() })
> +    }
> +}
> +
>  // SAFETY: A `Device` is always reference-counted and can be released fr=
om any thread.
>  unsafe impl Send for Device {}
> =20



