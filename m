Return-Path: <linux-kernel+bounces-286929-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FFED952086
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 18:54:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3CBA1287777
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 16:54:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 517331BB699;
	Wed, 14 Aug 2024 16:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="qDRbfxPj"
Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com [95.215.58.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D17E1B1409
	for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 16:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723654453; cv=none; b=grzuZTa2N9xEsmnCnpuzu0inJ65PECPCKYAQQkBxjnJfWss2ipk7yh634vEEQ050ygPTXNpf59rszEMSPL36FR3byRbNOaTQ6YoOCJfOSmHkByzV6cXanM+gLmomojD7UTDkif6ec+L0GyQ4bVdpKHyZTwjQGZkp9h/2cSqlWQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723654453; c=relaxed/simple;
	bh=BU4zEuE/FzoXgkeiwP3hGjtYmPvHNxBj+PElcXeoVWE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kpgBXGmLNkUIyIqxKTOi8GQnC6dY+NyQPzNbtwSxmVNJLIDLXzp1blDHGNP2opE0M+3SEvdoRQahZk+s8ZJb5knRHGFugsBKswT0nOAZcCYPODxFHhDo2Zof2tFslLDL3YegZ6WVlfTb2b3ZRf2sXHYZ3cjK3/VngY6q8n1Y4OU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=qDRbfxPj; arc=none smtp.client-ip=95.215.58.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Wed, 14 Aug 2024 09:54:00 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1723654448;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8iNjSLOWYSnpax906n7NCv/6QDFvRn3ZHzYLxFp7aGQ=;
	b=qDRbfxPjtIw6qAX6/qHOUEUQer0dZqW27JGbvbBTfSSNbu9zKXO94g+H7O3gGJYmCorYK+
	FPz1yb2xpb5BAiy7oPhKFLLAr/ZgBziE4YDsK2/eub5nrc1eevcRi85FTVJIuE/XaRso+g
	q/IOJpKnYXdp1mTrTf0jQzJth3aAM7Y=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
Cc: miklos@szeredi.hu, Amir Goldstein <amir73il@gmail.com>, 
	Christian Brauner <brauner@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Michal Hocko <mhocko@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fuse: use GFP_KERNEL_ACCOUNT for allocations in
 fuse_dev_alloc
Message-ID: <6emhfruzu3fujdkpld3j44qz5x2sg54xe7vjfqms552cammrhs@pef3mqv5p3qy>
References: <20240814112356.112329-1-aleksandr.mikhalitsyn@canonical.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240814112356.112329-1-aleksandr.mikhalitsyn@canonical.com>
X-Migadu-Flow: FLOW_OUT

Hi Alexander,

On Wed, Aug 14, 2024 at 01:23:56PM GMT, Alexander Mikhalitsyn wrote:
> fuse_dev_alloc() is called from the process context and it makes
> sense to properly account allocated memory to the kmemcg as these
> allocations are for long living objects.
> 
> Link: https://lore.kernel.org/all/20240105152129.196824-3-aleksandr.mikhalitsyn@canonical.com/
> 
> Cc: Miklos Szeredi <miklos@szeredi.hu>
> Cc: Amir Goldstein <amir73il@gmail.com>
> Cc: Christian Brauner <brauner@kernel.org>
> Cc: Johannes Weiner <hannes@cmpxchg.org>
> Cc: Michal Hocko <mhocko@kernel.org>
> Cc: Roman Gushchin <roman.gushchin@linux.dev>
> Cc: Shakeel Butt <shakeel.butt@linux.dev>
> Cc: <linux-fsdevel@vger.kernel.org>
> Cc: <linux-kernel@vger.kernel.org>
> Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
> ---
>  fs/fuse/inode.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
> index ed4c2688047f..6dae007186e1 100644
> --- a/fs/fuse/inode.c
> +++ b/fs/fuse/inode.c
> @@ -1486,11 +1486,11 @@ struct fuse_dev *fuse_dev_alloc(void)
>  	struct fuse_dev *fud;
>  	struct list_head *pq;
>  
> -	fud = kzalloc(sizeof(struct fuse_dev), GFP_KERNEL);
> +	fud = kzalloc(sizeof(struct fuse_dev), GFP_KERNEL_ACCOUNT);
>  	if (!fud)
>  		return NULL;
>  
> -	pq = kcalloc(FUSE_PQ_HASH_SIZE, sizeof(struct list_head), GFP_KERNEL);
> +	pq = kcalloc(FUSE_PQ_HASH_SIZE, sizeof(struct list_head), GFP_KERNEL_ACCOUNT);
>  	if (!pq) {
>  		kfree(fud);
>  		return NULL;

No objection from me but let me ask couple of questions to make sure we
know the impact of this change. It seems like this function is called
during mount() operation. Is that correct? If yes then basically the
admin process or node controller is being charged for this memory.
Nothing bad but this info should be in commit message. Also what is the
lifetime of these objects? From mount to unmount? Please add that info
as well. There are other unaccounted allocations in the fuse fs. Is
there a followup plan to include those as well?

thanks,
Shakeel

