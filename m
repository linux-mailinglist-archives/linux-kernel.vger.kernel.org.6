Return-Path: <linux-kernel+bounces-392125-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 419B69B9000
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 12:10:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F062F281EC2
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 11:09:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA5691922D6;
	Fri,  1 Nov 2024 11:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="P502Y5b9"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC64D15F330
	for <linux-kernel@vger.kernel.org>; Fri,  1 Nov 2024 11:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730459392; cv=none; b=boZxLRd7wG6o6SBjveMxICdAzTXlMPkP8qmhNYoqlXWWFsTMxfHk13QkMUEMni5Vtp8GfWCRwKegivRyonZpwjdFIb9xmjiVSDc/ccACRYeXcI4STlxZI9Fy17nqBh1NilzN7Fzb5Zi1H0zD3Oy5pnE5T/+5Yhr4ZkExfydhJNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730459392; c=relaxed/simple;
	bh=FcCnucfdn3onmEl44gQNyTAY2UG5y2cFt6pWw6BPDLA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=X06E93xDlKoqbEi5bnkhpYMWYpbcrGTVGMo4u0/XHSH4T30RLeGCf1ksSn5bIgH57MfP7+/5dMnVrZ1uuZxROM/C21lwYPoXfKhwD2jb2HCPioQIP4D8vucBwvwsOlhyJXqwOwWC2Ist/Lxr3iLQUa4hS3/Au9rO4Ax91h1p39Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=P502Y5b9; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4314c4cb752so16515555e9.2
        for <linux-kernel@vger.kernel.org>; Fri, 01 Nov 2024 04:09:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730459388; x=1731064188; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=P/NoOgguiT5CwhdaZ9aqZFjMO9gxSREHEAGHzeVSbb8=;
        b=P502Y5b9/F7gpAg+L/6/+X/jS/LgUsyyi6GiJlX1/bXkL8ERg7781AXxkZcqJ3W3xC
         O0F90orH4BphKq8vqn84PUSKTjPFh+EYyT2L34iXiwk56GrSpK7B5gw9vR/UYpdLvMYh
         j7pKtt/rTqEd1YiaGDxltNeuu/rPV7JvPyI/qdS5e66dDBkRwtLk2/rUzutXnvHYwK/y
         rxqNKwRjGmEJ5rhAVe3+Olb/z7D6BfFGVYxWffJ8MMeEDNnh4vWlr258zMnHDeK3Q17p
         /eE3/eavD7XKMc4XSPvWgu9ClzeArjdEU2xl30QdDLmvIwmUwU6rpAKS8rUUnoAHLUTr
         VxAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730459388; x=1731064188;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=P/NoOgguiT5CwhdaZ9aqZFjMO9gxSREHEAGHzeVSbb8=;
        b=k0Gsy7MI2/W1637UMeWywX/SS5GmYY/op8ykW+Io+VXqtIej2RHLbNEhQnWZ/Nraa7
         KZo92ZuKDOd3NkUC4se6kpR5N8GjNIPnRRlD1KMHphoi7XgpaeHtSQyOdNZP4oVD9IUh
         S2s8q2mB1YSX2J5FN21gxiW2SEjbMb4scUHeDJtsW4qJo/VWMym+tKZaeDAnmS7REaSL
         Z0n+G1qIPTjp+WL7ZRhXFjXZa7w7OSGxcuuqJIxqk4slX1xmvjOEYsY0FNmJTu7jabGV
         nqR7kTwc+3TvXkM9sW4u3miJaPsU17X+mcLFixwZTkL45RQ/TnjcaNNA0G8yPwmkkbFR
         ZhGg==
X-Forwarded-Encrypted: i=1; AJvYcCUjSDzt+2+HZYjpPCtSVy7dE6WHSwGBVfsmHzgMmPi62+hT/x87YeE5HBcGtE5aCtk2RGiy6v4wEkY3UHg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxM9dz+ZThD9gKoDNeNEYgKFdjsZBUEns3vP9r5FM2fv/c2PTZz
	H9qSb1/fxfJHqngtNNWMxmLUVDAt4sYTaes748f804czf5pYaWmbyBRJd4T2j7k=
X-Google-Smtp-Source: AGHT+IGy25iB2kEih8ZNrVQR3lDO7Xf74KqwbID85Ejd5e2Q6zpkg2hxYaGVoaMNvA9obVYPKXjWmQ==
X-Received: by 2002:a05:600c:5115:b0:431:7c78:b885 with SMTP id 5b1f17b1804b1-4327b6f954emr56401345e9.4.1730459387869;
        Fri, 01 Nov 2024 04:09:47 -0700 (PDT)
Received: from [192.168.68.136] ([145.224.65.67])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4327d6983b7sm55635355e9.43.2024.11.01.04.09.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Nov 2024 04:09:46 -0700 (PDT)
Message-ID: <cbbc3714-3f5e-41f3-8f2a-0a3ec95552c0@linaro.org>
Date: Fri, 1 Nov 2024 11:09:44 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] perf stat: Fix trailing comma when there is no
 metric unit
To: Ian Rogers <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org, acme@kernel.org, namhyung@kernel.org,
 tim.c.chen@linux.intel.com, Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@redhat.com>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
 "Liang, Kan" <kan.liang@linux.intel.com>,
 Yicong Yang <yangyicong@hisilicon.com>, linux-kernel@vger.kernel.org
References: <20241030113946.229361-1-james.clark@linaro.org>
 <20241030113946.229361-2-james.clark@linaro.org>
 <CAP-5=fXbh3i0i1Bwh9c3reZLZyXU6QShcyjwKaRsMp9YR0CMsQ@mail.gmail.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <CAP-5=fXbh3i0i1Bwh9c3reZLZyXU6QShcyjwKaRsMp9YR0CMsQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 31/10/2024 4:17 am, Ian Rogers wrote:
> On Wed, Oct 30, 2024 at 4:40 AM James Clark <james.clark@linaro.org> wrote:
>>
>> Now that printing metric-value and metric-unit is optional,
>> print_running_json() shouldn't add the comma in case it becomes
>> trailing.
>>
>> Replace all manual json comma stuff with a json_out() function that uses
>> the existing os->first tracking and auto inserts a comma if it's needed.
>> Update the test to handle that two of the fields can be missing.
> 
> Thanks for the larger clean up!
> 
>> This fixes the following test failure on Cortex A57 where the branch
>> misses metric is missing a required event:
>>
>>   $ perf test -vvv "json output"
>>
>>   106: perf stat JSON output linter:
>>   --- start ---
>>   test child forked, pid 665682
>>   Checking json output: no args Test failed for input:
>>   ...
>>   {"counter-value" : "3112.000000", "unit" : "",
>>    "event" : "armv8_pmuv3_1/branch-misses/",
>>    "event-runtime" : 20699340, "pcnt-running" : 100.00, }
>>   ...
>>   json.decoder.JSONDecodeError: Expecting property name enclosed in
>>   double quotes: line 12 column 144 (char 2109)
>>   ---- end(-1) ----
>>   106: perf stat JSON output linter                 : FAILED!
>>
>> Fixes: e1cc918b6cfd ("perf stat: Drop metric-unit if unit is NULL")
>> Signed-off-by: James Clark <james.clark@linaro.org>
>> ---
>>   .../tests/shell/lib/perf_json_output_lint.py  |  14 +-
>>   tools/perf/util/stat-display.c                | 177 ++++++++++--------
>>   2 files changed, 104 insertions(+), 87 deletions(-)
>>
>> diff --git a/tools/perf/tests/shell/lib/perf_json_output_lint.py b/tools/perf/tests/shell/lib/perf_json_output_lint.py
>> index 8ddb85586131..b066d721f897 100644
>> --- a/tools/perf/tests/shell/lib/perf_json_output_lint.py
>> +++ b/tools/perf/tests/shell/lib/perf_json_output_lint.py
>> @@ -69,16 +69,16 @@ def check_json_output(expected_items):
>>     for item in json.loads(input):
>>       if expected_items != -1:
>>         count = len(item)
>> -      if count != expected_items and count >= 1 and count <= 7 and 'metric-value' in item:
>> +      if count not in expected_items and count >= 1 and count <= 7 and 'metric-value' in item:
>>           # Events that generate >1 metric may have isolated metric
>>           # values and possibly other prefixes like interval, core,
>>           # aggregate-number, or event-runtime/pcnt-running from multiplexing.
>>           pass
>> -      elif count != expected_items and count >= 1 and count <= 5 and 'metricgroup' in item:
>> +      elif count not in expected_items and count >= 1 and count <= 5 and 'metricgroup' in item:
>>           pass
>> -      elif count == expected_items + 1 and 'metric-threshold' in item:
>> +      elif count - 1 in expected_items and 'metric-threshold' in item:
>>             pass
>> -      elif count != expected_items:
>> +      elif count not in expected_items:
>>           raise RuntimeError(f'wrong number of fields. counted {count} expected {expected_items}'
>>                              f' in \'{item}\'')
>>       for key, value in item.items():
>> @@ -90,11 +90,11 @@ def check_json_output(expected_items):
>>
>>   try:
>>     if args.no_args or args.system_wide or args.event:
>> -    expected_items = 7
>> +    expected_items = [5, 7]
>>     elif args.interval or args.per_thread or args.system_wide_no_aggr:
>> -    expected_items = 8
>> +    expected_items = [6, 8]
>>     elif args.per_core or args.per_socket or args.per_node or args.per_die or args.per_cluster or args.per_cache:
>> -    expected_items = 9
>> +    expected_items = [7, 9]
>>     else:
>>       # If no option is specified, don't check the number of items.
>>       expected_items = -1
>> diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-display.c
>> index 53dcdf07f5a2..a5d72f4a515c 100644
>> --- a/tools/perf/util/stat-display.c
>> +++ b/tools/perf/util/stat-display.c
>> @@ -114,23 +114,44 @@ static void print_running_csv(struct perf_stat_config *config, u64 run, u64 ena)
>>          fprintf(config->output, "%s%" PRIu64 "%s%.2f",
>>                  config->csv_sep, run, config->csv_sep, enabled_percent);
>>   }
>> +struct outstate {
>> +       FILE *fh;
>> +       bool newline;
>> +       bool first;
> 
> It'd be nice to have kernel-doc capturing the meaning of these
> variables. newline and first, why would something be a newline but not
> first? I know the lack of documentation is a pre-existing condition.
> Pretty much every variable in the struct below confuses me and I need
> to read the code to try to figure it out.
> 
>> +       const char *prefix;
> 
> Prefix of what?
> 
>> +       int  nfields;
> 
> Is this the number of columns in CSV format? Why not a name like
> csv_columns then? What is a field here?
> 
>> +       int  aggr_nr;
>> +       struct aggr_cpu_id id;
> 
> Something to do with aggregation, presumably for the current CSV line.
> Why two of them?
> 
>> +       struct evsel *evsel;
>> +       struct cgroup *cgrp;
> 
> Maybe the counter and cgroup being printed, but we usually pass those
> as extra arguments. This loses me.
> 
> I was hoping the code here could be more like the perf list json:
> https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tree/tools/perf/builtin-list.c?h=perf-tools-next#n357
> which avoids the comma problem by printing everything in one go.
> There's so much spaghetti code in stat-display and before we had tests
> there were frequent breakages. Anyway, I don't expect a larger clean
> up, just venting. If you could do the comments and clear up the
> newline vs first it'd be great.
> 
> Thanks,
> Ian
> 

Yep I can do that.

Thanks for the review.



