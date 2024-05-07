Return-Path: <linux-kernel+bounces-170697-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A126D8BDAB3
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 07:35:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 09BCAB23C85
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 05:35:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9535A6BFA2;
	Tue,  7 May 2024 05:35:27 +0000 (UTC)
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34FD44F616
	for <linux-kernel@vger.kernel.org>; Tue,  7 May 2024 05:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715060127; cv=none; b=d04xB1XmcyjEjazyLxUXu5Hydlo254QQOK6fAnq2cIq0+vKWbBDVBLHoq0zT+K4Dguev87zjp+4YJqlqXHHC+yM0uYnHoKihQYbXhwK/2pcAY++dMXKjKcBJT+/80Auz+B3uwUB6Wq8Bg7JtNYTLKVWVVWSCg4FXQxKMCtV7bPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715060127; c=relaxed/simple;
	bh=R1izPi+9m/IigXoYuUTrLyfKZKRClql2EXOPJevJbxs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VMwXycc1/e1VVuZWj7s9QXFiO2VIT6nX3z19e+hfiUQOCoOLnLwtRkJ/yXFvOD7lcdzxsxC3sWQKBia2X58XDzBa9DGonx0qngBOSaPtVshTWJfh9Whrybrqb6hBqfje92dicxffrCVzQDuaqL6aHbXMQ+hxq1ySuCmA32sRJIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr; spf=pass smtp.mailfrom=ghiti.fr; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ghiti.fr
Received: by mail.gandi.net (Postfix) with ESMTPSA id 4BD24C0003;
	Tue,  7 May 2024 05:35:20 +0000 (UTC)
Message-ID: <5a812c84-c3bb-4874-b29c-0816494b77a8@ghiti.fr>
Date: Tue, 7 May 2024 07:35:20 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/5] riscv: Add update_mmu_tlb_range()
Content-Language: en-US
To: Bang Li <libang.li@antgroup.com>, akpm@linux-foundation.org,
 chenhuacai@kernel.org, tsbogend@alpha.franken.de, paul.walmsley@sifive.com,
 palmer@dabbelt.com, chris@zankel.net, jcmvbkbc@gmail.com
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 loongarch@lists.linux.dev, linux-riscv@lists.infradead.org,
 david@redhat.com, ryan.roberts@arm.com, ioworker0@gmail.com,
 libang.linux@gmail.com
References: <20240506155120.83105-1-libang.li@antgroup.com>
 <20240506155120.83105-4-libang.li@antgroup.com>
From: Alexandre Ghiti <alex@ghiti.fr>
In-Reply-To: <20240506155120.83105-4-libang.li@antgroup.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-GND-Sasl: alex@ghiti.fr

Hi Bang,

On 06/05/2024 17:51, Bang Li wrote:
> Added update_mmu_tlb_range function, we can batch update tlb of an
> address range.
>
> Signed-off-by: Bang Li <libang.li@antgroup.com>
> ---
>   arch/riscv/include/asm/pgtable.h | 4 ++++
>   1 file changed, 4 insertions(+)
>
> diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
> index 661b2b4fe758..f784c6dd2c66 100644
> --- a/arch/riscv/include/asm/pgtable.h
> +++ b/arch/riscv/include/asm/pgtable.h
> @@ -489,6 +489,10 @@ static inline void update_mmu_cache_range(struct vm_fault *vmf,
>   #define __HAVE_ARCH_UPDATE_MMU_TLB
>   #define update_mmu_tlb update_mmu_cache
>   
> +#define __HAVE_ARCH_UPDATE_MMU_TLB_RANGE
> +#define update_mmu_tlb_range(vma, addr, ptep, nr) \
> +	update_mmu_cache_range(NULL, vma, addr, ptep, nr)
> +
>   static inline void update_mmu_cache_pmd(struct vm_area_struct *vma,
>   		unsigned long address, pmd_t *pmdp)
>   {


You can add:

Reviewed-by: Alexandre Ghiti <alexghiti@rivosinc.com>

Thanks,

Alex


