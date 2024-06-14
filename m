Return-Path: <linux-kernel+bounces-215363-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CEA03909199
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 19:34:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E05411C2623C
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 17:34:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B0951A38C5;
	Fri, 14 Jun 2024 17:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="K4mjauuG"
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9567F19AD48;
	Fri, 14 Jun 2024 17:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718386375; cv=none; b=b1hYMaLr+xSK/qxE0DNYTADEEMNjx8vH8t/HyIlim/g5SUqRCUm+7dfD0+RkI9eqXs/JTKrYSpfBwZjjyONHIc5xKEmsniOdcG1hoflVEP9dJ4rHQQ0MZiv9Q/JT3cUMZT1w/WO0f2GLB7t4WVkMk3ayZ2u8o7BgW2QJg0NwiwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718386375; c=relaxed/simple;
	bh=zPcEhF7Zbnn9w7HiuIbKexzk/QSSPVuHN85P038ldmE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e2WfFSc6N4NvoTU3oukAREW1TJ95qfBTDg65WGMoG83aeH3IUAMDIhi12qeOn+nI0LxlOXVbyW1HuG79TJE4AF8RIou1RzS6d1C+zyJsnpGVbEEg8nP+kxUynKy2KA/goyeOwFxkfga5bJsLeZeWeuZEoQ6/2pDWI4d/KJx7wRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=K4mjauuG; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPA id B4F37FF803;
	Fri, 14 Jun 2024 17:32:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1718386366;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+CQfiI+Nq1S9v1Nm6K78UW44sXVdGGexG8I5gR9gXYM=;
	b=K4mjauuGA30E+3QwBWCUnq0ia7ivGj9hrqSLbujhgwzAtgq6x89MuJTpz1udhPcEH+ZIbw
	nWaJiGSDGdXijQaZn6wMu+fvH4tWrcbD4fHzt5NlQa5Z4ORlpYZqssNWBeACWggtvYZcRc
	ECER1RTDcsJY30Y+LfW5hSUCGKzMn34/0GNRLQzX377vdW7iXju7rLa3/feML2gMAJFjKv
	0uUScPaUzURWX9ycbe21cdRoFjbnBjNoNgZRTfq1EPgjfe7cpiMypDSltLKfpiWla9T3OX
	RSOd5yQIzXU+L8SV5QNM1v9fqXcE1HdDuIEOQJbDKF+5wr5s9x+EzLDEJGBWHw==
From: Herve Codina <herve.codina@bootlin.com>
To: Matti Vaittinen <mazziesaccount@gmail.com>,
	Herve Codina <herve.codina@bootlin.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Marc Zyngier <maz@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-um@lists.infradead.org,
	Allan Nielsen <allan.nielsen@microchip.com>,
	Horatiu Vultur <horatiu.vultur@microchip.com>,
	Steen Hegelund <steen.hegelund@microchip.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: [PATCH 01/23] irqdomain: Introduce irq_domain_free()
Date: Fri, 14 Jun 2024 19:32:02 +0200
Message-ID: <20240614173232.1184015-2-herve.codina@bootlin.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240614173232.1184015-1-herve.codina@bootlin.com>
References: <20240614173232.1184015-1-herve.codina@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: herve.codina@bootlin.com

In preparation of the introduction of the irq domain instantiation,
introduce irq_domain_free() to avoid code duplication on later
modifications.

This new function is an extraction of the current operations performed
to free the irq domain. No functional changes are introduced.

Suggested-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Herve Codina <herve.codina@bootlin.com>
---
 kernel/irq/irqdomain.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/kernel/irq/irqdomain.c b/kernel/irq/irqdomain.c
index 86f8b91b0d3a..95eda206367f 100644
--- a/kernel/irq/irqdomain.c
+++ b/kernel/irq/irqdomain.c
@@ -241,6 +241,15 @@ static void __irq_domain_publish(struct irq_domain *domain)
 	pr_debug("Added domain %s\n", domain->name);
 }
 
+static void irq_domain_free(struct irq_domain *domain)
+{
+	fwnode_dev_initialized(domain->fwnode, false);
+	fwnode_handle_put(domain->fwnode);
+	if (domain->flags & IRQ_DOMAIN_NAME_ALLOCATED)
+		kfree(domain->name);
+	kfree(domain);
+}
+
 /**
  * __irq_domain_add() - Allocate a new irq_domain data structure
  * @fwnode: firmware node for the interrupt controller
@@ -296,12 +305,7 @@ void irq_domain_remove(struct irq_domain *domain)
 	mutex_unlock(&irq_domain_mutex);
 
 	pr_debug("Removed domain %s\n", domain->name);
-
-	fwnode_dev_initialized(domain->fwnode, false);
-	fwnode_handle_put(domain->fwnode);
-	if (domain->flags & IRQ_DOMAIN_NAME_ALLOCATED)
-		kfree(domain->name);
-	kfree(domain);
+	irq_domain_free(domain);
 }
 EXPORT_SYMBOL_GPL(irq_domain_remove);
 
-- 
2.45.0


