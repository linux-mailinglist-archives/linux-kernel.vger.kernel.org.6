Return-Path: <linux-kernel+bounces-339342-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AF89986476
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 18:07:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1FD7AB32AC4
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 15:30:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1390B1D5ACC;
	Wed, 25 Sep 2024 15:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="lMMTSp0j"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FE551F5F6;
	Wed, 25 Sep 2024 15:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727277901; cv=none; b=iQd1Spf00jZWxdPLKj2i1jvGdzSvCaXbaPqK9aCrJFkUU04GWQ5ndbFFKSZeDGTASUioeIIuth95zfuIIURcAeIGYIz4yfgClCOw2rdKQfKnjJOdZtL1CWmaHoJIN6PQYyHanER8rcreHY2tM6yg01NdN1rHHTkTSWipt8gDGrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727277901; c=relaxed/simple;
	bh=8UbC7Glv53C5Wh4gGajAzcDOxSrszEi7y/jg4Pu+9Uc=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=ceSCvc1W5BoITVkLa7xh9CQoO9wplwkVjGkc4g39Amp7GP0cC/x9zv2Upfw7uW+zXZJkgXnq6kVcUuNtulSSl+XcIEMnUUG5A39bm7s3TTnpPxNM3NN1e8pxcmAbRBDt/RLFSicCOd+bhtOaoNtJQNWBHCENZu7Mrc2Qgn4FkQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=lMMTSp0j; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1727277899; x=1758813899;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=8UbC7Glv53C5Wh4gGajAzcDOxSrszEi7y/jg4Pu+9Uc=;
  b=lMMTSp0jvkGSKtPUgwVt3hAk0vBRMg6FqMrzaV7wSUhawc5JDPW0hXUN
   5bGUllN/dEJpnmmBrZGPOxgRVujn06R9wuk26A342PHSZpl8f+d2d41rT
   3uKiX5Ljr13g6gdvpwDiAerCgQ3X1pTWhRZmK7YMlrffHFHxorl2mz8dX
   wcP2xyAel4T0gwenLSg+XCnqiaDTBRHqrm4Rwi9Osy9p+hc5xv76Lj75t
   PNcZkZ2pOnVgvcQF89Aq0YaI+h86ZvJH//AcxheR8mBz52lWcWHl+LAAE
   eGAwiHzjKe90CWwEKJQC6wxWMhwYbsSIzjIP5iKAhFQ7AyZGSHd/AZWwg
   w==;
X-CSE-ConnectionGUID: OOlwZxHRS2etYem7By+NLw==
X-CSE-MsgGUID: 0AFWp061Qqqb5rmbRepGNQ==
X-IronPort-AV: E=Sophos;i="6.10,257,1719903600"; 
   d="scan'208";a="32100963"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 25 Sep 2024 08:24:58 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 25 Sep 2024 08:24:28 -0700
Received: from [10.171.248.56] (10.10.85.11) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Wed, 25 Sep 2024 08:24:25 -0700
Message-ID: <da8ad5eb-355c-44c1-a060-76576bd419e9@microchip.com>
Date: Wed, 25 Sep 2024 17:24:41 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 09/12] clk: at91: sam9x60: Allow enabling main_rc_osc
 through DT
Content-Language: en-US, fr-FR
To: Ryan Wanner <ryan.wanner@microchip.com>, Claudiu Beznea
	<claudiu.beznea@tuxon.dev>, <ada@thorsis.com>
CC: Conor Dooley <conor+dt@kernel.org>, "moderated list:ARM/Microchip (AT91)
 SoC support" <linux-arm-kernel@lists.infradead.org>, Alexandre Belloni
	<alexandre.belloni@bootlin.com>, "open list:OPEN FIRMWARE AND FLATTENED
 DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, "open list:COMMON CLK
 FRAMEWORK" <linux-clk@vger.kernel.org>, Rob Herring <robh@kernel.org>, "open
 list" <linux-kernel@vger.kernel.org>, Krzysztof Kozlowski
	<krzk+dt@kernel.org>, Christian Melki <christian.melki@t2data.com>, "Michael
 Turquette" <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>
References: <20240821105943.230281-1-ada@thorsis.com>
 <20240821105943.230281-10-ada@thorsis.com>
 <20240919-outsider-extending-e0a926bd23fa@thorsis.com>
 <464f599a-7f0b-4e4e-901a-8f88a25428d6@microchip.com>
From: Nicolas Ferre <nicolas.ferre@microchip.com>
Organization: microchip
In-Reply-To: <464f599a-7f0b-4e4e-901a-8f88a25428d6@microchip.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit

On 24/09/2024 at 17:52, Ryan Wanner wrote:
> Hello Alex,
> 
> I think a possible solution is to put the DT binding ID for main rc oc
> after PMC_MCK and then add 1 to all the other IDs that are not dependent
> on PMC_MAIN, the IDs that are before the branch for the sama7g54.
> 
> One issue I see with this solution is with SoCs that do not want the
> main rc os exported to the DT the driver array might be allocating too
> much memory, this can be solved by removing the +1 that is in the clock

We're talking about a handful of bytes, we can surely afford that.

My $0.02. Regards,
   Nicolas

> drivers next to the device tree binding macro, since this macro is now
> increased by 1 with this change.
> 
> Doing a quick test on the sam9x60 and sama7g54 I did not see any glaring
> issues with this potential solution.
> 
> Best,
> 
> Ryan
> 
> 
> On 9/19/24 05:39, Alexander Dahl wrote:
>> EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
>>
>> Hello Claudiu,
>>
>> after being busy with other things, I'm back looking at this series.
>> As Nicolas pointed out [1], we need three clocks for the OTPC to work,
>> quote:
>>
>>    "for all the products, the main RC oscillator, the OTPC peripheral
>>    clock and the MCKx clocks associated to OTP must be enabled."
>>
>> I have a problem with making the main_rc_osc accessible for both
>> SAM9X60 and SAMA7G5 here, see below.
>>
>> Am Wed, Aug 21, 2024 at 12:59:40PM +0200 schrieb Alexander Dahl:
>>> SAM9X60 Datasheet (DS60001579G) Section "23.4 Product Dependencies"
>>> says:
>>>
>>>      "The OTPC is clocked through the Power Management Controller (PMC).
>>>      The user must power on the main RC oscillator and enable the
>>>      peripheral clock of the OTPC prior to reading or writing the OTP
>>>      memory."
>>>
>>> The code for enabling/disabling that clock is already present, it was
>>> just not possible to hook into DT anymore, after at91 clk devicetree
>>> binding rework back in 2018 for kernel v4.19.
>>>
>>> Signed-off-by: Alexander Dahl <ada@thorsis.com>
>>> ---
>>>   drivers/clk/at91/sam9x60.c       | 3 ++-
>>>   include/dt-bindings/clock/at91.h | 1 +
>>>   2 files changed, 3 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/clk/at91/sam9x60.c b/drivers/clk/at91/sam9x60.c
>>> index e309cbf3cb9a..4d5ee20b8fc4 100644
>>> --- a/drivers/clk/at91/sam9x60.c
>>> +++ b/drivers/clk/at91/sam9x60.c
>>> @@ -207,7 +207,7 @@ static void __init sam9x60_pmc_setup(struct device_node *np)
>>>        if (IS_ERR(regmap))
>>>                return;
>>>
>>> -     sam9x60_pmc = pmc_data_allocate(PMC_PLLACK + 1,
>>> +     sam9x60_pmc = pmc_data_allocate(PMC_MAIN_RC + 1,
>>>                                        nck(sam9x60_systemck),
>>>                                        nck(sam9x60_periphck),
>>>                                        nck(sam9x60_gck), 8);
>>> @@ -218,6 +218,7 @@ static void __init sam9x60_pmc_setup(struct device_node *np)
>>>                                           50000000);
>>>        if (IS_ERR(hw))
>>>                goto err_free;
>>> +     sam9x60_pmc->chws[PMC_MAIN_RC] = hw;
>>>
>>>        hw = at91_clk_register_main_osc(regmap, "main_osc", mainxtal_name, NULL, 0);
>>>        if (IS_ERR(hw))
>>> diff --git a/include/dt-bindings/clock/at91.h b/include/dt-bindings/clock/at91.h
>>> index 3e3972a814c1..f957625cb3ac 100644
>>> --- a/include/dt-bindings/clock/at91.h
>>> +++ b/include/dt-bindings/clock/at91.h
>>> @@ -25,6 +25,7 @@
>>>   #define PMC_PLLBCK           8
>>>   #define PMC_AUDIOPLLCK               9
>>>   #define PMC_AUDIOPINCK               10
>>> +#define PMC_MAIN_RC          11
>>>
>>>   /* SAMA7G5 */
>>>   #define PMC_CPUPLL           (PMC_MAIN + 1)
>>
>> There are IDs defined in the devicetree bindings here, which are used
>> both in dts and in driver code as array indexes.  In v1 of the patch
>> series I just added a new last element in the end of the generic list
>> and used that for SAM9X60.
>>
>> For SAMA7G5 those IDs are branched of from PMC_MAIN in between, making
>> SAMA7G5 using a different last element, and different values after
>> PMC_MAIN.
>>
>> Now we need a new ID for main rc osc, but not only for SAM9X60, but
>> also for SAMA7G5.  I'm not sure what the implications would be, if the
>> new ID would be added in between before PMC_MAIN, so all values would
>> change?  Adding it to the end of the lists would probably be safe, but
>> then you would need a diffently named variant for SAMA7G5's different
>> IDs.  I find the current status somewhat unfortunate for future
>> extensions.  How should this new ID be added here?  What would be the
>> way forward?
>>
>> Greets
>> Alex
>>
>> [1] https://lore.kernel.org/linux-clk/ec34efc2-2051-4b8a-b5d8-6e2fd5e08c28@microchip.com/T/#u
>>
>>> --
>>> 2.39.2
>>>
>>>
>>
> 


