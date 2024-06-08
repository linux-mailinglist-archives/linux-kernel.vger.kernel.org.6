Return-Path: <linux-kernel+bounces-207185-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 15DEE901365
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jun 2024 22:05:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A2DD82827A3
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jun 2024 20:05:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A66EB20B3E;
	Sat,  8 Jun 2024 20:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mail.de header.i=@mail.de header.b="cBUPyWHz"
Received: from shout11.mail.de (shout11.mail.de [62.201.172.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C8396FC6;
	Sat,  8 Jun 2024 20:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.201.172.57
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717877093; cv=none; b=YHqrhA6lmjZns8rMzYM2sfWcCQh+vdXbMc/Sb3LPmp3NF3uACQMASAC43BDxeYlvbMgIIWmTZ2YTnrnJutE1PiWrMvyMx6BKFFnH5f71Puwxrj9I89VvwCNPzg2kaBnEPcKCHWsnOAN/t7G7IaCTZU0sv6m11TRAdYXf5PQ2DOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717877093; c=relaxed/simple;
	bh=WAZOUGHN724lAzJ1hmJHyhH+KpdZGw5w6ew+tZEde5c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=m48cBQrX5tEVqM/PZYUy45GGMYgsuCM0OdUwWH50SzYveOT4YLpMKt7FThUnuFSKQvg3Z7/kR++hoQk8MbyY2yFOESd9yx8WqZFKIsLIOp2UBsvMcJrTl79R55JtoT+UmCZYg/sbPb1azRiASZRPr3UjC70voMzeGGq6uCCpGfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mail.de; spf=pass smtp.mailfrom=mail.de; dkim=pass (2048-bit key) header.d=mail.de header.i=@mail.de header.b=cBUPyWHz; arc=none smtp.client-ip=62.201.172.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mail.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.de
Received: from shout02.mail.de (unknown [10.0.120.222])
	by shout11.mail.de (Postfix) with ESMTPS id B492A24195A;
	Sat,  8 Jun 2024 21:58:39 +0200 (CEST)
Received: from postfix01.mail.de (postfix01.bt.mail.de [10.0.121.125])
	by shout02.mail.de (Postfix) with ESMTP id 8EFDA240C8A;
	Sat,  8 Jun 2024 21:58:39 +0200 (CEST)
Received: from smtp01.mail.de (smtp02.bt.mail.de [10.0.121.212])
	by postfix01.mail.de (Postfix) with ESMTP id 6BD998016E;
	Sat,  8 Jun 2024 21:58:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mail.de;
	s=mailde202009; t=1717876719;
	bh=WAZOUGHN724lAzJ1hmJHyhH+KpdZGw5w6ew+tZEde5c=;
	h=Message-ID:Date:Subject:To:Cc:From:From:To:CC:Subject:Reply-To;
	b=cBUPyWHzhE9FFGKHqZKsP9TrT5pZOY0MatSJWtjJ7Z5FXQVaaL/xY+gJYaHhx/sOw
	 kNciR6uZmC4h4frFuGNhgBiDMiYDMzhYMBnvyosoWAsnV9EuCtf08ZsRcHFplpS3G0
	 0VMLHyAlOYlyk8RR9APAzajPCCjVfvux7tBFk7LbNPmhyB4nNgPxTw8wGhgsVy6F7q
	 ZFzGIbGy4Ido9lj+mIJjn6kp2gzGIvIV9mhPoS1/bJt4/BA1RA7/ZwRvPGgahqDkY9
	 Z9n59vi4c/wUjY+UegMldtFwQaCJ8f/VmLJOswqgAHHSHwXi3MuoTFdQYqKX0MFbQE
	 24a2ww23b1IfQ==
Received: from [127.0.0.1] (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp01.mail.de (Postfix) with ESMTPSA id 04491240C95;
	Sat,  8 Jun 2024 21:58:37 +0200 (CEST)
Message-ID: <ea39242d-9b2d-4ea0-aa24-8a959e4f875e@mail.de>
Date: Sat, 8 Jun 2024 21:58:36 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2 2/2] arm64: dts: rockchip: Add FriendlyElec CM3588 NAS
 board
To: Space Meyer <me@the-space.agency>, Heiko Stuebner <heiko@sntech.de>,
 linux-rockchip@lists.infradead.org,
 Sebastian Reichel <sebastian.reichel@collabora.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Jonas Karlman <jonas@kwiboo.se>,
 Dragan Simic <dsimic@manjaro.org>, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20240602211901.237769-1-seb-dev@mail.de>
 <20240602202132.2012-1-seb-dev@mail.de>
 <20240602202132.2012-2-seb-dev@mail.de>
 <c4087311-cbd2-415e-a582-3565f2f62e81@the-space.agency>
From: Sebastian Kropatsch <seb-dev@mail.de>
In-Reply-To: <c4087311-cbd2-415e-a582-3565f2f62e81@the-space.agency>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-purgate: clean
X-purgate: This mail is considered clean (visit http://www.eleven.de for further information)
X-purgate-type: clean
X-purgate-Ad: Categorized by eleven eXpurgate (R) http://www.eleven.de
X-purgate: This mail is considered clean (visit http://www.eleven.de for further information)
X-purgate: clean
X-purgate-size: 6206
X-purgate-ID: 154282::1717876719-BE52C878-BE602C79/0/0

Hello Space,

Am 06.06.2024 um 15:13 schrieb Space Meyer:
> + Sebastian Reichel regarding pcie3x4 BAR 1 overlap
> [...]
> However there are some issues:
> - Type-C: No PD negotiated in or out
> - Type-C: No USB 1/2/3 devices recognised (I don't have any device to 
> test DP mode switching)
> - Audio: No audio (might just be my userspace)

The audio driver is pretty barebones, at least by looking at the
dt bindings (search for "realtek,rt5616"). I couldn't find any other
device apart from the NanoPC T6 and one old rk device that uses it.
Per dt bindings, properties like clocks and so on are invalid for
the current rt5616 driver.

Just look at FriendlyElec's rt5616 node:

	rt5616: rt5616@1b {
		status = "okay";
		#sound-dai-cells = <0>;
		compatible = "rt5616";
		reg = <0x1b>;
		clocks = <&mclkout_i2s0>;
		clock-names = "mclk";
		assigned-clocks = <&mclkout_i2s0>;
		assigned-clock-rates = <12288000>;
		pinctrl-names = "default";
		pinctrl-0 = <&i2s0_mclk>;
	};

Versus this one:

	rt5616: audio-codec@1b {
		compatible = "realtek,rt5616";
		reg = <0x1b>;
		#sound-dai-cells = <0>;
	};

I'll try to test the 3.5mm headphones output, but that's pretty
low priority currently.

> - I didn't test mmc, hdmi, db, gpu, fan, npu raspi header...
> - Your regulators are not always following the naming in the schematic 
> very closely.
> 
> Dmesg also has some concerning boot logs:
> - Missing phy-supply for usbdp_phy1, combphy0_ps, combphy1_ps, 
> combphy2_psu, pcie30phy
> - Missing vmmc-supply and vqmmc-supply for sdhci
> - PCIE: pcie3x4 BAR 1 fails to assign (probably overlapping region due 
> to untested 1x1x1x1 bifurcation in rk3588.dtsi)
> - PCIE: a bunch of `bridge configuration invalid` during boot, no idea 
> whether they having something todo with your DTS though
> - Sensors: rockchip-thermal fec00000.tsadc fails initializing. 
> lm-sensors shows me no sensors at all. Maybe I'm just missing the driver?
> - `rockchip-drm display-subsystem` fails initializing
> 

At least some of your errors are because the features simply haven't
been upstreamed yet :)
For example the thermal sensors are still waiting for this patch series:
https://lore.kernel.org/linux-rockchip/20240506-rk-dts-additions-v4-0-271023ddfd40@gmail.com/

Thanks for your testing and feedback! I'll send a v3 soon. Feel free
to test this as well and if you like, send me a tested-by.

>> +        button-vol-up {
>> +            label = "Volume Up";
>> +            linux,code = <KEY_VOLUMEUP>;
> 
> I believe this should be `label = "Recovery"`, as it's printed like that 
> on the silk screen. Maybe also give it a generic function like BTN_1.

Yeah, many of the rk devices use "Volume Up", even though I'm sure
this likely is not the label on the board :D

> 
>> +            press-threshold-microvolt = <17000>;
>> +        };
>> +    };
> 
> While at it you could also add the button labeled "Mask", which is at 
> `io-channels = <&saradc 0>;`.

I didn't include this button since it's used to enter MASKROM mode
before booting (some hard-wired stuff iirc). It could be added, yes,
but I'm not sure if there's any use or if there's a best practice to
not include it in the DT.

>> +    vcc_3v3_host_32: regulator-vcc-3v3-host-32 {
>> +        compatible = "regulator-fixed";
>> +        enable-active-high;
>> +        gpios = <&gpio3 RK_PA5 GPIO_ACTIVE_HIGH>;
>> +        pinctrl-names = "default";
>> +        pinctrl-0 = <&vcc_3v3_host32_en>;
>> +        regulator-name = "vcc_3v3_host_32";
>> +        regulator-min-microvolt = <3300000>;
>> +        regulator-max-microvolt = <3300000>;
>> +        vin-supply = <&vcc_5v0_sys>;
>> +    };
> 
> I think this is a 5v0 regulator?

You are correect, thanks! I trusted FriendlyElec too much on getting
this right in their own devicetree.

Following this mistake, I was just checking if the u2phy devices have
the correct phy-supply, but it's giving me headache.

>> +
>> +        usb_con: connector {
>> +            compatible = "usb-c-connector";
>> +            data-role = "dual";
>> +            label = "USB-C";
>> +            op-sink-microwatt = <1000000>;
>> +            power-role = "dual";
> 
> Looking at the schematic, I don't think this is dual role power. I think 
> it's only a source. Have you tested this working in both directions?

I have not tested USB-C power delivery. But I also don't know exactly
how the schematic should look if it had PD in both directions.
Probably more complicated like on the NanoPi R6C. So if you're pretty
sure about this from reading the schematic, I'm removing it for v3.

>> +&pcie30phy {
> 
> Not really a review comment, but a note for others: ASPM implementation seems buggy. > Setting CONFIG_PCIEASPM_POWERSAVE to certain values breaks PCIe 
completely.

Yes! I can confirm that the kernel will hang when trying to access
a NVMe SSD with aspm powersave enabled. Thought it was just something
with my configurations. Thanks for confirming this issue!

>> +&u2phy0_otg {
> 
> Missing `phy-supply = <&vbus_5v0_typec>;`?

Yes, thanks.

>  > +    usb-role-switch;
> 
> Were you actually able to use the typec in gadget mode?
> I think this might only work in dr_mode = "host";

Not tested. Vendor devicetree has a dwc3 role switch, but I
don't think we can necessarily count on that being true :)

>> --- /dev/null
>> +++ b/arch/arm64/boot/dts/rockchip/rk3588-friendlyelec-cm3588.dtsi
> 
>> +        led_sys: led-0 {
>> +            color = <LED_COLOR_ID_AMBER>;
> 
> This one is LED_COLOR_ID_RED.

Comparing it side by side with a really red LED, it looks more
like amber (dark orange) to me. But it may also be just some kind
of red.

>> +
>> +        led_usr: led-1 {
>> +            color = <LED_COLOR_ID_AMBER>;
> 
> And this one is LED_COLOR_ID_GREEN.

True, copy-paste mistake. Thanks!


Cheers, Sebastian


