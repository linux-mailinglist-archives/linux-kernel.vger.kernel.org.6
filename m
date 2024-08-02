Return-Path: <linux-kernel+bounces-272843-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B29C9461BC
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 18:19:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0FEC0B215D3
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 16:19:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 800003DAC05;
	Fri,  2 Aug 2024 16:15:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="0C+gG6pe";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="V4WDdmyB"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BF7921C172
	for <linux-kernel@vger.kernel.org>; Fri,  2 Aug 2024 16:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722615354; cv=none; b=aUdliXJn7JmAVYGfhQ1Htlozx5BVEVKYIP5ZUuYJD2y3st806UXjNLbvUCfAH77C9STzjBdodqh/Szyx4Wwqmg4PteY8Qz/xCrBPi2me+6IJ2MWSjsW0l4HNFRBzVcJDfYF/OurcEJuAHQQrcXyfW308aXmltANA33KYlzm9WLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722615354; c=relaxed/simple;
	bh=aKnRE8XCnmYsngU4rasKpNzR8KBGebtek5iljmOC2vg=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=tJwn6a0GfFwKNAj5pswiabKU4iJ+/lKHnqzvs7Q7Cr1TqpfEtPfmXKqfpKX+4s4/NTlihXwtvpuH1MJIbeJFvglI5IH4HVVvjt9Iy6lg+gU4W4/5FbZ/ZER/srGzAuWKJW0jZJNG9GFEBoKAvMlgopVzzqutLAaGNbnuFb9DFxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=0C+gG6pe; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=V4WDdmyB; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20240802155441.095653193@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1722615351;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=6GYsl3eqYV89gvDpo27xAlUTU+8TVZWQ0p3I+1xqu4o=;
	b=0C+gG6peoDT17eQLzTn7D4udtKtobDFYq+AqZmewKHDl7FuWqpcZjAHgVS9/huEb+ILgpc
	NnWcQrp6Xk/h0udZq3eKKDAbXa87NeGyVeZEZ6COTsNugSt5HBgaRdonuCe/Ep4CKPOcFX
	zW4RTm5W5IY5m3f/nRV7sDlH0GzVdjkXXbH3QfSm4EdS9EjsQ2C+gFZN9rOG2cV4IKy9Xc
	nRi1+4neXw2WmRQEr79Kp9BL+Zy7IoG040ed8fDEIvYMOUVuGuyj41tNZobJUauRrTE0Co
	b3FrkDsMV/+Bg533RGpx6bbYekNB6PC/IDU/zxNvK6jDcKrdiVpFQPYYcVEHJA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1722615351;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=6GYsl3eqYV89gvDpo27xAlUTU+8TVZWQ0p3I+1xqu4o=;
	b=V4WDdmyBX72X1i0xIFKKx97bxGpwBN4qZ856kepQohLaYVTb2LItcZmKVKnudL4uhOUqe1
	d1qeWYEpPg5G+kAQ==
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: x86@kernel.org
Subject: [patch 14/15] x86/ioapic: Cleanup line breaks
References: <20240802155038.556977544@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Fri,  2 Aug 2024 18:15:50 +0200 (CEST)

80 character limit is history.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/kernel/apic/io_apic.c |   55 +++++++++++++----------------------------
 1 file changed, 18 insertions(+), 37 deletions(-)

--- a/arch/x86/kernel/apic/io_apic.c
+++ b/arch/x86/kernel/apic/io_apic.c
@@ -637,10 +637,8 @@ static int __init find_isa_irq_pin(int i
 	for (i = 0; i < mp_irq_entries; i++) {
 		int lbus = mp_irqs[i].srcbus;
 
-		if (test_bit(lbus, mp_bus_not_pci) &&
-		    (mp_irqs[i].irqtype == type) &&
+		if (test_bit(lbus, mp_bus_not_pci) && (mp_irqs[i].irqtype == type) &&
 		    (mp_irqs[i].srcbusirq == irq))
-
 			return mp_irqs[i].dstirq;
 	}
 	return -1;
@@ -653,8 +651,7 @@ static int __init find_isa_irq_apic(int
 	for (i = 0; i < mp_irq_entries; i++) {
 		int lbus = mp_irqs[i].srcbus;
 
-		if (test_bit(lbus, mp_bus_not_pci) &&
-		    (mp_irqs[i].irqtype == type) &&
+		if (test_bit(lbus, mp_bus_not_pci) && (mp_irqs[i].irqtype == type) &&
 		    (mp_irqs[i].srcbusirq == irq))
 			break;
 	}
@@ -907,8 +904,7 @@ static int alloc_irq_from_domain(struct
 		return -1;
 	}
 
-	return __irq_domain_alloc_irqs(domain, irq, 1,
-				       ioapic_alloc_attr_node(info),
+	return __irq_domain_alloc_irqs(domain, irq, 1, ioapic_alloc_attr_node(info),
 				       info, legacy, NULL);
 }
 
@@ -922,13 +918,12 @@ static int alloc_irq_from_domain(struct
  * PIRQs instead of reprogramming the interrupt routing logic. Thus there may be
  * multiple pins sharing the same legacy IRQ number when ACPI is disabled.
  */
-static int alloc_isa_irq_from_domain(struct irq_domain *domain,
-				     int irq, int ioapic, int pin,
+static int alloc_isa_irq_from_domain(struct irq_domain *domain, int irq, int ioapic, int pin,
 				     struct irq_alloc_info *info)
 {
-	struct mp_chip_data *data;
 	struct irq_data *irq_data = irq_get_irq_data(irq);
 	int node = ioapic_alloc_attr_node(info);
+	struct mp_chip_data *data;
 
 	/*
 	 * Legacy ISA IRQ has already been allocated, just add pin to
@@ -942,8 +937,7 @@ static int alloc_isa_irq_from_domain(str
 			return -ENOMEM;
 	} else {
 		info->flags |= X86_IRQ_ALLOC_LEGACY;
-		irq = __irq_domain_alloc_irqs(domain, irq, 1, node, info, true,
-					      NULL);
+		irq = __irq_domain_alloc_irqs(domain, irq, 1, node, info, true, NULL);
 		if (irq >= 0) {
 			irq_data = irq_domain_get_irq_data(domain, irq);
 			data = irq_data->chip_data;
@@ -1121,8 +1115,7 @@ int IO_APIC_get_PCI_irq_vector(int bus,
 		return -1;
 
 out:
-	return pin_2_irq(best_idx, best_ioapic, mp_irqs[best_idx].dstirq,
-			 IOAPIC_MAP_ALLOC);
+	return pin_2_irq(best_idx, best_ioapic, mp_irqs[best_idx].dstirq, IOAPIC_MAP_ALLOC);
 }
 EXPORT_SYMBOL(IO_APIC_get_PCI_irq_vector);
 
@@ -1293,14 +1286,12 @@ void __init enable_IO_APIC(void)
 		 * If the interrupt line is enabled and in ExtInt mode I
 		 * have found the pin where the i8259 is connected.
 		 */
-		if (!entry.masked &&
-		    entry.delivery_mode == APIC_DELIVERY_MODE_EXTINT) {
+		if (!entry.masked && entry.delivery_mode == APIC_DELIVERY_MODE_EXTINT) {
 			ioapic_i8259.apic = apic;
 			ioapic_i8259.pin  = pin;
-			goto found_i8259;
+			break;
 		}
 	}
- found_i8259:
 
 	/*
 	 * Look to see what if the MP table has reported the ExtINT
@@ -1496,8 +1487,7 @@ static void __init delay_with_tsc(void)
 	do {
 		rep_nop();
 		now = rdtsc();
-	} while ((now - start) < 40000000000ULL / HZ &&
-		time_before_eq(jiffies, end));
+	} while ((now - start) < 40000000000ULL / HZ &&	time_before_eq(jiffies, end));
 }
 
 static void __init delay_without_tsc(void)
@@ -1912,20 +1902,17 @@ static inline void init_IO_APIC_traps(vo
 /*
  * The local APIC irq-chip implementation:
  */
-
 static void mask_lapic_irq(struct irq_data *data)
 {
-	unsigned long v;
+	unsigned long v = apic_read(APIC_LVT0);
 
-	v = apic_read(APIC_LVT0);
 	apic_write(APIC_LVT0, v | APIC_LVT_MASKED);
 }
 
 static void unmask_lapic_irq(struct irq_data *data)
 {
-	unsigned long v;
+	unsigned long v = apic_read(APIC_LVT0);
 
-	v = apic_read(APIC_LVT0);
 	apic_write(APIC_LVT0, v & ~APIC_LVT_MASKED);
 }
 
@@ -1944,8 +1931,7 @@ static struct irq_chip lapic_chip __read
 static void lapic_register_intr(int irq)
 {
 	irq_clear_status_flags(irq, IRQ_LEVEL);
-	irq_set_chip_and_handler_name(irq, &lapic_chip, handle_edge_irq,
-				      "edge");
+	irq_set_chip_and_handler_name(irq, &lapic_chip, handle_edge_irq, "edge");
 }
 
 /*
@@ -2265,10 +2251,8 @@ static int mp_irqdomain_create(int ioapi
 		return -ENOMEM;
 	}
 
-	if (cfg->type == IOAPIC_DOMAIN_LEGACY ||
-	    cfg->type == IOAPIC_DOMAIN_STRICT)
-		ioapic_dynirq_base = max(ioapic_dynirq_base,
-					 gsi_cfg->gsi_end + 1);
+	if (cfg->type == IOAPIC_DOMAIN_LEGACY || cfg->type == IOAPIC_DOMAIN_STRICT)
+		ioapic_dynirq_base = max(ioapic_dynirq_base, gsi_cfg->gsi_end + 1);
 
 	return 0;
 }
@@ -2682,8 +2666,7 @@ static int find_free_ioapic_entry(void)
  * @gsi_base:	base of GSI associated with the IOAPIC
  * @cfg:	configuration information for the IOAPIC
  */
-int mp_register_ioapic(int id, u32 address, u32 gsi_base,
-		       struct ioapic_domain_cfg *cfg)
+int mp_register_ioapic(int id, u32 address, u32 gsi_base, struct ioapic_domain_cfg *cfg)
 {
 	bool hotplug = !!ioapic_initialized;
 	struct mp_ioapic_gsi *gsi_cfg;
@@ -2835,8 +2818,7 @@ static void mp_irqdomain_get_attr(u32 gs
 	if (info && info->ioapic.valid) {
 		data->is_level = info->ioapic.is_level;
 		data->active_low = info->ioapic.active_low;
-	} else if (__acpi_get_override_irq(gsi, &data->is_level,
-					   &data->active_low) < 0) {
+	} else if (__acpi_get_override_irq(gsi, &data->is_level, &data->active_low) < 0) {
 		/* PCI interrupts are always active low level triggered. */
 		data->is_level = true;
 		data->active_low = true;
@@ -2956,8 +2938,7 @@ void mp_irqdomain_deactivate(struct irq_
 			     struct irq_data *irq_data)
 {
 	/* It won't be called for IRQ with multiple IOAPIC pins associated */
-	ioapic_mask_entry(mp_irqdomain_ioapic_idx(domain),
-			  (int)irq_data->hwirq);
+	ioapic_mask_entry(mp_irqdomain_ioapic_idx(domain), (int)irq_data->hwirq);
 }
 
 int mp_irqdomain_ioapic_idx(struct irq_domain *domain)


