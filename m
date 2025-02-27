Return-Path: <linux-kernel+bounces-536542-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BADC9A48115
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 15:27:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 853E919C1EA2
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 14:16:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A899B236A61;
	Thu, 27 Feb 2025 14:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="xdbx9PVo"
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DE6B231C9F
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 14:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740665451; cv=none; b=B7LhVdaOA6VuIRBgZ4+u7pvqQRSWPobHTziR9+r8Hqiv91URIm9w8o72x6OwwzYJ5TxSzjMnxe139E4uFe1T/wBG0Yr5yEzyxVsag36Sz5pSokHkJYNBnXab5B3F1uSG6N9EC2jriRp3+AKAkLN2a1J2aNNAB6YDvXSr7NYCb0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740665451; c=relaxed/simple;
	bh=HvD0GdHLA3qGwMXFiIknEZVlkedmf7OUeodMIEjbRR8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pH25ynHIwahOHIy6vdMi+1whAHL13fEbExX0p0cEWtuxHWyzRA1PvV7cH+wHG5IXxYuSPXgwdFcDoP+V4K66CTrsAaVK+zP8H+1rSThfprPRY0Vj3+12WEqFczzLFL7mIiVa6f2cFAL7NFTsJpEecZ0BXU3iwZ/03FxYG/B0OQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=xdbx9PVo; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-5485646441cso1029847e87.2
        for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 06:10:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1740665447; x=1741270247; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=juDHI0+8fEGnnjQA1BeXYd6MutVRHJOKOY+enn7+/qU=;
        b=xdbx9PVoAZAMRWQPjJvtrKmGBAL2x5O/m4RRtAILMgOHADoiu2jKWmh4JFP2FUkWVv
         QqpDn3/hbCIEcrptEh8PutNJ4AR2Lxrsbqcaf1vqVHZTB76KCQ+/a+6kCWOOHkT4waF2
         w3KjjlLOeXFNtdxurGgYaoSb+M6QBcZliWhr7cwaPODtLtrq1/qb2XfPaAw4yafC9hVy
         95pL72YLBSN/m87BCb5Wluic/UGprCotalgLUqYuJjzUD2maDTCkzhYSAxXQDaxXNOn/
         S2SHmZNt8r5YjYwBQoqSD0ROT5DeP+DtXE6PVHfdi1val6ELy8DFu1yIF7gVCGINeZ4W
         8bRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740665447; x=1741270247;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=juDHI0+8fEGnnjQA1BeXYd6MutVRHJOKOY+enn7+/qU=;
        b=CLmPdwqs2266LlVYNFqlIaKzaG2HeVCK8e1/Xs1y/pOuQOlFF70HPb9RR84qaivTKY
         8JMHeOicxrY7oVprHnyc4BBen2/CoYGuit6Y1pBmXkwcagAHWH0l/1bFvrrW6DRKZpMe
         5yDBa8f3OK04HN1CrH3uXkIIEggcGOLUIwhA6Uay3mTwiTNs8DojTYxryVJwIOf2CGIh
         xVdXDIcfPFRCacKTkT68Sz4KenHrIqFZejNPC9Bz+49sEGALFHY6XRaubsDl/H2x6tvG
         yUCa/uoNORHBMZhfhDEHELEiildn5PbezewWmmwaDRJ33tARK6E0sciiA/0n1bFiD8MZ
         90KQ==
X-Forwarded-Encrypted: i=1; AJvYcCXkxQNQrMMF4Xblc07MOAwS27jjEZjmnFFkKsDC1R/Lc2RZDFvgT/brIZ2h3YYYcQiRoqJHPaLtJ4qzzM4=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywz7UOlNpmgjpFMsnLoIOZGtFJixpy4mF0+fbUzBCz9RscWKJB1
	9Dw96fT3/ldui50qNsrrVQeeZ4BpN+CookQTTGRyIisqwE5F+FN/pjMXHvq1+uydx94XbOVvP0d
	HvutzyippFsqJZ92xJ3eXPJ6CiaIElRQZbiRbOw==
X-Gm-Gg: ASbGncuFgDCxGWClzL2FyIjjrjElZuC3u5+aU39hobe6uNpJFWOHVS7QK3oYfSjMp75
	ZWJgr1Mc7kFA0YJdyDFEwdf2p/9aVdGrh+rY3N1hAeshrKboYWBbv9RDDGprwEtbhLBOf7J1iqA
	wo6vgyD71U2HoH60iyXMs42HMcKdH4DnmXB4gFckg=
X-Google-Smtp-Source: AGHT+IGtNGS5FduT7L3EZWOi1jJ+2DJDrbFGiQz7I+jgi0UOPNmby3BbFiuvhopvsKBURmlm7v0tD/b9aNnGJLrVrls=
X-Received: by 2002:a05:6512:1389:b0:545:c9d:ef26 with SMTP id
 2adb3069b0e04-54851108679mr6710310e87.46.1740665446954; Thu, 27 Feb 2025
 06:10:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250220-gpio-set-retval-v2-0-bc4cfd38dae3@linaro.org>
 <CGME20250227140054eucas1p2bf6e3f2416e11e3c62a704682bf052bf@eucas1p2.samsung.com>
 <20250220-gpio-set-retval-v2-5-bc4cfd38dae3@linaro.org> <ab3e42c0-70fa-48e0-ac93-ecbffef63507@samsung.com>
In-Reply-To: <ab3e42c0-70fa-48e0-ac93-ecbffef63507@samsung.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Thu, 27 Feb 2025 15:10:35 +0100
X-Gm-Features: AQ5f1JruPIGRSMvfqfGJCo4M_sF2CtpTvVrdot0dr0pbOujavSKKEh_CTipp8d0
Message-ID: <CAMRc=McnzfHHLUyYczaza1ao-9iPMoQNOmV3Bm2DSMULCmYBTA@mail.gmail.com>
Subject: Re: [PATCH v2 05/15] gpiolib: introduce gpio_chip setters that return values
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, Michael Walle <mwalle@kernel.org>, 
	Bamvor Jian Zhang <bamv2005@gmail.com>, Geert Uytterhoeven <geert+renesas@glider.be>, Keerthy <j-keerthy@ti.com>, 
	=?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <ukleinek@kernel.org>, 
	linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pwm@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 27, 2025 at 3:00=E2=80=AFPM Marek Szyprowski
<m.szyprowski@samsung.com> wrote:
>
> On 20.02.2025 10:57, Bartosz Golaszewski wrote:
> > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> >
> > Add new variants of the set() and set_multiple() callbacks that have
> > integer return values allowing to indicate failures to users of the GPI=
O
> > consumer API. Until we convert all GPIO providers treewide to using
> > them, they will live in parallel to the existing ones.
> >
> > Make sure that providers cannot define both. Prefer the new ones and
> > only use the old ones as fallback.
> >
> > Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> > Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> > ---
> >       lockdep_assert_held(&gc->gpiodev->srcu);
> >
> > -     if (WARN_ON(unlikely(!gc->set_multiple && !gc->set)))
> > +     if (WARN_ON(unlikely(!gc->set_multiple && !gc->set_multiple_rv)))
> >               return -EOPNOTSUPP;
>
> The above change issues a warning on gpio controllers that doesn't
> support set_multiple() callbacks at all. I think that this wasn't intende=
d.
>

Eek, not at all, thanks for the report, I'll fix it.

Bartosz

