Return-Path: <linux-kernel+bounces-262464-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F0E6593C76D
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 18:53:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB525282877
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 16:53:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 783D019D091;
	Thu, 25 Jul 2024 16:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bh+dgbAv"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0EB21D545
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 16:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721926401; cv=none; b=PDenMv1VyJeDFiliYVKviddTyIZefmr/5ih0esQqiamqpvZFYicsaupB5CbrwIoT40WEUdjrvSoWTdCF973/jz4uWavFfA4BICkNIygxeNGTT0U+e/qUiQSM9n8EKATJKLwhQNzkvtYg8eseyCVe1YXGh6gn5QZN3oayqWF/4iY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721926401; c=relaxed/simple;
	bh=+4LlKYDTgAhPZmYC0SMXOXNTQ6Qeoe1ZKAUx/gCLEp8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LhrKdmor4lXMKKOiI/LNvXajJpr0o1V6LbUN11tL0dDiJH7Bn+DRdzqu0TtoNBa7nHmZPpx3JI9A72ay3WYl3RBhUhXjD6EelzEzxxEYjZviMUyrOQQppD41bchQ93oZgAzg/jTK1MwHn6+iA/Ux1Cg45MdVhI+0pPBZ7EIriTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bh+dgbAv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC589C116B1;
	Thu, 25 Jul 2024 16:53:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721926401;
	bh=+4LlKYDTgAhPZmYC0SMXOXNTQ6Qeoe1ZKAUx/gCLEp8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bh+dgbAvSjID/AhQ1jSSZiMZO6mGq8NpoZ/91FphQd9ok/ugXlvEV8SAXRvILTBWh
	 ztVRAk+37960TOTmWMU/Z4cGgguWJnDhxlqmrUzYaScWGB3LoDDf1S1MrAlGM1qKD7
	 MKoxHjqQneX2R4RaUqkFsYAULPI0ETl9VqvhijU5WlgmFhW5eOuzf9fuwny0oAqtXz
	 7ohPizIk0PoneOeXGgcKPhh6+u3kn1z4H1qCGwIp1dMxx6iQAi7PnBgmxQ7QHqauOA
	 nbLWCzg44pPUBiUPr6cwLK9cV711YbCGupsDd554bBehWo09bmogxIjelHWMBTDp0S
	 cTsGKK43lQruQ==
Date: Thu, 25 Jul 2024 16:53:19 +0000
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: Zhiguo Niu <zhiguo.niu@unisoc.com>
Cc: chao@kernel.org, linux-f2fs-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org, niuzhiguo84@gmail.com,
	ke.wang@unisoc.com, Hao_hao.Wang@unisoc.com
Subject: Re: [PATCH] f2fs: fix to use per-inode maxbytes and cleanup
Message-ID: <ZqKC_wqbe_1qqQmf@google.com>
References: <1721295366-21008-1-git-send-email-zhiguo.niu@unisoc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1721295366-21008-1-git-send-email-zhiguo.niu@unisoc.com>

On 07/18, Zhiguo Niu wrote:
> This is a supplement to commit 6d1451bf7f84 ("f2fs: fix to use per-inode maxbytes")
> for some missed cases, also cleanup redundant code in f2fs_llseek.
> 
> Cc: Chengguang Xu <cgxu519@mykernel.net>
> Signed-off-by: Zhiguo Niu <zhiguo.niu@unisoc.com>
> ---
>  fs/f2fs/data.c   | 2 +-
>  fs/f2fs/file.c   | 7 ++-----
>  fs/f2fs/verity.c | 5 +++--
>  3 files changed, 6 insertions(+), 8 deletions(-)
> 
> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
> index 6457e5b..1d41d99 100644
> --- a/fs/f2fs/data.c
> +++ b/fs/f2fs/data.c
> @@ -2064,7 +2064,7 @@ int f2fs_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
>  static inline loff_t f2fs_readpage_limit(struct inode *inode)
>  {
>  	if (IS_ENABLED(CONFIG_FS_VERITY) && IS_VERITY(inode))
> -		return inode->i_sb->s_maxbytes;
> +		return max_file_blocks(inode) << F2FS_BLKSIZE_BITS;

F2FS_BLK_TO_BYTES(max_file_blocks(inode))?

>  
>  	return i_size_read(inode);
>  }
> diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
> index effbaa6..e6411d5 100644
> --- a/fs/f2fs/file.c
> +++ b/fs/f2fs/file.c
> @@ -431,7 +431,7 @@ static bool __found_offset(struct address_space *mapping,
>  static loff_t f2fs_seek_block(struct file *file, loff_t offset, int whence)
>  {
>  	struct inode *inode = file->f_mapping->host;
> -	loff_t maxbytes = inode->i_sb->s_maxbytes;
> +	loff_t maxbytes = max_file_blocks(inode) << F2FS_BLKSIZE_BITS;
>  	struct dnode_of_data dn;
>  	pgoff_t pgofs, end_offset;
>  	loff_t data_ofs = offset;
> @@ -513,10 +513,7 @@ static loff_t f2fs_seek_block(struct file *file, loff_t offset, int whence)
>  static loff_t f2fs_llseek(struct file *file, loff_t offset, int whence)
>  {
>  	struct inode *inode = file->f_mapping->host;
> -	loff_t maxbytes = inode->i_sb->s_maxbytes;
> -
> -	if (f2fs_compressed_file(inode))
> -		maxbytes = max_file_blocks(inode) << F2FS_BLKSIZE_BITS;
> +	loff_t maxbytes = max_file_blocks(inode) << F2FS_BLKSIZE_BITS;
>  
>  	switch (whence) {
>  	case SEEK_SET:
> diff --git a/fs/f2fs/verity.c b/fs/f2fs/verity.c
> index f7bb0c5..7fc787c 100644
> --- a/fs/f2fs/verity.c
> +++ b/fs/f2fs/verity.c
> @@ -74,7 +74,7 @@ static int pagecache_write(struct inode *inode, const void *buf, size_t count,
>  	struct address_space *mapping = inode->i_mapping;
>  	const struct address_space_operations *aops = mapping->a_ops;
>  
> -	if (pos + count > inode->i_sb->s_maxbytes)
> +	if (pos + count > (max_file_blocks(inode) << F2FS_BLKSIZE_BITS))
>  		return -EFBIG;
>  
>  	while (count) {
> @@ -237,7 +237,8 @@ static int f2fs_get_verity_descriptor(struct inode *inode, void *buf,
>  	pos = le64_to_cpu(dloc.pos);
>  
>  	/* Get the descriptor */
> -	if (pos + size < pos || pos + size > inode->i_sb->s_maxbytes ||
> +	if (pos + size < pos ||
> +	    pos + size > (max_file_blocks(inode) << F2FS_BLKSIZE_BITS) ||
>  	    pos < f2fs_verity_metadata_pos(inode) || size > INT_MAX) {
>  		f2fs_warn(F2FS_I_SB(inode), "invalid verity xattr");
>  		f2fs_handle_error(F2FS_I_SB(inode),
> -- 
> 1.9.1

