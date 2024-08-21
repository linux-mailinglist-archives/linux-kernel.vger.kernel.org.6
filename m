Return-Path: <linux-kernel+bounces-295354-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 65AD9959A01
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 13:32:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 989E31C20B1D
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 11:32:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B647317836E;
	Wed, 21 Aug 2024 10:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GzesTNyE"
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29D8C1D12FB
	for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 10:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724237375; cv=none; b=GqvQTCEqcoimBUPp+GqNz7InfhFrLmWylIFogry70jKx1s2c3eNpKINWnvkIYXUnVL3nBfjP0T0jSOhMCRAGxCq3im4WHM/uriM33ZTX6oJZNrV/m0sntpw5DYhan+b5vvzCVJoOFovmIl4O6JOt04KJfVDVEro/cNsgUc4NTVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724237375; c=relaxed/simple;
	bh=JGcsFgMn4lz0OieBaCWqjR5hwIEe8I2gm2ZLbKFWnZQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=patnVQrnxZYMMAJp3Gd3YfRQYgUZLrhQ6anwFuBnPXNr/OfXfftu/TArqiLP7WrpKCFu6Yvj6JOlPEFpYU1O+gQXKgiT54P8dTioLeHvyL1blpQQyoEB4dV5slYae6b+HqJZNfW6cnCz30pYlX1N3JO+Acw6jCiuEn41pqly0N4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=GzesTNyE; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-371941bbfb0so3340774f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 03:49:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724237372; x=1724842172; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cMxDjVcwkjUuVPfc9ioRrttIgIfpp7/8vIch9gBk8E0=;
        b=GzesTNyEW2kh4QIPur0B8caNKvvW6e8TbvLtk4gUTlDzNvGEBYPFeGGkUw2O1p3rTd
         B44HFEObWl5No15vszyt8tiTsyTRbLv4W1odytjjUcA+3cdgYjcMPURVGD34qc7P4JzZ
         UJ/1zP3hwyMQ3Etourl/p7j4T6xYxPYC2jEPp/7Zhn2YtBkwwxCdZkckwc6hEWKAVEA1
         JTu/ieSsbjyzpPo2tznxvka6FjgZ92ImOa/QmqsOkkVCK8slyZI+tTLpNsRGYqZT5tDH
         s0nuwgw3kbs1bO1nhfSAdMUGedlvOI9v/kvEXKkIHHHvBrAxKF5T7YYzWn9WqNsbif+p
         S7cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724237372; x=1724842172;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cMxDjVcwkjUuVPfc9ioRrttIgIfpp7/8vIch9gBk8E0=;
        b=A34AFJo9Rx2ah84gyeUeSpUeQkdHb9KaMtqlCFzI3Z95kycRJhhLvNg/jqHumaTEIM
         UFWupyO9g1YBMruX7Pt7QcfWkFPHFo95ZtvcfGgCVD9SF5leIUg2AQ4lKj9S4km2V06r
         ZElhmdRe2o52jSPLN0qf+41xuoQkYJQGg/icKa3zX86pdGWyUrRLfNVwlLiGWMx3BhbQ
         FPm4KKm7B4F9FokjTMZwHVRQsJISxR/AeDG6tfM14MRzt7ypQlqCrldmEWzKlWXuQLaI
         887EBIIVE1SUoOmgi6dkXet3XFHzK11wyxfpm4BKi8yhFamXpdyOMga3F2ZS6sq+qGJj
         Yupw==
X-Gm-Message-State: AOJu0YyZ+mzEofbcFrgO3p31YKflx03V+YACzeqYfBYKgNb/CoBe0g8C
	lDfc6SMLbpofI54ef52dS84UeWgYR7FZZcMzbkPDzrJ0kQ5UsbQdl2rT2cwbjqY=
X-Google-Smtp-Source: AGHT+IHJjURLl7FCkfGSD2GQLFx/hg3HZNlZMuaJrKYN1Y4optKGaIH8UMdaODup5IN1vB0pCFIx5Q==
X-Received: by 2002:adf:f511:0:b0:371:8e68:a6dd with SMTP id ffacd0b85a97d-372fd592f27mr1284640f8f.23.1724237371952;
        Wed, 21 Aug 2024 03:49:31 -0700 (PDT)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-3718983a397sm15355626f8f.24.2024.08.21.03.49.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Aug 2024 03:49:31 -0700 (PDT)
Message-ID: <c90b53af-1641-4c8a-97d9-27feed7b2a7d@linaro.org>
Date: Wed, 21 Aug 2024 12:49:30 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 02/14] thermal: core: Rearrange checks in
 thermal_bind_cdev_to_trip()
To: "lihuisong (C)" <lihuisong@huawei.com>,
 "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: LKML <linux-kernel@vger.kernel.org>, Lukasz Luba <lukasz.luba@arm.com>,
 Zhang Rui <rui.zhang@intel.com>, Linux PM <linux-pm@vger.kernel.org>
References: <2205737.irdbgypaU6@rjwysocki.net>
 <3324214.44csPzL39Z@rjwysocki.net>
 <68ed6185-a602-c0fc-721e-b5d68fea83f8@huawei.com>
 <66bb19a0-00ba-40a5-91ef-73368659b30a@linaro.org>
 <8744a789-0424-0cc6-7cb1-b7c9b17f56cc@huawei.com>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <8744a789-0424-0cc6-7cb1-b7c9b17f56cc@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 21/08/2024 11:44, lihuisong (C) wrote:
> 
> 在 2024/8/21 17:28, Daniel Lezcano 写道:
>> On 21/08/2024 10:49, lihuisong (C) wrote:
>>
>> [ ... ]
>>
>>>> -    list_for_each_entry(pos2, &thermal_cdev_list, node) {
>>>> -        if (pos2 == cdev)
>>>> -            break;
>>>> -    }
>>>> +    lockdep_assert_held(&thermal_list_lock);
>>>> -    if (tz != pos1 || cdev != pos2)
>>>> +    if (list_empty(&tz->node) || list_empty(&cdev->node))
>>> The old verification is ensure that tz and cdev already add to 
>>> thermal_tz_list and thermal_cdev_list，respectively.
>>> Namely, tz and cdev are definitely registered and intialized.
>>> The check is ok for all untizalized thermal_zone_device and cooling 
>>> device.
>>> But the new verification doesn't seem to do that.
>>
>> If the tz or the cdev are registered then their "->node" is not empty 
>> because they are linked with the thermal_list and cdev_list
>>
>> So either way is browsing the lists to find the tz/cdev or just check 
>> "->node" is not empty. The latter the faster.
> Assume that tz/cdev isn't intiazlized and registered to thermal_tz_list 
> or thermal_cdev_list. And then directly call this interface.

Then there is a bug in the internal code because the 
thermal_zone_device_register*() and cooling_device_device_register() 
allocate and initialize those structures.

The caller of the function is supposed to use the API provided by the 
thermal framework. It is not possible to plan every stupid things a 
driver can do. In this particular case, very likely the kernel will 
crash immediately which is a sufficient test for me and coercive enough 
to have the API user to put its code in question ;)

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

