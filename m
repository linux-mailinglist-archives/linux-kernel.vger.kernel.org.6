Return-Path: <linux-kernel+bounces-519022-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D9456A39723
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 10:30:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C69611883443
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 09:30:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B22BD230D0A;
	Tue, 18 Feb 2025 09:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RO4oOwoL"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE82422FE0C
	for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 09:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739871030; cv=none; b=ZqHNWfYhNQ+GvpeJv1afBLWMku3Wd2JyscUruoAnyjrrbwgsXioluqXMZAbJOtQBjx2UKv3sn6f4cgH5bdJ21hTrtDHt8NcIhPYosTQpkC/+LueVpMsmNfb2IRiaAVfXVmb9B39KvwCwV4VyXb0lpgYPigu5n1dQEmbMdzEK6Xs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739871030; c=relaxed/simple;
	bh=0chrX0B3aSbge02bi2GD/Os7vwKtRKGXhmtR4Q7RfUI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bPL9q0/uxqj6PavSY1U10UPmZ5+NcLch4VOdNhvi9aCWe/AR6yu642JhlT7ZCfO6rPHO1llguO4gefh0fiaBgpmgF08QGmZ+aeSThcCoOR9D8rlX+irAqcHW0fIjq5O4NevO7HICq4sS9vQin4bGFTvp60YZTSTCQjKiwq/0RrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=RO4oOwoL; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4396a4d5e3bso36860735e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 01:30:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739871027; x=1740475827; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wE00UcNy1SuGyWGuuvNBzcoUSeaUQC7bGOfR84asgzE=;
        b=RO4oOwoLgT8nfcJs3ftVzltNq1OQlm1HZdSfzX6j72bylJyCwrbnoyi58Yw+07SEp8
         1FHMFHxfTE98/ccrlk8Fs/2+JoGDy7IeTavGD1tXduqK/ksm9SbeDpiDwnIVeH0pQcch
         e7sHScCpA6NTpaGM3FMvnXKr2nlKti7ppuYfIRF5WFYQS2PMNQi5ynWbASo8X6uDHLoG
         eoQUK8yQDYULDk2hyrdKBRdt7KpVbnTgnX4kV+T2lLZtrVFN4khoWjnkiuHeLqqE3dEV
         Z+IncUhnHevdSZS2aWxUNsw6dwzSQRgrUpS0CEeRUVgQTgKdsneiY03/GHULje7yY6GG
         8Tfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739871027; x=1740475827;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wE00UcNy1SuGyWGuuvNBzcoUSeaUQC7bGOfR84asgzE=;
        b=QDFne72LROKrGxtiDljmEAzELAL+/lk53ctKczz18FdV/2PTtmloFveUD+0zN+K5XD
         NpHLg9wlcE1TUz2dGHs2cnbxGSYFjpfc8pKa4eY0k3cVuLKb2LzxqcQ0xjW+98pc6Isv
         46r49KDt75kRBaUujyjWo6DHd7/+Ehr5VPd8f1lRGunKTx99tPZToQQQEp+j0FtdZ0An
         yIZt9vsuTuNrL2k5tTDCor+m0h2SbnhCmJEOg9H0I/ioFQL4Ymk6hR8KU4tckg8h10sk
         BAPy0AprDac2vfPBbWpAicRvyBnmbwqLVhiZtubqei+wNz43NlLvFp2sXtdsdDTUJ0yw
         ddoA==
X-Forwarded-Encrypted: i=1; AJvYcCW4/XHni0sKoh3PxZ1g+hwhescfI6GhCldi08FtFmLX9EXNoS0SxKxwdIr+H34nYcimfyUngKiCAgiMGPw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxesacDHPUfXfR7RCcT9xbPe6lGcqGQ5l7rIJZxPBpdHBr9JMTh
	3qeI2h7P0RHbBl+HpQG68dn4FmxSFS/JqxUaoVnzf6UmiqrKTIhzsXhZyS98HnM=
X-Gm-Gg: ASbGncuebVrxhmDejy979FtyMPNjDi2iNeQEI3IRLVQnYIXwiDA/4d3AHlJVbqDNc8D
	2Wje5WiAiZ97TbJzoHUsKSQ2CuYHFpppwLZ4U28zSMm43GB6TVZiVdkrGLcDGK3nE2tf2D3NWKF
	DZINL1cwKuTRSmlv18O75OpVbAFb3CNB4bMM3hpHxPtA8b22geR0QpXV9kiiSbjtc0/iXatzomB
	h1FEE2anjpvPm7qf3WqYhzyHq/jOSdrAeujKXuJoh6GniIvBo+cKmBtU9/C+346kylqZemxECit
	RK5x8Cfa3qHrsx/8tqUKrtZPsA==
X-Google-Smtp-Source: AGHT+IHYnyamw8QWwyVOjp9nBW/UYW7o5DDa8xsRZ9a2WsL6I1a5A5iV6efBKOc6QgGc1zCXFPOP2Q==
X-Received: by 2002:a05:600c:1d1d:b0:439:8ada:e3b0 with SMTP id 5b1f17b1804b1-4398adae4e8mr39398645e9.19.1739871026824;
        Tue, 18 Feb 2025 01:30:26 -0800 (PST)
Received: from [192.168.68.163] ([145.224.90.202])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-439617fc885sm144181505e9.9.2025.02.18.01.30.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Feb 2025 01:30:26 -0800 (PST)
Message-ID: <fe46069e-c52e-45ee-b4b3-8b929fb83b31@linaro.org>
Date: Tue, 18 Feb 2025 09:30:23 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] perf vendor events arm64: Add A720/A520
 events/metrics
To: Ian Rogers <irogers@google.com>
Cc: Yangyu Chen <cyy@cyyself.name>, Namhyung Kim <namhyung@kernel.org>,
 linux-perf-users@vger.kernel.org, John Garry <john.g.garry@oracle.com>,
 Will Deacon <will@kernel.org>, Mike Leach <mike.leach@linaro.org>,
 Leo Yan <leo.yan@linux.dev>, Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
 Liang Kan <kan.liang@linux.intel.com>,
 Yoshihiro Furudera <fj5100bi@fujitsu.com>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <tencent_5360DA048EE5B8CF3104213F8D037C698208@qq.com>
 <Z66YjGvjD_yzEHUg@google.com>
 <tencent_45B4E91CA370C563D6420A1A25F992056D09@qq.com>
 <1b8b234f-6435-45cf-83e7-8e86c84f075f@linaro.org>
 <CAP-5=fVAhLLH-a0_wLo8dPoMLOb6rOJiTgGh-OFZJJoaLFE-8Q@mail.gmail.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <CAP-5=fVAhLLH-a0_wLo8dPoMLOb6rOJiTgGh-OFZJJoaLFE-8Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 18/02/2025 12:41 am, Ian Rogers wrote:
> On Fri, Feb 14, 2025 at 2:02 AM James Clark <james.clark@linaro.org> wrote:
>>
>>
>>
>> On 14/02/2025 5:49 am, Yangyu Chen wrote:
>>>
>>>
>>>> On 14 Feb 2025, at 09:12, Namhyung Kim <namhyung@kernel.org> wrote:
>>>>
>>>> Hello,
>>>>
>>>> On Thu, Feb 13, 2025 at 11:11:01PM +0800, Yangyu Chen wrote:
>>>>> This patchset adds the perf JSON files for the Cortex-A720 and Cortex-A520
>>>>> processors. Some events have been tested on Raxda Orion 6 with Cix P1 SoC
>>>>> (8xA720 + 4xA520) running mainline Kernel with ACPI mode.
>>>>
>>>> I'm curious how the name of PMUs look like.  It is cortex_a720 (or a520)?
>>>
>>> The name of PMUs comes from Arm's documentation. I have included these
>>> links in each patch.
>>>
>>>> I remember there's a logic to check the length of hex digits at the end.
>>>>
>>>
>>> Could you provide more details about this?
>>>
>>>> Ian, are you ok with this?
>>>>
>>
>> I think they wouldn't be merged because they're core PMUs, so should be
>> fine? Even though they would otherwise be merged because they're more
>> than 3 hex digits.
> 
> Do we know the PMU names? If they are cortex_a520 and cortex_a720 then

It will be "armv9_cortex_a720" from this line:

   PMUV3_INIT_SIMPLE(armv9_cortex_a720)

> this comment at least reads a little stale:
> https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tree/tools/perf/util/pmus.c?h=perf-tools-next#n76
> ```
> /*
> * There is a '_{num}' suffix. For decimal suffixes any length
> * will do, for hexadecimal ensure more than 2 hex digits so
> * that S390's cpum_cf PMU doesn't match.
> */
> ```
> James is right that core PMUs aren't put on the same list as uncore/other PMUs.
> 
> Thanks,
> Ian
> 
>>>> Thanks,
>>>> Namhyung
>>>>
>>>>>
>>>>> Yangyu Chen (2):
>>>>>    perf vendor events arm64: Add Cortex-A720 events/metrics
>>>>>    perf vendor events arm64: Add Cortex-A520 events/metrics
>>>>>
>>>>> .../arch/arm64/arm/cortex-a520/bus.json       |  26 ++
>>>>> .../arch/arm64/arm/cortex-a520/exception.json |  18 +
>>>>> .../arm64/arm/cortex-a520/fp_operation.json   |  14 +
>>>>> .../arch/arm64/arm/cortex-a520/general.json   |   6 +
>>>>> .../arch/arm64/arm/cortex-a520/l1d_cache.json |  50 ++
>>>>> .../arch/arm64/arm/cortex-a520/l1i_cache.json |  14 +
>>>>> .../arch/arm64/arm/cortex-a520/l2_cache.json  |  46 ++
>>>>> .../arch/arm64/arm/cortex-a520/l3_cache.json  |  21 +
>>>>> .../arch/arm64/arm/cortex-a520/ll_cache.json  |  10 +
>>>>> .../arch/arm64/arm/cortex-a520/memory.json    |  58 +++
>>>>> .../arch/arm64/arm/cortex-a520/metrics.json   | 373 +++++++++++++++
>>>>> .../arch/arm64/arm/cortex-a520/pmu.json       |   8 +
>>>>> .../arch/arm64/arm/cortex-a520/retired.json   |  90 ++++
>>>>> .../arm64/arm/cortex-a520/spec_operation.json |  70 +++
>>>>> .../arch/arm64/arm/cortex-a520/stall.json     |  82 ++++
>>>>> .../arch/arm64/arm/cortex-a520/sve.json       |  22 +
>>>>> .../arch/arm64/arm/cortex-a520/tlb.json       |  78 ++++
>>>>> .../arch/arm64/arm/cortex-a520/trace.json     |  32 ++
>>>>> .../arch/arm64/arm/cortex-a720/bus.json       |  18 +
>>>>> .../arch/arm64/arm/cortex-a720/exception.json |  62 +++
>>>>> .../arm64/arm/cortex-a720/fp_operation.json   |  22 +
>>>>> .../arch/arm64/arm/cortex-a720/general.json   |  10 +
>>>>> .../arch/arm64/arm/cortex-a720/l1d_cache.json |  50 ++
>>>>> .../arch/arm64/arm/cortex-a720/l1i_cache.json |  14 +
>>>>> .../arch/arm64/arm/cortex-a720/l2_cache.json  |  62 +++
>>>>> .../arch/arm64/arm/cortex-a720/l3_cache.json  |  22 +
>>>>> .../arch/arm64/arm/cortex-a720/ll_cache.json  |  10 +
>>>>> .../arch/arm64/arm/cortex-a720/memory.json    |  54 +++
>>>>> .../arch/arm64/arm/cortex-a720/metrics.json   | 436 ++++++++++++++++++
>>>>> .../arch/arm64/arm/cortex-a720/pmu.json       |   8 +
>>>>> .../arch/arm64/arm/cortex-a720/retired.json   |  90 ++++
>>>>> .../arch/arm64/arm/cortex-a720/spe.json       |  42 ++
>>>>> .../arm64/arm/cortex-a720/spec_operation.json |  90 ++++
>>>>> .../arch/arm64/arm/cortex-a720/stall.json     |  82 ++++
>>>>> .../arch/arm64/arm/cortex-a720/sve.json       |  50 ++
>>>>> .../arch/arm64/arm/cortex-a720/tlb.json       |  74 +++
>>>>> .../arch/arm64/arm/cortex-a720/trace.json     |  32 ++
>>>>> .../arch/arm64/common-and-microarch.json      |  15 +
>>>>> tools/perf/pmu-events/arch/arm64/mapfile.csv  |   2 +
>>>>> 39 files changed, 2263 insertions(+)
>>>>> create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a520/bus.json
>>>>> create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a520/exception.json
>>>>> create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a520/fp_operation.json
>>>>> create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a520/general.json
>>>>> create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a520/l1d_cache.json
>>>>> create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a520/l1i_cache.json
>>>>> create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a520/l2_cache.json
>>>>> create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a520/l3_cache.json
>>>>> create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a520/ll_cache.json
>>>>> create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a520/memory.json
>>>>> create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a520/metrics.json
>>>>> create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a520/pmu.json
>>>>> create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a520/retired.json
>>>>> create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a520/spec_operation.json
>>>>> create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a520/stall.json
>>>>> create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a520/sve.json
>>>>> create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a520/tlb.json
>>>>> create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a520/trace.json
>>>>> create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a720/bus.json
>>>>> create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a720/exception.json
>>>>> create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a720/fp_operation.json
>>>>> create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a720/general.json
>>>>> create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a720/l1d_cache.json
>>>>> create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a720/l1i_cache.json
>>>>> create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a720/l2_cache.json
>>>>> create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a720/l3_cache.json
>>>>> create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a720/ll_cache.json
>>>>> create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a720/memory.json
>>>>> create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a720/metrics.json
>>>>> create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a720/pmu.json
>>>>> create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a720/retired.json
>>>>> create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a720/spe.json
>>>>> create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a720/spec_operation.json
>>>>> create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a720/stall.json
>>>>> create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a720/sve.json
>>>>> create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a720/tlb.json
>>>>> create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a720/trace.json
>>>>>
>>>>> --
>>>>> 2.47.2
>>>>>
>>>
>>


