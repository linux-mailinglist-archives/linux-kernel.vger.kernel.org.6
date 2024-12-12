Return-Path: <linux-kernel+bounces-444042-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EEAF9EFFF7
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 00:17:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 454F91886EB0
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 23:17:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EC841898EA;
	Thu, 12 Dec 2024 23:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FG6S+SZh"
Received: from mail-vs1-f41.google.com (mail-vs1-f41.google.com [209.85.217.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34E6B1BEF82
	for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 23:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734045468; cv=none; b=V+woLMRWMWDwjE8Jxdk9eA3fED3NtVOwt0TtAsAgqV9c+kt5w5bWLCpahDYCqYnIqyxCBaoGZ+3yKhQe4KKZ90JyjBIZx2Xq7MDt/iAs96vMwc3aytqZuo60P7JIPQZ7mhfFghmvKy2n8Z0I8roCVoy29HApNq0AceS3NiZ7AA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734045468; c=relaxed/simple;
	bh=hCfKR29Aqjbsxk4mpKXd/NZAeYT33r3WzQ6QUgAogG0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Qa1gC1STYLO4y2bhVHv4L/qEei2QVruNFcrWRh5scD3mX/h1gAiQNb8l9zsotajs2cHQPCZk0mrJseQeyinzsHqvkYAvLjCu8mtrJvAZ/ZeSgKqOEdnz9z62FCxsJ0vjBUFQz4Dil5dEPtuZrEr5aW2n4HgXG11KFOHHi4vDxHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FG6S+SZh; arc=none smtp.client-ip=209.85.217.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f41.google.com with SMTP id ada2fe7eead31-4aff5b3845eso307508137.2
        for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 15:17:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734045465; x=1734650265; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R/jz3iLY9FPUrbViSXQDcEBqhi/rKZAYxJ7EbbAWC1c=;
        b=FG6S+SZhJBDSSKXMRZ+ynY9d9Ffotd4Mb52NldQjxRmpa4EtdFlT0kU5SyivBlvIS/
         tao2gnDn3/f+3LJCnoUJVHUSF3xb5Cg9yU+MJsJmZ5RXD2mEgd7M55TpeAEoSopmXnsT
         M7thTWNNyG3NNwx0mVF/TDBauFzX9QsGgv6knQBgAjS3DDvGRSuGRgWSHse6No3cEqRs
         LczQiyc448HJ/3HsryPuM/tR8C/pep6Ek/hXKNoXDfuf2BEbo4gTTy8SepKQmBwbCUXn
         B54BTfm6uqyL2qGKOQeB378KJlZOb2gCkppZbspm1nwozFxtB0IZR26I4SC5RyfofUyv
         BDdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734045465; x=1734650265;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R/jz3iLY9FPUrbViSXQDcEBqhi/rKZAYxJ7EbbAWC1c=;
        b=c0s9FF16hnO2loZdeIFqlI1Clx1PKT8DFowZyogdF53oYcGbhwf4R2msG/x8DD7XhB
         Wl/8dbGeAxzl1DLI15wYBoB17veR0Y21PSnlqTATFZpmHaOUTAiDZj4hzygyATqvyEH4
         abKrj+XaR6b4sbQgnTNE0dJFwZOFDYm8NK2DtLEGnVZ8WCy3L15T0bT6AZbyrmLUm5xn
         DsNjzO/px5MlP+h0ruRgfmTTp8Kigbm074zEMCrdf55JO+APNhqUaqDXiOE1C6xA5DTQ
         7bSwOjEoxL0q2EgPMZieR6UOFgXRCtaUz94Hfq14keCY8csz+1+yFb8ALJFiaYmDWu4s
         dFkA==
X-Forwarded-Encrypted: i=1; AJvYcCW6/DsSNZLS5MxIYkvWYpGa/VLFqCnWpMgOB8w+/uTiTfpC+RwznkdR8ZoxJaTBscqvEc9IKpWR1e0aJ/M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyw0EbMwAv4Nt0rhHbLXKxdH9q1Ekwm4Oi+CCtfu+K3JagpN9F8
	m2r14EhgoswVyO+rkOqC/ASFxiIXCf1Xds9D9g35JaU/VXwybOE+3pjLYcGXVEeHq6rgAJOkl5S
	Uws2ShkC6392Hl85zaa+n+VTzwyg=
X-Gm-Gg: ASbGnct8zpB1GOS99C/MnpDJKHnqawsBLcHqNloBagbAovOCNpVMPPIbGmvEnFt8qE1
	qBykpR59nHjIsuU5fOqkq5nwhwH8F7/lNiZxg8LvlzKKdFpG2EYLAmZK6JIxbHFnTTWDJNlDl
X-Google-Smtp-Source: AGHT+IGjXhkoJpMfUPiKacf7Kfh7S4rbUd/mbjfvqu3riWZKz8Ep5ExuJUBuS6a4N4VuNuZBGNw9SFLcoaPzLFm8hic=
X-Received: by 2002:a05:6102:3ecd:b0:4b1:1a11:16e0 with SMTP id
 ada2fe7eead31-4b25db8a923mr1029988137.27.1734045464815; Thu, 12 Dec 2024
 15:17:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241209083618.2889145-1-chenridong@huaweicloud.com>
 <20241209083618.2889145-2-chenridong@huaweicloud.com> <CAGsJ_4wuy5Nhn0pdoz7YvzTXs9LCUrpxT5c4+Hd7-DGH3yBsog@mail.gmail.com>
 <13223d50-6218-49db-8356-700a1907e224@huawei.com> <CAGsJ_4yWLpd262vOMb11qeQXhXeNFLOKpmEUat3kvJv4wBxi5w@mail.gmail.com>
 <ee9573f8-dd9c-49dc-8518-68bb45e1bbf4@huawei.com>
In-Reply-To: <ee9573f8-dd9c-49dc-8518-68bb45e1bbf4@huawei.com>
From: Barry Song <21cnbao@gmail.com>
Date: Fri, 13 Dec 2024 12:17:33 +1300
Message-ID: <CAGsJ_4wJD8sv=4t98KC7nasbH9OFX9e6Nqzkr-MG9O3Bv-mbCw@mail.gmail.com>
Subject: Re: [PATCH v4 1/1] mm: vmascan: retry folios written back while
 isolated for traditional LRU
To: chenridong <chenridong@huawei.com>
Cc: Chen Ridong <chenridong@huaweicloud.com>, akpm@linux-foundation.org, mhocko@suse.com, 
	hannes@cmpxchg.org, yosryahmed@google.com, yuzhao@google.com, 
	david@redhat.com, willy@infradead.org, ryan.roberts@arm.com, 
	wangkefeng.wang@huawei.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	wangweiyang2@huawei.com, xieym_ict@hotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 11, 2024 at 1:11=E2=80=AFAM chenridong <chenridong@huawei.com> =
wrote:
>
>
>
> On 2024/12/10 16:24, Barry Song wrote:
> > On Tue, Dec 10, 2024 at 2:41=E2=80=AFPM chenridong <chenridong@huawei.c=
om> wrote:
> >>
> >>
> >>
> >> On 2024/12/10 12:54, Barry Song wrote:
> >>> On Mon, Dec 9, 2024 at 4:46=E2=80=AFPM Chen Ridong <chenridong@huawei=
cloud.com> wrote:
> >>>>
> >>>> From: Chen Ridong <chenridong@huawei.com>
> >>>>
> >>>> The commit 359a5e1416ca ("mm: multi-gen LRU: retry folios written ba=
ck
> >>>> while isolated") only fixed the issue for mglru. However, this issue
> >>>> also exists in the traditional active/inactive LRU. This issue will =
be
> >>>> worse if THP is split, which makes the list longer and needs longer =
time
> >>>> to finish a batch of folios reclaim.
> >>>>
> >>>> This issue should be fixed in the same way for the traditional LRU.
> >>>> Therefore, the common logic was extracted to the 'find_folios_writte=
n_back'
> >>>> function firstly, which is then reused in the 'shrink_inactive_list'
> >>>> function. Finally, retry reclaiming those folios that may have misse=
d the
> >>>> rotation for traditional LRU.
> >>>
> >>> let's drop the cover-letter and refine the changelog.
> >>>
> >> Will update.
> >>
> >>>>
> >>>> Signed-off-by: Chen Ridong <chenridong@huawei.com>
> >>>> ---
> >>>>  include/linux/mmzone.h |   3 +-
> >>>>  mm/vmscan.c            | 108 +++++++++++++++++++++++++++++---------=
---
> >>>>  2 files changed, 77 insertions(+), 34 deletions(-)
> >>>>
> >>>> diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
> >>>> index b36124145a16..47c6e8c43dcd 100644
> >>>> --- a/include/linux/mmzone.h
> >>>> +++ b/include/linux/mmzone.h
> >>>> @@ -391,6 +391,7 @@ struct page_vma_mapped_walk;
> >>>>
> >>>>  #define LRU_GEN_MASK           ((BIT(LRU_GEN_WIDTH) - 1) << LRU_GEN=
_PGOFF)
> >>>>  #define LRU_REFS_MASK          ((BIT(LRU_REFS_WIDTH) - 1) << LRU_RE=
FS_PGOFF)
> >>>> +#define LRU_REFS_FLAGS         (BIT(PG_referenced) | BIT(PG_working=
set))
> >>>>
> >>>>  #ifdef CONFIG_LRU_GEN
> >>>>
> >>>> @@ -406,8 +407,6 @@ enum {
> >>>>         NR_LRU_GEN_CAPS
> >>>>  };
> >>>>
> >>>> -#define LRU_REFS_FLAGS         (BIT(PG_referenced) | BIT(PG_working=
set))
> >>>> -
> >>>>  #define MIN_LRU_BATCH          BITS_PER_LONG
> >>>>  #define MAX_LRU_BATCH          (MIN_LRU_BATCH * 64)
> >>>>
> >>>> diff --git a/mm/vmscan.c b/mm/vmscan.c
> >>>> index 76378bc257e3..1f0d194f8b2f 100644
> >>>> --- a/mm/vmscan.c
> >>>> +++ b/mm/vmscan.c
> >>>> @@ -283,6 +283,48 @@ static void set_task_reclaim_state(struct task_=
struct *task,
> >>>>         task->reclaim_state =3D rs;
> >>>>  }
> >>>>
> >>>> +/**
> >>>> + * find_folios_written_back - Find and move the written back folios=
 to a new list.
> >>>> + * @list: filios list
> >>>> + * @clean: the written back folios list
> >>>> + * @skip: whether skip to move the written back folios to clean lis=
t.
> >>>> + */
> >>>> +static inline void find_folios_written_back(struct list_head *list,
> >>>> +               struct list_head *clean, bool skip)
> >>>> +{
> >>>> +       struct folio *folio;
> >>>> +       struct folio *next;
> >>>> +
> >>>> +       list_for_each_entry_safe_reverse(folio, next, list, lru) {
> >>>> +               if (!folio_evictable(folio)) {
> >>>> +                       list_del(&folio->lru);
> >>>> +                       folio_putback_lru(folio);
> >>>> +                       continue;
> >>>> +               }
> >>>> +
> >>>> +               if (folio_test_reclaim(folio) &&
> >>>> +                   (folio_test_dirty(folio) || folio_test_writeback=
(folio))) {
> >>>> +                       /* restore LRU_REFS_FLAGS cleared by isolate=
_folio() */
> >>>> +                       if (lru_gen_enabled() && folio_test_workings=
et(folio))
> >>>> +                               folio_set_referenced(folio);
> >>>> +                       continue;
> >>>> +               }
> >>>> +
> >>>> +               if (skip || folio_test_active(folio) || folio_test_r=
eferenced(folio) ||
> >>>> +                   folio_mapped(folio) || folio_test_locked(folio) =
||
> >>>> +                   folio_test_dirty(folio) || folio_test_writeback(=
folio)) {
> >>>> +                       /* don't add rejected folios to the oldest g=
eneration */
> >>>> +                       if (lru_gen_enabled())
> >>>> +                               set_mask_bits(&folio->flags, LRU_REF=
S_MASK | LRU_REFS_FLAGS,
> >>>> +                                             BIT(PG_active));
> >>>> +                       continue;
> >>>> +               }
> >>>> +
> >>>> +               /* retry folios that may have missed folio_rotate_re=
claimable() */
> >>>> +               list_move(&folio->lru, clean);
> >>>> +       }
> >>>> +}
> >>>> +
> >>>>  /*
> >>>>   * flush_reclaim_state(): add pages reclaimed outside of LRU-based =
reclaim to
> >>>>   * scan_control->nr_reclaimed.
> >>>> @@ -1907,6 +1949,25 @@ static int current_may_throttle(void)
> >>>>         return !(current->flags & PF_LOCAL_THROTTLE);
> >>>>  }
> >>>>
> >>>> +static inline void acc_reclaimed_stat(struct reclaim_stat *stat,
> >>>> +               struct reclaim_stat *curr)
> >>>> +{
> >>>> +       int i;
> >>>> +
> >>>> +       stat->nr_dirty +=3D curr->nr_dirty;
> >>>> +       stat->nr_unqueued_dirty +=3D curr->nr_unqueued_dirty;
> >>>> +       stat->nr_congested +=3D curr->nr_congested;
> >>>> +       stat->nr_writeback +=3D curr->nr_writeback;
> >>>> +       stat->nr_immediate +=3D curr->nr_immediate;
> >>>> +       stat->nr_pageout +=3D curr->nr_pageout;
> >>>> +       stat->nr_ref_keep +=3D curr->nr_ref_keep;
> >>>> +       stat->nr_unmap_fail +=3D curr->nr_unmap_fail;
> >>>> +       stat->nr_lazyfree_fail +=3D curr->nr_lazyfree_fail;
> >>>> +       stat->nr_demoted +=3D curr->nr_demoted;
> >>>> +       for (i =3D 0; i < ANON_AND_FILE; i++)
> >>>> +               stat->nr_activate[i] =3D curr->nr_activate[i];
> >>>> +}
> >>>
> >>> you had no this before, what's the purpose of this=EF=BC=9F
> >>>
> >>
> >> We may call shrink_folio_list twice, and the 'stat curr' will reset in
> >> the shrink_folio_list function. We should accumulate the stats as a
> >> whole, which will then be used to calculate the cost and return it to
> >> the caller.
> >
> > Does mglru have the same issue? If so, we may need to send a patch to
> > fix mglru's stat accounting as well. By the way, the code is rather
> > messy=E2=80=94could it be implemented as shown below instead?
> >
>
> I have checked the code (in the evict_folios function) again, and it
> appears that 'reclaimed' should correspond to sc->nr_reclaimed, which
> accumulates the results twice. Should I address this issue with a
> separate patch?

I don't think there is any problem.

        reclaimed =3D shrink_folio_list(&list, pgdat, sc, &stat, false);
        sc->nr.unqueued_dirty +=3D stat.nr_unqueued_dirty;
        sc->nr_reclaimed +=3D reclaimed;

reclaimed is always the number of pages we have reclaimed in
shrink_folio_list() no matter if it is retry or not.

>
> if (!cgroup_reclaim(sc))
>         __count_vm_events(item, reclaimed);
> __count_memcg_events(memcg, item, reclaimed);
> __count_vm_events(PGSTEAL_ANON + type, reclaimed);
>
>
> > diff --git a/mm/vmscan.c b/mm/vmscan.c
> > index 1f0d194f8b2f..40d2ddde21f5 100644
> > --- a/mm/vmscan.c
> > +++ b/mm/vmscan.c
> > @@ -1094,7 +1094,6 @@ static unsigned int shrink_folio_list(struct
> > list_head *folio_list,
> >   struct swap_iocb *plug =3D NULL;
> >
> >   folio_batch_init(&free_folios);
> > - memset(stat, 0, sizeof(*stat));
> >   cond_resched();
> >   do_demote_pass =3D can_demote(pgdat->node_id, sc);
> >
> > @@ -1949,25 +1948,6 @@ static int current_may_throttle(void)
> >   return !(current->flags & PF_LOCAL_THROTTLE);
> >  }
> >
> > -static inline void acc_reclaimed_stat(struct reclaim_stat *stat,
> > - struct reclaim_stat *curr)
> > -{
> > - int i;
> > -
> > - stat->nr_dirty +=3D curr->nr_dirty;
> > - stat->nr_unqueued_dirty +=3D curr->nr_unqueued_dirty;
> > - stat->nr_congested +=3D curr->nr_congested;
> > - stat->nr_writeback +=3D curr->nr_writeback;
> > - stat->nr_immediate +=3D curr->nr_immediate;
> > - stat->nr_pageout +=3D curr->nr_pageout;
> > - stat->nr_ref_keep +=3D curr->nr_ref_keep;
> > - stat->nr_unmap_fail +=3D curr->nr_unmap_fail;
> > - stat->nr_lazyfree_fail +=3D curr->nr_lazyfree_fail;
> > - stat->nr_demoted +=3D curr->nr_demoted;
> > - for (i =3D 0; i < ANON_AND_FILE; i++)
> > - stat->nr_activate[i] =3D curr->nr_activate[i];
> > -}
> > -
> >  /*
> >   * shrink_inactive_list() is a helper for shrink_node().  It returns t=
he number
> >   * of reclaimed pages
> > @@ -1981,7 +1961,7 @@ static unsigned long
> > shrink_inactive_list(unsigned long nr_to_scan,
> >   unsigned long nr_scanned;
> >   unsigned int nr_reclaimed =3D 0;
> >   unsigned long nr_taken;
> > - struct reclaim_stat stat, curr;
> > + struct reclaim_stat stat;
> >   bool file =3D is_file_lru(lru);
> >   enum vm_event_item item;
> >   struct pglist_data *pgdat =3D lruvec_pgdat(lruvec);
> > @@ -2022,9 +2002,8 @@ static unsigned long
> > shrink_inactive_list(unsigned long nr_to_scan,
> >
> >   memset(&stat, 0, sizeof(stat));
> >  retry:
> > - nr_reclaimed +=3D shrink_folio_list(&folio_list, pgdat, sc, &curr, fa=
lse);
> > + nr_reclaimed +=3D shrink_folio_list(&folio_list, pgdat, sc, &stat, fa=
lse);
> >   find_folios_written_back(&folio_list, &clean_list, skip_retry);
> > - acc_reclaimed_stat(&stat, &curr);
> >
> >   spin_lock_irq(&lruvec->lru_lock);
> >   move_folios_to_lru(lruvec, &folio_list);
> >
>
> This seems much better. But we have extras works to do:
>
> 1. In the shrink_folio_list function:
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -1089,12 +1089,12 @@ static unsigned int shrink_folio_list(struct
> list_head *folio_list,
>         LIST_HEAD(ret_folios);
>         LIST_HEAD(demote_folios);
>         unsigned int nr_reclaimed =3D 0;
> -       unsigned int pgactivate =3D 0;
> +       unsigned int pgactivate =3D stat->nr_activate[0] +
> stat->nr_activate[1];
> +       unsigned int nr_demote =3D 0;
>         bool do_demote_pass;
>         struct swap_iocb *plug =3D NULL;
>
>         folio_batch_init(&free_folios);
> -       memset(stat, 0, sizeof(*stat));
>         cond_resched();
>         do_demote_pass =3D can_demote(pgdat->node_id, sc);
>
> @@ -1558,7 +1558,8 @@ static unsigned int shrink_folio_list(struct
> list_head *folio_list,
>
>         /* Migrate folios selected for demotion */
>         stat->nr_demoted =3D demote_folio_list(&demote_folios, pgdat);
> -       nr_reclaimed +=3D stat->nr_demoted;
> +       stat->nr_demoted +=3D nr_demote;
> +       nr_reclaimed +=3D nr_demote;
>         /* Folios that could not be demoted are still in @demote_folios *=
/
>         if (!list_empty(&demote_folios)) {
>                 /* Folios which weren't demoted go back on @folio_list */
> @@ -1586,7 +1587,7 @@ static unsigned int shrink_folio_list(struct
> list_head *folio_list,
>                 }
>         }
>
> -       pgactivate =3D stat->nr_activate[0] + stat->nr_activate[1];
> +       pgactivate =3D stat->nr_activate[0] + stat->nr_activate[1] -
> pgactivate;
>
>         mem_cgroup_uncharge_folios(&free_folios);
>         try_to_unmap_flush();
>
>
> 2. Outsize of the shrink_folio_list function, The callers should memset
> the stat.
>
> If you think this will be better, I will update like this.

no. Please goto retry after you have collected all you need from
`stat` just as mglru
is doing, drop the "curr" and acc_reclaimed_stat().

        sc->nr.unqueued_dirty +=3D stat.nr_unqueued_dirty;
        sc->nr_reclaimed +=3D reclaimed;

move_folios_to_lru() has helped moving all uninterested folios back to lruv=
ec
before you retry. There is no duplicated counting.

>
> >>
> >> Thanks,
> >> Ridong
> >>
> >>>> +
> >>>>  /*
> >>>>   * shrink_inactive_list() is a helper for shrink_node().  It return=
s the number
> >>>>   * of reclaimed pages
> >>>> @@ -1916,14 +1977,16 @@ static unsigned long shrink_inactive_list(un=
signed long nr_to_scan,
> >>>>                 enum lru_list lru)
> >>>>  {
> >>>>         LIST_HEAD(folio_list);
> >>>> +       LIST_HEAD(clean_list);
> >>>>         unsigned long nr_scanned;
> >>>>         unsigned int nr_reclaimed =3D 0;
> >>>>         unsigned long nr_taken;
> >>>> -       struct reclaim_stat stat;
> >>>> +       struct reclaim_stat stat, curr;
> >>>>         bool file =3D is_file_lru(lru);
> >>>>         enum vm_event_item item;
> >>>>         struct pglist_data *pgdat =3D lruvec_pgdat(lruvec);
> >>>>         bool stalled =3D false;
> >>>> +       bool skip_retry =3D false;
> >>>>
> >>>>         while (unlikely(too_many_isolated(pgdat, file, sc))) {
> >>>>                 if (stalled)
> >>>> @@ -1957,10 +2020,20 @@ static unsigned long shrink_inactive_list(un=
signed long nr_to_scan,
> >>>>         if (nr_taken =3D=3D 0)
> >>>>                 return 0;
> >>>>
> >>>> -       nr_reclaimed =3D shrink_folio_list(&folio_list, pgdat, sc, &=
stat, false);
> >>>> +       memset(&stat, 0, sizeof(stat));
> >>>> +retry:
> >>>> +       nr_reclaimed +=3D shrink_folio_list(&folio_list, pgdat, sc, =
&curr, false);
> >>>> +       find_folios_written_back(&folio_list, &clean_list, skip_retr=
y);
> >>>> +       acc_reclaimed_stat(&stat, &curr);
> >>>>
> >>>>         spin_lock_irq(&lruvec->lru_lock);
> >>>>         move_folios_to_lru(lruvec, &folio_list);
> >>>> +       if (!list_empty(&clean_list)) {
> >>>> +               list_splice_init(&clean_list, &folio_list);
> >>>> +               skip_retry =3D true;
> >>>> +               spin_unlock_irq(&lruvec->lru_lock);
> >>>> +               goto retry;
> >
> > This is rather confusing. We're still jumping to retry even though
> > skip_retry=3Dtrue is set. Can we find a clearer approach for this?
> >
> > It was somewhat acceptable before we introduced the extracted
> > function find_folios_written_back(). However, it has become
> > harder to follow now that skip_retry is passed across functions.
> >
> > I find renaming skip_retry to is_retry more intuitive. The logic
> > is that since we are already retrying, find_folios_written_back()
> > shouldn=E2=80=99t move folios to the clean list again. The intended sem=
antics
> > are: we have retris, don=E2=80=99t retry again.
> >
>
> Reasonable. Will update.
>
> Thanks,
> Ridong
>
> >
> >>>> +       }
> >>>>
> >>>>         __mod_lruvec_state(lruvec, PGDEMOTE_KSWAPD + reclaimer_offse=
t(),
> >>>>                                         stat.nr_demoted);
> >>>> @@ -4567,8 +4640,6 @@ static int evict_folios(struct lruvec *lruvec,=
 struct scan_control *sc, int swap
> >>>>         int reclaimed;
> >>>>         LIST_HEAD(list);
> >>>>         LIST_HEAD(clean);
> >>>> -       struct folio *folio;
> >>>> -       struct folio *next;
> >>>>         enum vm_event_item item;
> >>>>         struct reclaim_stat stat;
> >>>>         struct lru_gen_mm_walk *walk;
> >>>> @@ -4597,34 +4668,7 @@ static int evict_folios(struct lruvec *lruvec=
, struct scan_control *sc, int swap
> >>>>                         scanned, reclaimed, &stat, sc->priority,
> >>>>                         type ? LRU_INACTIVE_FILE : LRU_INACTIVE_ANON=
);
> >>>>
> >>>> -       list_for_each_entry_safe_reverse(folio, next, &list, lru) {
> >>>> -               if (!folio_evictable(folio)) {
> >>>> -                       list_del(&folio->lru);
> >>>> -                       folio_putback_lru(folio);
> >>>> -                       continue;
> >>>> -               }
> >>>> -
> >>>> -               if (folio_test_reclaim(folio) &&
> >>>> -                   (folio_test_dirty(folio) || folio_test_writeback=
(folio))) {
> >>>> -                       /* restore LRU_REFS_FLAGS cleared by isolate=
_folio() */
> >>>> -                       if (folio_test_workingset(folio))
> >>>> -                               folio_set_referenced(folio);
> >>>> -                       continue;
> >>>> -               }
> >>>> -
> >>>> -               if (skip_retry || folio_test_active(folio) || folio_=
test_referenced(folio) ||
> >>>> -                   folio_mapped(folio) || folio_test_locked(folio) =
||
> >>>> -                   folio_test_dirty(folio) || folio_test_writeback(=
folio)) {
> >>>> -                       /* don't add rejected folios to the oldest g=
eneration */
> >>>> -                       set_mask_bits(&folio->flags, LRU_REFS_MASK |=
 LRU_REFS_FLAGS,
> >>>> -                                     BIT(PG_active));
> >>>> -                       continue;
> >>>> -               }
> >>>> -
> >>>> -               /* retry folios that may have missed folio_rotate_re=
claimable() */
> >>>> -               list_move(&folio->lru, &clean);
> >>>> -       }
> >>>> -
> >>>> +       find_folios_written_back(&list, &clean, skip_retry);
> >>>>         spin_lock_irq(&lruvec->lru_lock);
> >>>>
> >>>>         move_folios_to_lru(lruvec, &list);
> >>>> --
> >>>> 2.34.1
> >>>>
> >>>
> >
> > Thanks
> >  Barry

