Return-Path: <linux-kernel+bounces-299102-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B37995D025
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 16:39:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 50ED0B2D1AC
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 14:37:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95A9A189529;
	Fri, 23 Aug 2024 14:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="MxRsSXME"
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADFA118893E
	for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 14:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724423391; cv=none; b=jmWXuojv/TrO7SLUN5sEMpqnldeYdMtFg5aT6AEcx7BkQo4218CPFr0vBqRa+fCPG8t8DpKdj1dNnfv36qH02oOSAHB2yyhljpJqHUL0L0rlI4tPMTGoDN15VTLZF1yxiUWu7KkYhYI4MnKl8Fd935VIMxeICX2ShpCKUuK2vFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724423391; c=relaxed/simple;
	bh=SH9B0BL7uLt6tcnM1VBpTcnkgyiGTIFb0iTtXovs0F8=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=ZCktQHB0nwK9M4qJd2h9yhbPqdtyAJWn7xp/sHe0RtTbs36A4NV3J9QCuuhNZmbvvgf4OHFeObqSilUoEs7sXuqYcd3OpuaHzzYizPdqi8XKZsFSdpVrAxupMSl+KcbPOy0yk8tdJdrgW3ZTG+3SQG/vhethlglgf90evHPHcRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=MxRsSXME; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2ef2c56d9dcso19494021fa.2
        for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 07:29:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1724423387; x=1725028187; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DIB0c+jAUWDPXd2QD2p4fPNNQNtlM220AtDEZkMw744=;
        b=MxRsSXMEerqIt434qycs5BT04tKTYPphTapugcJypdWcrtzGunz2EUYQAUe2rLPBTy
         Y8q7Oce1vfUbjQNTTjFCRbTJ/W/icvV/FeQtrYYIzV33wA28WPCpK51XzlsABCXLuyF0
         EPYg28bBOJZOgjS3EO6pWJNFyGtVG4t8hrdZuDlB9JzELDiANgEPH7SBM47s4/IRHc0R
         +2AYGL+kC0MReC0dxaUgklw/IrzZxYEPP47Aew8/poEFsO45JAQTq/dH2R0FShCnHCuZ
         TBYgPNmEbIv02cXDD+LJfFZDmx/Uy6xJusubJL7S5MgvPacg6pSOu6kIj45ZXVv0kOH0
         Mxag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724423387; x=1725028187;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DIB0c+jAUWDPXd2QD2p4fPNNQNtlM220AtDEZkMw744=;
        b=f4QYGR5QBJAmghpGw1FJ3cqra2MuHR8ch66I4d3WwoJ9wYPXt+v3DLazcen1xiR2Rq
         Zns81yAak6o5QAlDiDcAcJI3CqDtxjmxi1fmtTs7Zt1pAj4zYsjhueBYnz12jE0ogc5l
         XzBy9pjf8l92n0VxZhIJuk5xS5ajy91d0pIS4485xAe9Tc8tX3PBM2D+cY4uTRJyae4P
         ipp4VAJbYkKclIvIJRH30VmPUaElq2NCyxuFr31muN+DXL5/sNl0OpX5oGBZocos7uXz
         jY7EeA/8w4NynTL3yX87iWtxRPZO9i8ZWw2WfXTosOF9MhSTPkZk2dwoJB7YuZ72qDRQ
         12rQ==
X-Forwarded-Encrypted: i=1; AJvYcCU+X7/bEjs1AZcUo5pBtYaxwo/I49uJiBklZPt+YuyF6x7rnb1NRVRM3Qn6eZwpay4SA/oBmSbicmEznYI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyoDYRwVQBTi268SmjRyS2WxuV+8qiMxDhY5KNcL6hhy0TolFAf
	FAt2L9etHUmlGwt3RzNz3g5D8JCI9xVwPkFvwv3LxkhIN+MSGxCxUKLIdM8L3Ob2MdEFrpN40mo
	q
X-Google-Smtp-Source: AGHT+IHYpZtJVH6Prfq+WLMWjdpDo7o54QqLVKRGeNhWCbFAyaehg6FYfiCh8d9nmrlXwYyq9Ve76g==
X-Received: by 2002:a2e:b555:0:b0:2ef:24a0:c176 with SMTP id 38308e7fff4ca-2f4f4916fd1mr18707381fa.28.1724423386214;
        Fri, 23 Aug 2024 07:29:46 -0700 (PDT)
Received: from [192.168.50.4] ([82.78.167.177])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c04a4c438fsm2147233a12.61.2024.08.23.07.29.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Aug 2024 07:29:45 -0700 (PDT)
Message-ID: <e7f69aa3-20a7-4233-96c7-0fa5fe67bbdc@tuxon.dev>
Date: Fri, 23 Aug 2024 17:29:44 +0300
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
 linux-arm-kernel@lists.infradead.org
References: <20240816-ludicrous-lagging-65e750c57ab4@thorsis.com>
 <384919bc-7d45-445a-bc85-630c599d43ef@tuxon.dev>
 <20240820-grandpa-down-fec4231f971c@thorsis.com>
From: claudiu beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <20240820-grandpa-down-fec4231f971c@thorsis.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 20.08.2024 15:17, Alexander Dahl wrote:
> Hello Claudiu,
> 
> Am Tue, Aug 20, 2024 at 02:54:59PM +0300 schrieb claudiu beznea:
>> Hi, Alexander,
>>
>> On 16.08.2024 17:34, Alexander Dahl wrote:
>>> Hello everyone,
>>>
>>> while further investigating timeout issues with the at91 otpc
>>> controller on sam9x60 [1] I came to the conclusion the main RC
>>> oscillator on that SoC must be enabled for that driver to work.
>>
>> Not sure how that works (unless undocumented) as figure Figure 28-1. Clock
>> Generator Block Diagram from [1] states that main_rc_osc feeds only the mainck.
> 
> It can feed the main clock and you're right from Clock Generator POV.
> However it is not completely undocumented.  Section "23.4 Product
> Dependencies" of the SAM9X60 datasheet (DS60001579G) says:
> 
>     "The OTPC is clocked through the Power Management Controller (PMC).
>     The user must power on the main RC oscillator and enable the
>     peripheral clock of the OTPC prior to reading or writing the OTP
>     memory."
> 
> Apparently this also applies to reading, at least according to my
> tests on sam9x60-curiosity.
> 
> btw, the last public release of the atmel-software-package, source for
> the sam-ba applets, also enables that clock, although the reasoning
> was for writing. [1]
> 
>> Also, Table 9-1. Peripheral Identifiers from [1] say that there is no clock
>> control for OTCP on the PMC side.
>>
>> [1]
>> https://ww1.microchip.com/downloads/aemDocuments/documents/MPU32/ProductDocuments/DataSheets/SAM9X60-Data-Sheet-DS60001579.pdf
> 
> You're right from the datasheet POV.  Not sure if the datasheet is
> right here?  It's not complete in some register contents anyway, maybe
> some things are kept confidential, and OTPC is part of that?
> 
> Maybe someone can confirm my findings on sam9x60-curiosity, e.g.
> after I sent a patch series with what I consider fixes for this topic?
> 
>>> (Verified that by poking single bits in registers through devmem
>>> already.)
>>>
>>> Fortunately the necessary clk is already registered from the SoC code
>>> in drivers/clk/at91/sam9x60.c [2] and I can see the clock in sysfs clk
>>> summary:
>>>
>>>     root@DistroKit:~ head -n4 /sys/kernel/debug/clk/clk_summary 
>>>                                      enable  prepare  protect                                duty  hardware                            connection
>>>        clock                          count    count    count        rate   accuracy phase  cycle    enable   consumer                         id
>>>     ---------------------------------------------------------------------------------------------------------------------------------------------
>>>      main_rc_osc                         0       0        0        12000000    50000000   0     50000      Y   deviceless                      no_connection_id         
>>>
>>> That clock has no parent and is not found anywhere in devicetree, nor
>>> is it handled by the two clock-producers on that platform, so
>>> from within mchp_otpc_probe() I just tried this:
>>>
>>>     otpc->clk = devm_clk_get_enabled(&pdev->dev, "main_rc_osc");
>>
>>>
>>> However that returns with -ENOENT, so I assume I can not reference the
>>> clock just by name?  Same result with this:
>>>
>>>     otpc->clk = devm_clk_get_enabled(NULL, "main_rc_osc");
>>>
>>> How do I get a pointer to that clk then to enable it?  Docs [3] where
>>
>> To expose it though DT you may want to save its hw object to one array
>> entry in sam9x60_pmc, sam9x60_pmc->chws[] fits best for this atm.
> 
> Great to see I came to the same conclusion.  I have a proof-of-concept
> working meanwhile, will send a patch series later this week I guess.
> 
> Thanks for your support.
> 
>> Otherwise, you can try to register the main_rc_osc with CLK_IS_CRITICAL for
>> simple trials.
> 
> Don't think that is necessary anymore. :-)
> 
> By chance: I don't have a sama7g5 based board at hand for testing.
> The datasheet says the same as for sam9x60.
> Does the nvmem_microchip_otpc driver actually work without timeout on
> sama7g5?

Yes! This should be because system bus is clocked from MCK0 (as mentioned
in peripheral identifiers table) which is enabled by bootloader.

Here is a snapshot of reading the NVMEM on a SAMA7G5 with bootconfig and
thermal calibration packets:
https://www.linux4sam.org/bin/view/Linux4SAM/ThermalFaq

> 
> Greets
> Alex
> 
>>
>> Thank you,
>> Claudiu Beznea
>>
>>> not as useful as I hoped for, neither was clk.h header docs. :-/
>>>
>>> From what I understood from header docs reading 'device for clock
>>> "consumer"' I must pass the device from which I call that clk_get() as
>>> first parameter, so this would be the otpc device then, right?  What's
>>> that second parameter clock consumer id then?  Are these terms
>>> explained somewhere?
>>>
>>> Greets
>>> Alex
>>>
>>> [1] <20240813-payable-ecology-8a9e739704bb@thorsis.com>
>>> [2] https://elixir.bootlin.com/linux/v6.10.4/source/drivers/clk/at91/sam9x60.c#L217
>>> [3] https://kernel.org/doc/html/latest/driver-api/clk.html
>>>
>>

