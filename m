Return-Path: <linux-kernel+bounces-324788-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 489DE9750DC
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 13:33:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7C5331C220EB
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 11:33:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76B2E187337;
	Wed, 11 Sep 2024 11:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BJrC1mKu"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1FE13D984;
	Wed, 11 Sep 2024 11:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726054391; cv=none; b=jyXQL9UZK7SjuxM93oIXdKhFS28kofXAr4UUW4qe/ARHZC/4kgsTjv5Wc5SOg6Ucb2CkXo+oOldnIpPenJA6SyvuNjYYqQGzEMMkTEgIs143MWjVgzZnx0vm1EUc59lzUCrQZaZsF+QJKO9wzVjZMENMbgZs98PUNj+ml/QaOIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726054391; c=relaxed/simple;
	bh=d/6BYN/hz0vb6byjvWNc4phCG22oIwVbCnvyfL1nmP8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u69PvsG3Xx8r+l1XcU1b84PZl4na24ocHk8Xx72drMWINrh5Zp3cgmNEM8O1lxNm9nyKRT9XFWv08wcyCFZGF/SUHn7sxyb/GurgoDZGsff1g318wFsrpij41yOXg3eJbgduFLUmIHitCul51jFtx+2BOpfnY6guRImOn1bst64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BJrC1mKu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A79ECC4CEC5;
	Wed, 11 Sep 2024 11:33:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726054391;
	bh=d/6BYN/hz0vb6byjvWNc4phCG22oIwVbCnvyfL1nmP8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BJrC1mKuzmCf5h4ZN/N4P6hYPuKbfXWRIhz0oMROBeEZug+h/+T4pMtUcsWl7lkTX
	 8To1SmRdKnLcEFd2JLUEET9DFIq7A/Hm1LW//VzLbYGoFXDbZezCETlCRMmSAky0su
	 vrpjyzkqVZnYdsUJY3MFIrYJyiXQpSJDb4v5J+QPpS44wOQwMambL/KQrI7LiEHJG3
	 vYmAWyrZKU07KfA1nPIQVwji9pk2vPfY30ktwgAqfk7jWt76BH+fxJZvtf7CLutq7n
	 i0YqtLiubl8yuDc377zIFUzNZn+VaFDwdOJtUVYRFWk5uGQ/67UZhWPe1fI0C/A9Mq
	 7GP4I/vtLMONw==
Date: Wed, 11 Sep 2024 13:33:03 +0200
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
Subject: Re: [PATCH v6 15/26] rust: alloc: implement `collect` for `IntoIter`
Message-ID: <ZuF_76DHQRukLEMb@pollux>
References: <20240816001216.26575-1-dakr@kernel.org>
 <20240816001216.26575-16-dakr@kernel.org>
 <747b8c1c-cb7b-422e-b6a0-ea863cc37f0a@proton.me>
 <ZuDiurdQfvmewzDh@pollux>
 <503abe24-fbac-440a-a063-fc30a2a6bd77@proton.me>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <503abe24-fbac-440a-a063-fc30a2a6bd77@proton.me>

On Wed, Sep 11, 2024 at 08:53:24AM +0000, Benno Lossin wrote:
> On 11.09.24 02:22, Danilo Krummrich wrote:
> > On Tue, Sep 10, 2024 at 08:12:24PM +0000, Benno Lossin wrote:
> >> On 16.08.24 02:10, Danilo Krummrich wrote:
> >>> +    /// Same as `Iterator::collect` but specialized for `Vec`'s `IntoIter`.
> >>> +    ///
> >>> +    /// Currently, we can't implement `FromIterator`. There are a couple of issues with this trait
> >>> +    /// in the kernel, namely:
> >>> +    ///
> >>> +    /// - Rust's specialization feature is unstable. This prevents us to optimze for the special
> >>> +    ///   case where `I::IntoIter` equals `Vec`'s `IntoIter` type.
> >>> +    /// - We also can't use `I::IntoIter`'s type ID either to work around this, since `FromIterator`
> >>> +    ///   doesn't require this type to be `'static`.
> >>> +    /// - `FromIterator::from_iter` does return `Self` instead of `Result<Self, AllocError>`, hence
> >>> +    ///   we can't properly handle allocation failures.
> >>> +    /// - Neither `Iterator::collect` nor `FromIterator::from_iter` can handle additional allocation
> >>> +    ///   flags.
> >>> +    ///
> >>> +    /// Instead, provide `IntoIter::collect`, such that we can at least convert a `IntoIter` into a
> >>> +    /// `Vec` again.
> >>
> >> I think it's great that you include this in the code, but I don't think
> >> that it should be visible in the documentation,
> > 
> > Why not? I think this information is valuable for users of this API.
> 
> If you want to keep it, then I don't mind, but I would still move it
> underneath `Examples` and add a section header `# Implementation
> Details` or similar.

Sure, we can do that.

> 
> ---
> Cheers,
> Benno
> 
> >> can you move it under
> >> the `Examples` section and turn it into normal comments?
> >>
> >>> +    ///
> >>> +    /// Note that `IntoIter::collect` doesn't require `Flags`, since it re-uses the existing backing
> >>> +    /// buffer. However, this backing buffer may be shrunk to the actual count of elements.
> >>> +    ///
> >>> +    /// # Examples
> >>> +    ///
> >>> +    /// ```
> >>> +    /// let v = kernel::kvec![1, 2, 3]?;
> >>> +    /// let mut it = v.into_iter();
> >>> +    ///
> >>> +    /// assert_eq!(it.next(), Some(1));
> >>> +    ///
> >>> +    /// let v = it.collect(GFP_KERNEL);
> >>> +    /// assert_eq!(v, [2, 3]);
> >>> +    ///
> >>> +    /// # Ok::<(), Error>(())
> >>> +    /// ```
> >>> +    pub fn collect(self, flags: Flags) -> Vec<T, A> {
> 

