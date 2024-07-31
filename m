Return-Path: <linux-kernel+bounces-269604-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C31C9434C0
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 19:11:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 473DA1C21E82
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 17:11:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 139F01BE22F;
	Wed, 31 Jul 2024 17:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="w5zfckEp"
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7461E1BD4ED;
	Wed, 31 Jul 2024 17:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722445849; cv=none; b=L2hgVjX8IHmgdCtIdXEu+2hoZjIaq/9q6ciZOoxbVDn9jTL4w0ar6mMkoScs6PWJUlshAPdVROPPB7B2C50e40cTNr9NWqwak82H0cTFSv7yAS7mokRYJgm3yOwpILtZXkzoQ/YdcFTmOak3XHEJqGMJomv7zYCj/vzXuYsp6fg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722445849; c=relaxed/simple;
	bh=KM94wb8SuRIdpVfm4xCuPtTZylQRif7udldhutgnZw4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=Refb5DrlnvzWkkJtTLJra+56mYiRM/xItC9eSl3XHiec8mBLr1VYkqRhdd6w2IwEFH8GyCYsftRRGAm/aqU87SGDWlcpimSyW6gjxoIFdAAHA8HOPomQ31c1BHuZtjLIM6ek9Yz/2c+L34MeQqKzN7hWFpS7JUbwTrhImxMQtHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=w5zfckEp; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 46VHAdx4108309;
	Wed, 31 Jul 2024 12:10:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1722445839;
	bh=zlhZl1fpMtrinZXymNW6JMSzbiViJzfmhLV/rRTKFKo=;
	h=From:Date:Subject:References:In-Reply-To:To:CC;
	b=w5zfckEpPLcNKAb+6nG0CPzWyBzoVWdeGypu+4lHTHqSpmeTisfUumOsf2BUO6JJZ
	 BryLbWcJv+3ynm8vZtQrJXrsJgdqUiYZzFoFNTr2V0CxVS90vff5mv7mFzXxUCNxrh
	 ctBTmPD7t8nf/zeNtX3b7/J+P09f7Wx28Kkq4Ovc=
Received: from DLEE112.ent.ti.com (dlee112.ent.ti.com [157.170.170.23])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 46VHAd3C082425
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 31 Jul 2024 12:10:39 -0500
Received: from DLEE108.ent.ti.com (157.170.170.38) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 31
 Jul 2024 12:10:39 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 31 Jul 2024 12:10:39 -0500
Received: from [127.0.1.1] (uda0497581.dhcp.ti.com [10.24.68.185])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 46VHAVgO036362;
	Wed, 31 Jul 2024 12:10:36 -0500
From: Manorit Chawdhry <m-chawdhry@ti.com>
Date: Wed, 31 Jul 2024 22:40:27 +0530
Subject: [PATCH v3 1/9] arm64: dts: ti: Move j784s4-{} include files to
 j784s4-j742s2-{}-common.dtsi
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240731-b4-upstream-j742s2-v3-1-da7fe3aa9e90@ti.com>
References: <20240731-b4-upstream-j742s2-v3-0-da7fe3aa9e90@ti.com>
In-Reply-To: <20240731-b4-upstream-j742s2-v3-0-da7fe3aa9e90@ti.com>
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
        Aniket Limaye <a-limaye@ti.com>, Manorit Chawdhry
	<m-chawdhry@ti.com>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1722445831; l=3022;
 i=m-chawdhry@ti.com; s=20231127; h=from:subject:message-id;
 bh=KM94wb8SuRIdpVfm4xCuPtTZylQRif7udldhutgnZw4=;
 b=tGGJ7k1kPGo25yzuUOBTJit1k2bsNbaJoLy+XeNMCT6kxlX84Ih/QLuByt3X7MYkZPAb3Vf5a
 aadrohgbneYCd5dLCD81SpdYYmU1MsWNZ0lUlKuTbDbZ84dDr3HMP3+
X-Developer-Key: i=m-chawdhry@ti.com; a=ed25519;
 pk=fsr6Tm39TvsTgfyfFQLk+nnqIz2sBA1PthfqqfiiYSs=
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

J784S4 shares a lot of things with J742s2. Move the files to common so
that the split between j784s4 and j742s2 can be done at a later point.

Signed-off-by: Manorit Chawdhry <m-chawdhry@ti.com>
---
 .../ti/{k3-j784s4-main.dtsi => k3-j784s4-j742s2-main-common.dtsi}   | 2 +-
 ...84s4-mcu-wakeup.dtsi => k3-j784s4-j742s2-mcu-wakeup-common.dtsi} | 2 +-
 ...{k3-j784s4-thermal.dtsi => k3-j784s4-j742s2-thermal-common.dtsi} | 0
 arch/arm64/boot/dts/ti/k3-j784s4.dtsi                               | 6 +++---
 4 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi b/arch/arm64/boot/dts/ti/k3-j784s4-j742s2-main-common.dtsi
similarity index 99%
rename from arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi
rename to arch/arm64/boot/dts/ti/k3-j784s4-j742s2-main-common.dtsi
index f170f80f00c1..17abd0f1560a 100644
--- a/arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j784s4-j742s2-main-common.dtsi
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-only OR MIT
 /*
- * Device Tree Source for J784S4 SoC Family Main Domain peripherals
+ * Device Tree Source for J784S4 and J742S2 SoC Family Main Domain peripherals
  *
  * Copyright (C) 2022-2024 Texas Instruments Incorporated - https://www.ti.com/
  */
diff --git a/arch/arm64/boot/dts/ti/k3-j784s4-mcu-wakeup.dtsi b/arch/arm64/boot/dts/ti/k3-j784s4-j742s2-mcu-wakeup-common.dtsi
similarity index 99%
rename from arch/arm64/boot/dts/ti/k3-j784s4-mcu-wakeup.dtsi
rename to arch/arm64/boot/dts/ti/k3-j784s4-j742s2-mcu-wakeup-common.dtsi
index f3a6ed1c979d..346623fa2ee9 100644
--- a/arch/arm64/boot/dts/ti/k3-j784s4-mcu-wakeup.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j784s4-j742s2-mcu-wakeup-common.dtsi
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-only OR MIT
 /*
- * Device Tree Source for J784S4 SoC Family MCU/WAKEUP Domain peripherals
+ * Device Tree Source for J784S4 and J742S2 SoC Family MCU/WAKEUP Domain peripherals
  *
  * Copyright (C) 2022-2024 Texas Instruments Incorporated - https://www.ti.com/
  */
diff --git a/arch/arm64/boot/dts/ti/k3-j784s4-thermal.dtsi b/arch/arm64/boot/dts/ti/k3-j784s4-j742s2-thermal-common.dtsi
similarity index 100%
rename from arch/arm64/boot/dts/ti/k3-j784s4-thermal.dtsi
rename to arch/arm64/boot/dts/ti/k3-j784s4-j742s2-thermal-common.dtsi
diff --git a/arch/arm64/boot/dts/ti/k3-j784s4.dtsi b/arch/arm64/boot/dts/ti/k3-j784s4.dtsi
index 73cc3c1fec08..76e43ee44496 100644
--- a/arch/arm64/boot/dts/ti/k3-j784s4.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j784s4.dtsi
@@ -296,10 +296,10 @@ cbass_mcu_wakeup: bus@28380000 {
 	};
 
 	thermal_zones: thermal-zones {
-		#include "k3-j784s4-thermal.dtsi"
+		#include "k3-j784s4-j742s2-thermal-common.dtsi"
 	};
 };
 
 /* Now include peripherals from each bus segment */
-#include "k3-j784s4-main.dtsi"
-#include "k3-j784s4-mcu-wakeup.dtsi"
+#include "k3-j784s4-j742s2-main-common.dtsi"
+#include "k3-j784s4-j742s2-mcu-wakeup-common.dtsi"

-- 
2.45.1


