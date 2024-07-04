Return-Path: <linux-kernel+bounces-240934-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CF3469274C8
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 13:17:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 58C0C1F21436
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 11:17:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8170E1ACE64;
	Thu,  4 Jul 2024 11:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="VEduwK0w"
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2043.outbound.protection.outlook.com [40.107.212.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05B921AC239;
	Thu,  4 Jul 2024 11:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720091842; cv=fail; b=Ohw/KFocT+I+ZcuvDeRV6NwI9s3sfbnilKgwLJ7zZQFKW8h9yZHeAT+H/PlXbRY8pjQcLSVddWaGIigCw7yb6xJtR4IUmXYXtudjvCRWZgDW97v6mZNQYUccYlVDSmG54XvU2KM2eBDLp/Kh4EGjpnAEx6unTYr6mvU+91+xbnY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720091842; c=relaxed/simple;
	bh=bDm2eHGu41dBL3E9XGAQtjIImxSSfeRSjlDtn0B0NQk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DjYic5E0fhq/ZdXnLcdgddsMjf3YdUkKWg2+GQGbBnRETkIcPSSoIn+KEmuZ7BtHTxVXpJNbE0rxM+VxjgmBAj+bFd6hTuRxmkVv10JR5SzKxt5xXGaYYj7L6ZbzymntNEHfVa0mAd2d+UnGVX+t5wEoTuAJFBc1QrKDqWf08Lk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=VEduwK0w; arc=fail smtp.client-ip=40.107.212.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dAi1GciATgVwu0hVfhti3bViOmRlFZEm7ADAIJh2lQSf8Fn8PaS4ujWlPAsMVqsRLTtX7qdI/uT5/0LA1cEhBkjqNfz7nge+VMSjt4pfWa3WgwS9ThkVzZ+XyWS3VWATvBZE3qDtna0LU7W7jet17YlQifxTdk/ZcBxoNjKIfsXtcUUM9+sSZF8o85aHgdXZ7xAbmnoHWmTIjNm0wZo+jiGk/hTsU27JOsP8gTkl2n4/pzaRWUidbQtqbmqoDW2puWRRxUsLG0OucxU9snVOrnPFWBLCKpahJSN2U91Uz6zEtjqBAhS3Ld8wzH2B41frllgqZReVxg4mCK6F4NFP7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zi7ASdHE7n3FnM018yPhb0oYrehFJ1BbtVpBL90/Qo0=;
 b=iV9prymR4B/jlprZa4FiPz2KgZO9YarnKulsAfiVuGr+HSvigOb8PcSmGfSpIssYDc7l5cwqFTCc9VJDqcPe0U5qEsZyc3v4kF0tKYDqZOe5BhlgsLPpSW5p58TIpV21BCY43NnPsBnyCDozbfaJwjzZcX4KtJWjh5Ak3PszEMWAddyz56mCnFAy7J7NTTNhquKg/8YEJdtvmJV8/UOv+/6SfsqzR/seSiTk9eDEjJbtI3R2LwuHWjMjN9CbAMVn0M8AKu1hOVXbIXNfK/qXo++o+Zd2Jx9BKkYzqt1jjeEcgzPCOA31NdVM9xxrSxibkWdsmA5u/4lbLMIomv4rtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zi7ASdHE7n3FnM018yPhb0oYrehFJ1BbtVpBL90/Qo0=;
 b=VEduwK0w+LS/ESIhCFXnXKEUUJeC+Zj/gDV5kzIb1g1se2B0lBtT4ris07pkY5f7wzOx5b13NcehEtab9r8l0b6lC79k2HfPTTlBKJwww6DhNYwvsWYW7/Rh/7cEVfik0prHbC6m4dct9jypOeKIZM8sH3lWrJ0Rs+m8fugsy8U=
Received: from CH0PR04CA0023.namprd04.prod.outlook.com (2603:10b6:610:76::28)
 by PH0PR12MB7011.namprd12.prod.outlook.com (2603:10b6:510:21c::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.32; Thu, 4 Jul
 2024 11:17:17 +0000
Received: from DS2PEPF0000343B.namprd02.prod.outlook.com
 (2603:10b6:610:76:cafe::af) by CH0PR04CA0023.outlook.office365.com
 (2603:10b6:610:76::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.29 via Frontend
 Transport; Thu, 4 Jul 2024 11:17:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF0000343B.mail.protection.outlook.com (10.167.18.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7741.18 via Frontend Transport; Thu, 4 Jul 2024 11:17:16 +0000
Received: from amd.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 4 Jul
 2024 06:17:13 -0500
From: Akshay Gupta <akshay.gupta@amd.com>
To: <linux-hwmon@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux@roeck-us.net>, <gregkh@linuxfoundation.org>, <arnd@arndb.de>
CC: <naveenkrishna.chatradhi@amd.com>, Akshay Gupta <akshay.gupta@amd.com>
Subject: [PATCH 4/6] misc: sbrmi: Clear sbrmi status register bit SwAlertSts
Date: Thu, 4 Jul 2024 11:16:22 +0000
Message-ID: <20240704111624.1583460-5-akshay.gupta@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240704111624.1583460-1-akshay.gupta@amd.com>
References: <20240704111624.1583460-1-akshay.gupta@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS2PEPF0000343B:EE_|PH0PR12MB7011:EE_
X-MS-Office365-Filtering-Correlation-Id: 1ee42336-6c7d-4c06-04ee-08dc9c1adcbc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?WQs0DNvOsGkrztYNphaVuFy7Cha7JrXD4lY338Hj4Djf45vbYMIaXOOKDaBm?=
 =?us-ascii?Q?Mcte7SO1kJYRvQh4NivOchn4S0JtxzAeniyypVmTqCswz5ntF4TNrNjlhjfs?=
 =?us-ascii?Q?7EBFyhyLJBsBWdzZdVAPySba9Ub9pRmP2bbfNrtPuFD8R3k3Xm1pJUvNnxPH?=
 =?us-ascii?Q?ajMndz5wx76oIPV8F6A4IwHUG4CMJdNCNH0jC1hSyRt5pvBgi5xYXmKQ6gzm?=
 =?us-ascii?Q?oAygEikI9uXfBxR9ngIVA5tj1DzjqMejcfyDGQRoiHIMFFbr99xDsojLdltS?=
 =?us-ascii?Q?J6LVtp3Jf/uoHqo9uQM5CJqzG+N6hx1B65M9eHc1gXs6gkwUyJXKFTXkg6I8?=
 =?us-ascii?Q?0SMnDQOBm6G8arPUkTGx81OYzCfdR+Nuu5LTBuOzBWjMtvFRKBU4GDXnpsJO?=
 =?us-ascii?Q?SdGwbH8hP+DOIbuhySl4omra9JD/hRiXUqOwJHmR1N18YFQRqFFiJVpaiGKI?=
 =?us-ascii?Q?69RVUunfMjx0aiLcdKNhzKdG4wZcykRRT2NnQLC1Xt57D7MfeOzc/6kmFUO7?=
 =?us-ascii?Q?Aez2zU6zhPzHSZoM1Ft0/2R45ASH5+/VPjNrb74j2f0mE4JRYPeFNA7WqTdL?=
 =?us-ascii?Q?SX8lwPaaNhlJ7wq55qc1l+Y5cqbNmV+9bttbvT8hz8cDAXFc1lOEPIU4ZyoS?=
 =?us-ascii?Q?SsVgLPdEk5pqGruBqocyAlCDV+iOHoeE87z4oACDvg9mVwsrsI01e32nbmZR?=
 =?us-ascii?Q?q/JMf34UQf76Gzv0wnkki/DAdT1qA1wZqATlSNFkqq6BpW3oMvAzSQs+8PR1?=
 =?us-ascii?Q?tX4i6WDHRJKAJ5Q4ChZANJT+RsYSsoh+zx0W1QqkWHuGeS1ZbX7aOwyFYGO6?=
 =?us-ascii?Q?BpYS7HwoZ3KEGcjvhB7+Gv92U6TTXw3kRrYusHb4PZyxaUeJJym8JEJ9N7Ti?=
 =?us-ascii?Q?vXKnHYyMq3aFvaTHWjjWh42wE25GPJ6vtogB2XriD+AZOnUx5r02AD087CZC?=
 =?us-ascii?Q?IectVF8BNmyXbKV8EySTLdCOCaVoP4KvThqK/1NPd3aho4HjfeMKj5vOiC2K?=
 =?us-ascii?Q?o4y72qwKKKcqf0kv0G8v5yBOBu6VfJLXIQB2IQsjHsYIZutiZBlID/AJn6Fo?=
 =?us-ascii?Q?cH8yFiMQUOhmfOpk4dbaz8eksM3EOoSV0NQH/4pxeXFNO6VZXwGwR2Ss/thQ?=
 =?us-ascii?Q?GDr5gIe8ndrCTaSOYQ2RhLUZx5GjWuPKKVXNy2rHYoYpFWsmOlf0ipdd9vdw?=
 =?us-ascii?Q?JuxZk5jI+r8KvPtNgOjHzQmc0L7v9pgYEaHm8L+/GsgvSLHy+OnYoseWxp9U?=
 =?us-ascii?Q?ukVxNvxikH9qNbUuBwJM3/bIJmsrzl3W9j/Z1P5T/cYY0MVs5mQ6kRnxXQwb?=
 =?us-ascii?Q?n9dd/H3wzJO+acCszmxPbt4OhPnkdPAgE5vUU6uJZriFJSKxyF34IXBMR1bb?=
 =?us-ascii?Q?3VcqX5Nk1jnSp7g1GajFwVwxWi6ZW0IcVirdKosH+f05Oq3NGu2+0mXFetPa?=
 =?us-ascii?Q?sXoi+t2oo+3+UN5chOrL+jmBR5+158fZ?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2024 11:17:16.5222
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ee42336-6c7d-4c06-04ee-08dc9c1adcbc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF0000343B.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7011

- SBRMI register status b1' SwAlertSts sets in below conditions
  - Completion of Mailbox command
  - syncflood event
If the bit is set for syncfllod event, it may be interpretted as
mailbox command compleition. This patch clears the bit before
start of mailbox protocol.

Signed-off-by: Akshay Gupta <akshay.gupta@amd.com>
Reviewed-by: Naveen Krishna Chatradhi <naveenkrishna.chatradhi@amd.com>
---
 drivers/misc/amd-sb/sbrmi-core.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/misc/amd-sb/sbrmi-core.c b/drivers/misc/amd-sb/sbrmi-core.c
index b2437a4044ac..e528b7314447 100644
--- a/drivers/misc/amd-sb/sbrmi-core.c
+++ b/drivers/misc/amd-sb/sbrmi-core.c
@@ -42,6 +42,22 @@ enum sbrmi_reg {
 	SBRMI_SW_INTERRUPT,
 };
 
+static int sbrmi_clear_status_alert(struct sbrmi_data *data)
+{
+	int sw_status, ret;
+
+	ret = regmap_read(data->regmap, SBRMI_STATUS,
+			  &sw_status);
+	if (ret < 0)
+		return ret;
+
+	if (!(sw_status & SW_ALERT_MASK))
+		return 0;
+
+	return regmap_write(data->regmap, SBRMI_STATUS,
+			    SW_ALERT_MASK);
+}
+
 int rmi_mailbox_xfer(struct sbrmi_data *data,
 		     struct sbrmi_mailbox_msg *msg)
 {
@@ -52,6 +68,10 @@ int rmi_mailbox_xfer(struct sbrmi_data *data,
 
 	mutex_lock(&data->lock);
 
+	ret = sbrmi_clear_status_alert(data);
+	if (ret < 0)
+		goto exit_unlock;
+
 	/* Indicate firmware a command is to be serviced */
 	ret = regmap_write(data->regmap, SBRMI_INBNDMSG7, START_CMD);
 	if (ret < 0)
-- 
2.25.1


