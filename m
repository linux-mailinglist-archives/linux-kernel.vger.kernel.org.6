Return-Path: <linux-kernel+bounces-547202-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FB42A5041C
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 17:03:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A8BED7A4F3C
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 16:02:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F52924CEF1;
	Wed,  5 Mar 2025 16:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E2QXPfgl"
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B68A13B2A9
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 16:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741190606; cv=none; b=rBAnz9qKZbABL6VVDZ3k0atTwtszJixaIEzmCKbpcyuLn3ZhFYmHlzc9HC97tWIaYaFkAtZucJ4ViB8XwM3Nz6aekYd8IJquE14zaQR8366dyUqIY1M19Q/i7TpSnU6CPcVzeH6FkL2y2eJnQ4b6w6ar04JD25ezcDfKrVwRCek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741190606; c=relaxed/simple;
	bh=X2zUNMDAnn4qJV/vxS5Y6yDKF725P+wKjbRiMUQGOy0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pupQKttjw6Oyv7qv4nGHT/6f+t3pXMjjym899exxls1fsjTjZdeuiJsZaF2+ui5o3GCgSvKggNwZva7TDT9YvVXbuoQ4pzaiPjl1f6F/pWhcLB2PFE3r/QIXi8v+6/kgYp1g7Sqstk1YvW1KoHg2cjFWCioMB7nKDWjaR9fn2nY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E2QXPfgl; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-7c081915cf3so902483585a.1
        for <linux-kernel@vger.kernel.org>; Wed, 05 Mar 2025 08:03:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741190604; x=1741795404; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M2CTF6Pisj27mJGFCpElro7v5jTGDiYni/G+Uk8j/R8=;
        b=E2QXPfglYZFSn9utQAj/2FIXdVA1DTVuN+oN0bERIFFg/JsOikAEruCeG2UGXniM4u
         Mf9CCaNyxi2ZS140dhgMDJpdKLxKz/4sri8zxCWMx11FISidTtnsgjdpJmj7v+49ydwy
         E/MyKzsksPB0Xdi/ZMG56O525z5MsVeN/KH6eq5NwgVkCmb6Lw1fxy+v0FHtOqjSOf2F
         4T+02MQ2sFNvwlWVf5ibinr8EYYV4PdlkgG+luEOk+ymHW4vbZIrftVHFiTkUxClil5m
         TXV1A/wZrCP+lYIT83UQ0vWeOIp1fyF65z+oDZDqaAgq0altRS01lUC8kTgV8OHl2Cjy
         usdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741190604; x=1741795404;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M2CTF6Pisj27mJGFCpElro7v5jTGDiYni/G+Uk8j/R8=;
        b=rUiZXDRSeEwj303h4cOJkOHCTMrfXh5XhRdhqKgYn5Wk2BY3bTkH2/JCVa6T+WJKvI
         IJge6wntosD8cxOssYha/rzkc+4X/IWUVyj/EBDz4CLeyhhA0CLolAAMt1Qdjt0xEj6p
         RJfya/nJZwa1a0dOlAUl0QqaD9EZhWPjfJ5ABPlr7rAoJpl44933q7OPch/mQIyw617q
         mGI9VSvVvK+5JsYW1N5mUlJZozKDowtBcZegYIM1Y0l6U/NjGaB3hc43GhNMdc6IvBc0
         PTSEjARCdR5OCMreqT1KHzSUOME6InkF+p5jOAmPJek7DutfkBq6ePg9LyLCl+4M/Hx1
         HW5A==
X-Forwarded-Encrypted: i=1; AJvYcCXl0Uzu9m0Q7vvebTxuRSrfR50ma/iBWrkZX1Hj3295sIPjIX+4Y9GWtAL8DBCIXFE77i+zjlDPuck2st0=@vger.kernel.org
X-Gm-Message-State: AOJu0YynzZWMkAHqgowixml6IIwN5kZ/gRMSZrznKpevKfbJGe5zhL9r
	zVC/EPcPhMpWxyno3alWae6QbH4ormfq76AL682iDAJXEUfqPArVgHwWZfqGLHt/uo1doL8dkpQ
	0IyNCsLUVIO+HBLKMAv8hau6r3f4=
X-Gm-Gg: ASbGncudUl7U3Cog9hoKy5SBSIbj560Qzg33DFzOvdxAtZctldk7A2/77Strx38HQV4
	VWrdkPhFM++Tn+23fe0UpYT3JmZLvMHvnEkgcErrNopi0WZHJWTLeu6CtuFey0K9byqYM1GH91L
	eU6D1VbyFd8C/y60Nqp5UbUlVM/yYYdhthiddsqt9FuDTBVsQd7khc8ESsAQ==
X-Google-Smtp-Source: AGHT+IFTdOugn9AkO/Ghfxd0ldeYCP3H0UlwQEVKhfeVgph2bg+IiSdqod7VKnJkN6OJ+qDAOSF2mxvfTd01xPm+47I=
X-Received: by 2002:a05:620a:2815:b0:7c3:c676:ffb8 with SMTP id
 af79cd13be357-7c3d8e20f42mr535409185a.10.1741190603957; Wed, 05 Mar 2025
 08:03:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250304192041.4048741-1-daeho43@gmail.com> <41160b37-16ad-4c12-aad2-1214d87d3df0@kernel.org>
 <Z8hhJs_fUOBN7U8y@google.com>
In-Reply-To: <Z8hhJs_fUOBN7U8y@google.com>
From: Daeho Jeong <daeho43@gmail.com>
Date: Wed, 5 Mar 2025 08:03:13 -0800
X-Gm-Features: AQ5f1JraQ2nQ-YwlAct77tFhnNZVX6HLHip0gChQCAbQqGUxDofMo3LpTumMS78
Message-ID: <CACOAw_woCqGXKeLqG_QJExc_usnZy6FkL5O+qrvdzoqF2yBnfw@mail.gmail.com>
Subject: Re: [f2fs-dev] [PATCH] f2fs: subtract current_reserved_blocks from total
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: Chao Yu <chao@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com, 
	Daeho Jeong <daehojeong@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 5, 2025 at 6:35=E2=80=AFAM Jaegeuk Kim <jaegeuk@kernel.org> wro=
te:
>
> On 03/05, Chao Yu wrote:
> > On 3/5/25 03:20, Daeho Jeong wrote:
> > > From: Daeho Jeong <daehojeong@google.com>
> > >
> > > current_reserved_blocks is not allowed to utilize. For some zoned
> > > storage devices, vendors will provide extra space which was used for
> > > device level GC than specs and we will use this space for filesystem
> > > level GC. This extra space should not be shown to users, otherwise,
> > > users will see not standardized size number like 530GB, not 512GB.
> >
> > Hi Daeho,
> >
> > However, if there are other users e.g. oem or vendor want to use
> > reserved_blocks and current_reserved_blocks sysfs interface to
> > reserve space, then, total size will be less than 512GB?
> >
> > What do you think of adding a new variable to indicate reserved
> > space for zoned storage case only?
>
> Or, adding a sysfs entry like "carve_out" to determine this?

Good points. Thanks, guys.

>
> >
> > Thanks,
> >
> > >
> > > Signed-off-by: Daeho Jeong <daehojeong@google.com>
> > > ---
> > >  fs/f2fs/super.c | 3 +--
> > >  1 file changed, 1 insertion(+), 2 deletions(-)
> > >
> > > diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
> > > index 19b67828ae32..c346dcc2518a 100644
> > > --- a/fs/f2fs/super.c
> > > +++ b/fs/f2fs/super.c
> > > @@ -1833,10 +1833,9 @@ static int f2fs_statfs(struct dentry *dentry, =
struct kstatfs *buf)
> > >     buf->f_type =3D F2FS_SUPER_MAGIC;
> > >     buf->f_bsize =3D sbi->blocksize;
> > >
> > > -   buf->f_blocks =3D total_count - start_count;
> > > -
> > >     spin_lock(&sbi->stat_lock);
> > >
> > > +   buf->f_blocks =3D total_count - start_count - sbi->current_reserv=
ed_blocks;
> > >     user_block_count =3D sbi->user_block_count;
> > >     total_valid_node_count =3D valid_node_count(sbi);
> > >     avail_node_count =3D sbi->total_node_count - F2FS_RESERVED_NODE_N=
UM;
> >

