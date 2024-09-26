Return-Path: <linux-kernel+bounces-340531-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D1DB9874CE
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 15:53:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C0E981F253E1
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 13:53:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 900A861FE9;
	Thu, 26 Sep 2024 13:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="SmRt/GeA"
Received: from mail-40131.protonmail.ch (mail-40131.protonmail.ch [185.70.40.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 458825FEED
	for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 13:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727358809; cv=none; b=rW0SyMDpZ75dcjGi8xFbzGi0by2HBLKxBm6u4E1XqKZJBTKDx2LhgJG8EJid5F5RTI8IqXiJ4Ji2zup8jSOu/X4jKVuyZdbkadkGR6DYsbXROjruQXTGwEhJtoXJuKgTJlhNEG/JET67d10v4AHiiaz4tm2kIooClaSDN0JTUsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727358809; c=relaxed/simple;
	bh=ke8ETQIxxOOJ5Eg7yIxfwmmRx4vFXxPfLRkVmtaInH4=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Wjik1DnUTANqHJdKkBUjUJa80mK88WQTePF/oBUsyfDfGNFXhDCyGQ7g/vMG6T3u/stFthu8irDSnpmej7bMdR8LVdUfLQJ+8b6TOhnwga88D+vbIqi7ox/NmkCUiJ3gVGg4odRpR98VsOPu4ZDU4hI0EBq2K7Qv39qmuJHIFF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=SmRt/GeA; arc=none smtp.client-ip=185.70.40.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1727358803; x=1727618003;
	bh=30p0HxmNSCqsWjNg4s5Rl2kjV1KIrDxeHCMZ2KZbK9c=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=SmRt/GeABgh19LnQElz2w50l7si0t5sfeKWl1xWmdlIg/0DVGGRQWmngzVLnfQ/NO
	 YNZEqzF8KLpq1yTGNEByRuRklc8lde7YPjl9uv24gzlpt+zPw+1rKs3y4rtQZ5/0AH
	 AO7B75PAPUsoO4bOiYtdpKPn/ojz+Qgrp2o4A+mlQPFhnXN9Q1I9RPIHIMBVDLt2d7
	 7l+LL1bTGRR9z13emr7rfq7HkpDEeAe+riDXJoYAz9KkOgLoBKj/Anzx4joDC88p4l
	 vqrO38w7ffdIEyr2StClvUeWe+mh8ZlV5mrKG/WMTrHJA6Soa/ZEeUZJehcfcZ7qt2
	 +lh76SjdhCTpw==
Date: Thu, 26 Sep 2024 13:53:19 +0000
To: Danilo Krummrich <dakr@kernel.org>, ojeda@kernel.org, alex.gaynor@gmail.com, wedsonaf@gmail.com, boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com, a.hindborg@samsung.com, aliceryhl@google.com, akpm@linux-foundation.org
From: Benno Lossin <benno.lossin@proton.me>
Cc: daniel.almeida@collabora.com, faith.ekstrand@collabora.com, boris.brezillon@collabora.com, lina@asahilina.net, mcanal@igalia.com, zhiw@nvidia.com, cjia@nvidia.com, jhubbard@nvidia.com, airlied@redhat.com, ajanulgu@redhat.com, lyude@redhat.com, linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v7 14/26] rust: alloc: implement `IntoIterator` for `Vec`
Message-ID: <cafb786e-5f7a-489f-8d1b-443f761e10ec@proton.me>
In-Reply-To: <20240911225449.152928-15-dakr@kernel.org>
References: <20240911225449.152928-1-dakr@kernel.org> <20240911225449.152928-15-dakr@kernel.org>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: 85c3c962bdf1b929a7009f824b18be77752e0e35
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 12.09.24 00:52, Danilo Krummrich wrote:
> Implement `IntoIterator` for `Vec`, `Vec`'s `IntoIter` type, as well as
> `Iterator` for `IntoIter`.
>=20
> `Vec::into_iter` disassembles the `Vec` into its raw parts; additionally,
> `IntoIter` keeps track of a separate pointer, which is incremented
> correspondingsly as the iterator advances, while the length, or the count
> of elements, is decremented.
>=20
> This also means that `IntoIter` takes the ownership of the backing
> buffer and is responsible to drop the remaining elements and free the
> backing buffer, if it's dropped.
>=20
> Reviewed-by: Alice Ryhl <aliceryhl@google.com>
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>
> ---
>  rust/kernel/alloc.rs      |   1 +
>  rust/kernel/alloc/kvec.rs | 181 ++++++++++++++++++++++++++++++++++++++
>  2 files changed, 182 insertions(+)

One comment below, with that fixed:

Reviewed-by: Benno Lossin <benno.lossin@proton.me>

---
Cheers,
Benno

> +impl<T, A> IntoIterator for Vec<T, A>
> +where
> +    A: Allocator,
> +{
> +    type Item =3D T;
> +    type IntoIter =3D IntoIter<T, A>;
> +
> +    /// Consumes the `Vec<T, A>` and creates an `Iterator`, which moves =
each value out of the
> +    /// vector (from start to end).
> +    ///
> +    /// # Examples
> +    ///
> +    /// ```
> +    /// let v =3D kernel::kvec![1, 2]?;
> +    /// let mut v_iter =3D v.into_iter();
> +    ///
> +    /// let first_element: Option<u32> =3D v_iter.next();
> +    ///
> +    /// assert_eq!(first_element, Some(1));
> +    /// assert_eq!(v_iter.next(), Some(2));
> +    /// assert_eq!(v_iter.next(), None);
> +    ///
> +    /// # Ok::<(), Error>(())
> +    /// ```
> +    ///
> +    /// ```
> +    /// let v =3D kernel::kvec![];
> +    /// let mut v_iter =3D v.into_iter();
> +    ///
> +    /// let first_element: Option<u32> =3D v_iter.next();
> +    ///
> +    /// assert_eq!(first_element, None);
> +    ///
> +    /// # Ok::<(), Error>(())
> +    /// ```
> +    #[inline]
> +    fn into_iter(self) -> Self::IntoIter {
> +        let (ptr, len, cap) =3D self.into_raw_parts();
> +
> +        IntoIter {
> +            ptr,
> +            // SAFETY: `ptr` is either a dangling pointer or a pointer t=
o a valid memory
> +            // allocation, allocated with `A`.
> +            buf: unsafe { NonNull::new_unchecked(ptr) },

Instead of this `unsafe` call, you can do

    let buf =3D self.ptr;

Before the call to `into_raw_parts`.

> +            len,
> +            cap,
> +            _p: PhantomData::<A>,
> +        }
> +    }
> +}
> --
> 2.46.0
>=20


