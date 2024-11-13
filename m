Return-Path: <linux-kernel+bounces-407918-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 390EE9C776B
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 16:40:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9BFE2281CDC
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 15:40:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 902B1205E2E;
	Wed, 13 Nov 2024 15:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="S9eTOaaj"
Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45AEA1632CD
	for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 15:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731511965; cv=none; b=PeQC2yVK6XQWR4rBtG2pf5P6u4orwkCvwOR4SnA74Dn6CWA/+1+HuzY+e+FIxZcrUMjDCYe0djdUSZMNetWQ0iZLkg6UUsiyjrY2kT9KUczr7mT8hCY/IWzUtFw+6fEZ71jPVCuICTK8sYB6FcMWErXnii9rf3OYY728006OIYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731511965; c=relaxed/simple;
	bh=Cw1UezyQoLezq0+6FCjkUo53AsvsDjlEDpGvlBfDS6A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FY3lvZoHT/Bo0kCJA02XoCLI12lOnOseXdFvSIBABWixEMEqik/sCXzJrDr50Rx0UDw13Nv/4cQUMIqMMcakh7Ff+1pWAcBFHF3D6LB9sZRf/ix+81sN1MqHlfo2dytEb8L2XkFDlvcm6cHQK8pv648tMxQK9env/3yaeRc1StI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=S9eTOaaj; arc=none smtp.client-ip=115.124.30.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1731511959; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=/WHU0tdWENVTU/cnY0uG1dijHbWIyDoyf3RBtytkpss=;
	b=S9eTOaajk+a+h7OYJsKMJ2l63Q64LG4KIaO9XrE1RI2+pvQn4nM5bXI97OXekciPGdF4naYqzMk+aZmCLKIstR0K32yC2s3ge9cTDfO5LJbTOlz/akidWmyRRrLY7QATK3F/g3T1KKelAG9OK+N3w1YoAZXVEZWtBFc5oTx0CkU=
Received: from 192.168.88.120(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WJLUVIG_1731511958 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 13 Nov 2024 23:32:38 +0800
Message-ID: <63a68526-3f21-4ef8-a782-74dc4f428272@linux.alibaba.com>
Date: Wed, 13 Nov 2024 23:32:37 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2] erofs: simplify definition of the log functions
To: Gou Hao <gouhao@uniontech.com>, xiang@kernel.org, chao@kernel.org
Cc: linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 gouhaojake@163.com
References: <20241113144128.16007-1-gouhao@uniontech.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20241113144128.16007-1-gouhao@uniontech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2024/11/13 22:41, Gou Hao wrote:
> Use printk instead of pr_info/err to reduce
> redundant code.
> 
> Signed-off-by: Gou Hao <gouhao@uniontech.com>
> ---
>   fs/erofs/internal.h | 14 ++++----------
>   fs/erofs/super.c    | 28 +++++++---------------------
>   2 files changed, 11 insertions(+), 31 deletions(-)
> 
> Changes:
> V2:
> - remove 'const char  *function' from _erofs_printk
> - remove pr_fmt macro, put 'erofs' prefix into printk
> 
> diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
> index 4efd578d7c62..116c82588661 100644
> --- a/fs/erofs/internal.h
> +++ b/fs/erofs/internal.h
> @@ -20,18 +20,12 @@
>   #include <linux/iomap.h>
>   #include "erofs_fs.h"
>   
> -/* redefine pr_fmt "erofs: " */
> -#undef pr_fmt
> -#define pr_fmt(fmt) "erofs: " fmt
> -
> -__printf(3, 4) void _erofs_err(struct super_block *sb,
> -			       const char *function, const char *fmt, ...);
> +__printf(2, 3) void _erofs_printk(struct super_block *sb, const char *fmt, ...);
>   #define erofs_err(sb, fmt, ...)	\
> -	_erofs_err(sb, __func__, fmt "\n", ##__VA_ARGS__)
> -__printf(3, 4) void _erofs_info(struct super_block *sb,
> -			       const char *function, const char *fmt, ...);
> +	_erofs_printk(sb, KERN_ERR fmt "\n", ##__VA_ARGS__)
>   #define erofs_info(sb, fmt, ...) \
> -	_erofs_info(sb, __func__, fmt "\n", ##__VA_ARGS__)
> +	_erofs_printk(sb, KERN_INFO fmt "\n", ##__VA_ARGS__)
> +
>   #ifdef CONFIG_EROFS_FS_DEBUG
>   #define DBG_BUGON               BUG_ON
>   #else
> diff --git a/fs/erofs/super.c b/fs/erofs/super.c
> index 666873f745da..93b44b77a41c 100644
> --- a/fs/erofs/super.c
> +++ b/fs/erofs/super.c
> @@ -18,37 +18,23 @@
>   
>   static struct kmem_cache *erofs_inode_cachep __read_mostly;
>   
> -void _erofs_err(struct super_block *sb, const char *func, const char *fmt, ...)
> +void _erofs_printk(struct super_block *sb, const char *fmt, ...)
>   {
>   	struct va_format vaf;
>   	va_list args;
> +	int level;
>   
>   	va_start(args, fmt);
>   
> -	vaf.fmt = fmt;
> +	level = printk_get_level(fmt);
> +	vaf.fmt = printk_skip_level(fmt);
>   	vaf.va = &args;
>   
>   	if (sb)
> -		pr_err("(device %s): %s: %pV", sb->s_id, func, &vaf);
> +		printk("%c%cerofs: (device %s): %pV",

		printk("%c%cerofs (device %s): %pV",

is preferred.

Otherwise it looks good to me.

Thanks,
Gao Xiang

