Return-Path: <linux-kernel+bounces-283839-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA1C494F94F
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 00:04:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7533628350A
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 22:04:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C67BE194C83;
	Mon, 12 Aug 2024 22:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kp0ESuQF"
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 578ED16DEAB;
	Mon, 12 Aug 2024 22:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723500275; cv=none; b=PtTvzBPtZk3MwNw+KMScDTRMzkBooNOOL/WZqHRxj7Igo2i/5sGzQ5+OnTKnmOANRqyApK+7ghab11jN+0QAfzqeK9ZA3FDBWweRdZBvboOSNaKBhLvg8as7lMtUMh9EG4loe82nUI2eIdngA1volIzuss5EfjqL40nEvXhB9Oo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723500275; c=relaxed/simple;
	bh=s356l82982ex54FrtcWCDDd+kcMjvFBOhngs5HfNkNE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tKnPHNh3ekl2CouvGFlyxkL7tly46bpZbXDpOkt5IqUGKM5chU/c7aDmqHf7PibFEMf84MSroax0lgOwuZbd7ZMyKbhQmm3hI7kuBAkH9tnIByISAvtvmo9HLNZh8OdTRX8vL0rCed4OxFAs3AgOmSFJ+OmFVugorGnO6oq9+e8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Kp0ESuQF; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-530e2548dfdso5070341e87.1;
        Mon, 12 Aug 2024 15:04:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723500271; x=1724105071; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=w2sJcbXaYw9J75zTjKpIjNm2QuuWu9ce9ETcgUGYICE=;
        b=Kp0ESuQFUDa/Roc2Y93m+gqVaz72AnUvGSUhGjsmhdmHWzSVG06Iukzo8L904q8pIa
         2qSChPOiafqLCs9v77CNsM5CuFPbT+id74oQFfXgw+69Apb7nu6VXx7n4imM/Bhr3Qca
         TZo1VcuwvgB5D7qxNsNZvDlg7OxlFQVsXWRiMy+4RSqWyChOrPjKFNEhrelc3tajqYTf
         0EBClh2wXkPS30LTarW8wyoRy82B8uObKC8oUKKryYmxxq/yYOBCc63Jdo5s8m/WfLT/
         LHDpcWHUSkdh0T7Chx+cRBqRCC5yVPRJfcGIGINeP2uOY4YfjgRffEbjfFhooPoeVMSY
         IYIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723500271; x=1724105071;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=w2sJcbXaYw9J75zTjKpIjNm2QuuWu9ce9ETcgUGYICE=;
        b=lw/+U+T6Ub6ZKqey4wnrtoVZkYTba3gy4FOOfS46vUnMgPX1b1GKhMHkZagZ1+d7uU
         7NrxXFeQDE8is4GxPTlZFPeSAuqlz7a4tetH2YAG4o1ieNlXuMWuB8uI0b7+Iyu9WuU0
         v7J5qUgDSnvMmJOA/lNJBrDreFAscNczDmFOY5ly9wkMn8wczStHiJtaTfk/znDaWJKI
         AGxeE3Q2njK3yNpWqnycPJfywU8skMReRxj6zUHNf9ZSzztdsOWWUWiwgXljijmFWJ5I
         tx5+Z8UVwGRRi8vNHRmtonQSAsSFpPjbaPJ0wu/IhunAYV9yJShbDKt8QmcYvl+8drup
         0r6Q==
X-Forwarded-Encrypted: i=1; AJvYcCW8CR9qaJkM0KGe50qYWrFG0/sIl66xJRlGiMQ87z5BpCfMDa/TPm+/9dChkK9czIYAviRKN83bSMM7Lw15gH5+TGSba9vlO1dZWO0O
X-Gm-Message-State: AOJu0YyEbouKTuqzqLzMek9Iw55RZpnpMrib+wcSP1qmv8IkVLfd9Lsa
	OZWSPU/GAZS+mTVBHh4FUu5DzdM26I6BQl4XSe8C8Phw5zlsTgqxb/w1QA==
X-Google-Smtp-Source: AGHT+IF64eeMGuR5Ozqv3G42ytGbfL5UFf2rkE56ljjgH0sh5epW013JhZq5DT+Ui9g0uFF8bjkRRw==
X-Received: by 2002:a05:6512:131b:b0:52b:c1cc:51f1 with SMTP id 2adb3069b0e04-532136582e5mr943442e87.23.1723500270891;
        Mon, 12 Aug 2024 15:04:30 -0700 (PDT)
Received: from [192.168.0.31] (84-115-213-37.cable.dynamic.surfer.at. [84.115.213.37])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a80f3fa4646sm14573466b.54.2024.08.12.15.04.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Aug 2024 15:04:30 -0700 (PDT)
Message-ID: <d90b6e77-be5f-4f47-8f9f-6fb926a0690f@gmail.com>
Date: Tue, 13 Aug 2024 00:04:29 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] hwmon: chipcap2: disable sensor if request ready irq
 fails
To: Guenter Roeck <linux@roeck-us.net>, Jean Delvare <jdelvare@suse.com>
Cc: linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240812-chipcap2-probe-improvements-v1-0-3cdff6d16897@gmail.com>
 <20240812-chipcap2-probe-improvements-v1-2-3cdff6d16897@gmail.com>
 <9b4f88e8-5fc6-4c4a-b89c-7f96675e81ac@roeck-us.net>
 <9659c699-1ce4-4b74-b697-83d926d80b35@gmail.com>
 <eefbeda1-8c09-4b57-83dc-30be9966de2b@roeck-us.net>
 <f6034baa-3a1c-4bd3-8cf2-cd197e8a0945@gmail.com>
 <ba54014c-429b-44ed-a887-e25a4bf033c0@roeck-us.net>
Content-Language: en-US, de-AT
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
In-Reply-To: <ba54014c-429b-44ed-a887-e25a4bf033c0@roeck-us.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/08/2024 23:26, Guenter Roeck wrote:
> On 8/12/24 13:48, Javier Carrasco wrote:
>> On 12/08/2024 22:08, Guenter Roeck wrote:
>>> On 8/12/24 12:59, Javier Carrasco wrote:
>>>> On 12/08/2024 18:49, Guenter Roeck wrote:
>>>>> On 8/12/24 08:43, Javier Carrasco wrote:
>>>>>> This check is carried out after getting the regulator, and the device
>>>>>> can be disabled if an error occurs.
>>>>>>
>>>>>
>>>>> I do not see a possible path for a call to cc2_enable() at this point,
>>>>> meaning the regulator won't ever be enabled. Please provide a better
>>>>> explanation why this patch would be necessary.
>>>>>
>>>>> Guenter
>>>>>
>>>>
>>>> Hi Guenter,
>>>>
>>>> this patch enforces the state where the dedicated regulator is
>>>> disabled,
>>>> no matter what the history of the regulator was. If a previous
>>>> regulator_disable() failed, it would still be desirable that the
>>>> regulator gets disabled the next time the driver is probed (i.e. a new
>>>> attempt to disable it on failure).
>>>> cc2_disable() checks first if the regulator is enabled to avoid any
>>>> imbalance.
>>>>
>>>
>>> That is very theoretic. Sorry, I am not going to accept this patch.
>>>
>>> Guenter
>>>
>>
>> I get your point, but given that this device requires a dedicated
>> regulator, I believe it makes sense that it tries to disable it whenever
>> possible if it's not going to be used. I think that makes more sense
>> that just returning an error value without even making sure that de
>> regulator was disabled, doesn't it?
>>
> 
> No, it doesn't make any sense whatsoever. What are you planning to do,
> clutter the kernel with code to disable regulators if instantiating a
> device
> fails for whatever reason and it turns out that a regulator which should
> not have been enabled to start with turns out to be enabled anyway ?
> 
>> Of course this is not a killer feature, and I don't want to make you
>> waste much time with it. But I think the dedicated regulator should be
>> shut down in all error paths, whatever status it had before.
>>
> 
> I strongly disagree. This can only mess up the kernel all over the place.
> Maybe you can convince other maintainers to accept such code, but please
> refrain from doing that in my scope of responsibility. If the regulator
> subsystem has the habit of leaving regulators enabled even after they
> have been released, that problem should be fixed in the regulator subsystem
> and not be worked around in individual drivers.
> 
> Guenter
> 

In that case the current behavior is wrong in the opposite direction,
and disabling the regulator before any call to cc2_enable() follows the
same invalid assumption.

I will remove the call to cc2_disable() in the probe function, which was
there exactly to ensure that the regulator gets disabled under all
circumstances. All error paths will just return, letting the regulator
untouched if it was not actively enabled.

Best regards,
Javier Carrasco

