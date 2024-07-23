Return-Path: <linux-kernel+bounces-260141-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0633393A3BE
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 17:27:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 878431F241DC
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 15:27:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFF0B157494;
	Tue, 23 Jul 2024 15:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CaOpnhxa"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BEFC15747F
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2024 15:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721748406; cv=none; b=srOPZ/0c97YW22PY9faGqJ1XJ9r6xfezce1QSSc8Ohnn2v59PdJKL9g2KI7/+gv4mZw6h8RtAZyZtIKMrjdM3jw+L25lXOPcc7akRnzz46rvaGde9i5ZDD0UcOctCWeHT3wDBvTn5AdANzL16KEPor+DrwUVsUsTiixnDiK6TPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721748406; c=relaxed/simple;
	bh=/GAzCoIpzcinpHppherQZNExMsxjrylvg0JO9ZwT0bo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aFQ/bUXaRKGfxVjtivtiD8sJslppVqeMDDStcH2qDaQrPCNvprFeXkLHWysbEXa6N9z1z9qtXH1vIHy19csFHAdMc6jU3DhxE2soh0E2ZhHeer02zVb4Qg/9NHckHhQn4Q2hi1ZRV84+WxruhM70wAlOAF5Go9TiXNjYOKHhrSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=CaOpnhxa; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-427d2cc1c4eso40257335e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2024 08:26:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721748402; x=1722353202; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6sJgSl3GAq4Vma3aTaXhJBsKRSa5G5hA7HsiKy1dx+4=;
        b=CaOpnhxa4aCILPuBj2/pYWApPy/Qv1bULSvKdi0hGR9fCvYZrGwPUMc9E03fEZwFHo
         jSm5//i2y7PnC6EZGppDSbN5JLnjqW5T4ndSWwqRvHEOIIrohKwvCSksn5W03VewdYr8
         86HZZa7x0anqhNfvyS6RQ73lOlblvZZKQeLX56eaQYCE9UhI9t7prGHcqKyk1ydOZXdz
         jkGJ3k/sXYGFIRFjdly7yiRBIfOrRBjxc8V0fAikcyIaHh4+06v8ARJl5CgJeoqeLpJF
         3O8ZHDK4Kmdb5U0fcuCqgWXRoPY6zqtpFqCLgB1X2jNU9Z0J1OsUNBxzso299fsYKE8x
         Bd8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721748402; x=1722353202;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6sJgSl3GAq4Vma3aTaXhJBsKRSa5G5hA7HsiKy1dx+4=;
        b=tdri74MxupXaWLJlFsTcAp2Ko+j1upVncbgFb080EORi3T+xp7WovfzBVsxsujIHqY
         5VaBHZfbNeeRyR3SKaPzIdwIPACHnL2Vn0ikU09qRH9quSHwv+muKj5joRMelDtZgiAW
         d9840pS0xFWDI5UsR4sK2tpwMgvOD1y7R/O0YTvWpeT466o49tkxPUhzgd39ZER05uV7
         Ya7oEXBZkC29k/GzHjSpBw+WF/hPANplJsZuAzHWWU/uNiT6AXH9C3hItA73iwHDMJ9s
         ikRYj6BLJXNJDd6xlmY8AKRiYxg/aPoKlwvkveKCCKtkBwvtNR+bPbAdtjtlPNV46zFh
         4O6g==
X-Forwarded-Encrypted: i=1; AJvYcCWTuEs4uGD2718ezJs25FfC9px6dhgcSl1OLIn73Uv5JzuIJuUAgh4H6CwRlFPN/1RcA4dfXPJhk8dwPyAbBKPy6gWLHrztUUqsXK6e
X-Gm-Message-State: AOJu0Ywj6enZJbWtJlvq3tPI2Ho6H7o4TU0lsGbdTlwo4/LIdliR5bdh
	kWzHniNHuQ8Gx4pDHVz8oVTyuZR7CuUICU7GLcC/+ZeKZkCt6Ou00TevM8l0/Ck=
X-Google-Smtp-Source: AGHT+IH704aplI1Gj4zi9mJCmtvatJ7BJmFbEsuJXSPD/J001YnpqT8iBJNqXv1HeeLf25Wnb5i4qw==
X-Received: by 2002:a05:6000:156a:b0:364:3ba5:c5af with SMTP id ffacd0b85a97d-369dee68c16mr3078106f8f.61.1721748402116;
        Tue, 23 Jul 2024 08:26:42 -0700 (PDT)
Received: from [192.168.1.3] ([89.47.253.130])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3687868b24csm11809518f8f.25.2024.07.23.08.26.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Jul 2024 08:26:41 -0700 (PDT)
Message-ID: <945e58b5-5012-45a8-933a-c1a192fd006e@linaro.org>
Date: Tue, 23 Jul 2024 16:26:40 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/2] perf script: Fix for `perf script +F metric` with
 leader sampling
To: Ian Rogers <irogers@google.com>
Cc: Andi Kleen <ak@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
 Kan Liang <kan.liang@linux.intel.com>, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org, Athira Rajeev <atrajeev@linux.vnet.ibm.com>
References: <20240720074552.1915993-1-irogers@google.com>
 <20240720074552.1915993-2-irogers@google.com>
 <8c8da262-a398-41cc-9721-4e72e6b7e5fd@linaro.org>
 <CAP-5=fWwjJuHpTJDMtxKYGDa9Sjo-kHk099vBTW8N-6_GtMfMw@mail.gmail.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <CAP-5=fWwjJuHpTJDMtxKYGDa9Sjo-kHk099vBTW8N-6_GtMfMw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 23/07/2024 3:57 pm, Ian Rogers wrote:
> On Tue, Jul 23, 2024 at 7:41 AM James Clark <james.clark@linaro.org> wrote:
>>
>>
>>
>> On 20/07/2024 8:45 am, Ian Rogers wrote:
>>> Andi Kleen reported a regression where `perf script +F metric` would
>>> crash. With this change the output is:
>>>
>>> ```
>>> $ perf record -a -e '{cycles,instructions}:S' perf bench mem memcpy
>>>
>>>         21.229620 GB/sec
>>>
>>>         15.751008 GB/sec
>>>
>>>         16.009221 GB/sec
>>> [ perf record: Woken up 1 times to write data ]
>>> [ perf record: Captured and wrote 1.945 MB perf.data (294 samples) ]
>>> $ perf --no-pager script -F +metric
>>>               perf 1912464 [000] 814503.473101:       6325       cycles:  ffffffff8548d64a native_write_msr+0xa ([kernel.kallsyms])
>>>               perf 1912464 [000] 814503.473101:   metric:    0.06  insn per cycle
>>>               perf 1912464 [000] 814503.473101:        351 instructions:  ffffffff8548d64a native_write_msr+0xa ([kernel.kallsyms])
>>>               perf 1912464 [000] 814503.473101:   metric:    0.03  insn per cycle
>>> ...
>>> ```
>>
>> For some reason I only get the metric: lines when I record with -a. I
>> noticed this because Andi's test doesn't use -a so it fails.
>>
>> I'm not sure if that's expected or it's related to your disclaimer below?
> 
> It is. When you don't do -a the cpu map just contains -1 and for some
> reason it is busted. The whole indirections to arrays of arrays,
> counts, stats, aggregations, with indices into various other arrays
> and a lack of helpers. The code works for perf stat, but there is a
> lot of complexity that I don't fully grok in that. Here I've tried to
> kind of break down what the code is trying to do in the comments, but
> the old code never did sample_read_group__for_each so was is broken
> with leader sampling? Is the leader sampling pretending the read
> counts are periods and calling process sample multiple times. Andi
> likely knows this code better than me so I was hoping he could fix it
> up. We may want to take the patches anyway in order to not have a
> segv.
> 
> Thanks,
> Ian
> 

Yeah I suppose it's strictly better now without the segfault. Could you 
pull in the test and update it to add -a? At least then that behavior 
will be locked down and we can extend it later without -a.

I also tested Andi's V5 and still got the segfault.

>>>
>>> The change fixes perf script to update counts and thereby aggregate
>>> values which then get consumed by unchanged metric logic in the shadow
>>> stat output. Note, it would be preferential to switch to json metrics.
>>>
>>> Reported-by: Andi Kleen <ak@linux.intel.com>
>>> Closes: https://lore.kernel.org/linux-perf-users/20240713155443.1665378-1-ak@linux.intel.com/
>>> Fixes: 37cc8ad77cf8 ("perf metric: Directly use counts rather than saved_value")'
>>> Signed-off-by: Ian Rogers <irogers@google.com>
>>> ---
>>> The code isn't well tested nor does it support non-leader sampling
>>> reading of counts based on periods that seemed to present in the
>>> previous code. Sending out for the sake of discussion. Andi's changes
>>> added a test and that should certainly be added.
>>> ---
>>>    tools/perf/builtin-script.c | 114 +++++++++++++++++++++++++++++-------
>>>    1 file changed, 93 insertions(+), 21 deletions(-)
>>>

