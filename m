Return-Path: <linux-kernel+bounces-268480-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E817D942523
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 05:42:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 179A51C20CC4
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 03:42:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B21E182BD;
	Wed, 31 Jul 2024 03:41:52 +0000 (UTC)
Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFDBF1C69A
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 03:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722397311; cv=none; b=lz09EhaTsFETuw2nRUFVHFArvILaX0DD+pcKg7+7NFPLxaSPhOe8C+pRxgEQuAqjcfohmhuANSQSqf8+SpTOKLjHyVxpfEfSCvwrRYzoz2iCmC2US1NUKFBejtT/ojCYBad/3cr1xRaV9a1qJ3om+Cm0+IIeS4DCwOH/2IEA37g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722397311; c=relaxed/simple;
	bh=SBLWkax+1dizY4f3fcemBbwS828IWfHrtdJ0GIjAsHc=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:Cc:
	 In-Reply-To:Content-Type; b=J/f/F2t7Z5Mq3+Cx2p0I1n9bN4uyHD/9CsD8/bWmcR+uj61SxffBtuvQzWQoVS0OuiSO2FR6oITLb0zqfnHKW52JThRhewymFPRMPND3OqkPjIMtbqMv8/tyD0HVMULx0GKOySrbputM7qKV+ngX7+JKZVfHXnDIZBfwrGRbeyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from [10.213.18.21] (unknown [210.73.53.31])
	by APP-01 (Coremail) with SMTP id qwCowACn7sJisqlmtb5bAg--.52659S2;
	Wed, 31 Jul 2024 11:41:27 +0800 (CST)
Message-ID: <f978c4b9-ef39-4b10-a980-deb23f4c26d3@iscas.ac.cn>
Date: Wed, 31 Jul 2024 11:41:21 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC] riscv/mm: Add handling for VM_FAULT_SIGSEGV in
 mm_fault_error()
To: Alexandre Ghiti <alex@ghiti.fr>, paul.walmsley@sifive.com,
 palmer@dabbelt.com, aou@eecs.berkeley.edu, surenb@google.com,
 alexghiti@rivosinc.com, akpm@linux-foundation.org,
 wangkefeng.wang@huawei.com, willy@infradead.org, qiaozhe@iscas.ac.cn
References: <20240730073822.27732-1-qiaozhe@iscas.ac.cn>
 <2f83c6a3-8db0-46f7-928a-8bf585e4a3b9@ghiti.fr>
From: Zhe Qiao <qiaozhe@iscas.ac.cn>
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
In-Reply-To: <2f83c6a3-8db0-46f7-928a-8bf585e4a3b9@ghiti.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qwCowACn7sJisqlmtb5bAg--.52659S2
X-Coremail-Antispam: 1UD129KBjvJXoWxWryrtr4fur4ktryUtF43Wrg_yoW5KFWrpF
	s5KrWUZr9Igrn3JryxJw1UXFy8C34rJ3WDXr10gFyjkr4UXr1jqr48Xr10gr1jyr48Jr1U
	Jr4UJr9xZFn8X37anT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9014x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWUuVWrJwAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AKxV
	W0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv
	7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r
	1j6r4UM4x0Y48IcVAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628v
	n2kIc2xKxwCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7x
	kEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E
	67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCw
	CI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1x
	MIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIda
	VFxhVjvjDU0xZFpf9x0JUqeHgUUUUU=
X-CM-SenderInfo: ptld061kh6x2xfdvhtffof0/

Hi everyone，

On 2024/7/30 20:43, Alexandre Ghiti wrote:
> Hi Zhe,
>
> On 30/07/2024 09:38, Zhe Qiao wrote:
>> Hello everyone, recently while learning about the Riscv architecture's
>> handling of page fault exceptions in the Linux kernel, I found that
>> there is no handling of VM_CAULT_SIGSEGV in mm_fault_erroneous (), but
>> rather a BUG() is executed directly. Therefore, I simultaneously analyzed
>> the processing procedures of arm64, powerpc, and sh architectures for
>> this area and found that all three architectures have processing for
>> VM_CAULT_SIGSEGV. Therefore, I added relevant processing methods for
>> VM_CAULT_SIGSEGV on the riscv architecture.
>>
>> As a beginner, I am not sure if this processing method is correct and
>> would like to hear the opinions of my seniors.
>
>
> FWIW, we correctly handle "normal" segfaults (ie no VMA or permission access faults).
>
> What we don't handle is handle_mm_fault() returning VM_FAULT_SIGSEGV, which can happen in different situations. For example, the BPF arena stuff implements a vma fault handler which can return VM_FAULT_SIGSEGV (see https://elixir.bootlin.com/linux/v6.10/source/kernel/bpf/arena.c#L273). In that case, we would BUG() instead of correctly killing the process.
>
> So I agree that we need this patch. Can you just rephrase the commit log? I would say something similar (without the link) to what I have just said above. And can you also add the following Fixes tag?
>
> Fixes: 07037db5d479 ("RISC-V: Paging and MMU")
>
> Thanks,
>
> Alex 


 Thinks for your reply. I have submitted a new patch. Connection address: https://lists.infradead.org/pipermail/linux-riscv/2024-July/058216.html


Thanks，


Zhe


>
>
>>
>> Signed-off-by: Zhe Qiao <qiaozhe@iscas.ac.cn>
>> ---
>>   arch/riscv/mm/fault.c | 17 +++++++++--------
>>   1 file changed, 9 insertions(+), 8 deletions(-)
>>
>> diff --git a/arch/riscv/mm/fault.c b/arch/riscv/mm/fault.c
>> index 5224f3733802..868163b904e2 100644
>> --- a/arch/riscv/mm/fault.c
>> +++ b/arch/riscv/mm/fault.c
>> @@ -61,26 +61,27 @@ static inline void no_context(struct pt_regs *regs, unsigned long addr)
>>     static inline void mm_fault_error(struct pt_regs *regs, unsigned long addr, vm_fault_t fault)
>>   {
>> +    if (!user_mode(regs)) {
>> +        no_context(regs, addr);
>> +        return;
>> +    }
>> +
>>       if (fault & VM_FAULT_OOM) {
>>           /*
>>            * We ran out of memory, call the OOM killer, and return the userspace
>>            * (which will retry the fault, or kill us if we got oom-killed).
>>            */
>> -        if (!user_mode(regs)) {
>> -            no_context(regs, addr);
>> -            return;
>> -        }
>>           pagefault_out_of_memory();
>>           return;
>>       } else if (fault & (VM_FAULT_SIGBUS | VM_FAULT_HWPOISON | VM_FAULT_HWPOISON_LARGE)) {
>>           /* Kernel mode? Handle exceptions or die */
>> -        if (!user_mode(regs)) {
>> -            no_context(regs, addr);
>> -            return;
>> -        }
>>           do_trap(regs, SIGBUS, BUS_ADRERR, addr);
>>           return;
>> +    } else if (fault & VM_FAULT_SIGSEGV) {
>> +        do_trap(regs, SIGSEGV, SEGV_MAPERR, addr);
>> +        return;
>>       }
>> +
>>       BUG();
>>   }
>>   


