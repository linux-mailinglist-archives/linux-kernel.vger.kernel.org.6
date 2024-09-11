Return-Path: <linux-kernel+bounces-324906-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1964497526B
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 14:34:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AF9521F22709
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 12:34:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E76BF18A6A0;
	Wed, 11 Sep 2024 12:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T4A6vh6c"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E38E185B7A;
	Wed, 11 Sep 2024 12:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726057886; cv=none; b=lNF371zEOiBS/a3UwYA24px8jnyTheSLl9ZTDlkRkcz9FZv3BPb+WE3Orfo7U4l+Xy89cZ2AgkcNoXjuLZtvpcnuAj+bZEXgcLlCL4lf2g1l/DwOCfvwmSYCcxOJyb2NUw7RHXOHtU59y04fEf2zWYzYWYxuIlzCqTEYhBrGbvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726057886; c=relaxed/simple;
	bh=eU3oOgqP7mozRvjpQC5rfw+p/h07bXakoBco4xUGrec=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ruCPtIe3XNrL9rwGHlI67L5lk2nN7hovMBrUwaAzWq/6UNiDsW8h328SM/nYNwhlDGnXYTnpwDODfHUhWXOj4xotOiSmoh82mg5tXUg8X1hSe7E5sWcwEqyTZhsPV5ZJWd+N5RwymtF6HQN86RzTFl/V0k+f8uIa7U61QZgrrtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T4A6vh6c; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27802C4CEC5;
	Wed, 11 Sep 2024 12:31:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726057883;
	bh=eU3oOgqP7mozRvjpQC5rfw+p/h07bXakoBco4xUGrec=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=T4A6vh6cbK6ZufKbZhNi3k1K95qYH460093V3SDwP3w3NF0b1mDzp9VAZ1trcsTaf
	 HPYAU/BozaKvBziW+zGOBpW8jWVHUzaUILaPCAFaWiUwMlRnYSfMrYSBVopGX0WKka
	 oDG2/p0IJAZuyOy1jiJWFNNy7f85NoRWCDus+XlOiqLkwpalyOsz6deVpSKVRDah39
	 SpekqTn+vU3RCz0IjjNRDzSNc7p3HrP+Z8dQK8h6ySFLB6yLW3t0BmGig7p54AqLLi
	 fz5pGEMUZ0KCNRudvLF8WbmUscL/Ig2eHHhGDIvbLxNaIqQr80RuExsjsWDVcF4Wjc
	 vNv9Cp51/3Dpw==
Date: Wed, 11 Sep 2024 14:31:16 +0200
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
Message-ID: <ZuGNlFluwAmTG19R@cassiopeiae>
References: <20240816001216.26575-1-dakr@kernel.org>
 <20240816001216.26575-23-dakr@kernel.org>
 <e3ccbf52-224e-4869-992b-4fcaa0ec3410@proton.me>
 <ZtD1TsGm0swi7gyv@pollux.localdomain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZtD1TsGm0swi7gyv@pollux.localdomain>

On Fri, Aug 30, 2024 at 12:25:27AM +0200, Danilo Krummrich wrote:
> On Thu, Aug 29, 2024 at 07:14:18PM +0000, Benno Lossin wrote:
> > On 16.08.24 02:11, Danilo Krummrich wrote:
> > 
> > > +
> > > +        if layout.size() == 0 {
> > > +            // SAFETY: `src` has been created by `Self::alloc_store_data`.
> > 
> > This is not true, consider:
> > 
> >     let ptr = alloc(size = 0);
> >     free(ptr)
> > 
> > Alloc will return a dangling pointer due to the first if statement and
> > then this function will pass it to `free_read_data`, even though it
> > wasn't created by `alloc_store_data`.
> > This isn't forbidden by the `Allocator` trait function's safety
> > requirements.
> > 
> > > +            unsafe { Self::free_read_data(src) };
> > > +
> > > +            return Ok(NonNull::slice_from_raw_parts(NonNull::dangling(), 0));
> > > +        }
> > > +
> > > +        let dst = Self::alloc(layout, flags)?;
> > > +
> > > +        // SAFETY: `src` has been created by `Self::alloc_store_data`.
> > > +        let data = unsafe { Self::data(src) };
> > 
> > Same issue here, if the allocation passed in is zero size. I think you
> > have no other choice than to allocate even for zero size requests...
> > Otherwise how would you know that they are zero-sized.
> 
> Good catch - gonna fix it.

Almost got me. :) I think the code is fine, callers are not allowed to pass
pointers to `realloc` and `free`, which haven't been allocated with the same
corresponding allocator or are dangling.

> 
> > 
> > ---
> > Cheers,
> > Benno
> > 
> > > +
> > > +        // SAFETY: `src` has previously been allocated with this `Allocator`; `dst` has just been
> > > +        // newly allocated. Copy up to the smaller of both sizes.
> > > +        unsafe {
> > > +            ptr::copy_nonoverlapping(
> > > +                src.as_ptr(),
> > > +                dst.as_ptr().cast(),
> > > +                cmp::min(layout.size(), data.size),
> > > +            )
> > > +        };
> > > +
> > > +        // SAFETY: `src` has been created by `Self::alloc_store_data`.
> > > +        unsafe { Self::free_read_data(src) };
> > > +
> > > +        Ok(dst)
> > >      }
> > >  }
> > > --
> > > 2.46.0
> > > 
> > 

