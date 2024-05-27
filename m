Return-Path: <linux-kernel+bounces-190608-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D9FBE8D0065
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 14:50:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 78C221F2396A
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 12:50:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFA9015E5C7;
	Mon, 27 May 2024 12:50:03 +0000 (UTC)
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 459194D5A2
	for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 12:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716814203; cv=none; b=VOzkATnwKfsAecOVchNRnqZwWBEBk/Ir+1Bfx0b/CUUmycaagUuD/ZoWTnWZd7a/2x74UeUUEds5HNuC055lXLkO8BNuQZpD0K3iFUx6x3nWDtyv38/XvIqp4oz9pkAkhhXeY1KNSt2OlC+37jUxmZ8khw3FpaxGg4iCio+qtik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716814203; c=relaxed/simple;
	bh=qmoXTNHUYcQhTTkK7zjwu5RydcbhSzwSS0Qq7JNAFmA=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=PF98EFvBs2ndHOOFVEOynoCy4Gm3sd3PGvhzU3RMHWptQPshkEX7ub077gZl1jc5nMzNb935RFL8iLJ2ktOEKyPTkIfK8KNmEwveaNcIJ9V1gqsWK+RRA4mH1MyLKmgtcDb3WJS3NrjJzb/H94ChK5ZHI7pIFlugjPOFLh8vBhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr; spf=pass smtp.mailfrom=ghiti.fr; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ghiti.fr
Received: by mail.gandi.net (Postfix) with ESMTPSA id 2EE121C000C;
	Mon, 27 May 2024 12:49:57 +0000 (UTC)
Message-ID: <187d7992-e2a7-446c-9f53-d0e7bf6a5843@ghiti.fr>
Date: Mon, 27 May 2024 14:49:57 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/7] riscv: drop the use of XIP_OFFSET in
 kernel_mapping_va_to_pa()
Content-Language: en-US
To: Nam Cao <namcao@linutronix.de>, Paul Walmsley <paul.walmsley@sifive.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
References: <cover.1715286093.git.namcao@linutronix.de>
 <5439a181cdd7ba185d55457200ddda2d2efa5eb1.1715286093.git.namcao@linutronix.de>
From: Alexandre Ghiti <alex@ghiti.fr>
In-Reply-To: <5439a181cdd7ba185d55457200ddda2d2efa5eb1.1715286093.git.namcao@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-GND-Sasl: alex@ghiti.fr


On 10/05/2024 08:28, Nam Cao wrote:
> XIP_OFFSET is the hard-coded offset of writable data section within the
> kernel.
>
> By hard-coding this value, the read-only section of the kernel (which is
> placed before the writable data section) is restricted in size.
>
> As a preparation to remove this hard-coded macro XIP_OFFSET entirely,
> remove the use of XIP_OFFSET in kernel_mapping_va_to_pa(). The macro
> XIP_OFFSET is used in this case to check if the virtual address is mapped
> to Flash or to RAM. The same check can be done with kernel_map.xiprom_sz.
>
> Signed-off-by: Nam Cao <namcao@linutronix.de>
> ---
>   arch/riscv/include/asm/page.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/riscv/include/asm/page.h b/arch/riscv/include/asm/page.h
> index 14d0de928f9b..bcd77df15835 100644
> --- a/arch/riscv/include/asm/page.h
> +++ b/arch/riscv/include/asm/page.h
> @@ -159,7 +159,7 @@ phys_addr_t linear_mapping_va_to_pa(unsigned long x);
>   #ifdef CONFIG_XIP_KERNEL
>   #define kernel_mapping_va_to_pa(y) ({						\
>   	unsigned long _y = (unsigned long)(y);					\
> -	(_y < kernel_map.virt_addr + XIP_OFFSET) ?				\
> +	(_y < kernel_map.virt_addr + kernel_map.xiprom_sz) ?			\
>   		(_y - kernel_map.va_kernel_xip_pa_offset) :			\
>   		(_y - kernel_map.va_kernel_data_pa_offset);			\
>   	})


Reviewed-by: Alexandre Ghiti <alexghiti@rivosinc.com>

Thanks,

Alex


