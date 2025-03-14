Return-Path: <linux-kernel+bounces-562229-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 61D5BA61F68
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 22:53:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 378448865AC
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 21:51:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B9DE1DE4C1;
	Fri, 14 Mar 2025 21:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qANbF8Cu"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E79D51C8631
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 21:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741989035; cv=none; b=Y7J9c/QkHaggNUcXdTPzqzifhExcN36Nbf3yhyTVceJJ3gOtMhOWsUwqKFisksUlTPT+N/0+hHJTmCsVEEhic/+c/S9dqif30GGI53bJdZJrNd25JPR2Zhh3PRlwWnWmDz0XfveMhu/ieNi6+Ul6g7xCoR3nBGEsGKs4Ztb4Wno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741989035; c=relaxed/simple;
	bh=tmqCpcVXwWVsDWj4IBtSm1R/td472GxXq775uoQ0xnU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eaxdozm70AMfChr04NaZXfGBqPweNz57DbvXqn1yy/KAjfSGxmujEJ+0rS9K+KT7TjhQ9FQf9YnZiF3jQisE4iBrSFkACl3HS3lVzt/5ZL5q43ipMPyQAIWxgpoUGkn715TIFX3X4xV4jQctUg7HP7g0Ur5HexpyyHUBpsRCRws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qANbF8Cu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BFC5C4CEE3;
	Fri, 14 Mar 2025 21:50:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741989034;
	bh=tmqCpcVXwWVsDWj4IBtSm1R/td472GxXq775uoQ0xnU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qANbF8Cu1Xcn7oCvxwPNdeOT/ZHfCxCwgmoR8Isv7UjmWWWmWY/ErbzgOYy5fOemv
	 qRr2yztxgzDYffVUcS4wsDOqLNyftZYFd6tMwmWjT1H3ADraeeEPrP7KFKePeEhP/E
	 D4wsPS2ZVPpShC37DpcZPdzndtWzM32LVQ28lJNLxfDUSe8fXvPf+V05k75kDy841D
	 UbjPn/xVLt81ObHsnjxmfbKMGwp5LCakvz1bt965CWDAqHAQjOVNKlvaRmBUXLmkC+
	 PPlhxF8p+9qZWKMJsin/C2ZOoUkD12sUmn3FwXN42iDTKvs3kd4AN2seNdMOuEQ2Wg
	 EaYRGAttV5oiQ==
Date: Fri, 14 Mar 2025 21:50:32 +0000
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: Yeongjin Gil <youngjin.gil@samsung.com>
Cc: chao@kernel.org, daehojeong@google.com,
	linux-f2fs-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org, sj1557.seo@samsung.com,
	s_min.jeong@samsung.com
Subject: Re: [PATCH] f2fs: fix to avoid atomicity corruption of atomic file
Message-ID: <Z9SkqFP93rWQrffm@google.com>
References: <CGME20250314120658epcas1p2d3ec037c294d4c907ce7fa2fe1c3aa27@epcas1p2.samsung.com>
 <20250314120651.443184-1-youngjin.gil@samsung.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250314120651.443184-1-youngjin.gil@samsung.com>

On 03/14, Yeongjin Gil wrote:
> In the case of the following call stack for an atomic file,
> FI_DIRTY_INODE is set, but FI_ATOMIC_DIRTIED is not subsequently set.
> 
> f2fs_file_write_iter
>   f2fs_map_blocks
>     f2fs_reserve_new_blocks
>       inc_valid_block_count
>         __mark_inode_dirty(dquot)
>           f2fs_dirty_inode
> 
> If FI_ATOMIC_DIRTIED is not set, atomic file can encounter corruption
> due to a mismatch between old file size and new data.
> 
> To resolve this issue, I changed to set FI_ATOMIC_DIRTIED when
> FI_DIRTY_INODE is set. This ensures that FI_DIRTY_INODE, which was
> previously cleared by the Writeback thread during the commit atomic, is
> set and i_size is updated.
> 
> Fixes: fccaa81de87e ("f2fs: prevent atomic file from being dirtied before commit")
> Reviewed-by: Sungjong Seo <sj1557.seo@samsung.com>
> Reviewed-by: Sunmin Jeong <s_min.jeong@samsung.com>
> Signed-off-by: Yeongjin Gil <youngjin.gil@samsung.com>
> ---
>  fs/f2fs/inode.c | 4 +---
>  fs/f2fs/super.c | 4 ++++
>  2 files changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/f2fs/inode.c b/fs/f2fs/inode.c
> index aa2f41696a88..83f862578fc8 100644
> --- a/fs/f2fs/inode.c
> +++ b/fs/f2fs/inode.c
> @@ -34,10 +34,8 @@ void f2fs_mark_inode_dirty_sync(struct inode *inode, bool sync)
>  	if (f2fs_inode_dirtied(inode, sync))
>  		return;
>  
> -	if (f2fs_is_atomic_file(inode)) {
> -		set_inode_flag(inode, FI_ATOMIC_DIRTIED);
> +	if (f2fs_is_atomic_file(inode))
>  		return;
> -	}
>  
>  	mark_inode_dirty_sync(inode);
>  }
> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
> index 397df271885c..c08d52c6467a 100644
> --- a/fs/f2fs/super.c
> +++ b/fs/f2fs/super.c
> @@ -1534,6 +1534,10 @@ int f2fs_inode_dirtied(struct inode *inode, bool sync)
>  		inc_page_count(sbi, F2FS_DIRTY_IMETA);
>  	}
>  	spin_unlock(&sbi->inode_lock[DIRTY_META]);
> +
> +	if (!ret && f2fs_is_atomic_file(inode))
> +		set_inode_flag(inode, FI_ATOMIC_DIRTIED);
> +

I'm not sure what's different here.

Before and after this patch, set_inode_flag(inode, FI_ATOMIC_DIRTIED) is called
only if f2fs_inode_dirtied() returns zero and f2fs_is_atomic_file(inode).

Note, f2fs_mark_inode_dirty_sync() looks the single caller of f2fs_inode_dirtied.


>  	return ret;
>  }
>  
> -- 
> 2.34.1

