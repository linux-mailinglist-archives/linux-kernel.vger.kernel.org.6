Return-Path: <linux-kernel+bounces-195025-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DB2CE8D4679
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 09:55:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9222428329C
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 07:55:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B71EA142E96;
	Thu, 30 May 2024 07:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jRZvsBiu"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EFB2142E60
	for <linux-kernel@vger.kernel.org>; Thu, 30 May 2024 07:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717055697; cv=none; b=SuG5YedLdJMzwshG7lqWqUTQuh7iVNAPgY+z8jRec7+Cl7tXs1eajNoPuH+MnbAlUzxGK0t2NKF7QF4oJS8QwL12uMR7mbZ0pxSdkseTHpfFGVv1X6LcRrnnZXXgNqJQvEsAfadIHZc2B5RouQgdEtjcrc15xptJZFtsfRc8cRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717055697; c=relaxed/simple;
	bh=QgYJg8JbxdnkwXVyVkRZ+YhgPS6t40j+Xro5Bau//bQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=focf5an6rOc36f5zvzPm5K0IgPShA6EJ6hZDYtWe5eCoSfQo43W8pS6Zb0NTAy3YsSVYZMLLq1fi3fyREpioTHSP6ETBBgImcwaYrjRP7fbCGATEbWQHeNvfVZYlYcOGFv3hGsRDJI6QZWT6SRsAt7KyPouRmsqbb2Ub4x0azRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=jRZvsBiu; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717055694;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6Hy0HAy7+UDrlNjCqMZ73nyrwEh649HSiHUGT4dFguc=;
	b=jRZvsBiuxpdgCG2c+CbhghMXA+ORdVtbGTkh56KSGqY9q5o9v95v7qTpL5Ns8Z5r6I7CBy
	ttjP+XLMCzY7gIN7KTzNwnNp1gm5ZgnMTIio8oOwwo5WxyvqcatbsBI1h1EKCsZ+goXWIP
	esjyWwmwwZxQpPFdJlJBwo4YZphgCLU=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-215-xrdTrkz6O8W-ukOJNc3WmA-1; Thu,
 30 May 2024 03:54:53 -0400
X-MC-Unique: xrdTrkz6O8W-ukOJNc3WmA-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 43BEC3806700;
	Thu, 30 May 2024 07:54:52 +0000 (UTC)
Received: from localhost (unknown [10.72.116.34])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 1DCA9400EAC;
	Thu, 30 May 2024 07:54:50 +0000 (UTC)
Date: Thu, 30 May 2024 15:54:47 +0800
From: Baoquan He <bhe@redhat.com>
To: Zhaoyang Huang <huangzhaoyang@gmail.com>
Cc: "zhaoyang.huang" <zhaoyang.huang@unisoc.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Christoph Hellwig <hch@infradead.org>,
	Lorenzo Stoakes <lstoakes@gmail.com>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, steve.kang@unisoc.com,
	Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] mm: fix incorrect vbq reference in purge_fragmented_block
Message-ID: <ZlgwxwN3k5vQVVvH@MiWiFi-R3L-srv>
References: <20240530025144.1570865-1-zhaoyang.huang@unisoc.com>
 <ZlgoX1E4/juuP7+o@MiWiFi-R3L-srv>
 <CAGWkznE=akrSBEQyq+f6tDN6fJ_J59WhJ-bvxpfrLUgTJ73h4g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGWkznE=akrSBEQyq+f6tDN6fJ_J59WhJ-bvxpfrLUgTJ73h4g@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9

On 05/30/24 at 03:35pm, Zhaoyang Huang wrote:
> On Thu, May 30, 2024 at 3:19 PM Baoquan He <bhe@redhat.com> wrote:
> >
> > On 05/30/24 at 10:51am, zhaoyang.huang wrote:
> > > From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
> > >
> > > Broken vbq->free reported on a v6.6 based system which is caused
> > > by invalid vbq->lock protect over vbq->free in purge_fragmented_block.
> > > This should be introduced by the Fixes below which ignored vbq->lock
> > > matter.
> >
> > It will be helpful to provide more details, what's the symptom of the
> > brekage, and in which case vbq->free is broken.
> Vmalloc area runs out in our ARM64 system during an erofs test as
> vm_map_ram failed[1]. We find that one vbq->free->next point to
> vbq->free which makes list_for_each_entry_rcu can not iterate the list
> and find the BUG.

Thanks for these information which are very helpful and important.
They need be put in log for easier understanding. I am wondering
about the vbq->free list breakage by the run out vmalloc area, could
you say more about how it's caused? And do you think we need fix that
vbq->free list breakage either?

> 
> [1]
> PID: 1        TASK: ffffff80802b4e00  CPU: 6    COMMAND: "init"
>  #0 [ffffffc08006afe0] __switch_to at ffffffc08111d5cc
>  #1 [ffffffc08006b040] __schedule at ffffffc08111dde0
>  #2 [ffffffc08006b0a0] schedule at ffffffc08111e294
>  #3 [ffffffc08006b0d0] schedule_preempt_disabled at ffffffc08111e3f0
>  #4 [ffffffc08006b140] __mutex_lock at ffffffc08112068c
>  #5 [ffffffc08006b180] __mutex_lock_slowpath at ffffffc08111f8f8
>  #6 [ffffffc08006b1a0] mutex_lock at ffffffc08111f834
>  #7 [ffffffc08006b1d0] reclaim_and_purge_vmap_areas at ffffffc0803ebc3c
>  #8 [ffffffc08006b290] alloc_vmap_area at ffffffc0803e83fc
>  #9 [ffffffc08006b300] vm_map_ram at ffffffc0803e78c0
> #10 [ffffffc08006b420] z_erofs_lz4_decompress at ffffffc0806a49b0
> #11 [ffffffc08006b670] z_erofs_decompress_queue at ffffffc0806a8fd0
> #12 [ffffffc08006b860] z_erofs_runqueue at ffffffc0806a8744
> #13 [ffffffc08006b970] z_erofs_readahead at ffffffc0806a6cfc
> #14 [ffffffc08006ba00] read_pages at ffffffc08037ed78
> #15 [ffffffc08006ba70] page_cache_ra_unbounded at ffffffc08037eb58
> #16 [ffffffc08006bb00] page_cache_ra_order at ffffffc08037f42c
> #17 [ffffffc08006bbb0] do_sync_mmap_readahead at ffffffc080371d3c
> #18 [ffffffc08006bc40] filemap_fault at ffffffc080371774
> #19 [ffffffc08006bd60] handle_mm_fault at ffffffc0803cc118
> #20 [ffffffc08006bdc0] do_page_fault at ffffffc08112a618
> #21 [ffffffc08006be20] do_translation_fault at ffffffc08112a36c
> #22 [ffffffc08006be30] do_mem_abort at ffffffc0800bfbf0
> #23 [ffffffc08006be70] el0_ia at ffffffc08111583c
> #24 [ffffffc08006bea0] el0t_64_sync_handler at ffffffc0811156a4
> #25 [ffffffc08006bfe0] el0t_64_sync at ffffffc080091584
> 
> 
> >
> > >
> > > Fixes: fc1e0d980037 ("mm/vmalloc: prevent stale TLBs in fully utilized blocks")
> > >
> > > Signed-off-by: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
> > > ---
> > >  mm/vmalloc.c | 11 +++++++----
> > >  1 file changed, 7 insertions(+), 4 deletions(-)
> > >
> > > diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> > > index 22aa63f4ef63..112b50431725 100644
> > > --- a/mm/vmalloc.c
> > > +++ b/mm/vmalloc.c
> > > @@ -2614,9 +2614,10 @@ static void free_vmap_block(struct vmap_block *vb)
> > >  }
> > >
> > >  static bool purge_fragmented_block(struct vmap_block *vb,
> > > -             struct vmap_block_queue *vbq, struct list_head *purge_list,
> > > -             bool force_purge)
> > > +             struct list_head *purge_list, bool force_purge)
> > >  {
> > > +     struct vmap_block_queue *vbq;
> > > +
> > >       if (vb->free + vb->dirty != VMAP_BBMAP_BITS ||
> > >           vb->dirty == VMAP_BBMAP_BITS)
> > >               return false;
> > > @@ -2625,6 +2626,8 @@ static bool purge_fragmented_block(struct vmap_block *vb,
> > >       if (!(force_purge || vb->free < VMAP_PURGE_THRESHOLD))
> > >               return false;
> > >
> > > +     vbq = container_of(addr_to_vb_xa(vb->va->va_start),
> > > +             struct vmap_block_queue, vmap_blocks);
> > >       /* prevent further allocs after releasing lock */
> > >       WRITE_ONCE(vb->free, 0);
> > >       /* prevent purging it again */
> > > @@ -2664,7 +2667,7 @@ static void purge_fragmented_blocks(int cpu)
> > >                       continue;
> > >
> > >               spin_lock(&vb->lock);
> > > -             purge_fragmented_block(vb, vbq, &purge, true);
> > > +             purge_fragmented_block(vb, &purge, true);
> > >               spin_unlock(&vb->lock);
> > >       }
> > >       rcu_read_unlock();
> > > @@ -2801,7 +2804,7 @@ static void _vm_unmap_aliases(unsigned long start, unsigned long end, int flush)
> > >                        * not purgeable, check whether there is dirty
> > >                        * space to be flushed.
> > >                        */
> > > -                     if (!purge_fragmented_block(vb, vbq, &purge_list, false) &&
> > > +                     if (!purge_fragmented_block(vb, &purge_list, false) &&
> > >                           vb->dirty_max && vb->dirty != VMAP_BBMAP_BITS) {
> > >                               unsigned long va_start = vb->va->va_start;
> > >                               unsigned long s, e;
> > > --
> > > 2.25.1
> > >
> > >
> >
> 


