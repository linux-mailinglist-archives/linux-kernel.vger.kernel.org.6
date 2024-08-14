Return-Path: <linux-kernel+bounces-286041-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 526EF9515C4
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 09:47:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C934B28A1D0
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 07:47:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C97413C827;
	Wed, 14 Aug 2024 07:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Ua8izzGl"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 256A36A01E;
	Wed, 14 Aug 2024 07:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723621665; cv=none; b=rcOLVPwFCnyCNzB9wMqSlBPH2gkLm3SGRjU0oClrMyGYDlCgZoBHdDtMQMJRs8AA64Ztmm9Rua4yfXYkZqXX/5O47g1Djfp2Hpqq55BihEtYmPqQZBYrxcsjb8RP3RNFBB+3X9nc2EZggQK94NV/fBzoPE+vijl2xmUjruGeczs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723621665; c=relaxed/simple;
	bh=Y3jb0LeRC71RlnUxsHNgVMczB0m7y8914iA/EX6oxBA=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=nFD2j6bm9VzfXDYINfKJt9MkIoV4k7IRUGXs5DIXQi5eFxykjFWVfgS4fZ23skM65JsBt6t6LxDEIscdgJ3CoXPeHuAOuLqWlRkVczaie5knOpEXHmMyJu+lz7tcvYs/WSBfvCdTqeFuRHR19YRkIjvWSLZwe+e5asiLzHrysuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=Ua8izzGl; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 47E7lZER106350;
	Wed, 14 Aug 2024 02:47:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1723621655;
	bh=6h/3SqkwVGcRGTy44j6pSLcJBwq4DMbU1XJdozxZlUY=;
	h=From:Subject:Date:To:CC;
	b=Ua8izzGlnQxVoIWrpk45hwqTsAk7i7S2K3jNvAJAQF54pI+Cq/tUk4wNqwbyh4hr1
	 0jYKjiiW9Wj+Dm84mSa294kSfqZzb5KIcNqkjk5WZ5F9JSrpQk0xDlx1fWA1sokOc9
	 SaJDXcM8nwUbNAVmwkTWyhpiqSPxm9CeiBHVVDQE=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 47E7lZig113659
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 14 Aug 2024 02:47:35 -0500
Received: from DFLE113.ent.ti.com (10.64.6.34) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 14
 Aug 2024 02:47:34 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 14 Aug 2024 02:47:34 -0500
Received: from [127.0.1.1] (uda0497581.dhcp.ti.com [10.24.68.185])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 47E7lT2E059812;
	Wed, 14 Aug 2024 02:47:30 -0500
From: Manorit Chawdhry <m-chawdhry@ti.com>
Subject: [PATCH v4 0/5] Add bootph-all property for J7 boards
Date: Wed, 14 Aug 2024 13:17:27 +0530
Message-ID: <20240814-b4-upstream-bootph-all-v4-0-f2b462000f25@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAA9hvGYC/3XPyQqDMBCA4VeRnJsyxizaU9+j9GAWa0CNJDa0i
 O/eaKHLweM/MN8wMwrGWxPQKZuRN9EG64YU9JAh1dbDzWCrUyMChAItAEuK72OYvKl7LJ2bxhb
 XXYdLTYUURCpoNErLozeNfWzw5Zq6tWFy/rndifk6fZMMxB4ZcwxYcc0IZ3nJeHOe7FG5Hq1eJ
 F9DANs1SDIqAMHL3Gihyz+j+DH2X4vFakhFjFKSV4x8jGVZXmHrxrNBAQAA
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
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1723621650; l=2628;
 i=m-chawdhry@ti.com; s=20231127; h=from:subject:message-id;
 bh=Y3jb0LeRC71RlnUxsHNgVMczB0m7y8914iA/EX6oxBA=;
 b=5BkfgpYqVhM7kl8CyJ76MJoWCKbn4V7kSDCYWBt/Qis/deOap1JJsDI0JYFn1YPoP3fVZtE5e
 AM4n6LkEPK9AeqZISxWWOGf/sNUlUqyyLifjwS7jtk81UaAfN2TyJ+X
X-Developer-Key: i=m-chawdhry@ti.com; a=ed25519;
 pk=fsr6Tm39TvsTgfyfFQLk+nnqIz2sBA1PthfqqfiiYSs=
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

The idea of this series is to add bootph-all and bootph-pre-ram property
in all the leaf nodes wherever required and cleanup any other places where
bootph-all/bootph-pre-ram exist in the parent nodes as well.

Signed-off-by: Manorit Chawdhry <m-chawdhry@ti.com>
---
Changes in v4:
* Andrew
- Change U-boot to bootloaders in commit description

* Udit
- Remove bootph-all from j784s4 main_pmx0
- Update the commit message to call out bootph movement from mcu_timer1
  to mcu_timer0 in j784s4
- Fix mcu_uart0 pinmux alignment with the node.
- Change bootph-all to bootph-pre-ram in main_esm
- Add bootph-all to ospi.phypattern

* Nishanth
- Update bootph in correct ordering.

- Align bootph in hbmc and hbmc_mux node as well.
- Link to v3: https://lore.kernel.org/r/20240730-b4-upstream-bootph-all-v3-0-9bc2eccb6952@ti.com

---
Manorit Chawdhry (5):
      arm64: dts: ti: k3-j721s2*: Add bootph-* properties
      arm64: dts: ti: k3-j784s4*: Remove bootph properties from parent nodes
      arm64: dts: ti: k3-am68*: Add bootph-* properties
      arm64: dts: ti: k3-j721e*: Add bootph-* properties
      arm64: dts: ti: k3-j7200*: Add bootph-* properties

 arch/arm64/boot/dts/ti/k3-am68-sk-base-board.dts     | 11 +++++++++++
 arch/arm64/boot/dts/ti/k3-am68-sk-som.dtsi           |  5 +++--
 .../arm64/boot/dts/ti/k3-j7200-common-proc-board.dts | 20 ++++++++++++++++++++
 arch/arm64/boot/dts/ti/k3-j7200-main.dtsi            |  2 ++
 arch/arm64/boot/dts/ti/k3-j7200-mcu-wakeup.dtsi      | 13 ++++++++++++-
 arch/arm64/boot/dts/ti/k3-j7200-som-p0.dtsi          |  7 +++++++
 .../arm64/boot/dts/ti/k3-j721e-common-proc-board.dts | 20 ++++++++++++++++++++
 arch/arm64/boot/dts/ti/k3-j721e-main.dtsi            |  2 ++
 arch/arm64/boot/dts/ti/k3-j721e-mcu-wakeup.dtsi      | 12 +++++++++++-
 arch/arm64/boot/dts/ti/k3-j721e-sk.dts               | 18 ++++++++++++++++++
 arch/arm64/boot/dts/ti/k3-j721e-som-p0.dtsi          |  5 +++++
 .../boot/dts/ti/k3-j721s2-common-proc-board.dts      | 14 ++++++++++++++
 arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi           |  4 +++-
 arch/arm64/boot/dts/ti/k3-j721s2-mcu-wakeup.dtsi     | 17 +++++++++++++++--
 arch/arm64/boot/dts/ti/k3-j721s2-som-p0.dtsi         |  2 ++
 arch/arm64/boot/dts/ti/k3-j784s4-evm.dts             | 10 +---------
 arch/arm64/boot/dts/ti/k3-j784s4-mcu-wakeup.dtsi     | 10 ++++++----
 17 files changed, 152 insertions(+), 20 deletions(-)
---
base-commit: 9e6869691724b12e1f43655eeedc35fade38120c
change-id: 20240430-b4-upstream-bootph-all-8d47b72bc0fd

Best regards,
-- 
Manorit Chawdhry <m-chawdhry@ti.com>


