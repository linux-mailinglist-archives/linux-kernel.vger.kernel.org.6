Return-Path: <linux-kernel+bounces-188774-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C6D68CE6B9
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 16:12:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2A13CB21D62
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 14:12:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFB3B12C47F;
	Fri, 24 May 2024 14:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GwmCAUjg"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DF4786146
	for <linux-kernel@vger.kernel.org>; Fri, 24 May 2024 14:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716559949; cv=none; b=KLcHN9qzCrNWw7+Rp4IWcdi6mrJJy5O336JqAztwkua9IWr9NPrd2cO65cjz3w6d48JL7GBk+QlXMyk9eFJJks58rtxaNH/F8fNYNs05mvlNHxsqRaaIXJaXWoo7hM6ailwMkt09Pk9NZ1e0TEM/js2dcuMIfGOf7FyWU86c2Y8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716559949; c=relaxed/simple;
	bh=3OBUEf+k9+/S53fi7pJ9nrmzNo/rGjvpS1jIyBj4xjU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LQ+dKz8GN+y041mlpGqySvnrADE8xxyJD9Okg8QTTueyvcbpWuRbOhlZpdSbg4Td7YzWqbyBORMMZudukmGFB8lqX66/oOolDUql+fLjz9hkcmVjIectZ5OuvL20G11Blpb11ERBx7GKYecPRjGF3d8GoKMbSzb0wKvxw8Hwm7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GwmCAUjg; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1716559945;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cMrniT4MB7fift7AHz8aclN4rykTNGKWpu+SRc/tZkI=;
	b=GwmCAUjgFxtzEKygEOYoIpX6Ge69jTfPtPSqTXO9237+74G72hJccAczT+LaZarRrB3LcZ
	Lm/dTuDoW67w6b/idrA3q/JaMYj9RAW6je7M9IUwBLb+MeGmPiqXUPQ2kge+CnLlvAItJY
	1HgOcReUcdlYnadz7ptJB1jS1bxrOqo=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-518-BijyvRmXNtaX6jLzc7Qd-w-1; Fri,
 24 May 2024 10:12:22 -0400
X-MC-Unique: BijyvRmXNtaX6jLzc7Qd-w-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B280829AA2C8;
	Fri, 24 May 2024 14:12:21 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.56])
	by smtp.corp.redhat.com (Postfix) with SMTP id A54FF1C09480;
	Fri, 24 May 2024 14:12:19 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Fri, 24 May 2024 16:10:54 +0200 (CEST)
Date: Fri, 24 May 2024 16:10:52 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Frederic Weisbecker <frederic@kernel.org>,
	Ingo Molnar <mingo@redhat.com>, Nicholas Piggin <npiggin@gmail.com>,
	Peter Zijlstra <peterz@infradead.org>, Phil Auld <pauld@redhat.com>,
	Chris von Recklinghausen <crecklin@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: Re: sched/isolation: tick_take_do_timer_from_boot() calls
 smp_call_function_single() with irqs disabled
Message-ID: <20240524141018.GA14261@redhat.com>
References: <20240522151742.GA10400@redhat.com>
 <20240523132358.GA1965@redhat.com>
 <87h6eneeu7.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87h6eneeu7.ffs@tglx>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7

Hi Thomas,

On 05/24, Thomas Gleixner wrote:
>
> >> But I don't even understand why exactly we need smp_call_function()...
>
> It's not required at all.
>
> >> Race with tick_nohz_stop_tick() on boot CPU which can set
> >> tick_do_timer_cpu = TICK_DO_TIMER_NONE? Is it really bad?
>
> This can't happen.
>
> > And is it supposed to happen if tick_nohz_full_running ?
> >
> > tick_sched_do_timer() and can_stop_idle_tick() claim that
> > TICK_DO_TIMER_NONE is not possible in this case...
>
> What happens during boot is:
>
>   1) The boot CPU takes the do_timer duty when it installs its
>      clockevent device
>
>   2) The boot CPU does not give up the duty because of this
>      condition in can_stop_idle_tick():
>
>      if (tick_nohz_full_enabled()) {
>      	if (tick_cpu == cpu)
>            return false;

Yes, I have looked at this code too. But I failed to understand its
callers, even tick_nohz_idle_stop_tick() which doesn't even call this
function when ts->timer_expires != 0.

This code is too tricky for me, I still don't follow the logic.
Damn, I can't even remember the names of all these functions ;)

> > So, once again, could you explain why the patch below is wrong?
>
> > -			tick_take_do_timer_from_boot();
> >  			tick_do_timer_boot_cpu = -1;
> > -			WARN_ON(READ_ONCE(tick_do_timer_cpu) != cpu);
> > +			WRITE_ONCE(tick_do_timer_cpu, cpu);
>
> This part is perfectly fine.

Great, thanks! I'll write the changelog and send the patch tomorrow.

> > --- a/kernel/time/tick-sched.c
> > +++ b/kernel/time/tick-sched.c
> > @@ -1014,6 +1014,9 @@ static void tick_nohz_stop_tick(struct tick_sched *ts, int cpu)
> >  	 */
> >  	tick_cpu = READ_ONCE(tick_do_timer_cpu);
> >  	if (tick_cpu == cpu) {
> > +#ifdef CONFIG_NO_HZ_FULL
> > +		WARN_ON_ONCE(tick_nohz_full_running);
> > +#endif
>
>                 WARN_ON_ONCE(tick_nohz_full_enabled());
>
> which spares the ugly #ifdef?

Yes but tick_nohz_full_enabled() depends on context_tracking_key, and
context_tracking_enabled() is false without CONFIG_CONTEXT_TRACKING_USER.
I didn't even try to check if it is selected by NO_HZ_FULL and how do
they play together.

But you know, I won't include this WARN_ON_ONCE(), I have added it for
(very basic) testing. We have another WARN_ON(tick_nohz_full_running)
in tick_sched_do_timer(), I guess it should be enough.

Thanks!

Oleg.


