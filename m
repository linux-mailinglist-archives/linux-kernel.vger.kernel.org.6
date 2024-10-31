Return-Path: <linux-kernel+bounces-390214-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C36BF9B771D
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 10:11:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 81AFE285929
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 09:11:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEBC2193439;
	Thu, 31 Oct 2024 09:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="imOs9yrV"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3517C192B70
	for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 09:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730365862; cv=none; b=hNnuYStYe8VGDRECqZM3fyxQ/rKRbXTa9WYr+siUY+5pBZ6Un64d05DuMiKUux2ms6zPJv2aDJKDWqCOjUA97AXhx50wkRBlR7fWdzWoC1lB1eJdppcmg5KTl6tku9LKfCi3lEVJ15vxz/0ej93U71tEJcQX+n8aztrA1FU0RVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730365862; c=relaxed/simple;
	bh=+rhQJSaEcLe8ujK1QpogNyPBY4hFSxaPhQvhmc/d4Ds=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AqR3U/lBspbQrz0h2OtJfo5lStlfFi2IBXooOYeBoUiiFVwYmGUpvnx05XecDjxH13AjynXRBX4ZgqOBre8JWS1EiydPca9Q/EkKbg0NrGu+yOVuOyuBRTX8Qj7giwUv3wTjtDqvnb8SzOyNPha+cPL3YgKbXHnVn4qf1yNgwS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=imOs9yrV; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4315b957ae8so783515e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 02:10:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730365857; x=1730970657; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wehjQiiMov4faMfJ+SamoSwv5BMC9NmSWUnj3789iPQ=;
        b=imOs9yrVRVaQ9xdErtbQfPspaRVMjtytUW7//v8m9wJQ4j6eX65ljTgAHHHxTy/xug
         4QqG6WruHoFvxGE8tg0BJTBESwCGVuKod7dOW2WDR+USslUCUpnjhrFKl8ROCa0kVzkn
         xMluV9MorYZF+ZbxrREKFnlhZqsroYcSUFi2m/eppjYTZ2akWyHym6MoSOyH+/G/O6S8
         5QxBQxb/pdhQx9OQyeyFVrneRZeyUnJJek9o8dir4vLJ3GGiRkqpYnWj+urAzrifv0+4
         7qFgLhE7pFzi7NmrH9UK0FJqA9HydgVs52cZ7h8pHyx2VeW9czWNrTbGbToTyjBURA3h
         dpVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730365857; x=1730970657;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wehjQiiMov4faMfJ+SamoSwv5BMC9NmSWUnj3789iPQ=;
        b=lfCvNT3g0LlHQs/x0vvsZXcuhWHHT+TgFSnyFyAZylPF79j12M1S9t0One9+FEYn4R
         ImzMATIp4i5vIq0/ipR885uwamWrNrTnLfY78r6IjkbiBiagbhh4AjisNFHKR9mrS4j8
         cTeISR+6Dlu+AkWtRnnEvpZEqY1DmnJ3k13tEZ+WxscduSIMfCtcxhXcLZR1ivqIJz5X
         YIMUtcRFph0Y+lfIstiVAN/N5dawwhVrhXpkhc5mTG2rx3aOxe58+eDjD1Expvswg65o
         7FUyFTCb9PSA6ESoGLadNnD2kFqBzo1Sv4+bYWI6nEqYyCMyWqd+FbICrPNxwX8n65eI
         rH0Q==
X-Forwarded-Encrypted: i=1; AJvYcCXPNmYsFeiis6wzsBk/SUJdZOAq2wEAHFy4iUi4Aun0z6MgdPIC4gZTbWOk5Yz7kFhgJ1q6sMr5Q3Pi9GY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKAVYwFhHlCwCw9tdplNs2HzeRCyomKUOPKuGqkXhRAi6Z+Y0y
	JULzVuxSQ1DvTxfaRP2DTqwejk4uk11z8afiqlxNfpgUVnI5hPxe0lBaWFLgwWQqRZ2QJ+kkqDg
	Kn63OjZwgutUHL1iRagzcwaDQYvE=
X-Google-Smtp-Source: AGHT+IGtKSys/PIsbUyw7CPyLhG+B6hUTyx7IAEHwh07oCLiZB+YP5jAjNztLapjvIlS0uRKZjOa5IrxxSHiSNenBr4=
X-Received: by 2002:a5d:5f94:0:b0:374:bde8:3b46 with SMTP id
 ffacd0b85a97d-380611a7665mr7497299f8f.2.1730365857003; Thu, 31 Oct 2024
 02:10:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241030103136.2874140-1-yi.sun@unisoc.com> <20241030103136.2874140-5-yi.sun@unisoc.com>
 <CACOAw_zn0ov0b2h9+zHn2gYVCDVGYPkXFNcx-j7OkhU0Y=i94g@mail.gmail.com> <CALpufv0ZBd5WMPgcXub2osrGRKdSzXvC5+3By5uNRFc4xXp=eQ@mail.gmail.com>
In-Reply-To: <CALpufv0ZBd5WMPgcXub2osrGRKdSzXvC5+3By5uNRFc4xXp=eQ@mail.gmail.com>
From: Zhiguo Niu <niuzhiguo84@gmail.com>
Date: Thu, 31 Oct 2024 17:10:45 +0800
Message-ID: <CAHJ8P3Kx3=cYygX13LFVv5ATAejpYF+Q9mKO7BwGDmX05b640Q@mail.gmail.com>
Subject: Re: [f2fs-dev] [PATCH v2 4/5] f2fs: add parameter @len to f2fs_invalidate_blocks()
To: yi sun <sunyibuaa@gmail.com>
Cc: Daeho Jeong <daeho43@gmail.com>, Yi Sun <yi.sun@unisoc.com>, chao@kernel.org, 
	jaegeuk@kernel.org, ke.wang@unisoc.com, linux-kernel@vger.kernel.org, 
	linux-f2fs-devel@lists.sourceforge.net, hao_hao.wang@unisoc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

yi sun <sunyibuaa@gmail.com> =E4=BA=8E2024=E5=B9=B410=E6=9C=8831=E6=97=A5=
=E5=91=A8=E5=9B=9B 11:00=E5=86=99=E9=81=93=EF=BC=9A
>
> On Thu, Oct 31, 2024 at 1:00=E2=80=AFAM Daeho Jeong <daeho43@gmail.com> w=
rote:
> >
> > On Wed, Oct 30, 2024 at 3:35=E2=80=AFAM Yi Sun <yi.sun@unisoc.com> wrot=
e:
> > >
> > > New function can process some consecutive blocks at a time.
> > >
> > > Function f2fs_invalidate_blocks()->down_write() and up_write()
> > > are very time-consuming, so if f2fs_invalidate_blocks() can
> > > process consecutive blocks at one time, it will save a lot of time.
> > >
> > > Signed-off-by: Yi Sun <yi.sun@unisoc.com>
> > > ---
> > >  fs/f2fs/compress.c |  4 +--
> > >  fs/f2fs/f2fs.h     |  3 +-
> > >  fs/f2fs/file.c     |  8 +++---
> > >  fs/f2fs/node.c     |  4 +--
> > >  fs/f2fs/segment.c  | 69 ++++++++++++++++++++++++++++++++++++++------=
--
> > >  5 files changed, 68 insertions(+), 20 deletions(-)
> > >
> > > diff --git a/fs/f2fs/compress.c b/fs/f2fs/compress.c
> > > index e607a7885b57..02ad0ff29cf2 100644
> > > --- a/fs/f2fs/compress.c
> > > +++ b/fs/f2fs/compress.c
> > > @@ -1374,7 +1374,7 @@ static int f2fs_write_compressed_pages(struct c=
ompress_ctx *cc,
> > >                         if (blkaddr =3D=3D COMPRESS_ADDR)
> > >                                 fio.compr_blocks++;
> > >                         if (__is_valid_data_blkaddr(blkaddr))
> > > -                               f2fs_invalidate_blocks(sbi, blkaddr);
> > > +                               f2fs_invalidate_blocks(sbi, blkaddr, =
1);
> > >                         f2fs_update_data_blkaddr(&dn, COMPRESS_ADDR);
> > >                         goto unlock_continue;
> > >                 }
> > > @@ -1384,7 +1384,7 @@ static int f2fs_write_compressed_pages(struct c=
ompress_ctx *cc,
> > >
> > >                 if (i > cc->valid_nr_cpages) {
> > >                         if (__is_valid_data_blkaddr(blkaddr)) {
> > > -                               f2fs_invalidate_blocks(sbi, blkaddr);
> > > +                               f2fs_invalidate_blocks(sbi, blkaddr, =
1);
> > >                                 f2fs_update_data_blkaddr(&dn, NEW_ADD=
R);
> > >                         }
> > >                         goto unlock_continue;
> > > diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> > > index addd49af57ec..4bb459157adf 100644
> > > --- a/fs/f2fs/f2fs.h
> > > +++ b/fs/f2fs/f2fs.h
> > > @@ -3716,7 +3716,8 @@ int f2fs_issue_flush(struct f2fs_sb_info *sbi, =
nid_t ino);
> > >  int f2fs_create_flush_cmd_control(struct f2fs_sb_info *sbi);
> > >  int f2fs_flush_device_cache(struct f2fs_sb_info *sbi);
> > >  void f2fs_destroy_flush_cmd_control(struct f2fs_sb_info *sbi, bool f=
ree);
> > > -void f2fs_invalidate_blocks(struct f2fs_sb_info *sbi, block_t addr);
> > > +void f2fs_invalidate_blocks(struct f2fs_sb_info *sbi, block_t addr,
> > > +                                               unsigned int len);
> > >  bool f2fs_is_checkpointed_data(struct f2fs_sb_info *sbi, block_t blk=
addr);
> > >  int f2fs_start_discard_thread(struct f2fs_sb_info *sbi);
> > >  void f2fs_drop_discard_cmd(struct f2fs_sb_info *sbi);
> > > diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
> > > index 75a8b22da664..13594bb502d1 100644
> > > --- a/fs/f2fs/file.c
> > > +++ b/fs/f2fs/file.c
> > > @@ -652,7 +652,7 @@ void f2fs_truncate_data_blocks_range(struct dnode=
_of_data *dn, int count)
> > >                                 valid_blocks++;
> > >                 }
> > >
> > > -               f2fs_invalidate_blocks(sbi, blkaddr);
> > > +               f2fs_invalidate_blocks(sbi, blkaddr, 1);
> > >
> > >                 if (!released || blkaddr !=3D COMPRESS_ADDR)
> > >                         nr_free++;
> > > @@ -750,7 +750,7 @@ int f2fs_do_truncate_blocks(struct inode *inode, =
u64 from, bool lock)
> > >                 unsigned int i;
> > >
> > >                 for (i =3D 0; i < ei.len; i++)
> > > -                       f2fs_invalidate_blocks(sbi, ei.blk + i);
> > > +                       f2fs_invalidate_blocks(sbi, ei.blk + i, 1);
> > >
> > >                 dec_valid_block_count(sbi, inode, ei.len);
> > >                 f2fs_update_time(sbi, REQ_TIME);
> > > @@ -1319,7 +1319,7 @@ static int __roll_back_blkaddrs(struct inode *i=
node, block_t *blkaddr,
> > >                 ret =3D f2fs_get_dnode_of_data(&dn, off + i, LOOKUP_N=
ODE_RA);
> > >                 if (ret) {
> > >                         dec_valid_block_count(sbi, inode, 1);
> > > -                       f2fs_invalidate_blocks(sbi, *blkaddr);
> > > +                       f2fs_invalidate_blocks(sbi, *blkaddr, 1);
> > >                 } else {
> > >                         f2fs_update_data_blkaddr(&dn, *blkaddr);
> > >                 }
> > > @@ -1571,7 +1571,7 @@ static int f2fs_do_zero_range(struct dnode_of_d=
ata *dn, pgoff_t start,
> > >                         break;
> > >                 }
> > >
> > > -               f2fs_invalidate_blocks(sbi, dn->data_blkaddr);
> > > +               f2fs_invalidate_blocks(sbi, dn->data_blkaddr, 1);
> > >                 f2fs_set_data_blkaddr(dn, NEW_ADDR);
> > >         }
> > >
> > > diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
> > > index af36c6d6542b..db15d6a90f67 100644
> > > --- a/fs/f2fs/node.c
> > > +++ b/fs/f2fs/node.c
> > > @@ -916,7 +916,7 @@ static int truncate_node(struct dnode_of_data *dn=
)
> > >         }
> > >
> > >         /* Deallocate node address */
> > > -       f2fs_invalidate_blocks(sbi, ni.blk_addr);
> > > +       f2fs_invalidate_blocks(sbi, ni.blk_addr, 1);
> > >         dec_valid_node_count(sbi, dn->inode, dn->nid =3D=3D dn->inode=
->i_ino);
> > >         set_node_addr(sbi, &ni, NULL_ADDR, false);
> > >
> > > @@ -2761,7 +2761,7 @@ int f2fs_recover_xattr_data(struct inode *inode=
, struct page *page)
> > >         if (err)
> > >                 return err;
> > >
> > > -       f2fs_invalidate_blocks(sbi, ni.blk_addr);
> > > +       f2fs_invalidate_blocks(sbi, ni.blk_addr, 1);
> > >         dec_valid_node_count(sbi, inode, false);
> > >         set_node_addr(sbi, &ni, NULL_ADDR, false);
> > >
> > > diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
> > > index 92ddff285a65..67f2bfdeb6ec 100644
> > > --- a/fs/f2fs/segment.c
> > > +++ b/fs/f2fs/segment.c
> > > @@ -245,7 +245,7 @@ static int __replace_atomic_write_block(struct in=
ode *inode, pgoff_t index,
> > >                 if (!__is_valid_data_blkaddr(new_addr)) {
> > >                         if (new_addr =3D=3D NULL_ADDR)
> > >                                 dec_valid_block_count(sbi, inode, 1);
> > > -                       f2fs_invalidate_blocks(sbi, dn.data_blkaddr);
> > > +                       f2fs_invalidate_blocks(sbi, dn.data_blkaddr, =
1);
> > >                         f2fs_update_data_blkaddr(&dn, new_addr);
> > >                 } else {
> > >                         f2fs_replace_block(sbi, &dn, dn.data_blkaddr,
> > > @@ -2558,29 +2558,76 @@ static void update_sit_entry(struct f2fs_sb_i=
nfo *sbi, block_t blkaddr, int del)
> > >                 get_sec_entry(sbi, segno)->valid_blocks +=3D del;
> > >  }
> > >
> > > -void f2fs_invalidate_blocks(struct f2fs_sb_info *sbi, block_t addr)
> > > +static void __f2fs_invalidate_blocks(struct f2fs_sb_info *sbi,
> > > +                                       block_t addr, block_t end)
> > >  {
> > >         unsigned int segno =3D GET_SEGNO(sbi, addr);
> > >         struct sit_info *sit_i =3D SIT_I(sbi);
> > > +       unsigned int seg_num =3D GET_SEGNO(sbi, end) - segno + 1;
> > > +       unsigned int i =3D 1, max_blocks =3D sbi->blocks_per_seg, len=
;
> > > +       block_t addr_start =3D addr;
> > >
> > > -       f2fs_bug_on(sbi, addr =3D=3D NULL_ADDR);
> > > -       if (addr =3D=3D NEW_ADDR || addr =3D=3D COMPRESS_ADDR)
> > > -               return;
> > > -
> > > -       f2fs_invalidate_internal_cache(sbi, addr, 1);
> > > +       f2fs_invalidate_internal_cache(sbi, addr, end - addr + 1);
> > >
> > >         /* add it into sit main buffer */
> > >         down_write(&sit_i->sentry_lock);
> > >
> > > -       update_segment_mtime(sbi, addr, 0);
> > > -       update_sit_entry(sbi, addr, -1);
> > > +       if (seg_num =3D=3D 1)
> > > +               len =3D end - addr + 1;
> > > +       else
> > > +               len =3D max_blocks - GET_BLKOFF_FROM_SEG0(sbi, addr);
> > >
> > > -       /* add it into dirty seglist */
> > > -       locate_dirty_segment(sbi, segno);
> > > +       do {
> > > +               update_segment_mtime(sbi, addr_start, 0);
> > > +               update_sit_entry(sbi, addr_start, -len);
> > > +
> > > +               /* add it into dirty seglist */
> > > +               locate_dirty_segment(sbi, segno);
> > > +
> > > +               /* update @addr_start and @len and @segno */
> > > +               addr_start =3D START_BLOCK(sbi, ++segno);
> > > +               if (++i =3D=3D seg_num)
> > > +                       len =3D GET_BLKOFF_FROM_SEG0(sbi, end) + 1;
> > > +               else
> > > +                       len =3D max_blocks;
> > > +       } while (i <=3D seg_num);
> > >
> > >         up_write(&sit_i->sentry_lock);
> > >  }
> > >
> > > +void f2fs_invalidate_blocks(struct f2fs_sb_info *sbi,
> > > +                               block_t addr, unsigned int len)
> > > +{
> > > +       unsigned int i;
> > > +       /* Temporary record location */
> > > +       block_t addr_start =3D addr, addr_end;
> > > +
> > > +       if (len =3D=3D 0)
> > > +               return;
> > > +
> > > +       for (i =3D 0; i < len; i++) {
> > > +               addr_end =3D addr + i;
> > > +
> > > +               f2fs_bug_on(sbi, addr_end =3D=3D NULL_ADDR);
> >
> > Looks like this line should be out of this loop, right?
> >
> > > +
> > > +               if (addr_end =3D=3D NEW_ADDR || addr_end =3D=3D COMPR=
ESS_ADDR) {
> >
> > ditto?
>
> The original f2fs_invalidate_blocks() can only process one block at a tim=
e,
> and it will check NULL_ADDR, NEW_ADDR and COMPRESS_ADDR for
> each input block.
>
> The new f2fs_invalidate_blocks() can process multiple blocks at a time.
> In order to keep it consistent with the original f2fs_invalidate_blocks()=
,
> the new function will also check NULL_ADDR, NEW_ADDR and COMPRESS_ADDR
> for each block, so these two lines are placed in the loop.
>
> > Could you help with enhancing the readability here? a little bit
> > confused with using addr_start, addr_end and NEW_ADDR, COMPRESS_ADDR,
> > here.
> >
>
> The addr_start and addr_end will continue to move to filter out the range=
 of
> all valid data blkaddr and pass it to __f2fs_invalidate_blocks() for
> further processing.
>
> Assume that the input  parameters of f2fs_invalidate_blocks() are addr=3D=
N, len=3D4,
> and there is a blkaddr =3D NEW_ADDR.
>
> Like this:
>           |      N       |    N+1    |NEW_ADDR|N+3|

Is this actually not a continuous address case?

> loop1  addr_start
>            addr_end
>
> loop2                  addr_end
>
> loop3                                  addr_end
>                                            At this point we need to
> pass range [addr_start, addr_end - 1] into __f2fs_invalidate_blocks()
> for processing.
>
> loop4
>                                                            addr_start
>                                                            addr_end
>
> > > +                       if (addr_start =3D=3D addr_end) {
> > > +                               addr_end =3D addr_start =3D addr_end =
+ 1;
> > > +                               continue;
> > > +                       }
> > > +
> > > +                       __f2fs_invalidate_blocks(sbi, addr_start, add=
r_end - 1);
> > > +                       addr_end =3D addr_start =3D addr_end + 1;
> > > +               }
> > > +       }
> > > +
> > > +       if (addr_end >=3D (addr + len))
> > > +               return;
> > > +
> > > +       __f2fs_invalidate_blocks(sbi, addr_start, addr_end);
> > > +
> > > +}
> > > +
> > >  bool f2fs_is_checkpointed_data(struct f2fs_sb_info *sbi, block_t blk=
addr)
> > >  {
> > >         struct sit_info *sit_i =3D SIT_I(sbi);
> > > --
> > > 2.25.1
> > >
> > >
> > >
> > > _______________________________________________
> > > Linux-f2fs-devel mailing list
> > > Linux-f2fs-devel@lists.sourceforge.net
> > > https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

