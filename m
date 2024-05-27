Return-Path: <linux-kernel+bounces-191186-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 42B778D07C3
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 18:12:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A8B52885C6
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 16:11:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 520F617083C;
	Mon, 27 May 2024 15:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eQm7Oa3a"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 191C2168C31
	for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 15:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716825556; cv=none; b=ulWt2ucUKcHNcguJ0+4BQI8KB55uaUZW0u9m0JZjsqrrKDqM5ofiPmztmj6Fdblzhyd8LautixyTIC2WFCwq5HGwP5/ebWEYH6xpvH4IL0QWo/47hZOzpoMQvrekShNVfgFnb/eBphFi2vcowjplV4m/+RtJPa/F5RXidbmlQjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716825556; c=relaxed/simple;
	bh=+2MBnVSy/FwwVGNcD8DYPhWgNjfN7sTC7c+izVqBLCA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FXShtWvEJcQPxO1r4/wNrOJ00GGPybYkIE3/JMLL3B8YVJccefyWxHg0w1oWoeyUYq14nlD2zEyvNjZwuZQDX0Cyhp9gaVpDeNZ5kqCT5jIyUMkRPVBZPrR7jaHrSrvVasYoBYsacSj+29UQGFCNEr9BjpyuM6UCpHe7roJ5mA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eQm7Oa3a; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1716825554;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hfE5bqY12+J/fHuO8jUr2r6BVU+YoH1eMrP4/6WOM44=;
	b=eQm7Oa3alO0dnFB7SD3+bGW66n0L8yUuD7dyGQ6kSMOHgYabNwu2s4VFhrC/pulqgNOrLd
	o2wvXTVkzVUaNdwh5xedwH9YHGhxZIX7G1YTTStVLVFS7BjgJoZfH1Ht+gHrSBI5dEOH01
	YWsCXKBr0aj94mnEzdvxgpHUF0wpzIo=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-265-cndmWuTHNX2pA2bmzJNlYQ-1; Mon,
 27 May 2024 11:59:10 -0400
X-MC-Unique: cndmWuTHNX2pA2bmzJNlYQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5526729AA39D;
	Mon, 27 May 2024 15:59:10 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.41])
	by smtp.corp.redhat.com (Postfix) with SMTP id 43C7C3C27;
	Mon, 27 May 2024 15:59:08 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Mon, 27 May 2024 17:57:42 +0200 (CEST)
Date: Mon, 27 May 2024 17:57:39 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Nicholas Piggin <npiggin@gmail.com>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Frederic Weisbecker <frederic@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>, Phil Auld <pauld@redhat.com>,
	Chris von Recklinghausen <crecklin@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: Re: sched/isolation: tick_take_do_timer_from_boot() calls
 smp_call_function_single() with irqs disabled
Message-ID: <20240527155739.GB5733@redhat.com>
References: <20240522151742.GA10400@redhat.com>
 <20240523132358.GA1965@redhat.com>
 <87h6eneeu7.ffs@tglx>
 <ZlCwKk65-eL0FrKX@pavilion.home>
 <20240524183700.GA17065@redhat.com>
 <87v832dfw1.ffs@tglx>
 <20240526192758.GA21193@redhat.com>
 <D1KDJILBPEKS.27MVR6A44NMX8@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <D1KDJILBPEKS.27MVR6A44NMX8@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1

On 05/27, Nicholas Piggin wrote:
>
> On Mon May 27, 2024 at 5:27 AM AEST, Oleg Nesterov wrote:
> > The more I grep the more I confused.
> >
> > On 05/25, Thomas Gleixner wrote:
> > >
> > > Right. It does not happen because the kernel starts with jiffies as
> > > clocksource except on S390. The jiffies clocksource is not qualified to
> > > switch over to NOHZ mode for obvious reasons.
> >
> > Not obvious for those who never looked at this code ;)
> >
> > OK, clocksource_jiffies doesn't have CLOCK_SOURCE_VALID_FOR_HRES,
>
> jiffies clocksource requires a timer to run it I suppose.

I meant, this is enough to ensure that clocksource_done_booting() paths should
find another cs, best != curr_clocksource, and call timekeeping_notify().

Nevermind, quite possibly I misread this code.

> > And I still don't understand why we can rely on can_stop_idle_tick() even
> > in tick_nohz_idle_stop_tick().
>
> AFAIKS timer_expires_base would be 0 unless tick_nohz_next_event()
> were called, but that is only called from places that checked
> can_stop_idle_tick() or is already a tick_nohz_full() CPU.

OK, thanks.

So, Frederic, Nicholas, any objections to the trivial change below?

We can cleanup the tick_do_timer_boot_cpu logic on top of it.

Oleg.

--- a/kernel/time/tick-common.c
+++ b/kernel/time/tick-common.c
@@ -178,26 +178,6 @@ void tick_setup_periodic(struct clock_event_device *dev, int broadcast)
 	}
 }
 
-#ifdef CONFIG_NO_HZ_FULL
-static void giveup_do_timer(void *info)
-{
-	int cpu = *(unsigned int *)info;
-
-	WARN_ON(tick_do_timer_cpu != smp_processor_id());
-
-	tick_do_timer_cpu = cpu;
-}
-
-static void tick_take_do_timer_from_boot(void)
-{
-	int cpu = smp_processor_id();
-	int from = tick_do_timer_boot_cpu;
-
-	if (from >= 0 && from != cpu)
-		smp_call_function_single(from, giveup_do_timer, &cpu, 1);
-}
-#endif
-
 /*
  * Setup the tick device
  */
@@ -231,9 +211,8 @@ static void tick_setup_device(struct tick_device *td,
 
 		} else if (tick_do_timer_boot_cpu != -1 &&
 						!tick_nohz_full_cpu(cpu)) {
-			tick_take_do_timer_from_boot();
 			tick_do_timer_boot_cpu = -1;
-			WARN_ON(READ_ONCE(tick_do_timer_cpu) != cpu);
+			WRITE_ONCE(tick_do_timer_cpu, cpu);
 #endif
 		}
 


