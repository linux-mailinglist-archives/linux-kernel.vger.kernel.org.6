Return-Path: <linux-kernel+bounces-569124-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A432A69ED7
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 04:33:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DE4DF7A3C66
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 03:32:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15FB91D88A4;
	Thu, 20 Mar 2025 03:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jKGfn2eJ"
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38FE32EAE4
	for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 03:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742441592; cv=none; b=BWSxMsG0FZO3hyT/lQHJ4whqOXcRf68mGH5WKRcPQOUqjDC/bqegdCnPcOSVe/tMpr3YSIOvyqx9uP6zOHHs854EjZ2iA/yyExjgSegfLyTKBLV3NdcrEdCpr7gqi013Bk0sBYHrAKhzsFyxefhxdU3iFCFW3hFOhSq8HAATomM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742441592; c=relaxed/simple;
	bh=YLH+He/C4urGLLNQm670ASoPl8z54Esn0XQBDVvdyXU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=n3qm57o5rMo1FGZMqrI9t+ajpN9lfVh4+jHyEbHSs3InupOeGkLj8CJsGy1pWlLSJMN7R2H8evy7dZ4Pmn4GkvvhZMPzUe0468PCxtVaH5shhq5L0fXCdXRDqtkPqAgcIs0DKRbR2n9vJGJplg2iVK/dQbwPS1uOiFOSnDZ2zVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jKGfn2eJ; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-39973c72e8cso50983f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 20:33:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742441588; x=1743046388; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wAHNeXDKHyLVzzq0rwOTQsewoGoPfVxW3U1+mtmUEUk=;
        b=jKGfn2eJhwXwCIA3CMS/T7SF7QXti40kn4fhL4jyCU24k8RqDtbQe4bsi9xxGIh8pM
         uDTfTBJieMJSo3xZOgZPWBbsYoqRCj09sEISutH85fIQVWULjQPAuailp4Qi6ERIzWoW
         kWBDWY1ZjiEJdB++vzq/zbRgDRBFlHS8rIYDY5r6dI75xh3JxlhAyUv76cFM5+7VbxQg
         7+h/K8yQl+TITtIPNBF3LAa7dcZvUS/onXbC+MlbS97MKlwaW2cBPPb7qa//7Lp1DQJv
         1D4/pVxgM6LUSUs21+WIcQmgZm+eJ3Il3NRmAOdepqAPknAz4O/0NNBmGmUdOfqlGtvc
         uOvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742441588; x=1743046388;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wAHNeXDKHyLVzzq0rwOTQsewoGoPfVxW3U1+mtmUEUk=;
        b=xAxU0c2X+xXgT7GerpzA9xTHU8+xVok2+cmB26VF4GeYxj2PFojEovPvZsiuAb2BjE
         RjixnIrVLkRPI2Dq3mZb1dWR2OIKdYA7SFpbvNkuhwooAtqEngeA+ebufPVl0PqTMZ6c
         jclIwxAjNgGtu8HpLIWUWB0P2mF1N1FrmbWa5GISN/KOINLdbgYh817WH5Bpv2wKeydX
         W/y0yOttrr40QzkCxcvtIAdV7cRa5qtqdYvlg5ivAdjwUqtwWl7qwHgBFYAyx02/u+5d
         FmkcBoX7rr7QfXCW+JHgbGoxDF0CaEhnA2mZ/qEPPQ8fl008/Kcf9afZlao3idvUvXxT
         O0Zw==
X-Forwarded-Encrypted: i=1; AJvYcCUa01+TZprGYJXZeMHIRxTOBbiqEfNuq/MEP4ODx1FwDDp3mD+JRLh8fwmbrSbDNTD8vUo+Xrv3+7ujTbk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw78LXaEDy6fByJpiwgieVorb/p+LJvGkuuwcGJtUbjRhxy2LMe
	HweXF2EZgvTznw3UIHxDnJzetYAZY+9wSlHVzRx3ntJQNk68zmVjBcciUNVez1FtIvD1PCd/uod
	zI7O2352X+LE7gSY9EY4v/w2Dq2A=
X-Gm-Gg: ASbGnctXgMA6X+Bdn3TtyCt3+p5lJI8Jt6gooFP3VcTZTjtNTo72kcfXPB+YvbYU/6w
	QljE/i/RkGiDvu6ArMjrJXq1RAYW4hzs4OZQD8qq8Bg3XxCobLtzSG4OeJ+ghPEtWNq0oWcUxli
	iTf+q/UMbP/4zb+8uCnfxc/Co5HE8=
X-Google-Smtp-Source: AGHT+IHEXNhJPFoziNZC1UXWkFDZ5g6z1JFopiu3vc9Q/LvecS+G6l7WSQf1W3Z/XhrusCBoW5rnkRD9RpvZB4oxqf4=
X-Received: by 2002:a5d:6d8a:0:b0:38d:d743:7d36 with SMTP id
 ffacd0b85a97d-39973afe524mr1531554f8f.10.1742441588158; Wed, 19 Mar 2025
 20:33:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250320022230.1938110-1-chao@kernel.org>
In-Reply-To: <20250320022230.1938110-1-chao@kernel.org>
From: Zhiguo Niu <niuzhiguo84@gmail.com>
Date: Thu, 20 Mar 2025 11:32:57 +0800
X-Gm-Features: AQ5f1JrS67VyAWqmg1qZYDDqtRgmbZBRzQk_sAgUFWj5Ju4NfXDkFsmP1V7ZhT8
Message-ID: <CAHJ8P3+Z+LEJysum4ZLO0HGkdYP_JDUfWoTfBiLPcDuHFeBNRw@mail.gmail.com>
Subject: Re: [f2fs-dev] [PATCH v2 1/2] f2fs: add a proc entry show inject stats
To: Chao Yu <chao@kernel.org>
Cc: jaegeuk@kernel.org, linux-kernel@vger.kernel.org, 
	linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Chao Yu via Linux-f2fs-devel <linux-f2fs-devel@lists.sourceforge.net>
=E4=BA=8E2025=E5=B9=B43=E6=9C=8820=E6=97=A5=E5=91=A8=E5=9B=9B 10:27=E5=86=
=99=E9=81=93=EF=BC=9A
>
> This patch adds a proc entry named inject_stats to show total injected
> count for each fault type.
>
> cat /proc/fs/f2fs/<dev>/inject_stats
> fault_type              injected_count
> kmalloc                 0
> kvmalloc                0
> page alloc              0
> page get                0
> alloc bio(obsolete)     0
> alloc nid               0
> orphan                  0
> no more block           0
> too big dir depth       0
> evict_inode fail        0
> truncate fail           0
> read IO error           0
> checkpoint error        0
> discard error           0
> write IO error          0
> slab alloc              0
> dquot initialize        0
> lock_op                 0
> invalid blkaddr         0
> inconsistent blkaddr    0
> no free segment         0
> inconsistent footer     0
>
> Signed-off-by: Chao Yu <chao@kernel.org>

Reviewed-by: Zhiguo Niu <zhiguo.niu@unisoc.com>
thanks=EF=BC=81

> ---
> v2:
> - add missing CONFIG_F2FS_FAULT_INJECTION
>  fs/f2fs/f2fs.h  |  3 +++
>  fs/f2fs/super.c |  1 +
>  fs/f2fs/sysfs.c | 22 ++++++++++++++++++++++
>  3 files changed, 26 insertions(+)
>
> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> index f1576dc6ec67..986ee5b9326d 100644
> --- a/fs/f2fs/f2fs.h
> +++ b/fs/f2fs/f2fs.h
> @@ -73,6 +73,8 @@ struct f2fs_fault_info {
>         atomic_t inject_ops;
>         int inject_rate;
>         unsigned int inject_type;
> +       /* Used to account total count of injection for each type */
> +       unsigned int inject_count[FAULT_MAX];
>  };
>
>  extern const char *f2fs_fault_name[FAULT_MAX];
> @@ -1902,6 +1904,7 @@ static inline bool __time_to_inject(struct f2fs_sb_=
info *sbi, int type,
>         atomic_inc(&ffi->inject_ops);
>         if (atomic_read(&ffi->inject_ops) >=3D ffi->inject_rate) {
>                 atomic_set(&ffi->inject_ops, 0);
> +               ffi->inject_count[type]++;
>                 f2fs_info_ratelimited(sbi, "inject %s in %s of %pS",
>                                 f2fs_fault_name[type], func, parent_func)=
;
>                 return true;
> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
> index f087b2b71c89..dfe0604ab558 100644
> --- a/fs/f2fs/super.c
> +++ b/fs/f2fs/super.c
> @@ -47,6 +47,7 @@ const char *f2fs_fault_name[FAULT_MAX] =3D {
>         [FAULT_KVMALLOC]                =3D "kvmalloc",
>         [FAULT_PAGE_ALLOC]              =3D "page alloc",
>         [FAULT_PAGE_GET]                =3D "page get",
> +       [FAULT_ALLOC_BIO]               =3D "alloc bio(obsolete)",
>         [FAULT_ALLOC_NID]               =3D "alloc nid",
>         [FAULT_ORPHAN]                  =3D "orphan",
>         [FAULT_BLOCK]                   =3D "no more block",
> diff --git a/fs/f2fs/sysfs.c b/fs/f2fs/sysfs.c
> index c69161366467..46fa94db08a8 100644
> --- a/fs/f2fs/sysfs.c
> +++ b/fs/f2fs/sysfs.c
> @@ -1679,6 +1679,24 @@ static int __maybe_unused disk_map_seq_show(struct=
 seq_file *seq,
>         return 0;
>  }
>
> +#ifdef CONFIG_F2FS_FAULT_INJECTION
> +static int __maybe_unused inject_stats_seq_show(struct seq_file *seq,
> +                                               void *offset)
> +{
> +       struct super_block *sb =3D seq->private;
> +       struct f2fs_sb_info *sbi =3D F2FS_SB(sb);
> +       struct f2fs_fault_info *ffi =3D &F2FS_OPTION(sbi).fault_info;
> +       int i;
> +
> +       seq_puts(seq, "fault_type               injected_count\n");
> +
> +       for (i =3D 0; i < FAULT_MAX; i++)
> +               seq_printf(seq, "%-24s%-10u\n", f2fs_fault_name[i],
> +                                               ffi->inject_count[i]);
> +       return 0;
> +}
> +#endif
> +
>  int __init f2fs_init_sysfs(void)
>  {
>         int ret;
> @@ -1770,6 +1788,10 @@ int f2fs_register_sysfs(struct f2fs_sb_info *sbi)
>                                 discard_plist_seq_show, sb);
>         proc_create_single_data("disk_map", 0444, sbi->s_proc,
>                                 disk_map_seq_show, sb);
> +#ifdef CONFIG_F2FS_FAULT_INJECTION
> +       proc_create_single_data("inject_stats", 0444, sbi->s_proc,
> +                               inject_stats_seq_show, sb);
> +#endif
>         return 0;
>  put_feature_list_kobj:
>         kobject_put(&sbi->s_feature_list_kobj);
> --
> 2.48.1
>
>
>
> _______________________________________________
> Linux-f2fs-devel mailing list
> Linux-f2fs-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

