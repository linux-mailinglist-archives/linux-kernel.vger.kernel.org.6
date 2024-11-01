Return-Path: <linux-kernel+bounces-391660-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78EBB9B89F8
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 04:28:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A408C1C2105F
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 03:28:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B1081422B8;
	Fri,  1 Nov 2024 03:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TJFv3CEy"
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5818E13E028
	for <linux-kernel@vger.kernel.org>; Fri,  1 Nov 2024 03:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730431689; cv=none; b=nJq56YnBIpZVMkow29W4yY4C8fGZanVzLDQOuolW31J4v8n2uP+ZJBxkLESAWnUIqvEUMR3vzJIqW0041lt6GjyYvQK0qig360IYN4+QrAYLSERhVgSIs1txsUH+89/MQ6gwYhHQiUSMyyuZ/FP9N0475ob/x/lDci6TuqqER/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730431689; c=relaxed/simple;
	bh=NB1keWdJI+0jryFCr9rbz2Q1QFpfhl4CCYsvRAf49fU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=m9G6G/ygX4DoiV8g03W+TgH8tumNUUbYc2fM+H89cckcC8mscGifn57ldlnJn1GH9SxcPNz4+eQ3OQMikECt86nsOKYvU2hR47FRNqcpTAksA+JJMOvfp2UgfpgZ4xq8ih61l+xpOSGUBMWR5dZmjmejzgRHhl8aGeSUIlQZtJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TJFv3CEy; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3807e72c468so149181f8f.3
        for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 20:28:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730431686; x=1731036486; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R69u2hyNlfGyaoatpAfniwK8rUiF2rXsD+XRzHGuSwU=;
        b=TJFv3CEyypj6nwKzWJL5N4Pbanxrob+TPHMqfjrmnOVoddWcWat3jMJmGacfj2BvS2
         wa/Mwjv4Geft0j1PI03bCyldV7I3MWX7Ndb5+34hzomDyW9zhS+MwOgrczZEs4GOL+uj
         5ENGTRtaMS+aX5xIEihYqGWmHcDyRgEpvqHJ/lB4N7BNbNzQ0JAOr9xQRTirCsyll8Lk
         c9Zex63qU+4UBfzvpUlAMXl8CYMRDnRH6AKT6YdGBE1qHE6uwNIvQ8sUL1YRQMSaBsfz
         6t0LDgT9/s0Nayc2p6G+94X13vvwISKtL/J5h1/pCRnGuxUwdh+4ky3M17tTCwLCuUUm
         QjfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730431686; x=1731036486;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R69u2hyNlfGyaoatpAfniwK8rUiF2rXsD+XRzHGuSwU=;
        b=aP0q7GkC4UTs4i6pFSfCzi6f3KXiXMQzxS79tsEaM8ttfpfTmju9BZQAz0NlrzdWQs
         NtJYOo5YgenRe7SyyE6Wwl06H09wGhLytXx9PGVct0a72CnZWZqr3vTDiS5TYfQ5bCKW
         jxs9V9zibpcqKThIZ2H8F3IQV5yyGfRsEHYNBnRiEC9dN+frrb0CVhXniyKOp98J9Qcw
         mdGjJOt6DGVbFvjynA4Dee+QWCpFjiRZmemwpkXJ0s34/hN0s8MEX4rD5Wexnh5L34T6
         WGNDJU2+mjzQue6XStqiInpu4AHd6CLsbzW+Vx8qO+gknZ18BkT9vvEKm+lfmBGO7QoX
         lfGA==
X-Forwarded-Encrypted: i=1; AJvYcCWq3VT6SUwdq7EzSop++RJIfmjotTFQqaa0OnG5GYX1Tqv1eUYymeubdjirnmjal3ogHi2CD6jOL8Zo4/8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyposDtiWsyHzW/RsjTTVBwV4qreQAzOpK97Bha/gf0SN+4a27C
	tVSs0h4XZu/kZeSUSu312IJJvxWlSiyyaiVomCAEQa+OnXVcWyZk6cCSN1+OObntD3LB3Q2oN+8
	aYnronbv50NDoZIRN2eVZxeb7m0g=
X-Google-Smtp-Source: AGHT+IFWLFV4lDauR2C969+HY4kc7dpyP0D2vWx1p98BhFczoh9gS9oRbhT+EdPhMXeniKq8vgqte3kz8rR4HUj9znI=
X-Received: by 2002:a05:6000:401f:b0:37d:4ca3:310f with SMTP id
 ffacd0b85a97d-3806125dea6mr7442966f8f.12.1730431685362; Thu, 31 Oct 2024
 20:28:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1730354393-19672-1-git-send-email-zhiguo.niu@unisoc.com>
 <1730354393-19672-2-git-send-email-zhiguo.niu@unisoc.com> <bf348748-46ba-47dd-a12d-5111be2df95e@kernel.org>
In-Reply-To: <bf348748-46ba-47dd-a12d-5111be2df95e@kernel.org>
From: Zhiguo Niu <niuzhiguo84@gmail.com>
Date: Fri, 1 Nov 2024 11:27:53 +0800
Message-ID: <CAHJ8P3+VY6RYgrCPJRSjJp82qJaYGUyqR3vV3OGRO_Q774qxxw@mail.gmail.com>
Subject: Re: [PATCH 2/2] f2fs: fix to adjust appropriate length for fiemap
To: Chao Yu <chao@kernel.org>
Cc: Zhiguo Niu <zhiguo.niu@unisoc.com>, jaegeuk@kernel.org, 
	linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, 
	ke.wang@unisoc.com, Hao_hao.Wang@unisoc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Chao Yu <chao@kernel.org> =E4=BA=8E2024=E5=B9=B411=E6=9C=881=E6=97=A5=E5=91=
=A8=E4=BA=94 10:36=E5=86=99=E9=81=93=EF=BC=9A
>
> On 2024/10/31 13:59, Zhiguo Niu wrote:
> > If user give a file size as "length" parameter for fiemap
> > operations, but this size is non-block size aligned,
> > it will show 2 segments fiemap results even this whole file
> > is contiguous on disk, such as the following results, please
> > note that this f2fs_io has been modified for testing.
> >
> >   ./f2fs_io fiemap 0 19304 ylog/analyzer.py
> > Fiemap: offset =3D 0 len =3D 19304
> >          logical addr.    physical addr.   length           flags
> > 0       0000000000000000 0000000020baa000 0000000000004000 00001000
> > 1       0000000000004000 0000000020bae000 0000000000001000 00001001
> >
> > after this patch:
> >   ./f2fs_io fiemap 0 19304 ylog/analyzer.py
> > Fiemap: offset =3D 0 len =3D 19304
> >       logical addr.    physical addr.   length           flags
> > 0     0000000000000000 00000000315f3000 0000000000005000 00001000
>
> Why is FIEMAP_EXTENT_LAST missing in #0 extent? As we can see it
> in #1 extent before your change.
Hi Chao,
for normal fiemap, we just  can tag  FIEMAP_EXTENT_LAST in the following:

/* HOLE */
if (!compr_cluster && !(map.m_flags & F2FS_MAP_FLAGS)) {
start_blk =3D next_pgofs;

if (blks_to_bytes(inode, start_blk) < blks_to_bytes(inode,
max_inode_blocks(inode)))
goto prep_next;

flags |=3D FIEMAP_EXTENT_LAST;
}
but after this patch, if file length =3D 19304, blk len =3D5(page size=3D40=
96),
and f2fs_map_blocks will run once if the file is  contiguous on disk,
and will tag
F2FS_MAP_FLAGS to map.m_flags, so the following case will not run.
then

if (size) {
flags |=3D FIEMAP_EXTENT_MERGED;
if (IS_ENCRYPTED(inode))
flags |=3D FIEMAP_EXTENT_DATA_ENCRYPTED;

ret =3D fiemap_fill_next_extent(fieinfo, logical,
phys, size, flags);
trace_f2fs_fiemap(inode, logical, phys, size, flags, ret);
if (ret)
goto out;
size =3D 0;
}
fiemap_fill_next_extent will return 1, then go out , this fiemap flow finis=
hes.

>
> 1       0000000000004000 0000000020bae000 0000000000001000 00001001
but back to this case, because

next:
memset(&map, 0, sizeof(map));
map.m_lblk =3D start_blk;
map.m_len =3D bytes_to_blks(inode, len);
map.m_next_pgofs =3D &next_pgofs;
map.m_seg_type =3D NO_CHECK_TYPE;

map.m_len will not  reduce the part that has beed maped even map.m_lbk
has changed,
for example, if file length =3D 19304, before patch, map.m_len=3D4,
after once f2fs_map_block,  map.m_lbk=3D4, map.m_len still =3D4, so
there will be "HOLE" case in the follow-up f2fs_map_block
so it will loop until start_blk reaches the maxbytes.
/* HOLE */
if (!compr_cluster && !(map.m_flags & F2FS_MAP_FLAGS)) {
start_blk =3D next_pgofs;

if (blks_to_bytes(inode, start_blk) < blks_to_bytes(inode,
max_inode_blocks(inode)))
goto prep_next;

flags |=3D FIEMAP_EXTENT_LAST;
}

there is another case before this patch, file size =3D 5 blocks, if we
pass the len not
greater than or equal to 5=EF=BC=8C it will not tag FIEMAP_EXTENT_LAST

 # ./f2fs_io_new fiemap 0 4 file.apk
Fiemap: offset =3D 0 len =3D 4
        logical addr.    physical addr.   length           flags
0       0000000000000000 000000070e08f000 0000000000004000 00001008

but if len equal or greater than 5,   it will tag FIEMAP_EXTENT_LAST
 # ./f2fs_io_new fiemap 0 5 file.apk
Fiemap: offset =3D 0 len =3D 5
        logical addr.    physical addr.   length           flags
0       0000000000000000 000000070e08f000 0000000000004000 00001008
1       0000000000004000 000000070e090000 0000000000001000 00001001
thanks!
>
> Thanks,
>
> >
> > Signed-off-by: Zhiguo Niu <zhiguo.niu@unisoc.com>
> > ---
> > f2fs_io has been modified for testing, the length for fiemap is
> > real file size, not block number
> > ---
> >   fs/f2fs/data.c | 4 ++--
> >   1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
> > index 90fa8ab..8c9bb42 100644
> > --- a/fs/f2fs/data.c
> > +++ b/fs/f2fs/data.c
> > @@ -1966,8 +1966,8 @@ int f2fs_fiemap(struct inode *inode, struct fiema=
p_extent_info *fieinfo,
> >                       goto out;
> >       }
> >
> > -     if (bytes_to_blks(inode, len) =3D=3D 0)
> > -             len =3D blks_to_bytes(inode, 1);
> > +     if (len & (blks_to_bytes(inode, 1) - 1))
> > +             len =3D round_up(len, blks_to_bytes(inode, 1));
> >
> >       start_blk =3D bytes_to_blks(inode, start);
> >       last_blk =3D bytes_to_blks(inode, start + len - 1);
>

