Return-Path: <linux-kernel+bounces-295089-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AAA7959692
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 10:32:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D9DF0B203E5
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 08:32:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFC621C1AB5;
	Wed, 21 Aug 2024 07:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="VhzMU89X"
Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A88F61C1AAF
	for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 07:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.112
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724227173; cv=none; b=ntEyRfyupywTlhueINAqxOItj09nGFg7tD5lO/nHbnO3ikyehe9U3S+SdMw+Vv4PE7a3zgWcR4P98ytsmK2qYvwHWDf3xPD2AyIeWAx4acUGyRWI41UmktXpXFySIw4kOZDmsOLrB/tbn1Ui75Q4eOApmPresZFZcs9TmTL0zM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724227173; c=relaxed/simple;
	bh=4pMNIxxEMJpxpxArXBjW5/A+4n4gdIecGUYoryNVl6M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iSF6PENDtwCFDXfMCgiOYbWAZlMcr0ZpLP6Io6DJCDC9lfPJ3R8N0FblRfzD8+nc+WZPYVVwTcLWX/7EscvbmeIopiBXC8BPI3DHlOsxH3mo4EIwNd5VkpSgyyAppDzYX9EGtRiMBGooOBS/wUnyE9ZeGkcpctS//v1AbfwecIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=VhzMU89X; arc=none smtp.client-ip=115.124.30.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1724227161; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=i67HIuhL2xxPqVb9SyyXkR0ZFGlDbI16z18pc4DNxEY=;
	b=VhzMU89XIouqF86oUscKjgLKrXFk6cK40N9TdjAoPup5jwH4/sXHBj4lTHR3dKJsaeigkG9fYv3zqoiQ9Lu80FtuMDY6k4FIZnYm3Nqkrg/IayfEflz4VkglfnXRyufMsKm90AtfjZHZRfHOHYl/GzFsaPo7ojLEAuBMrNN/sYc=
Received: from 30.221.129.221(mailfrom:joseph.qi@linux.alibaba.com fp:SMTPD_---0WDLAw5d_1724227160)
          by smtp.aliyun-inc.com;
          Wed, 21 Aug 2024 15:59:20 +0800
Message-ID: <b1e6e5af-696c-4bfb-a233-7a0821246ce4@linux.alibaba.com>
Date: Wed, 21 Aug 2024 15:59:20 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V4 2/2] ocfs2: Fix possible null-ptr-deref in
 ocfs2_set_buffer_uptodate
To: Lizhi Xu <lizhi.xu@windriver.com>, akpm <akpm@linux-foundation.org>
Cc: heming.zhao@suse.com, jlbec@evilplan.org, linux-kernel@vger.kernel.org,
 mark@fasheh.com, ocfs2-devel@lists.linux.dev,
 syzbot+ab134185af9ef88dfed5@syzkaller.appspotmail.com,
 syzkaller-bugs@googlegroups.com
References: <20240821055546.3254888-1-lizhi.xu@windriver.com>
 <20240821061450.3478602-1-lizhi.xu@windriver.com>
Content-Language: en-US
From: Joseph Qi <joseph.qi@linux.alibaba.com>
In-Reply-To: <20240821061450.3478602-1-lizhi.xu@windriver.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 8/21/24 2:14 PM, Lizhi Xu wrote:
> When doing cleanup, if flags without OCFS2_BH_READAHEAD, it may trigger
> NULL pointer dereference in the following ocfs2_set_buffer_uptodate() if
> bh is NULL.
> 
> Reported-and-suggested-by: Heming Zhao <heming.zhao@suse.com>
> Signed-off-by: Lizhi Xu <lizhi.xu@windriver.com>

Reviewed-by: Joseph Qi <joseph.qi@linux.alibaba.com>
> ---
> V3 -> V4: Update comments and subject
> 
>  fs/ocfs2/buffer_head_io.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/ocfs2/buffer_head_io.c b/fs/ocfs2/buffer_head_io.c
> index e62c7e1de4eb..8f714406528d 100644
> --- a/fs/ocfs2/buffer_head_io.c
> +++ b/fs/ocfs2/buffer_head_io.c
> @@ -388,7 +388,8 @@ int ocfs2_read_blocks(struct ocfs2_caching_info *ci, u64 block, int nr,
>  		/* Always set the buffer in the cache, even if it was
>  		 * a forced read, or read-ahead which hasn't yet
>  		 * completed. */
> -		ocfs2_set_buffer_uptodate(ci, bh);
> +		if (bh)
> +			ocfs2_set_buffer_uptodate(ci, bh);
>  	}
>  	ocfs2_metadata_cache_io_unlock(ci);
>  

