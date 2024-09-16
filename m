Return-Path: <linux-kernel+bounces-331101-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 872CD97A86C
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 22:50:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1547F1F240CA
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 20:50:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3971615D5CE;
	Mon, 16 Sep 2024 20:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N0jlC3Xu"
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E451F101EE;
	Mon, 16 Sep 2024 20:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726519841; cv=none; b=WZ+kpxKhZ+ce9ggWmRDC7agLO02SGduyB3E0SNAwSlGId5P/X6baOsDY1yZg0o2KFDqz42VjBT06y9tktSDUQj/juySFzT8917Q8OTLOz93oHs5jJLVQn3/tLOG5s1sUnXgPnJKX4ISb2ZD23AFNG28NeSPSGh3ABjSOE6onRLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726519841; c=relaxed/simple;
	bh=EPuS2/x+Apeqo+h5PlDJ57xWx6EiaLVNmNHDNkprA+Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oIYR/FoxJBoz9OErWh3YWNriy85iZKL2K4C4O9+zTHmy1N8fcssN8kGUh2lHhE20D16IkSauUDbhIDCUjR32N8CqSDhuJjKh4TJ5iBVYgw1wUdX/VsfnJ4bsZ8rYAoNjnwxQ9olOjDIfNZAHU8U5APmW/eh4dSkpdMLPXD4sk1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N0jlC3Xu; arc=none smtp.client-ip=209.85.219.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-e1d2cf4cbf1so4817454276.1;
        Mon, 16 Sep 2024 13:50:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726519839; x=1727124639; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=6x/uji5axtWcw2sGeJ1wr4Dagb+N5kE/4J37Qx8pyTE=;
        b=N0jlC3XuUs2FiXTSfB1ZLQ4fLBDZ9z4TpiJaA/ostN5tWWDktiRUSv4nJwcsN0KAym
         l3+syIsEGw0J4yByZrylwuxTCKNWE1E6+gGRqHdQuy4PeFHLwcIvUer4S1Q4YL+o+2HP
         1pL2+HvkqruRvBefSJfVVzZ7qpUJjYKv7NzEHPmqXj8hVTdNi+4X7j/aEnSS/cnOLBOF
         suo7s7HEXn46jY94LAB9eCZOVZOjoJ6Sqs0xTcEYLZxRVUzBoDhWTvBCw91z9OV0FSCm
         5MoiO1owOP6xhyIRePv4006sMExEgQxTABNjwSr2FZRazj7mDLioDd+5St1tHTqUlO9N
         DUeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726519839; x=1727124639;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6x/uji5axtWcw2sGeJ1wr4Dagb+N5kE/4J37Qx8pyTE=;
        b=vDKfu+2ecINv57F6jZr09wPWwiPkD/bDj4FHeKXG60bdwNsWA88DlzClqlQdH+x0Lk
         KOFZXlZg4BC2WxmNdxBi4FXeiyrnEl9mfe/yXiX+lAXDYtNAnGKhbrhHfw2jydfSYhSb
         mo5l2pzh7qbKwkc9AC4mudzRqmnadD222k8odWYLVU2MRa9N6NFY7yD8ir/uvfF0rLGH
         ArYmYpPTkKAkQ/g11tBwRy22nZHTMhB5jsMKig9YSClzHaWGYTaW2Jucyjk0c6+5+Czx
         vfR8Dt+MCdforsoAxAS2S6r8JtB/KQpuj5xtnjap8CQgLybiXVqwOAYfsApmNFZxX2Ml
         UQTg==
X-Forwarded-Encrypted: i=1; AJvYcCUD648QmZ5hU1quYm26kyATB80f/Ii4amVghUtIa+VGUnXaiUR119tQIQBFmgtLU8yyvEmto1v9qaHa@vger.kernel.org, AJvYcCXL1bQpwgwFsoT1VIA+xTayK4Nei9b9Hjli3U+YcAXjX1vDh7HVsFd9jcK2Z6b1NIxYuYUigdEnTK3AjH/Q@vger.kernel.org
X-Gm-Message-State: AOJu0YwcU3h2G3y5tMa8kh9m4pP0MXwGk+TsQfzK3qLq5CgJBOBp9LMP
	hJcyTo7CyU1PxyJBm1IGNFlLBM4sm7smIDWbV+XS2nTj9v6OntjlQFa1dLfzxIkmuLQz2awh6dv
	TKr4AMpBxs/+OvjlL45+0BSoPgG0=
X-Google-Smtp-Source: AGHT+IHNWoBnckh4JzG0DDNvv5RpTkKQzvqOqO9Ri3IKF30PiwhxsioNGUI2YVdoXHTZXLgQWO0U4qG9goXSQaXULW0=
X-Received: by 2002:a05:6902:1246:b0:e1d:33f1:cb91 with SMTP id
 3f1490d57ef6-e1d9dc2c28emr14379688276.39.1726519838644; Mon, 16 Sep 2024
 13:50:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240916200255.2566209-1-diogo.pais@ttcontrol.com> <eb3ec7f1-388c-4613-b995-69b8ad6ef2c0@kernel.org>
In-Reply-To: <eb3ec7f1-388c-4613-b995-69b8ad6ef2c0@kernel.org>
From: Diogo Silva <diogompaissilva@gmail.com>
Date: Mon, 16 Sep 2024 22:50:27 +0200
Message-ID: <CAJpoHp4MbeNCz4Sys1_khQiG7BG6F-aVkrgivHGY_JYP831teg@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: imx8: Fix lvds0 device tree
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de, 
	festevam@gmail.com, aisheng.dong@nxp.com, Frank.Li@nxp.com, 
	devicetree@vger.kernel.org, imx@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hey,

Sorry for the broken tag, will fix on a resend.

As for the naming, if there is any reason for them to be named qm_*
it's totally fine, I'll revert it and only touch the clock names. I
changed them because comparing with lvds1, those ones do not contain
the qm_ prefix and I don't see how this dtsi relates specifically to
the imx8qm, since it is a imx8-ss... and not imx8qm-ss...
I didn't quite get the question about the nodes. Could you elaborate? Thanks

Best regards,
Diogo


On Mon, 16 Sept 2024 at 22:23, Krzysztof Kozlowski <krzk@kernel.org> wrote:
>
> On 16/09/2024 22:02, Diogo Silva wrote:
> > From: Diogo Silva <diogompaissilva@gmail.com>
> >
> > Some clock output names on lvds0 device tree were duplicated from mipi1,
> > which caused an -EEXIST when registering these clocks during probe.
> > Also fixed the device naming to be consistent with lvds1.
> >
> > Fixes: 0fba24b3b956 ("arm64: dts: imx8: add basic lvds0 and lvds1 subsystem")
> > subsystem")
>
> Broken tags. They do not line-brake, BTW.
>
> > Signed-off-by: Diogo Silva <diogompaissilva@gmail.com>
> > ---
> >  .../boot/dts/freescale/imx8-ss-lvds0.dtsi     | 22 +++++++++----------
> >  arch/arm64/boot/dts/freescale/imx8qm-mek.dts  |  4 ++--
> >  .../boot/dts/freescale/imx8qm-ss-lvds.dtsi    | 20 ++++++++---------
> >  3 files changed, 23 insertions(+), 23 deletions(-)
> >
> > diff --git a/arch/arm64/boot/dts/freescale/imx8-ss-lvds0.dtsi b/arch/arm64/boot/dts/freescale/imx8-ss-lvds0.dtsi
> > index d00036204a8c..a4d94467039f 100644
> > --- a/arch/arm64/boot/dts/freescale/imx8-ss-lvds0.dtsi
> > +++ b/arch/arm64/boot/dts/freescale/imx8-ss-lvds0.dtsi
> > @@ -10,34 +10,34 @@ lvds0_subsys: bus@56240000 {
> >       #size-cells = <1>;
> >       ranges = <0x56240000 0x0 0x56240000 0x10000>;
> >
> > -     qm_lvds0_lis_lpcg: qxp_mipi1_lis_lpcg: clock-controller@56243000 {
> > +     lvds0_lis_lpcg: clock-controller@56243000 {
> >               compatible = "fsl,imx8qxp-lpcg";
> >               reg = <0x56243000 0x4>;
> >               #clock-cells = <1>;
> > -             clock-output-names = "mipi1_lis_lpcg_ipg_clk";
> > +             clock-output-names = "lvds0_lis_lpcg_ipg_clk";
> >               power-domains = <&pd IMX_SC_R_MIPI_1>;
> >       };
> >
> > -     qm_lvds0_pwm_lpcg: qxp_mipi1_pwm_lpcg: clock-controller@5624300c {
> > +     lvds0_pwm_lpcg: clock-controller@5624300c {
> >               compatible = "fsl,imx8qxp-lpcg";
> >               reg = <0x5624300c 0x4>;
> >               #clock-cells = <1>;
> > -             clock-output-names = "mipi1_pwm_lpcg_clk",
> > -                                  "mipi1_pwm_lpcg_ipg_clk",
> > -                                  "mipi1_pwm_lpcg_32k_clk";
> > +             clock-output-names = "lvds0_pwm_lpcg_clk",
> > +                                  "lvds0_pwm_lpcg_ipg_clk",
> > +                                  "lvds0_pwm_lpcg_32k_clk";
> >               power-domains = <&pd IMX_SC_R_MIPI_1_PWM_0>;
> >       };
> >
> > -     qm_lvds0_i2c0_lpcg: qxp_mipi1_i2c0_lpcg: clock-controller@56243010 {
> > +     lvds0_i2c0_lpcg: clock-controller@56243010 {
> >               compatible = "fsl,imx8qxp-lpcg";
> >               reg = <0x56243010 0x4>;
> >               #clock-cells = <1>;
> > -             clock-output-names = "mipi1_i2c0_lpcg_clk",
> > -                                  "mipi1_i2c0_lpcg_ipg_clk";
> > +             clock-output-names = "lvds0_i2c0_lpcg_clk",
> > +                                  "lvds0_i2c0_lpcg_ipg_clk";
> >               power-domains = <&pd IMX_SC_R_MIPI_1_I2C_0>;
> >       };
> >
> > -     qm_pwm_lvds0: qxp_pwm_mipi_lvds1: pwm@56244000 {
> > +     pwm_lvds0: pwm@56244000 {
> >               compatible = "fsl,imx8qxp-pwm", "fsl,imx27-pwm";
> >               reg = <0x56244000 0x1000>;
> >               clock-names = "ipg", "per";
> > @@ -48,7 +48,7 @@ qm_pwm_lvds0: qxp_pwm_mipi_lvds1: pwm@56244000 {
> >               status = "disabled";
> >       };
> >
> > -     qm_i2c0_lvds0: qxp_i2c0_mipi_lvds1: i2c@56246000 {
> > +     i2c0_lvds0: i2c@56246000 {
> >               compatible = "fsl,imx8qxp-lpi2c", "fsl,imx7ulp-lpi2c";
> >               reg = <0x56246000 0x1000>;
> >               #address-cells = <1>;
> > diff --git a/arch/arm64/boot/dts/freescale/imx8qm-mek.dts b/arch/arm64/boot/dts/freescale/imx8qm-mek.dts
> > index 62203eed6a6c..f7b9b319a58a 100644
> > --- a/arch/arm64/boot/dts/freescale/imx8qm-mek.dts
> > +++ b/arch/arm64/boot/dts/freescale/imx8qm-mek.dts
> > @@ -96,7 +96,7 @@ vdevbuffer: memory@90400000 {
> >
> >       lvds_backlight0: backlight-lvds0 {
> >               compatible = "pwm-backlight";
> > -             pwms = <&qm_pwm_lvds0 0 100000 0>;
> > +             pwms = <&pwm_lvds0 0 100000 0>;
> >               brightness-levels = <0 100>;
> >               num-interpolated-steps = <100>;
> >               default-brightness-level = <80>;
> > @@ -541,7 +541,7 @@ &fec2 {
> >       status = "okay";
> >  };
> >
> > -&qm_pwm_lvds0 {
> > +&pwm_lvds0 {
>
> Why this cannot stay qm_pwm_lvds0? Are you sure nodes now have correct
> order?
>
>
>
> Best regards,
> Krzysztof
>

