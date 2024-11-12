Return-Path: <linux-kernel+bounces-405510-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E35279C5243
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 10:42:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A8689282703
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 09:42:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07DA820E007;
	Tue, 12 Nov 2024 09:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="Jkkw+Cci"
Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBC2F20DD47
	for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 09:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.119
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731404558; cv=none; b=YKvdOkU3lqsaKwf2EKJ5z+cf+HLy1858+JewCWxMzg6QMxUoTEDm1WxrH/oQV2vJnQEtbcmfuf7prVKyIF+rphHru3vkVoSNl7rRSyKLQFUHKgJk/N1z4jTcsRehJiqMT1mZ9QJSAjgNw52GCY3Rlw8rurScv3wBxSBC/yYNsVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731404558; c=relaxed/simple;
	bh=mIhSHldPVqBpyw3G4Fo9cIpHCQSoiGXt+whYMri+MNM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FytYyWWtnbIC/Ym7ha4VXXSOO44fxQkLuhwAMaSEHKYLv3QrdUZYVGgC4eunRwjRy6mSXcm0PWOvEOUwBaQFOa7Hs2DzfgVegN7TNl6DprwR7yFqDNr7Yi6gTygNsw+bLADcy4DIHin3Kqnj0K3lx8u1wZLbgFt/OS+ZBFdcv1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=Jkkw+Cci; arc=none smtp.client-ip=115.124.30.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1731404553; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=voksCnbA+4EpaI3K9bQUHmFEWIROIUAhEOXE8dJ5UrU=;
	b=Jkkw+CciuCuvdXMfIocdejdynT4hV0yPeYKbdTfo440VT1IjeFHGGReZzMulqvW4/ycvEflFEFKdtxFZejy31DXxdeOPavevLC/jdHgSFOerk0PYf9iHyp52KFq1Rwps4Hw+Mkr6883+AwGI65NciJanj3d3eKxzFhrRN1X6dTw=
Received: from 30.221.128.202(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WJGo4pJ_1731404551 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 12 Nov 2024 17:42:32 +0800
Message-ID: <fabdfe9f-9293-45c2-8cf2-3d86c248ab4c@linux.alibaba.com>
Date: Tue, 12 Nov 2024 17:42:30 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] erofs: add sysfs node to drop all compression-related
 caches
To: Chunhai Guo <guochunhai@vivo.com>, xiang@kernel.org
Cc: chao@kernel.org, huyue2@coolpad.com, jefflexu@linux.alibaba.com,
 dhavale@google.com, linux-erofs@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
References: <20241112091403.586545-1-guochunhai@vivo.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20241112091403.586545-1-guochunhai@vivo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Chunhai,

On 2024/11/12 17:14, Chunhai Guo wrote:
> Add a sysfs node to drop all compression-related caches, including
> pclusters and attached compressed pages.

subject: erofs: add sysfs node to drop internal caches

Add a sysfs node to drop compression-related caches, currently
used to drop in-memory pclusters and compressed folios.

I don't think it really drops `compressed folios`, also see
my comment below:

> 
> Signed-off-by: Chunhai Guo <guochunhai@vivo.com>
> ---
>   Documentation/ABI/testing/sysfs-fs-erofs |  7 +++++++
>   fs/erofs/sysfs.c                         | 11 +++++++++++
>   2 files changed, 18 insertions(+)
> 
> diff --git a/Documentation/ABI/testing/sysfs-fs-erofs b/Documentation/ABI/testing/sysfs-fs-erofs
> index 284224d1b56f..b66a3f6d3fdf 100644
> --- a/Documentation/ABI/testing/sysfs-fs-erofs
> +++ b/Documentation/ABI/testing/sysfs-fs-erofs
> @@ -16,3 +16,10 @@ Description:	Control strategy of sync decompression:
>   		  readahead on atomic contexts only.
>   		- 1 (force on): enable for readpage and readahead.
>   		- 2 (force off): disable for all situations.
> +
> +What:		/sys/fs/erofs/<disk>/drop_caches
> +Date:		November 2024
> +Contact:	"Guo Chunhai" <guochunhai@vivo.com>
> +Description:	Writing 1 to this will cause the erofs to drop all
> +		compression-related caches, including pclusters and attached
> +		compressed pages. Any other value is invalid.
> diff --git a/fs/erofs/sysfs.c b/fs/erofs/sysfs.c
> index 63cffd0fd261..f068f01437d5 100644
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
> @@ -163,6 +166,14 @@ static ssize_t erofs_attr_store(struct kobject *kobj, struct attribute *attr,
>   			return -EINVAL;
>   		*(bool *)ptr = !!t;
>   		return len;
> +	case attr_drop_caches:
> +		ret = kstrtoul(skip_spaces(buf), 0, &t);
> +		if (ret)
> +			return ret;
> +		if (t != 1)
> +			return -EINVAL;

		if (t & 2)
			z_erofs_shrink_scan(sbi, ~0UL);

		if (t & 1)
			invalidate_mapping_pages(EROFS_I_SB(inode)->managed_cache->i_mapping, 0, -1);

or you could export MNGD_MAPPING macros again.

Thanks,
Gao Xiang

