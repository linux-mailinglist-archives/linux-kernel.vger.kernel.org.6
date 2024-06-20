Return-Path: <linux-kernel+bounces-222176-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C63D90FDE4
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 09:35:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2787E283674
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 07:35:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A93A345C18;
	Thu, 20 Jun 2024 07:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ivcbIfkT"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73815757E8
	for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 07:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718868874; cv=none; b=UlFC09rbpFuHf7vjpAJwjokO4bXHQp1UBSklzlWzoEjpKr4gh0esxCsB90f8r1/Sz1dB70a+QCWs4vQw4IbI+waL6z49FWT5imx7AyKyP7hSveOPqdQdn3jbMdlHGu3uBGNjnaZPEFouJHj1HPQVka4E8FiQTtIhybZutLpp8TA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718868874; c=relaxed/simple;
	bh=PZuzMuFrGxgfRX5jCBmwds6EGDY8oZ5qE7+Fjvvet2I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BmaQXx2qgunxvB58YCXSEb7YjCSupb3t0lIrK3D3aHHTAIjN3j+DjSkY5YSBTV+rrz72MFJegmWujoNkm//uQMku99Ec7WBZ4trtJF28ToU3o4l+mFfL13cIavQXroGWkvehc1fLGMwlMqNMhHxddwa/LioPtcsIBTsl/0OciAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ivcbIfkT; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=4pcxUoHoWVMwiO54VOdychYI86aS+tkZ4/hYK5+OQQw=; b=ivcbIfkT00yUxtKuGeVQ1RfE2b
	8+HMiroYhQydz0sEnPRv0gwrogVmEfTuoVfTjpTPuc+owMJ65R2un6XObQH4s9UomevSo+SNlQn+d
	uqtml+SodTd2V/J4B1TE2zRovTdQSwR06TD63LsJDjLt1ECDEO7yPOTJ8F+o2Hlc8n1HBZSx+91L1
	cQMcupItpCWluEJg7BwY8pEvZUpMlPSQDNq2Tp5SXolrb//nDJOnMMNQrAra7NOwr1VXbhO+lv9Cm
	h1GoQ6ayRhVHZFcJXxsD9YUquCmu0vReo0mx/0E9LZTwO3ZYhgpzmpoma7cuKyu5SQyTOhUBDaR2t
	zzRjReZQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sKCJO-00000007W46-320b;
	Thu, 20 Jun 2024 07:34:27 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 5AFDB300CB9; Thu, 20 Jun 2024 09:34:26 +0200 (CEST)
Date: Thu, 20 Jun 2024 09:34:26 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: kan.liang@linux.intel.com
Cc: mingo@kernel.org, acme@kernel.org, namhyung@kernel.org,
	irogers@google.com, adrian.hunter@intel.com,
	alexander.shishkin@linux.intel.com, linux-kernel@vger.kernel.org,
	ak@linux.intel.com, eranian@google.com
Subject: Re: [RESEND PATCH 04/12] perf/x86/intel: Support new data source for
 Lunar Lake
Message-ID: <20240620073426.GR31592@noisy.programming.kicks-ass.net>
References: <20240618151044.1318612-1-kan.liang@linux.intel.com>
 <20240618151044.1318612-5-kan.liang@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240618151044.1318612-5-kan.liang@linux.intel.com>

On Tue, Jun 18, 2024 at 08:10:36AM -0700, kan.liang@linux.intel.com wrote:

> @@ -77,7 +86,7 @@ union intel_x86_pebs_dse {
>  #define SNOOP_NONE_MISS (P(SNOOP, NONE) | P(SNOOP, MISS))
>  
>  /* Version for Sandy Bridge and later */
> -static u64 pebs_data_source[] = {
> +static u64 pebs_data_source[PERF_PEBS_DATA_SOURCE_MAX] = {
>  	P(OP, LOAD) | P(LVL, MISS) | LEVEL(L3) | P(SNOOP, NA),/* 0x00:ukn L3 */
>  	OP_LH | P(LVL, L1)  | LEVEL(L1) | P(SNOOP, NONE),  /* 0x01: L1 local */
>  	OP_LH | P(LVL, LFB) | LEVEL(LFB) | P(SNOOP, NONE), /* 0x02: LFB hit */
> @@ -173,6 +182,40 @@ void __init intel_pmu_pebs_data_source_cmt(void)
>  	__intel_pmu_pebs_data_source_cmt(pebs_data_source);
>  }
>  
> +/* Version for Lunar Lake p-core and later */
> +static u64 lnc_pebs_data_source[PERF_PEBS_DATA_SOURCE_MAX] = {

Comment and naming are inconsistent, please lion-cove and lnc

> +	P(OP, LOAD) | P(LVL, MISS) | LEVEL(L3) | P(SNOOP, NA),	/* 0x00: ukn L3 */
> +	OP_LH | P(LVL, L1)  | LEVEL(L1) | P(SNOOP, NONE),	/* 0x01: L1 hit */
> +	OP_LH | P(LVL, L1)  | LEVEL(L1) | P(SNOOP, NONE),	/* 0x02: L1 hit */
> +	OP_LH | P(LVL, LFB) | LEVEL(LFB) | P(SNOOP, NONE),	/* 0x03: LFB/L1 Miss Handling Buffer hit */
> +	0,							/* 0x04: Reserved */
> +	OP_LH | P(LVL, L2)  | LEVEL(L2) | P(SNOOP, NONE),	/* 0x05: L2 Hit */
> +	OP_LH | LEVEL(L2_MHB) | P(SNOOP, NONE),			/* 0x06: L2 Miss Handling Buffer Hit */
> +	0,							/* 0x07: Reserved */
> +	OP_LH | P(LVL, L3)  | LEVEL(L3) | P(SNOOP, NONE),	/* 0x08: L3 Hit */
> +	0,							/* 0x09: Reserved */
> +	0,							/* 0x0a: Reserved */
> +	0,							/* 0x0b: Reserved */
> +	OP_LH | P(LVL, L3)  | LEVEL(L3) | P(SNOOPX, FWD),	/* 0x0c: L3 Hit Snoop Fwd */
> +	OP_LH | P(LVL, L3)  | LEVEL(L3) | P(SNOOP, HITM),	/* 0x0d: L3 Hit Snoop HitM */
> +	0,							/* 0x0e: Reserved */
> +	P(OP, LOAD) | P(LVL, MISS) | P(LVL, L3)  | LEVEL(L3) | P(SNOOP, HITM),	/* 0x0f: L3 Miss Snoop HitM */
> +	OP_LH | LEVEL(MSC) | P(SNOOP, NONE),			/* 0x10: Memory-side Cache Hit */
> +	OP_LH | P(LVL, LOC_RAM)  | LEVEL(RAM) | P(SNOOP, NONE), /* 0x11: Local Memory Hit */
> +};
> +
> +void __init intel_pmu_pebs_data_source_lnl(void)
> +{
> +	u64 *data_source;
> +
> +	data_source = x86_pmu.hybrid_pmu[X86_HYBRID_PMU_CORE_IDX].pebs_data_source;
> +	memcpy(data_source, lnc_pebs_data_source, sizeof(lnc_pebs_data_source));
> +
> +	data_source = x86_pmu.hybrid_pmu[X86_HYBRID_PMU_ATOM_IDX].pebs_data_source;
> +	memcpy(data_source, pebs_data_source, sizeof(pebs_data_source));
> +	__intel_pmu_pebs_data_source_cmt(data_source);
> +}
> +
>  static u64 precise_store_data(u64 status)
>  {
>  	union intel_x86_pebs_dse dse;
> @@ -264,7 +307,7 @@ static u64 __adl_latency_data_small(struct perf_event *event, u64 status,
>  
>  	WARN_ON_ONCE(hybrid_pmu(event->pmu)->pmu_type == hybrid_big);
>  
> -	dse &= PERF_PEBS_DATA_SOURCE_MASK;
> +	dse &= PERF_PEBS_DATA_SOURCE_GRT_MASK;
>  	val = hybrid_var(event->pmu, pebs_data_source)[dse];
>  
>  	pebs_set_tlb_lock(&val, tlb, lock);
> @@ -300,6 +343,45 @@ u64 mtl_latency_data_small(struct perf_event *event, u64 status)
>  					dse.mtl_fwd_blk);
>  }
>  
> +u64 lnl_latency_data(struct perf_event *event, u64 status)
> +{
> +	struct x86_hybrid_pmu *pmu = hybrid_pmu(event->pmu);
> +	union intel_x86_pebs_dse dse;
> +	union perf_mem_data_src src;
> +	u64 val;
> +
> +	if (pmu->pmu_type == hybrid_small)
> +		return mtl_latency_data_small(event, status);

argh,.. can you please go and rename this mtl_small nonsense to .. /me
googles.. crestmont / crm ?

Oh gawd, and the adl_small things to gracemont / gcm ?

> +
	return lnc_latency_data();
}


u64 lnc_latency_data()
{
> +	dse.val = status;
> +
> +	/* LNC core latency data */
> +	val = hybrid_var(event->pmu, pebs_data_source)[status & PERF_PEBS_DATA_SOURCE_MASK];
> +	if (!val)
> +		val = P(OP, LOAD) | LEVEL(NA) | P(SNOOP, NA);
> +
> +	if (dse.lnc_stlb_miss)
> +		val |= P(TLB, MISS) | P(TLB, L2);
> +	else
> +		val |= P(TLB, HIT) | P(TLB, L1) | P(TLB, L2);
> +
> +	if (dse.lnc_locked)
> +		val |= P(LOCK, LOCKED);
> +
> +	if (dse.lnc_data_blk)
> +		val |= P(BLK, DATA);
> +	if (dse.lnc_addr_blk)
> +		val |= P(BLK, ADDR);
> +	if (!dse.lnc_data_blk && !dse.lnc_addr_blk)
> +		val |= P(BLK, NA);
> +
> +	src.val = val;
> +	if (event->hw.flags & PERF_X86_EVENT_PEBS_ST_HSW)
> +		src.mem_op = P(OP, STORE);
> +
> +	return src.val;
> +}


