Return-Path: <linux-kernel+bounces-176954-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1814B8C37CC
	for <lists+linux-kernel@lfdr.de>; Sun, 12 May 2024 19:38:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 328CF1C20999
	for <lists+linux-kernel@lfdr.de>; Sun, 12 May 2024 17:38:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A03A34D5BF;
	Sun, 12 May 2024 17:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b="MJWlGTEO"
Received: from mx1.sberdevices.ru (mx2.sberdevices.ru [45.89.224.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F5781E528;
	Sun, 12 May 2024 17:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.89.224.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715535476; cv=none; b=p5uMc3sd0U97xG62k7PianuV+jX+GwzWYPs1oRlk8Gy/UDZQiOoYeDYOkpUpBVkBsW3rz7QkrvZrwkReno/ECsQMzbYWxqW70K89E3T9IfmKn/w1G3eufhuhebxRZU1dAAwWGmOHR2r1t/QrQH2JVgBmmxbWgaljy5G83XmKJj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715535476; c=relaxed/simple;
	bh=U75ivTuC56utMHdDFPzGOGOJJmGtbfE4XqWe0/BYtns=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=sR/04EB9rqMPWgmbJi8tPXGeP/7a4ZhUX54ixE3bkIlxuOOEu2+FBT4NiVMhnPWb/OHHr6WS2vzcp5sXXodxuETT8ru64MGHq3LkhyvYL5Fl/J4gyVtBwtwqpSrZaPKGfV6DhVFsxNPVIvh6vEOOY9BLYt9evUc0iWpz7bhsJBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com; spf=pass smtp.mailfrom=salutedevices.com; dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b=MJWlGTEO; arc=none smtp.client-ip=45.89.224.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=salutedevices.com
Received: from p-infra-ksmg-sc-msk02 (localhost [127.0.0.1])
	by mx1.sberdevices.ru (Postfix) with ESMTP id 4DD4F120002;
	Sun, 12 May 2024 20:37:43 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 4DD4F120002
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=mail; t=1715535463;
	bh=uwsRFR9afraqpGHPq8DU2TSJXRBWv6wXpdPPQhQUsLY=;
	h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type:From;
	b=MJWlGTEOl1552sZrUtJQGf6XyPUgf5YKCyzIZH/ZnvlUOVrcmO9vlSlrOeiKUUOpK
	 3DTB1ZTu5xJrJ5AGiLLm1D/uGN6J+i/LwWEZCab7wU2gTLos9fgSZMu0hiMMkMb3Hm
	 BsCUstwLD5Qmk10Eq4MKdGgfHdZknWmJcJLn/HUyZSCzECeazwPqvbZ65ifdTjFvsR
	 4+zM81xf0Qs1FkJv94UN0k+cFjS7UcmySsuk0hKzp1AZYywW0nGbM7aLB8Vflg9jgt
	 8L/qzVtlLCuxtVULswG4HAXTiDRfmucsTRZ/h4G1YP/z+mbKruUPPhKfE/aBCnlYBK
	 u8eJPbczokiYg==
Received: from smtp.sberdevices.ru (p-i-exch-sc-m02.sberdevices.ru [172.16.192.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.sberdevices.ru (Postfix) with ESMTPS;
	Sun, 12 May 2024 20:37:43 +0300 (MSK)
Received: from [172.28.226.125] (100.64.160.123) by
 p-i-exch-sc-m02.sberdevices.ru (172.16.192.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Sun, 12 May 2024 20:37:42 +0300
Message-ID: <418e29c7-9baf-ee4c-7a24-49c196ac89b2@salutedevices.com>
Date: Sun, 12 May 2024 20:26:51 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v6 1/3] dt-bindings: mtd: amlogic,meson-nand: support
 fields for boot ROM code
Content-Language: en-US
To: Krasnov Arseniy <oxffffaa@gmail.com>, "Rob Herring (Arm)"
	<robh@kernel.org>
CC: Vignesh Raghavendra <vigneshr@ti.com>, Miquel Raynal
	<miquel.raynal@bootlin.com>, Richard Weinberger <richard@nod.at>,
	<devicetree@vger.kernel.org>, Kevin Hilman <khilman@baylibre.com>,
	<linux-mtd@lists.infradead.org>, <linux-arm-kernel@lists.infradead.org>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	<linux-amlogic@lists.infradead.org>, <kernel@sberdevices.ru>, Jerome Brunet
	<jbrunet@baylibre.com>, Rob Herring <robh+dt@kernel.org>,
	<linux-kernel@vger.kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley
	<conor+dt@kernel.org>
References: <20240507230903.3399594-1-avkrasnov@salutedevices.com>
 <20240507230903.3399594-2-avkrasnov@salutedevices.com>
 <171517732606.1572649.16193191353725811830.robh@kernel.org>
 <CAP_G_RUdN+6OcsQZUkqWQMYoH-ZvmPnskT3yONK_YssqUYhm9Q@mail.gmail.com>
From: Arseniy Krasnov <avkrasnov@salutedevices.com>
In-Reply-To: <CAP_G_RUdN+6OcsQZUkqWQMYoH-ZvmPnskT3yONK_YssqUYhm9Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: p-i-exch-sc-m02.sberdevices.ru (172.16.192.103) To
 p-i-exch-sc-m02.sberdevices.ru (172.16.192.103)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 185167 [May 11 2024]
X-KSMG-AntiSpam-Version: 6.1.0.4
X-KSMG-AntiSpam-Envelope-From: avkrasnov@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 19 0.3.19 07c7fa124d1a1dc9662cdc5aace418c06ae99d2b, {Tracking_from_domain_doesnt_match_to}, 100.64.160.123:7.1.2;smtp.sberdevices.ru:5.0.1,7.1.1;salutedevices.com:7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;127.0.0.199:7.1.2, FromAlignment: s, ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2024/05/12 16:13:00 #25178084
X-KSMG-AntiVirus-Status: Clean, skipped

Sorry, sending from proper mail client again (not sure it was delivered sent from gmail client on 08.05) :)

R-b was removed, because this patch was updated

Thanks, Arseniy

On 08.05.2024 20:07, Krasnov Arseniy wrote:
> Hi! I removed Your R-b because patch was changed in this version, after
> comments from Miquel Raynal
> 
> Thanks
> 
> ср, 8 мая 2024 г., 17:09 Rob Herring (Arm) <robh@kernel.org>:
> 
>>
>> On Wed, 08 May 2024 02:09:01 +0300, Arseniy Krasnov wrote:
>>> Boot ROM code on Meson requires that some pages on NAND must be written
>>> in special mode: "short" ECC mode where each block is 384 bytes and
>>> scrambling mode is on. Such pages are located on the chip in the
>>> following way (for example):
>>>
>>> [ p0 ][ p1 ][ p2 ][ p3 ][ p4 ][ p5 ][ p6 ][ p7 ] ... [ pN ]
>>>   ^           ^           ^           ^
>>>
>>> pX is page number "X". "^" means "special" page used by boot ROM - e.g.
>>> every 2nd page in the range of [0, 7]. Step (2 in example is set by
>>> 'amlogic,boot-page-step' field. Last page in range (7 in example) is
>>> set by 'amlogic,boot-pages' field.
>>>
>>> Signed-off-by: Arseniy Krasnov <avkrasnov@salutedevices.com>
>>> ---
>>>  .../bindings/mtd/amlogic,meson-nand.yaml       | 18 ++++++++++++++++++
>>>  1 file changed, 18 insertions(+)
>>>
>>
>>
>> Please add Acked-by/Reviewed-by tags when posting new versions. However,
>> there's no need to repost patches *only* to add the tags. The upstream
>> maintainer will do that for acks received on the version they apply.
>>
>> If a tag was not added on purpose, please state why and what changed.
>>
>> Missing tags:
>>
>> Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
>>
>>
>>
>>
> 

