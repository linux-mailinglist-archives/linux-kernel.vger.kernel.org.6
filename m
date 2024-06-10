Return-Path: <linux-kernel+bounces-207932-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C523B901E0C
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 11:23:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 406D21F24B76
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 09:23:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8333C74E0A;
	Mon, 10 Jun 2024 09:23:28 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1EC974054;
	Mon, 10 Jun 2024 09:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718011408; cv=none; b=db3OXt+PfAVhpndG6aEXNNRpKow5RM63h6KeM1DuBzOhvzhNxtWBO8ybBo8CFDlx/6+kFHmH41FekWBLRuKSfuVBmFGaOsmUYnadTDiFT1uY+gDmFsRdYkcLybpX133hfDzj4NRATZ4awvKEqV3ypWkS4HfocjibDJZHv7OBJ4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718011408; c=relaxed/simple;
	bh=ycXPxrHQqWs+PsV8fD314WdCfm1zb1kWuAA1Sks+2ho=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dnBRKX4AwcaDurCjjJ+jjXyTY8XXuSNPT66n8MHFZPbgcn3i0ry+9pWi5r8DeqEZgsuVwnST8OuQMKeFgRgIdcX+I3U+NI0QVRdrt+O7wrdWjLVqFa9aUvyvERW+bKu6Jx1fphOm0nSxBeBTSCDvggQFoyNpmy4w5X6+yzJBXyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8FC9812FC;
	Mon, 10 Jun 2024 02:23:49 -0700 (PDT)
Received: from J2N7QTR9R3 (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AE4693F73B;
	Mon, 10 Jun 2024 02:23:21 -0700 (PDT)
Date: Mon, 10 Jun 2024 10:23:18 +0100
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
Subject: Re: [PATCH 1/9] perf/arm: Move 32-bit PMU drivers to drivers/perf/
Message-ID: <ZmbGBoRvNdwbVLO6@J2N7QTR9R3>
References: <20240607-arm-pmu-3-9-icntr-v1-0-c7bd2dceff3b@kernel.org>
 <20240607-arm-pmu-3-9-icntr-v1-1-c7bd2dceff3b@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240607-arm-pmu-3-9-icntr-v1-1-c7bd2dceff3b@kernel.org>

On Fri, Jun 07, 2024 at 02:31:26PM -0600, Rob Herring (Arm) wrote:
> It is preferred to put drivers under drivers/ rather than under arch/.
> The PMU drivers also depend on arm_pmu.c, so it's better to place them
> all together.
> 
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>

Acked-by: Mark Rutland <mark.rutland@arm.com>

Mark.

> ---
>  arch/arm/kernel/Makefile                                     |  2 --
>  drivers/perf/Kconfig                                         | 12 ++++++++++++
>  drivers/perf/Makefile                                        |  3 +++
>  arch/arm/kernel/perf_event_v6.c => drivers/perf/arm_v6_pmu.c |  3 ---
>  arch/arm/kernel/perf_event_v7.c => drivers/perf/arm_v7_pmu.c |  3 ---
>  .../perf_event_xscale.c => drivers/perf/arm_xscale_pmu.c     |  3 ---
>  6 files changed, 15 insertions(+), 11 deletions(-)
> 
> diff --git a/arch/arm/kernel/Makefile b/arch/arm/kernel/Makefile
> index 89a77e3f51d2..aaae31b8c4a5 100644
> --- a/arch/arm/kernel/Makefile
> +++ b/arch/arm/kernel/Makefile
> @@ -78,8 +78,6 @@ obj-$(CONFIG_CPU_XSC3)		+= xscale-cp0.o
>  obj-$(CONFIG_CPU_MOHAWK)	+= xscale-cp0.o
>  obj-$(CONFIG_IWMMXT)		+= iwmmxt.o
>  obj-$(CONFIG_PERF_EVENTS)	+= perf_regs.o perf_callchain.o
> -obj-$(CONFIG_HW_PERF_EVENTS)	+= perf_event_xscale.o perf_event_v6.o \
> -				   perf_event_v7.o
>  AFLAGS_iwmmxt.o			:= -Wa,-mcpu=iwmmxt
>  obj-$(CONFIG_ARM_CPU_TOPOLOGY)  += topology.o
>  obj-$(CONFIG_VDSO)		+= vdso.o
> diff --git a/drivers/perf/Kconfig b/drivers/perf/Kconfig
> index 7526a9e714fa..aa9530b4064f 100644
> --- a/drivers/perf/Kconfig
> +++ b/drivers/perf/Kconfig
> @@ -56,6 +56,18 @@ config ARM_PMU
>  	  Say y if you want to use CPU performance monitors on ARM-based
>  	  systems.
>  
> +config ARM_V6_PMU
> +	depends on ARM_PMU && (CPU_V6 || CPU_V6K)
> +	def_bool y
> +
> +config ARM_V7_PMU
> +	depends on ARM_PMU && CPU_V7
> +	def_bool y
> +
> +config ARM_XSCALE_PMU
> +	depends on ARM_PMU && CPU_XSCALE
> +	def_bool y
> +
>  config RISCV_PMU
>  	depends on RISCV
>  	bool "RISC-V PMU framework"
> diff --git a/drivers/perf/Makefile b/drivers/perf/Makefile
> index 29b1c28203ef..d43df81d52f7 100644
> --- a/drivers/perf/Makefile
> +++ b/drivers/perf/Makefile
> @@ -6,6 +6,9 @@ obj-$(CONFIG_ARM_DSU_PMU) += arm_dsu_pmu.o
>  obj-$(CONFIG_ARM_PMU) += arm_pmu.o arm_pmu_platform.o
>  obj-$(CONFIG_ARM_PMU_ACPI) += arm_pmu_acpi.o
>  obj-$(CONFIG_ARM_PMUV3) += arm_pmuv3.o
> +obj-$(CONFIG_ARM_V6_PMU) += arm_v6_pmu.o
> +obj-$(CONFIG_ARM_V7_PMU) += arm_v7_pmu.o
> +obj-$(CONFIG_ARM_XSCALE_PMU) += arm_xscale_pmu.o
>  obj-$(CONFIG_ARM_SMMU_V3_PMU) += arm_smmuv3_pmu.o
>  obj-$(CONFIG_FSL_IMX8_DDR_PMU) += fsl_imx8_ddr_perf.o
>  obj-$(CONFIG_FSL_IMX9_DDR_PMU) += fsl_imx9_ddr_perf.o
> diff --git a/arch/arm/kernel/perf_event_v6.c b/drivers/perf/arm_v6_pmu.c
> similarity index 99%
> rename from arch/arm/kernel/perf_event_v6.c
> rename to drivers/perf/arm_v6_pmu.c
> index d9fd53841591..f7593843bb85 100644
> --- a/arch/arm/kernel/perf_event_v6.c
> +++ b/drivers/perf/arm_v6_pmu.c
> @@ -31,8 +31,6 @@
>   * enable the interrupt.
>   */
>  
> -#if defined(CONFIG_CPU_V6) || defined(CONFIG_CPU_V6K)
> -
>  #include <asm/cputype.h>
>  #include <asm/irq_regs.h>
>  
> @@ -445,4 +443,3 @@ static struct platform_driver armv6_pmu_driver = {
>  };
>  
>  builtin_platform_driver(armv6_pmu_driver);
> -#endif	/* CONFIG_CPU_V6 || CONFIG_CPU_V6K */
> diff --git a/arch/arm/kernel/perf_event_v7.c b/drivers/perf/arm_v7_pmu.c
> similarity index 99%
> rename from arch/arm/kernel/perf_event_v7.c
> rename to drivers/perf/arm_v7_pmu.c
> index a3322e2b3ea4..fdd936fbd188 100644
> --- a/arch/arm/kernel/perf_event_v7.c
> +++ b/drivers/perf/arm_v7_pmu.c
> @@ -17,8 +17,6 @@
>   *  counter and all 4 performance counters together can be reset separately.
>   */
>  
> -#ifdef CONFIG_CPU_V7
> -
>  #include <asm/cp15.h>
>  #include <asm/cputype.h>
>  #include <asm/irq_regs.h>
> @@ -2002,4 +2000,3 @@ static struct platform_driver armv7_pmu_driver = {
>  };
>  
>  builtin_platform_driver(armv7_pmu_driver);
> -#endif	/* CONFIG_CPU_V7 */
> diff --git a/arch/arm/kernel/perf_event_xscale.c b/drivers/perf/arm_xscale_pmu.c
> similarity index 99%
> rename from arch/arm/kernel/perf_event_xscale.c
> rename to drivers/perf/arm_xscale_pmu.c
> index 7a2ba1c689a7..3d8b72d6b37f 100644
> --- a/arch/arm/kernel/perf_event_xscale.c
> +++ b/drivers/perf/arm_xscale_pmu.c
> @@ -13,8 +13,6 @@
>   * PMU structures.
>   */
>  
> -#ifdef CONFIG_CPU_XSCALE
> -
>  #include <asm/cputype.h>
>  #include <asm/irq_regs.h>
>  
> @@ -745,4 +743,3 @@ static struct platform_driver xscale_pmu_driver = {
>  };
>  
>  builtin_platform_driver(xscale_pmu_driver);
> -#endif	/* CONFIG_CPU_XSCALE */
> 
> -- 
> 2.43.0
> 
> 

