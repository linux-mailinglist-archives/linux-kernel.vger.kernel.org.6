Return-Path: <linux-kernel+bounces-377389-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EBC349ABE2D
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 07:52:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A863A2853E1
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 05:52:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 122FC14A60F;
	Wed, 23 Oct 2024 05:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="smblkJcb"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2055.outbound.protection.outlook.com [40.107.94.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA2081465AE
	for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 05:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729662725; cv=fail; b=Uel6EWkqxCUyntLihEWzn6bowHYbzwoti/QkVRutab+OjMWYJnfbWWtDJGIuwNVWsH32vpoaDOtmuSFA35M+P0sa0rD2byEBGyDNDHqd5YPvOYclQqxVtB7L9OagblgE26RZ5cBXFwJ+LdjcxX/Z7oi9zC3HzKxxTbxzHxyRaIc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729662725; c=relaxed/simple;
	bh=5dJwOqgzpAIIa4BUPfmEcTa2pT/TBkiMLGB3QwcqfcU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ubJMTPYlwGl4nJaBra+1ydXODT7Mxc7efufjhM4RQ0kTLBXG83o+wmgOeV1+knDqvKgCGh8G6AXIwshAnojHW9Gh8swRx6yD0Cu5HHClyVdrqJimeWAis6cWpYH9A5j6SQ/O9aSnE+TyyFbWmueqtdYRpmqdyatq+gj8ivQmZ0Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=smblkJcb; arc=fail smtp.client-ip=40.107.94.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MiJnQUe8ZkTTc3sXFfptH94dqw2u8YhRT8BcDjUjRbad5Cky/5G2l2uoBsMGmkDKZ1XS1mvmha+qiUfGyJtX1KFaQKBC5iKzmVfFJxHmFmd/ZpnwHcCriaJ3inmAnjrYE/lMP8cn9UpD9NeiBUkMTyC9dk0S+XCDOudCF1yCfx6nt3phu/+8dFA8z/G5HwAAqNitK2cmztJQk7R/lg25mAlMhVbGl6yLU17GGwENOWycZTfwtsW0e++BeReCEDS+sPci0LCygs+OPEWi0je1pEPb54CGsk7kxo/8XfotBQNeVngRdjC1WtIegOUhQAyINQscm/rKib8spssYOXDOjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NPKmfR8IgTnu9YrzTYscpfFxxJTFU8XcLvkTAzCt77k=;
 b=at7sepv9w0QrXbFVgCwdGBKZwiQ0kKzxORZNYya7Be4e0r754LkpbECSHcUv6kNp1Z6CorAyA0As+nWqUodoCkIWQlU1AGGeS2MnaqvAx8L6MYkNtYiSQfwJMEpWFBeAFadtQ5VOsz/FEKxnHoYL+5kzDuKzWsHuF6emulx40R6S79qlPr/rZwabx7eyrEse4M3jvweZhagNCW+ku72807ZUEwbCb8k5kyA8boojUlTceGNaaREgh4HiUIFCKQYy9et/ixAbTtZsjFz9q+EHssW2zVtCB0nukHy2uAoslbtrN22Um4U9SRNl0/2O3ke3tG6OzmeVmOaZrQfOfTBQig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=bootlin.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NPKmfR8IgTnu9YrzTYscpfFxxJTFU8XcLvkTAzCt77k=;
 b=smblkJcb0MUIcYXsqIV9K3XgdS+SliPnnztDUZdER/Ik5tfxaCaF/hUDPZk5h8+3G+Jdj2kg+A1Iq8WByAmKb3+5j+oRWIkAWgcAcjYOlnXfJzk8jHR9IfxWwfDWSibeDpCoKVACIFZ0kVUk7xMYQzOm9mqsNR8CDH9BC6kCfoE=
Received: from PH8PR22CA0021.namprd22.prod.outlook.com (2603:10b6:510:2d1::7)
 by DM4PR12MB6374.namprd12.prod.outlook.com (2603:10b6:8:a3::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.18; Wed, 23 Oct
 2024 05:51:58 +0000
Received: from CY4PEPF0000E9D8.namprd05.prod.outlook.com
 (2603:10b6:510:2d1:cafe::4b) by PH8PR22CA0021.outlook.office365.com
 (2603:10b6:510:2d1::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.29 via Frontend
 Transport; Wed, 23 Oct 2024 05:51:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9D8.mail.protection.outlook.com (10.167.241.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8093.14 via Frontend Transport; Wed, 23 Oct 2024 05:51:57 +0000
Received: from airavat.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 23 Oct
 2024 00:51:55 -0500
From: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>, Jarkko Nikula
	<jarkko.nikula@linux.intel.com>
CC: <Sanket.Goswami@amd.com>, <linux-i3c@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
Subject: [PATCH v2 4/6] i3c: master: Add a routine to include the I3C SPD device
Date: Wed, 23 Oct 2024 11:21:16 +0530
Message-ID: <20241023055118.1400286-5-Shyam-sundar.S-k@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241023055118.1400286-1-Shyam-sundar.S-k@amd.com>
References: <20241023055118.1400286-1-Shyam-sundar.S-k@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D8:EE_|DM4PR12MB6374:EE_
X-MS-Office365-Filtering-Correlation-Id: ae84aab0-8cc4-47b5-b1d4-08dcf326ce9e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?mincNspPLvgo5kQb0mKnn6ieGy0pv5AkNxH3gQiXG64iDHlXjxlSV1XAZRk1?=
 =?us-ascii?Q?VgvE7qdmAmkZSeOKp0QU6JPflxbMHET7g4yrMTUHhWSSPPR3hOlfKC45VOnk?=
 =?us-ascii?Q?9Ptd1r23P+cTDrPgBqW1uvugh6uZVo2TBikfZDtJXb1gjbmO87MPzdGUinHc?=
 =?us-ascii?Q?rBVNmK94MafFBa3P4NtYc8CM7H66FcV0SArKXhtPB3FhisA+KgCCNcDS10FP?=
 =?us-ascii?Q?/3xfbu2c+6JIy50V5T3XdDEVKMCwlUr/Tjskr58bpNj9D9uAoT8fF1RrhM5t?=
 =?us-ascii?Q?+hGef5rYIwwSyoLKOgj8Q5hEILVgMDc/2miS1ee/Tpa1KuU6Yc5ctQg2CPd+?=
 =?us-ascii?Q?YLD9OyCdQxSuarqz3uz+uUoNkZfp89C9WGzyEL5OabFQK8CVM8bk/uhQ/eWz?=
 =?us-ascii?Q?92/BsXCxdKORFMijXBN629kgh8VT2EA/cu6EY8w27TBAFiZcePCG48ul3S9Y?=
 =?us-ascii?Q?nzvxWTmRyZRMA6aZWKbIhl2fjHXZBhEIG/n4dHXo+LGDRv5z8h6wclMr0sX/?=
 =?us-ascii?Q?eTLd5t+2KCKue5DG6xFYcuyQf1y15ok0f7Rn7lufqTrl/mmATvPUx9FmsM6f?=
 =?us-ascii?Q?XTJ+0wL0cOE+rZlH8ZdCONvNQmSivXkto6WNb4nvOwTOEqBF5hr9KEVVwsEH?=
 =?us-ascii?Q?dQEYPWzPHZ0CtUudeTSwMiydUDzAOtofnH7x9+Zmj09rqPG0kwT9evmjLDGz?=
 =?us-ascii?Q?Ho2UgS1dlqvgTJC7jQHN0QHIslXwPXyvOm/EZjG0Ye09R2G5qvJoG57io/zf?=
 =?us-ascii?Q?V1MldwbO+NpYMRL0TalYiTcUTeAGsbKSAJiyrBPrWgBOzmCiRAUyBCh+JkaA?=
 =?us-ascii?Q?eeURL/PCeqJvRBIvvaO9vkSbiJcjoV73acX3NS9rSpHB01dzFHMhAOvFnt/k?=
 =?us-ascii?Q?3FrvUU4ywWoPmp+LMXggA2AYQ1PjSO+6ILgy5DFqlm8EYWNNgQqrWJMF50OB?=
 =?us-ascii?Q?5/XtoN28jxZoxghuqhSYXgkBf+QfBDPfocyeYuWoe/IGyjDe7IkqNsHZ3xOh?=
 =?us-ascii?Q?juRdqWjPUWIvkakY5V22jOQPdCkWQjH6Ng3nbKNyggfkzw1Ud/hZaF8RfK1u?=
 =?us-ascii?Q?xFgZtaR6u2soSiRso/EWShyvsj1uPq2jqppeiHF5bwOAcwG+cwOiCxLTFvwm?=
 =?us-ascii?Q?y1Tf8aWogG0a4TcHxo9K77hqJZIiJFjodNNB7uyORp02Z7nkz/fKFR27zqde?=
 =?us-ascii?Q?ZDBEHUd9Zbpi7QDf34kOw/4SM4+xIAyP7wwh6Gu1BUs8oGD7Ee6QZpbWeR2f?=
 =?us-ascii?Q?i8YRsWLH4Tttcd7tPU/Y7wzrocvqCDS0SYAu/QDfWz/Xlw5aRecP2GM63jHF?=
 =?us-ascii?Q?zqOtXBLsp1b3sK7MWcUMYd89FwNPch8erhWzVpnX71kGGlgQs4RUfsRbLwPv?=
 =?us-ascii?Q?5SCaKx38o33bznz/EJg1dqpmFo+tce/Vn1XM8ODZwXcmBmu0Hw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2024 05:51:57.8706
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ae84aab0-8cc4-47b5-b1d4-08dcf326ce9e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9D8.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6374

Implement the i3c_master_add_spd_dev() function in the I3C master to
handle SPD (Serial Presence Detect) device creation and map the board
information into the I3C device structure.

Co-developed-by: Sanket Goswami <Sanket.Goswami@amd.com>
Signed-off-by: Sanket Goswami <Sanket.Goswami@amd.com>
Signed-off-by: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
---
 drivers/i3c/master.c | 43 ++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 42 insertions(+), 1 deletion(-)

diff --git a/drivers/i3c/master.c b/drivers/i3c/master.c
index 7d23c32e1c0f..ba6f17cb8aa6 100644
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
@@ -1814,7 +1853,7 @@ static int i3c_master_bus_init(struct i3c_master_controller *master)
 {
 	enum i3c_addr_slot_status status;
 	struct i2c_dev_boardinfo *i2cboardinfo;
-	struct i3c_dev_boardinfo *i3cboardinfo;
+	struct i3c_dev_boardinfo *i3cboardinfo = NULL;
 	struct i2c_dev_desc *i2cdev;
 	int ret;
 
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


