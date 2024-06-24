Return-Path: <linux-kernel+bounces-226795-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 121119143EA
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 09:53:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3CB991C2148C
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 07:53:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14872482C3;
	Mon, 24 Jun 2024 07:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="FD/vzg7p"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02C42182B3;
	Mon, 24 Jun 2024 07:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719215613; cv=none; b=UYtBIIrRWHQaNTjoTHtPKbI9rRGUXiB470WP9zppBF6/+JyVhfYq5xC0YTG+BHvGV4/VOWGYofleloyyg1Oat1ctOX4WWZucmpqJBPwy3cWsEZrebBn2ciXIugaRpyxRgz23IPv66+jgT5liPQ2fYJ+fGg/2L7eZtmcB8UjDGd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719215613; c=relaxed/simple;
	bh=x3GBVzJ/RPohlPjqsrJ6KKqzzBmwZLadTTs+X7ZDQNE=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=XYrxaA1F0IdtQHmeIaV6XR9p55puCs/lUdRbhLjxBjy+xJfy8qFhalCRNZrq4wSalxkkMu5kpTiv4gwLBrKfX9HRTI1YqTPvv9eHvjEz/2qHlj7/HhqTbhiSp1We3KlH620hD+t0w8e12rRnGdbc2BfA79bylT3z8hedBjcbMws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=FD/vzg7p; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 45O7qrVu114300;
	Mon, 24 Jun 2024 02:52:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1719215573;
	bh=gsArZAa7Q0RkeUisnnQPeD2LnH4EPHMGxZie8uBT0j8=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=FD/vzg7pkTjErO9m56DTLlAAPm5hFPAoNom1VjU9cOLi4tpTVOPA3FgCvSRq6Gmn5
	 zytGCORC5AAYnvWOL5HZrFnJ6x9J0MpPsdoVm+ECJ+wdgcXYyvmUbXmIvXV/C7gWHs
	 vw2cx8XAp9bhJ0WkQbKKaFSoWNxtE3Qwj1AJ1oe4=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 45O7qr4m013751
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 24 Jun 2024 02:52:53 -0500
Received: from DFLE113.ent.ti.com (10.64.6.34) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 24
 Jun 2024 02:52:53 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 24 Jun 2024 02:52:53 -0500
Received: from [172.24.227.55] (jayesh-hp-probook-440-g8-notebook-pc.dhcp.ti.com [172.24.227.55])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 45O7qnqg019243;
	Mon, 24 Jun 2024 02:52:50 -0500
Message-ID: <22f4b2ac-cf38-494b-84e4-0d09b545b303@ti.com>
Date: Mon, 24 Jun 2024 13:22:49 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] arm64: dts: ti: k3-j784s4-evm: Enable analog audio
 support
To: Vignesh Raghavendra <vigneshr@ti.com>, <linux-kernel@vger.kernel.org>,
        <nm@ti.com>, <j-luthra@ti.com>
CC: <kristo@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <u-kumar1@ti.com>
References: <20240619095253.290552-1-j-choudhary@ti.com>
 <20240619095253.290552-4-j-choudhary@ti.com>
 <6b13bb6a-4378-4764-9a60-d25ee2914176@ti.com>
Content-Language: en-US
From: Jayesh Choudhary <j-choudhary@ti.com>
In-Reply-To: <6b13bb6a-4378-4764-9a60-d25ee2914176@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Hello Vignesh,

On 22/06/24 12:14, Vignesh Raghavendra wrote:
> 
> 
> On 19/06/24 15:22, Jayesh Choudhary wrote:
>> &wkup_pmx2 {
>> @@ -881,6 +917,14 @@ exp1: gpio@20 {
>>   				  "PCIE0_4L_RC_RSTZ", "PCIE0_4L_EP_RST_EN", "PCIE1_4L_PRSNT#",
>>   				  "PCIE0_4L_PRSNT#", "CDCI1_OE1/OE4", "CDCI1_OE2/OE3",
>>   				  "AUDIO_MUX_SEL", "EXP_MUX2", "EXP_MUX3", "GESI_EXP_PHY_RSTZ";
>> +
>> +		p12-hog {
>> +			/* P12 - AUDIO_MUX_SEL */
>> +			gpio-hog;
>> +			gpios = <12 GPIO_ACTIVE_HIGH>;
>> +			output-low;
>> +			line-name = "AUDIO_MUX_SEL";
>> +		};
>>   	};
>>   
>>   	exp2: gpio@22 {
>> @@ -896,6 +940,22 @@ exp2: gpio@22 {
>>   				  "CANUART_MUX1_SEL1", "ENET1_EXP_PWRDN", "ENET1_EXP_RESETZ",
>>   				  "ENET1_I2CMUX_SEL", "ENET1_EXP_SPARE2", "ENET2_EXP_RESETZ",
>>   				  "USER_INPUT1", "USER_LED1", "USER_LED2";
>> +
>> +		p13-hog {
>> +			/* P13 - CANUART_MUX_SEL0 */
>> +			gpio-hog;
>> +			gpios = <13 GPIO_ACTIVE_HIGH>;
>> +			output-high;
>> +			line-name = "CANUART_MUX_SEL0";
>> +		};
>> +
>> +		p15-hog {
>> +			/* P15 - CANUART_MUX1_SEL1 */
>> +			gpio-hog;
>> +			gpios = <15 GPIO_ACTIVE_HIGH>;
>> +			output-high;
>> +			line-name = "CANUART_MUX1_SEL1";
>> +		};
>>   	};
>>   };
> 
> 
> Does this break CAN instances already enabled in the dts? If you
> consider making this a overlay as defaults seem to be set for CAN
> 

This does not break CAN.
The only issue was with p14-hog that was being used by can-3 instance
as mux-gpio and hogging it here was making the resource busy for can.
That I have handled with the idle-state in the gpio mux itself.

Thanks,
Jayesh


