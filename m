Return-Path: <linux-kernel+bounces-333983-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CECF97D102
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2024 07:54:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 601AC1C204AB
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2024 05:54:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C84D2B2D7;
	Fri, 20 Sep 2024 05:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="1GDsyHZb"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2042.outbound.protection.outlook.com [40.107.244.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17662EBE
	for <linux-kernel@vger.kernel.org>; Fri, 20 Sep 2024 05:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726811656; cv=fail; b=DvcHjqCj4mgI9EY/0g/2CnQAU47cIx9cL2b8af3ZIMIFR2iY5y8zKp7p1s3PPX5mXWPdeBogGZULC+1Q8aRbEW5kILxFAe7H9kyijs4VhQs/PtdQ/QHhZIumFt/6/OyT/Onxbljfc4zap12/6CNSCR5aJx2LiIjczex/gmaXOKY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726811656; c=relaxed/simple;
	bh=rMY8wkpHiSRcy5U/L+Tw7IxyxC23NHE4aGeq0ympi68=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=l1GzKGM4Srg5k9VuX3NvFdUD9xtIXUWXPXRTjeOLLJPz9wsImU2d/2/CQW21AGBCs/nSsm7q3RqiAZ90WrhkwRgXnUn7XhPbLZoNVxzgaGrSmw6z5EhLpsilV9vOkdYQ2qDNKf/O1Jm3s/6boejWjC8Zy+l7DrEFveeb7WsQl0k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=1GDsyHZb; arc=fail smtp.client-ip=40.107.244.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IS9lemMaaFdZD+JSyENk5et5ks3dH6FXYPDO0KBFz1E7TilwI/l0GgZKfZ5qGKHunk4nbwnLU4mJIc05g1/pvMBbUmG3jFvKhWn3CYnbJW02p2BFoOyD7SunE4cPGUfb5A3seXldyFQ+3/FBrogriuOFDfbD+VEGX7oxCpAQV0WNzLe7jd3jaLtb2CkqQs8xea9KwaXop0TnLq1q5rgeZvZxfMpEWe+s3QrTv26hRDl1FX99zGPcqviYPCn3Z4asHMAaL5HX03QjdatdYtfuFzblcdLm295hHKqeVhT+N7/k3BO+o2dE9LpEIuOmP3FPwfKqdSnz1mYl0z6FbYEBqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nlXS9fviuLiUQ9FZhH6T8KRixKRvCOYtkcKZEZ1IlDk=;
 b=WcNLmTf0LY1z893Hrm8c3Ybn8pOrmNEcytnfPqRMsmwwxCkO1TXwZf4Vo0PlBZ/NhBiykP8Cg3IoGy2z2HM58BVATSWqMyhOZv4JI4PEPZzFh9xOVLvgDgwqRBnKGEtIqdNJe+HoVOYZidmrTXu4fkn12q8crHFJvktZX1EgbNZ2sn+4tjcT3HtQgYQC6Wg9mj+DGLUkXCNbcks/822KLBK9dYGR0/dLHu5aJn1LKIJ76M3ex9aa23+96Tn67K5tdjQai4M+gu5+H/sICRNqGE4lM/jvpdIv6ctFKiUWnPZr31ogm7yNL4sQTw7vZhBTomvl+1ykTLIhvJgNWT/9dQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nlXS9fviuLiUQ9FZhH6T8KRixKRvCOYtkcKZEZ1IlDk=;
 b=1GDsyHZb8KdLGlHpx5Aal/3Z2EEhU0WBBfi6uXx8RR2ahGzZhPpKkykbfDM00LIr1ebOj/j6js19nYcMigbsImqV1hPiV8r0J/z/bud4XBMmu52RtGEK6q0t2tVyxSORaFHdGc1s4pkRce6a1wAORRaExVROovDFfWRAxsW/K4E=
Received: from PH7P220CA0164.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:33b::7)
 by SJ2PR12MB8781.namprd12.prod.outlook.com (2603:10b6:a03:4d0::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.22; Fri, 20 Sep
 2024 05:54:12 +0000
Received: from MWH0EPF000A6734.namprd04.prod.outlook.com
 (2603:10b6:510:33b:cafe::12) by PH7P220CA0164.outlook.office365.com
 (2603:10b6:510:33b::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.26 via Frontend
 Transport; Fri, 20 Sep 2024 05:54:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000A6734.mail.protection.outlook.com (10.167.249.26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Fri, 20 Sep 2024 05:54:11 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 20 Sep
 2024 00:54:10 -0500
Received: from xsjwillw50.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Fri, 20 Sep 2024 00:54:10 -0500
From: Ronak Jain <ronak.jain@amd.com>
To: <michal.simek@amd.com>
CC: <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] firmware: xilinx: add a warning print for unsupported feature
Date: Thu, 19 Sep 2024 22:54:10 -0700
Message-ID: <20240920055410.2658465-1-ronak.jain@amd.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: ronak.jain@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000A6734:EE_|SJ2PR12MB8781:EE_
X-MS-Office365-Filtering-Correlation-Id: 1f02f858-4114-4991-61ca-08dcd938a6b0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?FgE751C2yDp0z+D7sNfiLxDNqh7bk7vWz93g3AOqhwaqv+Cr5PqCE3++syav?=
 =?us-ascii?Q?kNFHyFD2gRmol/bq3MzNlo4WdikQJbSvAseSytrrf77Ssv7h7VnKdTn9hbou?=
 =?us-ascii?Q?U2qSjqgrWjIREdrhDmIoNsjTdXOch8vntlatls5vjM7f0L3dqywBE1cxqLBl?=
 =?us-ascii?Q?L1UjNqv3rTD25DPIIOB55S05WV2pfZuVlReiq7GBK7uq/tBvZx039hkXZwyV?=
 =?us-ascii?Q?zvECJH0/obI7/pf7n8v9IZs9amVTXa6jpst54Csr2mkTTGl1bFI3gEO0V81v?=
 =?us-ascii?Q?AvUHOBsjZ1Ecrf/21+Tt0JHL4YhbdW8ypPjPwGk01T2d1EpvuiCVDUkqo9Wi?=
 =?us-ascii?Q?OGV85mrL9PkOvLkXaVwqK9iYck866EeGhI8Slly+WYmKAgeYseFnYG7Us2xs?=
 =?us-ascii?Q?tgTjI9nb1fbZeNdHtW/z3OQZGQqK6FAsgtEUwMP+ghJijAsb8H8piCM8kdmi?=
 =?us-ascii?Q?PynxFCewsOmMosUp7bjHgE6yFS8Mq3fmRHcwOneT7nSpMOHJ4/aFBN1dX1Sl?=
 =?us-ascii?Q?XIf/lbZ6YFz2BqMVYX+vOrAhXANxXB9gHjk+lIpGcRc10TUAb66EKHi1DtVv?=
 =?us-ascii?Q?3ccT4EuMwmZwK6Ahue3vSn58hyXs2u+QUAc4GjwtMsfxJ9Oe8ajp7n3qt3KR?=
 =?us-ascii?Q?vW5g5L0WC5scsRLFdhI6dPas5WF2lrlIlXPFj0aq/K7zIPYoxCmAyZ7SLG4h?=
 =?us-ascii?Q?qlpCeoNyf7a9Xj/62FRuaeY2Yq28CaZn4kYh3GY2COlcLW2pQk99s71uvKnr?=
 =?us-ascii?Q?57UW9njaAsB0SMg8lU7ngJD/+1zO8HU0nelac6ickeL39uNhSzPsmrQngr68?=
 =?us-ascii?Q?8FSa37JcA8mUhV99RhVk5O7amu9MPp7/9lhkqv57JlbzE5ELqtO+iFMGWJHd?=
 =?us-ascii?Q?Rk8iUF2O7dR0ZR9fZV6nVP94LS85P2JFsJNoHabw6vtqDUIJCvL7JP0cbejW?=
 =?us-ascii?Q?aOWtz7akB7VlWmFhmM7A4G9NID3Zv2wJYvwVqQZW25rcJD+cvYu8pZrcxdZ9?=
 =?us-ascii?Q?Sr/BMyoSGYjYmYixOk3a7zH1KZk1ZyqqcBp7uXtqNcJAA9rT7BYqzSSzLqiB?=
 =?us-ascii?Q?imzZ2C0evKlRszTBBrolFiuz7RpYjziY4o/Gfx1EdYmupYXyPGFHozP2vE8R?=
 =?us-ascii?Q?+nfrzSh7cOD8HEPadmGew121FK3Eus7HyjoLsaQujrIlqFKv3a7sgpRXWA6E?=
 =?us-ascii?Q?9FJbzlvDaWqYopG3pM0h3GJ1YYvwuvMGO5DD3mIGPWA9DKxf6P6zVx6wimla?=
 =?us-ascii?Q?9sCfMy0Z1PkOZo3f3JJXd5yTraKYB9P1gUJg8WvbVmesSJsieDEfg4BkyDkN?=
 =?us-ascii?Q?jipxx7FrXtzwBcsWLc0OJ3swcDUNxZ5jLSEAgmZYayiDh+VGy1b67hh4W++8?=
 =?us-ascii?Q?ecr827WhOvNpecTEuHrBeGi+79BXeLvmRRcolXsKkbayGuuOYAakvzx28wPm?=
 =?us-ascii?Q?yJu1j8NbindIWK5MEoiNe+9ixI6LtYVZ?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2024 05:54:11.6178
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f02f858-4114-4991-61ca-08dcd938a6b0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000A6734.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8781

As per the current code base, feature check API is used to check the
version in zynqmp_pm_pinctrl_set_config() before requesting the
firmware, and if the expected version is not found then it will
return an error. So now when the latest kernel tries to access the
tri-state functionality with older firmware, observe failure prints
during booting.

The failure prints,
[    1.204850] zynqmp-pinctrl firmware:zynqmp-firmware:pinctrl: failed to set: pin 37 param 2 value 0
[    2.699455] zynqmp-pinctrl firmware:zynqmp-firmware:pinctrl: failed to set: pin 44 param 2 value 0
[    2.708424] zynqmp-pinctrl firmware:zynqmp-firmware:pinctrl: failed to set: pin 46 param 2 value 0
[    2.717387] zynqmp-pinctrl firmware:zynqmp-firmware:pinctrl: failed to set: pin 48 param 2 value 0

Now, these error prints mislead the user whether it is an actual
failure or the feature itself is not there in the firmware. So, just
to avoid confusion around this, add some debug prints before
returning an error code. With that, it is easier to know whether it is
an actual failure or the feature is unsupported.

Signed-off-by: Ronak Jain <ronak.jain@amd.com>
---
 drivers/firmware/xilinx/zynqmp.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/firmware/xilinx/zynqmp.c b/drivers/firmware/xilinx/zynqmp.c
index 0b2ad46c8bce..cdb565c41119 100644
--- a/drivers/firmware/xilinx/zynqmp.c
+++ b/drivers/firmware/xilinx/zynqmp.c
@@ -1245,8 +1245,11 @@ int zynqmp_pm_pinctrl_set_config(const u32 pin, const u32 param,
 	if (pm_family_code == ZYNQMP_FAMILY_CODE &&
 	    param == PM_PINCTRL_CONFIG_TRI_STATE) {
 		ret = zynqmp_pm_feature(PM_PINCTRL_CONFIG_PARAM_SET);
-		if (ret < PM_PINCTRL_PARAM_SET_VERSION)
+		if (ret < PM_PINCTRL_PARAM_SET_VERSION) {
+			pr_warn("The requested pinctrl feature is not supported in the current firmware.\n"
+				"Expected firmware version is 2023.1 and above for this feature to work.\r\n");
 			return -EOPNOTSUPP;
+		}
 	}
 
 	return zynqmp_pm_invoke_fn(PM_PINCTRL_CONFIG_PARAM_SET, NULL, 3, pin, param, value);
-- 
2.25.1


