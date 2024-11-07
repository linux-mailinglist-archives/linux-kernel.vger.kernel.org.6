Return-Path: <linux-kernel+bounces-399419-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D02B9BFEB2
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 07:54:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C1FC01F23BFF
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 06:54:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD3B4194C94;
	Thu,  7 Nov 2024 06:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CEji78aQ"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1ACB13A26F
	for <linux-kernel@vger.kernel.org>; Thu,  7 Nov 2024 06:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730962469; cv=none; b=ZZGfh02J9y3B92uYYFx0qhZi1sIhPRDCxqzi1tJoT7YHXTklYCYFeT5oEwADmO0BNLsP/Zxk4rBChvIJz3speaAQAuvNYSK7fxvYIzwy1CmPw3Wui3DE59ncTrID7WqK4gWOZRYTpWF2WInf5X5a3LulUVVwqk7GYMBMx0oKwd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730962469; c=relaxed/simple;
	bh=3veo/8Jx3xGgJv+sYABPU+3P5epaRQIEseGJ7zikPHQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QFZ+osBYv3XRgcu/9A83d4z/olkTydLO//jMg4RwU/sp2qDG1HYuBWPThTjKr7JSeyI53P6b4BMgzA5X0LCVc5JpjP9saSQE7Fcu22GbrXfIekoO66JOa2x9/lh3pEEVM21Uk1Pg3Yaf1QNMYc6FV9EUcDDXz3sqcBWZLBcLwko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CEji78aQ; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4315b0bd4ddso956325e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 06 Nov 2024 22:54:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730962466; x=1731567266; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VyxLhBQWjzlLqMsUsjx2AG4ZJO4tKIV9372UqntirLo=;
        b=CEji78aQ4zlu77w9v0LtT73Y1TMXnchLMn2zNgv8yxt9unDOqoA22kCbBkHUd5WPUf
         Z10m0sYskqLbPP77mVgqLmXHCnf3/50m4rLMjIacE46aGYLStsjPY1s6X74RGKmAxEnf
         +NBRDvLicaK6ivnZoy9OutkJikutq30+/Krw2lm+gdBMdXB5VPA4knm4bdVDUs6WihlX
         z3fTf6RwEdnRKJMfGx5VqvjqRd8lspGE0fC9AhOIRQc5s41dOVHMxfRjWzFw10zYbCmH
         IeSCvjSNGPsLrYoOt0YfFgtf0blfwVp6cRkD7S8MJBSYH/7/5D5xkzZ110u583UljLPR
         8rKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730962466; x=1731567266;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VyxLhBQWjzlLqMsUsjx2AG4ZJO4tKIV9372UqntirLo=;
        b=Wi8iWOvIs1e5pYGONlKHfEpkoOyjlNOX57pu/57IozNt4n1mat8ILN7HsRA8z4awdf
         JJQZrIHVoQogaLUI52Gybz5SnxinTyLBHUvS9Ad60pNcEWx2eURL42RFsmSynfCZfhom
         5A4xFzfzWDmMkEo4V4pyLjPtSYaMXKgzG0fU/t2OT0O694GtQQG8zMXNDRW0/EJnHDHp
         fIH3tR+R7Nmj+h4S1F0CWnQnVQdIqJ6qEsIV+ydT89TSwzZzOI9KRRb2lBL/ERx3MO2v
         bmXucNVoOiEN8kclnY3sxKyWLRnVpAa/iCIeWqeUGQfjGBZGIx/13AXWTt/4lvOCjQzH
         8LTw==
X-Forwarded-Encrypted: i=1; AJvYcCWRPvLjyiM17/Ie2GnA0VgoBPSjW4tDncxDcD7HlyPNSdeswRrUPNDNGCjcQF/EA+2yvs1YnAQ6pY6tAn8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9Pu6dx/V0jRrrspSU4vNwb4XWV5Bc4Aa9o/dJMyn5hdkXLDwY
	RhMNtJhtBltRO/R7VAxNGyfTHNxeDdRCaJk+FZ884IrYxyBq9sU4kfqvdwIhsZdFaz6OtbDitiY
	f5blOcAgyqv3bt0Y374RttB9SntipW0cX
X-Google-Smtp-Source: AGHT+IFxkWp0+ajRnKoDn6ec/DJOLyHh4BtzKlrtLTRvciUZK6q3TH2qalx4yZMDhl79+gg7wt+99SudHnprpWIfytA=
X-Received: by 2002:a05:6000:4028:b0:37d:4f25:816d with SMTP id
 ffacd0b85a97d-381ef6ba2f8mr6650f8f.4.1730962465814; Wed, 06 Nov 2024 22:54:25
 -0800 (PST)
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
 <d5ef36a3-1bcb-40a0-a963-c6d1887c4e4e@kernel.org>
In-Reply-To: <d5ef36a3-1bcb-40a0-a963-c6d1887c4e4e@kernel.org>
From: Zhiguo Niu <niuzhiguo84@gmail.com>
Date: Thu, 7 Nov 2024 14:54:14 +0800
Message-ID: <CAHJ8P3JARkFxkyz-FLWN2PSZb2AL3=dSqF1v-SR-oU9z6tm+Rg@mail.gmail.com>
Subject: Re: [PATCH V2] f2fs: fix to adjust appropriate length for fiemap
To: Chao Yu <chao@kernel.org>
Cc: Zhiguo Niu <zhiguo.niu@unisoc.com>, jaegeuk@kernel.org, 
	linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, 
	ke.wang@unisoc.com, Hao_hao.Wang@unisoc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Chao Yu <chao@kernel.org> =E4=BA=8E2024=E5=B9=B411=E6=9C=887=E6=97=A5=E5=91=
=A8=E5=9B=9B 14:18=E5=86=99=E9=81=93=EF=BC=9A
>
> On 2024/11/6 16:41, Zhiguo Niu wrote:
> > Chao Yu <chao@kernel.org> =E4=BA=8E2024=E5=B9=B411=E6=9C=886=E6=97=A5=
=E5=91=A8=E4=B8=89 15:40=E5=86=99=E9=81=93=EF=BC=9A
> >>
> >> On 2024/11/6 14:08, Zhiguo Niu wrote:
> >>> Chao Yu <chao@kernel.org> =E4=BA=8E2024=E5=B9=B411=E6=9C=886=E6=97=A5=
=E5=91=A8=E4=B8=89 10:40=E5=86=99=E9=81=93=EF=BC=9A
> >>>>
> >>>> On 2024/11/6 10:26, Zhiguo Niu wrote:
> >>>>> Chao Yu <chao@kernel.org> =E4=BA=8E2024=E5=B9=B411=E6=9C=886=E6=97=
=A5=E5=91=A8=E4=B8=89 10:16=E5=86=99=E9=81=93=EF=BC=9A
> >>>>>>
> >>>>>> On 2024/11/5 19:02, Zhiguo Niu wrote:
> >>>>>>> Chao Yu <chao@kernel.org> =E4=BA=8E2024=E5=B9=B411=E6=9C=885=E6=
=97=A5=E5=91=A8=E4=BA=8C 18:39=E5=86=99=E9=81=93=EF=BC=9A
> >>>>>>>>
> >>>>>>>> On 2024/11/5 15:28, Zhiguo Niu wrote:
> >>>>>>>>> Chao Yu <chao@kernel.org> =E4=BA=8E2024=E5=B9=B411=E6=9C=885=E6=
=97=A5=E5=91=A8=E4=BA=8C 15:04=E5=86=99=E9=81=93=EF=BC=9A
> >>>>>>>>>>
> >>>>>>>>>> On 2024/11/4 9:56, Zhiguo Niu wrote:
> >>>>>>>>>>> If user give a file size as "length" parameter for fiemap
> >>>>>>>>>>> operations, but if this size is non-block size aligned,
> >>>>>>>>>>> it will show 2 segments fiemap results even this whole file
> >>>>>>>>>>> is contiguous on disk, such as the following results:
> >>>>>>>>>>>
> >>>>>>>>>>>        ./f2fs_io fiemap 0 19034 ylog/analyzer.py
> >>>>>>>>>>> Fiemap: offset =3D 0 len =3D 19034
> >>>>>>>>>>>               logical addr.    physical addr.   length       =
    flags
> >>>>>>>>>>> 0       0000000000000000 0000000020baa000 0000000000004000 00=
001000
> >>>>>>>>>>> 1       0000000000004000 0000000020bae000 0000000000001000 00=
001001
> >>>>>>>>>>>
> >>>>>>>>>>> after this patch:
> >>>>>>>>>>> ./f2fs_io fiemap 0 19034 ylog/analyzer.py
> >>>>>>>>>>> Fiemap: offset =3D 0 len =3D 19034
> >>>>>>>>>>>           logical addr.    physical addr.   length           =
flags
> >>>>>>>>>>> 0    0000000000000000 00000000315f3000 0000000000005000 00001=
001
> >>>>>>>>>>>
> >>>>>>>>>>> Signed-off-by: Zhiguo Niu <zhiguo.niu@unisoc.com>
> >>>>>>>>>>> ---
> >>>>>>>>>>> V2: correct commit msg according to Chao's questions
> >>>>>>>>>>> f2fs_io has been modified for testing, the length for fiemap =
is
> >>>>>>>>>>> real file size, not block number
> >>>>>>>>>>> ---
> >>>>>>>>>>>        fs/f2fs/data.c | 4 ++--
> >>>>>>>>>>>        1 file changed, 2 insertions(+), 2 deletions(-)
> >>>>>>>>>>>
> >>>>>>>>>>> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
> >>>>>>>>>>> index 306b86b0..9fc229d 100644
> >>>>>>>>>>> --- a/fs/f2fs/data.c
> >>>>>>>>>>> +++ b/fs/f2fs/data.c
> >>>>>>>>>>> @@ -1966,8 +1966,8 @@ int f2fs_fiemap(struct inode *inode, st=
ruct fiemap_extent_info *fieinfo,
> >>>>>>>>>>>                            goto out;
> >>>>>>>>>>>            }
> >>>>>>>>>>>
> >>>>>>>>>>> -     if (bytes_to_blks(inode, len) =3D=3D 0)
> >>>>>>>>>>> -             len =3D blks_to_bytes(inode, 1);
> >>>>>>>>>>> +     if (len & (blks_to_bytes(inode, 1) - 1))
> >>>>>>>>>>> +             len =3D round_up(len, blks_to_bytes(inode, 1));
> >>>>>>>>>>
> >>>>>>>>>> How do you think of getting rid of above alignment for len?
> >>>>>>>>>>
> >>>>>>>>>>>
> >>>>>>>>>>>            start_blk =3D bytes_to_blks(inode, start);
> >>>>>>>>>>>            last_blk =3D bytes_to_blks(inode, start + len - 1)=
;
> >>>>>>>>>>
> >>>>>>>>>> And round up end position w/:
> >>>>>>>>>>
> >>>>>>>>>> last_blk =3D bytes_to_blks(inode, round_up(start + len - 1, F2=
FS_BLKSIZE));
> >>>>>>>>> Hi Chao,
> >>>>>>>>> I think this will change the current code logic
> >>>>>>>>> -------------
> >>>>>>>>> if (start_blk > last_blk)
> >>>>>>>>>          goto out;
> >>>>>>>>> -------------
> >>>>>>>>> for example, a file with size 19006, but the length from the us=
er is 16384.
> >>>>>>>>> before this modification,  last_blk =3D  bytes_to_blks(inode, s=
tart +
> >>>>>>>>> len - 1) =3D (inode, 16383) =3D 3
> >>>>>>>>> after the first f2fs_map_blocks(). start_blk change to be 4,
> >>>>>>>>> after the second f2fs_map_blocks(), fiemap_fill_nex_exten will =
be
> >>>>>>>>> called to fill user parameter and then
> >>>>>>>>> will goto out because start_blk > last_blk, then fiemap flow fi=
nishes.
> >>>>>>>>> but after this modification, last_blk will be 4
> >>>>>>>>> will do f2fs_map_blocks() until reach the max_file_blocks(inode=
)
> >>>>>>>>
> >>>>>>>> Yes, you're right, however, w/ this patch, it may change last_bl=
k, e.g.
> >>>>>>>>
> >>>>>>>> xfs_io file -c "fiemap -v 0 19006" vs xfs_io file -c "fiemap -v =
2 19006"
> >>>>>>>> start_blk and last_blk will be: 0, 4 and 0, 5.
> >>>>>>> Hi Chao,
> >>>>>>> yes, but w/o this patch , the original code still has the same si=
tuation??
> >>>>>>> for example
> >>>>>>> xfs_io file -c "fiemap -v 0 16384" vs xfs_io file -c "fiemap -v 2=
 16384"
> >>>>>>> start_blk and last_blk will be: 0, 3 and 0, 4.
> >>>>>>
> >>>>>> For the case "fiemap -v 2 19006", offset is 2, and length is 19006=
, so last_offset
> >>>>>> is 19008, and last_blk should be 4 rather than 5, right?
> >>>>> hi Chao,
> >>>>> it is right w/o my patch.
> >>>>>>
> >>>>>> And for you case, it calculates last_blk correctly.
> >>>>> So you suggest that "Should we round_up len after start_blk & last_=
blk
> >>>>> calculation?"
> >>>>
> >>>> Zhiguo,
> >>>>
> >>>> Yes, I think alignment of len should not affect calculation of last_=
blk.
> >>>>
> >>>> I mean this,
> >>>>
> >>>> ---
> >>>>     fs/f2fs/data.c          | 6 +++---
> >>>>     include/linux/f2fs_fs.h | 3 ++-
> >>>>     2 files changed, 5 insertions(+), 4 deletions(-)
> >>>>
> >>>> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
> >>>> index 7d1bb9518a40..cbbb956f420d 100644
> >>>> --- a/fs/f2fs/data.c
> >>>> +++ b/fs/f2fs/data.c
> >>>> @@ -1967,12 +1967,12 @@ int f2fs_fiemap(struct inode *inode, struct =
fiemap_extent_info *fieinfo,
> >>>>                           goto out;
> >>>>           }
> >>>>
> >>>> -       if (bytes_to_blks(inode, len) =3D=3D 0)
> >>>> -               len =3D blks_to_bytes(inode, 1);
> >>>> -
> >>>>           start_blk =3D bytes_to_blks(inode, start);
> >>>>           last_blk =3D bytes_to_blks(inode, start + len - 1);
> >>>>
> >>>> +       if (len & F2FS_BLKSIZE_MASK)
> >>>> +               len =3D round_up(len, F2FS_BLKSIZE);
> >>>> +
> >>> Hi Chao,
> >>> this verion verify pass with my test case.
> >>>
> >>> but there is still another issue in orginal code:
> >>> ylog/analyzer.py  size =3D 19034
> >>> if I input the following cmd(start/length are both real size, not blo=
ck number)
> >>> /f2fs_io fiemap 2 16384 ylog/analyzer.py
> >>> and the results shows:
> >>> Fiemap: offset =3D 2 len =3D 16384
> >>>       logical addr.    physical addr.   length           flags
> >>> 0    0000000000000000 0000000e2ebca000 0000000000004000 00001000
> >>> 1    0000000000004000 0000000e2ebce000 0000000000001000 00001001
> >>> so start_blk/last_blk should be calculate it in the following way?
> >>
> >> IIUC, the root cause is f2fs_map_blocks() will truncate size of
> >> returned extent to F2FS_BYTES_TO_BLK(len), so whenever parameter
> >> @len doesn't cover last extent, it triggers this bug.
> >>
> >> next:
> >>          memset(&map, 0, sizeof(map));
> >>          map.m_lblk =3D start_blk;
> >>          map.m_len =3D F2FS_BYTES_TO_BLK(len);  --- limit max size of =
extent it founds
> > yes, I think so too.
> >>          map.m_next_pgofs =3D &next_pgofs;
> >>          map.m_seg_type =3D NO_CHECK_TYPE;
> >> ...
> >>          ret =3D f2fs_map_blocks(inode, &map, F2FS_GET_BLOCK_FIEMAP);
> >>
> >> xfs_io file -c "fiemap -v 2 16384"
> >> file:
> >>    EXT: FILE-OFFSET      BLOCK-RANGE      TOTAL FLAGS
> >>      0: [0..31]:         139272..139303      32 0x1000
> >>      1: [32..39]:        139304..139311       8 0x1001
> >> xfs_io file -c "fiemap -v 0 16384"
> >> file:
> >>    EXT: FILE-OFFSET      BLOCK-RANGE      TOTAL FLAGS
> >>      0: [0..31]:         139272..139303      32 0x1000
> >> xfs_io file -c "fiemap -v 0 16385"
> >> file:
> >>    EXT: FILE-OFFSET      BLOCK-RANGE      TOTAL FLAGS
> >>      0: [0..39]:         139272..139311      40 0x1001
> >
> > But  If the correct last_blk is calculated correctly, fiemap can be
> > ended as soon as possible?  so the results shown is also right?
>
> Zhiguo,
>
> IMO, it's not, due to 1) if the extent is last one, FIEMAP_EXTENT_LAST
> must be tagged to notice user that it doesn't need further fiemap on
> latter LBA, 2) one continuous extent should not be split to two.
>
> Let me figure out a fix for that.
Hi Chao,
OK, thanks for your explaination.
btw, Do I need to update a patch about the original issue we disscussed?
or you will modify it together?
thanks!
>
> Thanks,
>
> > such as this special case "xfs_io file -c "fiemap -v 2 16384" we discus=
sed.
> > but it is fine for me to keep the current codes.
> > thanks!
> >>
> >> Thoughts?
> >>
> >> Thanks,
> >>
> >>> before:
> >>> start_blk =3D bytes_to_blks(inode, start);
> >>> last_blk =3D bytes_to_blks(inode, start + len - 1);
> >>> after:
> >>>
> >>> start_blk =3D bytes_to_blks(inode, start);
> >>> last_blk =3D start_blk + bytes_to_blks(inode, len - 1);
> >>> thanks!
> >>>>     next:
> >>>>           memset(&map, 0, sizeof(map));
> >>>>           map.m_lblk =3D start_blk;
> >>>> diff --git a/include/linux/f2fs_fs.h b/include/linux/f2fs_fs.h
> >>>> index b0b821edfd97..954e8e8344b7 100644
> >>>> --- a/include/linux/f2fs_fs.h
> >>>> +++ b/include/linux/f2fs_fs.h
> >>>> @@ -24,10 +24,11 @@
> >>>>     #define NEW_ADDR              ((block_t)-1)   /* used as block_t=
 addresses */
> >>>>     #define COMPRESS_ADDR         ((block_t)-2)   /* used as compres=
sed data flag */
> >>>>
> >>>> +#define F2FS_BLKSIZE_MASK              (F2FS_BLKSIZE - 1)
> >>>>     #define F2FS_BYTES_TO_BLK(bytes)      ((bytes) >> F2FS_BLKSIZE_B=
ITS)
> >>>>     #define F2FS_BLK_TO_BYTES(blk)                ((blk) << F2FS_BLK=
SIZE_BITS)
> >>>>     #define F2FS_BLK_END_BYTES(blk)               (F2FS_BLK_TO_BYTES=
(blk + 1) - 1)
> >>>> -#define F2FS_BLK_ALIGN(x)                      (F2FS_BYTES_TO_BLK((=
x) + F2FS_BLKSIZE - 1))
> >>>> +#define F2FS_BLK_ALIGN(x)              (F2FS_BYTES_TO_BLK((x) + F2F=
S_BLKSIZE - 1))
> >>>>
> >>>>     /* 0, 1(node nid), 2(meta nid) are reserved node id */
> >>>>     #define F2FS_RESERVED_NODE_NUM                3
> >>>> --
> >>>> 2.40.1
> >>>>
> >>>>
> >>>>
> >>>>> Thanks
> >>>>>>
> >>>>>> Thanks,
> >>>>>>
> >>>>>>> but overall last_blk will change loop counts but has not affect o=
n the results.
> >>>>>>>>
> >>>>>>>> Should we round_up len after start_blk & last_blk calculation?
> >>>>>>> I thinks it is ok ,but just a little bit redundant with the follo=
wing
> >>>>>>> handling about len.
> >>>>>>>
> >>>>>>> if (bytes_to_blks(inode, len) =3D=3D 0)
> >>>>>>>        len =3D blks_to_bytes(inode, 1);
> >>>>>>>
> >>>>>>> Based on the above situation,
> >>>>>>> do you have any other good suggestions? ^^
> >>>>>>> thanks!
> >>>>>>>
> >>>>>>>>
> >>>>>>>> Thanks,
> >>>>>>>>
> >>>>>>>>> thanks=EF=BC=81
> >>>>>>>>>>
> >>>>>>>>>> Thanks,
> >>>>>>>>>>
> >>>>>>>>
> >>>>>>
> >>>>
> >>
>

