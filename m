Return-Path: <linux-kernel+bounces-417787-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A2AE9D5914
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 06:24:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C010DB21D8C
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 05:24:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A97B114D2B1;
	Fri, 22 Nov 2024 05:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XK6G+qvo"
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D1AA23B0
	for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 05:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732253035; cv=none; b=eQmdVd1gneuAZCDhQ0x++i/1cpV1Q6g6ghmqPtg0VvEAeyQnyd71pLDtJ1S8EYvVU6SFN6KSKXLukvLBAfGBhUvmOsL/5Wmu6zJwwDnwHg5RhFfZWTAdJgZYqd85XK1ni28+GMl4xTGbBZZiHxc7PPf0f1q7pRPU5pIcjXwY7j0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732253035; c=relaxed/simple;
	bh=Hr1l9fZHXInCa1Hvwoejg/UWltwImSSKrH/3CRiL1L4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=t60EezLJhiPbkJrufnqMefaCUypvZeAUPQ79dczZMZlBdPinZ3QL0nt/5rCyhCgfX2sfv1SWgYnYqg4JutMzoyQrxI5k2Ehg0D0A/yV+4eu36fJckoT2gwCCVRmELlvDN1Qg8QOHTLR4pKQstgh5L2aFYv9tRFhs0SPAn5GLxn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XK6G+qvo; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-38231f84d8fso206101f8f.3
        for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2024 21:23:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732253031; x=1732857831; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qvfIu7WCtHFH+dZSegvvY/gAEu78tDcDOUONYuh+hwM=;
        b=XK6G+qvoufp+KJRiTMT+W/AfFFWmjLBqlHdlOkTn5+FpkU3zW+AlPYFn+t0bEL9+u4
         q9W0P+uwXN1NB3Z1Q4q5eoJBkTzKdEdsRQdyZAg1kqJdy6lDSEZyS+r3keajBQFnHPCj
         sSDeCIn8kHPpcT+ml8ez79Ku5LX13BJBLQGdxouAhLu73GlqQIexzAnw079PF5xhWB0a
         HZJyHSp+k7tS+SS8x5WxZ7UDG/iZSow6O6/fKtPN3UZuogzjKu+ok1DcCHhvJjpsAmFU
         LbwKJ3WjriVyLZoVTbf31M5N6xRPhl3p+vIl+eHSyLyCNM/DhYtSWio7dHRszp4pXhrJ
         AmCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732253031; x=1732857831;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qvfIu7WCtHFH+dZSegvvY/gAEu78tDcDOUONYuh+hwM=;
        b=F8EI+YVC+TPh1066gvj2kTObNJqdsjxs7MZWqP3+WvximuIt34fR4lh4wm2x4YTuM4
         TswjgUQFrosOlvuZat1nlvbDsoKDeMustU7f3Pk1Eg24Z+dIqDNYvl6T9fHHCZ5LBBco
         pUIcGBkWh2c1BnBtVeaWNqymGYrEF9KSbw4lZrfPU/ByuKE1vDxWY4+lQYZOO7//T6aL
         FgiBzMRQFx9GVnz3ROnTSJ2m1fColahXHh4UG6wloebkDMhBfXZeqQG3UtiaekKQzI6Z
         1yuD4NIt/WpQ2hv1ObJFSitjRc+TBxOyFQr2uz+A9BDoESxvxVItpomIbux6Gt7AXvgD
         oHTA==
X-Forwarded-Encrypted: i=1; AJvYcCUunZICGtlev7rdU3NfRHEOH9DOQvrApST6iorYimfGtKuWlKchNECppC1khrw31Bj4ykJ+zLVuIMNbs90=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0X/2uFWPIYpirtFcwr31MXr8ikU/hlvKmP/1V6tFGNAwcfa6I
	RMWtv3IQnvJQJWLpeXVR1YmvsdgChWo+esdcE5sbmAl9ODMU7LOhoNQFQHXkgx2t0zD+to+9x3D
	RzTBRGFVDdj94bkAe8PCkgtuQ9Fk=
X-Gm-Gg: ASbGnctG+pWF/QU+7YmF49eP6jWVACd5PnFVh+EO+He7Hgg2h/+HzawEkan/zGL84cr
	63OryybYdY9+WSRPJQgok5dVZbHyl0eJJ
X-Google-Smtp-Source: AGHT+IGmsZDvHCeNOpFAyh8dXH/iftRhZDVahZGx26C3AAewoLSLqv7b6VUTiVcbMnYVTwiVOb1pReSfgHbcijcVDIU=
X-Received: by 2002:a5d:47c7:0:b0:382:51bf:b0ec with SMTP id
 ffacd0b85a97d-3826089bf40mr399724f8f.0.1732253031178; Thu, 21 Nov 2024
 21:23:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241121015751.2300234-1-chao@kernel.org> <20241121015751.2300234-2-chao@kernel.org>
In-Reply-To: <20241121015751.2300234-2-chao@kernel.org>
From: Zhiguo Niu <niuzhiguo84@gmail.com>
Date: Fri, 22 Nov 2024 13:23:39 +0800
Message-ID: <CAHJ8P3LhPzmzf-tgiwSh+a+W+EC7pFE9+=RqkHL1543cHMag2w@mail.gmail.com>
Subject: Re: [f2fs-dev] [PATCH 2/2] f2fs: add a sysfs node to limit max read
 extent count per-inode
To: Chao Yu <chao@kernel.org>
Cc: jaegeuk@kernel.org, Xiuhong Wang <xiuhong.wang@unisoc.com>, 
	Zhiguo Niu <zhiguo.niu@unisoc.com>, linux-kernel@vger.kernel.org, 
	linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Chao Yu via Linux-f2fs-devel <linux-f2fs-devel@lists.sourceforge.net>
=E4=BA=8E2024=E5=B9=B411=E6=9C=8821=E6=97=A5=E5=91=A8=E5=9B=9B 10:01=E5=86=
=99=E9=81=93=EF=BC=9A
>
> Quoted:
> "at this time, there are still 1086911 extent nodes in this zombie
> extent tree that need to be cleaned up.
>
> crash_arm64_sprd_v8.0.3++> extent_tree.node_cnt ffffff80896cc500
>   node_cnt =3D {
>     counter =3D 1086911
>   },
> "
>
> As reported by Xiuhong, there will be a huge number of extent nodes
> in extent tree, it may potentially cause:
> - slab memory fragments
> - extreme long time shrink on extent tree
> - low mapping efficiency
>
> Let's add a sysfs node to limit max read extent count for each inode,
> by default, value of this threshold is 10240, it can be updated
> according to user's requirement.
>
> Reported-by: Xiuhong Wang <xiuhong.wang@unisoc.com>
> Closes: https://lore.kernel.org/linux-f2fs-devel/20241112110627.1314632-1=
-xiuhong.wang@unisoc.com/
> Signed-off-by: Xiuhong Wang <xiuhong.wang@unisoc.com>
> Signed-off-by: Zhiguo Niu <zhiguo.niu@unisoc.com>
> Signed-off-by: Chao Yu <chao@kernel.org>
> ---
>  Documentation/ABI/testing/sysfs-fs-f2fs | 6 ++++++
>  fs/f2fs/extent_cache.c                  | 5 ++++-
>  fs/f2fs/f2fs.h                          | 4 ++++
>  fs/f2fs/sysfs.c                         | 7 +++++++
>  4 files changed, 21 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/ABI/testing/sysfs-fs-f2fs b/Documentation/ABI/=
testing/sysfs-fs-f2fs
> index 513296bb6f29..3e1630c70d8a 100644
> --- a/Documentation/ABI/testing/sysfs-fs-f2fs
> +++ b/Documentation/ABI/testing/sysfs-fs-f2fs
> @@ -822,3 +822,9 @@ Description:        It controls the valid block ratio=
 threshold not to trigger excessiv
>                 for zoned deivces. The initial value of it is 95(%). F2FS=
 will stop the
>                 background GC thread from intiating GC for sections havin=
g valid blocks
>                 exceeding the ratio.
> +
> +What:          /sys/fs/f2fs/<disk>/max_read_extent_count
> +Date:          November 2024
> +Contact:       "Chao Yu" <chao@kernel.org>
> +Description:   It controls max read extent count for per-inode, the valu=
e of threshold
> +               is 10240 by default.
> diff --git a/fs/f2fs/extent_cache.c b/fs/f2fs/extent_cache.c
> index b7a6817b44b0..347b3b647834 100644
> --- a/fs/f2fs/extent_cache.c
> +++ b/fs/f2fs/extent_cache.c
> @@ -717,7 +717,9 @@ static void __update_extent_tree_range(struct inode *=
inode,
>                 }
>
>                 if (end < org_end && (type !=3D EX_READ ||
> -                               org_end - end >=3D F2FS_MIN_EXTENT_LEN)) =
{
> +                       (org_end - end >=3D F2FS_MIN_EXTENT_LEN &&
> +                       atomic_read(&et->node_cnt) <
> +                                       sbi->max_read_extent_count))) {
>                         if (parts) {
>                                 __set_extent_info(&ei,
>                                         end, org_end - end,
> @@ -1212,6 +1214,7 @@ void f2fs_init_extent_cache_info(struct f2fs_sb_inf=
o *sbi)
>         sbi->hot_data_age_threshold =3D DEF_HOT_DATA_AGE_THRESHOLD;
>         sbi->warm_data_age_threshold =3D DEF_WARM_DATA_AGE_THRESHOLD;
>         sbi->last_age_weight =3D LAST_AGE_WEIGHT;
> +       sbi->max_read_extent_count =3D DEF_MAX_READ_EXTENT_COUNT;
>  }
>
>  int __init f2fs_create_extent_cache(void)
> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> index b65b023a588a..6f2cbf4c5740 100644
> --- a/fs/f2fs/f2fs.h
> +++ b/fs/f2fs/f2fs.h
> @@ -635,6 +635,9 @@ enum {
>  #define DEF_HOT_DATA_AGE_THRESHOLD     262144
>  #define DEF_WARM_DATA_AGE_THRESHOLD    2621440
>
> +/* default max read extent count per inode */
> +#define DEF_MAX_READ_EXTENT_COUNT      10240
> +
>  /* extent cache type */
>  enum extent_type {
>         EX_READ,
> @@ -1619,6 +1622,7 @@ struct f2fs_sb_info {
>         /* for extent tree cache */
>         struct extent_tree_info extent_tree[NR_EXTENT_CACHES];
>         atomic64_t allocated_data_blocks;       /* for block age extent_c=
ache */
> +       unsigned int max_read_extent_count;     /* max read extent count =
per inode */
>
>         /* The threshold used for hot and warm data seperation*/
>         unsigned int hot_data_age_threshold;
> diff --git a/fs/f2fs/sysfs.c b/fs/f2fs/sysfs.c
> index bdbf24db667b..d1356c656cac 100644
> --- a/fs/f2fs/sysfs.c
> +++ b/fs/f2fs/sysfs.c
> @@ -787,6 +787,13 @@ static ssize_t __sbi_store(struct f2fs_attr *a,
>                 return count;
>         }
>
> +       if (!strcmp(a->attr.name, "max_read_extent_count")) {
> +               if (t > UINT_MAX)
> +                       return -EINVAL;
> +               *ui =3D (unsigned int)t;
> +               return count;
> +       }
> +
Hi Chao,
from Xiuhong remider, it seems miss codes of adding sysfs node
"max_read_extent_count"?
F2FS_SBI_GENERAL_RW_ATTR(max_read_extent_count);
ATTR_LIST(max_read_extent_count);
thanks=EF=BC=81
>         if (!strcmp(a->attr.name, "ipu_policy")) {
>                 if (t >=3D BIT(F2FS_IPU_MAX))
>                         return -EINVAL;
> --
> 2.40.1
>
>
>
> _______________________________________________
> Linux-f2fs-devel mailing list
> Linux-f2fs-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

