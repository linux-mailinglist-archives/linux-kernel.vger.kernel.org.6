Return-Path: <linux-kernel+bounces-309825-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08B769670C2
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Aug 2024 12:16:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B444F28442B
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Aug 2024 10:16:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69FBD17B427;
	Sat, 31 Aug 2024 10:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="Ui2YKOmr"
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D68E416F0CA
	for <linux-kernel@vger.kernel.org>; Sat, 31 Aug 2024 10:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725099373; cv=none; b=KTIPiV5SjDE08jyaU5XUQ0DqeLLn2UazQXfi5ukJg7G4jIFYkvuPQFIZ4YZqh2BZrpMYdKGZnC/D558wk5ZQSksZmpyr+15DOmHoZAks32IIzrdK+RxV2vx/WpRX/9rJ+2AwndtrFGwJx8OM55pYq/4W3jtcC5JlrzXlctTtqWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725099373; c=relaxed/simple;
	bh=7PxAHyswZLjCEcDDdIaCvCLTaRGZ61BCN7GeRk75FeI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NemTxmpYKX4OJc/r0CGJ1Cz0dPFJRXqiiR5uSha8JPqEssJKFRKGm+mO/zLq3y4qUk1Hi4DYDiRjxPKvDWGDfUAOWLesLCdug6PEi0xm+hKaV8s3iBMyef9IvqnrNlIB/rAAlcPirEr01uVPZ8fBJ2JGjnXy7obJ4DBYKdO52gw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com; spf=pass smtp.mailfrom=amarulasolutions.com; dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b=Ui2YKOmr; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amarulasolutions.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a868d7f92feso304506066b.2
        for <linux-kernel@vger.kernel.org>; Sat, 31 Aug 2024 03:16:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1725099369; x=1725704169; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xEegHeLswHgSFD60AbReMGvZ27oxPCuhcc/xuWI/93U=;
        b=Ui2YKOmr9YcN04xEWu9Hwe/UBoUgyWojeatfuyY7cCvlqZ6vEmPGwNCICEhoj7zUzG
         K03yF2CIY7km/595vkJxbVtHvtuVDQyINjh9Jy790JylSlNvS0h/Hl+RVdLjaaD2B15D
         ynhFYKURiHUksMONCAkUH3QZxf7y5bUrbh6Go=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725099369; x=1725704169;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xEegHeLswHgSFD60AbReMGvZ27oxPCuhcc/xuWI/93U=;
        b=QBic35yfJhwxIuMN1009hO0+KXuwiSB3mld6/vYtiAC6jLvXytAVB0RnBDNcc8pozS
         oIKAbxuTxI0iXvwEMj7ovc8Wvb/P7byMN5mMSPWiabZyx1EnsEHZ2DdgDxnFHBUo5Ric
         Itz1d7T28UyjceDDvEmfyFevN3bh/oMnnZjTjxAmbtLJrQ5O4bnD3LkVnJugZ0aj3/IS
         WF7LnTem5wm618CB5SPznqRjtmRv4bh6XWx9qNYNKBH0hL9p/oDfi16gZTZbXvFslu+E
         Xn7cgbZ48UgVLGrLjk+xhEbeZjz6j85JvyV89+wZGqCRzQeyMAT4meIk9A7ay6Iv3yXE
         K9mg==
X-Forwarded-Encrypted: i=1; AJvYcCXgpwpURlPUxMy3Ux8yCO7xTxysboQhrYK+/zi2L83pDL0vyX4j/evgPsM12rKxr1IbTs+SdvmB528IIwc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzDWitYqxg/pJoDAUBt9vGt2aFS5N8mk9SxZfjgVE6aPvGGxUsD
	u1TPqXqqVKUHuNSPRboXdG9Ts3Jl0ErdNQCtI7afrL15KPaiHxHJBe6HL37fx0FdAWHoppP14Qu
	mzG3ACXrwmhMbrKij1XkwqmbYL5j7LxwFrwReiQ==
X-Google-Smtp-Source: AGHT+IEljKe8Ivg1opymQ8s5TmiI5igE90nWvac0fE5HAogxs6IEzVOg+qUSFUw6dqnweZ0GuJo22CElxQCvmh+Yss4=
X-Received: by 2002:a17:906:d542:b0:a86:af10:6a47 with SMTP id
 a640c23a62f3a-a897fad60e1mr629129166b.60.1725099368529; Sat, 31 Aug 2024
 03:16:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240831101129.15640-1-krzysztof.kozlowski@linaro.org>
In-Reply-To: <20240831101129.15640-1-krzysztof.kozlowski@linaro.org>
From: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Date: Sat, 31 Aug 2024 12:15:56 +0200
Message-ID: <CAOf5uwk+40-qQdVYcqkEOKUdmn1UZcL2BCG_Pdd_8rphc94JWw@mail.gmail.com>
Subject: Re: [PATCH 1/2] ARM: dts: imx6ul-geam: fix fsl,pins property in
 tscgrp pinctrl
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
	Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>, 
	Fabio Estevam <festevam@gmail.com>, Matteo Lisi <matteo.lisi@engicam.com>, 
	Jagan Teki <jagan@amarulasolutions.com>, Parthiban Nallathambi <parthiban@linumiz.com>, 
	devicetree@vger.kernel.org, imx@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

HI

On Sat, Aug 31, 2024 at 12:11=E2=80=AFPM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> The property is "fsl,pins", not "fsl,pin".  Wrong property means the pin
> configuration was not applied.  Fixes dtbs_check warnings:
>
>   imx6ul-geam.dtb: pinctrl@20e0000: tscgrp: 'fsl,pins' is a required prop=
erty
>   imx6ul-geam.dtb: pinctrl@20e0000: tscgrp: 'fsl,pin' does not match any =
of the regexes: 'pinctrl-[0-9]+'
>
> Cc: <stable@vger.kernel.org>
> Fixes: a58e4e608bc8 ("ARM: dts: imx6ul-geam: Add Engicam IMX6UL GEA M6UL =
initial support")
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  arch/arm/boot/dts/nxp/imx/imx6ul-geam.dts | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/arm/boot/dts/nxp/imx/imx6ul-geam.dts b/arch/arm/boot/dt=
s/nxp/imx/imx6ul-geam.dts
> index cdbb8c435cd6..601d89b904cd 100644
> --- a/arch/arm/boot/dts/nxp/imx/imx6ul-geam.dts
> +++ b/arch/arm/boot/dts/nxp/imx/imx6ul-geam.dts
> @@ -365,7 +365,7 @@ MX6UL_PAD_ENET1_RX_ER__PWM8_OUT   0x110b0
>         };
>
>         pinctrl_tsc: tscgrp {
> -               fsl,pin =3D <
> +               fsl,pins =3D <
>                         MX6UL_PAD_GPIO1_IO01__GPIO1_IO01        0xb0
>                         MX6UL_PAD_GPIO1_IO02__GPIO1_IO02        0xb0
>                         MX6UL_PAD_GPIO1_IO03__GPIO1_IO03        0xb0
> --
> 2.43.0
>

Reviewed-by: Michael Trimarchi <michael@amarulasolutions.com>

Thank you
Michael

