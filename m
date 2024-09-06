Return-Path: <linux-kernel+bounces-318144-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D26E96E8ED
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 07:00:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C01C82865CF
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 05:00:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9779E56458;
	Fri,  6 Sep 2024 04:58:34 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B05754FB5
	for <linux-kernel@vger.kernel.org>; Fri,  6 Sep 2024 04:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725598714; cv=none; b=CBhhXCsGTA3cwkbEsSsGXj0FWLtKD1vcYog4morcxduc+2Qv5DqZtuZCcKzykzTodBqIj/Aeek3Wtq+hO2viZhe43o8ojiEIyMYNF8CEWUw025Dj6G/PvoySQebnhzD5COrSMWLLNj6+CiY6Xj1nv2fB1Qpr5SKmIU37/nwzWBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725598714; c=relaxed/simple;
	bh=6NNFAQTSF6IMXbgi+DbosHlqUy4RCVU10ccpHd+yqX8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uOKRmp/tMlSDPwWc/sL9mPGavElPB29r8gU0TyGNnD7bXEQl1+cqgkrYB6NCwmkHDYw5m+WtM27zdeZY5DbPKCyrTP/GQbOK0qgG4wlAmN04hLuUO0u8nI1te+mhEIc6YudgiPze7lIc8TSK9YsIO6TSB4BvXKYPIYDaHOQ73wg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6ED7BFEC;
	Thu,  5 Sep 2024 21:58:56 -0700 (PDT)
Received: from [10.163.60.122] (unknown [10.163.60.122])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D16F73F73F;
	Thu,  5 Sep 2024 21:58:27 -0700 (PDT)
Message-ID: <f632d5c8-93db-402c-82ec-9f3b79906458@arm.com>
Date: Fri, 6 Sep 2024 10:28:29 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf: arm_pmuv3: Use BR_RETIRED for HW branch event if
 enabled
To: Ilkka Koskinen <ilkka@os.amperecomputing.com>,
 Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20240905204732.20546-1-ilkka@os.amperecomputing.com>
Content-Language: en-US
From: Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <20240905204732.20546-1-ilkka@os.amperecomputing.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 9/6/24 02:17, Ilkka Koskinen wrote:
> The PMU driver attempts to use PC_WRITE_RETIRED for the HW branch event,
> if enabled. However, PC_WRITE_RETIRED counts only taken branches,
> whereas BR_RETIRED counts also non-taken ones.
> 
> Furthermore, perf uses HW branch event to calculate branch misses ratio,
> implying BR_RETIRED is the correct event to count.
But is the event BR_RETIRED always guaranteed to be available. Should not
armpmu->pmceid_bitmap be checked first ?

> 
> Signed-off-by: Ilkka Koskinen <ilkka@os.amperecomputing.com>
> ---
>  drivers/perf/arm_pmuv3.c | 27 ++++-----------------------
>  1 file changed, 4 insertions(+), 23 deletions(-)
> 
> diff --git a/drivers/perf/arm_pmuv3.c b/drivers/perf/arm_pmuv3.c
> index d246840797b6..a8ed08df1411 100644
> --- a/drivers/perf/arm_pmuv3.c
> +++ b/drivers/perf/arm_pmuv3.c
> @@ -46,6 +46,7 @@ static const unsigned armv8_pmuv3_perf_map[PERF_COUNT_HW_MAX] = {
>  	[PERF_COUNT_HW_INSTRUCTIONS]		= ARMV8_PMUV3_PERFCTR_INST_RETIRED,
>  	[PERF_COUNT_HW_CACHE_REFERENCES]	= ARMV8_PMUV3_PERFCTR_L1D_CACHE,
>  	[PERF_COUNT_HW_CACHE_MISSES]		= ARMV8_PMUV3_PERFCTR_L1D_CACHE_REFILL,
> +	[PERF_COUNT_HW_BRANCH_INSTRUCTIONS]	= ARMV8_PMUV3_PERFCTR_BR_RETIRED,
>  	[PERF_COUNT_HW_BRANCH_MISSES]		= ARMV8_PMUV3_PERFCTR_BR_MIS_PRED,
>  	[PERF_COUNT_HW_BUS_CYCLES]		= ARMV8_PMUV3_PERFCTR_BUS_CYCLES,
>  	[PERF_COUNT_HW_STALLED_CYCLES_FRONTEND]	= ARMV8_PMUV3_PERFCTR_STALL_FRONTEND,
> @@ -1083,28 +1084,6 @@ static void armv8pmu_reset(void *info)
>  	armv8pmu_pmcr_write(pmcr);
>  }
>  
> -static int __armv8_pmuv3_map_event_id(struct arm_pmu *armpmu,
> -				      struct perf_event *event)
> -{
> -	if (event->attr.type == PERF_TYPE_HARDWARE &&
> -	    event->attr.config == PERF_COUNT_HW_BRANCH_INSTRUCTIONS) {
> -
> -		if (test_bit(ARMV8_PMUV3_PERFCTR_PC_WRITE_RETIRED,
> -			     armpmu->pmceid_bitmap))
> -			return ARMV8_PMUV3_PERFCTR_PC_WRITE_RETIRED;
> -
> -		if (test_bit(ARMV8_PMUV3_PERFCTR_BR_RETIRED,
> -			     armpmu->pmceid_bitmap))
> -			return ARMV8_PMUV3_PERFCTR_BR_RETIRED;

If BR_RETIRED event is absent on the platform, PC_WRITE_RETIRED still remains
a good alternative to fallback on. Hence wondering if the above order could
just be changed to use BR_RETIRED first when available.

> -
> -		return HW_OP_UNSUPPORTED;
> -	}
> -
> -	return armpmu_map_event(event, &armv8_pmuv3_perf_map,
> -				&armv8_pmuv3_perf_cache_map,
> -				ARMV8_PMU_EVTYPE_EVENT);
> -}
> -
>  static int __armv8_pmuv3_map_event(struct perf_event *event,
>  				   const unsigned (*extra_event_map)
>  						  [PERF_COUNT_HW_MAX],
> @@ -1116,7 +1095,9 @@ static int __armv8_pmuv3_map_event(struct perf_event *event,
>  	int hw_event_id;
>  	struct arm_pmu *armpmu = to_arm_pmu(event->pmu);
>  
> -	hw_event_id = __armv8_pmuv3_map_event_id(armpmu, event);
> +	hw_event_id = armpmu_map_event(event, &armv8_pmuv3_perf_map,
> +				       &armv8_pmuv3_perf_cache_map,
> +				       ARMV8_PMU_EVTYPE_EVENT);
>  
>  	/*
>  	 * CHAIN events only work when paired with an adjacent counter, and it

