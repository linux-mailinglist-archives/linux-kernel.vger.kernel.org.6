Return-Path: <linux-kernel+bounces-205815-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 567BC9000A9
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 12:22:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A4425B23524
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 10:22:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC3D115ECF4;
	Fri,  7 Jun 2024 10:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="D6qFGgSm"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2078.outbound.protection.outlook.com [40.107.94.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AC3C15DBC6;
	Fri,  7 Jun 2024 10:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717755705; cv=fail; b=GwKQ8tgjspZjhRw4jNsAXD99l6ZhNOIC9+/UvNjzuhLIk+RNepjz4joHN5ILAEuuE5/NkPbUGYFgWZ/YH4JaepHsV4OH5hJOdQHtRgWa8YJdRIMiDap9mnVTGEMi3uTBmyuFzJF/t/Wa/0GfWAfvvcXh8VBQEu5zRXIYK2gznWM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717755705; c=relaxed/simple;
	bh=b3lmgfBq4u/LoZjxNrBCpbdjlq4OLj1eqPANP95GjQM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LBX5PS5nAMkOWJpGVYlMgbT/Dlijn2rVu9p2Tjm3qgaI1qmyqXPt6ECNvy5CvHJPhzMXahroCNa38W+kZyFpiO4BQtXBAbIIK84Sjo+gTQZKCHAqpDjZkumKx6Xuiq826XfclDhcgsHAWtHLWBAbor6S4FerijAHKFq5Af689Vo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=D6qFGgSm; arc=fail smtp.client-ip=40.107.94.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G1OliMqBJmE8aj1UsHYxUKfZ+7WR4r7TGN9GUsc6YS0/9X5zgChpMCkDw29/9phqFzLlQMzjdKQyyubTvRfFaa6Ad1niV1I1L3CowbTmQ8oKuLCEOCt76k+/2/OcmO3/xrAO4+MUtFB4g2axc1G/ctcEQrMELJrCqRXG5H3aEz1RG49Ux8xuL6BA7vIyii/e6FSHc3aAzHt62fbMhHx+SQzKpiWYRfQ7XgPHVY1yeKG+oK9wkJR/A9aKOD19UQr/RmWOK8n85tpu4sVaQGtjSVMIWUGlSZNu15zdEUM9Gcf5JZo9AKOmrvzV+EcS3x7nnIvuUHgsN/do67rLQ/ZN6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LhvWfOfnQIsyGM2CNER4k273Un+L1stFJMN9Kzn25M4=;
 b=RIMebB8OqdtazDtMElyn+TP0ByfYgPn4/hG4CIhlAFNs+bDPc9PsYYMYetwRZAw9ID/3eWtbvJav2T1UJppEX475Em9LWDUZGENPWZ3y+RmRYGq3kaD7gOngm5wBD9l9f7q78UD7gzR7ayYA98o4zaRi4M0V9Vj5uaAYtEaPixwVd96TsI/Da+wmnJ6tYH57nPIRJ3eLSx0bnEUv1Rzs7hDxnJLZS3GeMKwoN6FDpu5KhK0e0DQJ6CXy9NCaC7bJaGe97829agmbUkVP6GxbGXU2pgyvoiZwc6G8U6DnFz6mXdglcrMl+TWSX7b2i3KKNWH8gnfSbqMWBHcWobuNTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LhvWfOfnQIsyGM2CNER4k273Un+L1stFJMN9Kzn25M4=;
 b=D6qFGgSmQFD0mbIAPfoX/0EWaoJUjV50vdSL6iXV3N6D8MV8pdDd9UGyHe4UE+odNmwOQi/r46BAiJkb+wXkJv2Hl8IBT77/5VJ+pEht281oENJbFfDhJB5vZH9JgAtKqZ0U1wsvhHNo8b44ixXKDJbSxtEQzPtaIvr0zyeV0JE76qUpocKIOhuy8zgDbQdfOwee5KRLktzR/Yx7DWZBbWqs3ftL8TTb5V1vo/QXtePOLTvyMhUsmwguLgMoQiT26b+/0JpCPNneeuMyU30SV1QIFIil9S5p1wIKYq2L0O1SxQSgSgu89IYAW+CkSC6u0mT1H6O7yUEzTWkZF3GD/w==
Received: from BYAPR07CA0054.namprd07.prod.outlook.com (2603:10b6:a03:60::31)
 by PH7PR12MB6490.namprd12.prod.outlook.com (2603:10b6:510:1f5::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.22; Fri, 7 Jun
 2024 10:21:41 +0000
Received: from SJ1PEPF00002310.namprd03.prod.outlook.com
 (2603:10b6:a03:60:cafe::23) by BYAPR07CA0054.outlook.office365.com
 (2603:10b6:a03:60::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7656.21 via Frontend
 Transport; Fri, 7 Jun 2024 10:21:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ1PEPF00002310.mail.protection.outlook.com (10.167.242.164) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7633.15 via Frontend Transport; Fri, 7 Jun 2024 10:21:41 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 7 Jun 2024
 03:21:27 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 7 Jun 2024
 03:21:26 -0700
Received: from vdi.nvidia.com (10.127.8.14) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server id 15.2.1544.4 via Frontend Transport; Fri, 7 Jun
 2024 03:21:25 -0700
From: Shravan Kumar Ramani <shravankr@nvidia.com>
To: Hans de Goede <hdegoede@redhat.com>, Ilpo Jarvinen
	<ilpo.jarvinen@linux.intel.com>, Vadim Pasternak <vadimp@nvidia.com>, "David
 Thompson" <davthompson@nvidia.com>
CC: Shravan Kumar Ramani <shravankr@nvidia.com>,
	<platform-driver-x86@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 4/4] Documentation/ABI: Add new sysfs fields to sysfs-platform-mellanox-pmc
Date: Fri, 7 Jun 2024 06:21:14 -0400
Message-ID: <ef3f942c1d933ef757a0de84c2890d6779471239.1717755404.git.shravankr@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002310:EE_|PH7PR12MB6490:EE_
X-MS-Office365-Filtering-Correlation-Id: 58ca0e20-a69d-41e4-52d0-08dc86db9f97
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|82310400017|1800799015|376005|36860700004;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?hmB7RQlv4+BVjcW4sMVTS3Ro7L0nPQsfM1JD8q7PhTRRga/SOAVzj+yjQ43z?=
 =?us-ascii?Q?9iZ9xwZJSnhZNTOv1HS1vuYA1cJdjIjgyD0HDdWjN+9u8IAS4XqNUJjVM9Ko?=
 =?us-ascii?Q?ncmh6uKkVHhCF3cVdm4wFFmJYLgB5PAC0aHetW1rZ6KIiTDEXWATLq0ZTFPE?=
 =?us-ascii?Q?azWqO6n9rS3y4C/QyFGY8ZIxNl5mp9kkZvVooMpG2aoTITnDLLjhhx5eCLND?=
 =?us-ascii?Q?XQYG4NpPEohSaTBZUEkiU9aLw0t6qczLCHiKAPYqLk0bzrBI2gFy0YQPUGwS?=
 =?us-ascii?Q?dFTcIdat9RytS/1W9peRTgFKYuyhZj4RjCmOqv3fTZDT2eBte6bTu62wQ6YJ?=
 =?us-ascii?Q?TxhKRAwcuZOYBKLJr1uURHmqr1Y/b+U4M6K9tnwBOG+uUUerMlD/WOdBcK9Z?=
 =?us-ascii?Q?KPaw9Pv9V3p5XR28y2Ouv3cA4z7umI3ofMR48+wnZ7ee40pbtDnik3aHDGDW?=
 =?us-ascii?Q?P0TYk919ChgNXowPO2psBS97TN0kvba+yOF+aS6mxpay/Du6lN9ZguF+gD3d?=
 =?us-ascii?Q?od73B1vnffgqxBVsr+sBY6LmNDtuqswxFhz1Nx0l5XC0Hq6YoJEHeZO82T9y?=
 =?us-ascii?Q?IDqeF+aGB7k/wzUnxQvY3KOhN15DN/+Z9s4I3Pey1qC/TFPgJIXkjWYBvXrv?=
 =?us-ascii?Q?hll6G5dlWlTu5JH5kzarLxqaQkVzSwudxS76L3gVs0kgCrO1PmFkPUYIkd4k?=
 =?us-ascii?Q?3RzcAg3j2fDjkWaOcMD1bC/pvzOxQmHVpvl9ineaLmeE5cmLg1ZcVXfT3Rvu?=
 =?us-ascii?Q?G1yyi2N9v9AGdH2qNM852Jh9+GgBhS6jR6VimOrI+Gr8l3bjUUFiN/RbXcrp?=
 =?us-ascii?Q?MRtzhmjQ/nP6VISNpk/k0JXaG7wsHkgy8BO6HKMEIyPnUMTnPlPKByrMfilK?=
 =?us-ascii?Q?DYTMZP/YTl35NcTOX22HxzLgDjhebgCf0bqn7YOvxbE9qkW4G/ebIX5SsO84?=
 =?us-ascii?Q?nsQcBXq2RyzIL9+SRmXqFNq5qOmCf68YJ28s2TeDZhK2c35HS/vnC/AzWrCd?=
 =?us-ascii?Q?6qTMJ9BTUurE0sp/7AgGIMoVd8lnTwEEbQfnozo32L2vSAzC9KBeeR+zrCbJ?=
 =?us-ascii?Q?WydvPmEqc+NDLB2By1iojPCfpZ+DAV+fRFvMToMosgqiol6242hKrLhDuECy?=
 =?us-ascii?Q?3KhejvJyNUCRrmtcUQWKsTQWNMfCNDR0HJqjXNLY9tpST9YSsBl0qAu+y+vx?=
 =?us-ascii?Q?gxDsQTHTE+n02y09gW3lTadadfjJiqfEhEH4HEn6C1huxEbLm+e6bgH6vYAc?=
 =?us-ascii?Q?6OWdKLI6f0B7OmodtjLt2bACgLsftNDZm1eltYbGaXon9rG6qd7jeiNAyZo6?=
 =?us-ascii?Q?uAmg6UG+QBpgtYHd6TXZyjh+2pf/rr8z6bxnFf1kOyqIljmU4AOkJ688Ehip?=
 =?us-ascii?Q?jZTDiH2oruvmHXsXGA3zYOqClA/0GiA1GyBcZ+3XvcwYLHQ0+g=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(82310400017)(1800799015)(376005)(36860700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2024 10:21:41.2753
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 58ca0e20-a69d-41e4-52d0-08dc86db9f97
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002310.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6490

Document newly added "count_clock" and "use_odd_counter" sysfs entries
for the Mellanox BlueField PMC driver.

Signed-off-by: Shravan Kumar Ramani <shravankr@nvidia.com>
Reviewed-by: David Thompson <davthompson@nvidia.com>
---
 .../ABI/testing/sysfs-platform-mellanox-pmc   | 23 +++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-platform-mellanox-pmc b/Documentation/ABI/testing/sysfs-platform-mellanox-pmc
index 9f987c6410da..ee03d066c0d9 100644
--- a/Documentation/ABI/testing/sysfs-platform-mellanox-pmc
+++ b/Documentation/ABI/testing/sysfs-platform-mellanox-pmc
@@ -52,3 +52,26 @@ Description:
 		Writing 0 to the sysfs will clear the counter, writing any other
 		value is not allowed.
 
+What:		/sys/bus/platform/devices/<HID>/hwmon/hwmonX/<block>/count_clock
+Date:		May 2024
+KernelVersion:	6.10
+Contact:	"Shravan Kumar Ramani <shravankr@nvidia.com>"
+Description:
+		Use a counter for counting cycles. This is used to repurpose/dedicate
+		any of the counters in the block to counting cycles. Each counter is
+		represented by a bit (bit 0 for counter0, bit1 for counter1 and so on)
+		and setting the corresponding bit will reserve that specific counter
+		for counting cycles and override the event<N> setting.
+
+What:		/sys/bus/platform/devices/<HID>/hwmon/hwmonX/<block>/use_odd_counter
+Date:		May 2024
+KernelVersion:	6.10
+Contact:	"Shravan Kumar Ramani <shravankr@nvidia.com>"
+Description:
+		Form 64-bit counter using 2 32-bit counters. This is used to combine
+		2 adjacent counters to form a single 64-bit counter. Each even counter
+		is represented by a bit and setting the bit will join the corresponding
+		even counter with the next (odd) counter. The full 64-bit value can be
+		accessed using the same 2 counter<N> and counter<N+1> sysfs, with each
+		of them holding the lower and upper 32 bits respectively.
+
-- 
2.30.1


