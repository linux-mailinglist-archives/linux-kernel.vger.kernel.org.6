Return-Path: <linux-kernel+bounces-572123-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 517D6A6C6C3
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Mar 2025 01:54:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6B1D47A9259
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Mar 2025 00:53:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4FE2F507;
	Sat, 22 Mar 2025 00:54:18 +0000 (UTC)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F33B9BA42
	for <linux-kernel@vger.kernel.org>; Sat, 22 Mar 2025 00:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742604858; cv=none; b=QF2oFqQro1bJv2M+1/bTlNSjFjoxpbRmOzk7AnQXhdehS825plBITVoFy/ybopAQhpr5VM0cVXqnpXswQ6AIbav+PoiHSfsTO3rVm1WR2SuSoA7Z6NwUEztKD6Jk1UI/IOW/p/+VBDrDw8fIKGnmJwgyc2QB12iOqHAJZkPFypo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742604858; c=relaxed/simple;
	bh=FNz8ToESztnmuyyIUT6c2xRymqpqtINQMT3FlbHl1aI=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=uiqJR8MsJZPvNBn9LWdjBWTCnO5sxZoF126zET2+DWiOT9PVNuZrcZodiB1Yf7BWtRYgqhbKjaD1elSfN39fDYIFZOT0FaYl5CY1V9Ix3dzZzH2+ng/3teAbZCPrrV0j29RivzcRjYvWNt+xXLMxxi/oq99SeTXUPcg0nblCC8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4ZKLM315P7zvWrq;
	Sat, 22 Mar 2025 08:50:07 +0800 (CST)
Received: from kwepemo500009.china.huawei.com (unknown [7.202.194.199])
	by mail.maildlp.com (Postfix) with ESMTPS id F39791800B2;
	Sat, 22 Mar 2025 08:54:01 +0800 (CST)
Received: from [10.67.111.104] (10.67.111.104) by
 kwepemo500009.china.huawei.com (7.202.194.199) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Sat, 22 Mar 2025 08:54:01 +0800
Message-ID: <b235f795-3e1d-4a91-88dd-651bf9d75a17@huawei.com>
Date: Sat, 22 Mar 2025 08:54:00 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v6 1/7] erofs: move `struct erofs_anon_fs_type` to
 super.c
To: Hongzhen Luo <hongzhen@linux.alibaba.com>, <linux-erofs@lists.ozlabs.org>
CC: <linux-kernel@vger.kernel.org>
References: <20250301145002.2420830-1-hongzhen@linux.alibaba.com>
 <20250301145002.2420830-2-hongzhen@linux.alibaba.com>
Content-Language: en-US
From: Hongbo Li <lihongbo22@huawei.com>
In-Reply-To: <20250301145002.2420830-2-hongzhen@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemo500009.china.huawei.com (7.202.194.199)



On 2025/3/1 22:49, Hongzhen Luo wrote:
> Move the `struct erofs_anon_fs_type` to the super.c and
> expose it in preparation for the upcoming page cache share
> feature.
> 
> Signed-off-by: Hongzhen Luo <hongzhen@linux.alibaba.com>

Looks good. Feel free to add:

Reviewed-by: Hongbo Li <lihongbo22@huawei.com>

> ---
>   fs/erofs/fscache.c  | 13 -------------
>   fs/erofs/internal.h |  2 ++
>   fs/erofs/super.c    | 13 +++++++++++++
>   3 files changed, 15 insertions(+), 13 deletions(-)
> 
> diff --git a/fs/erofs/fscache.c b/fs/erofs/fscache.c
> index ce3d8737df85..ae7bd9ebff38 100644
> --- a/fs/erofs/fscache.c
> +++ b/fs/erofs/fscache.c
> @@ -3,7 +3,6 @@
>    * Copyright (C) 2022, Alibaba Cloud
>    * Copyright (C) 2022, Bytedance Inc. All rights reserved.
>    */
> -#include <linux/pseudo_fs.h>
>   #include <linux/fscache.h>
>   #include "internal.h"
>   
> @@ -13,18 +12,6 @@ static LIST_HEAD(erofs_domain_list);
>   static LIST_HEAD(erofs_domain_cookies_list);
>   static struct vfsmount *erofs_pseudo_mnt;
>   
> -static int erofs_anon_init_fs_context(struct fs_context *fc)
> -{
> -	return init_pseudo(fc, EROFS_SUPER_MAGIC) ? 0 : -ENOMEM;
> -}
> -
> -static struct file_system_type erofs_anon_fs_type = {
> -	.owner		= THIS_MODULE,
> -	.name           = "pseudo_erofs",
> -	.init_fs_context = erofs_anon_init_fs_context,
> -	.kill_sb        = kill_anon_super,
> -};
> -
>   struct erofs_fscache_io {
>   	struct netfs_cache_resources cres;
>   	struct iov_iter		iter;
> diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
> index 686d835eb533..47004eb89838 100644
> --- a/fs/erofs/internal.h
> +++ b/fs/erofs/internal.h
> @@ -379,6 +379,8 @@ extern const struct file_operations erofs_dir_fops;
>   
>   extern const struct iomap_ops z_erofs_iomap_report_ops;
>   
> +extern struct file_system_type erofs_anon_fs_type;
> +
>   /* flags for erofs_fscache_register_cookie() */
>   #define EROFS_REG_COOKIE_SHARE		0x0001
>   #define EROFS_REG_COOKIE_NEED_NOEXIST	0x0002
> diff --git a/fs/erofs/super.c b/fs/erofs/super.c
> index 827b62665649..eb052a770088 100644
> --- a/fs/erofs/super.c
> +++ b/fs/erofs/super.c
> @@ -11,6 +11,7 @@
>   #include <linux/fs_parser.h>
>   #include <linux/exportfs.h>
>   #include <linux/backing-dev.h>
> +#include <linux/pseudo_fs.h>
>   #include "xattr.h"
>   
>   #define CREATE_TRACE_POINTS
> @@ -850,6 +851,18 @@ static struct file_system_type erofs_fs_type = {
>   };
>   MODULE_ALIAS_FS("erofs");
>   
> +static int erofs_anon_init_fs_context(struct fs_context *fc)
> +{
> +	return init_pseudo(fc, EROFS_SUPER_MAGIC) ? 0 : -ENOMEM;
> +}
> +
> +struct file_system_type erofs_anon_fs_type = {
> +	.owner		= THIS_MODULE,
> +	.name           = "pseudo_erofs",
> +	.init_fs_context = erofs_anon_init_fs_context,
> +	.kill_sb        = kill_anon_super,
> +};
> +
>   static int __init erofs_module_init(void)
>   {
>   	int err;

