Return-Path: <linux-kernel+bounces-280526-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8240394CBB2
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 09:55:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 377E21F21F4A
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 07:55:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB67918A95D;
	Fri,  9 Aug 2024 07:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bOzX0ksM"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CD3B1552EB
	for <linux-kernel@vger.kernel.org>; Fri,  9 Aug 2024 07:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723190123; cv=none; b=cL//dgz1rhS284prZGcvInQf0UDVS+8mZWcRNAqWpASQ8IhOpuXLBOdfGsz6fD4Ubj8sSNg3P6Wph1StAifTBvXZ4ivFDhdKAmeDqfsgiRIoZyCMIsRHiMrp+qvt5nBf4jiixHfj6UroA1aHmDA2ucjalA5AYvfeY6a0jjVBau8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723190123; c=relaxed/simple;
	bh=RSx2eWpr1wYdEah1lxHqBl9NBPFaOCsVVnKSUHDiYKc=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=qRiNcJzNZzDi9jrhEvULR/w2F6ENOWAYSwqtvOPiDpqg6nN2AZkcOyaNUv5tv2vBVCNlY1Fh99TyE9SGnGWB7cX4VKYdxuRIRK4DQTIFcB9tTjCerdsZl2/OvpXqfZv8dg5TfCYO7CZGkEld0Sam6l783JTxZlV5XDU3KPtzPms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bOzX0ksM; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723190121; x=1754726121;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=RSx2eWpr1wYdEah1lxHqBl9NBPFaOCsVVnKSUHDiYKc=;
  b=bOzX0ksMpCl+sxbvEZONxCZ1M06JPZ3tCw+BxfJvemWByWplJ5/nlBQi
   qbvRh84k1KNFslCN6BizF8egJdU1naFR4p1htrw+hIBkdNHNJqSnnc5Cr
   s+a/TrQCMDaa6d7bO7vhE1j+YVDT6dFZMhnAWB5x+mRWOHCOOLcQQwM/c
   jhluJV0sj+tWwILHxD4jvlhFP0LHRINE02TeRzTBKgfn+FTMV0rKIVgHP
   GvxIoWHY4gv1EEE+FayckNV376L0OtWIGqQYY5bWf72FLM+adSrxIhM2Y
   jqjbUViaZMx9LdGSW/Y1/Bz2pL8XSZY3Jfs7v34qK/u0mLVQTLRSyBu7b
   A==;
X-CSE-ConnectionGUID: z7qqd7xkQAGLW0IpbP+PXA==
X-CSE-MsgGUID: r8DGPB5sR3maeSBBZMo4Iw==
X-IronPort-AV: E=McAfee;i="6700,10204,11158"; a="21477924"
X-IronPort-AV: E=Sophos;i="6.09,275,1716274800"; 
   d="scan'208";a="21477924"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2024 00:55:21 -0700
X-CSE-ConnectionGUID: sf2mU6w0SDWLRAXC5wMT6w==
X-CSE-MsgGUID: Qt2ST2OjSC2z49DeQcrEzQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,275,1716274800"; 
   d="scan'208";a="57141428"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.245.197.217])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2024 00:55:15 -0700
Message-ID: <391a2bd7-b236-467e-aa68-575201bf7a1d@intel.com>
Date: Fri, 9 Aug 2024 10:55:05 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/9] perf auxtrace: Use evsel__is_aux_event() for
 checking AUX event
To: Leo Yan <leo.yan@arm.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>,
 James Clark <james.clark@linaro.org>,
 Suzuki K Poulose <suzuki.poulose@arm.com>, Mike Leach
 <mike.leach@linaro.org>, coresight@lists.linaro.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 "Liang, Kan" <kan.liang@linux.intel.com>
References: <20240806204130.720977-1-leo.yan@arm.com>
 <20240806204130.720977-2-leo.yan@arm.com>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20240806204130.720977-2-leo.yan@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/08/24 23:41, Leo Yan wrote:
> Use evsel__is_aux_event() to decide if an event is a AUX event, this is
> a refactoring to replace comparing the PMU type.
> 
> Signed-off-by: Leo Yan <leo.yan@arm.com>

Reviewed-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  tools/perf/util/auxtrace.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/perf/util/auxtrace.c b/tools/perf/util/auxtrace.c
> index e2f317063eec..c3f0ef4349fc 100644
> --- a/tools/perf/util/auxtrace.c
> +++ b/tools/perf/util/auxtrace.c
> @@ -671,11 +671,11 @@ int auxtrace_record__read_finish(struct auxtrace_record *itr, int idx)
>  {
>  	struct evsel *evsel;
>  
> -	if (!itr->evlist || !itr->pmu)
> +	if (!itr->evlist)
>  		return -EINVAL;
>  
>  	evlist__for_each_entry(itr->evlist, evsel) {
> -		if (evsel->core.attr.type == itr->pmu->type) {
> +		if (evsel__is_aux_event(evsel)) {
>  			if (evsel->disabled)
>  				return 0;
>  			return evlist__enable_event_idx(itr->evlist, evsel, idx);


