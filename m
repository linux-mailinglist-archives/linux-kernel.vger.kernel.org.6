Return-Path: <linux-kernel+bounces-282273-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 61CC094E184
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Aug 2024 15:58:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF9A22815BE
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Aug 2024 13:58:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 933771494C2;
	Sun, 11 Aug 2024 13:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="1pEXuTN9";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="8R6kU5mn"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F8D6446AF
	for <linux-kernel@vger.kernel.org>; Sun, 11 Aug 2024 13:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723384690; cv=none; b=MWe0HXuorLuNV8r8v43HwO/WyEqULiPiQW4HhiV3Zf6rLK33a0HHbzNh0zlPhcW7Q2wT1IsL5KfnbmHYUBYMkqFblnRxyZ/sslMSDPqvlisoX2UVZkrVvo1oF+WqtIB9fvCaNo50RkZ1vxDfy0ZXEI92Y/4RuweeJSWVQjoXRHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723384690; c=relaxed/simple;
	bh=zT3OOJlYVDfoPxrzzG+NTlJeGXZLr9+6r1u1RnMuzlg=;
	h=From:To:Cc:Subject:Message-ID:Content-Type:MIME-Version:Date; b=E/+DVsEEJUVi/xeJ/VCjWK7BXLrtRFRYqGDJK7Qkh4JLKQDeOBAnM8hsSBrK8ca53npFTFHdFceZGmh/P7G43uxzfl00oK1kt1PqMBWXLQN7ihOqxe96qEcp1KsvQ8CIuO8szMGUCE0Ms3E5TIO+7oKaCk3y09I3/6SLDzmMAEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=1pEXuTN9; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=8R6kU5mn; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1723384686;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=8gyFGJW9F+p+UElimSfLYu8bLJB+gVwV+TcSEn1nU4I=;
	b=1pEXuTN9x8YY/AW+fim7wMXpwGZW/95+XMimURYOTr1fwIAvEyOhARA5ytzE0srsJsaWOf
	8oiCyIflNJxvM+NbO5bU5veFo8QtCDVMTflyFqyk7CWLSMkTQQY2SL+le3ootxSUqZ8rSj
	3xmSifIRZzf87Hu6DdRd/8ipLBTuZspNYK/p1YRPTeC4P62ade/4fHkV6rexjXOGt36vHs
	5TLyHWSTaStCLxDnNLjVncBHXkKC9xuNRJWtvExsP5hEOku8knHA9JhVhXkftOBPb6ECWl
	ev1W0PuteYnaZe67y6eRt9+vbozwWLjZfqMAsL+ISfXkvm2J5rYEmm4nea3hvw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1723384686;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=8gyFGJW9F+p+UElimSfLYu8bLJB+gVwV+TcSEn1nU4I=;
	b=8R6kU5mn5OV1ms5P9KddXpn/CEo7hW8wiRkoNaDP4VMB2o2xIcBbECmxMBDZADSRH41XNm
	ZfhjjimHo3O4VKBw==
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [GIT pull] irq/urgent for v6.11-rc3
Message-ID: 
 <172338466501.1168419.15927287413698158262.tglx@xen13.tec.linutronix.de>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Sun, 11 Aug 2024 15:58:05 +0200 (CEST)

Linus,

please pull the latest irq/urgent branch from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq-urgent-2024-=
08-11

up to:  03f9885c60ad: irqchip/riscv-aplic: Retrigger MSI interrupt on source =
configuration


Three small fixes for interrupt core and drivers:

    - The interrupt core fails to honor caller supplied affinity hints for
      non-managed interrupts and uses the system default affinity on
      startup instead. Set the missing flag in the descriptor to tell the
      core to use the provided affinity.

    - Fix a shift out of bounds error in the Xilinx driver

    - Handle switching to level trigger correctly in the RISCV APLIC
      driver. It failed to retrigger the interrupt which causes it to
      become stale.

Thanks,

	tglx

------------------>
Radhey Shyam Pandey (1):
      irqchip/xilinx: Fix shift out of bounds

Shay Drory (1):
      genirq/irqdesc: Honor caller provided affinity in alloc_desc()

Yong-Xuan Wang (1):
      irqchip/riscv-aplic: Retrigger MSI interrupt on source configuration


 drivers/irqchip/irq-riscv-aplic-msi.c | 32 +++++++++++++++++++++++++-------
 drivers/irqchip/irq-xilinx-intc.c     |  2 +-
 kernel/irq/irqdesc.c                  |  1 +
 3 files changed, 27 insertions(+), 8 deletions(-)

diff --git a/drivers/irqchip/irq-riscv-aplic-msi.c b/drivers/irqchip/irq-risc=
v-aplic-msi.c
index 028444af48bd..d7773f76e5d0 100644
--- a/drivers/irqchip/irq-riscv-aplic-msi.c
+++ b/drivers/irqchip/irq-riscv-aplic-msi.c
@@ -32,15 +32,10 @@ static void aplic_msi_irq_unmask(struct irq_data *d)
 	aplic_irq_unmask(d);
 }
=20
-static void aplic_msi_irq_eoi(struct irq_data *d)
+static void aplic_msi_irq_retrigger_level(struct irq_data *d)
 {
 	struct aplic_priv *priv =3D irq_data_get_irq_chip_data(d);
=20
-	/*
-	 * EOI handling is required only for level-triggered interrupts
-	 * when APLIC is in MSI mode.
-	 */
-
 	switch (irqd_get_trigger_type(d)) {
 	case IRQ_TYPE_LEVEL_LOW:
 	case IRQ_TYPE_LEVEL_HIGH:
@@ -59,6 +54,29 @@ static void aplic_msi_irq_eoi(struct irq_data *d)
 	}
 }
=20
+static void aplic_msi_irq_eoi(struct irq_data *d)
+{
+	/*
+	 * EOI handling is required only for level-triggered interrupts
+	 * when APLIC is in MSI mode.
+	 */
+	aplic_msi_irq_retrigger_level(d);
+}
+
+static int aplic_msi_irq_set_type(struct irq_data *d, unsigned int type)
+{
+	int rc =3D aplic_irq_set_type(d, type);
+
+	if (rc)
+		return rc;
+	/*
+	 * Updating sourcecfg register for level-triggered interrupts
+	 * requires interrupt retriggering when APLIC is in MSI mode.
+	 */
+	aplic_msi_irq_retrigger_level(d);
+	return 0;
+}
+
 static void aplic_msi_write_msg(struct irq_data *d, struct msi_msg *msg)
 {
 	unsigned int group_index, hart_index, guest_index, val;
@@ -130,7 +148,7 @@ static const struct msi_domain_template aplic_msi_templat=
e =3D {
 		.name			=3D "APLIC-MSI",
 		.irq_mask		=3D aplic_msi_irq_mask,
 		.irq_unmask		=3D aplic_msi_irq_unmask,
-		.irq_set_type		=3D aplic_irq_set_type,
+		.irq_set_type		=3D aplic_msi_irq_set_type,
 		.irq_eoi		=3D aplic_msi_irq_eoi,
 #ifdef CONFIG_SMP
 		.irq_set_affinity	=3D irq_chip_set_affinity_parent,
diff --git a/drivers/irqchip/irq-xilinx-intc.c b/drivers/irqchip/irq-xilinx-i=
ntc.c
index 238d3d344949..7e08714d507f 100644
--- a/drivers/irqchip/irq-xilinx-intc.c
+++ b/drivers/irqchip/irq-xilinx-intc.c
@@ -189,7 +189,7 @@ static int __init xilinx_intc_of_init(struct device_node =
*intc,
 		irqc->intr_mask =3D 0;
 	}
=20
-	if (irqc->intr_mask >> irqc->nr_irq)
+	if ((u64)irqc->intr_mask >> irqc->nr_irq)
 		pr_warn("irq-xilinx: mismatch in kind-of-intr param\n");
=20
 	pr_info("irq-xilinx: %pOF: num_irq=3D%d, edge=3D0x%x\n",
diff --git a/kernel/irq/irqdesc.c b/kernel/irq/irqdesc.c
index 07e99c936ba5..1dee88ba0ae4 100644
--- a/kernel/irq/irqdesc.c
+++ b/kernel/irq/irqdesc.c
@@ -530,6 +530,7 @@ static int alloc_descs(unsigned int start, unsigned int c=
nt, int node,
 				flags =3D IRQD_AFFINITY_MANAGED |
 					IRQD_MANAGED_SHUTDOWN;
 			}
+			flags |=3D IRQD_AFFINITY_SET;
 			mask =3D &affinity->mask;
 			node =3D cpu_to_node(cpumask_first(mask));
 			affinity++;


