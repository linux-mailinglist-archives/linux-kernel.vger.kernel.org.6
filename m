Return-Path: <linux-kernel+bounces-271416-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DEEC944DEF
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 16:25:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 446341F24F01
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 14:25:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 060171A3BB0;
	Thu,  1 Aug 2024 14:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="z673j3pC"
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6DD21A38CF
	for <linux-kernel@vger.kernel.org>; Thu,  1 Aug 2024 14:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722522342; cv=none; b=J14jgjlE2NF8pYfw2Tok7Px5UVVM+AKhZPUL9wvxkfAAA9BBZ1xzfryD9RD4ivrRZ57coXmS1s/JncwTy9qGmiLqikHKMFC7CGECBfHWw0AjdOpOgkl4l9E8MKyKZCttpAfoMtY/C1VZ9Qud1PnrovU7TaLiMnhS5kuI4PiBBbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722522342; c=relaxed/simple;
	bh=xZVYm2alWS2dQPPSFg1bSgQYV8gHGRWp6WJy38yv+jo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=favix+LKaoaPdMDfn+oW5+2uuowEttx8pBMoQ8OVUyjioSiUvg4iASAx0H8VMdncprlbnQxBZy8aiUby5KJoqu87949n4oU0MK8ymXl/Ya4KllFuhf9+/SHGzdqgQPghGc1ix9cacc3W9XHWPrDl5gBFVATSU90mr1XoLVV/5pQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=z673j3pC; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-7aa7703cf08so5314104a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 01 Aug 2024 07:25:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722522340; x=1723127140; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wMXLyrNv6gAVe2xpU5/FnQfc6WbYmugR7fD/Bg6dOs0=;
        b=z673j3pCSQaybW3F2PCT9olIyRDw+IeX+gDhvgfJKkAVhHhwLyD+2rL7o5kRVKh1aN
         skGKLAMZZu5wHZab5Lw2Ip6bYSqZmrggxwxrbFGWujCZ4BMuScY8OE2zc2Kpy4Cmmsxi
         u+ULXH/RJTAFr9i3Z0fk3QHS/EtgWAahSLriLdareTSJNj4lrtBWX4W8sbos2OkI6x9e
         tqUjQTgNZ/OZ/8xIdP2gtiDff68aRLThkgVATOQaWSVTWHNt+mCLE+//OyTzck7rXwwY
         nYgtBs6V6GmQNEGVIZvfNrboG4lMMMBNpfVJGiVhfrFBy2GDTNObzgHhiR4naHBzFGPk
         mFAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722522340; x=1723127140;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wMXLyrNv6gAVe2xpU5/FnQfc6WbYmugR7fD/Bg6dOs0=;
        b=sr0QHOjZrVMgtv/R7WQMMUqMqEc780dh9oDQHFpQGgWnZN+CYQJiJ7f7cbwRjfVLgZ
         zYJz3YjRm6seRvbNjjrG77yfBw32FhAsBwgCaWb8D+6KwHYTwTz4Dmf5OQPiUIqK2+lD
         gb0hOSKcNYUWGywznwVXNg4xYpNlbDYR/XRllgOjZI5S8gL8gOkeYQm3eaXm5r8+uUU/
         VEshMwoc2d+28uZIieVGdhqHlL7FjDRttoKbzB4GdDWR32wnhkQcgegJGyi2+QZWNt8A
         51DEPxedLy1/wboQo8xTPDRhndNsjRbMq0a7ykQypY88uk7wpIHubHxRxjQgh4RdjTgg
         BQKw==
X-Forwarded-Encrypted: i=1; AJvYcCUoGGs1IpqPlIrYwcLQL7ZaY17MNwrrxoDzAG0qXCL0EbeytVkOfkP2FRui3KW/9wRsCX93Yc3FPpHX6HyGUkYCEwI2dQzY5RsG0KUp
X-Gm-Message-State: AOJu0YypltUOuMl2TnhRMddiMVCzDVmbPR7zA6kRHCQqnWU3y0sX8pIq
	8aHR2a7P0Q/Xi1OKLH7QKS8wIcI/TMs6WVC5u/fbOnOxnBfpipDLUXNtS4DfP/h68a5bUdMBzYz
	YqNFDBYebOX2Q1OA3GX+TaDczFCm5Qhcbm2g0
X-Google-Smtp-Source: AGHT+IHWwdfCXSbrbEMMYZ1PpRprRVKf1JZMNsbSZ4PVV1VmDOudXf9Ktyc7oZ26GiiZCb3/7NGUglVGUheZkdgmYcw=
X-Received: by 2002:a17:90a:f02:b0:2cd:ba3e:38a5 with SMTP id
 98e67ed59e1d1-2cff9469006mr410991a91.21.1722522339636; Thu, 01 Aug 2024
 07:25:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240801000641.1882-1-dakr@kernel.org> <20240801000641.1882-2-dakr@kernel.org>
 <CAH5fLgj5xf4QdDU7yWrqUjcmJw4Rqe0-UzesHLhfQRvPqAv8eA@mail.gmail.com> <Zqt_BuyoUk12m61Q@pollux>
In-Reply-To: <Zqt_BuyoUk12m61Q@pollux>
From: Alice Ryhl <aliceryhl@google.com>
Date: Thu, 1 Aug 2024 16:25:25 +0200
Message-ID: <CAH5fLgiSjwZetUm5WW9cjM8gTsCXPMB3byzKgvMRt-o_n24YKg@mail.gmail.com>
Subject: Re: [PATCH v3 01/25] rust: alloc: add `Allocator` trait
To: Danilo Krummrich <dakr@kernel.org>
Cc: ojeda@kernel.org, alex.gaynor@gmail.com, wedsonaf@gmail.com, 
	boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com, 
	benno.lossin@proton.me, a.hindborg@samsung.com, akpm@linux-foundation.org, 
	daniel.almeida@collabora.com, faith.ekstrand@collabora.com, 
	boris.brezillon@collabora.com, lina@asahilina.net, mcanal@igalia.com, 
	zhiw@nvidia.com, acurrid@nvidia.com, cjia@nvidia.com, jhubbard@nvidia.com, 
	airlied@redhat.com, ajanulgu@redhat.com, lyude@redhat.com, 
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 1, 2024 at 2:27=E2=80=AFPM Danilo Krummrich <dakr@kernel.org> w=
rote:
>
> On Thu, Aug 01, 2024 at 10:19:41AM +0200, Alice Ryhl wrote:
> > On Thu, Aug 1, 2024 at 2:07=E2=80=AFAM Danilo Krummrich <dakr@kernel.or=
g> wrote:
> > > +    /// Free an existing memory allocation.
> > > +    ///
> > > +    /// # Safety
> > > +    ///
> > > +    /// `ptr` must point to an existing and valid memory allocation =
created by this `Allocator`
> > > +    /// instance.
> > > +    unsafe fn free(ptr: NonNull<u8>) {
> > > +        // SAFETY: `ptr` is guaranteed to be previously allocated wi=
th this `Allocator` or NULL.
> > > +        // Calling `realloc` with a buffer size of zero, frees the b=
uffer `ptr` points to.
> > > +        let _ =3D unsafe { Self::realloc(Some(ptr), Layout::new::<()=
>(), Flags(0)) };
> > > +    }
> >
> > At the very least, the provided implementation of `free` changes the
> > alignment when it calls `realloc`.
>
> Yes, I think that's fine though. Hopefully no one attempts to use the mem=
ory
> anymore once `free` is being called.

Sure, but if you require the alignment to remain constant throughout
calls to realloc, then you have to word it in a way that allows a
different alignment when the new size is zero.

Alice

