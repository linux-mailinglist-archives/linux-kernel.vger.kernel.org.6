Return-Path: <linux-kernel+bounces-408138-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 38FAB9C7AE4
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 19:18:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6C5EC1F225AE
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 18:18:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93654202F8E;
	Wed, 13 Nov 2024 18:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vpzsf5df"
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D87751586CB
	for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 18:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731521891; cv=none; b=ZbzAO81I5czQELRHsZ1xispDTD6dzc69qRD4O/aUE4S0FvH00WWtNunkT/xl4UUc8LGyoxrtGB/8s6LXAJvuKS5Prt7hoEDuGqPbNMaNrvQk7ADJizLcY59kezRL0Frznd4jXL7ay5UEvcuSy/vBzWrKekVInEbcN5UqB5vZbF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731521891; c=relaxed/simple;
	bh=hEmpp2nGMQFSZrQajXmI8OL1Mf8n48M60jnyic/SXPY=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=bgooBStlRd/e9OqsVBsZl6JHbtjYxaFYdJlhTyXNiII68v3EJCtTRsGY1LdVKc36qs0hoCw1Y0ro2GQ/vHKN9qtbGqTwa905abyDq+o0VCGZzXaX0izF/oygTcTKdtWWiDN68/jhsJyeLXOC9KAY14IC/3ucFP6h+D0g+qe3C7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=vpzsf5df; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-53c779ef19cso8636317e87.3
        for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 10:18:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1731521886; x=1732126686; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=tAIY4e+nFwJ6QvkC9kPfrl0tjap1nueeybQc4XVeRTA=;
        b=vpzsf5dfmrL3h/pzpARqk3HuMrreVhk+miVAGGaO2d9/2knmuRyjaBBaZw853Go/PN
         iWZ9YznqoWRojOyom8EmrOa6nwsPFI+O8PIHjaZQ4EjSjITwYzymDnN4zuZlY5EydK8B
         NswjqU9fxXdo9zFzMRGfg2RvDvKLY35ZgoBuYWuqXCvYJllO8Y5LwPdx0Uehh3ULpVvq
         HfLhfLVXy5zdqjknt7tb6mhk3tjRlHg+FkqDqkSyHgxqRi8nYDsH+a5gclI1UxA3jD2/
         5K5hqWXLnMNEgat9igk4Jkui36wlHFBURCjfuSO0gXjxx3FCjUtX5IleuqerDWOPlFzz
         USLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731521886; x=1732126686;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tAIY4e+nFwJ6QvkC9kPfrl0tjap1nueeybQc4XVeRTA=;
        b=kHH6fsuiTdO3I3Qmv/Dv/pwihxQdDei3JTGr+gkz2cythFeUcbbLkrJC48TT6j/N+I
         ybnxtZsZPp6jgpRI+VwpAXAElJFDb+9x6tRNTRU28zV/+s+/svFoKG49M57jwJ3oK49v
         s/6GvsrJ73AtXO2orvA1H3ZZjcFzZ9NGyBVcwluD8sI5YQIdqGTe3NqkdY9HZPfB7J/9
         b6NMuljtHpzkVIzlnMdtLhPCCyYmzwDpiXxOoby2jI6biD5H7aWPF3gmk2kxhUxxp07C
         ZouA1Cd+g83Xf8fSUgGGpFloOBktjOzOjvcBbrq21nWHkfPulwv6F/hjR+UisG02Tvt1
         Aecg==
X-Forwarded-Encrypted: i=1; AJvYcCWg+TQ4OGuBjwvg7jtF2YXl9nRZeKkAdBLsvdXCdtXr/Xlx4L2WAzsE78vhKdxnKB6N/GL1AQNjf7+rEt4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYT/LhgQNsDMvcLSYFoVpa2nZjx8sDQrqN/2H1GiB4u15cst7t
	VTFyP9uZF/80WPZEPPWa0T50BQLmVC1+HuThvQrJHlyML6ORCYuMD0JvjsfFumnkfOHt+yWnDf3
	e
X-Google-Smtp-Source: AGHT+IFglkeI6r32PMMOYdeEIyDlK6/q1n2Mf24sf/LbW1WwZdIjzqbhaymCyPGrKUmZOzNVWVy/4Q==
X-Received: by 2002:ac2:5049:0:b0:53d:a07e:9c22 with SMTP id 2adb3069b0e04-53da07e9cd0mr1592717e87.33.1731521885941;
        Wed, 13 Nov 2024 10:18:05 -0800 (PST)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-432d54f76b9sm32140295e9.14.2024.11.13.10.18.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Nov 2024 10:18:05 -0800 (PST)
Message-ID: <487d0de5-6f70-4b82-a22b-5e74ba32da11@linaro.org>
Date: Wed, 13 Nov 2024 19:18:04 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/3] dt-bindings: thermal: Add support for Airoha
 EN7581 thermal sensor
To: Christian Marangi <ansuelsmth@gmail.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Zhang Rui <rui.zhang@intel.com>,
 Lukasz Luba <lukasz.luba@arm.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Lorenzo Bianconi <lorenzo@kernel.org>,
 upstream@airoha.com
References: <20241018104839.13296-1-ansuelsmth@gmail.com>
 <6734cc42.df0a0220.4521f.ac78@mx.google.com>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <6734cc42.df0a0220.4521f.ac78@mx.google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


Hi Ansuel,

On 13/11/2024 16:56, Christian Marangi wrote:
> On Fri, Oct 18, 2024 at 12:48:04PM +0200, Christian Marangi wrote:
>> Add support for Airoha EN7581 thermal sensor and monitor. This is a
>> simple sensor for the CPU or SoC Package that provide thermal sensor and
>> trip point for hot low and critical condition to fire interrupt and
>> react on the abnormal state.
>>
>> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
>> Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
> 
> Any news with this series? Everything wrong with the thermal core small
> patch?

I understand why you are trying to achieve this but usually it is the 
kernel which overloads the firmware description, not the opposite, no?

Either way, we ignore the offset/slope from tzp and use a couple of 
private variables offset/slope in the driver (iow do not call 
thermal_zone_get_offset() thermal_zone_get_slope()). Or add the 
thermal_zone_set_offset() and thermal_zone_set_slope() helpers.

I would prefer the first solution as for today I can not see any DT for 
ARM64 with the coefficients set. So may be we can consider the slope and 
the offset as a legacy which should be removed from sysfs and the 
thermal zone device parameters in a near future.

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

