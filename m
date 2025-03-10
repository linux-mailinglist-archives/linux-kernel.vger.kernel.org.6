Return-Path: <linux-kernel+bounces-554333-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E9EEA5964C
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 14:29:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C5D7D1888271
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 13:29:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA65622A1D5;
	Mon, 10 Mar 2025 13:29:32 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF6ED846D;
	Mon, 10 Mar 2025 13:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741613372; cv=none; b=VYtPRYj9bWYGoQdno55xaTJA9frcSkNOFfIjuPH1C24InQ9BwCz4s7yPBDo8FhUyKD/RO+6Q5osg2KJbe4pRiJ5ETqNCpuodHWD68PhGHU4MGwOimmrJKRxnDKusscjwpvGCpxOfxLc3c+rCSjzqIwKmoQct3RSX/8RtwYF/XA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741613372; c=relaxed/simple;
	bh=wZ+bjnc45ikRcTR7Zx2xMwTbXDKPzC9yDpMnfE9AKes=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=DaNcTR4pcwoZw68ACJDRWh1F6RhQXF2b6Rg2VzjUg+vqXsBh73iouAaA13gUbMnPy/hgMVfmgGEpCy9HjLEj02Bw9UArDtseplpLonml0i3gbaLil01MZsLOlC7px4kFZkOqnnNTkMHsWtiPvdTeGPo3/xmtmI46ciepI7AjJQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6AE72153B;
	Mon, 10 Mar 2025 06:29:40 -0700 (PDT)
Received: from [10.1.197.1] (ewhatever.cambridge.arm.com [10.1.197.1])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id ABA2B3F673;
	Mon, 10 Mar 2025 06:29:27 -0700 (PDT)
Message-ID: <d8b1cf1f-1996-4d9c-9f1a-fad556f91577@arm.com>
Date: Mon, 10 Mar 2025 13:29:26 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/8] coresight: etm: Add an attribute for updating
 buffer
To: Leo Yan <leo.yan@arm.com>, Mike Leach <mike.leach@linaro.org>,
 James Clark <james.clark@linaro.org>, Jonathan Corbet <corbet@lwn.net>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Arnaldo Carvalho de Melo <acme@redhat.com>,
 Namhyung Kim <namhyung@kernel.org>, coresight@lists.linaro.org,
 linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250310104919.58816-1-leo.yan@arm.com>
 <20250310104919.58816-6-leo.yan@arm.com>
Content-Language: en-US
From: Suzuki K Poulose <suzuki.poulose@arm.com>
In-Reply-To: <20250310104919.58816-6-leo.yan@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Leo

On 10/03/2025 10:49, Leo Yan wrote:
> Add an attribute for updating buffer when the AUX trace is paused.  And
> populate the value to the 'update_buf_on_pause' flag during the AUX
> setting up.

Do we need this attribute in the uAPI ? Could we do this by default for
sinks without interrupt ? This definitely improves the quality of trace
collected for such sinks and the driver can transparently do this.

Cheers
Suzuki

> 
> If the AUX pause operation is attached to a PMU counter, when the
> counter is overflow and if the PMU interrupt in an NMI, then AUX pause
> operation will be triggered in the NMI context.  On the other hand, the
> per CPU sink has its own interrupt handling.  Thus, there will be a race
> condition between the updating buffer in NMI and sink's interrupt
> handler.
> 
> To avoid the race condition, this commit disallows updating buffer on
> AUX pause for the per CPU sink.  Currently, this is only applied for
> TRBE.
> 
> Signed-off-by: Leo Yan <leo.yan@arm.com>
> ---
>   .../hwtracing/coresight/coresight-etm-perf.c  | 20 +++++++++++++++++++
>   .../hwtracing/coresight/coresight-etm-perf.h  |  2 ++
>   include/linux/coresight-pmu.h                 |  1 +
>   3 files changed, 23 insertions(+)
> 
> diff --git a/drivers/hwtracing/coresight/coresight-etm-perf.c b/drivers/hwtracing/coresight/coresight-etm-perf.c
> index 29d52386ffbb..d759663a1f7d 100644
> --- a/drivers/hwtracing/coresight/coresight-etm-perf.c
> +++ b/drivers/hwtracing/coresight/coresight-etm-perf.c
> @@ -62,6 +62,8 @@ PMU_FORMAT_ATTR(contextid1,	"config:" __stringify(ETM_OPT_CTXTID));
>   PMU_FORMAT_ATTR(contextid2,	"config:" __stringify(ETM_OPT_CTXTID2));
>   PMU_FORMAT_ATTR(timestamp,	"config:" __stringify(ETM_OPT_TS));
>   PMU_FORMAT_ATTR(retstack,	"config:" __stringify(ETM_OPT_RETSTK));
> +PMU_FORMAT_ATTR(update_buf_on_pause,
> +		"config:" __stringify(ETM_OPT_UPDATE_BUF_ON_PAUSE));
>   /* preset - if sink ID is used as a configuration selector */
>   PMU_FORMAT_ATTR(preset,		"config:0-3");
>   /* Sink ID - same for all ETMs */
> @@ -103,6 +105,7 @@ static struct attribute *etm_config_formats_attr[] = {
>   	&format_attr_configid.attr,
>   	&format_attr_branch_broadcast.attr,
>   	&format_attr_cc_threshold.attr,
> +	&format_attr_update_buf_on_pause.attr,
>   	NULL,
>   };
>   
> @@ -434,6 +437,23 @@ static void *etm_setup_aux(struct perf_event *event, void **pages,
>   	if (!sink)
>   		goto err;
>   
> +	/* Populate the flag for updating buffer on AUX pause */
> +	event_data->update_buf_on_pause =
> +		!!(event->attr.config & BIT(ETM_OPT_UPDATE_BUF_ON_PAUSE));
> +
> +	if (event_data->update_buf_on_pause) {
> +		/*
> +		 * The per CPU sink has own interrupt handling, it might have
> +		 * race condition with updating buffer on AUX trace pause if
> +		 * it is invoked from NMI.  To avoid the race condition,
> +		 * disallows updating buffer for the per CPU sink case.
> +		 */
> +		if (coresight_is_percpu_sink(sink)) {
> +			dev_err(&sink->dev, "update_buf_on_pause is not permitted.\n");
> +			goto err;
> +		}
> +	}
> +
>   	/* If we don't have any CPUs ready for tracing, abort */
>   	cpu = cpumask_first(mask);
>   	if (cpu >= nr_cpu_ids)
> diff --git a/drivers/hwtracing/coresight/coresight-etm-perf.h b/drivers/hwtracing/coresight/coresight-etm-perf.h
> index 744531158d6b..52b9385f8c11 100644
> --- a/drivers/hwtracing/coresight/coresight-etm-perf.h
> +++ b/drivers/hwtracing/coresight/coresight-etm-perf.h
> @@ -51,6 +51,7 @@ struct etm_filters {
>    * @aux_hwid_done:	Whether a CPU has emitted the TraceID packet or not.
>    * @snk_config:		The sink configuration.
>    * @cfg_hash:		The hash id of any coresight config selected.
> + * @update_buf_on_pause: The flag to indicate updating buffer on AUX pause.
>    * @path:		An array of path, each slot for one CPU.
>    */
>   struct etm_event_data {
> @@ -59,6 +60,7 @@ struct etm_event_data {
>   	cpumask_t aux_hwid_done;
>   	void *snk_config;
>   	u32 cfg_hash;
> +	bool update_buf_on_pause;
>   	struct list_head * __percpu *path;
>   };
>   
> diff --git a/include/linux/coresight-pmu.h b/include/linux/coresight-pmu.h
> index 89b0ac0014b0..04147e30c2f2 100644
> --- a/include/linux/coresight-pmu.h
> +++ b/include/linux/coresight-pmu.h
> @@ -35,6 +35,7 @@
>   #define ETM_OPT_CTXTID2		15
>   #define ETM_OPT_TS		28
>   #define ETM_OPT_RETSTK		29
> +#define ETM_OPT_UPDATE_BUF_ON_PAUSE	30
>   
>   /* ETMv4 CONFIGR programming bits for the ETM OPTs */
>   #define ETM4_CFG_BIT_BB         3


