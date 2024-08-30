Return-Path: <linux-kernel+bounces-308205-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F08C89658A8
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 09:33:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D19C1C23017
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 07:33:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D156158544;
	Fri, 30 Aug 2024 07:32:54 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C703C14EC41
	for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 07:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725003173; cv=none; b=HLrfR8miHAK2bcRNPaXlNHZZsLzyz5CY6Hk6QJZrtHHnczUin6UQlz1i1KhP4k0K/9n9dhzYv8ZR8y6dzKC66b60aTsjMYQIF2tmJDd5Rk/njmITareNcdkcitUoRNXy/xvT4FElIgSoEjRfjBTRRCJ1zBGWy0JiE45zNjRTCm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725003173; c=relaxed/simple;
	bh=jH+pooDgwOPqgnTB3bY2WHm43B/dWviLsZL1E79h8Uw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XWV8fFwU37zrHVpb4474DbpkGWuHHRETCFTjcSEFvrfQyj5baImScjxcV6crxxwbH/obDUMqk5jiCdxxVtKGCIrXS4sOnLaYzRW30x7NRBrvnxUrYqpPi81SHEaAKMjzH9A0bWtCRfsCZht0wGrVhg6CN9frGWjjfkSKn/SfsOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2845F1063;
	Fri, 30 Aug 2024 00:33:17 -0700 (PDT)
Received: from [10.2.76.71] (e132581.arm.com [10.2.76.71])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5C3523F66E;
	Fri, 30 Aug 2024 00:32:49 -0700 (PDT)
Message-ID: <1bac3bc6-172f-4b45-8087-d0779cee8dd7@arm.com>
Date: Fri, 30 Aug 2024 08:32:47 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/9] perf auxtrace: Remove unused 'pmu' pointer from
 struct auxtrace_record
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
 Adrian Hunter <adrian.hunter@intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>,
 James Clark <james.clark@linaro.org>,
 Suzuki K Poulose <suzuki.poulose@arm.com>, Mike Leach
 <mike.leach@linaro.org>, coresight@lists.linaro.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 "Liang, Kan" <kan.liang@linux.intel.com>
References: <20240806204130.720977-1-leo.yan@arm.com>
 <20240806204130.720977-3-leo.yan@arm.com>
 <53c51dfc-9727-4e11-8846-6f37bc64744a@intel.com> <Zs-Tkl0D44fQmMHT@x1>
Content-Language: en-US
From: Leo Yan <leo.yan@arm.com>
In-Reply-To: <Zs-Tkl0D44fQmMHT@x1>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Arnaldo,

On 8/28/24 22:16, Arnaldo Carvalho de Melo wrote:
> On Fri, Aug 09, 2024 at 11:02:16AM +0300, Adrian Hunter wrote:
>> On 6/08/24 23:41, Leo Yan wrote:
>>> The 'pmu' pointer in the auxtrace_record structure is not used after
>>> support multiple AUX events, remove it.
>>>
>>> Signed-off-by: Leo Yan <leo.yan@arm.com>
>>
>> Reviewed-by: Adrian Hunter <adrian.hunter@intel.com>
> 
> Applied the first reviewed two patches.

I confirmed it is fine to picking up these two patches.

Just note, I combined these two patches into the multiple AUX event series [1].
Once I receive response for that series, I will drop the picked two patches and
send new series.

Thanks,
Leo

[1] https://lore.kernel.org/linux-perf-users/20240823113306.2310957-2-leo.yan@arm.com/

