Return-Path: <linux-kernel+bounces-570713-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 76750A6B3D1
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 05:49:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D48CC16FB1D
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 04:48:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEFBC1E3793;
	Fri, 21 Mar 2025 04:48:23 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C99C82AD0C
	for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 04:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742532503; cv=none; b=oGoW3580fE2ah7F8AkU+kK6YMR28NCG5MAtgMa7s9htU8UisztqBAuZjPKrBKFdVhf05+raCspX4NH8MDafX3JngyaZOsSom0Gr0kdY/TRgElR5cHxEALDIqvHG7RTCa/fPJIMVQUEIRaudMSsWsNQI3GVHF206Np4XErG+XIGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742532503; c=relaxed/simple;
	bh=Jt62BR8KQbTzUPS6y6fs1k8t5aTR/V2FQbDlelyhF2g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WT69YFPLlhNGQvbaYUirLDs8BNDUbiDIaQUmHvlIf5oKvA13HohX2xjxrusG9mwjORc7pfa4OD8Jey7NQmnMKCwMpxmv2LzbrqLIxQV+ECKn3hQgMiV3Z2CZUAFG3l2o8rYnQWsM573Sreg28kMRibq6HGCodQLsTxKAZulECZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 94279106F;
	Thu, 20 Mar 2025 21:48:27 -0700 (PDT)
Received: from [10.162.16.153] (a077893.blr.arm.com [10.162.16.153])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 68A1A3F673;
	Thu, 20 Mar 2025 21:48:18 -0700 (PDT)
Message-ID: <a15b93d8-3b8a-4b3a-a40b-016efe9d12a2@arm.com>
Date: Fri, 21 Mar 2025 10:18:15 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/page_alloc: Replace flag check with PageHWPoison() in
 check_new_page_bad()
To: Ye Liu <ye.liu@linux.dev>, akpm@linux-foundation.org
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 Ye Liu <liuye@kylinos.cn>
References: <20250320063346.489030-1-ye.liu@linux.dev>
Content-Language: en-US
From: Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <20250320063346.489030-1-ye.liu@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 3/20/25 12:03, Ye Liu wrote:
> From: Ye Liu <liuye@kylinos.cn>
> 
> This patch replaces the direct check for the __PG_HWPOISON flag with
> the PageHWPoison() macro, improving code readability and maintaining
> consistency with other parts of the memory management code.
> 
> Signed-off-by: Ye Liu <liuye@kylinos.cn>
> ---
>  mm/page_alloc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index fe76fd237dd0..6ef54abebf51 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -1427,7 +1427,7 @@ static __always_inline void page_del_and_expand(struct zone *zone,
>  
>  static void check_new_page_bad(struct page *page)
>  {
> -	if (unlikely(page->flags & __PG_HWPOISON)) {
> +	if (unlikely(PageHWPoison(page))) {
>  		/* Don't complain about hwpoisoned pages */
>  		if (PageBuddy(page))
>  			__ClearPageBuddy(page);

Reviewed-by: Anshuman Khandual <anshuman.khandual@arm.com>

