Return-Path: <linux-kernel+bounces-182217-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AEDDD8C8834
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 16:41:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F3A01B24A1E
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 14:41:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D44D79EA;
	Fri, 17 May 2024 14:41:03 +0000 (UTC)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FEDE1A2C2E
	for <linux-kernel@vger.kernel.org>; Fri, 17 May 2024 14:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715956862; cv=none; b=ZAVZRFn1764zZxV1vDm8TzIbhbXr6AkTqGYDISMu4itZ+oNPC1fta0ZyG3Dx6uaHfDIjm3s67G/Qy/D3udAjUHD8S2WRbejAAwpY6BUrjKqeZo44oNT2tcck/lhjnxIm7VL0ANR2EaU8ec8a+qtY497D+VazzRkvBw3liKYhVZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715956862; c=relaxed/simple;
	bh=EGn3ljBz6rxQ4NlQ7kY83/2B6Dqy4mSY8TiKcxSKrFI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=htz2oIZVZ6RqasqqZx5fZitLPMnZV1hE4aSR9uMXVMNkV6UgtZqEAqsjxLDUlbcKITMrTQ6c29+TbW3J1j2oeRf4S252m66YG37pT03gg+EYNn81/AJpfD8K/HFoz9Ty+4xwlOdxwKeEAwcz72Rnk+KoKnBvkj5mj9ODYY/QjYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4VgqLD2xrZzvYx9;
	Fri, 17 May 2024 22:37:24 +0800 (CST)
Received: from canpemm500010.china.huawei.com (unknown [7.192.105.118])
	by mail.maildlp.com (Postfix) with ESMTPS id 5372C1800C7;
	Fri, 17 May 2024 22:40:56 +0800 (CST)
Received: from huawei.com (10.67.189.167) by canpemm500010.china.huawei.com
 (7.192.105.118) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Fri, 17 May
 2024 22:40:56 +0800
From: Jiangfeng Xiao <xiaojiangfeng@huawei.com>
To: <catalin.marinas@arm.com>, <will@kernel.org>, <Dave.Martin@arm.com>,
	<xieyuanbin1@huawei.com>, <xiaojiangfeng@huawei.com>
CC: <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<nixiaoming@huawei.com>, <wangbing6@huawei.com>, <douzhaolei@huawei.com>,
	<liaohua4@huawei.com>, <lijiahuan5@huawei.com>, <wangfangpeng1@huawei.com>
Subject: [PATCH] arm64: asm-bug: Add .align 2 to the end of __BUG_ENTRY
Date: Fri, 17 May 2024 22:13:28 +0800
Message-ID: <1715955208-17109-1-git-send-email-xiaojiangfeng@huawei.com>
X-Mailer: git-send-email 1.8.5.6
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 canpemm500010.china.huawei.com (7.192.105.118)

I'm using the latest linux kernel mainline code,
with the default arm64 configuration:
make ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- defconfig,
and set CONFIG_EXPERT=y, CONFIG_DEBUG_BUGVERBOSE=n,
CONFIG_PANIC_ON_OOPS=y.

Loading the following kernel module will cause kernel panic.

The call stack is as follows:

root@(none):/# /root/insmod hello.ko
[    6.035003] hello: loading out-of-tree module taints kernel.
[    6.039129] ------------[ cut here ]------------
[    6.039287] hello
[    6.039704] Unexpected kernel BRK exception at EL1
[    6.040059] Internal error: BRK handler: 00000000f2000800 [#1] PREEMPT SMP
[    6.040457] Modules linked in: hello(O+)
[    6.041311] CPU: 0 PID: 50 Comm: insmod Tainted: G           O       6.9.1 #8
[    6.041755] Hardware name: linux,dummy-virt (DT)
[    6.042238] pstate: 60400005 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[    6.042594] pc : buginit+0x18/0x1000 [hello]
[    6.043601] lr : buginit+0x18/0x1000 [hello]
[    6.043852] sp : ffff800080533ae0
[    6.044121] x29: ffff800080533ae0 x28: 0000000000000000 x27: 0000000000000000
[    6.044523] x26: ffffaba8c4e70510 x25: ffff800080533c30 x24: ffffaba8c4a28a58
[    6.044961] x23: 0000000000000000 x22: 0000000000000000 x21: ffff3947c0eab3c0
[    6.045503] x20: ffffaba8c4e3f000 x19: ffffaba846464000 x18: 0000000000000006
[    6.046124] x17: 0000000000000000 x16: ffffaba8c2492834 x15: 0720072007200720
[    6.046387] x14: 0720072007200720 x13: ffffaba8c49b27c8 x12: 0000000000000312
[    6.046829] x11: 0000000000000106 x10: ffffaba8c4a0a7c8 x9 : ffffaba8c49b27c8
[    6.047293] x8 : 00000000ffffefff x7 : ffffaba8c4a0a7c8 x6 : 80000000fffff000
[    6.047739] x5 : 0000000000000107 x4 : 0000000000000000 x3 : 0000000000000000
[    6.047955] x2 : 0000000000000000 x1 : 0000000000000000 x0 : ffff3947c0eab3c0
[    6.048366] Call trace:
[    6.048653]  buginit+0x18/0x1000 [hello]
[    6.048922]  do_one_initcall+0x80/0x1c8
[    6.049333]  do_init_module+0x60/0x218
[    6.049475]  load_module+0x1ba4/0x1d70
[    6.049755]  __do_sys_init_module+0x198/0x1d0
[    6.049959]  __arm64_sys_init_module+0x1c/0x28
[    6.050160]  invoke_syscall+0x48/0x114
[    6.050334]  el0_svc_common.constprop.0+0x40/0xe0
[    6.050468]  do_el0_svc+0x1c/0x28
[    6.050635]  el0_svc+0x34/0xd8
[    6.050852]  el0t_64_sync_handler+0x120/0x12c
[    6.051088]  el0t_64_sync+0x190/0x194
[    6.051433] Code: d0ffffe0 910003fd 91000000 9400000b (d4210000)
[    6.052212] ---[ end trace 0000000000000000 ]---
[    6.052473] Kernel panic - not syncing: BRK handler: Fatal exception

The kernel module source code is as follows:
```

static int __init buginit(void)
{
	WARN(1, "hello\n");
	return 0;
}

static void __exit bugexit(void)
{
}

module_init(buginit);
module_exit(bugexit);
MODULE_LICENSE("GPL");
```

When CONFIG_DEBUG_BUGVERBOSE macro is disabled,
the size of "__bug_table" section in hello.ko
is only 6 bytes instead of the expected 8 bytes.
As a result,
mod->num_bugs = sechdrs[i].sh_size / sizeof(struct bug_entry) = 6 / 8 = 0
calculated in module_bug_finalize when the kernel loads ko is incorrect.

When running `WARN()`, the following backtrace is triggered:

module_find_bug() at lib/bug.c
find_bug() at lib/bug.c
__report_bug() at lib/bug.c
report_bug() at lib/bug.c
call_break_hook() at arch/arm64/kernel/debug-monitors.c
brk_handler() at arch/arm64/kernel/debug-monitors.c

It will return -EFAULT because hello.ko's mod->num_bugs is 0.
Finally, the kernel OOPS is triggered.

Add .align 2 to the end of __BUG_ENTRY
to make the object layout generated by the assembly code
consistent with that of the C struct bug_entry.

Fixes: 9fb7410f955f ("arm64/BUG: Use BRK instruction for generic BUG traps")

Signed-off-by: Yuanbin Xie <xieyuanbin1@huawei.com>
Signed-off-by: Jiangfeng Xiao <xiaojiangfeng@huawei.com>
---
 arch/arm64/include/asm/asm-bug.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/include/asm/asm-bug.h b/arch/arm64/include/asm/asm-bug.h
index c762038..6e73809 100644
--- a/arch/arm64/include/asm/asm-bug.h
+++ b/arch/arm64/include/asm/asm-bug.h
@@ -28,6 +28,7 @@
 	14470:	.long 14471f - .;			\
 _BUGVERBOSE_LOCATION(__FILE__, __LINE__)		\
 		.short flags; 				\
+		.align 2;				\
 		.popsection;				\
 	14471:
 #else
-- 
1.8.5.6


