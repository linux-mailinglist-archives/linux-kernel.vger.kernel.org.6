Return-Path: <linux-kernel+bounces-380348-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E95109AECB7
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 18:54:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A05461F23393
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 16:54:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D4B45FEED;
	Thu, 24 Oct 2024 16:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JG7Fb6Zd"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B04F91F4724
	for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 16:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729788871; cv=none; b=BUr7rH8Mb3pbJwnyN2TBB+36TDhA2gG5DakfNroGOoaGa0BbsmUF46IamfeoRtKVS50gSHBAEJK9y6nU+uocFTwCxQTfzY6LA0iiw2gUowWDZUBZkY54XAO/HE+zOUobjRa7/Dp8WTHuU3ydMg9qmix9IVO6lUzh9+44hUIfyfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729788871; c=relaxed/simple;
	bh=aLx7QG6uY3rZrJhStO1VgJs4ypcvdpgfHRjqSN9+C3M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Et6cIMvuURylftn7gC6zEhU+oq/HT2CqpDBmXVH0Wx6o5GDYjZ0s1T5rMlH/9qSaVWYgFUHzHV00XlN6TD0k3j0NQAErWFZfuYUjmVy1ynChTkB88ZVBDF0KvmDaxtdH5FsZXaZFSO4TkcAMpojX8zmVJ3XBQ9Ers5+AdhEGRjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=JG7Fb6Zd; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4315c1c7392so11942205e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 09:54:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729788868; x=1730393668; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Eg+iruVMbHZEdj0Scj2SHzkcTg3IW3N7WkF7hnD85K0=;
        b=JG7Fb6ZdW3t2o0DTq6j5vgS8JeABPw2phTlUzYYJ4Hzfon/OQw8Z8RP/Bnx+5vtC2m
         ch2eYPJkIpKPdK+ZhYqSfhbUy+c4GFIYs0hge42s2M5CcaNlWw1qY8VUe5Hpb1mPrCpI
         UecdfTTAeu0KO63gaVUXOm96i8b4hfGyYqGsvMbuscPanghHbbwZYwQwALvZ8jI/k9Ml
         894e/BnUvjFlF6/zXGI1z9ZBq5skZQfdgMH8Hsxvk1sXUlgF7BCH64bINUwsGAhIj78x
         MfK7315gR8hAASr4XifElEkjq7PB8edQ7fzyqrPLuXPGtsjLmPEeEZsU5XrMzEnzggeA
         4q5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729788868; x=1730393668;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Eg+iruVMbHZEdj0Scj2SHzkcTg3IW3N7WkF7hnD85K0=;
        b=IdfdAW4EhJbn+kDzfF/Tz6QvLyHQM64E9l+rRsxwo6rQY6skqO3pGDaXnZQ8Qgw5dm
         B9zzMhRVHHBk0RWC+wYfRzBRVNT/p3vztbkz5HNG3gA/LEEGo9gXU+ZUvcdL2fezeHbF
         zcQ0coA+3LIPD/oQPNeLjM2SbqxNpiAxDku/FVbcmZkFd7ipVU/D/tFVwUineVM2gvN0
         3UrNT1rD8muZaCQZhKwfV7HZojhNQKqmztzc7wSYu2qbgYsBW6TD31JydbXSZd+fc0Fk
         VgFZv7PVVpoTkjORy5h4TVVKGzLAdVyGbVp+hzYxzDM9WBtfSz5XexKnFwQNVukMdtq5
         mnFg==
X-Gm-Message-State: AOJu0YyPPoyM/i6C52idH4zdG/BHykOSpMeEVj5k47TsNe0ggGQUQcaP
	W7fKafJ6DLx0qwYdMmRrtynT+1BIp46X5KCi/BeQHSikopBBAGFO/oLYLfGkE1M=
X-Google-Smtp-Source: AGHT+IHRhetOY+GKLKLp0oFrYUIja4ZNjkEHbsFvHWSLLr6AEUKGn86j8jttfbFPxFSow44v5ZAQMg==
X-Received: by 2002:a05:600c:4fce:b0:431:5533:8f0c with SMTP id 5b1f17b1804b1-4318425fb2bmr62248085e9.29.1729788867920;
        Thu, 24 Oct 2024 09:54:27 -0700 (PDT)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-37ee0b94363sm11788307f8f.73.2024.10.24.09.54.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Oct 2024 09:54:27 -0700 (PDT)
Message-ID: <6de4bf6c-ed59-4d32-9e26-19309c8ab543@linaro.org>
Date: Thu, 24 Oct 2024 18:54:26 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] thermal/lib: Fix memory leak on error in
 thermal_genl_auto()
To: Markus Elfring <Markus.Elfring@web.de>,
 "Rafael J. Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org
Cc: LKML <linux-kernel@vger.kernel.org>, Lukasz Luba <lukasz.luba@arm.com>,
 Zhang Rui <rui.zhang@intel.com>
References: <20241024105938.1095358-1-daniel.lezcano@linaro.org>
 <45265aca-7371-455f-819f-c4d68cbb089b@web.de>
 <9ba3fa17-57c3-41e9-9e19-33fa105a179e@linaro.org>
 <CAJZ5v0jWGdzakj8ob2otAO6auwGBvVsewujG-d9b1Z5nnO7Vkw@mail.gmail.com>
 <03a4edf1-9562-49fd-81fe-d96f46a41d28@linaro.org>
 <d8623fe7-3035-4c61-ab8c-502e3b33ecdc@web.de>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <d8623fe7-3035-4c61-ab8c-502e3b33ecdc@web.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 24/10/2024 17:19, Markus Elfring wrote:
>> For correctness, I'll send a V2 with the return fixed
> 
> Would you become similarly interested to increase the application of
> scope-based resource management also for the affected software component?

Yes, I know it exist but I did not take the time to read the 
documentation, neither had the reflex to take care of that. Something I 
have to do :)

It seems like this function is a good candidate :)

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

