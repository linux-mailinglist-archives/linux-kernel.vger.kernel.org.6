Return-Path: <linux-kernel+bounces-446992-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F0A919F2BB6
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 09:24:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6CFAD18836A2
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 08:23:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2BD01FF7DC;
	Mon, 16 Dec 2024 08:23:51 +0000 (UTC)
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 788B51FF7BC
	for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 08:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734337431; cv=none; b=ANIVI+qpWK410ucKuTuTSGLGwEVjU882BXGAXo7XTjjOzPANKsM7SGbwJc7yEBUYS7NxoDTAKbxGG4amtolc3B0FZb4AcXObCq7wpvXZlsX+gUoz86N1tQBEZ1GCnSb49wTqQ5y4rILbLKohXkcOWfikRIjT4YEfCpaOXFxxbGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734337431; c=relaxed/simple;
	bh=7Z9tN2Oh4vFlQzMli/swJI1A95tgOe6Dq/1iDiyXa/Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SAFQqOUxlHLM4q0IkRrj4s5EDvZZUVedz7qGnBwkkyS4ab3HfesnDrsEO75/45EvD/lEECapMvLLoFvCuK6ybs6bfrL3JKk9UBZIWZPOzhMNCzvMNVmLRMxK7GvGRx2Xnl4Z/NG2C+nN/Fq2A4JoXpkcgQm/dKB3J6SCsHD+7qo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr; spf=pass smtp.mailfrom=ghiti.fr; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ghiti.fr
Received: by mail.gandi.net (Postfix) with ESMTPSA id 4EA1F240008;
	Mon, 16 Dec 2024 08:23:40 +0000 (UTC)
Message-ID: <4110cdab-7658-4820-a809-da326e4ad3e7@ghiti.fr>
Date: Mon, 16 Dec 2024 09:23:39 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] riscv: qspinlock: Fixup _Q_PENDING_LOOPS definition
To: guoren@kernel.org, paul.walmsley@sifive.com, palmer@dabbelt.com,
 bjorn@rivosinc.com, conor@kernel.org, leobras@redhat.com,
 peterz@infradead.org, parri.andrea@gmail.com, will@kernel.org,
 longman@redhat.com, boqun.feng@gmail.com, arnd@arndb.de,
 alexghiti@rivosinc.com
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
 Guo Ren <guoren@linux.alibaba.com>
References: <20241215135252.201983-1-guoren@kernel.org>
Content-Language: en-US
From: Alexandre Ghiti <alex@ghiti.fr>
In-Reply-To: <20241215135252.201983-1-guoren@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-GND-Sasl: alex@ghiti.fr

Hi Guo,

On 15/12/2024 14:52, guoren@kernel.org wrote:
> From: Guo Ren <guoren@linux.alibaba.com>
>
> When CONFIG_RISCV_QUEUED_SPINLOCKS=y, the _Q_PENDING_LOOPS
> definition is missing. Add the _Q_PENDING_LOOPS definition for
> pure qspinlock usage.
>
> Fixes: ab83647fadae ("riscv: Add qspinlock support")
> Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> Signed-off-by: Guo Ren <guoren@kernel.org>
> ---
>   arch/riscv/include/asm/spinlock.h | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/arch/riscv/include/asm/spinlock.h b/arch/riscv/include/asm/spinlock.h
> index e5121b89acea..52f11bfd0079 100644
> --- a/arch/riscv/include/asm/spinlock.h
> +++ b/arch/riscv/include/asm/spinlock.h
> @@ -3,8 +3,11 @@
>   #ifndef __ASM_RISCV_SPINLOCK_H
>   #define __ASM_RISCV_SPINLOCK_H
>   
> -#ifdef CONFIG_RISCV_COMBO_SPINLOCKS
> +#ifdef CONFIG_QUEUED_SPINLOCKS
>   #define _Q_PENDING_LOOPS	(1 << 9)
> +#endif
> +
> +#ifdef CONFIG_RISCV_COMBO_SPINLOCKS
>   
>   #define __no_arch_spinlock_redefine
>   #include <asm/ticket_spinlock.h>


Yep, good catch!

Reviewed-by: Alexandre Ghiti <alexghiti@rivosinc.com>

Thanks,

Alex


