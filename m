Return-Path: <linux-kernel+bounces-222206-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1980490FE2E
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 10:02:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A1515284252
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 08:02:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2981C3EA64;
	Thu, 20 Jun 2024 08:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="f+tzcQ94"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2548B4315B
	for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 08:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718870556; cv=none; b=gD6nLtES7XJtbPr3a9rkX0lMYftANrBJoyG1iGM/vbm4dqHFStRh9XnUn4NkCTHyFy1PCunn/Mf702LT0YHyfrJH865ETo9/SvHRzoh+tTa/w342yd4Yould/qI5Spe5yEG8AzxSPgpZY6uT0mLtiQLPD1IY+VPic7HEKrr/XHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718870556; c=relaxed/simple;
	bh=IHUls6ItjNQh5odUpzDFCIXCNghFgeY93zk0eWdZGPU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sRHAFHESvXr3klzshDdmA9Obr2KhDRutgKr0lRRO/R7Ux6LB8zWjNfBeNLc83WoRanVM8Ve1Bti1AAA4w9ah9fjhkikWkfVvPV3rJiGHh1BSz8U4DYuGhgVJzMPJy0BQvVtuVHcUXeVirJFrc5fQeDpvUTWjs+PemS66bBdxBII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=f+tzcQ94; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=PGcRkBZh7GybbNP2925RL87fLil4R3yLPY8D4vpU4Bw=; b=f+tzcQ94dNTfq0458sq+YoQJOC
	CtxyIx9EUBuiBMXbmlRcu4dZZ3CgI2XeYOGhYSSATUPmB9ZGyrypLHsumWMOYtlJB9ShmMZcnbLXH
	zbL2H5XtGRi+sbBvEqC+IQY5O2hNIABCzjU/GHA49robtNmLj8//vyjnJqCgvAtmwHrgqu6Dx5PNK
	/piTSnxxFs6e/vtkyncKPy6UT7Wq5UBvFyRybTszrnyfMd2/t7TpL9ncLzzv9klpp/JFXff6jTVvA
	rs0H+3zwry+/WYYxi/MHKjC/0IqV/ZKiaivOvFRDEBEeDxVPn2CGbbk3a9JmNJenoeZC/EMMeQiwV
	oEpysGyQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sKCkT-00000005o5V-22ie;
	Thu, 20 Jun 2024 08:02:25 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id D842E300CB9; Thu, 20 Jun 2024 10:02:24 +0200 (CEST)
Date: Thu, 20 Jun 2024 10:02:24 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: kan.liang@linux.intel.com
Cc: mingo@kernel.org, acme@kernel.org, namhyung@kernel.org,
	irogers@google.com, adrian.hunter@intel.com,
	alexander.shishkin@linux.intel.com, linux-kernel@vger.kernel.org,
	ak@linux.intel.com, eranian@google.com
Subject: Re: [RESEND PATCH 07/12] perf/x86/intel: Support Perfmon MSRs
 aliasing
Message-ID: <20240620080224.GT31592@noisy.programming.kicks-ass.net>
References: <20240618151044.1318612-1-kan.liang@linux.intel.com>
 <20240618151044.1318612-8-kan.liang@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240618151044.1318612-8-kan.liang@linux.intel.com>

On Tue, Jun 18, 2024 at 08:10:39AM -0700, kan.liang@linux.intel.com wrote:
> @@ -6179,6 +6181,11 @@ static void intel_pmu_check_extra_regs(struct extra_reg *extra_regs)
>  	}
>  }
>  
> +static inline int intel_pmu_addr_offset(int index, bool eventsel)
> +{
> +	return MSR_IA32_PMC_STEP * index;
> +}

This should have v6 in the name or somesuch... no?

>  static const struct { enum hybrid_pmu_type id; char *name; } intel_hybrid_pmu_type_map[] __initconst = {
>  	{ hybrid_small, "cpu_atom" },
>  	{ hybrid_big, "cpu_core" },
> @@ -7153,6 +7160,14 @@ __init int intel_pmu_init(void)
>  		pr_cont("full-width counters, ");
>  	}
>  
> +	/* Support V6+ MSR Aliasing */
> +	if (x86_pmu.version >= 6) {
> +		x86_pmu.perfctr = MSR_IA32_PMC_GP0_CTR;
> +		x86_pmu.eventsel = MSR_IA32_PMC_GP0_CFG_A;
> +		x86_pmu.fixedctr = MSR_IA32_PMC_FX0_CTR;
> +		x86_pmu.addr_offset = intel_pmu_addr_offset;
> +	}

