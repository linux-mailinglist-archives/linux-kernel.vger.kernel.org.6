Return-Path: <linux-kernel+bounces-396524-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 57C159BCE5F
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 14:55:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 915111C2190A
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 13:55:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DB101D6DBB;
	Tue,  5 Nov 2024 13:55:08 +0000 (UTC)
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6B3DBE4E
	for <linux-kernel@vger.kernel.org>; Tue,  5 Nov 2024 13:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730814907; cv=none; b=gLEYEdYWRQMuTvw+zLlul768KetcC5qGsl0i6vfERarrsBWuptOAMgBvWn8Jeh0q47a2g88ENyiUHcJp0zWywJzFkS5fE/iuw5qxbwrHviCwvXxwsM6/0Wwzkmo0hixATDB/qkrsXp1njhl9YuWq81l9GwpmCCfFSQ0ctE2O8is=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730814907; c=relaxed/simple;
	bh=jl6e9s2TfPZIsVCE0Xz8t1a0WT0cPFHP6KQQgbMmHKk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hLoX5CrLhtl/FN8ur3Xm9oX/F3DraQ+RTKUEf+X2qTzbcrFlcsIeGRiqFcnj4LoryZcyLEozYHZLOuXRVpXP8MnHcL/gILA4GKVgGQnHo4N8Ko7UB9rQcKDMi91PPmarDTHPtVYli6EVZ/dzyw8rMcR7vxHzlx3d/YptU0O5Pws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr; spf=pass smtp.mailfrom=ghiti.fr; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ghiti.fr
Received: by mail.gandi.net (Postfix) with ESMTPSA id DFB34E0003;
	Tue,  5 Nov 2024 13:55:01 +0000 (UTC)
Message-ID: <e8cf563f-d840-4e33-9ca0-2fa734c9f6c2@ghiti.fr>
Date: Tue, 5 Nov 2024 14:55:01 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 7/9] riscv: Align the sv39 linear map to 16 GiB
Content-Language: en-US
To: Samuel Holland <samuel.holland@sifive.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, linux-riscv@lists.infradead.org,
 Andrey Ryabinin <ryabinin.a.a@gmail.com>,
 Alexander Potapenko <glider@google.com>,
 Andrey Konovalov <andreyknvl@gmail.com>, Dmitry Vyukov <dvyukov@google.com>,
 Vincenzo Frascino <vincenzo.frascino@arm.com>, kasan-dev@googlegroups.com
Cc: llvm@lists.linux.dev, Catalin Marinas <catalin.marinas@arm.com>,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 Alexandre Ghiti <alexghiti@rivosinc.com>, Will Deacon <will@kernel.org>,
 Evgenii Stepanov <eugenis@google.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 linux-arm-kernel@lists.infradead.org
References: <20241022015913.3524425-1-samuel.holland@sifive.com>
 <20241022015913.3524425-8-samuel.holland@sifive.com>
From: Alexandre Ghiti <alex@ghiti.fr>
In-Reply-To: <20241022015913.3524425-8-samuel.holland@sifive.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-GND-Sasl: alex@ghiti.fr

On 22/10/2024 03:57, Samuel Holland wrote:
> The KASAN implementation on RISC-V requires the shadow memory for the
> vmemmap and linear map regions to be aligned to a PMD boundary (1 GiB).


PUD boundary


> For KASAN_GENERIC (KASAN_SHADOW_SCALE_SHIFT == 3), this enforces 8 GiB
> alignment for the memory regions themselves. KASAN_SW_TAGS uses 16-byte
> granules (KASAN_SHADOW_SCALE_SHIFT == 4), so now the memory regions must
> be aligned to a 16 GiB boundary.
>
> Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
> ---
>
> (no changes since v1)
>
>   Documentation/arch/riscv/vm-layout.rst | 10 +++++-----
>   arch/riscv/include/asm/page.h          |  2 +-
>   2 files changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/Documentation/arch/riscv/vm-layout.rst b/Documentation/arch/riscv/vm-layout.rst
> index eabec99b5852..c0778c421b34 100644
> --- a/Documentation/arch/riscv/vm-layout.rst
> +++ b/Documentation/arch/riscv/vm-layout.rst
> @@ -47,11 +47,11 @@ RISC-V Linux Kernel SV39
>                                                                 | Kernel-space virtual memory, shared between all processes:
>     ____________________________________________________________|___________________________________________________________
>                       |            |                  |         |
> -   ffffffc4fea00000 | -236    GB | ffffffc4feffffff |    6 MB | fixmap
> -   ffffffc4ff000000 | -236    GB | ffffffc4ffffffff |   16 MB | PCI io
> -   ffffffc500000000 | -236    GB | ffffffc5ffffffff |    4 GB | vmemmap
> -   ffffffc600000000 | -232    GB | ffffffd5ffffffff |   64 GB | vmalloc/ioremap space
> -   ffffffd600000000 | -168    GB | fffffff5ffffffff |  128 GB | direct mapping of all physical memory
> +   ffffffc2fea00000 | -244    GB | ffffffc2feffffff |    6 MB | fixmap
> +   ffffffc2ff000000 | -244    GB | ffffffc2ffffffff |   16 MB | PCI io
> +   ffffffc300000000 | -244    GB | ffffffc3ffffffff |    4 GB | vmemmap
> +   ffffffc400000000 | -240    GB | ffffffd3ffffffff |   64 GB | vmalloc/ioremap space
> +   ffffffd400000000 | -176    GB | fffffff3ffffffff |  128 GB | direct mapping of all physical memory
>                       |            |                  |         |
>      fffffff700000000 |  -36    GB | fffffffeffffffff |   32 GB | kasan
>     __________________|____________|__________________|_________|____________________________________________________________
> diff --git a/arch/riscv/include/asm/page.h b/arch/riscv/include/asm/page.h
> index 32d308a3355f..6e2f79cf77c5 100644
> --- a/arch/riscv/include/asm/page.h
> +++ b/arch/riscv/include/asm/page.h
> @@ -37,7 +37,7 @@
>    * define the PAGE_OFFSET value for SV48 and SV39.
>    */
>   #define PAGE_OFFSET_L4		_AC(0xffffaf8000000000, UL)
> -#define PAGE_OFFSET_L3		_AC(0xffffffd600000000, UL)
> +#define PAGE_OFFSET_L3		_AC(0xffffffd400000000, UL)
>   #else
>   #define PAGE_OFFSET		_AC(CONFIG_PAGE_OFFSET, UL)
>   #endif /* CONFIG_64BIT */


Other than the nit above (that I think should be fixed though), you can add:

Reviewed-by: Alexandre Ghiti <alexghiti@rivosinc.com>

Thanks,

Alex


