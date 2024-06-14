Return-Path: <linux-kernel+bounces-215370-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 73F509091A7
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 19:35:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0250228E9CE
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 17:35:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DA081AC240;
	Fri, 14 Jun 2024 17:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="bOAGkTHf"
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45EF71A2FC4;
	Fri, 14 Jun 2024 17:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718386378; cv=none; b=ZT87njX3kAihXNchIEtCJR0UIAxS+ACCYE2sMtDSrDJML4OGoayp2yzec7rXUIX02n2dw5NFUMmzTA/jhyOAR3k5onOm81rsh62EEI+fMPuEUCqp8ATeTzly37y7uMcNcmjyD/NZSmmhpEAOJFB3n4Sc+yZJg7X2XphqLCixETE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718386378; c=relaxed/simple;
	bh=NrhshJgjm6LEY5OHT9wMuizZDHruRnog7t0GliFU43Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TQF9Vnp9eDu+C1WMtpPBHIw6rLJa872k8uydA0qvKPPmGuVw/rUn+UFOJ9bTR6UBHYNJGgEGN9h4PfZFYI1ZR/t6lhARLNbDB6Yd2uFKdVK4gS6SaJ2cTt+c+xxKX153H/vZE7G8cSWuj4QO5cIMAZ17+Fg8EviPdjLVxQZfG/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=bOAGkTHf; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPA id D4E0DFF80D;
	Fri, 14 Jun 2024 17:32:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1718386374;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6CVX37YYxogQc3necMFvOYHcfj0KlRLwJOiGoHdPMpg=;
	b=bOAGkTHf3Tt4ls6Rby+74mlUNWvvt7xuujriO8VAYqeS01DWwJH0z3FgQ768dyYI5qxHZb
	8UdUmTgJXVMAyPT5BgpS4RHVp74FS2dH4X1tbsIR8biMD5IzhtOYhd57YiMEH8X1VibSEl
	xijuFc1C6ngU/B6VZB1TtARWw62kO+4C97kaHLPiP4smjQNUCOj9jSE7Q/S9hPz2/Ndewd
	Hk7SHuz84/Iaqvo8j0yY24EFji/ZveAoOWlTYW8aUq33KcWNoQ+w8t04mqdfRHRS/vKnt3
	Y5OklgaaJ0wDlRNUH/4xrzsWwPLklEd5AoqGRdvZTq924IyaFOavphjhWeityg==
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
Subject: [PATCH 10/23] irqdomain: Make __irq_domain_create() return an error code
Date: Fri, 14 Jun 2024 19:32:11 +0200
Message-ID: <20240614173232.1184015-11-herve.codina@bootlin.com>
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

__irq_domain_create() can fail for several reasons. When it fails it
returns a NULL pointer and so filters out the exact failure reason.
The only user of __irq_domain_create() is irq_domain_instantiate() which
can return a PTR_ERR value. On __irq_domain_create() failure, it uses an
arbitrary error code.

Rather than using this arbitrary error value, make __irq_domain_create()
return is own error code and use that one.

Signed-off-by: Herve Codina <herve.codina@bootlin.com>
---
 kernel/irq/irqdomain.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/kernel/irq/irqdomain.c b/kernel/irq/irqdomain.c
index edfd386be985..5090b1c572c6 100644
--- a/kernel/irq/irqdomain.c
+++ b/kernel/irq/irqdomain.c
@@ -187,17 +187,17 @@ static struct irq_domain *__irq_domain_create(const struct irq_domain_info *info
 	if (WARN_ON((info->size && info->direct_max) ||
 		    (!IS_ENABLED(CONFIG_IRQ_DOMAIN_NOMAP) && info->direct_max) ||
 		    (info->direct_max && info->direct_max != info->hwirq_max)))
-		return NULL;
+		return ERR_PTR(-EINVAL);
 
 	domain = kzalloc_node(struct_size(domain, revmap, info->size),
 			      GFP_KERNEL, of_node_to_nid(to_of_node(info->fwnode)));
 	if (!domain)
-		return NULL;
+		return ERR_PTR(-ENOMEM);
 
 	err = irq_domain_set_name(domain, info->fwnode);
 	if (err) {
 		kfree(domain);
-		return NULL;
+		return ERR_PTR(err);
 	}
 
 	domain->fwnode = fwnode_handle_get(info->fwnode);
@@ -260,8 +260,8 @@ struct irq_domain *irq_domain_instantiate(const struct irq_domain_info *info)
 	struct irq_domain *domain;
 
 	domain = __irq_domain_create(info);
-	if (!domain)
-		return ERR_PTR(-ENOMEM);
+	if (IS_ERR(domain))
+		return ERR_CAST(domain);
 
 	domain->flags |= info->domain_flags;
 
-- 
2.45.0


