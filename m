Return-Path: <linux-kernel+bounces-322652-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C3FE972BEA
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 10:17:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D1FD4B22551
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 08:17:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7555E210F8;
	Tue, 10 Sep 2024 08:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="boifW1tx"
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D008617BEBF;
	Tue, 10 Sep 2024 08:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725956124; cv=none; b=brblv0iYyt7y/116MZHtKdf26EmFiDL6/oP07G/sr29fcjWdqB4S2fDOWrnZqhgG/VFK68yHncM/OtXxBJxtYmH7DwM1CPLCRLYjduleS1Goj/V6WzD8PSYEM9kqjHcYklQzfQv2+j50qPnt1TTBb2GB3DyDcgpkQUGygMZyK9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725956124; c=relaxed/simple;
	bh=et3dYxQgsfg5PySGS6DCig0jQ0gmUdydE5KkYVWjHsw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Pp1wYw806Wg0GvRpa/j7TgaXeJW346jH/4MTd5gmpr0s+FyZU1k/xJ/u6U721/yyZ3Gsx0fqSZXcgRD2l2Zf1/iEMcvPckx6lyb+lDDfRb6GodvLZNzpSId5UaUpodbUoBqXNL9Q7y8lNsjKg3TLQFDNW0IlmWYU1SBpIGhoogE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=boifW1tx; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-4581d15c3e3so22607171cf.0;
        Tue, 10 Sep 2024 01:15:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725956122; x=1726560922; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EPH3kBIxJYHEyTOz3p0DMAY4Ngb5KzT9ROJM3lAS0nI=;
        b=boifW1txVaVmvCxbJqN6rwL2jzSDq4ZpwneTKa4XBEGr3WsFRTrlF3gQ30gFpQrfpT
         zM2rBKFgJfB+D98/99/3Um4a76cU+DBgH/I/KHuPZEBH/dj76QR/X3fnEJMGBXbPKM7A
         NzKqFfFS+ID1gqVPt1bchkVWIbNOl8D9G7nFsndI7p3pn9/bybMVOKwHorEvSobVl8ym
         EZLjuOvNLG7+q83WRPARrPj75rHtmP8RILg7kJIOmXCQtXcQDqoYczrGCPMto2ktwj8L
         /IzJR50fJbgtFL/RJXvNEyWn49c8dQP2KypTPu3NbypES4trEzyk3W6UfmxbZGQHZAVc
         sSQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725956122; x=1726560922;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EPH3kBIxJYHEyTOz3p0DMAY4Ngb5KzT9ROJM3lAS0nI=;
        b=Bc8Kn2UAOCfv/WFVeJVPSiFCjoVQ1BBGhinf+g6yG7/b0btYvl99DvaXPgYgQ4Bhqf
         6hf0BIgazioLvXmA8loKnmrpt1TT6inE6f9nCoqwqFfT50gyvz8P5Lsa2hC5v6nVa3on
         EOtAdPPrIpvL2sTtQPnojTDHzKRUd/WHu64zHaLZKgIEktlU/c5rLXY1Vn2TQJRQC6qD
         z/jq/BD9pq5A4NKsAV8LFMHbOmGHHVjOgs4ne1WSz0SYN2cs+zsBPodHsso+nzEaWxw9
         bdFVI8CjJiA+Ri6yqrfbxO2rowBIqx1ZqoyOtjX0j+N6VvXbmKwogUtyFajVLseNWKWm
         o39g==
X-Forwarded-Encrypted: i=1; AJvYcCWMkaDciVjUiITX/iPEOzUveIVN1AUrxUUYiJ1SQfVkFyLSKMa4fP2MKfVtYM/iXAqywMrNXMRKAOhFdBWY@vger.kernel.org, AJvYcCX9hN0WZztfawvZ4/fZ96ZcQiAWGdEzJdLeOyUrw/8lurTAL3FZJWi0Sv7IAC7/NLzL8wLwSC9wffFQ@vger.kernel.org
X-Gm-Message-State: AOJu0YyVnKFWRMT0TOmDItux19ygVGsZQINsVXlmrdjlXd7H4CSrjrJu
	oryLVZDi3j7YrKO3nK72PVAcwdDIWd0U2iuqFoDkjU4bZZtJD8AjLRUQX/4Gq//jwoEOgf/kC28
	yfENqWBiMRnAQwE47HuB/CKvG58M=
X-Google-Smtp-Source: AGHT+IGG8v+t1ox84vNDpIPMpKr7+kqzhm0kEvCpg1x+AuL9rGZb8R/FC6FEGlWADEqUViGH0udX1S86tKQmCZ752hM=
X-Received: by 2002:ac8:7f88:0:b0:457:d461:73ed with SMTP id
 d75a77b69052e-4580c6dcfffmr188194671cf.32.1725956121527; Tue, 10 Sep 2024
 01:15:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240910030951.3670653-1-damon.ding@rock-chips.com> <20240910030951.3670653-3-damon.ding@rock-chips.com>
In-Reply-To: <20240910030951.3670653-3-damon.ding@rock-chips.com>
From: Alexey Charkov <alchark@gmail.com>
Date: Tue, 10 Sep 2024 12:15:10 +0400
Message-ID: <CABjd4YwEGR-bdT6VSJYcC_WcesCrPq1=maKmdP7=Y_fesc3oow@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] arm64: dts: rockchip: Add support for rk3588s evb1 board
To: Damon Ding <damon.ding@rock-chips.com>
Cc: heiko@sntech.de, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	macromorgan@hotmail.com, jonas@kwiboo.se, tim@feathertop.org, 
	knaerzche@gmail.com, efectn@protonmail.com, andyshrk@163.com, 
	jagan@edgeble.ai, dsimic@manjaro.org, megi@xff.cz, 
	sebastian.reichel@collabora.com, boris.brezillon@collabora.com, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Damon,

On Tue, Sep 10, 2024 at 7:11=E2=80=AFAM Damon Ding <damon.ding@rock-chips.c=
om> wrote:
>
> Specification:
> - Rockchip RK3588S
> - RK806-2x2pcs + DiscretePower
> - eMMC5.1 + SPI Flash
> - Micro SD Card3.0
> - 1 x Typec3.0 + 2 x USB2 HOST
> - 1 x 1Lane PCIE2.0 Connector(RC Mode)
> - Headphone output
> - Array Key(MENU/VOL+/VOP-/ESC), Reset, Power on/off Key
> - 6 x SARADC
>
> Signed-off-by: Damon Ding <damon.ding@rock-chips.com>
> ---
>  arch/arm64/boot/dts/rockchip/Makefile         |    1 +
>  .../boot/dts/rockchip/rk3588s-evb1-v10.dts    | 1120 +++++++++++++++++
>  2 files changed, 1121 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/rockchip/rk3588s-evb1-v10.dts
>
> diff --git a/arch/arm64/boot/dts/rockchip/Makefile b/arch/arm64/boot/dts/=
rockchip/Makefile
> index fda1b980eb4b..f2992da01ada 100644
> --- a/arch/arm64/boot/dts/rockchip/Makefile
> +++ b/arch/arm64/boot/dts/rockchip/Makefile
> @@ -139,6 +139,7 @@ dtb-$(CONFIG_ARCH_ROCKCHIP) +=3D rk3588-tiger-haikou.=
dtb
>  dtb-$(CONFIG_ARCH_ROCKCHIP) +=3D rk3588-toybrick-x0.dtb
>  dtb-$(CONFIG_ARCH_ROCKCHIP) +=3D rk3588-turing-rk1.dtb
>  dtb-$(CONFIG_ARCH_ROCKCHIP) +=3D rk3588s-coolpi-4b.dtb
> +dtb-$(CONFIG_ARCH_ROCKCHIP) +=3D rk3588s-evb1-v10.dtb
>  dtb-$(CONFIG_ARCH_ROCKCHIP) +=3D rk3588s-indiedroid-nova.dtb
>  dtb-$(CONFIG_ARCH_ROCKCHIP) +=3D rk3588s-khadas-edge2.dtb
>  dtb-$(CONFIG_ARCH_ROCKCHIP) +=3D rk3588s-nanopi-r6s.dtb
> diff --git a/arch/arm64/boot/dts/rockchip/rk3588s-evb1-v10.dts b/arch/arm=
64/boot/dts/rockchip/rk3588s-evb1-v10.dts
> new file mode 100644
> index 000000000000..83128d2d8cdd
> --- /dev/null
> +++ b/arch/arm64/boot/dts/rockchip/rk3588s-evb1-v10.dts
> @@ -0,0 +1,1120 @@

<...>

> +       pmic@1 {
> +               compatible =3D "rockchip,rk806";
> +               reg =3D <0x01>;
> +               #gpio-cells =3D <2>;
> +               gpio-controller;
> +               interrupt-parent =3D <&gpio0>;
> +               interrupts =3D <7 IRQ_TYPE_LEVEL_LOW>;
> +               pinctrl-0 =3D <&rk806_slave_dvs1_null>, <&rk806_slave_dvs=
2_null>,
> +                           <&rk806_slave_dvs3_null>;
> +               pinctrl-names =3D "default";
> +               spi-max-frequency =3D <1000000>;
> +
> +               vcc1-supply =3D <&vcc5v0_sys>;
> +               vcc2-supply =3D <&vcc5v0_sys>;
> +               vcc3-supply =3D <&vcc5v0_sys>;
> +               vcc4-supply =3D <&vcc5v0_sys>;
> +               vcc5-supply =3D <&vcc5v0_sys>;
> +               vcc6-supply =3D <&vcc5v0_sys>;
> +               vcc7-supply =3D <&vcc5v0_sys>;
> +               vcc8-supply =3D <&vcc5v0_sys>;
> +               vcc9-supply =3D <&vcc5v0_sys>;
> +               vcc10-supply =3D <&vcc5v0_sys>;
> +               vcc11-supply =3D <&vcc_2v0_pldo_s3>;
> +               vcc12-supply =3D <&vcc5v0_sys>;
> +               vcc13-supply =3D <&vcc_1v1_nldo_s3>;
> +               vcc14-supply =3D <&vcc_2v0_pldo_s3>;
> +               vcca-supply =3D <&vcc5v0_sys>;
> +
> +               rk806_slave_dvs1_null: dvs1-null-pins {
> +                       pins =3D "gpio_pwrctrl1";
> +                       function =3D "pin_fun0";
> +               };
> +
> +               rk806_slave_dvs2_null: dvs2-null-pins {
> +                       pins =3D "gpio_pwrctrl2";
> +                       function =3D "pin_fun0";
> +               };
> +
> +               rk806_slave_dvs3_null: dvs3-null-pins {
> +                       pins =3D "gpio_pwrctrl3";
> +                       function =3D "pin_fun0";
> +               };
> +
> +               regulators {
> +                       vdd_cpu_big1_s0: dcdc-reg1 {
> +                               regulator-always-on;
> +                               regulator-boot-on;

You may want to introduce regulator coupling between CPU supplies and
their respective SRAM supplies, as they are driven by separate
physical regulators and will go out of sync when cpufreq tries to
adjust frequency and voltage of the CPU cluster under load. See [1].
So perhaps:

+                               regulator-coupled-with =3D <&vdd_cpu_big1_m=
em_s0>;
+                               regulator-coupled-max-spread =3D <10000>;

> +                               regulator-init-microvolt =3D <800000>;
> +                               regulator-min-microvolt =3D <550000>;
> +                               regulator-max-microvolt =3D <1050000>;
> +                               regulator-ramp-delay =3D <12500>;
> +                               regulator-name =3D "vdd_cpu_big1_s0";
> +                               regulator-state-mem {
> +                                       regulator-off-in-suspend;
> +                               };
> +                       };
> +
> +                       vdd_cpu_big0_s0: dcdc-reg2 {
> +                               regulator-always-on;
> +                               regulator-boot-on;

+                               regulator-coupled-with =3D <&vdd_cpu_big0_m=
em_s0>;
+                               regulator-coupled-max-spread =3D <10000>;

> +                               regulator-init-microvolt =3D <800000>;
> +                               regulator-min-microvolt =3D <550000>;
> +                               regulator-max-microvolt =3D <1050000>;
> +                               regulator-ramp-delay =3D <12500>;
> +                               regulator-name =3D "vdd_cpu_big0_s0";
> +                               regulator-state-mem {
> +                                       regulator-off-in-suspend;
> +                               };
> +                       };
> +
> +                       vdd_cpu_lit_s0: dcdc-reg3 {
> +                               regulator-always-on;
> +                               regulator-boot-on;

+                               regulator-coupled-with =3D <&vdd_cpu_lit_me=
m_s0>;
+                               regulator-coupled-max-spread =3D <10000>;

> +                               regulator-init-microvolt =3D <800000>;
> +                               regulator-min-microvolt =3D <550000>;
> +                               regulator-max-microvolt =3D <950000>;
> +                               regulator-ramp-delay =3D <12500>;
> +                               regulator-name =3D "vdd_cpu_lit_s0";
> +                               regulator-state-mem {
> +                                       regulator-off-in-suspend;
> +                               };
> +                       };
> +
> +                       vcc_3v3_s3: dcdc-reg4 {
> +                               regulator-always-on;
> +                               regulator-boot-on;
> +                               regulator-min-microvolt =3D <3300000>;
> +                               regulator-max-microvolt =3D <3300000>;
> +                               regulator-ramp-delay =3D <12500>;
> +                               regulator-name =3D "vcc_3v3_s3";
> +                               regulator-state-mem {
> +                                       regulator-on-in-suspend;
> +                                       regulator-suspend-microvolt =3D <=
3300000>;
> +                               };
> +                       };
> +
> +                       vdd_cpu_big1_mem_s0: dcdc-reg5 {
> +                               regulator-always-on;
> +                               regulator-boot-on;

+                               regulator-coupled-with =3D <&vdd_cpu_big1_s=
0>;
+                               regulator-coupled-max-spread =3D <10000>;

> +                               regulator-init-microvolt =3D <800000>;
> +                               regulator-min-microvolt =3D <675000>;
> +                               regulator-max-microvolt =3D <1050000>;
> +                               regulator-ramp-delay =3D <12500>;
> +                               regulator-name =3D "vdd_cpu_big1_mem_s0";
> +                               regulator-state-mem {
> +                                       regulator-off-in-suspend;
> +                               };
> +                       };
> +
> +
> +                       vdd_cpu_big0_mem_s0: dcdc-reg6 {
> +                               regulator-always-on;
> +                               regulator-boot-on;

+                               regulator-coupled-with =3D <&vdd_cpu_big0_s=
0>;
+                               regulator-coupled-max-spread =3D <10000>;

> +                               regulator-init-microvolt =3D <800000>;
> +                               regulator-min-microvolt =3D <675000>;
> +                               regulator-max-microvolt =3D <1050000>;
> +                               regulator-ramp-delay =3D <12500>;
> +                               regulator-name =3D "vdd_cpu_big0_mem_s0";
> +                               regulator-state-mem {
> +                                       regulator-off-in-suspend;
> +                               };
> +                       };
> +
> +                       vcc_1v8_s0: dcdc-reg7 {
> +                               regulator-always-on;
> +                               regulator-boot-on;
> +                               regulator-min-microvolt =3D <1800000>;
> +                               regulator-max-microvolt =3D <1800000>;
> +                               regulator-ramp-delay =3D <12500>;
> +                               regulator-name =3D "vcc_1v8_s0";
> +                               regulator-state-mem {
> +                                       regulator-off-in-suspend;
> +                               };
> +                       };
> +
> +                       vdd_cpu_lit_mem_s0: dcdc-reg8 {
> +                               regulator-always-on;
> +                               regulator-boot-on;

+                               regulator-coupled-with =3D <&vdd_cpu_lit_s0=
>;
+                               regulator-coupled-max-spread =3D <10000>;

> +                               regulator-init-microvolt =3D <800000>;
> +                               regulator-min-microvolt =3D <675000>;
> +                               regulator-max-microvolt =3D <950000>;
> +                               regulator-ramp-delay =3D <12500>;
> +                               regulator-name =3D "vdd_cpu_lit_mem_s0";
> +                               regulator-state-mem {
> +                                       regulator-off-in-suspend;
> +                               };
> +                       };

<...>

[1] https://github.com/torvalds/linux/commit/0ba0560982bc8d0c3fb3ca209fd0ed=
29f81402ac

Best regards,
Alexey

