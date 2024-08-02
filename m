Return-Path: <linux-kernel+bounces-272835-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B4169461B2
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 18:17:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 78D941F200E7
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 16:17:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2A6D1A34B8;
	Fri,  2 Aug 2024 16:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Q+sW0RFb";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ihoDIcVy"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1A9E15C146
	for <linux-kernel@vger.kernel.org>; Fri,  2 Aug 2024 16:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722615348; cv=none; b=Hvo6K9ipfhXN9RZUOD4CRomiUyjPAq7BdwPVzsx6GXUQudxAakFCAUGFx7oFzNVJUOD9sYZA+JUMvEzVFy6kEB/fXnj3NWOfyxzoaKLOQvHozgxYyxegLikzpGWllqt6jeU7QMhYk/KLMheF8DhsSEvfbl1lygFnA4GHI2NTPKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722615348; c=relaxed/simple;
	bh=o5XxEacxAZN8DGWVu6+iKEr80J1VWWCTqBEU5PKTzM8=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=Qoeio+HeM5hzg3tqZ1nQxH1u0pW0qZGzGjuTw+B5bJfpGzSi3J3s711oUHCLVX0q722qHSP06PsB/5s46Vueu2/IIppiI485tBw6iyLS+xcWKi1vvP/4sdOnHHrY4Fk3dSmM2Kk/+kQUI33l3ZME117ONmO8wnRvalcckNW1Fcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Q+sW0RFb; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ihoDIcVy; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20240802155440.714763708@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1722615343;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=/AChwy4D2Z7ZJmgJ7d3iZD2+yd7etU8zolVSlXE4sZg=;
	b=Q+sW0RFblTFhYmwXU5vE6tteQFOFaVHhkWqrDJwdXDtDC/0V6uOJ2Z2ggiJ2KSOEsvUO8q
	sZqKDBhsc9c47IlbiQXChO5M+l+NjPJHYPuPWw8tm64gkUekOo7wJ+5gb7aL9FQ15C+T7F
	VOWUKKjEa2Q4ZTGKgIF4RN90JpJoT+N18FLqXo00fsctbambpBcdZY2RYKAKmU/2B+WJo0
	upiEb/MrR70rh6FISl87KkEN3pyoiD0vRTOxKrzOhxhrk1hHG1P0LAJD3boptIPA5+SRpt
	Hcn8URFa9t8818DByTTA/hc/AYUKeBZnpFx65/Ap4xCDQ8EhCCls67Ok8w9ERA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1722615343;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=/AChwy4D2Z7ZJmgJ7d3iZD2+yd7etU8zolVSlXE4sZg=;
	b=ihoDIcVywzYbsAb9J0iWNHLA9iMJNnblQtcPalrVRSmJlLc/11rAvMBQRLDM+ZMeityRkO
	fQyvkuv9kOrEowCA==
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: x86@kernel.org
Subject: [patch 08/15] x86/ioapic: Cleanup guarded debug printk()s
References: <20240802155038.556977544@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Fri,  2 Aug 2024 18:15:43 +0200 (CEST)

Cleanup the APIC printk()s which are inside of a apic verbosity guarded
region by using apic_dbg() for the KERN_DEBUG level prints.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/kernel/apic/io_apic.c |   67 +++++++++++++++++------------------------
 1 file changed, 29 insertions(+), 38 deletions(-)

--- a/arch/x86/kernel/apic/io_apic.c
+++ b/arch/x86/kernel/apic/io_apic.c
@@ -1186,26 +1186,21 @@ static void io_apic_print_entries(unsign
 	char buf[256];
 	int i;
 
-	printk(KERN_DEBUG "IOAPIC %d:\n", apic);
+	apic_dbg("IOAPIC %d:\n", apic);
 	for (i = 0; i <= nr_entries; i++) {
 		entry = ioapic_read_entry(apic, i);
-		snprintf(buf, sizeof(buf),
-			 " pin%02x, %s, %s, %s, V(%02X), IRR(%1d), S(%1d)",
-			 i,
-			 entry.masked ? "disabled" : "enabled ",
+		snprintf(buf, sizeof(buf)," pin%02x, %s, %s, %s, V(%02X), IRR(%1d), S(%1d)",
+			 i, entry.masked ? "disabled" : "enabled ",
 			 entry.is_level ? "level" : "edge ",
 			 entry.active_low ? "low " : "high",
 			 entry.vector, entry.irr, entry.delivery_status);
 		if (entry.ir_format) {
-			printk(KERN_DEBUG "%s, remapped, I(%04X),  Z(%X)\n",
-			       buf,
-			       (entry.ir_index_15 << 15) | entry.ir_index_0_14,
-				entry.ir_zero);
+			apic_dbg("%s, remapped, I(%04X),  Z(%X)\n", buf,
+				 (entry.ir_index_15 << 15) | entry.ir_index_0_14, entry.ir_zero);
 		} else {
-			printk(KERN_DEBUG "%s, %s, D(%02X%02X), M(%1d)\n", buf,
-			       entry.dest_mode_logical ? "logical " : "physical",
-			       entry.virt_destid_8_14, entry.destid_0_7,
-			       entry.delivery_mode);
+			apic_dbg("%s, %s, D(%02X%02X), M(%1d)\n", buf,
+				 entry.dest_mode_logical ? "logical " : "physic	al",
+				 entry.virt_destid_8_14, entry.destid_0_7, entry.delivery_mode);
 		}
 	}
 }
@@ -1226,19 +1221,15 @@ static void __init print_IO_APIC(int ioa
 			reg_03.raw = io_apic_read(ioapic_idx, 3);
 	}
 
-	printk(KERN_DEBUG "IO APIC #%d......\n", mpc_ioapic_id(ioapic_idx));
-	printk(KERN_DEBUG ".... register #00: %08X\n", reg_00.raw);
-	printk(KERN_DEBUG ".......    : physical APIC id: %02X\n", reg_00.bits.ID);
-	printk(KERN_DEBUG ".......    : Delivery Type: %X\n", reg_00.bits.delivery_type);
-	printk(KERN_DEBUG ".......    : LTS          : %X\n", reg_00.bits.LTS);
-
-	printk(KERN_DEBUG ".... register #01: %08X\n", *(int *)&reg_01);
-	printk(KERN_DEBUG ".......     : max redirection entries: %02X\n",
-		reg_01.bits.entries);
-
-	printk(KERN_DEBUG ".......     : PRQ implemented: %X\n", reg_01.bits.PRQ);
-	printk(KERN_DEBUG ".......     : IO APIC version: %02X\n",
-		reg_01.bits.version);
+	apic_dbg("IO APIC #%d......\n", mpc_ioapic_id(ioapic_idx));
+	apic_dbg(".... register #00: %08X\n", reg_00.raw);
+	apic_dbg(".......    : physical APIC id: %02X\n", reg_00.bits.ID);
+	apic_dbg(".......    : Delivery Type: %X\n", reg_00.bits.delivery_type);
+	apic_dbg(".......    : LTS          : %X\n", reg_00.bits.LTS);
+	apic_dbg(".... register #01: %08X\n", *(int *)&reg_01);
+	apic_dbg(".......     : max redirection entries: %02X\n",reg_01.bits.entries);
+	apic_dbg(".......     : PRQ implemented: %X\n", reg_01.bits.PRQ);
+	apic_dbg(".......     : IO APIC version: %02X\n", reg_01.bits.version);
 
 	/*
 	 * Some Intel chipsets with IO APIC VERSION of 0x1? don't have reg_02,
@@ -1246,8 +1237,8 @@ static void __init print_IO_APIC(int ioa
 	 * value, so ignore it if reg_02 == reg_01.
 	 */
 	if (reg_01.bits.version >= 0x10 && reg_02.raw != reg_01.raw) {
-		printk(KERN_DEBUG ".... register #02: %08X\n", reg_02.raw);
-		printk(KERN_DEBUG ".......     : arbitration: %02X\n", reg_02.bits.arbitration);
+		apic_dbg(".... register #02: %08X\n", reg_02.raw);
+		apic_dbg(".......     : arbitration: %02X\n", reg_02.bits.arbitration);
 	}
 
 	/*
@@ -1257,11 +1248,11 @@ static void __init print_IO_APIC(int ioa
 	 */
 	if (reg_01.bits.version >= 0x20 && reg_03.raw != reg_02.raw &&
 	    reg_03.raw != reg_01.raw) {
-		printk(KERN_DEBUG ".... register #03: %08X\n", reg_03.raw);
-		printk(KERN_DEBUG ".......     : Boot DT    : %X\n", reg_03.bits.boot_DT);
+		apic_dbg(".... register #03: %08X\n", reg_03.raw);
+		apic_dbg(".......     : Boot DT    : %X\n", reg_03.bits.boot_DT);
 	}
 
-	printk(KERN_DEBUG ".... IRQ redirection table:\n");
+	apic_dbg(".... IRQ redirection table:\n");
 	io_apic_print_entries(ioapic_idx, reg_01.bits.entries);
 }
 
@@ -1270,11 +1261,11 @@ void __init print_IO_APICs(void)
 	int ioapic_idx;
 	unsigned int irq;
 
-	printk(KERN_DEBUG "number of MP IRQ sources: %d.\n", mp_irq_entries);
-	for_each_ioapic(ioapic_idx)
-		printk(KERN_DEBUG "number of IO-APIC #%d registers: %d.\n",
-		       mpc_ioapic_id(ioapic_idx),
-		       ioapics[ioapic_idx].nr_registers);
+	apic_dbg("number of MP IRQ sources: %d.\n", mp_irq_entries);
+	for_each_ioapic(ioapic_idx) {
+		apic_dbg("number of IO-APIC #%d registers: %d.\n",
+			 mpc_ioapic_id(ioapic_idx), ioapics[ioapic_idx].nr_registers);
+	}
 
 	/*
 	 * We are a bit conservative about what we expect.  We have to
@@ -1285,7 +1276,7 @@ void __init print_IO_APICs(void)
 	for_each_ioapic(ioapic_idx)
 		print_IO_APIC(ioapic_idx);
 
-	printk(KERN_DEBUG "IRQ to pin mappings:\n");
+	apic_dbg("IRQ to pin mappings:\n");
 	for_each_active_irq(irq) {
 		struct irq_pin_list *entry;
 		struct irq_chip *chip;
@@ -1300,7 +1291,7 @@ void __init print_IO_APICs(void)
 		if (list_empty(&data->irq_2_pin))
 			continue;
 
-		printk(KERN_DEBUG "IRQ%d ", irq);
+		apic_dbg("IRQ%d ", irq);
 		for_each_irq_pin(entry, data->irq_2_pin)
 			pr_cont("-> %d:%d", entry->apic, entry->pin);
 		pr_cont("\n");


