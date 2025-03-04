Return-Path: <linux-kernel+bounces-543422-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 25667A4D564
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 08:53:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 297F71883A44
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 07:53:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F79C1F8736;
	Tue,  4 Mar 2025 07:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bzzdgt4J"
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEA6C1F7914
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 07:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741074799; cv=none; b=VfobJP8OCO44aWhypFD+0pqPXzOWrdJ2xFa3rD+zC9ufxGynmAAdRCZceyWSuSAu+qItDNjfiLBNDhfMaLUsjanRwKkj1axDORTkQquPuJOkgilR0nROfIN5wVLmPU1ZWbJgfZBugDxShnNoSZ/Li55R0QrS6OG3EEY+8cDEDQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741074799; c=relaxed/simple;
	bh=BVJSFhPr+MWcVdsQvQ4e5j7EsE3f4zAOy5yVDG+t3BI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=r/Hr+Ly8DvTh5tSz9TvGPvPclIg6lMaIoSDTwL3/zfa9M16tb89ns6coMiKGDEWGqAU/GpyST+h7YwbxgCXEe6AK76CCXFzWNHE/3XLmo6l7JLEFoMEvuU3seCFkjZJhhFBtV8yAhZZCP72U8yvPBJg7ed9Va3BZHQYhQEmmUrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=bzzdgt4J; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-5497590ffbbso755693e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 03 Mar 2025 23:53:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741074795; x=1741679595; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BVJSFhPr+MWcVdsQvQ4e5j7EsE3f4zAOy5yVDG+t3BI=;
        b=bzzdgt4Jddv57DDM9/XJp5vg22xYr//tW5r6EorBC6CtS+UtHLMdTUSoKB61L3hS3C
         CrLFeeijxXBXKpXJPxBX9AFgLIWAAa5UYRixM3QV9ZC6oNLwVZr3Df6kpZfwXBubOdY4
         yhBlTyYcFzjkJzmOdcUeBc75jeCSRdAVQbWAdbm5JxabjWcvOlxN1Rj3hhf9e96fX6T0
         bW/DH/o4yRmvijclPwFvVlKJ+N9Q2yjgSTcTBD6sqQ035qQiKmivyOaVdj0W7rjFv5EP
         YybQXmu8fPrZC1Gohb/tGjwAlXzmYWMv5UZn4Cy+/zQdkoF1VOJUXR0q7OsNuQwXPCuC
         ZAZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741074795; x=1741679595;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BVJSFhPr+MWcVdsQvQ4e5j7EsE3f4zAOy5yVDG+t3BI=;
        b=j+ywrbWSDBvscU7wuKMB7agduv4n2DXvpLomFKVrtsikY8BjOGHnrbv6s+6MxTFsZ5
         W31YfZ+rVao1wGeh99t6FMkDW+DzenohtMNKoKt/6MSUdtnMG1QzHbEN8oG1U2WkeHxg
         ZnGObnWnuSZ0Gx4Tpec/8GKodS1DOM1lFEZY4uZSB5MnLs49E6hBCg0Z+rTCtIN9xGW2
         B3XBTY9V7w3PB7TUpjecFcd1y7H95vDTDhaCq9d+JHMiXcnSP1k47htfulJR1JS8f9O+
         wctwnEs0QbOrn157joY5qCZSBS/U2mypNauK4NSk6WiZoZgFs9HRBKQFKXCAmRNjiUBI
         5VHA==
X-Forwarded-Encrypted: i=1; AJvYcCVGp09514KppMbI5nBQklnNdEhl9T/xc+OvO+boUz5Cfm4uIoVcdyXCc9NbsBcnC4+BkJQtN1MlAzXmLd8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzhSRNFbHe0qRA+uN8uSM6wT6/FtLGlA0QpJ2MM5CpmS8BycNX7
	vDMYeEeCl4nY6W1Tr/Kk1OXzpuFWYzl1wJKGU8PNvWiaoou8FzT3tO2W9DnvANzplL+nrEb+q7G
	IOMyp02s7pwiOVixbz4/U6sUhgYjrIV/rTgTLmQ==
X-Gm-Gg: ASbGncuAtnMeQxo84rs8Or6yQZtQLRPXyTo+Wp0JD9gsgz5IxepxlxeI1Z2WM1/9smx
	nJbdyKAtWASEKIXGGRsPDYPjbB43NJc+hDRLtUXfpU0fbibbjoBcO3FiGTUO/qAcK1gx2Gub7y5
	Ochb6bbiDRVBc6LjWzvV2MAh1p6g==
X-Google-Smtp-Source: AGHT+IGo7kPW6t6mFBR3/sTMivZuqhRH0SeEyZ9ok1vnRKx+3P9ggktEPjyopRkd13VsV+wua67se3lgNpjzpez8VHk=
X-Received: by 2002:a05:6512:1044:b0:545:2efc:745d with SMTP id
 2adb3069b0e04-5494c3546d1mr5523229e87.46.1741074794798; Mon, 03 Mar 2025
 23:53:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250219102750.38519-1-brgl@bgdev.pl>
In-Reply-To: <20250219102750.38519-1-brgl@bgdev.pl>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 4 Mar 2025 08:53:03 +0100
X-Gm-Features: AQ5f1JoUOBReXAYnYf9thqIoVITthD3dUEJajNI_puN1-yLNkKw6af5pX77JOew
Message-ID: <CACRpkdYeBM6V+61-cbX1g_wLAVHvQQrtPb=5qjTdUw--+J+E4g@mail.gmail.com>
Subject: Re: [RFC/RFT PATCH] pinctrl: bcm2835: don't -EINVAL on alternate
 funcs from get_direction()
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Florian Fainelli <florian.fainelli@broadcom.com>, Ray Jui <rjui@broadcom.com>, 
	Scott Branden <sbranden@broadcom.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, Stefan Wahren <wahrenst@gmx.net>, 
	Liao Chen <liaochen4@huawei.com>, Chen-Yu Tsai <wens@csie.org>, Mark Brown <broonie@kernel.org>, 
	Marek Szyprowski <m.szyprowski@samsung.com>, linux-gpio@vger.kernel.org, 
	linux-rpi-kernel@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 19, 2025 at 11:27=E2=80=AFAM Bartosz Golaszewski <brgl@bgdev.pl=
> wrote:

> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>
> Since commit 9d846b1aebbe ("gpiolib: check the return value of
> gpio_chip::get_direction()") we check the return value of the
> get_direction() callback as per its API contract. This driver returns
> -EINVAL if the pin in question is set to one of the alternative
> (non-GPIO) functions. This isn't really an error that should be
> communicated to GPIOLIB so default to returning the "safe" value of
> INPUT in this case. The GPIO subsystem does not have the notion of
> "unknown" direction.
>
> Fixes: 9d846b1aebbe ("gpiolib: check the return value of gpio_chip::get_d=
irection()")
> Reported-by: Mark Brown <broonie@kernel.org>
> Closes: https://lore.kernel.org/all/Z7VFB1nST6lbmBIo@finisterre.sirena.or=
g.uk/
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Patch applied!

Yours,
Linus Walleij

