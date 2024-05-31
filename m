Return-Path: <linux-kernel+bounces-196555-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 649488D5DE7
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 11:12:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 883CB1C247DF
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 09:12:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2A5B15665C;
	Fri, 31 May 2024 09:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bt/SNztV"
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4467C13774C
	for <linux-kernel@vger.kernel.org>; Fri, 31 May 2024 09:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717146722; cv=none; b=KftVsFpeGHdzTKLRScXu0OUJmbFohUjc1cNhUGHlar6T4dDVbDCxk68cHzYXEqkws4MTH8HpVOavDlxLaow/ectQemzLXAqHk0R6oQTel/4u3+xHGLqpOaCDKGkxSNC4KVHOahz6kQfkCr4G3s50oChv8nvAWowhESG+0Vz/mvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717146722; c=relaxed/simple;
	bh=5mtRAJODRoRRW7DQ4SAOIQDPLWDoHRI78Zad6G6Afwk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qGquXGmjd2pPQ8DaKihA9++tdSjGV4OtcS6io++yafbcuZFKjLohEpqwqPRauaNo9AlPRGwt9tUzXb5ip2lbW3PIASJ1J2kMVtinYCJTWvaDzKkVHGHsXvvf9s7hRZEdROWT/zxvSchaEdDDwapcUwugUrWDLcYDR6dLJoF7bPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bt/SNztV; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2e95a883101so23139711fa.3
        for <linux-kernel@vger.kernel.org>; Fri, 31 May 2024 02:11:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717146718; x=1717751518; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DDTL4Ai9HAUKZeXb8qttk1mqXc5B8kPTvJ/FkRqwff4=;
        b=bt/SNztV60qwIsyBc9c2BLBfdq1FUUMeqwpaPKOtAUMNpXFGZaX7bN/PERTfewfJoS
         YhZJuqD/EH5IqcjRzWH5JxDDDKHJrKjyo6mn2BLDTu/P7JX+YNi+G67ARHTiQK1OzaMY
         w5Wle0XL7beA3zpsbnrI1J0PJAGldqp5ue5aGtEbAyjCsPO8o9ZbZdoC+pQwh2RVOgyG
         a/szqk6NEMDCEr3I2u/IW84ymXfzEYJxEPJM/hJOdfE6FFIYm4c6nyY1oHFy54fBcVn6
         vNHkasPzNFEzkOk5a6bZhyfbGN1UF8Uz28G3N4wSON9eONsUelXYAc57+yr8Pyz79HyC
         W9uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717146718; x=1717751518;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DDTL4Ai9HAUKZeXb8qttk1mqXc5B8kPTvJ/FkRqwff4=;
        b=tmpEQU505ouyPDNSFQ+cHubaLfrJMqKGj+11lFL930iwb8vvvPho1Bfy+CmwnI3fuc
         yGAWUIjJzqGAxP8K0WT3cKoYocxx3z+rBLjTon8pjZiyysPJPVrcQHTsJoJtOzweH6/H
         YKr7YkDNg/eg1p5FUP9R2/n3Qt1uS80XBIvPjmzSzKpopRV/FnHxCTt5gnZv+U2IVCzK
         JcXk838j2L4J8jESalX1B58KlRjU4A/q6YQKQ0dBviTimhNtTUXKMAvcHJEjBNZiCgoo
         eSV9N1YR+Jt5P3LyZxPi5VzjR9yTqfHYT/u3m+678RHCTJ7XslV4SOxg3AmbJct7jvcB
         iLTA==
X-Forwarded-Encrypted: i=1; AJvYcCVrTY+LDEnwRWhmvE843e4aryzXyZVxSTz7LbvfdCrPHvdVsfJnsKmBK8Cyk1F/N2Xe56Epwc53NzKrXWWbNDzRDh6iEHT185Wwe2pA
X-Gm-Message-State: AOJu0YyLKvOD9mWY/TM8RdwVr+LFMVEGUiSqBqt1vJDD6M9laGiuIvA9
	JnDOVFYkUqM/p83nThRDoVCubu3NxbK5g04CMZEom9aDxAuZYFRamPpA2migD2N3vieulznVG+Y
	R/psqWlxUYj5UfeoX1/g2H1OFSRk=
X-Google-Smtp-Source: AGHT+IGvOJMSovM0rMQhVTi97Ctg/NxKx43UQuMGogjYUJXvlYBBL74TBPWdW1JHxE2/8U2nmyzJ1QfpYFBRznw2pP4=
X-Received: by 2002:a2e:3c15:0:b0:2e9:5ad5:2bb6 with SMTP id
 38308e7fff4ca-2ea951d54d6mr8934101fa.47.1717146718095; Fri, 31 May 2024
 02:11:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240531030520.1615833-1-zhaoyang.huang@unisoc.com> <ZlmEp9nxKiG9gWFj@pc636>
In-Reply-To: <ZlmEp9nxKiG9gWFj@pc636>
From: Zhaoyang Huang <huangzhaoyang@gmail.com>
Date: Fri, 31 May 2024 17:11:45 +0800
Message-ID: <CAGWkznGak0txoOEq1SYL9Ymax04Tac2nVCSYiC+L8qQ6bqryZQ@mail.gmail.com>
Subject: Re: [PATCHv3] mm: fix incorrect vbq reference in purge_fragmented_block
To: Uladzislau Rezki <urezki@gmail.com>
Cc: "zhaoyang.huang" <zhaoyang.huang@unisoc.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Christoph Hellwig <hch@infradead.org>, Lorenzo Stoakes <lstoakes@gmail.com>, Baoquan He <bhe@redhat.com>, 
	Thomas Gleixner <tglx@linutronix.de>, hailong liu <hailong.liu@oppo.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, steve.kang@unisoc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 31, 2024 at 4:05=E2=80=AFPM Uladzislau Rezki <urezki@gmail.com>=
 wrote:
>
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
> > Fixes: fc1e0d980037 ("mm/vmalloc: prevent stale TLBs in fully utilized =
blocks")
> >
> > Suggested-by: Hailong.Liu <hailong.liu@oppo.com>
> > Signed-off-by: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
> >
> Is a problem related to run out of vmalloc space _only_ or it is a proble=
m
> with broken list? From the commit message it is hard to follow the reason=
.
>
> Could you please post a full trace or panic?
Please refer to the below scenario for how vbq->free broken.
step 1: new_vmap_block is called in CPU0 and get vb->va->addr =3D
0xffffffc000400000
step 2: vb is added to CPU1's vbq->vmap_block(xarray) by xa =3D
addr_to_vb_xa(va->va_start);
            fc1e0d980037 ("mm/vmalloc: prevent stale TLBs in fully
utilized blocks") introduce a per_cpu like xarray mechanism to have vb
be added to the corresponding CPU's xarray but not local.
step 3: vb is added to CPU0's vbq->free by
list_add_tail_rcu(&vb->free_list, &vbq->free);
step 4 : purge_fragmented_blocks get vbq of CPU1 and then get above vb
step 5 : purge_fragmented_blocks delete vb from CPU0's list with
taking the vbq->lock of CPU1
step 5': vb_alloc on CPU0 could race with step5 and break the CPU0's vbq->f=
ree

As fc1e0d980037 solved the problem of staled TLB issue, we need to
introduce a new variable to record the CPU in vmap_block instead of
reverting to iterate the list(will leave wrong TLB entry)
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
> >       struct list_head free_list;
> >       struct rcu_head rcu_head;
> >       struct list_head purge;
> > +     unsigned int cpu;
> >  };
> >
> >  /* Queue of free and dirty vmap blocks, for allocation and flushing pu=
rposes */
> > @@ -2586,10 +2587,12 @@ static void *new_vmap_block(unsigned int order,=
 gfp_t gfp_mask)
> >               return ERR_PTR(err);
> >       }
> >
> > +     vb->cpu =3D get_cpu();
> >       vbq =3D raw_cpu_ptr(&vmap_block_queue);
> >       spin_lock(&vbq->lock);
> >       list_add_tail_rcu(&vb->free_list, &vbq->free);
> >       spin_unlock(&vbq->lock);
> > +     put_cpu();
> >
> Why do you need get_cpu() here? Can you go with raw_smp_processor_id()
> and then access the per-cpu "vmap_block_queue"? get_cpu() disables
> preemption and then a spin-lock is take within this critical section.
> From the first glance PREEMPT_RT is broken in this case.
get_cpu here is to prevent current task from being migrated to other
COREs before we get the per_cpu vmap_block_queue. Could you please
suggest a correct way of doing this?

>
> I am on a vacation, responds can be with delays.
>
> --
> Uladzislau Rezki

