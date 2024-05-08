Return-Path: <linux-kernel+bounces-173697-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B31EE8C044C
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 20:26:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B71B2865C7
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 18:26:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FD2512C814;
	Wed,  8 May 2024 18:26:34 +0000 (UTC)
Received: from mslow1.mail.gandi.net (mslow1.mail.gandi.net [217.70.178.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C48F454FAA
	for <linux-kernel@vger.kernel.org>; Wed,  8 May 2024 18:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.178.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715192793; cv=none; b=CYi7iWvgZvbnN6+4VkS5hk0AhAqEL51Cz/VtLLivq0Of2qXqG6wpq2Rs8FkKHJ9FWbQhAeAhkgg9T61JfRLRf9NY4GKOwdxrdBuJ4WWB1htdY4SuCk0/1NvM7q9ji1BRGe8nTC04emhPf2rIT7gbkL9pO02mPhnjT2dvullX7qE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715192793; c=relaxed/simple;
	bh=oIvO6wRDB+Tamjd+aYPlKckkBTBydH1MgXq4hju3B7o=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=i3nSKv3uizK2kyZuTupbxHd0ndWH1m/tSpSNbRp1sJPYqZkglXI802PlVP/5Dm+JwGTHH30X1IyvALs4L7lr2H+I+Qn24/JcrUWfs4O4lHZjMJmv6KI7x3gYxLjtkoKtL4wdz+p5TVg4+jQiWlVzigRdLIAA4qLV7Kftt+pVhis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr; spf=pass smtp.mailfrom=ghiti.fr; arc=none smtp.client-ip=217.70.178.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ghiti.fr
Received: from relay2-d.mail.gandi.net (unknown [217.70.183.194])
	by mslow1.mail.gandi.net (Postfix) with ESMTP id B92D0C546E
	for <linux-kernel@vger.kernel.org>; Wed,  8 May 2024 18:22:48 +0000 (UTC)
Received: by mail.gandi.net (Postfix) with ESMTPSA id D5E4040005;
	Wed,  8 May 2024 18:22:43 +0000 (UTC)
Message-ID: <43829e94-98ae-46a4-a3e6-dbabbe94d7c1@ghiti.fr>
Date: Wed, 8 May 2024 20:22:43 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] riscv: Don't use hugepage mappings for vmemmap if it's
 not supported
Content-Language: en-US
To: Nam Cao <namcao@linutronix.de>, Paul Walmsley <paul.walmsley@sifive.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Alexandre Ghiti <alexghiti@rivosinc.com>, linux-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20240508173116.2866192-1-namcao@linutronix.de>
From: Alexandre Ghiti <alex@ghiti.fr>
In-Reply-To: <20240508173116.2866192-1-namcao@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Flag: yes
X-Spam-Level: **************************
X-GND-Spam-Score: 400
X-GND-Status: SPAM
X-GND-Sasl: alex@ghiti.fr

Hi Nam,

On 08/05/2024 19:31, Nam Cao wrote:
> Commit ff172d4818ad ("riscv: Use hugepage mappings for vmemmap") broke XIP
> kernel, because huge pages are not supported on XIP kernel.


I don't understand why XIP kernels can't support huge vmalloc mappings, 
so I think the right fix would be to enable such mappings on XIP. WDYT?

Thanks,

Alex


>
> Only use hugepage mapping if it is supported.
>
> Fixes: ff172d4818ad ("riscv: Use hugepage mappings for vmemmap")
> Signed-off-by: Nam Cao <namcao@linutronix.de>
> Cc: Alexandre Ghiti <alexghiti@rivosinc.com>
> Cc: <stable@vger.kernel.org>
> ---
>   arch/riscv/mm/init.c | 2 ++
>   1 file changed, 2 insertions(+)
>
> diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
> index 968761843203..c081e7d349b1 100644
> --- a/arch/riscv/mm/init.c
> +++ b/arch/riscv/mm/init.c
> @@ -1414,6 +1414,8 @@ int __meminit vmemmap_check_pmd(pmd_t *pmdp, int node,
>   int __meminit vmemmap_populate(unsigned long start, unsigned long end, int node,
>   			       struct vmem_altmap *altmap)
>   {
> +	if (!IS_ENABLED(CONFIG_HAVE_ARCH_HUGE_VMAP))
> +		return vmemmap_populate_basepages(start, end, node, NULL);
>   	/*
>   	 * Note that SPARSEMEM_VMEMMAP is only selected for rv64 and that we
>   	 * can't use hugepage mappings for 2-level page table because in case of

