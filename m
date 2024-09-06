Return-Path: <linux-kernel+bounces-319440-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 12A8296FC9E
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 22:23:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3029B1C2239D
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 20:23:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A70AE1D6789;
	Fri,  6 Sep 2024 20:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AMEM1b2T"
Received: from mail-ua1-f49.google.com (mail-ua1-f49.google.com [209.85.222.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C4B61B85DA
	for <linux-kernel@vger.kernel.org>; Fri,  6 Sep 2024 20:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725654205; cv=none; b=LWeVQlUDLVEY0/lwq4Iog1vdo1T6ukVOnT3tp4LZYkTwB6cje35Swg6R69q2K4cb9MuZN5BCLPr3XfzcRREKiCTxGMtga4xOZVXY3OnSBs414UWXT4scuyAIa3DpICZVXoeTM7iBPJT5qrVq1Me9OHdCex8m/z2gtQQAd0AnSfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725654205; c=relaxed/simple;
	bh=4B0JL4GdzkZjmJPWJuXyJQr7yGkNMhD/5tTUOgXudwg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LiTgwu9l9lUaZGofO9IefFrWU7OBKC5FmqeTOWjughhHqMkCt+acVXtxL1wFjK18MS4NtlZIyNGCvg+2r91g2IyPzmD478iFUNNWgEEqsxHYSKEhwFSze1XIhQYH1Ft5Ofj4kU0yjJIVo7pjar6pw+a8Rd9CF8P2jgrfHbUyq20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AMEM1b2T; arc=none smtp.client-ip=209.85.222.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f49.google.com with SMTP id a1e0cc1a2514c-8487af8a274so672497241.0
        for <linux-kernel@vger.kernel.org>; Fri, 06 Sep 2024 13:23:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725654202; x=1726259002; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A++Z791gkjq6QACDFHzJLpLm7CT3//vqJgMU5AApAas=;
        b=AMEM1b2TDLI2++JqupSIwoimCV4PM7CHlwWaXuInoqVpjycH0SfZf0bncj4HHm0gd1
         h6YlpYlY618ryGoe9GGHoc0qEWfFwlMptG898ndcFZ85kCLKTV/Pydlirl75lzNDLR0B
         PWpmqOoHLoUsd9iS1vdrGvHMS/JScTORxjhdO9CzDleqwZwVeNf/IjYn9/FIPduVS3gQ
         UmTtaKMWU3fOvkO6+JFU0pYpzilzLBcxs8tzPk9WEI5xKMZWeFGhl3iA6ZvEjwnBf2pE
         Ftyl/U9gDdKcPaxU2T/WlvP5EAnbDWqI+CisfjllprDmxaqI7G9wLbpf1obSvNVE5n52
         Mexg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725654202; x=1726259002;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A++Z791gkjq6QACDFHzJLpLm7CT3//vqJgMU5AApAas=;
        b=MxRXKcGlTkgCilQ6z1KRRjWE7kWAVi6z6rN8NjodB/EvRKEC1nYmvxu/7puqbistPA
         zkbzvO9ANF9dpyM5E8/dvROTB1ahnqBcGXpi3TN/wqI1kPvs2clbpzW0j1mlm1UJtOwT
         t8mHd4Ozpp47ncXZOjv5Scpv2fwkafgYCEmLyXUr4eBP+fhXY0nUTyituwuJoDnnDksk
         ajQ/5h+5bZ9lSV6QvFo1Pjcvbzqt6BCqrrGRKrf/DPx3Vs8g8iw/TgPij0kY2HE/yEFk
         RDqIoe7IdG6ij+B21euxniz+z4eAOhTvnD9UMSttK65+sG9lpYaFQxZpkqRzzpglkeWp
         dwUg==
X-Gm-Message-State: AOJu0YwYrjKiFVD0SLOXDhIBnRgnKNG5AWOwpdFZdoo/WIWZKM1M5dE4
	K9hYphHsDeu1iWxA0JFK3FGYqGfBNI9d4Akfn4w2QqmTd76WEZ7orPhfkiCJ2stR9DMYgvsEXGy
	qRt6ykcTJihL6bW5N6dA0kjj/Gxc=
X-Google-Smtp-Source: AGHT+IGFEDLHyafKDrN6fpuRLiKotM6Jf0bh+gYC99xcBWlyl5uETSjcE8noSLRFUgpdtqWo+5Zh/bpk8kjcNhuiRxw=
X-Received: by 2002:a05:6102:509e:b0:498:d12b:4774 with SMTP id
 ada2fe7eead31-49beccf629cmr569574137.7.1725654202146; Fri, 06 Sep 2024
 13:23:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240829215242.3641502-1-daeho43@gmail.com> <20240829215242.3641502-2-daeho43@gmail.com>
 <501416af-b08c-448b-881d-0915575e22f5@kernel.org>
In-Reply-To: <501416af-b08c-448b-881d-0915575e22f5@kernel.org>
From: Daeho Jeong <daeho43@gmail.com>
Date: Fri, 6 Sep 2024 13:23:11 -0700
Message-ID: <CACOAw_wgTOAQGJ3vbvp_Dqi_J0ZEsqWRFny-iczpyMD=kpxG-w@mail.gmail.com>
Subject: Re: [f2fs-dev] [PATCH 2/7] f2fs: read summary blocks with the correct
 amount for migration_granularity
To: Chao Yu <chao@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, 
	kernel-team@android.com, Daeho Jeong <daehojeong@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 5, 2024 at 7:56=E2=80=AFPM Chao Yu <chao@kernel.org> wrote:
>
> On 2024/8/30 5:52, Daeho Jeong wrote:
> > From: Daeho Jeong <daehojeong@google.com>
> >
> > Now we do readahead for a full section by not considering
> > migration_granularity and it triggers unnecessary read. So, make it rea=
d
> > with the correct amount.
> >
> > Signed-off-by: Daeho Jeong <daehojeong@google.com>
> > ---
> >   fs/f2fs/gc.c | 33 ++++++++++++++++++++-------------
> >   1 file changed, 20 insertions(+), 13 deletions(-)
> >
> > diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
> > index 46e3bc26b78a..b5d3fd40b17a 100644
> > --- a/fs/f2fs/gc.c
> > +++ b/fs/f2fs/gc.c
> > @@ -1708,24 +1708,33 @@ static int do_garbage_collect(struct f2fs_sb_in=
fo *sbi,
> >       struct blk_plug plug;
> >       unsigned int segno =3D start_segno;
> >       unsigned int end_segno =3D start_segno + SEGS_PER_SEC(sbi);
> > +     unsigned int sec_end_segno;
> >       int seg_freed =3D 0, migrated =3D 0;
> >       unsigned char type =3D IS_DATASEG(get_seg_entry(sbi, segno)->type=
) ?
> >                                               SUM_TYPE_DATA : SUM_TYPE_=
NODE;
> >       unsigned char data_type =3D (type =3D=3D SUM_TYPE_DATA) ? DATA : =
NODE;
> >       int submitted =3D 0;
> >
> > -     if (__is_large_section(sbi))
> > -             end_segno =3D rounddown(end_segno, SEGS_PER_SEC(sbi));
> > +     if (__is_large_section(sbi)) {
> > +             sec_end_segno =3D rounddown(end_segno, SEGS_PER_SEC(sbi))=
;
> >
> > -     /*
> > -      * zone-capacity can be less than zone-size in zoned devices,
> > -      * resulting in less than expected usable segments in the zone,
> > -      * calculate the end segno in the zone which can be garbage colle=
cted
> > -      */
> > -     if (f2fs_sb_has_blkzoned(sbi))
> > -             end_segno -=3D SEGS_PER_SEC(sbi) -
> > +             /*
> > +              * zone-capacity can be less than zone-size in zoned devi=
ces,
> > +              * resulting in less than expected usable segments in the=
 zone,
> > +              * calculate the end segno in the zone which can be garba=
ge
> > +              * collected
> > +              */
> > +             if (f2fs_sb_has_blkzoned(sbi))
> > +                     sec_end_segno -=3D SEGS_PER_SEC(sbi) -
> >                                       f2fs_usable_segs_in_sec(sbi, segn=
o);
> >
> > +             if (gc_type =3D=3D BG_GC)
> > +                     end_segno =3D start_segno + sbi->migration_granul=
arity;
> > +
> > +             if (end_segno > sec_end_segno)
> > +                     end_segno =3D sec_end_segno;
> > +     }
> > +
> >       sanity_check_seg_type(sbi, get_seg_entry(sbi, segno)->type);
> >
> >       /* readahead multi ssa blocks those have contiguous address */
> > @@ -1762,9 +1771,6 @@ static int do_garbage_collect(struct f2fs_sb_info=
 *sbi,
> >
> >               if (get_valid_blocks(sbi, segno, false) =3D=3D 0)
> >                       goto freed;
> > -             if (gc_type =3D=3D BG_GC && __is_large_section(sbi) &&
> > -                             migrated >=3D sbi->migration_granularity)
>
> It seems we change the logic from migrating "migration_granularity" segme=
nts which
> has valid blocks to scanning "migration_granularity" segments and try mig=
rating
> valid blocks in those segments.
>
> IIUC, when background GC recycle sparse zone, it will take gc thread more=
 round,
> it seems low efficient. How do you think of keeping previous implementati=
on?

I got your point. However, with zoned devices having 1GB sections, per
every round, we should
touch almost 2MB size of ssa block pages, even though we didn't need
to do it. Maybe, we can introduce
another sysfs node like migration_window_limit, which can be set as
double as migration_granuality by default,
limiting the size of scanning.

>
> Thanks,
>
> > -                     goto skip;
> >               if (!PageUptodate(sum_page) || unlikely(f2fs_cp_error(sbi=
)))
> >                       goto skip;
> >
> > @@ -1803,7 +1809,8 @@ static int do_garbage_collect(struct f2fs_sb_info=
 *sbi,
> >
> >               if (__is_large_section(sbi))
> >                       sbi->next_victim_seg[gc_type] =3D
> > -                             (segno + 1 < end_segno) ? segno + 1 : NUL=
L_SEGNO;
> > +                             (segno + 1 < sec_end_segno) ?
> > +                                     segno + 1 : NULL_SEGNO;
> >   skip:
> >               f2fs_put_page(sum_page, 0);
> >       }
>

