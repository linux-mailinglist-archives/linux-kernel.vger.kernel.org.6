Return-Path: <linux-kernel+bounces-190604-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AAA7A8D005C
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 14:47:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 63221282A63
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 12:47:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DBA215E5C1;
	Mon, 27 May 2024 12:47:10 +0000 (UTC)
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 682234D5A2
	for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 12:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716814029; cv=none; b=m9m8j2z50fbcMWP9n+TKBrtW7MELPteAKLxmQ2Ue57UR1yeJupRjILu5MRUdKhhJx13a5sOB3/YiS7zELJo0zxPe4iIwyPhVMOqbuGw2YQ2hhPAKcJo25RrolnohCYTz3TcdQqdH8Sfj+XUOVdE6xYdkRGohUCUvZK/iQd9ctx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716814029; c=relaxed/simple;
	bh=3SKw8SIMp10qp0a2/fAzeREhqPwTT1KOLPlqw1+LW04=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=pGZ8pnNryCFN4MvwXF/wGpTluQnVojUsoxuXLXrEDWs9SaRXQuBxNlpgJqQWzDadKccDdpE1BvHd23AhImhRrwCuZhASyHdfy23v94X0CPGHpK4nRBPU9CcrRi6IEnlLB/y9ZypfywU4MabERpT4CKUw+U/MpXCY4ovwEC6vU9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr; spf=pass smtp.mailfrom=ghiti.fr; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ghiti.fr
Received: by mail.gandi.net (Postfix) with ESMTPSA id 356CAE000A;
	Mon, 27 May 2024 12:47:05 +0000 (UTC)
Message-ID: <5f7e9b88-f70f-406e-9eb3-2619594ad4fd@ghiti.fr>
Date: Mon, 27 May 2024 14:47:04 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/7] riscv: drop the use of XIP_OFFSET in
 XIP_FIXUP_FLASH_OFFSET
Content-Language: en-US
To: Nam Cao <namcao@linutronix.de>, Paul Walmsley <paul.walmsley@sifive.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
References: <cover.1715286093.git.namcao@linutronix.de>
 <a49044c3833e40546f35dd1f821a683e6f4dfc1f.1715286093.git.namcao@linutronix.de>
From: Alexandre Ghiti <alex@ghiti.fr>
In-Reply-To: <a49044c3833e40546f35dd1f821a683e6f4dfc1f.1715286093.git.namcao@linutronix.de>
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
> using XIP_OFFSET in XIP_FIXUP_FLASH_OFFSET. Instead, use __data_loc and
> _sdata to do the same thing.
>
> While at it, also add a description for XIP_FIXUP_FLASH_OFFSET.
>
> Signed-off-by: Nam Cao <namcao@linutronix.de>
> ---
>   arch/riscv/include/asm/xip_fixup.h | 16 ++++++++++++----
>   1 file changed, 12 insertions(+), 4 deletions(-)
>
> diff --git a/arch/riscv/include/asm/xip_fixup.h b/arch/riscv/include/asm/xip_fixup.h
> index 9ed2cfae09e0..f3d56299bc22 100644
> --- a/arch/riscv/include/asm/xip_fixup.h
> +++ b/arch/riscv/include/asm/xip_fixup.h
> @@ -24,13 +24,21 @@
>   	sub \reg, \reg, t0
>   .endm
>   .macro XIP_FIXUP_FLASH_OFFSET reg
> +	/* In linker script, at the transition from read-only section to
> +	 * writable section, the VMA is increased while LMA remains the same.
> +	 * (See in linker script how _sdata, __data_loc and LOAD_OFFSET is
> +	 * changed)
> +	 *
> +	 * Consequently, early during boot before MMU is up, the generated code
> +	 * reads the "writable" section at wrong addresses, because VMA is used
> +	 * by compiler to generate code, but the data is located in Flash using
> +	 * LMA.
> +	 */
> +	la t0, _sdata
> +	sub \reg, \reg, t0
>   	la t0, __data_loc
> -	REG_L t1, _xip_phys_offset
> -	sub \reg, \reg, t1
>   	add \reg, \reg, t0
>   .endm
> -
> -_xip_phys_offset: .dword CONFIG_XIP_PHYS_ADDR + XIP_OFFSET
>   #else
>   .macro XIP_FIXUP_OFFSET reg
>   .endm


Reviewed-by: Alexandre Ghiti <alexghiti@rivosinc.com>

Thanks,

Alex


