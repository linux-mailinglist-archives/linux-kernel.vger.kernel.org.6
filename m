Return-Path: <linux-kernel+bounces-241442-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F250D927B7C
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 18:56:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 610451F22AFB
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 16:56:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 900EF1B3741;
	Thu,  4 Jul 2024 16:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="H+PuYr6z"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61F6717BA0;
	Thu,  4 Jul 2024 16:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720112169; cv=none; b=eymN85jjTwRBtIe+sf8+UMVMWmbzjNHnZPwMAefF/qj/jubvdU/J+mqEWun2oBP90o+CoBom2+es9fKUtMjr5gxmAcTW6+jAxGLDZNEF5S300Xho3+N4BqejMmRcjtyM/Rvh52uQle7mnaw2Cc4kvtxTDSRb1W5Isp3EBaqzA0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720112169; c=relaxed/simple;
	bh=eSTlpVtR37dGssDRdxSAV+2fxA5MDMp9eHBgulbxRv4=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=cN1pIMNkcrozMJrLHNr0SL72Dpp13Yi4z9MIrMpNtcQ117EcZlOlEy/CMwVIzFKuAC7lX3QHx9Wh6s5jUeOm52qNipijqXSgoG9gL6pBtbXfrE4lREoGqj/O/eXEKKAwAnW537DeN1MaDQWT7Vq+BxmkxZaMkcRxvNE5++LGtW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=H+PuYr6z; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 464GtlYA034530;
	Thu, 4 Jul 2024 11:55:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1720112147;
	bh=i8mmMS4YeSimO0/7O080Gbc7oU1oizPIJEm45Ldk4J8=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=H+PuYr6zPrOcRdmSYvX2E9JK6xse7jNf0xJRuAERpnkXooHMtvNxO/2XsMfhZ5tHw
	 oyt9DFiLjyO4fqniqfpugu/WqiuzIQnQy0OXdEI6OlB7d+RB0O2YLe4ZKi6zy3mZGG
	 /QgYpsOnR/qlWNRERYobBGyCZDxTLse5leM4d0D4=
Received: from DFLE107.ent.ti.com (dfle107.ent.ti.com [10.64.6.28])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 464Gtl9i011459
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 4 Jul 2024 11:55:47 -0500
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 4
 Jul 2024 11:55:46 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 4 Jul 2024 11:55:47 -0500
Received: from [10.249.42.149] ([10.249.42.149])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 464Gtk8g092779;
	Thu, 4 Jul 2024 11:55:46 -0500
Message-ID: <edfac25c-d708-4a55-a9bb-97d329877444@ti.com>
Date: Thu, 4 Jul 2024 11:55:45 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 3/3] arm64: dts: ti: grove: Add Grove Sunlight Sensor
 overlay
To: Ayush Singh <ayush@beagleboard.org>, Nishanth Menon <nm@ti.com>,
        Vignesh
 Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>, Rob Herring
	<robh+dt@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
        Vaishnav M A <vaishnav@beagleboard.org>,
        Derek
 Kiernan <derek.kiernan@amd.com>,
        Dragan Cvetic <dragan.cvetic@amd.com>, Arnd
 Bergmann <arnd@arndb.de>,
        Michael Walle <mwalle@kernel.org>,
        Jason Kridner
	<jkridner@beagleboard.org>,
        Robert Nelson <robertcnelson@beagleboard.org>,
        Robert Nelson <robertcnelson@gmail.com>,
        Ayush Singh
	<ayushdevel1325@gmail.com>
CC: <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20240702164403.29067-1-afd@ti.com>
 <20240702164403.29067-4-afd@ti.com>
 <df0f9705-b1e9-4dce-b110-09be540d5e25@beagleboard.org>
Content-Language: en-US
From: Andrew Davis <afd@ti.com>
In-Reply-To: <df0f9705-b1e9-4dce-b110-09be540d5e25@beagleboard.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

On 7/3/24 9:15 AM, Ayush Singh wrote:
> On 7/2/24 22:14, Andrew Davis wrote:
> 
>> Add DT overlay for the Grove Sunlight Sensor[0].
>>
>> [0] https://wiki.seeedstudio.com/Grove-Sunlight_Sensor/
>>
>> Signed-off-by: Andrew Davis <afd@ti.com>
>> ---
>>   arch/arm64/boot/dts/ti/Makefile               |  3 ++
>>   .../boot/dts/ti/grove-sunlight-sensor.dtso    | 31 +++++++++++++++++++
>>   2 files changed, 34 insertions(+)
>>   create mode 100644 arch/arm64/boot/dts/ti/grove-sunlight-sensor.dtso
>>
>> diff --git a/arch/arm64/boot/dts/ti/Makefile b/arch/arm64/boot/dts/ti/Makefile
>> index a859629a6072c..7d1ce7a5d97bc 100644
>> --- a/arch/arm64/boot/dts/ti/Makefile
>> +++ b/arch/arm64/boot/dts/ti/Makefile
>> @@ -8,6 +8,9 @@
>>   # Entries are grouped as per SoC present on the board. Groups are sorted
>>   # alphabetically.
>> +# This needs a better directory location
>> +dtb-$(CONFIG_OF_OVERLAY) += grove-sunlight-sensor.dtbo
>> +
>>   # Boards with AM62x SoC
>>   dtb-$(CONFIG_ARCH_K3) += k3-am625-beagleplay.dtb
>>   dtb-$(CONFIG_ARCH_K3) += k3-am625-beagleplay-csi2-ov5640.dtbo
>> diff --git a/arch/arm64/boot/dts/ti/grove-sunlight-sensor.dtso b/arch/arm64/boot/dts/ti/grove-sunlight-sensor.dtso
>> new file mode 100644
>> index 0000000000000..ab2f102e1f8ab
>> --- /dev/null
>> +++ b/arch/arm64/boot/dts/ti/grove-sunlight-sensor.dtso
>> @@ -0,0 +1,31 @@
>> +// SPDX-License-Identifier: GPL-2.0-or-later OR MIT
>> +/**
>> + * Grove - Sunlight Sensor v1.0
>> + *
>> + * https://wiki.seeedstudio.com/Grove-Sunlight_Sensor/
>> + *
>> + * Copyright (C) 2024 Texas Instruments Incorporated - http://www.ti.com/
>> + */
>> +
>> +/dts-v1/;
>> +/plugin/;
>> +
>> +&GROVE_CONNECTOR {
>> +    status = "okay";
>> +    pinctrl-names = "default";
>> +    pinctrl-0 = <&GROVE_PIN1_MUX_I2C_SCL>,
>> +                <&GROVE_PIN2_MUX_I2C_SDA>;
>> +};
> 
> On setting pinctrl in the mikrobus connector, I seem to encounter problem with the SPI driver trying to use the device before the pins are ready. So I think, the pinctrl should probably be defined in the respective i2c, spi, etc nodes instead of connector.
> 

Maybe, I originally did that but the issue there is it can overwrite
any existing pinmux for that IP node. For instance if you add the
pinmux to a GPIO node, any other users of that GPIO lose their mux.

But you are right, they belong in the IP node. Maybe even in the
specific consumer device node (si1145@60 in this case).

The general idea with all of this is that if we have a board in a
static state (with add-ons already attached) we could write a DTS
that fully describes that steady state. Our challenge is to create
an overlay that transforms the base board into what we would have
written in the static case. In the static case we would have added
the pinmux to the IP node, so that is where it belongs.

The issue then is the overlay mechanism is not complete. We
can add properties to nodes, and add nodes to nodes, and append
properties to nodes, but cannot append values to existing properties,
only replace them completely. This gap in the overlay system will
prevent a general solution. So I've started to work on adding
that property appending ability to the overlay system. I should
have some patches posted against the upstream dtc/libfdt here
in the next week or so.

>> +
>> +&GROVE_PIN1_I2C {
>> +    status = "okay";
>> +    #address-cells = <1>;
>> +    #size-cells = <0>;
>> +
>> +    clock-frequency = <100000>;
>> +
>> +    si1145@60 {
>> +        compatible = "si,si1145";
>> +        reg = <0x60>;
>> +    };
>> +};
> 
> 
> I also have question regarding how to define reg property in SPI (chipselect). Ideally, we want to define it relative to the connector pins, but since the SPI device(s) is a child of SPI controller, I am not sure how I can do remapping.
> 

Could you give me an example? Sounds like the interrupt issue, where
we want say the interrupt belonging to "pin 5", but need to specify
it relative to the base interrupt controller, which we cannot know
anything about in the general case. Instead we need a map, from
pin number to both interrupt controller and IRQ number (or SPI
controller and chipselect number, etc..). I think you are on to
something with the GPIO names, select the GPIO by generic name,
not by board specific number. That might be extendable to IRQs
and other numbered items (but yes, that is still an open item
and I'm waiting on some add-on boards to arrive before I can
start testing ideas on this..).

Andrew

> 
> Ayush Singh
> 

