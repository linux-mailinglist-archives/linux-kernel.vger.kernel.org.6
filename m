Return-Path: <linux-kernel+bounces-298712-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 701DB95CA89
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 12:34:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D0E22873D4
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 10:34:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FAA218786A;
	Fri, 23 Aug 2024 10:33:48 +0000 (UTC)
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90E2C146A8A;
	Fri, 23 Aug 2024 10:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724409228; cv=none; b=Zt1m5rhAMFw5MwfPG2oraIF6TKgNkqSHalRAwKW1sE1e7LVLaw6b4P+bjawKIkBxnIc3ejHD3FEFgbSNqHRMY4RyS/h5RWqZoJgm0Y5sUOZ0Q4n8IrQ2TxM9zheiO1hYSeLI0eSx95P+hLDfw5tAPGYYL8nW5dOGeEFr4mi8Z5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724409228; c=relaxed/simple;
	bh=PQJfH19J2xKUDKoipY1oOreDp44yq9ODA+Dq2V9F8t8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=u0eYZxtxGa5o5GGJloT9zL2iRSNVeAjLRzfqZkebC9MQWftZEqkKES1pa9Pp1Db1ljMmYzfETKyHQxRxLY+JVZYbiP1syMeGz0DG1eW5QuaQpK6tR8UUZhSYGfyYMF97P9nvM2D5oTr3hq8a7YayztIkICwn3sRG3AZS2fvCry8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.2.10.34])
	by gateway (Coremail) with SMTP id _____8Cx+emIZchmulMdAA--.61802S3;
	Fri, 23 Aug 2024 18:33:44 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.10.34])
	by front1 (Coremail) with SMTP id qMiowMAxVOCDZchmmDYfAA--.5401S4;
	Fri, 23 Aug 2024 18:33:43 +0800 (CST)
From: Tianyang Zhang <zhangtianyang@loongson.cn>
To: corbet@lwn.net,
	alexs@kernel.org,
	chenhuacai@kernel.org,
	kernel@xen0n.name,
	tglx@linutronix.de,
	jiaxun.yang@flygoat.com,
	gaoliang@loongson.cn,
	wangliupu@loongson.cn,
	lvjianmin@loongson.cn,
	zhangtianyang@loongson.cn,
	yijun@loongson.cn,
	mhocko@suse.com,
	akpm@linux-foundation.org,
	dianders@chromium.org,
	maobibo@loongson.cn,
	xry111@xry111.site,
	zhaotianrui@loongson.cn,
	nathan@kernel.org,
	yangtiezhu@loongson.cn,
	zhoubinbin@loongson.cn
Cc: loongarch@lists.linux.dev,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Huacai Chen <chenhuacai@loongson.cn>
Subject: [PATCH v11 2/7] LoongArch: Define ARCH_IRQ_INIT_FLAGS as IRQ_NOPROBE
Date: Fri, 23 Aug 2024 18:33:31 +0800
Message-Id: <20240823103337.23602-3-zhangtianyang@loongson.cn>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20240823103337.23602-1-zhangtianyang@loongson.cn>
References: <20240823103337.23602-1-zhangtianyang@loongson.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowMAxVOCDZchmmDYfAA--.5401S4
X-CM-SenderInfo: x2kd0wxwld05hdqjqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoW7Krykuw15Kr4DWrW5Gr1ktFc_yoW8XFyrpr
	ZrAa4kXr48Gry8AFyDKa4fur15J3ZrGw4aga1j9FZ7urnrXw1Fqw18Jr9rXFyYgayFgFWF
	gFn5Ww1FqF4UXwbCm3ZEXasCq-sJn29KB7ZKAUJUUUUD529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUBIb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
	xVW8Jr0_Cr1UM2kKe7AKxVWUAVWUtwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07
	AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWU
	tVWrXwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7V
	AKI48JMxkF7I0En4kS14v26r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY
	6r1j6r4UMxCIbckI1I0E14v26r126r1DMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7
	xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWrXwCIc40Y0x0EwIxGrwCI42IY6xII
	jxv20xvE14v26ryj6F1UMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw2
	0EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x02
	67AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU8XTm3UUUUU==

From: Huacai Chen <chenhuacai@loongson.cn>

Currently we call irq_set_noprobe() in a loop for all IRQs, but indeed
it only works for IRQs below NR_IRQS_LEGACY because at init_IRQ() only
legacy interrupts have been allocated.

Instead, we can define ARCH_IRQ_INIT_FLAGS as IRQ_NOPROBE in asm/hwirq.h
and the core will automatically set the flag for all interrupts.

Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
Signed-off-by: Tianyang Zhang <zhangtianyang@loongson.cn>
---
 arch/loongarch/include/asm/hw_irq.h | 2 ++
 arch/loongarch/kernel/irq.c         | 3 ---
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/loongarch/include/asm/hw_irq.h b/arch/loongarch/include/asm/hw_irq.h
index af4f4e8fbd85..8156ffb67415 100644
--- a/arch/loongarch/include/asm/hw_irq.h
+++ b/arch/loongarch/include/asm/hw_irq.h
@@ -9,6 +9,8 @@
 
 extern atomic_t irq_err_count;
 
+#define ARCH_IRQ_INIT_FLAGS	IRQ_NOPROBE
+
 /*
  * interrupt-retrigger: NOP for now. This may not be appropriate for all
  * machines, we'll see ...
diff --git a/arch/loongarch/kernel/irq.c b/arch/loongarch/kernel/irq.c
index f4991c03514f..adac8fcbb2ac 100644
--- a/arch/loongarch/kernel/irq.c
+++ b/arch/loongarch/kernel/irq.c
@@ -102,9 +102,6 @@ void __init init_IRQ(void)
 	mp_ops.init_ipi();
 #endif
 
-	for (i = 0; i < NR_IRQS; i++)
-		irq_set_noprobe(i);
-
 	for_each_possible_cpu(i) {
 		page = alloc_pages_node(cpu_to_node(i), GFP_KERNEL, order);
 
-- 
2.20.1


