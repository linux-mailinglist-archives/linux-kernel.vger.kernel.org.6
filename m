Return-Path: <linux-kernel+bounces-369143-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A94219A196B
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 05:42:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 575A51F2269F
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 03:42:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB38313AA4E;
	Thu, 17 Oct 2024 03:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="EOAS5csr"
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03995165F08
	for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 03:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729136535; cv=none; b=R6a6WmkQ78OLXbIYjmDONBMd9eojQe3/6r7SN/nrLVMiLd1W/kuuP+BbzfCEkOtn4mKWGwOzXkBQMdkOZyXNUk0arS0IbBoYJzt/8OWR8EIW671lndI/b+GH/vFqF9HiFUV8etWiN6IzZp1E13uB6hOUVF7vwhM7uIfT8Btnb+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729136535; c=relaxed/simple;
	bh=vwDsIhTnJ+RGBhyxCBjhRiO42lJ46dIiqrSa/na1EcI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Igis0+G7j8dA7DGUyzv8hZHgDNDIc8BqgmXbVdIgaj6mHaWu5XUfaHtEeJ+KeXzy9FEnWLlL4Jf27J6Z7CvILnUxn7t5Il5fvJ8XqE9QG2A7QRwn6mN0M3bTsABc0eYgIoVi9MZjaBlpUtieHv2PvwBmwuhIMDAf86zMRf4Ab9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=EOAS5csr; arc=none smtp.client-ip=115.124.30.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1729136530; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=DA4Z1yCinxSZ8HRe2Rh9XoWLg0ulprtNnoYyidfLapE=;
	b=EOAS5csrywAZ6qxu2q9OUHMYgcx7jKSHwD0161x+3DcSQR81eZC7p6FnzQWqto9TqHjKDukpwO634QVPsv/seSYbW1lmsprCHgWclJrmkEuKs/qzztorhinMxJprN+U8V84pfR5lRJRHbL5I3zWIwHSDsQpbBGZxjdpn4CuRJTg=
Received: from 30.221.129.137(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WHJGx75_1729136529 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 17 Oct 2024 11:42:09 +0800
Message-ID: <714b8a53-587f-4cee-bff7-330cf0b32f7f@linux.alibaba.com>
Date: Thu, 17 Oct 2024 11:42:07 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] erofs: simplify declaration of the log functions
To: Gou Hao <gouhao@uniontech.com>, xiang@kernel.org, chao@kernel.org
Cc: linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 gouhaojake@163.com
References: <20241016152430.3456-1-gouhao@uniontech.com>
 <20241016152430.3456-2-gouhao@uniontech.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20241016152430.3456-2-gouhao@uniontech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2024/10/16 23:24, Gou Hao wrote:
> remove the macro of the log declarations.
> 
> Signed-off-by: Gou Hao <gouhao@uniontech.com>
> ---
>   fs/erofs/internal.h | 13 +++++--------
>   fs/erofs/super.c    | 12 ++++++------
>   2 files changed, 11 insertions(+), 14 deletions(-)
> 
> diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
> index 4efd578d7c62..0c3d6b9f85b5 100644
> --- a/fs/erofs/internal.h
> +++ b/fs/erofs/internal.h
> @@ -24,14 +24,11 @@
>   #undef pr_fmt
>   #define pr_fmt(fmt) "erofs: " fmt
>   
> -__printf(3, 4) void _erofs_err(struct super_block *sb,
> -			       const char *function, const char *fmt, ...);
> -#define erofs_err(sb, fmt, ...)	\
> -	_erofs_err(sb, __func__, fmt "\n", ##__VA_ARGS__)
> -__printf(3, 4) void _erofs_info(struct super_block *sb,
> -			       const char *function, const char *fmt, ...);
> -#define erofs_info(sb, fmt, ...) \
> -	_erofs_info(sb, __func__, fmt "\n", ##__VA_ARGS__)
> +#define erofs_log_declare(name) \
> +	__printf(2, 3) void erofs_##name(struct super_block *sb, const char *fmt, ...)
> +erofs_log_declare(err);
> +erofs_log_declare(info);

I guess it will make the code harder to read IMHO..

Thanks,
Gao Xiang

