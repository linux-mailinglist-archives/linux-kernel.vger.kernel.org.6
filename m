Return-Path: <linux-kernel+bounces-311580-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5B37968AAE
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 17:10:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 09702B211FA
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 15:10:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3F611CB538;
	Mon,  2 Sep 2024 15:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="qVDBewNr"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 484761CB519;
	Mon,  2 Sep 2024 15:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725289804; cv=none; b=CngB3wkV22oOJgajCP4QnWPyrxreP/hcKPXBLpy8TVnw5+i+T9S4XF3nKvB+MACyUXw7/akT3rzDgCTab04QwFRFV156irUojulO5fbAK/86MTTld+my7LFB7AyqOJGZxsveOfgFhjQSl1SLw6b0sh0Aj8Rl7MBaOQPWMOGcPeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725289804; c=relaxed/simple;
	bh=rKuyikaFh3uMsnW94QkPolNVJ18V2RJFMNOetFaCfp0=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=FIOWDqxcYhk46BCCgzdZSYPQO70rq/6T4u77jAViLQav4/lRQD6g6HkUGuzh2lBMlVp11zdqoEQWCjuoP+dv5fwk5rknT0Zos4pjQxVWLO91ybO0tc1wO2+VYiftiT1q61tBmxoO0zZYAPdMECXG4jKrhwvL1J/WxnoTAda3Dwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=qVDBewNr; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1725289802; x=1756825802;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=rKuyikaFh3uMsnW94QkPolNVJ18V2RJFMNOetFaCfp0=;
  b=qVDBewNrtz4/w8hB4+DGpJjKwblz2JHFbrv52KzKSdvWLsjXaY3ogDTI
   uPTUdvVgj7wXYvyc1G//owEDAci2BTPwS+SjeoVmVJOKy9eZYX7lsfoXG
   5t79r/qPg5PilrFyTUhAiHTzRRgYPZZV4yfsAQt3I1ieC0V5ebEfc8rAx
   yvHF+WAl4FAqgPqJ/R+jetAnmN7m/ZsvcKqw/NnM9gvLvaQPKWjKTyZ/O
   daf5op6HalmSl/ltNgOK9dz5GJ7zOuD+RI0JO9oI6JdzRYcK1XnGi7NZN
   Lkxk42DPa/c+68jhaWRYUX/4hYfQPousaVdAvuY0Iltmhg4pQaD53evOR
   w==;
X-CSE-ConnectionGUID: HNcldJOFSlqbqQixbRg1xA==
X-CSE-MsgGUID: AQggWDGBQHGAHwopq+ge7A==
X-IronPort-AV: E=Sophos;i="6.10,195,1719903600"; 
   d="scan'208";a="262151402"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 02 Sep 2024 08:10:01 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 2 Sep 2024 08:09:46 -0700
Received: from [10.159.245.205] (10.10.85.11) by chn-vm-ex03.mchp-main.com
 (10.10.85.151) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Mon, 2 Sep 2024 08:09:44 -0700
Message-ID: <7a4160cf-d170-4bbd-a4bc-da69c2c43d55@microchip.com>
Date: Mon, 2 Sep 2024 17:10:05 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dt-bindings: ARM: at91: Document Microchip SAMA7D65
 Curiosity
Content-Language: en-US, fr-FR
To: Krzysztof Kozlowski <krzk@kernel.org>, Dharma Balasubiramani
	<dharma.b@microchip.com>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
	<krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Alexandre Belloni
	<alexandre.belloni@bootlin.com>, Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Arnd Bergmann <arnd@arndb.de>
CC: <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, Romain Sioen <romain.sioen@microchip.com>,
	Ryan Wanner <Ryan.Wanner@microchip.com>, Varshini Rajendran
	<Varshini.Rajendran@microchip.com>
References: <20240829-sama7d65-core-dt-v1-1-e5d882886f59@microchip.com>
 <eb96bcf2-8bcd-4801-b381-96583d733b87@kernel.org>
From: Nicolas Ferre <nicolas.ferre@microchip.com>
Organization: microchip
In-Reply-To: <eb96bcf2-8bcd-4801-b381-96583d733b87@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit

On 31/08/2024 at 15:38, Krzysztof Kozlowski wrote:
> On 29/08/2024 11:57, Dharma Balasubiramani wrote:
>> From: Romain Sioen <romain.sioen@microchip.com>
>>
>> Document device tree binding of the Microchip SAMA7D65 Curiosity board.
>>
>> Signed-off-by: Romain Sioen <romain.sioen@microchip.com>
>> Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>
>> Signed-off-by: Dharma Balasubiramani <dharma.b@microchip.com>
>> ---
>>   Documentation/devicetree/bindings/arm/atmel-at91.yaml | 7 +++++++
>>   1 file changed, 7 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/arm/atmel-at91.yaml b/Documentation/devicetree/bindings/arm/atmel-at91.yaml
>> index 82f37328cc69..8e897680d43a 100644
>> --- a/Documentation/devicetree/bindings/arm/atmel-at91.yaml
>> +++ b/Documentation/devicetree/bindings/arm/atmel-at91.yaml
>> @@ -174,6 +174,13 @@ properties:
>>             - const: atmel,sama5d4
>>             - const: atmel,sama5
>>
>> +      - description: Microchip SAMA7D65 Curiosity Board
>> +        items:
>> +          - const: microchip,sama7d65-curiosity
>> +          - const: microchip,sama7d65
>> +          - const: microchip,sama7d6
>> +          - const: microchip,sama7
>> +
> 
> No. This must go with the DTS.
> 
> It's second patch you sent entirely split from the rest. That's not how
> upstreaming of DTS and drivers work.

Krzystof,

We have been upstreaming sam9x75 SoC and now are trying with sama7d65 
SoC using a different approach.

It was mentioned to us to reduce the number of patches sent in a series, 
convert the remaining DT bindings from txt to yaml (we had quite a few), 
avoid generating new errors from the DT bot when sending new .dtsi/dts 
files... So we're trying to comply to these (valid) requirements... But 
well, it's not easy and I would like to emphasize that we are doing our 
best to address most of the (sometimes contradictory) challenges.

So now, we're trying to be very minimal in what we're sending. Address 
peripherals incrementally with trying to generate as few DT check errors 
as possible. Trying this, we're facing chicken and eggs problems: How to 
comply to a binding that is not yet accepted? How to organize 
introduction of a new SoC with a limited number of patch in a series? 
How to convert bindings to yaml and still be able to add new SoCs?

Be sure that we have been coordinating internally to be ready and send 
these patch series together. We're a team and are splitting the 
workload, I believe that it should be possible.
I feel that upstreaming a SoC is becoming overly difficult, and I added 
quite a few to Mainline throughout the years.

Can you please let us post this minimal set of patch series, give you 
the needed information and cross-reference links, but also understand 
that we're adding pieces of a big puzzle that would require a bit of 
flexibility?

Thanks for your understanding. Best regards,
   Nicolas


