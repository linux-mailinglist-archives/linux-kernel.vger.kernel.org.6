Return-Path: <linux-kernel+bounces-198446-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC8648D7845
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jun 2024 23:29:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E67011C20A62
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jun 2024 21:29:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B35D078C79;
	Sun,  2 Jun 2024 21:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IYv9nFD8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEB103C2D
	for <linux-kernel@vger.kernel.org>; Sun,  2 Jun 2024 21:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717363757; cv=none; b=lI9QpkqUs6A7tHY8XD5cesvNnQG2XFxhMGSBAcRkIGVFAQXAOlS0bpO1PyOVc6wJXxzUKLDKCiWSsFWXiUPZ69lFTZXDiGjn8VAUw2Z7KgMfUk3oEG1PtVv7mN1cZz3xRMyeeaW/JIDD10Wh7R578XRpLZ9JBfSdnQgPXNtlarU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717363757; c=relaxed/simple;
	bh=1vqt2V+7MDT26Ii7pi4e+LsYEkhNVLQJB5s6dJZNILI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uZNQmVcqeCeoBpqKHIRMydKUBzqseON+kAnLM8UBaZh4on4DtfDzI7ci0cSHuP5BBYIcv5xanVTKu/+EleYdHntNF++/E74+ltMCaKHpfxfyHGg/KO9wYa/uuaPDLGq9TbR9Zf1c+/HHkw31FN3o8XEwqzbNa5NKR5LLUcgb2+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IYv9nFD8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28049C2BBFC;
	Sun,  2 Jun 2024 21:29:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717363756;
	bh=1vqt2V+7MDT26Ii7pi4e+LsYEkhNVLQJB5s6dJZNILI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IYv9nFD8p4fT9gp89TK7L0Bv84peRZaqrCCRyejVOqxaawQykn6XeRgt9S62pAR+Q
	 hEJVuUHW5LwlO1y+xn9Tr3tzv2pDQzE6TKu2ifIBV69Se425ypaBvnYTx45lfwPvw9
	 /BESNflkAZV8FYUNekEvA+tkiIPTtP/YsRpY++vQTej/A6jWFIYmOeATiYcTD/U5v5
	 JMlTPdTOpQQlDuhZCgUdfrtVcrkukOOlA1oSgZeMvbTr9vb7Ix5Hts6Ld6rPXe0xmQ
	 Sk0cax5xc3ZMk8v9C9OGHUWc8ocObkEzM/nK2PbAXLntfgzlRXGqDHtra2WtGBkgn0
	 IBcvkIWyFiK3w==
Date: Sun, 2 Jun 2024 23:29:08 +0200
From: Frederic Weisbecker <frederic@kernel.org>
To: Oleg Nesterov <oleg@redhat.com>
Cc: Ingo Molnar <mingo@redhat.com>, Nicholas Piggin <npiggin@gmail.com>,
	Peter Zijlstra <peterz@infradead.org>, Phil Auld <pauld@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Chris von Recklinghausen <crecklin@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tick/nohz_full: don't abuse smp_call_function_single()
 in tick_setup_device()
Message-ID: <ZlzkJGPEIfWC3Ue1@pavilion.home>
References: <20240522151742.GA10400@redhat.com>
 <20240528122019.GA28794@redhat.com>
 <ZliSt-RDyxf1bZ_t@localhost.localdomain>
 <20240601140321.GA3758@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240601140321.GA3758@redhat.com>

Le Sat, Jun 01, 2024 at 04:03:22PM +0200, Oleg Nesterov a écrit :
> Hi Frederic,
> 
> First of all, can we please make the additional changes you suggest on top of
> this patch? I'd prefer to keep it as simple as possible, I will need to backport
> it and I'd like to simplify the internal review.

Sure!

> 
> On 05/30, Frederic Weisbecker wrote:
> >
> > And after all, pushing a bit further your subsequent patch, can we get rid of
> > tick_do_timer_boot_cpu and ifdefery altogether? Such as:
> 
> Sure, I thought about this from the very beginning, see
> https://lore.kernel.org/all/20240525135120.GA24152@redhat.com/
> and the changelog in
> [PATCH] tick/nohz_full: turn tick_do_timer_boot_cpu into boot_cpu_is_nohz_full
> https://lore.kernel.org/all/20240530124032.GA26833@redhat.com/
> on top of this patch.
> 
> And yes, in this case it is better to check that tick_do_timer_cpu != _NONE to
> ensure that tick_nohz_full_cpu(tick_cpu) can't crash.
> 
> So I considered the change which is very close to yours, except
> 
> > +		} else if (timekeeper == TICK_DO_TIMER_NONE) {
> > +			if (WARN_ON_ONCE(tick_nohz_full_enabled()))
> > +				WRITE_ONCE(tick_do_timer_cpu, cpu);
> 
> I don't think we need to change tick_do_timer_cpu in this case.
> And I am not sure we need to check tick_nohz_full_enabled() here.
> IOW, I was thinking about

Hmm, in case of cpu-hotplug operations (that is after boot), we may be
past nohz enablement and therefore it might be TICK_DO_TIMER_NONE.

> 
> 	if (!td->evtdev) {
> 		int tick_cpu = READ_ONCE(tick_do_timer_cpu);
> 		/*
> 		 * If no cpu took the do_timer update, assign it to
> 		 * this cpu:
> 		 */
> 		if (tick_cpu == TICK_DO_TIMER_BOOT) {
> 			WRITE_ONCE(tick_do_timer_cpu, cpu);
> 			tick_next_period = ktime_get();
> 			/*
> 			 * The boot CPU may be nohz_full, in which case the
> 			 * first housekeeping secondary will take do_timer()
> 			 * from us.
> 			 */
> 		} else if (!WARN_ON_ONCE(tick_cpu == TICK_DO_TIMER_NONE)) &&
> 			   tick_nohz_full_cpu(tick_cpu) &&
> 			   !tick_nohz_full_cpu(cpu)) {
> 			/*
> 			 * The boot CPU will stay in periodic (NOHZ disabled)
> 			 * mode until clocksource_done_booting() called after
> 			 * smp_init() selects a high resolution clocksource and
> 			 * timekeeping_notify() kicks the NOHZ stuff alive.
> 			 *
> 			 * So this WRITE_ONCE can only race with the READ_ONCE
> 			 * check in tick_periodic() but this race is harmless.
> 			 */
> 			WRITE_ONCE(tick_do_timer_cpu, cpu);
> 		}
> 
> But you know, somehow I like
> [PATCH] tick/nohz_full: turn tick_do_timer_boot_cpu into boot_cpu_is_nohz_full
> https://lore.kernel.org/all/20240530124032.GA26833@redhat.com/
> a bit more, to me the code looks more understandable this way.
> 
> Note that this patch doesn't really need to keep #ifdef CONFIG_NO_HZ_FULL,
> 
> 	if (!td->evtdev) {
> 		static bool boot_cpu_is_nohz_full;
> 		/*
> 		 * If no cpu took the do_timer update, assign it to
> 		 * this cpu:
> 		 */
> 		if (READ_ONCE(tick_do_timer_cpu) == TICK_DO_TIMER_BOOT) {
> 			WRITE_ONCE(tick_do_timer_cpu, cpu);
> 			tick_next_period = ktime_get();
> 			/*
> 			 * The boot CPU may be nohz_full, in which case the
> 			 * first housekeeping secondary will take do_timer()
> 			 * from us.
> 			 */
> 			boot_cpu_is_nohz_full = tick_nohz_full_cpu(cpu);
> 		} else if (boot_cpu_is_nohz_full && !tick_nohz_full_cpu(cpu)) {
> 			boot_cpu_is_nohz_full = false;
> 			/*
> 			 * The boot CPU will stay in periodic (NOHZ disabled)
> 			 * mode until clocksource_done_booting() called after
> 			 * smp_init() selects a high resolution clocksource and
> 			 * timekeeping_notify() kicks the NOHZ stuff alive.
> 			 *
> 			 * So this WRITE_ONCE can only race with the READ_ONCE
> 			 * check in tick_periodic() but this race is harmless.
> 			 */
> 			WRITE_ONCE(tick_do_timer_cpu, cpu);
> 		}
> 
> should work without #ifdef.
> 
> In this case I don't think we need the _NONE check, tick_sched_do_timer() will
> complain.

Right...

> 
> But I won't argue. I will be happy to make V2 which follows your recommendations
> but again, can I do this on top of this patch?

I guess the static version above should work to remove the ifdef. And yes on top is fine.

Thanks!

