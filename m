Return-Path: <linux-kernel+bounces-309612-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0ED5A966D6B
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Aug 2024 02:22:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 32D3B1C21E00
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Aug 2024 00:22:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65695AD2D;
	Sat, 31 Aug 2024 00:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="a9RwiSav"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E51BE524F
	for <linux-kernel@vger.kernel.org>; Sat, 31 Aug 2024 00:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725063606; cv=none; b=WiGjrJq2GRDWIIhdZ7eFDJ243+A8oFql3JSork1xNcE5qD1CKu1eBmCSPFn7kDy9YtulTeHCzHYZRNpI/2+tNi1XD6XvwLnaOV6nIL4wrJbX5o5/FKR7v7vUn/s1m91x/XNUFyE82r42xxlKIML/3eq26/XOsbZeOURzLYWuvuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725063606; c=relaxed/simple;
	bh=ZZRowe4RhA8xyNZe9Heq7nYlnDjY/IUL5ju5PjQ5jvA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=V/2e2BB4ZMToD8QlhiOAkAW4IkKHFIfV+l0vqg5k/4zGLcGHENnP3uJ6I3c+KeYCXBpsN5do9VnPvQ/6g4OGjAKQlMpxQCOdbnIRPP5EpftvHv/TKmRxVeaf2gf1mw9yst0fd1BVjF/xg0P9X+husG7jwdEFihNEzyIGYCFccKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=a9RwiSav; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-20227ba378eso21096015ad.0
        for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 17:20:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1725063604; x=1725668404; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pnTgkaw7FBT1YuA35mRpkBR8NB9M9iFw+p1sV3ijNNg=;
        b=a9RwiSavhV3VB1A7jJ3j8sLYQnwlpsS/Ol75N0AdL34y4bl3p6uJKoW/IpNA1tAooP
         jcewqulKqytoNar0W+rIN0oO1yd4EYNkChn52XvtGncQr1ZcE7KPOxKXLA7IWBKiyqww
         4QeUsag0vtcJEaxWPfcNuG4E2o+GJNc6mGQX8IhX68Nvt6wxfjqOZ1fAkvimw7CJIFTz
         rTLAogH6CEgfqeG7TxEC6LD3s6luWAnI6DA4is0G5zs36wzVmxT8HTtRipJid4Wg/PW3
         pccJ0vWxxJqhOn6WgpFb8nngD/2MnE5Nr6yDv9NxbMkqHmOCPRxrI9jRcYuWS6GctC0p
         yLow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725063604; x=1725668404;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pnTgkaw7FBT1YuA35mRpkBR8NB9M9iFw+p1sV3ijNNg=;
        b=EkFJ+ApEHgvgDjFuWuQYTXv9zsbB1v1zMq8GkuJeqQ9cG4W4mopCZx7MHgGPTzOqnT
         IFY97+zlDFQH3s6dIsmHwfeisLakYjteUiVDVz+hoZj4Zl10WERb9DNV5/czEIx3fCEZ
         gG63n1obGQaxakIJrHCa8Sxfq5/QX+pf6iRMRFjf6bGZSnzxdFBT5ljjD/iu6U6iJksh
         rlvXRv8bTwAlpXlf9FCDRPSJka4pLAN7264IZdxCr9VUjfmi+hQ8c75Q3NNFUAk9qznC
         JTLn0mESh9g2qvIDNcFXl8U3U1TiiVftPvS6P8HBZ/K3eG5FPw55+bYX1sOgFeHK25Hs
         3sWQ==
X-Forwarded-Encrypted: i=1; AJvYcCWlCoTDRseOvDCWTiBe8cf4fju7FfDUTDWZiYwhcpNBR2fHRtNsnUQP+bSpE2XSXIVaKbXj6O4CUoRPasU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxxyoeIwtvVgFs2tHowkMwokbrRUpvNgJexNT/QZ+DheTvD8536
	gnzaSJIhGOk/Fy+FFQNT2g6m6/mcs5/Jtyk/TXIJ/9uuaQPouDccnXhSdvY1IDHGPW3fzj0wm6x
	emuJFpwLxy633WpVu/x/kPM404iF3DBHzqn/z
X-Google-Smtp-Source: AGHT+IF6XTKtBOAzEJx7MD6AtUrAhijeTxPzAnrvV/O3/Prkia5bkSOhQQTfiMWxnItUocbdNBp2TMQ56goqyfNkbrI=
X-Received: by 2002:a17:902:ea0a:b0:201:daee:6fae with SMTP id
 d9443c01a7336-2050c3f9cb4mr88855095ad.48.1725063603496; Fri, 30 Aug 2024
 17:20:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240830032840.3783206-1-hsiangkao@linux.alibaba.com> <20240830032840.3783206-2-hsiangkao@linux.alibaba.com>
In-Reply-To: <20240830032840.3783206-2-hsiangkao@linux.alibaba.com>
From: Sandeep Dhavale <dhavale@google.com>
Date: Fri, 30 Aug 2024 17:19:52 -0700
Message-ID: <CAB=BE-Q1X2ossOkSUJcW_m-GBnzQngTMnCxUWUBD=qei-J7_=g@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] erofs: support unencoded inodes for fileio
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Cc: linux-erofs@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 29, 2024 at 8:29=E2=80=AFPM Gao Xiang <hsiangkao@linux.alibaba.=
com> wrote:
>
> Since EROFS only needs to handle read requests in simple contexts,
> Just directly use vfs_iocb_iter_read() for data I/Os.
>
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
> ---
> v2:
>  - fix redundant refcount which cause hanging on chunked inodes.
>
>  fs/erofs/Makefile   |   1 +
>  fs/erofs/data.c     |  50 +++++++++++-
>  fs/erofs/fileio.c   | 181 ++++++++++++++++++++++++++++++++++++++++++++
>  fs/erofs/inode.c    |  17 +++--
>  fs/erofs/internal.h |   7 +-
>  fs/erofs/zdata.c    |  46 ++---------
>  6 files changed, 251 insertions(+), 51 deletions(-)
>  create mode 100644 fs/erofs/fileio.c
>
> diff --git a/fs/erofs/Makefile b/fs/erofs/Makefile
> index 097d672e6b14..4331d53c7109 100644
> --- a/fs/erofs/Makefile
> +++ b/fs/erofs/Makefile
> @@ -7,4 +7,5 @@ erofs-$(CONFIG_EROFS_FS_ZIP) +=3D decompressor.o zmap.o z=
data.o zutil.o
>  erofs-$(CONFIG_EROFS_FS_ZIP_LZMA) +=3D decompressor_lzma.o
>  erofs-$(CONFIG_EROFS_FS_ZIP_DEFLATE) +=3D decompressor_deflate.o
>  erofs-$(CONFIG_EROFS_FS_ZIP_ZSTD) +=3D decompressor_zstd.o
> +erofs-$(CONFIG_EROFS_FS_BACKED_BY_FILE) +=3D fileio.o
>  erofs-$(CONFIG_EROFS_FS_ONDEMAND) +=3D fscache.o
> diff --git a/fs/erofs/data.c b/fs/erofs/data.c
> index 0fb31c588ae0..b4c07ce7a294 100644
> --- a/fs/erofs/data.c
> +++ b/fs/erofs/data.c
> @@ -132,7 +132,7 @@ int erofs_map_blocks(struct inode *inode, struct erof=
s_map_blocks *map)
>         if (map->m_la >=3D inode->i_size) {
>                 /* leave out-of-bound access unmapped */
>                 map->m_flags =3D 0;
> -               map->m_plen =3D 0;
> +               map->m_plen =3D map->m_llen;
>                 goto out;
>         }
>
> @@ -197,8 +197,13 @@ static void erofs_fill_from_devinfo(struct erofs_map=
_dev *map,
>                                     struct erofs_device_info *dif)
>  {
>         map->m_bdev =3D NULL;
> -       if (dif->file && S_ISBLK(file_inode(dif->file)->i_mode))
> -               map->m_bdev =3D file_bdev(dif->file);
> +       map->m_fp =3D NULL;
> +       if (dif->file) {
> +               if (S_ISBLK(file_inode(dif->file)->i_mode))
> +                       map->m_bdev =3D file_bdev(dif->file);
> +               else
> +                       map->m_fp =3D dif->file;
> +       }
>         map->m_daxdev =3D dif->dax_dev;
>         map->m_dax_part_off =3D dif->dax_part_off;
>         map->m_fscache =3D dif->fscache;
> @@ -215,6 +220,7 @@ int erofs_map_dev(struct super_block *sb, struct erof=
s_map_dev *map)
>         map->m_daxdev =3D EROFS_SB(sb)->dax_dev;
>         map->m_dax_part_off =3D EROFS_SB(sb)->dax_part_off;
>         map->m_fscache =3D EROFS_SB(sb)->s_fscache;
> +       map->m_fp =3D EROFS_SB(sb)->fdev;
>
>         if (map->m_deviceid) {
>                 down_read(&devs->rwsem);
> @@ -250,6 +256,42 @@ int erofs_map_dev(struct super_block *sb, struct ero=
fs_map_dev *map)
>         return 0;
>  }
>
> +/*
> + * bit 30: I/O error occurred on this folio
> + * bit 0 - 29: remaining parts to complete this folio
> + */
> +#define EROFS_ONLINEFOLIO_EIO                  (1 << 30)
> +
> +void erofs_onlinefolio_init(struct folio *folio)
> +{
> +       union {
> +               atomic_t o;
> +               void *v;
> +       } u =3D { .o =3D ATOMIC_INIT(1) };
> +
> +       folio->private =3D u.v;   /* valid only if file-backed folio is l=
ocked */
> +}
> +
> +void erofs_onlinefolio_split(struct folio *folio)
> +{
> +       atomic_inc((atomic_t *)&folio->private);
> +}
> +
> +void erofs_onlinefolio_end(struct folio *folio, int err)
> +{
> +       int orig, v;
> +
> +       do {
> +               orig =3D atomic_read((atomic_t *)&folio->private);
> +               v =3D (orig - 1) | (err ? EROFS_ONLINEFOLIO_EIO : 0);
> +       } while (atomic_cmpxchg((atomic_t *)&folio->private, orig, v) !=
=3D orig);
> +
> +       if (v & ~EROFS_ONLINEFOLIO_EIO)
> +               return;
> +       folio->private =3D 0;
> +       folio_end_read(folio, !(v & EROFS_ONLINEFOLIO_EIO));
> +}
> +
>  static int erofs_iomap_begin(struct inode *inode, loff_t offset, loff_t =
length,
>                 unsigned int flags, struct iomap *iomap, struct iomap *sr=
cmap)
>  {
> @@ -399,7 +441,7 @@ static ssize_t erofs_file_read_iter(struct kiocb *ioc=
b, struct iov_iter *to)
>  }
>
>  /* for uncompressed (aligned) files and raw access for other files */
> -const struct address_space_operations erofs_raw_access_aops =3D {
> +const struct address_space_operations erofs_aops =3D {
>         .read_folio =3D erofs_read_folio,
>         .readahead =3D erofs_readahead,
>         .bmap =3D erofs_bmap,
> diff --git a/fs/erofs/fileio.c b/fs/erofs/fileio.c
> new file mode 100644
> index 000000000000..eab52b8abd0b
> --- /dev/null
> +++ b/fs/erofs/fileio.c
> @@ -0,0 +1,181 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (C) 2024, Alibaba Cloud
> + */
> +#include "internal.h"
> +#include <trace/events/erofs.h>
> +
> +struct erofs_fileio_rq {
> +       struct bio_vec bvecs[BIO_MAX_VECS];
> +       struct bio bio;
> +       struct kiocb iocb;
> +};
> +
> +struct erofs_fileio {
> +       struct erofs_map_blocks map;
> +       struct erofs_map_dev dev;
> +       struct erofs_fileio_rq *rq;
> +};
> +
> +static void erofs_fileio_ki_complete(struct kiocb *iocb, long ret)
> +{
> +       struct erofs_fileio_rq *rq =3D
> +                       container_of(iocb, struct erofs_fileio_rq, iocb);
> +       struct folio_iter fi;
> +
> +       DBG_BUGON(rq->bio.bi_end_io);
> +       if (ret > 0) {
> +               if (ret !=3D rq->bio.bi_iter.bi_size) {
> +                       bio_advance(&rq->bio, ret);
> +                       zero_fill_bio(&rq->bio);
> +               }
> +               ret =3D 0;
> +       }
> +       bio_for_each_folio_all(fi, &rq->bio) {
> +               DBG_BUGON(folio_test_uptodate(fi.folio));
> +               erofs_onlinefolio_end(fi.folio, ret);
> +       }
> +       kfree(rq);
> +}
> +
> +static void erofs_fileio_rq_submit(struct erofs_fileio_rq *rq)
> +{
> +       struct iov_iter iter;
> +       int ret;
> +
> +       if (!rq)
> +               return;
> +       rq->iocb.ki_pos =3D rq->bio.bi_iter.bi_sector << 9;
> +       rq->iocb.ki_ioprio =3D get_current_ioprio();
> +       rq->iocb.ki_complete =3D erofs_fileio_ki_complete;
> +       rq->iocb.ki_flags =3D (rq->iocb.ki_filp->f_mode & FMODE_CAN_ODIRE=
CT) ?
> +                               IOCB_DIRECT : 0;
Hi Gao,
Does this mean, direct IO by default if the backing file supports it
(technically filesystem where image/backing file reside)?

Thanks,
Sandeep.
> +       iov_iter_bvec(&iter, ITER_DEST, rq->bvecs, rq->bio.bi_vcnt,
> +                     rq->bio.bi_iter.bi_size);
> +       ret =3D vfs_iocb_iter_read(rq->iocb.ki_filp, &rq->iocb, &iter);
> +       if (ret !=3D -EIOCBQUEUED)
> +               erofs_fileio_ki_complete(&rq->iocb, ret);
> +}
> +
> +static struct erofs_fileio_rq *erofs_fileio_rq_alloc(struct erofs_map_de=
v *mdev)
> +{
> +       struct erofs_fileio_rq *rq =3D kzalloc(sizeof(*rq), GFP_KERNEL);
> +
> +       if (!rq)
> +               return NULL;
> +       bio_init(&rq->bio, NULL, rq->bvecs, BIO_MAX_VECS, REQ_OP_READ);
> +       rq->iocb.ki_filp =3D mdev->m_fp;
> +       return rq;
> +}
> +
> +static int erofs_fileio_scan_folio(struct erofs_fileio *io, struct folio=
 *folio)
> +{
> +       struct inode *inode =3D folio_inode(folio);
> +       struct erofs_map_blocks *map =3D &io->map;
> +       unsigned int cur =3D 0, end =3D folio_size(folio), len, attached =
=3D 0;
> +       loff_t pos =3D folio_pos(folio), ofs;
> +       struct iov_iter iter;
> +       struct bio_vec bv;
> +       int err =3D 0;
> +
> +       erofs_onlinefolio_init(folio);
> +       while (cur < end) {
> +               if (!in_range(pos + cur, map->m_la, map->m_llen)) {
> +                       map->m_la =3D pos + cur;
> +                       map->m_llen =3D end - cur;
> +                       err =3D erofs_map_blocks(inode, map);
> +                       if (err)
> +                               break;
> +               }
> +
> +               ofs =3D folio_pos(folio) + cur - map->m_la;
> +               len =3D min_t(loff_t, map->m_llen - ofs, end - cur);
> +               if (map->m_flags & EROFS_MAP_META) {
> +                       struct erofs_buf buf =3D __EROFS_BUF_INITIALIZER;
> +                       void *src;
> +
> +                       src =3D erofs_read_metabuf(&buf, inode->i_sb,
> +                                                map->m_pa + ofs, EROFS_K=
MAP);
> +                       if (IS_ERR(src)) {
> +                               err =3D PTR_ERR(src);
> +                               break;
> +                       }
> +                       bvec_set_folio(&bv, folio, len, cur);
> +                       iov_iter_bvec(&iter, ITER_DEST, &bv, 1, len);
> +                       if (copy_to_iter(src, len, &iter) !=3D len) {
> +                               erofs_put_metabuf(&buf);
> +                               err =3D -EIO;
> +                               break;
> +                       }
> +                       erofs_put_metabuf(&buf);
> +               } else if (!(map->m_flags & EROFS_MAP_MAPPED)) {
> +                       folio_zero_segment(folio, cur, cur + len);
> +               } else {
> +                       if (io->rq && (map->m_pa + ofs !=3D io->dev.m_pa =
||
> +                                      map->m_deviceid !=3D io->dev.m_dev=
iceid)) {
> +io_retry:
> +                               erofs_fileio_rq_submit(io->rq);
> +                               io->rq =3D NULL;
> +                       }
> +
> +                       if (!io->rq) {
> +                               io->dev =3D (struct erofs_map_dev) {
> +                                       .m_pa =3D io->map.m_pa + ofs,
> +                                       .m_deviceid =3D io->map.m_devicei=
d,
> +                               };
> +                               err =3D erofs_map_dev(inode->i_sb, &io->d=
ev);
> +                               if (err)
> +                                       break;
> +                               io->rq =3D erofs_fileio_rq_alloc(&io->dev=
);
> +                               if (!io->rq) {
> +                                       err =3D -ENOMEM;
> +                                       break;
> +                               }
> +                               io->rq->bio.bi_iter.bi_sector =3D io->dev=
.m_pa >> 9;
> +                               attached =3D 0;
> +                       }
> +                       if (!attached++)
> +                               erofs_onlinefolio_split(folio);
> +                       if (!bio_add_folio(&io->rq->bio, folio, len, cur)=
)
> +                               goto io_retry;
> +                       io->dev.m_pa +=3D len;
> +               }
> +               cur +=3D len;
> +       }
> +       erofs_onlinefolio_end(folio, err);
> +       return err;
> +}
> +
> +static int erofs_fileio_read_folio(struct file *file, struct folio *foli=
o)
> +{
> +       struct erofs_fileio io =3D {};
> +       int err;
> +
> +       trace_erofs_read_folio(folio, false);
> +       err =3D erofs_fileio_scan_folio(&io, folio);
> +       erofs_fileio_rq_submit(io.rq);
> +       return err;
> +}
> +
> +static void erofs_fileio_readahead(struct readahead_control *rac)
> +{
> +       struct inode *inode =3D rac->mapping->host;
> +       struct erofs_fileio io =3D {};
> +       struct folio *folio;
> +       int err;
> +
> +       trace_erofs_readpages(inode, readahead_index(rac),
> +                             readahead_count(rac), false);
> +       while ((folio =3D readahead_folio(rac))) {
> +               err =3D erofs_fileio_scan_folio(&io, folio);
> +               if (err && err !=3D -EINTR)
> +                       erofs_err(inode->i_sb, "readahead error at folio =
%lu @ nid %llu",
> +                                 folio->index, EROFS_I(inode)->nid);
> +       }
> +       erofs_fileio_rq_submit(io.rq);
> +}
> +
> +const struct address_space_operations erofs_fileio_aops =3D {
> +       .read_folio =3D erofs_fileio_read_folio,
> +       .readahead =3D erofs_fileio_readahead,
> +};
> diff --git a/fs/erofs/inode.c b/fs/erofs/inode.c
> index d05b9e59f122..4a902e6e69a5 100644
> --- a/fs/erofs/inode.c
> +++ b/fs/erofs/inode.c
> @@ -258,11 +258,14 @@ static int erofs_fill_inode(struct inode *inode)
>         }
>
>         mapping_set_large_folios(inode->i_mapping);
> -       if (erofs_is_fileio_mode(EROFS_SB(inode->i_sb))) {
> -               /* XXX: data I/Os will be implemented in the following pa=
tches */
> -               err =3D -EOPNOTSUPP;
> -       } else if (erofs_inode_is_data_compressed(vi->datalayout)) {
> +       if (erofs_inode_is_data_compressed(vi->datalayout)) {
>  #ifdef CONFIG_EROFS_FS_ZIP
> +#ifdef CONFIG_EROFS_FS_BACKED_BY_FILE
> +               if (erofs_is_fileio_mode(EROFS_SB(inode->i_sb))) {
> +                       err =3D -EOPNOTSUPP;
> +                       goto out_unlock;
> +               }
> +#endif
>                 DO_ONCE_LITE_IF(inode->i_blkbits !=3D PAGE_SHIFT,
>                           erofs_info, inode->i_sb,
>                           "EXPERIMENTAL EROFS subpage compressed block su=
pport in use. Use at your own risk!");
> @@ -271,10 +274,14 @@ static int erofs_fill_inode(struct inode *inode)
>                 err =3D -EOPNOTSUPP;
>  #endif
>         } else {
> -               inode->i_mapping->a_ops =3D &erofs_raw_access_aops;
> +               inode->i_mapping->a_ops =3D &erofs_aops;
>  #ifdef CONFIG_EROFS_FS_ONDEMAND
>                 if (erofs_is_fscache_mode(inode->i_sb))
>                         inode->i_mapping->a_ops =3D &erofs_fscache_access=
_aops;
> +#endif
> +#ifdef CONFIG_EROFS_FS_BACKED_BY_FILE
> +               if (erofs_is_fileio_mode(EROFS_SB(inode->i_sb)))
> +                       inode->i_mapping->a_ops =3D &erofs_fileio_aops;
>  #endif
>         }
>  out_unlock:
> diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
> index 9bf4fb1cfa09..9bc4dcfd06d7 100644
> --- a/fs/erofs/internal.h
> +++ b/fs/erofs/internal.h
> @@ -372,6 +372,7 @@ struct erofs_map_dev {
>         struct erofs_fscache *m_fscache;
>         struct block_device *m_bdev;
>         struct dax_device *m_daxdev;
> +       struct file *m_fp;
>         u64 m_dax_part_off;
>
>         erofs_off_t m_pa;
> @@ -380,7 +381,8 @@ struct erofs_map_dev {
>
>  extern const struct super_operations erofs_sops;
>
> -extern const struct address_space_operations erofs_raw_access_aops;
> +extern const struct address_space_operations erofs_aops;
> +extern const struct address_space_operations erofs_fileio_aops;
>  extern const struct address_space_operations z_erofs_aops;
>  extern const struct address_space_operations erofs_fscache_access_aops;
>
> @@ -411,6 +413,9 @@ int erofs_map_dev(struct super_block *sb, struct erof=
s_map_dev *dev);
>  int erofs_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo=
,
>                  u64 start, u64 len);
>  int erofs_map_blocks(struct inode *inode, struct erofs_map_blocks *map);
> +void erofs_onlinefolio_init(struct folio *folio);
> +void erofs_onlinefolio_split(struct folio *folio);
> +void erofs_onlinefolio_end(struct folio *folio, int err);
>  struct inode *erofs_iget(struct super_block *sb, erofs_nid_t nid);
>  int erofs_getattr(struct mnt_idmap *idmap, const struct path *path,
>                   struct kstat *stat, u32 request_mask,
> diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
> index 424f656cd765..350612f32ac6 100644
> --- a/fs/erofs/zdata.c
> +++ b/fs/erofs/zdata.c
> @@ -122,42 +122,6 @@ static bool erofs_folio_is_managed(struct erofs_sb_i=
nfo *sbi, struct folio *fo)
>         return fo->mapping =3D=3D MNGD_MAPPING(sbi);
>  }
>
> -/*
> - * bit 30: I/O error occurred on this folio
> - * bit 0 - 29: remaining parts to complete this folio
> - */
> -#define Z_EROFS_FOLIO_EIO                      (1 << 30)
> -
> -static void z_erofs_onlinefolio_init(struct folio *folio)
> -{
> -       union {
> -               atomic_t o;
> -               void *v;
> -       } u =3D { .o =3D ATOMIC_INIT(1) };
> -
> -       folio->private =3D u.v;   /* valid only if file-backed folio is l=
ocked */
> -}
> -
> -static void z_erofs_onlinefolio_split(struct folio *folio)
> -{
> -       atomic_inc((atomic_t *)&folio->private);
> -}
> -
> -static void z_erofs_onlinefolio_end(struct folio *folio, int err)
> -{
> -       int orig, v;
> -
> -       do {
> -               orig =3D atomic_read((atomic_t *)&folio->private);
> -               v =3D (orig - 1) | (err ? Z_EROFS_FOLIO_EIO : 0);
> -       } while (atomic_cmpxchg((atomic_t *)&folio->private, orig, v) !=
=3D orig);
> -
> -       if (v & ~Z_EROFS_FOLIO_EIO)
> -               return;
> -       folio->private =3D 0;
> -       folio_end_read(folio, !(v & Z_EROFS_FOLIO_EIO));
> -}
> -
>  #define Z_EROFS_ONSTACK_PAGES          32
>
>  /*
> @@ -965,7 +929,7 @@ static int z_erofs_scan_folio(struct z_erofs_decompre=
ss_frontend *f,
>         int err =3D 0;
>
>         tight =3D (bs =3D=3D PAGE_SIZE);
> -       z_erofs_onlinefolio_init(folio);
> +       erofs_onlinefolio_init(folio);
>         do {
>                 if (offset + end - 1 < map->m_la ||
>                     offset + end - 1 >=3D map->m_la + map->m_llen) {
> @@ -1024,7 +988,7 @@ static int z_erofs_scan_folio(struct z_erofs_decompr=
ess_frontend *f,
>                         if (err)
>                                 break;
>
> -                       z_erofs_onlinefolio_split(folio);
> +                       erofs_onlinefolio_split(folio);
>                         if (f->pcl->pageofs_out !=3D (map->m_la & ~PAGE_M=
ASK))
>                                 f->pcl->multibases =3D true;
>                         if (f->pcl->length < offset + end - map->m_la) {
> @@ -1044,7 +1008,7 @@ static int z_erofs_scan_folio(struct z_erofs_decomp=
ress_frontend *f,
>                         tight =3D (bs =3D=3D PAGE_SIZE);
>                 }
>         } while ((end =3D cur) > 0);
> -       z_erofs_onlinefolio_end(folio, err);
> +       erofs_onlinefolio_end(folio, err);
>         return err;
>  }
>
> @@ -1147,7 +1111,7 @@ static void z_erofs_fill_other_copies(struct z_erof=
s_decompress_backend *be,
>                         cur +=3D len;
>                 }
>                 kunmap_local(dst);
> -               z_erofs_onlinefolio_end(page_folio(bvi->bvec.page), err);
> +               erofs_onlinefolio_end(page_folio(bvi->bvec.page), err);
>                 list_del(p);
>                 kfree(bvi);
>         }
> @@ -1302,7 +1266,7 @@ static int z_erofs_decompress_pcluster(struct z_ero=
fs_decompress_backend *be,
>
>                 DBG_BUGON(z_erofs_page_is_invalidated(page));
>                 if (!z_erofs_is_shortlived_page(page)) {
> -                       z_erofs_onlinefolio_end(page_folio(page), err);
> +                       erofs_onlinefolio_end(page_folio(page), err);
>                         continue;
>                 }
>                 if (pcl->algorithmformat !=3D Z_EROFS_COMPRESSION_LZ4) {
> --
> 2.43.5
>

