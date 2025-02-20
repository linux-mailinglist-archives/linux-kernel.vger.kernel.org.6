Return-Path: <linux-kernel+bounces-523245-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 505DAA3D42E
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 10:08:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 704D4189A4A9
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 09:08:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD1BF1EB9F9;
	Thu, 20 Feb 2025 09:08:10 +0000 (UTC)
Received: from mail-ua1-f50.google.com (mail-ua1-f50.google.com [209.85.222.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B8AC1C5D67
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 09:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740042490; cv=none; b=Ck7WJ8m8LzfQuHg3256TTNYJTHDs4Lf6x2MJzLFc/KRlHp5sJXv4Hbqb8EfS1pz33txA7FN9yKDRaEPzEH4EHH1/OBvK1zwpKyFXjirLmH27eoyrN8k6lfFVafNgLrsAuNWkMbebY1G6nyJzWu6UMEF4ZCl2vTsKFeuVHMcCX70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740042490; c=relaxed/simple;
	bh=7vx15IQxYZRa3T4lslXZAPYRFL8CcEnox/jZd//eeqg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Q76b7eeQWNVzQ4IOL0MVh29DAeWI+ulX5RNUIDqIku5kTCebv8r4F+cSr/o2uKJ/m+SI2R4qLle17NpfWXR1FKR/qzFiJu+BTRSPti2ZP8FTMjkTdQ8OlFzGOWa2NGHKJt80vQReb7Qj1+iS5NjWrx5trpLxfAvgiNqiphKaklw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f50.google.com with SMTP id a1e0cc1a2514c-868ec803d83so170014241.3
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 01:08:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740042486; x=1740647286;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vGBCTmEQKro/QQYdud7kw8Q+pzJM3E9asTpsvZ+X8EM=;
        b=ZuuhYzcH/Y9MmNv8/95lvsmYYGZXfprm9/jx4jaH2PgxiVYRyIG5dyP+zeXpqoGr/2
         KPNMTRIMovkpI9L4MO2bvf0ENPqZNqWDdvmpXLDfWVvKXgNyb+YlJy2Ni8/sy4aeaPi5
         C+DugbxkBhBNoaUypTUH9hHqpjiaFNpeEO34nWCpEeuQgS989LMyX6bPJdZljDB37nR0
         5vYT9qnwk+In0BWn9zkCzN8AiZCnGg29im4SVqy4ufJ/YVu/G9tRA24lTN7n7b6W8fiO
         oW8ps0sBuU0bPteOCIugb9NtFgb6Vy6HqwWOCWLHvebFfV5h22S6DTm3UPeB+n2n+TP1
         PQRg==
X-Forwarded-Encrypted: i=1; AJvYcCW3GHTRsg5f3hd3xBsiUSE7q36Jm/b+2Y6OHCfYSa/z+B+MGyE+dh9cG2LwULZAcXvyF4MKHLCLA80SOKc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBAVVX0qBwmzj74hINiHUCjas0/mtjgsm5UtnLPaAKg1r71HNn
	n8bbBR5ZL0KFRP+utqZClejN5vLvSjQkmOw2jpmDDUr0a4jqV3qkLE8zeZqy
X-Gm-Gg: ASbGncv4mM2KphHVDW854bhTguHWqyTByiATwgtQC7tHzceytYid6dz49ucedTusmcU
	+xi5PsjXZ8XaYDyiN6Kyc7KvrJm56gDxHGJZWCRd0O5GYapre6urOxLnkkh/4EAh0LZtNAnaQFD
	IwN69sLdPA42tFTkuRtmPODUFL2JWBBXgRcoFUXNiLnRSHiaqtMy3nx37uz9NhyQF/IAbDp4Xie
	zWbqmhqZZID9Inqyhfb7FitowuCpFbP98VOUgKrQ+AakY3aWiXxiWo/MYMFnWrr//usZOadHhxs
	0/9dRoU7n/75Yn2k0DJCE4gT1NjToiOfMiun7iVm2n+rpVjfcXvS6A==
X-Google-Smtp-Source: AGHT+IFQs3q7uZ8jIVXS65nXIa1a1prkn+MzyAOgRkEvrPeyowa20KmINOaFFNxzKmZrrgiH9i8RsA==
X-Received: by 2002:a05:6102:4187:b0:4bb:cbbc:42 with SMTP id ada2fe7eead31-4be85b54fe8mr3722999137.5.1740042486571;
        Thu, 20 Feb 2025 01:08:06 -0800 (PST)
Received: from mail-ua1-f47.google.com (mail-ua1-f47.google.com. [209.85.222.47])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-4be58249f76sm2104290137.3.2025.02.20.01.08.05
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Feb 2025 01:08:06 -0800 (PST)
Received: by mail-ua1-f47.google.com with SMTP id a1e0cc1a2514c-8671441a730so181646241.0
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 01:08:05 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVH/4qfgzWxFaU2twGbpVGzzy4ycwgbnn3QiqjabngH25uq3pAl/y9ewYBf1N6Ut+V0S3Sl+EYn7BM+L2o=@vger.kernel.org
X-Received: by 2002:a05:6102:8024:b0:4bb:d45c:7f4b with SMTP id
 ada2fe7eead31-4be85bf9778mr4909500137.11.1740042485608; Thu, 20 Feb 2025
 01:08:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <11603b392e2899b44fce61bbc8626a1aaa32b8f0.1740037706.git.geert@linux-m68k.org>
 <CAHp75VcMweeEa=oAsVOLefuUKx96YJVg4ifdqT-uySPLXWeAeg@mail.gmail.com>
In-Reply-To: <CAHp75VcMweeEa=oAsVOLefuUKx96YJVg4ifdqT-uySPLXWeAeg@mail.gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 20 Feb 2025 10:07:52 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXxu_H52JJPwwU-GSNA=J0qQ8oJtU53+gEidukTaFhseg@mail.gmail.com>
X-Gm-Features: AWEUYZnSi6YR9zYxT3gcuKH7swpfjTeD4n4sFC5i0xqksvPaaVEdT0XQXTf3TBg
Message-ID: <CAMuHMdXxu_H52JJPwwU-GSNA=J0qQ8oJtU53+gEidukTaFhseg@mail.gmail.com>
Subject: Re: [PATCH v2] auxdisplay: MAX6959 should select BITREVERSE
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Andy Shevchenko <andy@kernel.org>, linux-kernel@vger.kernel.org, 
	kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Andy,

On Thu, 20 Feb 2025 at 09:21, Andy Shevchenko <andy.shevchenko@gmail.com> w=
rote:
> On Thu, Feb 20, 2025 at 9:48=E2=80=AFAM Geert Uytterhoeven <geert@linux-m=
68k.org> wrote:
> >
> > If CONFIG_BITREVERSE is not enabled:
> >
> >     max6959.c:(.text+0x92): undefined reference to `byte_rev_table'
>
> LGTM now, thanks.
> Do you think we are in an emergency to send it for v6.14?

No.

> If possible, I would prefer to send this in PR for v6.15 as the
> problem was from day 1 and only bitbot found the configuration so far
> that fails to build.

I had to go through lots of loops to disable BITREVERSE and reproduce
the build issue (e.g. CRC32 selects BITREVERSE), so I doubt anyone
will ever encounter it with a real config.

Gr{oetje,eeting}s,

                        Geert

--=20
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds

