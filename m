Return-Path: <linux-kernel+bounces-414439-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A0449D281A
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 15:26:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7365AB28B34
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 14:22:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30A111CCEC6;
	Tue, 19 Nov 2024 14:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kV/PHb/u"
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DEF12AE74;
	Tue, 19 Nov 2024 14:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732026130; cv=none; b=nDEVyGKaHOxKrwLN1ES09IanQ+hyeMkS24M3InmCK6Oe2oTDHTb1/EfoBqQT9mIoTYuQXu7mpzQJsWuZezKUNWfdBw8TwRye/3LZXemdk9XUUg7zmVltP2RiFDILvHiQYXR9Jg78zEtZYiVdD7xr0vCjt/9KxHOTRgSjQmoqSDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732026130; c=relaxed/simple;
	bh=xfFBj0p0sKkLmYeWwPxrGm4axH9yyo5MKB2aEyD/6cQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=W/U3pOwuy/deoTDasmZw83gWTJTS0O39HB35ynMi7kK8WsgwFSZNzavbxhCl9kP0LSoKeEd5cg6y0PH5XybQCDrxjC7x5FojOc0nZF7AEUp2toxpxOOe8iYCs9JcABP/t2Ova0eZjfwGbLWvwQkvvBrqgBI1+8cij+lvpB/BRkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kV/PHb/u; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2fb57f97d75so10925171fa.2;
        Tue, 19 Nov 2024 06:22:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732026127; x=1732630927; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xfFBj0p0sKkLmYeWwPxrGm4axH9yyo5MKB2aEyD/6cQ=;
        b=kV/PHb/uVbnU+2nHM/voAiMBlpNnLUk8k3EJahjffY5p5s5Ll7LbjRhqXvoCB6/I+L
         8tQgB7MtHOUCb0TZATV6LJvI3BFad+BNsoYlhuZvRM6yO7z2E0IBX7KBuxKw3LF3DdPg
         f0sffe1aZtK8C3zj+aRhKc3qZI6GH0+DSbuzsKchIadHLmBnEIriYiIUIDtODTkbztFz
         M9Lb5wUeK+CEaLt2d8N9xRP/mmjXKI37utghl4QYs7fSU9/v+GEh7jJWIYKjJZluCch8
         mMBuA4frJPY4yBn2PR+x6gLqK2RZFVjXrfskOl380Y39Ic9mXFlCX5SKW9Eg5ZoNUwpH
         PCGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732026127; x=1732630927;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xfFBj0p0sKkLmYeWwPxrGm4axH9yyo5MKB2aEyD/6cQ=;
        b=kyLXqBzfQt2UXY3yYhh6o+mw7RppgmGlKoMIddYYt71eyDsgUWY4CqLqRWrDRvPrcy
         RlIhQi4dYn+v4w2uyhHSbcij+kb3mOme3ogiQ2t5g30kZ2uFE2KznHXJQhaBuRFZYVUa
         tYrj76bcaRYcVTmbJ360jH1qeG2NGq/ME+6TdYh1JzlQprwovJlGDjKuyam0KZwMZ+/w
         xNRzxRdpq7Z4PsK1IJZUmT4B4nr1JNWc7kp4Pqj3UOjMsfN6jUhAr5Auzc5cYBEl7Ev7
         VG0Uk7C/l+wmNsJ0MxeMDZsjtXp9Rjvplqg3ectmk3+S7GqoHBCIlIM24tkb2mrxAD/j
         AdBA==
X-Forwarded-Encrypted: i=1; AJvYcCWFnmyoSbS8XX+XQsXmKMT6D2tFTgupPJva4otK//VIJtwGi1DcYmoDCm/8O1Qy7cK9pmudNR2GnbygdLU=@vger.kernel.org, AJvYcCXZhhNY0VA3G6Xldlf+zysCSmvQj9qJxKaIrZDqpEZ+Fv0W351uBIS5EiVjsqJwIaenzFB41xJnfrMg2bnYsJM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6CKuvGcE/memjIm+xyVkskR+tHc6zxERGEerv4pWH/p+fDgzx
	5RMnyF/aLSO6EZRwYYujowdZGueT15ILOOQ498X0c0epIFhpfgz+q4EuFtonMJ4SUWIZbViljLW
	6kjAFjSIUqoq7TFq8u/fC5frh2DI=
X-Google-Smtp-Source: AGHT+IFbzzfoSlxuLAagboQqKdxyY6HbGnXmHLQTbsx77yr4vBkML7+vO5TnyByOusHY+LOJhjmv7O9SFvmUOC55QHk=
X-Received: by 2002:a05:651c:160f:b0:2fb:4428:e0fa with SMTP id
 38308e7fff4ca-2ff609be095mr74167951fa.36.1732026126201; Tue, 19 Nov 2024
 06:22:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241118-rust-xarray-bindings-v9-0-3219cdb53685@gmail.com>
 <CANiq72=13uaXS+mptTiQZ7OLpyO_=r7-06cXEujFqtej=150YQ@mail.gmail.com>
 <CAJ-ks9nqcrOhOSuw+fN9+871W4YEs_rwRJehm=mnAx+M_v8Pqw@mail.gmail.com>
 <b4c1e64b-daef-4181-a3fb-98b4ab3a9c1e@igalia.com> <962f49a8-0d0c-4a1d-836f-e12c0f621917@asahilina.net>
In-Reply-To: <962f49a8-0d0c-4a1d-836f-e12c0f621917@asahilina.net>
From: Tamir Duberstein <tamird@gmail.com>
Date: Tue, 19 Nov 2024 09:21:28 -0500
Message-ID: <CAJ-ks9mVHLC5EpiEp5t1=vNfDqPnn3bmYMgPRYr=K6DvRn0GgA@mail.gmail.com>
Subject: Re: [PATCH v9 0/2] rust: xarray: Add a minimal abstraction for XArray
To: Asahi Lina <lina@asahilina.net>
Cc: =?UTF-8?B?TWHDrXJhIENhbmFs?= <mcanal@igalia.com>, 
	Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>, Danilo Krummrich <dakr@kernel.org>, 
	Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 19, 2024 at 7:26=E2=80=AFAM Asahi Lina <lina@asahilina.net> wro=
te:
>
>
>
> On 11/19/24 8:11 PM, Ma=C3=ADra Canal wrote:
> > Hi Tamir & Miguel,
> >
> > On 18/11/24 14:02, Tamir Duberstein wrote:
> >> On Mon, Nov 18, 2024 at 11:52=E2=80=AFAM Miguel Ojeda
> >> <miguel.ojeda.sandonis@gmail.com> wrote:
> >>>
> >>> On Mon, Nov 18, 2024 at 5:33=E2=80=AFPM Tamir Duberstein <tamird@gmai=
l.com>
> >>> wrote:
> >>>>
> >>>> This is a reimagining relative to earlier versions[0] by Asahi Lina =
and
> >>>> Ma=C3=ADra Canal.
> >>>
> >>> Ma=C3=ADra's latest version has both of them listed as co-authors in =
the
> >>> main patch -- how close is this to that version? (I see some bits tha=
t
> >>> look fairly similar)
> >>>
> >>> Thanks!
> >>>
> >>> Cheers,
> >>> Miguel
> >>
> >> It's fairly different, and I discussed with both of them - we agreed
> >> that Co-developed-by would not be appropriate.
> >
> > I still agree that a Co-developed-by isn't appropriate, but I believe
> > that it would be fair to mention me and Lina on the commit message.
>
> I think I mentioned Inspired-by: as perhaps a nice alternative?

Ah yes - will add in v2.

