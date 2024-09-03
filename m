Return-Path: <linux-kernel+bounces-312437-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C96D9696A0
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 10:12:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2371A1F24F4F
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 08:12:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A404201248;
	Tue,  3 Sep 2024 08:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="uGyx0LAA"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0610C15573A;
	Tue,  3 Sep 2024 08:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725351164; cv=none; b=Q+DXupNDxY6QtCIvv/ye5EwWMcPuFF2JTGHeULCTAI74slrGJgMq9OmVz+IcndNwbFn3FjSSff0XS+R0kDRufnQ+jeYMl+y+QLwZpeVmPF0SHcH0tJCTFvzZnGP7HeoWRZC4Lv0G4fLeFu750cOeDpabDuh8PJFjNoBSganXfcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725351164; c=relaxed/simple;
	bh=O6fMx4aZUcqiaFE23C4p1D4ilSZnoIISHadiqvgdeWI=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=XsDK9AVBHkvU695LcsK04vSX8bAHiR0s09beGO+v0abbaEsmc3sBcIc14Z2hM0DCWDNZXkEN7S2eJjzyx9XuA4I8tbv7V/BdedWJCtNcl9VOGEYBRNCHVtm2sWbGe+oUc1o42zdjvuYgLxJbeusI4rr4FkdHjeGLQIlBpXd49Og=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=uGyx0LAA; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4838CVM0049868;
	Tue, 3 Sep 2024 03:12:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1725351151;
	bh=GqfQTypGsovyreDvPW1W4u4mSQvaqE2Q1zGIXLLx578=;
	h=From:Subject:Date:To:CC;
	b=uGyx0LAAryDY7P8VnQtImigdmXBr6Em1finHgLvS0mWN28AS9/AxqeSWD9Kk1f3R7
	 IprqH2+B3LkmAj7rQcLteude0rgdy4K7oz6V0w+n/hIXfrdiBPzLgl8q3S0ze5ppBB
	 LpNp5vMz7AtP36u8S98P7UlvxGT57esW/T9Kcol4=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4838CVvR023340;
	Tue, 3 Sep 2024 03:12:31 -0500
Received: from DLEE114.ent.ti.com (157.170.170.25) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 3
 Sep 2024 03:12:31 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 3 Sep 2024 03:12:31 -0500
Received: from [127.0.1.1] (uda0497581.dhcp.ti.com [10.24.68.185])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4838CQo8062032;
	Tue, 3 Sep 2024 03:12:27 -0500
From: Manorit Chawdhry <m-chawdhry@ti.com>
Subject: [PATCH RESEND v6 0/5] Introduce J742S2 SoC and EVM
Date: Tue, 3 Sep 2024 13:42:18 +0530
Message-ID: <20240903-b4-upstream-j742s2-v6-0-49d980fed889@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Tero
 Kristo <kristo@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof
 Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
CC: <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Udit Kumar <u-kumar1@ti.com>,
        Neha Malcom
 Francis <n-francis@ti.com>,
        Aniket Limaye <a-limaye@ti.com>, Beleswar Padhi
	<b-padhi@ti.com>,
        Siddharth Vadapalli <s-vadapalli@ti.com>,
        Manorit Chawdhry
	<m-chawdhry@ti.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1725351146; l=2226;
 i=m-chawdhry@ti.com; s=20231127; h=from:subject:message-id;
 bh=O6fMx4aZUcqiaFE23C4p1D4ilSZnoIISHadiqvgdeWI=;
 b=Rfd2kOY/FKkPMD0uQBuTsaKqRG+lBHkk74odN7xCJhLBWpZ2ET2ZT+woxpPnmcMX/nqK/PetI
 HnkaLg9j8o8BQFNqlqSJZAiIeaCjcB3ODVX8xeq8Mi2jK1lGkz9txDC
X-Developer-Key: i=m-chawdhry@ti.com; a=ed25519;
 pk=fsr6Tm39TvsTgfyfFQLk+nnqIz2sBA1PthfqqfiiYSs=
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

The series adds support for J742S2 family of SoCs. Also adds J742S2 EVM
Support and re-uses most of the stuff from the superset device J784s4.

It initially cleans up the J784s4 SoC files so that they can be
re-usable for j742s2 by introducing -common files. Next it cleans up the
EVM files for j784s4 in a similar way and then goes about adding the
support for j742s2.

Signed-off-by: Manorit Chawdhry <m-chawdhry@ti.com>
---
Changes in v6:
- Rebased on upstream-next
- Add a comment for MSMC node (Udit)
- Link to v5: https://lore.kernel.org/r/20240828-b4-upstream-j742s2-v5-0-9aaa02a0faee@ti.com

Changes in v5:
- Rebased on upstream-next
- Align j742s2 and j784s4 comments (Siddharth)
- Link to v4: https://lore.kernel.org/r/20240819-b4-upstream-j742s2-v4-0-f2284f6f771d@ti.com

---
Manorit Chawdhry (5):
      arm64: dts: ti: Refactor J784s4 SoC files to a common file
      arm64: dts: ti: Refactor J784s4-evm to a common file
      dt-bindings: arm: ti: Add bindings for J742S2 SoCs and Boards
      arm64: dts: ti: Introduce J742S2 SoC family
      arm64: dts: ti: Add support for J742S2 EVM board

 Documentation/devicetree/bindings/arm/ti/k3.yaml   |    6 +
 arch/arm64/boot/dts/ti/Makefile                    |    4 +
 arch/arm64/boot/dts/ti/k3-j742s2-evm.dts           |   26 +
 arch/arm64/boot/dts/ti/k3-j742s2-main.dtsi         |   45 +
 arch/arm64/boot/dts/ti/k3-j742s2.dtsi              |   98 +
 arch/arm64/boot/dts/ti/k3-j784s4-evm.dts           | 1488 +---------
 .../arm64/boot/dts/ti/k3-j784s4-j742s2-common.dtsi |  148 +
 .../boot/dts/ti/k3-j784s4-j742s2-evm-common.dtsi   | 1490 ++++++++++
 .../boot/dts/ti/k3-j784s4-j742s2-main-common.dtsi  | 2671 ++++++++++++++++++
 ...tsi => k3-j784s4-j742s2-mcu-wakeup-common.dtsi} |    2 +-
 ...l.dtsi => k3-j784s4-j742s2-thermal-common.dtsi} |    0
 arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi         | 2847 +-------------------
 arch/arm64/boot/dts/ti/k3-j784s4.dtsi              |  133 +-
 13 files changed, 4592 insertions(+), 4366 deletions(-)
---
base-commit: ecc768a84f0b8e631986f9ade3118fa37852fef0
change-id: 20240620-b4-upstream-j742s2-7ba652091550

Best regards,
-- 
Manorit Chawdhry <m-chawdhry@ti.com>


