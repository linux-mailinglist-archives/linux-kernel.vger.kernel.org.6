Return-Path: <linux-kernel+bounces-444988-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BF819F0F95
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 15:51:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 034541882F0C
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 14:51:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 816AD1E25EB;
	Fri, 13 Dec 2024 14:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="M92wGyNr"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86C561E00BF;
	Fri, 13 Dec 2024 14:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734101461; cv=none; b=CZ8Vsc/ZLpb+9XsLEf+tsdYllCNKpJm595HkZWjeHwHrzML30JH3bkE7qFVr2vDS0UwPGo+jgmjRbnefevy/nZPC9es7ZsZqchYBL/upfZNDylzYX1jpJ56E9PY1KaB7Ex/Wn5LwuYbHhT4048PxGSFtoCmVS6jtdGACFuOsbo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734101461; c=relaxed/simple;
	bh=6U9Q+r11fAb3XJLHbiGeO9pC+y0FLfqLw3ieM2gzyJY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qeTIf3Q/fuEr0EwBDHGlBuOxkMBNlGy5jL3arckhTsGgmgYbUo0RpwEe2hS4aYKOsDRZy7O+9X+ascd/ttUUyLksrikszMF+/IYwxMU23Ax0EeXsRa9T2mFSuHSZDg+ScwJiWvsvfjz0mn9c8VaG2KOV4P/NJ/0NPJfhM8AN+fQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=M92wGyNr; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BDEJBbP022666;
	Fri, 13 Dec 2024 14:50:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=MD6/YjMzy1EUjNUsx
	CPEgaQcTdupsWZAD//ZJovyAeg=; b=M92wGyNrkc62B2PX7uXrXuV9byXsPAZvP
	YcRbhTRFtVHfFfiK/obpu4y1Z+dg+ovHAK37n4FeN8c92+LnC6Yn2ruhf5u5Peny
	RElPSfiXAp8ijL+Xs+69oYO1KLi20n7ZAjo1e8XqIQLp6YCpAviUOvGnJmSEfyJj
	P3kGh+WdyNf1bfohYhXyOdWlghGAQYbTfOdXMxopkHPCRwFCsfD11sHvNc+kG8AA
	WYBslTiuorHc40kmG/0xxH1SH1RJHoV39H61fWsPzHNQDqI7Db4J80+tdNpU66FW
	/3Yis5n+eEZDZ1QOOQO56Xo3d3+TdTBH+t9iDVjf48laB0d/neCXA==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43g9yhkm5j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 13 Dec 2024 14:50:45 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4BDBWD5a007795;
	Fri, 13 Dec 2024 14:50:44 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 43ft11ysfg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 13 Dec 2024 14:50:44 +0000
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com [10.39.53.231])
	by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4BDEogUZ15073934
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 13 Dec 2024 14:50:42 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CE81F5805F;
	Fri, 13 Dec 2024 14:50:42 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1ACEE58056;
	Fri, 13 Dec 2024 14:50:42 +0000 (GMT)
Received: from gfwa153.aus.stglabs.ibm.com (unknown [9.3.84.127])
	by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 13 Dec 2024 14:50:42 +0000 (GMT)
From: Ninad Palsule <ninad@linux.ibm.com>
To: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, joel@jms.id.au,
        andrew@codeconstruct.com.au, devicetree@vger.kernel.org,
        eajames@linux.ibm.com, ninad@linux.ibm.com,
        linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Cc: NINAD PALSULE <ninadpalsule@us.ibm.com>
Subject: [PATCH v1 3/8] ARM: dts: aspeed: system1: Add RGMII support
Date: Fri, 13 Dec 2024 08:50:29 -0600
Message-ID: <20241213145037.3784931-4-ninad@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241213145037.3784931-1-ninad@linux.ibm.com>
References: <20241213145037.3784931-1-ninad@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: dtvFjMW3mnhDsOrs6Yo5bSWSokQVuOmn
X-Proofpoint-ORIG-GUID: dtvFjMW3mnhDsOrs6Yo5bSWSokQVuOmn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 clxscore=1015
 priorityscore=1501 spamscore=0 lowpriorityscore=0 suspectscore=0
 malwarescore=0 impostorscore=0 mlxscore=0 bulkscore=0 mlxlogscore=781
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412130103

From: NINAD PALSULE <ninadpalsule@us.ibm.com>

system1 has 2 transceiver connected through the RGMII interfaces. Added
device tree entry to enable RGMII support.

Signed-off-by: Ninad Palsule <ninad@linux.ibm.com>
---
 .../dts/aspeed/aspeed-bmc-ibm-system1.dts     | 38 ++++++++++++++++---
 1 file changed, 33 insertions(+), 5 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-system1.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-system1.dts
index db4b9fb674fe..775a95470f5c 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-system1.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-system1.dts
@@ -425,14 +425,42 @@ &lpc_ctrl {
 	memory-region = <&flash_memory>;
 };
 
+&mdio0 {
+	status = "okay";
+
+	ethphy0: ethernet-phy@0 {
+		compatible = "ethernet-phy-ieee802.3-c22";
+		reg = <0>;
+	};
+};
+
+&mdio2 {
+	status = "okay";
+
+	ethphy2: ethernet-phy@0 {
+		compatible = "ethernet-phy-ieee802.3-c22";
+		reg = <0>;
+	};
+};
+
+&mac0 {
+	status = "okay";
+
+	phy-mode = "rgmii-rxid";
+	phy-handle = <&ethphy0>;
+
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_rgmii1_default>;
+};
+
 &mac2 {
 	status = "okay";
+
+	phy-mode = "rgmii";
+	phy-handle = <&ethphy2>;
+
 	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_rmii3_default>;
-	clocks = <&syscon ASPEED_CLK_GATE_MAC3CLK>,
-		 <&syscon ASPEED_CLK_MAC3RCLK>;
-	clock-names = "MACCLK", "RCLK";
-	use-ncsi;
+	pinctrl-0 = <&pinctrl_rgmii3_default>;
 };
 
 &mac3 {
-- 
2.43.0


