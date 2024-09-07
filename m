Return-Path: <linux-kernel+bounces-319780-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A82B497021C
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Sep 2024 14:05:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA58B1C21A52
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Sep 2024 12:05:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2273A15B0F9;
	Sat,  7 Sep 2024 12:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="mY2TSYef"
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CADD1F5F6
	for <linux-kernel@vger.kernel.org>; Sat,  7 Sep 2024 12:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725710707; cv=none; b=NmWI246hilmL/OBT9RomVtumEvf2AW9MW4ABBP/s6aHyPWHuBfivdaGn6K9znpwdspMM72S6eGBi7v3VRniR2DYCaCbjPeoDozeB+rUEz1k5bUedg3H2T6PTnhq/CSLloash8DvFGaE7/rKMAeaHIG2M/oAcEHgwpKlqmoFT8wM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725710707; c=relaxed/simple;
	bh=pz/0EIbo4rpjszwOhTVi0fNWSmvIxvKSIP1MU6sZndQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=ed+F5quVBOY4IYD1npz6hiu78NXdnS6myV1vn782XtekGVCFrb/iQsEmuf5NEG1vunaUrgmnkMQeJsUdXiBisO97Uc4dThkL8+CnAEGGGni7kcmyi1pLHI2AU/4I+lPuAVIevKoR8H8S2L8gYivGQZLgVZjax16E2x9KEt0SkcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=mY2TSYef; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-53661ac5ba1so110306e87.2
        for <linux-kernel@vger.kernel.org>; Sat, 07 Sep 2024 05:05:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1725710703; x=1726315503; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aqvM697JlB9gjKKKjfqbFfLfWOob1dg5J0ndW8MLbXU=;
        b=mY2TSYef2CdajvY4OYmA2mw48KxuAN27suoHLlyjL+8z27BjHGSTBneHdlWBBD0meV
         eix+OLir6i+DaOkxKRnbHdGoKrRcYYv26CkJf4lR6+4pmr+ZvrOw8aGVq666Ba9g3C27
         NTe8zgPH89drga1hiaQF4vRpNk2uJSOfibbyWMgekRTbiNIhRogAeFcCRr7VjgQYUlmF
         8nb+Chc62bL4hS3qFzi6mtKGzR64sMnXcoiWJVSU6uPInqw53sRY9cuCWx9QVLwY1f/w
         2v3IhW3F2sMehQgmMaU2v6yecOmbH52oDJu5Z5FKjUujRZcZdYhuC43SGAieduJ/dhJM
         Lutg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725710703; x=1726315503;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aqvM697JlB9gjKKKjfqbFfLfWOob1dg5J0ndW8MLbXU=;
        b=TUlroEvlkSYpDwmRNGoBAwVK18/+O02ZrmZOgKCuRInTYK2vo6jnfIxtyAaL5Zyyvx
         PS3Yd4fpcARBnGUjsAPBdABmoR8oXzk3waScrkhVAVmQeQMmr5BNjzniVq2ofu1ceeSr
         +BjNr3zMiFUCLEI8AWUnE2V1GwJjwOfPM2xFZSJ9znmghofSBaC7iupi5NcHIAPVJYHl
         xuET57Z2xTFStc1TjpnHF5UuwNGwb8r+kKypg2F7gHZ6PmB30Q6m4AReP1r85Yszd2dp
         bBQMACsS+PC5zQH0CxXgOE5IsIXaKSWdfWu4pbM/8+eeWWPWZ308OYNZ14ForH/Ucp0N
         p4lA==
X-Forwarded-Encrypted: i=1; AJvYcCU/Amg+RMfTBncMWI9HW5uE1787RtZxUyMe6Bb08vlWh4+PODa2lsMQRCRZVmgiuB1n215HE0cNN27RU+c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+QUPXbh3ArwxWMvzDfyNwye9oaWgNrf+6Gdr0PAqv3xk377DB
	3COqdxyqQ4TDX80AgLd2LiNSc1fKWq6FIr+YnlbXF4fdym98b3YbAiVC0kl9ZMc=
X-Google-Smtp-Source: AGHT+IFtRi6m8sRVLTuS9OP4yIa7IuuuGeCjTXFidBiPaGoEONxF66FpQDAkwH9cJg21xCXNrz2Y5w==
X-Received: by 2002:a05:6512:138c:b0:52c:9f9e:d8e3 with SMTP id 2adb3069b0e04-536587c5fbfmr3915871e87.31.1725710702961;
        Sat, 07 Sep 2024 05:05:02 -0700 (PDT)
Received: from [192.168.50.4] ([82.78.167.144])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8d258317e1sm64649866b.37.2024.09.07.05.05.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 07 Sep 2024 05:05:02 -0700 (PDT)
Message-ID: <f3e37d0f-fe07-42df-a3cc-948155b76e20@tuxon.dev>
Date: Sat, 7 Sep 2024 15:05:01 +0300
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
 <aeed6b52-98df-4515-a3df-5ccc8429e022@tuxon.dev>
 <20240902-countless-applicant-e726bda10200@thorsis.com>
From: claudiu beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <20240902-countless-applicant-e726bda10200@thorsis.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 02.09.2024 11:08, Alexander Dahl wrote:
> Hello Claudiu,
> 
> Am Sat, Aug 31, 2024 at 06:33:50PM +0300 schrieb claudiu beznea:
>>
>>
>> On 28.08.2024 11:14, Alexander Dahl wrote:
>>> Hello Claudiu,
>>>
>>> Am Sat, Aug 24, 2024 at 06:54:02PM +0300 schrieb claudiu beznea:
>>>>
>>>>
>>>> On 21.08.2024 13:59, Alexander Dahl wrote:
>>>>> According to datasheets DS60001765B for SAMA7G5 and DS60001579G for
>>>>> SAM9X60.
>>>>>
>>>>> Signed-off-by: Alexander Dahl <ada@thorsis.com>
>>>>> ---
>>>>>  drivers/nvmem/microchip-otpc.c | 15 +++++++++++++++
>>>>>  1 file changed, 15 insertions(+)
>>>>>
>>>>> diff --git a/drivers/nvmem/microchip-otpc.c b/drivers/nvmem/microchip-otpc.c
>>>>> index b8ed7412dbca..4630e96243ac 100644
>>>>> --- a/drivers/nvmem/microchip-otpc.c
>>>>> +++ b/drivers/nvmem/microchip-otpc.c
>>>>> @@ -21,9 +21,24 @@
>>>>>  #define MCHP_OTPC_AR			(0x8)
>>>>>  #define MCHP_OTPC_SR			(0xc)
>>>>>  #define MCHP_OTPC_SR_READ		BIT(6)
>>>>> +#define MCHP_OTPC_IER			(0x10)
>>>>> +#define MCHP_OTPC_IDR			(0x14)
>>>>> +#define MCHP_OTPC_IMR			(0x18)
>>>>> +#define MCHP_OTPC_ISR			(0x1C)
>>>>> +#define MCHP_OTPC_ISR_COERR		BIT(13)
>>>>>  #define MCHP_OTPC_HR			(0x20)
>>>>>  #define MCHP_OTPC_HR_SIZE		GENMASK(15, 8)
>>>>>  #define MCHP_OTPC_DR			(0x24)
>>>>> +#define MCHP_OTPC_BAR			(0x30)
>>>>> +#define MCHP_OTPC_CAR			(0x34)
>>>>> +#define MCHP_OTPC_UHC0R			(0x50)
>>>>> +#define MCHP_OTPC_UHC1R			(0x54)
>>>>> +#define MCHP_OTPC_UID0R			(0x60)
>>>>> +#define MCHP_OTPC_UID1R			(0x64)
>>>>> +#define MCHP_OTPC_UID2R			(0x68)
>>>>> +#define MCHP_OTPC_UID3R			(0x6C)
>>>>> +#define MCHP_OTPC_WPMR			(0xE4)
>>>>> +#define MCHP_OTPC_WPSR			(0xE8)
>>>>
>>>> Are all these used in driver?
>>>
>>> Not all, but some.  What are you implying?  Only add register
>>> definitions actually used in the driver? 
>>
>> Yes!
> 
> Okay.
> 
> So if I drop the patch with the warnings on driver probe you did not
> like (checking for pre probe error conditions in interrupt register
> for example), then it is just the MCHP_OTPC_UID0R and I would squash
> that one definition in the last patch adding the nvmem for the UID
> then, okay?

OK for me.

The idea would be to keep just what is used.

Thank you,
Claudiu Beznea

> 
> Greets
> Alex
> 
>>
>>> Why?
>>
>> Less code to maintain. If it's not used there is no meaning to have it.
>>
>>
>>>
>>> Those register offsets won't change, but helped us when debugging.
>>> Debug code (e.g. register dump) is not part of the patch series.
>>>
>>> Greets
>>> Alex
>>>
>>>>
>>>>>  
>>>>>  #define MCHP_OTPC_NAME			"mchp-otpc"
>>>>>  #define MCHP_OTPC_SIZE			(11 * 1024)
>>

