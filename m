Return-Path: <linux-kernel+bounces-196284-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EAFDC8D59B6
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 06:59:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A0CE1C2379D
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 04:59:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88E0378C73;
	Fri, 31 May 2024 04:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="p+XBukZ1"
Received: from smtp-fw-6001.amazon.com (smtp-fw-6001.amazon.com [52.95.48.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8A8B39FF3
	for <linux-kernel@vger.kernel.org>; Fri, 31 May 2024 04:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.95.48.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717131545; cv=none; b=E794cyymV/ksZK1ZUz1Ck1vxSJQvZ+f/R4gQndmWuGQjtLw9wIRlcGnRiVU7Jc0YD8hVsXmbrReZypLJ8jVm3S2sQCLXr2Jl2ai0amIZYLHuCZkQcSEfrz/AJjl6tydZ4B0apNF0Qc+i1m+1/m0La2N1a7N8iA/kVIwYzZe7fWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717131545; c=relaxed/simple;
	bh=8d4LGhAZpnANkAPZi2Rz6nn5/d59XJQA0XyqwimboQw=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f0pccQLxqKN/3LdjbZXYcpfnDHcTCZx2XisHNdwFlstgXixjv5vMGijTie/iIPe5rEbG7lz3o6gVkNMXCvklz38r8qInrwDHwDtfMUChR5pKzeRuC7I9NRopm5lbhf4CV7GxnD8IZAJl9qVlAv4AU2Byscgb8+jXBvhGtyZNtXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=p+XBukZ1; arc=none smtp.client-ip=52.95.48.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1717131544; x=1748667544;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=BHHQNm4rjPB4mXDmlcn3ohEO7va2GBW9i7NGinzyc08=;
  b=p+XBukZ1XAjuhTLs1gQ0nXHb6Fe8lQrUo5FGfTb4BWhWlDLjIO/9xbbF
   xEYEkExjRiNR0a77vHux/hg/h4bGxcm4vPaJ91eM2yMygDDJW//c4x2um
   DzL1CI1SKFqRYUR0HKv46oUmxGnTBUzp+VqY2KoIWFnKg/TRCMPBd8VwZ
   Y=;
X-IronPort-AV: E=Sophos;i="6.08,203,1712620800"; 
   d="scan'208";a="400131024"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.2])
  by smtp-border-fw-6001.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2024 04:59:01 +0000
Received: from EX19MTAEUB001.ant.amazon.com [10.0.10.100:34081]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.33.99:2525] with esmtp (Farcaster)
 id a7488b13-720c-486c-8330-1930378f6073; Fri, 31 May 2024 04:58:59 +0000 (UTC)
X-Farcaster-Flow-ID: a7488b13-720c-486c-8330-1930378f6073
Received: from EX19D002EUA001.ant.amazon.com (10.252.50.66) by
 EX19MTAEUB001.ant.amazon.com (10.252.51.26) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Fri, 31 May 2024 04:58:59 +0000
Received: from EX19MTAUWB001.ant.amazon.com (10.250.64.248) by
 EX19D002EUA001.ant.amazon.com (10.252.50.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Fri, 31 May 2024 04:58:59 +0000
Received: from dev-dsk-hagarhem-1b-b868d8d5.eu-west-1.amazon.com
 (10.253.65.58) by mail-relay.amazon.com (10.250.64.254) with Microsoft SMTP
 Server id 15.2.1258.28 via Frontend Transport; Fri, 31 May 2024 04:58:57
 +0000
Received: by dev-dsk-hagarhem-1b-b868d8d5.eu-west-1.amazon.com (Postfix, from userid 23002382)
	id 5CC2520AC2; Fri, 31 May 2024 04:58:57 +0000 (UTC)
Date: Fri, 31 May 2024 04:58:57 +0000
From: Hagar Hemdan <hagarhem@amazon.com>
To: Marc Zyngier <maz@kernel.org>
CC: Maximilian Heyne <mheyne@amazon.de>, Norbert Manthey <nmanthey@amazon.de>,
	Thomas Gleixner <tglx@linutronix.de>, Eric Auger <eric.auger@redhat.com>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<hagarhem@amazon.de>
Subject: Re: [PATCH] irqchip/gic-v3-its: Fix potential race condition in
 its_vlpi_prop_update()
Message-ID: <20240531045857.GA14712@amazon.com>
References: <20240530105713.18552-1-hagarhem@amazon.com>
 <86v82vl34a.wl-maz@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <86v82vl34a.wl-maz@kernel.org>
User-Agent: Mutt/1.5.21 (2010-09-15)

On Thu, May 30, 2024 at 04:40:37PM +0100, Marc Zyngier wrote:
Hi Marc,

yes, you are right. The lock should be moved to
its_irq_set_vcpu_affinity(). I will update the patch and the commit
message in rev2.

Thanks,
Hagar

> Hi Hagar,
> 
> On Thu, 30 May 2024 11:57:13 +0100,
> Hagar Hemdan <hagarhem@amazon.com> wrote:
> > 
> > Similar to commit 046b5054f566 ("irqchip/gic-v3-its: Lock VLPI map array
> > before translating it"), its_vlpi_prop_update() calls lpi_write_config()
> > which obtains the mapping information for a VLPI.
> > This should always be done with vlpi_lock for this device held. Otherwise,
> > its_vlpi_prop_update() could race with its_vlpi_unmap().
> 
> Thanks for reporting this. Note that this issue is not the same as the
> one you refer to (what you have here is a total absence of locking,
> while 046b5054f566 fixed a call to get_vlpi_map() outside of an
> existing critical section).
> 
> > 
> > This bug was discovered and resolved using Coverity Static Analysis
> > Security Testing (SAST) by Synopsys, Inc.
> 
> Should we get a scrolling banner for this kind of advertisements? ;-)
> 
> > 
> > Fixes: 015ec0386ab6 ("irqchip/gic-v3-its: Add VLPI configuration handling")
> > Signed-off-by: Hagar Hemdan <hagarhem@amazon.com>
> > ---
> >  drivers/irqchip/irq-gic-v3-its.c | 12 +++++++++---
> >  1 file changed, 9 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
> > index 40ebf1726393..ecaad1786345 100644
> > --- a/drivers/irqchip/irq-gic-v3-its.c
> > +++ b/drivers/irqchip/irq-gic-v3-its.c
> > @@ -1970,9 +1970,13 @@ static int its_vlpi_unmap(struct irq_data *d)
> >  static int its_vlpi_prop_update(struct irq_data *d, struct its_cmd_info *info)
> >  {
> >  	struct its_device *its_dev = irq_data_get_irq_chip_data(d);
> > +	int ret = 0;
> >  
> > -	if (!its_dev->event_map.vm || !irqd_is_forwarded_to_vcpu(d))
> > -		return -EINVAL;
> > +	raw_spin_lock(&its_dev->event_map.vlpi_lock);
> > +	if (!its_dev->event_map.vm || !irqd_is_forwarded_to_vcpu(d)) {
> > +		ret = -EINVAL;
> > +		goto out;
> > +	}
> >  
> >  	if (info->cmd_type == PROP_UPDATE_AND_INV_VLPI)
> >  		lpi_update_config(d, 0xff, info->config);
> > @@ -1980,7 +1984,9 @@ static int its_vlpi_prop_update(struct irq_data *d, struct its_cmd_info *info)
> >  		lpi_write_config(d, 0xff, info->config);
> >  	its_vlpi_set_doorbell(d, !!(info->config & LPI_PROP_ENABLED));
> >  
> > -	return 0;
> > +out:
> > +	raw_spin_unlock(&its_dev->event_map.vlpi_lock);
> > +	return ret;
> >  }
> >  
> >  static int its_irq_set_vcpu_affinity(struct irq_data *d, void *vcpu_info)
> 
> As it turns out, all the calls from its_irq_set_vcpu_affinity()
> require the same lock to be held. So instead of peppering the locking
> all over the place, we could (should?) hoist the locking into
> its_irq_set_vcpu_affinity() and avoid future bugs. It also results in
> a negative diffstat.
> 
> Something like the hack below (compile-tested only), which I'm sure
> the "Coverity Static Analysis Security Testing (SAST) by Synopsys,
> Inc" will be able to verify...
> 
> 	M.
> 
> diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
> index 40ebf1726393..abc1fb360ce4 100644
> --- a/drivers/irqchip/irq-gic-v3-its.c
> +++ b/drivers/irqchip/irq-gic-v3-its.c
> @@ -1851,23 +1851,18 @@ static int its_vlpi_map(struct irq_data *d, struct its_cmd_info *info)
>  	if (!info->map)
>  		return -EINVAL;
>  
> -	raw_spin_lock(&its_dev->event_map.vlpi_lock);
> -
>  	if (!its_dev->event_map.vm) {
>  		struct its_vlpi_map *maps;
>  
>  		maps = kcalloc(its_dev->event_map.nr_lpis, sizeof(*maps),
>  			       GFP_ATOMIC);
> -		if (!maps) {
> -			ret = -ENOMEM;
> -			goto out;
> -		}
> +		if (!maps)
> +			return -ENOMEM;
>  
>  		its_dev->event_map.vm = info->map->vm;
>  		its_dev->event_map.vlpi_maps = maps;
>  	} else if (its_dev->event_map.vm != info->map->vm) {
> -		ret = -EINVAL;
> -		goto out;
> +		return -EINVAL;
>  	}
>  
>  	/* Get our private copy of the mapping information */
> @@ -1899,8 +1894,6 @@ static int its_vlpi_map(struct irq_data *d, struct its_cmd_info *info)
>  		its_dev->event_map.nr_vlpis++;
>  	}
>  
> -out:
> -	raw_spin_unlock(&its_dev->event_map.vlpi_lock);
>  	return ret;
>  }
>  
> @@ -1910,20 +1903,14 @@ static int its_vlpi_get(struct irq_data *d, struct its_cmd_info *info)
>  	struct its_vlpi_map *map;
>  	int ret = 0;
>  
> -	raw_spin_lock(&its_dev->event_map.vlpi_lock);
> -
>  	map = get_vlpi_map(d);
>  
> -	if (!its_dev->event_map.vm || !map) {
> -		ret = -EINVAL;
> -		goto out;
> -	}
> +	if (!its_dev->event_map.vm || !map)
> +		return -EINVAL;
>  
>  	/* Copy our mapping information to the incoming request */
>  	*info->map = *map;
>  
> -out:
> -	raw_spin_unlock(&its_dev->event_map.vlpi_lock);
>  	return ret;
>  }
>  
> @@ -1933,12 +1920,8 @@ static int its_vlpi_unmap(struct irq_data *d)
>  	u32 event = its_get_event_id(d);
>  	int ret = 0;
>  
> -	raw_spin_lock(&its_dev->event_map.vlpi_lock);
> -
> -	if (!its_dev->event_map.vm || !irqd_is_forwarded_to_vcpu(d)) {
> -		ret = -EINVAL;
> -		goto out;
> -	}
> +	if (!its_dev->event_map.vm || !irqd_is_forwarded_to_vcpu(d))
> +		return -EINVAL;
>  
>  	/* Drop the virtual mapping */
>  	its_send_discard(its_dev, event);
> @@ -1962,8 +1945,6 @@ static int its_vlpi_unmap(struct irq_data *d)
>  		kfree(its_dev->event_map.vlpi_maps);
>  	}
>  
> -out:
> -	raw_spin_unlock(&its_dev->event_map.vlpi_lock);
>  	return ret;
>  }
>  
> @@ -1987,29 +1968,41 @@ static int its_irq_set_vcpu_affinity(struct irq_data *d, void *vcpu_info)
>  {
>  	struct its_device *its_dev = irq_data_get_irq_chip_data(d);
>  	struct its_cmd_info *info = vcpu_info;
> +	int ret;
>  
>  	/* Need a v4 ITS */
>  	if (!is_v4(its_dev->its))
>  		return -EINVAL;
>  
> +	raw_spin_lock(&its_dev->event_map.vlpi_lock);
> +
>  	/* Unmap request? */
> -	if (!info)
> -		return its_vlpi_unmap(d);
> +	if (!info) {
> +		ret = its_vlpi_unmap(d);
> +		goto out;
> +	}
>  
>  	switch (info->cmd_type) {
>  	case MAP_VLPI:
> -		return its_vlpi_map(d, info);
> +		ret = its_vlpi_map(d, info);
> +		break;
>  
>  	case GET_VLPI:
> -		return its_vlpi_get(d, info);
> +		ret = its_vlpi_get(d, info);
> +		break;
>  
>  	case PROP_UPDATE_VLPI:
>  	case PROP_UPDATE_AND_INV_VLPI:
> -		return its_vlpi_prop_update(d, info);
> +		ret = its_vlpi_prop_update(d, info);
> +		break;
>  
>  	default:
> -		return -EINVAL;
> +		ret = -EINVAL;
>  	}
> +
> +out:
> +	raw_spin_unlock(&its_dev->event_map.vlpi_lock);
> +	return ret;
>  }
>  
>  static struct irq_chip its_irq_chip = {
> 
> -- 
> Without deviation from the norm, progress is not possible.
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

