Return-Path: <linux-kernel+bounces-215379-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F8F69091BF
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 19:37:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A41B31C21763
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 17:37:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C1AF1B1426;
	Fri, 14 Jun 2024 17:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="MDhfD84t"
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C25EA1AED58;
	Fri, 14 Jun 2024 17:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718386384; cv=none; b=nWXMN1GEf2DHeHuMkw6c/Ai06DK7xgG7w1t/1oe+gNXNUHHUYk97XA6TJzpUtRsWfLJ+90/TTURB7NVv+HoE9i0EafvaJFm5CSDygLV+F9zEHp5cgjjMJZMlngCprGe1QrdbFBhhfNoKRH3wTE4VbUC4gY4zLKETNFBzZQjvtmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718386384; c=relaxed/simple;
	bh=zoCc4TNVcL7n+F0RMiksAMgmLq9WnqeR7mq6Kf5Dx6k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DlXleBDxPW3VnEUJlTWU4fPd+4AqXJmG9hL64Kr/c0tvSHNx+how4xmRZqZNjfF1bWY7ocZ0o5/zVUq1uOB35waiKxPaeO18bRW/mu5jh4SonnGYnwPFJFKO1RMKE0PSE775bpS6FzH/Qiwq0r1LXSqt0YoXOewRb8gvhAq7jnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=MDhfD84t; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPA id B2696FF80F;
	Fri, 14 Jun 2024 17:33:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1718386381;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dbIYhZvFBgQOKeNKrpgIrZWNtdywW0MRjqSAyjPi9WI=;
	b=MDhfD84tbcqH2jCAZhK+8zTopQ3GfaxIIc+xxRspwt+V7Ji3j/iIKAmRBtBEVGMoRnIqM0
	35484UZe/JbAeyUMasGttWPxGYJIuEf7o9ZKWcgc0F02eCg+4dPXdNLK1Ls6JnIV+hSgce
	F4JGAcqKM7VOokHakL378HSV1iS8UiXvnP2RelD9RFa+5p+Y70EPC2RUW/hm3OBckzI1YV
	q1rg2D8FAvkhUE+Wyo9fEpeNaURtkhijmx68hY7swnNb0CVcevz5KXOzmMypIErviogyBB
	Or1AYN5R952kVlrinv4d/grvaQ0/2KeeCRgWCLIdrnlHzJWk3FslKYYHbQVG2Q==
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
Subject: [PATCH 18/23] irqdomain: Convert domain creation functions to irq_domain_instantiate()
Date: Fri, 14 Jun 2024 19:32:19 +0200
Message-ID: <20240614173232.1184015-19-herve.codina@bootlin.com>
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

Domain creation functions use __irq_domain_add(). With the introduction
of irq_domain_instantiate(), __irq_domain_add() becomes obsolete.

In order to fully remove __irq_domain_add(), convert domain
creation function to irq_domain_instantiate()

Signed-off-by: Herve Codina <herve.codina@bootlin.com>
---
 kernel/irq/irqdomain.c | 26 +++++++++++++++++++++-----
 1 file changed, 21 insertions(+), 5 deletions(-)

diff --git a/kernel/irq/irqdomain.c b/kernel/irq/irqdomain.c
index d95ca575a108..e1ceb2ba2699 100644
--- a/kernel/irq/irqdomain.c
+++ b/kernel/irq/irqdomain.c
@@ -442,10 +442,17 @@ struct irq_domain *irq_domain_create_simple(struct fwnode_handle *fwnode,
 					    const struct irq_domain_ops *ops,
 					    void *host_data)
 {
+	struct irq_domain_info info = {
+		.fwnode = fwnode,
+		.size = size,
+		.hwirq_max = size,
+		.ops = ops,
+		.host_data = host_data,
+	};
 	struct irq_domain *domain;
 
-	domain = __irq_domain_add(fwnode, size, size, 0, ops, host_data);
-	if (!domain)
+	domain = irq_domain_instantiate(&info);
+	if (IS_ERR(domain))
 		return NULL;
 
 	if (first_irq > 0) {
@@ -498,11 +505,20 @@ struct irq_domain *irq_domain_create_legacy(struct fwnode_handle *fwnode,
 					 const struct irq_domain_ops *ops,
 					 void *host_data)
 {
+	struct irq_domain_info info = {
+		.fwnode = fwnode,
+		.size = first_hwirq + size,
+		.hwirq_max = first_hwirq + size,
+		.ops = ops,
+		.host_data = host_data,
+	};
 	struct irq_domain *domain;
 
-	domain = __irq_domain_add(fwnode, first_hwirq + size, first_hwirq + size, 0, ops, host_data);
-	if (domain)
-		irq_domain_associate_many(domain, first_irq, first_hwirq, size);
+	domain = irq_domain_instantiate(&info);
+	if (IS_ERR(domain))
+		return NULL;
+
+	irq_domain_associate_many(domain, first_irq, first_hwirq, size);
 
 	return domain;
 }
-- 
2.45.0


