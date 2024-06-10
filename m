Return-Path: <linux-kernel+bounces-207745-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F139901B6B
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 08:54:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3D6F01C20F68
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 06:54:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A7561C6A4;
	Mon, 10 Jun 2024 06:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="N7+p5tiP"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEB76224E8;
	Mon, 10 Jun 2024 06:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718002434; cv=none; b=Xazj0YFLhhKhC9nXRrnZPE5EtjkNDMQcEDyb4YqQtE008690IwEP3j+Wld3cMfS47cKZEmLqYJSZ+t+gF3zbOa4waW24IYtdThN1I8kiMwnH/86ltYjX9ysoOLITRZdAPZ3qJIJYXx4ofZZxotzjDC3aDRoO5IW+SSxyE/9sKKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718002434; c=relaxed/simple;
	bh=UUCkxg6F+ZFRb1qsY17FUuhKbviHXLlzPpVxYybdOew=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=WziG1Ld/SwBNeAYIliVp8piWKk0N/ustnhpBkw2VRe8xFtS+xdFVzHYQ8Y/u3tEYEjY499HKDA07K2TWFhfrAdPhp0ef86OndSwxPpz2mJIHjgtjHDFubyRTGpxI2cGY6n3KtGdYZAs1EeYhNA1p0LfJ3pYVNPinjT6YGBH89uY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=N7+p5tiP; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 45A6rgTQ062074;
	Mon, 10 Jun 2024 01:53:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1718002422;
	bh=PxnIiwyzOSMm+O787G/I/NLCdKWBirKxD1GYw/nsyIU=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=N7+p5tiPlvsZQvFvwivsnqRlra8BPzjGA184BMns9VSKNEkxyxB2dN+oKMEp+n8kB
	 8mNj5MKwjfeuAGLwgO9P1WS7wTv0CYypqJdwHlmHHos0qCmtjwp0HMT+rd9Fe/vQTA
	 LjqbArHlGoMgwUb74IJ7/fJ1WbPrGqKTq4AcSo3Y=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 45A6rgZI125131
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 10 Jun 2024 01:53:42 -0500
Received: from DLEE112.ent.ti.com (157.170.170.23) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 10
 Jun 2024 01:53:42 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 10 Jun 2024 01:53:42 -0500
Received: from [172.24.227.94] (uda0132425.dhcp.ti.com [172.24.227.94])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 45A6rbgZ112839;
	Mon, 10 Jun 2024 01:53:37 -0500
Message-ID: <1156c363-93a8-4c31-8305-39d5da99653e@ti.com>
Date: Mon, 10 Jun 2024 12:23:36 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 4/7] arm64: dts: ti: k3-j722s: Switch to
 k3-am62p-j722s-common.dtsi
To: Roger Quadros <rogerq@kernel.org>,
        Siddharth Vadapalli
	<s-vadapalli@ti.com>, <nm@ti.com>, <afd@ti.com>,
        <kristo@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>
CC: <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <u-kumar1@ti.com>,
        <danishanwar@ti.com>, <srk@ti.com>
References: <20240604085252.3686037-1-s-vadapalli@ti.com>
 <20240604085252.3686037-5-s-vadapalli@ti.com>
 <79eedaea-bf4f-4a20-8a52-751ce7187523@ti.com>
 <c6d1b64b-48bf-435f-823c-fb4c588819cc@kernel.org>
From: Vignesh Raghavendra <vigneshr@ti.com>
Content-Language: en-US
In-Reply-To: <c6d1b64b-48bf-435f-823c-fb4c588819cc@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180



On 06/06/24 13:04, Roger Quadros wrote:
> 
> 
> On 06/06/2024 07:05, Vignesh Raghavendra wrote:
>>
>>
>> On 04/06/24 14:22, Siddharth Vadapalli wrote:
>>> Update "k3-j722s.dtsi" to use "k3-am62p-j722s-common.dtsi" which
>>> contains the nodes shared with AM62P, followed by including the J722S
>>> specific main domain peripherals contained in "k3-j722s-main.dtsi".
>>>
>>> Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
>>> ---
>>> v4:
>>> https://lore.kernel.org/r/20240601121554.2860403-5-s-vadapalli@ti.com/
>>> No changes since v4.
>>>
>>>  arch/arm64/boot/dts/ti/k3-j722s.dtsi | 97 +++++++++++++++++++++++++++-
>>>  1 file changed, 96 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/arch/arm64/boot/dts/ti/k3-j722s.dtsi b/arch/arm64/boot/dts/ti/k3-j722s.dtsi
>>> index c75744edb143..9e04e6a5c0fd 100644
>>> --- a/arch/arm64/boot/dts/ti/k3-j722s.dtsi
>>> +++ b/arch/arm64/boot/dts/ti/k3-j722s.dtsi
>>> @@ -10,12 +10,107 @@
>>>  #include <dt-bindings/interrupt-controller/arm-gic.h>
>>>  #include <dt-bindings/soc/ti,sci_pm_domain.h>
>>>  
>>> -#include "k3-am62p5.dtsi"
>>> +#include "k3-am62p-j722s-common.dtsi"
>>> +#include "k3-j722s-main.dtsi"
>>>  
>>>  / {
>>>  	model = "Texas Instruments K3 J722S SoC";
>>>  	compatible = "ti,j722s";
>>>  
>>> +	cpus {
>>> +		#address-cells = <1>;
>>> +		#size-cells = <0>;
>>> +
>>> +		cpu-map {
>>> +			cluster0: cluster0 {
>>> +				core0 {
>>> +					cpu = <&cpu0>;
>>> +				};
>>> +
>>> +				core1 {
>>> +					cpu = <&cpu1>;
>>> +				};
>>> +
>>> +				core2 {
>>> +					cpu = <&cpu2>;
>>> +				};
>>> +
>>> +				core3 {
>>> +					cpu = <&cpu3>;
>>> +				};
>>> +			};
>>> +		};
>>> +
>>> +		cpu0: cpu@0 {
>>> +			compatible = "arm,cortex-a53";
>>> +			reg = <0x000>;
>>> +			device_type = "cpu";
>>> +			enable-method = "psci";
>>> +			i-cache-size = <0x8000>;
>>> +			i-cache-line-size = <64>;
>>> +			i-cache-sets = <256>;
>>> +			d-cache-size = <0x8000>;
>>> +			d-cache-line-size = <64>;
>>> +			d-cache-sets = <128>;
>>> +			next-level-cache = <&l2_0>;
>>> +			clocks = <&k3_clks 135 0>;
>>> +		};
>>> +
>>> +		cpu1: cpu@1 {
>>> +			compatible = "arm,cortex-a53";
>>> +			reg = <0x001>;
>>> +			device_type = "cpu";
>>> +			enable-method = "psci";
>>> +			i-cache-size = <0x8000>;
>>> +			i-cache-line-size = <64>;
>>> +			i-cache-sets = <256>;
>>> +			d-cache-size = <0x8000>;
>>> +			d-cache-line-size = <64>;
>>> +			d-cache-sets = <128>;
>>> +			next-level-cache = <&l2_0>;
>>> +			clocks = <&k3_clks 136 0>;
>>> +		};
>>> +
>>> +		cpu2: cpu@2 {
>>> +			compatible = "arm,cortex-a53";
>>> +			reg = <0x002>;
>>> +			device_type = "cpu";
>>> +			enable-method = "psci";
>>> +			i-cache-size = <0x8000>;
>>> +			i-cache-line-size = <64>;
>>> +			i-cache-sets = <256>;
>>> +			d-cache-size = <0x8000>;
>>> +			d-cache-line-size = <64>;
>>> +			d-cache-sets = <128>;
>>> +			next-level-cache = <&l2_0>;
>>> +			clocks = <&k3_clks 137 0>;
>>> +		};
>>> +
>>> +		cpu3: cpu@3 {
>>> +			compatible = "arm,cortex-a53";
>>> +			reg = <0x003>;
>>> +			device_type = "cpu";
>>> +			enable-method = "psci";
>>> +			i-cache-size = <0x8000>;
>>> +			i-cache-line-size = <64>;
>>> +			i-cache-sets = <256>;
>>> +			d-cache-size = <0x8000>;
>>> +			d-cache-line-size = <64>;
>>> +			d-cache-sets = <128>;
>>> +			next-level-cache = <&l2_0>;
>>> +			clocks = <&k3_clks 138 0>;
>>> +		};
>>> +	};
>>> +
>>> +	l2_0: l2-cache0 {
>>> +		compatible = "cache";
>>> +		cache-unified;
>>> +		cache-level = <2>;
>>> +		cache-size = <0x80000>;
>>> +		cache-line-size = <64>;
>>> +		cache-sets = <512>;
>>> +	};
>>> +
>>>  	cbass_main: bus@f0000 {
>>>  		compatible = "simple-bus";
>>>  		#address-cells = <2>;
>>
>>
>> You would need to move the rest of main domain overrides and cbass_main
>> definitions to k3-j722s-main.dtsi and limit this file to CPU definitions
>> similar to k3-am62p5.dtsi
> 
> Not exactly.
> In existing cases there are 2 soc.dtsi files. e.g. k3-am62p.dtsi and k3-am62p5.dtsi.
> or k3-am2.dtsi and k3-am625.dtsi.
> 
> The former includes everything that is required for the SOC variant except the CPU, OPP and cache.
> The later includes just the CPU, OPP and cache.
> 
> I suppose this only makes sense if there are multiple variants of the SoC where only
> the number of CPUs change. Would this be the case for J722S?


Part numbers with different OPPs are expected besides difference in
number of cores for J722s.

> 
> If not then one soc.dtsi file should be sufficient. If yes then we need to have 2 soc.dtsi files
> for J722S like the rest.
> 

-- 
Regards
Vignesh

