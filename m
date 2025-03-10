Return-Path: <linux-kernel+bounces-554136-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 35157A5935F
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 13:04:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8ABB31891EF4
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 12:03:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29D8A225A2C;
	Mon, 10 Mar 2025 12:01:30 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2232E2222B5;
	Mon, 10 Mar 2025 12:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741608089; cv=none; b=Iv+BwiZ0kR3+m/xnidNlfxFdvTcbinueMW+jphCPpFyw4TckmwkOTP/biNLxz34K/3YKQm4vGhn/nCXXHX7Tklsa+Nu6OpSLzUYtwYDcpObYpPb7TWbgPGdlxbyFcduWBcxYbBlteQM+B2BS2xk8nAT3GtjLd7i+8Pe4Dal8Yz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741608089; c=relaxed/simple;
	bh=WBDXx1vokHCS7NaHgBUOgXNOTV2V7L3CvptF+NRbaf8=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=XrhF+OhqPZ4ZQ5WW6OMzxKyzsuXCCcHe9J0ifY6AdFBxCt4SDvFgj3gB50OXxRUxCLZ0UkT89vfGLpNbvTPNNwmatdrfb98Oq4BE9wXUwdXmk4ugkgKllpkF/6dS23fYTYw9Nb4IRrig+h4AdNVHkYJ/P1TZ1wNwU2y5JaIKnh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F18881516;
	Mon, 10 Mar 2025 05:01:38 -0700 (PDT)
Received: from [10.1.197.1] (ewhatever.cambridge.arm.com [10.1.197.1])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3B1C83F5A1;
	Mon, 10 Mar 2025 05:01:26 -0700 (PDT)
Message-ID: <65979e92-0047-427c-848d-53f908671905@arm.com>
Date: Mon, 10 Mar 2025 12:01:25 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/8] coresight: Introduce pause and resume APIs for
 source
To: Leo Yan <leo.yan@arm.com>, Mike Leach <mike.leach@linaro.org>,
 James Clark <james.clark@linaro.org>, Jonathan Corbet <corbet@lwn.net>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Arnaldo Carvalho de Melo <acme@redhat.com>,
 Namhyung Kim <namhyung@kernel.org>, coresight@lists.linaro.org,
 linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250310104919.58816-1-leo.yan@arm.com>
 <20250310104919.58816-3-leo.yan@arm.com>
Content-Language: en-US
From: Suzuki K Poulose <suzuki.poulose@arm.com>
In-Reply-To: <20250310104919.58816-3-leo.yan@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/03/2025 10:49, Leo Yan wrote:
> Introduce APIs for pausing and resuming trace source and export as GPL
> symbols.
> 
> Signed-off-by: Leo Yan <leo.yan@arm.com>
> ---
>   drivers/hwtracing/coresight/coresight-core.c | 20 ++++++++++++++++++++
>   drivers/hwtracing/coresight/coresight-priv.h |  2 ++
>   include/linux/coresight.h                    |  4 ++++
>   3 files changed, 26 insertions(+)
> 
> diff --git a/drivers/hwtracing/coresight/coresight-core.c b/drivers/hwtracing/coresight/coresight-core.c
> index 0a9380350fb5..eb7b83a7bfa2 100644
> --- a/drivers/hwtracing/coresight/coresight-core.c
> +++ b/drivers/hwtracing/coresight/coresight-core.c
> @@ -365,6 +365,26 @@ void coresight_disable_source(struct coresight_device *csdev, void *data)
>   }
>   EXPORT_SYMBOL_GPL(coresight_disable_source);
>   
> +void coresight_pause_source(struct coresight_device *csdev)
> +{
> +	if (!csdev || !coresight_is_percpu_source(csdev))

You may remove the !csdev check, coresight_is_percpu_source() already 
checks that.


> +		return;
> +
> +	if (source_ops(csdev)->pause)
> +		source_ops(csdev)->pause(csdev);
> +}
> +EXPORT_SYMBOL_GPL(coresight_pause_source);
> +
> +void coresight_resume_source(struct coresight_device *csdev)
> +{
> +	if (!csdev || !coresight_is_percpu_source(csdev))
> +		return;
> +

Same as above.

> +	if (source_ops(csdev)->resume)
> +		source_ops(csdev)->resume(csdev);
> +}
> +EXPORT_SYMBOL_GPL(coresight_resume_source);
> +
>   /*
>    * coresight_disable_path_from : Disable components in the given path beyond
>    * @nd in the list. If @nd is NULL, all the components, except the SOURCE are
> diff --git a/drivers/hwtracing/coresight/coresight-priv.h b/drivers/hwtracing/coresight/coresight-priv.h
> index 76403530f33e..a9f14c075e91 100644
> --- a/drivers/hwtracing/coresight/coresight-priv.h
> +++ b/drivers/hwtracing/coresight/coresight-priv.h
> @@ -247,5 +247,7 @@ void coresight_add_helper(struct coresight_device *csdev,
>   void coresight_set_percpu_sink(int cpu, struct coresight_device *csdev);
>   struct coresight_device *coresight_get_percpu_sink(int cpu);
>   void coresight_disable_source(struct coresight_device *csdev, void *data);
> +void coresight_pause_source(struct coresight_device *csdev);
> +void coresight_resume_source(struct coresight_device *csdev);
>   
>   #endif
> diff --git a/include/linux/coresight.h b/include/linux/coresight.h
> index 17276965ff1d..703e1b8dbe22 100644
> --- a/include/linux/coresight.h
> +++ b/include/linux/coresight.h
> @@ -385,6 +385,8 @@ struct coresight_ops_link {
>    *		is associated to.
>    * @enable:	enables tracing for a source.
>    * @disable:	disables tracing for a source.
> + * @resume:	resumes tracing for a source.
> + * @pause:	pauses tracing for a source.
>    */
>   struct coresight_ops_source {
>   	int (*cpu_id)(struct coresight_device *csdev);
> @@ -392,6 +394,8 @@ struct coresight_ops_source {
>   		      enum cs_mode mode, struct coresight_trace_id_map *id_map);
>   	void (*disable)(struct coresight_device *csdev,
>   			struct perf_event *event);
> +	int (*resume)(struct coresight_device *csdev);
> +	void (*pause)(struct coresight_device *csdev);

Given these callbacks are for perf mode, does it make sense  to pass the 
parameters similar to enable() ? Also, should we rename these as :

resume_perf
pause_perf

To explicitly mark them perf mode specific ?

Suzuki

>   };
>   
>   /**


