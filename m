Return-Path: <linux-kernel+bounces-272844-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C91289461BD
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 18:19:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 82FF9285D9A
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 16:19:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB77F3DAC03;
	Fri,  2 Aug 2024 16:15:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="PUZ9gkgM";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="+AJshIjl"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BDBF21C18B
	for <linux-kernel@vger.kernel.org>; Fri,  2 Aug 2024 16:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722615355; cv=none; b=BinZuVGaXU0eG5oUt1lwJsC9QbvkxQjB1TrJ1kuCet94+wsKAmYd9ONtZ7EUSXr0UUOhKw5uV6dbfwD9E8BM/mIR17Y5/tCRB1AeBLCdqYZTNi9Bhts1X40cvDdoXsesDBvkx8LWdsO4SJrlBo78U5J1ct7Lj5guC+KAiKO4DLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722615355; c=relaxed/simple;
	bh=A0wyGsG4VQqpvTYzQtPJGFUHhHE3Dg7u6/rty6Rpd8I=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=ITue9rTfVDfYIqJESyImg6VHwRfvam49VQXGtYoCHD9Xjs2aRhBJwwYZjTqZRHDy6x5HtgzOWPfzo/h23SD5Ii59ZUJUmZDP/zyiN5A65Wn6+1KViG8RRpRMxxpfbswUi7OL+qDPsv/UltOrUUDkEQms8gTjG4xoy+Emw87MhrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=PUZ9gkgM; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=+AJshIjl; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20240802155441.158662179@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1722615352;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=yEEn+vZuP5rQ44TYXFB0+eiJiPjkgFVGXHVETwJkf3s=;
	b=PUZ9gkgMveseYJ0xFU6+z60Z3cYanD1h71YljIL0eSDjB5cZt9imkH74fpogKHnI1C9guS
	QVggus4dZOn5i67vM36o7FW7areEyzVTXqManj5I8STOhFP2p/Jx/QE3B4bVJ1/Ew+Osbn
	I6Sx/ut03Rs6+low3AJaweLnSGbpqEDofrLBTIqUHQncHu5zfUmjbD0NvzTujMsSyHmWtT
	+hoJr33oJ4lETmn9/jmpexyavZNzdDxDlChTggdCORySt/3VxOQIVyb668FiOZeJLYz6vA
	PWPyc1MWm8w3y2d0JZtQtrn4YCWlsag52AyJNNSa9YI7pVHkf5/h/MyDn1tTiQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1722615352;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=yEEn+vZuP5rQ44TYXFB0+eiJiPjkgFVGXHVETwJkf3s=;
	b=+AJshIjlvkURz2JGHhhVLuZeg2+VJL/xWLa20ONqt/y5HGXuaHgreWpP97sdvxNBkool5Y
	A4ntFgA3qgmCWqAg==
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: x86@kernel.org
Subject: [patch 15/15] x86/ioapic: Cleanup remaining coding style issues
References: <20240802155038.556977544@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Fri,  2 Aug 2024 18:15:52 +0200 (CEST)

Add missing new lines and reorder variable definitions.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/kernel/apic/io_apic.c |   23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

--- a/arch/x86/kernel/apic/io_apic.c
+++ b/arch/x86/kernel/apic/io_apic.c
@@ -264,12 +264,14 @@ static __attribute_const__ struct io_api
 static inline void io_apic_eoi(unsigned int apic, unsigned int vector)
 {
 	struct io_apic __iomem *io_apic = io_apic_base(apic);
+
 	writel(vector, &io_apic->eoi);
 }
 
 unsigned int native_io_apic_read(unsigned int apic, unsigned int reg)
 {
 	struct io_apic __iomem *io_apic = io_apic_base(apic);
+
 	writel(reg, &io_apic->index);
 	return readl(&io_apic->data);
 }
@@ -880,9 +882,9 @@ static bool mp_check_pin_attr(int irq, s
 static int alloc_irq_from_domain(struct irq_domain *domain, int ioapic, u32 gsi,
 				 struct irq_alloc_info *info)
 {
+	int type = ioapics[ioapic].irqdomain_cfg.type;
 	bool legacy = false;
 	int irq = -1;
-	int type = ioapics[ioapic].irqdomain_cfg.type;
 
 	switch (type) {
 	case IOAPIC_DOMAIN_LEGACY:
@@ -951,11 +953,11 @@ static int alloc_isa_irq_from_domain(str
 static int mp_map_pin_to_irq(u32 gsi, int idx, int ioapic, int pin,
 			     unsigned int flags, struct irq_alloc_info *info)
 {
-	int irq;
-	bool legacy = false;
+	struct irq_domain *domain = mp_ioapic_irqdomain(ioapic);
 	struct irq_alloc_info tmp;
 	struct mp_chip_data *data;
-	struct irq_domain *domain = mp_ioapic_irqdomain(ioapic);
+	bool legacy = false;
+	int irq;
 
 	if (!domain)
 		return -ENOSYS;
@@ -1269,8 +1271,7 @@ static struct { int pin, apic; } ioapic_
 
 void __init enable_IO_APIC(void)
 {
-	int i8259_apic, i8259_pin;
-	int apic, pin;
+	int i8259_apic, i8259_pin, apic, pin;
 
 	if (ioapic_is_disabled)
 		nr_ioapics = 0;
@@ -1943,9 +1944,9 @@ static void lapic_register_intr(int irq)
  */
 static inline void __init unlock_ExtINT_logic(void)
 {
-	int apic, pin, i;
-	struct IO_APIC_route_entry entry0, entry1;
 	unsigned char save_control, save_freq_select;
+	struct IO_APIC_route_entry entry0, entry1;
+	int apic, pin, i;
 	u32 apic_id;
 
 	pin  = find_isa_irq_pin(8, mp_INT);
@@ -2211,11 +2212,11 @@ static inline void __init check_timer(vo
 
 static int mp_irqdomain_create(int ioapic)
 {
-	struct irq_domain *parent;
+	struct mp_ioapic_gsi *gsi_cfg = mp_ioapic_gsi_routing(ioapic);
 	int hwirqs = mp_ioapic_pin_count(ioapic);
 	struct ioapic *ip = &ioapics[ioapic];
 	struct ioapic_domain_cfg *cfg = &ip->irqdomain_cfg;
-	struct mp_ioapic_gsi *gsi_cfg = mp_ioapic_gsi_routing(ioapic);
+	struct irq_domain *parent;
 	struct fwnode_handle *fn;
 	struct irq_fwspec fwspec;
 
@@ -2491,8 +2492,8 @@ static struct resource *ioapic_resources
 
 static struct resource * __init ioapic_setup_resources(void)
 {
-	unsigned long n;
 	struct resource *res;
+	unsigned long n;
 	char *mem;
 	int i;
 


