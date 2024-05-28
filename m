Return-Path: <linux-kernel+bounces-191913-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A72F68D15FF
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 10:13:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 47E081F23352
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 08:13:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B54782837F;
	Tue, 28 May 2024 08:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D/aObtLz"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04D5F13AA54
	for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 08:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716883856; cv=none; b=AV7GU4Z4InbJXGoM8NXD1l1BP9ia4lkIxKUGgvibRHUkPeY1EMGXLyZ1fqnJLzA3WBWzXA/iTVzu1EZe0tfv7+ocWeGPmNUxNe81dgLliiy7W7RQ5j1Z510LkgopHGlC8AFMxN+nsblOasTU3e7z8UXEq4uaaFOT1QeuFpxIV+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716883856; c=relaxed/simple;
	bh=3JWi8QLCnAiMD/3J4oBlHOEY+0eLHBNVPmIqYMw0BFM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=myaw0qaGbOJbNKPE5+Q0046pCeF1cubfOz5ePf+G7VmcVcQ/M+jbC7TjaWtctI3I4O9ksLjCS1egz43NK8Qr2UTCAU6GZurau1G9lLRgR4uJm4F9ftoaPAah2ke5GrXacapvZaebxK+mUrhKTHtz+UdSFhm5s1/dwPDhQw6/FIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D/aObtLz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E49FC3277B;
	Tue, 28 May 2024 08:10:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716883855;
	bh=3JWi8QLCnAiMD/3J4oBlHOEY+0eLHBNVPmIqYMw0BFM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=D/aObtLzXz5XBzdB9HiGDNLSWr3F4gw8VeWwnYEqoD+wq0c6hA9VO+9e9Fb8rHYoE
	 f2TtwvUDnt3wPiizZEMYux1tp74d2kSTWguRqMjQhb7aqkYzbmS0ApTWCw/D9Tn2B4
	 YsJo8Lb5+mrWLAM4f1Bsm0IVepQBpPbGRq7qaP2aXCgz8GWjxm/6qprnmuTeOYyxNQ
	 NvM67O7uAY4rkXCm+UcGMjZzxETPnKHspSXMa3KT8Q0xOJe+46/yEby+OoYru9tO8u
	 4d/Nk2++LbMHUXtyZz12PZawAtyDLGqoAEG/83+LFw7tNZ9ozzqbu37VrJsnCInbHJ
	 Gb/SW7kqRThKw==
Message-ID: <69c0e008-ddde-4a38-b856-b765dc2b9745@kernel.org>
Date: Tue, 28 May 2024 10:10:50 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] memcg: simple cleanup of stats update functions
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Shakeel Butt <shakeel.butt@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 Muchun Song <muchun.song@linux.dev>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>
References: <20240420232505.2768428-1-shakeel.butt@linux.dev>
 <20240527152200.P1rU7FaG@linutronix.de>
 <86006806-4ffc-4330-ab4b-29215ab2c98c@kernel.org>
 <n6zstrcbqp7fqpennqf3qgt2nuc2tdrnsc5dmoawyke3zn3xcm@6uirkotvrhe6>
 <20240528075623.oFcU1JLj@linutronix.de>
Content-Language: en-US
From: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
In-Reply-To: <20240528075623.oFcU1JLj@linutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 5/28/24 9:56 AM, Sebastian Andrzej Siewior wrote:
> On 2024-05-27 22:16:41 [-0700], Shakeel Butt wrote:
>> On Mon, May 27, 2024 at 06:34:24PM GMT, Vlastimil Babka (SUSE) wrote:
>> > On 5/27/24 5:22 PM, Sebastian Andrzej Siewior wrote:
>> > > On 2024-04-20 16:25:05 [-0700], Shakeel Butt wrote:
>> > >> mod_memcg_lruvec_state() is never called from outside of memcontrol.c
>> > >> and with always irq disabled. So, replace it with the irq disabled
>> > >> version and add an assert that irq is disabled in the caller.
>> > > 
>> > > unless PREEMPT_RT is enabled. In that case IRQs are not disabled as part
>> > > of local_lock_irqsave(&memcg_stock.stock_lock, …) leading to:
>> 
>> Sorry about that and thanks for the report.
> 
> no worries.
> 
>> > 
>> > But then the "interrupts are handled by a kernel thread that can sleep" part
>> > of RT also means it's ok to just have the stock_lock taken with no
>> > interrupts disabled as no actual raw interrupt handler will interrupt the
>> > holder and deadlock, right?
> 
> I *don't* know why the interrupts-disabled check is here. The
> memcg_stock.stock_lock is acquired on RT with interrupts enabled and
> never disables interrupts. The lock is never acquired in an hard
> interrupt (not threaded interrupt) context so there is never a deadlock.
> 
> Originally the interrupts were disabled in mod_memcg_lruvec_state()
> because the counter, it operates on, is per-CPU and relies on disabled
> interrupts because the operation is not atomic and the code can be run
> in interrupts context (on !RT). The __mod_memcg_lruvec_state() variant
> of it relied on interrupts being disabled by the caller. This "rely on"
> was part of a spinlock_t lock (or invoked from an interrupt handler, the
> memory is fading slowly away) which does not disable interrupts on
> PREEMPT_RT.
> So for that reason we ended up with __memcg_stats_lock() which disables
> preemption only on PREEMPT_RT to achieve the same level of "atomic"
> update.
> 
>> Thanks Vlastimil for jolting my memory on RT reasoning.
>> 
>> > > suggestions?
>> > 
>> > So in that case the appropriate thing would be to replace the assert with
>> > lockdep_assert_held(&memcg_stock.stock_lock);
>> > ?
>> > 
>> > It seems all the code paths leading here have that one.
>> > 
>> 
>> Yeah this seems right and reasonable. Should I send a fix or you want to
>> send it?
> 
> I don't mind sending a patch. I'm just not sure if the lock is the right
> thing to do. However it should ensure that interrupts are disabled on
> !RT for the sake of the counter update (if observed in IRQ context).

Looks like some places there use VM_WARN_ON_IRQS_ENABLED() that's turned off
for PREEMPT_RT, so maybe that's what should replace the current
lockdep_assert, perhaps together with
lockdep_assert_held(this_cpu_ptr(&memcg_stock.stock_lock));

But also __mod_memcg_lruvec_state() already has that VM_WARN_ON.

> Yeah, let me prepare something.
> 
> Sebastian


