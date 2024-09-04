Return-Path: <linux-kernel+bounces-314422-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D3C096B2F5
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 09:34:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 51F1A1C23D8B
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 07:34:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D09F3146A9F;
	Wed,  4 Sep 2024 07:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="TKi/bj9q"
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D6E313DBB6
	for <linux-kernel@vger.kernel.org>; Wed,  4 Sep 2024 07:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725435235; cv=none; b=SI386qYvJxWAwPumee0C0JFU7I+XUCRkWHC3tWvy35TtS76VXfyKdPUCdT0Sy5fuUs8tByl8woFnRTpGvTPAkk/JCT+P8rjcgK7ZNw2VWe6q9WqyiGowEcrK1Cv+b7G6g6ZXscPZO2OegpqdT1YrW0oZinfE8m8hMrBEaGxWHRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725435235; c=relaxed/simple;
	bh=Ke0SEKANZoASNMdKQWMnB48FavmFqej6lXz7aD+gUs4=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=hNHI0P08yI9unzi+vtPrx7cXEm7sXLvhcyDPiqnzqG+TSmLh4eMgO6ERYpkXlk91+RTaUSLM9MrgIXaT+Q2A42jZVLPTGSnKTkU/QLLiexBpf0ka8Gm1lzdGKlG1b+FW/e6xGunb3cfXTIlZRtE+PBhSeJeGnagDsaPkwDz0o+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=TKi/bj9q; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5bf009cf4c0so6403752a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 04 Sep 2024 00:33:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1725435231; x=1726040031; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kySmQ0NpSqWHNg8+6rJZj9OzeWLaHHajMIIiNyf6JOU=;
        b=TKi/bj9qbKKCBRoqmoxsfD3uj+FIBrZ1DjENNAtrAmVlOLOCqsKkWTEeYvQqdl6a3t
         EXqpXfhLCLP9sKOLOr5w82EbX7mGESYsrzZJ+jzPBbSGKVWr9IBlBh9atvxaS7yHbGK+
         fScj8PahIxUbI5+ztN7MkQvuiKG/aOaDJZ7rAuztFChtqfnyFh51TvyT7TMLTJhTb3uR
         Jzf3GClMN4sq3S4NC4RtG2U/pgi8+NzQPf/jtTbHS2wdbQiBYAp9cybK8MJwKdRuXeZJ
         bIAZTzxfv5LsNuXQTG48ku8sCIuSyudxPrSMEewC6UoKGbyTWeNca9Xg9ze/63WfvVlh
         HUHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725435231; x=1726040031;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kySmQ0NpSqWHNg8+6rJZj9OzeWLaHHajMIIiNyf6JOU=;
        b=abfP17cyub55fX2c0qA9dko9grZODMYX0ZBqMYwivuyVozuFYtuGa4yNlCKtiW4JAl
         H5I128tPqp3/2XwskUykV82luaJU4g4v8p7urvXnAJczrBG8U008Kw9uxX4gmN/wS6l7
         TaIk7jF6s9ghGFmwbZa0nwD7RjAaSW8w0wbdKEXPs09eWwsayICXCQYA/1lbayGbECdH
         BYp/GUp2Mkie1Z7VMKLToE7+CnDbe6d+8VXfdamuf/5erpiZEmfKzR+Xzdxvt4RKCck1
         Zz1wTcCEjk3+n9CsQZG8V69lkItjbre4N3etGujMIATSgkTFRk3Dw3evrsqNeAaHC9pD
         77nA==
X-Forwarded-Encrypted: i=1; AJvYcCXkAc2JfRIY8044iM2nbGVZ8m6/4dwpvF0AMLhW9lE/42ISSOFQyyGvgG02WrDWIAE0/fv/YwYatmLS6Fg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHfP+GyAdNiC6G/5SbgbUjRpizFJK+k2Z712sIjlDpp8hGp3J5
	h9OJotCWtdJGb7+Lbt2xh8fu5kJOCBmJJq7bjAxEcYYsLA2UxwuBlntnm/0wOzI=
X-Google-Smtp-Source: AGHT+IGl05aPVJ2VVVeagU0VruOPFextWHrrfb3lApSLDF6oIkmfcuyVCehiFDjMGW4cA5W88nFnEQ==
X-Received: by 2002:a17:907:9690:b0:a86:78fd:1df0 with SMTP id a640c23a62f3a-a8a32ed8959mr245881866b.34.1725435231164;
        Wed, 04 Sep 2024 00:33:51 -0700 (PDT)
Received: from [192.168.50.4] ([82.78.167.144])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a89891a3dbdsm771648966b.131.2024.09.04.00.33.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Sep 2024 00:33:50 -0700 (PDT)
Message-ID: <6bc72d8a-c7b8-40de-b4c2-0170dde36d33@tuxon.dev>
Date: Wed, 4 Sep 2024 10:33:49 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: get, prepare, enable a clock not in DT?
Content-Language: en-US
To: linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 Nicolas Ferre <nicolas.ferre@microchip.com>
References: <20240816-ludicrous-lagging-65e750c57ab4@thorsis.com>
 <384919bc-7d45-445a-bc85-630c599d43ef@tuxon.dev>
 <20240820-grandpa-down-fec4231f971c@thorsis.com>
 <e7f69aa3-20a7-4233-96c7-0fa5fe67bbdc@tuxon.dev>
 <20240828-gainfully-cringing-2f420d8882bd@thorsis.com>
 <6cd18742-7ba8-4b0c-aff9-7065bccd4095@tuxon.dev>
 <20240902-machinist-straggler-cce44ffa4a7c@thorsis.com>
From: claudiu beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <20240902-machinist-straggler-cce44ffa4a7c@thorsis.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi, Alexander,

On 02.09.2024 11:24, Alexander Dahl wrote:
> Hello Claudiu,
> 
> Am Sat, Aug 31, 2024 at 06:49:59PM +0300 schrieb claudiu beznea:
>> Hi, Alexander,
>>
>> On 28.08.2024 09:55, Alexander Dahl wrote:
>>> Hello Claudiu,
>>>
>>> Am Fri, Aug 23, 2024 at 05:29:44PM +0300 schrieb claudiu beznea:
>>>>
>>>>
>>>> On 20.08.2024 15:17, Alexander Dahl wrote:
>>>>> By chance: I don't have a sama7g5 based board at hand for testing.
>>>>> The datasheet says the same as for sam9x60.
>>>>> Does the nvmem_microchip_otpc driver actually work without timeout on
>>>>> sama7g5?
>>>>
>>>> Yes! This should be because system bus is clocked from MCK0 (as mentioned
>>>> in peripheral identifiers table) which is enabled by bootloader.
>>>
>>> Not sure I can follow.  Citing the SAMA7G5 datasheet section 30.4
>>> (OTPC Product Dependencies):
>>>
>>>     "The OTPC is clocked through the Power Management Controller
>>>     (PMC). The user must power on the main RC oscillator and enable
>>>     the peripheral clock of the OTPC prior to reading or writing the
>>>     OTP memory."
>>
>> I don't see this in [1]. Only:
>>
>> "The OTPC is clocked through the Power Management Controller (PMC), so the
>> programmer must first to configure the PMC."
>>
>> From this I got that it is about the MCK0 listed in table Table 8-11.
>> Peripheral Identifiers.
>>
>> [1]
>> https://ww1.microchip.com/downloads/aemDocuments/documents/MPU32/ProductDocuments/DataSheets/SAMA7G5-Series-Data-Sheet-DS60001765A.pdf
> 
> Well, this seems to be an older version revision A from 03/2022.
> I have DS60001765B (revision B) from 12/2023 and got this here (note
> the missing 'A' in the filename):
> 
> https://ww1.microchip.com/downloads/aemDocuments/documents/MPU32/ProductDocuments/DataSheets/SAMA7G5-Series-Data-Sheet-DS60001765.pdf

This version clearly express your findings. The unknown now is the
"peripheral clock" that need to be enabled along with the
main_rc_oscillator. For that you may want to play around with PMC
Peripheral Control Register, PMC peripheral clock status register and see
if OTPC fails to work when disabling the peripheral clock with the OTPC ID
as there is no information about peripheral clock for OTPC in the
peripheral identifers table.

Hope this helps.

Thank you,
Claudiu Beznea

> 
> Linked here:
> 
> https://www.microchip.com/en-us/product/sama7g54
> 
> The revision history is not very specific, it only says "Updated Power
> Management".  Errata sheet has nothing interesting on that topic.
> 
> We both cited what we saw in the datasheets.  Revision A has the
> section you cited, revision B has the section I cited.
> 
>>> Table from section 8.5 (Peripheral Clocks …) has no check mark at "PMC
>>> clock control" but indeed lists MCK0 as main system bus clock.
>>
>> This is what I was taking about.
>>
>>>  If it
>>> works on SAMA7G5 without explicitly enabling main RC oscillator, then
>>> either that clock is on accidentally, or the datasheet is wrong in the
>>> OTPC section.
>>
>> Might be.
> 
> I don't have a SAMA7G5 at hand.  Someone who has could test if OTPC
> works with/without MCK0, and with/without main RC osc, all possible
> combinations would be most helpful: with none of those, with only one,
> only the other, both.
> 
> Hope we get this clock stuff sorted out?!
> 
> Greets
> Alex
> 
>>
>> Thank you,
>> Claudiu Beznea
>>
>>>
>>> Personally I find the "clocked through PMC" part in the OTPC
>>> section suspicious, because in the peripheral identifiers table OTPC
>>> has no "PMC Clock Control" mark.
>>>
>>> Not sure what's the difference between SAM9X60 and SAMA7G5 internally,
>>> though.  From a user's POV it's possible one of them requires the
>>> main RC osc, and the other does not, but currently you can't tell from
>>> the datasheets.
>>>
>>>> Here is a snapshot of reading the NVMEM on a SAMA7G5 with bootconfig and
>>>> thermal calibration packets:
>>>> https://www.linux4sam.org/bin/view/Linux4SAM/ThermalFaq
>>>
>>> Greets
>>> Alex
>>>
>>

