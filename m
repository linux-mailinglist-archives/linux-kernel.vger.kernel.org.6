Return-Path: <linux-kernel+bounces-298727-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E7AF95CAB1
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 12:43:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B7C3E1C228B8
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 10:43:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FEE4186295;
	Fri, 23 Aug 2024 10:43:49 +0000 (UTC)
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6449D358A7;
	Fri, 23 Aug 2024 10:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724409828; cv=none; b=QrDzX0cCBsaBEscWGP9tSE4b4mFbeo1DGapCo7iIK3FJbcKJytBtA2Ftuv3QZFMXeBoJEQzblqPkd0WyFZxKm1M9KVwQLOgIRUNayhU3/m270DijYnIK3PndRQvd5lJeCP6udxfJk1QL7DVYFH8vA8enWrbt5nkj2ZQQaavmO30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724409828; c=relaxed/simple;
	bh=ELG4SbnY6u3dorUFMxcrz6mNZbq0MRumxaIVIb/Mg4g=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ObcRgRYMPILh2Uiof4i/NFph6JcSGIux4xRw/P55zOw1BWYlRwGJv0djvHc7r9FevFvrUoI7LVlPRgXkZaGwy00gdXcBdhx9g9qh38YT+eVbmQwRWH3t5tW1oHYu3ROJ1DcRGzIqk8zhzeFL7SCmtfcYPyvvBNAXZEAIskEKegc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.2.10.34])
	by gateway (Coremail) with SMTP id _____8AxSZreZ8hmlFYdAA--.25100S3;
	Fri, 23 Aug 2024 18:43:42 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.10.34])
	by front1 (Coremail) with SMTP id qMiowMCxC2faZ8hm3TgfAA--.40011S2;
	Fri, 23 Aug 2024 18:43:41 +0800 (CST)
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
Subject: [PATCH v11 6/7] irqchip/loongson-pch-msi: Prepare get_pch_msi_handle() for AVECINTC
Date: Fri, 23 Aug 2024 18:43:36 +0800
Message-Id: <20240823104337.25577-1-zhangtianyang@loongson.cn>
X-Mailer: git-send-email 2.20.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowMCxC2faZ8hm3TgfAA--.40011S2
X-CM-SenderInfo: x2kd0wxwld05hdqjqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoW7tFykCF15Aw1UXw13Ww4xKrX_yoW8Ary5pF
	W3C34jvr45Ca1UuFZ5X3y7Xry3AF93Ga97Jay0k3srXw1DC39YkF17J3ZrurWfAFW0gF1U
	ur4ktr4UCa1DA3XCm3ZEXasCq-sJn29KB7ZKAUJUUUUf529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUmIb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E
	14v26r4UJVWxJr1ln4kS14v26r126r1DM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6x
	kI12xvs2x26I8E6xACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v2
	6Fy26r45twAv7VC2z280aVAFwI0_Gr1j6F4UJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2
	IYc2Ij64vIr41lF7xvrVCFI7AF6II2Y40_Zr0_Gr1UMxkF7I0En4kS14v26r1q6r43MxAI
	w28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMxCIbckI1I0E14v26r126r1DMI
	8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AK
	xVW8ZVWrXwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26w1j6s0DMIIF0xvE2Ix0cI
	8IcVCY1x0267AKxVW8Jr0_Cr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E
	87Iv67AKxVW8Jr0_Cr1UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJbIYCTnIWIevJa
	73UjIFyTuYvjxUgc_-DUUUU

On Loongson-3C6000 and higher systems with AVECINTC irqchip, there may
be multiple PCI segments, but only one PCH-MSI irq domain. In this case,
let get_pch_msi_handle() return the first domain handle.

Co-developed-by: Jianmin Lv <lvjianmin@loongson.cn>
Signed-off-by: Jianmin Lv <lvjianmin@loongson.cn>
Co-developed-by: Liupu Wang <wangliupu@loongson.cn>
Signed-off-by: Liupu Wang <wangliupu@loongson.cn>
Co-developed-by: Huacai Chen <chenhuacai@loongson.cn>
Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
Signed-off-by: Tianyang Zhang <zhangtianyang@loongson.cn>
---
 drivers/irqchip/irq-loongson-pch-msi.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/irqchip/irq-loongson-pch-msi.c b/drivers/irqchip/irq-loongson-pch-msi.c
index d43731878800..0dc14550791d 100644
--- a/drivers/irqchip/irq-loongson-pch-msi.c
+++ b/drivers/irqchip/irq-loongson-pch-msi.c
@@ -255,17 +255,17 @@ IRQCHIP_DECLARE(pch_msi, "loongson,pch-msi-1.0", pch_msi_of_init);
 #ifdef CONFIG_ACPI
 struct fwnode_handle *get_pch_msi_handle(int pci_segment)
 {
-	int i;
+	if (cpu_has_avecint)
+		return pch_msi_handle[0];
 
-	for (i = 0; i < MAX_IO_PICS; i++) {
+	for (int i = 0; i < MAX_IO_PICS; i++) {
 		if (msi_group[i].pci_segment == pci_segment)
 			return pch_msi_handle[i];
 	}
-	return NULL;
+	return pch_msi_handle[0];
 }
 
-int __init pch_msi_acpi_init(struct irq_domain *parent,
-					struct acpi_madt_msi_pic *acpi_pchmsi)
+int __init pch_msi_acpi_init(struct irq_domain *parent, struct acpi_madt_msi_pic *acpi_pchmsi)
 {
 	int ret;
 	struct fwnode_handle *domain_handle;
-- 
2.20.1


