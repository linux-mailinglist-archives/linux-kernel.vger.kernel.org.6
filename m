Return-Path: <linux-kernel+bounces-302938-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F1961960549
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 11:13:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 70B421F222E8
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 09:13:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0305B19D093;
	Tue, 27 Aug 2024 09:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="x3wA0W5f"
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33C0D19CD13
	for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 09:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724750007; cv=none; b=W7AjyOUTMHv1jUNYTCpsZObcvVnsHsLnJAYx35oYlDC45xfQJWnyva5twEfIguiDY+LSSk+Hc+1p7QWkw6QOjUwtH3f26ybm+bzLA693tjXjLKJNwECJ+YtVnj3He9pttnxNxQUzjoYasSsU9PdiRmKeLfjjgojGM2JqSWt1CoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724750007; c=relaxed/simple;
	bh=V90sN7VBxnn8Ka2+52DS2oyXgNuXtvZg40rY21lxveA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HSDhCVQQWuqWwpwkcpCcvLRue+P7kCCI8BVtz2sdBHYhOO+0T+7bvtVf6Ixa1/p+2QoxOB1ARtJyURMjeJ8G5bNYsl6Svn2fRKMAd6xYPCi84H7O42Lp28QpKTwfo+zUVnR1GjZccwS4JfUyUraOECzydnjHQiJJZ6s9y9KyoPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=x3wA0W5f; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3718eaf4046so3843547f8f.3
        for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 02:13:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724750003; x=1725354803; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MkOblmPhkLIe6oEykDBHRoLpfI5FhOdoxnXEnkmHpFs=;
        b=x3wA0W5fwAJMZ1ennsL+jpLhUrZnH3/2xMa+KeLmsvMLfWN55GmsUXoQ4NpMFGlfYy
         UHtOucwYkIlisZb7jThzduXEZjU0N4GnPrS0g+JGl+YBFA1A0ch/pnyW3WBngkvbyH4+
         6mW/d6UKWLIHERqtKezf2FCo/ibEOzzQzLbD8konFARULVJehiJqbHLSquBRuRhOxGdi
         1f/L1nvOD6wL+pSAKxkcdlT2fMV7bf8Y6W651qbSCV+Ed8QBnRaZ3pDBBlitpOsT65Sv
         HuRnpvQmK8HxdfuKgFUAMg043im6dIsvS+/R7EpZl66ZtGWVoh60GvcclGOoOPBiF+CT
         r4aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724750003; x=1725354803;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MkOblmPhkLIe6oEykDBHRoLpfI5FhOdoxnXEnkmHpFs=;
        b=JUbheDq4zDTAqlb2vunCI/LJpdmWUH/WeSCD0JqesDIV1TQmbzeIcUk2wUTY9ph2ra
         ABofD7ylLahM/9HQG7p3WzpiB7zd0V/NbTM2nWQDPQc4mP0Qt8ueLBXxQ882N6sB9Unm
         oaDxVeXqfOPFwB/+KGCGQo9/aENdh86dogPBB4ZPLhwSHvG3gs2/aUz2RqtJ0xJHhnyX
         RDTD9WgGDhWMwNfsw/XEQeypbzaDi9knDeh7sxrT3zHlE85SjVEvEav4aqMmOlq2yy3W
         8s8RPm6IaXj0BEfHOGa2+KBkgZIazMrODUacLwVrlsZAsKRdQM4PLAecumbPwbYeqCK9
         28Jg==
X-Forwarded-Encrypted: i=1; AJvYcCVwkb6XLFttYvQMxebRiADmKJwQpfC8rjYwt9eWp/k/0PvW2AErFn+QUY2yXq/8se1qzDzoo70GybyHhoY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyS+PZQ+LF5OyBgK2wDnMri7LzoCpUU1UfJy+AMJvpafvzg+m4E
	YzD4v/Wapc0ggclmTLVj7fAfWfKuW2ybtYM9M6ZTya71WCrK24UM6idRfWvsFtg=
X-Google-Smtp-Source: AGHT+IELDbQ0YInZRqLz+AEkpiYsCf7f42uK8vcwLez7hBLrv03kT5qUnySR5SzQV+tSfEm/vuuEJg==
X-Received: by 2002:a05:6000:1b92:b0:371:79f0:2cfb with SMTP id ffacd0b85a97d-373118c8523mr8634246f8f.46.1724750003086;
        Tue, 27 Aug 2024 02:13:23 -0700 (PDT)
Received: from [192.168.1.3] ([89.47.253.130])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a86e594e809sm83491966b.219.2024.08.27.02.13.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Aug 2024 02:13:22 -0700 (PDT)
Message-ID: <b9ff0a13-7a77-4cb3-b8c0-e5fdf2d86e87@linaro.org>
Date: Tue, 27 Aug 2024 10:13:21 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/7] Event parsing fixes
To: "Liang, Kan" <kan.liang@linux.intel.com>, Ian Rogers <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org, John Garry <john.g.garry@oracle.com>,
 Will Deacon <will@kernel.org>, Mike Leach <mike.leach@linaro.org>,
 Leo Yan <leo.yan@linux.dev>, Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
 Weilin Wang <weilin.wang@intel.com>,
 Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
 Dominique Martinet <asmadeus@codewreck.org>,
 Yang Jihong <yangjihong@bytedance.com>,
 Colin Ian King <colin.i.king@gmail.com>, Andi Kleen <ak@linux.intel.com>,
 Ze Gao <zegao2021@gmail.com>, Jing Zhang <renyu.zj@linux.alibaba.com>,
 Sun Haiyong <sunhaiyong@loongson.cn>, Yicong Yang
 <yangyicong@hisilicon.com>, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20240822132506.1468090-1-james.clark@linaro.org>
 <db095820-58a7-4b40-a12a-04b2f82cf903@linux.intel.com>
 <CAP-5=fX632gBrCG6Z+oQGkk=daFcrGM605t_2H1Jo20sVwvtqQ@mail.gmail.com>
 <961ff6d6-a9b3-4329-9a22-6934ca152318@linux.intel.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <961ff6d6-a9b3-4329-9a22-6934ca152318@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 22/08/2024 4:18 pm, Liang, Kan wrote:
> 
> 
> On 2024-08-22 11:10 a.m., Ian Rogers wrote:
>> On Thu, Aug 22, 2024 at 7:32 AM Liang, Kan <kan.liang@linux.intel.com> wrote:
>>>
>>>
>>>
>>> On 2024-08-22 9:24 a.m., James Clark wrote:
>>>> I rebased this one and made some other fixes so that I could test it,
>>>> so I thought I'd repost it here in case it's helpful. I also added a
>>>> new test.
>>>>
>>>> But for the testing it all looks ok.
>>>>
>>>> There is one small difference where it now shows "stalled-cycles-..."
>>>> as <not supported> events, when before it just didn't show them at all when
>>>> they weren't supported:
>>>>
>>>>    $ perf stat -- true
>>>>
>>>>    Performance counter stats for 'true':
>>>>
>>>>                0.66 msec task-clock                       #    0.384 CPUs utilized
>>>>                   0      context-switches                 #    0.000 /sec
>>>>                   0      cpu-migrations                   #    0.000 /sec
>>>>                  52      page-faults                      #   78.999 K/sec
>>>>       <not counted>      cpu_atom/instructions/                                                  (0.00%)
>>>>             978,399      cpu_core/instructions/           #    1.02  insn per cycle
>>>>       <not counted>      cpu_atom/cycles/                                                        (0.00%)
>>>>             959,722      cpu_core/cycles/                 #    1.458 GHz
>>>>     <not supported>      cpu_atom/stalled-cycles-frontend/
>>>>     <not supported>      cpu_core/stalled-cycles-frontend/
>>>>
>>>
>>> Intel didn't support the events for a very long time. It would impact
>>> many existing generations and all future generations.
>>> The current method is to hide the non-exist events. The TopdownL1 is an
>>> example. If it doesn't exist in the json file, perf stat will not
>>> display it.
>>> I don't think it's a good idea to disclose non-exist events in the perf
>>> stat default.
>>>
>>> The <not supported> doesn't help here, since there could be many reasons
>>> that the perf tool fails to open a counter. It just provides a
>>> misleading message for an event that never existed.
>>
>> The list of "default" events, not metrics, similarly has "<not
>> supported>" in many configurations with "-dd" or "-ddd" on AMD. I'm
>> not sure the set of default events, at different detail levels, is
>> necessarily the best. The default events can also be a source of
>> multiplexing, for example, showing branch miss rate alongside topdown
>> metrics. Anyway, for the "<not supported>" we should probably be able
>> to tweak should_skip_zero_counter that is in stat-display.c and tag
>> these default events as "skippable".
> 
> The "skippable" should be fine as long as it's completely hidden.
> 
> BTW: The stalled-cycles-backend should be similar to the
> stalled-cycles-frontend, but it isn't shown in the example. Is the
> stalled-cycles-backend event missed?
> 
> Thanks,
> Kan

Sorry I should have made it clearer that I truncated the output just to 
focus on the <not supported> part. The full output is below and it does 
include stalled-cycles-backend.

I'll have a look at trying to hide the ones that don't exist, I think it 
will look cleaner. But at the same time what it says isn't incorrect, 
and it's not like we hide the lines from cores where the process didn't 
run, so it doesn't look out of place with the <not counted> ones.



   $ perf stat -- true

   Performance counter stats for 'true':

                0.42 msec task-clock                #    0.439 CPUs 
utilized
                   0      context-switches          #    0.000 /sec 

                   0      cpu-migrations            #    0.000 /sec 

                  53      page-faults               #  125.592 K/sec 

             978,160      cpu_atom/instructions/    #    0.91  insn per 
cycle
       <not counted>      cpu_core/instructions/                 (0.00%)
           1,070,525      cpu_atom/cycles/          #    2.537 GHz 

       <not counted>      cpu_core/cycles/                       (0.00%)
     <not supported>      cpu_atom/stalled-cycles-frontend/
     <not supported>      cpu_core/stalled-cycles-frontend/
     <not supported>      cpu_atom/stalled-cycles-backend/
     <not supported>      cpu_core/stalled-cycles-backend/
             175,814      cpu_atom/branches/        #  416.620 M/sec 

       <not counted>      cpu_core/branches/                     (0.00%)
               6,851      cpu_atom/branch-misses/   #    3.90% of all 
branches
       <not counted>      cpu_core/branch-misses/                (0.00%)
               TopdownL1 (cpu_atom)     #     17.4 % 
tma_bad_speculation
                                        #     21.8 %  tma_retiring 

               TopdownL1 (cpu_atom)     #     27.5 %  tma_backend_bound 

                                        #     33.3 %  tma_frontend_bound 


         0.000960792 seconds time elapsed

         0.000000000 seconds user
         0.000471000 seconds sys

