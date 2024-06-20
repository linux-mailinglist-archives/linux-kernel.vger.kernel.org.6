Return-Path: <linux-kernel+bounces-222331-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CC1290FFC5
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 11:01:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 11D171F2196F
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 09:01:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9002A19E836;
	Thu, 20 Jun 2024 09:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="u7rfbikp"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C88850288
	for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 09:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718874034; cv=none; b=nIB2pD82X3m6MQmSci95lL0ZF+cPr8AHOAtXgLkX8pNvjFUKrNIactmc99hdZePmQzej/WAXozeckyp9wscJGLObaZ02ijt7iIm5wNe2PNAC1mD2JRn03V5yvOz0anqWpZ8Cl25+6FUlYw25fFZH1l1TzdhhNnQphaJ8pqjRGbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718874034; c=relaxed/simple;
	bh=garobEQZrgEddQebq3ve+QulKtp6U6J+7KW9+rA30+k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uFLjswU2R2eDBrEoQAihWikV4CYcSt5G4CiwEMplhQcF7rRTR/lIK5rgLdczhQ5R8xtKAqRWE894zNc6CvQTLTF5+YkmejIbw3Qo7PH/Q5xtz1P1sdzE0nNWyAfSsXJwIKhKjjKlWOuqYjCI1h8PM4J/qRNdB60obZpNtWKsX+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=u7rfbikp; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=pU0mtXswrga3e9qk/Sn+GsOMld6jBWrUO4iVxP5PfSM=; b=u7rfbikpRrqa0cE51d/OFT6Pss
	nRqu71wQxeGAGuPzhIrvha4KS8/xAOMT2hYCkjspJEYivAiFjqaC/aYutYPfiZyTYruU7cDKBYOYN
	PQAp7xJAnYsu4UODtJAMegyiOTBkmGah14Gs1wbKx0gDyhOkwxwCqxPhUJHbtT2xaddm/kYChIOBN
	nwpr2SOoKgGdiLjePr7L4klPPVARCRHdXLqoWpm/j2isGhvhJExi5zaMYkz4C53tjqyGKajhLZabj
	snRoi6gmQPX8p7TZcVNtSevg85IpR7Tx3dhK+3uEEFlI/gYPp8Rx5QQLj4KequIPMRkE0Le/oyu22
	hTr+AY3Q==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sKDee-00000005ryO-1rAC;
	Thu, 20 Jun 2024 09:00:28 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 1A502300CB9; Thu, 20 Jun 2024 11:00:28 +0200 (CEST)
Date: Thu, 20 Jun 2024 11:00:28 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: kan.liang@linux.intel.com
Cc: mingo@kernel.org, acme@kernel.org, namhyung@kernel.org,
	irogers@google.com, adrian.hunter@intel.com,
	alexander.shishkin@linux.intel.com, linux-kernel@vger.kernel.org,
	ak@linux.intel.com, eranian@google.com
Subject: Re: [RESEND PATCH 09/12] perf: Extend perf_output_read
Message-ID: <20240620090028.GW31592@noisy.programming.kicks-ass.net>
References: <20240618151044.1318612-1-kan.liang@linux.intel.com>
 <20240618151044.1318612-10-kan.liang@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240618151044.1318612-10-kan.liang@linux.intel.com>

On Tue, Jun 18, 2024 at 08:10:41AM -0700, kan.liang@linux.intel.com wrote:
> From: Kan Liang <kan.liang@linux.intel.com>
> 
> The event may have been updated in the PMU-specific implementation,
> e.g., Intel PEBS counters snapshotting. The common code should not
> read and overwrite the value.
> 
> The PERF_SAMPLE_READ in the data->sample_type can be used to detect
> whether the PMU-specific value is available. If yes, avoid the
> pmu->read() in the common code.
> 
> Reviewed-by: Andi Kleen <ak@linux.intel.com>
> Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
> ---
>  kernel/events/core.c | 15 ++++++++-------
>  1 file changed, 8 insertions(+), 7 deletions(-)
> 
> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index 8f908f077935..733e507948e6 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -7243,7 +7243,7 @@ static void perf_output_read_one(struct perf_output_handle *handle,
>  
>  static void perf_output_read_group(struct perf_output_handle *handle,
>  			    struct perf_event *event,
> -			    u64 enabled, u64 running)
> +			    u64 enabled, u64 running, bool read)
>  {
>  	struct perf_event *leader = event->group_leader, *sub;
>  	u64 read_format = event->attr.read_format;
> @@ -7265,7 +7265,7 @@ static void perf_output_read_group(struct perf_output_handle *handle,
>  	if (read_format & PERF_FORMAT_TOTAL_TIME_RUNNING)
>  		values[n++] = running;
>  
> -	if ((leader != event) &&
> +	if ((leader != event) && read &&
>  	    (leader->state == PERF_EVENT_STATE_ACTIVE))
>  		leader->pmu->read(leader);
>  
> @@ -7280,7 +7280,7 @@ static void perf_output_read_group(struct perf_output_handle *handle,
>  	for_each_sibling_event(sub, leader) {
>  		n = 0;
>  
> -		if ((sub != event) &&
> +		if ((sub != event) && read &&
>  		    (sub->state == PERF_EVENT_STATE_ACTIVE))
>  			sub->pmu->read(sub);
>  
> @@ -7307,7 +7307,8 @@ static void perf_output_read_group(struct perf_output_handle *handle,
>   * on another CPU, from interrupt/NMI context.
>   */
>  static void perf_output_read(struct perf_output_handle *handle,
> -			     struct perf_event *event)
> +			     struct perf_event *event,
> +			     bool read)
>  {
>  	u64 enabled = 0, running = 0, now;
>  	u64 read_format = event->attr.read_format;
> @@ -7325,7 +7326,7 @@ static void perf_output_read(struct perf_output_handle *handle,
>  		calc_timer_values(event, &now, &enabled, &running);
>  
>  	if (event->attr.read_format & PERF_FORMAT_GROUP)
> -		perf_output_read_group(handle, event, enabled, running);
> +		perf_output_read_group(handle, event, enabled, running, read);
>  	else
>  		perf_output_read_one(handle, event, enabled, running);
>  }
> @@ -7367,7 +7368,7 @@ void perf_output_sample(struct perf_output_handle *handle,
>  		perf_output_put(handle, data->period);
>  
>  	if (sample_type & PERF_SAMPLE_READ)
> -		perf_output_read(handle, event);
> +		perf_output_read(handle, event, !(data->sample_flags & PERF_SAMPLE_READ));
>  
>  	if (sample_type & PERF_SAMPLE_CALLCHAIN) {
>  		int size = 1;

this can't be right. The output is order sensitive. If a
PERF_SAMPLE_READ is part of the PERF_RECORD_SAMPLE, it must be in this
location.

