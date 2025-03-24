Return-Path: <linux-kernel+bounces-574373-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EC259A6E4A3
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 21:49:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D3F7A18891D7
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 20:49:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C40A1D6187;
	Mon, 24 Mar 2025 20:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dg5ph7zc"
Received: from mail-ua1-f45.google.com (mail-ua1-f45.google.com [209.85.222.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CBCD17E0
	for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 20:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742849375; cv=none; b=Lsd4+zcX/1Tvmi21c4twANBB8J5A+BjcoREHaBloJrymzPvIOzfSFDT6mBsQNAxvHCa7cZxKFnJNxGeVz3gikjj+8M2jvj2OdYPGhFcwAZO7UOTLDb+dnzKNp1pn1+/Pv7SZKvWlyNyBLM2F6NlPuww2UafvHVBwsJwfHuCQprg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742849375; c=relaxed/simple;
	bh=nJ3VMMClK53e5dVpasIm8nfo6P+DgJmYKMiEckiFfm8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=W7bv912tBVEW4IDCvI08CsAMJCg7lms8WNKj6faFF0kGfusaY8gIqNgHfHH8iEfVIv3NrwZ8ZoZCj+AvOEqgY8vj9eZExhF1WGhuj/hFWRs6VSfgqy6zALIlzUSCrZb61GuIucF5G1xqxkHR4pfCjqNoKuKkB55e0zhM0GsTUGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dg5ph7zc; arc=none smtp.client-ip=209.85.222.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f45.google.com with SMTP id a1e0cc1a2514c-86b9b1def28so4625223241.3
        for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 13:49:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742849373; x=1743454173; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xb1EcGN+DLdFqVyhIa6MKr7XqlCZ1puGiDPvwPhj3EA=;
        b=dg5ph7zc4q3oXt0XiMV+VMXCc5+kXdDi+yjJwnwd0tXj3y1I4dOi5TuITtzQg537Bg
         AUDBSe9LsVxmYP9S9knngdSMoDSOKOdR9aQo01szr0dDotUJz/FjZ2HKwbOgYlWFkhtc
         xi73EU73ew+QeBMmGwbUR6DLEZQeX8SBATysCF+U4Mn7M5J33NC8kQMSrhli8UwIkIOw
         9qmLuOYGX8pL+KmhbZXE051mbmCLAu5VThVod/K3IWRkDWm9X00Vsszk2djLI3LWtZXU
         +0vvhN6J13o1nitcJBcrxV1qEOipj7tm5o+bues/a4mO8TEUgiEjfKBMc7Tcdvrb3z7p
         5QuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742849373; x=1743454173;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Xb1EcGN+DLdFqVyhIa6MKr7XqlCZ1puGiDPvwPhj3EA=;
        b=TbwB0ARq25GgM71Mt1v7NGtxosDtHZNbCkXI5Sg7kUrqOA4hrnb6n0MfJpGRVNpOEe
         4iIlaqqmvqoiaAw//o4mhhbpIJhDAnXFsUsKC4/H1aupD/s/RYWlB7IsliBGhiRfgciK
         eLCT6h0Hkz7vc66R4Gj3D4FQ4PdHPSl8d1/gKSMwZwWBvnpJNJnXQwoGrdWc2zSc2VT9
         aV/1sUMEJKWEAyX+zLiNWRp8wc05BNDlpCyxi3jQNMZMb3YTxSIpecNe1dtLTYEiUpBT
         DxFQhDaLAHPOI7LGofAP/DK06US1y29/JOggzZsgA1FjpeID1u9bVqXQoRRnaJIHeiox
         R7RA==
X-Forwarded-Encrypted: i=1; AJvYcCXtD0v+pTPaT4wsHRwOatY4MtIO+n/gyaTi91rHmsFMWEQvEayzPQWWnqsXvEqR5lRWIrbGP6wbGMHjWPQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw58/+7k9uii8aXqRYE9wiyGEpS/uCWh5DuIl+4AX7gWYbpncZo
	vS6VVluogE35OdVgfvoqTEIGTTS0ZuWHXRr+Q4V/8KNIQXy+XSwX9ryNYl2zRdPtM1UoTznzl3L
	DRyAVdA/HrploY1BjWGQPyU8oOHw=
X-Gm-Gg: ASbGnctOSOJphoQgyBEuFeH2b8JfT1HDcXLdMRXX09XjUOTDPcyMwKA44uMacbXeOPf
	9Q0K70xedgcoZZSzWcg+3v4J/bBJbYEDKIdsb/tsuYJ+pYKUtuCqcD2+iqzImGe7lzYX7y1Pz+Z
	+6tpegAUwG8zqUzx3Lu8yA5sC2G3j1qeqcj0FQBeMhTPxbo8NqCDyoeX6SaKg=
X-Google-Smtp-Source: AGHT+IFYQ+znrERpUK/T2yZcjOgHwC0eeQV21cqyzOJ6TxJ8aQHzm3tW40+u9aH3j036JC0dMADHtPUzcsF4Ywqp65Y=
X-Received: by 2002:a05:6102:2ac7:b0:4bb:cbbc:38 with SMTP id
 ada2fe7eead31-4c50d47bb1amr10510750137.5.1742849372565; Mon, 24 Mar 2025
 13:49:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250324114935.3087821-1-chao@kernel.org>
In-Reply-To: <20250324114935.3087821-1-chao@kernel.org>
From: Daeho Jeong <daeho43@gmail.com>
Date: Mon, 24 Mar 2025 13:49:21 -0700
X-Gm-Features: AQ5f1JrmUa_GWVxdHKrgfz3iluAHNC70SVuKD8rE7iWmikL7TRxcoM4t5WcKpLg
Message-ID: <CACOAw_zQ1+yMknJ76B+H2-N=BfY4a85Yjwicip5UTQu9GLZQdA@mail.gmail.com>
Subject: Re: [f2fs-dev] [PATCH 1/2] f2fs: zone: fix to calculate
 first_zoned_segno correctly
To: Chao Yu <chao@kernel.org>
Cc: jaegeuk@kernel.org, Daeho Jeong <daehojeong@google.com>, linux-kernel@vger.kernel.org, 
	linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 24, 2025 at 4:54=E2=80=AFAM Chao Yu via Linux-f2fs-devel
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
>  fs/f2fs/f2fs.h    | 18 +++++++++++++-----
>  fs/f2fs/segment.c |  2 +-
>  fs/f2fs/super.c   | 32 +++++++++++++++++++++++++++-----
>  3 files changed, 41 insertions(+), 11 deletions(-)
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
> index 011925ee54f8..b2342366020a 100644
> --- a/fs/f2fs/super.c
> +++ b/fs/f2fs/super.c
> @@ -4307,12 +4307,26 @@ static void f2fs_record_error_work(struct work_st=
ruct *work)
>
>  static inline unsigned int get_first_zoned_segno(struct f2fs_sb_info *sb=
i)
>  {
> -       int devi;
> +#ifdef CONFIG_BLK_DEV_ZONED
> +       unsigned int segno;
> +       int devi, i;
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
> +               segno =3D GET_SEGNO(sbi, FDEV(devi).start_blk);
> +               for (i =3D 0; i < FDEV(devi).total_segments; i++) {
> +                       if (f2fs_zone_is_seq(sbi, devi,
> +                               GET_ZONE_FROM_SEG(sbi, segno + i)))

Maybe we can check it with a zone unit?

> +                               return segno + i;
> +               }
> +       }
> +#endif
> +       return NULL_SEGNO;
>  }
>
>  static int f2fs_scan_devices(struct f2fs_sb_info *sbi)
> @@ -4349,6 +4363,14 @@ static int f2fs_scan_devices(struct f2fs_sb_info *=
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
>
>
> _______________________________________________
> Linux-f2fs-devel mailing list
> Linux-f2fs-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

