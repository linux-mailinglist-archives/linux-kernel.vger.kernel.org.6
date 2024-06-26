Return-Path: <linux-kernel+bounces-230688-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF00C918094
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 14:08:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BF1831C2203C
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 12:08:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 935B4180A8E;
	Wed, 26 Jun 2024 12:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="e98xr7uQ"
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DB4B180A8B
	for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 12:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719403704; cv=none; b=baEL6XIHJCDBrkCA4EcxAyCvGuX97OZFHhmNJAcEc2QsFh3RvfKOwJ5NizA9LOWuXVHVwBK1cdrhy7JImEwJZUMVhkKhnBxmrrs3X7gmWOEUJf/0DWOtcHf4wUiyGQFkNqSSvnSrXDCcv3PKKaFsC4e/rNdXHlCgq8rsukg0ynw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719403704; c=relaxed/simple;
	bh=sNM0t5btmwmRWxg9oFqKPaxYC2URMv4IMNPh+tlcPuk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ft+ne/O4DVeuEVjylWA+ugrlS1FzpWiN5JDyt7ytgf4GbfvzVzjlCuYzDa8DoiVbcW1x3PK4jHzbXMTcdkhXUbJMmAFTIr0Y18HjWw5UBt/2ZXW1P4vodhdLraMD+yv4nFnSAs3TsCn3WDJ7c7H/OIOsPZpdUOPcTklTrPkcISQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=e98xr7uQ; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-52cecba8d11so2332156e87.1
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 05:08:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719403701; x=1720008501; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sNM0t5btmwmRWxg9oFqKPaxYC2URMv4IMNPh+tlcPuk=;
        b=e98xr7uQZhOm7vUbGkUM3VWkQXRrvP3U8JgJM0vCds8yORRFubKAWjRpApatMNCM4P
         VaY+Iqf3eyQ8YyKAlg5bxkWxy68yy8Mnf3y25+CWV+zl0HvTXUVG1Agw0Z9v60XljERS
         6taRBd8kyLgsKue02uRnp6QwMi0Gjxs/ssOGNe5lq708UqBWgNEdF4VGS3Z06WS3QFIp
         xch8ZVTGEzLkeVvgGBhEQgjP3M57uA39v6iO8hzTgupujL+B30alc3kZkSp4Hy+hMkko
         4gCBCEaPeC/s821mVP/GpwyUF7cz2mgV0qdEMxMpm6AkeYpQ74nUZ1NRBsO5iRJQc7H8
         tGcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719403701; x=1720008501;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sNM0t5btmwmRWxg9oFqKPaxYC2URMv4IMNPh+tlcPuk=;
        b=h22V7Ck9CiZuxQmo2xOIic+dsU2smf42mxhv7QXl728qetxI78ZszUn5hytNX3/slh
         3omKtQTSIYxtrcjCzmxY8aEuKiJ2bLECxLwynQyQFpaDUz41ZOSsrFZHA4SkCTYTkVqU
         GycJLNdFYcc3vGBLg4izSaEXyR+AGUTt2Q7J+jQyP5HSc3Hbrfc3D0DsZ6uoIq1M8p9T
         wddhviQ7wwsbdPhuYp+ctQf4wsAlae63VOcLIb6GAnyth1opfwCcs9L1k0p6U0knD58x
         7ITneFrT+w4Ty4WL3gPHom3U5Gkzzn6Mp/I4Et4//p94w+O3kdprb6vZik3EdARL0q4p
         5xEg==
X-Forwarded-Encrypted: i=1; AJvYcCXrmcVoH5RHNV+8QUTY7/WILwbbeXmOmKuSEEc0eleYR2NbZc+h38l/sJ4V4OajphUQ/SXCmu053/OrRfKEdt6e9mB541ojoaVXkOwn
X-Gm-Message-State: AOJu0Yy4RghaNhLmQg2TZM++wNqCxgC6DLpSjuYPxg1tOanKqbbwFHb3
	mYzh+wLxAF2T20Etc/ujGST4wxY0nymRjXfW7cFSJK1XYy965145JJnb9M2y2Mxt4dnxSlYddyI
	g2X8wcvvBpu+gP9+5elBOuVoXcMMTNeb4Szf2WQ==
X-Google-Smtp-Source: AGHT+IE7XMxIQJJ1aCimYjEWSyFZvjRjaUXV7rV4COqu6M3ZQ2Zfzl0Y1tYmHaO9gdJvOLgTXmM+4eAs2D6EvjQdW6U=
X-Received: by 2002:a05:6512:2004:b0:52c:dbc2:ea1 with SMTP id
 2adb3069b0e04-52ce18324b7mr5665556e87.6.1719403701264; Wed, 26 Jun 2024
 05:08:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240625043525.279711-1-manikandan.m@microchip.com>
In-Reply-To: <20240625043525.279711-1-manikandan.m@microchip.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 26 Jun 2024 14:08:10 +0200
Message-ID: <CACRpkdbWJN1DKckGqqhTX=nJ=0QE6-7pobZw377iKM1DDrMGUQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] Convert Atmel PIO3 Pinctrl and GPIO bindings to yaml
To: Manikandan Muralidharan <manikandan.m@microchip.com>
Cc: brgl@bgdev.pl, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com, 
	claudiu.beznea@tuxon.dev, arnd@arndb.de, durai.manickamkr@microchip.com, 
	linux-gpio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Manikandan,

thanks for working on AT91!

On Tue, Jun 25, 2024 at 6:35=E2=80=AFAM Manikandan Muralidharan
<manikandan.m@microchip.com> wrote:

> This patch series cleans-up the compatible property of PIO3 Pinctrl
> and GPIO bank nodes in DT and includes the text to yaml conversion of
> Atmel PIO3 Pinctrl and GPIO bindings.

The patches:
Acked-by: Linus Walleij <linus.walleij@linaro.org>

I assume it will be merged through the SoC tree.

Yours,
Linus Walleij

