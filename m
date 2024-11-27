Return-Path: <linux-kernel+bounces-423932-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0976E9DAE6B
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 21:18:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 69823B21C0A
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 20:18:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0D2C202F8F;
	Wed, 27 Nov 2024 20:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AMeMUaKt"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 724322CCC0
	for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 20:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732738695; cv=none; b=jhvrh0TeKthKsopcu4iGA3Ltzh4guf4Gf3huscVgZjGTrcjhXuqH8XyaYtyrOv9n8denq6XHXL4T0nhK0+Ck6iqCdrgTWEhfNfATsMRQ3/OBJSeMal6ug8eEd4UofehchjqFWemJa05egKrS7ruH2/pjdPRvhWOE3OWJJgCNcbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732738695; c=relaxed/simple;
	bh=iWtkanQFn3k+fKIRSNxoYkPRygqwiMfMeBcnm452Abs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BmgbGAqLLaBO7iRQEZ67vTewk8++hSFFqvoeOwg8Q95QdkFuJxLMTfrbDsNm3I31VqNs8mB4wnY4Dx/Sjmk/sXmMl88wj2NfF3qR1k0J7M66V1w6M0koC4Z4Ie5yha1RavbS0FCV7euBlzneSGstrZyPC/2E+GjVRmTGi46cifA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AMeMUaKt; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4349f160d62so455705e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 12:18:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1732738692; x=1733343492; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iWtkanQFn3k+fKIRSNxoYkPRygqwiMfMeBcnm452Abs=;
        b=AMeMUaKt3QsFa39ogSqPp6Oc/AcKYoNViXooYROSzFWcpO3jP0tDrttOBTWsF1mwoL
         TafuVeB0jy5ft1IZGIzIIggtse63RoOvBghFUWbxovjrHtxjBPGfcCbtwIVwIMXXYe30
         JjHPbzy9XZ8AuLhAJYlHDk6TLigBah85mhZt9rZbdPmd9Ok768zGEIdsrIfiHp+fAhgt
         Ue9QFDIUzSf3i7r62QDyYPn4xMEImCeKazkjm1gkPck/RqZQBh+AKFUz2mJ1sFF9EDXl
         rBTKdh1MJlyNFG70t1fX03dAehZPJuG+hWWVipCPlrpgaLT+n26QaF/5Se1S1X23p21Q
         Igww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732738692; x=1733343492;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iWtkanQFn3k+fKIRSNxoYkPRygqwiMfMeBcnm452Abs=;
        b=o5IRZlYRGrJGXoH9e0hlRt3r5RtDdValPawAhIvyJsGZTNdUVOW4PCXndm1vL5GBfn
         vx9fgXZItbP5FRu86ZQC8jSdKlIZ/GO2oucfhe1NmOItHaDg/mg5CVooknlODEA0bSNE
         094kC4f81xv/nRl06X++pFN+WdcSCV8ISiTCP4exSwArBtwLbLZY3Pgf1vIYboNbN9la
         iBAZtBsQL5w5G8tv55Bps0KCgWFACMQ+Dlqwwf6hGVnb5gIj5klmFkNqLvsRwSq/hy0a
         B7E8ajAp3CQcMiOWtu+62bb56oxYjJShUc+B5bHJ21RMcOa/TZnkk6KvHJHYCbHeN5VV
         ZaKQ==
X-Forwarded-Encrypted: i=1; AJvYcCXMYb8Q3oPalHPAZO1crmy+3WftQUfCc29vx1bEBlwB0LFl32XRR3Ds8mN1f3UwnWx1H2saZCL36RvrFzs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+rQxcufkQgMIu1O75iENm6RFqoppvqPMvmv5NDT2WrAotPOlA
	qF/hX7jRbqUryUnwP4q/4sfc2ei13xHP5Ajt8yBgniiIZayywIwmsRXsP0jC+0wubGMeDFHx8gi
	ejPxp1b0+qA+mBYJdHZGvelslyW4AQpqVER5b
X-Gm-Gg: ASbGncvnU1Y1+rwYI2UuG/Jxf7WDscBuhhNwRi4y454/c0s6/ZEYEQOtGnZXn/tu4KU
	aL4WaYIrjsT+ilvfveQwjBYAFDf+wlqIR
X-Google-Smtp-Source: AGHT+IGD3V+zmlg4ABEyFcJfFxdiSI3Xa9A1GIeQcefTQjzHie72TsmbhflHR68CenkvJh+FNnmRJuABJwSXf+d4wUs=
X-Received: by 2002:a05:600c:45c9:b0:434:a196:6377 with SMTP id
 5b1f17b1804b1-434a9dbed9bmr45626625e9.14.1732738691743; Wed, 27 Nov 2024
 12:18:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241126-pr_once_macros-v4-0-410b8ca9643e@tuta.io>
 <20241126-pr_once_macros-v4-1-410b8ca9643e@tuta.io> <CAH5fLgj30AmuobugAgzG9vOhSOrk5SqWwguOoNeh3J2fmLRHCA@mail.gmail.com>
 <OCjFF0---F-9@tuta.io>
In-Reply-To: <OCjFF0---F-9@tuta.io>
From: Alice Ryhl <aliceryhl@google.com>
Date: Wed, 27 Nov 2024 21:18:00 +0100
Message-ID: <CAH5fLgj2qHjYj=heYi55qWz7=LxyHeUPyhbgVe0QLjzH0S34bw@mail.gmail.com>
Subject: Re: [PATCH v4 1/3] rust: Add `OnceLite` for executing code once
To: jens.korinth@tuta.io
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, Rust For Linux <rust-for-linux@vger.kernel.org>, 
	FUJITA Tomonori <fujita.tomonori@gmail.com>, Dirk Behme <dirk.behme@gmail.com>, 
	Linux Kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 27, 2024 at 9:12=E2=80=AFPM <jens.korinth@tuta.io> wrote:
>
> > What is the use-case for this function?
>
> `DO_ONCE_LITE` has very few uses in C; frankly, the only other use I coul=
d think
> of was initialization. But since `OnceLite` cannot block or guarantee vis=
ibility
> of the side-effects of the `call_once` expression in other threads, it ca=
n't be
> used for this case, either. _Unless_ there is some mechanism to wait
> voluntarily when this is required, hence `is_completed`. (And it also exi=
sts in
> `std::sync::Once`.)
>
> `DO_ONCE_LITE_IF` has more uses in C, but this is a bit harder to do well=
 with
> `OnceLite`: A `do_once_lite_if` Rust macro can't short-circuit the condit=
ion to
> avoid the evaluation if the atomic load already shows that it has been do=
ne / is
> being done rn. Maybe a
> `pub fn call_once<C: FnOnce() -> bool, F: FnOnce()>(cond: C, f: F)` could=
 be
> used to simulate the effect. Thoughts?
>
> > Why not just have one atomic?
>
> Do you also have an `AtomicU32` state var in mind, as Daniel suggested?

What I had in mind was to use a single AtomicBool and get rid of the
`is_completed` logic entirely. The purpose is to use this for printing
once, and printing doesn't need `is_completed`. We can have another
helper for other purposes.

Alice

