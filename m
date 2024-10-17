Return-Path: <linux-kernel+bounces-370017-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B51C9A2606
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 17:04:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CE5631F277EF
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 15:04:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 739D41DED55;
	Thu, 17 Oct 2024 15:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="M7eu7Uf4"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2088.outbound.protection.outlook.com [40.107.237.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB8F51DE8B5
	for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 15:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729177448; cv=fail; b=b6VrxXJcw/VXApv3ChMCUumLWOVcRBZdukmy3IywG7oog9tV4/pZYHaOMVqelFqaLfHtekpRAWW1qyKS/GwwUrXGVwTD16utFmpb3aUGnGCa7J/KdUS73BkDbgRwMApkXQNYLwpzbDd6XrBlK1vzDIeSaPPavUD1qjYAJgJG2CQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729177448; c=relaxed/simple;
	bh=/CFNbg4hEgoGvzB3Vw6qhOkEGag6ZZGOrm3QGXUMaMQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Jvu5TxiNqt1IxgNw4lz8TbCuW4KmhLkSW0NzkY1pkTTf+KLoCCW+6pZdPyvU84r6Cd5vyh9HMy3vLuh9wutzvsKnCFov1y66BZr8I/mIHlL6m9F76x3WcQxCQCt/x+oYvhmBxSoX7kCYhhSkuk0wZiJAc+y/SwfK3Owt2Znhnow=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=M7eu7Uf4; arc=fail smtp.client-ip=40.107.237.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f2zAEH5g9iF/2TQZvLdZx8BkcKy0Cg4bUfwl/PEL30ecr94pHYawUJ7YEaAqQXcjWYlfVbU1Z5N/5XvaicQpdA5HCZEYdoARqPU53opUkV153ePovKycqw8lOycvw8lM0FdB+mGnlzy2Ke25Nrhh3amPwRcW9bJ95/c/ddI0U+AW/U+JiQRaNNBB/4OE04+9oceFrnhw5ShqHZ6trXIJP9aR1O0mQhAx/YV04T2JDZ2rLXOXREMDE2pGhiMc+25Gh5xfG6pnE9/9HyrF56thKigFk9OOnFXJR6lfAPzSZ38WN2bsksonM3xV3smUG/4xwnl7Nb14Uh8g1mzTZlrJ2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2eS3WcoEO94epiLm8nqRo+FQ7Vh0tmifhbEMUh1CaXA=;
 b=QyESInqCZ4pJ8tjjtgMZ99LweuKxWp8Jw77ZErmtX91ZRP1ntRQXz9QGz/+9b1xovWptmoR0sJ7nng42o8yApVwd9nctjrvJNtKMf12880CU4Fnw2GE9kox0S92IX7lqXV0weEL4+hznMBeLPDbvBGA5anHHGcuzGY2oy+xeF6FajLohkeOW8xlshPA2iRQJR7bT3dAUVEWzBf94V/rPKquWKj54x2AbXmUDKrSv66J516y/86oChPRkLpqbsbQ7lS0iaW41fRfc5AWirDPKmt0V1UfaGx/w6WyDDXjcQCpsmg30xzky22SyKBnaxY3YkBaid3KFSm5BENrWf3yW+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=bootlin.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2eS3WcoEO94epiLm8nqRo+FQ7Vh0tmifhbEMUh1CaXA=;
 b=M7eu7Uf4t0HJEKDCZbeMpA6qz6RhJumCR6md4w6BX+LEl2cgxvRyNzuz6PdDIOyc1fnyXuPNsAa3pAfdVjw0xarheRoQ8r9zGnlcMWZmwIEc5lmrifoPpZJAKV9t1TqPEoHVPljSQXtJ1bBo5Y5BsNqf3EwusiWXfmhdhIvNqC8=
Received: from BLAPR03CA0142.namprd03.prod.outlook.com (2603:10b6:208:32e::27)
 by CH3PR12MB9078.namprd12.prod.outlook.com (2603:10b6:610:196::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.20; Thu, 17 Oct
 2024 15:03:58 +0000
Received: from BN1PEPF00004688.namprd05.prod.outlook.com
 (2603:10b6:208:32e:cafe::ce) by BLAPR03CA0142.outlook.office365.com
 (2603:10b6:208:32e::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.18 via Frontend
 Transport; Thu, 17 Oct 2024 15:03:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN1PEPF00004688.mail.protection.outlook.com (10.167.243.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8069.17 via Frontend Transport; Thu, 17 Oct 2024 15:03:58 +0000
Received: from airavat.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 17 Oct
 2024 10:03:55 -0500
From: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>, Jarkko Nikula
	<jarkko.nikula@linux.intel.com>
CC: <Sanket.Goswami@amd.com>, <linux-i3c@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
Subject: [PATCH 2/6] i3c: dw: Use IRQF_SHARED flag for dw-i3c-master
Date: Thu, 17 Oct 2024 20:33:26 +0530
Message-ID: <20241017150330.3035568-3-Shyam-sundar.S-k@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN1PEPF00004688:EE_|CH3PR12MB9078:EE_
X-MS-Office365-Filtering-Correlation-Id: 77ebe8df-3885-4d95-53a9-08dceebced72
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?T6MXAQOMASExDiKhAlrjx9XSaBjkw5paqfDonJ8uwWZD4cs/SbLwwtQzMxFW?=
 =?us-ascii?Q?nAwcBJr9nk/ijSWJSj43kzppdJ0fSfxT1g8Idc9EGEcDYGEE2nosOW0W9ZQD?=
 =?us-ascii?Q?qfo1X9Po4q9unmFd2my4AVMqXMu9oQ1sfxv6l1oZqKPIandxhL2fW8IOy6c2?=
 =?us-ascii?Q?91U6W2zeS07rbA9gUHJ8jJOvjw47rV39CQe9a5KjnlGSHFc6/N/sIqiZEH9i?=
 =?us-ascii?Q?ZbMxsx19/dNyibZeAeDS0LOxspKtkVVErHy43hhDq8PyHnKKCPvDq0dpQt8J?=
 =?us-ascii?Q?uirevoRrYkJO4FYift/NJXp161f2ySfKsJ4ScL2Cq1C/tX0eRiS1MG8+CYbF?=
 =?us-ascii?Q?ou708LYov700EhQtzaNvWaX0K9/W0xmj/iZOufnOLwm8JJ3zgLFbGuMa+vH/?=
 =?us-ascii?Q?nqSvyHvflrx3Iikbt+ScwVrQojSfv7cTC+Or2BAZKuy13K248vBG6hbDgH/O?=
 =?us-ascii?Q?nCHAeJylQK2f9B/k8LVu2RnnQy8NGdLR1y6D5Cq/Gp/Lx+30qnBLKhck7acN?=
 =?us-ascii?Q?J49lOKR8WuJ3RiMYpIQRbgtq4P2S1YaVYjPSb3dd/TFTJoUpEcoJqwFKFBgP?=
 =?us-ascii?Q?2qnLph3pDVmR2EY3DxomRsTnBi8Jj64oJsDqIloz3KHD3qMQBZjrYEm3X4/0?=
 =?us-ascii?Q?WsvqijM2Zmw63Tqhoiz8ElS3WYdYEdA0h2gPoZvHN2A4GR9KXGojxHymjQv/?=
 =?us-ascii?Q?DB+6YMkpv3N1FDFKHl3xSahZ51XUi3XhSa+uQ4zW9vNTHOzw4TjTNjpdjsKX?=
 =?us-ascii?Q?zIy4Asg5C+7gXD0fY1nS83h+GwAbR9bwyEnVfYWR6Q1JMzmB3XxRSfIfp38C?=
 =?us-ascii?Q?cTK91tE0tVf1dtHF5UhG+R9hTX31PFqrsVSlD+zMtxNvDxzEv/A3Otyrpn71?=
 =?us-ascii?Q?48HLEmTSXCHvuI/YH+SucoqsS91IZHsIyDCjIRqeny2yUehnN8armI5qtVqG?=
 =?us-ascii?Q?s1z4fcpx7xSJxJ++qRY3H4OjD/MJad3BLWvB0m6yzqNOeVwFxf+DYIWcMd9I?=
 =?us-ascii?Q?AuNDX1k7zAVtELqkG/Nuw/Wfo1dOOLD39CMVIqKBPTC9hHESpwi+ZJkOxvim?=
 =?us-ascii?Q?Djf2jyJAbTfw+a7FSCnHhz7TnsGSFbG9gX9GIDpDS+Js+8PPqulf61RKG4sS?=
 =?us-ascii?Q?N6+KJxdgIsdkniHQrlQs7ZJ/8B6WtWLssc6n4QltO2fMaLlmvl8dEaBVOZhO?=
 =?us-ascii?Q?9L/CfyrK3D1EyFkxdNZZR+S56yd8RqlB8FvgVTjQ+q71jDP89HgerAYTsgkr?=
 =?us-ascii?Q?vYqrXeHOTfwxmvLm/uabsNOR9GlwlYxjFm1vSbFjRJ63jXW/ZWESiHXN4dQx?=
 =?us-ascii?Q?5ETWT13nMKREe+IQ1c7I09y3RLiabqSl29pQn6Lzi9jLZOLiAcbv3fjTwHRR?=
 =?us-ascii?Q?n4kPy3MdzmH8oqgJtwl5KBh3fwmCS0XGXOH+vu8d24L7y6Cp4A=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2024 15:03:58.3316
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 77ebe8df-3885-4d95-53a9-08dceebced72
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00004688.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9078

On AMD platforms, the IRQ lines are shared between two instances of I3C.
Add IRQF_SHARED flag during the interrupt registration process.

Co-developed-by: Sanket Goswami <Sanket.Goswami@amd.com>
Signed-off-by: Sanket Goswami <Sanket.Goswami@amd.com>
Signed-off-by: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
---
 drivers/i3c/master/dw-i3c-master.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i3c/master/dw-i3c-master.c b/drivers/i3c/master/dw-i3c-master.c
index 1a7c300b6d45..fd58a95ae1c3 100644
--- a/drivers/i3c/master/dw-i3c-master.c
+++ b/drivers/i3c/master/dw-i3c-master.c
@@ -1578,7 +1578,7 @@ int dw_i3c_common_probe(struct dw_i3c_master *master,
 	writel(INTR_ALL, master->regs + INTR_STATUS);
 	irq = platform_get_irq(pdev, 0);
 	ret = devm_request_irq(&pdev->dev, irq,
-			       dw_i3c_master_irq_handler, 0,
+			       dw_i3c_master_irq_handler, IRQF_SHARED,
 			       dev_name(&pdev->dev), master);
 	if (ret)
 		goto err_assert_rst;
-- 
2.34.1


