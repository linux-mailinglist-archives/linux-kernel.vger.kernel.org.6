Return-Path: <linux-kernel+bounces-373631-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 10F699A5996
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 06:44:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 85F3F1F21F18
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 04:44:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14C4C1940B2;
	Mon, 21 Oct 2024 04:44:18 +0000 (UTC)
Received: from mail-ua1-f50.google.com (mail-ua1-f50.google.com [209.85.222.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69DF164A
	for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 04:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729485857; cv=none; b=NVywqnnijsULd8xmA43TG1LZs2pMK8mNBOfSk0h/OWjBzVvVfVxWBLnTrHYWOmZeGkEDfJ9JDP3W+9WKjdkT6RQLFhZD/zUpkBqHvutGUj2HYqJtQ7Ps2vBBz1DJW9E110cgKbQtxYq2hwqWZobEEBVuyMs9tcl/TMAuzF8pZeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729485857; c=relaxed/simple;
	bh=0jT0JSpBQqM2s+K4ADprzXsQHVXFrLd1fUOjyjGl2d8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VqZbwpzOJk0Cywe9fvDw4XintbJOdhL7NBAqnHDC8ZeCuXTVEkOulxDZXLai2ksIJQE7hycwuubmDZ5Qfj5nsFIEdwQBNdYKicSjxCh64DdZM1y78zRdjbDOWNPduiasRl/1jjGR2M2I2c8A7gzAcKxy4oRoHz7KkNqWjU+wQs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f50.google.com with SMTP id a1e0cc1a2514c-84fc7b58d4dso1170525241.0
        for <linux-kernel@vger.kernel.org>; Sun, 20 Oct 2024 21:44:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729485854; x=1730090654;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m01RtHcH7jVqVjjekW1wmTbPRlfyOxXGbu4ESEnzxXo=;
        b=BA0BZExWCur3zKolRgUDJgv8awtQljyWZzltarfSwRTjfD5DAW/6o6j/T9VLLmiojf
         1KMQpA3f5Ceu5xOSRtQ9rdK1xaLQBprft6jp2JoO7pFD3MtlLYFhCpYREkStahRgMgwJ
         Hp0O5TzNAQP5NhxeyA0ZmMU9aA2aQ+tXMfrzY0M1zNO9+MHiklZbFf/Zho/B8cWzs5yw
         6Jy6FAmaL3fT6mCLkoCHhi3U6BKaOHQaOinEPCpzeZFz+ol6lUuCEEggBx9i6bwuhdyX
         Yz2HACMHRXQRjOTsVs4I4M/KnFWXigKMtyis/vFOBsUYUIaEOyT6miF8EE9oC4JpNiwx
         HJew==
X-Forwarded-Encrypted: i=1; AJvYcCXiFFu61vxbnwgYzcHyBQ618122sRxOL8Wv2D/XtcdRW0iUuXEx1w8IASYATlKUwSX53P6oLnroKvzPJv4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yya7ymgEFry6+dgvDqqNLKeBjxoW1WXpND6POmgYrX8nXT4gm+S
	VJSmSXZ47yNmW/cSKGnvCAP4slnLcEnQjUxPnma6C0cnj3p/MPGi/TIdsihGYDeAbeud2w+Cfcy
	AptbiMKwtYfrvijDfa3z6CneLBDU=
X-Google-Smtp-Source: AGHT+IGgeNOxeW2ojfo08suRiiHeAdMlxK3cKjG4ICyLsdNqgGmYc6WTwrOOEP3XWAxeEu1d4KqPB8m0VUKGVAz3zt4=
X-Received: by 2002:a05:6122:201e:b0:50d:7a14:ddf7 with SMTP id
 71dfb90a1353d-50dda3a0289mr7667931e0c.8.1729485853975; Sun, 20 Oct 2024
 21:44:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241010081802.290893-1-chenridong@huaweicloud.com>
 <c3f2c5e2-4804-46e8-86ff-1f6a79ea9a7c@huawei.com> <CAGsJ_4zR+=80S_Fz1ZV3iZxjVKUE3-f32w7W1smuAgZM=HrPRQ@mail.gmail.com>
 <62bd2564-76fa-4cb0-9c08-9eb2f96771b6@huawei.com>
In-Reply-To: <62bd2564-76fa-4cb0-9c08-9eb2f96771b6@huawei.com>
From: Barry Song <baohua@kernel.org>
Date: Mon, 21 Oct 2024 17:44:03 +1300
Message-ID: <CAGsJ_4x=nqKFMqDmfmvXVAhQNTo1Fx-aQ2MoSKSGQrSCccqr3Q@mail.gmail.com>
Subject: Re: [PATCH v3] mm/vmscan: stop the loop if enough pages have been page_out
To: chenridong <chenridong@huawei.com>
Cc: Kefeng Wang <wangkefeng.wang@huawei.com>, Chen Ridong <chenridong@huaweicloud.com>, 
	akpm@linux-foundation.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	wangweiyang2@huawei.com, Michal Hocko <mhocko@suse.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, Yosry Ahmed <yosryahmed@google.com>, Yu Zhao <yuzhao@google.com>, 
	David Hildenbrand <david@redhat.com>, Matthew Wilcox <willy@infradead.org>, 
	Ryan Roberts <ryan.roberts@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 11, 2024 at 7:49=E2=80=AFPM chenridong <chenridong@huawei.com> =
wrote:
>
>
>
> On 2024/10/11 0:17, Barry Song wrote:
> > On Thu, Oct 10, 2024 at 4:59=E2=80=AFPM Kefeng Wang <wangkefeng.wang@hu=
awei.com> wrote:
> >>
> >> Hi Ridong,
> >>
> >> This should be the first version for upstream, and the issue only
> >> occurred when large folio is spited.
> >>
> >> Adding more CCs to see if there's more feedback.
> >>
> >>
> >> On 2024/10/10 16:18, Chen Ridong wrote:
> >>> From: Chen Ridong <chenridong@huawei.com>
> >>>
> >>> An issue was found with the following testing step:
> >>> 1. Compile with CONFIG_TRANSPARENT_HUGEPAGE=3Dy
> >>> 2. Mount memcg v1, and create memcg named test_memcg and set
> >>>      usage_in_bytes=3D2.1G, memsw.usage_in_bytes=3D3G.
> >>> 3. Create a 1G swap file, and allocate 2.2G anon memory in test_memcg=
.
> >>>
> >>> It was found that:
> >>>
> >>> cat memory.usage_in_bytes
> >>> 2144940032
> >>> cat memory.memsw.usage_in_bytes
> >>> 2255056896
> >>>
> >>> free -h
> >>>                 total        used        free
> >>> Mem:           31Gi       2.1Gi        27Gi
> >>> Swap:         1.0Gi       618Mi       405Mi
> >>>
> >>> As shown above, the test_memcg used about 100M swap, but 600M+ swap m=
emory
> >>> was used, which means that 500M may be wasted because other memcgs ca=
n not
> >>> use these swap memory.
> >>>
> >>> It can be explained as follows:
> >>> 1. When entering shrink_inactive_list, it isolates folios from lru fr=
om
> >>>      tail to head. If it just takes folioN from lru(make it simple).
> >>>
> >>>      inactive lru: folio1<->folio2<->folio3...<->folioN-1
> >>>      isolated list: folioN
> >>>
> >>> 2. In shrink_page_list function, if folioN is THP, it may be splited =
and
> >>>      added to swap cache folio by folio. After adding to swap cache, =
it will
> >>>      submit io to writeback folio to swap, which is asynchronous.
> >>>      When shrink_page_list is finished, the isolated folios list will=
 be
> >>>      moved back to the head of inactive lru. The inactive lru may jus=
t look
> >>>      like this, with 512 filioes have been move to the head of inacti=
ve lru.
> >>>
> >>>      folioN512<->folioN511<->...filioN1<->folio1<->folio2...<->folioN=
-1
> >>>
> >>> 3. When folio writeback io is completed, the folio may be rotated to =
tail
> >>>      of lru. The following lru list is expected, with those filioes t=
hat have
> >>>      been added to swap cache are rotated to tail of lru. So those fo=
lios
> >>>      can be reclaimed as soon as possible.
> >>>
> >>>      folio1<->folio2<->...<->folioN-1<->filioN1<->...folioN511<->foli=
oN512
> >>>
> >>> 4. However, shrink_page_list and folio writeback are asynchronous. If=
 THP
> >>>      is splited, shrink_page_list loops at least 512 times, which mea=
ns that
> >>>      shrink_page_list is not completed but some folios writeback have=
 been
> >>>      completed, and this may lead to failure to rotate these folios t=
o the
> >>>      tail of lru. The lru may look likes as below:
> >
> > I assume you=E2=80=99re referring to PMD-mapped THP, but your code also=
 modifies
> > mTHP, which might not be that large. For instance, it could be a 16KB m=
THP.
> >
> >>>
> >>>      folioN50<->folioN49<->...filioN1<->folio1<->folio2...<->folioN-1=
<->
> >>>      folioN51<->folioN52<->...folioN511<->folioN512
> >>>
> >>>      Although those folios (N1-N50) have been finished writing back, =
they
> >>>      are still at the head of lru. When isolating folios from lru, it=
 scans
> >>>      from tail to head, so it is difficult to scan those folios again=
.
> >>>
> >>> What mentioned above may lead to a large number of folios have been a=
dded
> >>> to swap cache but can not be reclaimed in time, which may reduce recl=
aim
> >>> efficiency and prevent other memcgs from using this swap memory even =
if
> >>> they trigger OOM.
> >>>
> >>> To fix this issue, it's better to stop looping if THP has been splite=
d and
> >>> nr_pageout is greater than nr_to_reclaim.
> >>>
> >>> Signed-off-by: Chen Ridong <chenridong@huawei.com>
> >>> ---
> >>>    mm/vmscan.c | 16 +++++++++++++++-
> >>>    1 file changed, 15 insertions(+), 1 deletion(-)
> >>>
> >>> diff --git a/mm/vmscan.c b/mm/vmscan.c
> >>> index 749cdc110c74..fd8ad251eda2 100644
> >>> --- a/mm/vmscan.c
> >>> +++ b/mm/vmscan.c
> >>> @@ -1047,7 +1047,7 @@ static unsigned int shrink_folio_list(struct li=
st_head *folio_list,
> >>>        LIST_HEAD(demote_folios);
> >>>        unsigned int nr_reclaimed =3D 0;
> >>>        unsigned int pgactivate =3D 0;
> >>> -     bool do_demote_pass;
> >>> +     bool do_demote_pass, splited =3D false;
> >>>        struct swap_iocb *plug =3D NULL;
> >>>
> >>>        folio_batch_init(&free_folios);
> >>> @@ -1065,6 +1065,16 @@ static unsigned int shrink_folio_list(struct l=
ist_head *folio_list,
> >>>
> >>>                cond_resched();
> >>>
> >>> +             /*
> >>> +              * If a large folio has been split, many folios are add=
ed
> >>> +              * to folio_list. Looping through the entire list takes
> >>> +              * too much time, which may prevent folios that have co=
mpleted
> >>> +              * writeback from rotateing to the tail of the lru. Jus=
t
> >>> +              * stop looping if nr_pageout is greater than nr_to_rec=
laim.
> >>> +              */
> >>> +             if (unlikely(splited && stat->nr_pageout > sc->nr_to_re=
claim))
> >>> +                     break;
> >
> > I=E2=80=99m not entirely sure about the theory behind comparing stat->n=
r_pageout
> > with sc->nr_to_reclaim. However, the condition might still hold true ev=
en
> > if you=E2=80=99ve split a relatively small =E2=80=9Clarge folio,=E2=80=
=9D such as 16kB?
> >
>
> Why compare stat->nr_pageout with sc->nr_to_reclaim? It's because if all
> pages that have been pageout can be reclaimed, then enough pages can be
> reclaimed when all pages have finished writeback. Thus, it may not have
> to pageout more.
>
> If a small large folio(16 kB) has been split, it may return early
> without the entire pages in the folio_list being pageout, but I think
> that is fine. It can pageout more pages the next time it enters
> shrink_folio_list if there are not enough pages to reclaimed.
>
> However, if pages that have been pageout are still at the head of the
> LRU, it is difficult to scan these pages again. In this case, not only
> might it "waste" some swap memory but it also has to pageout more pages.
>
> Considering the above, I sent this patch. It may not be a perfect
> solution, but i think it's a good option to consider. And I am wondering
> if anyone has a better solution.

Hi Ridong,
My overall understanding is that you have failed to describe your problem
particularly I don't understand what your 3 and 4 mean:

> 3. When folio writeback io is completed, the folio may be rotated to tail
>    of lru. The following lru list is expected, with those filioes that ha=
ve
>    been added to swap cache are rotated to tail of lru. So those folios
>  can be reclaimed as soon as possible.
>
>  folio1<->folio2<->...<->folioN-1<->filioN1<->...folioN511<->folioN512

 > 4. However, shrink_page_list and folio writeback are asynchronous. If TH=
P
 >    is splited, shrink_page_list loops at least 512 times, which means th=
at
 >    shrink_page_list is not completed but some folios writeback have been
 >    completed, and this may lead to failure to rotate these folios to the
  >  tail of lru. The lru may look likes as below:

can you please describe it in a readable approach?

i feel your below diagram is somehow wrong:
folio1<->folio2<->...<->folioN-1<->filioN1<->...folioN511<->folioN512

You mentioned "rotate', how could "rotate" makes:
folioN512<->folioN511<->...filioN1 in (2)
become
filioN1<->...folioN511<->folioN512 in (3).

btw, writeback isn't always async. it could be sync for zram and sync_io
swap. in that case, your patch might change the order of LRU. i mean,
for example, while a mTHP becomes cold, we always reclaim all of them,
but not part of them and put back part of small folios to the head of lru.

>
> Best regards,
> Ridong
>
> >>> +
> >>>                folio =3D lru_to_folio(folio_list);
> >>>                list_del(&folio->lru);
> >>>
> >>> @@ -1273,6 +1283,7 @@ static unsigned int shrink_folio_list(struct li=
st_head *folio_list,
> >>>                if ((nr_pages > 1) && !folio_test_large(folio)) {
> >>>                        sc->nr_scanned -=3D (nr_pages - 1);
> >>>                        nr_pages =3D 1;
> >>> +                     splited =3D true;
> >>>                }
> >>>
> >>>                /*
> >>> @@ -1375,12 +1386,14 @@ static unsigned int shrink_folio_list(struct =
list_head *folio_list,
> >>>                                if (nr_pages > 1 && !folio_test_large(=
folio)) {
> >>>                                        sc->nr_scanned -=3D (nr_pages =
- 1);
> >>>                                        nr_pages =3D 1;
> >>> +                                     splited =3D true;
> >>>                                }
> >>>                                goto activate_locked;
> >>>                        case PAGE_SUCCESS:
> >>>                                if (nr_pages > 1 && !folio_test_large(=
folio)) {
> >>>                                        sc->nr_scanned -=3D (nr_pages =
- 1);
> >>>                                        nr_pages =3D 1;
> >>> +                                     splited =3D true;
> >>>                                }
> >>>                                stat->nr_pageout +=3D nr_pages;
> >>>
> >>> @@ -1491,6 +1504,7 @@ static unsigned int shrink_folio_list(struct li=
st_head *folio_list,
> >>>                if (nr_pages > 1) {
> >>>                        sc->nr_scanned -=3D (nr_pages - 1);
> >>>                        nr_pages =3D 1;
> >>> +                     splited =3D true;
> >>>                }
> >>>    activate_locked:
> >>>                /* Not a candidate for swapping, so reclaim swap space=
. */
> >>
>

Thanks
barry

