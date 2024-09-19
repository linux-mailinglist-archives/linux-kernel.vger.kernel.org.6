Return-Path: <linux-kernel+bounces-333053-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FD4297C2D2
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 04:23:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 68F351C2161E
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 02:23:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD4A41EA84;
	Thu, 19 Sep 2024 02:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dFieFpKt"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3191381E
	for <linux-kernel@vger.kernel.org>; Thu, 19 Sep 2024 02:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726712612; cv=none; b=uHk8ryYQj68S6A500bkVTiw24MvrR+BDVFtbHq2cwF++SVLPii8IZKhA0B/RDhrGUnz97qv7RfUlcId+mxKxFbUcQMbKmd99OZ8GGOe+onrDSkaJYo6MhTHAOkh6PNWaEfGeR+XPB0PLYdJgGZ11i4/Q9r+BrJtcfagf4DEzfK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726712612; c=relaxed/simple;
	bh=fvk7+7I1gV1sxwJ0HYyzs/2LgEKMQ6rHHQ3R1DNUQ4s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LeKxRlatoHxQNVHylhQvaoNRGWctl1rK768NLvH4pP4JfMrujCAHQ9XY+txDvk6Zc6p/i5jJH3z+0kM2g/Zv/BaOagDHt1IQqIFxSZuund6WUNOa6QMiPkeFcRnVGyRMCgjKSFzHImLkjQ3SrRZGU0CMswAeHSmVCXIBiSbREfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dFieFpKt; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-42cdefe9ae8so470485e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 18 Sep 2024 19:23:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726712608; x=1727317408; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qhLFHkcyTLaLAQFd6owrvSOx6913wgzUyjCt8LLZGTw=;
        b=dFieFpKtmYaP+xmJKfSLr2+z1BIpUGsuxR6rdyO3BL/8vQLuIdufnvgmdegKu2zgcy
         q2hGb16wso+a1rC/nJDQQrgQO1pGhbPADDl/tKX7jnti2RdoKMJaNxBkh2jKDZKjTpTF
         LTWF210VEKBr841LoahCa9fBwPTylHHxXf7dmlWyQko/BvuNt7iXlYTzfYUp4h5ouM+V
         0pkYTpT2tZiEWrmgVUbu5+UZRytHHwaX0fTHfHHMy7V4L48v4PBszZSdrWq1U/qAVx0p
         E/9G9JQHGKFO9eM/PRG1jJP6GtAQsoTDjhlrx9C+8N+tB7LiH68orXqrwpp5FMccZ3Lc
         jUZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726712608; x=1727317408;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qhLFHkcyTLaLAQFd6owrvSOx6913wgzUyjCt8LLZGTw=;
        b=bU96/rBN8dIa4bkEy+oj6N+p8j+wOaWQ1Aje5+XvqocavUVEPTjGY3SgfqAbVa7SWb
         7Ay7Lnq0uAacjxPypwUNLeUX99gV4bbNWWb0a6si3LpcsXlca9ln0ai5mU0tYY7D6HwJ
         r2XDEA/pASYDZJdrDiECH/oZg3XEKywlSUPlwRcGaLDYGcLbIJHEOBwNoNJXBvfjuKML
         fcDQGNuY7q3obQWva5BHmvminkjwONHwkW7xfaCt4PriWZIqXxftm0e7vZh1CTCvW/fZ
         ona5WFvdpUlzZbGM83BzC5bnjr0DGDsIPAOUuNQ32hQBAKNsJI/sz+ELg7cUpc4RTTjG
         ONwQ==
X-Forwarded-Encrypted: i=1; AJvYcCWzrsGar4aQMnzQMKeceehLlZBWAXnuNQmtx6mr1oPa1ie1fTzAJizFPK/+EcrkoFlrzCfLNcVcliiwrJk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzuOxlMs+5Hsic47W+L/B5yVPngnhaaI57Kwuu+0KQSKJnEjCvm
	PtQi7P/Ga+wpYsPUC1jGsQ8JOm1nVzXg0WqJkjWH3bapwNLpbaIIV2JtxeEVpHu5dplST05YgWd
	gZYWvFb4cmD+a7MzC4pcJgfmnZWY=
X-Google-Smtp-Source: AGHT+IEQwE+ThE/YOYpbVVYE+8FMAFtPY47RuCYrjbUPt+edKMJfmiWw86bn75YFfVDR9A3zwT5W2FyPgC7RrlnITEc=
X-Received: by 2002:a05:6000:1f89:b0:376:b7e4:c53d with SMTP id
 ffacd0b85a97d-378c2a4ae79mr7568845f8f.0.1726712608016; Wed, 18 Sep 2024
 19:23:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1726123214-208356-1-git-send-email-liuderong@oppo.com>
 <1726123214-208356-3-git-send-email-liuderong@oppo.com> <17ceed17-b17f-42d9-8c82-79f1f4814c1a@kernel.org>
In-Reply-To: <17ceed17-b17f-42d9-8c82-79f1f4814c1a@kernel.org>
From: Zhiguo Niu <niuzhiguo84@gmail.com>
Date: Thu, 19 Sep 2024 10:23:16 +0800
Message-ID: <CAHJ8P3LNpZamiva_Ktck+tRKXvyAAYK0dg_z2Mwjiq41aeMF0Q@mail.gmail.com>
Subject: Re: [f2fs-dev] [PATCH v2 2/2] f2fs: introduce get_section_mtime
To: Chao Yu <chao@kernel.org>
Cc: liuderong@oppo.com, jaegeuk@kernel.org, linux-kernel@vger.kernel.org, 
	linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Chao Yu via Linux-f2fs-devel <linux-f2fs-devel@lists.sourceforge.net>
=E4=BA=8E2024=E5=B9=B49=E6=9C=8818=E6=97=A5=E5=91=A8=E4=B8=89 14:45=E5=86=
=99=E9=81=93=EF=BC=9A
>
> On 2024/9/12 14:40, liuderong@oppo.com wrote:
> > From: liuderong <liuderong@oppo.com>
> >
> > When segs_per_sec is larger than 1, section may contain free segments,
> > mtime should be the mean value of each valid segments,
> > so introduce get_section_mtime to exclude free segments in a section.
> >
> > Signed-off-by: liuderong <liuderong@oppo.com>
> > ---
> >   fs/f2fs/f2fs.h    |  2 ++
> >   fs/f2fs/gc.c      | 15 ++-------------
> >   fs/f2fs/segment.c | 41 ++++++++++++++++++++++++++++++++++++-----
> >   3 files changed, 40 insertions(+), 18 deletions(-)
> >
> > diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> > index 4dcdcdd..d6adf0f 100644
> > --- a/fs/f2fs/f2fs.h
> > +++ b/fs/f2fs/f2fs.h
> > @@ -3762,6 +3762,8 @@ enum rw_hint f2fs_io_type_to_rw_hint(struct f2fs_=
sb_info *sbi,
> >   unsigned int f2fs_usable_segs_in_sec(struct f2fs_sb_info *sbi);
> >   unsigned int f2fs_usable_blks_in_seg(struct f2fs_sb_info *sbi,
> >                       unsigned int segno);
> > +unsigned long long get_section_mtime(struct f2fs_sb_info *sbi,
> > +                     unsigned int segno);
>
> Hi Derong,
>
> It needs to add "f2fs_" prefix for get_section_mtime() to avoid global
> namespace pollution.
>
> >
> >   #define DEF_FRAGMENT_SIZE   4
> >   #define MIN_FRAGMENT_SIZE   1
> > diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
> > index 6299639..03c6117 100644
> > --- a/fs/f2fs/gc.c
> > +++ b/fs/f2fs/gc.c
> > @@ -332,20 +332,14 @@ static unsigned int check_bg_victims(struct f2fs_=
sb_info *sbi)
> >   static unsigned int get_cb_cost(struct f2fs_sb_info *sbi, unsigned in=
t segno)
> >   {
> >       struct sit_info *sit_i =3D SIT_I(sbi);
> > -     unsigned int secno =3D GET_SEC_FROM_SEG(sbi, segno);
> > -     unsigned int start =3D GET_SEG_FROM_SEC(sbi, secno);
> >       unsigned long long mtime =3D 0;
> >       unsigned int vblocks;
> >       unsigned char age =3D 0;
> >       unsigned char u;
> > -     unsigned int i;
> >       unsigned int usable_segs_per_sec =3D f2fs_usable_segs_in_sec(sbi)=
;
> >
> > -     for (i =3D 0; i < usable_segs_per_sec; i++)
> > -             mtime +=3D get_seg_entry(sbi, start + i)->mtime;
> > +     mtime =3D get_section_mtime(sbi, segno);
> >       vblocks =3D get_valid_blocks(sbi, segno, true);
> > -
> > -     mtime =3D div_u64(mtime, usable_segs_per_sec);
> >       vblocks =3D div_u64(vblocks, usable_segs_per_sec);
> >
> >       u =3D BLKS_TO_SEGS(sbi, vblocks * 100);
> > @@ -485,10 +479,7 @@ static void add_victim_entry(struct f2fs_sb_info *=
sbi,
> >                               struct victim_sel_policy *p, unsigned int=
 segno)
> >   {
> >       struct sit_info *sit_i =3D SIT_I(sbi);
> > -     unsigned int secno =3D GET_SEC_FROM_SEG(sbi, segno);
> > -     unsigned int start =3D GET_SEG_FROM_SEC(sbi, secno);
> >       unsigned long long mtime =3D 0;
> > -     unsigned int i;
> >
> >       if (unlikely(is_sbi_flag_set(sbi, SBI_CP_DISABLED))) {
> >               if (p->gc_mode =3D=3D GC_AT &&
> > @@ -496,9 +487,7 @@ static void add_victim_entry(struct f2fs_sb_info *s=
bi,
> >                       return;
> >       }
> >
> > -     for (i =3D 0; i < SEGS_PER_SEC(sbi); i++)
> > -             mtime +=3D get_seg_entry(sbi, start + i)->mtime;
> > -     mtime =3D div_u64(mtime, SEGS_PER_SEC(sbi));
> > +     mtime =3D get_section_mtime(sbi, segno);
> >
> >       /* Handle if the system time has changed by the user */
> >       if (mtime < sit_i->min_mtime)
> > diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
> > index 6627394..e62e722 100644
> > --- a/fs/f2fs/segment.c
> > +++ b/fs/f2fs/segment.c
> > @@ -5389,6 +5389,41 @@ unsigned int f2fs_usable_segs_in_sec(struct f2fs=
_sb_info *sbi)
> >       return SEGS_PER_SEC(sbi);
> >   }
> >
> > +unsigned long long get_section_mtime(struct f2fs_sb_info *sbi,
> > +     unsigned int segno)
> > +{
> > +     unsigned int usable_segs_per_sec =3D f2fs_usable_segs_in_sec(sbi)=
;
> > +     unsigned int secno =3D 0, start =3D 0;
> > +     struct free_segmap_info *free_i =3D FREE_I(sbi);
> > +     unsigned int valid_seg_count =3D 0;
> > +     unsigned long long mtime =3D 0;
> > +     unsigned int i =3D 0;
> > +
> > +     if (segno =3D=3D NULL_SEGNO)
> > +             return 0;
>
> No needed.
>
> > +
> > +     secno =3D GET_SEC_FROM_SEG(sbi, segno);
> > +     start =3D GET_SEG_FROM_SEC(sbi, secno);
> > +
> > +     if (!__is_large_section(sbi))
> > +             return get_seg_entry(sbi, start + i)->mtime;
> > +
> > +     for (i =3D 0; i < usable_segs_per_sec; i++) {
> > +             /* for large section, only check the mtime of valid segme=
nts */
> > +             spin_lock(&free_i->segmap_lock);
> > +             if (test_bit(start + i, free_i->free_segmap)) {
> > +                     mtime +=3D get_seg_entry(sbi, start + i)->mtime;
> > +                     valid_seg_count++;
> > +             }
> > +             spin_unlock(&free_i->segmap_lock);
> > +     }
>
> After commit 6f3a01ae9b72 ("f2fs: record average update time of segment")=
,
> mtime of segment starts to indicate average update time of segment.
>
> So it needs to change like this?
>
> for (i =3D 0; i < usable_segs_per_sec; i++) {
>         struct seg_entry *se =3D get_seg_entry(sbi, start + i);
>
>         mtime +=3D se->mtime * se->valid_blocks;
>         total_valid_blocks +=3D se->valid_blocks;
> }
hi Chao,
after I read this patch from Derong and base on your this comment,
I have some doubts=EF=BC=9A
mtime is update in update_segment_mtime, and this API is called by
more than one path=EF=BC=8C such as f2fs_invalidate_blocks and f2fs_allocat=
e_data_block,
and se->mtime is calculated by the following  flow if se->mtime is not null=
.
--------------------------------
se->mtime =3D div_u64(se->mtime * se->valid_blocks + mtime,
se->valid_blocks + 1);
--------------------------------
if this is called from f2fs_invalidate_blocks, se->mtime is still calculate=
d by
mtime / se->valid_blocks + 1, but the real value of se->valid_blocks will
will be reduced  1=EF=BC=8CSo isn=E2=80=99t it a bit inaccurate just calcul=
ating valid
blocks in this patch?
thanks!
>
> if (total_valid_blocks =3D=3D 0)
>         return 0;
>
> return div_u64(mtime, total_valid_blocks);
>
> Thanks,
>
> > +
> > +     if (valid_seg_count =3D=3D 0)
> > +             return 0;
> > +
> > +     return div_u64(mtime, valid_seg_count);
> > +}
> > +
> >   /*
> >    * Update min, max modified time for cost-benefit GC algorithm
> >    */
> > @@ -5402,13 +5437,9 @@ static void init_min_max_mtime(struct f2fs_sb_in=
fo *sbi)
> >       sit_i->min_mtime =3D ULLONG_MAX;
> >
> >       for (segno =3D 0; segno < MAIN_SEGS(sbi); segno +=3D SEGS_PER_SEC=
(sbi)) {
> > -             unsigned int i;
> >               unsigned long long mtime =3D 0;
> >
> > -             for (i =3D 0; i < SEGS_PER_SEC(sbi); i++)
> > -                     mtime +=3D get_seg_entry(sbi, segno + i)->mtime;
> > -
> > -             mtime =3D div_u64(mtime, SEGS_PER_SEC(sbi));
> > +             mtime =3D get_section_mtime(sbi, segno);
> >
> >               if (sit_i->min_mtime > mtime)
> >                       sit_i->min_mtime =3D mtime;
>
>
>
> _______________________________________________
> Linux-f2fs-devel mailing list
> Linux-f2fs-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

