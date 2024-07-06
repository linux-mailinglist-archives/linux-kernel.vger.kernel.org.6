Return-Path: <linux-kernel+bounces-243305-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 484E592945B
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jul 2024 17:12:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C183C1F21520
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jul 2024 15:12:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 089AC13AD0F;
	Sat,  6 Jul 2024 15:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZIYpmmE+"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2123571B52
	for <linux-kernel@vger.kernel.org>; Sat,  6 Jul 2024 15:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720278712; cv=none; b=RPfStTV3aHWdTwXY9RW5ZjigUhciOEliqA1QHtlEsXWjmEXGWITKrPJ0WJNZsQTXdJMi/Niird8PGVcY8Z5kMHJeQqi4cFEWMIT2a9sy3uQbYmryuA8EYy2o6HdXkyQhhdYiE5f12KBVviAPzHhTr4hwp/7L3Dqt2y0iVjIBDVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720278712; c=relaxed/simple;
	bh=BGXPqF/he+M8n8bKnThXKeSfU7ZiAJGp2edLUdOx340=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SfOAsmAOS45e2Cz4C3VmfwsJKqRiUNR1yQiQphGkvIbdT8r6uPkpqBBbIDKOzrzIP1D61OMMWgoudWu5OGFBp3dVO/Woamo9Uchxikl4Pgn7jssbwPNilop5YMPYmDD51uoIK1pMiigHFMNrNqcHtMGmWqdtA6Sz43SjVOJFfbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZIYpmmE+; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720278709;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=f9Drg1pcL+fJJSNxrDujMl52l5uOCHsD7N8/R/pFtLM=;
	b=ZIYpmmE+akuZKsmLUG+lsLDudngRl3zalaSYRAdUxRxYj3B9pqv2fLkEs54pb+qUlqnZ87
	Nkoq+u5Pw6OgbS2DAZ8Z6cpqXhZuyUKdDzanmzkhLaWNfOWWD8lS0ef22z1aWGlawxxnYr
	IAyrms3GUQRkb9PqnUadgxrRQnQ0K+I=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-471-lik2YIl9MlG1VksZ3U_k7w-1; Sat, 06 Jul 2024 11:11:45 -0400
X-MC-Unique: lik2YIl9MlG1VksZ3U_k7w-1
Received: by mail-lj1-f199.google.com with SMTP id 38308e7fff4ca-2ec72d14876so24889131fa.2
        for <linux-kernel@vger.kernel.org>; Sat, 06 Jul 2024 08:11:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720278703; x=1720883503;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f9Drg1pcL+fJJSNxrDujMl52l5uOCHsD7N8/R/pFtLM=;
        b=J8KYq5TKZq8EXwLqfVt+Uad4ek/dSrmzT7QKMA1EXS9kOJsptD6OYjDThtTmvxnPbA
         Wv9e+ZRudvoYwhSoG7xBvAXRk5v2HBQmWv+etnIF4ZcTd73Q2vyK6amOBjOEFjYfqphx
         rUlsefKLh+a4jtBhN6+Y5/cppCEB61R8k4EG7CZUvRd6ho7uj+HVDZxzujPzNvRjFBf0
         UCT6iHuBO9TBJuDJDbcIkc8zoWZydcA7MaeJKv2udl0TZaErzok07CtewFLk1aJFVpJx
         B8c0hID+4uUjiwAoa4JUNAMFXG3vjqk2l2DKcEFwVVDN67CVC/ZRMkUIbubktCmxXy07
         mvdg==
X-Forwarded-Encrypted: i=1; AJvYcCW9pDUkpusadX241SKNsK6JPdnwl6LhwAhi4ho5gtF6xiMkRDq7026GDoDHj5Pf1ygFtnU/pAooZgIYIoIwzwABMxnPAFzOHMPrMLeL
X-Gm-Message-State: AOJu0YyDMjK/gUUjcjiWvb5RYlle6/9Nouhlow1VVib+Vgeca96fHX3u
	LFIvZHoR9s4CR9KOLROH7VymjM68clVRE6o6Kbu7XQl9b2wycD1cFRkgSC/iIbkThUGak+B8zdB
	reGkmOyqOBgY6b5YO009Gtnnrii6Jhr0QB6rPFgemzJiYjE9A45OvpQbdt/zHtQ==
X-Received: by 2002:a2e:a5c4:0:b0:2ec:4399:9c0f with SMTP id 38308e7fff4ca-2ee8ec6fccfmr63610501fa.0.1720278703626;
        Sat, 06 Jul 2024 08:11:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEXQpEcHiIHBZR4uOoqLIphHdwqLkdbh9n5g2nccrQ8lfR5TX+chvwswbLCdc36Vtwuy4zKIw==
X-Received: by 2002:a2e:a5c4:0:b0:2ec:4399:9c0f with SMTP id 38308e7fff4ca-2ee8ec6fccfmr63610241fa.0.1720278703135;
        Sat, 06 Jul 2024 08:11:43 -0700 (PDT)
Received: from pollux.localdomain ([2a02:810d:4b3f:ee94:701e:8fb8:a84f:6308])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4264a283551sm100210825e9.42.2024.07.06.08.11.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Jul 2024 08:11:42 -0700 (PDT)
Date: Sat, 6 Jul 2024 17:11:41 +0200
From: Danilo Krummrich <dakr@redhat.com>
To: Benno Lossin <benno.lossin@proton.me>
Cc: ojeda@kernel.org, alex.gaynor@gmail.com, wedsonaf@gmail.com,
	boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com,
	a.hindborg@samsung.com, aliceryhl@google.com,
	daniel.almeida@collabora.com, faith.ekstrand@collabora.com,
	boris.brezillon@collabora.com, lina@asahilina.net,
	mcanal@igalia.com, zhiw@nvidia.com, acurrid@nvidia.com,
	cjia@nvidia.com, jhubbard@nvidia.com, airlied@redhat.com,
	ajanulgu@redhat.com, lyude@redhat.com, linux-kernel@vger.kernel.org,
	rust-for-linux@vger.kernel.org
Subject: Re: [PATCH 01/20] rust: alloc: add `Allocator` trait
Message-ID: <ZolerSMkVl0C4yfF@pollux.localdomain>
References: <20240704170738.3621-1-dakr@redhat.com>
 <20240704170738.3621-2-dakr@redhat.com>
 <37d87244-fbef-414c-a726-60839b305040@proton.me>
 <ZoklB7aLyc90kWPT@pollux.localdomain>
 <2c322b00-20f8-4102-9f3b-edab0c0907b9@proton.me>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2c322b00-20f8-4102-9f3b-edab0c0907b9@proton.me>

On Sat, Jul 06, 2024 at 01:17:19PM +0000, Benno Lossin wrote:
> On 06.07.24 13:05, Danilo Krummrich wrote:
> > On Sat, Jul 06, 2024 at 10:33:49AM +0000, Benno Lossin wrote:
> >> On 04.07.24 19:06, Danilo Krummrich wrote:
> >>> +pub unsafe trait Allocator {
> >>> +    /// Allocate memory based on `layout` and `flags`.
> >>> +    ///
> >>> +    /// On success, returns a buffer represented as `NonNull<[u8]>` that satisfies the size an
> >>
> >> typo "an" -> "and"
> >>
> >>> +    /// alignment requirements of layout, but may exceed the requested size.
> >>
> >> Also if it may exceed the size, then I wouldn't call that "satisfies the
> >> size [...] requirements".
> > 
> > Do you have a better proposal? To me "satisfies or exceeds" sounds reasonable.
> 
> I think "satisfies the layout constraints (i.e. minimum size and
> alignment as specified by `layout`)" would be better.
> 
> >>> +    ///
> >>> +    /// This function is equivalent to `realloc` when called with a NULL pointer and an `old_size`
> >>> +    /// of `0`.
> >>
> >> This is only true for the default implementation and could be
> >> overridden, since it is not a requirement of implementing this trait to
> >> keep it this way. I would remove this sentence.
> > 
> > I could add a bit more generic description and say that for the default impl
> > "This function is eq..."?
> > 
> >>
> >>> +    fn alloc(&self, layout: Layout, flags: Flags) -> Result<NonNull<[u8]>, AllocError> {
> >>
> >> Instead of using the `Flags` type from the alloc module, we should have
> >> an associated `Flags` type in this trait.
> > 
> > What does this give us?
> 
> 1. IIRC not all flags can be used with every allocator (or do not have
>    an effect) and it would be best if only the working ones are allowed.

Agreed, but I'm not sure if it's worth the effort having different `Flags`
types for that only.

But I guess this and the below argument justify using an associated type. I will
queue this change up.

> 2. that way the design is more flexible and could be upstreamed more
>    easily.
> 
> >> Similarly, it might also be a good idea to let the implementer specify a
> >> custom error type.
> > 
> > Same here, why?
> 
> In this case the argument is weaker, but it could allow us to implement
> an allocator with `Error = Infallible`, to statically guarantee
> allocation (e.g. when using GFP_ATOMIC). But at the moment there is no
> user.

GFP_ATOMIC can fail, I guess you mean __GFP_NOFAIL.

Not really sure how this would work other than with separate `alloc_nofail` and
`realloc_nofail` functions?

> 
> >>> +        // SAFETY: Passing a NULL pointer to `realloc` is valid by it's safety requirements and asks
> >>> +        // for a new memory allocation.
> >>> +        unsafe { self.realloc(ptr::null_mut(), 0, layout, flags) }
> >>> +    }
> >>> +
> >>> +    /// Re-allocate an existing memory allocation to satisfy the requested `layout`. If the
> >>> +    /// requested size is zero, `realloc` behaves equivalent to `free`.
> >>
> >> This is not guaranteed by the implementation.
> > 
> > Not sure what exactly you mean? Is it about "satisfy" again?
> 
> If the requested size is zero, the implementation could also leak the
> memory, nothing prevents me from implementing such an Allocator.

Well, hopefully the documentation stating that `realloc` must be implemented
this exact way prevents you from doing otherwise. :-)

Please let me know if I need to document this in a different way if it's not
sufficient as it is.

> 
> >>> +    ///
> >>> +    /// If the requested size is larger than `old_size`, a successful call to `realloc` guarantees
> >>> +    /// that the new or grown buffer has at least `Layout::size` bytes, but may also be larger.
> >>> +    ///
> >>> +    /// If the requested size is smaller than `old_size`, `realloc` may or may not shrink the
> >>> +    /// buffer; this is implementation specific to the allocator.
> >>> +    ///
> >>> +    /// On allocation failure, the existing buffer, if any, remains valid.
> >>> +    ///
> >>> +    /// The buffer is represented as `NonNull<[u8]>`.
> >>> +    ///
> >>> +    /// # Safety
> >>> +    ///
> >>> +    /// `ptr` must point to an existing and valid memory allocation created by this allocator
> >>> +    /// instance of a size of at least `old_size`.
> >>> +    ///
> >>> +    /// Additionally, `ptr` is allowed to be a NULL pointer; in this case a new memory allocation is
> >>> +    /// created.
> >>> +    unsafe fn realloc(
> >>> +        &self,
> >>> +        ptr: *mut u8,
> >>> +        old_size: usize,
> >>
> >> Why not request the old layout like the std Allocator's grow/shrink
> >> functions do?
> > 
> > Because we only care about the size that needs to be preserved when growing the
> > buffer. The `alignment` field of `Layout` would be wasted.
> 
> In the std Allocator they specified an old layout. This is probably
> because of the following: if `Layout` is ever extended to hold another
> property that would need to be updated, the signatures are already
> correct.
> In our case we could change it tree-wide, so I guess we could fix that
> issue when it comes up.

Yes, I think so too.

> 
> >>> +        layout: Layout,
> >>> +        flags: Flags,
> >>> +    ) -> Result<NonNull<[u8]>, AllocError>;
> >>> +
> >>> +    /// Free an existing memory allocation.
> >>> +    ///
> >>> +    /// # Safety
> >>> +    ///
> >>> +    /// `ptr` must point to an existing and valid memory allocation created by this `Allocator`
> >>> +    /// instance.
> >>> +    unsafe fn free(&self, ptr: *mut u8) {
> >>
> >> `ptr` should be `NonNull<u8>`.
> > 
> > Creating a `NonNull` from a raw pointer is an extra operation for any user of
> > `free` and given that all `free` functions in the kernel accept a NULL pointer,
> > I think there is not much value in making this `NonNull`.
> 
> I don't think that this argument holds for Rust though. For example,
> `KBox` contains a `Unique` that contains a `NonNull`, so freeing could
> just be done with `free(self.0.0)`.

Agreed, we can indeed make it a `&NonNull<u8>`. However, I find this a bit
inconsistent with the signature of `realloc`.

Should we go with separate `shrink` / `grow`, `free` could be implemented as
shrinking to zero and allowing a NULL pointer makes not much sense.

But as mentioned, I'm not yet seeing the benefit of having `realloc` split into
`grow` and `shrink`.

> 
> >>> +        // SAFETY: `ptr` is guaranteed to be previously allocated with this `Allocator` or NULL.
> >>> +        // Calling `realloc` with a buffer size of zero, frees the buffer `ptr` points to.
> >>> +        let _ = unsafe { self.realloc(ptr, 0, Layout::new::<()>(), Flags(0)) };
> >>
> >> Why does the implementer have to guarantee this?
> > 
> > Who else can guarantee this?
> 
> Only the implementer yes. But they are not forced to do this i.e.
> nothing in the safety requirements of `Allocator` prevents me from doing
> a no-op on reallocating to a zero size.

Ah, I see now, this is the same as your comment on the documentation of
`realloc`. So, this indeed just about missing a safety comment.

> 
> >>> +    }
> >>> +}
> >>> --
> >>> 2.45.2
> >>>
> >>
> >> More general questions:
> >> - are there functions in the kernel to efficiently allocate zeroed
> >>   memory? In that case, the Allocator trait should also have methods
> >>   that do that (with a iterating default impl).
> > 
> > We do this with GFP flags. In particular, you can pass GFP_ZERO to `alloc` and
> > `realloc` to get zeroed memory. Hence, I think having dedicated functions that
> > just do "flags | GFP_ZERO" would not add much value.
> 
> Ah right, no in that case, we don't need it.
> 
> >> - I am not sure putting everything into the single realloc function is a
> >>   good idea, I like the grow/shrink methods of the std allocator. Is
> >>   there a reason aside from concentrating the impl to go for only a
> >>   single realloc function?
> > 
> > Yes, `krealloc()` already provides exactly the described behaviour. See the
> > implementation of `Kmalloc`.
> 
> But `kvmalloc` does not and neither does `vmalloc`. I would prefer
> multiple smaller functions over one big one in this case.

What I forsee is that:

  - `alloc` becomes a `grow` from zero.
  - `free` becomes a `shrink` to zero.
  - `grow` and `shrink` become a `realloc` alias,
     because they're almost the same

Wouldn't this just put us were we already are, effectively?

> 
> ---
> Cheers,
> Benno
> 


