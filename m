Return-Path: <linux-kernel+bounces-279147-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EE9B494B991
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 11:20:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1B0541C2135A
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 09:20:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60F88146A7B;
	Thu,  8 Aug 2024 09:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="il0tiE0X"
Received: from mail-ua1-f41.google.com (mail-ua1-f41.google.com [209.85.222.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E03B62575F
	for <linux-kernel@vger.kernel.org>; Thu,  8 Aug 2024 09:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723108831; cv=none; b=Mvr04mofJUwcIXx0uMzmeHZM9SZcVCqy8s97VORlcRTGegv5NA7lKi8w9bxIE466lct60jONOxsznrP9OkIACPeGPjq6lI0HZI9KpcPxlau7AdnL1xE9tQUvcUBibXu6LxHgWkkEZZ7mFomab6AdJpyHGZ1XubB8JpIaZ+Vqfb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723108831; c=relaxed/simple;
	bh=lqNCIdynxe155VGOb64biMpejCOs5Dkcdc/rLiliu6Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OBSqH/+WgtqFhqItFK+Ui9wSwYgRF9ZlFwTmEXEBxoa/ZGppHSIFb4k0y9+X4lWzpuczcDziLSKgobxmvFxFot+xyRTWbB3tsvXvSFXjZ3jZGsey4pIYvrF4O+9/nRqHDzLqvCTRmR6Pk9Xy5Ot0wEJg+rwuSWjvJdTw9hSqdZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=il0tiE0X; arc=none smtp.client-ip=209.85.222.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f41.google.com with SMTP id a1e0cc1a2514c-822eb80f6e4so263251241.2
        for <linux-kernel@vger.kernel.org>; Thu, 08 Aug 2024 02:20:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723108829; x=1723713629; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MvcJwK1N9TSmwZfU/K5nAuMPHKng60gm7a5/r3HWnDQ=;
        b=il0tiE0XlodCwcx/f8rEfoDHut3VWMrg2bfsVveJfKxwdJoQBadxpmmdq+vjNvuCry
         CHCWSmXTwNiv4bg9NnwIB9QN+qUMj1tmVrS3ghUUynCBkZJBAUlzbj7Rbe95bKZiyH+N
         EY/x41lS9QJiQi7o9f6KrK0bOe0p5dd01bQF3jFkkOEgLNDVlsnV9HZ4AVP3aWEtEu48
         dJoi3kkekPE+jFlE7a0ApHparX0r7VGRdCnwaAKIZ1TMb+SRqi8YstWxcAAfRauhF+Fp
         OZjVn0q6AbStEssUEWlmBMJnLmantmehQbVte3W8RBqXodgchJTGq3A/pnYeiJtCyiNy
         opzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723108829; x=1723713629;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MvcJwK1N9TSmwZfU/K5nAuMPHKng60gm7a5/r3HWnDQ=;
        b=eFIWRzhxVvfHp8WKLmJaQP73hXoYVoxfDVBf5CCcQR18rBuLnVkev2wOV5RqzV1ZYc
         G2LgfEmhYKl9xNzc2nONGwC3CjM6DiGN2R/sOi0NJmQGdf6f0muUWabuiizKOq9ZgXbI
         VE6LBz3DbrK8Oez+kpTV3WzN5d0haJw8/1jw6fw2A0bGe5GcBdXMyoRwADNtSZ452meQ
         S36Oc18IokDEQ2byN93TEqsMHhLHP72SQZqedTTWFpFvtwtgOPjGPpvPrq3uKSGTl40E
         z1lcq13C3lq68LPrbu6n0HwN0GlDs/9ZKfzbgIwEIYayTasHUeZyCT086/Si42wFn2AP
         qq3Q==
X-Forwarded-Encrypted: i=1; AJvYcCW1eGEk/+1Sd27NtqWD7UjZ7jYvtOa89GEdqzcfiuUfB/KE26qLMJDC3Nz1paFnKSVyuJ3mk7enDjOowCva+FHikH5nDhFBFuw+XD0m
X-Gm-Message-State: AOJu0YyNHme2RmvztsEhVtSjCzkA3MnCF1m+oZzQzQy/Dh6cfBWmJrN/
	fAoOMxYUizWWCt1DJHmjbbhygyyGF8zScwnzDIN0SH/QlQs/aSvVKO0PMHrnE+3y0NNW37b4Mvy
	AMyVhjAtCOZIiveVS9hI9GY8W4xc=
X-Google-Smtp-Source: AGHT+IF/ub0txcRVssHixGM5sw9RT1BVUuDay2z0TpvJn1yUuiY5r4UMZkz1EmbQbOjqUhgL03YFh4g+ZaDojcluIa0=
X-Received: by 2002:a05:6102:304b:b0:493:b4b5:4850 with SMTP id
 ada2fe7eead31-495c5d1677bmr1434621137.31.1723108828594; Thu, 08 Aug 2024
 02:20:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240808010457.228753-2-21cnbao@gmail.com> <20240808070847.285075-1-21cnbao@gmail.com>
 <b17133e5-4f25-47d5-b6db-412ae96db8c3@redhat.com> <14128caf-f7dc-41c0-ab63-c8d434c35f76@redhat.com>
 <41b49313-5804-46ba-9e1d-358b079274cd@redhat.com>
In-Reply-To: <41b49313-5804-46ba-9e1d-358b079274cd@redhat.com>
From: Barry Song <21cnbao@gmail.com>
Date: Thu, 8 Aug 2024 21:20:17 +1200
Message-ID: <CAGsJ_4xOzuYo9c2U=C=BqC=4ObKEqDxpmOmKmu76YFziTPDfNw@mail.gmail.com>
Subject: Re: [PATCH RFC 1/2] mm: collect the number of anon large folios
To: David Hildenbrand <david@redhat.com>
Cc: akpm@linux-foundation.org, baolin.wang@linux.alibaba.com, 
	chrisl@kernel.org, hanchuanhua@oppo.com, ioworker0@gmail.com, 
	kaleshsingh@google.com, kasong@tencent.com, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, ryan.roberts@arm.com, v-songbaohua@oppo.com, 
	ziy@nvidia.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 8, 2024 at 8:17=E2=80=AFPM David Hildenbrand <david@redhat.com>=
 wrote:
>
> On 08.08.24 10:08, David Hildenbrand wrote:
> > On 08.08.24 10:03, David Hildenbrand wrote:
> >> On 08.08.24 09:08, Barry Song wrote:
> >>> On Thu, Aug 8, 2024 at 1:05=E2=80=AFPM Barry Song <21cnbao@gmail.com>=
 wrote:
> >>>>
> >>>> From: Barry Song <v-songbaohua@oppo.com>
> >>>>
> >>>> When a new anonymous mTHP is added to the rmap, we increase the coun=
t.
> >>>> We reduce the count whenever an mTHP is completely unmapped.
> >>>>
> >>>> Signed-off-by: Barry Song <v-songbaohua@oppo.com>
> >>>> ---
> >>>>     Documentation/admin-guide/mm/transhuge.rst |  5 +++++
> >>>>     include/linux/huge_mm.h                    | 15 +++++++++++++--
> >>>>     mm/huge_memory.c                           |  2 ++
> >>>>     mm/rmap.c                                  |  3 +++
> >>>>     4 files changed, 23 insertions(+), 2 deletions(-)
> >>>>
> >>>> diff --git a/Documentation/admin-guide/mm/transhuge.rst b/Documentat=
ion/admin-guide/mm/transhuge.rst
> >>>> index 058485daf186..715f181543f6 100644
> >>>> --- a/Documentation/admin-guide/mm/transhuge.rst
> >>>> +++ b/Documentation/admin-guide/mm/transhuge.rst
> >>>> @@ -527,6 +527,11 @@ split_deferred
> >>>>             it would free up some memory. Pages on split queue are g=
oing to
> >>>>             be split under memory pressure, if splitting is possible=
.
> >>>>
> >>>> +anon_num
> >>>> +       the number of anon huge pages we have in the whole system.
> >>>> +       These huge pages could be still entirely mapped and have par=
tially
> >>>> +       unmapped and unused subpages.
> >>>> +
> >>>>     As the system ages, allocating huge pages may be expensive as th=
e
> >>>>     system uses memory compaction to copy data around memory to free=
 a
> >>>>     huge page for use. There are some counters in ``/proc/vmstat`` t=
o help
> >>>> diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
> >>>> index e25d9ebfdf89..294c348fe3cc 100644
> >>>> --- a/include/linux/huge_mm.h
> >>>> +++ b/include/linux/huge_mm.h
> >>>> @@ -281,6 +281,7 @@ enum mthp_stat_item {
> >>>>            MTHP_STAT_SPLIT,
> >>>>            MTHP_STAT_SPLIT_FAILED,
> >>>>            MTHP_STAT_SPLIT_DEFERRED,
> >>>> +       MTHP_STAT_NR_ANON,
> >>>>            __MTHP_STAT_COUNT
> >>>>     };
> >>>>
> >>>> @@ -291,14 +292,24 @@ struct mthp_stat {
> >>>>     #ifdef CONFIG_SYSFS
> >>>>     DECLARE_PER_CPU(struct mthp_stat, mthp_stats);
> >>>>
> >>>> -static inline void count_mthp_stat(int order, enum mthp_stat_item i=
tem)
> >>>> +static inline void mod_mthp_stat(int order, enum mthp_stat_item ite=
m, int delta)
> >>>>     {
> >>>>            if (order <=3D 0 || order > PMD_ORDER)
> >>>>                    return;
> >>>>
> >>>> -       this_cpu_inc(mthp_stats.stats[order][item]);
> >>>> +       this_cpu_add(mthp_stats.stats[order][item], delta);
> >>>> +}
> >>>> +
> >>>> +static inline void count_mthp_stat(int order, enum mthp_stat_item i=
tem)
> >>>> +{
> >>>> +       mod_mthp_stat(order, item, 1);
> >>>>     }
> >>>> +
> >>>>     #else
> >>>> +static inline void mod_mthp_stat(int order, enum mthp_stat_item ite=
m, int delta)
> >>>> +{
> >>>> +}
> >>>> +
> >>>>     static inline void count_mthp_stat(int order, enum mthp_stat_ite=
m item)
> >>>>     {
> >>>>     }
> >>>> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> >>>> index 697fcf89f975..b6bc2a3791e3 100644
> >>>> --- a/mm/huge_memory.c
> >>>> +++ b/mm/huge_memory.c
> >>>> @@ -578,6 +578,7 @@ DEFINE_MTHP_STAT_ATTR(shmem_fallback_charge, MTH=
P_STAT_SHMEM_FALLBACK_CHARGE);
> >>>>     DEFINE_MTHP_STAT_ATTR(split, MTHP_STAT_SPLIT);
> >>>>     DEFINE_MTHP_STAT_ATTR(split_failed, MTHP_STAT_SPLIT_FAILED);
> >>>>     DEFINE_MTHP_STAT_ATTR(split_deferred, MTHP_STAT_SPLIT_DEFERRED);
> >>>> +DEFINE_MTHP_STAT_ATTR(anon_num, MTHP_STAT_NR_ANON);
> >>>>
> >>>>     static struct attribute *stats_attrs[] =3D {
> >>>>            &anon_fault_alloc_attr.attr,
> >>>> @@ -591,6 +592,7 @@ static struct attribute *stats_attrs[] =3D {
> >>>>            &split_attr.attr,
> >>>>            &split_failed_attr.attr,
> >>>>            &split_deferred_attr.attr,
> >>>> +       &anon_num_attr.attr,
> >>>>            NULL,
> >>>>     };
> >>>>
> >>>> diff --git a/mm/rmap.c b/mm/rmap.c
> >>>> index 901950200957..2b722f26224c 100644
> >>>> --- a/mm/rmap.c
> >>>> +++ b/mm/rmap.c
> >>>> @@ -1467,6 +1467,7 @@ void folio_add_new_anon_rmap(struct folio *fol=
io, struct vm_area_struct *vma,
> >>>>            }
> >>>>
> >>>>            __folio_mod_stat(folio, nr, nr_pmdmapped);
> >>>> +       mod_mthp_stat(folio_order(folio), MTHP_STAT_NR_ANON, 1);
> >>>>     }
> >>>>
> >>>>     static __always_inline void __folio_add_file_rmap(struct folio *=
folio,
> >>>> @@ -1582,6 +1583,8 @@ static __always_inline void __folio_remove_rma=
p(struct folio *folio,
> >>>>                list_empty(&folio->_deferred_list))
> >>>>                    deferred_split_folio(folio);
> >>>>            __folio_mod_stat(folio, -nr, -nr_pmdmapped);
> >>>> +       if (folio_test_anon(folio) && !atomic_read(mapped))
> >>>
> >>> could have a risk here two processes unmap at the same time, so
> >>> they both get zero on atomic_read(mapped)? should read the value
> >>> of atomic_dec_return() instead to confirm we are the last one
> >>> doing unmap?
> >>
> >> I would appreciate if we leave the rmap out here.
> >>
> >> Can't we handle that when actually freeing the folio? folio_test_anon(=
)
> >> is sticky until freed.
> >
> > To be clearer: we increment the counter when we set a folio anon, which
> > should indeed only happen in folio_add_new_anon_rmap(). We'll have to
> > ignore hugetlb here where we do it in hugetlb_add_new_anon_rmap().
> >
> > Then, when we free an anon folio we decrement the counter. (hugetlb
> > should clear the anon flag when an anon folio gets freed back to its
> > allocator -- likely that is already done).
> >
>
> Sorry that I am talking to myself: I'm wondering if we also have to
> adjust the counter when splitting a large folio to multiple
> smaller-but-still-large folios.

yes, if we don't use remove_rmap. because we could allocate them as
mTHP but free them as nr_pages small folios.

>
> --
> Cheers,
>
> David / dhildenb
>

