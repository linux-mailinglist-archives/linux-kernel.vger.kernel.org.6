Return-Path: <linux-kernel+bounces-575470-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A6C9CA702D3
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 14:53:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 28B7718894E5
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 13:47:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8D201EEA2A;
	Tue, 25 Mar 2025 13:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JzvZydds"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FB8481732
	for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 13:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742910442; cv=none; b=DbWBrCPHL1HfL6tor+jPdy//nDBiKlsPvsbIM1xs/j4am8SU8q+guG6W8vWnb9dhmnqxV/QQ3bFuZF2ZGF/cEN4hjXDZBuTo5lKlCNbjrQy0HE8mPWl6FzQh6+yGKE9rwsVlkH5j2gDXOiJzq6IZ+ovhlgJwqdeM9vCwsz4yDkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742910442; c=relaxed/simple;
	bh=FmXK4DrckIsHek0Mysjl2eBrJbNXFmYGW96JuG3O44A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aJ+vtFcLwR82kY7mdN5TyWwaWXGTKveXALFe2c1JIPjZsXzyMuPBPId8zgjJz+KC2W3QVX3HOLBop99T/4EAJyb3wRVz6trRLlXFQuZG+LAuRw53PU/K7GVWW0wSvZ/aecXHvZdwx+60p91lvY46Itu3iZEnqdcAvSpC4IpjqHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=JzvZydds; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-43d04dc73b7so59331185e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 06:47:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1742910437; x=1743515237; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cC4k3GVKDrLc3pAzgTSQGdLDrYb8A4mFb3Dpb1J5fKk=;
        b=JzvZyddsjxfYLVcAAR9bx9160sBoN7Fn27F8HThRHMrKV+CRTII9hG4Efe+SexSXXU
         gUyADB52kXBxZGz4tHB9TRpJ5SXhDNOtun6xtYpMCm56dIL9NikkEf9ZyKpvU3vdoTcX
         7+hJYExTRdJm1Jp3veFXHIR8D4Oxu4M8TfmPeHNijPRzPdxHNsFj778a4iIr9NRlP8sd
         +b4KIJgHBwCuxboFstRMneqwiNrtaPgL+/UeIQJ2MQ06MgjzRWbLjSm0TwTNh9zmIFKU
         2idu2rMarp/bimahW3QGRke63BDFXYmZfXGHKjuy58uNumM9nWw93NUkD9gkWaVRzL90
         eNUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742910437; x=1743515237;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cC4k3GVKDrLc3pAzgTSQGdLDrYb8A4mFb3Dpb1J5fKk=;
        b=q5+HQs9bgKaDLRHMr+kSfQEDyFIdBDLSLJLIcKAgQ6Mz0MKg14ch5rcs8k3IRgoxGU
         TjdPy4R2FGd4NnLqHJDg+5s+KJiev+Io/3zQMY3GfCiAv27p0/4/TTTigZTOPyq8XT4U
         R/yLnM4Dv1qZAyWiGSuqqcafwi4lBl3c8KWFsrB9ZNtMpn8oi75VWC+bCb9Frw0MZx1c
         jkqvTTSrEQHClsOkPB49jKUkwhfcDSXU0XUheAA/rHN/Iyv+3C3jBLPwNAgWmi7sM/+b
         pFljW7JkG5Mp6cqL3CJnq6TBxgdvCaPvtRyh5aDXMuzZ64866Cw6yuUt9UtY5WbzSk/D
         cdSw==
X-Forwarded-Encrypted: i=1; AJvYcCW9T2fLK0/7gJzhCB4avVfMvyXuK1gvvnzqrJ8nN4SiwSPegXPW4qOHhkcEY7BzE+LW6Q6anPa5oicZXBA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUU3n/OAKt26ZJfQn5yoCnIyQT34dzHirKRZpsM1BhGsI1qyep
	CD9PHF78ASnsqmCuA+s4Ki9Cgzag0NwtA9U6od4dtHXCeBfLm6u5N4PM7M6arQU=
X-Gm-Gg: ASbGncsij3cSO/4pUP8qeE/PGkDVu7bzatGbJBcT149cDPAJl4BNZGI2r36G7+BXoBA
	Ip6swo8Qy28phJB1uEY+QMTt6oHS/9hp8i1xfmLvS4hfmbCEjK1+9TzhmzTCQNbr+DuRaoJTIdF
	U/3LwuxkPMF84/WyrEQeSiGSEWouNEW0/1uv1p4H9T3bHjnHlWVod9RWkMRpWWkD+XixxtBTrXk
	/lPWJdmNM5H0ytZmpN2pD9MhXsOEhejuFpVOY3MgiAu4mwjredqogFq7bUIGXlAx8bnkEpHd01A
	0obPxT0xi3VwAfP934f/KJCP+aYeMmra4nS0/0AWjV99P9I4IkTjdlkLMApEZx88
X-Google-Smtp-Source: AGHT+IFpqtRld4kYWIl0Bq8BHWcBrNQo6w9zy4bwED+7n/WR5x5JXePT8jlXXf2j5+6Ao1DnzGIn6g==
X-Received: by 2002:a05:600c:32a7:b0:43d:9f2:6274 with SMTP id 5b1f17b1804b1-43d51026f53mr116589055e9.14.1742910437457;
        Tue, 25 Mar 2025 06:47:17 -0700 (PDT)
Received: from [192.168.1.247] ([145.224.90.136])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d4fdbd348sm151629785e9.39.2025.03.25.06.47.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Mar 2025 06:47:17 -0700 (PDT)
Message-ID: <21217526-892d-4d27-9a09-b8853885493a@linaro.org>
Date: Tue, 25 Mar 2025 13:47:15 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/7] coresight: Only check bottom two claim bits
To: Suzuki K Poulose <suzuki.poulose@arm.com>
Cc: coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
 Mike Leach <mike.leach@linaro.org>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>, leo.yan@arm.com
References: <20250320-james-coresight-claim-tags-v3-0-d3145c153820@linaro.org>
 <20250320-james-coresight-claim-tags-v3-2-d3145c153820@linaro.org>
 <40e30ec8-a7ea-46b9-b687-aa7efa8cf0e1@arm.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <40e30ec8-a7ea-46b9-b687-aa7efa8cf0e1@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 21/03/2025 12:10 pm, Suzuki K Poulose wrote:
> On 20/03/2025 14:34, James Clark wrote:
>> The use of the whole register and == could break the claim mechanism if
>> any of the other bits are used in the future. The referenced doc "PSCI -
>> ARM DEN 0022D" also says to only read and clear the bottom two bits.
>>
>> Use FIELD_GET() to extract only the relevant part.
>>
>> Reviewed-by: Leo Yan <leo.yan@arm.com>
>> Signed-off-by: James Clark <james.clark@linaro.org>
>> ---
>>   drivers/hwtracing/coresight/coresight-core.c | 3 ++-
>>   drivers/hwtracing/coresight/coresight-priv.h | 1 +
>>   2 files changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/hwtracing/coresight/coresight-core.c b/drivers/ 
>> hwtracing/coresight/coresight-core.c
>> index 8471aefeac76..26d149a4c579 100644
>> --- a/drivers/hwtracing/coresight/coresight-core.c
>> +++ b/drivers/hwtracing/coresight/coresight-core.c
>> @@ -131,7 +131,8 @@ coresight_find_out_connection(struct 
>> coresight_device *csdev,
>>   static inline u32 coresight_read_claim_tags(struct coresight_device 
>> *csdev)
>>   {
>> -    return csdev_access_relaxed_read32(&csdev->access, 
>> CORESIGHT_CLAIMCLR);
>> +    return FIELD_GET(CORESIGHT_CLAIM_MASK,
>> +             csdev_access_relaxed_read32(&csdev->access, 
>> CORESIGHT_CLAIMCLR));
>>   }
>>   static inline bool coresight_is_claimed_self_hosted(struct 
>> coresight_device *csdev)
>> diff --git a/drivers/hwtracing/coresight/coresight-priv.h b/drivers/ 
>> hwtracing/coresight/coresight-priv.h
>> index 82644aff8d2b..38bb4e8b50ef 100644
>> --- a/drivers/hwtracing/coresight/coresight-priv.h
>> +++ b/drivers/hwtracing/coresight/coresight-priv.h
>> @@ -35,6 +35,7 @@ extern const struct device_type coresight_dev_type[];
>>    * Coresight device CLAIM protocol.
>>    * See PSCI - ARM DEN 0022D, Section: 6.8.1 Debug and Trace save and 
>> restore.
>>    */
>> +#define CORESIGHT_CLAIM_MASK        GENMASK(1, 0)
>>   #define CORESIGHT_CLAIM_SELF_HOSTED    BIT(1)
> 
> I am checking with the Arm CoreSight architects on this. This is
> problematic, if another agent is assigned, say BIT(2) and we wouldn't
> forward compatible.
> 
> Suzuki
> 
> 

For the benefit of the list, I think the conclusion is that in order to 
be forwards compatible with adding new bits, the spec would already have 
to have been released indicating that the extra bits may be used. As it 
specifically only mentions the two bits, any other implementation 
following it would also hit the same problem.

Seems like any further updates would have to be either be breaking or 
done in some other way.

James


