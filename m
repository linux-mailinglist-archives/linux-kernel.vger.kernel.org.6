Return-Path: <linux-kernel+bounces-243169-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE9D29292B3
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jul 2024 13:06:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AED1B1C20F74
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jul 2024 11:06:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B85774424;
	Sat,  6 Jul 2024 11:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ly9NWTXC"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A04AD4AED7
	for <linux-kernel@vger.kernel.org>; Sat,  6 Jul 2024 11:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720263952; cv=none; b=U2O+fRop3ETXRT6Ew4/8YqdGvnnBlah5566BEiYAT2AOX/9cRHElYFvCJhNQXqeF+JBZfk4FoXtLJGd+1EwAqzKHuycJpkPuZ/2Vjd/LEjiU5fHPKrtgM/m8q24P+6O/71J5AFeKivwTEJyW5MIVlYO1d5HlW8gM9nPN4pQnH2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720263952; c=relaxed/simple;
	bh=CIVNIJuyVvHFql7fC1dXJSjgL0sMWVexrM7r5FOLJj8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pfB/lCh8Gv1Y7e8uG9StZkwtb8K79kLIMLCpTGk+qzFs+0o3Dr/Jd2BtrIBqRjiZfVBrSINEm/68tQrRnxvg5rHe3SAyEvLFGRXph/m+fwzULNzP1A80Cpnk1VyCrOnklBXPDwxIJ9Va2akFVuuSuIZa7RLrJAfbCHvWfN7rods=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ly9NWTXC; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720263949;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3vL262l3kI0LSuVBnB5u+EZwZt8j6laPvN4iOeYawQU=;
	b=Ly9NWTXCyu9/xBisuC+66EYGGKeet0dBN3RV01TvKDxYIT4PMT8TZfjiLiMBMsm2vvhhY+
	kUnOUXoVDU8rjlbBd5gL3azzrfDkZEpcYmSVWktBtueQVs04YdXHPSt97KKB52ijDamomm
	cC9VBs2gpWZ05pcyY5tO0hfr1nFrq5c=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-346-5jH2WASqMqybwb-Cf336xA-1; Sat, 06 Jul 2024 07:05:47 -0400
X-MC-Unique: 5jH2WASqMqybwb-Cf336xA-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4256849a9f4so17503555e9.3
        for <linux-kernel@vger.kernel.org>; Sat, 06 Jul 2024 04:05:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720263946; x=1720868746;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3vL262l3kI0LSuVBnB5u+EZwZt8j6laPvN4iOeYawQU=;
        b=mL4lmAlqXfxidqRB4d/aA5EZAahK/zIQ4z9gm8U8+9JI/yZETt1Fzf27FmofXGuBtA
         CenHI0cHPnIVcZLZMd/ikrVKFekK81YnbC98S6Z3I82f6p6s4A0++qFv7MFOGL4LhUSl
         qyN9a5kE3KKhYF6xh3NmxBHrGRpbO9HeLSJJSj3nxpFCtWJYwcSxkpCaS29LN+s7pz+u
         QQibNgPgrlyv0Zs/7FlDpT5zrIG/+TqnJhjGUZ6Y0eDWa2x54c3xd+T4CitTRpVwH7bY
         cOmSmsYMVXy7kIqpRA3cQy2B9hfrmiOepGTD2IMQdymWFEpzTIZY85i6VmhFVgHGmvHy
         PvlQ==
X-Forwarded-Encrypted: i=1; AJvYcCU86hqsHcMFALL51mpubrYjlzPnwPC0QSnG4/ER0gW/ekmbszQn7qM/gIlCgclcwyhhCKqObr9+1VHszUfeHN7VCqibGWeXFyhR1iqq
X-Gm-Message-State: AOJu0YxEOTSgzIdktwa2HacX+pzXc6v2jDeQb3ln1MEJIwaCNQT2eUWh
	8ru/F50UxRMsRjLaAJKjTTvN0PzeGTcfOm8T1Nduq/0poT57xnL9lFfkaZD49o9sKSHmtAMahCp
	3RsSTfuRyxpZnY6tcdTW55PJbj9vl5/2cAewiIb78Je1Nay4EvCVm6CwYmTPnNA==
X-Received: by 2002:a05:600c:4393:b0:426:5de3:2ae5 with SMTP id 5b1f17b1804b1-4265de32becmr15193595e9.10.1720263945851;
        Sat, 06 Jul 2024 04:05:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFY4Lj5WUwUNVbGICYbcPxa1Fi6Uvtco2OqG6SgCJJoo5Gk7VbJV8koFqpHs65NnJhQJMzFmA==
X-Received: by 2002:a05:600c:4393:b0:426:5de3:2ae5 with SMTP id 5b1f17b1804b1-4265de32becmr15193465e9.10.1720263945409;
        Sat, 06 Jul 2024 04:05:45 -0700 (PDT)
Received: from pollux.localdomain ([2a02:810d:4b3f:ee94:701e:8fb8:a84f:6308])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3679b1e5f31sm6393013f8f.33.2024.07.06.04.05.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Jul 2024 04:05:44 -0700 (PDT)
Date: Sat, 6 Jul 2024 13:05:43 +0200
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
Message-ID: <ZoklB7aLyc90kWPT@pollux.localdomain>
References: <20240704170738.3621-1-dakr@redhat.com>
 <20240704170738.3621-2-dakr@redhat.com>
 <37d87244-fbef-414c-a726-60839b305040@proton.me>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <37d87244-fbef-414c-a726-60839b305040@proton.me>

On Sat, Jul 06, 2024 at 10:33:49AM +0000, Benno Lossin wrote:
> On 04.07.24 19:06, Danilo Krummrich wrote:
> > Add a kernel specific `Allocator` trait, that in contrast to the one in
> > Rust's core library doesn't require unstable features and supports GFP
> > flags.
> > 
> > Subsequent patches add the following trait implementors: `Kmalloc`,
> > `Vmalloc` and `KVmalloc`.
> > 
> > Signed-off-by: Danilo Krummrich <dakr@redhat.com>
> > ---
> >  rust/kernel/alloc.rs | 73 ++++++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 73 insertions(+)
> > 
> > diff --git a/rust/kernel/alloc.rs b/rust/kernel/alloc.rs
> > index 531b5e471cb1..462e00982510 100644
> > --- a/rust/kernel/alloc.rs
> > +++ b/rust/kernel/alloc.rs
> > @@ -11,6 +11,7 @@
> >  /// Indicates an allocation error.
> >  #[derive(Copy, Clone, PartialEq, Eq, Debug)]
> >  pub struct AllocError;
> > +use core::{alloc::Layout, ptr, ptr::NonNull};
> > 
> >  /// Flags to be used when allocating memory.
> >  ///
> > @@ -71,3 +72,75 @@ pub mod flags {
> >      /// small allocations.
> >      pub const GFP_NOWAIT: Flags = Flags(bindings::GFP_NOWAIT);
> >  }
> > +
> > +/// The kernel's [`Allocator`] trait.
> > +///
> > +/// An implementation of [`Allocator`] can allocate, re-allocate and free memory buffer described
> > +/// via [`Layout`].
> > +///
> > +/// [`Allocator`] is designed to be implemented on ZSTs; its safety requirements to not allow for
> > +/// keeping a state throughout an instance.
> 
> Why do the functions take `&self` if it is forbidden to have state? I
> would remove the receiver in that case.

Yes, that that makes sense.

> 
> > +///
> > +/// # Safety
> > +///
> > +/// Memory returned from an allocator must point to a valid memory buffer and remain valid until
> > +/// its explicitly freed.
> > +///
> > +/// Copying, cloning, or moving the allocator must not invalidate memory blocks returned from this
> > +/// allocator. A copied, cloned or even new allocator of the same type must behave like the same
> > +/// allocator, and any pointer to a memory buffer which is currently allocated may be passed to any
> > +/// other method of the allocator.
> 
> If you provide no receiver methods, then I think we can remove this
> requirement.

Indeed.

> 
> > +pub unsafe trait Allocator {
> > +    /// Allocate memory based on `layout` and `flags`.
> > +    ///
> > +    /// On success, returns a buffer represented as `NonNull<[u8]>` that satisfies the size an
> 
> typo "an" -> "and"
> 
> > +    /// alignment requirements of layout, but may exceed the requested size.
> 
> Also if it may exceed the size, then I wouldn't call that "satisfies the
> size [...] requirements".

Do you have a better proposal? To me "satisfies or exceeds" sounds reasonable.

> 
> > +    ///
> > +    /// This function is equivalent to `realloc` when called with a NULL pointer and an `old_size`
> > +    /// of `0`.
> 
> This is only true for the default implementation and could be
> overridden, since it is not a requirement of implementing this trait to
> keep it this way. I would remove this sentence.

I could add a bit more generic description and say that for the default impl
"This function is eq..."?

> 
> > +    fn alloc(&self, layout: Layout, flags: Flags) -> Result<NonNull<[u8]>, AllocError> {
> 
> Instead of using the `Flags` type from the alloc module, we should have
> an associated `Flags` type in this trait.

What does this give us?

> 
> Similarly, it might also be a good idea to let the implementer specify a
> custom error type.

Same here, why?

> 
> > +        // SAFETY: Passing a NULL pointer to `realloc` is valid by it's safety requirements and asks
> > +        // for a new memory allocation.
> > +        unsafe { self.realloc(ptr::null_mut(), 0, layout, flags) }
> > +    }
> > +
> > +    /// Re-allocate an existing memory allocation to satisfy the requested `layout`. If the
> > +    /// requested size is zero, `realloc` behaves equivalent to `free`.
> 
> This is not guaranteed by the implementation.

Not sure what exactly you mean? Is it about "satisfy" again?

> 
> > +    ///
> > +    /// If the requested size is larger than `old_size`, a successful call to `realloc` guarantees
> > +    /// that the new or grown buffer has at least `Layout::size` bytes, but may also be larger.
> > +    ///
> > +    /// If the requested size is smaller than `old_size`, `realloc` may or may not shrink the
> > +    /// buffer; this is implementation specific to the allocator.
> > +    ///
> > +    /// On allocation failure, the existing buffer, if any, remains valid.
> > +    ///
> > +    /// The buffer is represented as `NonNull<[u8]>`.
> > +    ///
> > +    /// # Safety
> > +    ///
> > +    /// `ptr` must point to an existing and valid memory allocation created by this allocator
> > +    /// instance of a size of at least `old_size`.
> > +    ///
> > +    /// Additionally, `ptr` is allowed to be a NULL pointer; in this case a new memory allocation is
> > +    /// created.
> > +    unsafe fn realloc(
> > +        &self,
> > +        ptr: *mut u8,
> > +        old_size: usize,
> 
> Why not request the old layout like the std Allocator's grow/shrink
> functions do?

Because we only care about the size that needs to be preserved when growing the
buffer. The `alignment` field of `Layout` would be wasted.

> 
> > +        layout: Layout,
> > +        flags: Flags,
> > +    ) -> Result<NonNull<[u8]>, AllocError>;
> > +
> > +    /// Free an existing memory allocation.
> > +    ///
> > +    /// # Safety
> > +    ///
> > +    /// `ptr` must point to an existing and valid memory allocation created by this `Allocator`
> > +    /// instance.
> > +    unsafe fn free(&self, ptr: *mut u8) {
> 
> `ptr` should be `NonNull<u8>`.

Creating a `NonNull` from a raw pointer is an extra operation for any user of
`free` and given that all `free` functions in the kernel accept a NULL pointer,
I think there is not much value in making this `NonNull`.

> 
> > +        // SAFETY: `ptr` is guaranteed to be previously allocated with this `Allocator` or NULL.
> > +        // Calling `realloc` with a buffer size of zero, frees the buffer `ptr` points to.
> > +        let _ = unsafe { self.realloc(ptr, 0, Layout::new::<()>(), Flags(0)) };
> 
> Why does the implementer have to guarantee this?

Who else can guarantee this?

> 
> > +    }
> > +}
> > --
> > 2.45.2
> > 
> 
> More general questions:
> - are there functions in the kernel to efficiently allocate zeroed
>   memory? In that case, the Allocator trait should also have methods
>   that do that (with a iterating default impl).

We do this with GFP flags. In particular, you can pass GFP_ZERO to `alloc` and
`realloc` to get zeroed memory. Hence, I think having dedicated functions that
just do "flags | GFP_ZERO" would not add much value.

> - I am not sure putting everything into the single realloc function is a
>   good idea, I like the grow/shrink methods of the std allocator. Is
>   there a reason aside from concentrating the impl to go for only a
>   single realloc function?

Yes, `krealloc()` already provides exactly the described behaviour. See the
implementation of `Kmalloc`.

> 
> ---
> Cheers,
> Benno
> 


