Return-Path: <linux-kernel+bounces-333106-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 59EE997C3D8
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 07:20:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E6BB11F23880
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 05:20:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F83920DC3;
	Thu, 19 Sep 2024 05:20:11 +0000 (UTC)
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 600E8224D2
	for <linux-kernel@vger.kernel.org>; Thu, 19 Sep 2024 05:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.235.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726723211; cv=none; b=M38ts0RA2MyH6J+xLpRDo3U2A7gKSWFfMjRBpFRi2TW4XHjbR/j/KDczgMpCOiSX37asQFfOLZi5X6jhdyF8V9ONNIWx3dFclwl36H5NErDjRVZF9BaDiPAtTt2DpPbNg8HqRI07RS9kHd7WWDZUp/thCkb3Fe47Ij65XOIpxO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726723211; c=relaxed/simple;
	bh=j56BP6wnv9jsTNVp5nYbTl0a2e3lwXyqRhCczBdXatc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ERSEYiVtvoNxvedIM1skfDCdcTnrafK6B3RECKzpshcEQo0VSZPbGTBijIrPweslBQlQbcrnh9uCtgDWhJAPcj90mEprSGMuHtC1ESVl3ID7hOxbMFZrC8Rn3h2QZFixNsfyl3l7hU0nO/DUkGqeV5wq46qEpehQ3JpTdwL2IIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.235.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4X8P3W2mtpz9tNv;
	Thu, 19 Sep 2024 07:20:07 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id AxoTRCMwyPDK; Thu, 19 Sep 2024 07:20:07 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4X8P3W1rdTz9tCB;
	Thu, 19 Sep 2024 07:20:07 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 2CD878B775;
	Thu, 19 Sep 2024 07:20:07 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id FP2B8C9gMap0; Thu, 19 Sep 2024 07:20:07 +0200 (CEST)
Received: from [192.168.234.38] (unknown [192.168.234.38])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 9794F8B763;
	Thu, 19 Sep 2024 07:20:06 +0200 (CEST)
Message-ID: <d9d8703a-df24-47e3-bd0d-2ff5a6eae184@csgroup.eu>
Date: Thu, 19 Sep 2024 07:20:04 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v2 03/13] book3s64/hash: Remove kfence support temporarily
To: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
 linuxppc-dev@lists.ozlabs.org
Cc: Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin
 <npiggin@gmail.com>, Madhavan Srinivasan <maddy@linux.ibm.com>,
 Hari Bathini <hbathini@linux.ibm.com>,
 "Aneesh Kumar K . V" <aneesh.kumar@kernel.org>,
 Donet Tom <donettom@linux.vnet.ibm.com>,
 Pavithra Prakash <pavrampu@linux.vnet.ibm.com>,
 Nirjhar Roy <nirjhar@linux.ibm.com>, LKML <linux-kernel@vger.kernel.org>,
 kasan-dev@googlegroups.com
References: <cover.1726571179.git.ritesh.list@gmail.com>
 <5f6809f3881d5929eedc33deac4847bf41a063b9.1726571179.git.ritesh.list@gmail.com>
Content-Language: fr-FR
From: Christophe Leroy <christophe.leroy@csgroup.eu>
In-Reply-To: <5f6809f3881d5929eedc33deac4847bf41a063b9.1726571179.git.ritesh.list@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 19/09/2024 à 04:56, Ritesh Harjani (IBM) a écrit :
> Kfence on book3s Hash on pseries is anyways broken. It fails to boot
> due to RMA size limitation. That is because, kfence with Hash uses
> debug_pagealloc infrastructure. debug_pagealloc allocates linear map
> for entire dram size instead of just kfence relevant objects.
> This means for 16TB of DRAM it will require (16TB >> PAGE_SHIFT)
> which is 256MB which is half of RMA region on P8.
> crash kernel reserves 256MB and we also need 2048 * 16KB * 3 for
> emergency stack and some more for paca allocations.
> That means there is not enough memory for reserving the full linear map
> in the RMA region, if the DRAM size is too big (>=16TB)
> (The issue is seen above 8TB with crash kernel 256 MB reservation).
> 
> Now Kfence does not require linear memory map for entire DRAM.
> It only needs for kfence objects. So this patch temporarily removes the
> kfence functionality since debug_pagealloc code needs some refactoring.
> We will bring in kfence on Hash support in later patches.
> 
> Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
> ---
>   arch/powerpc/include/asm/kfence.h     |  5 +++++
>   arch/powerpc/mm/book3s64/hash_utils.c | 16 +++++++++++-----
>   2 files changed, 16 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/powerpc/include/asm/kfence.h b/arch/powerpc/include/asm/kfence.h
> index fab124ada1c7..f3a9476a71b3 100644
> --- a/arch/powerpc/include/asm/kfence.h
> +++ b/arch/powerpc/include/asm/kfence.h
> @@ -10,6 +10,7 @@
>   
>   #include <linux/mm.h>
>   #include <asm/pgtable.h>
> +#include <asm/mmu.h>
>   
>   #ifdef CONFIG_PPC64_ELF_ABI_V1
>   #define ARCH_FUNC_PREFIX "."
> @@ -25,6 +26,10 @@ static inline void disable_kfence(void)
>   
>   static inline bool arch_kfence_init_pool(void)
>   {
> +#ifdef CONFIG_PPC64
> +	if (!radix_enabled())

No need for a #ifdef here, you can just do:

	if (IS_ENABLED(CONFIG_PPC64) && !radix_enabled())
		return false;


> +		return false;
> +#endif
>   	return !kfence_disabled;

But why not just set kfence_disabled to true by calling disable_kfence() 
from one of the powerpc init functions ?

>   }
>   #endif

