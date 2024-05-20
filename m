Return-Path: <linux-kernel+bounces-183703-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11F2B8C9CC6
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 13:57:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC475281C71
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 11:57:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C94995578A;
	Mon, 20 May 2024 11:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="bEa8RxFT"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2069.outbound.protection.outlook.com [40.107.237.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7C55548EC;
	Mon, 20 May 2024 11:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716206224; cv=fail; b=F7LG+0Cgf/UhThjA19HawyQBoiG1XqnLk7SIf/U+/CbX6R1hn14mR+M1BYIVzOZ3SbJ+0Mf0NrnzkOhUSUWkdyDYEOxPITGH0K9oO0GTw/asjfKI7d9t2lpwAKKqCfo8w3d1drCPCX6nfgcbwbzQXRI2NlveiHWvqYpPjkm3DMg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716206224; c=relaxed/simple;
	bh=aYSUZfhA72SyOQKsZXyMWyiNDtSadMWs15VX4HBM4QQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CU5NW+PkfEEHO5nYmoyIhp56tXzW/yLDk7W7aWP6YsH5loK5vu8A2RMUtZUM8KrrFPk8SXQHVRU9v2f873M9uK1UEYqSUVzV/J0Ttjzsinjfm6o8oR+U4yBQIcSuPsvSWAOFuHT4wNYt9cEDqkH4KjVOvn5Z/s0I9DfmZE1bnS8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=bEa8RxFT; arc=fail smtp.client-ip=40.107.237.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gNiKVJojEE0shhsU1qVo+X7sWQQwr1hZcBfNr7HgQVtp+XLdT1aJitY7oIX/QZtQoZftYiIJm4FQOEsRVpg+T72Lm46iQbZsAPw0P8gnnaVag7RXqhb22JRc3KXkhXPfXnGBZnPAORqNm5Xyuy1Qfm1Kxxi577nGXm8rpgmY0/Y5/18tv6Mq7sNzWniPGOUC3eNC+JmZYTWk19xP5v5SNdXoT7fWglL7eN03+3qC48xiCItawaDWYoOawUqNQVkmv+bwoiNo9H7Z1F8tlXJY1eKEm5ZwocvO46XT+DF0GTMXONrljNrKHGvUV+9njrVjUxx51LqZcNQACvsT+eHvEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yl0n7QsT9YnrQ1Cfhcglm5itVaGQMpNsx25HsUjDrEY=;
 b=cfCKRM9l+Q2RAiTHc1ESBssjFpuT3f6unHhaRck/ceCwIYOMkh3SN1kBciSGoTQ/FtqdoJ7O3hmjBlTCRbxMnXpiuDRBEzixv1VBMshXVkLPLvYt1hsPhcHHONcuE2/Ex3cDN4EkvzK2P45miBK/j/8SEhfMb8ytWrE/ifCDbrnuHH9pBZwJ9rT/7h5NqmqY1o9yNQ7ziMsS5YjA39mfp4ht6ILZUd3tg9rgdWO9XTS7y+epPzRqdaa29IwSW09RTY07JUHcLsY9Nfr2kLQE/3r9aFuISKnFo6SH1JpZGaqc4VK5d2hVA4fD95AN2H0X7JklA1O5CT86VKwV+8v/BA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yl0n7QsT9YnrQ1Cfhcglm5itVaGQMpNsx25HsUjDrEY=;
 b=bEa8RxFTTuzeuFvOEVzs3RnDqaLY0MkxXocj0pUCqMjAVnwJfRfoDDvJwIneyJFEzowQxR4bwyuiLeb42WUJVS5Vz3HzWNUKz7zJmP2HNHV+sYqv7E9ytlkt3XUW7lAo9/rBtX8AKdyZ+tesDusXwctiTczc30og/g+XUZ5/9pMabrHTw/KguMmbek3A64/9sDVTPqvCevirFw4YEGaLPPQaFPpILh8E6OVt/GjMCJRggG7cINoYw49MVqDyD8X2iTpyvszOWTxm1/5es+oVLTIfmQ7A8zQWuB4jPfA0iakBx6cgh+z7YxaXSmkExu/AngvjgzZfRT1ht+R/khGkLg==
Received: from BN9PR03CA0913.namprd03.prod.outlook.com (2603:10b6:408:107::18)
 by DS0PR12MB7971.namprd12.prod.outlook.com (2603:10b6:8:14e::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.36; Mon, 20 May
 2024 11:56:59 +0000
Received: from BN1PEPF00004683.namprd03.prod.outlook.com
 (2603:10b6:408:107:cafe::5c) by BN9PR03CA0913.outlook.office365.com
 (2603:10b6:408:107::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.35 via Frontend
 Transport; Mon, 20 May 2024 11:56:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN1PEPF00004683.mail.protection.outlook.com (10.167.243.89) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7611.14 via Frontend Transport; Mon, 20 May 2024 11:56:59 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 20 May
 2024 04:56:47 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 20 May
 2024 04:56:47 -0700
Received: from vdi.nvidia.com (10.127.8.14) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server id 15.2.1544.4 via Frontend Transport; Mon, 20 May
 2024 04:56:46 -0700
From: Shravan Kumar Ramani <shravankr@nvidia.com>
To: Hans de Goede <hdegoede@redhat.com>, Ilpo Jarvinen
	<ilpo.jarvinen@linux.intel.com>, Vadim Pasternak <vadimp@nvidia.com>, "David
 Thompson" <davthompson@nvidia.com>
CC: Shravan Kumar Ramani <shravankr@nvidia.com>,
	<platform-driver-x86@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 2/4] platform/mellanox: mlxbf-pmc: Add support for 64-bit counters and cycle count
Date: Mon, 20 May 2024 07:56:34 -0400
Message-ID: <ce077a0db5d4afdbcc63a635fece9793aaae055f.1716205838.git.shravankr@nvidia.com>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <cover.1716205838.git.shravankr@nvidia.com>
References: <cover.1716205838.git.shravankr@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN1PEPF00004683:EE_|DS0PR12MB7971:EE_
X-MS-Office365-Filtering-Correlation-Id: 82ace5e2-065d-4709-9f0f-08dc78c3f464
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|82310400017|376005|36860700004|1800799015;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?n4WPvjxYWLPvgu7OkdIJ/Y3LbQXXj+ZlTKdxaKsuGnXXtfdoNquYwdNviabT?=
 =?us-ascii?Q?veDkf6lYvhetG/omFdXbXfcsZtVBJqty+51SU+warzxoAWXn5UNcmVUaE0f9?=
 =?us-ascii?Q?UT3+CDyVludkbwN7qNOHNUV8Rv/yxLCZckLUTaqiuKJUkz7vjGit4mp+A8eN?=
 =?us-ascii?Q?ZN+jj4iEbBgBc2efQl/TjPAHn/koQYTV/j/zio6PKhr571ptOJhrAnAXdLpk?=
 =?us-ascii?Q?lzW5vQNf/irUmrbHj8PcqZZKS1t63yx85bvlBCaHZH2M9j/4xP2BYJHAK9/4?=
 =?us-ascii?Q?zzqcnL5uoMW6vN3f9OFpdmoH2o3HabE7jJXQCU9a85H7jUux6vnaWzdl1TeS?=
 =?us-ascii?Q?c6kppS4/ermD53sprhVafPSxh+ncbIRYoj7B/wJ+VBoLdcXQeoPF+EXViExg?=
 =?us-ascii?Q?oirNFWwzuF206RVcHEGWQjlXsMsJCuy3sBqcgqDStilBf8oFyXlyd3jJtgry?=
 =?us-ascii?Q?tcdsizlSpLf3nC1TBAe43RiesWUXoigvuYKN0zx44Q5yQXyVBvIyPNHtmIrY?=
 =?us-ascii?Q?37fgM+eWQILactseZLadn6B301tZw2Z5udOwGGyeUrPSn/Kfq3yYkX1rwIzr?=
 =?us-ascii?Q?sogKPLp9HN5U6NiEJ6blj3dRj5R7EV4lUdN1aJChxHSOGJtDkcvIs/7yszpO?=
 =?us-ascii?Q?D6qX35+jKQLIccCQRRfBgDk5w++HlNBudCka/SEr7DFUmACZoDsW2W0RsWqK?=
 =?us-ascii?Q?Rq+SS6huJa73ZHedYQ3O2gWNkbWRAmVWWx+F0U2et/Wn7c5YlNPxgSGRS9WR?=
 =?us-ascii?Q?O2HSK7M+RuKl7ADG/1Y/CzCQclovTcggYwAWWx7f0fYxDlvxuBSjW/VaCFIH?=
 =?us-ascii?Q?wSH27Vza6T2n3uMGiB3S3hkSHLEptav8LSNtINZO3nqi2AdsenuFa1vOI4EC?=
 =?us-ascii?Q?xxKtv0mQlKTbtu8Bn3gEMEIWE3zNjabaHjm8ER9rArD3nqRxYODnj8NPKC4o?=
 =?us-ascii?Q?sfYqgKf+qOs6nQGvEN4I8Fi/e+cuoZjsrUJVPbS22mbygp6AKsigvIFs29qc?=
 =?us-ascii?Q?DoD0GW1+52PNNlQ+Mdu84O6H55rva6f94FiGF9dnv4Q8wu+i66MMRcjli47A?=
 =?us-ascii?Q?cymfu4of0kxcV3LCTurp54mMKgAbl9xQXjrHhP71EYQdRQS/9BQMjpg65+VX?=
 =?us-ascii?Q?nc9/2wdVe3NZaAJLd3Is2h1m6tLYXi8MkslFsKtcygF6wEZyqf+jvcDfJTyt?=
 =?us-ascii?Q?DcquTNktcg4AwC6SovoCrzMgej9NzYnE/GLYo0CybL2WWPwCTAI1s0aDKM4i?=
 =?us-ascii?Q?5FORZ3DtpgpAgMs/73WjePEDtBGuWNle8AC8m1sWKmHe++bpS+bj3vHgQJ6V?=
 =?us-ascii?Q?ZED2SLx/KhB4J7plav/iuahn4Zxb7iVEpEC7dtlc1lDCOULqXaLKPu87xU2v?=
 =?us-ascii?Q?Hz3p6ry0hIRkn7I1iE43ijo0EHhh?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(82310400017)(376005)(36860700004)(1800799015);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2024 11:56:59.1771
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 82ace5e2-065d-4709-9f0f-08dc78c3f464
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00004683.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7971

Add support for programming any counter to monitor the cycle count.
Since counting of cycles using 32-bit ocunters would result in frequent
wraparounds, add the ability to combine 2 adjacent 32-bit counters to
form 1 64-bit counter.
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


