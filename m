Return-Path: <linux-kernel+bounces-235089-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 995C891CFDF
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jun 2024 04:51:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F3E061F21AD6
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jun 2024 02:51:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9F6528399;
	Sun, 30 Jun 2024 02:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="Ug+vfT52"
Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 074091E864
	for <linux-kernel@vger.kernel.org>; Sun, 30 Jun 2024 02:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719715893; cv=none; b=mxMBg+pg9hqgHXcah0n1G7WcAypwSlH9bdobKiZaZjazLI5DsUeXrfDOLLBqkJ2Qy/ZF4u0xk/e7qYHRAV04TpjG5WQtlALEBUANhB1Jbm0SZWhAQn6BpvkqWbTxFgJv3SDp+Cu2ssz9qquWMhMFnM7RMS/38bRV0qrtnK9H+Xw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719715893; c=relaxed/simple;
	bh=8exVNBhNNdcbPI6TllxHKJ3cEOqOLzGM0+EAOi6vD10=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Nwav/CbuPyHkc38EoTOWtioYOZeY+RzGPrDKjswF9lxlsJrI1PynFv/qooIIshI3+i+rJNnWJa/Hs61iTvw7WNaltG0AxAabMTOSfen0yb6L7e7CTFneR3iltZBs491gKQo28PmXxgKyGHFCjzTrGFdoX9uaUe5O4XOq/Qg9iyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=Ug+vfT52; arc=none smtp.client-ip=115.124.30.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1719715882; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=k2mW9kF0tcNvyXieKkWUUqtbjUaDk9gY5NZvuOVoRas=;
	b=Ug+vfT52xLwOlKQ47oav8ZXuMRAxfkikoK9cVRv8SxhmL/oXehloy1k+QOs8eRcJHtHy/fNOSRy5hX2+VlMYaZzYVCXp7W+Lxwq8h6nvnEXgnzZQh+1jS6GiKP0ZgzNOz4xMOjk84JRDGXUaWbLiqrXirNW84KvJ82EEeLU4ISg=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R661e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045046011;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=3;SR=0;TI=SMTPD_---0W9UWqM4_1719715880;
Received: from 30.27.95.242(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0W9UWqM4_1719715880)
          by smtp.aliyun-inc.com;
          Sun, 30 Jun 2024 10:51:21 +0800
Message-ID: <7adcf002-864e-489a-ac70-99c9850ea4f1@linux.alibaba.com>
Date: Sun, 30 Jun 2024 10:51:19 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] erofs: ensure m_llen is reset to 0 if metadata is invalid
To: linux-erofs@lists.ozlabs.org, Chao Yu <chao@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>
References: <20240629185743.2819229-1-hsiangkao@linux.alibaba.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20240629185743.2819229-1-hsiangkao@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2024/6/30 02:57, Gao Xiang wrote:
> Sometimes, the on-disk metadata might be invalid due to storage
> failure or other unknown issues.
user interrupts, storage failures, or other unknown causes.

> 
> In that case, z_erofs_map_blocks_iter() may still return a valid
> m_llen while other fields remain invalid (e.g., m_plen can be 0).
> 
> Due to the return value of z_erofs_scan_folio() in some path will
> be ignored on purpose, the following z_erofs_scan_folio() could
> then use the invalid value by accident.
> 
> Let's reset m_llen to 0 to prevent this.
> 
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
> ---
>   fs/erofs/zmap.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/fs/erofs/zmap.c b/fs/erofs/zmap.c
> index 9b248ee5fef2..74d3d7bffcf3 100644
> --- a/fs/erofs/zmap.c
> +++ b/fs/erofs/zmap.c
> @@ -711,6 +711,8 @@ int z_erofs_map_blocks_iter(struct inode *inode, struct erofs_map_blocks *map,
>   
>   	err = z_erofs_do_map_blocks(inode, map, flags);
>   out:
> +	if (err)
> +		map->m_llen = 0;
>   	trace_z_erofs_map_blocks_iter_exit(inode, map, flags, err);
>   	return err;
>   }

