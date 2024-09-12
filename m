Return-Path: <linux-kernel+bounces-326751-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C4D2976C89
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 16:47:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5EE081C23A6D
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 14:47:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 538881BB6B1;
	Thu, 12 Sep 2024 14:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BC/K4OjI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7D221BD012
	for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 14:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726152358; cv=none; b=oJmneYVfQHoAx3mysUwengTb677xBf0HjwMOubghjXwbQ3jZosWTWvKihVt4fS9JhxcQA3eUL46dgpYGm5xHvByhqotgEfHdILJzDsx49A0mXZq3oxQPDIRCSdTMyRwMrG8upxRPPBza7G+CSoTiqei/fOIt3de4loGIRFah0RI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726152358; c=relaxed/simple;
	bh=hrauWppsc6XR803UtC8++6+LnYlEts6MH5xg+4q+wJg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JehZz954O4Ncbn2myAD/hC+mfYHGSWZ31FSq+aOTsNpwvNVymwxUDZFrzjZwKVcV8zbitK0bJghnvvulPnYw7VvpV5yk5M9s5P19t/P0fI5V9UcguGFpTLvoPUm8SdTDUoVyO21gTFXfLe6/2qMDhVEWYCz735tKcb0fADWkfyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BC/K4OjI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1312AC4CEC3;
	Thu, 12 Sep 2024 14:45:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726152358;
	bh=hrauWppsc6XR803UtC8++6+LnYlEts6MH5xg+4q+wJg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BC/K4OjI32iuDv9vIgIEUHBAEPJq2E8mIRnVf+7h0cSFOb0hc4CNdbeGd8DpGl97v
	 3jUXK7sm4Nq7wYqPLm1b6h2ijZBSHBtslByMfKY2YpfSSG9dZ0gSYKjQtPpDjS2It1
	 llJaZn8zhayFhRvgGzfCdylwVXvDi1D7dBbyIX9hX92QBm52rU5crXsODDppN59ALA
	 oRXTmxlUAt2iBLmF/PcfZMNpUGGVm8iTcULgjSHfXov3SLGPWk/A0NC7e5Qa68O2/o
	 n3jBUhy0UJTYoF1IpzAJ9HeWwtTbBWe4E39NG6DdJY7IDUN0GXuefe6EuZ4NYLh6N1
	 cJHZfLe4dHk0w==
Date: Thu, 12 Sep 2024 14:45:56 +0000
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: Daeho Jeong <daeho43@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
	kernel-team@android.com, Daeho Jeong <daehojeong@google.com>
Subject: Re: [PATCH] f2fs: forcibly migrate to secure space for zoned device
 file pinning
Message-ID: <ZuL-pAo6A0VVBwYG@google.com>
References: <20240911213031.183299-1-daeho43@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240911213031.183299-1-daeho43@gmail.com>

On 09/11, Daeho Jeong wrote:
> From: Daeho Jeong <daehojeong@google.com>
> 
> We need to migrate data blocks even though it is full to secure space
> for zoned device file pinning.
> 
> Signed-off-by: Daeho Jeong <daehojeong@google.com>
> Fixes: 9703d69d9d15 ("f2fs: support file pinning for zoned devices")
> ---
>  fs/f2fs/gc.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
> index 724bbcb447d3..aaae13493a70 100644
> --- a/fs/f2fs/gc.c
> +++ b/fs/f2fs/gc.c
> @@ -2010,8 +2010,7 @@ int f2fs_gc_range(struct f2fs_sb_info *sbi,
>  			.iroot = RADIX_TREE_INIT(gc_list.iroot, GFP_NOFS),
>  		};
>  
> -		do_garbage_collect(sbi, segno, &gc_list, FG_GC,
> -						dry_run_sections == 0);
> +		do_garbage_collect(sbi, segno, &gc_list, FG_GC, true);

Do you mean this, right?

do_garbage_collect(sbi, segno, &gc_list, FG_GC, true, false);

>  		put_gc_inode(&gc_list);
>  
>  		if (!dry_run && get_valid_blocks(sbi, segno, true))
> -- 
> 2.46.0.598.g6f2099f65c-goog
> 

