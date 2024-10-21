Return-Path: <linux-kernel+bounces-374311-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C395D9A684F
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 14:27:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 415A91F2708C
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 12:27:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09DE61F7061;
	Mon, 21 Oct 2024 12:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ORfImR0E"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38F131F1316
	for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 12:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729513419; cv=none; b=oy5D3l7NY5KMwyXWjwKmQS12kIZwJrcMMHzozI2OHl6au5wZo7pWqaIaJ//34m6w+IyIYUsmHdu1HGPWGTB9OFyNIxPWRHXIIucllxwDWLmz97K/aGGiSqOF2Iwe7dHSzkV3F5SHXvrFrkcf4AyGte4mKva56h8FCNHIPlm0yxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729513419; c=relaxed/simple;
	bh=hqH3uJ3cRmHOsg368fktq8gyPxcMNhmSH3SzytsGRbg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DhvVFU60GGSl+TloSk2qFJM2ZphEqVbQod60MVCmfVS3UgXrlpkH6lU8aULyy9Ae2bha+SCzcYT3PsoT83HsCv6Ez6aR+wR0JtUsn/7QMnmU8RUkxkjKO4R/zX6PNBFEkRdhU38G5z0XxEKZsSXjfP6HxrQ+WnJ4iksLsHiGA2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ORfImR0E; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729513416;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uFXJPA42Z4FvckVpfiQrwGifFsYvWjPgRdkDsfHcBUA=;
	b=ORfImR0EiVOQsctBCNdNW4LU1MlmoRz28uJ21WaxCivEYCUtldMvQZw4JnNsXwqbnahisQ
	kt+f7pucfhe1lrcpv8zhDfUv4c4BfAShzgQFiz9Tcy7gBap1GLAZ4TOU/73fxwsninfkvj
	xTslXLsoRzGfY42Lt6yHOrpnsQKdZPw=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-678-Jm5UskipPCm64VDxaVy4OA-1; Mon, 21 Oct 2024 08:23:34 -0400
X-MC-Unique: Jm5UskipPCm64VDxaVy4OA-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4315d98a873so28977115e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 05:23:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729513414; x=1730118214;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uFXJPA42Z4FvckVpfiQrwGifFsYvWjPgRdkDsfHcBUA=;
        b=xEtYA8uwWjuONjotq+P9TAX4MWG3xFQRmQkgk0bA72mCxbWRlBmFdLWVvQNIjgVL1r
         riBfVwkDfht7F7dfCmFPhFTmZZBOLfzZ5wta8MBcW3AMgIT/uAXCeHbum/p+t/8QiTwh
         ewjx8xh1V4PEPjnMVPRs2ujez9vdUa8vkjqRt+jt0CykSaoPokn2Gb884EwD8E+cV4/d
         AsYpw9FWP0ciHdZeLve42/HcR70DaoUKk10FdjFAPuZTHrmcEzdeaVjuRHsYKSSEj1K4
         lGckY1MGQadZBymxO0jR9TGIBA0W6b37yfJg5cTfBh1SDklY/9obhhmVZK09hyHre6Ja
         27ZQ==
X-Forwarded-Encrypted: i=1; AJvYcCW0lPYIePUDmPfyJpov/NWFlv9FcOL9knTsXKZVAUrylgnp5WUq3GZlf+EgyoEqeq2Izq+z0NromGpTCa8=@vger.kernel.org
X-Gm-Message-State: AOJu0YztKjRDcJKCuqrqPLRUnV+7yKFst/IOPMSxtOD5hl8/shrvNYvo
	qgxle0KulMPbxrh3JcqZ+IjCFthsFAQQlWWcw98Pp6IRw3sZm3IKcoMnkiZ8sEpO3E3VR6EGETE
	VCI+CiZbG8vRzeh3L5AQr8tTQzqYJYQNCV+R0QEfMVujRldxW571Kwb4WWeSMlg==
X-Received: by 2002:a05:600c:1547:b0:42c:b80e:5e50 with SMTP id 5b1f17b1804b1-431615bf97dmr90972315e9.0.1729513413631;
        Mon, 21 Oct 2024 05:23:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEXq14rjOzZqkZ2LLBYAJkh/Z9QyHz8AiwWS/xKGGmWoTb0OdLBygpyTri0cFef6ZUQDR+yOA==
X-Received: by 2002:a05:600c:1547:b0:42c:b80e:5e50 with SMTP id 5b1f17b1804b1-431615bf97dmr90972045e9.0.1729513413260;
        Mon, 21 Oct 2024 05:23:33 -0700 (PDT)
Received: from ?IPV6:2a09:80c0:192:0:36d3:2b96:a142:a05b? ([2a09:80c0:192:0:36d3:2b96:a142:a05b])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4316f57fbe8sm55532975e9.18.2024.10.21.05.23.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Oct 2024 05:23:32 -0700 (PDT)
Message-ID: <a7279751-b9cd-4197-9c98-3aa70b1f5fe8@redhat.com>
Date: Mon, 21 Oct 2024 14:23:31 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm: avoid zeroing user movable page twice with
 init_on_alloc=1
To: Zi Yan <ziy@nvidia.com>, linux-mm@kvack.org,
 Andrew Morton <akpm@linux-foundation.org>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 Miaohe Lin <linmiaohe@huawei.com>, Kefeng Wang <wangkefeng.wang@huawei.com>,
 John Hubbard <jhubbard@nvidia.com>, "Huang, Ying" <ying.huang@intel.com>,
 Ryan Roberts <ryan.roberts@arm.com>, Alexander Potapenko
 <glider@google.com>, Kees Cook <keescook@chromium.org>,
 linux-kernel@vger.kernel.org
References: <20241011150304.709590-1-ziy@nvidia.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
In-Reply-To: <20241011150304.709590-1-ziy@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



Am 11.10.24 um 17:03 schrieb Zi Yan:
> Commit 6471384af2a6 ("mm: security: introduce init_on_alloc=1 and
> init_on_free=1 boot options") forces allocated page to be zeroed in
> post_alloc_hook() when init_on_alloc=1.
> 
> For order-0 folios, if arch does not define
> vma_alloc_zeroed_movable_folio(), the default implementation again zeros
> the page return from the buddy allocator. So the page is zeroed twice.
> Fix it by passing __GFP_ZERO instead to avoid double page zeroing.
> At the moment, s390,arm64,x86,alpha,m68k are not impacted since they
> define their own vma_alloc_zeroed_movable_folio().
> 
> For >0 order folios (mTHP and PMD THP), folio_zero_user() is called to
> zero the folio again. Fix it by calling folio_zero_user() only if
> init_on_alloc is set. All arch are impacted.
> 
> Added alloc_zeroed() helper to encapsulate the init_on_alloc check.
> 
> Signed-off-by: Zi Yan <ziy@nvidia.com>
> ---
>   include/linux/highmem.h | 8 +-------
>   mm/huge_memory.c        | 3 ++-
>   mm/internal.h           | 6 ++++++
>   mm/memory.c             | 3 ++-
>   4 files changed, 11 insertions(+), 9 deletions(-)
> 
> diff --git a/include/linux/highmem.h b/include/linux/highmem.h
> index bec9bd715acf..6e452bd8e7e3 100644
> --- a/include/linux/highmem.h
> +++ b/include/linux/highmem.h
> @@ -224,13 +224,7 @@ static inline
>   struct folio *vma_alloc_zeroed_movable_folio(struct vm_area_struct *vma,
>   				   unsigned long vaddr)
>   {
> -	struct folio *folio;
> -
> -	folio = vma_alloc_folio(GFP_HIGHUSER_MOVABLE, 0, vma, vaddr);
> -	if (folio)
> -		clear_user_highpage(&folio->page, vaddr);
> -
> -	return folio;
> +	return vma_alloc_folio(GFP_HIGHUSER_MOVABLE | __GFP_ZERO, 0, vma, vaddr);
>   }
>   #endif
>   
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index 82f464865570..5dcbea96edb7 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -1176,7 +1176,8 @@ static struct folio *vma_alloc_anon_folio_pmd(struct vm_area_struct *vma,
>   	}
>   	folio_throttle_swaprate(folio, gfp);
>   
> -	folio_zero_user(folio, addr);
> +	if (!alloc_zeroed())
> +		folio_zero_user(folio, addr);



It might be reasonable to spell out why we are not using GFP_ZERO somewhere, 
something like

/*
  * We are not using __GFP_ZERO because folio_zero_user() will make sure that the
  * page corresponding to the faulting address will be hot in the cache.
  */

Sth. like that maybe.

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb


