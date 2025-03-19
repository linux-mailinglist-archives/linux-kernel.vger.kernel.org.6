Return-Path: <linux-kernel+bounces-567610-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27A2DA6884C
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 10:40:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C6B0D176A9D
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 09:38:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8567125BAD9;
	Wed, 19 Mar 2025 09:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fhzi6EAK"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9EFE253B7B
	for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 09:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742376756; cv=none; b=sRFEO76JfB69THPR4AgKr7BeVpbqPwI2TBmFcWrZElsk8tLz3/cO3jayzbBvY7+NTDiGr+Q6VHffu2MtORbr4TeCo+jI6V1M+aFV4zCWEcR69CCisxrv8ls0wSbH1PJ/P/2OqrmsFQ9We5xKNfzxq54aEApRPGWmBEob25HXBp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742376756; c=relaxed/simple;
	bh=tZpnDeVQx9vLoEpc1EadaGV/CSqjQYXNqPacKZyWa1s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iDJ3yGbcDoDkOZUB+THPtbBeWJHrWGGgJb/7Y+3Yz+ze5AnhfH2oMRXyRLoXnMJQeb+HiATWTE/AKuTps8cYnmrGRJU6mNQh3SaoBiPkhkKqrRvqEI0IcGivvgNhiVtigfBuiprlvSqIMdqwDG7kPYHzCmcP+lcdhhiFngTIdrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fhzi6EAK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06A85C4CEEA;
	Wed, 19 Mar 2025 09:32:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742376756;
	bh=tZpnDeVQx9vLoEpc1EadaGV/CSqjQYXNqPacKZyWa1s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Fhzi6EAKAbU+Illv0bvyNM6NX1pkl+9SKXofmBHz8idUGkReYwQpOqrbAKEPTF6+o
	 Ek8eY/Ff8KqG050OFIQWfB5f4ynOn+xDNGhjCNqpgha1dIB4nXVXG58k6QIqLDL4Dg
	 I7NeQDnX3TJyq4nxQ44AfVO1hGDZrplfToAzMZfoOnPWV5S6BIkQXTbTSK8megg/VC
	 /M9aLJ9msOCxaTLBVpmrdb+fFzbjlc5G+Msan3e1wCfhb4+tTizcShUS95IkO/B8+5
	 jVovDiC55LUmoMH0DFHb+8LbblHPU4ocWsjzuLnfI0W0KdjNhd3V1AX6o6+HRt22L6
	 3NY+ZpFV3VYMg==
From: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To: tglx@linutronix.de
Cc: maz@kernel.org,
	linux-kernel@vger.kernel.org,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
	Andrew Lunn <andrew@lunn.ch>,
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
	Gregory Clement <gregory.clement@bootlin.com>,
	Qiang Zhao <qiang.zhao@nxp.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>
Subject: [PATCH v2 34/57] irqdomain: soc: Switch to irq_domain_create_*()
Date: Wed, 19 Mar 2025 10:29:27 +0100
Message-ID: <20250319092951.37667-35-jirislaby@kernel.org>
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

irq_domain_add_*() interfaces are going away as being obsolete now.
Switch to the preferred irq_domain_create_*() ones. Those differ in the
node parameter: They take more generic struct fwnode_handle instead of
struct device_node. Therefore, of_fwnode_handle() is added around the
original parameter.

Note some of the users can likely use dev->fwnode directly instead of
indirect of_fwnode_handle(dev->of_node). But dev->fwnode is not
guaranteed to be set for all, so this has to be investigated on case to
case basis (by people who can actually test with the HW).

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
Cc: Andrew Lunn <andrew@lunn.ch>
Cc: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Cc: Gregory Clement <gregory.clement@bootlin.com>
Cc: Qiang Zhao <qiang.zhao@nxp.com>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: Bjorn Andersson <andersson@kernel.org>
Cc: Konrad Dybcio <konradybcio@kernel.org>
Cc: Thierry Reding <thierry.reding@gmail.com>
Cc: Jonathan Hunter <jonathanh@nvidia.com>
---
 drivers/soc/dove/pmu.c     | 4 ++--
 drivers/soc/fsl/qe/qe_ic.c | 4 ++--
 drivers/soc/qcom/smp2p.c   | 2 +-
 drivers/soc/qcom/smsm.c    | 2 +-
 drivers/soc/tegra/pmc.c    | 5 +++--
 5 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/drivers/soc/dove/pmu.c b/drivers/soc/dove/pmu.c
index 6202dbcd20a8..cfc0efab27d7 100644
--- a/drivers/soc/dove/pmu.c
+++ b/drivers/soc/dove/pmu.c
@@ -274,8 +274,8 @@ static int __init dove_init_pmu_irq(struct pmu_data *pmu, int irq)
 	writel(0, pmu->pmc_base + PMC_IRQ_MASK);
 	writel(0, pmu->pmc_base + PMC_IRQ_CAUSE);
 
-	domain = irq_domain_add_linear(pmu->of_node, NR_PMU_IRQS,
-				       &irq_generic_chip_ops, NULL);
+	domain = irq_domain_create_linear(of_fwnode_handle(pmu->of_node), NR_PMU_IRQS,
+					  &irq_generic_chip_ops, NULL);
 	if (!domain) {
 		pr_err("%s: unable to add irq domain\n", name);
 		return -ENOMEM;
diff --git a/drivers/soc/fsl/qe/qe_ic.c b/drivers/soc/fsl/qe/qe_ic.c
index bbae3d39c7be..e5831c298ad6 100644
--- a/drivers/soc/fsl/qe/qe_ic.c
+++ b/drivers/soc/fsl/qe/qe_ic.c
@@ -446,8 +446,8 @@ static int qe_ic_init(struct platform_device *pdev)
 		high_handler = NULL;
 	}
 
-	qe_ic->irqhost = irq_domain_add_linear(node, NR_QE_IC_INTS,
-					       &qe_ic_host_ops, qe_ic);
+	qe_ic->irqhost = irq_domain_create_linear(of_fwnode_handle(node), NR_QE_IC_INTS,
+						  &qe_ic_host_ops, qe_ic);
 	if (qe_ic->irqhost == NULL) {
 		dev_err(dev, "failed to add irq domain\n");
 		return -ENODEV;
diff --git a/drivers/soc/qcom/smp2p.c b/drivers/soc/qcom/smp2p.c
index a3e88ced328a..8c8878bc87f5 100644
--- a/drivers/soc/qcom/smp2p.c
+++ b/drivers/soc/qcom/smp2p.c
@@ -399,7 +399,7 @@ static int qcom_smp2p_inbound_entry(struct qcom_smp2p *smp2p,
 				    struct smp2p_entry *entry,
 				    struct device_node *node)
 {
-	entry->domain = irq_domain_add_linear(node, 32, &smp2p_irq_ops, entry);
+	entry->domain = irq_domain_create_linear(of_fwnode_handle(node), 32, &smp2p_irq_ops, entry);
 	if (!entry->domain) {
 		dev_err(smp2p->dev, "failed to add irq_domain\n");
 		return -ENOMEM;
diff --git a/drivers/soc/qcom/smsm.c b/drivers/soc/qcom/smsm.c
index e803ea342c97..021e9d1f61dc 100644
--- a/drivers/soc/qcom/smsm.c
+++ b/drivers/soc/qcom/smsm.c
@@ -456,7 +456,7 @@ static int smsm_inbound_entry(struct qcom_smsm *smsm,
 		return ret;
 	}
 
-	entry->domain = irq_domain_add_linear(node, 32, &smsm_irq_ops, entry);
+	entry->domain = irq_domain_create_linear(of_fwnode_handle(node), 32, &smsm_irq_ops, entry);
 	if (!entry->domain) {
 		dev_err(smsm->dev, "failed to add irq_domain\n");
 		return -ENOMEM;
diff --git a/drivers/soc/tegra/pmc.c b/drivers/soc/tegra/pmc.c
index 51b9d852bb6a..e0d67bfe955c 100644
--- a/drivers/soc/tegra/pmc.c
+++ b/drivers/soc/tegra/pmc.c
@@ -2500,8 +2500,9 @@ static int tegra_pmc_irq_init(struct tegra_pmc *pmc)
 	pmc->irq.irq_set_type = pmc->soc->irq_set_type;
 	pmc->irq.irq_set_wake = pmc->soc->irq_set_wake;
 
-	pmc->domain = irq_domain_add_hierarchy(parent, 0, 96, pmc->dev->of_node,
-					       &tegra_pmc_irq_domain_ops, pmc);
+	pmc->domain = irq_domain_create_hierarchy(parent, 0, 96,
+						  of_fwnode_handle(pmc->dev->of_node),
+						  &tegra_pmc_irq_domain_ops, pmc);
 	if (!pmc->domain) {
 		dev_err(pmc->dev, "failed to allocate domain\n");
 		return -ENOMEM;
-- 
2.49.0


