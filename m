Return-Path: <linux-kernel+bounces-358506-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B9BD998036
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 10:39:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B7E6F1F223C4
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 08:39:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B05D81BC9E3;
	Thu, 10 Oct 2024 08:15:30 +0000 (UTC)
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E0EC1B2EFB
	for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 08:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728548130; cv=none; b=Sl6rHNsAgC+rBCLDIre41EarWzePf1mXqkhAJ4loyw29xORy/76T4MK72d+2aylLgXRtAgoIaM3jMxv7rOyLbJxeoW9uHF3sUcTRIg+i1GBMOSdz0vO8ufsCx0i58Jxj/JXJnW/gNKUprWqZbgoDgGaBLF6sYvKd1gysOPcNLwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728548130; c=relaxed/simple;
	bh=RTMxEguuUUrG1JCoCkF/wmpDBI0rBfkMH2AKLxKyKt0=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=ifw49C0kapKimQtw0Na/32/nhuBMyrBqwuXikz2In+huh6NnD03vjL56ZxB25yLxY3rwbAvT68fP+xJq+U7/YZXLVt8A5sYW6W41wFRXdD7fhmQPBf8noxPbyifD6Lx0ivMCvSzSAF9Qe6SHy6WNC4qFvdUpT/d7+zdIPbS3VyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4XPMwp4Mt6z1j9cn;
	Thu, 10 Oct 2024 16:14:18 +0800 (CST)
Received: from dggpemf100006.china.huawei.com (unknown [7.185.36.228])
	by mail.maildlp.com (Postfix) with ESMTPS id D19A41A016C;
	Thu, 10 Oct 2024 16:15:24 +0800 (CST)
Received: from [10.174.178.55] (10.174.178.55) by
 dggpemf100006.china.huawei.com (7.185.36.228) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 10 Oct 2024 16:15:24 +0800
Subject: Re: [patch 19/25] debugobjects: Prepare for batching
To: Thomas Gleixner <tglx@linutronix.de>, LKML <linux-kernel@vger.kernel.org>
CC: Waiman Long <longman@redhat.com>
References: <20241007163507.647617031@linutronix.de>
 <20241007164914.139204961@linutronix.de>
From: "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Message-ID: <59009a0b-cd3e-0a7b-75f5-8c5515b852cd@huawei.com>
Date: Thu, 10 Oct 2024 16:15:23 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20241007164914.139204961@linutronix.de>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemf100006.china.huawei.com (7.185.36.228)



On 2024/10/8 0:50, Thomas Gleixner wrote:
> Move the debug_obj::object pointer into a union and add a pointer to the
> last node in a batch. That allows to implement batch processing efficiently
> by utilizing the stack property of hlist:
> 
> When the first object of a batch is added to the list, then the batch
> pointer is set to the hlist node of the object itself. Any subsequent add
> retrieves the pointer to the last node from the first object in the list
> and uses that for storing the last node pointer in the newly added object.
> 
> Add the pointer to the data structure and ensure that all relevant pool
> sizes are strictly batch sized. The actual batching implementation follows
> in subsequent changes.

Reviewed-by: Zhen Lei <thunder.leizhen@huawei.com>

> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> ---
>  include/linux/debugobjects.h |   12 ++++++++----
>  lib/debugobjects.c           |   10 +++++++---
>  2 files changed, 15 insertions(+), 7 deletions(-)
> 
> --- a/include/linux/debugobjects.h
> +++ b/include/linux/debugobjects.h
> @@ -23,13 +23,17 @@ struct debug_obj_descr;
>   * @state:	tracked object state
>   * @astate:	current active state
>   * @object:	pointer to the real object
> + * @batch_last:	pointer to the last hlist node in a batch
>   * @descr:	pointer to an object type specific debug description structure
>   */
>  struct debug_obj {
> -	struct hlist_node	node;
> -	enum debug_obj_state	state;
> -	unsigned int		astate;
> -	void			*object;
> +	struct hlist_node		node;
> +	enum debug_obj_state		state;
> +	unsigned int			astate;
> +	union {
> +		void			*object;
> +		struct hlist_node	*batch_last;
> +	};
>  	const struct debug_obj_descr *descr;
>  };
>  
> --- a/lib/debugobjects.c
> +++ b/lib/debugobjects.c
> @@ -21,11 +21,15 @@
>  #define ODEBUG_HASH_BITS	14
>  #define ODEBUG_HASH_SIZE	(1 << ODEBUG_HASH_BITS)
>  
> -#define ODEBUG_POOL_SIZE	1024
> -#define ODEBUG_POOL_MIN_LEVEL	256
> -#define ODEBUG_POOL_PERCPU_SIZE	64
> +/* Must be power of two */
>  #define ODEBUG_BATCH_SIZE	16
>  
> +/* Initial values. Must all be a multiple of batch size */
> +#define ODEBUG_POOL_SIZE	(64 * ODEBUG_BATCH_SIZE)
> +#define ODEBUG_POOL_MIN_LEVEL	(ODEBUG_POOL_SIZE / 4)
> +
> +#define ODEBUG_POOL_PERCPU_SIZE	(4 * ODEBUG_BATCH_SIZE)
> +
>  #define ODEBUG_CHUNK_SHIFT	PAGE_SHIFT
>  #define ODEBUG_CHUNK_SIZE	(1 << ODEBUG_CHUNK_SHIFT)
>  #define ODEBUG_CHUNK_MASK	(~(ODEBUG_CHUNK_SIZE - 1))
> 
> .
> 

-- 
Regards,
  Zhen Lei

