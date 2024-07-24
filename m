Return-Path: <linux-kernel+bounces-261168-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF9E493B389
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 17:23:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 07481B23686
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 15:23:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52CCF15B13B;
	Wed, 24 Jul 2024 15:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yeQBcvEe"
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC0B21591EA
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 15:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721834586; cv=none; b=UalmOoJdf4AC9/t0Q8qXIzmFtD8l1SA4/uJrUiiYNvOsP9jCz7rlAXWB6tjX36fBZLrFotoyzYT+KGo8ZBoitEadzylWCCo4cOpTYoyK30PDVEST27YR1u/unDHgovwyJ3qVQAt+I3znRYnxgK1abKvPwRE6tImmR/LeAcYBvfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721834586; c=relaxed/simple;
	bh=00Lvw4LfeLNWJz764oZVHwF/AIp+LReLlGhG7UY0lyg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HPJWitqlfhiKo3KwYGzIr7ss4A5nJbe5eX1WPiesS/3BUJiSaCGqoN/PHZr4HSulYsGkdfi9dN9s8/xogVHyoCBb5+bx9cNHTzavm6l/+JaOjYuA20fwMFYQOsswUKurmx2luTNm05yJBDTDF1YiiVmyOrVHcw0Q5WWWM2wO4a0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=yeQBcvEe; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3684e8220f9so582724f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 08:23:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721834583; x=1722439383; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RPTIoOrTjWqM5QxFKIukuu9F2Sbk+6zfU+HH6r8TZG0=;
        b=yeQBcvEeK+X/uTsRSeIEmjkvdfgcUsatU846yVu4uAeirVGwsAqgpjV10zvTPl5I53
         LLg6mF/8tnvM/Fa11FLR5K1zEY2/QBoxjY42BtjCbKytDPIqz52V6LUlJsvQKxpZvtyg
         xXo4nPF5r9nvrspv/hUj9T8HBXs7oGjvC9g4DYZh9mB/s0M88pkEMHtr3ZcIJVKgib8B
         P7ez5GkvFDqI2n6dYf5dzqzwNNkFLa8cmFgr43fEGwz/6V4P/Xgk/T61Q8TfFYsThMfi
         8UezuBGKOvd4mQ0DkipnpZhn01U+WMrbCZ4qc/gspjFXbUCZ4MMWADBplSg7CRAT58M+
         F/3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721834583; x=1722439383;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RPTIoOrTjWqM5QxFKIukuu9F2Sbk+6zfU+HH6r8TZG0=;
        b=tvOxzLMRmJ0BfVMWjHVOnYp6LYxI5Z4VmjOS+osAWqfZw27lIIospvffu4ZPXbu2Ig
         ssaFvoW2ycHnS1UcI12SVrtr2Q6LTCePJYSMY2diGkIUR18kMcm42f7uiawcBNhFWZ9p
         S5e8GuBiAKuYNZR1eQqhznlgOHP8KCWm0RQGhfy7wbiikkJHG1yMRzxP9OyLn72rYW1c
         wlc8AJ5WS4jA3IoyiOJQIOrE4z+E29b2kmJqjkVwLgopZKyqR0PT4W0maGBDXpaSH26p
         KB/TJtxwxJAfbnpD+wVOXzmrPS/1mpeoKNBzof5gaAt/jViLcCUw4SnOBMmeD3rSAnRD
         C1yg==
X-Forwarded-Encrypted: i=1; AJvYcCUvV8mj7lWYUvP0hpZc1xa0w6qHNiqmsXIv4JUrySy0pRVpPCDbHZCNY/QraGmbDcKHtBiO+UtRQh4dFBQyLC509xaqPbhnkHAREtGf
X-Gm-Message-State: AOJu0Yx/Zg+apvQ888hZZo1YSw2d6/FLcBtI3N+fM/Lznrr+5jPPHWg6
	Y2XQGdcKf1R2alSBnJ52/VOHoTYS9m1GZyJuFYzxrvXmOZ/qdUZDNud95NW5zpo=
X-Google-Smtp-Source: AGHT+IELHJAVkBHikq0DcSqT4I8dqH7FzTfBuUEt1ReY+zMY/vj/fnuMfBj4F6YX3djoT4zjmG0n/g==
X-Received: by 2002:adf:a3d4:0:b0:368:377a:e8bb with SMTP id ffacd0b85a97d-369f6706278mr1513654f8f.28.1721834583106;
        Wed, 24 Jul 2024 08:23:03 -0700 (PDT)
Received: from [192.168.1.3] ([89.47.253.130])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-427f93e667bsm33556575e9.29.2024.07.24.08.23.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Jul 2024 08:23:02 -0700 (PDT)
Message-ID: <50b78571-34b5-4ad9-abc3-0416b3d9b917@linaro.org>
Date: Wed, 24 Jul 2024 16:23:01 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf scripts python: cs-etm: Update example to provide
 vmlinux path to Perf
To: Leo Yan <leo.yan@arm.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>,
 "Liang, Kan" <kan.liang@linux.intel.com>,
 Ruidong Tian <tianruidong@linux.alibaba.com>,
 Benjamin Gray <bgray@linux.ibm.com>, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org, coresight@lists.linaro.org,
 gankulkarni@os.amperecomputing.com, mike.leach@linaro.org,
 suzuki.poulose@arm.com
References: <20240724143319.169745-1-james.clark@linaro.org>
 <225ff37c-0e50-48d5-bb4c-e8a63e72991a@arm.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <225ff37c-0e50-48d5-bb4c-e8a63e72991a@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 24/07/2024 4:00 pm, Leo Yan wrote:
> On 7/24/2024 3:33 PM, James Clark wrote:
>>
>> The example shows the vmlinux path being given to the script, but this
>> only works when running on the target. If the script is run off the
>> target, then confusingly the vmlinux argument also needs to be given to
>> Perf as well.
>>
>> Without going into too much detail in the example about when it is or
>> isn't required, just include it. It doesn't do any harm even when
>> running on the target. Now the example command works in both places.
>>
>> Signed-off-by: James Clark <james.clark@linaro.org>
> 
> The change makes senses to me.  Just check a bit, does it need to add the same
> option for the command "only source line and symbols"?
> 
> Thanks,
> Leo
> 

I assumed that because that one didn't have vmlinux at all then it's 
just for userspace tracing. I think it's good to have an example without 
vmlinux to show that it's not a strict requirement.

>> ---
>>   tools/perf/scripts/python/arm-cs-trace-disasm.py | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/tools/perf/scripts/python/arm-cs-trace-disasm.py b/tools/perf/scripts/python/arm-cs-trace-disasm.py
>> index 7aff02d84ffb..4aeb9b497f7a 100755
>> --- a/tools/perf/scripts/python/arm-cs-trace-disasm.py
>> +++ b/tools/perf/scripts/python/arm-cs-trace-disasm.py
>> @@ -19,10 +19,10 @@ from perf_trace_context import perf_set_itrace_options, \
>>   # Below are some example commands for using this script.
>>   #
>>   # Output disassembly with objdump:
>> -#  perf script -s scripts/python/arm-cs-trace-disasm.py \
>> +#  perf script -k path/to/vmlinux -s scripts/python/arm-cs-trace-disasm.py \
>>   #              -- -d objdump -k path/to/vmlinux
>>   # Output disassembly with llvm-objdump:
>> -#  perf script -s scripts/python/arm-cs-trace-disasm.py \
>> +#  perf script -k path/to/vmlinux -s scripts/python/arm-cs-trace-disasm.py \
>>   #              -- -d llvm-objdump-11 -k path/to/vmlinux
>>   # Output only source line and symbols:
>>   #  perf script -s scripts/python/arm-cs-trace-disasm.py
>> --
>> 2.34.1
>>

