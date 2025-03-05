Return-Path: <linux-kernel+bounces-546172-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7E49A4F73E
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 07:39:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2FF2B3A7FCC
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 06:39:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDD541DC9BE;
	Wed,  5 Mar 2025 06:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lqhm5v+K"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8428E1078F
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 06:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741156786; cv=none; b=AeOsF8/AG8g++VyXn+ScaqOI0LKTx2bCs4OG0V3Izk7BZU4oRUZKeJ8/Q6AkyQ87/JzwXkkW/bx2cUM5K6Y0JRqLPbnGBVHHNo4SekYKPCEi6W8pVVQERBfqsQY2Mc3C3vg3wkibYv1cfX9F9ELKF+q58qtpY4B7p/8hyvnQAng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741156786; c=relaxed/simple;
	bh=iXaYjJnSHNdH1sMRh3a8nJmBk0g2ViKrhCScyf0UMd8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SptKjx7rYth0oWnFJiqi2zCMARkjiFGabJCtqScaV9YKHNMwmH6hmOxH5GXNu4ds86GJnYUMqwn9YPISdY8fsELyt3Uq2JDoPTOto+XBsS0S2tx/TO/1Z8W7gqxWNEbIN0CNviCZdUNXXAPEvUdkaLoW/sQJLfJkRhCa/KcXyqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lqhm5v+K; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-43bbf0fb0d6so3258625e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 04 Mar 2025 22:39:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741156782; x=1741761582; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5GDHFsT1jCkR5dbhbtlNVU9DUwSUkDs9T9prz234+yk=;
        b=lqhm5v+KguDUkZmbwI5K0787esdwhrOnAZxrfYJiRT7sDvOLtR06xYhoYEo2QD3j4k
         x+4x4/oFpVX6k0kyLGDgToWM6r0HApMoGz7xR5CdU4l6Z+yUW7DdPoraMyucJrIE4vCd
         tYHM/puW3UztJbRmn+SW+DzfwwMLVPTgMTGAXYF8/lEqinT/wxWciNUDeasgy8PonsEq
         fZj1fQKLhE/bFx2/eUDe0XhIEe6FPWwrfBgyBZlYm4lhrMwZVCbrYJ4YQNP8y9sFdDcZ
         ucLj8saT6R9OseN0xsLOD12oQvpIOv+heub414S0FA6qAHzR4qi1FE8OGUxyCgSRPdIW
         Tzfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741156782; x=1741761582;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5GDHFsT1jCkR5dbhbtlNVU9DUwSUkDs9T9prz234+yk=;
        b=U82aqtXuLW0cYRsLvdvlFwt+mRsDbbBpQiicyXE/HwtHnYsRI3GhOdwrsqiqo0I2sn
         PI4Sl3QuVlLPRUcEsLXAIf9klekuGm0TMp1t2ayZvuLHzyYu1LjbuHkRJcT4mx89Vpi9
         9XnK/U2SkeP9Fl6K86Rx0nHhlRTyLT9tk/gAh7MDGW+b3r+yGRpe8DDNRZSVfybX8q3l
         Nb3ktOQMDSapuWJYTWFR0b9GLpNitV6sb2IhgKxpoktF7GLRqxSwN7c5q/N8lpejdrSO
         78ve+v2VyZKjBHsf/PVhx7/bb8Xc/aOFLY8rFagOPGfFKYkGhRreOE1bT3GsATLHI2zk
         VejQ==
X-Forwarded-Encrypted: i=1; AJvYcCVrHh/DcSvMXp8kwDQE6SY2vY2g9zZwDDi8sJPgLJsCXHjLKfTtnwPe3mp1Cu5JC6jAxc5AzqqPWppCeas=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8/U0aMLoius/XHidHNcMErV+wQvg6A77ZSo7gcsfp64burPyv
	xc7kNUPiCljP0hOZo2FcNoZKS5doADHYpmdzkTHkqrBtKbifT304EaezNMdlDlYZ8FPIn6SF9kh
	ev9AucEpuVRhihmz2su32HdDT4r8=
X-Gm-Gg: ASbGnctycKRD0iZHDAIjCI3uwLKfd8yU/DwA7php7zQXGkEjlZj50D4WQFO09PiUqLy
	H0vjFC75Qqmabt1F7PSuqfHwkYUYSrZBmlfEfhV3c+uA7WZjLmEeia9J24gA1sGasDu2R6/Vo1d
	zzuxQWF9JoTAPxy8VdUqosuDPUjMc=
X-Google-Smtp-Source: AGHT+IFrDIrnAh/9tnpcr6peuZg6sgktPhWdHTUqlJMzOuMsfdPBNX4tOmsb3OfLpSVmdfHXwEiZiiKt61F3iNtMufQ=
X-Received: by 2002:a5d:6486:0:b0:38d:d69e:1316 with SMTP id
 ffacd0b85a97d-3911f72725bmr396701f8f.1.1741156782334; Tue, 04 Mar 2025
 22:39:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250303035423.1357211-1-chao@kernel.org>
In-Reply-To: <20250303035423.1357211-1-chao@kernel.org>
From: Zhiguo Niu <niuzhiguo84@gmail.com>
Date: Wed, 5 Mar 2025 14:39:30 +0800
X-Gm-Features: AQ5f1JowN4uOjgytqe3gorib3OepvMCqs_aDb8qxqV4vGSoe6v-H89tOi4GmdwM
Message-ID: <CAHJ8P3K7y_=uJ7R_-cBRt7bnOKT--3+BdzVfyYEUtc8-VNuyKQ@mail.gmail.com>
Subject: Re: [f2fs-dev] [PATCH 1/3] f2fs: do sanity check on inode footer in f2fs_get_inode_page()
To: Chao Yu <chao@kernel.org>
Cc: jaegeuk@kernel.org, linux-kernel@vger.kernel.org, 
	linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Chao Yu via Linux-f2fs-devel <linux-f2fs-devel@lists.sourceforge.net>
=E4=BA=8E2025=E5=B9=B43=E6=9C=883=E6=97=A5=E5=91=A8=E4=B8=80 11:57=E5=86=99=
=E9=81=93=EF=BC=9A
>
> This patch introduces a new wrapper f2fs_get_inode_page(), then, caller
> can use it to load inode block to page cache, meanwhile it will do sanity
> check on inode footer.
>
> Signed-off-by: Chao Yu <chao@kernel.org>
> ---
>  fs/f2fs/data.c   |  6 ++---
>  fs/f2fs/dir.c    |  2 +-
>  fs/f2fs/f2fs.h   |  3 ++-
>  fs/f2fs/file.c   |  2 +-
>  fs/f2fs/inline.c | 22 +++++++++----------
>  fs/f2fs/inode.c  |  4 ++--
>  fs/f2fs/node.c   | 57 +++++++++++++++++++++++++++++++++---------------
>  fs/f2fs/node.h   |  6 +++++
>  fs/f2fs/xattr.c  |  4 ++--
>  9 files changed, 67 insertions(+), 39 deletions(-)
>
> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
> index f1554a5a3d7a..e29d15d637ff 100644
> --- a/fs/f2fs/data.c
> +++ b/fs/f2fs/data.c
> @@ -3402,7 +3402,7 @@ static int prepare_write_begin(struct f2fs_sb_info =
*sbi,
>
>  restart:
>         /* check inline_data */
> -       ipage =3D f2fs_get_node_page(sbi, inode->i_ino);
> +       ipage =3D f2fs_get_inode_page(sbi, inode->i_ino);
>         if (IS_ERR(ipage)) {
>                 err =3D PTR_ERR(ipage);
>                 goto unlock_out;
> @@ -3465,7 +3465,7 @@ static int __find_data_block(struct inode *inode, p=
goff_t index,
>         struct page *ipage;
>         int err =3D 0;
>
> -       ipage =3D f2fs_get_node_page(F2FS_I_SB(inode), inode->i_ino);
> +       ipage =3D f2fs_get_inode_page(F2FS_I_SB(inode), inode->i_ino);
>         if (IS_ERR(ipage))
>                 return PTR_ERR(ipage);
>
> @@ -3495,7 +3495,7 @@ static int __reserve_data_block(struct inode *inode=
, pgoff_t index,
>
>         f2fs_map_lock(sbi, F2FS_GET_BLOCK_PRE_AIO);
>
> -       ipage =3D f2fs_get_node_page(sbi, inode->i_ino);
> +       ipage =3D f2fs_get_inode_page(sbi, inode->i_ino);
>         if (IS_ERR(ipage)) {
>                 err =3D PTR_ERR(ipage);
>                 goto unlock_out;
> diff --git a/fs/f2fs/dir.c b/fs/f2fs/dir.c
> index 4c74f29a2c73..acd5b2e3e966 100644
> --- a/fs/f2fs/dir.c
> +++ b/fs/f2fs/dir.c
> @@ -552,7 +552,7 @@ struct page *f2fs_init_inode_metadata(struct inode *i=
node, struct inode *dir,
>                                 goto put_error;
>                 }
>         } else {
> -               page =3D f2fs_get_node_page(F2FS_I_SB(dir), inode->i_ino)=
;
> +               page =3D f2fs_get_inode_page(F2FS_I_SB(dir), inode->i_ino=
);
>                 if (IS_ERR(page))
>                         return page;
>         }
> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> index e45c204c36ec..74a80bb06f06 100644
> --- a/fs/f2fs/f2fs.h
> +++ b/fs/f2fs/f2fs.h
> @@ -3702,7 +3702,8 @@ struct page *f2fs_new_inode_page(struct inode *inod=
e);
>  struct page *f2fs_new_node_page(struct dnode_of_data *dn, unsigned int o=
fs);
>  void f2fs_ra_node_page(struct f2fs_sb_info *sbi, nid_t nid);
>  struct page *f2fs_get_node_page(struct f2fs_sb_info *sbi, pgoff_t nid);
> -struct folio *f2fs_get_node_folio(struct f2fs_sb_info *sbi, pgoff_t nid)=
;
> +struct folio *f2fs_get_inode_folio(struct f2fs_sb_info *sbi, pgoff_t ino=
);
> +struct page *f2fs_get_inode_page(struct f2fs_sb_info *sbi, pgoff_t ino);
>  struct page *f2fs_get_node_page_ra(struct page *parent, int start);
>  int f2fs_move_node_page(struct page *node_page, int gc_type);
>  void f2fs_flush_inline_data(struct f2fs_sb_info *sbi);
> diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
> index cd8d366b2fd7..d21fd2ef8bf8 100644
> --- a/fs/f2fs/file.c
> +++ b/fs/f2fs/file.c
> @@ -761,7 +761,7 @@ int f2fs_do_truncate_blocks(struct inode *inode, u64 =
from, bool lock)
>         if (lock)
>                 f2fs_lock_op(sbi);
>
> -       ipage =3D f2fs_get_node_page(sbi, inode->i_ino);
> +       ipage =3D f2fs_get_inode_page(sbi, inode->i_ino);
>         if (IS_ERR(ipage)) {
>                 err =3D PTR_ERR(ipage);
>                 goto out;
> diff --git a/fs/f2fs/inline.c b/fs/f2fs/inline.c
> index 3e3c35d4c98b..ad92e9008781 100644
> --- a/fs/f2fs/inline.c
> +++ b/fs/f2fs/inline.c
> @@ -119,7 +119,7 @@ int f2fs_read_inline_data(struct inode *inode, struct=
 folio *folio)
>  {
>         struct page *ipage;
>
> -       ipage =3D f2fs_get_node_page(F2FS_I_SB(inode), inode->i_ino);
> +       ipage =3D f2fs_get_inode_page(F2FS_I_SB(inode), inode->i_ino);
>         if (IS_ERR(ipage)) {
>                 folio_unlock(folio);
>                 return PTR_ERR(ipage);
> @@ -237,7 +237,7 @@ int f2fs_convert_inline_inode(struct inode *inode)
>
>         f2fs_lock_op(sbi);
>
> -       ipage =3D f2fs_get_node_page(sbi, inode->i_ino);
> +       ipage =3D f2fs_get_inode_page(sbi, inode->i_ino);
>         if (IS_ERR(ipage)) {
>                 err =3D PTR_ERR(ipage);
>                 goto out;
> @@ -265,7 +265,7 @@ int f2fs_write_inline_data(struct inode *inode, struc=
t folio *folio)
>         struct f2fs_sb_info *sbi =3D F2FS_I_SB(inode);
>         struct page *ipage;
>
> -       ipage =3D f2fs_get_node_page(sbi, inode->i_ino);
> +       ipage =3D f2fs_get_inode_page(sbi, inode->i_ino);
>         if (IS_ERR(ipage))
>                 return PTR_ERR(ipage);
>
> @@ -312,7 +312,7 @@ int f2fs_recover_inline_data(struct inode *inode, str=
uct page *npage)
>         if (f2fs_has_inline_data(inode) &&
>                         ri && (ri->i_inline & F2FS_INLINE_DATA)) {
>  process_inline:
> -               ipage =3D f2fs_get_node_page(sbi, inode->i_ino);
> +               ipage =3D f2fs_get_inode_page(sbi, inode->i_ino);
>                 if (IS_ERR(ipage))
>                         return PTR_ERR(ipage);
>
> @@ -331,7 +331,7 @@ int f2fs_recover_inline_data(struct inode *inode, str=
uct page *npage)
>         }
>
>         if (f2fs_has_inline_data(inode)) {
> -               ipage =3D f2fs_get_node_page(sbi, inode->i_ino);
> +               ipage =3D f2fs_get_inode_page(sbi, inode->i_ino);
>                 if (IS_ERR(ipage))
>                         return PTR_ERR(ipage);
>                 f2fs_truncate_inline_inode(inode, ipage, 0);
> @@ -361,7 +361,7 @@ struct f2fs_dir_entry *f2fs_find_in_inline_dir(struct=
 inode *dir,
>         struct page *ipage;
>         void *inline_dentry;
>
> -       ipage =3D f2fs_get_node_page(sbi, dir->i_ino);
> +       ipage =3D f2fs_get_inode_page(sbi, dir->i_ino);
>         if (IS_ERR(ipage)) {
>                 *res_page =3D ipage;
>                 return NULL;
> @@ -609,7 +609,7 @@ int f2fs_try_convert_inline_dir(struct inode *dir, st=
ruct dentry *dentry)
>         if (err)
>                 goto out;
>
> -       ipage =3D f2fs_get_node_page(sbi, dir->i_ino);
> +       ipage =3D f2fs_get_inode_page(sbi, dir->i_ino);
>         if (IS_ERR(ipage)) {
>                 err =3D PTR_ERR(ipage);
>                 goto out_fname;
> @@ -644,7 +644,7 @@ int f2fs_add_inline_entry(struct inode *dir, const st=
ruct f2fs_filename *fname,
>         struct page *page =3D NULL;
>         int err =3D 0;
>
> -       ipage =3D f2fs_get_node_page(sbi, dir->i_ino);
> +       ipage =3D f2fs_get_inode_page(sbi, dir->i_ino);
>         if (IS_ERR(ipage))
>                 return PTR_ERR(ipage);
>
> @@ -734,7 +734,7 @@ bool f2fs_empty_inline_dir(struct inode *dir)
>         void *inline_dentry;
>         struct f2fs_dentry_ptr d;
>
> -       ipage =3D f2fs_get_node_page(sbi, dir->i_ino);
> +       ipage =3D f2fs_get_inode_page(sbi, dir->i_ino);
>         if (IS_ERR(ipage))
>                 return false;
>
> @@ -765,7 +765,7 @@ int f2fs_read_inline_dir(struct file *file, struct di=
r_context *ctx,
>         if (ctx->pos =3D=3D d.max)
>                 return 0;
>
> -       ipage =3D f2fs_get_node_page(F2FS_I_SB(inode), inode->i_ino);
> +       ipage =3D f2fs_get_inode_page(F2FS_I_SB(inode), inode->i_ino);
>         if (IS_ERR(ipage))
>                 return PTR_ERR(ipage);
>
> @@ -797,7 +797,7 @@ int f2fs_inline_data_fiemap(struct inode *inode,
>         struct page *ipage;
>         int err =3D 0;
>
> -       ipage =3D f2fs_get_node_page(F2FS_I_SB(inode), inode->i_ino);
> +       ipage =3D f2fs_get_inode_page(F2FS_I_SB(inode), inode->i_ino);
>         if (IS_ERR(ipage))
>                 return PTR_ERR(ipage);
>
> diff --git a/fs/f2fs/inode.c b/fs/f2fs/inode.c
> index 6aec752ac098..aa2f41696a88 100644
> --- a/fs/f2fs/inode.c
> +++ b/fs/f2fs/inode.c
> @@ -410,7 +410,7 @@ static int do_read_inode(struct inode *inode)
>         if (f2fs_check_nid_range(sbi, inode->i_ino))
>                 return -EINVAL;
>
> -       node_page =3D f2fs_get_node_page(sbi, inode->i_ino);
> +       node_page =3D f2fs_get_inode_page(sbi, inode->i_ino);
>         if (IS_ERR(node_page))
>                 return PTR_ERR(node_page);
>
> @@ -757,7 +757,7 @@ void f2fs_update_inode_page(struct inode *inode)
>         struct page *node_page;
>         int count =3D 0;
>  retry:
> -       node_page =3D f2fs_get_node_page(sbi, inode->i_ino);
> +       node_page =3D f2fs_get_inode_page(sbi, inode->i_ino);
>         if (IS_ERR(node_page)) {
>                 int err =3D PTR_ERR(node_page);
>
> diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
> index 36614a1c2590..ee5daa6f7408 100644
> --- a/fs/f2fs/node.c
> +++ b/fs/f2fs/node.c
> @@ -778,7 +778,7 @@ int f2fs_get_dnode_of_data(struct dnode_of_data *dn, =
pgoff_t index, int mode)
>         npage[0] =3D dn->inode_page;
>
>         if (!npage[0]) {
> -               npage[0] =3D f2fs_get_node_page(sbi, nids[0]);
> +               npage[0] =3D f2fs_get_inode_page(sbi, nids[0]);
>                 if (IS_ERR(npage[0]))
>                         return PTR_ERR(npage[0]);
>         }
> @@ -1147,7 +1147,7 @@ int f2fs_truncate_inode_blocks(struct inode *inode,=
 pgoff_t from)
>                 return level;
>         }
>
> -       folio =3D f2fs_get_node_folio(sbi, inode->i_ino);
> +       folio =3D f2fs_get_inode_folio(sbi, inode->i_ino);
>         if (IS_ERR(folio)) {
>                 trace_f2fs_truncate_inode_blocks_exit(inode, PTR_ERR(foli=
o));
>                 return PTR_ERR(folio);
> @@ -1456,8 +1456,27 @@ void f2fs_ra_node_page(struct f2fs_sb_info *sbi, n=
id_t nid)
>         f2fs_put_page(apage, err ? 1 : 0);
>  }
>
> +static int sanity_check_node_footer(struct f2fs_sb_info *sbi,
> +                                       struct page *page, pgoff_t nid,
> +                                       enum node_type ntype)
> +{
> +       if (unlikely(nid !=3D nid_of_node(page) ||
> +               (ntype =3D=3D NODE_TYPE_INODE && !IS_INODE(page)))) {
> +               f2fs_warn(sbi, "inconsistent node block, node_type:%d, ni=
d:%lu, "
> +                         "node_footer[nid:%u,ino:%u,ofs:%u,cpver:%llu,bl=
kaddr:%u]",
> +                         ntype, nid, nid_of_node(page), ino_of_node(page=
),
> +                         ofs_of_node(page), cpver_of_node(page),
> +                         next_blkaddr_of_node(page));
> +               set_sbi_flag(sbi, SBI_NEED_FSCK);
> +               f2fs_handle_error(sbi, ERROR_INCONSISTENT_FOOTER);
> +               return -EFSCORRUPTED;
> +       }
> +       return 0;
> +}
> +
>  static struct folio *__get_node_folio(struct f2fs_sb_info *sbi, pgoff_t =
nid,
> -                                       struct page *parent, int start)
> +                                       struct page *parent, int start,
> +                                       enum node_type ntype)
>  {
>         struct folio *folio;
>         int err;
> @@ -1499,16 +1518,9 @@ static struct folio *__get_node_folio(struct f2fs_=
sb_info *sbi, pgoff_t nid,
>                 goto out_err;
>         }
>  page_hit:
> -       if (likely(nid =3D=3D nid_of_node(&folio->page)))
> +       err =3D sanity_check_node_footer(sbi, &folio->page, nid, ntype);
> +       if (!err)
>                 return folio;
> -
> -       f2fs_warn(sbi, "inconsistent node block, nid:%lu, node_footer[nid=
:%u,ino:%u,ofs:%u,cpver:%llu,blkaddr:%u]",
> -                         nid, nid_of_node(&folio->page), ino_of_node(&fo=
lio->page),
> -                         ofs_of_node(&folio->page), cpver_of_node(&folio=
->page),
> -                         next_blkaddr_of_node(&folio->page));
> -       set_sbi_flag(sbi, SBI_NEED_FSCK);
> -       f2fs_handle_error(sbi, ERROR_INCONSISTENT_FOOTER);
> -       err =3D -EFSCORRUPTED;
>  out_err:
>         folio_clear_uptodate(folio);
>  out_put_err:
> @@ -1519,14 +1531,22 @@ static struct folio *__get_node_folio(struct f2fs=
_sb_info *sbi, pgoff_t nid,
>         return ERR_PTR(err);
>  }
>
> -struct folio *f2fs_get_node_folio(struct f2fs_sb_info *sbi, pgoff_t nid)
> +struct page *f2fs_get_node_page(struct f2fs_sb_info *sbi, pgoff_t nid)
> +{
> +       struct folio *folio =3D __get_node_folio(sbi, nid, NULL, 0,
> +                                               NODE_TYPE_REGULAR);
> +
> +       return &folio->page;
> +}
> +
> +struct folio *f2fs_get_inode_folio(struct f2fs_sb_info *sbi, pgoff_t ino=
)
>  {
> -       return __get_node_folio(sbi, nid, NULL, 0);
> +       return __get_node_folio(sbi, ino, NULL, 0, NODE_TYPE_REGULAR);
Hi Chao,
here should  return __get_node_folio(sbi, ino, NULL, 0, NODE_TYPE_INODE); ?
thanks=EF=BC=81
>  }
>
> -struct page *f2fs_get_node_page(struct f2fs_sb_info *sbi, pgoff_t nid)
> +struct page *f2fs_get_inode_page(struct f2fs_sb_info *sbi, pgoff_t ino)
>  {
> -       struct folio *folio =3D __get_node_folio(sbi, nid, NULL, 0);
> +       struct folio *folio =3D f2fs_get_inode_folio(sbi, ino);
>
>         return &folio->page;
>  }
> @@ -1535,7 +1555,8 @@ struct page *f2fs_get_node_page_ra(struct page *par=
ent, int start)
>  {
>         struct f2fs_sb_info *sbi =3D F2FS_P_SB(parent);
>         nid_t nid =3D get_nid(parent, start, false);
> -       struct folio *folio =3D __get_node_folio(sbi, nid, parent, start)=
;
> +       struct folio *folio =3D __get_node_folio(sbi, nid, parent, start,
> +                                                       NODE_TYPE_REGULAR=
);
>
>         return &folio->page;
>  }
> @@ -2727,7 +2748,7 @@ int f2fs_recover_inline_xattr(struct inode *inode, =
struct page *page)
>         struct page *ipage;
>         struct f2fs_inode *ri;
>
> -       ipage =3D f2fs_get_node_page(F2FS_I_SB(inode), inode->i_ino);
> +       ipage =3D f2fs_get_inode_page(F2FS_I_SB(inode), inode->i_ino);
>         if (IS_ERR(ipage))
>                 return PTR_ERR(ipage);
>
> diff --git a/fs/f2fs/node.h b/fs/f2fs/node.h
> index 281d53c95c9a..5079c6a2298d 100644
> --- a/fs/f2fs/node.h
> +++ b/fs/f2fs/node.h
> @@ -52,6 +52,12 @@ enum {
>         IS_PREALLOC,            /* nat entry is preallocated */
>  };
>
> +/* For node type in __get_node_folio() */
> +enum node_type {
> +       NODE_TYPE_REGULAR,
> +       NODE_TYPE_INODE,
> +};
> +
>  /*
>   * For node information
>   */
> diff --git a/fs/f2fs/xattr.c b/fs/f2fs/xattr.c
> index 3f3874943679..d5b42e1005d8 100644
> --- a/fs/f2fs/xattr.c
> +++ b/fs/f2fs/xattr.c
> @@ -282,7 +282,7 @@ static int read_inline_xattr(struct inode *inode, str=
uct page *ipage,
>         if (ipage) {
>                 inline_addr =3D inline_xattr_addr(inode, ipage);
>         } else {
> -               page =3D f2fs_get_node_page(sbi, inode->i_ino);
> +               page =3D f2fs_get_inode_page(sbi, inode->i_ino);
>                 if (IS_ERR(page))
>                         return PTR_ERR(page);
>
> @@ -449,7 +449,7 @@ static inline int write_all_xattrs(struct inode *inod=
e, __u32 hsize,
>                 if (ipage) {
>                         inline_addr =3D inline_xattr_addr(inode, ipage);
>                 } else {
> -                       in_page =3D f2fs_get_node_page(sbi, inode->i_ino)=
;
> +                       in_page =3D f2fs_get_inode_page(sbi, inode->i_ino=
);
>                         if (IS_ERR(in_page)) {
>                                 f2fs_alloc_nid_failed(sbi, new_nid);
>                                 return PTR_ERR(in_page);
> --
> 2.48.1
>
>
>
> _______________________________________________
> Linux-f2fs-devel mailing list
> Linux-f2fs-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

