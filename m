Return-Path: <linux-kernel+bounces-222006-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D1D590FB9D
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 05:20:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 53F2A1F22F66
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 03:20:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C69C1D540;
	Thu, 20 Jun 2024 03:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uu4go8hK"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D42C2139C7
	for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 03:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718853625; cv=none; b=EmtU3GaUOdTxdm3rmmdb1djNS9uU6Ka1yI4LHpMGoTTNgtCtK1Kr9Mc4pVvGfp8fn6lIC/XvJdwOK6APM7WQ8MLYUV4cHmQg/DuFW3wFz66moRYA75Bss4JjVMaO3ttBc+1pf3Zzc/e7F7awZc0p7CGAk7WY6wz+PEvgG9LJAPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718853625; c=relaxed/simple;
	bh=TAAgplD9oJWAcHrVyNc1Ug4UEEKEKPxmnmCOe3L5NyE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CK2z0MzUYCn+mye60tbO1b1bU7GVR+Q24KG3f8fTSXe/BSc0SB34ghEbJYwJwvpFnf43befprzEDrWQ2Yki4yypG2W5qg5D9t8YpxCNyyES8rEFgAcMqlSL5QVhs7yZt+uLRSTrHDYbxc/+ZaNztTNT7mXFqRx1NZpgB1DLWO+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uu4go8hK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D380FC2BBFC;
	Thu, 20 Jun 2024 03:20:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718853624;
	bh=TAAgplD9oJWAcHrVyNc1Ug4UEEKEKPxmnmCOe3L5NyE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=uu4go8hK2Ieal0QhF84wVdASOEMAWKc2+vYrYSQsMpMR0XvpmLa9KH+EGSIc1bz3d
	 bxaJuWKkFEdfxEW7vBHPNdAXawihAyj5UUSif4ArOXBVPhP3WM381aF/HeA/Sockg5
	 Phqez3wxzWC4WehNxjZuXkwi/XkLek00MRRnHJiKvnEv9ehHjdheQfVBnwXK7c65Tp
	 /H6zUk0gwidmVU/c2wN2EhOMs6mOwqIOtDFILwY77gfCaZ7KoW8rsMcsZmbxLL9n4q
	 d1sbzUfaAV+bNs0Tbhlq3bCSqaDnp0IiXnvCTCsO6W0SGNoNTE5xy1L8vpn/E3OQxy
	 PwkYCd6LRgIsQ==
Message-ID: <2842767c-db80-407b-a5e5-2b9fa74b0d79@kernel.org>
Date: Thu, 20 Jun 2024 11:20:20 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Revert "f2fs: use flush command instead of FUA for zoned
 device"
To: jaegeuk@kernel.org, Wenjie Cheng <cwjhust@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 qwjhust@gmail.com
References: <20240614004841.103114-1-cwjhust@gmail.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20240614004841.103114-1-cwjhust@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Jaegeuk,

Quoted commit message from commit c550e25bca66 ("f2fs: use flush command
instead of FUA for zoned device")
"
The block layer for zoned disk can reorder the FUA'ed IOs. Let's use flush
command to keep the write order.
"

It seems mq-deadline use fifo queue and make queue depth of zone device
as 1 to IO order, so why FUA'ed write node IOs can be reordered by block
layer?

Thanks,

On 2024/6/14 8:48, Wenjie Cheng wrote:
> This reverts commit c550e25bca660ed2554cbb48d32b82d0bb98e4b1.
> 
> Commit c550e25bca660ed2554cbb48d32b82d0bb98e4b1 ("f2fs: use flush
> command instead of FUA for zoned device") used additional flush
> command to keep write order.
> 
> Since Commit dd291d77cc90eb6a86e9860ba8e6e38eebd57d12 ("block:
> Introduce zone write plugging") has enabled the block layer to
> handle this order issue, there is no need to use flush command.
> 
> Signed-off-by: Wenjie Cheng <cwjhust@gmail.com>
> ---
>   fs/f2fs/file.c | 3 +--
>   fs/f2fs/node.c | 2 +-
>   2 files changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
> index eae2e7908072..f08e6208e183 100644
> --- a/fs/f2fs/file.c
> +++ b/fs/f2fs/file.c
> @@ -372,8 +372,7 @@ static int f2fs_do_sync_file(struct file *file, loff_t start, loff_t end,
>   	f2fs_remove_ino_entry(sbi, ino, APPEND_INO);
>   	clear_inode_flag(inode, FI_APPEND_WRITE);
>   flush_out:
> -	if ((!atomic && F2FS_OPTION(sbi).fsync_mode != FSYNC_MODE_NOBARRIER) ||
> -	    (atomic && !test_opt(sbi, NOBARRIER) && f2fs_sb_has_blkzoned(sbi)))
> +	if (!atomic && F2FS_OPTION(sbi).fsync_mode != FSYNC_MODE_NOBARRIER)
>   		ret = f2fs_issue_flush(sbi, inode->i_ino);
>   	if (!ret) {
>   		f2fs_remove_ino_entry(sbi, ino, UPDATE_INO);
> diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
> index 144f9f966690..c45d341dcf6e 100644
> --- a/fs/f2fs/node.c
> +++ b/fs/f2fs/node.c
> @@ -1631,7 +1631,7 @@ static int __write_node_page(struct page *page, bool atomic, bool *submitted,
>   		goto redirty_out;
>   	}
>   
> -	if (atomic && !test_opt(sbi, NOBARRIER) && !f2fs_sb_has_blkzoned(sbi))
> +	if (atomic && !test_opt(sbi, NOBARRIER))
>   		fio.op_flags |= REQ_PREFLUSH | REQ_FUA;
>   
>   	/* should add to global list before clearing PAGECACHE status */

