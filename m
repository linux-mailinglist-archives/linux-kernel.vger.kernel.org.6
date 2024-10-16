Return-Path: <linux-kernel+bounces-367598-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6C5B9A0442
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 10:29:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5AF7DB27701
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 08:29:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1527C1D934B;
	Wed, 16 Oct 2024 08:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kkpMGGlA"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DAE51D8E12
	for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 08:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729067361; cv=none; b=LarjcehEPknzWdRTC3SmVUGRzLmRApMVsWP45jtnJ27VajYTscH3M+Yu3r4Oz7OdVEfJbRvCkF26Itb36G5GmITNqUmxNJmq1YF3OPzYvlT6YluilMwhhrOcs0S29VVNJqtz2CIESwxfMcCKrySnX04WyYt/d8ia18DcSh0IxNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729067361; c=relaxed/simple;
	bh=gRZO8HZpS/Zzwkh1RQTDbb6sKIvOApvjfYVNUIthQ+0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=e6tYjaTbfPwkdodxUumunlo8OR5J0VL0rMdUCI6dj3JbZG5x40wX+Jymrj8VU6198uap2c2++SJ+6yuve8N0dFRYGmhRHBqNoVj5Nqt08mju2cGLZhWkdN5vpUDC7/63RGb3dvcv60FnOnFFgEFtZC76uXYTUnB0bJjhZDFnyGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=kkpMGGlA; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4314b316495so9020435e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 01:29:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729067358; x=1729672158; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6iqfBuczay4ElwQktBC/MRXYiJhYxD/GwTaPrSn+Is0=;
        b=kkpMGGlAnMbI6AkbHkF+Qqbm+Yt2SgZZQhHeI+QhMhEF68ChIpMjvChER2wtalwOUD
         Nl8iAxfdA+gdP5+sPaC7nkYMLckiZWvJPmc7eR7qgAUdj2TN4x/RBGAsPndAk4CQfk+b
         Qv/y9zss8sN7OD/AxsnWV9dHM36kDKmC6XiNVFVoVdxEXgfandQcRa87gyED80JWNQDX
         RszOdDDLo7d0n6cSTCsz+0JYzf9NF2hEesVBjd+uD0Y2JDE478xuCDScuN0Nugpa/KIT
         LfGIqaUo9A0SWR09HaeIArJvESk/yvrADLzDm8f1FBzYdQKNP3X7pIWOR3rNQ4RjeoUe
         DcYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729067358; x=1729672158;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6iqfBuczay4ElwQktBC/MRXYiJhYxD/GwTaPrSn+Is0=;
        b=evlF5zsuBla7WyZ2Zt1ec8TamsJtBU0T/tRLMREVd3VtEqq2i+bMw7Je7YSCwsDCTL
         sIPcx5YwUIQqK4tU8218Ex2/UgsGPj6ZzbfScIUTTYqjKDWKDv1L2BcCxhaXBdsibY7E
         vk7vvUsEcDd3V3Dc7OLKvQAPS6afO86cdyA9wBPd1b88+xmqNvdItw1tfELWZV+E2OgS
         ys3CMxODktKsQ7Z9VzGxV2fzxWnypg2ld/hYnCjIFwsuwwkKb721D9Iujh3ZSRkt8wqN
         n6eMxnD0UqARyNmpJZmGv2S0anIQG8c0D8L4bCK3bIk27VdXId42zkmHnJNVy8yaKTvP
         arSg==
X-Forwarded-Encrypted: i=1; AJvYcCVLFeFcTy0/gUfLKdcBprCh6PsHoTXL05dHeExySzrFrF++kKNyEOPtLv5FrJZ7JGSBe0Dk0uJOpvAdVgA=@vger.kernel.org
X-Gm-Message-State: AOJu0YycIBzIpz0br6nIv3xJPl5wu5Y41sk61bldXdTpF/rRH2Q06ohp
	+dYc6SXD9AH9WpEyhkptl/80QFaVy3PXdqPvt7Oeyguco8iWBiHTX0jxG45eb1w=
X-Google-Smtp-Source: AGHT+IFLTR/9sDkPujYWEOmpgOe7TTooUlrji54cUOBo4zxv4bz8Vx9Xi/pwm79C2hqLZjs8UPCD0Q==
X-Received: by 2002:a5d:69ca:0:b0:37d:4706:f728 with SMTP id ffacd0b85a97d-37d552cbc7dmr11601322f8f.50.1729067357763;
        Wed, 16 Oct 2024 01:29:17 -0700 (PDT)
Received: from [192.168.1.3] ([89.47.253.130])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d7fa8778csm3678998f8f.25.2024.10.16.01.29.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Oct 2024 01:29:17 -0700 (PDT)
Message-ID: <d9a4bebe-dde1-438f-bcf7-70b7a5e21848@linaro.org>
Date: Wed, 16 Oct 2024 09:29:16 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 1/1] libperf: evlist: Fix --cpu argument on hybrid
 platform
To: Ian Rogers <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org, acme@kernel.org, namhyung@kernel.org,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
 "Liang, Kan" <kan.liang@linux.intel.com>, linux-kernel@vger.kernel.org
References: <20241015145416.583690-1-james.clark@linaro.org>
 <20241015145416.583690-2-james.clark@linaro.org>
 <CAP-5=fW7aERe3KHtAoYX9UWsVWrhU95RcCgabgP+DNHi1whjsQ@mail.gmail.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <CAP-5=fW7aERe3KHtAoYX9UWsVWrhU95RcCgabgP+DNHi1whjsQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 15/10/2024 4:14 pm, Ian Rogers wrote:
> On Tue, Oct 15, 2024 at 7:54 AM James Clark <james.clark@linaro.org> wrote:
>>
>> Since the linked fixes: commit, specifying a CPU on hybrid platforms
>> results in an error because Perf tries to open an extended type event
>> on "any" CPU which isn't valid. Extended type events can only be opened
>> on CPUs that match the type.
>>
>> Before (working):
>>
>>    $ perf record --cpu 1 -- true
>>    [ perf record: Woken up 1 times to write data ]
>>    [ perf record: Captured and wrote 2.385 MB perf.data (7 samples) ]
>>
>> After (not working):
>>
>>    $ perf record -C 1 -- true
>>    WARNING: A requested CPU in '1' is not supported by PMU 'cpu_atom' (CPUs 16-27) for event 'cycles:P'
>>    Error:
>>    The sys_perf_event_open() syscall returned with 22 (Invalid argument) for event (cpu_atom/cycles:P/).
>>    /bin/dmesg | grep -i perf may provide additional information.
>>
>> (Ignore the warning message, that's expected and not particularly
>> relevant to this issue).
>>
>> This is because perf_cpu_map__intersect() of the user specified CPU (1)
>> and one of the PMU's CPUs (16-27) correctly results in an empty (NULL)
>> CPU map. However for the purposes of opening an event, libperf converts
>> empty CPU maps into an any CPU (-1) which the kernel rejects.
> 
> Ugh. The cpumap API tries its best to confuse NULL == empty but empty
> can give you dummy, dummy is also known as 'any' or -1, 'any' sounds a
> lot like 'all' but sometimes 'all' is only online CPUs. I tried to
> tidy up the naming a while ago, but there is still a mess.
> 

I don't know if you think this is a good opportunity for me to have a go 
at finishing separating those? Or is it a dead end?

>> Fix it by deleting evsels with empty CPU maps in the specific case where
>> user requested CPU maps are evaluated.
> 
> If we delete evsels than the indices can be broken for certain things.
> I'm guessing asan testing is clean but the large number of side data
> structures that are indexed by things in another data structure makes
> the whole code base brittle and I am nervous around this change.
> 
>> Fixes: 251aa040244a ("perf parse-events: Wildcard most "numeric" events")
>> Signed-off-by: James Clark <james.clark@linaro.org>
> 
> Reviewed-by: Ian Rogers <irogers@google.com>
> 
> Thanks,
> Ian
> 

Ok if we're not completely opposed to doing it this way I will dig a bit 
more and double check everything is working.

>> ---
>>   tools/lib/perf/evlist.c | 11 +++++++++--
>>   1 file changed, 9 insertions(+), 2 deletions(-)
>>
>> diff --git a/tools/lib/perf/evlist.c b/tools/lib/perf/evlist.c
>> index c6d67fc9e57e..8fae9a157a91 100644
>> --- a/tools/lib/perf/evlist.c
>> +++ b/tools/lib/perf/evlist.c
>> @@ -47,6 +47,13 @@ static void __perf_evlist__propagate_maps(struct perf_evlist *evlist,
>>                   */
>>                  perf_cpu_map__put(evsel->cpus);
>>                  evsel->cpus = perf_cpu_map__intersect(evlist->user_requested_cpus, evsel->own_cpus);
>> +
>> +               /*
>> +                * Empty cpu lists would eventually get opened as "any" so remove
>> +                * genuinely empty ones before they're opened in the wrong place.
>> +                */
>> +               if (perf_cpu_map__is_empty(evsel->cpus))
>> +                       perf_evlist__remove(evlist, evsel);
>>          } else if (!evsel->own_cpus || evlist->has_user_cpus ||
>>                  (!evsel->requires_cpu && perf_cpu_map__has_any_cpu(evlist->user_requested_cpus))) {
>>                  /*
>> @@ -80,11 +87,11 @@ static void __perf_evlist__propagate_maps(struct perf_evlist *evlist,
>>
>>   static void perf_evlist__propagate_maps(struct perf_evlist *evlist)
>>   {
>> -       struct perf_evsel *evsel;
>> +       struct perf_evsel *evsel, *n;
>>
>>          evlist->needs_map_propagation = true;
>>
>> -       perf_evlist__for_each_evsel(evlist, evsel)
>> +       list_for_each_entry_safe(evsel, n, &evlist->entries, node)
>>                  __perf_evlist__propagate_maps(evlist, evsel);
>>   }
>>
>> --
>> 2.34.1
>>


