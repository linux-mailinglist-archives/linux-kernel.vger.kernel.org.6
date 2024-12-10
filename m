Return-Path: <linux-kernel+bounces-439669-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB7C89EB267
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 14:58:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 162052895AD
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 13:58:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 364151C07E0;
	Tue, 10 Dec 2024 13:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="q6KBjPrD"
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A6821AAE23
	for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 13:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733838986; cv=none; b=GUFfp3t+RAe6ZlLy4JBQorfIIFg3/nnu3k39SQcCleetkEvX6/mnLy3L3/K/sRYyfBmOaRfLfqIlVEQBS+IWcNjf0c0KleLQ1QnZeWXAfesYSrjLzjaxy1tnLLkJk07SGkIMYuPyTQjaFSLauCWCAHUyjxm54bvcHjNQ/misKRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733838986; c=relaxed/simple;
	bh=Gs20wGactG1ECvoaE4EJaMGElPRumqsvpCOquN19Bac=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=S2EWb95sgbBQpeNtOS70l+4bGjyMbX4Na4wSqSxr+/OHdHsutaMRN7TVAYvTuT0jjBPNPlGPQMXp186eN5GzFzH7llISxKlB7pJow578tL9lN7DLGPHQHMWoXws/DGrCpToGlq7uHXddyORJkuSQevHN32qVBufa4Y/TR9QNaVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=q6KBjPrD; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-385ddcfc97bso4366756f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 05:56:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733838983; x=1734443783; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Z0i+hAoQS9TCydO8kZVE5j5VesNvi4DrqNm2MX/hNhg=;
        b=q6KBjPrDbVTPNyiCftNu16ixmBKRJhOysQ5ILLAZIO0N5Yp6Z4uFvULm8cuKYbgTG7
         ngyifmuEY5+XHlpKb3xBpLxzL5jtK2UiQP1az2XNLqCINWe+dkCNG7jNCXpdu54feRY4
         r3GCRnNvCkN5ldQaDjwYfjIJyMl6Yr0rURHEhqjlVlqbk9qxPAQB/NG+sQck1ABCAKd8
         gpY6EuUPOesV8zsINCq4lWUgG8oAXyAMzTPTl+0HKMdR7oFntj+3Mh1TU59bP1GUEEGf
         lr5cWypbx/TnygwYeu7X/vvBEzwuhjBEKWV2KatjizBJHScL1iolr6GlGoDL/OvcLsJ4
         7q6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733838983; x=1734443783;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Z0i+hAoQS9TCydO8kZVE5j5VesNvi4DrqNm2MX/hNhg=;
        b=n8NYSAbEZ6AspsYxIZde4eYpuF/0FtZOimwe7wXZt85ZthR1pfjdJjQocEcH/Fksca
         JWKbGz/nc7kXWj+3V+gLZPl0h18SlMjiSz0AB/GZisrgEbommERSAa98wFAMWG84UbHU
         qdPi15fI6w8y2PFjIFgYDgDlcu4oTYCbKHAg/sE6gcxekXWQ38wRytZ7QZ71nlPHWj5q
         BmaQZM7F92gz2JjmQ4gdnXV/0Ihskbp9J7IwKgXtnk1+VWOpKmz+nxZel1U07s26OaQy
         ZRUMDA1MlUNTDWN6ujoP1i4/+kpKj7ceEHAkgPv3MHWvTv4PaJ2uiEO2l98AJJMoTvwU
         P/bA==
X-Forwarded-Encrypted: i=1; AJvYcCU126+Uys+0/CX21vlLajunqlCKF7XGVTKS/2/1CCNodsCbhICnQ4jdD6LY22eQCAsfnmYiCWmSuA4q+SM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzrsH2wHNxuGm6bpsBPvtGojaIpAwHFhkFuHM2f+dh5yj+ac7nZ
	ZRFfq9FM55J3frewIaYKP9bQiyTBiBCWnXvK+cGg459sun2Io5jNPGcqOvrzrT4=
X-Gm-Gg: ASbGnct9/Y5K0CYKUXiyM+aMQkP0iRdl3CRtesZj0dy4mqHIG1QxoFpjXOTtUzW2ruC
	VZ7B1vQsQXWggdzdJEX6mESKN9wVzTwgxwixHjIkFWJv1rSFH/fESRri15t6R398S2krPALhQyg
	pPlBQeHRD7LaxmsGVZ2Puvi0NoGIGVTJiTEdO5u6iKnOxesk2gVbLO6yJ+ZDANJpxXTGmNGo6wW
	b/+ECOIk6ZHem9cl/irw0DQMrsceEDICe0VUM2muYF7ddWubloJ22v/ZbdNCywzrA==
X-Google-Smtp-Source: AGHT+IGmUPHzjr07VZhPYwJmhKlWKPLGqMuBNMkgPpOlnTg4cPB0fvEWfFbcPuEWGrnzVuTqHBtHEw==
X-Received: by 2002:a05:6000:1f85:b0:382:5141:f631 with SMTP id ffacd0b85a97d-3862b36c07amr13529906f8f.29.1733838982730;
        Tue, 10 Dec 2024 05:56:22 -0800 (PST)
Received: from [192.168.68.163] ([209.198.129.130])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434da0980ddsm190534205e9.0.2024.12.10.05.56.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Dec 2024 05:56:22 -0800 (PST)
Message-ID: <eb8301ec-50af-4414-89e7-5d49585bda47@linaro.org>
Date: Tue, 10 Dec 2024 13:56:21 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] libperf: evlist: Fix --cpu argument on hybrid
 platform
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>
Cc: linux-perf-users@vger.kernel.org, irogers@google.com,
 thomas.falcon@intel.com, Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@redhat.com>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
 "Liang, Kan" <kan.liang@linux.intel.com>, linux-kernel@vger.kernel.org
References: <20241114160450.295844-1-james.clark@linaro.org>
 <20241114160450.295844-2-james.clark@linaro.org> <Z1hHc-Q-TKgagORu@x1>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <Z1hHc-Q-TKgagORu@x1>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 10/12/2024 1:51 pm, Arnaldo Carvalho de Melo wrote:
> On Thu, Nov 14, 2024 at 04:04:48PM +0000, James Clark wrote:
>> Since the linked fixes: commit, specifying a CPU on hybrid platforms
>> results in an error because Perf tries to open an extended type event
>> on "any" CPU which isn't valid. Extended type events can only be opened
>> on CPUs that match the type.
>   
>> Before (working):
>   
>>    $ perf record --cpu 1 -- true
>>    [ perf record: Woken up 1 times to write data ]
>>    [ perf record: Captured and wrote 2.385 MB perf.data (7 samples) ]
>   
>> After (not working):
>   
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
>>
>> Fix it by deleting evsels with empty CPU maps in the specific case where
>> user requested CPU maps are evaluated.
> 
> 
> Namhyung, I think this should go via perf-tools,
> 
> Before, on an hybrid Intel processor:
> 
>    ⬢ [acme@toolbox perf-tools]$ grep -m1 'model name' /proc/cpuinfo
>    model name	: 13th Gen Intel(R) Core(TM) i7-1365U
>    ⬢ [acme@toolbox perf-tools]$
> 
>    root@x1:~# perf record -C 1 -- true
>    WARNING: A requested CPU in '1' is not supported by PMU 'cpu_atom' (CPUs 4-11) for event 'cycles:P'
>    Error:
>    The sys_perf_event_open() syscall returned with 22 (Invalid argument) for event (cpu_atom/cycles/P).
>    "dmesg | grep -i perf" may provide additional information.
>    root@x1:~#
> 
> After the patch:
> 
>    root@x1:~# perf record -C 1 -- true
>    WARNING: A requested CPU in '1' is not supported by PMU 'cpu_atom' (CPUs 4-11) for event 'cycles:P'
>    [ perf record: Woken up 1 times to write data ]
>    [ perf record: Captured and wrote 1.369 MB perf.data (8 samples) ]
>    root@x1:~#
>    root@x1:~# perf evlist -v
>    cpu_core/cycles/P: type: 0 (PERF_TYPE_HARDWARE), size: 136, config: 0x400000000, { sample_period, sample_freq }: 4000, sample_type: IP|TID|TIME|CPU|PERIOD|IDENTIFIER, read_format: ID|LOST, disabled: 1, freq: 1, precise_ip: 3, sample_id_all: 1
>    dummy:u: type: 1 (software), size: 136, config: 0x9 (PERF_COUNT_SW_DUMMY), { sample_period, sample_freq }: 1, sample_type: IP|TID|TIME|CPU|IDENTIFIER, read_format: ID|LOST, exclude_kernel: 1, exclude_hv: 1, mmap: 1, comm: 1, task: 1, sample_id_all: 1, exclude_guest: 1, mmap2: 1, comm_exec: 1, ksymbol: 1, bpf_event: 1
>    root@x1:~#
> 
> All on CPU 1:
> 
>    root@x1:~# perf report -D | grep PERF_RECORD_SAMPLE
>    1 1809541166457609 0x15e410 [0x38]: PERF_RECORD_SAMPLE(IP, 0x4001): 719180/719180: 0xffffffff9b1ce418 period: 1 addr: 0
>    1 1809541166470019 0x15e448 [0x38]: PERF_RECORD_SAMPLE(IP, 0x4001): 719180/719180: 0xffffffff9a0206b1 period: 1 addr: 0
>    1 1809541166475543 0x15e480 [0x38]: PERF_RECORD_SAMPLE(IP, 0x4001): 719180/719180: 0xffffffff9a0a9158 period: 5 addr: 0
>    1 1809541166478316 0x15e4b8 [0x38]: PERF_RECORD_SAMPLE(IP, 0x4001): 719180/719180: 0xffffffff9a0a9158 period: 53 addr: 0
>    1 1809541166480879 0x15e4f0 [0x38]: PERF_RECORD_SAMPLE(IP, 0x4001): 719180/719180: 0xffffffff9a0a9158 period: 667 addr: 0
>    1 1809541166483895 0x15e528 [0x38]: PERF_RECORD_SAMPLE(IP, 0x4001): 719180/719180: 0xffffffff9b1bcbcc period: 8537 addr: 0
>    1 1809541166489116 0x15e560 [0x38]: PERF_RECORD_SAMPLE(IP, 0x4001): 719180/719180: 0xffffffff9a009b3b period: 98429 addr: 0
>    1 1809541168375508 0x15e620 [0x38]: PERF_RECORD_SAMPLE(IP, 0x4001): 0/0: 0xffffffff9b0e2a34 period: 732596 addr: 0
>    root@x1:~#
> 
> Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> 
> James, the second patch isn't applying to perf-tools/perf-tools.
> 
> - Arnaldo
>   

The second one applies on 
https://lore.kernel.org/linux-perf-users/20241113011956.402096-1-irogers@google.com/T/#m2a3587fb83e6ab2d970bae25982ae9d6c8d9e5cd 
because that also does an evlist__remove() which gets fixed up. But the 
first one is ok to go in on its own.

>> Fixes: 251aa040244a ("perf parse-events: Wildcard most "numeric" events")
>> Reviewed-by: Ian Rogers <irogers@google.com>
>> Tested-by: Thomas Falcon <thomas.falcon@intel.com>
>> Signed-off-by: James Clark <james.clark@linaro.org>
>> ---
>>   tools/lib/perf/evlist.c | 18 ++++++++++++++++--
>>   1 file changed, 16 insertions(+), 2 deletions(-)
>>
>> diff --git a/tools/lib/perf/evlist.c b/tools/lib/perf/evlist.c
>> index c6d67fc9e57e..83c43dc13313 100644
>> --- a/tools/lib/perf/evlist.c
>> +++ b/tools/lib/perf/evlist.c
>> @@ -47,6 +47,20 @@ static void __perf_evlist__propagate_maps(struct perf_evlist *evlist,
>>   		 */
>>   		perf_cpu_map__put(evsel->cpus);
>>   		evsel->cpus = perf_cpu_map__intersect(evlist->user_requested_cpus, evsel->own_cpus);
>> +
>> +		/*
>> +		 * Empty cpu lists would eventually get opened as "any" so remove
>> +		 * genuinely empty ones before they're opened in the wrong place.
>> +		 */
>> +		if (perf_cpu_map__is_empty(evsel->cpus)) {
>> +			struct perf_evsel *next = perf_evlist__next(evlist, evsel);
>> +
>> +			perf_evlist__remove(evlist, evsel);
>> +			/* Keep idx contiguous */
>> +			if (next)
>> +				list_for_each_entry_from(next, &evlist->entries, node)
>> +					next->idx--;
>> +		}
>>   	} else if (!evsel->own_cpus || evlist->has_user_cpus ||
>>   		(!evsel->requires_cpu && perf_cpu_map__has_any_cpu(evlist->user_requested_cpus))) {
>>   		/*
>> @@ -80,11 +94,11 @@ static void __perf_evlist__propagate_maps(struct perf_evlist *evlist,
>>   
>>   static void perf_evlist__propagate_maps(struct perf_evlist *evlist)
>>   {
>> -	struct perf_evsel *evsel;
>> +	struct perf_evsel *evsel, *n;
>>   
>>   	evlist->needs_map_propagation = true;
>>   
>> -	perf_evlist__for_each_evsel(evlist, evsel)
>> +	list_for_each_entry_safe(evsel, n, &evlist->entries, node)
>>   		__perf_evlist__propagate_maps(evlist, evsel);
>>   }
>>   
>> -- 
>> 2.34.1


