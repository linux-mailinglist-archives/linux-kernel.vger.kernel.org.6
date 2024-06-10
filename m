Return-Path: <linux-kernel+bounces-207938-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 06F83901E31
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 11:30:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B3CD1282B24
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 09:30:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D3DA74C04;
	Mon, 10 Jun 2024 09:30:26 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 689F017BA6;
	Mon, 10 Jun 2024 09:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718011826; cv=none; b=HjOI/3zx2KMHgR87qnUxwTgVLl1Jh7KyALb3KI91yO1eDmvl+BrVywBFRB8XeOYrY8ueW+riYwWTWoqDbp3AxNAa8LuiD2dHJsDVYBtGtS9WIWmLGFL1xmz5nS6+8fe2dqwh1MEKdGZYpXIiimAhhhNxmbP+jmEW7p7TYEOd8hY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718011826; c=relaxed/simple;
	bh=BzOFp0MDhXXy+iCPicy7Sy9fxkKj25CRtqXNxtQwAjo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TMYdpmYwC+Z5LTMnc4g3BdNl30Cydo36BtdZqHWbNjZwuSo3d639tRaeunl4NXGpgY/fnrR/JswXeZRYvKmb2aOCx/ctHGijmRZe1yZDsUXcQM+CO1WJNB/i+DScQLaKS1lyRLMsF9X/Q/UyWPdjH1tXQSs+2gtDvRYOJqzxGlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 45A4312FC;
	Mon, 10 Jun 2024 02:30:47 -0700 (PDT)
Received: from J2N7QTR9R3 (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 731673F73B;
	Mon, 10 Jun 2024 02:30:19 -0700 (PDT)
Date: Mon, 10 Jun 2024 10:30:13 +0100
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
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org, kvmarm@lists.linux.dev
Subject: Re: [PATCH 2/9] perf: arm_v6/7_pmu: Drop non-DT probe support
Message-ID: <ZmbHpTXlSP4T0JqI@J2N7QTR9R3>
References: <20240607-arm-pmu-3-9-icntr-v1-0-c7bd2dceff3b@kernel.org>
 <20240607-arm-pmu-3-9-icntr-v1-2-c7bd2dceff3b@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240607-arm-pmu-3-9-icntr-v1-2-c7bd2dceff3b@kernel.org>

On Fri, Jun 07, 2024 at 02:31:27PM -0600, Rob Herring (Arm) wrote:
> There are no non-DT based PMU users for v6 or v7, so drop the custom
> non-DT probe table.
> 
> Note that this drops support for arm1156 PMU, but there are no arm1156
> based systems supported in the kernel.
> 
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>

It might be worth adding an explciit note that xscale still has non-DT
support, and hence we need to retain the infrastructure for that.

Regardless:

Acked-by: Mark Rutland <mark.rutland@arm.com>

Mark.

> ---
>  drivers/perf/arm_v6_pmu.c | 17 +----------------
>  drivers/perf/arm_v7_pmu.c | 10 +---------
>  2 files changed, 2 insertions(+), 25 deletions(-)
> 
> diff --git a/drivers/perf/arm_v6_pmu.c b/drivers/perf/arm_v6_pmu.c
> index f7593843bb85..0bb685b4bac5 100644
> --- a/drivers/perf/arm_v6_pmu.c
> +++ b/drivers/perf/arm_v6_pmu.c
> @@ -401,13 +401,6 @@ static int armv6_1136_pmu_init(struct arm_pmu *cpu_pmu)
>  	return 0;
>  }
>  
> -static int armv6_1156_pmu_init(struct arm_pmu *cpu_pmu)
> -{
> -	armv6pmu_init(cpu_pmu);
> -	cpu_pmu->name		= "armv6_1156";
> -	return 0;
> -}
> -
>  static int armv6_1176_pmu_init(struct arm_pmu *cpu_pmu)
>  {
>  	armv6pmu_init(cpu_pmu);
> @@ -421,17 +414,9 @@ static const struct of_device_id armv6_pmu_of_device_ids[] = {
>  	{ /* sentinel value */ }
>  };
>  
> -static const struct pmu_probe_info armv6_pmu_probe_table[] = {
> -	ARM_PMU_PROBE(ARM_CPU_PART_ARM1136, armv6_1136_pmu_init),
> -	ARM_PMU_PROBE(ARM_CPU_PART_ARM1156, armv6_1156_pmu_init),
> -	ARM_PMU_PROBE(ARM_CPU_PART_ARM1176, armv6_1176_pmu_init),
> -	{ /* sentinel value */ }
> -};
> -
>  static int armv6_pmu_device_probe(struct platform_device *pdev)
>  {
> -	return arm_pmu_device_probe(pdev, armv6_pmu_of_device_ids,
> -				    armv6_pmu_probe_table);
> +	return arm_pmu_device_probe(pdev, armv6_pmu_of_device_ids, NULL);
>  }
>  
>  static struct platform_driver armv6_pmu_driver = {
> diff --git a/drivers/perf/arm_v7_pmu.c b/drivers/perf/arm_v7_pmu.c
> index fdd936fbd188..928ac3d626ed 100644
> --- a/drivers/perf/arm_v7_pmu.c
> +++ b/drivers/perf/arm_v7_pmu.c
> @@ -1977,17 +1977,9 @@ static const struct of_device_id armv7_pmu_of_device_ids[] = {
>  	{},
>  };
>  
> -static const struct pmu_probe_info armv7_pmu_probe_table[] = {
> -	ARM_PMU_PROBE(ARM_CPU_PART_CORTEX_A8, armv7_a8_pmu_init),
> -	ARM_PMU_PROBE(ARM_CPU_PART_CORTEX_A9, armv7_a9_pmu_init),
> -	{ /* sentinel value */ }
> -};
> -
> -
>  static int armv7_pmu_device_probe(struct platform_device *pdev)
>  {
> -	return arm_pmu_device_probe(pdev, armv7_pmu_of_device_ids,
> -				    armv7_pmu_probe_table);
> +	return arm_pmu_device_probe(pdev, armv7_pmu_of_device_ids, NULL);
>  }
>  
>  static struct platform_driver armv7_pmu_driver = {
> 
> -- 
> 2.43.0
> 

