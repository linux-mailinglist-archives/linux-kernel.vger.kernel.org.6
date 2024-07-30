Return-Path: <linux-kernel+bounces-267556-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED0649412C5
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 15:04:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A6C1F284F75
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 13:04:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC6B119FA86;
	Tue, 30 Jul 2024 13:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DSv5RWdJ"
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3ABF19F48D;
	Tue, 30 Jul 2024 13:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722344669; cv=none; b=NlsdH00r4VlNzfJqd2lzNGL6iBgPVlCqzX+BVoIRDguvtrGMj0Ub9nf/zDl5uVyuW+mamwC9uNZLla3dDCE5y50ihtL21NWLX+G/iyIhZPyWMMpXL2IOTrDzC5PBL4jUEVAWu84Xx8KpcBRF5p9ka+Y6Gtvk1ru1LBFBXh3Q6+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722344669; c=relaxed/simple;
	bh=o7jV0TsjHShHuJW+lvGQPrtCv1eUSRwbwdqYfZNvf5g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KYs4goctbnjXmqt0Om++8VY/g3r9vVrBl8t0D5sqYxGJMyIfdRMbbdIiaukwXFGin9jJ7g+SinSnGpeX628a1ugOmz06LD5kx4Zxez/LbN06n5n1mQGH1yooiUJ00wWAf4OpoDfTBhAli/sjC+u0azJ/HV1vv0vurDnj5VPllyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DSv5RWdJ; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-6bce380eb96so2590427a12.0;
        Tue, 30 Jul 2024 06:04:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722344667; x=1722949467; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HeccX9FlLPnJUb8SbtR469SLQigZSvmfeJTapPIcJEo=;
        b=DSv5RWdJp5O+Sm3J4jYd0I+JQmqhI1af3vvw/Z1ieFJAaZIrZ3dVj1Qvb4rb3Kpjyg
         Q0EkTeLNWpSjvkA90K1WNUrncpsJPz8Kf0bAx2tjizchK5qTb0bBK9XSHa68rdlSJAEw
         9OhTGl/0e8fmA5csdO8TdDBI7z9NaKuR4gDFf5W0nmS5PV5pho8HMrprSEwRCMDZEHWF
         ZprESS2rIpBucZgaMLltj/qxy+S7DezMFwPRDtQaj6WxzGBZ2i+RAzZzY9IHm/p/lbUW
         exFFCqm9TUbsazKUZ1NLLxO70yzwOryqc6ZP9bxogDoOkL7Ak4t3jkOjYmCJdpb3blPc
         V+kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722344667; x=1722949467;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HeccX9FlLPnJUb8SbtR469SLQigZSvmfeJTapPIcJEo=;
        b=BcMSgwuI5oI+gMVApbZzHxtCQ3ni3CKd3RtfpdRv6R89jvUUX6APNZ2qDPOcJiFBNg
         elCQ715PrfY1dRkg8xNz4yOj2ISL4L9w53TsRcaaY9PFnjBgGx6tnbKlfOyh19U+fwFo
         OVznG9Ux4DKItWZSs4WUTMDghJ+44wk2B1YmMvJg/ZFXdokPuKejUsVYO292SE0Gzr4Y
         iNAXUpD5Y0np2UOlNmj031hz0XT891LGBEAVxqxFJWiETnvPYOoe3ZRJJrX3VC/37V1L
         ONRBAJae4isxWxm8X+629qFGmtgKtasBb8r0Bz1N8zb90qrDiMd0Ztw2Ot2Lu3PAVyGg
         ZaOA==
X-Forwarded-Encrypted: i=1; AJvYcCXS5plI1CKjAVggqAIfs7hSG8h2MqX7A30Cc4lKKWhRK8bynbBYvX4i2JsgKcpicFaWmhMw0nFQoDubRzvjbVb4K9fUW2wMgXFro904gTuwqNw4lrwhbow6MyD015/zVYtxLANZnF8Z0g==
X-Gm-Message-State: AOJu0YyXuaPex+9GUXRo6ZgDh7vnvPts+xAydHejxiTr9hziNeESPv3n
	z7ca5STc6TuLi8Gv0MuAxmAmdd0vc2WUGIxWZq50sYLtIGbMh0IgWGuh61lnMrP/lsaODN/mwBm
	k3UBk0OlOxXVgHzMsNKoann/2WO0=
X-Google-Smtp-Source: AGHT+IHgcXQCsSqKIUHuUWZSHKpsG+ja+gPjqOUYutQQRnCj/8Yw7YUXnXOnDA1PxG+ZugQo8W1m/pNBPvI+7DKcWA0=
X-Received: by 2002:a17:90a:ac2:b0:2c9:5c67:dd9e with SMTP id
 98e67ed59e1d1-2cf7e1ff4e8mr8772739a91.19.1722344666339; Tue, 30 Jul 2024
 06:04:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240714172017.422811-1-aford173@gmail.com>
In-Reply-To: <20240714172017.422811-1-aford173@gmail.com>
From: Adam Ford <aford173@gmail.com>
Date: Tue, 30 Jul 2024 08:04:14 -0500
Message-ID: <CAHCN7x+_M6Mmo8OmvA4EWcWwtedSHB4uFT0+7n+s6iVK+dxrkw@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: imx8mp-beacon-kit: Fix Stereo Audio on WM8962
To: linux-arm-kernel@lists.infradead.org
Cc: aford@beaconembedded.com, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, 
	Lucas Stach <l.stach@pengutronix.de>, devicetree@vger.kernel.org, imx@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jul 14, 2024 at 12:20=E2=80=AFPM Adam Ford <aford173@gmail.com> wro=
te:
>
> The L/R clock needs to be controlled by the SAI3 instead of the
> CODEC to properly achieve stereo sound. Doing this allows removes
> the need for unnecessary clock manipulation to try to get the
> CODEC's clock in sync with the SAI3 clock, since the CODEC can cope
> with a wide variety of clock inputs.

Shawn,

Any chance this could get reviewed and/or applied?

thanks,

adam

>
> Fixes: 161af16c18f3 ("arm64: dts: imx8mp-beacon-kit: Fix audio_pll2 clock=
")
> Fixes: 69e2f37a6ddc ("arm64: dts: imx8mp-beacon-kit: Enable WM8962 Audio =
CODEC")
> Signed-off-by: Adam Ford <aford173@gmail.com>
>
> diff --git a/arch/arm64/boot/dts/freescale/imx8mp-beacon-kit.dts b/arch/a=
rm64/boot/dts/freescale/imx8mp-beacon-kit.dts
> index 1871c10f5c12..de5b64fa479a 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mp-beacon-kit.dts
> +++ b/arch/arm64/boot/dts/freescale/imx8mp-beacon-kit.dts
> @@ -222,13 +222,12 @@ sound-wm8962 {
>
>                 simple-audio-card,cpu {
>                         sound-dai =3D <&sai3>;
> +                       frame-master;
> +                       bitclock-master;
>                 };
>
>                 simple-audio-card,codec {
>                         sound-dai =3D <&wm8962>;
> -                       clocks =3D <&clk IMX8MP_CLK_IPP_DO_CLKO1>;
> -                       frame-master;
> -                       bitclock-master;
>                 };
>         };
>  };
> @@ -544,10 +543,9 @@ &pcie_phy {
>  &sai3 {
>         pinctrl-names =3D "default";
>         pinctrl-0 =3D <&pinctrl_sai3>;
> -       assigned-clocks =3D <&clk IMX8MP_CLK_SAI3>,
> -                         <&clk IMX8MP_AUDIO_PLL2> ;
> -       assigned-clock-parents =3D <&clk IMX8MP_AUDIO_PLL2_OUT>;
> -       assigned-clock-rates =3D <12288000>, <361267200>;
> +       assigned-clocks =3D <&clk IMX8MP_CLK_SAI3>;
> +       assigned-clock-parents =3D <&clk IMX8MP_AUDIO_PLL1_OUT>;
> +       assigned-clock-rates =3D <12288000>;
>         fsl,sai-mclk-direction-output;
>         status =3D "okay";
>  };
> --
> 2.43.0
>

