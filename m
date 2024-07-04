Return-Path: <linux-kernel+bounces-241295-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 169DD927975
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 17:03:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B37551F21C17
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 15:03:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BE0B1B013D;
	Thu,  4 Jul 2024 15:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AcQEtNIO"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E47721AEFF5
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jul 2024 15:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720105380; cv=none; b=nNnTsYKRjSa8WY+F0ziW5VnXiBhy+2geYXCIZln+LUDJhR49bKgIOpRPQCY1BDC0IHI1U69gmNdJLUshnTAn+eOp274XuZhK8q7hUsQy/TGxvtwBPCvRpe5CaY3oY4e9hEj0AfHIzn9kSsG3bgbpd+XDSEtQfvV3acDvoOITh7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720105380; c=relaxed/simple;
	bh=yjLuyRyowZtnuxctbU1cXgNx8T1gytALM48J5F+5UJc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KjnGztgUNi1uKgHI0f1Wl64YwV9j3pxAn6p5COdeU+steEeIU4bfrfqhqlMXbOQi41CaKpMQb2/kKPuDJIwUbsMY9uingVbGRduur5Uc++tianLDYS5JfuiwEEz/apP0Oy+jh/nzt8A4WBb2F0iEjMc3ax8OMU4nctQ3RVc7etI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AcQEtNIO; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720105377;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mwlF2nZy/FOptazxuSTgaLV2WhMmNg44kTgmw/1H9t4=;
	b=AcQEtNIOjc4Z5hEMOmFK+GtrV6U/koAApsPGwmn/w4A8I/1SvaylTvvd2z52PMbbTjI3P8
	k7dkvGYDMjRllKukvcQZDwYo09LAUeWqDgXRN5q2anjaUqeO2YWoxMyxNNilquWTfdUWIG
	pSiLTXpWoosM9togLJldu2Mdtfw3Lx0=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-20-5CetH2V5N-aWcJHwSCwKqg-1; Thu, 04 Jul 2024 11:02:56 -0400
X-MC-Unique: 5CetH2V5N-aWcJHwSCwKqg-1
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-6b5e41e09b6so1946936d6.1
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jul 2024 08:02:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720105376; x=1720710176;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mwlF2nZy/FOptazxuSTgaLV2WhMmNg44kTgmw/1H9t4=;
        b=Q9LplPqGj7Anr9kPyk5gjzLafHMg7CyB19VKu5uNAOZTmr98l+Sup2dRj1evpmH9kT
         4fhlCb0lTg5pscljTodePu6DqSI1CNiii7Pk0XHGED0BOenMtl+qazC4p3pMP7o3P6Vt
         uvd8ZBJL04Df4VVaEqnPl+rtoWAz/r+U4HQgAPcy3Sg/VH2MEKik4aJ4pawZTGWlUVIa
         USG261VJGNpRHhgYxE2SDb6JzKTZCdIzVBg4VZ9Zz38KBbbwizybwj2QndjKrpMNvTQP
         9v44GlKthRfqijAbDvb08SmuWH5BfiPgFw5rsBenXHgVyJzffyB0EDCLMy7JQcaNSdd6
         YRJg==
X-Forwarded-Encrypted: i=1; AJvYcCWlzwe7Siy41vNJ4XSLcNkhUANV9u70pdkEX6Xez0jtxUMS2sfgrsiSRUOWt5+LeBRguStI2S8HpguQJapmn+RR54oDi6L8nvH8bNTN
X-Gm-Message-State: AOJu0YxvzTVW6j1rwyU1Ws5BO3cQRZDTGBPWdEdkeSE5UDKLkaeSPEYU
	yq/hdAO9hIf0ZANXNelkv6qZnYTllavnDPWWaSnBJFAsl2sgJyz53ccJTdGPpmXBJvAdF1VAuAz
	nb85ZBii+bvdl5OShaN5QvKK5raLCS958itycWVlg/4ZIxRNa22BKp9QJBnFNnQ==
X-Received: by 2002:a05:620a:990:b0:79d:6685:4e6e with SMTP id af79cd13be357-79eee1aadbdmr171276285a.2.1720105376020;
        Thu, 04 Jul 2024 08:02:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFjTnriP6wmPjUsy0qF0I/XGttLsiy7TWZGX+/WY5WX+mLiNQ7rJeIhIk3guLOr/46pXiAiLQ==
X-Received: by 2002:a05:620a:990:b0:79d:6685:4e6e with SMTP id af79cd13be357-79eee1aadbdmr171272585a.2.1720105375435;
        Thu, 04 Jul 2024 08:02:55 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com. [99.254.121.117])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-79d69328d75sm679815785a.127.2024.07.04.08.02.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jul 2024 08:02:54 -0700 (PDT)
Date: Thu, 4 Jul 2024 11:02:52 -0400
From: Peter Xu <peterx@redhat.com>
To: Oscar Salvador <osalvador@suse.de>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, Muchun Song <muchun.song@linux.dev>,
	David Hildenbrand <david@redhat.com>, SeongJae Park <sj@kernel.org>,
	Miaohe Lin <linmiaohe@huawei.com>, Michal Hocko <mhocko@suse.com>,
	Matthew Wilcox <willy@infradead.org>,
	Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: Re: [PATCH 02/45] mm: Add {pmd,pud}_huge_lock helper
Message-ID: <Zoa5nOkaUxmKiEIA@x1n>
References: <20240704043132.28501-1-osalvador@suse.de>
 <20240704043132.28501-3-osalvador@suse.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240704043132.28501-3-osalvador@suse.de>

On Thu, Jul 04, 2024 at 06:30:49AM +0200, Oscar Salvador wrote:
> Deep down hugetlb and thp use the same lock for pud and pmd.
> Create two helpers that can be directly used by both of them,
> as they will be used in the generic pagewalkers.
> 
> Signed-off-by: Oscar Salvador <osalvador@suse.de>
> ---
>  include/linux/mm_inline.h | 27 +++++++++++++++++++++++++++
>  1 file changed, 27 insertions(+)
> 
> diff --git a/include/linux/mm_inline.h b/include/linux/mm_inline.h
> index f4fe593c1400..93e3eb86ef4e 100644
> --- a/include/linux/mm_inline.h
> +++ b/include/linux/mm_inline.h
> @@ -9,6 +9,7 @@
>  #include <linux/string.h>
>  #include <linux/userfaultfd_k.h>
>  #include <linux/swapops.h>
> +#include <linux/hugetlb.h>
>  
>  /**
>   * folio_is_file_lru - Should the folio be on a file LRU or anon LRU?
> @@ -590,4 +591,30 @@ static inline bool vma_has_recency(struct vm_area_struct *vma)
>  	return true;
>  }
>  
> +static inline spinlock_t *pmd_huge_lock(pmd_t *pmd, struct vm_area_struct *vma)
> +{
> +	spinlock_t *ptl;
> +
> +	if (pmd_leaf(*pmd)) {
> +		ptl = pmd_lock(vma->vm_mm, pmd);
> +		if (pmd_leaf(*pmd))
> +			return ptl;
> +		spin_unlock(ptl);
> +	}
> +	return NULL;
> +}
> +
> +static inline spinlock_t *pud_huge_lock(pud_t *pud, struct vm_area_struct *vma)
> +{
> +	spinlock_t *ptl = pud_lock(vma->vm_mm, pud);
> +
> +	if (pud_leaf(*pud)) {
> +		ptl = pud_lock(vma->vm_mm, pud);
> +		if (pud_leaf(*pud))
> +			return ptl;
> +		spin_unlock(ptl);
> +	}
> +	return NULL;
> +}

IIRC I left similar comment before somewhere when we're discussing.. but we
may need to consider swap entries too.

I think it might be easier we stick with pxd_trans_huge_lock(), but some
slight modification on top: (1) rename them, perhaps s/trans_//g? (2) need
to also handle swap entry for puds (hugetlb migration entries, right now
pud_trans_huge_lock() didn't consider that).

Thanks,

-- 
Peter Xu


