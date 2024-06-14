Return-Path: <linux-kernel+bounces-215381-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 34F029091C1
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 19:38:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E023328B654
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 17:38:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA4C81B1503;
	Fri, 14 Jun 2024 17:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="hOHqyhLO"
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 016571B0128;
	Fri, 14 Jun 2024 17:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718386385; cv=none; b=oEjTtD49vAQKo74hThIGLRmWVes5CxGbjwCXG0TmTz6jM/y90xyvigXEsWWkKpNkZJHM4zmARCjjX/8wERHWpzRjMaLgZjTo0jYjAHWXnNMpzrTZkEEViVaf6A9dlXPdB2WX9MlhBGYH0E9hkbDXDqtUzTlzN4Ohu7+A8mQbcqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718386385; c=relaxed/simple;
	bh=c3bC7F7QNQIRu7ZQaHTt/iIzupdm+kobYH1rjjdpehY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GHjJ/KQnhge55A128Gu+TbQWFuSx9ZKm5HV67s3xYolnaBaX8hFcJ33t9sQ4FL+hFoaV9z5Gy+WBlx2qNvMpuaXlj7vAQkh8W+Sw6IybpFN1SfgT4xzAzxJ7rFoMR3RMHX7h6cvam8k+Dz3DY5WtQBcy4UjNN/HA2TjOVSpReAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=hOHqyhLO; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPA id 91E50FF812;
	Fri, 14 Jun 2024 17:33:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1718386382;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=w3cpBYdF6cMVxUW5Waih2GLzWLev0FdUvUlF6XEkz6w=;
	b=hOHqyhLOwwkkxkU6/4uv0vGXq4lG0/g6HnaOmVENSryxC7pYTsnYvJxvJl38DoAigBwEpJ
	UnSGTd+bGOyJHsZm7oqnQrIgUvs8hTf0mrBxs2OuvXXwpR+I65zbUCKj50dn6GjFB+bqCc
	qgl6Te/E5Q0wVwnbmAppzcm9etiqmeDEzfH2+YnaW99FoA3OvjlAoGrUmrmf8sF4RaSgn0
	dx9OButAg7KJoQOEdH9WsgqCvEY1Mxq209udmJTu43BenpEOI/8GrX2OidK2AJDpr4Oy/k
	oImLWkZ9rxOa82WSkXTHxNBSSB0oqLxd66T+Q4FgGdVj5OyFqkbpLDccQuR1yg==
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
Subject: [PATCH 19/23] um: virt-pci: Use irq_domain_instantiate()
Date: Fri, 14 Jun 2024 19:32:20 +0200
Message-ID: <20240614173232.1184015-20-herve.codina@bootlin.com>
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

um_pci_init() uses __irq_domain_add(). With the introduction of
irq_domain_instantiate(), __irq_domain_add() becomes obsolete.

In order to fully remove __irq_domain_add(), use directly
irq_domain_instantiate().

Signed-off-by: Herve Codina <herve.codina@bootlin.com>
---
 arch/um/drivers/virt-pci.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/arch/um/drivers/virt-pci.c b/arch/um/drivers/virt-pci.c
index 7cb503469bbd..597d89338693 100644
--- a/arch/um/drivers/virt-pci.c
+++ b/arch/um/drivers/virt-pci.c
@@ -986,6 +986,11 @@ static struct resource virt_platform_resource = {
 
 static int __init um_pci_init(void)
 {
+	struct irq_domain_info inner_domain_info = {
+		.size = MAX_MSI_VECTORS,
+		.hwirq_max = MAX_MSI_VECTORS,
+		.ops = &um_pci_inner_domain_ops,
+	};
 	int err, i;
 
 	WARN_ON(logic_iomem_add_region(&virt_cfgspace_resource,
@@ -1015,11 +1020,10 @@ static int __init um_pci_init(void)
 		goto free;
 	}
 
-	um_pci_inner_domain = __irq_domain_add(um_pci_fwnode, MAX_MSI_VECTORS,
-					       MAX_MSI_VECTORS, 0,
-					       &um_pci_inner_domain_ops, NULL);
-	if (!um_pci_inner_domain) {
-		err = -ENOMEM;
+	inner_domain_info.fwnode = um_pci_fwnode;
+	um_pci_inner_domain = irq_domain_instantiate(&inner_domain_info);
+	if (IS_ERR(um_pci_inner_domain)) {
+		err = PTR_ERR(um_pci_inner_domain);
 		goto free;
 	}
 
@@ -1056,7 +1060,7 @@ static int __init um_pci_init(void)
 		goto free;
 	return 0;
 free:
-	if (um_pci_inner_domain)
+	if (!IS_ERR_OR_NULL(um_pci_inner_domain))
 		irq_domain_remove(um_pci_inner_domain);
 	if (um_pci_fwnode)
 		irq_domain_free_fwnode(um_pci_fwnode);
-- 
2.45.0


