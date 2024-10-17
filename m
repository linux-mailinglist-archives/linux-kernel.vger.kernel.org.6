Return-Path: <linux-kernel+bounces-369138-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1311D9A195E
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 05:40:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D4C79285749
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 03:40:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B59887E575;
	Thu, 17 Oct 2024 03:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="GeiWSmCv"
Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D51941C6C
	for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 03:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729136406; cv=none; b=ekxOZKKxikfwxVy6I6aBfMG0Uy3YXDqoJjCL3KRWrIn3Fty3SrqXR2nfbuozuo+OulM2ameSevECLVV7n0ijr35fG/ltKNcVv4qE1PYVECDrvivEaFxIy0mW7bATQjU2hmECu770pHaHkLMOcuyUofA4TzJYmyvA6vncDT3a6Hg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729136406; c=relaxed/simple;
	bh=V7VGbicfm4qmKIZnTqZrTUgqnZUd5lNs4C/4Y2ZN+30=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WHMn41iJuIWwgwF7ijSxbbDTX+vg5CGlDKRS10DrrP8nNOfiuZvFmC/zyvziyu++oBgK/kkr39LGFUbezfBaK3y0mcrRjdfos/FkYwCk67bf+hPpVEkhASSyTdLDBuLM6c7UutUo1sNi4kR6BhMSrxlfA7Dm95OEmWEAt/5QmXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=GeiWSmCv; arc=none smtp.client-ip=115.124.30.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1729136394; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=BEdFcsWdIAk9ivYlkVbjLUq7w2ocbRx/r+bMp0elD6k=;
	b=GeiWSmCvsUtwAUIeVYTJ3JGFdQAz9WDsUdrBi27khZkZT4RI59TsPYHj/45Vr1hl+HQ2eR5YRIJVLz6FdFp5kwOo71jq8oNoHgBlB0ddtcFQPLLeBEITTgpggNJN5uvKOZx7/tju6Yk1w6X/s0T4WKxhRqJUMsBewLFQfKQdVcY=
Received: from 30.221.129.137(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WHJR1ca_1729136393 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 17 Oct 2024 11:39:54 +0800
Message-ID: <e5843bc0-4157-4bbb-908d-2997e95e6007@linux.alibaba.com>
Date: Thu, 17 Oct 2024 11:39:53 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] erofs: using macro instead of definition of log
 functions
To: Gou Hao <gouhao@uniontech.com>, xiang@kernel.org, chao@kernel.org
Cc: linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 gouhaojake@163.com
References: <20241016152430.3456-1-gouhao@uniontech.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20241016152430.3456-1-gouhao@uniontech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Hao,

On 2024/10/16 23:24, Gou Hao wrote:
> No functional change intended.
> 
> Signed-off-by: Gou Hao <gouhao@uniontech.com>
> ---
>   fs/erofs/super.c | 51 ++++++++++++++++++------------------------------
>   1 file changed, 19 insertions(+), 32 deletions(-)
> 
> diff --git a/fs/erofs/super.c b/fs/erofs/super.c
> index 666873f745da..b04f888c8123 100644
> --- a/fs/erofs/super.c
> +++ b/fs/erofs/super.c
> @@ -18,39 +18,26 @@
>   
>   static struct kmem_cache *erofs_inode_cachep __read_mostly;
>   
> -void _erofs_err(struct super_block *sb, const char *func, const char *fmt, ...)
> -{
> -	struct va_format vaf;
> -	va_list args;
> -
> -	va_start(args, fmt);
> -
> -	vaf.fmt = fmt;
> -	vaf.va = &args;
> -
> -	if (sb)
> -		pr_err("(device %s): %s: %pV", sb->s_id, func, &vaf);
> -	else
> -		pr_err("%s: %pV", func, &vaf);
> -	va_end(args);
> -}
> -
> -void _erofs_info(struct super_block *sb, const char *func, const char *fmt, ...)
> -{
> -	struct va_format vaf;
> -	va_list args;
> -
> -	va_start(args, fmt);
> -
> -	vaf.fmt = fmt;
> -	vaf.va = &args;
> +#define _erofs_log_def(name) \
> +	void _erofs_##name(struct super_block *sb, const char *func, const char *fmt, ...) \
> +	{ \
> +		struct va_format vaf; \
> +		va_list args; \
> +		\
> +		va_start(args, (fmt)); \
> +		\
> +		vaf.fmt = (fmt); \
> +		vaf.va = &args; \
> +		\
> +		if ((sb)) \
> +			pr_##name("(device %s): %s: %pV", (sb)->s_id, (func), &vaf); \
> +		else \
> +			pr_##name("%s: %pV", (func), &vaf); \
> +		va_end(args); \
> +	}

Thanks for the patch!

Although code simplicity is quite important for EROFS, but
I'm not sure introducing unnecessary macro definitions (which
can be avoided) is better for code readability.

I wonder if we can put this into another way, like the current
_btrfs_printk() and _f2fs_printk() if we really need to work
on this.

Thanks,
Gao Xiang

