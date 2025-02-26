Return-Path: <linux-kernel+bounces-533526-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EAE9A45BAF
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 11:25:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8FD1A188FF40
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 10:25:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD2FE2459D0;
	Wed, 26 Feb 2025 10:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VXb8cC6l"
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31603238165
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 10:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740565514; cv=none; b=I854BsxAIpykl7wyctsaOcThV//PIDodyj3WRG0MNbBimSq4WNf/iULv/poWF0hbfjH73JQqbhizXdacGstz3hkE2TT9X2KcQ/e9bIuEeY9naABWXjz4jSgxqm6RruaFv5PxtbTvYVs9vTbqRWYqjlRaoK4RKctxWgFmI4S8Gko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740565514; c=relaxed/simple;
	bh=I+/Cav1TJHj/Tbx1gffjMoAc+RpLVvSUahSN9bSlFcg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gIN0Wmfy0TQFEUKvTn7dq+3g+gdQpWbq0IL1oQ/Q5tepTZYeTFk/ztXhtLqp24GUb5b/1nd6fEBEbStRvcC4Xjqvmqw4iVP9S6E+l/9QpUomQPMNPzLiqcFlDqnNl4AWhgLRXZrCpzdHWk2W6qSuL7Lt83s0ABB0ktGH0dCDXl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=VXb8cC6l; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-38a25d4b9d4so3756953f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 02:25:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740565510; x=1741170310; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wibN8Cvu0K5ErM6j1Uy/yqqzYl4gFqiUmqiGWxUEQOM=;
        b=VXb8cC6lmiI3YiUBwRJFeKrnQeaP2PS7ECGLqJ88XLyENtWEqvOx9t0iZpCGaJw26V
         /XK8UJQMH9sjpokVuyb0SZmVfnqBv01nmJ6LbD+Js2qTbmIfOxqgYNZtPKujpZOZxkhu
         WfEhUPUqIj3CvE9xInv6Rr2rXnroRME7i85/P+Ahr8E4AcW0+j2xTbwh9MCU6bfBWgvy
         VtQI+41vGF+rHvTmMcA71/rXYg9ms+TGw9S82cjnKX/dl39XcBDbaZAEa3DSV5mSOcAU
         RXiHKrLR82zcLS0mq5pUnlMD6BgxdP9t9tqyR7Mo3wvh+4JrIc5f+Ejsxu2vvoMcDyBd
         aU8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740565510; x=1741170310;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wibN8Cvu0K5ErM6j1Uy/yqqzYl4gFqiUmqiGWxUEQOM=;
        b=O5maSJa+VfcVtCOYaATQRIiTuYN43pDqBLfChAWX89R6hOFmMFL1dVvvu7+g4q9p7Q
         N9Wp9L2p2KoX4K3ktyzsGkHIyp0ceLlunbbJi0Mz/hUJk9CB7m5lhv7a03wr08NM1lNd
         fABtVQqLaKHJS+NQDTZOgjh6xgc2uFoKK6q0waACDiFLjSqoAxq4w+CGrd9FIrU3gDGo
         lZM3AbdGzEloM3kwUOoZsLSRhqgEkIpipXYz1UxRmkm9LF0g9suwpMQKmYdq9h5kxfHb
         orMn/rbqu+VMoENCodne/c3dPyLnvN1jr3Iju3HwX6LOkZgH27ABzpE/mrvNRpzEu7vB
         k5ww==
X-Forwarded-Encrypted: i=1; AJvYcCWpG1kZ1hbLub+yickGFtd5M+y9XVPjg0Q6+CpvMFV0cKaEo0Yau1Sei1o/lXHwMb6/93fuNnhnbgrp8RM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBigiCFjqtW2TINHKBZWWg1CxCv0Ui+4ziK5QUZWONr+ABwG7j
	sEhNqwvSTkghN4/xF0itFeanOJLplqf1hJrCchD10wzK/5rDEZhkfpU9VO3+QAo=
X-Gm-Gg: ASbGnct+SrwVzJr3/ye1yemv4YkdY1JwEJtty66jj/Qc8HasPHqzX9Jny8PmoobXUCj
	OYPKn9ZMaAXDAXQ2vmnuhBjOWLtgZ37BflJQ/wqaFw6Mo46fE5a0NkI50UJDFQNR6wNAPKF2qwS
	F35IovoWaB1qsujZmcJnJFGITIdrCo35EXOboOnC6KVxREAnyBNkdNiTg5avZhBbIBKz8dAWbCG
	O/z5GNDVjCW7W3sIPA7JWWOhWCS16hWIa39mFnAeuG7U1F++9mD5LAsnlY72y7+/J8JqJjjgBui
	b+R8ybZdrT9l0f75VHhQWrY8fzOhozQnuQ==
X-Google-Smtp-Source: AGHT+IHjTO/1pjFHH+kjwewzcZzsGbp38uIF1SvTmpmkYjcZgHEn+7WkzgXXANIFTttdLT6P7jm5tA==
X-Received: by 2002:adf:e912:0:b0:38f:24f9:8bac with SMTP id ffacd0b85a97d-390cc60c1f9mr5068902f8f.23.1740565510339;
        Wed, 26 Feb 2025 02:25:10 -0800 (PST)
Received: from [192.168.1.247] ([145.224.66.72])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390cd86caf2sm5066404f8f.23.2025.02.26.02.25.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Feb 2025 02:25:09 -0800 (PST)
Message-ID: <b91333cd-ebc0-44a0-919e-a9455f4c44c8@linaro.org>
Date: Wed, 26 Feb 2025 10:25:08 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] perf pmu: Dynamically allocate tool PMU
To: Ian Rogers <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org, namhyung@kernel.org, cyy@cyyself.name,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
 "Liang, Kan" <kan.liang@linux.intel.com>,
 Yoshihiro Furudera <fj5100bi@fujitsu.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Weilin Wang <weilin.wang@intel.com>, Junhao He <hejunhao3@huawei.com>,
 Jean-Philippe Romain <jean-philippe.romain@foss.st.com>,
 linux-kernel@vger.kernel.org
References: <20250225164639.522741-1-james.clark@linaro.org>
 <20250225164639.522741-2-james.clark@linaro.org>
 <CAP-5=fW1NkeZjBpNijV1oKNjZ_F480wahmUPfEN9vrxYjwD=9A@mail.gmail.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <CAP-5=fW1NkeZjBpNijV1oKNjZ_F480wahmUPfEN9vrxYjwD=9A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 25/02/2025 5:19 pm, Ian Rogers wrote:
> On Tue, Feb 25, 2025 at 8:47 AM James Clark <james.clark@linaro.org> wrote:
>>
>> perf_pmus__destroy() treats all PMUs as allocated and free's them so we
>> can't have any static PMUs that are added to the PMU lists. Fix it by
>> allocating the tool PMU in the same way as the others. Current users of
>> the tool PMU already use find_pmu() and not perf_pmus__tool_pmu(), so
>> rename the function to add 'new' to avoid it being misused in the
>> future.
>>
>> perf_pmus__fake_pmu() can remain as static as it's not added to the
>> PMU lists.
>>
>> Fixes the following error:
>>
>>    $ perf bench internals pmu-scan
>>
>>    # Running 'internals/pmu-scan' benchmark:
>>    Computing performance of sysfs PMU event scan for 100 times
>>    munmap_chunk(): invalid pointer
>>    Aborted (core dumped)
>>
>> Fixes: 240505b2d0ad ("perf tool_pmu: Factor tool events into their own PMU")
>> Signed-off-by: James Clark <james.clark@linaro.org>
>> ---
>>   tools/perf/util/pmus.c     |  2 +-
>>   tools/perf/util/tool_pmu.c | 23 +++++++++++------------
>>   tools/perf/util/tool_pmu.h |  2 +-
>>   3 files changed, 13 insertions(+), 14 deletions(-)
>>
>> diff --git a/tools/perf/util/pmus.c b/tools/perf/util/pmus.c
>> index 8a0a919415d4..c1815edaca37 100644
>> --- a/tools/perf/util/pmus.c
>> +++ b/tools/perf/util/pmus.c
>> @@ -268,7 +268,7 @@ static void pmu_read_sysfs(unsigned int to_read_types)
>>
>>          if ((to_read_types & PERF_TOOL_PMU_TYPE_TOOL_MASK) != 0 &&
>>              (read_pmu_types & PERF_TOOL_PMU_TYPE_TOOL_MASK) == 0) {
>> -               tool_pmu = perf_pmus__tool_pmu();
>> +               tool_pmu = perf_pmus__new_tool_pmu();
>>                  list_add_tail(&tool_pmu->list, &other_pmus);
>>          }
>>          if ((to_read_types & PERF_TOOL_PMU_TYPE_HWMON_MASK) != 0 &&
>> diff --git a/tools/perf/util/tool_pmu.c b/tools/perf/util/tool_pmu.c
>> index 3a68debe7143..45eae810b205 100644
>> --- a/tools/perf/util/tool_pmu.c
>> +++ b/tools/perf/util/tool_pmu.c
>> @@ -490,17 +490,16 @@ int evsel__tool_pmu_read(struct evsel *evsel, int cpu_map_idx, int thread)
>>          return 0;
>>   }
>>
>> -struct perf_pmu *perf_pmus__tool_pmu(void)
>> +struct perf_pmu *perf_pmus__new_tool_pmu(void)
>>   {
>> -       static struct perf_pmu tool = {
>> -               .name = "tool",
>> -               .type = PERF_PMU_TYPE_TOOL,
>> -               .aliases = LIST_HEAD_INIT(tool.aliases),
>> -               .caps = LIST_HEAD_INIT(tool.caps),
>> -               .format = LIST_HEAD_INIT(tool.format),
>> -       };
>> -       if (!tool.events_table)
>> -               tool.events_table = find_core_events_table("common", "common");
>> -
>> -       return &tool;
>> +       struct perf_pmu *tool = zalloc(sizeof(struct perf_pmu));
>> +
>> +       tool->name = strdup("tool");
>> +       tool->type = PERF_PMU_TYPE_TOOL;
>> +       INIT_LIST_HEAD(&tool->aliases);
>> +       INIT_LIST_HEAD(&tool->caps);
>> +       INIT_LIST_HEAD(&tool->format);
>> +       tool->events_table = find_core_events_table("common", "common");
>> +
>> +       return tool;
>>   }
>> diff --git a/tools/perf/util/tool_pmu.h b/tools/perf/util/tool_pmu.h
>> index a60184859080..268f05064d03 100644
>> --- a/tools/perf/util/tool_pmu.h
>> +++ b/tools/perf/util/tool_pmu.h
>> @@ -51,6 +51,6 @@ int evsel__tool_pmu_open(struct evsel *evsel,
>>                           int start_cpu_map_idx, int end_cpu_map_idx);
>>   int evsel__tool_pmu_read(struct evsel *evsel, int cpu_map_idx, int thread);
>>
>> -struct perf_pmu *perf_pmus__tool_pmu(void);
>> +struct perf_pmu *perf_pmus__new_tool_pmu(void);
> 
> I think for consistency this should be "tool_pmu__new" although pmus
> have odd function names like "lookup" which is basically "new". I was
> trying to be smart by avoiding the allocation, but I also don't think
> it matters and correct is more important. Thanks for doing this.
> 
> Reviewed-by: Ian Rogers <irogers@google.com>
> 
> Ian
> 

No worries. Yes you're right about the rename, I'll resend it.

I did try adding a static flag that caused them to not be free'd, but 
it's fragile because there are members that could contain allocations 
even if the PMU is static, and then you also need to track re-adding it 
to the list if that gets cleared.

>>
>>   #endif /* __TOOL_PMU_H */
>> --
>> 2.34.1
>>


