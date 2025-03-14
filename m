Return-Path: <linux-kernel+bounces-561450-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DE09A611DF
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 14:00:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5BA647A3E47
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 12:59:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 142311FE470;
	Fri, 14 Mar 2025 13:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="AtI1StQk"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2589E8F54
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 13:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741957208; cv=none; b=NnzBj10zXGmPrywEeKRMQEfQfnJRkWDLwt4/Ph6btX4LxQhAJs2I263RnDK39OGTH99l6me3WhAlkNNkg+ZVO0J/phQgzK8CUvSyOiOgCoFocWs0Fo8CW39f/68NQI02goF/OqFUUJKGCGGsow8m4kxlNJrdKCLUaOMldeJOJn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741957208; c=relaxed/simple;
	bh=5GiZDtcyL2LqdkjlXrFc0MGSIspCiZMg0zXNERs4NHw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f9P8/oVRrhFnrpemodTHoHbyZ3HDkTgJyLt8RM5frrK26qi/iR5YA86FCrpciaW15W/ICIapdEGdOXreghObQYMeRQIR/F+qv50s0N4APx10FxgH6l1UiqbuSGJanvjlwyLSDGYFswv928P5zYD/4HxvOQI85tRVa0QB/xbZnYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=AtI1StQk; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=LLzNLEvRYvejLAFvOqrcf7Nl0LV+XaLJ4l6MlUXOqms=; b=AtI1StQkkr8X73dvC24TGKwScB
	IwYxi52FCYrPvwUFc4EnmVdfHXhqY4FmBIgESJXbksmSwb8LmBLnXkVBfopFd+agqLVeqnaf7NNqZ
	L5xFO8GpnNSLqv7m6VtVs9X5tLE6aEdsf4M6cRvMiEo0Z4s3Lx/ERFyv+JCR/kWcDPundqcBf8UuU
	WE4Z8n9gmn9mThHa3ComioRPpzyEJ/b3qpkVRcPgyjwhv+1GxCfTpYt3kDnEINegfZLidnOz38MZX
	3k7DRyRiJ5yA17Wtz4QCTXmC9rInyJ4r3/rTzqkYJMfvvVcVJXPccatOK/AgOxkrQdEt836ro1p1K
	fim4kkOQ==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tt4dr-00000002thh-1A0k;
	Fri, 14 Mar 2025 12:59:59 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 932EF300599; Fri, 14 Mar 2025 13:59:58 +0100 (CET)
Date: Fri, 14 Mar 2025 13:59:58 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: kan.liang@linux.intel.com
Cc: mingo@redhat.com, tglx@linutronix.de, bp@alien8.de, acme@kernel.org,
	namhyung@kernel.org, irogers@google.com,
	linux-kernel@vger.kernel.org, ak@linux.intel.com,
	eranian@google.com
Subject: Re: [PATCH V9 3/7] perf: attach/detach PMU specific data
Message-ID: <20250314125958.GC36322@noisy.programming.kicks-ass.net>
References: <20250314000242.323199-1-kan.liang@linux.intel.com>
 <20250314000242.323199-3-kan.liang@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250314000242.323199-3-kan.liang@linux.intel.com>

On Thu, Mar 13, 2025 at 05:02:38PM -0700, kan.liang@linux.intel.com wrote:

> @@ -12551,6 +12813,14 @@ perf_event_alloc(struct perf_event_attr *attr, int cpu,
>  	if (err)
>  		return ERR_PTR(err);
>  
> +	if (event->attach_state & PERF_ATTACH_TASK_DATA) {
> +		err = attach_perf_ctx_data(event);
> +		if (err) {
> +			security_perf_event_free(event);
> +			return ERR_PTR(err);
> +		}
> +	}
> +
>  	/* symmetric to unaccount_event() in _free_event() */
>  	account_event(event);
>  

This seems weird. We just pushed all the error handling into
__free_event(), and now you're adding one special case back.

Also, you've placed it after security_perf_event_alloc(), which I
_think_ wants to be last.

