Return-Path: <linux-kernel+bounces-205813-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 724C99000A7
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 12:22:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F06BD1F24AB4
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 10:22:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25AC415E5A8;
	Fri,  7 Jun 2024 10:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="qAPh+2K0"
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2083.outbound.protection.outlook.com [40.107.92.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F154515E5BA;
	Fri,  7 Jun 2024 10:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717755704; cv=fail; b=UDVoshxg2wD9/kkEYqL0s87iuDXZNlFwIcLEno/Ow9xyrlxL0dVH5UnVp8ms5EvYFPw88e/dUwotOq0MQdj8wnFu3x5mrT0Fo97qgCckXsPQ8SJ1Dsy9jhqqYc/OpFVjM4FtK9OdfP9t+uBMrmloOJdd0bbGlC1Z/wm54RCDmfs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717755704; c=relaxed/simple;
	bh=FecWP5RUxvyJTVmjC2irhE5goHaYL7TxPSHQLNnlBrk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QGB7v+BshzP5dCTyusz7Okvx66z8K4FXLewA0GfzAAqT1HSl4XNw7jXq8Ri7H+QtfKo+/BjCqRdrgot90IszskbKczXxqrbI7RWStXvQHLtFWFZ4VHr/Ueu5HBW5B2zxx5w07CB+a90UrGEa9woRCEDzEnLrRN5rUN2pd9Buq1s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=qAPh+2K0; arc=fail smtp.client-ip=40.107.92.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g5yCWOiYRAXgbjhG2Z7hWhgF/tS7GQkCeO7cQZXcWyxcqtQEALyeJdT3CRcEtlbYod3hgYf1AOMABSPCxGVfAzREKIAumPzvXP4WIrtGXqNOwTHKjbvThUFL0YTqsB5rF79ZYrZ0UuIuFwKleO1kTpTA0JUfER983BO/p3Lubg5vSYOnIKwARXPpL585xgWj+61+wGplASsv+xppi8ErpgE9DwmapfST84GGRcB9N6zOirthm8YLogs3MNOXJyyECqUKPkBryR7S07zdyq7pehLOjETXzcRhm6+kE1afGvP02ehS01/gW3AU5SJ5l7I/y3oPNMirYle4FIVzzA9Y4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+vWifZaKks5NNiQvGDKLxRTtvi+9SIPMiKPts1PugAY=;
 b=iQEneBb2D59RRNz62VC4GQkRTiuzDNjpKOZP+YEjlB1fNX4fcIGfdj2aL9wzJERQzj2frvY+pW6NwZ5PySOp64ykpkF9Io9j+dfNwQf2JxWw0TixMLR29UGBchcJbNAQI2Bu11PE4059z8gsaFnHzWBfuGn6JeipnPwXRfkwh40gPdBdSmMdc9ZCeZWU0Ycz7/jx28mJN363Ct63uBM+0rbjTSUq3TQsnjJoOHTGXCgWAHDhg9dUGronuQgMTgVdcIo0b/fv1vouYwz8HAVrvIgHR2avluq8ssANE6J5+amscHrs4orVo/A782SB3/L+CTrCtQt0J/h10eugH1Emjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+vWifZaKks5NNiQvGDKLxRTtvi+9SIPMiKPts1PugAY=;
 b=qAPh+2K0nm4CXY2XUlnllNu8/L+hCuyxtaxEbdbddD7k2K7ntKKmk8ei3Z8ZzhgY/7RTHGqgs0r8CCaNvj/2R6qufh9i4WqZfixQ4poNNfiEVxSzoGVoSFTthtF3472/JUkz2O5hLA/EQ5uhtkB9ZYAJKPb2o9nslGrsD2DhKXwCeKftIOCig29KHc9z9Q88srZCcUsVeg5o+MS4x30HR8+hF3Pyl0Iw9q9Wd8H0FQg9+7+23DNGUZDlIjE9XDmIfHGwQCzf5WOibApgwDBIY5aMc0K1I1hGEda0/AFOeMZLn7SPoIU5rrKx/et9xb5MIQljAwFvG6mqOatTx04Ecw==
Received: from BYAPR01CA0010.prod.exchangelabs.com (2603:10b6:a02:80::23) by
 DM4PR12MB6160.namprd12.prod.outlook.com (2603:10b6:8:a7::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7633.21; Fri, 7 Jun 2024 10:21:37 +0000
Received: from SJ1PEPF00002312.namprd03.prod.outlook.com
 (2603:10b6:a02:80:cafe::85) by BYAPR01CA0010.outlook.office365.com
 (2603:10b6:a02:80::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7656.20 via Frontend
 Transport; Fri, 7 Jun 2024 10:21:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ1PEPF00002312.mail.protection.outlook.com (10.167.242.166) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7633.15 via Frontend Transport; Fri, 7 Jun 2024 10:21:37 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 7 Jun 2024
 03:21:23 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 7 Jun 2024
 03:21:22 -0700
Received: from vdi.nvidia.com (10.127.8.14) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server id 15.2.1544.4 via Frontend Transport; Fri, 7 Jun
 2024 03:21:21 -0700
From: Shravan Kumar Ramani <shravankr@nvidia.com>
To: Hans de Goede <hdegoede@redhat.com>, Ilpo Jarvinen
	<ilpo.jarvinen@linux.intel.com>, Vadim Pasternak <vadimp@nvidia.com>, "David
 Thompson" <davthompson@nvidia.com>
CC: Shravan Kumar Ramani <shravankr@nvidia.com>,
	<platform-driver-x86@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 2/4] platform/mellanox: mlxbf-pmc: Add support for 64-bit counters and cycle count
Date: Fri, 7 Jun 2024 06:21:12 -0400
Message-ID: <b51dfa74fad5eea969f70fe921ae739eab2f4957.1717755404.git.shravankr@nvidia.com>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <cover.1717755404.git.shravankr@nvidia.com>
References: <cover.1717755404.git.shravankr@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002312:EE_|DM4PR12MB6160:EE_
X-MS-Office365-Filtering-Correlation-Id: 8575d039-77fa-4238-250e-08dc86db9d1e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|376005|82310400017|1800799015|36860700004;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?3whbo17LIvkeeVA3xyR2lbFie5662f2HBLwqlC65popVs3KwOB1yGysQX1E+?=
 =?us-ascii?Q?iEIQ1e86i+NcsZt8FnE/Bsl7Ryqe7iTddeTSg5rMLQmFRWLhQW7yxQjMLQXU?=
 =?us-ascii?Q?EKkQRpzKdOBdlSdVfVW5GPOPKVdUmOjACoc9uepkFLtrlnyDwIjFyqTw6U69?=
 =?us-ascii?Q?99HztEm5QKmWs3FBhMDE8mZekK8OoOMueD6DIIVCvJ8Xu7706EhnDsflJjkP?=
 =?us-ascii?Q?5rEkQEhkFVZqmL0GqofnetAuU7xbpCaYgleil2upv/lOhbM7MJ2dLrKqtLCz?=
 =?us-ascii?Q?ZJpPccbABr39QMri5fOenyoMe44Xul7Z6iNpBTSPe5tcqyL249lwSYri2BLY?=
 =?us-ascii?Q?5JXKySpokCVt2GLQV/hlqmTwaju4/CZ2sZSGtD4F5EcXUHgvj+6QOPRrqq75?=
 =?us-ascii?Q?gPUS0LmMGp+aiU7R+di178y17U/ZB9WIzveY/Tgyn6L6HobJLoQ/n/O5FpiU?=
 =?us-ascii?Q?RthQ/Cx4sFYpo9k4vRlC64Q0TlDYOLNH1LJ/VWllhouU1jLKdvgENfb3e5wl?=
 =?us-ascii?Q?2myN8B9laGq6YZAS4rM96/cZCYNDq3jwIl7p9C59xEsfo/nmamYXwSBmGfVv?=
 =?us-ascii?Q?gHOBHFdrs9cluqM4hfISGqvvmDYw6U3N0pya8n48EI23Zv6VI7EKjj5wXArP?=
 =?us-ascii?Q?tbxhCRa0Pwpns7zGTWmFv41TMkC28feSrgog83Lvpag2GP8l8SVPD2j5C9W0?=
 =?us-ascii?Q?eKsnWV0GmlBMReRGVxHCQaabo/SXPWWu9Yuym5qlLSOVyoYhQMoPQiEXf/vM?=
 =?us-ascii?Q?gAJ9N0Xipr/aMMds42ruhGxFvED3euLvnVNfz8LYumLflZQIGsc8sqX5Y2+o?=
 =?us-ascii?Q?LBqXQrsCriKYE/dzozSf9JP5QTtyFittXQ7KCaVuDSl6CDtGii3pw2GG1sue?=
 =?us-ascii?Q?d5FiAz9SGd1INXltpFBETbHZ2tVlYpVCMXuvIbcUKqKWJSgc93GjSHUOXo/o?=
 =?us-ascii?Q?XXjUt6sxLeQs8u5Xd2qzUB8O1AQ0TZXWd3cjqU2Cx9gXg9IvWXD1QwoJ5yX8?=
 =?us-ascii?Q?99j88hVuz+Bhx10caW5Up2DaRGKNMcboNiMw/CzMoc00N8c0BmPSAxQzCbLw?=
 =?us-ascii?Q?6Brlhq/DCJ6+8bvCc1mfFmlJxITjqil5o77i+FBIVGpTlcA5YKLvmODtA53M?=
 =?us-ascii?Q?fdxTt97NDmuXvqI93HJFjxNuR7obEmhyl0cpUGVYNH6cJJIbEw9IZ7mz/XUr?=
 =?us-ascii?Q?YZcKVmiEwlO9Uh0xGZgREfvY3k0VBMaaeBVb+f1tkCNJ7djv6AcZYDVekm52?=
 =?us-ascii?Q?bw22FlhJd0zJGmxDZy1gh5o3lqLfd3/1DQFux8CR4En4bKW6aai1eYVVL0wd?=
 =?us-ascii?Q?jP2gCU0oETheIe/GXnZAy8/NV88F5kVYMTzJFP2YRQYS8Cu64yNscpgtL90A?=
 =?us-ascii?Q?1XPXVZXe4bVNOlixV6QfoDvv5A3NMbEkvjFvGyCBVoLUnGGD/g=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(376005)(82310400017)(1800799015)(36860700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2024 10:21:37.1413
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8575d039-77fa-4238-250e-08dc86db9d1e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002312.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6160

Add support for programming any counter to monitor the cycle count.
This will allow the user to repurpose and dedicate any of the counters
in the block to counting cycles.
Since counting of cycles using 32-bit counters would result in frequent
wraparounds, add the ability to combine 2 adjacent 32-bit counters to
form 1 64-bit counter. The 64-bit value can be read via the same 2
counter sysfs  which will each hold the lower and upper 32 bits.
Both these features are supported by BlueField-3 PMC hardware, hence
the required bit-fields are exposed by the driver via sysfs to allow
the user to configure as needed.

Signed-off-by: Shravan Kumar Ramani <shravankr@nvidia.com>
Reviewed-by: David Thompson <davthompson@nvidia.com>
Reviewed-by: Vadim Pasternak <vadimp@nvidia.com>
---
 drivers/platform/mellanox/mlxbf-pmc.c | 134 ++++++++++++++++++++++++++
 1 file changed, 134 insertions(+)

diff --git a/drivers/platform/mellanox/mlxbf-pmc.c b/drivers/platform/mellanox/mlxbf-pmc.c
index 4ed9c7fd2b62..635ecc3b3845 100644
--- a/drivers/platform/mellanox/mlxbf-pmc.c
+++ b/drivers/platform/mellanox/mlxbf-pmc.c
@@ -88,6 +88,8 @@
 #define MLXBF_PMC_CRSPACE_PERFMON_CTL(n) (n * MLXBF_PMC_CRSPACE_PERFMON_REG0_SZ)
 #define MLXBF_PMC_CRSPACE_PERFMON_EN BIT(30)
 #define MLXBF_PMC_CRSPACE_PERFMON_CLR BIT(28)
+#define MLXBF_PMC_CRSPACE_PERFMON_UOC GENMASK(15, 0)
+#define MLXBF_PMC_CRSPACE_PERFMON_COUNT_CLOCK(n) (MLXBF_PMC_CRSPACE_PERFMON_CTL(n) + 0x4)
 #define MLXBF_PMC_CRSPACE_PERFMON_VAL0(n) (MLXBF_PMC_CRSPACE_PERFMON_CTL(n) + 0xc)
 
 /**
@@ -114,6 +116,8 @@ struct mlxbf_pmc_attribute {
  * @attr_event: Attributes for "event" sysfs files
  * @attr_event_list: Attributes for "event_list" sysfs files
  * @attr_enable: Attributes for "enable" sysfs files
+ * @attr_use_odd_counter: Attributes for "use_odd_counter" sysfs files
+ * @attr_count_clock: Attributes for "count_clock" sysfs files
  * @block_attr: All attributes needed for the block
  * @block_attr_grp: Attribute group for the block
  */
@@ -126,6 +130,8 @@ struct mlxbf_pmc_block_info {
 	struct mlxbf_pmc_attribute *attr_event;
 	struct mlxbf_pmc_attribute attr_event_list;
 	struct mlxbf_pmc_attribute attr_enable;
+	struct mlxbf_pmc_attribute attr_use_odd_counter;
+	struct mlxbf_pmc_attribute attr_count_clock;
 	struct attribute *block_attr[MLXBF_PMC_MAX_ATTRS];
 	struct attribute_group block_attr_grp;
 };
@@ -1763,6 +1769,103 @@ static ssize_t mlxbf_pmc_enable_store(struct device *dev,
 	return count;
 }
 
+/* Show function for "use_odd_counter" sysfs files - only for crspace */
+static ssize_t mlxbf_pmc_use_odd_counter_show(struct device *dev,
+					      struct device_attribute *attr, char *buf)
+{
+	struct mlxbf_pmc_attribute *attr_use_odd_counter = container_of(
+		attr, struct mlxbf_pmc_attribute, dev_attr);
+	unsigned int blk_num;
+	u32 value, reg;
+
+	blk_num = attr_use_odd_counter->nr;
+
+	if (mlxbf_pmc_readl(pmc->block[blk_num].mmio_base +
+			MLXBF_PMC_CRSPACE_PERFMON_CTL(pmc->block[blk_num].counters),
+			&reg))
+		return -EINVAL;
+
+	value = FIELD_GET(MLXBF_PMC_CRSPACE_PERFMON_UOC, reg);
+
+	return sysfs_emit(buf, "%u\n", value);
+}
+
+/* Store function for "use_odd_counter" sysfs files - only for crspace */
+static ssize_t mlxbf_pmc_use_odd_counter_store(struct device *dev,
+					       struct device_attribute *attr,
+					       const char *buf, size_t count)
+{
+	struct mlxbf_pmc_attribute *attr_use_odd_counter = container_of(
+		attr, struct mlxbf_pmc_attribute, dev_attr);
+	unsigned int blk_num;
+	u32 uoc, reg;
+	int err;
+
+	blk_num = attr_use_odd_counter->nr;
+
+	err = kstrtouint(buf, 0, &uoc);
+	if (err < 0)
+		return err;
+
+	err = mlxbf_pmc_readl(pmc->block[blk_num].mmio_base +
+		MLXBF_PMC_CRSPACE_PERFMON_CTL(pmc->block[blk_num].counters),
+		&reg);
+	if (err)
+		return -EINVAL;
+
+	reg &= ~MLXBF_PMC_CRSPACE_PERFMON_UOC;
+	reg |= FIELD_PREP(MLXBF_PMC_CRSPACE_PERFMON_UOC, uoc);
+
+	mlxbf_pmc_write(pmc->block[blk_num].mmio_base +
+		MLXBF_PMC_CRSPACE_PERFMON_CTL(pmc->block[blk_num].counters),
+		MLXBF_PMC_WRITE_REG_32, reg);
+
+	return count;
+}
+
+/* Show function for "count_clock" sysfs files - only for crspace */
+static ssize_t mlxbf_pmc_count_clock_show(struct device *dev,
+					  struct device_attribute *attr, char *buf)
+{
+	struct mlxbf_pmc_attribute *attr_count_clock = container_of(
+		attr, struct mlxbf_pmc_attribute, dev_attr);
+	unsigned int blk_num;
+	u32 reg;
+
+	blk_num = attr_count_clock->nr;
+
+	if (mlxbf_pmc_readl(pmc->block[blk_num].mmio_base +
+			MLXBF_PMC_CRSPACE_PERFMON_COUNT_CLOCK(pmc->block[blk_num].counters),
+			&reg))
+		return -EINVAL;
+
+	return sysfs_emit(buf, "%u\n", reg);
+}
+
+/* Store function for "count_clock" sysfs files - only for crspace */
+static ssize_t mlxbf_pmc_count_clock_store(struct device *dev,
+					   struct device_attribute *attr,
+					   const char *buf, size_t count)
+{
+	struct mlxbf_pmc_attribute *attr_count_clock = container_of(
+		attr, struct mlxbf_pmc_attribute, dev_attr);
+	unsigned int blk_num;
+	u32 reg;
+	int err;
+
+	blk_num = attr_count_clock->nr;
+
+	err = kstrtouint(buf, 0, &reg);
+	if (err < 0)
+		return err;
+
+	mlxbf_pmc_write(pmc->block[blk_num].mmio_base +
+		MLXBF_PMC_CRSPACE_PERFMON_COUNT_CLOCK(pmc->block[blk_num].counters),
+		MLXBF_PMC_WRITE_REG_32, reg);
+
+	return count;
+}
+
 /* Populate attributes for blocks with counters to monitor performance */
 static int mlxbf_pmc_init_perftype_counter(struct device *dev, unsigned int blk_num)
 {
@@ -1799,6 +1902,37 @@ static int mlxbf_pmc_init_perftype_counter(struct device *dev, unsigned int blk_
 		attr = NULL;
 	}
 
+	if (pmc->block[blk_num].type == MLXBF_PMC_TYPE_CRSPACE) {
+		/*
+		 * Couple adjacent odd and even 32-bit counters to form 64-bit counters
+		 * using "use_odd_counter" sysfs which has one bit per even counter.
+		 */
+		attr = &pmc->block[blk_num].attr_use_odd_counter;
+		attr->dev_attr.attr.mode = 0644;
+		attr->dev_attr.show = mlxbf_pmc_use_odd_counter_show;
+		attr->dev_attr.store = mlxbf_pmc_use_odd_counter_store;
+		attr->nr = blk_num;
+		attr->dev_attr.attr.name = devm_kasprintf(dev, GFP_KERNEL,
+							  "use_odd_counter");
+		if (!attr->dev_attr.attr.name)
+			return -ENOMEM;
+		pmc->block[blk_num].block_attr[++i] = &attr->dev_attr.attr;
+		attr = NULL;
+
+		/* Program crspace counters to count clock cycles using "count_clock" sysfs */
+		attr = &pmc->block[blk_num].attr_count_clock;
+		attr->dev_attr.attr.mode = 0644;
+		attr->dev_attr.show = mlxbf_pmc_count_clock_show;
+		attr->dev_attr.store = mlxbf_pmc_count_clock_store;
+		attr->nr = blk_num;
+		attr->dev_attr.attr.name = devm_kasprintf(dev, GFP_KERNEL,
+							  "count_clock");
+		if (!attr->dev_attr.attr.name)
+			return -ENOMEM;
+		pmc->block[blk_num].block_attr[++i] = &attr->dev_attr.attr;
+		attr = NULL;
+	}
+
 	pmc->block[blk_num].attr_counter = devm_kcalloc(
 		dev, pmc->block[blk_num].counters,
 		sizeof(struct mlxbf_pmc_attribute), GFP_KERNEL);
-- 
2.30.1


