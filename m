Return-Path: <linux-kernel+bounces-249829-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A782B92F075
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 22:47:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 507651F21E0F
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 20:47:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9BAE19E82B;
	Thu, 11 Jul 2024 20:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="fur/ZVA0"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E3B28BFC
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 20:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720730822; cv=none; b=Bzpiu+HX7hNYUBa/pKOQbS4mOtXabB8bZdXpJC4R/MpRflUiA8vQ5RXeLw7pFzP9pXG+7U6DEAfJwV5Qj3lUF3i2wovTFySmfTsdbo4yingUpcU8aT1C01+Cxjgpi/L7uVJK+zqI0m/XWJu91SVCI25njeXnyaO8P5x0VDh1VQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720730822; c=relaxed/simple;
	bh=payxL7EIqUFBpncJilY8RxBDRjde/jfWOfcg/f1uN3o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=vFPdGcX61QnunfDhmgKy6lH9RiEqYPZRGAWLTmqPpSm+KuDYpU18LFQlAaAtYYLM5j9XSkQ9Cf//0UNNruxQk8F33Lv0YFPWhkZAcwIt5BmydmAHzQHhIPuESI4mjFQGQaweyyYgMJIZl3h49lZpsXfY1Scxdm41eQeZD6Aw4DA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=fur/ZVA0; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=CGNTumT7OinIGSCEASYIzgO9rLYWSW+FBDUcoPMeSXc=; b=fur/ZVA06a3gup76tulcIgpPEf
	NlvLiW4EqqSIuUSON1uy5l1Pusblw1VVLVRrbPd20udAc48UWnk/xwkQOCyKRzBzprC0pOsQH7Qch
	+iIj0/7+Y9muvMwZNNCpI7ijn29UKbwby74L8lsTxEe6KKrM8iuiGTO/wADOvlVaK00+UxkZWZpzz
	0yrbR0iyn554g7M6UM6fZhABI715JSHjv7zAoGimrgK4ckkXEkdCc6twxS0nNLy1LtbToH8ohrjJp
	RvElKrNO+lB3Ambu/94OY+gOu3gtaTJhTVWM9wTmBuYd3FZNiF+O2o2FG1PqM5sem9YSAw4CmQ/94
	IUhzPVuA==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sS0gq-0000000Be2U-1wqg;
	Thu, 11 Jul 2024 20:46:56 +0000
Date: Thu, 11 Jul 2024 21:46:56 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Gavin Shan <gshan@redhat.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org, william.kucharski@oracle.com,
	david@redhat.com, ryan.roberts@arm.com, shan.gavin@gmail.com
Subject: Re: [PATCH] mm/huge_memory: Avoid PMD-size page cache if needed
Message-ID: <ZpBEwEn3swH7IFbI@casper.infradead.org>
References: <20240711104840.200573-1-gshan@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240711104840.200573-1-gshan@redhat.com>

On Thu, Jul 11, 2024 at 08:48:40PM +1000, Gavin Shan wrote:
> +++ b/mm/huge_memory.c
> @@ -136,7 +136,8 @@ unsigned long __thp_vma_allowable_orders(struct vm_area_struct *vma,
>  
>  		while (orders) {
>  			addr = vma->vm_end - (PAGE_SIZE << order);
> -			if (thp_vma_suitable_order(vma, addr, order))
> +			if (!(vma->vm_file && order > MAX_PAGECACHE_ORDER) &&
> +			    thp_vma_suitable_order(vma, addr, order))
>  				break;

Why does 'orders' even contain potential orders that are larger than
MAX_PAGECACHE_ORDER?

We do this at the top:

        orders &= vma_is_anonymous(vma) ?
                        THP_ORDERS_ALL_ANON : THP_ORDERS_ALL_FILE;

include/linux/huge_mm.h:#define THP_ORDERS_ALL_FILE     (BIT(PMD_ORDER) | BIT(PUD_ORDER))

... and that seems very wrong.  We support all kinds of orders for
files, not just PMD order.  We don't support PUD order at all.

What the hell is going on here?

