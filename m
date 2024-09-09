Return-Path: <linux-kernel+bounces-320571-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A7BA970C12
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 04:57:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2344A281FF3
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 02:57:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC75F1AC891;
	Mon,  9 Sep 2024 02:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="L7/xVjOx"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94EE714F135
	for <linux-kernel@vger.kernel.org>; Mon,  9 Sep 2024 02:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725850632; cv=none; b=KavNSjtS3htmPJshegrRfOiSN+3UhuVjiyw59C5F+exIq2NHuxAStQf1+75vDlATEJWUhE763EWClzyZvUcv9KVHTNmN/ziXsASwB04kpqH6zKkSGwGqRekmS9mkTu04+fmlKxHwSj1LswVOzDw7h7844kzNmx4TGwWMHI3GxMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725850632; c=relaxed/simple;
	bh=aGBpBECIxUDcJl7d2FvRplKeeGBsPRv2Xidc2s0bMes=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=el00VqRQ9dFNCX2M2xPuv/djdUfHfrtjBuqlnG1lQzgGBlBUTYnnYxvZvbyT3+f1SjqfBJgGydRaIS3xfwZx1opQJ23CdUKOG/M7EIsFUMJBND6qjuS/mmunkRs+ybth+kChYshh7O+I9e2Q2/IQQKGxdEUk6iWJVuP8eWbbGUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=L7/xVjOx; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725850629;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=auyTagAR38/zXhvomOHgx5kToruU3DjXNgh8gDAvr98=;
	b=L7/xVjOxeUo2C1MH73OWOEH3pZBGPcWadr5aHZrLfiuYskCaYYT4eKX+74Mbr4IHzSU4AS
	phV5rP75AMH+3xx8Rs4wWhpyaVPQLAluYKYoBjSKM7m+YRrAIrjLyZTWwLRytuEFvoNGGg
	9mMN9tEWIYi/CRsKxZCmrNiJsSYBK9Y=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-199-pGVghPk5NqKckzPzmSfDCQ-1; Sun,
 08 Sep 2024 22:57:06 -0400
X-MC-Unique: pGVghPk5NqKckzPzmSfDCQ-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id DAFF51953954;
	Mon,  9 Sep 2024 02:57:03 +0000 (UTC)
Received: from localhost (unknown [10.72.112.58])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4140A19560AA;
	Mon,  9 Sep 2024 02:57:01 +0000 (UTC)
Date: Mon, 9 Sep 2024 10:56:57 +0800
From: Baoquan He <bhe@redhat.com>
To: "Uladzislau Rezki (Sony)" <urezki@gmail.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Christoph Hellwig <hch@infradead.org>,
	Michal Hocko <mhocko@suse.com>,
	Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>
Subject: Re: [PATCH] mm/vmalloc.c: Use "high-order" in description non
 0-order pages
Message-ID: <Zt5j+c/SUNvCMY/+@MiWiFi-R3L-srv>
References: <20240906095049.3486-1-urezki@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240906095049.3486-1-urezki@gmail.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On 09/06/24 at 11:50am, Uladzislau Rezki (Sony) wrote:
> In many places, in the comments, we use both "higher-order" and
> "high-order" to describe the non 0-order pages. That is confusing,
> because a "higher-order" statement does not reflect what it is
> compared with.
> 
> Suggested-by: Baoquan He <bhe@redhat.com>
> Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> ---
>  mm/vmalloc.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

This looks good to me, thanks.

Reviewed-by: Baoquan He <bhe@redhat.com>

By the way, do you plan to clean up the rest of them in other places?

> 
> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> index 37b6e987234e..c7bd8740b8a2 100644
> --- a/mm/vmalloc.c
> +++ b/mm/vmalloc.c
> @@ -3590,7 +3590,7 @@ vm_area_alloc_pages(gfp_t gfp, int nid,
>  			break;
>  
>  		/*
> -		 * Higher order allocations must be able to be treated as
> +		 * High-order allocations must be able to be treated as
>  		 * independent small pages by callers (as they can with
>  		 * small-page vmallocs). Some drivers do their own refcounting
>  		 * on vmalloc_to_page() pages, some use page->mapping,
> @@ -3653,7 +3653,7 @@ static void *__vmalloc_area_node(struct vm_struct *area, gfp_t gfp_mask,
>  	page_order = vm_area_page_order(area);
>  
>  	/*
> -	 * Higher order nofail allocations are really expensive and
> +	 * High-order nofail allocations are really expensive and
>  	 * potentially dangerous (pre-mature OOM, disruptive reclaim
>  	 * and compaction etc.
>  	 *
> -- 
> 2.39.2
> 


