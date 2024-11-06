Return-Path: <linux-kernel+bounces-397549-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 614D59BDD51
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 03:55:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E22631F23014
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 02:55:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF83918FDB2;
	Wed,  6 Nov 2024 02:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jopZ2uoq"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EE85383
	for <linux-kernel@vger.kernel.org>; Wed,  6 Nov 2024 02:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730861708; cv=none; b=bGSyqHifZ+bvoZCy/CB2nlazUM0E9LJ8oJhwcs3xXr2hW1aUN18hf+JN6eP4+pRg+iaQg1wdS00nKThqiHJ3KRRD+kmIZ79yTn2aJojA80QRnRPDRtQJWRSARaQIVQ86IwyPzD6PQCXgBOevYzOWJer3v/U/0OsC4CLLpd35Z+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730861708; c=relaxed/simple;
	bh=QhBXPSsKnEnmCzBP0SAEtRK8nvfGvdXNm2yrb6YH4pc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CatNbjjhAfDGzOhflGSJ3AxqPaM+ei6j/gZoO2tfGl5wzfsrlR6aqgPBjnmjwYXJ0sxkogfnQvCRNcNrynoqU8KTSkcUCoZEpuC5WZM8KYUjC5MvGBnwh6Hf/l4+P/CKuOECNkc5Ok6YVTPfuROlePI1IX2xcSRtpxqmrPsM0so=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jopZ2uoq; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-43155a6c3a6so5676335e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 05 Nov 2024 18:55:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730861705; x=1731466505; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NQes59cEa49vmeV0NTcJ/qoTjjiI386Lhz/kOgrslMk=;
        b=jopZ2uoq6kk5d/TadXS3VxhCyMqQ88Iy/Ilrfwg8FlQwTkcrN3IaM5vOX4p55thqfF
         TLZLlUsfLzLaPaL5y1q03qdgT+nTmeyxYbhHSKGuWeqGwdWvFnLFZ4FMg5sd4P9V8mtF
         waM7QQE5SH5LUf1hyd45HEHNf6sve3FH6QVB3ftG7aBFcQsfE+5t1KiUO70LcDKvrW/Z
         PcvOpAB727A3NHu9HXPMEHROZYcOauQlHfphjI7QE3Web3g+teP9D51nQ8zFoMYxXpj0
         61cjGHPUEqw7l+kw24D3nXfEnBFA1WRBiQnB5vtYHHzXB6CvJDuFQmE92mHjj4suwaf/
         svIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730861705; x=1731466505;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NQes59cEa49vmeV0NTcJ/qoTjjiI386Lhz/kOgrslMk=;
        b=wKxiWA9eJAFwFtuywLwkBgOU5B6GYpiLfjSLQObb4EELmZ3g3kFGUsPtrzUrehXcCj
         J0w3VovtofjoWnI+NR91cyHm9oU7ldo7jIknxDOKeYrnayDqWUkFyr5WEk5HXILADzMu
         cvX6vStBPWLl5gHfBzoV6bsW0LrZ4czBe2lVO6XVLftWwkUJSNqwjfF6J8zDpXrS/mjs
         INENTTln1BigJBO1nQG3ORQml0zut0DMHD3dOFu51rgXkvEjCe5rH2hnGJycF6ika9KI
         mea5U68dP+X5LwiEhqyoV1KUvHe70HyKeawHr/zLjr87GmF4Ur2EsVf7JQnvAk2RAgBo
         oGeA==
X-Forwarded-Encrypted: i=1; AJvYcCUAyEdaWb8LbydOyZ6y7/IxwS+q4ZXszqyXsSkwKN9kKIGff/vCY38gmHw2lFQ35s1xNEmVbHrFTXQniqY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzEF5N2ZVbTLFsTFhMzUOl0S+diInprbl6DiTIQilfuE/G+4jSY
	eQ2G3Xcr2NKwrtBEUzZqNTstCSLXeVULKWlXuQ4np3Jvs/i9fU+V5tdYUZxJiKTOOrU2tx1ss1m
	yRehTLSbnFI5q6g5FVY2eqvNsYerq6Q==
X-Google-Smtp-Source: AGHT+IF5iR3fBAtxKCM9mgA2N+0sTTGwrkNA6FBz/Fcg8Vby7Oqb1shJKFDArEzhVjogGckl7GAW/eTPglpLrsBMJg8=
X-Received: by 2002:a05:600c:4f0c:b0:431:4983:e8fe with SMTP id
 5b1f17b1804b1-4319ad41c64mr146298255e9.9.1730861704400; Tue, 05 Nov 2024
 18:55:04 -0800 (PST)
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
 <c070fd2d-6480-4833-b03c-ec032ee37a28@kernel.org>
In-Reply-To: <c070fd2d-6480-4833-b03c-ec032ee37a28@kernel.org>
From: Zhiguo Niu <niuzhiguo84@gmail.com>
Date: Wed, 6 Nov 2024 10:54:53 +0800
Message-ID: <CAHJ8P3Jm1+BdGsHNB03tDug8JgEtxkM9A3BE9wectE_khGgDhQ@mail.gmail.com>
Subject: Re: [PATCH V2] f2fs: fix to adjust appropriate length for fiemap
To: Chao Yu <chao@kernel.org>
Cc: Zhiguo Niu <zhiguo.niu@unisoc.com>, jaegeuk@kernel.org, 
	linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, 
	ke.wang@unisoc.com, Hao_hao.Wang@unisoc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Chao Yu <chao@kernel.org> =E4=BA=8E2024=E5=B9=B411=E6=9C=886=E6=97=A5=E5=91=
=A8=E4=B8=89 10:40=E5=86=99=E9=81=93=EF=BC=9A
>
> On 2024/11/6 10:26, Zhiguo Niu wrote:
> > Chao Yu <chao@kernel.org> =E4=BA=8E2024=E5=B9=B411=E6=9C=886=E6=97=A5=
=E5=91=A8=E4=B8=89 10:16=E5=86=99=E9=81=93=EF=BC=9A
> >>
> >> On 2024/11/5 19:02, Zhiguo Niu wrote:
> >>> Chao Yu <chao@kernel.org> =E4=BA=8E2024=E5=B9=B411=E6=9C=885=E6=97=A5=
=E5=91=A8=E4=BA=8C 18:39=E5=86=99=E9=81=93=EF=BC=9A
> >>>>
> >>>> On 2024/11/5 15:28, Zhiguo Niu wrote:
> >>>>> Chao Yu <chao@kernel.org> =E4=BA=8E2024=E5=B9=B411=E6=9C=885=E6=97=
=A5=E5=91=A8=E4=BA=8C 15:04=E5=86=99=E9=81=93=EF=BC=9A
> >>>>>>
> >>>>>> On 2024/11/4 9:56, Zhiguo Niu wrote:
> >>>>>>> If user give a file size as "length" parameter for fiemap
> >>>>>>> operations, but if this size is non-block size aligned,
> >>>>>>> it will show 2 segments fiemap results even this whole file
> >>>>>>> is contiguous on disk, such as the following results:
> >>>>>>>
> >>>>>>>      ./f2fs_io fiemap 0 19034 ylog/analyzer.py
> >>>>>>> Fiemap: offset =3D 0 len =3D 19034
> >>>>>>>             logical addr.    physical addr.   length           fl=
ags
> >>>>>>> 0       0000000000000000 0000000020baa000 0000000000004000 000010=
00
> >>>>>>> 1       0000000000004000 0000000020bae000 0000000000001000 000010=
01
> >>>>>>>
> >>>>>>> after this patch:
> >>>>>>> ./f2fs_io fiemap 0 19034 ylog/analyzer.py
> >>>>>>> Fiemap: offset =3D 0 len =3D 19034
> >>>>>>>         logical addr.    physical addr.   length           flags
> >>>>>>> 0    0000000000000000 00000000315f3000 0000000000005000 00001001
> >>>>>>>
> >>>>>>> Signed-off-by: Zhiguo Niu <zhiguo.niu@unisoc.com>
> >>>>>>> ---
> >>>>>>> V2: correct commit msg according to Chao's questions
> >>>>>>> f2fs_io has been modified for testing, the length for fiemap is
> >>>>>>> real file size, not block number
> >>>>>>> ---
> >>>>>>>      fs/f2fs/data.c | 4 ++--
> >>>>>>>      1 file changed, 2 insertions(+), 2 deletions(-)
> >>>>>>>
> >>>>>>> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
> >>>>>>> index 306b86b0..9fc229d 100644
> >>>>>>> --- a/fs/f2fs/data.c
> >>>>>>> +++ b/fs/f2fs/data.c
> >>>>>>> @@ -1966,8 +1966,8 @@ int f2fs_fiemap(struct inode *inode, struct=
 fiemap_extent_info *fieinfo,
> >>>>>>>                          goto out;
> >>>>>>>          }
> >>>>>>>
> >>>>>>> -     if (bytes_to_blks(inode, len) =3D=3D 0)
> >>>>>>> -             len =3D blks_to_bytes(inode, 1);
> >>>>>>> +     if (len & (blks_to_bytes(inode, 1) - 1))
> >>>>>>> +             len =3D round_up(len, blks_to_bytes(inode, 1));
> >>>>>>
> >>>>>> How do you think of getting rid of above alignment for len?
> >>>>>>
> >>>>>>>
> >>>>>>>          start_blk =3D bytes_to_blks(inode, start);
> >>>>>>>          last_blk =3D bytes_to_blks(inode, start + len - 1);
> >>>>>>
> >>>>>> And round up end position w/:
> >>>>>>
> >>>>>> last_blk =3D bytes_to_blks(inode, round_up(start + len - 1, F2FS_B=
LKSIZE));
> >>>>> Hi Chao,
> >>>>> I think this will change the current code logic
> >>>>> -------------
> >>>>> if (start_blk > last_blk)
> >>>>>        goto out;
> >>>>> -------------
> >>>>> for example, a file with size 19006, but the length from the user i=
s 16384.
> >>>>> before this modification,  last_blk =3D  bytes_to_blks(inode, start=
 +
> >>>>> len - 1) =3D (inode, 16383) =3D 3
> >>>>> after the first f2fs_map_blocks(). start_blk change to be 4,
> >>>>> after the second f2fs_map_blocks(), fiemap_fill_nex_exten will be
> >>>>> called to fill user parameter and then
> >>>>> will goto out because start_blk > last_blk, then fiemap flow finish=
es.
> >>>>> but after this modification, last_blk will be 4
> >>>>> will do f2fs_map_blocks() until reach the max_file_blocks(inode)
> >>>>
> >>>> Yes, you're right, however, w/ this patch, it may change last_blk, e=
.g.
> >>>>
> >>>> xfs_io file -c "fiemap -v 0 19006" vs xfs_io file -c "fiemap -v 2 19=
006"
> >>>> start_blk and last_blk will be: 0, 4 and 0, 5.
> >>> Hi Chao,
> >>> yes, but w/o this patch , the original code still has the same situat=
ion??
> >>> for example
> >>> xfs_io file -c "fiemap -v 0 16384" vs xfs_io file -c "fiemap -v 2 163=
84"
> >>> start_blk and last_blk will be: 0, 3 and 0, 4.
> >>
> >> For the case "fiemap -v 2 19006", offset is 2, and length is 19006, so=
 last_offset
> >> is 19008, and last_blk should be 4 rather than 5, right?
> > hi Chao,
> > it is right w/o my patch.
> >>
> >> And for you case, it calculates last_blk correctly.
> > So you suggest that "Should we round_up len after start_blk & last_blk
> > calculation?"
>
> Zhiguo,
>
> Yes, I think alignment of len should not affect calculation of last_blk.
>
> I mean this,
>
> ---
>   fs/f2fs/data.c          | 6 +++---
>   include/linux/f2fs_fs.h | 3 ++-
>   2 files changed, 5 insertions(+), 4 deletions(-)
>
> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
> index 7d1bb9518a40..cbbb956f420d 100644
> --- a/fs/f2fs/data.c
> +++ b/fs/f2fs/data.c
> @@ -1967,12 +1967,12 @@ int f2fs_fiemap(struct inode *inode, struct fiema=
p_extent_info *fieinfo,
>                         goto out;
>         }
>
> -       if (bytes_to_blks(inode, len) =3D=3D 0)
> -               len =3D blks_to_bytes(inode, 1);
> -
>         start_blk =3D bytes_to_blks(inode, start);
>         last_blk =3D bytes_to_blks(inode, start + len - 1);
>
> +       if (len & F2FS_BLKSIZE_MASK)
> +               len =3D round_up(len, F2FS_BLKSIZE);
> +
Hi Chao,
It looks well and clear, Let me verify this.
another unimportant questions, do we need to use macor
F2FS_BLKSIZE_xxx for round_up?
because in fiemap, it all use bytes_to_blks(inode, xxx) /
blks_to_bytes(inode, xxx)
thanks!
>   next:
>         memset(&map, 0, sizeof(map));
>         map.m_lblk =3D start_blk;
> diff --git a/include/linux/f2fs_fs.h b/include/linux/f2fs_fs.h
> index b0b821edfd97..954e8e8344b7 100644
> --- a/include/linux/f2fs_fs.h
> +++ b/include/linux/f2fs_fs.h
> @@ -24,10 +24,11 @@
>   #define NEW_ADDR              ((block_t)-1)   /* used as block_t addres=
ses */
>   #define COMPRESS_ADDR         ((block_t)-2)   /* used as compressed dat=
a flag */
>
> +#define F2FS_BLKSIZE_MASK              (F2FS_BLKSIZE - 1)
>   #define F2FS_BYTES_TO_BLK(bytes)      ((bytes) >> F2FS_BLKSIZE_BITS)
>   #define F2FS_BLK_TO_BYTES(blk)                ((blk) << F2FS_BLKSIZE_BI=
TS)
>   #define F2FS_BLK_END_BYTES(blk)               (F2FS_BLK_TO_BYTES(blk + =
1) - 1)
> -#define F2FS_BLK_ALIGN(x)                      (F2FS_BYTES_TO_BLK((x) + =
F2FS_BLKSIZE - 1))
> +#define F2FS_BLK_ALIGN(x)              (F2FS_BYTES_TO_BLK((x) + F2FS_BLK=
SIZE - 1))
>
>   /* 0, 1(node nid), 2(meta nid) are reserved node id */
>   #define F2FS_RESERVED_NODE_NUM                3
> --
> 2.40.1
>
>
>
> > Thanks
> >>
> >> Thanks,
> >>
> >>> but overall last_blk will change loop counts but has not affect on th=
e results.
> >>>>
> >>>> Should we round_up len after start_blk & last_blk calculation?
> >>> I thinks it is ok ,but just a little bit redundant with the following
> >>> handling about len.
> >>>
> >>> if (bytes_to_blks(inode, len) =3D=3D 0)
> >>>      len =3D blks_to_bytes(inode, 1);
> >>>
> >>> Based on the above situation,
> >>> do you have any other good suggestions? ^^
> >>> thanks!
> >>>
> >>>>
> >>>> Thanks,
> >>>>
> >>>>> thanks=EF=BC=81
> >>>>>>
> >>>>>> Thanks,
> >>>>>>
> >>>>
> >>
>

