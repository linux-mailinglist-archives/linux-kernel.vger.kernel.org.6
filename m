Return-Path: <linux-kernel+bounces-386227-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DFE8C9B40B7
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 04:03:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 087B51F22FE6
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 03:03:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5458F1F12F0;
	Tue, 29 Oct 2024 03:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V7yO+gY9"
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78BB92B9A8
	for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 03:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730170971; cv=none; b=EzS/6BgIJQq4kcX5gIF8MOiPsUf+U0XLi7vu0fTdnuveW5FbDBKOv+VnT9Qoif0I0oJUivnQII/9DTue4fjWDqpSCCTki2htKVV0+y4UsTD0DH+z1NnqKihVtLFDfFWXSV4dA+GSN6x0r9K7pTU0TOX44IPnXZy5RoaZV/rYEoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730170971; c=relaxed/simple;
	bh=nL9YUdADRQzF9ohd45TkF8tEllzaNzfxeTgjtVbVxP8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WZivyhgAbfi8CEdYRKhlXOd33j0Hho+Jv5voIBHBa7tZLdJt1MincCE7/IMfz2BFlwrZQrulZBSVB1npE01Y8mmYUEqFQus7+8FXz0Vl6UedBX1u6WNypKGpaAGiChnLUgEn/hCXsB8FfPDLmJnFpBNP1B+Ju7/QFWZoFRALwZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V7yO+gY9; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2fb5fa911aaso66596711fa.2
        for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 20:02:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730170967; x=1730775767; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nO1wdwkfivit0ZHGVS9Vj4jzAP6hvc4ojwt1tVAYzWg=;
        b=V7yO+gY9mTpvrMCEb0oMASKpFmzqa56SYBUHsvE5gkUHpuD+B2BUB4/wxdp7lwh7yF
         K5oQ1BklvlpA38K5UqFlSd4BaRCr6osTzV3LDim2VoXrSW1i6z4oDuwk3cyiSBtRCdOb
         FJrzFdyPRpvTx3aRew7tHtDIDzv1PQ3x3cZyclMw/NWnvLshXuhZIchkJzhQYMI8xxpE
         O18qnPM9RaNJCHtE+EaLZY5BpC0eXu5oOsnat0J/CzG44O4R2Gjkgjt+H0uG0bHtmVvy
         tgUCoC+9OR1EdASJfjNlmmw7ufUj2riymvyGkVUNv1bwg7A0VraueZ37AXQsWGugKU1i
         bWyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730170967; x=1730775767;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nO1wdwkfivit0ZHGVS9Vj4jzAP6hvc4ojwt1tVAYzWg=;
        b=FbCZNBmQ+xUps6bGS+/x6caqTN0VDUB1EFOP300ulNFnen3g4GLoc4Hq2xX26/yub7
         fFJKPrK4ksc3tokyuHcRf5ruxVW0n8axn3ZcbKCqzOO+lfs/xUTaMKGRagowspf8yqBf
         sqiDE97xnKvbUmX75mdH/qrkMp4Gp5ZnAIoKAV5nxQt/KtWfuz9ER13OfJxrEg9gLN5F
         dVp/cy+B0PUoeNw1HAmF/2LsdZG5GoEJpo3HKNQK+IqM59sa+mh6LiEc1EK/VDvzA2dT
         kZqlNeuxETai2IACzqxAhlwRtmoyyBXOzfLhbxKy4qRCrVOduUt/B2cL0kN64mSnOOpL
         3FMg==
X-Forwarded-Encrypted: i=1; AJvYcCWRQZjps5cOJeMMy9NgEZLYBPUp2lNP49zo2XCqwtBJFdNaGJJ51yqGxnyp4q/Xyhq2VFG3q+qoB7Hq/a0=@vger.kernel.org
X-Gm-Message-State: AOJu0YySGYzmp0oVx2jSe7m/GnUan9rhd+g2Keav/g8K4nE1qARy/g39
	iM8h5kGVZZwWtXbBGnUcyZbc/pwbx7UOkI+3y371dS3D3AFQd1kFEG4N+8FcKsc8Qf5Hv6SotTC
	C+UwvcesffXyuxqzB/7OGE77Osdk=
X-Google-Smtp-Source: AGHT+IF+D5RdYReRiYH0oHODlB4S3zTeBnCkuu1HjNLTv1fkArWmGcxICLujd078fJS/XrIfe+pqHPv8YNJfd/qds3U=
X-Received: by 2002:a05:651c:211c:b0:2fb:63b5:c0bc with SMTP id
 38308e7fff4ca-2fcbdf60dfdmr67322531fa.3.1730170966375; Mon, 28 Oct 2024
 20:02:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241016052758.3400359-1-yi.sun@unisoc.com> <20241016052758.3400359-3-yi.sun@unisoc.com>
 <52de7b11-e118-433d-b187-0642e81428ef@kernel.org> <CALpufv3fCZXM4aD9cUkOQVk6Er-GxjVXhu-ceFnPAC4Mvnnbzw@mail.gmail.com>
 <9f6a6a5a-45e4-4008-97d5-fb38b220f516@kernel.org>
In-Reply-To: <9f6a6a5a-45e4-4008-97d5-fb38b220f516@kernel.org>
From: yi sun <sunyibuaa@gmail.com>
Date: Tue, 29 Oct 2024 11:02:09 +0800
Message-ID: <CALpufv29B=W-M9wztXJHwF=KWLKSeGgrEHQA56Z=z=FoDDpH0w@mail.gmail.com>
Subject: Re: [RFC PATCH 2/2] f2fs: introduce f2fs_invalidate_consecutive_blocks()
To: Chao Yu <chao@kernel.org>
Cc: Yi Sun <yi.sun@unisoc.com>, jaegeuk@kernel.org, 
	linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, 
	niuzhiguo84@gmail.com, hao_hao.wang@unisoc.com, ke.wang@unisoc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 24, 2024 at 6:26=E2=80=AFPM Chao Yu <chao@kernel.org> wrote:
>
> On 2024/10/24 17:54, yi sun wrote:
> > On Thu, Oct 17, 2024 at 9:40=E2=80=AFAM Chao Yu <chao@kernel.org> wrote=
:
> >>
> >> On 2024/10/16 13:27, Yi Sun wrote:
> >>> When doing truncate, consecutive blocks in the same segment
> >>> can be processed at the same time. So that the efficiency of
> >>> doing truncate can be improved.
> >>>
> >>> Add f2fs_invalidate_compress_pages_range() only for doing truncate.
> >>> Add check_f2fs_invalidate_consecutive_blocks() only for doing
> >>> truncate and to determine whether the blocks are continuous and
> >>> belong to the same segment.
> >>>
> >>> Signed-off-by: Yi Sun <yi.sun@unisoc.com>
> >>> ---
> >>>    fs/f2fs/compress.c | 14 ++++++++++++++
> >>>    fs/f2fs/f2fs.h     |  5 +++++
> >>>    fs/f2fs/file.c     | 34 +++++++++++++++++++++++++++++++++-
> >>>    fs/f2fs/segment.c  | 25 +++++++++++++++++++++++++
> >>>    4 files changed, 77 insertions(+), 1 deletion(-)
> >>>
> >>> diff --git a/fs/f2fs/compress.c b/fs/f2fs/compress.c
> >>> index 7f26440e8595..70929a87e9bf 100644
> >>> --- a/fs/f2fs/compress.c
> >>> +++ b/fs/f2fs/compress.c
> >>> @@ -2014,6 +2014,20 @@ void f2fs_invalidate_compress_pages(struct f2f=
s_sb_info *sbi, nid_t ino)
> >>>        } while (index < end);
> >>>    }
> >>>
> >>> +void f2fs_invalidate_compress_pages_range(struct f2fs_sb_info *sbi,
> >>> +                                     block_t blkaddr, int cnt)
> >>> +{
> >>> +     if (!sbi->compress_inode)
> >>> +             return;
> >>> +
> >>> +     if (cnt < 1) {
> >>> +             f2fs_bug_on(sbi, 1);
> >>> +             cnt =3D 1;
> >>> +     }
> >>> +
> >>> +     invalidate_mapping_pages(COMPRESS_MAPPING(sbi), blkaddr, blkadd=
r + cnt - 1);
> >>> +}
> >>> +
> >>>    int f2fs_init_compress_inode(struct f2fs_sb_info *sbi)
> >>>    {
> >>>        struct inode *inode;
> >>> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> >>> index ce00cb546f4a..99767f35678f 100644
> >>> --- a/fs/f2fs/f2fs.h
> >>> +++ b/fs/f2fs/f2fs.h
> >>> @@ -3716,6 +3716,7 @@ int f2fs_create_flush_cmd_control(struct f2fs_s=
b_info *sbi);
> >>>    int f2fs_flush_device_cache(struct f2fs_sb_info *sbi);
> >>>    void f2fs_destroy_flush_cmd_control(struct f2fs_sb_info *sbi, bool=
 free);
> >>>    void f2fs_invalidate_blocks(struct f2fs_sb_info *sbi, block_t addr=
);
> >>> +void f2fs_invalidate_consecutive_blocks(struct f2fs_sb_info *sbi, bl=
ock_t addr, int cnt);
> >>>    bool f2fs_is_checkpointed_data(struct f2fs_sb_info *sbi, block_t b=
lkaddr);
> >>>    int f2fs_start_discard_thread(struct f2fs_sb_info *sbi);
> >>>    void f2fs_drop_discard_cmd(struct f2fs_sb_info *sbi);
> >>> @@ -4375,6 +4376,8 @@ void f2fs_cache_compressed_page(struct f2fs_sb_=
info *sbi, struct page *page,
> >>>    bool f2fs_load_compressed_page(struct f2fs_sb_info *sbi, struct pa=
ge *page,
> >>>                                                                block_=
t blkaddr);
> >>>    void f2fs_invalidate_compress_pages(struct f2fs_sb_info *sbi, nid_=
t ino);
> >>> +void f2fs_invalidate_compress_pages_range(struct f2fs_sb_info *sbi,
> >>> +                                     block_t blkaddr, int cnt);
> >>>    #define inc_compr_inode_stat(inode)                               =
  \
> >>>        do {                                                          =
  \
> >>>                struct f2fs_sb_info *sbi =3D F2FS_I_SB(inode);        =
    \
> >>> @@ -4432,6 +4435,8 @@ static inline bool f2fs_load_compressed_page(st=
ruct f2fs_sb_info *sbi,
> >>>                                struct page *page, block_t blkaddr) { =
return false; }
> >>>    static inline void f2fs_invalidate_compress_pages(struct f2fs_sb_i=
nfo *sbi,
> >>>                                                        nid_t ino) { }
> >>> +static inline void f2fs_invalidate_compress_pages_range(struct f2fs_=
sb_info *sbi,
> >>> +                                             block_t blkaddr, int cn=
t) { }
> >>>    #define inc_compr_inode_stat(inode)         do { } while (0)
> >>>    static inline int f2fs_is_compressed_cluster(
> >>>                                struct inode *inode,
> >>> diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
> >>> index 7057efa8ec17..634691e3b5f1 100644
> >>> --- a/fs/f2fs/file.c
> >>> +++ b/fs/f2fs/file.c
> >>> @@ -612,6 +612,18 @@ static int f2fs_file_open(struct inode *inode, s=
truct file *filp)
> >>>        return finish_preallocate_blocks(inode);
> >>>    }
> >>>
> >>> +static bool check_f2fs_invalidate_consecutive_blocks(struct f2fs_sb_=
info *sbi,
> >>> +                                     block_t blkaddr1, block_t blkad=
dr2)
> >>> +{
> >>> +     if (blkaddr2 - blkaddr1 !=3D 1)
> >>> +             return false;
> >>> +
> >>> +     if (GET_SEGNO(sbi, blkaddr1) !=3D GET_SEGNO(sbi, blkaddr2))
> >>> +             return false;
> >>> +
> >>> +     return true;
> >>> +}
> >>> +
> >>>    void f2fs_truncate_data_blocks_range(struct dnode_of_data *dn, int=
 count)
> >>>    {
> >>>        struct f2fs_sb_info *sbi =3D F2FS_I_SB(dn->inode);
> >>> @@ -621,6 +633,9 @@ void f2fs_truncate_data_blocks_range(struct dnode=
_of_data *dn, int count)
> >>>        int cluster_index =3D 0, valid_blocks =3D 0;
> >>>        int cluster_size =3D F2FS_I(dn->inode)->i_cluster_size;
> >>>        bool released =3D !atomic_read(&F2FS_I(dn->inode)->i_compr_blo=
cks);
> >>> +     block_t con_start;
> >>> +     bool run_invalid =3D true;
> >>> +     int con_cnt =3D 1;
> >>>
> >>>        addr =3D get_dnode_addr(dn->inode, dn->node_page) + ofs;
> >>>
> >>> @@ -652,7 +667,24 @@ void f2fs_truncate_data_blocks_range(struct dnod=
e_of_data *dn, int count)
> >>>                                valid_blocks++;
> >>>                }
> >>>
> >>> -             f2fs_invalidate_blocks(sbi, blkaddr);
> >>> +             if (run_invalid)
> >>> +                     con_start =3D blkaddr;
> >>> +
> >>> +             if (count > 1 &&
> >>> +                     check_f2fs_invalidate_consecutive_blocks(sbi, b=
lkaddr,
> >>> +                             le32_to_cpu(*(addr + 1)))) {
> >>> +                     run_invalid =3D false;
> >>> +
> >>> +                     if (con_cnt++ =3D=3D 1)
> >>> +                             con_start =3D blkaddr;
> >>> +             } else {
> >>> +                     run_invalid =3D true;
> >>> +             }
> >>> +
> >>> +             if (run_invalid) {
> >>> +                     f2fs_invalidate_consecutive_blocks(sbi, con_sta=
rt, con_cnt);
> >>> +                     con_cnt =3D 1;
> >>> +             }
> >>>
> >>>                if (!released || blkaddr !=3D COMPRESS_ADDR)
> >>>                        nr_free++;
> >>> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
> >>> index f118faf36d35..edb8a78985ba 100644
> >>> --- a/fs/f2fs/segment.c
> >>> +++ b/fs/f2fs/segment.c
> >>> @@ -2570,6 +2570,31 @@ void f2fs_invalidate_blocks(struct f2fs_sb_inf=
o *sbi, block_t addr)
> >>>        up_write(&sit_i->sentry_lock);
> >>>    }
> >>>
> >>> +void f2fs_invalidate_consecutive_blocks(struct f2fs_sb_info *sbi, bl=
ock_t addr, int cnt)
> >>> +{
> >>> +     unsigned int segno =3D GET_SEGNO(sbi, addr);
> >>> +     unsigned int segno2 =3D GET_SEGNO(sbi, addr + cnt - 1);
> >>> +     struct sit_info *sit_i =3D SIT_I(sbi);
> >>> +
> >>> +     f2fs_bug_on(sbi, addr =3D=3D NULL_ADDR || segno !=3D segno2);
> >>> +     if (addr =3D=3D NEW_ADDR || addr =3D=3D COMPRESS_ADDR)
> >>> +             return;
> >>> +
> >>> +     f2fs_truncate_meta_inode_pages(sbi, addr, cnt);
> >>> +     f2fs_invalidate_compress_pages_range(sbi, addr, cnt);
> >>> +
> >>> +     /* add it into sit main buffer */
> >>> +     down_write(&sit_i->sentry_lock);
> >>> +
> >>> +     update_segment_mtime(sbi, addr, 0);
> >>> +     update_sit_entry(sbi, addr, -cnt);
> >>> +
> >>> +     /* add it into dirty seglist */
> >>> +     locate_dirty_segment(sbi, segno);
> >>> +
> >>> +     up_write(&sit_i->sentry_lock);
> >>
> >> I think it needs to clean up this patchset, what about expanding
> >> f2fs_invalidate_blocks() to support invalidating block address extent?
> >>
> >> Something like this:
> >>
> >> void f2fs_invalidate_blocks(struct f2fs_sb_info *sbi, block_t blkaddr,
> >>                                                  unsigned int len)
> >> {
> >>          struct sit_info *sit_i =3D SIT_I(sbi);
> >>          int i;
> >>
> >>          /* TODO: do sanity check on blkaddr extent */
> >>
> >>          down_write(&sit_i->sentry_lock);
> >>
> >>          /* TODO: expand f2fs_invalidate_internal_cache() to invalidat=
e blkaddr extent */
> >>          f2fs_invalidate_internal_cache(sbi, blkaddr, len);
> >>
> >>          for (i =3D 0; i < len; i++) {
> >>                  update_segment_mtime(sbi, blkaddr, 0);
> >>                  update_sit_entry(sbi, blkaddr, -1);
> >>
> >>                  /* add it into dirty seglist */
> >>                  locate_dirty_segment(sbi, GET_SEGNO(sbi, blkaddr));
> >>          }
> >>
> >>          up_write(&sit_i->sentry_lock);
> >> }
> >>
> >> Thanks,
> >>
> >
>
> Hi Yi,
>
> > Hi Chao,
> > The code structure you proposed is very good and very clear.
> > I retested using this code structure and found that the speed
> > of doing truncate also improved, but the improvement was smaller.
> >
> > So it might be better to use the following code structure.
> > void f2fs_invalidate_blocks(... , len)
> > {
> >      down_write();
> >      // Process in segments instead of blocks.
> >      for (i =3D 0; i < segment_num; i++) {
> >          update_segment_mtime();
> >          update_sit_entry();
>
> Ah, yes, it can merge more operations and do it w/ segment granularity.
>
> Can you please try:
>
>                 for (j =3D start; j < end; j++)
>                         update_sit_entry();
>
> Maybe it can eliminate change in update_sit_entry().
>
> >
> >           /* add it into dirty seglist */
> >          locate_dirty_segment();
> >       }
> >      up_write();
> > }
> >
> > Time Comparison of rm:
> > original    optimization(segment unit)    ratio(segment unit)
> > 7.17s           3.27s                                  54.39%
> >                 optimization(block unit)          ratio(block unit)
> >                      5.12s                                  28.6%
>
> Thanks for the test and feedback.
>
> Thanks,
>

Hi Chao,

I retested like this:

Test1(no change function update_sit_entry):
void f2fs_invalidate_blocks(... , len) {
    down_write();
    time1 =3D ktime_get();
    for (i =3D 0; i < segment_num; i++) {
        update_segment_mtime();
        for() {
            update_sit_entry(...,-1);
        }
        locate_dirty_segment();
    }
    time2 =3D ktime_get();
    up_write();
}

Test2(change function update_sit_entry):
void f2fs_invalidate_blocks(... , len) {
    down_write();
    time1 =3D ktime_get();
    for (i =3D 0; i < segment_num; i++) {
        update_segment_mtime();
        update_sit_entry();
        locate_dirty_segment();
    }
    time2 =3D ktime_get();
    up_write();
}

Result(the sum of (time2 - time1)):
test1                             test2                           ratio
963807433 ns              209316903 ns            78.3%

Perhaps it would be more beneficial to allow the update_sit_entry() functio=
n
to handle multiple consecutive blocks.

> >
> > New patches will be sent out by email after they are sorted out.
> > Thank you for your valuable suggestions.
> >
> >>> +}
> >>> +
> >>>    bool f2fs_is_checkpointed_data(struct f2fs_sb_info *sbi, block_t b=
lkaddr)
> >>>    {
> >>>        struct sit_info *sit_i =3D SIT_I(sbi);
> >>
>

