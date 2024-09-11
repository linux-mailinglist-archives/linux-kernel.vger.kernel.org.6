Return-Path: <linux-kernel+bounces-324786-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EE2C9750D8
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 13:32:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 91C021C22709
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 11:32:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FD13187329;
	Wed, 11 Sep 2024 11:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U8NEgo5v"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C760215383B;
	Wed, 11 Sep 2024 11:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726054352; cv=none; b=jOhFJPas6VQTUNdxZXBFqziFu2xfJqe1Z06k4lIRy1JNSruZ+nkdGhgbaRe4I2/dgucepk/O67djIFGOanVcxmYzHbS2xAth9XdnufrJ+xIeF43ny742ShCvTwZd7FLTeTg4YxuWr9QBExaQ17BLeR+wIl2PmoFp5PfKXa+OS10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726054352; c=relaxed/simple;
	bh=wZreKAiqXdRRnDPLI28qQmvvixc/AOTCYGxtJBYNZWc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kF99f1QNjTT/9tXZGW0eGgiLOGvlBgZhhzs42GolCHpJ/7ifsOarZX6B/GZrkfLKHFKRj4gj2TcVYLYZBseUFGTw8uUGg/REUxLPqlaC5sOQJaP34OxCbsOGd3fw4dJHnAQ3yy1w5UcTghWxe99srDRfbqB1W1+sDThoV1gVH6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U8NEgo5v; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2591C4CEC5;
	Wed, 11 Sep 2024 11:32:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726054350;
	bh=wZreKAiqXdRRnDPLI28qQmvvixc/AOTCYGxtJBYNZWc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=U8NEgo5v03iv7sMsrNvEVAi4+rcivnwhfgoqAl5WNNgmpZ6OOMeHRAcn4hWSkQazj
	 uoFwwNbLZihasWRa6SeBD9fivIaCamoypbUb/2Vy7KIxwRQXAMG1IdDtsl+jj0F3P8
	 LlLZZRYMe8fbsuDgicMDoHWu45Dr+E4fGiyghbIDmiXODrxJgOCGo1hOugoFartzvE
	 48dz5S0kGjwCm9r4wcgov42A2tIjXofXz8k9fi7Pr1RvyC8wTO1ozhyfG5h/YYgM5g
	 hDT82GfqHbp3Z7g4pk9BkA9riyyEk+6B/CM05alm2qv3HQ1RrwIPFT3hKEmS9UtO5F
	 cUCSO/ld3/sJg==
Date: Wed, 11 Sep 2024 13:32:23 +0200
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
Subject: Re: [PATCH v6 14/26] rust: alloc: implement `IntoIterator` for `Vec`
Message-ID: <ZuF_x__jiP6KHlvZ@pollux>
References: <20240816001216.26575-1-dakr@kernel.org>
 <20240816001216.26575-15-dakr@kernel.org>
 <308d40dd-105b-4ebf-ba70-585a97d66928@proton.me>
 <ZuDYy3HtPwVLgDtS@pollux>
 <a5efe05d-5e03-426f-bc72-5339dc07af19@proton.me>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a5efe05d-5e03-426f-bc72-5339dc07af19@proton.me>

On Wed, Sep 11, 2024 at 08:52:03AM +0000, Benno Lossin wrote:
> On 11.09.24 01:39, Danilo Krummrich wrote:
> > On Tue, Sep 10, 2024 at 08:04:27PM +0000, Benno Lossin wrote:
> >> On 16.08.24 02:10, Danilo Krummrich wrote:
> >>> +/// [`IntoIterator`] trait).
> >>> +///
> >>> +/// # Examples
> >>> +///
> >>> +/// ```
> >>> +/// let v = kernel::kvec![0, 1, 2]?;
> >>> +/// let iter = v.into_iter();
> >>> +///
> >>> +/// # Ok::<(), Error>(())
> >>> +/// ```
> >>> +pub struct IntoIter<T, A: Allocator> {
> >>> +    ptr: *mut T,
> >>> +    buf: NonNull<T>,
> >>
> >> No invariants for these two fields?
> > 
> > Suggestions?
> 
> When determining the invariants, I look at the places where you would
> want to use them, ie the `SAFETY` comments that use these fields:
> - for `buf` you only use it to free the backing allocation, so you only
>   need that it has been allocated by `A` if `cap != 0`.
> - for `ptr` you need that it is valid for reads for `size_of::<T>() *
>   length` bytes.
> 
> So I would put those two things into invariants.
> 
> >>> +    len: usize,
> >>> +    cap: usize,
> >>> +    _p: PhantomData<A>,
> >>> +}
> >>> +
> >>> +impl<T, A> IntoIter<T, A>
> >>> +where
> >>> +    A: Allocator,
> >>> +{
> >>> +    fn as_raw_mut_slice(&mut self) -> *mut [T] {
> >>> +        ptr::slice_from_raw_parts_mut(self.ptr, self.len)
> >>> +    }
> >>> +}
> >>> +
> >>> +impl<T, A> Iterator for IntoIter<T, A>
> >>> +where
> >>> +    A: Allocator,
> >>> +{
> >>> +    type Item = T;
> >>> +
> >>> +    /// # Examples
> >>> +    ///
> >>> +    /// ```
> >>> +    /// let v = kernel::kvec![1, 2, 3]?;
> >>> +    /// let mut it = v.into_iter();
> >>> +    ///
> >>> +    /// assert_eq!(it.next(), Some(1));
> >>> +    /// assert_eq!(it.next(), Some(2));
> >>> +    /// assert_eq!(it.next(), Some(3));
> >>> +    /// assert_eq!(it.next(), None);
> >>> +    ///
> >>> +    /// # Ok::<(), Error>(())
> >>> +    /// ```
> >>
> >> AFAIK documentation on functions in trait implementations won't show up
> >> in rustdoc (I just checked this). So I would remove it.
> > 
> > They don't, but the KUnit tests are still executed. :)
> 
> Oh I see, then may I suggest moving them to the module documentation or
> put them onto `Vec`, that way people can also read them :)

Hm, I'd rather keep them close on the functions they're testing. Those examples
probably don't have a huge documentation purpose. As you've said, the trait is
documented already and has examples.

> 
> ---
> Cheers,
> Benno
> 
> 

