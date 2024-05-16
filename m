Return-Path: <linux-kernel+bounces-180862-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 524AC8C740F
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 11:46:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C13271F24650
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 09:46:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F8C214386E;
	Thu, 16 May 2024 09:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="V9C9aDvj"
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C31BA143866
	for <linux-kernel@vger.kernel.org>; Thu, 16 May 2024 09:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715852761; cv=none; b=AqzNunXsR5zd5U7gcP+6Y0jY13AWuUcyfmVaOiWpDdGTBOG5rJY1W1neaei/ckSHGhHn2OhBwMTMpLZLCi2PB9iWsi6MS7XzgAqnh3v93lCzCgx27gF+Nl0zuDjLxCa6Px3zeRWCeFQJBmCuMwm+XNrBY719enXWrtlpogikcck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715852761; c=relaxed/simple;
	bh=sk30qgPUSP5VMpqNvzfTm4tREso0iPAES3Zy5BrkDD4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DzR6hO2gfgK2hlCbYH4bwNIs8cu/WEBNKG0UVY2icg0C8U8F9j5cNaJi54w//VTF7iiyjtvprVgSd6AG89qhoaoWV7pL5Czk/OKGFAY7b3j+e/EpDGAJJhGprmQDoausY4I0BRyuw9BtaZ2zK43Os1eRFDIIXuXbZ/7Kh4CyRTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=V9C9aDvj; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-34ddc9fe497so4881560f8f.3
        for <linux-kernel@vger.kernel.org>; Thu, 16 May 2024 02:45:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1715852758; x=1716457558; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gfUhSrVZG2CLLkDQLu8KJ8fPEH7JKufyK+L488gLenI=;
        b=V9C9aDvjybqcPUa8l0dImZlcq2ZJ98HsfbJdLjwvpKrMZgR8OgZygcs9v+mNSEdlCN
         r5ivaCVYeNbFIz3wAFLguv+U/sxYcuyK0W86fR3b5IUWWrsEH5Na68g/uyVxu7HDNFu3
         w7maLV4UqZ1OvYxm36hGMsSD1qq8I0UxuU2fdod6zSEjwZA0sj3K5/lm+xOpCnJzoJ5l
         D6/wl5Lz72t/5fqZTy1IEKHlW3IYxNlS1DKjyocSMyMaGlruAioxC/TZouQMMH4I6kCM
         WjWI7sPxLSMClMR3DeKoKWCoJXJ5+h5073OXmZpu1jtU6yV+HboGAnRlULkY5p9ifhTW
         6ydQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715852758; x=1716457558;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gfUhSrVZG2CLLkDQLu8KJ8fPEH7JKufyK+L488gLenI=;
        b=YtNK6cbGvnppLzCjFaP9vdk1Kb4JowLmqMRWEQKUe0KSQWBFx7tYfWhH7ExPOl+j44
         sQwOp66vyTJ05Bi7VkBjZJXtRAuekk2D3CFsdvBXmsn00Nj0b8Nxr0D1BlHzFN5sivwH
         WhisvVaHumMyKknuYJHi1DC4vu3ZTp86+Sg5RdNgojPhW2OaxUURiOzEMPbEcDwT+Hx/
         daLiTOweq9RcQmnCRyB1zpHi77tNnH8g7/1N3VjddjmWBRmuistZE6+OMynYoO2vUwAR
         IOUw6mFUsjvUmzLQf10NQnAq0SBH73pjOtpdPb3s/GenzvfJEQf9tbQGG6OGqfk/Qw0A
         Ab/A==
X-Forwarded-Encrypted: i=1; AJvYcCWDXZni1+0bfjoQ9KAAxQEwfFaDHPxCKHQq7uwt6EWqoM6WUyJmG4kPnHQxSQSkkKLtUnheNnthL97Gn4Reg4ipaLvtz/5SzxxGSKt0
X-Gm-Message-State: AOJu0YzLorB9u+KNZjdof9GDJE/Bf0abCMRJWWlBEAQ4S7Vlx5loiZYL
	T4dvCUDMLG6ylK1nkiZkiW+lVE2qn6yHRFWndrijY5g4QLigItVS8pJoRMEnECo=
X-Google-Smtp-Source: AGHT+IHOI2nq9U7R2THlqTlle6ZvaaiGSKn/bBTzfUSdjpTQ3Q9wafLDNp9Iz6mIii2pvyTa1FD8CA==
X-Received: by 2002:a5d:52cf:0:b0:34a:e73a:67a1 with SMTP id ffacd0b85a97d-3504a956039mr16342164f8f.56.1715852757928;
        Thu, 16 May 2024 02:45:57 -0700 (PDT)
Received: from [10.91.0.199] ([149.14.240.163])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-3502bbc4b41sm18515232f8f.113.2024.05.16.02.45.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 May 2024 02:45:57 -0700 (PDT)
Message-ID: <65a94273-7fa5-4352-a24b-a08a1f244f99@linaro.org>
Date: Thu, 16 May 2024 11:45:56 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/6] thermal: sysfs: Trigger zone temperature updates
 on sysfs reads
To: "Rafael J. Wysocki" <rafael@kernel.org>, Lukasz Luba <lukasz.luba@arm.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 Zhang Rui <rui.zhang@intel.com>
References: <13518388.uLZWGnKmhe@kreacher> <3304112.44csPzL39Z@kreacher>
 <39e15eef-f7fd-4e16-bc74-7f1c6820fe6a@arm.com>
 <CAJZ5v0gZJE6jfa8_9LgDdjYotY+crLH1JJXHdAWREPz4SJ305A@mail.gmail.com>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <CAJZ5v0gZJE6jfa8_9LgDdjYotY+crLH1JJXHdAWREPz4SJ305A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


Hi Rafael,

On 16/05/2024 11:04, Rafael J. Wysocki wrote:
> Hi Lukasz,
> 
> On Mon, May 13, 2024 at 9:11 AM Lukasz Luba <lukasz.luba@arm.com> wrote:
>>
>> Hi Rafael,
>>
>> On 5/10/24 15:13, Rafael J. Wysocki wrote:
>>> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>>>
>>> Reading the zone temperature via sysfs causes the driver callback to
>>> be invoked, but it does not cause the thermal zone object to be updated.
>>>
>>> This is problematic if the zone temperature read via sysfs differs from
>>> the temperature value stored in the thermal zone object as it may cause
>>> the kernel and user space to act against each other in some cases.
>>>
>>> For this reason, make temp_show() trigger a zone temperature update if
>>> the temperature returned by thermal_zone_get_temp() is different from
>>> the temperature value stored in the thermal zone object.


The hwmon system is doing something similar and I'm not sure we want to 
mimic the same behavior.

Just to summarize:

1. There is a polling delay set

This polling delay gives the sampling rate the thermal zone is 
monitored. The temperature is updated at each 'delay' tick

2. There is no polling delay set

The system relies on the interrupts to tell when a temperature reaches a 
threshold.


On the other side, if the governor is in-kernel, then we should not read 
the temperature of the thermal zones because it is the job of the kernel 
to do that.

Actually we can assume the temperature information exported to the 
userspace is a courtesy of the kernel when this one is managing the 
thermal zone.

If there is no governor associated to the thermal zone because there is 
no cooling device associated to the defined trip points, then we can 
assume it is up to the userspace to monitor the thermal zone.

Furthermore, the hwmon gives the temperature information with the 
caching and because of that it is not possible for a thermal daemon to 
correctly handle a thermal zone.

That said, I would say we don't want the userspace to influence the 
thermal zone monitoring in any manner.

 From my POV, we should keep the code as it is.

The description of the change says "it may cause the kernel and user 
space to act against each other in some cases". Is it possible to give 
the cases when that can happen ?




-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog


