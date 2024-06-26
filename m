Return-Path: <linux-kernel+bounces-230941-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 293A7918425
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 16:29:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D8518288E1F
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 14:29:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04536188CBD;
	Wed, 26 Jun 2024 14:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XsbkZlkn"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF9E1187354
	for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 14:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719412095; cv=none; b=Eo/ACWyBrXlXtsujjsUZ39BEes4m27PHrQFIjTtgmmG4mBL9Jl6x8mak4OtVjU9mYARRCE8c4vwuGlvy/2L1OQaSnddhQkevL2mnmMO2n5tjcRm5i9fuSJDweGKUcbx3lV+OZL49MufMa1zapoFX71qGeBmALtpY233ZnySwqn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719412095; c=relaxed/simple;
	bh=ATPAf+kNfDhpaJ/KEuy+Gq8rjUcecDTtvWVNbCP3D4o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LkLr96H1ABDYwxhrkzy8NT/vx3azcXrTa2T5t9PqqXo7ZV1Wj8fjY9L7J/0+KXL6xfVqS95rE1i9+uVH6MzJ0hcwMH//zyXy3JVwZxfsfEhIokkTy6U72zzxu8T0yvDZF5PMv9nNt+Ncw9tQd6VOofO4TriljOjWnYCJS0DalJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XsbkZlkn; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719412092;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=f/HcaWei1+g0z5tguQtmN7bt92j3/7nt6PMTKiEI6IA=;
	b=XsbkZlknrMVQOKSfTt+IHSRwl4wCxTlW2TS4H7Jg1orB+/Plc4DgT8JopogFT1NGu63id8
	UGTR69dH3890fSUxMUr7jyfCqr0bUHkHr5ufdlb3FjfZpKj5imak05x10BLnBg6tYdiGPx
	h59CF8Ar27kdu++l8BXkh0zNfPFN2lM=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-211-lj5JH7wMNvKQ7llts_K_jQ-1; Wed,
 26 Jun 2024 10:28:06 -0400
X-MC-Unique: lj5JH7wMNvKQ7llts_K_jQ-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 79A9F1955EAB;
	Wed, 26 Jun 2024 14:28:04 +0000 (UTC)
Received: from localhost (unknown [10.72.116.83])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7638E1956087;
	Wed, 26 Jun 2024 14:28:01 +0000 (UTC)
Date: Wed, 26 Jun 2024 22:27:52 +0800
From: Baoquan He <bhe@redhat.com>
To: "Uladzislau Rezki (Sony)" <urezki@gmail.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Hailong Liu <hailong.liu@oppo.com>,
	Christoph Hellwig <hch@infradead.org>,
	Nick Bowler <nbowler@draconx.ca>,
	Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>
Subject: Re: [PATCH] mm: vmalloc: Check if a hash-index is in
 cpu_possible_mask
Message-ID: <ZnwlaGtDpMz8rALN@MiWiFi-R3L-srv>
References: <20240626114324.87334-1-urezki@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240626114324.87334-1-urezki@gmail.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

On 06/26/24 at 01:43pm, Uladzislau Rezki (Sony) wrote:
> The problem is that there are systems where cpu_possible_mask
> has gaps between set CPUs, for example SPARC. In this scenario
> addr_to_vb_xa() hash function can return an index which accesses
> to not-possible and not setup CPU area using per_cpu() macro.
> 
> A per-cpu vmap_block_queue is also used as hash table assuming
                                                        ~~~~~
> that incorrectly assumes the cpu_possible_mask has not gaps.
                   ~~~~~~
                         Typo of duplicated word?

Other than above nit, this looks good to me. Thanks.

Reviewed-by: Baoquan He <bhe@redhat.com>

> 
> Fix it by adjusting an index to a next possible CPU.
> 
> Fixes: 062eacf57ad9 ("mm: vmalloc: remove a global vmap_blocks xarray")
> Reported-by: Nick Bowler <nbowler@draconx.ca>
> Closes: https://lore.kernel.org/linux-kernel/ZntjIE6msJbF8zTa@MiWiFi-R3L-srv/T/
> Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> ---
>  mm/vmalloc.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> index b4c42da9f3901..6b783baf12a14 100644
> --- a/mm/vmalloc.c
> +++ b/mm/vmalloc.c
> @@ -2544,7 +2544,15 @@ static DEFINE_PER_CPU(struct vmap_block_queue, vmap_block_queue);
>  static struct xarray *
>  addr_to_vb_xa(unsigned long addr)
>  {
> -	int index = (addr / VMAP_BLOCK_SIZE) % num_possible_cpus();
> +	int index = (addr / VMAP_BLOCK_SIZE) % nr_cpu_ids;
> +
> +	/*
> +	 * Please note, nr_cpu_ids points on a highest set
> +	 * possible bit, i.e. we never invoke cpumask_next()
> +	 * if an index points on it which is nr_cpu_ids - 1.
> +	 */
> +	if (!cpu_possible(index))
> +		index = cpumask_next(index, cpu_possible_mask);
>  
>  	return &per_cpu(vmap_block_queue, index).vmap_blocks;
>  }
> -- 
> 2.39.2
> 


