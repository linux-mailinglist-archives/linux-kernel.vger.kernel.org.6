Return-Path: <linux-kernel+bounces-360922-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E801A99A163
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 12:30:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5752D1F2499B
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 10:30:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A81BC2141B8;
	Fri, 11 Oct 2024 10:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UChjrc2Q"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 336F7212D1F
	for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 10:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728642580; cv=none; b=aEprakaWsbZPojIyiWYwLiVhVWq6PECICqggdiBRwT0bXx248Q54MOfhCLHWOjNgZ+8CacEY+ARsQxmAA6E+rwvdk3034ahZwg5XMxyOodLrWkkPr+Bq5HJ//kJJO764/n2jvLwWcdbrkx//KMfCl+SZCxIFMkc8Ahgm5kTxo+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728642580; c=relaxed/simple;
	bh=yteEQxz10J66CT+PCYl/YxRfhJ1gJiQkkZttYLNo/hA=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=Wt6gAOMSjDTaQxBfyq2OLXmXa1sDTgCDX9qEn2AtU6ZplEfAfdKBu87dcmCBlpDiBrxWdQpfLKa30RDDskuvKMTqp9fFByCPVifWvnwApYiLMV7L75yv5UBMrDcCuHIoth6f7QI1DqV9NrUsM1ctQUEBtjZC3lx3S1yRFMEugVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=UChjrc2Q; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-431195c3538so11063785e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 03:29:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728642576; x=1729247376; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=INWnCWa9p4DCzhAz8SZlPKQTEkrxultFZcTD61R/9K0=;
        b=UChjrc2Q+Zuv1vGELKZbK6I/FFRy4OgE3N22QjGhXTlrI5N3ZDYT5J4XDLtt+SyPA4
         0rtUxcDSeHWlxbKETBWakM21Erl+aQCJ62uWfeTQl2XFEy+D51GlGjDX6oIlhAgfKCuc
         75PD+CMbvqFKmWyrPvTgeDjk94URxVSiKcJ65ugwsujJ3LhbHy79TGTQV3OSDduoAdVE
         HWNNJn0elkWMWsQYJj4obreWuClgD8EFeT/ijIzuZjFB+p8f+R5yy13Wba7vGHcRG1wk
         55HyACEG9gmtTCgVZKzVHPz4lRsMBeWzO9hz7u9e5Lt3zcv2VOLcN1/GdC/VkSjeU7Hi
         5uXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728642576; x=1729247376;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=INWnCWa9p4DCzhAz8SZlPKQTEkrxultFZcTD61R/9K0=;
        b=VHxDQvtAv4wvIRxIhuG58iPrRwJG9XOx9hq3two1fIIOfhM5MwBNj3aIjiRYb7WmW9
         M5Y/rg91LhymJE9HkAvLb7AgJhXUMyY55xaB91m1Yc7DYEHIJrwWe/BoShYP/oJSp4Sk
         j6WKoRpnbvLJ8nsrTfEdmyqC7gX3M6e/SVYwrTsajXQpEuVYC0to63f2TdmLBtXVKEQj
         DH+2kSmhLHBeNkIZcgWAej5xxc51pAiIBzG6SHbU1oFkpLxEIaHz8H9LHehHpYZjgF10
         TpRXsKN/IoIHeHjbQebsKiuF27jZRZhRWoWPYrEIBAV1gnunuvUtpxOjmq2fLBDVxCZi
         te9w==
X-Forwarded-Encrypted: i=1; AJvYcCX7qEz7+KhZWnYzyWUPpRD60aREMaEnnNXK9sEIxVorSQlBSoD7gTt/9tjWRtrJZyL6KivP84gLV0Hjmbs=@vger.kernel.org
X-Gm-Message-State: AOJu0YynxTfMdF2vP2jKA/0S7klqNtUe6KupsNAbmlAzo8Go09x3zwbl
	lxpGzwJte1PD5+s3+TvzndK36bV9psWwYVCuGF8QSieRsMp/K/ujjr/cUMruiYg=
X-Google-Smtp-Source: AGHT+IEktUGrC4462Wglj/ucGdSO53AKyn6o1LcTuCzB8CQWo/AYuc/0Y8rlRb4dI7Feat4F2kzQmA==
X-Received: by 2002:a05:600c:3ba0:b0:42f:310f:de9 with SMTP id 5b1f17b1804b1-4311deebe1dmr13276075e9.15.1728642576549;
        Fri, 11 Oct 2024 03:29:36 -0700 (PDT)
Received: from [192.168.1.3] ([89.47.253.130])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-430d70b42d8sm72027095e9.31.2024.10.11.03.29.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Oct 2024 03:29:36 -0700 (PDT)
Message-ID: <affbe9b6-4d27-47d7-8767-9531f92b3d32@linaro.org>
Date: Fri, 11 Oct 2024 11:29:34 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 5/8] perf test: Tag parallel failing shell tests with
 "(exclusive)"
From: James Clark <james.clark@linaro.org>
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
 Kan Liang <kan.liang@linux.intel.com>, Howard Chu <howardchu95@gmail.com>,
 Athira Jajeev <atrajeev@linux.vnet.ibm.com>,
 Michael Petlan <mpetlan@redhat.com>, Veronika Molnarova
 <vmolnaro@redhat.com>, Dapeng Mi <dapeng1.mi@linux.intel.com>,
 Thomas Richter <tmricht@linux.ibm.com>, Ilya Leoshkevich
 <iii@linux.ibm.com>, Colin Ian King <colin.i.king@gmail.com>,
 Weilin Wang <weilin.wang@intel.com>, Andi Kleen <ak@linux.intel.com>,
 linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
References: <20241011073559.431302-1-irogers@google.com>
 <20241011073559.431302-6-irogers@google.com>
 <c32f8c46-3895-49e0-a837-98859345039b@linaro.org>
Content-Language: en-US
In-Reply-To: <c32f8c46-3895-49e0-a837-98859345039b@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 11/10/2024 11:01 am, James Clark wrote:
> 
> 
> On 11/10/2024 8:35 am, Ian Rogers wrote:
>> Some shell tests compete for resources and so can't run with other
>> tests, tag such tests.  The "(exclusive)" stems from shared/exclusive
>> to describe how the tests run as if holding a lock.
>>
>> Signed-off-by: Ian Rogers <irogers@google.com>
>> ---
>>   tools/perf/tests/shell/perftool-testsuite_report.sh | 2 +-
>>   tools/perf/tests/shell/record.sh                    | 2 +-
>>   tools/perf/tests/shell/record_lbr.sh                | 2 +-
>>   tools/perf/tests/shell/record_offcpu.sh             | 2 +-
>>   tools/perf/tests/shell/stat_all_pmu.sh              | 2 +-
>>   tools/perf/tests/shell/test_intel_pt.sh             | 2 +-
>>   tools/perf/tests/shell/test_stat_intel_tpebs.sh     | 2 +-
>>   7 files changed, 7 insertions(+), 7 deletions(-)
>>
> 
> The following ones would also need to be marked as exclusive, not sure 
> if you can include those here or you want me to send a patch:
> 
>   tools/perf/tests/shell/coresight/asm_pure_loop.sh
>   tools/perf/tests/shell/coresight/memcpy_thread_16k_10.sh
>   tools/perf/tests/shell/coresight/thread_loop_check_tid_10.sh
>   tools/perf/tests/shell/coresight/thread_loop_check_tid_2.sh
>   tools/perf/tests/shell/coresight/unroll_loop_thread_10.sh
>   tools/perf/tests/shell/test_arm_coresight.sh
>   tools/perf/tests/shell/test_arm_coresight_disasm.sh
>   tools/perf/tests/shell/test_arm_spe.sh
> 
> In theory all tests using probes would also need to be exclusive because 
> they install and delete probes globally. In practice I don't think I saw 
> any failures, whether that's just luck or because of some skips I'm not 
> sure.
> 
> And this one fails consistently in parallel mode on Arm:
> 
>    22: Number of exit events of a simple workload
>      : FAILED!
> 
> But it's a C test so I assume there isn't an exclusive mechanism to skip 
> it? It doesn't look like it should be affected though, so maybe we could 
> leave it failing as a real bug.
>

Oh I see it says in the cover letter it can be set for C tests. But can 
that be done through all the existing TEST_CASE() etc macros?


