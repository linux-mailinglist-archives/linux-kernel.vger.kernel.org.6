Return-Path: <linux-kernel+bounces-219123-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64CC290CA23
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 13:47:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D9F3928EB44
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 11:47:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19B2F19F469;
	Tue, 18 Jun 2024 11:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VUnd+W1U"
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C64A519F466
	for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 11:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718709160; cv=none; b=oUDR2xboT9umBayjYJJXCgs4U1J7nPCG0nQUuBGuRjxVlgmYpz98rOWGr2RkeyW3wFp1+K0j+USQQv+5xi8DJVCNaGaVNPtcLcvcfcydG/91n4wxdI9i9ThynM5r8ij/SNrGc4UTZx6E+9BABUK7Fg6/1p9BXJGuW8zc3ot8psM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718709160; c=relaxed/simple;
	bh=LytFF4Umh3FGe2BHoZB/hPX8STy/rMVhd/DWw4ViV9Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=B18YgHvIsWh0XZ5VWByC6tELQWElJQ1gnUBiXKuVSGYrl+CYl6DLcUPJNGiuJ7lRBAk/WsaLkHwFl5yJ9FyLSPfVztoKuu8QAQqsj+xs9eHYBH2ww5Wp7QTEOYvm6DQplqNctmoNKid/WWkJ3zA92xrY8bdZm7NXaYs9HFnonrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=VUnd+W1U; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-52c85a7f834so6816747e87.0
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 04:12:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718709157; x=1719313957; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LytFF4Umh3FGe2BHoZB/hPX8STy/rMVhd/DWw4ViV9Q=;
        b=VUnd+W1UO8dwI++rRJjC9xkLMye0Q0APYfv8wJocutnV98ASXKsE+os+RYgZnr3hWA
         aU83XdiVm1aVzbH4ycE7zZBcBDGxa4LAutLPtLVqrfDod+A+pnLWCCEazb5IxWGd309L
         ubTrPyWwdUL9XrveurDSq81DaVSwhwQufQnZTb1xzpnHVSxrLujgHeyByxs6RQuFKiN8
         Y+caXzBQIoO0Z0w9fXXy3e/mzi5sz0DjgwBtnZlBuDV152DN6KvG1ilNYLwrO6QFDnlH
         us/SORoz2NoEXKmvrWXa/CBygHmCH3UmkNSa2R3Rn6erqUkAXotZOdtqaepnTBXTtPqK
         +i8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718709157; x=1719313957;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LytFF4Umh3FGe2BHoZB/hPX8STy/rMVhd/DWw4ViV9Q=;
        b=L5dUMWaLdw4dL5tGxCSYoMDEAvBsdDjxnHowdVEutIIzvJeP5vLuwc3PZXtPeOiPhV
         7QTVhtDBB6xO3MWtDPO94xaCGHYpb/6SIl62c3Q8SlD2q3d2gb/g5IAILDs0OFZF/Oq0
         lT8l6HW+Bjo+xPmlup3wW3r/6+e0pmkb/tHOLiFB9YwGlSAo+p2gpj4R7xI6IjZE1fXO
         tnJGZ6dfICB0b1RuOI79M8RGX1W4AKqWK+7mWA8IOo1DsWCRHAwJUC1gjApSexuHBgpX
         u4fshrG51zR2Ndyb2cYJsTTis5hDdjyR3rhfZsgFxfwfZs2ov/DaVX5Fvb3ZnSkO2JvC
         SLpA==
X-Forwarded-Encrypted: i=1; AJvYcCWraYFq9Y3Mjb728oQLVVcjCY9J5yorl4HSSObMzgwpZ9sZsHwZp3r6M+RcYZJoPArA+DhVSe7ZG/J48PPc5HLJ2iD+kwQS0ZVCOhyZ
X-Gm-Message-State: AOJu0YxvJpE/7qNSnf0uR9kbBN+i5I3ja859oGflWmgUSvKU6bFquFqZ
	Z4g2bmX+lInaxEqEBR4JJB7YKz9lZrfJOkNUMoxbTgee4yojLMT79i2pe2UmHipdUN1q73fi/li
	tPdDMfKof/ykT6fD4Ij4wTSkvUbGtVUNJROshfA==
X-Google-Smtp-Source: AGHT+IFCeIOoRy25rTwUHZ/n6vBdkCPzCkJ8a//pB4Qa6c+3jDe2XeC/62v2ldwWc8Yh5JI+ho23V5WmsKqsRfZrbxc=
X-Received: by 2002:ac2:5307:0:b0:52c:998a:77ba with SMTP id
 2adb3069b0e04-52ca6e6e5f2mr6662065e87.36.1718709157060; Tue, 18 Jun 2024
 04:12:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240617-review-v3-0-88d1338c4cca@baylibre.com> <20240617-review-v3-35-88d1338c4cca@baylibre.com>
In-Reply-To: <20240617-review-v3-35-88d1338c4cca@baylibre.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 18 Jun 2024 13:12:26 +0200
Message-ID: <CACRpkdYchu+muvbinPpUFvppMMQCFe9zTcApj46ip4PYUGUhVg@mail.gmail.com>
Subject: Re: [PATCH v3 35/41] iio: pressure: bmp280-core: make use of regmap_clear_bits()
To: Trevor Gamblin <tgamblin@baylibre.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, 
	Dmitry Rokosov <ddrokosov@sberdevices.ru>, Michael Hennerich <Michael.Hennerich@analog.com>, 
	Cosmin Tanislav <cosmin.tanislav@analog.com>, Chen-Yu Tsai <wens@csie.org>, 
	Hans de Goede <hdegoede@redhat.com>, Ray Jui <rjui@broadcom.com>, 
	Scott Branden <sbranden@broadcom.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, Shawn Guo <shawnguo@kernel.org>, 
	Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>, 
	Fabio Estevam <festevam@gmail.com>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>, 
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>, Saravanan Sekar <sravanhome@gmail.com>, 
	Orson Zhai <orsonzhai@gmail.com>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
	Chunyan Zhang <zhang.lyra@gmail.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
	Alexandre Torgue <alexandre.torgue@foss.st.com>, =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>, Crt Mori <cmo@melexis.com>, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	imx@lists.linux.dev, linux-amlogic@lists.infradead.org, 
	linux-arm-msm@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
	=?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 17, 2024 at 3:51=E2=80=AFPM Trevor Gamblin <tgamblin@baylibre.c=
om> wrote:

> Instead of using regmap_update_bits() and passing val =3D 0, use
> regmap_clear_bits().
>
> Suggested-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@baylibre.com>
> Signed-off-by: Trevor Gamblin <tgamblin@baylibre.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

