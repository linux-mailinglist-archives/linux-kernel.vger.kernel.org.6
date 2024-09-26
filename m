Return-Path: <linux-kernel+bounces-339948-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F09E986C80
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 08:31:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C76731F24D7D
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 06:31:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B22319F123;
	Thu, 26 Sep 2024 06:30:40 +0000 (UTC)
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D03C192B8D;
	Thu, 26 Sep 2024 06:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=92.121.34.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727332239; cv=none; b=TmLFNDRxTwcXaUyJyhYycH0etR5yG0gPOXLS5bS6r3/jvexkeSzZ+BhR4I3vl2Pi8iuda8r6nnfT8VaVuwqbn96CMJQeCN6EIQFFIUG68hbYBzEzhnU+kZ6aVqUW6gQKU6cmDmGBLVHr+BikOjbipK6/KWvj7K225hbB1RKV5yA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727332239; c=relaxed/simple;
	bh=6as8uSvobANLTHVQ+QqtRdxfRbnCU31rrj0qGIeM2KQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=W19giBEI3gQO9/AI0v8yMwgQuMFtzKGdYxPs1LpwRNPW9PgKBkkSdkVsxNgdzRNQdKpcd+ebIcQMuLfVZMLFCIMTxs7QjI6g8xYlFPRR8CiLJILVfrBwTTQi4/1glVOpK0ZRscH6+5/aOaJnAJcnJ/AkJ/V8FIN5AxLiS3M5D+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; arc=none smtp.client-ip=92.121.34.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Received: from inva020.nxp.com (localhost [127.0.0.1])
	by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 322431A0FA7;
	Thu, 26 Sep 2024 08:30:37 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
	by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 030A51A0FC1;
	Thu, 26 Sep 2024 08:30:37 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
	by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 16982183F0C0;
	Thu, 26 Sep 2024 14:30:33 +0800 (+08)
From: Richard Zhu <hongxing.zhu@nxp.com>
To: l.stach@pengutronix.de,
	kwilczynski@kernel.org,
	bhelgaas@google.com,
	lpieralisi@kernel.org,
	frank.li@nxp.com,
	robh+dt@kernel.org,
	conor+dt@kernel.org,
	shawnguo@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	festevam@gmail.com,
	s.hauer@pengutronix.de
Cc: linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	kernel@pengutronix.de,
	imx@lists.linux.dev,
	Richard Zhu <hongxing.zhu@nxp.com>
Subject: [PATCH v3 5/9] PCI: imx6: Make core reset assertion deassertion symmetric
Date: Thu, 26 Sep 2024 14:07:49 +0800
Message-Id: <1727330873-17486-6-git-send-email-hongxing.zhu@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1727330873-17486-1-git-send-email-hongxing.zhu@nxp.com>
References: <1727330873-17486-1-git-send-email-hongxing.zhu@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Add apps_reset deassertion in the imx_pcie_deassert_core_reset(). Let it be
symmetric with imx_pcie_assert_core_reset().

Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/pci/controller/dwc/pci-imx6.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index d49154dbb1bd..f306f2e9dcce 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -770,6 +770,7 @@ static void imx_pcie_assert_core_reset(struct imx_pcie *imx_pcie)
 static int imx_pcie_deassert_core_reset(struct imx_pcie *imx_pcie)
 {
 	reset_control_deassert(imx_pcie->pciephy_reset);
+	reset_control_deassert(imx_pcie->apps_reset);
 
 	if (imx_pcie->drvdata->core_reset)
 		imx_pcie->drvdata->core_reset(imx_pcie, false);
-- 
2.37.1


