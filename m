Return-Path: <linux-kernel+bounces-171901-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4A398BEA3B
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 19:16:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E9072812AA
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 17:16:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD041C121;
	Tue,  7 May 2024 17:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="J7y4Cghf"
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F613A951;
	Tue,  7 May 2024 17:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715102149; cv=none; b=Q4v2+mtH+jVPvTVJ8S2lTdmRMSNbSzvw4GSi4wZ2K4+X4bZiruHDKIBtpxlH8C6+di+dBDY2V1/TJpDyaQ3cGUiiZzWanSXSbInf+0n0WmCHz+xwWTlI7ycm7VrEHAsaJBZNNV5ppUlRPv5j2wkpWHCNVkY4fDg275Ikv0rT4uM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715102149; c=relaxed/simple;
	bh=Q/PO5tT0xhQtBGm3Jrv1EVhPRHZt11qBfXbZHXoBJwg=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Je24K5Nb9YomsjI2XgScOj7oamLI64kWn6Xrg6WGnvadX8oH/NuHE0hOVuBG2rrcCA/K9VBirNiVe+a+7k+nzh/1fY0OOu3XJwkNNAOiKi+2Qpysel/r6MOHFt7CTVJAXhCwdtX8K5JOtxxS/Mlsu/PMsffq/geb4Ia0TtyjEPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=J7y4Cghf; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 447HFX6A096082;
	Tue, 7 May 2024 12:15:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1715102133;
	bh=2GIrttvXheSqzZiUQLCww8r4NlXBOs0jYqFU7kAkH8o=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=J7y4CghfJntoOM36oWcEhs4WChhmSjpYGexzlPflcKWj/cH/XTbkndM6B1dK01E1F
	 uSkQLUPqijPG9IvuC+TQjveYCZi3oXPoy6PSbjB0HJ9nPUahoMivIIjCYCPz5ZcX2J
	 K3UeFjcxzhVnlEF94WDjJoINPnkKxfZCBfTWwaxA=
Received: from DLEE106.ent.ti.com (dlee106.ent.ti.com [157.170.170.36])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 447HFXoJ015936
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 7 May 2024 12:15:33 -0500
Received: from DLEE110.ent.ti.com (157.170.170.21) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 7
 May 2024 12:15:32 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 7 May 2024 12:15:32 -0500
Received: from [10.249.42.149] ([10.249.42.149])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 447HFW70006845;
	Tue, 7 May 2024 12:15:32 -0500
Message-ID: <9c6f8999-715f-42e3-8d13-a5aef074dd5d@ti.com>
Date: Tue, 7 May 2024 12:15:32 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] arm64: dts: ti: k3-j722s: Redefine USB1 node
 description
To: Ravi Gunasekaran <r-gunasekaran@ti.com>, <nm@ti.com>, <vigneshr@ti.com>
CC: <kristo@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <srk@ti.com>, <rogerq@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20240429120932.11456-1-r-gunasekaran@ti.com>
 <20240429120932.11456-3-r-gunasekaran@ti.com>
Content-Language: en-US
From: Andrew Davis <afd@ti.com>
In-Reply-To: <20240429120932.11456-3-r-gunasekaran@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

On 4/29/24 7:09 AM, Ravi Gunasekaran wrote:
> USB1 controller on J722S and AM62P are from different vendors.
> Redefine the USB1 node description for J722S by deleting the
> node inherited from AM62P dtsi.
> 
> Signed-off-by: Ravi Gunasekaran <r-gunasekaran@ti.com>
> ---
>   arch/arm64/boot/dts/ti/k3-j722s.dtsi | 39 ++++++++++++++++++++++++++++
>   1 file changed, 39 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-j722s.dtsi b/arch/arm64/boot/dts/ti/k3-j722s.dtsi
> index beba5a3ea6cc..90725eeb3178 100644
> --- a/arch/arm64/boot/dts/ti/k3-j722s.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-j722s.dtsi
> @@ -13,6 +13,13 @@
>   
>   #include "k3-am62p5.dtsi"
>   
> +/*
> + * USB1 controller on AM62P and J722S are of different IP.
> + * Delete AM62P's USBSS1 node definition and redefine it for J722S.
> + */
> +
> +/delete-node/ &usbss1;
> +
>   / {
>   	model = "Texas Instruments K3 J722S SoC";
>   	compatible = "ti,j722s";
> @@ -120,6 +127,38 @@
>   			status = "disabled"; /* Needs lane config */
>   		};
>   	};
> +
> +	usbss1: cdns-usb@f920000 {

MAIN domain items are defined in -main.dtsi files, for instance the
USB node you are overriding was defined in k3-am62p-main.dtsi.
This should go in a file named k3-j722s-main.dtsi.

Andrew

> +		compatible = "ti,j721e-usb";
> +		reg = <0x00 0x0f920000 0x00 0x100>;
> +		ranges;
> +		power-domains = <&k3_pds 278 TI_SCI_PD_EXCLUSIVE>;
> +		clocks = <&k3_clks 278 3>, <&k3_clks 278 1>;
> +		clock-names = "ref", "lpm";
> +		assigned-clocks = <&k3_clks 278 3>; /* USB2_REFCLK */
> +		assigned-clock-parents = <&k3_clks 278 4>; /* HF0SC0 */
> +		#address-cells = <2>;
> +		#size-cells = <2>;
> +		status = "disabled";
> +
> +		usb1: usb@31200000{
> +			compatible = "cdns,usb3";
> +			reg = <0x00 0x31200000 0x00 0x10000>,
> +			      <0x00 0x31210000 0x00 0x10000>,
> +			      <0x00 0x31220000 0x00 0x10000>;
> +			reg-names = "otg",
> +				    "xhci",
> +				    "dev";
> +			interrupts = <GIC_SPI 226 IRQ_TYPE_LEVEL_HIGH>, /* irq.0 */
> +				     <GIC_SPI 232 IRQ_TYPE_LEVEL_HIGH>, /* irq.6 */
> +				     <GIC_SPI 245 IRQ_TYPE_LEVEL_HIGH>; /* otgirq */
> +			interrupt-names = "host",
> +					  "peripheral",
> +					  "otg";
> +			maximum-speed = "super-speed";
> +			dr_mode = "otg";
> +		};
> +	};
>   };
>   
>   /* Main domain overrides */

