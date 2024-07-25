Return-Path: <linux-kernel+bounces-262468-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1947993C776
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 18:56:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4A42E1C21AD7
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 16:56:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E5A119DF43;
	Thu, 25 Jul 2024 16:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pNovAvLK"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ED6819D091
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 16:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721926560; cv=none; b=nwJurREkMrqv3SzlGcuVOxg5opcoyABDKlu+AOldl5clXGaQIu5kRS2WtVD/5ZLlELq+q1Oq5EywI3Igni6lnQORBVrMD5A/VMjD88J50ZP0uFKhPK1DPjnlskXeeY6S/kFtKwebJrCpNsOkUdYuvAQYx0xeRaYbF84IJ18Ok3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721926560; c=relaxed/simple;
	bh=drnhCfnqjtD+uKAYvYSo4Q1c4Rbt5tbKQljMuGKzJ6U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JO7y8XE+UATcEsEqvNU3QmfxyNX707lj6wnFQO4eJnGrnbTuXERoU5vLgforgjVOHn8+XyiJxEnCNIJlN5LG4/Gv52aUA9ATArIQYUgZu026ySbpr+3c3WR/4zFLdO4O1b3NnarmeVjAjB6NLZkXPRdv412tIbqeuTPrECjA+vI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pNovAvLK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19451C116B1;
	Thu, 25 Jul 2024 16:56:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721926560;
	bh=drnhCfnqjtD+uKAYvYSo4Q1c4Rbt5tbKQljMuGKzJ6U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pNovAvLKrIJ5tPWI659ETbgg8B0whNU1i57au3u9kQZUJlhEWJBTPYzCajMWxYAyj
	 mlRttOQuTGF9bDYXZsW3y0wUAz+Kz/42X3Al19j0ewzERKICj+hHVnF1OWamLfwi/x
	 smKEQMqac+d5A+DRIL+9IPuHnb9KvtMMjHkgaSzoHGO94mK5s9zQaW5vXDRnne9wky
	 BxzgtRN8dSI5Rfu4FKbFyMILra+r8UBhM1VrSPQdkW4JiJtGCntqBqkw8Rqr5TCXaK
	 ZS08m1vPfWa1vBAWsDVHmAxzjhv/iqx6UUX1CP0YcencfCRRXhBY36OwbPT9pD3pq6
	 CMnS7GiqljFxw==
Date: Thu, 25 Jul 2024 16:55:58 +0000
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: Chao Yu <chao@kernel.org>
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] f2fs: don't traverse directory blocks after EOF
Message-ID: <ZqKDnpzwX85RyGaa@google.com>
References: <20240712073415.227226-1-chao@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240712073415.227226-1-chao@kernel.org>

On 07/12, Chao Yu wrote:
> All directory blocks are within the scope of i_size, so let's limit
> the end_block to just check valid dirent blocks.

Do we really need this?

> 
> Meanwhile, it uses dir_blocks() instead of variable for cleanup in
> __f2fs_find_entry().
> 
> Signed-off-by: Chao Yu <chao@kernel.org>
> ---
>  fs/f2fs/dir.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/f2fs/dir.c b/fs/f2fs/dir.c
> index 02c9355176d3..d4591c215f07 100644
> --- a/fs/f2fs/dir.c
> +++ b/fs/f2fs/dir.c
> @@ -305,18 +305,21 @@ static struct f2fs_dir_entry *find_in_level(struct inode *dir,
>  	int s = GET_DENTRY_SLOTS(fname->disk_name.len);
>  	unsigned int nbucket, nblock;
>  	unsigned int bidx, end_block;
> +	unsigned long last_block;
>  	struct page *dentry_page;
>  	struct f2fs_dir_entry *de = NULL;
>  	pgoff_t next_pgofs;
>  	bool room = false;
>  	int max_slots;
>  
> +	last_block = dir_blocks(dir);
>  	nbucket = dir_buckets(level, F2FS_I(dir)->i_dir_level);
>  	nblock = bucket_blocks(level);
>  
>  	bidx = dir_block_index(level, F2FS_I(dir)->i_dir_level,
>  			       le32_to_cpu(fname->hash) % nbucket);
>  	end_block = bidx + nblock;
> +	end_block = min_t(unsigned int, end_block, last_block);
>  
>  	while (bidx < end_block) {
>  		/* no need to allocate new dentry pages to all the indices */
> @@ -361,7 +364,6 @@ struct f2fs_dir_entry *__f2fs_find_entry(struct inode *dir,
>  					 const struct f2fs_filename *fname,
>  					 struct page **res_page)
>  {
> -	unsigned long npages = dir_blocks(dir);
>  	struct f2fs_dir_entry *de = NULL;
>  	unsigned int max_depth;
>  	unsigned int level;
> @@ -373,7 +375,7 @@ struct f2fs_dir_entry *__f2fs_find_entry(struct inode *dir,
>  		goto out;
>  	}
>  
> -	if (npages == 0)
> +	if (dir_blocks(dir) == 0)
>  		goto out;
>  
>  	max_depth = F2FS_I(dir)->i_current_depth;
> -- 
> 2.40.1

