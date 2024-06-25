Return-Path: <linux-kernel+bounces-228147-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6F41915B7B
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 03:08:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B8A281C216CC
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 01:08:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E54B10A35;
	Tue, 25 Jun 2024 01:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="GcA9g4++"
Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A09F1FA4
	for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 01:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719277683; cv=none; b=qI1MxqC6vfZVWNqSvoJOHDL3lmrKICgVNqsUNdrxFqWTBLLZn2HIdn5c/3Vd5MVhR/AL76QqEc870f5BIljEHGmN8iks6fuE4u2rtdA5XtA5zt78XruvMnDkYAFAgZ2K58B34d6JlMuymZwIZgCmC8TyLxQMzBTeemhWX4TJJr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719277683; c=relaxed/simple;
	bh=ADUMmIJTjjiXu1V4OhaSlYff0Kd2Es2IepT9SGAdtWg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bih2ZO277UiaM+ZpqAGJV3L0KPKiy8jsyCF3quYCft1c5rF5D2c1bjm3Rm81oVOR3no+8vDaCOQTYJr9CtQvXGDPBxAqEt/S117barUGjQQYCaxBuHTopu3dWK7IByJBztcIKA5hdMz091oJHJz93FVe7Mw578ZvgayuiVAXkKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=GcA9g4++; arc=none smtp.client-ip=115.124.30.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1719277678; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=Lwl4mROnTtmAvWH/rz1uCxV8+8BE7k/ToLx83D9L/Dg=;
	b=GcA9g4++0qljm4rcDHgNeQvx+xxgNBLgr234IlN84D7A0z5lgVmmPdKuoE4eRm6ihvSCYfDdqVq11PIGsj/oadukjQw/ZL9xh7CUrB2n1L/DSvHnsmrUWKxEjrcBh2PnE5Y6w8i5qaCDMAWXNuTFB6Bmx0o8c5CIZqUJjJLxKRo=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033068173054;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0W9DR4Ql_1719277360;
Received: from 192.168.3.4(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0W9DR4Ql_1719277360)
          by smtp.aliyun-inc.com;
          Tue, 25 Jun 2024 09:02:41 +0800
Message-ID: <00e92d3f-7bdd-44b8-8a2f-ea07fd47d040@linux.alibaba.com>
Date: Tue, 25 Jun 2024 09:02:40 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] erofs: fix possible memory leak in z_erofs_gbuf_exit()
To: Sandeep Dhavale <dhavale@google.com>, linux-erofs@lists.ozlabs.org,
 Gao Xiang <xiang@kernel.org>, Chao Yu <chao@kernel.org>,
 Yue Hu <huyue2@coolpad.com>, Jeffle Xu <jefflexu@linux.alibaba.com>,
 Chunhai Guo <guochunhai@vivo.com>
Cc: kernel-team@android.com, linux-kernel@vger.kernel.org
References: <20240624220206.3373197-1-dhavale@google.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20240624220206.3373197-1-dhavale@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2024/6/25 06:02, Sandeep Dhavale wrote:
> Because we incorrectly reused of variable `i` in `z_erofs_gbuf_exit()`
> for inner loop, we may exit early from outer loop resulting in memory
> leak. Fix this by using separate variable for iterating through inner loop.
> 
> Fixes: f36f3010f676 ("erofs: rename per-CPU buffers to global buffer pool and make it configurable")
> 
> Signed-off-by: Sandeep Dhavale <dhavale@google.com>

Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Thanks,
Gao Xiang

> ---
>   fs/erofs/zutil.c | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/erofs/zutil.c b/fs/erofs/zutil.c
> index 036024bce9f7..b80f612867c2 100644
> --- a/fs/erofs/zutil.c
> +++ b/fs/erofs/zutil.c
> @@ -148,7 +148,7 @@ int __init z_erofs_gbuf_init(void)
>   
>   void z_erofs_gbuf_exit(void)
>   {
> -	int i;
> +	int i, j;
>   
>   	for (i = 0; i < z_erofs_gbuf_count + (!!z_erofs_rsvbuf); ++i) {
>   		struct z_erofs_gbuf *gbuf = &z_erofs_gbufpool[i];
> @@ -161,9 +161,9 @@ void z_erofs_gbuf_exit(void)
>   		if (!gbuf->pages)
>   			continue;
>   
> -		for (i = 0; i < gbuf->nrpages; ++i)
> -			if (gbuf->pages[i])
> -				put_page(gbuf->pages[i]);
> +		for (j = 0; j < gbuf->nrpages; ++j)
> +			if (gbuf->pages[j])
> +				put_page(gbuf->pages[j]);
>   		kfree(gbuf->pages);
>   		gbuf->pages = NULL;
>   	}

