Return-Path: <linux-kernel+bounces-242204-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94FF89284ED
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 11:17:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4F80C28E51C
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 09:17:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 274CF14659B;
	Fri,  5 Jul 2024 09:17:01 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA11B142911
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jul 2024 09:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720171020; cv=none; b=g4KlQACfRltHyfI7Dy+7NE5K5p0g/8il2qnS3EkhnH9OEMf5e1rEFIq8Si9EuntAhxrYjbu0qjvqC993bf4lYZ9ZqXwA51S0bvQlRUBJks4W2DbJaV4I3hZfG0vpJYo4u6l/F6+FAYDC+5KVGbQrT5m2AB57dXoWda8TLs+KJJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720171020; c=relaxed/simple;
	bh=2OpaWBxNR6yNHmQVP4EARr4D+VfgYaDqWio9J7BXpzY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QH6m2KKm/CQC5y/hxlnxZ18o7qXOKv0kznMDLIAti2RbsYR1AqImpz8nFALzyrYj1g2SM27oQksRHXobRzqEAr2AQi5fIX3tMc7Jfgz0efT32LBrDFpto3Y28V+hN0vNg17ZzIgJbVmIjBU4D7b5pFi/swgZEDF+Qt1vbPKPsOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4AA04367;
	Fri,  5 Jul 2024 02:17:23 -0700 (PDT)
Received: from [10.57.74.223] (unknown [10.57.74.223])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6FD923F762;
	Fri,  5 Jul 2024 02:16:56 -0700 (PDT)
Message-ID: <b99ba664-982d-4b8b-b923-c3cefae8e021@arm.com>
Date: Fri, 5 Jul 2024 10:16:55 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] mm: add docs for per-order mTHP split counters
Content-Language: en-GB
To: Lance Yang <ioworker0@gmail.com>, akpm@linux-foundation.org
Cc: dj456119@gmail.com, 21cnbao@gmail.com, david@redhat.com,
 shy828301@gmail.com, ziy@nvidia.com, libang.li@antgroup.com,
 baolin.wang@linux.alibaba.com, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, Barry Song <baohua@kernel.org>,
 Mingzhe Yang <mingzhe.yang@ly.com>
References: <20240704012905.42971-1-ioworker0@gmail.com>
 <20240704012905.42971-3-ioworker0@gmail.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <20240704012905.42971-3-ioworker0@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 04/07/2024 02:29, Lance Yang wrote:
> This commit introduces documentation for mTHP split counters in
> transhuge.rst.
> 
> Reviewed-by: Barry Song <baohua@kernel.org>
> Signed-off-by: Mingzhe Yang <mingzhe.yang@ly.com>
> Signed-off-by: Lance Yang <ioworker0@gmail.com>
> ---
>  Documentation/admin-guide/mm/transhuge.rst | 20 ++++++++++++++++----
>  1 file changed, 16 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/admin-guide/mm/transhuge.rst b/Documentation/admin-guide/mm/transhuge.rst
> index 1f72b00af5d3..0830aa173a8b 100644
> --- a/Documentation/admin-guide/mm/transhuge.rst
> +++ b/Documentation/admin-guide/mm/transhuge.rst
> @@ -369,10 +369,6 @@ also applies to the regions registered in khugepaged.
>  Monitoring usage
>  ================
>  
> -.. note::
> -   Currently the below counters only record events relating to
> -   PMD-sized THP. Events relating to other THP sizes are not included.
> -
>  The number of PMD-sized anonymous transparent huge pages currently used by the
>  system is available by reading the AnonHugePages field in ``/proc/meminfo``.
>  To identify what applications are using PMD-sized anonymous transparent huge
> @@ -514,6 +510,22 @@ file_fallback_charge
>  	falls back to using small pages even though the allocation was
>  	successful.
>  
> +split
> +	is incremented every time a huge page is successfully split into
> +	smaller orders. This can happen for a variety of reasons but a
> +	common reason is that a huge page is old and is being reclaimed.
> +	This action implies splitting any block mappings into PTEs.

nit: the block mappings will already be PTEs if starting with mTHP?

regardless:

Reviewed-by: Ryan Roberts <ryan.roberts@arm.com>

> +
> +split_failed
> +	is incremented if kernel fails to split huge
> +	page. This can happen if the page was pinned by somebody.
> +
> +split_deferred
> +	is incremented when a huge page is put onto split
> +	queue. This happens when a huge page is partially unmapped and
> +	splitting it would free up some memory. Pages on split queue are
> +	going to be split under memory pressure.
> +
>  As the system ages, allocating huge pages may be expensive as the
>  system uses memory compaction to copy data around memory to free a
>  huge page for use. There are some counters in ``/proc/vmstat`` to help


