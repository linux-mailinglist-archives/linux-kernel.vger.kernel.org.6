Return-Path: <linux-kernel+bounces-550440-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 422A2A55F97
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 05:40:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2EA1A3A932A
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 04:39:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD0EE18DB1C;
	Fri,  7 Mar 2025 04:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="NBfUxLAf"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2060.outbound.protection.outlook.com [40.107.236.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 443883398B
	for <linux-kernel@vger.kernel.org>; Fri,  7 Mar 2025 04:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741322395; cv=fail; b=JcKK5iaqnhN4UIJO0G4UIN/Op//Ojohotel0XCza+5XzEfobBNA8N5Fb00btZGtsiogkYK9sIiz6TlTDOj80174eX38QDoJc2BPUNvSvjNsyRI7T3tkOH9/SK+1NMBw8/mlGTW8PkXrQgClUf54aHPEcRInBFti13C/u5uIxuPA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741322395; c=relaxed/simple;
	bh=v7R5JPKpIc8+6M3T3nGxM6Y5HNyvXSYcINoP8cxKPO0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=U5DunuvhV9EOUxpae0AfEo3luqA7vbYr2ThNgQg8kTRPprix3B1nhWCZdPM+iLpl6ppKtWyQDP38aE+SvVYVqTyHrrXi7dJovun6azC6rxWvQK3aSKk8jY1WKIAy50bpv18vu+SddSLN9RVz7qSZ8NAJjuIx9sy903a6urulahk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=NBfUxLAf; arc=fail smtp.client-ip=40.107.236.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hpWpHpUdB2rrlNvA31v6CmzK93eUEk3Uqd98s004zCU4ptigW0nwojYHnP59mgrHp1eohaMNqAH5GEmKEE1Y+WWdF5a3F7Sp5Mww5/5zwa8D9bjgNWnLOC4+NvG70heuxb4cE8A4XChlbSeuO1+ElpbgapmktrW5k6REEBlSTpOnLw1jxmD22pz5EFylul4GAg5Ysnk9eSuLI+YoB1BopM/7+c2QXwe62DBTOWt1N/V5SR+YQ34dIUmn6YyOKn/FJEhx15nxWPi3pesYIVNHVzTXn7KbQ9mAesKjx4165XQckyG9TETzmtnsZ4Cxm1iswgSDYLCpJnxwNCHeejzTRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y/ezN40pC5GY9Xr2Fb0sI6XbA8wBSJmnq21icKfSyPw=;
 b=qZHOeHlR2/QjNIXHO5dl7bW/wq2D8wUlc5/PCFzqlIGxYnR/OTmqcGoEc5RQEoSnSURumLTim/LZMBcCFEqyoc5s7jlrZggITi4UgR3QxvIflDM2rI9233L2nheTDkgT35RkXdgT0WB7vlhPKNrkO8eAmsorBsFKldlOdOF6+iZs1Ovkcv7C0BZKqHLRiMrM1IFLHLL+P96pRsXITI7U5sG+sYaTl3UxC4i7q0Cfo4/dh3nEOO2AuOVuHvMjMn/Be396fhGgEEiPNOCCW5J590DiHytudcNS0faow1npwIl/6Hz5vQnG7PmUWblw7oDdoxtJU0/XmBJaHZ5r8jz11w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=goodmis.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y/ezN40pC5GY9Xr2Fb0sI6XbA8wBSJmnq21icKfSyPw=;
 b=NBfUxLAft+9+38Q7vIn6dTfktj8XCUhc6UtIWo308UJheUJZvIx0mXN1Qe29ibeO6nULM05ItNIRNyt4qpz9V28zb966tgVpa1WOEKLozwA0SJEA97YsT0zmGpQv5MhmNskclTGIdBYKC6E7ro7Sem3DuXA3+DAm0IRk3xCQR3Y=
Received: from BL0PR0102CA0009.prod.exchangelabs.com (2603:10b6:207:18::22) by
 LV8PR12MB9271.namprd12.prod.outlook.com (2603:10b6:408:1ff::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.19; Fri, 7 Mar
 2025 04:39:50 +0000
Received: from BN2PEPF00004FBA.namprd04.prod.outlook.com
 (2603:10b6:207:18:cafe::3e) by BL0PR0102CA0009.outlook.office365.com
 (2603:10b6:207:18::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8511.16 via Frontend Transport; Fri,
 7 Mar 2025 04:39:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF00004FBA.mail.protection.outlook.com (10.167.243.180) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8511.15 via Frontend Transport; Fri, 7 Mar 2025 04:39:49 +0000
Received: from dellg853host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 6 Mar
 2025 22:39:48 -0600
From: Ayush Jain <Ayush.jain3@amd.com>
To: <rostedt@goodmis.org>, <warthog9@eaglescrag.net>
CC: <linux-kernel@vger.kernel.org>, <srikanth.aithal@amd.com>,
	<kalpana.shetty@amd.com>, Ayush Jain <Ayush.jain3@amd.com>
Subject: [PATCH v3] ktest: Fix Test Failures Due to Missing LOG_FILE Directories
Date: Fri, 7 Mar 2025 04:38:54 +0000
Message-ID: <20250307043854.2518539-1-Ayush.jain3@amd.com>
X-Mailer: git-send-email 2.34.1
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
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FBA:EE_|LV8PR12MB9271:EE_
X-MS-Office365-Filtering-Correlation-Id: 0e9cfbca-b312-4176-29f4-08dd5d32187a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ReE4oNCBJGoTEwWvggPEe+f6iORkff/nYkn1LOe8jGG7t7lVSC2GE+TkovbE?=
 =?us-ascii?Q?nBmziltt/TfiNtl6RxT51OW8AyutZHwXotVMDy+mt/+qykgeaUQ70cdN31xw?=
 =?us-ascii?Q?a0V3qe/4BEBpAvGCDhnzS7kzLP7LoB4tnxoX6FoxEaTS7EKLgVDQc0Nq+rxU?=
 =?us-ascii?Q?6a8kkjSl1zFpbd/+NhRxdWoFm2hnFh6behBmn0UNBacxFuYamoqtlbTBxTQT?=
 =?us-ascii?Q?daOlKz0WnKBYd906UNQHM+mbakoMUJunRluLd3tD3y8Dv774xZKufk9AAvgV?=
 =?us-ascii?Q?LIHmf70VfITmntI1lA7lS0t9SD2hBf2Ia0/U98JFHrt9S0wUoZgNeRxBpqj8?=
 =?us-ascii?Q?s96SreUm5POYz6pjXbOHAUW3x29dE8kd91WH/80UYxHOBJ/GVmE4yMfCcIvq?=
 =?us-ascii?Q?XwjGtjjGP7B83D6vG/VPSbidD7WaZzc010021w5q6yng+3lRYC9T+s5XVcWh?=
 =?us-ascii?Q?CIuR6KcpoINHrf58yKmWSouzAaqxNk1fDCnHRV8SkooQXhg9j4H4IJthW4H9?=
 =?us-ascii?Q?Skg4bWEAPehj5N1qJ7Ldvok/UEChC3ta1Y9uwfAcnOlzt93pLkoLTWrUTO/y?=
 =?us-ascii?Q?6Ny98nl+m5GewMJ1dVwx5aIv9S7KZ7/wYyQdr9S+KWkqRqE99KIb8Kj3KJ2f?=
 =?us-ascii?Q?7kNW84vBGtPK8ShvYy9uP7kDANmPMoer/vqedKcRkZBJLAzZObNXt+8lWBS2?=
 =?us-ascii?Q?i3ELnVeUcXq1/Tp2mm0uiZzVPW6abITn49l75NBZEhWRKQA8SgqdZyjoR2L1?=
 =?us-ascii?Q?gVh6yBU0bPNxNVXbF1JUx+Gyu2YBpnYaSfjsWWeV25SniHoj8+gepBfM4WF9?=
 =?us-ascii?Q?ZwTx01t0pLQhrz/lRlRqWS3DTpZc+DYhqLMGDg9FNu7PNzRTmlzW1625Ov0Q?=
 =?us-ascii?Q?9DaiwjMoL/2WtdE2mfCp2VEIW1IH6DXdNXxSGUV06CHatSu8YubEFW9C+xpF?=
 =?us-ascii?Q?XOd99J/nmNO9CIJ2Nr/F3C6o0Rfj5jojpKRfVM80JTNXflVYT3DDYTQOeGls?=
 =?us-ascii?Q?Z+KbzsZri+rHpZJ31GdV8bQA1cTV1QbfuTXNUknTWDMMRew1jFe5ameNg0s7?=
 =?us-ascii?Q?xTTtbF93p8bPQVvAwY3eZ96PEsvhr/AEM18rslvqcPNjUPWPFJkGvl8yT9vO?=
 =?us-ascii?Q?9XrwBgzLAjbjzQInIP7eRhaK6rblaA8H3Kne8J4C6GyeNZ23EUaqW1bJdIwn?=
 =?us-ascii?Q?zBcKjY6vc6mlaUY1O6SeONl/5o/OcnRCJLtYokn8h332VvJV59NgVhN9FOBD?=
 =?us-ascii?Q?oKNKiVbA2rlszqJR4uKfa4/M86ACboNoBc58gENaDxx7UoWAggg0ZqYoeuyV?=
 =?us-ascii?Q?2J3nIuS5aB9BJk27bP9tO0IbEF3+wEMS2QWhrGQGFaR7RiKhYjXY7qhpIpHF?=
 =?us-ascii?Q?jRlkaf7PnFd1qg+saVc/zH3DJG0McTfcx3TFksvSPJS+5XOSqxyX4N4oqEMQ?=
 =?us-ascii?Q?Th76B1P6d4JnML9MiC3w71jVkGPl4gPcH7Xm1mpawdzwmXQA93WdPNT3Vtcz?=
 =?us-ascii?Q?iH1e43FfouaGjNM=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2025 04:39:49.6416
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e9cfbca-b312-4176-29f4-08dd5d32187a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF00004FBA.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9271

Handle missing parent directories for LOG_FILE path to prevent test
failures. If the parent directories don't exist, create them to ensure
the tests proceed successfully.

Signed-off-by: Ayush Jain <Ayush.jain3@amd.com>
---
 tools/testing/ktest/ktest.pl | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/tools/testing/ktest/ktest.pl b/tools/testing/ktest/ktest.pl
index 8c8da966c641..a5f7fdd0c1fb 100755
--- a/tools/testing/ktest/ktest.pl
+++ b/tools/testing/ktest/ktest.pl
@@ -4303,6 +4303,14 @@ if (defined($opt{"LOG_FILE"})) {
     if ($opt{"CLEAR_LOG"}) {
 	unlink $opt{"LOG_FILE"};
     }
+
+    if (! -e $opt{"LOG_FILE"} && $opt{"LOG_FILE"} =~ m,^(.*/),) {
+        my $dir = $1;
+        if (! -d $dir) {
+            mkpath($dir) or die "Failed to create directories '$dir': $!";
+            print "\nThe log directory $dir did not exist, so it was created.\n";
+        }
+    }
     open(LOG, ">> $opt{LOG_FILE}") or die "Can't write to $opt{LOG_FILE}";
     LOG->autoflush(1);
 }
-- 
2.34.1


