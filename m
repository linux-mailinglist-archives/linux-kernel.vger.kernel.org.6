Return-Path: <linux-kernel+bounces-373772-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70ACB9A5C87
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 09:18:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3191528442F
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 07:18:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B19E1D12F9;
	Mon, 21 Oct 2024 07:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hi/+coWy"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9477B193418;
	Mon, 21 Oct 2024 07:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729495083; cv=none; b=GOXX9NsR9qox+FUxXzQk7n3JVFuaLx3JzuKiZUcdg9yWI3k1KGdr/+6JgFJ6T7Ux/64q+813RbMVFVBzzgZ+kBBklapbs8KAl97PRNBrkiqgCNcynpAzkryhrTF+YssfCqsS7xyQYEbFrpYPShT80ylT9lL6Bhv25Il+5tf0HZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729495083; c=relaxed/simple;
	bh=uoS5XTRMeT/gGcLkJRtVlVTCHjy0kWjFGMleEtECSvY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lBkW8p2dkH0oyhkSYX8Jo86yhWWct9NVTIAqJnVHCce4pXxEr5JGP7teE2vOrxInet4XkkQmSqjUp7JNNvJcFzAhTi0C92uu0BLfoRlue7c71R+QURnYJI7o+S0If6kkZgyD/HPvbNMVcBa/v5//o8UvcDKEN3pUlzAuPMLpNyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hi/+coWy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 981D3C4CECD;
	Mon, 21 Oct 2024 07:18:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729495083;
	bh=uoS5XTRMeT/gGcLkJRtVlVTCHjy0kWjFGMleEtECSvY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Hi/+coWyQ9HmJR2rIZDA/xoftFHtg9qrhjwgY0bLSCiU1tgTvgeuj64tM8eRO1S8l
	 IheLgBTBKvn8hvDU6IEki0p99LvUDFrzP2/WPv34WDkXFCdSTCOT0f7P1VHI62p0E/
	 zwKZdJpwzjQvcyO0xlgwG0QsPWTn1/JjgV8yQmXMmmmfj/oBiyWeDegZKci10h/5to
	 oA1UfgTIfWXv/tBfj3NnI5EHD824CyBf9gL3Iw4XpVg8lIiXEV0M0VOsKrf5LIMbuL
	 5Q+3hAV/qh3+ZTEvzk0MLLKMQtv5BdcOIHZNShkNMC5TM51BpAmAmjKq/JBNyY8ioU
	 66UQTEsEkWOhg==
Date: Mon, 21 Oct 2024 09:17:59 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Guodong Xu <guodong@riscstar.com>
Cc: Conor Dooley <conor@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Emil Renner Berthing <kernel@esmil.dk>, rafal@milecki.pl, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Heiko Stuebner <heiko.stuebner@cherry.de>, 
	Michael Zhu <michael.zhu@starfivetech.com>, Drew Fustini <drew@beagleboard.org>, 
	Alexandru Stan <ams@frame.work>, Daniel Schaefer <dhs@frame.work>, 
	Sandie Cao <sandie.cao@deepcomputing.io>, Yuning Liang <yuning.liang@deepcomputing.io>, 
	Huiming Qiu <huiming.qiu@deepcomputing.io>, Alex Elder <elder@riscstar.com>, linux@frame.work, 
	devicetree@vger.kernel.org, linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 3/3] riscv: dts: starfive: add DeepComputing FML13V01
 board device tree
Message-ID: <ae5gels34ozgzrcrwz53wj22hoy5cq3crn3dmkhitxlffmnavt@6lbmrcpjmqyd>
References: <20241020134959.519462-1-guodong@riscstar.com>
 <20241020134959.519462-4-guodong@riscstar.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241020134959.519462-4-guodong@riscstar.com>

On Sun, Oct 20, 2024 at 09:49:59PM +0800, Guodong Xu wrote:
> From: Sandie Cao <sandie.cao@deepcomputing.io>
> 
> The FML13V01 board from DeepComputing incorporates a StarFive JH7110 SoC.
> It is a mainboard designed for the Framework Laptop 13 Chassis, which has
> (Framework) SKU FRANHQ0001.
> 
> The FML13V01 board features:
> - StarFive JH7110 SoC
> - LPDDR4 8GB
> - eMMC 32GB or 128GB
> - QSPI Flash
> - MicroSD Slot
> - PCIe-based Wi-Fi
> - 4 USB-C Ports
>  - Port 1: PD 3.0 (60W Max), USB 3.2 Gen 1, DP 1.4 (4K@30Hz/2.5K@60Hz)
>  - Port 2: PD 3.0 (60W Max), USB 3.2 Gen 1
>  - Port 3 & 4: USB 3.2 Gen 1
> 
> Create the DTS file for the DeepComputing FML13V01 board. Seven device
> nodes have been verified functional and remain enabled: i2c2, i2c5, i2c6
> qspi, mmc0, mmc1 and usb0.  All others remain disabled, or are disabled
> by nodes in "jh7110-deepcomputing-fml13v01.dts".
> 
> Signed-off-by: Sandie Cao <sandie.cao@deepcomputing.io>
> [elder@riscstar.com: revised the description, updated some nodes]
> Signed-off-by: Alex Elder <elder@riscstar.com>
> Signed-off-by: Guodong Xu <guodong@riscstar.com>
> ---
> v5: No change
> v4: Changed model string to "DeepComputing FML13V01"
>     Changed dts filename and Makefile accordingly to reflect the change
>     Updated device nodes status, and verified functional
>     Revised the commit message
> v3: Updated the commit message
> v2: Changed the model and copmatible strings
>     Updated the commit message with board features
> 
>  arch/riscv/boot/dts/starfive/Makefile         |  1 +
>  .../jh7110-deepcomputing-fml13v01.dts         | 44 +++++++++++++++++++
>  2 files changed, 45 insertions(+)
>  create mode 100644 arch/riscv/boot/dts/starfive/jh7110-deepcomputing-fml13v01.dts
> 
> diff --git a/arch/riscv/boot/dts/starfive/Makefile b/arch/riscv/boot/dts/starfive/Makefile
> index 7a163a7d6ba3..b3bb12f78e7d 100644
> --- a/arch/riscv/boot/dts/starfive/Makefile
> +++ b/arch/riscv/boot/dts/starfive/Makefile
> @@ -8,6 +8,7 @@ DTC_FLAGS_jh7110-starfive-visionfive-2-v1.3b := -@
>  dtb-$(CONFIG_ARCH_STARFIVE) += jh7100-beaglev-starlight.dtb
>  dtb-$(CONFIG_ARCH_STARFIVE) += jh7100-starfive-visionfive-v1.dtb
>  
> +dtb-$(CONFIG_ARCH_STARFIVE) += jh7110-deepcomputing-fml13v01.dtb
>  dtb-$(CONFIG_ARCH_STARFIVE) += jh7110-milkv-mars.dtb
>  dtb-$(CONFIG_ARCH_STARFIVE) += jh7110-pine64-star64.dtb
>  dtb-$(CONFIG_ARCH_STARFIVE) += jh7110-starfive-visionfive-2-v1.2a.dtb
> diff --git a/arch/riscv/boot/dts/starfive/jh7110-deepcomputing-fml13v01.dts b/arch/riscv/boot/dts/starfive/jh7110-deepcomputing-fml13v01.dts
> new file mode 100644
> index 000000000000..b515b7d04c37
> --- /dev/null
> +++ b/arch/riscv/boot/dts/starfive/jh7110-deepcomputing-fml13v01.dts
> @@ -0,0 +1,44 @@
> +// SPDX-License-Identifier: GPL-2.0 OR MIT
> +/*
> + * Copyright (C) 2024 DeepComputing (HK) Limited
> + */
> +
> +/dts-v1/;
> +#include "jh7110-common.dtsi"
> +
> +/ {
> +	model = "DeepComputing FML13V01";
> +	compatible = "deepcomputing,fml13v01", "starfive,jh7110";
> +};
> +
> +&camss {
> +	status = "disabled";
> +};
> +
> +&csi2rx {
> +	status = "disabled";
> +};
> +
> +&gmac0 {
> +	status = "disabled";
> +};
> +
> +&i2c0 {
> +	status = "disabled";
> +};
> +
> +&pwm {
> +	status = "disabled";
> +};
> +
> +&pwmdac {
> +	status = "disabled";
> +};
> +
> +&spi0 {
> +	status = "disabled";

If your board has to disable all these, then they should not have been
enabled in DTSI in the first place. Only blocks present and working in
the SoC (without amny external needs) should be enabled.

I suggest to fix that aspect first.

Best regards,
Krzysztof


