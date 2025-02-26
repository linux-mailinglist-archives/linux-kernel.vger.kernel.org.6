Return-Path: <linux-kernel+bounces-532779-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BB9CA45225
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 02:22:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7C9097A3C96
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 01:21:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB6D918DB0E;
	Wed, 26 Feb 2025 01:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cixtech.com header.i=@cixtech.com header.b="HWkeD93j"
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2134.outbound.protection.outlook.com [40.107.117.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98D4FEEBB;
	Wed, 26 Feb 2025 01:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.117.134
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740532905; cv=fail; b=NMXnHWyPh1tU6CP3QGCDabqySBmzKFc6GfI4mmwDCLeIbddlBsocY+4KRcoKPRdCejts0Mb9gjnviB3lThqdpejQRmigXibya4PHd7jthpAV4VBgfP2WKxcATApbsXp+2oY5WKEV14KQXepjJFzKOBiTy20O1NWv79Ci0PdoGsM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740532905; c=relaxed/simple;
	bh=qkkqioGKnFRl0/dx96wfLb+UIxYRfXOoNSkBTNitF0A=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=k8ETP/XEhZbxfBwL81QcfadBTFc94EU0JvOSH/BqgyPg0ouVUmKV3oHFunAERP2oAEErCdksgZbn3wD1hO//jAFCyeg3+u0WroGMv3czwfpUiL77Ybkc2mMZn8U/yJvQAkpIdRCObJjt6BygDrddZsaNPrlo0kRZN4TWf/zV+jQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com; spf=pass smtp.mailfrom=cixtech.com; dkim=pass (2048-bit key) header.d=cixtech.com header.i=@cixtech.com header.b=HWkeD93j; arc=fail smtp.client-ip=40.107.117.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cixtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Pnt883Ian69WqNiYPdzI2FRumfHnqZqBTDlKYm/9Q+yaH33zOQVMxrSRLkODfaXNziMYcySRAGo44LF/Y7uxhmbkI7VBjpVUXSU7jkjvWx7J8dSFZ3HQGQ35j3V/aMrlIjxl+Yri3dCbQbarJCFob+Ig+buGbUd3xSUnWyDVWJ2dZRq+8UKptMrrTA+rKUXnSN4pNGJ/vQm9Wm/QT7SIhV6Dl002fG9ksX1qDosWAsmINSXeacGWgOYdPR4Nl3SArK/QIWrkoYaNlEqHuLvojgymW08QlHqFnE3pBPOVrhmBk/H/R2YU8xxdQ/FFh6aBvG3AOJyhbi9sySijCp1KxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nXIAsALo5yidsCybdoy2QGQtOmiPggHsyyymIqPE8JM=;
 b=pilv/eGEgfVyfhV70q3082jSslJ2x4YCMqNRQDgJqIs9dXQDzKeSCL6loNmiTjCq2hFTGKf3bX8XMf6x2jwTXe5qiaebDlqbO9NMuRavu3d0i59DgTHgKh//Kstx/qzpEfUc6EfRFjcPwHhkgx9RCE0lDIZaUpHpauREhXaqdiIKmyXf7po6W/pSVwTHVFzKeUsSJ2hIaCO6C6tj4hRQflyFL+uYY3RPMSMAJQyEFGTh1JknPK+AhOcnWe/0nAqH9R9aQDDFD95Z32gytmQia9RnQNm1iPBJ31OrrBRex+P1iZpcwhHmB/2Klnh6IUsemVNwOIwn0Mg0x0qZaOX1Rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 222.71.101.198) smtp.rcpttodomain=arm.com smtp.mailfrom=cixtech.com;
 dmarc=bestguesspass action=none header.from=cixtech.com; dkim=none (message
 not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cixtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nXIAsALo5yidsCybdoy2QGQtOmiPggHsyyymIqPE8JM=;
 b=HWkeD93j4TR5d+Z3iukS0ZVaqxAQMvALtQxXvRKidYpw+ykHloys+4Y5Td4BBy227j5D31MZtU2UIiMjxEQKOse8AFdn1XE46sZrG4SiTE9cK8B5Wx48sPhwOODrr11NTUYBDdnVAMBmY3oU5l7HtAbzFEcmBdo5UThkzWy6cpl/r8sEHwZQGvPBDpsFP1CN36snsItyUU89hH0XzzWMJ95I3F6ViaLmS2hr15ya+oTYjb6CAalFtddbsrReut+z7ZQFP1GFhWOwXqOHk9I414tkKiL6Xik4jFrws+Z07NNxkYrCTToC53NGu1MWYsgm5a6WiGkIYWdFIoS/YH+f2A==
Received: from SI2P153CA0033.APCP153.PROD.OUTLOOK.COM (2603:1096:4:190::21) by
 TY0PR06MB5634.apcprd06.prod.outlook.com (2603:1096:400:278::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.16; Wed, 26 Feb
 2025 01:21:38 +0000
Received: from SG2PEPF000B66C9.apcprd03.prod.outlook.com
 (2603:1096:4:190:cafe::bf) by SI2P153CA0033.outlook.office365.com
 (2603:1096:4:190::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8511.4 via Frontend Transport; Wed,
 26 Feb 2025 01:21:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 222.71.101.198)
 smtp.mailfrom=cixtech.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=cixtech.com;
Received-SPF: Pass (protection.outlook.com: domain of cixtech.com designates
 222.71.101.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=222.71.101.198; helo=smtprelay.cixcomputing.com; pr=C
Received: from smtprelay.cixcomputing.com (222.71.101.198) by
 SG2PEPF000B66C9.mail.protection.outlook.com (10.167.240.20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8489.16 via Frontend Transport; Wed, 26 Feb 2025 01:21:37 +0000
Received: from localhost.localdomain (unknown [172.16.64.25])
	by smtprelay.cixcomputing.com (Postfix) with ESMTPSA id 6683841604E5;
	Wed, 26 Feb 2025 09:21:36 +0800 (CST)
From: Peter Chen <peter.chen@cixtech.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	catalin.marinas@arm.com,
	will@kernel.org,
	arnd@arndb.de
Cc: linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	cix-kernel-upstream@cixtech.com,
	marcin@juszkiewicz.com.pl,
	Peter Chen <peter.chen@cixtech.com>
Subject: [PATCH v2 0/6] arm64: Introduce CIX P1 (SKY1) SoC
Date: Wed, 26 Feb 2025 09:21:30 +0800
Message-Id: <20250226012136.854614-1-peter.chen@cixtech.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG2PEPF000B66C9:EE_|TY0PR06MB5634:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: cf7f2b80-eaff-42a2-6ff7-08dd5603ea5d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Djnj0t/qH7RLfisOGhTX0NpRBFTofTAQIxReivnWNJCnHybtMUXjg2qS34Hf?=
 =?us-ascii?Q?us6IlHS8infWVzEzJKvYThjHat6hHMibPzvZKXLaJZbSjyEYa9YK6SGIsh5M?=
 =?us-ascii?Q?d8DindyCMDsLsWBF7P2Xe+CXv0EEDxgjYaxqd1F8sfcNiuSDfKleoSAz9fIo?=
 =?us-ascii?Q?a8RHHp8KqIHwGTGpqqCmn1qYofnCsXIpwSEjM2J2zEcKVx7ZPtFVUyO8HIDc?=
 =?us-ascii?Q?K0i4eoVLnoxSpULKEpK6KsrmkGpzi90jFDqFPBW8+T8EkjxsPs9jwPEsSYFp?=
 =?us-ascii?Q?Zf4wQSZU0HDEglhLrBnqzpxSOavZdjCKaAWUu0KR319QpydZMDjh78J4z9O1?=
 =?us-ascii?Q?owIy6VfiroQCVPlaOqFX6UpANkZgFgjCtDQsXsfZFk3IAUwN5pIfQBGtmD4q?=
 =?us-ascii?Q?fVZTw6ap9t+C7Ji3JhfTPE1yuHXxWcOZ4JtFta46VUd9kg+582DaE0JdzT6t?=
 =?us-ascii?Q?Dn6TuM96otRsKq0fKJt0OyeHJIXVfzp4D6V/UkZQhw1AacshROv5BwkFU9D1?=
 =?us-ascii?Q?dVsbH74FhvNNLofk5qopQqx9m8Y80PHzU/vMWVQSkgbZViCY6TUXiThdAZDd?=
 =?us-ascii?Q?C6X2HnEYS3AqIPSu9tgcUratlQ0L3xsfRdzPG7pUWj4BTQxRCESFQaL7LFFa?=
 =?us-ascii?Q?gTnPf4HBmaCvIIFygaCSjZhJjOAZu0RvjN7V+9szJR5SrZlF94Kvn4DVXARx?=
 =?us-ascii?Q?1vIfcxPRV1ouHQmbLkCPS8K4CQ2KKPVmxjmDgLCAKDHrvuQBBjYbKYPv683Y?=
 =?us-ascii?Q?3/9807KvIhCvmeXBk1VrCE/N8t380ixjH+u/inYBWeJ29CsLDxwmMdHhy9m1?=
 =?us-ascii?Q?pWxtfMpIzmLrQFMfY4Zi+nulep0Zj+fST5VumGJgJ50Ql8R1vHKJ3wrrtF81?=
 =?us-ascii?Q?0hsr/ncOrG2iojBKkqiEJz230Qwx9OvvfdMb9aB0wCw29JrUs4JHG0F3Fpeq?=
 =?us-ascii?Q?v1y81LfYF/k70oL9mxHa9QfAPfcdHm9OxGOO81O1aTvypA0OQFXSJDcloLFT?=
 =?us-ascii?Q?TteVZ/7buzXody0OIA/P4y4AO4g5/B6EnVjvBlkDbtCenfcs+yPgwDb5ydbI?=
 =?us-ascii?Q?pVFjZM1lQHNMX9mj/IA5jsNPHp8J68mzJkI98MRbxAalv4DfI84s0dDJH+m3?=
 =?us-ascii?Q?2Mitsx0v1PMnxCB9ncmuzgJLNK/KZgIPUxiCKxgTgDYgshuMlC+coLwMYqgM?=
 =?us-ascii?Q?TosSFNPcyynM6n+NX9hl1Jm9PdZ05PX6YYPFPLS3QSBAo4T1i9AjuM1ROCoC?=
 =?us-ascii?Q?QpZxJXRzznRswhx5GIg1MnagPKrA+Fzi1Z9YM/NhrxxuE8jTDznEEKnb79UW?=
 =?us-ascii?Q?jXrHM9XdoPbCS8gExyvF4YlGXU7CEQdOnrv3jnIlPY+j38VATivYstZjC3WJ?=
 =?us-ascii?Q?qGOUqit2CFqExmUeBDw3UY+EhthDOGWc+0sDU7p7G0PutbhaFWK8/glOvsja?=
 =?us-ascii?Q?3BLUcRa+JWjxpgbazShHYvSMuRAPf33z?=
X-Forefront-Antispam-Report:
	CIP:222.71.101.198;CTRY:CN;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:smtprelay.cixcomputing.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026);DIR:OUT;SFP:1102;
X-OriginatorOrg: cixtech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2025 01:21:37.1486
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cf7f2b80-eaff-42a2-6ff7-08dd5603ea5d
X-MS-Exchange-CrossTenant-Id: 0409f77a-e53d-4d23-943e-ccade7cb4811
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0409f77a-e53d-4d23-943e-ccade7cb4811;Ip=[222.71.101.198];Helo=[smtprelay.cixcomputing.com]
X-MS-Exchange-CrossTenant-AuthSource: SG2PEPF000B66C9.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR06MB5634

Cixtech P1 (internal name sky1) is high performance generic Armv9 SoC.
Orion O6 is the world's first open source Arm V9 Motherboard built by
Radxa. You could find brief introduction for SoC and related boards at:
https://radxa.com/products/orion/o6#overview

In this series, we add initial SoC and board support for Kernel building.
Patch 1-2: Add dt-binding doc for CIX and its sky1 SoC
Patch 3: add related maintainter entry
Patch 4-5: add Arm64 build support
Patch 6: add initial dts support for SoC and Orion O6 board

To run upstream kernel at Orion O6 board, you need to use BIOS
released by Radxa:
https://docs.radxa.com/en/orion/o6/bios/install-bios

Changes for v2:
- Pass dts build check with below commands:
make O=$OUTKNL dt_binding_check DT_SCHEMA_FILES=vendor-prefixes.yaml
make O=$OUTKNL dt_binding_check DT_SCHEMA_FILES=arm/cix.yaml
make O=$OUTKNL CHECK_DTBS=y W=1 cix/sky1-orion-o6.dtb
- Re-order the patch set, and move vendor-perfixes to the 1st patch.
- Patch 4: Ordered Kconfig config entry by alpha-numerically
- Patch 5: Corrects the Ack tag's name
- Patch 6: see below.
1) Corrects the SoF tag's name
2) Fix several coding sytle issues
3) move linux,cma node to dts file
4) delete memory node, memory size is passed by firmware
5) delete uart2 node which will be added in future patches
6) Improve for pmu and cpu node to stands for more specific cpu model
7) Improve the timer node and add hypervisor virtual timer irq

Fugang Duan (1):
  arm64: Kconfig: add ARCH_CIX for cix silicons

Peter Chen (5):
  dt-bindings: vendor-prefixes: Add CIX Technology Group Co., Ltd.
  dt-bindings: arm: add CIX P1 (SKY1) SoC
  MAINTAINERS: Add CIX SoC maintainer entry
  arm64: defconfig: Enable CIX SoC
  arm64: dts: cix: add initial CIX P1(SKY1) dts support

 .../devicetree/bindings/arm/cix.yaml          |  26 +++
 .../devicetree/bindings/vendor-prefixes.yaml  |   2 +
 MAINTAINERS                                   |   8 +
 arch/arm64/Kconfig.platforms                  |   6 +
 arch/arm64/boot/dts/Makefile                  |   1 +
 arch/arm64/boot/dts/cix/Makefile              |   2 +
 arch/arm64/boot/dts/cix/sky1-orion-o6.dts     |  26 +++
 arch/arm64/boot/dts/cix/sky1.dtsi             | 217 ++++++++++++++++++
 arch/arm64/configs/defconfig                  |   1 +
 9 files changed, 289 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/cix.yaml
 create mode 100644 arch/arm64/boot/dts/cix/Makefile
 create mode 100644 arch/arm64/boot/dts/cix/sky1-orion-o6.dts
 create mode 100644 arch/arm64/boot/dts/cix/sky1.dtsi

-- 
2.25.1


