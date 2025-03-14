Return-Path: <linux-kernel+bounces-561891-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EFFDA6182D
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 18:39:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 71366188F788
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 17:39:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F36E92045A5;
	Fri, 14 Mar 2025 17:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="M0dV2jm6"
Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com [95.215.58.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 340E52036E0
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 17:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741973949; cv=none; b=Ntz/Uo1CHhWRiNyUJ+G0ZY+nA3PRyjZgNtUzxkAP4jjN2B1gddh2muZMaBGQL3Qwar2bUkUs01kosZalfTj6wAfhUFiAO1hnxOwpbsU+iUQsbbkNl2KauN5Cj+Xg7hoyXA3WAdrzWFJqNzE3VN1asVwwvPMSBuyrjYZwKI7PsFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741973949; c=relaxed/simple;
	bh=PHdZRWeQ7ylwH9rabg+HUAzgax49mGzBpenAMxiNdf4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OslZmvG1VIWKWmhDtt744zjfpKTYIRhUpodlX8nV3QMO7tBSK6VPThkoX13me675/XVq+wH8tE7UBTo4/LmsojVS1GvhQYWA0Sxb7Igdh9daFYF7hPQJxTrop+0DLFZw8OtbngBfR2/VfmkVtJQG08i5Xm5EcNTfFhgin+HgzrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=M0dV2jm6; arc=none smtp.client-ip=95.215.58.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Fri, 14 Mar 2025 10:38:35 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1741973933;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zWi7wol7URKv7PqbpC5ssfeF0V5pQ7aeDMBGL83Sy1M=;
	b=M0dV2jm6zRqcXo2yTvwRlrFd66kFmp3T1EBe0FPhfuk266Yh4xxe3+UXMJ4J8eHGWI6y5j
	jFWv/LCWTuN3IrOTymNDtnKtrVx3Mfuv7nd1B/yKRn4FgoPAz1hiPT1PdwH/5xl0zqBe5R
	Sm/sbn6H0xD/tOn8l4cYWTQe1HCTRJs=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Vlastimil Babka <vbabka@suse.cz>, Tejun Heo <tj@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Michal Hocko <mhocko@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Muchun Song <muchun.song@linux.dev>, linux-mm@kvack.org, cgroups@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Meta kernel team <kernel-team@meta.com>
Subject: Re: [RFC PATCH 10/10] memcg: no more irq disabling for stock locks
Message-ID: <3uyrvm2vvpyplehpbhiroyiebrrpv7hgrv37fuq2vx7yiinfbs@exjiwtjavn52>
References: <20250314061511.1308152-1-shakeel.butt@linux.dev>
 <20250314061511.1308152-11-shakeel.butt@linux.dev>
 <9e1e3877-55ae-4546-a5c1-08ea730ea638@suse.cz>
 <20250314115802.DESa-C1z@linutronix.de>
 <2c62mvfo4726x3ci3sze7u55encoycbbzbaatzslkbhur2dkvd@wlli7wrcjlik>
 <20250314164234.KHdt_CWt@linutronix.de>
 <t6gqzrhipj3zxmev7pdmxbbbkx76eyscvkn4m66ifwcq3kfqtx@7jmqtzu5bs54>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <t6gqzrhipj3zxmev7pdmxbbbkx76eyscvkn4m66ifwcq3kfqtx@7jmqtzu5bs54>
X-Migadu-Flow: FLOW_OUT

On Fri, Mar 14, 2025 at 10:02:47AM -0700, Shakeel Butt wrote:
> On Fri, Mar 14, 2025 at 05:42:34PM +0100, Sebastian Andrzej Siewior wrote:
> > On 2025-03-14 08:55:51 [-0700], Shakeel Butt wrote:
> > > On Fri, Mar 14, 2025 at 12:58:02PM +0100, Sebastian Andrzej Siewior wrote:
> > > > On 2025-03-14 11:54:34 [+0100], Vlastimil Babka wrote:
> > > > > On 3/14/25 07:15, Shakeel Butt wrote:
> > > > > > Let's switch all memcg_stock locks acquire and release places to not
> > > > > > disable and enable irqs. There are two still functions (i.e.
> > > > > > mod_objcg_state() and drain_obj_stock) which needs to disable irqs to
> > > > > > update the stats on non-RT kernels. For now add a simple wrapper for
> > > > > > that functionality.
> > > > > 
> > > > > BTW, which part of __mod_objcg_mlstate() really needs disabled irqs and not
> > > > > just preemption? I see it does rcu_read_lock() anyway, which disables
> > > > > preemption. Then in __mod_memcg_lruvec_state() we do some __this_cpu_add()
> > > > > updates. I think these also are fine with just disabled preemption as they
> > > > > are atomic vs irqs (but don't need LOCK prefix to be atomic vs other cpus
> > > > > updates).
> > > > 
> > > > __this_cpu_add() is not safe if also used in interrupt context. Some
> > > > architectures (not x86) implemented as read, add, write.
> > > > this_cpu_add()() does the same but disables interrupts during the
> > > > operation.
> > > > So __this_cpu_add() should not be used if interrupts are not disabled
> > > > and a modification can happen from interrupt context.
> > > 
> > > So, if I use this_cpu_add() instead of __this_cpu_add() in
> > > __mod_memcg_state(), __mod_memcg_lruvec_state(), __count_memcg_events()
> > > then I can call these functions without disabling interrupts. Also
> > > this_cpu_add() does not disable interrupts for x86 and arm64, correct?
> > > For x86 and arm64, can I assume that the cost of this_cpu_add() is the
> > > same as __this_cpu_add()?
> > 
> > on arm64, __this_cpu_add will "load, add, store". preemptible.
> > this_cpu_add() will "disable preemption, atomic-load, add, atomic-store or
> > start over with atomic-load. if succeeded enable preemption and move an"
> 
> So, this_cpu_add() on arm64 is not protected against interrupts but is
> protected against preemption. We have a following comment in
> include/linux/percpu-defs.h. Is this not true anymore?
> 
> /*
>  * Operations with implied preemption/interrupt protection.  These
>  * operations can be used without worrying about preemption or interrupt.
>  */
> ...
> #define this_cpu_add(pcp, val)          __pcpu_size_call(this_cpu_add_, pcp, val)
> 

Just got clarification from Johannes & Tejun that this_cpu_add() is
indeed safe against irqs on arm64 as well. Basically arm64 uses loop of
Load Exclusive and Store Exclusive instruction to protect against irqs.
Defined in __PERCPU_OP_CASE() macro in arch/arm64/include/asm/percpu.h.

