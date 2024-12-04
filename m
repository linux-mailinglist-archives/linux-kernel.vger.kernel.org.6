Return-Path: <linux-kernel+bounces-430621-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EBC59E33A0
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 07:44:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 43C90283F3E
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 06:44:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AC78188580;
	Wed,  4 Dec 2024 06:44:48 +0000 (UTC)
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0689B2D7BF
	for <linux-kernel@vger.kernel.org>; Wed,  4 Dec 2024 06:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.235.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733294687; cv=none; b=H5NE8QG3CDFYXqZ4RbkmTO5A4MIRynq2EV4nFDU6MX6oPodanv9quVRsrGMi1q13SoRh0zz5C3AicJzoTRjmCetxbUdXdGbjTkCsbIvFwAeNXIawU18LbvY8drDZBIE78ImoCLKYMyhih9LjWc0aZXATZ6brqCHDXwcja0ffSEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733294687; c=relaxed/simple;
	bh=HPM/Uki/6lMXfPJcUt0lBMNmIZ9ZJggZFT/DJnaRK68=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Kb9SFPstti9Cao2Wu674lLz6YViy//vqYDrM0G8utVJIHH63HoDz/2KAgrS5+m5RGycGfR9ZGFOT/hqCiOJR1vFVGmuXA575jhUHEy03udQY0Uo08tbgAdQsrigAXXwNhShkDZeHvoAZQUToEV9fXWuNc08ZUDDHOlonLUEZveo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.235.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4Y37L348bYz9stF;
	Wed,  4 Dec 2024 07:44:43 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 1jQrAaaTRKQc; Wed,  4 Dec 2024 07:44:43 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4Y37L32vTfz9stD;
	Wed,  4 Dec 2024 07:44:43 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 47A838B767;
	Wed,  4 Dec 2024 07:44:43 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id TT-qyXS56Ygr; Wed,  4 Dec 2024 07:44:43 +0100 (CET)
Received: from [10.25.209.139] (unknown [10.25.209.139])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 160608B763;
	Wed,  4 Dec 2024 07:44:43 +0100 (CET)
Message-ID: <17b2588e-cf5e-43bd-8453-e6c2e1fef660@csgroup.eu>
Date: Wed, 4 Dec 2024 07:44:42 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] powerpc: print right preemption model in die
To: Shrikanth Hegde <sshegde@linux.ibm.com>, mpe@ellerman.id.au,
 linuxppc-dev@lists.ozlabs.org
Cc: npiggin@gmail.com, maddy@linux.ibm.com, bigeasy@linutronix.de,
 ankur.a.arora@oracle.com, linux-kernel@vger.kernel.org,
 mark.rutland@arm.com, vschneid@redhat.com, peterz@infradead.org
References: <20241125042212.1522315-1-sshegde@linux.ibm.com>
 <20241125042212.1522315-4-sshegde@linux.ibm.com>
Content-Language: fr-FR
From: Christophe Leroy <christophe.leroy@csgroup.eu>
In-Reply-To: <20241125042212.1522315-4-sshegde@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 25/11/2024 à 05:22, Shrikanth Hegde a écrit :
> Preemption models can change at runtime with dynamic preemption in
> place. So need to use the right methods instead of relying on
> CONFIG_PREEMPT to decide whether its full preemption or not.

Then this patch should go _before_ activating dynamic preemption.

But at the end, with the change to avoid the full copy of preempt.h, at 
the end the amount of changes is small and all three patches can be 
squashed into a single one.

> 
> While there, fix it to print preemption model correctly.
> 
> Signed-off-by: Shrikanth Hegde <sshegde@linux.ibm.com>
> ---
>   arch/powerpc/kernel/traps.c | 6 +++++-
>   1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/powerpc/kernel/traps.c b/arch/powerpc/kernel/traps.c
> index edf5cabe5dfd..2556fa8ec019 100644
> --- a/arch/powerpc/kernel/traps.c
> +++ b/arch/powerpc/kernel/traps.c
> @@ -266,7 +266,11 @@ static int __die(const char *str, struct pt_regs *regs, long err)
>   	printk("%s PAGE_SIZE=%luK%s%s%s%s%s%s %s\n",
>   	       IS_ENABLED(CONFIG_CPU_LITTLE_ENDIAN) ? "LE" : "BE",
>   	       PAGE_SIZE / 1024, get_mmu_str(),
> -	       IS_ENABLED(CONFIG_PREEMPT) ? " PREEMPT" : "",
> +	       preempt_model_none()      ? "none" :
> +	       preempt_model_voluntary() ? "voluntary" :
> +	       preempt_model_full()      ? "full" :
> +	       preempt_model_lazy()      ? "lazy" :
> +	       "",
>   	       IS_ENABLED(CONFIG_SMP) ? " SMP" : "",
>   	       IS_ENABLED(CONFIG_SMP) ? (" NR_CPUS=" __stringify(NR_CPUS)) : "",
>   	       debug_pagealloc_enabled() ? " DEBUG_PAGEALLOC" : "",


