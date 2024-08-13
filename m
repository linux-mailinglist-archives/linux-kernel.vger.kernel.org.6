Return-Path: <linux-kernel+bounces-284486-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B1A5A950183
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 11:48:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 35F981F21989
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 09:48:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D624117E919;
	Tue, 13 Aug 2024 09:48:36 +0000 (UTC)
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71EF916BE01
	for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 09:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723542516; cv=none; b=hSY/8w7LqmrkCxJCpL/m34BoTiqSw1X3RaHrxCKmdpUzlIl2PAx6r8FIxuOnCc912C7XCU+ixKvbvX8UMzrJZWsst5QmX6saEc+gxLru9hs7LzymatuWicX9bad4S4ybR0fD4Q/kdm1yCZ3JEt3Vp62NDvvs3oDgRIShLVEr5cs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723542516; c=relaxed/simple;
	bh=5eEQBLOKihWzM3QLvLfq+LLVS7GxmKbFaPn8j8IJ27Q=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=IgXTKJNK1iZj5kgsR+7aYd3yx0PvHxTsswHI7btKPcHuZ/wgKUIKM7mIDpeJFuB0y9W5bzx2LSHkZaGC+D34LuP///R/SjjJxIvHBKHnIgaRuuIm3IdPgYRPrpMWI93ug4brtWESZI7ZCJ68avlmkdQwbIRk3oqa+Nixqr7JmiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.2.5.213])
	by gateway (Coremail) with SMTP id _____8BxnpvwK7tm1SgSAA--.18857S3;
	Tue, 13 Aug 2024 17:48:32 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
	by front1 (Coremail) with SMTP id qMiowMDxnWfvK7tmegMSAA--.56069S2;
	Tue, 13 Aug 2024 17:48:31 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Huacai Chen <chenhuacai@kernel.org>
Cc: WANG Xuerui <kernel@xen0n.name>,
	loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	virtualization@lists.linux.dev
Subject: [PATCH] LoongArch: Fix AP booting issue in VM mode
Date: Tue, 13 Aug 2024 17:48:31 +0800
Message-Id: <20240813094831.678729-1-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowMDxnWfvK7tmegMSAA--.56069S2
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
	ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
	nUUI43ZEXa7xR_UUUUUUUUU==

If paravirt IPI is used, native IPI is still necessary for AP booting,
which is boot interface between OS and BIOS firmware, and the paravirt ipi
is used inside OS.

During AP boot stage, AP executes idle instruction and waits for interrupt
or SW events, if AP is woke up, it clears IPI interrupt and jumps to kernel
entry from HW mailbox. BP writes kernel entry address in the HW mailbox of
AP and sends IPI interrupt to notify AP.

Between BP writes HW mailbox and is ready to send IPI to AP, AP is woken
up by SW events and jumps to kernel entry, so ACTION_BOOT_CPU IPI
interrupt sent from BP will keep pending during AP booting. And native IPI
interrupt handler needs be registered so that it can clear pending native
IPI, else there will be endless IRQ handling during AP boot stage.

Here native ipi interrupt is initialized even if paravirt IPI is used.

Fixes: 74c16b2e2b0c ("LoongArch: KVM: Add PV IPI support on guest side")

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
---
 arch/loongarch/kernel/paravirt.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/arch/loongarch/kernel/paravirt.c b/arch/loongarch/kernel/paravirt.c
index 9c9b75b76f62..348920b25460 100644
--- a/arch/loongarch/kernel/paravirt.c
+++ b/arch/loongarch/kernel/paravirt.c
@@ -13,6 +13,9 @@ static int has_steal_clock;
 struct static_key paravirt_steal_enabled;
 struct static_key paravirt_steal_rq_enabled;
 static DEFINE_PER_CPU(struct kvm_steal_time, steal_time) __aligned(64);
+#ifdef CONFIG_SMP
+static struct smp_ops old_ops;
+#endif
 
 static u64 native_steal_clock(int cpu)
 {
@@ -55,6 +58,11 @@ static void pv_send_ipi_single(int cpu, unsigned int action)
 	int min, old;
 	irq_cpustat_t *info = &per_cpu(irq_stat, cpu);
 
+	if (unlikely(action == ACTION_BOOT_CPU)) {
+		old_ops.send_ipi_single(cpu, action);
+		return;
+	}
+
 	old = atomic_fetch_or(BIT(action), &info->message);
 	if (old)
 		return;
@@ -71,6 +79,12 @@ static void pv_send_ipi_mask(const struct cpumask *mask, unsigned int action)
 	__uint128_t bitmap = 0;
 	irq_cpustat_t *info;
 
+	if (unlikely(action == ACTION_BOOT_CPU)) {
+		/* Use native IPI to boot AP */
+		old_ops.send_ipi_mask(mask, action);
+		return;
+	}
+
 	if (cpumask_empty(mask))
 		return;
 
@@ -141,6 +155,8 @@ static void pv_init_ipi(void)
 {
 	int r, swi;
 
+	/* Init native ipi irq since AP booting uses it */
+	old_ops.init_ipi();
 	swi = get_percpu_irq(INT_SWI0);
 	if (swi < 0)
 		panic("SWI0 IRQ mapping failed\n");
@@ -179,6 +195,9 @@ int __init pv_ipi_init(void)
 		return 0;
 
 #ifdef CONFIG_SMP
+	old_ops.init_ipi	= mp_ops.init_ipi;
+	old_ops.send_ipi_single = mp_ops.send_ipi_single;
+	old_ops.send_ipi_mask	= mp_ops.send_ipi_mask;
 	mp_ops.init_ipi		= pv_init_ipi;
 	mp_ops.send_ipi_single	= pv_send_ipi_single;
 	mp_ops.send_ipi_mask	= pv_send_ipi_mask;

base-commit: 7c626ce4bae1ac14f60076d00eafe71af30450ba
-- 
2.39.3


