Return-Path: <linux-kernel+bounces-236721-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DB8191E648
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 19:11:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9EEA81C22339
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 17:11:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F6D616E87A;
	Mon,  1 Jul 2024 17:11:30 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C594916E861;
	Mon,  1 Jul 2024 17:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719853889; cv=none; b=oEPuDZHPKFNMibVOnWFEbmpFBy60bgFYpJ+XLbiCrSU9hbOYBdOsQ3L9QZx8Vtj3yYFs53oa1izk5Qpt8vtmEn5JmN94zQCaZZjqddgQTXOOzm7CssKOkta9f53zUfuwnZ12Kg4zjdyyd14ZRUfF0I+FWn96YITtRDINWQoMGYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719853889; c=relaxed/simple;
	bh=cQOKEl8T347wYcKXSrP4L6cvaIFsGG1xGX+1gP9kIOQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gqr9yrSGhOPc8OOTeaS6KHEDPWmOTpmiM5zBVfKtEOEGEZWH7xGn3+EZ1ct7NjQdaBwT9Wl0ulYyl+RQRQRh8l7bp7lyFL90n1cVk/aKhKHZ6d0Cprs8/LOrOiyAILhCdm1K6GLUPklvVal5fyQ63UG+FOSPUBi8oOTd2Tj1pP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5FD8D339;
	Mon,  1 Jul 2024 10:11:52 -0700 (PDT)
Received: from J2N7QTR9R3 (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 614463F766;
	Mon,  1 Jul 2024 10:11:24 -0700 (PDT)
Date: Mon, 1 Jul 2024 18:11:21 +0100
From: Mark Rutland <mark.rutland@arm.com>
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Russell King <linux@armlinux.org.uk>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
	Oliver Upton <oliver.upton@linux.dev>,
	James Morse <james.morse@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Zenghui Yu <yuzenghui@huawei.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	James Clark <james.clark@arm.com>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org, kvmarm@lists.linux.dev
Subject: Re: [PATCH v2 02/12] perf: arm_pmuv3: Drop unnecessary
 IS_ENABLED(CONFIG_ARM64) check
Message-ID: <ZoLjOTs2ywnw5v_x@J2N7QTR9R3>
References: <20240626-arm-pmu-3-9-icntr-v2-0-c9784b4f4065@kernel.org>
 <20240626-arm-pmu-3-9-icntr-v2-2-c9784b4f4065@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240626-arm-pmu-3-9-icntr-v2-2-c9784b4f4065@kernel.org>

On Wed, Jun 26, 2024 at 04:32:26PM -0600, Rob Herring (Arm) wrote:
> The IS_ENABLED(CONFIG_ARM64) check for threshold support is unnecessary.
> The purpose is to not enable thresholds on arm32, but if threshold is
> non-zero, the check against threshold_max() just above here will have
> errored out because threshold_max() is always 0 on arm32.
> 
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>

Acked-by: Mark rutland <mark.rutland@arm.com>

Mark.

> ---
> v2:
>  - new patch
> ---
>  drivers/perf/arm_pmuv3.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/perf/arm_pmuv3.c b/drivers/perf/arm_pmuv3.c
> index 8ed5c3358920..3e51cd7062b9 100644
> --- a/drivers/perf/arm_pmuv3.c
> +++ b/drivers/perf/arm_pmuv3.c
> @@ -1045,7 +1045,7 @@ static int armv8pmu_set_event_filter(struct hw_perf_event *event,
>  		return -EINVAL;
>  	}
>  
> -	if (IS_ENABLED(CONFIG_ARM64) && th) {
> +	if (th) {
>  		config_base |= FIELD_PREP(ARMV8_PMU_EVTYPE_TH, th);
>  		config_base |= FIELD_PREP(ARMV8_PMU_EVTYPE_TC,
>  					  armv8pmu_event_threshold_control(attr));
> 
> -- 
> 2.43.0
> 

