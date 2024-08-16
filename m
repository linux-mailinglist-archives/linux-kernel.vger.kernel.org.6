Return-Path: <linux-kernel+bounces-289727-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 90027954B13
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 15:27:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B3E441C23AAF
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 13:27:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D15281BB69D;
	Fri, 16 Aug 2024 13:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hxZW5vKn"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 338FE1A01CF
	for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 13:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723814845; cv=none; b=uBrnXr+L4NrJg0IANIfHfHFwsyX+qTFU3Wim7iVzwk9lsULLK24izFV1o41IZ2aJFK/uBbWAbbGcxTUTNSsNr5Pj+3am4krnZkPHwUrDb2MSES0sT2O0TuBbo+Qlczc7nwvoXsnqchB2lTm8vxFKM+KOIxi9sPt//kx2iTBqeM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723814845; c=relaxed/simple;
	bh=41rlXTFpA1svYSraeTj87VnYGe/UKMBKBWxBA5v5yqA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Fp3oCvHfudACROVvT+E7bhxQ93RYfdLlsxRI8aNQ614euqn6Si8TP5/RFssccaYKCAnTdTwCm9E033/BFRhWLh7ON8PXRVuhUZeK1lFu/THu+8sLzCzMr8qzral3TqQb/q1BtdNKFW7IkR+Z7HqKHS0U8MpGokeBDpN8KJyEmxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=hxZW5vKn; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-428141be2ddso13696045e9.2
        for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 06:27:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1723814841; x=1724419641; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7WCQM6v4NTwhI05qdS59VV07dC5nARwtW2tumhNxSAs=;
        b=hxZW5vKnJZWgavbXFKns4kvEqCWQTwqW0IGGY/rqvi9yvW4cyaOQl9EIW6wBnWpE/J
         hnuCjjB+49TdEqboT/1NKhjSfgtw172efdNAs9sGkZP0bXjheJDr6GHRlpiaMKVw2Ofn
         5e3NMmbtBc8F3Vwev/MjabhIPaNEw8CMNrx/tQvwgWNJ57joJ9edogNGYlIRvax1XMLo
         B5YTu/M1tBSINI9bJBmKY4Ijgg/MdyZ7UPQ22NlwiwvCyMcTfOPOJVKM2yFLlVlyKxbi
         64kvSWyjJ5SHWTQVKTnAQfCrTefguAhq4PWf/bRgqXjLXtDh9TfzGHIA589Su/TLoktH
         q/+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723814841; x=1724419641;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7WCQM6v4NTwhI05qdS59VV07dC5nARwtW2tumhNxSAs=;
        b=pfL5RzJZbKjm4/9w/DsvnKOc4dn9exavhGvfpJ3U4/nosXsxeAUf9ZcGMIVwCAXwtK
         Y+DxOeR0Ck3DqquO0RjYP8dYL8nlazzpyRKJy41DxcsaMLhQg0oLcYR119WIAfO9PCeV
         BuTSONomHs+J1BReDtqmHw93BZq9Y0rDVtaPkX0D9ZMRXa5QRBhB4j7HF6yjyZGulCUV
         ojUHXxXBxrPt8JKM+8VzmAIM4rtRALD9X8e9JSLDCsbQGdVeIBH9xfY172e67ekNrVAa
         D6Tk0eJdJJFTeS0JRB2e/Gev8i/sLB8BY1ZwV3PFo13ijmwylUPW7E4f/AwwYV3IYTWL
         KntQ==
X-Forwarded-Encrypted: i=1; AJvYcCVoRGdpnMRO8KNX0I2w7BIiQDO5n3ybqNUEowKwWJu3j9MhMGP9ECAwfe8Ir293XwSfH2qhsMDfWfyftcdTdyZgmP8BakHt6bZZtIFL
X-Gm-Message-State: AOJu0Yz2s/s329QNRKgQsSl9s1h84f7j89Xfur7NnHVnOjsu1wHWPHST
	i497hg/kbdk+HxfM+CLWty/qvSK6LgYsU1rL0xWFyOOgNPSoPiKUrLbhgQk4EQs=
X-Google-Smtp-Source: AGHT+IHbFkHu9392EA0i6PYQpeLlqoUxj+nwG7GXFX79pIwS5rABIJuq9XtLqO3ZGS6JxW3l8tgH3A==
X-Received: by 2002:a05:600c:4ecb:b0:426:6379:3b4f with SMTP id 5b1f17b1804b1-429ed7dba98mr20081015e9.31.1723814840869;
        Fri, 16 Aug 2024 06:27:20 -0700 (PDT)
Received: from [192.168.1.3] ([89.47.253.130])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-429ed6585d1sm22808075e9.22.2024.08.16.06.27.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Aug 2024 06:27:20 -0700 (PDT)
Message-ID: <177108bc-2bdd-4914-97cc-ee09dfef75c3@linaro.org>
Date: Fri, 16 Aug 2024 14:27:19 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drivers/perf: arm_spe: Use perf_allow_kernel() for
 permissions
To: Will Deacon <will@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, peterz@infradead.org,
 Al Grant <al.grant@arm.com>, Mark Rutland <mark.rutland@arm.com>,
 Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>,
 "Liang, Kan" <kan.liang@linux.intel.com>, linux-kernel@vger.kernel.org,
 linux-perf-users@vger.kernel.org
References: <20240807155153.2714025-1-james.clark@linaro.org>
 <20240816124459.GA24323@willie-the-truck>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <20240816124459.GA24323@willie-the-truck>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 16/08/2024 1:45 pm, Will Deacon wrote:
> On Wed, Aug 07, 2024 at 04:51:53PM +0100, James Clark wrote:
>> For other PMUs, PERF_SAMPLE_PHYS_ADDR requires perf_allow_kernel()
>> rather than just perfmon_capable(). Because PMSCR_EL1_PA is another form
>> of physical address, make it consistent and use perf_allow_kernel() for
>> SPE as well. PMSCR_EL1_PCT and PMSCR_EL1_CX also get the same change.
>>
>> This improves consistency and indirectly fixes the following error
>> message which is misleading because perf_event_paranoid is not taken
>> into account by perfmon_capable():
>>
>>    $ perf record -e arm_spe/pa_enable/
>>
>>    Error:
>>    Access to performance monitoring and observability operations is
>>    limited. Consider adjusting /proc/sys/kernel/perf_event_paranoid
>>    setting ...
>>
>> Suggested-by: Al Grant <al.grant@arm.com>
>> Signed-off-by: James Clark <james.clark@linaro.org>
>> ---
>> Changes since v1:
>>
>>    * Export perf_allow_kernel() instead of sysctl_perf_event_paranoid
>>
>>   drivers/perf/arm_spe_pmu.c | 9 ++++-----
>>   include/linux/perf_event.h | 8 +-------
>>   kernel/events/core.c       | 9 +++++++++
>>   3 files changed, 14 insertions(+), 12 deletions(-)
>>
>> diff --git a/drivers/perf/arm_spe_pmu.c b/drivers/perf/arm_spe_pmu.c
>> index 9100d82bfabc..3569050f9cf3 100644
>> --- a/drivers/perf/arm_spe_pmu.c
>> +++ b/drivers/perf/arm_spe_pmu.c
>> @@ -41,7 +41,7 @@
>>   
>>   /*
>>    * Cache if the event is allowed to trace Context information.
>> - * This allows us to perform the check, i.e, perfmon_capable(),
>> + * This allows us to perform the check, i.e, perf_allow_kernel(),
>>    * in the context of the event owner, once, during the event_init().
>>    */
>>   #define SPE_PMU_HW_FLAGS_CX			0x00001
>> @@ -50,7 +50,7 @@ static_assert((PERF_EVENT_FLAG_ARCH & SPE_PMU_HW_FLAGS_CX) == SPE_PMU_HW_FLAGS_C
>>   
>>   static void set_spe_event_has_cx(struct perf_event *event)
>>   {
>> -	if (IS_ENABLED(CONFIG_PID_IN_CONTEXTIDR) && perfmon_capable())
>> +	if (IS_ENABLED(CONFIG_PID_IN_CONTEXTIDR) && !perf_allow_kernel(&event->attr))
>>   		event->hw.flags |= SPE_PMU_HW_FLAGS_CX;
> 
> The rationale for this change in the commit message is because other
> drivers gate PERF_SAMPLE_PHYS_ADDR on perf_allow_kernel(). However,
> putting the PID in contextidr doesn't seem to have anything to do with
> that...
> 

That is true, I suppose I was thinking of two reasons to do it this way 
that I didn't really elaborate on:

#1 because context IDs and physical timestamps didn't seem to be any 
more sensitive than physical addresses, so it wouldn't make sense for 
them to have a stricter permissions model than addresses.

#2 (although this is indirect and not really related to the driver) but 
Perf will still print the misleading warning when physical timestamps 
are requested. So some other fix would eventually have to be made for that.

I'm not sure if you are objecting to the permissions change for the 
other two things, or it's just a lack of reasoning in the commit message?

IMO if we think the other two can't be changed, I would actually rather 
drop the change than only target PERF_SAMPLE_PHYS_ADDR. Because that 
seems like it unnecessarily complicates the permissions and might be 
quite surprising to a user. And then maybe some attempt of a fix could 
be made in Perf instead. Although that could be difficult because of the 
lack of a specific error code from the driver.

>>   }
>>   
>> @@ -745,9 +745,8 @@ static int arm_spe_pmu_event_init(struct perf_event *event)
>>   
>>   	set_spe_event_has_cx(event);
>>   	reg = arm_spe_event_to_pmscr(event);
>> -	if (!perfmon_capable() &&
>> -	    (reg & (PMSCR_EL1_PA | PMSCR_EL1_PCT)))
>> -		return -EACCES;
>> +	if (reg & (PMSCR_EL1_PA | PMSCR_EL1_PCT))
> 
> Similarly here. What does the physical counter have to do with physical
> address sampling other than sharing the word "physical"?
> 
> Will

