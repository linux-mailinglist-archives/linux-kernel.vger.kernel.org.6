Return-Path: <linux-kernel+bounces-388390-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BB7BC9B5EFF
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 10:36:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 78CC4281427
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 09:36:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CE691E231C;
	Wed, 30 Oct 2024 09:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gRFx/I7E"
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2720A1D3578
	for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 09:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730281003; cv=none; b=ny0JcktL+eyvN2vsJ6FNkAEz7FTzuR5RpGhGe4gYcBizB5849S2vo4RZEi4UrKUIR0yQwzbPVGK/5/4EZG9j3uVbDi7iVgI/d8OF+51gvece6mToQ/DQph4QdqExtBzhjC1LNF38+oVje8l652y1KSndOi3auuGn8wrtJDX0r5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730281003; c=relaxed/simple;
	bh=g144MaWQXpBZiXVb5U4Dg70dwQdFHSoPZzIlHrCc1Ek=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ScxVP9OIpqT2jeIZlDcAgKDYZ45aHHIjLNe+5hbt4T345nrV63di3tHCFRCl/QFdjeIuBCUP2khHMrV7Yr+fMP+Y3dP8q39nejPTmRGxd4XzpruEb5O7R2JziUkJHMcEHJHDMoSKfY6l+4JhfPVh+wVmb3/c6KHsIbRLq+nHVEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=gRFx/I7E; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-37d4c482844so4278727f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 02:36:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730280999; x=1730885799; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ELYC2gVZ99VwEOWagCjCy5Ob4XCFiyaVZTZYU7wE3hQ=;
        b=gRFx/I7EceBLGmb12ZX6i/BlvGkSRCOWrGGkcP536HyqzXPZnzld4d/sXYih03mXSp
         AfGGo41D4FKwFpPRu11Mh/hsP1iTQ688WwPsyYL0e5BhmXLs/V+EticHz0UwVGsVHKUO
         QQJHGurLLSJ8S57zpUeE8Mcfs9baVGGpLa6DA9Nw/UUdO3d2SwVUeqJPaxARk3vd1JVj
         uW+CwM3MRWjyW45ZUp4WKI6CNpPtZ7+1QhP3N+6p/mSfV9YEpeJzJ3zfU/ZAEaSDXAdp
         fIxy5RoII2+gca2jwK+M4NddY4uanPJz2W++RZf5hgqb9bpSMYKtYf7srjCH5gpjUhS7
         UtAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730280999; x=1730885799;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ELYC2gVZ99VwEOWagCjCy5Ob4XCFiyaVZTZYU7wE3hQ=;
        b=OCogaLinsJomyTalRnNiLF3Se8EB35+RnrO2nlGgfrC4kv7g/bPrUCshN1Qn/pOf5n
         EONlJjIYvYPyH6vLyZ85C8Buj/sxXUogO2EgELqbkEt4Z9SZI0adwSQFh+jq3+tpjndI
         iRa2ifrbu1v86iRFFCJ/MpzSPw8umqyhjEhohwxYriPQAXHcFrfPfRAy/2hIQNFet4fA
         L9LVFSyy8rKmuq0DUF+TIfS5vZJKyVgNnLZEtzJP8FCyM26VxuyiK8EdQY8pLsQHcP9P
         pePK6do04ygbzB6xJTslFIyRbszhZMFzJM3NqcwJesa5DL0n+oWWEAX/xDVTyF83u5cu
         XFbA==
X-Forwarded-Encrypted: i=1; AJvYcCXO8shdcO2UsZ6Nt0ddwFAA/yfIwivYDz4odSzpNz2JNN84mN4/MDt+0s9H1aLk81TbjyqHne2fnvRxWvc=@vger.kernel.org
X-Gm-Message-State: AOJu0YycmBL5W88NjY9gUfOp6otNUhmeCe7XxJo9A9cz0S4lIcuA4oMn
	vA8/AbsV2HsgxplXKOcLJ2tbHha6m8zXjJ/N3gTcjWTMdrBrzaFGmMb3R+xroNzwl4Km3BR2Xxu
	dvKA=
X-Google-Smtp-Source: AGHT+IEat8vDlw0b+jhMPlZN07cwDFRJB0AuzwWd5k/uXRcvUNp5TgoboENX1jvNvW/hZfV/nzNwTg==
X-Received: by 2002:adf:ea06:0:b0:37d:45f0:dd08 with SMTP id ffacd0b85a97d-380610f212emr10643342f8f.11.1730280999474;
        Wed, 30 Oct 2024 02:36:39 -0700 (PDT)
Received: from [192.168.68.136] ([145.224.65.67])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38058b3c625sm14884531f8f.37.2024.10.30.02.36.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Oct 2024 02:36:39 -0700 (PDT)
Message-ID: <1ab9d5be-b31b-4f76-9ccd-001603a55e53@linaro.org>
Date: Wed, 30 Oct 2024 09:36:37 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] perf stat: Also hide metric from JSON if units are an
 empty string
To: Ian Rogers <irogers@google.com>, Namhyung Kim <namhyung@kernel.org>
Cc: linux-perf-users@vger.kernel.org, acme@kernel.org,
 tim.c.chen@linux.intel.com, Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@redhat.com>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
 "Liang, Kan" <kan.liang@linux.intel.com>,
 Yicong Yang <yangyicong@hisilicon.com>, linux-kernel@vger.kernel.org
References: <20241025090307.59127-1-james.clark@linaro.org>
 <20241025090307.59127-3-james.clark@linaro.org> <ZyGA9cjrtbE_eWik@google.com>
 <CAP-5=fW=DfWK9qvrtxp7z+N7aELar2xMts_=twUjWbfEQ_9vHg@mail.gmail.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <CAP-5=fW=DfWK9qvrtxp7z+N7aELar2xMts_=twUjWbfEQ_9vHg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 30/10/2024 2:45 am, Ian Rogers wrote:
> On Tue, Oct 29, 2024 at 5:42 PM Namhyung Kim <namhyung@kernel.org> wrote:
>>
>> Hello,
>>
>> On Fri, Oct 25, 2024 at 10:03:05AM +0100, James Clark wrote:
>>> We decided to hide NULL metric units rather than showing it as "(null)",
>>> but on hybrid systems if the process doesn't hit a PMU you get an empty
>>> string metric unit instead. To make it consistent also remove empty
>>> strings.
>>>
>>> Note that metric-threshold is already hidden in this case without this
>>> change.
>>>
>>> Where a process only runs on cpu_core and never hits cpu_atom:
>>> Before:
>>>   $ perf stat -j -- true
>>>   ...
>>>   {"counter-value" : "<not counted>", "unit" : "", "event" : "cpu_atom/branch-misses/", "event-runtime" : 0, "pcnt-running" : 0.00, "metric-value" : "0.000000", "metric-unit" : ""}
>>>   {"counter-value" : "6326.000000", "unit" : "", "event" : "cpu_core/branch-misses/", "event-runtime" : 293786, "pcnt-running" : 100.00, "metric-value" : "3.553394", "metric-unit" : "of all branches", "metric-threshold" : "good"}
>>>   ...
>>
>> I guess you're talking about "metric-unit", not plain "unit", right?
>> Then please update the subject line to reduce the config.
>>

Yep I'll update it.

>> Ian, can you please review?
> 
> It'd be nice to see the stack trace for when metric-unit is "" as I'm
> not seeing the logic in stat-shadow.c. If we know the caller than it
> seems logical the unit can be passed as NULL rather than "".
> 
> Thanks,
> Ian
> 


Here's the stack:

print_metric_json() (stat-display.c:516)
printout() (stat-display.c:912)
print_counter_aggrdata() (stat-display.c:1110)
print_counter() (stat-display.c:1224)
evlist__print_counters() (stat-display.c:1734)
print_counters() (builtin-stat.c:1016)
cmd_stat() (builtin-stat.c:2872)
run_builtin() (perf/perf.c:351)
handle_internal_command() (perf.c:404)
run_argv() (perf.c:448)
main() (perf.c:560)

The empty string is from printout():

   pm(config, os, METRIC_THRESHOLD_UNKNOWN, /*format=*/NULL, /*unit=*/"",
      /*val=*/0);

Changing it to NULL seems to work, so is probably a bit neater. I can do 
that if you think that makes sense?

There's another one for --metric-only that I didn't run into, but it 
could also make sense to change:

   if (config->metric_only) {
     pm(config, os, METRIC_THRESHOLD_UNKNOWN, "", "", 0);

>> Thanks,
>> Namhyung
>>
>>>
>>> After:
>>>   ...
>>>   {"counter-value" : "<not counted>", "unit" : "", "event" : "cpu_atom/branch-misses/", "event-runtime" : 0, "pcnt-running" : 0.00}
>>>   {"counter-value" : "5778.000000", "unit" : "", "event" : "cpu_core/branch-misses/", "event-runtime" : 282240, "pcnt-running" : 100.00, "metric-value" : "3.226797", "metric-unit" : "of all branches", "metric-threshold" : "good"}
>>>   ...
>>>
>>> Signed-off-by: James Clark <james.clark@linaro.org>
>>> ---
>>>   tools/perf/util/stat-display.c | 2 +-
>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-display.c
>>> index a5d72f4a515c..9b7fd985a42a 100644
>>> --- a/tools/perf/util/stat-display.c
>>> +++ b/tools/perf/util/stat-display.c
>>> @@ -506,7 +506,7 @@ static void print_metric_json(struct perf_stat_config *config __maybe_unused,
>>>        struct outstate *os = ctx;
>>>        FILE *out = os->fh;
>>>
>>> -     if (unit) {
>>> +     if (unit && strlen(unit)) {
>>>                json_out(os, "\"metric-value\" : \"%f\", \"metric-unit\" : \"%s\"", val, unit);
>>>                if (thresh != METRIC_THRESHOLD_UNKNOWN) {
>>>                        json_out(os, "\"metric-threshold\" : \"%s\"",
>>> --
>>> 2.34.1
>>>


