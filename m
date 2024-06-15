Return-Path: <linux-kernel+bounces-215621-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A5118909504
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jun 2024 02:21:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 30BA928429F
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jun 2024 00:21:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C28F81FB4;
	Sat, 15 Jun 2024 00:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mail.de header.i=@mail.de header.b="aAv9BwjL"
Received: from shout11.mail.de (shout11.mail.de [62.201.172.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F373B1361;
	Sat, 15 Jun 2024 00:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.201.172.57
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718410859; cv=none; b=I3TaJJrUg4XeREG/mxmCUNgT7Sy/VZr2eVKRJZ79n+RPS+Tsd34pwR/9nxOKvUeqsXwQClZqTvDM2YH0CWOW/B6Sae/IlnOQV1tkisQqw3OI8IWt8NCWNRw04AMpyVdxcjbJbo4C9544Yb+BTpIQ9vx22GrNSnWxDWdd2JZSV+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718410859; c=relaxed/simple;
	bh=9+3UpvFvUL6e3xI+TeczZuFjYUk6rVLdYYrAycTppY0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WFt1BJgU0MfCu4CmjxQKX5u0N50+42lOnxLGhuBxWHiXkUvgVeZwWFehgesRbzgH0WUE59LHuL5KWeZt0GBoLxnuLSUz9IPX0DDtx0eE/pydXwRB4oEfKK+JlFMG+may7DuKleJ1hsmIM6qCo96fy6/HFotJbgZugkcCDbpkAR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mail.de; spf=pass smtp.mailfrom=mail.de; dkim=pass (2048-bit key) header.d=mail.de header.i=@mail.de header.b=aAv9BwjL; arc=none smtp.client-ip=62.201.172.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mail.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.de
Received: from shout02.mail.de (unknown [10.0.120.222])
	by shout11.mail.de (Postfix) with ESMTPS id 75BDB24192D;
	Sat, 15 Jun 2024 02:20:49 +0200 (CEST)
Received: from postfix01.mail.de (postfix01.bt.mail.de [10.0.121.125])
	by shout02.mail.de (Postfix) with ESMTP id 44D23240E5A;
	Sat, 15 Jun 2024 02:20:49 +0200 (CEST)
Received: from smtp01.mail.de (smtp03.bt.mail.de [10.0.121.213])
	by postfix01.mail.de (Postfix) with ESMTP id 20F57801BF;
	Sat, 15 Jun 2024 02:20:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mail.de;
	s=mailde202009; t=1718410849;
	bh=9+3UpvFvUL6e3xI+TeczZuFjYUk6rVLdYYrAycTppY0=;
	h=Message-ID:Date:Subject:To:Cc:From:From:To:CC:Subject:Reply-To;
	b=aAv9BwjLc6YnOm03QTpsTkVlUq3BMAOoGgdXP3HKvp1IRLkOcKkwlCTSeWgDbCRuQ
	 pnWaKo8c6CPf+719BzaBGrWGdeMIPEvnZ8x+94F1EUoNE6QaJouOBdDIR8x+Im1gdJ
	 WvwefICL+lo9G1xWnHkDahR+4rOAenxZEWxgabjyFAwkQVgFgmoE74nOnSjLy3eqst
	 PRuwo9E98nGz2xYm74Qi6k6b+u9yp/u+wZR042hBqHD7wkvxxm2NoJd+Ez49ugiQdc
	 lHnKcoL0M/4VnUCb8phTtoemWuaqFEKwzzoU5pgebQjD8WU+lDSMUmD5Z5eGosszAn
	 nnmxrvMhNG9rw==
Received: from [127.0.0.1] (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp01.mail.de (Postfix) with ESMTPSA id D551D240A6F;
	Sat, 15 Jun 2024 02:20:44 +0200 (CEST)
Message-ID: <1c702815-3f55-4f62-a743-2463f3141650@mail.de>
Date: Sat, 15 Jun 2024 02:20:43 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v3 2/2] arm64: dts: rockchip: Add FriendlyElec CM3588 NAS
 board
To: Tim Surber <me@timsurber.de>, Heiko Stuebner <heiko@sntech.de>,
 linux-rockchip@lists.infradead.org
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Sebastian Reichel <sebastian.reichel@collabora.com>,
 Jonas Karlman <jonas@kwiboo.se>, Space Meyer <me@the-space.agency>,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20240609222428.134977-1-seb-dev@mail.de>
 <20240609222428.134977-3-seb-dev@mail.de>
 <bea6657a-62bb-46a3-93be-4b8b4c68aed0@timsurber.de>
From: Sebastian Kropatsch <seb-dev@mail.de>
In-Reply-To: <bea6657a-62bb-46a3-93be-4b8b4c68aed0@timsurber.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-purgate: clean
X-purgate: This mail is considered clean (visit http://www.eleven.de for further information)
X-purgate-type: clean
X-purgate-Ad: Categorized by eleven eXpurgate (R) http://www.eleven.de
X-purgate: This mail is considered clean (visit http://www.eleven.de for further information)
X-purgate: clean
X-purgate-size: 3277
X-purgate-ID: 154282::1718410849-F3E201F9-4086A72E/0/0

Hi Tim,

Am 14.06.2024 um 04:00 schrieb Tim Surber:
> Hi Sebastian,
> 
> I propose the addition of "pwm-beeper" and "gpio-ir-receiver" to the 
> device tree, since they are permanently mounted on the baseboard.

Can you recommend a good way to test the IR receiver? I tried for
a while with evtest but could not see any output:

    evtest /dev/input/event2
    Input driver version is 1.0.1
    Input device ID: bus 0x19 vendor 0x1 product 0x1 version 0x100
    Input device name: "gpio_ir_recv"
    Supported events:
      Event type 0 (EV_SYN)
      Event type 1 (EV_KEY)
        Event code 152 (KEY_SCREENLOCK)
      Event type 2 (EV_REL)
        Event code 0 (REL_X)
        Event code 1 (REL_Y)
      Event type 4 (EV_MSC)
        Event code 4 (MSC_SCAN)
    Key repeat handling:
      Repeat type 20 (EV_REP)
        Repeat code 0 (REP_DELAY)
          Value    500
        Repeat code 1 (REP_PERIOD)
          Value    125
    Properties:
      Property type 5 (INPUT_PROP_POINTING_STICK)
    Testing ... (interrupt to exit)

I only have one TV remote to test, so I'm not even sure that this
is compatible, I haven't touched anything IR-related before.

Cheers,
Sebastian

> On 10.06.2024 00:20, Sebastian Kropatsch wrote:
>> The CM3588 NAS by FriendlyElec pairs the CM3588 compute module, based on
>> the Rockchip RK3588 SoC, with the CM3588 NAS Kit carrier board.
>> To reflect the hardware setup, add device tree sources for the SoM and
>> the NAS daughter board as separate files.
>>
>> Hardware features:
>>      - Rockchip RK3588 SoC
>>      - 4GB/8GB/16GB LPDDR4x RAM
>>      - 64GB eMMC
>>      - MicroSD card slot
>>      - 1x RTL8125B 2.5G Ethernet
>>      - 4x M.2 M-Key with PCIe 3.0 x1 (via bifurcation) for NVMe SSDs
>>      - 2x USB 3.0 (USB 3.1 Gen1) Type-A, 1x USB 2.0 Type-A
>>      - 1x USB 3.0 Type-C with DP AltMode support
>>      - 2x HDMI 2.1 out, 1x HDMI in
>>      - MIPI-CSI Connector, MIPI-DSI Connector
>>      - 40-pin GPIO header
>>      - 4 buttons: power, reset, recovery, MASK, user button
>>      - 3.5mm Headphone out, 2.0mm PH-2A Mic in
>>      - 5V Fan connector, PWM buzzer, IR receiver, RTC battery connector
>>
>> PCIe bifurcation is used to handle all four M.2 sockets at PCIe 3.0 x1
>> speed. Data lane mapping in the DT is done like described in commit
>> f8020dfb311d ("phy: rockchip-snps-pcie3: fix bifurcation on rk3588").
>>
>> This device tree includes support for eMMC, SD card, ethernet, all USB2
>> and USB3 ports, all four M.2 slots, GPU, RTC, buzzer, UART debugging as
>> well as the buttons and LEDs.
>> The GPIOs are labeled according to the schematics.
>>
>> Signed-off-by: Sebastian Kropatsch <seb-dev@mail.de>
>> ---
>>   arch/arm64/boot/dts/rockchip/Makefile         |   1 +
>>   .../rk3588-friendlyelec-cm3588-nas.dts        | 759 ++++++++++++++++++
>>   .../rockchip/rk3588-friendlyelec-cm3588.dtsi  | 655 +++++++++++++++
>>   3 files changed, 1415 insertions(+)
>>   create mode 100644 
>> arch/arm64/boot/dts/rockchip/rk3588-friendlyelec-cm3588-nas.dts
>>   create mode 100644 
>> arch/arm64/boot/dts/rockchip/rk3588-friendlyelec-cm3588.dtsi


