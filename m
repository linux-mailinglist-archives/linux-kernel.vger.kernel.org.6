Return-Path: <linux-kernel+bounces-565417-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 008AEA667B1
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 04:45:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E835422F96
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 03:45:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBB1E1A3A8D;
	Tue, 18 Mar 2025 03:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gj0VR1Vo"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D59B19B3CB
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 03:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742269534; cv=none; b=iP/0pP8pCkWadcr1LsfNVE7jqWESXql0vpwTp1OMH2ZXdBVn26KJ1O/vVxU9IKfYExfyW0Es1FZ/tM+RPT/dIha0wyeEDDSrJ3cxnt0+7YPV3cagoPvHhlNaaHSge1eQ6JPYsRXKhGPRlTXQSY3YdkYg/YLviJOOlh8XjNEvcuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742269534; c=relaxed/simple;
	bh=++3h7Bof4jAQAtQU4RRyqgkw3OfMN/2V24Ouwj5UMJE=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=W8YQV1mYDGnSqHsg6Cvg+pmKMU9DcE3PRyOAJyJ0IDxEXX423MLX/jDpvNRu1HzqDbnBKMa0n0Brf+DNGVrSHVe7sGOAwuEonZGXJT/C/2/puytngYLFVy1+phNhmymC0/yLwKQh3hTJI1q1x4oJBg74OtTchQZAtKEejzqAP5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gj0VR1Vo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45153C4CEDD;
	Tue, 18 Mar 2025 03:45:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742269533;
	bh=++3h7Bof4jAQAtQU4RRyqgkw3OfMN/2V24Ouwj5UMJE=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=gj0VR1Vo6aJlaApZ9MJzDjpdw82WNyj8o5ZhhgpM4KWju2/SnBT1whVmmbN65BKdM
	 YbN7BVAfCyRz/ljJMVRS+3DV2TArDNtFbWTTUDPBfsLY5bnYI8YnlJfwdo6P9g3dM6
	 bmBBsjRRqmcIw2kEew0x5GbabtqiLeRT1WfOUajTAh0afi9XNk8lzsXa+k0bF7PANa
	 ikgihPcyss/Mh9M7s4t+PhzPsCBheM8nIvEj8MaagPUM7Ot6IdJtSw5ee5Zr6WS7Uk
	 s+ezdIotS2w7BCevLm2c2D7lEA6bmmtXFc/20whUa+MP2OpJqddEJ9H4aJmuRt/zdg
	 HgcSAAnZuUR/w==
Message-ID: <ea3988c6-7708-4da9-8009-85708a27275b@kernel.org>
Date: Tue, 18 Mar 2025 11:45:30 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: chao@kernel.org, Daeho Jeong <daehojeong@google.com>
Subject: Re: [f2fs-dev] [PATCH] f2fs: support zero sized file truncate for
 device aliasing files
To: Daeho Jeong <daeho43@gmail.com>, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com
References: <20250317190809.678626-1-daeho43@gmail.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20250317190809.678626-1-daeho43@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/18/25 03:08, Daeho Jeong wrote:
> From: Daeho Jeong <daehojeong@google.com>
> 
> support a file truncation to zero size for device aliasing files.
> 
> Signed-off-by: Daeho Jeong <daehojeong@google.com>
> ---
>  fs/f2fs/file.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
> index f92a9fba9991..7ae5a5af5ed9 100644
> --- a/fs/f2fs/file.c
> +++ b/fs/f2fs/file.c
> @@ -1036,7 +1036,7 @@ int f2fs_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
>  
>  	if ((attr->ia_valid & ATTR_SIZE)) {
>  		if (!f2fs_is_compress_backend_ready(inode) ||
> -				IS_DEVICE_ALIASING(inode))
> +				(IS_DEVICE_ALIASING(inode) && attr->ia_size))
>  			return -EOPNOTSUPP;
>  		if (is_inode_flag_set(inode, FI_COMPRESS_RELEASED) &&
>  			!IS_ALIGNED(attr->ia_size,
> @@ -1117,6 +1117,9 @@ int f2fs_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
>  		if (err)
>  			return err;

Daeho,

If truncate(, 0) failed due to some reasons, maybe, the file was partially
truncated, should we tag it as inconsistent status to avoid its later access?
thoughts?

Thanks,

>  
> +		if (IS_DEVICE_ALIASING(inode))
> +			f2fs_destroy_extent_tree(inode);
> +
>  		spin_lock(&fi->i_size_lock);
>  		inode_set_mtime_to_ts(inode, inode_set_ctime_current(inode));
>  		fi->last_disk_size = i_size_read(inode);


