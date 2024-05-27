Return-Path: <linux-kernel+bounces-190592-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 980EB8D002B
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 14:37:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C99091C22055
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 12:37:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AE2C15E5B6;
	Mon, 27 May 2024 12:37:20 +0000 (UTC)
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A573215E5AF
	for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 12:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716813439; cv=none; b=QiYITgrMsjOQDndk+Wye6BJI3Dq7ISJ/FDisKwvGYiTpaPaRk3+/QIeHg8B5o75KKqLHhV5kzKVJYgAPKhuI2RuCfiSDUC+0Y2KsCDL6xlTwDnll/OH9agR9qQRGHVdDk/sXkV+6WjCRkLMaSm3JGjZgs+x036T6aNvvlfDSUwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716813439; c=relaxed/simple;
	bh=7+3IF3MN92ZTyrUu1kSOkIobd/fuy1IKeSNBJml1ZsQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=XtHEiqE7PDAu4NITD8ac6tFU3ch2VkeXbJLOyazTeAtFcx/E083DrGzHqAVoYY0o+khNevFHpa0yYG/TNcRfgvZtqAXesgWEFgJ6jjp1kxai699/L0jyvWoyMcqWnRhMNdb3oOr7RJsYTh9RiSIHQUunZ2wvOfVT0LoEPgaQIas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr; spf=pass smtp.mailfrom=ghiti.fr; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ghiti.fr
Received: by mail.gandi.net (Postfix) with ESMTPSA id B34BAE0005;
	Mon, 27 May 2024 12:37:13 +0000 (UTC)
Message-ID: <0030930d-dbee-4a65-8ab9-5c96bd2aeeea@ghiti.fr>
Date: Mon, 27 May 2024 14:37:13 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/7] riscv: drop the use of XIP_OFFSET in XIP_FIXUP_OFFSET
Content-Language: en-US
To: Nam Cao <namcao@linutronix.de>, Paul Walmsley <paul.walmsley@sifive.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
References: <cover.1715286093.git.namcao@linutronix.de>
 <e18d9e8e3540098617d8f5b14859158a63b78594.1715286093.git.namcao@linutronix.de>
From: Alexandre Ghiti <alex@ghiti.fr>
In-Reply-To: <e18d9e8e3540098617d8f5b14859158a63b78594.1715286093.git.namcao@linutronix.de>
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
> As a preparation to remove this hard-coded macro XIP_OFFSET entirely, stop
> using XIP_OFFSET in XIP_FIXUP_OFFSET. Instead, use CONFIG_PHYS_RAM_BASE and
> _sdata to do the same thing.
>
> While at it, also add a description for XIP_FIXUP_OFFSET.
>
> Signed-off-by: Nam Cao <namcao@linutronix.de>
> ---
>   arch/riscv/include/asm/xip_fixup.h | 14 ++++++++++++--
>   1 file changed, 12 insertions(+), 2 deletions(-)
>
> diff --git a/arch/riscv/include/asm/xip_fixup.h b/arch/riscv/include/asm/xip_fixup.h
> index b65bf6306f69..9ed2cfae09e0 100644
> --- a/arch/riscv/include/asm/xip_fixup.h
> +++ b/arch/riscv/include/asm/xip_fixup.h
> @@ -9,8 +9,19 @@
>   
>   #ifdef CONFIG_XIP_KERNEL
>   .macro XIP_FIXUP_OFFSET reg
> -        REG_L t0, _xip_fixup
> +	/* Fix-up address in Flash into address in RAM early during boot before
> +	 * MMU is up. Because generated code "thinks" data is in Flash, but it
> +	 * is actually in RAM (actually data is also in Flash, but Flash is
> +	 * read-only, thus we need to use the data residing in RAM).
> +	 *
> +	 * The start of data in Flash is _sdata and the start of data in RAM is
> +	 * CONFIG_PHYS_RAM_BASE. So this fix-up essentially does this:
> +	 * reg += CONFIG_PHYS_RAM_BASE - _start
> +	 */
> +	li t0, CONFIG_PHYS_RAM_BASE
>           add \reg, \reg, t0
> +	la t0, _sdata
> +	sub \reg, \reg, t0
>   .endm
>   .macro XIP_FIXUP_FLASH_OFFSET reg
>   	la t0, __data_loc
> @@ -19,7 +30,6 @@
>   	add \reg, \reg, t0
>   .endm
>   
> -_xip_fixup: .dword CONFIG_PHYS_RAM_BASE - CONFIG_XIP_PHYS_ADDR - XIP_OFFSET
>   _xip_phys_offset: .dword CONFIG_XIP_PHYS_ADDR + XIP_OFFSET
>   #else
>   .macro XIP_FIXUP_OFFSET reg


Reviewed-by: Alexandre Ghiti <alexghiti@rivosinc.com>

Thanks,

Alex


