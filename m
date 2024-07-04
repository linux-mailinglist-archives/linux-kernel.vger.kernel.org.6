Return-Path: <linux-kernel+bounces-240459-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 42836926DF4
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 05:13:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED1091F22C9C
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 03:13:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9E0B1946B;
	Thu,  4 Jul 2024 03:13:02 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 884E01B7F7
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jul 2024 03:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720062782; cv=none; b=sv//qZUTogAGoZKf1go9hn99hWNvUsLA2r8O3gEZrmO9Vt5cLK5SC7QAPznklf/VfYkm9ksn1+NoIKoZsCveJ5/+tl0hjlmXE2CVPcLbme22/5KWZJSd6nUJ35LT/N5YYN+3cm8ztM1cd0HL+7HDsBs+GbpS8xoYMjrP6kMgqzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720062782; c=relaxed/simple;
	bh=YOR7/V7dbNA2+IRtYeNmizSEedfTdg6VefKtceHK10A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aenDYroALIahUCL9kkQEYAg874A8IsoNxxNi10mp89uIMld2f1nKuZyfHElTEq0S4q1YMdMKN8xv2H/1Fv48+x2QkneOM7c9B9MQkPva33H2wPG+p/s/9U9NaIMP16gajjMANqlhi794/diN/MR4sBUVLyeH9JdOTE3zXqQnFsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 75DE9367;
	Wed,  3 Jul 2024 20:13:23 -0700 (PDT)
Received: from [10.162.40.16] (a077893.blr.arm.com [10.162.40.16])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A69953F762;
	Wed,  3 Jul 2024 20:12:55 -0700 (PDT)
Message-ID: <7d7134fe-f97d-453d-b90d-fb81008fff40@arm.com>
Date: Thu, 4 Jul 2024 08:42:52 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: limit MAX_PHYSMEM_BITS based on vmemmap
To: D Scott Phillips <scott@os.amperecomputing.com>,
 linux-arm-kernel@lists.infradead.org,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
 linux-kernel@vger.kernel.org, patches@amperecomputing.com
References: <20240703210707.1986816-1-scott@os.amperecomputing.com>
Content-Language: en-US
From: Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <20240703210707.1986816-1-scott@os.amperecomputing.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hello Scott,

On 7/4/24 02:37, D Scott Phillips wrote:
> Prior to the memory map adjustments in v6.9-rc1, the amdgpu driver could
> trip over the warning of:
> 
> `WARN_ON((start < VMEMMAP_START) || (end > VMEMMAP_END));`

Could you please provide the mainline commit ID for the mentioned memory
adjustment changes.

> 
> in vmemmap_populate()[1]. After the adjustments, it becomes a translation
> fault and panic.

Probably caused by accessing memory which does not exist on that address.

> 
> The cause is that the amdgpu driver allocates some unused space from
> iomem_resource and claims it as MEMORY_DEVICE_PRIVATE and
> devm_memremap_pages() it. An address above those backed by the vmemmap is
> used.
> 
> Adjust MAX_PHYSMEM_BITS so that addresses not backed by the vmemmap will
> not be chosen as device private addresses.
> 
> [1]: Call trace:
>       vmemmap_populate+0x30/0x48
>       __populate_section_memmap+0x40/0x90
>       sparse_add_section+0xfc/0x3e8
>       __add_pages+0xb4/0x168
>       pagemap_range+0x300/0x410
>       memremap_pages+0x184/0x2d8
>       devm_memremap_pages+0x30/0x90
>       kgd2kfd_init_zone_device+0xe0/0x1f0 [amdgpu]
>       amdgpu_device_ip_init+0x674/0x888 [amdgpu]
>       amdgpu_device_init+0x7bc/0xed8 [amdgpu]
>       amdgpu_driver_load_kms+0x28/0x1c0 [amdgpu]
>       amdgpu_pci_probe+0x194/0x580 [amdgpu]
>       local_pci_probe+0x48/0xb8
>       work_for_cpu_fn+0x24/0x40
>       process_one_work+0x170/0x3e0
>       worker_thread+0x2ac/0x3e0
>       kthread+0xf4/0x108
>       ret_from_fork+0x10/0x20
> 
> Signed-off-by: D Scott Phillips <scott@os.amperecomputing.com>
> ---
>  arch/arm64/include/asm/sparsemem.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/include/asm/sparsemem.h b/arch/arm64/include/asm/sparsemem.h
> index 8a8acc220371c..8387301f2e206 100644
> --- a/arch/arm64/include/asm/sparsemem.h
> +++ b/arch/arm64/include/asm/sparsemem.h
> @@ -5,7 +5,7 @@
>  #ifndef __ASM_SPARSEMEM_H
>  #define __ASM_SPARSEMEM_H
>  
> -#define MAX_PHYSMEM_BITS	CONFIG_ARM64_PA_BITS
> +#define MAX_PHYSMEM_BITS	ilog2(VMEMMAP_RANGE)

Just wondering if there is another method, which avoids selecting physical
memory ranges not backed with vmemmap. Also will reducing MAX_PHYSMEM_BITS
below ARM64_PA_BITS have other side effects ? Do other platforms have this
exact same co-relation between MAX_PHYSMEM_BITS and vmemmap range ?

>  
>  /*
>   * Section size must be at least 512MB for 64K base

