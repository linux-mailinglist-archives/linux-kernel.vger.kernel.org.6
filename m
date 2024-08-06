Return-Path: <linux-kernel+bounces-276067-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48B10948E04
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 13:43:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B42C1C22276
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 11:43:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8AE21C3F2D;
	Tue,  6 Aug 2024 11:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="N3Kadnmx"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D6151C3F13
	for <linux-kernel@vger.kernel.org>; Tue,  6 Aug 2024 11:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722944519; cv=none; b=R67GZHqe/i2VCO6kJORci/Cp1tmr+ioyzs9pP1PNwrwgvdzImG5EXYRaTZVDJYWe7TqB6TrJ7Sju8G+ZTyD7tGXLj7ZHMzNcvj9hVKDvqIekESBz0osxaZFaZ17qXEhxrMexT3Am/rx88thhW+6+yzllyO5F03wh6XJDdpA8BMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722944519; c=relaxed/simple;
	bh=vxMx1R6vyniT3mml4iccMR10Tq6hwD6+asqGjloJzYs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OfHfiUpSwegXkC++1UgkuJQkkyIVj2nGKpOwINQ/bSH6bRblxcEF4Qnl1NVx8mpF3C6gF8201KFah97MnmvmyrWZK7pSgyqA6rBMji5nERUF9D4/P23UFfyrK+gQkcKbzj/fF/+ZRYX90tLD8/HDSB6ACaoKkkiCx/ef9KRQDHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=N3Kadnmx; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=mjTexPapQ/UzbHj9PenQcYnawTTa6w/cI8iir+Sqrn0=; b=N3KadnmxX4vyKrjPXSlH0+AGcc
	jWjm1dvjR33hvySQOZQe9RguvYeucsG/AvcogNPtyIU50g1xS4KQ80aX41YpXJOlr8k/7YrV5Dztm
	TWudlcuTaYnP5zTsAP6kJ+yXb1R2qW+XQpDIFMA4/zWBRaWRI53hL4dOYZfRIhMCO6UP3L0lKuyvS
	0mUpaaMnEsWAVEzifjMOBfeLs3ejM4fasPgGqGGLnZvJ/CnfvS7aehMKqx84eI0Slw1dnE7+v33bA
	kN0iVlltRNPiffwxBrNp1qEh6pitSjdeQZ16rTxnoJ4D05rKzkXNBXktoRfQGfdl+sE2FEsE3BDiU
	eM+67XlQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sbIZd-00000006RBn-2453;
	Tue, 06 Aug 2024 11:41:53 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 5825F30066A; Tue,  6 Aug 2024 13:41:52 +0200 (CEST)
Date: Tue, 6 Aug 2024 13:41:52 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Song Liu <song@kernel.org>
Cc: linux-kernel@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>,
	Thomas Gleixner <tglx@linutronix.de>, Rob Herring <robh@kernel.org>,
	Will Deacon <will@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>
Subject: Re: [PATCH] Revert "perf: Add a counter for number of user access
 events in context"
Message-ID: <20240806114152.GW37996@noisy.programming.kicks-ass.net>
References: <20240805231031.1760371-1-song@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240805231031.1760371-1-song@kernel.org>

On Mon, Aug 05, 2024 at 04:10:31PM -0700, Song Liu wrote:
> This reverts commit 82ff0c022d19c2ad69a472692bb7ee01ac07a40b.
> 
> perf_event->nr_user is not used any more. Remove it.

Might be helpful to know where the user went..

> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Rob Herring <robh@kernel.org>
> Cc: Will Deacon <will@kernel.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
> Cc: Namhyung Kim <namhyung@kernel.org>
> Signed-off-by: Song Liu <song@kernel.org>
> ---
>  include/linux/perf_event.h | 1 -
>  kernel/events/core.c       | 4 ----
>  2 files changed, 5 deletions(-)
> 
> diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
> index 1a8942277dda..509ae4770bbe 100644
> --- a/include/linux/perf_event.h
> +++ b/include/linux/perf_event.h
> @@ -931,7 +931,6 @@ struct perf_event_context {
>  	struct list_head		event_list;
>  
>  	int				nr_events;
> -	int				nr_user;
>  	int				is_active;
>  
>  	int				nr_task_data;
> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index aa3450bdc227..6f44755ae907 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -1793,8 +1793,6 @@ list_add_event(struct perf_event *event, struct perf_event_context *ctx)
>  
>  	list_add_rcu(&event->event_entry, &ctx->event_list);
>  	ctx->nr_events++;
> -	if (event->hw.flags & PERF_EVENT_FLAG_USER_READ_CNT)
> -		ctx->nr_user++;
>  	if (event->attr.inherit_stat)
>  		ctx->nr_stat++;
>  
> @@ -2017,8 +2015,6 @@ list_del_event(struct perf_event *event, struct perf_event_context *ctx)
>  	event->attach_state &= ~PERF_ATTACH_CONTEXT;
>  
>  	ctx->nr_events--;
> -	if (event->hw.flags & PERF_EVENT_FLAG_USER_READ_CNT)
> -		ctx->nr_user--;
>  	if (event->attr.inherit_stat)
>  		ctx->nr_stat--;
>  
> -- 
> 2.43.5
> 

