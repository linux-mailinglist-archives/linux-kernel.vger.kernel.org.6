Return-Path: <linux-kernel+bounces-562257-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B838BA6203D
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 23:22:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 515E33BD407
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 22:22:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B0F9205E30;
	Fri, 14 Mar 2025 22:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JPZyqGBd"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B723E1FECCE
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 22:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741990903; cv=none; b=bGtkYWrRczgI7GG3lH4t74KJemhQcIYDwAsOWycuvpvcEiZAzVhF1bJXPwJLHu+IqrHl75cTydodUmmEtk9EB6sZsIrrf++R+C4GIfg1+Ossl3tMBOhgTI3mw7otGoy7ylfqAZ5iLRnAwAyJhKu8jA/Ehtowl9Fc1Le1SpmyxPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741990903; c=relaxed/simple;
	bh=yXi4VV69OQ5J9Ch0qeBs+FaNnX2iPv7Ofe2QeSUOJQc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b2LW1a0GXVM2hiH6ZRgAgr1uZsbO3toqwcvg6TU7JVkjHhqkDP1l8NiG4CuUnJU4paAMHNJadrtFMss+GdbzZXmhkPDfcxwXuCp0c5iimUPk6bl9SJaI9v4/qCfyrhyjkmvjridfmdrhkrgHm51Zfx30wmkGB5vUtb/kLIoEQjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JPZyqGBd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDED3C4CEE3;
	Fri, 14 Mar 2025 22:21:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741990903;
	bh=yXi4VV69OQ5J9Ch0qeBs+FaNnX2iPv7Ofe2QeSUOJQc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JPZyqGBdCCTlOuxqJOyOY/F0hpQQiyf/XDttYCvQLw/W9A2dB1OJBCexbEKyxnRhb
	 V9Q5RpWD76b2LnGmJJMcyBdR6o9wxyND4oBSnPADxB5XokeViyyViTk4LgUVfteA2O
	 tfi4zJdH4WZ1Bw/ZTnx7+ib2S8kxb8Roxgi7EMgKNg2mNQRhGQLUAdY6bXHyRbVyh0
	 C2IgJkvfxcERKbZNyr/Fwy5qVf+VUboQatcnUpHi97UDaI4dVoCQUytBLCYd/ZA6w8
	 rtvvHhEC/hICWn7/PsPG6AS2kj1XN9G0pfkLUer+mJKsBjFh/hWovJwyKAl5CH/mM/
	 YkP6WZZoYMKAQ==
Date: Fri, 14 Mar 2025 22:21:41 +0000
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: Yeongjin Gil <youngjin.gil@samsung.com>
Cc: chao@kernel.org, daehojeong@google.com,
	linux-f2fs-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org, sj1557.seo@samsung.com,
	s_min.jeong@samsung.com
Subject: Re: [PATCH] f2fs: fix to avoid atomicity corruption of atomic file
Message-ID: <Z9Sr9cjNGHkOM74n@google.com>
References: <CGME20250314120658epcas1p2d3ec037c294d4c907ce7fa2fe1c3aa27@epcas1p2.samsung.com>
 <20250314120651.443184-1-youngjin.gil@samsung.com>
 <Z9SkqFP93rWQrffm@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z9SkqFP93rWQrffm@google.com>

On 03/14, Jaegeuk Kim wrote:
> On 03/14, Yeongjin Gil wrote:
> > In the case of the following call stack for an atomic file,
> > FI_DIRTY_INODE is set, but FI_ATOMIC_DIRTIED is not subsequently set.
> > 
> > f2fs_file_write_iter
> >   f2fs_map_blocks
> >     f2fs_reserve_new_blocks
> >       inc_valid_block_count
> >         __mark_inode_dirty(dquot)
> >           f2fs_dirty_inode
> > 
> > If FI_ATOMIC_DIRTIED is not set, atomic file can encounter corruption
> > due to a mismatch between old file size and new data.
> > 
> > To resolve this issue, I changed to set FI_ATOMIC_DIRTIED when
> > FI_DIRTY_INODE is set. This ensures that FI_DIRTY_INODE, which was
> > previously cleared by the Writeback thread during the commit atomic, is
> > set and i_size is updated.
> > 
> > Fixes: fccaa81de87e ("f2fs: prevent atomic file from being dirtied before commit")
> > Reviewed-by: Sungjong Seo <sj1557.seo@samsung.com>
> > Reviewed-by: Sunmin Jeong <s_min.jeong@samsung.com>
> > Signed-off-by: Yeongjin Gil <youngjin.gil@samsung.com>
> > ---
> >  fs/f2fs/inode.c | 4 +---
> >  fs/f2fs/super.c | 4 ++++
> >  2 files changed, 5 insertions(+), 3 deletions(-)
> > 
> > diff --git a/fs/f2fs/inode.c b/fs/f2fs/inode.c
> > index aa2f41696a88..83f862578fc8 100644
> > --- a/fs/f2fs/inode.c
> > +++ b/fs/f2fs/inode.c
> > @@ -34,10 +34,8 @@ void f2fs_mark_inode_dirty_sync(struct inode *inode, bool sync)
> >  	if (f2fs_inode_dirtied(inode, sync))
> >  		return;
> >  
> > -	if (f2fs_is_atomic_file(inode)) {
> > -		set_inode_flag(inode, FI_ATOMIC_DIRTIED);
> > +	if (f2fs_is_atomic_file(inode))
> >  		return;
> > -	}
> >  
> >  	mark_inode_dirty_sync(inode);
> >  }
> > diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
> > index 397df271885c..c08d52c6467a 100644
> > --- a/fs/f2fs/super.c
> > +++ b/fs/f2fs/super.c
> > @@ -1534,6 +1534,10 @@ int f2fs_inode_dirtied(struct inode *inode, bool sync)
> >  		inc_page_count(sbi, F2FS_DIRTY_IMETA);
> >  	}
> >  	spin_unlock(&sbi->inode_lock[DIRTY_META]);
> > +
> > +	if (!ret && f2fs_is_atomic_file(inode))
> > +		set_inode_flag(inode, FI_ATOMIC_DIRTIED);
> > +
> 
> I'm not sure what's different here.
> 
> Before and after this patch, set_inode_flag(inode, FI_ATOMIC_DIRTIED) is called
> only if f2fs_inode_dirtied() returns zero and f2fs_is_atomic_file(inode).
> 
> Note, f2fs_mark_inode_dirty_sync() looks the single caller of f2fs_inode_dirtied.

Ok, I missed another caller, f2fs_dirty_inode, per discussion with Daeho.
Let me apply this.

> 
> 
> >  	return ret;
> >  }
> >  
> > -- 
> > 2.34.1

