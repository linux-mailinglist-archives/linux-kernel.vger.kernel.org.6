Return-Path: <linux-kernel+bounces-280536-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 922E894CBD5
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 10:02:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A43A281DC2
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 08:02:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C43AD18C330;
	Fri,  9 Aug 2024 08:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XHqPD4eP"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74930176226
	for <linux-kernel@vger.kernel.org>; Fri,  9 Aug 2024 08:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723190549; cv=none; b=qa2HU7y7OJyevgxN73ehZSqBpHT1QRHqZ0vm8Tl6FrvIvlT7KOytaENOlvpGJIG2trSrMyYztnZVYW3FF4CxVWTRT7XiU9KtX7cTqNwAkc7Cug3Bhy6hnkpSuk+CggIqqAre9GVNItRNxMb151deSRmGHmRQ1Ka6k6T/TuoPL9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723190549; c=relaxed/simple;
	bh=ENK3u/CP8UssvX6x0cSp1prUpMVN00yAwpWAYkhHIAs=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=QmeIQBjhNg9pbZu2PTv3NsL6hDVKG2OF/FPbO47ka67G5w9wBIBMl2aRzA6fpepghchRFGSRCHMFO8j/NAcxUKr5GPTLBmx7syxThDWxoojCatD+hKjLSnehxGW10OSjdtFAi/d1ejcuKepSoUlf3DgmBT1lNkyLVuEetkAjUPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XHqPD4eP; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723190547; x=1754726547;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=ENK3u/CP8UssvX6x0cSp1prUpMVN00yAwpWAYkhHIAs=;
  b=XHqPD4ePcj7Ic+1xIhmbFhXb04PZ67miqNb+u3ExoFITzm7gVtWos+dA
   ohV8bGmOyCs0K9OrsSw7z9UUGN8QwoweMoB8GsqSbAyFNiHVnof/Mg7dJ
   0gedJ3LoObTYNOObtdan8O1xCqq1qP3I4j9nbR4m7Tw1LlxQzr7eABDyY
   MD+IBQigonGlOgoxEDw4ZgcILWUhWAqgnOK+NRQOnSCJxb0wQMAktcV2x
   o/es01OS9Vs+fRAuzq13n0UofEY/9IBEraeluhGeJf7tS6QK2RMNokMGU
   1n9outUHaUMjQB6C1lyeVDhVwOhZalUJbaib2V/PMfkfKaDey+Js9QGfz
   g==;
X-CSE-ConnectionGUID: 1EjsAgTASOuefNwHeQ9XUA==
X-CSE-MsgGUID: bxU9bs1xTM2xAa7b3iSlvw==
X-IronPort-AV: E=McAfee;i="6700,10204,11158"; a="32501475"
X-IronPort-AV: E=Sophos;i="6.09,275,1716274800"; 
   d="scan'208";a="32501475"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2024 01:02:26 -0700
X-CSE-ConnectionGUID: GmjCZ/GTRaaJT3OtCUzJYQ==
X-CSE-MsgGUID: puesm/uTTFSKmncy7WDVIA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,275,1716274800"; 
   d="scan'208";a="57369225"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.245.197.217])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2024 01:02:23 -0700
Message-ID: <53c51dfc-9727-4e11-8846-6f37bc64744a@intel.com>
Date: Fri, 9 Aug 2024 11:02:16 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/9] perf auxtrace: Remove unused 'pmu' pointer from
 struct auxtrace_record
To: Leo Yan <leo.yan@arm.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>,
 James Clark <james.clark@linaro.org>,
 Suzuki K Poulose <suzuki.poulose@arm.com>, Mike Leach
 <mike.leach@linaro.org>, coresight@lists.linaro.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 "Liang, Kan" <kan.liang@linux.intel.com>
References: <20240806204130.720977-1-leo.yan@arm.com>
 <20240806204130.720977-3-leo.yan@arm.com>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20240806204130.720977-3-leo.yan@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/08/24 23:41, Leo Yan wrote:
> The 'pmu' pointer in the auxtrace_record structure is not used after
> support multiple AUX events, remove it.
> 
> Signed-off-by: Leo Yan <leo.yan@arm.com>

Reviewed-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  tools/perf/arch/arm/util/cs-etm.c     | 1 -
>  tools/perf/arch/arm64/util/arm-spe.c  | 1 -
>  tools/perf/arch/arm64/util/hisi-ptt.c | 1 -
>  tools/perf/arch/x86/util/intel-bts.c  | 1 -
>  tools/perf/arch/x86/util/intel-pt.c   | 1 -
>  tools/perf/util/auxtrace.h            | 1 -
>  6 files changed, 6 deletions(-)
> 
> diff --git a/tools/perf/arch/arm/util/cs-etm.c b/tools/perf/arch/arm/util/cs-etm.c
> index da6231367993..96aeb7cdbee1 100644
> --- a/tools/perf/arch/arm/util/cs-etm.c
> +++ b/tools/perf/arch/arm/util/cs-etm.c
> @@ -888,7 +888,6 @@ struct auxtrace_record *cs_etm_record_init(int *err)
>  	}
>  
>  	ptr->cs_etm_pmu			= cs_etm_pmu;
> -	ptr->itr.pmu			= cs_etm_pmu;
>  	ptr->itr.parse_snapshot_options	= cs_etm_parse_snapshot_options;
>  	ptr->itr.recording_options	= cs_etm_recording_options;
>  	ptr->itr.info_priv_size		= cs_etm_info_priv_size;
> diff --git a/tools/perf/arch/arm64/util/arm-spe.c b/tools/perf/arch/arm64/util/arm-spe.c
> index d59f6ca499f2..2be99fdf997d 100644
> --- a/tools/perf/arch/arm64/util/arm-spe.c
> +++ b/tools/perf/arch/arm64/util/arm-spe.c
> @@ -514,7 +514,6 @@ struct auxtrace_record *arm_spe_recording_init(int *err,
>  	}
>  
>  	sper->arm_spe_pmu = arm_spe_pmu;
> -	sper->itr.pmu = arm_spe_pmu;
>  	sper->itr.snapshot_start = arm_spe_snapshot_start;
>  	sper->itr.snapshot_finish = arm_spe_snapshot_finish;
>  	sper->itr.find_snapshot = arm_spe_find_snapshot;
> diff --git a/tools/perf/arch/arm64/util/hisi-ptt.c b/tools/perf/arch/arm64/util/hisi-ptt.c
> index ba97c8a562a0..eac9739c87e6 100644
> --- a/tools/perf/arch/arm64/util/hisi-ptt.c
> +++ b/tools/perf/arch/arm64/util/hisi-ptt.c
> @@ -174,7 +174,6 @@ struct auxtrace_record *hisi_ptt_recording_init(int *err,
>  	}
>  
>  	pttr->hisi_ptt_pmu = hisi_ptt_pmu;
> -	pttr->itr.pmu = hisi_ptt_pmu;
>  	pttr->itr.recording_options = hisi_ptt_recording_options;
>  	pttr->itr.info_priv_size = hisi_ptt_info_priv_size;
>  	pttr->itr.info_fill = hisi_ptt_info_fill;
> diff --git a/tools/perf/arch/x86/util/intel-bts.c b/tools/perf/arch/x86/util/intel-bts.c
> index 34696f3d3d5d..85c8186300c8 100644
> --- a/tools/perf/arch/x86/util/intel-bts.c
> +++ b/tools/perf/arch/x86/util/intel-bts.c
> @@ -434,7 +434,6 @@ struct auxtrace_record *intel_bts_recording_init(int *err)
>  	}
>  
>  	btsr->intel_bts_pmu = intel_bts_pmu;
> -	btsr->itr.pmu = intel_bts_pmu;
>  	btsr->itr.recording_options = intel_bts_recording_options;
>  	btsr->itr.info_priv_size = intel_bts_info_priv_size;
>  	btsr->itr.info_fill = intel_bts_info_fill;
> diff --git a/tools/perf/arch/x86/util/intel-pt.c b/tools/perf/arch/x86/util/intel-pt.c
> index 4b710e875953..ea510a7486b1 100644
> --- a/tools/perf/arch/x86/util/intel-pt.c
> +++ b/tools/perf/arch/x86/util/intel-pt.c
> @@ -1197,7 +1197,6 @@ struct auxtrace_record *intel_pt_recording_init(int *err)
>  	}
>  
>  	ptr->intel_pt_pmu = intel_pt_pmu;
> -	ptr->itr.pmu = intel_pt_pmu;
>  	ptr->itr.recording_options = intel_pt_recording_options;
>  	ptr->itr.info_priv_size = intel_pt_info_priv_size;
>  	ptr->itr.info_fill = intel_pt_info_fill;
> diff --git a/tools/perf/util/auxtrace.h b/tools/perf/util/auxtrace.h
> index 8a6ec9565835..95304368103b 100644
> --- a/tools/perf/util/auxtrace.h
> +++ b/tools/perf/util/auxtrace.h
> @@ -411,7 +411,6 @@ struct auxtrace_record {
>  	int (*read_finish)(struct auxtrace_record *itr, int idx);
>  	unsigned int alignment;
>  	unsigned int default_aux_sample_size;
> -	struct perf_pmu *pmu;
>  	struct evlist *evlist;
>  };
>  


