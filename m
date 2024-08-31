Return-Path: <linux-kernel+bounces-309624-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38EFB966D86
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Aug 2024 02:31:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5B2671C21F57
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Aug 2024 00:31:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 324CB4C81;
	Sat, 31 Aug 2024 00:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nHTmNktN"
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 116C51D12FE
	for <linux-kernel@vger.kernel.org>; Sat, 31 Aug 2024 00:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725064267; cv=none; b=jbNP6veCayUMIa/pXh6Y1Hzg82shdGwvBGTvLyI8evAWRpB/oRJRt111A6Dbh42IhhR5ZtQXF/X+9UIqUO70/POcLd/aOBkOPgOEYMLPPN3x1J6DgxGiA1OtBHino1q21Ss/VH8wT7AbhBsNcvrJjJAN0ASFKcFRo5n3n1LtfAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725064267; c=relaxed/simple;
	bh=tVD+UP8nUCTDkUBEXxAUd5XJk3IMXilTePMa8pU/Gzc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SiZIC+xUHX5nX+Xw2o5f3gRlKUyhE3g4isYwoDF0gJy97FHtkPA92Bjzcc1s3dHBsLES1/9iGppY/HY65F3C/7PfxyMi8E03gHL1y2iYC/TMf6qLjR2bC4Bfw9kn26d9H8PlIXAQ5Pq3Dtlq7NA4M7FPJHV/C0b7c7obuglFM+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nHTmNktN; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-2d3da054f7cso1813353a91.1
        for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 17:31:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1725064265; x=1725669065; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VT8oouZGQwzYC1vFmX2Bue/oThHs7bBkAgqX8/v0ST0=;
        b=nHTmNktNqw9MqbZvzuY2YhHDZ/hGG7jUw9o0Vg2EJz5KC6gs4mZKY3rC1T3Q9ct4vq
         kqA1rnNaJNJGYJ/3G71nJE6kcUi/Qam1x87b4Akk7CDjJbVyAL2I7k4MhwLOr9EXLHO/
         OC48Ph1kQqtbpqkpA6j5oCivP8IHp8SumU/uRngFx36FPlmnFzLF67FrcNvt4gTEe+Dr
         RG1bcXPffm3hkCDf7USM3Aq6j6v+1P6ypdLZbxrrlQVbI42gVR9gfByLnmrUfr9d6zIH
         1QU8WCJXVJNS2ccNm5iPfq5ma/DmcABU2JL+Uq3tr4LnmJLwmSDwIsZy/ZoL9EJg57Ul
         SYgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725064265; x=1725669065;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VT8oouZGQwzYC1vFmX2Bue/oThHs7bBkAgqX8/v0ST0=;
        b=l2mkrl2vRTYevpb3yMxW6p/WvytNLTyleAj/WEDjPP248sy+4jfKXrAyL5drNOAKjm
         zLfSk73QkfdTDpQehZ2lUHvwLpl4ppbEywExHaGEDJ9gAF+EtXqUFCpuhxncEVQyl8+/
         FmCfvalc2Aoe6prMlYpw8AcBY6GNbd4Iis+j7MQpD/Hx/bt6TWAPpcZssCbeT0MR1Acp
         f8kuifObru/OSbTKJm4QPMspT2abWFMW/t20uS259MND65z+KLdrd+HWzaYfHc979t0I
         ODX8dNw8XyE+egtCqto47hn8BKRwmAQFqpaRr9RlcVXkzNKrBSGGbDOxQLWnSx9M82Rs
         Bs9A==
X-Forwarded-Encrypted: i=1; AJvYcCWsDkDj/Mh+vlSj4xmfBJc9Tx8of4HvZCMeexJ7OQbDIbqP5Hn/lqbYnyQMhZuTF4KArmvsUhFpAT9a5IA=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywd68T3fvtrXbrXDiVtUNpxlm94Bd/jUBqxWMoY3u2OsuYw0bUO
	lecnpIyjBKZixbid20ptGYUPcjh/Lzh7dzPO+otVY4K9SbxgODoFWCPmJFiI6vadpX6aKoX5IJO
	26efixhRw3wirJA0LHgHJ4fLarPMdaZXINhrv
X-Google-Smtp-Source: AGHT+IHllA+hCLAfJhQi6WPIRVjTGZvJCzHWXnVAVx/B1xQX5e6f3kLuFFwG6AhJRWP6N1ZJ0kb0K5sZQa+Ghvga4Xs=
X-Received: by 2002:a17:90b:1917:b0:2d8:7a3b:730d with SMTP id
 98e67ed59e1d1-2d890546c3cmr1094202a91.21.1725064264712; Fri, 30 Aug 2024
 17:31:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240830032840.3783206-1-hsiangkao@linux.alibaba.com>
In-Reply-To: <20240830032840.3783206-1-hsiangkao@linux.alibaba.com>
From: Sandeep Dhavale <dhavale@google.com>
Date: Fri, 30 Aug 2024 17:30:53 -0700
Message-ID: <CAB=BE-R3wU7hBBaeAXdkDp2kvODxSFWNQtcmc5tCppN5qwdQgw@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] erofs: add file-backed mount support
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Cc: linux-erofs@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>, 
	kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 29, 2024 at 8:29=E2=80=AFPM Gao Xiang <hsiangkao@linux.alibaba.=
com> wrote:
>
> It actually has been around for years: For containers and other sandbox
> use cases, there will be thousands (and even more) of authenticated
> (sub)images running on the same host, unlike OS images.
>
> Of course, all scenarios can use the same EROFS on-disk format, but
> bdev-backed mounts just work well for OS images since golden data is
> dumped into real block devices.  However, it's somewhat hard for
> container runtimes to manage and isolate so many unnecessary virtual
> block devices safely and efficiently [1]: they just look like a burden
> to orchestrators and file-backed mounts are preferred indeed.  There
> were already enough attempts such as Incremental FS, the original
> ComposeFS and PuzzleFS acting in the same way for immutable fses.  As
> for current EROFS users, ComposeFS, containerd and Android APEXs will
> be directly benefited from it.
>
Hi Gao,
Thank you for the series! This is an interesting idea and will
definitely help the Android ecosystem for APEXes if we can remove the
loopback device. I will take a deeper look and provide comments soon.

Thanks,
Sandeep.

> On the other hand, previous experimental feature "erofs over fscache"
> was once also intended to provide a similar solution (inspired by
> Incremental FS discussion [2]), but the following facts show file-backed
> mounts will be a better approach:
>  - Fscache infrastructure has recently been moved into new Netfslib
>    which is an unexpected dependency to EROFS really, although it
>    originally claims "it could be used for caching other things such as
>    ISO9660 filesystems too." [3]
>
>  - It takes an unexpectedly long time to upstream Fscache/Cachefiles
>    enhancements.  For example, the failover feature took more than
>    one year, and the deamonless feature is still far behind now;
>
>  - Ongoing HSM "fanotify pre-content hooks" [4] together with this will
>    perfectly supersede "erofs over fscache" in a simpler way since
>    developers (mainly containerd folks) could leverage their existing
>    caching mechanism entirely in userspace instead of strictly following
>    the predefined in-kernel caching tree hierarchy.
>
> After "fanotify pre-content hooks" lands upstream to provide the same
> functionality, "erofs over fscache" will be removed then (as an EROFS
> internal improvement and EROFS will not have to bother with on-demand
> fetching and/or caching improvements anymore.)
>
> [1] https://github.com/containers/storage/pull/2039
> [2] https://lore.kernel.org/r/CAOQ4uxjbVxnubaPjVaGYiSwoGDTdpWbB=3Dw_AeM6Y=
M=3DzVixsUfQ@mail.gmail.com
> [3] https://docs.kernel.org/filesystems/caching/fscache.html
> [4] https://lore.kernel.org/r/cover.1723670362.git.josef@toxicpanda.com
>
> Closes: https://github.com/containers/composefs/issues/144
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
> ---
> v2:
>  - should use kill_anon_super();
>  - add O_LARGEFILE to support large files.
>
>  fs/erofs/Kconfig    | 17 ++++++++++
>  fs/erofs/data.c     | 35 ++++++++++++---------
>  fs/erofs/inode.c    |  5 ++-
>  fs/erofs/internal.h | 11 +++++--
>  fs/erofs/super.c    | 76 +++++++++++++++++++++++++++++----------------
>  5 files changed, 100 insertions(+), 44 deletions(-)
>
> diff --git a/fs/erofs/Kconfig b/fs/erofs/Kconfig
> index 7dcdce660cac..1428d0530e1c 100644
> --- a/fs/erofs/Kconfig
> +++ b/fs/erofs/Kconfig
> @@ -74,6 +74,23 @@ config EROFS_FS_SECURITY
>
>           If you are not using a security module, say N.
>
> +config EROFS_FS_BACKED_BY_FILE
> +       bool "File-backed EROFS filesystem support"
> +       depends on EROFS_FS
> +       default y
> +       help
> +         This allows EROFS to use filesystem image files directly, witho=
ut
> +         the intercession of loopback block devices or likewise. It is
> +         particularly useful for container images with numerous blobs an=
d
> +         other sandboxes, where loop devices behave intricately.  It can=
 also
> +         be used to simplify error-prone lifetime management of unnecess=
ary
> +         virtual block devices.
> +
> +         Note that this feature, along with ongoing fanotify pre-content
> +         hooks, will eventually replace "EROFS over fscache."
> +
> +         If you don't want to enable this feature, say N.
> +
>  config EROFS_FS_ZIP
>         bool "EROFS Data Compression Support"
>         depends on EROFS_FS
> diff --git a/fs/erofs/data.c b/fs/erofs/data.c
> index 1b7eba38ba1e..0fb31c588ae0 100644
> --- a/fs/erofs/data.c
> +++ b/fs/erofs/data.c
> @@ -59,8 +59,12 @@ void *erofs_bread(struct erofs_buf *buf, erofs_off_t o=
ffset,
>
>  void erofs_init_metabuf(struct erofs_buf *buf, struct super_block *sb)
>  {
> -       if (erofs_is_fscache_mode(sb))
> -               buf->mapping =3D EROFS_SB(sb)->s_fscache->inode->i_mappin=
g;
> +       struct erofs_sb_info *sbi =3D EROFS_SB(sb);
> +
> +       if (erofs_is_fileio_mode(sbi))
> +               buf->mapping =3D file_inode(sbi->fdev)->i_mapping;
> +       else if (erofs_is_fscache_mode(sb))
> +               buf->mapping =3D sbi->s_fscache->inode->i_mapping;
>         else
>                 buf->mapping =3D sb->s_bdev->bd_mapping;
>  }
> @@ -189,10 +193,22 @@ int erofs_map_blocks(struct inode *inode, struct er=
ofs_map_blocks *map)
>         return err;
>  }
>
> +static void erofs_fill_from_devinfo(struct erofs_map_dev *map,
> +                                   struct erofs_device_info *dif)
> +{
> +       map->m_bdev =3D NULL;
> +       if (dif->file && S_ISBLK(file_inode(dif->file)->i_mode))
> +               map->m_bdev =3D file_bdev(dif->file);
> +       map->m_daxdev =3D dif->dax_dev;
> +       map->m_dax_part_off =3D dif->dax_part_off;
> +       map->m_fscache =3D dif->fscache;
> +}
> +
>  int erofs_map_dev(struct super_block *sb, struct erofs_map_dev *map)
>  {
>         struct erofs_dev_context *devs =3D EROFS_SB(sb)->devs;
>         struct erofs_device_info *dif;
> +       erofs_off_t startoff, length;
>         int id;
>
>         map->m_bdev =3D sb->s_bdev;
> @@ -212,29 +228,20 @@ int erofs_map_dev(struct super_block *sb, struct er=
ofs_map_dev *map)
>                         up_read(&devs->rwsem);
>                         return 0;
>                 }
> -               map->m_bdev =3D dif->bdev_file ? file_bdev(dif->bdev_file=
) : NULL;
> -               map->m_daxdev =3D dif->dax_dev;
> -               map->m_dax_part_off =3D dif->dax_part_off;
> -               map->m_fscache =3D dif->fscache;
> +               erofs_fill_from_devinfo(map, dif);
>                 up_read(&devs->rwsem);
>         } else if (devs->extra_devices && !devs->flatdev) {
>                 down_read(&devs->rwsem);
>                 idr_for_each_entry(&devs->tree, dif, id) {
> -                       erofs_off_t startoff, length;
> -
>                         if (!dif->mapped_blkaddr)
>                                 continue;
> +
>                         startoff =3D erofs_pos(sb, dif->mapped_blkaddr);
>                         length =3D erofs_pos(sb, dif->blocks);
> -
>                         if (map->m_pa >=3D startoff &&
>                             map->m_pa < startoff + length) {
>                                 map->m_pa -=3D startoff;
> -                               map->m_bdev =3D dif->bdev_file ?
> -                                             file_bdev(dif->bdev_file) :=
 NULL;
> -                               map->m_daxdev =3D dif->dax_dev;
> -                               map->m_dax_part_off =3D dif->dax_part_off=
;
> -                               map->m_fscache =3D dif->fscache;
> +                               erofs_fill_from_devinfo(map, dif);
>                                 break;
>                         }
>                 }
> diff --git a/fs/erofs/inode.c b/fs/erofs/inode.c
> index 419432be3223..d05b9e59f122 100644
> --- a/fs/erofs/inode.c
> +++ b/fs/erofs/inode.c
> @@ -258,7 +258,10 @@ static int erofs_fill_inode(struct inode *inode)
>         }
>
>         mapping_set_large_folios(inode->i_mapping);
> -       if (erofs_inode_is_data_compressed(vi->datalayout)) {
> +       if (erofs_is_fileio_mode(EROFS_SB(inode->i_sb))) {
> +               /* XXX: data I/Os will be implemented in the following pa=
tches */
> +               err =3D -EOPNOTSUPP;
> +       } else if (erofs_inode_is_data_compressed(vi->datalayout)) {
>  #ifdef CONFIG_EROFS_FS_ZIP
>                 DO_ONCE_LITE_IF(inode->i_blkbits !=3D PAGE_SHIFT,
>                           erofs_info, inode->i_sb,
> diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
> index 45dc15ebd870..9bf4fb1cfa09 100644
> --- a/fs/erofs/internal.h
> +++ b/fs/erofs/internal.h
> @@ -49,7 +49,7 @@ typedef u32 erofs_blk_t;
>  struct erofs_device_info {
>         char *path;
>         struct erofs_fscache *fscache;
> -       struct file *bdev_file;
> +       struct file *file;
>         struct dax_device *dax_dev;
>         u64 dax_part_off;
>
> @@ -130,6 +130,7 @@ struct erofs_sb_info {
>
>         struct erofs_sb_lz4_info lz4;
>  #endif /* CONFIG_EROFS_FS_ZIP */
> +       struct file *fdev;
>         struct inode *packed_inode;
>         struct erofs_dev_context *devs;
>         struct dax_device *dax_dev;
> @@ -190,9 +191,15 @@ struct erofs_sb_info {
>  #define set_opt(opt, option)   ((opt)->mount_opt |=3D EROFS_MOUNT_##opti=
on)
>  #define test_opt(opt, option)  ((opt)->mount_opt & EROFS_MOUNT_##option)
>
> +static inline bool erofs_is_fileio_mode(struct erofs_sb_info *sbi)
> +{
> +       return IS_ENABLED(CONFIG_EROFS_FS_BACKED_BY_FILE) && sbi->fdev;
> +}
> +
>  static inline bool erofs_is_fscache_mode(struct super_block *sb)
>  {
> -       return IS_ENABLED(CONFIG_EROFS_FS_ONDEMAND) && !sb->s_bdev;
> +       return IS_ENABLED(CONFIG_EROFS_FS_ONDEMAND) &&
> +                       !erofs_is_fileio_mode(EROFS_SB(sb)) && !sb->s_bde=
v;
>  }
>
>  enum {
> diff --git a/fs/erofs/super.c b/fs/erofs/super.c
> index aae3fd15899a..9a7e67eceed4 100644
> --- a/fs/erofs/super.c
> +++ b/fs/erofs/super.c
> @@ -10,6 +10,7 @@
>  #include <linux/fs_context.h>
>  #include <linux/fs_parser.h>
>  #include <linux/exportfs.h>
> +#include <linux/backing-dev.h>
>  #include "xattr.h"
>
>  #define CREATE_TRACE_POINTS
> @@ -161,7 +162,7 @@ static int erofs_init_device(struct erofs_buf *buf, s=
truct super_block *sb,
>         struct erofs_sb_info *sbi =3D EROFS_SB(sb);
>         struct erofs_fscache *fscache;
>         struct erofs_deviceslot *dis;
> -       struct file *bdev_file;
> +       struct file *file;
>
>         dis =3D erofs_read_metabuf(buf, sb, *pos, EROFS_KMAP);
>         if (IS_ERR(dis))
> @@ -183,13 +184,17 @@ static int erofs_init_device(struct erofs_buf *buf,=
 struct super_block *sb,
>                         return PTR_ERR(fscache);
>                 dif->fscache =3D fscache;
>         } else if (!sbi->devs->flatdev) {
> -               bdev_file =3D bdev_file_open_by_path(dif->path, BLK_OPEN_=
READ,
> -                                               sb->s_type, NULL);
> -               if (IS_ERR(bdev_file))
> -                       return PTR_ERR(bdev_file);
> -               dif->bdev_file =3D bdev_file;
> -               dif->dax_dev =3D fs_dax_get_by_bdev(file_bdev(bdev_file),
> -                               &dif->dax_part_off, NULL, NULL);
> +               file =3D erofs_is_fileio_mode(sbi) ?
> +                               filp_open(dif->path, O_RDONLY | O_LARGEFI=
LE, 0) :
> +                               bdev_file_open_by_path(dif->path,
> +                                               BLK_OPEN_READ, sb->s_type=
, NULL);
> +               if (IS_ERR(file))
> +                       return PTR_ERR(file);
> +
> +               dif->file =3D file;
> +               if (!erofs_is_fileio_mode(sbi))
> +                       dif->dax_dev =3D fs_dax_get_by_bdev(file_bdev(fil=
e),
> +                                       &dif->dax_part_off, NULL, NULL);
>         }
>
>         dif->blocks =3D le32_to_cpu(dis->blocks);
> @@ -566,15 +571,16 @@ static void erofs_set_sysfs_name(struct super_block=
 *sb)
>  {
>         struct erofs_sb_info *sbi =3D EROFS_SB(sb);
>
> -       if (erofs_is_fscache_mode(sb)) {
> -               if (sbi->domain_id)
> -                       super_set_sysfs_name_generic(sb, "%s,%s",sbi->dom=
ain_id,
> -                                                    sbi->fsid);
> -               else
> -                       super_set_sysfs_name_generic(sb, "%s", sbi->fsid)=
;
> -               return;
> -       }
> -       super_set_sysfs_name_id(sb);
> +       if (sbi->domain_id)
> +               super_set_sysfs_name_generic(sb, "%s,%s", sbi->domain_id,
> +                                            sbi->fsid);
> +       else if (sbi->fsid)
> +               super_set_sysfs_name_generic(sb, "%s", sbi->fsid);
> +       else if (erofs_is_fileio_mode(sbi))
> +               super_set_sysfs_name_generic(sb, "%s",
> +                                            bdi_dev_name(sb->s_bdi));
> +       else
> +               super_set_sysfs_name_id(sb);
>  }
>
>  static int erofs_fc_fill_super(struct super_block *sb, struct fs_context=
 *fc)
> @@ -589,14 +595,15 @@ static int erofs_fc_fill_super(struct super_block *=
sb, struct fs_context *fc)
>         sb->s_op =3D &erofs_sops;
>
>         sbi->blkszbits =3D PAGE_SHIFT;
> -       if (erofs_is_fscache_mode(sb)) {
> +       if (!sb->s_bdev) {
>                 sb->s_blocksize =3D PAGE_SIZE;
>                 sb->s_blocksize_bits =3D PAGE_SHIFT;
>
> -               err =3D erofs_fscache_register_fs(sb);
> -               if (err)
> -                       return err;
> -
> +               if (erofs_is_fscache_mode(sb)) {
> +                       err =3D erofs_fscache_register_fs(sb);
> +                       if (err)
> +                               return err;
> +               }
>                 err =3D super_setup_bdi(sb);
>                 if (err)
>                         return err;
> @@ -693,11 +700,24 @@ static int erofs_fc_fill_super(struct super_block *=
sb, struct fs_context *fc)
>  static int erofs_fc_get_tree(struct fs_context *fc)
>  {
>         struct erofs_sb_info *sbi =3D fc->s_fs_info;
> +       int ret;
>
>         if (IS_ENABLED(CONFIG_EROFS_FS_ONDEMAND) && sbi->fsid)
>                 return get_tree_nodev(fc, erofs_fc_fill_super);
>
> -       return get_tree_bdev(fc, erofs_fc_fill_super);
> +       ret =3D get_tree_bdev(fc, erofs_fc_fill_super);
> +#ifdef CONFIG_EROFS_FS_BACKED_BY_FILE
> +       if (ret =3D=3D -ENOTBLK) {
> +               if (!fc->source)
> +                       return invalf(fc, "No source specified");
> +               sbi->fdev =3D filp_open(fc->source, O_RDONLY | O_LARGEFIL=
E, 0);
> +               if (IS_ERR(sbi->fdev))
> +                       return PTR_ERR(sbi->fdev);
> +
> +               return get_tree_nodev(fc, erofs_fc_fill_super);
> +       }
> +#endif
> +       return ret;
>  }
>
>  static int erofs_fc_reconfigure(struct fs_context *fc)
> @@ -727,8 +747,8 @@ static int erofs_release_device_info(int id, void *pt=
r, void *data)
>         struct erofs_device_info *dif =3D ptr;
>
>         fs_put_dax(dif->dax_dev, NULL);
> -       if (dif->bdev_file)
> -               fput(dif->bdev_file);
> +       if (dif->file)
> +               fput(dif->file);
>         erofs_fscache_unregister_cookie(dif->fscache);
>         dif->fscache =3D NULL;
>         kfree(dif->path);
> @@ -791,7 +811,7 @@ static void erofs_kill_sb(struct super_block *sb)
>  {
>         struct erofs_sb_info *sbi =3D EROFS_SB(sb);
>
> -       if (IS_ENABLED(CONFIG_EROFS_FS_ONDEMAND) && sbi->fsid)
> +       if ((IS_ENABLED(CONFIG_EROFS_FS_ONDEMAND) && sbi->fsid) || sbi->f=
dev)
>                 kill_anon_super(sb);
>         else
>                 kill_block_super(sb);
> @@ -801,6 +821,8 @@ static void erofs_kill_sb(struct super_block *sb)
>         erofs_fscache_unregister_fs(sb);
>         kfree(sbi->fsid);
>         kfree(sbi->domain_id);
> +       if (sbi->fdev)
> +               fput(sbi->fdev);
>         kfree(sbi);
>         sb->s_fs_info =3D NULL;
>  }
> @@ -903,7 +925,7 @@ static int erofs_statfs(struct dentry *dentry, struct=
 kstatfs *buf)
>         buf->f_namelen =3D EROFS_NAME_LEN;
>
>         if (uuid_is_null(&sb->s_uuid))
> -               buf->f_fsid =3D u64_to_fsid(erofs_is_fscache_mode(sb) ? 0=
 :
> +               buf->f_fsid =3D u64_to_fsid(!sb->s_bdev ? 0 :
>                                 huge_encode_dev(sb->s_bdev->bd_dev));
>         else
>                 buf->f_fsid =3D uuid_to_fsid(sb->s_uuid.b);
> --
> 2.43.5
>

