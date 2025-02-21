Return-Path: <linux-kernel+bounces-526097-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CF742A3F9F2
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 17:03:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D1EAE7A8334
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 15:56:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F46220E018;
	Fri, 21 Feb 2025 15:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hOKKCKCp"
Received: from mail-vk1-f182.google.com (mail-vk1-f182.google.com [209.85.221.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1F3F205ABF
	for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 15:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740153280; cv=none; b=SjriVaDrHI4+3ejlbdjMrfIc/9JyRUfAf40RKN2F1AJSDdU57H8lSbOfX26ZxdWlz1JZEGNh5IUA9psZXA4bkrj7Aj8AP1Ooo3QtRDZzvJWnIpn11tQjdA3EM9VgCGAHPILgz+qPMdRqXzb8n02vutpHu1LdoemsaRtYYuJFaUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740153280; c=relaxed/simple;
	bh=RKztKjhyXW+cJChux8lNeRXx2Zf3ZV/zmyd+5Z+JIKM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MfHNnVmGbni1omdqmXYuCP/DzPXc/7HGTPXeddilKvXHgaSnPKq9xDq2uppF6HybJi5TvN4iuTjWoMEWVEBLTZEg0ysjlsJ562hmx25s80syMdgvtFmbyttFtHyhvqc0lO3IyiEeh4Q8vttgWh4I8EzpQztJC+0hnDf8MnvG3hs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hOKKCKCp; arc=none smtp.client-ip=209.85.221.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f182.google.com with SMTP id 71dfb90a1353d-520aede8ae3so669053e0c.0
        for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 07:54:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740153277; x=1740758077; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VAlKnvF+99/2m3lfV6+cqEZKBv2WazQ70+jW+VGN9e4=;
        b=hOKKCKCpirLIFsbbEjaudC48qTPBYi8l6sPDrisuu+OymFT13qN3PD4wf9+15lakhI
         /Bdblo3KDbRIfLrRHbSqD4ApR2l40PoRL7h26Z9Pf+M92uOh1ID9ImST4c/agLdL7oOc
         muh5VfGSIQFmr/UOJNVGU3vZWPUJcDjG4/t6aJh6vg3YsiZU0aioNLisjywtd2PPQOSf
         oydnN8+vWLGI4aI0I7HgX5GKKfL7Pu117Mtdna1dSqunJNlnnxRR/SVWGBX8jUzsuFN9
         P2ty6mjHb7DTLiqhYRLbpZkcnfjpInIm9LVMHTe4mtehvTL5FkMMLd4HwZ3u7r/vdAhE
         GO3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740153277; x=1740758077;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VAlKnvF+99/2m3lfV6+cqEZKBv2WazQ70+jW+VGN9e4=;
        b=BUMAnIoDbzsIXbHfvCpc4ufEddEY1ZLKygv5XZaMTLIUWM3dpTIoCXf7GOKZPFY4t6
         rKz3ZplXIIZXnM2TuOR37MrnuPhl8g4aMqmmh9q4uRs3mh70DoVySF5sDsYt/3IQTwM6
         0EhO70a1LXVNwlJsSwvukTl5LvdVafS6paMRAxw2KAkgzD4PSgf9mjm460dvLx52cWmP
         +CPDlsEwuQSxMq9R43ERK1r2I4FfX+yovoxTljVL74imgCg1YgVVxH5fOt3K43tKs9S0
         xgoe/s8i5CE67lowxhnLheNX46fbMTJ1oYNoVwe0c1TnBUhogyXr/+BrfwkqQSlTFv5i
         jLXg==
X-Gm-Message-State: AOJu0Yy1yWqSF0m5/+QHyMm/LChyAXE0AbobhnkK2+cVZKbaxvstJlL4
	TjdTd/S4teatNXxXCJ0RUQ3/cB4n3xlvHpyfu1b8p0ilM6qdozVCuyCdo9ST9D55znkLHZCN3DZ
	Itwa3cOb2entbo07Cd4vpZKwQCLY=
X-Gm-Gg: ASbGnctS5wIuuNWXdZ4Uq4RTzzAEhSxZYbhY1iLxxaw6VIumDM/XkVS64dUDLHN86Ud
	QzJ0jdb8WkOtTBH61ZtbQAHV0ZUrhQmNh9GLZymaOHPfrW6cZUstmPP27tUW19pnSAI2/D9R49u
	rDdZjPUqZJAgd/If1vxpbVHLEXa2rjuyF9CZ0u6B0=
X-Google-Smtp-Source: AGHT+IGNJWciAvxYEU43nHmk601QXqX/yyFJBTmJeYfZwXATYOt+ya/3dlODsznzoAksL9U/MMx1wrMX1tanFDsjBKc=
X-Received: by 2002:a05:6122:1790:b0:520:8911:df12 with SMTP id
 71dfb90a1353d-521ee4b4ffemr1711921e0c.10.1740153277426; Fri, 21 Feb 2025
 07:54:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250220154904.2698964-1-daeho43@gmail.com> <e62dfe59-61a9-426f-bec4-69223b7247f9@kernel.org>
In-Reply-To: <e62dfe59-61a9-426f-bec4-69223b7247f9@kernel.org>
From: Daeho Jeong <daeho43@gmail.com>
Date: Fri, 21 Feb 2025 07:54:26 -0800
X-Gm-Features: AWEUYZmIXYjVM-71wxVtJACatMvbaTMJ5MG_qRydRZx-EkilO0T0WnAkuZKE-E4
Message-ID: <CACOAw_yOYnJ+zsFS339u8tonQNZkM9kjkAdouD9gooydQL0Zaw@mail.gmail.com>
Subject: Re: [f2fs-dev] [PATCH] f2fs: do not use granularity control for
 segment or section unit discard
To: Chao Yu <chao@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, 
	kernel-team@android.com, Daeho Jeong <daehojeong@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 20, 2025 at 6:19=E2=80=AFPM Chao Yu <chao@kernel.org> wrote:
>
> On 2025/2/20 23:49, Daeho Jeong wrote:
> > From: Daeho Jeong <daehojeong@google.com>
> >
> > When we support segment or section unit discard, we should only focus o=
n
> > how actively we submit discard commands for only one type of size, such
> > as segment or section. In this case, we don't have to manage smaller
> > sized discards.
> >
> > Reported-by: Yohan Joung <yohan.joung@sk.com>
> > Signed-off-by: Daeho Jeong <daehojeong@google.com>
> > ---
> >   fs/f2fs/segment.c | 29 ++++++++++++++++++++---------
> >   1 file changed, 20 insertions(+), 9 deletions(-)
> >
> > diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
> > index c282e8a0a2ec..4316ff7aa0d1 100644
> > --- a/fs/f2fs/segment.c
> > +++ b/fs/f2fs/segment.c
> > @@ -1661,12 +1661,20 @@ static int __issue_discard_cmd(struct f2fs_sb_i=
nfo *sbi,
> >                               f2fs_time_over(sbi, UMOUNT_DISCARD_TIMEOU=
T))
> >                       break;
> >
> > -             if (i + 1 < dpolicy->granularity)
> > -                     break;
> > +             /*
> > +              * Do not granularity control for segment or section
> > +              * unit discard, since we have only one type of discard l=
ength.
> > +              */
> > +             if (f2fs_block_unit_discard(sbi)) {
> > +                     if (i + 1 < dpolicy->granularity)
> > +                             break;
> >
> > -             if (i + 1 < dcc->max_ordered_discard && dpolicy->ordered)=
 {
> > -                     __issue_discard_cmd_orderly(sbi, dpolicy, &issued=
);
> > -                     return issued;
> > +                     if (i + 1 < dcc->max_ordered_discard &&
> > +                                     dpolicy->ordered) {
> > +                             __issue_discard_cmd_orderly(sbi, dpolicy,
> > +                                             &issued);
> > +                             return issued;
> > +                     }
> >               }
> >
> >               pend_list =3D &dcc->pend_list[i];
> > @@ -1701,6 +1709,13 @@ static int __issue_discard_cmd(struct f2fs_sb_in=
fo *sbi,
> >
> >               if (issued >=3D dpolicy->max_requests || io_interrupted)
> >                       break;
> > +
> > +             /*
> > +              * We only use the largest discard unit for segment or
> > +              * section unit discard.
> > +              */
> > +             if (!f2fs_block_unit_discard(sbi))
> > +                     break;
> >       }
> >
> >       if (dpolicy->type =3D=3D DPOLICY_UMOUNT && issued) {
> > @@ -2320,10 +2335,6 @@ static int create_discard_cmd_control(struct f2f=
s_sb_info *sbi)
> >       dcc->discard_granularity =3D DEFAULT_DISCARD_GRANULARITY;
> >       dcc->max_ordered_discard =3D DEFAULT_MAX_ORDERED_DISCARD_GRANULAR=
ITY;
> >       dcc->discard_io_aware =3D DPOLICY_IO_AWARE_ENABLE;
> > -     if (F2FS_OPTION(sbi).discard_unit =3D=3D DISCARD_UNIT_SEGMENT)
> > -             dcc->discard_granularity =3D BLKS_PER_SEG(sbi);
> > -     else if (F2FS_OPTION(sbi).discard_unit =3D=3D DISCARD_UNIT_SECTIO=
N)
> > -             dcc->discard_granularity =3D BLKS_PER_SEC(sbi);
>
> Hi Daeho,
>
> I think this bug was introduced by commit 4f993264fe29 ("f2fs: introduce
> discard_unit mount option"), since it set discard_granularity to section
> size incorrectly for discard_unit=3Dsection mount option, once section si=
ze
> is large than segment size, discard_granularity will be larger than 512.
>
> However, w/ current implementation, we only support range of [1, 512] for
> discard_granularity parameter, resulting in failing to submitting all
> dicards.
>
> So, what do you think of setting discard_granularity to 512 for both
> discard_unit=3Dsegment and discard_unit=3Dsection mount option, as I prop=
osed
> in [1]? Then, discard_thread in DPOLICY_BG mode can submit those large-si=
zed
> discards.
>
> [1] https://lore.kernel.org/linux-f2fs-devel/53598146-1f01-41ad-980e-9f4b=
989e81ab@kernel.org/

Yes, it makes sense. Thanks.

>
> Thanks,
>
> >
> >       INIT_LIST_HEAD(&dcc->entry_list);
> >       for (i =3D 0; i < MAX_PLIST_NUM; i++)
>

