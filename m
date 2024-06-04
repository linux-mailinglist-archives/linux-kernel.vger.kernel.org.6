Return-Path: <linux-kernel+bounces-199958-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D2E9B8FA833
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 04:09:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0F1CC1C231B4
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 02:09:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EC6F13D2BA;
	Tue,  4 Jun 2024 02:09:47 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 052411E485
	for <linux-kernel@vger.kernel.org>; Tue,  4 Jun 2024 02:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717466987; cv=none; b=HAPoEJ69EWbevt083W+dZc+pNqvYwAu3uytm/qSQQ9eew7NwzX61plABJqNpC/3/now58C+tg+NYB3vpacGQOyCpJpFKIuLT6AZJjqtO5AyRl3onACWP0SK78w++VfAzIN9tevyNvWnexJXXbX6LL46Bs3tlT+Ww1x2N9WHk8BI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717466987; c=relaxed/simple;
	bh=hwvOZyv7/mIIoFPw5rwuqHls+HkrfuvtmKl9JDFGQiU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=l/jTbJ58dcPIlgN2xKkPTKFMtxjBRRbnguwgw456IIKq1kfFRRq6nsg8Ej1zhf2R65kI6G8b99oT9NlAb/0gVHEfBWoMKDGeA473yILx0xH27One74LV5j1Ek0gjvb2wxHlLspMOTrsQJ7Y9AuQoBTNUoyeUmvflD9R4ivr/WJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 627C81042;
	Mon,  3 Jun 2024 19:10:07 -0700 (PDT)
Received: from [10.162.40.15] (a077893.blr.arm.com [10.162.40.15])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8A6B63F792;
	Mon,  3 Jun 2024 19:09:41 -0700 (PDT)
Message-ID: <52773c75-916a-42df-b60f-531770a3cc82@arm.com>
Date: Tue, 4 Jun 2024 07:39:38 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm: sparse: Consistently use _nr
Content-Language: en-US
To: Dev Jain <dev.jain@arm.com>, akpm@linux-foundation.org
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20240531124144.240399-1-dev.jain@arm.com>
From: Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <20240531124144.240399-1-dev.jain@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 5/31/24 18:11, Dev Jain wrote:
> Consistenly name the return variable with an _nr suffix, whenever calling
> pfn_to_section_nr(), to avoid confusion with a (struct mem_section *).
> 
> Signed-off-by: Dev Jain <dev.jain@arm.com>

Reviewed-by: Anshuman Khandual <anshuman.khandual@arm.com>

> ---
>  mm/sparse.c | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/mm/sparse.c b/mm/sparse.c
> index de40b2c73406..731f781e91b6 100644
> --- a/mm/sparse.c
> +++ b/mm/sparse.c
> @@ -192,13 +192,13 @@ static void subsection_mask_set(unsigned long *map, unsigned long pfn,
>  
>  void __init subsection_map_init(unsigned long pfn, unsigned long nr_pages)
>  {
> -	int end_sec = pfn_to_section_nr(pfn + nr_pages - 1);
> -	unsigned long nr, start_sec = pfn_to_section_nr(pfn);
> +	int end_sec_nr = pfn_to_section_nr(pfn + nr_pages - 1);
> +	unsigned long nr, start_sec_nr = pfn_to_section_nr(pfn);
>  
>  	if (!nr_pages)
>  		return;
>  
> -	for (nr = start_sec; nr <= end_sec; nr++) {
> +	for (nr = start_sec_nr; nr <= end_sec_nr; nr++) {
>  		struct mem_section *ms;
>  		unsigned long pfns;
>  
> @@ -229,17 +229,17 @@ static void __init memory_present(int nid, unsigned long start, unsigned long en
>  	start &= PAGE_SECTION_MASK;
>  	mminit_validate_memmodel_limits(&start, &end);
>  	for (pfn = start; pfn < end; pfn += PAGES_PER_SECTION) {
> -		unsigned long section = pfn_to_section_nr(pfn);
> +		unsigned long section_nr = pfn_to_section_nr(pfn);
>  		struct mem_section *ms;
>  
> -		sparse_index_init(section, nid);
> -		set_section_nid(section, nid);
> +		sparse_index_init(section_nr, nid);
> +		set_section_nid(section_nr, nid);
>  
> -		ms = __nr_to_section(section);
> +		ms = __nr_to_section(section_nr);
>  		if (!ms->section_mem_map) {
>  			ms->section_mem_map = sparse_encode_early_nid(nid) |
>  							SECTION_IS_ONLINE;
> -			__section_mark_present(ms, section);
> +			__section_mark_present(ms, section_nr);
>  		}
>  	}
>  }

