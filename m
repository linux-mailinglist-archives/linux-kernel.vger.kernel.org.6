Return-Path: <linux-kernel+bounces-286221-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 83B44951834
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 12:01:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 39EEE284111
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 10:01:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F0911AE876;
	Wed, 14 Aug 2024 10:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="FpWlzW8a"
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2048.outbound.protection.outlook.com [40.107.243.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 053C31AD9D4;
	Wed, 14 Aug 2024 10:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723629648; cv=fail; b=emDjiiHLoZS9JyE7Vvzcuzavpy1nVVp/0qPoxojUOS35Q3YR4J/+F9wMsAugi/5A8XpYirz6EiejBRKzEd8Qtc9Wqz3I9/2t2oLq6l93qd5DRR8OuDfoQIuXAATVX6ewa1eKBio2TWeSzPhWrxs/C/fhWYwUOdyj1U1U/HIjsdM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723629648; c=relaxed/simple;
	bh=/PdeybAOlU+rLjQb4B/6p+ZW4cwvv50/Vj2sIIEn4WU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ad9CdGvqt/pGRfNk0RU6V+yc6xouH8GVkc5Klr4TIK8zCWaA33uwZJKiEx2HBIkzzwM72WYgYTVOf98GxKxGJ6c4uhd2UvsNjAgVYKEHzXGVPlmAjS7OIFUv4812y9sBwX7gbjtpY1y40isci+keHEtM6X0ymoZK9er8iM5c9xY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=FpWlzW8a; arc=fail smtp.client-ip=40.107.243.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x3EhTF7E2WaqBhRonz2lu6b3BUiqfZdqMH2xY+/8C1E5060CFVFdU2osc21KTD7kq5mPQyMBPIixYtGNl/mL8LHEMnPt60u/zd7L4fUKxB5cm6TAyUfD0TSZnNnrqnkQz1Gge5tygTgpwjm7dOOqK4EyZeDhKTXf/el1GALmgKRUWKRXgKYJsmZMEEtqxmcD6QDweZOAjgwsvGAJUyeMAxpEKTvvnppiWBebWt0HfcW48FEBRdezwKTOS9nv41ZNLF/m+ZzuvO/4nq1V5O3p5TC2Om+sGeMPgCLSOrDG4cydaF5EtUZxrBFxhBuKIgOnezx/M8LmrpeWIEx8XoEY6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xNkVFQkP0h8U20a72RYPm4dRRJYk9LWpWeNot/K8fCs=;
 b=uDW1VihL72y4BHfdzKGGwljUT4u7hBm6V6b6vWx1bipQsAzPkg5XfRx7IYvlGnBhY9706h1OiWPlPUdDikpCkwiRzbGI7KwrRcKvLaCMOoUYJG+CrliSbQ6Yk7Wfqg5Q/D6iUiI58Dyak1s0rCGehaBgFbNp7S8Q+U5aCnixb1UmlJM5WqKE+pfMWKbCtDz4+UDCXu4fFjobV4dqZGq38PyamhGCSKZL9imVebRVhKkpdT/LL1hGRq6wXN+zoW1aVB1UtIGjslPpX9wWWmJkTOttPJmWG7d82JySsRZLn28xp4HzjUq9AUZhdS1LIBhGi/UleKM1VVAbIRDAESd9pw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xNkVFQkP0h8U20a72RYPm4dRRJYk9LWpWeNot/K8fCs=;
 b=FpWlzW8aJlnZnvYbUn04XiW46UwiNjOgoLdCmAjL3nTIEDNzaGfU5aoZkwzusyx5y/9Pnu0ViESKRPe/dTkPyi3oEJUkiKmfuNrb+A6YRnPfWIyfp9VMV0z/bTNhhsv7i3F7dk2ffzzxqWKURTrgLUAlk8xevnm66tArdwf8tQU=
Received: from CH5PR05CA0006.namprd05.prod.outlook.com (2603:10b6:610:1f0::11)
 by CH2PR12MB4037.namprd12.prod.outlook.com (2603:10b6:610:7a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.22; Wed, 14 Aug
 2024 10:00:43 +0000
Received: from CH2PEPF00000141.namprd02.prod.outlook.com
 (2603:10b6:610:1f0:cafe::da) by CH5PR05CA0006.outlook.office365.com
 (2603:10b6:610:1f0::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.16 via Frontend
 Transport; Wed, 14 Aug 2024 10:00:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF00000141.mail.protection.outlook.com (10.167.244.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7849.8 via Frontend Transport; Wed, 14 Aug 2024 10:00:43 +0000
Received: from amd.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 14 Aug
 2024 05:00:41 -0500
From: Akshay Gupta <akshay.gupta@amd.com>
To: <linux-hwmon@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <linux@roeck-us.net>, <gregkh@linuxfoundation.org>, <arnd@arndb.de>,
	<naveenkrishna.chatradhi@amd.com>, Akshay Gupta <akshay.gupta@amd.com>
Subject: [PATCH v3 7/8] misc: amd-sbi: Add supoort for register xfer
Date: Wed, 14 Aug 2024 09:59:52 +0000
Message-ID: <20240814095954.2359863-8-akshay.gupta@amd.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240814095954.2359863-1-akshay.gupta@amd.com>
References: <20240814095954.2359863-1-akshay.gupta@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF00000141:EE_|CH2PR12MB4037:EE_
X-MS-Office365-Filtering-Correlation-Id: 1c6ad9b8-2ab9-4572-8fe1-08dcbc47f627
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?FBJraGkoRZjAgLuGunHK2BSJ1rKzm/r8bAkgoCAs17Zr1xNMh6pK/xr4+XYl?=
 =?us-ascii?Q?koGeudur/KEFPaop/ZhppZ3z4VUTCJgrMFbw2D93IrYCQoo9/ITxaemEZX/q?=
 =?us-ascii?Q?uRq8407Fvwmdi6p2Gc7TIfpQn0UE38zMhgdfmQZUN384v7buHI2HEPCcw36p?=
 =?us-ascii?Q?4G03mFbzoZUEFlgRMqeCtbAAGNntIZ+EPYYOKIrhoOu5sTa98wEwsiEZsrma?=
 =?us-ascii?Q?Jt2vrFNkqYw55ha65mgNn9m+7nzzOxjE/OGlCFoFrV5WuoMmFTJ01elVb1TY?=
 =?us-ascii?Q?l2VUT0L9IVVM90uDCzWj4AbIRBzAPpyJ9tVvoO6v3VdoobAidM/t2Cw3b1Vz?=
 =?us-ascii?Q?dKe2Qh5wVi01h2ZhMqEPVip369Kp4VvA1G76NShU8HGzcEK1+ISIdzwz8roP?=
 =?us-ascii?Q?ogaGTiTfVpI/gfcCePIBePO4FRaMJb27T+V/1xgCv79h4T5LxBNrRQAnxJTo?=
 =?us-ascii?Q?18IdgPzBtNLKF4OMePBkwzqbUc5TslZzPw6VqidPGrQLWYRKk1ZQBqX3xONm?=
 =?us-ascii?Q?nTdrixVfWRKb016EFhTReaMM3gfc55wnqLnMsIAy/dH/B7T6bU5nXRNUQXFD?=
 =?us-ascii?Q?wUOdrG+aNrzRKqyilwosinn8bGmxv6zyziN99mIIORFuxUb16Iq/veIOmrZn?=
 =?us-ascii?Q?DB6wjgMGqzNscxqsPKF8JhErTPc3RpAsC50asBetjxlH5zbhm+ZvF+Lfnito?=
 =?us-ascii?Q?dB9oqMHbKhJtqZ5thPDCkf6+WpFpvg5pwQaGmR2y47uiGvjrUkfHfIG8vcD1?=
 =?us-ascii?Q?ICmmKjso5vL+RFNlTxaZqcglu3k8zj/ZJENElMMFFe9H2ehP9EUIkWowXYwx?=
 =?us-ascii?Q?vLcqTcJ8gPPHTYrqy+A0UZtsBW1fSW2BQ56lo7YxopAWlvhLt1K5wzIsdEWG?=
 =?us-ascii?Q?xu7WwUr7VBcyN5xAx+V8ggh2iaHoJtFEp3Qm6IUWOdDeXo/bs7uIYYPhTiIY?=
 =?us-ascii?Q?Y71mypICTrziswo14veP4ydGyUCJg0odaMV12hevuawhKPhBq0l8CYXw3dMq?=
 =?us-ascii?Q?tQwHzWSxu4+oBwOfiUCUut8ilW+xNd5W3AhFVYENJv/j6RdEHm28vyDlyNy0?=
 =?us-ascii?Q?oVLE9lh5TYs6iICwlzUQ04wlm4PDsY9JWmmJ9mtQC12onYIlQU4bG6C6Ik/G?=
 =?us-ascii?Q?0MPzH5sgCIdYi7cEmVVkF400ML4qES2/8Lb1+sgFF71fj+PDnqV5w6WEGgWn?=
 =?us-ascii?Q?h2/A2QbFVrG7P91kaqdf9rpGmA/tU1N5p3c3kq/VKPyhuqBc128ttQC+Qjj3?=
 =?us-ascii?Q?9alvslPsOaQE7PK4dfIDZBHjcNiGAxTVeUsMnjr+AUp+i8Ko/7fSEXZS3M0B?=
 =?us-ascii?Q?l6S3snV9uLvcSCxlcWAqIyWHOLciR5zkWVIENrN7Pn0Cx5lCIZwyqVYdglo1?=
 =?us-ascii?Q?bVyuFN4ho4fNGiE9YwwPIrs68YsJ4FtytpUdOXvdrRRyGcyrwD2qIMKPwaLJ?=
 =?us-ascii?Q?TFOzAvRfGfrbmezUoL6XtElNr8sXbH/1?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2024 10:00:43.7474
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c6ad9b8-2ab9-4572-8fe1-08dcbc47f627
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF00000141.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4037

- Provide user register access over IOCTL.
  Both register read and write are supported.
- APML interface does not provide a syncronysation method. By defining,
  a register access path, we use APML modules and library for
  all APML transactions. Without having to use external tools such as
  i2c-tools, which may cause race conditions.

Signed-off-by: Akshay Gupta <akshay.gupta@amd.com>
Reviewed-by: Naveen Krishna Chatradhi <naveenkrishna.chatradhi@amd.com>
---
Changes since v2:
- update the MACROS name as per feedback

Changes since v1:
- bifurcated from previous patch 5

 drivers/misc/amd-sbi/rmi-core.c | 22 ++++++++++++++++++++++
 include/uapi/misc/amd-apml.h    |  3 +++
 2 files changed, 25 insertions(+)

diff --git a/drivers/misc/amd-sbi/rmi-core.c b/drivers/misc/amd-sbi/rmi-core.c
index 56fe09e1e54c..d5159a53c18b 100644
--- a/drivers/misc/amd-sbi/rmi-core.c
+++ b/drivers/misc/amd-sbi/rmi-core.c
@@ -374,6 +374,24 @@ int rmi_mailbox_xfer(struct sbrmi_data *data,
 	return ret;
 }
 
+static int rmi_register_xfer(struct sbrmi_data *data,
+			     struct apml_message *msg)
+{
+	int ret;
+
+	mutex_lock(&data->lock);
+	if (msg->data_in.reg_in[AMD_SBI_RD_FLAG_INDEX])
+		ret = regmap_read(data->regmap,
+				  msg->data_in.reg_in[AMD_SBI_REG_OFF_INDEX],
+				  &msg->data_out.mb_out[AMD_SBI_RD_WR_DATA_INDEX]);
+	else
+		ret = regmap_write(data->regmap,
+				   msg->data_in.reg_in[AMD_SBI_REG_OFF_INDEX],
+				   msg->data_in.reg_in[AMD_SBI_REG_VAL_INDEX]);
+	mutex_unlock(&data->lock);
+	return ret;
+}
+
 static long sbrmi_ioctl(struct file *fp, unsigned int cmd, unsigned long arg)
 {
 	int __user *arguser = (int  __user *)arg;
@@ -407,6 +425,10 @@ static long sbrmi_ioctl(struct file *fp, unsigned int cmd, unsigned long arg)
 		/* MCAMSR protocol */
 		ret = rmi_mca_msr_read(data, &msg);
 		break;
+	case APML_REG:
+		/* REG R/W */
+		ret = rmi_register_xfer(data, &msg);
+		break;
 	default:
 		pr_err("Command:0x%x not recognized\n", msg.cmd);
 		break;
diff --git a/include/uapi/misc/amd-apml.h b/include/uapi/misc/amd-apml.h
index 8d1fdf2a54f0..2d531519c108 100644
--- a/include/uapi/misc/amd-apml.h
+++ b/include/uapi/misc/amd-apml.h
@@ -10,6 +10,7 @@
 enum apml_protocol {
 	APML_CPUID	= 0x1000,
 	APML_MCA_MSR,
+	APML_REG,
 };
 
 /* These are byte indexes into data_in and data_out arrays */
@@ -28,6 +29,7 @@ struct apml_message {
 	 * Mailbox Messages:	0x0 ... 0x999
 	 * APML_CPUID:		0x1000
 	 * APML_MCA_MSR:	0x1001
+	 * APML_REG:		0x1002
 	 */
 	__u32 cmd;
 
@@ -45,6 +47,7 @@ struct apml_message {
 	/*
 	 * [0]...[3] mailbox 32bit input
 	 *	     cpuid & mca msr,
+	 *	     rmi rd/wr: reg_offset
 	 * [4][5] cpuid & mca msr: thread
 	 * [4] rmi reg wr: value
 	 * [6] cpuid: ext function & read eax/ebx or ecx/edx
-- 
2.44.0


