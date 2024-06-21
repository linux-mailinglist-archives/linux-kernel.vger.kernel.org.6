Return-Path: <linux-kernel+bounces-224436-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 16627912261
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 12:28:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BE6101F21376
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 10:28:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63568171667;
	Fri, 21 Jun 2024 10:27:56 +0000 (UTC)
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B441117109B
	for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 10:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718965676; cv=none; b=AFEWOhSrS4ZrmgwY2h5TmdrZ9k89+UwZhVHveoRH/g3AL/PC5NPoVlEjYr+Z5gKFpM9CABJ3Q+qLp0Y+VlLLVQvBJb8KIe1yEJX3cCeKLj4RGrrBvg2VmQnwpFutgtiQzWRoABKEO+ctRwm56Qy3Zfzjbzs4508+XefNTeLZoOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718965676; c=relaxed/simple;
	bh=u0exqsZTqlqUCB1GjlBK9Hp2MlOA8PkMip+7OnJxA3c=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=QDW08n3WA08etUcOX6drxYKPb/NXV8cc1W8bcTRlxinkIR0hWzB8+uCaj3PwLIVZyVukEeRr/X/A0wa6Fu9eEOpyZPXfrsBlXYTKVu3xH4XtUO/exZja0uqyMaXIWqg2k97nJiiBSlRRK3UvvqqaT9mRZVDJCDfIblgZD6xVr1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr; spf=pass smtp.mailfrom=ghiti.fr; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ghiti.fr
Received: by mail.gandi.net (Postfix) with ESMTPSA id 65CC61C000E;
	Fri, 21 Jun 2024 10:27:45 +0000 (UTC)
Message-ID: <825ab2df-c040-4454-9db6-8d08bc3df592@ghiti.fr>
Date: Fri, 21 Jun 2024 12:27:43 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/8] riscv: don't export va_kernel_pa_offset in
 vmcoreinfo for XIP kernel
Content-Language: en-US
To: Nam Cao <namcao@linutronix.de>, Alexandre Ghiti <alexghiti@rivosinc.com>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
References: <cover.1717789719.git.namcao@linutronix.de>
 <8f8760d3f9a11af4ea0acbc247e4f49ff5d317e9.1717789719.git.namcao@linutronix.de>
From: Alexandre Ghiti <alex@ghiti.fr>
In-Reply-To: <8f8760d3f9a11af4ea0acbc247e4f49ff5d317e9.1717789719.git.namcao@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-GND-Sasl: alex@ghiti.fr

Hi Nam,

On 07/06/2024 22:22, Nam Cao wrote:
> The crash utility uses va_kernel_pa_offset to translate virtual addresses.
> This is incorrect in the case of XIP kernel, because va_kernel_pa_offset is
> not the virtual-physical address offset (yes, the name is misleading; this
> variable will be removed for XIP in a following commit).
>
> Stop exporting this variable for XIP kernel. The replacement is to be
> determined, note it as a TODO for now.
>
> Signed-off-by: Nam Cao <namcao@linutronix.de>
> ---
>   arch/riscv/kernel/vmcore_info.c | 7 +++++++
>   1 file changed, 7 insertions(+)
>
> diff --git a/arch/riscv/kernel/vmcore_info.c b/arch/riscv/kernel/vmcore_info.c
> index 6d7a22522d63..d5e448aa90e7 100644
> --- a/arch/riscv/kernel/vmcore_info.c
> +++ b/arch/riscv/kernel/vmcore_info.c
> @@ -19,6 +19,13 @@ void arch_crash_save_vmcoreinfo(void)
>   #endif
>   #endif
>   	vmcoreinfo_append_str("NUMBER(KERNEL_LINK_ADDR)=0x%lx\n", KERNEL_LINK_ADDR);
> +#ifdef CONFIG_XIP_KERNEL
> +	/* TODO: Communicate with crash-utility developers on the information to
> +	 * export. The XIP case is more complicated, because the virtual-physical
> +	 * address offset depends on whether the address is in ROM or in RAM.
> +	 */
> +#else
>   	vmcoreinfo_append_str("NUMBER(va_kernel_pa_offset)=0x%lx\n",
>   						kernel_map.va_kernel_pa_offset);
> +#endif
>   }


So that will regress crash on XIP kernels, but on the other hand this 
was wrong in the first place. And not sure anyone ever used crash on a 
XIP platform.

At least people will know that using va_kernel_pa_offset was wrong, so:

Reviewed-by: Alexandre Ghiti <alexghiti@rivosinc.com>

Thanks for all your changes in v2,

Alex


