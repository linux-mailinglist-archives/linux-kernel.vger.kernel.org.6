Return-Path: <linux-kernel+bounces-271247-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D7E8F944B98
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 14:43:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CC3D1B25229
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 12:43:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B58671A01DB;
	Thu,  1 Aug 2024 12:43:43 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF6AE194AE6
	for <linux-kernel@vger.kernel.org>; Thu,  1 Aug 2024 12:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722516223; cv=none; b=uTvVSODYin1a/pQBydFIV+3D/LMhyaDIoimYssqsP+w4Gn4pREF0awdwWkwopfOLMQoMvDGxOE1rLuZi0otwVdSBuona1ZZURhNM+r0ZDHKGlzEuV3Qlo+yCp/8Rb62ToL9jVA1CU676rfCcEYEd2w0MtvjA9/fWYkcDej+15QM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722516223; c=relaxed/simple;
	bh=mjtYasuRLEP9prqiXpnjS2+CP++nUycQh8EAJezdesM=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=QoVv/0MdZtX8aoVsoXCh5WDV7ianW+WL61JIMGLrZF9HF/hMIXNWSh4sJ0QcMXJnuwn2kucz9OYBAOej9AV4pKJ/cAeXtclUpNTBm6LgNygTYzZ4RltIzW+WFbU68YOK8uUaDvftxxJEeZN5M21VybGjBhMso/BZ3wMiAIrdhRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4WZTBh6WklzncQd;
	Thu,  1 Aug 2024 20:42:36 +0800 (CST)
Received: from dggpeml500022.china.huawei.com (unknown [7.185.36.66])
	by mail.maildlp.com (Postfix) with ESMTPS id 07DA618006C;
	Thu,  1 Aug 2024 20:43:38 +0800 (CST)
Received: from [10.67.111.104] (10.67.111.104) by
 dggpeml500022.china.huawei.com (7.185.36.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 1 Aug 2024 20:43:37 +0800
Message-ID: <5796c9ad-04ba-4226-ad28-75b265a4157b@huawei.com>
Date: Thu, 1 Aug 2024 20:43:37 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v2 2/2] erofs: apply the page cache share feature
Content-Language: en-US
To: Hongzhen Luo <hongzhen@linux.alibaba.com>, <linux-erofs@lists.ozlabs.org>
CC: <linux-kernel@vger.kernel.org>
References: <20240731080704.678259-1-hongzhen@linux.alibaba.com>
 <20240731080704.678259-3-hongzhen@linux.alibaba.com>
From: Hongbo Li <lihongbo22@huawei.com>
In-Reply-To: <20240731080704.678259-3-hongzhen@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpeml500022.china.huawei.com (7.185.36.66)



On 2024/7/31 16:07, Hongzhen Luo wrote:
> This modifies relevant functions to apply the page cache
> share feature.
> 
> Signed-off-by: Hongzhen Luo <hongzhen@linux.alibaba.com>
> ---
> v2: Make adjustments based on the latest implementation.
> v1: https://lore.kernel.org/all/20240722065355.1396365-5-hongzhen@linux.alibaba.com/
> ---
>   fs/erofs/inode.c | 23 +++++++++++++++++++++++
>   fs/erofs/super.c | 23 +++++++++++++++++++++++
>   2 files changed, 46 insertions(+)
> 
> diff --git a/fs/erofs/inode.c b/fs/erofs/inode.c
> index 5f6439a63af7..9f1e7332cff9 100644
> --- a/fs/erofs/inode.c
> +++ b/fs/erofs/inode.c
> @@ -5,6 +5,7 @@
>    * Copyright (C) 2021, Alibaba Cloud
>    */
>   #include "xattr.h"
> +#include "pagecache_share.h"
>   
>   #include <trace/events/erofs.h>
>   
> @@ -229,10 +230,22 @@ static int erofs_fill_inode(struct inode *inode)
>   	switch (inode->i_mode & S_IFMT) {
>   	case S_IFREG:
>   		inode->i_op = &erofs_generic_iops;
> +#ifdef CONFIG_EROFS_FS_PAGE_CACHE_SHARE
> +		erofs_pcs_fill_inode(inode);
> +#endif
>   		if (erofs_inode_is_data_compressed(vi->datalayout))
>   			inode->i_fop = &generic_ro_fops;
> +#ifdef CONFIG_EROFS_FS_PAGE_CACHE_SHARE
> +		else {
If the compress data is not support, the erofs_pcs_fill_inode should 
fill the fingerprint in this branch only.
> +			if (vi->fprt_len > 0)
> +				inode->i_fop = &erofs_pcs_file_fops;
> +			else
> +				inode->i_fop = &erofs_file_fops;
> +		}
> +#else
>   		else
>   			inode->i_fop = &erofs_file_fops;
> +#endif
>   		break;
>   	case S_IFDIR:
>   		inode->i_op = &erofs_dir_iops;
> @@ -325,6 +338,16 @@ struct inode *erofs_iget(struct super_block *sb, erofs_nid_t nid)
>   			return ERR_PTR(err);
>   		}
>   		unlock_new_inode(inode);
> +#ifdef CONFIG_EROFS_FS_PAGE_CACHE_SHARE
> +		if ((inode->i_mode & S_IFMT) == S_IFREG &&may be S_ISREG macro is better.

> +		    EROFS_I(inode)->fprt_len > 0) {
Perhaps this logic need to be enclosed within unlock_new_inode.
> +			err = erofs_pcs_add(inode);
> +			if (err) {
> +				iget_failed(inode);
> +				return ERR_PTR(err);
> +			}
> +		}
> +#endif
>   	}
>   	return inode;
>   }
> diff --git a/fs/erofs/super.c b/fs/erofs/super.c
> index 35268263aaed..a42e65ef7fc7 100644
> --- a/fs/erofs/super.c
> +++ b/fs/erofs/super.c
> @@ -11,6 +11,7 @@
>   #include <linux/fs_parser.h>
>   #include <linux/exportfs.h>
>   #include "xattr.h"
> +#include "pagecache_share.h"
>   
>   #define CREATE_TRACE_POINTS
>   #include <trace/events/erofs.h>
> @@ -95,6 +96,10 @@ static struct inode *erofs_alloc_inode(struct super_block *sb)
>   
>   	/* zero out everything except vfs_inode */
>   	memset(vi, 0, offsetof(struct erofs_inode, vfs_inode));
> +#ifdef CONFIG_EROFS_FS_PAGE_CACHE_SHARE
> +	INIT_LIST_HEAD(&vi->pcs_list);
> +	init_rwsem(&vi->pcs_rwsem);
> +#endif
>   	return &vi->vfs_inode;
>   }
>   
> @@ -108,6 +113,21 @@ static void erofs_free_inode(struct inode *inode)
>   	kmem_cache_free(erofs_inode_cachep, vi);
>   }
>   
> +#ifdef CONFIG_EROFS_FS_PAGE_CACHE_SHARE
> +static void erofs_destroy_inode(struct inode *inode)
> +{
> +	struct erofs_inode *vi = EROFS_I(inode);
> +
> +	if ((inode->i_mode & S_IFMT) == S_IFREG &&
using S_ISREG macro is better.
> +	    EROFS_I(inode)->fprt_len > 0) {
> +		if (erofs_pcs_remove(inode))
> +			erofs_err(inode->i_sb, "pcs: fail to remove inode.");
> +		kfree(vi->fprt);
> +		vi->fprt = NULL;
> +	}
> +}
> +#endif
> +
>   static bool check_layout_compatibility(struct super_block *sb,
>   				       struct erofs_super_block *dsb)
>   {
> @@ -937,6 +957,9 @@ static int erofs_show_options(struct seq_file *seq, struct dentry *root)
>   const struct super_operations erofs_sops = {
>   	.put_super = erofs_put_super,
>   	.alloc_inode = erofs_alloc_inode,
> +#ifdef CONFIG_EROFS_FS_PAGE_CACHE_SHARE
> +	.destroy_inode = erofs_destroy_inode,
> +#endif
>   	.free_inode = erofs_free_inode,
>   	.statfs = erofs_statfs,
>   	.show_options = erofs_show_options,

