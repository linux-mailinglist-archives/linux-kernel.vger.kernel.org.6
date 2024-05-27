Return-Path: <linux-kernel+bounces-190556-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A079E8CFFCA
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 14:17:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C45D287387
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 12:17:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0E811581E2;
	Mon, 27 May 2024 12:17:02 +0000 (UTC)
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D12913C3CA
	for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 12:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716812222; cv=none; b=pUQ4K5SPy6fHZ8x/ZeWfGjnlHfWwvRGbve2DfEX1z8kkapcETj0CDvQf8iLZEhYCn31p4MfRxWC845TYukdX2EYhv0SPhMWuy2AbbEgjA9PUOj2SygWoeqGWsDu5qRZBMnVEiwIuMBHSQSkkZ9dYlu+e8siXZAkN/PCw4Oci2c4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716812222; c=relaxed/simple;
	bh=4rmwT8fMBWaUg4ppZqnb51hiutGTSWM0Qo7P2tV1PV4=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=mZIYXvyjxqnvThF2AjGRBKGgxP29igGkJWYzhKpsocgkAK79oSs5D0TUQbxZhSBKyCyD6N1J0zM8qN+rFcqBL6aBwxndE8HhHLVucQPRzoE4RBLuAWi6tNzIponBu0f5O5MoJocSbVoQHDhW1Ui9ngVEWvR6QKy6+55mao2Cv5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr; spf=pass smtp.mailfrom=ghiti.fr; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ghiti.fr
Received: by mail.gandi.net (Postfix) with ESMTPSA id 3B5AA60011;
	Mon, 27 May 2024 12:16:57 +0000 (UTC)
Message-ID: <fb039f36-07ad-488b-a988-c149a68ef177@ghiti.fr>
Date: Mon, 27 May 2024 14:16:56 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/7] riscv: cleanup XIP_FIXUP macro
Content-Language: en-US
To: Nam Cao <namcao@linutronix.de>, Paul Walmsley <paul.walmsley@sifive.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
References: <cover.1715286093.git.namcao@linutronix.de>
 <19e63324d7a099f561c4a2e55f7df051bd5b8a6f.1715286093.git.namcao@linutronix.de>
From: Alexandre Ghiti <alex@ghiti.fr>
In-Reply-To: <19e63324d7a099f561c4a2e55f7df051bd5b8a6f.1715286093.git.namcao@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-GND-Sasl: alex@ghiti.fr

Hi Nam,

On 10/05/2024 08:28, Nam Cao wrote:
> The XIP_FIXUP macro is used to fix addresses early during boot before MMU:
> generated code "thinks" the data section is in ROM while it is actually in
> RAM. So this macro correct the addresses in the data section.
>
> This macro determines if the address needs to be fixed by checking if it is
> within the range startting of ROM address up to the size of 2 * XIP_OFFSET


s/startting/starting

And the sentence lacks the final dot.


>
> This means addresses within the .text section would incorrectly get fixed.


Yes, but XIP_FIXUP() should only be applied to data symbols so I believe 
this ^ is not relevant.


> Also if the kernel size if bigger than (2 * XIP_OFFSET), some addresses
> would not be fixed up.

s/the kernel size if/the kernel size is

>
> XIP kernel can still work if the above 2 cases do not happen. But this
> macro is obviously incorrect.
>
> Rewrite this macro to only fix up addresses within the data section.
>
> Signed-off-by: Nam Cao <namcao@linutronix.de>
> ---
>   arch/riscv/include/asm/pgtable.h | 11 +++++++----
>   1 file changed, 7 insertions(+), 4 deletions(-)
>
> diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
> index 58fd7b70b903..fbf342f4afee 100644
> --- a/arch/riscv/include/asm/pgtable.h
> +++ b/arch/riscv/include/asm/pgtable.h
> @@ -139,11 +139,14 @@
>   
>   #ifdef CONFIG_XIP_KERNEL
>   #define XIP_FIXUP(addr) ({							\
> +	extern char _sdata[], _start[], _end[];					\
> +	uintptr_t __rom_start_data = CONFIG_XIP_PHYS_ADDR			\
> +				+ (uintptr_t)&_sdata - (uintptr_t)&_start;	\
> +	uintptr_t __rom_end_data = CONFIG_XIP_PHYS_ADDR				\
> +				+ (uintptr_t)&_end - (uintptr_t)&_start;	\
>   	uintptr_t __a = (uintptr_t)(addr);					\
> -	(__a >= CONFIG_XIP_PHYS_ADDR && \
> -	 __a < CONFIG_XIP_PHYS_ADDR + XIP_OFFSET * 2) ?	\
> -		__a - CONFIG_XIP_PHYS_ADDR + CONFIG_PHYS_RAM_BASE - XIP_OFFSET :\
> -		__a;								\
> +	(__a >= __rom_start_data && __a < __rom_end_data) ?			\
> +		__a - __rom_start_data + CONFIG_PHYS_RAM_BASE :	__a;		\
>   	})
>   #else
>   #define XIP_FIXUP(addr)		(addr)


Reviewed-by: Alexandre Ghiti <alexghiti@rivosinc.com>

Thanks,

Alex


