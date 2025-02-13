Return-Path: <linux-kernel+bounces-512972-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3D8CA33FEC
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 14:08:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 571793AA9F5
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 13:08:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB88A23F414;
	Thu, 13 Feb 2025 13:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="RYZa6kWD"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBA0F23F42D
	for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 13:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739452121; cv=none; b=lmipUHaL03fpo+mw/UBfvjc46K21ESuPYj0ZQASL73oaqUncwla7jhv4L+PM00CZ3H0aIR6qnot5rInTWW/3EmOuY9oVCHazL6qTzGj6xUiQlJfx+8YxbTJ/e2TvdeQLJAK7HptqWK9aHz98Mi9/nKAul5yOz1/ugTrrjRDPlpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739452121; c=relaxed/simple;
	bh=WB4utiqEoEE/vY/GQYhBmlPqe6tcH8mD5sNTsPpqeAk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hvuQdkDTaK5iZvzrmjvbhmYy2Q0vCwOY1lj9E1PgRqjzAr74lOP1ND48R5Lbw10QKge37DoOgwULOxU+4siX8V2hnv0IbbzGKh0Eld+Srcr85PEy7y9HKSw/GKHoJcY8jSP38w5JiWX2cf1w6KsSCwQi3dA4EHHBD0rtUwLNIVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=RYZa6kWD; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Aapw2IErGtlo9KJno5VNShbCsvVlA1z8qG2MhjGNFrk=; b=RYZa6kWD/sfxt+//pyVvCW0/aN
	wwfbeYdcWxJ78NJsleXEWRLQGPxTfS/yVMPr0FxLlUaVLd8JhuJf1TzYYE3blhi4V240K3Z7P7Op4
	5tqLpD3Hbfy7iucyUdEHtAXcgJtapko0PtOpY6iRy+1ph7HO9pEekzom5ssY5XwXtMRN8tvsRCjJZ
	5IUfOU9NxKUKhnZA+eLCJeUfTghk8APUxVvDz6hqoKbsrjAkGdUppN+t7Ycmjp1amxJUnSjRoP5WF
	A2OW3qb0Z0MuldnD2mz0hODqjJj61CvWhowSoMJFFC19EwDmlOO1W5ZeU4WdxqZZnny26NX+CraUp
	ZDfSFhBA==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tiYxG-00000000zsJ-0R1X;
	Thu, 13 Feb 2025 13:08:34 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id AF5A73001AC; Thu, 13 Feb 2025 14:08:33 +0100 (CET)
Date: Thu, 13 Feb 2025 14:08:33 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Ravi Bangoria <ravi.bangoria@amd.com>
Cc: mingo@kernel.org, lucas.demarchi@intel.com,
	linux-kernel@vger.kernel.org, willy@infradead.org, acme@kernel.org,
	namhyung@kernel.org, mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com, jolsa@kernel.org,
	irogers@google.com, adrian.hunter@intel.com,
	kan.liang@linux.intel.com
Subject: Re: [PATCH v2 24/24] perf: Make perf_pmu_unregister() useable
Message-ID: <20250213130833.GH28068@noisy.programming.kicks-ass.net>
References: <20250205102120.531585416@infradead.org>
 <20250205102450.888979808@infradead.org>
 <1f4e4bb1-ba5e-4e5f-b6e3-e7603e3d6b0e@amd.com>
 <20250212124945.GH19118@noisy.programming.kicks-ass.net>
 <57fa247d-9c85-4f20-9723-d568272651f9@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <57fa247d-9c85-4f20-9723-d568272651f9@amd.com>

On Thu, Feb 13, 2025 at 01:22:55PM +0530, Ravi Bangoria wrote:
> > Does this work?
> > 
> > --- a/kernel/events/core.c
> > +++ b/kernel/events/core.c
> > @@ -2303,6 +2303,7 @@ static void perf_child_detach(struct per
> >  
> >  	sync_child_event(event);
> >  	list_del_init(&event->child_list);
> > +	event->parent = NULL;
> >  }
> >  
> >  static bool is_orphaned_event(struct perf_event *event)
> 
> Apparently not, it ends up with:
> 
>   ------------[ cut here ]------------
>   WARNING: CPU: 145 PID: 5459 at kernel/events/core.c:281 event_function+0xd2/0xf0

Durr, do you have an updated test case?

> Something like below instead? I haven't tested it thoroughly though.
> 
> ---
> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index d2b87a425e75..4e131b1c37ad 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -13645,20 +13645,25 @@ perf_event_exit_event(struct perf_event *event,
>  	unsigned long detach_flags = DETACH_EXIT;
>  
>  	if (parent_event) {
> -		/*
> -		 * Do not destroy the 'original' grouping; because of the
> -		 * context switch optimization the original events could've
> -		 * ended up in a random child task.
> -		 *
> -		 * If we were to destroy the original group, all group related
> -		 * operations would cease to function properly after this
> -		 * random child dies.
> -		 *
> -		 * Do destroy all inherited groups, we don't care about those
> -		 * and being thorough is better.
> -		 */
> -		detach_flags |= DETACH_GROUP | DETACH_CHILD;
>  		mutex_lock(&parent_event->child_mutex);
> +		if (event->attach_state & PERF_ATTACH_CHILD) {
> +			/*
> +			 * Do not destroy the 'original' grouping; because of the
> +			 * context switch optimization the original events could've
> +			 * ended up in a random child task.
> +			 *
> +			 * If we were to destroy the original group, all group related
> +			 * operations would cease to function properly after this
> +			 * random child dies.
> +			 *
> +			 * Do destroy all inherited groups, we don't care about those
> +			 * and being thorough is better.
> +			 */
> +			detach_flags |= DETACH_GROUP | DETACH_CHILD;
> +		} else {
> +			mutex_unlock(&parent_event->child_mutex);
> +			parent_event = NULL;
> +		}
>  	}

Yeah, that might do, but not really nice. But perhaps its the best we
can do. I'll give it some thought.

