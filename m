Return-Path: <linux-kernel+bounces-567612-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FEF9A6884B
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 10:40:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 08575188E5BB
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 09:39:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B775625BADE;
	Wed, 19 Mar 2025 09:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZrGAUEN5"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 250F1253B7E
	for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 09:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742376761; cv=none; b=Y6Sswn4SUc4xUwy84b50Pisa071jaFuqtKS7W17Xls4OT4cXKa7he8MFWkV31B0WE+1Di+gvRlKVSlJQYWDZqCPIlt5e03qnZJoE0Sbk5Qq5n+a0M8DH+aHRYu7YDbg1L5JM29JkNi5sDoSTNCTmTUo5OP988E5And1MST9DIHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742376761; c=relaxed/simple;
	bh=Z4yA1AHEAaUKQTQ9BXveXhf762g+/LA8fFsPbfITlKc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CN0r2/dZtRRLanvuC93bQdlJoPJrNrQviCgxcmlExGqpV39vVHTxZA7rdeRhm5u01+icFbe1xrtk1xqguPYvNpHq2QQ0QuUOOQxHTwJtvTSwgmwMs5hVRJ2sA3wUpquVYfpuYCgALgZUY1zvPCaHgbTav/B1vUGZ0uyhLZQjsK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZrGAUEN5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3642C4CEEA;
	Wed, 19 Mar 2025 09:32:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742376761;
	bh=Z4yA1AHEAaUKQTQ9BXveXhf762g+/LA8fFsPbfITlKc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZrGAUEN5HcUy65VXgldOPlWfqb6WG81/8lH0a2Yf9OqO4fnKf88SivWBkT/9ihpuq
	 8azJwwfTClHTpKfa90hChUNJPZWmsx5aq4V50wfdrTOjJYOPez+kk9bOiPC07AWGaP
	 1BWNNh+xj9RJfhUF8UfEtY5GfRHYXTNtbItwsaV/6y7w7JvlXHp/GTJQa2AYq4lsmI
	 b3ja0kZ8PpS/mNc2Y+t31CeUjV0I0tdiLGTyMTKv8ROOENnDeqKWM3PZ2GpEqs0KqD
	 iVOHaws8+ENGuvem2NYPVGP5+iHkDlzi9qrFLZz5eD8fXkfKtbL363PvpihgSYsFDv
	 LRBMsm7OE8fxA==
From: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To: tglx@linutronix.de
Cc: maz@kernel.org,
	linux-kernel@vger.kernel.org,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
	Stephen Boyd <sboyd@kernel.org>
Subject: [PATCH v2 36/57] irqdomain: spmi: Switch to irq_domain_create_tree()
Date: Wed, 19 Mar 2025 10:29:29 +0100
Message-ID: <20250319092951.37667-37-jirislaby@kernel.org>
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

irq_domain_add_tree() is going away as being obsolete now. Switch to
the preferred irq_domain_create_tree(). That differs in the first
parameter: It takes more generic struct fwnode_handle instead of struct
device_node. Therefore, of_fwnode_handle() is added around the
parameter.

Note some of the users can likely use dev->fwnode directly instead of
indirect of_fwnode_handle(dev->of_node). But dev->fwnode is not
guaranteed to be set for all, so this has to be investigated on case to
case basis (by people who can actually test with the HW).

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
Cc: Stephen Boyd <sboyd@kernel.org>
---
 drivers/spmi/spmi-pmic-arb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spmi/spmi-pmic-arb.c b/drivers/spmi/spmi-pmic-arb.c
index 5c058db21821..91581974ef84 100644
--- a/drivers/spmi/spmi-pmic-arb.c
+++ b/drivers/spmi/spmi-pmic-arb.c
@@ -1737,7 +1737,7 @@ static int spmi_pmic_arb_bus_init(struct platform_device *pdev,
 
 	dev_dbg(&pdev->dev, "adding irq domain for bus %d\n", bus_index);
 
-	bus->domain = irq_domain_add_tree(node, &pmic_arb_irq_domain_ops, bus);
+	bus->domain = irq_domain_create_tree(of_fwnode_handle(node), &pmic_arb_irq_domain_ops, bus);
 	if (!bus->domain) {
 		dev_err(&pdev->dev, "unable to create irq_domain\n");
 		return -ENOMEM;
-- 
2.49.0


