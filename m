Return-Path: <linux-kernel+bounces-571397-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CDEE9A6BCA8
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 15:12:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8BB343AD416
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 14:11:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E60D13D8A4;
	Fri, 21 Mar 2025 14:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="hRlxA1dD"
Received: from smtpbgbr1.qq.com (smtpbgbr1.qq.com [54.207.19.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ABBC38F80
	for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 14:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.207.19.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742566298; cv=none; b=h1uNSvb5Xk5r9DU0B270MbHDsAQdf4rpcN0uhRmVY0+1ZBhJGdux1kjagXOJLdiO8YGg2HEQTZHAhVsqT3NcutcfCSk/SMMvPOUsoI/Vd4pXKeyCvoGiIlc+wFlGd9UM+WkK8Fz/I+RcVm3loyRwS3Mxt4nF6IfmvvAHDDovKjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742566298; c=relaxed/simple;
	bh=8fMUp76T444bje/W45VHdUiPf9lotiASA/xY69OIqfI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=npXr4e8N+ZU+ZDq+PwFQXlkfpv1JV56XGUn6O+ZUJ4jJXBHOnuodPttPdnNSOh0GNPHJj9k/gvIol5CPXb54zpeIvhTAhVHhVJ373gi1YfJ8H7M0H12cbG7sYsmB8YPjLjLS9QWZmQ6gwzlgt6ObHatBSHtXKg1PGfFd82S8mLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=hRlxA1dD; arc=none smtp.client-ip=54.207.19.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1742566219;
	bh=ccIXduJ4dfdtMf/Dn3ItPL78KdsAYRi4RxbF/2CUsFs=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=hRlxA1dDC5vtuHPxw5BFSKsRm9+7sVPpz1yn1Nl0lL0g9uXDsO9ty+4hODFKkBIS4
	 vgNw889H+XFn4X8s87WEoO2C8jrvomEip2cU328MKfUqrsh04l6yyAf00IxAOq3SS2
	 xseAvSnbpr1je7PnWjz9yIlr4DNr0A4C/kpVtM0w=
X-QQ-mid: bizesmtpip2t1742566207tm3pwz1
X-QQ-Originating-IP: SSOKIJx+AXGyosOlrVF/ptcOrDYJv6nJKHEZam0Hf7w=
Received: from localhost.localdomain ( [localhost])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 21 Mar 2025 22:10:05 +0800 (CST)
X-QQ-SSF: 0002000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 18217267415120598276
From: WangYuli <wangyuli@uniontech.com>
To: chenhuacai@kernel.org,
	kernel@xen0n.name
Cc: wangyuli@uniontech.com,
	guanwentao@uniontech.com,
	wentao@uniontech.com,
	loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	zhangqing@loongson.cn,
	zhoubinbin@loongson.cn,
	lihui@loongson.cn,
	rdunlap@infradead.org,
	chenhuacai@loongson.cn,
	zhanjun@uniontech.com,
	niecheng1@uniontech.com
Subject: [PATCH v2] LoongArch: KGDB: Rework arch_kgdb_breakpoint() implementation
Date: Fri, 21 Mar 2025 22:10:01 +0800
Message-ID: <943E06D656E4E707+20250321141001.109916-1-wangyuli@uniontech.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtpip:uniontech.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: OB161YjlFY7FLADchKhVFssCpiaJ6Ya8+rm5rtumGkkDtz0/vy8pRO66
	sRvw7gWiReFkUEw8xuIng8gr0WQYK7FFWKKtLWX8jkqK3z1eb27MvtjQEREHXidi9HugB4u
	eQUQbQGeVPa8YnpqeMC4BnjaSu5KiNgDCa627IAV0U30XeVYWYTtiReok3q+sijwXkfeEzH
	YpbRzZPy6XsaGV7TC7bwwrS7uQFpSGSift+9QnuFyVyx//DC+++DbsEOchLUWycsoyrBfHS
	+sUomSGFDj7Q6ycZezQ21xftm5N+m6oy2WKpdF1YOfbYa+EMxSoYrBpOyBa4pxN3G7N8kpF
	JahqnhtGhcxvIjYfLBvbN7nvc7ijHX1Dzer23iPuwLKk8c+61+3yx34CBtT337WFSv8Do6u
	a98SymRNL0iHMCQJCKJhIJ6RCMP64t/KxRrX8s4/NDzY3zFjvYcRaX4cZFA/ayjjkmNP/de
	CL0BcyDaH6VwQo9CL0Z+glgWaeqRnHw09eaukQ5VYlFC+lK6WqZ7H2R0LdmD/+9a71FV2mp
	f3muamajTrcoKqqm32e+T/mbka3QjyBt1LJiG9jLQIQQxHd7tsyT58jyTPbpguukzUgC/Uc
	WZh0GH3DV1t2pagSHR/cNJKeEhDQIHypBTJkba85QYvhVAJyu8tJkRLXFOa2CRYH6iLEkds
	06ZNxB5+/9UaGBZzVV+sTtEpzacL5AUOUcVaP5qiNk1/VouMOUB95iEx26LrmncEnG+7l/R
	0Q/fKUcOeyXkhaJePhpCZGZOv6esi08hbbpvwhVRjAysIuQpKTbewzwv3p9WKXkO1jbE9sO
	vwnPU9Lz0Fl9Oug5iLM3ADFN9UnwrlN1oh1eJrJxZWvQZhJZUgitD1hrtq4VtvTpg5tVQeQ
	cDvZFkI2+xOZPEDbXMPUaG3izw4rNRP2zFPg0KPAt8iiop/YfS/knTOQvcTOY3njH+9cwsK
	SyJZ0VCYY1+H2MjdVNp2ljmg9CjqUkIq/pPyNdz5smo+Rq8f081Dwq9rX5Is+CDHCpQ3AFw
	XvfMZY0g2kkmD0VzINV7Y2cB3S/USyA4BIYJ2TUoG2dO5moeVbwuHqHo4PECg=
X-QQ-XMRINFO: OWPUhxQsoeAVDbp3OJHYyFg=
X-QQ-RECHKSPAM: 0

The arch_kgdb_breakpoint() function defines the kgdb_breakinst
symbol using inline assembly.

There's a potential issue where the compiler might inline
arch_kgdb_breakpoint(), which would then define the kgdb_breakinst
symbol multiple times, leading to a linker error.

To prevent this, declare arch_kgdb_breakpoint() as noline.

Fix follow error with LLVM-19 *only* when LTO_CLANG_FULL:
    LD      vmlinux.o
  ld.lld-19: error: ld-temp.o <inline asm>:3:1: symbol 'kgdb_breakinst' is already defined
  kgdb_breakinst: break 2
  ^

Additionally, remove "nop" here because it's meaningless for LoongArch
here.

Fixes: e14dd076964e ("LoongArch: Add basic KGDB & KDB support")
Co-developed-by: Winston Wen <wentao@uniontech.com>
Signed-off-by: Winston Wen <wentao@uniontech.com>
Co-developed-by: Wentao Guan <guanwentao@uniontech.com>
Signed-off-by: Wentao Guan <guanwentao@uniontech.com>
Co-developed-by: Huacai Chen <chenhuacai@loongson.cn>
Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
Tested-by: Yuli Wang <wangyuli@uniontech.com>
Tested-by: Binbin Zhou <zhoubinbin@loongson.cn>
Signed-off-by: Yuli Wang <wangyuli@uniontech.com>
---
Changelog:
 *v1->v2:
    1. Drop the nop which is no effect for LoongArch here.
    2. Add "STACK_FRAME_NON_STANDARD" for arch_kgdb_breakpoint() to
avoid the objtool warning.
---
 arch/loongarch/kernel/kgdb.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/loongarch/kernel/kgdb.c b/arch/loongarch/kernel/kgdb.c
index 445c452d72a7..38bd0561d7d5 100644
--- a/arch/loongarch/kernel/kgdb.c
+++ b/arch/loongarch/kernel/kgdb.c
@@ -224,13 +224,13 @@ void kgdb_arch_set_pc(struct pt_regs *regs, unsigned long pc)
 	regs->csr_era = pc;
 }
 
-void arch_kgdb_breakpoint(void)
+noinline void arch_kgdb_breakpoint(void)
 {
 	__asm__ __volatile__ (			\
 		".globl kgdb_breakinst\n\t"	\
-		"nop\n"				\
 		"kgdb_breakinst:\tbreak 2\n\t"); /* BRK_KDB = 2 */
 }
+STACK_FRAME_NON_STANDARD(arch_kgdb_breakpoint);
 
 /*
  * Calls linux_debug_hook before the kernel dies. If KGDB is enabled,
-- 
2.49.0


