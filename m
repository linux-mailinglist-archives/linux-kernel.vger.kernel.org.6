Return-Path: <linux-kernel+bounces-441278-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CFEF09ECC43
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 13:42:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7AC9F287267
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 12:42:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80B1A22912A;
	Wed, 11 Dec 2024 12:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="sBcuUj2A"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2048.outbound.protection.outlook.com [40.107.223.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0611A22915E;
	Wed, 11 Dec 2024 12:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733920915; cv=fail; b=SdS4IedbxUlP83+M/XlCMqk4UhjrDU3JyRno8TYsHh4vnrRx55ku3HhfI3nFK9vp0I8n2Czc10HOUsijsKEeV9KN6k9VPS/KVuP6pfq4g5N91rv+Z5W07T/F2lyPKasWmRRayYs/qM/74PnveCrA0CqmkqoneKIRlG3UfMypa+Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733920915; c=relaxed/simple;
	bh=Wbm3DkJVWTLHVnKbdjIlAqyRJU19PJutW7Ni8wq0OkM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=daihuu7qkPNYii7TMZHZHkctz1Ul5xi2dfEZ+JWCzROIplzD9FqZIl9QHtsq7KSSSiOg10eSLSnVJhqpstgcjwNhKq+TiKdq5Y3cHfFSoPSYtRn/JfgS0NcUg9pa5dbduRcdxvlopI0fJ50Ak9xftSoRYisoVR75oghzWCPuN7s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=sBcuUj2A; arc=fail smtp.client-ip=40.107.223.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YHEnPt97NOxhk+fL4KndWRNtXp3P7rqReUBdSvLIoGv2Ycz7cb259M/Hrdm8EVTUx2PnlK+BfVgrr7RXJEIKPfSbQGcVIGinYtiWjOj0PNtDc03qf+rFn3t+F96wM6PBKRWK35zfROdOQpW74z4sK/WElCpV1UY6kSJbXdFSzF6LrWOPglEYxXcihsXGxob9aNoAxXQVejpLML6O18e9uf+KZMOpZ+/1i6uhpX99cYJXRZ0FhCMqgmUILXgiJcvs5w5P4d4jaKI6VrVfUEUCtpH1pUCbzmOBnBVPetW5fuR5IlI4QOGsAASy3VebUZUFO0qzwOmA75tGLLn4VWQs5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ARQhpWvbRQI78o00UmJZI7y5NAbx8LKsy2NY4wyIjCc=;
 b=f2Pl7GGy6wPzI8VL1oim/6iyQ995YIZvY4v5c1PlsDm2h4pjKl9v5l/wgBSs7gHg+n4mcd3W4DVIgOW1E9nFfU72e3/Vk2+FOk5c6V7a2mKvqQkw1NIz22qtylL3PksLcX9n/PxVfP9lELEOmYOGq2uouDFb8XdggPTYYfDI/hH8VzMa6uUoskkKB1nISF05yfBzAAXKOvHLblCgXB/oRuC8EhNyQGnUmi0bCPRRAx9f9/JaIgcMPicZFRWYrJ2LL0ZknM83I+sVSJ+aDTLl0N33iIxGiPvESX2DB8PY/vGqv3X1oz+jM994KGPbl3iB0g8Tr9F5/MnY9GSr/ZX9dQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ARQhpWvbRQI78o00UmJZI7y5NAbx8LKsy2NY4wyIjCc=;
 b=sBcuUj2ApDvT1BLG+Q/C/DSeBxUTHp3mRreUsSd+O1h10Qy92pA2LQqb+VaM8u8k5Du8XE0wvn7quzQAtSMwodTlojsJI4Nh7dd7eyfFZsw5flHqrO/6OE7HBHVvcidbGd/kgf//j1NO+THN9HbmTMdVV5QLt32rMnzhv9gy7Zw=
Received: from MN2PR11CA0030.namprd11.prod.outlook.com (2603:10b6:208:23b::35)
 by IA1PR12MB9497.namprd12.prod.outlook.com (2603:10b6:208:593::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.15; Wed, 11 Dec
 2024 12:41:47 +0000
Received: from BL02EPF0001A102.namprd05.prod.outlook.com
 (2603:10b6:208:23b:cafe::63) by MN2PR11CA0030.outlook.office365.com
 (2603:10b6:208:23b::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8251.14 via Frontend Transport; Wed,
 11 Dec 2024 12:41:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A102.mail.protection.outlook.com (10.167.241.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8251.15 via Frontend Transport; Wed, 11 Dec 2024 12:41:47 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 11 Dec
 2024 06:41:45 -0600
From: Michal Simek <michal.simek@amd.com>
To: <linux-kernel@vger.kernel.org>, <monstr@monstr.eu>,
	<michal.simek@xilinx.com>, <git@xilinx.com>
CC: Conor Dooley <conor+dt@kernel.org>, Krzysztof Kozlowski
	<krzk+dt@kernel.org>, Rob Herring <robh@kernel.org>, "open list:OPEN FIRMWARE
 AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, "moderated
 list:ARM/ZYNQ ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH 02/15] ARM: zynq: Remove deprecated device_type property
Date: Wed, 11 Dec 2024 13:41:21 +0100
Message-ID: <77152dc14271a2340f63e6d407f36293ed656d49.1733920873.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1733920873.git.michal.simek@amd.com>
References: <cover.1733920873.git.michal.simek@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4217; i=michal.simek@amd.com; h=from:subject:message-id; bh=Wbm3DkJVWTLHVnKbdjIlAqyRJU19PJutW7Ni8wq0OkM=; b=owGbwMvMwCR4yjP1tKYXjyLjabUkhvTIjso9l/JX3ONQ2aWb/pR1ybUbuh6v8uIO9VdKc20tl WY7eVe9I5aFQZCJQVZMkUXa5sqZvZUzpghfPCwHM4eVCWQIAxenAEykxJFhrlj0s4c6qu/eyt/O YGVbM9nhyIZv4QzzbBfnm0isZnsR5OE649KGV5vCedkmAgA=
X-Developer-Key: i=michal.simek@amd.com; a=openpgp; fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A102:EE_|IA1PR12MB9497:EE_
X-MS-Office365-Filtering-Correlation-Id: eacef779-8b3a-4869-479c-08dd19e12d8d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?5fVPVFhaYfrgU38QFw2jrgproTcVmgJCikryHWlEZ5CfQVPyRBJp5FogNuyW?=
 =?us-ascii?Q?4URhjBzNcVfOirCAvlvImu+T/wghpJMtQwek7znWm056m2VRPbuPION//vvu?=
 =?us-ascii?Q?p77rc5CWQOvneDoEUYiHFTPeWPbobWG5JdhQTMHlYYyNVb2NzzLbi5YwPwmm?=
 =?us-ascii?Q?EejqtTr2jiM4zOGI95bve9SduLlOjJfmn3uX9OveDdtZWqabB8dY9wAbhPGd?=
 =?us-ascii?Q?qNgs038LdwETKesr2TETy2Xhi8+7ayAg80LvWAt4yoK34+OUvSc5mqo7vGb+?=
 =?us-ascii?Q?nX7FWoSDnP/alZl6NrVmZz0QsmAHvyVmSnvc46/RmIyB3nLlDjw0eAJLj5r+?=
 =?us-ascii?Q?koZ4jUtqbSyP6qxE0ZGR5xDtPZv4OLlYKicfCdSOnJbvFxoRNBTwNzZeL9RD?=
 =?us-ascii?Q?Z9dXCR8cc99uXnU8EAJWNFrkuH0UF21xL6QUD4QR1KY0hCySV4FWQISNNZZp?=
 =?us-ascii?Q?Vf+GHWYp5izVbz5yhfN+iFbwOfnwlvaWzzad2gTDjL5Q+fYq7uwho7grPRxJ?=
 =?us-ascii?Q?Twcf/HiPgscVukEn2Wsugq2AKz4wIx7Tfb+LZWq6QDCBM+3WWRLvJPqlYQ1T?=
 =?us-ascii?Q?0kAtdtxKy+JAffNvXqXLJuMFNo9Pcg2NPuj1ZA2VVGJ9QF+PM40AlMMHrHKZ?=
 =?us-ascii?Q?yaydMxQHTl3NqmvKD2/m0Zmx8KdCzzvr+yIMOC5GA2CKWpvJtWrF1XJH6MOu?=
 =?us-ascii?Q?8EWe0nZ/f6ojrpKJ2N5ea0tMjip0HFs/7Q6F4INtpIbuLtxEqS9c/ypFHdov?=
 =?us-ascii?Q?HSHQ7g+OWJ5slH9wfdqfth6CIzvjG2XFRjgK/PsIYU8BQyyMZx5y+zJTNDaZ?=
 =?us-ascii?Q?TRj0qm9Fp7PHclbU0SB7N5uvHlsLMnni2Up1V1XK5ZVh+o3VrATLh7c1RFQu?=
 =?us-ascii?Q?KRa2sUqOTFP8RMonEjJNrR0LbJ7FRtPkx11u/m5/EnGFvs1VoVOP7iiOLoOf?=
 =?us-ascii?Q?7H2xD3LXZ/tMvGY+S78xWtg+K1YLn5Z9NsRvGVEeMJc5Nf4HDZiRARvjZ6Ct?=
 =?us-ascii?Q?nnzEGJTOC8zM/aLkVLanOhlbpVgpaKEWXQkat+iDa+h+AaR6U37D5CY5wYqW?=
 =?us-ascii?Q?3/meho9yYpb83VXTuzm9h/cYip2PiXD9za8TshkxgGtzOK0M2ckcky1U3EVD?=
 =?us-ascii?Q?xvX1sG5JXr2+IijU8Yf0qcEAduK8IIxSrmbzbg8wjzlu2gOD7cCBKFL6Cdxb?=
 =?us-ascii?Q?T9vKyeb7aw6k3Zb0vSram7ojrIxbAS7N/7rXaoGSol6rJCU5Am42qH4qhHCJ?=
 =?us-ascii?Q?+NUwC4e/F8haQiqbPNyucJqKOyK/fbb7t8qlWWZBZRH/nzWEYyvk3fAFSpEn?=
 =?us-ascii?Q?lnCGrG0Ey3zwHv1O5nO75cr1zTjcpy4hMBwgz01bf4dGfJjuOM729PgpP8ZT?=
 =?us-ascii?Q?n7b58RpGpmLpCDGLLAhdunztObJDJTm8OOCws+mq87Ng/r5kIgtGYYQKpeGq?=
 =?us-ascii?Q?l/kFQpxTBSG6UmBWbj6xzTPHmETWDXli?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2024 12:41:47.8266
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eacef779-8b3a-4869-479c-08dd19e12d8d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A102.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB9497

Based on DT specification device_type property is deprecated and should be
used only for cpu and memory nodes. That's why remove other usage. In this
case ethernet phy.

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 arch/arm/boot/dts/xilinx/zynq-cc108.dts       | 1 -
 arch/arm/boot/dts/xilinx/zynq-parallella.dts  | 1 -
 arch/arm/boot/dts/xilinx/zynq-zc702.dts       | 1 -
 arch/arm/boot/dts/xilinx/zynq-zc706.dts       | 1 -
 arch/arm/boot/dts/xilinx/zynq-zc770-xm010.dts | 1 -
 arch/arm/boot/dts/xilinx/zynq-zc770-xm013.dts | 1 -
 arch/arm/boot/dts/xilinx/zynq-zed.dts         | 1 -
 arch/arm/boot/dts/xilinx/zynq-zybo-z7.dts     | 1 -
 arch/arm/boot/dts/xilinx/zynq-zybo.dts        | 1 -
 9 files changed, 9 deletions(-)

diff --git a/arch/arm/boot/dts/xilinx/zynq-cc108.dts b/arch/arm/boot/dts/xilinx/zynq-cc108.dts
index 8b9ab9bba23b..b930a5953b49 100644
--- a/arch/arm/boot/dts/xilinx/zynq-cc108.dts
+++ b/arch/arm/boot/dts/xilinx/zynq-cc108.dts
@@ -48,7 +48,6 @@ &gem0 {
 
 	ethernet_phy: ethernet-phy@1 {
 		reg = <1>;
-		device_type = "ethernet-phy";
 	};
 };
 
diff --git a/arch/arm/boot/dts/xilinx/zynq-parallella.dts b/arch/arm/boot/dts/xilinx/zynq-parallella.dts
index 54592aeb92b9..366af4fcf8d9 100644
--- a/arch/arm/boot/dts/xilinx/zynq-parallella.dts
+++ b/arch/arm/boot/dts/xilinx/zynq-parallella.dts
@@ -46,7 +46,6 @@ ethernet_phy: ethernet-phy@0 {
 		compatible = "ethernet-phy-id0141.0e90",
 		             "ethernet-phy-ieee802.3-c22";
 		reg = <0>;
-		device_type = "ethernet-phy";
 		marvell,reg-init = <0x3 0x10 0xff00 0x1e>,
 		                   <0x3 0x11 0xfff0 0xa>;
 	};
diff --git a/arch/arm/boot/dts/xilinx/zynq-zc702.dts b/arch/arm/boot/dts/xilinx/zynq-zc702.dts
index a933c0341b69..b77d2ae82606 100644
--- a/arch/arm/boot/dts/xilinx/zynq-zc702.dts
+++ b/arch/arm/boot/dts/xilinx/zynq-zc702.dts
@@ -95,7 +95,6 @@ &gem0 {
 
 	ethernet_phy: ethernet-phy@7 {
 		reg = <7>;
-		device_type = "ethernet-phy";
 	};
 };
 
diff --git a/arch/arm/boot/dts/xilinx/zynq-zc706.dts b/arch/arm/boot/dts/xilinx/zynq-zc706.dts
index d21e3ae4ebb2..50636906981e 100644
--- a/arch/arm/boot/dts/xilinx/zynq-zc706.dts
+++ b/arch/arm/boot/dts/xilinx/zynq-zc706.dts
@@ -46,7 +46,6 @@ &gem0 {
 
 	ethernet_phy: ethernet-phy@7 {
 		reg = <7>;
-		device_type = "ethernet-phy";
 	};
 };
 
diff --git a/arch/arm/boot/dts/xilinx/zynq-zc770-xm010.dts b/arch/arm/boot/dts/xilinx/zynq-zc770-xm010.dts
index 0dd352289a45..9bb5b3a5252f 100644
--- a/arch/arm/boot/dts/xilinx/zynq-zc770-xm010.dts
+++ b/arch/arm/boot/dts/xilinx/zynq-zc770-xm010.dts
@@ -45,7 +45,6 @@ &gem0 {
 
 	ethernet_phy: ethernet-phy@7 {
 		reg = <7>;
-		device_type = "ethernet-phy";
 	};
 };
 
diff --git a/arch/arm/boot/dts/xilinx/zynq-zc770-xm013.dts b/arch/arm/boot/dts/xilinx/zynq-zc770-xm013.dts
index 38d96adc870c..3fd0d05588bb 100644
--- a/arch/arm/boot/dts/xilinx/zynq-zc770-xm013.dts
+++ b/arch/arm/boot/dts/xilinx/zynq-zc770-xm013.dts
@@ -40,7 +40,6 @@ &gem1 {
 
 	ethernet_phy: ethernet-phy@7 {
 		reg = <7>;
-		device_type = "ethernet-phy";
 	};
 };
 
diff --git a/arch/arm/boot/dts/xilinx/zynq-zed.dts b/arch/arm/boot/dts/xilinx/zynq-zed.dts
index 6a5a93aa6552..63effb7809c5 100644
--- a/arch/arm/boot/dts/xilinx/zynq-zed.dts
+++ b/arch/arm/boot/dts/xilinx/zynq-zed.dts
@@ -43,7 +43,6 @@ &gem0 {
 
 	ethernet_phy: ethernet-phy@0 {
 		reg = <0>;
-		device_type = "ethernet-phy";
 	};
 };
 
diff --git a/arch/arm/boot/dts/xilinx/zynq-zybo-z7.dts b/arch/arm/boot/dts/xilinx/zynq-zybo-z7.dts
index 7b87e10d3953..da76cfd65832 100644
--- a/arch/arm/boot/dts/xilinx/zynq-zybo-z7.dts
+++ b/arch/arm/boot/dts/xilinx/zynq-zybo-z7.dts
@@ -49,7 +49,6 @@ &gem0 {
 
 	ethernet_phy: ethernet-phy@0 {
 		reg = <0>;
-		device_type = "ethernet-phy";
 	};
 };
 
diff --git a/arch/arm/boot/dts/xilinx/zynq-zybo.dts b/arch/arm/boot/dts/xilinx/zynq-zybo.dts
index 755f6f109d5a..4784ef115dad 100644
--- a/arch/arm/boot/dts/xilinx/zynq-zybo.dts
+++ b/arch/arm/boot/dts/xilinx/zynq-zybo.dts
@@ -44,7 +44,6 @@ &gem0 {
 
 	ethernet_phy: ethernet-phy@0 {
 		reg = <0>;
-		device_type = "ethernet-phy";
 	};
 };
 
-- 
2.43.0


