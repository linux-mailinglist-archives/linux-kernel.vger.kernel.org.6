Return-Path: <linux-kernel+bounces-174654-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FF938C1244
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 17:50:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A3B12B21E97
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 15:50:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53C373BBE3;
	Thu,  9 May 2024 15:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LsWqlUPi"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C37A16F0C3
	for <linux-kernel@vger.kernel.org>; Thu,  9 May 2024 15:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715269810; cv=none; b=gwnmOFqUCOt4Ei6l/zihyNJk1CTznuyNb3WPY9jbfVWMP/YwaKXOpR13+XA5DYdce7Pk34dzTS2fgW/t8ImbbFRgA0T7/Dt5i4JEfdhWbKEoxNdXuh3DUwDjaE4ALFuMIhdjlWwj5jh3QukfdyhcnByAseZpWpQBwUBjhM8hvTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715269810; c=relaxed/simple;
	bh=PVYxLVi7qmywbA3AVz6ygRy87Rw7WwcdjDJdNALqThU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oyTQ4SIJ8aVoZY38RFbu//vAZZ+fA+540UTVWxQUBtMH/G++YS4Dqs0flkdU2HW4kKkW2DEpE1sFgorp3Jvs/LxcmDC61ubA/H7lTS3ThfE1aCFIRP8OCf+fu3ByBA5n0+LmqgQ8wnCqIOhU5fluEZLpKLJpzTo4e9YKV0yZkPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LsWqlUPi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49948C116B1;
	Thu,  9 May 2024 15:50:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715269810;
	bh=PVYxLVi7qmywbA3AVz6ygRy87Rw7WwcdjDJdNALqThU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LsWqlUPisLmYwN5tQdh1E0gO+IF2GCueWzv/buL6tw9bnn8FsE72xoBX/eQXqBH1s
	 zQ+0cM7qRPDj20bIlatAyK9pebFMCpVhjCCmbi8R9zCYivIw27cKj/Czh437tqYUIM
	 4W63s66NxRCvzJnVSvI3ogR2uNmF5rJ6GOxpSzwd15/np6b1L/NmIW7AqO39cciat3
	 hOcDvePD6rq/sQ6Jiec1y/hh2won+7aSn1ltqAG//jfYcO5EbjOeWyQF73qhn0rk6x
	 5oz98MkpLKG0DqznXsPzMHu78krvF+aCBMebSP+p0AylW5cPHv7mY9DZrmtiE2ENpt
	 037Liu2sNSEag==
Date: Thu, 9 May 2024 15:50:08 +0000
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: Chao Yu <chao@kernel.org>
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] f2fs: fix to add missing iput() in gc_data_segment()
Message-ID: <ZjzwsB2y0AVNWY7X@google.com>
References: <20240506103313.773503-1-chao@kernel.org>
 <20240506103313.773503-2-chao@kernel.org>
 <Zjwc5QGJfm6XXzOX@google.com>
 <32e097e6-67f1-4f06-bad0-0c7b3afb46f0@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <32e097e6-67f1-4f06-bad0-0c7b3afb46f0@kernel.org>

On 05/09, Chao Yu wrote:
> On 2024/5/9 8:46, Jaegeuk Kim wrote:
> > On 05/06, Chao Yu wrote:
> > > During gc_data_segment(), if inode state is abnormal, it missed to call
> > > iput(), fix it.
> > > 
> > > Fixes: 132e3209789c ("f2fs: remove false alarm on iget failure during GC")
> > > Fixes: 9056d6489f5a ("f2fs: fix to do sanity check on inode type during garbage collection")
> > > Signed-off-by: Chao Yu <chao@kernel.org>
> > > ---
> > >   fs/f2fs/gc.c | 9 +++++++--
> > >   1 file changed, 7 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
> > > index 8852814dab7f..e86c7f01539a 100644
> > > --- a/fs/f2fs/gc.c
> > > +++ b/fs/f2fs/gc.c
> > > @@ -1554,10 +1554,15 @@ static int gc_data_segment(struct f2fs_sb_info *sbi, struct f2fs_summary *sum,
> > >   			int err;
> > >   			inode = f2fs_iget(sb, dni.ino);
> > > -			if (IS_ERR(inode) || is_bad_inode(inode) ||
> > > -					special_file(inode->i_mode))
> > > +			if (IS_ERR(inode))
> > >   				continue;
> > > +			if (is_bad_inode(inode) ||
> > > +					special_file(inode->i_mode)) {
> > > +				iput(inode);
> > 
> > iget_failed() called iput()?
> 
> It looks the bad inode was referenced in this context, it needs to be iput()ed
> here.
> 
> The bad inode was made in other thread, please check description in commit
> b73e52824c89 ("f2fs: reposition unlock_new_inode to prevent accessing invalid
> inode").

Ah, it's non-error case. Right.

> 
> Thanks,
> 
> > 
> > 
> > > +				continue;
> > > +			}
> > > +
> > >   			err = f2fs_gc_pinned_control(inode, gc_type, segno);
> > >   			if (err == -EAGAIN) {
> > >   				iput(inode);
> > > -- 
> > > 2.40.1

