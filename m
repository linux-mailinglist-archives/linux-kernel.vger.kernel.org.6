Return-Path: <linux-kernel+bounces-564440-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AFD6A65510
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 16:07:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D0471166885
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 15:06:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F38312459E3;
	Mon, 17 Mar 2025 15:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Q+D00XwX"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CD01241683
	for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 15:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742223948; cv=none; b=Ip8F3DAfE2AfVRCWiOQcGM6qm/b/kehgq4IRz0KRqW0eoypT3sgrDb8ZFqoKfZhjfPr/ZJHFCb8b26lbTQQtmWZsrWtxgffraln+JGdVp5dsD28VcErtbOa4O0nPAqCO0qFAok3BS5vNQvCANiDCOTEscewdePJjDdyFxri3Rm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742223948; c=relaxed/simple;
	bh=1PAZCi/U5ByauY5a4YBrrnRVbeuLzb6ffE/x/zToRhE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UapPeYrvQ0kiIykwK3GTn9JAcbadcaQZDC9sQrKM9h86NrK94eev+QnJNZk8CEpuf/KmeGfR2vfTsbkqQYiHW343KD5PdexmtjAMGddFhOdCJtXPndeSKGYXO2p/eiElnghLDcMUqpcKcETgdI5jRwk5GlRyRIMR/eUpzIXorrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Q+D00XwX; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-43cf034d4abso25158155e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 08:05:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1742223944; x=1742828744; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VtoKs4muQfIKjK2pfrzqLfYPjRO+KKfEwCIPoXdaWIE=;
        b=Q+D00XwXZBrOtZ+WogY+bLm2dIESOYL43kyxeiLtBHWtsLHCYS1A7Q96Z7/flqYFlF
         t8TM/tARyYyPhDfKJgpxpNn/jwJz7I3g27Y/1aeL0tazeT/GSyXd7rRd4v9gV+CXR/Sm
         9l2RSQ8pJRZr6T/DOb1W/9MwNH9ukD4gN2uUfupdSigfqTYvOMh9ptr3bo6iiZlcIEqs
         RU7L49TrSz7sIMbxbaB+MTNWaGn+uCuNRTjMiahMpj1riFwfV2a30iqCo+vuipJP1Ppa
         in6jUCxsfzSJoUdjwklBWmKFto4vmLL5pKJX/TBCTNGfl+Y9yV9ezLUtGoEExaHGEnEK
         WBPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742223944; x=1742828744;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VtoKs4muQfIKjK2pfrzqLfYPjRO+KKfEwCIPoXdaWIE=;
        b=SGoFFGVcEz9GqwCpd6wcPe4RT4KcuF3wb5+fD14BxSoUSjk+YiljePbJHzKW10ng+5
         S5VY0vIC5z/hIhsrMwlFxXdbWr1Z7lZyXIkhSBGvfnnFQvuTw8npgiZLrNZMsyP00yJw
         JWIbXwqtlGvSLG+3l31s5oGmWzXfzO9VAGnEx/uVgUjFnDLe9lT1ztFCtGVOkrRoMfp9
         bF+LPnDamx5F26ReEhvIrKXQFZOb5j1s0QzAtqU1adtGoWyquIM+Ggj78O6k8F0H2Yun
         kfVjkObwj61dsIHJaRBIR1zBQNGvJWmyhXTdAvTNLfMyUIo2PYN2Z4tFZKMA11+zCgmh
         W8Ng==
X-Forwarded-Encrypted: i=1; AJvYcCUbK2zNr8InQl8qMUorILO38LvlKY0QkqR55s0L0JeVjIUldknGOsTgs2Rb7hQi3+NDL9pl220xbKmZBw0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyaBsr0kBTC1uW42vpRk/Nl2SE/PUTHI4bGbTMkXVh1eqjoLLT6
	lfKtgA20qrNsjIWOvQwAScgrFf8gf2t2B9ZH4c3dhEaMXxo2aLtNwaZWVjAo+wo=
X-Gm-Gg: ASbGncs2/l3a2QTSgQivgkY79ygrNpeD5k81THnezDby5peHeDVxThrWEB3+V7sv7k6
	oeODRILJaRUbp0tfn2IKPRiI+zPK7LbTJb1JAs5r1y8l1NgmfSIPFXDVuYk/rsfaVUEg7iRpHOl
	lpudPuV2x93QV7UCuKjq40zTKxAAJoQFdeps4hur7pGdKmH1FIFbrkzgbOSknh9f019nkxwDRNv
	YNwh7x0EKgZ0+T7mux5WtrBHLRN058MZ1L+AntjjzKyZ3cdj+WoDtnCFoSv0oMKIQAYfzMqiNIw
	tphciWe5aWrjBchyiRcb2GQ3EHqL/CqpRWaJ/WtC30YE3/VSA9JDYw==
X-Google-Smtp-Source: AGHT+IFr4VZWBjzWUJMxKCB2olOOjvXpHwk1/Fc+c0jvMCr6/FceLLDOg2yCTQ+piJ+So3TuCF5r+w==
X-Received: by 2002:a05:600c:1547:b0:43d:300f:fa1d with SMTP id 5b1f17b1804b1-43d38a0da56mr1480995e9.31.1742223943934;
        Mon, 17 Mar 2025 08:05:43 -0700 (PDT)
Received: from [192.168.1.247] ([145.224.67.123])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d1ffb626esm107164485e9.8.2025.03.17.08.05.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Mar 2025 08:05:43 -0700 (PDT)
Message-ID: <6be400e2-a464-4714-acf4-328dade883a9@linaro.org>
Date: Mon, 17 Mar 2025 15:05:41 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/7] coresight: Clear self hosted claim tag on probe
To: Leo Yan <leo.yan@arm.com>
Cc: lcherian@marvell.com, coresight@lists.linaro.org,
 Mike Leach <mike.leach@linaro.org>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com
References: <20250211103945.967495-1-james.clark@linaro.org>
 <20250211103945.967495-6-james.clark@linaro.org>
 <20250313160409.GS9682@e132581.arm.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <20250313160409.GS9682@e132581.arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 13/03/2025 4:04 pm, Leo Yan wrote:
> On Tue, Feb 11, 2025 at 10:39:41AM +0000, James Clark wrote:
>>
>> This can be left behind from a crashed kernel after a kexec so clear it
>> when probing each device. Similarly to
>> coresight_disclaim_device_unlocked(), only clear it if it's already set
>> to avoid races with an external debugger.
>>
>> We need a csdev_access struct in etm_init_arch_data() so just replace
>> the iomem pointer with a full csdev_access struct. This means all usages
>> need to be updated to go through csa->base.
>>
>> Signed-off-by: James Clark <james.clark@linaro.org>
>> ---
>>   drivers/hwtracing/coresight/coresight-catu.c  |  1 +
>>   drivers/hwtracing/coresight/coresight-core.c  | 48 +++++++++++++++----
>>   .../hwtracing/coresight/coresight-cti-core.c  |  2 +
>>   drivers/hwtracing/coresight/coresight-etb10.c |  2 +
>>   drivers/hwtracing/coresight/coresight-etm.h   |  6 +--
>>   .../coresight/coresight-etm3x-core.c          | 28 +++++------
>>   .../coresight/coresight-etm3x-sysfs.c         |  8 ++--
>>   .../coresight/coresight-etm4x-core.c          |  2 +
>>   .../hwtracing/coresight/coresight-funnel.c    |  2 +
>>   .../coresight/coresight-replicator.c          |  1 +
>>   .../hwtracing/coresight/coresight-tmc-core.c  |  1 +
>>   include/linux/coresight.h                     |  3 ++
>>   12 files changed, 73 insertions(+), 31 deletions(-)
>>
>> diff --git a/drivers/hwtracing/coresight/coresight-catu.c b/drivers/hwtracing/coresight/coresight-catu.c
>> index d9259c0b6e64..575c2d247a90 100644
>> --- a/drivers/hwtracing/coresight/coresight-catu.c
>> +++ b/drivers/hwtracing/coresight/coresight-catu.c
>> @@ -558,6 +558,7 @@ static int __catu_probe(struct device *dev, struct resource *res)
>>          catu_desc.subtype.helper_subtype = CORESIGHT_DEV_SUBTYPE_HELPER_CATU;
>>          catu_desc.ops = &catu_ops;
>>
>> +       coresight_reset_claim(&catu_desc.access);
>>          drvdata->csdev = coresight_register(&catu_desc);
>>          if (IS_ERR(drvdata->csdev))
>>                  ret = PTR_ERR(drvdata->csdev);
>> diff --git a/drivers/hwtracing/coresight/coresight-core.c b/drivers/hwtracing/coresight/coresight-core.c
>> index 7fe5d5d432c4..97f33ffad05e 100644
>> --- a/drivers/hwtracing/coresight/coresight-core.c
>> +++ b/drivers/hwtracing/coresight/coresight-core.c
>> @@ -212,20 +212,48 @@ int coresight_claim_device(struct coresight_device *csdev)
>>   EXPORT_SYMBOL_GPL(coresight_claim_device);
>>
>>   /*
>> - * coresight_disclaim_device_unlocked : Clear the claim tag for the device.
>> + * Clear the claim tag for the device.
>> + * Returns an error if the device wasn't already claimed.
>> + */
>> +int coresight_reset_claim(struct csdev_access *csa)
>> +{
>> +       int ret;
>> +
>> +       CS_UNLOCK(csa->base);
>> +       ret = coresight_reset_claim_unlocked(csa);
>> +       CS_LOCK(csa->base);
>> +       return ret;
>> +}
>> +EXPORT_SYMBOL_GPL(coresight_reset_claim);
> 
> Maybe my question is overlapping with Mike's comment.
> 
> Callers never check the return values from coresight_reset_claim(). I am

I can remove the return value if it's confusing. The thought process was 
probably that it could be useful somewhere in the future, and 
coresight_reset_claim_unlocked() returns something anyway so might as 
well pass it up.

> wandering if coresight_reset_claim() can directly call
> coresight_clear_self_claim_tag() for _trying_ to clear self-host tag in
> probe phase. Any self claim tag issues will be deferred to detect until
> enable the component.
> 

Maybe, the spec does a read before setting which I assumed should be 
done for clearing as well. As in to not touch anything if it's in use 
externally. It doesn't specifically describe any clearing sequence, but 
if we assume it's ok to blindly clear self hosted flag even when it's in 
use then yes we can directly call coresight_clear_self_claim_tag().

This doesn't change anything about deferring errors though, 
coresight_reset_claim() doesn't warn early either.

> For consistent, we might rename coresight_reset_claim() to
> coresight_reset_self_claim_tag(), which acquires CS lock and clear
> self claim tag.
> 
>> +/*
>> + * Clear the claim tag for the device. Called with CS_UNLOCKed for the component.
>> + * Returns an error if the device wasn't already claimed.
>> + */
>> +int coresight_reset_claim_unlocked(struct csdev_access *csa)
>> +{
>> +       if (coresight_read_claim_tags(csa) == CORESIGHT_CLAIM_SELF_HOSTED) {
>> +               coresight_clear_self_claim_tag(csa);
>> +               return 0;
>> +       }
>> +
>> +       return -EINVAL;
>> +}
>> +EXPORT_SYMBOL_GPL(coresight_reset_claim_unlocked);
>> +
>> +/*
>> + * coresight_disclaim_device_unlocked : Clear the claim tag for the device
>> + * and warn if the device wasn't already claimed.
>>    * Called with CS_UNLOCKed for the component.
>>    */
>>   void coresight_disclaim_device_unlocked(struct csdev_access *csa)
>>   {
>> -       if (coresight_read_claim_tags(csa) == CORESIGHT_CLAIM_SELF_HOSTED)
>> -               coresight_clear_self_claim_tag(csa);
>> -       else
>> -               /*
>> -                * The external agent may have not honoured our claim
>> -                * and has manipulated it. Or something else has seriously
>> -                * gone wrong in our driver.
>> -                */
>> -               WARN_ON_ONCE(1);
>> +       /*
>> +        * Warn if the external agent hasn't honoured our claim
>> +        * and has manipulated it. Or something else has seriously
>> +        * gone wrong in our driver.
>> +        */
>> +       WARN_ON_ONCE(coresight_reset_claim_unlocked(csa));
>>   }
>>   EXPORT_SYMBOL_GPL(coresight_disclaim_device_unlocked);
>>
>> diff --git a/drivers/hwtracing/coresight/coresight-cti-core.c b/drivers/hwtracing/coresight/coresight-cti-core.c
>> index 073f67a41af9..389a72362f0c 100644
>> --- a/drivers/hwtracing/coresight/coresight-cti-core.c
>> +++ b/drivers/hwtracing/coresight/coresight-cti-core.c
>> @@ -931,6 +931,8 @@ static int cti_probe(struct amba_device *adev, const struct amba_id *id)
>>          cti_desc.ops = &cti_ops;
>>          cti_desc.groups = drvdata->ctidev.con_groups;
>>          cti_desc.dev = dev;
>> +
>> +       coresight_reset_claim(&cti_desc.access);
>>          drvdata->csdev = coresight_register(&cti_desc);
>>          if (IS_ERR(drvdata->csdev)) {
>>                  ret = PTR_ERR(drvdata->csdev);
>> diff --git a/drivers/hwtracing/coresight/coresight-etb10.c b/drivers/hwtracing/coresight/coresight-etb10.c
>> index d8bc3e776c88..b598b2c0c9bb 100644
>> --- a/drivers/hwtracing/coresight/coresight-etb10.c
>> +++ b/drivers/hwtracing/coresight/coresight-etb10.c
>> @@ -772,6 +772,8 @@ static int etb_probe(struct amba_device *adev, const struct amba_id *id)
>>          desc.pdata = pdata;
>>          desc.dev = dev;
>>          desc.groups = coresight_etb_groups;
>> +
>> +       coresight_reset_claim(&desc.access);
>>          drvdata->csdev = coresight_register(&desc);
>>          if (IS_ERR(drvdata->csdev))
>>                  return PTR_ERR(drvdata->csdev);
>> diff --git a/drivers/hwtracing/coresight/coresight-etm.h b/drivers/hwtracing/coresight/coresight-etm.h
>> index e02c3ea972c9..a89736309c27 100644
>> --- a/drivers/hwtracing/coresight/coresight-etm.h
>> +++ b/drivers/hwtracing/coresight/coresight-etm.h
>> @@ -229,7 +229,7 @@ struct etm_config {
>>    * @config:    structure holding configuration parameters.
>>    */
>>   struct etm_drvdata {
>> -       void __iomem                    *base;
>> +       struct csdev_access             csa;
> 
> I would like to extract the change for using `csdev_access` in the
> ETMv3 driver into a new patch, which is irrelevant to reset self claim
> tags and would significantly reduce the complexity in this patch.
> 

Will do, good point.

> Thanks,
> Leo


