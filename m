Return-Path: <linux-kernel+bounces-567586-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 62B4BA6881E
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 10:34:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 805C41895552
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 09:34:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A737256C6E;
	Wed, 19 Mar 2025 09:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X4m2YTZ8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE7C1256C65
	for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 09:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742376681; cv=none; b=t0K+DkbTuetcV4kfeDF+x2FpufqnNJ3roquBu+tih4YiEuEtY5NT10heuwud6w1YyYx64ku6aTNyz278Ot7vEuXPLZ2GH+20umj5nDVbxvHuj8VZlNgaoezH0OjiAo99uzSswgH5VkmOx6cR29F4iq2sMszqmLwDXDeZ2mm8PYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742376681; c=relaxed/simple;
	bh=geXQPeT6Ko/A+eBHGZJ7ocWnSItb0Cs6pjE+xVOGMOI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cW7OXLByfBzQk+FeSq/1DMiipw5jrYp2SYIhzxyhZbYZl0Li4Ae3sboExqBtBCMjNXHQSjsIbq8BMfv9tTJ7fjkxtydOy2rC8UiaN6e+JeYft15bkvKoafvv/5i3VfifCBSkNDI4SBfXHY6YMXjQC//vrqUC1biTyNJUuwytO8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X4m2YTZ8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28A25C4CEEE;
	Wed, 19 Mar 2025 09:31:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742376679;
	bh=geXQPeT6Ko/A+eBHGZJ7ocWnSItb0Cs6pjE+xVOGMOI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=X4m2YTZ8OjLf+TmKDNW5RsCAiPOC0LiIdFlAEIdw2q97LLMBs4hxW2zjFFq8xqWr7
	 N8maUQYfmeitpGcDqhoRga72NKT/vDb/tNXvHXIabLnp4OzxESyNWMFj/mwm+aA7ss
	 dyyYCHW+vwjlKKp4VU6TbEoUXli5fCLyUsgVKVQPC8LPjkfplkPNnwh3px9rbvRPAS
	 hHa0I3vR7+nTFoJo9WDOcVU7r0ChYyakH3bKEW0OpefBJqKBarYZMb1wS7zgzkpaOi
	 HSpqRonxcjqI5y5yLJIu4d71rIwWhDp2vIuP4WFThDoT9+qyDDTs+xkKxIlDEKYVCs
	 aUI0BmIMSHmzQ==
From: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To: tglx@linutronix.de
Cc: maz@kernel.org,
	linux-kernel@vger.kernel.org,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
	Vineet Gupta <vgupta@kernel.org>,
	linux-snps-arc@lists.infradead.org
Subject: [PATCH v2 13/57] irqdomain: arc: Switch to irq_domain_create_linear()
Date: Wed, 19 Mar 2025 10:29:06 +0100
Message-ID: <20250319092951.37667-14-jirislaby@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250319092951.37667-1-jirislaby@kernel.org>
References: <20250319092951.37667-1-jirislaby@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

irq_domain_add_linear() is going away as being obsolete now. Switch to
the preferred irq_domain_create_linear(). That differs in the first
parameter: It takes more generic struct fwnode_handle instead of struct
device_node. Therefore, of_fwnode_handle() is added around the
parameter.

Note some of the users can likely use dev->fwnode directly instead of
indirect of_fwnode_handle(dev->of_node). But dev->fwnode is not
guaranteed to be set for all, so this has to be investigated on case to
case basis (by people who can actually test with the HW).

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
Cc: Vineet Gupta <vgupta@kernel.org>
Cc: linux-snps-arc@lists.infradead.org
---
 arch/arc/kernel/intc-arcv2.c   | 2 +-
 arch/arc/kernel/intc-compact.c | 5 +++--
 arch/arc/kernel/mcip.c         | 3 ++-
 3 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/arch/arc/kernel/intc-arcv2.c b/arch/arc/kernel/intc-arcv2.c
index fea29d9d18d6..809edc59af25 100644
--- a/arch/arc/kernel/intc-arcv2.c
+++ b/arch/arc/kernel/intc-arcv2.c
@@ -170,7 +170,7 @@ init_onchip_IRQ(struct device_node *intc, struct device_node *parent)
 	if (parent)
 		panic("DeviceTree incore intc not a root irq controller\n");
 
-	root_domain = irq_domain_add_linear(intc, nr_cpu_irqs, &arcv2_irq_ops, NULL);
+	root_domain = irq_domain_create_linear(of_fwnode_handle(intc), nr_cpu_irqs, &arcv2_irq_ops, NULL);
 	if (!root_domain)
 		panic("root irq domain not avail\n");
 
diff --git a/arch/arc/kernel/intc-compact.c b/arch/arc/kernel/intc-compact.c
index 1d2ff1c6a61b..1b159e9e0234 100644
--- a/arch/arc/kernel/intc-compact.c
+++ b/arch/arc/kernel/intc-compact.c
@@ -112,8 +112,9 @@ init_onchip_IRQ(struct device_node *intc, struct device_node *parent)
 	if (parent)
 		panic("DeviceTree incore intc not a root irq controller\n");
 
-	root_domain = irq_domain_add_linear(intc, NR_CPU_IRQS,
-					    &arc_intc_domain_ops, NULL);
+	root_domain = irq_domain_create_linear(of_fwnode_handle(intc),
+					       NR_CPU_IRQS,
+					       &arc_intc_domain_ops, NULL);
 	if (!root_domain)
 		panic("root irq domain not avail\n");
 
diff --git a/arch/arc/kernel/mcip.c b/arch/arc/kernel/mcip.c
index cdd370ec9280..02b28a9324f4 100644
--- a/arch/arc/kernel/mcip.c
+++ b/arch/arc/kernel/mcip.c
@@ -391,7 +391,8 @@ idu_of_init(struct device_node *intc, struct device_node *parent)
 
 	pr_info("MCIP: IDU supports %u common irqs\n", nr_irqs);
 
-	domain = irq_domain_add_linear(intc, nr_irqs, &idu_irq_ops, NULL);
+	domain = irq_domain_create_linear(of_fwnode_handle(intc), nr_irqs,
+					  &idu_irq_ops, NULL);
 
 	/* Parent interrupts (core-intc) are already mapped */
 
-- 
2.49.0


