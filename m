Return-Path: <linux-kernel+bounces-337825-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CE160984F73
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 02:27:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 87919284D3A
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 00:27:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ABF08BE0;
	Wed, 25 Sep 2024 00:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="AAP9i+g5"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E94E55223
	for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 00:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727224041; cv=none; b=Y1ZdwFs+rYyo1Mvk7Zf2L1pElyFY2FFAxjnxrSLxAziirnopvbsV1iJYcnKPiGpoprbKEZ5mKUUs3dAiBMgnXS6xKXJ2+n+m7OCi+C75uA7rSqGWH+7o8lpoGxa6S/lXUvry602qKu7wZpNjjdtu1QUJN3LiveKgBKxkpVuJqM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727224041; c=relaxed/simple;
	bh=Z4RkI2XCR/URBobI3g/0VbmMRzi4VsCIdRH6RvE7uTw=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=P3Ga6vHVCFqRJ1hEbGtRkVpZ9dqEUGlzF/IUNSQ8Ihdt7xf6nVpJ9rXnveAn/WfoFxidIiB7ouWomGZ6InsFY0PX49DPK5MQUBebtQhj3NZfDQ8PF+lXsqYX9s+EEaj3PkMl8IX8+Yxd2IPqEe7ORTF7cHLnBACkWAMIrUMJ3gk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=AAP9i+g5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 513D9C4CEC4;
	Wed, 25 Sep 2024 00:27:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1727224040;
	bh=Z4RkI2XCR/URBobI3g/0VbmMRzi4VsCIdRH6RvE7uTw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=AAP9i+g5EnqoBd7ofnlINLmnTTI7pf6hjkHge+rAl/hL1OQlFoq/s8wDssOfWHGYJ
	 UhDn6TC0uadAnNH85/X/lHJ/DTY8hR0yI8xiK9dF08/B3j6yloX+eZpbawmvfH+Whx
	 uDgQ7RemLXae4hxBtL2OlME/6G3wt7d/6X0WFFUM=
Date: Tue, 24 Sep 2024 17:27:19 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Xiang Gao <gxxa03070307@gmail.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, gaoxiang17
 <gaoxiang17@xiaomi.com>
Subject: Re: [PATCH] mm/cma.c: To better understand cma area during
 debugging, add total and used count logs to in cma_alloc
Message-Id: <20240924172719.a486793abd66643d9938081f@linux-foundation.org>
In-Reply-To: <20240918124325.109236-1-gxxa03070307@gmail.com>
References: <20240918124325.109236-1-gxxa03070307@gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 18 Sep 2024 20:43:25 +0800 Xiang Gao <gxxa03070307@gmail.com> wrote:

> From: gaoxiang17 <gaoxiang17@xiaomi.com>
> 
> [   24.225125] cma: cma_alloc(cma (____ptrval____), name: reserved, total count 16384, used count: 64, request count 1, align 0)
> [   24.231963] cma: cma_alloc(cma (____ptrval____), name: reserved, total count 16384, used count: 65, request count 1, align 0)
> [   24.235712] cma: cma_alloc(cma (____ptrval____), name: reserved, total count 16384, used count: 66, request count 1, align 0)
> 

Providing before-and-after output would make the proposal more easily
understood.

> --- a/mm/cma.c
> +++ b/mm/cma.c
> @@ -403,6 +403,17 @@ static void cma_debug_show_areas(struct cma *cma)
>  	spin_unlock_irq(&cma->lock);
>  }
>  
> +static unsigned long cma_get_used(struct cma *cma)
> +{
> +	unsigned long used;
> +
> +	spin_lock_irq(&cma->lock);
> +	used = bitmap_weight(cma->bitmap, (int)cma_bitmap_maxno(cma));

Is the (int) cast needed?

> +	spin_unlock_irq(&cma->lock);
> +
> +	return (unsigned long)used << cma->order_per_bit;

Is the (unsigned long) bast needed?

> +}
> +
>  /**
>   * cma_alloc() - allocate pages from contiguous area
>   * @cma:   Contiguous memory region for which the allocation is performed.
> @@ -430,8 +441,8 @@ struct page *cma_alloc(struct cma *cma, unsigned long count,
>  	if (!cma || !cma->count || !cma->bitmap)
>  		return page;
>  
> -	pr_debug("%s(cma %p, name: %s, count %lu, align %d)\n", __func__,
> -		(void *)cma, cma->name, count, align);
> +	pr_debug("%s(cma %p, name: %s, total count %lu, used count: %lu, request count %lu, align %d)\n", __func__,
> +		(void *)cma, cma->name, cma->count, cma_get_used(cma), count, align);
>  
>  	if (!count)
>  		return page;
> -- 
> 2.34.1

