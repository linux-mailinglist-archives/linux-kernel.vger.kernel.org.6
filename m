Return-Path: <linux-kernel+bounces-196164-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 179E18D583A
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 03:40:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6E092B27031
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 01:40:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0A7EE56A;
	Fri, 31 May 2024 01:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nm3989pK"
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C3F7EAC0
	for <linux-kernel@vger.kernel.org>; Fri, 31 May 2024 01:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717119617; cv=none; b=ROAMoNfS2a73WfyqEQfpwOwV+ZRVThbMnVdLfyWCvzsp+FBA+f477OvjQTOcxT+NGee9qlu0pJNUFvFDXtQ2erqjsvIMlOga4ZGNt9Kx/QasYSXrSp7DhyweoZJPCk4XesaW5VUM7yO9gO93W8nWcyAHGLLlTPQeuZhsOL/da0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717119617; c=relaxed/simple;
	bh=YO4jtKu4wOYnvdq+i5iQyiaOMhwjJvKzdMBSf/5MNY4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gcC6UB7lBwdSbB0E/v6KsJO9FbZfC6cjZPzysErIyvmuT4CSIJkYQm7Y49ebL9CztqWhjXOIVignE7frktkGFo3Ct4yZXkMtRLkgdTXJmqONENyNwZS/uHTAtjKSQnhlUGr/hY/2ESnVY/I56OwFXYeHv44p8sQIOCWCcfJKFiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nm3989pK; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2ea8fff1486so5741741fa.1
        for <linux-kernel@vger.kernel.org>; Thu, 30 May 2024 18:40:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717119613; x=1717724413; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2t5EcuhFKFYbv2Rd9t0NV0fJiuW2dSu7qfxhtP3jFNE=;
        b=nm3989pKn4reOsiely1nUOMapkPoyuNGB4FVuDGt+nN45+BfKmKOTwJQuhkbqto8TU
         W/iKEYxb5y6/a8uoWoI/f0oX2jqfLMN+C0CXQq32NTjo1pDEpvKLpb7ZpBzlQuBA+Iec
         UBAEbHc0xrjripcKkhVPbudYwm+MOsoJMpa0g8O78iNIh9BvdwSAG6MQxbJ4MPk7kI4b
         G+gzQkQW+/YD0X282GiHbXHQF4m6iN6tZ2HizMbYD6AFt0yrWvDg2YeCMaD5TwA62diD
         lPqEdbWOie5Tb+KEyH30AQqTzinc49WxzLYJ+Xhdjsg53eqJYUFcsOrhdDVlaJi+69y3
         ACYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717119613; x=1717724413;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2t5EcuhFKFYbv2Rd9t0NV0fJiuW2dSu7qfxhtP3jFNE=;
        b=bGHZuCzEeWIdhWLTrO/+F5dm9X1gzfw6p/BXMpONu158pZE1WgWvEKDN0C1dTk49Wn
         xIJ9XNe4vp6bLQ+CQpcAbCs8UEPgdKTh7xhJGek0OqxoIZ0RHjKR+hYUz9b8rKulYlAH
         3FB8150/BtTq2dVLY5kRoru5YAZVSENBIYoanIcSXtZ9Bn3WV69sGbC2ilSNsHOHHqJQ
         cnneian0vY71KJ2AXqYxmTZsUnlMXki52lAm7mFu1r7IZ4BQz65r3SRz1IL1IRjnc+8F
         TGfiYCPcLjWN7K7fqSrqU9D+nQmKqBcvWgoxEanIqFT/aggWN3RgaqfYPbDvHkFGB1zb
         qd0w==
X-Forwarded-Encrypted: i=1; AJvYcCW5CRMNXUC044w86U2G05DXfAcpCuwmDHtKBUZc53oAkciIBPHYA2DSB4fKBz2AQyTPkKYhXbqz+SB4SDb2uO/Bs9FbNzAyiuK90afK
X-Gm-Message-State: AOJu0YzUgMf1bPH57C99EZ6J0i901Lxv+zi/X+bLupnaZnCkdZ05uVCa
	xYOAgpE/NsYIyjhcxqemYRfi/8yuisQDqVgcQiO4LH8CNRQ9I5KbDoAmm7xu089LBIGEIk+iaqT
	NwXsPxHijoIxTZBrmu6PuQFcYXX0=
X-Google-Smtp-Source: AGHT+IFYFaEZ3Edx2O6D+oSsu6WVUMhuF7NpJWdVA2LsYC1KQJArdEwMeENxSf+oreH0QS6Xx4QwchMHH4tdb5pxcLQ=
X-Received: by 2002:a05:651c:2112:b0:2e4:d378:7839 with SMTP id
 38308e7fff4ca-2ea950a6bedmr1765251fa.4.1717119613165; Thu, 30 May 2024
 18:40:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240531005007.1600287-1-zhaoyang.huang@unisoc.com> <20240531012718.ogitylhpsrrvvczo@oppo.com>
In-Reply-To: <20240531012718.ogitylhpsrrvvczo@oppo.com>
From: Zhaoyang Huang <huangzhaoyang@gmail.com>
Date: Fri, 31 May 2024 09:40:01 +0800
Message-ID: <CAGWkznHdbC_RJWYonKkHXpma+ioi7aRn+pDMnQBr=3KpsN8MkA@mail.gmail.com>
Subject: Re: [PATCHv2] mm: fix incorrect vbq reference in purge_fragmented_block
To: hailong liu <hailong.liu@oppo.com>
Cc: "zhaoyang.huang" <zhaoyang.huang@unisoc.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Uladzislau Rezki <urezki@gmail.com>, Christoph Hellwig <hch@infradead.org>, 
	Lorenzo Stoakes <lstoakes@gmail.com>, Baoquan He <bhe@redhat.com>, 
	Thomas Gleixner <tglx@linutronix.de>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	steve.kang@unisoc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 31, 2024 at 9:27=E2=80=AFAM hailong liu <hailong.liu@oppo.com> =
wrote:
>
> On Fri, 31. May 08:50, zhaoyang.huang wrote:
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
> > Fixes: fc1e0d980037 ("mm/vmalloc: prevent stale TLBs in fully utilized =
blocks")
> >
> > Signed-off-by: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
> > ---
> > v2: introduce cpu in vmap_block to record the right CPU number
> > ---
> > ---
> >  mm/vmalloc.c | 11 +++++++----
> >  1 file changed, 7 insertions(+), 4 deletions(-)
> >
> > diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> > index 22aa63f4ef63..ca962b554fa0 100644
> > --- a/mm/vmalloc.c
> > +++ b/mm/vmalloc.c
> > @@ -2458,6 +2458,7 @@ struct vmap_block {
> >       struct list_head free_list;
> >       struct rcu_head rcu_head;
> >       struct list_head purge;
> > +     unsigned int cpu;
> >  };
> >
> >  /* Queue of free and dirty vmap blocks, for allocation and flushing pu=
rposes */
> > @@ -2574,6 +2575,7 @@ static void *new_vmap_block(unsigned int order, g=
fp_t gfp_mask)
> >       vb->dirty =3D 0;
> >       vb->dirty_min =3D VMAP_BBMAP_BITS;
> >       vb->dirty_max =3D 0;
> if task migration to other CPU at this time, this may lead to get incorre=
ct vbq.
ok, thanks for the prompt. If this works?
    vb->cpu =3Dget_cpu();
    ...
    put_cpu();
    return vaddr;

> > +     vb->cpu =3D smp_processor_id();
> >       bitmap_set(vb->used_map, 0, (1UL << order));
> >       INIT_LIST_HEAD(&vb->free_list);
> >
> > @@ -2614,9 +2616,10 @@ static void free_vmap_block(struct vmap_block *v=
b)
> >  }
> >
> >  static bool purge_fragmented_block(struct vmap_block *vb,
> > -             struct vmap_block_queue *vbq, struct list_head *purge_lis=
t,
> > -             bool force_purge)
> > +             struct list_head *purge_list, bool force_purge)
> >  {
> > +     struct vmap_block_queue *vbq =3D &per_cpu(vmap_block_queue, vb->c=
pu);
> > +
> >       if (vb->free + vb->dirty !=3D VMAP_BBMAP_BITS ||
> >           vb->dirty =3D=3D VMAP_BBMAP_BITS)
> >               return false;
> > @@ -2664,7 +2667,7 @@ static void purge_fragmented_blocks(int cpu)
> >                       continue;
> >
> >               spin_lock(&vb->lock);
> > -             purge_fragmented_block(vb, vbq, &purge, true);
> > +             purge_fragmented_block(vb, &purge, true);
> >               spin_unlock(&vb->lock);
> >       }
> >       rcu_read_unlock();
> > @@ -2801,7 +2804,7 @@ static void _vm_unmap_aliases(unsigned long start=
, unsigned long end, int flush)
> >                        * not purgeable, check whether there is dirty
> >                        * space to be flushed.
> >                        */
> > -                     if (!purge_fragmented_block(vb, vbq, &purge_list,=
 false) &&
> > +                     if (!purge_fragmented_block(vb, &purge_list, fals=
e) &&
> >                           vb->dirty_max && vb->dirty !=3D VMAP_BBMAP_BI=
TS) {
> >                               unsigned long va_start =3D vb->va->va_sta=
rt;
> >                               unsigned long s, e;
> > --
> > 2.25.1
> >
> >
>
> --
>
> Best Regards,
> Hailong.

