Return-Path: <linux-kernel+bounces-389528-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D3F949B6E10
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 21:49:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 42FD6B228BA
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 20:49:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91D311FF606;
	Wed, 30 Oct 2024 20:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j+IbFrSx"
Received: from mail-vk1-f177.google.com (mail-vk1-f177.google.com [209.85.221.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1DB91EC016
	for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 20:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730321312; cv=none; b=FbiqCac2/8RaOw9TwOV9lKjJrRaqUh91alJKoedBoZD2xlCFOz4OffFUCHQ0qEssb7GSHWi16mWk5gwXdKuWwtMVoXGyGFsaGFSc25xmTPJg7HUsScp4iAdz4g4MMOW5yDp740Ch3ceoDElAzwY6oJTzDiUJsc3k9pxUHM/8BnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730321312; c=relaxed/simple;
	bh=PzqLt2pkdWXfyDE5lPw/T1rdSsq//rzq7mEHXkRKDY4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UO4KbREHP7NLpa9NtCx7lR/V5VpD8Jw+WuJFOTVPL9JUMEwk7pr3xAwQ6jsHlRcydfQVrMJhQ+lOSAllYKliFSavypDJr89CaQ8baetvqqPWAZUJDzN1ntarjpdjmHHKwAfNyWPskKHOXq8m5hRnm0d5MlvRQrD0Tkwi+DQI4xM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j+IbFrSx; arc=none smtp.client-ip=209.85.221.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f177.google.com with SMTP id 71dfb90a1353d-50d564df009so89868e0c.0
        for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 13:48:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730321305; x=1730926105; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ez0OuFdcogxoFd2zQ7V782VNSdNeqDy5+Mdo9bJHtso=;
        b=j+IbFrSxDF2VW3QSZrwBuAKGKADB6AweFVYyMfxs4pquSRjWD2d2eiEJHqU0IQJ4Mt
         sLNZdXC4UoqNNA8HWGZuNKAGYm05rjeh670n/eigTLtU8UvrqD7f+zUyAfKcBXDJws2T
         CKCBX99mNKoEkdOap/4LfpVH596qnwz/QKwBkxbBBhcZhYDVUxbpg99FiC8BpFByAVRn
         as8dFd/BcHJ2j1Gg43JekHWWDd6j3MSh7wF2YMjaERl8MFpkwROfI1mNgMrEvUc4nype
         yAAPjSgwJtmUmoHKtDRavljoD9+YDyUglMVoV3CjaU2UeuN73OALUjST9VNzeTvuhHCp
         bJ5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730321305; x=1730926105;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ez0OuFdcogxoFd2zQ7V782VNSdNeqDy5+Mdo9bJHtso=;
        b=DrSVDEwTTSu5xzXYVWh3anvh29jPqTAPQ9epIPTzlygcOsjtL9/zXWcso4P9tB3BBt
         gTJErzEVd8g+Moyn4Z7N8Ez+RHxHGNK1jWR4RLhOwA7dJBgX6araTyOFwoKyRDefT2id
         wEuDWbErGiS6qpHWyYL356Kc8Wj//Qp0qObIizIIV5r1J1m1c5KX6xf+f+seTXS3wor0
         0f8wfrgCWf1JTOxN9yUmgcFSs0EbaCol3d19PueKlE6CVOFWGdRsPDNaIODeau6OA1T+
         ESOg06IniVY82q0BfjTulP9qiboAulgopYlw2gBD+pyDC6un2NYKbG86iaQ5IoqP3lEp
         5F2A==
X-Forwarded-Encrypted: i=1; AJvYcCUVRlVP0kumXrGQD7H3/n5bKbxxwLTrQE0UeZbjQxLYUPDI05TIvMZPm6r65TEg7y6qrmFzsTQAc6IKyso=@vger.kernel.org
X-Gm-Message-State: AOJu0YyehLnw0ioMcxc5/yT3FeBiuiLRM11xopUENW26SrLZ+FwQMVpy
	2FjBaeNMgG6ixTgWHK4x0CdFv71WThN18+w98NBEyfHaoqdAKUc1Y817U/kXKE5UgG3bXpG1vuG
	gANMlmv9/vVJNOU3JKjBiLRmkUFw=
X-Google-Smtp-Source: AGHT+IFXs56rd0IPIxpjDZE4xRpJnKxTGnWSVWqIUdF+gchFTiRnqLm0bE49KtKIX/5TJha6Bre/x3zA/mMTylUrFT0=
X-Received: by 2002:a05:6122:1809:b0:50d:83e1:94fb with SMTP id
 71dfb90a1353d-5101511d93fmr15204137e0c.12.1730321305306; Wed, 30 Oct 2024
 13:48:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241027001444.3233-1-21cnbao@gmail.com> <33c5d5ca-7bc4-49dc-b1c7-39f814962ae0@gmail.com>
 <CAGsJ_4wdgptMK0dDTC5g66OE9WDxFDt7ixDQaFCjuHdTyTEGiA@mail.gmail.com>
 <e8c6d46c-b8cf-4369-aa61-9e1b36b83fe3@gmail.com> <CAGsJ_4wx-JH8T5wNjJURKvpQ4hUueMeF9Q6cu9WaFhEc7AEG2A@mail.gmail.com>
 <d88867ba-32e6-4b28-961e-756389d345ca@gmail.com>
In-Reply-To: <d88867ba-32e6-4b28-961e-756389d345ca@gmail.com>
From: Barry Song <21cnbao@gmail.com>
Date: Thu, 31 Oct 2024 09:48:13 +1300
Message-ID: <CAGsJ_4xyEg-hsAcDMM11f3K=FS28-Xp7sy4uo0fzCS5xR2EArg@mail.gmail.com>
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

On Thu, Oct 31, 2024 at 9:41=E2=80=AFAM Usama Arif <usamaarif642@gmail.com>=
 wrote:
>
>
>
> On 30/10/2024 20:27, Barry Song wrote:
> > On Thu, Oct 31, 2024 at 3:51=E2=80=AFAM Usama Arif <usamaarif642@gmail.=
com> wrote:
> >>
> >>
> >>
> >> On 28/10/2024 22:03, Barry Song wrote:
> >>> On Mon, Oct 28, 2024 at 8:07=E2=80=AFPM Usama Arif <usamaarif642@gmai=
l.com> wrote:
> >>>>
> >>>>
> >>>>
> >>>> On 27/10/2024 01:14, Barry Song wrote:
> >>>>> From: Barry Song <v-songbaohua@oppo.com>
> >>>>>
> >>>>> In a memcg where mTHP is always utilized, even at full capacity, it
> >>>>> might not be the best option. Consider a system that uses only smal=
l
> >>>>> folios: after each reclamation, a process has at least SWAP_CLUSTER=
_MAX
> >>>>> of buffer space before it can initiate the next reclamation. Howeve=
r,
> >>>>> large folios can quickly fill this space, rapidly bringing the memc=
g
> >>>>> back to full capacity, even though some portions of the large folio=
s
> >>>>> may not be immediately needed and used by the process.
> >>>>>
> >>>>> Usama and Kanchana identified a regression when building the kernel=
 in
> >>>>> a memcg with memory.max set to a small value while enabling large
> >>>>> folio swap-in support on zswap[1].
> >>>>>
> >>>>> The issue arises from an edge case where the memory cgroup remains
> >>>>> nearly full most of the time. Consequently, bringing in mTHP can
> >>>>> quickly cause a memcg overflow, triggering a swap-out. The subseque=
nt
> >>>>> swap-in then recreates the overflow, resulting in a repetitive cycl=
e.
> >>>>>
> >>>>> We need a mechanism to stop the cup from overflowing continuously.
> >>>>> One potential solution is to slow the filling process when we ident=
ify
> >>>>> that the cup is nearly full.
> >>>>>
> >>>>> Usama reported an improvement when we mitigate mTHP swap-in as the
> >>>>> memcg approaches full capacity[2]:
> >>>>>
> >>>>> int mem_cgroup_swapin_charge_folio(...)
> >>>>> {
> >>>>>       ...
> >>>>>       if (folio_test_large(folio) &&
> >>>>>           mem_cgroup_margin(memcg) < max(MEMCG_CHARGE_BATCH, folio_=
nr_pages(folio)))
> >>>>>               ret =3D -ENOMEM;
> >>>>>       else
> >>>>>               ret =3D charge_memcg(folio, memcg, gfp);
> >>>>>       ...
> >>>>> }
> >>>>>
> >>>>> AMD 16K+32K THP=3Dalways
> >>>>> metric         mm-unstable      mm-unstable + large folio zswapin s=
eries    mm-unstable + large folio zswapin + no swap thrashing fix
> >>>>> real           1m23.038s        1m23.050s                          =
         1m22.704s
> >>>>> user           53m57.210s       53m53.437s                         =
         53m52.577s
> >>>>> sys            7m24.592s        7m48.843s                          =
         7m22.519s
> >>>>> zswpin         612070           999244                             =
         815934
> >>>>> zswpout        2226403          2347979                            =
         2054980
> >>>>> pgfault        20667366         20481728                           =
         20478690
> >>>>> pgmajfault     385887           269117                             =
         309702
> >>>>>
> >>>>> AMD 16K+32K+64K THP=3Dalways
> >>>>> metric         mm-unstable      mm-unstable + large folio zswapin s=
eries   mm-unstable + large folio zswapin + no swap thrashing fix
> >>>>> real           1m22.975s        1m23.266s                          =
        1m22.549s
> >>>>> user           53m51.302s       53m51.069s                         =
        53m46.471s
> >>>>> sys            7m40.168s        7m57.104s                          =
        7m25.012s
> >>>>> zswpin         676492           1258573                            =
        1225703
> >>>>> zswpout        2449839          2714767                            =
        2899178
> >>>>> pgfault        17540746         17296555                           =
        17234663
> >>>>> pgmajfault     429629           307495                             =
        287859
> >>>>>
> >>>>> I wonder if we can extend the mitigation to do_anonymous_page() as
> >>>>> well. Without hardware like AMD and ARM with hardware TLB coalescin=
g
> >>>>> or CONT-PTE, I conducted a quick test on my Intel i9 workstation wi=
th
> >>>>> 10 cores and 2 threads. I enabled one 12 GiB zRAM while running ker=
nel
> >>>>> builds in a memcg with memory.max set to 1 GiB.
> >>>>>
> >>>>> $ echo always > /sys/kernel/mm/transparent_hugepage/hugepages-64kB/=
enabled
> >>>>> $ echo always > /sys/kernel/mm/transparent_hugepage/hugepages-32kB/=
enabled
> >>>>> $ echo always > /sys/kernel/mm/transparent_hugepage/hugepages-16kB/=
enabled
> >>>>> $ echo never > /sys/kernel/mm/transparent_hugepage/hugepages-2048kB=
/enabled
> >>>>>
> >>>>> $ time systemd-run --scope -p MemoryMax=3D1G make ARCH=3Darm64 \
> >>>>> CROSS_COMPILE=3Daarch64-linux-gnu- Image -10 1>/dev/null 2>/dev/nul=
l
> >>>>>
> >>>>>             disable-mTHP-swapin  mm-unstable  with-this-patch
> >>>>> Real:            6m54.595s      7m4.832s       6m45.811s
> >>>>> User:            66m42.795s     66m59.984s     67m21.150s
> >>>>> Sys:             12m7.092s      15m18.153s     12m52.644s
> >>>>> pswpin:          4262327        11723248       5918690
> >>>>> pswpout:         14883774       19574347       14026942
> >>>>> 64k-swpout:      624447         889384         480039
> >>>>> 32k-swpout:      115473         242288         73874
> >>>>> 16k-swpout:      158203         294672         109142
> >>>>> 64k-swpin:       0              495869         159061
> >>>>> 32k-swpin:       0              219977         56158
> >>>>> 16k-swpin:       0              223501         81445
> >>>>>
> >>>>
> >>>
> >>> Hi Usama,
> >>>
> >>>> hmm, both the user and sys time are worse with the patch compared to
> >>>> disable-mTHP-swapin. I wonder if the real time is an anomaly and if =
you
> >>>> repeat the experiment the real time might be worse as well?
> >>>
> >>> Well, I've improved my script to include a loop:
> >>>
> >>> echo always > /sys/kernel/mm/transparent_hugepage/hugepages-64kB/enab=
led
> >>> echo always > /sys/kernel/mm/transparent_hugepage/hugepages-32kB/enab=
led
> >>> echo always > /sys/kernel/mm/transparent_hugepage/hugepages-16kB/enab=
led
> >>> echo never > /sys/kernel/mm/transparent_hugepage/hugepages-2048kB/ena=
bled
> >>>
> >>> for ((i=3D1; i<=3D100; i++))
> >>> do
> >>>   echo "Executing round $i"
> >>>   make ARCH=3Darm64 CROSS_COMPILE=3Daarch64-linux-gnu- clean 1>/dev/n=
ull 2>/dev/null
> >>>   echo 3 > /proc/sys/vm/drop_caches
> >>>   time systemd-run --scope -p MemoryMax=3D1G make ARCH=3Darm64 \
> >>>         CROSS_COMPILE=3Daarch64-linux-gnu- vmlinux -j15 1>/dev/null 2=
>/dev/null
> >>>   cat /proc/vmstat | grep pswp
> >>>   echo -n 64k-swpout: ; cat
> >>> /sys/kernel/mm/transparent_hugepage/hugepages-64kB/stats/swpout
> >>>   echo -n 32k-swpout: ; cat
> >>> /sys/kernel/mm/transparent_hugepage/hugepages-32kB/stats/swpout
> >>>   echo -n 16k-swpout: ; cat
> >>> /sys/kernel/mm/transparent_hugepage/hugepages-16kB/stats/swpout
> >>>   echo -n 64k-swpin: ; cat
> >>> /sys/kernel/mm/transparent_hugepage/hugepages-64kB/stats/swpin
> >>>   echo -n 32k-swpin: ; cat
> >>> /sys/kernel/mm/transparent_hugepage/hugepages-32kB/stats/swpin
> >>>   echo -n 16k-swpin: ; cat
> >>> /sys/kernel/mm/transparent_hugepage/hugepages-16kB/stats/swpin
> >>> done
> >>>
> >>> I've noticed that the user/sys/real time on my i9 machine fluctuates
> >>> constantly, could be things
> >>> like:
> >>> real    6m52.087s
> >>> user    67m12.463s
> >>> sys     13m8.281s
> >>> ...
> >>>
> >>> real    7m42.937s
> >>> user    66m55.250s
> >>> sys     12m56.330s
> >>> ...
> >>>
> >>> real    6m49.374s
> >>> user    66m37.040s
> >>> sys     12m44.542s
> >>> ...
> >>>
> >>> real    6m54.205s
> >>> user    65m49.732s
> >>> sys     11m33.078s
> >>> ...
> >>>
> >>> likely due to unstable temperatures and I/O latency. As a result, my
> >>> data doesn=E2=80=99t seem
> >>> reference-worthy.
> >>>
> >>
> >> So I had suggested retrying the experiment to see how reproducible it =
is,
> >> but had not done that myself!
> >> Thanks for sharing this. I tried many times on the AMD server and I se=
e
> >> varying numbers as well.
> >>
> >> AMD 16K THP always, cgroup =3D 4G, large folio zswapin patches
> >> real    1m28.351s
> >> user    54m14.476s
> >> sys     8m46.596s
> >> zswpin 811693
> >> zswpout 2137310
> >> pgfault 27344671
> >> pgmajfault 290510
> >> ..
> >> real    1m24.557s
> >> user    53m56.815s
> >> sys     8m10.200s
> >> zswpin 571532
> >> zswpout 1645063
> >> pgfault 26989075
> >> pgmajfault 205177
> >> ..
> >> real    1m26.083s
> >> user    54m5.303s
> >> sys     9m55.247s
> >> zswpin 1176292
> >> zswpout 2910825
> >> pgfault 27286835
> >> pgmajfault 419746
> >>
> >>
> >> The sys time can especially vary by large numbers. I think you see the=
 same.
> >>
> >>
> >>> As a phone engineer, we never use phones to run kernel builds. I'm al=
so
> >>> quite certain that phones won't provide stable and reliable data for =
this
> >>> type of workload. Without access to a Linux server to conduct the tes=
t,
> >>> I really need your help.
> >>>
> >>> I used to work on optimizing the ARM server scheduler and memory
> >>> management, and I really miss that machine I had until three years ag=
o :-)
> >>>
> >>>>
> >>>>> I need Usama's assistance to identify a suitable patch, as I lack
> >>>>> access to hardware such as AMD machines and ARM servers with TLB
> >>>>> optimization.
> >>>>>
> >>>>> [1] https://lore.kernel.org/all/b1c17b5e-acd9-4bef-820e-699768f1426=
d@gmail.com/
> >>>>> [2] https://lore.kernel.org/all/7a14c332-3001-4b9a-ada3-f4d6799be55=
5@gmail.com/
> >>>>>
> >>>>> Cc: Kanchana P Sridhar <kanchana.p.sridhar@intel.com>
> >>>>> Cc: Usama Arif <usamaarif642@gmail.com>
> >>>>> Cc: David Hildenbrand <david@redhat.com>
> >>>>> Cc: Baolin Wang <baolin.wang@linux.alibaba.com>
> >>>>> Cc: Chris Li <chrisl@kernel.org>
> >>>>> Cc: Yosry Ahmed <yosryahmed@google.com>
> >>>>> Cc: "Huang, Ying" <ying.huang@intel.com>
> >>>>> Cc: Kairui Song <kasong@tencent.com>
> >>>>> Cc: Ryan Roberts <ryan.roberts@arm.com>
> >>>>> Cc: Johannes Weiner <hannes@cmpxchg.org>
> >>>>> Cc: Michal Hocko <mhocko@kernel.org>
> >>>>> Cc: Roman Gushchin <roman.gushchin@linux.dev>
> >>>>> Cc: Shakeel Butt <shakeel.butt@linux.dev>
> >>>>> Cc: Muchun Song <muchun.song@linux.dev>
> >>>>> Signed-off-by: Barry Song <v-songbaohua@oppo.com>
> >>>>> ---
> >>>>>  include/linux/memcontrol.h |  9 ++++++++
> >>>>>  mm/memcontrol.c            | 45 ++++++++++++++++++++++++++++++++++=
++++
> >>>>>  mm/memory.c                | 17 ++++++++++++++
> >>>>>  3 files changed, 71 insertions(+)
> >>>>>
> >>>>> diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.=
h
> >>>>> index 524006313b0d..8bcc8f4af39f 100644
> >>>>> --- a/include/linux/memcontrol.h
> >>>>> +++ b/include/linux/memcontrol.h
> >>>>> @@ -697,6 +697,9 @@ static inline int mem_cgroup_charge(struct foli=
o *folio, struct mm_struct *mm,
> >>>>>  int mem_cgroup_hugetlb_try_charge(struct mem_cgroup *memcg, gfp_t =
gfp,
> >>>>>               long nr_pages);
> >>>>>
> >>>>> +int mem_cgroup_precharge_large_folio(struct mm_struct *mm,
> >>>>> +                             swp_entry_t *entry);
> >>>>> +
> >>>>>  int mem_cgroup_swapin_charge_folio(struct folio *folio, struct mm_=
struct *mm,
> >>>>>                                 gfp_t gfp, swp_entry_t entry);
> >>>>>
> >>>>> @@ -1201,6 +1204,12 @@ static inline int mem_cgroup_hugetlb_try_cha=
rge(struct mem_cgroup *memcg,
> >>>>>       return 0;
> >>>>>  }
> >>>>>
> >>>>> +static inline int mem_cgroup_precharge_large_folio(struct mm_struc=
t *mm,
> >>>>> +             swp_entry_t *entry)
> >>>>> +{
> >>>>> +     return 0;
> >>>>> +}
> >>>>> +
> >>>>>  static inline int mem_cgroup_swapin_charge_folio(struct folio *fol=
io,
> >>>>>                       struct mm_struct *mm, gfp_t gfp, swp_entry_t =
entry)
> >>>>>  {
> >>>>> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> >>>>> index 17af08367c68..f3d92b93ea6d 100644
> >>>>> --- a/mm/memcontrol.c
> >>>>> +++ b/mm/memcontrol.c
> >>>>> @@ -4530,6 +4530,51 @@ int mem_cgroup_hugetlb_try_charge(struct mem=
_cgroup *memcg, gfp_t gfp,
> >>>>>       return 0;
> >>>>>  }
> >>>>>
> >>>>> +static inline bool mem_cgroup_has_margin(struct mem_cgroup *memcg)
> >>>>> +{
> >>>>> +     for (; !mem_cgroup_is_root(memcg); memcg =3D parent_mem_cgrou=
p(memcg)) {
> >>>>> +             if (mem_cgroup_margin(memcg) < HPAGE_PMD_NR)
> >>>>
> >>>> There might be 3 issues with the approach:
> >>>>
> >>>> Its a very big margin, lets say you have ARM64_64K_PAGES, and you ha=
ve
> >>>> 256K THP set to always. As HPAGE_PMD is 512M for 64K page, you are
> >>>> basically saying you need 512M free memory to swapin just 256K?
> >>>
> >>> Right, sorry for the noisy code. I was just thinking about 4KB pages
> >>> and wondering
> >>> if we could simplify the code.
> >>>
> >>>>
> >>>> Its an uneven margin for different folio sizes.
> >>>> For 16K folio swapin, you are checking if there is margin for 128 fo=
lios,
> >>>> but for 1M folio swapin, you are checking there is margin for just 2=
 folios.
> >>>>
> >>>> Maybe it might be better to make this dependent on some factor of fo=
lio_nr_pages?
> >>>
> >>> Agreed. This is similar to what we discussed regarding your zswap mTH=
P
> >>> swap-in series:
> >>>
> >>>  int mem_cgroup_swapin_charge_folio(...)
> >>>  {
> >>>        ...
> >>>        if (folio_test_large(folio) &&
> >>>            mem_cgroup_margin(memcg) < max(MEMCG_CHARGE_BATCH,
> >>> folio_nr_pages(folio)))
> >>>                ret =3D -ENOMEM;
> >>>        else
> >>>                ret =3D charge_memcg(folio, memcg, gfp);
> >>>        ...
> >>>  }
> >>>
> >>> As someone focused on phones, my challenge is the absence of stable p=
latforms to
> >>> benchmark this type of workload. If possible, Usama, I would greatly
> >>> appreciate it if
> >>> you could take the lead on the patch.
> >>>
> >>>>
> >>>> As Johannes pointed out, the charging code already does the margin c=
heck.
> >>>> So for 4K, the check just checks if there is 4K available, but for 1=
6K it checks
> >>>> if a lot more than 16K is available. Maybe there should be a similar=
 policy for
> >>>> all? I guess this is similar to my 2nd point, but just considers 4K =
folios as
> >>>> well.
> >>>
> >>> I don't think the charging code performs a margin check. It simply
> >>> tries to charge
> >>> the specified nr_pages (whether 1 or more). If nr_pages are available=
,
> >>> the charge
> >>> proceeds; otherwise, if GFP allows blocking, it triggers memory recla=
mation to
> >>> reclaim max(SWAP_CLUSTER_MAX, nr_pages) base pages.
> >>>
> >>
> >> So if you have defrag not set to always, it will not trigger reclamati=
on.
> >> I think that is a bigger usecase, i.e. defrag=3Dmadvise,defer,etc is p=
robably
> >> used much more then always.
> >>
> >> In the current code in that case try_charge_memcg will return -ENOMEM =
all
> >> the way to mem_cgroup_swapin_charge_folio and alloc_swap_folio will th=
en
> >> try the next order. So eventhough it might not be calling the mem_cgro=
up_margin
> >> function, it is kind of is doing the same?
> >>
> >>> If, after reclamation, we have exactly SWAP_CLUSTER_MAX pages availab=
le, a
> >>> large folio with nr_pages =3D=3D SWAP_CLUSTER_MAX will successfully c=
harge,
> >>> immediately filling the memcg.
> >>>
> >>> Shortly after, smaller folios=E2=80=94typically with blockable GFP=E2=
=80=94will quickly trigger
> >>> additional reclamation. While nr_pages - 1 subpages of the large foli=
o may not
> >>> be immediately needed, they still occupy enough space to fill the mem=
cg to
> >>> capacity.
> >>>
> >>> My second point about the mitigation is as follows: For a system (or
> >>> memcg) under severe memory pressure, especially one without hardware =
TLB
> >>> optimization, is enabling mTHP always the right choice? Since mTHP op=
erates at
> >>> a larger granularity, some internal fragmentation is unavoidable, reg=
ardless
> >>> of optimization. Could the mitigation code help in automatically tuni=
ng
> >>> this fragmentation?
> >>>
> >>
> >> I agree with the point that enabling mTHP always is not the right thin=
g to do
> >> on all platforms. I also think it might be the case that enabling mTHP
> >> might be a good thing for some workloads, but enabling mTHP swapin alo=
ng with
> >> it might not.
> >>
> >> As you said when you have apps switching between foreground and backgr=
ound
> >> in android, it probably makes sense to have large folio swapping, as y=
ou
> >> want to bringin all the pages from background app as quickly as possib=
le.
> >> And also all the TLB optimizations and smaller lru overhead you get af=
ter
> >> you have brought in all the pages.
> >> Linux kernel build test doesnt really get to benefit from the TLB opti=
mization
> >> and smaller lru overhead, as probably the pages are very short lived. =
So I
> >> think it doesnt show the benefit of large folio swapin properly and
> >> large folio swapin should probably be disabled for this kind of worklo=
ad,
> >> eventhough mTHP should be enabled.
> >
> > I'm not entirely sure if this applies to platforms without TLB
> > optimization, especially
> > in the absence of swap. In a memory-limited cgroup without swap, would
> > mTHP still
> > cause significant thrashing of file-backed folios? When a large swap
> > file is present,
> > the inability to swap in mTHP seems to act as a workaround for fragment=
ation,
> > allowing fragmented pages of the original mTHP from do_anonymous_page()=
 to
> > remain in swap.
> >
> >>
> >> I am not sure that the approach we are trying in this patch is the rig=
ht way:
> >> - This patch makes it a memcg issue, but you could have memcg disabled=
 and
> >> then the mitigation being tried here wont apply.
> >> - Instead of this being a large folio swapin issue, is it more of a re=
adahead
> >> issue? If we zswap (without the large folio swapin series) and change =
the window
> >> to 1 in swap_vma_readahead, we might see an improvement in linux kerne=
l build time
> >> when cgroup memory is limited as readahead would probably cause swap t=
hrashing as
> >> well.
> >> - Instead of looking at cgroup margin, maybe we should try and look at
> >> the rate of change of workingset_restore_anon? This might be a lot mor=
e complicated
> >> to do, but probably is the right metric to determine swap thrashing. I=
t also means
> >> that this could be used in both the synchronous swapcache skipping pat=
h and
> >> swapin_readahead path.
> >> (Thanks Johannes for suggesting this)
> >>
> >> With the large folio swapin, I do see the large improvement when consi=
dering only
> >> swapin performance and latency in the same way as you saw in zram.
> >> Maybe the right short term approach is to have
> >> /sys/kernel/mm/transparent_hugepage/swapin
> >> and have that disabled by default to avoid regression.
> >
> > A crucial component is still missing=E2=80=94managing the compression a=
nd decompression
> > of multiple pages as a larger block. This could significantly reduce
> > system time and
> > potentially resolve the kernel build issue within a small memory
> > cgroup, even with
> > swap thrashing.
> >
> > I=E2=80=99ll send an update ASAP so you can rebase for zswap.
>
> Did you mean https://lore.kernel.org/all/20241021232852.4061-1-21cnbao@gm=
ail.com/?
> Thats wont benefit zswap, right?

That's right. I assume we can also make it work with zswap?

> I actually had a few questions about it. Mainly that the benefit comes if=
 the
> pagefault happens on page 0 of the large folio. But if the page fault hap=
pens
> on any other page, lets say page 1 of a 64K folio. then it will decompres=
s the
> entire 64K chunk and just copy page 1? (memcpy in zram_bvec_read_multi_pa=
ges_partial).
> Could that cause a regression as you have to decompress a large chunk for=
 just
> getting 1 4K page?
> If we assume uniform distribution of page faults, maybe it could make thi=
ngs worse?
>
> I probably should ask all of this in that thread.

With mTHP swap-in, a page fault on any page behaves the same as a fault on
page 0. Without mTHP swap-in, there=E2=80=99s also no difference between
faults on page 0
and other pages.

A fault on any page means that the entire block is decompressed. The
only difference
is that we don=E2=80=99t partially copy one page when mTHP swap-in is prese=
nt.

>
> >
> >> If the workload owner sees a benefit, they can enable it.
> >> I can add this when sending the next version of large folio zswapin if=
 that makes
> >> sense?
> >> Longer term I can try and have a look at if we can do something with
> >> workingset_restore_anon to improve things.
> >>
> >> Thanks,
> >> Usama

Thanks
Barry

