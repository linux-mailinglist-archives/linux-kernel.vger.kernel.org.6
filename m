Return-Path: <linux-kernel+bounces-266086-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E01093FAAC
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 18:23:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EF74FB22D2E
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 16:23:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB954187862;
	Mon, 29 Jul 2024 16:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RvEaVZVK"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28D1E187853
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 16:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722270064; cv=none; b=bWr4+JVg/yC7jyX2wRy0B3LMsu5trhGKKcnqWnhRTwvzGsD6MEZFfCI/5oW2HdrdeyBxl3wxpjFnbvJKLhwwm4HA98Xy6BJgwLtTA6oPS03uZMNp/v4q6ejmUDLp4obhGyFV+Oli2308zFsMfmV5Aa0n2YULrYjVFQPz3R8Sisg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722270064; c=relaxed/simple;
	bh=L6jcEa8CfEldUuj1WusbJIcpD6rrcXH0GVGphBmFRwg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lZyhxMZ6KU55qbogidPJgmUW71/xPFFhMAEI1v9Uu1T96V+aLK89JScy2y4hZNgn9cXxnqTYiIkRBFuRRPhO7ToW0kmzY8trrGPXEnbfORLNWCSeVKcI4bgkFkzO0jvAIDcQAW0uH2kBQAS0W6HK3MPGVvSTd8mMDE5l4wfAlYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RvEaVZVK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68BEBC4AF19;
	Mon, 29 Jul 2024 16:21:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722270063;
	bh=L6jcEa8CfEldUuj1WusbJIcpD6rrcXH0GVGphBmFRwg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RvEaVZVKOp986/b3JSq7HO+zqtJTxfVCLOEH5WROoYKTVhKIsEXEvTEaDoSlwVtrf
	 g4sJ9q1hNLetbliwaOap3O9yPw2vmOY1Cz0jcl7W2N9EadlfEcEqS3hCOkXEhhMAkU
	 LGo+H1Q/+rD3gocQ4okL7fERC1XVxxe7hLfKzX1PXnqBpTbsZtzv/LLmB8kPE4+8A5
	 PRgvhDJjlk129VH4MXAfIPBVPkvuOHwQA1CO5u9rNECztOvKzH8U8ux/oyG+blRQEa
	 qgt7nPx1cOm01PoA/8fmoEtz1FeqVMW2up1ovkd2Sw0HNe7foQYdg52U+8eQMP1lCV
	 juwf9kz7BwZ0Q==
Date: Mon, 29 Jul 2024 16:21:01 +0000
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: Chao Yu <chao@kernel.org>
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] f2fs: don't traverse directory blocks after EOF
Message-ID: <ZqfBbQGxwpAvCO2m@google.com>
References: <20240712073415.227226-1-chao@kernel.org>
 <ZqKDnpzwX85RyGaa@google.com>
 <c2b7d0cd-ea10-4e25-829c-53967927bd03@kernel.org>
 <ZqRpHOJyWU3Sn8Ma@google.com>
 <74dbb5f1-1565-4971-ae5c-c176d62cfa8f@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <74dbb5f1-1565-4971-ae5c-c176d62cfa8f@kernel.org>

On 07/29, Chao Yu wrote:
> On 2024/7/27 11:27, Jaegeuk Kim wrote:
> > On 07/26, Chao Yu wrote:
> > > On 2024/7/26 0:55, Jaegeuk Kim wrote:
> > > > On 07/12, Chao Yu wrote:
> > > > > All directory blocks are within the scope of i_size, so let's limit
> > > > > the end_block to just check valid dirent blocks.
> > > > 
> > > > Do we really need this?
> > > 
> > > f2fs_readdir() and f2fs_empty_dir() uses dir_blocks() for upper boundary,
> > > this patch aligns find_in_level() w/ them.
> > > 
> > > Also, it can avoid grabbing never used page cache across EOF.
> > > 
> > > So, we can consider taking this patch?
> > 
> > I'm wondering whether the current code has a bug or not.
> 
> I think it's not a bug, but, in corner case it may waste memory and
> cause a bit performance reduction.

Well, I don't think it's really a problem.

> 
> Thanks,
> 
> > 
> > > 
> > > Thanks,
> > > 
> > > > 
> > > > > 
> > > > > Meanwhile, it uses dir_blocks() instead of variable for cleanup in
> > > > > __f2fs_find_entry().
> > > > > 
> > > > > Signed-off-by: Chao Yu <chao@kernel.org>
> > > > > ---
> > > > >    fs/f2fs/dir.c | 6 ++++--
> > > > >    1 file changed, 4 insertions(+), 2 deletions(-)
> > > > > 
> > > > > diff --git a/fs/f2fs/dir.c b/fs/f2fs/dir.c
> > > > > index 02c9355176d3..d4591c215f07 100644
> > > > > --- a/fs/f2fs/dir.c
> > > > > +++ b/fs/f2fs/dir.c
> > > > > @@ -305,18 +305,21 @@ static struct f2fs_dir_entry *find_in_level(struct inode *dir,
> > > > >    	int s = GET_DENTRY_SLOTS(fname->disk_name.len);
> > > > >    	unsigned int nbucket, nblock;
> > > > >    	unsigned int bidx, end_block;
> > > > > +	unsigned long last_block;
> > > > >    	struct page *dentry_page;
> > > > >    	struct f2fs_dir_entry *de = NULL;
> > > > >    	pgoff_t next_pgofs;
> > > > >    	bool room = false;
> > > > >    	int max_slots;
> > > > > +	last_block = dir_blocks(dir);
> > > > >    	nbucket = dir_buckets(level, F2FS_I(dir)->i_dir_level);
> > > > >    	nblock = bucket_blocks(level);
> > > > >    	bidx = dir_block_index(level, F2FS_I(dir)->i_dir_level,
> > > > >    			       le32_to_cpu(fname->hash) % nbucket);
> > > > >    	end_block = bidx + nblock;
> > > > > +	end_block = min_t(unsigned int, end_block, last_block);
> > > > >    	while (bidx < end_block) {
> > > > >    		/* no need to allocate new dentry pages to all the indices */
> > > > > @@ -361,7 +364,6 @@ struct f2fs_dir_entry *__f2fs_find_entry(struct inode *dir,
> > > > >    					 const struct f2fs_filename *fname,
> > > > >    					 struct page **res_page)
> > > > >    {
> > > > > -	unsigned long npages = dir_blocks(dir);
> > > > >    	struct f2fs_dir_entry *de = NULL;
> > > > >    	unsigned int max_depth;
> > > > >    	unsigned int level;
> > > > > @@ -373,7 +375,7 @@ struct f2fs_dir_entry *__f2fs_find_entry(struct inode *dir,
> > > > >    		goto out;
> > > > >    	}
> > > > > -	if (npages == 0)
> > > > > +	if (dir_blocks(dir) == 0)
> > > > >    		goto out;
> > > > >    	max_depth = F2FS_I(dir)->i_current_depth;
> > > > > -- 
> > > > > 2.40.1

