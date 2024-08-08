Return-Path: <linux-kernel+bounces-278733-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 89D7894B424
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 02:23:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D576E1F23B0C
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 00:23:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49D522EB02;
	Thu,  8 Aug 2024 00:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KwwiyE7F"
Received: from mail-vk1-f176.google.com (mail-vk1-f176.google.com [209.85.221.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B1562BB13
	for <linux-kernel@vger.kernel.org>; Thu,  8 Aug 2024 00:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723076500; cv=none; b=cTfGG5fDcd4TDAUactZtxBtZ4zL/g9eR1+hwT75fnEA873qX3DL4m/hWQNvicS9opU9AzUlwjX+0eCp9TknkDUqK3rlBl/hnKhxKcI/rzCrdghEb2IvZQMHVrh2rqOVA0+MWBvy+c0Cyiqi+N+FD9D++FEOHpD8kqFgtaJvgJZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723076500; c=relaxed/simple;
	bh=6tcaXJ3WKPKNhZ0y08j1tUJACkobhyGe0yDb/l92LVw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OoVlDNNLzCk/tPGAe5yem4BVFK2qbQvLZA5BI8S+QpGLXPob12TuzQv4Am3cQTJpzUFnNH673u65+fTHJGWxMsM3DyHLa2fH9rz+AZIGtjk5BPa4MWvZEy89NQ8ZYkVwPkeZlyfVhw95ql+wv64AK1tVbDIWvmf/AN3ILmKNLv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KwwiyE7F; arc=none smtp.client-ip=209.85.221.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f176.google.com with SMTP id 71dfb90a1353d-4f521a22d74so127542e0c.2
        for <linux-kernel@vger.kernel.org>; Wed, 07 Aug 2024 17:21:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723076496; x=1723681296; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HjZhSR4kkTz4c2RQRp+SaKIIi1dxQFU5h4p5ytU92ho=;
        b=KwwiyE7FrZYrRMrTiha8VjbtRgrbpShKXq+gyIEgA9L3mY91ZuQ99mlShXfkc6ML59
         379hDOR/rwRRlPtSM+rmugAh1xbTYbqsqezKPuJyoeFfAZVenTkv9zOcAfl4l/AYninQ
         Q8N5a1qMcXw/n1YzhV9KlGMzG4DXwLSCZjqCOHCYxEcDzdZo5vtcDkCLSR19AMrMcQ5h
         3wzhRrzbCiUGS7UD/3lX+BfYy+A9wObPmW3m7Em/TPqIBlZK932JzzDu+I0zfSWwy0yI
         tWl1Lg9xnHrw2fWI2SSmqttABQYFYDCFtEqhqqhfqDYTj3CL2SfYpTyNNrjtauBwnvj2
         MiqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723076496; x=1723681296;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HjZhSR4kkTz4c2RQRp+SaKIIi1dxQFU5h4p5ytU92ho=;
        b=jROADoDGZKSexrmwNlP0c8bGx3hzGn72d8GqhrGSdKvh0IrCeb+SzYCgGS43aYElmr
         Lmfs55k+W4Ai6OZgYIfY7vc8BiMTm0JebB0CHSCzQedNLxlyIjMKG/wH4K8lI0uKff9O
         LEf8wNDLX9/ol4jAo8HMPskHfXQmA0CpayLATbERl9zIsivqa3JvcLZHmSN4lwsNlltd
         b4XMHGz22XojXnoPetEfFDOQ5zxR/yRafIgyn4xb/LHz7Y2cRtlVAGUSlH6pr5WuaclR
         Zmyq46cr5fsyG8FjuWJetVpjZX59VvSzktZC5kyrpMq9fx0R8RsZ7dUjF0MViWMaueIW
         fFbQ==
X-Forwarded-Encrypted: i=1; AJvYcCVolNU67zQvrhf+CGexaxJNnf9VHgKAzNmEVGnQJ/isAvuIZXnk+acdAgZM+fN6iLstTfebZvkVKBz94hQd76sqxEKpyExQ5S1q9GzS
X-Gm-Message-State: AOJu0Yzb8FjcLmJY/8IbeueTlAhHdLG0WmDrJe+1w+7EujbsaVI74oVo
	QRI0PFfV2zjYowL6sxZmko8qbfI2I5AM1UZkiKNw9Bjy7hh5pN7SudH//k9uDP4VlgrUYk+p3Gt
	voEmFLoABn+1iF5zD5KD+KcWoNj8=
X-Google-Smtp-Source: AGHT+IHIFW0CCiwYSWU3fBmqZHZOyOZE+cxur+QAigSGqLxfM39UFM4fOQNkSjOWn067b+jaB/Cv64a/11Qr9B3kUYo=
X-Received: by 2002:a05:6122:c9b:b0:4f5:1b1f:ee6e with SMTP id
 71dfb90a1353d-4f902973599mr529003e0c.10.1723076495834; Wed, 07 Aug 2024
 17:21:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240807215859.57491-1-21cnbao@gmail.com> <20240807215859.57491-2-21cnbao@gmail.com>
 <CACePvbV5nxGz=gPKZLzZ_nF-Wzxy_4bXFw-t40rsmA0zk=irCg@mail.gmail.com>
In-Reply-To: <CACePvbV5nxGz=gPKZLzZ_nF-Wzxy_4bXFw-t40rsmA0zk=irCg@mail.gmail.com>
From: Barry Song <21cnbao@gmail.com>
Date: Thu, 8 Aug 2024 12:21:24 +1200
Message-ID: <CAGsJ_4z=sCyYU9z-HGN=G3wDkoEFrXPXm9nwPnqJhjvjHjufTw@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] mm: rename instances of swap_info_struct to
 meaningful 'si'
To: Chris Li <chrisl@kernel.org>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org, david@redhat.com, 
	hughd@google.com, justinjiang@vivo.com, kaleshsingh@google.com, 
	kasong@tencent.com, linux-kernel@vger.kernel.org, ryan.roberts@arm.com, 
	v-songbaohua@oppo.com, ying.huang@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 8, 2024 at 12:01=E2=80=AFPM Chris Li <chrisl@kernel.org> wrote:
>
> On Wed, Aug 7, 2024 at 2:59=E2=80=AFPM Barry Song <21cnbao@gmail.com> wro=
te:
> >
> > From: Barry Song <v-songbaohua@oppo.com>
> >
> > "p" means "pointer to something", rename it to a more meaningful
> > identifier - "si".
>
> Hi Berry,
>
> I am fine with the reason for renaming it to something more
> meaningful. On the other hand this will create a huge conflict on the
> next iteration of the swap allocator series. There is not much urgency
> in the renaming variable, right? Just try to figure out a way to
> coordinate it better. As it is, I am not sure how to handle the next
> refresh of swap allocator series, should I revert the rename or submit
> a refresh of patches with rename conflict resolved, effectively foldin
> the rename patch.

right, it is not urgent. if you are going to make another iteration
for the swap allocation series. I am perfect fine that you can add
these two patches into your series? it should be fine as this patchset
obviously depends on Kairui's and Your work.

>
> Chris
>
> > We also have a case with the name "sis", rename it to "si" as
> > well.
> >
> > Signed-off-by: Barry Song <v-songbaohua@oppo.com>
> > Acked-by: David Hildenbrand <david@redhat.com>
> > ---
> >  mm/swapfile.c | 334 +++++++++++++++++++++++++-------------------------
> >  1 file changed, 167 insertions(+), 167 deletions(-)
> >
> > diff --git a/mm/swapfile.c b/mm/swapfile.c
> > index ea023fc25d08..35cb58373493 100644
> > --- a/mm/swapfile.c
> > +++ b/mm/swapfile.c
> > @@ -532,7 +532,7 @@ static void free_cluster(struct swap_info_struct *s=
i, struct swap_cluster_info *
> >   * added to free cluster list and its usage counter will be increased =
by 1.
> >   * Only used for initialization.
> >   */
> > -static void inc_cluster_info_page(struct swap_info_struct *p,
> > +static void inc_cluster_info_page(struct swap_info_struct *si,
> >         struct swap_cluster_info *cluster_info, unsigned long page_nr)
> >  {
> >         unsigned long idx =3D page_nr / SWAPFILE_CLUSTER;
> > @@ -553,28 +553,28 @@ static void inc_cluster_info_page(struct swap_inf=
o_struct *p,
> >   * which means no page in the cluster is in use, we can optionally dis=
card
> >   * the cluster and add it to free cluster list.
> >   */
> > -static void dec_cluster_info_page(struct swap_info_struct *p,
> > +static void dec_cluster_info_page(struct swap_info_struct *si,
> >                                   struct swap_cluster_info *ci, int nr_=
pages)
> >  {
> > -       if (!p->cluster_info)
> > +       if (!si->cluster_info)
> >                 return;
> >
> >         VM_BUG_ON(ci->count < nr_pages);
> >         VM_BUG_ON(cluster_is_free(ci));
> > -       lockdep_assert_held(&p->lock);
> > +       lockdep_assert_held(&si->lock);
> >         lockdep_assert_held(&ci->lock);
> >         ci->count -=3D nr_pages;
> >
> >         if (!ci->count) {
> > -               free_cluster(p, ci);
> > +               free_cluster(si, ci);
> >                 return;
> >         }
> >
> >         if (!(ci->flags & CLUSTER_FLAG_NONFULL)) {
> >                 VM_BUG_ON(ci->flags & CLUSTER_FLAG_FREE);
> >                 if (ci->flags & CLUSTER_FLAG_FRAG)
> > -                       p->frag_cluster_nr[ci->order]--;
> > -               list_move_tail(&ci->list, &p->nonfull_clusters[ci->orde=
r]);
> > +                       si->frag_cluster_nr[ci->order]--;
> > +               list_move_tail(&ci->list, &si->nonfull_clusters[ci->ord=
er]);
> >                 ci->flags =3D CLUSTER_FLAG_NONFULL;
> >         }
> >  }
> > @@ -872,19 +872,19 @@ static unsigned long cluster_alloc_swap_entry(str=
uct swap_info_struct *si, int o
> >         return found;
> >  }
> >
> > -static void __del_from_avail_list(struct swap_info_struct *p)
> > +static void __del_from_avail_list(struct swap_info_struct *si)
> >  {
> >         int nid;
> >
> > -       assert_spin_locked(&p->lock);
> > +       assert_spin_locked(&si->lock);
> >         for_each_node(nid)
> > -               plist_del(&p->avail_lists[nid], &swap_avail_heads[nid])=
;
> > +               plist_del(&si->avail_lists[nid], &swap_avail_heads[nid]=
);
> >  }
> >
> > -static void del_from_avail_list(struct swap_info_struct *p)
> > +static void del_from_avail_list(struct swap_info_struct *si)
> >  {
> >         spin_lock(&swap_avail_lock);
> > -       __del_from_avail_list(p);
> > +       __del_from_avail_list(si);
> >         spin_unlock(&swap_avail_lock);
> >  }
> >
> > @@ -905,13 +905,13 @@ static void swap_range_alloc(struct swap_info_str=
uct *si, unsigned long offset,
> >         }
> >  }
> >
> > -static void add_to_avail_list(struct swap_info_struct *p)
> > +static void add_to_avail_list(struct swap_info_struct *si)
> >  {
> >         int nid;
> >
> >         spin_lock(&swap_avail_lock);
> >         for_each_node(nid)
> > -               plist_add(&p->avail_lists[nid], &swap_avail_heads[nid])=
;
> > +               plist_add(&si->avail_lists[nid], &swap_avail_heads[nid]=
);
> >         spin_unlock(&swap_avail_lock);
> >  }
> >
> > @@ -1291,22 +1291,22 @@ int get_swap_pages(int n_goal, swp_entry_t swp_=
entries[], int entry_order)
> >
> >  static struct swap_info_struct *_swap_info_get(swp_entry_t entry)
> >  {
> > -       struct swap_info_struct *p;
> > +       struct swap_info_struct *si;
> >         unsigned long offset;
> >
> >         if (!entry.val)
> >                 goto out;
> > -       p =3D swp_swap_info(entry);
> > -       if (!p)
> > +       si =3D swp_swap_info(entry);
> > +       if (!si)
> >                 goto bad_nofile;
> > -       if (data_race(!(p->flags & SWP_USED)))
> > +       if (data_race(!(si->flags & SWP_USED)))
> >                 goto bad_device;
> >         offset =3D swp_offset(entry);
> > -       if (offset >=3D p->max)
> > +       if (offset >=3D si->max)
> >                 goto bad_offset;
> > -       if (data_race(!p->swap_map[swp_offset(entry)]))
> > +       if (data_race(!si->swap_map[swp_offset(entry)]))
> >                 goto bad_free;
> > -       return p;
> > +       return si;
> >
> >  bad_free:
> >         pr_err("%s: %s%08lx\n", __func__, Unused_offset, entry.val);
> > @@ -1339,14 +1339,14 @@ static struct swap_info_struct *swap_info_get_c=
ont(swp_entry_t entry,
> >         return p;
> >  }
> >
> > -static unsigned char __swap_entry_free_locked(struct swap_info_struct =
*p,
> > +static unsigned char __swap_entry_free_locked(struct swap_info_struct =
*si,
> >                                               unsigned long offset,
> >                                               unsigned char usage)
> >  {
> >         unsigned char count;
> >         unsigned char has_cache;
> >
> > -       count =3D p->swap_map[offset];
> > +       count =3D si->swap_map[offset];
> >
> >         has_cache =3D count & SWAP_HAS_CACHE;
> >         count &=3D ~SWAP_HAS_CACHE;
> > @@ -1362,7 +1362,7 @@ static unsigned char __swap_entry_free_locked(str=
uct swap_info_struct *p,
> >                 count =3D 0;
> >         } else if ((count & ~COUNT_CONTINUED) <=3D SWAP_MAP_MAX) {
> >                 if (count =3D=3D COUNT_CONTINUED) {
> > -                       if (swap_count_continued(p, offset, count))
> > +                       if (swap_count_continued(si, offset, count))
> >                                 count =3D SWAP_MAP_MAX | COUNT_CONTINUE=
D;
> >                         else
> >                                 count =3D SWAP_MAP_MAX;
> > @@ -1372,9 +1372,9 @@ static unsigned char __swap_entry_free_locked(str=
uct swap_info_struct *p,
> >
> >         usage =3D count | has_cache;
> >         if (usage)
> > -               WRITE_ONCE(p->swap_map[offset], usage);
> > +               WRITE_ONCE(si->swap_map[offset], usage);
> >         else
> > -               WRITE_ONCE(p->swap_map[offset], SWAP_HAS_CACHE);
> > +               WRITE_ONCE(si->swap_map[offset], SWAP_HAS_CACHE);
> >
> >         return usage;
> >  }
> > @@ -1453,16 +1453,16 @@ struct swap_info_struct *get_swap_device(swp_en=
try_t entry)
> >         return NULL;
> >  }
> >
> > -static unsigned char __swap_entry_free(struct swap_info_struct *p,
> > +static unsigned char __swap_entry_free(struct swap_info_struct *si,
> >                                        swp_entry_t entry)
> >  {
> >         struct swap_cluster_info *ci;
> >         unsigned long offset =3D swp_offset(entry);
> >         unsigned char usage;
> >
> > -       ci =3D lock_cluster_or_swap_info(p, offset);
> > -       usage =3D __swap_entry_free_locked(p, offset, 1);
> > -       unlock_cluster_or_swap_info(p, ci);
> > +       ci =3D lock_cluster_or_swap_info(si, offset);
> > +       usage =3D __swap_entry_free_locked(si, offset, 1);
> > +       unlock_cluster_or_swap_info(si, ci);
> >         if (!usage)
> >                 free_swap_slot(entry);
> >
> > @@ -1473,27 +1473,27 @@ static unsigned char __swap_entry_free(struct s=
wap_info_struct *p,
> >   * Drop the last HAS_CACHE flag of swap entries, caller have to
> >   * ensure all entries belong to the same cgroup.
> >   */
> > -static void swap_entry_range_free(struct swap_info_struct *p, swp_entr=
y_t entry,
> > +static void swap_entry_range_free(struct swap_info_struct *si, swp_ent=
ry_t entry,
> >                                   unsigned int nr_pages)
> >  {
> >         unsigned long offset =3D swp_offset(entry);
> > -       unsigned char *map =3D p->swap_map + offset;
> > +       unsigned char *map =3D si->swap_map + offset;
> >         unsigned char *map_end =3D map + nr_pages;
> >         struct swap_cluster_info *ci;
> >
> > -       ci =3D lock_cluster(p, offset);
> > +       ci =3D lock_cluster(si, offset);
> >         do {
> >                 VM_BUG_ON(*map !=3D SWAP_HAS_CACHE);
> >                 *map =3D 0;
> >         } while (++map < map_end);
> > -       dec_cluster_info_page(p, ci, nr_pages);
> > +       dec_cluster_info_page(si, ci, nr_pages);
> >         unlock_cluster(ci);
> >
> >         mem_cgroup_uncharge_swap(entry, nr_pages);
> > -       swap_range_free(p, offset, nr_pages);
> > +       swap_range_free(si, offset, nr_pages);
> >  }
> >
> > -static void cluster_swap_free_nr(struct swap_info_struct *sis,
> > +static void cluster_swap_free_nr(struct swap_info_struct *si,
> >                 unsigned long offset, int nr_pages,
> >                 unsigned char usage)
> >  {
> > @@ -1501,26 +1501,26 @@ static void cluster_swap_free_nr(struct swap_in=
fo_struct *sis,
> >         DECLARE_BITMAP(to_free, BITS_PER_LONG) =3D { 0 };
> >         int i, nr;
> >
> > -       ci =3D lock_cluster_or_swap_info(sis, offset);
> > +       ci =3D lock_cluster_or_swap_info(si, offset);
> >         while (nr_pages) {
> >                 nr =3D min(BITS_PER_LONG, nr_pages);
> >                 for (i =3D 0; i < nr; i++) {
> > -                       if (!__swap_entry_free_locked(sis, offset + i, =
usage))
> > +                       if (!__swap_entry_free_locked(si, offset + i, u=
sage))
> >                                 bitmap_set(to_free, i, 1);
> >                 }
> >                 if (!bitmap_empty(to_free, BITS_PER_LONG)) {
> > -                       unlock_cluster_or_swap_info(sis, ci);
> > +                       unlock_cluster_or_swap_info(si, ci);
> >                         for_each_set_bit(i, to_free, BITS_PER_LONG)
> > -                               free_swap_slot(swp_entry(sis->type, off=
set + i));
> > +                               free_swap_slot(swp_entry(si->type, offs=
et + i));
> >                         if (nr =3D=3D nr_pages)
> >                                 return;
> >                         bitmap_clear(to_free, 0, BITS_PER_LONG);
> > -                       ci =3D lock_cluster_or_swap_info(sis, offset);
> > +                       ci =3D lock_cluster_or_swap_info(si, offset);
> >                 }
> >                 offset +=3D nr;
> >                 nr_pages -=3D nr;
> >         }
> > -       unlock_cluster_or_swap_info(sis, ci);
> > +       unlock_cluster_or_swap_info(si, ci);
> >  }
> >
> >  /*
> > @@ -1646,28 +1646,28 @@ int swap_swapcount(struct swap_info_struct *si,=
 swp_entry_t entry)
> >  int swp_swapcount(swp_entry_t entry)
> >  {
> >         int count, tmp_count, n;
> > -       struct swap_info_struct *p;
> > +       struct swap_info_struct *si;
> >         struct swap_cluster_info *ci;
> >         struct page *page;
> >         pgoff_t offset;
> >         unsigned char *map;
> >
> > -       p =3D _swap_info_get(entry);
> > -       if (!p)
> > +       si =3D _swap_info_get(entry);
> > +       if (!si)
> >                 return 0;
> >
> >         offset =3D swp_offset(entry);
> >
> > -       ci =3D lock_cluster_or_swap_info(p, offset);
> > +       ci =3D lock_cluster_or_swap_info(si, offset);
> >
> > -       count =3D swap_count(p->swap_map[offset]);
> > +       count =3D swap_count(si->swap_map[offset]);
> >         if (!(count & COUNT_CONTINUED))
> >                 goto out;
> >
> >         count &=3D ~COUNT_CONTINUED;
> >         n =3D SWAP_MAP_MAX + 1;
> >
> > -       page =3D vmalloc_to_page(p->swap_map + offset);
> > +       page =3D vmalloc_to_page(si->swap_map + offset);
> >         offset &=3D ~PAGE_MASK;
> >         VM_BUG_ON(page_private(page) !=3D SWP_CONTINUED);
> >
> > @@ -1681,7 +1681,7 @@ int swp_swapcount(swp_entry_t entry)
> >                 n *=3D (SWAP_CONT_MAX + 1);
> >         } while (tmp_count & COUNT_CONTINUED);
> >  out:
> > -       unlock_cluster_or_swap_info(p, ci);
> > +       unlock_cluster_or_swap_info(si, ci);
> >         return count;
> >  }
> >
> > @@ -2542,52 +2542,52 @@ static int setup_swap_extents(struct swap_info_=
struct *sis, sector_t *span)
> >         return generic_swapfile_activate(sis, swap_file, span);
> >  }
> >
> > -static int swap_node(struct swap_info_struct *p)
> > +static int swap_node(struct swap_info_struct *si)
> >  {
> >         struct block_device *bdev;
> >
> > -       if (p->bdev)
> > -               bdev =3D p->bdev;
> > +       if (si->bdev)
> > +               bdev =3D si->bdev;
> >         else
> > -               bdev =3D p->swap_file->f_inode->i_sb->s_bdev;
> > +               bdev =3D si->swap_file->f_inode->i_sb->s_bdev;
> >
> >         return bdev ? bdev->bd_disk->node_id : NUMA_NO_NODE;
> >  }
> >
> > -static void setup_swap_info(struct swap_info_struct *p, int prio,
> > +static void setup_swap_info(struct swap_info_struct *si, int prio,
> >                             unsigned char *swap_map,
> >                             struct swap_cluster_info *cluster_info)
> >  {
> >         int i;
> >
> >         if (prio >=3D 0)
> > -               p->prio =3D prio;
> > +               si->prio =3D prio;
> >         else
> > -               p->prio =3D --least_priority;
> > +               si->prio =3D --least_priority;
> >         /*
> >          * the plist prio is negated because plist ordering is
> >          * low-to-high, while swap ordering is high-to-low
> >          */
> > -       p->list.prio =3D -p->prio;
> > +       si->list.prio =3D -si->prio;
> >         for_each_node(i) {
> > -               if (p->prio >=3D 0)
> > -                       p->avail_lists[i].prio =3D -p->prio;
> > +               if (si->prio >=3D 0)
> > +                       si->avail_lists[i].prio =3D -si->prio;
> >                 else {
> > -                       if (swap_node(p) =3D=3D i)
> > -                               p->avail_lists[i].prio =3D 1;
> > +                       if (swap_node(si) =3D=3D i)
> > +                               si->avail_lists[i].prio =3D 1;
> >                         else
> > -                               p->avail_lists[i].prio =3D -p->prio;
> > +                               si->avail_lists[i].prio =3D -si->prio;
> >                 }
> >         }
> > -       p->swap_map =3D swap_map;
> > -       p->cluster_info =3D cluster_info;
> > +       si->swap_map =3D swap_map;
> > +       si->cluster_info =3D cluster_info;
> >  }
> >
> > -static void _enable_swap_info(struct swap_info_struct *p)
> > +static void _enable_swap_info(struct swap_info_struct *si)
> >  {
> > -       p->flags |=3D SWP_WRITEOK;
> > -       atomic_long_add(p->pages, &nr_swap_pages);
> > -       total_swap_pages +=3D p->pages;
> > +       si->flags |=3D SWP_WRITEOK;
> > +       atomic_long_add(si->pages, &nr_swap_pages);
> > +       total_swap_pages +=3D si->pages;
> >
> >         assert_spin_locked(&swap_lock);
> >         /*
> > @@ -2600,40 +2600,40 @@ static void _enable_swap_info(struct swap_info_=
struct *p)
> >          * which allocates swap pages from the highest available priori=
ty
> >          * swap_info_struct.
> >          */
> > -       plist_add(&p->list, &swap_active_head);
> > +       plist_add(&si->list, &swap_active_head);
> >
> >         /* add to available list iff swap device is not full */
> > -       if (p->highest_bit)
> > -               add_to_avail_list(p);
> > +       if (si->highest_bit)
> > +               add_to_avail_list(si);
> >  }
> >
> > -static void enable_swap_info(struct swap_info_struct *p, int prio,
> > +static void enable_swap_info(struct swap_info_struct *si, int prio,
> >                                 unsigned char *swap_map,
> >                                 struct swap_cluster_info *cluster_info)
> >  {
> >         spin_lock(&swap_lock);
> > -       spin_lock(&p->lock);
> > -       setup_swap_info(p, prio, swap_map, cluster_info);
> > -       spin_unlock(&p->lock);
> > +       spin_lock(&si->lock);
> > +       setup_swap_info(si, prio, swap_map, cluster_info);
> > +       spin_unlock(&si->lock);
> >         spin_unlock(&swap_lock);
> >         /*
> >          * Finished initializing swap device, now it's safe to referenc=
e it.
> >          */
> > -       percpu_ref_resurrect(&p->users);
> > +       percpu_ref_resurrect(&si->users);
> >         spin_lock(&swap_lock);
> > -       spin_lock(&p->lock);
> > -       _enable_swap_info(p);
> > -       spin_unlock(&p->lock);
> > +       spin_lock(&si->lock);
> > +       _enable_swap_info(si);
> > +       spin_unlock(&si->lock);
> >         spin_unlock(&swap_lock);
> >  }
> >
> > -static void reinsert_swap_info(struct swap_info_struct *p)
> > +static void reinsert_swap_info(struct swap_info_struct *si)
> >  {
> >         spin_lock(&swap_lock);
> > -       spin_lock(&p->lock);
> > -       setup_swap_info(p, p->prio, p->swap_map, p->cluster_info);
> > -       _enable_swap_info(p);
> > -       spin_unlock(&p->lock);
> > +       spin_lock(&si->lock);
> > +       setup_swap_info(si, si->prio, si->swap_map, si->cluster_info);
> > +       _enable_swap_info(si);
> > +       spin_unlock(&si->lock);
> >         spin_unlock(&swap_lock);
> >  }
> >
> > @@ -3019,20 +3019,20 @@ static struct swap_info_struct *alloc_swap_info=
(void)
> >         return p;
> >  }
> >
> > -static int claim_swapfile(struct swap_info_struct *p, struct inode *in=
ode)
> > +static int claim_swapfile(struct swap_info_struct *si, struct inode *i=
node)
> >  {
> >         if (S_ISBLK(inode->i_mode)) {
> > -               p->bdev =3D I_BDEV(inode);
> > +               si->bdev =3D I_BDEV(inode);
> >                 /*
> >                  * Zoned block devices contain zones that have a sequen=
tial
> >                  * write only restriction.  Hence zoned block devices a=
re not
> >                  * suitable for swapping.  Disallow them here.
> >                  */
> > -               if (bdev_is_zoned(p->bdev))
> > +               if (bdev_is_zoned(si->bdev))
> >                         return -EINVAL;
> > -               p->flags |=3D SWP_BLKDEV;
> > +               si->flags |=3D SWP_BLKDEV;
> >         } else if (S_ISREG(inode->i_mode)) {
> > -               p->bdev =3D inode->i_sb->s_bdev;
> > +               si->bdev =3D inode->i_sb->s_bdev;
> >         }
> >
> >         return 0;
> > @@ -3067,7 +3067,7 @@ __weak unsigned long arch_max_swapfile_size(void)
> >         return generic_max_swapfile_size();
> >  }
> >
> > -static unsigned long read_swap_header(struct swap_info_struct *p,
> > +static unsigned long read_swap_header(struct swap_info_struct *si,
> >                                         union swap_header *swap_header,
> >                                         struct inode *inode)
> >  {
> > @@ -3098,9 +3098,9 @@ static unsigned long read_swap_header(struct swap=
_info_struct *p,
> >                 return 0;
> >         }
> >
> > -       p->lowest_bit  =3D 1;
> > -       p->cluster_next =3D 1;
> > -       p->cluster_nr =3D 0;
> > +       si->lowest_bit  =3D 1;
> > +       si->cluster_next =3D 1;
> > +       si->cluster_nr =3D 0;
> >
> >         maxpages =3D swapfile_maximum_size;
> >         last_page =3D swap_header->info.last_page;
> > @@ -3118,7 +3118,7 @@ static unsigned long read_swap_header(struct swap=
_info_struct *p,
> >                 if ((unsigned int)maxpages =3D=3D 0)
> >                         maxpages =3D UINT_MAX;
> >         }
> > -       p->highest_bit =3D maxpages - 1;
> > +       si->highest_bit =3D maxpages - 1;
> >
> >         if (!maxpages)
> >                 return 0;
> > @@ -3142,7 +3142,7 @@ static unsigned long read_swap_header(struct swap=
_info_struct *p,
> >  #define SWAP_CLUSTER_COLS                                             =
 \
> >         max_t(unsigned int, SWAP_CLUSTER_INFO_COLS, SWAP_CLUSTER_SPACE_=
COLS)
> >
> > -static int setup_swap_map_and_extents(struct swap_info_struct *p,
> > +static int setup_swap_map_and_extents(struct swap_info_struct *si,
> >                                         union swap_header *swap_header,
> >                                         unsigned char *swap_map,
> >                                         struct swap_cluster_info *clust=
er_info,
> > @@ -3153,19 +3153,19 @@ static int setup_swap_map_and_extents(struct sw=
ap_info_struct *p,
> >         unsigned int nr_good_pages;
> >         int nr_extents;
> >         unsigned long nr_clusters =3D DIV_ROUND_UP(maxpages, SWAPFILE_C=
LUSTER);
> > -       unsigned long col =3D p->cluster_next / SWAPFILE_CLUSTER % SWAP=
_CLUSTER_COLS;
> > +       unsigned long col =3D si->cluster_next / SWAPFILE_CLUSTER % SWA=
P_CLUSTER_COLS;
> >         unsigned long i, idx;
> >
> >         nr_good_pages =3D maxpages - 1;   /* omit header page */
> >
> > -       INIT_LIST_HEAD(&p->free_clusters);
> > -       INIT_LIST_HEAD(&p->full_clusters);
> > -       INIT_LIST_HEAD(&p->discard_clusters);
> > +       INIT_LIST_HEAD(&si->free_clusters);
> > +       INIT_LIST_HEAD(&si->full_clusters);
> > +       INIT_LIST_HEAD(&si->discard_clusters);
> >
> >         for (i =3D 0; i < SWAP_NR_ORDERS; i++) {
> > -               INIT_LIST_HEAD(&p->nonfull_clusters[i]);
> > -               INIT_LIST_HEAD(&p->frag_clusters[i]);
> > -               p->frag_cluster_nr[i] =3D 0;
> > +               INIT_LIST_HEAD(&si->nonfull_clusters[i]);
> > +               INIT_LIST_HEAD(&si->frag_clusters[i]);
> > +               si->frag_cluster_nr[i] =3D 0;
> >         }
> >
> >         for (i =3D 0; i < swap_header->info.nr_badpages; i++) {
> > @@ -3179,13 +3179,13 @@ static int setup_swap_map_and_extents(struct sw=
ap_info_struct *p,
> >                          * Haven't marked the cluster free yet, no list
> >                          * operation involved
> >                          */
> > -                       inc_cluster_info_page(p, cluster_info, page_nr)=
;
> > +                       inc_cluster_info_page(si, cluster_info, page_nr=
);
> >                 }
> >         }
> >
> >         /* Haven't marked the cluster free yet, no list operation invol=
ved */
> >         for (i =3D maxpages; i < round_up(maxpages, SWAPFILE_CLUSTER); =
i++)
> > -               inc_cluster_info_page(p, cluster_info, i);
> > +               inc_cluster_info_page(si, cluster_info, i);
> >
> >         if (nr_good_pages) {
> >                 swap_map[0] =3D SWAP_MAP_BAD;
> > @@ -3193,13 +3193,13 @@ static int setup_swap_map_and_extents(struct sw=
ap_info_struct *p,
> >                  * Not mark the cluster free yet, no list
> >                  * operation involved
> >                  */
> > -               inc_cluster_info_page(p, cluster_info, 0);
> > -               p->max =3D maxpages;
> > -               p->pages =3D nr_good_pages;
> > -               nr_extents =3D setup_swap_extents(p, span);
> > +               inc_cluster_info_page(si, cluster_info, 0);
> > +               si->max =3D maxpages;
> > +               si->pages =3D nr_good_pages;
> > +               nr_extents =3D setup_swap_extents(si, span);
> >                 if (nr_extents < 0)
> >                         return nr_extents;
> > -               nr_good_pages =3D p->pages;
> > +               nr_good_pages =3D si->pages;
> >         }
> >         if (!nr_good_pages) {
> >                 pr_warn("Empty swap-file\n");
> > @@ -3223,11 +3223,11 @@ static int setup_swap_map_and_extents(struct sw=
ap_info_struct *p,
> >                                 continue;
> >                         if (ci->count) {
> >                                 ci->flags =3D CLUSTER_FLAG_NONFULL;
> > -                               list_add_tail(&ci->list, &p->nonfull_cl=
usters[0]);
> > +                               list_add_tail(&ci->list, &si->nonfull_c=
lusters[0]);
> >                                 continue;
> >                         }
> >                         ci->flags =3D CLUSTER_FLAG_FREE;
> > -                       list_add_tail(&ci->list, &p->free_clusters);
> > +                       list_add_tail(&ci->list, &si->free_clusters);
> >                 }
> >         }
> >         return nr_extents;
> > @@ -3235,7 +3235,7 @@ static int setup_swap_map_and_extents(struct swap=
_info_struct *p,
> >
> >  SYSCALL_DEFINE2(swapon, const char __user *, specialfile, int, swap_fl=
ags)
> >  {
> > -       struct swap_info_struct *p;
> > +       struct swap_info_struct *si;
> >         struct filename *name;
> >         struct file *swap_file =3D NULL;
> >         struct address_space *mapping;
> > @@ -3261,11 +3261,11 @@ SYSCALL_DEFINE2(swapon, const char __user *, sp=
ecialfile, int, swap_flags)
> >         if (!swap_avail_heads)
> >                 return -ENOMEM;
> >
> > -       p =3D alloc_swap_info();
> > -       if (IS_ERR(p))
> > -               return PTR_ERR(p);
> > +       si =3D alloc_swap_info();
> > +       if (IS_ERR(si))
> > +               return PTR_ERR(si);
> >
> > -       INIT_WORK(&p->discard_work, swap_discard_work);
> > +       INIT_WORK(&si->discard_work, swap_discard_work);
> >
> >         name =3D getname(specialfile);
> >         if (IS_ERR(name)) {
> > @@ -3280,12 +3280,12 @@ SYSCALL_DEFINE2(swapon, const char __user *, sp=
ecialfile, int, swap_flags)
> >                 goto bad_swap;
> >         }
> >
> > -       p->swap_file =3D swap_file;
> > +       si->swap_file =3D swap_file;
> >         mapping =3D swap_file->f_mapping;
> >         dentry =3D swap_file->f_path.dentry;
> >         inode =3D mapping->host;
> >
> > -       error =3D claim_swapfile(p, inode);
> > +       error =3D claim_swapfile(si, inode);
> >         if (unlikely(error))
> >                 goto bad_swap;
> >
> > @@ -3313,7 +3313,7 @@ SYSCALL_DEFINE2(swapon, const char __user *, spec=
ialfile, int, swap_flags)
> >         }
> >         swap_header =3D kmap(page);
> >
> > -       maxpages =3D read_swap_header(p, swap_header, inode);
> > +       maxpages =3D read_swap_header(si, swap_header, inode);
> >         if (unlikely(!maxpages)) {
> >                 error =3D -EINVAL;
> >                 goto bad_swap_unlock_inode;
> > @@ -3326,19 +3326,19 @@ SYSCALL_DEFINE2(swapon, const char __user *, sp=
ecialfile, int, swap_flags)
> >                 goto bad_swap_unlock_inode;
> >         }
> >
> > -       if (p->bdev && bdev_stable_writes(p->bdev))
> > -               p->flags |=3D SWP_STABLE_WRITES;
> > +       if (si->bdev && bdev_stable_writes(si->bdev))
> > +               si->flags |=3D SWP_STABLE_WRITES;
> >
> > -       if (p->bdev && bdev_synchronous(p->bdev))
> > -               p->flags |=3D SWP_SYNCHRONOUS_IO;
> > +       if (si->bdev && bdev_synchronous(si->bdev))
> > +               si->flags |=3D SWP_SYNCHRONOUS_IO;
> >
> > -       if (p->bdev && bdev_nonrot(p->bdev)) {
> > +       if (si->bdev && bdev_nonrot(si->bdev)) {
> >                 int cpu, i;
> >                 unsigned long ci, nr_cluster;
> >
> > -               p->flags |=3D SWP_SOLIDSTATE;
> > -               p->cluster_next_cpu =3D alloc_percpu(unsigned int);
> > -               if (!p->cluster_next_cpu) {
> > +               si->flags |=3D SWP_SOLIDSTATE;
> > +               si->cluster_next_cpu =3D alloc_percpu(unsigned int);
> > +               if (!si->cluster_next_cpu) {
> >                         error =3D -ENOMEM;
> >                         goto bad_swap_unlock_inode;
> >                 }
> > @@ -3347,8 +3347,8 @@ SYSCALL_DEFINE2(swapon, const char __user *, spec=
ialfile, int, swap_flags)
> >                  * SSD
> >                  */
> >                 for_each_possible_cpu(cpu) {
> > -                       per_cpu(*p->cluster_next_cpu, cpu) =3D
> > -                               get_random_u32_inclusive(1, p->highest_=
bit);
> > +                       per_cpu(*si->cluster_next_cpu, cpu) =3D
> > +                               get_random_u32_inclusive(1, si->highest=
_bit);
> >                 }
> >                 nr_cluster =3D DIV_ROUND_UP(maxpages, SWAPFILE_CLUSTER)=
;
> >
> > @@ -3362,15 +3362,15 @@ SYSCALL_DEFINE2(swapon, const char __user *, sp=
ecialfile, int, swap_flags)
> >                 for (ci =3D 0; ci < nr_cluster; ci++)
> >                         spin_lock_init(&((cluster_info + ci)->lock));
> >
> > -               p->percpu_cluster =3D alloc_percpu(struct percpu_cluste=
r);
> > -               if (!p->percpu_cluster) {
> > +               si->percpu_cluster =3D alloc_percpu(struct percpu_clust=
er);
> > +               if (!si->percpu_cluster) {
> >                         error =3D -ENOMEM;
> >                         goto bad_swap_unlock_inode;
> >                 }
> >                 for_each_possible_cpu(cpu) {
> >                         struct percpu_cluster *cluster;
> >
> > -                       cluster =3D per_cpu_ptr(p->percpu_cluster, cpu)=
;
> > +                       cluster =3D per_cpu_ptr(si->percpu_cluster, cpu=
);
> >                         for (i =3D 0; i < SWAP_NR_ORDERS; i++)
> >                                 cluster->next[i] =3D SWAP_NEXT_INVALID;
> >                 }
> > @@ -3379,11 +3379,11 @@ SYSCALL_DEFINE2(swapon, const char __user *, sp=
ecialfile, int, swap_flags)
> >                 inced_nr_rotate_swap =3D true;
> >         }
> >
> > -       error =3D swap_cgroup_swapon(p->type, maxpages);
> > +       error =3D swap_cgroup_swapon(si->type, maxpages);
> >         if (error)
> >                 goto bad_swap_unlock_inode;
> >
> > -       nr_extents =3D setup_swap_map_and_extents(p, swap_header, swap_=
map,
> > +       nr_extents =3D setup_swap_map_and_extents(si, swap_header, swap=
_map,
> >                 cluster_info, maxpages, &span);
> >         if (unlikely(nr_extents < 0)) {
> >                 error =3D nr_extents;
> > @@ -3391,14 +3391,14 @@ SYSCALL_DEFINE2(swapon, const char __user *, sp=
ecialfile, int, swap_flags)
> >         }
> >
> >         if ((swap_flags & SWAP_FLAG_DISCARD) &&
> > -           p->bdev && bdev_max_discard_sectors(p->bdev)) {
> > +           si->bdev && bdev_max_discard_sectors(si->bdev)) {
> >                 /*
> >                  * When discard is enabled for swap with no particular
> >                  * policy flagged, we set all swap discard flags here i=
n
> >                  * order to sustain backward compatibility with older
> >                  * swapon(8) releases.
> >                  */
> > -               p->flags |=3D (SWP_DISCARDABLE | SWP_AREA_DISCARD |
> > +               si->flags |=3D (SWP_DISCARDABLE | SWP_AREA_DISCARD |
> >                              SWP_PAGE_DISCARD);
> >
> >                 /*
> > @@ -3408,24 +3408,24 @@ SYSCALL_DEFINE2(swapon, const char __user *, sp=
ecialfile, int, swap_flags)
> >                  * Now it's time to adjust the p->flags accordingly.
> >                  */
> >                 if (swap_flags & SWAP_FLAG_DISCARD_ONCE)
> > -                       p->flags &=3D ~SWP_PAGE_DISCARD;
> > +                       si->flags &=3D ~SWP_PAGE_DISCARD;
> >                 else if (swap_flags & SWAP_FLAG_DISCARD_PAGES)
> > -                       p->flags &=3D ~SWP_AREA_DISCARD;
> > +                       si->flags &=3D ~SWP_AREA_DISCARD;
> >
> >                 /* issue a swapon-time discard if it's still required *=
/
> > -               if (p->flags & SWP_AREA_DISCARD) {
> > -                       int err =3D discard_swap(p);
> > +               if (si->flags & SWP_AREA_DISCARD) {
> > +                       int err =3D discard_swap(si);
> >                         if (unlikely(err))
> >                                 pr_err("swapon: discard_swap(%p): %d\n"=
,
> > -                                       p, err);
> > +                                       si, err);
> >                 }
> >         }
> >
> > -       error =3D init_swap_address_space(p->type, maxpages);
> > +       error =3D init_swap_address_space(si->type, maxpages);
> >         if (error)
> >                 goto bad_swap_unlock_inode;
> >
> > -       error =3D zswap_swapon(p->type, maxpages);
> > +       error =3D zswap_swapon(si->type, maxpages);
> >         if (error)
> >                 goto free_swap_address_space;
> >
> > @@ -3445,15 +3445,15 @@ SYSCALL_DEFINE2(swapon, const char __user *, sp=
ecialfile, int, swap_flags)
> >         if (swap_flags & SWAP_FLAG_PREFER)
> >                 prio =3D
> >                   (swap_flags & SWAP_FLAG_PRIO_MASK) >> SWAP_FLAG_PRIO_=
SHIFT;
> > -       enable_swap_info(p, prio, swap_map, cluster_info);
> > +       enable_swap_info(si, prio, swap_map, cluster_info);
> >
> >         pr_info("Adding %uk swap on %s.  Priority:%d extents:%d across:=
%lluk %s%s%s%s\n",
> > -               K(p->pages), name->name, p->prio, nr_extents,
> > +               K(si->pages), name->name, si->prio, nr_extents,
> >                 K((unsigned long long)span),
> > -               (p->flags & SWP_SOLIDSTATE) ? "SS" : "",
> > -               (p->flags & SWP_DISCARDABLE) ? "D" : "",
> > -               (p->flags & SWP_AREA_DISCARD) ? "s" : "",
> > -               (p->flags & SWP_PAGE_DISCARD) ? "c" : "");
> > +               (si->flags & SWP_SOLIDSTATE) ? "SS" : "",
> > +               (si->flags & SWP_DISCARDABLE) ? "D" : "",
> > +               (si->flags & SWP_AREA_DISCARD) ? "s" : "",
> > +               (si->flags & SWP_PAGE_DISCARD) ? "c" : "");
> >
> >         mutex_unlock(&swapon_mutex);
> >         atomic_inc(&proc_poll_event);
> > @@ -3462,22 +3462,22 @@ SYSCALL_DEFINE2(swapon, const char __user *, sp=
ecialfile, int, swap_flags)
> >         error =3D 0;
> >         goto out;
> >  free_swap_zswap:
> > -       zswap_swapoff(p->type);
> > +       zswap_swapoff(si->type);
> >  free_swap_address_space:
> > -       exit_swap_address_space(p->type);
> > +       exit_swap_address_space(si->type);
> >  bad_swap_unlock_inode:
> >         inode_unlock(inode);
> >  bad_swap:
> > -       free_percpu(p->percpu_cluster);
> > -       p->percpu_cluster =3D NULL;
> > -       free_percpu(p->cluster_next_cpu);
> > -       p->cluster_next_cpu =3D NULL;
> > +       free_percpu(si->percpu_cluster);
> > +       si->percpu_cluster =3D NULL;
> > +       free_percpu(si->cluster_next_cpu);
> > +       si->cluster_next_cpu =3D NULL;
> >         inode =3D NULL;
> > -       destroy_swap_extents(p);
> > -       swap_cgroup_swapoff(p->type);
> > +       destroy_swap_extents(si);
> > +       swap_cgroup_swapoff(si->type);
> >         spin_lock(&swap_lock);
> > -       p->swap_file =3D NULL;
> > -       p->flags =3D 0;
> > +       si->swap_file =3D NULL;
> > +       si->flags =3D 0;
> >         spin_unlock(&swap_lock);
> >         vfree(swap_map);
> >         kvfree(cluster_info);
> > @@ -3529,23 +3529,23 @@ void si_swapinfo(struct sysinfo *val)
> >   */
> >  static int __swap_duplicate(swp_entry_t entry, unsigned char usage, in=
t nr)
> >  {
> > -       struct swap_info_struct *p;
> > +       struct swap_info_struct *si;
> >         struct swap_cluster_info *ci;
> >         unsigned long offset;
> >         unsigned char count;
> >         unsigned char has_cache;
> >         int err, i;
> >
> > -       p =3D swp_swap_info(entry);
> > +       si =3D swp_swap_info(entry);
> >
> >         offset =3D swp_offset(entry);
> >         VM_WARN_ON(nr > SWAPFILE_CLUSTER - offset % SWAPFILE_CLUSTER);
> >         VM_WARN_ON(usage =3D=3D 1 && nr > 1);
> > -       ci =3D lock_cluster_or_swap_info(p, offset);
> > +       ci =3D lock_cluster_or_swap_info(si, offset);
> >
> >         err =3D 0;
> >         for (i =3D 0; i < nr; i++) {
> > -               count =3D p->swap_map[offset + i];
> > +               count =3D si->swap_map[offset + i];
> >
> >                 /*
> >                  * swapin_readahead() doesn't check if a swap entry is =
valid, so the
> > @@ -3573,7 +3573,7 @@ static int __swap_duplicate(swp_entry_t entry, un=
signed char usage, int nr)
> >         }
> >
> >         for (i =3D 0; i < nr; i++) {
> > -               count =3D p->swap_map[offset + i];
> > +               count =3D si->swap_map[offset + i];
> >                 has_cache =3D count & SWAP_HAS_CACHE;
> >                 count &=3D ~SWAP_HAS_CACHE;
> >
> > @@ -3581,7 +3581,7 @@ static int __swap_duplicate(swp_entry_t entry, un=
signed char usage, int nr)
> >                         has_cache =3D SWAP_HAS_CACHE;
> >                 else if ((count & ~COUNT_CONTINUED) < SWAP_MAP_MAX)
> >                         count +=3D usage;
> > -               else if (swap_count_continued(p, offset + i, count))
> > +               else if (swap_count_continued(si, offset + i, count))
> >                         count =3D COUNT_CONTINUED;
> >                 else {
> >                         /*
> > @@ -3592,11 +3592,11 @@ static int __swap_duplicate(swp_entry_t entry, =
unsigned char usage, int nr)
> >                         goto unlock_out;
> >                 }
> >
> > -               WRITE_ONCE(p->swap_map[offset + i], count | has_cache);
> > +               WRITE_ONCE(si->swap_map[offset + i], count | has_cache)=
;
> >         }
> >
> >  unlock_out:
> > -       unlock_cluster_or_swap_info(p, ci);
> > +       unlock_cluster_or_swap_info(si, ci);
> >         return err;
> >  }
> >
> > --
> > 2.34.1
> >

Thanks
Barry

