Return-Path: <linux-kernel+bounces-375605-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ED589A981A
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 07:07:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2EFF0284D12
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 05:07:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEB9C12D1EA;
	Tue, 22 Oct 2024 05:07:14 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7207E45945
	for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 05:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729573634; cv=none; b=K1FX0YS/hKtoX8slQxmeWPq8+JE/EVSTEpvGCJW4rRL/1hAX4xRF9ioCJM8pkf1OFcRzhJHvGbjWj2D3nqlsz4ekT9vXYvBvKE6bKDbg4g3f41Y/uvQcAj/BcwYgcEeZ3E4H8LHwyUYyyOy/fgLDfKeoWJ0WSYwkLxYUOsi6lpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729573634; c=relaxed/simple;
	bh=ytDddSakrkvCe/zrmqq7bS00L+F/pGIcl1KpNi5gLTg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qtKCqHfl1yBwhX1jEXiAgvZboMFbdbugU1SGhPTQn4g1NJ5M5C9KJrn1pmC/tuqMSnWe0BCLsz5dfnm4GXXZMDrQd3f/0YW2ugy7XTV2P1051zg3FO5MTZ0ZxNMvry4s0M/oZqloxzaXr6jEm6yDaXAQdzAekljPqgkQwLGJCds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3A408497;
	Mon, 21 Oct 2024 22:07:40 -0700 (PDT)
Received: from [10.163.41.149] (unknown [10.163.41.149])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 787123F528;
	Mon, 21 Oct 2024 22:07:07 -0700 (PDT)
Message-ID: <a11f46f7-29bc-4242-bd8b-d316065607e2@arm.com>
Date: Tue, 22 Oct 2024 10:37:05 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/page_alloc: Use str_off_on() helper in
 build_all_zonelists()
To: Thorsten Blum <thorsten.blum@linux.dev>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20241021091340.5243-2-thorsten.blum@linux.dev>
Content-Language: en-US
From: Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <20241021091340.5243-2-thorsten.blum@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 10/21/24 14:43, Thorsten Blum wrote:
> Remove hard-coded strings by using the str_off_on() helper function.
> 
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
> ---
>  mm/page_alloc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 8afab64814dc..11d3fa3587db 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -5495,7 +5495,7 @@ void __ref build_all_zonelists(pg_data_t *pgdat)
>  
>  	pr_info("Built %u zonelists, mobility grouping %s.  Total pages: %ld\n",
>  		nr_online_nodes,
> -		page_group_by_mobility_disabled ? "off" : "on",
> +		str_off_on(page_group_by_mobility_disabled),
>  		vm_total_pages);
>  #ifdef CONFIG_NUMA
>  	pr_info("Policy zone: %s\n", zone_names[policy_zone]);

There are multiple other instances which could use similar str_on_off() as well.

mm/kasan/hw_tags.c:             kasan_vmalloc_enabled() ? "on" : "off",
mm/kasan/hw_tags.c:             kasan_stack_collection_enabled() ? "on" : "off");
mm/kasan/sw_tags.c:             kasan_stack_collection_enabled() ? "on" : "off");
mm/mm_init.c:           stack, want_init_on_alloc(GFP_KERNEL) ? "on" : "off",
mm/mm_init.c:           want_init_on_free() ? "on" : "off");

I would suggest converting all of them together in a single patch instead.

