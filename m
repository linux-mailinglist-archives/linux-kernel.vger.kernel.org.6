Return-Path: <linux-kernel+bounces-369041-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17A919A1826
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 03:54:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA25A28884E
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 01:54:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00F2CA2D;
	Thu, 17 Oct 2024 01:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="KINz60jt"
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [202.36.163.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8FEC382
	for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 01:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.36.163.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729130056; cv=none; b=d5Ael1sMG2hkegE8jv3Ku4ZVuuAt0l1vktmqfRP1dEYbBNksbZoxpNb2RXIdaL6K2qseDWYUkscg4mkW+eTiUT4GRXO5WXA1SDTBjYl06s//hYOoKvrpRsgbeatNEDhvl7rLxPZmxPsQnDSUfu+oKbm96jvTjzW3WTkjn7n6j/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729130056; c=relaxed/simple;
	bh=DRMcYas5jTkuHE6fDhiJFW3CS1t85QDN3n3Ll859YmE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fbhXTa+kEtVDJKGQnD5WupFuQOo1pXLZmaC1kxtbdpEgchfZw+syn74wQ0pEv987XRM/y00+LXdM3DbjAzmHt9So3H9vBazF7GEx48v8RVKO7geJ7atzZc/YEgvKLI7b8oBlkoaqkO27h+1D8NP/rhFo9aDiWXFnRF8MWsrh7UI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz; spf=pass smtp.mailfrom=alliedtelesis.co.nz; dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b=KINz60jt; arc=none smtp.client-ip=202.36.163.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alliedtelesis.co.nz
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 966AC2C0372;
	Thu, 17 Oct 2024 14:54:09 +1300 (NZDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
	s=mail181024; t=1729130049;
	bh=J87wGS51xjrITb3DT9w7rSdBrnVW7k2HNOqiCdPmMNQ=;
	h=From:To:Cc:Subject:Date:From;
	b=KINz60jt0RzNpOvqWEsX5Esvzl3W4y00Jc3CrbmXDvnGoh1aWGQFUI+IzFZkPmmhG
	 cwwyB4a1+DklXZwqmmsN+YA1OEEB4gNN3w1jxVzMY/fzK0bXOXqxfccfQ6hG6IbOv9
	 uzohqvhkvETswweqsSM2rtR+QNvjUuN/kXnEP/280FkYXCcp/eZL+TzhXWUUPrSS1h
	 Y+ZqZ+pAxUkVvHevQ72zzs9ElGcVane7Rjo4dQuInT3hNUsIBslt8NtQJ3+WWkor7R
	 wUQ1Ztm9mDnBzdqQxAfU767LNrqCz1Jndgc/+sdZ7B6qGyqDipiKfNmnv/ZbgQWeOy
	 KT6HR4rmA5RRg==
Received: from pat.atlnz.lc (Not Verified[10.32.16.33]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
	id <B67106e410000>; Thu, 17 Oct 2024 14:54:09 +1300
Received: from pauld2-dl.ws.atlnz.lc (pauld-dl.ws.atlnz.lc [10.33.23.30])
	by pat.atlnz.lc (Postfix) with ESMTP id 6DA7613EE32;
	Thu, 17 Oct 2024 14:54:09 +1300 (NZDT)
Received: by pauld2-dl.ws.atlnz.lc (Postfix, from userid 1684)
	id 6584A40A11; Thu, 17 Oct 2024 14:54:09 +1300 (NZDT)
From: Paul Davey <paul.davey@alliedtelesis.co.nz>
To: Andrew Lunn <andrew@lunn.ch>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Paul Davey <paul.davey@alliedtelesis.co.nz>
Subject: [PATCH net-next] net: phy: aquantia: Add mdix config and reporting
Date: Thu, 17 Oct 2024 14:54:07 +1300
Message-ID: <20241017015407.256737-1-paul.davey@alliedtelesis.co.nz>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-SEG-SpamProfiler-Analysis: v=2.4 cv=ca1xrWDM c=1 sm=1 tr=0 ts=67106e41 a=KLBiSEs5mFS1a/PbTCJxuA==:117 a=DAUX931o1VcA:10 a=uGgpi8APxHEu2YRnv34A:9 a=3ZKOabzyN94A:10
X-SEG-SpamProfiler-Score: 0
x-atlnz-ls: pat

Add support for configuring MDI-X state of PHY.
Add reporting of resolved MDI-X state in status information.

Tested on AQR113C.

Signed-off-by: Paul Davey <paul.davey@alliedtelesis.co.nz>
---
 drivers/net/phy/aquantia/aquantia_main.c | 45 ++++++++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/drivers/net/phy/aquantia/aquantia_main.c b/drivers/net/phy/a=
quantia/aquantia_main.c
index 38d0dd5c80a4..8fe63a13b9f0 100644
--- a/drivers/net/phy/aquantia/aquantia_main.c
+++ b/drivers/net/phy/aquantia/aquantia_main.c
@@ -54,6 +54,12 @@
 #define MDIO_AN_VEND_PROV_DOWNSHIFT_MASK	GENMASK(3, 0)
 #define MDIO_AN_VEND_PROV_DOWNSHIFT_DFLT	4
=20
+#define MDIO_AN_RESVD_VEND_PROV			0xc410
+#define MDIO_AN_RESVD_VEND_PROV_MDIX_AUTO	0
+#define MDIO_AN_RESVD_VEND_PROV_MDIX_MDI	1
+#define MDIO_AN_RESVD_VEND_PROV_MDIX_MDIX	2
+#define MDIO_AN_RESVD_VEND_PROV_MDIX_MASK	GENMASK(1, 0)
+
 #define MDIO_AN_TX_VEND_STATUS1			0xc800
 #define MDIO_AN_TX_VEND_STATUS1_RATE_MASK	GENMASK(3, 1)
 #define MDIO_AN_TX_VEND_STATUS1_10BASET		0
@@ -64,6 +70,9 @@
 #define MDIO_AN_TX_VEND_STATUS1_5000BASET	5
 #define MDIO_AN_TX_VEND_STATUS1_FULL_DUPLEX	BIT(0)
=20
+#define MDIO_AN_RESVD_VEND_STATUS1		0xc810
+#define MDIO_AN_RESVD_VEND_STATUS1_MDIX		BIT(8)
+
 #define MDIO_AN_TX_VEND_INT_STATUS1		0xcc00
 #define MDIO_AN_TX_VEND_INT_STATUS1_DOWNSHIFT	BIT(1)
=20
@@ -155,12 +164,40 @@ static void aqr107_get_stats(struct phy_device *phy=
dev,
 	}
 }
=20
+static int aqr_set_polarity(struct phy_device *phydev, int polarity)
+{
+	u16 val =3D 0;
+
+	switch (polarity) {
+	case ETH_TP_MDI:
+		val =3D MDIO_AN_RESVD_VEND_PROV_MDIX_MDI;
+		break;
+	case ETH_TP_MDI_X:
+		val =3D MDIO_AN_RESVD_VEND_PROV_MDIX_MDIX;
+		break;
+	case ETH_TP_MDI_AUTO:
+	case ETH_TP_MDI_INVALID:
+	default:
+		val =3D MDIO_AN_RESVD_VEND_PROV_MDIX_AUTO;
+		break;
+	}
+
+	return phy_modify_mmd_changed(phydev, MDIO_MMD_AN, MDIO_AN_RESVD_VEND_P=
ROV,
+				      MDIO_AN_RESVD_VEND_PROV_MDIX_MASK, val);
+}
+
 static int aqr_config_aneg(struct phy_device *phydev)
 {
 	bool changed =3D false;
 	u16 reg;
 	int ret;
=20
+	ret =3D aqr_set_polarity(phydev, phydev->mdix_ctrl);
+	if (ret < 0)
+		return ret;
+	if (ret > 0)
+		changed =3D true;
+
 	if (phydev->autoneg =3D=3D AUTONEG_DISABLE)
 		return genphy_c45_pma_setup_forced(phydev);
=20
@@ -278,6 +315,14 @@ static int aqr_read_status(struct phy_device *phydev=
)
 				 val & MDIO_AN_RX_LP_STAT1_1000BASET_HALF);
 	}
=20
+	val =3D phy_read_mmd(phydev, MDIO_MMD_AN, MDIO_AN_RESVD_VEND_STATUS1);
+	if (val < 0)
+		return val;
+	if (val & MDIO_AN_RESVD_VEND_STATUS1_MDIX)
+		phydev->mdix =3D ETH_TP_MDI_X;
+	else
+		phydev->mdix =3D ETH_TP_MDI;
+
 	return genphy_c45_read_status(phydev);
 }
=20
--=20
2.47.0


