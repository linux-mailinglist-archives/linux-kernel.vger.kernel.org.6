Return-Path: <linux-kernel+bounces-190644-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BBDCB8D00DB
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 15:03:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7446D1F23C50
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 13:03:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 025A715F316;
	Mon, 27 May 2024 12:58:20 +0000 (UTC)
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 916DF15ECCD
	for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 12:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716814699; cv=none; b=ijYm9O2WM1/Qc7haVhFpCTpv2JMnNJscREl3ndSvMdL46zhEE2tJoum1aaBseCpIP6ejSVG6ofk2VzdZKnrTcfyvarobxScQfgejN1MYC0lahsJsQIipxI0+rgp2O0Yo7IpNPhUesIOMZvA1XQExeZyO1vkO1MRswat7WwPYbog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716814699; c=relaxed/simple;
	bh=v0J+sOVDHQy2wLhWEYp0vZ3fGEo6tOMovB9cWlyGRcQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iXhyaC30r3jY13/+ZlYBDewA4/+0pEmHfJKtIHOvr3o7D8Jgl640yHtoxT3TtOs1fb/NOS1YoN/b4voL8FzL0NubQ/K4CGiKVARQiPhzg1plF592hH63SVAOkZOLeQAN3PqmpVNe3fdYt3Hn2mO7mAzJILJugbKDc9/JF1g9u9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr; spf=pass smtp.mailfrom=ghiti.fr; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ghiti.fr
Received: by mail.gandi.net (Postfix) with ESMTPSA id 2C3D620008;
	Mon, 27 May 2024 12:58:15 +0000 (UTC)
Message-ID: <2e092f39-0716-4b73-9268-da9211a4b600@ghiti.fr>
Date: Mon, 27 May 2024 14:58:14 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7/7] riscv: remove limit on the size of read-only section
 for XIP kernel
Content-Language: en-US
To: Nam Cao <namcao@linutronix.de>, Paul Walmsley <paul.walmsley@sifive.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: kernel test robot <lkp@intel.com>
References: <cover.1715286093.git.namcao@linutronix.de>
 <9eea4b61f7b6300def3b6582d8e465ef4207501e.1715286093.git.namcao@linutronix.de>
From: Alexandre Ghiti <alex@ghiti.fr>
In-Reply-To: <9eea4b61f7b6300def3b6582d8e465ef4207501e.1715286093.git.namcao@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-GND-Sasl: alex@ghiti.fr


On 10/05/2024 08:28, Nam Cao wrote:
> XIP_OFFSET is the hard-coded offset of writable data section within the
> kernel.
>
> By hard-coding this value, the read-only section of the kernel (which is
> placed before the writable data section) is restricted in size. This causes
> build failures if the kernel get too big (an example is in Closes:).

s/get/gets

I think you can use:

Closes: https://lore.kernel.org/oe-kbuild-all/202404211031.J6l2AfJk-lkp@intel.com/ [1]

And instead use:

s/an example is in Closes:/[1]


>
> Remove this limit.
>
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202404211031.J6l2AfJk-lkp@intel.com/
> Signed-off-by: Nam Cao <namcao@linutronix.de>
> ---
>   arch/riscv/include/asm/pgtable.h    | 7 -------
>   arch/riscv/kernel/vmlinux-xip.lds.S | 4 ++--
>   2 files changed, 2 insertions(+), 9 deletions(-)
>
> diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
> index fbf342f4afee..75f4a92ea5bb 100644
> --- a/arch/riscv/include/asm/pgtable.h
> +++ b/arch/riscv/include/asm/pgtable.h
> @@ -104,13 +104,6 @@
>   
>   #endif
>   
> -#ifdef CONFIG_XIP_KERNEL
> -#define XIP_OFFSET		SZ_32M
> -#define XIP_OFFSET_MASK		(SZ_32M - 1)
> -#else
> -#define XIP_OFFSET		0
> -#endif
> -
>   #ifndef __ASSEMBLY__
>   
>   #include <asm/page.h>
> diff --git a/arch/riscv/kernel/vmlinux-xip.lds.S b/arch/riscv/kernel/vmlinux-xip.lds.S
> index 8c3daa1b0531..01f73f2ffecc 100644
> --- a/arch/riscv/kernel/vmlinux-xip.lds.S
> +++ b/arch/riscv/kernel/vmlinux-xip.lds.S
> @@ -65,10 +65,10 @@ SECTIONS
>    * From this point, stuff is considered writable and will be copied to RAM
>    */
>   	__data_loc = ALIGN(PAGE_SIZE);		/* location in file */
> -	. = KERNEL_LINK_ADDR + XIP_OFFSET;	/* location in memory */
> +	. = ALIGN(SZ_2M);			/* location in memory */


You can't use SZ_2M here since it corresponds to PMD_SIZE for rv64 but 
on rv32 (which is allowed to use xip kernels), it's 4MB. Use 
SECTION_ALIGN instead.


>   
>   #undef LOAD_OFFSET
> -#define LOAD_OFFSET (KERNEL_LINK_ADDR + XIP_OFFSET - (__data_loc & XIP_OFFSET_MASK))
> +#define LOAD_OFFSET (KERNEL_LINK_ADDR + _sdata - __data_loc)
>   
>   	_sdata = .;			/* Start of data section */
>   	_data = .;

When the above comment is fixed, you can add:

Reviewed-by: Alexandre Ghiti <alexghiti@rivosinc.com>

And many thanks for this big cleanup.

Alex


