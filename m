Return-Path: <linux-kernel+bounces-365177-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B465799DEA1
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 08:43:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E66611C21CC7
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 06:43:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1830318BBA0;
	Tue, 15 Oct 2024 06:42:43 +0000 (UTC)
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C380818A6C8
	for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 06:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.235.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728974562; cv=none; b=AyLPKx9EX1BNZ02obCfnNHBFGrtkraZwKSey9+VmS0RT7KxE95bzEGxaBxs4tv6T9uarq+xEpNk6YJAFjHecWbZN0tZ437SNNHFuTQVi8l6Gyihd/39n3z/htgx2PLyFe0H/7M3tmqGDEe/3HkzdfgrwPIU5Wqwn31tD/wNHbJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728974562; c=relaxed/simple;
	bh=RQ3UyLFKEpSueZRnqXfIA5cM74Y6S4ZFTS8UMQ8gEnI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Vh4hKyGK8UoR83WgNYWwtTwr4QIzmZgLZ/RTNblJVCLvbXTulBxirYWJX0SLlSYMPSgrLPSF9Jy3cUZnKZEdGIsRdRyT6Zq9n2fJbHob1oXYaQG+NEZluYDsiQPNCN1P6VDR4qixHKo9AKA85dIwjlG3y/enyV9svCcL0tXkWak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.235.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4XSPfk3bvFz9sPd;
	Tue, 15 Oct 2024 08:42:38 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id jWUMtT-TFO-Y; Tue, 15 Oct 2024 08:42:38 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4XSPfk2bjlz9rvV;
	Tue, 15 Oct 2024 08:42:38 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 456068B766;
	Tue, 15 Oct 2024 08:42:38 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id haU307l0a_y8; Tue, 15 Oct 2024 08:42:38 +0200 (CEST)
Received: from [192.168.233.13] (unknown [192.168.233.13])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 6D1568B764;
	Tue, 15 Oct 2024 08:42:37 +0200 (CEST)
Message-ID: <660a2cf7-24f9-4558-87df-5e4c13362380@csgroup.eu>
Date: Tue, 15 Oct 2024 08:42:36 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC RESEND v2 02/13] powerpc: mm: Fix kfence page fault
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
References: <cover.1728954719.git.ritesh.list@gmail.com>
 <6bf523aa03e72d701d24aca49b51864331eed2d5.1728954719.git.ritesh.list@gmail.com>
Content-Language: fr-FR
From: Christophe Leroy <christophe.leroy@csgroup.eu>
In-Reply-To: <6bf523aa03e72d701d24aca49b51864331eed2d5.1728954719.git.ritesh.list@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 15/10/2024 à 03:33, Ritesh Harjani (IBM) a écrit :
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
> Guessing the fix should go back to when we first got kfence on PPC32.
> 
> Fixes: 90cbac0e995d ("powerpc: Enable KFENCE for PPC32")
> Reported-by: Disha Goel <disgoel@linux.ibm.com>
> Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
> ---
>   arch/powerpc/mm/fault.c | 10 +++++++++-
>   1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/powerpc/mm/fault.c b/arch/powerpc/mm/fault.c
> index 81c77ddce2e3..fa825198f29f 100644
> --- a/arch/powerpc/mm/fault.c
> +++ b/arch/powerpc/mm/fault.c
> @@ -439,9 +439,17 @@ static int ___do_page_fault(struct pt_regs *regs, unsigned long address,
>   	/*
>   	 * The kernel should never take an execute fault nor should it
>   	 * take a page fault to a kernel address or a page fault to a user
> -	 * address outside of dedicated places
> +	 * address outside of dedicated places.
> +	 *
> +	 * Rather than kfence reporting false negatives, let the fixup table
> +	 * handler handle the page fault by returning SIGSEGV, if the fault
> +	 * has come from functions like copy_from_kernel_nofault().
>   	 */
>   	if (unlikely(!is_user && bad_kernel_fault(regs, error_code, address, is_write))) {
> +
> +		if (search_exception_tables(instruction_pointer(regs)))
> +			return SIGSEGV;

This is a heavy operation. It should at least be done only when KFENCE 
is built-in.

kfence_handle_page_fault() bails out immediately when 
is_kfence_address() returns false, and is_kfence_address() returns 
always false when KFENCE is not built-in.

So you could check that before calling the heavy weight 
search_exception_tables().

		if (is_kfence_address(address) &&
		    !search_exception_tables(instruction_pointer(regs)) &&
		    kfence_handle_page_fault(address, is_write, regs))
			return 0;



 > +			return SIGSEGV;

> +
>   		if (kfence_handle_page_fault(address, is_write, regs))
>   			return 0;
>   

