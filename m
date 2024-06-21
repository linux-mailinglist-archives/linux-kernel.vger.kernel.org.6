Return-Path: <linux-kernel+bounces-224820-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 24A69912738
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 16:03:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C1DEB1F2892F
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 14:03:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC8A81D54B;
	Fri, 21 Jun 2024 14:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WPtyW3xj"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B67722F0F
	for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 14:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718978584; cv=none; b=HEKi46SmP89plGR0gzR3CX9xtwMW2ugegMbzFHnDZ4YESAm8nG7OFmsWJfrbTRYQXsdvuEgJCFMyYQTAqtEFfPmuR2iz6XK5+kbm0Naqa/G2dmJ7vkOa0uv2/DzXA4oRlpy1+Qf9L7rrOrCwl4gDYlTC7GgrTRpWACaz/y5D6kE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718978584; c=relaxed/simple;
	bh=sO2Vqa/xiHVkUc1MI7sSYJtHx5kboa5sTEpZ4k7n0Q0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Dp8nKRw7j0ZwE/7YOPSlDLUJseBvU7UchWUvB6jLUSJ7ov9k8ahVDXj0uzeqWVTPJrP38kfueK/W27V2K//qqo8YSjmU6Im1hmELRO4mHkErPNARLlgVH+uG0Ld2hzXFxruVCD8LZvMiY9maSJIDq2focfrzi/7SeFiJ0oUgCIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WPtyW3xj; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718978581;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=akLFQtt/+POxVR4pxOkO3hxUvw7PQRoqpGG2Zvxz0Ao=;
	b=WPtyW3xj5EHVmfA2PGZ9u/2bT/Z1xDd3NVUa7eMWY4lzy+MPf2lXnadmLBtUWErH/6doOU
	hA80EwgALHibC3ANwC4G0vjTFzs7m4iThZOX9J7F9ZuRovRtiOiLYnsyVYuk5/7vjhzyTL
	TnbQWsuKFyFpLOszdDvxQTxQ2snRD4E=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-1-boMQmNw-Nki6ogvq3fnK8Q-1; Fri,
 21 Jun 2024 10:02:58 -0400
X-MC-Unique: boMQmNw-Nki6ogvq3fnK8Q-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3D6BA1955F01;
	Fri, 21 Jun 2024 14:02:57 +0000 (UTC)
Received: from localhost (unknown [10.72.112.17])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7D6303000218;
	Fri, 21 Jun 2024 14:02:54 +0000 (UTC)
Date: Fri, 21 Jun 2024 22:02:50 +0800
From: Baoquan He <bhe@redhat.com>
To: Uladzislau Rezki <urezki@gmail.com>
Cc: Nick Bowler <nbowler@draconx.ca>, Hailong Liu <hailong.liu@oppo.com>,
	linux-kernel@vger.kernel.org,
	Linux regressions mailing list <regressions@lists.linux.dev>,
	linux-mm@kvack.org, sparclinux@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: PROBLEM: kernel crashes when running xfsdump since ~6.4
Message-ID: <ZnWICsPgYuBlrWlt@MiWiFi-R3L-srv>
References: <75e17b57-1178-4288-b792-4ae68b19915e@draconx.ca>
 <00d74f24-c49c-460e-871c-d5af64701306@draconx.ca>
 <20240621033005.6mccm7waduelb4m5@oppo.com>
 <ZnUmpMbCBFWnvaEz@MiWiFi-R3L-srv>
 <ZnVLbCCkvhf5GaTf@pc636>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZnVLbCCkvhf5GaTf@pc636>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On 06/21/24 at 11:44am, Uladzislau Rezki wrote:
> On Fri, Jun 21, 2024 at 03:07:16PM +0800, Baoquan He wrote:
> > On 06/21/24 at 11:30am, Hailong Liu wrote:
> > > On Thu, 20. Jun 14:02, Nick Bowler wrote:
> > > > On 2024-06-20 02:19, Nick Bowler wrote:
......
> > diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> > index be2dd281ea76..18e87cafbaf2 100644
> > --- a/mm/vmalloc.c
> > +++ b/mm/vmalloc.c
> > @@ -2542,7 +2542,7 @@ static DEFINE_PER_CPU(struct vmap_block_queue, vmap_block_queue);
> >  static struct xarray *
> >  addr_to_vb_xa(unsigned long addr)
> >  {
> > -	int index = (addr / VMAP_BLOCK_SIZE) % num_possible_cpus();
> > +	int index = (addr / VMAP_BLOCK_SIZE) % nr_cpu_ids;
> >  
> >  	return &per_cpu(vmap_block_queue, index).vmap_blocks;
> >  }
> > 
> The problem i see is about not-initializing of the:
> <snip>
> 	for_each_possible_cpu(i) {
> 		struct vmap_block_queue *vbq;
> 		struct vfree_deferred *p;
> 
> 		vbq = &per_cpu(vmap_block_queue, i);
> 		spin_lock_init(&vbq->lock);
> 		INIT_LIST_HEAD(&vbq->free);
> 		p = &per_cpu(vfree_deferred, i);
> 		init_llist_head(&p->list);
> 		INIT_WORK(&p->wq, delayed_vfree_work);
> 		xa_init(&vbq->vmap_blocks);
> 	}
> <snip>
> 
> correctly or fully. It is my bad i did not think that CPUs in a possible mask
> can be non sequential :-/
> 
> nr_cpu_ids - is not the max possible CPU. For example, in Nick case,
> when he has two CPUs, num_possible_cpus() and nr_cpu_ids are the same.

I checked the generic version of setup_nr_cpu_ids(), from codes, they
are different with my understanding.

kernel/smp.c
void __init setup_nr_cpu_ids(void)
{
        set_nr_cpu_ids(find_last_bit(cpumask_bits(cpu_possible_mask), NR_CPUS) + 1);
}

include/linux/cpumask.h:
#define num_possible_cpus()     cpumask_weight(cpu_possible_mask)


