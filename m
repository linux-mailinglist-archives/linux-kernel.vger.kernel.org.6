Return-Path: <linux-kernel+bounces-297608-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D0F7495BB63
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 18:09:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E8E228265A
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 16:09:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDA321CCEC7;
	Thu, 22 Aug 2024 16:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XqXRiPgI"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 552131CCB2E
	for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 16:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724342950; cv=none; b=kywsB6wdeP9KNbNkKITCQ6fn8Wu+2/tgBd1qFFDMAUM+wkHBh4Yume52GEUQ5y6yJ6M4HA6oG5xwu5L8mWS4giRH9JDebKWyccy5u76FyVwUB+RpOQDAu0lo9jRTsam1qumdkyxDlYYi4SMFX1pq5swBEgbEiVx2Mqd8aUzDnWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724342950; c=relaxed/simple;
	bh=UpopM0iCKTPu7oD7wDK7usjY91WrEhIWx1dqahbwaGc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rPwNyh/l1A+SZGKu2blLViq5G2pqLJ/ajG08tl9hQBcyIF4ob5jnXIxh1uOLBbR/u7nhozf1+djdAfBK2fG3rxzxczXtEwmYbWR7FWPeV8x6NvoZ0hJblgeinD7FcDVGE0S7djDyYCKHHPlsfhjXQZAdWVSmbquwk/lVyTbaekM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=XqXRiPgI; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-428e0d18666so7155405e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 09:09:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724342947; x=1724947747; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mxWtqtu6B9Te+Ly60+I2Fkm4q9IiogrBTjwymbi54UI=;
        b=XqXRiPgIz5P0/WJnN9Yg7tmqldQsiP2YwJk5T4hdLJnN6DnZU6mGMeEYXRvrOFZIVH
         4lSDfliqti0iV+pDut8ao0/okOvEH4wQ8Q+csodxCCz2zBR38cyivCxChT91NPv16bpF
         kqYCDL8fr2mphiQpS/t2R53ZTPVfvJ1BsYT3nyMw/4kBuuOt4JxHi7VR3Pjw8WtZH/w9
         FFWKbDZRAEsSKv90Yop4Ciuw2+2404yPSeX5saiClm7MKu4G/CfSUn43aFRbiIV/+V3Q
         npAwctDwUlryvyPLpKJqYzYohgPoHFxes5AvK2L+u6EgOv37tJHxr7uk4kGN5r3BP5mE
         Hrvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724342947; x=1724947747;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mxWtqtu6B9Te+Ly60+I2Fkm4q9IiogrBTjwymbi54UI=;
        b=tkYcaJ7oOa5NoBsTrEhIBIvDpHMFZjWoEuGyH9BQcclXU4k0HIv05oAZRUDqC/VKiO
         SzY9UEN67/0wDLLR17nbSOPLpYrRm3SHITTmzEjPOlJav43T/Pg6oxzwKJlnmF8Wyvvy
         sTlzv98N5d1BPJP33JEgbnmbDMvvflilwFYyAeOFBik5FCe8hEU8bqCzpdIqzk8c01u8
         7X9kc55NWPrtAO1MYX0dolQeCrl3ME+CfGYPCBsR3nscvMVoPzCBG2X2wk9hmvkBbf82
         SPFcR5rQUdaQ/Yqi5eUglO+Y9aUil4cstO1NMcUpiONYkH8axXT9kqEmYrlxOa+/sMAH
         p2Cw==
X-Forwarded-Encrypted: i=1; AJvYcCW20QKuWKIHEIYTigbtl3bnNFVYYUS7oszYQjGnpkWhSJNmKTxk42rP7O/YNV4D/1LYYp+KIKf8w1N7lac=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4zdz38uPfEKsfXiJxbCOnkEkm5VaELR3XzLzgr97i64me9F2a
	dpTqT6sNS0l5Ylzl40eTTdXIVuTGb5EKVJAQi3qhARexFB5v2G0N1MVEbwrRsQo=
X-Google-Smtp-Source: AGHT+IEN98bUxf5mTW8am5jeqLmJ9b+md3U9v/C8Oin8X/xeA+XvE29YV7xWzZoqUMcgJ7TNmlyYiQ==
X-Received: by 2002:adf:dd87:0:b0:371:8ed7:49e9 with SMTP id ffacd0b85a97d-372fd6f0fafmr3816719f8f.26.1724342946252;
        Thu, 22 Aug 2024 09:09:06 -0700 (PDT)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-3730821a8bcsm2002038f8f.90.2024.08.22.09.09.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Aug 2024 09:09:05 -0700 (PDT)
Message-ID: <9296367b-500e-4701-9eca-a7fa7eea36d9@linaro.org>
Date: Thu, 22 Aug 2024 18:09:05 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] thermal: of: Fix OF node leak in
 thermal_of_trips_init() error path
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240814195823.437597-1-krzysztof.kozlowski@linaro.org>
 <f3d2c104-360a-4da0-8d77-59af89ebda2b@linaro.org>
 <CAJZ5v0hiR0sqgfR1WiuT=tXx3XRWgAE-j3biEMMaV5FjiSZwbw@mail.gmail.com>
 <9e6d817f-1fcf-4d31-b0c5-d68753e1f949@linaro.org>
 <CAJZ5v0jU4xOwgA8neFVMijV+T9=oiOBoEjD9viaCq=g51wFGkQ@mail.gmail.com>
 <CAJZ5v0iGkGeHV5a_LpeVFTnzKAZf9ynmpYWfH4D95jw2t6sFOg@mail.gmail.com>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <CAJZ5v0iGkGeHV5a_LpeVFTnzKAZf9ynmpYWfH4D95jw2t6sFOg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 22/08/2024 17:54, Rafael J. Wysocki wrote:
> On Mon, Aug 19, 2024 at 3:31 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
>>
>> On Mon, Aug 19, 2024 at 3:22 PM Daniel Lezcano
>> <daniel.lezcano@linaro.org> wrote:
>>>
>>> On 19/08/2024 15:20, Rafael J. Wysocki wrote:
>>>> On Mon, Aug 19, 2024 at 12:12 PM Daniel Lezcano
>>>> <daniel.lezcano@linaro.org> wrote:
>>>>>
>>>>> On 14/08/2024 21:58, Krzysztof Kozlowski wrote:
>>>>>> Terminating for_each_child_of_node() loop requires dropping OF node
>>>>>> reference, so bailing out after thermal_of_populate_trip() error misses
>>>>>> this.  Solve the OF node reference leak with scoped
>>>>>> for_each_child_of_node_scoped().
>>>>>>
>>>>>> Fixes: d0c75fa2c17f ("thermal/of: Initialize trip points separately")
>>>>>> Cc: <stable@vger.kernel.org>
>>>>>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>>>>>> ---
>>>>>
>>>>> Applied, thanks for the fixes
>>>>
>>>> Is there a place from which I can pull these?
>>>>
>>>> It would be good to include them into 6.11 as they are -stable material.
>>>>
>>>> Alternatively, I can pick them up from the list.
>>>
>>> I'll send a PR for fixes only. Let me double check if there are other
>>> fixes to go along with those
>>
>> Sure, thanks!
> 
> Sorry for pressing, but it would be good to get this material into -rc5.
> 
> I can still pick up the patches, I don't believe they are controversial.

Ok, feel free to pick them. Give me a few minutes to add my tags

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

