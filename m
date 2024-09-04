Return-Path: <linux-kernel+bounces-315146-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 22ABF96BE86
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 15:29:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 46DA91C231E2
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 13:29:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C5361DA115;
	Wed,  4 Sep 2024 13:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ov/XTk/n"
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4E9F1DA101
	for <linux-kernel@vger.kernel.org>; Wed,  4 Sep 2024 13:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725456563; cv=none; b=eLuUpL2EqGDY/eErezibaJ7nrG1YUI6AadBtrRFcT1nUDiUXIaQkfJaMZhonveIcWLJIfVWNPBk0p5ezDS+NOHIXOJS3XWa8oBLc5dK71bm1oGtaXNfKvBB7I++SaUBRzgUWTqd/vi84F/iF/90ImulVqKaV7PCu9D0lgfbUJlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725456563; c=relaxed/simple;
	bh=hTwz7T+kA1ZdMphX8cn3RJOdysmUSUewq+ktL3MQIpU=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=Z7qSC/2d/NPO4IUIl22DrSlTBAINZnUxWDQ+hfVhT/jYUM+X4hJPgIGfxjhwe0OGX3R+h8OWAGqK0Mc4MZBenhY/yWrgZ8hwScyIK53Rs4l0q2u9kcPmnVUXxxHLbM6Tg5CDKK4/pRGfHaMg6OWgJitshCBX7Ey1s00nLQzApF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ov/XTk/n; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-371941bbfb0so4226695f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 04 Sep 2024 06:29:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725456560; x=1726061360; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Xj+Wgvo3JkMcqvVd3ksJTTHYIece7AGFEnbRLynw6+s=;
        b=ov/XTk/nsb33mRfYMR95y0apTMBbtVmHnxwuCiQpZK0mNiO0F7XcX3WOFYkw1dTknw
         JfwC4JObLrVzhdo2UBZDlOX8LGBPaJEBtEEHWhddY2LzfHCx4+XNFpnXDSYbKU8o2+ad
         jokdaAEz5FcKaUehluRGv1phEixlrX59QCr3wdWD0JVCSwlhxJL361soehnbX5rN9gjV
         1fBQhSwGU8yFod02RmzERNH0fW4NTk+evwKeOOG2weAiyivr2OCMACTx22TFxxlFuyMS
         D8sWBgpoYC2RBQ8YoD9KivNc302p/xvU0y1iyc4wbq8SHtrRsL1cvyRJ/hJjkcHWEK9l
         LNxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725456560; x=1726061360;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Xj+Wgvo3JkMcqvVd3ksJTTHYIece7AGFEnbRLynw6+s=;
        b=JN+RW2xM4qC9aqngVxlCMli8m3aDHD32y13bf2HtkVg7/Ip+CCleGWf5gBVPN8JkOT
         QCY4aiMqenjEmMr8KSn1aLsAbP0RYcSnKdxF3OBwrHZiRyah+O7ggN4FYxmNeyVALtEH
         VSQuHazVc1wHh1zQH2TN1UpUkENYnte6iv610v8jKYrv94teXIadXcy50I/ws0Q2D4et
         +NwYm9B1AR4e9dmfwRFq0FGseYZGOHm4cDr0SQblstiXaIRyFlgEvfZTTwK7NbxyMlAB
         jOWsR40E0tpQUZFXcynBOm3kY9rbI38iN3LbUV90EouNTcok+igUehHU28wTvRl4d2Hh
         ETcw==
X-Forwarded-Encrypted: i=1; AJvYcCX+FPk9SD/5w2rQUgey2GRCfQ4/7qbyHsrrSEeRA74WA0SKJyjttYA1NG0hcv+MtwxHraaMo4tRyoA5Gbg=@vger.kernel.org
X-Gm-Message-State: AOJu0YziS4HCGG6GIEToc/bLCqj8lAf4Keqygl0CvjTItJi80mOLxGE0
	LZPNYZh7e5ozUVHUT6RM2Tfo9wZJau8jIySSiHxjaPPSd21gkM/SK2ZEujjCZw4=
X-Google-Smtp-Source: AGHT+IH4ZFL2+hN2XCv+e/8g7SeM4o2fEGG1dQ4/Uh11y3ctyio8U+lxhaPAht3QfOXq4fDudCTE7Q==
X-Received: by 2002:a5d:4576:0:b0:374:c654:204a with SMTP id ffacd0b85a97d-374c6542086mr7291508f8f.61.1725456559282;
        Wed, 04 Sep 2024 06:29:19 -0700 (PDT)
Received: from [192.168.1.3] ([89.47.253.130])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-374c1b0a62esm11591070f8f.47.2024.09.04.06.29.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Sep 2024 06:29:18 -0700 (PDT)
Message-ID: <9cdc97eb-a194-454a-916c-2acf64f0c726@linaro.org>
Date: Wed, 4 Sep 2024 14:29:17 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7/8] perf tools: Add fallback for exclude_guest
From: James Clark <james.clark@linaro.org>
To: Namhyung Kim <namhyung@kernel.org>,
 Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>,
 LKML <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org,
 Ravi Bangoria <ravi.bangoria@amd.com>, Mark Rutland <mark.rutland@arm.com>,
 James Clark <james.clark@arm.com>,
 Athira Rajeev <atrajeev@linux.vnet.ibm.com>, Kajol Jain
 <kjain@linux.ibm.com>, Thomas Richter <tmricht@linux.ibm.com>,
 Atish Patra <atishp@atishpatra.org>, Palmer Dabbelt <palmer@rivosinc.com>,
 Mingwei Zhang <mizhang@google.com>, Ian Rogers <irogers@google.com>,
 Kan Liang <kan.liang@linux.intel.com>
References: <20240904064131.2377873-1-namhyung@kernel.org>
 <20240904064131.2377873-8-namhyung@kernel.org>
 <8c47cb2a-2bea-422d-b16c-f304ab4ff470@linaro.org>
Content-Language: en-US
In-Reply-To: <8c47cb2a-2bea-422d-b16c-f304ab4ff470@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 04/09/2024 2:28 pm, James Clark wrote:
> 
> 
> On 04/09/2024 7:41 am, Namhyung Kim wrote:
>> It seems Apple M1 PMU requires exclude_guest set and returns EOPNOTSUPP
>> if not.  Let's add a fallback so that it can work with default events.
>>
>> Cc: Mark Rutland <mark.rutland@arm.com>
>> Cc: James Clark <james.clark@linaro.org>
>> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
>> ---
>>   tools/perf/util/evsel.c | 21 +++++++++++++++++++++
>>   1 file changed, 21 insertions(+)
>>
>> diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
>> index 0de0a72947db3f10..8c4d70f7b2f5b880 100644
>> --- a/tools/perf/util/evsel.c
>> +++ b/tools/perf/util/evsel.c
>> @@ -3400,6 +3400,27 @@ bool evsel__fallback(struct evsel *evsel, 
>> struct target *target, int err,
>>                 "to fall back to excluding hypervisor samples", 
>> paranoid);
>>           evsel->core.attr.exclude_hv = 1;
>> +        return true;
>> +    } else if (err == EOPNOTSUPP && !evsel->core.attr.exclude_guest &&
>> +           !evsel->exclude_GH) {
>> +        const char *name = evsel__name(evsel);
>> +        char *new_name;
>> +        const char *sep = ":";
>> +
>> +        /* Is there already the separator in the name. */
>> +        if (strchr(name, '/') ||
>> +            (strchr(name, ':') && !evsel->is_libpfm_event))
>> +            sep = "";
>> +
>> +        if (asprintf(&new_name, "%s%su", name, sep) < 0)
>> +            return false;
>> +
>> +        free(evsel->name);
>> +        evsel->name = new_name;
>> +        /* Apple M1 requires exclude_guest */
>> +        scnprintf(msg, msgsize, "trying to fall back to excluding 
>> guest samples");
>> +        evsel->core.attr.exclude_guest = 1;
>> +
>>           return true;
>>       }
> 
> Not sure if this is working, for some reason it doesn't try the 
> fallback. With exclude guest made mandatory in the Arm PMU, then:
> 
>   $ perf stat -e cycles -vvv -- true
> 
>    Control descriptor is not initialized
>    Opening: cycles
>    ------------------------------------------------------------
>    perf_event_attr:
>      type                             0 (PERF_TYPE_HARDWARE)
>      size                             136
>      config                           0xb00000000
>      sample_type                      IDENTIFIER
>      read_format                      TOTAL_TIME_ENABLED|TOTAL_TIME_RUNNING
>      disabled                         1
>      inherit                          1
>      enable_on_exec                   1
>    ------------------------------------------------------------
>    sys_perf_event_open: pid 698  cpu -1  group_fd -1  flags 0x8
>    sys_perf_event_open failed, error -95
>    Warning:
>    cycles event is not supported by the kernel.
>    Opening: cycles
>    ------------------------------------------------------------
>    perf_event_attr:
>      type                             0 (PERF_TYPE_HARDWARE)
>      size                             136
>      config                           0xa00000000
>      sample_type                      IDENTIFIER
>      read_format                      TOTAL_TIME_ENABLED|TOTAL_TIME_RUNNING
>      disabled                         1
>      inherit                          1
>      enable_on_exec                   1
>    ------------------------------------------------------------
>    sys_perf_event_open: pid 698  cpu -1  group_fd -1  flags 0x8
>    sys_perf_event_open failed, error -95
>    Warning:
>    cycles event is not supported by the kernel.
>    failed to read counter cycles
>    failed to read counter cycles
> 
>     Performance counter stats for 'true':
> 
>       <not supported>      armv8_cortex_a53/cycles/
>       <not supported>      armv8_cortex_a57/cycles/
> 
> 
> 
> Other than that, all the tests are passing on Juno (without the 
> exclude_guest requirement).

Sorry one other thing, I think this commit would also need to come 
before the change to the exclude_guest default to keep bisect working.

