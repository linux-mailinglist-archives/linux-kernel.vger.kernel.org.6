Return-Path: <linux-kernel+bounces-429004-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6C579E161C
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 09:46:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2FEE1163B3C
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 08:46:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25A321BD50C;
	Tue,  3 Dec 2024 08:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="uRoC6Knf"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2050.outbound.protection.outlook.com [40.107.223.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECAB77E591
	for <linux-kernel@vger.kernel.org>; Tue,  3 Dec 2024 08:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733215581; cv=fail; b=N+g+wFbw6MtPIFJuSeV+RU5mD0/7cOkci7c3M2uExUb4jrgSTLzsaLkgYhBeR8Ng2HJuirHseh/XdKca22L9DrbVQ39Ux4JpgdIvo3QhUbfpT4Dqd+lD1+ox37CEG2mJivcwBbjvL48UPziW7dZr5ypBIlJEgzhZrEUWCmB4xg8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733215581; c=relaxed/simple;
	bh=BMR+odXzfEoIUmFpq+M5CSab4ZvecB5y1iEhmHou7aA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kRIssLqmYHQitisJW+BMPvyr+G2PM9egWOdbjmrZGoFTGfHU5GwNK3rJLNHUkgSQp0sKE8F7vsNIZ6hDfdfEdYMWkREyaVUcubTBzhAagBeuMn+yDMvjobMYlwMqZ72BsbcIAYZxHH9N/cInWMUeoYl8Q7ZP01wqtPtyPu+NemA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=uRoC6Knf; arc=fail smtp.client-ip=40.107.223.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Gjz8Ruc+0vLFw5z+ZGTSlYNhAuoY2rdf2FTbmQz3f8gwWIOoEaIe2s/SHCneqYskqrazC5Xyfw9VtfOX1KvS3+utl6M3eyiAedqvczFjF0t5X9ADBuv/UtIvZtSBLbSTPhcaRTk95f1jKFd4GJ784T66Xd9IoY4ji6NG1gflsCLjMb/kFQnjsT+8pvZBpRVaPTJHXtx3yuRErWAKU3XhD+0DA4nkvtiM+xZdjCHG76vHD/rdikOMPyowEShDL4fkroR5ri/DRHHwkhe1YWi6/yQ5bRYySL5+OUajFsdiBH55s06tyxFbef+nS7NSzbBvJRDJ5We6w98n4bSPIawIcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4ph1ztod9qQQOSqQM5NnnlXUpJM65lsT1moniBxNL/k=;
 b=NlI2ZubhD3iXnNrFR9SxHyr4G+LHghmhQazys6Ba+y2VH+v2vO5mM9gAdBzUfeEx3OY+i1oU9qoFJW/54fHi42G2fMzpRtpZOgIunnOwSbvdZ1S7U4DvzBmyIeZhdA3XyW43whN6RY92uWROVEyDHcQ7TASYwqEKJmlJUsDCuRp39+/2aRqzAMU1yuUeXF3TfGTf908FD076Z0Dq3Wx+wDk6IeEsWgJdGrGFZginB+fPE34XAlBIz3WPne8c6zJRQ4sNHQwH10zl2SqxW/ONOmPr1LJo/cDjJFfd208KGgx6EQyW4aQJVzRzagHblwdgmj14DoErITliH/SDvDTmhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linuxfoundation.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4ph1ztod9qQQOSqQM5NnnlXUpJM65lsT1moniBxNL/k=;
 b=uRoC6KnfhBeYyGi3G67w/ilAJHiAAcAEFtVUZJlmkg5g/fh6FBLH1Pn0tlLeBdjt1Nwjn8UZRb5Xj3p0Xx7ZYCneCT8p+B5bgAz+w7OvpzLWHEw+OcLZYAt+TImP1Vun8n6nIDqHPS+KUt1NE3BaLUwBN0SRSk62EQInCO5AMlc=
Received: from BN9PR03CA0274.namprd03.prod.outlook.com (2603:10b6:408:f5::9)
 by SA1PR12MB6972.namprd12.prod.outlook.com (2603:10b6:806:24f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.19; Tue, 3 Dec
 2024 08:46:16 +0000
Received: from BN2PEPF000055DA.namprd21.prod.outlook.com
 (2603:10b6:408:f5:cafe::e7) by BN9PR03CA0274.outlook.office365.com
 (2603:10b6:408:f5::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8182.20 via Frontend Transport; Tue,
 3 Dec 2024 08:46:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF000055DA.mail.protection.outlook.com (10.167.245.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8251.1 via Frontend Transport; Tue, 3 Dec 2024 08:46:16 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 3 Dec
 2024 02:44:45 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 3 Dec
 2024 02:44:44 -0600
Received: from xhdipdslab49.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Tue, 3 Dec 2024 02:44:42 -0600
From: Abhijit Gangurde <abhijit.gangurde@amd.com>
To: <nikhil.agarwal@amd.com>, <Nipun.Gupta@amd.com>
CC: <gregkh@linuxfoundation.org>, <linux-kernel@vger.kernel.org>,
	<michal.simek@amd.com>, <git@amd.com>, Abhijit Gangurde
	<abhijit.gangurde@amd.com>
Subject: [PATCH v2 2/2] cdx: disable cdx bus from bus shutdown callback
Date: Tue, 3 Dec 2024 14:14:09 +0530
Message-ID: <20241203084409.2747897-2-abhijit.gangurde@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241203084409.2747897-1-abhijit.gangurde@amd.com>
References: <20241203084409.2747897-1-abhijit.gangurde@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000055DA:EE_|SA1PR12MB6972:EE_
X-MS-Office365-Filtering-Correlation-Id: e8296976-dca2-4958-d778-08dd1376f335
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?mdZKBtGbZYIqPvgNqVciM0uzdpeYizkBFv4FjYVnKz/Z+6PO0MEWN+4Jnq54?=
 =?us-ascii?Q?iOOvf1OL3npfR/NhVqIGsWe0oSgEVQavhii3SOYPcxE7Vpc1n/9cPODJwO7U?=
 =?us-ascii?Q?Yuv08J+pub1DsfI6hHrob+/zHDWPcs3WmcT/NCRoML0BKh9dCScUQIAONoPe?=
 =?us-ascii?Q?CzqvEogJrULOrMRHpDGV5abTE8gMR/PycVW3lfl0+iQW/UzhDirIHKBL6XOA?=
 =?us-ascii?Q?ItatU1xYUDt4U9cctecv63PtJAi48b1PhDtQTt8zux3rJZ+wru25Cm9UcXAd?=
 =?us-ascii?Q?HNYfWZEj+rBfQRx0h66NXP4rb7XiQChlZ3aOc2W2LTnZc8c7DNCd03/lBT0E?=
 =?us-ascii?Q?XFdWRxmxYf0Pl1NXJ3PRbXVLZtmQv/AfjFweMxnixrPPKMEA7xmcMVloGxgr?=
 =?us-ascii?Q?kxORJFLdvhK0WfsidVZEVVbF8d+YiGyqYaep3ihe0i2J6Hs5moZtgt7Ysy49?=
 =?us-ascii?Q?SB2hpWwjAmeJcSFfJIdwYZ3DxXQP7LosgXHACHVllNA2tYqn2S3sZybP2vYA?=
 =?us-ascii?Q?LdeJCCbV+fAp3irWCjphV9OqgQlRAdJM/Zfm9sbtucV+LumBis8D84/xcfdQ?=
 =?us-ascii?Q?AF6YniNXl8CeqYKm6FKmuFJ9nYOuGwGxjikbIkRYJIQRxPNUD7drp8KiqYHq?=
 =?us-ascii?Q?GG+hOQ4CgM97Y1bEjZlSVdk84OZqzTZN2bRyOFrpd6Aoqog/FCOpvKhykGik?=
 =?us-ascii?Q?QAJOQR2JmYmRNu4YTPnkW2uvMjHzQiARP4iHGxcGmCR/VLwzsFykV4j9Vai2?=
 =?us-ascii?Q?I5wW3LfnTlPkYgQpZY2e5ktSChepMAlEW0QXw1sxn8+O1CtXKjHHy/wdfGE9?=
 =?us-ascii?Q?lrXDigfX+QLwGReDJuYMQJ6BedZfdz5X/0AqhAxTq+4L8bkuca3Ekte1aqXs?=
 =?us-ascii?Q?SG3gf9gJBXhdu6XlvqUZtpme7vct7TFSGMVAWg1k+NsvSKdN7SGDN/8Jbf1W?=
 =?us-ascii?Q?i99AAnWEWMzABT2GXtMtwvKP2yKj2eU6lc0heVhjO9bPnDYzTl/XeIi3tcAV?=
 =?us-ascii?Q?8tYxL50fN0xxxp/3fnnc2pB+gtipEnINLMy7E8VXJYa5d+YwPUKWv5NIgv23?=
 =?us-ascii?Q?BuQcRsciaJViY9hjG8s1iAW62cs1wlZBhLmwJFT8YGLBagCt0T8WtcoSYeTa?=
 =?us-ascii?Q?ch+U8chueah0jcjL6Uhk/bxxY/GrDE+XRMrpSNkdHvR3Pz1tCPxhZjAu+fX/?=
 =?us-ascii?Q?7EepioC9IDDx/EpOLyxn7tkruKf653DWchizHcm91c2KRqyk1fW7+0q84OQ8?=
 =?us-ascii?Q?pwvvpRKBb4XJ/CZluJKEV4v8MVtlr4PkUoFspD0sAzuHcqLn/ADDjZPci+jZ?=
 =?us-ascii?Q?mhVbhf/yxtDBshGlc+YFLkXqL1/ua947Cpqu49mQAaD39sfnDyOcx5IceW5r?=
 =?us-ascii?Q?sEvwV/9ojR0Td9/HnC2ctbJSr+5sv1BoD+BKiHzEYSkJ4cS08Rhok6Eg8qVR?=
 =?us-ascii?Q?bnyAVDtXMbvCKS6tglMFswmzLtQ7CRTo?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2024 08:46:16.3157
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e8296976-dca2-4958-d778-08dd1376f335
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000055DA.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6972

disable cdx bus when bus shutdown is called.

Signed-off-by: Abhijit Gangurde <abhijit.gangurde@amd.com>
---
 drivers/cdx/cdx.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/cdx/cdx.c b/drivers/cdx/cdx.c
index 07371cb653d3..cfda17a93977 100644
--- a/drivers/cdx/cdx.c
+++ b/drivers/cdx/cdx.c
@@ -338,7 +338,10 @@ static void cdx_shutdown(struct device *dev)
 {
 	struct cdx_driver *cdx_drv = to_cdx_driver(dev->driver);
 	struct cdx_device *cdx_dev = to_cdx_device(dev);
+	struct cdx_controller *cdx = cdx_dev->cdx;
 
+	if (cdx_dev->is_bus && cdx_dev->enabled && cdx->ops->bus_disable)
+		cdx->ops->bus_disable(cdx, cdx_dev->bus_num);
 	if (cdx_drv && cdx_drv->shutdown)
 		cdx_drv->shutdown(cdx_dev);
 }
-- 
2.25.1


