Return-Path: <linux-kernel+bounces-196658-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B11D8D5F6A
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 12:17:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0BFF81F215A7
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 10:17:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B70FA14C581;
	Fri, 31 May 2024 10:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FDcsA9J7"
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C1A217554
	for <linux-kernel@vger.kernel.org>; Fri, 31 May 2024 10:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717150668; cv=none; b=ih4kSZefdyF6N2omX2tsNb87JiSJXmXOoKD8N9SPo31wQ6p5qHZ+EyuQHLYi48UrV1igOnPPvuWDhFbZT6PODnumZBdp1TAYCzBVpYhNr/thPQinpLqZcymjQDnulvO5Hqs+AhS1SexhuJBVnCVGXGwfDKhW32jmcgMizWTwuLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717150668; c=relaxed/simple;
	bh=prdCZOznwDNvu6snl24VEO2hfwhspXa2lXjHhWav0m0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UoSh3plwVx1+zVVXtvHWh5ALfkMx2hJJE2Ps6OU2uSP4PvTt3I2qKPX4HXHGNJcWe0owq5V+w4kVIanwU97WFls593tpkTof+N6sM36XGqd4YqJFEbGixaXrPQEzBvp1CSa/V0DBDpxw1W79d3Inp3FkXVpHe2C2o/m8pG69L04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FDcsA9J7; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2ea8fff1486so9041591fa.1
        for <linux-kernel@vger.kernel.org>; Fri, 31 May 2024 03:17:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717150665; x=1717755465; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TWqmSKkMMPozlvG9PvsxZ7J4hb8xyIyUVNhn6fNsCNY=;
        b=FDcsA9J7TfaFIODD2dc8v2G32jOlzvI7+jgGHadRAg6dCBZv6ilU3ODY5tO2wSrjLz
         r+TpEU9sLNTgixMOxskYDLNvMVjv8kEEKDCT3sqMlAlepCF7pw1SuIKH7vVHP5sB1pyM
         JWpdxdWu2y+GoYIrJp7sVmbuhXXDipNcjOElLQ18114xX4GSOjHilp5MHCkWowOOS5du
         Axq5huJJZWBccfxMIzbgRgJ0HFtl1bs/oYfAOOe8T41LQfsEnj0nI0BpvCIiKZhR/Lo5
         PTg8UknPTrJIODNIRznPrsql2wGBacMqVEXR98AitUoUByFDhEb2F3wVmwp6G2seoA5m
         Gizg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717150665; x=1717755465;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TWqmSKkMMPozlvG9PvsxZ7J4hb8xyIyUVNhn6fNsCNY=;
        b=vL0TVc0OFGl49oIeEqCjU9MBonLle3sQPbjTjPK0DRmgzUTdErAlyiW2crmW/GJY0p
         GZIhaKXLwLgnb5gtFQUsiyU7BMshYhv/dP3O3DKjYK2MplLzRnuXUzQvoN7srQOmVyI/
         601qcTjNBN3BJElc+YZzpKJs3dwgW9mws8IjccP8cg5LpbZTVvsAKeexvJo/aj8JPbW4
         Hb5C1Fml6XuimPuODdSQAX7dSBfFzNbnIHyCrqeO2YAT9EQXsdWZcLLkizIHkW6ZBnzP
         M2wYUWc778NJGanPRF5UZIrU+2+u0r/n9kgppDS439G79qz3UZeFby2ZIXAe/JQ2Dpk3
         eulQ==
X-Forwarded-Encrypted: i=1; AJvYcCXThxSamwLZNHPkO1yOfgIdT3m6EakWY0VHdZJ5l9FDrn4MQpGCHZDanIYgBTYQ2+Ni63+4a8jSygPCxs1UaG81ElTN9SP/kumhPmBk
X-Gm-Message-State: AOJu0YySGWYra+du6GE6I5h1Vm//LLSt0TNLDHA2sBZ3fON8nVPcWfQr
	SLifDG5rJUmLXh047ZX7Uw2stDuNYqakXTZIjMTq9XFvrTe08DtZxUHc9FcofMwu3Aa1rARJzvy
	DkWExVAhSomf3qOsHfltIdNkVdYY=
X-Google-Smtp-Source: AGHT+IFxiVOz/AQ6oFP/EWN8n0vVEn6fqbzgHGw6qCJpt+kwdpzR8gQlWbP8gFy7jvsJTfNAI60ggmalUAnQN2lqbpg=
X-Received: by 2002:a2e:8e62:0:b0:2e9:550b:f28f with SMTP id
 38308e7fff4ca-2ea950d195cmr4641081fa.6.1717150664874; Fri, 31 May 2024
 03:17:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240531030520.1615833-1-zhaoyang.huang@unisoc.com>
 <ZlmEp9nxKiG9gWFj@pc636> <CAGWkznGak0txoOEq1SYL9Ymax04Tac2nVCSYiC+L8qQ6bqryZQ@mail.gmail.com>
 <CAGsJ_4ywu+WgOz_nxaeCa2qzv2=qDa8ZJWOUYb4LqVUq2qeCxQ@mail.gmail.com>
In-Reply-To: <CAGsJ_4ywu+WgOz_nxaeCa2qzv2=qDa8ZJWOUYb4LqVUq2qeCxQ@mail.gmail.com>
From: Zhaoyang Huang <huangzhaoyang@gmail.com>
Date: Fri, 31 May 2024 18:17:33 +0800
Message-ID: <CAGWkznE1tChV=idAEH7AQG7Uw8e411yZMfjKknuSH1GG8SSXDw@mail.gmail.com>
Subject: Re: [PATCHv3] mm: fix incorrect vbq reference in purge_fragmented_block
To: Barry Song <21cnbao@gmail.com>
Cc: Uladzislau Rezki <urezki@gmail.com>, "zhaoyang.huang" <zhaoyang.huang@unisoc.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Christoph Hellwig <hch@infradead.org>, 
	Lorenzo Stoakes <lstoakes@gmail.com>, Baoquan He <bhe@redhat.com>, 
	Thomas Gleixner <tglx@linutronix.de>, hailong liu <hailong.liu@oppo.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, steve.kang@unisoc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 31, 2024 at 5:56=E2=80=AFPM Barry Song <21cnbao@gmail.com> wrot=
e:
>
> On Fri, May 31, 2024 at 9:13=E2=80=AFPM Zhaoyang Huang <huangzhaoyang@gma=
il.com> wrote:
> >
> > On Fri, May 31, 2024 at 4:05=E2=80=AFPM Uladzislau Rezki <urezki@gmail.=
com> wrote:
> > >
> > > On Fri, May 31, 2024 at 11:05:20AM +0800, zhaoyang.huang wrote:
> > > > From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
> > > >
> > > > vmalloc area runs out in our ARM64 system during an erofs test as
> > > > vm_map_ram failed[1]. By following the debug log, we find that
> > > > vm_map_ram()->vb_alloc() will allocate new vb->va which correspondi=
ng
> > > > to 4MB vmalloc area as list_for_each_entry_rcu returns immediately
> > > > when vbq->free->next points to vbq->free. That is to say, 65536 tim=
es
> > > > of page fault after the list's broken will run out of the whole
> > > > vmalloc area. This should be introduced by one vbq->free->next poin=
t to
> > > > vbq->free which makes list_for_each_entry_rcu can not iterate the l=
ist
> > > > and find the BUG.
> > > >
> > > > [1]
> > > > PID: 1        TASK: ffffff80802b4e00  CPU: 6    COMMAND: "init"
> > > >  #0 [ffffffc08006afe0] __switch_to at ffffffc08111d5cc
> > > >  #1 [ffffffc08006b040] __schedule at ffffffc08111dde0
> > > >  #2 [ffffffc08006b0a0] schedule at ffffffc08111e294
> > > >  #3 [ffffffc08006b0d0] schedule_preempt_disabled at ffffffc08111e3f=
0
> > > >  #4 [ffffffc08006b140] __mutex_lock at ffffffc08112068c
> > > >  #5 [ffffffc08006b180] __mutex_lock_slowpath at ffffffc08111f8f8
> > > >  #6 [ffffffc08006b1a0] mutex_lock at ffffffc08111f834
> > > >  #7 [ffffffc08006b1d0] reclaim_and_purge_vmap_areas at ffffffc0803e=
bc3c
> > > >  #8 [ffffffc08006b290] alloc_vmap_area at ffffffc0803e83fc
> > > >  #9 [ffffffc08006b300] vm_map_ram at ffffffc0803e78c0
> > > >
> > > > Fixes: fc1e0d980037 ("mm/vmalloc: prevent stale TLBs in fully utili=
zed blocks")
> > > >
> > > > Suggested-by: Hailong.Liu <hailong.liu@oppo.com>
> > > > Signed-off-by: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
> > > >
> > > Is a problem related to run out of vmalloc space _only_ or it is a pr=
oblem
> > > with broken list? From the commit message it is hard to follow the re=
ason.
> > >
> > > Could you please post a full trace or panic?
> > Please refer to the below scenario for how vbq->free broken.
> > step 1: new_vmap_block is called in CPU0 and get vb->va->addr =3D
> > 0xffffffc000400000
> > step 2: vb is added to CPU1's vbq->vmap_block(xarray) by xa =3D
> > addr_to_vb_xa(va->va_start);
> >             fc1e0d980037 ("mm/vmalloc: prevent stale TLBs in fully
> > utilized blocks") introduce a per_cpu like xarray mechanism to have vb
> > be added to the corresponding CPU's xarray but not local.
> > step 3: vb is added to CPU0's vbq->free by
> > list_add_tail_rcu(&vb->free_list, &vbq->free);
> > step 4 : purge_fragmented_blocks get vbq of CPU1 and then get above vb
> > step 5 : purge_fragmented_blocks delete vb from CPU0's list with
> > taking the vbq->lock of CPU1
> > step 5': vb_alloc on CPU0 could race with step5 and break the CPU0's vb=
q->free
> >
> > As fc1e0d980037 solved the problem of staled TLB issue, we need to
> > introduce a new variable to record the CPU in vmap_block instead of
> > reverting to iterate the list(will leave wrong TLB entry)
> > >
> > > > ---
> > > > v2: introduce cpu in vmap_block to record the right CPU number
> > > > v3: use get_cpu/put_cpu to prevent schedule between core
> > > > ---
> > > > ---
> > > >  mm/vmalloc.c | 12 ++++++++----
> > > >  1 file changed, 8 insertions(+), 4 deletions(-)
> > > >
> > > > diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> > > > index 22aa63f4ef63..ecdb75d10949 100644
> > > > --- a/mm/vmalloc.c
> > > > +++ b/mm/vmalloc.c
> > > > @@ -2458,6 +2458,7 @@ struct vmap_block {
> > > >       struct list_head free_list;
> > > >       struct rcu_head rcu_head;
> > > >       struct list_head purge;
> > > > +     unsigned int cpu;
> > > >  };
> > > >
> > > >  /* Queue of free and dirty vmap blocks, for allocation and flushin=
g purposes */
> > > > @@ -2586,10 +2587,12 @@ static void *new_vmap_block(unsigned int or=
der, gfp_t gfp_mask)
> > > >               return ERR_PTR(err);
> > > >       }
> > > >
> > > > +     vb->cpu =3D get_cpu();
> > > >       vbq =3D raw_cpu_ptr(&vmap_block_queue);
> > > >       spin_lock(&vbq->lock);
> > > >       list_add_tail_rcu(&vb->free_list, &vbq->free);
> > > >       spin_unlock(&vbq->lock);
> > > > +     put_cpu();
> > > >
> > > Why do you need get_cpu() here? Can you go with raw_smp_processor_id(=
)
> > > and then access the per-cpu "vmap_block_queue"? get_cpu() disables
> > > preemption and then a spin-lock is take within this critical section.
> > > From the first glance PREEMPT_RT is broken in this case.
> > get_cpu here is to prevent current task from being migrated to other
> > COREs before we get the per_cpu vmap_block_queue. Could you please
> > suggest a correct way of doing this?
>
> not quite sure if you have to pay the price of disabling preempt.
> Does the below Hailong suggested fix your problem?
>
> vb->cpu =3D raw_smp_processor_id();
> vbq =3D per_cpu_ptr(&vmap_block_queue, vb->cpu);
emm, it looks like 2 could race with 2' which also leads to wrong
vbq->free status, right?

taskA
1.  CPU0:
    vb->cpu =3D raw_smp_processor_id();
2.  CPU1:
    vbq =3D per_cpu_ptr(&vmap_block_queue, vb->cpu(0));

taskB
 2'. CPU0:
static void *vb_alloc(unsigned long size, gfp_t gfp_mask)
{
        rcu_read_lock();
        vbq =3D raw_cpu_ptr(&vmap_block_queue);
        list_for_each_entry_rcu(vb, &vbq->free, free_list) {
>
> >
> > >
> > > I am on a vacation, responds can be with delays.
> > >
> > > --
> > > Uladzislau Rezki
>
> Thanks
> Barry

