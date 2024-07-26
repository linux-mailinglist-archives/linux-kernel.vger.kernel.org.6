Return-Path: <linux-kernel+bounces-262814-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5792393CD0C
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 05:42:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7BC8C1C20FB0
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 03:42:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADD3324B26;
	Fri, 26 Jul 2024 03:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dTYfQd/d"
Received: from mail-il1-f178.google.com (mail-il1-f178.google.com [209.85.166.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D859ED8;
	Fri, 26 Jul 2024 03:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721965354; cv=none; b=mHe40cyDKdPP1ZsFpabS2T9zV2eTvVXUyGKrUJsxrJkVf0y+4yq70xPHpHT+98ntQqOxSkpgIM4/1MAI0IaEjheoIzMzTkF1c8nbI7QyyjXsGwnLlVF6MSqWoxxUvMZMcVb+AzQ2LqflYqGzyn9G3+HZpzdtD5fiDw0I0ksfU6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721965354; c=relaxed/simple;
	bh=7wMNObpjfTSN51lD4C+CqYqPfzylmmrtRYUnxMbdCxE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DjCkSu3DXZFi09szu3PMkdDPkd79DeDngLEBUJv+BLplvL/jxyuYjcIpCinIbtMSsA5KkdojU/Ur7BlBdRom9CSYomgPf7kttAyNAHEbP+mu09Ip8g3ebz5NnD66sxnbHYvsVm7MOOlFAft/OTWCcJATQO6TFhotGP+yYgnHot0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dTYfQd/d; arc=none smtp.client-ip=209.85.166.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f178.google.com with SMTP id e9e14a558f8ab-3970f9331deso5621885ab.2;
        Thu, 25 Jul 2024 20:42:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721965352; x=1722570152; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A7PkbKxzE54lmr0LCOjwbWnHM/YynvOstwGccHNVI58=;
        b=dTYfQd/dKS/btj3LeaF7/mMj9UI9gVA4mT96ZnTgCcBOVt7zbolDHgFy1qjz4HJyxx
         SEO7OfzZunaYPf0KFuuEgrqpA8lpESJEOK2A96geyqzI+eEh9GCc1abILJA2iAgSBaX1
         fWTGFDWwyUWFzowFAxE+vgNqEdsPvfQwPSHLDF/NuAD1LActGukYJ9GJoV/xIn/zamgr
         fQXSy54DroyEz1pXfT02CTTPnOkold5NgWbblJNwbMr1XahKdM6MHQ1qHmBwTWivMKwN
         wnK7eWOLWQHBLHoPDm5tG1OfpAaP2/anlWHEA2sJI4ffFUD3UpkE1CF+sPKkzZYQSu9v
         QQUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721965352; x=1722570152;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A7PkbKxzE54lmr0LCOjwbWnHM/YynvOstwGccHNVI58=;
        b=qGKjccqjI2ufLviBsyxbv5qwNT9rs/PQR1fm0HUl+gUIL3PGLNhbKrVy4HpwCHT2LJ
         z9IsGNFgBJJ1CJXc0pswcaZIMtWtmEepMyypnh0jEKx03/HFC0lCxEb2S4R3xAMVElty
         6s1KX2JfEf4v4PQr/3yGSRwYWnGRaIMIafLOEnnkKoMP/rZdOZlxZ5+3stF6xmqCDv9/
         zbX/HJ3ez80B9tCKEqgTb+WnsSof5rFH9jF2JOD728RfotyhDu4fcjEpP0dzp3hRz/qz
         jO92rcprNRePkW2JEWAeyzMacmCBZM9ldrPV1EEY0AF8K3D52vjzU9JqEuvJJCcm3nVH
         mcEg==
X-Forwarded-Encrypted: i=1; AJvYcCUgGV7ZPgJUDEeN7W3KDl7F2tTpPHprLFlSU27l58eYHhx+2wRPPS+z9Qx+LTeSLB5tNNpo/7Wd6hsrSGEt1JfWc/hA9PS83M+LCiUqP6EURRQcmaBAP5F4lJ7/ShY0C/9mg9dhY3QRCQ==
X-Gm-Message-State: AOJu0YxeJQJk7yHcfdo4MAbRiOdC3TKJdJmnfiaKq05mklvxFNE/Urav
	8g9DZp2jOF2e/U3Fd/FYL5cSWa5aRLU97PIEeWCcIgbDqnAnb3cPQoUa+bofSWnregh1bYTyxMA
	JHUu2h9bJTbKqh+nKJsi1aonPNKA=
X-Google-Smtp-Source: AGHT+IHIAh3YmIenNsZW01plMaPsQ64x57/5R+OeUm2N86CIaUA0Fwx/iH/fj2NwDe6TP3ufKDGf/j6BRC/KV+Fam5U=
X-Received: by 2002:a05:6e02:1a6d:b0:39a:e776:6ce with SMTP id
 e9e14a558f8ab-39ae776082bmr5803265ab.22.1721965352359; Thu, 25 Jul 2024
 20:42:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1721897948-6306-1-git-send-email-shengjiu.wang@nxp.com>
 <1721897948-6306-2-git-send-email-shengjiu.wang@nxp.com> <e4ab2fc9-eac4-4ab7-9346-d4129fd778e6@linaro.org>
In-Reply-To: <e4ab2fc9-eac4-4ab7-9346-d4129fd778e6@linaro.org>
From: Shengjiu Wang <shengjiu.wang@gmail.com>
Date: Fri, 26 Jul 2024 11:42:21 +0800
Message-ID: <CAA+D8ANj0oond9bT0tv7DhBRpoXTEB95zMLALrLLZZZsw7sC=Q@mail.gmail.com>
Subject: Re: [PATCH 1/3] arm64: dts: imx93-11x11-evk: add bt-sco sound card support
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Shengjiu Wang <shengjiu.wang@nxp.com>, robh+dt@kernel.org, 
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, shawnguo@kernel.org, 
	s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com, 
	linux-imx@nxp.com, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 25, 2024 at 7:32=E2=80=AFPM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 25/07/2024 10:59, Shengjiu Wang wrote:
> > Add bt-sco sound card, which is used by BT HFP case.
> > It supports wb profile as default
>
> <form letter>
> Please use scripts/get_maintainers.pl to get a list of necessary people
> and lists to CC (and consider --no-git-fallback argument). It might
> happen, that command when run on an older kernel, gives you outdated
> entries. Therefore please be sure you base your patches on recent Linux
> kernel.
>
> Tools like b4 or scripts/get_maintainer.pl provide you proper list of
> people, so fix your workflow. Tools might also fail if you work on some
> ancient tree (don't, instead use mainline) or work on fork of kernel
> (don't, instead use mainline). Just use b4 and everything should be
> fine, although remember about `b4 prep --auto-to-cc` if you added new
> patches to the patchset.
> </form letter>

Sorry,  I don't get the point. I used the scripts/get_maintainer.pl to get
the list of people.   Anything wrong?

>
> >
> > Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> > ---
> >  .../boot/dts/freescale/imx93-11x11-evk.dts    | 54 +++++++++++++++++++
> >  1 file changed, 54 insertions(+)
> >
> > diff --git a/arch/arm64/boot/dts/freescale/imx93-11x11-evk.dts b/arch/a=
rm64/boot/dts/freescale/imx93-11x11-evk.dts
> > index a15987f49e8d..7ed75fb287df 100644
> > --- a/arch/arm64/boot/dts/freescale/imx93-11x11-evk.dts
> > +++ b/arch/arm64/boot/dts/freescale/imx93-11x11-evk.dts
> > @@ -80,6 +80,30 @@ reg_usdhc2_vmmc: regulator-usdhc2 {
> >               off-on-delay-us =3D <12000>;
> >               enable-active-high;
> >       };
> > +
> > +     bt_sco_codec: bt_sco_codec {
>
> No underscores, generic node names. Please follow DTS coding style.

Ok, will update it.
>
> > +             #sound-dai-cells =3D <1>;
>
> Order properties and nodes according to DTS coding style.

ok, will update it.

>
> > +             compatible =3D "linux,bt-sco";
> > +     };
> > +
> > +     sound-bt-sco {
>
> Why this is not "sound"?
>
> How many sound cards do you have there?

We will have 4 sound cards.

>
> > +             compatible =3D "simple-audio-card";
> > +             simple-audio-card,name =3D "bt-sco-audio";
> > +             simple-audio-card,format =3D "dsp_a";
> > +             simple-audio-card,bitclock-inversion;
> > +             simple-audio-card,frame-master =3D <&btcpu>;
> > +             simple-audio-card,bitclock-master =3D <&btcpu>;
> > +
> > +             btcpu: simple-audio-card,cpu {
> > +                     sound-dai =3D <&sai1>;
> > +                     dai-tdm-slot-num =3D <2>;
> > +                     dai-tdm-slot-width =3D <16>;
> > +             };
> > +
> > +             simple-audio-card,codec {
> > +                     sound-dai =3D <&bt_sco_codec 1>;
> > +             };
> > +     };
> >  };
> >
> >  &adc1 {
> > @@ -345,6 +369,18 @@ &mu2 {
> >       status =3D "okay";
> >  };
> >
> > +&sai1 {
> > +     #sound-dai-cells =3D <0>;
> > +     pinctrl-names =3D "default", "sleep";
> > +     pinctrl-0 =3D <&pinctrl_sai1>;
> > +     pinctrl-1 =3D <&pinctrl_sai1_sleep>;
> > +     assigned-clocks =3D <&clk IMX93_CLK_SAI1>;
> > +     assigned-clock-parents =3D <&clk IMX93_CLK_AUDIO_PLL>;
> > +     assigned-clock-rates =3D <12288000>;
> > +     fsl,sai-mclk-direction-output;
> > +     status =3D "okay";
> > +};
> > +
> >  &usbotg1 {
> >       dr_mode =3D "otg";
> >       hnp-disable;
> > @@ -528,6 +564,24 @@ MX93_PAD_CCM_CLKO2__GPIO3_IO27                   0=
x31e
> >               >;
> >       };
> >
> > +     pinctrl_sai1: sai1grp {
> > +             fsl,pins =3D <
> > +                     MX93_PAD_SAI1_TXC__SAI1_TX_BCLK                 0=
x31e
> > +                     MX93_PAD_SAI1_TXFS__SAI1_TX_SYNC                0=
x31e
> > +                     MX93_PAD_SAI1_TXD0__SAI1_TX_DATA00              0=
x31e
> > +                     MX93_PAD_SAI1_RXD0__SAI1_RX_DATA00              0=
x31e
> > +             >;
> > +     };
> > +
> > +     pinctrl_sai1_sleep: sai1grpsleep {
>
> Does not look like tested. Srsly, NXP, start doing basic tests before
> posting your code.

Did the test. but maybe my test method is not correct,  will double check.

Best regards
Shengjiu wang
>
> It does not look like you tested the DTS against bindings. Please run
> `make dtbs_check W=3D1` (see
> Documentation/devicetree/bindings/writing-schema.rst or
> https://www.linaro.org/blog/tips-and-tricks-for-validating-devicetree-sou=
rces-with-the-devicetree-schema/
> for instructions).
>
>
> Best regards,
> Krzysztof
>

