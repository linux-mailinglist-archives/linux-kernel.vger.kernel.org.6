Return-Path: <linux-kernel+bounces-513593-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30A8AA34C1A
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 18:38:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 900EC7A3001
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 17:37:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C081A204C0B;
	Thu, 13 Feb 2025 17:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BfYkO0oe"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D03328A2D6
	for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 17:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739468294; cv=none; b=RiubWpeGKJW7+bx6+Ij7TIhAHMSfwRZWAe7d/MmPeYExnQjinP8PWLLIiMXIb1oASKNP+yd5d9zcpArfvrTBalqrzI4IOMzCNNR87SNKgTKpMi6SFBGH6Z0Lt4B8cc6XB80u3HwFCNenFz9o4hFB82ndw+8E5985jWX/rC48Vl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739468294; c=relaxed/simple;
	bh=cnxfUNBbqbYlLFA77nUvaz5wzyMXDOOF13HQXlveTa4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oIkt189OcXqn4Pmx3KWpVcXRCj+TWYBWO1ORc4Iq2eXtpWGiGY8Qy3wy0eyaY8yY0P/mPUBwBq9c5sP17fWS/YL9LdU9SulkSFHAqP4VDeI8RtSFZ7E7hCtMmM4eF+IMHabxOj/4eXxZh3rGt4lQG9i3j53qeLtBTrQe2ImkG2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BfYkO0oe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63394C4CED1;
	Thu, 13 Feb 2025 17:38:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739468293;
	bh=cnxfUNBbqbYlLFA77nUvaz5wzyMXDOOF13HQXlveTa4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BfYkO0oewUevWKucBYARTUfa0Kqd5b/FbOe7lZX+v3FSgghhfG3Xg+iNZ5NHpVumJ
	 q/7oc61C6TecC+yOKTEeZWhQ1zLPrNs4UmvuJqJJuoNU01Z1Az2oS89jIV3SGyHjHy
	 PeiWg6T0e+SSxPZtcZhSn2yEQ4m84HCTR/d8v0Te7dXM99AGTNCEFWNXjqFyy0kdkz
	 e32oyonqTncA7Q49M4Op7Rao6izadgNcINpHj/VySJrVcy71Ah0iFKmqA5q462l51f
	 FH9qNNf3x1A8K+N7FZDyYennNRWhQudwj66QhkKh6XKYHleSgePzeQeOeSvrNkFaag
	 srLdi3HKuKxJg==
Date: Thu, 13 Feb 2025 17:38:11 +0000
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: Chao Yu <chao@kernel.org>
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
	Leo Stone <leocstone@gmail.com>,
	syzbot+b01a36acd7007e273a83@syzkaller.appspotmail.com
Subject: Re: [PATCH v4] f2fs: add check for deleted inode
Message-ID: <Z64uA2ys4nhV54lI@google.com>
References: <20250212072742.977248-1-chao@kernel.org>
 <Z6zQoyNp5td-Wgd1@google.com>
 <d8be79a2-9470-45b7-9df1-b571f2219c30@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d8be79a2-9470-45b7-9df1-b571f2219c30@kernel.org>

On 02/13, Chao Yu wrote:
> On 2/13/25 00:47, Jaegeuk Kim wrote:
> > On 02/12, Chao Yu wrote:
> >> From: Leo Stone <leocstone@gmail.com>
> >>
> >> The syzbot reproducer mounts a f2fs image, then tries to unlink an
> >> existing file. However, the unlinked file already has a link count of 0
> >> when it is read for the first time in do_read_inode().
> >>
> >> Add a check to sanity_check_inode() for i_nlink == 0.
> >>
> >> [Chao Yu: rebase the code and fix orphan inode recovery issue]
> >> Reported-by: syzbot+b01a36acd7007e273a83@syzkaller.appspotmail.com
> >> Closes: https://syzkaller.appspot.com/bug?extid=b01a36acd7007e273a83
> >> Fixes: 39a53e0ce0df ("f2fs: add superblock and major in-memory structure")
> >> Signed-off-by: Leo Stone <leocstone@gmail.com>
> >> Signed-off-by: Chao Yu <chao@kernel.org>
> >> ---
> >>  fs/f2fs/checkpoint.c | 4 ++++
> >>  fs/f2fs/f2fs.h       | 1 +
> >>  fs/f2fs/inode.c      | 6 ++++++
> >>  3 files changed, 11 insertions(+)
> >>
> >> diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
> >> index bd890738b94d..ada2c548645c 100644
> >> --- a/fs/f2fs/checkpoint.c
> >> +++ b/fs/f2fs/checkpoint.c
> >> @@ -751,6 +751,8 @@ int f2fs_recover_orphan_inodes(struct f2fs_sb_info *sbi)
> >>  	if (is_sbi_flag_set(sbi, SBI_IS_WRITABLE))
> >>  		f2fs_info(sbi, "orphan cleanup on readonly fs");
> >>  
> >> +	set_sbi_flag(sbi, SBI_ORPHAN_RECOVERY);
> > 
> > What about using SBI_POR_DOING?
> 
> SBI_POR_DOING will cover most flow of f2fs_fill_super(), I think we can add a
> separated flag just covering f2fs_recover_orphan_inodes(), so that we can allow
> iget() of root_inode and all inodes during roll-forward recovery to do sanity
> check nlink w/ zero. What do you think?

Can we do this sanity check after f2fs_iget in the f2fs_unlink() only?

> 
> Thanks,
> 
> > 
> >> +
> >>  	start_blk = __start_cp_addr(sbi) + 1 + __cp_payload(sbi);
> >>  	orphan_blocks = __start_sum_addr(sbi) - 1 - __cp_payload(sbi);
> >>  
> >> @@ -778,9 +780,11 @@ int f2fs_recover_orphan_inodes(struct f2fs_sb_info *sbi)
> >>  		}
> >>  		f2fs_put_page(page, 1);
> >>  	}
> >> +
> >>  	/* clear Orphan Flag */
> >>  	clear_ckpt_flags(sbi, CP_ORPHAN_PRESENT_FLAG);
> >>  out:
> >> +	clear_sbi_flag(sbi, SBI_ORPHAN_RECOVERY);
> >>  	set_sbi_flag(sbi, SBI_IS_RECOVERED);
> >>  
> >>  	return err;
> >> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> >> index 05879c6dc4d6..1c75081c0c14 100644
> >> --- a/fs/f2fs/f2fs.h
> >> +++ b/fs/f2fs/f2fs.h
> >> @@ -1322,6 +1322,7 @@ enum {
> >>  	SBI_IS_CLOSE,				/* specify unmounting */
> >>  	SBI_NEED_FSCK,				/* need fsck.f2fs to fix */
> >>  	SBI_POR_DOING,				/* recovery is doing or not */
> >> +	SBI_ORPHAN_RECOVERY,			/* orphan inodes recovery is doing */
> >>  	SBI_NEED_SB_WRITE,			/* need to recover superblock */
> >>  	SBI_NEED_CP,				/* need to checkpoint */
> >>  	SBI_IS_SHUTDOWN,			/* shutdown by ioctl */
> >> diff --git a/fs/f2fs/inode.c b/fs/f2fs/inode.c
> >> index d6ad7810df69..02f1b69d03d8 100644
> >> --- a/fs/f2fs/inode.c
> >> +++ b/fs/f2fs/inode.c
> >> @@ -386,6 +386,12 @@ static bool sanity_check_inode(struct inode *inode, struct page *node_page)
> >>  		}
> >>  	}
> >>  
> >> +	if (inode->i_nlink == 0 && !is_sbi_flag_set(sbi, SBI_ORPHAN_RECOVERY)) {
> >> +		f2fs_warn(sbi, "%s: inode (ino=%lx) has a link count of 0",
> >> +			  __func__, inode->i_ino);
> >> +		return false;
> >> +	}
> >> +
> >>  	return true;
> >>  }
> >>  
> >> -- 
> >> 2.48.1.502.g6dc24dfdaf-goog

