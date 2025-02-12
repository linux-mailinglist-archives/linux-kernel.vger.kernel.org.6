Return-Path: <linux-kernel+bounces-511526-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D5481A32C44
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 17:47:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3080C3A7D45
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 16:47:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF473253332;
	Wed, 12 Feb 2025 16:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ct/YiBkV"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 398D424C68E
	for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 16:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739378853; cv=none; b=N26PjK2jfp6OZ8wqjkYIIn0vD/zw28LpfyJYuijatLuWq1O4PDQQLRCPuN7UllcMCv0VzhmOCOXd/6R3Nj+12XTA8IbKT4k4pQZJeFZnLxl+fO4q8Rzn6C027boWMwAbLckh2rxOzeUO3nsyQJZMLwR+nTIbaZA9DFc316+LndM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739378853; c=relaxed/simple;
	bh=l49aKGECHlQJL+5gadj9OfHegUDAV/GXDkNvlccDNUs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kqebyYTpPuOu8FrQfNyex0UDBHB1TDt83ffWuSXnv6m8W/qwddSGe7ROE9qEW0JMQP0zjz85vIn3pCeEyYZMea4Io2NtrqnPHcEXo3h7Zj+jgJbzEIqBBiDkvXIuGBOgxShBe5DM9ZzhyQQYCnv+YOUvYugejgDpIZdq4oGGLK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ct/YiBkV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD895C4CEDF;
	Wed, 12 Feb 2025 16:47:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739378853;
	bh=l49aKGECHlQJL+5gadj9OfHegUDAV/GXDkNvlccDNUs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ct/YiBkVj/1vprGdL50t6+tZ3aG+ajLJswfKlgU/6eAGNwlyaDIyRSYBf/INefrZ1
	 7JpaxOf5/XOZGMmA7XrVJhPuc8ADt/r/W+ONiwSiZYVpKS2UUKvuP8LExJYrV/i+Cz
	 1EErM067bDYnFD8+ddMlm7UFaKiU9UTWnxGxgqmOSVc6hVTr/Bh1r7h+HmqTbID41Y
	 sYDQD2DNG9NwACjfkyyzC4xYDufLXJZ0rl55jFIN3Q+xBBSWINodFmr++kj0cTn0KO
	 mo/Z8qRGKRBbF7Ot+FMipeblXWVrmDj6fj9oCuXf4qO45Sm01DpmVH7m+h5hhmhdYO
	 cwJXaM1AQQ1HQ==
Date: Wed, 12 Feb 2025 16:47:31 +0000
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: Chao Yu <chao@kernel.org>
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
	Leo Stone <leocstone@gmail.com>,
	syzbot+b01a36acd7007e273a83@syzkaller.appspotmail.com
Subject: Re: [PATCH v4] f2fs: add check for deleted inode
Message-ID: <Z6zQoyNp5td-Wgd1@google.com>
References: <20250212072742.977248-1-chao@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250212072742.977248-1-chao@kernel.org>

On 02/12, Chao Yu wrote:
> From: Leo Stone <leocstone@gmail.com>
> 
> The syzbot reproducer mounts a f2fs image, then tries to unlink an
> existing file. However, the unlinked file already has a link count of 0
> when it is read for the first time in do_read_inode().
> 
> Add a check to sanity_check_inode() for i_nlink == 0.
> 
> [Chao Yu: rebase the code and fix orphan inode recovery issue]
> Reported-by: syzbot+b01a36acd7007e273a83@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=b01a36acd7007e273a83
> Fixes: 39a53e0ce0df ("f2fs: add superblock and major in-memory structure")
> Signed-off-by: Leo Stone <leocstone@gmail.com>
> Signed-off-by: Chao Yu <chao@kernel.org>
> ---
>  fs/f2fs/checkpoint.c | 4 ++++
>  fs/f2fs/f2fs.h       | 1 +
>  fs/f2fs/inode.c      | 6 ++++++
>  3 files changed, 11 insertions(+)
> 
> diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
> index bd890738b94d..ada2c548645c 100644
> --- a/fs/f2fs/checkpoint.c
> +++ b/fs/f2fs/checkpoint.c
> @@ -751,6 +751,8 @@ int f2fs_recover_orphan_inodes(struct f2fs_sb_info *sbi)
>  	if (is_sbi_flag_set(sbi, SBI_IS_WRITABLE))
>  		f2fs_info(sbi, "orphan cleanup on readonly fs");
>  
> +	set_sbi_flag(sbi, SBI_ORPHAN_RECOVERY);

What about using SBI_POR_DOING?

> +
>  	start_blk = __start_cp_addr(sbi) + 1 + __cp_payload(sbi);
>  	orphan_blocks = __start_sum_addr(sbi) - 1 - __cp_payload(sbi);
>  
> @@ -778,9 +780,11 @@ int f2fs_recover_orphan_inodes(struct f2fs_sb_info *sbi)
>  		}
>  		f2fs_put_page(page, 1);
>  	}
> +
>  	/* clear Orphan Flag */
>  	clear_ckpt_flags(sbi, CP_ORPHAN_PRESENT_FLAG);
>  out:
> +	clear_sbi_flag(sbi, SBI_ORPHAN_RECOVERY);
>  	set_sbi_flag(sbi, SBI_IS_RECOVERED);
>  
>  	return err;
> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> index 05879c6dc4d6..1c75081c0c14 100644
> --- a/fs/f2fs/f2fs.h
> +++ b/fs/f2fs/f2fs.h
> @@ -1322,6 +1322,7 @@ enum {
>  	SBI_IS_CLOSE,				/* specify unmounting */
>  	SBI_NEED_FSCK,				/* need fsck.f2fs to fix */
>  	SBI_POR_DOING,				/* recovery is doing or not */
> +	SBI_ORPHAN_RECOVERY,			/* orphan inodes recovery is doing */
>  	SBI_NEED_SB_WRITE,			/* need to recover superblock */
>  	SBI_NEED_CP,				/* need to checkpoint */
>  	SBI_IS_SHUTDOWN,			/* shutdown by ioctl */
> diff --git a/fs/f2fs/inode.c b/fs/f2fs/inode.c
> index d6ad7810df69..02f1b69d03d8 100644
> --- a/fs/f2fs/inode.c
> +++ b/fs/f2fs/inode.c
> @@ -386,6 +386,12 @@ static bool sanity_check_inode(struct inode *inode, struct page *node_page)
>  		}
>  	}
>  
> +	if (inode->i_nlink == 0 && !is_sbi_flag_set(sbi, SBI_ORPHAN_RECOVERY)) {
> +		f2fs_warn(sbi, "%s: inode (ino=%lx) has a link count of 0",
> +			  __func__, inode->i_ino);
> +		return false;
> +	}
> +
>  	return true;
>  }
>  
> -- 
> 2.48.1.502.g6dc24dfdaf-goog

