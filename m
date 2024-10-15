Return-Path: <linux-kernel+bounces-365881-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D039199ED3D
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 15:26:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8590F1F24DD9
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 13:26:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DAAF2281CC;
	Tue, 15 Oct 2024 13:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TS261FeU"
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 012F920B1EA
	for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 13:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728998504; cv=none; b=ADBPQUgakE+B3eovk69M2kAGpPQKISpNFmkm+oUKn32pLaDdEpoy8ETLmEoe79s1936D1xLREpstRv30EK8qBwxkKbLQct+sPWMrSxemUb4BiYnk6ThEJj6u8nEEI2C1rLSMovw9epQRImwV1pACQbbBi1L0/JanVRC8gVql8sk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728998504; c=relaxed/simple;
	bh=K8j37Y3NeHTSMT2XD/Vi8P46SlNMypsxn4DSZpg+r0Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WWlVagGlfGkxraNh4jfHFk2cbPLVw0xyAwqMbhVLdDFjv91i+oCjSy+iSPLbxDdB2vuVseKDG6/gvgpMhMgRwfcBVeUVCAHTyxcTLGmJ7XOsfqXfKZDQmvSKf9Puer/e7n8uW3XjKtx5jVftkCEV+wHQ4q/CbSLXqBAgf6Ofyq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TS261FeU; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-37d70df0b1aso1837620f8f.3
        for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 06:21:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728998501; x=1729603301; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9n0q1KEeo2CPHzRQUjPiqBunABt8CrDdywKyGxq8L14=;
        b=TS261FeUN1VG7pSP7BIYVxSVv6Y4ErA51QUPWqMIc01UO8R21kaGhBPw/3lApd/GFj
         kM6atMmZO/yXVX3tGk1rCR/Jc6leJ/2xhEziRIZTVV0czsAG+IOToJCbKredoSpft6Yl
         rN5KtXV7xiMytKLfU0xcz4tIIUI+rr3i0xGiw42dgwFPQtpmWX5RM47+BZJGuII/Tco/
         W6vt664WA4YXhDBlP/Ewq+EMhJ7+Zw/iu8ZB5Gp01/qhIo44JUo63qSTOpzrI8nS2h06
         zmh0iwXzcqh+c8Y+6JVO+MNTtdN0MvalYgnDJY6fOLp2VRAz4Pr3IFgMk4TT03TnZVD+
         Bsbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728998501; x=1729603301;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9n0q1KEeo2CPHzRQUjPiqBunABt8CrDdywKyGxq8L14=;
        b=lmViGJ4UGyrg6uwME9/je0rXltrs4CIW8uMQuycbb9rzta2peT7b5IFgC/p+7SW4a0
         nlykYvkrfAbigmnyE6ZFXammmcjNlW9yWcMIn50H87WvKafH/DP9hOIB+HIB9K6Tukdv
         wNLFsuEes8cTSMBHjjbRi6x4hykjhrR6u7pM1I5ifMkKuT0/fE3Sn9Tyaoh0r36rL4lF
         oVUZu3PpQwU18WKCp5dj1cbzDpQW3YvHnV4e6kaZYhoKE9ENmaU5p+2Q7UAFmDWvTsDg
         rVTKf/y1nvpIKO5GdK54gDmsuY4IYP7Xbh0cv7w2Ix/c3i2lNw7ksO1Q5lvr67WNWY53
         eSgw==
X-Forwarded-Encrypted: i=1; AJvYcCVcoCg82BTtUWqAQBe13uqHpFh1c5fY6WIqwgI548ayfBLN/jpEphm5Nij+kiu7sPoqHiuQVimqXLVtazA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLDOJxLE/0uVULhQQdCBJMpzxHRKXgiO6Oi+CapuNLeGsXl9Jx
	w3Fkm81fGrWuTqvu3t8lCKkbcR1zBED3ZRr8vw9HFsdmob0oZsahYwewZwStkRWG/a2O4g/5RUJ
	6yJKPhINRqxNcidaEfTkdAWPaBmxcUn/b19YM
X-Google-Smtp-Source: AGHT+IEs4y1lsgZZyZeKndW8H2aOP/taIrYhkxqpBCO265rUvdXSxly/PKF+yBNK4FxQzvpl5te02bSQ+3Szz/EodnM=
X-Received: by 2002:adf:eace:0:b0:37d:5084:b667 with SMTP id
 ffacd0b85a97d-37d86c040b5mr178619f8f.33.1728998501000; Tue, 15 Oct 2024
 06:21:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241007202752.3096472-1-abdiel.janulgue@gmail.com>
 <20241007202752.3096472-2-abdiel.janulgue@gmail.com> <065A20A8-EB66-4350-965C-2456841D03A1@kloenk.dev>
In-Reply-To: <065A20A8-EB66-4350-965C-2456841D03A1@kloenk.dev>
From: Alice Ryhl <aliceryhl@google.com>
Date: Tue, 15 Oct 2024 15:21:29 +0200
Message-ID: <CAH5fLgiSt3Lc5+Rmcfg7frsy2y4o9yuj6LLqp6j0oNrzHRZGGA@mail.gmail.com>
Subject: Re: [PATCH 1/3] rust: page: replace the page pointer wrapper with Opaque
To: Fiona Behrens <me@kloenk.dev>
Cc: Abdiel Janulgue <abdiel.janulgue@gmail.com>, rust-for-linux@vger.kernel.org, 
	dakr@redhat.com, linux-kernel@vger.kernel.org, lyude@redhat.com, 
	airlied@redhat.com, miguel.ojeda.sandonis@gmail.com, boqun.feng@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 11, 2024 at 1:07=E2=80=AFPM Fiona Behrens <me@kloenk.dev> wrote=
:
>
>
>
> On 7 Oct 2024, at 22:27, Abdiel Janulgue wrote:
>
> > Replace NonNull with Opaque to make it possible to cast to a Page point=
er
> > from a raw struct page pointer.
> >
> > Signed-off-by: Abdiel Janulgue <abdiel.janulgue@gmail.com>
> > ---
> >  rust/kernel/page.rs | 19 +++++++++++++------
> >  1 file changed, 13 insertions(+), 6 deletions(-)
> >
> > diff --git a/rust/kernel/page.rs b/rust/kernel/page.rs
> > index 208a006d587c..08ff09a25223 100644
> > --- a/rust/kernel/page.rs
> > +++ b/rust/kernel/page.rs
> > @@ -8,8 +8,9 @@
> >      error::code::*,
> >      error::Result,
> >      uaccess::UserSliceReader,
> > +    types::Opaque,
> >  };
> > -use core::ptr::{self, NonNull};
> > +use core::ptr::{self};
> >
> >  /// A bitwise shift for the page size.
> >  pub const PAGE_SHIFT: usize =3D bindings::PAGE_SHIFT as usize;
> > @@ -25,8 +26,9 @@
> >  /// # Invariants
> >  ///
> >  /// The pointer is valid, and has ownership over the page.
> > +#[repr(transparent)]
> >  pub struct Page {
> > -    page: NonNull<bindings::page>,
> > +    page: Opaque<bindings::page>,
>
> Still not to sure where to encode pinning in the type api. Looking into t=
he C struct I see a union that sometimes holds a list head, should this the=
n be a pinned thing in this type?

As long as you only hand out immutable references to it, nothing
further is necessary.

Alice

