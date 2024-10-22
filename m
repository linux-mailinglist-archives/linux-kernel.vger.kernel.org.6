Return-Path: <linux-kernel+bounces-376947-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A44B19AB7EE
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 22:47:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 343451F23A1E
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 20:47:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 921B71CC174;
	Tue, 22 Oct 2024 20:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ST+6stU4"
Received: from mail-vk1-f177.google.com (mail-vk1-f177.google.com [209.85.221.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D5AC1C9ED6;
	Tue, 22 Oct 2024 20:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729630025; cv=none; b=J3AziOGPlhADUDy5KIlFEqqOCM4Fbx4AHSsp8fHzuYbTSfXdpKuMhRb9kak0P8H45NSWGn6E2ulFLV2Mqp+DrPzMES3nkoYkjFG74iw1GwisGdmpRTULUwZPgTS/AbZKD41jRk8FzUoEyihYeJTJiqTWsqVTuiN/9KuSBqYpcc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729630025; c=relaxed/simple;
	bh=lTj8PyZUfguPi2UROHuyGqGE9XlSKt8RTgvW9VIFMqw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hHdV7Lqt/c69rPTq/EG8Ns5kHogx4ad4yXyj0o0wA5mTVlsEmiSlx+3sK4ZKFCWJn8c/pOXC7TkB6vvEIDSnmVbaZiy1g573dvobHeNTk9vZOKt7W0ZGE90Y+DkBv8Usv1YLXGG46YMPJYr3Jo150uEVdUkUoXFU/gii6PnaArg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ST+6stU4; arc=none smtp.client-ip=209.85.221.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f177.google.com with SMTP id 71dfb90a1353d-50d57c109d5so1716468e0c.2;
        Tue, 22 Oct 2024 13:47:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729630022; x=1730234822; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VzMs4glpkrtoeS+CkDx1PfbSV7F7jM84g8Urjy7VeAM=;
        b=ST+6stU4U2a9Oue8dueu/QNzzBfKmt5wzfvCJu+xzXJ8k/hs5WwKJf4MC8NEpuWlXA
         8xOK9l8yV0eWqgxF8M8SSnuJ/IIrHVgyTbOqUdM4v4IG3bRuFd75w8YH4EaVhYJaGl6Y
         Phmfa20Gn5IZMAziIl1e3nLdI6GmYEIkpC5/1qyPL9mWTBxvVq99p7I53y/zQWQpJF8T
         FZ9Hike0zi9tH4rGzjCvnegJ+vgoOir79XfRrZZDohf0UjAsGoJi9N/uUUdqg3U3u/VM
         jEjvdrZR8KBkFckeCq7A1xZ+F9IiJ0FUnvLRnFNhBlsEAJY+i9396GO1aWETK2AlOzBh
         9ENw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729630022; x=1730234822;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VzMs4glpkrtoeS+CkDx1PfbSV7F7jM84g8Urjy7VeAM=;
        b=vQDbSy9rAyRnDk+TWiApnBFJcUGTPzv3XWIB7XPWRjelq6ZYTV8+gMvUOeXGPwQ80n
         AHVX1fM+lbMwE1nq6gyETDNTCi3n35743trHqETb+kOpBBmKRxY5bipY/rHemSavaD7Z
         jEIda1Sxj9ZFq6yXd2RuGFNM+tVXSK6allIBXiS/DUpY+pYirNKU4OHtBhaiJrQfON6h
         1FifwlYuXXTHy82UdHxpG89thgm4yMs0LdokIP81VKe/oh0+0BIfyMLAWB3ADW/he6JO
         Djc4usqRBYNRGtTAQ6tQvZ5i4GF8AN1WKA7dqV6XeHUR6/BQ+1WTdfduVUFYeIrdlsHQ
         qxng==
X-Forwarded-Encrypted: i=1; AJvYcCXLoawCwybNWD07hN/AkfkG9iAP0NSvPlP14EXvrZO7UIbQ2As1aPe/FoaH8d6OaUJne9v4MF4rOUg=@vger.kernel.org, AJvYcCXjaWocvOQSI/TcQOUvQJuPelezZNFD8qZV/usd3nix3XHxDF5nGtKvXQo+hCyY5sDzy1BLOdODrRUfuj+y@vger.kernel.org
X-Gm-Message-State: AOJu0YwML0cGj5/F/w9C/QuLUOER4LlWff1w4nWHui/Hu3yQhjDng34y
	1MesiABTH3p9XKh8Nae9QgNMC9sBXRZMPszIY4ImWu9depjHZytuZoMNqbaQhTSHTzVFeuXPVZH
	1kQaEdPPuT+Z49Rrhugn2Q2kvw5E=
X-Google-Smtp-Source: AGHT+IF2qb7+AOcVia6bPuti55Icxvv3d9XSqc4fEAVKYWlyMSIP8xCYTHU67sjliqi0JcWEAVbOUc9qBeHKi9BNe9k=
X-Received: by 2002:a05:6122:328e:b0:50a:318:b3c2 with SMTP id
 71dfb90a1353d-50fd01d308fmr626121e0c.2.1729630022248; Tue, 22 Oct 2024
 13:47:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241018105026.2521366-1-usamaarif642@gmail.com>
 <CAGsJ_4xweuSwMUBuLSr2eUy69mtQumeDpMZ1g2jFPGq6nFn9fg@mail.gmail.com>
 <5313c721-9cf1-4ecd-ac23-1eeddabd691f@gmail.com> <b1c17b5e-acd9-4bef-820e-699768f1426d@gmail.com>
In-Reply-To: <b1c17b5e-acd9-4bef-820e-699768f1426d@gmail.com>
From: Barry Song <21cnbao@gmail.com>
Date: Wed, 23 Oct 2024 09:46:50 +1300
Message-ID: <CAGsJ_4wykOyJupLhcqkSPe27rdANd=bOJhqxL74vcdZ+T9f==g@mail.gmail.com>
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

On Wed, Oct 23, 2024 at 4:26=E2=80=AFAM Usama Arif <usamaarif642@gmail.com>=
 wrote:
>
>
>
> On 21/10/2024 11:40, Usama Arif wrote:
> >
> >
> > On 21/10/2024 06:09, Barry Song wrote:
> >> On Fri, Oct 18, 2024 at 11:50=E2=80=AFPM Usama Arif <usamaarif642@gmai=
l.com> wrote:
> >>>
> >>> After large folio zswapout support added in [1], this patch adds
> >>> support for zswapin of large folios to bring it on par with zram.
> >>> This series makes sure that the benefits of large folios (fewer
> >>> page faults, batched PTE and rmap manipulation, reduced lru list,
> >>> TLB coalescing (for arm64 and amd)) are not lost at swap out when
> >>> using zswap.
> >>>
> >>> It builds on top of [2] which added large folio swapin support for
> >>> zram and provides the same level of large folio swapin support as
> >>> zram, i.e. only supporting swap count =3D=3D 1.
> >>>
> >>> Patch 1 skips swapcache for swapping in zswap pages, this should impr=
ove
> >>> no readahead swapin performance [3], and also allows us to build on l=
arge
> >>> folio swapin support added in [2], hence is a prerequisite for patch =
3.
> >>>
> >>> Patch 3 adds support for large folio zswapin. This patch does not add
> >>> support for hybrid backends (i.e. folios partly present swap and zswa=
p).
> >>>
> >>> The main performance benefit comes from maintaining large folios *aft=
er*
> >>> swapin, large folio performance improvements have been mentioned in p=
revious
> >>> series posted on it [2],[4], so have not added those. Below is a simp=
le
> >>> microbenchmark to measure the time needed *for* zswpin of 1G memory (=
along
> >>> with memory integrity check).
> >>>
> >>>                                 |  no mTHP (ms) | 1M mTHP enabled (ms=
)
> >>> Base kernel                     |   1165        |    1163
> >>> Kernel with mTHP zswpin series  |   1203        |     738
> >>
> >> Hi Usama,
> >> Do you know where this minor regression for non-mTHP comes from?
> >> As you even have skipped swapcache for small folios in zswap in patch1=
,
> >> that part should have some gain? is it because of zswap_present_test()=
?
> >>
> >
> > Hi Barry,
> >
> > The microbenchmark does a sequential read of 1G of memory, so it probab=
ly
> > isnt very representative of real world usecases. This also means that
> > swap_vma_readahead is able to readahead accurately all pages in its win=
dow.
> > With this patch series, if doing 4K swapin, you get 1G/4K calls of fast
> > do_swap_page. Without this patch, you get 1G/(4K*readahead window) of s=
low
> > do_swap_page calls. I had added some prints and I was seeing 8 pages be=
ing
> > readahead in 1 do_swap_page. The larger number of calls causes the slig=
ht
> > regression (eventhough they are quite fast). I think in a realistic sce=
nario,
> > where readahead window wont be as large, there wont be a regression.
> > The cost of zswap_present_test in the whole call stack of swapping page=
 is
> > very low and I think can be ignored.
> >
> > I think the more interesting thing is what Kanchana pointed out in
> > https://lore.kernel.org/all/f2f2053f-ec5f-46a4-800d-50a3d2e61bff@gmail.=
com/
> > I am curious, did you see this when testing large folio swapin and comp=
ression
> > at 4K granuality? Its looks like swap thrashing so I think it would be =
common
> > between zswap and zram. I dont have larger granuality zswap compression=
 done,
> > which is why I think there is a regression in time taken. (It could be =
because
> > its tested on intel as well).
> >
> > Thanks,
> > Usama
> >
>
> Hi,
>
> So I have been doing some benchmarking after Kanchana pointed out a perfo=
rmance
> regression in [1] of swapping in large folio. I would love to get thought=
s from
> zram folks on this, as thats where large folio swapin was first added [2]=
.
> As far as I can see, the current support in zram is doing large folio swa=
pin
> at 4K granuality. The large granuality compression in [3] which was poste=
d
> in March is not merged, so I am currently comparing upstream zram with th=
is series.
>
> With the microbenchmark below of timing 1G swapin, there was a very large=
 improvement
> in performance by using this series. I think similar numbers would be see=
n in zram.

Imagine running several apps on a phone and switching
between them: A =E2=86=92 B =E2=86=92 C =E2=86=92 D =E2=86=92 E =E2=80=A6 =
=E2=86=92 A =E2=86=92 B =E2=80=A6 The app
currently on the screen retains its memory, while the ones
sent to the background are swapped out. When we bring
those apps back to the foreground, their memory is restored.
This behavior is quite similar to what you're seeing with
your microbenchmark.

>
> But when doing kernel build test, Kanchana saw a regression in [1]. I bel=
ieve
> its because of swap thrashing (causing large zswap activity), due to larg=
er page swapin.
> The part of the code that decides large folio swapin is the same between =
zswap and zram,
> so I believe this would be observed in zram as well.

Is this an extreme case where the workload's working set far
exceeds the available memory by memcg limitation? I doubt mTHP
would provide any real benefit from the start if the workload is bound to
experience swap thrashing. What if we disable mTHP entirely?

>
> My initial thought was this might be because its intel, where you dont ha=
ve the advantage
> of TLB coalescing, so tested on AMD and ARM, but the regression is there =
on AMD
> and ARM as well, though a bit less (have added the numbers below).
>
> The numbers show that the zswap activity increases and page faults decrea=
se.
> Overall this does result in sys time increasing and real time slightly in=
creases,
> likely because the cost of increased zswap activity is more than the bene=
fit of
> lower page faults.
> I can see in [3] that pagefaults reduced in zram as well.
>
> Large folio swapin shows good numbers in microbenchmarks that just target=
 reduce page
> faults and sequential swapin only, but not in kernel build test. Is a sim=
ilar regression
> observed with zram when enabling large folio swapin on kernel build test?=
 Maybe large
> folio swapin makes more sense on workloads where mappings are kept for a =
longer time?
>

I suspect this is because mTHP doesn't always benefit workloads
when available memory is quite limited compared to the working set.
In that case, mTHP swap-in might introduce more features that
exacerbate the problem. We used to have an extra control "swapin_enabled"
for swap-in, but it never gained much traction:
https://lore.kernel.org/linux-mm/20240726094618.401593-5-21cnbao@gmail.com/
We can reconsider whether to include the knob, but if it's better
to disable mTHP entirely for these cases, we can still adhere to
the policy of "enabled".

Using large block compression and decompression in zRAM will
significantly reduce CPU usage, likely making the issue unnoticeable.
However, the default minimum size for large block support is currently
set to 64KB(ZSMALLOC_MULTI_PAGES_ORDER =3D 4).

>
> Kernel build numbers in cgroup with memory.max=3D4G to trigger zswap
> Command for AMD: make defconfig; time make -j$(nproc) bzImage
> Command for ARM: make defconfig; time make -j$(nproc) Image
>
>
> AMD 16K+32K THP=3Dalways
> metric         mm-unstable      mm-unstable + large folio zswapin series
> real           1m23.038s        1m23.050s
> user           53m57.210s       53m53.437s
> sys            7m24.592s        7m48.843s
> zswpin         612070           999244
> zswpout        2226403          2347979
> pgfault        20667366         20481728
> pgmajfault     385887           269117
>
> AMD 16K+32K+64K THP=3Dalways
> metric         mm-unstable      mm-unstable + large folio zswapin series
> real           1m22.975s        1m23.266s
> user           53m51.302s       53m51.069s
> sys            7m40.168s        7m57.104s
> zswpin         676492           1258573
> zswpout        2449839          2714767
> pgfault        17540746         17296555
> pgmajfault     429629           307495
> --------------------------
> ARM 16K+32K THP=3Dalways
> metric         mm-unstable      mm-unstable + large folio zswapin series
> real           0m51.168s        0m52.086s
> user           25m14.715s       25m15.765s
> sys            17m18.856s       18m8.031s
> zswpin         3904129          7339245
> zswpout        11171295         13473461
> pgfault        37313345         36011338
> pgmajfault     2726253          1932642
>
>
> ARM 16K+32K+64K THP=3Dalways
> metric         mm-unstable      mm-unstable + large folio zswapin series
> real           0m52.017s        0m53.828s
> user           25m2.742s        25m0.046s
> sys            18m24.525s       20m26.207s
> zswpin         4853571          8908664
> zswpout        12297199         15768764
> pgfault        32158152         30425519
> pgmajfault     3320717          2237015
>
>
> Thanks!
> Usama
>
>
> [1] https://lore.kernel.org/all/f2f2053f-ec5f-46a4-800d-50a3d2e61bff@gmai=
l.com/
> [2] https://lore.kernel.org/all/20240821074541.516249-3-hanchuanhua@oppo.=
com/
> [3] https://lore.kernel.org/all/20240327214816.31191-1-21cnbao@gmail.com/
>
> >
> >>>
> >>> The time measured was pretty consistent between runs (~1-2% variation=
).
> >>> There is 36% improvement in zswapin time with 1M folios. The percenta=
ge
> >>> improvement is likely to be more if the memcmp is removed.
> >>>
> >>> diff --git a/tools/testing/selftests/cgroup/test_zswap.c b/tools/test=
ing/selftests/cgroup/test_zswap.c
> >>> index 40de679248b8..77068c577c86 100644
> >>> --- a/tools/testing/selftests/cgroup/test_zswap.c
> >>> +++ b/tools/testing/selftests/cgroup/test_zswap.c
> >>> @@ -9,6 +9,8 @@
> >>>  #include <string.h>
> >>>  #include <sys/wait.h>
> >>>  #include <sys/mman.h>
> >>> +#include <sys/time.h>
> >>> +#include <malloc.h>
> >>>
> >>>  #include "../kselftest.h"
> >>>  #include "cgroup_util.h"
> >>> @@ -407,6 +409,74 @@ static int test_zswap_writeback_disabled(const c=
har *root)
> >>>         return test_zswap_writeback(root, false);
> >>>  }
> >>>
> >>> +static int zswapin_perf(const char *cgroup, void *arg)
> >>> +{
> >>> +       long pagesize =3D sysconf(_SC_PAGESIZE);
> >>> +       size_t memsize =3D MB(1*1024);
> >>> +       char buf[pagesize];
> >>> +       int ret =3D -1;
> >>> +       char *mem;
> >>> +       struct timeval start, end;
> >>> +
> >>> +       mem =3D (char *)memalign(2*1024*1024, memsize);
> >>> +       if (!mem)
> >>> +               return ret;
> >>> +
> >>> +       /*
> >>> +        * Fill half of each page with increasing data, and keep othe=
r
> >>> +        * half empty, this will result in data that is still compres=
sible
> >>> +        * and ends up in zswap, with material zswap usage.
> >>> +        */
> >>> +       for (int i =3D 0; i < pagesize; i++)
> >>> +               buf[i] =3D i < pagesize/2 ? (char) i : 0;
> >>> +
> >>> +       for (int i =3D 0; i < memsize; i +=3D pagesize)
> >>> +               memcpy(&mem[i], buf, pagesize);
> >>> +
> >>> +       /* Try and reclaim allocated memory */
> >>> +       if (cg_write_numeric(cgroup, "memory.reclaim", memsize)) {
> >>> +               ksft_print_msg("Failed to reclaim all of the requeste=
d memory\n");
> >>> +               goto out;
> >>> +       }
> >>> +
> >>> +       gettimeofday(&start, NULL);
> >>> +       /* zswpin */
> >>> +       for (int i =3D 0; i < memsize; i +=3D pagesize) {
> >>> +               if (memcmp(&mem[i], buf, pagesize)) {
> >>> +                       ksft_print_msg("invalid memory\n");
> >>> +                       goto out;
> >>> +               }
> >>> +       }
> >>> +       gettimeofday(&end, NULL);
> >>> +       printf ("zswapin took %fms to run.\n", (end.tv_sec - start.tv=
_sec)*1000 + (double)(end.tv_usec - start.tv_usec) / 1000);
> >>> +       ret =3D 0;
> >>> +out:
> >>> +       free(mem);
> >>> +       return ret;
> >>> +}
> >>> +
> >>> +static int test_zswapin_perf(const char *root)
> >>> +{
> >>> +       int ret =3D KSFT_FAIL;
> >>> +       char *test_group;
> >>> +
> >>> +       test_group =3D cg_name(root, "zswapin_perf_test");
> >>> +       if (!test_group)
> >>> +               goto out;
> >>> +       if (cg_create(test_group))
> >>> +               goto out;
> >>> +
> >>> +       if (cg_run(test_group, zswapin_perf, NULL))
> >>> +               goto out;
> >>> +
> >>> +       ret =3D KSFT_PASS;
> >>> +out:
> >>> +       cg_destroy(test_group);
> >>> +       free(test_group);
> >>> +       return ret;
> >>> +}
> >>> +
> >>>  /*
> >>>   * When trying to store a memcg page in zswap, if the memcg hits its=
 memory
> >>>   * limit in zswap, writeback should affect only the zswapped pages o=
f that
> >>> @@ -584,6 +654,7 @@ struct zswap_test {
> >>>         T(test_zswapin),
> >>>         T(test_zswap_writeback_enabled),
> >>>         T(test_zswap_writeback_disabled),
> >>> +       T(test_zswapin_perf),
> >>>         T(test_no_kmem_bypass),
> >>>         T(test_no_invasive_cgroup_shrink),
> >>>  };
> >>>
> >>> [1] https://lore.kernel.org/all/20241001053222.6944-1-kanchana.p.srid=
har@intel.com/
> >>> [2] https://lore.kernel.org/all/20240821074541.516249-1-hanchuanhua@o=
ppo.com/
> >>> [3] https://lore.kernel.org/all/1505886205-9671-5-git-send-email-minc=
han@kernel.org/T/#u
> >>> [4] https://lwn.net/Articles/955575/
> >>>
> >>> Usama Arif (4):
> >>>   mm/zswap: skip swapcache for swapping in zswap pages
> >>>   mm/zswap: modify zswap_decompress to accept page instead of folio
> >>>   mm/zswap: add support for large folio zswapin
> >>>   mm/zswap: count successful large folio zswap loads
> >>>
> >>>  Documentation/admin-guide/mm/transhuge.rst |   3 +
> >>>  include/linux/huge_mm.h                    |   1 +
> >>>  include/linux/zswap.h                      |   6 ++
> >>>  mm/huge_memory.c                           |   3 +
> >>>  mm/memory.c                                |  16 +--
> >>>  mm/page_io.c                               |   2 +-
> >>>  mm/zswap.c                                 | 120 ++++++++++++++-----=
--
> >>>  7 files changed, 99 insertions(+), 52 deletions(-)
> >>>
> >>> --
> >>> 2.43.5
> >>>
> >>

Thanks
Barry

