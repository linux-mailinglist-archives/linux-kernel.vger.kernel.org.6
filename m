Return-Path: <linux-kernel+bounces-269812-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 54980943715
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 22:27:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 10018282991
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 20:27:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14CE01607B5;
	Wed, 31 Jul 2024 20:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jg3uHcYB"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A0B214AD3F
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 20:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722457645; cv=none; b=rcdPw/7mp+ZzgUTqXS9ZZObk49fqsYzM/2PlmdpJI8A5onGQ3Lgy/PD5bfHa20UN/5Vo5vfMOq9PHWBh13RVhO1qD5bSENs8oLNsxYY99cA/KwlVHCkafQrScGlaVYqcLw12p1PH6Fp0zxDOXLZs8Z9bZAKfERDu+qVN36r36+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722457645; c=relaxed/simple;
	bh=NP8PSucstw3bxkC5xSko2GaChVKEzv5ikkGSO/MOdGU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p7jMSPivcZXsyi+MGs7GRBJ6tUxAncR3dy6O8zwRWPshT4+0rRraJ6f4jES2bElAHo0l75GHk8bH5JuycHnQRmsw7xkxXVX2XEuu7wqPFdYL1GXpDHQAs8f39Hf12fgkPe9KKJ74K29UgNWxPbyxSmFJ0CSppDfiC7Is2Wlts/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jg3uHcYB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C704DC116B1;
	Wed, 31 Jul 2024 20:27:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722457644;
	bh=NP8PSucstw3bxkC5xSko2GaChVKEzv5ikkGSO/MOdGU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jg3uHcYBHRvDhUP716M6IhX7iKtFr/DaGodoJffAsmPJ5oaMOU5TCNaUOV9ry2BF8
	 OjeBEBovz0TiZTIGJTAiBDgQ5+f46p5xJsz8V/WerpKY+3suaICGk15OJioZvTitLu
	 OrqfhNSr7U8NH4yA1YZs0N3Xmj2g2mWQtoQW/wtsjzEVWhtllAPhMRceXmm7YehbEz
	 hmXcfJjxwvsdstFQmGSXZ+VKY+554p0MSKFxV+as6lk0o6Lbz65faLqZF09FmXZxzy
	 fiq/NvW2CSSHHzCJICH5gGMadzOmTqQR9KheZu/kEcK8ZxrffSa0Mx6pk4ld5oj+Cx
	 waPZZIVxXkZZg==
Date: Wed, 31 Jul 2024 20:27:22 +0000
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: Chao Yu <chao@kernel.org>
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/4] f2fs: atomic: fix to truncate pagecache before
 on-disk metadata truncation
Message-ID: <ZqqeKuEIExOwMyuK@google.com>
References: <20240726012204.1306174-1-chao@kernel.org>
 <ZqfCwDcg7nvJPenf@google.com>
 <9e6c0e72-a175-4432-bada-564464698c3f@kernel.org>
 <ZqkUJAMJzW_4ANhY@google.com>
 <1b1c5fcf-0c71-4c5d-a429-3decc3bb8cb3@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1b1c5fcf-0c71-4c5d-a429-3decc3bb8cb3@kernel.org>

On 07/31, Chao Yu wrote:
> On 2024/7/31 0:26, Jaegeuk Kim wrote:
> > On 07/30, Chao Yu wrote:
> > > On 2024/7/30 0:26, Jaegeuk Kim wrote:
> > > > On 07/26, Chao Yu wrote:
> > > > > We should always truncate pagecache while truncating on-disk data.
> > > > > 
> > > > > Fixes: a46bebd502fe ("f2fs: synchronize atomic write aborts")
> > > > > Signed-off-by: Chao Yu <chao@kernel.org>
> > > > > ---
> > > > > v2:
> > > > > - fix to use cow_inode instead of inode
> > > > >    fs/f2fs/file.c | 1 +
> > > > >    1 file changed, 1 insertion(+)
> > > > > 
> > > > > diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
> > > > > index 6c62f76474d1..54886ddcb8ab 100644
> > > > > --- a/fs/f2fs/file.c
> > > > > +++ b/fs/f2fs/file.c
> > > > > @@ -2202,6 +2202,7 @@ static int f2fs_ioc_start_atomic_write(struct file *filp, bool truncate)
> > > > >    		F2FS_I(fi->cow_inode)->atomic_inode = inode;
> > > > >    	} else {
> > > > >    		/* Reuse the already created COW inode */
> > > > > +		truncate_setsize(fi->cow_inode, 0);
> > > > 
> > > > What if the below truncation failed?
> > > 
> > > What about just dropping page cache and do not set isize to 0?
> > 
> > Can we also check if there's any dirty page before truncating it?
> 
> Sure, so how about this?
> 
> 		/* Reuse the already created COW inode */
> 		if (get_dirty_pages(fi->cow_inode)) {

Was supposed to be a bug here?

> 			ret = filemap_write_and_wait(fi->cow_inode->i_mapping);
> 			if (ret) {
> 				f2fs_up_write(&fi->i_gc_rwsem[WRITE]);
> 				goto out;
> 			}
> 		}
> 
> 		truncate_inode_pages(fi->cow_inode->i_mapping, 0);

invalidate_mapping_pages() would be much safer?

> 
> 		ret = f2fs_do_truncate_blocks(fi->cow_inode, 0, true);
> 		if (ret) {
> 			f2fs_up_write(&fi->i_gc_rwsem[WRITE]);
> 			goto out;
> 		}
> 
> 		i_size_write(fi->cow_inode, 0);
> 
> Thanks,
> 
> > 
> > > 
> > > Thanks,
> > > 
> > > > 
> > > > >    		ret = f2fs_do_truncate_blocks(fi->cow_inode, 0, true);
> > > > >    		if (ret) {
> > > > >    			f2fs_up_write(&fi->i_gc_rwsem[WRITE]);
> > > > > -- 
> > > > > 2.40.1

