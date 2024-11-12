Return-Path: <linux-kernel+bounces-406094-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A7749C5C01
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 16:36:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D24D6B2B8D1
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 14:51:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D6BF1FF037;
	Tue, 12 Nov 2024 14:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="gvGw3rw7"
Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B43342309A3
	for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 14:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731423067; cv=none; b=k16hk9EQG/yU94iFsGb73KY4R4+pcqJcEAMYEOt/p0asRoMRCiETsh1fblvVujmCAYHi6Bw03434pny5LLvB7QybNHy57hWO/KGgc8+7TZrZSGHbJbaldZiIUNa0zWLROVTbZ4kcZ2hH+lz5OWFgSc4aG2Z/vlgtsmmD7BAYm3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731423067; c=relaxed/simple;
	bh=99SWnpry2UErb7FF9v9dt8wjpS3qs4YDqMuG/mAzSjY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=J0kN0eMMROwm8PrrLrVhItR9pF1JVJopalrbKCFuqbnH5r6u08AjyxmPQrhvlpHDsnLbMI2ze7qJfNaxUFgPm1M3L4jhv+4aPsleF1gfxbjSRCveZCdBde1KqqGPV/FnplItFZu37F0DcKjqEhrD9mj0jC8p+ub2gKxSNmsGu9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=gvGw3rw7; arc=none smtp.client-ip=115.124.30.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1731423061; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=qqPGlldiKA/0frstxqxDfQ+0+1Zynw9+m2wDIl7/ooo=;
	b=gvGw3rw7gDpOrk4Qb9rdKif0dJYG+GItWmR8ZfpPi8SEJGJL/VvLU91RpjKgqHLhImxpEZ9QZdeb2Giqj2LNijZ3qeVf554ZmINZU82NZBW/11ZnODbNqIg5g+/XRCCTdwYD0lQ5a1RmnpQVjryQTCegSEgPq5hvh7hpCssvl0o=
Received: from 192.168.88.120(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WJHtRez_1731423059 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 12 Nov 2024 22:51:00 +0800
Message-ID: <0b56f59e-b973-4ac2-b234-b362af8adedc@linux.alibaba.com>
Date: Tue, 12 Nov 2024 22:50:58 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] erofs: add sysfs node to drop internal caches
To: Chunhai Guo <guochunhai@vivo.com>, xiang@kernel.org
Cc: chao@kernel.org, huyue2@coolpad.com, jefflexu@linux.alibaba.com,
 dhavale@google.com, linux-erofs@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
References: <20241112114034.618402-1-guochunhai@vivo.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20241112114034.618402-1-guochunhai@vivo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2024/11/12 19:40, Chunhai Guo wrote:
> Add a sysfs node to drop compression-related caches, currently used to
> drop in-memory pclusters and compressed folios.
> 
> Signed-off-by: Chunhai Guo <guochunhai@vivo.com>
> ---
> v1: https://lore.kernel.org/linux-erofs/fabdfe9f-9293-45c2-8cf2-3d86c248ab4c@linux.alibaba.com
> change since v1:
>   - Change subject as suggested by Gao Xiang.
>   - Use different bits to indicate different meanings in the sysfs node.
> ---
>   Documentation/ABI/testing/sysfs-fs-erofs | 11 +++++++++++
>   fs/erofs/internal.h                      |  2 ++
>   fs/erofs/sysfs.c                         | 15 +++++++++++++++
>   fs/erofs/zdata.c                         |  1 -
>   4 files changed, 28 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/ABI/testing/sysfs-fs-erofs b/Documentation/ABI/testing/sysfs-fs-erofs
> index 284224d1b56f..44d863cd07b5 100644
> --- a/Documentation/ABI/testing/sysfs-fs-erofs
> +++ b/Documentation/ABI/testing/sysfs-fs-erofs
> @@ -16,3 +16,14 @@ Description:	Control strategy of sync decompression:
>   		  readahead on atomic contexts only.
>   		- 1 (force on): enable for readpage and readahead.
>   		- 2 (force off): disable for all situations.
> +
> +What:		/sys/fs/erofs/<disk>/drop_caches
> +Date:		November 2024
> +Contact:	"Guo Chunhai" <guochunhai@vivo.com>
> +Description:	Writing to this will drop compression-related caches,
> +		currently used to drop in-memory pclusters and
> +		compressed folios:

		cached compressed folios:

> +
> +		- 1 : drop in-memory compressed folios

		- 1 : invalidate cached compressed folios

> +		- 2 : drop in-memory pclusters
> +		- 3 : drop in-memory pclusters and compressed folios

		- 3 : drop in-memory pclusters and cached compressed folios

> diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
> index 3905d991c49b..0328e6b98c1b 100644
> --- a/fs/erofs/internal.h
> +++ b/fs/erofs/internal.h
> @@ -450,6 +450,8 @@ static inline void erofs_pagepool_add(struct page **pagepool, struct page *page)
>   void erofs_release_pages(struct page **pagepool);
>   
>   #ifdef CONFIG_EROFS_FS_ZIP
> +#define MNGD_MAPPING(sbi)	((sbi)->managed_cache->i_mapping)
> +
>   extern atomic_long_t erofs_global_shrink_cnt;
>   void erofs_shrinker_register(struct super_block *sb);
>   void erofs_shrinker_unregister(struct super_block *sb);
> diff --git a/fs/erofs/sysfs.c b/fs/erofs/sysfs.c
> index 63cffd0fd261..01d509e43827 100644
> --- a/fs/erofs/sysfs.c
> +++ b/fs/erofs/sysfs.c
> @@ -10,6 +10,7 @@
>   
>   enum {
>   	attr_feature,
> +	attr_drop_caches,
>   	attr_pointer_ui,
>   	attr_pointer_bool,
>   };
> @@ -57,11 +58,13 @@ static struct erofs_attr erofs_attr_##_name = {			\
>   
>   #ifdef CONFIG_EROFS_FS_ZIP
>   EROFS_ATTR_RW_UI(sync_decompress, erofs_mount_opts);
> +EROFS_ATTR_FUNC(drop_caches, 0200);
>   #endif
>   
>   static struct attribute *erofs_attrs[] = {
>   #ifdef CONFIG_EROFS_FS_ZIP
>   	ATTR_LIST(sync_decompress),
> +	ATTR_LIST(drop_caches),
>   #endif
>   	NULL,
>   };
> @@ -163,6 +166,18 @@ static ssize_t erofs_attr_store(struct kobject *kobj, struct attribute *attr,
>   			return -EINVAL;
>   		*(bool *)ptr = !!t;
>   		return len;
> +	case attr_drop_caches:
> +		ret = kstrtoul(skip_spaces(buf), 0, &t);
> +		if (ret)
> +			return ret;
> +		if (t < 1 || t > 3)
> +			return -EINVAL;> +
> +		if (t & 1)
> +			invalidate_mapping_pages(MNGD_MAPPING(sbi), 0, -1);
> +		if (t & 2)
> +			z_erofs_shrink_scan(sbi, ~0UL);

Please switch the order to

		if (t & 2)
			z_erofs_shrink_scan(sbi, ~0UL);

		if (t & 1)
			invalidate_mapping_pages(MNGD_MAPPING(sbi), 0, -1);

So that all cached folios could be disconnected first.

Thanks,
Gao Xiang

