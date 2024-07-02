Return-Path: <linux-kernel+bounces-238106-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 336539243A2
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 18:32:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 660011C2342D
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 16:32:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBA7B1BD4FD;
	Tue,  2 Jul 2024 16:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VYm2vSAU"
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EEDF33CD2
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jul 2024 16:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719937917; cv=none; b=fdaaahiEOHt7C/wnivak5yq79lp1ZTVmk8Af3tGwndaOyDCNFtYNuqBKa2yOfyfB6NTTJsYwlyJ6gXF1D/rbUkWEG6EASoLYGDgVo3fpquo7jR96k98HQNq/EcCPJ/EswyxZN8ZwL/TLneT94x7gjNi0GjQOgcoBKmbiS8BeImU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719937917; c=relaxed/simple;
	bh=NcR4UoV+iV/iG/vFUoCs8a66N+aWGz/3elnHzo7rR5M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=j6cEZFvXPhhaY/t7nZ7m4dx9akWQX6kawKvSMuODvRkt898ZtPrroQDtyaem9sJ9T+Fji+HR9DILDBAF0YdvOL+bH9NWh+vABVp5CZZS9BJBVlzFJMfOO02kAsvIhCpAYUMhMtyXwwErCi9U38WawzJj0/ewOQB8GATqVvmIp5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=VYm2vSAU; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-364a3d5d901so2566462f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jul 2024 09:31:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719937913; x=1720542713; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SZ3nrMZ8xf5iqvSbwRyggvCmfkI8tHRxLTLxcqXvxrM=;
        b=VYm2vSAUKCBTaFlvvCXxe0UjzsRQPAFVpvzX440AslRnyfKhjXx8fvlamIjxNj8inC
         CLoaniKxd+iSUidxLVBxt3QA/wCnwv0+QcD673XZh7KtqklbE3jbJsBc+gsEZ1olpf5N
         zuRmfIvhvPAVOPrcbqqNJdnt1z8t4ZFsMKPnh0NOo0hdUocd4FZcZTS37cPqrTRPZVoQ
         T1rGKLl0fovU4sDvrmH/901FWukav3PmLbUiCk3umomE9R/tPoQv+4cS1f4Bzm5hM8Kf
         IUyLW1ZJS/muT8C61nwHuSnhjB1dTPKhfFNs2cT6imzgQqJCdTN9H17Z5WJnr92DQbyS
         DXsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719937913; x=1720542713;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SZ3nrMZ8xf5iqvSbwRyggvCmfkI8tHRxLTLxcqXvxrM=;
        b=FKmuzzx51gK8mVeYLqUx8XzAKV+444PpoC/vSCzI7eSiSSSyg9mWuHIO1Kvot6dtz7
         Sfc9opOcNid++CfijE4Xwp3/Mt2o7Dj0hXLMh9gaUX+KXh9ZK7qcnCukx4XQ890cRdgl
         3VkH746oMj6uh4lXvrQsnolVkYqpkRDoCX6qmOhpUYDIp8KLFOsghNW9l8KfWoIorJOU
         UdfSx+v6mz5Xs2pwHar+3bJP/Hco+X3URb+OZC/D2Xelm7Gag9OZgqLVx89N+7pb3djZ
         4E4NuH6LQDt6KPQdXMcmC5g15gUAENs+/js5NIVVUHHdLCSGCMv+gDpbfstlhT8mg6vV
         tI/w==
X-Forwarded-Encrypted: i=1; AJvYcCXF4HMlk0V3M1OF6un7IFBizJKLWcTnpRzdkJhOqKsyMNS1ySz6yPhwKUerGL1WFr+azxRujUKlzYyIO4MOmQ1k/bp7nzlFS6EPWl+5
X-Gm-Message-State: AOJu0YyUFgnesq9EhlGS0G2YJ0/azCAdgMXLVIvdciWUZvxmQ0vph3bH
	NzqNAJ1iNmd9irnKaOIhWCiheg3rWLrlDpS7PpqEbkfRPcaFF2/ey6jwB2FlnRs=
X-Google-Smtp-Source: AGHT+IGsZ1fgxA8SKHjpaB2XrBQgORgix+uj5qYoOc9dRc/F2eqJM/tlJoSyViIXlJRSGTc+c5ifJw==
X-Received: by 2002:a5d:47c6:0:b0:367:3cdf:c027 with SMTP id ffacd0b85a97d-367757248c5mr6463145f8f.50.1719937913525;
        Tue, 02 Jul 2024 09:31:53 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:c49e:e1a5:3210:b8c0? ([2a05:6e02:1041:c10:c49e:e1a5:3210:b8c0])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-3675a0fb967sm13637209f8f.82.2024.07.02.09.31.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Jul 2024 09:31:53 -0700 (PDT)
Message-ID: <2a8f5b5f-b67a-4bd0-afe9-f09473aea2d5@linaro.org>
Date: Tue, 2 Jul 2024 18:31:52 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] thermal/core: Introduce user trip points
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Rob Herring <robh@kernel.org>, linux-pm@vger.kernel.org,
 Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>,
 "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
References: <20240627085451.3813989-1-daniel.lezcano@linaro.org>
 <20240701162600.GA4119789-robh@kernel.org>
 <98fe3146-07ae-4095-b372-6aed6e080d94@linaro.org>
 <CAJZ5v0ix+RDtrR+r3jd=A_W7D5U7JodMiirJ519-wwLrHeBbSw@mail.gmail.com>
 <1eb7eb88-4230-4803-83fe-415ce0745951@linaro.org>
 <CAJZ5v0jV+0bWqpCR1Q2rYLJvx0J6hgExzRks6YDPL9gX_HK0rA@mail.gmail.com>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <CAJZ5v0jV+0bWqpCR1Q2rYLJvx0J6hgExzRks6YDPL9gX_HK0rA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 02/07/2024 13:03, Rafael J. Wysocki wrote:

[ ... ]

>>> Trips cannot be created on the fly ATM.
>>>
>>> What can be done is to create trips that are invalid to start with and
>>> then set their temperature via sysfs.  This has been done already for
>>> quite a while AFAICS.
>>
>> Yes, I remember that.
>>
>> I would like to avoid introducing more weirdness in the thermal
>> framework which deserve a clear ABI.
>>
>> What is missing to create new trip points on the fly ?
> 
> A different data structure to store them (essentially, a list instead
> of an array).
> 
> I doubt it's worth the hassle.
> 
> What's wrong with the current approach mentioned above?  It will need
> to be supported going forward anyway.

So when the "user trip point" option will be set, a thermal zone will 
have ~ten(?) user trip points initialized to an invalid temperature ?


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog


