Return-Path: <linux-kernel+bounces-271266-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9C48944BCE
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 14:56:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 39AE1B2713A
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 12:56:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8612A19EEC6;
	Thu,  1 Aug 2024 12:56:39 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD5B8208D1
	for <linux-kernel@vger.kernel.org>; Thu,  1 Aug 2024 12:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722516998; cv=none; b=DOBLU4QtYyU23rWs5Pbu5+8wiFD1lRKvOFI1H99WA97M7lpkYMPaVUCOcLEiNbdAHQO8xoK++p/3spx4uU5TJn+XYmx3L16x40i3h0x0cu7C+TXzHBIYKiTGUjxODOPRR5JXEtr/qXx6tJ6bYw9YGs2z6EGHcZy3BgBpit6RNYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722516998; c=relaxed/simple;
	bh=xEhmB39UoUaqpTGhVLxj3Ydk7VUfuybDDHz0jF0wDYI=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=XmPZ/xWlN4UI478IdjhZ9CRq6zhkokf3IdeNgj6Lyn6a+fBvHeiPBZMCJ7kHAiic+uYJUaTyxbHRTCm6Z27F/i17T5y2wZZ1SZX4dgg+DbS1OvjLBaVbd77mnQhP1WdV1EpWPShCPB8Lf1PKOnwcS6L7OxBG75AIU2kFNBiHYlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4WZTTc17N1zndMf;
	Thu,  1 Aug 2024 20:55:32 +0800 (CST)
Received: from dggpeml500022.china.huawei.com (unknown [7.185.36.66])
	by mail.maildlp.com (Postfix) with ESMTPS id 4590E180106;
	Thu,  1 Aug 2024 20:56:33 +0800 (CST)
Received: from [10.67.111.104] (10.67.111.104) by
 dggpeml500022.china.huawei.com (7.185.36.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 1 Aug 2024 20:56:33 +0800
Message-ID: <d783ea02-5834-40e5-87e7-5aaf8da63150@huawei.com>
Date: Thu, 1 Aug 2024 20:56:32 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v2 1/2] erofs: introduce page cache share feature
Content-Language: en-US
To: Hongzhen Luo <hongzhen@linux.alibaba.com>, <linux-erofs@lists.ozlabs.org>
CC: <linux-kernel@vger.kernel.org>
References: <20240731080704.678259-1-hongzhen@linux.alibaba.com>
 <20240731080704.678259-2-hongzhen@linux.alibaba.com>
From: Hongbo Li <lihongbo22@huawei.com>
In-Reply-To: <20240731080704.678259-2-hongzhen@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpeml500022.china.huawei.com (7.185.36.66)



On 2024/7/31 16:07, Hongzhen Luo wrote:
> Currently, reading files with different paths (or names) but the same
> content will consume multiple copies of the page cache, even if the
> content of these page caches is the same. For example, reading identical
> files (e.g., *.so files) from two different minor versions of container
> images will cost multiple copies of the same page cache, since different
> containers have different mount points. Therefore, sharing the page cache
> for files with the same content can save memory.
> 
> This introduces the page cache share feature in erofs. During the mkfs
> phase, file content is hashed and the hash value is stored in the
> `trusted.erofs.fingerprint` extended attribute. Inodes of files with the
> same `trusted.erofs.fingerprint` are mapped to a list. One of these inodes
> that in the list (the first inode in this implementation) is used to store
> the actual content. In this way, a single copy of the selected inode's
> page cache can serve read requests from several files mapped to it.
> 
> Below is the memory usage for reading all files in two different minor
> versions of container images:
> 
> +-------------------+------------------+-------------+---------------+
> |       Image       | Page Cache Share | Memory (MB) |    Memory     |
> |                   |                  |             | Reduction (%) |
> +-------------------+------------------+-------------+---------------+
> |                   |        No        |     241     |       -       |
> |       redis       +------------------+-------------+---------------+
> |   7.2.4 & 7.2.5   |        Yes       |     163     |      33%      |
> +-------------------+------------------+-------------+---------------+
> |                   |        No        |     872     |       -       |
> |      postgres     +------------------+-------------+---------------+
> |    16.1 & 16.2    |        Yes       |     630     |      28%      |
> +-------------------+------------------+-------------+---------------+
> |                   |        No        |     2771    |       -       |
> |     tensorflow    +------------------+-------------+---------------+
> |  1.11.0 & 2.11.1  |        Yes       |     2340    |      16%      |
> +-------------------+------------------+-------------+---------------+
> |                   |        No        |     926     |       -       |
> |       mysql       +------------------+-------------+---------------+
> |  8.0.11 & 8.0.12  |        Yes       |     735     |      21%      |
> +-------------------+------------------+-------------+---------------+
> |                   |        No        |     390     |       -       |
> |       nginx       +------------------+-------------+---------------+
> |   7.2.4 & 7.2.5   |        Yes       |     219     |      44%      |
> +-------------------+------------------+-------------+---------------+
> |       tomcat      |        No        |     924     |       -       |
> | 10.1.25 & 10.1.26 +------------------+-------------+---------------+
> |                   |        Yes       |     474     |      49%      |
> +-------------------+------------------+-------------+---------------+
> 
> Additionally, the table below shows the runtime memory usage of the
> container:
> 
> +-------------------+------------------+-------------+---------------+
> |       Image       | Page Cache Share | Memory (MB) |    Memory     |
> |                   |                  |             | Reduction (%) |
> +-------------------+------------------+-------------+---------------+
> |                   |        No        |      35     |       -       |
> |       redis       +------------------+-------------+---------------+
> |   7.2.4 & 7.2.5   |        Yes       |      28     |      20%      |
> +-------------------+------------------+-------------+---------------+
> |                   |        No        |     149     |       -       |
> |      postgres     +------------------+-------------+---------------+
> |    16.1 & 16.2    |        Yes       |      95     |      37%      |
> +-------------------+------------------+-------------+---------------+
> |                   |        No        |     1028    |       -       |
> |     tensorflow    +------------------+-------------+---------------+
> |  1.11.0 & 2.11.1  |        Yes       |     941     |       9%      |
> +-------------------+------------------+-------------+---------------+
> |                   |        No        |     155     |       -       |
> |       mysql       +------------------+-------------+---------------+
> |  8.0.11 & 8.0.12  |        Yes       |     139     |      11%      |
> +-------------------+------------------+-------------+---------------+
> |                   |        No        |      25     |       -       |
> |       nginx       +------------------+-------------+---------------+
> |   7.2.4 & 7.2.5   |        Yes       |      20     |      23%      |
> +-------------------+------------------+-------------+---------------+
> |       tomcat      |        No        |     186     |       -       |
> | 10.1.25 & 10.1.26 +------------------+-------------+---------------+
> |                   |        Yes       |      98     |      48%      |
> +-------------------+------------------+-------------+---------------+
> 
> Signed-off-by: Hongzhen Luo <hongzhen@linux.alibaba.com>
> ---
> v2: Refactored the implementation.
> v1: https://lore.kernel.org/all/20240722065355.1396365-4-hongzhen@linux.alibaba.com/
> ---
>   fs/erofs/Kconfig           |  10 ++
>   fs/erofs/Makefile          |   1 +
>   fs/erofs/internal.h        |   8 ++
>   fs/erofs/pagecache_share.c | 189 +++++++++++++++++++++++++++++++++++++
>   fs/erofs/pagecache_share.h |  15 +++
>   5 files changed, 223 insertions(+)
>   create mode 100644 fs/erofs/pagecache_share.c
>   create mode 100644 fs/erofs/pagecache_share.h
> 
> diff --git a/fs/erofs/Kconfig b/fs/erofs/Kconfig
> index 7dcdce660cac..756a74de623c 100644
> --- a/fs/erofs/Kconfig
> +++ b/fs/erofs/Kconfig
> @@ -158,3 +158,13 @@ config EROFS_FS_PCPU_KTHREAD_HIPRI
>   	  at higher priority.
>   
>   	  If unsure, say N.
> +
> +config EROFS_FS_PAGE_CACHE_SHARE
> +       bool "EROFS page cache share support"
> +       depends on EROFS_FS
> +       default n
> +	help
> +	  This permits EROFS to share page cache for files with same
> +	  fingerprints.
> +
> +	  If unsure, say N.
> diff --git a/fs/erofs/Makefile b/fs/erofs/Makefile
> index 097d672e6b14..f14a2ac0e561 100644
> --- a/fs/erofs/Makefile
> +++ b/fs/erofs/Makefile
> @@ -8,3 +8,4 @@ erofs-$(CONFIG_EROFS_FS_ZIP_LZMA) += decompressor_lzma.o
>   erofs-$(CONFIG_EROFS_FS_ZIP_DEFLATE) += decompressor_deflate.o
>   erofs-$(CONFIG_EROFS_FS_ZIP_ZSTD) += decompressor_zstd.o
>   erofs-$(CONFIG_EROFS_FS_ONDEMAND) += fscache.o
> +erofs-$(CONFIG_EROFS_FS_PAGE_CACHE_SHARE) += pagecache_share.o
> diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
> index 736607675396..e3c17b28d1c5 100644
> --- a/fs/erofs/internal.h
> +++ b/fs/erofs/internal.h
> @@ -288,6 +288,13 @@ struct erofs_inode {
>   		};
>   #endif	/* CONFIG_EROFS_FS_ZIP */
>   	};
> +#ifdef CONFIG_EROFS_FS_PAGE_CACHE_SHARE
> +	struct list_head pcs_list;
> +	struct rw_semaphore pcs_rwsem;
> +	char *fprt;
> +	int fprt_len;
> +	unsigned long fprt_hash;
> +#endif
>   	/* the corresponding vfs inode */
>   	struct inode vfs_inode;
>   };
> @@ -383,6 +390,7 @@ extern const struct inode_operations erofs_fast_symlink_iops;
>   extern const struct inode_operations erofs_dir_iops;
>   
>   extern const struct file_operations erofs_file_fops;
> +extern const struct file_operations erofs_pcs_file_fops;
>   extern const struct file_operations erofs_dir_fops;
>   
>   extern const struct iomap_ops z_erofs_iomap_report_ops;
> diff --git a/fs/erofs/pagecache_share.c b/fs/erofs/pagecache_share.c
> new file mode 100644
> index 000000000000..985dd2a38b5e
> --- /dev/null
> +++ b/fs/erofs/pagecache_share.c
> @@ -0,0 +1,189 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (C) 2024, Alibaba Cloud
> + */
> +#include <linux/xarray.h>
> +#include <linux/mutex.h>
> +#include <linux/xxhash.h>
> +#include "internal.h"
> +#include "xattr.h"
> +#include "pagecache_share.h"
> +
> +struct erofs_pcs_lhead {
> +	struct mutex lmutex;
> +	struct list_head list;
> +};
> +
> +#define PCS_FPRT_IDX	4
> +#define PCS_FPRT_NAME	"erofs.fingerprint"
This macro should be "trusted.erofs.fingerprint"
> +#define PCS_FPRT_MAXLEN 1024
> +
> +DEFINE_XARRAY(pcs_xarray);
> +
> +void erofs_pcs_fill_inode(struct inode *inode)
> +{
> +	struct erofs_inode *vi = EROFS_I(inode);
> +	char fprt[PCS_FPRT_MAXLEN];
> +
> +	vi->fprt_len = erofs_getxattr(inode, PCS_FPRT_IDX, PCS_FPRT_NAME, fprt,
> +				      PCS_FPRT_MAXLEN);
> +	if (vi->fprt_len > 0 && vi->fprt_len <= PCS_FPRT_MAXLEN) {
> +		vi->fprt = kmalloc(vi->fprt_len, GFP_KERNEL);
> +		if (IS_ERR(vi->fprt)) {
> +			vi->fprt_len = -1;
> +			return;
> +		}
> +		memcpy(vi->fprt, fprt, vi->fprt_len);
This could use strscpy or other string copy function to avoid random 
garbage beyond a string's null terminator.
> +		vi->fprt_hash = xxh32(vi->fprt, vi->fprt_len, 0);
> +	}
> +}
> +
> +int erofs_pcs_add(struct inode *inode)
> +{
> +	struct erofs_inode *vi = EROFS_I(inode);
> +	struct erofs_pcs_lhead *lst;
> +
> +	xa_lock(&pcs_xarray);
> +	lst = xa_load(&pcs_xarray, vi->fprt_hash);
> +	if (!lst) {
> +		lst = kmalloc(sizeof(struct erofs_pcs_lhead), GFP_KERNEL);
> +		if (!lst) {
> +			xa_unlock(&pcs_xarray);
> +			return -ENOMEM;
> +		}
> +		mutex_init(&lst->lmutex);
> +		INIT_LIST_HEAD(&lst->list);
> +		/* we have already held the xa_lock here */
> +		__xa_store(&pcs_xarray, vi->fprt_hash, lst, GFP_KERNEL);
Here, fprt_hash is calculated with xxh32, if hash conflict happend, the 
fprt_hash will be same, and the value in xarray also will be replaced. 
How can we avoid this case?
> +	}
> +	xa_unlock(&pcs_xarray);
> +
> +	mutex_lock(&lst->lmutex);
> +	list_add_tail(&vi->pcs_list, &lst->list);
> +	mutex_unlock(&lst->lmutex);
> +	return 0;
> +}
> +
> +int erofs_pcs_remove(struct inode *inode)
> +{
> +	struct erofs_inode *vi = EROFS_I(inode);
> +	struct erofs_pcs_lhead *lst = xa_load(&pcs_xarray, vi->fprt_hash);
This operation should hold the xarray lock.
> +
> +	if (!lst || list_empty(&lst->list))
> +		return -EINVAL;
This part should not happen, right? Unless there is a problem with the 
code logic, and the remove operation seems unnecessary to return a value.
> +
> +	mutex_lock(&lst->lmutex);
> +	down_write(&vi->pcs_rwsem);
> +	list_del(&vi->pcs_list);
> +	up_write(&vi->pcs_rwsem);
> +	mutex_unlock(&lst->lmutex);
> +
> +	xa_lock(&pcs_xarray);
> +	if (list_empty(&lst->list)) {
> +		__xa_erase(&pcs_xarray, vi->fprt_hash);
> +		kfree(lst);
> +	}
> +	xa_unlock(&pcs_xarray);
> +	return 0;
> +}
> +
> +static struct inode *erofs_pcs_get4read(struct inode *inode)
> +{
> +	struct erofs_inode *vi = EROFS_I(inode), *pcs_inode = NULL, *p, *tmp;
This should be locked xarray here? Otherwise, how can we prevent another 
thread deleting from the pcs_xarray?
> +	struct erofs_pcs_lhead *lst = xa_load(&pcs_xarray, vi->fprt_hash);
> +
> +	if (!lst || list_empty(&lst->list))
> +		return ERR_PTR(-EINVAL);
> +
> +	mutex_lock(&lst->lmutex);
> +	list_for_each_entry_safe(p, tmp, &lst->list, pcs_list) {
> +		if (vi->fprt_len == p->fprt_len &&
> +			!memcmp(vi->fprt, p->fprt, p->fprt_len)) {
use string compare helper?
> +			pcs_inode = p;
> +			break;
> +		}
> +	}
> +	if (pcs_inode)
> +		down_read(&pcs_inode->pcs_rwsem);
> +	mutex_unlock(&lst->lmutex);
> +
> +	return pcs_inode ? &pcs_inode->vfs_inode : ERR_PTR(-EINVAL);
> +}
> +
> +static int erofs_pcs_file_open(struct inode *inode, struct file *file)
> +{
> +	struct inode *pcs_inode;
> +	struct file *ano_file;
> +
> +	pcs_inode = erofs_pcs_get4read(inode);
> +	if (IS_ERR(pcs_inode))
> +		return PTR_ERR(pcs_inode);
> +
> +	ano_file = alloc_file_pseudo(pcs_inode, file->f_path.mnt, "[erofs_pcs_f]",
> +				     O_RDONLY, &erofs_file_fops);
> +	file_ra_state_init(&ano_file->f_ra, file->f_mapping);
> +	ihold(pcs_inode);
> +	file->private_data = (void *)ano_file;
> +	return 0;
> +}
> +
> +static int erofs_pcs_file_release(struct inode *inode, struct file *file)
> +{
> +	struct inode *pcs_inode;
> +
> +	if (!file->private_data)
> +		return -EINVAL;
> +	pcs_inode = ((struct file *)file->private_data)->f_inode;
> +	up_read(&EROFS_I(pcs_inode)->pcs_rwsem);
> +	fput((struct file *)file->private_data);
> +	file->private_data = NULL;
> +	return 0;
> +}
> +
> +static ssize_t erofs_pcs_file_read_iter(struct kiocb *iocb,
> +					struct iov_iter *to)
> +{
> +	struct file *file, *ano_file;
> +	struct kiocb ano_iocb;
> +	ssize_t res;
> +
> +	memcpy(&ano_iocb, iocb, sizeof(struct kiocb));
> +	file = iocb->ki_filp;
> +	ano_file = file->private_data;
> +	if (!ano_file)
> +		return -EINVAL;
> +	ano_iocb.ki_filp = ano_file;
> +	res = filemap_read(&ano_iocb, to, 0);
> +	memcpy(iocb, &ano_iocb, sizeof(struct kiocb));
> +	iocb->ki_filp = file;
> +	file_accessed(file);
> +	return res;
> +}
> +
> +static vm_fault_t erofs_pcs_fault(struct vm_fault *vmf)
> +{
> +	return filemap_fault(vmf);
> +}
This helper is unnecessary. We could just assign the default fault helper.
> +
> +static const struct vm_operations_struct erofs_pcs_file_vm_ops = {
> +	.fault = erofs_pcs_fault,
If .map_pages not assigned, the fault around should not arouse.
> +};
> +
> +static int erofs_pcs_mmap(struct file *file, struct vm_area_struct *vma)
> +{
> +	struct file *ano_file = file->private_data;
> +
> +	vma_set_file(vma, ano_file);
> +	vma->vm_ops = &erofs_pcs_file_vm_ops;
> +	return 0;
> +}
> +
> +const struct file_operations erofs_pcs_file_fops = {
> +	.open		= erofs_pcs_file_open,
> +	.llseek		= generic_file_llseek,
> +	.read_iter	= erofs_pcs_file_read_iter,
> +	.mmap		= erofs_pcs_mmap,
> +	.release	= erofs_pcs_file_release,
> +	.get_unmapped_area = thp_get_unmapped_area,
> +	.splice_read	= filemap_splice_read,
> +};
> diff --git a/fs/erofs/pagecache_share.h b/fs/erofs/pagecache_share.h
> new file mode 100644
> index 000000000000..fb75ae3abd8a
> --- /dev/null
> +++ b/fs/erofs/pagecache_share.h
> @@ -0,0 +1,15 @@
> +/* SPDX-License-Identifier: GPL-2.0-or-later */
> +/*
> + * Copyright (C) 2024, Alibaba Cloud
> + */
> +#ifndef __EROFS_PAGECACHE_SHARE_H
> +#define __EROFS_PAGECACHE_SHARE_H
> +
> +#include <linux/mutex.h>
> +#include "internal.h"
> +
> +void erofs_pcs_fill_inode(struct inode *inode);
> +int erofs_pcs_add(struct inode *inode);
> +int erofs_pcs_remove(struct inode *inode);
> +
> +#endif

