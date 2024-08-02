Return-Path: <linux-kernel+bounces-272114-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4981B945732
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 06:50:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BFDDC1F245EF
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 04:50:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A580F208A5;
	Fri,  2 Aug 2024 04:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="Rrw3dpVc"
Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40B3B18B1A
	for <linux-kernel@vger.kernel.org>; Fri,  2 Aug 2024 04:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722574224; cv=none; b=hwxfOBwv4tXU12ieqU/2g0StJStWP5j5Bh0J3UrJKEThAj9OJMpeggZFL6EKX4gfWyXqy0vcQHsVAkSZ8lK2GMLVtzFluLlZ6HMhKw8ttPFAynzdZoTq5c5VVL83v2GfWHJO2S4LzXObY3Tz0Vq9Uup/DWpXDx4OTyU94MIs7/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722574224; c=relaxed/simple;
	bh=Yxr7NIzQja8SRkKRwBQzZFpVHtslcmY46oSFVEyhNWU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PzHR0FxdOYHnGjLrd3zSDAwFl2Qr96cB9ZTius5ICZSPsGgOv1EHMGjji98Aowz2FcLiuWt8yUAfI1qX8BNehdA1wVyaOHzhJVR6zHmH4aNWH4f1XCFp3llNSXlBMysb4bQrUy8bZud0vxbBcVuKaMpi3+qyHrblCXczVTu0c8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=Rrw3dpVc; arc=none smtp.client-ip=115.124.30.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1722574219; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=iT1Gb1/fXutb0eoDqTIXuXWrHKlOxX3peoQ1F2Cfe9c=;
	b=Rrw3dpVcQIX82LnSVhZdE9p1vfBJaQ/cBijN+DF8smIiQhwpP2Pjo+XuvCEr7xUzmQt1w/aqJrUDiyyfTnZjxJ6ZD3DjQc+Ml3vzw8zJOI2J+RuCGZ1FcZKZNmEcHWdN81ePfblJU/Rw63zyQ10pAUdmb7bwX5L7KEwbs0TQ+ss=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067111;MF=hongzhen@linux.alibaba.com;NM=1;PH=DS;RN=3;SR=0;TI=SMTPD_---0WBw4fd3_1722574218;
Received: from 30.221.128.228(mailfrom:hongzhen@linux.alibaba.com fp:SMTPD_---0WBw4fd3_1722574218)
          by smtp.aliyun-inc.com;
          Fri, 02 Aug 2024 12:50:19 +0800
Message-ID: <a40fb02b-02ac-4d66-8550-0750ba10346d@linux.alibaba.com>
Date: Fri, 2 Aug 2024 12:50:18 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v2 2/2] erofs: apply the page cache share feature
To: Hongbo Li <lihongbo22@huawei.com>, linux-erofs@lists.ozlabs.org
Cc: linux-kernel@vger.kernel.org
References: <20240731080704.678259-1-hongzhen@linux.alibaba.com>
 <20240731080704.678259-3-hongzhen@linux.alibaba.com>
 <5796c9ad-04ba-4226-ad28-75b265a4157b@huawei.com>
From: Hongzhen Luo <hongzhen@linux.alibaba.com>
In-Reply-To: <5796c9ad-04ba-4226-ad28-75b265a4157b@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 2024/8/1 20:43, Hongbo Li wrote:
>
>
> On 2024/7/31 16:07, Hongzhen Luo wrote:
>> This modifies relevant functions to apply the page cache
>> share feature.
>>
>> Signed-off-by: Hongzhen Luo <hongzhen@linux.alibaba.com>
>> ---
>> v2: Make adjustments based on the latest implementation.
>> v1: 
>> https://lore.kernel.org/all/20240722065355.1396365-5-hongzhen@linux.alibaba.com/
>> ---
>>   fs/erofs/inode.c | 23 +++++++++++++++++++++++
>>   fs/erofs/super.c | 23 +++++++++++++++++++++++
>>   2 files changed, 46 insertions(+)
>>
>> diff --git a/fs/erofs/inode.c b/fs/erofs/inode.c
>> index 5f6439a63af7..9f1e7332cff9 100644
>> --- a/fs/erofs/inode.c
>> +++ b/fs/erofs/inode.c
>> @@ -5,6 +5,7 @@
>>    * Copyright (C) 2021, Alibaba Cloud
>>    */
>>   #include "xattr.h"
>> +#include "pagecache_share.h"
>>     #include <trace/events/erofs.h>
>>   @@ -229,10 +230,22 @@ static int erofs_fill_inode(struct inode *inode)
>>       switch (inode->i_mode & S_IFMT) {
>>       case S_IFREG:
>>           inode->i_op = &erofs_generic_iops;
>> +#ifdef CONFIG_EROFS_FS_PAGE_CACHE_SHARE
>> +        erofs_pcs_fill_inode(inode);
>> +#endif
>>           if (erofs_inode_is_data_compressed(vi->datalayout))
>>               inode->i_fop = &generic_ro_fops;
>> +#ifdef CONFIG_EROFS_FS_PAGE_CACHE_SHARE
>> +        else {
> If the compress data is not support, the erofs_pcs_fill_inode should 
> fill the fingerprint in this branch only.
Sure, thanks.
>> +            if (vi->fprt_len > 0)
>> +                inode->i_fop = &erofs_pcs_file_fops;
>> +            else
>> +                inode->i_fop = &erofs_file_fops;
>> +        }
>> +#else
>>           else
>>               inode->i_fop = &erofs_file_fops;
>> +#endif
>>           break;
>>       case S_IFDIR:
>>           inode->i_op = &erofs_dir_iops;
>> @@ -325,6 +338,16 @@ struct inode *erofs_iget(struct super_block *sb, 
>> erofs_nid_t nid)
>>               return ERR_PTR(err);
>>           }
>>           unlock_new_inode(inode);
>> +#ifdef CONFIG_EROFS_FS_PAGE_CACHE_SHARE
>> +        if ((inode->i_mode & S_IFMT) == S_IFREG &&may be S_ISREG 
>> macro is better.
>
>> +            EROFS_I(inode)->fprt_len > 0) {
> Perhaps this logic need to be enclosed within unlock_new_inode.
Sure, thanks.
>> +            err = erofs_pcs_add(inode);
>> +            if (err) {
>> +                iget_failed(inode);
>> +                return ERR_PTR(err);
>> +            }
>> +        }
>> +#endif
>>       }
>>       return inode;
>>   }
>> diff --git a/fs/erofs/super.c b/fs/erofs/super.c
>> index 35268263aaed..a42e65ef7fc7 100644
>> --- a/fs/erofs/super.c
>> +++ b/fs/erofs/super.c
>> @@ -11,6 +11,7 @@
>>   #include <linux/fs_parser.h>
>>   #include <linux/exportfs.h>
>>   #include "xattr.h"
>> +#include "pagecache_share.h"
>>     #define CREATE_TRACE_POINTS
>>   #include <trace/events/erofs.h>
>> @@ -95,6 +96,10 @@ static struct inode *erofs_alloc_inode(struct 
>> super_block *sb)
>>         /* zero out everything except vfs_inode */
>>       memset(vi, 0, offsetof(struct erofs_inode, vfs_inode));
>> +#ifdef CONFIG_EROFS_FS_PAGE_CACHE_SHARE
>> +    INIT_LIST_HEAD(&vi->pcs_list);
>> +    init_rwsem(&vi->pcs_rwsem);
>> +#endif
>>       return &vi->vfs_inode;
>>   }
>>   @@ -108,6 +113,21 @@ static void erofs_free_inode(struct inode *inode)
>>       kmem_cache_free(erofs_inode_cachep, vi);
>>   }
>>   +#ifdef CONFIG_EROFS_FS_PAGE_CACHE_SHARE
>> +static void erofs_destroy_inode(struct inode *inode)
>> +{
>> +    struct erofs_inode *vi = EROFS_I(inode);
>> +
>> +    if ((inode->i_mode & S_IFMT) == S_IFREG &&
> using S_ISREG macro is better.

Thanks.

---

Hongzhen Luo

>> +        EROFS_I(inode)->fprt_len > 0) {
>> +        if (erofs_pcs_remove(inode))
>> +            erofs_err(inode->i_sb, "pcs: fail to remove inode.");
>> +        kfree(vi->fprt);
>> +        vi->fprt = NULL;
>> +    }
>> +}
>> +#endif
>> +
>>   static bool check_layout_compatibility(struct super_block *sb,
>>                          struct erofs_super_block *dsb)
>>   {
>> @@ -937,6 +957,9 @@ static int erofs_show_options(struct seq_file 
>> *seq, struct dentry *root)
>>   const struct super_operations erofs_sops = {
>>       .put_super = erofs_put_super,
>>       .alloc_inode = erofs_alloc_inode,
>> +#ifdef CONFIG_EROFS_FS_PAGE_CACHE_SHARE
>> +    .destroy_inode = erofs_destroy_inode,
>> +#endif
>>       .free_inode = erofs_free_inode,
>>       .statfs = erofs_statfs,
>>       .show_options = erofs_show_options,

