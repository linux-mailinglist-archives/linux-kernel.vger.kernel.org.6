Return-Path: <linux-kernel+bounces-192023-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A317E8D1761
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 11:40:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 286CBB227E4
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 09:40:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7BC616A394;
	Tue, 28 May 2024 09:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="CE5glure"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44E1D6E611;
	Tue, 28 May 2024 09:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716889209; cv=none; b=NRIK0mGsDtfntX8q+BUPJgpzPhAwVjBZFc3wgxQRsccz5oha3gVJ0LD8YBkgpi9PXRug9uygZj2ccHHak1KNdV2OFXMWO50h7qaKyXFufQAkfhY5ABZUbJYpUyA/ZQqOI8dX2NefU/eMa0ZiQ2pOFhby3YrkTa5ZIeHex3W5BbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716889209; c=relaxed/simple;
	bh=TC5V3F9ZuVvtFPXf6ACqcNweTub3Lwd52asO1a1UoWI=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=bqBJMYmkX0gyL8qFVPs70QLadnG34mjo3QpFUo4JA/hufaxd9Wue4wfrCvYImHDDfCHKDhyVaU6Tv3g0ZiR5cOQmkOD1QhW7NrIZRwyEnwVI6qDnWpNErOAYW5MBhUP+SvpOm5InnhX5/LpSGRft8w0v7V5E05V2gg6ui8vQMFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=CE5glure; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 44S9e0tb013299;
	Tue, 28 May 2024 04:40:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1716889200;
	bh=ffxmxMG+plf/1ZptXJEfrRGp9f0KMBSj+wG8qJ6NP8M=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=CE5glurekB0Pi//B0GHf5vvh3VmbnquPp+H1ycVrW4tdxkrgcrUZIzre2llHbtNdf
	 ZKs7WMty0eMQDAYVYRgFxmPPkkUi3sJou6CjwBicM4adtnJEDdliXa5Nq/Z0CeQqIw
	 hdFK+g0E3PvgTBKFemqmWC6AoYopVOgCEtlA68fQ=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 44S9e05M014383
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 28 May 2024 04:40:00 -0500
Received: from DLEE106.ent.ti.com (157.170.170.36) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 28
 May 2024 04:39:59 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 28 May 2024 04:39:59 -0500
Received: from [10.24.68.216] (a0498981-hp-z2-tower-g5-workstation.dhcp.ti.com [10.24.68.216])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 44S9dt3X041012;
	Tue, 28 May 2024 04:39:56 -0500
Message-ID: <b95d49e8-72f3-46e9-b9e4-197fe542c6f9@ti.com>
Date: Tue, 28 May 2024 15:09:55 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: dts: ti: k3-j722s-evm: Enable main_uart5
Content-Language: en-US
To: <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
CC: <linux-arm-kernel@lists.infradead.org>, <conor+dt@kernel.org>,
        <krzk+dt@kernel.org>, <robh@kernel.org>, <kristo@kernel.org>,
        <vigneshr@ti.com>, <nm@ti.com>
References: <20240528093911.47786-1-b-kapoor@ti.com>
From: Bhavya Kapoor <b-kapoor@ti.com>
In-Reply-To: <20240528093911.47786-1-b-kapoor@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180


On 28/05/24 3:09 pm, Bhavya Kapoor wrote:
> main_uart5 node defined in the SoC dtsi file is incomplete
> and will not be functional unless it is extended with pinmux
> information at board integration level.
>
> Thus, add pinmux for main_uart5 in the board dts file and
> enable it to make it functional.
>
> Signed-off-by: Bhavya Kapoor <b-kapoor@ti.com>
> ---
rebased to next-20240528
>   arch/arm64/boot/dts/ti/k3-j722s-evm.dts | 16 ++++++++++++++++
>   1 file changed, 16 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/ti/k3-j722s-evm.dts b/arch/arm64/boot/dts/ti/k3-j722s-evm.dts
> index bf3c246d13d1..e3892a6f2fab 100644
> --- a/arch/arm64/boot/dts/ti/k3-j722s-evm.dts
> +++ b/arch/arm64/boot/dts/ti/k3-j722s-evm.dts
> @@ -18,6 +18,7 @@ / {
>   	aliases {
>   		serial0 = &wkup_uart0;
>   		serial2 = &main_uart0;
> +		serial3 = &main_uart5;
>   		mmc0 = &sdhci0;
>   		mmc1 = &sdhci1;
>   	};
> @@ -142,6 +143,14 @@ J722S_IOPAD(0x01cc, PIN_OUTPUT, 0)	/* (B22) UART0_TXD */
>   		bootph-all;
>   	};
>   
> +	main_uart5_pins_default: main-uart5-default-pins {
> +		pinctrl-single,pins = <
> +			J722S_IOPAD(0x0108, PIN_INPUT, 3)	/* (J27) UART5_RXD */
> +			J722S_IOPAD(0x010c, PIN_OUTPUT, 3)	/* (H27) UART5_TXD */
> +		>;
> +		bootph-all;
> +	};
> +
>   	vdd_sd_dv_pins_default: vdd-sd-dv-default-pins {
>   		pinctrl-single,pins = <
>   			J722S_IOPAD(0x0120, PIN_INPUT, 7) /* (F27) MMC2_CMD.GPIO0_70 */
> @@ -240,6 +249,13 @@ &main_uart0 {
>   	bootph-all;
>   };
>   
> +&main_uart5 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&main_uart5_pins_default>;
> +	status = "okay";
> +	bootph-all;
> +};
> +
>   &mcu_pmx0 {
>   
>   	wkup_uart0_pins_default: wkup-uart0-default-pins {

