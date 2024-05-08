Return-Path: <linux-kernel+bounces-173223-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4795B8BFD40
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 14:35:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D61ED1F23F33
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 12:35:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D92655E6C;
	Wed,  8 May 2024 12:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="KI1vs2J/"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF4C554FBE;
	Wed,  8 May 2024 12:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715171718; cv=none; b=cEGHQE+6gZakRXAtZoxpOMCiNkGeDVqeFGXduRnkIX6HpKKVtG4DV8i6bkW7ESU2+rPxMGH1VDt/PDOmmBV3QFunO3tclTBvfWDVrJIPiTq/BsTCeOdzjEYfApTj40TlxQWW1eWD91n6zsSEBg+xlOaDo+h55l/cKMgRNSvXEHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715171718; c=relaxed/simple;
	bh=2Etf+3oMm8wPJG4pw3INs5sFZubsOVqMVAIhncRw1Tc=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=dy9eVk8Uz7IjYixhD+Mj0MWdbUBuUWKkTQSMj+bfWG2N0f+k4GKbnpL65d4vuoK/MY6jTI5wGifbaParTRNLr3VqURhAvgB5RhI9aKhZEH8Xa00z+DPnsdWWXjI+EtgNvPIoK9b3j1V0gXa/xfQCCaivgchhMTJeB0i1myv2hkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=KI1vs2J/; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 448CYwNu024030;
	Wed, 8 May 2024 07:34:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1715171698;
	bh=yHR2bzsPIYHNIgrn3KJGdKIw3Nu3pQhsAXQh/+rbFXs=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=KI1vs2J/Q6NjOdoLtKFjUeMz6uru7mGS+xEBTOidoKQ5yxO86IEdoN+H5PAxJeQcb
	 d+B4T3N0KZkQquLc4VCX1AySyJ4jnoUYPI3JtP+1XGTa7piHlagyR8ve5pIcrn6cUC
	 aaIt/tXw2Sfap3wRhtvCrUiQdLAyqYYs/JDOy/cI=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 448CYwCe025812
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 8 May 2024 07:34:58 -0500
Received: from DFLE101.ent.ti.com (10.64.6.22) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 8
 May 2024 07:34:58 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 8 May 2024 07:34:58 -0500
Received: from [172.24.227.88] (uda0500640.dhcp.ti.com [172.24.227.88])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 448CYsH3086002;
	Wed, 8 May 2024 07:34:55 -0500
Message-ID: <588e4d0a-78c6-553f-3c40-0d248f4c92f9@ti.com>
Date: Wed, 8 May 2024 18:04:53 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 1/3] arm64: dts: ti: k3-j722s: Add support for SERDES0
Content-Language: en-US
To: Roger Quadros <rogerq@kernel.org>, <nm@ti.com>, <vigneshr@ti.com>
CC: <kristo@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <srk@ti.com>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Ravi
 Gunasekaran <r-gunasekaran@ti.com>
References: <20240429120932.11456-1-r-gunasekaran@ti.com>
 <20240429120932.11456-2-r-gunasekaran@ti.com>
 <41047a89-2787-422f-a643-3e2d850da6dd@kernel.org>
From: Ravi Gunasekaran <r-gunasekaran@ti.com>
In-Reply-To: <41047a89-2787-422f-a643-3e2d850da6dd@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180



On 5/8/24 5:29 PM, Roger Quadros wrote:
> 
> 
> On 29/04/2024 15:09, Ravi Gunasekaran wrote:
>> Add SERDES0 and its wrapper description to support USB3
>> and SGMII interfaces.
>>
>> Signed-off-by: Ravi Gunasekaran <r-gunasekaran@ti.com>
>> ---
>>  arch/arm64/boot/dts/ti/k3-j722s.dtsi | 54 ++++++++++++++++++++++++++++
>>  1 file changed, 54 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/ti/k3-j722s.dtsi b/arch/arm64/boot/dts/ti/k3-j722s.dtsi
>> index c75744edb143..beba5a3ea6cc 100644
>> --- a/arch/arm64/boot/dts/ti/k3-j722s.dtsi
>> +++ b/arch/arm64/boot/dts/ti/k3-j722s.dtsi
>> @@ -9,6 +9,7 @@
>>  #include <dt-bindings/interrupt-controller/irq.h>
>>  #include <dt-bindings/interrupt-controller/arm-gic.h>
>>  #include <dt-bindings/soc/ti,sci_pm_domain.h>
>> +#include <dt-bindings/phy/phy-ti.h>
>>  
>>  #include "k3-am62p5.dtsi"
>>  
>> @@ -75,6 +76,50 @@
>>  			 <0x00 0x78000000 0x00 0x78000000 0x00 0x00008000>,
>>  			 <0x00 0x78100000 0x00 0x78100000 0x00 0x00008000>;
>>  	};
>> +
>> +	serdes_refclk: clock-cmnrefclk {
> 
> What could be the generic name here?
> 

How about phy-clk or serdes-clk?
I searched for "fixed-clock" and wide range of naming conventions is followed.

>> +		compatible = "fixed-clock";
>> +		#clock-cells = <0>;
>> +		clock-frequency = <0>;
>> +	};
>> +
>> +	serdes_wiz0: wiz@f000000 {
> 
> Should generic name be phy?

Since serdes is used for both USB and PCIe,
I can go with "phy".

> 
>> +		compatible = "ti,am64-wiz-10g";
>> +		ranges = <0x0f000000 0x0 0x0f000000 0x00010000>;
>> +		#address-cells = <1>;
>> +		#size-cells = <1>;
>> +		power-domains = <&k3_pds 279 TI_SCI_PD_EXCLUSIVE>;
>> +		clocks = <&k3_clks 279 0>, <&k3_clks 279 1>, <&serdes_refclk>;
>> +		clock-names = "fck", "core_ref_clk", "ext_ref_clk";
>> +		num-lanes = <1>;
>> +		#reset-cells = <1>;
>> +		#clock-cells = <1>;
>> +
>> +		assigned-clocks = <&k3_clks 279 1>;
>> +		assigned-clock-parents = <&k3_clks 279 5>;
>> +
>> +		serdes0: serdes@f000000 {
> 
> here too?

I could use "phy" here as well. 
https://elixir.bootlin.com/linux/latest/source/arch/arm64/boot/dts/qcom/sa8775p.dtsi#L1853
https://elixir.bootlin.com/linux/latest/source/arch/arm64/boot/dts/renesas/r8a779f0.dtsi#L563

> 
>> +			compatible = "ti,j721e-serdes-10g";

[...]

> 

-- 
Regards,
Ravi

