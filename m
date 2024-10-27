Return-Path: <linux-kernel+bounces-383870-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 162349B2126
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Oct 2024 23:52:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 416C81C20C6B
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Oct 2024 22:52:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3649188591;
	Sun, 27 Oct 2024 22:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="ZHwqKWyl"
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68846286A1
	for <linux-kernel@vger.kernel.org>; Sun, 27 Oct 2024 22:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730069565; cv=none; b=sZ6MeFfc/cxqCccmM9OoRCYAFxtbiy3v+NJTgtbCPhbFa2HRcnrTtXHtxEDIGZLX+4FYvny8WvNLrHR38FPC9P+RYHWzYf6dcAcKlPvqUJ2Y2gEtcWbwRXAdex5gstBym6dcKU/J9rmnyXQ82Qsm5H4uXfRY0QNH8Od3q55Tppc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730069565; c=relaxed/simple;
	bh=0lEEI+SQw5c2x47rs5SF9I43R0m5oUka0ji+W5HGOKw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=D6ASMN/QVVTyJC2iSCArNZGEcL5uPJ0FogTQdCbsIc40bymDd0Mv11kpUuSdLdvTBgnIehNlT8L8xjgmxzAFV029FRpBPakMGhmaL3uwDlahgePMEmIRaSVKP2jI72ghoG8dUT3p+tRJsxsako75YG+2La+xZN3CNRurRJQSK48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=ZHwqKWyl; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-460da5a39fdso22788351cf.1
        for <linux-kernel@vger.kernel.org>; Sun, 27 Oct 2024 15:52:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1730069560; x=1730674360; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fXquMMV+4Hpsc00nMdUdCqYLDn7vHEApN+hixggLnx4=;
        b=ZHwqKWyllC7FKIYcsMhgx3NdB6GFY55DMmx9hbecfUbBHPQb7yRefm72wP0fl60ls5
         HhBmrMkf5IIKmn+WgMtuRi8hNhLId4Tiug2nGtmCih2Za7IqhpkCv5aWINhMGE0Dp26m
         MSWJ6Nkt7EbqN2l2z/rQw56Yaz3vktrf2EJAQWtRZZjwxPbJw98mumdr4kLVVXSDScx5
         TbgbP81gEJGEse69vjrl+iqrxLDu5mGvjdCUacAOBUORQ1RqxU8T3UTVh5eckZtBuljk
         5gC3U8AfkXIVxw5/p8/maepmTFVKLQFx4wLNeNXYtHFK8yDI1++UCwEY+/HuWyRCE/vO
         NjYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730069560; x=1730674360;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fXquMMV+4Hpsc00nMdUdCqYLDn7vHEApN+hixggLnx4=;
        b=cqxGRBTVDne7hrypZ8I//4XrhZ67XRD1bMcKu8JotfHTvGARGLdbNc1MKBqv8uT762
         CKSJLdLwRFYyRYjz6AYLA8iq5AEVCp8+d70dLpKys+uWQiDxt1V4nGOqrrD+gJw0AstK
         7yfKPP0KpXacwoWthxUknN+7lDt74Xb2FqScbIvu2L0l8glg774ReVtCmgHrc0s2YAdr
         AxurXyT36uJ8e2c+IJ7/IiUvMOTL5id9XJH7S2EPSKoIpdaFj9JGJxtID00wUtSZPMW5
         SOkmqkt/Lrs9AC5hPAwZAdgaFdQWzEGMJAJjV3NZHB00esJCSVfu4xqXNgdZ0LOGU4xa
         V9Ig==
X-Forwarded-Encrypted: i=1; AJvYcCWnPCT6odgKmP034JYIxszSgycllyRIMPzQ39vvaDRA+t72CSHIrJU/M4CHVHm5hLij1WI9kVvQ94uTTlo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1395tTBC1TV1kx6tTN/BZvLL50SIkRH1Ib5TyMJa5hDdimbvM
	GFvSgljYN9wHhXstx7dOsy2LFO2fxBUOV5LKfuuEyfgGf/tDoyl6rS4lziQrEWJ7ZyZ2/tOkhJd
	qVELt246z4M7vWoh1XAfNTHhCiETHRz1L6Lv1eg==
X-Google-Smtp-Source: AGHT+IEKaxmHw7UX3zIJClnKQtV6bW7RDIrexBRLx49gNSuJcL5LQDsbbzftubUyIWpE0dNrhG1GQakOfRbUwWZLGj8=
X-Received: by 2002:ac8:429a:0:b0:461:48f9:438d with SMTP id
 d75a77b69052e-46148f947a9mr55266941cf.57.1730069560255; Sun, 27 Oct 2024
 15:52:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241027144448.1813611-1-guodong@riscstar.com>
 <20241027144448.1813611-2-guodong@riscstar.com> <CAJM55Z-xxbUY9nyjt8TsqzknY4NNUiqJEi1XeLK-ytFpjDVvOg@mail.gmail.com>
In-Reply-To: <CAJM55Z-xxbUY9nyjt8TsqzknY4NNUiqJEi1XeLK-ytFpjDVvOg@mail.gmail.com>
From: Guodong Xu <guodong@riscstar.com>
Date: Mon, 28 Oct 2024 06:52:28 +0800
Message-ID: <CAH1PCMZYk_wGsvDHk+7pjUOskXx4JTsRHtC4vBQP07LT_Ovg4g@mail.gmail.com>
Subject: Re: [PATCH v6 1/5] riscv: dts: starfive: jh7110-common: revised
 device node
To: Emil Renner Berthing <emil.renner.berthing@canonical.com>
Cc: Conor Dooley <conor@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Emil Renner Berthing <kernel@esmil.dk>, rafal@milecki.pl, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Heiko Stuebner <heiko.stuebner@cherry.de>, 
	Michael Zhu <michael.zhu@starfivetech.com>, Drew Fustini <drew@beagleboard.org>, 
	Alexandru Stan <ams@frame.work>, Daniel Schaefer <dhs@frame.work>, 
	Sandie Cao <sandie.cao@deepcomputing.io>, Yuning Liang <yuning.liang@deepcomputing.io>, 
	Huiming Qiu <huiming.qiu@deepcomputing.io>, Alex Elder <elder@riscstar.com>, linux@frame.work, 
	devicetree@vger.kernel.org, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 28, 2024 at 12:35=E2=80=AFAM Emil Renner Berthing
<emil.renner.berthing@canonical.com> wrote:
>
> Guodong Xu wrote:
> > Earlier this year a new DTSI file was created to define common
> > properties for the StarFive VisionFive 2 and Milk-V Mars boards,
> > both of which use the StarFive JH7110 SoC.  The Pine64 Star64
> > board has also been added since that time.
> >
> > Some of the nodes defined in "jh7110-common.dtsi" are enabled in
> > that file because all of the boards including it "want" them
> > enabled.
> >
> > An upcoming patch enables another JH7110 board, but for that
> > board not all of these common nodes should be enabled.  Prepare
> > for supporting the new board by avoiding enabling these nodes in
> > "jh711-common.dtsi", and enable them instead in these files:
>
> jh7110-common.dtsi
>

Will fix.

> >    jh7110-milkv-mars.dts
> >    jh7110-pine64-star64.dts
> >    jh7110-starfive-visionfive-2.dtsi
> >
> > Signed-off-by: Alex Elder <elder@riscstar.com>
> > Signed-off-by: Guodong Xu <guodong@riscstar.com>
> > ---
> > v6: New patch
> >
> >  .../boot/dts/starfive/jh7110-common.dtsi      |  5 -----
> >  .../boot/dts/starfive/jh7110-milkv-mars.dts   | 17 ++++++++++++++++
> >  .../dts/starfive/jh7110-pine64-star64.dts     | 17 ++++++++++++++++
> >  .../jh7110-starfive-visionfive-2.dtsi         | 20 +++++++++++++++++++
> >  4 files changed, 54 insertions(+), 5 deletions(-)
> >
>
> From here..
>
> > diff --git a/arch/riscv/boot/dts/starfive/jh7110-common.dtsi b/arch/ris=
cv/boot/dts/starfive/jh7110-common.dtsi
> > index c7771b3b6475..9e77f79ec162 100644
> > --- a/arch/riscv/boot/dts/starfive/jh7110-common.dtsi
> > +++ b/arch/riscv/boot/dts/starfive/jh7110-common.dtsi
> >  .../boot/dts/starfive/jh7110-common.dtsi      |  5 -----
> >  .../boot/dts/starfive/jh7110-milkv-mars.dts   | 17 ++++++++++++++++
> >  .../dts/starfive/jh7110-pine64-star64.dts     | 17 ++++++++++++++++
> >  .../jh7110-starfive-visionfive-2.dtsi         | 20 +++++++++++++++++++
> >  4 files changed, 54 insertions(+), 5 deletions(-)
>
> ..to here seems to be added by mistake. At least my "git am" wouldn't app=
ly it
> like this.
>

My editing mistake. I will fix that.

> With that fixed this looks good to me, thanks.
>
> Reviewed-by: Emil Renner Berthing <emil.renner.berthing@canonical.com>
>

Thank you, Emil.

> > diff --git a/arch/riscv/boot/dts/starfive/jh7110-common.dtsi b/arch/ris=
cv/boot/dts/starfive/jh7110-common.dtsi
> > index c7771b3b6475..9e77f79ec162 100644
> > --- a/arch/riscv/boot/dts/starfive/jh7110-common.dtsi
> > +++ b/arch/riscv/boot/dts/starfive/jh7110-common.dtsi
> > @@ -176,7 +176,6 @@ csi2rx_to_camss: endpoint {
> >  &gmac0 {
> >       phy-handle =3D <&phy0>;
> >       phy-mode =3D "rgmii-id";
> > -     status =3D "okay";
> >
> >       mdio {
> >               #address-cells =3D <1>;
> > @@ -196,7 +195,6 @@ &i2c0 {
> >       i2c-scl-falling-time-ns =3D <510>;
> >       pinctrl-names =3D "default";
> >       pinctrl-0 =3D <&i2c0_pins>;
> > -     status =3D "okay";
> >  };
> >
> >  &i2c2 {
> > @@ -311,7 +309,6 @@ &pcie1 {
> >  &pwmdac {
> >       pinctrl-names =3D "default";
> >       pinctrl-0 =3D <&pwmdac_pins>;
> > -     status =3D "okay";
> >  };
> >
> >  &qspi {
> > @@ -350,13 +347,11 @@ uboot@100000 {
> >  &pwm {
> >       pinctrl-names =3D "default";
> >       pinctrl-0 =3D <&pwm_pins>;
> > -     status =3D "okay";
> >  };
> >
> >  &spi0 {
> >       pinctrl-names =3D "default";
> >       pinctrl-0 =3D <&spi0_pins>;
> > -     status =3D "okay";
> >
> >       spi_dev0: spi@0 {
> >               compatible =3D "rohm,dh2228fv";
> > diff --git a/arch/riscv/boot/dts/starfive/jh7110-milkv-mars.dts b/arch/=
riscv/boot/dts/starfive/jh7110-milkv-mars.dts
> > index 5cb9e99e1dac..66ad3eb2fd66 100644
> > --- a/arch/riscv/boot/dts/starfive/jh7110-milkv-mars.dts
> > +++ b/arch/riscv/boot/dts/starfive/jh7110-milkv-mars.dts
> > @@ -15,6 +15,11 @@ &gmac0 {
> >       starfive,tx-use-rgmii-clk;
> >       assigned-clocks =3D <&aoncrg JH7110_AONCLK_GMAC0_TX>;
> >       assigned-clock-parents =3D <&aoncrg JH7110_AONCLK_GMAC0_RMII_RTX>=
;
> > +     status =3D "okay";
> > +};
> > +
> > +&i2c0 {
> > +     status =3D "okay";
> >  };
> >
> >  &pcie0 {
> > @@ -35,3 +40,15 @@ &phy0 {
> >       rx-internal-delay-ps =3D <1500>;
> >       tx-internal-delay-ps =3D <1500>;
> >  };
> > +
> > +&pwm {
> > +     status =3D "okay";
> > +};
> > +
> > +&pwmdac {
> > +     status =3D "okay";
> > +};
> > +
> > +&spi0 {
> > +     status =3D "okay";
> > +};
> > diff --git a/arch/riscv/boot/dts/starfive/jh7110-pine64-star64.dts b/ar=
ch/riscv/boot/dts/starfive/jh7110-pine64-star64.dts
> > index b720cdd15ed6..dbc8612b8464 100644
> > --- a/arch/riscv/boot/dts/starfive/jh7110-pine64-star64.dts
> > +++ b/arch/riscv/boot/dts/starfive/jh7110-pine64-star64.dts
> > @@ -18,6 +18,7 @@ &gmac0 {
> >       starfive,tx-use-rgmii-clk;
> >       assigned-clocks =3D <&aoncrg JH7110_AONCLK_GMAC0_TX>;
> >       assigned-clock-parents =3D <&aoncrg JH7110_AONCLK_GMAC0_RMII_RTX>=
;
> > +     status =3D "okay";
> >  };
> >
> >  &gmac1 {
> > @@ -39,6 +40,10 @@ phy1: ethernet-phy@1 {
> >       };
> >  };
> >
> > +&i2c0 {
> > +     status =3D "okay";
> > +};
> > +
> >  &pcie1 {
> >       status =3D "okay";
> >  };
> > @@ -63,3 +68,15 @@ &phy1 {
> >       motorcomm,tx-clk-10-inverted;
> >       motorcomm,tx-clk-100-inverted;
> >  };
> > +
> > +&pwm {
> > +     status =3D "okay";
> > +};
> > +
> > +&pwmdac {
> > +     status =3D "okay";
> > +};
> > +
> > +&spi0 {
> > +     status =3D "okay";
> > +};
> > diff --git a/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.=
dtsi b/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dtsi
> > index 18f38fc790a4..ef93a394bb2f 100644
> > --- a/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dtsi
> > +++ b/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dtsi
> > @@ -13,6 +13,10 @@ aliases {
> >       };
> >  };
> >
> > +&gmac0 {
> > +     status =3D "okay";
> > +};
> > +
> >  &gmac1 {
> >       phy-handle =3D <&phy1>;
> >       phy-mode =3D "rgmii-id";
> > @@ -29,6 +33,10 @@ phy1: ethernet-phy@1 {
> >       };
> >  };
> >
> > +&i2c0 {
> > +     status =3D "okay";
> > +};
> > +
> >  &mmc0 {
> >       non-removable;
> >  };
> > @@ -40,3 +48,15 @@ &pcie0 {
> >  &pcie1 {
> >       status =3D "okay";
> >  };
> > +
> > +&pwm {
> > +     status =3D "okay";
> > +};
> > +
> > +&pwmdac {
> > +     status =3D "okay";
> > +};
> > +
> > +&spi0 {
> > +     status =3D "okay";
> > +};
> > --
> > 2.34.1
> >

