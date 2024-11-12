Return-Path: <linux-kernel+bounces-405111-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B2B99C4D26
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 04:16:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A7440B286C5
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 03:10:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 330C9207A1C;
	Tue, 12 Nov 2024 03:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="KlqSDgzQ"
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13D9E204952
	for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 03:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731381003; cv=none; b=JtNg/sm8vYmc76rWAi10liGJ2Sw5qWgrIlN7cibZcw10JdkIWznFy0wY9NQokb6cAAtOlx+84v1oELJS9k/jm7TymwANJsPM0/tYUkgwkNyviUrgiVdnkU4YqCfGYck32XuNP0l55/tG54LKc7PK/+2FGpJuZ6YWZ8Ytz34Dy2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731381003; c=relaxed/simple;
	bh=tz7ZaBQW0xdivy8VccIhUHyqdsPe80fPrFvvwNdc39s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=o3jprUcX6vyCZoutDHhtxxB0kKzBRw0e4/ySy9LN2DUMn7ktvIiuNxhRfy7MnW2RpSuzVfBCjcg8Y604uEej2e0dHsnApRaITmKH5N66/Ty2UyoWDito/trOcsVSECNkLbzmrZ993dBWfpqgr98FJRUdOcjzMpRlthX1/NpQA9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=KlqSDgzQ; arc=none smtp.client-ip=115.124.30.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1731380997; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=gN3YaYLgY9SUyrMbc88gJjv3MN+sgD5Bg199MEKibO4=;
	b=KlqSDgzQZ5rtKHUTdUsti02pr5I5q74kMIngyVpzFhsBCFloy+LDXANmMkLtQNlXbHOKeBr4hD32SKdC9y93F/1JumYuJRzHkl5P/uxL1gwLv3EAX+oI5ZhPMbUelAoNHHvH2IQSrKO+wzkdn79He7B0cH2MV5BiP+zxuWZKi5s=
Received: from 30.221.128.202(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WJFQ1wm_1731380995 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 12 Nov 2024 11:09:56 +0800
Message-ID: <3cc99567-b3e6-419f-820c-f772e26aa85d@linux.alibaba.com>
Date: Tue, 12 Nov 2024 11:09:55 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] erofs: clean up the cache if cached decompression is
 disabled
To: Chunhai Guo <guochunhai@vivo.com>, xiang@kernel.org
Cc: chao@kernel.org, huyue2@coolpad.com, jefflexu@linux.alibaba.com,
 dhavale@google.com, linux-erofs@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
References: <20241112031513.528474-1-guochunhai@vivo.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20241112031513.528474-1-guochunhai@vivo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2024/11/12 11:15, Chunhai Guo wrote:
> Clean up the cache when cached decompression strategy is changed to
> EROFS_ZIP_CACHE_DISABLED by remount.
> 
> Signed-off-by: Chunhai Guo <guochunhai@vivo.com>
> ---
>   fs/erofs/super.c | 5 +++++
>   1 file changed, 5 insertions(+)
> 
> diff --git a/fs/erofs/super.c b/fs/erofs/super.c
> index 320d586c3896..de2af862e65b 100644
> --- a/fs/erofs/super.c
> +++ b/fs/erofs/super.c
> @@ -743,6 +743,11 @@ static int erofs_fc_reconfigure(struct fs_context *fc)
>   	else
>   		fc->sb_flags &= ~SB_POSIXACL;
>   
> +	if (new_sbi->opt.cache_strategy == EROFS_ZIP_CACHE_DISABLED) {

I guess we need to check if
	(sbi->opt.cache_strategy != new_sbi->opt.cache_strategy &&
	new_sbi->opt.cache_strategy == EROFS_ZIP_CACHE_DISABLED)


Thanks,
Gao Xiang

> +		mutex_lock(&sbi->umount_mutex);
> +		z_erofs_shrink_scan(sbi, ~0UL);
> +		mutex_unlock(&sbi->umount_mutex);
> +	}
>   	sbi->opt = new_sbi->opt;
>   
>   	fc->sb_flags |= SB_RDONLY;


