Return-Path: <linux-kernel+bounces-263955-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B7C593DD18
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jul 2024 05:27:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0A6A4B233B0
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jul 2024 03:27:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C7694C9B;
	Sat, 27 Jul 2024 03:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GTjo2alE"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70E6E4A05
	for <linux-kernel@vger.kernel.org>; Sat, 27 Jul 2024 03:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722050846; cv=none; b=ed5EPU71VRDdokw6+tLrYKDm4irg4AqdqqWZexc3b6Sd4SEPSk0s2WyDjt6L6+5cPPvENfIca2Y2/E3oEjhxrw8cLpqHXB5MvYq/7xl3v/WCuuvQkEWwLPPMqoo/ctlTRbuP+fuAR2vo7iQRahIoiLAn8SaUxzUhzuJMq0d/dFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722050846; c=relaxed/simple;
	bh=S+kQb6Aea11p16gcRO1Yz5vgGsQTxv5epZ7ksHNbHfI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IN5gmhSFNmuAaZHAsrQtJPM1l1+jROPU5cWD0H+1mFU6tMLNqQ199Rq9bJSZAXuF3DqARfaqRHSX7x4pBwSi+KcOT7Tpkx3CEUhd9eC4KCUa4MPlpZJfsKWKL7N/Ct7LseAfBT9R1ukeeC/JVOS7iLp/WiGA08Pb0ZYRFC6nzog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GTjo2alE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5518C32781;
	Sat, 27 Jul 2024 03:27:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722050846;
	bh=S+kQb6Aea11p16gcRO1Yz5vgGsQTxv5epZ7ksHNbHfI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GTjo2alEa4C0Y1f7pPT7UaySLATpnYxt2jSDvGPDaK/Z9YB6EwU1UFyLB2Emx1d4M
	 O/8KllXJKogsI6JKtQHhfGG5CPAFn+GL+gt/cej4SYXESggZKqAp7izek6wbgwIgMJ
	 R7qAKXJkYvp8e5tZ1UVGM7pgD97UzjgX/kFQaEPURGIYWDFYL4o0cBYzdbQyIA3s0+
	 Bkb/ZiYCuF18RSsfE0iVFruaw4QOB3uIXy7InOP75Lx4b6NIwuuRTmiFl/N/QyvQfo
	 QGQgI1CkPtY/92dqgOnqI3yN0tvF9aDRQLCw2Hq6KKgfcWUlM3uGTFZFKFfb8fYLtG
	 mG2L6hYNLhh2g==
Date: Sat, 27 Jul 2024 03:27:24 +0000
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: Chao Yu <chao@kernel.org>
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] f2fs: don't traverse directory blocks after EOF
Message-ID: <ZqRpHOJyWU3Sn8Ma@google.com>
References: <20240712073415.227226-1-chao@kernel.org>
 <ZqKDnpzwX85RyGaa@google.com>
 <c2b7d0cd-ea10-4e25-829c-53967927bd03@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c2b7d0cd-ea10-4e25-829c-53967927bd03@kernel.org>

On 07/26, Chao Yu wrote:
> On 2024/7/26 0:55, Jaegeuk Kim wrote:
> > On 07/12, Chao Yu wrote:
> > > All directory blocks are within the scope of i_size, so let's limit
> > > the end_block to just check valid dirent blocks.
> > 
> > Do we really need this?
> 
> f2fs_readdir() and f2fs_empty_dir() uses dir_blocks() for upper boundary,
> this patch aligns find_in_level() w/ them.
> 
> Also, it can avoid grabbing never used page cache across EOF.
> 
> So, we can consider taking this patch?

I'm wondering whether the current code has a bug or not.

> 
> Thanks,
> 
> > 
> > > 
> > > Meanwhile, it uses dir_blocks() instead of variable for cleanup in
> > > __f2fs_find_entry().
> > > 
> > > Signed-off-by: Chao Yu <chao@kernel.org>
> > > ---
> > >   fs/f2fs/dir.c | 6 ++++--
> > >   1 file changed, 4 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/fs/f2fs/dir.c b/fs/f2fs/dir.c
> > > index 02c9355176d3..d4591c215f07 100644
> > > --- a/fs/f2fs/dir.c
> > > +++ b/fs/f2fs/dir.c
> > > @@ -305,18 +305,21 @@ static struct f2fs_dir_entry *find_in_level(struct inode *dir,
> > >   	int s = GET_DENTRY_SLOTS(fname->disk_name.len);
> > >   	unsigned int nbucket, nblock;
> > >   	unsigned int bidx, end_block;
> > > +	unsigned long last_block;
> > >   	struct page *dentry_page;
> > >   	struct f2fs_dir_entry *de = NULL;
> > >   	pgoff_t next_pgofs;
> > >   	bool room = false;
> > >   	int max_slots;
> > > +	last_block = dir_blocks(dir);
> > >   	nbucket = dir_buckets(level, F2FS_I(dir)->i_dir_level);
> > >   	nblock = bucket_blocks(level);
> > >   	bidx = dir_block_index(level, F2FS_I(dir)->i_dir_level,
> > >   			       le32_to_cpu(fname->hash) % nbucket);
> > >   	end_block = bidx + nblock;
> > > +	end_block = min_t(unsigned int, end_block, last_block);
> > >   	while (bidx < end_block) {
> > >   		/* no need to allocate new dentry pages to all the indices */
> > > @@ -361,7 +364,6 @@ struct f2fs_dir_entry *__f2fs_find_entry(struct inode *dir,
> > >   					 const struct f2fs_filename *fname,
> > >   					 struct page **res_page)
> > >   {
> > > -	unsigned long npages = dir_blocks(dir);
> > >   	struct f2fs_dir_entry *de = NULL;
> > >   	unsigned int max_depth;
> > >   	unsigned int level;
> > > @@ -373,7 +375,7 @@ struct f2fs_dir_entry *__f2fs_find_entry(struct inode *dir,
> > >   		goto out;
> > >   	}
> > > -	if (npages == 0)
> > > +	if (dir_blocks(dir) == 0)
> > >   		goto out;
> > >   	max_depth = F2FS_I(dir)->i_current_depth;
> > > -- 
> > > 2.40.1

