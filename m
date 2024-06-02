Return-Path: <linux-kernel+bounces-198202-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 105258D74D1
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jun 2024 13:02:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B4CB9281C2E
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jun 2024 11:02:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFF2237703;
	Sun,  2 Jun 2024 11:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TpUfkO/m"
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A9FD2628D
	for <linux-kernel@vger.kernel.org>; Sun,  2 Jun 2024 11:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717326164; cv=none; b=iVKT/rmU0COPnypg7Y3oUsW+1viM67Oau+krJ5j8nMhtKCHyKPBPUQ18JBmD4nGyzjxCaJsGvn0IACa8kQVsn4GX4VUe/nB3C4gMphhcgaf6Vvc0Emzfdnou8kI4VZLMqq4B/71qSd5Z9zZDWZS6/C2tcN8W2lvvLtB6E1ESwyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717326164; c=relaxed/simple;
	bh=z9AZHBI3Q/NHb45SGkEsW6mP0SB6I4HJY/pUVABc660=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OTPb8rfSo2/5isrErMIkNfDLqq7gT8W8KEUAKc3etB2Gcvul/6d6m8dnwrOqrgXEGaHoFxmJET4QiJO9ejSxjxygWTVj7nX4/UmKs8l5+SUi1Wu4XwtkrCf3A9kVl+rChZXjudnXq4PdPZ9AsZdY7RpZ3XzgjRYYDYypTJtAZ4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TpUfkO/m; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2e95a74d51fso52007761fa.2
        for <linux-kernel@vger.kernel.org>; Sun, 02 Jun 2024 04:02:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717326160; x=1717930960; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OvyOhWiM2rQIHomj4DY7TiG5cgjCTqPWZhY6q6i+OGM=;
        b=TpUfkO/m3ZE3RhdzTrvN60b+zLWE9+PblU3B8ccoI5VSlafSTuelmdES+T0zSJEQ25
         TkeO13m2Kx1OrXgR2yZ+GCq5f21qhcDXvs5l9y/MxYqVsDeBH9t80akKw+j88R98r3wC
         Z7NCQiJfXIBbcOFuJ3Ls4eoWMziPKJnZeCvWwZ/tn2WziDi7ExSknaM7WUWRUmLhSkBJ
         AL8k5UvBahXLGPDl94V+bm0YnqyGoqg+5rZXApgvOglSK+4tKMkABbojS9dPQDb0NnoK
         MxC5NPMuftA6a1yBn42V2O/Mi1CtMDWNI2rns1n5+fnD3ymzn5HCaReTwJO779afQVPW
         whvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717326160; x=1717930960;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OvyOhWiM2rQIHomj4DY7TiG5cgjCTqPWZhY6q6i+OGM=;
        b=bk7+9DdiCdp2kR5VflFbg4h4RwY1/HW9zXjbbEzADpP/3YVxrCdwaH+wgKVYj8dG+B
         fvjp/NSdDgQCrr7SrvMmwXiRgIMNgUq01Ml0/xuQIObaxctbXxGw2jX4AxLudLNK5KQV
         QE2rBf+ySccIPEcvc5zJ2jNS6DpRFbF25oRi4nVUDMH6HpJCQUYkZY+/H1Lare2E5USp
         6KzSLGohj9DHN1ZjdvtLaWfVmtT1NkSFIJvWpZ9zmKriVuUyCzU1Fm6o+BwB5T0Uwa85
         PEjUvEgjK8QHu03hOl2YijWouFJjBqfEQDydWuM4Pj0C+Viy25d8SvrTo2OAmG41nCHs
         7v6A==
X-Forwarded-Encrypted: i=1; AJvYcCWtDE2QlhFIRPvSB3Fk6AovLBAILLL44uPAzeizCm3VPpztGoibwcgQEDvfjFpAfNsAsdDT20sGIp375IP0hmaA8k+TRQjLmtEkaoyT
X-Gm-Message-State: AOJu0Yw0DTu04dks4C+4F3QOz8oPY9TbzU77JN89EeOqfuer6OVDo6PC
	4Gx6x7fidNz4BiUYMu9SQJeDlQL6gqyy1znn1ULIzFdcwUnq7FIISwTByEheeKXNLTndrCG3Jcl
	Twkx/o6tjmPofu8I41F+2j51awF0=
X-Google-Smtp-Source: AGHT+IG6h0NcNH5Bcu9B8dU0JMMQsTv7A0rDcHHCnyDQqR7bpE7UOVdW0pJP2DJASH2WC5TyzC3zulLosvryES0NRUA=
X-Received: by 2002:a2e:9ec6:0:b0:2e6:935f:b6d3 with SMTP id
 38308e7fff4ca-2ea9510e721mr54272811fa.14.1717326160067; Sun, 02 Jun 2024
 04:02:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240531030520.1615833-1-zhaoyang.huang@unisoc.com>
 <ZlmEp9nxKiG9gWFj@pc636> <ZlqIp9V1Jknm7axa@MiWiFi-R3L-srv>
In-Reply-To: <ZlqIp9V1Jknm7axa@MiWiFi-R3L-srv>
From: Zhaoyang Huang <huangzhaoyang@gmail.com>
Date: Sun, 2 Jun 2024 19:02:28 +0800
Message-ID: <CAGWkznGCF23_q1=d-oHY7QVqf+D7DM7ndN082Dy+X5JBeaYTgA@mail.gmail.com>
Subject: Re: [PATCHv3] mm: fix incorrect vbq reference in purge_fragmented_block
To: Baoquan He <bhe@redhat.com>
Cc: Uladzislau Rezki <urezki@gmail.com>, "zhaoyang.huang" <zhaoyang.huang@unisoc.com>, 
	hailong liu <hailong.liu@oppo.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Christoph Hellwig <hch@infradead.org>, Lorenzo Stoakes <lstoakes@gmail.com>, 
	Thomas Gleixner <tglx@linutronix.de>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	steve.kang@unisoc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jun 1, 2024 at 10:34=E2=80=AFAM Baoquan He <bhe@redhat.com> wrote:
>
> On 05/31/24 at 10:04am, Uladzislau Rezki wrote:
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
>
> This should fix the broken list.
>
> Hi Zhaoyang and Hailong,
>
> Could any of you test below patch in your testing environment?
>
> From b56dcc7d98c4dbb7ea197516bd129c30c0e9d1ef Mon Sep 17 00:00:00 2001
> From: Baoquan He <bhe@redhat.com>
> Date: Fri, 31 May 2024 23:44:57 +0800
> Subject: [PATCH] mm/vmalloc.c: add vb into appropriate vbq->free
> Content-type: text/plain
>
> The current vbq is organized into per-cpu data structure, including a xa
> and list. However, its adding into vba->free list is not handled
> correctly. The new vmap_block allocation could be done in one cpu, while
> it's actually belong into anohter cpu's percpu vbq. Then the
> list_for_each_entry_rcu() on the vbq->free and its deletion could cause
> list breakage.
>
> This fix the wrong vb adding to make it be added into expected
> vba->free.
>
> Signed-off-by: Baoquan He <bhe@redhat.com>
> ---
>  mm/vmalloc.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
>
> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> index b921baf0ef8a..47659b41259a 100644
> --- a/mm/vmalloc.c
> +++ b/mm/vmalloc.c
> @@ -2547,6 +2547,14 @@ addr_to_vb_xa(unsigned long addr)
>         return &per_cpu(vmap_block_queue, index).vmap_blocks;
>  }
>
> +static struct vmap_block_queue *
> +addr_to_vbq(unsigned long addr)
> +{
> +       int index =3D (addr / VMAP_BLOCK_SIZE) % num_possible_cpus();
> +
> +       return &per_cpu(vmap_block_queue, index);
> +}
emm, I am wondering if it make sense to add addr to vbp[CPU1] from
CPU0 etc which is against per_cpu variable's goal?
> +
>  /*
>   * We should probably have a fallback mechanism to allocate virtual memo=
ry
>   * out of partially filled vmap blocks. However vmap block sizing should=
 be
> @@ -2626,7 +2634,7 @@ static void *new_vmap_block(unsigned int order, gfp=
_t gfp_mask)
>                 return ERR_PTR(err);
>         }
>
> -       vbq =3D raw_cpu_ptr(&vmap_block_queue);
> +       vbq =3D addr_to_vbq(va->va_start);

>         spin_lock(&vbq->lock);
>         list_add_tail_rcu(&vb->free_list, &vbq->free);
>         spin_unlock(&vbq->lock);
> --
> 2.41.0
>

