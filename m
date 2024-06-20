Return-Path: <linux-kernel+bounces-222425-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BFC48910154
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 12:20:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A3FE281683
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 10:20:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B56131A8C38;
	Thu, 20 Jun 2024 10:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="UVWcf9U9"
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 388F61A8C05
	for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 10:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718878811; cv=none; b=DTcqDPj7CfEMlhgdaiMVYILFcFXjRf/Rv+xnI3/RBXjjWoXf33ThPQaUAUXfq4gMXvxlj2fiWtNmuur5pR17I54wOh+Ud15uVK4d4bWrU5Za+2o/E/BHsg19QlfdOrJ0ymLXW24uzkZyBeIXxdXvYZRrcS2Z5cM9lDjGT30fTJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718878811; c=relaxed/simple;
	bh=PP+mMEHHt5goP6yNje1ACtoEQu4E7NC1K1SIUJoccZo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mOq71KABYZfFni9sXlAzHFqdNivsNXL0rdO6hRiysfN3snaKdTejgCPeJ3a5D5t2cIKsWO5Kdq/osRtVm2snisNS8/omYb2mk6EQS2VSsGzQ3EisFTyWkcAicBz1NQc4Kh8iwxy2+bpnt1gM6YRQo4c5Fx2equMivJfhoLBoYP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=UVWcf9U9; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2ec002caeb3so8354601fa.2
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 03:20:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1718878807; x=1719483607; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kMQv+SI/kH2fj+sCWOpuzWhC+RAihSFQwyEfWFTRJ0E=;
        b=UVWcf9U971MfcIJwep941pIudFEw8+WAsZLJ3a9lx+d77Bw3gIuvcq3IQ2gmBgHIU3
         bePHneBbgFKv5F4YfnJH9pH49EHmGLcxlXXXDf9h267ndUpRs/LD+ov2gwTKstPHCjpH
         WAcWmgC+D9zR6wmi6knbgs2Ryim7x11w/lfog=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718878807; x=1719483607;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kMQv+SI/kH2fj+sCWOpuzWhC+RAihSFQwyEfWFTRJ0E=;
        b=qrvFharmRPxbrdtbigPujmdU53UfGjZ/B1J+dKctfCMiZD6GAPyESUUgB/RxqVLQ+J
         trnqz3FUr0e0MbvsiRp3f9hHixg1GQd2vHTpobveBf/F7DJooYnOop28Bq+xO8i7tsXJ
         AUqnz0dNC9vneQz37cABc/RtmcZHp2JLvpyh/zUJ+muir0RdOjDYj/6UdAU6eAwThBkV
         ASxcJ3rHdB6gDNsNQuq4HCrWaVl9UaThgv84pHNEQPVcDUYBp5+pbm9oQ4++6XrEa18i
         2OdW64RtYrm6tb4C1clDEbbr5UZxDVBW7xFQsOXCbDsTdzCRcExdV0XFZDjQAFIwS6xk
         XvcA==
X-Forwarded-Encrypted: i=1; AJvYcCXejwQrSwTXyBRaL+GGst+v3QIBL4DnpKta4Z5RnoYreUUWVLFmAIfCuz7hQwpVzqzWz7wj0XKar1fAKTdiRXQelnDVndbdjXRH9gPl
X-Gm-Message-State: AOJu0YyFxnw+OnxNDKM+VEiC6Tx6aqg3Uvxj1E9XVCTOItU6weiDSFIt
	hRfphjfXhUq6mjQS0KvJzDYTsEk0WQqgxtuy5cNINWhaHuTZSlErgAhGNBO+/ngY2qaB/j713oN
	l/F8FSqHg/xCtRpVGUm9FAVfYoWnMcMdasuea
X-Google-Smtp-Source: AGHT+IFzCFhLF+GpdQivYBjTN44c3awT7QjJvjvCa4N6HMck3/8WvClS9kMnKrGjmoVAcGvXMshNVwpxInBhTRdLn5g=
X-Received: by 2002:a2e:8811:0:b0:2eb:e9cf:e179 with SMTP id
 38308e7fff4ca-2ec3ce9419fmr34233601fa.21.1718878807358; Thu, 20 Jun 2024
 03:20:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240620101656.1096374-1-angelogioacchino.delregno@collabora.com> <20240620101656.1096374-3-angelogioacchino.delregno@collabora.com>
In-Reply-To: <20240620101656.1096374-3-angelogioacchino.delregno@collabora.com>
From: Chen-Yu Tsai <wenst@chromium.org>
Date: Thu, 20 Jun 2024 18:19:56 +0800
Message-ID: <CAGXv+5GLCrQzxGFSuReD77CLBa-w4=1So8qdbPm_1nohKOOnpw@mail.gmail.com>
Subject: Re: [PATCH 2/2] arm: dts: mediatek: Declare drive-strength numerically
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: linux-mediatek@lists.infradead.org, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, matthias.bgg@gmail.com, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	kernel@collabora.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 20, 2024 at 6:17=E2=80=AFPM AngeloGioacchino Del Regno
<angelogioacchino.delregno@collabora.com> wrote:
>
> On some devicetrees, the drive-strength property gets assigned a
> MTK_DRIVE_(x)_mA definition, which matches with (x).
>
> For example, MTK_DRIVE_8mA equals to 8 and MTK_DRIVE_30mA equals
> to 30.
>
> Also keeping in mind that the drive-strength property is, by
> (binding) definition, taking a number in milliamperes unit,
> change all devicetrees to avoid the usage of any MTK_DRIVE_(x)
> definition.
>
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@coll=
abora.com>

Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>

> ---
>  arch/arm/boot/dts/mediatek/mt2701-evb.dts |  2 +-
>  arch/arm/boot/dts/mediatek/mt7623.dtsi    | 18 +++++++++---------
>  2 files changed, 10 insertions(+), 10 deletions(-)
>
> diff --git a/arch/arm/boot/dts/mediatek/mt2701-evb.dts b/arch/arm/boot/dt=
s/mediatek/mt2701-evb.dts
> index 9c7325f18933..4c76366aa938 100644
> --- a/arch/arm/boot/dts/mediatek/mt2701-evb.dts
> +++ b/arch/arm/boot/dts/mediatek/mt2701-evb.dts
> @@ -231,7 +231,7 @@ pins1 {
>                                  <MT2701_PIN_238_EXT_SDIO1__FUNC_EXT_SDIO=
1>,
>                                  <MT2701_PIN_237_EXT_SDIO2__FUNC_EXT_SDIO=
2>,
>                                  <MT2701_PIN_236_EXT_SDIO3__FUNC_EXT_SDIO=
3>;
> -                       drive-strength =3D <MTK_DRIVE_4mA>;
> +                       drive-strength =3D <4>;
>                         bias-pull-up;
>                 };
>         };
> diff --git a/arch/arm/boot/dts/mediatek/mt7623.dtsi b/arch/arm/boot/dts/m=
ediatek/mt7623.dtsi
> index f0b4a09004b3..814586abc297 100644
> --- a/arch/arm/boot/dts/mediatek/mt7623.dtsi
> +++ b/arch/arm/boot/dts/mediatek/mt7623.dtsi
> @@ -1143,13 +1143,13 @@ pins-cmd-dat {
>                                  <MT7623_PIN_121_MSDC0_DAT0_FUNC_MSDC0_DA=
T0>,
>                                  <MT7623_PIN_116_MSDC0_CMD_FUNC_MSDC0_CMD=
>;
>                         input-enable;
> -                       drive-strength =3D <MTK_DRIVE_2mA>;
> +                       drive-strength =3D <2>;
>                         bias-pull-up =3D <MTK_PUPD_SET_R1R0_01>;
>                 };
>
>                 pins-clk {
>                         pinmux =3D <MT7623_PIN_117_MSDC0_CLK_FUNC_MSDC0_C=
LK>;
> -                       drive-strength =3D <MTK_DRIVE_2mA>;
> +                       drive-strength =3D <2>;
>                         bias-pull-down =3D <MTK_PUPD_SET_R1R0_01>;
>                 };
>
> @@ -1167,14 +1167,14 @@ pins-cmd-dat {
>                                  <MT7623_PIN_110_MSDC1_DAT3_FUNC_MSDC1_DA=
T3>,
>                                  <MT7623_PIN_105_MSDC1_CMD_FUNC_MSDC1_CMD=
>;
>                         input-enable;
> -                       drive-strength =3D <MTK_DRIVE_4mA>;
> +                       drive-strength =3D <4>;
>                         bias-pull-up =3D <MTK_PUPD_SET_R1R0_10>;
>                 };
>
>                 pins-clk {
>                         pinmux =3D <MT7623_PIN_106_MSDC1_CLK_FUNC_MSDC1_C=
LK>;
>                         bias-pull-down;
> -                       drive-strength =3D <MTK_DRIVE_4mA>;
> +                       drive-strength =3D <4>;
>                 };
>
>                 pins-wp {
> @@ -1197,13 +1197,13 @@ pins-cmd-dat {
>                                  <MT7623_PIN_110_MSDC1_DAT3_FUNC_MSDC1_DA=
T3>,
>                                  <MT7623_PIN_105_MSDC1_CMD_FUNC_MSDC1_CMD=
>;
>                         input-enable;
> -                       drive-strength =3D <MTK_DRIVE_4mA>;
> +                       drive-strength =3D <4>;
>                         bias-pull-up =3D <MTK_PUPD_SET_R1R0_10>;
>                 };
>
>                 pins-clk {
>                         pinmux =3D <MT7623_PIN_106_MSDC1_CLK_FUNC_MSDC1_C=
LK>;
> -                       drive-strength =3D <MTK_DRIVE_4mA>;
> +                       drive-strength =3D <4>;
>                         bias-pull-down =3D <MTK_PUPD_SET_R1R0_10>;
>                 };
>         };
> @@ -1211,7 +1211,7 @@ pins-clk {
>         nand_pins_default: nanddefault {
>                 pins-ale {
>                         pinmux =3D <MT7623_PIN_116_MSDC0_CMD_FUNC_NALE>;
> -                       drive-strength =3D <MTK_DRIVE_8mA>;
> +                       drive-strength =3D <8>;
>                         bias-pull-down =3D <MTK_PUPD_SET_R1R0_10>;
>                 };
>
> @@ -1226,13 +1226,13 @@ pins-dat {
>                                  <MT7623_PIN_115_MSDC0_RSTB_FUNC_NLD8>,
>                                  <MT7623_PIN_119_MSDC0_DAT2_FUNC_NLD2>;
>                         input-enable;
> -                       drive-strength =3D <MTK_DRIVE_8mA>;
> +                       drive-strength =3D <8>;
>                         bias-pull-up;
>                 };
>
>                 pins-we {
>                         pinmux =3D <MT7623_PIN_117_MSDC0_CLK_FUNC_NWEB>;
> -                       drive-strength =3D <MTK_DRIVE_8mA>;
> +                       drive-strength =3D <8>;
>                         bias-pull-up =3D <MTK_PUPD_SET_R1R0_10>;
>                 };
>         };
> --
> 2.45.2
>
>

