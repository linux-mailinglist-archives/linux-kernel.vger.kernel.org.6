Return-Path: <linux-kernel+bounces-350663-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EF870990880
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 18:05:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C248FB2505A
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 15:47:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5617D1AA7B1;
	Fri,  4 Oct 2024 15:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hDgP+FMw"
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D4451C304F
	for <linux-kernel@vger.kernel.org>; Fri,  4 Oct 2024 15:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728056416; cv=none; b=h7BGsvsvZH4w1vhF50wt4UcnBqDn0GPLZNIf2MDDYuyo3UCk4VQewe9P/WDt+ngaYGxl+AJJN4DKA/RWLHxHgvGltxIJLc0J8oEYOd4XYg8El7dkMfUxWsdM87EX3Em6J76F+Jo7AfYKZ+SrHN82M49+ecuze9HpzOcvOi4P1zM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728056416; c=relaxed/simple;
	bh=tlog5Puy9tYn45pVIriTYxhn+2WhzdBfm35n7a2lqyw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oHbf30fgJFr602iqRYh67SC8MCugko681FulaFBhBpclMoCVwxpzr5lQItLdU4Eq9FLP4darRTuGhtXfBF6BWs/j7kAuByz1rIHUUkfg1W47ubqAqWM10e9UCWHCyKVxLyrFkNuQs1v3DB4YtAhNwnAa5zABTydQgIJWjjIOhUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=hDgP+FMw; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-37cea34cb57so1499979f8f.0
        for <linux-kernel@vger.kernel.org>; Fri, 04 Oct 2024 08:40:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728056413; x=1728661213; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aHux5YCBtf6Tmf71heyPONJlsjnrZTh7gRZYCFhLq9M=;
        b=hDgP+FMwRNUXTw0T2fTyh0YkGB9lYFutooXm9W9UO81OoXhWxYwS8FT1NcmsUc8u1p
         kuXTJ1TW4+VlATt3182JEBapyKfzVweiEKF0D+GCDupLpdC9ON6M17jhSfycOPNEzn7a
         pzCw5YKtGxzlz2K/6heXOFp+LFRsxRBsOCE5tJduCMbXIfTesfChzU33EyRwpvrckQeZ
         5lJeGFeblwqslRwwKN4UIZo37JGehqJHzSAZ/bkWTSF0whIW0Kq+MXCKv4mUxq/tOMpx
         CJa2+au8+fb+8uMqomgCTKDfpEYL1UwhMbVREK+UvG905JVt9kavLmorQ0Sp+SOkpCo3
         9oQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728056413; x=1728661213;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aHux5YCBtf6Tmf71heyPONJlsjnrZTh7gRZYCFhLq9M=;
        b=rSrtnDy7CVVokKVBgUi53gh4qnRu8/zb9TweIVc+9VYF2QwxmVTQ5YjID2ip8gkRUz
         wGmBPRcu6zg9naTW94YK9kTb7JLCg1zMnW3X3XFaKzFywIBruZhnJT//gLz7NTEEHqgJ
         0uWSfpzLrct2lR8SdRuSXB3AWv5b5DqvmcjYdc/mS5V7RaDtDmp70OsVYzRSYfRYhPtR
         YSsj+evoo1L0S5YSbmNIMULeP0FYYuFJJdylni3RA6pirrOf79qbxcqZmu56Uw0Nn7Xt
         2aAEAimRKPVS84ePELQNZCshcXgk6ID/i0CNEFVVUMAvTkV9gfYx7A/ah5NfUtzwH4Ys
         SbtA==
X-Forwarded-Encrypted: i=1; AJvYcCWbk9e2ifx1JkyvophEOHwk96fw1XCYczJVuOaGJf6Ys7EBrx/dhXgt9sQvdA9DCHpmkfBk2ZjM8xl3YWs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxq2Dph4/hzUOkE9NVpsfLnoCKdUEGSf/bV/pxDVa6ZADfcrltY
	fockYvCgpU1qQ0dasDVUxOv1XHmFLszqz32G66mnQCnGXtpfNNu2e7+7zcWiTWM=
X-Google-Smtp-Source: AGHT+IF2Yngfld5XXGH+7t1bU2U2KiO9+t0OHKCQZL8WUyRPXViGsUPh90uJyTN5fP6/zi54xcRjPg==
X-Received: by 2002:adf:ea8c:0:b0:374:c432:4971 with SMTP id ffacd0b85a97d-37d0e6f01aemr1907015f8f.16.1728056412774;
        Fri, 04 Oct 2024 08:40:12 -0700 (PDT)
Received: from [192.168.1.183] ([89.47.253.130])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42f86b4a38bsm18387855e9.39.2024.10.04.08.40.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Oct 2024 08:40:12 -0700 (PDT)
Message-ID: <eec7cdd2-e74b-4845-a898-320c911832fa@linaro.org>
Date: Fri, 4 Oct 2024 16:40:18 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHSET 0/8] perf tools: Do not set attr.exclude_guest by
 default (v4)
To: Namhyung Kim <namhyung@kernel.org>
Cc: Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>,
 LKML <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org,
 Ravi Bangoria <ravi.bangoria@amd.com>, Mark Rutland <mark.rutland@arm.com>,
 James Clark <james.clark@arm.com>, Kajol Jain <kjain@linux.ibm.com>,
 Thomas Richter <tmricht@linux.ibm.com>, Atish Patra <atishp@atishpatra.org>,
 Palmer Dabbelt <palmer@rivosinc.com>, Mingwei Zhang <mizhang@google.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>, Ian Rogers <irogers@google.com>,
 Kan Liang <kan.liang@linux.intel.com>
References: <20241001002027.1272889-1-namhyung@kernel.org>
 <b894eed7-15e0-4ec4-a9d6-07fe86326396@linaro.org>
 <Zv2RIr8I04f8dEP2@google.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <Zv2RIr8I04f8dEP2@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 02/10/2024 19:29, Namhyung Kim wrote:
> On Wed, Oct 02, 2024 at 10:49:36AM +0100, James Clark wrote:
>>
>>
>> On 01/10/2024 1:20 am, Namhyung Kim wrote:
>>> Hello,
>>>
>>> I found perf tools set exclude_guest bit inconsistently.  It used to
>>> set the bit but now the default event for perf record doesn't.  So I'm
>>> wondering why we want the bit in the first place.
>>>
>>> Actually it's not good for PMUs don't support any exclusion like AMD
>>> IBS because it disables new features after the exclude_guest due to
>>> the missing feature detection logic.
>>>
>>> v4 changes)
>>>
>>>    * handle EOPNOTSUPP error in compatible way  (Kan)
>>>    * drop --exclude-guest option in perf stat
>>>    * not to separate exclude_hv fallback
>>>    * rename to exclude_GH_default  (Kan)
>>>    * drop the RFC from the subject
>>>
>>> v3) https://lore.kernel.org/lkml/20240905202426.2690105-1-namhyung@kernel.org/
>>>
>>>    * move exclude_guest fallback to the front
>>>    * fix precise_max handling on AMD
>>>    * simplify the default event for perf record
>>>
>>> v2) https://lore.kernel.org/lkml/20240904064131.2377873-1-namhyung@kernel.org/
>>>
>>>    * update the missing feature detection logic
>>>    * separate exclude_hv fallback
>>>    * add new fallback for exclude_guest
>>>
>>> v1) https://lore.kernel.org/lkml/20240902014621.2002343-1-namhyung@kernel.org/
>>>
>>> AFAIK it doesn't matter for the most cases but perf kvm.  If users
>>> need to set the bit, they can still use :H modifier.  For vPMU pass-
>>> through or Apple M1, it'd add the exclude_guest during the fallback
>>> logic.
>>>
>>> Also the kernel feature detection logic should be separated from the
>>> exclude bit tests since it depends on the PMU implementation rather
>>> than the core kernel features.  So I changed it to use a software
>>> event for the detection and factor out some hw-specific checks.
>>>
>>> The code is available at 'perf/exclude-v4' branch in
>>> git://git.kernel.org/pub/scm/linux/kernel/git/namhyung/linux-perf.git
>>>
>>> Thanks,
>>> Namhyung
>>>
>>>
>>
>> Looks like you need to allow for :H in the perf stat test on M1 now:
>>
>> diff --git a/tools/perf/tests/shell/stat.sh b/tools/perf/tests/shell/stat.sh
>> index 5a2ca2bcf94d..77cb95859649 100755
>> --- a/tools/perf/tests/shell/stat.sh
>> +++ b/tools/perf/tests/shell/stat.sh
>> @@ -161,7 +161,7 @@ test_hybrid() {
>>     fi
>>
>>     # Run default Perf stat
>> -  cycles_events=$(perf stat -- true 2>&1 | grep -E "/cycles/|  cycles " |
>> wc -l)
>> +  cycles_events=$(perf stat -- true 2>&1 | grep -E "/cycles/|  cycles |  cycles:H  " | wc -l)
> 
> Ok, what about "u"?  Probably it can be
> 
>    cycles_events=$(perf stat -- true 2>&1 | grep -E "/cycles/(uH)*|  cycles(:[uH])* " | wc -l)
> 

Yep that probably works too and is a bit more robust

>>
>>     if [ "$pmus" -ne "$cycles_events" ]
>>     then
>>
>> Other than that:
>>
>> Reviewed-by: James Clark <james.clark@linaro.org>
> 
> Thanks for the review!
> Namhyung
> 
>>
>>> Namhyung Kim (8):
>>>     perf tools: Add fallback for exclude_guest
>>>     perf tools: Don't set attr.exclude_guest by default
>>>     perf tools: Simplify evsel__add_modifier()
>>>     perf tools: Do not set exclude_guest for precise_ip
>>>     perf tools: Detect missing kernel features properly
>>>     perf tools: Move x86__is_amd_cpu() to util/env.c
>>>     perf tools: Check fallback error and order
>>>     perf record: Just use "cycles:P" as the default event
>>>
>>>    tools/perf/arch/x86/util/Build              |   1 -
>>>    tools/perf/arch/x86/util/env.c              |  19 -
>>>    tools/perf/arch/x86/util/env.h              |   7 -
>>>    tools/perf/arch/x86/util/pmu.c              |   2 +-
>>>    tools/perf/builtin-kvm.c                    |   1 +
>>>    tools/perf/builtin-record.c                 |   4 +-
>>>    tools/perf/builtin-stat.c                   |  18 +-
>>>    tools/perf/dlfilters/dlfilter-test-api-v0.c |   2 +-
>>>    tools/perf/dlfilters/dlfilter-test-api-v2.c |   2 +-
>>>    tools/perf/tests/attr/test-record-dummy-C0  |   2 +-
>>>    tools/perf/tests/parse-events.c             |  30 +-
>>>    tools/perf/util/env.c                       |  24 ++
>>>    tools/perf/util/env.h                       |   4 +
>>>    tools/perf/util/evsel.c                     | 394 ++++++++++++++------
>>>    tools/perf/util/evsel.h                     |   1 -
>>>    tools/perf/util/parse-events.c              |   6 +-
>>>    tools/perf/util/util.c                      |  10 +-
>>>    tools/perf/util/util.h                      |   3 +
>>>    18 files changed, 364 insertions(+), 166 deletions(-)
>>>    delete mode 100644 tools/perf/arch/x86/util/env.c
>>>    delete mode 100644 tools/perf/arch/x86/util/env.h
>>>
>>

