Return-Path: <linux-kernel+bounces-370020-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FDCE9A2609
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 17:05:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 070E828938C
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 15:05:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 685D81DF257;
	Thu, 17 Oct 2024 15:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ySzmmNCg"
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2083.outbound.protection.outlook.com [40.107.92.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE24E1DEFEB
	for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 15:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729177454; cv=fail; b=FBHSBCLtX7QS9EGhyt72GsS03tIGRsibdH47wyOkaVODgK+0NyDhhIO1KDf5T7KLUZLIXTUKvfRtzvdO/xGLr4LtJwAStOxkGi7dvMgCB2yxAdsjubMvWukdEuqTaP/k1Gj3PHuYQRWsxeQ8OIGszgZxqV3anV1NopiijBbPH8A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729177454; c=relaxed/simple;
	bh=v/krIiFmV/SMIhkgL4s3X7G/2wLzbJMJiUMOys6z74M=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=R2mZ2EVUtOYIVKlhalj1rr69q+y0EC66vc/fU0IrG9G4uX4as/ewceaPH6DQdRtjsEBJXllv7Nkd7J4PmTESIiY2osXrVaNNnnvd/BZNpv7qzA1Yu3PTsNms33uaFcDaiepn5PYR3DX4dXercik6QQoKAEVm+6yMQqw5udgDbiU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ySzmmNCg; arc=fail smtp.client-ip=40.107.92.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OZA3I1JhwuPUPU/zMvSs8twdj2Dj+y/HMHPo4oBfrs510gSnIQuSFXvhbm6ZOqG7DL9FIQomELM0SZ+RW+Oya3OZ/S9dUo7EC8dAA7xs6syWIj8VzS1QMxj8/mC0Aaq6bVjiXE/TORfwPX4orvjFDz0c3KjqFHn6FtPyAjOLxmGoD+zbs+eDe06t+G4cJjzP1gNSuMb4WuWGr5zIt5vAgR/Kj4P5PnXCLSFIBOAT5gy7a0QGPNg6tgs/KecbofjgUtC8Hw4qa9KI5yQRWOlXMlQPmoyzDC6ZmkCPSw9OnpVDYhsndIj5cCoqkb52i3NZeHGe845rSq6k8pK8wxjgIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tEuBjKftWnG8/lTH/XY+Pm302D7Z6uUrMXLct9A+m+8=;
 b=F7A5WC+Q1rZGpHYJjyKzZOrqSM330yD+o+KgbWyB+tDJaJa374UpS/JFpGnnA6BSpTFweBWgJZ4ufWyOicBMA/U7tm0Di3+Mc+tch9aP4KWarLZXhVK1WAFCVmaluwMTuu5S6Fu0RWKVqrePscqQ9Z9h1+5Ia8Vn5ejhqO3PHGBCc0a3yw+I80F8IIFqG+TieQWn/oUCxjIVfh/NjtbwFGqXM16LFV4EKJhb/av8RepEES2HzU38PIrnb0qQFxwR/F6gKOZQFneNweOMPcag8JhE60wYHa4CJ7b8N35yo1gxCXnbtIfGEbAtiNXZWcvIhl24iTGPB/ZS5PpWAeGv0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=bootlin.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tEuBjKftWnG8/lTH/XY+Pm302D7Z6uUrMXLct9A+m+8=;
 b=ySzmmNCgrVomr21I4MyIJSm2gNHCZtqheoE5KmtWEywPWAxkdMmivQlVRqj2hko94CPS82WywRmb6eQUY0+wIcRR/RzKWG353eJaoWIfRNN/xbrnxms4+lvkxupbdDHsRu/x10bZecDjyAcdmdPSuXy9HppnaafHgAGxR2w91us=
Received: from BN9PR03CA0126.namprd03.prod.outlook.com (2603:10b6:408:fe::11)
 by SA1PR12MB6798.namprd12.prod.outlook.com (2603:10b6:806:25a::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.18; Thu, 17 Oct
 2024 15:04:03 +0000
Received: from BN1PEPF0000468A.namprd05.prod.outlook.com
 (2603:10b6:408:fe:cafe::88) by BN9PR03CA0126.outlook.office365.com
 (2603:10b6:408:fe::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.26 via Frontend
 Transport; Thu, 17 Oct 2024 15:04:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN1PEPF0000468A.mail.protection.outlook.com (10.167.243.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8069.17 via Frontend Transport; Thu, 17 Oct 2024 15:04:02 +0000
Received: from airavat.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 17 Oct
 2024 10:04:00 -0500
From: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>, Jarkko Nikula
	<jarkko.nikula@linux.intel.com>
CC: <Sanket.Goswami@amd.com>, <linux-i3c@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
Subject: [PATCH 4/6] i3c: master: Add a routine to include the I3C SPD device
Date: Thu, 17 Oct 2024 20:33:28 +0530
Message-ID: <20241017150330.3035568-5-Shyam-sundar.S-k@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241017150330.3035568-1-Shyam-sundar.S-k@amd.com>
References: <20241017150330.3035568-1-Shyam-sundar.S-k@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN1PEPF0000468A:EE_|SA1PR12MB6798:EE_
X-MS-Office365-Filtering-Correlation-Id: 9d48f2a7-1cc8-4e10-b3fa-08dceebcf02f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?oEUOV3/I2WGq/s97pS5yDSBBysWjQsb9H3LDVwy8mOQHMSuUhH2QIZFl09//?=
 =?us-ascii?Q?P6m1nUSSLQ4G1vxE6WebqweCl8Sm9yNmtHi21CqW2KIZVSEMpHshmD9J3Cqs?=
 =?us-ascii?Q?wol3JAQPGfuCqlOPtmjcg/deMN2l4IjPDLlwkCcWvai8FFpbGoPYo+Q9kAz5?=
 =?us-ascii?Q?8G41yiCr6yKiAfVymjxCiIfJwRNd2Si5oPIZ9LrEBLeohwUkR1peRIouJexI?=
 =?us-ascii?Q?whiPV7BPHPVwQwrTSMeT1Jsmsrv/ME3dLxSjr59yBPAsAy/cebfzLmLA94cd?=
 =?us-ascii?Q?SfxuzULBKGTQQStpV0Cp1BiOjWRppK4ADlqLcH5y6U1D+i53lypiAULlTqqC?=
 =?us-ascii?Q?oc6oho7ML3LtM1rIc2qN8jM120iDgJanrgfnva6/+FA8SoGl8Zl1eay4M1Rb?=
 =?us-ascii?Q?Hn/Qs+s5tbMJxhZc2ur0N1iE+09bxUR0jE9fKOz+8FkcuGKFuWTeQWfc7JQk?=
 =?us-ascii?Q?/YpqxjkQTEZgD+sA/SNvpIfeGJsTI7Y4PBLakCRh/fm0BowwLqQhVkPVj/uV?=
 =?us-ascii?Q?Mlg/PJ4HSePSM1AMsY3TbHSEQboMnx/pUTyS6icNPeUPiiqOuLYc01MLFhdd?=
 =?us-ascii?Q?nsp/0tb4q3KP7XXMflbZvGlK0oKrDf/6maobCzM4Ow/okbXfCuVjGhPi/tBv?=
 =?us-ascii?Q?p8eVurdVQJqOv4eRGmL7XlW3aQ4tgSFsSiHsRXDDCf2fXed3UEK6HiXpVMB4?=
 =?us-ascii?Q?AIfQMugS+he/5GKp4g8+q2TvtLzFn0oSkT2KVmC8n8YlRxHhCn7nhD1bG4by?=
 =?us-ascii?Q?CNYCMxYle6gzOR7qgfG8CkRuJT8Ttz/McjWQdZanGImQrK6NR6duGTEtZ2jD?=
 =?us-ascii?Q?dR4xeRvqG4tyYkbHfXbOnlv4yKL+QveUGegOBdToFfuNo7KaNvZwU6xjj1/Y?=
 =?us-ascii?Q?9Dx5MSxt8JYysNy4vQI2A1m6yjvKwrKwJg72tqtz55uC78Pgrg74cHHGBRZR?=
 =?us-ascii?Q?+OXlkvZj3N2omLVS/H92V8Fec4jSwkl0JyvdFHWRTBir3LL05vlSBMFrQ/rj?=
 =?us-ascii?Q?/tV8oQ8LkY1n7Ye/Yvd3500KKboCvaHrcJrXI8Qcc9KbEBrnYD7lNd6FzTMw?=
 =?us-ascii?Q?GJvZS95zDV+xuVf4ConhbmXCOaxBBx9mwYKJrKvPtXkm+aDEKnQwcSyiZx8X?=
 =?us-ascii?Q?rHnFE4A71yBEgsIk/P5lbbdWN687Tiaz2Mm8t0mj+03DYIS99CtiJMytVMli?=
 =?us-ascii?Q?z8uWk/LWMiEp/5lpSfB+kl7clbebkHwG24aS5Mj8bSl0EGxOBkyuRXxYjzuH?=
 =?us-ascii?Q?Y6l184eJV8I1vdB3+kCurZYJhu7TuDetUfhKxCxvMiMhTsC+9MueZNyX5YT5?=
 =?us-ascii?Q?IHtktmnlgvdFuFxSCldqAKRd3EFoZKLauRHsZo1FTKdFs4bDVJZO3ruDEOmW?=
 =?us-ascii?Q?nDxM3LhWUmiugWOkpEUFvm54FqggBD20MHsSBXA5Ej1UQsVIgQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2024 15:04:02.9906
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d48f2a7-1cc8-4e10-b3fa-08dceebcf02f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF0000468A.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6798

Implement the i3c_master_add_spd_dev() function in the I3C master to
handle SPD (Serial Presence Detect) device creation and map the board
information into the I3C device structure.

Co-developed-by: Sanket Goswami <Sanket.Goswami@amd.com>
Signed-off-by: Sanket Goswami <Sanket.Goswami@amd.com>
Signed-off-by: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
---
 drivers/i3c/master.c | 41 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/drivers/i3c/master.c b/drivers/i3c/master.c
index 20b83ca52d31..4f149519170e 100644
--- a/drivers/i3c/master.c
+++ b/drivers/i3c/master.c
@@ -1657,6 +1657,45 @@ i3c_master_register_new_i3c_devs(struct i3c_master_controller *master)
 	}
 }
 
+static int i3c_master_add_spd_dev(struct i3c_master_controller *master,
+				  struct i3c_dev_boardinfo *boardinfo)
+{
+	struct i3c_dev_desc *i3cdev;
+	int ret;
+
+	list_for_each_entry(boardinfo, &master->boardinfo.i3c, node) {
+		struct i3c_device_info info = {
+			.static_addr = boardinfo->static_addr,
+		};
+
+		ret = i3c_bus_get_addr_slot_status(&master->bus, boardinfo->static_addr);
+		if (ret != I3C_ADDR_SLOT_FREE)
+			return -EBUSY;
+
+		i3cdev = i3c_master_alloc_i3c_dev(master, &info);
+		if (IS_ERR(i3cdev))
+			return -ENOMEM;
+
+		i3cdev->boardinfo = boardinfo;
+		ret = i3c_master_attach_i3c_dev(master, i3cdev);
+		if (ret)
+			goto err_free_dev;
+
+		i3cdev->info.pid = i3cdev->boardinfo->pid;
+		i3cdev->info.dyn_addr = i3cdev->boardinfo->init_dyn_addr;
+
+		i3c_bus_normaluse_lock(&master->bus);
+		i3c_master_register_new_i3c_devs(master);
+		i3c_bus_normaluse_unlock(&master->bus);
+	}
+
+	return 0;
+
+err_free_dev:
+	i3c_master_free_i3c_dev(i3cdev);
+	return ret;
+}
+
 /**
  * i3c_master_do_daa() - do a DAA (Dynamic Address Assignment)
  * @master: master doing the DAA
@@ -1868,6 +1907,8 @@ static int i3c_master_bus_init(struct i3c_master_controller *master)
 		goto err_bus_cleanup;
 	}
 
+	i3c_master_add_spd_dev(master, i3cboardinfo);
+
 	if (master->ops->set_speed) {
 		ret = master->ops->set_speed(master, I3C_OPEN_DRAIN_SLOW_SPEED);
 		if (ret)
-- 
2.34.1


