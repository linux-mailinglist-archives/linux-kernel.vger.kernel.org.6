Return-Path: <linux-kernel+bounces-231003-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C36479184C8
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 16:47:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 783C41F27854
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 14:47:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E69A185083;
	Wed, 26 Jun 2024 14:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Hy7oK2+o"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C8441822C2
	for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 14:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719413244; cv=none; b=YBVEvEdWhRJf7JLlza6y51Cj7taFPbb1iz7IhN0W+F7O3F4ePVxAotZIESPEMIhCXVf5qyLqLXyxlGix+jeLc8D/W+cZfYIuMSmf+JpE9nik/mGNXSZQfMxBjbc1XK60HYHAf64jfoq7s64Jteh2y2jEilkMPVjisRj8CVz6spg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719413244; c=relaxed/simple;
	bh=tP3f01vd+AIq/sCU/RHF1Em96qtyYmLphIQ2Yw99zmQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LFwCGWY0PFzn45dQZ1tFEr7l0emcibkspLM0r3ZqDLuqo+oZB25+d9H3QoliEEQNLE7jEHXbwcC37MAlMo7mOb5ftDqNYggXlEOVAQM/pm5f+Slq/8eP+I+/rMKFRlkgwvYu8fGewybGNrCQJJT1KPX4LzNht0qe3ZH7Biv08RA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Hy7oK2+o; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719413241;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wisZg/aFZE5WteLo7J7P34UhgnjvqpXMSCIrSOFt5XA=;
	b=Hy7oK2+oormc70so4hMo0zEb8WOqlSeAdeoGNOiIZPKrKfJOldsn9jkkLaD1isBvZUSXrv
	GkDS4+NrOvnYKsgCZiqtuaYuP7orTk1IGzjsbJ/bkAP7lyfOeW3PKlFZB05bGD1OcvQwsa
	/YJK68fd5Y7NcVJWGeCMa4cyfZQXmI4=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-160-F_XHNrgrNB-CxNeZjy46Vg-1; Wed,
 26 Jun 2024 10:47:18 -0400
X-MC-Unique: F_XHNrgrNB-CxNeZjy46Vg-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 83B42195609F;
	Wed, 26 Jun 2024 14:47:16 +0000 (UTC)
Received: from localhost (unknown [10.72.116.83])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1BBD81955E91;
	Wed, 26 Jun 2024 14:47:14 +0000 (UTC)
Date: Wed, 26 Jun 2024 22:47:09 +0800
From: Baoquan He <bhe@redhat.com>
To: "Uladzislau Rezki (Sony)" <urezki@gmail.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Hailong Liu <hailong.liu@oppo.com>,
	Christoph Hellwig <hch@infradead.org>,
	Nick Bowler <nbowler@draconx.ca>,
	Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>
Subject: Re: [PATCH v2] mm: vmalloc: Check if a hash-index is in
 cpu_possible_mask
Message-ID: <Znwp7cDSI6f+laBg@MiWiFi-R3L-srv>
References: <20240626140330.89836-1-urezki@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240626140330.89836-1-urezki@gmail.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

On 06/26/24 at 04:03pm, Uladzislau Rezki (Sony) wrote:
> The problem is that there are systems where cpu_possible_mask
> has gaps between set CPUs, for example SPARC. In this scenario
> addr_to_vb_xa() hash function can return an index which accesses
> to not-possible and not setup CPU area using per_cpu() macro.
> 
> A per-cpu vmap_block_queue is also used as hash table, incorrectly
> assuming the cpu_possible_mask has no gaps. Fix it by adjusting an
> index to a next possible CPU.
> 
> v1 -> v2:
>  - update a commit message.
> 
> Fixes: 062eacf57ad9 ("mm: vmalloc: remove a global vmap_blocks xarray")
> Reported-by: Nick Bowler <nbowler@draconx.ca>
> Closes: https://lore.kernel.org/linux-kernel/ZntjIE6msJbF8zTa@MiWiFi-R3L-srv/T/
> Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> ---
>  mm/vmalloc.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)

LGTM,

Reviewed-by: Baoquan He <bhe@redhat.com>

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


