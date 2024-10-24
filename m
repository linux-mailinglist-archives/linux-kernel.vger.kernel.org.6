Return-Path: <linux-kernel+bounces-380076-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B14649AE896
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 16:27:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 67E821F2143E
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 14:27:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C7CD1F76B8;
	Thu, 24 Oct 2024 14:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lTOHYgaY"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC0CF1EABC6
	for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 14:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729779720; cv=none; b=n1S8tTh64uO2I9EPdGfxEre+mjaNyO+53FxHE/xnrAUXyEk+4sHSYG6uGlc56mSP6eVlCGHN90QUeEMOqgHradLk+bX/xxxLh9+L2gx/oKjBgGrwWB7nNQ9phQfw7HrmdJ5pvQsJiycq/+IpashOW/5y/VbNy76+0/PaONLsMPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729779720; c=relaxed/simple;
	bh=Ztn3ZTk8dzE/YkwiP2wbeo/AXwxRZTQQkbkKaza/89k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lJ7EOan8yQauAw/JvCDIZvykniJ66LsmNwepr6HQWY1JhGd8E0/XIRMQMLtZSvURHEzXRiWKieRgBpu2pwf4wRTi8R/SvMr+BzMW/hDZcOIyumX06GLhUJvdcqZE5IlG4zoQEBg1lCnWBGaUu34wOr5PvtpMSwkOY+anBC5cvog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=lTOHYgaY; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4314c452180so14345555e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 07:21:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729779716; x=1730384516; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0FZisNkmAgDb4FsOsOHpAPmNZ3iYpoVhIfqXzX+OuNk=;
        b=lTOHYgaY7B/9VwHIYyJaxP+WddV5sKAxAt8DmEKrqwXRRHy3WjEB7t7q6y2HjOf1Uu
         IjwbRr35q4/OuKDM45Fw7g5mGIj+NBISTrSc7qEfReI2KEAOPFXwtjEC17shnOoCnyEs
         /38zIvjZxn9Uu6txvehRfdV4LpIswno/hTJ5IfEovlKMLuT4k2gYttg29Kz3WR6Ek5dk
         4uX7bLujSMrg2O9gkRwArcovdE12Gn0zBarYoz3mlMNRkcbJwTkfADg17m1hPLutBCS/
         JXkRwSWNwTw54a1xmSiLF5+9hzF5cuUiSH8wMgoMNfUIaNp/NpTqAq9HZRegSnt1Jt2h
         jp1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729779716; x=1730384516;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0FZisNkmAgDb4FsOsOHpAPmNZ3iYpoVhIfqXzX+OuNk=;
        b=ChSPkLR+ALV450SG6FsHAe3HrM/M0Crav4dm0aAneLUZYqHSpSuzLPCpP+DpuKTmOV
         k7uSZi5myY8zWiVrDesAYs/kBTU+C3KrDpPbQyfbQla5Ahk6Z46gmvJLyahkVDXq97Lb
         USd/QuZxhrBNWtfV887DsPWIXXk1oUQzIrLpgsxnOlUMgw/8A3oG1Yz4c3ZjLPZnl/WT
         QJN9ErKlogzmspCPk38naru5UVPf/XBK4Jq38PDr98CCy1CgUeXsZK0aCFA4yVZmTfgp
         0807lXVGENnVjoyUgy0oW6Tm3y+47aw0Jel4hcLP6wxzXBzsEsePqnLjwNdEMmO7r7K7
         eUCQ==
X-Forwarded-Encrypted: i=1; AJvYcCWp0YAJmeIAf7/MUgcf0U8APiq31FGQhlDNHiX7LwuGyEPRFf7//KVTMuxQGlFsJamwrxd3VErHGDwjKIg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwjQCw6t95KdhMCijGp4XkOKoJ70R3ub1fGvU0FvNl49yzSZ/7l
	2zqxBwXBJaq+Bqf6bByX6AQCJkrTKdQ60AqTO89oQwG7qXP0OXa3F+WepYiiV2U=
X-Google-Smtp-Source: AGHT+IGml03ePm5Nk6M8qPc+AoiNyOJzzaFhBgOmcu1YaqZI0C1FBGekaPgCTh48LKY+C1SoIheKoA==
X-Received: by 2002:a05:600c:1c22:b0:42c:b991:98bc with SMTP id 5b1f17b1804b1-4318d7f1753mr14763425e9.0.1729779716044;
        Thu, 24 Oct 2024 07:21:56 -0700 (PDT)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-37ee0a64dc1sm11433322f8f.65.2024.10.24.07.21.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Oct 2024 07:21:55 -0700 (PDT)
Message-ID: <03a4edf1-9562-49fd-81fe-d96f46a41d28@linaro.org>
Date: Thu, 24 Oct 2024 16:21:55 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] thermal/lib: Fix memory leak on error in
 thermal_genl_auto()
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Markus Elfring <Markus.Elfring@web.de>, linux-pm@vger.kernel.org,
 Lukasz Luba <lukasz.luba@arm.com>, LKML <linux-kernel@vger.kernel.org>,
 Zhang Rui <rui.zhang@intel.com>
References: <20241024105938.1095358-1-daniel.lezcano@linaro.org>
 <45265aca-7371-455f-819f-c4d68cbb089b@web.de>
 <9ba3fa17-57c3-41e9-9e19-33fa105a179e@linaro.org>
 <CAJZ5v0jWGdzakj8ob2otAO6auwGBvVsewujG-d9b1Z5nnO7Vkw@mail.gmail.com>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <CAJZ5v0jWGdzakj8ob2otAO6auwGBvVsewujG-d9b1Z5nnO7Vkw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 24/10/2024 15:18, Rafael J. Wysocki wrote:
> On Thu, Oct 24, 2024 at 2:57 PM Daniel Lezcano
> <daniel.lezcano@linaro.org> wrote:
>>
>> On 24/10/2024 14:02, Markus Elfring wrote:
>>>> The function thermal_genl_auto() does not free the allocated message
>>>> in the error path. Fix that by putting a out label and jump to it
>>>> which will free the message instead of directly returning an error.
>>>
>>> Would you like to add any tags (like “Fixes” and “Cc”) accordingly?
>>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/submitting-patches.rst?h=v6.12-rc4#n145
>>>
>>>
>>> …
>>>> +++ b/tools/lib/thermal/commands.c
>>>> @@ -375,27 +375,30 @@ static thermal_error_t thermal_genl_auto(struct thermal_handler *th, cmd_cb_t cm
>>>>                                        struct cmd_param *param,
>>>>                                        int cmd, int flags, void *arg)
>>>>    {
>>>> +    thermal_error_t ret = THERMAL_ERROR;
>>>>       struct nl_msg *msg;
>>>>       void *hdr;
>>>>
>>>>       msg = nlmsg_alloc();
>>>>       if (!msg)
>>>> -            return THERMAL_ERROR;
>>>> +            goto out;
>>> …
>>>
>>> Is it really reasonable to pass a null pointer (from a failed function call)
>>> to a subsequent nlmsg_free() call?
>>
>> You are right, I should return here :S
> 
> Do you want to respin it?
> 
> Alternatively, I can fix it up when applying the patch.

If you don't mind I would prefer to apply the lib patches

For correctness, I'll send a V2 with the return fixed


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

