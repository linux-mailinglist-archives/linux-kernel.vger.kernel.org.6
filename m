Return-Path: <linux-kernel+bounces-251495-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AFA6B93058D
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jul 2024 14:22:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 30FD11F21AB7
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jul 2024 12:22:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3886F7E59A;
	Sat, 13 Jul 2024 12:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="SrVgWoWd";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="c0FzzGuS"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCEDF1CAB5
	for <linux-kernel@vger.kernel.org>; Sat, 13 Jul 2024 12:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720873350; cv=none; b=lWqt19tcGDXKk7YYggo6DmfNt5NzKn+1V/HSExQrd1mzflFycKIW97cj8WucBJc28L4i0kh8IOx/UlKYsr7eI87v/YsuGRA+HqXhuKra+81T4/viqLQIMm6I3IJn/JOqARJMlrknw/xkxa7It8ccXkVzUN49AdS87AQx6mbaBt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720873350; c=relaxed/simple;
	bh=8yCLpYirxiDeC1/r3TsleOAH9bH7TSoTLdoY/lVFPYw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=cuExy5pJmbMcpSg4S1ERhSwUG7/HmbdT9u63bufiRrtcEUfdUZen/4ctKOK6XeHgmZEJXR6t7BVL3HGt1NHUSA/Y34/3wIX9FmG9wOSIvb+hO8UERLmCp0rX/VtP4zv103skLr0xDIteYPM+NYqKUI1TRCKN8OK0XC4ZqiqpM/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=SrVgWoWd; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=c0FzzGuS; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1720873346;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IxVY0JIawRXcfd9ztsyYu8EBX2zKGnyEQ86RgaBjSEQ=;
	b=SrVgWoWdSixHHvOh+WROlEOZxiN/zVuJeKUk9QbG70Tn4mXj6uR4a8AFj8ck8xzZvlE7NT
	y/J2PmKN3GfAtfoTQEx+j0CPvitFxleKRKUFSanqSO0kb/PjXy6gkdQUhTkzEwxkpaIgUC
	Rnq+kTxn6NjpDc5zfmmsZmigPjxZ+jVaSDQGbxb3mYrrhvOb4bk+XkKcOnOmd4aE2WcOhw
	0b7iHb77jUgnk5n+Ewen1M3e/B1AMdTcOVJh6+fdDew8GW0K4nMvj326/NgR4/1SaoQ+3y
	PvAamJ6ocPVj7yu2zOE9govQ5LkHq4ZVRQPdlV08twuilUWMMNpAdPLi6TdTWQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1720873346;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IxVY0JIawRXcfd9ztsyYu8EBX2zKGnyEQ86RgaBjSEQ=;
	b=c0FzzGuSvJE8kUcycGIAugjTtkWNBEbwrDXWaNOnFGkS8uGGLWaf9YoP70XLHEGMI51eN9
	1LlKylmwxOhDozAg==
To: Matti Vaittinen <mazziesaccount@gmail.com>, Matti Vaittinen
 <matti.vaittinen@fi.rohmeurope.com>
Cc: Mark Brown <broonie@kernel.org>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] regmap: Allow setting IRQ domain name suffix
In-Reply-To: <12228ec5-cf2f-47b2-842d-ce336d921260@gmail.com>
References: <cover.1719830185.git.mazziesaccount@gmail.com>
 <fd13fcc9dd785d69b8450c8e9c26d860fcab7da8.1719830185.git.mazziesaccount@gmail.com>
 <87plrpvzmg.ffs@tglx> <12228ec5-cf2f-47b2-842d-ce336d921260@gmail.com>
Date: Sat, 13 Jul 2024 14:22:26 +0200
Message-ID: <87jzhpscql.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Matti!

On Mon, Jul 08 2024 at 15:40, Matti Vaittinen wrote:
> On 7/7/24 21:13, Thomas Gleixner wrote:
>> 
>> I wonder whether this can be handled at the core. Let me stare at it.
>
> Thanks Thomas! I'll wait for your ideas before re-spinning this series :)

Something like the untested below should work. That would make your
info:

	struct irq_domain_info info = {
		.fwnode		= fwnode,
		.size		= chip->num_irqs,
		.hwirq_max	= chip->num_irqs,
                .virq_base	= irq_base,
		.ops		= &regmap_domain_ops,
		.host_data	= d,
		.name_suffix	= chip->domain_suffix,
	};

Thanks,

        tglx
---
--- a/include/linux/irqdomain.h
+++ b/include/linux/irqdomain.h
@@ -291,6 +291,9 @@ struct irq_domain_chip_generic_info;
  * @hwirq_max:		Maximum number of interrupts supported by controller
  * @direct_max:		Maximum value of direct maps;
  *			Use ~0 for no limit; 0 for no direct mapping
+ * @hwirq_base:		The first hardware interrupt number (legacy domains only)
+ * @virq_base:		The first Linux interrupt number for legacy domains to
+ *			immediately associate the interrupts after domain creation
  * @bus_token:		Domain bus token
  * @ops:		Domain operation callbacks
  * @host_data:		Controller private data pointer
@@ -307,6 +310,8 @@ struct irq_domain_info {
 	unsigned int				size;
 	irq_hw_number_t				hwirq_max;
 	int					direct_max;
+	unsigned int				hwirq_base;
+	unsigned int				virq_base;
 	enum irq_domain_bus_token		bus_token;
 	const struct irq_domain_ops		*ops;
 	void					*host_data;
--- a/kernel/irq/irqdomain.c
+++ b/kernel/irq/irqdomain.c
@@ -267,13 +267,20 @@ static void irq_domain_free(struct irq_d
 	kfree(domain);
 }
 
-/**
- * irq_domain_instantiate() - Instantiate a new irq domain data structure
- * @info: Domain information pointer pointing to the information for this domain
- *
- * Return: A pointer to the instantiated irq domain or an ERR_PTR value.
- */
-struct irq_domain *irq_domain_instantiate(const struct irq_domain_info *info)
+static void irq_domain_instantiate_descs(const struct irq_domain_info *info)
+{
+	if (!IS_ENABLED(CONFIG_SPARSE_IRQ))
+		return;
+
+	if (irq_alloc_descs(info->virq_base, info->virq_base, info->size,
+			    of_node_to_nid(to_of_node(info->fwnode))) < 0) {
+		pr_info("Cannot allocate irq_descs @ IRQ%d, assuming pre-allocated\n",
+			info->virq_base);
+	}
+}
+
+static struct irq_domain *__irq_domain_instantiate(const struct irq_domain_info *info,
+						   bool cond_alloc_descs)
 {
 	struct irq_domain *domain;
 	int err;
@@ -306,6 +313,13 @@ struct irq_domain *irq_domain_instantiat
 
 	__irq_domain_publish(domain);
 
+	if (cond_alloc_descs && info->virq_base > 0)
+		irq_domain_instantiate_descs(info);
+
+	/* Legacy interrupt domains have a fixed Linux interrupt number */
+	if (info->virq_base > 0)
+		irq_domain_associate_many(domain, info->virq_base, info->hwirq_base, info->size);
+
 	return domain;
 
 err_domain_gc_remove:
@@ -315,6 +329,17 @@ struct irq_domain *irq_domain_instantiat
 	irq_domain_free(domain);
 	return ERR_PTR(err);
 }
+
+/**
+ * irq_domain_instantiate() - Instantiate a new irq domain data structure
+ * @info: Domain information pointer pointing to the information for this domain
+ *
+ * Return: A pointer to the instantiated irq domain or an ERR_PTR value.
+ */
+struct irq_domain *irq_domain_instantiate(const struct irq_domain_info *info)
+{
+	return __irq_domain_instantiate(info, false);
+}
 EXPORT_SYMBOL_GPL(irq_domain_instantiate);
 
 /**
@@ -413,28 +438,13 @@ struct irq_domain *irq_domain_create_sim
 		.fwnode		= fwnode,
 		.size		= size,
 		.hwirq_max	= size,
+		.virq_base	= first_irq,
 		.ops		= ops,
 		.host_data	= host_data,
 	};
-	struct irq_domain *domain;
-
-	domain = irq_domain_instantiate(&info);
-	if (IS_ERR(domain))
-		return NULL;
-
-	if (first_irq > 0) {
-		if (IS_ENABLED(CONFIG_SPARSE_IRQ)) {
-			/* attempt to allocated irq_descs */
-			int rc = irq_alloc_descs(first_irq, first_irq, size,
-						 of_node_to_nid(to_of_node(fwnode)));
-			if (rc < 0)
-				pr_info("Cannot allocate irq_descs @ IRQ%d, assuming pre-allocated\n",
-					first_irq);
-		}
-		irq_domain_associate_many(domain, first_irq, 0, size);
-	}
+	struct irq_domain *domain = __irq_domain_instantiate(&info, true);
 
-	return domain;
+	return IS_ERR(domain) ? NULL : domain;
 }
 EXPORT_SYMBOL_GPL(irq_domain_create_simple);
 
@@ -476,18 +486,14 @@ struct irq_domain *irq_domain_create_leg
 		.fwnode		= fwnode,
 		.size		= first_hwirq + size,
 		.hwirq_max	= first_hwirq + size,
+		.hwirq_base	= first_hwirq,
+		.virq_base	= first_irq,
 		.ops		= ops,
 		.host_data	= host_data,
 	};
-	struct irq_domain *domain;
+	struct irq_domain *domain = irq_domain_instantiate(&info);
 
-	domain = irq_domain_instantiate(&info);
-	if (IS_ERR(domain))
-		return NULL;
-
-	irq_domain_associate_many(domain, first_irq, first_hwirq, size);
-
-	return domain;
+	return IS_ERR(domain) ? NULL : domain;
 }
 EXPORT_SYMBOL_GPL(irq_domain_create_legacy);
 

