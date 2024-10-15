Return-Path: <linux-kernel+bounces-366360-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 95B4799F450
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 19:44:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 41B711F24C8C
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 17:44:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D25031FAEF2;
	Tue, 15 Oct 2024 17:44:06 +0000 (UTC)
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 823EB1F9ED1
	for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 17:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.235.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729014246; cv=none; b=pRp/vCuJPGoaJBmjAlvWNx66azrKMFhRQsWm7fFk3qyP4o7gMTT4L4/HZBfLrUoUT/YQokIW1spj3XQf2K4cWArxBB9AfXSXpKP4f4mZDKb7oTdZTkUCeKjf5ycxGlToptT8TkwUSwR7R20EE1ZPMmy1XzUfcB5rjIxcpULTs50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729014246; c=relaxed/simple;
	bh=LXn0moybR9RYzAbhFaw7+7cVE1/Bi/WVXUVrdQ+C2Ks=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=H840AkPjwtAerRAt88PU/stoUSkjURFdJdRsYWO9n7C3HTWvu5HvLNhCcYkXB59TuwEupRni7EZbMbhQ5D2ONMGXYkA0Azm8lO9V2iGmscYbPLglmaWILKZGTYkj5hCUSRrXP62NMPp4eYOvBsLLuAd1/hLyQJXE+3sdymjn3Bg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.235.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4XShKn2M7jz9sPd;
	Tue, 15 Oct 2024 19:43:57 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id TVYtcATzovDT; Tue, 15 Oct 2024 19:43:57 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4XShKn0mffz9rvV;
	Tue, 15 Oct 2024 19:43:57 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id C58078B770;
	Tue, 15 Oct 2024 19:43:56 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id Jsl9_4vQLh1r; Tue, 15 Oct 2024 19:43:56 +0200 (CEST)
Received: from [192.168.233.89] (unknown [192.168.233.89])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 5FFCA8B764;
	Tue, 15 Oct 2024 19:43:56 +0200 (CEST)
Message-ID: <e9595d8b-d1e2-4c6a-b097-6f4f08d29866@csgroup.eu>
Date: Tue, 15 Oct 2024 19:43:56 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/7] powerpc/entry: convert to common and generic entry
To: Luming Yu <luming.yu@shingroup.cn>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, mpe@ellerman.id.au, npiggin@gmail.com,
 jialong.yang@shingroup.cn, luming.yu@gmail.com
References: <88E2581B1D024E9A+20241012035621.1245-3-luming.yu@shingroup.cn>
Content-Language: fr-FR
From: Christophe Leroy <christophe.leroy@csgroup.eu>
In-Reply-To: <88E2581B1D024E9A+20241012035621.1245-3-luming.yu@shingroup.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 12/10/2024 à 05:56, Luming Yu a écrit :
> convert powerpc entry code in syscall and fault to use syscall_work
> and irqentry_state as well as common calls implemented in generic
> entry infrastructure.
> 
> Signed-off-by: Luming Yu <luming.yu@shingroup.cn>
> ---
>   arch/powerpc/Kconfig                   | 1 +
>   arch/powerpc/include/asm/hw_irq.h      | 5 +++++
>   arch/powerpc/include/asm/processor.h   | 6 ++++++
>   arch/powerpc/include/asm/syscall.h     | 5 +++++
>   arch/powerpc/include/asm/thread_info.h | 1 +
>   arch/powerpc/kernel/syscall.c          | 5 ++++-
>   arch/powerpc/mm/fault.c                | 3 +++
>   7 files changed, 25 insertions(+), 1 deletion(-)
> 

...

> diff --git a/arch/powerpc/kernel/syscall.c b/arch/powerpc/kernel/syscall.c
> index 77fedb190c93..e0338bd8d383 100644
> --- a/arch/powerpc/kernel/syscall.c
> +++ b/arch/powerpc/kernel/syscall.c
> @@ -3,6 +3,7 @@
>   #include <linux/compat.h>
>   #include <linux/context_tracking.h>
>   #include <linux/randomize_kstack.h>
> +#include <linux/entry-common.h>
>   
>   #include <asm/interrupt.h>
>   #include <asm/kup.h>
> @@ -131,7 +132,7 @@ notrace long system_call_exception(struct pt_regs *regs, unsigned long r0)
>   		 * and the test against NR_syscalls will fail and the return
>   		 * value to be used is in regs->gpr[3].
>   		 */
> -		r0 = do_syscall_trace_enter(regs);
> +		r0 = syscall_enter_from_user_mode(regs, r0);

Can you provide details on how this works ?

For instance, do_syscall_trace_enter() was calling do_seccomp().
do_seccomp() sets regs->r3 to -ENOSYS then calls __secure_computing().

Now you call syscall_enter_from_user_mode() instead which calls 
syscall_enter_from_user_mode_work() which calls syscall_trace_enter() 
which calls  __secure_computing() but without seting regs->r3 to -ENOSYS.

So what will be returned by the below return when 
syscall_enter_from_user_mode returns -1 ?

>   		if (unlikely(r0 >= NR_syscalls))
>   			return regs->gpr[3];
>   
> @@ -184,6 +185,8 @@ notrace long system_call_exception(struct pt_regs *regs, unsigned long r0)
>   	 * So the resulting 6 or 7 bits of entropy is seen in SP[9:4] or SP[9:3].
>   	 */
>   	choose_random_kstack_offset(mftb());
> +	/*common entry*/
> +	syscall_exit_to_user_mode(regs);
>   
>   	return ret;
>   }

