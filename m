Return-Path: <linux-kernel+bounces-336912-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E724984278
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 11:44:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F1FBE1F21806
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 09:44:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBFE016D33F;
	Tue, 24 Sep 2024 09:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b="RzNVOrKP"
Received: from HK2PR02CU002.outbound.protection.outlook.com (mail-eastasiaazon11010022.outbound.protection.outlook.com [52.101.128.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E2E316C453;
	Tue, 24 Sep 2024 09:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.128.22
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727171079; cv=fail; b=dzypAJoS5rE+l//Pz13IWjC4cVx1499VFyw+hRxWw81Mb8POxx/L7P6nW0O/Lr2ccLoQhyX9bH2UqRIJoSD30ST3noAI04058qDQa6Y2Z2pWAUAEBSKVjJjjbvVfwQMuUN0j/cG54rhrJ2GQiWOOXLTOSQHhRlS/Thc3312RXMo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727171079; c=relaxed/simple;
	bh=1ypKWXkZM28FpevUq6anMcJY1ScWmcFAnE2fKkZPqEI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=DNKSu9eet7CouNpiiQ80kwV0WPmwi+9uL1puBMiu4jniN5o4POpLa0mr8AVePQgD+9YLjafkKGZQHcojX4n7HXxQt9+Oe3coMDv+YnyyIdRuNiAShjHS/VWZeDiszGehYFB22KCEfWd6eVj/Shel80g5yXJ8SPOiT+/hzTaWr9s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com; spf=pass smtp.mailfrom=wiwynn.com; dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b=RzNVOrKP; arc=fail smtp.client-ip=52.101.128.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wiwynn.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BvWuAZk+6xwRtMsQp0YbIzclFvdrJvRA+809c0ZZZ1Tj54EXNNnLBt/+gopDHAWO19XViIymuVfTBaRKFI96uQVb18WHwwmjqRnH0jT0fB9R3ri1L9JfGAWCtRdq/rwi/mzNBou2j5/zv3gfUSd5ercH9+hWxtP6Wp3gushUFLWiXqjriBfWcZUBLiah3VuS8x5vKK5qq74/MNVrWFi7xHowiyVqu0oqYKxJU5KAS4i48DgktoPjpNJg5vJXTsYToZ6qzZQcLe0Bgk94H2ocF//UDDLWlvWufXtJv07kD3hkeIvjgjHEQZWXeGejlIUrtT//noCkkyiSXrEH6RQqCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ye1N0glocfJZvNTRlCptwkK7DQVSWsC1x6PIxEzcb9Y=;
 b=GrbrvLZ57MczFxOqPKvs984Ziw9EkJuiYz7arjZdrCyah3ND0IFisnuxrR0ig3+sJBvNo143EiVfcjxbuQJM84aKKlGBsel12+5UKEDwGDQIM0ZltoX8hDYsEXXybl7U0vMfcz/m8qSAkOtBz+3Cr9tRrMEkT4GySI20N1jxraoweD0gnNospikrtL06k08rwo9+gw9vYPyyBol0Rz8/7EK+J3QCDYqWgHicTLWhh/JrkjAg7HQEakHUvopUwHcMkA/+4ZYnzd6oz4hJ7QJn7m7MDPSIjx/yVH4PSYNi9HGFA+7zU6cqAo2TD2RV59yVH7LkXtqkZpDqes95qlC33g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 211.20.1.79) smtp.rcpttodomain=stwcx.xyz smtp.mailfrom=wiwynn.com; dmarc=fail
 (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=wiwynn.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wiwynn.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ye1N0glocfJZvNTRlCptwkK7DQVSWsC1x6PIxEzcb9Y=;
 b=RzNVOrKPwZTCe6lQspVqhlBmRCfkk1iIWhF8UHIFReLPf0cga4W+hpFrxGW1wzbu1bdJwVz4PJ/S/+IqnsUKepA3nQOqSKu6MYzjqWovhVM0yTLaw9feg8nBykkpo0gXYeeGPvUAOjJq0B70JE+111DqYzrKJI11LhgyrKbjyI74RouxRUcg80rmMpm2fJX57msPawxMrfevG0V2haVL5/vPYBuV+rPU2yaCF6wzhokgsyy7Xz3aRBYW/XYYDeJ4DThGQxh04/Akla3cuKoHRZwz0citDPvqI64YeMuklU9etcwmkbGkHDezQF1P37KjiEGb0ZUVhOMZglRP5dNIIg==
Received: from PS2PR03CA0019.apcprd03.prod.outlook.com (2603:1096:300:5b::31)
 by PUZPR04MB6183.apcprd04.prod.outlook.com (2603:1096:301:ef::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.27; Tue, 24 Sep
 2024 09:44:33 +0000
Received: from HK3PEPF00000221.apcprd03.prod.outlook.com
 (2603:1096:300:5b:cafe::cc) by PS2PR03CA0019.outlook.office365.com
 (2603:1096:300:5b::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.16 via Frontend
 Transport; Tue, 24 Sep 2024 09:44:33 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 211.20.1.79)
 smtp.mailfrom=wiwynn.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=wiwynn.com;
Received-SPF: Fail (protection.outlook.com: domain of wiwynn.com does not
 designate 211.20.1.79 as permitted sender) receiver=protection.outlook.com;
 client-ip=211.20.1.79; helo=localhost.localdomain;
Received: from localhost.localdomain (211.20.1.79) by
 HK3PEPF00000221.mail.protection.outlook.com (10.167.8.43) with Microsoft SMTP
 Server id 15.20.8005.15 via Frontend Transport; Tue, 24 Sep 2024 09:44:32
 +0000
From: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
To: patrick@stwcx.xyz
Cc: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/2] Adjust the setting for SPI flash of yosemite4
Date: Tue, 24 Sep 2024 17:44:28 +0800
Message-Id: <20240924094430.272074-1-Delphine_CC_Chiu@wiwynn.com>
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
X-MS-TrafficTypeDiagnostic: HK3PEPF00000221:EE_|PUZPR04MB6183:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 3d89e636-99a1-4eef-1574-08dcdc7d7e33
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|7416014|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?m59lBVYkfty40qRsLUHlzp5abOkywe0sYKqxtG/k7tjzCosLAcqqr6jRhCtz?=
 =?us-ascii?Q?Rk3nelEbKMvNU8TABIbFH+jK4pU1bVFK5lbDWQnXjJZLYiSHvALhXfxSyZpF?=
 =?us-ascii?Q?eCK74zyozGMioQcUHBfqoSQM4b9nFqX1RvZfA2LZrbW+mrT+kB2zgXtX3Cwp?=
 =?us-ascii?Q?eMiZ2XrEjOXuS3vdCWABXL7JZwwARGlNVp2tk+TDDDuS+YHeyZNHSLapxhvv?=
 =?us-ascii?Q?bzPjqIoodjuwY21e361oALjW9R8EyMitErPYlETlEXJeXtgtE10+Gfl8WlLI?=
 =?us-ascii?Q?u8H0fCEojg+tSZ0mfW4kCm37qRxa7vuEuREdZ5EDLaFwIpokRUmpbp4AM6T/?=
 =?us-ascii?Q?AT9NxNFYJxTL4M8S3EL6z/CP+65jF+n5dOKcIN8BKpfLHLkENur8OtS7oL8o?=
 =?us-ascii?Q?ddgehB1x9W9Ac6cDqyPf1Sjgl0cJpMVWCcy9ak2Z4mAJ1h+WQLWU/E0l5nJJ?=
 =?us-ascii?Q?aKCG8KU8nAmxHB3SK3q9liJFfTStcclazf/zZZYrHci68tBrt34hV/1fdbVK?=
 =?us-ascii?Q?rh/b8ey2gndK82yLp19/eRqAPErSFXVwTblZID3fO8ub+8M7HrqAO2og66N6?=
 =?us-ascii?Q?L7Nbmp2IBNkFfPfFelTyFkM9o1CnG9wRwVyoNxTB1PkazdBfaYlPqPGjlKea?=
 =?us-ascii?Q?3FPeZbrg6UTjzGmo3dE7YyzVT/lG8sWVhPS16Qr+7RGNXGUTZoIL1G04imab?=
 =?us-ascii?Q?h0jHhGtOaXQ3e82vK6Jf0mx09BITTJGPDSFs/0Vj6/c3zxHOw/f9/s3SXmrQ?=
 =?us-ascii?Q?GgWbQtCaSp+GTcXmvB02z2yjQVh5dE1icRy6gLITPW3kAff2DUc9em5f/U/K?=
 =?us-ascii?Q?IJ3d8bWkPVkb1wxi+Ou+SoYnq1UY+pTARYGKZ5Dd3C7txACUcEYzhq9vdTGl?=
 =?us-ascii?Q?Qtac2Vb03NApNuvxlFkQrh7gkkYRu6dAcZjBDZqt14RRE+rwHQ9y5gEGK8VP?=
 =?us-ascii?Q?etPbEvN3hSTT2bBNY6LoGqULC7IqWPT7ZH4VthM7m3j07vZ+lsYnTGdCW3Rd?=
 =?us-ascii?Q?ZIYKtrPneWiwk9gk5C5h5qvcD+o+TvmRSuEyJE4eF463B48u7jpEyyF5N0i2?=
 =?us-ascii?Q?lvmJp5WT4QS8sLWrIci4IE3IL78/VR50ZJtB3jHqm5xHpIMZsWRUlWO+GpO7?=
 =?us-ascii?Q?aCxwjkUOsAlZvqymNsYYaJqm6nUhCKr/6l5DFywW3AC9K1Hqt1wq1XAAA7a7?=
 =?us-ascii?Q?OYfDo2nanL0AVbLCzAvG4/ASgtvSBsExd/pfvft1fchkWlZQYw6f/y9/9vEP?=
 =?us-ascii?Q?TeMJRQhupSUMVXY7XQu1lu/ORaDg08xEQaWc4m81MEW81qrzPDuCIKTzE3kQ?=
 =?us-ascii?Q?JXL2o+eCi5pvdHlVHCMKD3EiKQdYkAVFBCrArxYuxGP264kebNLZG2MDtiVe?=
 =?us-ascii?Q?AjeUOT6Kyhh4AgzBqY8Pi9ydk67t?=
X-Forefront-Antispam-Report:
	CIP:211.20.1.79;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:localhost.localdomain;PTR:211-20-1-79.hinet-ip.hinet.net;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(7416014)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: wiwynn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2024 09:44:32.3880
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d89e636-99a1-4eef-1574-08dcdc7d7e33
X-MS-Exchange-CrossTenant-Id: da6e0628-fc83-4caf-9dd2-73061cbab167
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=da6e0628-fc83-4caf-9dd2-73061cbab167;Ip=[211.20.1.79];Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource:
	HK3PEPF00000221.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PUZPR04MB6183

- v2
  - Split the patches for different targets.
- v1
  - Revise SPI flash to dual mode.
  - Revise flash layout to 128MB.

Ricky CX Wu (2):
  ARM: dts: aspeed: yosemite4: Revise quad mode to dual mode
  ARM: dts: aspeed: yosemite4: revise flash layout to 128MB

 .../arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

-- 
2.25.1


