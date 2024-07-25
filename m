Return-Path: <linux-kernel+bounces-262642-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6899F93C9EB
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 22:54:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 202771F21581
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 20:54:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E926013CA93;
	Thu, 25 Jul 2024 20:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rLgvLDDj"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B91361FCE
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 20:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721940858; cv=none; b=HRzPqKjnU/IKpuBwZkemvCPrmU5KGU6cyLnVF+XEJ8sF55+S89ITcAdvVZQkFCFhXA9Czh4tu8fORarPfRTEubGcdkejzgpV9Fy5+EIbWOaTkGtdyV1sPLNFPsDSansuGJnkJsE4Yx0sDa9xAp+/FLvFwUVCj5EKAw7pON8epms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721940858; c=relaxed/simple;
	bh=k5XgKfZKuQaShbPcQ6ThZs8P3ZYbgS7XfbQSn8nih/M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MAOx6N8ttbjUYmpVUEvIuG6MsdtMj5ODF5H94v1SHDrHhCX7IQ3px0r+qRw7vs7MYjPRm8Qb8miPs+5hMjswKoV8ZiXT/2waIdYbe0v1EgaSe60+7HIM0fkibBJaBQF+pBvW3THjW0fSuTtViX5HU5XPSu3qctWVQVzUyV7MaS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rLgvLDDj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8D80C116B1;
	Thu, 25 Jul 2024 20:54:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721940858;
	bh=k5XgKfZKuQaShbPcQ6ThZs8P3ZYbgS7XfbQSn8nih/M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rLgvLDDj/jasD2/pDtM49kkJ73pgckmTKb+fEsomssWcydRi7ggyWe8W/aipUNKO+
	 J5F8Gmt2d7PLHw/6elTZEG8kU6W3QDAE/TV4sp0VxN1LWbcIuIn+TES/IhTmNza0yw
	 x6AcKKCui7WnsXGMe2d0kQzF+3BmdmE4s0cmJy/AVVv012YJp1+PRaT1f2JJ/4SqZT
	 72BVaur7u7PpesAI1oMYHku9zbf7Mvqs65VP0AN51oH83+fFkkNVwoa9KnjlSZFKOz
	 EOOi05ETs9X82PYug+aOE2q76RAie1OOXjLttCt4QV4qsOUiPr4kx6wczrG2+rFkkR
	 9L3ftWZG+6niw==
Date: Thu, 25 Jul 2024 20:54:16 +0000
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: Chao Yu <chao@kernel.org>
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/4] f2fs: atomic: fix to truncate pagecache before
 on-disk metadata truncation
Message-ID: <ZqK7eC9W9HVweTOJ@google.com>
References: <20240625031351.3586955-1-chao@kernel.org>
 <20240625031351.3586955-3-chao@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240625031351.3586955-3-chao@kernel.org>

On 06/25, Chao Yu wrote:
> We should always truncate pagecache while truncating on-disk data.
> 
> Fixes: a46bebd502fe ("f2fs: synchronize atomic write aborts")
> Signed-off-by: Chao Yu <chao@kernel.org>
> ---
>  fs/f2fs/file.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
> index 2203904383a6..0355cb054521 100644
> --- a/fs/f2fs/file.c
> +++ b/fs/f2fs/file.c
> @@ -2185,6 +2185,7 @@ static int f2fs_ioc_start_atomic_write(struct file *filp, bool truncate)
>  		clear_inode_flag(fi->cow_inode, FI_INLINE_DATA);
>  	} else {
>  		/* Reuse the already created COW inode */
> +		truncate_setsize(inode, 0);

		fi->cow_inode?

>  		ret = f2fs_do_truncate_blocks(fi->cow_inode, 0, true);
>  		if (ret) {
>  			f2fs_up_write(&fi->i_gc_rwsem[WRITE]);
> -- 
> 2.40.1

