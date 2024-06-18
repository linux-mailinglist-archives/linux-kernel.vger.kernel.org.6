Return-Path: <linux-kernel+bounces-219114-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DE80890CA06
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 13:44:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C3FB1F2179E
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 11:44:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32EFE19CD08;
	Tue, 18 Jun 2024 11:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oSAzLXR+"
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8214158D8F
	for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 11:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718708973; cv=none; b=Kbbp5a3wkQ1YID3r/Dvip4w4z8McWgVrRoIvDEkDnXkholF9RnCnkJB+PTLverpn9pRGVYX2j+Pokhcw1oNJc1lzYD8ynAE45VruNtFJS5tdU0I1a1uW7pSf817wzAVyhyYkj6hsJ2SlK2bh9y4NXOX0DxRWM4sTs1VQN5tMbvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718708973; c=relaxed/simple;
	bh=RvD7TOS4EE1gHEN7QDkfjxYlgO+IfDmVHOBhN7+7Oyw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aFKnTg7pTGqzS6Eu822C2f03vmHxxRhd1W7JCGU1qIihfBwlvY2Es+yrjk7kYpgmq4o0Vqn60F2wKdiCKa6APlhamJOg2zQWgrXkE5qV3L0q98LVVAXn3BCcbT0PCFjKYzDCqWrxN3ajs6OLMD+iOJ4WT7hjRotMJcVVXE9c5h8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=oSAzLXR+; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-52b7ffd9f6eso5279531e87.3
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 04:09:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718708970; x=1719313770; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RvD7TOS4EE1gHEN7QDkfjxYlgO+IfDmVHOBhN7+7Oyw=;
        b=oSAzLXR+RVdFM4wEvTMIfkg7m2Nb974FQ1Vos1n5GiD8xHQ9rW+YWIlE7Zk1EryfLo
         6uvjO3+XrvZC7BtkO2gz7JIauoisJDnfQf14c+F5eDxDI/fQgTMurSoarF3Yw0dzZGMe
         zb/l8Vz7NO884V8pDtfULomBK7+WeVCufCDX02G2FtsePLYJm4hD2YM/N5Irrd14vOx0
         cSsib4wI5yjLXPQ5bC6apLY85modfwBw7oNe9NIFqzH7CyYNg2ggIsw1D8k7YiJpn33f
         PxCMLXn5hkbEGg6eHkcVOf2ys7eUK0dQZorTANcahBuF2n2Ekmwa6Jgx+sAeoJd86S4l
         Pcgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718708970; x=1719313770;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RvD7TOS4EE1gHEN7QDkfjxYlgO+IfDmVHOBhN7+7Oyw=;
        b=c6g8Wh8B4CYmVb4sMEGPr6d5J9ULeN1dXjGcUIAFneY2TUF22koHj3T5DJXikg7FmC
         vIaklB6i3+lfPnfeBy5/ICJBNe6SfqIckzCYJ4RlYkN1Z1N5f9d8xJq84P4h8y8N6NTG
         Q0Y886ssjbZDMn3yhN+4NO+aATtmCik1bYm7TteXG2T+dWkeyp8IdYlp5eGPf1HI0a3d
         3YCM31zprLpcoTCspG5gAgCzoHMCpBEuV+oxiM35ZW1QioeV7jTEcUOmNFDVLmOaEeUY
         qgTmHSrovVsiYWieUNC556Xr5FU17cIWP9C2L1GH+OhokdiF01ja6+zHpNdQeH5gXDfh
         wWHA==
X-Forwarded-Encrypted: i=1; AJvYcCWJIx3UFJyVcLgcrgDicGnfx0qu3h6uIOU99D5rZcw/BxedsJk0wv7pWfig3qwkLPjEG5gANfFzo0tJt5bngYtobC75sJ3706NL8hdf
X-Gm-Message-State: AOJu0YyMuYnAvhqrU310b/72EXLUEmXZXQrQuJsAdTswhmKaZ/e8/Bky
	LJ/Uqpt6E1rzBLDBDwhBVYKkibYnr3m2A198ctVwXQmj3twe91f6vQ2wOK3OkOtXDX+m7BHHBqn
	xxKihmpwtI2uovvZj8NrtjSKHrDPkPph4lXFBlg==
X-Google-Smtp-Source: AGHT+IGoKxTkRYLabjHUEETT/B3IbExJAmXPzq9+RXs6bzZ+GQ8xGK2jG8c67xHQQUvRR1JIcG5ZA4yr3WPNV/0LYAU=
X-Received: by 2002:a05:6512:2348:b0:52b:bf9c:7e28 with SMTP id
 2adb3069b0e04-52ca6e56012mr10869317e87.14.1718708970136; Tue, 18 Jun 2024
 04:09:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240617-review-v3-0-88d1338c4cca@baylibre.com> <20240617-review-v3-2-88d1338c4cca@baylibre.com>
In-Reply-To: <20240617-review-v3-2-88d1338c4cca@baylibre.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 18 Jun 2024 13:09:19 +0200
Message-ID: <CACRpkdbos8og5=d4MXt4q11tQkhX=dOZdv382f1z2YJV44zidA@mail.gmail.com>
Subject: Re: [PATCH v3 02/41] iio: accel: kxsd9: Make use of regmap_clear_bits()
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

On Mon, Jun 17, 2024 at 3:49=E2=80=AFPM Trevor Gamblin <tgamblin@baylibre.c=
om> wrote:

> Instead of using regmap_update_bits() and passing val =3D 0, use
> regmap_clear_bits().
>
> Suggested-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@baylibre.com>
> Signed-off-by: Trevor Gamblin <tgamblin@baylibre.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

