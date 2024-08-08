Return-Path: <linux-kernel+bounces-280092-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9887D94C591
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 22:20:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D510D1C22194
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 20:19:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A890156237;
	Thu,  8 Aug 2024 20:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="e3P8Pokg";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="HJ9JYQEt"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 763EDBE40
	for <linux-kernel@vger.kernel.org>; Thu,  8 Aug 2024 20:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723148385; cv=none; b=M+DbEFzhgNCuCMuTB1pV8qKeiXVSAAvR6DyB5oNz8ztL+nfAU9OgmOm6269atbSmR7nfW9J95FrSRSQfNXDE7cWsHtkTXx7WLwPtUyi4C8Cs6SF5emA5AP9ut/3tu+vrIni30O+Y4Nj85h4vY7HDTud5mi89eEMD28HEpQO9Jxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723148385; c=relaxed/simple;
	bh=woPtMvfToWMXknsIxkiOjol1fuKH2pf+S82Wq4ai6Ok=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=sLt6g2v5cDxTXwWcqkicCig/cD/6hnSpqJFCbPE+r7qRtJMjEebAoISccbq2/WmJ0ReOkX062QPAFI/njUDVr7goJ/NikIbLqB5F/MJb8mDMl1ehOiJxTjA9pDq/L1vC7wjkd2FLehky5W0fpxsJUrI5YGsTaOR+6ecGBRp0fvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=e3P8Pokg; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=HJ9JYQEt; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1723148381;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ou5DKJ0eAop5una4YZqzZQBmZpyN0erdOFwGZF2IoUU=;
	b=e3P8PokghEtki3W5VgBkde1OsYDJjbeId+prGsqt73kvOjF1aSm8Idi4Qd8UGAfhJXdxP6
	OpzGGW+Xg2iFhlaAyjWub6mrOcp6WT2RF8jBswVaQj9LCLrRYltFjuqSkMh6e5AX+BAwsk
	6esjDdiXiCy/wUotApYCdIcmQUb5EbFVYI7g3eQJS7AhsaFKeRA9NnH7SlXCyBVpoZBWEX
	PFCouqwca2KdlqcyH99IYYIPQx4xqD7TIJFJuGhFl1Bx453bdkxEzq2Xv7wX4Hc7e6+aKy
	D/+uMOq/iR6jZ/PdfUiD1q//cOpmo4eYFKPv8LftuhHjrMAAMUHOvDg8u0dC7Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1723148381;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ou5DKJ0eAop5una4YZqzZQBmZpyN0erdOFwGZF2IoUU=;
	b=HJ9JYQEtZyA1tJTShFLTrPILB42A3K5CWg07zBrjf5amvHDJ3LcDCzdyEYi9+JvYK6lypr
	OLkyo8E4q2oe3JDQ==
To: Matti Vaittinen <mazziesaccount@gmail.com>, Matti Vaittinen
 <mazziesaccount@gmail.com>, Matti Vaittinen
 <matti.vaittinen@fi.rohmeurope.com>
Cc: Mark Brown <broonie@kernel.org>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
 linux-kernel@vger.kernel.org
Subject: [PATCH] irqdomain: Cleanup domain name allocation
In-Reply-To: <877ccqvkfm.ffs@tglx>
References: <cover.1723120028.git.mazziesaccount@gmail.com>
 <7a048c0139e79beb46d887b0cd5a620963ff8ef8.1723120028.git.mazziesaccount@gmail.com>
 <877ccqvkfm.ffs@tglx>
Date: Thu, 08 Aug 2024 22:19:41 +0200
Message-ID: <874j7uvkbm.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

irq_domain_set_name() is truly unreadable gunk. Clean it up before adding
more.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 kernel/irq/irqdomain.c |  104 +++++++++++++++++++++++++------------------------
 1 file changed, 55 insertions(+), 49 deletions(-)

--- a/kernel/irq/irqdomain.c
+++ b/kernel/irq/irqdomain.c
@@ -128,11 +128,53 @@ void irq_domain_free_fwnode(struct fwnod
 }
 EXPORT_SYMBOL_GPL(irq_domain_free_fwnode);
 
-static int irq_domain_set_name(struct irq_domain *domain,
-			       const struct fwnode_handle *fwnode,
-			       enum irq_domain_bus_token bus_token)
+static int alloc_name(struct irq_domain *domain, char *base, enum irq_domain_bus_token bus_token)
+{
+	domain->name = bus_token ? kasprintf(GFP_KERNEL, "%s-%d", base, bus_token) :
+				   kasprintf(GFP_KERNEL, "%s", base);
+	if (!domain->name)
+		return -ENOMEM;
+
+	domain->flags |= IRQ_DOMAIN_NAME_ALLOCATED;
+	return 0;
+}
+
+static int alloc_fwnode_name(struct irq_domain *domain, const struct fwnode_handle *fwnode,
+			     enum irq_domain_bus_token bus_token)
+{
+	char *name = bus_token ? kasprintf(GFP_KERNEL, "%pfw-%d", fwnode, bus_token) :
+				 kasprintf(GFP_KERNEL, "%pfw", fwnode);
+
+	if (!name)
+		return -ENOMEM;
+
+	/*
+	 * fwnode paths contain '/', which debugfs is legitimately unhappy
+	 * about. Replace them with ':', which does the trick and is not as
+	 * offensive as '\'...
+	 */
+	domain->name = strreplace(name, '/', ':');
+	domain->flags |= IRQ_DOMAIN_NAME_ALLOCATED;
+	return 0;
+}
+
+static int alloc_unknown_name(struct irq_domain *domain, enum irq_domain_bus_token bus_token)
 {
 	static atomic_t unknown_domains;
+	int id = atomic_inc_return(&unknown_domains);
+
+	domain->name = bus_token ? kasprintf(GFP_KERNEL, "unknown-%d-%d", id, bus_token) :
+				   kasprintf(GFP_KERNEL, "unknown-%d", id);
+
+	if (!domain->name)
+		return -ENOMEM;
+	domain->flags |= IRQ_DOMAIN_NAME_ALLOCATED;
+	return 0;
+}
+
+static int irq_domain_set_name(struct irq_domain *domain, const struct fwnode_handle *fwnode,
+			       enum irq_domain_bus_token bus_token)
+{
 	struct irqchip_fwid *fwid;
 
 	if (is_fwnode_irqchip(fwnode)) {
@@ -141,59 +183,23 @@ static int irq_domain_set_name(struct ir
 		switch (fwid->type) {
 		case IRQCHIP_FWNODE_NAMED:
 		case IRQCHIP_FWNODE_NAMED_ID:
-			domain->name = bus_token ?
-					kasprintf(GFP_KERNEL, "%s-%d",
-						  fwid->name, bus_token) :
-					kstrdup(fwid->name, GFP_KERNEL);
-			if (!domain->name)
-				return -ENOMEM;
-			domain->flags |= IRQ_DOMAIN_NAME_ALLOCATED;
-			break;
+			return alloc_name(domain, fwid->name, bus_token);
 		default:
 			domain->name = fwid->name;
-			if (bus_token) {
-				domain->name = kasprintf(GFP_KERNEL, "%s-%d",
-							 fwid->name, bus_token);
-				if (!domain->name)
-					return -ENOMEM;
-				domain->flags |= IRQ_DOMAIN_NAME_ALLOCATED;
-			}
-			break;
+			if (bus_token)
+				return alloc_name(domain, fwid->name, bus_token);
 		}
-	} else if (is_of_node(fwnode) || is_acpi_device_node(fwnode) ||
-		   is_software_node(fwnode)) {
-		char *name;
-
-		/*
-		 * fwnode paths contain '/', which debugfs is legitimately
-		 * unhappy about. Replace them with ':', which does
-		 * the trick and is not as offensive as '\'...
-		 */
-		name = bus_token ?
-			kasprintf(GFP_KERNEL, "%pfw-%d", fwnode, bus_token) :
-			kasprintf(GFP_KERNEL, "%pfw", fwnode);
-		if (!name)
-			return -ENOMEM;
 
-		domain->name = strreplace(name, '/', ':');
-		domain->flags |= IRQ_DOMAIN_NAME_ALLOCATED;
+	} else if (is_of_node(fwnode) || is_acpi_device_node(fwnode) || is_software_node(fwnode)) {
+		return alloc_fwnode_name(domain, fwnode, bus_token);
 	}
 
-	if (!domain->name) {
-		if (fwnode)
-			pr_err("Invalid fwnode type for irqdomain\n");
-		domain->name = bus_token ?
-				kasprintf(GFP_KERNEL, "unknown-%d-%d",
-					  atomic_inc_return(&unknown_domains),
-					  bus_token) :
-				kasprintf(GFP_KERNEL, "unknown-%d",
-					  atomic_inc_return(&unknown_domains));
-		if (!domain->name)
-			return -ENOMEM;
-		domain->flags |= IRQ_DOMAIN_NAME_ALLOCATED;
-	}
+	if (domain->name)
+		return 0;
 
-	return 0;
+	if (fwnode)
+		pr_err("Invalid fwnode type for irqdomain\n");
+	return alloc_unknown_name(domain, bus_token);
 }
 
 static struct irq_domain *__irq_domain_create(const struct irq_domain_info *info)

