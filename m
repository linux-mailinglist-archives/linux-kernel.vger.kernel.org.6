Return-Path: <linux-kernel+bounces-292848-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 243DD957538
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 22:03:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 84F0FB2327E
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 20:03:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69BD91DD388;
	Mon, 19 Aug 2024 20:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gjMB4VHc"
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02CA918E0E;
	Mon, 19 Aug 2024 20:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724097826; cv=none; b=YdOQ08HvogjWP5xGVbNh9QABioBVp4cJWKhplPmc846IhGbQSVD5/VZA2zDAMUp8JHtsp0ngtJcMECoT2g6a/G5LcFHXZm6GfR8I2jvtEF1/XKRi/6jl1p2kPtLQg3wLOK3eYRpDsp7W5uKsjStnj0eZPAS86J6q1quzhLbXgnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724097826; c=relaxed/simple;
	bh=k9M1GWBOjgSaQ/XNTFFHoKe35CV+yy8JTJlBuMg8UdY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VGp9GfAWZPdiQAojd9ETX9ms0pMt5wqpUT9+FcyFCDMkfs+AOC2NNZFEw8dTlJutmXzGmQ+JdZPKhWmTri9rjcmk5+B7Vg7vvxK92A0/V3+mHGM23DJb64whDMJD6Csg/eN/qM65WBayGk4e+T769dSY5sqZEUhEl5n1yyzT/R8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gjMB4VHc; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a7a843bef98so531215466b.2;
        Mon, 19 Aug 2024 13:03:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724097823; x=1724702623; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SaW51Bo1p5n35hvKLdnXJeeKln2IbzdtDwBHwICo5Ak=;
        b=gjMB4VHcyVnevyrNRaa4LVUThSxyO5nIzZXjOByhB8NStUzMgrQNO1/Vgh3OWmitwv
         liOYKQ9wqiF0qWWo5o4f0I9iZ184ulsHxdHJUJbgV6FnZ9fH/7jEi8CnOTng/ufg2IbC
         sF7F5/zTxt1sXhqzNNipOfM2dM++uqb0OL/Fpa0ctLrZf0Bzbb1jLjVfp4yVNDHPc6Ud
         BzV6gie+uykBohfMXNK3irE/Zu8DrCxrY7ZXclND07XppkfIMxVhaIw9a6se6pOX/Day
         hAiuPLn5k2LuCB7abMhOWDlTaaInKowTeZvJkXOdUbYPXDKRYIpoIfrVHnlA46ZIjtl6
         gqMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724097823; x=1724702623;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SaW51Bo1p5n35hvKLdnXJeeKln2IbzdtDwBHwICo5Ak=;
        b=jplh+7krNDNBiExL0o4xtVDmUQcoafAaqqJQE1VDPmNOv5oyQCCdwIFGf7/ph9pzKw
         DEcaph/mHemMq6rLgP4JWyk5KjIlB7LEGVNvN7mOrxEHNPkkcVu6fmw/63Kdw6obGIHA
         Dm2KN/yjyq3sMrGFWX3eRawVuCdGSPDuV17uW4XySJjHSHzia0NvOeD1g8aQcYNggekj
         fM0ScRXAHV4W/k5OH7iyusTAMC/BDl1ESPPL9mmyVmo+y5zZmQk2RElXWT/3IijYCaba
         4QVJGPhztuQZGJAOA4NzCLUKNDCIovEh9RfpwkIMBhgyzI5fCy7m66RpcIftrRtj3a9p
         cr4g==
X-Forwarded-Encrypted: i=1; AJvYcCVjQJ11+paAAODVGQymCSxZ1wqj0Dc4RWJe3cpEPE28Uj0Kj5YxdDoMf/ymvEV2prOBJswMBuP24PA7V1Db@vger.kernel.org, AJvYcCVt6CTsU6OWNRVFPm0d3xSQf/WuQfnY9g8SXX9hP9BDESIxDCLsSROfH/N8X1gYCsxFo4m+TpYTonTmkg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxDlUUE0NsCASx3SOkTMHI/F2GxkRgEMdLRYmXFd/RWGbmP6Htx
	CzyRQqoMY25F/RYFu4SCglWl7H0HoxIN6I8BGvRGHX+EJrA2PzM61l/BdQ==
X-Google-Smtp-Source: AGHT+IFEO9W2xpUkZmGpXZPUK6npkx18zFyTZ+wb1k8Gx/FI09Bw5izf3o18L6+lncNNgqDkAGiuXA==
X-Received: by 2002:a17:907:c88c:b0:a7a:8bf9:a6e8 with SMTP id a640c23a62f3a-a839295353fmr934087366b.35.1724097822818;
        Mon, 19 Aug 2024 13:03:42 -0700 (PDT)
Received: from ?IPV6:2a02:8071:b783:140:927c:82ba:d32d:99c1? ([2a02:8071:b783:140:927c:82ba:d32d:99c1])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8383935641sm674311766b.127.2024.08.19.13.03.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Aug 2024 13:03:42 -0700 (PDT)
Message-ID: <84588132-015f-4bbb-becf-e5166effb5a4@gmail.com>
Date: Mon, 19 Aug 2024 22:03:41 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] hwmon: Add thermal sensor driver for Surface
 Aggregator Module
To: Konrad Dybcio <konradybcio@kernel.org>, Guenter Roeck <linux@roeck-us.net>
Cc: Jean Delvare <jdelvare@suse.com>, Hans de Goede <hdegoede@redhat.com>,
 Ivor Wanders <ivor@iwanders.net>, linux-kernel@vger.kernel.org,
 linux-hwmon@vger.kernel.org
References: <20240804230832.247852-1-luzmaximilian@gmail.com>
 <6027d9db-b1a8-4eb0-a0b7-451f1524834c@kernel.org>
 <4464d0f5-1a40-40b9-8d53-7f0d75b9d062@gmail.com>
 <39eecb79-0b1a-4a17-865f-dcb60a20a893@gmail.com>
 <44aa4b41-c9af-4c0a-a8a8-4d2cd3e1054e@kernel.org>
Content-Language: en-US
From: Maximilian Luz <luzmaximilian@gmail.com>
In-Reply-To: <44aa4b41-c9af-4c0a-a8a8-4d2cd3e1054e@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 8/19/24 12:26 PM, Konrad Dybcio wrote:
> On 10.08.2024 3:14 AM, Konrad Dybcio wrote:
>> On 10.08.2024 3:04 AM, Maximilian Luz wrote:
>>> On 8/10/24 1:35 AM, Konrad Dybcio wrote:
>>>> On 5.08.2024 1:08 AM, Maximilian Luz wrote:
>>>>> Some of the newer Microsoft Surface devices (such as the Surface Book
>>>>> 3 and Pro 9) have thermal sensors connected via the Surface Aggregator
>>>>> Module (the embedded controller on those devices). Add a basic driver
>>>>> to read out the temperature values of those sensors.
>>>>>
>>>>> The EC can have up to 16 thermal sensors connected via a single
>>>>> sub-device, each providing temperature readings and a label string.
>>>>>
>>>>> Link: https://github.com/linux-surface/surface-aggregator-module/issues/59
>>>>> Reviewed-by: Hans de Goede <hdegoede@redhat.com>
>>>>> Co-developed-by: Ivor Wanders <ivor@iwanders.net>
>>>>> Signed-off-by: Ivor Wanders <ivor@iwanders.net>
>>>>> Signed-off-by: Maximilian Luz <luzmaximilian@gmail.com>
>>>>>
>>>>> ---
>>>>
>>>> Gave it a shot on SL7, some names are repeated and one sensor is
>>>> totally busted
>>>>
>>>> /sys/class/hwmon/hwmon66/name:surface_thermal
>>>> /sys/class/hwmon/hwmon66/temp10_input:32200
>>>> /sys/class/hwmon/hwmon66/temp10_label:I_RTS2
>>>> /sys/class/hwmon/hwmon66/temp11_input:31600
>>>> /sys/class/hwmon/hwmon66/temp11_label:I_RTS3
>>>> /sys/class/hwmon/hwmon66/temp12_input:38000
>>>> /sys/class/hwmon/hwmon66/temp12_label:I_RTS4
>>>> /sys/class/hwmon/hwmon66/temp1_input:43900
>>>> /sys/class/hwmon/hwmon66/temp1_label:I_RTS1
>>>> /sys/class/hwmon/hwmon66/temp2_input:44000
>>>> /sys/class/hwmon/hwmon66/temp2_label:I_RTS2
>>>> /sys/class/hwmon/hwmon66/temp3_input:47300
>>>> /sys/class/hwmon/hwmon66/temp3_label:I_RTS3
>>>> /sys/class/hwmon/hwmon66/temp4_input:-273100
>>>> /sys/class/hwmon/hwmon66/temp4_label:I_RTS4
>>>> /sys/class/hwmon/hwmon66/temp5_input:31300
>>>> /sys/class/hwmon/hwmon66/temp5_label:I_RTS5
>>>> /sys/class/hwmon/hwmon66/temp9_input:37100
>>>> /sys/class/hwmon/hwmon66/temp9_label:I_RTS1
>>>
>>> Hmm, on the SPX it looks like this:
>>>
>>> I_RTS1:       +31.9°C
>>> I_RTS2:       +31.3°C
>>> I_RTS3:       +31.4°C
>>> I_RTS4:       +28.3°C
>>> I_RTS5:       +29.3°C
>>> I_RTS6:       +29.3°C
>>> I_RTS7:       +29.3°C
>>> I_RTS8:       +29.3°C
>>> VTS1:         +30.2°C
>>> VTS2:          +0.0°C
>>> VTS3:          +0.0°C
>>> VTS4:          +0.0°C
>>> VTS5:          +0.0°C
>>>
>>> So VTS2-5 seem like they may not actually be connected, but the rest at
>>> least look somewhat sensible. I'd probably still keep the names as they
>>> at least might give an indication what the sensors could be for.
>>>
>>> But there's a good chance that we're missing something on how MS
>>> envisions these sensors to work exactly.
>>
>> I think the takeaway here is that I'll keep the sensors disabled for
>> now on SL7 until we have a better idea and not block this driver
> 
> I had an idea.. maybe the busted sensor is for something modem-related.
> My unit doesn't come with one.

I think that could make sense. It is interesting though that SAM says
it's present (there's a bit-field indicating which sensor is there),
but I guess they just hard-code that the same way across all variants.

Best regards,
Max

