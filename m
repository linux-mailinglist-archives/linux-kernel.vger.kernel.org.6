Return-Path: <linux-kernel+bounces-342448-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5220D988F3A
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Sep 2024 14:43:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6298C1C20C41
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Sep 2024 12:43:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 365E8187FF2;
	Sat, 28 Sep 2024 12:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kBuolGPM"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 911581E52D;
	Sat, 28 Sep 2024 12:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727527417; cv=none; b=VriMT3jXoFhqyXyXzt1L2IbiClLM6NPb4IM3v4qCubzN6rsA3RoRQKpROpOpcbwYYnWtn33r7wiDsf0OB7HCFDTOHb4UMfPoYscFivXbYCrli7Li8MLF9Qo8V2YcQEItLzv+HeAi45ZYdlQwagnFmEx4DhM55H3X7aBGApkBwXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727527417; c=relaxed/simple;
	bh=tAmNwQrFqOnGLWoMuKORR3I292iyiJ/rRwbQKe4bVow=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AGea1Mbcl2wTufA0hRxtpt3GoUL8rDcRXU+VDv9reuSEyL4is3FNFP34gkYcTVNZqUlkclYg+PPLLbLsuphf7XfDf5BDqf1r0NnFa/YEDZzRhZFha8nhhVcTXmjVFhNR32NMSZR2vEjqVV6OkuZcSTkHYDicB5uvC0U8eiU3Lxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kBuolGPM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B278C4CEC3;
	Sat, 28 Sep 2024 12:43:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727527417;
	bh=tAmNwQrFqOnGLWoMuKORR3I292iyiJ/rRwbQKe4bVow=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kBuolGPMW47cT/Yn85jsdRWnYfmrzPAW5OTz2y/1t1pNa6mEczXjbUqYNxrcpXut0
	 RHPFA5Vrigx34oDjPV6X8hBZ2dKYe78s4o9MXkC/X45XVFgdQ/IG4S8qrQlXrl0cIn
	 wF8IuqQvfv0ZcGesyfwp6yVL3ZRNMKYsc7RdqDdfBKC+1PX/x01dJPbXWC9e2vTYeS
	 /66A09Gjb+zT0sAfTRFyeYK3Faoi9HnYowTQiv/o9mZ2WbRd5/q3JrzY5VAV66cwLi
	 ieDPNYIc/xRuolVDoDeGTdrdH7eugb35mdOhfPH5n4FOLSyUcE1iiF8lSVwUgaTurC
	 CWzRipSylxPnw==
Date: Sat, 28 Sep 2024 14:43:29 +0200
From: Danilo Krummrich <dakr@kernel.org>
To: Benno Lossin <benno.lossin@proton.me>
Cc: ojeda@kernel.org, alex.gaynor@gmail.com, wedsonaf@gmail.com,
	boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com,
	a.hindborg@samsung.com, aliceryhl@google.com,
	akpm@linux-foundation.org, daniel.almeida@collabora.com,
	faith.ekstrand@collabora.com, boris.brezillon@collabora.com,
	lina@asahilina.net, mcanal@igalia.com, zhiw@nvidia.com,
	cjia@nvidia.com, jhubbard@nvidia.com, airlied@redhat.com,
	ajanulgu@redhat.com, lyude@redhat.com, linux-kernel@vger.kernel.org,
	rust-for-linux@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v7 13/26] rust: alloc: implement kernel `Vec` type
Message-ID: <Zvf58aEqGEamm7s8@pollux>
References: <20240911225449.152928-1-dakr@kernel.org>
 <20240911225449.152928-14-dakr@kernel.org>
 <1a06b767-ca02-41ec-840a-47e73f7876d8@proton.me>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1a06b767-ca02-41ec-840a-47e73f7876d8@proton.me>

On Thu, Sep 26, 2024 at 01:47:04PM +0000, Benno Lossin wrote:
> On 12.09.24 00:52, Danilo Krummrich wrote:
> > +    /// Appends an element to the back of the [`Vec`] instance.
> > +    ///
> > +    /// # Examples
> > +    ///
> > +    /// ```
> > +    /// let mut v = KVec::new();
> > +    /// v.push(1, GFP_KERNEL)?;
> > +    /// assert_eq!(&v, &[1]);
> > +    ///
> > +    /// v.push(2, GFP_KERNEL)?;
> > +    /// assert_eq!(&v, &[1, 2]);
> > +    /// # Ok::<(), Error>(())
> > +    /// ```
> > +    pub fn push(&mut self, v: T, flags: Flags) -> Result<(), AllocError> {
> > +        Vec::reserve(self, 1, flags)?;
> > +
> > +        // SAFETY:
> > +        // - `self.len` is smaller than `self.capacity` and hence, the resulting pointer is
> > +        //   guaranteed to be part of the same allocated object.
> > +        // - `self.len` can not overflow `isize`.
> > +        let ptr = unsafe { self.as_mut_ptr().add(self.len) };
> > +
> > +        // SAFETY:
> > +        // - `ptr` is properly aligned and valid for writes.
> > +        unsafe { core::ptr::write(ptr, v) };
> 
> Why not use `self.spare_capacity_mut()[0].write(v);`?

Before v7 I did exactly that, but in v6 you suggested to use the raw pointer
instead to avoid the bounds check.

> 
> If you want to avoid the bounds check, you can do
> 
>     let first = self.spare_capacity_mut().first();
>     // SAFETY: the call to `Vec::reserve` above ensures that `spare_capacity_mut()` is non-empty.
>     unsafe { first.unwrap_unchecked() }.write(v);

`first` does a similar check to create the `Option<&T>`, right?. I'd rather keep
the raw pointer access as suggested in v6.

