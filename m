Return-Path: <linux-kernel+bounces-208018-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66DBD901F68
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 12:30:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A152BB20F5D
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 10:29:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01F8778C7D;
	Mon, 10 Jun 2024 10:29:36 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D646815B3;
	Mon, 10 Jun 2024 10:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718015375; cv=none; b=NLfo69N8haQTM3Wuji2Ue0gMZVIPWKgPav2nmFLgB6pEfftdjYFvwiGcVC/ZjwQ9L0fAHrOBpr+uSsGsk4G2SqOXgVXnSCmOGFPweYswkDwUffTYkT5qRciNwiOMUCrJuQO4hnSJ+Mykt9gFhlwVJ82uacb+vCbxLzkFgewwEH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718015375; c=relaxed/simple;
	bh=9yHlgxkFolcI67pUpMpcXyC0XND7ujb3mNTWVgJll/A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NG15FvMAimXtlzfQb62a8eZzEpFJFm23+EpWfrdCXPfR44Xqav1llGtHl9m3+wc4V3PTs4p4bf1mV42GcBrDAQikJVmm5D3dTTczZ9qYd28/7Wz3Fq5f0L/4+O1ffLz70QakxcooTWnlyxdRiQ9VqrZLBuzOYEiQixm5rESG9/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A3F491692;
	Mon, 10 Jun 2024 03:29:57 -0700 (PDT)
Received: from [10.57.71.145] (unknown [10.57.71.145])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 458C43F73B;
	Mon, 10 Jun 2024 03:29:30 -0700 (PDT)
Message-ID: <a697111a-ec64-451a-aee1-3709bd08e73e@arm.com>
Date: Mon, 10 Jun 2024 11:29:28 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 15/16] coresight: Re-emit trace IDs when the sink
 changes in per-thread mode
Content-Language: en-GB
To: James Clark <james.clark@arm.com>, coresight@lists.linaro.org,
 gankulkarni@os.amperecomputing.com, mike.leach@linaro.org,
 leo.yan@linux.dev, anshuman.khandual@arm.com
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>, John Garry
 <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com, linux-perf-users@vger.kernel.org
References: <20240604143030.519906-1-james.clark@arm.com>
 <20240604143030.519906-16-james.clark@arm.com>
From: Suzuki K Poulose <suzuki.poulose@arm.com>
In-Reply-To: <20240604143030.519906-16-james.clark@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 04/06/2024 15:30, James Clark wrote:
> In per-cpu mode there are multiple aux buffers and each one has a
> fixed sink, so the hw ID mappings which only need to be emitted once
> for each buffer, even with the new per-sink trace ID pools.
> 
> But in per-thread mode there is only a single buffer which can be
> written to from any sink with now potentially overlapping trace IDs, so
> hw ID mappings need to be re-emitted every time the sink changes.
> 
> This will require a change in Perf to track this so it knows which
> decode tree to use for each segment of the buffer. In theory it's also
> possible to look at the CPU ID on the AUX records, but this is more
> consistent with the existing system, and allows for correct decode using
> either mechanism.
> 
> Signed-off-by: James Clark <james.clark@arm.com>
> ---
>   drivers/hwtracing/coresight/coresight-etm-perf.c | 14 ++++++++++++++
>   drivers/hwtracing/coresight/coresight-etm-perf.h |  2 ++
>   2 files changed, 16 insertions(+)
> 
> diff --git a/drivers/hwtracing/coresight/coresight-etm-perf.c b/drivers/hwtracing/coresight/coresight-etm-perf.c
> index 17cafa1a7f18..b6f505b50e67 100644
> --- a/drivers/hwtracing/coresight/coresight-etm-perf.c
> +++ b/drivers/hwtracing/coresight/coresight-etm-perf.c
> @@ -499,6 +499,20 @@ static void etm_event_start(struct perf_event *event, int flags)
>   				      &sink->perf_sink_id_map))
>   		goto fail_disable_path;
>   
> +	/*
> +	 * In per-cpu mode there are multiple aux buffers and each one has a
> +	 * fixed sink, so the hw ID mappings which only need to be emitted once
> +	 * for each buffer.
> +	 *
> +	 * But in per-thread mode there is only a single buffer which can be
> +	 * written to from any sink with potentially overlapping trace IDs, so
> +	 * hw ID mappings need to be re-emitted every time the sink changes.
> +	 */
> +	if (event->cpu == -1 && event_data->last_sink_hwid != sink) {
> +		cpumask_clear(&event_data->aux_hwid_done);
> +		event_data->last_sink_hwid = sink;
> +	}

I am wondering if we really need this patch, as we have the sinkid in 
the HWID already ? We would emit the packet for each CPU only once and
that wouldn't change the HWID ?

Suzuki


> +
>   	/*
>   	 * output cpu / trace ID in perf record, once for the lifetime
>   	 * of the event.
> diff --git a/drivers/hwtracing/coresight/coresight-etm-perf.h b/drivers/hwtracing/coresight/coresight-etm-perf.h
> index 744531158d6b..bd4553b2a1ec 100644
> --- a/drivers/hwtracing/coresight/coresight-etm-perf.h
> +++ b/drivers/hwtracing/coresight/coresight-etm-perf.h
> @@ -52,6 +52,7 @@ struct etm_filters {
>    * @snk_config:		The sink configuration.
>    * @cfg_hash:		The hash id of any coresight config selected.
>    * @path:		An array of path, each slot for one CPU.
> + * @last_sink_hwid:	Last sink that a hwid was emitted for.
>    */
>   struct etm_event_data {
>   	struct work_struct work;
> @@ -60,6 +61,7 @@ struct etm_event_data {
>   	void *snk_config;
>   	u32 cfg_hash;
>   	struct list_head * __percpu *path;
> +	struct coresight_device *last_sink_hwid;
>   };
>   
>   int etm_perf_symlink(struct coresight_device *csdev, bool link);


