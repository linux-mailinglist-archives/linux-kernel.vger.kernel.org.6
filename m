Return-Path: <linux-kernel+bounces-309954-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B8DE3967268
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Aug 2024 17:34:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F60528372F
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Aug 2024 15:34:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C60328377;
	Sat, 31 Aug 2024 15:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="Vs2Cb78D"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DD931BF2A
	for <linux-kernel@vger.kernel.org>; Sat, 31 Aug 2024 15:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725118437; cv=none; b=mEI3iblmAvocbYu8kTa6Xcrd3ASo0bx60CfPkHjYaf7aHwPoTRwjgRcqUk3t5DUYfT8asvMT+PPRohoyC/dWiuCCrD/Hukkaf66pDXOCsbjp7cuLivufcp1M3xelJNN8m6E6PZ/swaQsN5SBwH2Gos99dXnHD8CMDEPTke2f7ds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725118437; c=relaxed/simple;
	bh=0Aq1sNKfFzJn8xQpMMG4pqBsSwiOHkTTuHUhXG4ekCM=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=BtiUoWStcjdSznAO8L6iiZki1A7FSKk9TwGzqC3ic+CLTgd/PvKoxkreioyk0IMZfFFZo+eqpExf5yhXJBcTr4VSv/wxbdyCrHw7+We57D0ZzRBtQgwLSk4cr2RhbFKbUEJyBu99X+CRc04Oxkfu8/cMN5S+V9RnVnhUpRbImKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=Vs2Cb78D; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-42c7bc97423so3114205e9.0
        for <linux-kernel@vger.kernel.org>; Sat, 31 Aug 2024 08:33:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1725118434; x=1725723234; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=N9MjxDrbaua4w9wMZSO5n89c35tDh+VOTCEJqezilSA=;
        b=Vs2Cb78DqI+829I3CnXDTWAlQjDkpK/MMbuMa9b0vQJUb2DDQVo3kGePsHxBNCw22D
         lGZXz4qoXUPduQoRXVo0/W9EAbSxdSiLGFcz1Vpqp20PVjYqlYZblNwJksLuTQPlWrHf
         viQ0spERVeoMJC3eP4BVzJbqlZEhR2kTf/DJ1MH/jRH/hs9/zazTEGY+1/jHCBv7Ykd4
         n4+WAMcP0ef0xlqRFb4hQfguGPpIQDWSUb3pcAjDgBfK4AJMEzQK9ySs+/0hwf41z/Y/
         Ja3YO4yqxep5Qm5U4I0hhwH6hQBqH7a7FSjJrQSb5OJUZ45Mdy4WapvAwpnovsiQhVSk
         riNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725118434; x=1725723234;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=N9MjxDrbaua4w9wMZSO5n89c35tDh+VOTCEJqezilSA=;
        b=r9Owscn8EyNIIIX/jEebDs9ch/q5xCz4dyQDfyVi6fVlUcszgeQwWmpF0Qnd3+vCHn
         jAjuODq4Vj1dL8BY2zcBKcL6JkfuY0Y0SSmLAsLALRZ+lOAVC7YUm/kxVQKsB4KnScx3
         7Xg07XegFEZhpmLPh/KpJpTtHiY5I4zwyh52+cHl0lsakOJtEW/boeaORtHdCoKeIlHE
         YgovB+vCvYImk6VvAV16Vbm+hcbbZX1JAfPVwhWvkdzTB3mLjLQebVrR87WmcFz1afCA
         6IEyFi1lTrQh3PaNS35gPstI11IqdsayD7CeW9HItbadr9O87dJvRCwanlGdctRo7acP
         d+6w==
X-Forwarded-Encrypted: i=1; AJvYcCWM7lD1rV8kwzh064YgcVve7jFUaqfN8Dbcz3/8wLbMG6s6HBO+Jr7FXn9osJOypzHKG2kIggglOdOHM6k=@vger.kernel.org
X-Gm-Message-State: AOJu0YxaJyWjjmS3UEfGZOMLoxnEN/5lLRqoprJ4iQd1+H/hGnsVZHjS
	TKTCMswhd4CKbeOvv6qHYw2JqBQwIDD7x50YxOeeSx8O3NfjxgW3HaEe9229zM4=
X-Google-Smtp-Source: AGHT+IGbHkUNqAug0TtbZHZxpqz58AzfONDihCHxG0wzsQG0OM473lIfRYWud/gLeqmeP9GloZ6rAg==
X-Received: by 2002:a05:600c:1c83:b0:426:59fe:ac27 with SMTP id 5b1f17b1804b1-42bb01edc2amr81614945e9.26.1725118433566;
        Sat, 31 Aug 2024 08:33:53 -0700 (PDT)
Received: from [192.168.50.4] ([82.78.167.144])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42bb6df7c5bsm79364085e9.23.2024.08.31.08.33.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 31 Aug 2024 08:33:53 -0700 (PDT)
Message-ID: <aeed6b52-98df-4515-a3df-5ccc8429e022@tuxon.dev>
Date: Sat, 31 Aug 2024 18:33:50 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 07/12] nvmem: microchip-otpc: Add missing register
 definitions
Content-Language: en-US
To: Christian Melki <christian.melki@t2data.com>,
 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
 "moderated list:MICROCHIP OTPC DRIVER"
 <linux-arm-kernel@lists.infradead.org>,
 open list <linux-kernel@vger.kernel.org>,
 Nicolas Ferre <nicolas.ferre@microchip.com>
References: <20240821105943.230281-1-ada@thorsis.com>
 <20240821105943.230281-8-ada@thorsis.com>
 <5228af83-b423-4f51-820a-edfc40017ca8@tuxon.dev>
 <20240828-making-gangrene-786ec368b106@thorsis.com>
From: claudiu beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <20240828-making-gangrene-786ec368b106@thorsis.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 28.08.2024 11:14, Alexander Dahl wrote:
> Hello Claudiu,
> 
> Am Sat, Aug 24, 2024 at 06:54:02PM +0300 schrieb claudiu beznea:
>>
>>
>> On 21.08.2024 13:59, Alexander Dahl wrote:
>>> According to datasheets DS60001765B for SAMA7G5 and DS60001579G for
>>> SAM9X60.
>>>
>>> Signed-off-by: Alexander Dahl <ada@thorsis.com>
>>> ---
>>>  drivers/nvmem/microchip-otpc.c | 15 +++++++++++++++
>>>  1 file changed, 15 insertions(+)
>>>
>>> diff --git a/drivers/nvmem/microchip-otpc.c b/drivers/nvmem/microchip-otpc.c
>>> index b8ed7412dbca..4630e96243ac 100644
>>> --- a/drivers/nvmem/microchip-otpc.c
>>> +++ b/drivers/nvmem/microchip-otpc.c
>>> @@ -21,9 +21,24 @@
>>>  #define MCHP_OTPC_AR			(0x8)
>>>  #define MCHP_OTPC_SR			(0xc)
>>>  #define MCHP_OTPC_SR_READ		BIT(6)
>>> +#define MCHP_OTPC_IER			(0x10)
>>> +#define MCHP_OTPC_IDR			(0x14)
>>> +#define MCHP_OTPC_IMR			(0x18)
>>> +#define MCHP_OTPC_ISR			(0x1C)
>>> +#define MCHP_OTPC_ISR_COERR		BIT(13)
>>>  #define MCHP_OTPC_HR			(0x20)
>>>  #define MCHP_OTPC_HR_SIZE		GENMASK(15, 8)
>>>  #define MCHP_OTPC_DR			(0x24)
>>> +#define MCHP_OTPC_BAR			(0x30)
>>> +#define MCHP_OTPC_CAR			(0x34)
>>> +#define MCHP_OTPC_UHC0R			(0x50)
>>> +#define MCHP_OTPC_UHC1R			(0x54)
>>> +#define MCHP_OTPC_UID0R			(0x60)
>>> +#define MCHP_OTPC_UID1R			(0x64)
>>> +#define MCHP_OTPC_UID2R			(0x68)
>>> +#define MCHP_OTPC_UID3R			(0x6C)
>>> +#define MCHP_OTPC_WPMR			(0xE4)
>>> +#define MCHP_OTPC_WPSR			(0xE8)
>>
>> Are all these used in driver?
> 
> Not all, but some.  What are you implying?  Only add register
> definitions actually used in the driver? 

Yes!

> Why?

Less code to maintain. If it's not used there is no meaning to have it.


> 
> Those register offsets won't change, but helped us when debugging.
> Debug code (e.g. register dump) is not part of the patch series.
> 
> Greets
> Alex
> 
>>
>>>  
>>>  #define MCHP_OTPC_NAME			"mchp-otpc"
>>>  #define MCHP_OTPC_SIZE			(11 * 1024)

