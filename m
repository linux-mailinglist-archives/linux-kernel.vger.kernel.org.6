Return-Path: <linux-kernel+bounces-197884-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 784AA8D705C
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jun 2024 16:05:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 12C5B1F212A4
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jun 2024 14:05:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FC271514FB;
	Sat,  1 Jun 2024 14:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="e/o1Rocw"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD37C2A1AA
	for <linux-kernel@vger.kernel.org>; Sat,  1 Jun 2024 14:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717250702; cv=none; b=AlRlaIN7T0GOh893XQmQTg2S5+teu5JMpM1PIMXlv+Th5JcD6uWIwbB8xJV43JNy4R/osIcEysJ8GYWW8YGwve555ONTTyRQRb9FYuFO8VbDiXSN58NYmjbOIMSbDG/wA/2KAsggab7eArjC/xqBWq2q6tudmqaB2onouUTTjeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717250702; c=relaxed/simple;
	bh=Sv6fyPAWAiCqjEqChNh44LDu+c6409ub4wxlMPE19nA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t9Ln2pvnndSgL3sZihk7+lH1J4u0oMZ/UMbTyldXr/RVzB/Lf0XUnNox9HvQoNt1/EgZ072U0V5ZesU8c23fC2F+Rv9l5STKfykQtkugQg/KDrM/Hc+hC38c9pGAs9LLT94rimm0o44Pn0qmsPJCzuMAhPiRrLQtenXfK0enRMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=e/o1Rocw; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717250699;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8wOHAGnZ8bkDJn8tyHm2l/TYxESrqQ2JfmPVHBd885s=;
	b=e/o1Rocw2ULNcKXr4c2LR0KgsLqmaYKfUqZ4G9Z7+Fcv9j1LKFOD7JoVZYkhx+RDYaT197
	8tJ3I1xPxBN0u8LvQ3JekYTBhSczyaL81Pr0WRAXOchNBNEpOlw+mcdsK+VRyGlkVTba1I
	gFNBkx6hJwNByEewi0XOe1bdBIxock4=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-625-1d0v6lKPObGtVNSBJNV5uA-1; Sat,
 01 Jun 2024 10:04:52 -0400
X-MC-Unique: 1d0v6lKPObGtVNSBJNV5uA-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 66DCF3C025AD;
	Sat,  1 Jun 2024 14:04:52 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.19])
	by smtp.corp.redhat.com (Postfix) with SMTP id 59222401405;
	Sat,  1 Jun 2024 14:04:50 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Sat,  1 Jun 2024 16:03:24 +0200 (CEST)
Date: Sat, 1 Jun 2024 16:03:22 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Frederic Weisbecker <frederic@kernel.org>
Cc: Ingo Molnar <mingo@redhat.com>, Nicholas Piggin <npiggin@gmail.com>,
	Peter Zijlstra <peterz@infradead.org>, Phil Auld <pauld@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Chris von Recklinghausen <crecklin@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tick/nohz_full: don't abuse smp_call_function_single()
 in tick_setup_device()
Message-ID: <20240601140321.GA3758@redhat.com>
References: <20240522151742.GA10400@redhat.com>
 <20240528122019.GA28794@redhat.com>
 <ZliSt-RDyxf1bZ_t@localhost.localdomain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZliSt-RDyxf1bZ_t@localhost.localdomain>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10

Hi Frederic,

First of all, can we please make the additional changes you suggest on top of
this patch? I'd prefer to keep it as simple as possible, I will need to backport
it and I'd like to simplify the internal review.

On 05/30, Frederic Weisbecker wrote:
>
> And after all, pushing a bit further your subsequent patch, can we get rid of
> tick_do_timer_boot_cpu and ifdefery altogether? Such as:

Sure, I thought about this from the very beginning, see
https://lore.kernel.org/all/20240525135120.GA24152@redhat.com/
and the changelog in
[PATCH] tick/nohz_full: turn tick_do_timer_boot_cpu into boot_cpu_is_nohz_full
https://lore.kernel.org/all/20240530124032.GA26833@redhat.com/
on top of this patch.

And yes, in this case it is better to check that tick_do_timer_cpu != _NONE to
ensure that tick_nohz_full_cpu(tick_cpu) can't crash.

So I considered the change which is very close to yours, except

> +		} else if (timekeeper == TICK_DO_TIMER_NONE) {
> +			if (WARN_ON_ONCE(tick_nohz_full_enabled()))
> +				WRITE_ONCE(tick_do_timer_cpu, cpu);

I don't think we need to change tick_do_timer_cpu in this case.
And I am not sure we need to check tick_nohz_full_enabled() here.
IOW, I was thinking about

	if (!td->evtdev) {
		int tick_cpu = READ_ONCE(tick_do_timer_cpu);
		/*
		 * If no cpu took the do_timer update, assign it to
		 * this cpu:
		 */
		if (tick_cpu == TICK_DO_TIMER_BOOT) {
			WRITE_ONCE(tick_do_timer_cpu, cpu);
			tick_next_period = ktime_get();
			/*
			 * The boot CPU may be nohz_full, in which case the
			 * first housekeeping secondary will take do_timer()
			 * from us.
			 */
		} else if (!WARN_ON_ONCE(tick_cpu == TICK_DO_TIMER_NONE)) &&
			   tick_nohz_full_cpu(tick_cpu) &&
			   !tick_nohz_full_cpu(cpu)) {
			/*
			 * The boot CPU will stay in periodic (NOHZ disabled)
			 * mode until clocksource_done_booting() called after
			 * smp_init() selects a high resolution clocksource and
			 * timekeeping_notify() kicks the NOHZ stuff alive.
			 *
			 * So this WRITE_ONCE can only race with the READ_ONCE
			 * check in tick_periodic() but this race is harmless.
			 */
			WRITE_ONCE(tick_do_timer_cpu, cpu);
		}

But you know, somehow I like
[PATCH] tick/nohz_full: turn tick_do_timer_boot_cpu into boot_cpu_is_nohz_full
https://lore.kernel.org/all/20240530124032.GA26833@redhat.com/
a bit more, to me the code looks more understandable this way.

Note that this patch doesn't really need to keep #ifdef CONFIG_NO_HZ_FULL,

	if (!td->evtdev) {
		static bool boot_cpu_is_nohz_full;
		/*
		 * If no cpu took the do_timer update, assign it to
		 * this cpu:
		 */
		if (READ_ONCE(tick_do_timer_cpu) == TICK_DO_TIMER_BOOT) {
			WRITE_ONCE(tick_do_timer_cpu, cpu);
			tick_next_period = ktime_get();
			/*
			 * The boot CPU may be nohz_full, in which case the
			 * first housekeeping secondary will take do_timer()
			 * from us.
			 */
			boot_cpu_is_nohz_full = tick_nohz_full_cpu(cpu);
		} else if (boot_cpu_is_nohz_full && !tick_nohz_full_cpu(cpu)) {
			boot_cpu_is_nohz_full = false;
			/*
			 * The boot CPU will stay in periodic (NOHZ disabled)
			 * mode until clocksource_done_booting() called after
			 * smp_init() selects a high resolution clocksource and
			 * timekeeping_notify() kicks the NOHZ stuff alive.
			 *
			 * So this WRITE_ONCE can only race with the READ_ONCE
			 * check in tick_periodic() but this race is harmless.
			 */
			WRITE_ONCE(tick_do_timer_cpu, cpu);
		}

should work without #ifdef.

In this case I don't think we need the _NONE check, tick_sched_do_timer() will
complain.

But I won't argue. I will be happy to make V2 which follows your recommendations
but again, can I do this on top of this patch?

Oleg.


