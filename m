Return-Path: <linux-kernel+bounces-547044-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E04F8A5024D
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 15:39:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F40E63B0200
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 14:37:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E740F24E008;
	Wed,  5 Mar 2025 14:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AFdsha0E"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 560DC15746E
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 14:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741185321; cv=none; b=GJn/DkLh6Z+k5N7yWt9BHU4zjkaYS6FjojlSThnxpcoRUQxVaVpxPSoxXC2a+g+rWItqCz9qB8E2TTiiM+fhzbY4uCLssNFp/jllT8DF5l4gMIoJNmjVRuu5eAAwlpwAdwb/8OC8PAjaUmEximxNNc2fLDHjJK+DRE9+hZ1RnXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741185321; c=relaxed/simple;
	bh=+/POTIBYu3YbxycBA5ufAE7WLG0Xfu9i9jwITjW3woE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BxAOtPyx3TSuKhOGWY5XE7EtzX7Bszt95P3gQ7xTGuXLeQEao/7BQqb3Rjjvsc7a+dsFcSdbyAPD7e4Ik5Q/BGFqqbX1vwfHLQuhZ6qsWEm5WN4RZ3+dpoQTffWETGfxGYOC3OhGuzQhgkW0j6LEV28ppeB6spJI5DddYNGuFpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AFdsha0E; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66F3BC4CED1;
	Wed,  5 Mar 2025 14:35:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741185320;
	bh=+/POTIBYu3YbxycBA5ufAE7WLG0Xfu9i9jwITjW3woE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AFdsha0E3TTkHFrh6locq319Bxuu3oaoMsKrRFGmfy/6GzfzT2Omi/6LAuuPhOoUR
	 7nuN17GDWc1onwbWAXeoSSCARVFlJ3gAVT0EGgbR65cFmn7iwEXTabW3XCK827pQFk
	 2OvbXCV4tP6leP0w9LGHFN6BdPnRfHot7I43kQY5uMZWzy8oCWjBBhHp3Qf4A8rwod
	 D/cTaTg/1LsHXDN/z2+dgTPJ+WGJwPLmW5u5PLmLFF3hdCPbi1GnVgjq4IwSVYQWWO
	 1BVExHEXc0+xi00u7b0G/CppFbabY5v2YoWv5E9u5kohoIoq0DTFw40gz3yOHROTR1
	 kTMeFzdi5PkPQ==
Date: Wed, 5 Mar 2025 14:35:18 +0000
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: Chao Yu <chao@kernel.org>
Cc: Daeho Jeong <daeho43@gmail.com>, linux-kernel@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com,
	Daeho Jeong <daehojeong@google.com>
Subject: Re: [f2fs-dev] [PATCH] f2fs: subtract current_reserved_blocks from
 total
Message-ID: <Z8hhJs_fUOBN7U8y@google.com>
References: <20250304192041.4048741-1-daeho43@gmail.com>
 <41160b37-16ad-4c12-aad2-1214d87d3df0@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41160b37-16ad-4c12-aad2-1214d87d3df0@kernel.org>

On 03/05, Chao Yu wrote:
> On 3/5/25 03:20, Daeho Jeong wrote:
> > From: Daeho Jeong <daehojeong@google.com>
> > 
> > current_reserved_blocks is not allowed to utilize. For some zoned
> > storage devices, vendors will provide extra space which was used for
> > device level GC than specs and we will use this space for filesystem
> > level GC. This extra space should not be shown to users, otherwise,
> > users will see not standardized size number like 530GB, not 512GB.
> 
> Hi Daeho,
> 
> However, if there are other users e.g. oem or vendor want to use
> reserved_blocks and current_reserved_blocks sysfs interface to
> reserve space, then, total size will be less than 512GB?
> 
> What do you think of adding a new variable to indicate reserved
> space for zoned storage case only?

Or, adding a sysfs entry like "carve_out" to determine this?

> 
> Thanks,
> 
> > 
> > Signed-off-by: Daeho Jeong <daehojeong@google.com>
> > ---
> >  fs/f2fs/super.c | 3 +--
> >  1 file changed, 1 insertion(+), 2 deletions(-)
> > 
> > diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
> > index 19b67828ae32..c346dcc2518a 100644
> > --- a/fs/f2fs/super.c
> > +++ b/fs/f2fs/super.c
> > @@ -1833,10 +1833,9 @@ static int f2fs_statfs(struct dentry *dentry, struct kstatfs *buf)
> >  	buf->f_type = F2FS_SUPER_MAGIC;
> >  	buf->f_bsize = sbi->blocksize;
> >  
> > -	buf->f_blocks = total_count - start_count;
> > -
> >  	spin_lock(&sbi->stat_lock);
> >  
> > +	buf->f_blocks = total_count - start_count - sbi->current_reserved_blocks;
> >  	user_block_count = sbi->user_block_count;
> >  	total_valid_node_count = valid_node_count(sbi);
> >  	avail_node_count = sbi->total_node_count - F2FS_RESERVED_NODE_NUM;
> 

