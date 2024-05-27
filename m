Return-Path: <linux-kernel+bounces-190343-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9385C8CFD16
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 11:37:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A9B3283C35
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 09:37:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44B4C13A897;
	Mon, 27 May 2024 09:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="IGCOGKda"
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2070.outbound.protection.outlook.com [40.107.212.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5E4A13A88D;
	Mon, 27 May 2024 09:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716802506; cv=fail; b=BiVDTgmvPS984pbl6d5RkuGL9XimuMCLmqd3JU3vvlA+yT/x1/VDab75DVQUNnHH/3STarQCPbzkZKfvRIowByZIKVarcHfa1lmMx0uIPdyC59NUOQ5BxNXWckID2toM30ZdFyhzyEyR5q1Mum0AJHuUdCbEqQ1YWF31U9gcs9c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716802506; c=relaxed/simple;
	bh=59azTxhi6ok1NJU3C98a8ab5AYVuvhTV4hMdsg4AAp4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qAGzBu5gG431E2Y7pg/CGXa6KNAlk47nP0Eb2REgr67pcUzCK+nbiYpphoevw0wCUwjxEQw9ZbC6pikrqCrvXLaXcDqAS3hIIgKXMej+B5VUgdnzZyt4fIf/IHxiukK8lhYn504WnqjjBUPkJ9k7sfNPt02zN0bhgzz/f/BvHYs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=IGCOGKda; arc=fail smtp.client-ip=40.107.212.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Fv7SS/kyF2Ksp4PTXcnZi/yq5TgoEsi/H0tQshyoHPYK/WSE5yQYFxN+XZtFCsU15nOAROuWIthaU1wM0NktEm89DcBwmGylkylyQubaoubjv8DjptPp1JJCXoqk84Yxe10HVL0f6egiqcKH79nzPGODOCTs1G1udbT/P9jyJCUIM1EylNeZmJJwxuOAcvY1tlQEBaKNvUNpiGN0HNcNEGCgZzdB1FyDZkenwIvIUd0dr9B00mu0ctw8tm6Gtd9kmye0kgiP+voCqasAUMnCXaP9xAa190AVWsCrGJu5JMzyRd+xjOzp3HC48iifJGLG2prMZgyq+ddcj5OBw3YdeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2qJv6FF1YN+sNMaPPetVxc5zFbg+erg0/sNdu2GXXRI=;
 b=Fjf2L9XKancwN4fV2lBKFimU9Eq0YKnjGJgX1UP8O3bk2aHYhe6a50KZGWosKfRvfxDMskx7CetHXbaTlWjBFuwsycM6/iHi937JT9LrZQiuqUrDZgC7XP6YgYVf++KC/MAb9BpoLOhlyp28JrDCqZSQnnIjBcn+Kz0dMs3yMBJAqa5vSnf4uTq9IIHoWAXfiaM0Exhr4/y2RT0PrwRsdpxm/BR4zaHCcdvyfM4tsM6+oO4Phx8HKsNh6gW85ChIVbCHd+0GP0OFmddVm2Ahw09Pr3EUeOnd9YRo+J44ZKy/AazgD/CoOzMUKKpXazcNBn5VxWzXm73C+3bcKuP6vw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2qJv6FF1YN+sNMaPPetVxc5zFbg+erg0/sNdu2GXXRI=;
 b=IGCOGKdahrR/5iTvmy7vjckl7GsCJve6Xd9f2F1n65ldsWpD8AbG7ap7dfppf4e9i96QRemZAMd3qNwQVygZxVAgTeZmsCSK6zFE9yHk2gY248+5L9oaepof0HILCyHuhKovMLdpFD1Q9aG9SGz7HLoJtbyehvRAZOz/JnoWIU4=
Received: from SA0PR11CA0026.namprd11.prod.outlook.com (2603:10b6:806:d3::31)
 by PH7PR12MB8124.namprd12.prod.outlook.com (2603:10b6:510:2ba::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.30; Mon, 27 May
 2024 09:35:00 +0000
Received: from SA2PEPF00003F68.namprd04.prod.outlook.com
 (2603:10b6:806:d3:cafe::7e) by SA0PR11CA0026.outlook.office365.com
 (2603:10b6:806:d3::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.28 via Frontend
 Transport; Mon, 27 May 2024 09:34:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF00003F68.mail.protection.outlook.com (10.167.248.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7633.15 via Frontend Transport; Mon, 27 May 2024 09:34:59 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 27 May
 2024 04:34:58 -0500
From: Michal Simek <michal.simek@amd.com>
To: <linux-kernel@vger.kernel.org>, <monstr@monstr.eu>,
	<michal.simek@xilinx.com>, <git@xilinx.com>
CC: Conor Dooley <conor+dt@kernel.org>, Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>, Rob Herring <robh@kernel.org>, "open
 list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
	<devicetree@vger.kernel.org>, "moderated list:ARM/ZYNQ ARCHITECTURE"
	<linux-arm-kernel@lists.infradead.org>
Subject: [PATCH 08/12] arm64: zynqmp: Add compatible string for kv260
Date: Mon, 27 May 2024 11:34:14 +0200
Message-ID: <1e436f82182a92187f3892401664db2507482870.1716802450.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1716802450.git.michal.simek@amd.com>
References: <cover.1716802450.git.michal.simek@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1640; i=michal.simek@amd.com; h=from:subject:message-id; bh=59azTxhi6ok1NJU3C98a8ab5AYVuvhTV4hMdsg4AAp4=; b=owGbwMvMwCR4yjP1tKYXjyLjabUkhrSQ4Glrfpl53H0sqX/dwX3+U4n2q8lza8ME9kn9yF+tW Cv0x/FwRywLgyATg6yYIou0zZUzeytnTBG+eFgOZg4rE8gQBi5OAZjI9iKGOVy77B3bnjBdvnTj B5OGcLeFGdcTVoZ56hE+bh9ePlfkMz/5IsDSpO5BN1suAA==
X-Developer-Key: i=michal.simek@amd.com; a=openpgp; fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F68:EE_|PH7PR12MB8124:EE_
X-MS-Office365-Filtering-Correlation-Id: 3d0f3db4-9cd4-4073-8292-08dc7e30473f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|376005|36860700004|1800799015|82310400017;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?3OxcW4HMdzKWW+MYbVWxrhDe7euKrW6wx8TJKUn8peokm2mGiMxUDHRNcK2O?=
 =?us-ascii?Q?G2vjJQtSs3iFjHTq0gr+qMH9rBTp7iCGN451yVV4RAqHTfC4E5Lf4dSjyj8b?=
 =?us-ascii?Q?Fk7V/5NvgRsEB4WCvL65V5d6FuQ0oq+9/WIcKThQPBGO0SNpPxO/eUr37CPh?=
 =?us-ascii?Q?E+uF7gKd5GHbXld9tEvR4ShQj1QQdcXoaVWn1q5TcAYjgmuwCxd8GnpFUhnM?=
 =?us-ascii?Q?QBB0WsYmKU1Nioji/SmGbiGaR5hyFaPgIyQEPaRCu7csDKKmzrCuwyYNFWHQ?=
 =?us-ascii?Q?jLNnjvcPyOv9z56CWhabWJicZayXgN/QrM09pc4szM1O0q/U9l+pzFQX/Ndb?=
 =?us-ascii?Q?ZQIWdIkhjbSAtHCXhP027LuP3GDfAMkiBSMoKPRRkc1NqTiL5DHVvwSsXgXt?=
 =?us-ascii?Q?xLMYMa4vBtIWe/ZAhFtFzFidlJzKytMP2DIVytG8wxcUvi4kv5Uh5lVRHIKE?=
 =?us-ascii?Q?7gD+smts8AQ8Oc1g2gtqMDVDwFMjH1aFfyr13qBrrKjFUBfBpHzrceNaHMEs?=
 =?us-ascii?Q?uFc7twlLPNuoOKibyesBga/3UPFrgGlS1oEW5Q2dOm50c9wyyLFMNtXAbQMO?=
 =?us-ascii?Q?5GneDVxow3Tb7DxBmu2RQs1HQPVqYHxVjxCnB06vVaPcfTPmx/Jd5k9++taO?=
 =?us-ascii?Q?dPBZsc3wTYodJpFAfv18EZryYHW48AItp34Bdpqf5CkMPdXxz38AOoYvXqfp?=
 =?us-ascii?Q?rzpUaPRsPJg8cozBtd35bKEEQVFVuqZXfHxxA1KIZAJxFQV980LG3bWmMWEe?=
 =?us-ascii?Q?ooulv4VjtTaW1mK5JhJugXwJLejhCkboOebssf8yw8YbvN6e8EIhZlw+fj1q?=
 =?us-ascii?Q?Zty/1xlDBSFMFEuXVzuFJNW0Y28oxnL0GLg8EJhVxzW5Dj+mI14+4L6j+gnz?=
 =?us-ascii?Q?uU7dYXnlV6UqHezZ6U2ixf4CEY4EhLaMuNrHisVX85s3C/bFmN+/UD/ei/eB?=
 =?us-ascii?Q?Q5abfxNRdMc+5XXRZZQ3z2CgtVzcdSRHQP0BAV6QeMRRHJQ4gFtVNjdSJagI?=
 =?us-ascii?Q?TGsSM1Cjgkgrie/1dPFEtDH7BZniSTZ+nM9V5TYIc9dsRZBUTfryEU4kzOd3?=
 =?us-ascii?Q?DEZhKnSBfnH2Nzq0L85SXREOAEHZqrMbkttLDjwEITXsnWMFqlisgu71mwY3?=
 =?us-ascii?Q?/lwGxcRjKuJeM8u4g6lTPMDkkWupux79ekvg6CbY3ftTMNbZLeZTujJhpDn4?=
 =?us-ascii?Q?abIiH0FOSdxf5PxfjCCHof3TvzwhJN8iBLOykYONnxFUShZz+vJhQA1m2ol+?=
 =?us-ascii?Q?koprfrvi12OH8tNf6WG70M+vAETmH+OPz/Hg119Y0F+BArplND3V4WDZGooH?=
 =?us-ascii?Q?6sNLYfhKVwYUyaRfyIwO9aOyKCoFqPIFuoXFNAr577E7pCnXmR7rTzrifU/x?=
 =?us-ascii?Q?b6yDxCXW46l2nLW7+Bk4ckBjOBgX?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(376005)(36860700004)(1800799015)(82310400017);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2024 09:34:59.8017
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d0f3db4-9cd4-4073-8292-08dc7e30473f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003F68.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8124

The commit dbcd27526e6a ("dt-bindings: soc: xilinx: Add support for KV260
CC") added description for kv260 kit and it should be also reflected in
DTs.

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 arch/arm64/boot/dts/xilinx/zynqmp-sck-kv-g-revA.dtso | 6 ++++++
 arch/arm64/boot/dts/xilinx/zynqmp-sck-kv-g-revB.dtso | 6 ++++++
 2 files changed, 12 insertions(+)

diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-sck-kv-g-revA.dtso b/arch/arm64/boot/dts/xilinx/zynqmp-sck-kv-g-revA.dtso
index a09909a6f885..0e5597e2fe10 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp-sck-kv-g-revA.dtso
+++ b/arch/arm64/boot/dts/xilinx/zynqmp-sck-kv-g-revA.dtso
@@ -22,6 +22,12 @@
 /plugin/;
 
 &{/} {
+	compatible = "xlnx,zynqmp-sk-kv260-revA",
+		     "xlnx,zynqmp-sk-kv260-revY",
+		     "xlnx,zynqmp-sk-kv260-revZ",
+		     "xlnx,zynqmp-sk-kv260", "xlnx,zynqmp";
+	model = "ZynqMP KV260 revA";
+
 	si5332_0: si5332-0 { /* u17 */
 		compatible = "fixed-clock";
 		#clock-cells = <0>;
diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-sck-kv-g-revB.dtso b/arch/arm64/boot/dts/xilinx/zynqmp-sck-kv-g-revB.dtso
index b3b8875f8f7a..fb37c06cfd69 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp-sck-kv-g-revB.dtso
+++ b/arch/arm64/boot/dts/xilinx/zynqmp-sck-kv-g-revB.dtso
@@ -17,6 +17,12 @@
 /plugin/;
 
 &{/} {
+	compatible = "xlnx,zynqmp-sk-kv260-rev2",
+		     "xlnx,zynqmp-sk-kv260-rev1",
+		     "xlnx,zynqmp-sk-kv260-revB",
+		     "xlnx,zynqmp-sk-kv260", "xlnx,zynqmp";
+	model = "ZynqMP KV260 revB";
+
 	si5332_0: si5332-0 { /* u17 */
 		compatible = "fixed-clock";
 		#clock-cells = <0>;
-- 
2.40.1


