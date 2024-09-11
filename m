Return-Path: <linux-kernel+bounces-324626-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 47B75974EF2
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 11:45:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C563289A9E
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 09:45:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EC36184551;
	Wed, 11 Sep 2024 09:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="F6/nHtKH"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEE0B155758
	for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 09:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726047910; cv=none; b=hBY4VokVuUh7RImlem5DVsuFw9mChC94DM8Lhaxpbixhy3X6TSplkf0gl6+ade+n7M28zp6qQI6xp8lu26V3Tv2q5PyAp2ZcMvAW+yP5CHPC8/nhMcGnk3OcRCpTZbMlGJ9kmqFyZImXL5QVY3rn+3rXdEGD+Fdxmh9//OVUGyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726047910; c=relaxed/simple;
	bh=HbvCf2201rlCiYWUGZXa8hrWPWUEdpCqwLCY6YaIimo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HeLgBxaJqVO3kBfJ192RdyTXOaMkXrV/t8AfbFk26J8jQWZ70DxRShsjvCpkKnRONpNkXs9jD+7vy2ertuK7tnJmplRuVHSmV8MCcJHJb/muVDZHgj85btdhto8w0IUzsFNSDq8lOBcZQebtDiSFEIqTlXIgfYWDqRxHv7dXZKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=F6/nHtKH; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-42cafda818aso40362255e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 02:45:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1726047907; x=1726652707; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gue4qaTI8QiVGn2E5BdIJ10PDgpNtCS7+q74iHgYmk8=;
        b=F6/nHtKHbga8smQD4UApUi7mjyP1Bqrxed1BMUqjKCK6U1gBQn82rD0OXZWiLd88PE
         j4eDOZcRdLsFXsQBUqHEfihATrbm31zqctyILY2tTyoBsMcyYMM81N7De62zre+pljcX
         EKXnUa0ilzqBu9KTOo9tfx0TsrqV8vud1IZIt7LXe+CceQ4/RoaUhA82zhU8GJ1HN5YZ
         PrXTq9cs75SDj+CohK3gwY+3Ao36nyNcNO0rZyHauvo9EZhYcGOuhTtrruMbtiQbrwje
         Uj+fJguluZ62kBbTFhkzlD3XNTui0lPX0WNUkIRzeQly9alKR5EEcP23UPx6phkt3fcx
         ondA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726047907; x=1726652707;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gue4qaTI8QiVGn2E5BdIJ10PDgpNtCS7+q74iHgYmk8=;
        b=X22WXcvGJolHGJeiN5WQhih9aotm75UgTsmp2v3RJ8e4sH/cY2IRjinu0zD5GdQsx5
         kSn+3IZi1qzghV4TDu4ggiz3hprJTci2xjyc+cHR3sJcQ8wa8h/6+D11Bujhinw/djGC
         Wjq3CQuqyfsUufc4T480GY26CMBT5PtOySiMzjyBkfZ1B+zehwmx4uawz2M5JxcJ0ZOq
         SW/D78aqYQMKDvRerSJROtUbWfimMKYug9qMOD6JRWLS8bpa0j5CglyJpFNSd5ejlgRm
         aD08RLtdI3ogREhBitqa5KllvZjBtTcacCDDx0cEENSCcoSHyGW1+prfl9zEOOZbq3Pp
         YFWA==
X-Forwarded-Encrypted: i=1; AJvYcCWCee4v9fJhS1cZhbfUXOBejvoVoUIJZzZs93HhXax9k1jx2Fj8xTonZGCfjR/FNnio/CS/rcFpCmdNkEI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHCp80BMZ81Gv0N+FBNxQFGE5azpuhcGomE0rtOqmsI3T96Vqs
	EGI4gEQd9ymtjFLkjqxDVSbnnKjxfWOI/EPvMbZeryt40QBTeAoM4XiZxwokaeo=
X-Google-Smtp-Source: AGHT+IHWW2BOCOUSxSnw3LpxP0BBwi783RZeFXOJkye4XyzKNPrR3uraEVfYW7VpMiN9f3L/uEnOYQ==
X-Received: by 2002:a05:600c:1f90:b0:425:7c95:75d0 with SMTP id 5b1f17b1804b1-42c9f9850d1mr132773265e9.18.1726047906431;
        Wed, 11 Sep 2024 02:45:06 -0700 (PDT)
Received: from [192.168.1.61] ([84.67.228.188])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42caeb32b0csm136294375e9.18.2024.09.11.02.45.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Sep 2024 02:45:06 -0700 (PDT)
Message-ID: <4fa0229e-630b-4b6e-8882-3d8a5793a9dd@linaro.org>
Date: Wed, 11 Sep 2024 10:45:16 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf ftrace: Detect whether ftrace is enabled on system
To: Changbin Du <changbin.du@huawei.com>
Cc: Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>,
 "Liang, Kan" <kan.liang@linux.intel.com>, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>
References: <20240910033625.3569729-1-changbin.du@huawei.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <20240910033625.3569729-1-changbin.du@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 10/09/2024 04:36, Changbin Du wrote:
> To make error messages more accurate, this change detects whether ftrace is
> enabled on system by checking trace file "set_ftrace_pid".
> 
> Before:
> ~ # perf ftrace
> failed to reset ftrace
> 
> After:
> ~ # perf ftrace
> ftrace is not supported on this system
> 
> Signed-off-by: Changbin Du <changbin.du@huawei.com>
> ---
>   tools/perf/builtin-ftrace.c | 24 ++++++++++++++++++++++++
>   1 file changed, 24 insertions(+)
> 
> diff --git a/tools/perf/builtin-ftrace.c b/tools/perf/builtin-ftrace.c
> index eb30c8eca488..e1dc2768bc0f 100644
> --- a/tools/perf/builtin-ftrace.c
> +++ b/tools/perf/builtin-ftrace.c
> @@ -1112,6 +1112,24 @@ static int parse_graph_tracer_opts(const struct option *opt,
>   	return 0;
>   }
>   
> +static bool is_ftrace_supported(void)
> +{
> +	char *file;
> +	bool supported = false;
> +
> +	file = get_tracing_file("set_ftrace_pid");
> +	if (!file) {
> +		pr_debug("cannot get tracing file set_ftrace_pid\n");
> +		return false;
> +	}
> +
> +	if (!access(file, F_OK))
> +		supported = true;
> +
> +	put_tracing_file(file);
> +	return supported;
> +}
> +
>   enum perf_ftrace_subcommand {
>   	PERF_FTRACE_NONE,
>   	PERF_FTRACE_TRACE,
> @@ -1254,6 +1272,12 @@ int cmd_ftrace(int argc, const char **argv)
>   		goto out_delete_filters;
>   	}
>   
> +	if (!is_ftrace_supported()) {
> +		pr_err("ftrace is not supported on this system\n");
> +		ret = -ENOTSUP;
> +		goto out_delete_filters;
> +	}
> +

Very minor nit, but you could probably put this earlier next to 
check_ftrace_capable(). It didn't look like it used any of the config or 
parsing results.

Either way:

Reviewed-by: James Clark <james.clark@linaro.org>

