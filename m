Return-Path: <linux-kernel+bounces-292665-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F249A957287
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 19:57:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 224BD1C23058
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 17:57:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3358F188CBE;
	Mon, 19 Aug 2024 17:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YmlUf+5y"
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 030DA16CD0C;
	Mon, 19 Aug 2024 17:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724090229; cv=none; b=hqik7ehfoDOdQrQBsvAqkaPoiKDfEUKPQmnnWrE/kxcwqZja8xRGo++wjOU1tBbms6BG3k2ID3IrR4MojYy3jq0dsEqFaTp5Vy+dSUEeKZr1PYoC+88gSWG+3Jtvj5ozYq7L2v8Mvo5S0BNVAa0weZ/yFBCdSZ1Yn+/VE8rT+8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724090229; c=relaxed/simple;
	bh=ElElpE5RI1lH2dckfWn+mTh2+L8kYUvgE3xhIammmVg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GfkwxJG8ulfaKpxir1KFvlzbBijF6Wo28f1aUZPEE/PN61L/+HTzN9tCj7F8cmaPSoEenM8Ej+0g1rQyv/NI0GSO64E8LWr8BB/o4efS/pjxaM0bF0lQ1anAVzaT8QP91C5hD46YgzI/b5pRWmtjXTFgh49GBZ3rxCHL/0OzN84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YmlUf+5y; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-2d3da6d3f22so2952559a91.0;
        Mon, 19 Aug 2024 10:57:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724090227; x=1724695027; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cuuVS1ITiXegZviCSVA69/H214SGYPE8ceZUaExnSkA=;
        b=YmlUf+5ysG8CE/xT3SCKuCFw7/A8CbyqtfUVpGCNzJVNMwo3PVnkCHME5pDYvTSXyO
         STeeOic3iyUwtMI3DBMsoOWt68lDEAffLRWKA5bodLxQJPbAReOHxKvRlKY86JYhZd8m
         k5McfB1+Ub7ujFDKjkY7RIpt6Zhei1Mj8PUCfGWJa8EI3yjoZKQj4nmnZZh3u77rtadY
         wbvPTSpTvupYO25ZjYkialo76aDr9SZ2XrWkEFVONTg8gwWcc8p/pgM1JiNOHHgYlrYe
         FPi7jsRc8x0UJcARTQxViSZa8D4qJFLrKoda0iOJY09NVkSaSkHRcDKw7/ayYLgx4RDT
         aj1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724090227; x=1724695027;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cuuVS1ITiXegZviCSVA69/H214SGYPE8ceZUaExnSkA=;
        b=nI1O8vQ6c6I3djOifgw8uoEWIBUvnj4ZQuyARTdLYhyZKAfzyWQPb8soLa310qhGNt
         yQcfpCEvSqcst8oenTp6oPUErnnFY38EA9bQL4K5J+p1IP+UL3wABZEMSdDQqZmPeTc7
         kyJP64RXhdkLTMC5G77ATg4PCzMl4m1ItZO7CrA7181s4hyuU1PGXhOz0QGi1sOzum3l
         4ByNxEfY0pD+Vav56wIH9vZYp+le0Lz73XM2VIgNd6K2B+kD4pjFXxup8nMb0UvIcIIy
         dKy3UfJ206ZjU+5zccNYgtAFJt5PvLB18uyGcyDh3ZmTYUF9Uih7gFYWCVGdQmc8nAJd
         xQFg==
X-Forwarded-Encrypted: i=1; AJvYcCUjsiV5PVXnrpYbDlXb8gTzfYNHs05sx85jNr2xlJEx6gBf5+PBULFmgjy4LEHnWVK8sgPED5eJz03g1o0/clGwM1AkkQZ2Yq7BhyFp451ZXelcWwKG9dQRcS86PGakJ3noFsQNrvN/dQ==
X-Gm-Message-State: AOJu0YyWURloeTUhtEytmuikZZlOZ2vwpi5Svjxh8vZRfumUA0sfiHe4
	ZqlC4rhmbcByyY5E4Fnrzkg0aF986Le4HP0jYURBVXB+7Jae9I/M08snvQ/4P41PZUvNfeytVpl
	7o4/WilfPQooSipnA6qetH74SqHQ=
X-Google-Smtp-Source: AGHT+IGbaJamB1WMkYOQP8y5T/PYjNZENVTB6C6IJlDHm2P8ZbvZAYpVTPylR32B0EEeQ7iuqG6aNEVdXU3TCrMt3ZQ=
X-Received: by 2002:a17:90b:1247:b0:2cd:5d13:40ba with SMTP id
 98e67ed59e1d1-2d3dffc8f3bmr12871217a91.14.1724090227028; Mon, 19 Aug 2024
 10:57:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240819-imx_warning-v2-0-4c428bd11160@nxp.com>
 <20240819-imx_warning-v2-12-4c428bd11160@nxp.com> <CAOMZO5C_uvmuf-+QGH4E2X=Jei81a--N5wC83V-URPkXj-q7hw@mail.gmail.com>
In-Reply-To: <CAOMZO5C_uvmuf-+QGH4E2X=Jei81a--N5wC83V-URPkXj-q7hw@mail.gmail.com>
From: Adam Ford <aford173@gmail.com>
Date: Mon, 19 Aug 2024 12:56:55 -0500
Message-ID: <CAHCN7xKYZDZdaQ7Noe1TrcDt-E5cU=kdnmkn7EBvBFRapvCApQ@mail.gmail.com>
Subject: Re: [PATCH v2 12/12] arm64: dts: imx8mm-beacon-kit: add DVDD-supply
 and DOVDD-supply
To: Fabio Estevam <festevam@gmail.com>
Cc: Frank Li <Frank.Li@nxp.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, Gregor Herburger <gregor.herburger@ew.tq-group.com>, 
	Alexander Stein <alexander.stein@ew.tq-group.com>, devicetree@vger.kernel.org, 
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux@ew.tq-group.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 19, 2024 at 12:24=E2=80=AFPM Fabio Estevam <festevam@gmail.com>=
 wrote:
>
> Adding Adam.
>
> On Mon, Aug 19, 2024 at 2:03=E2=80=AFPM Frank Li <Frank.Li@nxp.com> wrote=
:
> >
> > According to binding doc, DVDD-supply and DOVDD-supply is required
> > properties. Add these to fix below warning:
> > arch/arm64/boot/dts/freescale/imx8mm-beacon-kit.dtb: camera@10: 'DVDD-s=
upply' is a required proper
> >
> > Signed-off-by: Frank Li <Frank.Li@nxp.com>

Thanks for doing that!



Reviewed-by:  Adam Ford <aford173@gmail.com>

> > ---
> >  .../boot/dts/freescale/imx8mm-beacon-baseboard.dtsi      | 16 ++++++++=
++++++++
> >  .../boot/dts/freescale/imx8mn-beacon-baseboard.dtsi      | 16 ++++++++=
++++++++
> >  2 files changed, 32 insertions(+)
> >
> > diff --git a/arch/arm64/boot/dts/freescale/imx8mm-beacon-baseboard.dtsi=
 b/arch/arm64/boot/dts/freescale/imx8mm-beacon-baseboard.dtsi
> > index 6086dae2e5fbe..ea1d5b9c6bae0 100644
> > --- a/arch/arm64/boot/dts/freescale/imx8mm-beacon-baseboard.dtsi
> > +++ b/arch/arm64/boot/dts/freescale/imx8mm-beacon-baseboard.dtsi
> > @@ -56,6 +56,20 @@ pcie0_refclk_gated:  pcie0-refclk-gated {
> >                 enable-gpios =3D <&pca6416_1 2 GPIO_ACTIVE_LOW>;
> >         };
> >
> > +       reg_1v5: regulator-1v5 {
> > +               compatible =3D "regulator-fixed";
> > +               regulator-name =3D "1V5";
> > +               regulator-min-microvolt =3D <1500000>;
> > +               regulator-max-microvolt =3D <1500000>;
> > +       };
> > +
> > +       reg_1v8: regulator-1v8 {
> > +               compatible =3D "regulator-fixed";
> > +               regulator-name =3D "1V8";
> > +               regulator-min-microvolt =3D <1800000>;
> > +               regulator-max-microvolt =3D <1800000>;
> > +       };
> > +
> >         reg_audio: regulator-audio {
> >                 compatible =3D "regulator-fixed";
> >                 regulator-name =3D "3v3_aud";
> > @@ -187,6 +201,8 @@ camera@10 {
> >                 assigned-clock-parents =3D <&clk IMX8MM_CLK_24M>;
> >                 assigned-clock-rates =3D <24000000>;
> >                 AVDD-supply =3D <&reg_camera>;  /* 2.8v */
> > +               DVDD-supply =3D <&reg_1v5>;
> > +               DOVDD-supply =3D <&reg_1v8>;
> >                 powerdown-gpios =3D <&gpio1 7 GPIO_ACTIVE_HIGH>;
> >                 reset-gpios =3D <&gpio1 6 GPIO_ACTIVE_LOW>;
> >
> > diff --git a/arch/arm64/boot/dts/freescale/imx8mn-beacon-baseboard.dtsi=
 b/arch/arm64/boot/dts/freescale/imx8mn-beacon-baseboard.dtsi
> > index 20018ee2c803e..77d14ea459e57 100644
> > --- a/arch/arm64/boot/dts/freescale/imx8mn-beacon-baseboard.dtsi
> > +++ b/arch/arm64/boot/dts/freescale/imx8mn-beacon-baseboard.dtsi
> > @@ -40,6 +40,20 @@ led-3 {
> >                 };
> >         };
> >
> > +       reg_1v5: regulator-1v5 {
> > +               compatible =3D "regulator-fixed";
> > +               regulator-name =3D "1V5";
> > +               regulator-min-microvolt =3D <1500000>;
> > +               regulator-max-microvolt =3D <1500000>;
> > +       };
> > +
> > +       reg_1v8: regulator-1v8 {
> > +               compatible =3D "regulator-fixed";
> > +               regulator-name =3D "1V8";
> > +               regulator-min-microvolt =3D <1800000>;
> > +               regulator-max-microvolt =3D <1800000>;
> > +       };
> > +
> >         reg_audio: regulator-audio {
> >                 compatible =3D "regulator-fixed";
> >                 regulator-name =3D "3v3_aud";
> > @@ -158,6 +172,8 @@ camera@10 {
> >                 assigned-clock-parents =3D <&clk IMX8MN_CLK_24M>;
> >                 assigned-clock-rates =3D <24000000>;
> >                 AVDD-supply =3D <&reg_camera>;  /* 2.8v */
> > +               DVDD-supply =3D <&reg_1v5>;
> > +               DOVDD-supply =3D <&reg_1v8>;
> >                 powerdown-gpios =3D <&gpio1 7 GPIO_ACTIVE_HIGH>;
> >                 reset-gpios =3D <&gpio1 6 GPIO_ACTIVE_LOW>;
> >
> >
> > --
> > 2.34.1
> >

