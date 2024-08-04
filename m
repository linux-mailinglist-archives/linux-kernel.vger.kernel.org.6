Return-Path: <linux-kernel+bounces-273857-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C63CD946EED
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Aug 2024 15:06:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A2FA2828CA
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Aug 2024 13:06:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07A3E13D298;
	Sun,  4 Aug 2024 13:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="zxh+VJPX";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="HzOE7jEn"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C216D13C8E2
	for <linux-kernel@vger.kernel.org>; Sun,  4 Aug 2024 13:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722776577; cv=none; b=qH4PCFg3xdpJaosy+oLF6LT9ERrL9Z0P/W3WEy3q/QRW8kuQx+cs2ZgdX892bT22W9XDxY988sT//lLMoqZAcNYJdyh54Sf5dG43NLRBTVO2WjUBcNG8F1wfKzdx3GYmvB/q7ur4O2UD9UGaNdJY6phFueB0/xC0Lpyci6dVhaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722776577; c=relaxed/simple;
	bh=tRLk/TvS98YdupTDjl9q7x/mMD7P/49029EJk8kt74Q=;
	h=From:To:Cc:Subject:Message-ID:Content-Type:MIME-Version:Date; b=giMkVqVEaDOR8W5GfMXLY9YlgdG10vLLbEs+or5OBYvGa4A9hPs3oqqeX2r3Omxb+YUarGA8e/B4miKeNAq2dj24hb4tdXXCCUrzoKQYVJCPD6jEKHdtvGQlsdKcTgwkAIuWA3HqipLIi37lgzCJnpkH1IwYLQoIgVm5xyj4IfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=zxh+VJPX; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=HzOE7jEn; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1722776572;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=MuN4xzF32bAtgY+PBsjK2SNDY6cWQFFqdFAOpv+mFMM=;
	b=zxh+VJPXQOwfz2VWujQ3TPwV9FVkayqOBkEpD5UCfDEkQYit2aBjioLI0biar4Hp0akSXX
	yPJHdFm/zWldVWegV/mmwyk0X4gnzs2aPFP6eL6l6FTdUsFMcdcBGY4XnNX9hfAhUivNc2
	cyF66oZYbftigAknroM7YpMj54dBIFzfuI5m3e/KIhW9/dZeiRNEi+tq31sDJvsYVvsZoV
	NFWvMOqzmi+32z3Omu7E4gW9dQp4Yq/eM1EnXb2Gv22rZeaENkqu5PRrBiIoK7tp63aAvX
	W4QTVMUZ4KfMqQ/vCQqWF0wDma8rXT5Hl0kC6YgwMW0B2lOjWUXq8gEEVTH9WA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1722776572;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=MuN4xzF32bAtgY+PBsjK2SNDY6cWQFFqdFAOpv+mFMM=;
	b=HzOE7jEn/8ratqM7S/PfjmGc54qU40+sI78syiBVhDF0IIx0NNhijuhMuJD3WoTKNCLeJA
	184BFqurnOq0AnAQ==
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [GIT pull] irq/urgent for v6.11-rc2
Message-ID: <172277654174.866296.10517632866315552419.tglx@xen13>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Sun,  4 Aug 2024 15:02:51 +0200 (CEST)

Linus,

please pull the latest irq/urgent branch from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq-urgent-2024-=
08-04

up to:  6be6cba9c437: irqchip/mbigen: Fix mbigen node address layout

A couple of fixes for interrupt chip drivers:

  - Ensure to skip the clear register space in the MBIGEN driver when
    calculating the node register index. Otherwise the clear register is
    clobbered and the wrong node registers are accessed.

  - Fix a signed/unsigned confusion in the loongarch CPU driver which
    converts an error code to a huge "valid" interrupt number.

  - Convert the mesion GPIO interrupt controller lock to a raw spinlock so
    it works on RT.

  - Add a missing static to a internal function in the pic32 EVIC driver.

Thanks,

	tglx

------------------>
Arseniy Krasnov (1):
      irqchip/meson-gpio: Convert meson_gpio_irq_controller::lock to 'raw_spi=
nlock_t'

Huacai Chen (1):
      irqchip/loongarch-cpu: Fix return value of lpic_gsi_to_irq()

Luca Ceresoli (1):
      irqchip/irq-pic32-evic: Add missing 'static' to internal function

Yipeng Zou (1):
      irqchip/mbigen: Fix mbigen node address layout


 drivers/irqchip/irq-loongarch-cpu.c |  6 ++++--
 drivers/irqchip/irq-mbigen.c        | 20 ++++++++++++++++----
 drivers/irqchip/irq-meson-gpio.c    | 14 +++++++-------
 drivers/irqchip/irq-pic32-evic.c    |  6 +++---
 4 files changed, 30 insertions(+), 16 deletions(-)

diff --git a/drivers/irqchip/irq-loongarch-cpu.c b/drivers/irqchip/irq-loonga=
rch-cpu.c
index 9d8f2c406043..b35903a06902 100644
--- a/drivers/irqchip/irq-loongarch-cpu.c
+++ b/drivers/irqchip/irq-loongarch-cpu.c
@@ -18,11 +18,13 @@ struct fwnode_handle *cpuintc_handle;
=20
 static u32 lpic_gsi_to_irq(u32 gsi)
 {
+	int irq =3D 0;
+
 	/* Only pch irqdomain transferring is required for LoongArch. */
 	if (gsi >=3D GSI_MIN_PCH_IRQ && gsi <=3D GSI_MAX_PCH_IRQ)
-		return acpi_register_gsi(NULL, gsi, ACPI_LEVEL_SENSITIVE, ACPI_ACTIVE_HIGH=
);
+		irq =3D acpi_register_gsi(NULL, gsi, ACPI_LEVEL_SENSITIVE, ACPI_ACTIVE_HIG=
H);
=20
-	return 0;
+	return (irq > 0) ? irq : 0;
 }
=20
 static struct fwnode_handle *lpic_get_gsi_domain_id(u32 gsi)
diff --git a/drivers/irqchip/irq-mbigen.c b/drivers/irqchip/irq-mbigen.c
index 093fd42893a7..53cc08387588 100644
--- a/drivers/irqchip/irq-mbigen.c
+++ b/drivers/irqchip/irq-mbigen.c
@@ -64,6 +64,20 @@ struct mbigen_device {
 	void __iomem		*base;
 };
=20
+static inline unsigned int get_mbigen_node_offset(unsigned int nid)
+{
+	unsigned int offset =3D nid * MBIGEN_NODE_OFFSET;
+
+	/*
+	 * To avoid touched clear register in unexpected way, we need to directly
+	 * skip clear register when access to more than 10 mbigen nodes.
+	 */
+	if (nid >=3D (REG_MBIGEN_CLEAR_OFFSET / MBIGEN_NODE_OFFSET))
+		offset +=3D MBIGEN_NODE_OFFSET;
+
+	return offset;
+}
+
 static inline unsigned int get_mbigen_vec_reg(irq_hw_number_t hwirq)
 {
 	unsigned int nid, pin;
@@ -72,8 +86,7 @@ static inline unsigned int get_mbigen_vec_reg(irq_hw_number=
_t hwirq)
 	nid =3D hwirq / IRQS_PER_MBIGEN_NODE + 1;
 	pin =3D hwirq % IRQS_PER_MBIGEN_NODE;
=20
-	return pin * 4 + nid * MBIGEN_NODE_OFFSET
-			+ REG_MBIGEN_VEC_OFFSET;
+	return pin * 4 + get_mbigen_node_offset(nid) + REG_MBIGEN_VEC_OFFSET;
 }
=20
 static inline void get_mbigen_type_reg(irq_hw_number_t hwirq,
@@ -88,8 +101,7 @@ static inline void get_mbigen_type_reg(irq_hw_number_t hwi=
rq,
 	*mask =3D 1 << (irq_ofst % 32);
 	ofst =3D irq_ofst / 32 * 4;
=20
-	*addr =3D ofst + nid * MBIGEN_NODE_OFFSET
-		+ REG_MBIGEN_TYPE_OFFSET;
+	*addr =3D ofst + get_mbigen_node_offset(nid) + REG_MBIGEN_TYPE_OFFSET;
 }
=20
 static inline void get_mbigen_clear_reg(irq_hw_number_t hwirq,
diff --git a/drivers/irqchip/irq-meson-gpio.c b/drivers/irqchip/irq-meson-gpi=
o.c
index 27e30ce41db3..cd789fa51519 100644
--- a/drivers/irqchip/irq-meson-gpio.c
+++ b/drivers/irqchip/irq-meson-gpio.c
@@ -178,7 +178,7 @@ struct meson_gpio_irq_controller {
 	void __iomem *base;
 	u32 channel_irqs[MAX_NUM_CHANNEL];
 	DECLARE_BITMAP(channel_map, MAX_NUM_CHANNEL);
-	spinlock_t lock;
+	raw_spinlock_t lock;
 };
=20
 static void meson_gpio_irq_update_bits(struct meson_gpio_irq_controller *ctl,
@@ -187,14 +187,14 @@ static void meson_gpio_irq_update_bits(struct meson_gpi=
o_irq_controller *ctl,
 	unsigned long flags;
 	u32 tmp;
=20
-	spin_lock_irqsave(&ctl->lock, flags);
+	raw_spin_lock_irqsave(&ctl->lock, flags);
=20
 	tmp =3D readl_relaxed(ctl->base + reg);
 	tmp &=3D ~mask;
 	tmp |=3D val;
 	writel_relaxed(tmp, ctl->base + reg);
=20
-	spin_unlock_irqrestore(&ctl->lock, flags);
+	raw_spin_unlock_irqrestore(&ctl->lock, flags);
 }
=20
 static void meson_gpio_irq_init_dummy(struct meson_gpio_irq_controller *ctl)
@@ -244,12 +244,12 @@ meson_gpio_irq_request_channel(struct meson_gpio_irq_co=
ntroller *ctl,
 	unsigned long flags;
 	unsigned int idx;
=20
-	spin_lock_irqsave(&ctl->lock, flags);
+	raw_spin_lock_irqsave(&ctl->lock, flags);
=20
 	/* Find a free channel */
 	idx =3D find_first_zero_bit(ctl->channel_map, ctl->params->nr_channels);
 	if (idx >=3D ctl->params->nr_channels) {
-		spin_unlock_irqrestore(&ctl->lock, flags);
+		raw_spin_unlock_irqrestore(&ctl->lock, flags);
 		pr_err("No channel available\n");
 		return -ENOSPC;
 	}
@@ -257,7 +257,7 @@ meson_gpio_irq_request_channel(struct meson_gpio_irq_cont=
roller *ctl,
 	/* Mark the channel as used */
 	set_bit(idx, ctl->channel_map);
=20
-	spin_unlock_irqrestore(&ctl->lock, flags);
+	raw_spin_unlock_irqrestore(&ctl->lock, flags);
=20
 	/*
 	 * Setup the mux of the channel to route the signal of the pad
@@ -567,7 +567,7 @@ static int meson_gpio_irq_of_init(struct device_node *nod=
e, struct device_node *
 	if (!ctl)
 		return -ENOMEM;
=20
-	spin_lock_init(&ctl->lock);
+	raw_spin_lock_init(&ctl->lock);
=20
 	ctl->base =3D of_iomap(node, 0);
 	if (!ctl->base) {
diff --git a/drivers/irqchip/irq-pic32-evic.c b/drivers/irqchip/irq-pic32-evi=
c.c
index 1d9bb28d13e5..277240325cbc 100644
--- a/drivers/irqchip/irq-pic32-evic.c
+++ b/drivers/irqchip/irq-pic32-evic.c
@@ -161,9 +161,9 @@ static int pic32_irq_domain_map(struct irq_domain *d, uns=
igned int virq,
 	return ret;
 }
=20
-int pic32_irq_domain_xlate(struct irq_domain *d, struct device_node *ctrlr,
-			   const u32 *intspec, unsigned int intsize,
-			   irq_hw_number_t *out_hwirq, unsigned int *out_type)
+static int pic32_irq_domain_xlate(struct irq_domain *d, struct device_node *=
ctrlr,
+				  const u32 *intspec, unsigned int intsize,
+				  irq_hw_number_t *out_hwirq, unsigned int *out_type)
 {
 	struct evic_chip_data *priv =3D d->host_data;
=20


