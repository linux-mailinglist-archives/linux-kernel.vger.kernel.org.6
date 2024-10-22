Return-Path: <linux-kernel+bounces-377055-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A0969AB953
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 00:07:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BAECE1C22B7B
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 22:07:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C0871CDA02;
	Tue, 22 Oct 2024 22:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JgCnwRNH"
Received: from mail-oo1-f52.google.com (mail-oo1-f52.google.com [209.85.161.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 798C31CCECB;
	Tue, 22 Oct 2024 22:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729634835; cv=none; b=klKmPuazpXfearMEk/hWfTecRwOzAihIrxT3jzYFkcDJQ/9vAm3j/vCXrcqnuo/i7zfKtyk2USWILPIOFA+N93kSzOCLSClLigKdPYkEA4nUMj4oEvOk1x6aSXkA5SRaV1aZaapBfbPGblVqCAsf3Lx7C8PEkMRAIve62LRLJks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729634835; c=relaxed/simple;
	bh=JJRlAXn/S0FDJg5vjC1T+Ntbi4vIIGRNPJO5lvmXSyo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=D6WBhN52nraANkmYlJWekHdYTpKOX0/dnFcBSbgthej2GNe0FnCM0adY6SOf58QHIXypjyPCDnhDFyhm/DeazBIu2iYdplWyHrS7hOACOUZRzZrRMRd/hIwdO5Sny0jM5o25pFCNskhejJKBsDGX9D6OkTohUjxM96fRFmhabZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JgCnwRNH; arc=none smtp.client-ip=209.85.161.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-5ebc4e89240so1348908eaf.1;
        Tue, 22 Oct 2024 15:07:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729634832; x=1730239632; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GpQHdkSrrifg6mMBJ5OBvthREeLICDKeEzHFZur+O6o=;
        b=JgCnwRNHe0eZDF5k8TXUyFqm8AFvdDDmEzhTKGUhdtIDOYy4xj7FLascDzUXjoDsJJ
         thprvzw9GVQFUHhs/4oNHdgRycv5kU546fsDNdGHeb4bDXX5YNQoDzNE+v3gYdtEuZDw
         Or1gWZ85w17FugEHhtISuTVl3Eh3o1Op/46jZ1qDVuSGZQt2co+wXtgK1jQIZqJ/W6bG
         rPEBFjc3vZHiCQDeBiwMCkm37/eWGGpnl/ZrNSkm/ba00UGZJ825h/esPqlZhr4oo9bt
         LP0evMm0XtVu9hdUpRVMHquuCGNMTs/A4bDfsxxaJQrWQMzfcpgFzJclg+LJ59OjA2H4
         5Y8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729634832; x=1730239632;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GpQHdkSrrifg6mMBJ5OBvthREeLICDKeEzHFZur+O6o=;
        b=GiAlq4+WHn232K0aKBsewJd0vcbOPxdVCErwfpvlPvnmT8+uinj5YHrVfccprWg8D5
         UDwLcOTSg26XWOVd6GaoQ/Vk2iuj6xFZ6AuTx+XhL4Mii+ZeoBFxNhC3HgIUN/QsN4Ev
         vsUupIcCvrko9LILsXMEmpokJxrSp5TFj8rhMsenori2ErmFAdeRbvW+19haZsFVfxRs
         CQZFPsHT6+d58mATG1UgWUMV+4JPlBT0dAuLSohK2QMvi4IGFmYl00q6zpSXQ9050B/4
         ENBGe8zJtK3RSsm7kNxeh0kyh8+HT9zd9zOdYVpy3Z/p80vaHuMPqTVsEdsBypVp1e4k
         AdyA==
X-Forwarded-Encrypted: i=1; AJvYcCWhGV3AxPoDVXNO5f58Qk2ZLVn0/gD4wj6Tcoi55mJyHgz9Q8ZOrFJdCyKuG/zmgqXxAwdeXqMTnb9RDRi7@vger.kernel.org, AJvYcCXnuFihPU4uuFPM9ZgJFdUnaHpYJtONY+2YlcCRwtIC8ZQac6ERI8SP2KTjddhwDlH+/o61bEtBiBA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwxpPayUJQysmEPbHCez1ORdqa6SosNb17IOnHqSpyGO/jgvnI6
	LwWJ+6m1STlJ2vxpptcdTlsu15YmLvrlgAzEo/HKiBV6XvK7BPyRkDQsajQ5gZneSQhHAa6EWkE
	0xE/gq3hofgTwc878Usi7whXrCWg=
X-Google-Smtp-Source: AGHT+IEQ8MN3H6ccxqndyX8CxCGkssCuch3G0zDY/RaqmDE+PosRp0Lx7lv+bpwR7YxS3kyZb8mrItsyzardtDXRWP0=
X-Received: by 2002:a05:6358:5328:b0:1c3:9d1e:842 with SMTP id
 e5c5f4694b2df-1c3d819b98cmr43531055d.20.1729634832251; Tue, 22 Oct 2024
 15:07:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241018105026.2521366-1-usamaarif642@gmail.com>
 <CAGsJ_4xweuSwMUBuLSr2eUy69mtQumeDpMZ1g2jFPGq6nFn9fg@mail.gmail.com>
 <5313c721-9cf1-4ecd-ac23-1eeddabd691f@gmail.com> <b1c17b5e-acd9-4bef-820e-699768f1426d@gmail.com>
 <CAGsJ_4wykOyJupLhcqkSPe27rdANd=bOJhqxL74vcdZ+T9f==g@mail.gmail.com> <eab11780-e671-4d09-86a6-af4cf3589392@gmail.com>
In-Reply-To: <eab11780-e671-4d09-86a6-af4cf3589392@gmail.com>
From: Barry Song <21cnbao@gmail.com>
Date: Wed, 23 Oct 2024 11:07:00 +1300
Message-ID: <CAGsJ_4wWf7QnibY_uU8B=efuEACrvFaJJ=bJTD+9KrxFtfoMmQ@mail.gmail.com>
Subject: Re: [RFC 0/4] mm: zswap: add support for zswapin of large folios
To: Usama Arif <usamaarif642@gmail.com>
Cc: senozhatsky@chromium.org, minchan@kernel.org, hanchuanhua@oppo.com, 
	v-songbaohua@oppo.com, akpm@linux-foundation.org, linux-mm@kvack.org, 
	hannes@cmpxchg.org, david@redhat.com, willy@infradead.org, 
	kanchana.p.sridhar@intel.com, yosryahmed@google.com, nphamcs@gmail.com, 
	chengming.zhou@linux.dev, ryan.roberts@arm.com, ying.huang@intel.com, 
	riel@surriel.com, shakeel.butt@linux.dev, kernel-team@meta.com, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 23, 2024 at 10:17=E2=80=AFAM Usama Arif <usamaarif642@gmail.com=
> wrote:
>
>
>
> On 22/10/2024 21:46, Barry Song wrote:
> > On Wed, Oct 23, 2024 at 4:26=E2=80=AFAM Usama Arif <usamaarif642@gmail.=
com> wrote:
> >>
> >>
> >>
> >> On 21/10/2024 11:40, Usama Arif wrote:
> >>>
> >>>
> >>> On 21/10/2024 06:09, Barry Song wrote:
> >>>> On Fri, Oct 18, 2024 at 11:50=E2=80=AFPM Usama Arif <usamaarif642@gm=
ail.com> wrote:
> >>>>>
> >>>>> After large folio zswapout support added in [1], this patch adds
> >>>>> support for zswapin of large folios to bring it on par with zram.
> >>>>> This series makes sure that the benefits of large folios (fewer
> >>>>> page faults, batched PTE and rmap manipulation, reduced lru list,
> >>>>> TLB coalescing (for arm64 and amd)) are not lost at swap out when
> >>>>> using zswap.
> >>>>>
> >>>>> It builds on top of [2] which added large folio swapin support for
> >>>>> zram and provides the same level of large folio swapin support as
> >>>>> zram, i.e. only supporting swap count =3D=3D 1.
> >>>>>
> >>>>> Patch 1 skips swapcache for swapping in zswap pages, this should im=
prove
> >>>>> no readahead swapin performance [3], and also allows us to build on=
 large
> >>>>> folio swapin support added in [2], hence is a prerequisite for patc=
h 3.
> >>>>>
> >>>>> Patch 3 adds support for large folio zswapin. This patch does not a=
dd
> >>>>> support for hybrid backends (i.e. folios partly present swap and zs=
wap).
> >>>>>
> >>>>> The main performance benefit comes from maintaining large folios *a=
fter*
> >>>>> swapin, large folio performance improvements have been mentioned in=
 previous
> >>>>> series posted on it [2],[4], so have not added those. Below is a si=
mple
> >>>>> microbenchmark to measure the time needed *for* zswpin of 1G memory=
 (along
> >>>>> with memory integrity check).
> >>>>>
> >>>>>                                 |  no mTHP (ms) | 1M mTHP enabled (=
ms)
> >>>>> Base kernel                     |   1165        |    1163
> >>>>> Kernel with mTHP zswpin series  |   1203        |     738
> >>>>
> >>>> Hi Usama,
> >>>> Do you know where this minor regression for non-mTHP comes from?
> >>>> As you even have skipped swapcache for small folios in zswap in patc=
h1,
> >>>> that part should have some gain? is it because of zswap_present_test=
()?
> >>>>
> >>>
> >>> Hi Barry,
> >>>
> >>> The microbenchmark does a sequential read of 1G of memory, so it prob=
ably
> >>> isnt very representative of real world usecases. This also means that
> >>> swap_vma_readahead is able to readahead accurately all pages in its w=
indow.
> >>> With this patch series, if doing 4K swapin, you get 1G/4K calls of fa=
st
> >>> do_swap_page. Without this patch, you get 1G/(4K*readahead window) of=
 slow
> >>> do_swap_page calls. I had added some prints and I was seeing 8 pages =
being
> >>> readahead in 1 do_swap_page. The larger number of calls causes the sl=
ight
> >>> regression (eventhough they are quite fast). I think in a realistic s=
cenario,
> >>> where readahead window wont be as large, there wont be a regression.
> >>> The cost of zswap_present_test in the whole call stack of swapping pa=
ge is
> >>> very low and I think can be ignored.
> >>>
> >>> I think the more interesting thing is what Kanchana pointed out in
> >>> https://lore.kernel.org/all/f2f2053f-ec5f-46a4-800d-50a3d2e61bff@gmai=
l.com/
> >>> I am curious, did you see this when testing large folio swapin and co=
mpression
> >>> at 4K granuality? Its looks like swap thrashing so I think it would b=
e common
> >>> between zswap and zram. I dont have larger granuality zswap compressi=
on done,
> >>> which is why I think there is a regression in time taken. (It could b=
e because
> >>> its tested on intel as well).
> >>>
> >>> Thanks,
> >>> Usama
> >>>
> >>
> >> Hi,
> >>
> >> So I have been doing some benchmarking after Kanchana pointed out a pe=
rformance
> >> regression in [1] of swapping in large folio. I would love to get thou=
ghts from
> >> zram folks on this, as thats where large folio swapin was first added =
[2].
> >> As far as I can see, the current support in zram is doing large folio =
swapin
> >> at 4K granuality. The large granuality compression in [3] which was po=
sted
> >> in March is not merged, so I am currently comparing upstream zram with=
 this series.
> >>
> >> With the microbenchmark below of timing 1G swapin, there was a very la=
rge improvement
> >> in performance by using this series. I think similar numbers would be =
seen in zram.
> >
> > Imagine running several apps on a phone and switching
> > between them: A =E2=86=92 B =E2=86=92 C =E2=86=92 D =E2=86=92 E =E2=80=
=A6 =E2=86=92 A =E2=86=92 B =E2=80=A6 The app
> > currently on the screen retains its memory, while the ones
> > sent to the background are swapped out. When we bring
> > those apps back to the foreground, their memory is restored.
> > This behavior is quite similar to what you're seeing with
> > your microbenchmark.
> >
>
> Hi Barry,
>
> Thanks for explaining this! Do you know if there is some open source benc=
hmark
> we could use to show an improvement in app switching with large folios?
>

I=E2=80=99m fairly certain the Android team has this benchmark, but it=E2=
=80=99s not
open source.

A straightforward way to simulate this is to use a script that
cyclically launches multiple applications, such as Chrome, Firefox,
Office, PDF, and others.

for example:

launch chrome;
launch firefox;
launch youtube;
....
launch chrome;
launch firefox;
....

On Android, we have "Android activity manager 'am' command" to do that.
https://gist.github.com/tsohr/5711945

Not quite sure if other windows managers have similar tools.

> Also I guess swap thrashing can happen when apps are brought back to fore=
ground?
>

Typically, the foreground app doesn't experience much swapping,
as it is the most recently or frequently used. However, this may
not hold for very low-end phones, where memory is significantly
less than the app's working set. For instance, we can't expect a
good user experience when playing a large game that requires 8GB
of memory on a 4GB phone! :-)
And for low-end phones, we never even enable mTHP.

> >>
> >> But when doing kernel build test, Kanchana saw a regression in [1]. I =
believe
> >> its because of swap thrashing (causing large zswap activity), due to l=
arger page swapin.
> >> The part of the code that decides large folio swapin is the same betwe=
en zswap and zram,
> >> so I believe this would be observed in zram as well.
> >
> > Is this an extreme case where the workload's working set far
> > exceeds the available memory by memcg limitation? I doubt mTHP
> > would provide any real benefit from the start if the workload is bound =
to
> > experience swap thrashing. What if we disable mTHP entirely?
> >
>
> I would agree, this is an extreme case. I wanted (z)swap activity to happ=
en so limited
> memory.max to 4G.
>
> mTHP is beneficial in kernel test benchmarking going from no mTHP to 16K:
>
> ARM make defconfig; time make -j$(nproc) Image, cgroup memory.max=3D4G
> metric         no mTHP         16K mTHP=3Dalways
> real           1m0.613s         0m52.008s
> user           25m23.028s       25m19.488s
> sys            25m45.466s       18m11.640s
> zswpin         1911194          3108438
> zswpout        6880815          9374628
> pgfault        120430166        48976658
> pgmajfault     1580674          2327086
>
>

Interesting! We never use a phone to build the Linux kernel, but
let me see if I can find some other machines to reproduce your data.

>
>
> >>
> >> My initial thought was this might be because its intel, where you dont=
 have the advantage
> >> of TLB coalescing, so tested on AMD and ARM, but the regression is the=
re on AMD
> >> and ARM as well, though a bit less (have added the numbers below).
> >>
> >> The numbers show that the zswap activity increases and page faults dec=
rease.
> >> Overall this does result in sys time increasing and real time slightly=
 increases,
> >> likely because the cost of increased zswap activity is more than the b=
enefit of
> >> lower page faults.
> >> I can see in [3] that pagefaults reduced in zram as well.
> >>
> >> Large folio swapin shows good numbers in microbenchmarks that just tar=
get reduce page
> >> faults and sequential swapin only, but not in kernel build test. Is a =
similar regression
> >> observed with zram when enabling large folio swapin on kernel build te=
st? Maybe large
> >> folio swapin makes more sense on workloads where mappings are kept for=
 a longer time?
> >>
> >
> > I suspect this is because mTHP doesn't always benefit workloads
> > when available memory is quite limited compared to the working set.
> > In that case, mTHP swap-in might introduce more features that
> > exacerbate the problem. We used to have an extra control "swapin_enable=
d"
> > for swap-in, but it never gained much traction:
> > https://lore.kernel.org/linux-mm/20240726094618.401593-5-21cnbao@gmail.=
com/
> > We can reconsider whether to include the knob, but if it's better
> > to disable mTHP entirely for these cases, we can still adhere to
> > the policy of "enabled".
> >
> Yes I think this makes sense to have. The only thing is, its too many kno=
bs!
> I personally think its already difficult to decide upto which mTHP size w=
e
> should enable (and I think this changes per workload). But if we add swap=
in_enabled
> on top of that it can make things more difficult.
>
> > Using large block compression and decompression in zRAM will
> > significantly reduce CPU usage, likely making the issue unnoticeable.
> > However, the default minimum size for large block support is currently
> > set to 64KB(ZSMALLOC_MULTI_PAGES_ORDER =3D 4).
> >
>
> I saw that the patch was sent in March, and there werent any updates afte=
r?
> Maybe I can try and cherry-pick that and see if we can develop large
> granularity compression for zswap.

will provide an updated version next week.

>
> >>
> >> Kernel build numbers in cgroup with memory.max=3D4G to trigger zswap
> >> Command for AMD: make defconfig; time make -j$(nproc) bzImage
> >> Command for ARM: make defconfig; time make -j$(nproc) Image
> >>
> >>
> >> AMD 16K+32K THP=3Dalways
> >> metric         mm-unstable      mm-unstable + large folio zswapin seri=
es
> >> real           1m23.038s        1m23.050s
> >> user           53m57.210s       53m53.437s
> >> sys            7m24.592s        7m48.843s
> >> zswpin         612070           999244
> >> zswpout        2226403          2347979
> >> pgfault        20667366         20481728
> >> pgmajfault     385887           269117
> >>
> >> AMD 16K+32K+64K THP=3Dalways
> >> metric         mm-unstable      mm-unstable + large folio zswapin seri=
es
> >> real           1m22.975s        1m23.266s
> >> user           53m51.302s       53m51.069s
> >> sys            7m40.168s        7m57.104s
> >> zswpin         676492           1258573
> >> zswpout        2449839          2714767
> >> pgfault        17540746         17296555
> >> pgmajfault     429629           307495
> >> --------------------------
> >> ARM 16K+32K THP=3Dalways
> >> metric         mm-unstable      mm-unstable + large folio zswapin seri=
es
> >> real           0m51.168s        0m52.086s
> >> user           25m14.715s       25m15.765s
> >> sys            17m18.856s       18m8.031s
> >> zswpin         3904129          7339245
> >> zswpout        11171295         13473461
> >> pgfault        37313345         36011338
> >> pgmajfault     2726253          1932642
> >>
> >>
> >> ARM 16K+32K+64K THP=3Dalways
> >> metric         mm-unstable      mm-unstable + large folio zswapin seri=
es
> >> real           0m52.017s        0m53.828s
> >> user           25m2.742s        25m0.046s
> >> sys            18m24.525s       20m26.207s
> >> zswpin         4853571          8908664
> >> zswpout        12297199         15768764
> >> pgfault        32158152         30425519
> >> pgmajfault     3320717          2237015
> >>
> >>
> >> Thanks!
> >> Usama
> >>
> >>
> >> [1] https://lore.kernel.org/all/f2f2053f-ec5f-46a4-800d-50a3d2e61bff@g=
mail.com/
> >> [2] https://lore.kernel.org/all/20240821074541.516249-3-hanchuanhua@op=
po.com/
> >> [3] https://lore.kernel.org/all/20240327214816.31191-1-21cnbao@gmail.c=
om/
> >>
> >>>
> >>>>>
> >>>>> The time measured was pretty consistent between runs (~1-2% variati=
on).
> >>>>> There is 36% improvement in zswapin time with 1M folios. The percen=
tage
> >>>>> improvement is likely to be more if the memcmp is removed.
> >>>>>
> >>>>> diff --git a/tools/testing/selftests/cgroup/test_zswap.c b/tools/te=
sting/selftests/cgroup/test_zswap.c
> >>>>> index 40de679248b8..77068c577c86 100644
> >>>>> --- a/tools/testing/selftests/cgroup/test_zswap.c
> >>>>> +++ b/tools/testing/selftests/cgroup/test_zswap.c
> >>>>> @@ -9,6 +9,8 @@
> >>>>>  #include <string.h>
> >>>>>  #include <sys/wait.h>
> >>>>>  #include <sys/mman.h>
> >>>>> +#include <sys/time.h>
> >>>>> +#include <malloc.h>
> >>>>>
> >>>>>  #include "../kselftest.h"
> >>>>>  #include "cgroup_util.h"
> >>>>> @@ -407,6 +409,74 @@ static int test_zswap_writeback_disabled(const=
 char *root)
> >>>>>         return test_zswap_writeback(root, false);
> >>>>>  }
> >>>>>
> >>>>> +static int zswapin_perf(const char *cgroup, void *arg)
> >>>>> +{
> >>>>> +       long pagesize =3D sysconf(_SC_PAGESIZE);
> >>>>> +       size_t memsize =3D MB(1*1024);
> >>>>> +       char buf[pagesize];
> >>>>> +       int ret =3D -1;
> >>>>> +       char *mem;
> >>>>> +       struct timeval start, end;
> >>>>> +
> >>>>> +       mem =3D (char *)memalign(2*1024*1024, memsize);
> >>>>> +       if (!mem)
> >>>>> +               return ret;
> >>>>> +
> >>>>> +       /*
> >>>>> +        * Fill half of each page with increasing data, and keep ot=
her
> >>>>> +        * half empty, this will result in data that is still compr=
essible
> >>>>> +        * and ends up in zswap, with material zswap usage.
> >>>>> +        */
> >>>>> +       for (int i =3D 0; i < pagesize; i++)
> >>>>> +               buf[i] =3D i < pagesize/2 ? (char) i : 0;
> >>>>> +
> >>>>> +       for (int i =3D 0; i < memsize; i +=3D pagesize)
> >>>>> +               memcpy(&mem[i], buf, pagesize);
> >>>>> +
> >>>>> +       /* Try and reclaim allocated memory */
> >>>>> +       if (cg_write_numeric(cgroup, "memory.reclaim", memsize)) {
> >>>>> +               ksft_print_msg("Failed to reclaim all of the reques=
ted memory\n");
> >>>>> +               goto out;
> >>>>> +       }
> >>>>> +
> >>>>> +       gettimeofday(&start, NULL);
> >>>>> +       /* zswpin */
> >>>>> +       for (int i =3D 0; i < memsize; i +=3D pagesize) {
> >>>>> +               if (memcmp(&mem[i], buf, pagesize)) {
> >>>>> +                       ksft_print_msg("invalid memory\n");
> >>>>> +                       goto out;
> >>>>> +               }
> >>>>> +       }
> >>>>> +       gettimeofday(&end, NULL);
> >>>>> +       printf ("zswapin took %fms to run.\n", (end.tv_sec - start.=
tv_sec)*1000 + (double)(end.tv_usec - start.tv_usec) / 1000);
> >>>>> +       ret =3D 0;
> >>>>> +out:
> >>>>> +       free(mem);
> >>>>> +       return ret;
> >>>>> +}
> >>>>> +
> >>>>> +static int test_zswapin_perf(const char *root)
> >>>>> +{
> >>>>> +       int ret =3D KSFT_FAIL;
> >>>>> +       char *test_group;
> >>>>> +
> >>>>> +       test_group =3D cg_name(root, "zswapin_perf_test");
> >>>>> +       if (!test_group)
> >>>>> +               goto out;
> >>>>> +       if (cg_create(test_group))
> >>>>> +               goto out;
> >>>>> +
> >>>>> +       if (cg_run(test_group, zswapin_perf, NULL))
> >>>>> +               goto out;
> >>>>> +
> >>>>> +       ret =3D KSFT_PASS;
> >>>>> +out:
> >>>>> +       cg_destroy(test_group);
> >>>>> +       free(test_group);
> >>>>> +       return ret;
> >>>>> +}
> >>>>> +
> >>>>>  /*
> >>>>>   * When trying to store a memcg page in zswap, if the memcg hits i=
ts memory
> >>>>>   * limit in zswap, writeback should affect only the zswapped pages=
 of that
> >>>>> @@ -584,6 +654,7 @@ struct zswap_test {
> >>>>>         T(test_zswapin),
> >>>>>         T(test_zswap_writeback_enabled),
> >>>>>         T(test_zswap_writeback_disabled),
> >>>>> +       T(test_zswapin_perf),
> >>>>>         T(test_no_kmem_bypass),
> >>>>>         T(test_no_invasive_cgroup_shrink),
> >>>>>  };
> >>>>>
> >>>>> [1] https://lore.kernel.org/all/20241001053222.6944-1-kanchana.p.sr=
idhar@intel.com/
> >>>>> [2] https://lore.kernel.org/all/20240821074541.516249-1-hanchuanhua=
@oppo.com/
> >>>>> [3] https://lore.kernel.org/all/1505886205-9671-5-git-send-email-mi=
nchan@kernel.org/T/#u
> >>>>> [4] https://lwn.net/Articles/955575/
> >>>>>
> >>>>> Usama Arif (4):
> >>>>>   mm/zswap: skip swapcache for swapping in zswap pages
> >>>>>   mm/zswap: modify zswap_decompress to accept page instead of folio
> >>>>>   mm/zswap: add support for large folio zswapin
> >>>>>   mm/zswap: count successful large folio zswap loads
> >>>>>
> >>>>>  Documentation/admin-guide/mm/transhuge.rst |   3 +
> >>>>>  include/linux/huge_mm.h                    |   1 +
> >>>>>  include/linux/zswap.h                      |   6 ++
> >>>>>  mm/huge_memory.c                           |   3 +
> >>>>>  mm/memory.c                                |  16 +--
> >>>>>  mm/page_io.c                               |   2 +-
> >>>>>  mm/zswap.c                                 | 120 ++++++++++++++---=
----
> >>>>>  7 files changed, 99 insertions(+), 52 deletions(-)
> >>>>>
> >>>>> --
> >>>>> 2.43.5
> >>>>>
> >>>>
> >

Thanks
Barry

