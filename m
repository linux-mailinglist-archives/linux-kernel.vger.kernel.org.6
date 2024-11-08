Return-Path: <linux-kernel+bounces-401596-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2F839C1CBB
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 13:17:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E63E284223
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 12:17:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EE781E47CC;
	Fri,  8 Nov 2024 12:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sLGL7xCd"
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E86C7B3E1
	for <linux-kernel@vger.kernel.org>; Fri,  8 Nov 2024 12:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731068209; cv=none; b=FqfLm2a8YaaczuQYFt/kFPTL/t9DjIpL9+sLt9LY03haWxmWexrubuHeJpFHoLI9uJfjCE51oR4bxfv/o0OzQMd/T1g/8MvKqhNso1WjVH72UL4DW5S4bLi+IeTVd1LMxRCV7mVlB6vt7ra3VrFUSI4X2U6D4tHL8f53PehdNOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731068209; c=relaxed/simple;
	bh=INR+4hF4QADHM4c27Irlv2yAX6TqyDNccEXTVlS880U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hBb6RnkMpQn049iTNw/Vp9DUfXjmX1dRzsfo06Yxkkm51FJor6Sz4pXz33+C8XBkF3E1h3kp0F9yvsXrlHZ6lJGjUYnveuGxjk4Z+3VvnKjKTJPxT+MIqr9G3f79tMLfk1UX+ubmn2CQAjoYjnEo4SXJ8NAwR4d7CFDNhvVCflw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=sLGL7xCd; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-539f72c8fc1so3314569e87.1
        for <linux-kernel@vger.kernel.org>; Fri, 08 Nov 2024 04:16:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1731068205; x=1731673005; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JZ3fBc9vrdhfjlvvoxQNCflIXe7o6g5VS5PYdFJEVS8=;
        b=sLGL7xCdskoEI6X77FlWDiMbUvnKFX/bfujjdgCnKm7laZ8Mj0sTOfEhBo4Z8o5ghp
         MZ9liewtTDRliForMwdw0JM7WoK5uRadAPWDCCH0FRE9m+731eIUuaOIGdxkL55zWy6G
         ciKm2szcelaMKwhogPK05m2RqZ5XenfSYaB9ZMy1i7mbUi+y5ZA3p+xDiQ0qwximFlCj
         7WTZhnr6DefJ6VRjT+ebwKzvFhTWmjhf4yjod0TWuJOhfzcSiogmRKXE1kGox7esSSvB
         Rz0Wor9womsJqPbrBLFNSIDeQGxX7WeRgJuATqxjNOJnfyRnjlyRMFUCEFowgeGnZef7
         086g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731068205; x=1731673005;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JZ3fBc9vrdhfjlvvoxQNCflIXe7o6g5VS5PYdFJEVS8=;
        b=wdyVrfm+K87RDpTX2KAoKjFqNyjIGGeakgW5z28c/C/7rrc1zeoOTgIDJNYOO8KOGa
         Ty6foAdnOJ6kQ5qZOf8HXJk/Ymiubrk+KO08SCsMNxW8ni6OEoQiiWdcAOjR2bx5oPca
         d0QVaqHb/q9OzGrzrbWXZnYUtLt+LLnsKzfBbVL/6p/4JDa6od9VjPTVBMk+soF2F9gH
         DMiPfrD6Q4x0iouSI1zYihkeefgkdh88Thb6o25qWGv1ckwPLfAaINuVSw38+/Dq6zQI
         4d4ZfjDvP4sfCJhT+c72pSmfiG8v9vvF48HFwImGV8ET7fYayTdS2G/85P/Q5WXb5G2w
         Mbhw==
X-Gm-Message-State: AOJu0YzNvIoEN7xIZT8NFk1L/uNcbJmzYdEahDbakXEl6CTZosLM7+dL
	YOReZwbLpBe1YA/bM3TeeFNymKnGrdk7qnIfgp7VkIk+VYFjP5py+7JkSEwpStw=
X-Google-Smtp-Source: AGHT+IH1zvqcdZ/LuDqh+mCVw6B8DRN5b7XSyMB+43BYdxRmxl6Kvigd3I21b2SuUwGtr/lV246iLg==
X-Received: by 2002:a05:6512:3da5:b0:536:7362:5923 with SMTP id 2adb3069b0e04-53d862275c6mr1434785e87.1.1731068205513;
        Fri, 08 Nov 2024 04:16:45 -0800 (PST)
Received: from [172.20.144.15] ([89.101.134.25])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432aa523a0esm96371185e9.0.2024.11.08.04.16.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Nov 2024 04:16:45 -0800 (PST)
Message-ID: <78eb729c-7594-460f-9d79-97fb683d8b5e@linaro.org>
Date: Fri, 8 Nov 2024 12:16:43 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 0/4] Prefer sysfs/JSON events also when no PMU is
 provided
To: Ian Rogers <irogers@google.com>, Atish Patra <atishp@rivosinc.com>,
 linux-perf-users@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Ben Gainey <ben.gainey@arm.com>,
 Junhao He <hejunhao3@huawei.com>, linux-riscv@lists.infradead.org,
 beeman@rivosinc.com, Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Jiri Olsa <jolsa@kernel.org>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Kan Liang <kan.liang@linux.intel.com>, Ze Gao <zegao2021@gmail.com>,
 Weilin Wang <weilin.wang@intel.com>,
 Dominique Martinet <asmadeus@codewreck.org>
References: <20241026121758.143259-1-irogers@google.com>
 <CAP-5=fXf9HtqKZyvfXNbKLTB-dL_Ax5Hd0_Gn1J-y0T1SE9wLQ@mail.gmail.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <CAP-5=fXf9HtqKZyvfXNbKLTB-dL_Ax5Hd0_Gn1J-y0T1SE9wLQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 07/11/2024 18:51, Ian Rogers wrote:
> On Sat, Oct 26, 2024 at 5:18 AM Ian Rogers <irogers@google.com> wrote:
>>
>> At the RISC-V summit the topic of avoiding event data being in the
>> RISC-V PMU kernel driver came up. There is a preference for sysfs/JSON
>> events being the priority when no PMU is provided so that legacy
>> events maybe supported via json. Originally Mark Rutland also
>> expressed at LPC 2023 that doing this would resolve bugs on ARM Apple
>> M? processors, but James Clark more recently tested this and believes
>> the driver issues there may not have existed or have been resolved. In
>> any case, it is inconsistent that with a PMU event names avoid legacy
>> encodings, but when wildcarding PMUs (ie without a PMU with the event
>> name) the legacy encodings have priority.
>>
>> The patch doing this work was reverted in a v6.10 release candidate
>> as, even though the patch was posted for weeks and had been on
>> linux-next for weeks without issue, Linus was in the habit of using
>> explicit legacy events with unsupported precision options on his
>> Neoverse-N1. This machine has SLC PMU events for bus and CPU cycles
>> where ARM decided to call the events bus_cycles and cycles, the latter
>> being also a legacy event name. ARM haven't renamed the cycles event
>> to a more consistent cpu_cycles and avoided the problem. With these
>> changes the problematic event will now be skipped, a large warning
>> produced, and perf record will continue for the other PMU events. This
>> solution was proposed by Arnaldo.
>>
>> Two minor changes have been added to help with the error message and
>> to work around issues occurring with "perf stat metrics (shadow stat)
>> test".
>>
>> The patches have only been tested on my x86 non-hybrid laptop.
> 
> Hi Atish and James,
> 
> Could I get your tags for this series?
> 
> The patches were originally motivated by wanting to make the behavior
> of events parsed like "cycles" match that of "cpu/cycles/", the PMU is
> wildcarded to "cpu" in the first case. This was divergent because of
> ARM we switched from preferring legacy (type = PERF_TYPE_HARDWARE,
> config = PERF_COUNT_HW_CPU_CYCLES) to sysfs/json (type=<core PMU's
> type>, config=<encoding from event>) when a PMU name was given. This
> aligns with RISC-V wanting to use json encodings to avoid complexity
> in the PMU driver.
> 

I couldn't find the thread, but I remember fairly recently it was 
mentioned that RISC-V would be supporting the legacy events after all, 
maybe it was a comment from Atish? I'm not sure if that changes the 
requirements for this or not?

I still can't really imagine how tooling would work if every tool has to 
maintain the mappings of basic events like instructions and branches. 
For example all the perf_event_open tests in ltp use the legacy events.

And wouldn't porting existing software to RISC-V would be an issue if it 
doesn't behave in a similar way to what's there already?

> James, could you show the neoverse with the cmn PMU behavior for perf
> record of "cycles:pp" due to sensitivities there.
> 

Yep I can check this on Monday.

> Thanks,
> Ian
> 


> 
> 
> 
>> Ian Rogers (4):
>>    perf evsel: Add pmu_name helper
>>    perf stat: Fix find_stat for mixed legacy/non-legacy events
>>    perf record: Skip don't fail for events that don't open
>>    perf parse-events: Reapply "Prefer sysfs/JSON hardware events over
>>      legacy"
>>
>>   tools/perf/builtin-record.c    | 22 +++++++---
>>   tools/perf/util/evsel.c        | 10 +++++
>>   tools/perf/util/evsel.h        |  1 +
>>   tools/perf/util/parse-events.c | 26 +++++++++---
>>   tools/perf/util/parse-events.l | 76 +++++++++++++++++-----------------
>>   tools/perf/util/parse-events.y | 60 ++++++++++++++++++---------
>>   tools/perf/util/pmus.c         | 20 +++++++--
>>   tools/perf/util/stat-shadow.c  |  3 +-
>>   8 files changed, 145 insertions(+), 73 deletions(-)
>>
>> --
>> 2.47.0.163.g1226f6d8fa-goog
>>

