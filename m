Return-Path: <linux-kernel+bounces-396240-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 857179BC9D4
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 11:00:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 49CA6283BE5
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 10:00:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3553E1D0F60;
	Tue,  5 Nov 2024 10:00:22 +0000 (UTC)
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 754FE155C8C;
	Tue,  5 Nov 2024 10:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730800821; cv=none; b=Yy9oJeH26mp6z1U1U8xGX7jN8HaakUg5LoH9KjtLgxDFarLaCe/S7ap7o3qE7TZPr3529yAItJnH0RL4xudj9hxnXk8VbWb0Qkbc5jLYarsW1l88YVryWzRKEgDxSIRKEaHVeqF3k4FYlPpfhSrgMUPYnoAZ940MVWa2NWZxZoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730800821; c=relaxed/simple;
	bh=oW8MJhtkmrR9J4NZgmtt4vc8lb6iqpBcnLMgRaLCOLU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YViyhAnZheHjrViaoUH8LKylqZqPFBe6M5KXZdJCPe8SjiFfhxj9zHCmqwNE6S/FdJs3TB1uwUg+PuVqnbDZkAkU0V8kwyd0eY1yenOw5IGIdsS8ouIKja//I8n65IgxOyzJACXgTtma8SPusK1dm9G+LS05kJnsnt7t/XpNDBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr; spf=pass smtp.mailfrom=ghiti.fr; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ghiti.fr
Received: by mail.gandi.net (Postfix) with ESMTPSA id EEB6E2000C;
	Tue,  5 Nov 2024 10:00:08 +0000 (UTC)
Message-ID: <e9aebe78-2e5b-43f3-bd96-45bd9f9e7269@ghiti.fr>
Date: Tue, 5 Nov 2024 11:00:08 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/11] riscv: mm: Deduplicate _PAGE_CHG_MASK definition
Content-Language: en-US
To: Samuel Holland <samuel.holland@sifive.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, linux-riscv@lists.infradead.org,
 Conor Dooley <conor@kernel.org>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 Alexandre Ghiti <alexghiti@rivosinc.com>,
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
 Emil Renner Berthing <kernel@esmil.dk>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>
References: <20241102000843.1301099-1-samuel.holland@sifive.com>
 <20241102000843.1301099-5-samuel.holland@sifive.com>
From: Alexandre Ghiti <alex@ghiti.fr>
In-Reply-To: <20241102000843.1301099-5-samuel.holland@sifive.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-GND-Sasl: alex@ghiti.fr

On 02/11/2024 01:07, Samuel Holland wrote:
> The two existing definitions are equivalent because _PAGE_MTMASK is
> defined as 0 on riscv32.
>
> Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
> ---
>
>   arch/riscv/include/asm/pgtable-32.h | 5 -----
>   arch/riscv/include/asm/pgtable-64.h | 7 -------
>   arch/riscv/include/asm/pgtable.h    | 6 ++++++
>   3 files changed, 6 insertions(+), 12 deletions(-)
>
> diff --git a/arch/riscv/include/asm/pgtable-32.h b/arch/riscv/include/asm/pgtable-32.h
> index 23137347dc15..7dc0751d67dc 100644
> --- a/arch/riscv/include/asm/pgtable-32.h
> +++ b/arch/riscv/include/asm/pgtable-32.h
> @@ -28,11 +28,6 @@
>   #define _PAGE_IO		0
>   #define _PAGE_MTMASK		0
>   
> -/* Set of bits to preserve across pte_modify() */
> -#define _PAGE_CHG_MASK  (~(unsigned long)(_PAGE_PRESENT | _PAGE_READ |	\
> -					  _PAGE_WRITE | _PAGE_EXEC |	\
> -					  _PAGE_USER | _PAGE_GLOBAL))
> -
>   #define pud_pfn(pud)				(pmd_pfn((pmd_t){ pud }))
>   #define p4d_pfn(p4d)				(pud_pfn((pud_t){ p4d }))
>   #define pgd_pfn(pgd)				(p4d_pfn((p4d_t){ pgd }))
> diff --git a/arch/riscv/include/asm/pgtable-64.h b/arch/riscv/include/asm/pgtable-64.h
> index 33e7ff049c4a..4ba88592b8d1 100644
> --- a/arch/riscv/include/asm/pgtable-64.h
> +++ b/arch/riscv/include/asm/pgtable-64.h
> @@ -66,7 +66,6 @@ typedef struct {
>   
>   #define pmd_val(x)      ((x).pmd)
>   #define __pmd(x)        ((pmd_t) { (x) })
> -
>   #define PTRS_PER_PMD    (PAGE_SIZE / sizeof(pmd_t))
>   
>   /*
> @@ -166,12 +165,6 @@ static inline u64 riscv_page_io(void)
>   #define _PAGE_IO		riscv_page_io()
>   #define _PAGE_MTMASK		riscv_page_mtmask()
>   
> -/* Set of bits to preserve across pte_modify() */
> -#define _PAGE_CHG_MASK  (~(unsigned long)(_PAGE_PRESENT | _PAGE_READ |	\
> -					  _PAGE_WRITE | _PAGE_EXEC |	\
> -					  _PAGE_USER | _PAGE_GLOBAL |	\
> -					  _PAGE_MTMASK))
> -
>   static inline int pud_present(pud_t pud)
>   {
>   	return (pud_val(pud) & _PAGE_PRESENT);
> diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
> index 3e0e1177107d..afa0b455eaa4 100644
> --- a/arch/riscv/include/asm/pgtable.h
> +++ b/arch/riscv/include/asm/pgtable.h
> @@ -201,6 +201,12 @@ extern struct pt_alloc_ops pt_ops __meminitdata;
>   #define _PAGE_IOREMAP	((_PAGE_KERNEL & ~_PAGE_MTMASK) | _PAGE_IO)
>   #define PAGE_KERNEL_IO		__pgprot(_PAGE_IOREMAP)
>   
> +/* Set of bits to preserve across pte_modify() */
> +#define _PAGE_CHG_MASK  (~(unsigned long)(_PAGE_PRESENT | _PAGE_READ |	\
> +					  _PAGE_WRITE | _PAGE_EXEC |	\
> +					  _PAGE_USER | _PAGE_GLOBAL |	\
> +					  _PAGE_MTMASK))
> +
>   extern pgd_t swapper_pg_dir[];
>   extern pgd_t trampoline_pg_dir[];
>   extern pgd_t early_pg_dir[];

Nice clean up too, you can add:

Reviewed-by: Alexandre Ghiti <alexghiti@rivosinc.com>

Thanks,

Alex


