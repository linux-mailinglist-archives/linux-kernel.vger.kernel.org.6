Return-Path: <linux-kernel+bounces-411975-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F8AD9D01ED
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Nov 2024 04:26:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7B4D1B2459C
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Nov 2024 03:26:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B48A2DF60;
	Sun, 17 Nov 2024 03:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZckEyvAs"
Received: from mail-ua1-f42.google.com (mail-ua1-f42.google.com [209.85.222.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06BFD7E9
	for <linux-kernel@vger.kernel.org>; Sun, 17 Nov 2024 03:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731814004; cv=none; b=fWZs2PTWaznHacNZFIPH76r65e69VjBG8J6bNrdRlxp10bpTJ4YWIsvSvPcK3G4107zom7q2vCT21IJVY05ycC5a146tRj2hfzylRkvnlKb2VPDsX5WFznb+11e2uSix8j1QMSUX5tbwdqdG6VyzAxw5zpYq0qvNFw1pQfbvfpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731814004; c=relaxed/simple;
	bh=aMhEiNW0XG9a9n15y1JrtYKMSGSHJiRVO+5p2nuFxiw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FrvAkqz7UFCGgyy9/JFTwc/x3FkSS08rEauzTypRcfVKQ6OaliGpnXGdjV3gvLIR+isRA/PFzu9VgNsFBFiRA3EJjlQrNms/h2lhRLLdhEQbeN9nHkTgg1OA/wlZctq/5XdZe2LpAoCH0gLNIG2Vy6rNWdmu0ZShMUgfAWTMejY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZckEyvAs; arc=none smtp.client-ip=209.85.222.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f42.google.com with SMTP id a1e0cc1a2514c-85700242ca1so169108241.0
        for <linux-kernel@vger.kernel.org>; Sat, 16 Nov 2024 19:26:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731814002; x=1732418802; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h3HZNDghnUw69Fh7P2VlawROtSkACLEvtCtaigDJRCQ=;
        b=ZckEyvAsxkwoRHjWS2q2ft4yokWG2Ed0jwRe1sPgmMmoQHfT6dudRmycbECbwHTPFF
         uzoaaczXb/x8LBWixE/Xf+KFSLlE3XuFzt7nEjA8qgFq4hgajBj0YvLwwNfFc8w9LJEr
         GbC55ZYWaqCGfbkUrlo+rbW8GxV/OGoZa4//TuCcZ+F8rMOjtxNnx8vqTFDX/8ACJgZZ
         s79POSzapmpgGIPs3WNUOj1kqmQjEROIw8QtwIwXpUcZVFYe5JbXNX8DadnUeL+1MzS5
         QfP3Ka3w6UihgMrHWpaoxDSSBW07U9jeVriI15wGlQI5Yq4fghPQ6uegA682rNipKwcW
         dnYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731814002; x=1732418802;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h3HZNDghnUw69Fh7P2VlawROtSkACLEvtCtaigDJRCQ=;
        b=MoDWkGVVULHlgZoVcWaXRIL8NG9QFB0GvIY7z1Zl0M/nFqyrjwdspkkCTwI6dUgd4T
         G4Rdkhz1rqfeTo3O+e2nxqml5Bkbmn5V+dQjBVSmuWNPPpUcHoJlbGKw4J5iwItw00wt
         5KOgNyz65GXiMiQmVQ4v0j9oXg2DCnVDXM2g32wijxE8s51cdxSMVbAh7rjFdEvEnIbw
         ZC9y8gmgkVEmIK9K7TkrTM1yVA96f664+4J2g8vZjtEMgPQmEZAkxrJesNPFPeNvcLzt
         2ijWHY7CPC6Na/XB0ZJYK2Df7zPkN2Mwd9ORJEXkgR0Cf8GTwugSJeiJtzChyV/7sGeT
         EWdw==
X-Forwarded-Encrypted: i=1; AJvYcCUazQfnSD0Db/w/7Ksoj8ngEDS2Yr6SblxP3nuPoCYOLzTc6O6QY86+sRifL+3ksXRky0D+OdB85pXOuNA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzY6MELPPwIStua3oNOZ+c7gADIfkPyaOG1Gp6BZpe5JfMF3c47
	sFMSo6O7UCs522hYRK2Yja5VOncWR5bKAIskDww5l+WtoniBetwbl5C8UuZElsoKau/kNYqnMr/
	fzsCdJwhcH7vntamBRGfpRBh4MEY=
X-Google-Smtp-Source: AGHT+IGT2F+YPc+DD3ZP4CLx6U2+XhG+QANRVdIermr92rMRisFrRNjweCep+S0cP94n26NM1PbnuGrvwNgJrF1/Cuk=
X-Received: by 2002:a05:6102:38ce:b0:4ad:4bc2:7efd with SMTP id
 ada2fe7eead31-4ad62ba9defmr6723776137.10.1731814001708; Sat, 16 Nov 2024
 19:26:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241116091658.1983491-1-chenridong@huaweicloud.com> <20241116091658.1983491-2-chenridong@huaweicloud.com>
In-Reply-To: <20241116091658.1983491-2-chenridong@huaweicloud.com>
From: Barry Song <21cnbao@gmail.com>
Date: Sun, 17 Nov 2024 16:26:30 +1300
Message-ID: <CAGsJ_4zdVyxh4ka7q8PA2Wi_ZPpjY_sv_bGS9E9NP_vpAFLOHg@mail.gmail.com>
Subject: Re: [RFC PATCH v2 1/1] mm/vmscan: move the written-back folios to the
 tail of LRU after shrinking
To: Chen Ridong <chenridong@huaweicloud.com>
Cc: akpm@linux-foundation.org, mhocko@suse.com, hannes@cmpxchg.org, 
	yosryahmed@google.com, yuzhao@google.com, david@redhat.com, 
	willy@infradead.org, ryan.roberts@arm.com, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, chenridong@huawei.com, wangweiyang2@huawei.com, 
	xieym_ict@hotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 16, 2024 at 10:26=E2=80=AFPM Chen Ridong <chenridong@huaweiclou=
d.com> wrote:
>
> From: Chen Ridong <chenridong@huawei.com>
>
> An issue was found with the following testing step:
> 1. Compile with CONFIG_TRANSPARENT_HUGEPAGE=3Dy
> 2. Mount memcg v1, and create memcg named test_memcg and set
>    usage_in_bytes=3D2.1G, memsw.usage_in_bytes=3D3G.
> 3. Create a 1G swap file, and allocate 2.2G anon memory in test_memcg.
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
>
> What mentioned above may lead to a large number of folios have been added
> to swap cache but can not be reclaimed in time, which may reduce reclaim
> efficiency and prevent other memcgs from using this swap memory even if
> they trigger OOM.
>
> To fix this issue, the folios whose writeback has been completed should b=
e
> move to the tail of the LRU instead of always placing them at the head of
> the LRU when the shrink_page_list is finished. It can be realized by
> following steps.
> 1. In the shrink_page_list function, the folios whose are committed to

It seems like there's a grammatical error here=E2=80=94whose something=EF=
=BC=9F

>    are added to the head of 'folio_list', which will be return to the
>    caller.
> 2. When shrink_page_list finishes, it is known that how many folios have
>    been pageout, and they are all at the head of 'folio_list', which is
>    ready be moved back to LRU. So, in the 'move_folios_to_lru function'
>    function, if the first 'nr_io' folios (which have been pageout) have
>    been written back completely, move them to the tail of LRU. Otherwise,
>    move them to the head of the LRU.
>
> Signed-off-by: Chen Ridong <chenridong@huawei.com>
> ---
>  mm/vmscan.c | 37 +++++++++++++++++++++++++++++--------
>  1 file changed, 29 insertions(+), 8 deletions(-)
>
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index 76378bc257e3..04f7eab9d818 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -1046,6 +1046,7 @@ static unsigned int shrink_folio_list(struct list_h=
ead *folio_list,
>         struct folio_batch free_folios;
>         LIST_HEAD(ret_folios);
>         LIST_HEAD(demote_folios);
> +       LIST_HEAD(pageout_folios);
>         unsigned int nr_reclaimed =3D 0;
>         unsigned int pgactivate =3D 0;
>         bool do_demote_pass;
> @@ -1061,7 +1062,7 @@ static unsigned int shrink_folio_list(struct list_h=
ead *folio_list,
>                 struct address_space *mapping;
>                 struct folio *folio;
>                 enum folio_references references =3D FOLIOREF_RECLAIM;
> -               bool dirty, writeback;
> +               bool dirty, writeback, is_pageout =3D false;
>                 unsigned int nr_pages;
>
>                 cond_resched();
> @@ -1384,6 +1385,7 @@ static unsigned int shrink_folio_list(struct list_h=
ead *folio_list,
>                                         nr_pages =3D 1;
>                                 }
>                                 stat->nr_pageout +=3D nr_pages;
> +                               is_pageout =3D true;
>
>                                 if (folio_test_writeback(folio))
>                                         goto keep;
> @@ -1508,7 +1510,10 @@ static unsigned int shrink_folio_list(struct list_=
head *folio_list,
>  keep_locked:
>                 folio_unlock(folio);
>  keep:
> -               list_add(&folio->lru, &ret_folios);
> +               if (is_pageout)
> +                       list_add(&folio->lru, &pageout_folios);
> +               else
> +                       list_add(&folio->lru, &ret_folios);
>                 VM_BUG_ON_FOLIO(folio_test_lru(folio) ||
>                                 folio_test_unevictable(folio), folio);
>         }
> @@ -1551,6 +1556,7 @@ static unsigned int shrink_folio_list(struct list_h=
ead *folio_list,
>         free_unref_folios(&free_folios);
>
>         list_splice(&ret_folios, folio_list);
> +       list_splice(&pageout_folios, folio_list);

Do we really need this pageout_folios list? is the below not sufficient?

 +               if (nr_io > 0 &&
 +                   !folio_test_reclaim(folio) &&
 +                   !folio_test_writeback(folio))
 +                       lruvec_add_folio_tail(lruvec, folio);
 +               else
 +                       lruvec_add_folio(lruvec, folio);

>         count_vm_events(PGACTIVATE, pgactivate);
>
>         if (plug)
> @@ -1826,11 +1832,14 @@ static bool too_many_isolated(struct pglist_data =
*pgdat, int file,
>
>  /*
>   * move_folios_to_lru() moves folios from private @list to appropriate L=
RU list.
> + * @lruvec: The LRU vector the list is moved to.
> + * @list: The folio list are moved to lruvec
> + * @nr_io: The first nr folios of the list that have been committed io.
>   *
>   * Returns the number of pages moved to the given lruvec.
>   */
>  static unsigned int move_folios_to_lru(struct lruvec *lruvec,
> -               struct list_head *list)
> +               struct list_head *list, unsigned int nr_io)
>  {
>         int nr_pages, nr_moved =3D 0;
>         struct folio_batch free_folios;
> @@ -1880,9 +1889,21 @@ static unsigned int move_folios_to_lru(struct lruv=
ec *lruvec,
>                  * inhibits memcg migration).
>                  */
>                 VM_BUG_ON_FOLIO(!folio_matches_lruvec(folio, lruvec), fol=
io);
> -               lruvec_add_folio(lruvec, folio);
> +               /*
> +                * If the folio have been committed io and writed back co=
mpletely,
> +                * it should be added to the tailed to the lru, so it can
> +                * be relaimed as soon as possible.
> +                */
> +               if (nr_io > 0 &&
> +                   !folio_test_reclaim(folio) &&
> +                   !folio_test_writeback(folio))
> +                       lruvec_add_folio_tail(lruvec, folio);
> +               else
> +                       lruvec_add_folio(lruvec, folio);
> +
>                 nr_pages =3D folio_nr_pages(folio);
>                 nr_moved +=3D nr_pages;
> +               nr_io =3D nr_io > nr_pages ? (nr_io - nr_pages) : 0;
>                 if (folio_test_active(folio))
>                         workingset_age_nonresident(lruvec, nr_pages);
>         }
> @@ -1960,7 +1981,7 @@ static unsigned long shrink_inactive_list(unsigned =
long nr_to_scan,
>         nr_reclaimed =3D shrink_folio_list(&folio_list, pgdat, sc, &stat,=
 false);
>
>         spin_lock_irq(&lruvec->lru_lock);
> -       move_folios_to_lru(lruvec, &folio_list);
> +       move_folios_to_lru(lruvec, &folio_list, stat.nr_pageout);
>
>         __mod_lruvec_state(lruvec, PGDEMOTE_KSWAPD + reclaimer_offset(),
>                                         stat.nr_demoted);
> @@ -2111,8 +2132,8 @@ static void shrink_active_list(unsigned long nr_to_=
scan,
>          */
>         spin_lock_irq(&lruvec->lru_lock);
>
> -       nr_activate =3D move_folios_to_lru(lruvec, &l_active);
> -       nr_deactivate =3D move_folios_to_lru(lruvec, &l_inactive);
> +       nr_activate =3D move_folios_to_lru(lruvec, &l_active, 0);
> +       nr_deactivate =3D move_folios_to_lru(lruvec, &l_inactive, 0);
>
>         __count_vm_events(PGDEACTIVATE, nr_deactivate);
>         __count_memcg_events(lruvec_memcg(lruvec), PGDEACTIVATE, nr_deact=
ivate);
> @@ -4627,7 +4648,7 @@ static int evict_folios(struct lruvec *lruvec, stru=
ct scan_control *sc, int swap
>
>         spin_lock_irq(&lruvec->lru_lock);
>
> -       move_folios_to_lru(lruvec, &list);
> +       move_folios_to_lru(lruvec, &list, 0);

I'm not entirely convinced about using the 'nr' argument here.
Is the goal to differentiate between two cases?
1. we need to take care of written-back folios
2. we don't need to take care of written-back folios?

Would it be a bool or better to provide separate helpers?

>
>         walk =3D current->reclaim_state->mm_walk;
>         if (walk && walk->batched) {
> --
> 2.34.1
>

Thanks
Barry

