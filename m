Return-Path: <linux-kernel+bounces-391713-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 81BB29B8ABF
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 06:48:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D75C9B210C6
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 05:48:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1D3F1487F4;
	Fri,  1 Nov 2024 05:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MVbInOZC"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98F4836B
	for <linux-kernel@vger.kernel.org>; Fri,  1 Nov 2024 05:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730440118; cv=none; b=GEth5rT3R3cgseh2aw/igiWpkwvoTymRA7lotSCxaoDum7pruE9FyMVy3aHMwm+YZr3xSL/+gDncUKtWW3HFlAcSYK185tb28jxAF/cWEuITQ/bY+1G4aZi4a4nn5Z6BYdry5Ed8Tl68/gtfXAgsxEr8hR3RUpTWeEacWUZuHcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730440118; c=relaxed/simple;
	bh=Dk++3mW8W7uDFc3FqfWKXNpIC+fSF/Ds5k5Kz8OR3Mo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=frw0230V4ws/543LaW6mYgR4qcc6r7He+bGOS5yedjIWw58Q6QgPkBasoU1PZJu1MLuzzERkdOIf88LqtogbHntup4Jqwf6P0J0TKZ8NkeqHE/CcSrGs591lB2dsuev5h1x9ghnsPVSslsvVIoWyJ5MH4ID+TEluvSfHOX944PY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MVbInOZC; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4315dfa3e0bso1930165e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 22:48:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730440114; x=1731044914; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tocm+9fQXJJcOvtJEq9rUApWO8EZrViX+kDeRul5gM0=;
        b=MVbInOZCnuCp/+S21586Por7C4Ok1vpAbQtic2Rdj3z+V6091N7JwTX9cPtcGQj9oI
         W397OXgzeD/H47rlRDb1bkozU0ZoUcX2pLKFZv1leTbjp3qAOdF9BP/UvXHE+zBau0Kk
         i7E9eGLfzwZ1AWE1DyvhIYZzuihlk2AoaZmUOcCxTgajpJqtMiQJDSPRa8fQuIKRecXu
         a8vFhWghxq6+Z9iIM//NV9LL8sUGpLXI46p0GYJn3de16zNWHV/FQJ7eped7/kVT57/p
         ydGhesU8KiXUd9Fu6uIWj6o9kMelMqmR8PtGKBbQVdTY8pqNrNBj7d63VkCPq6p82zui
         DlvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730440114; x=1731044914;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tocm+9fQXJJcOvtJEq9rUApWO8EZrViX+kDeRul5gM0=;
        b=j0/jcmURiIvkT8Vc6Btnz664YmN5JJ2Smq5FdZ+emYlQsEtOSyYpvl6AVDrBMlYJho
         7Tq5S9Gk4F3ePXoMveyZfzh5OXg5AUdJSIUqjXk+la+1SAzkKPnwXixq7BOtb6/ygP5O
         hgZ6I5GBn03eGS5BLThZEOLPMnazokQxgEgYV2ugfSbzOPKnkwhLAjRdlhVPpatLyC6j
         qAjBxatup2yjKWupOsc0GYbZrKonRz8B0ROSqmy64mRsdBO4vcDZmhLttYL6zwInYPHn
         n0evdKJj7t/e7bbutqj0eEenmLdioHZNwW+t8Akw/2biSIjhmxn8mHtgfrGTV6odpNk5
         moTw==
X-Forwarded-Encrypted: i=1; AJvYcCXK2BklHYOm7EMDzgQys7mUfLnbMzRfhhTL1ClCSUEqBy4mOs17PyOFR8vdElAUcJqY+AoiD22ypxq0Iyg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4juPl9K+Z8+Fcc40/hRWqBiwhrIHdMbkA4CjRmFIt3aTmXqQr
	bmRyhqL8VzEKH/37NwMCcOV9Y5/oWtjDXGJNtMXmVOrQipqGC6WkJp0iHlbcG1LVlKx3rwg4mGr
	0PWRNDY8xiKGaCUlTxiWZeKYRY6v6ew==
X-Google-Smtp-Source: AGHT+IGLiqgrdhzH0+Qqr4PxQlkc+m8W6PfG2o5fVCbc8yQnEUgDRQ1v8Wd1Df8TSkcAlQ/SAmvjhvi+moj86g9SoYI=
X-Received: by 2002:a05:600c:3b8a:b0:42c:b8da:c79b with SMTP id
 5b1f17b1804b1-4319ad082c5mr83187225e9.5.1730440113534; Thu, 31 Oct 2024
 22:48:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1730354393-19672-1-git-send-email-zhiguo.niu@unisoc.com>
 <1730354393-19672-2-git-send-email-zhiguo.niu@unisoc.com> <bf348748-46ba-47dd-a12d-5111be2df95e@kernel.org>
 <CAHJ8P3+VY6RYgrCPJRSjJp82qJaYGUyqR3vV3OGRO_Q774qxxw@mail.gmail.com>
In-Reply-To: <CAHJ8P3+VY6RYgrCPJRSjJp82qJaYGUyqR3vV3OGRO_Q774qxxw@mail.gmail.com>
From: Zhiguo Niu <niuzhiguo84@gmail.com>
Date: Fri, 1 Nov 2024 13:48:22 +0800
Message-ID: <CAHJ8P3LFDBwgm1SUr3A3fNOLbP37vybPLuUJ=aYBtKgEh66BfQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] f2fs: fix to adjust appropriate length for fiemap
To: Chao Yu <chao@kernel.org>
Cc: Zhiguo Niu <zhiguo.niu@unisoc.com>, jaegeuk@kernel.org, 
	linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, 
	ke.wang@unisoc.com, Hao_hao.Wang@unisoc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Zhiguo Niu <niuzhiguo84@gmail.com> =E4=BA=8E2024=E5=B9=B411=E6=9C=881=E6=97=
=A5=E5=91=A8=E4=BA=94 11:27=E5=86=99=E9=81=93=EF=BC=9A
>
> Chao Yu <chao@kernel.org> =E4=BA=8E2024=E5=B9=B411=E6=9C=881=E6=97=A5=E5=
=91=A8=E4=BA=94 10:36=E5=86=99=E9=81=93=EF=BC=9A
> >
> > On 2024/10/31 13:59, Zhiguo Niu wrote:
> > > If user give a file size as "length" parameter for fiemap
> > > operations, but this size is non-block size aligned,
> > > it will show 2 segments fiemap results even this whole file
> > > is contiguous on disk, such as the following results, please
> > > note that this f2fs_io has been modified for testing.
> > >
> > >   ./f2fs_io fiemap 0 19304 ylog/analyzer.py
> > > Fiemap: offset =3D 0 len =3D 19304
> > >          logical addr.    physical addr.   length           flags
> > > 0       0000000000000000 0000000020baa000 0000000000004000 00001000
> > > 1       0000000000004000 0000000020bae000 0000000000001000 00001001
> > >
> > > after this patch:
> > >   ./f2fs_io fiemap 0 19304 ylog/analyzer.py
> > > Fiemap: offset =3D 0 len =3D 19304
> > >       logical addr.    physical addr.   length           flags
> > > 0     0000000000000000 00000000315f3000 0000000000005000 00001000
> >
> > Why is FIEMAP_EXTENT_LAST missing in #0 extent? As we can see it
> > in #1 extent before your change.
> Hi Chao,
> for normal fiemap, we just  can tag  FIEMAP_EXTENT_LAST in the following:
>
> /* HOLE */
> if (!compr_cluster && !(map.m_flags & F2FS_MAP_FLAGS)) {
> start_blk =3D next_pgofs;
>
> if (blks_to_bytes(inode, start_blk) < blks_to_bytes(inode,
> max_inode_blocks(inode)))
> goto prep_next;
>
> flags |=3D FIEMAP_EXTENT_LAST;
> }
> but after this patch, if file length =3D 19304, blk len =3D5(page size=3D=
4096),
> and f2fs_map_blocks will run once if the file is  contiguous on disk,
> and will tag
> F2FS_MAP_FLAGS to map.m_flags, so the following case will not run.
> then
>
> if (size) {
> flags |=3D FIEMAP_EXTENT_MERGED;
> if (IS_ENCRYPTED(inode))
> flags |=3D FIEMAP_EXTENT_DATA_ENCRYPTED;
>
> ret =3D fiemap_fill_next_extent(fieinfo, logical,
> phys, size, flags);
> trace_f2fs_fiemap(inode, logical, phys, size, flags, ret);
> if (ret)
> goto out;
> size =3D 0;
> }
> fiemap_fill_next_extent will return 1, then go out , this fiemap flow fin=
ishes.
>
> >
> > 1       0000000000004000 0000000020bae000 0000000000001000 00001001
> but back to this case, because
>
> next:
> memset(&map, 0, sizeof(map));
> map.m_lblk =3D start_blk;
> map.m_len =3D bytes_to_blks(inode, len);
> map.m_next_pgofs =3D &next_pgofs;
> map.m_seg_type =3D NO_CHECK_TYPE;
>
> map.m_len will not  reduce the part that has beed maped even map.m_lbk
> has changed,
> for example, if file length =3D 19304, before patch, map.m_len=3D4,
> after once f2fs_map_block,  map.m_lbk=3D4, map.m_len still =3D4, so
> there will be "HOLE" case in the follow-up f2fs_map_block
> so it will loop until start_blk reaches the maxbytes.
> /* HOLE */
> if (!compr_cluster && !(map.m_flags & F2FS_MAP_FLAGS)) {
> start_blk =3D next_pgofs;
>
> if (blks_to_bytes(inode, start_blk) < blks_to_bytes(inode,
> max_inode_blocks(inode)))
> goto prep_next;
>
> flags |=3D FIEMAP_EXTENT_LAST;
> }
>
> there is another case before this patch, file size =3D 5 blocks, if we
> pass the len not
> greater than or equal to 5=EF=BC=8C it will not tag FIEMAP_EXTENT_LAST
>
>  # ./f2fs_io_new fiemap 0 4 file.apk
> Fiemap: offset =3D 0 len =3D 4
>         logical addr.    physical addr.   length           flags
> 0       0000000000000000 000000070e08f000 0000000000004000 00001008
>
> but if len equal or greater than 5,   it will tag FIEMAP_EXTENT_LAST
>  # ./f2fs_io_new fiemap 0 5 file.apk
> Fiemap: offset =3D 0 len =3D 5
>         logical addr.    physical addr.   length           flags
> 0       0000000000000000 000000070e08f000 0000000000004000 00001008
> 1       0000000000004000 000000070e090000 0000000000001000 00001001
> thanks!
Hi Chao, pls ignore this reply , I will confirm your questions.
thanks a lot~
> >
> > Thanks,
> >
> > >
> > > Signed-off-by: Zhiguo Niu <zhiguo.niu@unisoc.com>
> > > ---
> > > f2fs_io has been modified for testing, the length for fiemap is
> > > real file size, not block number
> > > ---
> > >   fs/f2fs/data.c | 4 ++--
> > >   1 file changed, 2 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
> > > index 90fa8ab..8c9bb42 100644
> > > --- a/fs/f2fs/data.c
> > > +++ b/fs/f2fs/data.c
> > > @@ -1966,8 +1966,8 @@ int f2fs_fiemap(struct inode *inode, struct fie=
map_extent_info *fieinfo,
> > >                       goto out;
> > >       }
> > >
> > > -     if (bytes_to_blks(inode, len) =3D=3D 0)
> > > -             len =3D blks_to_bytes(inode, 1);
> > > +     if (len & (blks_to_bytes(inode, 1) - 1))
> > > +             len =3D round_up(len, blks_to_bytes(inode, 1));
> > >
> > >       start_blk =3D bytes_to_blks(inode, start);
> > >       last_blk =3D bytes_to_blks(inode, start + len - 1);
> >

