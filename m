Return-Path: <linux-kernel+bounces-264120-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B09293DF1C
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jul 2024 13:15:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1E7B71C211FE
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jul 2024 11:15:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DF726BB5B;
	Sat, 27 Jul 2024 11:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JnXROIeJ"
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF7C84CB37
	for <linux-kernel@vger.kernel.org>; Sat, 27 Jul 2024 11:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722078917; cv=none; b=Obqv1gsAo6LIV7r2nRK7ZVuCKiE1tLswi1cw29zbS5Ls35lZmgo4VWQFTWAOIpiUFjC87TkCJhjfkhGsmv6i7ZYgqBfwa60c6PZIgiZ5FLyIvLL947nNwUzFU8fcZH8gxOxci3Y+Gors44zbrrUKRhA09tTPXmDUzB6mONTpt4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722078917; c=relaxed/simple;
	bh=XW+Sl05nPKtK0oJETkXKZKjWld845FHy7XWyvct8PHo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OI2A3sjGGQobifY3GJ5J7MHg8Mi0nxkocFe10/1S2maTw+HtHft1qCsTyVnQuRjAxgzE+SM687wHCof/Y4Xc5/3iBUo+7WNtPEze1CbbgQsk77gPcLUtt0UnW348rG7Fpt6J0Pk4+VmKx5NFW10pOrIhZdC1dwZnkNG0XvpW/Pw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=JnXROIeJ; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2ee920b0781so22304721fa.1
        for <linux-kernel@vger.kernel.org>; Sat, 27 Jul 2024 04:15:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1722078913; x=1722683713; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=F6IkcugCt219ovB+QT/C8OnX7+9cAi+LnPtWh9ZzNwI=;
        b=JnXROIeJjlxYnQ5Wj4iudV+2+ZlQDYVIvKPX9xB4wwvBCQpVdgDYzlhLCEzDB6Qz6D
         Ol4XsLK0AUZyS+y2weXpzsnJtX1KKT6+0dhpv8pTt7YSUsB74atuHfs2bmdtqsBwGiXu
         C5D3d/mlRZu+lS+TvrYluRMMKeFVZtdFUtrVlvjk3RmDMgvOi0dG8GNreqLb67AcFsV4
         sTPBbS+lNVlxtK2m5LO1rZ5LOhUmyegcQh/k6INpMnowynn9GO0EG0t2We/J8CPPfhYg
         +izhdLtwXzK4ONyzqe5UkOE3mAjfXUVFEpZnnn0uxA94I5EyJlOfRVi0X0gAKqm0b23E
         Rnug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722078913; x=1722683713;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F6IkcugCt219ovB+QT/C8OnX7+9cAi+LnPtWh9ZzNwI=;
        b=m8OysMmAVaVhoB5lzbC8YlQtJMQ6BvnmPmtmUCK0DD8DY4K2s2b0G02I2G+Q4RSUCt
         tWLk7kb5aC50aslG/HwFEAuIQCPaswQk2Bbi28pg/0I0/tcuoS4b8Y5BfDlV4GcKFXvb
         bPM/tAWFLintiEbFv5zVoiICZPth45KxTpwt7tukP1V0D6GNvdPNBOCZBIeB6i1TGlfZ
         dxs2/ESw3yDHLD38Oibm/9SFUEm2IbSL90RCNLEQj3Bx9z+514SHZp6/32innfj+5trD
         zIFINNHBiLobA64/2sT5+Zmt6tUPFK9zlvc+mXGRX+5h0ZOhABFJMnLz5OU8TnW1jq3i
         wuKg==
X-Forwarded-Encrypted: i=1; AJvYcCVI4DCJMYcwHwj8ICca4Y3RvGcKcwNKFj18jlIZNlgdbnM3Y/YL5qBuj2vFzwhVkAdOc2hB6clsToN6y8gYuP9d5Nloe58CKLqvi/45
X-Gm-Message-State: AOJu0YxFy6r68v+nzT1AiZMIo8zIiMjGd+XtHvbV+sqPC3vKavq2VI6z
	VroHQbbmkLH/rAtNGckfq6GZt+jY7M/CSnSKpZLdy7V+uxyEr66tZlq3qjiylcY=
X-Google-Smtp-Source: AGHT+IFVXUmMe+3AT1Z/H4tmBdr6d67ABfA5prOEZcm0+0GcEzV9I7RRCuZCY8eehOOL6sI8HfvrCg==
X-Received: by 2002:a2e:9d99:0:b0:2ef:24dd:8d86 with SMTP id 38308e7fff4ca-2f12ee634a8mr12638391fa.49.1722078912885;
        Sat, 27 Jul 2024 04:15:12 -0700 (PDT)
Received: from eriador.lumag.spb.ru (dzdbxzyyyyyyyyyyybrhy-3.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2f03cf0f9bfsm6943141fa.16.2024.07.27.04.15.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Jul 2024 04:15:12 -0700 (PDT)
Date: Sat, 27 Jul 2024 14:15:10 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Liu Ying <victor.liu@nxp.com>
Cc: devicetree@vger.kernel.org, imx@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, shawnguo@kernel.org, 
	s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com, saravanak@google.com
Subject: Re: [RFC PATCH] ARM: dts: imx53-qsb: Add MCIMX-LVDS1 display module
 support
Message-ID: <xoj4sypxndql62k64ztmco5ufddeysp26fyc46prwr4ezik223@sssy5zmefwtg>
References: <20240726065012.618606-1-victor.liu@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240726065012.618606-1-victor.liu@nxp.com>

On Fri, Jul 26, 2024 at 02:50:12PM GMT, Liu Ying wrote:
> MCIMX-LVDS1[1] display module integrates a HannStar HSD100PXN1 LVDS
> display panel and a touch IC.  Add an overlay to support the LVDS
> panel on i.MX53 QSB / QSRB platforms.
> 
> [1] https://www.nxp.com/part/MCIMX-LVDS1
> 
> Signed-off-by: Liu Ying <victor.liu@nxp.com>
> ---
> I mark RFC in patch subject prefix because if the DT overlay is used, both ldb
> and panel devices end up as devices deferred.  However, if the DT overlay is
> not used and the devices are defined in imx53-qsb-common.dtsi, then they can be
> probed ok.
> 
> With a dev_err_probe() added to imx_ldb_probe() in imx-ldb.c, devices_deferred
> indicates 53fa8008.ldb and panel-lvds kind of depend on each other.
> 
> root@imx53qsb:~# cat /sys/kernel/debug/devices_deferred
> 53fa8008.ldb    imx-ldb: failed to find panel or bridge for channel0
> panel-lvds      platform: wait for supplier /soc/bus@50000000/ldb@53fa8008/lvds-channel@0
> 
> It looks like the issue is related to fw_devlink, because if "fw_devlink=off"
> is added to kernel bootup command line, then the issue doesn't happen.

Could you please fdtdump /sys/firmware/fdt (or just generated DTB files)
in both cases and compare the dumps for sensible differences?

> 
> Saravana, DT folks, any ideas?
> 
> Thanks.
> 
>  arch/arm/boot/dts/nxp/imx/Makefile            |  4 ++
>  .../boot/dts/nxp/imx/imx53-qsb-common.dtsi    |  4 +-
>  .../dts/nxp/imx/imx53-qsb-mcimx-lvds1.dtso    | 43 +++++++++++++++++++
>  3 files changed, 49 insertions(+), 2 deletions(-)
>  create mode 100644 arch/arm/boot/dts/nxp/imx/imx53-qsb-mcimx-lvds1.dtso
> 
> diff --git a/arch/arm/boot/dts/nxp/imx/Makefile b/arch/arm/boot/dts/nxp/imx/Makefile
> index 92e291603ea1..7116889e1515 100644
> --- a/arch/arm/boot/dts/nxp/imx/Makefile
> +++ b/arch/arm/boot/dts/nxp/imx/Makefile
> @@ -46,8 +46,10 @@ dtb-$(CONFIG_SOC_IMX53) += \
>  	imx53-ppd.dtb \
>  	imx53-qsb.dtb \
>  	imx53-qsb-hdmi.dtb \
> +	imx53-qsb-mcimx-lvds1.dtb \
>  	imx53-qsrb.dtb \
>  	imx53-qsrb-hdmi.dtb \
> +	imx53-qsrb-mcimx-lvds1.dtb \
>  	imx53-sk-imx53.dtb \
>  	imx53-sk-imx53-atm0700d4-lvds.dtb \
>  	imx53-sk-imx53-atm0700d4-rgb.dtb \
> @@ -57,7 +59,9 @@ dtb-$(CONFIG_SOC_IMX53) += \
>  	imx53-usbarmory.dtb \
>  	imx53-voipac-bsb.dtb
>  imx53-qsb-hdmi-dtbs := imx53-qsb.dtb imx53-qsb-hdmi.dtbo
> +imx53-qsb-mcimx-lvds1-dtbs := imx53-qsb.dtb imx53-qsb-mcimx-lvds1.dtbo
>  imx53-qsrb-hdmi-dtbs := imx53-qsrb.dtb imx53-qsb-hdmi.dtbo
> +imx53-qsrb-mcimx-lvds1-dtbs := imx53-qsrb.dtb imx53-qsb-mcimx-lvds1.dtbo
>  dtb-$(CONFIG_SOC_IMX6Q) += \
>  	imx6dl-alti6p.dtb \
>  	imx6dl-apf6dev.dtb \
> diff --git a/arch/arm/boot/dts/nxp/imx/imx53-qsb-common.dtsi b/arch/arm/boot/dts/nxp/imx/imx53-qsb-common.dtsi
> index 05d7a462ea25..430792a91ccf 100644
> --- a/arch/arm/boot/dts/nxp/imx/imx53-qsb-common.dtsi
> +++ b/arch/arm/boot/dts/nxp/imx/imx53-qsb-common.dtsi
> @@ -16,7 +16,7 @@ memory@70000000 {
>  		      <0xb0000000 0x20000000>;
>  	};
>  
> -	backlight_parallel: backlight-parallel {
> +	backlight: backlight {

Nit: this seems unrelated to the LVDS support

>  		compatible = "pwm-backlight";
>  		pwms = <&pwm2 0 5000000 0>;
>  		brightness-levels = <0 4 8 16 32 64 128 255>;
> @@ -89,7 +89,7 @@ panel_dpi: panel {
>  		compatible = "sii,43wvf1g";
>  		pinctrl-names = "default";
>  		pinctrl-0 = <&pinctrl_display_power>;
> -		backlight = <&backlight_parallel>;
> +		backlight = <&backlight>;
>  		enable-gpios = <&gpio3 24 GPIO_ACTIVE_HIGH>;
>  
>  		port {
> diff --git a/arch/arm/boot/dts/nxp/imx/imx53-qsb-mcimx-lvds1.dtso b/arch/arm/boot/dts/nxp/imx/imx53-qsb-mcimx-lvds1.dtso
> new file mode 100644
> index 000000000000..27f6bedf3d39
> --- /dev/null
> +++ b/arch/arm/boot/dts/nxp/imx/imx53-qsb-mcimx-lvds1.dtso
> @@ -0,0 +1,43 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +/*
> + * Copyright 2024 NXP
> + */
> +
> +/dts-v1/;
> +/plugin/;
> +
> +&{/} {
> +	panel-lvds {

Nit: Just 'panel' should be enough.

> +		compatible = "hannstar,hsd100pxn1";
> +		backlight = <&backlight>;
> +		power-supply = <&reg_3p2v>;
> +
> +		port {
> +			panel_lvds_in: endpoint {
> +				remote-endpoint = <&lvds0_out>;
> +			};
> +		};
> +	};
> +};
> +
> +&ldb {
> +	#address-cells = <1>;
> +	#size-cells = <0>;
> +	status = "okay";
> +
> +	lvds-channel@0 {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		fsl,data-mapping = "spwg";
> +		fsl,data-width = <18>;
> +		status = "okay";
> +
> +		port@2 {
> +			reg = <2>;
> +
> +			lvds0_out: endpoint {
> +				remote-endpoint = <&panel_lvds_in>;
> +			};
> +		};
> +	};
> +};
> -- 
> 2.34.1
> 

-- 
With best wishes
Dmitry

