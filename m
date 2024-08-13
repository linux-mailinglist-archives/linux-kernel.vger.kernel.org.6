Return-Path: <linux-kernel+bounces-284545-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ABADC95022B
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 12:13:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DDBE91C211A3
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 10:13:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB3E818953E;
	Tue, 13 Aug 2024 10:13:23 +0000 (UTC)
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA95119470;
	Tue, 13 Aug 2024 10:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723544003; cv=none; b=lCjzDkp9qZQVJvVxwB4jFK1AumaU1o0kgb+zI3p4Tt3sfaiyneg7euLm6QHVmAU3+EHMRey4HOgaSQPck50tpboBP7dFHH57n7ZEetNnXcCIhrUUYZzbBHSVYC4C6QXTRtRKdFolHu1/wGIN0/2RxVQk50/qdV4wRvkqcEpdG7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723544003; c=relaxed/simple;
	bh=W331D/PUjvZjCqYIGYZ4nkXl96CMPr3mXkrKLYAiA1o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=p3Ko5ELLqDmVJzXvrVulUxGH3CKTWbEMNOrbdek4SePqCQILk/LkAiSFlD29DvQ1sBMZ1KxfSKEjrlr5GPoedVo5a07f6DMXPg402DUz6kuzMR1YEiFLWU6PB0wSgQ/x9ZlkLA1cYqvBe7D8zfBCygI6n9/bv/61DTHBeAIl6Yw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr; spf=pass smtp.mailfrom=ghiti.fr; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ghiti.fr
Received: by mail.gandi.net (Postfix) with ESMTPSA id B2980FF803;
	Tue, 13 Aug 2024 10:13:10 +0000 (UTC)
Message-ID: <4fe4a8a0-b5ac-4c52-ac9f-210c59a5d2f2@ghiti.fr>
Date: Tue, 13 Aug 2024 12:13:10 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 03/10] riscv: Add CSR definitions for pointer masking
Content-Language: en-US
To: Samuel Holland <samuel.holland@sifive.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, linux-riscv@lists.infradead.org
Cc: devicetree@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>,
 linux-kernel@vger.kernel.org, Anup Patel <anup@brainfault.org>,
 Conor Dooley <conor@kernel.org>, kasan-dev@googlegroups.com,
 Atish Patra <atishp@atishpatra.org>, Evgenii Stepanov <eugenis@google.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Rob Herring <robh+dt@kernel.org>,
 "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
References: <20240625210933.1620802-1-samuel.holland@sifive.com>
 <20240625210933.1620802-4-samuel.holland@sifive.com>
From: Alexandre Ghiti <alex@ghiti.fr>
In-Reply-To: <20240625210933.1620802-4-samuel.holland@sifive.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-GND-Sasl: alex@ghiti.fr


On 25/06/2024 23:09, Samuel Holland wrote:
> Pointer masking is controlled via a two-bit PMM field, which appears in
> various CSRs depending on which extensions are implemented. Smmpm adds
> the field to mseccfg; Smnpm adds the field to menvcfg; Ssnpm adds the
> field to senvcfg. If the H extension is implemented, Ssnpm also defines
> henvcfg.PMM and hstatus.HUPMM.
>
> Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
> ---
>
> Changes in v2:
>   - Use the correct name for the hstatus.HUPMM field
>
>   arch/riscv/include/asm/csr.h | 16 ++++++++++++++++
>   1 file changed, 16 insertions(+)
>
> diff --git a/arch/riscv/include/asm/csr.h b/arch/riscv/include/asm/csr.h
> index 25966995da04..5c0c0d574f63 100644
> --- a/arch/riscv/include/asm/csr.h
> +++ b/arch/riscv/include/asm/csr.h
> @@ -119,6 +119,10 @@
>   
>   /* HSTATUS flags */
>   #ifdef CONFIG_64BIT
> +#define HSTATUS_HUPMM		_AC(0x3000000000000, UL)
> +#define HSTATUS_HUPMM_PMLEN_0	_AC(0x0000000000000, UL)
> +#define HSTATUS_HUPMM_PMLEN_7	_AC(0x2000000000000, UL)
> +#define HSTATUS_HUPMM_PMLEN_16	_AC(0x3000000000000, UL)
>   #define HSTATUS_VSXL		_AC(0x300000000, UL)
>   #define HSTATUS_VSXL_SHIFT	32
>   #endif
> @@ -195,6 +199,10 @@
>   /* xENVCFG flags */
>   #define ENVCFG_STCE			(_AC(1, ULL) << 63)
>   #define ENVCFG_PBMTE			(_AC(1, ULL) << 62)
> +#define ENVCFG_PMM			_AC(0x300000000, ULL)
> +#define ENVCFG_PMM_PMLEN_0		_AC(0x000000000, ULL)
> +#define ENVCFG_PMM_PMLEN_7		_AC(0x200000000, ULL)
> +#define ENVCFG_PMM_PMLEN_16		_AC(0x300000000, ULL)


Nit: the other ENVCFG_XX use (_AC(Y, ULL) << Z)


>   #define ENVCFG_CBZE			(_AC(1, UL) << 7)
>   #define ENVCFG_CBCFE			(_AC(1, UL) << 6)
>   #define ENVCFG_CBIE_SHIFT		4
> @@ -216,6 +224,12 @@
>   #define SMSTATEEN0_SSTATEEN0_SHIFT	63
>   #define SMSTATEEN0_SSTATEEN0		(_ULL(1) << SMSTATEEN0_SSTATEEN0_SHIFT)
>   
> +/* mseccfg bits */
> +#define MSECCFG_PMM			ENVCFG_PMM
> +#define MSECCFG_PMM_PMLEN_0		ENVCFG_PMM_PMLEN_0
> +#define MSECCFG_PMM_PMLEN_7		ENVCFG_PMM_PMLEN_7
> +#define MSECCFG_PMM_PMLEN_16		ENVCFG_PMM_PMLEN_16
> +
>   /* symbolic CSR names: */
>   #define CSR_CYCLE		0xc00
>   #define CSR_TIME		0xc01
> @@ -382,6 +396,8 @@
>   #define CSR_MIP			0x344
>   #define CSR_PMPCFG0		0x3a0
>   #define CSR_PMPADDR0		0x3b0
> +#define CSR_MSECCFG		0x747
> +#define CSR_MSECCFGH		0x757
>   #define CSR_MVENDORID		0xf11
>   #define CSR_MARCHID		0xf12
>   #define CSR_MIMPID		0xf13

