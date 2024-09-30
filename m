Return-Path: <linux-kernel+bounces-343731-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 85FA6989ED5
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 11:56:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 45948281C7A
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 09:56:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF4F918BBB5;
	Mon, 30 Sep 2024 09:55:40 +0000 (UTC)
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 465A118DF73
	for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 09:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727690140; cv=none; b=Py8sHNCdZiWJ5umDwy6LiaOKtLMMrIOgHrKTQJ+vqOXna6XlgygEXQL7TgLcM32qucwkkZh+5h0ZuWWU5H4p6fynPZ7gg/2rsPrkARYIY8WKof9HoYNF33qEDg2lzPHNqWf7ttwiC25yZpog8XcFCQSfW89Wo/9guGn13qkBbgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727690140; c=relaxed/simple;
	bh=QIKUiExVKDaAHlgBgjT31THH9clBpXUkPTzClPM3hCU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OzcNI2x3R4V6+p+I+gVRNADR28bTxcRas7o+jdVtmBW0AeHYekkamRGKcHhPI6ZUg8Knqyuy/Cw/wC5JZCUr6fTtVVpOdQlCbm/XPu/qTZM9qio2gCYhZBs2lnDfhRIJ8WpsSu/KvVIHpfUDYjPeIZIXiyQp4IBUVS95wqEkeGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr; spf=pass smtp.mailfrom=ghiti.fr; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ghiti.fr
Received: by mail.gandi.net (Postfix) with ESMTPSA id AC5201BF205;
	Mon, 30 Sep 2024 09:55:28 +0000 (UTC)
Message-ID: <e8f6ed93-d47c-4c07-963c-8f16f498abed@ghiti.fr>
Date: Mon, 30 Sep 2024 11:55:28 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] riscv: make ZONE_DMA32 optional
Content-Language: en-US
To: Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org
References: <20240827113611.537302-1-vladimir.kondratiev@mobileye.com>
From: Alexandre Ghiti <alex@ghiti.fr>
In-Reply-To: <20240827113611.537302-1-vladimir.kondratiev@mobileye.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-GND-Sasl: alex@ghiti.fr

Hi Vladimir,

On 27/08/2024 13:36, Vladimir Kondratiev wrote:
> It is not necessary any RISCV platform has ZONE_DMA32.
>
> Example - if platform has no DRAM in [0..4G] region,
> it will report failure like below each boot.
>
> [    0.088709] swapper/0: page allocation failure: order:7, mode:0xcc4(GFP_KERNEL|GFP_DMA32), nodemask=(null),cpuset=/
> [    0.088832] CPU: 0 UID: 0 PID: 1 Comm: swapper/0 Not tainted 6.11.0-rc5 #30
> [    0.088864] Call Trace:
> [    0.088869] [<ffffffff800059f2>] dump_backtrace+0x1c/0x24
> [    0.088910] [<ffffffff805f328c>] show_stack+0x2c/0x38
> [    0.088957] [<ffffffff805fd800>] dump_stack_lvl+0x52/0x74
> [    0.088987] [<ffffffff805fd836>] dump_stack+0x14/0x1c
> [    0.089010] [<ffffffff801a23a8>] warn_alloc+0xf4/0x176
> [    0.089041] [<ffffffff801a3052>] __alloc_pages_noprof+0xc28/0xcb4
> [    0.089067] [<ffffffff80086eda>] atomic_pool_expand+0x62/0x1f8
> [    0.089090] [<ffffffff8080d674>] __dma_atomic_pool_init+0x46/0x9e
> [    0.089115] [<ffffffff8080d762>] dma_atomic_pool_init+0x96/0x11c
> [    0.089139] [<ffffffff80002146>] do_one_initcall+0x5c/0x1b2
> [    0.089158] [<ffffffff8080127c>] kernel_init_freeable+0x214/0x274
> [    0.089190] [<ffffffff805fefd8>] kernel_init+0x1e/0x10a
> [    0.089209] [<ffffffff8060748a>] ret_from_fork+0xe/0x1c
>
> Signed-off-by: Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>
> ---
>   arch/riscv/Kconfig | 2 +-
>   mm/Kconfig         | 2 +-
>   2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index 0f3cd7c3a436..94a573112625 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -50,6 +50,7 @@ config RISCV
>   	select ARCH_HAS_TICK_BROADCAST if GENERIC_CLOCKEVENTS_BROADCAST
>   	select ARCH_HAS_UBSAN
>   	select ARCH_HAS_VDSO_DATA
> +	select ARCH_HAS_ZONE_DMA_SET if 64BIT
>   	select ARCH_KEEP_MEMBLOCK if ACPI
>   	select ARCH_MHP_MEMMAP_ON_MEMORY_ENABLE	if 64BIT && MMU
>   	select ARCH_OPTIONAL_KERNEL_RWX if ARCH_HAS_STRICT_KERNEL_RWX
> @@ -200,7 +201,6 @@ config RISCV
>   	select THREAD_INFO_IN_TASK
>   	select TRACE_IRQFLAGS_SUPPORT
>   	select UACCESS_MEMCPY if !MMU
> -	select ZONE_DMA32 if 64BIT
>   
>   config CLANG_SUPPORTS_DYNAMIC_FTRACE
>   	def_bool CC_IS_CLANG
> diff --git a/mm/Kconfig b/mm/Kconfig
> index b72e7d040f78..97c85da98e89 100644
> --- a/mm/Kconfig
> +++ b/mm/Kconfig
> @@ -1032,7 +1032,7 @@ config ZONE_DMA
>   config ZONE_DMA32
>   	bool "Support DMA32 zone" if ARCH_HAS_ZONE_DMA_SET
>   	depends on !X86_32
> -	default y if ARM64
> +	default y if ARM64 || (RISCV && 64BIT)
>   
>   config ZONE_DEVICE
>   	bool "Device memory (pmem, HMM, etc...) hotplug support"


I'm wondering how distro kernels will deal with that since some 
platforms will need the ZONE_DMA32 and some others will break when 
enabled as you have shown.

Is there a way to make it optional at runtime instead?

Thanks,

Alex


