Return-Path: <linux-kernel+bounces-427044-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4ADD19DFB8E
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 08:59:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 075FC16162C
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 07:59:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 454AE1F9A9F;
	Mon,  2 Dec 2024 07:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yadro.com header.i=@yadro.com header.b="oqIUdBdD";
	dkim=pass (2048-bit key) header.d=yadro.com header.i=@yadro.com header.b="HGQs4v4Z"
Received: from mta-03.yadro.com (mta-03.yadro.com [89.207.88.253])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E896156220
	for <linux-kernel@vger.kernel.org>; Mon,  2 Dec 2024 07:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.207.88.253
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733126342; cv=none; b=WU12FwmUQ20nXpPCRyDfHQQJ9g0i1uZcm9AFKhOzYpF0IN3x/OdTK8ip+W9ZWxjR0uqm2ar8Dm/I2mvXl8VCDKij/9vPXUfSNe/O3gJ7GyC1fgOyezgnKrs8x1Nf7ncHgW5TJSgzc3FezaNPKnq0zFZjc4dvjHE1h9rFHwv1Wxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733126342; c=relaxed/simple;
	bh=lI5ecZrVKoDDzHzIcNve9oQyAaRZmoMQKc4D/2CelSE=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=RD2j1+EyYsQ4hfUxdGsueYrgfg+7PLUUzDv6TMTxdLzQyH5GMv59T+pEEfbMgjZjOJ9so8scvNk7wIp7eufWizMXObAjUUONq8X49qJNFkko78eyxlrDCkpPxwbjlJH2CthUEjWyRhXYs9xuleTuoO7dQKHv9ZcoAlWmtw3BRqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yadro.com; spf=pass smtp.mailfrom=yadro.com; dkim=pass (2048-bit key) header.d=yadro.com header.i=@yadro.com header.b=oqIUdBdD; dkim=pass (2048-bit key) header.d=yadro.com header.i=@yadro.com header.b=HGQs4v4Z; arc=none smtp.client-ip=89.207.88.253
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yadro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yadro.com
DKIM-Filter: OpenDKIM Filter v2.11.0 mta-03.yadro.com 618B8E0002
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yadro.com; s=mta-04;
	t=1733126334; bh=FtA8nfMAc5D3CTIG0uNX1jurEbsjQmlpZP0LYJNrYJM=;
	h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type:From;
	b=oqIUdBdD+IE9izN16sbYuKngFHY+B4IaNnQxY2W/hp7Edh5fehT/QYXgE1K9rJ0nv
	 pwchwPh1STprgpXMw60f7WTs/Ur2hhi6TYFzy5uFhjAcJi3+F389uTqGa/as8/u84J
	 PJe2ufKbtw7ZkYNV5ygIc77+BWUcJKPi4k1X+EE1JYzcNwTajkhukFgO/qS/OvwDoU
	 nIqeLIwhSotPAgeRujwPCkvb29PkuJNmt3BkZ/erLVRkSxpmDbhsHSOMXxvP7lteXg
	 1JyQeOzg8Xrqijc8kCawIIGwtqvJvzQ471IOGYTOfarN3ty/mZzpEnk6KQFiV/HNYb
	 U5gGzm9c9wZuQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yadro.com; s=mta-03;
	t=1733126334; bh=FtA8nfMAc5D3CTIG0uNX1jurEbsjQmlpZP0LYJNrYJM=;
	h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type:From;
	b=HGQs4v4Z5Rs9dryTvbgzi7WFSzX1HI+vdZCx2vFydmE05azEugTTrlAEkOhYjhz2o
	 hdlV6C/Q4E4nB/IYwbHfzaxDZa7cWU4c84ErXlQ8dPPS9fYk3NGtGh2zplSDnd1DtC
	 gVeKi9ZumoJUQcMrugR9ilegDW+6wZmUAYZK60MfHY8tM6+cxXqDzPA04TAYiKPx+u
	 oaYgylq804G8cygCQB6iB0USueKAwDF/N4muvvFBm11XBqC6t6zXZsftxslCkhc90c
	 WQuiQ89ENaGGLabVDY89y7j70htR7sCcvK6ttF3qCDgJJ71Xo7u8Ntfs5jd1do4muL
	 rWlX98fEk1PMQ==
Message-ID: <62f06687-a20d-4f55-b22d-52af707b528a@yadro.com>
Date: Mon, 2 Dec 2024 10:58:51 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/7] riscv: ftrace: atmoic patching and preempt
 improvements
To: Andy Chiu <andybnac@gmail.com>
CC: Justin Stitt <justinstitt@google.com>, Bill Wendling <morbo@google.com>,
	Nick Desaulniers <ndesaulniers@google.com>, Nathan Chancellor
	<nathan@kernel.org>, Albert Ou <aou@eecs.berkeley.edu>, Palmer Dabbelt
	<palmer@dabbelt.com>, Paul Walmsley <paul.walmsley@sifive.com>,
	<linux-kernel@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
	<llvm@lists.linux.dev>, <bjorn@rivosinc.com>, <puranjay12@gmail.com>,
	<alexghiti@rivosinc.com>, <yongxuan.wang@sifive.com>,
	<greentime.hu@sifive.com>, <nick.hu@sifive.com>, <nylon.chen@sifive.com>,
	<tommy.wu@sifive.com>, <eric.lin@sifive.com>, <viccent.chen@sifive.com>,
	<zong.li@sifive.com>, <samuel.holland@sifive.com>, <linux@yadro.com>
References: <20241127172908.17149-1-andybnac@gmail.com>
Content-Language: en-US
From: Evgenii Shatokhin <e.shatokhin@yadro.com>
In-Reply-To: <20241127172908.17149-1-andybnac@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: T-EXCH-07.corp.yadro.com (172.17.11.57) To
 T-EXCH-10.corp.yadro.com (172.17.11.60)

Hi,

On 27.11.2024 20:29, Andy Chiu wrote:
> This series makes atmoic code patching possible in riscv ftrace. A
> direct benefit of this is that we can get rid of stop_machine() when
> patching function entries. This also makes it possible to run ftrace
> with full kernel preemption. Before this series, the kernel initializes
> patchable function entries to NOP4 + NOP4. To start tracing, it updates
> entries to AUIPC + JALR while holding other cores in stop_machine.
> stop_machine() is required because it is impossible to update 2
> instructions, and be seen atomically. And preemption must have to be
> prevented, as kernel preemption allows process to be scheduled out while
> executing on one of these instruction pairs.
> 
> This series addresses the problem by initializing the first NOP4 to
> AUIPC. So, atmoic patching is possible because the kernel only has to
> update one instruction. As long as the instruction is naturally aligned,
> then it is expected to be updated atomically.
> 
> However, the address range of the ftrace trampoline is limited to +-2K
> from ftrace_caller after appplying this series. This issue is expected
> to be solved by Puranjay's CALL_OPS, where it adds 8B naturally align
> data in front of pacthable functions and can  use it to direct execution
> out to any custom trampolines.
> 
> The series is composed by three parts. The first part cleans up the
> existing issues when the kernel is compiled with clang.The second part
> modifies the ftrace code patching mechanism (2-4) as mentioned above.
> Then prepare ftrace to be able to run with kernel preemption (5,6)
> 
> An ongoing fix:
> 
> Since there is no room for marking *kernel_text_address as notrace[1] at
> source code level, there is a significant performance regression when
> using function_graph with TRACE_IRQFLAGS enabled. There can be as much as
> 8 graph handler being called in each function-entry. The current
> workaround requires us echo "*kernel_text_address" into
> set_ftrace_notrace before starting the trace. However, we observed that
> the kernel still enables the patch site in some cases even with
> *kernel_text_address properly added in the file While the root cause is
> still under investagtion, we consider that it should not be the reason
> for holding back the code patching, in order to unblock the call_ops
> part.
> 
> [1]: https://lore.kernel.org/linux-riscv/20240613093233.0b349ed0@rorschach.local.home/
> 
> Changes in v3:
> - Add a fix tag for patch 1
> - Add a data fence before sending out remote fence.i (6)
> - Link to v2: https://lore.kernel.org/all/20240628-dev-andyc-dyn-ftrace-v4-v2-0-1e5f4cb1f049@sifive.com/
> 
> Changes in v2:
> - Drop patch 1 as it is merged through fixes.
> - Drop patch 2, which converts kernel_text_address into notrace. As
>    users can prevent tracing it by configuring the tracefs.
> - Use a more generic way in kconfig to align functions.
> - Link to v1: https://lore.kernel.org/r/20240613-dev-andyc-dyn-ftrace-v4-v1-0-1a538e12c01e@sifive.com
> 
> 
> Andy Chiu (7):
>    riscv: ftrace: support fastcc in Clang for WITH_ARGS
>    riscv: ftrace: align patchable functions to 4 Byte boundary
>    riscv: ftrace: prepare ftrace for atomic code patching
>    riscv: ftrace: do not use stop_machine to update code
>    riscv: vector: Support calling schedule() for preemptible Vector
>    riscv: add a data fence for CMODX in the kernel mode
>    riscv: ftrace: support PREEMPT
> 
>   arch/riscv/Kconfig                 |   4 +-
>   arch/riscv/include/asm/ftrace.h    |  11 +++
>   arch/riscv/include/asm/processor.h |   5 ++
>   arch/riscv/include/asm/vector.h    |  22 ++++-
>   arch/riscv/kernel/asm-offsets.c    |   7 ++
>   arch/riscv/kernel/ftrace.c         | 133 ++++++++++++-----------------
>   arch/riscv/kernel/mcount-dyn.S     |  25 ++++--
>   arch/riscv/mm/cacheflush.c         |  15 +++-
>   8 files changed, 135 insertions(+), 87 deletions(-)
> ---
> base-commit: 0eb512779d642b21ced83778287a0f7a3ca8f2a1
> --
> 2.39.3 (Apple Git-145)

I have tested this series in a QEMU VM (-machine virt) with the 
preemptible kernels, CONFIG_PREEMPT=y.

No issues have been revealed so far.

One of the kernels was built by GCC 13.2.0 (with the patch for minimum 
alignment added on top of it), the other - with LLVM 17.0.6.

In both cases, the basic boottime tests for Ftrace passed.

Switching tracers between nop, function, function_graph and blk in a 
loop in parallel with stress-ng and with network load for several hours 
did not reveal any problems either. Kernel crashes happened in this 
scenario a year ago, but now it runs clean, good!

Function redirection via Ftrace seems to work OK too.

The size of .text section increased slightly after this series, by 0.35% 
- 0.38%, probably because of function alignment:
* 12075 KB => 12121 KB (GCC)
* 12167 KB => 12209 KB (LLVM/clang)

Not sure, how to test the vector-related part though, "[PATCH v3 5/7] 
riscv: vector: Support calling schedule() for preemptible Vector"

For all other patches in the series:
Tested-by: Evgenii Shatokhin <e.shatokhin@yadro.com>

Regards,
Evgenii

