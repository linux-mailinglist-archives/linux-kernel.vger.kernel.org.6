Return-Path: <linux-kernel+bounces-324512-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 617D8974D89
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 10:55:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 228AE281F43
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 08:55:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1635A185B60;
	Wed, 11 Sep 2024 08:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="b0MC+EOR"
Received: from mail-4322.protonmail.ch (mail-4322.protonmail.ch [185.70.43.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91A98154C0B
	for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 08:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726044733; cv=none; b=KYreviuTeVKGrkmvsiiXz93m8oebGWPIu4IVpUsTSJwiA8VS2HCWowdVi2QLSOrgOu9v1Zv6kOHJhtbSSw5S9qZAHLwcAlI7V+FtVN8jFlBLGkovsGgjnjjI4TUfC6F9pUwWxJKkzL8ZJJEeZHTa+PX42q98pIttOHvGMfFaeh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726044733; c=relaxed/simple;
	bh=4znQhUu8LxiVX6fr/ZOCHM8a2TBpbvw6wCXWyWqGN9A=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZRxdN3aw/+gSAfpl4kScSJK07OZZK6JCFqjCjGpGXCgk7Pe3dQZvVx5WMULwFIApRT8BgG54OkeUZ1gB4Wv3e+OvOV9a1InWItyTNyhKWTyT/W5Xf/wbyn31Obsxm2rDw8e2CcbQzv3IltpkCOwPIXECm7MV5VigQ8lrZhIjnbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=b0MC+EOR; arc=none smtp.client-ip=185.70.43.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1726044729; x=1726303929;
	bh=7ej536exrAiwdO2l5a1GM7W1na7XjDoAMN2spKpA03Q=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=b0MC+EORYPM1eG7rGu9uqZFAa11xU9ar3Xj8+WRjj/IxSr8xw3CNH2Yf0M0jRDi+l
	 of2INkSQuKw6uCrmZiyDpFwN74/mB40aoKtyi0R9MyTRrHaTauY3qstWIxt6SbDsGk
	 2NrEycbGAN5Uz9WG+MpUd78xTosJycw32GzQsCfLXH87e4dzwzNRzep0kA7QUpRRgh
	 iUEzCJanFIbc3NNYLeHfNWUK+2dqQL8v9fHoawAi3XfixSuQjGOPPtdORQsOhOW55A
	 Gay5+Pt7tFqNZ0GhcAJdA7tybxYA1+7UIz7su8scSSP5ceyU3ZS0m/gbcH2C+kb/1Z
	 Yk8gjgON5jQIA==
Date: Wed, 11 Sep 2024 08:52:03 +0000
To: Danilo Krummrich <dakr@kernel.org>
From: Benno Lossin <benno.lossin@proton.me>
Cc: ojeda@kernel.org, alex.gaynor@gmail.com, wedsonaf@gmail.com, boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com, a.hindborg@samsung.com, aliceryhl@google.com, akpm@linux-foundation.org, daniel.almeida@collabora.com, faith.ekstrand@collabora.com, boris.brezillon@collabora.com, lina@asahilina.net, mcanal@igalia.com, zhiw@nvidia.com, cjia@nvidia.com, jhubbard@nvidia.com, airlied@redhat.com, ajanulgu@redhat.com, lyude@redhat.com, linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v6 14/26] rust: alloc: implement `IntoIterator` for `Vec`
Message-ID: <a5efe05d-5e03-426f-bc72-5339dc07af19@proton.me>
In-Reply-To: <ZuDYy3HtPwVLgDtS@pollux>
References: <20240816001216.26575-1-dakr@kernel.org> <20240816001216.26575-15-dakr@kernel.org> <308d40dd-105b-4ebf-ba70-585a97d66928@proton.me> <ZuDYy3HtPwVLgDtS@pollux>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: 113f2dd15dbb08efdbff177ae5499441409002bf
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 11.09.24 01:39, Danilo Krummrich wrote:
> On Tue, Sep 10, 2024 at 08:04:27PM +0000, Benno Lossin wrote:
>> On 16.08.24 02:10, Danilo Krummrich wrote:
>>> +/// [`IntoIterator`] trait).
>>> +///
>>> +/// # Examples
>>> +///
>>> +/// ```
>>> +/// let v =3D kernel::kvec![0, 1, 2]?;
>>> +/// let iter =3D v.into_iter();
>>> +///
>>> +/// # Ok::<(), Error>(())
>>> +/// ```
>>> +pub struct IntoIter<T, A: Allocator> {
>>> +    ptr: *mut T,
>>> +    buf: NonNull<T>,
>>
>> No invariants for these two fields?
>=20
> Suggestions?

When determining the invariants, I look at the places where you would
want to use them, ie the `SAFETY` comments that use these fields:
- for `buf` you only use it to free the backing allocation, so you only
  need that it has been allocated by `A` if `cap !=3D 0`.
- for `ptr` you need that it is valid for reads for `size_of::<T>() *
  length` bytes.

So I would put those two things into invariants.

>>> +    len: usize,
>>> +    cap: usize,
>>> +    _p: PhantomData<A>,
>>> +}
>>> +
>>> +impl<T, A> IntoIter<T, A>
>>> +where
>>> +    A: Allocator,
>>> +{
>>> +    fn as_raw_mut_slice(&mut self) -> *mut [T] {
>>> +        ptr::slice_from_raw_parts_mut(self.ptr, self.len)
>>> +    }
>>> +}
>>> +
>>> +impl<T, A> Iterator for IntoIter<T, A>
>>> +where
>>> +    A: Allocator,
>>> +{
>>> +    type Item =3D T;
>>> +
>>> +    /// # Examples
>>> +    ///
>>> +    /// ```
>>> +    /// let v =3D kernel::kvec![1, 2, 3]?;
>>> +    /// let mut it =3D v.into_iter();
>>> +    ///
>>> +    /// assert_eq!(it.next(), Some(1));
>>> +    /// assert_eq!(it.next(), Some(2));
>>> +    /// assert_eq!(it.next(), Some(3));
>>> +    /// assert_eq!(it.next(), None);
>>> +    ///
>>> +    /// # Ok::<(), Error>(())
>>> +    /// ```
>>
>> AFAIK documentation on functions in trait implementations won't show up
>> in rustdoc (I just checked this). So I would remove it.
>=20
> They don't, but the KUnit tests are still executed. :)

Oh I see, then may I suggest moving them to the module documentation or
put them onto `Vec`, that way people can also read them :)

---
Cheers,
Benno



