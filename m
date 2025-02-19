Return-Path: <linux-kernel+bounces-521340-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BE879A3BBCF
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 11:43:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9EB16177FAB
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 10:43:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 531A51DE4CA;
	Wed, 19 Feb 2025 10:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b="CIF+V4ib"
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 977691DE3D6
	for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 10:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.149.199.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739961794; cv=none; b=ROw85neUCn713trQ7vd5YVo1gGK9LXl2BuLHFW5GdEs02ljyBIVaQWA2dxCm94vcZzg9Q01SKT9FjKFbN4SE3epCxD/WFO7QNO+G6G3TrxEQFCg+3LYbTKj+KcByORkwKZPK8W1ll//xVzv1SX/0tsY/X5AYUVCocKkbtfM+h+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739961794; c=relaxed/simple;
	bh=hLiyNaqwwkpQgSvb1VVq/DAYN1fAgd+TH6x+OmeExGQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QDz9qW0CY4k3cBvr89zpyn6yRR9EyMkCUEaUEH46M1M6FJINe5UeTkGYJWHe9ClAFBfmNl3ykCNDL4YddSuERAARbpMyhQ4FHLWXelJHq+HSrJMZIzFL7kLZ/9SES+nimmyrhSMwe1t6TXx3lhlNUDa5ewqSrsTt5nGV5v67Eh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru; spf=pass smtp.mailfrom=ispras.ru; dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b=CIF+V4ib; arc=none smtp.client-ip=83.149.199.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ispras.ru
Received: from localhost (unknown [10.10.165.7])
	by mail.ispras.ru (Postfix) with ESMTPSA id 5ACA440CE188;
	Wed, 19 Feb 2025 10:43:10 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru 5ACA440CE188
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
	s=default; t=1739961790;
	bh=+I4/wTQwhMvH3uad7QmIZ+rCsdOWbseIIzswhmNndQ4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CIF+V4ib9b+RZaVRVLXnqWCDidZeNOyUqZVo+xbJe5hQZ2MPiBZAcsAz3E98bVL2x
	 OjxAatttv05fo3NxMBoCw0NVDTrv5fkkZCGAiVZMz6+0aMBqAt17161UZcGVEWHZJj
	 WqQFPo7HzkShlYYod2y4nXJlCsev5JXjAHHTww7I=
Date: Wed, 19 Feb 2025 13:43:10 +0300
From: Fedor Pchelkin <pchelkin@ispras.ru>
To: Rand Deeb <rand.sec96@gmail.com>
Cc: Dave Kleikamp <shaggy@kernel.org>, 
	jfs-discussion@lists.sourceforge.net, linux-kernel@vger.kernel.org, 
	voskresenski.stanislav@confident.ru, deeb.rand@confident.ru, lvc-project@linuxtesting.org
Subject: Re: [PATCH 5.10.y] fs/jfs: Prevent integer overflow in AG size
 calculation
Message-ID: <dmsdrpn5c5x3aqsgjiapqem4akvof2jezgyj4liqkeveo2cect@lb4s4krxfhtm>
References: <20250218124428.1638816-1-rand.sec96@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250218124428.1638816-1-rand.sec96@gmail.com>

On Tue, 18. Feb 15:44, Rand Deeb wrote:
> The JFS filesystem calculates allocation group (AG) size using 1 << 
> l2agsize in dbExtendFS(). When l2agsize exceeds 31 (possible with >2TB 
> aggregates on 32-bit systems), this 32-bit shift operation causes undefined
> behavior and improper AG sizing.
> 
> On 32-bit architectures:
> - Left-shifting 1 by 32+ bits results in 0 due to integer overflow
> - This creates invalid AG sizes (0 or garbage values) in 
> sbi->bmap->db_agsize
> - Subsequent block allocations would reference invalid AG structures
> - Could lead to: 
>   - Filesystem corruption during extend operations
>   - Kernel crashes due to invalid memory accesses
>   - Security vulnerabilities via malformed on-disk structures
> 
> Fix by casting to s64 before shifting:
> bmp->db_agsize = (s64)1 << l2agsize;
> 
> This ensures 64-bit arithmetic even on 32-bit architectures. The cast 
> matches the data type of db_agsize (s64) and follows similar patterns in 
> JFS block calculation code.
> 
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
> 
> Signed-off-by: Rand Deeb <rand.sec96@gmail.com>
> ---

Same here. The patch is supposed to address the issue in the mainline
first.. What is the reason for '5.10.y' in the subject?

>  fs/jfs/jfs_dmap.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/jfs/jfs_dmap.c b/fs/jfs/jfs_dmap.c
> index ef220709c7f5..eedea23d70ff 100644
> --- a/fs/jfs/jfs_dmap.c
> +++ b/fs/jfs/jfs_dmap.c
> @@ -3465,7 +3465,7 @@ int dbExtendFS(struct inode *ipbmap, s64 blkno,	s64 nblocks)
>  	oldl2agsize = bmp->db_agl2size;
>  
>  	bmp->db_agl2size = l2agsize;
> -	bmp->db_agsize = 1 << l2agsize;
> +	bmp->db_agsize = (s64)1 << l2agsize;
>  
>  	/* compute new number of AG */
>  	agno = bmp->db_numag;
> -- 
> 2.34.1

