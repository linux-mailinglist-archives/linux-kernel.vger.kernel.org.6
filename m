Return-Path: <linux-kernel+bounces-244292-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E3DBE92A241
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 14:13:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 93D131F2613C
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 12:13:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 595DE13A407;
	Mon,  8 Jul 2024 12:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NWhhWVC8"
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB54A80046
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jul 2024 12:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720440398; cv=none; b=EINomtToXZhVcF6AaZzhVSCORmlEMU/u3Bq4pylItRwyib50GT5W3dtUGgFNwTwjclcNL5BLMne0nzY+mryVCKnNcuD1Lu8WgI9G/TefU3Z/soUYZZnjRG56xU6vWcWQTZk2ay48P0h9C4+9MRG2RtLbKMz2ZOUy1KHb6E7iccQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720440398; c=relaxed/simple;
	bh=vvhp4fRApGwcWx+HYgN66svEhYeuk2Cy5WZpOCo0nx4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dSdjfbvavTIsjhkuDZCq4lycqxmA+SHE6fKZOGIez3t5glDK6rUR2oF0hn4kwLMfJbaGAa5c6VPiCsGlFW46Zhbp45c5Y8BlmU2B1oJgLnvC+GHUc/pJFEhcwskR+Pv401XYYHx+jWIoiGnjOZJizhIuUJSw0g96xTV+f/RKVPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=NWhhWVC8; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2ee910d6aaeso42987761fa.1
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jul 2024 05:06:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720440395; x=1721045195; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GIOHsuoN+RJIrgoMh8AOlVtaMS5uVmOStC/SKT1pRY4=;
        b=NWhhWVC8IkFdOxM8oeAOq6g1YgxyiZ+LrU+YiMumcYIOP9Ug5xM+n7amIBKEA6EQHL
         Tr3NawyaZIEgqdXvbg6VF+SbXzvDeWpCI99nxh4RVFRUVHcqgKKzGyPKhF8YJQOjoTFD
         Pzfne7Rw57BA1Miuc9Dbc9XMnoKzqujZ7WqjtGYLDY0UNtwUPBrXie+fHvndR92KTxYf
         BY4S1BsFl08LYnqCKrakxDCqWYsNMYcU9zB8AuCkVm+FoYEvpCF0cYRkLZQcxX7lBOXN
         fEL05YQCHh809UU+h5NmNbopMggeAQpxgnnm03wTpd2QHvOMRAtai/1FNY36KcRKb8+M
         FpCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720440395; x=1721045195;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GIOHsuoN+RJIrgoMh8AOlVtaMS5uVmOStC/SKT1pRY4=;
        b=boykat4oJyfOxSJkVFmHaiEWxvJc4hJiGW1qiD5HA2W4DeXqGETK3xJD9u9qLPB3z0
         LipLCKw5NEWOb7BwvfJEjgDu+lOJHxSAQv8Q2VKo74bsrVZAAYKvmr5C2pU5JX2/GSI3
         oshrBlEdG5efz+cBKLHnx8TaSBZQtqt9APWFin/z9ied2JnuhnFsPFsIb5o+ehDiqHlF
         EWk5HbHbEJxyho+zV9oTg8BQYqOT8hUTbT5dZ9ziOmSQsfOexyNj9LzD1wVBSzidCOaZ
         rlcM1KyDID2xQaQt32DV6QGit98frs5aeF2CXzAGYtaqD1SU4eiQmJIWPccArgH7ERm9
         QTxA==
X-Gm-Message-State: AOJu0Yz0BfRfrMBfUXPBQXosFHE1/zV0uoFY19VHyDvSKP7SyCgJY7Nm
	OeFsbsRLX/QL7fMmzZP5l3aSseeLaeHzaqgkSPUhBAvbAXk+YfO2bD2bb3fwfylCRKp0pjDlBYS
	i
X-Google-Smtp-Source: AGHT+IGgWz353tljKhdO83u9sS54lkUMOPfQr8fMIV7vCsqQ+f3NT52R0i3CP1D+AoSSca2X/CFjuA==
X-Received: by 2002:a2e:99c9:0:b0:2ee:8bc6:6817 with SMTP id 38308e7fff4ca-2ee8ed5e0ecmr71535501fa.16.1720440394755;
        Mon, 08 Jul 2024 05:06:34 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:c49e:e1a5:3210:b8c0? ([2a05:6e02:1041:c10:c49e:e1a5:3210:b8c0])
        by smtp.googlemail.com with ESMTPSA id 4fb4d7f45d1cf-58f4114a9ffsm4282023a12.12.2024.07.08.05.06.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Jul 2024 05:06:34 -0700 (PDT)
Message-ID: <402ede79-5eda-48fc-8eb8-5d89ffe6bd41@linaro.org>
Date: Mon, 8 Jul 2024 14:06:33 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] thermal: core: Add sanity check for polling_delay
 and passive_delay
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Lukasz Luba <lukasz.luba@arm.com>
References: <2746673.mvXUDI8C0e@rjwysocki.net>
 <4940808.31r3eYUQgx@rjwysocki.net>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <4940808.31r3eYUQgx@rjwysocki.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 05/07/2024 21:46, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> If polling_delay is nonzero and passive_delay is 0, the thermal zone
> will use polling except when tz->passive is nonzero, which does not make
> sense.
> 
> Also if polling_delay is nonzero and passive_delay is greater than
> polling_delay, the thermal zone temperature will be updated less often
> when tz->passive is nonzero.  This does not make sense either.
> 
> Ensure that none of the above will happen.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
> 
> v1 -> v2: The patch actually matches the changelog
> 
> ---
>   drivers/thermal/thermal_core.c |    3 +++
>   1 file changed, 3 insertions(+)
> 
> Index: linux-pm/drivers/thermal/thermal_core.c
> ===================================================================
> --- linux-pm.orig/drivers/thermal/thermal_core.c
> +++ linux-pm/drivers/thermal/thermal_core.c
> @@ -1440,6 +1440,9 @@ thermal_zone_device_register_with_trips(
>   		td->threshold = INT_MAX;
>   	}
>   
> +	if (polling_delay && (passive_delay > polling_delay || !passive_delay))
> +		passive_delay = polling_delay;

Given this is a system misconfiguration, it would make more sense to 
bail out with -EINVAL. Assigning a default value in the back of the 
caller will never raise its attention and can make a bad configuration 
staying for a long time.

That said, there are configurations with a passive delay set to zero but 
with a non zero polling delay. For instance, a thermal zone mitigated 
with a fan, so active trip points are set. Another example is when there 
is only critical trip points for a thermal zone.

Actually there are multiple combinations with delays value which may 
look invalid but which are actually valid.

For example, a setup with polling_delay > 0, passive_delay = 0, active 
trip points, cooling map to this active trips, passive trip points 
without cooling map.

IMHO, it is better to do the configuration the system is asking for, 
even if it sounds weird


>   	thermal_set_delay_jiffies(&tz->passive_delay_jiffies, passive_delay);
>   	thermal_set_delay_jiffies(&tz->polling_delay_jiffies, polling_delay);


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog


