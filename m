Return-Path: <linux-kernel+bounces-566265-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B8E9CA675A9
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 14:56:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B45EB188F254
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 13:54:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAFF920DD6D;
	Tue, 18 Mar 2025 13:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fd6/juyD"
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE51520D4FC;
	Tue, 18 Mar 2025 13:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742306056; cv=none; b=tbJVfFpFigXovDdPOFrwks0lyvJGTnV7OiQRzzzK5FChCHQhc9ZKnmLMKUshidXGflsadc22utrFqM0SmHzkdlu9NbfRR5T7RnK7wqgp20FQSH1bAIKmgzSXG329CF4L+AawMQHwOR4sqhFfRoNB6FCOjB3x+SdndLkwJLYBp9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742306056; c=relaxed/simple;
	bh=CxOI8mwu7JtKIevWK8uvc5MGY2JFwokUpAABhDp1EF4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aed4ggF7MBwzGJ0O9g8sMah3r63GbPgvBQBXdN39nNHJn9IFnfDOgQnaYSodB/w8GpoDeLcU40wVtjsDjhrnPvMIlvfqGBbMMwi4GdfVMdcFCW24xijEWpHUR07hSSjBFZlcdBOUVh/oRNUdJPo2V/txmA23K2hGx6VGOTYa3KM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fd6/juyD; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-aaf0f1adef8so522420366b.3;
        Tue, 18 Mar 2025 06:54:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742306049; x=1742910849; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ioS2cZEy0ukzwLsu1UzbYL55bIz2RUYjyFsEjQ2qJY4=;
        b=fd6/juyDlJCljQMfoOpSNiOXh5z2WZvQkmV5y8Ebt+r+cHXn5KGyzDBjEITe9uq/VJ
         hsTrQoSY8Lx/EIIMxz0t3KR66SmVW1xm2WYXn1uGKhTKRqnoDCS+bgc32Zj4Szx6/zJ5
         EYdJMRQk/xzZ5F/tqNBmilkEAPyj7hsIHVCfQsvlU6U1lWGCwD3wIIIRU5GhTvVDOnLL
         5kLVC4enKsbEzOBV5w0yTpg1bTVmy2fCBYhhP5jONl7KngeeVQuLOThs6EI5886XK8Ay
         VymEmRWlnap7TqpwUMhOV5ceXnvHdYDM6PcJ+wrvr6vWkru+0r8v54//Bfq34/+4ASbx
         H2zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742306049; x=1742910849;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ioS2cZEy0ukzwLsu1UzbYL55bIz2RUYjyFsEjQ2qJY4=;
        b=VfFZ1Uf+eDoW3uKKJ+HiGGP76lKe7QnroRo0f9zgr7hUQ7mMMKCuz6ND/Co87v7qT1
         dvpNGYf3lNaQy7OPfJRS9IqHPfZwr/En35CbwB+hb67ZE0xyZKaGcF3J6hQXb0XG96V9
         IudsFdNVAM30yRH23jQzQT296gWxI/N/npdJwujtnPNjpUFv2nr5q0piySYtxDlh403+
         LzraqSosGsf52hY8jbpIH1KDqJZFw8zIKfrPUyMtG5tBuvTUua9FJHjszQeaqQSDtPy/
         aZSNYgC6yryq8jQgK17vPdDuLQH68HQCqZ9ng1HAa5+L2H13XqwMfUpIVIZxmbowRyP5
         2w9g==
X-Forwarded-Encrypted: i=1; AJvYcCUN9zikLxc7WFu8TjDLzrc2a+NM2BpnGdUrAVL4l0/CW2TH3ZIzJwX74tQz5DfrYsGSZ9tsmzAjQdD+@vger.kernel.org, AJvYcCVtaGeG9lamW423osLew6W8hbnl5oO8Do+u7uoj2Bp8OoZc/tU5qoU55+b734IZQd6BPGW7l+vC/aiCq8ty@vger.kernel.org, AJvYcCXTgZ3OArlaa6a2PWYOQ1MLzCF6toaw8p6MrsAJ647WxID9dTvugaBzXV67gunzFd4CyoAttxnz/pBW@vger.kernel.org
X-Gm-Message-State: AOJu0YwQro1/UocRuZUrC2EsidTX6hC3ECilcMkECpOgpEC8RfZpK3jh
	ORcv8K6YFDqhfO9dBCGaRSPnELb+zhpnFT2ZPNFAL4InJ/sYusmT
X-Gm-Gg: ASbGncv1IhUMot3bUGj/235NE4dOrE9A6hzxBEpOBtpjDGRMFtpzY79h5fErvhfkLB+
	Tjjg09tgb4SVb30Wosh8B3FiYfZGncJU6QLPakGbn5TUnaScZOeRkZrUOn/Theurb/1ASJfg9Zh
	yJJqO3d+5swdjKxJNC1dcyW7wewoOOnlAuMx+7tS9Cps83h1ePtWI73slvc97Y+DhM0U+XN0NqL
	M36HpiVZmezd0A5JEHlwDTInI7Mwe3fp0FoXf9zy+uPi9KFlMXqSkvD+qe2e/UmMMNG/HWBAGxo
	tgFmHUXtnID2BhB0xWdizR6znwC4zBL+LtkeaaozVCMkrvAxkYnbRaqzE5+nG7j1ykokeUzwFr5
	mhj3RcEIGbcsZmOUWR7FsyzbaC/fTUGhHhMAXmUGt8YEZbw==
X-Google-Smtp-Source: AGHT+IHmjQU+EohyzzTayMACB/7/c62nd81pThtraC244l6FOU5kzeMBypubUIwPfYcCsaGXQp9bZw==
X-Received: by 2002:a17:907:6ea9:b0:abf:74d6:e2b0 with SMTP id a640c23a62f3a-ac3301db34fmr1803410066b.3.1742306048621;
        Tue, 18 Mar 2025 06:54:08 -0700 (PDT)
Received: from alb3rt0-ThinkPad-P15-Gen-1 (host-95-251-108-181.retail.telecomitalia.it. [95.251.108.181])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac3149cfb96sm840601766b.119.2025.03.18.06.54.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Mar 2025 06:54:08 -0700 (PDT)
Date: Tue, 18 Mar 2025 14:54:05 +0100
From: Alberto Merciai <alb3rt0.m3rciai@gmail.com>
To: Pankaj Gupta <pankaj.gupta@nxp.com>
Cc: Jonathan Corbet <corbet@lwn.net>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v13 3/5] arm64: dts: imx8ulp-evk: add nxp secure enclave
 firmware
Message-ID: <Z9l6/WKTmBvzjEfn@alb3rt0-ThinkPad-P15-Gen-1>
References: <20250311-imx-se-if-v13-0-9cc6d8fd6d1c@nxp.com>
 <20250311-imx-se-if-v13-3-9cc6d8fd6d1c@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250311-imx-se-if-v13-3-9cc6d8fd6d1c@nxp.com>

On Tue, Mar 11, 2025 at 09:09:34PM +0530, Pankaj Gupta wrote:
> Add support for NXP secure enclave called EdgeLock Enclave
> firmware (se-fw) for imx8ulp-evk.
> 
> EdgeLock Enclave has a hardware limitation of restricted access to DDR
> address: 0x80000000 to 0xAFFFFFFF, so reserve 1MB of DDR memory region
> from 0x80000000.
> 
> Signed-off-by: Pankaj Gupta <pankaj.gupta@nxp.com>
> ---
>  arch/arm64/boot/dts/freescale/imx8ulp-evk.dts | 17 ++++++++++++++++-
>  arch/arm64/boot/dts/freescale/imx8ulp.dtsi    | 13 +++++++++++--
>  2 files changed, 27 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/freescale/imx8ulp-evk.dts b/arch/arm64/boot/dts/freescale/imx8ulp-evk.dts
> index 290a49bea2f7..a25d71bf2c26 100644
> --- a/arch/arm64/boot/dts/freescale/imx8ulp-evk.dts
> +++ b/arch/arm64/boot/dts/freescale/imx8ulp-evk.dts
> @@ -1,6 +1,6 @@
>  // SPDX-License-Identifier: (GPL-2.0+ OR MIT)
>  /*
> - * Copyright 2021 NXP
> + * Copyright 2021, 2025 NXP
>   */
>  
>  /dts-v1/;
> @@ -24,6 +24,17 @@ memory@80000000 {
>  		device_type = "memory";
>  		reg = <0x0 0x80000000 0 0x80000000>;
>  	};
> +	reserved-memory {
> +		#address-cells = <2>;
> +		#size-cells = <2>;
> +		ranges;
> +
> +		ele_reserved: ele-reserved@90000000 {
> +			compatible = "shared-dma-pool";
> +			reg = <0 0x90000000 0 0x100000>;
> +			no-map;
> +		};
> +	};
>  
>  	reserved-memory {
>  		#address-cells = <2>;
> @@ -259,6 +270,10 @@ &usdhc0 {
>  	status = "okay";
>  };
>  
> +&hsm0 {
> +	memory-region = <&ele_reserved>;
> +};
> +
>  &fec {
>  	pinctrl-names = "default", "sleep";
>  	pinctrl-0 = <&pinctrl_enet>;
> diff --git a/arch/arm64/boot/dts/freescale/imx8ulp.dtsi b/arch/arm64/boot/dts/freescale/imx8ulp.dtsi
> index 2562a35286c2..c79a5de227b3 100644
> --- a/arch/arm64/boot/dts/freescale/imx8ulp.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx8ulp.dtsi
> @@ -1,6 +1,6 @@
>  // SPDX-License-Identifier: (GPL-2.0+ OR MIT)
>  /*
> - * Copyright 2021 NXP
> + * Copyright 2021, 2025 NXP
>   */
>  
>  #include <dt-bindings/clock/imx8ulp-clock.h>
> @@ -154,7 +154,7 @@ sosc: clock-sosc {
>  		#clock-cells = <0>;
>  	};
>  
> -	sram@2201f000 {
> +	sram0: sram@2201f000 {
>  		compatible = "mmio-sram";
>  		reg = <0x0 0x2201f000 0x0 0x1000>;
>  
> @@ -169,6 +169,8 @@ scmi_buf: scmi-sram-section@0 {
>  	};
>  
>  	firmware {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
>  		scmi {
>  			compatible = "arm,scmi-smc";
>  			arm,smc-id = <0xc20000fe>;
> @@ -186,6 +188,13 @@ scmi_sensor: protocol@15 {
>  				#thermal-sensor-cells = <1>;
>  			};
>  		};
> +
> +		hsm0: secure-enclave {
> +			 compatible = "fsl,imx8ulp-se-ele-hsm";
> +			 mbox-names = "tx", "rx";
> +			 mboxes = <&s4muap 0 0>, <&s4muap 1 0>;
> +			 sram = <&sram0>;
> +		 };
>  	};
>  
>  	cm33: remoteproc-cm33 {
> 
> -- 
> 2.43.0
> 
> 
Hello,

I'm trying to test that solution with imx93-evk-11x11.

Driver is loaded fine:
[    2.098390] fsl-se firmware:ele-if@0: i.MX secure-enclave: hsm0 interface to firmware, configured.
and I was able to expose /dev/hsm0_ch0 to userland.

Can you share me tests that I can run against that device?

Thanks,
Alberto

