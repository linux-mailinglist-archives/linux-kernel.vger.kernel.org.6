Return-Path: <linux-kernel+bounces-254870-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8AAE9338B3
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 10:13:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2570EB2244D
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 08:13:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48A53482D7;
	Wed, 17 Jul 2024 08:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="SEVAhLcY"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2052.outbound.protection.outlook.com [40.107.236.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C59DE53E15;
	Wed, 17 Jul 2024 08:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721203878; cv=fail; b=JWM8dOozN3rMganxqbfya71ngvwzR0Qidzdgbiu5vDH+R9OytxyRhBYYa46XEsEsSLCw7WvwofD/XePCB7qJeKeasMQFqHrXtAa72ofxopoVBOa+7qhGr1oBax0n+/ASmI4r5j9nt+k7xV0AMBFbIYf4teKjzYLhgKVyTozYPlc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721203878; c=relaxed/simple;
	bh=wAtmzOsj2pzNP3lmh80KnAhOTOqx2d3HOjpB5UnRQWc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BIQ1Wv9XIuQWAOcsBaoJjST1K2bbMmH+ZMXjQ1ztvvH95G2Qy5aTYJpD538pH6tuSBDRuOWoeaoQjADjU5+z14FJMXeh8hR+1uv15glL1ksXXFvtb+4cwkkFFH1Cl/gM5epqr48EwnAGFKvhCGf5RGY7DY+s1KM2u1yg+7Euf1g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=SEVAhLcY; arc=fail smtp.client-ip=40.107.236.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E3CFT21O9+xotkq42iu2BS4EY15T817S26ZsnvwMDJGvuU6BdDFs2VBPQ+8Mrf/uL8K94Ypk6Q3RNzMMcF1D6SwYfNbG4kYzNUkV6SKGVrKgXFedUJuwx8hZQTGoBV+XI3QuKvRC2m8Uv1pN/N3kc/KRMLWfDT0HqTFM/a6JT9dB0hL3lddZhxY8YomMGep5q+tGFFN1FRNzrz8NO2NxnhSHv3hGDVgxwXklwigdzeCltkqz4qSapViO+FLeCDPfKidCJEQ71FHEYKF8V5mNvn20wSZ1o60YEwWc4cCxfEfSOtehYdz8sK0EQGxgxgvYwzZqV4FS/JZoiJd/ZafjBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yoTT9s4dMPtmvhoRPiN9XWFX+RQTtI+IY3S7ygchNG8=;
 b=UFMyLCB07VBhECf0VHFL3oI3yLi5VtdxqeblGkEvL8yAE07146HqRlQhiLkUYxj9wLTVcHhLzqvOzT6h64cLY1w4KMXMf0Z+4MCO1q1HyTqsoxF9r6/JxJu6BITZGWnpJPoSMg6bdNdRZYKUSyEmqNs57mB/Os13csshGsIEFpRkevGdvdZIXvIchBvEl1anfArQBrXKNZup1LM3C4NObkIj3gP2w1PS1SdbdKDM5wSFWeAfdpQg5GgdvwInULjQ9et13T8NNT6hm8uNZA6QpvbqLlwYquWuJklg7LTpPjr24fvUn4H9ku0VUSOWp62sABFcfsoCrb6G+xK4apzS7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yoTT9s4dMPtmvhoRPiN9XWFX+RQTtI+IY3S7ygchNG8=;
 b=SEVAhLcYwwKBsE2FrDzZmlDwlSy1Xbmk7DyZm37mtEPCkm2on7nt6P67zjWddiZHHYbzkuq8A/L7UvMvI3tZ997qLau+jKBRzQyobfsvVSpI8pYjhPQ2Q9np/c+riJRMbmJp0cEKyZJgUOF0tbObQzjgrLBV3RYSp8vy/Pdi/xE=
Received: from CH2PR08CA0020.namprd08.prod.outlook.com (2603:10b6:610:5a::30)
 by MW6PR12MB8758.namprd12.prod.outlook.com (2603:10b6:303:23d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.17; Wed, 17 Jul
 2024 08:11:14 +0000
Received: from CH1PEPF0000A349.namprd04.prod.outlook.com
 (2603:10b6:610:5a:cafe::80) by CH2PR08CA0020.outlook.office365.com
 (2603:10b6:610:5a::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.29 via Frontend
 Transport; Wed, 17 Jul 2024 08:11:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000A349.mail.protection.outlook.com (10.167.244.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7784.11 via Frontend Transport; Wed, 17 Jul 2024 08:11:13 +0000
Received: from amd.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 17 Jul
 2024 03:11:11 -0500
From: Akshay Gupta <akshay.gupta@amd.com>
To: <linux-hwmon@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <linux@roeck-us.net>, <gregkh@linuxfoundation.org>, <arnd@arndb.de>,
	<naveenkrishna.chatradhi@amd.com>, Akshay Gupta <akshay.gupta@amd.com>
Subject: [PATCH v2 7/8] misc: amd-sbi: Add supoort for register xfer
Date: Wed, 17 Jul 2024 08:10:26 +0000
Message-ID: <20240717081027.2079549-8-akshay.gupta@amd.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240717081027.2079549-1-akshay.gupta@amd.com>
References: <20240717081027.2079549-1-akshay.gupta@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A349:EE_|MW6PR12MB8758:EE_
X-MS-Office365-Filtering-Correlation-Id: cf56067c-11bc-417e-9f9d-08dca638066f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?NDOZ1TrzZxICZyYW8TlenIVA6ceHrtACCOJ42HoIY6YmUphTZNhAmGJ9N6Q2?=
 =?us-ascii?Q?fWIZGbGUH75VyJ820yqr6r6m2o9ysYmY44Fjai5Nk33aAPDSsIirsYiEvPj/?=
 =?us-ascii?Q?+sXJ4cJ1yJuGWR3ty3NLpgthkm0HcOqwux78EwQCj3Dk+YLfG+2UWU/zEidB?=
 =?us-ascii?Q?gI29gTDo5J5iTNc1x2vO4RL1r6EQlhTMYh1blJ+jY3jqPqzZyDjp+tztjpLr?=
 =?us-ascii?Q?1pAwfuLfqqCtSO9kg1ZQMQ/0Er8nFgHjBunDmh3z8dvzGwa5abbxxSPnRT8B?=
 =?us-ascii?Q?4uqWHEdFfZgDf28zDeXXpKiRmzGbKkTuBoHyBBtoglmQtdzhc8e+IZXz0uDs?=
 =?us-ascii?Q?yH1mDO4Ent0ro2qHJvmy/kgF/sCeonqinKy/SMl9y7GvKayd+m1yDJ0FG7Zu?=
 =?us-ascii?Q?ySnd3A9qgKmNVeaDTVSnYPO1ibj27zqiyp3qeMgs9YjXztpixFCwqwdFC6rm?=
 =?us-ascii?Q?6AjxT9P3iK4WCHbYc3ltpsuvxzwTNVt+RZU5kjcAG5TuK48BwMfYzXw2srvC?=
 =?us-ascii?Q?XuQK7BpwJti0p3I6hq1We8r6Ovd0+LqoeTB1454tdrAdAMtpaQs+pkwx1Rdc?=
 =?us-ascii?Q?5YTJpWC+ZvPMwYALOpohxILzjFlKlt4tzmdSyM8ABDbBzI1TZmAN3UwfBjYV?=
 =?us-ascii?Q?3pkZ/U+oI9bTdjJ85eT/zB7WM1PBIG+alrJ32e43Q6xlqGOIsB3IAALAfUXq?=
 =?us-ascii?Q?CBQ7gsU/3QfqV+So6uMu99CpUsxOsEPqUK9ZaYEg5vKpAVLgMnhudU3Ds2Ml?=
 =?us-ascii?Q?XWd6oGCL/wav0/8Gx9FvhUkgdzK/7ffnF7r/F4VrKzpPjvqNEyH1xzUzQ+s3?=
 =?us-ascii?Q?YmB3PU7zDlIGbKSywKyIUoV4NNcsQJ7GTGos9H8go+cj3467jYEQyZr81jM5?=
 =?us-ascii?Q?AmID0jMtjfR8sgQrxV0kLXFi2N8HjMwB2cmluYO7wHFRvPXnwBT68eqIoi0y?=
 =?us-ascii?Q?KNx1qARScgTJ+3G4jf3oiiRBJRNws5TzQq5DAcREAst17Brtnmqn3Q3LL/gb?=
 =?us-ascii?Q?7IyEDGHYr8vu1hm7VNdcnzDLPN7pxFpr8zxhxGijuES/JbkBvpDmB/X8Fm6m?=
 =?us-ascii?Q?7/PyImTucMqoSh7sagOnWPmUETir31yAg+bmyG19vZ+ilA7tcso/HeUBpDAk?=
 =?us-ascii?Q?TTzDUA9crTaVTlva2pg3xRphPqDnzICY1SXRNWCPDFnilCMJX9DC025KVfV3?=
 =?us-ascii?Q?R5DrxX68TCMwHcIgKSmoRR1vcvf83PvfVtnbuQtTdY0yFo48Vfg8JGKBAMTh?=
 =?us-ascii?Q?KGFPyo82NzTl/M1rSxSJMNZ2JT+Na5y7K2mN+JnHgRoqwUCl8KLYy3pb8V2F?=
 =?us-ascii?Q?zua9Ya30JAZJrOCZIId/MDnICbwKgX53mCPmyG00OWKEEElpGb8EyHOpEapi?=
 =?us-ascii?Q?OjiT0OdbP10mVqIyJvGEsNs356EQGVjR1VfwigsyZK4E7Jw/PpnY/AO12yCm?=
 =?us-ascii?Q?Bc8iMl8viB+pmru9is50UJTJKSZRRiDq?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2024 08:11:13.5032
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cf56067c-11bc-417e-9f9d-08dca638066f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000A349.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8758

- Provide user register access over IOCTL.
  Both register read and write are supported.
- APML interface does not provide a syncronysation method. By defining,
  a register access path, we use APML modules and library for
  all APML transactions. Without having to use external tools such as
  i2c-tools, which may cause race conditions.

Signed-off-by: Akshay Gupta <akshay.gupta@amd.com>
Reviewed-by: Naveen Krishna Chatradhi <naveenkrishna.chatradhi@amd.com>
---
Changes since v1:
- bifurcated from previous patch 5

 drivers/misc/amd-sbi/rmi-core.c | 22 ++++++++++++++++++++++
 include/uapi/misc/amd-apml.h    |  3 +++
 2 files changed, 25 insertions(+)

diff --git a/drivers/misc/amd-sbi/rmi-core.c b/drivers/misc/amd-sbi/rmi-core.c
index 87bd2ffcbcc1..da223e47d5df 100644
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
+	if (msg->data_in.reg_in[RD_FLAG_INDEX])
+		ret = regmap_read(data->regmap,
+				  msg->data_in.reg_in[REG_OFF_INDEX],
+				  &msg->data_out.mb_out[RD_WR_DATA_INDEX]);
+	else
+		ret = regmap_write(data->regmap,
+				   msg->data_in.reg_in[REG_OFF_INDEX],
+				   msg->data_in.reg_in[REG_VAL_INDEX]);
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
index 3d536f2c8815..6d74f4ffba10 100644
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


