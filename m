Return-Path: <linux-kernel+bounces-568008-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E17DA68CDF
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 13:30:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7B1C17A3B58
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 12:29:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0723255E4D;
	Wed, 19 Mar 2025 12:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bf9C6eBz"
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4175B1E492
	for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 12:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742387423; cv=none; b=csbFPs+qVgQVW4bKa8XplXO2vZFbmorp+mpAUYDj+LEuABokeyTxyV+wRlTbl+9wGq1OXS3qDVYapYsJ1d03ni+WUXPI+NxVraYPAmB6FjTAs0ybaIzQU5anew+Y0os72YBkCO142BfFKVUn702Z5SbnTAdoMY+5YL1RLx+X0d8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742387423; c=relaxed/simple;
	bh=rs3rFS2C2IcZ8+z4w3hBviDDluBdzYKVxKPYwl7P1b4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gcrHeWtmXfdmkhuTkyIJU9nJjojkGZqVwIMqzclVB1ikcRpUv7sBEu/dWgBfifMCzkVrzKNR73aqmvQn3f5yjRi3S0GqRsRxEJh9QI8Uo0TjYB9ZSNi33uja3MAdt4xKsC81i9gVOWSt8pVGUuRun1xK9P3eL3Q9CazxF7XRSzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=bf9C6eBz; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-391342fc1f6so5500555f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 05:30:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1742387419; x=1742992219; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FR7LOBfgMjA2RsqEaQnFiGMYbwNkGFoaG0P7aHkHt7Y=;
        b=bf9C6eBzxwIbr5L7BCnpY0xLbnbAz8EMZV1C2an0/LTbtPJdxnSakKfgA9QN1CXj6n
         OH1PZVq4Oo6qtgh1/H2xt2+zSLOrEuSTo/gvJdUIARSsDZZs+JunTHG/arulZja9AM5F
         0i2x2tddDSIImY26P14TkwzqqLOViHP/9QX/9FFPODKoHJeXD+M3uIBdgy9awL8QFXSJ
         Y3ymotANkke2tHjzgig+eVL1Z4c1AmC3TEdLmAXCzd7Eci33Lnj4HI7b93/PYWqW6PuC
         Os05Kn0NwBZoNyZTKqug+artpISqFGN2Qv0goPgM8L+NYsHAfivfCz27Cgn8PUkBHf2d
         He7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742387419; x=1742992219;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FR7LOBfgMjA2RsqEaQnFiGMYbwNkGFoaG0P7aHkHt7Y=;
        b=caI/QM1RU2chW9Q7mNH0XzIQoZopCdq3dT1/vERyPILCHSycrKqzjLJaV6kmqOrDXb
         ZQgckkoMLvKE1fOTgomQmDBwPGEz002zleg8+2I4J4ig/wzJGYP57VSoS1GEdx5LiEHa
         ipcif4OlhKdiOn6OiP9WaP+De4tA8ofxPeul6wXUF1EnL4W2XEkcjk3NCTTh2uLn5Ylv
         lYBXMqt1LpucLJsQQllWNE1wbHYgw+mh1rbDti+CwsWwsAcRaxSCCqG2iK8ms2LZV99Y
         hXrS2vO2Kr/HXgNFR9WtL8qG1p91bw9aEIAV8N1MdemwB1EPF3RxBpmPtw8Kfc9DTcLl
         ZkoQ==
X-Forwarded-Encrypted: i=1; AJvYcCWagsHsNQbqns7mdIDBMaHkSvDSDUlokgB7CzHo6qjt3kP4awQU4/cl8enLsud/+5nXN1u1AaQ0xweI6pw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPIrdw9443W29dCaQ/rrsg6lfrDfmh8DeaPaVFZoteJTwIcM9U
	vixPTD2R3uu3Qgk+z5iu2ArKCArpW6p2Rm4eERfYwYCTFSNxT8btXVPx5jkTrDI=
X-Gm-Gg: ASbGncu6SfPqabkT7g872Tws16yRnOwdnOhlk9hn5MMTH9+2WtKbfpQgbUDLTlmYwFL
	h46j9xZGL1oWfEGj/teAhl6qNCF42QOly6ShGp9uQ52S9glelTXrrV/9GSMxPeTV9lG1Rv7IUW8
	f2rf+wdIrKQPIm00fiYi+GfIeCNERj4IyDjBv/WtK99DRgKkZFa3UyiAwafmzV5N2S5kpAnQauD
	bpPbc6In5MHz6kPrnLvqNEXcKLZZWZNCEQIuN2CZ2cpa8BKQvl0diPmUVup2P2MK3l20uF0quiV
	C2fQOLrbUIT5xVzzyvrjS0nGMa5cuHjEoW49Dnz+EiOCpN0cldWlMA==
X-Google-Smtp-Source: AGHT+IElD83yXdXLURLXF/axbPrNrrCeSAlJQC+eF2bcCRNhZkvyLSVVQgbNardWtBxjxy/EPmxOCw==
X-Received: by 2002:a05:6000:1847:b0:391:456b:6ac8 with SMTP id ffacd0b85a97d-399739ca1camr1959945f8f.24.1742387419344;
        Wed, 19 Mar 2025 05:30:19 -0700 (PDT)
Received: from [192.168.1.247] ([145.224.67.123])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-397f2837e61sm15560737f8f.97.2025.03.19.05.30.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Mar 2025 05:30:19 -0700 (PDT)
Message-ID: <2700171e-dbaa-4218-9b46-5d181f5afee7@linaro.org>
Date: Wed, 19 Mar 2025 12:30:17 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/8] coresight: Convert tag clear function to take a
 struct cs_access
To: Suzuki K Poulose <suzuki.poulose@arm.com>
Cc: coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
 Mike Leach <mike.leach@linaro.org>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>, leo.yan@arm.com
References: <20250318-james-coresight-claim-tags-v2-0-e9c8a9cde84e@linaro.org>
 <20250318-james-coresight-claim-tags-v2-2-e9c8a9cde84e@linaro.org>
 <cc68d43f-4719-4f57-a38c-fb5afe8d29cc@arm.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <cc68d43f-4719-4f57-a38c-fb5afe8d29cc@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 19/03/2025 12:00 pm, Suzuki K Poulose wrote:
> On 18/03/2025 16:21, James Clark wrote:
>> The self hosted claim tag will be reset on device probe in a later
>> commit. We'll want to do this before coresight_register() is called so
>> won't have a coresight_device and have to use cs_access instead.
>>
>> Also make them public and create locked and unlocked versions for
>> later use.
>>
>> Signed-off-by: James Clark <james.clark@linaro.org>
> 
> minor nit:
> 
> The restructuring looks a bit confusing. Could we start with :
> 
> coresight_{set,clear}_self_claim_tag_unlocked in Patch 1. Rather
> than rename what we renamed in patch 1 again here.
> 
> 

I considered collapsing these two actually, would you be ok with that?

>> ---
>>   drivers/hwtracing/coresight/coresight-core.c | 17 +++++++++++++----
>>   include/linux/coresight.h                    |  3 ++-
>>   2 files changed, 15 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/hwtracing/coresight/coresight-core.c b/drivers/ 
>> hwtracing/coresight/coresight-core.c
>> index 3f1c996d668a..9ff601e2415a 100644
>> --- a/drivers/hwtracing/coresight/coresight-core.c
>> +++ b/drivers/hwtracing/coresight/coresight-core.c
>> @@ -151,12 +151,21 @@ static inline void 
>> coresight_set_self_claim_tag(struct coresight_device *csdev)
>>       isb();
>>   }
>> -static inline void coresight_clear_self_claim_tag(struct 
>> coresight_device *csdev)
>> +void coresight_clear_self_claim_tag(struct csdev_access *csa)
>>   {
>> -    csdev_access_relaxed_write32(&csdev->access, 
>> CORESIGHT_CLAIM_SELF_HOSTED,
>> +    CS_UNLOCK(csa->base);
> 
> This looks to be hard coding MMIO based access ? Should we abstract it 
> based on the csdev_access_** ?
> 
> 
> Suzuki
> 
> 

I did something similar earlier but it ended up being huge to do it 
properly and I wasn't sure of the benefits so I deleted it. By 
'properly' I mean change all of the CS_UNLOCK() calls to be abstracted 
and delete etm4_cs_unlock() because CS_UNLOCK() would handle both. It 
ends adding in an if and indirection for every lock/unlock for devices 
that are never sysreg access anyway.

Because there's already this:

static void etm4_cs_unlock(struct etmv4_drvdata *drvdata,
			   struct csdev_access *csa)
{
	if (csa->io_mem)
		CS_UNLOCK(csa->base);

But yeah I can add the if into coresight_clear_self_claim_tag(), 
although it technically doesn't do anything now because it's never 
called by any devices that aren't MMIO. And then it makes 
etm4_cs_unlock() stand out a bit because its not a core function when it 
could be. But that's probably fine.





