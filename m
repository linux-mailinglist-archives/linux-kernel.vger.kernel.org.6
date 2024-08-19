Return-Path: <linux-kernel+bounces-292631-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E0B9957215
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 19:24:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 534DF1C225E9
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 17:24:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A5A9184535;
	Mon, 19 Aug 2024 17:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="joDu3RFP"
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A08D216A934;
	Mon, 19 Aug 2024 17:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724088250; cv=none; b=IcB964+wUIro1mX1wkEn+H4Koa4jcGmh/JRMqFqGls6jCmMymWi7DwzeT5T0zH/kkPKe+fR+4A3L631sBDubWGyKhnso3q+PC5MpKpamUbnSU3aDudmgcQKq5BiCRszPg76lRir4KPZeNagYYFeD0WlUsWOWMnvk/GzDNKmMGrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724088250; c=relaxed/simple;
	bh=h5Ik+4GPsKEsUFyv/+ngVFo1vuM4D3ux3Z41/ZHTSlI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rlvISNw1CUIgRkLCxjOS9jk91OC6faeZJO7Hq1hhW+vuTuGe+pmeLh4zs0tEx1WHOKpMrJUPe7RzaL1xqYtTLCrOq03SoxiUPB/mquIxonLnVWMiw+f7KTxIT88A3TsLOpIL2DJurVGY3GK3NCm7tqGIW2FJjTmedl2VBiHAKxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=joDu3RFP; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2f381da27bcso3469191fa.3;
        Mon, 19 Aug 2024 10:24:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724088247; x=1724693047; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tA3DbE0eIgB/krXWiVQLA/SM1DVu9kNL0tSxYAoSxNc=;
        b=joDu3RFPWGHZa8fnVoj6znCP+Xx/zN2XTizprG6ugz7cqry/CrJ661VXNcNqpXxJIK
         9wK3vCcJHA+rGqz3EW8sRmp1XtbvgFxE1MY0EZyh1HrtYJvkNomBNd9I2JSwOYR077Ed
         h0cvaARGKNf3WMukoaU/a7B5jdfX+l7shYlwdpDLztKUPMHQikRmdC823gz1fSSp5RLz
         6/v7Abt5TvK2mOjWcP21UXDtf4xuu7w8b1cq+H7h9ZQXBbWrxWP1CMKdtAQNuY5u3cb4
         tjJzWAG7tSee0XM6iBA51hRBatE3P4r56ZQpSeRvzArgniAOeOrWIi+E9LfKO1FYjf6A
         iuNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724088247; x=1724693047;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tA3DbE0eIgB/krXWiVQLA/SM1DVu9kNL0tSxYAoSxNc=;
        b=ZvI2APf9MhoJyJtHcugWnYZWZUgfxlT6m1/nPRIDBjISfUjKWn3yYzrmAqA71UhLUu
         a3gU/qBJnvdJAeQ4As0g2PiQ/NWOaXORqAu3YUJLOafzAN1b9TUXaxD3zKz5Yd+JbBxp
         i/MM/+vBVZkrjovIxw1TL/rdEoabqfzGQpDyTe8ZTc5qVQS/48KNN12hVd7n5xbT7EdI
         SthW09mLP/dkR8X17CL88TvQh/lA1jWUILGKegRS+6SLVdUqLBZ20yPtF9RoMRMyAJhm
         gWd0vZ32rQHfrC3L5YZJmfD7DSFRBuH4Jt/Be08gd9NHiE4WOYYYGe/2cJFdcN310tHT
         eb0g==
X-Forwarded-Encrypted: i=1; AJvYcCXXY2e/900hIJcY+TTdm7ngjyuPsv4HuTe5RZoHQaTirqAj4QR1waqFZ0YpXZ1ht/ahoaBddl0x/vfKR1Klm8Z5sS9V7ktHXGG+WuiVHBKUwLhLAgDp2ECsI4iPGFU/tT9LyXYom7PvMA==
X-Gm-Message-State: AOJu0YwxXe0s9TvgifYgidTqBodCUJ8NiEuQgr+RNzeccBH7nPRwErVA
	4q7GrGLZxhz7pnQWGA+7pwXQrHNNzu39fItjbWXHh40BZtXeVjbDeBBf+IT/mMsE3UCVXSwxNp+
	tuY5Qh4hke/gy2lRXkLoyBmzOr8M=
X-Google-Smtp-Source: AGHT+IGr/XQMgMzcp6jgW0glG/inQWx5ioDh8iHJ7/a0zz1Ff0cyAn5p6R1jdxyTyikNRSSeG19EhIpsXqgXc0tDdN8=
X-Received: by 2002:a05:651c:198e:b0:2ef:17df:62f9 with SMTP id
 38308e7fff4ca-2f3be608217mr49111421fa.7.1724088246308; Mon, 19 Aug 2024
 10:24:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240819-imx_warning-v2-0-4c428bd11160@nxp.com> <20240819-imx_warning-v2-12-4c428bd11160@nxp.com>
In-Reply-To: <20240819-imx_warning-v2-12-4c428bd11160@nxp.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Mon, 19 Aug 2024 14:23:55 -0300
Message-ID: <CAOMZO5C_uvmuf-+QGH4E2X=Jei81a--N5wC83V-URPkXj-q7hw@mail.gmail.com>
Subject: Re: [PATCH v2 12/12] arm64: dts: imx8mm-beacon-kit: add DVDD-supply
 and DOVDD-supply
To: Frank Li <Frank.Li@nxp.com>, Adam Ford <aford173@gmail.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
	Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>, 
	Gregor Herburger <gregor.herburger@ew.tq-group.com>, 
	Alexander Stein <alexander.stein@ew.tq-group.com>, devicetree@vger.kernel.org, 
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux@ew.tq-group.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Adding Adam.

On Mon, Aug 19, 2024 at 2:03=E2=80=AFPM Frank Li <Frank.Li@nxp.com> wrote:
>
> According to binding doc, DVDD-supply and DOVDD-supply is required
> properties. Add these to fix below warning:
> arch/arm64/boot/dts/freescale/imx8mm-beacon-kit.dtb: camera@10: 'DVDD-sup=
ply' is a required proper
>
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
>  .../boot/dts/freescale/imx8mm-beacon-baseboard.dtsi      | 16 ++++++++++=
++++++
>  .../boot/dts/freescale/imx8mn-beacon-baseboard.dtsi      | 16 ++++++++++=
++++++
>  2 files changed, 32 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/freescale/imx8mm-beacon-baseboard.dtsi b=
/arch/arm64/boot/dts/freescale/imx8mm-beacon-baseboard.dtsi
> index 6086dae2e5fbe..ea1d5b9c6bae0 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mm-beacon-baseboard.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx8mm-beacon-baseboard.dtsi
> @@ -56,6 +56,20 @@ pcie0_refclk_gated:  pcie0-refclk-gated {
>                 enable-gpios =3D <&pca6416_1 2 GPIO_ACTIVE_LOW>;
>         };
>
> +       reg_1v5: regulator-1v5 {
> +               compatible =3D "regulator-fixed";
> +               regulator-name =3D "1V5";
> +               regulator-min-microvolt =3D <1500000>;
> +               regulator-max-microvolt =3D <1500000>;
> +       };
> +
> +       reg_1v8: regulator-1v8 {
> +               compatible =3D "regulator-fixed";
> +               regulator-name =3D "1V8";
> +               regulator-min-microvolt =3D <1800000>;
> +               regulator-max-microvolt =3D <1800000>;
> +       };
> +
>         reg_audio: regulator-audio {
>                 compatible =3D "regulator-fixed";
>                 regulator-name =3D "3v3_aud";
> @@ -187,6 +201,8 @@ camera@10 {
>                 assigned-clock-parents =3D <&clk IMX8MM_CLK_24M>;
>                 assigned-clock-rates =3D <24000000>;
>                 AVDD-supply =3D <&reg_camera>;  /* 2.8v */
> +               DVDD-supply =3D <&reg_1v5>;
> +               DOVDD-supply =3D <&reg_1v8>;
>                 powerdown-gpios =3D <&gpio1 7 GPIO_ACTIVE_HIGH>;
>                 reset-gpios =3D <&gpio1 6 GPIO_ACTIVE_LOW>;
>
> diff --git a/arch/arm64/boot/dts/freescale/imx8mn-beacon-baseboard.dtsi b=
/arch/arm64/boot/dts/freescale/imx8mn-beacon-baseboard.dtsi
> index 20018ee2c803e..77d14ea459e57 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mn-beacon-baseboard.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx8mn-beacon-baseboard.dtsi
> @@ -40,6 +40,20 @@ led-3 {
>                 };
>         };
>
> +       reg_1v5: regulator-1v5 {
> +               compatible =3D "regulator-fixed";
> +               regulator-name =3D "1V5";
> +               regulator-min-microvolt =3D <1500000>;
> +               regulator-max-microvolt =3D <1500000>;
> +       };
> +
> +       reg_1v8: regulator-1v8 {
> +               compatible =3D "regulator-fixed";
> +               regulator-name =3D "1V8";
> +               regulator-min-microvolt =3D <1800000>;
> +               regulator-max-microvolt =3D <1800000>;
> +       };
> +
>         reg_audio: regulator-audio {
>                 compatible =3D "regulator-fixed";
>                 regulator-name =3D "3v3_aud";
> @@ -158,6 +172,8 @@ camera@10 {
>                 assigned-clock-parents =3D <&clk IMX8MN_CLK_24M>;
>                 assigned-clock-rates =3D <24000000>;
>                 AVDD-supply =3D <&reg_camera>;  /* 2.8v */
> +               DVDD-supply =3D <&reg_1v5>;
> +               DOVDD-supply =3D <&reg_1v8>;
>                 powerdown-gpios =3D <&gpio1 7 GPIO_ACTIVE_HIGH>;
>                 reset-gpios =3D <&gpio1 6 GPIO_ACTIVE_LOW>;
>
>
> --
> 2.34.1
>

