Return-Path: <linux-kernel+bounces-548543-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 86B36A54644
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 10:28:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4DAB43B0C50
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 09:28:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71D2D209692;
	Thu,  6 Mar 2025 09:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FxmWPOL2"
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E13B920101A
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 09:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741253296; cv=none; b=ImU97R7q5+sHHt9tg4gb2i3G6WOlk6s+Ml2uW0nFg4inPILKnsaaYGqKmoD0CtMGig5YAsFLMGGZJP/JoW+xEpu1Dz/XFaVNuUk/3nM8tWp95P7SFP5PZmdnJ7bc52t2HOqbpWCyZkLNQx8a9uCfJGE0hhihRSYor7kpMaxzPuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741253296; c=relaxed/simple;
	bh=NhSldC0StQJliVf3OGZstcBg4t38fxbc7Y2jy8MQeN0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=l7TU3bK2U5uz/ft5T/G+4/RxbUz3IkHl7rm6sQW3ZoLxdMFyDir1MUvlAeGjbKm3bRU87dvoK0UXS4N0V0dUe8nLR6Gm5sG90YkN055PvrpfS1BG9+eMEE51EnHyYLIUV7sDGHSwGBqIGbelTjt1vepoWu7B6Fnhd2QhMxLIEBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FxmWPOL2; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-6e8992f9a45so2996306d6.0
        for <linux-kernel@vger.kernel.org>; Thu, 06 Mar 2025 01:28:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741253294; x=1741858094; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WqAfDSob7smaNT3kQ4hD78feEG4BxS7W63H/J3wi1GM=;
        b=FxmWPOL2Vv7GsAriZnbtGNRSQkldJIkvrkY3wJ95na2RjIHHp15AqbFYrOh6rvl0hc
         ThgmHQSE2MiQetymhRFZv5oWHu/r4jI3gcBWSUnRvwHw7UzTh/8SKnLt5eLmm8IUEwKS
         i7jTeGcKge7pS/Xw81EmXK+Fj9CEbMCWAft/zsKRJHRdWMyFyjdLZidCD3Kospd1Eclf
         3GXtlBQrWpdULf1o5BD2Yfghfalcy7e5BjdHbXUTxzVSrq0sPExpQW9zeBrbxrZ8QTQg
         ebKQvUvF3UQIeIoKXnIYWFkVVyE9bEPJcRLdQKTxlUFjx3Lo1WUDPDZLox95tgMZtwmW
         /fng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741253294; x=1741858094;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WqAfDSob7smaNT3kQ4hD78feEG4BxS7W63H/J3wi1GM=;
        b=n+dIwUV4aLnpllX+0w3/BVEcWnVvdTaXO/NwFu58VL1diyHTFp5VRzNnj8eVqFn31W
         75N9K0+C0EZEZvJCMaZvCROY/FNHWqfSJooGm2dTycs0w9t3ONZT8vblezSyjswD8eau
         mLWPDQdSupKdRMY9YpU0vrmQVXhwKysxWgbzGmLjsAQJMNKEpKDHhnqFYtP55UsMZi8/
         P9OFUfwamTU3YblG8GMTaR2wfjR8WTiK7abtZXIwOYK/tvfHWcv4AVlR9n2S+ZJ/KeLH
         hH2Yx3yVW7sVnH9lZtvdQ5DwPaMP80klry4CEvm7ZIK0GmonkaHS6vnQostehFT5YQtB
         RH6g==
X-Forwarded-Encrypted: i=1; AJvYcCXShRCe4Ftn6WCpxJPuQzFVfftRYIyJ3w6qGiUvqUDLl01+G/f8Mb9qhsk3nuKeHs3KWNmNmAbo8Ket2/g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxoza7mD6YVYYdEl42LGhuAHLLmjeFDAj/tj6HmmEt7SdSjp9zw
	mLOa4xpXD0v6BUiDDnnziS2bpQuyZowHkatNmo3Oh1L+EM9lCARcrVkbSbVwbEnbpE1NU7/DQ4r
	YB4YmSkdM1BbD6LZn4Rb30+vdkHDoDwmA2d0=
X-Gm-Gg: ASbGncv8oEsXJ8nZ9lo6A8N+FeWXNwr4EXWy/GgDAXQU9kBJ/eJwp7uOKYKamJMTwC2
	Pk2Wmx7W/IrAXRTC2BICO+VypM0K171ay2umDoZcKYrkXOiqawh5fPyKJdHpEZDcwlaMfNAXzOV
	1On1fAtVuspDClwYdwujaB21S/sw==
X-Google-Smtp-Source: AGHT+IH+fPk0U4uJyEDh9wNyghvHwGXmf97oOT9QYQaONOtTn8LWHeXBqGWVHSVP77e94hrFuFOaIfpMayyrXC5p+4o=
X-Received: by 2002:a05:6214:e4b:b0:6e4:2872:45f5 with SMTP id
 6a1803df08f44-6e8e6d108d7mr93352636d6.25.1741253293497; Thu, 06 Mar 2025
 01:28:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250212022718.1995504-1-xiaqinxin@huawei.com>
 <20250212022718.1995504-3-xiaqinxin@huawei.com> <CAGsJ_4yDBT4rJyG4-Ow4T3xLq8VujBjG+-uxjnWUm_vW1nzT_A@mail.gmail.com>
 <43618c9167654c68945ec5e7d9bf69d5@huawei.com> <CAGsJ_4zNTYsMkeBav7z=AKdm5CjB=Y73P1QBzq+9FS--z9t9Cw@mail.gmail.com>
 <66470ea1-668a-418a-bcf6-c8702be799ce@huawei.com>
In-Reply-To: <66470ea1-668a-418a-bcf6-c8702be799ce@huawei.com>
From: Barry Song <21cnbao@gmail.com>
Date: Thu, 6 Mar 2025 22:28:02 +1300
X-Gm-Features: AQ5f1JqB8cNhBAWR3qF56LcUJaWZgEaRQfzV6PT1yMNFLa-vwpLH2O0Z_Yl2mhM
Message-ID: <CAGsJ_4wavUq2y1TXAqKE3_paSDnTRdTyJ_j6LmHcjymm4Y-3mA@mail.gmail.com>
Subject: Re: [PATCH 2/3] dma-mapping: benchmark: add support for dma_map_sg
To: Qinxin Xia <xiaqinxin@huawei.com>
Cc: yangyicong <yangyicong@huawei.com>, "hch@lst.de" <hch@lst.de>, 
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>, Jonathan Cameron <jonathan.cameron@huawei.com>, 
	"Zengtao (B)" <prime.zeng@hisilicon.com>, "fanghao (A)" <fanghao11@huawei.com>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 5, 2025 at 2:49=E2=80=AFAM Qinxin Xia <xiaqinxin@huawei.com> wr=
ote:
>
>
> =E5=9C=A8 2025/2/22 14:36, Barry Song =E5=86=99=E9=81=93:
> > On Fri, Feb 21, 2025 at 4:16=E2=80=AFPM xiaqinxin <xiaqinxin@huawei.com=
> wrote:
> >>
> >>
> >> -----=E9=82=AE=E4=BB=B6=E5=8E=9F=E4=BB=B6-----
> >> =E5=8F=91=E4=BB=B6=E4=BA=BA: Barry Song <21cnbao@gmail.com>
> >> =E5=8F=91=E9=80=81=E6=97=B6=E9=97=B4: 2025=E5=B9=B42=E6=9C=8818=E6=97=
=A5 4:59
> >> =E6=94=B6=E4=BB=B6=E4=BA=BA: xiaqinxin <xiaqinxin@huawei.com>
> >> =E6=8A=84=E9=80=81: chenxiang66@hisilicon.com; yangyicong <yangyicong@=
huawei.com>; hch@lst.de; iommu@lists.linux.dev; Jonathan Cameron <jonathan.=
cameron@huawei.com>; Zengtao (B) <prime.zeng@hisilicon.com>; fanghao (A) <f=
anghao11@huawei.com>; linux-kernel@vger.kernel.org
> >> =E4=B8=BB=E9=A2=98: Re: [PATCH 2/3] dma-mapping: benchmark: add suppor=
t for dma_map_sg
> >>
> >> On Wed, Feb 12, 2025 at 3:27=E2=80=AFPM Qinxin Xia <xiaqinxin@huawei.c=
om> wrote:
> >>> Support for dma scatter-gather mapping and is intended for testing
> >>> mapping performance. It achieves by introducing the dma_sg_map_param
> >>> structure and related functions, which enable the implementation of
> >>> scatter-gather mapping preparation, mapping, and unmapping operations=
.
> >>> Additionally, the dma_map_benchmark_ops array is updated to include
> >>> operations for scatter-gather mapping. This commit aims to provide a
> >>> wider range of mapping performance test  to cater to different scenar=
ios.
> >> This benchmark is mainly designed to debug contention issues, such as =
IOMMU TLB flushes or IOMMU driver bottlenecks. I don't fully understand how=
 SG or single will impact the evaluation of the IOMMU driver, making it unc=
lear if the added complexity is justified.
> >>
> >> Can you add some explanation on why single mode is not sufficient for =
profiling and improving IOMMU drivers?
> >>
> >> Hello Barry ! =F0=9F=98=8A
> >> Currently, the HiSilicon accelerator service uses the dma_map_sg inter=
face. We want to evaluate the performance of the entire DMA map process. (i=
ncluding not only the iommu, but also the map framework). In addition, for =
scatterlist, __iommu_map is executed for each nent. This increases the comp=
lexity and time overhead of mapping. The effect of this fragmentation is no=
t obvious in dma_map_single, which only handles a single contiguous block o=
f memory.
> >>
> > Thanks!
> > Please update your editor to ensure it doesn't respond with such long s=
entences
> > without line breaks in the future :-)
>
> Hello Barry !
>
> Thank you for your advice, I will I'll pay attention. Leon
>
> > Can you provide concrete examples or data showing how the newly added m=
ode
> > improves profiling of the entire DMA map process? For instance, what li=
mitations
> > exist without this mode? What performance issues cannot be identified w=
ithout
> > it?
>
> You can see this patch
> :https://lore.kernel.org/all/cover.1738765879.git.leonro@nvidia.com/
>
> Leon provides new interface for scatterlist scenarios to improve
> performance and gives some
>
> application instance in rdma and vfio. Users can use dma_map_sg
> benchmark to measure
>
> the performance improvement of the optimized interface compared with the
> previous one.

I=E2=80=99m not quite sure how this patchset helps compare the new interfac=
es=E2=80=94
dma_iova_try_alloc(), dma_iova_link(), dma_iova_destroy()=E2=80=94with
dma_map_sg(), dma_unmap_sg(), etc. Does this mean you also plan
to include these new interfaces in the benchmark?

However, I agree that this patchset could be useful for evaluating cases
where we are optimizing dma_map_sg itself for A/B side testing. Do we
have such a case?

>
> Thanks!
>
> >
> >>> Signed-off-by: Qinxin Xia <xiaqinxin@huawei.com>
> >>> ---
> >>>   include/linux/map_benchmark.h |   1 +
> >>>   kernel/dma/map_benchmark.c    | 102 +++++++++++++++++++++++++++++++=
+++
> >>>   2 files changed, 103 insertions(+)
> >>>
> >>> diff --git a/include/linux/map_benchmark.h
> >>> b/include/linux/map_benchmark.h index 054db02a03a7..a9c1a104ba4f
> >>> 100644
> >>> --- a/include/linux/map_benchmark.h
> >>> +++ b/include/linux/map_benchmark.h
> >>> @@ -17,6 +17,7 @@
> >>>
> >>>   enum {
> >>>          DMA_MAP_SINGLE_MODE,
> >>> +       DMA_MAP_SG_MODE,
> >>>          DMA_MAP_MODE_MAX
> >>>   };
> >>>
> >>> diff --git a/kernel/dma/map_benchmark.c b/kernel/dma/map_benchmark.c
> >>> index d8ec0ce058d8..b5828eeb3db7 100644
> >>> --- a/kernel/dma/map_benchmark.c
> >>> +++ b/kernel/dma/map_benchmark.c
> >>> @@ -17,6 +17,7 @@
> >>>   #include <linux/module.h>
> >>>   #include <linux/pci.h>
> >>>   #include <linux/platform_device.h>
> >>> +#include <linux/scatterlist.h>
> >>>   #include <linux/slab.h>
> >>>   #include <linux/timekeeping.h>
> >>>
> >>> @@ -111,8 +112,109 @@ static struct map_benchmark_ops dma_single_map_=
benchmark_ops =3D {
> >>>          .do_unmap =3D dma_single_map_benchmark_do_unmap,
> >>>   };
> >>>
> >>> +struct dma_sg_map_param {
> >>> +       struct sg_table sgt;
> >>> +       struct device *dev;
> >>> +       void **buf;
> >>> +       u32 npages;
> >>> +       u32 dma_dir;
> >>> +};
> >>> +
> >>> +static void *dma_sg_map_benchmark_prepare(struct map_benchmark_data
> >>> +*map) {
> >>> +       struct scatterlist *sg;
> >>> +       int i =3D 0;
> >>> +
> >>> +       struct dma_sg_map_param *mparam __free(kfree) =3D kzalloc(siz=
eof(*mparam), GFP_KERNEL);
> >>> +       if (!mparam)
> >>> +               return NULL;
> >>> +
> >>> +       mparam->npages =3D map->bparam.granule;
> >>> +       mparam->dma_dir =3D map->bparam.dma_dir;
> >>> +       mparam->dev =3D map->dev;
> >>> +       mparam->buf =3D kmalloc_array(mparam->npages, sizeof(*mparam-=
>buf),
> >>> +                                   GFP_KERNEL);
> >>> +       if (!mparam->buf)
> >>> +               goto err1;
> >>> +
> >>> +       if (sg_alloc_table(&mparam->sgt, mparam->npages, GFP_KERNEL))
> >>> +               goto err2;
> >>> +
> >>> +       for_each_sgtable_sg(&mparam->sgt, sg, i) {
> >>> +               mparam->buf[i] =3D (void *)__get_free_page(GFP_KERNEL=
);
> >>> +               if (!mparam->buf[i])
> >>> +                       goto err3;
> >>> +
> >>> +               if (mparam->dma_dir !=3D DMA_FROM_DEVICE)
> >>> +                       memset(mparam->buf[i], 0x66, PAGE_SIZE);
> >>> +
> >>> +               sg_set_buf(sg, mparam->buf[i], PAGE_SIZE);
> >>> +       }
> >>> +
> >>> +       return_ptr(mparam);
> >>> +
> >>> +err3:
> >>> +       while (i-- > 0)
> >>> +               free_page((unsigned long)mparam->buf[i]);
> >>> +
> >>> +       pr_err("dma_map_sg failed get free page on %s\n", dev_name(mp=
aram->dev));
> >>> +       sg_free_table(&mparam->sgt);
> >>> +err2:
> >>> +       pr_err("dma_map_sg failed alloc sg table on %s\n", dev_name(m=
param->dev));
> >>> +       kfree(mparam->buf);
> >>> +err1:
> >>> +       pr_err("dma_map_sg failed alloc mparam buf on %s\n", dev_name=
(mparam->dev));
> >>> +       return NULL;
> >>> +}
> >>> +
> >>> +static void dma_sg_map_benchmark_unprepare(void *arg) {
> >>> +       struct dma_sg_map_param *mparam =3D arg;
> >>> +       int i;
> >>> +
> >>> +       for (i =3D 0; i < mparam->npages; i++)
> >>> +               free_page((unsigned long)mparam->buf[i]);
> >>> +
> >>> +       sg_free_table(&mparam->sgt);
> >>> +
> >>> +       kfree(mparam->buf);
> >>> +       kfree(mparam);
> >>> +}
> >>> +
> >>> +static int dma_sg_map_benchmark_do_map(void *arg) {
> >>> +       struct dma_sg_map_param *mparam =3D arg;
> >>> +
> >>> +       int sg_mapped =3D dma_map_sg(mparam->dev, mparam->sgt.sgl,
> >>> +                                  mparam->npages, mparam->dma_dir);
> >>> +       if (!sg_mapped) {
> >>> +               pr_err("dma_map_sg failed on %s\n", dev_name(mparam->=
dev));
> >>> +               return -ENOMEM;
> >>> +       }
> >>> +
> >>> +       return 0;
> >>> +}
> >>> +
> >>> +static int dma_sg_map_benchmark_do_unmap(void *arg) {
> >>> +       struct dma_sg_map_param *mparam =3D arg;
> >>> +
> >>> +       dma_unmap_sg(mparam->dev, mparam->sgt.sgl, mparam->npages,
> >>> +                    mparam->dma_dir);
> >>> +
> >>> +       return 0;
> >>> +}
> >>> +
> >>> +static struct map_benchmark_ops dma_sg_map_benchmark_ops =3D {
> >>> +       .prepare =3D dma_sg_map_benchmark_prepare,
> >>> +       .unprepare =3D dma_sg_map_benchmark_unprepare,
> >>> +       .do_map =3D dma_sg_map_benchmark_do_map,
> >>> +       .do_unmap =3D dma_sg_map_benchmark_do_unmap, };
> >>> +
> >>>   static struct map_benchmark_ops *dma_map_benchmark_ops[DMA_MAP_MODE=
_MAX] =3D {
> >>>          [DMA_MAP_SINGLE_MODE] =3D &dma_single_map_benchmark_ops,
> >>> +       [DMA_MAP_SG_MODE] =3D &dma_sg_map_benchmark_ops,
> >>>   };
> >>>
> >>>   static int map_benchmark_thread(void *data)
> >>> --
> >>> 2.33.0
> >>>

Thanks
Barry

