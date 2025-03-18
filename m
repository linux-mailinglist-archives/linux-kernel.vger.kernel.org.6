Return-Path: <linux-kernel+bounces-565821-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DBF7A66FC1
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 10:28:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D3508172665
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 09:28:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B43782080D3;
	Tue, 18 Mar 2025 09:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cyaW8K3g"
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59784207A2C
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 09:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742290040; cv=none; b=D5xCgTh+jbQCO9ay1YUrbh6Jiyy/p8X0FfBySZj2mGaM1kgrqDztkzhT12IIK83DcGtLtb051/ZYARCgBMEtE+ijS4EuYOGFqNJaO6OtD4ZSLFiUe4wHDUF87hvYdhFZzRprEgmPZkWFSLLk0n9UKNztDk09AuVKQwAJiP7pcT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742290040; c=relaxed/simple;
	bh=pck6Ds5DmySoVIyHuUT2dF/NAU91PM3KWqBmcEgnzIs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=S2/V+i/jhBnAbVE1dxUpxZ60Xye6RlNNHYI2ouALNueawdMLtY2QC5GZE7dPyhkE+Qa/Au3nn5tqjvvWSwVzdt+ljHY639WrvFHCW/YQMPVdSnQs31R8vuTVvBdhkixMI1WziD8tUdi0E1+bRGz3DDo7isaJvDyZYfnm+ItuED4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=cyaW8K3g; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3913fdd003bso2633343f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 02:27:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1742290032; x=1742894832; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=C7TGD/sTJc0OtjwahroX9tclP8lTIbogOcbW0Jwqg2g=;
        b=cyaW8K3gxJQXTFyh4HqrzCEgiXjXeeVpTSxw/dNF5GrYmlvevszJHPaaOytrxog1w9
         HCnq1bo/QjxjJdUUKworrE8iDZwN3Pyv5ZwyGrfYN647uXvORWK06YquqkebihgpyKTH
         sanKGuyu7v5coh+typS/v/30h0HFGgS7tK96ntnGFuYPSk+Sx9wR+RAtDRkip1flEQVr
         08PT7vB8IqHq1eu8dobwst3skY1w8eN5CnHkQaVTGDAGf4UbaUK07BbhzgkPphM8GcTD
         jYPD7J7XmhF0ZQuORKeYLftVE2RG0YomSt/LZDkFn/rsFaeyfXAn9/K+bHy32dYyEq4S
         S9Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742290032; x=1742894832;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=C7TGD/sTJc0OtjwahroX9tclP8lTIbogOcbW0Jwqg2g=;
        b=QmLoa89NqXwkeXW6vqFRFIYMtkrl+k/yV3k/CdHOnMnXMRmuGQ9NrVBYZh/GnvyCf5
         iJG9wiP3/4JChYg9NAMkWB/ObnvOfkCU8mwkpUm4/VrEPOFMZXQ6kevFVuNe8Mujg85p
         aE4DYngAp91dGuMIbePXBLFxO64vgFLcXIfg1tKBaezz4ZQhPrZ1Uu75gbbhzqiJkg9s
         cuERGlXwCITTlNPEPjqmhTli8NEM+A52WDycBxHEFTAJDuVbfeMvv74axG+C89MoFufh
         +PWIFtB8HUGoAAExSg9WsdC/hAmfaoer/6h0Ub0Xk68uD6Ge+X1P/3UoAQ19RMyqJUjl
         7gug==
X-Forwarded-Encrypted: i=1; AJvYcCUYhKrdIbLTw5DHVsKq/RN9EF3HH4e2B7SMrwDkKGzt3TjwAnM+bhNmNRJNReNgOe6gKH8zyVvMFTv3UKQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzIyy+eveDsKgnCTFSKzAgrCQWo6hiaIhE30z47fbZWzVQt7G3i
	WPHW6RigvOCcjv7jolqBQQ9R0ad3PRENSa77JYJevcLJnI0SmpMc8ltBQGyBt14=
X-Gm-Gg: ASbGnctkGrMl/qpTq8pV3d1fiZQGMkYPpji4aGl3EIqdjujULKkil8BoD7slXGDo1wc
	9MwJLp2uV+Xb1YoaAf3Dy2UfKZZmL0t7Y2HWcp3nzSECG82YDbfwEeEKKvuRN9BC2g5K4HfsYSS
	YCnlAJpQw2PsFcrJrq6u4tASS84yHiC8tsKV70BTbFO2ZJL6loXDx4v7s1sXUMktovXwFPcjQKK
	Ewjc7wimB77fD90RQ6KhG5kIcQ7Utu6SLRRPB8pZpVuVPaMSxAC11GykoKVStBj5d1j/VNSR8+n
	3x1GIbrZGBTrNtNVicigivqQCPWigf9hd7VfbjfCl6nW3poSdkQPhg==
X-Google-Smtp-Source: AGHT+IH73QS1D5UWCRs0ctMHCS8bma4/x/bL3ofL41GBF2GkxNIuYWlfCICxcIlvecm4Hmc0Weksew==
X-Received: by 2002:a5d:64c3:0:b0:38d:ba8e:7327 with SMTP id ffacd0b85a97d-3996b935107mr1858488f8f.8.1742290032371;
        Tue, 18 Mar 2025 02:27:12 -0700 (PDT)
Received: from [192.168.1.247] ([145.224.67.123])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-395cb318a3dsm17661397f8f.74.2025.03.18.02.27.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Mar 2025 02:27:11 -0700 (PDT)
Message-ID: <b6c2622a-5c54-4951-be23-7f05599fc10d@linaro.org>
Date: Tue, 18 Mar 2025 09:27:10 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/7] coresight: Convert disclaim functions to take a
 struct cs_access
To: Leo Yan <leo.yan@arm.com>
Cc: lcherian@marvell.com, coresight@lists.linaro.org,
 Mike Leach <mike.leach@linaro.org>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com
References: <20250211103945.967495-1-james.clark@linaro.org>
 <20250211103945.967495-3-james.clark@linaro.org>
 <20250313145456.GR9682@e132581.arm.com>
 <c6a86373-64be-4101-a08a-74aa302bf64c@linaro.org>
 <20250317182957.GL2487211@e132581.arm.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <20250317182957.GL2487211@e132581.arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 17/03/2025 6:29 pm, Leo Yan wrote:
> On Mon, Mar 17, 2025 at 11:36:40AM +0000, James Clark wrote:
>>
>>
>> On 13/03/2025 2:54 pm, Leo Yan wrote:
>>> On Tue, Feb 11, 2025 at 10:39:38AM +0000, James Clark wrote:
>>>
>>> [...]
>>>
>>>>    static inline bool coresight_is_claimed_any(struct coresight_device *csdev)
>>>>    {
>>>> -       return coresight_read_claim_tags(csdev) != 0;
>>>> +       return coresight_read_claim_tags(&csdev->access) != 0;
>>>>    }
>>>
>>> Likewise other claim functions, can coresight_is_claimed_any() change its
>>> argument type from struct coresight_device to struct csdev_access?
>>
>> I only wanted to change the ones that I had to. I think we should prioritize
>> passing csdev as much as possible in the coresight framework to make
>> everything consistent. Otherwise it's extra churn for no benefit, and if we
>> need something from csdev here in the future we'll have to change this one
>> back again.
> 
> The function coresight_is_claimed_any() has been deleted in a later
> patch.  So this is fine for me.
> 
> In theory, claim tags are low level operations and don't need a
> CoreSight device context, I prefer we can keep them as simple as
> possible.
> 
> With this series, we can see coresight_claim_device() and
> coresight_disclaim_device() are inconsistent for their parameters:
> one is using "struct coresight_device *" and another is
> "struct csdev_access *".  Maybe we just proceed to use csdev_access
> for all claim tag functions?
> 

That's because coresight_claim_device() has logging which requires the 
device name to make it useful. If anything, coresight_disclaim_device() 
should actually take a csdev and then print a better log message. I 
don't think there's a way to make it consistent when there are different 
requirements for each level of operations. The ones with logging need a 
csdev and the lower level ones used on probe need to work with only csa.

> If later we need to use a CoreSight device context when operating
> claim tags, it means we might have different scenarios and we can
> handle that separately.
> 
> Thanks,
> Leo



