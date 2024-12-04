Return-Path: <linux-kernel+bounces-430764-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EA659E353D
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 09:27:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E860F281218
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 08:27:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1C9C192D6C;
	Wed,  4 Dec 2024 08:27:08 +0000 (UTC)
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE97D136338
	for <linux-kernel@vger.kernel.org>; Wed,  4 Dec 2024 08:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733300828; cv=none; b=lHzXFl4anCbDTQD+PtFrxTMdm0D2q9bsUCM8fuoG6lnmNJGloDX49+lRW744kyRieG6KpgRPBKASYmDW8XUTGukhtvxcYuBytGTBx4Wo+A8iBWwdE5iKyZayqOqmrwOTZtn6zFFu2eL/sZjYO+z969L2wOcTnfxXFjDEWfWoUHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733300828; c=relaxed/simple;
	bh=fnGAHa77/FVpNqcbKWKxJyAlq8e4WYcADYH7Wq24Nmw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qJ/7lDN4QH9gWJTZnmzL4/AFjB2B2kU+QBc7EZzV7K45krdp/fbnBdxgUAdUIPf1U3vnIhGWgZYLgjJqK19VIo8HV7MVASIAqcHCpVE3fF8ice4gBiRCxjzDxAqI7mShhmIUjEJ9lr6zBQ/1amsSo8NxPl/jGtzE0sOjnBvAaFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr; spf=pass smtp.mailfrom=ghiti.fr; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ghiti.fr
Received: by mail.gandi.net (Postfix) with ESMTPSA id 5A3DC60007;
	Wed,  4 Dec 2024 08:27:01 +0000 (UTC)
Message-ID: <7e93d7a9-caa8-40c4-997a-d96ad94dbe94@ghiti.fr>
Date: Wed, 4 Dec 2024 09:27:00 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND PATCH] riscv: Fixup boot failure when
 CONFIG_DEBUG_RT_MUTEXES=y
Content-Language: en-US
To: guoren@kernel.org, paul.walmsley@sifive.com, palmer@dabbelt.com,
 bjorn@rivosinc.com, conor@kernel.org, leobras@redhat.com,
 peterz@infradead.org, parri.andrea@gmail.com, will@kernel.org,
 longman@redhat.com, boqun.feng@gmail.com, arnd@arndb.de,
 alexghiti@rivosinc.com
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
 Guo Ren <guoren@linux.alibaba.com>
References: <20241130153310.3349484-1-guoren@kernel.org>
From: Alexandre Ghiti <alex@ghiti.fr>
In-Reply-To: <20241130153310.3349484-1-guoren@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-GND-Sasl: alex@ghiti.fr

Hi Guo,

On 30/11/2024 16:33, guoren@kernel.org wrote:
> From: Guo Ren <guoren@linux.alibaba.com>
>
> When CONFIG_DEBUG_RT_MUTEXES=y, mutex_lock->rt_mutex_try_acquire
> would change from rt_mutex_cmpxchg_acquire to
> rt_mutex_slowtrylock():
> 	raw_spin_lock_irqsave(&lock->wait_lock, flags);
> 	ret = __rt_mutex_slowtrylock(lock);
> 	raw_spin_unlock_irqrestore(&lock->wait_lock, flags);
>
> Because queued_spin_#ops to ticket_#ops is changed one by one by
> jump_label, raw_spin_lock/unlock would cause a deadlock during the
> changing.
>
> That means in arch/riscv/kernel/jump_label.c:
> 1.
> arch_jump_label_transform_queue() ->
> mutex_lock(&text_mutex); +-> raw_spin_lock  -> queued_spin_lock
> 			 |-> raw_spin_unlock -> queued_spin_unlock
> patch_insn_write -> change the raw_spin_lock to ticket_lock
> mutex_unlock(&text_mutex);
> ...
>
> 2. /* Dirty the lock value */
> arch_jump_label_transform_queue() ->
> mutex_lock(&text_mutex); +-> raw_spin_lock -> *ticket_lock*
>                           |-> raw_spin_unlock -> *queued_spin_unlock*
> 			  /* BUG: ticket_lock with queued_spin_unlock */
> patch_insn_write  ->  change the raw_spin_unlock to ticket_unlock
> mutex_unlock(&text_mutex);
> ...
>
> 3. /* Dead lock */
> arch_jump_label_transform_queue() ->
> mutex_lock(&text_mutex); +-> raw_spin_lock -> ticket_lock /* deadlock! */
>                           |-> raw_spin_unlock -> ticket_unlock
> patch_insn_write -> change other raw_spin_#op -> ticket_#op
> mutex_unlock(&text_mutex);
>
> So, the solution is to disable mutex usage of
> arch_jump_label_transform_queue() during early_boot_irqs_disabled, just
> like we have done for stop_machine.
>
> Reported-by: Conor Dooley <conor@kernel.org>
> Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> Signed-off-by: Guo Ren <guoren@kernel.org>
> Fixes: ab83647fadae ("riscv: Add qspinlock support")
> Link: https://lore.kernel.org/linux-riscv/CAJF2gTQwYTGinBmCSgVUoPv0_q4EPt_+WiyfUA1HViAKgUzxAg@mail.gmail.com/T/#mf488e6347817fca03bb93a7d34df33d8615b3775
> Cc: Palmer Dabbelt <palmer@dabbelt.com>
> Cc: Alexandre Ghiti <alexghiti@rivosinc.com>
> ---
>   arch/riscv/kernel/jump_label.c | 12 +++++++++---
>   1 file changed, 9 insertions(+), 3 deletions(-)
>
> diff --git a/arch/riscv/kernel/jump_label.c b/arch/riscv/kernel/jump_label.c
> index 6eee6f736f68..654ed159c830 100644
> --- a/arch/riscv/kernel/jump_label.c
> +++ b/arch/riscv/kernel/jump_label.c
> @@ -36,9 +36,15 @@ bool arch_jump_label_transform_queue(struct jump_entry *entry,
>   		insn = RISCV_INSN_NOP;
>   	}
>   
> -	mutex_lock(&text_mutex);
> -	patch_insn_write(addr, &insn, sizeof(insn));
> -	mutex_unlock(&text_mutex);
> +	if (early_boot_irqs_disabled) {
> +		riscv_patch_in_stop_machine = 1;
> +		patch_insn_write(addr, &insn, sizeof(insn));
> +		riscv_patch_in_stop_machine = 0;
> +	} else {
> +		mutex_lock(&text_mutex);
> +		patch_insn_write(addr, &insn, sizeof(insn));
> +		mutex_unlock(&text_mutex);
> +	}
>   
>   	return true;
>   }


Sorry for the late answer, I've been sick lately!

Thank you very much for looking into this and finding this not-so-bad 
solution! I remind everyone that this is a temporary solution until we 
can use an alternative instead of a static key.

You can add:

Reviewed-by: Alexandre Ghiti <alexghiti@rivosinc.com>
Tested-by: Alexandre Ghiti <alexghiti@rivosinc.com>

The revert is still on the table IMO, let's Palmer decide.

Thank you again Guo, really appreciate you took the time to find this 
solution!

Alex


