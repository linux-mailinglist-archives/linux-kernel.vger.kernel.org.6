Return-Path: <linux-kernel+bounces-272841-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BF7A9461BA
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 18:18:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DB5711F22795
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 16:18:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15F85200104;
	Fri,  2 Aug 2024 16:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="IZPHPvdj";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="cpmGYs0k"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48C251E287F
	for <linux-kernel@vger.kernel.org>; Fri,  2 Aug 2024 16:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722615352; cv=none; b=czoIvnGEdu8GNV5td/UwRxzFGpzR39Rj7auU6y5lzTP+1wByNLlaQmVNHF+XTbFKdjClnr7fgHoIlMJx4IaSZeLrUJp3C0055nJd/1LPbrospLLPTxDE/Bz3W25tulWzaglSBltqHJ+I4zBqUspOXTfp13dvWlhMwdVkN6qZ9Ms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722615352; c=relaxed/simple;
	bh=ApuFP7hUkB4GG2CDVVRZNYbtp2I1Rn1Ost0KRvUQ9vQ=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=DxarIfCsYqlhYrPs1u3E7IHO5ORGkulbqwxMXKW4JbfvGKKTkqMo2e+T6GMaOQvSs7nHQ/IYSQbKqqg7dox8bkSJhAxzAXlk3VMP5V8cCYqelLH/GqNwNpp+IlqF+4C6DuQ9CA+tIpJW+Ek5UEOuX4GLDDqiMk2vvr9aoC+L6xg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=IZPHPvdj; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=cpmGYs0k; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20240802155440.969619978@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1722615348;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=xqjWzalHB8Wp0VvFcAWCmZ5DG9g95Nn4RtzOchAdDo8=;
	b=IZPHPvdj2qjXXhnizchH12MLk8SVBYIJFw9FjEIxTca+9VLOqrIRl29YOzoP0a6gyyBV60
	5PfRSYiApHp4JBRfJ1GHNrJl35vjGZotd2HuwNiS/B9D25P/Juf/n2wxnNZlRnj+N3t1dX
	2TX2AHP7+wmWsUrN09jrBge5poJMPRYjSpCJ/KeVlf1/29n3MoLP8pFqnTRZSlAWko0BDl
	CvNKVhVgpu14r1fd5jwD7fwlcOdbT2u8PeN8EzKL1tnp6YCtzsLppoYjopFJptjsRcDj7+
	h5DUx/dQpJQdzVuCN5WmR2tVk7q1VAFVEK3tacJ+pcftGfMgnlmASN2o890xeA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1722615348;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=xqjWzalHB8Wp0VvFcAWCmZ5DG9g95Nn4RtzOchAdDo8=;
	b=cpmGYs0kGPvNrf5ipO8pbfpDUHqeGBr6h3OGcaEVZGEM9ddpNdcTkivSBqENUhhicfA7oP
	pOe90vlYvGMBEFCA==
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: x86@kernel.org
Subject: [patch 12/15] x86/ioapic: Cleanup comments
References: <20240802155038.556977544@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Fri,  2 Aug 2024 18:15:48 +0200 (CEST)

Use proper comment styles and shrink comments to their scope where
applicable.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/kernel/apic/io_apic.c |   86 +++++++++++++++++------------------------
 1 file changed, 37 insertions(+), 49 deletions(-)

--- a/arch/x86/kernel/apic/io_apic.c
+++ b/arch/x86/kernel/apic/io_apic.c
@@ -384,12 +384,12 @@ static void io_apic_modify_irq(struct mp
 	}
 }
 
+/*
+ * Synchronize the IO-APIC and the CPU by doing a dummy read from the
+ * IO-APIC
+ */
 static void io_apic_sync(struct irq_pin_list *entry)
 {
-	/*
-	 * Synchronize the IO-APIC and the CPU by doing
-	 * a dummy read from the IO-APIC
-	 */
 	struct io_apic __iomem *io_apic;
 
 	io_apic = io_apic_base(entry->apic);
@@ -442,17 +442,13 @@ static void __eoi_ioapic_pin(int apic, i
 
 		entry = entry1 = __ioapic_read_entry(apic, pin);
 
-		/*
-		 * Mask the entry and change the trigger mode to edge.
-		 */
+		/* Mask the entry and change the trigger mode to edge. */
 		entry1.masked = true;
 		entry1.is_level = false;
 
 		__ioapic_write_entry(apic, pin, entry1);
 
-		/*
-		 * Restore the previous level triggered entry.
-		 */
+		/* Restore the previous level triggered entry. */
 		__ioapic_write_entry(apic, pin, entry);
 	}
 }
@@ -1012,16 +1008,12 @@ static int pin_2_irq(int idx, int ioapic
 {
 	u32 gsi = mp_pin_to_gsi(ioapic, pin);
 
-	/*
-	 * Debugging check, we are in big trouble if this message pops up!
-	 */
+	/* Debugging check, we are in big trouble if this message pops up! */
 	if (mp_irqs[idx].dstirq != pin)
 		pr_err("broken BIOS or MPTABLE parser, ayiee!!\n");
 
 #ifdef CONFIG_X86_32
-	/*
-	 * PCI IRQ command line redirection. Yes, limits are hardcoded.
-	 */
+	/* PCI IRQ command line redirection. Yes, limits are hardcoded. */
 	if ((pin >= 16) && (pin <= 23)) {
 		if (pirq_entries[pin - 16] != -1) {
 			if (!pirq_entries[pin - 16]) {
@@ -1296,8 +1288,9 @@ void __init enable_IO_APIC(void)
 		/* See if any of the pins is in ExtINT mode */
 		struct IO_APIC_route_entry entry = ioapic_read_entry(apic, pin);
 
-		/* If the interrupt line is enabled and in ExtInt mode
-		 * I have found the pin where the i8259 is connected.
+		/*
+		 * If the interrupt line is enabled and in ExtInt mode I
+		 * have found the pin where the i8259 is connected.
 		 */
 		if (!entry.masked &&
 		    entry.delivery_mode == APIC_DELIVERY_MODE_EXTINT) {
@@ -1307,8 +1300,11 @@ void __init enable_IO_APIC(void)
 		}
 	}
  found_i8259:
-	/* Look to see what if the MP table has reported the ExtINT */
-	/* If we could not find the appropriate pin by looking at the ioapic
+
+	/*
+	 * Look to see what if the MP table has reported the ExtINT
+	 *
+	 * If we could not find the appropriate pin by looking at the ioapic
 	 * the i8259 probably is not connected the ioapic but give the
 	 * mptable a chance anyway.
 	 */
@@ -1348,9 +1344,7 @@ void native_restore_boot_irq_mode(void)
 		entry.destid_0_7	= apic_id & 0xFF;
 		entry.virt_destid_8_14	= apic_id >> 8;
 
-		/*
-		 * Add it to the IO-APIC irq-routing table:
-		 */
+		/* Add it to the IO-APIC irq-routing table */
 		ioapic_write_entry(ioapic_i8259.apic, ioapic_i8259.pin, entry);
 	}
 
@@ -1427,8 +1421,8 @@ static void __init setup_ioapic_ids_from
 		}
 
 		/*
-		 * We need to adjust the IRQ routing table
-		 * if the ID changed.
+		 * We need to adjust the IRQ routing table if the ID
+		 * changed.
 		 */
 		if (old_id != mpc_ioapic_id(ioapic_idx))
 			for (i = 0; i < mp_irq_entries; i++)
@@ -1437,8 +1431,8 @@ static void __init setup_ioapic_ids_from
 						= mpc_ioapic_id(ioapic_idx);
 
 		/*
-		 * Update the ID register according to the right value
-		 * from the MPC table if they are different.
+		 * Update the ID register according to the right value from
+		 * the MPC table if they are different.
 		 */
 		if (mpc_ioapic_id(ioapic_idx) == reg_00.bits.ID)
 			continue;
@@ -1562,21 +1556,17 @@ static int __init timer_irq_works(void)
  * so we 'resend' these IRQs via IPIs, to the same CPU. It's much
  * better to do it this way as thus we do not have to be aware of
  * 'pending' interrupts in the IRQ path, except at this point.
- */
-/*
- * Edge triggered needs to resend any interrupt
- * that was delayed but this is now handled in the device
- * independent code.
- */
-
-/*
- * Starting up a edge-triggered IO-APIC interrupt is
- * nasty - we need to make sure that we get the edge.
- * If it is already asserted for some reason, we need
- * return 1 to indicate that is was pending.
  *
- * This is not complete - we should be able to fake
- * an edge even if it isn't on the 8259A...
+ *
+ * Edge triggered needs to resend any interrupt that was delayed but this
+ * is now handled in the device independent code.
+ *
+ * Starting up a edge-triggered IO-APIC interrupt is nasty - we need to
+ * make sure that we get the edge.  If it is already asserted for some
+ * reason, we need return 1 to indicate that is was pending.
+ *
+ * This is not complete - we should be able to fake an edge even if it
+ * isn't on the 8259A...
  */
 static unsigned int startup_ioapic_irq(struct irq_data *data)
 {
@@ -1627,7 +1617,8 @@ static inline bool ioapic_prepare_move(s
 static inline void ioapic_finish_move(struct irq_data *data, bool moveit)
 {
 	if (unlikely(moveit)) {
-		/* Only migrate the irq if the ack has been received.
+		/*
+		 * Only migrate the irq if the ack has been received.
 		 *
 		 * On rare occasions the broadcast level triggered ack gets
 		 * delayed going to ioapics, and if we reprogram the
@@ -1904,14 +1895,13 @@ static inline void init_IO_APIC_traps(vo
 		cfg = irq_cfg(irq);
 		if (IO_APIC_IRQ(irq) && cfg && !cfg->vector) {
 			/*
-			 * Hmm.. We don't have an entry for this,
-			 * so default to an old-fashioned 8259
-			 * interrupt if we can..
+			 * Hmm.. We don't have an entry for this, so
+			 * default to an old-fashioned 8259 interrupt if we
+			 * can. Otherwise set the dummy interrupt chip.
 			 */
 			if (irq < nr_legacy_irqs())
 				legacy_pic->make_irq(irq);
 			else
-				/* Strange. Oh, well.. */
 				irq_set_chip(irq, &no_irq_chip);
 		}
 	}
@@ -2307,9 +2297,7 @@ void __init setup_IO_APIC(void)
 	for_each_ioapic(ioapic)
 		BUG_ON(mp_irqdomain_create(ioapic));
 
-	/*
-         * Set up IO-APIC IRQ routing.
-         */
+	/* Set up IO-APIC IRQ routing. */
 	x86_init.mpparse.setup_ioapic_ids();
 
 	sync_Arb_IDs();


