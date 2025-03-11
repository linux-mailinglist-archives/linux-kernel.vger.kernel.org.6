Return-Path: <linux-kernel+bounces-556276-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D0060A5C392
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 15:16:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8E95316C7DC
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 14:15:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A19825BAC5;
	Tue, 11 Mar 2025 14:14:31 +0000 (UTC)
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7579F254B0D
	for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 14:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741702470; cv=none; b=rUNxHBq36CH/so83adGVsUGRnFZe3pTOmCN5Ru/szPqvNeW7EMc2IMX51sxzU0TPXpyq8HxhHyuIZNZ/aoVwSzj7lgerlnjFJSHxeaN7SoM14jQCnGKhOVbV24Cg0BbiX2iIU3njf1UkEFsuELoIxZINMIfhNWBs/paPYtCo8eM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741702470; c=relaxed/simple;
	bh=4GxfhW1VvwugEPa4S44BXC1EuXDp+9/89G1h3HCD//Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fpItS24soEr5u7nzSAHeom/T3u8cx0YA76GkzrNTW1b4qHPwr/u4ow8wDan82HB/X3i9MaTaCRuiCfFbfH3qxzfUQZzRXXgaxm1Jd2zD8iBSZy3QuVAaQbiC1YBQAvpNr1jM2NKc+nAX05xFlKaZzWDhm3Y332f8Pkyr2Mq2nBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr; spf=pass smtp.mailfrom=ghiti.fr; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ghiti.fr
Received: by mail.gandi.net (Postfix) with ESMTPSA id 91CB644257;
	Tue, 11 Mar 2025 14:14:19 +0000 (UTC)
Message-ID: <536b4feb-4631-4727-b918-c2e39e8217fb@ghiti.fr>
Date: Tue, 11 Mar 2025 15:14:18 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] riscv: fgraph: Fix stack layout to match
 __arch_ftrace_regs argument of ftrace_return_to_handler
Content-Language: en-US
To: Pu Lehui <pulehui@huaweicloud.com>, linux-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
 "Steven Rostedt (Google)" <rostedt@goodmis.org>,
 Naresh Kamboju <naresh.kamboju@linaro.org>, Pu Lehui <pulehui@huawei.com>,
 =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@rivosinc.com>
References: <20250311132243.2178271-1-pulehui@huaweicloud.com>
From: Alexandre Ghiti <alex@ghiti.fr>
In-Reply-To: <20250311132243.2178271-1-pulehui@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduvddvgeehucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefkffggfgfuvfevfhfhjggtgfesthekredttddvjeenucfhrhhomheptehlvgigrghnughrvgcuifhhihhtihcuoegrlhgvgiesghhhihhtihdrfhhrqeenucggtffrrghtthgvrhhnpeeuffegheeugfeugeegvdeigeegieegkeejhfeludejhfegvdehvefghfevkedtleenucffohhmrghinhepkhgvrhhnvghlrdhorhhgpdhmtghouhhnthdrshgsnecukfhppeefuddrfedvrdekuddrudekjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeefuddrfedvrdekuddrudekjedphhgvlhhopegludelvddrudeikedrvddurddvhegnpdhmrghilhhfrhhomheprghlvgigsehghhhithhirdhfrhdpnhgspghrtghpthhtohepledprhgtphhtthhopehpuhhlvghhuhhisehhuhgrfigvihgtlhhouhgurdgtohhmpdhrtghpthhtoheplhhinhhugidqrhhishgtvheslhhishhtshdrihhnfhhrrgguvggrugdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehprghlmhgvrhesuggrsggsvghlthdrtghomhdprhgtphhtthhop
 ehmhhhirhgrmhgrtheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprhhoshhtvgguthesghhoohgumhhishdrohhrghdprhgtphhtthhopehnrghrvghshhdrkhgrmhgsohhjuheslhhinhgrrhhordhorhhgpdhrtghpthhtohepphhulhgvhhhuiheshhhurgifvghirdgtohhm
X-GND-Sasl: alex@ghiti.fr

Hi Pu,

Thanks for working on this, we were talking about this issue with Björn 
this morning!

On 11/03/2025 14:22, Pu Lehui wrote:
> From: Pu Lehui <pulehui@huawei.com>
>
> Naresh Kamboju reported a "Bad frame pointer" kernel warning while
> running LTP trace ftrace_stress_test.sh in riscv. We can reproduce the
> same issue with the following command:
>
> ```
> $ cd /sys/kernel/debug/tracing
> $ echo 'f:myprobe do_nanosleep%return args1=$retval' > dynamic_events
> $ echo 1 > events/fprobes/enable
> $ echo 1 > tracing_on
> $ sleep 1
> ```
>
> And we can get the following kernel warning:
>
> [  127.692888] ------------[ cut here ]------------
> [  127.693755] Bad frame pointer: expected ff2000000065be50, received ba34c141e9594000
> [  127.693755]   from func do_nanosleep return to ffffffff800ccb16
> [  127.698699] WARNING: CPU: 1 PID: 129 at kernel/trace/fgraph.c:755 ftrace_return_to_handler+0x1b2/0x1be
> [  127.699894] Modules linked in:
> [  127.700908] CPU: 1 UID: 0 PID: 129 Comm: sleep Not tainted 6.14.0-rc3-g0ab191c74642 #32
> [  127.701453] Hardware name: riscv-virtio,qemu (DT)
> [  127.701859] epc : ftrace_return_to_handler+0x1b2/0x1be
> [  127.702032]  ra : ftrace_return_to_handler+0x1b2/0x1be
> [  127.702151] epc : ffffffff8013b5e0 ra : ffffffff8013b5e0 sp : ff2000000065bd10
> [  127.702221]  gp : ffffffff819c12f8 tp : ff60000080853100 t0 : 6e00000000000000
> [  127.702284]  t1 : 0000000000000020 t2 : 6e7566206d6f7266 s0 : ff2000000065bd80
> [  127.702346]  s1 : ff60000081262000 a0 : 000000000000007b a1 : ffffffff81894f20
> [  127.702408]  a2 : 0000000000000010 a3 : fffffffffffffffe a4 : 0000000000000000
> [  127.702470]  a5 : 0000000000000000 a6 : 0000000000000008 a7 : 0000000000000038
> [  127.702530]  s2 : ba34c141e9594000 s3 : 0000000000000000 s4 : ff2000000065bdd0
> [  127.702591]  s5 : 00007fff8adcf400 s6 : 000055556dc1d8c0 s7 : 0000000000000068
> [  127.702651]  s8 : 00007fff8adf5d10 s9 : 000000000000006d s10: 0000000000000001
> [  127.702710]  s11: 00005555737377c8 t3 : ffffffff819d899e t4 : ffffffff819d899e
> [  127.702769]  t5 : ffffffff819d89a0 t6 : ff2000000065bb18
> [  127.702826] status: 0000000200000120 badaddr: 0000000000000000 cause: 0000000000000003
> [  127.703292] [<ffffffff8013b5e0>] ftrace_return_to_handler+0x1b2/0x1be
> [  127.703760] [<ffffffff80017bce>] return_to_handler+0x16/0x26
> [  127.704009] [<ffffffff80017bb8>] return_to_handler+0x0/0x26
> [  127.704057] [<ffffffff800d3352>] common_nsleep+0x42/0x54
> [  127.704117] [<ffffffff800d44a2>] __riscv_sys_clock_nanosleep+0xba/0x10a
> [  127.704176] [<ffffffff80901c56>] do_trap_ecall_u+0x188/0x218
> [  127.704295] [<ffffffff8090cc3e>] handle_exception+0x14a/0x156
> [  127.705436] ---[ end trace 0000000000000000 ]---
>
> The reason is that the stack layout for constructing argument for the
> ftrace_return_to_handler in the return_to_handler does not match the
> __arch_ftrace_regs structure of riscv, leading to unexpected results.
>
> Fixes: a3ed4157b7d8 ("fgraph: Replace fgraph_ret_regs with ftrace_regs")
> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> Closes: https://lore.kernel.org/all/CA+G9fYvp_oAxeDFj88Tk2rfEZ7jtYKAKSwfYS66=57Db9TBdyA@mail.gmail.com
> Signed-off-by: Pu Lehui <pulehui@huawei.com>
> ---
>   arch/riscv/kernel/mcount.S | 24 +++++++++++-------------
>   1 file changed, 11 insertions(+), 13 deletions(-)
>
> diff --git a/arch/riscv/kernel/mcount.S b/arch/riscv/kernel/mcount.S
> index 068168046e0e..da4a4000e57e 100644
> --- a/arch/riscv/kernel/mcount.S
> +++ b/arch/riscv/kernel/mcount.S
> @@ -12,8 +12,6 @@
>   #include <asm/asm-offsets.h>
>   #include <asm/ftrace.h>
>   
> -#define ABI_SIZE_ON_STACK	80
> -
>   	.text
>   
>   	.macro SAVE_ABI_STATE
> @@ -28,12 +26,12 @@
>   	 * register if a0 was not saved.
>   	 */
>   	.macro SAVE_RET_ABI_STATE
> -	addi	sp, sp, -ABI_SIZE_ON_STACK
> -	REG_S	ra, 1*SZREG(sp)
> -	REG_S	s0, 8*SZREG(sp)
> -	REG_S	a0, 10*SZREG(sp)
> -	REG_S	a1, 11*SZREG(sp)
> -	addi	s0, sp, ABI_SIZE_ON_STACK
> +	addi	sp, sp, -FREGS_SIZE_ON_STACK
> +	REG_S	ra, FREGS_RA(sp)
> +	REG_S	s0, FREGS_S0(sp)
> +	REG_S	a0, FREGS_A0(sp)
> +	REG_S	a1, FREGS_A1(sp)
> +	addi	s0, sp, FREGS_SIZE_ON_STACK
>   	.endm
>   
>   	.macro RESTORE_ABI_STATE
> @@ -43,11 +41,11 @@
>   	.endm
>   
>   	.macro RESTORE_RET_ABI_STATE
> -	REG_L	ra, 1*SZREG(sp)
> -	REG_L	s0, 8*SZREG(sp)
> -	REG_L	a0, 10*SZREG(sp)
> -	REG_L	a1, 11*SZREG(sp)
> -	addi	sp, sp, ABI_SIZE_ON_STACK
> +	REG_L	ra, FREGS_RA(sp)
> +	REG_L	s0, FREGS_S0(sp)
> +	REG_L	a0, FREGS_A0(sp)
> +	REG_L	a1, FREGS_A1(sp)
> +	addi	sp, sp, FREGS_SIZE_ON_STACK
>   	.endm
>   
>   SYM_TYPED_FUNC_START(ftrace_stub)


It looks good to me, so:

Reviewed-by: Alexandre Ghiti <alexghiti@rivosinc.com>

Thanks,

Alex


