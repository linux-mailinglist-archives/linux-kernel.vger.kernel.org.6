Return-Path: <linux-kernel+bounces-195052-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DA6878D46E4
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 10:18:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 43A93B218E1
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 08:18:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24DC514AD25;
	Thu, 30 May 2024 08:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aPplUFCG"
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82B2914387F
	for <linux-kernel@vger.kernel.org>; Thu, 30 May 2024 08:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717057127; cv=none; b=FxCQ7E+oci+8DnC2vD+Qph/JpZkg8zFAcX6quh1H80Y5Z1uyVog9ja92VyTA9mojFFysppDmxpq9Bk1X/b9tdtqHUydeXyVP7bmnUToWrOJevdGNWKfayME0fLmjbljEdKyLkzfULAcU/3i+Xwrr7QGCJj8J1UHzwcqBcBsQ8mo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717057127; c=relaxed/simple;
	bh=rNwHQiH6mmQDwL0U6Z8P3lRAILA5tuVfCPZGLxWRoqI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pQKS0c7ZKDB4UYYslqMLB+3f4CGZ2bthWE7UKDac865prOJociEkmXydjj6ahRhRi1YtKkuH6A+nNrvKcpCtXFL5jzZ11tSE8AK9tB17phzUJKwDDbp34JA9iHDqiCmqA/S432T6Uj7O9O63zU8pu8X440Q6fVQfQP0OIfZnGSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aPplUFCG; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2e95a1d5ee2so10089901fa.0
        for <linux-kernel@vger.kernel.org>; Thu, 30 May 2024 01:18:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717057124; x=1717661924; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/zaL5WD7NTrZXgrCgxrS4DuBKHjHniNbKiAgaYsZSm8=;
        b=aPplUFCGSojkax9RD0WkgnnbXyKdtL8uNYhXiyo/lHmeBMUmfjphVqoC/enAaFHyQl
         eXeaIeWkWi1pIM2QoIHpzrtHZTKwLY0RQfp9Kwy2eVG3/+BvXykvlLmujyP55HWFS6+A
         65BQ/HUWJQxqS1zlY3sgtAUhvV6RY8kHLj5yLOkrJ7v9Pg9u9DY2udaowNrSD/EEJMpc
         SECvw4fJD53Vgbgzy54OyoLpSvIZuwin9nvaWgPnsw8sta+gDXwcSdA4n1rAmQh7vJc2
         oeMq8wDIov0KdZtMHiELqADlJ6nldpBAksAx3hneh+3i6ygwSs2N65SO3fia9iteeMQD
         8MnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717057124; x=1717661924;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/zaL5WD7NTrZXgrCgxrS4DuBKHjHniNbKiAgaYsZSm8=;
        b=lhFPNID8HEj00ClPjuxzcI4lfhMqt8AeaRf8/t9bU/xzSudWAiXiNH7D8X/wJMU02L
         jcLRoCsLLnU17/092oqxOhCL58lZOCOG+w989OuHii4OCfxs5OtLQR/4TDN0c/wiJioS
         t8ecfHG6iAwFNXu/DOxr6C2vQsqxTmNgV5oRdBvOBJVjiNt+CZ8xLm80aP1s2IVtdXpn
         Cj9bfVFZKb0XqTb3rccdB3uL5u/3rCtGsjCGZPq9JeWjuFPK+Y0xojh8EinDT1yLpl5v
         zsQtQ8ziPNkvthKGvBAZSV2snrxRECeeVv+J+78y7JqT/4l35hxsE7HAAEc+1lRKMWVa
         PFTA==
X-Forwarded-Encrypted: i=1; AJvYcCUv3lcqDS1f+WHSy/B4XKwp664XKDQOkT7TrCKzGI+msEZCMaMaeZYSD3OyTpglBrD7T1d3REm5ILJyUuxV96wzGYWEWl77jVKfg6Un
X-Gm-Message-State: AOJu0YzfDFpzfuqhtGdDcUcNVbspKL5CSWaY5c76M9XRdTrV3+0dPNBE
	zxBvusg72IEjV6Fkc3oglCn08DWtXLFgBAUY2GcfqqhlC5YbyMu5C4kLClR176XEr58m6Pdk/Lv
	ZmBwFDUhxlW2trIKrGExK5T1F4EQ=
X-Google-Smtp-Source: AGHT+IGfnzM04cgjZOM34LIMfzSs8VxbR1kCAU/6ZNji/seMTGawYM31bLJqAb8oXPM0EjOJ+2axtTo0pFZ0XEobT34=
X-Received: by 2002:a2e:8ec8:0:b0:2e1:fa3f:67bd with SMTP id
 38308e7fff4ca-2ea8486d338mr10047371fa.36.1717057123451; Thu, 30 May 2024
 01:18:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240530025144.1570865-1-zhaoyang.huang@unisoc.com>
 <ZlgoX1E4/juuP7+o@MiWiFi-R3L-srv> <CAGWkznE=akrSBEQyq+f6tDN6fJ_J59WhJ-bvxpfrLUgTJ73h4g@mail.gmail.com>
 <ZlgwxwN3k5vQVVvH@MiWiFi-R3L-srv>
In-Reply-To: <ZlgwxwN3k5vQVVvH@MiWiFi-R3L-srv>
From: Zhaoyang Huang <huangzhaoyang@gmail.com>
Date: Thu, 30 May 2024 16:18:32 +0800
Message-ID: <CAGWkznG5Y2hwJLQk_-U9qVtaYL_g3WgvHYVkD_z-QcTtjzLAkw@mail.gmail.com>
Subject: Re: [PATCH] mm: fix incorrect vbq reference in purge_fragmented_block
To: Baoquan He <bhe@redhat.com>
Cc: "zhaoyang.huang" <zhaoyang.huang@unisoc.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Uladzislau Rezki <urezki@gmail.com>, Christoph Hellwig <hch@infradead.org>, 
	Lorenzo Stoakes <lstoakes@gmail.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	steve.kang@unisoc.com, Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 30, 2024 at 3:54=E2=80=AFPM Baoquan He <bhe@redhat.com> wrote:
>
> On 05/30/24 at 03:35pm, Zhaoyang Huang wrote:
> > On Thu, May 30, 2024 at 3:19=E2=80=AFPM Baoquan He <bhe@redhat.com> wro=
te:
> > >
> > > On 05/30/24 at 10:51am, zhaoyang.huang wrote:
> > > > From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
> > > >
> > > > Broken vbq->free reported on a v6.6 based system which is caused
> > > > by invalid vbq->lock protect over vbq->free in purge_fragmented_blo=
ck.
> > > > This should be introduced by the Fixes below which ignored vbq->loc=
k
> > > > matter.
> > >
> > > It will be helpful to provide more details, what's the symptom of the
> > > brekage, and in which case vbq->free is broken.
> > Vmalloc area runs out in our ARM64 system during an erofs test as
> > vm_map_ram failed[1]. We find that one vbq->free->next point to
> > vbq->free which makes list_for_each_entry_rcu can not iterate the list
> > and find the BUG.
>
> Thanks for these information which are very helpful and important.
> They need be put in log for easier understanding.
ok, I will update the commit message in the next version.

> about the vbq->free list breakage by the run out vmalloc area, could
vm_map_ram()->vb_alloc() will allocate new vb->va which corresponding
to 4MB vmalloc area as list_for_each_entry_rcu returns immediately
when vbq->free->next points to vbq->free. That is to say, 65536 times
of page fault after the list's broken will run out of the whole
vmalloc area.

> you say more about how it's caused? And do you think we need fix that
> vbq->free list breakage either?
IMO, the purge_fragmented_block->list_del_rcu could race with
new_vmap_block->list_add_tail_rcu when vbq is wrongly referenced.

>
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
> > #10 [ffffffc08006b420] z_erofs_lz4_decompress at ffffffc0806a49b0
> > #11 [ffffffc08006b670] z_erofs_decompress_queue at ffffffc0806a8fd0
> > #12 [ffffffc08006b860] z_erofs_runqueue at ffffffc0806a8744
> > #13 [ffffffc08006b970] z_erofs_readahead at ffffffc0806a6cfc
> > #14 [ffffffc08006ba00] read_pages at ffffffc08037ed78
> > #15 [ffffffc08006ba70] page_cache_ra_unbounded at ffffffc08037eb58
> > #16 [ffffffc08006bb00] page_cache_ra_order at ffffffc08037f42c
> > #17 [ffffffc08006bbb0] do_sync_mmap_readahead at ffffffc080371d3c
> > #18 [ffffffc08006bc40] filemap_fault at ffffffc080371774
> > #19 [ffffffc08006bd60] handle_mm_fault at ffffffc0803cc118
> > #20 [ffffffc08006bdc0] do_page_fault at ffffffc08112a618
> > #21 [ffffffc08006be20] do_translation_fault at ffffffc08112a36c
> > #22 [ffffffc08006be30] do_mem_abort at ffffffc0800bfbf0
> > #23 [ffffffc08006be70] el0_ia at ffffffc08111583c
> > #24 [ffffffc08006bea0] el0t_64_sync_handler at ffffffc0811156a4
> > #25 [ffffffc08006bfe0] el0t_64_sync at ffffffc080091584
> >
> >
> > >
> > > >
> > > > Fixes: fc1e0d980037 ("mm/vmalloc: prevent stale TLBs in fully utili=
zed blocks")
> > > >
> > > > Signed-off-by: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
> > > > ---
> > > >  mm/vmalloc.c | 11 +++++++----
> > > >  1 file changed, 7 insertions(+), 4 deletions(-)
> > > >
> > > > diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> > > > index 22aa63f4ef63..112b50431725 100644
> > > > --- a/mm/vmalloc.c
> > > > +++ b/mm/vmalloc.c
> > > > @@ -2614,9 +2614,10 @@ static void free_vmap_block(struct vmap_bloc=
k *vb)
> > > >  }
> > > >
> > > >  static bool purge_fragmented_block(struct vmap_block *vb,
> > > > -             struct vmap_block_queue *vbq, struct list_head *purge=
_list,
> > > > -             bool force_purge)
> > > > +             struct list_head *purge_list, bool force_purge)
> > > >  {
> > > > +     struct vmap_block_queue *vbq;
> > > > +
> > > >       if (vb->free + vb->dirty !=3D VMAP_BBMAP_BITS ||
> > > >           vb->dirty =3D=3D VMAP_BBMAP_BITS)
> > > >               return false;
> > > > @@ -2625,6 +2626,8 @@ static bool purge_fragmented_block(struct vma=
p_block *vb,
> > > >       if (!(force_purge || vb->free < VMAP_PURGE_THRESHOLD))
> > > >               return false;
> > > >
> > > > +     vbq =3D container_of(addr_to_vb_xa(vb->va->va_start),
> > > > +             struct vmap_block_queue, vmap_blocks);
> > > >       /* prevent further allocs after releasing lock */
> > > >       WRITE_ONCE(vb->free, 0);
> > > >       /* prevent purging it again */
> > > > @@ -2664,7 +2667,7 @@ static void purge_fragmented_blocks(int cpu)
> > > >                       continue;
> > > >
> > > >               spin_lock(&vb->lock);
> > > > -             purge_fragmented_block(vb, vbq, &purge, true);
> > > > +             purge_fragmented_block(vb, &purge, true);
> > > >               spin_unlock(&vb->lock);
> > > >       }
> > > >       rcu_read_unlock();
> > > > @@ -2801,7 +2804,7 @@ static void _vm_unmap_aliases(unsigned long s=
tart, unsigned long end, int flush)
> > > >                        * not purgeable, check whether there is dirt=
y
> > > >                        * space to be flushed.
> > > >                        */
> > > > -                     if (!purge_fragmented_block(vb, vbq, &purge_l=
ist, false) &&
> > > > +                     if (!purge_fragmented_block(vb, &purge_list, =
false) &&
> > > >                           vb->dirty_max && vb->dirty !=3D VMAP_BBMA=
P_BITS) {
> > > >                               unsigned long va_start =3D vb->va->va=
_start;
> > > >                               unsigned long s, e;
> > > > --
> > > > 2.25.1
> > > >
> > > >
> > >
> >
>

