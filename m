Return-Path: <linux-kernel+bounces-313125-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B3F8696A098
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 16:29:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D9DBF1C23DF7
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 14:29:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B85E2AE68;
	Tue,  3 Sep 2024 14:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Khq2s4f6"
Received: from out-183.mta1.migadu.com (out-183.mta1.migadu.com [95.215.58.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4710E7581B
	for <linux-kernel@vger.kernel.org>; Tue,  3 Sep 2024 14:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725373691; cv=none; b=CKQ4Ub2A3biMJbssqyGRS8inuipH0GrXHLpAfLgiS62nzZaENEBPpJCG4KO8E+PIBzvSvX3tWxYwdY9+ao8D3zmUjXDX37m4tAGWy6l9zYoPQrdP4t76pSSl2ZdqErRgEIyx9eRbdUREs2KZSU12dEoOmVoU79uz1lhB7Z+WUdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725373691; c=relaxed/simple;
	bh=ojz+7WparPkVQwWyEjl4rdXO1jICIRfxsnlaOrFuNlA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=T5rksNGErLpvFNoq/88MSg7591gDBe0tikFVvraYJE0Qc7h2LG31CFm2QLVBua7dfEtIQKQU5OgTmeWPcltBFhLFmatKIeT2v89KxS2/WzQw/oilImp3gZpvV+loniXM9Xpzn/8EVPBjpQco2L0ZDFeQ8O9uftb57weKf9C1nzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Khq2s4f6; arc=none smtp.client-ip=95.215.58.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <7348caab-726c-4c30-8634-a7820aec97d1@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1725373685;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ymhIc+2OBz7c40DDcJxEUjad+Et8wdGnqysD/7o2s18=;
	b=Khq2s4f686heVHMRR8ofZwIgYqRYWzjWwUl8nXBKpHbqHbJbsBtCaKhGArrrLur05F9Sl9
	35ceY7w+71vvS4uimweBoLi16R0G8++NiTSZVmh11YHxvnHkKbZFjXHBQTuOkmF7qc+JpO
	EU7MZuSv5cVlo6pRUhG33j4Q0bINjxY=
Date: Tue, 3 Sep 2024 10:27:49 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 3/3] arm64: zynqmp: Add thermal zones
To: "Thangaraj, Senthil Nathan" <SenthilNathan.Thangaraj@amd.com>,
 "Simek, Michal" <michal.simek@amd.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Cc: Rob Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
References: <20240812215129.3599832-1-sean.anderson@linux.dev>
 <20240812215129.3599832-4-sean.anderson@linux.dev>
 <LV3PR12MB9260AC14D997DED122284940E2932@LV3PR12MB9260.namprd12.prod.outlook.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Sean Anderson <sean.anderson@linux.dev>
In-Reply-To: <LV3PR12MB9260AC14D997DED122284940E2932@LV3PR12MB9260.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 9/3/24 04:32, Thangaraj, Senthil Nathan wrote:
> Hi Sean,
> 
> Please find my review comments inline.
> 
> Thanks,
> Senthil.
> 
>> -----Original Message-----
>> From: Sean Anderson <sean.anderson@linux.dev>
>> Sent: Monday, August 12, 2024 2:51 PM
>> To: Simek, Michal <michal.simek@amd.com>; linux-arm-
>> kernel@lists.infradead.org
>> Cc: Rob Herring <robh@kernel.org>; Conor Dooley <conor+dt@kernel.org>;
>> Krzysztof Kozlowski <krzk+dt@kernel.org>; linux-kernel@vger.kernel.org;
>> devicetree@vger.kernel.org; Sean Anderson <sean.anderson@linux.dev>
>> Subject: [PATCH 3/3] arm64: zynqmp: Add thermal zones
>> 
>> Add some thermal trip points. We can't undervolt the CPUs to save power
>> when we underclock them, so there isn't really a point in throttling them until
>> we are about to overheat. As such, the passive trip point is right below the
>> critical trip point.
>> 
>> The critical trip point is the extended/industrial-grade maximum junction
>> temperature of 100C minus the maximum temperature sensor error of 3.5C
>> (in the range -55C to 110C). Automotive- and military-grade parts can go up
>> to 125C, but as far as I can tell there is no way to detect them at runtime.
>> Userspace can adjust the trip points at runtime, but this may not be viable
>> when booting above 100C. I think it's reasonable to ask automotive/military
>> users to edit their device trees to bump the trip points, but if that proves to be
>> an issue we can always go with no default temperatures. However, that
>> wouldn't be too nice for the majority of extended/industrial users.
>> 
>> Signed-off-by: Sean Anderson <sean.anderson@linux.dev>
>> ---
>> 
>>  arch/arm64/boot/dts/xilinx/zynqmp.dtsi | 86
>> ++++++++++++++++++++++++++
>>  1 file changed, 86 insertions(+)
>> 
>> diff --git a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
>> b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
>> index 21c1adbaf35f..467f084c6469 100644
>> --- a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
>> +++ b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
>> @@ -18,6 +18,7 @@
>>  #include <dt-bindings/interrupt-controller/irq.h>
>>  #include <dt-bindings/power/xlnx-zynqmp-power.h>
>>  #include <dt-bindings/reset/xlnx-zynqmp-resets.h>
>> +#include <dt-bindings/thermal/thermal.h>
>> 
>>  / {
>>  	compatible = "xlnx,zynqmp";
>> @@ -36,6 +37,7 @@ cpus {
>>  		#size-cells = <0>;
>> 
>>  		cpu0: cpu@0 {
>> +			#cooling-cells = <2>;
>>  			compatible = "arm,cortex-a53";
>>  			device_type = "cpu";
>>  			enable-method = "psci";
>> @@ -46,6 +48,7 @@ cpu0: cpu@0 {
>>  		};
>> 
>>  		cpu1: cpu@1 {
>> +			#cooling-cells = <2>;
>>  			compatible = "arm,cortex-a53";
>>  			device_type = "cpu";
>>  			enable-method = "psci";
>> @@ -56,6 +59,7 @@ cpu1: cpu@1 {
>>  		};
>> 
>>  		cpu2: cpu@2 {
>> +			#cooling-cells = <2>;
>>  			compatible = "arm,cortex-a53";
>>  			device_type = "cpu";
>>  			enable-method = "psci";
>> @@ -66,6 +70,7 @@ cpu2: cpu@2 {
>>  		};
>> 
>>  		cpu3: cpu@3 {
>> +			#cooling-cells = <2>;
>>  			compatible = "arm,cortex-a53";
>>  			device_type = "cpu";
>>  			enable-method = "psci";
>> @@ -406,6 +411,87 @@ ams {
>>  			<&xilinx_ams 27>, <&xilinx_ams 28>, <&xilinx_ams
>> 29>;
>>  	};
>> 
>> +
>> +	tsens_apu: thermal-sensor-apu {
>> +		compatible = "generic-adc-thermal";
>> +		#thermal-sensor-cells = <0>;
>> +		io-channels = <&xilinx_ams 7>;
>> +		io-channel-names = "sensor-channel";
>> +	};
>> +
>> +	tsens_rpu: thermal-sensor-rpu {
>> +		compatible = "generic-adc-thermal";
>> +		#thermal-sensor-cells = <0>;
>> +		io-channels = <&xilinx_ams 8>;
>> +		io-channel-names = "sensor-channel";
>> +	};
>> +
>> +	tsens_pl: thermal-sensor-pl {
>> +		compatible = "generic-adc-thermal";
>> +		#thermal-sensor-cells = <0>;
>> +		io-channels = <&xilinx_ams 20>;
>> +		io-channel-names = "sensor-channel";
>> +	};
>> +
>> +	thermal-zones {
>> +		apu-thermal {
>> +			polling-delay-passive = <1000>;
>> +			polling-delay = <5000>;
> 
> How did we arrive at these delays, 1000 and 5000 ? could you please clarify ?

They're just arbitrary. Feel free to suggest other numbers. I could find
no guidance on this matter (or anything else thermal-related).

>> +			thermal-sensors = <&tsens_apu>;
>> +
>> +			trips {
>> +				apu_passive: passive {
>> +					temperature = <93000>;
>> +					hysteresis = <3500>;
>> +					type = "passive";
>> +				};
>> +
>> +				apu_critical: critical {
>> +					temperature = <96500>;
>> +					hysteresis = <3500>;
>> +					type = "critical";
>> +				};
>> +			};
>> +
>> +			cooling-maps {
>> +				map {
>> +					trip = <&apu_passive>;
>> +					cooling-device =
>> +						<&cpu0 THERMAL_NO_LIMIT
>> THERMAL_NO_LIMIT>,
>> +						<&cpu1 THERMAL_NO_LIMIT
>> THERMAL_NO_LIMIT>,
>> +						<&cpu2 THERMAL_NO_LIMIT
>> THERMAL_NO_LIMIT>,
>> +						<&cpu3 THERMAL_NO_LIMIT
>> THERMAL_NO_LIMIT>;
>> +				};
>> +			};
>> +		};
>> +
>> +		rpu-thermal {
>> +			polling-delay = <10000>;
> 
> Same questions, how did we come up with number 10000
> 
>> +			thermal-sensors = <&tsens_rpu>;
>> +
>> +			trips {
>> +				critical {
>> +					temperature = <96500>;
>> +					hysteresis = <3500>;
>> +					type = "critical";
>> +				};
> 
> Any reason why we haven't defined for passive trip point for RPU ?

What is there to do? It is up to the RPU software to do something if the
RPU is going to overheat. But the more-likely occurrence is that the APU
is overheating and the heat is spreading to the RPU. In which case, the
APU passive trip point will handle things.

>> +			};
>> +		};
>> +
>> +		pl-thermal {
>> +			polling-delay = <10000>;
>> +			thermal-sensors = <&tsens_pl>;
>> +
>> +			trips {
>> +				critical {
>> +					temperature = <96500>;
>> +					hysteresis = <3500>;
>> +					type = "critical";
>> +				};
>> +			};
> Same question, any reason why we haven't defined for passive trip point for PL ?
>> +		};
>> +	};
>> +
>>  	amba: axi {
>>  		compatible = "simple-bus";
>>  		bootph-all;
>> --
>> 2.35.1.1320.gc452695387.dirty
> 

