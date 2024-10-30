Return-Path: <linux-kernel+bounces-389226-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D7499B6A43
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 18:08:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A18911C21BD6
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 17:08:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90142215023;
	Wed, 30 Oct 2024 17:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jh9S7BiA"
Received: from mail-vk1-f173.google.com (mail-vk1-f173.google.com [209.85.221.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24BAC1E7C3A
	for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 17:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730307623; cv=none; b=Ty1WWZhZj/6hBFojP3MkA8gLhbV7abcyghbHSl4P+rg3PJHDCwa3NAsANl+84ctvRsvM1HSmppY+XtIexA/gqnaPGkzE4N9kTyDwHSET1sLFMRc/s4iU/ZGVam2ABk6vogtSAdgTjExl7XdEJUSbV0TUH9Mlp6jT73KBZ4KqWSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730307623; c=relaxed/simple;
	bh=xEKWkEQ0dsTDVGsrZdU0x7/Ytc30fsIoqz1nb6OTFK0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Oeo4EiUbyL3NLvvH/4Jri+O4fTA9gMtetENRqp+9eFaybaWyTToal32QH/dDjnb76uCYI+XqDHu5PQHEvhP8iGasdAX/uq9t2ofaGgL8LV3GqiGSaKF0D4jm5pTKMkQ5d0lTOVGCbhv6TBkyElPi0nZQAG/ix8I0KgyL33B1eNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jh9S7BiA; arc=none smtp.client-ip=209.85.221.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f173.google.com with SMTP id 71dfb90a1353d-5101bd018ceso30968e0c.1
        for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 10:00:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730307620; x=1730912420; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wWrbK7fnh9whln3CNHKOj//EVVMSdORA+MSC2o/MTY0=;
        b=jh9S7BiAZlYQAiLnUTJkPDY3Jrd1ys7bMTbyU/WBEEveqOJ7y6GkdhDW+JuMbGB2YG
         oi8uMlDE36T8s0TcR+sPpFSWTzMoqd4Fbt3TuyZf4+BoaceIm9o/TRiuASwt+jbo6O3A
         8dPO1VQ6qlCxlXZQQicwhE4JU25ddC9r9fr0SenqpOsqmnu8WIDr1sX86o9zB1M3Tkb6
         KCyORARKPa8WVsBx5Zraatftq75z08bmSeaLhpATLwbabqOH+TV61wXKgJuHQI9e+LiV
         /Lob0MWBFdqg6/QgWdSx717cHnhYTlU62NfSdNhymWytczBP5+r6GjO41LNbb/Fzt2o4
         Nkkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730307620; x=1730912420;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wWrbK7fnh9whln3CNHKOj//EVVMSdORA+MSC2o/MTY0=;
        b=xDzvlDMp6P9uP+J0TtU4LQMmAepdhQbbSHDV+KSLiWuVF1QsM4WTf5SQhB4qFkmP6z
         sFtETlZ6qj7eBsbHFYeTLkJ1u/xa1VWkXi3czlWQL9QZJOxzkwuYihFOwtF0qyoKsJDz
         L40lia6w5rDai8Mc7PAsLvsxl9tzdAZvD5UZvMx43LS4vM6hKzADWzpbFLLddbI1t/6L
         hXROWjTmHsrZ32bh2nQ16jiYbq0Ln0zn8VjpGmzS0MCyQ2I5++4Fc32lBvHVgTqcD0mo
         LIK1XGrtZFnfDX7dKLn+HY+XleHN40K79YjEe8lc/0vKPGcsaMHgNmBMyz/RDBtCoTUl
         fJyQ==
X-Forwarded-Encrypted: i=1; AJvYcCUXZrGxPMTEuMRyj0rgMHuB5TRrAAmf6UuS3lnF9PWj/LNLcqf+1Ix2LtCxPeLXhZT4hClf7E/7upV2IyM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxMV47uof06ncxjqVNBWN/X9qyd/zFKn7E01ciyFfa93lMlYP9Y
	Vp1kYjxpufdtvQAD6E+eKfeGc/tyyKhCKUPBeSyTBsyZiyoio/9xaK+ZyZTLMgGPK9YoDmwiyUm
	Qzk9wgWpqmmLCM4asB6X4XgtbXoAQ/2Xu
X-Google-Smtp-Source: AGHT+IE+a/Gf/q8ZCJNrbPIEjOQEQW/h0iSkBlQV8DZREUM2G66zLJ+sF8UsnR1zsQnuSlZqupomzOXFiVHLrgYaFWM=
X-Received: by 2002:a05:6122:d90:b0:50d:35d9:ad5a with SMTP id
 71dfb90a1353d-51015045ccemr13184984e0c.5.1730307618102; Wed, 30 Oct 2024
 10:00:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241030103136.2874140-1-yi.sun@unisoc.com> <20241030103136.2874140-5-yi.sun@unisoc.com>
In-Reply-To: <20241030103136.2874140-5-yi.sun@unisoc.com>
From: Daeho Jeong <daeho43@gmail.com>
Date: Wed, 30 Oct 2024 10:00:06 -0700
Message-ID: <CACOAw_zn0ov0b2h9+zHn2gYVCDVGYPkXFNcx-j7OkhU0Y=i94g@mail.gmail.com>
Subject: Re: [f2fs-dev] [PATCH v2 4/5] f2fs: add parameter @len to f2fs_invalidate_blocks()
To: Yi Sun <yi.sun@unisoc.com>
Cc: chao@kernel.org, jaegeuk@kernel.org, ke.wang@unisoc.com, 
	linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, 
	sunyibuaa@gmail.com, hao_hao.wang@unisoc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 30, 2024 at 3:35=E2=80=AFAM Yi Sun <yi.sun@unisoc.com> wrote:
>
> New function can process some consecutive blocks at a time.
>
> Function f2fs_invalidate_blocks()->down_write() and up_write()
> are very time-consuming, so if f2fs_invalidate_blocks() can
> process consecutive blocks at one time, it will save a lot of time.
>
> Signed-off-by: Yi Sun <yi.sun@unisoc.com>
> ---
>  fs/f2fs/compress.c |  4 +--
>  fs/f2fs/f2fs.h     |  3 +-
>  fs/f2fs/file.c     |  8 +++---
>  fs/f2fs/node.c     |  4 +--
>  fs/f2fs/segment.c  | 69 ++++++++++++++++++++++++++++++++++++++--------
>  5 files changed, 68 insertions(+), 20 deletions(-)
>
> diff --git a/fs/f2fs/compress.c b/fs/f2fs/compress.c
> index e607a7885b57..02ad0ff29cf2 100644
> --- a/fs/f2fs/compress.c
> +++ b/fs/f2fs/compress.c
> @@ -1374,7 +1374,7 @@ static int f2fs_write_compressed_pages(struct compr=
ess_ctx *cc,
>                         if (blkaddr =3D=3D COMPRESS_ADDR)
>                                 fio.compr_blocks++;
>                         if (__is_valid_data_blkaddr(blkaddr))
> -                               f2fs_invalidate_blocks(sbi, blkaddr);
> +                               f2fs_invalidate_blocks(sbi, blkaddr, 1);
>                         f2fs_update_data_blkaddr(&dn, COMPRESS_ADDR);
>                         goto unlock_continue;
>                 }
> @@ -1384,7 +1384,7 @@ static int f2fs_write_compressed_pages(struct compr=
ess_ctx *cc,
>
>                 if (i > cc->valid_nr_cpages) {
>                         if (__is_valid_data_blkaddr(blkaddr)) {
> -                               f2fs_invalidate_blocks(sbi, blkaddr);
> +                               f2fs_invalidate_blocks(sbi, blkaddr, 1);
>                                 f2fs_update_data_blkaddr(&dn, NEW_ADDR);
>                         }
>                         goto unlock_continue;
> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> index addd49af57ec..4bb459157adf 100644
> --- a/fs/f2fs/f2fs.h
> +++ b/fs/f2fs/f2fs.h
> @@ -3716,7 +3716,8 @@ int f2fs_issue_flush(struct f2fs_sb_info *sbi, nid_=
t ino);
>  int f2fs_create_flush_cmd_control(struct f2fs_sb_info *sbi);
>  int f2fs_flush_device_cache(struct f2fs_sb_info *sbi);
>  void f2fs_destroy_flush_cmd_control(struct f2fs_sb_info *sbi, bool free)=
;
> -void f2fs_invalidate_blocks(struct f2fs_sb_info *sbi, block_t addr);
> +void f2fs_invalidate_blocks(struct f2fs_sb_info *sbi, block_t addr,
> +                                               unsigned int len);
>  bool f2fs_is_checkpointed_data(struct f2fs_sb_info *sbi, block_t blkaddr=
);
>  int f2fs_start_discard_thread(struct f2fs_sb_info *sbi);
>  void f2fs_drop_discard_cmd(struct f2fs_sb_info *sbi);
> diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
> index 75a8b22da664..13594bb502d1 100644
> --- a/fs/f2fs/file.c
> +++ b/fs/f2fs/file.c
> @@ -652,7 +652,7 @@ void f2fs_truncate_data_blocks_range(struct dnode_of_=
data *dn, int count)
>                                 valid_blocks++;
>                 }
>
> -               f2fs_invalidate_blocks(sbi, blkaddr);
> +               f2fs_invalidate_blocks(sbi, blkaddr, 1);
>
>                 if (!released || blkaddr !=3D COMPRESS_ADDR)
>                         nr_free++;
> @@ -750,7 +750,7 @@ int f2fs_do_truncate_blocks(struct inode *inode, u64 =
from, bool lock)
>                 unsigned int i;
>
>                 for (i =3D 0; i < ei.len; i++)
> -                       f2fs_invalidate_blocks(sbi, ei.blk + i);
> +                       f2fs_invalidate_blocks(sbi, ei.blk + i, 1);
>
>                 dec_valid_block_count(sbi, inode, ei.len);
>                 f2fs_update_time(sbi, REQ_TIME);
> @@ -1319,7 +1319,7 @@ static int __roll_back_blkaddrs(struct inode *inode=
, block_t *blkaddr,
>                 ret =3D f2fs_get_dnode_of_data(&dn, off + i, LOOKUP_NODE_=
RA);
>                 if (ret) {
>                         dec_valid_block_count(sbi, inode, 1);
> -                       f2fs_invalidate_blocks(sbi, *blkaddr);
> +                       f2fs_invalidate_blocks(sbi, *blkaddr, 1);
>                 } else {
>                         f2fs_update_data_blkaddr(&dn, *blkaddr);
>                 }
> @@ -1571,7 +1571,7 @@ static int f2fs_do_zero_range(struct dnode_of_data =
*dn, pgoff_t start,
>                         break;
>                 }
>
> -               f2fs_invalidate_blocks(sbi, dn->data_blkaddr);
> +               f2fs_invalidate_blocks(sbi, dn->data_blkaddr, 1);
>                 f2fs_set_data_blkaddr(dn, NEW_ADDR);
>         }
>
> diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
> index af36c6d6542b..db15d6a90f67 100644
> --- a/fs/f2fs/node.c
> +++ b/fs/f2fs/node.c
> @@ -916,7 +916,7 @@ static int truncate_node(struct dnode_of_data *dn)
>         }
>
>         /* Deallocate node address */
> -       f2fs_invalidate_blocks(sbi, ni.blk_addr);
> +       f2fs_invalidate_blocks(sbi, ni.blk_addr, 1);
>         dec_valid_node_count(sbi, dn->inode, dn->nid =3D=3D dn->inode->i_=
ino);
>         set_node_addr(sbi, &ni, NULL_ADDR, false);
>
> @@ -2761,7 +2761,7 @@ int f2fs_recover_xattr_data(struct inode *inode, st=
ruct page *page)
>         if (err)
>                 return err;
>
> -       f2fs_invalidate_blocks(sbi, ni.blk_addr);
> +       f2fs_invalidate_blocks(sbi, ni.blk_addr, 1);
>         dec_valid_node_count(sbi, inode, false);
>         set_node_addr(sbi, &ni, NULL_ADDR, false);
>
> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
> index 92ddff285a65..67f2bfdeb6ec 100644
> --- a/fs/f2fs/segment.c
> +++ b/fs/f2fs/segment.c
> @@ -245,7 +245,7 @@ static int __replace_atomic_write_block(struct inode =
*inode, pgoff_t index,
>                 if (!__is_valid_data_blkaddr(new_addr)) {
>                         if (new_addr =3D=3D NULL_ADDR)
>                                 dec_valid_block_count(sbi, inode, 1);
> -                       f2fs_invalidate_blocks(sbi, dn.data_blkaddr);
> +                       f2fs_invalidate_blocks(sbi, dn.data_blkaddr, 1);
>                         f2fs_update_data_blkaddr(&dn, new_addr);
>                 } else {
>                         f2fs_replace_block(sbi, &dn, dn.data_blkaddr,
> @@ -2558,29 +2558,76 @@ static void update_sit_entry(struct f2fs_sb_info =
*sbi, block_t blkaddr, int del)
>                 get_sec_entry(sbi, segno)->valid_blocks +=3D del;
>  }
>
> -void f2fs_invalidate_blocks(struct f2fs_sb_info *sbi, block_t addr)
> +static void __f2fs_invalidate_blocks(struct f2fs_sb_info *sbi,
> +                                       block_t addr, block_t end)
>  {
>         unsigned int segno =3D GET_SEGNO(sbi, addr);
>         struct sit_info *sit_i =3D SIT_I(sbi);
> +       unsigned int seg_num =3D GET_SEGNO(sbi, end) - segno + 1;
> +       unsigned int i =3D 1, max_blocks =3D sbi->blocks_per_seg, len;
> +       block_t addr_start =3D addr;
>
> -       f2fs_bug_on(sbi, addr =3D=3D NULL_ADDR);
> -       if (addr =3D=3D NEW_ADDR || addr =3D=3D COMPRESS_ADDR)
> -               return;
> -
> -       f2fs_invalidate_internal_cache(sbi, addr, 1);
> +       f2fs_invalidate_internal_cache(sbi, addr, end - addr + 1);
>
>         /* add it into sit main buffer */
>         down_write(&sit_i->sentry_lock);
>
> -       update_segment_mtime(sbi, addr, 0);
> -       update_sit_entry(sbi, addr, -1);
> +       if (seg_num =3D=3D 1)
> +               len =3D end - addr + 1;
> +       else
> +               len =3D max_blocks - GET_BLKOFF_FROM_SEG0(sbi, addr);
>
> -       /* add it into dirty seglist */
> -       locate_dirty_segment(sbi, segno);
> +       do {
> +               update_segment_mtime(sbi, addr_start, 0);
> +               update_sit_entry(sbi, addr_start, -len);
> +
> +               /* add it into dirty seglist */
> +               locate_dirty_segment(sbi, segno);
> +
> +               /* update @addr_start and @len and @segno */
> +               addr_start =3D START_BLOCK(sbi, ++segno);
> +               if (++i =3D=3D seg_num)
> +                       len =3D GET_BLKOFF_FROM_SEG0(sbi, end) + 1;
> +               else
> +                       len =3D max_blocks;
> +       } while (i <=3D seg_num);
>
>         up_write(&sit_i->sentry_lock);
>  }
>
> +void f2fs_invalidate_blocks(struct f2fs_sb_info *sbi,
> +                               block_t addr, unsigned int len)
> +{
> +       unsigned int i;
> +       /* Temporary record location */
> +       block_t addr_start =3D addr, addr_end;
> +
> +       if (len =3D=3D 0)
> +               return;
> +
> +       for (i =3D 0; i < len; i++) {
> +               addr_end =3D addr + i;
> +
> +               f2fs_bug_on(sbi, addr_end =3D=3D NULL_ADDR);

Looks like this line should be out of this loop, right?

> +
> +               if (addr_end =3D=3D NEW_ADDR || addr_end =3D=3D COMPRESS_=
ADDR) {

ditto?
Could you help with enhancing the readability here? a little bit
confused with using addr_start, addr_end and NEW_ADDR, COMPRESS_ADDR,
here.

> +                       if (addr_start =3D=3D addr_end) {
> +                               addr_end =3D addr_start =3D addr_end + 1;
> +                               continue;
> +                       }
> +
> +                       __f2fs_invalidate_blocks(sbi, addr_start, addr_en=
d - 1);
> +                       addr_end =3D addr_start =3D addr_end + 1;
> +               }
> +       }
> +
> +       if (addr_end >=3D (addr + len))
> +               return;
> +
> +       __f2fs_invalidate_blocks(sbi, addr_start, addr_end);
> +
> +}
> +
>  bool f2fs_is_checkpointed_data(struct f2fs_sb_info *sbi, block_t blkaddr=
)
>  {
>         struct sit_info *sit_i =3D SIT_I(sbi);
> --
> 2.25.1
>
>
>
> _______________________________________________
> Linux-f2fs-devel mailing list
> Linux-f2fs-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

