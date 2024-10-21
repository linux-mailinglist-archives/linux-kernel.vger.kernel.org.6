Return-Path: <linux-kernel+bounces-373638-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D68A9A59A8
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 07:09:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 395A7281110
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 05:09:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85A4E19408B;
	Mon, 21 Oct 2024 05:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l1M7yn0N"
Received: from mail-ua1-f46.google.com (mail-ua1-f46.google.com [209.85.222.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF8E420309;
	Mon, 21 Oct 2024 05:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729487360; cv=none; b=TXbo+KngYAOE54XkDrRKITDiA8J6Bd3ylyehIpeFywNxg+cxXKwGswY+BXK/8shqfgW9R8BC5PFBxv9y78PMR90gmsyS/2DuC3QAefo7XBaSoJ4C3SAk84xrbU7cRwQjlrEWjTyS3r1xU55jb26G8E4+8oVTmUMpawgMifMaCAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729487360; c=relaxed/simple;
	bh=VdBZa22JXUz+U22C7XAzqsphA7Nq7h40Ydaiw43ERrs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HW7JXLmiIPDTI0uwQgfUaQqJvaO5IJQELBa7MvK75Z4UrbXeMo/zll9PRa76oggQ06GiPGW1/pG1c20UF8I2pXpYmC3eH/JmvWw0KKBPu5+KLkHPW+RqG96bSCbEQ3n1UjeYJntjtPMlr+/OSsSlbKwdfGr3f56NmUNrPILQOEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l1M7yn0N; arc=none smtp.client-ip=209.85.222.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f46.google.com with SMTP id a1e0cc1a2514c-84fcb49691fso1289954241.3;
        Sun, 20 Oct 2024 22:09:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729487357; x=1730092157; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5ZfuLO1PsYZ/2x/t2VqSxTRS6GMZs9BTeqlNjwBX8hg=;
        b=l1M7yn0NowpkFbAXfeHtADZ3po7InEMMwBBMld5F+hnhH/66XDuHlsktbVuORk0MFI
         AVSgamI/+/3JoZkqkXDuORwA7sOOCNoIdOGeoWdxl2KC/HvReDjbJm3kj+jBejCLim5z
         vgH6KeZLUOc9eU1t+WBAfITbWWApNorbqjDtJIAfOnCY8qH/rYa6JHpJ1DTYNNAcE+l0
         qkm8TLH2t3JT7fBvYb6uOLlgZcAw0gy82eAgT9SQs3c/c1SNF3yVkGf6SWVH9wTrs3T7
         3IGgQDvBFPqJ1vYvRZQPycmD3zROtcPbU2lzMtbKk+i1avu0jktL8h+BNlMst/y6d7RN
         R+Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729487357; x=1730092157;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5ZfuLO1PsYZ/2x/t2VqSxTRS6GMZs9BTeqlNjwBX8hg=;
        b=QL29VqItpXl1uEBNQV1E2Fz72xRgV4cC1HX71D75NkxOwfZQ0b50GtEbbRDE5kbogs
         bitGFZeWjB9gLHL2PzmIITXkuGFWw655++KD6ebgESPeADXNaa/D8D2sOakmJkJLcs09
         1PMB5k+Cobe2mgJtn8gVqHQl5rAvYuEuua9y0aTB0EsDJ4bKeHXtmlEHQ13V/sKDVfDO
         AnHaeILhIkIF26VFE32lnQVMmCzj0gt4yzcLUa6ixV/Cwwd438ImR6APVbyqWJD+tm8R
         1QtZvAP4UzjrL4CoxbsuhGPl5GA3U21uaq6qwj9UjCJSrgM6GXfYaMSvZ9GrmnD7apFD
         saTA==
X-Forwarded-Encrypted: i=1; AJvYcCW0iIcO1CIhnhYT8nj2ZVg9J4e6liUlfEDL1Vza1P6+c0St1jlDyOBeiapTz4t0aKotJhziqPfrm58=@vger.kernel.org, AJvYcCXE0UDKLlgwLnpXbYtfbGqXzM3nnd8APCWhPTcjvonLluSxvbZB7Saym7qMnpPfxhv+W+b0o5KSHCOmPL8Q@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4TkxZd76dlB8PuFrcG1ifwfhDATnP121CVwa1IpzqDpl/y61Y
	rJ3qGhW9oWugaagBZ5sI1wLv65rb9Q8xAKs5cDW0TTqar1+3xMkwP5pH7D3r8B4JXdqyVyMhtc4
	imlOfdQ9HjvERs9TvPc+nqmfOEPQ=
X-Google-Smtp-Source: AGHT+IH3xl7ThsfvKchUSKP+3qWnkHnpxJwcuvCeybMDE6GJeUa8ZBQy9SW1x/IgozmKqdbiCG+gNSwH41GKQQl1OHg=
X-Received: by 2002:a05:6102:c4e:b0:4a4:80a0:98fb with SMTP id
 ada2fe7eead31-4a5d6a74742mr7957823137.5.1729487357560; Sun, 20 Oct 2024
 22:09:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241018105026.2521366-1-usamaarif642@gmail.com>
In-Reply-To: <20241018105026.2521366-1-usamaarif642@gmail.com>
From: Barry Song <21cnbao@gmail.com>
Date: Mon, 21 Oct 2024 18:09:06 +1300
Message-ID: <CAGsJ_4xweuSwMUBuLSr2eUy69mtQumeDpMZ1g2jFPGq6nFn9fg@mail.gmail.com>
Subject: Re: [RFC 0/4] mm: zswap: add support for zswapin of large folios
To: Usama Arif <usamaarif642@gmail.com>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org, hannes@cmpxchg.org, 
	david@redhat.com, willy@infradead.org, kanchana.p.sridhar@intel.com, 
	yosryahmed@google.com, nphamcs@gmail.com, chengming.zhou@linux.dev, 
	ryan.roberts@arm.com, ying.huang@intel.com, riel@surriel.com, 
	shakeel.butt@linux.dev, kernel-team@meta.com, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 18, 2024 at 11:50=E2=80=AFPM Usama Arif <usamaarif642@gmail.com=
> wrote:
>
> After large folio zswapout support added in [1], this patch adds
> support for zswapin of large folios to bring it on par with zram.
> This series makes sure that the benefits of large folios (fewer
> page faults, batched PTE and rmap manipulation, reduced lru list,
> TLB coalescing (for arm64 and amd)) are not lost at swap out when
> using zswap.
>
> It builds on top of [2] which added large folio swapin support for
> zram and provides the same level of large folio swapin support as
> zram, i.e. only supporting swap count =3D=3D 1.
>
> Patch 1 skips swapcache for swapping in zswap pages, this should improve
> no readahead swapin performance [3], and also allows us to build on large
> folio swapin support added in [2], hence is a prerequisite for patch 3.
>
> Patch 3 adds support for large folio zswapin. This patch does not add
> support for hybrid backends (i.e. folios partly present swap and zswap).
>
> The main performance benefit comes from maintaining large folios *after*
> swapin, large folio performance improvements have been mentioned in previ=
ous
> series posted on it [2],[4], so have not added those. Below is a simple
> microbenchmark to measure the time needed *for* zswpin of 1G memory (alon=
g
> with memory integrity check).
>
>                                 |  no mTHP (ms) | 1M mTHP enabled (ms)
> Base kernel                     |   1165        |    1163
> Kernel with mTHP zswpin series  |   1203        |     738

Hi Usama,
Do you know where this minor regression for non-mTHP comes from?
As you even have skipped swapcache for small folios in zswap in patch1,
that part should have some gain? is it because of zswap_present_test()?

>
> The time measured was pretty consistent between runs (~1-2% variation).
> There is 36% improvement in zswapin time with 1M folios. The percentage
> improvement is likely to be more if the memcmp is removed.
>
> diff --git a/tools/testing/selftests/cgroup/test_zswap.c b/tools/testing/=
selftests/cgroup/test_zswap.c
> index 40de679248b8..77068c577c86 100644
> --- a/tools/testing/selftests/cgroup/test_zswap.c
> +++ b/tools/testing/selftests/cgroup/test_zswap.c
> @@ -9,6 +9,8 @@
>  #include <string.h>
>  #include <sys/wait.h>
>  #include <sys/mman.h>
> +#include <sys/time.h>
> +#include <malloc.h>
>
>  #include "../kselftest.h"
>  #include "cgroup_util.h"
> @@ -407,6 +409,74 @@ static int test_zswap_writeback_disabled(const char =
*root)
>         return test_zswap_writeback(root, false);
>  }
>
> +static int zswapin_perf(const char *cgroup, void *arg)
> +{
> +       long pagesize =3D sysconf(_SC_PAGESIZE);
> +       size_t memsize =3D MB(1*1024);
> +       char buf[pagesize];
> +       int ret =3D -1;
> +       char *mem;
> +       struct timeval start, end;
> +
> +       mem =3D (char *)memalign(2*1024*1024, memsize);
> +       if (!mem)
> +               return ret;
> +
> +       /*
> +        * Fill half of each page with increasing data, and keep other
> +        * half empty, this will result in data that is still compressibl=
e
> +        * and ends up in zswap, with material zswap usage.
> +        */
> +       for (int i =3D 0; i < pagesize; i++)
> +               buf[i] =3D i < pagesize/2 ? (char) i : 0;
> +
> +       for (int i =3D 0; i < memsize; i +=3D pagesize)
> +               memcpy(&mem[i], buf, pagesize);
> +
> +       /* Try and reclaim allocated memory */
> +       if (cg_write_numeric(cgroup, "memory.reclaim", memsize)) {
> +               ksft_print_msg("Failed to reclaim all of the requested me=
mory\n");
> +               goto out;
> +       }
> +
> +       gettimeofday(&start, NULL);
> +       /* zswpin */
> +       for (int i =3D 0; i < memsize; i +=3D pagesize) {
> +               if (memcmp(&mem[i], buf, pagesize)) {
> +                       ksft_print_msg("invalid memory\n");
> +                       goto out;
> +               }
> +       }
> +       gettimeofday(&end, NULL);
> +       printf ("zswapin took %fms to run.\n", (end.tv_sec - start.tv_sec=
)*1000 + (double)(end.tv_usec - start.tv_usec) / 1000);
> +       ret =3D 0;
> +out:
> +       free(mem);
> +       return ret;
> +}
> +
> +static int test_zswapin_perf(const char *root)
> +{
> +       int ret =3D KSFT_FAIL;
> +       char *test_group;
> +
> +       test_group =3D cg_name(root, "zswapin_perf_test");
> +       if (!test_group)
> +               goto out;
> +       if (cg_create(test_group))
> +               goto out;
> +
> +       if (cg_run(test_group, zswapin_perf, NULL))
> +               goto out;
> +
> +       ret =3D KSFT_PASS;
> +out:
> +       cg_destroy(test_group);
> +       free(test_group);
> +       return ret;
> +}
> +
>  /*
>   * When trying to store a memcg page in zswap, if the memcg hits its mem=
ory
>   * limit in zswap, writeback should affect only the zswapped pages of th=
at
> @@ -584,6 +654,7 @@ struct zswap_test {
>         T(test_zswapin),
>         T(test_zswap_writeback_enabled),
>         T(test_zswap_writeback_disabled),
> +       T(test_zswapin_perf),
>         T(test_no_kmem_bypass),
>         T(test_no_invasive_cgroup_shrink),
>  };
>
> [1] https://lore.kernel.org/all/20241001053222.6944-1-kanchana.p.sridhar@=
intel.com/
> [2] https://lore.kernel.org/all/20240821074541.516249-1-hanchuanhua@oppo.=
com/
> [3] https://lore.kernel.org/all/1505886205-9671-5-git-send-email-minchan@=
kernel.org/T/#u
> [4] https://lwn.net/Articles/955575/
>
> Usama Arif (4):
>   mm/zswap: skip swapcache for swapping in zswap pages
>   mm/zswap: modify zswap_decompress to accept page instead of folio
>   mm/zswap: add support for large folio zswapin
>   mm/zswap: count successful large folio zswap loads
>
>  Documentation/admin-guide/mm/transhuge.rst |   3 +
>  include/linux/huge_mm.h                    |   1 +
>  include/linux/zswap.h                      |   6 ++
>  mm/huge_memory.c                           |   3 +
>  mm/memory.c                                |  16 +--
>  mm/page_io.c                               |   2 +-
>  mm/zswap.c                                 | 120 ++++++++++++++-------
>  7 files changed, 99 insertions(+), 52 deletions(-)
>
> --
> 2.43.5
>

Thanks
barry

