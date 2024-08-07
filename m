Return-Path: <linux-kernel+bounces-278413-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 448F294AFF3
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 20:43:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB5DD1F226D7
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 18:43:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E7821411EB;
	Wed,  7 Aug 2024 18:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fVbenao7"
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB4DA1097B;
	Wed,  7 Aug 2024 18:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723056182; cv=none; b=iwE+nMT+YVU/FYahU2EoMRpfDgGub4MQ/dSaRuzLYJwcfJ483ABBsJE5WzEtQW+cdyVkgxhy5Kbk1IbNmGGPTfxofF91tVW/1Mx2LK+DTl+2H4B0ezi7kCIA/2dRt0mxWIfRPjTa0Wx1aj8ajeeCIlcAks3+tIoHmyPDBLu+Kg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723056182; c=relaxed/simple;
	bh=pjQWUW7q5HQDIJGAFqqVY+CDA9M9vwP1peG/rZG94os=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BD2L2PLIpFG5OvFlpN+QSGeExREs/HghySFkfPk9P+VrSl3Zg5hiwjOUVM9s8MiCqqKl5TMbKMlo5bnMuAZdtywqLu5sdR5VEOwOPLIuQ5qJ9NZbOVcx0/Ep0Aa0+RSDADwHUCHL/VP8GzZ94NbThrtyCPPzrla9GRyWo3XZhDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fVbenao7; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2ef243cc250so174321fa.0;
        Wed, 07 Aug 2024 11:43:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723056179; x=1723660979; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vi22Z7/z7KGaeL5sryaJg6znudrYZaucY8JSso4zVMA=;
        b=fVbenao7NoWc5Bh/7tnthcMymzmmTLq12O8MVu5o7t5+t2pifgrTfY0GtzxZcZLvY6
         4RplJQYr96HQF59YPCL9Jc7cGOXKlCPe/MwSNVFjDUU4h3E6bi5gWC4nxu/C9wSZmNGd
         X+PuqxpVO7+Y/ggpdLdkvy/1jJsXwNE3uNMqs3o0trOSJudm9q9h1ETve2yUnChMUnig
         nYjf+i5e2VIgd6yNiC2VZWyH7sUnKMDdFyle4VeEmlcCJ0oOhuTXIGfCJHCEn/5ldsEz
         yj8IIiGUCMn5LgVVtA4g0Hqn9ORSXia8nNFFVuhWKsqOaBQ9nQkjxztS3ptnDyeqQCHn
         PYWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723056179; x=1723660979;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Vi22Z7/z7KGaeL5sryaJg6znudrYZaucY8JSso4zVMA=;
        b=Q8EvnTW4r4Hep6WOuH2ZiCUoAr3Y3tV4bfpEkzhX51a1sp/F3VBUYz0vCVUs+VEqK+
         e47WtWpIOMDjva9TD2fIdHZvjFyNfIxIJ1pJI6MPVIoUb8k+us6lqascHrynmsJH50Ha
         3Jfur1RxDETfL8wvGIq6/3xTUCqH3skW32U1Crwpb8o6hwe+5rLSi7XoOXql4YUmzbJH
         H+pUdEn8q5fZQIGZDI637j5EcMasiRxeTZmVP0MVWS4JGZwqQxgM1xc1LKW1o1c6fbrO
         ukMcCShybwa/2n6o+o2dlZZIkBm3cFtG+MDfPDWmzRVx/hDNwIDL2X4NiwmyNB8bWOOe
         c3iQ==
X-Forwarded-Encrypted: i=1; AJvYcCUPZ1ouIVw7/ozPxemq0pcKiKAV2EJCRRr0dOSvqNYnXA6u14ceS5KOmUS9x/6dlZxZOG5mK4icncXtzcQTsnjHyBoraUzBCEcRANrs53+71YAlSVFiIpOWKrezN+zEP2/Jc1K1ptqiFA==
X-Gm-Message-State: AOJu0YyXg8ALved6qqdamPBQk9L+svDpY2Kmq2//M8Cc0gSnvnHBuoGk
	O6y9ZtNuANIHEV7+JowRtCyqzWTvMK/mjAQaZRsvcZddn6mbxe8FUjQ5WQ/1QceJJIco08H9by/
	u8GczbYkqacvAW6TbDr1pu1FRE30=
X-Google-Smtp-Source: AGHT+IErDQ9+7pwORIsutODey2VWREwIo+wqFfhXfY42C+j14tgspSe8U5il7QB4nP2cMGLiMo1jeiIdsiqEcMuj4xI=
X-Received: by 2002:a05:6512:31c9:b0:52f:cad0:2d4a with SMTP id
 2adb3069b0e04-530bb3bdc62mr7540743e87.9.1723056178707; Wed, 07 Aug 2024
 11:42:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240807-fsl_dts_warning-v2-0-89e08c38831a@nxp.com> <20240807-fsl_dts_warning-v2-4-89e08c38831a@nxp.com>
In-Reply-To: <20240807-fsl_dts_warning-v2-4-89e08c38831a@nxp.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Wed, 7 Aug 2024 15:42:47 -0300
Message-ID: <CAOMZO5A3FKPurXZ6ZoUB7zzXBC5xRLEHPsTQ-hRyDs=g2ZaqUQ@mail.gmail.com>
Subject: Re: [PATCH v2 4/6] arm64: dts: imx8mp-data-modul-edm-sbc: remove
 #clock-cells for sai3
To: Frank Li <Frank.Li@nxp.com>, Marek Vasut <marex@denx.de>
Cc: Shawn Guo <shawnguo@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>, 
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, imx@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Adding Marek.

On Wed, Aug 7, 2024 at 11:52=E2=80=AFAM Frank Li <Frank.Li@nxp.com> wrote:
>
> Remove #clock-cells for sai3 because sai3 is not clock controller to fix
> below warning:
> /arch/arm64/boot/dts/freescale/imx8mp-data-modul-edm-sbc.dtb: sai@30c3000=
0: Unevaluated properties are not allowed ('#clock-cells' was unexpected)
>
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
>  arch/arm64/boot/dts/freescale/imx8mp-data-modul-edm-sbc.dts | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/arch/arm64/boot/dts/freescale/imx8mp-data-modul-edm-sbc.dts =
b/arch/arm64/boot/dts/freescale/imx8mp-data-modul-edm-sbc.dts
> index 7e1b58dbe23a7..837ea79741e8d 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mp-data-modul-edm-sbc.dts
> +++ b/arch/arm64/boot/dts/freescale/imx8mp-data-modul-edm-sbc.dts
> @@ -499,7 +499,6 @@ &pwm4 {
>  };
>
>  &sai3 {
> -       #clock-cells =3D <0>;
>         #sound-dai-cells =3D <0>;
>         assigned-clocks =3D <&clk IMX8MP_CLK_SAI3>;
>         assigned-clock-parents =3D <&clk IMX8MP_AUDIO_PLL1_OUT>;
>
> --
> 2.34.1
>

