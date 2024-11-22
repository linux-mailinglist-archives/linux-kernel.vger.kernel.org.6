Return-Path: <linux-kernel+bounces-418446-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 42FD39D61B9
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 17:12:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8C2CDB22905
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 16:12:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E80713B797;
	Fri, 22 Nov 2024 16:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="HvwiXI16"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B86C12E3EE
	for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 16:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732291922; cv=none; b=iJz6t0ssYqtOTFePPpw0mkkRL2WIdlo37sulwm9nKA4WC9py+s8ClcR+Z+XDdXkMW9Aq5yiD1whDADB7wNdo3GQLqDI4u6bVajLN7xk7Lona1mYDOKrOdHig18NAJe/RHt5wai9YCr5zis1NsAbnacl8LWIIwKEWr8mgnvSj7tI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732291922; c=relaxed/simple;
	bh=B2XuqM2k4vAqnNv/Q7MZKYMoyczUHCxuOfqeQWYko64=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DKAXgEfURSdz3cjUGFK7+bapxCfm4VgToIBwYhskyvVzjJxQhS1W/B2TzUv1T+bRr30jxUeVRKtF/7MeGR60IV3irV+zrak8S1ne6IvDFE92IbWpC2ASFDzG1AOj4aY9y4waXtSvhfqFgaWpYTQQoLv7hc3o93qnlVeV1ppvfSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=HvwiXI16; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-212776d6449so25149255ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 08:12:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1732291920; x=1732896720; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=qeuSASKxqY15hjekOW/VX6sx+7ELWDbXW0lHusDBx0M=;
        b=HvwiXI16KiGZ/DjFhSYONfzxGAb2rWtgiJhHEC6RSLEkpD+6SIMKd33EUEF8qQYyoZ
         0kZnjn16dP/klrUZFapYf7/YIEdwD8F8gc7T9YIHgsdnnQSPY3mwvBdlKjzP+SNC2y3L
         EzP67GmIBkA4pqAzIxTUUlPAoegu0OzoxhI60=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732291920; x=1732896720;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qeuSASKxqY15hjekOW/VX6sx+7ELWDbXW0lHusDBx0M=;
        b=HIm1UQUM9fC3i4SF3CYvqVL+gvTpZmKPOzxHPaDjyDM6Wry3QFIfRDfD5WY87wLNgl
         yk9MGudr3B+tfl/FjqSq1uGV5REAfBynoFQLI61wooQuBjotyPG4uQZZRNTSEscowczW
         retM14svTQ1GTFGVXHffWNcBnMhsl7r+NL9twS36nb3R2uS1zkdgKlhM2n5rgIEX9O6m
         ywpclzluqx+1c7xGFXHULQDudMcQ2KYd0mi3G2bMDeYfjPibVjBJn/rB9/E1SrtRPtkd
         kuA94WAfmKEJ+zTd9AV/m7ySkolZUkqte16ffb/q1MSI2MEDn8hAE7xk9rP9LeL0boBK
         aNKg==
X-Forwarded-Encrypted: i=1; AJvYcCW96rbCQ5hihQQgEdp+3u4AsCUyUAfvCoHVutaXT5czhQSUN6f4JDTw/v36yKl5oR+6XtWE0weiQiTE5X0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6EoembMqactXVCLQPeR0n9EXnfAbQI02JImSxL5xyLODb6JRl
	t4++cGX2j5MN4JJb4BVkLk/NUh2RYrl82+qUhENDekhpRsrXU4YNYiIdFaARi6IWieGcdsz+1ny
	Xlw==
X-Gm-Gg: ASbGncvJFqkkzFl45zHXFkqhkhDfQ6Agr4u0cy2+aGv0o5GFqin5KVntyik9aDL3mC/
	BVA3w+vTB3ylTvnD1b8PO7ktNwPCTVBf/vds9oSFUd+te/76DRB4Z3/yURV97lWNy56mGX3+aF8
	UecpkzEkwvpxbnXTMBzBUul+JsiQLgAthAm33hZPnbLNUVD6e7ryGDkPigCEUSXc4jPRg3MVEbz
	X4OhwylcZDjTPvZ332gwRijH4VMH5xWGiy15hQarQ3FLEzImWT5XHYNgaJ91OZOw+7weOkpzHGm
	Odsn0ikgSmo8p/Z2wYrYj61r
X-Google-Smtp-Source: AGHT+IHfRfcL3L8+ww9Y6Is7Dr5zOV4p7yRTBPSPTOb3uNC96+njIJuxJFE9xL4mmMRR9hbRp+Vazg==
X-Received: by 2002:a17:902:f543:b0:212:1abb:fe65 with SMTP id d9443c01a7336-2129f5e7d2dmr44710335ad.35.1732291920011;
        Fri, 22 Nov 2024 08:12:00 -0800 (PST)
Received: from [192.168.1.3] (ip68-4-215-93.oc.oc.cox.net. [68.4.215.93])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-724de575d9asm1782022b3a.178.2024.11.22.08.11.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Nov 2024 08:11:59 -0800 (PST)
Message-ID: <4823ecb4-d714-43a2-8fc0-dff7c9ff8a6d@broadcom.com>
Date: Fri, 22 Nov 2024 08:11:57 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] pm: cpupower: Makefile: Fix cross compilation
To: Shuah Khan <skhan@linuxfoundation.org>, linux-kernel@vger.kernel.org
Cc: Thomas Renninger <trenn@suse.com>, Shuah Khan <shuah@kernel.org>,
 "John B. Wyatt IV" <jwyatt@redhat.com>, John Kacur <jkacur@redhat.com>,
 Peng Fan <peng.fan@nxp.com>,
 "open list:CPU POWER MONITORING SUBSYSTEM" <linux-pm@vger.kernel.org>
References: <20241121044353.1753244-1-florian.fainelli@broadcom.com>
 <9d35ba5e-179e-4aef-b973-ad615489cfa4@linuxfoundation.org>
Content-Language: en-US
From: Florian Fainelli <florian.fainelli@broadcom.com>
Autocrypt: addr=florian.fainelli@broadcom.com; keydata=
 xsBNBFPAG8ABCAC3EO02urEwipgbUNJ1r6oI2Vr/+uE389lSEShN2PmL3MVnzhViSAtrYxeT
 M0Txqn1tOWoIc4QUl6Ggqf5KP6FoRkCrgMMTnUAINsINYXK+3OLe7HjP10h2jDRX4Ajs4Ghs
 JrZOBru6rH0YrgAhr6O5gG7NE1jhly+EsOa2MpwOiXO4DE/YKZGuVe6Bh87WqmILs9KvnNrQ
 PcycQnYKTVpqE95d4M824M5cuRB6D1GrYovCsjA9uxo22kPdOoQRAu5gBBn3AdtALFyQj9DQ
 KQuc39/i/Kt6XLZ/RsBc6qLs+p+JnEuPJngTSfWvzGjpx0nkwCMi4yBb+xk7Hki4kEslABEB
 AAHNMEZsb3JpYW4gRmFpbmVsbGkgPGZsb3JpYW4uZmFpbmVsbGlAYnJvYWRjb20uY29tPsLB
 IQQQAQgAywUCZWl41AUJI+Jo+hcKAAG/SMv+fS3xUQWa0NryPuoRGjsA3SAUAAAAAAAWAAFr
 ZXktdXNhZ2UtbWFza0BwZ3AuY29tjDAUgAAAAAAgAAdwcmVmZXJyZWQtZW1haWwtZW5jb2Rp
 bmdAcGdwLmNvbXBncG1pbWUICwkIBwMCAQoFF4AAAAAZGGxkYXA6Ly9rZXlzLmJyb2FkY29t
 Lm5ldAUbAwAAAAMWAgEFHgEAAAAEFQgJChYhBNXZKpfnkVze1+R8aIExtcQpvGagAAoJEIEx
 tcQpvGagWPEH/2l0DNr9QkTwJUxOoP9wgHfmVhqc0ZlDsBFv91I3BbhGKI5UATbipKNqG13Z
 TsBrJHcrnCqnTRS+8n9/myOF0ng2A4YT0EJnayzHugXm+hrkO5O9UEPJ8a+0553VqyoFhHqA
 zjxj8fUu1px5cbb4R9G4UAySqyeLLeqnYLCKb4+GklGSBGsLMYvLmIDNYlkhMdnnzsSUAS61
 WJYW6jjnzMwuKJ0ZHv7xZvSHyhIsFRiYiEs44kiYjbUUMcXor/uLEuTIazGrE3MahuGdjpT2
 IOjoMiTsbMc0yfhHp6G/2E769oDXMVxCCbMVpA+LUtVIQEA+8Zr6mX0Yk4nDS7OiBlvOwE0E
 U8AbwQEIAKxr71oqe+0+MYCc7WafWEcpQHFUwvYLcdBoOnmJPxDwDRpvU5LhqSPvk/yJdh9k
 4xUDQu3rm1qIW2I9Puk5n/Jz/lZsqGw8T13DKyu8eMcvaA/irm9lX9El27DPHy/0qsxmxVmU
 pu9y9S+BmaMb2CM9IuyxMWEl9ruWFS2jAWh/R8CrdnL6+zLk60R7XGzmSJqF09vYNlJ6Bdbs
 MWDXkYWWP5Ub1ZJGNJQ4qT7g8IN0qXxzLQsmz6tbgLMEHYBGx80bBF8AkdThd6SLhreCN7Uh
 IR/5NXGqotAZao2xlDpJLuOMQtoH9WVNuuxQQZHVd8if+yp6yRJ5DAmIUt5CCPcAEQEAAcLB
 gQQYAQIBKwUCU8AbwgUbDAAAAMBdIAQZAQgABgUCU8AbwQAKCRCTYAaomC8PVQ0VCACWk3n+
 obFABEp5Rg6Qvspi9kWXcwCcfZV41OIYWhXMoc57ssjCand5noZi8bKg0bxw4qsg+9cNgZ3P
 N/DFWcNKcAT3Z2/4fTnJqdJS//YcEhlr8uGs+ZWFcqAPbteFCM4dGDRruo69IrHfyyQGx16s
 CcFlrN8vD066RKevFepb/ml7eYEdN5SRALyEdQMKeCSf3mectdoECEqdF/MWpfWIYQ1hEfdm
 C2Kztm+h3Nkt9ZQLqc3wsPJZmbD9T0c9Rphfypgw/SfTf2/CHoYVkKqwUIzI59itl5Lze+R5
 wDByhWHx2Ud2R7SudmT9XK1e0x7W7a5z11Q6vrzuED5nQvkhAAoJEIExtcQpvGagugcIAJd5
 EYe6KM6Y6RvI6TvHp+QgbU5dxvjqSiSvam0Ms3QrLidCtantcGT2Wz/2PlbZqkoJxMQc40rb
 fXa4xQSvJYj0GWpadrDJUvUu3LEsunDCxdWrmbmwGRKqZraV2oG7YEddmDqOe0Xm/NxeSobc
 MIlnaE6V0U8f5zNHB7Y46yJjjYT/Ds1TJo3pvwevDWPvv6rdBeV07D9s43frUS6xYd1uFxHC
 7dZYWJjZmyUf5evr1W1gCgwLXG0PEi9n3qmz1lelQ8lSocmvxBKtMbX/OKhAfuP/iIwnTsww
 95A2SaPiQZA51NywV8OFgsN0ITl2PlZ4Tp9hHERDe6nQCsNI/Us=
In-Reply-To: <9d35ba5e-179e-4aef-b973-ad615489cfa4@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 11/22/2024 7:25 AM, Shuah Khan wrote:
> On 11/20/24 21:43, Florian Fainelli wrote:
>> After f79473ed9220 ("pm: cpupower: Makefile: Allow overriding
>> cross-compiling env params") we would fail to cross compile cpupower in
>> buildroot which uses the recipe at [1] where only the CROSS variable is
>> being set.
>>
>> The issue here is the use of the lazy evaluation for all variables: CC,
>> LD, AR, STRIP, RANLIB, rather than just CROSS.
>>
>> [1]:
>> https://git.buildroot.net/buildroot/tree/package/linux-tools/linux- 
>> tool-cpupower.mk.in
>>
>> Fixes: f79473ed9220 ("pm: cpupower: Makefile: Allow overriding cross- 
>> compiling env params")
>> Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>
>> Change-Id: Id98f2c648c82c08044b7281714bc6a8e921629ad
>> ---
>>   tools/power/cpupower/Makefile | 10 +++++-----
>>   1 file changed, 5 insertions(+), 5 deletions(-)
>>
>> diff --git a/tools/power/cpupower/Makefile b/tools/power/cpupower/ 
>> Makefile
>> index 175004ce44b2..96bb1e5f3970 100644
>> --- a/tools/power/cpupower/Makefile
>> +++ b/tools/power/cpupower/Makefile
>> @@ -87,11 +87,11 @@ INSTALL_SCRIPT = ${INSTALL} -m 644
>>   # to something more interesting, like "arm-linux-".  If you want
>>   # to compile vs uClibc, that can be done here as well.
>>   CROSS ?= #/usr/i386-linux-uclibc/usr/bin/i386-uclibc-
>> -CC ?= $(CROSS)gcc
>> -LD ?= $(CROSS)gcc
>> -AR ?= $(CROSS)ar
>> -STRIP ?= $(CROSS)strip
>> -RANLIB ?= $(CROSS)ranlib
>> +CC = $(CROSS)gcc
>> +LD = $(CROSS)gcc
>> +AR = $(CROSS)ar
>> +STRIP = $(CROSS)strip
>> +RANLIB = $(CROSS)ranlib
>>   HOSTCC = gcc
>>   MKDIR = mkdir
> 
> Thank you for the patch. I will apply this once the merge window
> closes.

Thanks for taking a look, there is still an on-going discussion with 
Peng about how to best approach this, the discussion is here:

https://lore.kernel.org/all/PAXPR04MB84595BA5BEAE2D21F015036688232@PAXPR04MB8459.eurprd04.prod.outlook.com/

Let's wait until that settles before taking this patch, or Peng's.
-- 
Florian


