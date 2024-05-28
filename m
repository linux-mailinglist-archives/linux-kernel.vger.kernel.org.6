Return-Path: <linux-kernel+bounces-191677-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F2E68D127D
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 05:19:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D32792840B6
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 03:19:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F2B418638;
	Tue, 28 May 2024 03:19:27 +0000 (UTC)
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43220171A7;
	Tue, 28 May 2024 03:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=92.121.34.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716866366; cv=none; b=Ix0Fsr892SugVV6IP9MzqFhj1zQAxr07p88MPkU5B7PV6LnPavGdbUfp+GPs9ebLThaODEYviI1RkJsMZ89Iuz6stDLCFv1q+e4i1bfKGHqMb6t1nSDRg9vsViSzNam7kJu9OTgsrRWfdzpb9b7rpThUPFqA5QSL0aoBia4xXRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716866366; c=relaxed/simple;
	bh=BCjgtX7qnroMhhttvjYYhYxVp0B4QNrMVcp4hig0gvQ=;
	h=From:To:Cc:Subject:Date:Message-Id; b=NzwZrcvzAUudgbR8pCyKZJkqN5hGrNFpUtawnP3MsfiShTkOVePyY1PlBlGgOrreDL1g6hO9UOX/7QhXLbd+zl8Zub1/4t9LbUiXNHKQxd00McfxGv1/9Yi28mUkmhMOnpysvq++zhdMhXM62Ti9MGIxw0Xzs/T523+okJtM0A0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; arc=none smtp.client-ip=92.121.34.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Received: from inva021.nxp.com (localhost [127.0.0.1])
	by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 2F1CF201D3C;
	Tue, 28 May 2024 05:19:17 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
	by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id A99EF2011C0;
	Tue, 28 May 2024 05:19:16 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
	by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id B4DC7180222F;
	Tue, 28 May 2024 11:19:14 +0800 (+08)
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
Subject: [PATCH v6 0/2] Add i.MX8Q HSIO PHY support
Date: Tue, 28 May 2024 10:59:12 +0800
Message-Id: <1716865154-25044-1-git-send-email-hongxing.zhu@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

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

[PATCH v6 1/2] dt-bindings: phy: Add i.MX8Q HSIO SerDes PHY binding
[PATCH v6 2/2] phy: freescale: imx8qm-hsio: Add i.MX8QM HSIO PHY

Documentation/devicetree/bindings/phy/fsl,imx8qm-hsio.yaml | 164 ++++++++++++++++++++++
drivers/phy/freescale/Kconfig                              |   8 ++
drivers/phy/freescale/Makefile                             |   1 +
drivers/phy/freescale/phy-fsl-imx8qm-hsio.c                | 612 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
4 files changed, 785 insertions(+)

