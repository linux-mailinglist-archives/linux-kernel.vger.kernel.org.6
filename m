Return-Path: <linux-kernel+bounces-190419-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E8A6C8CFE04
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 12:23:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 86D341F21FB8
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 10:23:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6B3B13AD2A;
	Mon, 27 May 2024 10:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="yjj+DmYx";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="jSwWA1Hu"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4F3313B79B
	for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 10:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716805426; cv=none; b=mNSY/XRW/hqN/BztRIxn22qHU1he+HeS7SCH7Izj8cj240+Kf3JJ+ejR+RBJ+/3eYOwHFuSEVcNi1q90JF+ffyejN4v3/OxcCGFY4yLJGDjRlUm2WpUQpIUESCXvl3r3MqZSAJYZxLghQFlJBVpjvKXz0z3mSSs/wbxEjTZ+pxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716805426; c=relaxed/simple;
	bh=i3vdeAypAzvlzDDD6HqhwpuYW/F7goIsrwm8HIum47o=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=QCHWguiyrUtZXqjG72WejPMRAb7xhgr1yFzA4PFcchHJ2LRgdigVPkM5TlW5FDcqV/8Z9Kq9mU0t6QmxvBpId5RvIY9RnvW0HcLJ1YTqoDkwGMTMl8oGMKy+1Hsvi1nWlzqOxa3DPKW4A06GF2cQeccLH6zvG4gmjhZzPdhCf8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=yjj+DmYx; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=jSwWA1Hu; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1716805423;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xAi79tNwAZNKGUrFRXRD/7kC5b85OqYaOCNzQ5fyfEk=;
	b=yjj+DmYxI9Nv/1XC+qKfhZqGe2qNZ8BAAiUthqF6qqx3q+6QE8NA2sDGKYzvJbw44Bj6qv
	VhGsAYVfjFM2v3zzl+fX+738g8c1BbIp0MfkRFhbPCBuHc/A7RdYdpl6Q0i5AJlLift0et
	bGT9wgxLN3CHkjN1PWMFFEWuUxOvv1EAJys6J1Mr47KI2BquCwoCq6x6t0IWPYNoGjaN4D
	UeYKW3NVtw72y15WXSdDsWo+BXxQYkDkMZ5/YnRtjQL8NHTHCd0I2ojr+DpYZC8tAT5Qi3
	Zso+r9a3lvKI0BksJOQklu66xbnSVZ4o4olknjc0xj8S/0lTcxCGOOvFkSp/wA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1716805423;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xAi79tNwAZNKGUrFRXRD/7kC5b85OqYaOCNzQ5fyfEk=;
	b=jSwWA1HupkoQl0DYR7t1kbmKacA5c5thpqWGeXFyU3HzWLoRqByKs+xz8u5VOt5o1TUQfr
	FMLBb8BYfnlUwIBA==
To: Nicholas Piggin <npiggin@gmail.com>, Oleg Nesterov <oleg@redhat.com>,
 Frederic Weisbecker <frederic@kernel.org>
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 Phil Auld <pauld@redhat.com>, Chris von
 Recklinghausen <crecklin@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: sched/isolation: tick_take_do_timer_from_boot() calls
 smp_call_function_single() with irqs disabled
In-Reply-To: <D1KB5Z1455DI.3HOVYR566ZGXN@gmail.com>
References: <20240522151742.GA10400@redhat.com>
 <20240523132358.GA1965@redhat.com> <87h6eneeu7.ffs@tglx>
 <ZlCwKk65-eL0FrKX@pavilion.home> <20240524183700.GA17065@redhat.com>
 <87v832dfw1.ffs@tglx> <D1KB5Z1455DI.3HOVYR566ZGXN@gmail.com>
Date: Mon, 27 May 2024 12:23:42 +0200
Message-ID: <87ed9nd041.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Mon, May 27 2024 at 19:10, Nicholas Piggin wrote:
> On Sat May 25, 2024 at 8:06 AM AEST, Thomas Gleixner wrote:
>> along with the removal of the SMP function call voodoo programming gunk,
>> a lengthy changelog and a bunch of useful comments.
>
> I might not have tested that path on powerpc since it should not
> switch clockevent driver (or clocksource either I think) at least
> on 64-bit.  Explains the smp_call_function warning if you are
> testing on x86 :/

Even on PowerPC the per CPU clockevent driver is registered during early
boot for the boot CPU and for the APs when they are onlined. Before your
change the boot CPU was unconditionally taking over the do_timer duty
and never gave up on it in the NOHZ full case.

The logic you added allows that the duty is taken by the first
housekeeping CPU in the case that the boot CPU is marked NOHZ full.

So yes, that function call _is_ invoked on PowerPC too if the boot CPU
is NOHZ full. There is absolutely nothing x86 specific.

The difference is that PowerPC registers the per CPU clockevent _before_
setting the CPU online and x86 does it afterwards.

So the warning does not trigger on PowerPC because:

   WARN_ON_ONCE(cpu_online(this_cpu) && irqs_disabled() && ...);

Thanks,

        tglx


