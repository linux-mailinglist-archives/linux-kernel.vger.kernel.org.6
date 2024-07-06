Return-Path: <linux-kernel+bounces-243308-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C76D8929462
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jul 2024 17:16:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 412631F22B94
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jul 2024 15:16:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56C4C1386D1;
	Sat,  6 Jul 2024 15:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FvOZ78AU"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D442A23BE
	for <linux-kernel@vger.kernel.org>; Sat,  6 Jul 2024 15:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720279003; cv=none; b=DOCIinuCpWmfrR99wshflO2KoYxXUbIdckXRVccFEa2OscslLadHpnKWhlTYWI6o0ZvwGLrZDmWc/mULxSXdd8MVOCdt+jQeIlCNJc2QuodO4yT760BWdBg9D/vg+2leMrzfBDMOYplkiumfbHJeCYbcubQPKDvjBSMub4VN6Fw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720279003; c=relaxed/simple;
	bh=V8xKziIWvw+z7yiIc3EtT3gOTGIXEMHhjqqvEppRrXc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kU2EbC1JmyXFrnm5dw03fPqUfscBIDO/LZD1qJtJ9FNeiwklCTLdYPUwOfneDSJvlcklkZI6BxDkomhvMm9/qr5SoZ0KCxIzerEDjO5t6Ensb9KPH+9/oUZCaoo2JWghwOgFmZ4frAltlaJKFr8WSdh9xPfJlV4kbKlkDpAK1G0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FvOZ78AU; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720278999;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=R7m3OsbObA3XsltJe97nQ6y2kpIXDhS9/pjgnJGh+oo=;
	b=FvOZ78AU7cBujBtxi662MkXDPOzpxZmXJ4RztlDfB+n0r80FfEziZuJRkgvzYEZ+SEMTVs
	D7pe97F+tRPeGQ2W4C0Wy1+XkOpBr66bw5BxhR0lU9qszD4To00qsg4nXX2iRUiSa8li1t
	ZGh/rIozml+TIT3Xm9E77aQyL3QuPRk=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-576-DnltJrObOteUsqVWAgHVPw-1; Sat, 06 Jul 2024 11:16:38 -0400
X-MC-Unique: DnltJrObOteUsqVWAgHVPw-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3679ed08797so1724882f8f.0
        for <linux-kernel@vger.kernel.org>; Sat, 06 Jul 2024 08:16:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720278997; x=1720883797;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R7m3OsbObA3XsltJe97nQ6y2kpIXDhS9/pjgnJGh+oo=;
        b=NIetPVIsh/3rHZBfl6IazR4pj0MbBGTL31cxV+TTamtrZZr+hFW15g54Yew+uBVLcO
         WPNfIa1575klMJLc/CNX1nQngmoM6y2I3qAUCRg2DgY7QzMahpVhyaUw1KEIusq1EkMJ
         XFyZXDTxB40YoMZ1HsvPW3CIToPqRjEDONQYYAPtU3v0NOWyFp25GepTaKxOKcGoW5Hn
         /m11ovhTc0/T0UCE8OES/g+63LQ43MsNGR6wKuNyodveajWAm7vigoxgzYviFn3Tcdi6
         u9rVoQNyN6WOth6X9BS5CThbYhOr5A7ea32zDBu+1EXUQNgjjU/SIcvD8T8+6MXtPGiQ
         7hSg==
X-Forwarded-Encrypted: i=1; AJvYcCUzNQvSIZ7hyoojzF5u7cVT60B71c+2mfepDyKU8p6BewIB6CrsEgb0VB6y/lPKj9KR/4UjpMLuh5h/8dYhygb+m6neBusjlpTkppqd
X-Gm-Message-State: AOJu0YyTXXY3kmu7YrZDgK+tSRF6KPLYpZthM+tt6i2FI7UBFy8HFk0o
	auz2KLsA+qggo/6kEJNBmEoSVMeBSBtvBGwJhmM+Rk0Ys5QtEKMBTKDZ6DM7n/NOnI7fNRf+dMY
	MJIo8hoqDfBHYPcuMEg9+SSCb7/EJX0uQlchVgAKLMDNTw32EgPbc1m5XBIW53w==
X-Received: by 2002:a5d:56ce:0:b0:367:83e9:b4a5 with SMTP id ffacd0b85a97d-3679dd652fcmr4832294f8f.49.1720278997260;
        Sat, 06 Jul 2024 08:16:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHafTnjFM5kZgi7HFwiFktMu0O4vCTp/tC4spHajbb7STT0WS9kIOsUlPmPs+jwkyFOOdkfyQ==
X-Received: by 2002:a5d:56ce:0:b0:367:83e9:b4a5 with SMTP id ffacd0b85a97d-3679dd652fcmr4832271f8f.49.1720278996838;
        Sat, 06 Jul 2024 08:16:36 -0700 (PDT)
Received: from pollux.localdomain ([2a02:810d:4b3f:ee94:701e:8fb8:a84f:6308])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36797e5d97bsm7901940f8f.92.2024.07.06.08.16.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Jul 2024 08:16:36 -0700 (PDT)
Date: Sat, 6 Jul 2024 17:16:35 +0200
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
Message-ID: <Zolf08nsj/rx6RXe@pollux.localdomain>
References: <20240704170738.3621-1-dakr@redhat.com>
 <20240704170738.3621-8-dakr@redhat.com>
 <596c6446-eca4-46a8-91c5-e71e92c61062@proton.me>
 <Zokm6M48WunoEohV@pollux.localdomain>
 <796b50c4-0824-4b9f-97f9-750f34096ed6@proton.me>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <796b50c4-0824-4b9f-97f9-750f34096ed6@proton.me>

On Sat, Jul 06, 2024 at 01:21:39PM +0000, Benno Lossin wrote:
> On 06.07.24 13:13, Danilo Krummrich wrote:
> > On Sat, Jul 06, 2024 at 10:41:28AM +0000, Benno Lossin wrote:
> >> On 04.07.24 19:06, Danilo Krummrich wrote:
> >>> @@ -112,6 +118,55 @@ unsafe fn alloc_zeroed(&self, layout: Layout) -> *mut u8 {
> >>>      }
> >>>  }
> >>>
> >>> +unsafe impl Allocator for Vmalloc {
> >>> +    unsafe fn realloc(
> >>> +        &self,
> >>> +        src: *mut u8,
> >>> +        old_size: usize,
> >>> +        layout: Layout,
> >>> +        flags: Flags,
> >>> +    ) -> Result<NonNull<[u8]>, AllocError> {
> >>> +        let mut size = aligned_size(layout);
> >>> +
> >>> +        let dst = if size == 0 {
> >>> +            // SAFETY: `src` is guaranteed to be previously allocated with this `Allocator` or NULL.
> >>> +            unsafe { bindings::vfree(src.cast()) };
> >>> +            NonNull::dangling()
> >>> +        } else if size <= old_size {
> >>> +            size = old_size;
> >>> +            NonNull::new(src).ok_or(AllocError)?
> >>> +        } else {
> >>> +            // SAFETY: `src` is guaranteed to point to valid memory with a size of at least
> >>> +            // `old_size`, which was previously allocated with this `Allocator` or NULL.
> >>> +            let dst = unsafe { bindings::__vmalloc_noprof(size as u64, flags.0) };
> >>> +
> >>> +            // Validate that we actually allocated the requested memory.
> >>> +            let dst = NonNull::new(dst.cast()).ok_or(AllocError)?;
> >>> +
> >>> +            if !src.is_null() {
> >>> +                // SAFETY: `src` is guaranteed to point to valid memory with a size of at least
> >>> +                // `old_size`; `dst` is guaranteed to point to valid memory with a size of at least
> >>> +                // `size`.
> >>> +                unsafe {
> >>> +                    core::ptr::copy_nonoverlapping(
> >>> +                        src,
> >>> +                        dst.as_ptr(),
> >>> +                        core::cmp::min(old_size, size),
> >>> +                    )
> >>> +                };
> >>> +
> >>> +                // SAFETY: `src` is guaranteed to be previously allocated with this `Allocator` or
> >>> +                // NULL.
> >>> +                unsafe { bindings::vfree(src.cast()) }
> >>> +            }
> >>> +
> >>> +            dst
> >>> +        };
> >>
> >> If we had not a single realloc, but shrink/grow/free/alloc, then we
> >> would not need these checks here, I personally would prefer that, what
> >> do you guys think?
> > 
> > Yeah, but look at `Kmalloc`, you'd have these checks in `Kmalloc`'s shrink/grow
> > functions instead, since `krealloc()` already behaves this way.
> 
> In the kmalloc case you would have different instantiations, no checks.
> IIUC for freeing you would do `krealloc(ptr, 0, flags)`.

We can't allow to shrink on a `grow` call and we can't allow to grow on a
`shrink` call, so we have to do the checks there before we call into krealloc().

Unless, we say that passing stupid arguments to `grow` can actually shrink and
vice versa, but then we can just keep `realloc`, right?

> 
> > Personally, I don't see much value in `shrink` and `grow`. I think
> > implementations end up calling into some `realloc` with either `new < old` or
> > `new > old` anyway.
> 
> I think a `resize` would make more sense. In general, splitting
> resizing, creating and freeing makes sense to me.

Please see the other mail thread.

> 
> ---
> Cheers,
> Benno
> 


