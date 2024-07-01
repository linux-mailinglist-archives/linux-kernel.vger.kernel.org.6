Return-Path: <linux-kernel+bounces-235506-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01F8891D5EE
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 04:09:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EDDA22819C2
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 02:09:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8D4679F9;
	Mon,  1 Jul 2024 02:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iN+dYJZ6"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D61FDF5C
	for <linux-kernel@vger.kernel.org>; Mon,  1 Jul 2024 02:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719799788; cv=none; b=YueV3PH/nqZIoJt+1FFkL2mf/+dSzWVxvqvjXie5MraHXK1PQXjOCYEc/QZ5eBWWWHTzCCKlugMTZduBqWw4P5AGVL7gCDSawlmf2sGTjyiFEFKWHbg7/s7sA04qkd96J3jpQWMjdr4cAKI1xewVQl4lTZaCtQoJ8Qr65k6Fki8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719799788; c=relaxed/simple;
	bh=/wd3LnG2ga9Hft6t4lrf1Af+kA3o7IIoJmye8zqEneI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Df2Kpw8es4pa/HxToNdz5WsoQQjJCHRXRmfRB898kMzPkERey9fO1aUAv9JhafNXmJAqosGmQr7Du3JgbBJeIV99yFQ53Uld9o6s/LTSZjlKz3mtThLu2IM9PX9otkFf5kqOOowj0IkEPjTiAjf3lQFeyGgX0Xvi1gM+Mc9rQyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iN+dYJZ6; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719799786;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YFBv2GNzfwr96rwHa3FF1YMIpAUxs+Y9neXUQdtqtGE=;
	b=iN+dYJZ6+v4cYETqV40f7hMKP4S4g24ahVHGl+SrYnjNPm0sS3sQv7mC+ADt3aXeyD2hNI
	rWahmbmrwBrPdStyMqkvGVxoj3vKlQyzBAA+csWUMDVXx1yHmSC4nmTZGilmvGpjwcYU0Z
	oViN6fzJzORfPoTSaIyoft7ApEfPqLc=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-434-rNlGfnrSPya_7Tl82MuDLg-1; Sun,
 30 Jun 2024 22:09:42 -0400
X-MC-Unique: rNlGfnrSPya_7Tl82MuDLg-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 03491194510D;
	Mon,  1 Jul 2024 02:09:34 +0000 (UTC)
Received: from fedora (unknown [10.72.112.45])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id CB67819560A3;
	Mon,  1 Jul 2024 02:09:22 +0000 (UTC)
Date: Mon, 1 Jul 2024 10:09:17 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Daniel Wagner <dwagner@suse.de>
Cc: Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	Thomas Gleixner <tglx@linutronix.de>,
	Christoph Hellwig <hch@lst.de>,
	Frederic Weisbecker <fweisbecker@suse.com>,
	Mel Gorman <mgorman@suse.de>, Hannes Reinecke <hare@suse.de>,
	Sridhar Balaraman <sbalaraman@parallelwireless.com>,
	"brookxu.cn" <brookxu.cn@gmail.com>, linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
	ming.lei@redhat.com
Subject: Re: [PATCH v2 3/3] lib/group_cpus.c: honor housekeeping config when
 grouping CPUs
Message-ID: <ZoIPzQNEsUWOWp3f@fedora>
References: <20240627-isolcpus-io-queues-v2-0-26a32e3c4f75@suse.de>
 <20240627-isolcpus-io-queues-v2-3-26a32e3c4f75@suse.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240627-isolcpus-io-queues-v2-3-26a32e3c4f75@suse.de>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On Thu, Jun 27, 2024 at 04:10:53PM +0200, Daniel Wagner wrote:
> group_cpus_evenly distributes all present CPUs into groups. This ignores
> the isolcpus configuration and assigns isolated CPUs into the groups.
> 
> Make group_cpus_evenly aware of isolcpus configuration and use the
> housekeeping CPU mask as base for distributing the available CPUs into
> groups.
> 
> Fixes: 11ea68f553e2 ("genirq, sched/isolation: Isolate from handling managed interrupts")
> Signed-off-by: Daniel Wagner <dwagner@suse.de>
> ---
>  lib/group_cpus.c | 75 ++++++++++++++++++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 73 insertions(+), 2 deletions(-)
> 
> diff --git a/lib/group_cpus.c b/lib/group_cpus.c
> index ee272c4cefcc..19fb7186f9d4 100644
> --- a/lib/group_cpus.c
> +++ b/lib/group_cpus.c
> @@ -8,6 +8,7 @@
>  #include <linux/cpu.h>
>  #include <linux/sort.h>
>  #include <linux/group_cpus.h>
> +#include <linux/sched/isolation.h>
>  
>  #ifdef CONFIG_SMP
>  
> @@ -330,7 +331,7 @@ static int __group_cpus_evenly(unsigned int startgrp, unsigned int numgrps,
>  }
>  
>  /**
> - * group_cpus_evenly - Group all CPUs evenly per NUMA/CPU locality
> + * group_possible_cpus_evenly - Group all CPUs evenly per NUMA/CPU locality
>   * @numgrps: number of groups
>   *
>   * Return: cpumask array if successful, NULL otherwise. And each element
> @@ -344,7 +345,7 @@ static int __group_cpus_evenly(unsigned int startgrp, unsigned int numgrps,
>   * We guarantee in the resulted grouping that all CPUs are covered, and
>   * no same CPU is assigned to multiple groups
>   */
> -struct cpumask *group_cpus_evenly(unsigned int numgrps)
> +static struct cpumask *group_possible_cpus_evenly(unsigned int numgrps)
>  {
>  	unsigned int curgrp = 0, nr_present = 0, nr_others = 0;
>  	cpumask_var_t *node_to_cpumask;
> @@ -423,6 +424,76 @@ struct cpumask *group_cpus_evenly(unsigned int numgrps)
>  	}
>  	return masks;
>  }
> +
> +/**
> + * group_mask_cpus_evenly - Group all CPUs evenly per NUMA/CPU locality
> + * @numgrps: number of groups
> + * @cpu_mask: CPU to consider for the grouping
> + *
> + * Return: cpumask array if successful, NULL otherwise. And each element
> + * includes CPUs assigned to this group.
> + *
> + * Try to put close CPUs from viewpoint of CPU and NUMA locality into
> + * same group. Allocate present CPUs on these groups evenly.
> + */
> +static struct cpumask *group_mask_cpus_evenly(unsigned int numgrps,
> +					      const struct cpumask *cpu_mask)
> +{
> +	cpumask_var_t *node_to_cpumask;
> +	cpumask_var_t nmsk;
> +	int ret = -ENOMEM;
> +	struct cpumask *masks = NULL;
> +
> +	if (!zalloc_cpumask_var(&nmsk, GFP_KERNEL))
> +		return NULL;
> +
> +	node_to_cpumask = alloc_node_to_cpumask();
> +	if (!node_to_cpumask)
> +		goto fail_nmsk;
> +
> +	masks = kcalloc(numgrps, sizeof(*masks), GFP_KERNEL);
> +	if (!masks)
> +		goto fail_node_to_cpumask;
> +
> +	build_node_to_cpumask(node_to_cpumask);
> +
> +	ret = __group_cpus_evenly(0, numgrps, node_to_cpumask, cpu_mask, nmsk,
> +				  masks);
> +
> +fail_node_to_cpumask:
> +	free_node_to_cpumask(node_to_cpumask);
> +
> +fail_nmsk:
> +	free_cpumask_var(nmsk);
> +	if (ret < 0) {
> +		kfree(masks);
> +		return NULL;
> +	}
> +	return masks;
> +}
> +
> +/**
> + * group_cpus_evenly - Group all CPUs evenly per NUMA/CPU locality
> + * @numgrps: number of groups
> + *
> + * Return: cpumask array if successful, NULL otherwise.
> + *
> + * group_possible_cpus_evently() is used for distributing the cpus on all
> + * possible cpus in absence of isolcpus command line argument.
> + * group_mask_cpu_evenly() is used when the isolcpus command line
> + * argument is used with managed_irq option. In this case only the
> + * housekeeping CPUs are considered.
> + */
> +struct cpumask *group_cpus_evenly(unsigned int numgrps)
> +{
> +	const struct cpumask *hk_mask;
> +
> +	hk_mask = housekeeping_cpumask(HK_TYPE_MANAGED_IRQ);
> +	if (!cpumask_empty(hk_mask))
> +		return group_mask_cpus_evenly(numgrps, hk_mask);
> +
> +	return group_possible_cpus_evenly(numgrps);

Since this patch, some isolated CPUs may not be covered in
blk-mq queue mapping.

Meantime people still may submit IO workload from isolated CPUs
such as by 'taskset -c', blk-mq may not work well for this situation,
for example, IO hang may be caused during cpu hotplug.

I did see this kind of usage in some RH Openshift workloads.

If blk-mq problem can be solved, I am fine with this kind of
change. 


Thanks,
Ming


