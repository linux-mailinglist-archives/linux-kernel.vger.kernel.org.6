Return-Path: <linux-kernel+bounces-196639-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E765D8D5F2D
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 12:03:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 826D4B25C0D
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 10:03:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8F721422DA;
	Fri, 31 May 2024 10:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NYCuL4qR"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1C88558A5
	for <linux-kernel@vger.kernel.org>; Fri, 31 May 2024 10:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717149792; cv=none; b=W0wOFxy+6Re2uujIVsLdClLZaYyYHSdddG6HASfkP2p6XvFTYk/EoJbkawHiVy45o2baAfU+yx9dur2NAuhE+Oorv/zx+eQPdtvJUR9Tk0GGJJx1m4QYdJX/9/9g4qvkjH+XU9ZtJYI/KUjHJu859cedOVMrxPLSKAX3CDEgpN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717149792; c=relaxed/simple;
	bh=snTSlKQB3owp82PVW4F7ruTvFYi79PjfpR98oPnaGh0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cT9BrezIp+94VKnOCGt2cADvw1gTU04St1od37eacY2w/vRPf/fSdVfdagBh3/V5Ce4rIz/DQ1TZFroVtDECfpit3Kq/pDLKr5yIH62qALchiYGOPI3LuOwUXIfM7hV0E+GnT+TdHpMSpFGNjew8PIdUdGMWsVnDjdXG6hH9gyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NYCuL4qR; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717149789;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Zc7MonfzRyeQDwj3Ud3usru80cZaxIT/UX2rYkzrde4=;
	b=NYCuL4qRk46cHk46pCR49lmKMNu02XcpfOOfFYfuxpmVym7ouDSckUov2/NLXfwbtYGDuH
	fiDv60Md9qwzoLwGre56tDxxHoWnSXYeteyR63hxK4/DVZoJU/2IudzAZsqcuWHrjXW+in
	kjrZIqTqn+QJV3AznLo7Zn2jTTrHurs=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-687-qV7CmnWQOEOsxg0EZQL2qw-1; Fri,
 31 May 2024 06:03:06 -0400
X-MC-Unique: qV7CmnWQOEOsxg0EZQL2qw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9D9E33806701;
	Fri, 31 May 2024 10:03:05 +0000 (UTC)
Received: from localhost (unknown [10.72.116.39])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 04FB4C15BB1;
	Fri, 31 May 2024 10:03:03 +0000 (UTC)
Date: Fri, 31 May 2024 18:03:00 +0800
From: Baoquan He <bhe@redhat.com>
To: Uladzislau Rezki <urezki@gmail.com>
Cc: "zhaoyang.huang" <zhaoyang.huang@unisoc.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Christoph Hellwig <hch@infradead.org>,
	Lorenzo Stoakes <lstoakes@gmail.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	hailong liu <hailong.liu@oppo.com>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Zhaoyang Huang <huangzhaoyang@gmail.com>, steve.kang@unisoc.com
Subject: Re: [PATCHv3] mm: fix incorrect vbq reference in
 purge_fragmented_block
Message-ID: <ZlmgVAZ6KABfpn8K@MiWiFi-R3L-srv>
References: <20240531030520.1615833-1-zhaoyang.huang@unisoc.com>
 <ZlmEp9nxKiG9gWFj@pc636>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZlmEp9nxKiG9gWFj@pc636>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8

On 05/31/24 at 10:04am, Uladzislau Rezki wrote:
> On Fri, May 31, 2024 at 11:05:20AM +0800, zhaoyang.huang wrote:
> > From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
> > 
> > vmalloc area runs out in our ARM64 system during an erofs test as
> > vm_map_ram failed[1]. By following the debug log, we find that
> > vm_map_ram()->vb_alloc() will allocate new vb->va which corresponding
> > to 4MB vmalloc area as list_for_each_entry_rcu returns immediately
> > when vbq->free->next points to vbq->free. That is to say, 65536 times
> > of page fault after the list's broken will run out of the whole
> > vmalloc area. This should be introduced by one vbq->free->next point to
> > vbq->free which makes list_for_each_entry_rcu can not iterate the list
> > and find the BUG.
> > 
> > [1]
> > PID: 1        TASK: ffffff80802b4e00  CPU: 6    COMMAND: "init"
> >  #0 [ffffffc08006afe0] __switch_to at ffffffc08111d5cc
> >  #1 [ffffffc08006b040] __schedule at ffffffc08111dde0
> >  #2 [ffffffc08006b0a0] schedule at ffffffc08111e294
> >  #3 [ffffffc08006b0d0] schedule_preempt_disabled at ffffffc08111e3f0
> >  #4 [ffffffc08006b140] __mutex_lock at ffffffc08112068c
> >  #5 [ffffffc08006b180] __mutex_lock_slowpath at ffffffc08111f8f8
> >  #6 [ffffffc08006b1a0] mutex_lock at ffffffc08111f834
> >  #7 [ffffffc08006b1d0] reclaim_and_purge_vmap_areas at ffffffc0803ebc3c
> >  #8 [ffffffc08006b290] alloc_vmap_area at ffffffc0803e83fc
> >  #9 [ffffffc08006b300] vm_map_ram at ffffffc0803e78c0
> > 
> > Fixes: fc1e0d980037 ("mm/vmalloc: prevent stale TLBs in fully utilized blocks")
> > 
> > Suggested-by: Hailong.Liu <hailong.liu@oppo.com>
> > Signed-off-by: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
> >
> Is a problem related to run out of vmalloc space _only_ or it is a problem
> with broken list? From the commit message it is hard to follow the reason.

The broken list caused the vmalloc space run out. I think we should fix
the broken list.

Wondering if the issue can be always reproduced, or rarely seen. We
should try making a patch to fix the list breakage unless it's not
feasible. I will have a look at this.

> 
> Could you please post a full trace or panic?
> 
> > ---
> > v2: introduce cpu in vmap_block to record the right CPU number
> > v3: use get_cpu/put_cpu to prevent schedule between core
> > ---
> > ---
> >  mm/vmalloc.c | 12 ++++++++----
> >  1 file changed, 8 insertions(+), 4 deletions(-)
> > 
> > diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> > index 22aa63f4ef63..ecdb75d10949 100644
> > --- a/mm/vmalloc.c
> > +++ b/mm/vmalloc.c
> > @@ -2458,6 +2458,7 @@ struct vmap_block {
> >  	struct list_head free_list;
> >  	struct rcu_head rcu_head;
> >  	struct list_head purge;
> > +	unsigned int cpu;
> >  };
> >  
> >  /* Queue of free and dirty vmap blocks, for allocation and flushing purposes */
> > @@ -2586,10 +2587,12 @@ static void *new_vmap_block(unsigned int order, gfp_t gfp_mask)
> >  		return ERR_PTR(err);
> >  	}
> >  
> > +	vb->cpu = get_cpu();
> >  	vbq = raw_cpu_ptr(&vmap_block_queue);
> >  	spin_lock(&vbq->lock);
> >  	list_add_tail_rcu(&vb->free_list, &vbq->free);
> >  	spin_unlock(&vbq->lock);
> > +	put_cpu();
> >  
> Why do you need get_cpu() here? Can you go with raw_smp_processor_id()
> and then access the per-cpu "vmap_block_queue"? get_cpu() disables
> preemption and then a spin-lock is take within this critical section.
> From the first glance PREEMPT_RT is broken in this case.
> 
> I am on a vacation, responds can be with delays.
> 
> --
> Uladzislau Rezki
> 


