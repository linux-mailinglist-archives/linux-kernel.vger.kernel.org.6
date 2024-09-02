Return-Path: <linux-kernel+bounces-310874-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 409FC968256
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 10:47:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A1F76B2117E
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 08:47:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5985156885;
	Mon,  2 Sep 2024 08:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="JOwaJQa7"
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6901F12EBEA
	for <linux-kernel@vger.kernel.org>; Mon,  2 Sep 2024 08:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725266851; cv=none; b=YHM+I27LPTBwKsMWiy4SwJYiQNknnoIciisZtgo+912fA70FSVolKYgot3uAR9JTFf/kMfGE8Hd+mrBivt7dkO64skJARwAoo/uAGSy6ryrO/w0LYGVPcJgG3JFjkJiSoZ3b7n25yPswVoNzLKWZ+NbtIuTYyN6qdrhSkjgf2ig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725266851; c=relaxed/simple;
	bh=N2g00tuABoBPM0sSD+eLbo4vma8qIxTBQwjDX+kBOwY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=a892ISQS5wYIjKgX85BohopvhdxY4GAlz/Dj8Nec0cj9EAMjk21PxS1tEgIrj2JGe1CO3mGAnGrkCTt9VlqAwP+wkRv8sKh90h/1DF4wMG8oomfDP6wmVNxk3szvxtICcmiyTwirQM+qUcYdDo60AjIt6g9OLhxkTJFFYTVy8w8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=JOwaJQa7; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-5334c018913so3659925e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 02 Sep 2024 01:47:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1725266847; x=1725871647; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oOaSphN4uqIVyGx4/lf/Z0TMBGuenM0C4nTClydRFg4=;
        b=JOwaJQa7oe0E2nuM/9p9QTTllF4o7QC8SPrdiGTm4A+0CzJpTWjOtKcgg49SsjD0NB
         ZZk4IR6JDv7Ejtx8dnfzr3At5DycGmJBoy1SylS/VZchjiIiN63oUWCnsBMQNA8bOmIT
         ZEBWsWWKCceWaPlHSgfuN2bKTYMd4sEtaR94p3uE2Mdzv97Z8CKtgkR3AEd0vZVZpS2b
         VkOiWUOoQtQOl96pQt/+J/q41Hbzis5CI3JJU60XId8GBHw77SoTRZ87KCgRR1DDAgUS
         IT1M6AdUGpj+8/6kzRbllNIdfTBH/N1b1a78rWKDzzH/n5C2+d97GNUBAwx49CrrJjXE
         KGxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725266847; x=1725871647;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oOaSphN4uqIVyGx4/lf/Z0TMBGuenM0C4nTClydRFg4=;
        b=s+P7hbOpv9zWyz8NvjJMf9JzdHuqza0L8ZCkQ25OQf0ShqKJZKjg26TpkB+uZBFK5/
         EJEBZ4WHxsq6+nW4D02hPrWMIAx8VLl6un2emnDEv1Dv63SgXgYsNzqXZnFTaq1V6Q5F
         w5eQwcIYkv3Ia/Gq+Cy6C6P/3Ho0i/ig2Tb9jmtE0ZGuM06n+FZOKB7eiwnzbzvGgsg5
         p/EQndRBsidfLbcEe0Ft6nwndLnjMqHsnl7NudQAg0zg4l2nYeGl57Vf8BsBarJF65ZY
         NLXW71TOATRueGKyhFPZa5zD5YRfDRMer1pWHwX80lwisNIslOsQhI1ZuKKe2SxgFliM
         jPhw==
X-Forwarded-Encrypted: i=1; AJvYcCWqmEtqy7T7QU7tw6e1jaTJcQfeHOUnJb0RY51p2q3Ki9QPhvdARnRUiESCZkfaIqUcDOD2Hz1AejzLDY8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4dfhgZ070eaXIT8XqX5oJzDqiT7O8KdyyV5rwuh1VapPbA20P
	eMNYPIup5n2aBI+s8B8nE7VsMQAQVqrnqWyTtkAkjdT+6T2NW+WuQGwDwFqcOl0=
X-Google-Smtp-Source: AGHT+IFKP+TMYUf8hSyMMTGOziIULq1HvfnDIOTbDSCryKJ5amdlOmDWug+wIx0ZuZ/E3sdbRQoVKA==
X-Received: by 2002:a05:6512:15a5:b0:52e:9e70:d068 with SMTP id 2adb3069b0e04-53546afad74mr5564997e87.4.1725266847009;
        Mon, 02 Sep 2024 01:47:27 -0700 (PDT)
Received: from [192.168.50.4] ([82.78.167.144])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8988fef4c3sm525445666b.32.2024.09.02.01.47.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Sep 2024 01:47:26 -0700 (PDT)
Message-ID: <5556d176-cca7-492c-ba21-48256d5d6338@tuxon.dev>
Date: Mon, 2 Sep 2024 11:47:24 +0300
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
 <CAPDyKFrS4Dhd7DZa2zz=oPro1TiTJFix0awzzzp8Qatm-8Z2Ug@mail.gmail.com>
 <99bef301-9f6c-4797-b47e-c83e56dfbda9@tuxon.dev>
 <TY3PR01MB1134652F9587CFA0ADE851CA486902@TY3PR01MB11346.jpnprd01.prod.outlook.com>
 <TY3PR01MB113467275C519B729FCAB1ACB86922@TY3PR01MB11346.jpnprd01.prod.outlook.com>
From: claudiu beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <TY3PR01MB113467275C519B729FCAB1ACB86922@TY3PR01MB11346.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi, Biju,

On 02.09.2024 10:54, Biju Das wrote:
> Hi Claudiu,
> 
>> -----Original Message-----
>> From: Biju Das
>> Sent: Saturday, August 31, 2024 6:14 AM
>> Subject: RE: [PATCH 00/16] Add initial USB support for the Renesas RZ/G3S SoC
>>
>> Hi Claudiu,
>>
>>> -----Original Message-----
>>> From: claudiu beznea <claudiu.beznea@tuxon.dev>
>>> Sent: Friday, August 30, 2024 9:23 AM
>>> Subject: Re: [PATCH 00/16] Add initial USB support for the Renesas
>>> RZ/G3S SoC
>>>
>>> Hi, Ulf,
>>>
>>> On 29.08.2024 18:26, Ulf Hansson wrote:
>>>> On Thu, 22 Aug 2024 at 17:28, Claudiu <claudiu.beznea@tuxon.dev> wrote:
>>>>>
>>>>> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>>>>>
>>>>> Hi,
>>>>>
>>>>> Series adds initial USB support for the Renesas RZ/G3S SoC.
>>>>>
>>>>> Series is split as follows:
>>>>>
>>>>> - patch 01/16           - add clock reset and power domain support for USB
>>>>> - patch 02-04/16        - add reset control support for a USB signal
>>>>>                           that need to be controlled before/after
>>>>>                           the power to USB area is turned on/off.
>>>>>
>>>>>                           Philipp, Ulf, Geert, all,
>>>>>
>>>>>                           I detailed my approach for this in patch
>>>>>                           04/16, please have a look and let me know
>>>>>                           your input.
>>>>
>>>> I have looked briefly. Your suggested approach may work, but I have
>>>> a few thoughts, see below.
>>>>
>>>> If I understand correctly, it is the consumer driver for the device
>>>> that is attached to the USB power domain that becomes responsible
>>>> for asserting/de-asserting this new signal. Right?
>>>
>>> Right!
>>>
>>>>
>>>> In this regard, please note that the consumer driver doesn't really
>>>> know when the power domain really gets powered-on/off. Calling
>>>> pm_runtime_get|put*() is dealing with the reference counting. For
>>>> example, a call to pm_runtime_get*() just makes sure that the PM
>>>> domain gets-or-remains powered-on. Could this be a problem from the
>>>> reset-signal point of view?
>>>
>>> It should be safe. From the HW manual I understand the hardware block is something like the
>> following:
>>>
>>>
>>>                   USB area
>>>          +-------------------------+
>>>          |                         |
>>>          | PHY --->USB controller  |
>>> SYSC --> |  ^                      |
>>>          |  |                      |
>>>          | PHY reset               |
>>>          +-------------------------+
>>
>> How USB PWRRDY signal is connected to USB?
>>
>> USB block consists of PHY control, PHY, USB HOST and USB OTG Controller IPs.
>>
>> Is it connected to top level block or connected to each IP's for turning off the USB region power?
>>
>> ? Or Just PHY (HW manual mentions for AWO, the USB PWRRDY signal->USB PHY PWRRDY signal control)?
> 
> As per the update from HW team,
> 
> "SYS_USB_PWRRDY and SYS_PCIE_RST_RSM_B are used when transition from ALL_ON to AWO (or from AWO to ALL_ON).
> 
> Refer to step 8,9 in Table 41.10 Example Transition Flow Outline from ALL_ON Mode to AWO Mode.
> Refer to step 9,10 in Table 41.11 Example Transition Flow Outline from AWO Mode to ALL_ON Mode.

All this is not new information.

From experiments, we need to control these signals also when booting as
intermediary booting application may control and leave it in improper
state. W/o having SYSC signals configured properly there is no chance for
USB to work (it should be the same for PCIe but I haven't explored it yet).

> 
> When turning off USB PHY and PCIe PHY, if they are not controlled, PHY may break."

From experiments, I know this, as this is the reason the SYSC USB PWRRDY
has been implemented in Linux and proposed in this series.

> 
> Do you have any plan to control this power transitions(ALL_ON to AWO and vice versa) in linux? 

As you know, the RZ/G3S USB PM code is already prepared. This is also
configuring these signals when going to suspend/exiting from resume. W/o
configuring properly these signals the USB is not working after a
suspend/resume cycle.

Thank you,
Claudiu Beznea


> Cheers,
> Biju
>  

