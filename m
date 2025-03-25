Return-Path: <linux-kernel+bounces-575269-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AA35A6FAB6
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 13:07:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 833547A4D06
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 12:06:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAFAC2561DB;
	Tue, 25 Mar 2025 12:06:58 +0000 (UTC)
Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EA671A08CA
	for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 12:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742904418; cv=none; b=JKLGiYPY+tD/egQ5YXuo1SifFforcBY2AB1nCjEcQAx5FEL4ROTMSYRymODIH9qNfk2DKrrQ8W72vD0v7FFymgVp1Qrv/LiUDFqXHqfMEKQ0YA0vasUTdOFcVgFO9dwCt+2c+QmJ5ZWF2o9nPQgYW2UlD9PmRdpGMg+XbuaDLBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742904418; c=relaxed/simple;
	bh=eeApgnsfzdO7Ipf0r86niXAeDaTqVhIECgg1bpKEtmQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Br/g3ocYVH5b1w1t6lNNIuya/M+UabygEdvr1GEjZ4tyooTiyzbQGW2aI6EI9BTMoBTEDuPl+8RxHJZOOgRjpDUhXdOursF86IfQ/7UTaN9IklJqbHU2mB9kKFWrGZrqh9nhBBT+a/H3NjfLLl6nLTZaW9IcWPAzBXmhIOtnkXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4ZMTF66yD1z27hHh;
	Tue, 25 Mar 2025 20:07:22 +0800 (CST)
Received: from kwepemj200003.china.huawei.com (unknown [7.202.194.15])
	by mail.maildlp.com (Postfix) with ESMTPS id 6723C1A016C;
	Tue, 25 Mar 2025 20:06:45 +0800 (CST)
Received: from [10.67.120.170] (10.67.120.170) by
 kwepemj200003.china.huawei.com (7.202.194.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 25 Mar 2025 20:06:44 +0800
Message-ID: <704bf3e2-be54-4463-b59b-3c1b867e7df0@huawei.com>
Date: Tue, 25 Mar 2025 20:06:38 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7] arm64: kprobe: Enable OPTPROBE for arm64
To: Yicong Yang <yangyicong@huawei.com>
CC: <catalin.marinas@arm.com>, <will@kernel.org>,
	<naveen.n.rao@linux.ibm.com>, <anil.s.keshavamurthy@intel.com>,
	<davem@davemloft.net>, <mhiramat@kernel.org>, <linuxarm@huawei.com>,
	<yangyicong@hisilicon.com>, <linux-kernel@vger.kernel.org>,
	<fanghao11@huawei.com>, <prime.zeng@hisilicon.com>, <xuwei5@huawei.com>,
	<jonathan.cameron@huawei.com>, Barry Song <baohua@kernel.org>,
	<chris.zjh@huawei.com>
References: <20250216070044.1792872-1-xiaqinxin@huawei.com>
 <9ce3dfac-e6b2-1b2c-ae09-b0dd509d1581@huawei.com>
From: Qinxin Xia <xiaqinxin@huawei.com>
In-Reply-To: <9ce3dfac-e6b2-1b2c-ae09-b0dd509d1581@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemj200003.china.huawei.com (7.202.194.15)


在 2025/3/17 12:01, Yicong Yang 写道:
> On 2025/2/16 15:00, Qinxin Xia wrote:
>> This patch introduce optprobe for ARM64. In optprobe, probed
>> instruction is replaced by a branch instruction to trampoline.
>>
>> Performance of optprobe on Hip08 platform is test using kprobe
>> example module to analyze the latency of a kernel function,
>> and here is the result:
>>
>> common kprobe:
>> [280709.846380] do_empty returned 0 and took 1530 ns to execute
>> [280709.852057] do_empty returned 0 and took 550 ns to execute
>> [280709.857631] do_empty returned 0 and took 440 ns to execute
>> [280709.863215] do_empty returned 0 and took 380 ns to execute
>> [280709.868787] do_empty returned 0 and took 360 ns to execute
>> [280709.874362] do_empty returned 0 and took 340 ns to execute
>> [280709.879936] do_empty returned 0 and took 320 ns to execute
>> [280709.885505] do_empty returned 0 and took 300 ns to execute
>> [280709.891075] do_empty returned 0 and took 280 ns to execute
>> [280709.896646] do_empty returned 0 and took 290 ns to execute
>>
>> optprobe:
>> [ 2965.964572] do_empty returned 0 and took 90 ns to execute
>> [ 2965.969952] do_empty returned 0 and took 80 ns to execute
>> [ 2965.975332] do_empty returned 0 and took 70 ns to execute
>> [ 2965.980714] do_empty returned 0 and took 60 ns to execute
>> [ 2965.986128] do_empty returned 0 and took 80 ns to execute
>> [ 2965.991507] do_empty returned 0 and took 70 ns to execute
>> [ 2965.996884] do_empty returned 0 and took 70 ns to execute
>> [ 2966.002262] do_empty returned 0 and took 80 ns to execute
>> [ 2966.007642] do_empty returned 0 and took 70 ns to execute
>> [ 2966.013020] do_empty returned 0 and took 70 ns to execute
>> [ 2966.018400] do_empty returned 0 and took 70 ns to execute
> a chart to show the performance difference w/ and w/o the optprobe
> should be enough. The whole log seems too long.
Okay, in the next version, I'll simplify the commit information and 
display it in a chart.
>> As the result shows, optprobe can greatly reduce the latency. Big
>> latency of common kprobe will significantly impact the real result
>> while doing performance analysis or debugging performance issues
>> in lab, so optprobe is useful in this scenario.
>>
>> The trampoline design is illustrated in the following diagram.
>> Some commands will be replaced in arch_prepare_optimized_kprobe.
>> +------------------optprobe_template_entry---------------------+
>> |- Saving stacks and registers                                 |
>> |- Loading params for callback                                 |
>> +------------------optprobe_template_common--------------------+
>> |- nop                                                         |
>> |(replaced to the branch jump to optprobe_common)              |
>> |- Restore stacks and registers                                |
>> +-------------optprobe_template_restore_orig_insn--------------+
>> |- nop                                                         |
>> |(replaced to the kprobe->opcode)                              |
>> +----------------optprobe_template_restore_end-----------------+
>> |- nop                                                         |
>> |(replaced to next address of the probe point)                 |
>> +------------------optprobe_template_val-----------------------+
>> |- 0 (two 32-bit words)                                        |
>> |(replaced to params for optprobe_optimized_callback)          |
>> +-----------------optprobe_template_orig_addr------------------+
>> |- 0 (two 32-bit words)                                        |
>> |(replaced to origin probe point address)                      |
>> +-------------------optprobe_template_end----------------------+
>> |- nop                                                         |
> (eliminate the collision to the other kernel symbols)
>
> I'd prefer to also comment the illustration inline the code.
Okay, in the next version I'll just inline it in the code.
>
>> +--------------------------------------------------------------+
>>
>> Co-developed-by: Qi Liu <liuqi115@huawei.com>
>> Signed-off-by: Qi Liu <liuqi115@huawei.com>
>> Signed-off-by: Qinxin Xia <xiaqinxin@huawei.com>
>> ---
>>
>> Changes since V6:
>> - Address the comments from Masami, add design of optprobe trampoline in commit.
>> - Address the comments from Yicong, add nop in optprobe_template_end and move
>> optprobe_optimized_callback from framework to arch.
>> - Link: https://lore.kernel.org/lkml/20250103012753.66988-1-xiaqinxin@huawei.com/
>>
>> Changes since V5:
>> - Address the comments from Masami, saves stack frames to obtain correct backtrace
>> and make an array of usage flags to manage the reserved OPT_SLOT_SIZE.
>> - Link: https://lore.kernel.org/lkml/20211207124002.59877-1-liuqi115@huawei.com/
>>
>> Changes since V4:
>> - Address the comments from Masami, update arch_prepare_optimized_kprobe，
>> if the probe address is out of limit return -ERANGE.
>> - Link: https://lore.kernel.org/lkml/20210818073336.59678-1-liuqi115@huawei.com/
>>
>> Changes since V3:
>> - Address the comments from Masami, reduce the number of aarch64_insn_patch_text
>> in arch_optimize_kprobes() and arch_unoptimize_kprobes().
>> - Link: https://lore.kernel.org/lkml/20210810055330.18924-1-liuqi115@huawei.com/
>>
>> Changes since V2:
>> - Address the comments from Masami, prepare another writable buffer in
>> arch_prepare_optimized_kprobe()and build the trampoline code on it.
>> - Address the comments from Amit, move save_all_base_regs and
>> restore_all_base_regs to <asm/assembler.h>, as these two macros are reused
>> in optprobe.
>> - Link: https://lore.kernel.org/lkml/20210804060209.95817-1-liuqi115@huawei.com/
>>
>> Changes since V1:
>> - Address the comments from Masami, checks for all branch instructions, and
>> use aarch64_insn_patch_text_nosync() instead of aarch64_insn_patch_text()
>> in each probe.
>> - Link: https://lore.kernel.org/lkml/20210719122417.10355-1-liuqi115@huawei.com/
>> ---
>>   arch/arm64/Kconfig                            |   1 +
>>   arch/arm64/include/asm/kprobes.h              |  22 ++
>>   arch/arm64/kernel/probes/Makefile             |   2 +
>>   arch/arm64/kernel/probes/opt_arm64.c          | 244 ++++++++++++++++++
>>   .../arm64/kernel/probes/optprobe_trampoline.S | 113 ++++++++
>>   5 files changed, 382 insertions(+)
>>   create mode 100644 arch/arm64/kernel/probes/opt_arm64.c
>>   create mode 100644 arch/arm64/kernel/probes/optprobe_trampoline.S
>>
>> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
>> index 100570a048c5..f9c4e2625595 100644
>> --- a/arch/arm64/Kconfig
>> +++ b/arch/arm64/Kconfig
>> @@ -244,6 +244,7 @@ config ARM64
>>   	select HAVE_SYSCALL_TRACEPOINTS
>>   	select HAVE_KPROBES
>>   	select HAVE_KRETPROBES
>> +	select HAVE_OPTPROBES
>>   	select HAVE_GENERIC_VDSO
>>   	select HOTPLUG_CORE_SYNC_DEAD if HOTPLUG_CPU
>>   	select IRQ_DOMAIN
>> diff --git a/arch/arm64/include/asm/kprobes.h b/arch/arm64/include/asm/kprobes.h
>> index be7a3680dadf..bd4973bfb58d 100644
>> --- a/arch/arm64/include/asm/kprobes.h
>> +++ b/arch/arm64/include/asm/kprobes.h
>> @@ -37,6 +37,28 @@ struct kprobe_ctlblk {
>>   
>>   void arch_remove_kprobe(struct kprobe *);
>>   int kprobe_fault_handler(struct pt_regs *regs, unsigned int fsr);
>> +
>> +struct arch_optimized_insn {
>> +	kprobe_opcode_t orig_insn[1];
>> +	kprobe_opcode_t *trampoline;
>> +};
>> +
>> +#define MAX_OPTIMIZED_LENGTH	sizeof(kprobe_opcode_t)
>> +#define MAX_OPTINSN_SIZE                                                       \
>> +	((unsigned long)optprobe_template_end - (unsigned long)optprobe_template_entry)
>> +
>> +extern __visible kprobe_opcode_t optprobe_template_entry[];
>> +extern __visible kprobe_opcode_t optprobe_template_val[];
>> +extern __visible kprobe_opcode_t optprobe_template_orig_addr[];
>> +extern __visible kprobe_opcode_t optprobe_template_common[];
>> +extern __visible kprobe_opcode_t optprobe_template_end[];
>> +extern __visible kprobe_opcode_t optprobe_template_restore_begin[];
>> +extern __visible kprobe_opcode_t optprobe_template_restore_orig_insn[];
>> +extern __visible kprobe_opcode_t optprobe_template_restore_end[];
>> +extern __visible kprobe_opcode_t optinsn_slot[];
>> +
>> +void optprobe_common(void);
>> +
>>   void __kretprobe_trampoline(void);
>>   void __kprobes *trampoline_probe_handler(struct pt_regs *regs);
>>   
>> diff --git a/arch/arm64/kernel/probes/Makefile b/arch/arm64/kernel/probes/Makefile
>> index 8e4be92e25b1..7b2885b23ff6 100644
>> --- a/arch/arm64/kernel/probes/Makefile
>> +++ b/arch/arm64/kernel/probes/Makefile
>> @@ -4,3 +4,5 @@ obj-$(CONFIG_KPROBES)		+= kprobes.o decode-insn.o	\
>>   				   simulate-insn.o
>>   obj-$(CONFIG_UPROBES)		+= uprobes.o decode-insn.o	\
>>   				   simulate-insn.o
>> +obj-$(CONFIG_OPTPROBES)	+= opt_arm64.o			\
>> +				   optprobe_trampoline.o
>> diff --git a/arch/arm64/kernel/probes/opt_arm64.c b/arch/arm64/kernel/probes/opt_arm64.c
>> new file mode 100644
>> index 000000000000..a7f34ab82a2f
>> --- /dev/null
>> +++ b/arch/arm64/kernel/probes/opt_arm64.c
>> @@ -0,0 +1,244 @@
>> +// SPDX-License-Identifier: GPL-2.0-only
>> +/*
>> + * Code for Kernel probes Jump optimization.
>> + *
>> + * Copyright (C) 2025 HiSilicon Limited
>> + */
>> +
>> +#include <linux/jump_label.h>
>> +#include <linux/kprobes.h>
>> +#include <linux/wordpart.h>
>> +
>> +#include <asm/cacheflush.h>
>> +#include <asm/compiler.h>
>> +#include <asm/insn.h>
>> +#include <asm/kprobes.h>
>> +#include <asm/text-patching.h>
>> +
>> +#define OPTPROBE_BATCH_SIZE 64
>> +
>> +#define TMPL_VAL_IDX \
>> +	(optprobe_template_val - optprobe_template_entry)
>> +#define TMPL_ORIGN_ADDR \
>> +	(optprobe_template_orig_addr - optprobe_template_entry)
>> +#define TMPL_CALL_COMMON \
>> +	(optprobe_template_common - optprobe_template_entry)
>> +#define TMPL_RESTORE_ORIGN_INSN \
>> +	(optprobe_template_restore_orig_insn - optprobe_template_entry)
>> +#define TMPL_RESTORE_END \
>> +	(optprobe_template_restore_end - optprobe_template_entry)
>> +
>> +#define OPT_SLOT_SIZE			65536
>> +#define OPT_INSN_PAGES			(OPT_SLOT_SIZE / PAGE_SIZE)
>> +
>> +static bool insn_page_in_use[OPT_INSN_PAGES];
>> +
>> +void *alloc_optinsn_page(void)
>> +{
>> +	int i;
>> +
>> +	for (i = 0; i < OPT_INSN_PAGES; i++) {
>> +		if (!insn_page_in_use[i]) {
>> +			insn_page_in_use[i] = true;
>> +			return (void *)((unsigned long)optinsn_slot + PAGE_SIZE * i);
> do we need any synchronization here for accessing insn_page_in_use()? Is it guaranteed
> by the framework or no race situation here?

Oh, It's already been synchronized in the upper functions, and there's

mutex to prevent race.

>> +		}
>> +	}
>> +
>> +	return NULL;
>> +}
>> +
>> +void free_optinsn_page(void *page)
>> +{
>> +	unsigned long idx = (unsigned long)page - (unsigned long)optinsn_slot;
>> +
>> +	WARN_ONCE(idx & (PAGE_SIZE - 1), "Invalid idx with wrong align\n");
>> +	idx >>= PAGE_SHIFT;
>> +	if (WARN_ONCE(idx >= OPT_INSN_PAGES, "Invalid idx with wrong size\n"))
>> +		return;
>> +	insn_page_in_use[idx] = false;
>> +}
>> +
>> +/*
>> + * In ARM ISA, kprobe opt always replace one instruction (4 bytes
>> + * aligned and 4 bytes long). It is impossible to encounter another
>> + * kprobe in the address range. So always return 0.
>> + */
>> +int arch_check_optimized_kprobe(struct optimized_kprobe *op)
>> +{
>> +	return 0;
>> +}
>> +
>> +int arch_prepared_optinsn(struct arch_optimized_insn *optinsn)
>> +{
>> +	return optinsn->trampoline != NULL;
>> +}
>> +
>> +int arch_within_optimized_kprobe(struct optimized_kprobe *op, kprobe_opcode_t *addr)
>> +{
>> +	return op->kp.addr == addr;
>> +}
>> +
>> +static int optprobe_check_branch_limit(unsigned long pc, unsigned long addr)
>> +{
>> +	long offset;
>> +
>> +	if ((pc & 0x3) || (addr & 0x3))
>> +		return -ERANGE;
>> +
>> +	offset = (long)addr - (long)pc;
>> +	if (offset < -SZ_128M || offset >= SZ_128M)
>> +		return -ERANGE;
>> +
>> +	return 0;
>> +}
>> +
>> +int arch_prepare_optimized_kprobe(struct optimized_kprobe *op, struct kprobe *orig)
>> +{
>> +	kprobe_opcode_t *code, *buf;
>> +	int ret = -ENOMEM;
>> +	u32 insn;
>> +	int i;
>> +
>> +	buf = kzalloc(MAX_OPTINSN_SIZE, GFP_KERNEL);
>> +	if (!buf)
>> +		return ret;
>> +
>> +	code = get_optinsn_slot();
>> +	if (!code)
>> +		goto out;
>> +
>> +	if (optprobe_check_branch_limit((unsigned long)code, (unsigned long)orig->addr + 8)) {
>> +		ret = -ERANGE;
>> +		goto error;
>> +	}
>> +
>> +	memcpy(buf, optprobe_template_entry, MAX_OPTINSN_SIZE);
>> +
>> +	insn = aarch64_insn_gen_branch_imm((unsigned long)&code[TMPL_CALL_COMMON],
>> +					   (unsigned long)&optprobe_common,
>> +					   AARCH64_INSN_BRANCH_LINK);
>> +	if (insn == AARCH64_BREAK_FAULT) {
>> +		ret = -ERANGE;
>> +		goto error;
>> +	}
>> +
>> +	buf[TMPL_CALL_COMMON] = insn;
>> +
>> +	insn = aarch64_insn_gen_branch_imm((unsigned long)&code[TMPL_RESTORE_END],
>> +					   (unsigned long)(op->kp.addr + 1),
>> +					   AARCH64_INSN_BRANCH_NOLINK);
>> +	if (insn == AARCH64_BREAK_FAULT) {
>> +		ret = -ERANGE;
>> +		goto error;
>> +	}
>> +
>> +	buf[TMPL_RESTORE_END] = insn;
>> +
>> +	buf[TMPL_VAL_IDX] = cpu_to_le32(lower_32_bits((unsigned long)op));
>> +	buf[TMPL_VAL_IDX + 1] = cpu_to_le32(upper_32_bits((unsigned long)op));
>> +	buf[TMPL_ORIGN_ADDR] = cpu_to_le32(lower_32_bits((unsigned long)orig->addr));
>> +	buf[TMPL_ORIGN_ADDR + 1] = cpu_to_le32(upper_32_bits((unsigned long)orig->addr));
>> +> +	buf[TMPL_RESTORE_ORIGN_INSN] = orig->opcode;
> it'll be more convenient to match the assembles if we initialize the trampoline
> according to the code order of optprobe_common.
Good advice, I will fix it in the next version.
>> +
>> +	/* Setup template */
>> +	for (i = 0; i < MAX_OPTINSN_SIZE / MAX_OPTIMIZED_LENGTH; i++)
>> +		aarch64_insn_patch_text_nosync(code + i, buf[i]);
>> +
>> +	flush_icache_range((unsigned long)code, (unsigned long)(&code[TMPL_VAL_IDX]));
>> +	/* Set op->optinsn.trampoline means prepared. */
>> +	op->optinsn.trampoline = code;
>> +
>> +	return 0;
> forget to free the "buf"?
I will fix it in the next version.
>
>> +error:
>> +	free_optinsn_slot(code, 0);
>> +
>> +out:
>> +	kfree(buf);
>> +	return ret;
>> +}
>> +
>> +void arch_optimize_kprobes(struct list_head *oplist)
>> +{
>> +	struct optimized_kprobe *op, *tmp;
>> +	kprobe_opcode_t insns[OPTPROBE_BATCH_SIZE];
>> +	void *addrs[OPTPROBE_BATCH_SIZE];
>> +	int i = 0;
>> +
>> +	list_for_each_entry_safe(op, tmp, oplist, list) {
>> +		WARN_ON(kprobe_disabled(&op->kp));
>> +
>> +		/*
>> +		 * Backup instructions which will be replaced
>> +		 * by jump address
>> +		 */
>> +		memcpy(op->optinsn.orig_insn, op->kp.addr, AARCH64_INSN_SIZE);
>> +
>> +		addrs[i] = op->kp.addr;
>> +		insns[i] = aarch64_insn_gen_branch_imm((unsigned long)op->kp.addr,
>> +						       (unsigned long)op->optinsn.trampoline,
>> +						       AARCH64_INSN_BRANCH_NOLINK);
> need to check the return value here.
ok, I will fix it in the next version.
>
>> +
>> +		list_del_init(&op->list);
>> +		if (++i == OPTPROBE_BATCH_SIZE)
>> +			break;
> if we reach the limits here, what is the behaviour of the rest kprobes?
> need comments here.
ok, I will fix it in the next version.
>
>> +	}
>> +
>> +	aarch64_insn_patch_text(addrs, insns, i);
>> +}
>> +
>> +void arch_unoptimize_kprobe(struct optimized_kprobe *op)
>> +{
>> +	arch_arm_kprobe(&op->kp);
>> +}
>> +
>> +/*
>> + * Recover original instructions and breakpoints from relative jumps.
>> + * Caller must call with locking kprobe_mutex.
>> + */
>> +void arch_unoptimize_kprobes(struct list_head *oplist,
>> +			    struct list_head *done_list)
>> +{
>> +	struct optimized_kprobe *op, *tmp;
>> +	kprobe_opcode_t insns[OPTPROBE_BATCH_SIZE];
>> +	void *addrs[OPTPROBE_BATCH_SIZE];
>> +	int i = 0;
>> +
>> +	list_for_each_entry_safe(op, tmp, oplist, list) {
>> +		addrs[i] = op->kp.addr;
>> +		insns[i] = BRK64_OPCODE_KPROBES;
>> +		list_move(&op->list, done_list);
>> +
>> +		if (++i == OPTPROBE_BATCH_SIZE)
>> +			break;
>> +	}
>> +
>> +	aarch64_insn_patch_text(addrs, insns, i);
>> +}
>> +
>> +void arch_remove_optimized_kprobe(struct optimized_kprobe *op)
>> +{
>> +	if (op->optinsn.trampoline) {
>> +		free_optinsn_slot(op->optinsn.trampoline, 1);
>> +		op->optinsn.trampoline = NULL;
>> +	}
>> +
>> +}
>> +
>> +void optprobe_optimized_callback(struct optimized_kprobe *op, struct pt_regs *regs)
> need to be static.
ok, I will fix it in the next version.
It must be referenced by 'optprobe_trampoline.S' and cannot be covered 
by the static scope.
>> +{
>> +	if (kprobe_disabled(&op->kp))
>> +		return;
>> +
>> +	guard(preempt)();
>> +
>> +	if (kprobe_running()) {
>> +		kprobes_inc_nmissed_count(&op->kp);
>> +	} else {
>> +		__this_cpu_write(current_kprobe, &op->kp);
>> +		get_kprobe_ctlblk()->kprobe_status = KPROBE_HIT_ACTIVE;
>> +		opt_pre_handler(&op->kp, regs);
>> +		__this_cpu_write(current_kprobe, NULL);
>> +	}
>> +}
>> +NOKPROBE_SYMBOL(optprobe_optimized_callback)
>> diff --git a/arch/arm64/kernel/probes/optprobe_trampoline.S b/arch/arm64/kernel/probes/optprobe_trampoline.S
>> new file mode 100644
>> index 000000000000..f564b119da69
>> --- /dev/null
>> +++ b/arch/arm64/kernel/probes/optprobe_trampoline.S
>> @@ -0,0 +1,113 @@
>> +/* SPDX-License-Identifier: GPL-2.0 */
>> +/*
>> + * trampoline entry and return code for optprobes.
>> + */
>> +
>> +#include <linux/linkage.h>
>> +#include <asm/asm-offsets.h>
>> +#include <asm/assembler.h>
>> +
>> +#define        OPT_SLOT_SIZE   65536
>> +
>> +	.global optinsn_slot
>> +optinsn_slot:
>> +	.space  OPT_SLOT_SIZE
>> +
>> +SYM_CODE_START(optprobe_common)
>> +	stp x2, x3, [sp, #S_X2]
>> +	stp x4, x5, [sp, #S_X4]
>> +	stp x6, x7, [sp, #S_X6]
>> +	stp x8, x9, [sp, #S_X8]
>> +	stp x10, x11, [sp, #S_X10]
>> +	stp x12, x13, [sp, #S_X12]
>> +	stp x14, x15, [sp, #S_X14]
>> +	stp x16, x17, [sp, #S_X16]
>> +	stp x18, x19, [sp, #S_X18]
>> +	stp x20, x21, [sp, #S_X20]
>> +	stp x22, x23, [sp, #S_X22]
>> +	stp x24, x25, [sp, #S_X24]
>> +	stp x26, x27, [sp, #S_X26]
>> +	stp x28, x29, [sp, #S_X28]
>> +	add x2, sp, #PT_REGS_SIZE
>> +	str x2, [sp, #S_SP]
>> +	/* Construct a useful saved PSTATE */
>> +	mrs x2, nzcv
>> +	mrs x3, daif
>> +	orr x2, x2, x3
>> +	mrs x3, CurrentEL
>> +	orr x2, x2, x3
>> +	mrs x3, SPSel
>> +	orr x2, x2, x3
>> +	adr x1, 2f
>> +	stp x1, x2, [sp, #S_PC]
>> +
>> +	/* set the pt_regs address to x1 */
>> +	mov x1, sp
>> +	/* store lr of optprobe_common temporary */
>> +	stp x29, x30, [sp, #-16]!
>> +	mov x29, sp
>> +
>> +	bl optprobe_optimized_callback
>> +
>> +	ldp x29, x30, [sp], #16
>> +
>> +	ldr x0, [sp, #S_PSTATE]
>> +	and x0, x0, #(PSR_N_BIT | PSR_Z_BIT | PSR_C_BIT | PSR_V_BIT)
>> +	msr nzcv, x0
>> +
>> +	ldp x0, x1, [sp, #S_X0]
>> +	ldp x2, x3, [sp, #S_X2]
>> +	ldp x4, x5, [sp, #S_X4]
>> +	ldp x6, x7, [sp, #S_X6]
>> +	ldp x8, x9, [sp, #S_X8]
>> +	ldp x10, x11, [sp, #S_X10]
>> +	ldp x12, x13, [sp, #S_X12]
>> +	ldp x14, x15, [sp, #S_X14]
>> +	ldp x16, x17, [sp, #S_X16]
>> +	ldp x18, x19, [sp, #S_X18]
>> +	ldp x20, x21, [sp, #S_X20]
>> +	ldp x22, x23, [sp, #S_X22]
>> +	ldp x24, x25, [sp, #S_X24]
>> +	ldp x26, x27, [sp, #S_X26]
>> +	ldp x28, x29, [sp, #S_X28]
>> +	ret
>> +SYM_CODE_END(optprobe_common)
>> +
>> +	.global optprobe_template_entry
>> +optprobe_template_entry:
>> +	stp x29, x30, [sp, #-16]!
>> +	mov x29, sp
>> +	adr x30, 2f
>> +	stp x29, x30, [sp, #-16]!
>> +	mov x29, sp
>> +	sub sp, sp, #PT_REGS_SIZE
>> +	str lr, [sp, #S_LR]
>> +	stp x0, x1, [sp, #S_X0]
>> +	/* Get parameters to optimized_callback() */
>> +	adr x0, 1f
>> +	.global optprobe_template_common
>> +optprobe_template_common:
>> +	nop
>> +	ldr lr, [sp, #S_LR]
>> +	add sp, sp, #PT_REGS_SIZE
>> +	ldp x29, x30, [sp], #16
>> +	ldp x29, x30, [sp], #16
> so we restore the FP/LR twice, need comments to mention the reason here.
>
> Thanks.
Okay, I'll add some comments in the next version.
>
>> +	.global optprobe_template_restore_orig_insn
>> +optprobe_template_restore_orig_insn:
>> +	nop
>> +	.global optprobe_template_restore_end
>> +optprobe_template_restore_end:
>> +	nop
>> +	.balign
>> +	.global optprobe_template_val
>> +optprobe_template_val:
>> +	1:	.long 0
>> +		.long 0
>> +	.balign
>> +	.global optprobe_template_orig_addr
>> +optprobe_template_orig_addr:
>> +	2:	.long 0
>> +		.long 0
>> +	.global optprobe_template_end
>> +optprobe_template_end:
>> +	nop
>>

