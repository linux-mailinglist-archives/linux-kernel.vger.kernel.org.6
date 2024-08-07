Return-Path: <linux-kernel+bounces-277928-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 39B8794A84E
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 15:07:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E397F281520
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 13:07:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 563711E6750;
	Wed,  7 Aug 2024 13:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="BXmmDjVo"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A125155C83;
	Wed,  7 Aug 2024 13:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723036018; cv=none; b=tGxsDPoRO/wtS77Hukjxlv/yYM9FFeHMPpkhFwzr9Q5KUpUZN/GZiv8Vmg0GpSVZi0qGx1rXLlm+488sHP3eubeZ2BYINz7F6LKNheB20WJqXHtUanl03zPpP0huLgPWAF5KkuYh1NGCHJ9Bfj4zglzX5Z89CH+KnYwqdlah5To=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723036018; c=relaxed/simple;
	bh=zdCHLivRBHeV2NYtAz5hBxGICgl+ldCZ4tiN7YTehV8=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZD51lxNNO+SfynRDn1NAkebJ1N+qck7Ho5Np5JnB1VVus0bkg7KsVvtwp3FyKLWT96UAQm4SHiTSNU+sWgoMJxk4wmDlY31Ebm319j/fDiNHxEi9WI3HM3RYlYgw/LjLa/EZc1x3jA5TJo/Ki9Ms9AABpvRpXaI6vxBCyvNnEyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=BXmmDjVo; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 477D6mwW096127;
	Wed, 7 Aug 2024 08:06:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1723036008;
	bh=sse7kT6azNByYduNdrThku4TmwDTwyJbiElkKLi6dtw=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=BXmmDjVozkVOHhPZ9ZXz7JYQ39/qYGBwnwuGzDButm06c5NQwQ2WB3x1FHsSYTU8b
	 7NDlefGltcgbmhSCFPOV+Qh0qz5IgzRkui0lvvyxdsXNwLc35DkUbzgZT5POfgzG98
	 dI9iiWOACoIWHTwLMyFvBljNzdYvGLjNBft2tV1E=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 477D6mIw122246
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 7 Aug 2024 08:06:48 -0500
Received: from DFLE114.ent.ti.com (10.64.6.35) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 7
 Aug 2024 08:06:48 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 7 Aug 2024 08:06:48 -0500
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 477D6mZE096327;
	Wed, 7 Aug 2024 08:06:48 -0500
Date: Wed, 7 Aug 2024 08:06:48 -0500
From: Nishanth Menon <nm@ti.com>
To: Manorit Chawdhry <m-chawdhry@ti.com>
CC: Vignesh Raghavendra <vigneshr@ti.com>, Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Udit Kumar
	<u-kumar1@ti.com>,
        Neha Malcom Francis <n-francis@ti.com>,
        Aniket Limaye
	<a-limaye@ti.com>
Subject: Re: [PATCH v3 6/9] arm64: dts: ti: Split
 k3-j784s4-j742s2-evm-common.dtsi
Message-ID: <20240807130648.elyf66euunm6iowy@illusion>
References: <20240731-b4-upstream-j742s2-v3-0-da7fe3aa9e90@ti.com>
 <20240731-b4-upstream-j742s2-v3-6-da7fe3aa9e90@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240731-b4-upstream-j742s2-v3-6-da7fe3aa9e90@ti.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

On 22:40-20240731, Manorit Chawdhry wrote:
> k3-j784s4-j742s2-evm-common.dtsi will be included in k3-j742s2-evm.dts
> at a later point so move j784s4 related stuff to k3-j784s4-evm.dts

How about this:

Refactor J784s2-evm to a common file which uses the
superset device to allow reuse in j742s2-evm which uses the subset part.

Use a similar style commit message in other refactoring patches as well.

> 
> Signed-off-by: Manorit Chawdhry <m-chawdhry@ti.com>
> ---
>  arch/arm64/boot/dts/ti/k3-j784s4-evm.dts           | 49 ++++++++++++++++++++++
>  .../boot/dts/ti/k3-j784s4-j742s2-evm-common.dtsi   | 42 -------------------
>  2 files changed, 49 insertions(+), 42 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-j784s4-evm.dts b/arch/arm64/boot/dts/ti/k3-j784s4-evm.dts
> index e3730b2bca92..2543983b7fe7 100644
> --- a/arch/arm64/boot/dts/ti/k3-j784s4-evm.dts
> +++ b/arch/arm64/boot/dts/ti/k3-j784s4-evm.dts
> @@ -5,4 +5,53 @@
>   * EVM Board Schematics: https://www.ti.com/lit/zip/sprr458
>   */
>  
> +/dts-v1/;
> +
> +#include <dt-bindings/net/ti-dp83867.h>
> +#include <dt-bindings/gpio/gpio.h>
> +#include "k3-j784s4.dtsi"
>  #include "k3-j784s4-j742s2-evm-common.dtsi"
> +
> +/ {
> +	compatible = "ti,j784s4-evm", "ti,j784s4";
> +	model = "Texas Instruments J784S4 EVM";
> +
> +	memory@80000000 {
> +		device_type = "memory";
> +		bootph-all;
> +		/* 32G RAM */
> +		reg = <0x00000000 0x80000000 0x00000000 0x80000000>,
> +		      <0x00000008 0x80000000 0x00000007 0x80000000>;
I understand you are moving the nodes in and it is just copy paste, but
we have an opportunity to clean the nodes up a bit here.

Same as https://lore.kernel.org/all/20240807120629.3bo2cu3wlpkixwrp@flattered/

> +	};
> +
> +	reserved_memory: reserved-memory {
> +		#address-cells = <2>;
> +		#size-cells = <2>;
> +
> +		c71_3_dma_memory_region: c71-dma-memory@ab000000 {
> +			compatible = "shared-dma-pool";
> +			reg = <0x00 0xab000000 0x00 0x100000>;
> +			no-map;
> +		};
> +
> +		c71_3_memory_region: c71-memory@ab100000 {
> +			compatible = "shared-dma-pool";
> +			reg = <0x00 0xab100000 0x00 0xf00000>;
> +			no-map;
> +		};
> +	};
> +};
> +
> +&mailbox0_cluster5 {
> +	mbox_c71_3: mbox-c71-3 {
> +		ti,mbox-rx = <2 0 0>;
> +		ti,mbox-tx = <3 0 0>;
> +	};
> +};
> +
> +&c71_3 {
> +	status = "okay";

Status comes last. I know that these coding standards are new, and it
takes a little getting used to and one wishes there was a linting tool
of some sort to make this easier.. but for now, eyes are the only way
out :(.


> +	mboxes = <&mailbox0_cluster5 &mbox_c71_3>;
> +	memory-region = <&c71_3_dma_memory_region>,
> +			<&c71_3_memory_region>;
> +};

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D

