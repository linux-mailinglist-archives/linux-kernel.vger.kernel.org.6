Return-Path: <linux-kernel+bounces-569017-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A37F7A69D73
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 02:17:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F3DA6461A94
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 01:17:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEF0040BF5;
	Thu, 20 Mar 2025 01:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NF10Kr6u"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F9A3BA34
	for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 01:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742433432; cv=none; b=oAvIVzMrI6kjp0wiNcqBPwlibEIZ8W3mR/NvxCtccIgDoef00SuGZifwSRTupCi6mZn5yFe7RtLpzOzzKbIuvPjiv16fQxlz9NvmUzp5BeWCj90r4sRiV96K89Gr9K7BGxiO3viA4G2Y0mAX+V9iMFFWKTlBMuoT0I/Oc9EjxEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742433432; c=relaxed/simple;
	bh=5fxCjtzDzc8ZNX0CIXQFCgMeaWwboGRZcgCXZXXabPk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Htflp4zOz/m23/aG4ptrMI4ADzgG5pis7EoHZJeAw9aJdZvwxquYTDex3RRLpdwXSABUjghQJ2SsCsXmBsYZnTfMghFu+rNtS/v4NmbSUU4Q7Mgk01Wf8yx+CiQklNdsvmhXj/Dd0Tr9/3EXRYDa7M8p7TiiraHaqfspfKdqlyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NF10Kr6u; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-43ce4e47a85so391465e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 18:17:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742433429; x=1743038229; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t2ciTx/RStUSAwUHNKtF40zJRK3MDGYwf16stoJ3Vjk=;
        b=NF10Kr6uFCP08hgUxDnlSK1VWDGTMgH+4WWh3eO4WFkN783MI8/khYzHhW8lE78HmC
         CGh4V6T5e0upBZWVUxqkjfDdWPf3bqQwuw8LKspsrXxGGBmHJTYV6UAcPMms8VziMXZr
         ZuoGPVG5So6ingh5n1dkY7yww1zgY8iHu1dfHb41AnMerKHfWWRw0+5l+PfZYiAkJMK9
         IlbUty21G50FBw2ugtLxrYlYthXyMnDtW795RJqHRAK8QrIeZ0jkDveHZrH7Z7jzRRMX
         3OmFQCC28bpB6XFJJF0zKCdcDPZxK6t6Ie9dMLP2RGA84et2jgzyGLaxhvGzbMFKfY0j
         iEig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742433429; x=1743038229;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t2ciTx/RStUSAwUHNKtF40zJRK3MDGYwf16stoJ3Vjk=;
        b=M8sU17hCwsYL0VDkZMAavcyqnmxyWKy5+9QFXn9xws9QVVsqD/goBznMXgSAWAVyhr
         Q+G/C02V7bOarf3ZOavkn0R4UeZSjEH/02PgmrB22KJ8nj9IlHmXp5T65STdfuto4y56
         fK3BED8ifF6edZa7dhSAN517HHLF1R9b7w313iMX9RYD/PjSR7dDVEZGBiYJz/I4CGMb
         MJGyTKj742lC7yFwQSK2voYihNqx7kjGxxnP1VHjce8spIzW7XPRAfr0nZ2WRErY0EWI
         wk8AKhhC252ZFCffulNOtRYVL6fVKXFA26/3ug6WYloiKvwZtFwE0PMt2/sD0lbBqFzj
         JPyA==
X-Forwarded-Encrypted: i=1; AJvYcCX9z01cSl58wbOlly6tiviTbAuSfzE4L3YY1xG2aCxNudbxGkt+im52jpMWi4qma/goacK2z9WMRukCNWM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz33t5KzfIKIx2sB5KAz8zU9Rsmza7naCapDU7Ze3erACjV6snC
	puvALgedjbLdCGDkP/z1JeWIYuBFj9Yxgq1dVIXarPSvNMh8xXmgnayZv3agtgmEeloSikQhVZh
	W8ZINgfjfefeCONSb1BJbbhHz7JN4F+iy
X-Gm-Gg: ASbGncscYNjjSjxPkj/8kQAVypnAokKUjImaQdjnDyemGbHs0ZJe+4gQivj/tHrWc5C
	ojgVuueiQnAcjK5oeI+3jnZEBn93ymv/FHVMQDx0GKI4smjN+HLsXQdlvnflSGL+Bp2ydHO86oc
	nY5ion4b9kI9xWI0se0S1abeDL2Pw=
X-Google-Smtp-Source: AGHT+IGVtPfULjMYZGuEEitdKMGCad7UyVTG2LiHkEgkXErUP14Awh5JH40VYA/sp8jzVa2FISJDp04AXzI8BQS/IvM=
X-Received: by 2002:a05:6000:2a6:b0:394:d0c3:da7a with SMTP id
 ffacd0b85a97d-399739bb3bdmr1601062f8f.3.1742433428394; Wed, 19 Mar 2025
 18:17:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250319120046.1784103-1-chao@kernel.org>
In-Reply-To: <20250319120046.1784103-1-chao@kernel.org>
From: Zhiguo Niu <niuzhiguo84@gmail.com>
Date: Thu, 20 Mar 2025 09:16:57 +0800
X-Gm-Features: AQ5f1Jp1f4g_5y7rwVIA-U4VMXsmenZe6hLkE_1y75af-IvWTFWuOz61yNyIfVw
Message-ID: <CAHJ8P3LPtYsOH9yQzk4ozXT_=ufzSBe+FtzymH4TaNdavcF6jw@mail.gmail.com>
Subject: Re: [f2fs-dev] [PATCH 1/2] f2fs: add a proc entry show inject stats
To: Chao Yu <chao@kernel.org>
Cc: jaegeuk@kernel.org, linux-kernel@vger.kernel.org, 
	linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Chao Yu via Linux-f2fs-devel <linux-f2fs-devel@lists.sourceforge.net>
=E4=BA=8E2025=E5=B9=B43=E6=9C=8819=E6=97=A5=E5=91=A8=E4=B8=89 23:38=E5=86=
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
> ---
>  fs/f2fs/f2fs.h  |  3 +++
>  fs/f2fs/super.c |  1 +
>  fs/f2fs/sysfs.c | 18 ++++++++++++++++++
>  3 files changed, 22 insertions(+)
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
> index c69161366467..e87e89d2c023 100644
> --- a/fs/f2fs/sysfs.c
> +++ b/fs/f2fs/sysfs.c
> @@ -1679,6 +1679,22 @@ static int __maybe_unused disk_map_seq_show(struct=
 seq_file *seq,
>         return 0;
>  }
>
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
> +
Hi Chao,
Here should we need to use #ifdef CONFIG_F2FS_FAULT_INJECTION to avoid
build error when
CONFIG_F2FS_FAULT_INJECTION is not enabled?
thanks=EF=BC=81
>  int __init f2fs_init_sysfs(void)
>  {
>         int ret;
> @@ -1770,6 +1786,8 @@ int f2fs_register_sysfs(struct f2fs_sb_info *sbi)
>                                 discard_plist_seq_show, sb);
>         proc_create_single_data("disk_map", 0444, sbi->s_proc,
>                                 disk_map_seq_show, sb);
> +       proc_create_single_data("inject_stats", 0444, sbi->s_proc,
> +                               inject_stats_seq_show, sb);
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

