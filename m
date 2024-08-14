Return-Path: <linux-kernel+bounces-286953-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F38439520C6
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 19:13:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A57E01F22E39
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 17:13:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 102261BBBCD;
	Wed, 14 Aug 2024 17:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="es+ldT/D"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50A0528DC3;
	Wed, 14 Aug 2024 17:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723655601; cv=none; b=lQOX0I6h/PEw6F8C2NSB13oWrV9sCFTfxt0ls1BfM8yIwWgZpZf0galGViYv6Ms0yM/+baJAjxyGOPUuE5+WAGoGxqetSmpNhErqRJHlC6fYYnN659V9Zm1WrmDuZWqB2sva14DIiln3nD1fSOAY1KbU2QC1pa6Q76Ib3G9HLE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723655601; c=relaxed/simple;
	bh=DJ0tPf2qO/ZeZBBDG1UOrsbfoOLKy8q+8P0FrWkqchQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J9Oe520FWOEGSqdrW51xoFey8uL5Y0Z2v4LRWNmrYCawOVT0NLh0aUBkYGLYs9WlGtw8uL5asE1zvhqnQU4ezqXsNTqi1OJfe9zi4r25Fesip3wiq+jisuvZLPzzlKfymoGNIdSVFywD1/xVj/RPJezx6x5KnvHGhBypM5ezm9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=es+ldT/D; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2310AC116B1;
	Wed, 14 Aug 2024 17:13:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723655600;
	bh=DJ0tPf2qO/ZeZBBDG1UOrsbfoOLKy8q+8P0FrWkqchQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=es+ldT/DqHjprxUm+UD9M9GM87UABh2Z+TIJRVfV5qW23yzi1t/USl4Ol43ux+hc6
	 s33vQxJpkyG90VhNtPvLA06fNvJYw2g1ia8GM/eBSsWu+mfIlXXxvGVa/HZLYUOGjr
	 dI3otS8ndT9ywKNAx88NfaHHiIfkz5Es6LVdv3GC2uhzus76fM35UMRXoi7b0pL8aM
	 OGGsovThVWJrvcUVhYXSgfnS3YdLVJat6rixCqxqrHhq7MJFHzoDSUMiNsEIQNw7ta
	 aKm+GLnGP1eGosY9Pnpn8zgiGMfyfJ0I5HRRJNLoJHZSSaezTAzW7XOVv2hCqHuycl
	 NyMRv4NoBqRuQ==
Date: Wed, 14 Aug 2024 19:13:12 +0200
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
Subject: Re: [PATCH v5 04/26] rust: alloc: implement `Allocator` for `Kmalloc`
Message-ID: <ZrzlqFuZ63QJT8Cx@cassiopeiae>
References: <20240812182355.11641-1-dakr@kernel.org>
 <20240812182355.11641-5-dakr@kernel.org>
 <04b0fd96-c91c-4f38-90e9-8acee31e8445@proton.me>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <04b0fd96-c91c-4f38-90e9-8acee31e8445@proton.me>

On Wed, Aug 14, 2024 at 04:28:04PM +0000, Benno Lossin wrote:
> On 12.08.24 20:22, Danilo Krummrich wrote:
> > +unsafe impl Allocator for Kmalloc {
> 
> There is a missing SAFETY comment here (and also for Vmalloc, probably
> also for VKmalloc then).

Any suggestion on what to write here?

I'd probably come up with something like:

--
Memory returned from `Kmalloc` remains valid until explicitly freed.

It is valid to pass any pointer to an allocated memory buffer obtained with any
function of `Kmalloc` to any other function of `Kmalloc`.

If `Kmalloc::realloc` is called with a size of zero, the given memory
allocation, if any, is freed.

If `Kmalloc::realloc` is called with `None` it behaves like `Kmalloc::alloc`,
i.e. a new memory allocation is created.
--

and repeat that for `Vmalloc` and `KVmalloc`.

I'm not sure how useful that is though.

> 
> ---
> Cheers,
> Benno
> 
> > +    unsafe fn realloc(
> > +        ptr: Option<NonNull<u8>>,
> > +        layout: Layout,
> > +        flags: Flags,
> > +    ) -> Result<NonNull<[u8]>, AllocError> {
> > +        // SAFETY: `ReallocFunc::call` has the same safety requirements as `Allocator::realloc`.
> > +        unsafe { ReallocFunc::KREALLOC.call(ptr, layout, flags) }
> > +    }
> > +}
> > +
> >  unsafe impl GlobalAlloc for Kmalloc {
> >      unsafe fn alloc(&self, layout: Layout) -> *mut u8 {
> >          // SAFETY: `ptr::null_mut()` is null and `layout` has a non-zero size by the function safety
> > --
> > 2.45.2
> > 
> 

