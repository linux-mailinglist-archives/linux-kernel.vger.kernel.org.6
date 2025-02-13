Return-Path: <linux-kernel+bounces-513736-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 213F8A34E00
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 19:49:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C7CAA16CC78
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 18:49:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C726024292D;
	Thu, 13 Feb 2025 18:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hSFh9gW3"
Received: from mail-vs1-f46.google.com (mail-vs1-f46.google.com [209.85.217.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 746A424293A
	for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 18:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739472547; cv=none; b=XO7hZiiz/ipU+AG58m/T5e8nyCbtaui0cWRqZampEvKZsHBRlpHj2P698++IEzhiZEgu77RAn/IdfQkPf9M/Grme1msns/lTjQnZKF2pAw4AOuohzzSZl9YEGuRUYRggGckDjf/8yscrp44REg4ncnt1zbO7HnS3MaoEKvU8bzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739472547; c=relaxed/simple;
	bh=VdCq+xtDMHL7BRy1o/OIDvxdZ3slqVLstb8+HrIaAhQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=f/i9MXxq20rh57l4U7KBK5y2smWjQJdpvMaV1vjuVeC2Rt07hNljhquAnLT2HFHCx/E+npzO2+uqlUadRV5w/cRjEVfZQUDOVb68kA+kfEvZrv7qguLVbv2mMdCjqt1wrTK8mu/IkgoJf3ejq1V8QY1jL9gv6lnP2mEU63dX3XM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hSFh9gW3; arc=none smtp.client-ip=209.85.217.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f46.google.com with SMTP id ada2fe7eead31-4bbf29bb21eso228371137.1
        for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 10:49:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739472544; x=1740077344; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v7boHwExjmVAJE837TzvXWkShByi/UK+LGMj8HpqhPk=;
        b=hSFh9gW3/SPJ169bUhzjtXejI7Fc4grOyHsmsq6XTSzTqLPRgsNi24MzarM5WlQpnQ
         8YLerSCtqvdz9xEYVri7GaHnsqukr2bkAFvIJaEYbybogkVHrmGxJ7wUnTHxtsMNcTT+
         eYuraQMeCdLdOsa2PhkRC61jqTtA8eZQbblSYkvuHMO+bVMtYRB7tOaPWAktcN0M1uHl
         0xy7ZfB60ih02KFenLJhIuN22Jte9rrXuEpbTYdNtH+v/v7E0jlbZbBso9y7a1ogvUoR
         NVwRWPaeXA3Ix+/8Zos0YcRy129cYoLIUfhYsx7QTh1nm9p31a1GJd4/vZ4sJhx8WU0V
         u7Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739472544; x=1740077344;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v7boHwExjmVAJE837TzvXWkShByi/UK+LGMj8HpqhPk=;
        b=fFUY19Q8rWyzCqEkK6Q67kqPxtMc4TA87E7kdo7jVC46jdTxhsU7JNUVFCpLN6o8vm
         csvgduzooBEDvJmRy2NyvkiBaa8krwssHhV/SA7totaT1aAohnKcmz24sqRr81U1wVFw
         qvrxsEiN63vQBJyNtrZErSBwND+9xCCGQ6wAaYADKof6VphTOwSQYFuTEf3fsRiOGhGj
         PHwHSYgnsmyNQKnc+7lSPY14q9FDn2EbtN+6DHxAkDEvvqHeS7xuWgHQKDvfMjjkWAOo
         b9TV7coxH2hZkJ3IEIQkUlAg79pgcpZ6NizJiQ/QtC3TeIyJ3Sww1eaz8oiYOvSuJRI5
         VNzg==
X-Forwarded-Encrypted: i=1; AJvYcCX2ABWyLgPuZvFOD0NAJo2JJPsWJCo7fFa9c92G8j0toLNCfo0z9/DtctEtvwqwrBX+RggZQxQlhM75Lho=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6G9Wu3us2WavJi9OaK4KeVyoMD0VaE5o2OHL81XwxIDW4J1uT
	U4rztPd9QwqV/cRhDPqJpC1XG5nPMLNW0hvnwBund6e8aCNz1183Yq6ArRZoIPXOIGhWKZ8M2Dj
	tIk2qbFmbHk8O6Qg/L3Jt8dfnQTQ=
X-Gm-Gg: ASbGncvFWiVg40ZMN/6udfHZEgpGl76B7MHmIfD0OBAJwMlZijX0XXH09Z3lKZKYJHO
	cmTW69/PwASENQc3QbusrAKPF98mUX8irT2MGq7YqHLOV3m3fe2BYsTDANhaAVQG/clyygZrlby
	sOMN9nsrqd6IGdf/N+eFbNhslaJig=
X-Google-Smtp-Source: AGHT+IHllIcsi3aUC71hMwNeu2lRyCQ1wpzzesNNV0/+8zMd7QG5KBTum2gcYayGUUMFrUY2gmN2IeXSdsWtezGirbY=
X-Received: by 2002:a05:6102:4427:b0:4bb:ce42:40e3 with SMTP id
 ada2fe7eead31-4bc0374ab00mr4727166137.17.1739472544182; Thu, 13 Feb 2025
 10:49:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250208135414.417-1-yohan.joung@sk.com>
In-Reply-To: <20250208135414.417-1-yohan.joung@sk.com>
From: Daeho Jeong <daeho43@gmail.com>
Date: Thu, 13 Feb 2025 10:48:52 -0800
X-Gm-Features: AWEUYZlxYmvOwQTFXp17eT7krbTyJ3SD0g8BbY2UrGprqoYLvaVBXGruYXqJuEo
Message-ID: <CACOAw_xqi7cy5j5FVNKJk=QLGzda+pzAmq=weHNOpiasG+zeog@mail.gmail.com>
Subject: Re: [PATCH v1] f2fs: separate discard and zone reset command from
 pend list
To: Yohan Joung <jyh429@gmail.com>
Cc: jaegeuk@kernel.org, chao@kernel.org, 
	linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, 
	Yohan Joung <yohan.joung@sk.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 8, 2025 at 5:54=E2=80=AFAM Yohan Joung <jyh429@gmail.com> wrote=
:
>
> currently, zone reset only occurs when there is urgent utilization and
> when pending blocks are reallocated. this causes performance
> degradation, so we are modifying it to allow pending reset zones to be
> issued.
>
> Signed-off-by: Yohan Joung <yohan.joung@sk.com>
> ---
>  fs/f2fs/f2fs.h    |  3 ++-
>  fs/f2fs/segment.c | 21 +++++++++++++++------
>  2 files changed, 17 insertions(+), 7 deletions(-)
>
> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> index 1afa7be16e7d..09a7e13c0d00 100644
> --- a/fs/f2fs/f2fs.h
> +++ b/fs/f2fs/f2fs.h
> @@ -349,6 +349,7 @@ struct discard_entry {
>
>  /* max discard pend list number */
>  #define MAX_PLIST_NUM          512
> +#define ZONE_PLIST_NUM         1
>  #define plist_idx(blk_num)     ((blk_num) >=3D MAX_PLIST_NUM ?          =
 \
>                                         (MAX_PLIST_NUM - 1) : ((blk_num) =
- 1))
>
> @@ -410,7 +411,7 @@ struct discard_policy {
>  struct discard_cmd_control {
>         struct task_struct *f2fs_issue_discard; /* discard thread */
>         struct list_head entry_list;            /* 4KB discard entry list=
 */
> -       struct list_head pend_list[MAX_PLIST_NUM];/* store pending entrie=
s */
> +       struct list_head pend_list[MAX_PLIST_NUM + ZONE_PLIST_NUM];/* sto=
re pending entries */
>         struct list_head wait_list;             /* store on-flushing entr=
ies */
>         struct list_head fstrim_list;           /* in-flight discard from=
 fstrim */
>         wait_queue_head_t discard_wait_queue;   /* waiting queue for wake=
-up */
> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
> index c282e8a0a2ec..1c32252db525 100644
> --- a/fs/f2fs/segment.c
> +++ b/fs/f2fs/segment.c
> @@ -962,7 +962,10 @@ static struct discard_cmd *__create_discard_cmd(stru=
ct f2fs_sb_info *sbi,
>
>         f2fs_bug_on(sbi, !len);
>
> -       pend_list =3D &dcc->pend_list[plist_idx(len)];
> +       if (f2fs_sb_has_blkzoned(sbi) && bdev_is_zoned(bdev))
> +               pend_list =3D &dcc->pend_list[MAX_PLIST_NUM];
> +       else
> +               pend_list =3D &dcc->pend_list[plist_idx(len)];
>
>         dc =3D f2fs_kmem_cache_alloc(discard_cmd_slab, GFP_NOFS, true, NU=
LL);
>         INIT_LIST_HEAD(&dc->list);
> @@ -1649,6 +1652,8 @@ static int __issue_discard_cmd(struct f2fs_sb_info =
*sbi,
>         struct discard_cmd *dc, *tmp;
>         struct blk_plug plug;
>         int i, issued;
> +       int plist_num =3D f2fs_sb_has_blkzoned(sbi) ?
> +               MAX_PLIST_NUM + ZONE_PLIST_NUM : MAX_PLIST_NUM;
>         bool io_interrupted =3D false;
>
>         if (dpolicy->timeout)
> @@ -1656,12 +1661,12 @@ static int __issue_discard_cmd(struct f2fs_sb_inf=
o *sbi,
>
>  retry:
>         issued =3D 0;
> -       for (i =3D MAX_PLIST_NUM - 1; i >=3D 0; i--) {
> +       for (i =3D plist_num - 1; i >=3D 0; i--) {
>                 if (dpolicy->timeout &&
>                                 f2fs_time_over(sbi, UMOUNT_DISCARD_TIMEOU=
T))
>                         break;
>
> -               if (i + 1 < dpolicy->granularity)
> +               if (i + 1 < dpolicy->granularity && i + 1 !=3D plist_num)

To me, this part is kind of a hack, since it just skips checking
granularity for the largest pending list.
It might not work for conventional devices. The fundamental problem is
the current pend_list doesn't
work with zoned devices now. So, I think we need a new design covering
zoned devices for discard
such as using another discard pending list for zoned devices and
controlling it in a different way.
Thanks for letting me know about this issue. I will come up with a new
discard design for zoned devices.

>                         break;
>
>                 if (i + 1 < dcc->max_ordered_discard && dpolicy->ordered)=
 {
> @@ -1720,6 +1725,8 @@ static bool __drop_discard_cmd(struct f2fs_sb_info =
*sbi)
>         struct list_head *pend_list;
>         struct discard_cmd *dc, *tmp;
>         int i;
> +       int plist_num =3D f2fs_sb_has_blkzoned(sbi) ?
> +               MAX_PLIST_NUM + ZONE_PLIST_NUM : MAX_PLIST_NUM;
>         bool dropped =3D false;
>
>         mutex_lock(&dcc->cmd_lock);
> @@ -2305,7 +2312,7 @@ int f2fs_start_discard_thread(struct f2fs_sb_info *=
sbi)
>  static int create_discard_cmd_control(struct f2fs_sb_info *sbi)
>  {
>         struct discard_cmd_control *dcc;
> -       int err =3D 0, i;
> +       int err =3D 0, i, plist_num;
>
>         if (SM_I(sbi)->dcc_info) {
>                 dcc =3D SM_I(sbi)->dcc_info;
> @@ -2316,7 +2323,9 @@ static int create_discard_cmd_control(struct f2fs_s=
b_info *sbi)
>         if (!dcc)
>                 return -ENOMEM;
>
> -       dcc->discard_io_aware_gran =3D MAX_PLIST_NUM;
> +       plist_num =3D f2fs_sb_has_blkzoned(sbi) ?
> +               MAX_PLIST_NUM + ZONE_PLIST_NUM : MAX_PLIST_NUM;
> +       dcc->discard_io_aware_gran =3D plist_num;
>         dcc->discard_granularity =3D DEFAULT_DISCARD_GRANULARITY;
>         dcc->max_ordered_discard =3D DEFAULT_MAX_ORDERED_DISCARD_GRANULAR=
ITY;
>         dcc->discard_io_aware =3D DPOLICY_IO_AWARE_ENABLE;
> @@ -2326,7 +2335,7 @@ static int create_discard_cmd_control(struct f2fs_s=
b_info *sbi)
>                 dcc->discard_granularity =3D BLKS_PER_SEC(sbi);
>
>         INIT_LIST_HEAD(&dcc->entry_list);
> -       for (i =3D 0; i < MAX_PLIST_NUM; i++)
> +       for (i =3D 0; i < plist_num; i++)
>                 INIT_LIST_HEAD(&dcc->pend_list[i]);
>         INIT_LIST_HEAD(&dcc->wait_list);
>         INIT_LIST_HEAD(&dcc->fstrim_list);
> --
> 2.25.1
>

