Return-Path: <linux-kernel+bounces-392186-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 00C399B90C9
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 12:57:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EAF9EB221F4
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 11:57:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C19F19E7D1;
	Fri,  1 Nov 2024 11:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MxzH+GCR"
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DFA819C569
	for <linux-kernel@vger.kernel.org>; Fri,  1 Nov 2024 11:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730462183; cv=none; b=PYgJSoOaCi4jVECnBqKn/1la2Mb5HkiZimpHLW8bY6KHC4zTPQWF7M/dYa7q8pVRKZ49POaNY7qWHNxeIYyev8i2tq2vacTAx5WtMzVWa8IUFRO1Oxjyb/tT5nLSUwCjLmLiRHj1pjKdjmZs922HiWzTX9x/Pxy002AHBW7EjKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730462183; c=relaxed/simple;
	bh=1Uojm1GMg7+SmttJF2ZuBBVhB5ST+uLPitvJ1/9BMXM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IAwitK/xSf+7z2B50unX4v6LogVQ9WFVFzeq8fMcGU56Efqa29w3dFod+n2GTkPz4wjnO9XA++g6lf/R7UzlBzEioIJKkwAf83z6eGBtZ13lNBIvjnuZhqRRs+o4PlsqS8gI1qLDPanJVYoU366EB5pEL34RX34TRoSoSMbjJ6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=MxzH+GCR; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-539f6e1f756so1998797e87.0
        for <linux-kernel@vger.kernel.org>; Fri, 01 Nov 2024 04:56:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730462178; x=1731066978; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PR7nhijIFPqEwqWUXxfWpQdSj2cyoar1EyPI7jC4FfI=;
        b=MxzH+GCRv9ClLXszj1vkA7X0oGAXClXXgEIfvB1I/fqumEFDtqAzfp3hURIQrIAVEZ
         BsqbkaFi5p3FyjrPwEk4hGz5p94qimaZQXAlI7Ps+m69KiH8Gbw4dgRTSE2mb6EHnH4N
         wi3vSnMtzyNMr7ipbOc+lxfww/zjYouA+g2Fy/JvBb0lY8OC6Nw9we4tjJHv8j9xHcqC
         BAo0oh3U+8LGjpDZCm6O4mJaKarznjkDV/o4EOKJsTDsR/VR9PTHJcaU12FxvYyDAeEf
         5JdKWuQtH5k8F1vC1JFfyoIGkWUw5zNWqP7LAivnTuIenqLG6C0GX4ozJ7SW3/FF5C+J
         LQsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730462178; x=1731066978;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PR7nhijIFPqEwqWUXxfWpQdSj2cyoar1EyPI7jC4FfI=;
        b=IFnWe5RwDOrc1GFS+BY0mF2kLCssEfFTYiI7+OKoj1P/EWXgvETEQAJ8NQRuR+Zri9
         OPcY3vq4U1jhiuGQ2RPeAY0bHB0D1fcM5g2l0asFkk96yJRnfJqol7662U3gtCvLoMPs
         h/AclZumstiiMlwrCv7gUu3RR2xZtkUJYPZbKqd2fRfVnfNmyphPDQDAbWGAHJQBwBvE
         6Owu9fB0XW8GiGawgvhQrabPHdTY3x14r9gwp4LUP+81mOE0EaTEHjtGcz0sytM6cOWy
         v+89osjKe8UNnXQXVM6Xo3q7wm6ulnZVDDx8NWrIAdfU7ahGckTtyAzNU61Nx44gS98V
         50yA==
X-Forwarded-Encrypted: i=1; AJvYcCWcH9FmC/+985kOLwz2fJ711yofAQmYWDEemMtTH13OxDMWQoRI0jDl1WPqcyIlDWmGvOmYsTE6kWozo/c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxo6SOm6XW+15BQYeH2X0kdcGUaDetceCTvYn9FvJg5Xvd4WjS9
	FAwxKkFNFKikAyeptYJUGnfboemwW8C2YZawEhFOSf/azqf+neqU0oghYkOpJreGDz2GSLLKxw4
	GsZcaugvat/wgwlYjSPdpkW/ses6AfM2m1jWd0w==
X-Google-Smtp-Source: AGHT+IG201tjRpH4xAJy3js1MXvAZgMS+IPv3AAVo1TZLrpjjIYjlw9AiqUvvc+CIbPttUv3zlvfcUINXBzKPHjno0Q=
X-Received: by 2002:a05:651c:211a:b0:2fc:9550:d658 with SMTP id
 38308e7fff4ca-2fcbe004950mr124110461fa.24.1730462178345; Fri, 01 Nov 2024
 04:56:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241101080614.1070819-1-andrei.stefanescu@oss.nxp.com>
In-Reply-To: <20241101080614.1070819-1-andrei.stefanescu@oss.nxp.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 1 Nov 2024 12:56:07 +0100
Message-ID: <CACRpkdbFQ6f6xg906ZREOgDifSWwfFWdxCqDxcLALZdYg6PWWQ@mail.gmail.com>
Subject: Re: [PATCH v5 0/7] gpio: siul2-s32g2: add initial GPIO driver
To: Andrei Stefanescu <andrei.stefanescu@oss.nxp.com>
Cc: Bartosz Golaszewski <brgl@bgdev.pl>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Chester Lin <chester62515@gmail.com>, Matthias Brugger <mbrugger@suse.com>, 
	Ghennadi Procopciuc <Ghennadi.Procopciuc@nxp.com>, Larisa Grigore <larisa.grigore@nxp.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Lee Jones <lee@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
	Sascha Hauer <s.hauer@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, 
	Dong Aisheng <aisheng.dong@nxp.com>, Jacky Bai <ping.bai@nxp.com>, linux-gpio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, NXP S32 Linux Team <s32@nxp.com>, 
	Christophe Lizzi <clizzi@redhat.com>, Alberto Ruiz <aruizrui@redhat.com>, 
	Enric Balletbo <eballetb@redhat.com>, Pengutronix Kernel Team <kernel@pengutronix.de>, imx@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 1, 2024 at 9:06=E2=80=AFAM Andrei Stefanescu
<andrei.stefanescu@oss.nxp.com> wrote:

> Andrei Stefanescu (7):
>   dt-bindings: mfd: add support for the NXP SIUL2 module
>   mfd: nxp-siul2: add support for NXP SIUL2
>   arm64: dts: s32g: make pinctrl part of mfd node
>   pinctrl: s32: convert the driver into an mfd cell
>   pinctrl: s32cc: change to "devm_pinctrl_register_and_init"
>   pinctrl: s32cc: add driver for GPIO functionality
>   MAINTAINERS: add MAINTAINER for NXP SIUL2 MFD driver

How do you want to merge this?

Can the MFD and pinctrl parts be merged separately, or shall
it all go into MFD or all into pinctrl?

I can certainly merge it if Lee ACKs the MFD patch.

Yours,
Linus Walleij

