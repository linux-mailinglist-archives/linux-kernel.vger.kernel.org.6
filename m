Return-Path: <linux-kernel+bounces-196629-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E2CB28D5EF6
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 11:56:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9943F282B9F
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 09:56:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B24513FD95;
	Fri, 31 May 2024 09:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pe4mqUkk"
Received: from mail-vs1-f52.google.com (mail-vs1-f52.google.com [209.85.217.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28B1313774B
	for <linux-kernel@vger.kernel.org>; Fri, 31 May 2024 09:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717149370; cv=none; b=gcVqu+sqITchwTHtL9Cg8xksZxn1m1l/1uSr0zhQlsDIraSGYIqjtGNgxdJUmRKCVAwUf5bajIL52dD7iPheV1ynYzQ8QtK4mcTo4GbKCcrObFB/4BYKclWyGOfZ/a9Mkq31X2W1LweAKRQTr3zonXiZCRWuMW4My0rCOREgTwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717149370; c=relaxed/simple;
	bh=wdnSz7hPG16Mf1CquMbTgjUO3TBxrLJE3vX/KeX7zF8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SOTaH4arBk70Gvu+QbO7kqIWPcoVmu8cyW2iQkGlhCynzVqWHnI4cs0vKZYxDlQePXQyeztlI1it52CkNIloYMyOxmPQSv5uyIvKWQtzPdlYI+ebl517WzJjyJRpVjWlGZj9uOBHjHjh6m17ThygWzwfLN1oOS2AbpkHNzFmtUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Pe4mqUkk; arc=none smtp.client-ip=209.85.217.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f52.google.com with SMTP id ada2fe7eead31-48bc3314cddso111561137.1
        for <linux-kernel@vger.kernel.org>; Fri, 31 May 2024 02:56:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717149368; x=1717754168; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tKVx7XGBm+o8Fw6YnGhdz2zXhlTIlCI4yh9naXhDehg=;
        b=Pe4mqUkkERbqXhH2ic+Vc0f1ZZxKRk+Pk7+15cPARx1QwvdZH/jlwkxlu/2NQExPCC
         PvdV+Jg+8+TKElAWuOKgEjnRtYJNrDOlsEZ5c8Yvy86LRSDvXcy1afjK0SK5Tp83hlUD
         fF0T7V8t8HFIPplNyAGrth6wCEP52v+QdL0xkMyySPAmG6p4uciqX1mg3cZRBpcedlls
         IniW8i8cPwj7YPTVpnEAq0Md7gYuZGv+sTjm/R7+WtUaomNdsAhttXsFLllzfpGKPYsi
         3tWC8l958Y+GM+3SBmZPMYwg0Qtk3+BWANIKXk/0SmkiZkn/Ovsun1b9k8SOnx+Dx7nn
         ni8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717149368; x=1717754168;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tKVx7XGBm+o8Fw6YnGhdz2zXhlTIlCI4yh9naXhDehg=;
        b=sLJeEmgp7Pf6MQ20Y46vmc5r9m0x4W9O8TmYCxi1zFfZwf+W9BjH6M8U6eqldtOIg2
         x/eGDXGZfl6XZrM5thLCvJMhJUlfJ9vLAmhBBLi91f8qeyb9/9DtOtrecYmrk+crrFYk
         5dWE5gzghDuZIeZnraR5i9jCV+XYnPrOC9trItbve32qaLL9vfwoMWmJW4CHCIuniHfT
         m6jxmeZ9y/CCvCdKGEKEMHvr8vdUgKzStR4My3UCKYHyghZHXqoOa10bSS27KFr+ty24
         qbEFeSDD8nmJeO+O7gWmqNYb+FL1lzd3Uuvk8orcd6hAmIB2d3Nc5/0taT/kiru1fB3g
         FLBA==
X-Forwarded-Encrypted: i=1; AJvYcCU8tgrIh3rOAjL8kL7Jhyi1Y9c8upnhisQVm+kPnVUF3R2OaOpF3m3xjkyLkknB6CSiDXVldzI7oixouu5CSiFNtNUTYsBajbISn1pQ
X-Gm-Message-State: AOJu0YzhyBQsS9ANpqHowui8UqiVLDPnaCXMeJZazIxV2G20scGSvH6u
	3GQY2xzfY8FXEvos3l22dLJ/YvfUbHdXJlLslju2QRqxG6j7MCm24tPToyrPbC8i71AmRGvRBfL
	1XYp68yJ7sbxknPvoXtsBBcIsTWs=
X-Google-Smtp-Source: AGHT+IE7QADRzsDSKxZVcKYQmnfV+eZbaOv5G9hqVWSP9YXpgJiCW/5H7Z953Bi7OzB6+gQ7jiXAAbTT+R029c1AXVw=
X-Received: by 2002:a05:6102:4c0b:b0:47b:bea0:bdf7 with SMTP id
 ada2fe7eead31-48bc234666cmr1446622137.27.1717149368007; Fri, 31 May 2024
 02:56:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240531030520.1615833-1-zhaoyang.huang@unisoc.com>
 <ZlmEp9nxKiG9gWFj@pc636> <CAGWkznGak0txoOEq1SYL9Ymax04Tac2nVCSYiC+L8qQ6bqryZQ@mail.gmail.com>
In-Reply-To: <CAGWkznGak0txoOEq1SYL9Ymax04Tac2nVCSYiC+L8qQ6bqryZQ@mail.gmail.com>
From: Barry Song <21cnbao@gmail.com>
Date: Fri, 31 May 2024 21:55:55 +1200
Message-ID: <CAGsJ_4ywu+WgOz_nxaeCa2qzv2=qDa8ZJWOUYb4LqVUq2qeCxQ@mail.gmail.com>
Subject: Re: [PATCHv3] mm: fix incorrect vbq reference in purge_fragmented_block
To: Zhaoyang Huang <huangzhaoyang@gmail.com>
Cc: Uladzislau Rezki <urezki@gmail.com>, "zhaoyang.huang" <zhaoyang.huang@unisoc.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Christoph Hellwig <hch@infradead.org>, 
	Lorenzo Stoakes <lstoakes@gmail.com>, Baoquan He <bhe@redhat.com>, 
	Thomas Gleixner <tglx@linutronix.de>, hailong liu <hailong.liu@oppo.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, steve.kang@unisoc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 31, 2024 at 9:13=E2=80=AFPM Zhaoyang Huang <huangzhaoyang@gmail=
com> wrote:
>
> On Fri, May 31, 2024 at 4:05=E2=80=AFPM Uladzislau Rezki <urezki@gmail.co=
m> wrote:
> >
> > On Fri, May 31, 2024 at 11:05:20AM +0800, zhaoyang.huang wrote:
> > > From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
> > >
> > > vmalloc area runs out in our ARM64 system during an erofs test as
> > > vm_map_ram failed[1]. By following the debug log, we find that
> > > vm_map_ram()->vb_alloc() will allocate new vb->va which corresponding
> > > to 4MB vmalloc area as list_for_each_entry_rcu returns immediately
> > > when vbq->free->next points to vbq->free. That is to say, 65536 times
> > > of page fault after the list's broken will run out of the whole
> > > vmalloc area. This should be introduced by one vbq->free->next point =
to
> > > vbq->free which makes list_for_each_entry_rcu can not iterate the lis=
t
> > > and find the BUG.
> > >
> > > [1]
> > > PID: 1        TASK: ffffff80802b4e00  CPU: 6    COMMAND: "init"
> > >  #0 [ffffffc08006afe0] __switch_to at ffffffc08111d5cc
> > >  #1 [ffffffc08006b040] __schedule at ffffffc08111dde0
> > >  #2 [ffffffc08006b0a0] schedule at ffffffc08111e294
> > >  #3 [ffffffc08006b0d0] schedule_preempt_disabled at ffffffc08111e3f0
> > >  #4 [ffffffc08006b140] __mutex_lock at ffffffc08112068c
> > >  #5 [ffffffc08006b180] __mutex_lock_slowpath at ffffffc08111f8f8
> > >  #6 [ffffffc08006b1a0] mutex_lock at ffffffc08111f834
> > >  #7 [ffffffc08006b1d0] reclaim_and_purge_vmap_areas at ffffffc0803ebc=
3c
> > >  #8 [ffffffc08006b290] alloc_vmap_area at ffffffc0803e83fc
> > >  #9 [ffffffc08006b300] vm_map_ram at ffffffc0803e78c0
> > >
> > > Fixes: fc1e0d980037 ("mm/vmalloc: prevent stale TLBs in fully utilize=
d blocks")
> > >
> > > Suggested-by: Hailong.Liu <hailong.liu@oppo.com>
> > > Signed-off-by: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
> > >
> > Is a problem related to run out of vmalloc space _only_ or it is a prob=
lem
> > with broken list? From the commit message it is hard to follow the reas=
on.
> >
> > Could you please post a full trace or panic?
> Please refer to the below scenario for how vbq->free broken.
> step 1: new_vmap_block is called in CPU0 and get vb->va->addr =3D
> 0xffffffc000400000
> step 2: vb is added to CPU1's vbq->vmap_block(xarray) by xa =3D
> addr_to_vb_xa(va->va_start);
>             fc1e0d980037 ("mm/vmalloc: prevent stale TLBs in fully
> utilized blocks") introduce a per_cpu like xarray mechanism to have vb
> be added to the corresponding CPU's xarray but not local.
> step 3: vb is added to CPU0's vbq->free by
> list_add_tail_rcu(&vb->free_list, &vbq->free);
> step 4 : purge_fragmented_blocks get vbq of CPU1 and then get above vb
> step 5 : purge_fragmented_blocks delete vb from CPU0's list with
> taking the vbq->lock of CPU1
> step 5': vb_alloc on CPU0 could race with step5 and break the CPU0's vbq-=
>free
>
> As fc1e0d980037 solved the problem of staled TLB issue, we need to
> introduce a new variable to record the CPU in vmap_block instead of
> reverting to iterate the list(will leave wrong TLB entry)
> >
> > > ---
> > > v2: introduce cpu in vmap_block to record the right CPU number
> > > v3: use get_cpu/put_cpu to prevent schedule between core
> > > ---
> > > ---
> > >  mm/vmalloc.c | 12 ++++++++----
> > >  1 file changed, 8 insertions(+), 4 deletions(-)
> > >
> > > diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> > > index 22aa63f4ef63..ecdb75d10949 100644
> > > --- a/mm/vmalloc.c
> > > +++ b/mm/vmalloc.c
> > > @@ -2458,6 +2458,7 @@ struct vmap_block {
> > >       struct list_head free_list;
> > >       struct rcu_head rcu_head;
> > >       struct list_head purge;
> > > +     unsigned int cpu;
> > >  };
> > >
> > >  /* Queue of free and dirty vmap blocks, for allocation and flushing =
purposes */
> > > @@ -2586,10 +2587,12 @@ static void *new_vmap_block(unsigned int orde=
r, gfp_t gfp_mask)
> > >               return ERR_PTR(err);
> > >       }
> > >
> > > +     vb->cpu =3D get_cpu();
> > >       vbq =3D raw_cpu_ptr(&vmap_block_queue);
> > >       spin_lock(&vbq->lock);
> > >       list_add_tail_rcu(&vb->free_list, &vbq->free);
> > >       spin_unlock(&vbq->lock);
> > > +     put_cpu();
> > >
> > Why do you need get_cpu() here? Can you go with raw_smp_processor_id()
> > and then access the per-cpu "vmap_block_queue"? get_cpu() disables
> > preemption and then a spin-lock is take within this critical section.
> > From the first glance PREEMPT_RT is broken in this case.
> get_cpu here is to prevent current task from being migrated to other
> COREs before we get the per_cpu vmap_block_queue. Could you please
> suggest a correct way of doing this?

not quite sure if you have to pay the price of disabling preempt.
Does the below Hailong suggested fix your problem?

vb->cpu =3D raw_smp_processor_id();
vbq =3D per_cpu_ptr(&vmap_block_queue, vb->cpu);

>
> >
> > I am on a vacation, responds can be with delays.
> >
> > --
> > Uladzislau Rezki

Thanks
Barry

