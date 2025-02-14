Return-Path: <linux-kernel+bounces-514749-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EEC2BA35B0D
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 11:03:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 70886188CCD2
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 10:03:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE9FB253B46;
	Fri, 14 Feb 2025 10:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RMNgjBdm"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C8FA202C43
	for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 10:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739527374; cv=none; b=o5b+/WRh8VgAHuOIHdjInqogyJKVCIOauMnHNG50ynw2ZidtZ+Rwgi1E3stOXHc27M3Wxrv7sWaIPNElO0KhL4KPqKYNWypLIkC/+VDK07Lrp16aHpZlYOvtU4KgYie3qp8oQlLKym+eTpMxVEMrh2rlgilAaCTDbxnWLMQdTqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739527374; c=relaxed/simple;
	bh=6IIJKgD/OctiPI/Am9zaDQvl6XDddiVDhmizBXie3+w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TdCBY8Vx1QaKF7D5eoXf8EwENah+1T8zTGri9D1DF6Se/ow2PXdidBgRFhsgMOzTOb7HJWZvV7FE++hSDTv7etZTTtCpDcVDaAADpqHFjsSnpynMrVXhLHOjBNBFp/ScE12IjK0WiPNS1U7ozSRZIAcdcqA0gvcs49gP9vGg+hs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=RMNgjBdm; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4395f81db4dso11229925e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 02:02:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739527369; x=1740132169; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WX8WwYpC/7CDpNuf00AfcD8uPd4813egQtu1K93XN+I=;
        b=RMNgjBdmi14GdXF/e/FXOgFkspcAfCbTV6mCByCmutlxIded49f6GkLeesW3gdp/Yw
         D/0cH5oMOQTqyO9QxDy4Mc20zgVLWO7YFbq7xC8fWUvR5050IE1uKIAYzgQ7G824Wg63
         1lkkjYfFHiSU4sdkA5RRu3DVsQDwXOfopaezW2XVyyDQYyqRuyzki56mbsMBK4hL+tTS
         RkH2yZodiqLDCsKfQdNxYXJJ+naScWDikIF8e2YQVZ2kz4KgsXDSM+S8pdQ8pnEo/St3
         iWPXAGzhJYGDtHWYMtKRI8RzgJa3ZGT9StPC6eVWu1I8twf9sTA85F0CPGXCMioyoDz8
         DWJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739527369; x=1740132169;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WX8WwYpC/7CDpNuf00AfcD8uPd4813egQtu1K93XN+I=;
        b=ki8bUJZnZa4zioCqxuRw+KeZdnhCMQmmSdjC6w0f90HCUx3Qg1B76pSqtWfdwpsfA2
         MryN9Hyuy662+E4SoGwaqFzYMAxrJtdc1wJnZLbGkTJyML6ruEfPtaqYOuV5Kn73WPAa
         Dyg6wlt0oYjNyzw5c95uXdTOROQ43UzbfRCiNKREQsOysts/aTWq8kEKUvyoQdrINtRF
         FwsQP+OYfgicqxd8EAYlylgw5Mq+bk9zIJktrj1ZhxngZH6cgwKTNQsAJ2OtqMfO60Xt
         MGKNOeh/0tlMDB4U9lSh1NAAl3wVHNIns06PKe12ZSyjQ+lejFNp8K5oMFf4TFF7CkZF
         1fOQ==
X-Forwarded-Encrypted: i=1; AJvYcCXTbZCstPEOOiV+KJYpvm61RmRo+/2RxocBaS0GEbFBzDqDgXj2QLzPHLIHcfU5fqhsin1ShUSUW91HFPw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQ2OKqBqd7l3qUFl8rp3/D1vAtqlmj2CqGhUas//gPyjCYzUZ4
	aKoyrC6ZImFa2Xdt4F4IuivLjxex/ch7/PRZoYufZT7Y0BFMRjddaC2OGazO0MNitSrEUPBlQto
	KWn4=
X-Gm-Gg: ASbGncsWi21RIaQysww43eTrgv5B6J9IOhKMyXDM2tm247BBFo8z66F36MBUUHp7Yja
	FKLiLZv5Gk3Kc5dw/GFOQNCE5NmjjSPU0TXrNXiB/SjKs7LIWe1vCodPhNh5Bp+UKtfX0XOmxqz
	7zdSmQyzPjLcdmBNeSoURCzBQlABAD0bCjZuAIcOC1HGU9vO9vLthgF1otHxBRVCnBO+pRtx3at
	PFeZ6Rc6ZQVuut3EgCHwZXrUrY7ssRmVbhRVV3nrtQ3oSRfzpYWDMLzldUceXU26KjzIJtfB3Mk
	2+o+mIsE0f1pfInIdTH3Kvjs0g==
X-Google-Smtp-Source: AGHT+IGXbOvw8S2GyqkxFIBv52Dq7Q6IHtiiNKaFsB5EmhnCm9g3CNMhqRiW6G3yKYM1hCJUjhidtA==
X-Received: by 2002:a05:600c:a0c:b0:434:f1bd:1e40 with SMTP id 5b1f17b1804b1-43960e81b92mr70034575e9.6.1739527369462;
        Fri, 14 Feb 2025 02:02:49 -0800 (PST)
Received: from [192.168.68.163] ([145.224.90.202])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4396b5267b6sm1615605e9.0.2025.02.14.02.02.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Feb 2025 02:02:47 -0800 (PST)
Message-ID: <1b8b234f-6435-45cf-83e7-8e86c84f075f@linaro.org>
Date: Fri, 14 Feb 2025 10:02:44 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] perf vendor events arm64: Add A720/A520
 events/metrics
To: Yangyu Chen <cyy@cyyself.name>, Namhyung Kim <namhyung@kernel.org>,
 Ian Rogers <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org, John Garry <john.g.garry@oracle.com>,
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
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <tencent_45B4E91CA370C563D6420A1A25F992056D09@qq.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 14/02/2025 5:49 am, Yangyu Chen wrote:
> 
> 
>> On 14 Feb 2025, at 09:12, Namhyung Kim <namhyung@kernel.org> wrote:
>>
>> Hello,
>>
>> On Thu, Feb 13, 2025 at 11:11:01PM +0800, Yangyu Chen wrote:
>>> This patchset adds the perf JSON files for the Cortex-A720 and Cortex-A520
>>> processors. Some events have been tested on Raxda Orion 6 with Cix P1 SoC
>>> (8xA720 + 4xA520) running mainline Kernel with ACPI mode.
>>
>> I'm curious how the name of PMUs look like.  It is cortex_a720 (or a520)?
> 
> The name of PMUs comes from Arm's documentation. I have included these
> links in each patch.
> 
>> I remember there's a logic to check the length of hex digits at the end.
>>
> 
> Could you provide more details about this?
> 
>> Ian, are you ok with this?
>>

I think they wouldn't be merged because they're core PMUs, so should be 
fine? Even though they would otherwise be merged because they're more 
than 3 hex digits.

>> Thanks,
>> Namhyung
>>
>>>
>>> Yangyu Chen (2):
>>>   perf vendor events arm64: Add Cortex-A720 events/metrics
>>>   perf vendor events arm64: Add Cortex-A520 events/metrics
>>>
>>> .../arch/arm64/arm/cortex-a520/bus.json       |  26 ++
>>> .../arch/arm64/arm/cortex-a520/exception.json |  18 +
>>> .../arm64/arm/cortex-a520/fp_operation.json   |  14 +
>>> .../arch/arm64/arm/cortex-a520/general.json   |   6 +
>>> .../arch/arm64/arm/cortex-a520/l1d_cache.json |  50 ++
>>> .../arch/arm64/arm/cortex-a520/l1i_cache.json |  14 +
>>> .../arch/arm64/arm/cortex-a520/l2_cache.json  |  46 ++
>>> .../arch/arm64/arm/cortex-a520/l3_cache.json  |  21 +
>>> .../arch/arm64/arm/cortex-a520/ll_cache.json  |  10 +
>>> .../arch/arm64/arm/cortex-a520/memory.json    |  58 +++
>>> .../arch/arm64/arm/cortex-a520/metrics.json   | 373 +++++++++++++++
>>> .../arch/arm64/arm/cortex-a520/pmu.json       |   8 +
>>> .../arch/arm64/arm/cortex-a520/retired.json   |  90 ++++
>>> .../arm64/arm/cortex-a520/spec_operation.json |  70 +++
>>> .../arch/arm64/arm/cortex-a520/stall.json     |  82 ++++
>>> .../arch/arm64/arm/cortex-a520/sve.json       |  22 +
>>> .../arch/arm64/arm/cortex-a520/tlb.json       |  78 ++++
>>> .../arch/arm64/arm/cortex-a520/trace.json     |  32 ++
>>> .../arch/arm64/arm/cortex-a720/bus.json       |  18 +
>>> .../arch/arm64/arm/cortex-a720/exception.json |  62 +++
>>> .../arm64/arm/cortex-a720/fp_operation.json   |  22 +
>>> .../arch/arm64/arm/cortex-a720/general.json   |  10 +
>>> .../arch/arm64/arm/cortex-a720/l1d_cache.json |  50 ++
>>> .../arch/arm64/arm/cortex-a720/l1i_cache.json |  14 +
>>> .../arch/arm64/arm/cortex-a720/l2_cache.json  |  62 +++
>>> .../arch/arm64/arm/cortex-a720/l3_cache.json  |  22 +
>>> .../arch/arm64/arm/cortex-a720/ll_cache.json  |  10 +
>>> .../arch/arm64/arm/cortex-a720/memory.json    |  54 +++
>>> .../arch/arm64/arm/cortex-a720/metrics.json   | 436 ++++++++++++++++++
>>> .../arch/arm64/arm/cortex-a720/pmu.json       |   8 +
>>> .../arch/arm64/arm/cortex-a720/retired.json   |  90 ++++
>>> .../arch/arm64/arm/cortex-a720/spe.json       |  42 ++
>>> .../arm64/arm/cortex-a720/spec_operation.json |  90 ++++
>>> .../arch/arm64/arm/cortex-a720/stall.json     |  82 ++++
>>> .../arch/arm64/arm/cortex-a720/sve.json       |  50 ++
>>> .../arch/arm64/arm/cortex-a720/tlb.json       |  74 +++
>>> .../arch/arm64/arm/cortex-a720/trace.json     |  32 ++
>>> .../arch/arm64/common-and-microarch.json      |  15 +
>>> tools/perf/pmu-events/arch/arm64/mapfile.csv  |   2 +
>>> 39 files changed, 2263 insertions(+)
>>> create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a520/bus.json
>>> create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a520/exception.json
>>> create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a520/fp_operation.json
>>> create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a520/general.json
>>> create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a520/l1d_cache.json
>>> create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a520/l1i_cache.json
>>> create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a520/l2_cache.json
>>> create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a520/l3_cache.json
>>> create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a520/ll_cache.json
>>> create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a520/memory.json
>>> create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a520/metrics.json
>>> create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a520/pmu.json
>>> create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a520/retired.json
>>> create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a520/spec_operation.json
>>> create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a520/stall.json
>>> create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a520/sve.json
>>> create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a520/tlb.json
>>> create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a520/trace.json
>>> create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a720/bus.json
>>> create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a720/exception.json
>>> create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a720/fp_operation.json
>>> create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a720/general.json
>>> create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a720/l1d_cache.json
>>> create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a720/l1i_cache.json
>>> create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a720/l2_cache.json
>>> create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a720/l3_cache.json
>>> create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a720/ll_cache.json
>>> create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a720/memory.json
>>> create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a720/metrics.json
>>> create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a720/pmu.json
>>> create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a720/retired.json
>>> create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a720/spe.json
>>> create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a720/spec_operation.json
>>> create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a720/stall.json
>>> create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a720/sve.json
>>> create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a720/tlb.json
>>> create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a720/trace.json
>>>
>>> -- 
>>> 2.47.2
>>>
> 


