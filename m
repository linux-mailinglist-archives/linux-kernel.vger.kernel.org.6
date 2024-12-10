Return-Path: <linux-kernel+bounces-438859-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 66E489EA76E
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 05:55:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5FF291887F5C
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 04:55:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1AF31AAA27;
	Tue, 10 Dec 2024 04:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K8T6o+EZ"
Received: from mail-vk1-f169.google.com (mail-vk1-f169.google.com [209.85.221.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF5C1148FF5
	for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 04:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733806506; cv=none; b=qafWHRirEL7oI1LVQZobBlPGIA/0GkxaqN4Jt0QaYQlo3ehvx3ovulR/BEVw1IjVJSqCY1VZLpnGyZJjdvE76O/hklP/87sJ3izeowi08ThfB8oP8fsOne/0xqQoXnEBI0p0PF4hR2kWfTngg8xuIuG7Ci9oT3Kg4yLL+cRAx0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733806506; c=relaxed/simple;
	bh=QRxp3ywvcSjy4qCZnnkbg65st+T+tqcMKV9k+hqCIQE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DZTvv/2/VGqQZVVzgkfbOJbbViG7HEHElGd2MOlNrqxaXXAKFp8DlgPZXUK2uCrl6kMV7DjyrlU5xtyVdyZRXkpRigDvCSzhM3aYBGQYjkntqgHkf9c4VycAGlSd6Vcys9v69dZpENuS5cO4vVPNVphr/1VeazTCwhG+Mr9fWAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K8T6o+EZ; arc=none smtp.client-ip=209.85.221.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f169.google.com with SMTP id 71dfb90a1353d-5187f0b893dso425708e0c.3
        for <linux-kernel@vger.kernel.org>; Mon, 09 Dec 2024 20:55:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733806504; x=1734411304; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mDFbbwwOVomYolQdyT9bOHykr5RTMJRxIyRn7hebbDs=;
        b=K8T6o+EZxW0KySOJsDh/gSMUVlALPClmE9KdbAtT4uc8LBZ1C+INIsIDCBocW1eMPt
         IE/91HwcIiOb0lgspw4b+WY4YduyB6s4p8e5gUfKKHsZszMO9PKRktK5mEdgCnd74ES6
         xhtJOgjHO5GH+4VY68/6VRjCO4JfV9TgtgJyammCMUdJDGsbaSebm2GNCJEujqY9hWVm
         o+M51e/0uHp3JolZH7WYMdUoItaWJs14R9N/geqCUzBiRltYQijg6s+WGMx9EBjVLT4b
         hDgAfr0bObjO64MAyDyXoyfIIpBDt81uJ1+q8ro8nl9aEwsmq50X4n29YUgl4f/D/w5s
         fehg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733806504; x=1734411304;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mDFbbwwOVomYolQdyT9bOHykr5RTMJRxIyRn7hebbDs=;
        b=RkXaSMRK5j0gmMVKptOv3y/cds75gpEchbVZvbUuu4qoV/iQ138Bu7t+X9VoCi4mA7
         yFBV2HUvioNLgKeg8IBe4Onxdico3UnLuK3ZY/YZFCkJf2GWkWGD+nd/Jr5xdDo4e018
         2mKiAq1jDKpaczMXlqe1VjPVmFhmv8xZbRtXwfxLOFdbDmujEPqRyLZXmYStpzCplVLT
         919UdGM1JrI0Vz0bYH3fV/D4X4LadS3h1e1kO5XiJSNqvXY1EHfsM0tzHYb4SxWGq0XP
         kbhQnoh+gbIni2MB3cUH05/d5xlm3pb57NZR6fDNVfEhNe8VIXQdt8G/4cyzqhkjzDyz
         j1Cg==
X-Forwarded-Encrypted: i=1; AJvYcCV1CcgvqelH36ZBUoP45GifQnO8peTYLe+YGdZWPx5QXORLKQaq2Cv9FiJ63zUZwhlFLRJIiM8HaF7qEHg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZGeBVgO/Pwk6zkl95vAOTsRGBgx8Ff1m3CMfdcmqX+WqsLMSR
	k211YNfN+bhKJRNUSXv5l0lhDBVJq+S2oH2gxP1nhq2U/yX4DJLonMzgx+C3N+Qz/NfYx8Y8T2z
	LcOFTPRriTE1fPMXCsm9aOzf/EHA=
X-Gm-Gg: ASbGnct4VojSOeGDEunkl695IXxISc9qKeazC5KAIac/5EU5TLZEdbk9knIUx1/7c3d
	M4e+EvO5JZIjvY119825CQ+LWFZ0vNCDRb4S5hTwSJYQl8qtFCvKrcnoqoSpE/SCIoF0IPw==
X-Google-Smtp-Source: AGHT+IHN2+Hf+Os/pMGS099DB15tkL5YmQXUHjxOaDv7QInNXh2kZ0vi196IPZ9fbMU6pb8yYQfGLbAYtlehBosBFIk=
X-Received: by 2002:a05:6122:2213:b0:515:4b68:c37f with SMTP id
 71dfb90a1353d-5188834be77mr3512181e0c.6.1733806503561; Mon, 09 Dec 2024
 20:55:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241209083618.2889145-1-chenridong@huaweicloud.com> <20241209083618.2889145-2-chenridong@huaweicloud.com>
In-Reply-To: <20241209083618.2889145-2-chenridong@huaweicloud.com>
From: Barry Song <21cnbao@gmail.com>
Date: Tue, 10 Dec 2024 12:54:52 +0800
Message-ID: <CAGsJ_4wuy5Nhn0pdoz7YvzTXs9LCUrpxT5c4+Hd7-DGH3yBsog@mail.gmail.com>
Subject: Re: [PATCH v4 1/1] mm: vmascan: retry folios written back while
 isolated for traditional LRU
To: Chen Ridong <chenridong@huaweicloud.com>
Cc: akpm@linux-foundation.org, mhocko@suse.com, hannes@cmpxchg.org, 
	yosryahmed@google.com, yuzhao@google.com, david@redhat.com, 
	willy@infradead.org, ryan.roberts@arm.com, wangkefeng.wang@huawei.com, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, chenridong@huawei.com, 
	wangweiyang2@huawei.com, xieym_ict@hotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 9, 2024 at 4:46=E2=80=AFPM Chen Ridong <chenridong@huaweicloud.=
com> wrote:
>
> From: Chen Ridong <chenridong@huawei.com>
>
> The commit 359a5e1416ca ("mm: multi-gen LRU: retry folios written back
> while isolated") only fixed the issue for mglru. However, this issue
> also exists in the traditional active/inactive LRU. This issue will be
> worse if THP is split, which makes the list longer and needs longer time
> to finish a batch of folios reclaim.
>
> This issue should be fixed in the same way for the traditional LRU.
> Therefore, the common logic was extracted to the 'find_folios_written_bac=
k'
> function firstly, which is then reused in the 'shrink_inactive_list'
> function. Finally, retry reclaiming those folios that may have missed the
> rotation for traditional LRU.

let's drop the cover-letter and refine the changelog.

>
> Signed-off-by: Chen Ridong <chenridong@huawei.com>
> ---
>  include/linux/mmzone.h |   3 +-
>  mm/vmscan.c            | 108 +++++++++++++++++++++++++++++------------
>  2 files changed, 77 insertions(+), 34 deletions(-)
>
> diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
> index b36124145a16..47c6e8c43dcd 100644
> --- a/include/linux/mmzone.h
> +++ b/include/linux/mmzone.h
> @@ -391,6 +391,7 @@ struct page_vma_mapped_walk;
>
>  #define LRU_GEN_MASK           ((BIT(LRU_GEN_WIDTH) - 1) << LRU_GEN_PGOF=
F)
>  #define LRU_REFS_MASK          ((BIT(LRU_REFS_WIDTH) - 1) << LRU_REFS_PG=
OFF)
> +#define LRU_REFS_FLAGS         (BIT(PG_referenced) | BIT(PG_workingset))
>
>  #ifdef CONFIG_LRU_GEN
>
> @@ -406,8 +407,6 @@ enum {
>         NR_LRU_GEN_CAPS
>  };
>
> -#define LRU_REFS_FLAGS         (BIT(PG_referenced) | BIT(PG_workingset))
> -
>  #define MIN_LRU_BATCH          BITS_PER_LONG
>  #define MAX_LRU_BATCH          (MIN_LRU_BATCH * 64)
>
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index 76378bc257e3..1f0d194f8b2f 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -283,6 +283,48 @@ static void set_task_reclaim_state(struct task_struc=
t *task,
>         task->reclaim_state =3D rs;
>  }
>
> +/**
> + * find_folios_written_back - Find and move the written back folios to a=
 new list.
> + * @list: filios list
> + * @clean: the written back folios list
> + * @skip: whether skip to move the written back folios to clean list.
> + */
> +static inline void find_folios_written_back(struct list_head *list,
> +               struct list_head *clean, bool skip)
> +{
> +       struct folio *folio;
> +       struct folio *next;
> +
> +       list_for_each_entry_safe_reverse(folio, next, list, lru) {
> +               if (!folio_evictable(folio)) {
> +                       list_del(&folio->lru);
> +                       folio_putback_lru(folio);
> +                       continue;
> +               }
> +
> +               if (folio_test_reclaim(folio) &&
> +                   (folio_test_dirty(folio) || folio_test_writeback(foli=
o))) {
> +                       /* restore LRU_REFS_FLAGS cleared by isolate_foli=
o() */
> +                       if (lru_gen_enabled() && folio_test_workingset(fo=
lio))
> +                               folio_set_referenced(folio);
> +                       continue;
> +               }
> +
> +               if (skip || folio_test_active(folio) || folio_test_refere=
nced(folio) ||
> +                   folio_mapped(folio) || folio_test_locked(folio) ||
> +                   folio_test_dirty(folio) || folio_test_writeback(folio=
)) {
> +                       /* don't add rejected folios to the oldest genera=
tion */
> +                       if (lru_gen_enabled())
> +                               set_mask_bits(&folio->flags, LRU_REFS_MAS=
K | LRU_REFS_FLAGS,
> +                                             BIT(PG_active));
> +                       continue;
> +               }
> +
> +               /* retry folios that may have missed folio_rotate_reclaim=
able() */
> +               list_move(&folio->lru, clean);
> +       }
> +}
> +
>  /*
>   * flush_reclaim_state(): add pages reclaimed outside of LRU-based recla=
im to
>   * scan_control->nr_reclaimed.
> @@ -1907,6 +1949,25 @@ static int current_may_throttle(void)
>         return !(current->flags & PF_LOCAL_THROTTLE);
>  }
>
> +static inline void acc_reclaimed_stat(struct reclaim_stat *stat,
> +               struct reclaim_stat *curr)
> +{
> +       int i;
> +
> +       stat->nr_dirty +=3D curr->nr_dirty;
> +       stat->nr_unqueued_dirty +=3D curr->nr_unqueued_dirty;
> +       stat->nr_congested +=3D curr->nr_congested;
> +       stat->nr_writeback +=3D curr->nr_writeback;
> +       stat->nr_immediate +=3D curr->nr_immediate;
> +       stat->nr_pageout +=3D curr->nr_pageout;
> +       stat->nr_ref_keep +=3D curr->nr_ref_keep;
> +       stat->nr_unmap_fail +=3D curr->nr_unmap_fail;
> +       stat->nr_lazyfree_fail +=3D curr->nr_lazyfree_fail;
> +       stat->nr_demoted +=3D curr->nr_demoted;
> +       for (i =3D 0; i < ANON_AND_FILE; i++)
> +               stat->nr_activate[i] =3D curr->nr_activate[i];
> +}

you had no this before, what's the purpose of this=EF=BC=9F

> +
>  /*
>   * shrink_inactive_list() is a helper for shrink_node().  It returns the=
 number
>   * of reclaimed pages
> @@ -1916,14 +1977,16 @@ static unsigned long shrink_inactive_list(unsigne=
d long nr_to_scan,
>                 enum lru_list lru)
>  {
>         LIST_HEAD(folio_list);
> +       LIST_HEAD(clean_list);
>         unsigned long nr_scanned;
>         unsigned int nr_reclaimed =3D 0;
>         unsigned long nr_taken;
> -       struct reclaim_stat stat;
> +       struct reclaim_stat stat, curr;
>         bool file =3D is_file_lru(lru);
>         enum vm_event_item item;
>         struct pglist_data *pgdat =3D lruvec_pgdat(lruvec);
>         bool stalled =3D false;
> +       bool skip_retry =3D false;
>
>         while (unlikely(too_many_isolated(pgdat, file, sc))) {
>                 if (stalled)
> @@ -1957,10 +2020,20 @@ static unsigned long shrink_inactive_list(unsigne=
d long nr_to_scan,
>         if (nr_taken =3D=3D 0)
>                 return 0;
>
> -       nr_reclaimed =3D shrink_folio_list(&folio_list, pgdat, sc, &stat,=
 false);
> +       memset(&stat, 0, sizeof(stat));
> +retry:
> +       nr_reclaimed +=3D shrink_folio_list(&folio_list, pgdat, sc, &curr=
, false);
> +       find_folios_written_back(&folio_list, &clean_list, skip_retry);
> +       acc_reclaimed_stat(&stat, &curr);
>
>         spin_lock_irq(&lruvec->lru_lock);
>         move_folios_to_lru(lruvec, &folio_list);
> +       if (!list_empty(&clean_list)) {
> +               list_splice_init(&clean_list, &folio_list);
> +               skip_retry =3D true;
> +               spin_unlock_irq(&lruvec->lru_lock);
> +               goto retry;
> +       }
>
>         __mod_lruvec_state(lruvec, PGDEMOTE_KSWAPD + reclaimer_offset(),
>                                         stat.nr_demoted);
> @@ -4567,8 +4640,6 @@ static int evict_folios(struct lruvec *lruvec, stru=
ct scan_control *sc, int swap
>         int reclaimed;
>         LIST_HEAD(list);
>         LIST_HEAD(clean);
> -       struct folio *folio;
> -       struct folio *next;
>         enum vm_event_item item;
>         struct reclaim_stat stat;
>         struct lru_gen_mm_walk *walk;
> @@ -4597,34 +4668,7 @@ static int evict_folios(struct lruvec *lruvec, str=
uct scan_control *sc, int swap
>                         scanned, reclaimed, &stat, sc->priority,
>                         type ? LRU_INACTIVE_FILE : LRU_INACTIVE_ANON);
>
> -       list_for_each_entry_safe_reverse(folio, next, &list, lru) {
> -               if (!folio_evictable(folio)) {
> -                       list_del(&folio->lru);
> -                       folio_putback_lru(folio);
> -                       continue;
> -               }
> -
> -               if (folio_test_reclaim(folio) &&
> -                   (folio_test_dirty(folio) || folio_test_writeback(foli=
o))) {
> -                       /* restore LRU_REFS_FLAGS cleared by isolate_foli=
o() */
> -                       if (folio_test_workingset(folio))
> -                               folio_set_referenced(folio);
> -                       continue;
> -               }
> -
> -               if (skip_retry || folio_test_active(folio) || folio_test_=
referenced(folio) ||
> -                   folio_mapped(folio) || folio_test_locked(folio) ||
> -                   folio_test_dirty(folio) || folio_test_writeback(folio=
)) {
> -                       /* don't add rejected folios to the oldest genera=
tion */
> -                       set_mask_bits(&folio->flags, LRU_REFS_MASK | LRU_=
REFS_FLAGS,
> -                                     BIT(PG_active));
> -                       continue;
> -               }
> -
> -               /* retry folios that may have missed folio_rotate_reclaim=
able() */
> -               list_move(&folio->lru, &clean);
> -       }
> -
> +       find_folios_written_back(&list, &clean, skip_retry);
>         spin_lock_irq(&lruvec->lru_lock);
>
>         move_folios_to_lru(lruvec, &list);
> --
> 2.34.1
>

Thanks
Barry

>

