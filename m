Return-Path: <linux-kernel+bounces-324515-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 80FBC974D8F
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 10:55:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 435B4286DEC
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 08:55:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70F7B14EC46;
	Wed, 11 Sep 2024 08:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="GDzrFMoW"
Received: from mail-40133.protonmail.ch (mail-40133.protonmail.ch [185.70.40.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9E0C186609
	for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 08:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726044814; cv=none; b=QifLadeyZ0OjhD/2QPESvDQpJaidzZxqwifzKPLWkkQX19YUnExtaKIdOWt2H99RCCEEZEKcTAhJJyQaxOnSQtEN++U7I28iuh4I76R2s3eDlrlhHpsfz5G5WJH8R35wse4ffRKfMG5eUnXmXsySoiQyuqKzEqQeMXSeF7ktdqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726044814; c=relaxed/simple;
	bh=8eph8ZoPw5th/a4Boxem+pbq7rjO0PIK4L5g+jysul8=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HJwOQ0xGUzYWATV9yg7U/EUDf37Dm8FEdFB4loO2LL76k09MoCMmjAgpQyv7tT0lSiVTugOm501za6meNZjssYu1c8dMioYQldDsshcetGE9PIsYSOrmSE49hkAl6yXoIvKZNdn7kLg71jWwJiwHkzKilEcuWpjlz4JtzPXIc7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=GDzrFMoW; arc=none smtp.client-ip=185.70.40.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1726044809; x=1726304009;
	bh=V1DaypacfHgH30QcZbTBIVISoAMB3BZmyLTSZgD+fCw=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=GDzrFMoWBDrZGpotXcDnsUADzacYIMxuQESVwPdEnbILhv+MrEfGbM2iPOlAnhi8p
	 cyYQ29nONdVLSiyaVRhfwMWLMmko4GVgj31fKRBEW5Yzz/jKR0fG+wXYX0rZvZg973
	 IE02FI6O70Wi7e+bpSDTte51pmWoxjPZPFTAo8Mxsrl9dyqFM6T3pI4TQXLPgeBUX1
	 YE/DtvwGliwkcluG5rRFki75XIuOXjMGcxicDzBnMiiArFI0MAtUNqQketzaHu4TXQ
	 58slCmqVi2ueGwiA0HwJNxvOu03MFH4R330Fr9XA+siVOPnRY6duu3BdJ2yB8dt1Lx
	 p91iRDCqSke0w==
Date: Wed, 11 Sep 2024 08:53:24 +0000
To: Danilo Krummrich <dakr@kernel.org>
From: Benno Lossin <benno.lossin@proton.me>
Cc: ojeda@kernel.org, alex.gaynor@gmail.com, wedsonaf@gmail.com, boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com, a.hindborg@samsung.com, aliceryhl@google.com, akpm@linux-foundation.org, daniel.almeida@collabora.com, faith.ekstrand@collabora.com, boris.brezillon@collabora.com, lina@asahilina.net, mcanal@igalia.com, zhiw@nvidia.com, cjia@nvidia.com, jhubbard@nvidia.com, airlied@redhat.com, ajanulgu@redhat.com, lyude@redhat.com, linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v6 15/26] rust: alloc: implement `collect` for `IntoIter`
Message-ID: <503abe24-fbac-440a-a063-fc30a2a6bd77@proton.me>
In-Reply-To: <ZuDiurdQfvmewzDh@pollux>
References: <20240816001216.26575-1-dakr@kernel.org> <20240816001216.26575-16-dakr@kernel.org> <747b8c1c-cb7b-422e-b6a0-ea863cc37f0a@proton.me> <ZuDiurdQfvmewzDh@pollux>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: 6f7b7bfdbfdcc7f366fd5b4e594634851cf4cf85
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 11.09.24 02:22, Danilo Krummrich wrote:
> On Tue, Sep 10, 2024 at 08:12:24PM +0000, Benno Lossin wrote:
>> On 16.08.24 02:10, Danilo Krummrich wrote:
>>> +    /// Same as `Iterator::collect` but specialized for `Vec`'s `IntoI=
ter`.
>>> +    ///
>>> +    /// Currently, we can't implement `FromIterator`. There are a coup=
le of issues with this trait
>>> +    /// in the kernel, namely:
>>> +    ///
>>> +    /// - Rust's specialization feature is unstable. This prevents us =
to optimze for the special
>>> +    ///   case where `I::IntoIter` equals `Vec`'s `IntoIter` type.
>>> +    /// - We also can't use `I::IntoIter`'s type ID either to work aro=
und this, since `FromIterator`
>>> +    ///   doesn't require this type to be `'static`.
>>> +    /// - `FromIterator::from_iter` does return `Self` instead of `Res=
ult<Self, AllocError>`, hence
>>> +    ///   we can't properly handle allocation failures.
>>> +    /// - Neither `Iterator::collect` nor `FromIterator::from_iter` ca=
n handle additional allocation
>>> +    ///   flags.
>>> +    ///
>>> +    /// Instead, provide `IntoIter::collect`, such that we can at leas=
t convert a `IntoIter` into a
>>> +    /// `Vec` again.
>>
>> I think it's great that you include this in the code, but I don't think
>> that it should be visible in the documentation,
>=20
> Why not? I think this information is valuable for users of this API.

If you want to keep it, then I don't mind, but I would still move it
underneath `Examples` and add a section header `# Implementation
Details` or similar.

---
Cheers,
Benno

>> can you move it under
>> the `Examples` section and turn it into normal comments?
>>
>>> +    ///
>>> +    /// Note that `IntoIter::collect` doesn't require `Flags`, since i=
t re-uses the existing backing
>>> +    /// buffer. However, this backing buffer may be shrunk to the actu=
al count of elements.
>>> +    ///
>>> +    /// # Examples
>>> +    ///
>>> +    /// ```
>>> +    /// let v =3D kernel::kvec![1, 2, 3]?;
>>> +    /// let mut it =3D v.into_iter();
>>> +    ///
>>> +    /// assert_eq!(it.next(), Some(1));
>>> +    ///
>>> +    /// let v =3D it.collect(GFP_KERNEL);
>>> +    /// assert_eq!(v, [2, 3]);
>>> +    ///
>>> +    /// # Ok::<(), Error>(())
>>> +    /// ```
>>> +    pub fn collect(self, flags: Flags) -> Vec<T, A> {


