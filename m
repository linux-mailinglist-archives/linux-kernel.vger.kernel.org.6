Return-Path: <linux-kernel+bounces-275624-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E10D99487B1
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 04:45:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B27B285D8B
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 02:45:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FE5743AAE;
	Tue,  6 Aug 2024 02:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p4vt2xXg"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63F8E433BB
	for <linux-kernel@vger.kernel.org>; Tue,  6 Aug 2024 02:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722912223; cv=none; b=t39iZaRtf1TDkqO1hIWcV//iAOD3iR3AzS075CGmCQj+I8z2EEe3e5iG6GFa3fqCs1sczXUpa/yMr2A/aRzDYS2MryIwuhDXzzyGwz0fQV8/BerTuyrWYVn9sAG9VpJpDovK33kRW9gAWoZ9IxS9TYe73OPulNbaGTtK/qsCN1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722912223; c=relaxed/simple;
	bh=1gQt/xGiNzbNxHjkcFls8MV62aqxPJqo4osSDIzjg5M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aovGYknvYgxaRyTUHvozCXOcIHN3jUyAKahfTVmHUnO9OaQuTB947412VOJDXOY2Pe1jWBr+LUolvEOSzncxiqwmHVRx6BfsefZpDdNfapDZhkjI6Q8G4Hu4j8hmmel70TmW9jiqfeW2e3Jj0vJMKlwcI44ej/zzlUo1n6F6Qs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p4vt2xXg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5B10C32782;
	Tue,  6 Aug 2024 02:43:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722912223;
	bh=1gQt/xGiNzbNxHjkcFls8MV62aqxPJqo4osSDIzjg5M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=p4vt2xXgNp2e8HCJlCzpA1pTKzEmRd4zdAfLkKdxneYhNTihGUp6ix0Fh4D9eGF8P
	 DmAAMpI71pzEVsnLUO1FTpkZbzGB+DH5r8EMe1JOuYkkC8+6vYmTBarjVJv1XRHtD4
	 9Qu27mD1XlTueCmN93PCb96KgOPkLoBqlm4gP1gU/BWx4/h6N3F2fA0e8ltTX9D7Bn
	 dJ0o2UrNf7MmSG19BtiAC7QJKqtQCg74AANwmJ+9BYOeTqm2oVghanSthBlzq9NIyc
	 +8lQh70cFUn3Zp1rCRML2fgn1YTyooT+Mc7aiULXYgOIKRtDfnKylw4G5KLkzuRVXA
	 1HM6nvYEcO9cw==
Date: Tue, 6 Aug 2024 02:43:41 +0000
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: Chao Yu <chao@kernel.org>
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/4] f2fs: atomic: fix to truncate pagecache before
 on-disk metadata truncation
Message-ID: <ZrGN3ed4pN5Ii67m@google.com>
References: <20240801011337.3772536-1-chao@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240801011337.3772536-1-chao@kernel.org>

On 08/01, Chao Yu wrote:
> We should always truncate pagecache while truncating on-disk data.
> 
> Fixes: a46bebd502fe ("f2fs: synchronize atomic write aborts")
> Signed-off-by: Chao Yu <chao@kernel.org>
> ---
> v3:
> - check dirty page before truncation
> - use invalidate_mapping_pages() instead of truncate_inode_pages()
> - set i_size to zero after truncation
>  fs/f2fs/file.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
> index ac61c88f7688..a316c21539d1 100644
> --- a/fs/f2fs/file.c
> +++ b/fs/f2fs/file.c
> @@ -2199,11 +2199,17 @@ static int f2fs_ioc_start_atomic_write(struct file *filp, bool truncate)
>  		F2FS_I(fi->cow_inode)->atomic_inode = inode;
>  	} else {
>  		/* Reuse the already created COW inode */
> +		f2fs_bug_on(sbi, get_dirty_pages(fi->cow_inode));
> +
> +		invalidate_mapping_pages(fi->cow_inode->i_mapping, 0, -1);
> +
>  		ret = f2fs_do_truncate_blocks(fi->cow_inode, 0, true);
>  		if (ret) {
>  			f2fs_up_write(&fi->i_gc_rwsem[WRITE]);
>  			goto out;
>  		}
> +
> +		i_size_write(fi->cow_inode, 0);

Do we really need this?

>  	}
>  
>  	f2fs_write_inode(inode, NULL);
> -- 
> 2.40.1

