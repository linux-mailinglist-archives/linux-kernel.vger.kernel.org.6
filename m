Return-Path: <linux-kernel+bounces-189849-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 50B778CF59C
	for <lists+linux-kernel@lfdr.de>; Sun, 26 May 2024 21:29:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7C7C11C20BF4
	for <lists+linux-kernel@lfdr.de>; Sun, 26 May 2024 19:29:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 673A18BE7;
	Sun, 26 May 2024 19:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ioYsn9+Q"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4AEB5231
	for <linux-kernel@vger.kernel.org>; Sun, 26 May 2024 19:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716751777; cv=none; b=HYNbGKeXNmGINh/qpfyRMEDjBEFiROX2UATDeYvk5rB7NcyAXeEzslNqQsPVjNShQ7jfj/5+8UWFf2NqzKFj1wYdfli6gy2igjmTImeOwoJqOY3q7ZGmMiRNu4Vind65P4xq9wi3/uuTdLZjVdk3kg6M1A2y3mQEshwfIhbc7Qk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716751777; c=relaxed/simple;
	bh=6f3OVUR126mQqphazmXjBWx6HkP9r58nBwsJg+iHtT8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GwcCSzuI1t/y9ETkaHc+zapCuwAVyK1PmiDXb55UaPGBsLIkyv/EzlTy2MPRD9SE/GkFZpqsiiP7KAJAONnwTqwmLrl95wWLlBZRGuz/VMmnrLut+wB+uW6VJuCgm4AFpKuO39NPzitGdf0i7zL7YaFDSbkF6KApFZFnJs14FFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ioYsn9+Q; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1716751774;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RK24F2wzxXyRWWsg0IS99CT+RTmRpCxyqLgYB7eJ4e8=;
	b=ioYsn9+QKhjsoUI4x4jJ7jKp7pUEDpCgufQ5NVjiw5si3OaDHXl+VSOlhYBwx9jZMffqRS
	pErGKitLYC4ul7Rx7pDWQUpSmJwjGjbhEv6MWHOoWXJX+Cplw/xuQ9vfpq/uGJRAtz/U95
	+lrAZE67ZxA+RFl3QXHfXkBEKxDJ4nE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-303-bFI8zcppPOe1BUv6dhs5nQ-1; Sun, 26 May 2024 15:29:29 -0400
X-MC-Unique: bFI8zcppPOe1BUv6dhs5nQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id F1F898029E1;
	Sun, 26 May 2024 19:29:28 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.27])
	by smtp.corp.redhat.com (Postfix) with SMTP id 3D3D1105480A;
	Sun, 26 May 2024 19:29:26 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Sun, 26 May 2024 21:28:01 +0200 (CEST)
Date: Sun, 26 May 2024 21:27:58 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Frederic Weisbecker <frederic@kernel.org>,
	Ingo Molnar <mingo@redhat.com>, Nicholas Piggin <npiggin@gmail.com>,
	Peter Zijlstra <peterz@infradead.org>, Phil Auld <pauld@redhat.com>,
	Chris von Recklinghausen <crecklin@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: Re: sched/isolation: tick_take_do_timer_from_boot() calls
 smp_call_function_single() with irqs disabled
Message-ID: <20240526192758.GA21193@redhat.com>
References: <20240522151742.GA10400@redhat.com>
 <20240523132358.GA1965@redhat.com>
 <87h6eneeu7.ffs@tglx>
 <ZlCwKk65-eL0FrKX@pavilion.home>
 <20240524183700.GA17065@redhat.com>
 <87v832dfw1.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87v832dfw1.ffs@tglx>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3

The more I grep the more I confused.

On 05/25, Thomas Gleixner wrote:
>
> Right. It does not happen because the kernel starts with jiffies as
> clocksource except on S390. The jiffies clocksource is not qualified to
> switch over to NOHZ mode for obvious reasons.

Not obvious for those who never looked at this code ;)

OK, clocksource_jiffies doesn't have CLOCK_SOURCE_VALID_FOR_HRES,

> fs_initcall(clocksource_done_booting)

So clocksource_done_booting() -> clocksource_select() should find another
CLOCK_SOURCE_VALID_FOR_HRES cs, then timekeeping_notify(best)

	- sets tk_core.timekeeper.tkr_mono.clock = best

	- calls tick_clock_notify() which sets .check_clocks on every cpu.

This makes tick_check_oneshot_change(false) return true. (I am ignoring the
highres=n case, tick_nohz_switch_to_nohz() doesn't really differ).

Now, on every CPU the next ->event_handler == tick_handle_periodic path
call hrtimer_switch_to_hres() which

	- sets ->event_handler == hrtimer_interrupt (tick_init_highres)
	  so tick_periodic/do_timer will be never called again

	- calls tick_setup_sched_timer() -> tick_nohz_activate() which
	  sets TS_FLAG_NOHZ

> [    1.918548] clocksource_done_booting: Switched to NOHZ // debug printk
>
> This is the point where tick_nohz_activate() is called first time and
> that does:
>
>   tick_sched_flag_set(ts, TS_FLAG_NOHZ);

See above, but I got lost, most probably I misunderstood these nontrivial
code paths.

> So up to this point the tick is never stopped neither on housekeeping
> nor on NOHZ FULL CPUs:
>
> tick_nohz_full_update_tick()
>   if (!tick_sched_flag_test(ts, TS_FLAG_NOHZ))
>     return;

OK... But tick_nohz_idle_update_tick() doesn't check TS_FLAG_NOHZ and
the tick_nohz_full_cpu() check can't help at boot time.

And I still don't understand why we can rely on can_stop_idle_tick() even
in tick_nohz_idle_stop_tick().

I'll try to read this code again tomorrow, but it will never fit my poor
little brain ;)

Oleg.


