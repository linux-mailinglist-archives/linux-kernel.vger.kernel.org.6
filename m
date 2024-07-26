Return-Path: <linux-kernel+bounces-262999-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F34CA93CFAA
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 10:33:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7B5A7B22EDF
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 08:33:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF7B8176FA4;
	Fri, 26 Jul 2024 08:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XgiWkVZz"
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94688174EFC
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 08:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721982802; cv=none; b=LZPKr84rC0eTaFGG68wWYKfQBofeUBIneBmk7ATTIrjSbnFMVmwlJvJapnEPDtYeAXGmOVaWMVJHgbf66Mkpt3wRVDstZ4ZBs3PjY3B7weg8sX/KXKkqd4oH6oYNnIxay/K7s3UzlpepJB+fbJ/qiT3XQYk6cxE0pRwvq+HyA4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721982802; c=relaxed/simple;
	bh=53dobYdS8KsOkCAu1bJA2jLn0K2p08hQ1qDqFmij3yU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=khYUp++GmFhGDiT8n2xrDqvyeDX5hxMho/tAlnYL7ldzSghhV5zw5yB3AG1up/dgA5FVara9sXyCwmP7XPeM/znvheMf2fZrK3+bQ/z8ofd38CfZVA7qNriwbPnLzc7hEUGgLRehguY1Kdx5JSqR5XgucGztvIhVXZjaF3XZEQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XgiWkVZz; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3684407b2deso1015813f8f.1
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 01:33:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721982799; x=1722587599; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZPm6XuNojaNQsg895r0c95JIGCSRRVDaD7kzsK35kfQ=;
        b=XgiWkVZzJCbCGpnV0tJYUqXJhYtuWN9MH3fDwkFEOcaKr8R2Qi4SVrDsfwtPL3fsLh
         XquLLfoZLGy5CZIsgfBklUpAfsuJSbPLhM6fXaAhquwtjZz3TKHxKLMw+qg3rNnYVxVf
         qP2dKqJkcDWhit6Xe8rIZk80vO2R/SoSgSDvtUilRDByhbgzWeX4+4AOiTj3JNDdJbeH
         FoHgLAt931vsYPNXOMNrQe2zoJZnY9luqXcT3vpbcBsRsPsy6/JY4pEuARv1y4eSS48c
         ioFuQJF/5BHDr4F+k6S6S0vcvNkHxM5p+vswb4z/dHNOan0ZzqIwMPzbm0DJpoYgumzM
         GxIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721982799; x=1722587599;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZPm6XuNojaNQsg895r0c95JIGCSRRVDaD7kzsK35kfQ=;
        b=jQRz63+0EmDwx1ns646LxhCO7J1s5yNYe7MkAFX+xok/rszI46K6Hmc8jm0dbYWf6G
         xbYv3rq4sPrwAQNCwLlF7/YLYKcJywTbcFKkcSDbV4OWR09mcb4BUwO/1FRedEIiv6t6
         2PdV6Jm7XIA6hu+D3bOFW37/+Cs4a3yOMbZhmhEKGufq/vkSR2vfb+3I1RoteEt+wGla
         n+K7FBu/nPrgY4rTxSPRlUKVE/7ZYmNPd0gnVDOhCf3X0o18UiBapQI71Uld7yuBej+A
         FTwWlWNlvOzGn78jy9XyCNvVAf9uIdtlHNTdoT/zIfGnhbmIAK4+Ug+P+WgSB+YBTYCF
         Ewgg==
X-Forwarded-Encrypted: i=1; AJvYcCWXI0O3H1nYxps0bPSgAeI+SjijN1jtspMPtZ6gsWIPPgROylHInYKcAoo9WMAnjeclHf2jHsMF3+IP8cRkeetzIUSykAKShELhKlxi
X-Gm-Message-State: AOJu0YxY7gV6fNSE8/Cm24/WnRatkO0pMDyyDATpW+fB1TToBRZMaWm1
	4exJSKqcOdlC//iRiC5Ezg/WITelQAusf+8xj4GvoSHggXXCQH6GLWTPtShJRaHpuC329XqsvXU
	RGyRHscUD6E4oEOfCZqS4Tqf5yH1B4uWxMivG
X-Google-Smtp-Source: AGHT+IHTIH/nyBhut1YQtRo1s+bLXpii9cddBs1xSdQMkjOgadw6CJk7RbpXB2YjAbyC6yBIdcie/3lWxMaNWQgPTKM=
X-Received: by 2002:a05:6000:4011:b0:367:9801:9c5b with SMTP id
 ffacd0b85a97d-36b36421c28mr4227035f8f.50.1721982798738; Fri, 26 Jul 2024
 01:33:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240723-vma-v1-1-32ad5a0118ee@google.com> <3bf6bfdc-84af-442a-acec-a58f023d1164@proton.me>
 <CAH5fLggDDXmD8Nj-r0_bbEfquuKfOeH7bJkcA4GA=kKk8=gi7w@mail.gmail.com> <324d3628-a537-431f-8dd4-f33184600537@proton.me>
In-Reply-To: <324d3628-a537-431f-8dd4-f33184600537@proton.me>
From: Alice Ryhl <aliceryhl@google.com>
Date: Fri, 26 Jul 2024 10:33:05 +0200
Message-ID: <CAH5fLgg0wh2D5e9Qt6Jg7Cy1-2m2gR0-uDRL5ufoN1HYGNxutw@mail.gmail.com>
Subject: Re: [PATCH] rust: mm: add abstractions for mm_struct and vm_area_struct
To: Benno Lossin <benno.lossin@proton.me>
Cc: Miguel Ojeda <ojeda@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Andreas Hindborg <a.hindborg@samsung.com>, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	rust-for-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 26, 2024 at 10:26=E2=80=AFAM Benno Lossin <benno.lossin@proton.=
me> wrote:
>
> On 26.07.24 10:14, Alice Ryhl wrote:
> > On Fri, Jul 26, 2024 at 10:11=E2=80=AFAM Benno Lossin <benno.lossin@pro=
ton.me> wrote:
> >>
> >> On 23.07.24 16:32, Alice Ryhl wrote:
> >>> +pub struct MmGet {
> >>> +    mm: NonNull<bindings::mm_struct>,
> >>> +}
> >>> +
> >>> +impl MmGet {
> >>> +    /// Lock the mmap read lock.
> >>> +    #[inline]
> >>> +    pub fn mmap_write_lock(&self) -> MmapWriteLock<'_> {
> >>> +        // SAFETY: The pointer is valid since we hold a refcount.
> >>> +        unsafe { bindings::mmap_write_lock(self.mm.as_ptr()) };
> >>> +
> >>> +        // INVARIANT: We just acquired the write lock, so we can tra=
nsfer to this guard.
> >>> +        //
> >>> +        // The signature of this function ensures that the `MmapWrit=
eLock` will not outlive this
> >>> +        // `mmget` refcount.
> >>> +        MmapWriteLock {
> >>> +            mm: self.mm,
> >>> +            _lifetime: PhantomData,
> >>> +        }
> >>> +    }
> >>> +
> >>> +    /// When dropping this refcount, use `mmput_async` instead of `m=
mput`.
> >>
> >> I don't get this comment.
> >
> > The C side provides two ways to decrement the mmget refcount. One is
> > mmput and the other is mmput_async. The difference is that when the
> > refcount hits zero, mmput_async cleans up the mm_struct on the
> > workqueue, whereas mmput cleans it up immediately. This means that
> > mmput_async is safe in atomic context, but mmput is not.
>
> I see, IMO this would be a better comment:
>
> /// Converts to this `MmGet` to `MmGetAsync`.
> ///
> /// `MmGetAsync` uses `mmput_async` instead of `mmput` for decrementing
> /// the refcount.
>
> Since from a Rust perspective, this is just a conversion function. Maybe
> the name should also reflect that ie `to_mm_get_async` or similar.

That sounds good to me.

Alice

