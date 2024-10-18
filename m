Return-Path: <linux-kernel+bounces-372155-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BE2709A4524
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 19:42:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5FC032855EA
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 17:42:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 812EA204026;
	Fri, 18 Oct 2024 17:40:26 +0000 (UTC)
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5420203710
	for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 17:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.235.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729273226; cv=none; b=iS4cNvpobHLDeL605qzKSZPnzSF6kSUyA9lqnRUXRsqifg0qrmN0/CM1HLsOk0riAkUpQsnVghxHBwyER9Elsiinax34FtR2jGOSLzPtiEk0/azdBDAe/VD8NJPL+gK+lLTGvTxdmnfJQJEzWkikG+WPFIBpHJkogCFu1ojoIzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729273226; c=relaxed/simple;
	bh=hbRI55698veypB4UxQ3Z9Im/ei0Q8/Xan8ZM7GDpVRU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iimShupGUd+rDG45M3Pms6C23sOrLS4a6NFlKZmyog1uibwzBICZIM2Cs9DbAKQZAj0DRLP8exKNFv+JCorzk88M7zk3bGJwnRh6r35TapdU9mBAybx0ejaX8yEQWVpNoqKvQsx0yI+EpMs+Q9qVeNzUQ32Vr+uhZivbHE8Oork=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.235.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4XVX675pLBz9sPd;
	Fri, 18 Oct 2024 19:40:15 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id A60ALosMKCjZ; Fri, 18 Oct 2024 19:40:15 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4XVX674tplz9rvV;
	Fri, 18 Oct 2024 19:40:15 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 97B0A8B779;
	Fri, 18 Oct 2024 19:40:15 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id ZaNkbIa7WNNO; Fri, 18 Oct 2024 19:40:15 +0200 (CEST)
Received: from [192.168.232.18] (unknown [192.168.232.18])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id CBDAC8B764;
	Fri, 18 Oct 2024 19:40:14 +0200 (CEST)
Message-ID: <0c81a6cc-2466-4932-805b-056d4e7dec2b@csgroup.eu>
Date: Fri, 18 Oct 2024 19:40:14 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 01/12] powerpc: mm/fault: Fix kfence page fault
 reporting
To: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
 linuxppc-dev@lists.ozlabs.org
Cc: kasan-dev@googlegroups.com, linux-mm@kvack.org,
 Marco Elver <elver@google.com>, Alexander Potapenko <glider@google.com>,
 Heiko Carstens <hca@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>,
 Nicholas Piggin <npiggin@gmail.com>,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Hari Bathini <hbathini@linux.ibm.com>,
 "Aneesh Kumar K . V" <aneesh.kumar@kernel.org>,
 Donet Tom <donettom@linux.vnet.ibm.com>,
 Pavithra Prakash <pavrampu@linux.vnet.ibm.com>,
 LKML <linux-kernel@vger.kernel.org>, Disha Goel <disgoel@linux.ibm.com>
References: <cover.1729271995.git.ritesh.list@gmail.com>
 <a411788081d50e3b136c6270471e35aba3dfafa3.1729271995.git.ritesh.list@gmail.com>
Content-Language: fr-FR
From: Christophe Leroy <christophe.leroy@csgroup.eu>
In-Reply-To: <a411788081d50e3b136c6270471e35aba3dfafa3.1729271995.git.ritesh.list@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 18/10/2024 à 19:29, Ritesh Harjani (IBM) a écrit :
> copy_from_kernel_nofault() can be called when doing read of /proc/kcore.
> /proc/kcore can have some unmapped kfence objects which when read via
> copy_from_kernel_nofault() can cause page faults. Since *_nofault()
> functions define their own fixup table for handling fault, use that
> instead of asking kfence to handle such faults.
> 
> Hence we search the exception tables for the nip which generated the
> fault. If there is an entry then we let the fixup table handler handle the
> page fault by returning an error from within ___do_page_fault().
> 
> This can be easily triggered if someone tries to do dd from /proc/kcore.
> dd if=/proc/kcore of=/dev/null bs=1M
> 
> <some example false negatives>
> ===============================
> BUG: KFENCE: invalid read in copy_from_kernel_nofault+0xb0/0x1c8
> Invalid read at 0x000000004f749d2e:
>   copy_from_kernel_nofault+0xb0/0x1c8
>   0xc0000000057f7950
>   read_kcore_iter+0x41c/0x9ac
>   proc_reg_read_iter+0xe4/0x16c
>   vfs_read+0x2e4/0x3b0
>   ksys_read+0x88/0x154
>   system_call_exception+0x124/0x340
>   system_call_common+0x160/0x2c4
> 
> BUG: KFENCE: use-after-free read in copy_from_kernel_nofault+0xb0/0x1c8
> Use-after-free read at 0x000000008fbb08ad (in kfence-#0):
>   copy_from_kernel_nofault+0xb0/0x1c8
>   0xc0000000057f7950
>   read_kcore_iter+0x41c/0x9ac
>   proc_reg_read_iter+0xe4/0x16c
>   vfs_read+0x2e4/0x3b0
>   ksys_read+0x88/0x154
>   system_call_exception+0x124/0x340
>   system_call_common+0x160/0x2c4
> 
> Fixes: 90cbac0e995d ("powerpc: Enable KFENCE for PPC32")
> Suggested-by: Christophe Leroy <christophe.leroy@csgroup.eu>

Reviewed-by: Christophe Leroy <christophe.leroy@csgroup.eu>

Nit below.

> Reported-by: Disha Goel <disgoel@linux.ibm.com>
> Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
> ---
>   arch/powerpc/mm/fault.c | 11 +++++++++--
>   1 file changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/powerpc/mm/fault.c b/arch/powerpc/mm/fault.c
> index 81c77ddce2e3..316f5162ffc4 100644
> --- a/arch/powerpc/mm/fault.c
> +++ b/arch/powerpc/mm/fault.c
> @@ -439,10 +439,17 @@ static int ___do_page_fault(struct pt_regs *regs, unsigned long address,
>   	/*
>   	 * The kernel should never take an execute fault nor should it
>   	 * take a page fault to a kernel address or a page fault to a user
> -	 * address outside of dedicated places
> +	 * address outside of dedicated places.
> +	 *
> +	 * Rather than kfence directly reporting false negatives, search whether
> +	 * the NIP belongs to the fixup table for cases where fault could come
> +	 * from functions like copy_from_kernel_nofault().
>   	 */
>   	if (unlikely(!is_user && bad_kernel_fault(regs, error_code, address, is_write))) {
> -		if (kfence_handle_page_fault(address, is_write, regs))
> +

Why do you need a blank line here ?

> +		if (is_kfence_address((void *)address) &&
> +		    !search_exception_tables(instruction_pointer(regs)) &&
> +		    kfence_handle_page_fault(address, is_write, regs))
>   			return 0;
> 
>   		return SIGSEGV;
> --
> 2.46.0
> 

