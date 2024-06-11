Return-Path: <linux-kernel+bounces-210609-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 80206904633
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 23:19:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 15F4F2886C6
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 21:19:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AA47153580;
	Tue, 11 Jun 2024 21:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kali.org header.i=@kali.org header.b="ZZXTUq5D"
Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4054A1534EC
	for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 21:19:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718140777; cv=none; b=LOhEIjHcMviPUOP/CLbn7mFWPYb0OT75BvmTxz2k+RJjYX1uIlq8P+SM+4ZI8TEzzR19dSdZgGIwZRWv0TKRv9HKO3T7ro9KzoBHtcSrZO68HFsVczdmB+PXf2CXJ1Ukt2ipUskzwcZIZVru8oOy9ldtdWfCb5h2qdZQ7khaKag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718140777; c=relaxed/simple;
	bh=ELCydqjpdFo4e5YLr2TqZB1sj47Z8XFwUvs0m0bOxMk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JPhAWSoUZQ039rm/zbKTp0a80Fli4xda2B7abcsDUj2qMPT7NoW314BFD27f9zf/EGkBAy2M141FqlEksX68nebM6MedUiX1ruzu75WmxTCGXFEgkZ3IHxItebIUw+bwPJPUoLZScjiW1k5TOieRJDHF1Ctr8LHM8RbKGt54nWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kali.org; spf=pass smtp.mailfrom=kali.org; dkim=pass (2048-bit key) header.d=kali.org header.i=@kali.org header.b=ZZXTUq5D; arc=none smtp.client-ip=209.85.160.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kali.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kali.org
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-254c22faf4cso1202514fac.2
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 14:19:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kali.org; s=google; t=1718140775; x=1718745575; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kIrp8qzhxU8e7FrceQyxypKcph7vNSgb2Uumfdyvzas=;
        b=ZZXTUq5DSYPqKc7X1syAQURklKwKIu4veTOWNmvnbazNSr/X9ggmYT7UHia8VThni9
         gp0nMJKuTUCzZRQfJ71ZcREljadWQmYHCRcT2XU3Vnx7a6tFM5YzjeE1iQCYsAkblqd7
         BIpggKAVtm0kg+cs34nYT4QDKfk1pSFFoOTdGeITrcGWKiO3zErCyy4KDqKyh++lt7J1
         eVocFQPMou+TB79OuyIcXuTwzwQGKwOYnhlIpXdxswQRvvoSuL9s1h3efoWBFGnx3gE4
         gAwtNNFuublJxvw2FTiNdi/39vALV8DbVInxv+nA4aUzY0wlDKH3I1mTF6INSkswXvZ5
         IpOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718140775; x=1718745575;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kIrp8qzhxU8e7FrceQyxypKcph7vNSgb2Uumfdyvzas=;
        b=WozLBKvoewIzKt7RPvjfQyLYL+lzdg11fEPxe04ni88AcJlyLN/vbYGgVhLMN07ssw
         IX+RboxIv9be4vpQVtnj2sJ8I2ogNJLFe+1dYrOTUz9nk3sEEamXyf8qWKeKVeIMC8bu
         Y2KgtdFh47PuZk8wll3M5jHqSQZehgnZx3y5eSmNl/O+g/AQXj+xPVRZqzj3J2+YhVTw
         yUpBuvnFf8KW7EftluhZ34pZAApt+OtAPqwBQwNAGHHf4kUWcY2+khToq+LOeovImDgK
         pH1hgOsW6p+tooNotUTbkBqdA0j4boXFjkqpJHtZPw+eH3SRGC7mNUaQIHl3gcZB+6ts
         NOgA==
X-Forwarded-Encrypted: i=1; AJvYcCUuBDWQDKQ/rwvAljeNPEKGa2RUt06ct6SDTOsDJHTxqAJf5zs17IjilY8FZAGRSKfyruhdwFNvgPxFYeL8yxATjAVC3ukoyhdFSknx
X-Gm-Message-State: AOJu0YxdtSXMLQJgFEgvkafwTa5gzHYhHgqTUFahg6JuYNW/4s3LcfDL
	sIueqe7TaD2kiDnDNvXZKWwoDvIwNkj2gtPrx+krLYmaoPUMhdtIl3dzN9T0YNE=
X-Google-Smtp-Source: AGHT+IEspAynUq6bEDt0FQbYW3uXgAn4JXj6JpZ/+Vmr9hn7HqhaGFU2dhDx1yYp9Pq3vY+Wts3Rlw==
X-Received: by 2002:a05:6870:f113:b0:24f:c7cf:17fb with SMTP id 586e51a60fabf-25514c037f9mr50908fac.22.1718140775044;
        Tue, 11 Jun 2024 14:19:35 -0700 (PDT)
Received: from [192.168.1.98] (104-48-214-220.lightspeed.snantx.sbcglobal.net. [104.48.214.220])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-6f9d9a98e74sm616426a34.72.2024.06.11.14.19.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Jun 2024 14:19:34 -0700 (PDT)
Message-ID: <f288cbb9-af88-4c4e-94d4-60b0829bd0dc@kali.org>
Date: Tue, 11 Jun 2024 16:19:32 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: cpufreq/thermal regression in 6.10
To: Johan Hovold <johan@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Viresh Kumar <viresh.kumar@linaro.org>, Zhang Rui <rui.zhang@intel.com>,
 Lukasz Luba <lukasz.luba@arm.com>, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org, regressions@lists.linux.dev
References: <ZmVfcEOxmjUHZTSX@hovoldconsulting.com>
 <CAJZ5v0gVnjVyd_O6KgXy2sXr3b3M3vyTLyUCasyxP0GrAXro4Q@mail.gmail.com>
 <CAJZ5v0iz7gwhpvT53CH0ZEA_q3U=dnn6XR8HdLk6LpP3ye4Zkg@mail.gmail.com>
 <Zmg8x6JXQW1dqOr4@hovoldconsulting.com>
Content-Language: en-US
From: Steev Klimaszewski <steev@kali.org>
In-Reply-To: <Zmg8x6JXQW1dqOr4@hovoldconsulting.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 6/11/24 7:02 AM, Johan Hovold wrote:
> On Tue, Jun 11, 2024 at 12:54:25PM +0200, Rafael J. Wysocki wrote:
>> On Mon, Jun 10, 2024 at 1:17 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
>>> On Sun, Jun 9, 2024 at 9:53 AM Johan Hovold <johan@kernel.org> wrote:
>>>> Steev reported to me off-list that the CPU frequency of the big cores on
>>>> the Lenovo ThinkPad X13s sometimes appears to get stuck at a low
>>>> frequency with 6.10-rc2.
>>>>
>>>> I just confirmed that once the cores are fully throttled (using the
>>>> stepwise thermal governor) due to the skin temperature reaching the
>>>> first trip point, scaling_max_freq gets stuck at the next OPP:
>>>>
>>>>          cpu4/cpufreq/scaling_max_freq:940800
>>>>          cpu5/cpufreq/scaling_max_freq:940800
>>>>          cpu6/cpufreq/scaling_max_freq:940800
>>>>          cpu7/cpufreq/scaling_max_freq:940800
>>>>
>>>> when the temperature drops again.
>> If this is the step-wise governor, the problem might have been
>> introduced by commit
>>
>> 042a3d80f118 thermal: core: Move passive polling management to the core
>>
>> which removed passive polling count updates from that governor, so if
>> the thermal zone in question has passive polling only and no regular
>> polling, temperature updates may stop coming before the governor drops
>> the cooling device states to the "no target" level.
>>
>> So please test the attached partial revert of the above commit when you can.
> Thanks for the quick fix. The partial revert seems to do the trick:
>
> Tested-by: Johan Hovold <johan+linaro@kernel.org>
>
> Johan

I can also confirm that it's working here!

Tested-by: Steev Klimaszewski <steev@kali.org>


