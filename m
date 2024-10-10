Return-Path: <linux-kernel+bounces-359547-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A6BE4998D10
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 18:17:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2DBE82841A1
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 16:17:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F5C51CDA2D;
	Thu, 10 Oct 2024 16:17:32 +0000 (UTC)
Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3D251CCB3A
	for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 16:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728577051; cv=none; b=GIel+HsaaTi6tHzYVRkmxniL7jhye8ngOTIJByqqU8MkLkyAZMrcYGyAWIA1o3vCHDfxfzUgJ7N/KF9oBtyXRsavxDdl/xQDW1A1Ah5W4Dc/w+9qrx07tPY2v2MVop1qJmQ1Hs75fXa2ofv/BgxBlIx45nncBi5WlFDa1ZaU6Ds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728577051; c=relaxed/simple;
	bh=z+LBwvuQNOWkbzeij4Gxj0pXvof+ckisSpZgiJaUe0g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QDb/T83wDX71hURC2vYi6zUDFBifloVPQs5eI/J7sAPR4Cs3BsU1ybip12Fsxb2jtb6qqDcxlR2hy9QTqkN1NO3tz371iYRGckd+/u+nyWL6bu3lUS/32CJDhRWFFi/S+t8xJdQO6ykvgbzdpvoKApw2t6J0U2X78hH4iYv1ZHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.160.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-2870ce5e9e8so506721fac.3
        for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 09:17:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728577049; x=1729181849;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9ggyZZMYXw3cQfBqSZJ3mRpUxqE54sjhDul++k7ziUQ=;
        b=qrS2SLgfKwhiQOi+nOuOtNFXaQnJWjaEBM+4db+840yaEiEBcREjY1ZXpvULIDZft7
         zExrwSDGeIlLKsdgOUPJgy4xZ4JOqNJjfvmEhoOt+3UHQwmFKRRDUxiRyQfKX8Q+ArpS
         YjAPi87oGyaBBdh0OAQ8zd+41wAvKvN04TZ86KHnf2m21+ZvRJ+STlZ9JbioctiPdgjT
         /20rRFtX+m0jyRJzmRhMZFJ17PvFw/8xiLJjsJxWxJilogsM5s9qxJNWUd2ER1+f8dy1
         tml5BA7Ftj3W2qvhr5XKJjJ41uNIfgxqkVIoXUYk0UJWkVRsvYd7+bzxPt3GxxDUtNB0
         OleA==
X-Forwarded-Encrypted: i=1; AJvYcCVj13nh6HylnlhcojDVbueoIZjcLYMHpwg1yFBfTcrxFzuWmL0MrDqfvdKTJnC6xc6nzTJvo0IexPKj3Mk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwjVSWlL4l8qoje6cUxhzh5zHB3wFvSgeIWSGyvWbuNmJXfNfzQ
	HSTcipgd68ScYL42s0rdZgcSMxt9+uiKfTfQ6irwY31gKqNCoZ0PNHY9GOp2TAtvRz6e8jJwFjl
	u9kaf7wXvP59/Wxdn8ueVjuIEd4w=
X-Google-Smtp-Source: AGHT+IFTdW5DEZv1SE87vgLU4viEbBsDhZfUbFb+rtHiE1ZWfovnQa71SQDkA5Vmz7Yi0uughElhQ0dbeyTw7r7/X2w=
X-Received: by 2002:a05:6871:549:b0:27b:6762:3fdb with SMTP id
 586e51a60fabf-2884a6b3998mr4829678fac.6.1728577048960; Thu, 10 Oct 2024
 09:17:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241010081802.290893-1-chenridong@huaweicloud.com> <c3f2c5e2-4804-46e8-86ff-1f6a79ea9a7c@huawei.com>
In-Reply-To: <c3f2c5e2-4804-46e8-86ff-1f6a79ea9a7c@huawei.com>
From: Barry Song <baohua@kernel.org>
Date: Fri, 11 Oct 2024 00:17:17 +0800
Message-ID: <CAGsJ_4zR+=80S_Fz1ZV3iZxjVKUE3-f32w7W1smuAgZM=HrPRQ@mail.gmail.com>
Subject: Re: [PATCH v3] mm/vmscan: stop the loop if enough pages have been page_out
To: Kefeng Wang <wangkefeng.wang@huawei.com>
Cc: Chen Ridong <chenridong@huaweicloud.com>, akpm@linux-foundation.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, chenridong@huawei.com, 
	wangweiyang2@huawei.com, Michal Hocko <mhocko@suse.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, Yosry Ahmed <yosryahmed@google.com>, Yu Zhao <yuzhao@google.com>, 
	David Hildenbrand <david@redhat.com>, Matthew Wilcox <willy@infradead.org>, 
	Ryan Roberts <ryan.roberts@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 10, 2024 at 4:59=E2=80=AFPM Kefeng Wang <wangkefeng.wang@huawei=
.com> wrote:
>
> Hi Ridong,
>
> This should be the first version for upstream, and the issue only
> occurred when large folio is spited.
>
> Adding more CCs to see if there's more feedback.
>
>
> On 2024/10/10 16:18, Chen Ridong wrote:
> > From: Chen Ridong <chenridong@huawei.com>
> >
> > An issue was found with the following testing step:
> > 1. Compile with CONFIG_TRANSPARENT_HUGEPAGE=3Dy
> > 2. Mount memcg v1, and create memcg named test_memcg and set
> >     usage_in_bytes=3D2.1G, memsw.usage_in_bytes=3D3G.
> > 3. Create a 1G swap file, and allocate 2.2G anon memory in test_memcg.
> >
> > It was found that:
> >
> > cat memory.usage_in_bytes
> > 2144940032
> > cat memory.memsw.usage_in_bytes
> > 2255056896
> >
> > free -h
> >                total        used        free
> > Mem:           31Gi       2.1Gi        27Gi
> > Swap:         1.0Gi       618Mi       405Mi
> >
> > As shown above, the test_memcg used about 100M swap, but 600M+ swap mem=
ory
> > was used, which means that 500M may be wasted because other memcgs can =
not
> > use these swap memory.
> >
> > It can be explained as follows:
> > 1. When entering shrink_inactive_list, it isolates folios from lru from
> >     tail to head. If it just takes folioN from lru(make it simple).
> >
> >     inactive lru: folio1<->folio2<->folio3...<->folioN-1
> >     isolated list: folioN
> >
> > 2. In shrink_page_list function, if folioN is THP, it may be splited an=
d
> >     added to swap cache folio by folio. After adding to swap cache, it =
will
> >     submit io to writeback folio to swap, which is asynchronous.
> >     When shrink_page_list is finished, the isolated folios list will be
> >     moved back to the head of inactive lru. The inactive lru may just l=
ook
> >     like this, with 512 filioes have been move to the head of inactive =
lru.
> >
> >     folioN512<->folioN511<->...filioN1<->folio1<->folio2...<->folioN-1
> >
> > 3. When folio writeback io is completed, the folio may be rotated to ta=
il
> >     of lru. The following lru list is expected, with those filioes that=
 have
> >     been added to swap cache are rotated to tail of lru. So those folio=
s
> >     can be reclaimed as soon as possible.
> >
> >     folio1<->folio2<->...<->folioN-1<->filioN1<->...folioN511<->folioN5=
12
> >
> > 4. However, shrink_page_list and folio writeback are asynchronous. If T=
HP
> >     is splited, shrink_page_list loops at least 512 times, which means =
that
> >     shrink_page_list is not completed but some folios writeback have be=
en
> >     completed, and this may lead to failure to rotate these folios to t=
he
> >     tail of lru. The lru may look likes as below:

I assume you=E2=80=99re referring to PMD-mapped THP, but your code also mod=
ifies
mTHP, which might not be that large. For instance, it could be a 16KB mTHP.

> >
> >     folioN50<->folioN49<->...filioN1<->folio1<->folio2...<->folioN-1<->
> >     folioN51<->folioN52<->...folioN511<->folioN512
> >
> >     Although those folios (N1-N50) have been finished writing back, the=
y
> >     are still at the head of lru. When isolating folios from lru, it sc=
ans
> >     from tail to head, so it is difficult to scan those folios again.
> >
> > What mentioned above may lead to a large number of folios have been add=
ed
> > to swap cache but can not be reclaimed in time, which may reduce reclai=
m
> > efficiency and prevent other memcgs from using this swap memory even if
> > they trigger OOM.
> >
> > To fix this issue, it's better to stop looping if THP has been splited =
and
> > nr_pageout is greater than nr_to_reclaim.
> >
> > Signed-off-by: Chen Ridong <chenridong@huawei.com>
> > ---
> >   mm/vmscan.c | 16 +++++++++++++++-
> >   1 file changed, 15 insertions(+), 1 deletion(-)
> >
> > diff --git a/mm/vmscan.c b/mm/vmscan.c
> > index 749cdc110c74..fd8ad251eda2 100644
> > --- a/mm/vmscan.c
> > +++ b/mm/vmscan.c
> > @@ -1047,7 +1047,7 @@ static unsigned int shrink_folio_list(struct list=
_head *folio_list,
> >       LIST_HEAD(demote_folios);
> >       unsigned int nr_reclaimed =3D 0;
> >       unsigned int pgactivate =3D 0;
> > -     bool do_demote_pass;
> > +     bool do_demote_pass, splited =3D false;
> >       struct swap_iocb *plug =3D NULL;
> >
> >       folio_batch_init(&free_folios);
> > @@ -1065,6 +1065,16 @@ static unsigned int shrink_folio_list(struct lis=
t_head *folio_list,
> >
> >               cond_resched();
> >
> > +             /*
> > +              * If a large folio has been split, many folios are added
> > +              * to folio_list. Looping through the entire list takes
> > +              * too much time, which may prevent folios that have comp=
leted
> > +              * writeback from rotateing to the tail of the lru. Just
> > +              * stop looping if nr_pageout is greater than nr_to_recla=
im.
> > +              */
> > +             if (unlikely(splited && stat->nr_pageout > sc->nr_to_recl=
aim))
> > +                     break;

I=E2=80=99m not entirely sure about the theory behind comparing stat->nr_pa=
geout
with sc->nr_to_reclaim. However, the condition might still hold true even
if you=E2=80=99ve split a relatively small =E2=80=9Clarge folio,=E2=80=9D s=
uch as 16kB?

> > +
> >               folio =3D lru_to_folio(folio_list);
> >               list_del(&folio->lru);
> >
> > @@ -1273,6 +1283,7 @@ static unsigned int shrink_folio_list(struct list=
_head *folio_list,
> >               if ((nr_pages > 1) && !folio_test_large(folio)) {
> >                       sc->nr_scanned -=3D (nr_pages - 1);
> >                       nr_pages =3D 1;
> > +                     splited =3D true;
> >               }
> >
> >               /*
> > @@ -1375,12 +1386,14 @@ static unsigned int shrink_folio_list(struct li=
st_head *folio_list,
> >                               if (nr_pages > 1 && !folio_test_large(fol=
io)) {
> >                                       sc->nr_scanned -=3D (nr_pages - 1=
);
> >                                       nr_pages =3D 1;
> > +                                     splited =3D true;
> >                               }
> >                               goto activate_locked;
> >                       case PAGE_SUCCESS:
> >                               if (nr_pages > 1 && !folio_test_large(fol=
io)) {
> >                                       sc->nr_scanned -=3D (nr_pages - 1=
);
> >                                       nr_pages =3D 1;
> > +                                     splited =3D true;
> >                               }
> >                               stat->nr_pageout +=3D nr_pages;
> >
> > @@ -1491,6 +1504,7 @@ static unsigned int shrink_folio_list(struct list=
_head *folio_list,
> >               if (nr_pages > 1) {
> >                       sc->nr_scanned -=3D (nr_pages - 1);
> >                       nr_pages =3D 1;
> > +                     splited =3D true;
> >               }
> >   activate_locked:
> >               /* Not a candidate for swapping, so reclaim swap space. *=
/
>

