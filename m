Return-Path: <linux-kernel+bounces-374071-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EC139A6209
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 12:09:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A9F1283480
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 10:09:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF08B1E4113;
	Mon, 21 Oct 2024 10:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i5SOUAj1"
Received: from mail-ua1-f45.google.com (mail-ua1-f45.google.com [209.85.222.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FFE71E2834
	for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 10:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729505376; cv=none; b=SyIT+tbfZjIlgwRwy0OrQ2RksMrQzvKZ/mlyY0OxPFGE1caa5YQfa98uxBfTrZklxlMoSrGWvTVUEZs5PxR+6zsPq4DdwKMAO23q+v+pb+0tMrudC3Po7Jl7u2XjrB9KKDo7BLg+SP+Y6L1B4zfj2d2pcCbEA1cXMz25Fpncaa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729505376; c=relaxed/simple;
	bh=IWaRSvA+Ceu5BWueciMuACGITj84NJgIswgUTSkWZyQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AlGw+T3TjkeIgwmaIPP/lIIh5IfFFrRoDSLZYqLKhHPK+kzwULPRAD+6JhMtnDttzbm9gSe1wHFPgk2dNbPkXSMF7tCrrlBHeqIZQP9j5Zr4YqAUlO7K9rdLl/4HxZOfWpJHY8PsxbOZeVWXisjYh6JWu99MS4abc5sEq6o3Qzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i5SOUAj1; arc=none smtp.client-ip=209.85.222.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f45.google.com with SMTP id a1e0cc1a2514c-851f5d3001fso635795241.1
        for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 03:09:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729505373; x=1730110173; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+7aeabzaQLkaNKEn8nxxF+sKaTT/AZcjGrs/CJVL4kA=;
        b=i5SOUAj1xJDrVv2IpYUAZMUgXNEcVWdlVzAHGVq2CKVXdyhsqZVg6igsydS/S+31o+
         7icXK1fFk+k8kNsAv9DwawyiuyrdvRFKd+f7pUTKEhto3ml56mRabueU10MQs7aJ/qrF
         8DbiCvGFFxXaCdwGgcyZIULeH4V+oncqO8FGT8qNzz3rs4t1rDUCm6VkXRrRQSMqUiMn
         itcN+XcAa6HUJo7cFg4UX5Vz8CkOrE8QgkX+SC7miXT3VkgNrroj/Uh3rVA939aWhetw
         w4aDNCMQjlzQhHhNuGF+cg7dd8dSvwp5D67+mpaJHj8EDMdJfXsZAmkGJeiq/APUbUWL
         K2vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729505373; x=1730110173;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+7aeabzaQLkaNKEn8nxxF+sKaTT/AZcjGrs/CJVL4kA=;
        b=aB+cozDG39DfW1g0FmvGlxLn7QiN6s/oGNetGuznvDsvMovnjMXF6XGmkKBJk9TtU3
         1HLyqdd4BCrLN6+ZUDQywTjen1RLndpu20OmumRVbjWbQTw0v1q1QSQLM8s2kdgnkmGR
         vzNouNzPwgDLJ6Web6anDmTyhTWqq2Mry4YEn19yGRnhDj/qUhkM+YQd4EaC0v34Q8XR
         TE9XTOPkz1bk90vNbJNL0effvj/Kt62fwIB6MleHU5ZaSltdTN2uZ736Bboyq9faE28H
         5lRpvlxqwch/81Qk5A3n9RZS+Rt5Y3AgPaBf9DcYZlPWEiBGZJIAYX6Z1ORFSWTstB3e
         +0pg==
X-Forwarded-Encrypted: i=1; AJvYcCVoiau8MfPJt3i7Q335QzIYfKlk5qM3UnE2RwGy93NOmr5PM4c2fYjLOnz5fNIFVwrjQ0HPALaYWyBy0/E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yylw1YM/wtIHIRjoNxmY/AK/lwI1dPQkNgRwwW9mlF+nh9+Z04n
	R4D7vImkb6DaJrsnU1mwpMB8IXuW7Th3WhMeJmLy+w/o4FCbohNp+hEFkKbPxs88dvovfmFWAXw
	qxke5WsmuOepZhrRxFhndUNKBvlkR9/7fKAw=
X-Google-Smtp-Source: AGHT+IFGnMnr+kA36VRys9G8Q876lQLIQBWaNxf/4dChzdM7jOETx64G9MpYP6TlAa7tPztFgUe7nYZVwxMDerXYQhk=
X-Received: by 2002:a05:6102:b08:b0:4a4:7980:b9c8 with SMTP id
 ada2fe7eead31-4a5d6adfdf4mr9567667137.13.1729505373146; Mon, 21 Oct 2024
 03:09:33 -0700 (PDT)
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
 <c85a035b-70d2-47df-b2c3-db255c98f6ff@huawei.com>
In-Reply-To: <c85a035b-70d2-47df-b2c3-db255c98f6ff@huawei.com>
From: Barry Song <21cnbao@gmail.com>
Date: Mon, 21 Oct 2024 23:09:21 +1300
Message-ID: <CAGsJ_4yfpPoEnR2DOGcytEe0Xzuhq05W8Ncrb=z7OZ_icdWAww@mail.gmail.com>
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

On Mon, Oct 21, 2024 at 10:56=E2=80=AFPM chenridong <chenridong@huawei.com>=
 wrote:
>
>
>
> On 2024/10/21 17:42, Barry Song wrote:
> > On Mon, Oct 21, 2024 at 9:14=E2=80=AFPM Chen Ridong <chenridong@huaweic=
loud.com> wrote:
> >>
> >>
> >>
> >> On 2024/10/21 12:44, Barry Song wrote:
> >>> On Fri, Oct 11, 2024 at 7:49=E2=80=AFPM chenridong <chenridong@huawei=
.com> wrote:
> >>>>
> >>>>
> >>>>
> >>>> On 2024/10/11 0:17, Barry Song wrote:
> >>>>> On Thu, Oct 10, 2024 at 4:59=E2=80=AFPM Kefeng Wang <wangkefeng.wan=
g@huawei.com> wrote:
> >>>>>>
> >>>>>> Hi Ridong,
> >>>>>>
> >>>>>> This should be the first version for upstream, and the issue only
> >>>>>> occurred when large folio is spited.
> >>>>>>
> >>>>>> Adding more CCs to see if there's more feedback.
> >>>>>>
> >>>>>>
> >>>>>> On 2024/10/10 16:18, Chen Ridong wrote:
> >>>>>>> From: Chen Ridong <chenridong@huawei.com>
> >>>>>>>
> >>>>>>> An issue was found with the following testing step:
> >>>>>>> 1. Compile with CONFIG_TRANSPARENT_HUGEPAGE=3Dy
> >>>>>>> 2. Mount memcg v1, and create memcg named test_memcg and set
> >>>>>>>      usage_in_bytes=3D2.1G, memsw.usage_in_bytes=3D3G.
> >>>>>>> 3. Create a 1G swap file, and allocate 2.2G anon memory in test_m=
emcg.
> >>>>>>>
> >>>>>>> It was found that:
> >>>>>>>
> >>>>>>> cat memory.usage_in_bytes
> >>>>>>> 2144940032
> >>>>>>> cat memory.memsw.usage_in_bytes
> >>>>>>> 2255056896
> >>>>>>>
> >>>>>>> free -h
> >>>>>>>                 total        used        free
> >>>>>>> Mem:           31Gi       2.1Gi        27Gi
> >>>>>>> Swap:         1.0Gi       618Mi       405Mi
> >>>>>>>
> >>>>>>> As shown above, the test_memcg used about 100M swap, but 600M+ sw=
ap memory
> >>>>>>> was used, which means that 500M may be wasted because other memcg=
s can not
> >>>>>>> use these swap memory.
> >>>>>>>
> >>>>>>> It can be explained as follows:
> >>>>>>> 1. When entering shrink_inactive_list, it isolates folios from lr=
u from
> >>>>>>>      tail to head. If it just takes folioN from lru(make it simpl=
e).
> >>>>>>>
> >>>>>>>      inactive lru: folio1<->folio2<->folio3...<->folioN-1
> >>>>>>>      isolated list: folioN
> >>>>>>>
> >>>>>>> 2. In shrink_page_list function, if folioN is THP, it may be spli=
ted and
> >>>>>>>      added to swap cache folio by folio. After adding to swap cac=
he, it will
> >>>>>>>      submit io to writeback folio to swap, which is asynchronous.
> >>>>>>>      When shrink_page_list is finished, the isolated folios list =
will be
> >>>>>>>      moved back to the head of inactive lru. The inactive lru may=
 just look
> >>>>>>>      like this, with 512 filioes have been move to the head of in=
active lru.
> >>>>>>>
> >>>>>>>      folioN512<->folioN511<->...filioN1<->folio1<->folio2...<->fo=
lioN-1
> >>>>>>>
> >>>>>>> 3. When folio writeback io is completed, the folio may be rotated=
 to tail
> >>>>>>>      of lru. The following lru list is expected, with those filio=
es that have
> >>>>>>>      been added to swap cache are rotated to tail of lru. So thos=
e folios
> >>>>>>>      can be reclaimed as soon as possible.
> >>>>>>>
> >>>>>>>      folio1<->folio2<->...<->folioN-1<->filioN1<->...folioN511<->=
folioN512
> >>>>>>>
> >>>>>>> 4. However, shrink_page_list and folio writeback are asynchronous=
. If THP
> >>>>>>>      is splited, shrink_page_list loops at least 512 times, which=
 means that
> >>>>>>>      shrink_page_list is not completed but some folios writeback =
have been
> >>>>>>>      completed, and this may lead to failure to rotate these foli=
os to the
> >>>>>>>      tail of lru. The lru may look likes as below:
> >>>>>
> >>>>> I assume you=E2=80=99re referring to PMD-mapped THP, but your code =
also modifies
> >>>>> mTHP, which might not be that large. For instance, it could be a 16=
KB mTHP.
> >>>>>
> >>>>>>>
> >>>>>>>      folioN50<->folioN49<->...filioN1<->folio1<->folio2...<->foli=
oN-1<->
> >>>>>>>      folioN51<->folioN52<->...folioN511<->folioN512
> >>>>>>>
> >>>>>>>      Although those folios (N1-N50) have been finished writing ba=
ck, they
> >>>>>>>      are still at the head of lru. When isolating folios from lru=
, it scans
> >>>>>>>      from tail to head, so it is difficult to scan those folios a=
gain.
> >>>>>>>
> >>>>>>> What mentioned above may lead to a large number of folios have be=
en added
> >>>>>>> to swap cache but can not be reclaimed in time, which may reduce =
reclaim
> >>>>>>> efficiency and prevent other memcgs from using this swap memory e=
ven if
> >>>>>>> they trigger OOM.
> >>>>>>>
> >>>>>>> To fix this issue, it's better to stop looping if THP has been sp=
lited and
> >>>>>>> nr_pageout is greater than nr_to_reclaim.
> >>>>>>>
> >>>>>>> Signed-off-by: Chen Ridong <chenridong@huawei.com>
> >>>>>>> ---
> >>>>>>>    mm/vmscan.c | 16 +++++++++++++++-
> >>>>>>>    1 file changed, 15 insertions(+), 1 deletion(-)
> >>>>>>>
> >>>>>>> diff --git a/mm/vmscan.c b/mm/vmscan.c
> >>>>>>> index 749cdc110c74..fd8ad251eda2 100644
> >>>>>>> --- a/mm/vmscan.c
> >>>>>>> +++ b/mm/vmscan.c
> >>>>>>> @@ -1047,7 +1047,7 @@ static unsigned int shrink_folio_list(struc=
t list_head *folio_list,
> >>>>>>>        LIST_HEAD(demote_folios);
> >>>>>>>        unsigned int nr_reclaimed =3D 0;
> >>>>>>>        unsigned int pgactivate =3D 0;
> >>>>>>> -     bool do_demote_pass;
> >>>>>>> +     bool do_demote_pass, splited =3D false;
> >>>>>>>        struct swap_iocb *plug =3D NULL;
> >>>>>>>
> >>>>>>>        folio_batch_init(&free_folios);
> >>>>>>> @@ -1065,6 +1065,16 @@ static unsigned int shrink_folio_list(stru=
ct list_head *folio_list,
> >>>>>>>
> >>>>>>>                cond_resched();
> >>>>>>>
> >>>>>>> +             /*
> >>>>>>> +              * If a large folio has been split, many folios are=
 added
> >>>>>>> +              * to folio_list. Looping through the entire list t=
akes
> >>>>>>> +              * too much time, which may prevent folios that hav=
e completed
> >>>>>>> +              * writeback from rotateing to the tail of the lru.=
 Just
> >>>>>>> +              * stop looping if nr_pageout is greater than nr_to=
_reclaim.
> >>>>>>> +              */
> >>>>>>> +             if (unlikely(splited && stat->nr_pageout > sc->nr_t=
o_reclaim))
> >>>>>>> +                     break;
> >>>>>
> >>>>> I=E2=80=99m not entirely sure about the theory behind comparing sta=
t->nr_pageout
> >>>>> with sc->nr_to_reclaim. However, the condition might still hold tru=
e even
> >>>>> if you=E2=80=99ve split a relatively small =E2=80=9Clarge folio,=E2=
=80=9D such as 16kB?
> >>>>>
> >>>>
> >>>> Why compare stat->nr_pageout with sc->nr_to_reclaim? It's because if=
 all
> >>>> pages that have been pageout can be reclaimed, then enough pages can=
 be
> >>>> reclaimed when all pages have finished writeback. Thus, it may not h=
ave
> >>>> to pageout more.
> >>>>
> >>>> If a small large folio(16 kB) has been split, it may return early
> >>>> without the entire pages in the folio_list being pageout, but I thin=
k
> >>>> that is fine. It can pageout more pages the next time it enters
> >>>> shrink_folio_list if there are not enough pages to reclaimed.
> >>>>
> >>>> However, if pages that have been pageout are still at the head of th=
e
> >>>> LRU, it is difficult to scan these pages again. In this case, not on=
ly
> >>>> might it "waste" some swap memory but it also has to pageout more pa=
ges.
> >>>>
> >>>> Considering the above, I sent this patch. It may not be a perfect
> >>>> solution, but i think it's a good option to consider. And I am wonde=
ring
> >>>> if anyone has a better solution.
> >>>
> >>> Hi Ridong,
> >>> My overall understanding is that you have failed to describe your pro=
blem
> >>> particularly I don't understand what your 3 and 4 mean:
> >>>
> >>>> 3. When folio writeback io is completed, the folio may be rotated to=
 tail
> >>>>    of lru. The following lru list is expected, with those filioes th=
at have
> >>>>    been added to swap cache are rotated to tail of lru. So those fol=
ios
> >>>>  can be reclaimed as soon as possible.
> >>>>
> >>>>  folio1<->folio2<->...<->folioN-1<->filioN1<->...folioN511<->folioN5=
12
> >>>
> >>>  > 4. However, shrink_page_list and folio writeback are asynchronous.=
 If THP
> >>>  >    is splited, shrink_page_list loops at least 512 times, which me=
ans that
> >>>  >    shrink_page_list is not completed but some folios writeback hav=
e been
> >>>  >    completed, and this may lead to failure to rotate these folios =
to the
> >>>   >  tail of lru. The lru may look likes as below:
> >>>
> >>> can you please describe it in a readable approach?
> >>>
> >>> i feel your below diagram is somehow wrong:
> >>> folio1<->folio2<->...<->folioN-1<->filioN1<->...folioN511<->folioN512
> >>>
> >>> You mentioned "rotate', how could "rotate" makes:
> >>> folioN512<->folioN511<->...filioN1 in (2)
> >>> become
> >>> filioN1<->...folioN511<->folioN512 in (3).
> >>>
> >>
> >> I am sorry for any confusion.
> >>
> >> If THP is split, filioN1, filioN2, filioN3, ...filioN512 are committed
> >> to writeback one by one. it assumed that filioN1,
> >> filioN2,filioN3,...filioN512 are completed in order.
> >>
> >> Orignal:
> >> folioN512<->folioN511<->...filioN1<->folio1<->folio2...<->folioN-1
> >>
> >> filioN1 is finished, filioN1 is rotated to the tail of LRU:
> >> folioN512<->folioN511<->...filioN2<->folio1<->folio2...<->folioN-1<->f=
olioN1
> >>
> >> filioN2 is finished:
> >> folioN512<->folioN511<->...filioN3<->folio1<->folio2...<->folioN-1<->f=
olioN1<->folioN2
> >>
> >> filioN3 is finished:
> >> folioN512<->folioN511<->...filioN4<->folio1<->folio2...<->folioN-1<->f=
olioN1<->folioN2<->filioN3
> >>
> >> ...
> >>
> >> filioN512 is finished:
> >> folio1<->folio2<->...<->folioN-1<->filioN1<->...folioN511<->folioN512
> >>
> >> When the filios are finished, the LRU might just like this:
> >> folio1<->folio2<->...<->folioN-1<->filioN1<->...folioN511<->folioN512
> >
> > understood, thanks!
> >
> > Let me try to understand the following part:
> >
> >> 4:
> >>   folioN50<->folioN49<->...filioN1<->folio1<->folio2...<->folioN-1<->
> >>   folioN51<->folioN52<->...folioN511<->folioN512
> >
> >  >  Although those folios (N1-N50) have been finished writing back, the=
y
> >  >  are still at the head of lru. When isolating folios from lru, it sc=
ans
> >  >  from tail to head, so it is difficult to scan those folios again.
> >
> > What is the reason that "those folios (N1-N50) have finished writing ba=
ck,
> > yet they remain at the head of the LRU"? Is it because their writeback_=
end
> > occurred while we were still looping in shrink_folio_list(), causing
> > folio_end_writeback()'s folio_rotate_reclaimable() to fail in moving
> > these folios, which are still in the "folio_list", to the tail of the L=
RU?
> >
>
> Yes, you are right.
>
> >>
> >>> btw, writeback isn't always async. it could be sync for zram and sync=
_io
> >>> swap. in that case, your patch might change the order of LRU. i mean,
> >>> for example, while a mTHP becomes cold, we always reclaim all of them=
,
> >>> but not part of them and put back part of small folios to the head of=
 lru.
> >>>
> >>
> >> Yes, This can be changed.
> >> Although it may put back part of small folios to the head of lru, it c=
an
> >> return in time from shrink_folio_list without causing much additional =
I/O.
> >>
> >> If you have understood this issue, do you have any suggestions to fix
> >> it? My patch may not be a perfect way to fix this issue.
> >>
> >
> > My point is that synchronous I/O, like zRAM, doesn't have this issue an=
d
> > doesn't require this fix, as writeback is always completed without
> > asynchronous latency.
> >
>
> I have tested zRAM and found no issues.
> This is version 1, and I don't know whether this fix will be accepted.
> If it is accepted, perhaps this patch could be modified to apply only to
> asynchronous io.

Consider a 2MB THP: when it becomes cold, we detect that it is cold and
decide to page it out. Even if we split it into 512 * 4KiB folios, the enti=
re
2MB is still cold, so we want pageout() to be called for the entire 2MB.
With your current approach, some parts of the 2MB are moved to the
LRU head while we're still paging out other parts, which seems
problematic.

Could we address this in move_folios_to_lru()? Perhaps we could find
a way to detect folios whose writeback has done and move them to the
tail instead of always placing them at the head.

>
> Best regards,
> Ridong
>
> >
> >> Best regards,
> >> Ridong
> >>

Thanks
Barry

