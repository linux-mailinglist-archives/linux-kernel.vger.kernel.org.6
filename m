Return-Path: <linux-kernel+bounces-293976-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36D08958722
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 14:38:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 48FA21C21B54
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 12:38:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61B98190471;
	Tue, 20 Aug 2024 12:37:42 +0000 (UTC)
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F37F318FC90
	for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 12:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724157462; cv=none; b=jOXwVtLVss/at6XtBvNL8Ap2h0D1c3lTfMQcX1aggcrvXD2y7NO1uJC/bwNDMUBnln29HmkjNQ9qk3h+6LnV2wiYESWBsOsZ2/pe7wmU2OhTt1j/l5k22yY0jyhzXlbF3m5mrVM2pgJl6f1BBnlge1Dii3V4f7mTvM/tB6S4XCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724157462; c=relaxed/simple;
	bh=t9x4TYYD0UVihjjijunrAnfnxESPR+7kSgN2YaQSQ9I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VUcqB+cdAiJGkmKUaRZAd8ksji3VwDWj6wDDwH8KWH9o7NcdXzRgQqT5lJ+p6BRIKM4Iu2EWUskTgfZLxR1VJRqdRvloP1INOQzDN5x3iSdvNg+Zykk3YcK4ILPdsWgTO4r+l13KtaLWEuT+qA6lxysQFj3y9QTKNDSQgzaupB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [113.200.148.30])
	by gateway (Coremail) with SMTP id _____8CxrpsRjsRmySYaAA--.30979S3;
	Tue, 20 Aug 2024 20:37:37 +0800 (CST)
Received: from linux.localdomain (unknown [113.200.148.30])
	by front1 (Coremail) with SMTP id qMiowMDxkeEMjsRmL5MbAA--.56855S4;
	Tue, 20 Aug 2024 20:37:36 +0800 (CST)
From: Tiezhu Yang <yangtiezhu@loongson.cn>
To: Huacai Chen <chenhuacai@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>,
	loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 2/2] LoongArch: Add ifdefs to fix LSX and LASX related issues
Date: Tue, 20 Aug 2024 20:37:31 +0800
Message-ID: <20240820123731.31568-3-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240820123731.31568-1-yangtiezhu@loongson.cn>
References: <20240820123731.31568-1-yangtiezhu@loongson.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowMDxkeEMjsRmL5MbAA--.56855S4
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoWxuF1kGr1fur43GrWxWr4fCrX_yoW5XFWrpr
	9xCrs5Kr45WFn2y3yDZwn5WFZ0ka97Gr1agF4qy34fCF4qqFnrXr18tFn8XFyjgws7Ja1F
	gFWrGw4YqayUAwbCm3ZEXasCq-sJn29KB7ZKAUJUUUUr529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUU9Fb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
	xVW8Jr0_Cr1UM2kKe7AKxVWUXVWUAwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07
	AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWU
	tVWrXwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7V
	AKI48JMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMxCIbckI1I0E14v2
	6r1Y6r17MI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17
	CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r4j6ryUMIIF
	0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIx
	AIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2
	KfnxnUUI43ZEXa7IU8EeHDUUUUU==

There exist some issues when building kernel if CONFIG_CPU_HAS_LBT is set
but CONFIG_CPU_HAS_LSX and CONFIG_CPU_HAS_LASX are not set. In this case,
there are no definitions of _restore_lsx and _restore_lasx and there are
also no definitions of kvm_restore_lsx and kvm_restore_lasx in fpu.S and
switch.S respectively, just add some ifdefs to fix the issues.

  AS      arch/loongarch/kernel/fpu.o
arch/loongarch/kernel/fpu.o: warning: objtool: unexpected relocation symbol type in .rela.discard.func_stack_frame_non_standard: 0
arch/loongarch/kernel/fpu.o: warning: objtool: unexpected relocation symbol type in .rela.discard.func_stack_frame_non_standard: 0

  AS [M]  arch/loongarch/kvm/switch.o
arch/loongarch/kvm/switch.o: warning: objtool: unexpected relocation symbol type in .rela.discard.func_stack_frame_non_standard: 0
arch/loongarch/kvm/switch.o: warning: objtool: unexpected relocation symbol type in .rela.discard.func_stack_frame_non_standard: 0

  MODPOST Module.symvers
ERROR: modpost: "kvm_restore_lsx" [arch/loongarch/kvm/kvm.ko] undefined!
ERROR: modpost: "kvm_restore_lasx" [arch/loongarch/kvm/kvm.ko] undefined!

Cc: stable@vger.kernel.org # 6.9+
Fixes: cb8a2ef0848c ("LoongArch: Add ORC stack unwinder support")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202408120955.qls5oNQY-lkp@intel.com/
Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
---
 arch/loongarch/kernel/fpu.S | 4 ++++
 arch/loongarch/kvm/switch.S | 4 ++++
 2 files changed, 8 insertions(+)

diff --git a/arch/loongarch/kernel/fpu.S b/arch/loongarch/kernel/fpu.S
index 69a85f2479fb..6ab640101457 100644
--- a/arch/loongarch/kernel/fpu.S
+++ b/arch/loongarch/kernel/fpu.S
@@ -530,6 +530,10 @@ SYM_FUNC_END(_restore_lasx_context)
 
 #ifdef CONFIG_CPU_HAS_LBT
 STACK_FRAME_NON_STANDARD _restore_fp
+#ifdef CONFIG_CPU_HAS_LSX
 STACK_FRAME_NON_STANDARD _restore_lsx
+#endif
+#ifdef CONFIG_CPU_HAS_LASX
 STACK_FRAME_NON_STANDARD _restore_lasx
 #endif
+#endif
diff --git a/arch/loongarch/kvm/switch.S b/arch/loongarch/kvm/switch.S
index 80e988985a6a..0c292f818492 100644
--- a/arch/loongarch/kvm/switch.S
+++ b/arch/loongarch/kvm/switch.S
@@ -277,6 +277,10 @@ SYM_DATA(kvm_enter_guest_size, .quad kvm_enter_guest_end - kvm_enter_guest)
 
 #ifdef CONFIG_CPU_HAS_LBT
 STACK_FRAME_NON_STANDARD kvm_restore_fpu
+#ifdef CONFIG_CPU_HAS_LSX
 STACK_FRAME_NON_STANDARD kvm_restore_lsx
+#endif
+#ifdef CONFIG_CPU_HAS_LASX
 STACK_FRAME_NON_STANDARD kvm_restore_lasx
 #endif
+#endif
-- 
2.42.0


