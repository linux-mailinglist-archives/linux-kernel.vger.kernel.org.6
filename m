Return-Path: <linux-kernel+bounces-202820-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A5FDA8FD183
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 17:22:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 14FD61F24219
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 15:22:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A6403F8E2;
	Wed,  5 Jun 2024 15:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="NqZMzhTW"
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2061.outbound.protection.outlook.com [40.107.92.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 995371922EF
	for <linux-kernel@vger.kernel.org>; Wed,  5 Jun 2024 15:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717600833; cv=fail; b=QK2qGtoEEeiAdD86gHiRhOmB9ucLNYSHAjrNDKzksAdKghquxUJjuV7pfhpWhE9DaQFA6brn8hedV9/StgARiDOwddtfKxw2JrNgYFY8RpA3PvIZZkt49K+1OmLD7myUj67Yl3YPNojU0F7XAf9rFT+BKe8LRbk0pELkgYrjXvo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717600833; c=relaxed/simple;
	bh=Q3Q/cWpIXvrjR7lHhWXYDBOLYSaUes9lBeOI8ICFbfM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FKcloeqx90n6crmMyeUSK7a3mQHV57GEBsB0EQyEwDSkoVbGAigO7sqeagFovZnwfP5oXfuGnnNtVVUV8oruhTnrv0gCKySgA+eJCtxxDjKROOEX4+eZAnBBjBTNDAeMwLvaXoSmO/CwL4aud1/d42IM+hlfCcXBsbsjq9d8qd4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=NqZMzhTW; arc=fail smtp.client-ip=40.107.92.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VthanLHIRSPqQLy8fNp9qGK23/1LCXzjOkCo3zmgBc9WlDfixyIwMpmlDsMJYoKWOOivwepauKLw/oEo5Sia8vZEpEglgjKrWX8DrbQGXFmlrwfPbbvVSJNyDnO5DdZxFrNHUOJ9s3Bd9o0gLEQ6S5SzHhoWro/WGsZlDib3jhRA0KEuzar5bDdpTX1E71qcqQqM9+XK3wwQR9ivFkXlSNVDyrfosNr9F4uu06eWflNapd6GdgtNsy+c/5hSEG8vTA2I/5EudzPWQ6qXQ2mjO/pbaDdCTs37IqUApTBzJb5XCy1HW0gpMCNCjaS75nEcjLxSYKkjKYpn0YxUso1OHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VyKiZVJW0GpQotl057ZYLtvmJQ2ATScjZN/mHEK8EPY=;
 b=aVkIVnaYMZ9vFFodWKB1CunMrDhppTUkdIR/rWHC5nxLgs7UQQCTDUP3HqRmxa0sF5rXxZkmI4Cv7wbuxeZMdHCnp/F98AOEDaPwEmdNU0EkvjaSSf2xKmCUw5ixBtzuMEyPg+W8MJ3BnGcIy5mu9ktFbJU+J9Uxt+/4VV+Jbcb0N/Y3SWPtfVtpnn8KnKbe2eRnUgmr/5PsjkVLQV4HR1kSLMRNWKNJ8wPAcdxj6DX0r+gd8rIzi8JjmbbK8ODPWYKMr69/OGKlyOMtTze7aPvkR01b3acrqCCMMM8UG/Ijb+hqW1XRjq4IVfh4GUnZGvangzQM0KAg75rF2oWHKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VyKiZVJW0GpQotl057ZYLtvmJQ2ATScjZN/mHEK8EPY=;
 b=NqZMzhTWj7ClS8o0Q8VdyAlOg5MTUZB4K46sRYMJIv4eB4sdBtBjQ+HCssXomRT63LvqLA00thGnXEHqKPIZhy7E72TxfVeRRvMQdZL4cZN6GXdkG7x2smsvkmKFS0dqb5lhtmQyxuIjAZi9zS9csW6AxtlmB+70j9qE04Y4h00=
Received: from BL0PR03CA0016.namprd03.prod.outlook.com (2603:10b6:208:2d::29)
 by LV3PR12MB9096.namprd12.prod.outlook.com (2603:10b6:408:198::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.31; Wed, 5 Jun
 2024 15:20:29 +0000
Received: from BN3PEPF0000B36D.namprd21.prod.outlook.com
 (2603:10b6:208:2d:cafe::81) by BL0PR03CA0016.outlook.office365.com
 (2603:10b6:208:2d::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7656.18 via Frontend
 Transport; Wed, 5 Jun 2024 15:20:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B36D.mail.protection.outlook.com (10.167.243.164) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.0 via Frontend Transport; Wed, 5 Jun 2024 15:20:28 +0000
Received: from tlendack-t1.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 5 Jun
 2024 10:20:27 -0500
From: Tom Lendacky <thomas.lendacky@amd.com>
To: <linux-kernel@vger.kernel.org>, <x86@kernel.org>,
	<linux-coco@lists.linux.dev>, <svsm-devel@coconut-svsm.dev>
CC: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>, "Peter
 Zijlstra" <peterz@infradead.org>, Dan Williams <dan.j.williams@intel.com>,
	Michael Roth <michael.roth@amd.com>, Ashish Kalra <ashish.kalra@amd.com>,
	Joel Becker <jlbec@evilplan.org>, Christoph Hellwig <hch@lst.de>
Subject: [PATCH v5 10/13] fs/configfs: Add a callback to determine attribute visibility
Date: Wed, 5 Jun 2024 10:18:53 -0500
Message-ID: <e555c8740a263fab9f83b2cbb44da1af49a2813c.1717600736.git.thomas.lendacky@amd.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <cover.1717600736.git.thomas.lendacky@amd.com>
References: <cover.1717600736.git.thomas.lendacky@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B36D:EE_|LV3PR12MB9096:EE_
X-MS-Office365-Filtering-Correlation-Id: a45c0c8c-85dd-41df-68e5-08dc85730875
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|36860700004|376005|82310400017|1800799015|7416005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?K3isMi/D/jn22CEPP+wTct+qyY7SxBsfV7trMqmS1cog/gZfUrN8Gh3th37r?=
 =?us-ascii?Q?2nYC2ip8JfkAPP3yI57n8Xs5XV1RNA0IDxBHgoJqLrV3oAY7sGRrFOm4s6LI?=
 =?us-ascii?Q?opf2Wvs5OjGVdWlUdOJv/S7Z1eLiwskNCzpiXc/jSFtWIvWXIfzqDC17XNh9?=
 =?us-ascii?Q?ILmqMo64Pxkx52iLK59rXIKHaW2godLY1LL8O8kslFDPHJut+XwOIjM8Rsns?=
 =?us-ascii?Q?odMPuzRIE2BoVQfjRb6kNYho2SD14xzpfBW1suMLoMH6DlSn1Q8tSeG1eyDv?=
 =?us-ascii?Q?0AQT8y5WrySani1LgCoeg+irgjlm4Ncr1D4hgzMgczHiEvS4TEKEISgXTQRe?=
 =?us-ascii?Q?4r6aKNU12qmwN7zz/aqVA8u/Ml5QXDXbSsK9VY37ZPGrjx4JfXYA5kxIu1qT?=
 =?us-ascii?Q?ymKDWtRrAg5/+HHNaRwuJ8TwVvgfcBaeLhCRV5OQmROzEWIh637jy4zv3QEJ?=
 =?us-ascii?Q?d6fljGwtSY1LGa0topuvd1/r34uuJQas7jFZGKhhcy5cJb/9Z4vX6AP2ezfm?=
 =?us-ascii?Q?zjozmW/e63vIOKS4I5+w4ehlxhJ0BF0sY+3j7Yug/p4IKua66D6lOt9J2FCn?=
 =?us-ascii?Q?oNQLwKwPbLrzdzWHexmVdLOIQ10qz5M3eDcrc90zCJeknTq31X2Q1WsFsnq0?=
 =?us-ascii?Q?onC5WwKCePXUJXqXy9Kqgs7X8bxvFIMwF96cEwdUXvJCm9vhE9N2+99med61?=
 =?us-ascii?Q?IzMifezErowcSNjkewOYH5o1NscbR41n/hd0KT7riSRiujl7QPLOj5A4IkWn?=
 =?us-ascii?Q?8bf7CgCLn7tEEgdLrFvDBl3jLAlAHijAtDjBQlVRfg8vy/rMHym6/xt7FdQQ?=
 =?us-ascii?Q?JCyvjMVf/8EUgneKJVcTW0hTf5vZc4bqcv+u+8GwPWxFIYuNUsVaBAijyUaO?=
 =?us-ascii?Q?eaSW8FEAGoXk6Z/D4BR2JO4HSSvk6U9vAok8nwHywwfwP6zewnC32SMEgl4l?=
 =?us-ascii?Q?VQSlOiHASGBmobY2Z9vxkCAbPUzhxjtGAwRUrnsGqhSq4Jorjm2dtDl0F/Tm?=
 =?us-ascii?Q?85pNv7sAtOURC/afxghhOFEBviMbqKCT+xre6iBrx3w6LyqkD6ZdvDeC2swn?=
 =?us-ascii?Q?yKslguzXcg2mZv6SIbzjpVn0q/y7ZWi82Sr3T+4wwuUcrf7ikGUhXUQB0uqo?=
 =?us-ascii?Q?kolLMFWlfrtjUHRwp1/dGn7AexKfCUUjsENHofQRoQUofto3GHtwi51FWiAT?=
 =?us-ascii?Q?NlFjIZLUVlTb7a8cXLxNVmgCWrj5r0O3d0He1NrZ0mIO2Q1hpXCiM4jKfTTq?=
 =?us-ascii?Q?b1DOETZKXLmo51wtz2uNalFXFgehGRAtEHL/a9bjCaE8kwTIGPWixcIXhPR+?=
 =?us-ascii?Q?v3mrDMXGAa6Wbesd3toYDgBHXPj5V3iUs/9T5zNquwiMyRi0O12NkQ31QiuZ?=
 =?us-ascii?Q?AaUydpuzZ58hcQPi8kZdv1mRBdHH?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(36860700004)(376005)(82310400017)(1800799015)(7416005);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2024 15:20:28.8632
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a45c0c8c-85dd-41df-68e5-08dc85730875
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B36D.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9096

In order to support dynamic decisions as to whether an attribute should be
created, add a callback that returns a bool to indicate whether the
attribute should be displayed. If no callback is registered, the attribute
is displayed by default.

Cc: Joel Becker <jlbec@evilplan.org>
Cc: Christoph Hellwig <hch@lst.de>
Co-developed-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
---
 fs/configfs/dir.c        | 10 ++++++++++
 include/linux/configfs.h |  3 +++
 2 files changed, 13 insertions(+)

diff --git a/fs/configfs/dir.c b/fs/configfs/dir.c
index 18677cd4e62f..43d6bde1adcc 100644
--- a/fs/configfs/dir.c
+++ b/fs/configfs/dir.c
@@ -580,6 +580,7 @@ static void detach_attrs(struct config_item * item)
 static int populate_attrs(struct config_item *item)
 {
 	const struct config_item_type *t = item->ci_type;
+	struct configfs_group_operations *ops;
 	struct configfs_attribute *attr;
 	struct configfs_bin_attribute *bin_attr;
 	int error = 0;
@@ -587,14 +588,23 @@ static int populate_attrs(struct config_item *item)
 
 	if (!t)
 		return -EINVAL;
+
+	ops = t->ct_group_ops;
+
 	if (t->ct_attrs) {
 		for (i = 0; (attr = t->ct_attrs[i]) != NULL; i++) {
+			if (ops && ops->is_visible && !ops->is_visible(item, attr, i))
+				continue;
+
 			if ((error = configfs_create_file(item, attr)))
 				break;
 		}
 	}
 	if (t->ct_bin_attrs) {
 		for (i = 0; (bin_attr = t->ct_bin_attrs[i]) != NULL; i++) {
+			if (ops && ops->is_bin_visible && !ops->is_bin_visible(item, bin_attr, i))
+				continue;
+
 			error = configfs_create_bin_file(item, bin_attr);
 			if (error)
 				break;
diff --git a/include/linux/configfs.h b/include/linux/configfs.h
index 2606711adb18..c771e9d0d0b9 100644
--- a/include/linux/configfs.h
+++ b/include/linux/configfs.h
@@ -216,6 +216,9 @@ struct configfs_group_operations {
 	struct config_group *(*make_group)(struct config_group *group, const char *name);
 	void (*disconnect_notify)(struct config_group *group, struct config_item *item);
 	void (*drop_item)(struct config_group *group, struct config_item *item);
+	bool (*is_visible)(struct config_item *item, struct configfs_attribute *attr, int n);
+	bool (*is_bin_visible)(struct config_item *item, struct configfs_bin_attribute *attr,
+			       int n);
 };
 
 struct configfs_subsystem {
-- 
2.43.2


