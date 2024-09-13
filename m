Return-Path: <linux-kernel+bounces-328131-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F36B6977F42
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 14:09:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B19E3280E05
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 12:09:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B64F01D9328;
	Fri, 13 Sep 2024 12:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LGZnmWIS"
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59B031D86EC
	for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2024 12:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726229337; cv=none; b=Q2C7VAAB5yFIZ8VduT8vjOV/8nNEKJm3oTuDoLds7JJBEVwW8avzSrWjgz/8UTQ/3InvcnXwNSuCJe35cXtzfeNjAZbU+pM6/tqAcR5wtJFWn0e7fnNdkKe5Jri7VazIza5r//jpKFlI75tPDG8KwjG7kape1ssUxbuAnmXbIPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726229337; c=relaxed/simple;
	bh=DHls9ncs43N2cY+KBhoDz5LT8cdPXxKz8OG5NtYGIzo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Z2bMV56m0wlDCzUy8eI0Raim/xJeYxudOtox59yrJO1fqcDEqwjRxj7F+4aDhJBVHLs2V04mh9hHFpLxy9+v7It5FAzRG3hTDupRokv3ou1/4uu6y1O/dLmy1tdNhZTXjp6dIsHBdDfUxZe+8OLMuoLu0MwZnJWGlXXflqxnu+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=LGZnmWIS; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-53653ee23adso1881412e87.3
        for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2024 05:08:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1726229333; x=1726834133; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bfq+W44YecCwDojJhg+2LqlC6kM/7W6GIy5oGme1yFc=;
        b=LGZnmWIShFurSOPR3clYP2LLIziJY88g+HdgyuGYiN618/LUNjNH2ve57Fdyo6d8Pd
         8eQcs6EcqS5qY/MTOBFZPxPxZ5oCA04lLwrnbRvvgyLrKo9lQ7XrrpTHaerK96SrUjZ/
         FXfEW1wcl8xHFJX3tbx1W57YH0XWiiV5/0Iezkd7Ws6K/XtJrTHBBNjoWffF8sYlWyfz
         TUpwiGC1x+Uowh7LcGPVMCEsgq1MDU9EHgQq6peNSAjlL87tlgbLsfvPWtiI5Q2lr5tx
         l/AoM6exobtBi4joklN8z2Y3oUGgUGch9VmxtJEG+vcIiN51YmLMge+c87CalcMs0lSB
         duWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726229333; x=1726834133;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bfq+W44YecCwDojJhg+2LqlC6kM/7W6GIy5oGme1yFc=;
        b=T5sItSd29MMLG3I4Se7N/0qsQUmRYEbta0HvMTN9/VPyH+OKwIDzZ7Suhhr65A+lMC
         Wy/o4wDo/Dpk5gJiBWq48flQ1PKwHYwoxvipaNhbrK1LqYaZyMf/ClCV17zKOY/S8Q1r
         pIWrFUrmiMGG69F8RBOoQ3L3hsg8bfOQAw+g5pR7zyJ8bEP5qsuPN19qHctApitdIMnm
         NLX+8ln1tVv3BsBW56sygbjwjyRbwSb1X1Bd7+jK37em7JWr0LaHJzQ8TEgWsHicwjp3
         8cRQcbjNDyxIVc86nRViu8o8EQYYuWIj0ua7hqbWJBAxacOEXtLI/1VAO4yCSGGEHEAB
         aU1g==
X-Forwarded-Encrypted: i=1; AJvYcCUnDBfHl9/Xh59fGKY3soMQHTeVjiVEyO5TDWIpCgVcLJxLeG7+sgTaxKetBMBZqbiDO1moYCzdwtv7Z+Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZtHGEn6HtBRhtIHokHbvVILuawbfJqAzGuxYaJZ0/ZUbdTL4V
	WVDkT9SvXGk7wTjGKeaU9QutnEQGdWZ+5e5sh0syISrJx0an6FWV50Kn8j/E36I=
X-Google-Smtp-Source: AGHT+IG9DtgFArBOo022Muf8Kgfs3Z0aaLcxTYPJCojGCGGF/d87glnhK4hXOB6oeIn6TBebTBMaHA==
X-Received: by 2002:a05:6512:3b23:b0:52c:e086:7953 with SMTP id 2adb3069b0e04-53678fb1ddfmr3964807e87.4.1726229332734;
        Fri, 13 Sep 2024 05:08:52 -0700 (PDT)
Received: from [192.168.1.61] ([84.67.228.188])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42d9b179b29sm23367705e9.34.2024.09.13.05.08.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Sep 2024 05:08:52 -0700 (PDT)
Message-ID: <332e0654-df8c-44b1-8e55-398aeba37b08@linaro.org>
Date: Fri, 13 Sep 2024 13:09:06 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/7] perf cs-etm: Use new OpenCSD consistency checks
To: Leo Yan <leo.yan@arm.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>,
 "Liang, Kan" <kan.liang@linux.intel.com>,
 Suzuki K Poulose <suzuki.poulose@arm.com>, Mike Leach
 <mike.leach@linaro.org>, John Garry <john.g.garry@oracle.com>,
 Will Deacon <will@kernel.org>, Leo Yan <leo.yan@linux.dev>,
 Ben Gainey <ben.gainey@arm.com>, Ruidong Tian
 <tianruidong@linux.alibaba.com>, Benjamin Gray <bgray@linux.ibm.com>,
 Mathieu Poirier <mathieu.poirier@linaro.org>, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-perf-users@vger.kernel.org,
 gankulkarni@os.amperecomputing.com, coresight@lists.linaro.org,
 scclevenger@os.amperecomputing.com
References: <20240912151143.1264483-1-james.clark@linaro.org>
 <20240912151143.1264483-3-james.clark@linaro.org>
 <cfad80e4-3ee8-4a55-9dee-41d0d0256c04@arm.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <cfad80e4-3ee8-4a55-9dee-41d0d0256c04@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 13/09/2024 12:54, Leo Yan wrote:
> On 9/12/24 16:11, James Clark wrote:>
>>
>> Previously when the incorrect binary was used for decode, Perf would
>> silently continue to generate incorrect samples. With OpenCSD 1.5.4 we
>> can enable consistency checks that do a best effort to detect a mismatch
>> in the image. When one is detected a warning is printed and sample
>> generation stops until the trace resynchronizes with a good part of the
>> image.
>>
>> Reported-by: Ganapatrao Kulkarni <gankulkarni@os.amperecomputing.com>
>> Closes: 
>> https://lore.kernel.org/all/20240719092619.274730-1-gankulkarni@os.amperecomputing.com/
>> Signed-off-by: James Clark <james.clark@linaro.org>
>> ---
>>   tools/perf/util/cs-etm-decoder/cs-etm-decoder.c | 7 ++++++-
>>   1 file changed, 6 insertions(+), 1 deletion(-)
>>
>> diff --git a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c 
>> b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
>> index b78ef0262135..b85a8837bddc 100644
>> --- a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
>> +++ b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
>> @@ -685,9 +685,14 @@ cs_etm_decoder__create_etm_decoder(struct 
>> cs_etm_decoder_params *d_params,
>>          }
>>
>>          if (d_params->operation == CS_ETM_OPERATION_DECODE) {
>> +               int decode_flags = OCSD_CREATE_FLG_FULL_DECODER;
>> +#ifdef OCSD_OPFLG_N_UNCOND_DIR_BR_CHK
>> +               decode_flags |= OCSD_OPFLG_N_UNCOND_DIR_BR_CHK | 
>> OCSD_OPFLG_CHK_RANGE_CONTINUE |
>> +                               ETM4_OPFLG_PKTDEC_AA64_OPCODE_CHK;
>> +#endif
> 
> Looks good to me.
> 
> Just one question: should the flag ETM4_OPFLG_PKTDEC_AA64_OPCODE_CHK be set
> according to ETM version? E.g. it should be only set for ETMv4 or this is
> fine for ETE as well.
> 
> Thanks,
> Leo
> 

I asked Mike the same question about ETMv3 and he said none of the flags 
overlap and it was ok to always pass them. So I assume the same applies 
to ETE as well.

