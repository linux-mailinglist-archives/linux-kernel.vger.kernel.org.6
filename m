Return-Path: <linux-kernel+bounces-536009-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 863E6A47A6E
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 11:37:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E5573B2BC6
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 10:36:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37B3521D3E7;
	Thu, 27 Feb 2025 10:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LakZS0Tz"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3F7021ABB4
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 10:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740652615; cv=none; b=BHVwLAFKPXNy7QhX6FTBhECA3lhk1z7g0Wr8zySO/AffnLlKZk4xZnUaU+JWghAmUJ1RVAo69KE8ohktrKk1vCGdh+KgfQVeRfdhS3IvN3inK5kWXTQfCkHiT93omYmOVlRRvkzzqZK6btpuY92/b2wYyw2+nw18mIC9jlhGwqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740652615; c=relaxed/simple;
	bh=uzBPdxGSREpu6eSIRPiuVXWgEpF8t4nK9hQGI8ZHwpI=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=Vs76QICLxqOCTf6+HJjah6+M1UGQV2H4RioRv1Yl/1gCT0dExuGHCtFw/DkZIuXiZgmqajYRYOro/xwRs+rMswRjK3utxiHxCcoPk2FQ4BAwewnyOfJ9qI1lMTWSsaxEUuLaYF3IYyXOaRLfTyg/LxYxnPSfxKLJ4cmKvcDfSiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=LakZS0Tz; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-abbd96bef64so134708466b.3
        for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 02:36:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740652612; x=1741257412; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:cc:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jsFKh9UbkZa4mPXu6xn2EHAIINbDdqAyML0CYYvfpfc=;
        b=LakZS0TzxlinrFp1LptazAhUETSPShv3FBIj1Wi/SmnLzADHGKKyQMAcBMAIKKwSmq
         0pDOGzyv2UF4zrVX5yWbexbf8V4i+2eH6vlIRLMNJ802y7IwxKOM1Kvw6igyThHsCwFB
         eX0E5zxFghBtyZ+HqykNQCCmlc8qekHByvPFjv1Ovxl+84zTEVYEYukp2hrxYAtUnoP2
         l4pk2R/Pib2VnAjvrXprG7eI6z3xYz45J97e5b/v6CDq5ULYg9E3yUcmjLh8neUWFO2b
         qFMVy0YPRilTxgFDtISveM4NSmg7UOiC3Aq8dvQwaxddbNIeGBq8ZTKShUrHZTmhjsJf
         eVDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740652612; x=1741257412;
        h=content-transfer-encoding:in-reply-to:from:cc:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jsFKh9UbkZa4mPXu6xn2EHAIINbDdqAyML0CYYvfpfc=;
        b=NmyoeHvBJspXrHE36IeUecGMswhX4PVxKh+Y32SeI7eIAWAHz100HVb1l5xQfqklsJ
         vu/XrDHAOzlxs+DfW3QPDB0lXcnOwRHAbRO8IT0S1WK8xZii0/yj5Ymu9ethCB5Y4lgV
         5MB+yvWY4lQGYJw7V9qVhuJl6+xv7UZr48aUhpO1ZLRCgxooRZ1Tx6gIadh9n7EKaPJt
         OBN+9ZIvTS3Jn9QQWRAqN+XUjHFJ1sUiwel0NBB4bGY0UexEfmkGzojs4n9mWglOfCEP
         6It9C7LbQj95Y5/vH63OO1Sdr6CETj0sovS294x63WpGFKeLD9Fh/fzAzibZoA3BOSyE
         WLzg==
X-Forwarded-Encrypted: i=1; AJvYcCWW6+o7IKFsxCX0J8Uj7Zw6ZINjVfv//eIA+Z1J9bnDqcY9oHDNhGuqZ/pUl+hBwvAX6KA5pco7F2/C3GM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzlVuushl+FdpeF/OLuPW3/XqA+p5jgbbXxI+TKEE94d0qzYwCM
	ee+xjh/OU9InwwYatXfyNmLHv+HeMQmNbOBUkHmlQKQsfyINOhEQ3Lbmp9725L8=
X-Gm-Gg: ASbGncs6gUDUzdMwrrx/i4FHjCSWhP8in3zLdXkKjidHcMUU5U0zMryOni3n4jHEjO7
	Vskq+sZDpX8k1u8m4Pm9US05dz3O2fNbSy6QcvzljaOPgLdzJEOLGh3vENXpLHr+I4vKJIkhcWA
	haeFwuVzNu+irEpbYywECWXrDG32T3KqrYMjIBPHXcVuUfnE5vTlFb1GlcMDsCY/OxBlxdUbiPd
	yWXjFrykr/CorPgEeXwYhkeEKntVqXyaHujLnGfFnkDcH4fvQbda3zvv3uWZUF80qlHGsc/4F6D
	ilG3yLxiiIqCI/URzbRaFhFFv+Ri3mnwog==
X-Google-Smtp-Source: AGHT+IEsSfiZIs400KhlsV64WxdFbebZ9xtk3b00PNEdGcSXHdqx0XdTR9/OXY1rEFnEmYXIsXcKzQ==
X-Received: by 2002:a17:906:6a20:b0:ab7:e451:4834 with SMTP id a640c23a62f3a-abed0d117bamr1339096666b.19.1740652612039;
        Thu, 27 Feb 2025 02:36:52 -0800 (PST)
Received: from [192.168.1.247] ([145.224.66.72])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abf0c6ed7ccsm101865366b.96.2025.02.27.02.36.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Feb 2025 02:36:51 -0800 (PST)
Message-ID: <7c3e1316-a4a6-4a9e-b179-57e9c8aca697@linaro.org>
Date: Thu, 27 Feb 2025 10:36:50 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] perf arm-spe: Report error if set frequency
To: Leo Yan <leo.yan@arm.com>
References: <20250227085544.2154136-1-leo.yan@arm.com>
Content-Language: en-US
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Will Deacon <will@kernel.org>,
 Mike Leach <mike.leach@linaro.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>,
 "Liang, Kan" <kan.liang@linux.intel.com>,
 linux-arm-kernel@lists.infradead.org, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org
From: James Clark <james.clark@linaro.org>
In-Reply-To: <20250227085544.2154136-1-leo.yan@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 27/02/2025 8:55 am, Leo Yan wrote:
> When users set the parameter '-F' to specify frequency for Arm SPE, the
> tool reports error:
> 
>    perf record -F 1000 -e arm_spe_0// -- sleep 1
>    Error:
>    Invalid event (arm_spe_0//) in per-thread mode, enable system wide with '-a'.
> 
> The output logs are confused and it does not give the correct reminding.
> Arm SPE does not support frequency setting given it adopts a statistical
> based approach.
> 
> Alternatively, Arm SPE supports setting period.  This commit adds a
> for frequency setting.  It reports error and reminds users to set period
> instead.
> 
> After:
> 
>    perf record -F 1000 -e arm_spe_0// -- sleep 1
>    Arm SPE: Frequency is not supported. Set period with -c option or PMU parameter (-e arm_spe_0/period=NUM/).
> 
> Signed-off-by: Leo Yan <leo.yan@arm.com>
> ---
> 
> Changes from v1:
> - Sugguested users for '-c' option or PMU parameter 'period' in the log
>    (Namhyung)
> 
>   tools/perf/arch/arm64/util/arm-spe.c | 21 +++++++++++++++++++++
>   1 file changed, 21 insertions(+)
> 
> diff --git a/tools/perf/arch/arm64/util/arm-spe.c b/tools/perf/arch/arm64/util/arm-spe.c
> index 4301181b8e45..4f2833b62ff5 100644
> --- a/tools/perf/arch/arm64/util/arm-spe.c
> +++ b/tools/perf/arch/arm64/util/arm-spe.c
> @@ -40,6 +40,19 @@ struct arm_spe_recording {
>   	bool			*wrapped;
>   };
>   
> +/* Iterate config list to detect if the "freq" parameter is set */
> +static bool arm_spe_is_set_freq(struct evsel *evsel)
> +{
> +	struct evsel_config_term *term;
> +
> +	list_for_each_entry(term, &evsel->config_terms, list) {
> +		if (term->type == EVSEL__CONFIG_TERM_FREQ)
> +			return true;
> +	}
> +
> +	return false;
> +}
> +
>   /*
>    * arm_spe_find_cpus() returns a new cpu map, and the caller should invoke
>    * perf_cpu_map__put() to release the map after use.
> @@ -389,6 +402,14 @@ static int arm_spe_recording_options(struct auxtrace_record *itr,
>   				return -EINVAL;
>   			}
>   			opts->full_auxtrace = true;
> +
> +			if (opts->user_freq != UINT_MAX ||
> +			    arm_spe_is_set_freq(evsel)) {
> +				pr_err("Arm SPE: Frequency is not supported. "
> +				       "Set period with -c option or PMU parameter (-e %s/period=NUM/).\n",
> +				       evsel->pmu->name);
> +				return -EINVAL;
> +			}
>   		}
>   	}
>   

Reviewed-by: James Clark <james.clark@linaro.org>


