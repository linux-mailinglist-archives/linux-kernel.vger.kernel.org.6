Return-Path: <linux-kernel+bounces-215366-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 414809091A0
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 19:34:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 14E1D1C26076
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 17:34:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5DA21AB527;
	Fri, 14 Jun 2024 17:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="NqjJr4g4"
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF41019DF5A;
	Fri, 14 Jun 2024 17:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718386376; cv=none; b=sbXUCnzrCASVOH666rK58fTyBxbAdthiiCxy8mMRX6ZP7lIiM3ydmOdUgwNm0oZEhCyBb5DNCaIy6NGe0/+AcA5xpebvItAq3LvQJMfmQ10IECAfXlWDzWXMLNY8tqokv164+QDRiEigzGYuASwH3UHcHIkFP0TL8R+5n4DaL8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718386376; c=relaxed/simple;
	bh=PF38VuD+9IgZ9WgHHTfNlFHfOmN+wF9T8Nrddq3qlwY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GxYUDU2hqKrpq0frnw4CF1GnXfBLXwD7hlVSWyRZJuu/PDixSacKmKZPYVwGTasCANzd8wvqPp97rQNioF04Xo9vFul31qWDT6enysmF2Pb/ckENAZf0v2veI021t5oanlSS3aqJk1pO3X5ep2npGgdhHUKfYzqaTuNGrNNCt2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=NqjJr4g4; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPA id 52054FF809;
	Fri, 14 Jun 2024 17:32:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1718386372;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AMFrvT6Mdf1M8/KeTvOvOwVZ5loFJ3PtGAldEjb671s=;
	b=NqjJr4g4eXcxFlWRTnbsdfo6sVMTxYST9ZqL8ikpV8nap+AARRvMtiktNHwc6cYTUz4jm8
	MAKRY8pGwBQRrwd/tzOjV+ONRuSgmsUG4qkyaV0ESriPcUY/Dgb9EEELubShaaz7HygpaV
	UfyCkCtb1nNQRmqhByP59AgbhKaxaTajgrbBl5NjpLWDEWcWVS2DL1aQ6cuJPylUKcTKGx
	VL2AbzVH6bDjS5hxy8tcO2WWkkOvwZjtiOJeZuBdQN/i2AWEXXlvDY/FEAgtwsPc3osb3G
	+8H1qSV5ARKkUYxiO7wpJYMPxziQUeW2D7ij7nqhPzMvWdo/MzZPcMg7hqZ08g==
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
Subject: [PATCH 07/23] irqdomain: Handle additional domain flags in irq_domain_instantiate()
Date: Fri, 14 Jun 2024 19:32:08 +0200
Message-ID: <20240614173232.1184015-8-herve.codina@bootlin.com>
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

In order to use irq_domain_instantiate() from several places such as
irq_domain_create_hierarchy(), irq_domain_instantiate() needs to handle
additional domain flags.

Handle these additional flags.

Suggested-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Herve Codina <herve.codina@bootlin.com>
---
 include/linux/irqdomain.h | 2 ++
 kernel/irq/irqdomain.c    | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/include/linux/irqdomain.h b/include/linux/irqdomain.h
index a3b43e357009..4683b66eded9 100644
--- a/include/linux/irqdomain.h
+++ b/include/linux/irqdomain.h
@@ -260,6 +260,7 @@ void irq_domain_free_fwnode(struct fwnode_handle *fwnode);
 /**
  * struct irq_domain_info - Domain information structure
  * @fwnode:		firmware node for the interrupt controller
+ * @domain_flags:	Additional flags to add to the domain flags
  * @size:		Size of linear map; 0 for radix mapping only
  * @hwirq_max:		Maximum number of interrupts supported by controller
  * @direct_max:		Maximum value of direct maps;
@@ -269,6 +270,7 @@ void irq_domain_free_fwnode(struct fwnode_handle *fwnode);
  */
 struct irq_domain_info {
 	struct fwnode_handle			*fwnode;
+	unsigned int				domain_flags;
 	unsigned int				size;
 	irq_hw_number_t				hwirq_max;
 	int					direct_max;
diff --git a/kernel/irq/irqdomain.c b/kernel/irq/irqdomain.c
index 28a463e25d99..34acc2ccfee7 100644
--- a/kernel/irq/irqdomain.c
+++ b/kernel/irq/irqdomain.c
@@ -263,6 +263,8 @@ struct irq_domain *irq_domain_instantiate(const struct irq_domain_info *info)
 	if (!domain)
 		return ERR_PTR(-ENOMEM);
 
+	domain->flags |= info->domain_flags;
+
 	__irq_domain_publish(domain);
 
 	return domain;
-- 
2.45.0


