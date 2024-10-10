Return-Path: <linux-kernel+bounces-360045-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 204149993D7
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 22:43:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 41D521C22410
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 20:43:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 768F61E132F;
	Thu, 10 Oct 2024 20:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WY7VmlaG"
Received: from mail-ua1-f44.google.com (mail-ua1-f44.google.com [209.85.222.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D340D18C03D
	for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 20:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728592976; cv=none; b=FEFYxe4Lt0LQ1F28EquHaUMaq3Xu4h+cGXlU8iiVzEDW8QA2KewPGqLC77VS66A5eeRnAgz0zj/1esoPim43JyDRNGvxUJJruAS4+SqaheHFn/vKqOCyr92oCoKhf/yTAkX7PD3V/LzhFBC9Y16BiwOEaS0ywM422DRUyG5ncvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728592976; c=relaxed/simple;
	bh=b4RgTigo2ch0f9r2SwmvgOhGDY26RHp/VjDumLYVMQk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZHpem1GUeyBS3+CpSjSw8ySv5cD6nDSaAHciCU6S7yqdJmujJtVUOBjRzQYEtUhDpzMka9YeilvZksFIqNyVJULfgEJ6vo6V83PK+HwB1aIPH1niuG3YazF8zvHFkhciaiL8BRAVyt4aVDVEhZ+7pw4l/HkystlKEBZOvZR7Ee8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WY7VmlaG; arc=none smtp.client-ip=209.85.222.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f44.google.com with SMTP id a1e0cc1a2514c-84fd764f6ddso515700241.1
        for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 13:42:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728592973; x=1729197773; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mhHYMLd+kyEo96OgFlncBZbI6yqnYZncvQl/Df2PPIA=;
        b=WY7VmlaG97tcyuX0fGmc52wS5x557hWDwIaV6Ct1IQhNbhlwf2Crg5fU4NNN9WGwjw
         BYZW1x3IARaA4rG9r924EaT4gbCJ4/CYu8RIEW9z9fX3kcPXN4Wir1BI/cWvxccSDl9z
         E7nHl2DicIuVb4ZwL3Snxzwc+UdQF5sbEmVdWeaP+MfKp04irQPSWPiNiTsxkMvlvbqE
         SybkpF/Uj0grxqZ52ytOSe2yM9O4DBC5k5cru7b+QGnRCKMTW7duhoMWb/PpiHP1RLyY
         PihiJgMqoTFE1W+95gtUnMMuNqxi9fEdULPHOGuTZq33DzalvkBekYJheW3DsQknaWIA
         /ToQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728592973; x=1729197773;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mhHYMLd+kyEo96OgFlncBZbI6yqnYZncvQl/Df2PPIA=;
        b=UkPx5aSf1JbZqkveHbhFgHAAZ+uvChHH/qHJAcXZ2RQVe3+NXssAgQ9bGLd++ENbAi
         BrtWWkhkXBIVzd3vD0QwzihR0BP/Zv9iRh5aY9KiPdKdImfhrPd6sh1J3X0aBbDMSLmn
         DBpqPxiXV5ZBkIaB0ssn/tVfTRWwyOsQtjlXj2LSsB6WHKDUAKsiuWH4lgXBzFjoeM+1
         kqj74af8TtQfakiHMomC554ljY8sKZO9YQkufF/qwSNSQ2E17g0L+PZ1jl4d/zHs/+5O
         cZ/2VjWPxMac6JQ3BsI1K9KT0wOjlGaY+F0jFaj6Whf1f0gAPEqVRWaMosyDz6IMgHuj
         rp2Q==
X-Forwarded-Encrypted: i=1; AJvYcCUnrYSOrByNOLPZKNLW5cM8QXFoks6L/+nebdbSeSBXJREyiz6nkL+PgFcfvIhSa6SJ3q9Kq2bG9N9MzJM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyoaMbRGO02fRPpahY5elrVA+p4aCi1D/acrRJ5QBuVv0K5ffqI
	S+g2LPR9cXx3qO0GS6CH4gVoeipIGyt4zALpXw6/SB0rxQHJruanSIsmBCxGDKZDXZJblve1FWv
	IBhGbX2g+O7lyQuFr3eIbuNciaaY=
X-Google-Smtp-Source: AGHT+IFzqJVjz4nmg6OGEAWdTEArRH0gKmdQbgnki5fNwurx93jUIzCaXqYjKy9UlKPe0B8MlnYtEIy1qK5UXY8qcf4=
X-Received: by 2002:a05:6102:3f86:b0:4a3:c32a:dfbf with SMTP id
 ada2fe7eead31-4a4543cb9bfmr4441245137.9.1728592973437; Thu, 10 Oct 2024
 13:42:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CGME20240927072239epcms2p48e5ae61717652c25e1fe3c87ce53573c@epcms2p4>
 <20240927072239epcms2p48e5ae61717652c25e1fe3c87ce53573c@epcms2p4>
In-Reply-To: <20240927072239epcms2p48e5ae61717652c25e1fe3c87ce53573c@epcms2p4>
From: Daeho Jeong <daeho43@gmail.com>
Date: Thu, 10 Oct 2024 13:42:42 -0700
Message-ID: <CACOAw_x6iNOjAmm9imCM3_5O+aWT2knhxxZuCOdzmw1_5F43LQ@mail.gmail.com>
Subject: Re: [f2fs-dev] [PATCH] f2fs: support dio write for zoned storage
To: daejun7.park@samsung.com
Cc: "jaegeuk@kernel.org" <jaegeuk@kernel.org>, "chao@kernel.org" <chao@kernel.org>, 
	"linux-f2fs-devel@lists.sourceforge.net" <linux-f2fs-devel@lists.sourceforge.net>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Dongjin Kim <dongjin_.kim@samsung.com>, 
	Siwoo Jung <siu.jung@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 27, 2024 at 12:25=E2=80=AFAM Daejun Park <daejun7.park@samsung.=
com> wrote:
>
> With zoned storage, F2FS avoids direct IO writes and uses buffered writes
> with page cache flushes to prevent unaligned writes. However, the
> unaligned write can be avoided by allowing only a single thread per zone
> to perform direct writes.
>
> To achieve direct writes in zoned storage, it uses semephores to serializ=
e
> block allocation and writes per zone.
>
> Signed-off-by: Daejun Park <daejun7.park@samsung.com>
> ---
>  fs/f2fs/data.c    | 28 ++++++++++++++++++++++++++-
>  fs/f2fs/f2fs.h    |  7 +++++--
>  fs/f2fs/file.c    | 48 ++++++++++++++++++++++++++++++++++++++++-------
>  fs/f2fs/gc.c      |  4 ++--
>  fs/f2fs/segment.c |  6 +++---
>  fs/f2fs/super.c   |  5 ++++-
>  6 files changed, 82 insertions(+), 16 deletions(-)
>
> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
> index b94cf6eea2f9..fa2bd88a2ed2 100644
> --- a/fs/f2fs/data.c
> +++ b/fs/f2fs/data.c
> @@ -922,7 +922,7 @@ int f2fs_merge_page_bio(struct f2fs_io_info *fio)
>  }
>
>  #ifdef CONFIG_BLK_DEV_ZONED
> -static bool is_end_zone_blkaddr(struct f2fs_sb_info *sbi, block_t blkadd=
r)
> +bool is_end_zone_blkaddr(struct f2fs_sb_info *sbi, block_t blkaddr)
>  {
>         struct block_device *bdev =3D sbi->sb->s_bdev;
>         int devi =3D 0;
> @@ -4207,6 +4207,7 @@ static int f2fs_iomap_begin(struct inode *inode, lo=
ff_t offset, loff_t length,
>                             struct iomap *srcmap)
>  {
>         struct f2fs_map_blocks map =3D {};
> +       struct f2fs_sb_info *sbi =3D F2FS_I_SB(inode);
>         pgoff_t next_pgofs =3D 0;
>         int err;
>
> @@ -4218,6 +4219,18 @@ static int f2fs_iomap_begin(struct inode *inode, l=
off_t offset, loff_t length,
>         if (flags & IOMAP_WRITE)
>                 map.m_may_create =3D true;
>
> +       if (f2fs_sb_has_blkzoned(sbi) && !f2fs_is_pinned_file(inode)) {

I think it's better that we can skip this for conventional LU by
examining the block address.

> +               struct f2fs_rwsem *io_order_lock =3D
> +                               &sbi->io_order_lock[map.m_seg_type];
> +
> +               f2fs_down_write(io_order_lock);
> +
> +               /* set io order lock */
> +               iomap->private =3D io_order_lock;
> +       } else {
> +               iomap->private =3D NULL;
> +       }
> +
>         err =3D f2fs_map_blocks(inode, &map, F2FS_GET_BLOCK_DIO);
>         if (err)
>                 return err;
> @@ -4273,6 +4286,19 @@ static int f2fs_iomap_begin(struct inode *inode, l=
off_t offset, loff_t length,
>         return 0;
>  }
>
> +static int f2fs_iomap_end(struct inode *inode, loff_t pos, loff_t length=
,
> +               ssize_t written, unsigned int flags, struct iomap *iomap)
> +{
> +       struct f2fs_rwsem *io_order_lock =3D iomap->private;
> +
> +       /* ordered write */
> +       if (io_order_lock)
> +               f2fs_up_write(io_order_lock);
> +
> +       return 0;
> +}
> +
>  const struct iomap_ops f2fs_iomap_ops =3D {
>         .iomap_begin    =3D f2fs_iomap_begin,
> +       .iomap_end      =3D f2fs_iomap_end,
>  };
> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> index 33f5449dc22d..06ed132f22ad 100644
> --- a/fs/f2fs/f2fs.h
> +++ b/fs/f2fs/f2fs.h
> @@ -1582,8 +1582,8 @@ struct f2fs_sb_info {
>
>         /* for bio operations */
>         struct f2fs_bio_info *write_io[NR_PAGE_TYPE];   /* for write bios=
 */
> -       /* keep migration IO order for LFS mode */
> -       struct f2fs_rwsem io_order_lock;
> +       /* keep IO order for LFS mode */
> +       struct f2fs_rwsem io_order_lock[NR_CURSEG_DATA_TYPE];
>         pgoff_t page_eio_ofs[NR_PAGE_TYPE];     /* EIO page offset */
>         int page_eio_cnt[NR_PAGE_TYPE];         /* EIO count */
>
> @@ -3863,6 +3863,9 @@ void f2fs_submit_merged_ipu_write(struct f2fs_sb_in=
fo *sbi,
>  void f2fs_flush_merged_writes(struct f2fs_sb_info *sbi);
>  int f2fs_submit_page_bio(struct f2fs_io_info *fio);
>  int f2fs_merge_page_bio(struct f2fs_io_info *fio);
> +#ifdef CONFIG_BLK_DEV_ZONED
> +bool is_end_zone_blkaddr(struct f2fs_sb_info *sbi, block_t blkaddr);
> +#endif
>  void f2fs_submit_page_write(struct f2fs_io_info *fio);
>  struct block_device *f2fs_target_device(struct f2fs_sb_info *sbi,
>                 block_t blk_addr, sector_t *sector);
> diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
> index 99903eafa7fe..fde49f3e54cf 100644
> --- a/fs/f2fs/file.c
> +++ b/fs/f2fs/file.c
> @@ -869,13 +869,7 @@ static bool f2fs_force_buffered_io(struct inode *ino=
de, int rw)
>         /* disallow direct IO if any of devices has unaligned blksize */
>         if (f2fs_is_multi_device(sbi) && !sbi->aligned_blksize)
>                 return true;
> -       /*
> -        * for blkzoned device, fallback direct IO to buffered IO, so
> -        * all IOs can be serialized by log-structured write.
> -        */
> -       if (f2fs_sb_has_blkzoned(sbi) && (rw =3D=3D WRITE) &&
> -           !f2fs_is_pinned_file(inode))
> -               return true;
> +
>         if (is_sbi_flag_set(sbi, SBI_CP_DISABLED))
>                 return true;
>
> @@ -4815,6 +4809,17 @@ static int f2fs_dio_write_end_io(struct kiocb *ioc=
b, ssize_t size, int error,
>         return 0;
>  }
>
> +#ifdef CONFIG_BLK_DEV_ZONED
> +static void f2fs_dio_zone_write_end_io(struct bio *bio)
> +{
> +       struct f2fs_bio_info *io =3D (struct f2fs_bio_info *)bio->bi_priv=
ate;
> +
> +       bio->bi_private =3D io->bi_private;
> +       complete(&io->zone_wait);
> +       iomap_dio_bio_end_io(bio);
> +}
> +#endif
> +
>  static void f2fs_dio_write_submit_io(const struct iomap_iter *iter,
>                                         struct bio *bio, loff_t file_offs=
et)
>  {
> @@ -4824,6 +4829,31 @@ static void f2fs_dio_write_submit_io(const struct =
iomap_iter *iter,
>         enum temp_type temp =3D f2fs_get_segment_temp(seg_type);
>
>         bio->bi_write_hint =3D f2fs_io_type_to_rw_hint(sbi, DATA, temp);
> +
> +#ifdef CONFIG_BLK_DEV_ZONED
> +       if (f2fs_sb_has_blkzoned(sbi) && !f2fs_is_pinned_file(inode)) {
> +               struct f2fs_bio_info *io =3D sbi->write_io[DATA] + temp;
> +               block_t last_blkaddr =3D SECTOR_TO_BLOCK(bio_end_sector(b=
io) - 1);
> +
> +               f2fs_down_write(&io->io_rwsem);
> +               if (io->zone_pending_bio) {
> +                       wait_for_completion_io(&io->zone_wait);
> +                       bio_put(io->zone_pending_bio);
> +                       io->zone_pending_bio =3D NULL;
> +                       io->bi_private =3D NULL;
> +               }
> +
> +               if (is_end_zone_blkaddr(sbi, last_blkaddr)) {
> +                       bio_get(bio);
> +                       reinit_completion(&io->zone_wait);
> +                       io->bi_private =3D bio->bi_private;
> +                       bio->bi_private =3D io;
> +                       bio->bi_end_io =3D f2fs_dio_zone_write_end_io;
> +                       io->zone_pending_bio =3D bio;
> +               }
> +               f2fs_up_write(&io->io_rwsem);
> +       }
> +#endif
>         submit_bio(bio);
>  }
>
> @@ -4897,6 +4927,10 @@ static ssize_t f2fs_dio_write_iter(struct kiocb *i=
ocb, struct iov_iter *from,
>         dio_flags =3D 0;
>         if (pos + count > inode->i_size)
>                 dio_flags |=3D IOMAP_DIO_FORCE_WAIT;
> +
> +       if (f2fs_sb_has_blkzoned(sbi) && !f2fs_is_pinned_file(inode))
> +               dio_flags |=3D IOMAP_DIO_FORCE_WAIT;
> +
>         dio =3D __iomap_dio_rw(iocb, from, &f2fs_iomap_ops,
>                              &f2fs_iomap_dio_write_ops, dio_flags, NULL, =
0);
>         if (IS_ERR_OR_NULL(dio)) {
> diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
> index 9322a7200e31..49270713f739 100644
> --- a/fs/f2fs/gc.c
> +++ b/fs/f2fs/gc.c
> @@ -1361,7 +1361,7 @@ static int move_data_block(struct inode *inode, blo=
ck_t bidx,
>         fio.new_blkaddr =3D fio.old_blkaddr =3D dn.data_blkaddr;
>
>         if (lfs_mode)
> -               f2fs_down_write(&fio.sbi->io_order_lock);
> +               f2fs_down_write(&fio.sbi->io_order_lock[CURSEG_COLD_DATA]=
);
>
>         mpage =3D f2fs_grab_cache_page(META_MAPPING(fio.sbi),
>                                         fio.old_blkaddr, false);
> @@ -1444,7 +1444,7 @@ static int move_data_block(struct inode *inode, blo=
ck_t bidx,
>                                                         true, true, true)=
;
>  up_out:
>         if (lfs_mode)
> -               f2fs_up_write(&fio.sbi->io_order_lock);
> +               f2fs_up_write(&fio.sbi->io_order_lock[CURSEG_COLD_DATA]);
>  put_out:
>         f2fs_put_dnode(&dn);
>  out:
> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
> index 1766254279d2..d602ae4d79e3 100644
> --- a/fs/f2fs/segment.c
> +++ b/fs/f2fs/segment.c
> @@ -3796,10 +3796,10 @@ void f2fs_update_device_state(struct f2fs_sb_info=
 *sbi, nid_t ino,
>  static void do_write_page(struct f2fs_summary *sum, struct f2fs_io_info =
*fio)
>  {
>         int type =3D __get_segment_type(fio);
> -       bool keep_order =3D (f2fs_lfs_mode(fio->sbi) && type =3D=3D CURSE=
G_COLD_DATA);
> +       bool keep_order =3D (f2fs_lfs_mode(fio->sbi) && type <=3D CURSEG_=
COLD_DATA);

ditto

>
>         if (keep_order)
> -               f2fs_down_read(&fio->sbi->io_order_lock);
> +               f2fs_down_read(&fio->sbi->io_order_lock[type]);
>
>         if (f2fs_allocate_data_block(fio->sbi, fio->page, fio->old_blkadd=
r,
>                         &fio->new_blkaddr, sum, type, fio)) {
> @@ -3819,7 +3819,7 @@ static void do_write_page(struct f2fs_summary *sum,=
 struct f2fs_io_info *fio)
>         f2fs_update_device_state(fio->sbi, fio->ino, fio->new_blkaddr, 1)=
;
>  out:
>         if (keep_order)
> -               f2fs_up_read(&fio->sbi->io_order_lock);
> +               f2fs_up_read(&fio->sbi->io_order_lock[type]);
>  }
>
>  void f2fs_do_write_meta_page(struct f2fs_sb_info *sbi, struct folio *fol=
io,
> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
> index fc2c586c7619..5289b6f5f6f3 100644
> --- a/fs/f2fs/super.c
> +++ b/fs/f2fs/super.c
> @@ -3833,7 +3833,10 @@ static void init_sb_info(struct f2fs_sb_info *sbi)
>
>         INIT_LIST_HEAD(&sbi->s_list);
>         mutex_init(&sbi->umount_mutex);
> -       init_f2fs_rwsem(&sbi->io_order_lock);
> +
> +       for (i =3D 0; i < NR_CURSEG_DATA_TYPE; i++)
> +               init_f2fs_rwsem(&sbi->io_order_lock[i]);
> +
>         spin_lock_init(&sbi->cp_lock);
>
>         sbi->dirty_device =3D 0;
> --
> 2.25.1
>
>
>
> _______________________________________________
> Linux-f2fs-devel mailing list
> Linux-f2fs-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

