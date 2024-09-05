Return-Path: <linux-kernel+bounces-316326-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E1B996CDF0
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 06:23:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BC6E9B25C90
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 04:23:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56D9E14EC4B;
	Thu,  5 Sep 2024 04:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WM1WajeG"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF16C13DDAA;
	Thu,  5 Sep 2024 04:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725510155; cv=none; b=gayIHY/zXRLIT9Uq+rI7UQHJUtEmCfEH/WGXZX4l9ZeDuIKF3GJyCXG31XNwl9qbNJAFNtfcrLrrD+3xAMyK4/yHAmn59ypbkg0FqE9AvsuXWYfrLpo2qRMz4NPIeSaBNfJg/CZ4iYjRG8JpaCbPP6b8uI77gb/BC3LMjzPelaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725510155; c=relaxed/simple;
	bh=U1TkSowBS4l0pDJb3uRfvRj52SA8sM0BMayw9LB+ZIA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cM2fRoZ0H4UEiJml0ETw9nPZ6O5HBwLrrdnoh3Q3BFc4oVdb4TAcpZPhhC1rByCMaQAl76ALX7eZXIeH9R51vrZ/JCR9a/6mwadCNHghH2wohElGBYrvc6QUokkASwrNZhaj9oDiyyoNLxevG/0M0zyB7GVJaVtmq1dtdD5amR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WM1WajeG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CAC60C4CEC4;
	Thu,  5 Sep 2024 04:22:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725510155;
	bh=U1TkSowBS4l0pDJb3uRfvRj52SA8sM0BMayw9LB+ZIA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WM1WajeGzT11zSvASNbpATUP2tDMV0p0b3DkI/RhM8+k3/1/ZykWnShNurU7yF70X
	 pkymxs/jWLZ9c/mDM7JBmZzGjw9Z0uttykTnOuBTG3moT0Edq0yerJWdIWNEttNIkd
	 X9Ug+ZFHogTl+W2yZZnOnMTLzGN5GpqmJ1qag5BaxFzczYX4nAeVnZx4m4enqJ9I1N
	 WlJuqz3CfszhBBCyMAa01ljNXxY64oa5wS6xvEABtf3J8EdYU0QwStg4tl16MEK9UA
	 uvpVAPXW4GdjDOSIwtt12m9mPY2ZAvA4nlvCQtSso25nC4bh4yA1/1XD7NuRijvtrS
	 /UGQXRdssHetg==
Date: Wed, 4 Sep 2024 21:22:33 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Charlie Jenkins <charlie@rivosinc.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] libperf: Add perf_evsel__id() function
Message-ID: <ZtkyCWXVjnn-hjUT@google.com>
References: <20240823-perf_evsel_get_id-v1-1-0ffa204c4164@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240823-perf_evsel_get_id-v1-1-0ffa204c4164@rivosinc.com>

Hello,

On Fri, Aug 23, 2024 at 11:58:38AM -0700, Charlie Jenkins wrote:
> Introduce perf_evsel__id() to collect the id of an evsel. It is not
> currently possible when using libperf to determine the id of an evsel.
> This will allow applications to link the id returned by PERF_SAMPLE_ID
> to the event being sampled.

I'm not sure what's your use case.  We have evlist__id2evsel() to
convert sample-ID to evsel already.  It'd read the IDs from perf data
file.

> 
> Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
> ---
>  tools/lib/perf/Documentation/libperf.txt |  2 ++
>  tools/lib/perf/evsel.c                   | 10 ++++++++++
>  tools/lib/perf/include/perf/evsel.h      |  1 +
>  3 files changed, 13 insertions(+)
> 
> diff --git a/tools/lib/perf/Documentation/libperf.txt b/tools/lib/perf/Documentation/libperf.txt
> index fcfb9499ef9c..69c1d7efb659 100644
> --- a/tools/lib/perf/Documentation/libperf.txt
> +++ b/tools/lib/perf/Documentation/libperf.txt
> @@ -94,6 +94,8 @@ SYNOPSIS
>    void perf_evlist__enable(struct perf_evlist *evlist);
>    void perf_evlist__disable(struct perf_evlist *evlist);
>  
> +  void perf_evsel__id(struct perf_evsel *evsel, u64 *id);
> +
>    #define perf_evlist__for_each_evsel(evlist, pos)
>  
>    void perf_evlist__set_maps(struct perf_evlist *evlist,
> diff --git a/tools/lib/perf/evsel.c b/tools/lib/perf/evsel.c
> index c07160953224..765b17045342 100644
> --- a/tools/lib/perf/evsel.c
> +++ b/tools/lib/perf/evsel.c
> @@ -484,6 +484,16 @@ int perf_evsel__disable(struct perf_evsel *evsel)
>  	return err;
>  }
>  
> +int perf_evsel__id(struct perf_evsel *evsel, __u64 *id)
> +{
> +	int i;
> +	int err = 0;
> +
> +	for (i = 0; i < xyarray__max_x(evsel->fd) && !err; i++)
> +		err = perf_evsel__run_ioctl(evsel, PERF_EVENT_IOC_ID, (unsigned long)id, i);

IIUC this would update the place pointed by 'id' for every fd then you
will get the last ID only.

Thanks,
Namhyung

> +	return err;
> +}
> +
>  int perf_evsel__apply_filter(struct perf_evsel *evsel, const char *filter)
>  {
>  	int err = 0, i;
> diff --git a/tools/lib/perf/include/perf/evsel.h b/tools/lib/perf/include/perf/evsel.h
> index 6f92204075c2..1457e5a46b28 100644
> --- a/tools/lib/perf/include/perf/evsel.h
> +++ b/tools/lib/perf/include/perf/evsel.h
> @@ -41,6 +41,7 @@ LIBPERF_API int perf_evsel__enable_cpu(struct perf_evsel *evsel, int cpu_map_idx
>  LIBPERF_API int perf_evsel__enable_thread(struct perf_evsel *evsel, int thread);
>  LIBPERF_API int perf_evsel__disable(struct perf_evsel *evsel);
>  LIBPERF_API int perf_evsel__disable_cpu(struct perf_evsel *evsel, int cpu_map_idx);
> +LIBPERF_API int perf_evsel__id(struct perf_evsel *evsel, __u64 *id);
>  LIBPERF_API struct perf_cpu_map *perf_evsel__cpus(struct perf_evsel *evsel);
>  LIBPERF_API struct perf_thread_map *perf_evsel__threads(struct perf_evsel *evsel);
>  LIBPERF_API struct perf_event_attr *perf_evsel__attr(struct perf_evsel *evsel);
> 
> ---
> base-commit: 47ac09b91befbb6a235ab620c32af719f8208399
> change-id: 20240822-perf_evsel_get_id-f7e11f15504b
> -- 
> - Charlie
> 

