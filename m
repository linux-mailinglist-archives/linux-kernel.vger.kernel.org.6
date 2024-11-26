Return-Path: <linux-kernel+bounces-422751-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 398009D9DCF
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 20:06:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AF58EB21072
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 18:59:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 674F21DE2C6;
	Tue, 26 Nov 2024 18:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="lIDpLA4N"
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2052.outbound.protection.outlook.com [40.107.101.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCFEA1DDA0E
	for <linux-kernel@vger.kernel.org>; Tue, 26 Nov 2024 18:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732647555; cv=fail; b=sQanoztffV1gLZcEX5SC7XcuffxJsA0MUeRGhb4McDFs8gJCigWvvZpMAezVKeNkLDdCElwyjT/IEyOG/+b5m3hbL4/RQbjIX1bNjxUeZzyFQCnIbCcptZy90eOlcwLWAZLQu1D1C+EvKJveSa+UgL3DOWyTMrqpUeiuCSikqHc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732647555; c=relaxed/simple;
	bh=tD/NaBBDUScZJb2R2VTqSVdQnpX0jVSKOVDm+R52AOE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=s4ndmuow/H5V717kxY8ua4t6KCbOWBOjEwWHrQzFa/bFST4GJlHaL/reM17RW+ZByDLkio318RDWIQYMbve4tvyZy+m18Lp+rylLWFk2mJzeiRFUxtpoF9BgqBVpKmD3V42yuquMr2gXBtj8W3+mnRnaulLcNX2WZMSNBdPVn/8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=lIDpLA4N; arc=fail smtp.client-ip=40.107.101.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pVBIqj9CRe3aTnOeag/aTrfvrIeFzuKMHSKvNWf9rsyu9sLm/Qc1MMk2U96PB+yX8+kPCUIbl+Cm6ppxIQNO6ifEn4f12PeNUiirUopJ5mJSFqzkplpa4dFnQS2zRitn92PgMMeUWL0qiLWBvyDCA7GrbsySe8hpMr3DIDVwccoTQD7QqbQn5zV0GGMmI64KJE9NM+XDOh+AEcu2LutsRuTo4o5Ocx5vGvTLJxJYcrXwiW0Gz3EVFhsjM3PQcmHt9CWkZWhchxmxiAMKyGPl6K75nyvoXzNYdlgPAGFBT8e7Buak7eUMaZcsQL08OhHekAByoWhXsYUy/Im+jPy+hA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8KP2HNXkoQo0jtWwicQocmpJT/EVP2hCC5tzJCRgx8w=;
 b=h7eXXS/vCj/PWAW972V/7uk0wYJYtKampFwaEtfKG5jXkm2onNxNxIxpua80Z5INjEjlMuWTpPiN+sSKztLmTV0POPDiIPZkjj3WibywglI1jbJoNoE6T0rdxVk9IFbV0IMe1kJUmvigeFwTFOfn0gnC41kJfNJBkgA8eOUcg/6MBF18yjUQXK0QX3p4RTQxrytcaXICKoP2ScdqvkzSpcLJXD5AjUisTwZ8raQd9TINzTkkyOASu6PBztuIDDwFOdVbRY7TVG6gadeegK3cobEs6hv4IVY7snx3u4JrUYB9Fkzbvq9SBOjH2oAFPyOuPrJCJrk5V9u4h90UCP1I4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=linaro.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8KP2HNXkoQo0jtWwicQocmpJT/EVP2hCC5tzJCRgx8w=;
 b=lIDpLA4NywGDYswXujIhPZPIguXLd2YNBIwZ2fh7I9vUVh2uB8YkRxuTT18PLGNV1aGa+5YkP8UvZldAi6dj1374UOtPvJu1rGoejKlRqCwSMQVzzihGI9bKcvtZ+XA0NqeEKEfD5j3aZ9H6TGEA6HlZbChuPqbqSgLUbnUOvrtJKYlrJ32VngKcdhRwf1youJryM3Ca79MF8YJaFJD/Tz7BpXNb+nBa6pYGez/It8SyIiH/m+mt+H9h178V38nNUcZf9B5W5JgWwaWNGiS5WP+LxKcmEOhxcD1OULNsTTO5tLkn5R2aayBndORKVUtujpp5l53M0j/DYvgE7REDIw==
Received: from BL1P223CA0008.NAMP223.PROD.OUTLOOK.COM (2603:10b6:208:2c4::13)
 by CYYPR12MB8963.namprd12.prod.outlook.com (2603:10b6:930:c3::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.27; Tue, 26 Nov
 2024 18:59:09 +0000
Received: from BN1PEPF00004683.namprd03.prod.outlook.com
 (2603:10b6:208:2c4:cafe::d5) by BL1P223CA0008.outlook.office365.com
 (2603:10b6:208:2c4::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8182.19 via Frontend Transport; Tue,
 26 Nov 2024 18:59:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN1PEPF00004683.mail.protection.outlook.com (10.167.243.89) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8207.12 via Frontend Transport; Tue, 26 Nov 2024 18:59:08 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 26 Nov
 2024 10:58:48 -0800
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 26 Nov
 2024 10:58:48 -0800
Received: from build-va-bionic-20241022.nvidia.com (10.127.8.12) by
 mail.nvidia.com (10.129.68.9) with Microsoft SMTP Server id 15.2.1544.4 via
 Frontend Transport; Tue, 26 Nov 2024 10:58:44 -0800
From: Vishwaroop A <va@nvidia.com>
To: <tudor.ambarus@linaro.org>, <pratyush@kernel.org>, <mwalle@kernel.org>,
	<cmiquel.raynal@bootlin.com>, <thierry.reding@gmail.com>, <richard@nod.at>,
	<vigneshr@ti.com>, <linux-mtd@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <jonathanh@nvidia.com>,
	<kyarlagadda@nvidia.com>, <smangipudi@nvidia.com>
CC: Vishwaroop A <va@nvidia.com>
Subject: [PATCH 1/3] mtd: spi-nor: Add post-get-map-id fixup for S25FS512S/S1
Date: Tue, 26 Nov 2024 18:58:32 +0000
Message-ID: <20241126185834.1130949-2-va@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20241126185834.1130949-1-va@nvidia.com>
References: <20241126185834.1130949-1-va@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00004683:EE_|CYYPR12MB8963:EE_
X-MS-Office365-Filtering-Correlation-Id: 277c496d-0ee8-4695-11a2-08dd0e4c6846
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|82310400026|36860700013|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?McsfNMhr//XjluxzW03tq1NRl58qkqM0xhQ1mSAz50oxzv2aDjcMkrYMhHMT?=
 =?us-ascii?Q?C2NOJKKMpvJ9L0qizUGIZlsC6nr2OoyAuBx/NwN2ZPxhSDvKArR9NqgSpWoI?=
 =?us-ascii?Q?jhoCY4nsPCi3CIjsHwuC9DFlePhTam4pP8cEO5HU8bvdqauPr/uVdb/yIZn5?=
 =?us-ascii?Q?w1DC4jdeR5qljBnL3CmMn9zyXp33pl4aZhlrCOJzPwv7hm01b/+QliTfDyQr?=
 =?us-ascii?Q?gZa93r/LYVCn/novD0gOJokeQNBfoxZkqrxLD/eWX/qHU5fmycCefkLEonSB?=
 =?us-ascii?Q?Meycp7Acdl0L8b1+hijZLmrMziZxb63rp0OVa40CA4UFTDiAn8ahDHzWp00D?=
 =?us-ascii?Q?eu22eHbxNorhfurHK7j74sR17zTKeyk+zvTRJfXNzLWooI+oAa1L9s+0hmS4?=
 =?us-ascii?Q?2AfzGo9VbZmm56gOD1K7pnqIN/ga4oByVuldlNJNtggUfOubB5n7HcwQLOv5?=
 =?us-ascii?Q?94PvOfxvOziI9X8NrKDIhnDJGGSMsqbBpLeGq21cmpA7Vqj5fHceVhgcC/fk?=
 =?us-ascii?Q?KPKhgqYRYky5W71l2uL/RWtPAjmvGfr4MIY+5Iy9mHIJCllDtrCrT68gkn0e?=
 =?us-ascii?Q?jgDfmiHR4PYPkACvfE28BI9wuq4UWAqE/rvyWMvJfzZQ3zHdAQMmIs4HDs5l?=
 =?us-ascii?Q?hVltMvkuDo8twCKCl0APZVi97sXkZfkgIkTS5QPMPxOxS/54nyc44PezJjBn?=
 =?us-ascii?Q?nFUzmY2xSmJ03eVrmJ6a8DibyOWLMXV4+/+EsLlhHM4+8EPwmvsQfgoBEHQr?=
 =?us-ascii?Q?pI1OxgUj+xkget4Fk2V18yXIrLc4n1IM9mHmyUAcqCKLcQ4RRj8MsQMChlCc?=
 =?us-ascii?Q?2aHrz7XeoxK8Yf0lR2ueFGA9mI3NJb8xg6UPwqYB2Vu0S0XpyqI8sC1tb7zw?=
 =?us-ascii?Q?5EEDrty77pxjzYKot1T1r2peRI07FyN6kcm+wlEelRuRoDV7EG7oHzPFunM3?=
 =?us-ascii?Q?7T3y1R9G2kq+8QjPqX7dogcC1UFqCc5MyoYDoXpZsWXdpXWbdZbS80EVIlPt?=
 =?us-ascii?Q?YzmMWG3VPo+04nf3nbINdMS2aAWQWU9lV48GenHzQaERykibHRhfQUFni2Z+?=
 =?us-ascii?Q?aHeahBCOa+zt6RPXjtxqWI0fRAsxOyJN4lFy7J8Msj1ayareAets3uJw4mr5?=
 =?us-ascii?Q?adhzkbHqjT8f7XJ64lg6K3ZCof6RmwDEEVRTVUJ2NfAa368oY3EJp1TbjUGc?=
 =?us-ascii?Q?vyzAKM6Snds5BKJAzLRcJ5bFKU2ffW6ICchpko/Ia3VeHE/rHbXYaTqQ9RBq?=
 =?us-ascii?Q?CBEwcMdF6wCXSJjt7kk27CiatWdlijjSCKgabM5NAWxb9CbTPplmg9j4y+wD?=
 =?us-ascii?Q?83n4NfXBN3GWEBrSoULkpSbdjxMQRevK1LHLkwDqJ8144ybrebLWgJiiZfef?=
 =?us-ascii?Q?hBYF7ZRskbeCD8n1EgvUj6y6opjWj6VypezOr/NPSnfEwRRxXy75IGvco9ri?=
 =?us-ascii?Q?kbGtsPY4rBdRPxC5iUK33Z73xmUqDWbu1rxjbFuF2zH5NpkVGAJ0CA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2024 18:59:08.4173
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 277c496d-0ee8-4695-11a2-08dd0e4c6846
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00004683.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8963

The SFDP Address Map for S25FS512S / S25FS512S1 devices incorrectly
reports that the map ID is 0 when it should be 1. This issue can
cause problems when trying to erase sectors on the flash device.

Add a post-get-map-id fixup for S25FS512S / S1 flash devices. The fixup
reads the values of the CR3V and CR1V registers and determines the
map ID based on those values. The fixup also checks for invalid
combinations of CR3V and CR1V values.This fixup is necessary to
workaround an issue with the SFDP Address Map for S25FS512S flash.

Change-Id: Ide18bb4ee076cd36c57b0b52b5d49b63c3caf322
Signed-off-by: Vishwaroop A <va@nvidia.com>
---
 drivers/mtd/spi-nor/core.c     | 25 +++++++++++++++++++++
 drivers/mtd/spi-nor/core.h     |  4 ++++
 drivers/mtd/spi-nor/sfdp.c     |  7 ++++++
 drivers/mtd/spi-nor/spansion.c | 41 ++++++++++++++++++++++++++++++++++
 4 files changed, 77 insertions(+)

diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
index 66949d9f0cc5..a76202c6d252 100644
--- a/drivers/mtd/spi-nor/core.c
+++ b/drivers/mtd/spi-nor/core.c
@@ -2408,6 +2408,31 @@ int spi_nor_post_bfpt_fixups(struct spi_nor *nor,
 	return 0;
 }
 
+/**
+ * spi_nor_post_get_map_id_fixups - Apply post-processing fixups for map ID
+ * @nor: Pointer to the spi_nor structure
+ * @smpt: Pointer to the sector map parameter table
+ * @smpt_len: Length of the sector map parameter table
+ * @map_id: Pointer to store the updated map ID
+ *
+ * Return: 0 on success (including when no fixup is applied),
+ *         positive value if a new map_id is set,
+ *         negative value on error
+ */
+int spi_nor_post_get_map_id_fixups(struct spi_nor *nor, const u32 *smpt,
+				   u8 smpt_len, u8 *map_id)
+{
+	int ret;
+
+	if (nor->info->fixups && nor->info->fixups->post_get_map_id) {
+		ret = nor->info->fixups->post_get_map_id(nor, smpt, smpt_len);
+		if (ret < 0)
+			return ret;
+		*map_id = ret;
+	}
+	return 0;
+}
+
 static int spi_nor_select_read(struct spi_nor *nor,
 			       u32 shared_hwcaps)
 {
diff --git a/drivers/mtd/spi-nor/core.h b/drivers/mtd/spi-nor/core.h
index 5c33740ed7f5..37a9f43e1bf9 100644
--- a/drivers/mtd/spi-nor/core.h
+++ b/drivers/mtd/spi-nor/core.h
@@ -428,6 +428,7 @@ struct spi_nor_fixups {
 			 const struct sfdp_bfpt *bfpt);
 	int (*post_sfdp)(struct spi_nor *nor);
 	int (*late_init)(struct spi_nor *nor);
+	int (*post_get_map_id)(struct spi_nor *nor, const u32 *smpt, u8 smpt_len);
 };
 
 /**
@@ -661,6 +662,9 @@ int spi_nor_post_bfpt_fixups(struct spi_nor *nor,
 			     const struct sfdp_parameter_header *bfpt_header,
 			     const struct sfdp_bfpt *bfpt);
 
+int spi_nor_post_get_map_id_fixups(struct spi_nor *nor, const u32 *smpt,
+				   u8 smpt_len, u8 *map_id);
+
 void spi_nor_init_default_locking_ops(struct spi_nor *nor);
 void spi_nor_try_unlock_all(struct spi_nor *nor);
 void spi_nor_set_mtd_locking_ops(struct spi_nor *nor);
diff --git a/drivers/mtd/spi-nor/sfdp.c b/drivers/mtd/spi-nor/sfdp.c
index 21727f9a4ac6..87af29d2c28b 100644
--- a/drivers/mtd/spi-nor/sfdp.c
+++ b/drivers/mtd/spi-nor/sfdp.c
@@ -769,6 +769,13 @@ static const u32 *spi_nor_get_map_in_use(struct spi_nor *nor, const u32 *smpt,
 		map_id = map_id << 1 | !!(*buf & read_data_mask);
 	}
 
+	err = spi_nor_post_get_map_id_fixups(nor, smpt, smpt_len, &map_id);
+
+	if (err < 0) {
+		dev_err(nor->dev, "Error in post_get_map_id fixup: %d\n", err);
+		return ERR_PTR(err);
+	}
+
 	/*
 	 * If command descriptors are provided, they always precede map
 	 * descriptors in the table. There is no need to start the iteration
diff --git a/drivers/mtd/spi-nor/spansion.c b/drivers/mtd/spi-nor/spansion.c
index 5a88a6096ca8..2e1dd023a1aa 100644
--- a/drivers/mtd/spi-nor/spansion.c
+++ b/drivers/mtd/spi-nor/spansion.c
@@ -25,6 +25,7 @@
 #define SPINOR_REG_CYPRESS_STR1V					\
 	(SPINOR_REG_CYPRESS_VREG + SPINOR_REG_CYPRESS_STR1)
 #define SPINOR_REG_CYPRESS_CFR1			0x2
+#define SPINOR_REG_CYPRESS_CFR1V		0x00800002
 #define SPINOR_REG_CYPRESS_CFR1_QUAD_EN		BIT(1)	/* Quad Enable */
 #define SPINOR_REG_CYPRESS_CFR2			0x3
 #define SPINOR_REG_CYPRESS_CFR2V					\
@@ -33,6 +34,7 @@
 #define SPINOR_REG_CYPRESS_CFR2_MEMLAT_11_24	0xb
 #define SPINOR_REG_CYPRESS_CFR2_ADRBYT		BIT(7)
 #define SPINOR_REG_CYPRESS_CFR3			0x4
+#define SPINOR_REG_CYPRESS_CFR3V		0x00800004
 #define SPINOR_REG_CYPRESS_CFR3_PGSZ		BIT(4) /* Page size. */
 #define SPINOR_REG_CYPRESS_CFR5			0x6
 #define SPINOR_REG_CYPRESS_CFR5_BIT6		BIT(6)
@@ -754,8 +756,47 @@ s25fs_s_nor_post_bfpt_fixups(struct spi_nor *nor,
 	return 0;
 }
 
+static int s25fs_s_nor_post_get_map_id(struct spi_nor *nor, const u32 *smpt, u8 smpt_len)
+{
+	struct spi_mem_op op =
+		SPI_MEM_OP(SPI_MEM_OP_CMD(SPINOR_OP_RD_ANY_REG, 1),
+			   SPI_MEM_OP_ADDR(3, 0, 1),
+			   SPI_MEM_OP_NO_DUMMY,
+			   SPI_MEM_OP_DATA_IN(1, nor->bouncebuf, 1));
+
+	u8 reg_cr3v_val, reg_cr1v_val;
+	int ret;
+
+	/* Read CR3V value from Configuration Register 3 Volatile */
+	op.addr.val = SPINOR_REG_CYPRESS_CFR3V;
+	ret = spi_mem_exec_op(nor->spimem, &op);
+	if (ret)
+		return ret;
+	reg_cr3v_val = nor->bouncebuf[0];
+
+	/* Read CR1V value from Configuration Register 1 Volatile */
+	op.addr.val = SPINOR_REG_CYPRESS_CFR1V;
+	ret = spi_mem_exec_op(nor->spimem, &op);
+	if (ret)
+		return ret;
+	reg_cr1v_val = nor->bouncebuf[0];
+
+	/* Determine the map ID based on CR3V[3] and CR1V[2] values */
+	if (!(reg_cr3v_val & BIT(3)) && !(reg_cr1v_val & BIT(2)))
+		return 1; /* CR3V[3] = 0, CR1V[2] = 0, map id = 1 */
+
+	if (!(reg_cr3v_val & BIT(3)) && (reg_cr1v_val & BIT(2)))
+		return 3; /* CR3V[3] = 0, CR1V[2] = 1, map id = 3 */
+
+	if ((reg_cr3v_val & BIT(3)) && !(reg_cr1v_val & BIT(2)))
+		return 5; /* CR3V[3] = 1, CR1V[2] = 0, map id = 5 */
+
+	return 0;
+}
+
 static const struct spi_nor_fixups s25fs_s_nor_fixups = {
 	.post_bfpt = s25fs_s_nor_post_bfpt_fixups,
+	.post_get_map_id = s25fs_s_nor_post_get_map_id,
 };
 
 static const struct flash_info spansion_nor_parts[] = {
-- 
2.17.1


