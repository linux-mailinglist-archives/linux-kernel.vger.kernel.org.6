Return-Path: <linux-kernel+bounces-193498-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D59708D2D11
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 08:18:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 12C2B1C21ACC
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 06:18:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F98A15FCFE;
	Wed, 29 May 2024 06:18:46 +0000 (UTC)
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97A0615ECD9;
	Wed, 29 May 2024 06:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=92.121.34.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716963525; cv=none; b=N1a6gmThno+YXDJtyIY3FwFq0v2BaxbtdGGojOi4IMuUxpE8O4r4A7NVgQ8k28Jx+evwf32IouBH5mfapVz4HIla20c5fVdUqyZJZjia4R7TSSKHfyOj1SdBxXs6O8XFyjGwoxKDQZqHnQjKJInZc3DShR0WZle0RZppZHtT/OI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716963525; c=relaxed/simple;
	bh=J3oHJ6BUvlEp4jAHQzUBker2OU7er4PvjG6IkKQziYo=;
	h=From:To:Cc:Subject:Date:Message-Id; b=esLhEWvbFYAmCkdoMJ2AF6hrrT55RrHflttCDgDQc7kpq3hSuueR44neiGIYuXpPuoYBBKD/21xYEc4Q/Lrj5gs97aOLVs06+xkebSbNNQsrT7N21bocTjZXf3x331DjK4Cv/JaFevH4iN5izHYUK5VK2ku+IDyHb2Kwm3l1DsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; arc=none smtp.client-ip=92.121.34.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Received: from inva021.nxp.com (localhost [127.0.0.1])
	by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 683CF20152B;
	Wed, 29 May 2024 08:18:35 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
	by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id D520D201527;
	Wed, 29 May 2024 08:18:34 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
	by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id D968E180222F;
	Wed, 29 May 2024 14:18:32 +0800 (+08)
From: Richard Zhu <hongxing.zhu@nxp.com>
To: conor@kernel.org,
	vkoul@kernel.org,
	kishon@kernel.org,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	frank.li@nxp.com,
	conor+dt@kernel.org
Cc: hongxing.zhu@nxp.com,
	linux-phy@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	kernel@pengutronix.de,
	imx@lists.linux.dev
Subject: [PATCH v7 0/2] Add i.MX8Q HSIO PHY support
Date: Wed, 29 May 2024 14:02:43 +0800
Message-Id: <1716962565-2084-1-git-send-email-hongxing.zhu@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

v7 changes:
Rebase to 6.10-rc1

dt-binding
- To keep the table format, add "|" to description of "fsl,hsio-cfg" property.
- Refine the contents of "fsl,hsio-cfg" property.
- Add Reviewed-by: Conor Dooley <conor.dooley@microchip.com> tag.
PHY driver
- Use "imx8qm_hsio_drvdata" as imx_hsio_drvdata struct name of i.MX8QM
- Remove redundant memset().
- Add Reviewed-by: Frank Li <Frank.Li@nxp.com> tag.

v6:https://patchwork.kernel.org/project/linux-phy/cover/1716865154-25044-1-git-send-email-hongxing.zhu@nxp.com/

v6 changes:
- Correct the spell mistake in binding document.
- Change the "fsl,hsio-cfg" property to an enum strings too.

v5:https://patchwork.kernel.org/project/linux-phy/cover/1715563324-6391-1-git-send-email-hongxing.zhu@nxp.com/

v5 changes:
dt-binding
- Fix dt_binding_check errors of fsl,refclk-pad-mode.
  And, add the unused description of this property.
- Add description for each register entry.
- Add fsl,hsio-cfg description.
- Other minor refine changes.

PHY driver
- To make codes safe enough in multi instances probe, use scoped_guard()
to replace the atomic_###() callbacks.

v4:https://patchwork.kernel.org/project/linux-phy/cover/1715234181-672-1-git-send-email-hongxing.zhu@nxp.com/

v4 changes:
- Re-format the "phy-cells" as <&hsio_phy lane_id phy_mode controller_id>
- Use each lane as a phys entry, suggested by Rob.
PCIEA:
phys = <&hsio_phy 0 PHY_MODE_PCIE>;
or:
phys = <&hsio_phy 0 PHY_MODE_PCIE>, <&hsio_phy 1 PHY_MODE_PCIE>;

PCIEB:
phys = <&hsio_phy 1 PHY_MODE_PCIE>;
or:
phys = <&hsio_phy 2 PHY_MODE_PCIE>;

SATA:
phys = <&hsio_phy 2 PHY_MODE_SATA>;

- Add a new propery "fsl,hsio-cfg".
The HSIO configuration (fsl,hsio-cfg) is one global state.
It should be known and used to set global setting: PCIE_AB_SELECT and
PHY_X1_EPCS_SEL at the begin of HSIO initialization like this listed below.

 +-------------------------------------------------------------+
 |CRR(SYS.CSR) register|PCIAx2 and|PCIEAx1, PCIEBx1|PCIEAx2 and|
 |                     |SATA      |SATA            |PCIEBx1    |
 |---------------------|----------|----------------|-----------|
 |PCIE_AB_SELECT       | 0        | 1              | 1         |
 |---------------------|----------|----------------|-----------|
 |PHY_X1_EPCS_SEL      | 1        | 1              | 0         |
 +-------------------------------------------------------------+
When first PHY instance is probed, PHY driver can't get a global view of the
HSIO use case and doesn't know how to set global setting: PCIE_AB_SELECT and
PHYX1_EPCS_SEL.
Because first PHY instance doesn't know followed PHY instance use mode.

So, one property named "fsl,hsio-cfg" has to be introduced here to specify the
setting of the global setting: PCIE_AB_SELECT and PHY_X1_EPCS_SEL.

Here is the discussion about this.
https://lkml.org/lkml/2024/4/26/231

- Address Conor's comments about the "fsl,refclk-pad-mode".
fsl,refclk-pad-mode:
  description:
    ...
  enum: ["input", "output"].

v3:https://patchwork.kernel.org/project/linux-phy/cover/1713939683-15328-1-git-send-email-hongxing.zhu@nxp.com/

v3 changes:
Refer to Conor's comments.
- Let filename match a compatible
- Refine description of the fsl,refclk-pad-mode.
- Remove power-domains description.
- Keep clock ording for two devices.
- Drop the unused label and status.
Refer to Rob's comments.
- Use standard phy mode defines.
- Correct the spell mistakes in the binding document.

v2:https://patchwork.kernel.org/project/linux-phy/cover/1712036704-21064-1-git-send-email-hongxing.zhu@nxp.com/ 

v2 changes:
- Place the dt-bindings header file changes as the first one
in the patch-set, make the annotation more clear, and add
Frank's Reviewed-by tag.

v1:https://patchwork.kernel.org/project/linux-phy/cover/1711699790-16494-1-git-send-email-hongxing.zhu@nxp.com/

[PATCH v7 1/2] dt-bindings: phy: Add i.MX8Q HSIO SerDes PHY binding
[PATCH v7 2/2] phy: freescale: imx8qm-hsio: Add i.MX8QM HSIO PHY

Documentation/devicetree/bindings/phy/fsl,imx8qm-hsio.yaml | 164 ++++++++++++++++++++++
drivers/phy/freescale/Kconfig                              |   9 +-
drivers/phy/freescale/Makefile                             |   1 +
drivers/phy/freescale/phy-fsl-imx8qm-hsio.c                | 610 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
4 files changed, 783 insertions(+), 1 deletion(-)

