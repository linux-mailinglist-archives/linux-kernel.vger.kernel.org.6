Return-Path: <linux-kernel+bounces-400898-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A9E69C13CA
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 02:53:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 624E81C223AF
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 01:53:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8274BE65;
	Fri,  8 Nov 2024 01:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nQaSUNYZ"
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 741178C1F
	for <linux-kernel@vger.kernel.org>; Fri,  8 Nov 2024 01:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731030820; cv=none; b=A3a3fnaQPiFEL0QlWET5m4fEB62tjn6boNVgCnFi9Lih2cKqVmIOIndvp8D8ZdcdQ62/i9E0BSheExQ+6RAzZezvjCuOUl/++bnvgtQpGlOmVVA1VHHXolXnFvjwyiJG6ae14sQV9QzGa7mKr5D/CxXXzJ0AdQ80G9sWZmPvIsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731030820; c=relaxed/simple;
	bh=X0Nj0RqatB4YSzuaQD//j2LXfWGUNQ0h46NiqkrZpCs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=arSh8KTPAr5IvV3FIUzPhat4Wxynws5ydpwSJhKVFzefQFE509J5Jm/Om2nWs6kd8GtAgadSXETb85uwNueuWHEs0oxbDactvH4kbSCJyaClPRvPyhwTU1BMYmwCHX9/yTJ+oBpQtYgVToUCaezTF9vr975qjBN8Epj8xR4nVqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nQaSUNYZ; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-37d6716e200so138091f8f.3
        for <linux-kernel@vger.kernel.org>; Thu, 07 Nov 2024 17:53:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731030817; x=1731635617; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g6iszzv7cvyfxc67RtDE1FElxuvz0aWSZ5YwOIqG6hs=;
        b=nQaSUNYZdsFLDorsw0Ak98/SkAe5MGF1aHPkOyQZulmcUfLxrh8jIgJ8lb5smu2UyJ
         zRInp8ha/kzxgEwk7CIMgyN8CS3bKkNbebZnu3OyHI1Jxt2uTkwfx4U6j3teWFwnr91i
         i2jRCWpWLUczlJmxTktN/FPGuHTQhy94YFPt48aKdb7oqKVYOoEWUITmb0i5sKXDtek9
         R+I7Vm+rYTWPCoSmJ+8YTKhGmzuy22Op2Qy84GKdsJPXklz1vI4UcZdyW5WSzBqP3nZT
         nxcvQaeF8xbU87zQ3oprBmXKxfzZXNZ59CW8xoUQOxD2yE15K2sUnwyqld1efATY41nz
         /mEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731030817; x=1731635617;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g6iszzv7cvyfxc67RtDE1FElxuvz0aWSZ5YwOIqG6hs=;
        b=dRS0VQuHXPWgxLevvP+zY6/v4rLO9ATfsHmNSHKcikpZtq7Qu/4jcJXoP72Z0qTV/i
         71Xt+t/OQXZpWxzqIaFI7kGRzbcMN17xzSHM3JrySOI9teAXeuMMVypqdvqG8Rj9f9aS
         KfZcCbHpShS3mGfIxDrW6yS1eE342gjOEQJSSDLoRNIt75yMQ1zdvtL6Mr1VmE6g1Rw5
         JKglylVzu7J5llyqGN5pqhW3/n1ic26yVYo1NJ5Oo2uot3CvFBh5U7DWFjVcmlr4mrQk
         ATVid4ZFzgBHBzaHGiNie3kPCypoyrmrNOkj3xBFcL5CMh9hDApT8r30cBrp2bDOc5to
         nUXA==
X-Forwarded-Encrypted: i=1; AJvYcCWJXBmbdutBULkLYsSpyYOgCyMoMh9fE/Tnr6VsutNSLeiCPiIFEuElw5sbrAFIYKC1uJNFqvB6tEudbNM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzApetRKOpO7QenlVC77lozz28JQYiGvK9e/wE6+wR1bl8FvRKU
	LMn93HpbeRyp+Jh/j7TcvaVCEbbNkvjpuKA7a7tlTC9Jt27qWaWGRaVgqgTwxYo8wgzuvPwYeWx
	eIdx/BgQ9VyeBEEBOH8r4B2AW+b4g3g==
X-Google-Smtp-Source: AGHT+IGgNIKoU99YePnICd4cm2bjzqJfA+hS0vhBjQkQCnwLsURxcSPUeHxtI9hZhTYEByIrD5F6okwSP8weEiNgMgE=
X-Received: by 2002:a05:6000:1863:b0:375:bb30:6525 with SMTP id
 ffacd0b85a97d-381f1829a97mr343524f8f.1.1731030816332; Thu, 07 Nov 2024
 17:53:36 -0800 (PST)
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
 <0a8f96da-302d-4d6c-9ab6-0b66a05cbcfd@kernel.org> <CAHJ8P3JTY=DFQRMd0zNGy6a3Hdq1y045ri9QKM8NGn8bNhHJfA@mail.gmail.com>
 <d5ef36a3-1bcb-40a0-a963-c6d1887c4e4e@kernel.org> <CAHJ8P3JARkFxkyz-FLWN2PSZb2AL3=dSqF1v-SR-oU9z6tm+Rg@mail.gmail.com>
 <45cec698-2679-435b-b62a-ebe22d361955@kernel.org> <CAHJ8P3LWwA=VzKcr3nXO1uZtkc1H9dmO+5dNy247A2fGn6JHDA@mail.gmail.com>
 <e2e61445-c1fd-4b88-8402-b9f83111e05e@kernel.org>
In-Reply-To: <e2e61445-c1fd-4b88-8402-b9f83111e05e@kernel.org>
From: Zhiguo Niu <niuzhiguo84@gmail.com>
Date: Fri, 8 Nov 2024 09:53:25 +0800
Message-ID: <CAHJ8P3+7eE2h9kWSN81H2n8MXuzvozB-nG3Uq2Z18-WdRXu3vg@mail.gmail.com>
Subject: Re: [PATCH V2] f2fs: fix to adjust appropriate length for fiemap
To: Chao Yu <chao@kernel.org>
Cc: Zhiguo Niu <zhiguo.niu@unisoc.com>, jaegeuk@kernel.org, 
	linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, 
	ke.wang@unisoc.com, Hao_hao.Wang@unisoc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Chao Yu <chao@kernel.org> =E4=BA=8E2024=E5=B9=B411=E6=9C=888=E6=97=A5=E5=91=
=A8=E4=BA=94 09:22=E5=86=99=E9=81=93=EF=BC=9A
>
> On 2024/11/7 18:53, Zhiguo Niu wrote:
> > Chao Yu <chao@kernel.org> =E4=BA=8E2024=E5=B9=B411=E6=9C=887=E6=97=A5=
=E5=91=A8=E5=9B=9B 16:22=E5=86=99=E9=81=93=EF=BC=9A
> >>
> >> On 2024/11/7 14:54, Zhiguo Niu wrote:
> >>> Chao Yu <chao@kernel.org> =E4=BA=8E2024=E5=B9=B411=E6=9C=887=E6=97=A5=
=E5=91=A8=E5=9B=9B 14:18=E5=86=99=E9=81=93=EF=BC=9A
> >>>>
> >>>> On 2024/11/6 16:41, Zhiguo Niu wrote:
> >>>>> Chao Yu <chao@kernel.org> =E4=BA=8E2024=E5=B9=B411=E6=9C=886=E6=97=
=A5=E5=91=A8=E4=B8=89 15:40=E5=86=99=E9=81=93=EF=BC=9A
> >>>>>>
> >>>>>> On 2024/11/6 14:08, Zhiguo Niu wrote:
> >>>>>>> Chao Yu <chao@kernel.org> =E4=BA=8E2024=E5=B9=B411=E6=9C=886=E6=
=97=A5=E5=91=A8=E4=B8=89 10:40=E5=86=99=E9=81=93=EF=BC=9A
> >>>>>>>>
> >>>>>>>> On 2024/11/6 10:26, Zhiguo Niu wrote:
> >>>>>>>>> Chao Yu <chao@kernel.org> =E4=BA=8E2024=E5=B9=B411=E6=9C=886=E6=
=97=A5=E5=91=A8=E4=B8=89 10:16=E5=86=99=E9=81=93=EF=BC=9A
> >>>>>>>>>>
> >>>>>>>>>> On 2024/11/5 19:02, Zhiguo Niu wrote:
> >>>>>>>>>>> Chao Yu <chao@kernel.org> =E4=BA=8E2024=E5=B9=B411=E6=9C=885=
=E6=97=A5=E5=91=A8=E4=BA=8C 18:39=E5=86=99=E9=81=93=EF=BC=9A
> >>>>>>>>>>>>
> >>>>>>>>>>>> On 2024/11/5 15:28, Zhiguo Niu wrote:
> >>>>>>>>>>>>> Chao Yu <chao@kernel.org> =E4=BA=8E2024=E5=B9=B411=E6=9C=88=
5=E6=97=A5=E5=91=A8=E4=BA=8C 15:04=E5=86=99=E9=81=93=EF=BC=9A
> >>>>>>>>>>>>>>
> >>>>>>>>>>>>>> On 2024/11/4 9:56, Zhiguo Niu wrote:
> >>>>>>>>>>>>>>> If user give a file size as "length" parameter for fiemap
> >>>>>>>>>>>>>>> operations, but if this size is non-block size aligned,
> >>>>>>>>>>>>>>> it will show 2 segments fiemap results even this whole fi=
le
> >>>>>>>>>>>>>>> is contiguous on disk, such as the following results:
> >>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>>          ./f2fs_io fiemap 0 19034 ylog/analyzer.py
> >>>>>>>>>>>>>>> Fiemap: offset =3D 0 len =3D 19034
> >>>>>>>>>>>>>>>                 logical addr.    physical addr.   length =
          flags
> >>>>>>>>>>>>>>> 0       0000000000000000 0000000020baa000 000000000000400=
0 00001000
> >>>>>>>>>>>>>>> 1       0000000000004000 0000000020bae000 000000000000100=
0 00001001
> >>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>> after this patch:
> >>>>>>>>>>>>>>> ./f2fs_io fiemap 0 19034 ylog/analyzer.py
> >>>>>>>>>>>>>>> Fiemap: offset =3D 0 len =3D 19034
> >>>>>>>>>>>>>>>             logical addr.    physical addr.   length     =
      flags
> >>>>>>>>>>>>>>> 0    0000000000000000 00000000315f3000 0000000000005000 0=
0001001
> >>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>> Signed-off-by: Zhiguo Niu <zhiguo.niu@unisoc.com>
> >>>>>>>>>>>>>>> ---
> >>>>>>>>>>>>>>> V2: correct commit msg according to Chao's questions
> >>>>>>>>>>>>>>> f2fs_io has been modified for testing, the length for fie=
map is
> >>>>>>>>>>>>>>> real file size, not block number
> >>>>>>>>>>>>>>> ---
> >>>>>>>>>>>>>>>          fs/f2fs/data.c | 4 ++--
> >>>>>>>>>>>>>>>          1 file changed, 2 insertions(+), 2 deletions(-)
> >>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
> >>>>>>>>>>>>>>> index 306b86b0..9fc229d 100644
> >>>>>>>>>>>>>>> --- a/fs/f2fs/data.c
> >>>>>>>>>>>>>>> +++ b/fs/f2fs/data.c
> >>>>>>>>>>>>>>> @@ -1966,8 +1966,8 @@ int f2fs_fiemap(struct inode *inode=
, struct fiemap_extent_info *fieinfo,
> >>>>>>>>>>>>>>>                              goto out;
> >>>>>>>>>>>>>>>              }
> >>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>> -     if (bytes_to_blks(inode, len) =3D=3D 0)
> >>>>>>>>>>>>>>> -             len =3D blks_to_bytes(inode, 1);
> >>>>>>>>>>>>>>> +     if (len & (blks_to_bytes(inode, 1) - 1))
> >>>>>>>>>>>>>>> +             len =3D round_up(len, blks_to_bytes(inode, =
1));
> >>>>>>>>>>>>>>
> >>>>>>>>>>>>>> How do you think of getting rid of above alignment for len=
?
> >>>>>>>>>>>>>>
> >>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>>              start_blk =3D bytes_to_blks(inode, start);
> >>>>>>>>>>>>>>>              last_blk =3D bytes_to_blks(inode, start + le=
n - 1);
> >>>>>>>>>>>>>>
> >>>>>>>>>>>>>> And round up end position w/:
> >>>>>>>>>>>>>>
> >>>>>>>>>>>>>> last_blk =3D bytes_to_blks(inode, round_up(start + len - 1=
, F2FS_BLKSIZE));
> >>>>>>>>>>>>> Hi Chao,
> >>>>>>>>>>>>> I think this will change the current code logic
> >>>>>>>>>>>>> -------------
> >>>>>>>>>>>>> if (start_blk > last_blk)
> >>>>>>>>>>>>>            goto out;
> >>>>>>>>>>>>> -------------
> >>>>>>>>>>>>> for example, a file with size 19006, but the length from th=
e user is 16384.
> >>>>>>>>>>>>> before this modification,  last_blk =3D  bytes_to_blks(inod=
e, start +
> >>>>>>>>>>>>> len - 1) =3D (inode, 16383) =3D 3
> >>>>>>>>>>>>> after the first f2fs_map_blocks(). start_blk change to be 4=
,
> >>>>>>>>>>>>> after the second f2fs_map_blocks(), fiemap_fill_nex_exten w=
ill be
> >>>>>>>>>>>>> called to fill user parameter and then
> >>>>>>>>>>>>> will goto out because start_blk > last_blk, then fiemap flo=
w finishes.
> >>>>>>>>>>>>> but after this modification, last_blk will be 4
> >>>>>>>>>>>>> will do f2fs_map_blocks() until reach the max_file_blocks(i=
node)
> >>>>>>>>>>>>
> >>>>>>>>>>>> Yes, you're right, however, w/ this patch, it may change las=
t_blk, e.g.
> >>>>>>>>>>>>
> >>>>>>>>>>>> xfs_io file -c "fiemap -v 0 19006" vs xfs_io file -c "fiemap=
 -v 2 19006"
> >>>>>>>>>>>> start_blk and last_blk will be: 0, 4 and 0, 5.
> >>>>>>>>>>> Hi Chao,
> >>>>>>>>>>> yes, but w/o this patch , the original code still has the sam=
e situation??
> >>>>>>>>>>> for example
> >>>>>>>>>>> xfs_io file -c "fiemap -v 0 16384" vs xfs_io file -c "fiemap =
-v 2 16384"
> >>>>>>>>>>> start_blk and last_blk will be: 0, 3 and 0, 4.
> >>>>>>>>>>
> >>>>>>>>>> For the case "fiemap -v 2 19006", offset is 2, and length is 1=
9006, so last_offset
> >>>>>>>>>> is 19008, and last_blk should be 4 rather than 5, right?
> >>>>>>>>> hi Chao,
> >>>>>>>>> it is right w/o my patch.
> >>>>>>>>>>
> >>>>>>>>>> And for you case, it calculates last_blk correctly.
> >>>>>>>>> So you suggest that "Should we round_up len after start_blk & l=
ast_blk
> >>>>>>>>> calculation?"
> >>>>>>>>
> >>>>>>>> Zhiguo,
> >>>>>>>>
> >>>>>>>> Yes, I think alignment of len should not affect calculation of l=
ast_blk.
> >>>>>>>>
> >>>>>>>> I mean this,
> >>>>>>>>
> >>>>>>>> ---
> >>>>>>>>       fs/f2fs/data.c          | 6 +++---
> >>>>>>>>       include/linux/f2fs_fs.h | 3 ++-
> >>>>>>>>       2 files changed, 5 insertions(+), 4 deletions(-)
> >>>>>>>>
> >>>>>>>> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
> >>>>>>>> index 7d1bb9518a40..cbbb956f420d 100644
> >>>>>>>> --- a/fs/f2fs/data.c
> >>>>>>>> +++ b/fs/f2fs/data.c
> >>>>>>>> @@ -1967,12 +1967,12 @@ int f2fs_fiemap(struct inode *inode, str=
uct fiemap_extent_info *fieinfo,
> >>>>>>>>                             goto out;
> >>>>>>>>             }
> >>>>>>>>
> >>>>>>>> -       if (bytes_to_blks(inode, len) =3D=3D 0)
> >>>>>>>> -               len =3D blks_to_bytes(inode, 1);
> >>>>>>>> -
> >>>>>>>>             start_blk =3D bytes_to_blks(inode, start);
> >>>>>>>>             last_blk =3D bytes_to_blks(inode, start + len - 1);
> >>>>>>>>
> >>>>>>>> +       if (len & F2FS_BLKSIZE_MASK)
> >>>>>>>> +               len =3D round_up(len, F2FS_BLKSIZE);
> >>>>>>>> +
> >>>>>>> Hi Chao,
> >>>>>>> this verion verify pass with my test case.
> >>>>>>>
> >>>>>>> but there is still another issue in orginal code:
> >>>>>>> ylog/analyzer.py  size =3D 19034
> >>>>>>> if I input the following cmd(start/length are both real size, not=
 block number)
> >>>>>>> /f2fs_io fiemap 2 16384 ylog/analyzer.py
> >>>>>>> and the results shows:
> >>>>>>> Fiemap: offset =3D 2 len =3D 16384
> >>>>>>>         logical addr.    physical addr.   length           flags
> >>>>>>> 0    0000000000000000 0000000e2ebca000 0000000000004000 00001000
> >>>>>>> 1    0000000000004000 0000000e2ebce000 0000000000001000 00001001
> >>>>>>> so start_blk/last_blk should be calculate it in the following way=
?
> >>>>>>
> >>>>>> IIUC, the root cause is f2fs_map_blocks() will truncate size of
> >>>>>> returned extent to F2FS_BYTES_TO_BLK(len), so whenever parameter
> >>>>>> @len doesn't cover last extent, it triggers this bug.
> >>>>>>
> >>>>>> next:
> >>>>>>            memset(&map, 0, sizeof(map));
> >>>>>>            map.m_lblk =3D start_blk;
> >>>>>>            map.m_len =3D F2FS_BYTES_TO_BLK(len);  --- limit max si=
ze of extent it founds
> >>>>> yes, I think so too.
> >>>>>>            map.m_next_pgofs =3D &next_pgofs;
> >>>>>>            map.m_seg_type =3D NO_CHECK_TYPE;
> >>>>>> ...
> >>>>>>            ret =3D f2fs_map_blocks(inode, &map, F2FS_GET_BLOCK_FIE=
MAP);
> >>>>>>
> >>>>>> xfs_io file -c "fiemap -v 2 16384"
> >>>>>> file:
> >>>>>>      EXT: FILE-OFFSET      BLOCK-RANGE      TOTAL FLAGS
> >>>>>>        0: [0..31]:         139272..139303      32 0x1000
> >>>>>>        1: [32..39]:        139304..139311       8 0x1001
> >>>>>> xfs_io file -c "fiemap -v 0 16384"
> >>>>>> file:
> >>>>>>      EXT: FILE-OFFSET      BLOCK-RANGE      TOTAL FLAGS
> >>>>>>        0: [0..31]:         139272..139303      32 0x1000
> >>>>>> xfs_io file -c "fiemap -v 0 16385"
> >>>>>> file:
> >>>>>>      EXT: FILE-OFFSET      BLOCK-RANGE      TOTAL FLAGS
> >>>>>>        0: [0..39]:         139272..139311      40 0x1001
> >>>>>
> >>>>> But  If the correct last_blk is calculated correctly, fiemap can be
> >>>>> ended as soon as possible?  so the results shown is also right?
> >>>>
> >>>> Zhiguo,
> >>>>
> >>>> IMO, it's not, due to 1) if the extent is last one, FIEMAP_EXTENT_LA=
ST
> >>>> must be tagged to notice user that it doesn't need further fiemap on
> >>>> latter LBA, 2) one continuous extent should not be split to two.
> >>>>
> >>>> Let me figure out a fix for that.
> >>> Hi Chao,
> >>> OK, thanks for your explaination.
> >>> btw, Do I need to update a patch about the original issue we disscuss=
ed?
> >>> or you will modify it together?
> >>
> >> Zhiguo, let me send a patchset including your patch, now, I'm testing =
this:
> > Hi Chao,
> > It's ok ^^
> >>
> >>   From c67cb4782a3f1875865f9ae24cce80a59752d600 Mon Sep 17 00:00:00 20=
01
> >> From: Chao Yu <chao@kernel.org>
> >> Date: Thu, 7 Nov 2024 14:52:17 +0800
> >> Subject: [PATCH] f2fs: fix to requery extent which cross boundary of i=
nquiry
> >>
> >> dd if=3D/dev/zero of=3Dfile bs=3D4k count=3D5
> >> xfs_io file -c "fiemap -v 2 16384"
> >> file:
> >>      EXT: FILE-OFFSET      BLOCK-RANGE      TOTAL FLAGS
> >>        0: [0..31]:         139272..139303      32 0x1000
> >>        1: [32..39]:        139304..139311       8 0x1001
> >> xfs_io file -c "fiemap -v 0 16384"
> >> file:
> >>      EXT: FILE-OFFSET      BLOCK-RANGE      TOTAL FLAGS
> >>        0: [0..31]:         139272..139303      32 0x1000
> >> xfs_io file -c "fiemap -v 0 16385"
> >> file:
> >>      EXT: FILE-OFFSET      BLOCK-RANGE      TOTAL FLAGS
> >>        0: [0..39]:         139272..139311      40 0x1001
> >>
> >> There are two problems:
> >> - continuous extent is split to two
> >> - FIEMAP_EXTENT_LAST is missing in last extent
> >>
> >> The root cause is: if upper boundary of inquiry crosses extent,
> >> f2fs_map_blocks() will truncate length of returned extent to
> >> F2FS_BYTES_TO_BLK(len), and also, it will stop to query latter
> >> extent or hole to make sure current extent is last or not.
> >>
> >> In order to fix this issue, once we found an extent locates
> >> in the end of inquiry range by f2fs_map_blocks(), we need to
> >> expand inquiry range to requiry.
> >>
> >> Reported-by: Zhiguo Niu <zhiguo.niu@unisoc.com>
> >> Signed-off-by: Chao Yu <chao@kernel.org>
> >> ---
> >>    fs/f2fs/data.c | 20 +++++++++++++++-----
> >>    1 file changed, 15 insertions(+), 5 deletions(-)
> >>
> >> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
> >> index 69f1cb0490ee..ee5614324df0 100644
> >> --- a/fs/f2fs/data.c
> >> +++ b/fs/f2fs/data.c
> >> @@ -1896,7 +1896,7 @@ int f2fs_fiemap(struct inode *inode, struct fiem=
ap_extent_info *fieinfo,
> >>                  u64 start, u64 len)
> >>    {
> >>          struct f2fs_map_blocks map;
> >> -       sector_t start_blk, last_blk;
> >> +       sector_t start_blk, last_blk, blk_len, max_len;
> >>          pgoff_t next_pgofs;
> >>          u64 logical =3D 0, phys =3D 0, size =3D 0;
> >>          u32 flags =3D 0;
> >> @@ -1940,14 +1940,13 @@ int f2fs_fiemap(struct inode *inode, struct fi=
emap_extent_info *fieinfo,
> >>
> >>          start_blk =3D F2FS_BYTES_TO_BLK(start);
> >>          last_blk =3D F2FS_BYTES_TO_BLK(start + len - 1);
> >> -
> >> -       if (len & F2FS_BLKSIZE_MASK)
> >> -               len =3D round_up(len, F2FS_BLKSIZE);
> >> +       blk_len =3D last_blk - start_blk + 1;
> >> +       max_len =3D F2FS_BYTES_TO_BLK(maxbytes) - start_blk;
> >>
> >>    next:
> >>          memset(&map, 0, sizeof(map));
> >>          map.m_lblk =3D start_blk;
> >> -       map.m_len =3D F2FS_BYTES_TO_BLK(len);
> >> +       map.m_len =3D blk_len;
> >>          map.m_next_pgofs =3D &next_pgofs;
> >>          map.m_seg_type =3D NO_CHECK_TYPE;
> >>
> >> @@ -1970,6 +1969,17 @@ int f2fs_fiemap(struct inode *inode, struct fie=
map_extent_info *fieinfo,
> >>                  flags |=3D FIEMAP_EXTENT_LAST;
> >>          }
> >>
> >> +       /*
> >> +        * current extent may cross boundary of inquiry, increase len =
to
> >> +        * requery.
> >> +        */
> >> +       if (!compr_cluster && (map.m_flags & F2FS_MAP_MAPPED) &&
> >> +                               map.m_lblk + map.m_len - 1 =3D=3D last=
_blk &&
> >> +                               blk_len !=3D max_len) {
> >> +               blk_len =3D max_len;
> >> +               goto next;
> >> +       }
> >> +
> > it seems if user input the lenght which is less than the file size,
> > but return the whole fiemap?
> > such as:
> >   dd if=3D/dev/zero of=3Dfile bs=3D4k count=3D5
> >   xfs_io file -c "fiemap -v 0 16384"
> > will get extent with lenght =3D 0x5000? Is this expected?
> > Or did I understand it wrong?
>
> It's fine?
>
> Quoted from Documentation/filesystems/fiemap.rst
>
> "fm_start, and fm_length specify the logical range within the file
> which the process would like mappings for. Extents returned mirror
> those on disk - that is, the logical offset of the 1st returned extent
> may start before fm_start, and the range covered by the last returned
> extent may end after fm_length. All offsets and lengths are in bytes."
>
> Quoted from reply of Darrick:
>
> https://lore.kernel.org/fstests/20210224165057.GB7269@magnolia/
Hi Chao,
clear, and verfy thanks for you kindly explanations.
thanks again.
>
> Thanks,
>
> > thanks!
> >>          compr_appended =3D false;
> >>          /* In a case of compressed cluster, append this to the last e=
xtent */
> >>          if (compr_cluster && ((map.m_flags & F2FS_MAP_DELALLOC) ||
> >> --
> >> 2.40.1
> >>
> >>> thanks!
> >>>>
> >>>> Thanks,
> >>>>
> >>>>> such as this special case "xfs_io file -c "fiemap -v 2 16384" we di=
scussed.
> >>>>> but it is fine for me to keep the current codes.
> >>>>> thanks!
> >>>>>>
> >>>>>> Thoughts?
> >>>>>>
> >>>>>> Thanks,
> >>>>>>
> >>>>>>> before:
> >>>>>>> start_blk =3D bytes_to_blks(inode, start);
> >>>>>>> last_blk =3D bytes_to_blks(inode, start + len - 1);
> >>>>>>> after:
> >>>>>>>
> >>>>>>> start_blk =3D bytes_to_blks(inode, start);
> >>>>>>> last_blk =3D start_blk + bytes_to_blks(inode, len - 1);
> >>>>>>> thanks!
> >>>>>>>>       next:
> >>>>>>>>             memset(&map, 0, sizeof(map));
> >>>>>>>>             map.m_lblk =3D start_blk;
> >>>>>>>> diff --git a/include/linux/f2fs_fs.h b/include/linux/f2fs_fs.h
> >>>>>>>> index b0b821edfd97..954e8e8344b7 100644
> >>>>>>>> --- a/include/linux/f2fs_fs.h
> >>>>>>>> +++ b/include/linux/f2fs_fs.h
> >>>>>>>> @@ -24,10 +24,11 @@
> >>>>>>>>       #define NEW_ADDR              ((block_t)-1)   /* used as b=
lock_t addresses */
> >>>>>>>>       #define COMPRESS_ADDR         ((block_t)-2)   /* used as c=
ompressed data flag */
> >>>>>>>>
> >>>>>>>> +#define F2FS_BLKSIZE_MASK              (F2FS_BLKSIZE - 1)
> >>>>>>>>       #define F2FS_BYTES_TO_BLK(bytes)      ((bytes) >> F2FS_BLK=
SIZE_BITS)
> >>>>>>>>       #define F2FS_BLK_TO_BYTES(blk)                ((blk) << F2=
FS_BLKSIZE_BITS)
> >>>>>>>>       #define F2FS_BLK_END_BYTES(blk)               (F2FS_BLK_TO=
_BYTES(blk + 1) - 1)
> >>>>>>>> -#define F2FS_BLK_ALIGN(x)                      (F2FS_BYTES_TO_B=
LK((x) + F2FS_BLKSIZE - 1))
> >>>>>>>> +#define F2FS_BLK_ALIGN(x)              (F2FS_BYTES_TO_BLK((x) +=
 F2FS_BLKSIZE - 1))
> >>>>>>>>
> >>>>>>>>       /* 0, 1(node nid), 2(meta nid) are reserved node id */
> >>>>>>>>       #define F2FS_RESERVED_NODE_NUM                3
> >>>>>>>> --
> >>>>>>>> 2.40.1
> >>>>>>>>
> >>>>>>>>
> >>>>>>>>
> >>>>>>>>> Thanks
> >>>>>>>>>>
> >>>>>>>>>> Thanks,
> >>>>>>>>>>
> >>>>>>>>>>> but overall last_blk will change loop counts but has not affe=
ct on the results.
> >>>>>>>>>>>>
> >>>>>>>>>>>> Should we round_up len after start_blk & last_blk calculatio=
n?
> >>>>>>>>>>> I thinks it is ok ,but just a little bit redundant with the f=
ollowing
> >>>>>>>>>>> handling about len.
> >>>>>>>>>>>
> >>>>>>>>>>> if (bytes_to_blks(inode, len) =3D=3D 0)
> >>>>>>>>>>>          len =3D blks_to_bytes(inode, 1);
> >>>>>>>>>>>
> >>>>>>>>>>> Based on the above situation,
> >>>>>>>>>>> do you have any other good suggestions? ^^
> >>>>>>>>>>> thanks!
> >>>>>>>>>>>
> >>>>>>>>>>>>
> >>>>>>>>>>>> Thanks,
> >>>>>>>>>>>>
> >>>>>>>>>>>>> thanks=EF=BC=81
> >>>>>>>>>>>>>>
> >>>>>>>>>>>>>> Thanks,
> >>>>>>>>>>>>>>
> >>>>>>>>>>>>
> >>>>>>>>>>
> >>>>>>>>
> >>>>>>
> >>>>
> >>
>

