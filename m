Return-Path: <linux-kernel+bounces-514795-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B7A7A35BC1
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 11:47:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1A2A618943E8
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 10:45:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2487726137C;
	Fri, 14 Feb 2025 10:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jItG9VRH"
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72E6F20DD66
	for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 10:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739529914; cv=none; b=VDsn2DOVxOlyqY0UN6aa3m/PCKhXXrBgPAhCL8NS7TAWp77IYpyDM6BdVBfAJaT3vv7oTXn6AbngB5kPbYnvu9J4dg5JFJtVHQQDlRHfrKKvnJUH3TMuzwgV2bpoePqrjo2h5izhmPI1nWu3Y82rqXD1KEwkpbwoEgabfXARfgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739529914; c=relaxed/simple;
	bh=Nx9EhElNnXdckJI528SZPNFesBEPptOwmd+Z/ThXERg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=f6Cl4+78bARagc0zcVyqz3Bmr4gDDFcKU31Gydi1d/93bJcRD3PwoA4PWSrsWXX4By78EsWzybu5x6VbgNiS2ixbW26NfyenMq3K2W6m8YYb1En9rb1fqANr40Fr+pdY6OnpINDWl4S1qxdhcCLTuBmd7dbmJ4plXMkLO8o86Jk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=jItG9VRH; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-38dc5764fc0so1657434f8f.3
        for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 02:45:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739529911; x=1740134711; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=He1s2OIxDgisgww5yn2VxjMheuTyHEWczA9ZBdr3hJQ=;
        b=jItG9VRHHkFsfI+MT1J7M5cYcVAO8iWvhPqYjdDXizCjY/uxwWaje5gZjtNHr1UTq7
         hzfU+t+36HOm/IurJObFc1clt0E6pdf7qwpzWfm2EYXmwXlyYim83AS67wi48rRxdDHW
         57g1/LYSd4Ils0KSAAr1IKVPDsa+UfNpCjKvRg6Aa8TgUwq6LxQunLA166kHYcVUJK3C
         jWQIZ9iznfFtnrFoXJPqaNGw60aph+nxMc4qXKjxtgd65D7+t5CJ1VdhaltlccgsCdGo
         5+qeegzzLfc1eYWBI+8Y9bOApUKFgAKMK4dh4wb68nugfv/oqXzQFQFEu/Ff/SCm0vZn
         2nlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739529911; x=1740134711;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=He1s2OIxDgisgww5yn2VxjMheuTyHEWczA9ZBdr3hJQ=;
        b=MhQh0FTraaqNRdsVSTQHkpMmNdZlpFzFD9CVAHFMofEVkzP8H8b6xhiU34741Xyscr
         IVa2B8TvP/FgILJZAGrFNpj8ctZqjJPXCTuwaCIuTGwhoN9vbHP6j+YwNwTYcZK7f8+N
         cGXQ8i24qhLZEvW6xBSpaYpQZIdYYjPYJblX5rXpMpZ8tZo8+Vws5NF2gsDRYn50Xi3R
         m76kBNixBzjxnAADKG5OYiX6l8mCgtvhiGDqxeSGHGYAzf39Ev1XLKUt1MPL9o+6f8Q3
         PWUAvqAa6plW4tijWDNwIOtm48BCNG28z9hPvHiqgBHjgpRqqt+vFmi9AwF+9RVG95K3
         a0Cw==
X-Forwarded-Encrypted: i=1; AJvYcCWfdgJVCTXExo/1MG3z3Q04pCxuJGz0QVN1ZQCk0U2ejLr1Gl9/XVZvTWZuHySdeKYBtpljp8rDuIDBVUI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVDOLoA1YObk1f+hGwkQtgE5kSBJ9ZbzSb/SaC4tPfIkftvuzb
	lEF2ObTp5Cxv8Pqu+xGiLFDNT90Tn6lXotaTJPG793nkJZm+oSmT3SAlFt/ph7k=
X-Gm-Gg: ASbGncup1XstAXMrAs3uTirl83YM2295WSZZ+ED6R5mcGMIfP0qGZ4/cC/gPRG0rUiE
	MHfSfpljRdyIZ7uj+U31CDXl8tACD/67Hm3p5DttanbzWG8BKU/qvujiayHKaWsaZyCJ3j9cSKM
	dsOWGLIwMGlm6ff3IYUzvg8TENkarGnQuchea3toa3HnfX0IKm0vlrMnpzjHsYd40CIyIGkQWM4
	/KqTRb4VTPtqNupbEa4DqvS4cJAiIXqrTBBQIVOdujYRHe0AHYUxLoomQxpyWe9ZpliqaiQ3gLf
	h+P/kuhVo7I/drEH19z4cV6UmQ==
X-Google-Smtp-Source: AGHT+IEsTwh5I/x8/HDxHBh6znue5a6A9yAG+hxspk3gf1dRGBn6Fcnb2VFbvG0klj0RG27F7iXfdg==
X-Received: by 2002:a5d:5f8c:0:b0:38e:6cd0:f973 with SMTP id ffacd0b85a97d-38e6cd1122dmr12892583f8f.21.1739529910686;
        Fri, 14 Feb 2025 02:45:10 -0800 (PST)
Received: from [192.168.68.163] ([145.224.90.202])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38f258f5fabsm4236425f8f.45.2025.02.14.02.45.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Feb 2025 02:45:09 -0800 (PST)
Message-ID: <6c9d8c3a-d5f7-4b88-9dda-74b9b3d4484c@linaro.org>
Date: Fri, 14 Feb 2025 10:45:08 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf stat: Fix non-uniquified hybrid legacy events
To: Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org, Robin.Murphy@arm.com,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
 "Liang, Kan" <kan.liang@linux.intel.com>, linux-kernel@vger.kernel.org
References: <20250212122413.1184503-1-james.clark@linaro.org>
 <CAP-5=fWywDB40-RgV8LaPqsoffOLdDcYkUB_LHoPvV=R8yas4w@mail.gmail.com>
 <CAP-5=fV0rWEL-ewGpoDwaJ3rvbTPXSx0YTuF5p9=6+h5oUhsfg@mail.gmail.com>
 <c672c3a3-64e3-495a-ae61-ae098d30c6b9@linaro.org>
 <Z66b9-I_MkmX7pg5@google.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <Z66b9-I_MkmX7pg5@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 14/02/2025 1:27 am, Namhyung Kim wrote:
> Hello,
> 
> On Thu, Feb 13, 2025 at 12:15:30PM +0000, James Clark wrote:
>>
>>
>> On 12/02/2025 9:38 pm, Ian Rogers wrote:
>>> On Wed, Feb 12, 2025 at 9:48 AM Ian Rogers <irogers@google.com> wrote:
>>>>
>>>> On Wed, Feb 12, 2025 at 4:24 AM James Clark <james.clark@linaro.org> wrote:
>>>>>
>>>>> Legacy hybrid events have attr.type == PERF_TYPE_HARDWARE, so they look
>>>>> like plain legacy events if we only look at attr.type. But legacy events
>>>>> should still be uniquified if they were opened on a non-legacy PMU.
>>>>> Previously we looked at the PMU type to determine legacy vs hybrid
>>>>> events here so revert this particular check to how it was before the
>>>>> linked fixes commit.
>>>>>
>>>>> counter->pmu doesn't need to be null checked twice, in fact it is
>>>>> required for any kind of uniquification so make that a separate check.
>>>>>
>>>>> This restores PMU names on hybrid systems and also changes "perf stat
>>>>> metrics (shadow stat) test" from a FAIL back to a SKIP (on hybrid). The
>>>>> test was gated on "cycles" appearing alone which doesn't happen on
>>>>> here.
>>>>>
>>>>> Before:
>>>>>
>>>>>     $ perf stat -- true
>>>>>     ...
>>>>>        <not counted>      instructions:u                           (0.00%)
>>>>>              162,536      instructions:u            # 0.58  insn per cycle
>>>>>     ...
>>>>>
>>>>> After:
>>>>>
>>>>>    $ perf stat -- true
>>>>>    ...
>>>>>        <not counted>      cpu_atom/instructions/u                  (0.00%)
>>>>>              162,541      cpu_core/instructions/u   # 0.62  insn per cycle
>>>>>    ...
>>>>>
>>>>> Fixes: 357b965deba9 ("perf stat: Changes to event name uniquification")
>>>>> Signed-off-by: James Clark <james.clark@linaro.org>
>>>>> ---
>>>>>    tools/perf/util/stat-display.c | 9 +++++++--
>>>>>    1 file changed, 7 insertions(+), 2 deletions(-)
>>>>>
>>>>> diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-display.c
>>>>> index e65c7e9f15d1..eae34ba95f59 100644
>>>>> --- a/tools/perf/util/stat-display.c
>>>>> +++ b/tools/perf/util/stat-display.c
>>>>> @@ -1688,12 +1688,17 @@ static void evsel__set_needs_uniquify(struct evsel *counter, const struct perf_s
>>>>>                   return;
>>>>>           }
>>>>>
>>>>> -       if  (counter->core.attr.type < PERF_TYPE_MAX && counter->core.attr.type != PERF_TYPE_RAW) {
>>>>> +       if (!counter->pmu) {
>>>>
>>>> Thanks James, I wish I had a hybrid laptop so I didn't keep breaking
>>>> things like this. I'm uncomfortable using an evsel having/not-having a
>>>> PMU as an indication of whether uniquification is necessary. It is
>>>> kind of a side-effect of parsing whether the PMU variable is non-NULL,
>>>> it'd kind of be nice to stop things using `evsel->pmu` directly and
>>>> switch them to `evsel__find_pmu(evsel)`, in the future maybe legacy
>>>> events will get the core PMU, a tracepoint PMU, etc. so we'd never
>>>> expect this variable to be NULL.
>>
>> As it stands evsel__uniquify_counter() unconditionally dereferences
>> evsel->pmu which is why I thought it made sense to check that first. But if
>> that might change then fair enough.
>>
>>>>
>>>> Your commit message gives me enough to think about what the issue is,
>>>> so let me give it some thought.
>>>
>>> I wonder we should just hoist the hybrid test earlier:
>>> ```
>>> diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-display.c
>>> index e65c7e9f15d1..e852ac0d9847 100644
>>> --- a/tools/perf/util/stat-display.c
>>> +++ b/tools/perf/util/stat-display.c
>>> @@ -1688,6 +1688,12 @@ static void evsel__set_needs_uniquify(struct
>>> evsel *counter, const struct per
>>> f_s
>>>                  return;
>>>          }
>>>
>>> +       if (!config->hybrid_merge && evsel__is_hybrid(counter)) {
>>> +               /* Unique hybrid counters necessary. */
>>> +               counter->needs_uniquify = true;
>>> +               return;
>>> +       }
>>> +
>>>          if  (counter->core.attr.type < PERF_TYPE_MAX &&
>>> counter->core.attr.type != PERF_TYPE_RAW) {
>>>                  /* Legacy event, don't uniquify. */
>>>                  return;
>>> @@ -1705,12 +1711,6 @@ static void evsel__set_needs_uniquify(struct
>>> evsel *counter, const struct per
>>> f_s
>>>                  return;
>>>          }
>>>
>>> -       if (!config->hybrid_merge && evsel__is_hybrid(counter)) {
>>> -               /* Unique hybrid counters necessary. */
>>> -               counter->needs_uniquify = true;
>>> -               return;
>>> -       }
>>> -
>>>          /*
>>>           * Do other non-merged events in the evlist have the same name? If so
>>>           * uniquify is necessary.
>>>
>>> ```
>>>
>>> The hybrid test is unfortunately expensive at it needs to search for
>>>> 1 core PMU, which means loading all sysfs PMUs. I think we're already
>>> paying the cost though.
>>>
>>> Could you check this works James?
>>>
>>> Thanks,
>>> Ian
>>>
>>
>> Yep that works too.
> 
> James, can I take it as your Tested-by?
> 

Yep sure

> Ian, can you please send a formal patch with that?
> 
> Thanks,
> Namhyung
> 


