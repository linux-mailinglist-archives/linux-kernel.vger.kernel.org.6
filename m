Return-Path: <linux-kernel+bounces-225571-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0783913268
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jun 2024 08:45:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 294271C2178B
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jun 2024 06:45:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E24BE14B088;
	Sat, 22 Jun 2024 06:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="TlqdmYZE"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DE748BFD;
	Sat, 22 Jun 2024 06:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719038693; cv=none; b=XuimOQvT4WvSqcqZZnrNlwuAm81CypGvOMvdlE9NVJjStZdk/XxOi0gbAjdwYM4s1vaqM2XJEyu4Vyj75ACCdsy+hjYw/vHzaqxXOy/FPeQCT/cSW5b3YSNv4Mr558Ay6Jgus0XXuzwDPOW6MPEyHT7OVMUX4ilzY+sfS4oKbI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719038693; c=relaxed/simple;
	bh=UQb8Z+ujaHhhsuuhpwTwvPOB79Pihy/x2wORD1fIK6s=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=gxp+OZGrJBwwglt1l3WRH674dqzKygFIFOHficifHrcP+GyV+uKItbQvIh8eIayT+XW0XR4Os3Sg4bLO01eOihCkyLqkFIOqqF4DcnzNAWX2jrsTLKQqjaCBuv0+dp6UpZ8J2U60X2OTYh6BPm+iv6D6IJupkSnhR96knlq9f50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=TlqdmYZE; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 45M6iixB122438;
	Sat, 22 Jun 2024 01:44:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1719038684;
	bh=spi4GdNW9JTa5ptQraKQLzKCk03Loxxcxp8dMLIrZNY=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=TlqdmYZELih3Jw4nYUqKZiT9NRELaqTORRtOogiEfUsELJG+t7Px+FY7fWjegT/83
	 Weyiowdgs8C+eR12zY5sdQ44b0rfz/IbhUnuBA8oPuJTfIyCaZEs67OiQFFreY429J
	 rlZedS0YhachLmkNT5BLmfg2FiVW0YKhuAXQ0zI8=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 45M6iioF110193
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Sat, 22 Jun 2024 01:44:44 -0500
Received: from DFLE114.ent.ti.com (10.64.6.35) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Sat, 22
 Jun 2024 01:44:44 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Sat, 22 Jun 2024 01:44:44 -0500
Received: from [172.24.227.94] (uda0132425.dhcp.ti.com [172.24.227.94])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 45M6ieNS065637;
	Sat, 22 Jun 2024 01:44:41 -0500
Message-ID: <6b13bb6a-4378-4764-9a60-d25ee2914176@ti.com>
Date: Sat, 22 Jun 2024 12:14:39 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] arm64: dts: ti: k3-j784s4-evm: Enable analog audio
 support
To: Jayesh Choudhary <j-choudhary@ti.com>, <linux-kernel@vger.kernel.org>,
        <nm@ti.com>, <j-luthra@ti.com>
CC: <kristo@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <u-kumar1@ti.com>
References: <20240619095253.290552-1-j-choudhary@ti.com>
 <20240619095253.290552-4-j-choudhary@ti.com>
From: Vignesh Raghavendra <vigneshr@ti.com>
Content-Language: en-US
In-Reply-To: <20240619095253.290552-4-j-choudhary@ti.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180



On 19/06/24 15:22, Jayesh Choudhary wrote:
> &wkup_pmx2 {
> @@ -881,6 +917,14 @@ exp1: gpio@20 {
>  				  "PCIE0_4L_RC_RSTZ", "PCIE0_4L_EP_RST_EN", "PCIE1_4L_PRSNT#",
>  				  "PCIE0_4L_PRSNT#", "CDCI1_OE1/OE4", "CDCI1_OE2/OE3",
>  				  "AUDIO_MUX_SEL", "EXP_MUX2", "EXP_MUX3", "GESI_EXP_PHY_RSTZ";
> +
> +		p12-hog {
> +			/* P12 - AUDIO_MUX_SEL */
> +			gpio-hog;
> +			gpios = <12 GPIO_ACTIVE_HIGH>;
> +			output-low;
> +			line-name = "AUDIO_MUX_SEL";
> +		};
>  	};
>  
>  	exp2: gpio@22 {
> @@ -896,6 +940,22 @@ exp2: gpio@22 {
>  				  "CANUART_MUX1_SEL1", "ENET1_EXP_PWRDN", "ENET1_EXP_RESETZ",
>  				  "ENET1_I2CMUX_SEL", "ENET1_EXP_SPARE2", "ENET2_EXP_RESETZ",
>  				  "USER_INPUT1", "USER_LED1", "USER_LED2";
> +
> +		p13-hog {
> +			/* P13 - CANUART_MUX_SEL0 */
> +			gpio-hog;
> +			gpios = <13 GPIO_ACTIVE_HIGH>;
> +			output-high;
> +			line-name = "CANUART_MUX_SEL0";
> +		};
> +
> +		p15-hog {
> +			/* P15 - CANUART_MUX1_SEL1 */
> +			gpio-hog;
> +			gpios = <15 GPIO_ACTIVE_HIGH>;
> +			output-high;
> +			line-name = "CANUART_MUX1_SEL1";
> +		};
>  	};
>  };


Does this break CAN instances already enabled in the dts? If you
consider making this a overlay as defaults seem to be set for CAN

-- 
Regards
Vignesh

