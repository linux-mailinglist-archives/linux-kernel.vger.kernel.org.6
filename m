Return-Path: <linux-kernel+bounces-541908-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6EC0A4C344
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 15:22:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 01E5F3A646A
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 14:21:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BE0420B7FB;
	Mon,  3 Mar 2025 14:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Md9vTZbL"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA94778F40
	for <linux-kernel@vger.kernel.org>; Mon,  3 Mar 2025 14:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741011715; cv=none; b=bF+yrG1UtZtkdyArBDmfvJzDSU7A6800xN8VpCaZRW/ucBQFuH/+GRsiUORiC0G/hnQHU9UCy5hrc479iWl6VLod0ePjUW7kQmUVSag2o6Wdhfq9VLQUFp9yEj5s9WaCz0lpG+FJqTKDtcw9col3UoGA/dYsTiZEd8e0uEQUGoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741011715; c=relaxed/simple;
	bh=lpedDVxZE0DQoY8GMHlwLA2B2sZCBM/rsaWS4jtNZY8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MqMUTgUx/1agPDaoDi3h0mFN/FcoZYMzIYsqLiaVzShtEIul6uBea2ZSqAaL9zh9zPfyp5OOEiCy4u2x7jCakrAU92H8W3n7+MLvoehvMwv+u8ecKCPW+i0w7KMJAGCow6+v6lPk4FU31si9xDNqRz3twR0qU8Cb/Yft7hweTX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Md9vTZbL; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741011712;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HqofTmYQBRdv0TUnm4x4h0Nmvh8yzQvSSMCzHPsKE5g=;
	b=Md9vTZbLsoie7TDIaGboRHgKGR1oVZmlV2X7rUQ6E24hQFLkt7el5r+4bRx+RQeSEGqDvX
	lXrUNBO5Jsd05acigod4xG8pkBDNjawRzueUogbC/tVOy9F+mmmhYuUr9V1b41Vh7QTS2i
	hF5vMzDOrkeQy+Rh7hCPjACzLRpuKU4=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-159-B09R4LCsMIqfZoFaFng9iQ-1; Mon,
 03 Mar 2025 09:21:51 -0500
X-MC-Unique: B09R4LCsMIqfZoFaFng9iQ-1
X-Mimecast-MFC-AGG-ID: B09R4LCsMIqfZoFaFng9iQ_1741011710
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id AD02819783B9;
	Mon,  3 Mar 2025 14:21:49 +0000 (UTC)
Received: from pauld.westford.csb (unknown [10.22.89.22])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D7AD3300019F;
	Mon,  3 Mar 2025 14:21:46 +0000 (UTC)
Date: Mon, 3 Mar 2025 09:21:44 -0500
From: Phil Auld <pauld@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Waiman Long <longman@redhat.com>,
	Vishal Chourasia <vishalc@linux.ibm.com>,
	Vineeth Reddy <vineethr@linux.ibm.com>
Subject: Re: [PATCH v2] sched/isolation: Make use of more than one
 housekeeping cpu
Message-ID: <20250303142144.GB190558@pauld.westford.csb>
References: <20250218184618.1331715-1-pauld@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250218184618.1331715-1-pauld@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Hi

On Tue, Feb 18, 2025 at 06:46:18PM +0000 Phil Auld wrote:
> The exising code uses housekeeping_any_cpu() to select a cpu for
> a given housekeeping task. However, this often ends up calling
> cpumask_any_and() which is defined as cpumask_first_and() which has
> the effect of alyways using the first cpu among those available.
> 
> The same applies when multiple NUMA nodes are involved. In that
> case the first cpu in the local node is chosen which does provide
> a bit of spreading but with multiple HK cpus per node the same
> issues arise.
> 
> We have numerous cases where a single HK cpu just cannot keep up
> and the remote_tick warning fires. It also can lead to the other
> things (orchastration sw, HA keepalives etc) on the HK cpus getting
> starved which leads to other issues.  In these cases we recommend
> increasing the number of HK cpus.  But... that only helps the
> userspace tasks somewhat. It does not help the actual housekeeping
> part.
> 
> Spread the HK work out by having housekeeping_any_cpu() and
> sched_numa_find_closest() use cpumask_any_and_distribute()
> instead of cpumask_any_and().
> 
> Signed-off-by: Phil Auld <pauld@redhat.com>
> Reviewed-by: Waiman Long <longman@redhat.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Juri Lelli <juri.lelli@redhat.com>
> Cc: Frederic Weisbecker <frederic@kernel.org>
> Cc: Waiman Long <longman@redhat.com>
> Cc: linux-kernel@vger.kernel.org
> Link: https://lore.kernel.org/lkml/20250211141437.GA349314@pauld.westford.csb/

Friendly ping...

Frederic, anyone else, thoughts?

Cheers,
Phil

> 
> ---
> 
> v2: Fix subject line. Update commit message. No code change. 
> 
>  kernel/sched/isolation.c | 2 +-
>  kernel/sched/topology.c  | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/sched/isolation.c b/kernel/sched/isolation.c
> index 81bc8b329ef1..93b038d48900 100644
> --- a/kernel/sched/isolation.c
> +++ b/kernel/sched/isolation.c
> @@ -40,7 +40,7 @@ int housekeeping_any_cpu(enum hk_type type)
>  			if (cpu < nr_cpu_ids)
>  				return cpu;
>  
> -			cpu = cpumask_any_and(housekeeping.cpumasks[type], cpu_online_mask);
> +			cpu = cpumask_any_and_distribute(housekeeping.cpumasks[type], cpu_online_mask);
>  			if (likely(cpu < nr_cpu_ids))
>  				return cpu;
>  			/*
> diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
> index c49aea8c1025..94133f843485 100644
> --- a/kernel/sched/topology.c
> +++ b/kernel/sched/topology.c
> @@ -2101,7 +2101,7 @@ int sched_numa_find_closest(const struct cpumask *cpus, int cpu)
>  	for (i = 0; i < sched_domains_numa_levels; i++) {
>  		if (!masks[i][j])
>  			break;
> -		cpu = cpumask_any_and(cpus, masks[i][j]);
> +		cpu = cpumask_any_and_distribute(cpus, masks[i][j]);
>  		if (cpu < nr_cpu_ids) {
>  			found = cpu;
>  			break;
> -- 
> 2.47.1
> 
> 

-- 


