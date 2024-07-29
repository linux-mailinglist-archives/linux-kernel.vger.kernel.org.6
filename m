Return-Path: <linux-kernel+bounces-266110-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B00A893FB3E
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 18:33:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 663CB1F22958
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 16:33:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97DFD17CA1A;
	Mon, 29 Jul 2024 16:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b33yKb7/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBD32150981
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 16:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722270402; cv=none; b=TXVkHxzcz9GP8X22lEs2BvSEsr9qEhQxyyYjTHk4NqgEaADzWRupKDjQBJG5cesgeT8+TkpJWAmo1ARl52aTUkgeqodW4kNitgUGdqlzdFrw6SWwRyxjJx/xncyme2BW9Bz6TLzMaWmub+dTvW8Zf5RBy82Pa+n0uEWLxPKsF0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722270402; c=relaxed/simple;
	bh=5DJAmjjO5CX30yVxzqsOVYfxU3wFszmuKdtYvT0Qc30=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rjbuzGZ9Sp6rN4WmbAaKMRZ6A9sN/Yi8uFJAY78y6ZE29FHrF8g0KZ5yWCEE+MDlzhKreZqUctzXvvX2+zcS+rxbMKbkYDYp3b96Pd6snrmPFU7KTDLKawq3MmgKFGZSn1Dzmx2Lv1ViqrGq9fz0DvrpG+xNKJRKoxibw9eUQP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b33yKb7/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F781C32786;
	Mon, 29 Jul 2024 16:26:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722270402;
	bh=5DJAmjjO5CX30yVxzqsOVYfxU3wFszmuKdtYvT0Qc30=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=b33yKb7/aN0jAQSJGC/gG5idmAse7XkoN74GQYfcYO4Q+RdnKCeI1zwhrNE/FBFn5
	 ksjKCofXvc5hbk2s6HzwDTNV7WiEiWmI+HxrgnV82ab4pI5M+GU9oWWFbESeZwMmhv
	 TttP8AqQS5L9LN28zruVhhTQIOsn6EarOtZjg/nz34XmCqTTyUWKz3BjWI2N2em4jZ
	 HLVSaCDR2UXKjzm80nytePkIzcwIUQMozzXYhwzWmVF5lRdUNjrjY+Oiz6lTB/xeDs
	 IYTccFPuvpsRe6b9D8Z1HJttamvUXJW+vtJ0cn0OTXBdrD0WxKUrVdsx025baU5Ka+
	 wAMieBRXfx7vQ==
Date: Mon, 29 Jul 2024 16:26:40 +0000
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: Chao Yu <chao@kernel.org>
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/4] f2fs: atomic: fix to truncate pagecache before
 on-disk metadata truncation
Message-ID: <ZqfCwDcg7nvJPenf@google.com>
References: <20240726012204.1306174-1-chao@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240726012204.1306174-1-chao@kernel.org>

On 07/26, Chao Yu wrote:
> We should always truncate pagecache while truncating on-disk data.
> 
> Fixes: a46bebd502fe ("f2fs: synchronize atomic write aborts")
> Signed-off-by: Chao Yu <chao@kernel.org>
> ---
> v2:
> - fix to use cow_inode instead of inode
>  fs/f2fs/file.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
> index 6c62f76474d1..54886ddcb8ab 100644
> --- a/fs/f2fs/file.c
> +++ b/fs/f2fs/file.c
> @@ -2202,6 +2202,7 @@ static int f2fs_ioc_start_atomic_write(struct file *filp, bool truncate)
>  		F2FS_I(fi->cow_inode)->atomic_inode = inode;
>  	} else {
>  		/* Reuse the already created COW inode */
> +		truncate_setsize(fi->cow_inode, 0);

What if the below truncation failed?

>  		ret = f2fs_do_truncate_blocks(fi->cow_inode, 0, true);
>  		if (ret) {
>  			f2fs_up_write(&fi->i_gc_rwsem[WRITE]);
> -- 
> 2.40.1

