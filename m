Return-Path: <linux-kernel+bounces-252386-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55984931278
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 12:41:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 00D75282E19
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 10:41:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CEFE188CB8;
	Mon, 15 Jul 2024 10:41:11 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1768418629E
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2024 10:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721040071; cv=none; b=V7h/AGrYvWXfZAtizIP3c8A3JUbBmclc3vRuoB/li4/WN9bw9Q/UWmVBlrvjL2Xjt32ODOoK4OgpJh6MjJqiVVTe0soPmIZinUMFVGRFhss44Q0Ig6uR/l0JdXBibUy7PjBU2DkNSODk77LvBs2jxRyerLmWPg7aXZ6PP5samPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721040071; c=relaxed/simple;
	bh=Q6SJZuKkA/oIZAVFJYqyjou8klMNhAwYc9VTBZAqvsY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pWPOZdIFuTKpDj0Ne9qD40Zj7B5GNDjCrnxhxc0adtc8gpR0Rys9irxJLLHlbi1u8jS1l0d6sF4iJtll/08BQxDHR0MbTHEcwoMI2ePNVMrEm64K/E3GpjsTJUASmAgLCwrQV1pi00mwJ68J2LJBlKfOy5U2s18IwuHJRzDEePo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 78E89DA7;
	Mon, 15 Jul 2024 03:41:32 -0700 (PDT)
Received: from [10.57.75.89] (unknown [10.57.75.89])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 72ED03F766;
	Mon, 15 Jul 2024 03:41:05 -0700 (PDT)
Message-ID: <ea673fe9-beed-43fd-9a54-c683b0c800ce@arm.com>
Date: Mon, 15 Jul 2024 11:41:03 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] mm/huge_memory: Avoid PMD-size page cache if needed
Content-Language: en-GB
To: Gavin Shan <gshan@redhat.com>, linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
 david@redhat.com, willy@infradead.org, baohua@kernel.org, peterx@redhat.com,
 ziy@nvidia.com, william.kucharski@oracle.com, baolin.wang@linux.alibaba.com,
 ddutile@redhat.com, shan.gavin@gmail.com
References: <20240715000423.316491-1-gshan@redhat.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <20240715000423.316491-1-gshan@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

[...]

> diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
> index 2aa986a5cd1b..c73ad77fa33d 100644
> --- a/include/linux/huge_mm.h
> +++ b/include/linux/huge_mm.h
> @@ -72,14 +72,20 @@ extern struct kobj_attribute shmem_enabled_attr;
>  #define THP_ORDERS_ALL_ANON	((BIT(PMD_ORDER + 1) - 1) & ~(BIT(0) | BIT(1)))
>  
>  /*
> - * Mask of all large folio orders supported for file THP.
> + * Mask of all large folio orders supported for file THP. Folios in a DAX
> + * file is never split and the MAX_PAGECACHE_ORDER limit does not apply to
> + * it.
>   */
> -#define THP_ORDERS_ALL_FILE	(BIT(PMD_ORDER) | BIT(PUD_ORDER))
> +#define THP_ORDERS_ALL_FILE_DAX		\
> +	(BIT(PMD_ORDER) | BIT(PUD_ORDER))

Appologies if this was already discussed, but if changing _FILE_DEFAULT to
advertise all orders 1-MAX_PAGECACHE_ORDER, shouldn't we also change _FILE_DAX
to advertise all orders 1-PUD_ORDER ? Or is DAX literally limited to PTE/PMD/PUD?

> +#define THP_ORDERS_ALL_FILE_DEFAULT	\
> +	((BIT(MAX_PAGECACHE_ORDER + 1) - 1) & ~BIT(0))
>  
>  /*
>   * Mask of all large folio orders supported for THP.
>   */
> -#define THP_ORDERS_ALL		(THP_ORDERS_ALL_ANON | THP_ORDERS_ALL_FILE)
> +#define THP_ORDERS_ALL	\
> +	(THP_ORDERS_ALL_ANON | THP_ORDERS_ALL_FILE_DAX | THP_ORDERS_ALL_FILE_DEFAULT)
>  
>  #define TVA_SMAPS		(1 << 0)	/* Will be used for procfs */
>  #define TVA_IN_PF		(1 << 1)	/* Page fault handler */
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index 2120f7478e55..4690f33afaa6 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -88,9 +88,17 @@ unsigned long __thp_vma_allowable_orders(struct vm_area_struct *vma,
>  	bool smaps = tva_flags & TVA_SMAPS;
>  	bool in_pf = tva_flags & TVA_IN_PF;
>  	bool enforce_sysfs = tva_flags & TVA_ENFORCE_SYSFS;
> +	unsigned long supported_orders;
> +
>  	/* Check the intersection of requested and supported orders. */
> -	orders &= vma_is_anonymous(vma) ?
> -			THP_ORDERS_ALL_ANON : THP_ORDERS_ALL_FILE;
> +	if (vma_is_anonymous(vma))
> +		supported_orders = THP_ORDERS_ALL_ANON;
> +	else if (vma_is_dax(vma))
> +		supported_orders = THP_ORDERS_ALL_FILE_DAX;
> +	else
> +		supported_orders = THP_ORDERS_ALL_FILE_DEFAULT;
> +
> +	orders &= supported_orders;
>  	if (!orders)
>  		return 0;
>  


