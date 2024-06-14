Return-Path: <linux-kernel+bounces-215364-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D833690919C
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 19:34:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F20B28DD69
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 17:34:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8B2F1A38ED;
	Fri, 14 Jun 2024 17:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="VQBWA83d"
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EBC519DF5D;
	Fri, 14 Jun 2024 17:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718386376; cv=none; b=SaoeFLw/EIX3gk7dgRM76K6lXPh7KWl75yzu5h5B+ui6HqLeVeWe4V335p6yMbh0pgWEQU/U/ELpGRtxofAlcJgQf1DYj0mdyii1kf8rGszFzZKKBNfpUGqI5mWzlavURd0yvCzymfC92mXiAyMVJsWzJ9mJXj6pTE421tVgS9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718386376; c=relaxed/simple;
	bh=kEUiQ1CYjLj755ILvY6eux74YH9KYDJzi2RBOyIeGR8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E2QLXhKV4tcjp+3erJ5S75JKPLQw90nj//9jmPKCDwHS894jND5gssxPhyuXtUn16LwpgMqlMwi8POrhxtYO+ELqaZpPVjp08s2EV8nobKjKO6fknVbz18riM1hc5Rvl1P/EpEIpF+jlyNNb69WDvRI4tyvdE9tBMHmCyoCq1Ec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=VQBWA83d; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPA id 2C61DFF80C;
	Fri, 14 Jun 2024 17:32:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1718386372;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+NkYxenKEC9OO3jJ3gxAE6moq1UMvEUEbQkI5OAK8Bk=;
	b=VQBWA83dpargUL4CS6k35jbg8SKlxJAGPHYkzdgEEmtSl5vL1cntkYI6XkIIjtpa9pDh4C
	Av7cVO9vJakY5eylBEXku6OTiL6KMd2IOoKoyZB1SLoNStAzpyvs85hnVXiKH67aGUg5LB
	cNwthBjvoeORgsoaoJphzeU0KPfxvLfHwOvCaJdYipR1WwrcdSwhr4lt7trgfKo87JTomj
	eYlaobYjgGaP/5//iadWWn3YmYO8hWG7wTbkm86mYcq0xYCQouc+z91tocA0gslxRiXzir
	ZjNP2Vq6LDpRBig9FY/deNx2YTwmjqn037zuEpG0NOWpBeyNn9I+8emIGlKV9A==
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
Subject: [PATCH 08/23] irqdomain: Handle domain hierarchy parent in irq_domain_instantiate()
Date: Fri, 14 Jun 2024 19:32:09 +0200
Message-ID: <20240614173232.1184015-9-herve.codina@bootlin.com>
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

To use irq_domain_instantiate() from irq_domain_create_hierarchy(),
irq_domain_instantiate() needs to handle the domain hierarchy parent.

Handle this parent.

Signed-off-by: Herve Codina <herve.codina@bootlin.com>
---
 include/linux/irqdomain.h | 6 ++++++
 kernel/irq/irqdomain.c    | 7 +++++++
 2 files changed, 13 insertions(+)

diff --git a/include/linux/irqdomain.h b/include/linux/irqdomain.h
index 4683b66eded9..e52fd5e5494c 100644
--- a/include/linux/irqdomain.h
+++ b/include/linux/irqdomain.h
@@ -276,6 +276,12 @@ struct irq_domain_info {
 	int					direct_max;
 	const struct irq_domain_ops		*ops;
 	void					*host_data;
+#ifdef CONFIG_IRQ_DOMAIN_HIERARCHY
+	/**
+	 * @parent: Pointer to the parent irq domain used in a hierarchy domain
+	 */
+	struct irq_domain			*parent;
+#endif
 };
 
 struct irq_domain *irq_domain_instantiate(const struct irq_domain_info *info);
diff --git a/kernel/irq/irqdomain.c b/kernel/irq/irqdomain.c
index 34acc2ccfee7..7e4a1da63549 100644
--- a/kernel/irq/irqdomain.c
+++ b/kernel/irq/irqdomain.c
@@ -265,6 +265,13 @@ struct irq_domain *irq_domain_instantiate(const struct irq_domain_info *info)
 
 	domain->flags |= info->domain_flags;
 
+#ifdef CONFIG_IRQ_DOMAIN_HIERARCHY
+	if (info->parent) {
+		domain->root = info->parent->root;
+		domain->parent = info->parent;
+	}
+#endif
+
 	__irq_domain_publish(domain);
 
 	return domain;
-- 
2.45.0


