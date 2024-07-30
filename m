Return-Path: <linux-kernel+bounces-267499-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B948941226
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 14:44:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C5D8D280D48
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 12:44:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE8AC19FA82;
	Tue, 30 Jul 2024 12:43:16 +0000 (UTC)
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95C4A19FA77
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 12:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722343396; cv=none; b=D97yhXo2ZiFXYUmtToC7iTeSHnW6n3xpsJ+7kfizHIy+nndFZo1fY/L0Xo+ES7Ts+Pr9JR04JCyOaf4/cy4xNjBIZMouz1+oYVhvnJ/UZzlPLqvRF72pbjGTI7gPAjlFSUfKnPfupUou67dRSVT8Sy11dBJZ3DycTXg3If6mY4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722343396; c=relaxed/simple;
	bh=HIfo3bTVT8YWrcUgJqif/A3PM/nmsNvtVSnjCcVreWs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XHlzYoKr7lYhfkNM+9CbV3+yWDdYQNRmol2WvB0RT3nhRrbxev48rHEbg8SLd1k3LfDMqmdJZtbjprmMcEmQtHCjAFIdAtRTCKxfJSa7ocOWtXhxUI3B1XeB177POlAoQnBQo3c81a/fZOA+0rGXdHPe3xK73tkzd5Ux23LZChY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr; spf=pass smtp.mailfrom=ghiti.fr; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ghiti.fr
Received: by mail.gandi.net (Postfix) with ESMTPSA id BD4E9FF80D;
	Tue, 30 Jul 2024 12:43:02 +0000 (UTC)
Message-ID: <2f83c6a3-8db0-46f7-928a-8bf585e4a3b9@ghiti.fr>
Date: Tue, 30 Jul 2024 14:43:02 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC] riscv/mm: Add handling for VM_FAULT_SIGSEGV in
 mm_fault_error()
Content-Language: en-US
To: Zhe Qiao <qiaozhe@iscas.ac.cn>, paul.walmsley@sifive.com,
 palmer@dabbelt.com, aou@eecs.berkeley.edu, surenb@google.com,
 alexghiti@rivosinc.com, akpm@linux-foundation.org,
 wangkefeng.wang@huawei.com, willy@infradead.org
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20240730073822.27732-1-qiaozhe@iscas.ac.cn>
From: Alexandre Ghiti <alex@ghiti.fr>
In-Reply-To: <20240730073822.27732-1-qiaozhe@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-GND-Sasl: alex@ghiti.fr

Hi Zhe,

On 30/07/2024 09:38, Zhe Qiao wrote:
> Hello everyone, recently while learning about the Riscv architecture's
> handling of page fault exceptions in the Linux kernel, I found that
> there is no handling of VM_CAULT_SIGSEGV in mm_fault_erroneous (), but
> rather a BUG() is executed directly. Therefore, I simultaneously analyzed
> the processing procedures of arm64, powerpc, and sh architectures for
> this area and found that all three architectures have processing for
> VM_CAULT_SIGSEGV. Therefore, I added relevant processing methods for
> VM_CAULT_SIGSEGV on the riscv architecture.
>
> As a beginner, I am not sure if this processing method is correct and
> would like to hear the opinions of my seniors.


FWIW, we correctly handle "normal" segfaults (ie no VMA or permission 
access faults).

What we don't handle is handle_mm_fault() returning VM_FAULT_SIGSEGV, 
which can happen in different situations. For example, the BPF arena 
stuff implements a vma fault handler which can return VM_FAULT_SIGSEGV 
(see 
https://elixir.bootlin.com/linux/v6.10/source/kernel/bpf/arena.c#L273). 
In that case, we would BUG() instead of correctly killing the process.

So I agree that we need this patch. Can you just rephrase the commit 
log? I would say something similar (without the link) to what I have 
just said above. And can you also add the following Fixes tag?

Fixes: 07037db5d479 ("RISC-V: Paging and MMU")

Thanks,

Alex


>
> Signed-off-by: Zhe Qiao <qiaozhe@iscas.ac.cn>
> ---
>   arch/riscv/mm/fault.c | 17 +++++++++--------
>   1 file changed, 9 insertions(+), 8 deletions(-)
>
> diff --git a/arch/riscv/mm/fault.c b/arch/riscv/mm/fault.c
> index 5224f3733802..868163b904e2 100644
> --- a/arch/riscv/mm/fault.c
> +++ b/arch/riscv/mm/fault.c
> @@ -61,26 +61,27 @@ static inline void no_context(struct pt_regs *regs, unsigned long addr)
>   
>   static inline void mm_fault_error(struct pt_regs *regs, unsigned long addr, vm_fault_t fault)
>   {
> +	if (!user_mode(regs)) {
> +		no_context(regs, addr);
> +		return;
> +	}
> +
>   	if (fault & VM_FAULT_OOM) {
>   		/*
>   		 * We ran out of memory, call the OOM killer, and return the userspace
>   		 * (which will retry the fault, or kill us if we got oom-killed).
>   		 */
> -		if (!user_mode(regs)) {
> -			no_context(regs, addr);
> -			return;
> -		}
>   		pagefault_out_of_memory();
>   		return;
>   	} else if (fault & (VM_FAULT_SIGBUS | VM_FAULT_HWPOISON | VM_FAULT_HWPOISON_LARGE)) {
>   		/* Kernel mode? Handle exceptions or die */
> -		if (!user_mode(regs)) {
> -			no_context(regs, addr);
> -			return;
> -		}
>   		do_trap(regs, SIGBUS, BUS_ADRERR, addr);
>   		return;
> +	} else if (fault & VM_FAULT_SIGSEGV) {
> +		do_trap(regs, SIGSEGV, SEGV_MAPERR, addr);
> +		return;
>   	}
> +
>   	BUG();
>   }
>   

