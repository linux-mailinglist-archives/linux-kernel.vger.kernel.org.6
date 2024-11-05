Return-Path: <linux-kernel+bounces-396515-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 554C09BCE39
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 14:44:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0BBC51F22CCF
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 13:44:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 125B01D6DA3;
	Tue,  5 Nov 2024 13:44:33 +0000 (UTC)
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B771F1D1E8A
	for <linux-kernel@vger.kernel.org>; Tue,  5 Nov 2024 13:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730814272; cv=none; b=ZzNT2qgRCF2vTn9HZMv8ahEsEnnR9u/PktQDDK5/LWRyvruACjBcOuCQkjzyfhnsiaTncy5wlxpXt1QxkK7AowBJapmS4F+leuYfL6oobrqR9ACtcKTQJ5D2T+HQj0C1SP2nt94g7Bja9TxUo4Q3tQyP/dWQyqP5PH7Q7qCPQ/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730814272; c=relaxed/simple;
	bh=98U9Z2AD0kDN3G6/Ym86C6dNCyUZfXoy+4DqYRUfv6c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=q/ngieq5yJYlrjpJ+w7byglxFPF9RLwMapc+TZXPlvbLgcGR2fEeVws6VLfOVPBvRaI/29AZcb30cVgRWM/pLmptVwgsMJpc3agzKCuekjQ4h4j5A/CEe3V7gBrn+HFnVUOp6hSlRnqYMyXoAF86D0EMPWcnryXcI988cyEWGRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr; spf=pass smtp.mailfrom=ghiti.fr; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ghiti.fr
Received: by mail.gandi.net (Postfix) with ESMTPSA id 21972240006;
	Tue,  5 Nov 2024 13:44:25 +0000 (UTC)
Message-ID: <5dba5a49-91e5-4988-9018-63b146b5e26c@ghiti.fr>
Date: Tue, 5 Nov 2024 14:44:25 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/9] riscv: mm: Log potential KASAN shadow alias
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
 <20241022015913.3524425-6-samuel.holland@sifive.com>
From: Alexandre Ghiti <alex@ghiti.fr>
In-Reply-To: <20241022015913.3524425-6-samuel.holland@sifive.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-GND-Sasl: alex@ghiti.fr

Hi Samuel,

On 22/10/2024 03:57, Samuel Holland wrote:
> When KASAN is enabled, shadow memory is allocated and mapped for all
> legitimate kernel addresses, but not for the entire address space. As a
> result, the kernel can fault when accessing a shadow address computed
> from a bogus pointer. This can be confusing, because the shadow address
> computed for (e.g.) NULL looks nothing like a NULL pointer. To assist
> debugging, if the faulting address might be the result of a KASAN shadow
> memory address computation, report the range of original memory
> addresses that would map to the faulting address.
>
> Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
> ---
>
> Changes in v2:
>   - New patch for v2
>
>   arch/riscv/mm/fault.c | 3 +++
>   1 file changed, 3 insertions(+)
>
> diff --git a/arch/riscv/mm/fault.c b/arch/riscv/mm/fault.c
> index a9f2b4af8f3f..dae1131221b7 100644
> --- a/arch/riscv/mm/fault.c
> +++ b/arch/riscv/mm/fault.c
> @@ -8,6 +8,7 @@
>   
>   
>   #include <linux/mm.h>
> +#include <linux/kasan.h>
>   #include <linux/kernel.h>
>   #include <linux/interrupt.h>
>   #include <linux/perf_event.h>
> @@ -30,6 +31,8 @@ static void die_kernel_fault(const char *msg, unsigned long addr,
>   	pr_alert("Unable to handle kernel %s at virtual address " REG_FMT "\n", msg,
>   		addr);
>   
> +	kasan_non_canonical_hook(addr);
> +
>   	bust_spinlocks(0);
>   	die(regs, "Oops");
>   	make_task_dead(SIGKILL);


That's nice, I used to do that by hand :)

Reviewed-by: Alexandre Ghiti <alexghiti@rivosinc.com>

Thanks,

Alex


