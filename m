Return-Path: <linux-kernel+bounces-309003-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DA110966508
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 17:11:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6DA25283AB7
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 15:11:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FB3B1B3B32;
	Fri, 30 Aug 2024 15:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="bnaiL27t"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93B7F1DA26;
	Fri, 30 Aug 2024 15:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725030668; cv=none; b=Z9CHZfaT2rFPofYVnL4MnPqYI2Wi6rvzpni25PDgZaeMs57Ykey3hNRCUFCHXBArcQ2y+4e+9diu7b4OLpgstKIDPgY2TTWeAvVEfqauLpwqhcaGMQnGWwAfTzqSGsPi6mlkXROkse29fwIab4g04LDmN+LFRTQ9n0xjlWBer5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725030668; c=relaxed/simple;
	bh=k0MHcD6fGcBRoGoAYkXiaRGvEEgp/XNQ8KfBL7zEbY4=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=b/IBONBGnFPZiFQHTw4n/ORMii3fZHt+5F1u+askPDn9RW77a7Xo3d4uavQwEmgo+zo4XTBx+KoxNFkoobo+idDsjeVG+LsrGHDSyXruoZKJrqV7V5xaVBXSBNu9ZUmvNfS+ndNsq5NsABtintVR88l4oLXRmTszJounsFxGx3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=bnaiL27t; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 47UFB02o043535;
	Fri, 30 Aug 2024 10:11:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1725030660;
	bh=cFtmf837AAq1zuiS8MEL5I5amHqOsrkqaChyfLvPtFM=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=bnaiL27tf6fmDQlFqNMJMoTvgvCxQpC+FpR+TEwjxqNpig9/UXqw4W4hkbftrHd/O
	 mlLIrajOfqno46OtoUQRZAvGe4qQSGPW9e6nSVWGK7cWIIs/YeEPoHUiSWxrabW3C0
	 N07HcIhAfXEapZS1U+DlggNdDdwNp62NB0kX+Zg8=
Received: from DLEE112.ent.ti.com (dlee112.ent.ti.com [157.170.170.23])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTP id 47UFB05w027682;
	Fri, 30 Aug 2024 10:11:00 -0500
Received: from DLEE104.ent.ti.com (157.170.170.34) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 30
 Aug 2024 10:10:59 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 30 Aug 2024 10:10:59 -0500
Received: from [10.249.141.75] ([10.249.141.75])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 47UFAtXK035736;
	Fri, 30 Aug 2024 10:10:56 -0500
Message-ID: <d6bf10b1-9671-4c21-8093-48a4065ceb3c@ti.com>
Date: Fri, 30 Aug 2024 20:40:55 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/2] arm64: dts: ti: k3-j722s-main: Add R5F and C7x
 remote processor nodes
To: Beleswar Padhi <b-padhi@ti.com>, <nm@ti.com>, <vigneshr@ti.com>,
        <kristo@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>
CC: <j-choudhary@ti.com>, <vaishnav.a@ti.com>, <afd@ti.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <u-kumar1@ti.com>
References: <20240829060932.3441295-1-b-padhi@ti.com>
 <20240829060932.3441295-2-b-padhi@ti.com>
Content-Language: en-US
From: "Kumar, Udit" <u-kumar1@ti.com>
In-Reply-To: <20240829060932.3441295-2-b-padhi@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180


On 8/29/2024 11:39 AM, Beleswar Padhi wrote:
> From: Apurva Nandan <a-nandan@ti.com>
>
> The K3 J722S SoCs have one single-core Arm Cortex-R5F processor in each
> of the WAKEUP, MCU and MAIN voltage domain, and two C71x DSP subsystems
> in MAIN voltage domain. Add the DT nodes to support Inter-Processor
> Communication.
>
> Signed-off-by: Apurva Nandan <a-nandan@ti.com>
> [ refactoring changes to k3-j722s-main.dtsi ]
> Signed-off-by: Beleswar Padhi <b-padhi@ti.com>
> [...]
>   arch/arm64/boot/dts/ti/k3-j722s-main.dtsi | 61 +++++++++++++++++++++++
>   1 file changed, 61 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/ti/k3-j722s-main.dtsi b/arch/arm64/boot/dts/ti/k3-j722s-main.dtsi
> index cadb4f7c2ea9..ed6f4ba08afc 100644
> --- a/arch/arm64/boot/dts/ti/k3-j722s-main.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-j722s-main.dtsi
> @@ -153,6 +153,67 @@ usb1: usb@31200000{
>   			dr_mode = "otg";
>   		};
>   	};
> +
> +	main_r5fss0: r5fss@78400000 {
> +		compatible = "ti,am62-r5fss";
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		ranges = <0x78400000 0x00 0x78400000 0x8000>,
> +			 <0x78500000 0x00 0x78500000 0x8000>;
> +		power-domains = <&k3_pds 261 TI_SCI_PD_EXCLUSIVE>;
> +		status = "disabled";
> +
> +		main_r5fss0_core0: r5f@78400000 {
> +			compatible = "ti,am62-r5f";
> +			reg = <0x78400000 0x00008000>,
> +			      <0x78500000 0x00008000>;
> +			reg-names = "atcm", "btcm";
> +			resets = <&k3_reset 262 1>;
> +			firmware-name = "j722s-main-r5f0_0-fw";

Reviewed-by: Udit Kumar <u-kumar1@ti.com>

> +			ti,sci = <&dmsc>;
> +			ti,sci-dev-id = <262>;
> +			ti,sci-proc-ids = <0x04 0xff>;
> +			ti,atcm-enable = <1>;
> +			ti,btcm-enable = <1>;
> +			ti,loczrama = <1>;
> +		};
> +	};
> +
> +	c7x_0: dsp@7e000000 {
> +		compatible = "ti,am62a-c7xv-dsp";
> +		reg = <0x00 0x7e000000 0x00 0x00200000>;
> +		reg-names = "l2sram";
> +		resets = <&k3_reset 208 1>;
> +		firmware-name = "j722s-c71_0-fw";
> +		ti,sci = <&dmsc>;
> +		ti,sci-dev-id = <208>;
> +		ti,sci-proc-ids = <0x30 0xff>;
> +		status = "disabled";
> +	};
> +
> +	c7x_1: dsp@7e200000 {
> +		compatible = "ti,am62a-c7xv-dsp";
> +		reg = <0x00 0x7e200000 0x00 0x00200000>;
> +		reg-names = "l2sram";
> +		resets = <&k3_reset 268 1>;
> +		firmware-name = "j722s-c71_1-fw";
> +		ti,sci = <&dmsc>;
> +		ti,sci-dev-id = <268>;
> +		ti,sci-proc-ids = <0x31 0xff>;
> +		status = "disabled";
> +	};
> +};
> +
> +/* MCU domain overrides */
> +
> +&mcu_r5fss0_core0 {
> +	firmware-name = "j722s-mcu-r5f0_0-fw";
> +};
> +
> +/* Wakeup domain overrides */
> +
> +&wkup_r5fss0_core0 {
> +	firmware-name = "j722s-wkup-r5f0_0-fw";
>   };
>   
>   &main_conf {

