Return-Path: <linux-kernel+bounces-334463-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F95197D793
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2024 17:39:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 41A4BB23302
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2024 15:38:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BCBC17BEC8;
	Fri, 20 Sep 2024 15:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aIgyazMO"
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF0651F16B
	for <linux-kernel@vger.kernel.org>; Fri, 20 Sep 2024 15:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726846731; cv=none; b=ES4F1v8im4K4FQ9TLXjsdJkGCZCoHc3jykrmJ1cLA+VY9kx9/NTzjph0/GSKalQr9k90RYLUmdP56QqybhNFyEcpx1+wLqXhrWTICbxHHlYYGXGo4Z+d8YeLaBmQwkA06zpI5Rett6fAtNymf7Uj4C0/tJlE52fB/h5gFYY3LTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726846731; c=relaxed/simple;
	bh=ErZOL8RUV6uE/tt/emQgP8Vf4iTFDOpig5wwLwOaF70=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=n82z97FHe3BfuxpJAxxQ/Td2O/QYakuqGQ2dggRSo/KQlZ4Ol0o2/s+wlLONgdFqFze9gyiDsgT3Q63L9imsMsGGfdgE8LnWBtHQ67P3g0AvozCvfNzC0L0e+hH4OJ61x2zuLNc64wjhwkhPJahCHm8cmDpVwFQ4cEo063sYn50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aIgyazMO; arc=none smtp.client-ip=209.85.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-710e14e2134so1301482a34.0
        for <linux-kernel@vger.kernel.org>; Fri, 20 Sep 2024 08:38:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726846729; x=1727451529; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rr5KQ5ZLHVOl3Oeu6RlbYVLwrPzOvhWdRLnaEIc3JZ4=;
        b=aIgyazMOJmPk3ARl9+eLhYsPXh4fLv06pprRJIikUisXc8TNPK+9a6s4UmTvIj/jP7
         YidnIEZT27ve5Wf85LaTvsUQrb1Up+2wY7Xqi43o7UYmZukTufXh4heGUpv30BWSXKx4
         5h5n4z9xJYwjox1vHWYukXGquEiSBU7Pp3j7uUXXyPjzlqszLsVfRtzEok8HQJBpGMT1
         dOej1Uapcn77AD9/2dAfT+R8fsVpYw5SKs2om5x+SmbYwAci0zfsQCL1JO1jGONG4oKe
         Grop+FWo0iCWmcu6WPWJigHaH8G6oZPuz4/XARixdLU/ozGfj+qVo/edIiSR8PkMM5qT
         md2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726846729; x=1727451529;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rr5KQ5ZLHVOl3Oeu6RlbYVLwrPzOvhWdRLnaEIc3JZ4=;
        b=CphyPRB3IBxZ1wpqU22QB9DMGGQMW6bIO5CrRVEKMqkYy7P9kCxIEpsE2OufhKUX95
         OhZW0mjibwI2gpijyFDJH9uaSZJLVUiQfEhGlnvwlDXpclqFb+oIz5BtLxoTSPGnVTXC
         WeFN1Lxrh5XnQScxk/S8OjBOyvwi7CmbkVEXsh3B0xw2uW8GDYCb9E+wdPhrDCmE1zTi
         5eWWNGs9qvSisIS3gYV38U6+Ptd/zjkXfw/JHIHrA7JXAOgpm82ESf9Ln4hxEgVVQUyh
         TQonhn8LSDBTws6lI74ImST3fPFUCcVf26KJQPILgNpMi3/+6LDygoBajMOoa1Xr8ul6
         oHZQ==
X-Gm-Message-State: AOJu0YwDQzXrqglhvfwW0ovQLV8GQLf9GKCDN5JvFDMrZ8epdmSyUcWd
	1XhrsgN2nIXnAx//roNe+X/ZtFeQjZzLplItweqUU8BmSb2/L1cg/d9ldhyRg4CE51T3/92L+WX
	aKs0S+p+Ae8zOse407VtLOS8p3lMiuw==
X-Google-Smtp-Source: AGHT+IESIjXuG65digZumlpEH1+LhW2toUCoI59eVJjvC/8VUPASncj02dp31mQsRAYYovpGArB2prI1ATX6X8bBV60=
X-Received: by 2002:a05:6830:648b:b0:710:b13b:ff15 with SMTP id
 46e09a7af769-7139348120dmr2402636a34.6.1726846728712; Fri, 20 Sep 2024
 08:38:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240913212810.912171-1-daeho43@gmail.com> <cef0eeba-6089-44c6-b08e-308f8ee36f6a@kernel.org>
In-Reply-To: <cef0eeba-6089-44c6-b08e-308f8ee36f6a@kernel.org>
From: Daeho Jeong <daeho43@gmail.com>
Date: Fri, 20 Sep 2024 08:38:37 -0700
Message-ID: <CACOAw_xW_UsNLy-j6tySmOLzqR6LDDDCZnpx4Uj8PF=ZTuVRag@mail.gmail.com>
Subject: Re: [f2fs-dev] [PATCH] f2fs: introduce device aliasing file
To: Chao Yu <chao@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, 
	kernel-team@android.com, Daeho Jeong <daehojeong@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 19, 2024 at 6:14=E2=80=AFAM Chao Yu <chao@kernel.org> wrote:
>
> On 2024/9/14 5:28, Daeho Jeong wrote:
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
> > ---
> >   fs/f2fs/data.c         |  5 +++++
> >   fs/f2fs/extent_cache.c | 10 ++++++++++
> >   fs/f2fs/f2fs.h         |  5 +++++
> >   fs/f2fs/file.c         | 36 ++++++++++++++++++++++++++++++++----
> >   fs/f2fs/inode.c        | 10 ++++++++--
> >   fs/f2fs/sysfs.c        |  2 ++
> >   6 files changed, 62 insertions(+), 6 deletions(-)
> >
> > diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
> > index 6457e5bca9c9..9ce92093ba1e 100644
> > --- a/fs/f2fs/data.c
> > +++ b/fs/f2fs/data.c
> > @@ -3423,6 +3423,11 @@ static int prepare_write_begin(struct f2fs_sb_in=
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
> > index fd1fc06359ee..03883963b991 100644
> > --- a/fs/f2fs/extent_cache.c
> > +++ b/fs/f2fs/extent_cache.c
> > @@ -401,6 +401,11 @@ void f2fs_init_read_extent_tree(struct inode *inod=
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
> > @@ -463,6 +468,11 @@ static bool __lookup_extent_tree(struct inode *ino=
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
> > index ac19c61f0c3e..59179b9b3a83 100644
> > --- a/fs/f2fs/f2fs.h
> > +++ b/fs/f2fs/f2fs.h
> > @@ -208,6 +208,7 @@ struct f2fs_mount_info {
> >   #define F2FS_FEATURE_CASEFOLD                       0x00001000
> >   #define F2FS_FEATURE_COMPRESSION            0x00002000
> >   #define F2FS_FEATURE_RO                             0x00004000
> > +#define F2FS_FEATURE_DEVICE_ALIAS            0x00008000
> >
> >   #define __F2FS_HAS_FEATURE(raw_super, mask)                         \
> >       ((raw_super->feature & cpu_to_le32(mask)) !=3D 0)
> > @@ -3001,6 +3002,7 @@ static inline void f2fs_change_bit(unsigned int n=
r, char *addr)
> >   #define F2FS_DIRSYNC_FL                     0x00010000 /* dirsync beh=
aviour (directories only) */
> >   #define F2FS_PROJINHERIT_FL         0x20000000 /* Create with parents=
 projid */
> >   #define F2FS_CASEFOLD_FL            0x40000000 /* Casefolded file */
> > +#define F2FS_DEVICE_ALIAS_FL         0x80000000 /* File for aliasing a=
 device */
> >
> >   #define F2FS_QUOTA_DEFAULT_FL               (F2FS_NOATIME_FL | F2FS_I=
MMUTABLE_FL)
> >
> > @@ -3016,6 +3018,8 @@ static inline void f2fs_change_bit(unsigned int n=
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
> > @@ -4478,6 +4482,7 @@ F2FS_FEATURE_FUNCS(sb_chksum, SB_CHKSUM);
> >   F2FS_FEATURE_FUNCS(casefold, CASEFOLD);
> >   F2FS_FEATURE_FUNCS(compression, COMPRESSION);
> >   F2FS_FEATURE_FUNCS(readonly, RO);
> > +F2FS_FEATURE_FUNCS(device_alias, DEVICE_ALIAS);
> >
> >   #ifdef CONFIG_BLK_DEV_ZONED
> >   static inline bool f2fs_blkz_is_seq(struct f2fs_sb_info *sbi, int dev=
i,
> > diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
> > index 168f08507004..0f4af6b303ff 100644
> > --- a/fs/f2fs/file.c
> > +++ b/fs/f2fs/file.c
> > @@ -727,6 +727,11 @@ int f2fs_do_truncate_blocks(struct inode *inode, u=
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
> > @@ -741,6 +746,21 @@ int f2fs_do_truncate_blocks(struct inode *inode, u=
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
> > @@ -776,7 +796,7 @@ int f2fs_do_truncate_blocks(struct inode *inode, u6=
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
> > @@ -994,7 +1014,8 @@ int f2fs_setattr(struct mnt_idmap *idmap, struct d=
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
> > @@ -1855,7 +1876,7 @@ static long f2fs_fallocate(struct file *file, int=
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
> > @@ -3264,6 +3285,9 @@ int f2fs_pin_file_control(struct inode *inode, bo=
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
> > @@ -3294,6 +3318,9 @@ static int f2fs_ioc_set_pin_file(struct file *fil=
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
> > @@ -4711,7 +4738,8 @@ static int f2fs_preallocate_blocks(struct kiocb *=
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
> > index aef57172014f..f118e955ba88 100644
> > --- a/fs/f2fs/inode.c
> > +++ b/fs/f2fs/inode.c
> > @@ -367,6 +367,12 @@ static bool sanity_check_inode(struct inode *inode=
, struct page *node_page)
> >               return false;
> >       }
> >
> > +     if ((fi->i_flags & F2FS_DEVICE_ALIAS_FL) && !f2fs_sb_has_device_a=
lias(sbi)) {
> > +             f2fs_warn(sbi, "%s: inode (ino=3D%lx) has device alias fl=
ag, but the feature is off",
> > +                       __func__, inode->i_ino);
> > +             return false;
> > +     }
>
> Do we need to do sanity check device_alias feature flag w/
> sb.devs[].path format? and related inode?

Sorry, I am not sure I got your point. Could you elaborate it more?

>
> > +
> >       return true;
> >   }
> >
> > @@ -818,8 +824,6 @@ void f2fs_evict_inode(struct inode *inode)
> >       f2fs_bug_on(sbi, get_dirty_pages(inode));
> >       f2fs_remove_dirty_inode(inode);
> >
> > -     f2fs_destroy_extent_tree(inode);
>
> For hardlink inode, it missed to call f2fs_destroy_extent_tree()?

Got it.

>
> Thanks,
>
> > -
> >       if (inode->i_nlink || is_bad_inode(inode))
> >               goto no_delete;
> >
> > @@ -874,6 +878,8 @@ void f2fs_evict_inode(struct inode *inode)
> >               goto retry;
> >       }
> >
> > +     f2fs_destroy_extent_tree(inode);
> > +
> >       if (err) {
> >               f2fs_update_inode_page(inode);
> >               if (dquot_initialize_needed(inode))
> > diff --git a/fs/f2fs/sysfs.c b/fs/f2fs/sysfs.c
> > index fee7ee45ceaa..bf64f4cc3522 100644
> > --- a/fs/f2fs/sysfs.c
> > +++ b/fs/f2fs/sysfs.c
> > @@ -1281,6 +1281,7 @@ F2FS_SB_FEATURE_RO_ATTR(sb_checksum, SB_CHKSUM);
> >   F2FS_SB_FEATURE_RO_ATTR(casefold, CASEFOLD);
> >   F2FS_SB_FEATURE_RO_ATTR(compression, COMPRESSION);
> >   F2FS_SB_FEATURE_RO_ATTR(readonly, RO);
> > +F2FS_SB_FEATURE_RO_ATTR(device_alias, DEVICE_ALIAS);
> >
> >   static struct attribute *f2fs_sb_feat_attrs[] =3D {
> >       ATTR_LIST(sb_encryption),
> > @@ -1297,6 +1298,7 @@ static struct attribute *f2fs_sb_feat_attrs[] =3D=
 {
> >       ATTR_LIST(sb_casefold),
> >       ATTR_LIST(sb_compression),
> >       ATTR_LIST(sb_readonly),
> > +     ATTR_LIST(sb_device_alias),
> >       NULL,
> >   };
> >   ATTRIBUTE_GROUPS(f2fs_sb_feat);
>

