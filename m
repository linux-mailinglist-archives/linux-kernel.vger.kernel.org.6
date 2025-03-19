Return-Path: <linux-kernel+bounces-567614-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B6EFA68849
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 10:39:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DDD217A9569
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 09:38:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F792255238;
	Wed, 19 Mar 2025 09:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QUx3Q2w1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5967325523F
	for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 09:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742376767; cv=none; b=o6L0CZ5/NJgf2n1SnpLWhg4QTQhRO0QIlktBaCn6Hn961kLlfxHoQEnLzuccm/qXNRS/vZaGajX6eSydCbwzOFqbvycqqS7yU5V+jgqHCCWahXzEg/++ao6vdjV2shH+3/ISU+V8r+pddBnKoc3odyrThiHnxWq9ldezGJT2bR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742376767; c=relaxed/simple;
	bh=gyEWu07dvJTaObjS4W75J1syxJG8BbEtWYsDPPpR630=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=syQDjLI5qP6njD3XIJpRjEL9O6OEI4j946dPnrtEeTbpHGSi7FDoDWu3G5Ksg1/5s5+gXbyrA+GwCGd+7aOr9IqJZP2iPSHw1z6Zw/yTRJZh/QFhobbBDTd9cZCXeBLZAcRiM53bQU45ioRA8325WTjSZTP1W0F55QhC689AJpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QUx3Q2w1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A73CC4CEE9;
	Wed, 19 Mar 2025 09:32:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742376765;
	bh=gyEWu07dvJTaObjS4W75J1syxJG8BbEtWYsDPPpR630=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QUx3Q2w1Awz+kZNKlePLdrewm550hrP1tQ8Qngc4cBHBZym1CPkJWHThbaWWO2Py4
	 GIBIKuNO0JoXv2hvvcrEQBPnlSZI29Ow8toDvq/znAmYXlrvII1ppds3GNWoazebIi
	 IXNm3TbqXpebRS3hcDaJq0UvjXPGKz2h9aZ6rVfB0rocWv2tHvSyIqWZwpGN70T0oC
	 2Dti6NDZ7O+kRVkl2dKopVIm+7MUfpOCDnmpFdl1wGpMcGAL2z5c3EsUifo4Mqsob8
	 NhFX1YHgIltd0SFcVyhoIONhF0uS+mKjIpmKuP7SjktFmYbsdDbRfB2c3xGlM/N8Pa
	 hUecIlpAIvBDw==
From: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To: tglx@linutronix.de
Cc: maz@kernel.org,
	linux-kernel@vger.kernel.org,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
	Amit Kucheria <amitk@kernel.org>,
	Thara Gopinath <thara.gopinath@gmail.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>
Subject: [PATCH v2 38/57] irqdomain: thermal: Switch to irq_domain_create_linear()
Date: Wed, 19 Mar 2025 10:29:31 +0100
Message-ID: <20250319092951.37667-39-jirislaby@kernel.org>
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
Cc: Amit Kucheria <amitk@kernel.org>
Cc: Thara Gopinath <thara.gopinath@gmail.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Zhang Rui <rui.zhang@intel.com>
Cc: Lukasz Luba <lukasz.luba@arm.com>
Cc: Thierry Reding <thierry.reding@gmail.com>
Cc: Jonathan Hunter <jonathanh@nvidia.com>
---
 drivers/thermal/qcom/lmh.c       | 3 ++-
 drivers/thermal/tegra/soctherm.c | 2 +-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/thermal/qcom/lmh.c b/drivers/thermal/qcom/lmh.c
index d2d49264cf83..991d1573983d 100644
--- a/drivers/thermal/qcom/lmh.c
+++ b/drivers/thermal/qcom/lmh.c
@@ -209,7 +209,8 @@ static int lmh_probe(struct platform_device *pdev)
 	}
 
 	lmh_data->irq = platform_get_irq(pdev, 0);
-	lmh_data->domain = irq_domain_add_linear(np, 1, &lmh_irq_ops, lmh_data);
+	lmh_data->domain = irq_domain_create_linear(of_fwnode_handle(np), 1, &lmh_irq_ops,
+						    lmh_data);
 	if (!lmh_data->domain) {
 		dev_err(dev, "Error adding irq_domain\n");
 		return -EINVAL;
diff --git a/drivers/thermal/tegra/soctherm.c b/drivers/thermal/tegra/soctherm.c
index 2c5ddf0db40c..926f1052e6de 100644
--- a/drivers/thermal/tegra/soctherm.c
+++ b/drivers/thermal/tegra/soctherm.c
@@ -1234,7 +1234,7 @@ static int soctherm_oc_int_init(struct device_node *np, int num_irqs)
 	soc_irq_cdata.irq_chip.irq_set_type = soctherm_oc_irq_set_type;
 	soc_irq_cdata.irq_chip.irq_set_wake = NULL;
 
-	soc_irq_cdata.domain = irq_domain_add_linear(np, num_irqs,
+	soc_irq_cdata.domain = irq_domain_create_linear(of_fwnode_handle(np), num_irqs,
 						     &soctherm_oc_domain_ops,
 						     &soc_irq_cdata);
 
-- 
2.49.0


