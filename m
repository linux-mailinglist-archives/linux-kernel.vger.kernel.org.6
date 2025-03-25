Return-Path: <linux-kernel+bounces-576263-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 57554A70CF5
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 23:34:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 917F7188DE4C
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 22:34:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3272D269CE0;
	Tue, 25 Mar 2025 22:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mJrIDTvN"
Received: from mail-ua1-f42.google.com (mail-ua1-f42.google.com [209.85.222.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF2312528FC
	for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 22:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742942053; cv=none; b=VD1hT9mbOnbXA3qb3OrbSR7OL5cRpqUbH78cewTCet4PZg8CRoCzyZPVYY0XCSX6AXrTdHcvWWiPGTr28uQe5cnYR6chFxHhkZ9z+pE3wb/3Ag/bYX3uOC4gGAvJ+fz2GaApAgjCjUSJZIw7WzlUZpVrcKo2uEERIYtvsc1Et4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742942053; c=relaxed/simple;
	bh=AnaHmUH56p6cTWzgtQ3Fygv/R0PqbacS1aE9mN7JrWw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nEgGaPbfVPWodC9bG0vLWQ7ccLVhx+9RsmaU0uC+szZNn9EkU4xRCrBI4EWuRhV7um6bvXr1VoNM36ryvN0hNVpqZo7HpyuUAWElRzeawLd91nez9QaR+ZFx3kaJ8eYHhUeBxD/Hmv8RmFItvHyvLSBX9lYA3W4MdPch5bmSDkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mJrIDTvN; arc=none smtp.client-ip=209.85.222.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f42.google.com with SMTP id a1e0cc1a2514c-86b9ea43955so2613774241.2
        for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 15:34:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742942050; x=1743546850; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uos4nIEGtskCz3kQxHDBkGDTKQCWMZ5uRqFgYPmUsx4=;
        b=mJrIDTvNX3Xn573zZmfpRgteVWs2iteGoaGd0xNOj1p11sEcNdy/TA7mGL+SrWCRUD
         b2X8+g7bU4c1nvz9As+Cqn2ByAycpsroVxx87yU10H1RDVFEDWefBcOHpvVqC/sRVoET
         eIn1aOA8TrdyOi7YTIE5lj+SoC3nkJlG6+9h975X1WItIKFSYJAGqN+7YC8DlG6XDfHH
         vYEza12tWsG3vp1DR4U6VKpkygx1FiIEsHTCgLg5EZhQawqtQhWxdwap8y1bPZrlk40Q
         DJ45V6cQ6ZyNOJOE3AMWK7ER3CjiXNakTWdKX8XhoKTSt0GCrzhoUt7CKuLrwwiCVw0h
         cV0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742942050; x=1743546850;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uos4nIEGtskCz3kQxHDBkGDTKQCWMZ5uRqFgYPmUsx4=;
        b=CBlI7nWWV7z9K0eXa7UWiUFyqVW/h2+uVYEsjuJUzD0hIqphUUjDhk36Z13TDJKUa/
         KrgapsziYcDQXcNIVr6kA+1ujzg8FL2cxKCdSMohS7N/XTjnZwklSK6wivFjGJxsfCUh
         9l7sIvTfCsx/oGBTmR6X0cjVQ1WEeVE06zzqWAdm9SiKLK9NngVphCrHxg17AsGmYjZH
         IIYWsTTaM6lKLUKmgKIHA/7AP4VH0vTqNCLMc/7MCRuXX4R9WaCoogsZqxX2Sh3j3HiU
         lPggAE7yBH+LvJMmV17ok1Kcl83aVhYZ8mcf5EkY6aoBJIMOjZHWgHtECiAkVDbIRuid
         yyPg==
X-Forwarded-Encrypted: i=1; AJvYcCUYI+vEg2ulqdpo0ZEm+3WgqYfPEzvKj3B5FBWbgtFKUl+dcjHYapkAlzupoQoU32MdVFrlJUuIMA/I57Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0hyKC8SJ//bX6Y/ooCsu+qr/1mZWbTVYDzwPlEA7vTlLvbLxy
	Rarky8ikOI4fRuHlRZcixbiIwH30VCC0NgoUojjItNlArgtBUN9mVjvt82oeZjFZfym4ef88UEH
	g+ctPr2gIWy+qVpo6ps8BHxZV0SHGEFtrv0M=
X-Gm-Gg: ASbGnct39dWz33PTD2a8O/BB5WGAkIFKKN7ZWQ1lSEpmzxJ1wSadSlmn91lcgdRfDB0
	kHaefhssJ01Dh67V+VNxvhJx/POh5o3gtAxQ7VWbJrFTC92kAqy/dfNNC0F5Ky6DRlhiU7HtPEY
	SvrDJpLhWPi+m51CKQvVeBaza9Q1vVCOcRRuSS/1GsYGCRtVaXVQJhrYyc
X-Google-Smtp-Source: AGHT+IEZEfp0IC0V1HCPvxajk9/zFfT2FEvemSSUeEzas4JC8+lyDOdIkFJMziNTBvhAu/U33Ngy5eRo5qyZwG4meYc=
X-Received: by 2002:a05:6102:358c:b0:4ba:971a:41fd with SMTP id
 ada2fe7eead31-4c50d626786mr15442298137.19.1742942050371; Tue, 25 Mar 2025
 15:34:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250325080646.3291947-1-chao@kernel.org>
In-Reply-To: <20250325080646.3291947-1-chao@kernel.org>
From: Daeho Jeong <daeho43@gmail.com>
Date: Tue, 25 Mar 2025 15:33:59 -0700
X-Gm-Features: AQ5f1JqgLFr6hrR_b21OMLQFPCtalcWZu0uy8F3y1Tn6V7X3QEqCyY1gLLihExU
Message-ID: <CACOAw_wH6E1tU9KGBjyBxLGzZSFMDeU=49hVs=cEqehdqKoF0Q@mail.gmail.com>
Subject: Re: [f2fs-dev] [PATCH v2 1/2] f2fs: zone: fix to calculate
 first_zoned_segno correctly
To: Chao Yu <chao@kernel.org>
Cc: jaegeuk@kernel.org, Daeho Jeong <daehojeong@google.com>, linux-kernel@vger.kernel.org, 
	linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 25, 2025 at 1:09=E2=80=AFAM Chao Yu via Linux-f2fs-devel
<linux-f2fs-devel@lists.sourceforge.net> wrote:
>
> A zoned device can has both conventional zones and sequential zones,
> so we should not treat first segment of zoned device as first_zoned_segno=
,
> instead, we need to check zone type for each zone during traversing zoned
> device to find first_zoned_segno.
>
> Otherwise, for below case, first_zoned_segno will be 0, which could be
> wrong.
>
> create_null_blk 512 2 1024 1024
> mkfs.f2fs -m /dev/nullb0
>
> Fixes: 9703d69d9d15 ("f2fs: support file pinning for zoned devices")
> Cc: Daeho Jeong <daehojeong@google.com>
> Signed-off-by: Chao Yu <chao@kernel.org>
> ---
> v2:
> - traverse w/ zone unit in get_first_zoned_segno()
>  fs/f2fs/f2fs.h    | 18 +++++++++++++-----
>  fs/f2fs/segment.c |  2 +-
>  fs/f2fs/super.c   | 37 +++++++++++++++++++++++++++++++++----
>  3 files changed, 47 insertions(+), 10 deletions(-)
>
> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> index ca884e39a5ff..3dea037faa55 100644
> --- a/fs/f2fs/f2fs.h
> +++ b/fs/f2fs/f2fs.h
> @@ -4630,12 +4630,16 @@ F2FS_FEATURE_FUNCS(readonly, RO);
>  F2FS_FEATURE_FUNCS(device_alias, DEVICE_ALIAS);
>
>  #ifdef CONFIG_BLK_DEV_ZONED
> -static inline bool f2fs_blkz_is_seq(struct f2fs_sb_info *sbi, int devi,
> -                                   block_t blkaddr)
> +static inline bool f2fs_zone_is_seq(struct f2fs_sb_info *sbi, int devi,
> +                                                       unsigned int zone=
)
>  {
> -       unsigned int zno =3D blkaddr / sbi->blocks_per_blkz;
> +       return test_bit(zone, FDEV(devi).blkz_seq);
> +}
>
> -       return test_bit(zno, FDEV(devi).blkz_seq);
> +static inline bool f2fs_blkz_is_seq(struct f2fs_sb_info *sbi, int devi,
> +                                                               block_t b=
lkaddr)
> +{
> +       return f2fs_zone_is_seq(sbi, devi, blkaddr / sbi->blocks_per_blkz=
);
>  }
>  #endif
>
> @@ -4711,9 +4715,13 @@ static inline bool f2fs_valid_pinned_area(struct f=
2fs_sb_info *sbi,
>                                           block_t blkaddr)
>  {
>         if (f2fs_sb_has_blkzoned(sbi)) {
> +#ifdef CONFIG_BLK_DEV_ZONED
>                 int devi =3D f2fs_target_device_index(sbi, blkaddr);
>
> -               return !bdev_is_zoned(FDEV(devi).bdev);
> +               return !f2fs_blkz_is_seq(sbi, devi, blkaddr);
> +#else
> +               return true;
> +#endif
>         }
>         return true;
>  }
> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
> index 396ef71f41e3..dc360b4b0569 100644
> --- a/fs/f2fs/segment.c
> +++ b/fs/f2fs/segment.c
> @@ -3311,7 +3311,7 @@ int f2fs_allocate_pinning_section(struct f2fs_sb_in=
fo *sbi)
>
>         if (f2fs_sb_has_blkzoned(sbi) && err =3D=3D -EAGAIN && gc_require=
d) {
>                 f2fs_down_write(&sbi->gc_lock);
> -               err =3D f2fs_gc_range(sbi, 0, GET_SEGNO(sbi, FDEV(0).end_=
blk),
> +               err =3D f2fs_gc_range(sbi, 0, sbi->first_zoned_segno - 1,
>                                 true, ZONED_PIN_SEC_REQUIRED_COUNT);
>                 f2fs_up_write(&sbi->gc_lock);
>
> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
> index 011925ee54f8..9a42a1323f42 100644
> --- a/fs/f2fs/super.c
> +++ b/fs/f2fs/super.c
> @@ -4307,12 +4307,33 @@ static void f2fs_record_error_work(struct work_st=
ruct *work)
>
>  static inline unsigned int get_first_zoned_segno(struct f2fs_sb_info *sb=
i)
>  {
> +#ifdef CONFIG_BLK_DEV_ZONED
> +       unsigned int zoneno, total_zones;
>         int devi;
>
> -       for (devi =3D 0; devi < sbi->s_ndevs; devi++)
> -               if (bdev_is_zoned(FDEV(devi).bdev))
> -                       return GET_SEGNO(sbi, FDEV(devi).start_blk);
> -       return 0;
> +       if (!f2fs_sb_has_blkzoned(sbi))
> +               return NULL_SEGNO;
> +
> +       for (devi =3D 0; devi < sbi->s_ndevs; devi++) {
> +               if (!bdev_is_zoned(FDEV(devi).bdev))
> +                       continue;
> +
> +               total_zones =3D GET_ZONE_FROM_SEG(sbi, FDEV(devi).total_s=
egments);
> +
> +               for (zoneno =3D 0; zoneno < total_zones; zoneno++) {
> +                       unsigned int segs, blks;
> +
> +                       if (!f2fs_zone_is_seq(sbi, devi, zoneno))
> +                               continue;
> +
> +                       segs =3D GET_SEG_FROM_SEC(sbi,
> +                                       zoneno * sbi->secs_per_zone);
> +                       blks =3D SEGS_TO_BLKS(sbi, segs);
> +                       return GET_SEGNO(sbi, FDEV(devi).start_blk + blks=
);
> +               }
> +       }
> +#endif
> +       return NULL_SEGNO;
>  }
>
>  static int f2fs_scan_devices(struct f2fs_sb_info *sbi)
> @@ -4349,6 +4370,14 @@ static int f2fs_scan_devices(struct f2fs_sb_info *=
sbi)
>  #endif
>
>         for (i =3D 0; i < max_devices; i++) {
> +               if (max_devices =3D=3D 1) {
> +                       FDEV(i).total_segments =3D
> +                               le32_to_cpu(raw_super->segment_count_main=
);
> +                       FDEV(i).start_blk =3D 0;
> +                       FDEV(i).end_blk =3D FDEV(i).total_segments *
> +                                               BLKS_PER_SEG(sbi);
> +               }
> +
>                 if (i =3D=3D 0)
>                         FDEV(0).bdev_file =3D sbi->sb->s_bdev_file;
>                 else if (!RDEV(i).path[0])
> --
> 2.48.1
>

Reviewed-by: Daeho Jeong <daehojeong@google.com>

Thanks.

>
>
> _______________________________________________
> Linux-f2fs-devel mailing list
> Linux-f2fs-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

