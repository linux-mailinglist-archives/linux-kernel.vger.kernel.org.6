Return-Path: <linux-kernel+bounces-211342-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B0EDE90504E
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 12:20:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4B697B2502B
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 10:20:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5194116EC1B;
	Wed, 12 Jun 2024 10:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="h46WvgPO"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 093D836B17;
	Wed, 12 Jun 2024 10:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718187600; cv=none; b=fqnqms5vD3fJFHqUb5XG8+V4Cg/+KzHcssu58E8Wp/EHs3asBXPGYz4vAyfIy+43NLdxI2hTbcmndf3L34nGmR6ODkkbqdNBW9uBusp2rBCcKsDXjxetvnKL/5CQhYwPGwtBKF1aWTnGaPRB8iAbLRRGO6uFyXrPuegZOfpMM/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718187600; c=relaxed/simple;
	bh=tQpnE6Jpl5o6xrViC34nVjTYYdfSKXAALIsMajYxG7Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=A7jDJLsfAXXjKYGBStwc9YcTbNh5LyIFCRB3MUZtUzFEH00yVtF8H8JHsAan4b941ekAIn78RBNPN6fJ6Gcn62LPPco9eH9A77B4oP3up0Tm+ZiAD/AXj9CH1by1wISsBnVUp7ZpoXcSmsKeCRpj5C8Wx4tT9ZUlLJZ8BW2iiBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=h46WvgPO; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 45CAJp7b015573;
	Wed, 12 Jun 2024 05:19:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1718187591;
	bh=JNs1l8+IwxXvd7kw039pXjFA0Ygz2v4ZLuzxy6QdndA=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=h46WvgPOzbM7OPScfHJMCzIUTtka7PIJD94JNQUECFxsfCP3hb1CyYvdMjCERN1OZ
	 ix+pFXgb1KX17tDRVM/ERvfJRIaDJV0jJHws1xRFUAYmfWiF+5z0xrjuNdK9mJou6j
	 S8TDhZ2xCzXCMf5GjMbrup1UL6sPzY3sRj3if8cE=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 45CAJpVj015825
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 12 Jun 2024 05:19:51 -0500
Received: from DLEE100.ent.ti.com (157.170.170.30) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 12
 Jun 2024 05:19:51 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 12 Jun 2024 05:19:51 -0500
Received: from [172.24.227.94] (uda0132425.dhcp.ti.com [172.24.227.94])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 45CAJlqU038726;
	Wed, 12 Jun 2024 05:19:48 -0500
Message-ID: <629a95ac-3f40-412f-b983-312f434bfb2f@ti.com>
Date: Wed, 12 Jun 2024 15:49:46 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/4] Add overlays to disable optional hardware in
 k3-am6xx-phycore-som boards
To: Nathan Morrisson <nmorrisson@phytec.com>, <nm@ti.com>, <kristo@kernel.org>,
        <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>
CC: <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <upstream@lists.phytec.de>,
        <w.egorov@phytec.de>
References: <20240528225137.3629698-1-nmorrisson@phytec.com>
 <4ac40139-eda0-4f6a-8bbe-99110605f91e@ti.com>
 <5a773641-73a6-416e-8c52-eccc136f11ef@phytec.com>
From: Vignesh Raghavendra <vigneshr@ti.com>
Content-Language: en-US
In-Reply-To: <5a773641-73a6-416e-8c52-eccc136f11ef@phytec.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180



On 05/06/24 04:45, Nathan Morrisson wrote:
> Hi Vignesh,
> 
> On 6/3/24 10:41 AM, Vignesh Raghavendra wrote:
>> Hi Nathan,
>>
>> On 29/05/24 04:21, Nathan Morrisson wrote:
>>> Add three overlays to disable the eth phy, rtc, and spi nor. These
>>> overlays will be used to disable device tree nodes for components
>>> that are optionally not populated.
>>>
>>> v2:
>>>    - Add build time tests in makefile
>>>
>>> Nathan Morrisson (4):
>>>    arm64: dts: ti: k3-am64-phycore-som: Add serial_flash label
>>
>>>    arm64: dts: ti: k3-am6xx-phycore-som: Add overlay to disable eth phy
>>>    arm64: dts: ti: k3-am6xx-phycore-som: Add overlay to disable rtc
>>>    arm64: dts: ti: k3-am6xx-phycore-som: Add overlay to disabl spi nor
>>>
>>>   arch/arm64/boot/dts/ti/Makefile               | 17 +++++++++++++++++
>>>   .../boot/dts/ti/k3-am64-phycore-som.dtsi      |  2 +-
>>>   .../ti/k3-am6xx-phycore-disable-eth-phy.dtso  | 19 +++++++++++++++++++
>>>   .../dts/ti/k3-am6xx-phycore-disable-rtc.dtso  | 15 +++++++++++++++
>>>   .../ti/k3-am6xx-phycore-disable-spi-nor.dtso  | 15 +++++++++++++++
>>>   5 files changed, 67 insertions(+), 1 deletion(-)
>>>   create mode 100644
>>> arch/arm64/boot/dts/ti/k3-am6xx-phycore-disable-eth-phy.dtso
>>>   create mode 100644
>>> arch/arm64/boot/dts/ti/k3-am6xx-phycore-disable-rtc.dtso
>>>   create mode 100644
>>> arch/arm64/boot/dts/ti/k3-am6xx-phycore-disable-spi-nor.dtso
>>>
>> I am not sure if this a common practice to have overlays to disable
>> missing components (at least I dont see such dtso in kernel). I would
>> like to see an what DT maintainers feel as such dtsos can explode in
>> numbers.
>>
>> Is this something that U-Boot can detect and fix up for the Linux DT?

> We have an EEPROM on our board with information on what is populated on     
> that particular board. We will apply these overlays based on that EEPROM
> data.

Typical usage of overlay is to keep the minimum in baseboard and enable
optional components in the overlay. But it would also depend on whats
information is present in the EEPROM.

Could you provide bit more color on whats in EEPROM and how each overlay
would be applied? Please add the same to commit message and respin.

>>
>> Unpopulated SPI flash and RTC should ideally not be an issue as drivers
>> would gracefully fail albeit with some sort of error msg.
>> Not so sure about Eth PHYs though.
>>
>> Also, Are these dtso's mutually exclusive? ie can SoM have SPI flash but
>> not RTC, have RTC and SPI Flash but no ETH PHY?
> 
> They are not mutually exclusive, you could have any combination of
> overlays applied.
> 
> 
> Regards,
> 
> Nathan
> 
>>

-- 
Regards
Vignesh

