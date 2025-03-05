Return-Path: <linux-kernel+bounces-546075-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BD0CA4F606
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 05:19:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD19616D713
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 04:19:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B5151B4248;
	Wed,  5 Mar 2025 04:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="5aUQaIm2"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2073.outbound.protection.outlook.com [40.107.236.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E637B19258E
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 04:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741148380; cv=fail; b=DspPQMLc5/PeNBbJ6rzIKAiIZowI3HO7ImHvK47azjK9VqIdvHBBMkjPVzOQ39wi6aS27//tXwkV/zrXv1E81jyDOh0UCm/R9C/2OmSCepVNHyTDq/GfB6UwmA5MBso15ky6fkewPDa2YB4ImDWr4PNJXW/RrvbQl0ebv6K1CoE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741148380; c=relaxed/simple;
	bh=g/wgbW6K21H5sWxCn4vnwySsFZ4Uu5ei6I8LVda3QVc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=t59K9iOmtFOFhQVAMApWRMf3hnO/FKcSg3HghJYStAe8AIUqc+B38MQqO8kc0ke5I0NVw4BdcLbiASF9phoJ2zxwqxdbVouUWAfLl3Mt4L8oOHZ4oW2rZLCtky2TsXgX/rFGmvuoy2zdbOqK/XW/85x2ShI8I1qzAA58vXMP6Bo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=5aUQaIm2; arc=fail smtp.client-ip=40.107.236.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P5z5oijxBiE3BFRBLezjkL1t1UrkKatWnbKr8dohnksa8pmYJ62+s57dYesiSku7sBO4Ux/iM7wUV91zBJZK4iU6daigcZ4NT44GltDELB5MYPCxIEL8iSCSd+pxsM5dtx1dZTGE1yw9MzlNTUV23reuJObKk30pvt0ygEsuytuSkpVn5BBMS0keZtszqfr8VW/Ysx7diVTjDMH328oPK+Wpdkrn4TCRnEhPV7oKbW5D4My8qddvJ/p1/qphO44QKp8p3MBFPhttb63M8mWLXIac8ivfrnCaPyA1pt8orxpyQ3zY8/0bVSLEgE7/NgpqzMLcc+ZEcEMbhGJEPs2JMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TVMM09LKf+OCIFADXGkiHcNwrx9DEMTZFTVBp63OdwA=;
 b=TTDX7n/IynZTAiEeGEjAP6qMLoKf6XZsf7siTaopVuatw2EYEDtHug8NkIZqhlz/fb/QJqFxUAUrGEjOcXNQlTVTdTR7bzXGAKDU+cr/hKrsKKa8xJvMGgkIdghLoFmaHXpaP3c5TxoKzNnpOBMLqhpBk2zVfq9rFXrJjbMCIJCrkixWaUmHL5SJgwXByD4KKuut5buarv4YhXWpZVFv8uX8jJv1ENFNQHd+GmIibyNnWqjsdyRqbyE60zgYEHtW5VWXHH081OKibT582CYGEreFJyoWm3YqZkOdI/kOwXf53gg46CoVALkegdpxlRfIIhopqIxAxk8HOR/SGIS3rQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=goodmis.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TVMM09LKf+OCIFADXGkiHcNwrx9DEMTZFTVBp63OdwA=;
 b=5aUQaIm2xE29lkxBlHDUZyxUzWG5RCi+ycB0rq3SP4/9z6rH/sbScA0iVVgpWm0sbbiw9twq8OaR9RuF2hSBn8Ly1QKJFxndgCh3bV9PMC8MhscicgIKdC0lKvOYrRYp9C88CbyVfcDUvQWQOqe4vmyWPyjTVuikbdlfu7dlYUU=
Received: from MN2PR06CA0009.namprd06.prod.outlook.com (2603:10b6:208:23d::14)
 by PH7PR12MB6665.namprd12.prod.outlook.com (2603:10b6:510:1a7::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.17; Wed, 5 Mar
 2025 04:19:35 +0000
Received: from BN1PEPF00004682.namprd03.prod.outlook.com
 (2603:10b6:208:23d:cafe::4) by MN2PR06CA0009.outlook.office365.com
 (2603:10b6:208:23d::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8511.18 via Frontend Transport; Wed,
 5 Mar 2025 04:19:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN1PEPF00004682.mail.protection.outlook.com (10.167.243.88) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8511.15 via Frontend Transport; Wed, 5 Mar 2025 04:19:34 +0000
Received: from dellg853host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 4 Mar
 2025 22:19:33 -0600
From: Ayush Jain <Ayush.jain3@amd.com>
To: <rostedt@goodmis.org>, <warthog9@eaglescrag.net>
CC: <linux-kernel@vger.kernel.org>, <srikanth.aithal@amd.com>,
	<kalpana.shetty@amd.com>, Ayush Jain <Ayush.jain3@amd.com>
Subject: [PATCH v2] ktest: Fix Test Failures Due to Missing LOG_FILE Directories
Date: Wed, 5 Mar 2025 04:19:13 +0000
Message-ID: <20250305041913.1720599-1-Ayush.jain3@amd.com>
X-Mailer: git-send-email 2.34.1
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
X-MS-TrafficTypeDiagnostic: BN1PEPF00004682:EE_|PH7PR12MB6665:EE_
X-MS-Office365-Filtering-Correlation-Id: 50a03494-153b-41f8-8e03-08dd5b9cef9b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700013|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?3dVfgko/D2Ljs5msJT6urVQtEu9reFoTvx0NBNe1gisfkdDAlcoIXYnXA8lR?=
 =?us-ascii?Q?7z7PA/uCigZhwlzTDyvqX9OvYp1aAZm04r0g0Ral1mCtAttWeX73I0NNS9oK?=
 =?us-ascii?Q?QjbrAIhE5pJBy/bLPUbt+aFlCgYkDzivmyzfi7SYMBHY91jxP7uQ4RfaLFP9?=
 =?us-ascii?Q?4GCWKISoQPeFaLuV/jfKhbdg1er+pLnFyqOW7lpo9t73A1mRuyOhbb6NvKpX?=
 =?us-ascii?Q?+iPC+t+AxwHrPcK/sKzEtAGN1YEH7gHtgrqs+YtU/vKRMiE5i8C68EEUDWnf?=
 =?us-ascii?Q?UQRjMuTKC0w1tuyx6TZC1QvlEwMmG9SbSLt/HYzqe+prmKIzFKI5R1HyDkFh?=
 =?us-ascii?Q?vkxTgkdqFBq0MK2zPjFr27rFieUEMchsrQJqog5aLl6hQ83/QiKxNOSg+Cvz?=
 =?us-ascii?Q?CfifleyzjonULEfD3/P5iYARHOCa3TkpvjyAE5pCbzM7K2o6nnpoc59F0JSA?=
 =?us-ascii?Q?Ng0PCS5TZjF3TwbYS19adlHZmsjeitYvI9JzXhzIWFsFzuvUqVmLEQvbedDu?=
 =?us-ascii?Q?n2NsH85X+6K3p6PBxs8fial1fTdyg3EWn+QG/pmDIwJQsZbJPG/kzGaJDOUq?=
 =?us-ascii?Q?X02T2TyYpLlXNThp+A25OxtgWJohNxPmxRc3nOywoTpAFt/2w5fs83A/Gtln?=
 =?us-ascii?Q?7aWShjkRUbWaYUQvCMnPIBQIAHwJ90QtdD/vfjRfgH3/zW5DN92Y5BQHNcB4?=
 =?us-ascii?Q?3PS+SpZmH0TgVUCtLCahrKDWKdBz2jOtPDihYYueF+ad3ak5VS/KXJfbIWgt?=
 =?us-ascii?Q?/DWG6Ioyr/ao73UgdHG7qaWvJGrZQbu1RUhMCqqcqxoGegTLiCaqaKD4z/78?=
 =?us-ascii?Q?njNN/b7jVdaBz8tuJ22c2625URm76drX7EuDxo4PwPLLb6zshA53NLMDJ+Re?=
 =?us-ascii?Q?6VGcJCpC8ir15jEtJ5r2TD7vfWyj6aHSeqsBtqKPA4dWzLN073vmd6jVC6nK?=
 =?us-ascii?Q?S4fFopjQLEWnWIWj/F+2EMoBster0LSBwTTzbJkjYuoMuuP4AHGBAqiPSITm?=
 =?us-ascii?Q?fMcCcdzTG6SKqcDYeEUZXKBOa5qTEYUourvkhFgQZeB6NT24ADE9Tuh3LUqE?=
 =?us-ascii?Q?qHZ9qA7o81CgrbUgoE6AudSg3V1Wp53ERdpggn377l4R9Q2RuKS5pqMnFvze?=
 =?us-ascii?Q?BgsHXEagut0Vceb03qCXp64F8HpIUaszdZGcsMk5JbuAhFTrXcEznFAClPV1?=
 =?us-ascii?Q?NQFcdTNmkC6lyj3Z3GCg5OOj+LUgm0pUrYJAzEIyuwsxRMPo7LJ1rKPx6di9?=
 =?us-ascii?Q?53qsB8MDZMKWy9HYqbYHbFK4m5lTPRSt4uaTqfjA2CoyDnWIU4HqYi3IlWQk?=
 =?us-ascii?Q?x2eH/3ONwXunJbPyAcHNPid7+TN7rd/C6edw0/NGcR7G1yEqdN8fdaIAy1be?=
 =?us-ascii?Q?la59A47sjOl00dvC8O65akfknCuJkYD6thfu0t1v8Zit5W69tns5By6GLI7c?=
 =?us-ascii?Q?aFe9LQ4mGMudmOywlJyxOaHFh2hQtB2gHaqP0GYWMymXKWDvGwlnQo7uDlSy?=
 =?us-ascii?Q?zNN89rZcW50kP6o=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2025 04:19:34.8984
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 50a03494-153b-41f8-8e03-08dd5b9cef9b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00004682.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6665

Handle missing parent directories for LOG_FILE path to prevent test
failures. If the parent directories don't exist, create them to ensure
the tests proceed successfully.

Signed-off-by: Ayush Jain <Ayush.jain3@amd.com>
---
v1..v2:
 https://lore.kernel.org/all/20250128051427.405808-1-Ayush.jain3@amd.com/
 - Update logic to check for LOG_FILE existence (steven)
---
 tools/testing/ktest/ktest.pl | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/tools/testing/ktest/ktest.pl b/tools/testing/ktest/ktest.pl
index 8c8da966c641..13b97e6b8459 100755
--- a/tools/testing/ktest/ktest.pl
+++ b/tools/testing/ktest/ktest.pl
@@ -4303,6 +4303,14 @@ if (defined($opt{"LOG_FILE"})) {
     if ($opt{"CLEAR_LOG"}) {
 	unlink $opt{"LOG_FILE"};
     }
+
+	if (! -e $opt{"LOG_FILE"} && $opt{"LOG_FILE"} =~ m,^(.*/),) {
+	my $dir = $1;
+	if (! -d $dir) {
+	mkpath($dir) or die "Failed to create directories '$dir': $!";
+	print "\nThe log directory $dir did not exist, so it was created.\n";
+	}
+	}
     open(LOG, ">> $opt{LOG_FILE}") or die "Can't write to $opt{LOG_FILE}";
     LOG->autoflush(1);
 }
-- 
2.34.1


