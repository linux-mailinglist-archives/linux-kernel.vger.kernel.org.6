Return-Path: <linux-kernel+bounces-288204-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE0D9953741
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 17:29:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1BB791C251ED
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 15:29:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA2321AD3F7;
	Thu, 15 Aug 2024 15:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JdKjJPlf"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2C191A00EC
	for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2024 15:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723735790; cv=none; b=d0OA5p7iII2zeFQLWS6XvB0VFV84NXs/8wqU/3AvdJ2pOTZDXEoTehiw8ZGpiVl1okzFRHx7h23BF54lL19wux68XzJ03kern6UbJCnaCNIL1+eaLwq1fgAEdKSFffF0n30CaUSerHtJzsn8g0v1gtzugRLpJRobPNLe04qBpM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723735790; c=relaxed/simple;
	bh=pI8L/RvDGnryLxS0LDdr60wqC3uvj+nWgBAUoDUazXI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jm00deCl90pGJJlGztEowPg3N5gU0TZrh8v7mfm7LOhKmOsw42zOCXhflgcs0Z9Gy3Ldy17qVUFv35YM9HJpPWuWFtG30kygCzvbepVoWKhi07haAlb/S6E3B8ua+vbf94IamEifEOJBolvbck9cHsOQmPcT9737X/z4LlMGMco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JdKjJPlf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B7A8C32786;
	Thu, 15 Aug 2024 15:29:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723735789;
	bh=pI8L/RvDGnryLxS0LDdr60wqC3uvj+nWgBAUoDUazXI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JdKjJPlf7v2Y1Lj7NmPGxBj4PKcneKao15DLyuq6cyuN/6U7Xw+DMnG6coeXyvVOx
	 IX2LuVvHV3fUM45Q6Oy5+OuoEs/KJ0aR1mMKQYy9B2X/mJqGfqib+coF3Zcannz+VR
	 RL0X4mUr9Df55fKbkhSy/UBfZZ9Qulf0jziRZDyRmcZmUMTqyNHD5//RGOcSNfrP7S
	 qnuXLJG+aRKj5SupigskfsktTuIVvoKGo2KcXs7sLdBZndPlUlooJsps4XpTjKeco+
	 Tm+RLWbsKx4K1MGzXBGNSoEUJDO2VAb/uP1mwJxjxj+hM9ghfR43KqktxnSQIQhKho
	 yqHyCFPBSMJIQ==
Date: Thu, 15 Aug 2024 15:29:47 +0000
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: Diogo Jahchan Koike <djahchankoike@gmail.com>
Cc: Chao Yu <chao@kernel.org>, linux-f2fs-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	linux-kernel-mentees@lists.linuxfoundation.org,
	syzbot+733300ca0a9baca7e245@syzkaller.appspotmail.com,
	syzkaller-bugs@googlegroups.com
Subject: Re: [PATCH] f2fs: fix unreleased reader lock on return
Message-ID: <Zr4e6zsKOotTLVTp@google.com>
References: <20240814211640.167728-1-djahchankoike@gmail.com>
 <efcc15bf-0248-4690-b4d4-11022d12cffd@kernel.org>
 <CAJwTMzrXOBrZ2XSG4GykDhjeTAztO8j1h8zoAFGZeZBqZF5brQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJwTMzrXOBrZ2XSG4GykDhjeTAztO8j1h8zoAFGZeZBqZF5brQ@mail.gmail.com>

On 08/15, Diogo Jahchan Koike wrote:
> No problem whatsoever.

Thanks. I removed the original patch from -next. Chao, please post a fixed
version.

> 
> Thanks,
> 
> Em qua., 14 de ago. de 2024, 21:51, Chao Yu <chao@kernel.org> escreveu:
> 
> > On 2024/8/15 5:16, Diogo Jahchan Koike wrote:
> > > fix reader lock unreleased in error path.
> >
> > Thank you for catching this, if you don't mind, I'd like to merge it to
> > original patch, since it is still in dev-test branch.
> >
> > Thanks,
> >
> > >
> > > Fixes: 374a8881ce4c ("f2fs: atomic: fix to forbid dio in atomic_file")
> > > Reported-by: syzbot+733300ca0a9baca7e245@syzkaller.appspotmail.com
> > > Closes: https://syzkaller.appspot.com/bug?extid=733300ca0a9baca7e245
> > > Signed-off-by: Diogo Jahchan Koike <djahchankoike@gmail.com>
> > > ---
> > >   fs/f2fs/file.c | 4 ++++
> > >   1 file changed, 4 insertions(+)
> > >
> > > diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
> > > index 51f6ffd5f4e2..c9eda5dbd11f 100644
> > > --- a/fs/f2fs/file.c
> > > +++ b/fs/f2fs/file.c
> > > @@ -2172,6 +2172,7 @@ static int f2fs_ioc_start_atomic_write(struct file
> > *filp, bool truncate)
> > >       ret = filemap_write_and_wait_range(inode->i_mapping, 0, LLONG_MAX);
> > >       if (ret) {
> > >               f2fs_up_write(&fi->i_gc_rwsem[WRITE]);
> > > +             f2fs_up_write(&fi->i_gc_rwsem[READ]);
> > >               goto out;
> > >       }
> > >
> > > @@ -2181,6 +2182,7 @@ static int f2fs_ioc_start_atomic_write(struct file
> > *filp, bool truncate)
> > >               pinode = f2fs_iget(inode->i_sb, fi->i_pino);
> > >               if (IS_ERR(pinode)) {
> > >                       f2fs_up_write(&fi->i_gc_rwsem[WRITE]);
> > > +                     f2fs_up_write(&fi->i_gc_rwsem[READ]);
> > >                       ret = PTR_ERR(pinode);
> > >                       goto out;
> > >               }
> > > @@ -2189,6 +2191,7 @@ static int f2fs_ioc_start_atomic_write(struct file
> > *filp, bool truncate)
> > >               iput(pinode);
> > >               if (ret) {
> > >                       f2fs_up_write(&fi->i_gc_rwsem[WRITE]);
> > > +                     f2fs_up_write(&fi->i_gc_rwsem[READ]);
> > >                       goto out;
> > >               }
> > >
> > > @@ -2202,6 +2205,7 @@ static int f2fs_ioc_start_atomic_write(struct file
> > *filp, bool truncate)
> > >               ret = f2fs_do_truncate_blocks(fi->cow_inode, 0, true);
> > >               if (ret) {
> > >                       f2fs_up_write(&fi->i_gc_rwsem[WRITE]);
> > > +                     f2fs_up_write(&fi->i_gc_rwsem[READ]);
> > >                       goto out;
> > >               }
> > >       }
> >
> >

