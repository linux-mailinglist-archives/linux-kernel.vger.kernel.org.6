Return-Path: <linux-kernel+bounces-390373-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C39D29B7906
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 11:52:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E83ED1C21D02
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 10:51:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BCD919994D;
	Thu, 31 Oct 2024 10:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IP8BsV5H"
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87D8F13A25F
	for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 10:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730371914; cv=none; b=g/zefYZW1eOQU5py9/H5tMsb6FQYPm1P4oA3fRbFRJ1bpYz0TBOAhziHwOz7kKf7ujLVzxNnKao5r9wtbIPM0EAwqqgeGsGbRojtFjysYWujVv5CDVmvaU92CIg9BlF6A/V6ufn/ZNQ3Lx+G3rrLxHMdTgaPoQ/z9NF8IsaCtQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730371914; c=relaxed/simple;
	bh=3nuA7mgJNDPcUnsc2Ij2ITbL6v3Po8asK3ktTXdUGZY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=b8KEzNlJThI2tGgS2FVHBTg11NJrPUlAel1iP8ISk+Sn2PfVo7caj0E7NcqZnd2TKOkd0AV2RaC1LQpcD301NSNa0dR1roIQNAySnqcjkfmvNQA3DaOfXQLtRZNIPphyJNe/5fMTwsb644R+CujL4MwU15WEIZecRMGYcIH4nqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IP8BsV5H; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-53a0c160b94so825493e87.2
        for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 03:51:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730371910; x=1730976710; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OAKJobIzQ2plj+444JfDBeC+xC6nafHiaa5Oo8vAHsU=;
        b=IP8BsV5Ht/ffe7K3Wgl8ZVP6KPI4AD6fQfr9PKvlKO8PDQG/uM7pA83ptgzWeVa3Mr
         W7UTm6q9MHF8auVrk1oA+USqiHIPUswW4BPzzC3WnNYS8kBBuJW75FBWv4F6ptjZtA+v
         eKsZ9z/0Hs3nFMtbadVRMummPskz+PWY5XKxemuuYiLy5WLacqDNW/tGHkQCy28+yl50
         LzX+8cFDDWOYHpx6cvYOKi7ui6qKxF3ufEGFco/CWHQlCY4ABxDvECuCJ8qH2julSnY3
         z5/eqwqkg6f4MM6cjwPd34fUP0Y8tSZDQGdylIu9cHUFdisCs797m+9dO64tgi2M4SKy
         pNPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730371910; x=1730976710;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OAKJobIzQ2plj+444JfDBeC+xC6nafHiaa5Oo8vAHsU=;
        b=iuk7FJ+M+SoL7JIaG68yxBRL8yzRwAvogq/o/mNiUQj03qPuWG9xvrRwu0cNd6RvtD
         jDwa+kDlnyIsJ/kJaJXnr5LsubV4zYvCe53v/O113y5d1glHREg8XfpEP7yreelfF/vo
         eQMdHtfmAqU9O2pzqFmlA3rjnMviaKYjkswsT6dbR6MMnNJdLO912ziig6lYwmEuT3ma
         1uTlkQHa8X9chqw1lO+Ne6QbXm6suU9KqdEgJBeJI1bHB/66eZDURuUsVWLJ6MrxPd+8
         48lfp7HSqfKw/vLMigJtnqCdNgpMOkHAi3NWgjYwJfoLCLvL4Js22lYha7Nx+/zP+tL1
         gP3g==
X-Forwarded-Encrypted: i=1; AJvYcCWxOVJuXfmZCd0qNir90nMcIciZmLAJ/l9gsBBaT852PyLH52TokrEG3l6To9ZbuTpHfziZ02N9JC+eQC8=@vger.kernel.org
X-Gm-Message-State: AOJu0YztRiquSPNLo+gAjjS0WWA2D0n7Y/0d9WzJAQK0ykOiz3fPGsrE
	MIf0NNqMR/o+ppizo7nJsXBT/t20uuMGxe30SDrgnJ7qQYXLcY3F2c2f0w18OAgzNzIDNG8GDeZ
	B3N/i8vXLWdLT1MGhLKzpM7ZsYtA=
X-Google-Smtp-Source: AGHT+IHot1z6qXTtXVtcfqK9Rn/V/n2/EMT7ByZM9Kf4vpBerDQcvnHT7onH4HaynXVEtDOb/KJJWwNMarI9lF6KHNs=
X-Received: by 2002:a05:6512:3da8:b0:536:55a8:6f78 with SMTP id
 2adb3069b0e04-53b348cefbfmr8669016e87.17.1730371909344; Thu, 31 Oct 2024
 03:51:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241030103136.2874140-1-yi.sun@unisoc.com> <20241030103136.2874140-5-yi.sun@unisoc.com>
 <CACOAw_zn0ov0b2h9+zHn2gYVCDVGYPkXFNcx-j7OkhU0Y=i94g@mail.gmail.com>
 <CALpufv0ZBd5WMPgcXub2osrGRKdSzXvC5+3By5uNRFc4xXp=eQ@mail.gmail.com> <CAHJ8P3Kx3=cYygX13LFVv5ATAejpYF+Q9mKO7BwGDmX05b640Q@mail.gmail.com>
In-Reply-To: <CAHJ8P3Kx3=cYygX13LFVv5ATAejpYF+Q9mKO7BwGDmX05b640Q@mail.gmail.com>
From: yi sun <sunyibuaa@gmail.com>
Date: Thu, 31 Oct 2024 18:51:12 +0800
Message-ID: <CALpufv1Mpter57LoAmytREw68KMAtCaaFr2C7wLxUSkroA9Luw@mail.gmail.com>
Subject: Re: [f2fs-dev] [PATCH v2 4/5] f2fs: add parameter @len to f2fs_invalidate_blocks()
To: Zhiguo Niu <niuzhiguo84@gmail.com>
Cc: Daeho Jeong <daeho43@gmail.com>, Yi Sun <yi.sun@unisoc.com>, chao@kernel.org, 
	jaegeuk@kernel.org, ke.wang@unisoc.com, linux-kernel@vger.kernel.org, 
	linux-f2fs-devel@lists.sourceforge.net, hao_hao.wang@unisoc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 31, 2024 at 5:10=E2=80=AFPM Zhiguo Niu <niuzhiguo84@gmail.com> =
wrote:
>
> yi sun <sunyibuaa@gmail.com> =E4=BA=8E2024=E5=B9=B410=E6=9C=8831=E6=97=A5=
=E5=91=A8=E5=9B=9B 11:00=E5=86=99=E9=81=93=EF=BC=9A
> >
> > On Thu, Oct 31, 2024 at 1:00=E2=80=AFAM Daeho Jeong <daeho43@gmail.com>=
 wrote:
> > >
> > > On Wed, Oct 30, 2024 at 3:35=E2=80=AFAM Yi Sun <yi.sun@unisoc.com> wr=
ote:
> > > >
> > > > New function can process some consecutive blocks at a time.
> > > >
> > > > Function f2fs_invalidate_blocks()->down_write() and up_write()
> > > > are very time-consuming, so if f2fs_invalidate_blocks() can
> > > > process consecutive blocks at one time, it will save a lot of time.
> > > >
> > > > Signed-off-by: Yi Sun <yi.sun@unisoc.com>
> > > > ---
> > > >  fs/f2fs/compress.c |  4 +--
> > > >  fs/f2fs/f2fs.h     |  3 +-
> > > >  fs/f2fs/file.c     |  8 +++---
> > > >  fs/f2fs/node.c     |  4 +--
> > > >  fs/f2fs/segment.c  | 69 ++++++++++++++++++++++++++++++++++++++----=
----
> > > >  5 files changed, 68 insertions(+), 20 deletions(-)
> > > >
> > > > diff --git a/fs/f2fs/compress.c b/fs/f2fs/compress.c
> > > > index e607a7885b57..02ad0ff29cf2 100644
> > > > --- a/fs/f2fs/compress.c
> > > > +++ b/fs/f2fs/compress.c
> > > > @@ -1374,7 +1374,7 @@ static int f2fs_write_compressed_pages(struct=
 compress_ctx *cc,
> > > >                         if (blkaddr =3D=3D COMPRESS_ADDR)
> > > >                                 fio.compr_blocks++;
> > > >                         if (__is_valid_data_blkaddr(blkaddr))
> > > > -                               f2fs_invalidate_blocks(sbi, blkaddr=
);
> > > > +                               f2fs_invalidate_blocks(sbi, blkaddr=
, 1);
> > > >                         f2fs_update_data_blkaddr(&dn, COMPRESS_ADDR=
);
> > > >                         goto unlock_continue;
> > > >                 }
> > > > @@ -1384,7 +1384,7 @@ static int f2fs_write_compressed_pages(struct=
 compress_ctx *cc,
> > > >
> > > >                 if (i > cc->valid_nr_cpages) {
> > > >                         if (__is_valid_data_blkaddr(blkaddr)) {
> > > > -                               f2fs_invalidate_blocks(sbi, blkaddr=
);
> > > > +                               f2fs_invalidate_blocks(sbi, blkaddr=
, 1);
> > > >                                 f2fs_update_data_blkaddr(&dn, NEW_A=
DDR);
> > > >                         }
> > > >                         goto unlock_continue;
> > > > diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> > > > index addd49af57ec..4bb459157adf 100644
> > > > --- a/fs/f2fs/f2fs.h
> > > > +++ b/fs/f2fs/f2fs.h
> > > > @@ -3716,7 +3716,8 @@ int f2fs_issue_flush(struct f2fs_sb_info *sbi=
, nid_t ino);
> > > >  int f2fs_create_flush_cmd_control(struct f2fs_sb_info *sbi);
> > > >  int f2fs_flush_device_cache(struct f2fs_sb_info *sbi);
> > > >  void f2fs_destroy_flush_cmd_control(struct f2fs_sb_info *sbi, bool=
 free);
> > > > -void f2fs_invalidate_blocks(struct f2fs_sb_info *sbi, block_t addr=
);
> > > > +void f2fs_invalidate_blocks(struct f2fs_sb_info *sbi, block_t addr=
,
> > > > +                                               unsigned int len);
> > > >  bool f2fs_is_checkpointed_data(struct f2fs_sb_info *sbi, block_t b=
lkaddr);
> > > >  int f2fs_start_discard_thread(struct f2fs_sb_info *sbi);
> > > >  void f2fs_drop_discard_cmd(struct f2fs_sb_info *sbi);
> > > > diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
> > > > index 75a8b22da664..13594bb502d1 100644
> > > > --- a/fs/f2fs/file.c
> > > > +++ b/fs/f2fs/file.c
> > > > @@ -652,7 +652,7 @@ void f2fs_truncate_data_blocks_range(struct dno=
de_of_data *dn, int count)
> > > >                                 valid_blocks++;
> > > >                 }
> > > >
> > > > -               f2fs_invalidate_blocks(sbi, blkaddr);
> > > > +               f2fs_invalidate_blocks(sbi, blkaddr, 1);
> > > >
> > > >                 if (!released || blkaddr !=3D COMPRESS_ADDR)
> > > >                         nr_free++;
> > > > @@ -750,7 +750,7 @@ int f2fs_do_truncate_blocks(struct inode *inode=
, u64 from, bool lock)
> > > >                 unsigned int i;
> > > >
> > > >                 for (i =3D 0; i < ei.len; i++)
> > > > -                       f2fs_invalidate_blocks(sbi, ei.blk + i);
> > > > +                       f2fs_invalidate_blocks(sbi, ei.blk + i, 1);
> > > >
> > > >                 dec_valid_block_count(sbi, inode, ei.len);
> > > >                 f2fs_update_time(sbi, REQ_TIME);
> > > > @@ -1319,7 +1319,7 @@ static int __roll_back_blkaddrs(struct inode =
*inode, block_t *blkaddr,
> > > >                 ret =3D f2fs_get_dnode_of_data(&dn, off + i, LOOKUP=
_NODE_RA);
> > > >                 if (ret) {
> > > >                         dec_valid_block_count(sbi, inode, 1);
> > > > -                       f2fs_invalidate_blocks(sbi, *blkaddr);
> > > > +                       f2fs_invalidate_blocks(sbi, *blkaddr, 1);
> > > >                 } else {
> > > >                         f2fs_update_data_blkaddr(&dn, *blkaddr);
> > > >                 }
> > > > @@ -1571,7 +1571,7 @@ static int f2fs_do_zero_range(struct dnode_of=
_data *dn, pgoff_t start,
> > > >                         break;
> > > >                 }
> > > >
> > > > -               f2fs_invalidate_blocks(sbi, dn->data_blkaddr);
> > > > +               f2fs_invalidate_blocks(sbi, dn->data_blkaddr, 1);
> > > >                 f2fs_set_data_blkaddr(dn, NEW_ADDR);
> > > >         }
> > > >
> > > > diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
> > > > index af36c6d6542b..db15d6a90f67 100644
> > > > --- a/fs/f2fs/node.c
> > > > +++ b/fs/f2fs/node.c
> > > > @@ -916,7 +916,7 @@ static int truncate_node(struct dnode_of_data *=
dn)
> > > >         }
> > > >
> > > >         /* Deallocate node address */
> > > > -       f2fs_invalidate_blocks(sbi, ni.blk_addr);
> > > > +       f2fs_invalidate_blocks(sbi, ni.blk_addr, 1);
> > > >         dec_valid_node_count(sbi, dn->inode, dn->nid =3D=3D dn->ino=
de->i_ino);
> > > >         set_node_addr(sbi, &ni, NULL_ADDR, false);
> > > >
> > > > @@ -2761,7 +2761,7 @@ int f2fs_recover_xattr_data(struct inode *ino=
de, struct page *page)
> > > >         if (err)
> > > >                 return err;
> > > >
> > > > -       f2fs_invalidate_blocks(sbi, ni.blk_addr);
> > > > +       f2fs_invalidate_blocks(sbi, ni.blk_addr, 1);
> > > >         dec_valid_node_count(sbi, inode, false);
> > > >         set_node_addr(sbi, &ni, NULL_ADDR, false);
> > > >
> > > > diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
> > > > index 92ddff285a65..67f2bfdeb6ec 100644
> > > > --- a/fs/f2fs/segment.c
> > > > +++ b/fs/f2fs/segment.c
> > > > @@ -245,7 +245,7 @@ static int __replace_atomic_write_block(struct =
inode *inode, pgoff_t index,
> > > >                 if (!__is_valid_data_blkaddr(new_addr)) {
> > > >                         if (new_addr =3D=3D NULL_ADDR)
> > > >                                 dec_valid_block_count(sbi, inode, 1=
);
> > > > -                       f2fs_invalidate_blocks(sbi, dn.data_blkaddr=
);
> > > > +                       f2fs_invalidate_blocks(sbi, dn.data_blkaddr=
, 1);
> > > >                         f2fs_update_data_blkaddr(&dn, new_addr);
> > > >                 } else {
> > > >                         f2fs_replace_block(sbi, &dn, dn.data_blkadd=
r,
> > > > @@ -2558,29 +2558,76 @@ static void update_sit_entry(struct f2fs_sb=
_info *sbi, block_t blkaddr, int del)
> > > >                 get_sec_entry(sbi, segno)->valid_blocks +=3D del;
> > > >  }
> > > >
> > > > -void f2fs_invalidate_blocks(struct f2fs_sb_info *sbi, block_t addr=
)
> > > > +static void __f2fs_invalidate_blocks(struct f2fs_sb_info *sbi,
> > > > +                                       block_t addr, block_t end)
> > > >  {
> > > >         unsigned int segno =3D GET_SEGNO(sbi, addr);
> > > >         struct sit_info *sit_i =3D SIT_I(sbi);
> > > > +       unsigned int seg_num =3D GET_SEGNO(sbi, end) - segno + 1;
> > > > +       unsigned int i =3D 1, max_blocks =3D sbi->blocks_per_seg, l=
en;
> > > > +       block_t addr_start =3D addr;
> > > >
> > > > -       f2fs_bug_on(sbi, addr =3D=3D NULL_ADDR);
> > > > -       if (addr =3D=3D NEW_ADDR || addr =3D=3D COMPRESS_ADDR)
> > > > -               return;
> > > > -
> > > > -       f2fs_invalidate_internal_cache(sbi, addr, 1);
> > > > +       f2fs_invalidate_internal_cache(sbi, addr, end - addr + 1);
> > > >
> > > >         /* add it into sit main buffer */
> > > >         down_write(&sit_i->sentry_lock);
> > > >
> > > > -       update_segment_mtime(sbi, addr, 0);
> > > > -       update_sit_entry(sbi, addr, -1);
> > > > +       if (seg_num =3D=3D 1)
> > > > +               len =3D end - addr + 1;
> > > > +       else
> > > > +               len =3D max_blocks - GET_BLKOFF_FROM_SEG0(sbi, addr=
);
> > > >
> > > > -       /* add it into dirty seglist */
> > > > -       locate_dirty_segment(sbi, segno);
> > > > +       do {
> > > > +               update_segment_mtime(sbi, addr_start, 0);
> > > > +               update_sit_entry(sbi, addr_start, -len);
> > > > +
> > > > +               /* add it into dirty seglist */
> > > > +               locate_dirty_segment(sbi, segno);
> > > > +
> > > > +               /* update @addr_start and @len and @segno */
> > > > +               addr_start =3D START_BLOCK(sbi, ++segno);
> > > > +               if (++i =3D=3D seg_num)
> > > > +                       len =3D GET_BLKOFF_FROM_SEG0(sbi, end) + 1;
> > > > +               else
> > > > +                       len =3D max_blocks;
> > > > +       } while (i <=3D seg_num);
> > > >
> > > >         up_write(&sit_i->sentry_lock);
> > > >  }
> > > >
> > > > +void f2fs_invalidate_blocks(struct f2fs_sb_info *sbi,
> > > > +                               block_t addr, unsigned int len)
> > > > +{
> > > > +       unsigned int i;
> > > > +       /* Temporary record location */
> > > > +       block_t addr_start =3D addr, addr_end;
> > > > +
> > > > +       if (len =3D=3D 0)
> > > > +               return;
> > > > +
> > > > +       for (i =3D 0; i < len; i++) {
> > > > +               addr_end =3D addr + i;
> > > > +
> > > > +               f2fs_bug_on(sbi, addr_end =3D=3D NULL_ADDR);
> > >
> > > Looks like this line should be out of this loop, right?
> > >
> > > > +
> > > > +               if (addr_end =3D=3D NEW_ADDR || addr_end =3D=3D COM=
PRESS_ADDR) {
> > >
> > > ditto?
> >
> > The original f2fs_invalidate_blocks() can only process one block at a t=
ime,
> > and it will check NULL_ADDR, NEW_ADDR and COMPRESS_ADDR for
> > each input block.
> >
> > The new f2fs_invalidate_blocks() can process multiple blocks at a time.
> > In order to keep it consistent with the original f2fs_invalidate_blocks=
(),
> > the new function will also check NULL_ADDR, NEW_ADDR and COMPRESS_ADDR
> > for each block, so these two lines are placed in the loop.
> >
> > > Could you help with enhancing the readability here? a little bit
> > > confused with using addr_start, addr_end and NEW_ADDR, COMPRESS_ADDR,
> > > here.
> > >
> >
> > The addr_start and addr_end will continue to move to filter out the ran=
ge of
> > all valid data blkaddr and pass it to __f2fs_invalidate_blocks() for
> > further processing.
> >
> > Assume that the input  parameters of f2fs_invalidate_blocks() are addr=
=3DN, len=3D4,
> > and there is a blkaddr =3D NEW_ADDR.
> >
> > Like this:
> >           |      N       |    N+1    |NEW_ADDR|N+3|
>
> Is this actually not a continuous address case?
>

I'm not sure if this case actually exists, I just took all the
possibilities into consideration.

> > loop1  addr_start
> >            addr_end
> >
> > loop2                  addr_end
> >
> > loop3                                  addr_end
> >                                            At this point we need to
> > pass range [addr_start, addr_end - 1] into __f2fs_invalidate_blocks()
> > for processing.
> >
> > loop4
> >                                                            addr_start
> >                                                            addr_end
> >
> > > > +                       if (addr_start =3D=3D addr_end) {
> > > > +                               addr_end =3D addr_start =3D addr_en=
d + 1;
> > > > +                               continue;
> > > > +                       }
> > > > +
> > > > +                       __f2fs_invalidate_blocks(sbi, addr_start, a=
ddr_end - 1);
> > > > +                       addr_end =3D addr_start =3D addr_end + 1;
> > > > +               }
> > > > +       }
> > > > +
> > > > +       if (addr_end >=3D (addr + len))
> > > > +               return;
> > > > +
> > > > +       __f2fs_invalidate_blocks(sbi, addr_start, addr_end);
> > > > +
> > > > +}
> > > > +
> > > >  bool f2fs_is_checkpointed_data(struct f2fs_sb_info *sbi, block_t b=
lkaddr)
> > > >  {
> > > >         struct sit_info *sit_i =3D SIT_I(sbi);
> > > > --
> > > > 2.25.1
> > > >
> > > >
> > > >
> > > > _______________________________________________
> > > > Linux-f2fs-devel mailing list
> > > > Linux-f2fs-devel@lists.sourceforge.net
> > > > https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

