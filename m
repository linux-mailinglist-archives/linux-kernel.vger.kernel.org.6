Return-Path: <linux-kernel+bounces-392936-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C8CC9B99D7
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 22:06:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E4CE41F226E2
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 21:06:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1137F1E2826;
	Fri,  1 Nov 2024 21:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EOLbFIMG"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F00B1D0E15
	for <linux-kernel@vger.kernel.org>; Fri,  1 Nov 2024 21:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730495187; cv=none; b=rim3Wa/0c7dIcca4fjn1a9BDf476usbmvXSDMqRLHIo/blu1c+B6dHnDlUu59UBSFmO2RZP6ytqnKvqs2kU56t10hotbvIjrCgLQDh7/Xit1mrSXbNsLie/YnvdFLKXsJIBLYVQ12Dtz7F6PiEd5t6r2MHk1gLQonX+k19AMfvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730495187; c=relaxed/simple;
	bh=6r0kSGz22uyB0SBpH5zjJIdf6qncKwiekp9O4rAUAUA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gK/O4X7V1KqA6m6zQCFjYfx55dhZzcbrnG7SbDqs4CkikLXX/qNrEcya5Thn3jh1vUCE+x/HcOAlCQSjwDX7cgF93MPHyYDHtTLHK7N6B11o+WorOcsjm3ZOhfz0Dxz0X9WvHTw0T/80Psl0G698lzdUdw4zamPVHQokBPjL6qM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EOLbFIMG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09CDEC4CECD;
	Fri,  1 Nov 2024 21:06:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730495187;
	bh=6r0kSGz22uyB0SBpH5zjJIdf6qncKwiekp9O4rAUAUA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EOLbFIMGNUKs72gZPgmR4wOxbn3G0A+8h2r/vLQzpb1TtSkfi9g9mFvv2Zc7SDk44
	 q/NbICTH+a5uSel23gTHJA6FZ/dAcNHgbjS/WGXS2k/kEAXLBORtIB4KjMsxOtEkD/
	 04QbSjBcUJSfbWgQyOo1GQRJltodhEzf27AJCEYz1soebWko8dktEV6xk07c8tk4ND
	 W7RmEqm2gDOieEmtVosjPbO85LX/LFgZpZBdZtpJLNcPoB8M1T0wQ3KPegAFFjE3iX
	 CtqPkML/7kZr5oyAdVIEUAx9Pj33EzGLV9CWtGRA3zLR2SWfOHMJ4gIbiIW7Gx6ocJ
	 RRoXjubbrlURA==
Date: Fri, 1 Nov 2024 21:06:25 +0000
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: Chao Yu <chao@kernel.org>
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
	kernel test robot <oliver.sang@intel.com>,
	Cyril Hrubis <chrubis@suse.cz>
Subject: Re: [PATCH] f2fs: fix to map blocks correctly for direct read
Message-ID: <ZyVC0R8JYwMZXM9u@google.com>
References: <20241031102200.440407-1-chao@kernel.org>
 <ZyQtcbtzpixFd6Zs@google.com>
 <fede8a9b-8532-4d63-a4db-b52ed088d6f8@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fede8a9b-8532-4d63-a4db-b52ed088d6f8@kernel.org>

On 11/01, Chao Yu wrote:
> On 2024/11/1 9:22, Jaegeuk Kim wrote:
> > On 10/31, Chao Yu wrote:
> > > f2fs_map_blocks() supports to map continuous holes or preallocated
> > > address, we should avoid setting F2FS_MAP_MAPPED for these cases
> > > only, otherwise, it may fail f2fs_iomap_begin(), and make direct
> > > write fallbacking to use buffered IO and flush, result in performance
> > > regression.
> > 
> > Is this fixing direct write or read?
> 
> Direct write.

I was confising the patch subject is saying direct read.

> 
> > 
> > > 
> > > Fixes: 9f0f6bf42714 ("f2fs: support to map continuous holes or preallocated address")
> > > Reported-by: kernel test robot <oliver.sang@intel.com>
> > > Closes: https://lore.kernel.org/oe-lkp/202409122103.e45aa13b-oliver.sang@intel.com
> > > Cc: Cyril Hrubis <chrubis@suse.cz>
> > > Signed-off-by: Chao Yu <chao@kernel.org>
> > > ---
> > >   fs/f2fs/data.c | 7 ++++++-
> > >   1 file changed, 6 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
> > > index 306b86b0595d..38b85160c6bd 100644
> > > --- a/fs/f2fs/data.c
> > > +++ b/fs/f2fs/data.c
> > > @@ -1676,7 +1676,12 @@ int f2fs_map_blocks(struct inode *inode, struct f2fs_map_blocks *map, int flag)
> > >   		/* reserved delalloc block should be mapped for fiemap. */
> > >   		if (blkaddr == NEW_ADDR)
> > >   			map->m_flags |= F2FS_MAP_DELALLOC;
> > > -		if (flag != F2FS_GET_BLOCK_DIO || !is_hole)
> > > +		/*
> > > +		 * f2fs_map_blocks() supports to map continuous holes or
> > > +		 * preallocated address, don't set F2FS_MAP_MAPPED for these
> > > +		 * cases only.
> > > +		 */
> > > +		if (flag != F2FS_GET_BLOCK_DIO || map->m_may_create || !is_hole)
> > 
> > So, this is adding map->m_may_create, which is for writes?
> 
> map->m_may_create is added for write path, w/o this condition, f2fs_map_blocks()
> may missed to tag F2FS_MAP_MAPPED, result in that f2fs_iomap_begin() will return
> -ENOTBLK.

Is that something like this?

/* DIO READ and hole case, should not map the blocks. */
if (!(flag == F2FS_GET_BLOCK_DIO && is_hole && !map->m_may_create))

> 
> Am I missing someting?
> 
> Thanks,
> 
> > 
> > >   			map->m_flags |= F2FS_MAP_MAPPED;
> > >   		map->m_pblk = blkaddr;
> > > -- 
> > > 2.40.1

