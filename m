Return-Path: <linux-kernel+bounces-379649-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D36EF9AE193
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 11:55:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 005311C22360
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 09:55:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51BA41B85C4;
	Thu, 24 Oct 2024 09:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IwAih6DE"
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F18841B6CF7
	for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 09:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729763716; cv=none; b=hpoLElwPfVkueVgAy/cc17SZVBK+8+84QrJ+wc+ZyNr9vdeLmGC4u/7ZJivMJVNaVY4jjMz/gt10iqJ7g3CSl+o2/1hRbkMFgulxBDL9e8yCqEv3dYXzwW1MHNMd1FgrVziiFdkaCYsz+SePSpcQZJhOoHCJZPb1MeSe0qKeRFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729763716; c=relaxed/simple;
	bh=TNP6x2s/VIMYv12njjOtFD2PGJnXTn9zPvsP6t5xiGw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=u/08PHzSaDtkJzV64XdjAbKwv5KAVEB1ogN4XbDCzkgHWjwhJP2UKQdQQDL3D/3prvpPNWSe0ROR9scRQK0CurBkEX0DnbaC8jHcR8cz0xrsm+Ksk3je68TmklT9VuqAmKejhOHNDpQ+7fJJ9V8rgPDG9y70V0FGFFrrsItcPlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IwAih6DE; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2fb5a9c7420so6261041fa.3
        for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 02:55:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729763708; x=1730368508; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=re9grESPsROw4zpnxpNKH6B4r66eUYUwYnoDT6vR9H8=;
        b=IwAih6DE0Hl6XmQVD0Pn6wuJySqMQHpnJgJsrTGD7ONU66DPess5ufGirh+A8tpG+w
         9UNSy+V7gUDgM9b17NbfhzdrQNWLY6WcC/8V5vM1W/B0N8w9KHfTf9DcPARloWdlvSz/
         PnWzIshAxyxbwnbtHBctvVdnbhOaQ3MS0AbpFcSGJCJleZCCHV7OcfD41yMtrOHUyoGd
         ZkCcV72JjRLiGsn4h/3U4PNdCUHLSO0homDfBAdGYVIImg8lYf3i8jb5YwQX1AqfGvQF
         qSsYusyxWSIcfTpMMQq7tgprxkhsZKEGKGqx/Xz6M085zppTW5x4hf3gqNDg1y0FCZJo
         vc0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729763708; x=1730368508;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=re9grESPsROw4zpnxpNKH6B4r66eUYUwYnoDT6vR9H8=;
        b=ViiKTvFDsZal9gmMzPtKcH1u5MOdDoxSlxEtrZpAJhI2EAwxER4TRChN3f/1S2FjUj
         Q55vE+EjG3Z673eNnFLPfPWNyFWEOEyBHz7J1Iwv4jw706/qldcnfv0yb5ID7x0JU5PO
         0fipfLVqAcVltdC3gd8gL0us7uZORU0/g4NNOZIwyzOVJguBqrDYyjDl4WoWSK7LMUfi
         QJtxHuub/vOwgCeab2T426JoFOA4tpL930egJy2P96se2m92RLG+0JqtqDuJjWRZYFLV
         ILZamlaLcPM6pmnoHNa6+ZBBfSVNjuzsq5TgVJ5xZCaoKShfWAAttvZtD8wIq2EyyZw9
         +HYw==
X-Forwarded-Encrypted: i=1; AJvYcCWIqxnkOO8XrvbMfYc2RRFZnB39JLuRgs2gCBlHT8kaSJCaZXqYahEnDBUHjeSssOSew+ravMbRnWAThDY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQOkNctKle7eMertVSOABu7mG5N5wrdp2tsyqXAzUYYmpT9jOY
	KLLdhpdz5SzN9Ic97pYyDZsSGXok+NqKtxnEcnF5sk1u6cqfcN17qfKH/lOcoHi+uhj8UZf8brv
	ScVfl7LfzllnHz8wcdCw566xJNoM=
X-Google-Smtp-Source: AGHT+IHFMgZjQwnppJJD5ToFmpbYjTIfZdG6r2ymPeWmUdrtkmEzH2ZGpePnZY+S1uiLAD/brsBTnlVAc32YtKUkcSI=
X-Received: by 2002:a05:6512:10c9:b0:539:964c:16d9 with SMTP id
 2adb3069b0e04-53b1a381324mr3031885e87.57.1729763707656; Thu, 24 Oct 2024
 02:55:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241016052758.3400359-1-yi.sun@unisoc.com> <20241016052758.3400359-3-yi.sun@unisoc.com>
 <52de7b11-e118-433d-b187-0642e81428ef@kernel.org>
In-Reply-To: <52de7b11-e118-433d-b187-0642e81428ef@kernel.org>
From: yi sun <sunyibuaa@gmail.com>
Date: Thu, 24 Oct 2024 17:54:31 +0800
Message-ID: <CALpufv3fCZXM4aD9cUkOQVk6Er-GxjVXhu-ceFnPAC4Mvnnbzw@mail.gmail.com>
Subject: Re: [RFC PATCH 2/2] f2fs: introduce f2fs_invalidate_consecutive_blocks()
To: Chao Yu <chao@kernel.org>
Cc: Yi Sun <yi.sun@unisoc.com>, jaegeuk@kernel.org, 
	linux-f2fs-devel@lists.sourceforge.net, yi sun <sunyibuaa@gmail.com>, 
	linux-kernel@vger.kernel.org, niuzhiguo84@gmail.com, hao_hao.wang@unisoc.com, 
	ke.wang@unisoc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 17, 2024 at 9:40=E2=80=AFAM Chao Yu <chao@kernel.org> wrote:
>
> On 2024/10/16 13:27, Yi Sun wrote:
> > When doing truncate, consecutive blocks in the same segment
> > can be processed at the same time. So that the efficiency of
> > doing truncate can be improved.
> >
> > Add f2fs_invalidate_compress_pages_range() only for doing truncate.
> > Add check_f2fs_invalidate_consecutive_blocks() only for doing
> > truncate and to determine whether the blocks are continuous and
> > belong to the same segment.
> >
> > Signed-off-by: Yi Sun <yi.sun@unisoc.com>
> > ---
> >   fs/f2fs/compress.c | 14 ++++++++++++++
> >   fs/f2fs/f2fs.h     |  5 +++++
> >   fs/f2fs/file.c     | 34 +++++++++++++++++++++++++++++++++-
> >   fs/f2fs/segment.c  | 25 +++++++++++++++++++++++++
> >   4 files changed, 77 insertions(+), 1 deletion(-)
> >
> > diff --git a/fs/f2fs/compress.c b/fs/f2fs/compress.c
> > index 7f26440e8595..70929a87e9bf 100644
> > --- a/fs/f2fs/compress.c
> > +++ b/fs/f2fs/compress.c
> > @@ -2014,6 +2014,20 @@ void f2fs_invalidate_compress_pages(struct f2fs_=
sb_info *sbi, nid_t ino)
> >       } while (index < end);
> >   }
> >
> > +void f2fs_invalidate_compress_pages_range(struct f2fs_sb_info *sbi,
> > +                                     block_t blkaddr, int cnt)
> > +{
> > +     if (!sbi->compress_inode)
> > +             return;
> > +
> > +     if (cnt < 1) {
> > +             f2fs_bug_on(sbi, 1);
> > +             cnt =3D 1;
> > +     }
> > +
> > +     invalidate_mapping_pages(COMPRESS_MAPPING(sbi), blkaddr, blkaddr =
+ cnt - 1);
> > +}
> > +
> >   int f2fs_init_compress_inode(struct f2fs_sb_info *sbi)
> >   {
> >       struct inode *inode;
> > diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> > index ce00cb546f4a..99767f35678f 100644
> > --- a/fs/f2fs/f2fs.h
> > +++ b/fs/f2fs/f2fs.h
> > @@ -3716,6 +3716,7 @@ int f2fs_create_flush_cmd_control(struct f2fs_sb_=
info *sbi);
> >   int f2fs_flush_device_cache(struct f2fs_sb_info *sbi);
> >   void f2fs_destroy_flush_cmd_control(struct f2fs_sb_info *sbi, bool fr=
ee);
> >   void f2fs_invalidate_blocks(struct f2fs_sb_info *sbi, block_t addr);
> > +void f2fs_invalidate_consecutive_blocks(struct f2fs_sb_info *sbi, bloc=
k_t addr, int cnt);
> >   bool f2fs_is_checkpointed_data(struct f2fs_sb_info *sbi, block_t blka=
ddr);
> >   int f2fs_start_discard_thread(struct f2fs_sb_info *sbi);
> >   void f2fs_drop_discard_cmd(struct f2fs_sb_info *sbi);
> > @@ -4375,6 +4376,8 @@ void f2fs_cache_compressed_page(struct f2fs_sb_in=
fo *sbi, struct page *page,
> >   bool f2fs_load_compressed_page(struct f2fs_sb_info *sbi, struct page =
*page,
> >                                                               block_t b=
lkaddr);
> >   void f2fs_invalidate_compress_pages(struct f2fs_sb_info *sbi, nid_t i=
no);
> > +void f2fs_invalidate_compress_pages_range(struct f2fs_sb_info *sbi,
> > +                                     block_t blkaddr, int cnt);
> >   #define inc_compr_inode_stat(inode)                                 \
> >       do {                                                            \
> >               struct f2fs_sb_info *sbi =3D F2FS_I_SB(inode);           =
 \
> > @@ -4432,6 +4435,8 @@ static inline bool f2fs_load_compressed_page(stru=
ct f2fs_sb_info *sbi,
> >                               struct page *page, block_t blkaddr) { ret=
urn false; }
> >   static inline void f2fs_invalidate_compress_pages(struct f2fs_sb_info=
 *sbi,
> >                                                       nid_t ino) { }
> > +static inline void f2fs_invalidate_compress_pages_range(struct f2fs_sb=
_info *sbi,
> > +                                             block_t blkaddr, int cnt)=
 { }
> >   #define inc_compr_inode_stat(inode)         do { } while (0)
> >   static inline int f2fs_is_compressed_cluster(
> >                               struct inode *inode,
> > diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
> > index 7057efa8ec17..634691e3b5f1 100644
> > --- a/fs/f2fs/file.c
> > +++ b/fs/f2fs/file.c
> > @@ -612,6 +612,18 @@ static int f2fs_file_open(struct inode *inode, str=
uct file *filp)
> >       return finish_preallocate_blocks(inode);
> >   }
> >
> > +static bool check_f2fs_invalidate_consecutive_blocks(struct f2fs_sb_in=
fo *sbi,
> > +                                     block_t blkaddr1, block_t blkaddr=
2)
> > +{
> > +     if (blkaddr2 - blkaddr1 !=3D 1)
> > +             return false;
> > +
> > +     if (GET_SEGNO(sbi, blkaddr1) !=3D GET_SEGNO(sbi, blkaddr2))
> > +             return false;
> > +
> > +     return true;
> > +}
> > +
> >   void f2fs_truncate_data_blocks_range(struct dnode_of_data *dn, int co=
unt)
> >   {
> >       struct f2fs_sb_info *sbi =3D F2FS_I_SB(dn->inode);
> > @@ -621,6 +633,9 @@ void f2fs_truncate_data_blocks_range(struct dnode_o=
f_data *dn, int count)
> >       int cluster_index =3D 0, valid_blocks =3D 0;
> >       int cluster_size =3D F2FS_I(dn->inode)->i_cluster_size;
> >       bool released =3D !atomic_read(&F2FS_I(dn->inode)->i_compr_blocks=
);
> > +     block_t con_start;
> > +     bool run_invalid =3D true;
> > +     int con_cnt =3D 1;
> >
> >       addr =3D get_dnode_addr(dn->inode, dn->node_page) + ofs;
> >
> > @@ -652,7 +667,24 @@ void f2fs_truncate_data_blocks_range(struct dnode_=
of_data *dn, int count)
> >                               valid_blocks++;
> >               }
> >
> > -             f2fs_invalidate_blocks(sbi, blkaddr);
> > +             if (run_invalid)
> > +                     con_start =3D blkaddr;
> > +
> > +             if (count > 1 &&
> > +                     check_f2fs_invalidate_consecutive_blocks(sbi, blk=
addr,
> > +                             le32_to_cpu(*(addr + 1)))) {
> > +                     run_invalid =3D false;
> > +
> > +                     if (con_cnt++ =3D=3D 1)
> > +                             con_start =3D blkaddr;
> > +             } else {
> > +                     run_invalid =3D true;
> > +             }
> > +
> > +             if (run_invalid) {
> > +                     f2fs_invalidate_consecutive_blocks(sbi, con_start=
, con_cnt);
> > +                     con_cnt =3D 1;
> > +             }
> >
> >               if (!released || blkaddr !=3D COMPRESS_ADDR)
> >                       nr_free++;
> > diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
> > index f118faf36d35..edb8a78985ba 100644
> > --- a/fs/f2fs/segment.c
> > +++ b/fs/f2fs/segment.c
> > @@ -2570,6 +2570,31 @@ void f2fs_invalidate_blocks(struct f2fs_sb_info =
*sbi, block_t addr)
> >       up_write(&sit_i->sentry_lock);
> >   }
> >
> > +void f2fs_invalidate_consecutive_blocks(struct f2fs_sb_info *sbi, bloc=
k_t addr, int cnt)
> > +{
> > +     unsigned int segno =3D GET_SEGNO(sbi, addr);
> > +     unsigned int segno2 =3D GET_SEGNO(sbi, addr + cnt - 1);
> > +     struct sit_info *sit_i =3D SIT_I(sbi);
> > +
> > +     f2fs_bug_on(sbi, addr =3D=3D NULL_ADDR || segno !=3D segno2);
> > +     if (addr =3D=3D NEW_ADDR || addr =3D=3D COMPRESS_ADDR)
> > +             return;
> > +
> > +     f2fs_truncate_meta_inode_pages(sbi, addr, cnt);
> > +     f2fs_invalidate_compress_pages_range(sbi, addr, cnt);
> > +
> > +     /* add it into sit main buffer */
> > +     down_write(&sit_i->sentry_lock);
> > +
> > +     update_segment_mtime(sbi, addr, 0);
> > +     update_sit_entry(sbi, addr, -cnt);
> > +
> > +     /* add it into dirty seglist */
> > +     locate_dirty_segment(sbi, segno);
> > +
> > +     up_write(&sit_i->sentry_lock);
>
> I think it needs to clean up this patchset, what about expanding
> f2fs_invalidate_blocks() to support invalidating block address extent?
>
> Something like this:
>
> void f2fs_invalidate_blocks(struct f2fs_sb_info *sbi, block_t blkaddr,
>                                                 unsigned int len)
> {
>         struct sit_info *sit_i =3D SIT_I(sbi);
>         int i;
>
>         /* TODO: do sanity check on blkaddr extent */
>
>         down_write(&sit_i->sentry_lock);
>
>         /* TODO: expand f2fs_invalidate_internal_cache() to invalidate bl=
kaddr extent */
>         f2fs_invalidate_internal_cache(sbi, blkaddr, len);
>
>         for (i =3D 0; i < len; i++) {
>                 update_segment_mtime(sbi, blkaddr, 0);
>                 update_sit_entry(sbi, blkaddr, -1);
>
>                 /* add it into dirty seglist */
>                 locate_dirty_segment(sbi, GET_SEGNO(sbi, blkaddr));
>         }
>
>         up_write(&sit_i->sentry_lock);
> }
>
> Thanks,
>

Hi Chao,
The code structure you proposed is very good and very clear.
I retested using this code structure and found that the speed
of doing truncate also improved, but the improvement was smaller.

So it might be better to use the following code structure.
void f2fs_invalidate_blocks(... , len)
{
    down_write();
    // Process in segments instead of blocks.
    for (i =3D 0; i < segment_num; i++) {
        update_segment_mtime();
        update_sit_entry();

         /* add it into dirty seglist */
        locate_dirty_segment();
     }
    up_write();
}

Time Comparison of rm:
original    optimization(segment unit)    ratio(segment unit)
7.17s           3.27s                                  54.39%
               optimization(block unit)          ratio(block unit)
                    5.12s                                  28.6%

New patches will be sent out by email after they are sorted out.
Thank you for your valuable suggestions.

> > +}
> > +
> >   bool f2fs_is_checkpointed_data(struct f2fs_sb_info *sbi, block_t blka=
ddr)
> >   {
> >       struct sit_info *sit_i =3D SIT_I(sbi);
>

