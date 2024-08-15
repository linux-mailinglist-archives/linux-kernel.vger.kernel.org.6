Return-Path: <linux-kernel+bounces-287615-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D907D9529F8
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 09:32:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8F0F01F23A83
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 07:32:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1B081991C2;
	Thu, 15 Aug 2024 07:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wzlfRWAu"
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C7AF17B514
	for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2024 07:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723707052; cv=none; b=ffg/OS1RKPvaIcYFkuhcPoGLMv000fEv8BniJNWoi/qcyeuWl2K8wO7oV+UrHMgsRkSVUqLqsR6XCAjRglXmyg2ZUS1YWYrXFoZ3mpBXlD8+MZ0AviuggKblll7KYSSKKwOjcoogq4e0EJpehEUyyfwyvAiZmcZC6xKibA4GN5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723707052; c=relaxed/simple;
	bh=o9Y3VAbaVpEXsRiqkrrvqdRumcVSil10QCL3W83+hg4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AKbpp7PTq++W9ngeDXOyRlgLUTgv8itScHC71crThhvibI+V5PMOunvbs38tojMB+4ZVrSJm8l+Y8VB9f88PEJAE8VuxVkKQkKnB9UqwHRvU1YUxxR+A93YK88AXSG7YyB9+B3Fxjt9Skducvr1DDc7KgXw4RBx5RGl21ZSLbTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wzlfRWAu; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3718e416297so7449f8f.2
        for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2024 00:30:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723707049; x=1724311849; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Na2qPkDz9wEnFMfwgo58FPItJ1H0k/FhreZx8u4KhIk=;
        b=wzlfRWAuo7LZARtunVzjQCXxrQdl+t/BFUyUO2rDkRaEyX0AWaeQa+KRSot0e9G23K
         BQjJnWix0dPogfVV6vhqx26LN9t+Kp+GigqnPJnAX5fg2ER9wIphTNHGKmce9BepNBTt
         5S4eaVWvNiQWOwyWVX/HlacB/h/YdgsEXXV+JSdOI4t+xmR/BC1OJQ7ZlfIxxUhZsltc
         LMudYU3Cs910PjyZTpHKzsV/uiyIINkqgZwNKUxiUvWum/8SB4UbEzr2VeCL9VlD8pL+
         pBzFSshr3tDxvYEs3EXqJ46T8xj61VcywGUjkXw2bCoJSnckTQBLFJgIeqG4jeRXgJf2
         Mzwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723707049; x=1724311849;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Na2qPkDz9wEnFMfwgo58FPItJ1H0k/FhreZx8u4KhIk=;
        b=qzb832HlxeA1ezR7Ef1afX8gZ7Tzss04ATKNtZ1kgGlqPt6lZ1A9kh3mduVUM2hS3z
         1o9KFdkfA5mhOiUxi3Tnu2CU43eBupTqG1aqIBKWDkv3x1IBFu3OqreBIfWScmMxan9T
         m+YbdpqShsTsGePh7W2md11EJNOt/wYiDoqWaA8T+91yzOdFHcWn0h0LIX6KIpfKfP5L
         cYydbv2y+jILST3PdwliBOTETh735B4Vy0o7DAkflo9T1OfwVdDqMrlcl83Fj99BwxbN
         CEKu+UPXBhVeigB+gUUjLCoQIKN5wm7l0EITiJ2FIl7KyZk1vFKiPtbKMqxhpyzC0bit
         5SjQ==
X-Forwarded-Encrypted: i=1; AJvYcCU4iga+I/waxBvX5niCePlVBE4r/z24kTNxyYCWUDnPQJU3GjiygAgm2rNU8OiIdDVlYUswr7bvtTlu+KUgVsgOx2OSNVYLa1bYT94H
X-Gm-Message-State: AOJu0Yyfl0ZeGuiGU8/Ry4Ywvw7fjtWdfG3OdgjprJPcBMDHwtOKMiDh
	CttW3CmqOoaP/Lcpqkz1EM+VNJpqGoxb27nMBhBtXnBIn4bmGRPQaLQa3SbYliSgItFl0M5yE24
	E6/20pmN1zHNuy+1O61y2ioM63Zc9ZqRSW4yd
X-Google-Smtp-Source: AGHT+IEPBTh7NnBCJo7Fv6b3olK539XPfHtZQOZ/CqlqCTfNfwkNYi+Ki3w5YESiWRyIihW6h4nZGGml3+9uEjB0rYY=
X-Received: by 2002:a05:6000:c82:b0:368:255e:ab13 with SMTP id
 ffacd0b85a97d-3717780e225mr2611278f8f.50.1723707048574; Thu, 15 Aug 2024
 00:30:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240812182355.11641-1-dakr@kernel.org> <20240812182355.11641-14-dakr@kernel.org>
 <CAH5fLggchaAzcRK=i=zRm7hTg6qX0yGBAyAHcO45rG-oEh-AMQ@mail.gmail.com> <Zr0z0fBM_acHFezv@cassiopeiae>
In-Reply-To: <Zr0z0fBM_acHFezv@cassiopeiae>
From: Alice Ryhl <aliceryhl@google.com>
Date: Thu, 15 Aug 2024 09:30:36 +0200
Message-ID: <CAH5fLgjDMuiR07jc=aa-3radEOgU8iMn-u+XttepuWr9r_doYQ@mail.gmail.com>
Subject: Re: [PATCH v5 13/26] rust: alloc: implement kernel `Vec` type
To: Danilo Krummrich <dakr@kernel.org>
Cc: ojeda@kernel.org, alex.gaynor@gmail.com, wedsonaf@gmail.com, 
	boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com, 
	benno.lossin@proton.me, a.hindborg@samsung.com, akpm@linux-foundation.org, 
	daniel.almeida@collabora.com, faith.ekstrand@collabora.com, 
	boris.brezillon@collabora.com, lina@asahilina.net, mcanal@igalia.com, 
	zhiw@nvidia.com, cjia@nvidia.com, jhubbard@nvidia.com, airlied@redhat.com, 
	ajanulgu@redhat.com, lyude@redhat.com, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 15, 2024 at 12:46=E2=80=AFAM Danilo Krummrich <dakr@kernel.org>=
 wrote:
>
> On Wed, Aug 14, 2024 at 10:42:28AM +0200, Alice Ryhl wrote:
> > > +#[macro_export]
> > > +macro_rules! kvec {
> > > +    () =3D> (
> > > +        {
> > > +            $crate::alloc::KVec::new()
> > > +        }
> > > +    );
> > > +    ($elem:expr; $n:expr) =3D> (
> > > +        {
> > > +            $crate::alloc::KVec::from_elem($elem, $n, GFP_KERNEL)
> > > +        }
> > > +    );
> > > +    ($($x:expr),+ $(,)?) =3D> (
> > > +        {
> > > +            match $crate::alloc::KBox::new([$($x),+], GFP_KERNEL) {
> > > +                Ok(b) =3D> Ok($crate::alloc::KBox::into_vec(b)),
> > > +                Err(e) =3D> Err(e),
> >
> > Hmm. This currently generates code that:
> >
> > 1. Creates the array.
> > 2. Allocates the memory.
> > 3. Moves the array into the box.
> >
> > Whereas the stdlib macro swaps step 1 and 2.
>
> Isn't stdlib [1] doing the same thing I do?
>
> [1] https://doc.rust-lang.org/1.80.1/src/alloc/macros.rs.html#49

Stdlib is using something called #[rustc_box] which has the effect I descri=
bed.

> > You can do the same by utilizing new_uninit. A sketch:
> >
> > match KBox::<[_; _]>::new_uninit(GFP_KERNEL) {
>
> How do we get the size here? `#![feature(generic_arg_infer)]` seems to be
> unstable.

It probably works if you don't specify the type at all:
`KBox::new_uninit`. But you should double check.

> >     Ok(b) =3D> Ok(KVec::from(KBox::write(b, [$($x),+]))),
> >     Err(e) =3D> Err(e),
> > }

