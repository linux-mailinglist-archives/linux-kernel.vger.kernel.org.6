Return-Path: <linux-kernel+bounces-377484-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CF7EB9ABF80
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 08:59:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8BE94285ACF
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 06:59:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71E8415696E;
	Wed, 23 Oct 2024 06:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="gYz9EMVr"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5E6C155743;
	Wed, 23 Oct 2024 06:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729666679; cv=none; b=WuCeIjD1xzvgTi4awhnNZaHzrJicNFxtNrnajyhiTMY97e4c6xZwUIC4ocZsvJl4zQ31V8QPCSGXt99tQD0SotpoAJIQQfPL+NLUySvTiy+n/WHrT4vr31QfD1MoUrH6vIa4Uvw4F9iphiQw4QK6miC040f1hZoriFaeicIcHtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729666679; c=relaxed/simple;
	bh=2rax7yKIhQsvJYcFNUUG2GwYkUux9uFf7U2h0ad1IhY=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=exuNLfpn52ZQ1r6EC5Hr+7tiWUmxRN5a7iiiKLATThicbxsgJMuJF7/XJ9F+lvdIM3tUpzsomd7OZmV9pTDZ8OSD8pCdIxzV+kNDtNM7IPJlhZ8LF0cxHljgQh1wmJDfJbhmsTdUklAwYLGbZ67ftdJ+Iw9tubsWsheXARY+cTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=gYz9EMVr; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 49N6vbRv031021;
	Wed, 23 Oct 2024 01:57:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1729666657;
	bh=EoDhictmZsJJtG/6BZ26mfYqwG6vumYLSrV54R2HCM0=;
	h=From:Subject:Date:To:CC;
	b=gYz9EMVrbCWsV2S9+AVGvzpNktXjH8+amxKcvvQCwDBaIPBXpqxEAd1n/0xTTr3iR
	 yE/xnWju66BAthFenC19tPCN1eT/RGi7NLDW27XPW7rLNEyzWQlFGtalgYV51TUKJD
	 z1hRttD8zoBbprEx41DI8C5AMlvWMjbD5y9Ouvk0=
Received: from DFLE107.ent.ti.com (dfle107.ent.ti.com [10.64.6.28])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 49N6vbAC006031
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 23 Oct 2024 01:57:37 -0500
Received: from DFLE114.ent.ti.com (10.64.6.35) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 23
 Oct 2024 01:57:36 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 23 Oct 2024 01:57:36 -0500
Received: from [127.0.1.1] (uda0497581.dhcp.ti.com [10.24.68.185])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 49N6vWUN129058;
	Wed, 23 Oct 2024 01:57:32 -0500
From: Manorit Chawdhry <m-chawdhry@ti.com>
Subject: [PATCH v5 00/12] Add bootph-all property for J7 boards
Date: Wed, 23 Oct 2024 12:27:14 +0530
Message-ID: <20241023-b4-upstream-bootph-all-v5-0-a974d06370ab@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAEqeGGcC/3XPS27CMBCA4asgr3E1nvgFK+5RsYhfxBLgyE4tq
 ih3r0OlUhZZ/iPNN5qZFJ+jL+S4m0n2NZaY7i3Efkfs0N8vnkbXmiAgB94BNZx+jWXKvr9Rk9I
 0DrS/Xql2XBmFxkJwpC2P2Yf4eMKf59ZDLFPK3887la3TX1KA2iIro0CtdAKlYFrIcJrih003s
 noVX4YCsWlgMw4ASmrmnXL6zej+Gduv1W41jEVvrZEHgW8Gfxma8U2DNyOg4RIBIKD4M5Zl+QE
 y8N2+hQEAAA==
To: Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Tero
 Kristo <kristo@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof
 Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
CC: <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Neha Malcom Francis <n-francis@ti.com>,
        Aniket Limaye <a-limaye@ti.com>, Udit Kumar <u-kumar1@ti.com>,
        Beleswar Padhi
	<b-padhi@ti.com>,
        Siddharth Vadapalli <s-vadapalli@ti.com>, Andrew Davis
	<afd@ti.com>,
        Manorit Chawdhry <m-chawdhry@ti.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1729666652; l=3137;
 i=m-chawdhry@ti.com; s=20231127; h=from:subject:message-id;
 bh=2rax7yKIhQsvJYcFNUUG2GwYkUux9uFf7U2h0ad1IhY=;
 b=NrpsPdITotx96VGFq/zPvy2ItlU0MFt58GQqxaXkUXEciVEEkhk8fZJSzusSRzs0xX1HHQSni
 hdrWzj7SwtBAgNx3kb30Ug9hox3cUo4BsjitViiac03HqMUuq2/s1NM
X-Developer-Key: i=m-chawdhry@ti.com; a=ed25519;
 pk=fsr6Tm39TvsTgfyfFQLk+nnqIz2sBA1PthfqqfiiYSs=
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

The idea of this series is to add bootph-all and bootph-pre-ram property
in all the leaf nodes wherever required and cleanup any other places where
bootph-all/bootph-pre-ram exist in the parent nodes as well since now
the bootloaders can handle it.

Signed-off-by: Manorit Chawdhry <m-chawdhry@ti.com>
---
Changes in v5:
* Nishanth
- Break the patch into EVM and SoC

- Drop serdes0_pcie_link, serdes0_qsgmii_link, serdes_ln_ctrl bootph tags
- Drop usb0 bootph from am68-base-board
- Drop exp nodes bootph from j7200 and j721e ( along with main_i2c )
- Drop wkup_gpio bootph as it is only used as interrupt parent or for CAN nodes
- Sort some missed bootph entries

- Drop Aniket and Neha's r-by due to quite a few changes in j721e and
  j7200
- Link to v4: https://lore.kernel.org/r/20240814-b4-upstream-bootph-all-v4-0-f2b462000f25@ti.com

---
Manorit Chawdhry (12):
      arm64: dts: ti: k3-j784s4-j742s2-mcu-wakeup: Move bootph from mcu_timer1 to mcu_timer0
      arm64: dts: ti: k3-j784s4-j742s2-mcu-wakeup: Remove parent nodes bootph-*
      arm64: dts: ti: k3-j784s4: Add bootph-* properties
      arm64: dts: ti: k3-j721s2: Add bootph-* properties
      arm64: dts: ti: k3-j721e: Add bootph-* properties
      arm64: dts: ti: k3-j7200: Add bootph-* properties
      arm64: dts: ti: k3-j784s4-j742s2-evm-common: Remove parent nodes bootph-*
      arm64: dts: ti: k3-j721s2-evm*: Add bootph-* properties
      arm64: dts: ti: k3-am68-sk*: Add bootph-* properties
      arm64: dts: ti: k3-j721e-evm*: Add bootph-* properties
      arm64: dts: ti: k3-j721e-sk*: Add bootph-* properties
      arm64: dts: ti: k3-j7200-evm*: Add bootph-* properties

 arch/arm64/boot/dts/ti/k3-am68-sk-base-board.dts       |  8 ++++++++
 arch/arm64/boot/dts/ti/k3-am68-sk-som.dtsi             |  5 +++--
 arch/arm64/boot/dts/ti/k3-j7200-common-proc-board.dts  | 13 +++++++++++++
 arch/arm64/boot/dts/ti/k3-j7200-main.dtsi              |  2 ++
 arch/arm64/boot/dts/ti/k3-j7200-mcu-wakeup.dtsi        | 11 +++++++++++
 arch/arm64/boot/dts/ti/k3-j7200-som-p0.dtsi            |  6 ++++++
 arch/arm64/boot/dts/ti/k3-j721e-common-proc-board.dts  | 16 ++++++++++++++++
 arch/arm64/boot/dts/ti/k3-j721e-main.dtsi              |  2 ++
 arch/arm64/boot/dts/ti/k3-j721e-mcu-wakeup.dtsi        | 10 ++++++++++
 arch/arm64/boot/dts/ti/k3-j721e-sk.dts                 | 18 ++++++++++++++++++
 arch/arm64/boot/dts/ti/k3-j721e-som-p0.dtsi            |  5 +++++
 arch/arm64/boot/dts/ti/k3-j721s2-common-proc-board.dts | 14 ++++++++++++++
 arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi             |  1 +
 arch/arm64/boot/dts/ti/k3-j721s2-mcu-wakeup.dtsi       | 13 +++++++++++++
 arch/arm64/boot/dts/ti/k3-j721s2-som-p0.dtsi           |  3 +++
 .../arm64/boot/dts/ti/k3-j784s4-j742s2-evm-common.dtsi |  9 ---------
 .../dts/ti/k3-j784s4-j742s2-mcu-wakeup-common.dtsi     | 10 ++++++----
 17 files changed, 131 insertions(+), 15 deletions(-)
---
base-commit: 63b3ff03d91ae8f875fe8747c781a521f78cde17
change-id: 20240430-b4-upstream-bootph-all-8d47b72bc0fd

Best regards,
-- 
Manorit Chawdhry <m-chawdhry@ti.com>


