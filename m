Return-Path: <linux-kernel+bounces-187242-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2E0E8CCEF8
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 11:21:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EF96BB2172B
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 09:21:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B982614A094;
	Thu, 23 May 2024 09:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b="axxhwC4G"
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2082.outbound.protection.outlook.com [40.107.255.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AC3D149E19;
	Thu, 23 May 2024 09:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.255.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716455935; cv=fail; b=rNocoBn6K3LL+KgH4K/EGrR2kJ+k4z1E/AqNm+aCvNmoHaEq8s5yavYZEQE/jfTcI6t97RVZPN9YS0+DBU1b3cxyjaSguLZ0Wzn7rEQmfUgVT9EX7ESQ2CUAmNpY/IpkOO7xJbQsWh+YfgdjeXNwT5iaTX+DdFUQHAJXhzHNSaA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716455935; c=relaxed/simple;
	bh=9QLFR+VmV/z9TnXDPdlSddPjyt/lOEkotMb2isambQE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qPY1Xa5Rb562rchu9zA4DbaZUEmhfG48xUmkj14/jFftkQw6pMqJRGU8zg25WFqOwyyIpLSqQfEdzZgCSJkIRET+LabE0xQCHQcnGdLXmFqDH9nkfq/dIdoSNWHgSG8vBah+pP32RT77HDMu/iIKd/YTEGzrJM+aiIzBu+QBBZY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com; spf=pass smtp.mailfrom=wiwynn.com; dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b=axxhwC4G; arc=fail smtp.client-ip=40.107.255.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wiwynn.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=neJ+2hIasBh8s6wNgtjQwkcTUlzHUwNhZeRi7btciniOG+6r9+DHmmSoa6qOqi1wyaSKoTrkRM2P5x04BrxhFuF+eSgLCAGMcR06nPaUdakLGNKUpYhSqB+iVHk96NYNto+/r1rT9MdAsO8RqIffv/MUuC40r9cqABSVt6Nl7DYpnncsnFnkl+asHb5iYYZNgG5WB6yDTPHTNrrVpqU51LbsqP5Wg9K5qAyquXUVI8+R7HrqhSqm5y+HXA6rjXm+fMXd5wYmtyUfH98RUBgpYkv8SpBgVl8PCOVqvClhzgpvJIj4Cs1fp1Ab0oYsgHkMIUYTYyjGW8b+3Mn8C5sVmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S11d+Rgg5XKlgMlTPsawAewq2X5TMPnusGFqrYm+mrA=;
 b=GNXwFbPSMcHForP9N2NKfbC9q3iMklUQFKTd2kY2ogZhqQ7Z7sabvt5YW/Y5kpboNNCE51C5jK1gD/HuOHA2ZS+NqYcxg0aalY7Ocn6qG1iyc1Ppw8sWin3GJPjCsu7+7j8J6BwL8RBUtHilfwWoeC1IJdA14sEI/3Uogsv5OP8TMmLZsikMyWuETVL3zw+qAa/oVTH4fj+IlqElEn9odG35djm9bt3i17kW49EDqpDLBf2V3UmQN61c7ss6+jZYXufrdQ66nCbQ5krpySoPWZcEo0U2ct0KaqpvMuKRerlKczwXPOdMktHNXlzZ4rHF0QFkPPFeh+MNssSQHDxuag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 211.20.1.79) smtp.rcpttodomain=stwcx.xyz smtp.mailfrom=wiwynn.com; dmarc=fail
 (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=wiwynn.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wiwynn.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S11d+Rgg5XKlgMlTPsawAewq2X5TMPnusGFqrYm+mrA=;
 b=axxhwC4GXvwRCE3KoBEJj8mMwLeATvRWXQgo56Zv4butlh3/pPO1hyAoC7FBtaleYTBdPI3GUAZGRrQU0AAvMghursuMKxsi0xdLdQikolvvmd45w9TjwguviR5B1cQjEIjfv8XxgtAvv/t/ROoiuaXDMdraFe8sRR+hnlvp0mypZMB/SRQce1kv4z84MMkkvZBcCfdgxJ/Kj6Dq8XgmDgq68v/oFO08JTiwvFvEKvpaIClh1oFSB2EKLhJYQBqHe/SH2OmHK5eEqdLwsG3nSDd8NeT4CCoLA1XVboHSpGzvEGSQciUY5JF+lIo1ZXvKlBmPYS6foabUkJVfvN4KjQ==
Received: from PS2PR03CA0019.apcprd03.prod.outlook.com (2603:1096:300:5b::31)
 by KL1PR04MB8143.apcprd04.prod.outlook.com (2603:1096:820:142::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.19; Thu, 23 May
 2024 09:18:50 +0000
Received: from HK3PEPF0000021E.apcprd03.prod.outlook.com
 (2603:1096:300:5b:cafe::a6) by PS2PR03CA0019.outlook.office365.com
 (2603:1096:300:5b::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.19 via Frontend
 Transport; Thu, 23 May 2024 09:18:47 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 211.20.1.79)
 smtp.mailfrom=wiwynn.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=wiwynn.com;
Received-SPF: Fail (protection.outlook.com: domain of wiwynn.com does not
 designate 211.20.1.79 as permitted sender) receiver=protection.outlook.com;
 client-ip=211.20.1.79; helo=localhost.localdomain;
Received: from localhost.localdomain (211.20.1.79) by
 HK3PEPF0000021E.mail.protection.outlook.com (10.167.8.40) with Microsoft SMTP
 Server id 15.20.7611.14 via Frontend Transport; Thu, 23 May 2024 09:18:47
 +0000
From: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
To: patrick@stwcx.xyz,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>
Cc: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v8 10/23] ARM: dts: aspeed: yosemite4: Add power sensor for power module reading
Date: Thu, 23 May 2024 17:17:57 +0800
Message-Id: <20240523091812.2032933-11-Delphine_CC_Chiu@wiwynn.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240523091812.2032933-1-Delphine_CC_Chiu@wiwynn.com>
References: <20240523091812.2032933-1-Delphine_CC_Chiu@wiwynn.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HK3PEPF0000021E:EE_|KL1PR04MB8143:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 0e2f95b3-bb63-4a5b-0631-08dc7b0959f5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|36860700004|7416005|376005|82310400017|1800799015;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?z34dsyFtcSOmYVgntdMArFMYSsJ+mgbXfj/SFxHmIgPcnhVITcUfDwg4i0qT?=
 =?us-ascii?Q?ai8hFn8hn2H1DI62TE9AjPndaEOaRJWdP8snZTGgLeZ6mtUqJwTGDcNul0Nl?=
 =?us-ascii?Q?rh3NHFxBXZaYWwxp6Aa2D7mhDTa2ycBAm4o5taGakRRoffqUYRWu3j15+3sR?=
 =?us-ascii?Q?QqqtlDQtkxgHypTAJO/Z0MD1DwM0kSzV+JMPZ/g8N2lhYDMWKLuJYNVRNVBX?=
 =?us-ascii?Q?axKoEb4yS8OMPgTO0kmkBTbBW3VKkoahPjUrWXnIDURFDrsb0PVbamV6Rn+N?=
 =?us-ascii?Q?DTXN81EiFel5zOiu38FudCHPTRnh3lbudKQpoNAnFrqaEnQye3pVTp9u1XPa?=
 =?us-ascii?Q?eYiqHNFzeuIZvADyCHwTV9yzTDSiDu7i9JYbATD6iXwThLy12gI0QRuvXcr4?=
 =?us-ascii?Q?qyDaAUTSZmvxnyaVaaShwr2ILgF1P2080CXjsG0DhJxjmrK8ALkj7y+oGpxI?=
 =?us-ascii?Q?Dhd0M+jvWbwojTLbrzjF2/GfYOVJL2Bp6MKv+qKZ7fokPGLyuFbPXY3/MIL+?=
 =?us-ascii?Q?652kzf/JvBIjcEauMsV+E0ZyFpkfk88ewbhIAQKOd6KFUYPMtwpeZ/JPAmeb?=
 =?us-ascii?Q?AVUj34+hpt5/x0fegJuALtFjazD7klKliNkxwZcJznXcX41gdpjqwu8ffX6y?=
 =?us-ascii?Q?ii4sZ82mlarbl+HNHtacsM2qb1vNgHnDbeNJsNnOO8UZ5NgLI+BF/J8l++pi?=
 =?us-ascii?Q?L4JAZ/rcd9YrK42q2ANY4JNsIEenp7I4eK1s5YHK83HU+X7mB990U1wqlk3n?=
 =?us-ascii?Q?kF3UbhkVgAFbgN6oFjYBAky10Jt7rg+hnsXED+xGia11si+E1ZnNqkbIblAy?=
 =?us-ascii?Q?W1gxzv03SHRaOIDQyREcIHvyLioDdc09f2iJk+uAUzFylJTABSCmmq24zf4W?=
 =?us-ascii?Q?edo5OmUcs9q6A6w6TmHwtnVUsFpnLUaylgaWw8tKpf1s/KVq2TwpDIojQDdJ?=
 =?us-ascii?Q?z9U9PVlIK6CFC5HV9EGXX+U/ZmjNnf3PDHGRnq/wj2LEUY3cca4GpIwMCtC0?=
 =?us-ascii?Q?n+pMKYmERkn0Uo9BNuKS7W33QmN7eurZ6i1tmmy2fHxincpPSVTxbDAN3q8X?=
 =?us-ascii?Q?lIEmlrOEU///Fih3z/+CzZlmbeWvAAVmeMZ5TO/9A3ngFqOQGcZBPEPNl3U8?=
 =?us-ascii?Q?b+p050w4qnfIYYbrrRYGnvXr+KP8LFp/padDmGI8H/LVpKT0nVuqSczenVaM?=
 =?us-ascii?Q?qZgmJy9elpZyQVqzRQ4PClKcU2GCiqrvt+vnK1EJhj2YepazzwWvGR3Wallw?=
 =?us-ascii?Q?QMM99DzbnsF/rnns+SX4ZahK9+W8movEN3MkycwHp9WLw46hCyME77Y7sD06?=
 =?us-ascii?Q?LNKRHIQtMHb8stbaz1WQ4IxrxdWjYYWczA9C+BrYIqPTAaN9OeTkNT39qd0z?=
 =?us-ascii?Q?6CN1GY7EGmHAZY0CN+laBUMsGyZZ?=
X-Forefront-Antispam-Report:
	CIP:211.20.1.79;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:localhost.localdomain;PTR:211-20-1-79.hinet-ip.hinet.net;CAT:NONE;SFS:(13230031)(36860700004)(7416005)(376005)(82310400017)(1800799015);DIR:OUT;SFP:1101;
X-OriginatorOrg: wiwynn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2024 09:18:47.1732
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e2f95b3-bb63-4a5b-0631-08dc7b0959f5
X-MS-Exchange-CrossTenant-Id: da6e0628-fc83-4caf-9dd2-73061cbab167
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=da6e0628-fc83-4caf-9dd2-73061cbab167;Ip=[211.20.1.79];Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource:
	HK3PEPF0000021E.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR04MB8143

Add power sensor for power module reading

Signed-off-by: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
---
 .../aspeed/aspeed-bmc-facebook-yosemite4.dts  | 25 +++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
index 92733a8ecf0b..2ac872878acd 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
@@ -906,6 +906,11 @@ gpio@23 {
 		"HSC7-ALERT2-R-N","HSC8-ALERT2-R-N";
 	};
 
+	power-sensor@40 {
+		compatible = "mps,mp5023";
+		reg = <0x40>;
+	};
+
 	temperature-sensor@48 {
 		compatible = "ti,tmp75";
 		reg = <0x48>;
@@ -930,6 +935,26 @@ eeprom@54 {
 		compatible = "atmel,24c256";
 		reg = <0x54>;
 	};
+
+	power-sensor@62 {
+		compatible = "pmbus";
+		reg = <0x62>;
+	};
+
+	power-sensor@64 {
+		compatible = "pmbus";
+		reg = <0x64>;
+	};
+
+	power-sensor@65 {
+		compatible = "pmbus";
+		reg = <0x65>;
+	};
+
+	power-sensor@68 {
+		compatible = "pmbus";
+		reg = <0x68>;
+	};
 };
 
 &i2c12 {
-- 
2.25.1


