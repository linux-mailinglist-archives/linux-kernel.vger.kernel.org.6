Return-Path: <linux-kernel+bounces-219195-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98D7490CB26
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 14:08:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A17AD1C23B2E
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 12:08:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF4C513D281;
	Tue, 18 Jun 2024 12:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CbVhBDZR"
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96A0413B2BC;
	Tue, 18 Jun 2024 12:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718712442; cv=none; b=dMJARpGc581aiupZxppJCZ0DBOsOLiJLOBAew854SwGqapse7kW+OApuk/g3CJWIrwDc/S00JIY6rGgUo3EU9k11oQVRWSlaO3BTBP7PEsKpFuoPlWR7jfh8CCZDfXlu6lkxLg4MKFlNGawg4XdL2jKq3SSQ86MWMyMvaqYmO3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718712442; c=relaxed/simple;
	bh=zIMNWACWd3M1Cq3jpWfZKiQ5Xh7liCvscnKOrJX2hTA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kcpeEzfpNR2mQkm5DO0C35pZF/2ZtREXGROYS+SsEZ8q79nlxuq+p+1g/q6XIkxgORZWXFyJDhY8YNzBDk9ioFf3U6QVif7SChz3bNssuMgi+MG4v+KE3kZU+zA3oNbzofuarsLXelxHFJ7XoS954upEHOEgZsJARqCUp28tTII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CbVhBDZR; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-2bfff08fc29so4466343a91.1;
        Tue, 18 Jun 2024 05:07:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718712440; x=1719317240; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8qMW/fhC5hVCG/nXgj+a3Q82/zqzq5GMfidhC1/vwWQ=;
        b=CbVhBDZRSE56f2nPKs8+osbzXWivc/5soSlsNrHdIv5JYQzwbMgqEhhKhADMM6TRdE
         us0Ho/SojLECOJKvDENAnGfYV0dKY4UyOmzvfaKkdJcC1MFRkEJkIYA8roMYc3BMOuzq
         95RE8dWAPathJntsAprj+UNZIZ6ipJp0IYH3f8yeShf3oNoAUmiFwfZkqPlLA346uRc9
         QgxsRE+sdy/fx+E6fCOqFWXPSdM3uDuuN95T0jNI4UJ3FJ3DcGXIY49+f94+Sr+UkihZ
         v/1/lRftD7ZkqPIoLmCWt9G6UYSft5hkvoaWypGlzTGUP3pIn0CqPSoHKvFuvSQ1ylyP
         nsug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718712440; x=1719317240;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8qMW/fhC5hVCG/nXgj+a3Q82/zqzq5GMfidhC1/vwWQ=;
        b=A5mxHS3ZlI/SxZPX2v6ruycRlJdEr9W0IWys/ygJ3jOSiOu/2KfMIherTas08ZdrFP
         hmfsOCiUY04j4TeekYRCXVGadc3hpxE92xLrZ+tI41LW1IpA9n4JbWj7kpr2y4CZ4BA4
         e7TqiUckGuircIvQyXaVOQFsZ8fGTWGKGewV+QgkToeqfnpeXCZKrlBYkqfuOSPX8I1i
         hGeNU9lp+TgMFIjQjQ0Vgd3OdgWM3c/HEQWRXqC5DTK3URMTxUiYt5xDRK67Y8x0oqvR
         RbNv3Chb685P7IKY9hGwVx4jfReOBB03Mc/BMOSR9P0ICvqWADKDMpUZwBs0+od/rzrO
         Lr2g==
X-Forwarded-Encrypted: i=1; AJvYcCVt2Fu7OR3eeLd+R80ppjVKWtHnptxsMnDsA3Cllwjrr1Aux6MJSmAAHYwGrdWEJRQOqdZox8omDk9vzKZ1M8XogD9wzIshiYM0fwsimiHyyylaHssn8q8AZZqoybENB9ChziBEFvhDZg==
X-Gm-Message-State: AOJu0Yy80yB/dR/A9ZkXk9WZC8/7agfNAQPzQF6qsDcT+7ODvrv09z/G
	juvubsZf7awysLh1g7CHGXXLkQaasq1tZ557vuvmBRQ0xEk2Bhc1+hBxZg0uAGofMwZI6TMuCLi
	TWAYiAuBBmN81ZNVq995AVNDf9f0=
X-Google-Smtp-Source: AGHT+IHg1X7qgFSor7TxKpGXZBPsKGWKdT3X+Qx1Ip3e8IAZa58OsBuEF8S062FwXsVLE54KZxZg9btByg4FhvGFjdA=
X-Received: by 2002:a17:90b:4d8b:b0:2c4:aa67:895c with SMTP id
 98e67ed59e1d1-2c4db242648mr11431737a91.17.1718712439650; Tue, 18 Jun 2024
 05:07:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240617223952.1899201-1-aford173@gmail.com> <5814494.DvuYhMxLoT@steina-w>
In-Reply-To: <5814494.DvuYhMxLoT@steina-w>
From: Adam Ford <aford173@gmail.com>
Date: Tue, 18 Jun 2024 07:07:08 -0500
Message-ID: <CAHCN7xLPHx_W4GGkSknu=_3o29jT0gQZddLAakDMzUUR0ok=Lg@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: imx8mp: Fix pgc_mlmix location
To: Alexander Stein <alexander.stein@ew.tq-group.com>
Cc: linux-arm-kernel@lists.infradead.org, aford@beaconembedded.com, 
	marex@denx.de, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
	Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>, 
	Fabio Estevam <festevam@gmail.com>, Peng Fan <peng.fan@nxp.com>, 
	Marco Felsch <m.felsch@pengutronix.de>, devicetree@vger.kernel.org, imx@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 18, 2024 at 1:15=E2=80=AFAM Alexander Stein
<alexander.stein@ew.tq-group.com> wrote:
>
> Hi Adam,
>
> Am Dienstag, 18. Juni 2024, 00:39:51 CEST schrieb Adam Ford:
> > The pgc_mlmix shows a power-domain@24, but the reg value is
> > IMX8MP_POWER_DOMAIN_MLMIX which is set to 4.
> >
> > The stuff after the @ symbol should match the stuff referenced
> > by 'reg' so reorder the pgc_mlmix so it to appear as power-domain@4.
>
> Taking a look this mismatch seems to be also true for:
> * IMX8MP_POWER_DOMAIN_VPUMIX
> * IMX8MP_POWER_DOMAIN_VPU_G1
> * IMX8MP_POWER_DOMAIN_VPU_G2
> * IMX8MP_POWER_DOMAIN_VPU_VC8000E
>
> Would you mind fixing them as well?

I can do that.   I'll send out out later tonight.

adam
>
> Despite that, for this patch:
> Reviewed-by: Alexander Stein <alexander.stein@ew.tq-group.com>
>
> Thanks and best regards,
> Alexander
>
> > Fixes: 834464c8504c ("arm64: dts: imx8mp: add mlmix power domain")
> > Fixes: 4bedc468b725 ("arm64: dts: imx8mp: Add NPU Node")
> >
> > Signed-off-by: Adam Ford <aford173@gmail.com>
> >
> > diff --git a/arch/arm64/boot/dts/freescale/imx8mp.dtsi b/arch/arm64/boo=
t/dts/freescale/imx8mp.dtsi
> > index b92abb5a5c53..3576d2b89b43 100644
> > --- a/arch/arm64/boot/dts/freescale/imx8mp.dtsi
> > +++ b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
> > @@ -789,6 +789,23 @@ pgc_usb2_phy: power-domain@3 {
> >                                               reg =3D <IMX8MP_POWER_DOM=
AIN_USB2_PHY>;
> >                                       };
> >
> > +                                     pgc_mlmix: power-domain@4 {
> > +                                             #power-domain-cells =3D <=
0>;
> > +                                             reg =3D <IMX8MP_POWER_DOM=
AIN_MLMIX>;
> > +                                             clocks =3D <&clk IMX8MP_C=
LK_ML_AXI>,
> > +                                                      <&clk IMX8MP_CLK=
_ML_AHB>,
> > +                                                      <&clk IMX8MP_CLK=
_NPU_ROOT>;
> > +                                             assigned-clocks =3D <&clk=
 IMX8MP_CLK_ML_CORE>,
> > +                                                               <&clk I=
MX8MP_CLK_ML_AXI>,
> > +                                                               <&clk I=
MX8MP_CLK_ML_AHB>;
> > +                                             assigned-clock-parents =
=3D <&clk IMX8MP_SYS_PLL1_800M>,
> > +                                                                      =
<&clk IMX8MP_SYS_PLL1_800M>,
> > +                                                                      =
<&clk IMX8MP_SYS_PLL1_800M>;
> > +                                             assigned-clock-rates =3D =
<800000000>,
> > +                                                                    <8=
00000000>,
> > +                                                                    <3=
00000000>;
> > +                                     };
> > +
> >                                       pgc_audio: power-domain@5 {
> >                                               #power-domain-cells =3D <=
0>;
> >                                               reg =3D <IMX8MP_POWER_DOM=
AIN_AUDIOMIX>;
> > @@ -900,23 +917,6 @@ pgc_vpu_vc8000e: power-domain@22 {
> >                                               reg =3D <IMX8MP_POWER_DOM=
AIN_VPU_VC8000E>;
> >                                               clocks =3D <&clk IMX8MP_C=
LK_VPU_VC8KE_ROOT>;
> >                                       };
> > -
> > -                                     pgc_mlmix: power-domain@24 {
> > -                                             #power-domain-cells =3D <=
0>;
> > -                                             reg =3D <IMX8MP_POWER_DOM=
AIN_MLMIX>;
> > -                                             clocks =3D <&clk IMX8MP_C=
LK_ML_AXI>,
> > -                                                      <&clk IMX8MP_CLK=
_ML_AHB>,
> > -                                                      <&clk IMX8MP_CLK=
_NPU_ROOT>;
> > -                                             assigned-clocks =3D <&clk=
 IMX8MP_CLK_ML_CORE>,
> > -                                                               <&clk I=
MX8MP_CLK_ML_AXI>,
> > -                                                               <&clk I=
MX8MP_CLK_ML_AHB>;
> > -                                             assigned-clock-parents =
=3D <&clk IMX8MP_SYS_PLL1_800M>,
> > -                                                                      =
<&clk IMX8MP_SYS_PLL1_800M>,
> > -                                                                      =
<&clk IMX8MP_SYS_PLL1_800M>;
> > -                                             assigned-clock-rates =3D =
<800000000>,
> > -                                                                    <8=
00000000>,
> > -                                                                    <3=
00000000>;
> > -                                     };
> >                               };
> >                       };
> >               };
> >
>
>
> --
> TQ-Systems GmbH | M=C3=BChlstra=C3=9Fe 2, Gut Delling | 82229 Seefeld, Ge=
rmany
> Amtsgericht M=C3=BCnchen, HRB 105018
> Gesch=C3=A4ftsf=C3=BChrer: Detlef Schneider, R=C3=BCdiger Stahl, Stefan S=
chneider
> http://www.tq-group.com/
>
>

