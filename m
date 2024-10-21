Return-Path: <linux-kernel+bounces-374136-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24FC19A6575
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 12:57:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2F121B2FEA3
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 10:52:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B3F839FD6;
	Mon, 21 Oct 2024 10:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HEjN4v1w"
Received: from mail-vk1-f175.google.com (mail-vk1-f175.google.com [209.85.221.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46E7B1E884F
	for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 10:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729507573; cv=none; b=MjB8CwXOAbq9wxnCPdElC0zTQfiqJwACjFFs8DeGWW4IudgLJAKm0HUdZclHRSW7VWW5QLSfXndI0WmaWdCJ7+LsSVicRVY7wepJiQGNzDkp289Xax4EMFGqMpql5OcKawPK+VIA+up4TAWIhOeZ+SUdobLnLjd7x9g+n6vGFbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729507573; c=relaxed/simple;
	bh=BzAoNiJpOKGRfJOQy/8kIsygsxYKURKZAP14gWBxLYE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iimhQg2U7FuKWZmkNTBeQ+7VkXj2Lkwl5m7z1CodJxLUYz8cRMEDlYvJkRpwUxIhlIcWINS7xuHIRiuVvch4VZPvzgzKuvW+Ysf2T+mTML9DJy64nZ/MksFkEhNTv5HnEYLGbkK+VLq8/07Bol5jVtpFFXDQVWFvx2JvCQCFpX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HEjN4v1w; arc=none smtp.client-ip=209.85.221.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f175.google.com with SMTP id 71dfb90a1353d-50d4797098dso1373138e0c.3
        for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 03:46:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729507570; x=1730112370; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BhEoGd/s6ygWjnSvhBS32BfDo9PvsTAZAJStsreblOE=;
        b=HEjN4v1weyFw9ycq0gEkRIj8r0eEwVO9kSO3AvjFp5lbbtmzzF1EKBidzWWQpMobMZ
         Vnp1WWaHYlftmShqjFGbvmuktuF8Tyop5NUEHy8hKvy6IaWBqtBBrtsiMw/QcbwKZnKD
         tpTzFdnigIwsHiUGSeHR419MmV3A9YYM4Pd7c38Yq5tsibk0wNnfhoi09pIUz11zfXNt
         e7tvFoNoaMmxNQ7kbkfIgVuJnZ1KY1AxtZvnnBfRvx/PYqvcmMu97D8AdrJ06yp1Tn7o
         SatT0Htk3s+Q3o60I4MG+ZyVbw5AYZG83MHIbT8J9FO5yLTj8PHcro6ztSSB0cNlPIcc
         T82g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729507570; x=1730112370;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BhEoGd/s6ygWjnSvhBS32BfDo9PvsTAZAJStsreblOE=;
        b=TumxCwGtAxyN6ksh/eBGbV1KGrj27AzLOj3fWFafOoDuV/7O9QbJHgZfIKtuK5aniM
         mPe9mEukAW7cE7fJKsyD5UMEI93AAYq25I/Zr2G6laCRR3qmnzMrmH0lqC8VAlyTAe4n
         6YpM3Buwa5df5rEy93tE52czJzsbPbHokrbIa+h4hLtei0m2dauuMo5WQA0g8yMAGbc7
         dxHDaZ0uHbEol/c6UeD/F+3uEJzEUll9w9abW+vxYtnDms2slwOVYsaewV4f+5skO3Qu
         sTyrp7ZkR+5MH4RrS2vqrCcABMJBipObpIRBoUXmE/Tqsv7qWhZv6fatRsvQ8xG4IdxZ
         LftQ==
X-Forwarded-Encrypted: i=1; AJvYcCVS4E820MUxUVgmELDM7TtfGscjrQMmIBTHcxE+vBNkg5d9e9Bmz++qHgkflT/c03/uBEmWWWUWhqrfVCA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yymt/45jkT03XXbv8WWFcBz+1KxgSpqbChACKksm8YHSha3hNXU
	Dj5UEtLfdMigRNx6fDtZl/sT+uw+KeINhyQssvgYTTelyX2fAnu8eMlMqkNwowSXTmsck8nlRbf
	gxgZbdpz13FV+tDxYUai9T0NsFhE=
X-Google-Smtp-Source: AGHT+IGXZKPZN28R8jIvU8ZZ85JZGucUR+bg/y84MtAP/i0l6oszSmR9MPPM02pCuQHBz1fzNRu5CdQ8jffuvjQoxu0=
X-Received: by 2002:a05:6122:926:b0:50d:5095:f02b with SMTP id
 71dfb90a1353d-50dd9872d66mr7994355e0c.0.1729507569914; Mon, 21 Oct 2024
 03:46:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241010081802.290893-1-chenridong@huaweicloud.com>
 <c3f2c5e2-4804-46e8-86ff-1f6a79ea9a7c@huawei.com> <CAGsJ_4zR+=80S_Fz1ZV3iZxjVKUE3-f32w7W1smuAgZM=HrPRQ@mail.gmail.com>
 <62bd2564-76fa-4cb0-9c08-9eb2f96771b6@huawei.com> <CAGsJ_4x=nqKFMqDmfmvXVAhQNTo1Fx-aQ2MoSKSGQrSCccqr3Q@mail.gmail.com>
 <28b3eae5-92e7-471f-9883-d03684e06d1b@huaweicloud.com> <CAGsJ_4yx8Z2w=FbBCUHtDa-=jDVDcdsBAHu26-LNeuOuquoOmg@mail.gmail.com>
 <c85a035b-70d2-47df-b2c3-db255c98f6ff@huawei.com> <CAGsJ_4yfpPoEnR2DOGcytEe0Xzuhq05W8Ncrb=z7OZ_icdWAww@mail.gmail.com>
In-Reply-To: <CAGsJ_4yfpPoEnR2DOGcytEe0Xzuhq05W8Ncrb=z7OZ_icdWAww@mail.gmail.com>
From: Barry Song <21cnbao@gmail.com>
Date: Mon, 21 Oct 2024 23:45:58 +1300
Message-ID: <CAGsJ_4z9YqZ0-KFfOMrSXZyt7QEeCp4MF1zLEXdzRNGJGnPqQA@mail.gmail.com>
Subject: Re: [PATCH v3] mm/vmscan: stop the loop if enough pages have been page_out
To: chenridong <chenridong@huawei.com>
Cc: Chen Ridong <chenridong@huaweicloud.com>, Kefeng Wang <wangkefeng.wang@huawei.com>, 
	akpm@linux-foundation.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	wangweiyang2@huawei.com, Michal Hocko <mhocko@suse.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, Yosry Ahmed <yosryahmed@google.com>, Yu Zhao <yuzhao@google.com>, 
	David Hildenbrand <david@redhat.com>, Matthew Wilcox <willy@infradead.org>, 
	Ryan Roberts <ryan.roberts@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 21, 2024 at 11:09=E2=80=AFPM Barry Song <21cnbao@gmail.com> wro=
te:
>
> On Mon, Oct 21, 2024 at 10:56=E2=80=AFPM chenridong <chenridong@huawei.co=
m> wrote:
> >
> >
> >
> > On 2024/10/21 17:42, Barry Song wrote:
> > > On Mon, Oct 21, 2024 at 9:14=E2=80=AFPM Chen Ridong <chenridong@huawe=
icloud.com> wrote:
> > >>
> > >>
> > >>
> > >> On 2024/10/21 12:44, Barry Song wrote:
> > >>> On Fri, Oct 11, 2024 at 7:49=E2=80=AFPM chenridong <chenridong@huaw=
ei.com> wrote:
> > >>>>
> > >>>>
> > >>>>
> > >>>> On 2024/10/11 0:17, Barry Song wrote:
> > >>>>> On Thu, Oct 10, 2024 at 4:59=E2=80=AFPM Kefeng Wang <wangkefeng.w=
ang@huawei.com> wrote:
> > >>>>>>
> > >>>>>> Hi Ridong,
> > >>>>>>
> > >>>>>> This should be the first version for upstream, and the issue onl=
y
> > >>>>>> occurred when large folio is spited.
> > >>>>>>
> > >>>>>> Adding more CCs to see if there's more feedback.
> > >>>>>>
> > >>>>>>
> > >>>>>> On 2024/10/10 16:18, Chen Ridong wrote:
> > >>>>>>> From: Chen Ridong <chenridong@huawei.com>
> > >>>>>>>
> > >>>>>>> An issue was found with the following testing step:
> > >>>>>>> 1. Compile with CONFIG_TRANSPARENT_HUGEPAGE=3Dy
> > >>>>>>> 2. Mount memcg v1, and create memcg named test_memcg and set
> > >>>>>>>      usage_in_bytes=3D2.1G, memsw.usage_in_bytes=3D3G.
> > >>>>>>> 3. Create a 1G swap file, and allocate 2.2G anon memory in test=
_memcg.
> > >>>>>>>
> > >>>>>>> It was found that:
> > >>>>>>>
> > >>>>>>> cat memory.usage_in_bytes
> > >>>>>>> 2144940032
> > >>>>>>> cat memory.memsw.usage_in_bytes
> > >>>>>>> 2255056896
> > >>>>>>>
> > >>>>>>> free -h
> > >>>>>>>                 total        used        free
> > >>>>>>> Mem:           31Gi       2.1Gi        27Gi
> > >>>>>>> Swap:         1.0Gi       618Mi       405Mi
> > >>>>>>>
> > >>>>>>> As shown above, the test_memcg used about 100M swap, but 600M+ =
swap memory
> > >>>>>>> was used, which means that 500M may be wasted because other mem=
cgs can not
> > >>>>>>> use these swap memory.
> > >>>>>>>
> > >>>>>>> It can be explained as follows:
> > >>>>>>> 1. When entering shrink_inactive_list, it isolates folios from =
lru from
> > >>>>>>>      tail to head. If it just takes folioN from lru(make it sim=
ple).
> > >>>>>>>
> > >>>>>>>      inactive lru: folio1<->folio2<->folio3...<->folioN-1
> > >>>>>>>      isolated list: folioN
> > >>>>>>>
> > >>>>>>> 2. In shrink_page_list function, if folioN is THP, it may be sp=
lited and
> > >>>>>>>      added to swap cache folio by folio. After adding to swap c=
ache, it will
> > >>>>>>>      submit io to writeback folio to swap, which is asynchronou=
s.
> > >>>>>>>      When shrink_page_list is finished, the isolated folios lis=
t will be
> > >>>>>>>      moved back to the head of inactive lru. The inactive lru m=
ay just look
> > >>>>>>>      like this, with 512 filioes have been move to the head of =
inactive lru.
> > >>>>>>>
> > >>>>>>>      folioN512<->folioN511<->...filioN1<->folio1<->folio2...<->=
folioN-1
> > >>>>>>>
> > >>>>>>> 3. When folio writeback io is completed, the folio may be rotat=
ed to tail
> > >>>>>>>      of lru. The following lru list is expected, with those fil=
ioes that have
> > >>>>>>>      been added to swap cache are rotated to tail of lru. So th=
ose folios
> > >>>>>>>      can be reclaimed as soon as possible.
> > >>>>>>>
> > >>>>>>>      folio1<->folio2<->...<->folioN-1<->filioN1<->...folioN511<=
->folioN512
> > >>>>>>>
> > >>>>>>> 4. However, shrink_page_list and folio writeback are asynchrono=
us. If THP
> > >>>>>>>      is splited, shrink_page_list loops at least 512 times, whi=
ch means that
> > >>>>>>>      shrink_page_list is not completed but some folios writebac=
k have been
> > >>>>>>>      completed, and this may lead to failure to rotate these fo=
lios to the
> > >>>>>>>      tail of lru. The lru may look likes as below:
> > >>>>>
> > >>>>> I assume you=E2=80=99re referring to PMD-mapped THP, but your cod=
e also modifies
> > >>>>> mTHP, which might not be that large. For instance, it could be a =
16KB mTHP.
> > >>>>>
> > >>>>>>>
> > >>>>>>>      folioN50<->folioN49<->...filioN1<->folio1<->folio2...<->fo=
lioN-1<->
> > >>>>>>>      folioN51<->folioN52<->...folioN511<->folioN512
> > >>>>>>>
> > >>>>>>>      Although those folios (N1-N50) have been finished writing =
back, they
> > >>>>>>>      are still at the head of lru. When isolating folios from l=
ru, it scans
> > >>>>>>>      from tail to head, so it is difficult to scan those folios=
 again.
> > >>>>>>>
> > >>>>>>> What mentioned above may lead to a large number of folios have =
been added
> > >>>>>>> to swap cache but can not be reclaimed in time, which may reduc=
e reclaim
> > >>>>>>> efficiency and prevent other memcgs from using this swap memory=
 even if
> > >>>>>>> they trigger OOM.
> > >>>>>>>
> > >>>>>>> To fix this issue, it's better to stop looping if THP has been =
splited and
> > >>>>>>> nr_pageout is greater than nr_to_reclaim.
> > >>>>>>>
> > >>>>>>> Signed-off-by: Chen Ridong <chenridong@huawei.com>
> > >>>>>>> ---
> > >>>>>>>    mm/vmscan.c | 16 +++++++++++++++-
> > >>>>>>>    1 file changed, 15 insertions(+), 1 deletion(-)
> > >>>>>>>
> > >>>>>>> diff --git a/mm/vmscan.c b/mm/vmscan.c
> > >>>>>>> index 749cdc110c74..fd8ad251eda2 100644
> > >>>>>>> --- a/mm/vmscan.c
> > >>>>>>> +++ b/mm/vmscan.c
> > >>>>>>> @@ -1047,7 +1047,7 @@ static unsigned int shrink_folio_list(str=
uct list_head *folio_list,
> > >>>>>>>        LIST_HEAD(demote_folios);
> > >>>>>>>        unsigned int nr_reclaimed =3D 0;
> > >>>>>>>        unsigned int pgactivate =3D 0;
> > >>>>>>> -     bool do_demote_pass;
> > >>>>>>> +     bool do_demote_pass, splited =3D false;
> > >>>>>>>        struct swap_iocb *plug =3D NULL;
> > >>>>>>>
> > >>>>>>>        folio_batch_init(&free_folios);
> > >>>>>>> @@ -1065,6 +1065,16 @@ static unsigned int shrink_folio_list(st=
ruct list_head *folio_list,
> > >>>>>>>
> > >>>>>>>                cond_resched();
> > >>>>>>>
> > >>>>>>> +             /*
> > >>>>>>> +              * If a large folio has been split, many folios a=
re added
> > >>>>>>> +              * to folio_list. Looping through the entire list=
 takes
> > >>>>>>> +              * too much time, which may prevent folios that h=
ave completed
> > >>>>>>> +              * writeback from rotateing to the tail of the lr=
u. Just
> > >>>>>>> +              * stop looping if nr_pageout is greater than nr_=
to_reclaim.
> > >>>>>>> +              */
> > >>>>>>> +             if (unlikely(splited && stat->nr_pageout > sc->nr=
_to_reclaim))
> > >>>>>>> +                     break;
> > >>>>>
> > >>>>> I=E2=80=99m not entirely sure about the theory behind comparing s=
tat->nr_pageout
> > >>>>> with sc->nr_to_reclaim. However, the condition might still hold t=
rue even
> > >>>>> if you=E2=80=99ve split a relatively small =E2=80=9Clarge folio,=
=E2=80=9D such as 16kB?
> > >>>>>
> > >>>>
> > >>>> Why compare stat->nr_pageout with sc->nr_to_reclaim? It's because =
if all
> > >>>> pages that have been pageout can be reclaimed, then enough pages c=
an be
> > >>>> reclaimed when all pages have finished writeback. Thus, it may not=
 have
> > >>>> to pageout more.
> > >>>>
> > >>>> If a small large folio(16 kB) has been split, it may return early
> > >>>> without the entire pages in the folio_list being pageout, but I th=
ink
> > >>>> that is fine. It can pageout more pages the next time it enters
> > >>>> shrink_folio_list if there are not enough pages to reclaimed.
> > >>>>
> > >>>> However, if pages that have been pageout are still at the head of =
the
> > >>>> LRU, it is difficult to scan these pages again. In this case, not =
only
> > >>>> might it "waste" some swap memory but it also has to pageout more =
pages.
> > >>>>
> > >>>> Considering the above, I sent this patch. It may not be a perfect
> > >>>> solution, but i think it's a good option to consider. And I am won=
dering
> > >>>> if anyone has a better solution.
> > >>>
> > >>> Hi Ridong,
> > >>> My overall understanding is that you have failed to describe your p=
roblem
> > >>> particularly I don't understand what your 3 and 4 mean:
> > >>>
> > >>>> 3. When folio writeback io is completed, the folio may be rotated =
to tail
> > >>>>    of lru. The following lru list is expected, with those filioes =
that have
> > >>>>    been added to swap cache are rotated to tail of lru. So those f=
olios
> > >>>>  can be reclaimed as soon as possible.
> > >>>>
> > >>>>  folio1<->folio2<->...<->folioN-1<->filioN1<->...folioN511<->folio=
N512
> > >>>
> > >>>  > 4. However, shrink_page_list and folio writeback are asynchronou=
s. If THP
> > >>>  >    is splited, shrink_page_list loops at least 512 times, which =
means that
> > >>>  >    shrink_page_list is not completed but some folios writeback h=
ave been
> > >>>  >    completed, and this may lead to failure to rotate these folio=
s to the
> > >>>   >  tail of lru. The lru may look likes as below:
> > >>>
> > >>> can you please describe it in a readable approach?
> > >>>
> > >>> i feel your below diagram is somehow wrong:
> > >>> folio1<->folio2<->...<->folioN-1<->filioN1<->...folioN511<->folioN5=
12
> > >>>
> > >>> You mentioned "rotate', how could "rotate" makes:
> > >>> folioN512<->folioN511<->...filioN1 in (2)
> > >>> become
> > >>> filioN1<->...folioN511<->folioN512 in (3).
> > >>>
> > >>
> > >> I am sorry for any confusion.
> > >>
> > >> If THP is split, filioN1, filioN2, filioN3, ...filioN512 are committ=
ed
> > >> to writeback one by one. it assumed that filioN1,
> > >> filioN2,filioN3,...filioN512 are completed in order.
> > >>
> > >> Orignal:
> > >> folioN512<->folioN511<->...filioN1<->folio1<->folio2...<->folioN-1
> > >>
> > >> filioN1 is finished, filioN1 is rotated to the tail of LRU:
> > >> folioN512<->folioN511<->...filioN2<->folio1<->folio2...<->folioN-1<-=
>folioN1
> > >>
> > >> filioN2 is finished:
> > >> folioN512<->folioN511<->...filioN3<->folio1<->folio2...<->folioN-1<-=
>folioN1<->folioN2
> > >>
> > >> filioN3 is finished:
> > >> folioN512<->folioN511<->...filioN4<->folio1<->folio2...<->folioN-1<-=
>folioN1<->folioN2<->filioN3
> > >>
> > >> ...
> > >>
> > >> filioN512 is finished:
> > >> folio1<->folio2<->...<->folioN-1<->filioN1<->...folioN511<->folioN51=
2
> > >>
> > >> When the filios are finished, the LRU might just like this:
> > >> folio1<->folio2<->...<->folioN-1<->filioN1<->...folioN511<->folioN51=
2
> > >
> > > understood, thanks!
> > >
> > > Let me try to understand the following part:
> > >
> > >> 4:
> > >>   folioN50<->folioN49<->...filioN1<->folio1<->folio2...<->folioN-1<-=
>
> > >>   folioN51<->folioN52<->...folioN511<->folioN512
> > >
> > >  >  Although those folios (N1-N50) have been finished writing back, t=
hey
> > >  >  are still at the head of lru. When isolating folios from lru, it =
scans
> > >  >  from tail to head, so it is difficult to scan those folios again.
> > >
> > > What is the reason that "those folios (N1-N50) have finished writing =
back,
> > > yet they remain at the head of the LRU"? Is it because their writebac=
k_end
> > > occurred while we were still looping in shrink_folio_list(), causing
> > > folio_end_writeback()'s folio_rotate_reclaimable() to fail in moving
> > > these folios, which are still in the "folio_list", to the tail of the=
 LRU?
> > >
> >
> > Yes, you are right.
> >
> > >>
> > >>> btw, writeback isn't always async. it could be sync for zram and sy=
nc_io
> > >>> swap. in that case, your patch might change the order of LRU. i mea=
n,
> > >>> for example, while a mTHP becomes cold, we always reclaim all of th=
em,
> > >>> but not part of them and put back part of small folios to the head =
of lru.
> > >>>
> > >>
> > >> Yes, This can be changed.
> > >> Although it may put back part of small folios to the head of lru, it=
 can
> > >> return in time from shrink_folio_list without causing much additiona=
l I/O.
> > >>
> > >> If you have understood this issue, do you have any suggestions to fi=
x
> > >> it? My patch may not be a perfect way to fix this issue.
> > >>
> > >
> > > My point is that synchronous I/O, like zRAM, doesn't have this issue =
and
> > > doesn't require this fix, as writeback is always completed without
> > > asynchronous latency.
> > >
> >
> > I have tested zRAM and found no issues.
> > This is version 1, and I don't know whether this fix will be accepted.

Hi Ridong,

Let me clarify further. I don't believe this is the right fix for either
asynchronous or synchronous I/O, as the coldness of the folios
is being overlooked in both cases. It could lead to more refaults
because cold memory isn't having pageout() executed with the
earlier break you're trying to add, even though it works around
the problem you're facing.

We should ensure that pageout() is always called for all subpages,
regardless of whether an mTHP is split. However, we can adjust
how the folio_list is returned to the LRU.

> > If it is accepted, perhaps this patch could be modified to apply only t=
o
> > asynchronous io.
>
> Consider a 2MB THP: when it becomes cold, we detect that it is cold and
> decide to page it out. Even if we split it into 512 * 4KiB folios, the en=
tire
> 2MB is still cold, so we want pageout() to be called for the entire 2MB.
> With your current approach, some parts of the 2MB are moved to the
> LRU head while we're still paging out other parts, which seems
> problematic.
>
> Could we address this in move_folios_to_lru()? Perhaps we could find
> a way to detect folios whose writeback has done and move them to the
> tail instead of always placing them at the head.
>
> >
> > Best regards,
> > Ridong

Thanks
Barry

