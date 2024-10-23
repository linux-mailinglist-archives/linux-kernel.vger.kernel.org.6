Return-Path: <linux-kernel+bounces-377315-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D37109ABCE6
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 06:21:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7E2CB1F2275E
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 04:21:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0746137745;
	Wed, 23 Oct 2024 04:19:15 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6E33610B
	for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 04:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729657155; cv=none; b=FbolYM5Z5jhd/sSytvsIxDpMsqS1ZjUn9XFUyzn9S/+R4naNPixsiHnWwcY/pPApR7jlZOaSP4dcoJitCgwO7v0bqqjXhScioXRoV3d3DMSqaKPuI9Zl94T+qe8/jrbG2xK8NVVQY8KgGoIZDA9a4JDuINb1p3yyPP/NAWYt/Ro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729657155; c=relaxed/simple;
	bh=MCZS0B04eTyoXSI7kMSmUrZac3YdkoSIjpgaDTjHohI=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=LX7h+TBP8qexy68Izv1tfONCqttpxnal5uj12a4hBl9VEUFIoNJW/ZDTqSdEAB9TvDmYI8qMqybkgFP90ExDGFybebsMtRd7gA9vAzp9ny+mM1Rh2mBqF8suQ97prnOSt0hqV/xYYRQLjkGoVM15gjfgB4vueCcL+IfryxG9QpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 84C24339;
	Tue, 22 Oct 2024 21:19:41 -0700 (PDT)
Received: from [10.163.41.228] (unknown [10.163.41.228])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0E7413F528;
	Tue, 22 Oct 2024 21:19:08 -0700 (PDT)
Message-ID: <49a7dbae-d382-4b60-b08e-2aaca9eb343f@arm.com>
Date: Wed, 23 Oct 2024 09:49:07 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] mm/codetag: fix arg in pgalloc_tag_copy alloc_tag_sub
To: Sourav Panda <souravpanda@google.com>, akpm@linux-foundation.org,
 surenb@google.com, yuzhao@google.com, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, pasha.tatashin@soleen.com, weixugc@google.com
References: <20241022232440.334820-1-souravpanda@google.com>
Content-Language: en-US
From: Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <20241022232440.334820-1-souravpanda@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 10/23/24 04:54, Sourav Panda wrote:
> alloc_tag_sub() takes bytes as opposed to number of pages as argument.
> 
> Currently pgalloc_tag_copy() passes the number of pages. This fix passes
> the correct unit, which is the number of bytes allocated.
> 
> Fixes: e0a955bf7f61 ("mm/codetag: add pgalloc_tag_copy()")
> Signed-off-by: Sourav Panda <souravpanda@google.com>
> Acked-by: Suren Baghdasaryan <surenb@google.com>
> Reviewed-by: Pasha Tatashin <pasha.tatashin@soleen.com>
> ---
> Changelog:
> Added Acked-by: Suren Baghdasaryan <surenb@google.com>
> Added Reviewed-by: Pasha Tatashin <pasha.tatashin@soleen.com>

Very minor nit.

Just mentioning that the tags have been picked up should suffice.

> Fixed the nit pointed by Wei in the commit message
> 
> v1:
> https://lore.kernel.org/all/20241022205622.133697-1-souravpanda@google.com/
> ---
>  include/linux/mm.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index ecf63d2b0582..2890001c8b97 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -4203,7 +4203,7 @@ static inline void pgalloc_tag_copy(struct folio *new, struct folio *old)
>  	/* Clear the old ref to the original allocation tag. */
>  	clear_page_tag_ref(&old->page);
>  	/* Decrement the counters of the tag on get_new_folio. */
> -	alloc_tag_sub(ref, folio_nr_pages(new));
> +	alloc_tag_sub(ref, folio_size(new));
>  
>  	__alloc_tag_ref_set(ref, tag);
>  

Reviewed-by: Anshuman Khandual <anshuman.khandual@arm.com>

