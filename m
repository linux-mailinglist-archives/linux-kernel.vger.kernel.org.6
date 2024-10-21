Return-Path: <linux-kernel+bounces-374137-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A14D9A64FF
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 12:52:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C02061C218CF
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 10:52:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B293D1EF0AA;
	Mon, 21 Oct 2024 10:47:14 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2255B195FEC
	for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 10:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729507634; cv=none; b=c49wrOGmaKCcoX7zkVp9MAARmb3VcHHsbRGFXlJICqUG3EykP0gqO+Wsd+Snk0c5Coi9OjrqjQUQMa55S/wJzQLCTpfhtjtBZ2dWJqcn7I11cw23EjNcO8de8DtskIzVsPnjT1aLmyc5y81zO1+EdplFNUnVWmKOhrzGrEw42VE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729507634; c=relaxed/simple;
	bh=a1OblafRC+CKDcQO1SEOtqaigGRU4RCzCONRSR9+qOo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SHwHd9PQJG4o3DjYd1D3KpSlhNKw7LJSQXt4KScS1ibV65ezxZtLnZwtPoXp7BiDpjmXRH3gk68tNVKIAV91PLHD05UfCgWpMLsffr690FLP7FnEmvMREqbUCDgsT3YrKEnStZAnsWyaN47cVgb03NI1Fy8F97UmM1qkGnhUqiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3192FDA7;
	Mon, 21 Oct 2024 03:47:41 -0700 (PDT)
Received: from [10.57.24.27] (unknown [10.57.24.27])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id ED0693F73B;
	Mon, 21 Oct 2024 03:47:09 -0700 (PDT)
Message-ID: <1f6e19c4-1fb9-43ab-a8a2-a465c9cff84b@arm.com>
Date: Mon, 21 Oct 2024 11:47:07 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] irqchip/gic-v3-its: Share ITS tables with a
 non-trusted hypervisor
To: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 Will Deacon <will@kernel.org>, Suzuki K Poulose <suzuki.poulose@arm.com>,
 Michael Kelley <mhklinux@outlook.com>,
 Shanker Donthineni <sdonthineni@nvidia.com>, Marc Zyngier <maz@kernel.org>
References: <20241002141630.433502-1-steven.price@arm.com>
 <20241002141630.433502-2-steven.price@arm.com>
From: Steven Price <steven.price@arm.com>
Content-Language: en-GB
In-Reply-To: <20241002141630.433502-2-steven.price@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 02/10/2024 15:16, Steven Price wrote:
> Within a realm guest the ITS is emulated by the host. This means the
> allocations must have been made available to the host by a call to
> set_memory_decrypted(). Introduce an allocation function which performs
> this extra call.
> 
> For the ITT use a custom genpool-based allocator that calls
> set_memory_decrypted() for each page allocated, but then suballocates
> the size needed for each ITT. Note that there is no mechanism
> implemented to return pages from the genpool, but it is unlikely the
> peak number of devices will so much larger than the normal level - so
> this isn't expected to be an issue.
> 
> Co-developed-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> Tested-by: Will Deacon <will@kernel.org>
> Reviewed-by: Marc Zyngier <maz@kernel.org>
> Signed-off-by: Steven Price <steven.price@arm.com>
> ---
> Changes since v1:
>  * Drop WARN_ONs and add a comment explaining that, if they fail,
>    set_memory_{en,de}crypted() will already have WARNed and that we are
>    purposefully leaking memory in those cases.
> ---
>  drivers/irqchip/irq-gic-v3-its.c | 151 ++++++++++++++++++++++++++-----
>  1 file changed, 128 insertions(+), 23 deletions(-)
> 
> diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
> index fdec478ba5e7..7a62fd3a8673 100644
> --- a/drivers/irqchip/irq-gic-v3-its.c
> +++ b/drivers/irqchip/irq-gic-v3-its.c

<snip>

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
> +		if (!page)
> +			return NULL;
> +
> +		return page_address(page);
> +	}
> +
> +	do {
> +		addr = gen_pool_alloc(itt_pool, size);
> +		if (addr)
> +			break;
> +
> +		page = its_alloc_pages_node(node, GFP_KERNEL | __GFP_ZERO, 1);

Shanker pointed out[1] that this line is wrong. It's allocating 2 pages
not the expect single page because the final argument is the order and
1<<1 is 2.

Can you squash in (or apply as a fix) the following?

Thanks,
Steve

[1] https://lore.kernel.org/r/ed65312a-245c-4fa5-91ad-5d620cab7c6b%40nvidia.com

----8<----
From ada4dc7b3e028a9901219fe0f9212d665a4e610b Mon Sep 17 00:00:00 2001
From: Steven Price <steven.price@arm.com>
Date: Mon, 21 Oct 2024 11:41:05 +0100
Subject: [PATCH] irqchip/gic-v3-its: Fix over allocation in itt_alloc_pool()

itt_alloc_pool() calls its_alloc_pages_node() to allocate an individual
page to add to the pool (for allocations <PAGE_SIZE). However the final
argument of its_alloc_pages_node() is the page order not the number of
pages. Currently it allocates two pages and leaks the second page.
Fix it by passing 0 instead (1 << 0 = 1 page).

Reported-by: Shanker Donthineni <sdonthineni@nvidia.com>
Signed-off-by: Steven Price <steven.price@arm.com>
---
 drivers/irqchip/irq-gic-v3-its.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index 6c1581bf1ae0..526be60e3502 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -261,7 +261,7 @@ static void *itt_alloc_pool(int node, int size)
 		if (addr)
 			break;
 
-		page = its_alloc_pages_node(node, GFP_KERNEL | __GFP_ZERO, 1);
+		page = its_alloc_pages_node(node, GFP_KERNEL | __GFP_ZERO, 0);
 		if (!page)
 			break;
 
-- 
2.34.1



