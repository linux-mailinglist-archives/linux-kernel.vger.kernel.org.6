Return-Path: <linux-kernel+bounces-212096-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B745E905B30
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 20:39:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A890F1C231F1
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 18:39:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D13C5FB8A;
	Wed, 12 Jun 2024 18:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="yKPZhDZr"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F11C347F4B;
	Wed, 12 Jun 2024 18:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718217519; cv=none; b=FWQNGSbesKaIhEbctFoat6izFH++rL0LDzoGSqFf11uppaMBcvQa8ocplenzottiGYJQX+ZhpPGV/wkhlWcvFPgrCcYBIXjRiU6T8AoxQ5F+V0QQ70vH/kLZxizQ5G9I3FtZatcHciDsUxf7t4SM+lqtAO4xZdO9jnC30CT+xQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718217519; c=relaxed/simple;
	bh=zxuJWH7+enaX20ZWWYO4My3IxIyK3wC5Qmez/L1MCtM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=rHVP1V26pBKDXddcloJzWoEhlFQ3bsNMwQDf7470zRnX46U6gu/i6J/h4m78s/5pFsjdDasEO+z/r2cff9hN5QGxMN0NP6iK6eOJ+dq4GuMZe+W/DWAcH0AP4IYqoSKFAehihLTtkV+mo7CCUO1P972Sztyw5PV5KRNGBgptGcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=yKPZhDZr; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 45CIcSgG023851;
	Wed, 12 Jun 2024 13:38:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1718217508;
	bh=1q/iabsvT1n5IGBz3FslQzyBnmmvqQ04qdAtxuKj2w4=;
	h=From:To:CC:Subject:Date;
	b=yKPZhDZr9dnom2pB6E8Q/gn2OB28x71rPgFYRbouT/PuCfDTDtyvyM8tqvSKhQ7TP
	 GIftOzxLDqm4oPwO66n+Urz5sSibNKP4a50Os3x3gjnjwztwCrJcojpWLs82MqR++E
	 HiiaXSmJGefxEkDBrh8pls0MuK4q/fnEG1ncaMA0=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 45CIcRYm001569
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 12 Jun 2024 13:38:27 -0500
Received: from DLEE103.ent.ti.com (157.170.170.33) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 12
 Jun 2024 13:38:27 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 12 Jun 2024 13:38:27 -0500
Received: from lelvsmtp5.itg.ti.com ([10.249.42.149])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 45CIcQ77013889;
	Wed, 12 Jun 2024 13:38:27 -0500
From: Andrew Davis <afd@ti.com>
To: Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Tero
 Kristo <kristo@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof
 Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley
	<conor+dt@kernel.org>
CC: <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Andrew Davis <afd@ti.com>
Subject: [PATCH] arm64: dts: ti: k3-am642-sk: Add power supply temperature sensors
Date: Wed, 12 Jun 2024 13:38:26 -0500
Message-ID: <20240612183826.121856-1-afd@ti.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

The SK-AM64 board has two TMP100 temperature sensors, add these here.

Signed-off-by: Andrew Davis <afd@ti.com>
---
 arch/arm64/boot/dts/ti/k3-am642-sk.dts | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am642-sk.dts b/arch/arm64/boot/dts/ti/k3-am642-sk.dts
index 5b028b3a3192f..44ecbcf1c8447 100644
--- a/arch/arm64/boot/dts/ti/k3-am642-sk.dts
+++ b/arch/arm64/boot/dts/ti/k3-am642-sk.dts
@@ -430,6 +430,18 @@ exp2: gpio@60 {
 		#gpio-cells = <2>;
 		gpio-line-names = "LED1","LED2","LED3","LED4","LED5","LED6","LED7","LED8";
 	};
+
+	/* SoC power supply temperature */
+	tmp100@48 {
+		compatible = "ti,tmp100";
+		reg = <0x48>;
+	};
+
+	/* DDR power supply temperature */
+	tmp100@49 {
+		compatible = "ti,tmp100";
+		reg = <0x49>;
+	};
 };
 
 /* mcu_gpio0 and mcu_gpio_intr are reserved for mcu firmware usage */
-- 
2.39.2


