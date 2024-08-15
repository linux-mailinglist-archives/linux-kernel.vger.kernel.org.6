Return-Path: <linux-kernel+bounces-287557-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 97716952932
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 08:07:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B08E3B22859
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 06:07:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 307DD176ACA;
	Thu, 15 Aug 2024 06:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jw8F5GOk"
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C335038DC8;
	Thu, 15 Aug 2024 06:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723702053; cv=none; b=li1bssKb3+JcpY+g/kgB/h2Y0eiLkHhOGtqrp4W6kFasrKPqWbnd5ZRboP2Nreq1P0vDOp6sxQheQK+SjAZf7Ig2t+ocFswrlXEgX1UNJivnVSjCsOqw7sVaKluwYhnR45/2wfFVUlEmoibMshRYoMOaLx2kE0crzp2MzPAs7ws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723702053; c=relaxed/simple;
	bh=PFJbY9QxyJb7XD4KnUPRq++45YKSxQjoOOINOoNW/1s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QQ3JoEDSdqSpxv5lK+GStpKhZG5MLXoQW4opXXOFDji9hkH0ztIpfTaNMGSeT+jPEijIMIpTTcDQj1Wq+PuWolWo1qkMh2a0BRCzFMbPTG2Qz/wIeFtbQlhvVvR0FI/MYYs7UHIgRiuIFV9dJBw6J43Ion7ybZIum46PFZNd2LM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jw8F5GOk; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2f189a2a841so5518021fa.3;
        Wed, 14 Aug 2024 23:07:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723702049; x=1724306849; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UN5Jya+bU5edlI+PXQKJHx7XpQB+ZJik6Qvqm1dVNgw=;
        b=Jw8F5GOkfgWjeW6DQmy2OZe7sVH+mK4iQeQKXuO8QLk4mU2OS+f7rFLhCXFSlcDfui
         o08uQQbBRPRHOgMDIsmSTGYiYibMuYm6AZSn10D8mB/uU2J03nDDOWOPTfsZNuIqy1PD
         HaVa1YoJdU0WuLabdKD5Bjx3lOCo/ESFEaU+7KAxH+nPMVyrPJO3tDe9MdkIag8ckGtY
         tVSSh4N8kWOsX2dgpO5YFIhTbF/hQ/Cfg6QtKYtqIUW2LwSMFe5ZM9pW9XQ65lYmar9c
         rtHJyk1rbIpdmIcIOIe43mQUCrFyI4xgpDtbD9UV8OBPQ7DP/z60CdFJ8uAMsJfXXDjA
         /QKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723702049; x=1724306849;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UN5Jya+bU5edlI+PXQKJHx7XpQB+ZJik6Qvqm1dVNgw=;
        b=eik6cXyLmyYRvr6j0bi7lnIIvjAwM9/kSMsLvo0sAyQytDTfMWivEEoRJ3WHBVsFzo
         JrJAPRs+7z1hDR2Up7Ua5qLVCkZcbCnakabAeRhqy42WfLV3RiRU7jCOzhWsK2fw2sat
         Vim/9hQrLDhyHAiSux57VSdP1L/oTspb4ExKVGSD/K2szCQtl+eiilggtNXAxEudo/Le
         r1tN5rq5uX2rR7Cp0E1MrHhGSJNQ0nAfNW36c4x02TOtWNJXRE5x7hMtpATfK4PeW8FQ
         9jCZMw027wIbrXKV9ENBkgUQhV/3bFLtXMA4Mb5GMb/f834QoRScSntMPpaRbcPiNSeC
         KtCw==
X-Forwarded-Encrypted: i=1; AJvYcCUEJ/rtwt+uRRRTboRyZtbK8X87+CVT7iEA5+0/zBg0DgV8IfOqTgChc8kBqwGv6lSoZQy1L7995gzAZnnOfK8JXBqDdw87S8h+fxTOXRhSXoqB7N/xCinSfotSKknfJn23uYf37G43
X-Gm-Message-State: AOJu0YxE/GhqrjVa+10YocHYfXy0CLqZi0dEZtVW6zo6arg8kSm/Nm54
	/AW22d21seZBLOBHA2Sue8nYE1fqHdVQEUg5uMRHB7j6cHSJ6k/f
X-Google-Smtp-Source: AGHT+IG6OfSRhlLQ72gK8wu3bsFy8k8fYy6wk5RgBRZ4o44OVQdUrPFDC6xwajVvEPZa7Dehfmzd5w==
X-Received: by 2002:a2e:3003:0:b0:2ef:2685:177d with SMTP id 38308e7fff4ca-2f3aa1f1bb2mr31167161fa.20.1723702048207;
        Wed, 14 Aug 2024 23:07:28 -0700 (PDT)
Received: from ?IPV6:2a10:a5c0:800d:dd00:8cfe:d6e7:6701:9dfd? ([2a10:a5c0:800d:dd00:8cfe:d6e7:6701:9dfd])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2f3b748dd43sm999051fa.49.2024.08.14.23.07.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Aug 2024 23:07:27 -0700 (PDT)
Message-ID: <22f3c925-309f-4ebe-a481-2553cfa71c0c@gmail.com>
Date: Thu, 15 Aug 2024 09:07:25 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 2/3] clk: bd718x7: Enable the possibility to mark the
 clock as critical
To: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Cc: Michael Turquette <mturquette@baylibre.com>,
 Stephen Boyd <sboyd@kernel.org>,
 "open list:COMMON CLK FRAMEWORK" <linux-clk@vger.kernel.org>,
 open list <linux-kernel@vger.kernel.org>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 linux-amarula@amarulasolutions.com, Marek Vasut <marex@denx.de>
References: <20220605165703.1565234-1-michael@amarulasolutions.com>
 <20220605165703.1565234-3-michael@amarulasolutions.com>
 <5f34b6d6-c2dd-44f9-c1bc-fe1deb336334@gmail.com>
 <CAOf5uwm3p5AJXL9w7hQtqz05hDpQ_-CQArm0z6kAehj7OxK1Mw@mail.gmail.com>
Content-Language: en-US, en-GB
From: Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <CAOf5uwm3p5AJXL9w7hQtqz05hDpQ_-CQArm0z6kAehj7OxK1Mw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 8/14/24 19:00, Michael Nazzareno Trimarchi wrote:
> Hi Stephen
> 
> On Mon, Jun 6, 2022 at 7:26 AM Matti Vaittinen <mazziesaccount@gmail.com> wrote:
>>
>> Hi Michael,
>>
>> On 6/5/22 19:57, Michael Trimarchi wrote:
>>> If the clock is used to generate the osc_32k, we need to mark
>>> as critical. clock-critical has no binding description at the moment
>>> but it's defined in linux kernel
>>>
>>> bd71847: pmic@4b {
>>> ...
>>>        rohm,reset-snvs-powered;
>>>
>>>        #clock-cells = <0>;
>>>        clock-critical = <1>;
>>>        clocks = <&osc_32k 0>;
>>>        clock-output-names = "clk-32k-out";
>>> ...
>>> }
>>>
>>> Signed-off-by: Michael Trimarchi <michael@amarulasolutions.com>
>>> ---
>>>    drivers/clk/clk-bd718x7.c | 4 ++++
>>
>> //snip
>>
>>> @@ -100,6 +101,9 @@ static int bd71837_clk_probe(struct platform_device *pdev)
>>>
>>>        parent_clk = of_clk_get_parent_name(parent->of_node, 0);
>>>
>>> +     of_clk_detect_critical(dev->of_node, 0, &flags);
>>
>> Purely judging the kerneldoc for of_clk_detect_critical - you may have
>> hard time getting this accepted.
>>
>> I think you're working on a very valid problem though. Maybe you could
>> see if you could align your effort with Marek?
>>
>> https://lore.kernel.org/all/20220517235919.200375-1-marex@denx.de/T/#m52d6d0831bf43d5f293e35cb27f3021f278d0564
>>
> 
> Old thread but same problem. Is there any way to make this acceptable?
> any suggestion?

Hi Michael. I'm not sure what is the correct way but I think there are a 
few tricks people have used to fix (or paper over) the problem. One was 
suggested by Sebastian:

https://lore.kernel.org/all/20220913152140.iikckob5h3ecagfi@mercury.elektranox.org/

No one shouted for implementing this fix though.

It also seems to me that there is a way to 'make things work' by 
modelling the clock dependencies in the DT in certain way, AND having 
correct drivers enabled. This understanding came just by reading mails 
Marek sent in this discussion:

https://lore.kernel.org/all/20220924174603.458956-1-marex@denx.de/

I've not tested any of this myself - but I hope you can use these as 
pointers to a solution that works for you...

Yours,
	-- Matti

-- 
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~


