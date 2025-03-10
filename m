Return-Path: <linux-kernel+bounces-554637-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C4FAA59ACB
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 17:17:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 26EA23A80C6
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 16:16:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F5B522F155;
	Mon, 10 Mar 2025 16:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="oItISY0F"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2305F22F17A
	for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 16:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741623418; cv=none; b=eSbbQNjf1yte0eL+vIUO0pvi/6oBCuebeyhXOMJDPjHGPGdw3uZpFTkROp2TgMlpoFLGDJTA9zTRY1eDQDLAwI93bog8t21/a2e88nbRhNg/hRKcjkbTvjwVe3aKQ7ESrTmAmqEKpxkwu1i3cqsf0Y6xM1IhsQ+p+MzDlyhVj4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741623418; c=relaxed/simple;
	bh=emb9auBSHxF4tlyXoWTp5NptCPzqIIHlSVkgFyPWSts=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eJC6ctGdRtoqs2lGzG6MzdbdVa/m8XECyyLEGzaQ65buksRMqXBZ1b5lWO3yxI3xXG3f04MN+uTp0g4pJgRMFnBszH7leX3jYgd2qSjOYtXUHNaZ1/N9FchS5kRIKaUemc4Ij3+qQi/y8Yz9qX1Dfw0ehmLzZ5NJGqW7OYjHWr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=oItISY0F; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=ERs6yabp7PifLMJ8plQdpvIMPOx6OSaUkIpbf+aPDzY=; b=oItISY0FIccmGQGGcaASKtVlIM
	BafAVkQduuWkDl3em2sjHuQ6oyOIlLzKejJYJXGRMjT0x95GEflo3kgv+A62bR7QIR2wXQ9QD3Y6P
	C/XpeaJ17N2NLXxesRzQSStIRornfx/paGQQxaYu40kTmUMm7W4luTTPpyxjlGsMCFF+UKYb8XBmI
	1TJG5PRssBwS/y4aX3/7UIbxx0DUSBgfvlcMPRxj5n7ny1AkWre2TIa4oDcT10bSXVpAESbcBq0yU
	AY1/N0z7S9oO8eCec5wvgxsgHmz+fokrLh1lX998Acl3DESFuKKDmdpaA13u/cknjLiZc46LQgigu
	twNWptyw==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1trfmA-00000007Qsx-3T0l;
	Mon, 10 Mar 2025 16:16:01 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id EA065300599; Mon, 10 Mar 2025 17:14:45 +0100 (CET)
Date: Mon, 10 Mar 2025 17:14:45 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Ravi Bangoria <ravi.bangoria@amd.com>
Cc: mingo@kernel.org, lucas.demarchi@intel.com,
	linux-kernel@vger.kernel.org, acme@kernel.org, namhyung@kernel.org,
	mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
	jolsa@kernel.org, irogers@google.com, adrian.hunter@intel.com,
	kan.liang@linux.intel.com
Subject: Re: [PATCH v3 7/7] perf: Make perf_pmu_unregister() useable
Message-ID: <20250310161445.GI19344@noisy.programming.kicks-ass.net>
References: <20250307193305.486326750@infradead.org>
 <20250307193723.525402029@infradead.org>
 <0f36ca48-09ab-4fca-8a8d-7ed3b2abc056@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0f36ca48-09ab-4fca-8a8d-7ed3b2abc056@amd.com>

On Mon, Mar 10, 2025 at 09:05:45PM +0530, Ravi Bangoria wrote:
> > @@ -207,6 +207,7 @@ static void perf_ctx_unlock(struct perf_
> >  }
> >  
> >  #define TASK_TOMBSTONE ((void *)-1L)
> > +#define EVENT_TOMBSTONE ((void *)-1L)
> >  
> >  static bool is_kernel_event(struct perf_event *event)
> >  {
> > @@ -2348,6 +2349,11 @@ static void perf_child_detach(struct per
> >  
> >  	sync_child_event(event);
> >  	list_del_init(&event->child_list);
> > +	/*
> > +	 * Cannot set to NULL, as that would confuse the situation vs
> > +	 * not being a child event. See for example unaccount_event().
> > +	 */
> > +	event->parent = EVENT_TOMBSTONE;
> 
> This will cause issues where we do `event = event->parent`. No? For ex:
> 
>   perf_pmu_unregister()
>     ...
>       perf_event_exit_event()
>         perf_event_wakeup()
>           ring_buffer_wakeup()
>             if (event->parent)
>               event = event->parent;

It will. However, if we do not do this, we have a potential
use-after-free, and people seem to take a dim view of those too :-)

I had convinced myself all paths that were doing this 'event =
event->parent' were unreachable by the time we set the TOMBSTONE, but
clearly I missed one.

I suppose we can do something like so, not really pretty though.

--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -13722,9 +13722,12 @@ perf_event_exit_event(struct perf_event
 {
 	struct perf_event *parent_event = event->parent;
 	unsigned long detach_flags = DETACH_EXIT;
+	bool parent_dead = false;
 
-	if (parent_event == EVENT_TOMBSTONE)
+	if (parent_event == EVENT_TOMBSTONE) {
 		parent_event = NULL;
+		parent_dead = true;
+	}
 
 	if (parent_event) {
 		/*
@@ -13748,6 +13751,9 @@ perf_event_exit_event(struct perf_event
 
 	perf_remove_from_context(event, detach_flags);
 
+	if (parent_dead)
+		return;
+
 	/*
 	 * Child events can be freed.
 	 */

