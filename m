Return-Path: <linux-kernel+bounces-313158-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E286296A11B
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 16:48:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9939C28905A
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 14:48:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A423015AADA;
	Tue,  3 Sep 2024 14:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="rRWyX9YU"
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8C481AACA
	for <linux-kernel@vger.kernel.org>; Tue,  3 Sep 2024 14:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725374904; cv=none; b=D51qsvLw/dE+c4b8Ebs6rMUEaBmUSqLPKZNVtbKYOnDCaPRlJOEIX5j+h7GxVVdcT3ObXw4YmRfSHUr9rdC3fzJjj/inJAKdm95Fce7jRuiHr6g62rLIsSqmvNXqois0Leri0lTEVRU9MOVf0pXzRB18BKdyd/4LFmCF0nIZwVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725374904; c=relaxed/simple;
	bh=sTTEsGQXRaTOXecmyjXOSuS6JlHB333ozxO7Dg7qzYU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=G7zn+368J37dhY+nAxAi1/se/CqEUr2+qlT/Zm70yjh2nu+cORh4wgZAG7ekXAvGBPxM4f+03URqNi7EP56WdN/mucRMSIoKgIJEucEjPvJ84EEqVIwvA76gtCOfLdHhuoWN0pC7E/Y1naREiUCqy5JPhZYvAO8cW5aupB4zwjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=rRWyX9YU; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5c27067b860so635445a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 03 Sep 2024 07:48:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1725374901; x=1725979701; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tYCfjFhT6V80KL60H9R9UPi35bzaxYeuXsMEcnoS+3o=;
        b=rRWyX9YUX9SqwHSnrxuI7oaTaq9MJy7/30elrIJebVrmX1xXCK0Bk1ciQ+ZUAQSFXl
         e/yfO23xhPauPTGKIURfOXBfGV8arNOSRIOpm+/zM/+B9kznKICtYHO3FUid+K23lwy+
         XFhlHTeYfBUJZplag421cG5WLwykwSfLvID0PJRq82oiSY8SagVjiEeFe+nOGsjwZOBv
         DE1DIcJtzNMjjyepyXf3UuEnznw0kwbE/4FZ2rfO1YchcAfo7PPrbe78SqbLR79JWY1+
         rA5t/ziBfmTYO9EyFt+yJpId+kd4SXRkPURRuFGLiC4HHAafCLBexlk7E+E2CIZF//Ee
         4jeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725374901; x=1725979701;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tYCfjFhT6V80KL60H9R9UPi35bzaxYeuXsMEcnoS+3o=;
        b=FC2ne0BYK03IGJKveDL3PUOnO2to2LX/VNzNQPZARpDoK3vbZKQvhJ73dfH3L8I+4h
         2IBZaW6tiqJ8IlUbQnIT/tYD1O4LyACJeTKOz/uTOYGJ5Izl0oGVJ1KnrOsm6G+ICwQw
         CvXu3MeBOzRocos4zXUY7S8mCg4FM8aUhCIA/GXf/OwK+BXOCBHbG+Wm2KjonqfzqTBX
         WE/AvZOm3P1WHCVNx4jykgLuSCno65JxnTEoBmAUITKjFZT7duOrKf0hb/vKNe1KqiLa
         +SP1jQP/J3swjSIIFXr7Bv7Q6NMLhAM4NnqWIcdASMylz4xFblKvepConE19jO8jEGD5
         xg7w==
X-Forwarded-Encrypted: i=1; AJvYcCVgKayXe8nIklRItQqA1RupZdbBvXJpskK5wFebLHnvANlIHHyex0hO+JVYFRYGZBv/xPQ3kVSd2LRBIQo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9xXyhW2cAuVIvxgut8e9JBejK0bNREsg+FUFfMKOvTOGL2Twt
	Dcd1VjYKgfBkbZGcmJTONugRVEGIqgggxWAYY+Gb5t6LQrJhwmEc8jtlq68fADI=
X-Google-Smtp-Source: AGHT+IHbatOQ4VEqyYMrobH7Q1bov/exBOit5pFJyMdS0ZVwH1qUlYUaswymHBX8ZBxtVmsniM7/IA==
X-Received: by 2002:a17:907:980f:b0:a86:7af3:8299 with SMTP id a640c23a62f3a-a8a1d2c8675mr318571466b.25.1725374901005;
        Tue, 03 Sep 2024 07:48:21 -0700 (PDT)
Received: from [192.168.50.4] ([82.78.167.144])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8988feb31fsm702013566b.17.2024.09.03.07.48.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Sep 2024 07:48:20 -0700 (PDT)
Message-ID: <d64243fe-48ea-4cb5-b6d6-e9f820e1b8a3@tuxon.dev>
Date: Tue, 3 Sep 2024 17:48:18 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/16] Add initial USB support for the Renesas RZ/G3S SoC
Content-Language: en-US
To: Biju Das <biju.das.jz@bp.renesas.com>,
 Ulf Hansson <ulf.hansson@linaro.org>
Cc: "vkoul@kernel.org" <vkoul@kernel.org>,
 "kishon@kernel.org" <kishon@kernel.org>, "robh@kernel.org"
 <robh@kernel.org>, "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
 "conor+dt@kernel.org" <conor+dt@kernel.org>,
 "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
 "geert+renesas@glider.be" <geert+renesas@glider.be>,
 "magnus.damm@gmail.com" <magnus.damm@gmail.com>,
 "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
 "mturquette@baylibre.com" <mturquette@baylibre.com>,
 "sboyd@kernel.org" <sboyd@kernel.org>,
 Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
 "linux-phy@lists.infradead.org" <linux-phy@lists.infradead.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>,
 "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
 "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
 Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
References: <20240822152801.602318-1-claudiu.beznea.uj@bp.renesas.com>
 <TY3PR01MB11346505565B81AD2894E035586922@TY3PR01MB11346.jpnprd01.prod.outlook.com>
 <35dc7414-f5bd-4ed4-bfa1-f723f4f0078c@tuxon.dev>
 <TY3PR01MB11346A4814F83FE296A1DED8886922@TY3PR01MB11346.jpnprd01.prod.outlook.com>
 <TY3PR01MB1134648BF51F1B52BFE34DD6D86932@TY3PR01MB11346.jpnprd01.prod.outlook.com>
 <fbfa9179-2f52-429f-8b69-f7f4064e796b@tuxon.dev>
 <TYCPR01MB11332EF1A8D064C491D8F261286932@TYCPR01MB11332.jpnprd01.prod.outlook.com>
 <f7c57e76-b890-491f-880d-62d060b7b31e@tuxon.dev>
 <TYCPR01MB11332BE2EDB318950B9C7B54C86932@TYCPR01MB11332.jpnprd01.prod.outlook.com>
 <TY3PR01MB113469FC8A9F49D9B1FA432FD86932@TY3PR01MB11346.jpnprd01.prod.outlook.com>
 <0b73544b-0253-43b9-b631-6578b48eaca8@tuxon.dev>
 <TY3PR01MB1134689573A785E91A9041E1886932@TY3PR01MB11346.jpnprd01.prod.outlook.com>
 <5bcdc677-e61e-4312-a19b-57b4600685d3@tuxon.dev>
 <TY3PR01MB1134690F9D37E3BB4814D864386932@TY3PR01MB11346.jpnprd01.prod.outlook.com>
From: claudiu beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <TY3PR01MB1134690F9D37E3BB4814D864386932@TY3PR01MB11346.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 03.09.2024 16:45, Biju Das wrote:
> Hi Claudiu,
> 
>> -----Original Message-----
>> From: claudiu beznea <claudiu.beznea@tuxon.dev>
>> Sent: Tuesday, September 3, 2024 1:57 PM
>> Subject: Re: [PATCH 00/16] Add initial USB support for the Renesas RZ/G3S SoC
>>
>>
>>
>> On 03.09.2024 15:37, Biju Das wrote:
>>>
>>>
>>>> -----Original Message-----
>>>> From: claudiu beznea <claudiu.beznea@tuxon.dev>
>>>> Sent: Tuesday, September 3, 2024 1:26 PM
>>>> To: Biju Das <biju.das.jz@bp.renesas.com>; Ulf Hansson
>>>> <ulf.hansson@linaro.org>
>>>> Cc: vkoul@kernel.org; kishon@kernel.org; robh@kernel.org;
>>>> krzk+dt@kernel.org; conor+dt@kernel.org; p.zabel@pengutronix.de;
>>>> geert+renesas@glider.be; magnus.damm@gmail.com;
>>>> gregkh@linuxfoundation.org; mturquette@baylibre.com;
>>>> sboyd@kernel.org; Yoshihiro Shimoda
>>>> <yoshihiro.shimoda.uh@renesas.com>;
>>>> linux-phy@lists.infradead.org; devicetree@vger.kernel.org;
>>>> linux-kernel@vger.kernel.org; linux- renesas-soc@vger.kernel.org;
>>>> linux-usb@vger.kernel.org; linux-arm-kernel@lists.infradead.org;
>>>> linux- clk@vger.kernel.org; linux-pm@vger.kernel.org; Claudiu Beznea
>>>> <claudiu.beznea.uj@bp.renesas.com>
>>>> Subject: Re: [PATCH 00/16] Add initial USB support for the Renesas
>>>> RZ/G3S SoC
>>>>
>>>>
>>>>
>>>> On 03.09.2024 15:00, Biju Das wrote:
>>>>>
>>>>>
>>>>>> -----Original Message-----
>>>>>> From: Biju Das <biju.das.jz@bp.renesas.com>
>>>>>> Sent: Tuesday, September 3, 2024 12:07 PM
>>>>>> To: Claudiu.Beznea <claudiu.beznea@tuxon.dev>; Ulf Hansson
>>>>>> <ulf.hansson@linaro.org>
>>>>>> Cc: vkoul@kernel.org; kishon@kernel.org; robh@kernel.org;
>>>>>> krzk+dt@kernel.org; conor+dt@kernel.org; p.zabel@pengutronix.de;
>>>>>> geert+renesas@glider.be; magnus.damm@gmail.com;
>>>>>> gregkh@linuxfoundation.org; mturquette@baylibre.com;
>>>>>> sboyd@kernel.org; Yoshihiro Shimoda
>>>>>> <yoshihiro.shimoda.uh@renesas.com>;
>>>>>> linux-phy@lists.infradead.org; devicetree@vger.kernel.org;
>>>>>> linux-kernel@vger.kernel.org; linux- renesas-soc@vger.kernel.org;
>>>>>> linux-usb@vger.kernel.org; linux-arm-kernel@lists.infradead.org;
>>>>>> linux- clk@vger.kernel.org; linux-pm@vger.kernel.org; Claudiu
>>>>>> Beznea <claudiu.beznea.uj@bp.renesas.com>
>>>>>> Subject: RE: [PATCH 00/16] Add initial USB support for the Renesas
>>>>>> RZ/G3S SoC
>>>>>>
>>>>>> Hi Claudiu,
>>>>>>
>>>>>>> -----Original Message-----
>>>>>>> From: claudiu beznea <claudiu.beznea@tuxon.dev>
>>>>>>> Sent: Tuesday, September 3, 2024 12:00 PM
>>>>>>> Subject: Re: [PATCH 00/16] Add initial USB support for the Renesas
>>>>>>> RZ/G3S SoC
>>>>>>>
>>>>>>>
>>>>>>>
>>>>>>> On 03.09.2024 13:31, Biju Das wrote:
>>>>>>>>>> During boot clr USB PWR READY signal in TF-A.
>>>>>>>>>> STR case, suspend set USB PWR READY signal in TF-A.
>>>>>>>>>> STR case, resume clr USB PWR READY signal in TF-A.
>>>>>>>>> As I said previously, it can be done in different ways. My point
>>>>>>>>> was to let Linux set what it needs for all it's devices to work.
>>>>>>>>> I think the way to go forward is a
>>>>>>> maintainer decision.
>>>>>>>>
>>>>>>>> I agree, there can be n number of solution for a problem.
>>>>>>>>
>>>>>>>> Since you modelled system state signal (USB PWRRDY) as reset
>>>>>>>> control signal, it is reset/DT maintainer's decision to say the
>>>>>>>> final word whether this signal fits in reset
>>>>>>> system framework or not?
>>>>>>>
>>>>>>> I was thinking:
>>>>>>> 1/ Geert would be the best to say if he considers it OK to handle this
>>>>>>>    in Linux
>>>>>>
>>>>>> I agree Geert is the right person for taking SYSTEM decisions,
>>>>>> since the signal is used only during state transitions (Table
>>>>>> 41.6.4 AWO to ALL_ON and 41.6.3 ALL_ON to AWO)
>>>>>
>>>>> One more info, as per [1], this USB PWRRDY signal setting to be before Linux kernel boots.
>>>>
>>>> The "controlled by" column mentions CA-55 on PWRRDY signal control
>>>> line and it is b/w steps "DDR exits from retention mode" and  "clock
>>>> start settings for system bus and peripheral modules". AFAICT, after DDR exists retention mode
>> Linux is ready to run.
>>>
>>> DDR retention exit happens in TF-A and it jumps into reset code where it executes BL2 in TF_A. Bl2
>> checks for warm or cold reset.
>>> If it is warm reset, it sets required minimal clocks/resets and pass
>>> the control to linux by calling the SMC callback handler. Which in turn calls resume(step 11-->14)
>> path.
>>
>> Is this from HW manual or some specific documentation? I'm referring at "resume" == "steps 11-->14"
>>
>>>
>>> Step 8, Cortex-A55 Exit from DDR retention mode (when using) Setting
>>> for exiting form DDR retention mode Step 9, Cortex-A55 USB PHY PWRRDY
>>> signal control (if use USB) SYS_USB_PWRRDY Step 10, Cortex-A55 PCIe
>>> RST_RSM_B signal control (if use PCIe) SYS_PCIE_RST_RSM_B
>>
>> Note *if use*: how does the TF-A know if USB/PCIe is used by Linux? The documentation mention to set
>> it *if use*. Same note is on ALL_ON to VBATT transition documentation (namely "if using USB", "if
>> using PCIe"). If TF-A will do this it should set this signals unconditionally. It will not be
>> something wrong though. We don't know at the moment what this involves in terms of power consumption,
>> if it means something...
> 
> IIUC,
> The only information we have is,
> 
> "SYS_USB_PWRRDY and SYS_PCIE_RST_RSM_B are used when transition from ALL_ON to AWO (or from AWO to ALL_ON).
> "When turning off USB PHY and PCIe PHY, if they are not controlled, PHY may break"
> 
> ALL_ON to AWO_MODE state transition: 
> USB/PCIe are part of PD_ISOVCC power domain and before turning PD_ISOVCC to off,
> we need to set USBPWRRDY signal.
> 
> AWO_MODE to ALL_ON state transition:
> 
> Turn on PD_ISOVCC first, then clr USBPWRRDY signal for USB usage in linux.
> 
> Maybe we need to ask hw team, exact usage of USBPWRRDY signal other than state transition.

As you may already know, this is open for quite some time and is ongoing.

> 
> Cheers,
> Biju
> 
> 

