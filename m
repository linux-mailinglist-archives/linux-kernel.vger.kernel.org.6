Return-Path: <linux-kernel+bounces-168837-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A73078BBE4F
	for <lists+linux-kernel@lfdr.de>; Sat,  4 May 2024 23:54:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4200D1F2189B
	for <lists+linux-kernel@lfdr.de>; Sat,  4 May 2024 21:54:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 745B084E0B;
	Sat,  4 May 2024 21:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b="5F9/OfrF"
Received: from mail2.andi.de1.cc (vmd64148.contaboserver.net [161.97.139.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B2F983CC8;
	Sat,  4 May 2024 21:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=161.97.139.27
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714859640; cv=none; b=GVjXfAkCg3vNkhhriScMgiEaUKJMHLB9l8Bsuvi4NhXkdvKoRpp6mCtmycDH+jeoQkTZZRUVuWk+frIMUAg3LlT+lMtR3bopPyk9b0UtFrUAApASV9d8oMOR65zlTsRZeVq8/lidQE+oE05BEKwTmKjZwrZP/A84a7HL2k7TB+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714859640; c=relaxed/simple;
	bh=lGUai3OBbVcPuarJOkEgvhrXWORjqot9FSfSQI8erk4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kaAsaNz2XZXHMASLl6CCzzzG6SmYmAx3eeSpV7fUWrMR5gxbiGCWsafZaQb2pWFu28UrzCirRaD030+vDcpYSWYN383bhzdxh1ekzz4aDN/hLIRsF5t528ETB4i4y7e3ru/sbM2MwpQ4JNJSVL4keJ4iuCLc6QoCxAdros4Z5P0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kemnade.info; spf=pass smtp.mailfrom=kemnade.info; dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b=5F9/OfrF; arc=none smtp.client-ip=161.97.139.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kemnade.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kemnade.info
Received: from mail.andi.de1.cc ([2a02:c205:3004:2154::1])
	by mail2.andi.de1.cc with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <andreas@kemnade.info>)
	id 1s3NKH-005iKr-2v;
	Sat, 04 May 2024 23:53:51 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=kemnade.info; s=20220719; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=oh7AjFUuZxOMD8dhy3mDCuG2iys3ZUxJV2zi2DGl1Nk=; b=5F9/OfrFNGXq70yjhkwl26AYe+
	OVlQvzJ89ZRqZMzzHp7UrKnFht1fRiJX+rYgoRcL8dZzkcr75DF7VTgcjTSaAuwT0a9e2DhiLEAlJ
	S6dr4ym/EVZF/svP9LHaf39eG1v9ujxNYeJ56fKvbdsMiyPBpCPr6yNTjdtRCKECTc+X2FeM9YdzP
	voGDEcfgBUyjQZgPSXLSAGrr7lEhHuoCwqR4EZbBJyxGb7WXr8LiwEhQesxabL0/dbwz9NGaZbJdI
	+JJvEA+IXc2VrpwCwlRnpei6CGZIXx0JdoZiJ23tH9aRDPEdJU8OfywWiDXj7l7Y3EVRO5gXpZS+0
	KZHe4BDA==;
Received: from p200300c20737c2001a3da2fffebfd33a.dip0.t-ipconnect.de ([2003:c2:737:c200:1a3d:a2ff:febf:d33a] helo=aktux)
	by mail.andi.de1.cc with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <andreas@kemnade.info>)
	id 1s3NKF-000aXg-12;
	Sat, 04 May 2024 23:53:48 +0200
Received: from andi by aktux with local (Exim 4.96)
	(envelope-from <andreas@kemnade.info>)
	id 1s3NKG-003c4g-0w;
	Sat, 04 May 2024 23:53:48 +0200
From: Andreas Kemnade <andreas@kemnade.info>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com,
	marex@denx.de,
	leoyang.li@nxp.com,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org
Cc: Andreas Kemnade <andreas@kemnade.info>
Subject: [PATCH 2/2] ARM: dts: imx: Add Kobo Clara HD rev b
Date: Sat,  4 May 2024 23:53:44 +0200
Message-Id: <20240504215344.861327-3-andreas@kemnade.info>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240504215344.861327-1-andreas@kemnade.info>
References: <20240504215344.861327-1-andreas@kemnade.info>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There is a variation of the Kobo Clara HD containing a PMIC with different
default settings for the regulators in the OTP and therefore also
regulators wired up in a different way, so add a proper devicetree for it
to avoid some magic smoke.

Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
---
 arch/arm/boot/dts/nxp/imx/Makefile            |  1 +
 .../dts/nxp/imx/imx6sll-kobo-clarahd-b.dts    | 79 +++++++++++++++++++
 2 files changed, 80 insertions(+)
 create mode 100644 arch/arm/boot/dts/nxp/imx/imx6sll-kobo-clarahd-b.dts

diff --git a/arch/arm/boot/dts/nxp/imx/Makefile b/arch/arm/boot/dts/nxp/imx/Makefile
index 4052cad859fa9..a4826d128dfc7 100644
--- a/arch/arm/boot/dts/nxp/imx/Makefile
+++ b/arch/arm/boot/dts/nxp/imx/Makefile
@@ -288,6 +288,7 @@ dtb-$(CONFIG_SOC_IMX6SL) += \
 dtb-$(CONFIG_SOC_IMX6SLL) += \
 	imx6sll-evk.dtb \
 	imx6sll-kobo-clarahd.dtb \
+	imx6sll-kobo-clarahd-b.dtb \
 	imx6sll-kobo-librah2o.dtb
 dtb-$(CONFIG_SOC_IMX6SX) += \
 	imx6sx-nitrogen6sx.dtb \
diff --git a/arch/arm/boot/dts/nxp/imx/imx6sll-kobo-clarahd-b.dts b/arch/arm/boot/dts/nxp/imx/imx6sll-kobo-clarahd-b.dts
new file mode 100644
index 0000000000000..09b890fe915ab
--- /dev/null
+++ b/arch/arm/boot/dts/nxp/imx/imx6sll-kobo-clarahd-b.dts
@@ -0,0 +1,79 @@
+// SPDX-License-Identifier: (GPL-2.0)
+/*
+ * Device tree for the Kobo Clara HD Rev B ebook reader
+ *
+ * Name on mainboard is: 37NB-E60K00+4B0
+ * Serials start with: E60K02 (a number also seen in
+ * vendor kernel sources)
+ *
+ * Copyright 2024 Andreas Kemnade
+ */
+
+/dts-v1/;
+
+#include "imx6sll-kobo-clarahd.dts"
+
+/ {
+	model = "Kobo Clara HD Rev B";
+	compatible = "kobo,clarahd-b", "kobo,clarahd", "fsl,imx6sll";
+};
+
+&cpu0 {
+	arm-supply = <&dcdc5_reg>;
+	soc-supply = <&dcdc2_reg>;
+};
+
+&dcdc1_reg {
+	/delete-property/ regulator-min-microvolt;
+	/delete-property/ regulator-max-microvolt;
+
+	regulator-state-mem {
+		regulator-suspend-min-microvolt = <1040000>;
+		regulator-suspend-max-microvolt = <1040000>;
+	};
+};
+
+&dcdc2_reg {
+	regulator-min-microvolt = <660000>;
+	regulator-max-microvolt = <1000000>;
+
+	regulator-state-mem {
+		regulator-suspend-min-microvolt = <660000>;
+		regulator-suspend-max-microvolt = <660000>;
+	};
+};
+
+&dcdc3_reg {
+	/delete-property/ regulator-min-microvolt;
+	/delete-property/ regulator-max-microvolt;
+
+	regulator-state-mem {
+		regulator-suspend-min-microvolt = <3300000>;
+		regulator-suspend-max-microvolt = <3300000>;
+	};
+};
+
+&dcdc4_reg {
+	/delete-property/ regulator-min-microvolt;
+	/delete-property/ regulator-max-microvolt;
+
+	regulator-state-mem {
+		regulator-suspend-min-microvolt = <1700000>;
+		regulator-suspend-max-microvolt = <1700000>;
+	};
+};
+
+&dcdc5_reg {
+	regulator-min-microvolt = <710000>;
+	regulator-max-microvolt = <1100000>;
+
+	regulator-state-mem {
+		regulator-suspend-min-microvolt = <710000>;
+		regulator-suspend-max-microvolt = <710000>;
+	};
+};
+
+&ldo8_reg {
+		/delete-property/ regulator-min-microvolt;
+		/delete-property/ regulator-max-microvolt;
+};
-- 
2.39.2


