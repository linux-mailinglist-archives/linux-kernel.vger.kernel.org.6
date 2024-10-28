Return-Path: <linux-kernel+bounces-385953-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A8D29B3D77
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 23:05:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9D3361C213F7
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 22:05:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8A0C1F4293;
	Mon, 28 Oct 2024 22:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b7qBxFg3"
Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D789C1F12E1
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 22:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730153022; cv=none; b=KzIphh016FX/csedFZuiNhYU0/TZgATnnZ0dLy8warXJfhks/ZOJ8vw6z4DQNb/W60xHvdt0yCdaf2+2I5SHCdvvhASJj4VnsleyCpBzZaEU7tMB4BZFJkyk6zO8nmb6bnVgVGWVNRe8DTu1URCs2Dp5kt+ciFXf1vfyFNvzt9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730153022; c=relaxed/simple;
	bh=jGoL/5uXUjISCBS5tUb3oUCfyV3nqV5xj8bXGuRp+HE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KgRG8ICTYbVopVr4Isd6Rgqaq1vCcaQy655l7EC+vWWAGx9b/VZlob2lniGpHbVX1nhkM60xJEbutYVphZUAicJqsE3GXq6K70F1DexyZWt2QBVmxqWk4WBnwWFRPoIW5xaOk5aLxnV5T4xo5CnSasTVVMv39CYoHGz0ubsB40M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b7qBxFg3; arc=none smtp.client-ip=209.85.160.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-29066daf9e2so1117978fac.3
        for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 15:03:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730153019; x=1730757819; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VT25SlOP/9heYhhMY9JcTBuLz9APZ46BG6zc+j69VGg=;
        b=b7qBxFg3LwMp1o1rmyxRI0CHlmo8BAKidytD47BTDM2eN8yQC7Tce0cg0HJS9VaHHf
         lRfnhhuDmZ6RCzLpaHJ686V5vvPOMs0VvZ1cJfoz7K+mGiqUQnMSxPTld5JKSwbJd3FE
         RriyI5FO0KA9HSjaYwnizVCg4oLRWIw1dvyqpe1NufiSBQeDARyL5nebPQi53LhxX7ZE
         k6WQBeUZL8bekSvJL09QmMDuatxfRi/pwS+qXfsn7CKmZUX6dC/LYfPSAXyFcgAl8fKO
         xjc6aFZp2DsbzBSnz6nN80OlWgDURv9JQ9cAJnP+otlHN3Np3B79Mi2ex7naqPW4hQtm
         vHtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730153019; x=1730757819;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VT25SlOP/9heYhhMY9JcTBuLz9APZ46BG6zc+j69VGg=;
        b=GJwFiya6gxiHK0CLEhyoSlTzjDqtP7d85Ml7pG3EvwH9Ra592xK6R3UfKLTRoLhElE
         urMC6C6mtODfMpXn9hmeo3AuR6jQXMvuqTwdAtGooJ3iLgGRrMRd0XwuixW5H+Tz31A2
         L4AbfcmEaDwwtZfr6/nuu5YQWzcrnXGSDOCwCzKvO8JKAIs9ebSeaiHUeiDswsSnhHvn
         br3CGt3kWGj1dndToJIm0eP5UXs6Q2R4jLM8+JratKiwcn0BO2CTbRvaCP6cftqCv415
         dx/g/BUyE96vrhhCdLXZew2HUUSQkyX9QjIm/dyrnjA2qGQETneNGlcKgm6B2pNjcHjG
         XKYg==
X-Forwarded-Encrypted: i=1; AJvYcCXehsl9VkQJne7hi30z61eZBgg4xzCfkUXCsj9a8yG7/I0QOPg1lgoqTjJpqkFTCd48qkmXyTPwg5+U85I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7jSUloPUa9aCicywtWSNU+CpPhEbuTguPo3hXorPtik6CRaOC
	33KIwTbjeYm8NiYdGKLjmqp316TV6X/wGMLZISeveHSQAg3WnciY5ioO2Acg/MfL5uSMbb1WWXi
	iUbhFVgUIxaFytwrpmUGa6x4c814br9zS
X-Google-Smtp-Source: AGHT+IGrZe8I93wFWl+f5BfDBwq3fQDCPB5HaKZjGp/PpGK1c95TPeD47dpehxlL4PQavuFn5xVqjBJKD0SKa1d0CgM=
X-Received: by 2002:a05:6870:d10e:b0:270:276d:fb54 with SMTP id
 586e51a60fabf-29051c0405fmr8640821fac.21.1730153018811; Mon, 28 Oct 2024
 15:03:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241027001444.3233-1-21cnbao@gmail.com> <33c5d5ca-7bc4-49dc-b1c7-39f814962ae0@gmail.com>
In-Reply-To: <33c5d5ca-7bc4-49dc-b1c7-39f814962ae0@gmail.com>
From: Barry Song <21cnbao@gmail.com>
Date: Tue, 29 Oct 2024 06:03:27 +0800
Message-ID: <CAGsJ_4wdgptMK0dDTC5g66OE9WDxFDt7ixDQaFCjuHdTyTEGiA@mail.gmail.com>
Subject: Re: [PATCH RFC] mm: mitigate large folios usage and swap thrashing
 for nearly full memcg
To: Usama Arif <usamaarif642@gmail.com>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Barry Song <v-songbaohua@oppo.com>, 
	Kanchana P Sridhar <kanchana.p.sridhar@intel.com>, David Hildenbrand <david@redhat.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, Chris Li <chrisl@kernel.org>, 
	Yosry Ahmed <yosryahmed@google.com>, "Huang, Ying" <ying.huang@intel.com>, 
	Kairui Song <kasong@tencent.com>, Ryan Roberts <ryan.roberts@arm.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Muchun Song <muchun.song@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 28, 2024 at 8:07=E2=80=AFPM Usama Arif <usamaarif642@gmail.com>=
 wrote:
>
>
>
> On 27/10/2024 01:14, Barry Song wrote:
> > From: Barry Song <v-songbaohua@oppo.com>
> >
> > In a memcg where mTHP is always utilized, even at full capacity, it
> > might not be the best option. Consider a system that uses only small
> > folios: after each reclamation, a process has at least SWAP_CLUSTER_MAX
> > of buffer space before it can initiate the next reclamation. However,
> > large folios can quickly fill this space, rapidly bringing the memcg
> > back to full capacity, even though some portions of the large folios
> > may not be immediately needed and used by the process.
> >
> > Usama and Kanchana identified a regression when building the kernel in
> > a memcg with memory.max set to a small value while enabling large
> > folio swap-in support on zswap[1].
> >
> > The issue arises from an edge case where the memory cgroup remains
> > nearly full most of the time. Consequently, bringing in mTHP can
> > quickly cause a memcg overflow, triggering a swap-out. The subsequent
> > swap-in then recreates the overflow, resulting in a repetitive cycle.
> >
> > We need a mechanism to stop the cup from overflowing continuously.
> > One potential solution is to slow the filling process when we identify
> > that the cup is nearly full.
> >
> > Usama reported an improvement when we mitigate mTHP swap-in as the
> > memcg approaches full capacity[2]:
> >
> > int mem_cgroup_swapin_charge_folio(...)
> > {
> >       ...
> >       if (folio_test_large(folio) &&
> >           mem_cgroup_margin(memcg) < max(MEMCG_CHARGE_BATCH, folio_nr_p=
ages(folio)))
> >               ret =3D -ENOMEM;
> >       else
> >               ret =3D charge_memcg(folio, memcg, gfp);
> >       ...
> > }
> >
> > AMD 16K+32K THP=3Dalways
> > metric         mm-unstable      mm-unstable + large folio zswapin serie=
s    mm-unstable + large folio zswapin + no swap thrashing fix
> > real           1m23.038s        1m23.050s                              =
     1m22.704s
> > user           53m57.210s       53m53.437s                             =
     53m52.577s
> > sys            7m24.592s        7m48.843s                              =
     7m22.519s
> > zswpin         612070           999244                                 =
     815934
> > zswpout        2226403          2347979                                =
     2054980
> > pgfault        20667366         20481728                               =
     20478690
> > pgmajfault     385887           269117                                 =
     309702
> >
> > AMD 16K+32K+64K THP=3Dalways
> > metric         mm-unstable      mm-unstable + large folio zswapin serie=
s   mm-unstable + large folio zswapin + no swap thrashing fix
> > real           1m22.975s        1m23.266s                              =
    1m22.549s
> > user           53m51.302s       53m51.069s                             =
    53m46.471s
> > sys            7m40.168s        7m57.104s                              =
    7m25.012s
> > zswpin         676492           1258573                                =
    1225703
> > zswpout        2449839          2714767                                =
    2899178
> > pgfault        17540746         17296555                               =
    17234663
> > pgmajfault     429629           307495                                 =
    287859
> >
> > I wonder if we can extend the mitigation to do_anonymous_page() as
> > well. Without hardware like AMD and ARM with hardware TLB coalescing
> > or CONT-PTE, I conducted a quick test on my Intel i9 workstation with
> > 10 cores and 2 threads. I enabled one 12 GiB zRAM while running kernel
> > builds in a memcg with memory.max set to 1 GiB.
> >
> > $ echo always > /sys/kernel/mm/transparent_hugepage/hugepages-64kB/enab=
led
> > $ echo always > /sys/kernel/mm/transparent_hugepage/hugepages-32kB/enab=
led
> > $ echo always > /sys/kernel/mm/transparent_hugepage/hugepages-16kB/enab=
led
> > $ echo never > /sys/kernel/mm/transparent_hugepage/hugepages-2048kB/ena=
bled
> >
> > $ time systemd-run --scope -p MemoryMax=3D1G make ARCH=3Darm64 \
> > CROSS_COMPILE=3Daarch64-linux-gnu- Image -10 1>/dev/null 2>/dev/null
> >
> >             disable-mTHP-swapin  mm-unstable  with-this-patch
> > Real:            6m54.595s      7m4.832s       6m45.811s
> > User:            66m42.795s     66m59.984s     67m21.150s
> > Sys:             12m7.092s      15m18.153s     12m52.644s
> > pswpin:          4262327        11723248       5918690
> > pswpout:         14883774       19574347       14026942
> > 64k-swpout:      624447         889384         480039
> > 32k-swpout:      115473         242288         73874
> > 16k-swpout:      158203         294672         109142
> > 64k-swpin:       0              495869         159061
> > 32k-swpin:       0              219977         56158
> > 16k-swpin:       0              223501         81445
> >
>

Hi Usama,

> hmm, both the user and sys time are worse with the patch compared to
> disable-mTHP-swapin. I wonder if the real time is an anomaly and if you
> repeat the experiment the real time might be worse as well?

Well, I've improved my script to include a loop:

echo always > /sys/kernel/mm/transparent_hugepage/hugepages-64kB/enabled
echo always > /sys/kernel/mm/transparent_hugepage/hugepages-32kB/enabled
echo always > /sys/kernel/mm/transparent_hugepage/hugepages-16kB/enabled
echo never > /sys/kernel/mm/transparent_hugepage/hugepages-2048kB/enabled

for ((i=3D1; i<=3D100; i++))
do
  echo "Executing round $i"
  make ARCH=3Darm64 CROSS_COMPILE=3Daarch64-linux-gnu- clean 1>/dev/null 2>=
/dev/null
  echo 3 > /proc/sys/vm/drop_caches
  time systemd-run --scope -p MemoryMax=3D1G make ARCH=3Darm64 \
        CROSS_COMPILE=3Daarch64-linux-gnu- vmlinux -j15 1>/dev/null 2>/dev/=
null
  cat /proc/vmstat | grep pswp
  echo -n 64k-swpout: ; cat
/sys/kernel/mm/transparent_hugepage/hugepages-64kB/stats/swpout
  echo -n 32k-swpout: ; cat
/sys/kernel/mm/transparent_hugepage/hugepages-32kB/stats/swpout
  echo -n 16k-swpout: ; cat
/sys/kernel/mm/transparent_hugepage/hugepages-16kB/stats/swpout
  echo -n 64k-swpin: ; cat
/sys/kernel/mm/transparent_hugepage/hugepages-64kB/stats/swpin
  echo -n 32k-swpin: ; cat
/sys/kernel/mm/transparent_hugepage/hugepages-32kB/stats/swpin
  echo -n 16k-swpin: ; cat
/sys/kernel/mm/transparent_hugepage/hugepages-16kB/stats/swpin
done

I've noticed that the user/sys/real time on my i9 machine fluctuates
constantly, could be things
like:
real    6m52.087s
user    67m12.463s
sys     13m8.281s
...

real    7m42.937s
user    66m55.250s
sys     12m56.330s
...

real    6m49.374s
user    66m37.040s
sys     12m44.542s
...

real    6m54.205s
user    65m49.732s
sys     11m33.078s
...

likely due to unstable temperatures and I/O latency. As a result, my
data doesn=E2=80=99t seem
reference-worthy.

As a phone engineer, we never use phones to run kernel builds. I'm also
quite certain that phones won't provide stable and reliable data for this
type of workload. Without access to a Linux server to conduct the test,
I really need your help.

I used to work on optimizing the ARM server scheduler and memory
management, and I really miss that machine I had until three years ago :-)

>
> > I need Usama's assistance to identify a suitable patch, as I lack
> > access to hardware such as AMD machines and ARM servers with TLB
> > optimization.
> >
> > [1] https://lore.kernel.org/all/b1c17b5e-acd9-4bef-820e-699768f1426d@gm=
ail.com/
> > [2] https://lore.kernel.org/all/7a14c332-3001-4b9a-ada3-f4d6799be555@gm=
ail.com/
> >
> > Cc: Kanchana P Sridhar <kanchana.p.sridhar@intel.com>
> > Cc: Usama Arif <usamaarif642@gmail.com>
> > Cc: David Hildenbrand <david@redhat.com>
> > Cc: Baolin Wang <baolin.wang@linux.alibaba.com>
> > Cc: Chris Li <chrisl@kernel.org>
> > Cc: Yosry Ahmed <yosryahmed@google.com>
> > Cc: "Huang, Ying" <ying.huang@intel.com>
> > Cc: Kairui Song <kasong@tencent.com>
> > Cc: Ryan Roberts <ryan.roberts@arm.com>
> > Cc: Johannes Weiner <hannes@cmpxchg.org>
> > Cc: Michal Hocko <mhocko@kernel.org>
> > Cc: Roman Gushchin <roman.gushchin@linux.dev>
> > Cc: Shakeel Butt <shakeel.butt@linux.dev>
> > Cc: Muchun Song <muchun.song@linux.dev>
> > Signed-off-by: Barry Song <v-songbaohua@oppo.com>
> > ---
> >  include/linux/memcontrol.h |  9 ++++++++
> >  mm/memcontrol.c            | 45 ++++++++++++++++++++++++++++++++++++++
> >  mm/memory.c                | 17 ++++++++++++++
> >  3 files changed, 71 insertions(+)
> >
> > diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> > index 524006313b0d..8bcc8f4af39f 100644
> > --- a/include/linux/memcontrol.h
> > +++ b/include/linux/memcontrol.h
> > @@ -697,6 +697,9 @@ static inline int mem_cgroup_charge(struct folio *f=
olio, struct mm_struct *mm,
> >  int mem_cgroup_hugetlb_try_charge(struct mem_cgroup *memcg, gfp_t gfp,
> >               long nr_pages);
> >
> > +int mem_cgroup_precharge_large_folio(struct mm_struct *mm,
> > +                             swp_entry_t *entry);
> > +
> >  int mem_cgroup_swapin_charge_folio(struct folio *folio, struct mm_stru=
ct *mm,
> >                                 gfp_t gfp, swp_entry_t entry);
> >
> > @@ -1201,6 +1204,12 @@ static inline int mem_cgroup_hugetlb_try_charge(=
struct mem_cgroup *memcg,
> >       return 0;
> >  }
> >
> > +static inline int mem_cgroup_precharge_large_folio(struct mm_struct *m=
m,
> > +             swp_entry_t *entry)
> > +{
> > +     return 0;
> > +}
> > +
> >  static inline int mem_cgroup_swapin_charge_folio(struct folio *folio,
> >                       struct mm_struct *mm, gfp_t gfp, swp_entry_t entr=
y)
> >  {
> > diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> > index 17af08367c68..f3d92b93ea6d 100644
> > --- a/mm/memcontrol.c
> > +++ b/mm/memcontrol.c
> > @@ -4530,6 +4530,51 @@ int mem_cgroup_hugetlb_try_charge(struct mem_cgr=
oup *memcg, gfp_t gfp,
> >       return 0;
> >  }
> >
> > +static inline bool mem_cgroup_has_margin(struct mem_cgroup *memcg)
> > +{
> > +     for (; !mem_cgroup_is_root(memcg); memcg =3D parent_mem_cgroup(me=
mcg)) {
> > +             if (mem_cgroup_margin(memcg) < HPAGE_PMD_NR)
>
> There might be 3 issues with the approach:
>
> Its a very big margin, lets say you have ARM64_64K_PAGES, and you have
> 256K THP set to always. As HPAGE_PMD is 512M for 64K page, you are
> basically saying you need 512M free memory to swapin just 256K?

Right, sorry for the noisy code. I was just thinking about 4KB pages
and wondering
if we could simplify the code.

>
> Its an uneven margin for different folio sizes.
> For 16K folio swapin, you are checking if there is margin for 128 folios,
> but for 1M folio swapin, you are checking there is margin for just 2 foli=
os.
>
> Maybe it might be better to make this dependent on some factor of folio_n=
r_pages?

Agreed. This is similar to what we discussed regarding your zswap mTHP
swap-in series:

 int mem_cgroup_swapin_charge_folio(...)
 {
       ...
       if (folio_test_large(folio) &&
           mem_cgroup_margin(memcg) < max(MEMCG_CHARGE_BATCH,
folio_nr_pages(folio)))
               ret =3D -ENOMEM;
       else
               ret =3D charge_memcg(folio, memcg, gfp);
       ...
 }

As someone focused on phones, my challenge is the absence of stable platfor=
ms to
benchmark this type of workload. If possible, Usama, I would greatly
appreciate it if
you could take the lead on the patch.

>
> As Johannes pointed out, the charging code already does the margin check.
> So for 4K, the check just checks if there is 4K available, but for 16K it=
 checks
> if a lot more than 16K is available. Maybe there should be a similar poli=
cy for
> all? I guess this is similar to my 2nd point, but just considers 4K folio=
s as
> well.

I don't think the charging code performs a margin check. It simply
tries to charge
the specified nr_pages (whether 1 or more). If nr_pages are available,
the charge
proceeds; otherwise, if GFP allows blocking, it triggers memory reclamation=
 to
reclaim max(SWAP_CLUSTER_MAX, nr_pages) base pages.

If, after reclamation, we have exactly SWAP_CLUSTER_MAX pages available, a
large folio with nr_pages =3D=3D SWAP_CLUSTER_MAX will successfully charge,
immediately filling the memcg.

Shortly after, smaller folios=E2=80=94typically with blockable GFP=E2=80=94=
will quickly trigger
additional reclamation. While nr_pages - 1 subpages of the large folio may =
not
be immediately needed, they still occupy enough space to fill the memcg to
capacity.

My second point about the mitigation is as follows: For a system (or
memcg) under severe memory pressure, especially one without hardware TLB
optimization, is enabling mTHP always the right choice? Since mTHP operates=
 at
a larger granularity, some internal fragmentation is unavoidable, regardles=
s
of optimization. Could the mitigation code help in automatically tuning
this fragmentation?

>
> Thanks,
> Usama
>
>
> > +                     return false;
> > +     }
> > +
> > +     return true;
> > +}
> > +
> > +/**
> > + * mem_cgroup_swapin_precharge_large_folio: Precharge large folios.
> > + *
> > + * @mm: mm context of the victim
> > + * @entry: swap entry for which the folio will be allocated
> > + *
> > + * If we are arriving the edge of an almost full memcg, return error s=
o that
> > + * swap-in and anon faults can quickly fall back to small folios to av=
oid swap
> > + * thrashing.
> > + *
> > + * Returns 0 on success, an error code on failure.
> > + */
> > +int mem_cgroup_precharge_large_folio(struct mm_struct *mm, swp_entry_t=
 *entry)
> > +{
> > +     struct mem_cgroup *memcg =3D NULL;
> > +     unsigned short id;
> > +     bool has_margin;
> > +
> > +     if (mem_cgroup_disabled())
> > +             return 0;
> > +
> > +     rcu_read_lock();
> > +     if (entry) {
> > +             id =3D lookup_swap_cgroup_id(*entry);
> > +             memcg =3D mem_cgroup_from_id(id);
> > +     }
> > +     if (!memcg || !css_tryget_online(&memcg->css))
> > +             memcg =3D get_mem_cgroup_from_mm(mm);
> > +     has_margin =3D mem_cgroup_has_margin(memcg);
> > +     rcu_read_unlock();
> > +
> > +     css_put(&memcg->css);
> > +     return has_margin ? 0 : -ENOMEM;
> > +}
> > +
> >  /**
> >   * mem_cgroup_swapin_charge_folio - Charge a newly allocated folio for=
 swapin.
> >   * @folio: folio to charge.
> > diff --git a/mm/memory.c b/mm/memory.c
> > index 0f614523b9f4..96368ba0e8a6 100644
> > --- a/mm/memory.c
> > +++ b/mm/memory.c
> > @@ -4168,6 +4168,16 @@ static struct folio *alloc_swap_folio(struct vm_=
fault *vmf)
> >
> >       pte_unmap_unlock(pte, ptl);
> >
> > +     if (!orders)
> > +             goto fallback;
> > +
> > +     /*
> > +      * Avoid swapping in large folios when memcg is nearly full, as i=
t
> > +      * may quickly trigger additional swap-out and swap-in cycles.
> > +      */
> > +     if (mem_cgroup_precharge_large_folio(vma->vm_mm, &entry))
> > +             goto fallback;
> > +
> >       /* Try allocating the highest of the remaining orders. */
> >       gfp =3D vma_thp_gfp_mask(vma);
> >       while (orders) {
> > @@ -4707,6 +4717,13 @@ static struct folio *alloc_anon_folio(struct vm_=
fault *vmf)
> >       if (!orders)
> >               goto fallback;
> >
> > +     /*
> > +      * When memcg is nearly full, large folios can rapidly fill
> > +      * the margin and trigger new reclamation
> > +      */
> > +     if (mem_cgroup_precharge_large_folio(vma->vm_mm, NULL))
> > +             goto fallback;
> > +
> >       /* Try allocating the highest of the remaining orders. */
> >       gfp =3D vma_thp_gfp_mask(vma);
> >       while (orders) {
>

Thanks
Barry

