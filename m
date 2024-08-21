Return-Path: <linux-kernel+bounces-295347-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 456929599EC
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 13:31:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 790361C22506
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 11:31:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5C92214118;
	Wed, 21 Aug 2024 10:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="jMNnDyR+"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FF191CFEB0;
	Wed, 21 Aug 2024 10:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724236507; cv=none; b=tOoATpPEqMS16cU38eKDhtZfwCkKexa9zXrnhRJrX7MMqMI0hVLgcaeoOj/SKfep001DQDf6t5bJHOTQHLMWE15STKsLPro5OBh+eK+9t2GahaknrHawVU3RMjk/YA+pm+JzqWon1YjUjidU5RAPoS9h8eGi4sL+wItPSzS6kZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724236507; c=relaxed/simple;
	bh=K7DOkzi42xq+HfVhnqi1tr84srJCsiSwGy56mcaoQmA=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=a4Z/BLDiMo632FqKnOIgjR82nHa5074ZN2xsXDWpF4Bdf0Bvo4zf2mFikaIjRIKBlrQ3B1v1Fs9nZVN7LgB9ugMa6MNdsM4oJ21A7e41iq4HWH4QECby9OD6Api/8YqVngdIdwT30h1rD6EKLweieo2kLJPBMtgxOPjXpdsBeYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=jMNnDyR+; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 47LAYvUM025012;
	Wed, 21 Aug 2024 05:34:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1724236497;
	bh=WQbzw7eazD9kb56WLpgM8B4dO+PwjPnIebRPwp8yits=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=jMNnDyR+/8ATyAAig+1X8pMvxt1NehfEw1qLHmfK3qOx/HkqSiKlA4EcvsQJV5X2O
	 Vi+6Bv8/Vt5Njh5AnFUxK2fkrQ8eIAUjgG+8e6GwCtP4oiQ55sDJw90lMp9EA2NUsN
	 sIsOJKw7FEsCzyli89XtCFCUc9mBwWxjmH8RDTFY=
Received: from DLEE102.ent.ti.com (dlee102.ent.ti.com [157.170.170.32])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 47LAYvZq062865
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 21 Aug 2024 05:34:57 -0500
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 21
 Aug 2024 05:34:57 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 21 Aug 2024 05:34:57 -0500
Received: from [172.24.156.234] (lt5cd2489kgj.dhcp.ti.com [172.24.156.234])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 47LAYq9W111813;
	Wed, 21 Aug 2024 05:34:52 -0500
Message-ID: <654c509d-492e-44f0-8b87-6b5e3d88340f@ti.com>
Date: Wed, 21 Aug 2024 16:04:51 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/5] arm64: dts: ti: k3-am68*: Add bootph-* properties
To: Manorit Chawdhry <m-chawdhry@ti.com>, Nishanth Menon <nm@ti.com>,
        Vignesh
 Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>, Rob Herring
	<robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
	<conor+dt@kernel.org>
CC: <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Neha Malcom Francis <n-francis@ti.com>,
        Aniket Limaye <a-limaye@ti.com>, Beleswar Padhi <b-padhi@ti.com>,
        Siddharth
 Vadapalli <s-vadapalli@ti.com>, Andrew Davis <afd@ti.com>
References: <20240814-b4-upstream-bootph-all-v4-0-f2b462000f25@ti.com>
 <20240814-b4-upstream-bootph-all-v4-3-f2b462000f25@ti.com>
Content-Language: en-US
From: "Kumar, Udit" <u-kumar1@ti.com>
In-Reply-To: <20240814-b4-upstream-bootph-all-v4-3-f2b462000f25@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180


On 8/14/2024 1:17 PM, Manorit Chawdhry wrote:
> Adds bootph-* properties to the leaf nodes to enable bootloaders to
> utilise them.
>
> Signed-off-by: Manorit Chawdhry <m-chawdhry@ti.com>
> ---
>   arch/arm64/boot/dts/ti/k3-am68-sk-base-board.dts | 11 +++++++++++
>   arch/arm64/boot/dts/ti/k3-am68-sk-som.dtsi       |  5 +++--
>   2 files changed, 14 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm64/boot/dts/ti/k3-am68-sk-base-board.dts b/arch/arm64/boot/dts/ti/k3-am68-sk-base-board.dts
> index 90dbe31c5b81..e7dd31b49081 100644
> --- a/arch/arm64/boot/dts/ti/k3-am68-sk-base-board.dts
> +++ b/arch/arm64/boot/dts/ti/k3-am68-sk-base-board.dts
> @@ -184,6 +184,7 @@ main_uart8_pins_default: main-uart8-default-pins {
>   			J721S2_IOPAD(0x0d0, PIN_INPUT, 11) /* (AF26) SPI0_CS1.UART8_RXD */
>   			J721S2_IOPAD(0x0d4, PIN_OUTPUT, 11) /* (AH27) SPI0_CLK.UART8_TXD */
>   		>;
> +		bootph-all;
>   	};


Reviewed-by: Udit Kumar <u-kumar1@ti.com>

>   
>   	main_i2c0_pins_default: main-i2c0-default-pins {
> @@ -210,6 +211,7 @@ J721S2_IOPAD(0x0f4, PIN_INPUT, 0) /* (R24) MMC1_DAT2 */
>   			J721S2_IOPAD(0x0f0, PIN_INPUT, 0) /* (R22) MMC1_DAT3 */
>   			J721S2_IOPAD(0x0e8, PIN_INPUT, 8) /* (AE25) TIMER_IO0.MMC1_SDCD */
>   		>;
> [..]

