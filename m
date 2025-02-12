Return-Path: <linux-kernel+bounces-511125-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23856A32640
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 13:50:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 209377A354D
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 12:49:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C803420E012;
	Wed, 12 Feb 2025 12:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="TmKLMHMC"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AF8F20E013
	for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 12:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739364595; cv=none; b=Fi2Mbsl6gTpnUOFFGEEmQ5p0OWw8EsdIIGJIBXzZThKUixP6/0tXFAsQoivgwS/WkK3FO8v7/r3PPmppDUAuqiSgujHqP1vjNDbQCzr9XehdCeaieMu+I3WXkKQNe+O0+TqIo/M8inm79OT8NEQUls4ewBUcWiNVUccWev9iCes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739364595; c=relaxed/simple;
	bh=Kk1uXuMCyi89H9Zj5sWMwT0E3fVPe/U5vpWZHmOo4H4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b/wfGyQGk8I3v482GDhTzqkFtHzU11Vz+b7t55zSzZxn2kBOu/4nu+yRCajM2iovdhuPhiOp+3iKCIGqrv1ElZAkHroh3PQ9E9gyOpNyPknQnjINb70kPWBQHCdtokqyC6BLRrgGR/z811BmBW5prnX5N9LYjLLeu6E+3EbqTxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=TmKLMHMC; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Coc/0LIzPmseOI/4EFzj4tOdcOeB0/JxO/a8At2AH90=; b=TmKLMHMClKnito8b1EvKd2LpFo
	QKGr1f2L8xRh76cI1EXGOk0F7R1UfW9oKDq3DOXrsj7Bx+1SyGfKc/RMJxZHiS+PBKWzH+uWbGHfo
	CCEffqyCV0QcJNyZj28nMpXJH1iipDaOUIYNf7uwT7YOLqcTVvJqgZfeztJ1Tt8O6ASx+kPrz4Z/+
	p/YGxyKTjYidsOvBVKMyGCzLjEvcvEZjPUs1Ggi1/9uxpfUyaWUTO6C71hW3tBymG5TfD0SZiUY8C
	d69phFy+5H0lay2mdtzfEogXKZt/xAnbayhEU8FkXmZfWtNFbY6gufhxBhYdnM9yJXD1vVSA+RPtf
	DEyfSInA==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tiCBX-00000000oTC-2BB7;
	Wed, 12 Feb 2025 12:49:47 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 83702300322; Wed, 12 Feb 2025 13:49:45 +0100 (CET)
Date: Wed, 12 Feb 2025 13:49:45 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Ravi Bangoria <ravi.bangoria@amd.com>
Cc: mingo@kernel.org, lucas.demarchi@intel.com,
	linux-kernel@vger.kernel.org, willy@infradead.org, acme@kernel.org,
	namhyung@kernel.org, mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com, jolsa@kernel.org,
	irogers@google.com, adrian.hunter@intel.com,
	kan.liang@linux.intel.com
Subject: Re: [PATCH v2 24/24] perf: Make perf_pmu_unregister() useable
Message-ID: <20250212124945.GH19118@noisy.programming.kicks-ass.net>
References: <20250205102120.531585416@infradead.org>
 <20250205102450.888979808@infradead.org>
 <1f4e4bb1-ba5e-4e5f-b6e3-e7603e3d6b0e@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1f4e4bb1-ba5e-4e5f-b6e3-e7603e3d6b0e@amd.com>

On Mon, Feb 10, 2025 at 12:12:40PM +0530, Ravi Bangoria wrote:
> > @@ -13467,7 +13665,13 @@ perf_event_exit_event(struct perf_event
> >  		 * Kick perf_poll() for is_event_hup();
> >  		 */
> >  		perf_event_wakeup(parent_event);
> > -		free_event(event);
> > +		/*
> > +		 * pmu_detach_event() will have an extra refcount.
> > +		 */
> > +		if (revoke)
> > +			put_event(event);
> > +		else
> > +			free_event(event);
> >  		put_event(parent_event);
> >  		return;
> >  	}
> 
> There is a race between do_exit() and perf_pmu_unregister():
> 
> Assume: a Parent process with 'event1' and a Child process with an
> inherited 'event2'.
> 
>                   CPU 1                                                       CPU 2
> 
>       Child process exiting ...
>    1  do_exit()
>    2    perf_event_exit_task()
>    3      perf_event_exit_task_context()
>    4        mutex_lock(&child_ctx->mutex);
>    5        list_for_each_entry_safe(&child_ctx->event_list)
>    6        /* picks event2. event2->refcount is 1 */
>    7                                                             perf_pmu_unregister()
>    8                                                               pmu_detach_events()
>    9                                                                 pmu_get_event(pmu) /* Picks event2 */
>   10                                                                   atomic_long_inc_not_zero(&event->refcount) /* event2 */
>   11                                                                   /* event2->refcount becomes 2 */
>   12                                                                 pmu_detach_event() /* event2 */
>   13                                                                   perf_event_ctx_lock(); /* event2 */
>   14        /* event2->refcount became 2 (by CPU 2) */                 .
>   15      perf_event_exit_event() /* event2 */                         . /* CPU 1 is holding ctx->mutex of
>   16        if (parent_event) { /* true */                             .    child process. Waiting ... */
>   17          if (revoke) /* false */                                  .
>   18          else                                                     .
>   19              free_event();  /* event2 */                          .
>   20                  WARN()                                           .
> 
>                       ^^^^^^
> 
> This race manifests as:
> 
>   unexpected event refcount: 2; ptr=00000000c6ca2049
>   WARNING: CPU: 57 PID: 9729 at kernel/events/core.c:5439 free_event+0x48/0x60
>   RIP: 0010:free_event+0x48/0x60
>   Call Trace:
>    ? free_event+0x48/0x60
>    perf_event_exit_event.isra.0+0x60/0xf0
>    perf_event_exit_task+0x1e1/0x280
>    do_exit+0x327/0xb00
> 
> The race continues... now, with the stale child2->parent pointer:
> 
>                   CPU 1                                                       CPU 2
> 
>   15      perf_event_exit_event() /* event2 */                         . /* CPU 1 is holding ctx->mutex of
>   16        if (parent_event) { /* true */                             .    child process. Waiting ... */
>   17          if (revoke) /* false */                                  .
>   18          else                                                     .
>   19              free_event();  /* event2 */                          .
>   20                  WARN()                                           .
>   21          put_event(parent_event); /* event1 */                    .
>   22          /* event1->refcount becomes 1 */                         .
>   23        }                                                          .
>   24        +- mutex_unlock(&child_ctx->mutex);                        . /* Acquired child's ctx->mutex */
>   25                                                                   __pmu_detach_event() /* event2 */
>   26                                                                     perf_event_exit_event() /* event2 */
>   27                                                                       if (parent_event) { /* true, BUT FALSE POSITIVE. */
>   28                                                                         if (revoke) /* true */
>   29                                                                             put_event(); /* event2 */
>   30                                                                             /* event2->refcount becomes 1 */
>   31                                                                         put_event(parent_event); /* event1 */
>   32                                                                         /* event1->refcount becomes 0 */
> 
>                                                                                 ^^^^^^^^^^^^^^^^^^^^^^^^^^
> 
> This can manifest as some random bug. I guess, perf_event_exit_event()
> should also check for (event->attach_state & PERF_ATTACH_CHILD) when
> event->parent != NULL.

Does this work?

--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -2303,6 +2303,7 @@ static void perf_child_detach(struct per
 
 	sync_child_event(event);
 	list_del_init(&event->child_list);
+	event->parent = NULL;
 }
 
 static bool is_orphaned_event(struct perf_event *event)

