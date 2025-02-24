Return-Path: <linux-kernel+bounces-529141-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 82D62A4205C
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 14:20:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1159116E0D8
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 13:20:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A1C3248864;
	Mon, 24 Feb 2025 13:20:06 +0000 (UTC)
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6762D204C19
	for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 13:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.235.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740403206; cv=none; b=bszsxR5ojCrGSxncDKO+bIbkTGXyESZ0JXfzuJCbdJRMPvGTRo/3hWzXAPv/Kj4pmJCrHiYpBwuaLyQCaesIAuOKhawiS3DlZ/n3+AdmGHz6TnZEHXlYa2wo9FXhJUBd/VAluRFZin2r6M2q6vda1drHPpXIndeafe1b2iGSpuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740403206; c=relaxed/simple;
	bh=YlfiDa4ehp8gAnXZClnAykMpirIwal++7MaRs1hu1ik=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=l+47h1pBiY74wNW3scRDZS7ltScpYJJliDVknOIuraO/ZkevyiGcjzOxiKU4KvdvNMBHEpWEvxLZ0LxHxbLTOyAk78sw8pGUFTzQJm/t1+U4udam/pTdhJ3ZeOnfy9JDMpnTl6JUkWl+fReJ4Tk1kOldNL5oEsJnbrQ6UUiqG7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.235.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4Z1gjd65vLz9sST;
	Mon, 24 Feb 2025 13:56:53 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 8FR8LrDFc0wQ; Mon, 24 Feb 2025 13:56:53 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4Z1gjd5FVWz9sSR;
	Mon, 24 Feb 2025 13:56:53 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 9D6D38B765;
	Mon, 24 Feb 2025 13:56:53 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id u3om1-aGR3l0; Mon, 24 Feb 2025 13:56:53 +0100 (CET)
Received: from [10.25.207.138] (unknown [10.25.207.138])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 6BB268B763;
	Mon, 24 Feb 2025 13:56:53 +0100 (CET)
Message-ID: <f872c2ef-4adc-4daa-aa12-769e3108abc8@csgroup.eu>
Date: Mon, 24 Feb 2025 13:56:53 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND PATCH] powerpc: mpic: Use str_enabled_disabled() helper
 function
To: Thorsten Blum <thorsten.blum@linux.dev>,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 Naveen N Rao <naveen@kernel.org>, =?UTF-8?Q?Ricardo_B=2E_Marli=C3=A8re?=
 <ricardo@marliere.net>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <20250219112053.3352-2-thorsten.blum@linux.dev>
Content-Language: fr-FR
From: Christophe Leroy <christophe.leroy@csgroup.eu>
In-Reply-To: <20250219112053.3352-2-thorsten.blum@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi,

Le 19/02/2025 à 12:20, Thorsten Blum a écrit :
> Remove hard-coded strings by using the str_enabled_disabled() helper
> function.
> 
> Use pr_debug() instead of printk(KERN_DEBUG) to silence a checkpatch
> warning.
> 
> Reviewed-by: Ricardo B. Marlière <ricardo@marliere.net>
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
> ---


When you resend a patch, please tell why here (below the ---) so that we 
know the reason.

At the time being I have several duplicated patches from you and I don't 
know what to do with them which one to keep and which one to drop.

The list is here:

https://patchwork.ozlabs.org/project/linuxppc-dev/list/?submitter=89400

>   arch/powerpc/sysdev/mpic.c | 7 ++++---
>   1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/powerpc/sysdev/mpic.c b/arch/powerpc/sysdev/mpic.c
> index d94cf36b0f65..25fc4ac91814 100644
> --- a/arch/powerpc/sysdev/mpic.c
> +++ b/arch/powerpc/sysdev/mpic.c
> @@ -27,6 +27,7 @@
>   #include <linux/spinlock.h>
>   #include <linux/pci.h>
>   #include <linux/slab.h>
> +#include <linux/string_choices.h>
>   #include <linux/syscore_ops.h>
>   #include <linux/ratelimit.h>
>   #include <linux/pgtable.h>
> @@ -474,9 +475,9 @@ static void __init mpic_scan_ht_msi(struct mpic *mpic, u8 __iomem *devbase,
>   		addr = addr | ((u64)readl(base + HT_MSI_ADDR_HI) << 32);
>   	}
>   
> -	printk(KERN_DEBUG "mpic:   - HT:%02x.%x %s MSI mapping found @ 0x%llx\n",
> -		PCI_SLOT(devfn), PCI_FUNC(devfn),
> -		flags & HT_MSI_FLAGS_ENABLE ? "enabled" : "disabled", addr);
> +	pr_debug("mpic:   - HT:%02x.%x %s MSI mapping found @ 0x%llx\n",
> +		 PCI_SLOT(devfn), PCI_FUNC(devfn),
> +		 str_enabled_disabled(flags & HT_MSI_FLAGS_ENABLE), addr);
>   
>   	if (!(flags & HT_MSI_FLAGS_ENABLE))
>   		writeb(flags | HT_MSI_FLAGS_ENABLE, base + HT_MSI_FLAGS);


