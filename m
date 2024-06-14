Return-Path: <linux-kernel+bounces-215377-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DD7909091B8
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 19:37:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6D55A2893C3
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 17:37:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 217B61B012B;
	Fri, 14 Jun 2024 17:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="dEv8F+Yn"
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 543591AD9F5;
	Fri, 14 Jun 2024 17:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718386383; cv=none; b=kUNwLD9ju9P/mUiqF7Xb+VeA8m4hV/T90zf8M8EXaiSRLbdkrsXhCjZ/CQR9Dtefl8UXI3SjgwmtqxaIimIgLqQ/IfUhDqfQVjpwZBh+wNdPy6skitLnPzohqQXKkApejmADDHfxDJEW/pQHo58SRfWlfA09eNQ9UDPZrgGjglE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718386383; c=relaxed/simple;
	bh=+GEMoT9fsybF2t6htFlaw8fkxkNsZBe9GF9d/ejPY80=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SKP5q/QW5MEcUDxAzeaTt4YZ/+/GLCQeyH8egSf92n9SZSW6wF6jPg50PgpUwiAmGpKi0XUarqWe75cTmGqXu9liVsjIPgnr86LUoeGz2aCu3C40YKiDPVa0p5rwy+YkNvdAGLN+B/BSGZX2+AMEXVJu6yky7TsX0tPEzBzO+7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=dEv8F+Yn; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPA id 1569EFF806;
	Fri, 14 Jun 2024 17:32:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1718386379;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TgSTclGEyMVNAcyML8FqLvo4YRpuke6IGp+WHuItynU=;
	b=dEv8F+YnoNI0QIBoh3E5anMu3hKDqUOCr8ora+u+Di5YR922JEF+cKtDfeUAM6W3MK1yuU
	zZOBncfdU/J4snrEKG7burRvMzc4gCJW3fkvfKsNmQHoqJONN3PsE0v9DnEoQmk9YTLrGq
	qayVRK9g3/daqT9BizVyKmQ3aUZB9THh5TNa7QG0rKRcPQvql4rEY+9UmapVDWiWcwXB5H
	j7kvJWE4WvIqxaPjsT3Z3oIrgdU3gzhyzre0jNOb7NyoJX9+VbQ+hT8MuOJhiIh5ZI1tfe
	Smx+ZrOZpDDru6tzqqm/opoLeAehq5Q9LUWxuz12kWrsMi262Zx2akJKw4gYww==
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
Subject: [PATCH 16/23] irqdomain: Add a resource managed version of irq_domain_instantiate()
Date: Fri, 14 Jun 2024 19:32:17 +0200
Message-ID: <20240614173232.1184015-17-herve.codina@bootlin.com>
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

Add a devres version of irq_domain_instantiate().

Signed-off-by: Herve Codina <herve.codina@bootlin.com>
---
 include/linux/irqdomain.h |  2 ++
 kernel/irq/devres.c       | 41 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 43 insertions(+)

diff --git a/include/linux/irqdomain.h b/include/linux/irqdomain.h
index 5540b22a755c..8820317582c4 100644
--- a/include/linux/irqdomain.h
+++ b/include/linux/irqdomain.h
@@ -304,6 +304,8 @@ struct irq_domain_info {
 };
 
 struct irq_domain *irq_domain_instantiate(const struct irq_domain_info *info);
+struct irq_domain *devm_irq_domain_instantiate(struct device *dev,
+					       const struct irq_domain_info *info);
 
 struct irq_domain *__irq_domain_add(struct fwnode_handle *fwnode, unsigned int size,
 				    irq_hw_number_t hwirq_max, int direct_max,
diff --git a/kernel/irq/devres.c b/kernel/irq/devres.c
index f6e5515ee077..b3e98668f4dd 100644
--- a/kernel/irq/devres.c
+++ b/kernel/irq/devres.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <linux/module.h>
 #include <linux/interrupt.h>
+#include <linux/irqdomain.h>
 #include <linux/device.h>
 #include <linux/gfp.h>
 #include <linux/irq.h>
@@ -282,3 +283,43 @@ int devm_irq_setup_generic_chip(struct device *dev, struct irq_chip_generic *gc,
 }
 EXPORT_SYMBOL_GPL(devm_irq_setup_generic_chip);
 #endif /* CONFIG_GENERIC_IRQ_CHIP */
+
+#ifdef CONFIG_IRQ_DOMAIN
+static void devm_irq_domain_remove(struct device *dev, void *res)
+{
+	struct irq_domain **domain = res;
+
+	irq_domain_remove(*domain);
+}
+
+/**
+ * devm_irq_domain_instantiate() - Instantiate a new irq domain data for a
+ *                                 managed device.
+ * @dev:	Device to instantiate the domain for
+ * @info:	Domain information pointer pointing to the information for this
+ *		domain
+ *
+ * Return: A pointer to the instantiated irq domain or an ERR_PTR value.
+ */
+struct irq_domain *devm_irq_domain_instantiate(struct device *dev,
+					       const struct irq_domain_info *info)
+{
+	struct irq_domain *domain;
+	struct irq_domain **dr;
+
+	dr = devres_alloc(devm_irq_domain_remove, sizeof(*dr), GFP_KERNEL);
+	if (!dr)
+		return ERR_PTR(-ENOMEM);
+
+	domain = irq_domain_instantiate(info);
+	if (!IS_ERR(domain)) {
+		*dr = domain;
+		devres_add(dev, dr);
+	} else {
+		devres_free(dr);
+	}
+
+	return domain;
+}
+EXPORT_SYMBOL_GPL(devm_irq_domain_instantiate);
+#endif /* CONFIG_IRQ_DOMAIN */
-- 
2.45.0


