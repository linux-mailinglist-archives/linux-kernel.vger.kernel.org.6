Return-Path: <linux-kernel+bounces-294217-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DCA24958ABF
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 17:09:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 77354B21DA3
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 15:09:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B2F51917FB;
	Tue, 20 Aug 2024 15:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Tu3HD1Ys"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACC2C8F48;
	Tue, 20 Aug 2024 15:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724166568; cv=none; b=jbmT12NWCS8OeQTR+bmtI1Ib4blaUUQK1Ynr31kfE+Nbecg3D4YDM7f1/iPShi6tX6qKctg+jGkbPmAyA8407U5D4vJuUfhHRr63t50qZd5XIRbjTE2pjC0Ez5f4qKAhR62CJsTZ5jZ9K8+tibqwXi/5xBl8RBepcX5GFrSpvxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724166568; c=relaxed/simple;
	bh=+9tqy8z/EvH53xMnv1QsxXC2sZRco3I8buXN96OAJrc=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=ADPvQTTrejGzUnWl4wCZb+IuDVRXJkkxZGRdabh9oMuf+DpNLF3ArLjfq23fpTjQu6LWpqw7/SU0K9hCxbEwtuEOXOtAzyEQ62aZMNsunHNsOy0x+3iARnswy3WgrBESIQ0YXNzwqrDexSqkL0kVxdgZXSnzgAGJdVtrpLWRKCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=Tu3HD1Ys; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 47KF9IiP048893;
	Tue, 20 Aug 2024 10:09:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1724166558;
	bh=ytLIZJR+bT0mdJmSaZNxr9OjibdZmzCxEEv7uH4LDwA=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=Tu3HD1Ysx2hOIU8GX0c7KnMZFbKKKuLqY1Ladyxj/Hhg9454KdixGua5vFF96YpHY
	 M1Dwg91C6bD0cPh5kAcUeahMuOJxpkSBEtti1stTDpFlNdS4iVJtLMVaZJXgNXQlik
	 vOFa6z1zjYJeVvkRJbPfMD6iUpzruGT4cvOUL75I=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 47KF9Hq5093888
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 20 Aug 2024 10:09:18 -0500
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 20
 Aug 2024 10:09:17 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 20 Aug 2024 10:09:17 -0500
Received: from [10.249.42.149] ([10.249.42.149])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 47KF9H9Y040616;
	Tue, 20 Aug 2024 10:09:17 -0500
Message-ID: <7bb9f490-aabb-4e79-8022-ef5fbfb77512@ti.com>
Date: Tue, 20 Aug 2024 10:09:17 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/4] arm64: dts: k3-am62a-mcu: Add R5F remote proc node
To: Hari Nagalla <hnagalla@ti.com>, <vigneshr@ti.com>, <kristo@kernel.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <nm@ti.com>, <bb@ti.com>
CC: <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>
References: <20240820104034.15607-1-hnagalla@ti.com>
 <20240820104034.15607-3-hnagalla@ti.com>
Content-Language: en-US
From: Andrew Davis <afd@ti.com>
In-Reply-To: <20240820104034.15607-3-hnagalla@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

On 8/20/24 5:40 AM, Hari Nagalla wrote:
> AM62A SoCs have a single R5F core in the MCU voltage domain. The MCU
> domain also has a 512KB sram memory, the R5F core can use for
> applications needing fast memory access.
> 
> Signed-off-by: Hari Nagalla <hnagalla@ti.com>
> ---
>   arch/arm64/boot/dts/ti/k3-am62a-mcu.dtsi | 35 ++++++++++++++++++++++++
>   1 file changed, 35 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-am62a-mcu.dtsi b/arch/arm64/boot/dts/ti/k3-am62a-mcu.dtsi
> index 8c36e56f4138..803da3cce336 100644
> --- a/arch/arm64/boot/dts/ti/k3-am62a-mcu.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-am62a-mcu.dtsi
> @@ -6,6 +6,17 @@
>    */
>   
>   &cbass_mcu {
> +	mcu_ram: sram@79100000 {

This change doesn't belong to this patch, this memory can be
used by other components in the system and is not exclusive
to the R5F firmware.

Let's add this node later so it can be discussed on its own
and not block this otherwise correct series.

> +		compatible = "mmio-sram";
> +		reg = <0x00 0x79100000 0x00 0x80000>;
> +		ranges = <0x00 0x00 0x79100000 0x80000>;
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +
> +		mcu1-sram@0 {
> +			reg = <0x0 0x80000>;
> +		};
> +	};

Need newline here if you were going to keep this node..

>   	mcu_pmx0: pinctrl@4084000 {
>   		compatible = "pinctrl-single";
>   		reg = <0x00 0x04084000 0x00 0x88>;
> @@ -167,4 +178,28 @@ mcu_mcan1: can@4e18000 {
>   		bosch,mram-cfg = <0x0 128 64 64 64 64 32 32>;
>   		status = "disabled";
>   	};
> +
> +	mcu_r5fss0: r5fss@79000000 {
> +		compatible = "ti,am62-r5fss";
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		ranges = <0x79000000 0x00 0x79000000 0x8000>,
> +			 <0x79020000 0x00 0x79020000 0x8000>;
> +		power-domains = <&k3_pds 7 TI_SCI_PD_EXCLUSIVE>;

Newline here.

Andrew

> +		mcu_r5fss0_core0: r5f@79000000 {
> +			compatible = "ti,am62-r5f";
> +			reg = <0x79000000 0x00008000>,
> +				<0x79020000 0x00008000>;
> +			reg-names = "atcm", "btcm";
> +			ti,sci = <&dmsc>;
> +			ti,sci-dev-id = <9>;
> +			ti,sci-proc-ids = <0x03 0xff>;
> +			resets = <&k3_reset 9 1>;
> +			firmware-name = "am62a-mcu-r5f0_0-fw";
> +			ti,atcm-enable = <0>;
> +			ti,btcm-enable = <1>;
> +			ti,loczrama = <0>;
> +			sram = <&mcu_ram>;
> +		};
> +	};
>   };

