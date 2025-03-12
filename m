Return-Path: <linux-kernel+bounces-558337-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3526EA5E486
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 20:35:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB75E3A5106
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 19:35:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CEA32571A5;
	Wed, 12 Mar 2025 19:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aQJ3+8p6"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEDC71CA9C
	for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 19:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741808119; cv=none; b=cq3utILl+YM3QXRDCztkP+XZkb7ygMzla0BxWDC40CESP4fz1vwAoabgV8V2eH4wh+f4++3eGCZLkKasTa8pdAtkAixBe33qZ8WotQGfhl4/idnxQJ9pfjPBqx7eOskyNNJPbMgawvocphL0Xu92H6x/tJBkIvCq1okx7rszW+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741808119; c=relaxed/simple;
	bh=M7+fyGOccmn1F32HBUZ/rVE79bzT22RXFBotLnZ+pnE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=q6cC34hNEMSMY99fJCYHtNpyLceeNVHZoCgNirtTXnj1BsIg9M243S7o4L+kclnixnf5DNLCBJ/LdrpbxBR03C9VMVksq52ibnB1JdD0+wA7XQ1cVl9c5z87N/xn1luJG7OpnQZlp/KOfXgT8LgRM9V1HcccoJFTiZaGF9CLm6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aQJ3+8p6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB038C4CEDD;
	Wed, 12 Mar 2025 19:35:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741808118;
	bh=M7+fyGOccmn1F32HBUZ/rVE79bzT22RXFBotLnZ+pnE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=aQJ3+8p6fBwpOXEoh6GvXpk0RJ1mLsxFNRyOfDYvPJVsJfMjjE1qgqFH6yYkH2g1W
	 6HS/MW8DmQtGobiIy6Gn1FzYH4FnIe7XKHd7cTxg7+Ojs4F0tSxMuFP8chjQo3PsWR
	 ah3G8UoaACRNCF3QFNGyxqaONyQXiSxLOyHwu6sj/ya2CIkGIwKSPaOTRqKaVdCksf
	 hbvznQCMx2/39jeQ8sKkEcW0/uPudiwcF1Dd9/ekn6BPqBnn2qiVsQT4RcY4G4xAdR
	 yq/gHuPvuQw0/cg11V55/52mhFcFUBrvQme/KdXF+uBe5zb8ezrX/TzxKaQJHkXKrY
	 N8vUqpBOVkgoA==
From: =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To: Pu Lehui <pulehui@huaweicloud.com>, linux-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>, Alexandre Ghiti <alex@ghiti.fr>,
 "Masami Hiramatsu (Google)" <mhiramat@kernel.org>, "Steven Rostedt
 (Google)" <rostedt@goodmis.org>, Naresh Kamboju
 <naresh.kamboju@linaro.org>, Pu Lehui <pulehui@huawei.com>
Subject: Re: [PATCH] riscv: fgraph: Fix stack layout to match
 __arch_ftrace_regs argument of ftrace_return_to_handler
In-Reply-To: <20250311132243.2178271-1-pulehui@huaweicloud.com>
References: <20250311132243.2178271-1-pulehui@huaweicloud.com>
Date: Wed, 12 Mar 2025 20:35:14 +0100
Message-ID: <87wmcucaa5.fsf@all.your.base.are.belong.to.us>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Pu Lehui <pulehui@huaweicloud.com> writes:

> From: Pu Lehui <pulehui@huawei.com>
>
> Naresh Kamboju reported a "Bad frame pointer" kernel warning while
> running LTP trace ftrace_stress_test.sh in riscv. We can reproduce the
> same issue with the following command:
>
> ```
> $ cd /sys/kernel/debug/tracing
> $ echo 'f:myprobe do_nanosleep%return args1=3D$retval' > dynamic_events
> $ echo 1 > events/fprobes/enable
> $ echo 1 > tracing_on
> $ sleep 1
> ```
>
> And we can get the following kernel warning:
>
> [  127.692888] ------------[ cut here ]------------
> [  127.693755] Bad frame pointer: expected ff2000000065be50, received ba3=
4c141e9594000
> [  127.693755]   from func do_nanosleep return to ffffffff800ccb16
> [  127.698699] WARNING: CPU: 1 PID: 129 at kernel/trace/fgraph.c:755 ftra=
ce_return_to_handler+0x1b2/0x1be
> [  127.699894] Modules linked in:
> [  127.700908] CPU: 1 UID: 0 PID: 129 Comm: sleep Not tainted 6.14.0-rc3-=
g0ab191c74642 #32
> [  127.701453] Hardware name: riscv-virtio,qemu (DT)
> [  127.701859] epc : ftrace_return_to_handler+0x1b2/0x1be
> [  127.702032]  ra : ftrace_return_to_handler+0x1b2/0x1be
> [  127.702151] epc : ffffffff8013b5e0 ra : ffffffff8013b5e0 sp : ff200000=
0065bd10
> [  127.702221]  gp : ffffffff819c12f8 tp : ff60000080853100 t0 : 6e000000=
00000000
> [  127.702284]  t1 : 0000000000000020 t2 : 6e7566206d6f7266 s0 : ff200000=
0065bd80
> [  127.702346]  s1 : ff60000081262000 a0 : 000000000000007b a1 : ffffffff=
81894f20
> [  127.702408]  a2 : 0000000000000010 a3 : fffffffffffffffe a4 : 00000000=
00000000
> [  127.702470]  a5 : 0000000000000000 a6 : 0000000000000008 a7 : 00000000=
00000038
> [  127.702530]  s2 : ba34c141e9594000 s3 : 0000000000000000 s4 : ff200000=
0065bdd0
> [  127.702591]  s5 : 00007fff8adcf400 s6 : 000055556dc1d8c0 s7 : 00000000=
00000068
> [  127.702651]  s8 : 00007fff8adf5d10 s9 : 000000000000006d s10: 00000000=
00000001
> [  127.702710]  s11: 00005555737377c8 t3 : ffffffff819d899e t4 : ffffffff=
819d899e
> [  127.702769]  t5 : ffffffff819d89a0 t6 : ff2000000065bb18
> [  127.702826] status: 0000000200000120 badaddr: 0000000000000000 cause: =
0000000000000003
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
> Closes: https://lore.kernel.org/all/CA+G9fYvp_oAxeDFj88Tk2rfEZ7jtYKAKSwfY=
S66=3D57Db9TBdyA@mail.gmail.com
> Signed-off-by: Pu Lehui <pulehui@huawei.com>

With this patch, I get (from ftrace startup tests):
  Testing tracer function_graph: PASSED
instead of the splat above! Thanks!

Tested-by: Bj=C3=B6rn T=C3=B6pel <bjorn@rivosinc.com>

