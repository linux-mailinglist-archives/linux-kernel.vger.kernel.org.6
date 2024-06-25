Return-Path: <linux-kernel+bounces-228527-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ACAB916147
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 10:32:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A17C5B25170
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 08:32:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81AD21494C9;
	Tue, 25 Jun 2024 08:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="BjpjAbg5"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1322149015;
	Tue, 25 Jun 2024 08:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719304306; cv=none; b=hbhOX3EHVmVNLilM3KMSzQrNZTssY/3eDF4yhN3Ssy5xV3yJ13U6K6hYdN38c6/8DB8lYzdVQXcLIKi20a8kLkced2mg8uADbm0XqULMueOdKkugKzkFn9DqkBfnzJGgowP/5m0rI7qHZj7+4La1JFUV/LBvd8VdymObyy2z6k8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719304306; c=relaxed/simple;
	bh=+D48S5Vq0swdQkscBySnwczFMRaxSpZ8KHXgGGRiwsY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=U+jnQLIUpwByW/L95fRkWBRajcsNdOFxAyTin7M2HEmDGiEB3ad5cFXF3OzCwR6JwnXbk50qnJWR1ldyTLOq0ftbSqWrCwAd5V9sfBPo7OQNg7JI0xrC5kx4qXwgwbEeZncDU81OFf42v+f6wwz98qVNLhBaHA4neTfska/BsFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=BjpjAbg5; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 45P8VaP4087438;
	Tue, 25 Jun 2024 03:31:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1719304296;
	bh=LYGd2H7FTgR/FQpG/Ynu641/TDmOOv4Oh/6t57w2iwM=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=BjpjAbg5lgCI6Y9Avm0J6xbXMN1SjzcDaMd6qI9qwAbsh2Uxs3C62snLXhep0PTxs
	 jjMAw7zxLYZpPg+YL4XuuSD1lnUKGUzQHFiUSN+9jmaK1pdyBJ8c8aLLv2o8gPcftg
	 Y8BXYQlZhBQ9GTZ2Ggo0iWrvL8u0Y9h6hHKK+h0g=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 45P8VaCY073116
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 25 Jun 2024 03:31:36 -0500
Received: from DLEE108.ent.ti.com (157.170.170.38) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 25
 Jun 2024 03:31:36 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 25 Jun 2024 03:31:36 -0500
Received: from [172.24.227.94] (uda0132425.dhcp.ti.com [172.24.227.94])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 45P8VVov086972;
	Tue, 25 Jun 2024 03:31:32 -0500
Message-ID: <f9f5178b-1e94-489b-8e71-43b814b7252a@ti.com>
Date: Tue, 25 Jun 2024 14:01:30 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] arm64: dts: ti: k3-j784s4-main: Add McASP nodes
To: Jayesh Choudhary <j-choudhary@ti.com>, <linux-kernel@vger.kernel.org>,
        <nm@ti.com>, <j-luthra@ti.com>
CC: <kristo@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <u-kumar1@ti.com>
References: <20240619095253.290552-1-j-choudhary@ti.com>
 <20240619095253.290552-2-j-choudhary@ti.com>
From: Vignesh Raghavendra <vigneshr@ti.com>
Content-Language: en-US
In-Reply-To: <20240619095253.290552-2-j-choudhary@ti.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180



On 19/06/24 15:22, Jayesh Choudhary wrote:
> Add McASP 0-4 instances and keep them disabled as several required
> properties are missing as they are board specific.
> 
> Signed-off-by: Jayesh Choudhary <j-choudhary@ti.com>
> ---
>  arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi | 80 ++++++++++++++++++++++
>  1 file changed, 80 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi b/arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi
> index fd3d3344efbe..96085dc7bc18 100644
> --- a/arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi
> @@ -2617,4 +2617,84 @@ dss_ports: ports {
>  			 */
>  		};
>  	};
> +
> +	mcasp0: mcasp@2b00000 {
> +		compatible = "ti,am33xx-mcasp-audio";
> +		reg = <0x0 0x02b00000 0x0 0x2000>,
> +		      <0x0 0x02b08000 0x0 0x1000>;

			^^ Should be 0x00 (elsewhere as well) to be inline with rest of the file


> +		reg-names = "mpu","dat";
> +		interrupts = <GIC_SPI 544 IRQ_TYPE_LEVEL_HIGH>,
> +			     <GIC_SPI 545 IRQ_TYPE_LEVEL_HIGH>;
> +		interrupt-names = "tx", "rx";
> +		dmas = <&main_udmap 0xc400>, <&main_udmap 0x4400>;
> +		dma-names = "tx", "rx";
> +		clocks = <&k3_clks 265 1>;
> +		clock-names = "fck";
> +		power-domains = <&k3_pds 265 TI_SCI_PD_EXCLUSIVE>;
> +		status = "disabled";
> +	};
> +
> +	mcasp1: mcasp@2b10000 {
> +		compatible = "ti,am33xx-mcasp-audio";
> +		reg = <0x0 0x02b10000 0x0 0x2000>,
> +		      <0x0 0x02b18000 0x0 0x1000>;
> +		reg-names = "mpu","dat";
> +		interrupts = <GIC_SPI 546 IRQ_TYPE_LEVEL_HIGH>,
> +			     <GIC_SPI 547 IRQ_TYPE_LEVEL_HIGH>;
> +		interrupt-names = "tx", "rx";
> +		dmas = <&main_udmap 0xc401>, <&main_udmap 0x4401>;
> +		dma-names = "tx", "rx";
> +		clocks = <&k3_clks 266 1>;
> +		clock-names = "fck";
> +		power-domains = <&k3_pds 266 TI_SCI_PD_EXCLUSIVE>;
> +		status = "disabled";
> +	};
> +
> +	mcasp2: mcasp@2b20000 {
> +		compatible = "ti,am33xx-mcasp-audio";
> +		reg = <0x0 0x02b20000 0x0 0x2000>,
> +		      <0x0 0x02b28000 0x0 0x1000>;
> +		reg-names = "mpu","dat";
> +		interrupts = <GIC_SPI 548 IRQ_TYPE_LEVEL_HIGH>,
> +			     <GIC_SPI 549 IRQ_TYPE_LEVEL_HIGH>;
> +		interrupt-names = "tx", "rx";
> +		dmas = <&main_udmap 0xc402>, <&main_udmap 0x4402>;
> +		dma-names = "tx", "rx";
> +		clocks = <&k3_clks 267 1>;
> +		clock-names = "fck";
> +		power-domains = <&k3_pds 267 TI_SCI_PD_EXCLUSIVE>;
> +		status = "disabled";
> +	};
> +
> +	mcasp3: mcasp@2b30000 {
> +		compatible = "ti,am33xx-mcasp-audio";
> +		reg = <0x0 0x02b30000 0x0 0x2000>,
> +		      <0x0 0x02b38000 0x0 0x1000>;
> +		reg-names = "mpu","dat";
> +		interrupts = <GIC_SPI 550 IRQ_TYPE_LEVEL_HIGH>,
> +			     <GIC_SPI 551 IRQ_TYPE_LEVEL_HIGH>;
> +		interrupt-names = "tx", "rx";
> +		dmas = <&main_udmap 0xc500>, <&main_udmap 0x4500>;
> +		dma-names = "tx", "rx";
> +		clocks = <&k3_clks 268 1>;
> +		clock-names = "fck";
> +		power-domains = <&k3_pds 268 TI_SCI_PD_EXCLUSIVE>;
> +		status = "disabled";
> +	};
> +
> +	mcasp4: mcasp@2b40000 {
> +		compatible = "ti,am33xx-mcasp-audio";
> +		reg = <0x0 0x02b40000 0x0 0x2000>,
> +		      <0x0 0x02b48000 0x0 0x1000>;
> +		reg-names = "mpu","dat";
> +		interrupts = <GIC_SPI 552 IRQ_TYPE_LEVEL_HIGH>,
> +			     <GIC_SPI 553 IRQ_TYPE_LEVEL_HIGH>;
> +		interrupt-names = "tx", "rx";
> +		dmas = <&main_udmap 0xc501>, <&main_udmap 0x4501>;
> +		dma-names = "tx", "rx";
> +		clocks = <&k3_clks 269 1>;
> +		clock-names = "fck";
> +		power-domains = <&k3_pds 269 TI_SCI_PD_EXCLUSIVE>;
> +		status = "disabled";
> +	};
>  };

-- 
Regards
Vignesh

