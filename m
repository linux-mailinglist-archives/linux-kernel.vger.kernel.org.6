Return-Path: <linux-kernel+bounces-170833-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 960CE8BDCA6
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 09:46:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C73671C22F5F
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 07:46:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 246C013C667;
	Tue,  7 May 2024 07:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b="g1xsU6pQ"
Received: from mx1.sberdevices.ru (mx2.sberdevices.ru [45.89.224.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 138AE13BC39;
	Tue,  7 May 2024 07:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.89.224.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715068001; cv=none; b=uTZgwJ48HPVMx7FVJirR1aM5WUZbzm90QcARoJRWKFkKX6VOaweN5+++JOrQObAebH99ZN9RwlU0LYv3QyF2rJYvO2Kzb/PtWoiu/9LBdHUE03zf3PzSZ/+d97q8pme30mnrzmsZRIEOuYvD8/JfIB8BIU33GPDbuOpx8p4Q+qM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715068001; c=relaxed/simple;
	bh=94Af4ymmCiF00Qx1iKDK+IJXafc4Rr4rO1jecboT9BE=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=sIJwhm02ZgQ7DEZChJLKcMRz7fW7+zJrLYioZlazVHtKtrnUvEqwkm2tJsXJ5MHNJDI3UaEpsTMnzC84UEoj94S0BhoYRSgbp0A/uG3eSS+hlyZOUM+Y1ssZqQVmSIj1q62S1GM9GpvjgE+akzW9evMcIcwsM1xVLOPSuFCjKoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com; spf=pass smtp.mailfrom=salutedevices.com; dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b=g1xsU6pQ; arc=none smtp.client-ip=45.89.224.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=salutedevices.com
Received: from p-infra-ksmg-sc-msk02 (localhost [127.0.0.1])
	by mx1.sberdevices.ru (Postfix) with ESMTP id 0D05B120005;
	Tue,  7 May 2024 10:46:35 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 0D05B120005
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=mail; t=1715067995;
	bh=Gu71DSSw7UmD80j9iS8L6fOPFWts2Eqb3HZYUJnLUQo=;
	h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type:From;
	b=g1xsU6pQtn8HsuRHl2PbpoH6ktNn/NNTJgnu0d8Pf8dUGmmrRIrDCX2d5yDCkOWdO
	 UqjUFPp6maQ0CRIbDhCLdQRZQUj6mIFSiIUSAwrG9Z6kuxGOlAz3fmkD11k4FG4loc
	 ROgfBNtqvbXp40oDGrHlk/IYx8hgcfApUZHO+q1j57maDX0vnPOL14tpZqiI8FWKVR
	 YthHiYDaJxdWI9L4+owRh4Y0RvL/j0u8rpt+2GOO+HOrJ7zPrQpwSKnvp/Sy+jMvoG
	 Pml6qneHQmbss0rwzQo9SjB2UWqILgORZESCta4fj11wcAoMUCB3gkfw1q0yS2Qru9
	 FBXOb92L87g4w==
Received: from smtp.sberdevices.ru (p-i-exch-sc-m02.sberdevices.ru [172.16.192.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.sberdevices.ru (Postfix) with ESMTPS;
	Tue,  7 May 2024 10:46:34 +0300 (MSK)
Received: from [172.28.226.125] (100.64.160.123) by
 p-i-exch-sc-m02.sberdevices.ru (172.16.192.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Tue, 7 May 2024 10:46:34 +0300
Message-ID: <e3ea7238-c80d-dfe9-28bf-df95708872d6@salutedevices.com>
Date: Tue, 7 May 2024 10:35:51 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v5 1/2] dt-bindings: mtd: amlogic,meson-nand: support
 fields for boot ROM code
Content-Language: en-US
To: Miquel Raynal <miquel.raynal@bootlin.com>
CC: Richard Weinberger <richard@nod.at>, Vignesh Raghavendra
	<vigneshr@ti.com>, Rob Herring <robh+dt@kernel.org>, Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, Neil
 Armstrong <neil.armstrong@linaro.org>, Kevin Hilman <khilman@baylibre.com>,
	Jerome Brunet <jbrunet@baylibre.com>, Martin Blumenstingl
	<martin.blumenstingl@googlemail.com>, <linux-mtd@lists.infradead.org>,
	<devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-amlogic@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<oxffffaa@gmail.com>, <kernel@sberdevices.ru>
References: <20240416085101.740458-1-avkrasnov@salutedevices.com>
 <20240416085101.740458-2-avkrasnov@salutedevices.com>
 <20240506154858.003bab54@xps-13>
 <d90f9d3d-7823-503f-4cc6-73783a083d0e@salutedevices.com>
 <20240507092726.4ab1afdb@xps-13>
From: Arseniy Krasnov <avkrasnov@salutedevices.com>
In-Reply-To: <20240507092726.4ab1afdb@xps-13>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) To
 p-i-exch-sc-m02.sberdevices.ru (172.16.192.103)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 185103 [May 07 2024]
X-KSMG-AntiSpam-Version: 6.1.0.4
X-KSMG-AntiSpam-Envelope-From: avkrasnov@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 19 0.3.19 07c7fa124d1a1dc9662cdc5aace418c06ae99d2b, {Tracking_from_domain_doesnt_match_to}, smtp.sberdevices.ru:7.1.1,5.0.1;salutedevices.com:7.1.1;100.64.160.123:7.1.2;127.0.0.199:7.1.2;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1, FromAlignment: s, ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2024/05/07 06:33:00 #25113436
X-KSMG-AntiVirus-Status: Clean, skipped



On 07.05.2024 10:27, Miquel Raynal wrote:
> Hi Arseniy,
> 
> avkrasnov@salutedevices.com wrote on Tue, 7 May 2024 09:53:06 +0300:
> 
>> On 06.05.2024 16:48, Miquel Raynal wrote:
>>> Hi Arseniy,
>>>
>>> avkrasnov@salutedevices.com wrote on Tue, 16 Apr 2024 11:51:00 +0300:
>>>   
>>>> Boot ROM code on Meson requires that some pages on NAND must be written
>>>> in special mode: "short" ECC mode where each block is 384 bytes and
>>>> scrambling mode is on.  
>>>
>>> Ok
>>>   
>>>> Such pages located with the specified interval within specified offset.  
>>>
>>> I'm sorry I don't get that sentence.  
>>
>> Sorry, I mean this (let me draw :) ) :
>>
>> [ page 0 ][ page 1 ][ page 2 ][ page 3 ][ page 4 ][ page 5 ][ page 6 ][ page 7 ][ page 8 ][ page 9 ]
>>
>> For example, we have 10 pages starting from the beginning of the chip - this is "within specified offset",
>> e.g. offset is 10. BootROM on axg needs that (for example) every third page must be written in "special"
>> mode: scrambling is on and ECC is 384 bytes. Such pages are 0, 2, 4, 6, 8. E.g. "specified interval" will
>> be 3.
> 
> Shall be 2, no?

yes, starting from 0 - then 2. e.g.
if (!(page_num % 2))
    boot ROM need this page

> 
>>
>> So:
>>
>> amlogic,boot-pages: 10
>> amlogic,boot-page-step: 3
> 
> Ok I get it. Thanks for the explanation. I don't really understand the
> logic behind it though. Do you know why the bootROM would access only
> one page over 2 or 3? Is there a default value? Is this configurable?

No, boot rom source is closed, I don't have access to it. I get this logic
from old version of vendor's uboot - in practice they use non 2 or 3, they
use hardcoded 128 step value. And amlogic,boot-pages is 1024

Thanks, Arseniy

> 
> Thanks,
> Miquèl

