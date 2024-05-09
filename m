Return-Path: <linux-kernel+bounces-174580-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A3BDA8C1118
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 16:16:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C730B1C20E0B
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 14:16:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2CA5148302;
	Thu,  9 May 2024 14:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gDNNyaEJ"
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 626B715E7F3;
	Thu,  9 May 2024 14:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715264188; cv=none; b=S6HRMuW7WU5ngdwR+xDWtCYN2Of1Auhf1t6IA8VEHR7dGncZsl4xDR2LS6VTg1n+yljqfXTNhl+aN76H/91QwNAeSRGPAqnKoqyegFAH2ouUHDCgVtCqMMwOf7L33r7beTsWjpbLxliPt+6NU7w5r7aH9ScwYl0Vqxfpgi3NWp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715264188; c=relaxed/simple;
	bh=ESg1b5jnmOUHRR27iy09hYLRMXOuFgdVdTlPqAUfp4E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QuEn1tGRTHZyknh/zdQPyOp3HBMhV4G3wsFGqhv0udJZ9vsrWCFRK/amt+8umtqzQkLo3d1GgRE+rsy7Z3c4de80OURPJRyxgTF1VWFBl20DkE/SFTYXwibJZDrMarvoqJdYrh1UkZr9scTBCqSKYjE0OjqCrGlErolWzai0B50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gDNNyaEJ; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a59c5c9c6aeso230740566b.2;
        Thu, 09 May 2024 07:16:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715264185; x=1715868985; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JuarBTe05a8SJXz+yxbrZY1b0TySGHncC7/ocSyGfDE=;
        b=gDNNyaEJahFdpylW9TzZCEY1dKK3+TnmxqWx6bhAYlVw7SghE8oKbZw/aJ06OUXEg5
         V9YcxZfVExFevn43MY3VUxsyQEueyrEkKYzap4MJAbNCtqrialRlKzYw695CDbSzPpPR
         KVFa1Y7UmMi+ChrpGEGRwHYXg+ic8NDkcwbRAKllzpZ1KzpZ1vqeQqof/1pQfeh7Lc/a
         hyMPYpsMSlRJ+You+hoVnH7PBV2H1iWYvWbxL32+Wmx/9yrtkqWDUITyk9Re/9FiK35A
         7ph2kIPQkcgWjh1MaYXfraOUuQ72y3VQZErXzsx9Y5K4XWhA0WPjFBgP2Hw3AM6Sf/n0
         6enQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715264185; x=1715868985;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JuarBTe05a8SJXz+yxbrZY1b0TySGHncC7/ocSyGfDE=;
        b=cBIoEpRhJaz6NWrz3h9xf2w8aoKVsKJmMGy2jXSK15R2YEA9BhEfGRS3QVXeu0I0kZ
         KRFYxxPpq6DZ1safD6egv2JcPVD5wpStZRUxnkzlgq9pH8aQXhkqjOTX9gxtpU8UnrZY
         Ifi8uqDEv2YxZ1a8ziUGcFt9q8+WCxd6lINhzMZ3XdlzuGfrqv3mgrjHuzrBXKtiXlmj
         ImHBy9hUan94aJSxQcuoXPFJ3AUDEtKhyD20lDUkCMoFgFyTksuLOg6kXpN+jcumtNTh
         /vD5gHPms1LL58QJOJ6Or57eJcl8kdkQz5jC8g47n/tirqahJLGx87mq9tzeNlSrQLKF
         YkZw==
X-Forwarded-Encrypted: i=1; AJvYcCWJZgnhbGFhe3YWm+ZbMCPd8sy0S/j3+ttbK5WSk9D5fjKENZ3VFKteWtb7GjmFvfFugnDrD/LHAPQxkqxX16P+JG1/826Fg5xTVgoeL1MdznVjUtZs14jj0C3cCeo/lmRywF1Fi2zpVg==
X-Gm-Message-State: AOJu0YxhLzg2FJnskN9W3rFuJlU3nssUZskgaiZqcK91x77GREJ2zkLX
	XOwEh+jE4cIZEVYCiiMvyiAP5/EtjuoMUm2OdAyyL3zXKFug5iw0JzDlqIPztAgIDjtJskx9ybu
	6QPoJJz4VLcm7yjfK7u1lC6fm32Z81o1f
X-Google-Smtp-Source: AGHT+IHEaL0zNvf/wgfMz36U5EILzloZVUXfcXUHz3D2htjZ3euaCHd0ROhVyTfoIaJnj4SE31TR55hSPLMLzD/lDKg=
X-Received: by 2002:a17:906:4756:b0:a59:cb29:3fac with SMTP id
 a640c23a62f3a-a59fb9f1043mr357282066b.65.1715264184620; Thu, 09 May 2024
 07:16:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1715231698-451-1-git-send-email-shengjiu.wang@nxp.com> <1715231698-451-3-git-send-email-shengjiu.wang@nxp.com>
In-Reply-To: <1715231698-451-3-git-send-email-shengjiu.wang@nxp.com>
From: Daniel Baluta <daniel.baluta@gmail.com>
Date: Thu, 9 May 2024 17:16:11 +0300
Message-ID: <CAEnQRZDoiVSD+CQoS6kcmTVbacDU=Ct3SJe5__Z5JBPAofeVrw@mail.gmail.com>
Subject: Re: [PATCH 2/2] arm64: dts: imx8mp-evk: add bt-sco sound card support
To: Shengjiu Wang <shengjiu.wang@nxp.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de, 
	festevam@gmail.com, devicetree@vger.kernel.org, imx@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	shengjiu.wang@gmail.com, Daniel Baluta <daniel.baluta@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 9, 2024 at 8:37=E2=80=AFAM Shengjiu Wang <shengjiu.wang@nxp.com=
> wrote:
>
> Add bt-sco sound card, which is used by BT HFP case.
> It supports wb profile as default
>
> Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>

Reviewed-by: Daniel Baluta <daniel.baluta@nxp.com>


> ---
>  arch/arm64/boot/dts/freescale/imx8mp-evk.dts | 44 ++++++++++++++++++++
>  1 file changed, 44 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/freescale/imx8mp-evk.dts b/arch/arm64/bo=
ot/dts/freescale/imx8mp-evk.dts
> index 8be5b2a57f27..b2225cb710b6 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mp-evk.dts
> +++ b/arch/arm64/boot/dts/freescale/imx8mp-evk.dts
> @@ -114,6 +114,11 @@ reg_vext_3v3: regulator-vext-3v3 {
>                 regulator-max-microvolt =3D <3300000>;
>         };
>
> +       audio_codec_bt_sco: audio-codec-bt-sco {
> +               compatible =3D "linux,bt-sco";
> +               #sound-dai-cells =3D <1>;
> +       };
> +
>         sound {
>                 compatible =3D "simple-audio-card";
>                 simple-audio-card,name =3D "wm8960-audio";
> @@ -145,6 +150,25 @@ simple-audio-card,codec {
>
>         };
>
> +       sound-bt-sco {
> +               compatible =3D "simple-audio-card";
> +               simple-audio-card,name =3D "bt-sco-audio";
> +               simple-audio-card,format =3D "dsp_a";
> +               simple-audio-card,bitclock-inversion;
> +               simple-audio-card,frame-master =3D <&btcpu>;
> +               simple-audio-card,bitclock-master =3D <&btcpu>;
> +
> +               btcpu: simple-audio-card,cpu {
> +                       sound-dai =3D <&sai2>;
> +                       dai-tdm-slot-num =3D <2>;
> +                       dai-tdm-slot-width =3D <16>;
> +               };
> +
> +               simple-audio-card,codec {
> +                       sound-dai =3D <&audio_codec_bt_sco 1>;
> +               };
> +       };
> +
>         sound-hdmi {
>                 compatible =3D "fsl,imx-audio-hdmi";
>                 model =3D "audio-hdmi";
> @@ -608,6 +632,17 @@ &pwm4 {
>         status =3D "okay";
>  };
>
> +&sai2 {
> +       #sound-dai-cells =3D <0>;
> +       pinctrl-names =3D "default";
> +       pinctrl-0 =3D <&pinctrl_sai2>;
> +       assigned-clocks =3D <&clk IMX8MP_CLK_SAI2>;
> +       assigned-clock-parents =3D <&clk IMX8MP_AUDIO_PLL1_OUT>;
> +       assigned-clock-rates =3D <12288000>;
> +       fsl,sai-mclk-direction-output;
> +       status =3D "okay";
> +};
> +
>  &sai3 {
>         pinctrl-names =3D "default";
>         pinctrl-0 =3D <&pinctrl_sai3>;
> @@ -880,6 +915,15 @@ MX8MP_IOMUXC_UART3_TXD__UART1_DCE_RTS      0x140
>                 >;
>         };
>
> +       pinctrl_sai2: sai2grp {
> +               fsl,pins =3D <
> +                       MX8MP_IOMUXC_SAI2_TXC__AUDIOMIX_SAI2_TX_BCLK    0=
xd6
> +                       MX8MP_IOMUXC_SAI2_TXFS__AUDIOMIX_SAI2_TX_SYNC   0=
xd6
> +                       MX8MP_IOMUXC_SAI2_TXD0__AUDIOMIX_SAI2_TX_DATA00 0=
xd6
> +                       MX8MP_IOMUXC_SAI2_RXD0__AUDIOMIX_SAI2_RX_DATA00 0=
xd6
> +               >;
> +       };
> +
>         pinctrl_sai3: sai3grp {
>                 fsl,pins =3D <
>                         MX8MP_IOMUXC_SAI3_TXFS__AUDIOMIX_SAI3_TX_SYNC   0=
xd6
> --
> 2.34.1
>
>

