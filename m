Return-Path: <linux-kernel+bounces-319219-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6407196F969
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 18:36:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 23C7F28670B
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 16:36:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30E4A1D365D;
	Fri,  6 Sep 2024 16:36:25 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB9251D31A9
	for <linux-kernel@vger.kernel.org>; Fri,  6 Sep 2024 16:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725640584; cv=none; b=AsCPVdEE6UpmWhGCGiwOkNP8WcD1JSwHiMXDEw7P899MXMgkiTTHOLztCJPMU+Ie/UguUiXaOAO+kKaxeM7mf1Zf5mHNoA25v9OzWDxiq5hr4VIqD32xguyAo7xD6Ogbq3+ssQkpYKcSEzOn3niInRoZzODyM+cmIbFXMzmin9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725640584; c=relaxed/simple;
	bh=+nxkEOxIze17upCd4FQabCWwqtb3NVdd7bD33DVR6LA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K7lHmOFe3QRrK833WXppd5Y5VL1eN7v8Zq1q5rmaApM/j7hCTmiaZz2ouH85gpWJr9cgC9WZ6N73DE9x5GTSINjn3Pmk0N7FizrZj5/x/oojiVQq9udDrdkraaNBts8rAoq687DiYN08O4O4Z+XD6KTwxOshe2VWXlPciKqYME4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 102BBC4CEC6;
	Fri,  6 Sep 2024 16:36:22 +0000 (UTC)
Date: Fri, 6 Sep 2024 17:36:20 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: Steven Price <steven.price@arm.com>
Cc: Marc Zyngier <maz@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Will Deacon <will@kernel.org>,
	Suzuki K Poulose <suzuki.poulose@arm.com>
Subject: Re: [PATCH 1/2] irqchip/gic-v3-its: Share ITS tables with a
 non-trusted hypervisor
Message-ID: <ZtsvhESaBDdyEs7B@arm.com>
References: <20240905091738.28544-1-steven.price@arm.com>
 <20240905091738.28544-2-steven.price@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240905091738.28544-2-steven.price@arm.com>

On Thu, Sep 05, 2024 at 10:17:37AM +0100, Steven Price wrote:
> +static struct page *its_alloc_pages_node(int node, gfp_t gfp,
> +					 unsigned int order)
> +{
> +	struct page *page;
> +	int ret = 0;
> +
> +	page = alloc_pages_node(node, gfp, order);
> +
> +	if (!page)
> +		return NULL;
> +
> +	ret = set_memory_decrypted((unsigned long)page_address(page),
> +				   1 << order);
> +	if (WARN_ON(ret))
> +		return NULL;

I think we discussed this but forgot the details. If
set_memory_decrypted() failed, I guess it's not safe to free the page
back as we don't know the state it is in. It might be worth adding a
comment if you respin for other reasons.

> +static void *itt_alloc_pool(int node, int size)
> +{
> +	unsigned long addr;
> +	struct page *page;
> +
> +	if (size >= PAGE_SIZE) {
> +		page = its_alloc_pages_node(node,
> +					    GFP_KERNEL | __GFP_ZERO,
> +					    get_order(size));
> +
> +		return page_address(page);
> +	}

Since its_alloc_pages_node() can return NULL, we should check for this
as page_address() would not be valid.

Otherwise the patch looks fine:

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>

