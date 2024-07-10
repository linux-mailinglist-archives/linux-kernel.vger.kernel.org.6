Return-Path: <linux-kernel+bounces-247193-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B5E1A92CC55
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 09:56:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 615D01F24406
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 07:56:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E04A84A36;
	Wed, 10 Jul 2024 07:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="rbF+/Oze"
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEEE27BB17
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 07:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720598207; cv=none; b=QenAiMh8MTlLImt8DiwHDaYn81PlINB/l18gMys+JIcxrqqu8L1QgPNtO7BSb76xTZZ21e4wb8dYu8zd0yIGQ5f25D8G2OxTK5niZnpXkyh6ijAB+shwCpPrrRfQd66iy5JWHVXh4qONOm+FeniepWcaSKDHAJdi9eIq9Gb+oaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720598207; c=relaxed/simple;
	bh=c95Qk0eEWg1EqqavyDXuIh3UP1MhVbRWFGKlXhpw6xM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Y40meib5m4CESzlG9b36ULJ0mVAdjv1qEVYIBBV/HzHflkIcdqI1iaxjhUmU6Fec/Cm6A3uGT9Fe2+ws+4eBIX2kfK4ja/4DeDe2Rro3XjM4woLwB/Yg0Y3/OunUu/PYCuVPbGzzWULjfuNf4Ulo5fv6ybLNu5crexd/ObofhNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=rbF+/Oze; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2ee9b1b422fso4796611fa.0
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 00:56:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1720598204; x=1721203004; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HOSNhvX2fTnZ5eop2y/6vcG46FGcgD00Yko2TrPilbc=;
        b=rbF+/OzeilR0kR5X7oJ1/MZSSuHWDONCRvT8m5nkoz3/kE72zy2H4lQ7JDx8oFgpPY
         j3zGlrBM+iC/pLhImh2vF3lnSwnKlIx9Iu1r20sdqlh0WTMBS4UTQ1P7oCvyY1qvWp7T
         W3PIWyu5xsncZ6KY9Mi/KQ1n+t7mUQFEMYOvSi+mi7VNgFqwTGYTgcU+7eHM77HHREof
         3kzXk1wniHsxS2E/oN6KGy9dNSFpSp3x4u7Qftq9ZKDIhF6KMjxOHQvw6thTeHbcIMg2
         sVhlvlysqGaowJjAxBHAJewXPjFgWLkJuwx5n2HS9P2u06NXy6jtumICcjMTqxRjgv5y
         lB0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720598204; x=1721203004;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HOSNhvX2fTnZ5eop2y/6vcG46FGcgD00Yko2TrPilbc=;
        b=SbV7rEJJn435+8uVYulNfdV0bm5/C+fuXHaQBf3GyXAesSypZG5645uugHr/jzH1WW
         5EbNKW8h/Q262vH7iNz9NaEY3w4dwnwcBhjFFKJo1WtbFuGDQBwiscAdoTcwCEH2CsHc
         YKAmOGRg0aQiCQMMC3y1WWygZbP7tn4y3lh5OQzmA5TZRXE7C+8eAtPeIIlZR8jfJ6qi
         CiMzly1Sw1/mbXs5y52/eT7gKhlvMdIu7nvJBUxNTaxcvsszNrIdtNTO1x4lX+TKiY/B
         Pc7NYXB9rMPsNPTlNppaIQ+KRACqgqJP4Ql5B3lcq+v3S2/EimO+abIK7Ztb/NDjnjL4
         BkIA==
X-Forwarded-Encrypted: i=1; AJvYcCU2caSbygO/uWzmbpkC6FnU3rUcCrVLWpBpXpCpQ7O4PxT5cPL7LIhAKMmY9dEW/+COKjGjdginHjRqmhPmS8BSy0HBz4CfCtdVN3Df
X-Gm-Message-State: AOJu0Yy9X+/55B5vHZlfCa2mRSjuki/r6XV27/Q/7GpIPS6AwcsoWzay
	uDC0XcMNEQ+Bpa3dI4WztT9nkgyLCM/DHedcgqw0pC7X2zzUMepvIhaQOYR2lQWTzF25LXx312x
	o+F5WOJ9Rgswy5oNFp+aL+lJjzw38hVhKlqwPsbFgMpCsU/Qx
X-Google-Smtp-Source: AGHT+IEQPK5BvKG62/rcQJWivaYYXpcgyK4iH/08mQXPMMZVo+si0r71P5cFlWmZxZJpKSjf0rsjIlTsd+8hqxYiTpQ=
X-Received: by 2002:a2e:9d8e:0:b0:2ec:3f79:dcd5 with SMTP id
 38308e7fff4ca-2eeb46d031fmr12617111fa.18.1720598204058; Wed, 10 Jul 2024
 00:56:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240710014401.1719716-1-nichen@iscas.ac.cn>
In-Reply-To: <20240710014401.1719716-1-nichen@iscas.ac.cn>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Wed, 10 Jul 2024 09:56:33 +0200
Message-ID: <CAMRc=MdfG5Tru1VS1xg+Q_w0dPEOwMuwbEzHBZiuFDO_mjioEg@mail.gmail.com>
Subject: Re: [PATCH] ARM: davinci: Convert comma to semicolon
To: Chen Ni <nichen@iscas.ac.cn>
Cc: linux@armlinux.org.uk, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 10, 2024 at 3:44=E2=80=AFAM Chen Ni <nichen@iscas.ac.cn> wrote:
>
> Replace a comma between expression statements by a semicolon.
>
> Signed-off-by: Chen Ni <nichen@iscas.ac.cn>
> ---
>  arch/arm/mach-davinci/pm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/arm/mach-davinci/pm.c b/arch/arm/mach-davinci/pm.c
> index 8aa39db095d7..2c5155bd376b 100644
> --- a/arch/arm/mach-davinci/pm.c
> +++ b/arch/arm/mach-davinci/pm.c
> @@ -61,7 +61,7 @@ static void davinci_pm_suspend(void)
>
>         /* Configure sleep count in deep sleep register */
>         val =3D __raw_readl(pm_config.deepsleep_reg);
> -       val &=3D ~DEEPSLEEP_SLEEPCOUNT_MASK,
> +       val &=3D ~DEEPSLEEP_SLEEPCOUNT_MASK;
>         val |=3D pm_config.sleepcount;
>         __raw_writel(val, pm_config.deepsleep_reg);
>
> --
> 2.25.1
>

Same as the GPIO patch, can you add the Fixes tag?

Bart

