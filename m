Return-Path: <linux-kernel+bounces-243173-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05F139292BB
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jul 2024 13:14:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B19A1282A2C
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jul 2024 11:14:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 654A480600;
	Sat,  6 Jul 2024 11:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VgU8qung"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 197A177F15
	for <linux-kernel@vger.kernel.org>; Sat,  6 Jul 2024 11:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720264433; cv=none; b=CpfL+ELzjv49LTaGVSttbIyhRum73a168pQ85Eltc8qfCZBtdAXRgC5LQtrAAG3onthYecghgAZh7t7VXON43tc++YlJRqrmJtWs/nLtgZ8Fx7Bt797jSDNDM6TEGXuDkTAN5ganK2RklyV6vchEnGPGBxjTpgCE4Bgzu/ZEvCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720264433; c=relaxed/simple;
	bh=xwPo/8yNRDZw9B0/2bqVanEnQ9fyVSXpmnx0NEjQuFE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nhLEUXupRHKJBlsyDRHGoIJCx5ZKtPpwEnZspgWEnwECuX1YZFKY6N0x/yYelTth4NmGcy839nFD5FirT/VhzwO3BALQbsv6FjBWgAH0exy6yBq+x1g/g4XasQGSigOdPKQ1gqKyBLDFQckGAmVZYA0Yyf4i/NTwVyhOcuHYIN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VgU8qung; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720264430;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9Pc+ghM1IGnVK60OdMJPrFWjFdR/3X7MPMFaJLrjd08=;
	b=VgU8qungVMpCuCcr1RLxnRSSM9uOYUgf9Zl/XaK1wrFbojUOWgeXqYw66km6HUrIGuBJbs
	kVIwTOcZSEdvnvH+RpnYWkeel8hoPCDYHKOT0iBVrrddyBYr02Efn8JGqp7b6NoEk302IE
	aXz0iTbmH5TVXH9XZm8CzQb4RqySFoY=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-164-aC3tbNKRO1qwvBs7nZWU-g-1; Sat, 06 Jul 2024 07:13:48 -0400
X-MC-Unique: aC3tbNKRO1qwvBs7nZWU-g-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3679aa0ee0aso1557110f8f.2
        for <linux-kernel@vger.kernel.org>; Sat, 06 Jul 2024 04:13:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720264427; x=1720869227;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9Pc+ghM1IGnVK60OdMJPrFWjFdR/3X7MPMFaJLrjd08=;
        b=km20kXATClesYbULgLe0UPwvZx0vAeZPestHHa3Do+GKGsPe492rYfaF4+uwuBcOdi
         fncevf2Zq+OS1+zv2k05vDgQVVrJPhpc7svC4GUPhfoOOmPG4hnfdXF7ZBNdANkkK50f
         W4feLyJ+b1nPJ/pNACxsH9Q3BPn3LangD3KuCXdRCuiVUxiOzQfkH9AbXvUjofAypPBN
         umTW3K3AnxU3Byo4d0dgnhQSDZwKTTda5vnanmfUEo8BBHWsXAxiDSOJ7YRMt4mzXQNb
         8IdVRuQ3mkw8HGEAeMaAPPFzZOmbBf925DP2xmleDItB1r1CJTgef1sNwu+U9BsNiK6p
         e+5w==
X-Forwarded-Encrypted: i=1; AJvYcCU7TjiEyVFBGaoYm0LG5gRvq8dCiD/uRPXS1yaciP+6XEF1cOuMxfms93NPnDss3+rRe0qStEQ5Rd1cbiFu99D1Xmwc7ZmwhoRJV3Hz
X-Gm-Message-State: AOJu0YwYo6T4b/o1l7Kb+hDWvjUcqN3tJmhWGNUGOUTRU0phM5ouG5uE
	nXVEuCyjMcCq0icgfSncuG/t4+x4rTV9uXPaBmw9BT1KiTng+GFtsA7jm0hSa0pHwFBGZPyqGAY
	lO56+2cMHPqIOx1VrI6GbLn+nenmdyA7rE2F9I3Ni/WI12CrcB9H1dYfpnbb/9A==
X-Received: by 2002:adf:e248:0:b0:367:88e8:fed1 with SMTP id ffacd0b85a97d-3679dd27817mr4098110f8f.25.1720264427176;
        Sat, 06 Jul 2024 04:13:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGk/gWmNdk0i/OIcjict+BJuPcLjlkZaZen7ujO3zcNrCw23lTLaMsPr7sHVxgvuMFi/ABCCQ==
X-Received: by 2002:adf:e248:0:b0:367:88e8:fed1 with SMTP id ffacd0b85a97d-3679dd27817mr4098091f8f.25.1720264426784;
        Sat, 06 Jul 2024 04:13:46 -0700 (PDT)
Received: from pollux.localdomain ([2a02:810d:4b3f:ee94:701e:8fb8:a84f:6308])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4264a2ca62bsm93272425e9.35.2024.07.06.04.13.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Jul 2024 04:13:46 -0700 (PDT)
Date: Sat, 6 Jul 2024 13:13:44 +0200
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
Subject: Re: [PATCH 07/20] rust: alloc: implement `Vmalloc` allocator
Message-ID: <Zokm6M48WunoEohV@pollux.localdomain>
References: <20240704170738.3621-1-dakr@redhat.com>
 <20240704170738.3621-8-dakr@redhat.com>
 <596c6446-eca4-46a8-91c5-e71e92c61062@proton.me>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <596c6446-eca4-46a8-91c5-e71e92c61062@proton.me>

On Sat, Jul 06, 2024 at 10:41:28AM +0000, Benno Lossin wrote:
> On 04.07.24 19:06, Danilo Krummrich wrote:
> > @@ -112,6 +118,55 @@ unsafe fn alloc_zeroed(&self, layout: Layout) -> *mut u8 {
> >      }
> >  }
> > 
> > +unsafe impl Allocator for Vmalloc {
> > +    unsafe fn realloc(
> > +        &self,
> > +        src: *mut u8,
> > +        old_size: usize,
> > +        layout: Layout,
> > +        flags: Flags,
> > +    ) -> Result<NonNull<[u8]>, AllocError> {
> > +        let mut size = aligned_size(layout);
> > +
> > +        let dst = if size == 0 {
> > +            // SAFETY: `src` is guaranteed to be previously allocated with this `Allocator` or NULL.
> > +            unsafe { bindings::vfree(src.cast()) };
> > +            NonNull::dangling()
> > +        } else if size <= old_size {
> > +            size = old_size;
> > +            NonNull::new(src).ok_or(AllocError)?
> > +        } else {
> > +            // SAFETY: `src` is guaranteed to point to valid memory with a size of at least
> > +            // `old_size`, which was previously allocated with this `Allocator` or NULL.
> > +            let dst = unsafe { bindings::__vmalloc_noprof(size as u64, flags.0) };
> > +
> > +            // Validate that we actually allocated the requested memory.
> > +            let dst = NonNull::new(dst.cast()).ok_or(AllocError)?;
> > +
> > +            if !src.is_null() {
> > +                // SAFETY: `src` is guaranteed to point to valid memory with a size of at least
> > +                // `old_size`; `dst` is guaranteed to point to valid memory with a size of at least
> > +                // `size`.
> > +                unsafe {
> > +                    core::ptr::copy_nonoverlapping(
> > +                        src,
> > +                        dst.as_ptr(),
> > +                        core::cmp::min(old_size, size),
> > +                    )
> > +                };
> > +
> > +                // SAFETY: `src` is guaranteed to be previously allocated with this `Allocator` or
> > +                // NULL.
> > +                unsafe { bindings::vfree(src.cast()) }
> > +            }
> > +
> > +            dst
> > +        };
> 
> If we had not a single realloc, but shrink/grow/free/alloc, then we
> would not need these checks here, I personally would prefer that, what
> do you guys think? 

Yeah, but look at `Kmalloc`, you'd have these checks in `Kmalloc`'s shrink/grow
functions instead, since `krealloc()` already behaves this way.

Personally, I don't see much value in `shrink` and `grow`. I think
implementations end up calling into some `realloc` with either `new < old` or
`new > old` anyway.

> 
> ---
> Cheers,
> Benno
> 
> > +
> > +        Ok(NonNull::slice_from_raw_parts(dst, size))
> > +    }
> > +}
> > +
> >  #[global_allocator]
> >  static ALLOCATOR: Kmalloc = Kmalloc;
> > 
> > diff --git a/rust/kernel/alloc/allocator_test.rs b/rust/kernel/alloc/allocator_test.rs
> > index 3a0abe65491d..b2d7db492ba6 100644
> > --- a/rust/kernel/alloc/allocator_test.rs
> > +++ b/rust/kernel/alloc/allocator_test.rs
> > @@ -7,6 +7,7 @@
> >  use core::ptr::NonNull;
> > 
> >  pub struct Kmalloc;
> > +pub type Vmalloc = Kmalloc;
> > 
> >  unsafe impl Allocator for Kmalloc {
> >      unsafe fn realloc(
> > --
> > 2.45.2
> > 
> 


