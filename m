Return-Path: <linux-kernel+bounces-243011-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 88555929045
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jul 2024 05:20:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ACA861C20F44
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jul 2024 03:20:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8B95DDC5;
	Sat,  6 Jul 2024 03:20:13 +0000 (UTC)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBB785C99
	for <linux-kernel@vger.kernel.org>; Sat,  6 Jul 2024 03:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720236013; cv=none; b=KdEd6vK/JZY5MKLQa3mzL+pUrbCMtEg798i25TA7Wecj4ke+dL6bzQ+6MO2dlHyOrFMZIxu9OBAiOqzgVKXiA5DA7JXoRVz9j0+ODhXPjirmhmfstPMaDs5my1q4mWWs4WncKEl9zNWlrb/bVDNokQ5YA8nhSsubihcJEx9v0LE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720236013; c=relaxed/simple;
	bh=9hj0vWBvaSYZ8tUJE3SE8hP7dskF3/KDmLYdCKHb3DE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=R7HReuhNbsTgQq3rr7KmsLo4mWCT/FxQlHfOHoVu2+qw6j4by30Xr3mLrbdZdQBWkC69x8/9n5nXWnNetA9AV5tVOtT1S6jmCokAuBlLaur+2vTML3s2VF+i2hUV/178F1kruXBpEFIFoA5T/2lNbduj91YxBrwDh75SgZTLshY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4WGFrK6JZlzwW2X;
	Sat,  6 Jul 2024 11:15:29 +0800 (CST)
Received: from kwepemm600011.china.huawei.com (unknown [7.193.23.229])
	by mail.maildlp.com (Postfix) with ESMTPS id DE4D21401E9;
	Sat,  6 Jul 2024 11:20:06 +0800 (CST)
Received: from huawei.com (10.67.133.142) by kwepemm600011.china.huawei.com
 (7.193.23.229) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Sat, 6 Jul
 2024 11:20:06 +0800
From: wanglinhui <wanglinhui@huawei.com>
To: Russell King <linux@armlinux.org.uk>, <rmk+kernel@armlinux.org.uk>, Andrew
 Morton <akpm@linux-foundation.org>, Kees Cook <kees@kernel.org>, Kefeng Wang
	<wangkefeng.wang@huawei.com>, Suren Baghdasaryan <surenb@google.com>
CC: Linus Walleij <linus.walleij@linaro.org>, Catalin Marinas
	<catalin.marinas@arm.com>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <wangfangpeng1@huawei.com>,
	<zhangxun38@huawei.com>, <yangzhuohao1@huawei.com>
Subject: [PATCH] ARM: Fix "external abort on non-linefetch" kernel panic caused by userspace
Date: Sat, 6 Jul 2024 11:20:05 +0800
Message-ID: <20240706032005.122654-1-wanglinhui@huawei.com>
X-Mailer: git-send-email 2.12.3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemm600011.china.huawei.com (7.193.23.229)

0x16800000 is a peripheral physical address that supports only
4-byte-aligned access.

Use /dev/mem to enable the user space to access 0x16800000. Then userspace
unexpectedly tried to read four bytes from 0x16800001 (actually access
its virtual address), which caused the kernel to trigger an
"external abort on non-linefetch" panic:

  Unhandled fault: external abort on non-linefetch (0x1018) at 0x0100129b
  [0100129b] *pgd=85038831, *pte=16801703, *ppte=16801e33
  Internal error: : 1018 [#1] SMP ARM
  ...
  CPU: 2 PID: xxxx Comm: xxxx Tainted: G           O      5.10.0 #1
  Hardware name: Hisilicon A9
  PC is at do_alignment_ldrstr+0xb8/0x100
  LR is at 0xc1f203fc
  psr: 200f0313
  sp : c7081ed4  ip : 00000008  fp : 00000011
  r10: b42250c8  r9 : c7081f0c  r8 : c7081fb0
  r7 : 0100129b  r6 : 00000004  r5 : 00000000  r4 : e5908000
  r3 : 00000000  r2 : c7081f0c  r1 : 200f0210  r0 : 0100129b
  Flags: nzCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment user
  Control: 1ac5387d  Table: 82c3c04a  DAC: 55555555
  Process LcnNCoreTask (pid: 4049, stack limit = 0x14066b0e)
  Call trace:
    do_alignment_ldrstr
    --do_alignment
    ----do_DataAbort
    ------__dabt_usr

It triggers a data abort exception twice. The first time occurs when
an unaligned address is accessed in user mode. The second time occurs
when the peripheral address is actually accessed in kernel mode,
and it crashes the kernel. However, the code location for the second
data abort is as follows:

  ```
  #define __get8_unaligned_check(ins, val, addr, err) \
  	__asm__(\
   ARM("1: "ins" %1, [%2], #1\n") \ <-- Second data abort is triggered here
   THUMB("1: "ins" %1, [%2]\n") \
   THUMB(" add %2, %2, #1\n") \
  	"2:\n" \
  	" .pushsection .text.fixup,\"ax\"\n" \
  ```

It is an exception table entry that can be fixed up.

There is another test that indicates that
"external abort on non-linefetch" needs to be fixed up.

Similarly, use /dev/mem to map 0x16800000 to the user space.
Pass 0x16800001 (actually passes its virtual address) to the
kernel via the write() system call and write 1 byte.
It also causes the kernel to trigger an
"external abort on non-linefetch" panic:

  Unhandled fault: external abort on non-linefetch (0x1018) at 0xb6f95000
  [b6f95000] *pgd=83fb6831, *pte=16800783, *ppte=16800e33
  Internal error: : 1018 [#1] SMP ARM
  ...
  CPU: 1 PID: xxxx Comm: xxxx Tainted: G           O      5.10.0 #1
  Hardware name: Hisilicon A9
  PC is at __get_user_1+0x14/0x20
  LR is at iov_iter_fault_in_readable+0x7c/0x198
  psr: 800b0213
  sp : c195be18  ip : 00000001  fp : c35a2478
  r10: c06b5260  r9 : 00000000  r8 : c356fee0
  r7 : ffffe000  r6 : b6f95000  r5 : 00000001  r4 : c195bf10
  r3 : b6f95000  r2 : f7f95000  r1 : beffffff  r0 : b6f95000
  Call trace looks like:
    __get_user_1
    --iov_iter_fault_in_readable
    ----generic_perform_write
    ------__generic_file_write_iter
    --------generic_file_write_iter

The location of the instruction that triggers the data abort
is as follows:
  ```
  ENTRY(__get_user_1)
  	check_uaccess r0, 1, r1, r2, __get_user_bad
  1: TUSER(ldrb) r2, [r0] <-- Data abort is triggered here
  	mov r0, #0
  	ret lr
  ENDPROC(__get_user_1)
  _ASM_NOKPROBE(__get_user_1)
  ```
It is also an exception table entry that can be fixed up.

Address passed in from user space should not crash the kernel.
Therefore, fixup_exception() is added to fix up such exception.

Fixes: 136848d4ca9c ("ARM: LPAE: Move the FSR definitions to separate files")

Signed-off-by: wanglinhui <wanglinhui@huawei.com>
---
 arch/arm/mm/fault.c      | 9 +++++++++
 arch/arm/mm/fsr-2level.c | 4 ++--
 2 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mm/fault.c b/arch/arm/mm/fault.c
index 67c425341a95..55776dcde015 100644
--- a/arch/arm/mm/fault.c
+++ b/arch/arm/mm/fault.c
@@ -558,6 +558,15 @@ do_bad(unsigned long addr, unsigned int fsr, struct pt_regs *regs)
 	return 1;
 }
 
+static int do_fixup_exception(unsigned long addr, unsigned int fsr,
+					struct pt_regs *regs)
+{
+	if (fixup_exception(regs))
+		return 0;
+
+	return 1;
+}
+
 struct fsr_info {
 	int	(*fn)(unsigned long addr, unsigned int fsr, struct pt_regs *regs);
 	int	sig;
diff --git a/arch/arm/mm/fsr-2level.c b/arch/arm/mm/fsr-2level.c
index f2be95197265..a80444db9b3e 100644
--- a/arch/arm/mm/fsr-2level.c
+++ b/arch/arm/mm/fsr-2level.c
@@ -12,9 +12,9 @@ static struct fsr_info fsr_info[] = {
 	{ do_translation_fault,	SIGSEGV, SEGV_MAPERR,	"section translation fault"	   },
 	{ do_bad,		SIGBUS,	 0,		"external abort on linefetch"	   },
 	{ do_page_fault,	SIGSEGV, SEGV_MAPERR,	"page translation fault"	   },
-	{ do_bad,		SIGBUS,	 0,		"external abort on non-linefetch"  },
+	{ do_fixup_exception,	SIGBUS,	 0,		"external abort on non-linefetch"  },
 	{ do_bad,		SIGSEGV, SEGV_ACCERR,	"section domain fault"		   },
-	{ do_bad,		SIGBUS,	 0,		"external abort on non-linefetch"  },
+	{ do_fixup_exception,	SIGBUS,	 0,		"external abort on non-linefetch"  },
 	{ do_bad,		SIGSEGV, SEGV_ACCERR,	"page domain fault"		   },
 	{ do_bad,		SIGBUS,	 0,		"external abort on translation"	   },
 	{ do_sect_fault,	SIGSEGV, SEGV_ACCERR,	"section permission fault"	   },
-- 
2.12.3


