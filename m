Return-Path: <linux-kernel+bounces-232957-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 781D891B079
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 22:33:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 266181F22492
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 20:33:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BE0719F49D;
	Thu, 27 Jun 2024 20:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="dCpmUrBv"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B47A319F467
	for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2024 20:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719520413; cv=none; b=ViEFVrSE09jSP0kUkPCt2TYSPoq3LziiJes9skVYO1G6CFCQd6AL9E0BIo12BqX4VbXd5OzH6gN338E/G8NFQ2bqIR86VC7rlPJGvDWMEyey2y+KRP+c4HszhtWTRy7reLWE4sVk7eoqEug5zluubCrN3Z90r5KvY0neAmBnfh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719520413; c=relaxed/simple;
	bh=DzCemOMDrWk1p2PXFfLQ5rRwDU+Hjn16YC9hoJNhjwQ=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=iDz+VIeKwQ6bbdZYCE6aQ19Vv31/rx4OKq0m7ZeACUQ7KY8HmvC991h95pcL3PxCvR0+nJW77AKxDosizGCj/RKdjoPJ6Q07v0PZ2xUMfF/Liq/hLOi+pCjNzyNWoppzPQskHoaUCiUBfNzSan3GQiDTDBkgwDYhJgyh2MyX/5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=dCpmUrBv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8C9DC2BD10;
	Thu, 27 Jun 2024 20:33:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1719520411;
	bh=DzCemOMDrWk1p2PXFfLQ5rRwDU+Hjn16YC9hoJNhjwQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=dCpmUrBvfeAw4x0uhl4yAPoiUEkkv1tpxXEDxwc2UQt2nQuDnWnXQCftnD04pu8NG
	 lfqRH7HRVqxop8RdonCJfzYzLE2akqY/OkLtzcFf9zSoCqZ8/AOSdzI0kkKuUgMvbu
	 Dt3bLmc1DlcKmXP7Kn6ZHZ7TT1rYDS1B+2qv4Guw=
Date: Thu, 27 Jun 2024 13:33:30 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Chengming Zhou <chengming.zhou@linux.dev>
Cc: minchan@kernel.org, senozhatsky@chromium.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] mm/zsmalloc: fix class per-fullness zspage counts
Message-Id: <20240627133330.7f8a82078725228585dbf2d3@linux-foundation.org>
In-Reply-To: <20240627075959.611783-1-chengming.zhou@linux.dev>
References: <20240627075959.611783-1-chengming.zhou@linux.dev>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 27 Jun 2024 15:59:58 +0800 Chengming Zhou <chengming.zhou@linux.dev> wrote:

> We always use insert_zspage() and remove_zspage() to update zspage's
> fullness location, which will account correctly.
> 
> But this special async free path use "splice" instead of remove_zspage(),
> so the per-fullness zspage count for ZS_INUSE_RATIO_0 won't decrease.
> 
> Fix it by decreasing when iterate over the zspage free list.
>
> ...
>
> Signed-off-by: Chengming Zhou <chengming.zhou@linux.dev>
> +++ b/mm/zsmalloc.c
> @@ -1883,6 +1883,7 @@ static void async_free_zspage(struct work_struct *work)
>  
>  		class = zspage_class(pool, zspage);
>  		spin_lock(&class->lock);
> +		class_stat_dec(class, ZS_INUSE_RATIO_0, 1);
>  		__free_zspage(pool, class, zspage);
>  		spin_unlock(&class->lock);
>  	}

What are the runtime effects of this bug?  Should we backport the fix
into earlier kernels?  And are we able to identify the appropriate
Fixes: target?

Thanks.

