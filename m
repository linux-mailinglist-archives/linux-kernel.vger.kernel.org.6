Return-Path: <linux-kernel+bounces-219194-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 085C090CB24
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 14:08:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8BFDD288F22
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 12:08:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75A4713C683;
	Tue, 18 Jun 2024 12:06:47 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6820913C3F7
	for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 12:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718712407; cv=none; b=ETbQokMiV5DmiWoYtrjjEMAllbjooz+5skqvZiXvm6/9yk33xeq1cbJgczkcPC0Xe2ROLuR8R8DKZxjpShPalE7kXHTtwWKZ1NuNKufQb27p1Xg8CKCL65EJAxG8oZl0bkDK92ky8eOxY65F+oemRZdPMJBI1ZqzNWnoJ+x4+Jk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718712407; c=relaxed/simple;
	bh=sCB6qFIifA6LuNZmQUEQyn6WAFJeJoazZVJMMDKYjGk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K4m/guJ37k7Z9yDxuZcYJ4JPLf3jg+/vyojimxapqGtE+FOZIZ9ochyZawsdz3SRMq1OqjKJiQ978h9PwSxoTZMwm9P3M9Ha/Tamn4QpO5i9Z711SVwY4aAzN8IvQIAh7mpKrfoJp0RJcKcJiLe0iDPZq+NMKRZWTdgkvaoW8Iw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5AEF0DA7;
	Tue, 18 Jun 2024 05:07:08 -0700 (PDT)
Received: from J2N7QTR9R3 (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 551573F64C;
	Tue, 18 Jun 2024 05:06:42 -0700 (PDT)
Date: Tue, 18 Jun 2024 13:06:39 +0100
From: Mark Rutland <mark.rutland@arm.com>
To: Xu Lu <luxu.kernel@bytedance.com>
Cc: alex@ghiti.fr, paul.walmsley@sifive.com, palmer@dabbelt.com,
	aou@eecs.berkeley.edu, linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] riscv: Fix local irq restore when flags indicates irq
 disabled
Message-ID: <ZnF4T51VPhJ4C5su@J2N7QTR9R3>
References: <20240618103803.40578-1-luxu.kernel@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240618103803.40578-1-luxu.kernel@bytedance.com>

On Tue, Jun 18, 2024 at 06:38:03PM +0800, Xu Lu wrote:
> When arch_local_irq_restore() is called with flags indicating irqs
> disabled, we need to clear SR_IE bit in CSR_STATUS, whereas current
> implementation based on csr_set() function only sets SR_IE bit of
> CSR_STATUS when SR_IE bit of flags is high and does nothing when
> SR_IE bit of flags is low.

That shouldn't matter; arch_local_irq_restore() should *never* be called
from a context with IRQs enabled, and so arch_local_irq_restore() never
needs to disable IRQs. Either it enables IRQs or it leaves IRQs
disabled, but it never needs to explicitly disable IRQs.

See CONFIG_DEBUG_IRQFLAGS and the commit that introduced it:

  997acaf6b4b59c6a ("lockdep: report broken irq restoration")

I don't believe this patch is necessary.

Mark.

> 
> This commit supplies csr clear operation when calling irq restore
> function with flags indicating irq disabled.
> 
> Fixes: 6d60b6ee0c97 ("RISC-V: Device, timer, IRQs, and the SBI")
> Signed-off-by: Xu Lu <luxu.kernel@bytedance.com>
> ---
>  arch/riscv/include/asm/irqflags.h | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/riscv/include/asm/irqflags.h b/arch/riscv/include/asm/irqflags.h
> index 6fd8cbfcfcc7..f3aad7bfadb7 100644
> --- a/arch/riscv/include/asm/irqflags.h
> +++ b/arch/riscv/include/asm/irqflags.h
> @@ -48,7 +48,10 @@ static inline int arch_irqs_disabled(void)
>  /* set interrupt enabled status */
>  static inline void arch_local_irq_restore(unsigned long flags)
>  {
> -	csr_set(CSR_STATUS, flags & SR_IE);
> +	if (flags & SR_IE)
> +		csr_set(CSR_STATUS, SR_IE);
> +	else
> +		csr_clear(CSR_STATUS, SR_IE);
>  }
>  
>  #endif /* _ASM_RISCV_IRQFLAGS_H */
> -- 
> 2.20.1
> 
> 

