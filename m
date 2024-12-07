Return-Path: <linux-kernel+bounces-435869-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2358D9E7E1B
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Dec 2024 04:32:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D2AA81887511
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Dec 2024 03:32:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A061825761;
	Sat,  7 Dec 2024 03:31:55 +0000 (UTC)
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4218717C7C;
	Sat,  7 Dec 2024 03:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733542315; cv=none; b=jWvMOgMhpMG+weH9EPeE2MhlM6oSyWSjBQ/vW/19+hB6Kwxut2cFg486Xepjinv/nM02bwaRcIoO+XrLkjMminfFlM+s0sUQrWXKdZjsOuQhJbKgP+SDs6FVeEuxKocHjIJ0F2y82FdSLlzHvelyQmwv2esrZ+khDBGAyKFTPlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733542315; c=relaxed/simple;
	bh=c/zfDTlJjLWyLEAaKXkccdygHFnfSqWAximJP+kKsf8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=BT+U5JT4ADyiXGv/SmVqHB9jFU4o17KRHPwZ9HN7MWRo0CC6DnnTfj/Sr3JkPZA+lvFOSmhBp2dkmGywMqt/uGzhgXUAWZRczQM4p/diAj3zbOoUY2X1vY5Q4EgLIQQwQ4m+0llMZ50FxlNpchM9LzYx2Qt1Hjl4q6AJLv8iYE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.2.10.34])
	by gateway (Coremail) with SMTP id _____8CxieGmwVNnC7RSAA--.32789S3;
	Sat, 07 Dec 2024 11:31:50 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.10.34])
	by front1 (Coremail) with SMTP id qMiowMDxPEelwVNnjYJ5AA--.65188S2;
	Sat, 07 Dec 2024 11:31:49 +0800 (CST)
From: Tianyang Zhang <zhangtianyang@loongson.cn>
To: chenhuacai@kernel.org,
	kernel@xen0n.name,
	tglx@linutronix.de
Cc: loongarch@lists.linux.dev,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Tianyang Zhang <zhangtianyang@loongson.cn>
Subject: [PATCH] irqchip/loongarch-avec:Add multi-nodes topology support
Date: Sat,  7 Dec 2024 11:31:46 +0800
Message-Id: <20241207033146.20938-1-zhangtianyang@loongson.cn>
X-Mailer: git-send-email 2.20.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowMDxPEelwVNnjYJ5AA--.65188S2
X-CM-SenderInfo: x2kd0wxwld05hdqjqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoW7tr4kCFy5tF1fuFy7uw4rWFX_yoW8Kr1rpa
	y5Za45Jr4Ut3Z7WF9xK34DXry3Jr4xKrW7ta43C3W3WrZ8G34q9ry0qFy5ZF18C397Z3WF
	vr48JFWUu3W5ZFgCm3ZEXasCq-sJn29KB7ZKAUJUUUU5529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUk0b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6r4j6r4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYIkI8VC2zVCFFI0UMc
	02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUXVWUAwAv7VC2z280aVAF
	wI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JMxAIw28IcxkI7V
	AKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCj
	r7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6x
	IIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAI
	w20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x
	0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxU7_MaUUUUU

This patch enables the advanced interrupt controller function under
multiple-node of 3C600. The topology of the advanced interrupt controller
is consistent with NUMA node. We check the enable status of the node where
each CPU is located once when it goes online, which may cause some
additional operations, but it can ensure that the advanced interrupt
controller can still be used in situations where some CPUs cannot start

Signed-off-by: Tianyang Zhang <zhangtianyang@loongson.cn>
---
 drivers/irqchip/irq-loongarch-avec.c | 20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

diff --git a/drivers/irqchip/irq-loongarch-avec.c b/drivers/irqchip/irq-loongarch-avec.c
index 0f6e465dd309..9e30198fa7e4 100644
--- a/drivers/irqchip/irq-loongarch-avec.c
+++ b/drivers/irqchip/irq-loongarch-avec.c
@@ -56,6 +56,18 @@ struct avecintc_data {
 	unsigned int		moving;
 };
 
+static inline void avecintc_enable(void)
+{
+	u64 value;
+
+	if (!loongarch_avec.domain)
+		return;
+
+	value = iocsr_read64(LOONGARCH_IOCSR_MISC_FUNC);
+	value |= IOCSR_MISC_FUNC_AVEC_EN;
+	iocsr_write64(value, LOONGARCH_IOCSR_MISC_FUNC);
+}
+
 static inline void avecintc_ack_irq(struct irq_data *d)
 {
 }
@@ -127,6 +139,8 @@ static int avecintc_cpu_online(unsigned int cpu)
 
 	guard(raw_spinlock)(&loongarch_avec.lock);
 
+	avecintc_enable();
+
 	irq_matrix_online(loongarch_avec.vector_matrix);
 
 	pending_list_init(cpu);
@@ -339,7 +353,6 @@ static int __init irq_matrix_init(void)
 static int __init avecintc_init(struct irq_domain *parent)
 {
 	int ret, parent_irq;
-	unsigned long value;
 
 	raw_spin_lock_init(&loongarch_avec.lock);
 
@@ -378,14 +391,13 @@ static int __init avecintc_init(struct irq_domain *parent)
 				  "irqchip/loongarch/avecintc:starting",
 				  avecintc_cpu_online, avecintc_cpu_offline);
 #endif
-	value = iocsr_read64(LOONGARCH_IOCSR_MISC_FUNC);
-	value |= IOCSR_MISC_FUNC_AVEC_EN;
-	iocsr_write64(value, LOONGARCH_IOCSR_MISC_FUNC);
+	avecintc_enable();
 
 	return ret;
 
 out_remove_domain:
 	irq_domain_remove(loongarch_avec.domain);
+	loongarch_avec.domain = NULL;
 out_free_handle:
 	irq_domain_free_fwnode(loongarch_avec.fwnode);
 out:
-- 
2.20.1


