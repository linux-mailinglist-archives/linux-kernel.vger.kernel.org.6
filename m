Return-Path: <linux-kernel+bounces-362036-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E298899B02E
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Oct 2024 04:42:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E890281E14
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Oct 2024 02:42:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10C09175BF;
	Sat, 12 Oct 2024 02:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PLXC7fRF"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F7F013FEE
	for <linux-kernel@vger.kernel.org>; Sat, 12 Oct 2024 02:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728700972; cv=none; b=PATeLww01RUVW1oro1u7/LngGDMbNfNDEJsa6KpJvg9qgiZ4fI2ksHGGPo77NH8kTkg5aZRqy9fCgelnS0TMrSSvcyimar9aUMhVVVwO/eWi7EZVnEU9XglqphBpFOct6YsGTjXR4RKXwoZ6ub2jN686Ph2zXYZa3M/3DdLz3M0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728700972; c=relaxed/simple;
	bh=RLEiaGtYnac6iCX6YR/4UajVQiUmwCqXjMwt4XIFwvc=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=k8auuS0tWTlknQrcY83OrdEJ88XsglC1dYvpKfHJQ0wcSc7qiIuEYp+f4w8qt28PQT+JPLRfXXBv7gSirlFSPdsgHG8UypwnNFBxc2Tk/OdLlx2JkQQ9VcnChzh1VGbup7YEbRU599AlJhqQWk6Qd4lr0jRvA0TFt38ivYuH9yg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PLXC7fRF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5228C4CEC3;
	Sat, 12 Oct 2024 02:42:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728700972;
	bh=RLEiaGtYnac6iCX6YR/4UajVQiUmwCqXjMwt4XIFwvc=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=PLXC7fRFdDaVXaBdnxSaV+RYffrIakbMmtz6kNdxO/mD9fI6WCod3jhIIinNAPDDl
	 XKmp4WN3WUCvwEYjE0MBDrnoUon/xu037rx4lbLx0UXNGKgh842s/rAWX4KTtHqKqQ
	 ckeaUH6ybsAskP0M3bXChrJZSTNpy++Nbt3gbcWRbuxZjYIQbRvfxkcrpao87aeHTy
	 NdF6ZYE833keQ4Upuo3Iv1eZFlFZ8hRX7LjL7djidnjwWUKzwCSbcreENLWxO8v0nc
	 DgyqDE5hiEG9C1AAxYqdgc/8BfsqMJ0YZ2hOQN4hsc95jEb/QH/caAVdGQMH/cK2Ws
	 bWfAsLHsMisXQ==
Message-ID: <64487878-21fb-4679-ac1c-ce24c02a3e64@kernel.org>
Date: Sat, 12 Oct 2024 10:42:48 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: Chao Yu <chao@kernel.org>, linux-f2fs-devel@lists.sourceforge.net,
 linux-kernel@vger.kernel.org, zhangxiaoxu5@huawei.com
Subject: Re: [PATCH] f2fs: fix null-ptr-deref in f2fs_submit_page_bio()
To: Ye Bin <yebin@huaweicloud.com>, jaegeuk@kernel.org
References: <20241011164450.3366215-1-yebin@huaweicloud.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20241011164450.3366215-1-yebin@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/10/12 0:44, Ye Bin wrote:
> From: Ye Bin <yebin10@huawei.com>
> 
> There's issue as follows when concurrently installing the f2fs.ko
> module and mounting the f2fs file system:
> KASAN: null-ptr-deref in range [0x0000000000000020-0x0000000000000027]
> RIP: 0010:__bio_alloc+0x2fb/0x6c0 [f2fs]
> Call Trace:
>   <TASK>
>   f2fs_submit_page_bio+0x126/0x8b0 [f2fs]
>   __get_meta_page+0x1d4/0x920 [f2fs]
>   get_checkpoint_version.constprop.0+0x2b/0x3c0 [f2fs]
>   validate_checkpoint+0xac/0x290 [f2fs]
>   f2fs_get_valid_checkpoint+0x207/0x950 [f2fs]
>   f2fs_fill_super+0x1007/0x39b0 [f2fs]
>   mount_bdev+0x183/0x250
>   legacy_get_tree+0xf4/0x1e0
>   vfs_get_tree+0x88/0x340
>   do_new_mount+0x283/0x5e0
>   path_mount+0x2b2/0x15b0
>   __x64_sys_mount+0x1fe/0x270
>   do_syscall_64+0x5f/0x170
>   entry_SYSCALL_64_after_hwframe+0x76/0x7e
> 
> Above issue happens as the biset of the f2fs file system is not
> initialized before register "f2fs_fs_type".
> To address above issue just register "f2fs_fs_type" at the last in
> init_f2fs_fs(). Ensure that all f2fs file system resources are
> initialized.
> 
> Fixes: f543805fcd60 ("f2fs: introduce private bioset")
> Signed-off-by: Ye Bin <yebin10@huawei.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,

