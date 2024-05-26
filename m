Return-Path: <linux-kernel+bounces-189869-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 398AB8CF605
	for <lists+linux-kernel@lfdr.de>; Sun, 26 May 2024 22:52:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D26628119C
	for <lists+linux-kernel@lfdr.de>; Sun, 26 May 2024 20:52:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73B23139CFF;
	Sun, 26 May 2024 20:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p2Vpn1mp"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA6851A2C26
	for <linux-kernel@vger.kernel.org>; Sun, 26 May 2024 20:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716756753; cv=none; b=hzlVi4/K4+g99XHG24xhWBmsKs1ja8FJFwBbBS2yFKYBIFpKzMrF19NLk+4oBhkykw77IuBeM9/u9MJ76IVuPJJYQYD2o94w3087BrKyLn5W1h8h0ac3V35M8T1JzahYlDK6cWIsVPFBL3gNH1Z3bdCn84UY6l7cHZXbXu+SIiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716756753; c=relaxed/simple;
	bh=L0GLl0GqT5KmujDvu3QSZG4872mpUUMeYFAAIFtjrnQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sQaP6i9V8jP8V1j6ovH7iuZTN0/KHv9xL7nQGPqm1cDa+cWjKTNiojgQ4gtTEDB4EUrei5t/P6sPlp8htFhN3qXCiA7vS6tTqNAB/UWvDsYbV2UtyzmpcNOOazEYCXbjowlB+A3MhBWE8eyGpNc4cnLsydox9tPm6vwNoHR8Z4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p2Vpn1mp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7EC0C2BD10;
	Sun, 26 May 2024 20:52:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716756753;
	bh=L0GLl0GqT5KmujDvu3QSZG4872mpUUMeYFAAIFtjrnQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=p2Vpn1mp7Fp4ef7Lozmnx1r7aazDoes1f9s+lCOW6NoO6F18lYAqT9denSsN77xhC
	 EiNaCcQmhTUBvVSCLGtutAMl7ljy1eS5RvoQBJ58On84GHH4duHCne2REiOD+9rTS/
	 1HeHa6ovPWYq1k7lWaV+uySHyEf5CizigU9odTLhG59LU7cJjDUwdjZSZiIAta0R+G
	 TEx9V3DJjcciqMCwB9Qg897Dxdnec9otqOVxpm5tlo/HEh+iPJVaFgx/NCL1GZvnNK
	 MzJO7WbM4V1V8zceFg7a/OzrMnbSE6zrWrdPxCGuzaYSapHGqbaliNThGkZmTFpbD0
	 bmsqnWbYIscsQ==
Date: Sun, 26 May 2024 22:52:30 +0200
From: Frederic Weisbecker <frederic@kernel.org>
To: Oleg Nesterov <oleg@redhat.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Nicholas Piggin <npiggin@gmail.com>,
	Peter Zijlstra <peterz@infradead.org>, Phil Auld <pauld@redhat.com>,
	Chris von Recklinghausen <crecklin@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: Re: sched/isolation: tick_take_do_timer_from_boot() calls
 smp_call_function_single() with irqs disabled
Message-ID: <ZlOhDiqomHlumd-u@pavilion.home>
References: <20240522151742.GA10400@redhat.com>
 <20240523132358.GA1965@redhat.com>
 <87h6eneeu7.ffs@tglx>
 <ZlCwKk65-eL0FrKX@pavilion.home>
 <20240524183700.GA17065@redhat.com>
 <87v832dfw1.ffs@tglx>
 <20240526192758.GA21193@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240526192758.GA21193@redhat.com>

Le Sun, May 26, 2024 at 09:27:58PM +0200, Oleg Nesterov a écrit :
> > So up to this point the tick is never stopped neither on housekeeping
> > nor on NOHZ FULL CPUs:
> >
> > tick_nohz_full_update_tick()
> >   if (!tick_sched_flag_test(ts, TS_FLAG_NOHZ))
> >     return;
> 
> OK... But tick_nohz_idle_update_tick() doesn't check TS_FLAG_NOHZ and
> the tick_nohz_full_cpu() check can't help at boot time.

Yes but tick_nohz_idle_update_tick() is only called when the tick is already
stopped. And for the tick to be already stopped, TS_FLAG_NOHZ must have been
set.

> And I still don't understand why we can rely on can_stop_idle_tick() even
> in tick_nohz_idle_stop_tick().

Not sure I follow you on this one...

> 
> I'll try to read this code again tomorrow, but it will never fit my poor
> little brain ;)

You understood more than I ever did in just a few hours :-)

But yes the tick code was much more simple before I put my own hands
inside. nohz_full and cpuidle did not arrange it.

Thanks.

