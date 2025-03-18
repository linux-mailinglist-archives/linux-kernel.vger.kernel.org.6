Return-Path: <linux-kernel+bounces-566723-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 20D91A67BAD
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 19:11:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 09A7A1891E34
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 18:09:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 076B5213241;
	Tue, 18 Mar 2025 18:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="atA/w/lf"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68424212FBA
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 18:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742321364; cv=none; b=k8vEW6/P53vb5ii9/6Iu2eIJkesU9cm9E5n/mXtPivWaZ05jvKWm58JvfedcKkGsnZ3JYHSaoJmYdBXCSYnxXcQvVtxRAOHbitJZfcL1q/v1biwamlHMeSnQ/nVIRg+uPwZ+mV0B4fI9qdG7fTANLBHtrNhBiRIk7Kc1acInykM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742321364; c=relaxed/simple;
	bh=cvA5nA7PII29f5NvCF34TprU7gUF4YaM/FML5sAGdCI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qtKOu5e811VDMw1v6xvt+/Cv+ftF4MHg55nNL6V3HZcfuFgDZh+FHNmbY7cPb5xADFI8+qc4HQTrGS/zmCyw3mj4VJX5PoRfxplnS6GBPGVXtqMUwy6HRFxX41Fe4Zqx1gLzLEgOrmjF4zSHmSug0Y45Onz8gXgEL6Ww1QJEox8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=atA/w/lf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79DECC4CEDD;
	Tue, 18 Mar 2025 18:09:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742321363;
	bh=cvA5nA7PII29f5NvCF34TprU7gUF4YaM/FML5sAGdCI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=atA/w/lfOk3haIBB2yrEPEP3aGZTozqX61ZSP3nbI6os3UHdiwY54eT/OVj3llIUJ
	 ONbr3XLBrjJVe2b0ACZ4uto56BKifr0sveWPj5/G/AEKY/EtOu35tIUfx0hj1zNUo2
	 YDf1C2vWhDWJLPlsHrXt1Ff+FsDgP/+km/qZVpshzY3jE2ZGdPggJJpC6ymCxx/QD0
	 rlxjLF3RaLTuR4jGFp4sR54I+Oc+PogqCA1RbNWSMqFVna+JqsbxtkbGGvQ3smMe2R
	 bdehcJC723S7OKc+3BZvnbprMdeDbWTYahVh/+fgEav6imXV/aUfWPGkmTvlGZahSK
	 YMN6nCt6SV/YA==
Date: Tue, 18 Mar 2025 11:09:21 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Ravi Bangoria <ravi.bangoria@amd.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>,
	Kan Liang <kan.liang@linux.intel.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Matteo Rizzo <matteorizzo@google.com>
Subject: Re: [PATCH v2] perf/x86: Check data address for IBS software filter
Message-ID: <Z9m20YMkMfUDBxgv@google.com>
References: <20250317163755.1842589-1-namhyung@kernel.org>
 <0eb55fa1-3b03-4550-bdd7-c7c50294dcbe@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <0eb55fa1-3b03-4550-bdd7-c7c50294dcbe@amd.com>

Hi Ravi,

On Tue, Mar 18, 2025 at 04:02:20PM +0530, Ravi Bangoria wrote:
> Hi Namhyung,
> 
> On 17-Mar-25 10:07 PM, Namhyung Kim wrote:
> > IBS software filter was to filter kernel samples for regular users in
> > PMI handler.  It checks the instruction address in the IBS register to
> > determine if it was in the kernel more or not.
> > 
> > But it turns out that it's possible to report a kernel data address even
> > if the instruction address belongs to the user space.  Matteo Rizzo
> > found that when an instruction raises an exception, IBS can report some
> > kernel data address like IDT while holding the faulting instruction's
> > RIP.  To prevent an information leak, it should double check if the data
> > address in PERF_SAMPLE_DATA is in the kernel space as well.
> 
> PERF_SAMPLE_RAW can also leak kernel data address. How about:

Thanks for your review.

I think RAW is different as it requires perf_event_paranoid == -1.
This is normally not allowed to regular users and having this means
you can profile kernel with detailed tracepoints info already.

Thanks,
Namhyung

> 
> --- a/arch/x86/events/amd/ibs.c
> +++ b/arch/x86/events/amd/ibs.c
> @@ -1159,6 +1159,25 @@ static int perf_ibs_get_offset_max(struct perf_ibs *perf_ibs,
>  	return 1;
>  }
>  
> +static bool perf_ibs_swfilt_discard(struct perf_ibs *perf_ibs, struct perf_event *event,
> +				    struct pt_regs *regs, struct perf_ibs_data *ibs_data)
> +{
> +	union ibs_op_data3 op_data3;
> +
> +	if (perf_exclude_event(event, regs))
> +		return true;
> +
> +	if (perf_ibs != &perf_ibs_op || !event->attr.exclude_kernel)
> +		return false;
> +
> +	op_data3.val = ibs_data->regs[ibs_op_msr_idx(MSR_AMD64_IBSOPDATA3)];
> +
> +	/* Prevent leaking kernel 'data' addresses to unprivileged users. */
> +	return unlikely(event->attr.sample_type & (PERF_SAMPLE_ADDR | PERF_SAMPLE_RAW) &&
> +			op_data3.dc_lin_addr_valid &&
> +			kernel_ip(ibs_data->regs[ibs_op_msr_idx(MSR_AMD64_IBSDCLINAD)]));
> +}
> +
>  static int perf_ibs_handle_irq(struct perf_ibs *perf_ibs, struct pt_regs *iregs)
>  {
>  	struct cpu_perf_ibs *pcpu = this_cpu_ptr(perf_ibs->pcpu);
> @@ -1268,7 +1287,7 @@ static int perf_ibs_handle_irq(struct perf_ibs *perf_ibs, struct pt_regs *iregs)
>  	}
>  
>  	if ((event->attr.config2 & IBS_SW_FILTER_MASK) &&
> -	    perf_exclude_event(event, &regs)) {
> +	    perf_ibs_swfilt_discard(perf_ibs, event, &regs, &ibs_data)) {
>  		throttle = perf_event_account_interrupt(event);
>  		goto out;
>  	}
> -- 
> 
> Thanks,
> Ravi

