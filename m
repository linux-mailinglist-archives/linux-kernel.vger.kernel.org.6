Return-Path: <linux-kernel+bounces-395429-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DA1569BBDC6
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 20:09:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 59ADAB22FFB
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 19:09:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 717A91CEE8D;
	Mon,  4 Nov 2024 19:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZeeDAWOI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBE2D1CDFBE
	for <linux-kernel@vger.kernel.org>; Mon,  4 Nov 2024 19:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730747323; cv=none; b=ftOU6mREi4zZqhZzvl6bnZxrEKqINGXKuIvJQnoWBFsRerDq+xYvTDlyVudC4jBxRHeJrSmZi/OC/BUL+ZDwVnpEexMULMa5nwMY1UiL+mogN3lWSIRYUaR0+LGwN9Pj20G1Xv8hhWg6VYvQ9z8lfm628TMsK+e6pOh8aU3ecRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730747323; c=relaxed/simple;
	bh=/6rcbMtM42HcnHtS60PzjqVFy7pKZof26/BWcubLefQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=A3lHxzA6KY4V3NyZIRlH0vnKRGCuX+ya4SYKQOzZRJkJs6LgLEu7xDgOt8dUWTBuIBOg/DBWjPexzKyY0rCnNxdnE+rU0B3R1syawLdyoJhzd08JAPcI0U806yZCiVVDa/W8HgAoXUmluZMVbHu41OTe56j798TvEur4yNFMRFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZeeDAWOI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89C6DC4CECE;
	Mon,  4 Nov 2024 19:08:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730747323;
	bh=/6rcbMtM42HcnHtS60PzjqVFy7pKZof26/BWcubLefQ=;
	h=From:To:Cc:Subject:Date:From;
	b=ZeeDAWOIFGxAbASpg1wkeN5leoCtZslN+XiOFlneYPTVx1GWTOaBjf+Y0jagph0iQ
	 zQuiTrnzQ9dhxhV4pZANcAPElQz/Qi4tBrVCfdkucKcubur2s+qSfm+KC1ecX/7eL9
	 Q181IrhJ8Jl3RMFan00mJ1Cbd3ib0eisD3/ObWn6y9yZ7clBTP7a7aPZ3+Njy3d7hJ
	 e0MrlXdNhhpjWBqCRebmIbm32WT4tl+JG9ArS4M9tYDmwZfutLUtxWCc+teOc5MKZN
	 cUGEGHcjODbVCHWUrTil6y0RMZHSwxynilpnfjUUZCAu36NK5JyEpwJqy+/veYTa2f
	 0NLw5MExvoWFw==
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc: linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH] irqchip/stm32mp-exti: Use of_property_present() for non-boolean properties
Date: Mon,  4 Nov 2024 13:08:35 -0600
Message-ID: <20241104190836.278117-1-robh@kernel.org>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The use of of_property_read_bool() for non-boolean properties is
deprecated in favor of of_property_present() when testing for property
presence.

Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
---
 drivers/irqchip/irq-stm32mp-exti.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/irqchip/irq-stm32mp-exti.c b/drivers/irqchip/irq-stm32mp-exti.c
index 33e0cfdea654..cb83d6cc6113 100644
--- a/drivers/irqchip/irq-stm32mp-exti.c
+++ b/drivers/irqchip/irq-stm32mp-exti.c
@@ -696,8 +696,7 @@ static int stm32mp_exti_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	if (of_property_read_bool(np, "interrupts-extended"))
-		host_data->dt_has_irqs_desc = true;
+	host_data->dt_has_irqs_desc = of_property_present(np, "interrupts-extended");
 
 	return 0;
 }
-- 
2.45.2


