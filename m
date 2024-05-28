Return-Path: <linux-kernel+bounces-191759-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CB0868D13C4
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 07:17:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 07BB61C21A3C
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 05:17:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CC844D5AA;
	Tue, 28 May 2024 05:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="HGGhQwFq"
Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF0364D108
	for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 05:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716873410; cv=none; b=dYLCyAmPBWje90TJGENJSjrDNScGSOEUs4ltM0zkCgSm8M7CpEAQgojIwHI2illw/K8PGweH35Q8AOHZGnpn0Xlas+oyFkHNi/nGDv6SfBQY60wfPThkVL4Duh3akGv4AdmUHQBrKNs/zqep9pzI1uup+YSqme+oEuZqL6+PZJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716873410; c=relaxed/simple;
	bh=NMLkvvg5qObSgClZZbO5bDWOjnVmIgpOQUbiedvX498=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SIjWdEkkvcG6bHvkIVtdGOfGsiFYcY7C3os/2RpKMBv/6hR5CsWoqtdOQnLhWGnmD7KsgcWYgfBX4CDUZ0ROohtNaw7zyVvuBoQffbS1/Y5ObK4XSRPjrNbHJ4z2WUyw0PHxKM8V8Hjv8OvA646L4QdlBDqmPLnemZOr2lfAK9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=HGGhQwFq; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: vbabka@kernel.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1716873406;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3PvMR9k1pGFigZouPy+tMRVCzX+R62W6OpqFaB67TC8=;
	b=HGGhQwFq+dRq6k8V3hc0wLl4PSQjCwaiqjWJGTuBoy6sot/EvSMUF9uoO6wgTW9RCaLBnj
	on9hvRA2ven7pvJ2qnp7M6NxUm6Vgr3vbNIknPjpYBsGp2tW+zIemHk0T9RgVWRV+EZgRc
	CSOSa25vfYAxSzsOrwyhsrpdD7UbHjs=
X-Envelope-To: bigeasy@linutronix.de
X-Envelope-To: akpm@linux-foundation.org
X-Envelope-To: hannes@cmpxchg.org
X-Envelope-To: mhocko@kernel.org
X-Envelope-To: roman.gushchin@linux.dev
X-Envelope-To: muchun.song@linux.dev
X-Envelope-To: linux-mm@kvack.org
X-Envelope-To: linux-kernel@vger.kernel.org
X-Envelope-To: tglx@linutronix.de
Date: Mon, 27 May 2024 22:16:41 -0700
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	Andrew Morton <akpm@linux-foundation.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Michal Hocko <mhocko@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Muchun Song <muchun.song@linux.dev>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v2] memcg: simple cleanup of stats update functions
Message-ID: <n6zstrcbqp7fqpennqf3qgt2nuc2tdrnsc5dmoawyke3zn3xcm@6uirkotvrhe6>
References: <20240420232505.2768428-1-shakeel.butt@linux.dev>
 <20240527152200.P1rU7FaG@linutronix.de>
 <86006806-4ffc-4330-ab4b-29215ab2c98c@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <86006806-4ffc-4330-ab4b-29215ab2c98c@kernel.org>
X-Migadu-Flow: FLOW_OUT

On Mon, May 27, 2024 at 06:34:24PM GMT, Vlastimil Babka (SUSE) wrote:
> On 5/27/24 5:22 PM, Sebastian Andrzej Siewior wrote:
> > On 2024-04-20 16:25:05 [-0700], Shakeel Butt wrote:
> >> mod_memcg_lruvec_state() is never called from outside of memcontrol.c
> >> and with always irq disabled. So, replace it with the irq disabled
> >> version and add an assert that irq is disabled in the caller.
> > 
> > unless PREEMPT_RT is enabled. In that case IRQs are not disabled as part
> > of local_lock_irqsave(&memcg_stock.stock_lock, …) leading to:

Sorry about that and thanks for the report.

> 
> But then the "interrupts are handled by a kernel thread that can sleep" part
> of RT also means it's ok to just have the stock_lock taken with no
> interrupts disabled as no actual raw interrupt handler will interrupt the
> holder and deadlock, right?
> 

Thanks Vlastimil for jolting my memory on RT reasoning.

> > | ------------[ cut here ]------------
> > | WARNING: CPU: 0 PID: 1 at mm/memcontrol.c:3150 __mod_objcg_mlstate+0xc2/0x110
> > | CPU: 0 PID: 1 Comm: systemd Not tainted 6.10.0-rc1-rt0+ #17
> > | Call Trace:
> > |  <TASK>
> > |  mod_objcg_state+0x2b3/0x320
> > |  __memcg_slab_post_alloc_hook+0x13c/0x340
> > |  kmem_cache_alloc_lru_noprof+0x2bd/0x2e0
> > |  alloc_inode+0x59/0xc0
> > |  iget_locked+0xf0/0x290
> > 
> > suggestions?
> 
> So in that case the appropriate thing would be to replace the assert with
> lockdep_assert_held(&memcg_stock.stock_lock);
> ?
> 
> It seems all the code paths leading here have that one.
> 

Yeah this seems right and reasonable. Should I send a fix or you want to
send it?

