Return-Path: <linux-kernel+bounces-272842-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EAD39461BB
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 18:18:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B8CC1C20B5A
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 16:18:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCC0F21C194;
	Fri,  2 Aug 2024 16:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="SuHgct+A";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ny5DpkZZ"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72D652101B3
	for <linux-kernel@vger.kernel.org>; Fri,  2 Aug 2024 16:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722615353; cv=none; b=sQ00QghZ3bdEs1kN8e/z11jFLed8jMtkGM3VszIfjhzhyxGQfi052CDoioMc917pGKOMWk40TIAUiMpA5qUHHBsHfFFJsYhIXk4udDy99I63BRqwD7+N/XpNB9XzhepPJXnbH7Uiah37RWYQla7M3xI8q717Ag0m3FzzvFTbTv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722615353; c=relaxed/simple;
	bh=4joPjqYEQP1EZM/mKEFP/7OQQSP2kumvms7FfENrhiI=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=k5DLlKb11vuRcSKXlHLJoXRW0JVZOCQj3kCbFVWJb8QlQtrsXUaiHDrIchIfUUxMnjlRBG+p+UdLF02WlSZov+RWegIrN+N/Yvb+ZRda1XYNnWzWE3OOt87ju9MaFdNkVllmrc/3IJBdFZ8iZ51B3yNX74MdO0/M4C37jvNXpqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=SuHgct+A; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ny5DpkZZ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20240802155441.032045616@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1722615349;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=Dhes1tKIxTk1JJs3+ZEKAxniIS8S9bZ/SOxPoiAxujU=;
	b=SuHgct+AllcbTQrVfvZHWvWkxazys3y+/DqLm8CNc4SsPA9lAvzolwybv/XdmyirOsLC5N
	72a71oPLr2/zr+ZwsrDXzJSkw6ugwzwkp+EqKDmXmEmoFTKDuCCysYhZdIXXVab7d2gOjK
	KDh6ORu7q6NXWp6llM5GNM+RbNPEJKob8hEYYgy21oBmgnsq+MZ975cVeyrfsqxHXS7EDL
	Y/XLS8rDwROasjCZwYFd+lgwgqB3PvfmJdS/OZCOMehZWk6+7AxBbL3XCtvfamGOSfdVxq
	T6V0/GmmLhvGt/CFwpWV/xyudR135yYcH8y7oV4VMzHOI5bgoj41r/Y5kkWoaw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1722615349;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=Dhes1tKIxTk1JJs3+ZEKAxniIS8S9bZ/SOxPoiAxujU=;
	b=ny5DpkZZlOzC1zv9wFla0Frd7g5caUvIOLfx+uTVKNccrHQj3UECxu60uhPYNfbTcgDgWC
	AmIO/FP/1mZ/xCBA==
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: x86@kernel.org
Subject: [patch 13/15] x86/ioapic: Cleanup bracket usage
References: <20240802155038.556977544@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Fri,  2 Aug 2024 18:15:49 +0200 (CEST)

Add brackets around if/for constructs as required by coding style or remove
pointless line breaks to make it true single line statements which do not
require brackets.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/kernel/apic/io_apic.c |   34 ++++++++++++++++++----------------
 1 file changed, 18 insertions(+), 16 deletions(-)

--- a/arch/x86/kernel/apic/io_apic.c
+++ b/arch/x86/kernel/apic/io_apic.c
@@ -362,12 +362,13 @@ static void __remove_pin_from_irq(struct
 {
 	struct irq_pin_list *tmp, *entry;
 
-	list_for_each_entry_safe(entry, tmp, &data->irq_2_pin, list)
+	list_for_each_entry_safe(entry, tmp, &data->irq_2_pin, list) {
 		if (entry->apic == apic && entry->pin == pin) {
 			list_del(&entry->list);
 			kfree(entry);
 			return;
 		}
+	}
 }
 
 static void io_apic_modify_irq(struct mp_chip_data *data, bool masked,
@@ -562,8 +563,7 @@ int save_ioapic_entries(void)
 		}
 
 		for_each_pin(apic, pin)
-			ioapics[apic].saved_registers[pin] =
-				ioapic_read_entry(apic, pin);
+			ioapics[apic].saved_registers[pin] = ioapic_read_entry(apic, pin);
 	}
 
 	return err;
@@ -604,8 +604,7 @@ int restore_ioapic_entries(void)
 			continue;
 
 		for_each_pin(apic, pin)
-			ioapic_write_entry(apic, pin,
-					   ioapics[apic].saved_registers[pin]);
+			ioapic_write_entry(apic, pin, ioapics[apic].saved_registers[pin]);
 	}
 	return 0;
 }
@@ -617,12 +616,13 @@ static int find_irq_entry(int ioapic_idx
 {
 	int i;
 
-	for (i = 0; i < mp_irq_entries; i++)
+	for (i = 0; i < mp_irq_entries; i++) {
 		if (mp_irqs[i].irqtype == type &&
 		    (mp_irqs[i].dstapic == mpc_ioapic_id(ioapic_idx) ||
 		     mp_irqs[i].dstapic == MP_APIC_ALL) &&
 		    mp_irqs[i].dstirq == pin)
 			return i;
+	}
 
 	return -1;
 }
@@ -662,9 +662,10 @@ static int __init find_isa_irq_apic(int
 	if (i < mp_irq_entries) {
 		int ioapic_idx;
 
-		for_each_ioapic(ioapic_idx)
+		for_each_ioapic(ioapic_idx) {
 			if (mpc_ioapic_id(ioapic_idx) == mp_irqs[i].dstapic)
 				return ioapic_idx;
+		}
 	}
 
 	return -1;
@@ -1424,11 +1425,12 @@ static void __init setup_ioapic_ids_from
 		 * We need to adjust the IRQ routing table if the ID
 		 * changed.
 		 */
-		if (old_id != mpc_ioapic_id(ioapic_idx))
-			for (i = 0; i < mp_irq_entries; i++)
+		if (old_id != mpc_ioapic_id(ioapic_idx)) {
+			for (i = 0; i < mp_irq_entries; i++) {
 				if (mp_irqs[i].dstapic == old_id)
-					mp_irqs[i].dstapic
-						= mpc_ioapic_id(ioapic_idx);
+					mp_irqs[i].dstapic = mpc_ioapic_id(ioapic_idx);
+			}
+		}
 
 		/*
 		 * Update the ID register according to the right value from
@@ -2666,12 +2668,10 @@ static int bad_ioapic_register(int idx)
 
 static int find_free_ioapic_entry(void)
 {
-	int idx;
-
-	for (idx = 0; idx < MAX_IO_APICS; idx++)
+	for (int idx = 0; idx < MAX_IO_APICS; idx++) {
 		if (ioapics[idx].nr_registers == 0)
 			return idx;
-
+	}
 	return MAX_IO_APICS;
 }
 
@@ -2780,11 +2780,13 @@ int mp_unregister_ioapic(u32 gsi_base)
 	int ioapic, pin;
 	int found = 0;
 
-	for_each_ioapic(ioapic)
+	for_each_ioapic(ioapic) {
 		if (ioapics[ioapic].gsi_config.gsi_base == gsi_base) {
 			found = 1;
 			break;
 		}
+	}
+
 	if (!found) {
 		pr_warn("can't find IOAPIC for GSI %d\n", gsi_base);
 		return -ENODEV;


