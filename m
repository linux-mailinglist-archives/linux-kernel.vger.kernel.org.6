Return-Path: <linux-kernel+bounces-399637-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7EB59C0206
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 11:14:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 631FDB2279E
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 10:14:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9560B1EBFE3;
	Thu,  7 Nov 2024 10:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="OaQU6j6S"
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF4FF1E909C;
	Thu,  7 Nov 2024 10:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730974471; cv=none; b=f80WpH00tgevIQ6aZtA2qeSDkh3gx7hn6ifUWuDKlnlTFtJIyNC6ISt2apNXyh9SYa1cyKUiEA2EijGuV0hHkKw93YXqUibakhHq01fOJttJtiO1gHYkEcZnqozh0QH7AuCTMsTAR2h4XWz69WuAzx6UDwc8KgomkRVpUGu09M4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730974471; c=relaxed/simple;
	bh=ATL7M1Loql/H/FRX3t4w/EVdlm8l7Pns6lcCMDqmGZA=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TNCycED6dpZ5gYF4GaFKlsqGCj9M4B1ieQdnOxhBRGq5AJjpuQcENlbA4GvfMEkoLTximtiDiwEOqTYw6/HqKqoLyVzTwOI4fPpL88uGC39jp6p0H4SRrZyal4bTTtGsGYSp1wiQPrPzkGc2LN/QAF2y674OTEumvPQsTKUbFyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=OaQU6j6S; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4A7AE9W4007164;
	Thu, 7 Nov 2024 04:14:09 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1730974449;
	bh=aAHPUbNs7M6QgxqG12AlzIrLLtSFknGoPRYn8hsW/Zw=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=OaQU6j6SxZvQsqeOTwkdonkxFSNlzp2aNOpoUBETx19mczhRBENskfTOQwQwzkJf3
	 eJ5s1A3cAQl4HnuXJO43ks7DkRxRouVydG5hpdoS5b0J9mU3TSKJFx5lkCPDZ6DVnY
	 X2RiH1Y5B4PQzpdASA03OC8fF9I3Rnkv7z0MXHa8=
Received: from DLEE106.ent.ti.com (dlee106.ent.ti.com [157.170.170.36])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4A7AE9p3104642
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 7 Nov 2024 04:14:09 -0600
Received: from DLEE110.ent.ti.com (157.170.170.21) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 7
 Nov 2024 04:14:08 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 7 Nov 2024 04:14:08 -0600
Received: from localhost (prasanth-server.dhcp.ti.com [172.24.227.197])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4A7AE7rb006059;
	Thu, 7 Nov 2024 04:14:07 -0600
Date: Thu, 7 Nov 2024 15:44:06 +0530
From: Prasanth Mantena <p-mantena@ti.com>
To: Bhavya Kapoor <b-kapoor@ti.com>
CC: <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>, <nm@ti.com>,
        <vigneshr@ti.com>, <kristo@kernel.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <u-kumar1@ti.com>,
        <s-sinha@ti.com>
Subject: Re: [PATCH] arm64: dts: ti: k3-j722s-evm: Enable support for mcu_i2c0
Message-ID: <20241107101406.6bj4xbiguzuwt5db@prasanth-server>
References: <20241105091224.23453-1-b-kapoor@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20241105091224.23453-1-b-kapoor@ti.com>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

On 14:42, Bhavya Kapoor wrote:
> Enable support for mcu_i2c0 and add pinmux required to bring out the
> mcu_i2c0 signals on 40-pin RPi expansion header on the J722S EVM.
> 
> Signed-off-by: Bhavya Kapoor <b-kapoor@ti.com>
> Signed-off-by: Shreyash Sinha <s-sinha@ti.com>
> ---
>  arch/arm64/boot/dts/ti/k3-j722s-evm.dts | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-j722s-evm.dts b/arch/arm64/boot/dts/ti/k3-j722s-evm.dts
> index a00f4a7d20d9..796287c76b69 100644
> --- a/arch/arm64/boot/dts/ti/k3-j722s-evm.dts
> +++ b/arch/arm64/boot/dts/ti/k3-j722s-evm.dts
> @@ -406,6 +406,13 @@ &main_uart5 {
>  
>  &mcu_pmx0 {
>  
> +	mcu_i2c0_pins_default: mcu-i2c0-default-pins {
> +		pinctrl-single,pins = <
> +			J722S_MCU_IOPAD(0x048, PIN_INPUT, 0) /* (E11) MCU_I2C0_SDA */
> +			J722S_MCU_IOPAD(0x044, PIN_INPUT, 0) /* (B13) MCU_I2C0_SCL */
> +		>;
> +	};
> +
>  	mcu_mcan0_pins_default: mcu-mcan0-default-pins {
>  		pinctrl-single,pins = <
>  			J722S_MCU_IOPAD(0x038, PIN_INPUT, 0) /* (D8) MCU_MCAN0_RX */
> @@ -812,3 +819,10 @@ &main_mcan0 {
>  &mcu_gpio0 {
>  	status = "okay";
>  };
> +
> +&mcu_i2c0 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&mcu_i2c0_pins_default>;
> +	clock-frequency = <400000>;
> +	status = "okay";
> +};

Reviewed-by: Prasanth Babu Mantena <p-mantena@ti.com>

> -- 
> 2.34.1
> 
> 

