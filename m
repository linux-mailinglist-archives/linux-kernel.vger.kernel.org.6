Return-Path: <linux-kernel+bounces-397836-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DF309BE131
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 09:41:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D6CB2840C9
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 08:41:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A5AC1D47AC;
	Wed,  6 Nov 2024 08:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KcaINJsv"
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 979A57FBAC
	for <linux-kernel@vger.kernel.org>; Wed,  6 Nov 2024 08:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730882482; cv=none; b=pNZOhzut36vCwTQoE9TIVzazF5AorSK3nKFFdq2MUyJOo3zGGxlD/VSTto2rLMyzQ8dvr2SwIBaIB4lr4es10TQnlliwofbzLQytHmiUdVjjOQG+miDjypLI2DCt6SYqItrI/Cdc8R92IRkhmiuQ1xS1cLitm5tHaCns4vsSmaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730882482; c=relaxed/simple;
	bh=U1JOsdFmVZMOcXRJX/TaqC64NJzPJNEI0/emo/a8n1E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NXNmzGC6NHbHL2fpzvqAeq32Mo/Kw8VUmisPnLlWHuQ0/WfsC0N61UYPDbaLBDqjTQd19wzPXZ3iMM8ppfgN8VQg0JQGrCX3K1jpq4os0kJH8SUhEi3Yqo2F2+xUcpV6Wk2jMyDgbru3uUeKzWmFUoLPiADAoyGO3BezkY/NJQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KcaINJsv; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-37d6716e200so713042f8f.3
        for <linux-kernel@vger.kernel.org>; Wed, 06 Nov 2024 00:41:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730882479; x=1731487279; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UYlK0RZ1uJdzqEWsrTNzfbcKQBFCx0AhJcbWF91rojs=;
        b=KcaINJsvuONaxQENkyAdY/B6p5bGjknEJcrDzl0dWt6ekK0G/I0Lw9Sf4gcBTGG9C6
         788hx9kvjiSQFKk+nySGUdx03CndkLscmolCkSlLYN8QzsFCRSybRURDEnrWpZqYITTo
         JEKdgwEe6VDEjvykrT2ovro7oJcmsi4O9WHU0CEh7B6zEDA/8uvlzLwOQt5yFmKAfyYa
         GsUk7ElQoSnVCy9eZ/2+TBqQoU5diGzPdxgucZJTqwdUF0ywnzFrmBIdqgCsOJAovxAs
         RB1RiQkFDM0SauV4P99RJY9npLss0zGfzk7JlCoigF51zEMJ1fl+8t9aB6EDRwdSkKGI
         dhiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730882479; x=1731487279;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UYlK0RZ1uJdzqEWsrTNzfbcKQBFCx0AhJcbWF91rojs=;
        b=wQ1I9uFEjfQXIYDMXju0AC50Cb7S9QgTbs8Ib1L/WFRlTg6HcBbJiHxs9ni5+NZcNF
         fihwlIZfg1W25uNIzLaSqIPR1OxQ2fb8i7vPWFYmrD7MiZ3xi2kEZankHGPogMaTrne1
         s/Fnbl8h2ZMPLrWNu3pKZ7qQevSBmYfg7EjeUhhMWcJMbAWByXPwdpJ04VlB0tlmUbXI
         Z/Q6gkAPZuhOo1RoiDYwDRR7XY0yTDACZrjDQzrwQkqmi5c8hD/0j/aGl5M/TC+NTexY
         U7uKh90140Hxg3M6DpYGscy+JuNsnOwh+AocaMKMMz4ib5ZXBb8smXRx3zukX+cqJuN4
         1onw==
X-Forwarded-Encrypted: i=1; AJvYcCUfR86GHYLUm4oHmmvSvt/CuuF/iFFeRugQh3beYhbD1JYr7azTlnBUV38WZ1IflEB6zos0b3hTMN+gLmE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzOYizuKLKiGsGMV/ujVMI/qhuWTCl7l5DRLJwuHHKMkGQITg32
	EZ2YkhgQvEj+B8AHwtcWmoIxgBSWtV++xClwGr8aDTf5gZMnf0Ijh4op4SRJ2iv7+FvrybwW7md
	mXVMtGP72Ml46jOE4YuDSuxUIRK8=
X-Google-Smtp-Source: AGHT+IEGnvPPfpSYq+4dl4Y821vZGW4XVJU3ACpC06ThTPljGDT5X7HM/YmdUYuSN1/uEe6duCdlktHw6ZMxVA/L52M=
X-Received: by 2002:a05:6000:1fab:b0:37d:47a4:ec2b with SMTP id
 ffacd0b85a97d-3806121a2b6mr12687338f8f.11.1730882478538; Wed, 06 Nov 2024
 00:41:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1730685372-2995-1-git-send-email-zhiguo.niu@unisoc.com>
 <ab9f63b2-8d02-411b-8d2f-bc1b5b748ffe@kernel.org> <CAHJ8P3L9o2RJgV=TtUf_MPj36wasgPn7bn9FnGPXu=TgpE7ATQ@mail.gmail.com>
 <22873055-370b-4240-83ff-96bcfa91413a@kernel.org> <CAHJ8P3LddwapGLV5nKmw1ULTm7qp5OMk-kFBK3s_UptPPeph7w@mail.gmail.com>
 <9199e9fc-7b5b-4069-b79b-65ba5ae1b0f6@kernel.org> <CAHJ8P3L68mKAcSdrgk-5VZQh4cW+BBroh+50ymvuzO0f5x5kMw@mail.gmail.com>
 <c070fd2d-6480-4833-b03c-ec032ee37a28@kernel.org> <CAHJ8P3L4Q4Pia66o1RQGw5NnUOVxzNgFXUPO33jtqfQ-Oc=G_g@mail.gmail.com>
 <0a8f96da-302d-4d6c-9ab6-0b66a05cbcfd@kernel.org>
In-Reply-To: <0a8f96da-302d-4d6c-9ab6-0b66a05cbcfd@kernel.org>
From: Zhiguo Niu <niuzhiguo84@gmail.com>
Date: Wed, 6 Nov 2024 16:41:07 +0800
Message-ID: <CAHJ8P3JTY=DFQRMd0zNGy6a3Hdq1y045ri9QKM8NGn8bNhHJfA@mail.gmail.com>
Subject: Re: [PATCH V2] f2fs: fix to adjust appropriate length for fiemap
To: Chao Yu <chao@kernel.org>
Cc: Zhiguo Niu <zhiguo.niu@unisoc.com>, jaegeuk@kernel.org, 
	linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, 
	ke.wang@unisoc.com, Hao_hao.Wang@unisoc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Chao Yu <chao@kernel.org> =E4=BA=8E2024=E5=B9=B411=E6=9C=886=E6=97=A5=E5=91=
=A8=E4=B8=89 15:40=E5=86=99=E9=81=93=EF=BC=9A
>
> On 2024/11/6 14:08, Zhiguo Niu wrote:
> > Chao Yu <chao@kernel.org> =E4=BA=8E2024=E5=B9=B411=E6=9C=886=E6=97=A5=
=E5=91=A8=E4=B8=89 10:40=E5=86=99=E9=81=93=EF=BC=9A
> >>
> >> On 2024/11/6 10:26, Zhiguo Niu wrote:
> >>> Chao Yu <chao@kernel.org> =E4=BA=8E2024=E5=B9=B411=E6=9C=886=E6=97=A5=
=E5=91=A8=E4=B8=89 10:16=E5=86=99=E9=81=93=EF=BC=9A
> >>>>
> >>>> On 2024/11/5 19:02, Zhiguo Niu wrote:
> >>>>> Chao Yu <chao@kernel.org> =E4=BA=8E2024=E5=B9=B411=E6=9C=885=E6=97=
=A5=E5=91=A8=E4=BA=8C 18:39=E5=86=99=E9=81=93=EF=BC=9A
> >>>>>>
> >>>>>> On 2024/11/5 15:28, Zhiguo Niu wrote:
> >>>>>>> Chao Yu <chao@kernel.org> =E4=BA=8E2024=E5=B9=B411=E6=9C=885=E6=
=97=A5=E5=91=A8=E4=BA=8C 15:04=E5=86=99=E9=81=93=EF=BC=9A
> >>>>>>>>
> >>>>>>>> On 2024/11/4 9:56, Zhiguo Niu wrote:
> >>>>>>>>> If user give a file size as "length" parameter for fiemap
> >>>>>>>>> operations, but if this size is non-block size aligned,
> >>>>>>>>> it will show 2 segments fiemap results even this whole file
> >>>>>>>>> is contiguous on disk, such as the following results:
> >>>>>>>>>
> >>>>>>>>>       ./f2fs_io fiemap 0 19034 ylog/analyzer.py
> >>>>>>>>> Fiemap: offset =3D 0 len =3D 19034
> >>>>>>>>>              logical addr.    physical addr.   length          =
 flags
> >>>>>>>>> 0       0000000000000000 0000000020baa000 0000000000004000 0000=
1000
> >>>>>>>>> 1       0000000000004000 0000000020bae000 0000000000001000 0000=
1001
> >>>>>>>>>
> >>>>>>>>> after this patch:
> >>>>>>>>> ./f2fs_io fiemap 0 19034 ylog/analyzer.py
> >>>>>>>>> Fiemap: offset =3D 0 len =3D 19034
> >>>>>>>>>          logical addr.    physical addr.   length           fla=
gs
> >>>>>>>>> 0    0000000000000000 00000000315f3000 0000000000005000 0000100=
1
> >>>>>>>>>
> >>>>>>>>> Signed-off-by: Zhiguo Niu <zhiguo.niu@unisoc.com>
> >>>>>>>>> ---
> >>>>>>>>> V2: correct commit msg according to Chao's questions
> >>>>>>>>> f2fs_io has been modified for testing, the length for fiemap is
> >>>>>>>>> real file size, not block number
> >>>>>>>>> ---
> >>>>>>>>>       fs/f2fs/data.c | 4 ++--
> >>>>>>>>>       1 file changed, 2 insertions(+), 2 deletions(-)
> >>>>>>>>>
> >>>>>>>>> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
> >>>>>>>>> index 306b86b0..9fc229d 100644
> >>>>>>>>> --- a/fs/f2fs/data.c
> >>>>>>>>> +++ b/fs/f2fs/data.c
> >>>>>>>>> @@ -1966,8 +1966,8 @@ int f2fs_fiemap(struct inode *inode, stru=
ct fiemap_extent_info *fieinfo,
> >>>>>>>>>                           goto out;
> >>>>>>>>>           }
> >>>>>>>>>
> >>>>>>>>> -     if (bytes_to_blks(inode, len) =3D=3D 0)
> >>>>>>>>> -             len =3D blks_to_bytes(inode, 1);
> >>>>>>>>> +     if (len & (blks_to_bytes(inode, 1) - 1))
> >>>>>>>>> +             len =3D round_up(len, blks_to_bytes(inode, 1));
> >>>>>>>>
> >>>>>>>> How do you think of getting rid of above alignment for len?
> >>>>>>>>
> >>>>>>>>>
> >>>>>>>>>           start_blk =3D bytes_to_blks(inode, start);
> >>>>>>>>>           last_blk =3D bytes_to_blks(inode, start + len - 1);
> >>>>>>>>
> >>>>>>>> And round up end position w/:
> >>>>>>>>
> >>>>>>>> last_blk =3D bytes_to_blks(inode, round_up(start + len - 1, F2FS=
_BLKSIZE));
> >>>>>>> Hi Chao,
> >>>>>>> I think this will change the current code logic
> >>>>>>> -------------
> >>>>>>> if (start_blk > last_blk)
> >>>>>>>         goto out;
> >>>>>>> -------------
> >>>>>>> for example, a file with size 19006, but the length from the user=
 is 16384.
> >>>>>>> before this modification,  last_blk =3D  bytes_to_blks(inode, sta=
rt +
> >>>>>>> len - 1) =3D (inode, 16383) =3D 3
> >>>>>>> after the first f2fs_map_blocks(). start_blk change to be 4,
> >>>>>>> after the second f2fs_map_blocks(), fiemap_fill_nex_exten will be
> >>>>>>> called to fill user parameter and then
> >>>>>>> will goto out because start_blk > last_blk, then fiemap flow fini=
shes.
> >>>>>>> but after this modification, last_blk will be 4
> >>>>>>> will do f2fs_map_blocks() until reach the max_file_blocks(inode)
> >>>>>>
> >>>>>> Yes, you're right, however, w/ this patch, it may change last_blk,=
 e.g.
> >>>>>>
> >>>>>> xfs_io file -c "fiemap -v 0 19006" vs xfs_io file -c "fiemap -v 2 =
19006"
> >>>>>> start_blk and last_blk will be: 0, 4 and 0, 5.
> >>>>> Hi Chao,
> >>>>> yes, but w/o this patch , the original code still has the same situ=
ation??
> >>>>> for example
> >>>>> xfs_io file -c "fiemap -v 0 16384" vs xfs_io file -c "fiemap -v 2 1=
6384"
> >>>>> start_blk and last_blk will be: 0, 3 and 0, 4.
> >>>>
> >>>> For the case "fiemap -v 2 19006", offset is 2, and length is 19006, =
so last_offset
> >>>> is 19008, and last_blk should be 4 rather than 5, right?
> >>> hi Chao,
> >>> it is right w/o my patch.
> >>>>
> >>>> And for you case, it calculates last_blk correctly.
> >>> So you suggest that "Should we round_up len after start_blk & last_bl=
k
> >>> calculation?"
> >>
> >> Zhiguo,
> >>
> >> Yes, I think alignment of len should not affect calculation of last_bl=
k.
> >>
> >> I mean this,
> >>
> >> ---
> >>    fs/f2fs/data.c          | 6 +++---
> >>    include/linux/f2fs_fs.h | 3 ++-
> >>    2 files changed, 5 insertions(+), 4 deletions(-)
> >>
> >> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
> >> index 7d1bb9518a40..cbbb956f420d 100644
> >> --- a/fs/f2fs/data.c
> >> +++ b/fs/f2fs/data.c
> >> @@ -1967,12 +1967,12 @@ int f2fs_fiemap(struct inode *inode, struct fi=
emap_extent_info *fieinfo,
> >>                          goto out;
> >>          }
> >>
> >> -       if (bytes_to_blks(inode, len) =3D=3D 0)
> >> -               len =3D blks_to_bytes(inode, 1);
> >> -
> >>          start_blk =3D bytes_to_blks(inode, start);
> >>          last_blk =3D bytes_to_blks(inode, start + len - 1);
> >>
> >> +       if (len & F2FS_BLKSIZE_MASK)
> >> +               len =3D round_up(len, F2FS_BLKSIZE);
> >> +
> > Hi Chao,
> > this verion verify pass with my test case.
> >
> > but there is still another issue in orginal code:
> > ylog/analyzer.py  size =3D 19034
> > if I input the following cmd(start/length are both real size, not block=
 number)
> > /f2fs_io fiemap 2 16384 ylog/analyzer.py
> > and the results shows:
> > Fiemap: offset =3D 2 len =3D 16384
> >      logical addr.    physical addr.   length           flags
> > 0    0000000000000000 0000000e2ebca000 0000000000004000 00001000
> > 1    0000000000004000 0000000e2ebce000 0000000000001000 00001001
> > so start_blk/last_blk should be calculate it in the following way?
>
> IIUC, the root cause is f2fs_map_blocks() will truncate size of
> returned extent to F2FS_BYTES_TO_BLK(len), so whenever parameter
> @len doesn't cover last extent, it triggers this bug.
>
> next:
>         memset(&map, 0, sizeof(map));
>         map.m_lblk =3D start_blk;
>         map.m_len =3D F2FS_BYTES_TO_BLK(len);  --- limit max size of exte=
nt it founds
yes, I think so too.
>         map.m_next_pgofs =3D &next_pgofs;
>         map.m_seg_type =3D NO_CHECK_TYPE;
> ...
>         ret =3D f2fs_map_blocks(inode, &map, F2FS_GET_BLOCK_FIEMAP);
>
> xfs_io file -c "fiemap -v 2 16384"
> file:
>   EXT: FILE-OFFSET      BLOCK-RANGE      TOTAL FLAGS
>     0: [0..31]:         139272..139303      32 0x1000
>     1: [32..39]:        139304..139311       8 0x1001
> xfs_io file -c "fiemap -v 0 16384"
> file:
>   EXT: FILE-OFFSET      BLOCK-RANGE      TOTAL FLAGS
>     0: [0..31]:         139272..139303      32 0x1000
> xfs_io file -c "fiemap -v 0 16385"
> file:
>   EXT: FILE-OFFSET      BLOCK-RANGE      TOTAL FLAGS
>     0: [0..39]:         139272..139311      40 0x1001

But  If the correct last_blk is calculated correctly, fiemap can be
ended as soon as possible?  so the results shown is also right?
such as this special case "xfs_io file -c "fiemap -v 2 16384" we discussed.
but it is fine for me to keep the current codes.
thanks!
>
> Thoughts?
>
> Thanks,
>
> > before:
> > start_blk =3D bytes_to_blks(inode, start);
> > last_blk =3D bytes_to_blks(inode, start + len - 1);
> > after:
> >
> > start_blk =3D bytes_to_blks(inode, start);
> > last_blk =3D start_blk + bytes_to_blks(inode, len - 1);
> > thanks!
> >>    next:
> >>          memset(&map, 0, sizeof(map));
> >>          map.m_lblk =3D start_blk;
> >> diff --git a/include/linux/f2fs_fs.h b/include/linux/f2fs_fs.h
> >> index b0b821edfd97..954e8e8344b7 100644
> >> --- a/include/linux/f2fs_fs.h
> >> +++ b/include/linux/f2fs_fs.h
> >> @@ -24,10 +24,11 @@
> >>    #define NEW_ADDR              ((block_t)-1)   /* used as block_t ad=
dresses */
> >>    #define COMPRESS_ADDR         ((block_t)-2)   /* used as compressed=
 data flag */
> >>
> >> +#define F2FS_BLKSIZE_MASK              (F2FS_BLKSIZE - 1)
> >>    #define F2FS_BYTES_TO_BLK(bytes)      ((bytes) >> F2FS_BLKSIZE_BITS=
)
> >>    #define F2FS_BLK_TO_BYTES(blk)                ((blk) << F2FS_BLKSIZ=
E_BITS)
> >>    #define F2FS_BLK_END_BYTES(blk)               (F2FS_BLK_TO_BYTES(bl=
k + 1) - 1)
> >> -#define F2FS_BLK_ALIGN(x)                      (F2FS_BYTES_TO_BLK((x)=
 + F2FS_BLKSIZE - 1))
> >> +#define F2FS_BLK_ALIGN(x)              (F2FS_BYTES_TO_BLK((x) + F2FS_=
BLKSIZE - 1))
> >>
> >>    /* 0, 1(node nid), 2(meta nid) are reserved node id */
> >>    #define F2FS_RESERVED_NODE_NUM                3
> >> --
> >> 2.40.1
> >>
> >>
> >>
> >>> Thanks
> >>>>
> >>>> Thanks,
> >>>>
> >>>>> but overall last_blk will change loop counts but has not affect on =
the results.
> >>>>>>
> >>>>>> Should we round_up len after start_blk & last_blk calculation?
> >>>>> I thinks it is ok ,but just a little bit redundant with the followi=
ng
> >>>>> handling about len.
> >>>>>
> >>>>> if (bytes_to_blks(inode, len) =3D=3D 0)
> >>>>>       len =3D blks_to_bytes(inode, 1);
> >>>>>
> >>>>> Based on the above situation,
> >>>>> do you have any other good suggestions? ^^
> >>>>> thanks!
> >>>>>
> >>>>>>
> >>>>>> Thanks,
> >>>>>>
> >>>>>>> thanks=EF=BC=81
> >>>>>>>>
> >>>>>>>> Thanks,
> >>>>>>>>
> >>>>>>
> >>>>
> >>
>

