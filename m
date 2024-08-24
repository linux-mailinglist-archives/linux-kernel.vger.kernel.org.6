Return-Path: <linux-kernel+bounces-300151-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 909BA95DF82
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Aug 2024 20:14:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 429C61F21B2A
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Aug 2024 18:14:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28C9759164;
	Sat, 24 Aug 2024 18:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="wjxDyzaT"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EA8114A85;
	Sat, 24 Aug 2024 18:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724523282; cv=none; b=G3GuWtiCuDD4deFm5cVQWhvOWkJd6wNkkUiTSoffZ2EIBLP0Zam0YwNn+sTZtSCColn5Mg0QSYNi5sqTtSNGCTO0gppnIFIk+FlHViblqytcvib2cHbYCZjhOoe4EosI+IPSuBlDccnNQQOW/39Atdx1Ivfov2iviDhJsWPJqsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724523282; c=relaxed/simple;
	bh=In1+zwWn3VrjnjsaMZoAxKnAaIi/2fDgduIA/Xb8wLU=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ApWE7+/Wo6ThkJRuJcbr3zFzZmP7AmTI7IMjKYyh4sHzP5G9JoBwAplfJ5vkFwJs1Gpu5KkCgwoZmVdQBVPj63kJgyV4Sabcuwq95XFmCvryjuK64iLuuwob6pWNKewdMz+mCdvDkAuqpZ/oAZP9eYqh894+O3GYm/54S+Dq5BM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=wjxDyzaT; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 47OIEZVb045319;
	Sat, 24 Aug 2024 13:14:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1724523275;
	bh=J4K23o+SI+8AX8CHrJnoadjI1f+AoslCwAkrQY97kdA=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=wjxDyzaTbQOQkZQaLhMml3ewDlPEZlyeo/7/ZaAecXNP5ICApF6xW+vVVky+ssrwr
	 ZuyBtANraXv8fnHh2+IYeVNy/0n68mqct2OhzEFqqS9zog7z9rQ++xTQaVOYDySLW5
	 Vcn/J/z7a0co40+1oKf/jT0j02GAwvQS+oEcHd5g=
Received: from DFLE108.ent.ti.com (dfle108.ent.ti.com [10.64.6.29])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 47OIEZQX126815
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Sat, 24 Aug 2024 13:14:35 -0500
Received: from DFLE105.ent.ti.com (10.64.6.26) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Sat, 24
 Aug 2024 13:14:34 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Sat, 24 Aug 2024 13:14:34 -0500
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 47OIEYHu058559;
	Sat, 24 Aug 2024 13:14:34 -0500
Date: Sat, 24 Aug 2024 13:14:34 -0500
From: Nishanth Menon <nm@ti.com>
To: Bhavya Kapoor <b-kapoor@ti.com>
CC: <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <vigneshr@ti.com>, <kristo@kernel.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH] arm64: dts: ti: k3-j722s-evm: Describe main_uart5
Message-ID: <20240824181434.53m2ik3ozvc74pjf@dormitory>
References: <20240822053538.10475-1-b-kapoor@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240822053538.10475-1-b-kapoor@ti.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

On 11:05-20240822, Bhavya Kapoor wrote:
> main_uart5 in J722S platform is used by the firmware. Thus,
what platform? what firmware?

> describe it for completeness, adding the pinmux and mark
> it as reserved.
> 
> Signed-off-by: Bhavya Kapoor <b-kapoor@ti.com>
> ---
>  arch/arm64/boot/dts/ti/k3-j722s-evm.dts | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-j722s-evm.dts b/arch/arm64/boot/dts/ti/k3-j722s-evm.dts
> index 24e9f2ea509b..5addf1c0afc2 100644
> --- a/arch/arm64/boot/dts/ti/k3-j722s-evm.dts
> +++ b/arch/arm64/boot/dts/ti/k3-j722s-evm.dts
> @@ -20,6 +20,7 @@ / {
>  	aliases {
>  		serial0 = &wkup_uart0;
>  		serial2 = &main_uart0;
> +		serial3 = &main_uart5;
>  		mmc0 = &sdhci0;
>  		mmc1 = &sdhci1;
>  	};
> @@ -211,6 +212,13 @@ J722S_IOPAD(0x01cc, PIN_OUTPUT, 0)	/* (B22) UART0_TXD */
>  		bootph-all;
>  	};
>  
> +	main_uart5_pins_default: main-uart5-default-pins {
> +		pinctrl-single,pins = <
> +			J722S_IOPAD(0x0108, PIN_INPUT, 3)       /* (J27) UART5_RXD */
> +			J722S_IOPAD(0x010c, PIN_OUTPUT, 3)      /* (H27) UART5_TXD */
> +		>;
> +	};
> +
>  	vdd_sd_dv_pins_default: vdd-sd-dv-default-pins {
>  		pinctrl-single,pins = <
>  			J722S_IOPAD(0x0120, PIN_INPUT, 7) /* (F27) MMC2_CMD.GPIO0_70 */
> @@ -330,6 +338,12 @@ &main_uart0 {
>  	bootph-all;
>  };
>  
> +&main_uart5 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&main_uart5_pins_default>;

Document specifically why reserved.

> +	status = "reserved";
> +};
> +
>  &mcu_pmx0 {
>  
>  	mcu_mcan0_pins_default: mcu-mcan0-default-pins {
> -- 
> 2.34.1
> 

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D

