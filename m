Return-Path: <linux-kernel+bounces-325165-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 60FE09755BA
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 16:39:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0E7A81F21857
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 14:39:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FBB11AB535;
	Wed, 11 Sep 2024 14:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LPV3lDJ0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7592919F128;
	Wed, 11 Sep 2024 14:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726065483; cv=none; b=MpMiyf/HCtEjTaIrq0a3Sr1/8S7CbcC3QkAr5kypcBB9/zayU/hsOP25YthDJeq7EEgWRsp594ysYnZLV/ofxt3NAs0OQCsQDCxeKepa3DDuiwIyHSQlQlJLk73nIaZvgMN0ECxmmFROp+WSK8wLK1WN3lgEGOHyrubVuXRmF6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726065483; c=relaxed/simple;
	bh=mqHDA66/2LWiEoFN7msYbfNAJjJbyoJbwWfKXNsRYrc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mzUh1ywGqqyqM2MRUt08j5lTe94O9Jv478vt9E7mcMP0M5HKQyMhSC9OuPR5hYK6XW/kDFxCDFhrruoNVAQmDPYv7Pw6o0tucbPtZlhQcPaZTJNWrcCDowirloiETF4cHpneQ5Bb9+v6U2TZKm1cPi3Uf96M63sXrmaObCMe+fA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LPV3lDJ0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 244C7C4CEC0;
	Wed, 11 Sep 2024 14:37:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726065483;
	bh=mqHDA66/2LWiEoFN7msYbfNAJjJbyoJbwWfKXNsRYrc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LPV3lDJ0LW0wWEKaDYHpJ11yP5N2P7CWmzRvEbQBBTjjMqjqYDynZP0lUyYMEkfKs
	 XUHUC/GkZY8lMJY5M3LC8J1XNQcL53qXwd9xgzwEy1qwTay6K2aNde/kxYbXNVE8Ov
	 8Xh8Sw+LpQJj1GK63obyZVdTlXfVIZt2wkf3TVZSd1VhCcMUYRejpOx1NuG5BboKOO
	 4N4IsUWhsSL0XYApgDgw/qY2Ql59mjZseA6a/E2UdcpTFOhGVh1zWhz6E5LBCSg9XI
	 PXrHtNZ77su4ucdVQRU89k3TWj4G0vrgLoF2ReGeOsK10fGwJGmA0oahiOsFfw3qN9
	 AfGeY3QZuaXuw==
Date: Wed, 11 Sep 2024 16:37:53 +0200
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
Subject: Re: [PATCH v6 22/26] rust: alloc: implement `Cmalloc` in module
 allocator_test
Message-ID: <ZuGrQcLwXi-tiK8l@cassiopeiae>
References: <20240816001216.26575-1-dakr@kernel.org>
 <20240816001216.26575-23-dakr@kernel.org>
 <e3ccbf52-224e-4869-992b-4fcaa0ec3410@proton.me>
 <ZtD1TsGm0swi7gyv@pollux.localdomain>
 <ZuGNlFluwAmTG19R@cassiopeiae>
 <bf158e23-4123-419b-a2ce-a27c4ea51219@proton.me>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bf158e23-4123-419b-a2ce-a27c4ea51219@proton.me>

On Wed, Sep 11, 2024 at 01:32:31PM +0000, Benno Lossin wrote:
> On 11.09.24 14:31, Danilo Krummrich wrote:
> > On Fri, Aug 30, 2024 at 12:25:27AM +0200, Danilo Krummrich wrote:
> >> On Thu, Aug 29, 2024 at 07:14:18PM +0000, Benno Lossin wrote:
> >>> On 16.08.24 02:11, Danilo Krummrich wrote:
> >>>> +
> >>>> +        if layout.size() == 0 {
> >>>> +            // SAFETY: `src` has been created by `Self::alloc_store_data`.
> >>>
> >>> This is not true, consider:
> >>>
> >>>     let ptr = alloc(size = 0);
> >>>     free(ptr)
> >>>
> >>> Alloc will return a dangling pointer due to the first if statement and
> >>> then this function will pass it to `free_read_data`, even though it
> >>> wasn't created by `alloc_store_data`.
> >>> This isn't forbidden by the `Allocator` trait function's safety
> >>> requirements.
> >>>
> >>>> +            unsafe { Self::free_read_data(src) };
> >>>> +
> >>>> +            return Ok(NonNull::slice_from_raw_parts(NonNull::dangling(), 0));
> >>>> +        }
> >>>> +
> >>>> +        let dst = Self::alloc(layout, flags)?;
> >>>> +
> >>>> +        // SAFETY: `src` has been created by `Self::alloc_store_data`.
> >>>> +        let data = unsafe { Self::data(src) };
> >>>
> >>> Same issue here, if the allocation passed in is zero size. I think you
> >>> have no other choice than to allocate even for zero size requests...
> >>> Otherwise how would you know that they are zero-sized.
> >>
> >> Good catch - gonna fix it.
> > 
> > Almost got me. :) I think the code is fine, callers are not allowed to pass
> > pointers to `realloc` and `free`, which haven't been allocated with the same
> > corresponding allocator or are dangling.
> 
> But what about the example above (ie the `alloc(size = 0)` and then
> `free`)?

This never has been valid for the `Allocator` trait. Look at `Kmalloc`,
`Vmalloc` and `KVmalloc`, they don't allow this either.

We've discussed this already in previous versions of this series, where for this
purpose, you asked for `old_layout` for `free`. Such that `free` can check if
the `size` was zero and therefore return without doing anything.

> I guess this all depends on how one interprets the term
> "existing, valid memory allocation". To me that describes anything an
> `Allocator` returns via `alloc` and `realloc`, including zero-sized
> allocations.

I argue that the dangling pointer returned for `size == 0` does not point to any
allocation in the sense of those allocators. It's just a dangling `[u8]`
pointer.

> But if you argue that those are not valid allocations from that
> allocator, then that is not properly documented in the safety
> requirements of `Allocator`. 

The safety requirements of `Allocator` where proposed by you and I thought they
consider this aspect?

`realloc` has:

"If `ptr == Some(p)`, then `p` must point to an existing and valid memory
allocation created by this allocator."

`free` has:

"`ptr` must point to an existing and valid memory allocation created by this
`Allocator` and must not be a dangling pointer."

We can add the part about the dangling pointer to `realloc` if you want.

> 
> ---
> Cheers,
> Benno
> 

