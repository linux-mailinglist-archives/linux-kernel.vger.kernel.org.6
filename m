Return-Path: <linux-kernel+bounces-377876-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ED7879AC7E8
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 12:28:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 717B51F283F6
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 10:28:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD28C1A2C06;
	Wed, 23 Oct 2024 10:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZY7xp3yE"
Received: from mail-vs1-f41.google.com (mail-vs1-f41.google.com [209.85.217.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73DF01A073A;
	Wed, 23 Oct 2024 10:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729679222; cv=none; b=cEWNx5g6x3BF67BuZ/5NcvmJ5ZdRRDhjwHVQzkv4rUXC00594ZJI6MxLBaDjCo704IbYzeNEqWPQHIPLD+vLDZboCQz4WGT/gBLIHaHomfYtvYwV40sqwnhgBKh6TbiKlDNSGu8iEej0LZCQVuWGsaHZwxNZRgrLwZB7mIWIGtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729679222; c=relaxed/simple;
	bh=tfVqYsUq77Z5sJypNx7Q9FO0oPUpQwT/dH7F3t3/nNo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VmvZzsFzKMYwSppskJvLE0IzCxDYUnubmS4rUW+TclHYf8dh3o2dPJBlrqVOKfAi6T3bqcaf9HWuX4nBKTDfJEQVNfVp5bx2DdKuRcMWJ/fToGWb6wju/i1rfpSuMM3VYyqQileLHxe2PTys2HNeyfXUASkr35C6QMHTH9QzaLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZY7xp3yE; arc=none smtp.client-ip=209.85.217.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f41.google.com with SMTP id ada2fe7eead31-4a482cb53bdso2284819137.3;
        Wed, 23 Oct 2024 03:27:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729679219; x=1730284019; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cD3WF3EmzIj/UjMOYgnbsaubBoun6n700zqtkOjtj/0=;
        b=ZY7xp3yEXg4VRs3KUcdYuxKKwDvxKT/H4tzD1nx/rD1i5VNLIczEAGamkeYaurJsKO
         iYajozT57j5DEIuS1gAdc8eC5EOP1vQjyBdkTPtKv0UT+qQe9RkBtBIHAYmQI0SHPiVP
         0bwjuDgMkVTdAmCuEAJL6HWiHb8GENs8ZKkEBqs25E4sd5we94GlmbTs0mgGiGSdmqah
         D8rwHYGuVnx1O+wfD88uv8pS4T/JKcrs6YnPhVghtHiSHi8ZLUWSK3MvU4EcvrTmMXqJ
         d5sg5hbMrRXW02a3/DFoTrZLMMfSSYyiXMyZYlJ5HBLnQOVsUzqa59GcrgAvsXrb+hnH
         ygnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729679219; x=1730284019;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cD3WF3EmzIj/UjMOYgnbsaubBoun6n700zqtkOjtj/0=;
        b=Eud4KzVyF++ywKK8migc6u1355UOEQPbp0p7/ZqJJgVj3D/fFh6UkLZlfkgqcRSeFg
         Hi7QecdvR//YhUL0gpGrSgVP79fpAR2uaNzzykGhIVx7yTsxQ0yD/0QdgH8DNGzfOASf
         oDXBcUW1ZWMMxUWxO3mTCLtwMOr/VenweLYgEHUujlzJgOf75OyStUU776CXHjv0k7IO
         ZoP2pjSFGcHV1hwJAOFDVpwIP/vO9etaeNlgFIv4PLQ2UUq8jnpHrGFvrcu6UUcT3J6P
         fcBasibiVUro95/IdPeUvvSDMGEtwxAy1+RlrcaAzx2PrPpML9M812spBM/BlKwczmk2
         WdFQ==
X-Forwarded-Encrypted: i=1; AJvYcCUalnEgBK0wrVfcv1xo1rxu5+dOqXBPxlw0k2lisaRxjTltLWOaTaG9xjszeDPYl6pjgXy+1pHEQtyAfYB0@vger.kernel.org, AJvYcCXJPYvVOLUCJTR2JFWz5b8trBqZ8rzQiU40Ryrof8aeTWOiMe9F04cBrbV/w5W0eBXEoz1fgLytQkc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1KCCXbXqSC5b47yjdxXvs2wUFSFDNhDiqQeYk369BiMZlTaAu
	Dp2XDcdGCub0Sf2rpd8PY7ErjqU6yfl0SoOkw13RNRZiXN3LtlVkk/bA5EDOyWjNd72AA2YND1W
	VHmM0qgb5CLR6nE2aRun7/xxQglY=
X-Google-Smtp-Source: AGHT+IHoSZ9iJCWtN80lyMqQitxDGgAShQFIS0lvgU/Pc6cfEG/3CV/yHOpOqP7fXB3VcEHlkC+ua8YEP2qjdiHnOR4=
X-Received: by 2002:a05:6102:4411:b0:4a3:cce7:8177 with SMTP id
 ada2fe7eead31-4a751c07bddmr2531920137.16.1729679219093; Wed, 23 Oct 2024
 03:26:59 -0700 (PDT)
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
In-Reply-To: <CAGsJ_4wWf7QnibY_uU8B=efuEACrvFaJJ=bJTD+9KrxFtfoMmQ@mail.gmail.com>
From: Barry Song <21cnbao@gmail.com>
Date: Wed, 23 Oct 2024 23:26:47 +1300
Message-ID: <CAGsJ_4w5XLMok4F6Xw7aTAdV6rY9OvCVPM3U+hzFnKyTXBUpOA@mail.gmail.com>
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

On Wed, Oct 23, 2024 at 11:07=E2=80=AFAM Barry Song <21cnbao@gmail.com> wro=
te:
>
> On Wed, Oct 23, 2024 at 10:17=E2=80=AFAM Usama Arif <usamaarif642@gmail.c=
om> wrote:
> >
> >
> >
> > On 22/10/2024 21:46, Barry Song wrote:
> > > On Wed, Oct 23, 2024 at 4:26=E2=80=AFAM Usama Arif <usamaarif642@gmai=
l.com> wrote:
> > >>
> > >>
> > >>
> > >> On 21/10/2024 11:40, Usama Arif wrote:
> > >>>
> > >>>
> > >>> On 21/10/2024 06:09, Barry Song wrote:
> > >>>> On Fri, Oct 18, 2024 at 11:50=E2=80=AFPM Usama Arif <usamaarif642@=
gmail.com> wrote:
> > >>>>>
> > >>>>> After large folio zswapout support added in [1], this patch adds
> > >>>>> support for zswapin of large folios to bring it on par with zram.
> > >>>>> This series makes sure that the benefits of large folios (fewer
> > >>>>> page faults, batched PTE and rmap manipulation, reduced lru list,
> > >>>>> TLB coalescing (for arm64 and amd)) are not lost at swap out when
> > >>>>> using zswap.
> > >>>>>
> > >>>>> It builds on top of [2] which added large folio swapin support fo=
r
> > >>>>> zram and provides the same level of large folio swapin support as
> > >>>>> zram, i.e. only supporting swap count =3D=3D 1.
> > >>>>>
> > >>>>> Patch 1 skips swapcache for swapping in zswap pages, this should =
improve
> > >>>>> no readahead swapin performance [3], and also allows us to build =
on large
> > >>>>> folio swapin support added in [2], hence is a prerequisite for pa=
tch 3.
> > >>>>>
> > >>>>> Patch 3 adds support for large folio zswapin. This patch does not=
 add
> > >>>>> support for hybrid backends (i.e. folios partly present swap and =
zswap).
> > >>>>>
> > >>>>> The main performance benefit comes from maintaining large folios =
*after*
> > >>>>> swapin, large folio performance improvements have been mentioned =
in previous
> > >>>>> series posted on it [2],[4], so have not added those. Below is a =
simple
> > >>>>> microbenchmark to measure the time needed *for* zswpin of 1G memo=
ry (along
> > >>>>> with memory integrity check).
> > >>>>>
> > >>>>>                                 |  no mTHP (ms) | 1M mTHP enabled=
 (ms)
> > >>>>> Base kernel                     |   1165        |    1163
> > >>>>> Kernel with mTHP zswpin series  |   1203        |     738
> > >>>>
> > >>>> Hi Usama,
> > >>>> Do you know where this minor regression for non-mTHP comes from?
> > >>>> As you even have skipped swapcache for small folios in zswap in pa=
tch1,
> > >>>> that part should have some gain? is it because of zswap_present_te=
st()?
> > >>>>
> > >>>
> > >>> Hi Barry,
> > >>>
> > >>> The microbenchmark does a sequential read of 1G of memory, so it pr=
obably
> > >>> isnt very representative of real world usecases. This also means th=
at
> > >>> swap_vma_readahead is able to readahead accurately all pages in its=
 window.
> > >>> With this patch series, if doing 4K swapin, you get 1G/4K calls of =
fast
> > >>> do_swap_page. Without this patch, you get 1G/(4K*readahead window) =
of slow
> > >>> do_swap_page calls. I had added some prints and I was seeing 8 page=
s being
> > >>> readahead in 1 do_swap_page. The larger number of calls causes the =
slight
> > >>> regression (eventhough they are quite fast). I think in a realistic=
 scenario,
> > >>> where readahead window wont be as large, there wont be a regression=
.
> > >>> The cost of zswap_present_test in the whole call stack of swapping =
page is
> > >>> very low and I think can be ignored.
> > >>>
> > >>> I think the more interesting thing is what Kanchana pointed out in
> > >>> https://lore.kernel.org/all/f2f2053f-ec5f-46a4-800d-50a3d2e61bff@gm=
ail.com/
> > >>> I am curious, did you see this when testing large folio swapin and =
compression
> > >>> at 4K granuality? Its looks like swap thrashing so I think it would=
 be common
> > >>> between zswap and zram. I dont have larger granuality zswap compres=
sion done,
> > >>> which is why I think there is a regression in time taken. (It could=
 be because
> > >>> its tested on intel as well).
> > >>>
> > >>> Thanks,
> > >>> Usama
> > >>>
> > >>
> > >> Hi,
> > >>
> > >> So I have been doing some benchmarking after Kanchana pointed out a =
performance
> > >> regression in [1] of swapping in large folio. I would love to get th=
oughts from
> > >> zram folks on this, as thats where large folio swapin was first adde=
d [2].
> > >> As far as I can see, the current support in zram is doing large foli=
o swapin
> > >> at 4K granuality. The large granuality compression in [3] which was =
posted
> > >> in March is not merged, so I am currently comparing upstream zram wi=
th this series.
> > >>
> > >> With the microbenchmark below of timing 1G swapin, there was a very =
large improvement
> > >> in performance by using this series. I think similar numbers would b=
e seen in zram.
> > >
> > > Imagine running several apps on a phone and switching
> > > between them: A =E2=86=92 B =E2=86=92 C =E2=86=92 D =E2=86=92 E =E2=
=80=A6 =E2=86=92 A =E2=86=92 B =E2=80=A6 The app
> > > currently on the screen retains its memory, while the ones
> > > sent to the background are swapped out. When we bring
> > > those apps back to the foreground, their memory is restored.
> > > This behavior is quite similar to what you're seeing with
> > > your microbenchmark.
> > >
> >
> > Hi Barry,
> >
> > Thanks for explaining this! Do you know if there is some open source be=
nchmark
> > we could use to show an improvement in app switching with large folios?
> >
>
> I=E2=80=99m fairly certain the Android team has this benchmark, but it=E2=
=80=99s not
> open source.
>
> A straightforward way to simulate this is to use a script that
> cyclically launches multiple applications, such as Chrome, Firefox,
> Office, PDF, and others.
>
> for example:
>
> launch chrome;
> launch firefox;
> launch youtube;
> ....
> launch chrome;
> launch firefox;
> ....
>
> On Android, we have "Android activity manager 'am' command" to do that.
> https://gist.github.com/tsohr/5711945
>
> Not quite sure if other windows managers have similar tools.
>
> > Also I guess swap thrashing can happen when apps are brought back to fo=
reground?
> >
>
> Typically, the foreground app doesn't experience much swapping,
> as it is the most recently or frequently used. However, this may
> not hold for very low-end phones, where memory is significantly
> less than the app's working set. For instance, we can't expect a
> good user experience when playing a large game that requires 8GB
> of memory on a 4GB phone! :-)
> And for low-end phones, we never even enable mTHP.
>
> > >>
> > >> But when doing kernel build test, Kanchana saw a regression in [1]. =
I believe
> > >> its because of swap thrashing (causing large zswap activity), due to=
 larger page swapin.
> > >> The part of the code that decides large folio swapin is the same bet=
ween zswap and zram,
> > >> so I believe this would be observed in zram as well.
> > >
> > > Is this an extreme case where the workload's working set far
> > > exceeds the available memory by memcg limitation? I doubt mTHP
> > > would provide any real benefit from the start if the workload is boun=
d to
> > > experience swap thrashing. What if we disable mTHP entirely?
> > >
> >
> > I would agree, this is an extreme case. I wanted (z)swap activity to ha=
ppen so limited
> > memory.max to 4G.
> >
> > mTHP is beneficial in kernel test benchmarking going from no mTHP to 16=
K:
> >
> > ARM make defconfig; time make -j$(nproc) Image, cgroup memory.max=3D4G
> > metric         no mTHP         16K mTHP=3Dalways
> > real           1m0.613s         0m52.008s
> > user           25m23.028s       25m19.488s
> > sys            25m45.466s       18m11.640s
> > zswpin         1911194          3108438
> > zswpout        6880815          9374628
> > pgfault        120430166        48976658
> > pgmajfault     1580674          2327086
> >
> >
>
> Interesting! We never use a phone to build the Linux kernel, but
> let me see if I can find some other machines to reproduce your data.

Hi Usama,

I suspect the regression occurs because you're running an edge case
where the memory cgroup stays nearly full most of the time (this isn't
an inherent issue with large folio swap-in). As a result, swapping in
mTHP quickly triggers a memcg overflow, causing a swap-out. The
next swap-in then recreates the overflow, leading to a repeating
cycle.

We need a way to stop the cup from repeatedly filling to the brim and
overflowing. While not a definitive fix, the following change might help
improve the situation:

diff --git a/mm/memcontrol.c b/mm/memcontrol.c

index 17af08367c68..f2fa0eeb2d9a 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c

@@ -4559,7 +4559,10 @@ int mem_cgroup_swapin_charge_folio(struct folio
*folio, struct mm_struct *mm,
                memcg =3D get_mem_cgroup_from_mm(mm);
        rcu_read_unlock();

-       ret =3D charge_memcg(folio, memcg, gfp);
+       if (folio_test_large(folio) && mem_cgroup_margin(memcg) <
MEMCG_CHARGE_BATCH)
+               ret =3D -ENOMEM;
+       else
+               ret =3D charge_memcg(folio, memcg, gfp);

        css_put(&memcg->css);
        return ret;
}

Please confirm if it makes the kernel build with memcg limitation
faster. If so, let's
work together to figure out an official patch :-) The above code hasn't con=
sider
the parent memcg's overflow, so not an ideal fix.

>
> >
> >
> > >>
> > >> My initial thought was this might be because its intel, where you do=
nt have the advantage
> > >> of TLB coalescing, so tested on AMD and ARM, but the regression is t=
here on AMD
> > >> and ARM as well, though a bit less (have added the numbers below).
> > >>
> > >> The numbers show that the zswap activity increases and page faults d=
ecrease.
> > >> Overall this does result in sys time increasing and real time slight=
ly increases,
> > >> likely because the cost of increased zswap activity is more than the=
 benefit of
> > >> lower page faults.
> > >> I can see in [3] that pagefaults reduced in zram as well.
> > >>
> > >> Large folio swapin shows good numbers in microbenchmarks that just t=
arget reduce page
> > >> faults and sequential swapin only, but not in kernel build test. Is =
a similar regression
> > >> observed with zram when enabling large folio swapin on kernel build =
test? Maybe large
> > >> folio swapin makes more sense on workloads where mappings are kept f=
or a longer time?
> > >>
> > >
> > > I suspect this is because mTHP doesn't always benefit workloads
> > > when available memory is quite limited compared to the working set.
> > > In that case, mTHP swap-in might introduce more features that
> > > exacerbate the problem. We used to have an extra control "swapin_enab=
led"
> > > for swap-in, but it never gained much traction:
> > > https://lore.kernel.org/linux-mm/20240726094618.401593-5-21cnbao@gmai=
l.com/
> > > We can reconsider whether to include the knob, but if it's better
> > > to disable mTHP entirely for these cases, we can still adhere to
> > > the policy of "enabled".
> > >
> > Yes I think this makes sense to have. The only thing is, its too many k=
nobs!
> > I personally think its already difficult to decide upto which mTHP size=
 we
> > should enable (and I think this changes per workload). But if we add sw=
apin_enabled
> > on top of that it can make things more difficult.
> >
> > > Using large block compression and decompression in zRAM will
> > > significantly reduce CPU usage, likely making the issue unnoticeable.
> > > However, the default minimum size for large block support is currentl=
y
> > > set to 64KB(ZSMALLOC_MULTI_PAGES_ORDER =3D 4).
> > >
> >
> > I saw that the patch was sent in March, and there werent any updates af=
ter?
> > Maybe I can try and cherry-pick that and see if we can develop large
> > granularity compression for zswap.
>
> will provide an updated version next week.
>
> >
> > >>
> > >> Kernel build numbers in cgroup with memory.max=3D4G to trigger zswap
> > >> Command for AMD: make defconfig; time make -j$(nproc) bzImage
> > >> Command for ARM: make defconfig; time make -j$(nproc) Image
> > >>
> > >>
> > >> AMD 16K+32K THP=3Dalways
> > >> metric         mm-unstable      mm-unstable + large folio zswapin se=
ries
> > >> real           1m23.038s        1m23.050s
> > >> user           53m57.210s       53m53.437s
> > >> sys            7m24.592s        7m48.843s
> > >> zswpin         612070           999244
> > >> zswpout        2226403          2347979
> > >> pgfault        20667366         20481728
> > >> pgmajfault     385887           269117
> > >>
> > >> AMD 16K+32K+64K THP=3Dalways
> > >> metric         mm-unstable      mm-unstable + large folio zswapin se=
ries
> > >> real           1m22.975s        1m23.266s
> > >> user           53m51.302s       53m51.069s
> > >> sys            7m40.168s        7m57.104s
> > >> zswpin         676492           1258573
> > >> zswpout        2449839          2714767
> > >> pgfault        17540746         17296555
> > >> pgmajfault     429629           307495
> > >> --------------------------
> > >> ARM 16K+32K THP=3Dalways
> > >> metric         mm-unstable      mm-unstable + large folio zswapin se=
ries
> > >> real           0m51.168s        0m52.086s
> > >> user           25m14.715s       25m15.765s
> > >> sys            17m18.856s       18m8.031s
> > >> zswpin         3904129          7339245
> > >> zswpout        11171295         13473461
> > >> pgfault        37313345         36011338
> > >> pgmajfault     2726253          1932642
> > >>
> > >>
> > >> ARM 16K+32K+64K THP=3Dalways
> > >> metric         mm-unstable      mm-unstable + large folio zswapin se=
ries
> > >> real           0m52.017s        0m53.828s
> > >> user           25m2.742s        25m0.046s
> > >> sys            18m24.525s       20m26.207s
> > >> zswpin         4853571          8908664
> > >> zswpout        12297199         15768764
> > >> pgfault        32158152         30425519
> > >> pgmajfault     3320717          2237015
> > >>
> > >>
> > >> Thanks!
> > >> Usama
> > >>
> > >>
> > >> [1] https://lore.kernel.org/all/f2f2053f-ec5f-46a4-800d-50a3d2e61bff=
@gmail.com/
> > >> [2] https://lore.kernel.org/all/20240821074541.516249-3-hanchuanhua@=
oppo.com/
> > >> [3] https://lore.kernel.org/all/20240327214816.31191-1-21cnbao@gmail=
.com/
> > >>
> > >>>
> > >>>>>
> > >>>>> The time measured was pretty consistent between runs (~1-2% varia=
tion).
> > >>>>> There is 36% improvement in zswapin time with 1M folios. The perc=
entage
> > >>>>> improvement is likely to be more if the memcmp is removed.
> > >>>>>
> > >>>>> diff --git a/tools/testing/selftests/cgroup/test_zswap.c b/tools/=
testing/selftests/cgroup/test_zswap.c
> > >>>>> index 40de679248b8..77068c577c86 100644
> > >>>>> --- a/tools/testing/selftests/cgroup/test_zswap.c
> > >>>>> +++ b/tools/testing/selftests/cgroup/test_zswap.c
> > >>>>> @@ -9,6 +9,8 @@
> > >>>>>  #include <string.h>
> > >>>>>  #include <sys/wait.h>
> > >>>>>  #include <sys/mman.h>
> > >>>>> +#include <sys/time.h>
> > >>>>> +#include <malloc.h>
> > >>>>>
> > >>>>>  #include "../kselftest.h"
> > >>>>>  #include "cgroup_util.h"
> > >>>>> @@ -407,6 +409,74 @@ static int test_zswap_writeback_disabled(con=
st char *root)
> > >>>>>         return test_zswap_writeback(root, false);
> > >>>>>  }
> > >>>>>
> > >>>>> +static int zswapin_perf(const char *cgroup, void *arg)
> > >>>>> +{
> > >>>>> +       long pagesize =3D sysconf(_SC_PAGESIZE);
> > >>>>> +       size_t memsize =3D MB(1*1024);
> > >>>>> +       char buf[pagesize];
> > >>>>> +       int ret =3D -1;
> > >>>>> +       char *mem;
> > >>>>> +       struct timeval start, end;
> > >>>>> +
> > >>>>> +       mem =3D (char *)memalign(2*1024*1024, memsize);
> > >>>>> +       if (!mem)
> > >>>>> +               return ret;
> > >>>>> +
> > >>>>> +       /*
> > >>>>> +        * Fill half of each page with increasing data, and keep =
other
> > >>>>> +        * half empty, this will result in data that is still com=
pressible
> > >>>>> +        * and ends up in zswap, with material zswap usage.
> > >>>>> +        */
> > >>>>> +       for (int i =3D 0; i < pagesize; i++)
> > >>>>> +               buf[i] =3D i < pagesize/2 ? (char) i : 0;
> > >>>>> +
> > >>>>> +       for (int i =3D 0; i < memsize; i +=3D pagesize)
> > >>>>> +               memcpy(&mem[i], buf, pagesize);
> > >>>>> +
> > >>>>> +       /* Try and reclaim allocated memory */
> > >>>>> +       if (cg_write_numeric(cgroup, "memory.reclaim", memsize)) =
{
> > >>>>> +               ksft_print_msg("Failed to reclaim all of the requ=
ested memory\n");
> > >>>>> +               goto out;
> > >>>>> +       }
> > >>>>> +
> > >>>>> +       gettimeofday(&start, NULL);
> > >>>>> +       /* zswpin */
> > >>>>> +       for (int i =3D 0; i < memsize; i +=3D pagesize) {
> > >>>>> +               if (memcmp(&mem[i], buf, pagesize)) {
> > >>>>> +                       ksft_print_msg("invalid memory\n");
> > >>>>> +                       goto out;
> > >>>>> +               }
> > >>>>> +       }
> > >>>>> +       gettimeofday(&end, NULL);
> > >>>>> +       printf ("zswapin took %fms to run.\n", (end.tv_sec - star=
t.tv_sec)*1000 + (double)(end.tv_usec - start.tv_usec) / 1000);
> > >>>>> +       ret =3D 0;
> > >>>>> +out:
> > >>>>> +       free(mem);
> > >>>>> +       return ret;
> > >>>>> +}
> > >>>>> +
> > >>>>> +static int test_zswapin_perf(const char *root)
> > >>>>> +{
> > >>>>> +       int ret =3D KSFT_FAIL;
> > >>>>> +       char *test_group;
> > >>>>> +
> > >>>>> +       test_group =3D cg_name(root, "zswapin_perf_test");
> > >>>>> +       if (!test_group)
> > >>>>> +               goto out;
> > >>>>> +       if (cg_create(test_group))
> > >>>>> +               goto out;
> > >>>>> +
> > >>>>> +       if (cg_run(test_group, zswapin_perf, NULL))
> > >>>>> +               goto out;
> > >>>>> +
> > >>>>> +       ret =3D KSFT_PASS;
> > >>>>> +out:
> > >>>>> +       cg_destroy(test_group);
> > >>>>> +       free(test_group);
> > >>>>> +       return ret;
> > >>>>> +}
> > >>>>> +
> > >>>>>  /*
> > >>>>>   * When trying to store a memcg page in zswap, if the memcg hits=
 its memory
> > >>>>>   * limit in zswap, writeback should affect only the zswapped pag=
es of that
> > >>>>> @@ -584,6 +654,7 @@ struct zswap_test {
> > >>>>>         T(test_zswapin),
> > >>>>>         T(test_zswap_writeback_enabled),
> > >>>>>         T(test_zswap_writeback_disabled),
> > >>>>> +       T(test_zswapin_perf),
> > >>>>>         T(test_no_kmem_bypass),
> > >>>>>         T(test_no_invasive_cgroup_shrink),
> > >>>>>  };
> > >>>>>
> > >>>>> [1] https://lore.kernel.org/all/20241001053222.6944-1-kanchana.p.=
sridhar@intel.com/
> > >>>>> [2] https://lore.kernel.org/all/20240821074541.516249-1-hanchuanh=
ua@oppo.com/
> > >>>>> [3] https://lore.kernel.org/all/1505886205-9671-5-git-send-email-=
minchan@kernel.org/T/#u
> > >>>>> [4] https://lwn.net/Articles/955575/
> > >>>>>
> > >>>>> Usama Arif (4):
> > >>>>>   mm/zswap: skip swapcache for swapping in zswap pages
> > >>>>>   mm/zswap: modify zswap_decompress to accept page instead of fol=
io
> > >>>>>   mm/zswap: add support for large folio zswapin
> > >>>>>   mm/zswap: count successful large folio zswap loads
> > >>>>>
> > >>>>>  Documentation/admin-guide/mm/transhuge.rst |   3 +
> > >>>>>  include/linux/huge_mm.h                    |   1 +
> > >>>>>  include/linux/zswap.h                      |   6 ++
> > >>>>>  mm/huge_memory.c                           |   3 +
> > >>>>>  mm/memory.c                                |  16 +--
> > >>>>>  mm/page_io.c                               |   2 +-
> > >>>>>  mm/zswap.c                                 | 120 ++++++++++++++-=
------
> > >>>>>  7 files changed, 99 insertions(+), 52 deletions(-)
> > >>>>>
> > >>>>> --
> > >>>>> 2.43.5
> > >>>>>
> > >>>>
> > >
>

Thanks
Barry

