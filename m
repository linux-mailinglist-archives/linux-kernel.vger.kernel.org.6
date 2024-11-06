Return-Path: <linux-kernel+bounces-397649-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 567B89BDE84
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 07:08:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A68D1C22EB8
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 06:08:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A1551922D5;
	Wed,  6 Nov 2024 06:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="csaWKdk0"
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAF141917D7
	for <linux-kernel@vger.kernel.org>; Wed,  6 Nov 2024 06:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730873310; cv=none; b=aGvLS5cAINSqAz5+6T80synuNCjWBVH54LLF/uSFiJmy58+u67w3gjI2sTTbYv4LT1+w9JqOkucO+AnFuQc/djcXwu4Pcv6JvFLNgmDQXbR6IK3EDlUaNs8f517EW/sORCgW2Q1X1KTnhJR+8eriAHDGL8M3zXxgQmctdi1k50s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730873310; c=relaxed/simple;
	bh=wdDgAK5RrXo7AWi3gELRpqNSa9tfZPv8UOIJqjTunO4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mAEk9Ee0l6pIAqsW0MCzNnSmDbLwxdg7EWh8jSJqYmcoAi0bYy4wKDrdjGhdfXFxyY2KxBF/MEuGDJFTZjfW+7dB0zI7VzjMdTv9dRhoRdZQSeiPynhJv0jJsWiO83/HAR4zpQKbw+nRhXHxLekXtX+R9lbH+MfDISto+ij1Z34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=csaWKdk0; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-37d4dbb4a89so647836f8f.3
        for <linux-kernel@vger.kernel.org>; Tue, 05 Nov 2024 22:08:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730873304; x=1731478104; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=azHHUl4nqqf7Fe+wXQiRFszybd+J/B98aFc7sI65jX0=;
        b=csaWKdk0THrRNg5/AJSKnEtduYAHk7UGTbFl5GTKmYt1JqvYIONORp/OQVKGfS+nBD
         bRNrajeLEhvVTaAfY5IJzNewjUsKjXCkBNFmtsjKuXAF+oraHaGLGh+3bZ8m8qT5ZHu5
         if0c1v3l2gELipDk9V5gYSaDczt/48yJI3ZvAy9RLAYQgITfUivrvdgx0emf/176YCPx
         uge+h/0Fm9PdkhW9b15GfGqSBAh5CdMybpYG+92kxqOGoJ++SeDIh+nSqG2boepROGle
         BqGs0W26PNa+8mVhqVaJaE5wyNAhjBHD4vBJ3UJdgTko/0gUYl2EgLH6p7gO0uOP0IHX
         0Z1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730873304; x=1731478104;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=azHHUl4nqqf7Fe+wXQiRFszybd+J/B98aFc7sI65jX0=;
        b=fid5H+5kYqtpedxkNQMR6oth8mM8M+gy+bDX5umwZdtlWEiKTcq/4dYX3ADw6QTtW7
         Tp74x4+7xQ9D7p34Fvns+3nS2hldAWlLhGH9NDCu51X/gcOKbQbQtlcKa261WoNVkPQY
         Gz7VUWi8nM1Pl6ZPbUd+8fICKvzf1hV+j1I2AabtVLG+FVS6HAhvgwX+/KTvZ95ci3eD
         jZjt9P0lV1Pv/EvIOW09Z5SPoZrUcO+wtiQd3K5I5YR7wG6yih4aAnJRHlJzJ4TngR/o
         c+plpgoiacE6Jl2J/9tA6Y/fO+tLTez9m0L8Re/ONco7tmdOsnoAeuGJwsgR6tGgKhCs
         +uWA==
X-Forwarded-Encrypted: i=1; AJvYcCUHwuoSGKxUR77Yq8wde/as4htJNUBQYOY6BGATXMj0z2grtfm2JY5qwdnX15ORo0WcHjxSdvQ8HYc1UhQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzUjT8bzRSMU/3hUGrvoLoLRMeBdxy/GXJD+E0LT3vHGj+VN8Pj
	bhkNlf6XYMrtDgMKYJRpaPK7j+bUGNbuPzQhWWZX3voxafbywxwoMWvmni5FzwQSFLc7PtwwOxn
	8rSuIvvsoGbyJPj+i7jvUHDAfEDY=
X-Google-Smtp-Source: AGHT+IEjwIRX1UxVuVYlPr2qH0yTmMcek5+7LydrTDbQhaWFRr8nsAdyjXrzZXYmEQzkyaExSR7Sc+nWMWB9fx4mju4=
X-Received: by 2002:a05:6000:1549:b0:378:955f:d47d with SMTP id
 ffacd0b85a97d-380611fe5e7mr13784511f8f.11.1730873303960; Tue, 05 Nov 2024
 22:08:23 -0800 (PST)
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
Date: Wed, 6 Nov 2024 14:08:12 +0800
Message-ID: <CAHJ8P3L4Q4Pia66o1RQGw5NnUOVxzNgFXUPO33jtqfQ-Oc=G_g@mail.gmail.com>
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
this verion verify pass with my test case.

but there is still another issue in orginal code:
ylog/analyzer.py  size =3D 19034
if I input the following cmd(start/length are both real size, not block num=
ber)
/f2fs_io fiemap 2 16384 ylog/analyzer.py
and the results shows:
Fiemap: offset =3D 2 len =3D 16384
    logical addr.    physical addr.   length           flags
0    0000000000000000 0000000e2ebca000 0000000000004000 00001000
1    0000000000004000 0000000e2ebce000 0000000000001000 00001001
so start_blk/last_blk should be calculate it in the following way?
before:
start_blk =3D bytes_to_blks(inode, start);
last_blk =3D bytes_to_blks(inode, start + len - 1);
after:

start_blk =3D bytes_to_blks(inode, start);
last_blk =3D start_blk + bytes_to_blks(inode, len - 1);
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

