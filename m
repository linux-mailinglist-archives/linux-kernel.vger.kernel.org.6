Return-Path: <linux-kernel+bounces-547835-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 99770A50E2D
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 22:50:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 146157A2FE0
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 21:49:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24A5F263883;
	Wed,  5 Mar 2025 21:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KwFvVxfy"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAE2318E362
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 21:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741211433; cv=none; b=AKy//K6BtEkGIUya2Sv+vdj4S8wBr4tQrWF8DvIHzlzkNSZixxrtK4n63CfrapaRP4b0yyE3qBrKrwmfvQ5kDqb9m5pZ+g3C3FMzmYiSYY0bicnS0Ptspkfiik/vir4MZIu+5xRp7rnKRcBhaoOHxA0RXsUZW9SDIUL4K0EisDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741211433; c=relaxed/simple;
	bh=VBIhiKxO0hnWFQYFuNpxm8i1Lr8rKMJKGNLLyGHZmYQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=klhQIy8LtNsqeF9RpCboM9LrFqb9UUJZ30l9cOUjOZdH/7jbJ8JcueJu+6fpPjus73ALsFzX7z5NUeScLx2ot6pjxIICCd2r6Z5Cua7gnqaEx3fbNLvDtBRZyp6B8bMplFySDdtsadamocz5NYvHkhW1rWDFzhdr2Y4iY3nR/y8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KwFvVxfy; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-43bc638686eso8624185e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 05 Mar 2025 13:50:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741211430; x=1741816230; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6sXlsk07FZxhY/T3MpoCtJCcVQMm9u5T5zif23+8N4I=;
        b=KwFvVxfyCZ7bxn1cGtmbmxoEPCSsQ/HE01sASncTabIU8Ida3rr0vRbJApXwgHF5B9
         f+0rXOywmpn9Kkn+EdvuHuuKVYYEB1s6nnmcdanXi+iaFlDp2LMiVWMW32+8Jqemy5mf
         2g6aZSe1MR4ojgUW7RuSiXuPDy4mDVMsfsrn5AEClyoQ3C3S1pvDkKNLkzLKqlt1nviB
         AlHbKkVZAQONuBRtusROx8iDq+FOEgvdyvSKE724CwcSANa03GxjritSbhIWYgaZ79E3
         v+APi/Frg47k/V63S1I1oY6bdbls+SpyReDM3aF6IY2f/i5Z6k28+LO2vIXv9TFwRMk1
         PiUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741211430; x=1741816230;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6sXlsk07FZxhY/T3MpoCtJCcVQMm9u5T5zif23+8N4I=;
        b=CKWcKAPsuAFIwwWLfPna+3uOfs5GKAMBI42Pwg+s1LFaacWH+g9ZBa5BPukCUUmG7I
         lEtKJSo+3ENjXAknGkWKxlVdw2WEB/jdaeGICqRAFBxC20WlEfOHhtAn3iKD8H2xHabh
         LTCfDiUcnaUso6rmVSFu2QTE1UJBfHM0f2wfJiZVYdR1KBR2fvg/MF/PqPeD3jsvzNOa
         bYEFqjGkJEbFThvT62faVOqDpVK1RG2sp1s5PXddlLq9rAIHnCoUfG8OKqzOJQUy4fND
         wqPGw9a2jnXrWriaQ3kF1gYLMIjwwxqijCgi9pPaCuuRp5uib1Rd4CYUJVQl8xCphDKi
         ZDzQ==
X-Forwarded-Encrypted: i=1; AJvYcCVvh/WcPjWeLwsxcfKwSacjn6QGdJEFV2SsTASzCGolSIkwDOvzCQeMYrkTANUbjnSFBuDokQflMpoaiVk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzoskK6oBmBB9x2j+eufnnI4gil14FZK0kDUu8AxrKZ9aYo9NWe
	bHtR931ymCAWXhyQEw35KVfPQTmuU6Xqp9gMYNg7iBg8f4SRojmX
X-Gm-Gg: ASbGncszt91wbgbW7/s0ZTDMIM1I4m28B8ile+HGxiPowJRNzC41m6bEGny2NPGnTRV
	CV/U01QdR9N5UD1IQH0U3oXTSUmCzFO02i3OTtm16fHoKaHMNA0UP2KhaQmV8/fDZ9ROwIsigt+
	QYKstal+lyn6Wk+A35RJmwyV23LcsCFtys758eKh0haQxEQj38JSDujEbbN40tNOJIIKGwRNjD4
	VtNqD87JE/WNdZym5VtW9Cm8cxoyEkVnWFkpv73iCGAkegE6hgl73ejRUWPYIKjKXi0LiNwipFJ
	omo0JK9L3vBWAatAErzgczL7v14lEkWFObkRqv5RQ8CD8GYh+PQml0NrdYvZRhda+It3olEYs2i
	LCbW9oec=
X-Google-Smtp-Source: AGHT+IG71FMGRyiv4mH56x2l3ar2LR8avIi/yv9IH3AmHHF/clful2q3Uy7KDSjam8AZJ3mZxK8wvg==
X-Received: by 2002:a05:600c:3657:b0:43b:baf7:76e4 with SMTP id 5b1f17b1804b1-43bdb368d0emr7700425e9.1.1741211429755;
        Wed, 05 Mar 2025 13:50:29 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43bd4310779sm29158675e9.37.2025.03.05.13.50.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Mar 2025 13:50:28 -0800 (PST)
Date: Wed, 5 Mar 2025 21:50:27 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Vincent Mailhol <mailhol.vincent@wanadoo.fr>, Yury Norov
 <yury.norov@gmail.com>, Lucas De Marchi <lucas.demarchi@intel.com>, Rasmus
 Villemoes <linux@rasmusvillemoes.dk>, Jani Nikula
 <jani.nikula@linux.intel.com>, Joonas Lahtinen
 <joonas.lahtinen@linux.intel.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Tvrtko Ursulin <tursulin@ursulin.net>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Andrew Morton <akpm@linux-foundation.org>,
 linux-kernel@vger.kernel.org, intel-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, Andi Shyti <andi.shyti@linux.intel.com>,
 David Laight <David.Laight@aculab.com>, Dmitry Baryshkov
 <dmitry.baryshkov@linaro.org>, Jani Nikula <jani.nikula@intel.com>
Subject: Re: [PATCH v4 4/8] bits: introduce fixed-type BIT
Message-ID: <20250305215027.5d9be1fa@pumpkin>
In-Reply-To: <Z8isZodEqhZw5p7-@smile.fi.intel.com>
References: <20250305-fixed-type-genmasks-v4-0-1873dcdf6723@wanadoo.fr>
	<20250305-fixed-type-genmasks-v4-4-1873dcdf6723@wanadoo.fr>
	<Z8hgqOB5Ym-GGykS@smile.fi.intel.com>
	<d7f3150d-0167-44be-90b2-17f8a050687c@wanadoo.fr>
	<Z8hyNXVZxLzhEzNy@smile.fi.intel.com>
	<824dc1d1-14f0-433e-aa3f-679527b87077@wanadoo.fr>
	<Z8isZodEqhZw5p7-@smile.fi.intel.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 5 Mar 2025 21:56:22 +0200
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> On Thu, Mar 06, 2025 at 02:17:18AM +0900, Vincent Mailhol wrote:
> > On 06/03/2025 at 00:48, Andy Shevchenko wrote: =20
> > > On Wed, Mar 05, 2025 at 11:48:10PM +0900, Vincent Mailhol wrote: =20
> > >> On 05/03/2025 at 23:33, Andy Shevchenko wrote: =20
> > >>> On Wed, Mar 05, 2025 at 10:00:16PM +0900, Vincent Mailhol via B4 Re=
lay wrote: =20
>=20
> ...
>=20
> > >>>> +#define BIT_U8(b) (BIT_INPUT_CHECK(u8, b) + (unsigned int)BIT(b))
> > >>>> +#define BIT_U16(b) (BIT_INPUT_CHECK(u16, b) + (unsigned int)BIT(b=
)) =20
> > >>>
> > >>> Why not u8 and u16? This inconsistency needs to be well justified. =
=20
> > >>
> > >> Because of the C integer promotion rules, if casted to u8 or u16, the
> > >> expression will immediately become a signed integer as soon as it is=
 get
> > >> used. For example, if casted to u8
> > >>
> > >>   BIT_U8(0) + BIT_U8(1)
> > >>
> > >> would be a signed integer. And that may surprise people. =20
> > >=20
> > > Yes, but wouldn't be better to put it more explicitly like
> > >=20
> > > #define BIT_U8(b)	(BIT_INPUT_CHECK(u8, b) + (u8)BIT(b) + 0 + UL(0)) /=
/ + ULL(0) ? =20
> >=20
> > OK, the final result would be unsigned. But, I do not follow how this is
> > more explicit.
> >=20
> > Also, why doing:
> >=20
> >   (u8)BIT(b) + 0 + UL(0)
> >=20
> > and not just:
> >=20
> >   (u8)BIT(b) + UL(0)
> >=20
> > ?
> >=20
> > What is that intermediary '+ 0' for?
> >=20
> > I am sorry, but I=C2=A0am having a hard time understanding how casting =
to u8
> > and then doing an addition with an unsigned long is more explicit than
> > directly doing a cast to the desired type. =20
>=20
> Reading this again, I think we don't need it at all. u8, aka unsigned cha=
r,
> will be promoted to int, but it will be int with a value < 256, can't be =
signed
> as far as I understand this correctly.

The value can't be negative, but the type will be a signed one.
Anything comparing types (and there are a few) will treat it as signed.
It really is bad practise to even pretend you can have an expression
(rather that a variable) that has a type smaller than 'int'.
It wouldn't surprise me if even an 'a =3D b' assignment promotes 'b' to int.

So it is even questionable whether BIT8() and BIT16() should even exist at =
all.
There can be reasons to return 'unsigned int' rather than 'unsigned long'.
But with the type definitions that Linux uses (and can't really be changed)
you can have BIT32() that is 'unsigned int' and BIT64() that is 'unsigned l=
ong
long'. These are then the same on 32bit and 64bit.

	David=20


