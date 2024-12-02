Return-Path: <linux-kernel+bounces-427185-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01B4A9DFDD1
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 10:54:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C14F5163282
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 09:54:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B73AA1FBCB1;
	Mon,  2 Dec 2024 09:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="qfUfxddg"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFBCC1F949
	for <linux-kernel@vger.kernel.org>; Mon,  2 Dec 2024 09:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733133259; cv=none; b=HUotIbO4ghsaWZ4YmMSDscRL0GPWb4bCF6hAF28CKbVlsw+Mhf++aUrgR44sczpXHwjt7vWVvjcEl4QWT8wj/TYbSpi4LZq6u04vHRc8Djgrntq3Cl0mY6YX/LLCyl2CK5vg8kCkpFM+4DTp2gIkC2omr6QZiqZSbDklRpwOuyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733133259; c=relaxed/simple;
	bh=ebPBjN63bFKnUG/J74q17ZyfC4Rh1nDJRDw9WpaXtJo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SKXRz2acwp00PyV2nDrk852P0AtqPpOB2ClGBYNRRibAuoWbJSJsgpXbJTRjlQFX20X9g8k9ey4ATa5yhjr+E8qkZdJWRxjz0AXF5oEyScb7aNzXquBYmyXR65rYDz9m1cvtEtaJg6xv4ywDE4YRYdkoKHzqo28rtYsmHRGyRKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=qfUfxddg; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=1v3vZEldFiKc+6jPSwS92TvCI9mU5ixa4KrkWb6cDTw=; b=qfUfxddgZ8TLQWQqWp+/hgwloe
	564zRkfsJsUUdxsJuVR3lkdM/4Wo2UwaDdL4ZM/Ar9fKM6995Rcfe1mkw+t8pmgTpdpp24f+5bvW3
	Nivis1WaxbVLl96pUe7dzC+XmJol0X8NR6Hbwpt3y76tggifyai14hTKjiaOFjg666xQmtiFZ9GTz
	nDsfcCzo5HDPtSMoWoLQ4c/OZb3ulZUhcHdzC5OscBA54ROCgJwKTC9LIStLi0MOJLXT5I0cVyJJ2
	lyc2MOUYZNKe15Dn71+T2lyL4P+KU4MXgxXBCIukaaBEWv7tZGPSM2LmQque/UE4by7zfyxy3s1r+
	SL35S6Dg==;
Received: from 77-249-17-89.cable.dynamic.v4.ziggo.nl ([77.249.17.89] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tI37x-00000007o1m-2al2;
	Mon, 02 Dec 2024 09:54:03 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 03CC2300402; Mon,  2 Dec 2024 10:54:02 +0100 (CET)
Date: Mon, 2 Dec 2024 10:54:01 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Vincent Guittot <vincent.guittot@linaro.org>
Cc: mingo@redhat.com, juri.lelli@redhat.com, dietmar.eggemann@arm.com,
	rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
	vschneid@redhat.com, linux-kernel@vger.kernel.org,
	kprateek.nayak@amd.com, pauld@redhat.com, efault@gmx.de,
	luis.machado@arm.com
Subject: Re: [PATCH 03/10 v2] sched/fair: Add new cfs_rq.h_nr_runnable
Message-ID: <20241202095401.GJ24400@noisy.programming.kicks-ass.net>
References: <20241129161756.3081386-1-vincent.guittot@linaro.org>
 <20241129161756.3081386-4-vincent.guittot@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241129161756.3081386-4-vincent.guittot@linaro.org>

On Fri, Nov 29, 2024 at 05:17:49PM +0100, Vincent Guittot wrote:
> With delayed dequeued feature, a sleeping sched_entity remains queued in
> the rq until its lag has elapsed. As a result, it stays also visible
> in the statistics that are used to balance the system and in particular
> the field cfs.h_nr_queued when the sched_entity is associated to a task.
> 
> Create a new h_nr_runnable that tracks all queued and runnable tasks and
> use it when balancing the load on the system.
> 
> h_nr_runnable will be used in several places to make decision on load
> balance:
> - PELT runnable_avg
> - deciding if a group is overloaded or has spare capacity
> - numa stats
> - reduced capacity management
> - load balance
> - nohz kick
> 
> It should be noticed that the rq->nr_running still counts the delayed
> dequeued tasks as delayed dequeue is a fair feature that is meaningless
> at core level.

Since you're doing a v3, could you please split this into 2 patches, one
adding the accounting, and then a separate patch making use of it?

