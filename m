Return-Path: <linux-kernel+bounces-368023-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0DB09A0A0D
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 14:38:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 151081C22188
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 12:38:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55412209F3E;
	Wed, 16 Oct 2024 12:37:44 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71826209695
	for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 12:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729082264; cv=none; b=jip7Bn6H2iqH0jsR4uHNlEhl/nBQ6SrLANoIApNDy7yMQPVoMO7/MmTh5eBXQFekA9rsfUwqeYSgby+saIV8b/WsAmvqRFcQh61t6My8c3Gv12AENFKG3XwQMaGbXMGz7S65kFQYn8sbKgzsxzoBV3h2bZgDXsN/4HZStqZSMvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729082264; c=relaxed/simple;
	bh=Q/Uo4opeP72V0is0b5O0aSP69/Bj/BN6StF/fWqNNto=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DkdofT/w4ww3FJeVkU6A9adeBVqvF8mBcD0TMIvsJbCUX8/t9BOQdtCwXNY/xp/dLBte0+WBKHjUdDBM7taR17Qancw0SNpmDS/0ovhAejZEZoABYI3pwLgyh+XmwUHxcokoDtIgP5nkPC9rfOb3C0GbqiJLQ723DMcSCAEnt34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1B27AFEC;
	Wed, 16 Oct 2024 05:38:10 -0700 (PDT)
Received: from [10.163.39.8] (unknown [10.163.39.8])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BC7783F528;
	Wed, 16 Oct 2024 05:37:38 -0700 (PDT)
Message-ID: <162ff655-0c55-4aa8-9ca2-3f818a1233cd@arm.com>
Date: Wed, 16 Oct 2024 18:07:36 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] mm: numa_clear_kernel_node_hotplug: Add NUMA_NO_NODE
 check for node id
To: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>, linux-mm@kvack.org,
 Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, yuji2.ishikawa@toshiba.co.jp,
 Mike Rapoport <rppt@kernel.org>
References: <1729070461-13576-1-git-send-email-nobuhiro1.iwamatsu@toshiba.co.jp>
Content-Language: en-US
From: Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <1729070461-13576-1-git-send-email-nobuhiro1.iwamatsu@toshiba.co.jp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 10/16/24 14:51, Nobuhiro Iwamatsu wrote:
> The acquired memory blocks for reserved may include blocks outside of
> memory management. In this case, the nid variable is set to NUMA_NO_NODE
> (-1), so an error occurs in node_set().
> This adds a check using numa_valid_node() to numa_clear_kernel_node_hotplug()
> that skips node_set() when nid is set to NUMA_NO_NODE.
> 
> Fixes: 87482708210f ("mm: introduce numa_memblks")
> Cc: Mike Rapoport (Microsoft) <rppt@kernel.org>
> Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> Suggested-by: Yuji Ishikawa <yuji2.ishikawa@toshiba.co.jp>
> Signed-off-by: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
> ---
>  mm/numa_memblks.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> v2:
>   - Use numa_valid_node() instead of check.
>   - Add Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
>   - Update description.
>   - Drop RFC from subject.
> 
> diff --git a/mm/numa_memblks.c b/mm/numa_memblks.c
> index be52b93a9c58..a3877e9bc878 100644
> --- a/mm/numa_memblks.c
> +++ b/mm/numa_memblks.c
> @@ -349,7 +349,7 @@ static void __init numa_clear_kernel_node_hotplug(void)
>  	for_each_reserved_mem_region(mb_region) {
>  		int nid = memblock_get_region_node(mb_region);
>  
> -		if (nid != MAX_NUMNODES)
> +		if (numa_valid_node(nid))
>  			node_set(nid, reserved_nodemask);
>  	}
>  

Reviewed-by: Anshuman Khandual <anshuman.khandual@arm.com>

