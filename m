Return-Path: <linux-kernel+bounces-309017-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4664996653F
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 17:22:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9E152B21330
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 15:22:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6886D1B3F0A;
	Fri, 30 Aug 2024 15:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="jGktXyxW"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1D531B581C;
	Fri, 30 Aug 2024 15:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725031311; cv=none; b=RIM3c1gWDrgLdq8DmG/doBEglyk/0FjLRfUXaSTbmxgjvCleYQIFjrTsKIPC845drQVncmgG379MTiM60hcsdrWePdmgZXmKtfHMMeFkSrYbj8Imo1zfdo+aWze4tWggJrod2AMsqNKhGAT8jkKEKobKVQQ/gC71L0RNbftgTJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725031311; c=relaxed/simple;
	bh=QWcY8OXVDgZa77uOrPTn6smZmm8csMFsYnDeLLxxbj4=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=ibKfwNsbFr2+y7/xue5zmYLbzuKp+3Kfrl7iu6bMTkZJGo52735dH2/lcqbjNcPflC7xkbYDVKxCOoOJ34nXp+IZCWbp4SduCHWRL6PfcFRxFxyNwxnnTB1syLBR2nprv5EBLM13nUotpzPmWWhR1JLQ56GmnYuJyTygVxl+E6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=jGktXyxW; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 47UFLgce047730;
	Fri, 30 Aug 2024 10:21:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1725031302;
	bh=zyA2dHoolcIrKslvuVVKBrvQIthf/3SLsHvHY/u5g7I=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=jGktXyxW1Wt3ZNVNJkyYFW2BDBrpdGO5SD22qGP0hmClaMNvjHyQZs7YhLBFGrEt2
	 QQEsB3KOMfDvSyutHPgrz2y3dv0O3oIRrnzIfrEtrd36zN4fbt+3feIh5O7Dj0jWQ0
	 +KvF0MPy4CTaxj9wiN929PU8YqxGv2Fw/C+YmGq8=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 47UFLgt3051517
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 30 Aug 2024 10:21:42 -0500
Received: from DLEE112.ent.ti.com (157.170.170.23) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 30
 Aug 2024 10:21:42 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 30 Aug 2024 10:21:42 -0500
Received: from [10.249.42.149] ([10.249.42.149])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 47UFLfTi041572;
	Fri, 30 Aug 2024 10:21:41 -0500
Message-ID: <377e6f59-3fe8-4d35-8650-10276649471a@ti.com>
Date: Fri, 30 Aug 2024 10:21:41 -0500
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
CC: <u-kumar1@ti.com>, <j-choudhary@ti.com>, <vaishnav.a@ti.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
References: <20240829060932.3441295-1-b-padhi@ti.com>
 <20240829060932.3441295-2-b-padhi@ti.com>
Content-Language: en-US
From: Andrew Davis <afd@ti.com>
In-Reply-To: <20240829060932.3441295-2-b-padhi@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

On 8/29/24 1:09 AM, Beleswar Padhi wrote:
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
> ---

Reviewed-by: Andrew Davis <afd@ti.com>

> v4: Changelog:
> 1) Put standard properties (resets, firmware-name) before vendor
> specific properties in added DT Nodes. (Nishanth)
> 
> Link to v3:
> https://lore.kernel.org/all/20240828112713.2668526-2-b-padhi@ti.com/
> 
> v3: Changelog:
> 1) None to this patch.
> 
> Link to v2:
> https://lore.kernel.org/all/20240612112259.1131653-2-b-padhi@ti.com/
> 
> v2: Changelog:
> 1) Refactored changes from k3-j722s.dtsi to k3-j722s-main.dtsi. (Andrew)
> 
> Link to v1:
> https://lore.kernel.org/all/20240607090433.488454-2-b-padhi@ti.com/
> 
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

