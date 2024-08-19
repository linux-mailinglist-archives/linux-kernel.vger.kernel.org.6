Return-Path: <linux-kernel+bounces-292898-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A46559575E5
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 22:44:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 32E7D284114
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 20:44:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B233E159598;
	Mon, 19 Aug 2024 20:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="lm0aV51/"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBD7615921B
	for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 20:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724100250; cv=none; b=J6YRNEWM9NCgB5sXJdZ4okmL6vmG0y0Sq78moKqWumbhyg1hCPqYWRaUz/hM8y6KFZAKHUZKOBb8zjcXa2Ul8nydyZPG5YOl9DlBDcys9wg/vtl2E03yoTiaLZXQjVlgqx/nqtm4KJIMDoeCXFWyw6GxyeFCBNo24Xbqh6vf7as=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724100250; c=relaxed/simple;
	bh=AEquITEGXqCulA4wa1w144IgjY9QUK93eqFo8dwxKKg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=jONC+PYs8HvRcgFXETvyGd6XBbxXqV+rXOMTwv+tpOGnmPoyDuSiDWpHPhw2HGCYT3ST/BcJSUsRG0BDDNwh+klaC8Wh1EK00wRwXW0RNQ4Dw2K2Xr/v/asi4m+RNPRIGCcPjv7D1vHEhMUIcprItXz/P/sRS1O6SmCTZ6T8kus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=lm0aV51/; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 47JKhqOc089762;
	Mon, 19 Aug 2024 15:43:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1724100232;
	bh=/M4mzabDb17GXIAo28ICkg/ib/Ki3WmR2v5LnKU5Bis=;
	h=From:To:CC:Subject:Date;
	b=lm0aV51/4n+CZyfxkw01lfpJEEQfK2VO7O45ushoAsMCjbKVaH9FptYeaWX1vgWkK
	 G+UkptBXTgvY9b+bYx2N6BNa7Uk9iCI8h5NA27iV34V+OjyKY8GAIBiFh9WLoRGy2Y
	 e7EmjN3wgQUUP8B3gibEk7CpxPQ3LEoF3el5cIlY=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 47JKhqJI006867
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 19 Aug 2024 15:43:52 -0500
Received: from DLEE105.ent.ti.com (157.170.170.35) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 19
 Aug 2024 15:43:52 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 19 Aug 2024 15:43:51 -0500
Received: from judy-hp.dhcp.ti.com (judy-hp.dhcp.ti.com [128.247.81.105])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 47JKhqSd037534;
	Mon, 19 Aug 2024 15:43:52 -0500
From: Judith Mendez <jm@ti.com>
To: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>
CC: Bjorn Andersson <quic_bjorande@quicinc.com>,
        Geert Uytterhoeven
	<geert+renesas@glider.be>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Neil Armstrong
	<neil.armstrong@linaro.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        Nishanth Menon <nm@ti.com>, Vignesh
 Raghavendra <vigneshr@ti.com>,
        Bryan Brattlof <bb@ti.com>
Subject: [RFC PATCH] arm64: defconfig: Set MFD_TPS6594_I2C as built-in
Date: Mon, 19 Aug 2024 15:43:52 -0500
Message-ID: <20240819204352.1423727-1-jm@ti.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

SK-AM62A-LP is a device targeting automotive front-camera applications
among other use-cases. It utilizes the TPS6593x PMIC (interfaced over I2C)
to power the SoC and various other peripherals on the board [1].

MMCSD requires the PMIC to be setup correctly before setting the bus
pins to 1.8V using the TPS6594 driver interfaced over i2c.

Currently, the following could be seen when booting the am62ax platform:

"platform fa00000.mmc: deferred probe pending: platform: supplier regulator-5 not ready"
"vdd_mmc1: disabling"

and a failure to boot the SK-AM62A-LP.

One solution is to use initramfs [2], but using initramfs increases the
boot time for this automotive solution which requires faster boot time
parameters.

Another solution is to change MFD_TPS6594_I2C to built-in, that way the
PMIC is setup and the regulators are ready before MMCSD switches to UHS
mode, this is the preferred solution since it does not increase boot time
like the initramfs solution does.

[1] https://www.ti.com/lit/zip/sprr459
[2] https://lore.kernel.org/linux-devicetree/5f03207b-c29b-4d16-92b0-d14eef77bf17@linaro.org/
Fixes: f9010eb938be ("arm64: defconfig: Enable TPS6593 PMIC for SK-AM62A")

Signed-off-by: Judith Mendez <jm@ti.com>
---
 arch/arm64/configs/defconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 7d32fca649965..61f767246d3a5 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -756,7 +756,7 @@ CONFIG_RZ_MTU3=y
 CONFIG_MFD_TI_AM335X_TSCADC=m
 CONFIG_MFD_TI_LP873X=m
 CONFIG_MFD_TPS65219=y
-CONFIG_MFD_TPS6594_I2C=m
+CONFIG_MFD_TPS6594_I2C=y
 CONFIG_MFD_ROHM_BD718XX=y
 CONFIG_MFD_WCD934X=m
 CONFIG_MFD_KHADAS_MCU=m

base-commit: 8400291e289ee6b2bf9779ff1c83a291501f017b
-- 
2.46.0


