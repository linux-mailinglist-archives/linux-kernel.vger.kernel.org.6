Return-Path: <linux-kernel+bounces-280777-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DF1E194CF0C
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 12:57:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7B5FDB214CE
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 10:57:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CEF8192B7A;
	Fri,  9 Aug 2024 10:57:32 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CF6317993
	for <linux-kernel@vger.kernel.org>; Fri,  9 Aug 2024 10:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723201051; cv=none; b=mTIbAIvwFVrXt9TVQC8opFeRaaKbg5PQuO1j6xG15NLActWawsDmDQWmrlwgeYDdr9K32xQolfCETCnXJ1NiuCmskLT+T4XQl3YIwsWFZAX5e1XWmGxJkxNx10/lSpNSS+Jb15EQmizzd/FQQ69jX7vlozqD40p5AHYTVNbmq18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723201051; c=relaxed/simple;
	bh=/aB6IK9SufVg+RsxBP39LdXMBjlIpmEjzIzjSRpG/Do=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=S25AZKN3ATxYJQc2sVbzRNSyXfaueM9KDoPZeS7kd4J4T5futAyG0g5H+FaQ7ecvWNNyeXopf4qolPboCDurAzPjmX+MqCd37/4aT5OZ7GxHnC3wMEeBf5IqmHw+YUTSuMwhhujpEE7mcVBuA4DZwuVugEDbNG2aVJwMIOAxXs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 545C213D5;
	Fri,  9 Aug 2024 03:57:55 -0700 (PDT)
Received: from [10.2.76.71] (e132581.arm.com [10.2.76.71])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3BA6D3F71E;
	Fri,  9 Aug 2024 03:57:28 -0700 (PDT)
Message-ID: <3e3b38d1-5170-44ce-b1ba-e9599cceee95@arm.com>
Date: Fri, 9 Aug 2024 11:57:26 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 3/9] perf auxtrace: Refactor
 auxtrace__evsel_is_auxtrace()
To: James Clark <james.clark@linaro.org>,
 Adrian Hunter <adrian.hunter@intel.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>,
 Suzuki K Poulose <suzuki.poulose@arm.com>, Mike Leach
 <mike.leach@linaro.org>, coresight@lists.linaro.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 "Liang, Kan" <kan.liang@linux.intel.com>
References: <20240806204130.720977-1-leo.yan@arm.com>
 <20240806204130.720977-4-leo.yan@arm.com>
 <1059261e-9d1c-472e-a211-f83c313eb5c2@intel.com>
 <8258c91a-ab6c-42f0-a77c-dea52201deec@linaro.org>
Content-Language: en-US
From: Leo Yan <leo.yan@arm.com>
In-Reply-To: <8258c91a-ab6c-42f0-a77c-dea52201deec@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 8/9/24 11:08, James Clark wrote:

[...]

> On 08/08/2024 1:58 pm, Adrian Hunter wrote:
>> On 6/08/24 23:41, Leo Yan wrote:
>>> The auxtrace__evsel_is_auxtrace() function invokes the callback
>>> .evsel_is_auxtrace() to check if an event is an AUX trace. In the
>>> low-level code, every AUX trace module provides its callback to
>>> compare the PMU type.
>>>
>>> This commit refactors auxtrace__evsel_is_auxtrace() by simply
>>> calling evsel__is_aux_event() rather than using the callback function.
>>> As a result, the callback .evsel_is_auxtrace() is no longer needed, so
>>> the definition and implementations are removed.
>>
>> evsel__is_aux_event() assumes it is on the target machine e.g.
>> being called from perf record.  It indirectly reads from sysfs
>> to find PMUs, which will not necessarily be the same a different
>> machine.
>>
>> For example, what happens if a perf data file from one arch is
>> being processed on a machine from another arch.
> 
> I think this does go a bit wrong. If I open an SPE file on x86 it finds
> the intel_pt PMU which both have the same type number. But because
> that's also an auxtrace one it appears to work.

Yes, anyway, I missed the cross report case and this patch will break it.

A event attribute should contain info to indicate the event is an AUX event.
This would be better than inquiry every AUX module. I checked the attribute,
there have no attribute field can be use to indicate a event is AUX event.
A relevant field 'aux_output' is used to generate AUX trace rather than
events, which is not set for AUX events.

Can we add a new field 'auxtrace' into the structure perf_event_attr? By using
this way, the event will track the state rather than stored in PMU.

For next step, I will pick the first two patches in this series and merge them
into the multiple AUX events support patch set. This can allow us to firstly
resolve the multiple AUX event issue.

If we agree the refactoring for 'auxtrace' attribute, then I will use a separate
patch set to address it.

Thanks,
Leo
  

