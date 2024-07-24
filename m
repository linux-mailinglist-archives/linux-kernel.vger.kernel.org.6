Return-Path: <linux-kernel+bounces-260691-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A1B6F93AD0F
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 09:14:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 108A3B22670
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 07:14:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3B4C73440;
	Wed, 24 Jul 2024 07:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="GLBhWj5o"
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2060.outbound.protection.outlook.com [40.107.243.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF90D77102
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 07:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721805213; cv=fail; b=bRn/WuFnv0+qwzBSrLsvqrPwsq2OR5emsaoFwX4R/K7r0ZxMDP+KAVxr37ZiWA/S6P7tGMZWbyl7MMjYl6CYTDN+mhyD8xYnf/O8/HTSm/wTUJIWGXbXFWJustYxlkBALR9pzNUpnCLAAxNDAn5Cq4x8GZB0qzs0fVocecUBpP8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721805213; c=relaxed/simple;
	bh=RoNETKBoejaYGy9rbtJm6AGin8ehjmKDmfSBHCgGj1U=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=S+u6cI0zZOnuJS6Y4O0cIsQurR48KIvKbtj0xeKPNRCciRDOV2XtcvuPYskjug2iT3K4SRoveoFqD9vjDPVUZ9/IKxsfu84QatT+7GbSy/chOSEuichk2f3g2ltjJPsbXYy0gYU4rcJRtQIVWfRBVzpTyGf0eu4hNwqWCQF2LP0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=GLBhWj5o; arc=fail smtp.client-ip=40.107.243.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AY3MXPQd+hXX1yTcy1C17F/NKIknM+q0lOTWl7osam31p8bgkmk9etigusKJsO3fwxlyxavUo5ABDznD+oFLunFUP1XG0QF806mo17Hmh0PKJ3G/J2nw2EtDaCiZg6NNampoWEWnAAAYN9WJC6aXx685/VdxBL32EUNgkC22bjF19oJrZeV0jNET96AVG2QH9Jy4DSDIGOe7GsOGyHx0WVBVZcuq6/3LcQf/lV29mkD86QSpN0Ghf2q77ASxxqHxt/CnN0y24z7UaMXE8Z2LVyZVBE6eGqWBZ1W61b9k00BpIoTL1RtuCeFytEsn3nFXbroXM13JcuRmobYFFVNLbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UtBl23dy1zJf9rkzc7HruH/ojUo1R9wqQ1CABqtj3vY=;
 b=xNavNUxRdyyIMVnP/mYFpJYuV5ROe//CHk+Xr5boJ0t+AtF9ReL6IugFeUGm4S30YI99FSd0eNlXbdyUjtaoA8UZSar+/P2yE7i/Wm2Hbc1JG0Qg6pWgrw7dMjPanJbmG64LAZg6f679ynteZKJrpn1wMN3o+9ubEBYFQLtIiuU/5FwAUAg5ISr/hblSJcDxeU6UO5MOiqe4EYELJISITM4dPG38IfF6iGNA1oXwD6KdTNNHZx4zS4pOymIzzpJlw7RQiAlqyfjzCFmsuSHASaGO/0wMAz1EfCArgJj0NPScf6NlI/xlkrUmjkaBVLH2G0W4iC8m8Uh/8kWR9B/1Hg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=bootlin.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UtBl23dy1zJf9rkzc7HruH/ojUo1R9wqQ1CABqtj3vY=;
 b=GLBhWj5ocoiVexDgOFMG8poNOvo7i5Tp8u/5RUGtMAiX172BeOvTOrM1hTWwUIDeXZG7mZmVCtW/C5cUTD1vqTsmYCYr8LHDn9N0Sbx9qeqyn5y60D3ok1YB2j2Sd0Fgt0ESVb5gwU2fqL2dA8YuupuEkjAIWYcBxemP8m/jQ3o=
Received: from SJ0PR13CA0027.namprd13.prod.outlook.com (2603:10b6:a03:2c0::32)
 by CH3PR12MB8457.namprd12.prod.outlook.com (2603:10b6:610:154::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.18; Wed, 24 Jul
 2024 07:13:27 +0000
Received: from SJ5PEPF000001D4.namprd05.prod.outlook.com
 (2603:10b6:a03:2c0:cafe::21) by SJ0PR13CA0027.outlook.office365.com
 (2603:10b6:a03:2c0::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.19 via Frontend
 Transport; Wed, 24 Jul 2024 07:13:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001D4.mail.protection.outlook.com (10.167.242.56) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7784.11 via Frontend Transport; Wed, 24 Jul 2024 07:13:27 +0000
Received: from jatayu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 24 Jul
 2024 02:13:23 -0500
From: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>, Jarkko Nikula
	<jarkko.nikula@linux.intel.com>
CC: Guruvendra Punugupati <Guruvendra.Punugupati@amd.com>, Krishnamoorthi M
	<krishnamoorthi.m@amd.com>, <linux-i3c@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
Subject: [PATCH v2 2/5] i3c: mipi-i3c-hci: Add a quirk to set PIO mode
Date: Wed, 24 Jul 2024 12:42:42 +0530
Message-ID: <20240724071245.3833404-3-Shyam-sundar.S-k@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240724071245.3833404-1-Shyam-sundar.S-k@amd.com>
References: <20240724071245.3833404-1-Shyam-sundar.S-k@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D4:EE_|CH3PR12MB8457:EE_
X-MS-Office365-Filtering-Correlation-Id: bb992048-68c9-4448-162d-08dcabb01d4d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?VJBMgBf1R/dEFLY/chanA4yoRH4Xgiib3/eLejmEjqybDxVWsRh5cgXgSjEt?=
 =?us-ascii?Q?tK2yuDn7Cv/amU52z73HuZEcLgw9MnDJQN6fTZU1xlpbqVyFpLTH4MxR3qqo?=
 =?us-ascii?Q?TpXIINTzm+16qMB2P/COHKmgdcTCPNCAzfpvMcBj4VI3Kq0f4MN/vHRgLl6L?=
 =?us-ascii?Q?oTwAhUO3vCmNRXO5YFKh7s/1DLFo31bTkHI0hjioy4HZPeV4N1MV4hFomdVp?=
 =?us-ascii?Q?8FHgVOIuutG1+eyEpXi8WCrue0xbZUvi37FnbgNwuMJhw/8VhjCalcvCmZEz?=
 =?us-ascii?Q?qJkVbA4yRfJwExVI06zooVi2nP5cPEp7LFBGIqkxIhFTdIcxQAYG/Ijh/Bfc?=
 =?us-ascii?Q?ELh96eeJ/OLS99aBKFM3bdZy10GbJYrMOfeqXdjWYGZGh6CVFDqHp04k80vZ?=
 =?us-ascii?Q?dB9kT5d9ivZKlXPkcukzaNLSXz/Lpm1MraOmyWgbggSQgi3vxPVSzGvoarnJ?=
 =?us-ascii?Q?8KdtDxri65oj9flEQbF6fBWpyNuFRoDQVqcnVDG2ZTEB3Ojj/vUNCWP0/3FJ?=
 =?us-ascii?Q?pECXVwDwd3+Qdl7dx+uPFY2KxAomIAysqgpHGRRfZgQZpwibNjDef8jJjlr1?=
 =?us-ascii?Q?TlrT/sCnQQEpbJOOeUUcgBg4AQ8Iah+25aWdHi2dWwDb4Y4ANafJeY1cC99K?=
 =?us-ascii?Q?Fy12dPwVc9qr+d7kV7+OqeYX7+uhQJ6lIPsD5Gc6+UFHZI6Jj8sntbfyc+ox?=
 =?us-ascii?Q?2jSk0VKTt/XvzXleQy1WVHk98A6otC9SvYJBjEtH9iwgrIbSOY08Mea6mHeb?=
 =?us-ascii?Q?IcFmZqAKbelfUQi14ZSmyjNYtW3ISnu1vcxBswGUWqoLNAeE0qZpBDaIN4t+?=
 =?us-ascii?Q?nNmz1yQeZZjgKF6UpIROeta0KDHkmo8XlSr91oFZ3k5JzQ/Xv6KxERkaqiHm?=
 =?us-ascii?Q?4uRSFiAosMbaA400MQRyp1wg1eWgshfnTrNXK+Xe8XuAluZtD83FQ0w9Mp0A?=
 =?us-ascii?Q?A42u7nk0Igj1+1hc7PzMlHeT8UDGNPsDFq+8mHUOKpvdQDOXNKZCl6hsG4o+?=
 =?us-ascii?Q?AdxdbucWgUFlSMyT2ahrxywo8bEFWjZlPuBicxpwYK3+beCcQxyn5vNcmqJ+?=
 =?us-ascii?Q?hX9OStUaIz/h+vSHJWGdWacZOFIVsojXLV626qHk30zF185cCi9DMopnXq4h?=
 =?us-ascii?Q?4A4ma5kuE7h4UIRFZ+80BIS0ExX8fNMQC5HjhTSSaMTdL2SDFJPFtmI5NvaZ?=
 =?us-ascii?Q?16r4zZQXHHu2p1rC+IcjLCGl8PSkGRNi9DPSYfvdPckoTi5zRrrrn3vrMZ6L?=
 =?us-ascii?Q?mRwaJ9n84un5Am+UkbL/JMJJ8hHwkNWcPUOAxmiQs3CgJC6/xgqHN5SZ56RQ?=
 =?us-ascii?Q?sPGZr54/pYPFywlEc8Hk0lwujW2m3P5SEZ5moY9roGWKiZULWjjqAAkwLumT?=
 =?us-ascii?Q?dPORlTZZ+UWxHwr49Xj4zffWQ8nkYM51PH6tpF59KMX2pN4TQVTVmmmf1CE1?=
 =?us-ascii?Q?n+c9Co1lOthI8MEn0YvpUHCr95yx/p7E?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2024 07:13:27.2390
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bb992048-68c9-4448-162d-08dcabb01d4d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001D4.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8457

The AMD HCI controller currently only supports PIO mode but exposes DMA
rings to the OS, which leads to the controller being configured in DMA
mode. To address this, add a quirk to avoid configuring the controller in
DMA mode and default to PIO mode.

Additionally, introduce a generic quirk infrastructure to the mipi-i3c-hci
driver to facilitate seamless future quirk additions.

Co-developed-by: Krishnamoorthi M <krishnamoorthi.m@amd.com>
Signed-off-by: Krishnamoorthi M <krishnamoorthi.m@amd.com>
Co-developed-by: Guruvendra Punugupati <Guruvendra.Punugupati@amd.com>
Signed-off-by: Guruvendra Punugupati <Guruvendra.Punugupati@amd.com>
Signed-off-by: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
---
 drivers/i3c/master/mipi-i3c-hci/Makefile |  3 ++-
 drivers/i3c/master/mipi-i3c-hci/core.c   | 15 ++++++++++++++-
 drivers/i3c/master/mipi-i3c-hci/hci.h    |  3 +++
 3 files changed, 19 insertions(+), 2 deletions(-)

diff --git a/drivers/i3c/master/mipi-i3c-hci/Makefile b/drivers/i3c/master/mipi-i3c-hci/Makefile
index a658e7b8262c..1f8cd5c48fde 100644
--- a/drivers/i3c/master/mipi-i3c-hci/Makefile
+++ b/drivers/i3c/master/mipi-i3c-hci/Makefile
@@ -3,4 +3,5 @@
 obj-$(CONFIG_MIPI_I3C_HCI)		+= mipi-i3c-hci.o
 mipi-i3c-hci-y				:= core.o ext_caps.o pio.o dma.o \
 					   cmd_v1.o cmd_v2.o \
-					   dat_v1.o dct_v1.o
+					   dat_v1.o dct_v1.o \
+					   hci_quirks.o
diff --git a/drivers/i3c/master/mipi-i3c-hci/core.c b/drivers/i3c/master/mipi-i3c-hci/core.c
index dbc8c38bd962..8bb422ab1d01 100644
--- a/drivers/i3c/master/mipi-i3c-hci/core.c
+++ b/drivers/i3c/master/mipi-i3c-hci/core.c
@@ -33,6 +33,7 @@
 #define reg_clear(r, v)		reg_write(r, reg_read(r) & ~(v))
 
 #define HCI_VERSION			0x00	/* HCI Version (in BCD) */
+#define HCI_VERSION_V1			0x100	/* MIPI HCI Version number V1.0 */
 
 #define HC_CONTROL			0x04
 #define HC_CONTROL_BUS_ENABLE		BIT(31)
@@ -745,6 +746,14 @@ static int i3c_hci_init(struct i3c_hci *hci)
 		return -EINVAL;
 	}
 
+	/* Initialize quirks for AMD platforms */
+	amd_i3c_hci_quirks_init(hci);
+
+	regval = reg_read(HCI_VERSION);
+
+	if (hci->quirks & HCI_QUIRK_AMD_PIO_MODE)
+		hci->RHS_regs = NULL;
+
 	/* Try activating DMA operations first */
 	if (hci->RHS_regs) {
 		reg_clear(HC_CONTROL, HC_CONTROL_PIO_MODE);
@@ -760,7 +769,11 @@ static int i3c_hci_init(struct i3c_hci *hci)
 	/* If no DMA, try PIO */
 	if (!hci->io && hci->PIO_regs) {
 		reg_set(HC_CONTROL, HC_CONTROL_PIO_MODE);
-		if (!(reg_read(HC_CONTROL) & HC_CONTROL_PIO_MODE)) {
+		/*
+		 * HC_CONTROL_PIO_MODE bit not present in HC_CONTROL register w.r.t V1.0
+		 * specification. So skip checking PIO_MODE bit status
+		 */
+		if (regval != HCI_VERSION_V1 && !(reg_read(HC_CONTROL) & HC_CONTROL_PIO_MODE)) {
 			dev_err(&hci->master.dev, "DMA mode is stuck\n");
 			ret = -EIO;
 		} else {
diff --git a/drivers/i3c/master/mipi-i3c-hci/hci.h b/drivers/i3c/master/mipi-i3c-hci/hci.h
index f94d95e024be..046b65d43e63 100644
--- a/drivers/i3c/master/mipi-i3c-hci/hci.h
+++ b/drivers/i3c/master/mipi-i3c-hci/hci.h
@@ -135,6 +135,7 @@ struct i3c_hci_dev_data {
 
 /* list of quirks */
 #define HCI_QUIRK_RAW_CCC	BIT(1)	/* CCC framing must be explicit */
+#define HCI_QUIRK_AMD_PIO_MODE		BIT(2)  /* Set PIO mode for AMD platforms */
 
 
 /* global functions */
@@ -142,4 +143,6 @@ void mipi_i3c_hci_resume(struct i3c_hci *hci);
 void mipi_i3c_hci_pio_reset(struct i3c_hci *hci);
 void mipi_i3c_hci_dct_index_reset(struct i3c_hci *hci);
 
+void amd_i3c_hci_quirks_init(struct i3c_hci *hci);
+
 #endif
-- 
2.25.1


