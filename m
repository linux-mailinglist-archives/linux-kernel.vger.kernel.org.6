Return-Path: <linux-kernel+bounces-383698-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 78AA99B1F39
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Oct 2024 17:35:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 37A76281746
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Oct 2024 16:35:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1565E762E0;
	Sun, 27 Oct 2024 16:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="tjJ+D6ZH"
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D60F3161
	for <linux-kernel@vger.kernel.org>; Sun, 27 Oct 2024 16:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730046951; cv=none; b=C32aTz62xQNh0A5l/enoiLuhN/cDH9YC9zshrx9sqRvjBFuJtPCj14eAohV3BuZtiDFLc6e1vyTFfAQP+jQjLe9yl2kEyoy1uJ3YiBN4cJX36SSNPzlDS+cW6GUGn6EdQn6Og4+yh5yAVXwhmmzIoHoFigWoCGNAPR04noKamH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730046951; c=relaxed/simple;
	bh=AlYvdMPybVErEAX/9fH2PozFgRO7wzNvwnwb7UXwn8U=;
	h=From:In-Reply-To:References:Mime-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YKc2FrUH9NxZAJ7iWy+QWf4AXsUkLNsvOoy3xkchDvpSjeAHeSKcPGBMkWHRFV/ejdJxLeGIOOnvzxERLA7WBfbzE/cNxJFgWK6bwfu0pgjGcsld1mDco/+kiiJlz5uEwVKOpuX0xscMCpqcArcOHM7ElPmMZa6xkL7QI/ynyQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=tjJ+D6ZH; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-oa1-f72.google.com (mail-oa1-f72.google.com [209.85.160.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 3D4603F297
	for <linux-kernel@vger.kernel.org>; Sun, 27 Oct 2024 16:35:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1730046943;
	bh=AS3d1idyi67yhm3sH0WkCViihKLdaz8goaiNUlUugUw=;
	h=From:In-Reply-To:References:Mime-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type;
	b=tjJ+D6ZHJ1egn9pKOX//QiNsiKnEjbm5wXa7mmv8QnQwSVMR/PYQEE5j5TlfUvALn
	 KMRKNYmV4w8btmAKuMZXxVPqeoDrFEd/zyy6cZ9zq8L1scc2VPjPxYsTvzg6YxRMdp
	 iUaHMVL8BuTykYOS4HNY9G3HJ0ShJkRQsx8u04BnUoPED7jXRGZwm385q6d27m7ali
	 WMcq7fOOvXr7GcVwL3eQO4x2CeM6vkV0IxR2+mFAXly6jpWQ2nj8h7Zy5lhk1qbq9P
	 qF3EO2S61Eoa2vm6uFebGqyaC1fCiXKkAdLXSDW1CzNp2L3BkfMoEOG8tK63kSVlrX
	 STJ2kwVTq4z5A==
Received: by mail-oa1-f72.google.com with SMTP id 586e51a60fabf-2885c5af51cso5735329fac.3
        for <linux-kernel@vger.kernel.org>; Sun, 27 Oct 2024 09:35:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730046942; x=1730651742;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AS3d1idyi67yhm3sH0WkCViihKLdaz8goaiNUlUugUw=;
        b=Ji03ndvrBlZ5k14XRUV9eXooKgH1QWwH+sYHq2qtUdpJ4obVfM+gG9i3vhXckV6EGi
         vFUiW9YJelSamQ33pbM/V/VAvsdPhvZcqN3OdpjIPnk/tQGqNkYN2/hQ0RlU+IJ1pL/r
         zponBkj1CkIevf2ry2h0A2LXRJ+4Z4PJbvtRzsW23OcCsHJU0ZnHCZkR84lqwt9WOLJE
         HQVhdDzJG8cHl+d225ZD/2sxtBLlrRLYz7G9ksSCgtQn+aq8Xu3/pGQZYLnMQQEFxzcT
         /VtGiyg983x8rQ3nnNqxuh9dDwcc5kMiRZ9eK+os8Mc95ouJ6cZ6cYnuNvXdoWvMOYtl
         SO0Q==
X-Forwarded-Encrypted: i=1; AJvYcCXYerP+P1AJjLAiR9g7YQ9FvHDM88w9+h/SWoyXQbDowQxTSDt8PDz78CH81yjn10AHCPK9ZNr/RQsi98I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5GHYitVTn+vsP0sPhA2Ik0FB38bingjRfmUupVCfiEUT4oqRB
	IjfTp01yY1DfZ/G7OLB0ymGV/9Hq4wp3EI8B57xnfM3vigxi6Izais7Ilo/eK1GGSLVDZ0UagCq
	CVmkMH+e+wSwUROem8z+uyyP4FKhUHIpebpK5yj5LVH78yXqqCWZHsnAyj2Zha+s2GUttbIs4n/
	6e6QcUD8X50FnIUCwuDUP9jws4OzX0TUCh6/E/0tQw67HZUhoG9f/3
X-Received: by 2002:a05:6870:d146:b0:25e:1610:9705 with SMTP id 586e51a60fabf-29051b02dbbmr3856648fac.2.1730046942088;
        Sun, 27 Oct 2024 09:35:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGUm8dRcl5FUlikyMPXfT5+z8OZ8NQmE4kXNKT5ygN0pDp+fWfRSCfmaW6cV2Gqzx+DXyDyNOUUgC8HIji1dHw=
X-Received: by 2002:a05:6870:d146:b0:25e:1610:9705 with SMTP id
 586e51a60fabf-29051b02dbbmr3856618fac.2.1730046941756; Sun, 27 Oct 2024
 09:35:41 -0700 (PDT)
Received: from 348282803490 named unknown by gmailapi.google.com with
 HTTPREST; Sun, 27 Oct 2024 09:35:41 -0700
From: Emil Renner Berthing <emil.renner.berthing@canonical.com>
In-Reply-To: <20241027144448.1813611-2-guodong@riscstar.com>
References: <20241027144448.1813611-1-guodong@riscstar.com> <20241027144448.1813611-2-guodong@riscstar.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Date: Sun, 27 Oct 2024 09:35:41 -0700
Message-ID: <CAJM55Z-xxbUY9nyjt8TsqzknY4NNUiqJEi1XeLK-ytFpjDVvOg@mail.gmail.com>
Subject: Re: [PATCH v6 1/5] riscv: dts: starfive: jh7110-common: revised
 device node
To: Guodong Xu <guodong@riscstar.com>, Conor Dooley <conor@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Emil Renner Berthing <kernel@esmil.dk>, rafal@milecki.pl, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Heiko Stuebner <heiko.stuebner@cherry.de>, Michael Zhu <michael.zhu@starfivetech.com>, 
	Drew Fustini <drew@beagleboard.org>, Alexandru Stan <ams@frame.work>, Daniel Schaefer <dhs@frame.work>, 
	Sandie Cao <sandie.cao@deepcomputing.io>, Yuning Liang <yuning.liang@deepcomputing.io>, 
	Huiming Qiu <huiming.qiu@deepcomputing.io>, Alex Elder <elder@riscstar.com>, linux@frame.work, 
	devicetree@vger.kernel.org, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Guodong Xu wrote:
> Earlier this year a new DTSI file was created to define common
> properties for the StarFive VisionFive 2 and Milk-V Mars boards,
> both of which use the StarFive JH7110 SoC.  The Pine64 Star64
> board has also been added since that time.
>
> Some of the nodes defined in "jh7110-common.dtsi" are enabled in
> that file because all of the boards including it "want" them
> enabled.
>
> An upcoming patch enables another JH7110 board, but for that
> board not all of these common nodes should be enabled.  Prepare
> for supporting the new board by avoiding enabling these nodes in
> "jh711-common.dtsi", and enable them instead in these files:

jh7110-common.dtsi

>    jh7110-milkv-mars.dts
>    jh7110-pine64-star64.dts
>    jh7110-starfive-visionfive-2.dtsi
>
> Signed-off-by: Alex Elder <elder@riscstar.com>
> Signed-off-by: Guodong Xu <guodong@riscstar.com>
> ---
> v6: New patch
>
>  .../boot/dts/starfive/jh7110-common.dtsi      |  5 -----
>  .../boot/dts/starfive/jh7110-milkv-mars.dts   | 17 ++++++++++++++++
>  .../dts/starfive/jh7110-pine64-star64.dts     | 17 ++++++++++++++++
>  .../jh7110-starfive-visionfive-2.dtsi         | 20 +++++++++++++++++++
>  4 files changed, 54 insertions(+), 5 deletions(-)
>

From here..

> diff --git a/arch/riscv/boot/dts/starfive/jh7110-common.dtsi b/arch/riscv/boot/dts/starfive/jh7110-common.dtsi
> index c7771b3b6475..9e77f79ec162 100644
> --- a/arch/riscv/boot/dts/starfive/jh7110-common.dtsi
> +++ b/arch/riscv/boot/dts/starfive/jh7110-common.dtsi
>  .../boot/dts/starfive/jh7110-common.dtsi      |  5 -----
>  .../boot/dts/starfive/jh7110-milkv-mars.dts   | 17 ++++++++++++++++
>  .../dts/starfive/jh7110-pine64-star64.dts     | 17 ++++++++++++++++
>  .../jh7110-starfive-visionfive-2.dtsi         | 20 +++++++++++++++++++
>  4 files changed, 54 insertions(+), 5 deletions(-)

..to here seems to be added by mistake. At least my "git am" wouldn't apply it
like this.

With that fixed this looks good to me, thanks.

Reviewed-by: Emil Renner Berthing <emil.renner.berthing@canonical.com>

> diff --git a/arch/riscv/boot/dts/starfive/jh7110-common.dtsi b/arch/riscv/boot/dts/starfive/jh7110-common.dtsi
> index c7771b3b6475..9e77f79ec162 100644
> --- a/arch/riscv/boot/dts/starfive/jh7110-common.dtsi
> +++ b/arch/riscv/boot/dts/starfive/jh7110-common.dtsi
> @@ -176,7 +176,6 @@ csi2rx_to_camss: endpoint {
>  &gmac0 {
>  	phy-handle = <&phy0>;
>  	phy-mode = "rgmii-id";
> -	status = "okay";
>
>  	mdio {
>  		#address-cells = <1>;
> @@ -196,7 +195,6 @@ &i2c0 {
>  	i2c-scl-falling-time-ns = <510>;
>  	pinctrl-names = "default";
>  	pinctrl-0 = <&i2c0_pins>;
> -	status = "okay";
>  };
>
>  &i2c2 {
> @@ -311,7 +309,6 @@ &pcie1 {
>  &pwmdac {
>  	pinctrl-names = "default";
>  	pinctrl-0 = <&pwmdac_pins>;
> -	status = "okay";
>  };
>
>  &qspi {
> @@ -350,13 +347,11 @@ uboot@100000 {
>  &pwm {
>  	pinctrl-names = "default";
>  	pinctrl-0 = <&pwm_pins>;
> -	status = "okay";
>  };
>
>  &spi0 {
>  	pinctrl-names = "default";
>  	pinctrl-0 = <&spi0_pins>;
> -	status = "okay";
>
>  	spi_dev0: spi@0 {
>  		compatible = "rohm,dh2228fv";
> diff --git a/arch/riscv/boot/dts/starfive/jh7110-milkv-mars.dts b/arch/riscv/boot/dts/starfive/jh7110-milkv-mars.dts
> index 5cb9e99e1dac..66ad3eb2fd66 100644
> --- a/arch/riscv/boot/dts/starfive/jh7110-milkv-mars.dts
> +++ b/arch/riscv/boot/dts/starfive/jh7110-milkv-mars.dts
> @@ -15,6 +15,11 @@ &gmac0 {
>  	starfive,tx-use-rgmii-clk;
>  	assigned-clocks = <&aoncrg JH7110_AONCLK_GMAC0_TX>;
>  	assigned-clock-parents = <&aoncrg JH7110_AONCLK_GMAC0_RMII_RTX>;
> +	status = "okay";
> +};
> +
> +&i2c0 {
> +	status = "okay";
>  };
>
>  &pcie0 {
> @@ -35,3 +40,15 @@ &phy0 {
>  	rx-internal-delay-ps = <1500>;
>  	tx-internal-delay-ps = <1500>;
>  };
> +
> +&pwm {
> +	status = "okay";
> +};
> +
> +&pwmdac {
> +	status = "okay";
> +};
> +
> +&spi0 {
> +	status = "okay";
> +};
> diff --git a/arch/riscv/boot/dts/starfive/jh7110-pine64-star64.dts b/arch/riscv/boot/dts/starfive/jh7110-pine64-star64.dts
> index b720cdd15ed6..dbc8612b8464 100644
> --- a/arch/riscv/boot/dts/starfive/jh7110-pine64-star64.dts
> +++ b/arch/riscv/boot/dts/starfive/jh7110-pine64-star64.dts
> @@ -18,6 +18,7 @@ &gmac0 {
>  	starfive,tx-use-rgmii-clk;
>  	assigned-clocks = <&aoncrg JH7110_AONCLK_GMAC0_TX>;
>  	assigned-clock-parents = <&aoncrg JH7110_AONCLK_GMAC0_RMII_RTX>;
> +	status = "okay";
>  };
>
>  &gmac1 {
> @@ -39,6 +40,10 @@ phy1: ethernet-phy@1 {
>  	};
>  };
>
> +&i2c0 {
> +	status = "okay";
> +};
> +
>  &pcie1 {
>  	status = "okay";
>  };
> @@ -63,3 +68,15 @@ &phy1 {
>  	motorcomm,tx-clk-10-inverted;
>  	motorcomm,tx-clk-100-inverted;
>  };
> +
> +&pwm {
> +	status = "okay";
> +};
> +
> +&pwmdac {
> +	status = "okay";
> +};
> +
> +&spi0 {
> +	status = "okay";
> +};
> diff --git a/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dtsi b/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dtsi
> index 18f38fc790a4..ef93a394bb2f 100644
> --- a/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dtsi
> +++ b/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dtsi
> @@ -13,6 +13,10 @@ aliases {
>  	};
>  };
>
> +&gmac0 {
> +	status = "okay";
> +};
> +
>  &gmac1 {
>  	phy-handle = <&phy1>;
>  	phy-mode = "rgmii-id";
> @@ -29,6 +33,10 @@ phy1: ethernet-phy@1 {
>  	};
>  };
>
> +&i2c0 {
> +	status = "okay";
> +};
> +
>  &mmc0 {
>  	non-removable;
>  };
> @@ -40,3 +48,15 @@ &pcie0 {
>  &pcie1 {
>  	status = "okay";
>  };
> +
> +&pwm {
> +	status = "okay";
> +};
> +
> +&pwmdac {
> +	status = "okay";
> +};
> +
> +&spi0 {
> +	status = "okay";
> +};
> --
> 2.34.1
>

