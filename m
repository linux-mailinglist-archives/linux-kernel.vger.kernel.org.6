Return-Path: <linux-kernel+bounces-375621-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 04F409A9845
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 07:23:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 867D9B21494
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 05:23:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90DC112A14C;
	Tue, 22 Oct 2024 05:23:26 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB8115A79B
	for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 05:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729574606; cv=none; b=hBXugph2/3lHb+/LBz7hG7aHgYBISx0uyMl2RSpgugdDAoSweYrjmBAgyWv65maEQI5u5fqAqHddGwn1MTShgyXMxRLTerfXB42G9mzCg+CIizIFCKoK7Bb7WFs7rzAzxZmrotMS9JtMthSMmsTSEoNQ7IhRM0lO6F6akJIM0Dw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729574606; c=relaxed/simple;
	bh=ujSvGQTZG3caebGcZ6XotwWkMRfa0IF10kv517T4X3I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Eh6ZMfEgCrC5pIBA8E9xat2m3y6En5Zn+G1744QlkWih1v6Uzi22kM+V3IE2jQ1I9hegxL2ncVCM7J71tVCkxTAmlLWUz88qtrsNIGDLrbiL/zW17chb7oRXcS69sKCm4opdtMrT+Da8oAElxNOlPRd25ov7uckhmojdY16VYC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E483B497;
	Mon, 21 Oct 2024 22:23:52 -0700 (PDT)
Received: from [10.163.41.149] (unknown [10.163.41.149])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C12E63F528;
	Mon, 21 Oct 2024 22:23:20 -0700 (PDT)
Message-ID: <d7ef250c-a97b-4d91-89b8-d3094c76b59e@arm.com>
Date: Tue, 22 Oct 2024 10:53:18 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm: Remove redundant condition for THP folio
To: Dev Jain <dev.jain@arm.com>, akpm@linux-foundation.org, david@redhat.com,
 willy@infradead.org
Cc: ziy@nvidia.com, ying.huang@intel.com, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org
References: <20241018094151.3458-1-dev.jain@arm.com>
Content-Language: en-US
From: Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <20241018094151.3458-1-dev.jain@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 10/18/24 15:11, Dev Jain wrote:
> folio_test_pmd_mappable() implies folio_test_large(), therefore,
> simplify the expression for is_thp.
> 
> Signed-off-by: Dev Jain <dev.jain@arm.com>
> ---
>  mm/migrate.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/migrate.c b/mm/migrate.c
> index df91248755e4..b43e7b105559 100644
> --- a/mm/migrate.c
> +++ b/mm/migrate.c
> @@ -1731,7 +1731,7 @@ static int migrate_pages_batch(struct list_head *from,
>  
>  		list_for_each_entry_safe(folio, folio2, from, lru) {
>  			is_large = folio_test_large(folio);
> -			is_thp = is_large && folio_test_pmd_mappable(folio);
> +			is_thp = folio_test_pmd_mappable(folio);
>  			nr_pages = folio_nr_pages(folio);
>  
>  			cond_resched();

Reviewed-by: Anshuman Khandual <anshuman.khandual@arm.com>

