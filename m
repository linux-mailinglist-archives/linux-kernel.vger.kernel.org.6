Return-Path: <linux-kernel+bounces-518350-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 853A0A38DC0
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 21:59:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D3F2E1696A9
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 20:59:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD69A239094;
	Mon, 17 Feb 2025 20:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gGaJurzX"
Received: from mail-ua1-f50.google.com (mail-ua1-f50.google.com [209.85.222.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A73D238D35
	for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 20:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739825959; cv=none; b=Sv/AhlPsVJ5PAldkkjdwaTIy0r8GNCsLQB+2q1kuaJJs9CU4jh6NE8FpIc09PhkNn4sdf4SaBPXtiXEIyqtGw8dp/C1Nn0Xu2ypHVyJVy4sSLboMD8nInQgaXnABnhyfRA/fxs3yetiiDXdOZQG7wVs4Z5vLBDPGT0pjFaUlO+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739825959; c=relaxed/simple;
	bh=WuU8p6064CgpWvovK2DNE1efAG5dEUZEugUzVJuJNg0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=padoUTuWgz2IjMbTyxkTaQvsZsuz1rtrwtFqtHj6XqWlf90pvTpiHwaGPIw552mGyw9oMW4RQEwixpMEZ0+YnA1sWrayptvocffnD6+EBXYtMERIgMdPKS3JDb1bdLMPaGA8CZKoZI4H+9AUfBw00o81ml1Grpt4NwfzVtugOvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gGaJurzX; arc=none smtp.client-ip=209.85.222.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f50.google.com with SMTP id a1e0cc1a2514c-868ddc4c6b6so1755085241.2
        for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 12:59:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739825956; x=1740430756; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gN9C6GJ3vbuBk+DYa6AYbjdNka3yXQK1xjjdcHzYn2Q=;
        b=gGaJurzXuCqfjcxTI9Y2OPMT6t/OVGEOQwB55CHTbSNZnkuP084XLYXKV56g6WgMAl
         oT8dz++SeA0dfQbClN/IvLt8hPcfNggPO292iVtcfpRWGz1pSO9JzivvfoT0f1w4v+Nj
         EfXQNyWAR+a9ijvEBDWNZKSrn2ygiPYgbWy2ECLjF/JefU0tIqpnpwDu1d/udZVDR8gf
         ISMLF4MSZBsMWvm7jNPsVnae5AaZyiLmz+HyeDI18Ljk4UXZLCL/1nG97I7rUWJC1JUe
         4t+tj27USZhoQsV5KqXjOBpnjQBr1q+4yU23ZmxRqRP1EhmvmnyPABYtnAKVssivjhn7
         QN5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739825956; x=1740430756;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gN9C6GJ3vbuBk+DYa6AYbjdNka3yXQK1xjjdcHzYn2Q=;
        b=iNsYUq053vxHuZxvR6kloZx6TUzH3+4+Slwl4Imp6L87kLbSASQJpfSMfSrNGZGqMw
         e3XXPXCHwoK/LdDoss/jwKyUJDF6b48MYn6G/wMSQVXyzYSHQxS+gmrJDbHaz3TzIaEg
         8Nk56avkPW9iPOxmI8JINcrbnuRXaKgIjtvcm1FuwolbHQO1t41pi4hmZASnay7GWcXg
         9JeV2QtMu+gwMt1Q9dGId61svwJQYmF3mcbp0ib+gF5c9eppUm8A7mSdlfY/xoJ2FXn6
         5t2AIxUiRKNzvfYTjJKtSDpHxnjxfKZTluJpE4+ZZHsLBgKOsZFZR3+KMIZKkRDMnxvK
         Q1nQ==
X-Forwarded-Encrypted: i=1; AJvYcCWL6zM3KvjKcDz1MegsTJMEnS0RljpRt2/kI0KJFd0j0z4ReRlCpXkBBJACEZHboouidPNjiGXndgr753o=@vger.kernel.org
X-Gm-Message-State: AOJu0YzN/WEkm8TgRJZzbOwTZuGkeWKfm5+ATMLI3tXNRTYxodEy32UA
	p5QigVQp4zYreKJ9HdxKgIUoRbtfbmMjfZteY3wfujFMCJQ1AiVaLersSNKVt2MvPGLoBdRSJPR
	Dk643KW/bNQqlTCuBP6181m2hzDI=
X-Gm-Gg: ASbGnctukxdEBeyXvft5SuNg6mHf4m2Iz1+qwx14UUdKs4dW9U0c6XTuOH/l4lGDISB
	2EaLY9uWLT7eGc2icqFyi+KqZH7sOG05tsnvbpGwEK0ZbJ0qYoOAPGihcDde+6Q16kt2uwWkP
X-Google-Smtp-Source: AGHT+IFdaFX0/LJZFrJBYXEwXt2w/+z6Cc+X5KMG6NJcp3HawFYZtb+e5VkrS4tF5/vC93zwML9XTsstZR4xaLqSQxU=
X-Received: by 2002:a05:6102:26d6:b0:4bb:d7f0:6e70 with SMTP id
 ada2fe7eead31-4bd3fc60789mr4993862137.5.1739825956149; Mon, 17 Feb 2025
 12:59:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250212022718.1995504-1-xiaqinxin@huawei.com> <20250212022718.1995504-3-xiaqinxin@huawei.com>
In-Reply-To: <20250212022718.1995504-3-xiaqinxin@huawei.com>
From: Barry Song <21cnbao@gmail.com>
Date: Tue, 18 Feb 2025 09:59:05 +1300
X-Gm-Features: AWEUYZkaz_erMtIH_9ZSRhIBgB5LLNaeOovPv5qkk3rDjQ5IhCT-Wxr4Y907wiM
Message-ID: <CAGsJ_4yDBT4rJyG4-Ow4T3xLq8VujBjG+-uxjnWUm_vW1nzT_A@mail.gmail.com>
Subject: Re: [PATCH 2/3] dma-mapping: benchmark: add support for dma_map_sg
To: Qinxin Xia <xiaqinxin@huawei.com>
Cc: chenxiang66@hisilicon.com, yangyicong@huawei.com, hch@lst.de, 
	iommu@lists.linux.dev, jonathan.cameron@huawei.com, prime.zeng@huawei.com, 
	fanghao11@huawei.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 12, 2025 at 3:27=E2=80=AFPM Qinxin Xia <xiaqinxin@huawei.com> w=
rote:
>
> Support for dma scatter-gather mapping and is intended for testing
> mapping performance. It achieves by introducing the dma_sg_map_param
> structure and related functions, which enable the implementation of
> scatter-gather mapping preparation, mapping, and unmapping operations.
> Additionally, the dma_map_benchmark_ops array is updated to include
> operations for scatter-gather mapping. This commit aims to provide
> a wider range of mapping performance test  to cater to different scenario=
s.

This benchmark is mainly designed to debug contention issues, such as IOMMU
TLB flushes or IOMMU driver bottlenecks. I don't fully understand how SG or
single will impact the evaluation of the IOMMU driver, making it unclear if=
 the
added complexity is justified.

Can you add some explanation on why single mode is not sufficient for profi=
ling
and improving IOMMU drivers?

>
> Signed-off-by: Qinxin Xia <xiaqinxin@huawei.com>
> ---
>  include/linux/map_benchmark.h |   1 +
>  kernel/dma/map_benchmark.c    | 102 ++++++++++++++++++++++++++++++++++
>  2 files changed, 103 insertions(+)
>
> diff --git a/include/linux/map_benchmark.h b/include/linux/map_benchmark.=
h
> index 054db02a03a7..a9c1a104ba4f 100644
> --- a/include/linux/map_benchmark.h
> +++ b/include/linux/map_benchmark.h
> @@ -17,6 +17,7 @@
>
>  enum {
>         DMA_MAP_SINGLE_MODE,
> +       DMA_MAP_SG_MODE,
>         DMA_MAP_MODE_MAX
>  };
>
> diff --git a/kernel/dma/map_benchmark.c b/kernel/dma/map_benchmark.c
> index d8ec0ce058d8..b5828eeb3db7 100644
> --- a/kernel/dma/map_benchmark.c
> +++ b/kernel/dma/map_benchmark.c
> @@ -17,6 +17,7 @@
>  #include <linux/module.h>
>  #include <linux/pci.h>
>  #include <linux/platform_device.h>
> +#include <linux/scatterlist.h>
>  #include <linux/slab.h>
>  #include <linux/timekeeping.h>
>
> @@ -111,8 +112,109 @@ static struct map_benchmark_ops dma_single_map_benc=
hmark_ops =3D {
>         .do_unmap =3D dma_single_map_benchmark_do_unmap,
>  };
>
> +struct dma_sg_map_param {
> +       struct sg_table sgt;
> +       struct device *dev;
> +       void **buf;
> +       u32 npages;
> +       u32 dma_dir;
> +};
> +
> +static void *dma_sg_map_benchmark_prepare(struct map_benchmark_data *map=
)
> +{
> +       struct scatterlist *sg;
> +       int i =3D 0;
> +
> +       struct dma_sg_map_param *mparam __free(kfree) =3D kzalloc(sizeof(=
*mparam), GFP_KERNEL);
> +       if (!mparam)
> +               return NULL;
> +
> +       mparam->npages =3D map->bparam.granule;
> +       mparam->dma_dir =3D map->bparam.dma_dir;
> +       mparam->dev =3D map->dev;
> +       mparam->buf =3D kmalloc_array(mparam->npages, sizeof(*mparam->buf=
),
> +                                   GFP_KERNEL);
> +       if (!mparam->buf)
> +               goto err1;
> +
> +       if (sg_alloc_table(&mparam->sgt, mparam->npages, GFP_KERNEL))
> +               goto err2;
> +
> +       for_each_sgtable_sg(&mparam->sgt, sg, i) {
> +               mparam->buf[i] =3D (void *)__get_free_page(GFP_KERNEL);
> +               if (!mparam->buf[i])
> +                       goto err3;
> +
> +               if (mparam->dma_dir !=3D DMA_FROM_DEVICE)
> +                       memset(mparam->buf[i], 0x66, PAGE_SIZE);
> +
> +               sg_set_buf(sg, mparam->buf[i], PAGE_SIZE);
> +       }
> +
> +       return_ptr(mparam);
> +
> +err3:
> +       while (i-- > 0)
> +               free_page((unsigned long)mparam->buf[i]);
> +
> +       pr_err("dma_map_sg failed get free page on %s\n", dev_name(mparam=
->dev));
> +       sg_free_table(&mparam->sgt);
> +err2:
> +       pr_err("dma_map_sg failed alloc sg table on %s\n", dev_name(mpara=
m->dev));
> +       kfree(mparam->buf);
> +err1:
> +       pr_err("dma_map_sg failed alloc mparam buf on %s\n", dev_name(mpa=
ram->dev));
> +       return NULL;
> +}
> +
> +static void dma_sg_map_benchmark_unprepare(void *arg)
> +{
> +       struct dma_sg_map_param *mparam =3D arg;
> +       int i;
> +
> +       for (i =3D 0; i < mparam->npages; i++)
> +               free_page((unsigned long)mparam->buf[i]);
> +
> +       sg_free_table(&mparam->sgt);
> +
> +       kfree(mparam->buf);
> +       kfree(mparam);
> +}
> +
> +static int dma_sg_map_benchmark_do_map(void *arg)
> +{
> +       struct dma_sg_map_param *mparam =3D arg;
> +
> +       int sg_mapped =3D dma_map_sg(mparam->dev, mparam->sgt.sgl,
> +                                  mparam->npages, mparam->dma_dir);
> +       if (!sg_mapped) {
> +               pr_err("dma_map_sg failed on %s\n", dev_name(mparam->dev)=
);
> +               return -ENOMEM;
> +       }
> +
> +       return 0;
> +}
> +
> +static int dma_sg_map_benchmark_do_unmap(void *arg)
> +{
> +       struct dma_sg_map_param *mparam =3D arg;
> +
> +       dma_unmap_sg(mparam->dev, mparam->sgt.sgl, mparam->npages,
> +                    mparam->dma_dir);
> +
> +       return 0;
> +}
> +
> +static struct map_benchmark_ops dma_sg_map_benchmark_ops =3D {
> +       .prepare =3D dma_sg_map_benchmark_prepare,
> +       .unprepare =3D dma_sg_map_benchmark_unprepare,
> +       .do_map =3D dma_sg_map_benchmark_do_map,
> +       .do_unmap =3D dma_sg_map_benchmark_do_unmap,
> +};
> +
>  static struct map_benchmark_ops *dma_map_benchmark_ops[DMA_MAP_MODE_MAX]=
 =3D {
>         [DMA_MAP_SINGLE_MODE] =3D &dma_single_map_benchmark_ops,
> +       [DMA_MAP_SG_MODE] =3D &dma_sg_map_benchmark_ops,
>  };
>
>  static int map_benchmark_thread(void *data)
> --
> 2.33.0
>

Thanks
Barry

