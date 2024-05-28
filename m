Return-Path: <linux-kernel+bounces-192148-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 181FC8D1920
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 13:08:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 49BEC1C22948
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 11:08:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AF2A16C45C;
	Tue, 28 May 2024 11:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="uZByvk75"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78F2C13E3F6;
	Tue, 28 May 2024 11:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716894515; cv=none; b=VHOeX7h5nRAeguMteqldCYz685A8iEIxJnQeRFx2GMog83dKHSS/xU6r3kA4yNQ6HmDDi/yYj7p5WmjIcnnsajfEhkd86YCzPQ6N/e+6F59461JeGFDv8d2828ARrQ3pE4PCZdhnhEMSFqAM3mgeBh55A93P8ff32R51ev0w3DY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716894515; c=relaxed/simple;
	bh=6pQ48s/ZXPuwRrmYhWeA5YildQBgCa5Lulh90LEteHk=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=IzMEHaWnWnz9rwDg5hqeVyWLiAm22D/X45iCdbe1rg71qaOJaJjJCBL3c6abC8/lmIPiXoMqDfd1f+O9e6JVFx1QYC4zwHf2kzeerN+mMtkZFqT1kQmR0EB3ap9eSPF7uwbSnKbVDRyaMxffehU1/5KemXFtygG95u9G85E0tYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=uZByvk75; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 44SB8MLa042098;
	Tue, 28 May 2024 06:08:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1716894502;
	bh=3I2KuQ/zJ4n3DrpkbGo1uDhZ7yKlLjDJekmhpjEg2kk=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=uZByvk75iVVakkTNJgg65Ha5X3D5YdBeTd2OPaf0yPksX6a3ktrNL3LDkVQkrpn90
	 5QzCOlH+yVWKZv1I/Ir4tRbwyF2cA1vbW9Sm04f48+EN1xkZU2AUwNNfDE/JCufanB
	 GOySkwDmy8Xi0nftr67PbUycbZUWsqnHjQxF86sA=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 44SB8MJQ009091
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 28 May 2024 06:08:22 -0500
Received: from DFLE102.ent.ti.com (10.64.6.23) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 28
 May 2024 06:08:22 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 28 May 2024 06:08:22 -0500
Received: from [10.24.68.216] (a0498981-hp-z2-tower-g5-workstation.dhcp.ti.com [10.24.68.216])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 44SB8IOP044466;
	Tue, 28 May 2024 06:08:19 -0500
Message-ID: <27a350e5-b3e0-427d-8897-89e1d34a4c00@ti.com>
Date: Tue, 28 May 2024 16:38:18 +0530
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
        <vigneshr@ti.com>, <nm@ti.com>, Bhavya Kapoor <b-kapoor@ti.com>
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
Test Logs: https://gist.github.com/a0498981/dc8b0cb670a5726eeb6c10f6de1f468e
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

