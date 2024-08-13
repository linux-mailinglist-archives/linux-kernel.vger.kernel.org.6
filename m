Return-Path: <linux-kernel+bounces-285000-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C5E69507E8
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 16:39:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A4497B26648
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 14:39:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29B4219E808;
	Tue, 13 Aug 2024 14:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="W+YqRtnG"
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD62B19D07D
	for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 14:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723559938; cv=none; b=gVmHFgLS/2wXHlYQCHBE7zCJ2lw86/uuq9rpEVqN65YE5zetJU3DVX9UYePVL90AZWHfhL/qFZU/XDsYFrtAlytj19XF5azMB+embqkA26IJ3J0EJJgwuSsgow6PawdhM7T23xMQQ/R77XJal/eyvignLBFizah7KE2xR+ycYYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723559938; c=relaxed/simple;
	bh=B3hf41SbGEXb5U+irpYfxacjxMaRj3pkNpkzqprh8jM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WVEM491KAcOEzrXhzEmgux7e2fuIvGUOPI5xHRskLmucgl3wkz2raNZUqiqs5dT6UYHSTS6Yy50eclYWUc0b6NvHCjuBZ1VmurLwwkx6LfRKoVKqKSHc41eDsh9GZ8vv671yG9FS0CL2t8gzZ1AaZnjNZpXHAJTOBXmYTqRuVpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=W+YqRtnG; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3685a5e7d3cso3435616f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 07:38:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1723559935; x=1724164735; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UtQ1YB4RrIk11ETTD2r10cRbUnQqCHQoAwSrZok6NMo=;
        b=W+YqRtnGAOwa+F9gD65LjQ3mD05ryxQkrNYfyAAj3m1OG+Ytx9gK15+tAWU+uDvEZ2
         Rva79BcVTMA5oVaPhZqa3OBLpPbNWm2BM0RdzJvb0YNMwy6jbyX+SF2TNvCSXifmIkYP
         FDmrWW12eywYn5j04ai9vnXNl+MPp3xZRdC6jfgWr3bwdghUu6/GxLBhnkjSN0g/EBWa
         g01RoFJZxTHD6FSvTSZwljdN3JwtoeSfbhj/TyzOCd0Xt86C7z1DQdscfaFGHLY5siqi
         3jOeafbu5u8HGikW+Ds5oH4lczA5z2EKozKePbkH8LlvP6HPQ8EWVue3Pds4VlY2PdF3
         nvbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723559935; x=1724164735;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UtQ1YB4RrIk11ETTD2r10cRbUnQqCHQoAwSrZok6NMo=;
        b=r+VYQQ/CjlYW7lgweT7UUx6Je/LJov9VIYUIFExEhk296kxw8InlOiJqmz6A2bbApi
         94QyIldvqkH4J9lYX35gH0OxL+zEL6Y9wkLYO1HhY1Aa6+fLWYip6lRW50h6YiQXuDL4
         1zWrSnDnnWh7yXUEE+OLIIEj+OkBstjtGXdY0WeePnRZnbE78dvCizP4dR1PliWJLkO6
         daojBeEr+IrwzISNXuA9kPyAVugsatWlbl+uKw8K3ZfwmL4nMjm62aURT3My0L/ENXgK
         jJFWR7J3f3xzO7Mnvzo3Eurv2KicXJlMrq9uL7CuNzlAyjO65fdZhwKwrX7FdP87KFWO
         0RxA==
X-Forwarded-Encrypted: i=1; AJvYcCVefQGxc7dQJ02PpSECvyNZi28bZeBJzGKm1oscKGxTSfyXVVNwoMvN45ISTnhZ9o2jiTxL/zbcimi6QvwtDwmJqpCwZ/2r7qjeEJCk
X-Gm-Message-State: AOJu0YxC9Ba6iOzaj47to5KiXX1RX59UMJXYCiX4gsiluJ2Pi26Ai+6W
	rInsMRtR5A9nMJIL3PBZpGZJgZl3lSjR/CFQHnvfUk1vjOHYz3kNM7lyiRRPsW0=
X-Google-Smtp-Source: AGHT+IGZ3q4qbGnDy3Ugzxb9kudMaZUjN4anbfPXoXoEcqrmhBSoqtwtLTteBZDVMdUtj+hl9W7U2w==
X-Received: by 2002:a5d:40cc:0:b0:367:947a:a491 with SMTP id ffacd0b85a97d-3716cd028b6mr2751743f8f.26.1723559935045;
        Tue, 13 Aug 2024 07:38:55 -0700 (PDT)
Received: from [192.168.1.3] ([89.47.253.130])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36e4f0a7111sm10604674f8f.117.2024.08.13.07.38.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Aug 2024 07:38:54 -0700 (PDT)
Message-ID: <76ee9150-36fa-4dfc-ba9f-8a10df580c92@linaro.org>
Date: Tue, 13 Aug 2024 15:38:53 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/7] perf stat: Initialize instead of overwriting clock
 event
To: Ian Rogers <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org, John Garry <john.g.garry@oracle.com>,
 Will Deacon <will@kernel.org>, Mike Leach <mike.leach@linaro.org>,
 Leo Yan <leo.yan@linux.dev>, Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
 "Liang, Kan" <kan.liang@linux.intel.com>,
 Yang Jihong <yangjihong1@huawei.com>, Ze Gao <zegao2021@gmail.com>,
 Dominique Martinet <asmadeus@codewreck.org>, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
References: <20240813132323.98728-1-james.clark@linaro.org>
 <20240813132323.98728-2-james.clark@linaro.org>
 <CAP-5=fX-m3mhi0sGsGo9biWmFV_U=35Tp7h9X0reg3zHMEsy_Q@mail.gmail.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <CAP-5=fX-m3mhi0sGsGo9biWmFV_U=35Tp7h9X0reg3zHMEsy_Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 13/08/2024 3:28 pm, Ian Rogers wrote:
> On Tue, Aug 13, 2024 at 6:24 AM James Clark <james.clark@linaro.org> wrote:
>>
>> This overwrite relies on the clock event remaining at index 0 and is
>> quite a way down from where the array is initialized, making it easy to
>> miss. Just initialize it with the correct clock event to begin with.
>>
>> Signed-off-by: James Clark <james.clark@linaro.org>
>> ---
>>   tools/perf/builtin-stat.c | 7 +++----
>>   1 file changed, 3 insertions(+), 4 deletions(-)
>>
>> diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
>> index 1f92445f7480..a65f58f8783f 100644
>> --- a/tools/perf/builtin-stat.c
>> +++ b/tools/perf/builtin-stat.c
>> @@ -1817,7 +1817,9 @@ static int add_default_attributes(void)
>>   {
>>          struct perf_event_attr default_attrs0[] = {
>>
>> -  { .type = PERF_TYPE_SOFTWARE, .config = PERF_COUNT_SW_TASK_CLOCK             },
>> +  { .type = PERF_TYPE_SOFTWARE, .config = target__has_cpu(&target) ?
>> +                                               PERF_COUNT_SW_CPU_CLOCK :
>> +                                               PERF_COUNT_SW_TASK_CLOCK        },
> 
> Hand crafting perf_event_attr when we have an event name to
> perf_event_atttr parser doesn't make sense. Doing things this way
> means we need to duplicate logic between event parsing and these
> default configurations. The default configurations are also using
> legacy events which of course are broken on Apple ARM M? (albeit for
> hardware events, here it is software). Event and metric parsing has to
> worry about things like grouping topdown events. All-in-all let's have
> one way to do things, event parsing, otherwise this code is going to
> end up reinventing all the workarounds the event parsing has to have.
> Lots of struct perf_event_attr also contribute to binary size.
> 
> If you are worried about a cycles event being opened on arm_dsu PMUs,
> there is this patch:
> https://lore.kernel.org/lkml/20240525152927.665498-1-irogers@google.com/
> 
> Thanks,
> Ian

Hi Ian,

Is this comment related to this patch specifically or is it more of a 
general comment?

This patch doesn't really make any actual changes other than move one 
line of code from one place to another.

James

