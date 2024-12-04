Return-Path: <linux-kernel+bounces-430985-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5DDA9E37CF
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 11:46:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 94DDD165951
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 10:46:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA8651B0F33;
	Wed,  4 Dec 2024 10:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LYP3vvTt"
Received: from mail-vs1-f53.google.com (mail-vs1-f53.google.com [209.85.217.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5738118CBF2
	for <linux-kernel@vger.kernel.org>; Wed,  4 Dec 2024 10:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733309142; cv=none; b=qVqbr9k6jB4DiTTJ7XqvGMHEoPy1dxEnmneqxvqL8Z3IByE3GCD3auMpa3Tdr4lg6a2kjeOzXwY2CsNENUe0xDuvmfcs4xXGZToTNJn8Cj7wU5OSTQ8NQJYjvVQ6gbQkz/tILgkHt64V2l6yuxPTsWjSTK3LqvH8HRH4CwIQCNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733309142; c=relaxed/simple;
	bh=WmkcGznFx2twbiEn71zcnck9IFaPCNhH/DA6P1VtDQg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EL9vJPG7KWz0kzAPuedDTpkfQkxixPxEY1Y6bcFJqa5aAI039iWei1ThTce/ThE/91QXlVqMHS4n9CF5m4GbWP8x5UkGBlTlWKQ6eGF55i17zfauFDzbcCGU7Ve39SsdsA78Bb2Gy9CFjKSXCjByrjKOxZsTe+9gMmH4zoxfdmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LYP3vvTt; arc=none smtp.client-ip=209.85.217.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f53.google.com with SMTP id ada2fe7eead31-4af3bfbb721so1959776137.3
        for <linux-kernel@vger.kernel.org>; Wed, 04 Dec 2024 02:45:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733309139; x=1733913939; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4oNqa4xsuUgxCQOGEVLbW6F6nvAU5L7WVcWYuhDILIU=;
        b=LYP3vvTth/uryBdot7yvtWqgD0rc39uHDPGxkWoKp/HvSRvaspRK7kCzdsHWIjdSNG
         U7DYD/H0BPW3NagtwkT/Mn1qW2BstIjIVtgQwl2yVTNIz4OBvcwVY5eHHMHm4dJMOVIb
         JBzHKQnWnPe+DqccxhScf+2pJXn4tsgqpOqjb5cohI0TkdQrDjBwSYtbfOufSFjb5Gre
         CDEC2XJ5ArG7zI1jeV4u4k13nn9Zio1yTIFb7NXUZwzO9GR8nb4kH9Dsyz5qGN6vfakw
         Ewat1ZvP3Wc7JogkCs0PDBYuYvukSUsFGaG1iC/dkdly2lVeEVmf7Kc5fkfACW1PDP94
         HFtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733309139; x=1733913939;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4oNqa4xsuUgxCQOGEVLbW6F6nvAU5L7WVcWYuhDILIU=;
        b=SvxBUARgoiyG22q6nthLQcIAsXjr2ohLZ/ibTg6O6Ow6KOJU0YWDXcLajQq3zTXPQX
         YLSQ8RYys070/SzrQgutaujVwfhKPrJeWAWpn7THznbp1iP1YWUWHaDRPPGVM2aptzMB
         G3oSqcriIaYPoCCUyIgPRBJ6oEwrsM9nsC+KeFu+FZd2YBth2GG5p+pMx/Ej+kktAaFd
         JY02peDSPn2b0d5y/gLG4DTdHJZebaZMErYEJ8kE2r/n7TGpvkbEtgR+M4MDbXEf6T2V
         opdXTjaGjwG4J8GXQXIsQ13OmhuDTwyukA22AWsfaR+02HC/4fVBtn3vOLu3vlpXid9q
         aQFw==
X-Forwarded-Encrypted: i=1; AJvYcCXWvB6iJBGeKgzK53yuIt+U3M5Vj6MjFXKEMTh3ic8DHSP4mbCaedrqxx4tILBM0zVknXBMtwS4znRPmk8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxgGhutZVUQ+zRaFufU5F76ULX9wjOv91cdsYiu2Zun66ro1wXr
	+U5wNOii/GuC3SyXzUdjLlhqR9XxVUmQn/n9pEHivgr6sGZXGMXH+YZd+FDEtRk6AtLXtaNI1V4
	+me8Oae/ubrrALJO4W38StH7mHcI=
X-Gm-Gg: ASbGncsP9Zsaw+dw4UWW+LAINcbbNOHUTpz3eNR/1h0CI988vhmsDevro2s7RqQ8QjC
	+U5E+hZrPnAvGNg/AoUHzBO1/Rg04ng3c0jBqQkp9Ri8cHJIsCZ9gfH0iVIvTgwUU
X-Google-Smtp-Source: AGHT+IHdwsPFXegfj/QMcPND1kvd7vgdT05elxSwKsFdMquj5tWyX9yUwkcpDh3RouMX1xVM80YyzhPqPt4Vkfi0rMc=
X-Received: by 2002:a05:6102:2ad0:b0:4af:5b9a:3350 with SMTP id
 ada2fe7eead31-4af971fce54mr8554874137.3.1733309139194; Wed, 04 Dec 2024
 02:45:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241204040158.2768519-1-chenridong@huaweicloud.com> <20241204040158.2768519-3-chenridong@huaweicloud.com>
In-Reply-To: <20241204040158.2768519-3-chenridong@huaweicloud.com>
From: Barry Song <21cnbao@gmail.com>
Date: Wed, 4 Dec 2024 23:45:28 +1300
Message-ID: <CAGsJ_4w83823wbqDHta6RGE_3VzHYpLTBDDbzX6sVEN=YSPEKw@mail.gmail.com>
Subject: Re: [RFC PATCH v3 2/2] mm: vmscan: retry folios written back while isolated
To: Chen Ridong <chenridong@huaweicloud.com>
Cc: akpm@linux-foundation.org, mhocko@suse.com, hannes@cmpxchg.org, 
	yosryahmed@google.com, yuzhao@google.com, david@redhat.com, 
	willy@infradead.org, ryan.roberts@arm.com, wangkefeng.wang@huawei.com, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, chenridong@huawei.com, 
	wangweiyang2@huawei.com, xieym_ict@hotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 4, 2024 at 5:11=E2=80=AFPM Chen Ridong <chenridong@huaweicloud.=
com> wrote:
>
> From: Chen Ridong <chenridong@huawei.com>
>
> An issue was found with the following testing step:
> 1. Compile with CONFIG_TRANSPARENT_HUGEPAGE=3Dy, CONFIG_LRU_GEN_ENABLED=
=3Dn.
> 2. Mount memcg v1, and create memcg named test_memcg and set
>    usage_in_bytes=3D2.1G, memsw.usage_in_bytes=3D3G.
> 3. Use file as swap, and create a 1G swap.
> 4. Allocate 2.2G anon memory in test_memcg.
>
> It was found that:
>
> cat memory.usage_in_bytes
> 2144940032
> cat memory.memsw.usage_in_bytes
> 2255056896
>
> free -h
>               total        used        free
> Mem:           31Gi       2.1Gi        27Gi
> Swap:         1.0Gi       618Mi       405Mi
>
> As shown above, the test_memcg used about 100M swap, but 600M+ swap memor=
y
> was used, which means that 500M may be wasted because other memcgs can no=
t
> use these swap memory.
>
> It can be explained as follows:
> 1. When entering shrink_inactive_list, it isolates folios from lru from
>    tail to head. If it just takes folioN from lru(make it simple).
>
>    inactive lru: folio1<->folio2<->folio3...<->folioN-1
>    isolated list: folioN
>
> 2. In shrink_page_list function, if folioN is THP(2M), it may be splited
>    and added to swap cache folio by folio. After adding to swap cache,
>    it will submit io to writeback folio to swap, which is asynchronous.
>    When shrink_page_list is finished, the isolated folios list will be
>    moved back to the head of inactive lru. The inactive lru may just look
>    like this, with 512 filioes have been move to the head of inactive lru=
.
>
>    folioN512<->folioN511<->...filioN1<->folio1<->folio2...<->folioN-1
>
>    It committed io from folioN1 to folioN512, the later folios committed
>    was added to head of the 'ret_folios' in the shrink_page_list function=
.
>    As a result, the order was shown as folioN512->folioN511->...->folioN1=
.
>
> 3. When folio writeback io is completed, the folio may be rotated to tail
>    of the lru one by one. It's assumed that filioN1,filioN2, ...,filioN51=
2
>    are completed in order(commit io in this order), and they are rotated =
to
>    the tail of the LRU in order (filioN1<->...folioN511<->folioN512).
>    Therefore, those folios that are tail of the lru will be reclaimed as
>    soon as possible.
>
>    folio1<->folio2<->...<->folioN-1<->filioN1<->...folioN511<->folioN512
>
> 4. However, shrink_page_list and folio writeback are asynchronous. If THP
>    is splited, shrink_page_list loops at least 512 times, which means tha=
t
>    shrink_page_list is not completed but some folios writeback have been
>    completed, and this may lead to failure to rotate these folios to the
>    tail of lru. The lru may look likes as below:
>
>    folioN50<->folioN49<->...filioN1<->folio1<->folio2...<->folioN-1<->
>    folioN51<->folioN52<->...folioN511<->folioN512
>
>    Although those folios (N1-N50) have been finished writing back, they
>    are still at the head of the lru. This is because their writeback_end
>    occurred while it were still looping in shrink_folio_list(), causing
>    folio_end_writeback()'s folio_rotate_reclaimable() to fail in moving
>    these folios, which are not in the LRU but still in the 'folio_list',
>    to the tail of the LRU.
>    When isolating folios from lru, it scans from tail to head, so it is
>    difficult to scan those folios again.

I don=E2=80=99t think it=E2=80=99s necessary to focus so much on large foli=
os. This
issue affects both small and large folios alike. Splitting large
folios simply lengthens the list, which increases the chances of
missing rotation. It=E2=80=99s enough to note that commit 359a5e1416ca
fixed this issue in mglru, but the same problem exists in the
active/inactive LRU. As a result, we=E2=80=99re extracting the function in
patch 1 to make it usable for both LRUs and applying the same fix
to the active/inactive LRU. Mentioning that THP splitting can
worsen the issue (since it makes the list longer) is sufficient;
it=E2=80=99s not the main point.

It=E2=80=99s better to have a single patch and refine the changelog to focu=
s on
the core and essential problem, avoiding too many unrelated details.

>
> This issue is fixed when CONFIG_LRU_GEN_ENABLED is enabled with the
> commit 359a5e1416ca ("mm: multi-gen LRU: retry folios written back while
> isolated"). This issue should be fixed for active/inactive lru in the
> same way.
>
> Signed-off-by: Chen Ridong <chenridong@huawei.com>
> ---
>  mm/vmscan.c | 35 +++++++++++++++++++++++++++++++++--
>  1 file changed, 33 insertions(+), 2 deletions(-)
>
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index af1ff76f83e7..1f0d194f8b2f 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -1949,6 +1949,25 @@ static int current_may_throttle(void)
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
> +
>  /*
>   * shrink_inactive_list() is a helper for shrink_node().  It returns the=
 number
>   * of reclaimed pages
> @@ -1958,14 +1977,16 @@ static unsigned long shrink_inactive_list(unsigne=
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
> @@ -1999,10 +2020,20 @@ static unsigned long shrink_inactive_list(unsigne=
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
> --
> 2.34.1
>

Thanks
Barry

