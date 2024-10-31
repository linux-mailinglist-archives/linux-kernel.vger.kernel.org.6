Return-Path: <linux-kernel+bounces-389905-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BFBB49B72B0
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 04:01:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 437361F24FDD
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 03:01:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2679126BE0;
	Thu, 31 Oct 2024 03:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T6oTfdz7"
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1688D33FD
	for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 03:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730343654; cv=none; b=q/VrbWHPeBBkPL6Yzx/kB9CGgohATmZYIB1LF9gv0MLgaNbkrSa9borVCX5VsJteiN+KMtnnOVTC1C8XwQvDc9tZDhS4LNcm4BBbS+O3mor+llgf0HNcmBj/bWYRndZsX0dVmLjUqUHEI27OG9BOegqekQS1oz0U+DPLHw1za3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730343654; c=relaxed/simple;
	bh=eiybuSbSqAfhqTX4klwGjcubjH2hTSHCm3MBjy/E4j8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZSpkt3y2f6CuC2QP+StnPl5msLe4aqmRczuSvOW4mbLLYYpk4JgsY8MabOAiEhx7Tg9XFxrCqn+MVcSOyNCZpSOksbglRv9Z2hlVQl9sCJ3pqjM+HY+RWWSA73P/Vmt51a7j9i0O5L0mODkEkOap46Ni6mZ7aNkPR14qBaoGBwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T6oTfdz7; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-539f0f9ee49so534470e87.1
        for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 20:00:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730343650; x=1730948450; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1Y+UlFzxA5mQX6XWn4SRCBXwaRvTlDldwosLSyGNw9E=;
        b=T6oTfdz7kgu+AhAQ9jprJ0qQKBuu04A5I3E7ovnvqMSYYVjZ8uWHhnlU/8x4J/r9ZN
         ztyMdc2AsdICCIBx/UIlZg/oDF9kViSHbNHGiYhuHtATMxmG4gxO7yK+onG/GTwpzKW2
         hV1tbfDWxBXKM3HYStSP/xUG2KD//gg4/DuLmWQJWUcnynz+2dN7MEpRj9cmXa/XahyL
         Mp3FDxedoHoMb/P1QmMgoHKXR1AQR7ZB5VI46o+Gj/d/0ibR70amO4uMfhKL+TapX7d9
         qNUkbE1cXjzV0L4JKs3NAHffIwZy3djslZ63FE92rjr7kqHhLPYAbbBPGsdjB22PRJNy
         r9AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730343650; x=1730948450;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1Y+UlFzxA5mQX6XWn4SRCBXwaRvTlDldwosLSyGNw9E=;
        b=p7+9OvxI23OcNqHTGutsV/GRAfUV2k3hYL/GL5Y1LrvU7WcSQIcE4bT1E5FNFR1nT7
         5pUBqTt1rfhxVPRDdwaenen+F2nU9Zz+cPShKcP+mzZgmydOj2f0Ni9Hszo7sFZJXwnQ
         cBElPAlCTq0Wd2ytOXASsdOH7TeOkQwTUO7K3kxMeBvDIz4aaE87V20k/AF0mHmGrP/A
         cNY21qulsaSBuEw1bXP/EtM8Jn5e3jRbS0tk+R06+V/xZmbe3dwdF4uHcVRlp4o1Rhrp
         jTBG85QOAKVJAxA3t7aN9LX15z4hjwZK+XmUQDoyWpcF+nnY6YelxI09ZFbFeOhufVkW
         BY3A==
X-Forwarded-Encrypted: i=1; AJvYcCVkEqYUwLtSKR/C1X2X2JnaUDWiBsdVDjabHwp2qfZMWln3d4O+XJlFrgfTrFMcwug09NrsjR9YGui2PkM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzEWX6tfW61Sfhdg5J0sTbMw/6YpKTxU0hZx+kHi0j/rSlvHvIK
	weSKVcDVeLEyMDGygjRjmntVrPvrv1NBmEHWIkdjf/KIRzfNB+ZYKMnH7tQn18jMbZe4SzRKszw
	qDzMKvqGy5ZsCSMVIHP7J3M+cYfU=
X-Google-Smtp-Source: AGHT+IFXNa3eT/jEBuv8fmpM4+RSU3MTUtU4ZUgOzIR+Q4QKrG12ONruVcSzwkbe6AhRaMmT7eiPFoZ2oAmdzFE9ww4=
X-Received: by 2002:a05:6512:3b06:b0:539:f607:1d2b with SMTP id
 2adb3069b0e04-53b348b7c7bmr8525195e87.7.1730343649891; Wed, 30 Oct 2024
 20:00:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241030103136.2874140-1-yi.sun@unisoc.com> <20241030103136.2874140-5-yi.sun@unisoc.com>
 <CACOAw_zn0ov0b2h9+zHn2gYVCDVGYPkXFNcx-j7OkhU0Y=i94g@mail.gmail.com>
In-Reply-To: <CACOAw_zn0ov0b2h9+zHn2gYVCDVGYPkXFNcx-j7OkhU0Y=i94g@mail.gmail.com>
From: yi sun <sunyibuaa@gmail.com>
Date: Thu, 31 Oct 2024 11:00:13 +0800
Message-ID: <CALpufv0ZBd5WMPgcXub2osrGRKdSzXvC5+3By5uNRFc4xXp=eQ@mail.gmail.com>
Subject: Re: [f2fs-dev] [PATCH v2 4/5] f2fs: add parameter @len to f2fs_invalidate_blocks()
To: Daeho Jeong <daeho43@gmail.com>
Cc: Yi Sun <yi.sun@unisoc.com>, chao@kernel.org, jaegeuk@kernel.org, 
	ke.wang@unisoc.com, linux-kernel@vger.kernel.org, 
	linux-f2fs-devel@lists.sourceforge.net, hao_hao.wang@unisoc.com, 
	Zhiguo Niu <niuzhiguo84@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 31, 2024 at 1:00=E2=80=AFAM Daeho Jeong <daeho43@gmail.com> wro=
te:
>
> On Wed, Oct 30, 2024 at 3:35=E2=80=AFAM Yi Sun <yi.sun@unisoc.com> wrote:
> >
> > New function can process some consecutive blocks at a time.
> >
> > Function f2fs_invalidate_blocks()->down_write() and up_write()
> > are very time-consuming, so if f2fs_invalidate_blocks() can
> > process consecutive blocks at one time, it will save a lot of time.
> >
> > Signed-off-by: Yi Sun <yi.sun@unisoc.com>
> > ---
> >  fs/f2fs/compress.c |  4 +--
> >  fs/f2fs/f2fs.h     |  3 +-
> >  fs/f2fs/file.c     |  8 +++---
> >  fs/f2fs/node.c     |  4 +--
> >  fs/f2fs/segment.c  | 69 ++++++++++++++++++++++++++++++++++++++--------
> >  5 files changed, 68 insertions(+), 20 deletions(-)
> >
> > diff --git a/fs/f2fs/compress.c b/fs/f2fs/compress.c
> > index e607a7885b57..02ad0ff29cf2 100644
> > --- a/fs/f2fs/compress.c
> > +++ b/fs/f2fs/compress.c
> > @@ -1374,7 +1374,7 @@ static int f2fs_write_compressed_pages(struct com=
press_ctx *cc,
> >                         if (blkaddr =3D=3D COMPRESS_ADDR)
> >                                 fio.compr_blocks++;
> >                         if (__is_valid_data_blkaddr(blkaddr))
> > -                               f2fs_invalidate_blocks(sbi, blkaddr);
> > +                               f2fs_invalidate_blocks(sbi, blkaddr, 1)=
;
> >                         f2fs_update_data_blkaddr(&dn, COMPRESS_ADDR);
> >                         goto unlock_continue;
> >                 }
> > @@ -1384,7 +1384,7 @@ static int f2fs_write_compressed_pages(struct com=
press_ctx *cc,
> >
> >                 if (i > cc->valid_nr_cpages) {
> >                         if (__is_valid_data_blkaddr(blkaddr)) {
> > -                               f2fs_invalidate_blocks(sbi, blkaddr);
> > +                               f2fs_invalidate_blocks(sbi, blkaddr, 1)=
;
> >                                 f2fs_update_data_blkaddr(&dn, NEW_ADDR)=
;
> >                         }
> >                         goto unlock_continue;
> > diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> > index addd49af57ec..4bb459157adf 100644
> > --- a/fs/f2fs/f2fs.h
> > +++ b/fs/f2fs/f2fs.h
> > @@ -3716,7 +3716,8 @@ int f2fs_issue_flush(struct f2fs_sb_info *sbi, ni=
d_t ino);
> >  int f2fs_create_flush_cmd_control(struct f2fs_sb_info *sbi);
> >  int f2fs_flush_device_cache(struct f2fs_sb_info *sbi);
> >  void f2fs_destroy_flush_cmd_control(struct f2fs_sb_info *sbi, bool fre=
e);
> > -void f2fs_invalidate_blocks(struct f2fs_sb_info *sbi, block_t addr);
> > +void f2fs_invalidate_blocks(struct f2fs_sb_info *sbi, block_t addr,
> > +                                               unsigned int len);
> >  bool f2fs_is_checkpointed_data(struct f2fs_sb_info *sbi, block_t blkad=
dr);
> >  int f2fs_start_discard_thread(struct f2fs_sb_info *sbi);
> >  void f2fs_drop_discard_cmd(struct f2fs_sb_info *sbi);
> > diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
> > index 75a8b22da664..13594bb502d1 100644
> > --- a/fs/f2fs/file.c
> > +++ b/fs/f2fs/file.c
> > @@ -652,7 +652,7 @@ void f2fs_truncate_data_blocks_range(struct dnode_o=
f_data *dn, int count)
> >                                 valid_blocks++;
> >                 }
> >
> > -               f2fs_invalidate_blocks(sbi, blkaddr);
> > +               f2fs_invalidate_blocks(sbi, blkaddr, 1);
> >
> >                 if (!released || blkaddr !=3D COMPRESS_ADDR)
> >                         nr_free++;
> > @@ -750,7 +750,7 @@ int f2fs_do_truncate_blocks(struct inode *inode, u6=
4 from, bool lock)
> >                 unsigned int i;
> >
> >                 for (i =3D 0; i < ei.len; i++)
> > -                       f2fs_invalidate_blocks(sbi, ei.blk + i);
> > +                       f2fs_invalidate_blocks(sbi, ei.blk + i, 1);
> >
> >                 dec_valid_block_count(sbi, inode, ei.len);
> >                 f2fs_update_time(sbi, REQ_TIME);
> > @@ -1319,7 +1319,7 @@ static int __roll_back_blkaddrs(struct inode *ino=
de, block_t *blkaddr,
> >                 ret =3D f2fs_get_dnode_of_data(&dn, off + i, LOOKUP_NOD=
E_RA);
> >                 if (ret) {
> >                         dec_valid_block_count(sbi, inode, 1);
> > -                       f2fs_invalidate_blocks(sbi, *blkaddr);
> > +                       f2fs_invalidate_blocks(sbi, *blkaddr, 1);
> >                 } else {
> >                         f2fs_update_data_blkaddr(&dn, *blkaddr);
> >                 }
> > @@ -1571,7 +1571,7 @@ static int f2fs_do_zero_range(struct dnode_of_dat=
a *dn, pgoff_t start,
> >                         break;
> >                 }
> >
> > -               f2fs_invalidate_blocks(sbi, dn->data_blkaddr);
> > +               f2fs_invalidate_blocks(sbi, dn->data_blkaddr, 1);
> >                 f2fs_set_data_blkaddr(dn, NEW_ADDR);
> >         }
> >
> > diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
> > index af36c6d6542b..db15d6a90f67 100644
> > --- a/fs/f2fs/node.c
> > +++ b/fs/f2fs/node.c
> > @@ -916,7 +916,7 @@ static int truncate_node(struct dnode_of_data *dn)
> >         }
> >
> >         /* Deallocate node address */
> > -       f2fs_invalidate_blocks(sbi, ni.blk_addr);
> > +       f2fs_invalidate_blocks(sbi, ni.blk_addr, 1);
> >         dec_valid_node_count(sbi, dn->inode, dn->nid =3D=3D dn->inode->=
i_ino);
> >         set_node_addr(sbi, &ni, NULL_ADDR, false);
> >
> > @@ -2761,7 +2761,7 @@ int f2fs_recover_xattr_data(struct inode *inode, =
struct page *page)
> >         if (err)
> >                 return err;
> >
> > -       f2fs_invalidate_blocks(sbi, ni.blk_addr);
> > +       f2fs_invalidate_blocks(sbi, ni.blk_addr, 1);
> >         dec_valid_node_count(sbi, inode, false);
> >         set_node_addr(sbi, &ni, NULL_ADDR, false);
> >
> > diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
> > index 92ddff285a65..67f2bfdeb6ec 100644
> > --- a/fs/f2fs/segment.c
> > +++ b/fs/f2fs/segment.c
> > @@ -245,7 +245,7 @@ static int __replace_atomic_write_block(struct inod=
e *inode, pgoff_t index,
> >                 if (!__is_valid_data_blkaddr(new_addr)) {
> >                         if (new_addr =3D=3D NULL_ADDR)
> >                                 dec_valid_block_count(sbi, inode, 1);
> > -                       f2fs_invalidate_blocks(sbi, dn.data_blkaddr);
> > +                       f2fs_invalidate_blocks(sbi, dn.data_blkaddr, 1)=
;
> >                         f2fs_update_data_blkaddr(&dn, new_addr);
> >                 } else {
> >                         f2fs_replace_block(sbi, &dn, dn.data_blkaddr,
> > @@ -2558,29 +2558,76 @@ static void update_sit_entry(struct f2fs_sb_inf=
o *sbi, block_t blkaddr, int del)
> >                 get_sec_entry(sbi, segno)->valid_blocks +=3D del;
> >  }
> >
> > -void f2fs_invalidate_blocks(struct f2fs_sb_info *sbi, block_t addr)
> > +static void __f2fs_invalidate_blocks(struct f2fs_sb_info *sbi,
> > +                                       block_t addr, block_t end)
> >  {
> >         unsigned int segno =3D GET_SEGNO(sbi, addr);
> >         struct sit_info *sit_i =3D SIT_I(sbi);
> > +       unsigned int seg_num =3D GET_SEGNO(sbi, end) - segno + 1;
> > +       unsigned int i =3D 1, max_blocks =3D sbi->blocks_per_seg, len;
> > +       block_t addr_start =3D addr;
> >
> > -       f2fs_bug_on(sbi, addr =3D=3D NULL_ADDR);
> > -       if (addr =3D=3D NEW_ADDR || addr =3D=3D COMPRESS_ADDR)
> > -               return;
> > -
> > -       f2fs_invalidate_internal_cache(sbi, addr, 1);
> > +       f2fs_invalidate_internal_cache(sbi, addr, end - addr + 1);
> >
> >         /* add it into sit main buffer */
> >         down_write(&sit_i->sentry_lock);
> >
> > -       update_segment_mtime(sbi, addr, 0);
> > -       update_sit_entry(sbi, addr, -1);
> > +       if (seg_num =3D=3D 1)
> > +               len =3D end - addr + 1;
> > +       else
> > +               len =3D max_blocks - GET_BLKOFF_FROM_SEG0(sbi, addr);
> >
> > -       /* add it into dirty seglist */
> > -       locate_dirty_segment(sbi, segno);
> > +       do {
> > +               update_segment_mtime(sbi, addr_start, 0);
> > +               update_sit_entry(sbi, addr_start, -len);
> > +
> > +               /* add it into dirty seglist */
> > +               locate_dirty_segment(sbi, segno);
> > +
> > +               /* update @addr_start and @len and @segno */
> > +               addr_start =3D START_BLOCK(sbi, ++segno);
> > +               if (++i =3D=3D seg_num)
> > +                       len =3D GET_BLKOFF_FROM_SEG0(sbi, end) + 1;
> > +               else
> > +                       len =3D max_blocks;
> > +       } while (i <=3D seg_num);
> >
> >         up_write(&sit_i->sentry_lock);
> >  }
> >
> > +void f2fs_invalidate_blocks(struct f2fs_sb_info *sbi,
> > +                               block_t addr, unsigned int len)
> > +{
> > +       unsigned int i;
> > +       /* Temporary record location */
> > +       block_t addr_start =3D addr, addr_end;
> > +
> > +       if (len =3D=3D 0)
> > +               return;
> > +
> > +       for (i =3D 0; i < len; i++) {
> > +               addr_end =3D addr + i;
> > +
> > +               f2fs_bug_on(sbi, addr_end =3D=3D NULL_ADDR);
>
> Looks like this line should be out of this loop, right?
>
> > +
> > +               if (addr_end =3D=3D NEW_ADDR || addr_end =3D=3D COMPRES=
S_ADDR) {
>
> ditto?

The original f2fs_invalidate_blocks() can only process one block at a time,
and it will check NULL_ADDR, NEW_ADDR and COMPRESS_ADDR for
each input block.

The new f2fs_invalidate_blocks() can process multiple blocks at a time.
In order to keep it consistent with the original f2fs_invalidate_blocks(),
the new function will also check NULL_ADDR, NEW_ADDR and COMPRESS_ADDR
for each block, so these two lines are placed in the loop.

> Could you help with enhancing the readability here? a little bit
> confused with using addr_start, addr_end and NEW_ADDR, COMPRESS_ADDR,
> here.
>

The addr_start and addr_end will continue to move to filter out the range o=
f
all valid data blkaddr and pass it to __f2fs_invalidate_blocks() for
further processing.

Assume that the input  parameters of f2fs_invalidate_blocks() are addr=3DN,=
 len=3D4,
and there is a blkaddr =3D NEW_ADDR.

Like this:
          |      N       |    N+1    |NEW_ADDR|N+3|
loop1  addr_start
           addr_end

loop2                  addr_end

loop3                                  addr_end
                                           At this point we need to
pass range [addr_start, addr_end - 1] into __f2fs_invalidate_blocks()
for processing.

loop4
                                                           addr_start
                                                           addr_end

> > +                       if (addr_start =3D=3D addr_end) {
> > +                               addr_end =3D addr_start =3D addr_end + =
1;
> > +                               continue;
> > +                       }
> > +
> > +                       __f2fs_invalidate_blocks(sbi, addr_start, addr_=
end - 1);
> > +                       addr_end =3D addr_start =3D addr_end + 1;
> > +               }
> > +       }
> > +
> > +       if (addr_end >=3D (addr + len))
> > +               return;
> > +
> > +       __f2fs_invalidate_blocks(sbi, addr_start, addr_end);
> > +
> > +}
> > +
> >  bool f2fs_is_checkpointed_data(struct f2fs_sb_info *sbi, block_t blkad=
dr)
> >  {
> >         struct sit_info *sit_i =3D SIT_I(sbi);
> > --
> > 2.25.1
> >
> >
> >
> > _______________________________________________
> > Linux-f2fs-devel mailing list
> > Linux-f2fs-devel@lists.sourceforge.net
> > https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

