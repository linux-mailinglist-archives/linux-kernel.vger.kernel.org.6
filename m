Return-Path: <linux-kernel+bounces-363282-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BC1799BFFD
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 08:27:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 41EC9282A0F
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 06:27:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55F66142903;
	Mon, 14 Oct 2024 06:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="JkwQOnpa"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3A8E22318;
	Mon, 14 Oct 2024 06:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728887216; cv=none; b=aTCp7GFDV2AIyiutV6vT3ZYD9TgfIQIy6s4bwX2iMZNQ0BrwhLtpkVfOM5OJXdSVhGrQOmK+ElC6fN0TSR3oS4JYFNMqx/+jn1lGEFBxNo/kYsSnegOEloOIvdF77sTbuLn7GYyf0v0dqIGioE+Z8WmA6bzbWnrcF25xyLn6gmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728887216; c=relaxed/simple;
	bh=lDDOeepiuGsQX/EtDF5vWeo17THB0hN6NU6mTVBse8E=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=S4JW41gO9Wu5FSKiJhXkrujQp7XAuJ5TA/KLwO4WZoA+rzEh8yKmsEYrh/W5ZrQGYhr/TjNfHU1/PHIZ517c9KRNRjbxdxHbAzchHy64z9VfCauH/kJxF9kaRqirMX+WZ22nDUICH0vtV6xUhYrTawwVgboc6fzBXIktx+h4QFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=JkwQOnpa; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 49E6QYcA041705;
	Mon, 14 Oct 2024 01:26:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1728887194;
	bh=8aV72M3ehzjbixCrsDrkYe5AY4NB7A5bDvUINlh27eU=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=JkwQOnpao0GIVr9wbkLIX8PLhFZmGHT/Ktbd/URnJ+plQR4j3SNWji4FT+VjcLeBB
	 A0BbQjd+7f62YvJarlgZGYmfrzFdHPDIk0944tDsVppmVxvqPkTcu73Xa10YRU54CZ
	 5FKseHGxeuutJoiy8Rx+Jhjir2FnCC5wxf5dBXps=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 49E6QYec043367
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 14 Oct 2024 01:26:34 -0500
Received: from DLEE111.ent.ti.com (157.170.170.22) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 14
 Oct 2024 01:26:34 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 14 Oct 2024 01:26:34 -0500
Received: from [10.24.69.142] ([10.24.69.142])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 49E6QTrH048931;
	Mon, 14 Oct 2024 01:26:30 -0500
Message-ID: <d713c82a-2f78-471c-9f7e-6b42932e164f@ti.com>
Date: Mon, 14 Oct 2024 11:56:29 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] arm64: dts: ti: k3-j7200: Fix register map for main
 domain pmx
To: Aniket Limaye <a-limaye@ti.com>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <mranostay@ti.com>, <conor+dt@kernel.org>, <krzk+dt@kernel.org>,
        <robh@kernel.org>, <kristo@kernel.org>, <vigneshr@ti.com>, <nm@ti.com>
CC: <u-kumar1@ti.com>, Jared McArthur <j-mcarthur@ti.com>
References: <20240926102533.398139-1-a-limaye@ti.com>
Content-Language: en-US
From: Vaishnav Achath <vaishnav.a@ti.com>
In-Reply-To: <20240926102533.398139-1-a-limaye@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

Hi Aniket, Jared,


On 26/09/24 15:55, Aniket Limaye wrote:
> From: Jared McArthur <j-mcarthur@ti.com>
> 
> Commit 0d0a0b441346 ("arm64: dts: ti: k3-j7200: fix main pinmux
> range") split the main_pmx0 into two nodes: main_pmx0 and main_pmx1
> due to a non-addressable region, but incorrectly represented the
> ranges. As a result, the memory map for the pinctrl is incorrect. Fix
> this by introducing the correct ranges.
> 
> The ranges are taken from the J7200 TRM [1] (Table 5-695. CTRL_MMR0
> Registers).
> 
> Padconfig starting addresses and ranges:
> -  0 to 66: 0x11c000, 0x10c
> -       68: 0x11c110, 0x004
> - 71 to 73: 0x11c11c, 0x00c
> - 89 to 90: 0x11c164, 0x008
> 
> The datasheet [2] doesn't contain PADCONFIG63 (Table 6-106. Pin
> Multiplexing), but the pin is necessary for enabling the MMC1 CLKLP
> pad loopback and should be included in the pinmux register map.
> 
> Due to the change in pinmux node addresses, change the pinmux node for
> the USB0_DRVVBUS pin to main_pmx2. The offset has not changed since the
> new main_pmx2 node has the same base address and range as the original
> main_pmx1 node. All other pinmuxing done within J7200 dts or dtso files
> only uses main_pmx0 which has not changed.
> 
> [1] https://www.ti.com/lit/pdf/spruiu1
> [2] https://www.ti.com/lit/gpn/dra821u
> 
> Fixes: 0d0a0b441346 ("arm64: dts: ti: k3-j7200: fix main pinmux range")
> Signed-off-by: Aniket Limaye <a-limaye@ti.com>
> Signed-off-by: Jared McArthur <j-mcarthur@ti.com>

Thank you for the patch.

Reviewed-by: Vaishnav Achath <vaishnav.a@ti.com>

> ---
> Changes in v2:
> - Explains why PADCONFIG63 is included in the pinmux ranges when it
>    doesn't appear in the datasheet.
> 
> * Nishanth
> - Use cannonical links in commit msg for the TRM and Datasheet
> - Explains the reason for the offset not changing for the USB0_DRVVBUS
>    pin and why there are no changes to other pins.
> 
> - Link to v1: https://lore.kernel.org/all/20240829071208.2172825-1-a-limaye@ti.com/
> ---
>   .../dts/ti/k3-j7200-common-proc-board.dts     |  2 +-
>   arch/arm64/boot/dts/ti/k3-j7200-main.dtsi     | 22 +++++++++++++++++--
>   2 files changed, 21 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-j7200-common-proc-board.dts b/arch/arm64/boot/dts/ti/k3-j7200-common-proc-board.dts
> index 6593c5da82c06..df39f2b1ff6ba 100644
> --- a/arch/arm64/boot/dts/ti/k3-j7200-common-proc-board.dts
> +++ b/arch/arm64/boot/dts/ti/k3-j7200-common-proc-board.dts
> @@ -254,7 +254,7 @@ J721E_IOPAD(0x38, PIN_OUTPUT, 0) /* (Y21) MCAN3_TX */
>   	};
>   };
>   
> -&main_pmx1 {
> +&main_pmx2 {
>   	main_usbss0_pins_default: main-usbss0-default-pins {
>   		pinctrl-single,pins = <
>   			J721E_IOPAD(0x04, PIN_OUTPUT, 0) /* (T4) USB0_DRVVBUS */
> diff --git a/arch/arm64/boot/dts/ti/k3-j7200-main.dtsi b/arch/arm64/boot/dts/ti/k3-j7200-main.dtsi
> index 9386bf3ef9f68..41adfa64418d0 100644
> --- a/arch/arm64/boot/dts/ti/k3-j7200-main.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-j7200-main.dtsi
> @@ -426,10 +426,28 @@ main_pmx0: pinctrl@11c000 {
>   		pinctrl-single,function-mask = <0xffffffff>;
>   	};
>   
> -	main_pmx1: pinctrl@11c11c {
> +	main_pmx1: pinctrl@11c110 {
>   		compatible = "ti,j7200-padconf", "pinctrl-single";
>   		/* Proxy 0 addressing */
> -		reg = <0x00 0x11c11c 0x00 0xc>;
> +		reg = <0x00 0x11c110 0x00 0x004>;
> +		#pinctrl-cells = <1>;
> +		pinctrl-single,register-width = <32>;
> +		pinctrl-single,function-mask = <0xffffffff>;
> +	};
> +
> +	main_pmx2: pinctrl@11c11c {
> +		compatible = "ti,j7200-padconf", "pinctrl-single";
> +		/* Proxy 0 addressing */
> +		reg = <0x00 0x11c11c 0x00 0x00c>;
> +		#pinctrl-cells = <1>;
> +		pinctrl-single,register-width = <32>;
> +		pinctrl-single,function-mask = <0xffffffff>;
> +	};
> +
> +	main_pmx3: pinctrl@11c164 {
> +		compatible = "ti,j7200-padconf", "pinctrl-single";
> +		/* Proxy 0 addressing */
> +		reg = <0x00 0x11c164 0x00 0x008>;
>   		#pinctrl-cells = <1>;
>   		pinctrl-single,register-width = <32>;
>   		pinctrl-single,function-mask = <0xffffffff>;

