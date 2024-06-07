Return-Path: <linux-kernel+bounces-206196-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BAB8B900596
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 15:50:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 44CA8B259AD
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 13:50:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60AAC1953AA;
	Fri,  7 Jun 2024 13:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="mcCPMUP+"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED197194C68;
	Fri,  7 Jun 2024 13:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717768246; cv=none; b=TBaFDvfvOPnW8xUfoVEAaKGHOgJ8slkIT5WSRkY+WKqvPOEFvB3FlP7N7ZJGbmtR9Aa7njCKWlGMoQO9rldni9OLYeGuXOjVu9X7OPDSii2gFl0YCNN4Wcyu5dWkTW6mnbw3K+9trDHm8nJV65tVADvF+s/isT6VyUf9WU2xIMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717768246; c=relaxed/simple;
	bh=e6iHO2IYnGpIdIoH1bNHyO9cvIz+obfMNwdQuf55PjQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=lnnlarShbv4Ff/VCs2HoH0Z4yjytP/YOrG3tHj50/E5pHyA67AW0JlaH9fBsJAOvoBpoU5eAGTqZQ10GjxDAG6NqKmBiaj16F5RlUxIHMa8mq0NyTrVd95aKjdJJ7IrCx4gehHE3pBJd41FH6AZ1PKFSnrqsR2vBiI6dEYz9VZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=mcCPMUP+; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 457Doaqa007787;
	Fri, 7 Jun 2024 08:50:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1717768236;
	bh=1Uxh85VvPCAwRMyepNZuRs17wawFAMgwisXPdTshiNo=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=mcCPMUP+BZeAn/T0xah1YhSNOt7F3HRhyI2QG7pickCV7lXMnN7uLcwykbMLHuq4N
	 UImfxMoj06v4eBWQWBsn04J5YMaZvds7k4q+IxfFel9wr2VpZjc1SoMIWJ+0sewuDP
	 uPt6UjUVlqUa8P5xO9KQOZKTzeX4XcrQMaNVzjRg=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 457DoaDX028917
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 7 Jun 2024 08:50:36 -0500
Received: from DLEE101.ent.ti.com (157.170.170.31) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 7
 Jun 2024 08:50:36 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 7 Jun 2024 08:50:36 -0500
Received: from [10.249.42.149] ([10.249.42.149])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 457DoZr7014659;
	Fri, 7 Jun 2024 08:50:35 -0500
Message-ID: <3981ff59-05ea-466a-bfd6-1459556410ad@ti.com>
Date: Fri, 7 Jun 2024 08:50:35 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] arm64: dts: ti: Add R5F and C7x remote processor
 nodes
To: Beleswar Padhi <b-padhi@ti.com>, <nm@ti.com>, <vigneshr@ti.com>
CC: <kristo@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <vaishnav.a@ti.com>, <j-choudhary@ti.com>, <u-kumar1@ti.com>
References: <20240607090433.488454-1-b-padhi@ti.com>
 <20240607090433.488454-2-b-padhi@ti.com>
Content-Language: en-US
From: Andrew Davis <afd@ti.com>
In-Reply-To: <20240607090433.488454-2-b-padhi@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

On 6/7/24 4:04 AM, Beleswar Padhi wrote:
> From: Apurva Nandan <a-nandan@ti.com>
> 
> The K3 J722S SoCs have one single-core Arm Cortex-R5F processor in each
> of the WAKEUP, MCU and MAIN voltage domain, and two C71x DSP subsystems
> in MAIN voltage domain. Add the DT nodes to support Inter-Processor
> Communication.
> 
> Signed-off-by: Apurva Nandan <a-nandan@ti.com>
> Signed-off-by: Beleswar Padhi <b-padhi@ti.com>
> ---
>   arch/arm64/boot/dts/ti/k3-j722s.dtsi | 63 ++++++++++++++++++++++++++++
>   1 file changed, 63 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-j722s.dtsi b/arch/arm64/boot/dts/ti/k3-j722s.dtsi
> index c75744edb1433..a894a132f1667 100644
> --- a/arch/arm64/boot/dts/ti/k3-j722s.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-j722s.dtsi
> @@ -87,3 +87,66 @@ &oc_sram {
>   	reg = <0x00 0x70000000 0x00 0x40000>;
>   	ranges = <0x00 0x00 0x70000000 0x40000>;
>   };
> +
> +&cbass_main {

There is another series[0] in progress that adds `k3-j722s-main.dtsi` for the J722s
MAIN domain items, these new nodes will belong there.

That does mean there is a dependency on that series, but better than having to move
these nodes over later (and I'm sure Nishanth and Vignesh can sort that out when
taking both these series..)

Andrew

[0]https://lore.kernel.org/linux-arm-kernel/20240604085252.3686037-4-s-vadapalli@ti.com/

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
> +			ti,sci = <&dmsc>;
> +			ti,sci-dev-id = <262>;
> +			ti,sci-proc-ids = <0x04 0xff>;
> +			resets = <&k3_reset 262 1>;
> +			firmware-name = "j722s-main-r5f0_0-fw";
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
> +		ti,sci = <&dmsc>;
> +		ti,sci-dev-id = <208>;
> +		ti,sci-proc-ids = <0x30 0xff>;
> +		resets = <&k3_reset 208 1>;
> +		firmware-name = "j722s-c71_0-fw";
> +		status = "disabled";
> +	};
> +
> +	c7x_1: dsp@7e200000 {
> +		compatible = "ti,am62a-c7xv-dsp";
> +		reg = <0x00 0x7e200000 0x00 0x00200000>;
> +		reg-names = "l2sram";
> +		ti,sci = <&dmsc>;
> +		ti,sci-dev-id = <268>;
> +		ti,sci-proc-ids = <0x31 0xff>;
> +		resets = <&k3_reset 268 1>;
> +		firmware-name = "j722s-c71_1-fw";
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
> +};

