Return-Path: <linux-kernel+bounces-373997-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F44B9A6066
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 11:42:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF82928191B
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 09:42:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63D3E946C;
	Mon, 21 Oct 2024 09:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lJjLc/na"
Received: from mail-vs1-f53.google.com (mail-vs1-f53.google.com [209.85.217.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26CAA1E22EB
	for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 09:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729503748; cv=none; b=UDfPwDzBEpnREKtXecWsbXdPwMBIchU81878B4C/cZ6XX41y+cQ4hGITsXivmaBYtTm6pgI33FNNM7XoIUaDXO7H2q2O9EEoQASic6AHeH5o9UGSZgbQDG2fDN1tpKjx2i8Hi+hWs2vuRJi5iGSxctMbk91EQzYCliDM0pCEHns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729503748; c=relaxed/simple;
	bh=sBcxPpPlhwTk3DGY5r4pXpE9Vf99vHDOLdO9E8TuyeI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=p9/aLpQVvXtUo2Wo5YHGWmRgb0E7F3xwgYVTs7OXrDWK5WHJSwiq01aCKi4G1zMYvNsa+bA+qrU2fASnOa/yRGbpKN3DGYaf2oevRKZF/RoT79S2k31aiArVywsJgEOR66Zq+5VI5Uv/R5Mrkdfv4eR/LfY21KiFHSSswgbx5hI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lJjLc/na; arc=none smtp.client-ip=209.85.217.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f53.google.com with SMTP id ada2fe7eead31-4a46d36c044so2290621137.1
        for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 02:42:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729503745; x=1730108545; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GKWQ+PiNxEr+3J2vDFkOhXSbXDVfWjoiMlO+y8Dj1m0=;
        b=lJjLc/naLWPJSYiIjBV06j4yADt6fV4U1OPPQGWEg1sDJYFlQSUqPrEF0OXmAfjM/R
         RYHroH+KbUsRCuKoRzSgiS/AS6PsN7ErGnSTLlGjKf2vaDrUTnzisAXPXXAcQE+iJl3K
         fg0SKDNs0/0ZsNnotL9dEMrpBMc5TWa0B6sYhhS2pZjVnN8RfvExiFC/CvGCXt7M+DSq
         z2J2CkgFjNcOKwwmFuRCVvaIUx9gH+Yrgrqc17Z6LuOOPan1fond4+Jlo5O2FEbjd8Yv
         8mY/JRha5Di22Rl0ESKKVEg+dxsHvDA0d1qt4IUHayq47+/aFil7b4lsW4i5BTIMGb0L
         WUcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729503745; x=1730108545;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GKWQ+PiNxEr+3J2vDFkOhXSbXDVfWjoiMlO+y8Dj1m0=;
        b=ev/czAxcTCiwzF7r3HtKDKU0CmogjsvVvcDPSHCZhdmajuBV7yWT3GqrFgQnM52FsB
         R94Pq4TtC3XkQxOzcpEw+ql5/+b2DpKoyVHktZnfidMhQVlKg12SLCLySjXzl9MXW2C3
         +mV2NMXcDC5u0eUzMgaI/A/PIrK5Ea1XlveSvc4BuFS7noh/G8AKk+3MiwKQ5cZg6iPE
         aK8DHv+uo2D9JrtJ4YGWMZa7GBPdlhfdWBvKXa4Fx/xKMQ2CjyfjopSS+A4J06gRIZ6b
         4erpI30DQq+TrXFgNEwkJz7Jy6EiFV+PVbzoJwTdvcI/ECOWa3Ztv5Wz2LdcNDPz11g9
         o8aw==
X-Forwarded-Encrypted: i=1; AJvYcCVGmgSAJstiMIKhkj15h/qOunXSJ9GwylTxRgR/KlXecpf9O9vEZhRFayuXnufxirKJQ8tvcUNIT062w9s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yypp9cevE3S4bBZ74FGzxm8/8Qilj2vCas9USmsdglv9EB/713H
	scxmGbBlRo2cnJQjPPZ/+LVLAo1CC84ihENux1N3+YUOB2inIHoutUihk507t3WlQXjJh9H5+a3
	zq6RPM9mYOTIL4H6RwMd0sqev95w=
X-Google-Smtp-Source: AGHT+IH5bvFdKhaa3Mfg5e8pWptQK15nfHtN0KXRjq1x037cl+QupNMTsv4bTid/1Hw+JF7dCSiO01RFSWIhmKGnq1Y=
X-Received: by 2002:a05:6102:38d2:b0:4a4:92f7:3611 with SMTP id
 ada2fe7eead31-4a5d6f01da5mr4919910137.12.1729503744835; Mon, 21 Oct 2024
 02:42:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241010081802.290893-1-chenridong@huaweicloud.com>
 <c3f2c5e2-4804-46e8-86ff-1f6a79ea9a7c@huawei.com> <CAGsJ_4zR+=80S_Fz1ZV3iZxjVKUE3-f32w7W1smuAgZM=HrPRQ@mail.gmail.com>
 <62bd2564-76fa-4cb0-9c08-9eb2f96771b6@huawei.com> <CAGsJ_4x=nqKFMqDmfmvXVAhQNTo1Fx-aQ2MoSKSGQrSCccqr3Q@mail.gmail.com>
 <28b3eae5-92e7-471f-9883-d03684e06d1b@huaweicloud.com>
In-Reply-To: <28b3eae5-92e7-471f-9883-d03684e06d1b@huaweicloud.com>
From: Barry Song <21cnbao@gmail.com>
Date: Mon, 21 Oct 2024 22:42:13 +1300
Message-ID: <CAGsJ_4yx8Z2w=FbBCUHtDa-=jDVDcdsBAHu26-LNeuOuquoOmg@mail.gmail.com>
Subject: Re: [PATCH v3] mm/vmscan: stop the loop if enough pages have been page_out
To: Chen Ridong <chenridong@huaweicloud.com>
Cc: chenridong <chenridong@huawei.com>, Kefeng Wang <wangkefeng.wang@huawei.com>, 
	akpm@linux-foundation.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	wangweiyang2@huawei.com, Michal Hocko <mhocko@suse.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, Yosry Ahmed <yosryahmed@google.com>, Yu Zhao <yuzhao@google.com>, 
	David Hildenbrand <david@redhat.com>, Matthew Wilcox <willy@infradead.org>, 
	Ryan Roberts <ryan.roberts@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 21, 2024 at 9:14=E2=80=AFPM Chen Ridong <chenridong@huaweicloud=
.com> wrote:
>
>
>
> On 2024/10/21 12:44, Barry Song wrote:
> > On Fri, Oct 11, 2024 at 7:49=E2=80=AFPM chenridong <chenridong@huawei.c=
om> wrote:
> >>
> >>
> >>
> >> On 2024/10/11 0:17, Barry Song wrote:
> >>> On Thu, Oct 10, 2024 at 4:59=E2=80=AFPM Kefeng Wang <wangkefeng.wang@=
huawei.com> wrote:
> >>>>
> >>>> Hi Ridong,
> >>>>
> >>>> This should be the first version for upstream, and the issue only
> >>>> occurred when large folio is spited.
> >>>>
> >>>> Adding more CCs to see if there's more feedback.
> >>>>
> >>>>
> >>>> On 2024/10/10 16:18, Chen Ridong wrote:
> >>>>> From: Chen Ridong <chenridong@huawei.com>
> >>>>>
> >>>>> An issue was found with the following testing step:
> >>>>> 1. Compile with CONFIG_TRANSPARENT_HUGEPAGE=3Dy
> >>>>> 2. Mount memcg v1, and create memcg named test_memcg and set
> >>>>>      usage_in_bytes=3D2.1G, memsw.usage_in_bytes=3D3G.
> >>>>> 3. Create a 1G swap file, and allocate 2.2G anon memory in test_mem=
cg.
> >>>>>
> >>>>> It was found that:
> >>>>>
> >>>>> cat memory.usage_in_bytes
> >>>>> 2144940032
> >>>>> cat memory.memsw.usage_in_bytes
> >>>>> 2255056896
> >>>>>
> >>>>> free -h
> >>>>>                 total        used        free
> >>>>> Mem:           31Gi       2.1Gi        27Gi
> >>>>> Swap:         1.0Gi       618Mi       405Mi
> >>>>>
> >>>>> As shown above, the test_memcg used about 100M swap, but 600M+ swap=
 memory
> >>>>> was used, which means that 500M may be wasted because other memcgs =
can not
> >>>>> use these swap memory.
> >>>>>
> >>>>> It can be explained as follows:
> >>>>> 1. When entering shrink_inactive_list, it isolates folios from lru =
from
> >>>>>      tail to head. If it just takes folioN from lru(make it simple)=
.
> >>>>>
> >>>>>      inactive lru: folio1<->folio2<->folio3...<->folioN-1
> >>>>>      isolated list: folioN
> >>>>>
> >>>>> 2. In shrink_page_list function, if folioN is THP, it may be splite=
d and
> >>>>>      added to swap cache folio by folio. After adding to swap cache=
, it will
> >>>>>      submit io to writeback folio to swap, which is asynchronous.
> >>>>>      When shrink_page_list is finished, the isolated folios list wi=
ll be
> >>>>>      moved back to the head of inactive lru. The inactive lru may j=
ust look
> >>>>>      like this, with 512 filioes have been move to the head of inac=
tive lru.
> >>>>>
> >>>>>      folioN512<->folioN511<->...filioN1<->folio1<->folio2...<->foli=
oN-1
> >>>>>
> >>>>> 3. When folio writeback io is completed, the folio may be rotated t=
o tail
> >>>>>      of lru. The following lru list is expected, with those filioes=
 that have
> >>>>>      been added to swap cache are rotated to tail of lru. So those =
folios
> >>>>>      can be reclaimed as soon as possible.
> >>>>>
> >>>>>      folio1<->folio2<->...<->folioN-1<->filioN1<->...folioN511<->fo=
lioN512
> >>>>>
> >>>>> 4. However, shrink_page_list and folio writeback are asynchronous. =
If THP
> >>>>>      is splited, shrink_page_list loops at least 512 times, which m=
eans that
> >>>>>      shrink_page_list is not completed but some folios writeback ha=
ve been
> >>>>>      completed, and this may lead to failure to rotate these folios=
 to the
> >>>>>      tail of lru. The lru may look likes as below:
> >>>
> >>> I assume you=E2=80=99re referring to PMD-mapped THP, but your code al=
so modifies
> >>> mTHP, which might not be that large. For instance, it could be a 16KB=
 mTHP.
> >>>
> >>>>>
> >>>>>      folioN50<->folioN49<->...filioN1<->folio1<->folio2...<->folioN=
-1<->
> >>>>>      folioN51<->folioN52<->...folioN511<->folioN512
> >>>>>
> >>>>>      Although those folios (N1-N50) have been finished writing back=
, they
> >>>>>      are still at the head of lru. When isolating folios from lru, =
it scans
> >>>>>      from tail to head, so it is difficult to scan those folios aga=
in.
> >>>>>
> >>>>> What mentioned above may lead to a large number of folios have been=
 added
> >>>>> to swap cache but can not be reclaimed in time, which may reduce re=
claim
> >>>>> efficiency and prevent other memcgs from using this swap memory eve=
n if
> >>>>> they trigger OOM.
> >>>>>
> >>>>> To fix this issue, it's better to stop looping if THP has been spli=
ted and
> >>>>> nr_pageout is greater than nr_to_reclaim.
> >>>>>
> >>>>> Signed-off-by: Chen Ridong <chenridong@huawei.com>
> >>>>> ---
> >>>>>    mm/vmscan.c | 16 +++++++++++++++-
> >>>>>    1 file changed, 15 insertions(+), 1 deletion(-)
> >>>>>
> >>>>> diff --git a/mm/vmscan.c b/mm/vmscan.c
> >>>>> index 749cdc110c74..fd8ad251eda2 100644
> >>>>> --- a/mm/vmscan.c
> >>>>> +++ b/mm/vmscan.c
> >>>>> @@ -1047,7 +1047,7 @@ static unsigned int shrink_folio_list(struct =
list_head *folio_list,
> >>>>>        LIST_HEAD(demote_folios);
> >>>>>        unsigned int nr_reclaimed =3D 0;
> >>>>>        unsigned int pgactivate =3D 0;
> >>>>> -     bool do_demote_pass;
> >>>>> +     bool do_demote_pass, splited =3D false;
> >>>>>        struct swap_iocb *plug =3D NULL;
> >>>>>
> >>>>>        folio_batch_init(&free_folios);
> >>>>> @@ -1065,6 +1065,16 @@ static unsigned int shrink_folio_list(struct=
 list_head *folio_list,
> >>>>>
> >>>>>                cond_resched();
> >>>>>
> >>>>> +             /*
> >>>>> +              * If a large folio has been split, many folios are a=
dded
> >>>>> +              * to folio_list. Looping through the entire list tak=
es
> >>>>> +              * too much time, which may prevent folios that have =
completed
> >>>>> +              * writeback from rotateing to the tail of the lru. J=
ust
> >>>>> +              * stop looping if nr_pageout is greater than nr_to_r=
eclaim.
> >>>>> +              */
> >>>>> +             if (unlikely(splited && stat->nr_pageout > sc->nr_to_=
reclaim))
> >>>>> +                     break;
> >>>
> >>> I=E2=80=99m not entirely sure about the theory behind comparing stat-=
>nr_pageout
> >>> with sc->nr_to_reclaim. However, the condition might still hold true =
even
> >>> if you=E2=80=99ve split a relatively small =E2=80=9Clarge folio,=E2=
=80=9D such as 16kB?
> >>>
> >>
> >> Why compare stat->nr_pageout with sc->nr_to_reclaim? It's because if a=
ll
> >> pages that have been pageout can be reclaimed, then enough pages can b=
e
> >> reclaimed when all pages have finished writeback. Thus, it may not hav=
e
> >> to pageout more.
> >>
> >> If a small large folio(16 kB) has been split, it may return early
> >> without the entire pages in the folio_list being pageout, but I think
> >> that is fine. It can pageout more pages the next time it enters
> >> shrink_folio_list if there are not enough pages to reclaimed.
> >>
> >> However, if pages that have been pageout are still at the head of the
> >> LRU, it is difficult to scan these pages again. In this case, not only
> >> might it "waste" some swap memory but it also has to pageout more page=
s.
> >>
> >> Considering the above, I sent this patch. It may not be a perfect
> >> solution, but i think it's a good option to consider. And I am wonderi=
ng
> >> if anyone has a better solution.
> >
> > Hi Ridong,
> > My overall understanding is that you have failed to describe your probl=
em
> > particularly I don't understand what your 3 and 4 mean:
> >
> >> 3. When folio writeback io is completed, the folio may be rotated to t=
ail
> >>    of lru. The following lru list is expected, with those filioes that=
 have
> >>    been added to swap cache are rotated to tail of lru. So those folio=
s
> >>  can be reclaimed as soon as possible.
> >>
> >>  folio1<->folio2<->...<->folioN-1<->filioN1<->...folioN511<->folioN512
> >
> >  > 4. However, shrink_page_list and folio writeback are asynchronous. I=
f THP
> >  >    is splited, shrink_page_list loops at least 512 times, which mean=
s that
> >  >    shrink_page_list is not completed but some folios writeback have =
been
> >  >    completed, and this may lead to failure to rotate these folios to=
 the
> >   >  tail of lru. The lru may look likes as below:
> >
> > can you please describe it in a readable approach?
> >
> > i feel your below diagram is somehow wrong:
> > folio1<->folio2<->...<->folioN-1<->filioN1<->...folioN511<->folioN512
> >
> > You mentioned "rotate', how could "rotate" makes:
> > folioN512<->folioN511<->...filioN1 in (2)
> > become
> > filioN1<->...folioN511<->folioN512 in (3).
> >
>
> I am sorry for any confusion.
>
> If THP is split, filioN1, filioN2, filioN3, ...filioN512 are committed
> to writeback one by one. it assumed that filioN1,
> filioN2,filioN3,...filioN512 are completed in order.
>
> Orignal:
> folioN512<->folioN511<->...filioN1<->folio1<->folio2...<->folioN-1
>
> filioN1 is finished, filioN1 is rotated to the tail of LRU:
> folioN512<->folioN511<->...filioN2<->folio1<->folio2...<->folioN-1<->foli=
oN1
>
> filioN2 is finished:
> folioN512<->folioN511<->...filioN3<->folio1<->folio2...<->folioN-1<->foli=
oN1<->folioN2
>
> filioN3 is finished:
> folioN512<->folioN511<->...filioN4<->folio1<->folio2...<->folioN-1<->foli=
oN1<->folioN2<->filioN3
>
> ...
>
> filioN512 is finished:
> folio1<->folio2<->...<->folioN-1<->filioN1<->...folioN511<->folioN512
>
> When the filios are finished, the LRU might just like this:
> folio1<->folio2<->...<->folioN-1<->filioN1<->...folioN511<->folioN512

understood, thanks!

Let me try to understand the following part:

> 4:
>   folioN50<->folioN49<->...filioN1<->folio1<->folio2...<->folioN-1<->
>   folioN51<->folioN52<->...folioN511<->folioN512

 >  Although those folios (N1-N50) have been finished writing back, they
 >  are still at the head of lru. When isolating folios from lru, it scans
 >  from tail to head, so it is difficult to scan those folios again.

What is the reason that "those folios (N1-N50) have finished writing back,
yet they remain at the head of the LRU"? Is it because their writeback_end
occurred while we were still looping in shrink_folio_list(), causing
folio_end_writeback()'s folio_rotate_reclaimable() to fail in moving
these folios, which are still in the "folio_list", to the tail of the LRU?

>
> > btw, writeback isn't always async. it could be sync for zram and sync_i=
o
> > swap. in that case, your patch might change the order of LRU. i mean,
> > for example, while a mTHP becomes cold, we always reclaim all of them,
> > but not part of them and put back part of small folios to the head of l=
ru.
> >
>
> Yes, This can be changed.
> Although it may put back part of small folios to the head of lru, it can
> return in time from shrink_folio_list without causing much additional I/O=
.
>
> If you have understood this issue, do you have any suggestions to fix
> it? My patch may not be a perfect way to fix this issue.
>

My point is that synchronous I/O, like zRAM, doesn't have this issue and
doesn't require this fix, as writeback is always completed without
asynchronous latency.


> Best regards,
> Ridong
>

Thanks
Barry

