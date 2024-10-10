Return-Path: <linux-kernel+bounces-359178-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B10ED998864
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 15:54:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 357861F24526
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 13:54:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAD331C9DE6;
	Thu, 10 Oct 2024 13:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zr2T0mgk"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7507A1C3F15
	for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 13:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728568424; cv=none; b=XqO8czuLMIza6+e7BKLdbuYwcNp8F27tZzpzr8chKIetCac8y/H++gzDLUdW8J6P6Ka0ayV9JU+6SbSiwq9V9JizxMb3mdpkpOZPA/wCsFB2/ordp7q+mk+QCqtUQDJpVZbvPMr8qm6YFMvOJcBWRTLvl3LOhl5VYQGu4dvIG8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728568424; c=relaxed/simple;
	bh=xQBn55PN23aO9670OjnpZ+dbvgmFwudgJXE9e0tDqI4=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=daOjPrmC51hUTd9H0kv1tcayBLFpWd5bkXPhDPjkPNDNk5ZIuB+Sl3dx55pKk9v5qLlPlDAutIK+OLZIG1YnF1Yf2dR+kBa8NZDbgBxKepfvfj3O6lNtTm1L6o2Vxtj84mFt/SxHOeWijFKP4cGgcU1/OKoT/vV4wfzU31vvDwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=zr2T0mgk; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-43117ed8adbso7351025e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 06:53:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728568421; x=1729173221; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:cc:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ZZWASQJRTemAf/zxW7UcNYsAfxwrSESa7YfVw9wIktk=;
        b=zr2T0mgkzfiJ6nH61rXD0w9XvkV5KOZ/P5ElHS7BsXRb+t6P6YUmmT24TAR6SuD0YM
         tRM4tf/pddwJH/MsEzJj8UPQNO+tYQpnyVkJcu8fxrPQNLE/V16F0u0KMOLTNL+LYPV/
         K1gqYLQIEEGa5PeYXU/4vQ4gQpHW7M53GpqXZbU5KqUTjSwwiYO5OlIcEIItlHjAaJCR
         p/Je49HO4KnWwm7j70Vke0/SnKN0oFXofZUcxHMQey9z3p6pYX4Qo5OkSXfM2JktuHKk
         KUO0uBY+yAZHndYcfSHzAMvQRymJNRG3IF/Tyjk+qHJceEIpK1X+TOdYckLwzmBNjmEX
         SgUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728568421; x=1729173221;
        h=content-transfer-encoding:in-reply-to:from:cc:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZZWASQJRTemAf/zxW7UcNYsAfxwrSESa7YfVw9wIktk=;
        b=HjWuhwlc4Y/7s6eGForlfIOgqPSMkVINugofTygxsJ/rAxb+PKGSt1iv72T1MSM1sX
         JSusSrT++ZeZoTAXiwggC6vQkYtzq1IjCWMFXVQCnOsZzGnlNfq6i3t4VZncL5t4rgT/
         KkYe2TBJcqswav7U1dnXioFd6zGLeEHCf1r2LVoIOh5M/Aeom6EviL9SsD75nXRb6eyK
         AGKWTvE38E0o3Hph/RWIT5U3XlZ31XNMbSqTn9dlWDOtZf7FJ6jmc5vmQhp4kFjLSwGR
         WYHv0tOvTM9lPiSIDWcd3w5GirWCBwkdkMAm9T2GMxFgbFerbdqMAI+qm2WtVZ9ZXl2a
         1m9Q==
X-Forwarded-Encrypted: i=1; AJvYcCWm1sl/yb/9i9dWh1dNPlGQLdFMDIQBTU4Nt6Jq7S8hAh0JIOJtNTRR0yNEQnHgDVkf6iINTnUiW5oE710=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxy9xOl4uUeiu2C/nujH+dbI9tzL6QgzmECXDSpd/+3AbAKaIqT
	40a522bagefwBaY6H33dM9D9ovmgjCzEPwXGBqGi9JDMCojNFeV0dEvS0wvs8v8=
X-Google-Smtp-Source: AGHT+IEeAJA5sdaCjGTwxs4gLczR4r2Ovs8C0vOUYnCLqOz3bZD5qg7zVil2Ky5cHBPgaIUQEIppKw==
X-Received: by 2002:a05:600c:1f0d:b0:430:85be:32cb with SMTP id 5b1f17b1804b1-430ccf4f5camr57977055e9.18.1728568420734;
        Thu, 10 Oct 2024 06:53:40 -0700 (PDT)
Received: from [192.168.1.3] ([89.47.253.130])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d4b6a8227sm1626662f8f.17.2024.10.10.06.53.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Oct 2024 06:53:40 -0700 (PDT)
Message-ID: <555fbea8-7103-4de1-bcd5-accc9c649e62@linaro.org>
Date: Thu, 10 Oct 2024 14:53:38 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/7] perf arm-spe: Use metadata to decide the data
 source feature
To: Leo Yan <leo.yan@arm.com>
References: <20241003185322.192357-1-leo.yan@arm.com>
 <20241003185322.192357-5-leo.yan@arm.com>
Content-Language: en-US
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Besar Wicaksono <bwicaksono@nvidia.com>,
 Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>,
 "Liang, Kan" <kan.liang@linux.intel.com>,
 John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>,
 Mike Leach <mike.leach@linaro.org>, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
From: James Clark <james.clark@linaro.org>
In-Reply-To: <20241003185322.192357-5-leo.yan@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 03/10/2024 7:53 pm, Leo Yan wrote:
> Use the info in the metadata to decide if the data source feature is
> supported. The CPU MIDR must be in the CPU list for the common data
> source encoding.
> 
> For the metadata version 1, it doesn't include info for MIDR. In this
> case, due to absent info for making decision, print out warning to
> remind users to upgrade tool and returns false.
> 
> Signed-off-by: Leo Yan <leo.yan@arm.com>
> ---
>   tools/perf/util/arm-spe.c | 67 +++++++++++++++++++++++++++++++++++++--
>   1 file changed, 64 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/perf/util/arm-spe.c b/tools/perf/util/arm-spe.c
> index 587943b6bdb8..9221b2f66bbe 100644
> --- a/tools/perf/util/arm-spe.c
> +++ b/tools/perf/util/arm-spe.c
> @@ -278,6 +278,20 @@ static int arm_spe_set_tid(struct arm_spe_queue *speq, pid_t tid)
>   	return 0;
>   }
>   
> +static u64 *arm_spe__get_metadata_by_cpu(struct arm_spe *spe, u64 cpu)
> +{
> +	u64 i;
> +
> +	if (!spe->metadata)
> +		return NULL;
> +
> +	for (i = 0; i < spe->metadata_nr_cpu; i++)
> +		if (spe->metadata[i][ARM_SPE_CPU] == cpu)
> +			return spe->metadata[i];
> +
> +	return NULL;
> +}
> +
>   static struct simd_flags arm_spe__synth_simd_flags(const struct arm_spe_record *record)
>   {
>   	struct simd_flags simd_flags = {};
> @@ -520,10 +534,57 @@ static void arm_spe__synth_memory_level(const struct arm_spe_record *record,
>   		data_src->mem_lvl |= PERF_MEM_LVL_REM_CCE1;
>   }
>   
> -static u64 arm_spe__synth_data_source(const struct arm_spe_record *record, u64 midr)
> +static bool arm_spe__is_common_ds_encoding(struct arm_spe_queue *speq)
> +{
> +	struct arm_spe *spe = speq->spe;
> +	bool is_in_cpu_list;
> +	u64 *metadata = NULL;
> +	u64 midr = 0;
> +
> +	/*
> +	 * Metadata version 1 doesn't contain any info for MIDR.
> +	 * Simply return false in this case.
> +	 */
> +	if (spe->metadata_ver == 1) {
> +		pr_warning_once("The data file contains metadata version 1, "
> +				"which is absent the info for data source. "
> +				"Please upgrade the tool to record data.\n");
> +		return false;
> +	}
> +
> +	/* CPU ID is -1 for per-thread mode */
> +	if (speq->cpu < 0) {
> +		/*
> +		 * On the heterogeneous system, due to CPU ID is -1,
> +		 * cannot confirm the data source packet is supported.
> +		 */
> +		if (!spe->is_homogeneous)
> +			return false;

Technically you could look at timestamps and context switches to find 
the CPU for non-homogeneous per-thread mode. But it's such an edge case 
I'm not sure it's even worth leaving a TODO for.


