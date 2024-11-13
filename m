Return-Path: <linux-kernel+bounces-407050-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 942539C67E5
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 04:42:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 315E4B2260B
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 03:42:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F1A816DEB2;
	Wed, 13 Nov 2024 03:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="aiySjThg"
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E9E62309AA
	for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 03:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731469358; cv=none; b=spBy2cQ8r+S/9alpejxZ+e62+zfpxKvLXz4fdZK/H3ZVHr/Kh2zEt0xOUocJ5dIBMmMS2agAzAupBgoGvcwB/Lw9+llLdXQTJMn2rSw6VOuNl3kZqqCcBvSbBzEfcviAfQtDs0rCfkDy7IF+Nu1BSflZzrt403Lftqn1c+7Rtoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731469358; c=relaxed/simple;
	bh=AjoK82q7ZJfYgbsXCx5YMx0EuMBH7YgQXmJkE+y2ufk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=orffh/0Hh9xohMMTapqYxcKkT7Pui2IJ/3KM9RkoUqFyEJ/cr5SfviThZLkCLaJ37TpcnurCEm+WozqASvaIhmhnKtSY34AxGu3xkA9Lp9L1QPAv2nkCCsALjug9+aJTnHPw5w0Vfyqu+fTmmzg9N1flueGxkeS87vFFNWRuiiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=aiySjThg; arc=none smtp.client-ip=115.124.30.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1731469348; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=DLNQlGqphkgHJqVTPy96g2sXHQpFwdRU64zTO215OIM=;
	b=aiySjThg+NbhRu8AgjdTliSdEOZMQH/1zkD7lzJRL1fSyV4NwEzys5lwjpCG43klSC0rNX5KSHfMzlRBJEMp3pDkES8rytwi9KtlD56iLXYkvILLd0zTsVdlNKAzKNf0oaoruM9xIrZMg8DCXnve5GLeObSipzgmn6Qr/GKtZSE=
Received: from 30.221.129.12(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WJJVINE_1731469346 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 13 Nov 2024 11:42:27 +0800
Message-ID: <ecfb4f83-e78c-40f6-803c-554edf7928b2@linux.alibaba.com>
Date: Wed, 13 Nov 2024 11:42:25 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] erofs: simplify definition of the log functions
To: Gou Hao <gouhao@uniontech.com>, xiang@kernel.org, chao@kernel.org
Cc: linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 gouhaojake@163.com
References: <20241018033500.13833-1-gouhao@uniontech.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20241018033500.13833-1-gouhao@uniontech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Hao,

Sorry for late response due to my long vacation.

On 2024/10/18 11:35, Gou Hao wrote:
> using printk instead of pr_info/err, reduce
> redundant code.

Use printk instead of pr_info/err to reduce
redundant code.

> 
> Signed-off-by: Gou Hao <gouhao@uniontech.com>
> ---
>   fs/erofs/internal.h |  9 ++++-----
>   fs/erofs/super.c    | 28 +++++++---------------------
>   2 files changed, 11 insertions(+), 26 deletions(-)
> 
> diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
> index 4efd578d7c62..ae87e855e815 100644
> --- a/fs/erofs/internal.h
> +++ b/fs/erofs/internal.h
> @@ -24,14 +24,13 @@
>   #undef pr_fmt
>   #define pr_fmt(fmt) "erofs: " fmt
>   
> -__printf(3, 4) void _erofs_err(struct super_block *sb,
> +__printf(3, 4) void _erofs_printk(struct super_block *sb,
>   			       const char *function, const char *fmt, ...);
>   #define erofs_err(sb, fmt, ...)	\
> -	_erofs_err(sb, __func__, fmt "\n", ##__VA_ARGS__)
> -__printf(3, 4) void _erofs_info(struct super_block *sb,
> -			       const char *function, const char *fmt, ...);
> +	_erofs_printk(sb, __func__, KERN_ERR fmt "\n", ##__VA_ARGS__)
>   #define erofs_info(sb, fmt, ...) \
> -	_erofs_info(sb, __func__, fmt "\n", ##__VA_ARGS__)
> +	_erofs_printk(sb, __func__, KERN_INFO fmt "\n", ##__VA_ARGS__)
> +
>   #ifdef CONFIG_EROFS_FS_DEBUG
>   #define DBG_BUGON               BUG_ON
>   #else
> diff --git a/fs/erofs/super.c b/fs/erofs/super.c
> index 666873f745da..64c3258ddf9a 100644
> --- a/fs/erofs/super.c
> +++ b/fs/erofs/super.c
> @@ -18,37 +18,23 @@
>   
>   static struct kmem_cache *erofs_inode_cachep __read_mostly;
>   
> -void _erofs_err(struct super_block *sb, const char *func, const char *fmt, ...)
> +void _erofs_printk(struct super_block *sb, const char *func, const char *fmt, ...)
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

Let's get rid of `const char *func,` for all cases
since I think it's not very helpful indeed.

Thanks,
Gao Xiang

