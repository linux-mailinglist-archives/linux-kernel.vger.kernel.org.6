Return-Path: <linux-kernel+bounces-203562-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DC0A8FDD2E
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 05:10:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B2941C2245C
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 03:10:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28C111DDC9;
	Thu,  6 Jun 2024 03:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ScuXqwbI"
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E5A6179AA
	for <linux-kernel@vger.kernel.org>; Thu,  6 Jun 2024 03:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717643416; cv=none; b=MG6uhTcPKVkmXa+/piekx9JMAx2KLdCvfdz99rw9s3q5ua2xtiY+uOiMfrWAgdw8gMDmpddY/WXhKh3dd5AVSN6bbvCnUcc4G8gjZOx2Sx6LwsADrgkUwchjyhG2G3S8fxhA/kp5WzkujcqmR+dPvM0agLDOsImz5dtBi/yeOqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717643416; c=relaxed/simple;
	bh=W9FEh/nfrFWeISBWXVi/Ghp5mG+mRMQ9PMwi1KjyER4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EpZJSEieWDacrsZlj5dDBum1K1Bn9r5zrHpy4hgpFmtXlLprrP8HRrUnGf2jOOcWmkAyjdSN8THY0TRsEHEKL9XHTXrEpTOJIWhZuNpmaT5FACRGwEBNKT371FPAHtrJA3e7yfm/YnWWo+xNgtHT6YSVZRB43//LFEUt/v9WnaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ScuXqwbI; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2eaccc0979eso5915071fa.1
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jun 2024 20:10:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717643412; x=1718248212; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XfY1Fcfk5dDBAApcQFnkeusEIm9Y4xpt1EazgOKzvgg=;
        b=ScuXqwbIP7DBLD0Y1yCMhNY+C4Z8Ts58FgOhO9VVxTAv0N+/WMWV6StgXPG3CHjU4q
         iYmlDHTRRJYg/QiUs3BcLTTgu2m9+j8ncrCeCQvoVMS2geZG3UVV4JI4u4br4aRkTvgl
         +anGZzn4oOShVLB/Iw8TTufItbLt8D/09qO+H/B54QVXt5h8Rw1o+hUMXLyanmRq5Cth
         hkVr82EmR2TPfjcYXca1KGtCQC/bV7wBYXLrP/14yGvgbz0mz7rv45pAIXIgj21dtVZF
         kLNim4YQxwdJfelQ1rZAQPL0Cdu+QDkl8m6zEsQgX6nPPjh/OI955IT4wF1rZQ5eS3Q3
         AFRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717643412; x=1718248212;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XfY1Fcfk5dDBAApcQFnkeusEIm9Y4xpt1EazgOKzvgg=;
        b=eAJ5R+qSSkoglgh3maDwWO6yAfcvPIVeBtrM+w0TwfJfViiNxhp7HY7Tnwd3UQQhNq
         ibIfQW7hyG6MTHdf/wZ6hWlk3Kr9OPeU55AnhdGn7pF/x8BNDadUrck3349EUnm9aK4z
         xZO/o1/6CmJk+jXK8AjrBktJdIM1qW+NeQ5pVlGj3H7mqScP6vuIvh8fUttvZrm5UCEi
         yuIOThPNfVo1hWH/f1Au09BNwZX+N9VqZNQwCxCAknU1VIVFuZMq0cOwa8Kx9FVtu8SD
         PhUwlmJF/CdLsz92QzkVT9Gi+TrKJMA0Gi1etazJydVk+/nUGdcT/5mTWKLNyv2OX8SS
         VPJA==
X-Forwarded-Encrypted: i=1; AJvYcCV0xo2eRauoaYl9S+kTwexb0TsNRUt/ey3nKc9gBsz5SEkdLcMFEbVtVyVQM/Xyy4Kxnvs9nKTaKdPeEH6QvN+v29FutDLU1eRvMxRO
X-Gm-Message-State: AOJu0Yy6MCTYfzWRXPpeW8lzPpuNMXwn00fYkwy4uTBIDjobWILio//n
	lV4Be/mJOZAZ5YmDHeIgdmsm0MskMhmleEf+OzBludmaa8YG+q80TsqaBefX4xnPDJ2YHdS7NFd
	Q91aKi02STdr6GSbbm3S2GNvvVjY=
X-Google-Smtp-Source: AGHT+IHP8bY9IHXPIKOEaVEYVbX+eiQBJNrfDc1riznfaIWj31JWfhAGcFb3/wFXC4SJITLcjJOMmkLdPs7T6iQJ9H4=
X-Received: by 2002:a2e:9188:0:b0:2ea:8abe:2319 with SMTP id
 38308e7fff4ca-2eac7783081mr22581081fa.0.1717643412278; Wed, 05 Jun 2024
 20:10:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240604022232.1669983-1-zhaoyang.huang@unisoc.com>
 <CAGWkznHt3p=+bW=+CKCDdXEjqDkUqj89AO1F=zje-A_cDkx2NA@mail.gmail.com> <ZmEh/7ylV8M64XQZ@MiWiFi-R3L-srv>
In-Reply-To: <ZmEh/7ylV8M64XQZ@MiWiFi-R3L-srv>
From: Zhaoyang Huang <huangzhaoyang@gmail.com>
Date: Thu, 6 Jun 2024 11:10:01 +0800
Message-ID: <CAGWkznFnkBW3z2QtSDJzR+AEFzxi_3v+HaQQZUG2wkGCXvhXow@mail.gmail.com>
Subject: Re: [PATCHv4 1/1] mm: fix incorrect vbq reference in purge_fragmented_block
To: Baoquan He <bhe@redhat.com>
Cc: "zhaoyang.huang" <zhaoyang.huang@unisoc.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Uladzislau Rezki <urezki@gmail.com>, Christoph Hellwig <hch@infradead.org>, 
	Lorenzo Stoakes <lstoakes@gmail.com>, Thomas Gleixner <tglx@linutronix.de>, 
	hailong liu <hailong.liu@oppo.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	steve.kang@unisoc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 6, 2024 at 10:42=E2=80=AFAM Baoquan He <bhe@redhat.com> wrote:
>
> On 06/06/24 at 10:28am, Zhaoyang Huang wrote:
> > This patch is urgent for the Android world which uses v6.6 now. Is
> > there any comments on this? Thanks!
>
> You should take the way Willf and I suggested, to adjust the vba->free
> to only contain the vb belonging to it. Have you tested the draft patch?
The vbq access will be totally mixed by your suggestion which means
vb_alloc on CPUx could get the vb on every CPU which has per_cpu
declaration making no sense.

>
> >
> > On Tue, Jun 4, 2024 at 10:23=E2=80=AFAM zhaoyang.huang
> > <zhaoyang.huang@unisoc.com> wrote:
> > >
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
> > > For detailed reason of broken list, please refer to below URL
> > > https://lore.kernel.org/all/20240531024820.5507-1-hailong.liu@oppo.co=
m/
> > >
> > > Suggested-by: Hailong.Liu <hailong.liu@oppo.com>
> > > Signed-off-by: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
> > > ---
> > > v2: introduce cpu in vmap_block to record the right CPU number
> > > v3: use get_cpu/put_cpu to prevent schedule between core
> > > v4: replace get_cpu/put_cpu by another API to avoid disabling preempt=
ion
> > > ---
> > > ---
> > >  mm/vmalloc.c | 21 +++++++++++++++------
> > >  1 file changed, 15 insertions(+), 6 deletions(-)
> > >
> > > diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> > > index 22aa63f4ef63..89eb034f4ac6 100644
> > > --- a/mm/vmalloc.c
> > > +++ b/mm/vmalloc.c
> > > @@ -2458,6 +2458,7 @@ struct vmap_block {
> > >         struct list_head free_list;
> > >         struct rcu_head rcu_head;
> > >         struct list_head purge;
> > > +       unsigned int cpu;
> > >  };
> > >
> > >  /* Queue of free and dirty vmap blocks, for allocation and flushing =
purposes */
> > > @@ -2585,8 +2586,15 @@ static void *new_vmap_block(unsigned int order=
, gfp_t gfp_mask)
> > >                 free_vmap_area(va);
> > >                 return ERR_PTR(err);
> > >         }
> > > -
> > > -       vbq =3D raw_cpu_ptr(&vmap_block_queue);
> > > +       /*
> > > +        * list_add_tail_rcu could happened in another core
> > > +        * rather than vb->cpu due to task migration, which
> > > +        * is safe as list_add_tail_rcu will ensure the list's
> > > +        * integrity together with list_for_each_rcu from read
> > > +        * side.
> > > +        */
> > > +       vb->cpu =3D raw_smp_processor_id();
> > > +       vbq =3D per_cpu_ptr(&vmap_block_queue, vb->cpu);
> > >         spin_lock(&vbq->lock);
> > >         list_add_tail_rcu(&vb->free_list, &vbq->free);
> > >         spin_unlock(&vbq->lock);
> > > @@ -2614,9 +2622,10 @@ static void free_vmap_block(struct vmap_block =
*vb)
> > >  }
> > >
> > >  static bool purge_fragmented_block(struct vmap_block *vb,
> > > -               struct vmap_block_queue *vbq, struct list_head *purge=
_list,
> > > -               bool force_purge)
> > > +               struct list_head *purge_list, bool force_purge)
> > >  {
> > > +       struct vmap_block_queue *vbq =3D &per_cpu(vmap_block_queue, v=
b->cpu);
> > > +
> > >         if (vb->free + vb->dirty !=3D VMAP_BBMAP_BITS ||
> > >             vb->dirty =3D=3D VMAP_BBMAP_BITS)
> > >                 return false;
> > > @@ -2664,7 +2673,7 @@ static void purge_fragmented_blocks(int cpu)
> > >                         continue;
> > >
> > >                 spin_lock(&vb->lock);
> > > -               purge_fragmented_block(vb, vbq, &purge, true);
> > > +               purge_fragmented_block(vb, &purge, true);
> > >                 spin_unlock(&vb->lock);
> > >         }
> > >         rcu_read_unlock();
> > > @@ -2801,7 +2810,7 @@ static void _vm_unmap_aliases(unsigned long sta=
rt, unsigned long end, int flush)
> > >                          * not purgeable, check whether there is dirt=
y
> > >                          * space to be flushed.
> > >                          */
> > > -                       if (!purge_fragmented_block(vb, vbq, &purge_l=
ist, false) &&
> > > +                       if (!purge_fragmented_block(vb, &purge_list, =
false) &&
> > >                             vb->dirty_max && vb->dirty !=3D VMAP_BBMA=
P_BITS) {
> > >                                 unsigned long va_start =3D vb->va->va=
_start;
> > >                                 unsigned long s, e;
> > > --
> > > 2.25.1
> > >
> >
>

