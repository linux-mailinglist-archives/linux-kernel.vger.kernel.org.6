Return-Path: <linux-kernel+bounces-359684-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B9072998F12
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 19:58:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 21C14B2488C
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 17:56:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B4861C9DE6;
	Thu, 10 Oct 2024 17:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eGKN+EoG"
Received: from mail-vs1-f45.google.com (mail-vs1-f45.google.com [209.85.217.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4199F1CCB45
	for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 17:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728582983; cv=none; b=ib4iO6SLQ5vPxmdFHFRp0CWvsI8H4XWTo9WsFUHeVt/bfYU0axuwr+iV/4bl/KD1MZUeENdrzmfiS4NQ9BhAa43DZKWgbt0jHKCUC/pBTmam5ognPg2VS3dqrVGlxn2uUupFYuMXrPaJfgq/8oEEVeUENWzA+SYOcBp6nHz77BU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728582983; c=relaxed/simple;
	bh=UvbbczA99RAMdKk5BZy3MTYcDBXgxFqwciBMwrY6Kgs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bBgkFntTOOso2rXRkAeFsuMdsqPtm4qEdH8ivfcZOWIER/DTAvrXbph/juDkfmYXjU9dSiVoFthARGJGoEMLgH/Xk65enG+uzrDwYin8L2CGPDnn8te9mGjGyje1VKrxitoUmAIa1xuSSfW9vZvxH4cDS+3onHttcqxgjr5dVvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eGKN+EoG; arc=none smtp.client-ip=209.85.217.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f45.google.com with SMTP id ada2fe7eead31-4a28a1ae1adso434180137.3
        for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 10:56:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728582980; x=1729187780; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9oI7sXwcI5GGl64ZskRdmNIT9Y3FO2iiGenfuWdCwmc=;
        b=eGKN+EoG6CShmEdY8SVpSh2D3TfVRnTMUdnPx3n+ELQEF0FgaJXaAUc5yBSJlHFfAZ
         p36i6OORkGhmzz3ZKsnlim/JZKVJbidjrFau5oWplb4Itm+MyXon+xGBBDFwfb1p/3KJ
         2uQ7LJCURf3kkPjKa9628UmK413KtXTaj7aYPV3QEUJj9JRKtAi6KsB+FQjb9HR/W9If
         LGie+6wKyod6ER0DFxUyjl8yk+jZv0EhxZKqsAuK8TEAHpWOeokOSF6Wb4j5MccWtk2T
         IBfpsji+jK1mwapZfXZXr+mIFohRmU3pvJwHLctGlpSxU0scoMJHK9QahO5XSp4wEeXz
         qSEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728582980; x=1729187780;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9oI7sXwcI5GGl64ZskRdmNIT9Y3FO2iiGenfuWdCwmc=;
        b=uLTi7/+8POMKP2RVVJEwZ6SSNSAHycoWwLNdbZZTI+Tuw5IlburyPMNa5QI0Q/W7gh
         n98HM+Vz0ZEw40h02A4+hTwpcE+eAwdKgyy7IIhIliKWmawhIK65qU1umnfIEsLUpoQ/
         unw3WTwI2kfELR4ILm5ZnZ3NHsp9CaLFAu3tVz9P0NKDrd89N2GaRsd9of770CBfx22J
         oPNB6fupfVggp7IHO5nOM8ylNbRUBQ9boSSZQnSwu+6xCg6K4+/5z/qqbvWQAYdEITSt
         wX6RWUcOy5QzjyM9GT/SrLJGukM6pvUZuhJG7oogWB8vTV2Jww/WLcDLVtfDmr/pd/bd
         L33Q==
X-Gm-Message-State: AOJu0YxEIVgwAT0ywnOxioQjag89+SKZ92/kTJtBUEX4FqYmOOJwHKAC
	YzrC4qN6j8olvUE7rijt3gjSM5cdmg9b3xt9JKmNRDfRjUGAQueWJ9htYeNXfqMTi6YfKA8EwIG
	fKkklydmgEzQ3LFjiGn4s1Eh2kjq7Rw==
X-Google-Smtp-Source: AGHT+IHsPG3nlkAPqqwDwkDQ577ENaApjiV+DQ/9M6qom7cmAnXsvKPVK26EhXz4TDZttz61YZqrCYGspswGIzM6fOU=
X-Received: by 2002:a05:6102:2ac1:b0:4a3:e3f5:2766 with SMTP id
 ada2fe7eead31-4a463879f93mr316766137.16.1728582979840; Thu, 10 Oct 2024
 10:56:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241008180515.3198262-1-daeho43@gmail.com> <ed77a5ab-d572-42d7-b9db-b5f13717e083@kernel.org>
In-Reply-To: <ed77a5ab-d572-42d7-b9db-b5f13717e083@kernel.org>
From: Daeho Jeong <daeho43@gmail.com>
Date: Thu, 10 Oct 2024 10:56:08 -0700
Message-ID: <CACOAw_xErajS5y7=Pi6z+ppnGrw0DWUhojkENJCWzH437GTOPg@mail.gmail.com>
Subject: Re: [PATCH v4] f2fs: introduce device aliasing file
To: Chao Yu <chao@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, 
	kernel-team@android.com, Daeho Jeong <daehojeong@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 8, 2024 at 7:32=E2=80=AFPM Chao Yu <chao@kernel.org> wrote:
>
> On 2024/10/9 2:05, Daeho Jeong wrote:
> > From: Daeho Jeong <daehojeong@google.com>
> >
> > F2FS should understand how the device aliasing file works and support
> > deleting the file after use. A device aliasing file can be created by
> > mkfs.f2fs tool and it can map the whole device with an extrent, not
> > using node blocks. The file space should be pinned and normally used fo=
r
> > read-only usages.
> >
> > Signed-off-by: Daeho Jeong <daehojeong@google.com>
> > Signed-off-by: Chao Yu <chao@kernel.org>
> > ---
> > v4: added file pinning check in sanity check
> > v3: merged Chao's extent cache sanity check.
> >      prevented device aliasing support with noextent mount option
> > v2: changed the position of f2fs_destroy_extent_tree() only for device
> >      aliasing files
> > ---
> >   fs/f2fs/data.c         |  5 +++++
> >   fs/f2fs/extent_cache.c | 45 +++++++++++++++++++++++++++++++++++++++++=
-
> >   fs/f2fs/f2fs.h         |  5 +++++
> >   fs/f2fs/file.c         | 36 +++++++++++++++++++++++++++++----
> >   fs/f2fs/inode.c        | 19 +++++++++++++++++-
> >   fs/f2fs/super.c        |  4 ++++
> >   fs/f2fs/sysfs.c        |  2 ++
> >   7 files changed, 110 insertions(+), 6 deletions(-)
> >
> > diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
> > index b94cf6eea2f9..385b46e62ede 100644
> > --- a/fs/f2fs/data.c
> > +++ b/fs/f2fs/data.c
> > @@ -3441,6 +3441,11 @@ static int prepare_write_begin(struct f2fs_sb_in=
fo *sbi,
> >
> >       if (!f2fs_lookup_read_extent_cache_block(inode, index,
> >                                                &dn.data_blkaddr)) {
> > +             if (IS_DEVICE_ALIASING(inode)) {
> > +                     err =3D -ENODATA;
> > +                     goto out;
> > +             }
> > +
> >               if (locked) {
> >                       err =3D f2fs_reserve_block(&dn, index);
> >                       goto out;
> > diff --git a/fs/f2fs/extent_cache.c b/fs/f2fs/extent_cache.c
> > index 62ac440d9416..019c1f7b7fa5 100644
> > --- a/fs/f2fs/extent_cache.c
> > +++ b/fs/f2fs/extent_cache.c
> > @@ -24,6 +24,7 @@ bool sanity_check_extent_cache(struct inode *inode, s=
truct page *ipage)
> >       struct f2fs_sb_info *sbi =3D F2FS_I_SB(inode);
> >       struct f2fs_extent *i_ext =3D &F2FS_INODE(ipage)->i_ext;
> >       struct extent_info ei;
> > +     int devi;
> >
> >       get_read_extent_info(&ei, i_ext);
> >
> > @@ -38,7 +39,36 @@ bool sanity_check_extent_cache(struct inode *inode, =
struct page *ipage)
> >                         ei.blk, ei.fofs, ei.len);
> >               return false;
> >       }
> > -     return true;
> > +
> > +     if (!IS_DEVICE_ALIASING(inode))
> > +             return true;
> > +
> > +     for (devi =3D 0; devi < sbi->s_ndevs; devi++) {
> > +             if (FDEV(devi).start_blk !=3D ei.blk ||
> > +                             FDEV(devi).end_blk !=3D ei.blk + ei.len -=
 1)
> > +                     continue;
> > +
> > +             if (devi =3D=3D 0) {
> > +                     f2fs_warn(sbi,
> > +                         "%s: inode (ino=3D%lx) is an alias of meta de=
vice",
> > +                         __func__, inode->i_ino);
> > +                     return false;
> > +             }
> > +
> > +             if (bdev_is_zoned(FDEV(devi).bdev)) {
> > +                     f2fs_warn(sbi,
> > +                         "%s: device alias inode (ino=3D%lx)'s extent =
info "
> > +                         "[%u, %u, %u] maps to zoned block device",
> > +                         __func__, inode->i_ino, ei.blk, ei.fofs, ei.l=
en);
> > +                     return false;
> > +             }
> > +             return true;
> > +     }
> > +
> > +     f2fs_warn(sbi, "%s: device alias inode (ino=3D%lx)'s extent info =
"
> > +                     "[%u, %u, %u] is inconsistent w/ any devices",
> > +                     __func__, inode->i_ino, ei.blk, ei.fofs, ei.len);
> > +     return false;
> >   }
> >
> >   static void __set_extent_info(struct extent_info *ei,
> > @@ -76,6 +106,9 @@ static bool __init_may_extent_tree(struct inode *ino=
de, enum extent_type type)
> >
> >   static bool __may_extent_tree(struct inode *inode, enum extent_type t=
ype)
> >   {
> > +     if (IS_DEVICE_ALIASING(inode) && type =3D=3D EX_READ)
> > +             return true;
> > +
> >       /*
> >        * for recovered files during mount do not create extents
> >        * if shrinker is not registered.
> > @@ -401,6 +434,11 @@ void f2fs_init_read_extent_tree(struct inode *inod=
e, struct page *ipage)
> >       if (atomic_read(&et->node_cnt) || !ei.len)
> >               goto skip;
> >
> > +     if (IS_DEVICE_ALIASING(inode)) {
> > +             et->largest =3D ei;
> > +             goto skip;
> > +     }
> > +
> >       en =3D __attach_extent_node(sbi, et, &ei, NULL,
> >                               &et->root.rb_root.rb_node, true);
> >       if (en) {
> > @@ -463,6 +501,11 @@ static bool __lookup_extent_tree(struct inode *ino=
de, pgoff_t pgofs,
> >               goto out;
> >       }
> >
> > +     if (IS_DEVICE_ALIASING(inode)) {
> > +             ret =3D false;
> > +             goto out;
> > +     }
> > +
> >       en =3D __lookup_extent_node(&et->root, et->cached_en, pgofs);
> >       if (!en)
> >               goto out;
> > diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> > index 33f5449dc22d..b6ba22a1da47 100644
> > --- a/fs/f2fs/f2fs.h
> > +++ b/fs/f2fs/f2fs.h
> > @@ -213,6 +213,7 @@ struct f2fs_mount_info {
> >   #define F2FS_FEATURE_CASEFOLD                       0x00001000
> >   #define F2FS_FEATURE_COMPRESSION            0x00002000
> >   #define F2FS_FEATURE_RO                             0x00004000
> > +#define F2FS_FEATURE_DEVICE_ALIAS            0x00008000
> >
> >   #define __F2FS_HAS_FEATURE(raw_super, mask)                         \
> >       ((raw_super->feature & cpu_to_le32(mask)) !=3D 0)
> > @@ -3046,6 +3047,7 @@ static inline void f2fs_change_bit(unsigned int n=
r, char *addr)
> >   #define F2FS_DIRSYNC_FL                     0x00010000 /* dirsync beh=
aviour (directories only) */
> >   #define F2FS_PROJINHERIT_FL         0x20000000 /* Create with parents=
 projid */
> >   #define F2FS_CASEFOLD_FL            0x40000000 /* Casefolded file */
> > +#define F2FS_DEVICE_ALIAS_FL         0x80000000 /* File for aliasing a=
 device */
>
> Is there any way to know which inode is device-alias one? maybe
> we can export this flag to userspace via .fileattr_get? or via
> newly introduced ioctl interface?

Right, we need to add a new ioctl interface to get the flag.
Let me take care of this.

Thanks,

>
> >
> >   #define F2FS_QUOTA_DEFAULT_FL               (F2FS_NOATIME_FL | F2FS_I=
MMUTABLE_FL)
> >
> > @@ -3061,6 +3063,8 @@ static inline void f2fs_change_bit(unsigned int n=
r, char *addr)
> >   /* Flags that are appropriate for non-directories/regular files. */
> >   #define F2FS_OTHER_FLMASK   (F2FS_NODUMP_FL | F2FS_NOATIME_FL)
> >
> > +#define IS_DEVICE_ALIASING(inode)    (F2FS_I(inode)->i_flags & F2FS_DE=
VICE_ALIAS_FL)
> > +
> >   static inline __u32 f2fs_mask_flags(umode_t mode, __u32 flags)
> >   {
> >       if (S_ISDIR(mode))
> > @@ -4510,6 +4514,7 @@ F2FS_FEATURE_FUNCS(sb_chksum, SB_CHKSUM);
> >   F2FS_FEATURE_FUNCS(casefold, CASEFOLD);
> >   F2FS_FEATURE_FUNCS(compression, COMPRESSION);
> >   F2FS_FEATURE_FUNCS(readonly, RO);
> > +F2FS_FEATURE_FUNCS(device_alias, DEVICE_ALIAS);
> >
> >   #ifdef CONFIG_BLK_DEV_ZONED
> >   static inline bool f2fs_blkz_is_seq(struct f2fs_sb_info *sbi, int dev=
i,
> > diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
> > index 99903eafa7fe..f2d2d84d025b 100644
> > --- a/fs/f2fs/file.c
> > +++ b/fs/f2fs/file.c
> > @@ -725,6 +725,11 @@ int f2fs_do_truncate_blocks(struct inode *inode, u=
64 from, bool lock)
> >
> >       trace_f2fs_truncate_blocks_enter(inode, from);
> >
> > +     if (IS_DEVICE_ALIASING(inode) && from) {
> > +             err =3D -EINVAL;
> > +             goto out_err;
> > +     }
> > +
> >       free_from =3D (pgoff_t)F2FS_BLK_ALIGN(from);
> >
> >       if (free_from >=3D max_file_blocks(inode))
> > @@ -739,6 +744,21 @@ int f2fs_do_truncate_blocks(struct inode *inode, u=
64 from, bool lock)
> >               goto out;
> >       }
> >
> > +     if (IS_DEVICE_ALIASING(inode)) {
> > +             struct extent_tree *et =3D F2FS_I(inode)->extent_tree[EX_=
READ];
> > +             struct extent_info ei =3D et->largest;
> > +             unsigned int i;
> > +
> > +             for (i =3D 0; i < ei.len; i++)
> > +                     f2fs_invalidate_blocks(sbi, ei.blk + i);
> > +
> > +             dec_valid_block_count(sbi, inode, ei.len);
> > +             f2fs_update_time(sbi, REQ_TIME);
> > +
> > +             f2fs_put_page(ipage, 1);
> > +             goto out;
> > +     }
> > +
> >       if (f2fs_has_inline_data(inode)) {
> >               f2fs_truncate_inline_inode(inode, ipage, from);
> >               f2fs_put_page(ipage, 1);
> > @@ -774,7 +794,7 @@ int f2fs_do_truncate_blocks(struct inode *inode, u6=
4 from, bool lock)
> >       /* lastly zero out the first data page */
> >       if (!err)
> >               err =3D truncate_partial_data_page(inode, from, truncate_=
page);
> > -
> > +out_err:
> >       trace_f2fs_truncate_blocks_exit(inode, err);
> >       return err;
> >   }
> > @@ -992,7 +1012,8 @@ int f2fs_setattr(struct mnt_idmap *idmap, struct d=
entry *dentry,
> >               return -EPERM;
> >
> >       if ((attr->ia_valid & ATTR_SIZE)) {
> > -             if (!f2fs_is_compress_backend_ready(inode))
> > +             if (!f2fs_is_compress_backend_ready(inode) ||
> > +                             IS_DEVICE_ALIASING(inode))
> >                       return -EOPNOTSUPP;
> >               if (is_inode_flag_set(inode, FI_COMPRESS_RELEASED) &&
> >                       !IS_ALIGNED(attr->ia_size,
> > @@ -1860,7 +1881,7 @@ static long f2fs_fallocate(struct file *file, int=
 mode,
> >               return -EIO;
> >       if (!f2fs_is_checkpoint_ready(F2FS_I_SB(inode)))
> >               return -ENOSPC;
> > -     if (!f2fs_is_compress_backend_ready(inode))
> > +     if (!f2fs_is_compress_backend_ready(inode) || IS_DEVICE_ALIASING(=
inode))
> >               return -EOPNOTSUPP;
> >
> >       /* f2fs only support ->fallocate for regular file */
> > @@ -3296,6 +3317,9 @@ int f2fs_pin_file_control(struct inode *inode, bo=
ol inc)
> >       struct f2fs_inode_info *fi =3D F2FS_I(inode);
> >       struct f2fs_sb_info *sbi =3D F2FS_I_SB(inode);
> >
> > +     if (IS_DEVICE_ALIASING(inode))
> > +             return -EINVAL;
> > +
> >       if (fi->i_gc_failures >=3D sbi->gc_pin_file_threshold) {
> >               f2fs_warn(sbi, "%s: Enable GC =3D ino %lx after %x GC tri=
als",
> >                         __func__, inode->i_ino, fi->i_gc_failures);
> > @@ -3326,6 +3350,9 @@ static int f2fs_ioc_set_pin_file(struct file *fil=
p, unsigned long arg)
> >       if (f2fs_readonly(sbi->sb))
> >               return -EROFS;
> >
> > +     if (!pin && IS_DEVICE_ALIASING(inode))
> > +             return -EOPNOTSUPP;
> > +
> >       ret =3D mnt_want_write_file(filp);
> >       if (ret)
> >               return ret;
> > @@ -4764,7 +4791,8 @@ static int f2fs_preallocate_blocks(struct kiocb *=
iocb, struct iov_iter *iter,
> >       else
> >               return 0;
> >
> > -     map.m_may_create =3D true;
> > +     if (!IS_DEVICE_ALIASING(inode))
> > +             map.m_may_create =3D true;
> >       if (dio) {
> >               map.m_seg_type =3D f2fs_rw_hint_to_seg_type(sbi,
> >                                               inode->i_write_hint);
> > diff --git a/fs/f2fs/inode.c b/fs/f2fs/inode.c
> > index 1ed86df343a5..e2d30fc79644 100644
> > --- a/fs/f2fs/inode.c
> > +++ b/fs/f2fs/inode.c
> > @@ -372,6 +372,19 @@ static bool sanity_check_inode(struct inode *inode=
, struct page *node_page)
> >               return false;
> >       }
> >
> > +     if (fi->i_flags & F2FS_DEVICE_ALIAS_FL) {
>
> Trivial cleanup.
>
> IS_DEVICE_ALIASING(inode)
>
> Thanks,
>
> > +             if (!f2fs_sb_has_device_alias(sbi)) {
> > +                     f2fs_warn(sbi, "%s: inode (ino=3D%lx) has device =
alias flag, but the feature is off",
> > +                               __func__, inode->i_ino);
> > +                     return false;
> > +             }
> > +             if (!f2fs_is_pinned_file(inode)) {
> > +                     f2fs_warn(sbi, "%s: inode (ino=3D%lx) has device =
alias flag, but is not pinned",
> > +                               __func__, inode->i_ino);
> > +                     return false;
> > +             }
> > +     }
> > +
> >       return true;
> >   }
> >
> > @@ -823,7 +836,8 @@ void f2fs_evict_inode(struct inode *inode)
> >       f2fs_bug_on(sbi, get_dirty_pages(inode));
> >       f2fs_remove_dirty_inode(inode);
> >
> > -     f2fs_destroy_extent_tree(inode);
> > +     if (!IS_DEVICE_ALIASING(inode))
> > +             f2fs_destroy_extent_tree(inode);
> >
> >       if (inode->i_nlink || is_bad_inode(inode))
> >               goto no_delete;
> > @@ -879,6 +893,9 @@ void f2fs_evict_inode(struct inode *inode)
> >               goto retry;
> >       }
> >
> > +     if (IS_DEVICE_ALIASING(inode))
> > +             f2fs_destroy_extent_tree(inode);
> > +
> >       if (err) {
> >               f2fs_update_inode_page(inode);
> >               if (dquot_initialize_needed(inode))
> > diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
> > index fc2c586c7619..95097498b544 100644
> > --- a/fs/f2fs/super.c
> > +++ b/fs/f2fs/super.c
> > @@ -834,6 +834,10 @@ static int parse_options(struct super_block *sb, c=
har *options, bool is_remount)
> >                       set_opt(sbi, READ_EXTENT_CACHE);
> >                       break;
> >               case Opt_noextent_cache:
> > +                     if (F2FS_HAS_FEATURE(sbi, F2FS_FEATURE_DEVICE_ALI=
AS)) {
> > +                             f2fs_err(sbi, "device aliasing requires e=
xtent cache");
> > +                             return -EINVAL;
> > +                     }
> >                       clear_opt(sbi, READ_EXTENT_CACHE);
> >                       break;
> >               case Opt_noinline_data:
> > diff --git a/fs/f2fs/sysfs.c b/fs/f2fs/sysfs.c
> > index c56e8c873935..e51304bc65ea 100644
> > --- a/fs/f2fs/sysfs.c
> > +++ b/fs/f2fs/sysfs.c
> > @@ -1313,6 +1313,7 @@ F2FS_SB_FEATURE_RO_ATTR(sb_checksum, SB_CHKSUM);
> >   F2FS_SB_FEATURE_RO_ATTR(casefold, CASEFOLD);
> >   F2FS_SB_FEATURE_RO_ATTR(compression, COMPRESSION);
> >   F2FS_SB_FEATURE_RO_ATTR(readonly, RO);
> > +F2FS_SB_FEATURE_RO_ATTR(device_alias, DEVICE_ALIAS);
> >
> >   static struct attribute *f2fs_sb_feat_attrs[] =3D {
> >       ATTR_LIST(sb_encryption),
> > @@ -1329,6 +1330,7 @@ static struct attribute *f2fs_sb_feat_attrs[] =3D=
 {
> >       ATTR_LIST(sb_casefold),
> >       ATTR_LIST(sb_compression),
> >       ATTR_LIST(sb_readonly),
> > +     ATTR_LIST(sb_device_alias),
> >       NULL,
> >   };
> >   ATTRIBUTE_GROUPS(f2fs_sb_feat);
>

