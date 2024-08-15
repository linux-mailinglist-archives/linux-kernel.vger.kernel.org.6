Return-Path: <linux-kernel+bounces-288038-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 17BE79531F1
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 16:00:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BCBEF1F23085
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 14:00:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EA6D1A00EC;
	Thu, 15 Aug 2024 14:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kRMXgrvV"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC3F21714DD;
	Thu, 15 Aug 2024 14:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723730409; cv=none; b=DsIJ9oyzpsHiSZeSsimahFwINZVNKlvOVWfcnK5U91Ey/rfBCQnUgNzGwoKN1labtb+Fpg2km4bEsC2cyJgoG0d8ctDLi5jzqdDu2fJ844evpq7Z7PEb4lSRzSUbwNvDfGYG0eWqu9Y5kq539yrrMhHrHnKl3GIMQPRxvHzko64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723730409; c=relaxed/simple;
	bh=VjE4NfRmSu0PuBa/1fJhFSIyi6UvWzfAz36g3PUzzGk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eDskleVu7HFw9ZlahyEWBbidzmYWq9QZ5hBOwcclwSop1+EOY+ZpcHYmjJOGFdbYql0M3SuSe0WefywLCnfEEaUutouiDYqVCh88nGPPkbeQhaqJBO253k8YfGUGF72D3H6bc9lAojgX/hqdQTCHibX+y5cB0Vfz8jreH59ryfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kRMXgrvV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8BD0C4AF0C;
	Thu, 15 Aug 2024 14:00:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723730409;
	bh=VjE4NfRmSu0PuBa/1fJhFSIyi6UvWzfAz36g3PUzzGk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kRMXgrvVQ8zjoE2cMq4XkxjxL/ABksyrGoF+xMEO9zK2++sr6rOAp7lriRXjld/+u
	 Yr5Nqj0Vpoj00e5P9Mr4ydHtX1D9YKfN4tFuSCwIbfwz3VapMRO6PesNhb58YpVzUJ
	 hIOnRL/i5/+WqtsaCgHMNBpGJjkEud5YUfmiD4Gp5BsPRm/lRfpTAo7WLqKYmjZlFL
	 6ZEtwR8safZR6ggzLZo1ScK6PyNM+kOMixGNvP7i4hC3Nn1qfjcUX1vUaFbnmQdZb/
	 d3Xhg4Pw0jfVN8/UlCVoxBy0xUBNrNL+kNowHNMQ92Zcw9o+Xg2Pg2cwF24DawWD+7
	 tDKvU4iQ2FXVA==
Date: Thu, 15 Aug 2024 16:00:01 +0200
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
Subject: Re: [PATCH v5 09/26] rust: alloc: implement kernel `Box`
Message-ID: <Zr4J4e1aLADlyDMD@cassiopeiae>
References: <20240812182355.11641-1-dakr@kernel.org>
 <20240812182355.11641-10-dakr@kernel.org>
 <a69e7280-7291-49f7-a46f-1ad465efce04@proton.me>
 <Zr0ocI-j3fZZM7Rw@cassiopeiae>
 <56ebda7b-c570-4dc6-8456-ab768d3a4b77@proton.me>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <56ebda7b-c570-4dc6-8456-ab768d3a4b77@proton.me>

On Thu, Aug 15, 2024 at 01:24:47PM +0000, Benno Lossin wrote:
> On 14.08.24 23:58, Danilo Krummrich wrote:
> > On Wed, Aug 14, 2024 at 05:01:34PM +0000, Benno Lossin wrote:
> >> On 12.08.24 20:22, Danilo Krummrich wrote:
> >>> +/// The kernel's [`Box`] type - a heap allocation for a single value of type `T`.
> >>> +///
> >>> +/// This is the kernel's version of the Rust stdlib's `Box`. There are a couple of differences,
> >>> +/// for example no `noalias` attribute is emitted and partially moving out of a `Box` is not
> >>> +/// supported.
> >>
> >> I would add "But otherwise it works the same." (I don't know if there is
> >> a comma needed after the "otherwise").
> > 
> > There are more differences we don't list here, and probably don't need to.
> > Hence, saying that it otherwise works the same isn't correct.
> > 
> >> Also I remember that there was one more difference with a custom box
> >> compared to the stdlib, but I forgot what that was, does someone else
> >> remember? We should also put that here.
> > 
> > Obviously, there are also quite some API differences. For instance, `Box`
> > generally requires two generics, value type and allocator, we take page flags
> > and return a `Result`, where std just panics on failure.
> 
> Oh yeah that's true. The things listed above don't really refer to API
> stuff, so I didn't consider that. How about changing "couple
> differences" to "several differences"? Also adding that the APIs are
> different would not hurt.
> 

Sure.

> 
> >>> +
> >>> +/// Type alias for `Box` with a `Kmalloc` allocator.
> >>
> >> I think we should add that this is only designed for small values.
> > 
> > I don't want duplicate the existing documentation around kmalloc and friends
> > [1].
> > 
> > Maybe we can refer to the existing documentation somehow.
> > 
> > [1] https://www.kernel.org/doc/html/latest/core-api/memory-allocation.html
> 
> Oh great! With the C docs, I never know where to find them (is it in the
> code and do they exist?). Yeah let's just link it.
> 
> >>> +///
> >>> +/// # Examples
> >>> +///
> >>> +/// ```
> >>> +/// let b = KBox::new(24_u64, GFP_KERNEL)?;
> >>> +///
> >>> +/// assert_eq!(*b, 24_u64);
> >>> +///
> >>> +/// # Ok::<(), Error>(())
> >>> +/// ```
> >>> +pub type KBox<T> = Box<T, super::allocator::Kmalloc>;
> >>> +
> >>> +/// Type alias for `Box` with a `Vmalloc` allocator.
> >>
> >> Same here, add that this is supposed to be used for big values (or is
> >> this also a general-purpose allocator, just not guaranteeing that the
> >> memory is physically contiguous? in that case I would document it
> >> here and also on `Vmalloc`).
> > 
> > Same as above, I'd rather not duplicate that. But I'm happy to link things in,
> > just not sure what's the best way doing it.
> 
> I took a look at the link and there is the "Selecting memory allocator"
> section, but there isn't really just a vmalloc or kmalloc section, it is
> rather stuff that we would put in the module documentation.

There are no dedicated sections, but...

> What I would write on these types would be what to use these boxes for.
> eg large allocations, general purpose etc. I don't think that that is
> easily accessible from the docs that you linked above.

...this stuff should be covered by the document, e.g.:

"The maximal size of a chunk that can be allocated with kmalloc is limited. The
actual limit depends on the hardware and the kernel configuration, but it is a
good practice to use kmalloc for objects smaller than page size."

or

"For large allocations you can use vmalloc() and vzalloc(), or directly request
pages from the page allocator. The memory allocated by vmalloc and related
functions is not physically contiguous."

I'd probably reference [1] in the module documentation as you say and otherwise
refer to the C APIs, just like `RBTree` does.

> 
> ---
> Cheers,
> Benno
> 

