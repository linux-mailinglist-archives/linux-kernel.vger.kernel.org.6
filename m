Return-Path: <linux-kernel+bounces-215222-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81ADD909000
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 18:21:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 24612B2750A
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 16:19:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B18A16DEB8;
	Fri, 14 Jun 2024 16:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="cCr7c84L"
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B097FC157;
	Fri, 14 Jun 2024 16:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718381973; cv=none; b=SqACloMqoK/t+puF8lKhOZcC10e8z5swMScTFRh3jwaGx5/dW5egWjpVdhoucEw1CnU5Yxv9v/eHAVGP0D/Jdqdy04FIgv2nrJWhHJ+iWEv69xgZRDzNMucGU3MV3IPVyWCrt+qkuM4+3R6UZnLxzkzs49LOG8ZaHuhF91Puqzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718381973; c=relaxed/simple;
	bh=RvM9Byx6xReLAogbyKCyf0s3T78q56dMUiE2RqExjRA=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=IXlyH/voljZwgdXH9uZ5YMKk9Sw+VoXoQktf0rRscwIc1JFWfGnB2H5PQyaczg7bLjNKPjPCcWWNNf30L1Ls0MMK4zvDBZOc9bmPar3MBUR/eOkanMMo5VacP4NYioAJZ/gz5Byg7Tln+zzNgWyknycCvcxFQvXQXZJKxBOKlCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=cCr7c84L; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 45EGJJNI054952;
	Fri, 14 Jun 2024 11:19:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1718381959;
	bh=EUV7dGvcgbJoB9l9iKdTnHjZx3tt0uz/7rtFxfYa7xU=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=cCr7c84LnRHERwwuSEdVI3fQCQbb94U8dnJO22RyhDhX9Vxs4sdC/utM/vHERRd3A
	 WbLaOijDmmNt+4kdaYwErotQfb7ZNjmtbbRVOueUMi1Y+lgeb9wFj1J46GfCrjs4r/
	 7xNhPD2Mut7vYAkVNaNuCYQBt2FGALjzH94c0oDA=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 45EGJIrU020171
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 14 Jun 2024 11:19:19 -0500
Received: from DLEE108.ent.ti.com (157.170.170.38) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 14
 Jun 2024 11:19:18 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 14 Jun 2024 11:19:18 -0500
Received: from [10.249.42.149] ([10.249.42.149])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 45EGJIqB101018;
	Fri, 14 Jun 2024 11:19:18 -0500
Message-ID: <50327a4a-3653-43d7-88de-2182dc3eb4e7@ti.com>
Date: Fri, 14 Jun 2024 11:19:18 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] arm64: dts: ti: k3-am65: Move SerDes mux nodes under
 the control node
To: Jan Kiszka <jan.kiszka@siemens.com>, Nishanth Menon <nm@ti.com>,
        Vignesh
 Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>, Rob Herring
	<robh+dt@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
CC: <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20240326185627.29852-1-afd@ti.com>
 <20240326185627.29852-2-afd@ti.com>
 <a15da17a-f196-4356-a744-5c8e1104e7c0@siemens.com>
Content-Language: en-US
From: Andrew Davis <afd@ti.com>
In-Reply-To: <a15da17a-f196-4356-a744-5c8e1104e7c0@siemens.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

On 6/14/24 2:44 AM, Jan Kiszka wrote:
> On 26.03.24 19:56, Andrew Davis wrote:
>> These SerDes lane select muxes use bits from the same register as
>> the SerDes clock select mux. Make the lane select mux a child
>> of the SerDes control node.
>>
>> This removes one more requirement on scm-conf being a syscon node
>> which will later be converted to fix a couple DTS check warnings.
>>
>> Signed-off-by: Andrew Davis <afd@ti.com>
>> ---
>>   arch/arm64/boot/dts/ti/k3-am65-main.dtsi | 21 +++++++++++++--------
>>   1 file changed, 13 insertions(+), 8 deletions(-)
>>
>> diff --git a/arch/arm64/boot/dts/ti/k3-am65-main.dtsi b/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
>> index 738c5c4acbcd2..5ce67e6a33600 100644
>> --- a/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
>> +++ b/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
>> @@ -66,7 +66,7 @@ serdes0: serdes@900000 {
>>   		assigned-clock-parents = <&k3_clks 153 8>, <&k3_clks 153 4>;
>>   		ti,serdes-clk = <&serdes0_clk>;
>>   		#clock-cells = <1>;
>> -		mux-controls = <&serdes_mux 0>;
>> +		mux-controls = <&serdes0_mux 0>;
>>   	};
>>   
>>   	serdes1: serdes@910000 {
>> @@ -81,7 +81,7 @@ serdes1: serdes@910000 {
>>   		assigned-clock-parents = <&k3_clks 154 9>, <&k3_clks 154 5>;
>>   		ti,serdes-clk = <&serdes1_clk>;
>>   		#clock-cells = <1>;
>> -		mux-controls = <&serdes_mux 1>;
>> +		mux-controls = <&serdes1_mux 0>;
>>   	};
>>   
>>   	main_uart0: serial@2800000 {
>> @@ -485,18 +485,23 @@ scm_conf: scm-conf@100000 {
>>   		serdes0_clk: clock@4080 {
>>   			compatible = "ti,am654-serdes-ctrl", "syscon";
>>   			reg = <0x4080 0x4>;
>> +
>> +			serdes0_mux: mux-controller {
>> +				compatible = "mmio-mux";
>> +				#mux-control-cells = <1>;
>> +				mux-reg-masks = <0x0 0x3>; /* lane select */
>> +			};
>>   		};
>>   
>>   		serdes1_clk: clock@4090 {
>>   			compatible = "ti,am654-serdes-ctrl", "syscon";
>>   			reg = <0x4090 0x4>;
>> -		};
>>   
>> -		serdes_mux: mux-controller {
>> -			compatible = "mmio-mux";
>> -			#mux-control-cells = <1>;
>> -			mux-reg-masks = <0x4080 0x3>, /* SERDES0 lane select */
>> -					<0x4090 0x3>; /* SERDES1 lane select */
>> +			serdes1_mux: mux-controller {
>> +				compatible = "mmio-mux";
>> +				#mux-control-cells = <1>;
>> +				mux-reg-masks = <0x0 0x3>; /* lane select */
>> +			};
>>   		};
>>   
>>   		dss_oldi_io_ctrl: dss-oldi-io-ctrl@41e0 {
> 
> This change breaks serdes setup on the IOT2050 SM (k3-am6548-iot2050-
> advanced-sm.dts), possibly on more of our devices as well:
> 
> platform 5500000.pcie: deferred probe pending: platform: supplier 900000.serdes not ready
> platform 900000.serdes: deferred probe pending: (reason unknown)
> 
> And PCI remains unavailable. Digging a bit into it, it seems the change
> is causing a circular consumer/provider dependency between serdes0 and
> serdes1:
> 
> root@iot2050-debian:~# ls -l /sys/bus/platform/devices/900000.serdes/
> total 0
> lrwxrwxrwx 1 root root    0 Jun 14 07:10 consumer:platform:5500000.pcie -> ../../../virtual/devlink/platform:900000.serdes--platform:5500000.pcie
> lrwxrwxrwx 1 root root    0 Jun 14 07:10 consumer:platform:910000.serdes -> ../../../virtual/devlink/platform:900000.serdes--platform:910000.serdes
> -rw-r--r-- 1 root root 4096 Jun 14 07:10 driver_override
> -r--r--r-- 1 root root 4096 Jun 14 07:10 modalias
> lrwxrwxrwx 1 root root    0 Jun 14 07:10 of_node -> ../../../../firmware/devicetree/base/bus@100000/serdes@900000
> drwxr-xr-x 2 root root    0 Jun 14 07:10 power
> lrwxrwxrwx 1 root root    0 Jun 14 07:00 subsystem -> ../../../../bus/platform
> lrwxrwxrwx 1 root root    0 Jun 14 07:10 supplier:platform:44083000.system-controller:clock-controller -> ../../../virtual/devlink/platform:44083000.system-controller:clock-controller--platform:900000.serdes
> lrwxrwxrwx 1 root root    0 Jun 14 07:10 supplier:platform:44083000.system-controller:power-controller -> ../../../virtual/devlink/platform:44083000.system-controller:power-controller--platform:900000.serdes
> lrwxrwxrwx 1 root root    0 Jun 14 07:10 supplier:platform:910000.serdes -> ../../../virtual/devlink/platform:910000.serdes--platform:900000.serdes
> -rw-r--r-- 1 root root 4096 Jun 14 07:00 uevent
> -r--r--r-- 1 root root 4096 Jun 14 07:10 waiting_for_supplier
> root@iot2050-debian:~# ls -l /sys/bus/platform/devices/910000.serdes/
> total 0
> lrwxrwxrwx 1 root root    0 Jun 14 07:14 consumer:platform:900000.serdes -> ../../../virtual/devlink/platform:910000.serdes--platform:900000.serdes
> -rw-r--r-- 1 root root 4096 Jun 14 07:14 driver_override
> -r--r--r-- 1 root root 4096 Jun 14 07:14 modalias
> lrwxrwxrwx 1 root root    0 Jun 14 07:14 of_node -> ../../../../firmware/devicetree/base/bus@100000/serdes@910000
> drwxr-xr-x 2 root root    0 Jun 14 07:14 power
> lrwxrwxrwx 1 root root    0 Jun 14 07:00 subsystem -> ../../../../bus/platform
> lrwxrwxrwx 1 root root    0 Jun 14 07:14 supplier:platform:44083000.system-controller:clock-controller -> ../../../virtual/devlink/platform:44083000.system-controller:clock-controller--platform:910000.serdes
> lrwxrwxrwx 1 root root    0 Jun 14 07:14 supplier:platform:44083000.system-controller:power-controller -> ../../../virtual/devlink/platform:44083000.system-controller:power-controller--platform:910000.serdes
> lrwxrwxrwx 1 root root    0 Jun 14 07:14 supplier:platform:900000.serdes -> ../../../virtual/devlink/platform:900000.serdes--platform:910000.serdes
> -rw-r--r-- 1 root root 4096 Jun 14 07:00 uevent
> -r--r--r-- 1 root root 4096 Jun 14 07:14 waiting_for_supplier
> 
> Note that we normally disable serdes1 on this device as it was not
> required so far. Enabling the node does not solve the issue, though:
> 
> platform 5500000.pcie: deferred probe pending: platform: supplier 900000.serdes not ready
> platform 900000.serdes: deferred probe pending: (reason unknown)
> platform 910000.serdes: deferred probe pending: (reason unknown)
> 

Thanks for the report, I think I know the issue and can
send the fix here in a bit. In the mean time, could you
see if the following fixes the issue (this isn't fully
correct and will cause a new DTB check warning, but will
let me verify the issue):

diff --git a/arch/arm64/boot/dts/ti/k3-am65-main.dtsi b/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
index 1af3dedde1f67..06ed74197f893 100644
--- a/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
@@ -478,7 +478,7 @@ scm_conf: scm-conf@100000 {
                 ranges = <0x0 0x0 0x00100000 0x1c000>;
  
                 serdes0_clk: clock@4080 {
-                       compatible = "ti,am654-serdes-ctrl", "syscon";
+                       compatible = "ti,am654-serdes-ctrl", "syscon", "simple-mfd";
                         reg = <0x4080 0x4>;
  
                         serdes0_mux: mux-controller {
@@ -489,7 +489,7 @@ serdes0_mux: mux-controller {
                 };
  
                 serdes1_clk: clock@4090 {
-                       compatible = "ti,am654-serdes-ctrl", "syscon";
+                       compatible = "ti,am654-serdes-ctrl", "syscon", "simple-mfd";
                         reg = <0x4090 0x4>;
  
                         serdes1_mux: mux-controller {

Thanks,
Andrew

> Jan
> 

