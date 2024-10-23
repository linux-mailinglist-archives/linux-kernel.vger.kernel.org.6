Return-Path: <linux-kernel+bounces-378799-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F47C9AD59C
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 22:37:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A5C521F262B8
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 20:37:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2EF71E2309;
	Wed, 23 Oct 2024 20:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kl3TbqaW"
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 390A875809;
	Wed, 23 Oct 2024 20:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729715812; cv=none; b=FqBwdnVMWAg/9gEEODOOZ8OSlTjWgbV0JqOGGkNKZ4q8gV/3lZsVg18OyKtenSf6fYTIeMq8EWeWiZPR0FB74y2K7bIGg+ezP17uRUoI8VBhSC+t2Ia5nNH8pyz9hqci/Kk/z5+Q4f+e+2ROEWjyWbYgsU9MXugjp6cW4yihh/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729715812; c=relaxed/simple;
	bh=7inbycXNVAFLBUope9rtODF93ynbYopv+uZWuiEajSw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Xs+Lpv6U3zFjoNmI9K1WVAedUc+AofhRo7bff6L3p44C6YBAjuGmCRK5tECJW3LMtQx4ybF3QADGfYvlD0szFbOS0RaDL8uWm0hhc6+x9YfHYojOSBnVa4Fe5QO8kJzLama23w7KPWD3Zukhj4FnsTM9r1u1mbdRSg/QD9rhmWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Kl3TbqaW; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-6cbe9e8bbb1so1613056d6.1;
        Wed, 23 Oct 2024 13:36:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729715810; x=1730320610; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TdCpUQcRCxycp1oA+hx4B9LdzkloT4+GShpJ+9vO7yQ=;
        b=Kl3TbqaWog+76NYX+aABxt6eq46bPb/nZ0oZdciGt1x2ng49hpUQGCjduv9eAnIdwv
         veNJEfW6UIRQCZSvvLbEegI3CwZ06YToZosT0ZW0ZSixmS7pAc+RXt9mIOb33u1nK7rB
         tH0FCEosCmD0TDegxc29MT1+nAriv1oUl/zwAVGJi3+3tn5mgCikogteSqGZj4v7Y76F
         l7B0RVi7RhwgVvuf74pe6kqmU7wGfn8ZvzPLA/Gs4WmbDv93wiyHJ6bkELqSJKXa4pXO
         5rk2DzUTjSf10ZBEnPs4EriJlG/oKooZX6jbOCTqaZ8dGY1Sp7AmrQlwKXk82GvPOgb1
         rAEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729715810; x=1730320610;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TdCpUQcRCxycp1oA+hx4B9LdzkloT4+GShpJ+9vO7yQ=;
        b=ntna7I1zEg7s+VkI3wjOTG7ftP0zJK/YLQsRK8IjlQixoGUS5vwMIr+8NpZ8EHiw3C
         jiQDNZoNUW1IEW6ZFcqsxypALe9x58l9YeJbwpZt6g1BU+PQdn7JHXGeWFngaCvctzBN
         DN5DWT9UEn1nX/b5nWViOTPEe5tw0uoSrcfi4QcWYDn59B++3yfMLieKRxGFzEJ4Y/RT
         gCNbu7r1dKkMYCCVuQQ+cg6k3I5iuqwKpl1xaFCm2nFFUzM7vcAmMLJ54ETxjGjC0cXA
         6qWa4dY1OyNncLxn2Q2R9FJ3XnN4gOQPF6FlguyusM242qmNMrXEYCzFkhepqWxdTAkt
         kTuw==
X-Forwarded-Encrypted: i=1; AJvYcCUPP3s9eD2wSzk9thMX2ei2yzw/EdvUZ652P1e0Hq0XYX/T55NHpQB5aEOlo9TOidPHJbK3X7e8shabCbsf@vger.kernel.org, AJvYcCV3UwsuTa0vDnS3lzaOcGf88kt4QNTeOQsjRB6uo+AAsMMysJVU90VN4HZWuy3Z6hMJdTa7TJojl+M=@vger.kernel.org
X-Gm-Message-State: AOJu0YzCfjdKQF0yk/O7kLPzvWynVsKNblMKpZF3Rydi8wWHBVRSPQjW
	pP4+zWQh64koV5WMt0TAJDPkUIULySplHREGswVG+vAP1ITTDCJ/SGUSZWu9vbvrHcwI+z6Vdur
	TT1XMDucKoPSwGBB5cDQikXVa9k0=
X-Google-Smtp-Source: AGHT+IEIYqmBvmyq1BnS7WqfOoZdQ4oafI10a+RJB/c7zG4TfRTuS9fXa0Ukj12YORhl0TDf8zx9lJRwakqv7QDcOvI=
X-Received: by 2002:a05:6214:598a:b0:6cb:255e:61a1 with SMTP id
 6a1803df08f44-6ce342f208fmr52989656d6.41.1729715809873; Wed, 23 Oct 2024
 13:36:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241018105026.2521366-1-usamaarif642@gmail.com>
 <CAGsJ_4xweuSwMUBuLSr2eUy69mtQumeDpMZ1g2jFPGq6nFn9fg@mail.gmail.com>
 <5313c721-9cf1-4ecd-ac23-1eeddabd691f@gmail.com> <b1c17b5e-acd9-4bef-820e-699768f1426d@gmail.com>
 <CAGsJ_4wykOyJupLhcqkSPe27rdANd=bOJhqxL74vcdZ+T9f==g@mail.gmail.com>
 <eab11780-e671-4d09-86a6-af4cf3589392@gmail.com> <CAGsJ_4wWf7QnibY_uU8B=efuEACrvFaJJ=bJTD+9KrxFtfoMmQ@mail.gmail.com>
 <CAGsJ_4w5XLMok4F6Xw7aTAdV6rY9OvCVPM3U+hzFnKyTXBUpOA@mail.gmail.com>
 <4c30cc30-0f7c-4ca7-a933-c8edfadaee5c@gmail.com> <7a14c332-3001-4b9a-ada3-f4d6799be555@gmail.com>
 <CAJD7tkbrjV3Px8h1p950VZFi9FnzxZPn2Kg+vZD69eEcsQvtxg@mail.gmail.com>
 <3dca2498-363c-4ba5-a7e6-80c5e5532db5@gmail.com> <CAGsJ_4zp=E7izB5oAAiWu14UCqNCSvWhveGoHCP6Wr030SHH1A@mail.gmail.com>
 <cb3f67c3-e8d3-4398-98c9-d5aee134fd4c@gmail.com>
In-Reply-To: <cb3f67c3-e8d3-4398-98c9-d5aee134fd4c@gmail.com>
From: Barry Song <21cnbao@gmail.com>
Date: Thu, 24 Oct 2024 09:36:38 +1300
Message-ID: <CAGsJ_4yHCpY7MX+9aBwkHvP1e93jzGrCzskJk1Xh1zuFw_d-bg@mail.gmail.com>
Subject: Re: [RFC 0/4] mm: zswap: add support for zswapin of large folios
To: Usama Arif <usamaarif642@gmail.com>
Cc: Yosry Ahmed <yosryahmed@google.com>, senozhatsky@chromium.org, minchan@kernel.org, 
	hanchuanhua@oppo.com, v-songbaohua@oppo.com, akpm@linux-foundation.org, 
	linux-mm@kvack.org, hannes@cmpxchg.org, david@redhat.com, willy@infradead.org, 
	kanchana.p.sridhar@intel.com, nphamcs@gmail.com, chengming.zhou@linux.dev, 
	ryan.roberts@arm.com, ying.huang@intel.com, riel@surriel.com, 
	shakeel.butt@linux.dev, kernel-team@meta.com, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 24, 2024 at 8:47=E2=80=AFAM Usama Arif <usamaarif642@gmail.com>=
 wrote:
>
>
>
> On 23/10/2024 19:52, Barry Song wrote:
> > On Thu, Oct 24, 2024 at 7:31=E2=80=AFAM Usama Arif <usamaarif642@gmail.=
com> wrote:
> >>
> >>
> >>
> >> On 23/10/2024 19:02, Yosry Ahmed wrote:
> >>> [..]
> >>>>>> I suspect the regression occurs because you're running an edge cas=
e
> >>>>>> where the memory cgroup stays nearly full most of the time (this i=
sn't
> >>>>>> an inherent issue with large folio swap-in). As a result, swapping=
 in
> >>>>>> mTHP quickly triggers a memcg overflow, causing a swap-out. The
> >>>>>> next swap-in then recreates the overflow, leading to a repeating
> >>>>>> cycle.
> >>>>>>
> >>>>>
> >>>>> Yes, agreed! Looking at the swap counters, I think this is what is =
going
> >>>>> on as well.
> >>>>>
> >>>>>> We need a way to stop the cup from repeatedly filling to the brim =
and
> >>>>>> overflowing. While not a definitive fix, the following change migh=
t help
> >>>>>> improve the situation:
> >>>>>>
> >>>>>> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> >>>>>>
> >>>>>> index 17af08367c68..f2fa0eeb2d9a 100644
> >>>>>> --- a/mm/memcontrol.c
> >>>>>> +++ b/mm/memcontrol.c
> >>>>>>
> >>>>>> @@ -4559,7 +4559,10 @@ int mem_cgroup_swapin_charge_folio(struct f=
olio
> >>>>>> *folio, struct mm_struct *mm,
> >>>>>>                 memcg =3D get_mem_cgroup_from_mm(mm);
> >>>>>>         rcu_read_unlock();
> >>>>>>
> >>>>>> -       ret =3D charge_memcg(folio, memcg, gfp);
> >>>>>> +       if (folio_test_large(folio) && mem_cgroup_margin(memcg) <
> >>>>>> MEMCG_CHARGE_BATCH)
> >>>>>> +               ret =3D -ENOMEM;
> >>>>>> +       else
> >>>>>> +               ret =3D charge_memcg(folio, memcg, gfp);
> >>>>>>
> >>>>>>         css_put(&memcg->css);
> >>>>>>         return ret;
> >>>>>> }
> >>>>>>
> >>>>>
> >>>>> The diff makes sense to me. Let me test later today and get back to=
 you.
> >>>>>
> >>>>> Thanks!
> >>>>>
> >>>>>> Please confirm if it makes the kernel build with memcg limitation
> >>>>>> faster. If so, let's
> >>>>>> work together to figure out an official patch :-) The above code h=
asn't consider
> >>>>>> the parent memcg's overflow, so not an ideal fix.
> >>>>>>
> >>>>
> >>>> Thanks Barry, I think this fixes the regression, and even gives an i=
mprovement!
> >>>> I think the below might be better to do:
> >>>>
> >>>> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> >>>> index c098fd7f5c5e..0a1ec55cc079 100644
> >>>> --- a/mm/memcontrol.c
> >>>> +++ b/mm/memcontrol.c
> >>>> @@ -4550,7 +4550,11 @@ int mem_cgroup_swapin_charge_folio(struct fol=
io *folio, struct mm_struct *mm,
> >>>>                 memcg =3D get_mem_cgroup_from_mm(mm);
> >>>>         rcu_read_unlock();
> >>>>
> >>>> -       ret =3D charge_memcg(folio, memcg, gfp);
> >>>> +       if (folio_test_large(folio) &&
> >>>> +           mem_cgroup_margin(memcg) < max(MEMCG_CHARGE_BATCH, folio=
_nr_pages(folio)))
> >>>> +               ret =3D -ENOMEM;
> >>>> +       else
> >>>> +               ret =3D charge_memcg(folio, memcg, gfp);
> >>>>
> >>>>         css_put(&memcg->css);
> >>>>         return ret;
> >>>>
> >>>>
> >>>> AMD 16K+32K THP=3Dalways
> >>>> metric         mm-unstable      mm-unstable + large folio zswapin se=
ries    mm-unstable + large folio zswapin + no swap thrashing fix
> >>>> real           1m23.038s        1m23.050s                           =
        1m22.704s
> >>>> user           53m57.210s       53m53.437s                          =
        53m52.577s
> >>>> sys            7m24.592s        7m48.843s                           =
        7m22.519s
> >>>> zswpin         612070           999244                              =
        815934
> >>>> zswpout        2226403          2347979                             =
        2054980
> >>>> pgfault        20667366         20481728                            =
        20478690
> >>>> pgmajfault     385887           269117                              =
        309702
> >>>>
> >>>> AMD 16K+32K+64K THP=3Dalways
> >>>> metric         mm-unstable      mm-unstable + large folio zswapin se=
ries   mm-unstable + large folio zswapin + no swap thrashing fix
> >>>> real           1m22.975s        1m23.266s                           =
       1m22.549s
> >>>> user           53m51.302s       53m51.069s                          =
       53m46.471s
> >>>> sys            7m40.168s        7m57.104s                           =
       7m25.012s
> >>>> zswpin         676492           1258573                             =
       1225703
> >>>> zswpout        2449839          2714767                             =
       2899178
> >>>> pgfault        17540746         17296555                            =
       17234663
> >>>> pgmajfault     429629           307495                              =
       287859
> >>>>
> >>>
> >>> Thanks Usama and Barry for looking into this. It seems like this woul=
d
> >>> fix a regression with large folio swapin regardless of zswap. Can the
> >>> same result be reproduced on zram without this series?
> >>
> >>
> >> Yes, its a regression in large folio swapin support regardless of zswa=
p/zram.
> >>
> >> Need to do 3 tests, one with probably the below diff to remove large f=
olio support,
> >> one with current upstream and one with upstream + swap thrashing fix.
> >>
> >> We only use zswap and dont have a zram setup (and I am a bit lazy to c=
reate one :)).
> >> Any zram volunteers to try this?
> >
> > Hi Usama,
> >
> > I tried a quick experiment:
> >
> > echo 1 > /sys/module/zswap/parameters/enabled
> > echo 0 > /sys/module/zswap/parameters/enabled
> >
> > This was to test the zRAM scenario. Enabling zswap even
> > once disables mTHP swap-in. :)
> >
> > I noticed a similar regression with zRAM alone, but the change resolved
> > the issue and even sped up the kernel build compared to the setup witho=
ut
> > mTHP swap-in.
>
> Thanks for trying, this is amazing!
> >
> > However, I=E2=80=99m still working on a proper patch to address this. T=
he current
> > approach:
> >
> > mem_cgroup_margin(memcg) < max(MEMCG_CHARGE_BATCH, folio_nr_pages(folio=
))
> >
> > isn=E2=80=99t sufficient, as it doesn=E2=80=99t cover cases where group=
 A contains group B, and
> > we=E2=80=99re operating within group B. The problem occurs not at the b=
oundary of
> > group B but at the boundary of group A.
>
> I am not sure I completely followed this. As MEMCG_CHARGE_BATCH=3D64, if =
we are
> trying to swapin a 16kB page, we basically check if atleast 64/4 =3D 16 f=
olios can be
> charged to cgroup, which is reasonable. If we try to swapin a 1M folio, w=
e just
> check if we can charge atleast 1 folio. Are you saying that checking just=
 1 folio
> is not enough in this case and can still cause thrashing, i.e we should c=
heck more?

My understanding is that cgroups are hierarchical. Even if we don=E2=80=99t
hit the memory
 limit of the folio=E2=80=99s direct memcg, we could still reach the limit =
of
one of its parent
memcgs. Imagine a structure like:

/sys/fs/cgroup/a/b/c/d

If we=E2=80=99re compiling the kernel in d, there=E2=80=99s a chance that w=
hile d
isn=E2=80=99t at its limit, its
parents (c, b, or a) could be. Currently, the check only applies to d.

>
> If we want to maintain consitency for all folios another option is
> mem_cgroup_margin(memcg) < MEMCG_CHARGE_BATCH * folio_nr_pages(folio)
> but I think this is too extreme, we would be checking if 64M can be charg=
ed to
> cgroup just to swapin 1M.
>
> >
> > I believe there=E2=80=99s still room for improvement. For example, if a=
 64KB charge
> > attempt fails, there=E2=80=99s no need to waste time trying 32KB or 16K=
B. We can
> > directly fall back to 4KB, as 32KB and 16KB will also fail based on our
> > margin detection logic.
> >
>
> Yes that makes sense. Would something like below work to fix that:
>
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index c098fd7f5c5e..0a1ec55cc079 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -4550,7 +4550,11 @@ int mem_cgroup_swapin_charge_folio(struct folio *f=
olio, struct mm_struct *mm,
>                 memcg =3D get_mem_cgroup_from_mm(mm);
>         rcu_read_unlock();
>
> -       ret =3D charge_memcg(folio, memcg, gfp);
> +       if (folio_test_large(folio) &&
> +           mem_cgroup_margin(memcg) < max(MEMCG_CHARGE_BATCH, folio_nr_p=
ages(folio)))
> +               ret =3D -ENOMEM;
> +       else
> +               ret =3D charge_memcg(folio, memcg, gfp);
>
>         css_put(&memcg->css);
>         return ret;
> diff --git a/mm/memory.c b/mm/memory.c
> index fecdd044bc0b..b6ce6605dc63 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -4123,6 +4123,7 @@ static struct folio *alloc_swap_folio(struct vm_fau=
lt *vmf)
>         pte_t *pte;
>         gfp_t gfp;
>         int order;
> +       int ret;
>
>         /*
>          * If uffd is active for the vma we need per-page fault fidelity =
to
> @@ -4170,9 +4171,13 @@ static struct folio *alloc_swap_folio(struct vm_fa=
ult *vmf)
>                 addr =3D ALIGN_DOWN(vmf->address, PAGE_SIZE << order);
>                 folio =3D vma_alloc_folio(gfp, order, vma, addr, true);
>                 if (folio) {
> -                       if (!mem_cgroup_swapin_charge_folio(folio, vma->v=
m_mm,
> -                                                           gfp, entry))
> +                       ret =3D mem_cgroup_swapin_charge_folio(folio, vma=
->vm_mm, gfp, entry);
> +                       if (!ret) {
>                                 return folio;
> +                       } else if (ret =3D=3D -ENOMEM) {
> +                               folio_put(folio);
> +                               goto fallback;
> +                       }
>                         folio_put(folio);
>                 }
>                 order =3D next_order(&orders, order);
>

Yes, does it make your kernel build even faster?

Thanks
Barry

