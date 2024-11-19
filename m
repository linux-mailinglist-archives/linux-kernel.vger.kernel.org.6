Return-Path: <linux-kernel+bounces-414256-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CD149D2554
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 13:11:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 989DEB2515E
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 12:11:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F0A61CC158;
	Tue, 19 Nov 2024 12:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NSLHu+wS"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 147E61CBEAB
	for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2024 12:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732018281; cv=none; b=l3/doyePA+lQ9QsS5A9hT2jpItnZD8kto6FrKo0O9yqOyLgWB1aELHvta6YoHJJHRssmbiAXNUlq8C3jKbTcESxjEL2ucJQqQEFn1gZjOX+r1GkztsT3xNvs48BXqQmWhGUDRTZ2M2c50DC0s8A80Kw7EdA4GvDYzoEAJcUBvBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732018281; c=relaxed/simple;
	bh=0Xf6K87/xbZFVtaZ88oBaMgrdASIyF8b9s7Cq5ipu+8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=O+Fmvu7S1Hu0QTs46x0nN2hh2202Yv3V2T0R3Hz9HJIRK5bwqaqybmYc+1hDElpolsBKl6a7bG7NNJfXj+bPlNjCh0i7MRZpyED+yeax6Lf2PcGxAFjVH/EaxAqoPphwhpSGEQCKjbeUHa4P8IOua13sF1FMzxdUw59XdsryYJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NSLHu+wS; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-43167ff0f91so37776395e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2024 04:11:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1732018278; x=1732623078; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R0AK29HVbXNe+v5FqEWeSVJhzv0SqiMS3JRu+eQ7aaQ=;
        b=NSLHu+wS5QVdWYyPMe5Yir/cNzOdR/bK6OXPR6g9zZ/Jjjmma4a+Ce+5DPUTuCiV2Q
         0xGcErLB3nqohgfgtvhJ9RTfASGz3Ev2MXvD2iC9Yh4mE3O7NAGDHGCrE84VnwC4GpQE
         lpSmajN/t1Fr9ScrpsElmjWBzzaYsvvoGzdecll0kSx39+j6E3v/zJV5jKwIKOPqzdWg
         KgiMyoKufmA3IpApGZs3+nRRpOMCKF3GGB7yp03ZVcGc2iF75LXAPsaQtCrxoXAMv3XU
         4GSquTMR39j8wcOfehEHwhg29b3d59N2AmSRoGFqGUZEScJF/dy2jd3gLoYTxohDYRQH
         g5SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732018278; x=1732623078;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R0AK29HVbXNe+v5FqEWeSVJhzv0SqiMS3JRu+eQ7aaQ=;
        b=mUIKzWXm0yNeZYkwgYtdV/O6sUy13A/QIOx4mMlDB+yCUFUBEjSrnK/AwynnbGSS4o
         Hnv4Up5QZO+GU+X4+rk/PESow43zD4Cn7cFuJ57OsfLEm7P6/E47b4Q0hEUtBeIsM6S4
         pVNl01Pd7z6p9LJvSmC3R6dtTLV3iqOQ03OvRCtnKaHZiDaqfZtWfYNaf6HR+Rtjn3Ad
         ykRC+jhH5UUm+4KkBy2qB9qYZzR3NggWc2NgvnsYJdvbIN2/HFjLRI7QtjLTvp2CUH8z
         UGYaYkZbSVXMGfnRRN2jmjD3u+9ZMTvD1T3aNw4vjSRwvTZdUcw/pX+houKNTg3sr13K
         a/AA==
X-Forwarded-Encrypted: i=1; AJvYcCXcIV1BwsOgbh7w+iUmG9LYb23HTvXCk0b4/04ZgdtsK7c/reV4drk1WhiHJoXR5owZqhBCC57j3g5yk3k=@vger.kernel.org
X-Gm-Message-State: AOJu0YzpZaEI4PFD4Co5ZVT5cJst6u8KFwUBINpu3oF/Z8R9UZks90/i
	01SCpgBeKE9LTQOat2BNJAGS2vlbhIdn1ouKMUL43CdhIFdovg2YfpG6oLaOiMbLQX446ZErS7S
	EK8PheeFlkByaxUEEnS33qj2mTLCOVunw8Klv
X-Google-Smtp-Source: AGHT+IEKtsIARus6mKK5ASfADNSrf5QYJBJdJ237SnQ9mMhtg4z8AnizImg/prdEA84rjf2Tjy9SdSfo+610sNb9LY4=
X-Received: by 2002:a5d:584b:0:b0:371:8eb3:603a with SMTP id
 ffacd0b85a97d-38225a0e1dfmr13371820f8f.27.1732018278176; Tue, 19 Nov 2024
 04:11:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241119112408.779243-1-abdiel.janulgue@gmail.com>
 <20241119112408.779243-2-abdiel.janulgue@gmail.com> <CAH5fLgj_BW22yopAdOLpSQaK97eeUAQb4jfn=KgOqNgCJ4CsqQ@mail.gmail.com>
 <3c546153-5677-41e6-9bbe-dbf64de751da@gmail.com>
In-Reply-To: <3c546153-5677-41e6-9bbe-dbf64de751da@gmail.com>
From: Alice Ryhl <aliceryhl@google.com>
Date: Tue, 19 Nov 2024 13:11:06 +0100
Message-ID: <CAH5fLgig7e9o31Osdupo=-6tSV8FJ5fC=Hot1cJWGahAV9FJdw@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] rust: page: use the page's reference count to
 decide when to free the allocation
To: Abdiel Janulgue <abdiel.janulgue@gmail.com>
Cc: rust-for-linux@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, 
	Wedson Almeida Filho <wedsonaf@gmail.com>, Valentin Obst <kernel@valentinobst.de>, 
	open list <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	"open list:MEMORY MANAGEMENT" <linux-mm@kvack.org>, airlied@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 19, 2024 at 1:06=E2=80=AFPM Abdiel Janulgue
<abdiel.janulgue@gmail.com> wrote:
>
>
> On 19/11/2024 13:45, Alice Ryhl wrote:
> >> +    pub fn alloc_page(flags: Flags) -> Result<ARef<Self>, AllocError>=
 {
> >>           // SAFETY: Depending on the value of `gfp_flags`, this call =
may sleep. Other than that, it
> >>           // is always safe to call this method.
> >>           let page =3D unsafe { bindings::alloc_pages(flags.as_raw(), =
0) };
> >> -        let page =3D NonNull::new(page).ok_or(AllocError)?;
> >> -        // INVARIANT: We just successfully allocated a page, so we no=
w have ownership of the newly
> >> -        // allocated page. We transfer that ownership to the new `Pag=
e` object.
> >> -        Ok(Self { page })
> >> +        if page.is_null() {
> >> +            return Err(AllocError);
> >> +        }
> >> +        // CAST: Self` is a `repr(transparent)` wrapper around `bindi=
ngs::page`.
> >> +        let ptr =3D page.cast::<Self>();
> >> +        // INVARIANT: We just successfully allocated a page, ptr poin=
ts to the new `Page` object.
> >> +        // SAFETY: According to invariant above ptr is valid.
> >> +        Ok(unsafe { ARef::from_raw(NonNull::new_unchecked(ptr)) })
> >
> > Why did you change the null check? You should be able to avoid
> > changing anything but the last line.
>
> Changing only the line, it complains:
>
> 86  |         Ok(unsafe { ARef::from_raw(page) })
>      |                     -------------- ^^^^ expected `NonNull<Page>`,
> found `NonNull<page>`
>
> Unless this is what you mean?
>
>          let page =3D unsafe { bindings::alloc_pages(flags.as_raw(), 0) }=
;
>          let page =3D page.cast::<Self>();
>          let page =3D NonNull::new(page).ok_or(AllocError)?;
>          Ok(unsafe { ARef::from_raw(page) })

You can put the cast here:

let page =3D unsafe { bindings::alloc_pages(flags.as_raw(), 0) };
let page =3D NonNull::new(page).ok_or(AllocError)?;
Ok(unsafe { ARef::from_raw(page.cast()) })

> But what if alloc_pages returns null in the place? Would that be a valid
> cast still?

The cast is correct both before and after the null check. The above
code returns Err(AllocError) when the pointer is null.

Alice

