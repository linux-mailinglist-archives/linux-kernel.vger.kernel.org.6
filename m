Return-Path: <linux-kernel+bounces-195004-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0053E8D45EF
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 09:19:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8FFA21F22FB2
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 07:19:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6497155386;
	Thu, 30 May 2024 07:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="coaD3JiQ"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ACCB13DB9F
	for <linux-kernel@vger.kernel.org>; Thu, 30 May 2024 07:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717053548; cv=none; b=Am7yfSKm9BjCZSTyQrrqpQu/Yh6sWz46KhP8KoZTH4zeSGs+IzodaRAtQPO+bldUDygsNHAd338apw9dzdbfPpc91EgHUw7l+qI9LOLxwwijsRYDRFVz5MynWJjpRq18G2/FS7lMIjaUWVVBFE8VLMBeVIeFQ1n6YLvLGXmNhQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717053548; c=relaxed/simple;
	bh=7hPshm6CVQPCR0OThFXAcce1IaqHYN9wkAS6qfiOh4o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u+LHfNw3/3oSPKjRKWp9eIRbuiwnJzcyh/lx6pyTKMoqrvCnhDFt2g1w09+9DfPU/WgyboEw5V/W6imuqL16TXTNuqZ2tMG9uKgEcz/BsE2qvvDNQWTFWvLaWra8vjtl/CGttiEDos5r/l6RUnRpapRFVhFRMkYjC9mOVFinf0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=coaD3JiQ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717053545;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=iZGq8sKKqv0GQPGpX0nqEsoomt5Fgw2t8XRl12KY1wg=;
	b=coaD3JiQ9bvgko+w0R+skcBDCeuY2HcUhrScDb5J05/6PxqgfTaDmPYFmpTCaiMYaAd91g
	IuszAF8x//u7oFt06IoEYK+8OxAN+Mp47Pa1gicPNiaSmzPJDL7VQifUUdMbuRkyXH4RIS
	oo6cdjDKsbut6twN6dIqx7vF4hzpZBo=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-221-u-EL3OrGOryN3zr2_1fd2w-1; Thu, 30 May 2024 03:19:00 -0400
X-MC-Unique: u-EL3OrGOryN3zr2_1fd2w-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B28E4101A52C;
	Thu, 30 May 2024 07:18:59 +0000 (UTC)
Received: from localhost (unknown [10.72.116.34])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id D138D3C27;
	Thu, 30 May 2024 07:18:58 +0000 (UTC)
Date: Thu, 30 May 2024 15:18:55 +0800
From: Baoquan He <bhe@redhat.com>
To: "zhaoyang.huang" <zhaoyang.huang@unisoc.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Christoph Hellwig <hch@infradead.org>,
	Lorenzo Stoakes <lstoakes@gmail.com>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Zhaoyang Huang <huangzhaoyang@gmail.com>, steve.kang@unisoc.com
Subject: Re: [PATCH] mm: fix incorrect vbq reference in purge_fragmented_block
Message-ID: <ZlgoX1E4/juuP7+o@MiWiFi-R3L-srv>
References: <20240530025144.1570865-1-zhaoyang.huang@unisoc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240530025144.1570865-1-zhaoyang.huang@unisoc.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1

On 05/30/24 at 10:51am, zhaoyang.huang wrote:
> From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
> 
> Broken vbq->free reported on a v6.6 based system which is caused
> by invalid vbq->lock protect over vbq->free in purge_fragmented_block.
> This should be introduced by the Fixes below which ignored vbq->lock
> matter.

It will be helpful to provide more details, what's the symptom of the
brekage, and in which case vbq->free is broken.

> 
> Fixes: fc1e0d980037 ("mm/vmalloc: prevent stale TLBs in fully utilized blocks")
> 
> Signed-off-by: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
> ---
>  mm/vmalloc.c | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)
> 
> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> index 22aa63f4ef63..112b50431725 100644
> --- a/mm/vmalloc.c
> +++ b/mm/vmalloc.c
> @@ -2614,9 +2614,10 @@ static void free_vmap_block(struct vmap_block *vb)
>  }
>  
>  static bool purge_fragmented_block(struct vmap_block *vb,
> -		struct vmap_block_queue *vbq, struct list_head *purge_list,
> -		bool force_purge)
> +		struct list_head *purge_list, bool force_purge)
>  {
> +	struct vmap_block_queue *vbq;
> +
>  	if (vb->free + vb->dirty != VMAP_BBMAP_BITS ||
>  	    vb->dirty == VMAP_BBMAP_BITS)
>  		return false;
> @@ -2625,6 +2626,8 @@ static bool purge_fragmented_block(struct vmap_block *vb,
>  	if (!(force_purge || vb->free < VMAP_PURGE_THRESHOLD))
>  		return false;
>  
> +	vbq = container_of(addr_to_vb_xa(vb->va->va_start),
> +		struct vmap_block_queue, vmap_blocks);
>  	/* prevent further allocs after releasing lock */
>  	WRITE_ONCE(vb->free, 0);
>  	/* prevent purging it again */
> @@ -2664,7 +2667,7 @@ static void purge_fragmented_blocks(int cpu)
>  			continue;
>  
>  		spin_lock(&vb->lock);
> -		purge_fragmented_block(vb, vbq, &purge, true);
> +		purge_fragmented_block(vb, &purge, true);
>  		spin_unlock(&vb->lock);
>  	}
>  	rcu_read_unlock();
> @@ -2801,7 +2804,7 @@ static void _vm_unmap_aliases(unsigned long start, unsigned long end, int flush)
>  			 * not purgeable, check whether there is dirty
>  			 * space to be flushed.
>  			 */
> -			if (!purge_fragmented_block(vb, vbq, &purge_list, false) &&
> +			if (!purge_fragmented_block(vb, &purge_list, false) &&
>  			    vb->dirty_max && vb->dirty != VMAP_BBMAP_BITS) {
>  				unsigned long va_start = vb->va->va_start;
>  				unsigned long s, e;
> -- 
> 2.25.1
> 
> 


