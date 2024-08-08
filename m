Return-Path: <linux-kernel+bounces-280098-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B686A94C5A1
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 22:23:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 69C982847E3
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 20:23:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B70015A848;
	Thu,  8 Aug 2024 20:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="FwA5yNNV";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="D/VTDpu3"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E46C0159598
	for <linux-kernel@vger.kernel.org>; Thu,  8 Aug 2024 20:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723148590; cv=none; b=dVwlMxk3LuP13AAxCxYIjvJptk75YdRRIa7RM5O9leZ7AAt/xhMSlJsGb/xusfT/dW9xoj+FIXuD+jMoOsOnCII/kruAq++QctFuPW7pIVG4YAzuqiqZpIs4eQWtCKFmFZJYmCWJhkAis1JBWpz0DFCCIuO3E/ePqdQVHRX/pOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723148590; c=relaxed/simple;
	bh=LwA9F7XZ2oEMCjw7Kgx97oUzAF53Fmps3bt12FnFCKw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Ra+I6xI/izbspUCgqUStwEc9r91Eg6Nbc0IxNxBFXoHNnSdk122xjgChFulKTOOUGZdIV3vs02SQ/HO8JhBA3773TWHluMtJJBynEg3oaPWdSTl33vruV6tHbOJeTSQvAWBPIYS2aqk6MQAeEj0AQk3+Tm8zL6dlw95xsznJoH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=FwA5yNNV; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=D/VTDpu3; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1723148587;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9Yq+NG8Hl8l7ZEs/tA7F+DiDs6lzdrkcFIK7wyGTvlU=;
	b=FwA5yNNVEZGtMwMrKq+5ogSWlfipXpPIs2hDc9c5Ucsy23dEYW58Xri8HLF9YEEjr3tzFN
	3dVWf7WjM81P7hdRsfy4pJy02klYvRgJ3dJflVyzYBvHybZYmiRdtWCVnyxjrI4RzB1/P8
	rauVMBhffFg0kwU7Ie/XDp3B5xQbnpuOLTtnYT1sgzTT5DvnJrfov2KDubmuNXSGDLqSzX
	pJy/keP3cdn01h6Cb2AMLMCz/23XFjnWMrY7o8HaDx2kZutv5fOjDAzYecF1NNEfPXi6kS
	PA9Zz93VgX5xdiEJZsGqBMUxVYnGWh9UfJTprrzWOb4hAPZCu9km1e2mQ09SNA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1723148587;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9Yq+NG8Hl8l7ZEs/tA7F+DiDs6lzdrkcFIK7wyGTvlU=;
	b=D/VTDpu3t7nheEw3iMTILhfgEnmqMUh18tjJYKpqfdRz7pF3jpXhue36DBTV1TotOOOili
	/z/gUZNpBuX53PBg==
To: Matti Vaittinen <mazziesaccount@gmail.com>, Matti Vaittinen
 <mazziesaccount@gmail.com>, Matti Vaittinen
 <matti.vaittinen@fi.rohmeurope.com>
Cc: Mark Brown <broonie@kernel.org>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
 linux-kernel@vger.kernel.org
Subject: [PATCH v2a 2/3] irqdomain: Allow giving name suffix for domain
In-Reply-To: <874j7uvkbm.ffs@tglx>
References: <cover.1723120028.git.mazziesaccount@gmail.com>
 <7a048c0139e79beb46d887b0cd5a620963ff8ef8.1723120028.git.mazziesaccount@gmail.com>
 <877ccqvkfm.ffs@tglx> <874j7uvkbm.ffs@tglx>
Date: Thu, 08 Aug 2024 22:23:06 +0200
Message-ID: <871q2yvk5x.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain


From: Matti Vaittinen <mazziesaccount@gmail.com>

Devices can provide multiple interrupt lines. One reason for this is that
a device has multiple subfunctions, each providing its own interrupt line.
Another reason is that a device can be designed to be used (also) on a
system where some of the interrupts can be routed to another processor.

A line often further acts as a demultiplex for specific interrupts
and has it's respective set of interrupt (status, mask, ack, ...)
registers.

Regmap supports the handling of these registers and demultiplexing
interrupts, but the interrupt domain code ends up assigning the same name
for the per interrupt line domains. This causes a naming collision in the
debugFS code and leads to confusion, as /proc/interrupts shows two separate
interrupts with the same domain name and hardware interrupt number.

Instead of adding a workaround in regmap or driver code, allow giving a
name suffix for the domain name when the domain is created.

Add a name_suffix field in the irq_domain_info structure and make
irq_domain_instantiate() use this suffix if it is given when a domain is
created.

Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
Revision history:
v2 => v2a:
   Update to name allocation cleanup patch. Fix the invalid NULL return.
v1 => v2:
 - typofix in comment. 'collison' to 'collision'.
---
 include/linux/irqdomain.h |    3 +++
 kernel/irq/irqdomain.c    |   32 +++++++++++++++++++++++---------
 2 files changed, 26 insertions(+), 9 deletions(-)

--- a/include/linux/irqdomain.h
+++ b/include/linux/irqdomain.h
@@ -295,6 +295,8 @@ struct irq_domain_chip_generic_info;
  * @virq_base:		The first Linux interrupt number for legacy domains to
  *			immediately associate the interrupts after domain creation
  * @bus_token:		Domain bus token
+ * @name_suffix:	Optional name suffix to avoid collisions when multiple
+ *			domains are added using same fwnode
  * @ops:		Domain operation callbacks
  * @host_data:		Controller private data pointer
  * @dgc_info:		Geneneric chip information structure pointer used to
@@ -313,6 +315,7 @@ struct irq_domain_info {
 	unsigned int				hwirq_base;
 	unsigned int				virq_base;
 	enum irq_domain_bus_token		bus_token;
+	const char				*name_suffix;
 	const struct irq_domain_ops		*ops;
 	void					*host_data;
 #ifdef CONFIG_IRQ_DOMAIN_HIERARCHY
--- a/kernel/irq/irqdomain.c
+++ b/kernel/irq/irqdomain.c
@@ -140,11 +140,14 @@ static int alloc_name(struct irq_domain
 }
 
 static int alloc_fwnode_name(struct irq_domain *domain, const struct fwnode_handle *fwnode,
-			     enum irq_domain_bus_token bus_token)
+			     enum irq_domain_bus_token bus_token, const char *suffix)
 {
-	char *name = bus_token ? kasprintf(GFP_KERNEL, "%pfw-%d", fwnode, bus_token) :
-				 kasprintf(GFP_KERNEL, "%pfw", fwnode);
+	const char *sep = suffix ? "-" : "";
+	const char *suf = suffix ? : "";
+	char *name;
 
+	name = bus_token ? kasprintf(GFP_KERNEL, "%pfw-%s%s%d", fwnode, suf, sep, bus_token) :
+			   kasprintf(GFP_KERNEL, "%pfw-%s", fwnode, suf);
 	if (!name)
 		return -ENOMEM;
 
@@ -172,13 +175,24 @@ static int alloc_unknown_name(struct irq
 	return 0;
 }
 
-static int irq_domain_set_name(struct irq_domain *domain, const struct fwnode_handle *fwnode,
-			       enum irq_domain_bus_token bus_token)
+static int irq_domain_set_name(struct irq_domain *domain, const struct irq_domain_info *info)
 {
-	struct irqchip_fwid *fwid;
+	enum irq_domain_bus_token bus_token = info->bus_token;
+	const struct fwnode_handle *fwnode = info->fwnode;
 
 	if (is_fwnode_irqchip(fwnode)) {
-		fwid = container_of(fwnode, struct irqchip_fwid, fwnode);
+		struct irqchip_fwid *fwid = container_of(fwnode, struct irqchip_fwid, fwnode);
+
+		/*
+		 * The name_suffix is only intended to be used to avoid a name
+		 * collision, when multiple domains are created for a single
+		 * device and the name is picked using a real device node.
+		 * (Typical use-case is regmap-IRQ controllers for devices
+		 * providing more than one physical IRQ.) There should be no
+		 * need to use name_suffix with irqchip-fwnode.
+		 */
+		if (info->name_suffix)
+			return -EINVAL;
 
 		switch (fwid->type) {
 		case IRQCHIP_FWNODE_NAMED:
@@ -191,7 +205,7 @@ static int irq_domain_set_name(struct ir
 		}
 
 	} else if (is_of_node(fwnode) || is_acpi_device_node(fwnode) || is_software_node(fwnode)) {
-		return alloc_fwnode_name(domain, fwnode, bus_token);
+		return alloc_fwnode_name(domain, fwnode, bus_token, info->name_suffix);
 	}
 
 	if (domain->name)
@@ -217,7 +231,7 @@ static struct irq_domain *__irq_domain_c
 	if (!domain)
 		return ERR_PTR(-ENOMEM);
 
-	err = irq_domain_set_name(domain, info->fwnode, info->bus_token);
+	err = irq_domain_set_name(domain, info);
 	if (err) {
 		kfree(domain);
 		return ERR_PTR(err);

