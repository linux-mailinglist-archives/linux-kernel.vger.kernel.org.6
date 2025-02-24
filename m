Return-Path: <linux-kernel+bounces-528127-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D59A9A413EB
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 04:17:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 271483A2C42
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 03:17:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 695C53FB31;
	Mon, 24 Feb 2025 03:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sbn2OSDY"
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8E3E8F5E
	for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 03:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740367024; cv=none; b=fsf/lXOS2g0v4Iuzxw/aAXelax5yKq6VALe78dAOAHEhpXEM+Ad0nHI0erucuknmU3R/RXy7ox4uvMeKetcFlHjmBq577EvyIpXzA8u2lGfwGgzRyzjRpOn4RoWaRA9RX2QKsQKOEwF3pE4Hwy5esCInq/LZ88MpwHZHlcQg2fA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740367024; c=relaxed/simple;
	bh=0eWBcYJBYQSFJOKdTjvEc/QNVXXp/Hkb1g911520OD0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dEMIk1+7g7sNYyu4rS4G38XL3atDKJClGq/beQZmTM1pkQTXPvk6bXBWgJS8IxHYRKy/70AvfdFdVnPytbvGInWHHPQbh4KOV/iaLEnbTnmiESWJfZI0Efqxl30v6JROjMHV4oc3LYSTkenuI7IJl3aeq49v8jpUwKxDYK8uCE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Sbn2OSDY; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-30a2f240156so39089151fa.3
        for <linux-kernel@vger.kernel.org>; Sun, 23 Feb 2025 19:17:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740367021; x=1740971821; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iWpih9SqXJ8FOq6IOVCaslCnD6suo7a9+gpry+7qR9I=;
        b=Sbn2OSDYfbm1U/hiT9R3WUJHWz7SjdboTKTGv+hwrJgfmdSnLIWuycKSGJ8SfRk0ZN
         qYVd8MpMHSRI7Z3ORwhj+eKAu1YRuXkDT1xZD6nAJp/LbOUuDwMdmncqh2qADYmbwHLF
         TU1/NGnI+gcnTV7bpSw9fwj0mJ2JclqIt9TLWoTA+RCj4J9ZXR22cyVGLTjWLvjAcQZ2
         iTtdgJdAzhIgKbklaPkeszmGt7X1sG7sqww40I16Df5tHm3xQTrNxn31KTwtZ3m1NA0h
         0l3D7CFKkgNC3UIlKBgeBPwTKbpWAJm9FSA9PlJ9/xbpe0NMwROZBCzFdWuMnJ5T2FVn
         UkNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740367021; x=1740971821;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iWpih9SqXJ8FOq6IOVCaslCnD6suo7a9+gpry+7qR9I=;
        b=EabJQREHmXsYWbF7HCoMUEvgXdogFAl2MxBfc1sCWieLGuWZKHxDJ9+ycbY3Irm6sy
         OCzlVWJZ/bmPZFAsXQ/m3EDl2/d++5eD9xnNqPFzg2Eq+fvd8b9rwzJHxbB0FHUVjXZ9
         7JyC3R0BCZY0ZnI6BUn+UCwIY4lfbQoJRm9fBkwh+3c/bUvcsmO4WdFB8a4cjKykAqYs
         7KL7jv/wjZNOpZxfXbT5S1ItOhVn8Us74HpmA9VPcx9MQXUJO/Gc7b2dIjSuY1xsz30o
         vtJI5VIeM9SadQZ4NGbLX13GVD37W0bCnrjDyquWrvZje0U3fAN+nzRtELEB6TsZKySJ
         newA==
X-Forwarded-Encrypted: i=1; AJvYcCVNS7MkG5IYwcuIwc6dYzHIRBpzQ+slmwoUZEI5UJ2TJk8tE5mtGl/xis9ULLYAeRXJGR7RmVed6pMaHSw=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywi1OWlgJzmiQ2079bcvNaFi0LvUGLT+00+DCOqWSXjxAcuy7BO
	7aIwo3kQawnPUWMjaU5qD2Yp9q8gAMwi7OA8jRI5EYJpZomSPbWL70VqNZuayglIMOiS8k0NV/S
	eN8SBQX0ssqvD3R9dVu8u+nvC7cY=
X-Gm-Gg: ASbGncuhRPZaOnTl8F+DlhYXNapYvJXCqfUMPENx3YBP7dzieaSryOwt7TQ7YbdyELL
	kapQlL8QSIQDMP44vu6ffX+JCpry5VoQyhrscZeTCZTBvhxbUQoo+WQ+JezSz92Qvw0jLfBHDhe
	hDA6OmKxo=
X-Google-Smtp-Source: AGHT+IEQ3qu54FgHcwV/AtAwrQRXLVHC3SBK4MvY4oOL0wgADlEAML9foGrCD4J5unRUQmXJP1PN25G7ZvUuIfg3afk=
X-Received: by 2002:a2e:9f4a:0:b0:309:1d7b:f027 with SMTP id
 38308e7fff4ca-30a59892a72mr37753531fa.9.1740367020726; Sun, 23 Feb 2025
 19:17:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250214175709.76029-1-ryncsn@gmail.com> <20250214175709.76029-7-ryncsn@gmail.com>
 <Z7bgDhZmg9Vs+btw@MiWiFi-R3L-srv>
In-Reply-To: <Z7bgDhZmg9Vs+btw@MiWiFi-R3L-srv>
From: Kairui Song <ryncsn@gmail.com>
Date: Mon, 24 Feb 2025 11:16:44 +0800
X-Gm-Features: AWEUYZktw7oYwWYoRJtULTBOiHQylTQa-2J2GtS0CcWv-hIKF0ztnTjx6bA70-g
Message-ID: <CAMgjq7BeaJrvcdtyJPgLi-S-=jcmTp4_k5QThPbXy2XxdVy1eg@mail.gmail.com>
Subject: Re: [PATCH 6/7] mm, swap: remove swap slot cache
To: Baoquan He <bhe@redhat.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>, 
	Chris Li <chrisl@kernel.org>, Barry Song <v-songbaohua@oppo.com>, 
	Hugh Dickins <hughd@google.com>, Yosry Ahmed <yosryahmed@google.com>, 
	"Huang, Ying" <ying.huang@linux.alibaba.com>, Nhat Pham <nphamcs@gmail.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, Kalesh Singh <kaleshsingh@google.com>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 20, 2025 at 3:56=E2=80=AFPM Baoquan He <bhe@redhat.com> wrote:
>
> Hi Kairui,
>
> On 02/15/25 at 01:57am, Kairui Song wrote:
> ......snip....
> > -int get_swap_pages(int n_goal, swp_entry_t swp_entries[], int entry_or=
der)
> > +swp_entry_t folio_alloc_swap(struct folio *folio)
> >  {
> > -     int order =3D swap_entry_order(entry_order);
> > -     unsigned long size =3D 1 << order;
> > +     unsigned int order =3D folio_order(folio);
> > +     unsigned int size =3D 1 << order;
> >       struct swap_info_struct *si, *next;
> > -     int n_ret =3D 0;
> > +     swp_entry_t entry =3D {};
> > +     unsigned long offset;
> >       int node;
> >
> > +     if (order) {
> > +             /*
> > +              * Should not even be attempting large allocations when h=
uge
> > +              * page swap is disabled. Warn and fail the allocation.
> > +              */
> > +             if (!IS_ENABLED(CONFIG_THP_SWAP) || size > SWAPFILE_CLUST=
ER) {
> > +                     VM_WARN_ON_ONCE(1);
> > +                     return entry;
> > +             }
> > +     }
> > +
> >       /* Fast path using percpu cluster */
> >       local_lock(&percpu_swap_cluster.lock);
> > -     n_ret =3D swap_alloc_fast(swp_entries,
> > -                             SWAP_HAS_CACHE,
> > -                             order, n_goal);
> > -     if (n_ret =3D=3D n_goal)
> > -             goto out;
> > +     if (swap_alloc_fast(&entry, SWAP_HAS_CACHE, order))
> > +             goto out_alloced;
> >
> > -     n_goal =3D min_t(int, n_goal - n_ret, SWAP_BATCH);
> >       /* Rotate the device and switch to a new cluster */
> >       spin_lock(&swap_avail_lock);
> >  start_over:
> > @@ -1268,11 +1236,14 @@ int get_swap_pages(int n_goal, swp_entry_t swp_=
entries[], int entry_order)
> >               plist_requeue(&si->avail_lists[node], &swap_avail_heads[n=
ode]);
> >               spin_unlock(&swap_avail_lock);
> >               if (get_swap_device_info(si)) {
> > -                     n_ret +=3D scan_swap_map_slots(si, SWAP_HAS_CACHE=
, n_goal,
> > -                                     swp_entries + n_ret, order);
> > +                     offset =3D cluster_alloc_swap_entry(si, order, SW=
AP_HAS_CACHE);
> >                       put_swap_device(si);
> > -                     if (n_ret || size > 1)
> > -                             goto out;
> > +                     if (offset) {
> > +                             entry =3D swp_entry(si->type, offset);
> > +                             goto out_alloced;
> > +                     }
> > +                     if (order)
> > +                             goto out_failed;
>
> This is not related to this patch, do you know why non order-0 case
> can't start over on different devices?

I think that might be an existing bug... I just didn change it as it's
kind of trivial, and also the comment "Swapfile is not block device so
unable to allocate large entries." which I didn't change either, is
also looking strange, but I prefer to fix them later as the background
seems a bit complex to explain.

>
> >               }
> >
> >               spin_lock(&swap_avail_lock);
> > @@ -1291,10 +1262,20 @@ int get_swap_pages(int n_goal, swp_entry_t swp_=
entries[], int entry_order)
> >                       goto start_over;
> >       }
> >       spin_unlock(&swap_avail_lock);
> > -out:
> > +out_failed:
> > +     local_unlock(&percpu_swap_cluster.lock);
> > +     return entry;
> > +
> > +out_alloced:
> >       local_unlock(&percpu_swap_cluster.lock);
> > -     atomic_long_sub(n_ret * size, &nr_swap_pages);
> > -     return n_ret;
> > +     if (mem_cgroup_try_charge_swap(folio, entry)) {
> > +             put_swap_folio(folio, entry);
> > +             entry.val =3D 0;
> > +     } else {
> > +             atomic_long_sub(size, &nr_swap_pages);
> > +     }
> > +
> > +     return entry;
> >  }
> >
> >  static struct swap_info_struct *_swap_info_get(swp_entry_t entry)
> ......snip....
> > @@ -2623,16 +2591,6 @@ static bool __has_usable_swap(void)
> >       return !plist_head_empty(&swap_active_head);
> >  }
>
> seems the __has_usable_swap() function need be moved into the ifdeffery
> scope where __folio_throttle_swaprate() is located to fix the lkp
> warning.

Yes, will fix the bot warning.


>
> >
> > -bool has_usable_swap(void)
> > -{
> > -     bool ret;
> > -
> > -     spin_lock(&swap_lock);
> > -     ret =3D __has_usable_swap();
> > -     spin_unlock(&swap_lock);
> > -     return ret;
> > -}
> > -
> >  /*
> >   * Called after clearing SWP_WRITEOK, ensures cluster_alloc_range
> >   * see the updated flags, so there will be no more allocations.
>
> Other than the test robot reported warning, this patch looks good to me.
> Thanks.
>
>

