Return-Path: <linux-kernel+bounces-203543-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AA0928FDCE8
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 04:42:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1B68C1F21F89
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 02:42:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07E1C1BDEF;
	Thu,  6 Jun 2024 02:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GUIIr7Ce"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59A49179A7
	for <linux-kernel@vger.kernel.org>; Thu,  6 Jun 2024 02:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717641740; cv=none; b=mwzHeTW0v4Sg6/Xs4fVnucp+gQBSMWFxp/bvPhuqEwmwygMvjhhci4YFsidVhhXDP25doiMIuLIQpTE3ss792ikxsG+OewA9I++znBQywtDUdWa/9mbCqjH72JeqfQJqbo7dfu707m3ydWT84gescBr7GiLMIUk3hPJ6z9Uww7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717641740; c=relaxed/simple;
	bh=Vxo09eYaHSgtqXxn1SqIh90DmJ7Ej+wZ0BseGPRXVxQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z+RjBscs44x0PdLLS8mBaZ9R89esZPaCpstz8rlG/UXFSREas73r7ZFqvmpj9xexzAzDleyjv/HfTTu2U1clwYxPiuschYyYjc4EQBRB+RjT9MIv/1UP63wBbaNupsdn9emO47UlzvKzl++kt1v96NYhecM2V7TcvFrtlSRE5us=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GUIIr7Ce; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717641737;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rF5m20l5EfPvWWblQabpJhD2bWhVAxo9SZyKSImgFRM=;
	b=GUIIr7Ce4Mf/Lmnbr2auzab9dtu0ST7PYv9+Oneh3L3sbuQMe1FDp3y+admbS2k1Rf67+x
	SbsdstxIfxwQvbz4+JjQSxaWgGH/CRIRkBPjRxhc44i9qj9tsiCTykisTEdzRHtbtvDlyf
	eXAnDyySxSz8v/GB5ISczHrcsvILu2Y=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-543-IuZwjLf_ORSph_LhBUbrgA-1; Wed, 05 Jun 2024 22:42:13 -0400
X-MC-Unique: IuZwjLf_ORSph_LhBUbrgA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 382758007A1;
	Thu,  6 Jun 2024 02:42:13 +0000 (UTC)
Received: from localhost (unknown [10.72.113.20])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id AF1532140FC5;
	Thu,  6 Jun 2024 02:42:10 +0000 (UTC)
Date: Thu, 6 Jun 2024 10:42:07 +0800
From: Baoquan He <bhe@redhat.com>
To: Zhaoyang Huang <huangzhaoyang@gmail.com>
Cc: "zhaoyang.huang" <zhaoyang.huang@unisoc.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Christoph Hellwig <hch@infradead.org>,
	Lorenzo Stoakes <lstoakes@gmail.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	hailong liu <hailong.liu@oppo.com>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, steve.kang@unisoc.com
Subject: Re: [PATCHv4 1/1] mm: fix incorrect vbq reference in
 purge_fragmented_block
Message-ID: <ZmEh/7ylV8M64XQZ@MiWiFi-R3L-srv>
References: <20240604022232.1669983-1-zhaoyang.huang@unisoc.com>
 <CAGWkznHt3p=+bW=+CKCDdXEjqDkUqj89AO1F=zje-A_cDkx2NA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGWkznHt3p=+bW=+CKCDdXEjqDkUqj89AO1F=zje-A_cDkx2NA@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6

On 06/06/24 at 10:28am, Zhaoyang Huang wrote:
> This patch is urgent for the Android world which uses v6.6 now. Is
> there any comments on this? Thanks!

You should take the way Willf and I suggested, to adjust the vba->free
to only contain the vb belonging to it. Have you tested the draft patch?

> 
> On Tue, Jun 4, 2024 at 10:23 AM zhaoyang.huang
> <zhaoyang.huang@unisoc.com> wrote:
> >
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
> > For detailed reason of broken list, please refer to below URL
> > https://lore.kernel.org/all/20240531024820.5507-1-hailong.liu@oppo.com/
> >
> > Suggested-by: Hailong.Liu <hailong.liu@oppo.com>
> > Signed-off-by: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
> > ---
> > v2: introduce cpu in vmap_block to record the right CPU number
> > v3: use get_cpu/put_cpu to prevent schedule between core
> > v4: replace get_cpu/put_cpu by another API to avoid disabling preemption
> > ---
> > ---
> >  mm/vmalloc.c | 21 +++++++++++++++------
> >  1 file changed, 15 insertions(+), 6 deletions(-)
> >
> > diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> > index 22aa63f4ef63..89eb034f4ac6 100644
> > --- a/mm/vmalloc.c
> > +++ b/mm/vmalloc.c
> > @@ -2458,6 +2458,7 @@ struct vmap_block {
> >         struct list_head free_list;
> >         struct rcu_head rcu_head;
> >         struct list_head purge;
> > +       unsigned int cpu;
> >  };
> >
> >  /* Queue of free and dirty vmap blocks, for allocation and flushing purposes */
> > @@ -2585,8 +2586,15 @@ static void *new_vmap_block(unsigned int order, gfp_t gfp_mask)
> >                 free_vmap_area(va);
> >                 return ERR_PTR(err);
> >         }
> > -
> > -       vbq = raw_cpu_ptr(&vmap_block_queue);
> > +       /*
> > +        * list_add_tail_rcu could happened in another core
> > +        * rather than vb->cpu due to task migration, which
> > +        * is safe as list_add_tail_rcu will ensure the list's
> > +        * integrity together with list_for_each_rcu from read
> > +        * side.
> > +        */
> > +       vb->cpu = raw_smp_processor_id();
> > +       vbq = per_cpu_ptr(&vmap_block_queue, vb->cpu);
> >         spin_lock(&vbq->lock);
> >         list_add_tail_rcu(&vb->free_list, &vbq->free);
> >         spin_unlock(&vbq->lock);
> > @@ -2614,9 +2622,10 @@ static void free_vmap_block(struct vmap_block *vb)
> >  }
> >
> >  static bool purge_fragmented_block(struct vmap_block *vb,
> > -               struct vmap_block_queue *vbq, struct list_head *purge_list,
> > -               bool force_purge)
> > +               struct list_head *purge_list, bool force_purge)
> >  {
> > +       struct vmap_block_queue *vbq = &per_cpu(vmap_block_queue, vb->cpu);
> > +
> >         if (vb->free + vb->dirty != VMAP_BBMAP_BITS ||
> >             vb->dirty == VMAP_BBMAP_BITS)
> >                 return false;
> > @@ -2664,7 +2673,7 @@ static void purge_fragmented_blocks(int cpu)
> >                         continue;
> >
> >                 spin_lock(&vb->lock);
> > -               purge_fragmented_block(vb, vbq, &purge, true);
> > +               purge_fragmented_block(vb, &purge, true);
> >                 spin_unlock(&vb->lock);
> >         }
> >         rcu_read_unlock();
> > @@ -2801,7 +2810,7 @@ static void _vm_unmap_aliases(unsigned long start, unsigned long end, int flush)
> >                          * not purgeable, check whether there is dirty
> >                          * space to be flushed.
> >                          */
> > -                       if (!purge_fragmented_block(vb, vbq, &purge_list, false) &&
> > +                       if (!purge_fragmented_block(vb, &purge_list, false) &&
> >                             vb->dirty_max && vb->dirty != VMAP_BBMAP_BITS) {
> >                                 unsigned long va_start = vb->va->va_start;
> >                                 unsigned long s, e;
> > --
> > 2.25.1
> >
> 


