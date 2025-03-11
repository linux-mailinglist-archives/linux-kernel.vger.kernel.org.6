Return-Path: <linux-kernel+bounces-555994-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DC8DA5BF58
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 12:40:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 33FF03B2EB4
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 11:40:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9391C253F3B;
	Tue, 11 Mar 2025 11:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="kjsVZCHW"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 786E2253B46
	for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 11:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741693218; cv=none; b=dZcAp6iIaUUgZzFunq4EtV/iea/n6HaEymhrR79kRxqudcG7TKQqRCUsb23PkCCfBZ7IKOZHKfBpvw0frQ9R+E8wWCNtMvChxl38E0AGXbnpyBVpXcUSoJkOrENhKHD97BHRTYmkhpcfalacWhJAUweN9DG2JjEv8gdJdlKzG0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741693218; c=relaxed/simple;
	bh=6RIhLeZWE5sEhtVGPkBXsCtoy7n8k/IF8zXcLM2YqzE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FKSwJI38kuks2NDWmZAeyATY7QZzNOTg32i0+AzYfo1iQtRKJgxFwGqf37dMGw0Vltp0J/qQi9QcbffV41kfDVboyDnPWGgeKDfZn1A8/2bQB3GRq9RVXHwhTnFd+1MH/jSbIuOhn2fQCnOoXrcrMS4mXSCe2orJ8V3EjyJMGYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=kjsVZCHW; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=S4g3I2UJAcBxO5zytx/wxy6Z9dR7Rinx/CzGz1kt9W0=; b=kjsVZCHWopQAWW3ws9adP6nrM3
	baJBJDRCwXMxtA4uenO4gOLVN9QxX3qVw1vHP95H+mbV3dyNlkgd87pYhMihbehmhcmAnRE8enmoL
	CwphVeqm/Ti5r48V0g1UIZGHl06TBfc39B0w0tys+C6WF6SPy/fDGaAS/KLbOBvH8Dcq63F+80GT0
	igsd0zmc5MLrVnfRk4Ps1DVu4RnA4yD6qxY2I6RcxBcopyHzw430HTYKkn4iT4nAn6ysT3boAc9b/
	zi9EG423MrEZRZLiaZI7seccm6/NO2tnMjYOvzWsqKuSeXZxs4ymwoz1QkeKmfg44x8PrQCxDQoQm
	zA55x5KA==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1trxy0-000000028bg-3RWS;
	Tue, 11 Mar 2025 11:40:12 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 63E603002C7; Tue, 11 Mar 2025 12:40:12 +0100 (CET)
Date: Tue, 11 Mar 2025 12:40:12 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: kan.liang@linux.intel.com
Cc: mingo@redhat.com, acme@kernel.org, namhyung@kernel.org,
	linux-kernel@vger.kernel.org, ak@linux.intel.com,
	eranian@google.com
Subject: Re: [PATCH] perf: Extend per event callchain limit to branch stack
Message-ID: <20250311114012.GE19424@noisy.programming.kicks-ass.net>
References: <20250310181536.3645382-1-kan.liang@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250310181536.3645382-1-kan.liang@linux.intel.com>

On Mon, Mar 10, 2025 at 11:15:36AM -0700, kan.liang@linux.intel.com wrote:
> From: Kan Liang <kan.liang@linux.intel.com>
> 
> The commit 97c79a38cd45 ("perf core: Per event callchain limit")
> introduced a per-event term to allow finer tuning of the depth of
> callchains to save space.
> 
> It should be applied to the branch stack as well. For example, autoFDO
> collections require maximum LBR entries. In the meantime, other
> system-wide LBR users may only be interested in the latest a few number
> of LBRs. A per-event LBR depth would save the perf output buffer.
> 
> The patch simply drops the uninterested branches, but HW still collects
> the maximum branches. There may be a model-specific optimization that
> can reduce the HW depth for some cases to reduce the overhead further.
> But it isn't included in the patch set. Because it's not useful for all
> cases. For example, ARCH LBR can utilize the PEBS and XSAVE to collect
> LBRs. The depth should have less impact on the collecting overhead.
> The model-specific optimization may be implemented later separately.
> 
> Signed-off-by: Kan Liang <kan.liang@linux.intel.com>

Thanks!

> ---
>  include/linux/perf_event.h      | 3 +++
>  include/uapi/linux/perf_event.h | 2 ++
>  2 files changed, 5 insertions(+)
> 
> diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
> index 24f2eba200ac..bca1dfd30276 100644
> --- a/include/linux/perf_event.h
> +++ b/include/linux/perf_event.h
> @@ -1347,6 +1347,9 @@ static inline void perf_sample_save_brstack(struct perf_sample_data *data,
>  
>  	if (branch_sample_hw_index(event))
>  		size += sizeof(u64);
> +
> +	brs->nr = min_t(u16, event->attr.sample_max_stack, brs->nr);
> +
>  	size += brs->nr * sizeof(struct perf_branch_entry);
>  
>  	/*
> diff --git a/include/uapi/linux/perf_event.h b/include/uapi/linux/perf_event.h
> index 0524d541d4e3..5fc753c23734 100644
> --- a/include/uapi/linux/perf_event.h
> +++ b/include/uapi/linux/perf_event.h
> @@ -385,6 +385,8 @@ enum perf_event_read_format {
>   *
>   * @sample_max_stack: Max number of frame pointers in a callchain,
>   *		      should be < /proc/sys/kernel/perf_event_max_stack
> + *		      Max number of entries of branch stack
> + *		      should be < hardware limit
>   */
>  struct perf_event_attr {
>  
> -- 
> 2.38.1
> 

