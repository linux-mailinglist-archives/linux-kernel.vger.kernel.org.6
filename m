Return-Path: <linux-kernel+bounces-413341-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C5DE9D179E
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 19:08:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E5A20282432
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 18:08:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EBA41DE4F1;
	Mon, 18 Nov 2024 18:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fvrRXRXm"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E7A31C07FC
	for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 18:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731953280; cv=none; b=aCQg2/VeYzQSH+OYw74+OwCkk26GdHjVIs17B66T/CGWa6dIBTIrwFHLKNsIoSx2MGLUWt64GNNN1pkuuI45IqLOFAtMDVh9YOgBH56ZsVGSqPhoHp3k5RinxrJD+e4m+gq7QJAkQDfz10lVIccJMskRxScs22WbV+JMt95O160=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731953280; c=relaxed/simple;
	bh=XN8H4LzvUQloDuTy+U3peh1JPPNd1rvnX1i2XbCnODw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zp2TPgTJ/os2EBpaCbGKn7hBi4RFkPr7HU0n5Uev8CI/EL5Qi6gHLM+X5rUMBujuk/2ptiXkY5c47bYo3ZDLBN06rFloMR6mnkxSvm1J7xQ3rVJnfFSJYA8Sr/1k1vsG2pfvTIDTL8brOHpWfwie5Wzg7lna322NwSMncKjRNL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fvrRXRXm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D73F2C4CECC;
	Mon, 18 Nov 2024 18:07:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731953280;
	bh=XN8H4LzvUQloDuTy+U3peh1JPPNd1rvnX1i2XbCnODw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fvrRXRXm1PaVd7qlQfzj3ZHm+iQnSJTNNW/ir0rL4WwYMK0nH7vZ/rz1wm+Tteuw9
	 2zZzyuoZatN325HZsyVMgD0tc4nS1DrZodE1Cii85oceol/X8hrg0iM6L8AbC89o1w
	 BRWUARzZhRbXeAhL9MtR/3acf8yVbZXiGpeTYhzN+FL57bAYLjedP/OlXg7ineiJ9c
	 Qt09+CgBVUDmh+jJpYNyELh4J0+JGb+nAoQyYJw1/khNbMV992RzP2/JDG/njcs6pj
	 /m99tx5P/cZScdXpbzajiyHnTimBSovYH0Tt4IZtqIc8qo38FhqITFz0kxPRAxTLXe
	 XUz8L2lwZGTXA==
Date: Mon, 18 Nov 2024 18:07:58 +0000
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: Chao Yu <chao@kernel.org>
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] f2fs: fix to do cast in F2FS_{BLK_TO_BYTES,
 BTYES_TO_BLK} to avoid overflow
Message-ID: <ZzuCfgTp9m1eqIGa@google.com>
References: <20241108012557.572782-1-chao@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241108012557.572782-1-chao@kernel.org>

I applied this with the below change to avoid build failure.

--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -3336,7 +3336,7 @@ loff_t max_file_blocks(struct inode *inode)
         * fit within U32_MAX + 1 data units.
         */

-       result = min(result, F2FS_BYTES_TO_BLK(((loff_t)U32_MAX + 1) * 4096));
+       result = umin(result, F2FS_BYTES_TO_BLK(((loff_t)U32_MAX + 1) * 4096));

        return result;
 }

On 11/08, Chao Yu wrote:
> It missed to cast variable to unsigned long long type before
> bit shift, which will cause overflow, fix it.
> 
> Fixes: f7ef9b83b583 ("f2fs: introduce macros to convert bytes and blocks in f2fs")
> Signed-off-by: Chao Yu <chao@kernel.org>
> ---
>  include/linux/f2fs_fs.h | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/include/linux/f2fs_fs.h b/include/linux/f2fs_fs.h
> index b0b821edfd97..3b2ad444c002 100644
> --- a/include/linux/f2fs_fs.h
> +++ b/include/linux/f2fs_fs.h
> @@ -24,10 +24,10 @@
>  #define NEW_ADDR		((block_t)-1)	/* used as block_t addresses */
>  #define COMPRESS_ADDR		((block_t)-2)	/* used as compressed data flag */
>  
> -#define F2FS_BYTES_TO_BLK(bytes)	((bytes) >> F2FS_BLKSIZE_BITS)
> -#define F2FS_BLK_TO_BYTES(blk)		((blk) << F2FS_BLKSIZE_BITS)
> +#define F2FS_BYTES_TO_BLK(bytes)	((unsigned long long)(bytes) >> F2FS_BLKSIZE_BITS)
> +#define F2FS_BLK_TO_BYTES(blk)		((unsigned long long)(blk) << F2FS_BLKSIZE_BITS)
>  #define F2FS_BLK_END_BYTES(blk)		(F2FS_BLK_TO_BYTES(blk + 1) - 1)
> -#define F2FS_BLK_ALIGN(x)			(F2FS_BYTES_TO_BLK((x) + F2FS_BLKSIZE - 1))
> +#define F2FS_BLK_ALIGN(x)		(F2FS_BYTES_TO_BLK((x) + F2FS_BLKSIZE - 1))
>  
>  /* 0, 1(node nid), 2(meta nid) are reserved node id */
>  #define F2FS_RESERVED_NODE_NUM		3
> -- 
> 2.40.1

