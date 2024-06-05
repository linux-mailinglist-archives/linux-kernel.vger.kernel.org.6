Return-Path: <linux-kernel+bounces-202816-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0288E8FD17E
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 17:21:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 80BC3281F78
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 15:21:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5537A482C3;
	Wed,  5 Jun 2024 15:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="5pxLBHbf"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2084.outbound.protection.outlook.com [40.107.223.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09385481B3
	for <linux-kernel@vger.kernel.org>; Wed,  5 Jun 2024 15:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717600813; cv=fail; b=pXp53psXIpmifSvr/HAehBvehyAWgx2/WzJpBbj5j9yn62gqUWNgcEzyF9vcW6v7P4HsURwWrl2Hu0WUlTv5PT4iOhJDCuipVZrC5+CseU+rez4KkeC1YcWq2vIv09Wr0v0ooTl13u1fnQ/dfagxgNkeJSccsNnOfa79eOrvlyU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717600813; c=relaxed/simple;
	bh=ZRCK2LCevbg42lRTbV9cvBPFTscTA6aU74OgsI8O9Zk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UeerZNWsLK17HcJdl2mz2Rhhf+SESrG61byEzNDqeO9ESIY1whtCcZRkW7PpV4cKy9GT+sczJhFZkbyl3BLK1t18g3uUNSOr85Fn8/kNNiP9GrpJALYtHoU+NHSoK7d6f5d/7d69CziOjsOPNs6v/90rXBKAs3lRkE/n2+1+IW4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=5pxLBHbf; arc=fail smtp.client-ip=40.107.223.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BHZ0qbkm8Fel0NXci1++O2KlKhwzOcoYQFB43v3s5qrVdgZ3ckdDzOllAKd6rqFBCbf43cAboy9U6xOPcLq6LN1LNi1+b6u5pAcZwcO/yCZAVy0Z79eCCkFTPC1UwOqL5kv1i7fvWPSB8xRhS2L9gGRiUrfnjt03aEAP9wSHy3+W/kwTZRyc8AnTHC3S8gbzmvQj6tjnlwvBi2aftHxxDdTYR3o0Fa532N+dejzEEosh0v5Au/CghuZoJnWO43m/0yahSTL0toAmxLnNu9YcitOO1/Fbwg/vrto0ciHBlxJM2ka656QipbztIM/m0JvLvCQ2rWTBjhUQGI5vt55ktQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RRK6aHalP6yxxv5CWxUvgOMg/8Mg7wqQ0dLgCT4h1bw=;
 b=j+QOPY899r6OWkupjF3r9RRBAHASFt7DOYP6jzHs6Gal8aMgCN2cm7PoTjjLFbSbwlBfVRybkVtQuZpLETH7ytrHwmtzcSh6d2qptR3lfu6H+LZ3h03wHi87KucTbileiP+QkT1/TLf2nmT8NlyqWt64fsnULk0L4gGjTXI6Up4hYa05wfU2l6eqM/9gtePFcjmq3Fip09xhgqSA2ahEwqCFOhIqzFJW2hActAl+Ucg1RkmpBNfXBRkeOtczBiDWAQAZi+RIMkbhJtFQDxhwXKCCI4mjXJSSb7dgQkny1SbtPq3KjZHtIpC7PmP3ol6r0Wl6xyqcK/UlH26Op/xzjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RRK6aHalP6yxxv5CWxUvgOMg/8Mg7wqQ0dLgCT4h1bw=;
 b=5pxLBHbfZNxQg+neB3GbbCNAaek9oCLUvToMf5etzjDS8MSoGQrGfHJez0WAProvj+TCYcOSLv9qeWOXT0j9lLfFw/YfgnjZ7gku6SOGpe0ljb1CqKXykTETPNxGJe8zHu5iOkWjq00HDgSbrNgpm9RftuW6pCmjoCoU+iKGdC4=
Received: from BN1PR10CA0003.namprd10.prod.outlook.com (2603:10b6:408:e0::8)
 by CY8PR12MB7587.namprd12.prod.outlook.com (2603:10b6:930:9a::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.27; Wed, 5 Jun
 2024 15:20:07 +0000
Received: from BN3PEPF0000B373.namprd21.prod.outlook.com
 (2603:10b6:408:e0:cafe::e) by BN1PR10CA0003.outlook.office365.com
 (2603:10b6:408:e0::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.31 via Frontend
 Transport; Wed, 5 Jun 2024 15:20:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B373.mail.protection.outlook.com (10.167.243.170) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.0 via Frontend Transport; Wed, 5 Jun 2024 15:20:07 +0000
Received: from tlendack-t1.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 5 Jun
 2024 10:20:06 -0500
From: Tom Lendacky <thomas.lendacky@amd.com>
To: <linux-kernel@vger.kernel.org>, <x86@kernel.org>,
	<linux-coco@lists.linux.dev>, <svsm-devel@coconut-svsm.dev>
CC: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>, "Peter
 Zijlstra" <peterz@infradead.org>, Dan Williams <dan.j.williams@intel.com>,
	Michael Roth <michael.roth@amd.com>, Ashish Kalra <ashish.kalra@amd.com>
Subject: [PATCH v5 07/13] x86/sev: Provide guest VMPL level to userspace
Date: Wed, 5 Jun 2024 10:18:50 -0500
Message-ID: <fff846da0d8d561f9fdaf297dcf8cd907545a25b.1717600736.git.thomas.lendacky@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B373:EE_|CY8PR12MB7587:EE_
X-MS-Office365-Filtering-Correlation-Id: b4eb7448-8c23-4486-492c-08dc8572fb7e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|36860700004|1800799015|82310400017|376005|7416005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?BgNjEfTKN5s1f4p9qQTJ4dWsapWsahBMVeTsUWaCcUmJpTS1p+oCnvye0T++?=
 =?us-ascii?Q?wEA2ZuVzakFfrXeHNejHwXlFZ0AHxBNiylLwMJyrPv4vaXfeG+0xt9ehob2X?=
 =?us-ascii?Q?v/6HRF6ykBi/g9ozWuZ3+YwvagT3/sOxw7CGoBsTxaVB5Re2Pwbykue/lkbo?=
 =?us-ascii?Q?KfWn0+hhf70U9N56B8MgJYzxgyRav+1OfQUUelgpBN1BSikKhy7U3SgdbPo4?=
 =?us-ascii?Q?//V2jNvHfCy8aSejChbXLO/6gvRydg1sZKBvjpOIETFNRbTQBSFiJHT+R7tC?=
 =?us-ascii?Q?BBA67U8uwz+mXOjivqAsT2tNzAVdepXEFH5m1N2LZhsT3X/XIURF2HkmEH1O?=
 =?us-ascii?Q?HYCfrqghuZ10k/o0tRcb6JNr+c56FkuVJarKMnq6PeOB4phGz2/q4B26iWPJ?=
 =?us-ascii?Q?z497dneyOa/jToeqlkB6fPMnyCwQ87ekZxe6ikrcuNs9JaSQHXW0EF7KAtoI?=
 =?us-ascii?Q?BMPv7OMVPxK+HRH20SKg3mRuCCrzMgzRXJk53Lb1McMxuDhg5DusaRGRoZhn?=
 =?us-ascii?Q?YhV7X9QAMxRLEoYyUO9oalwLBLQZFv1CYhjqQIzVz0xGejFheuzAK02BAu3y?=
 =?us-ascii?Q?SaTfPQkUzENoyZgq4Jlpl+WwsywFN6vW8KzaS8wqmK1SUc20e0V9AvUSJoxS?=
 =?us-ascii?Q?HjRIhE/UZkTG9tlRX0SBy5boo9aMqx0Fmtosna7DecJUppVZSI9TVThdR+K8?=
 =?us-ascii?Q?BfmJIf2bfPwWVWRzBffebduxQT7ShUQoMHV/EU2WvzC8y18Y4BDUUryt9m9j?=
 =?us-ascii?Q?jSdMt/BAKAR6zC0XyQhH/4hrDtcQW3WfsuThLJX2GVqvuTi9NkS0rVgl2hXD?=
 =?us-ascii?Q?JwC8klx0hysUACPJJAko9Eckkzpwivdb/jfCASRHLbS7i0AQ2iBDc1syhhD7?=
 =?us-ascii?Q?jFyiXLjGr8EV9q+P2sK6KaVLZ5lq0XC7iUny+kRfXLlPEAKYSvjtFbv9SH2f?=
 =?us-ascii?Q?RkjkB5iXLvWCcEejwngfm3b7I4+9+sXGXQe4CkwuFgmR2j8ZvgaqwjuRrTYn?=
 =?us-ascii?Q?SaNrO7/yfn96dXawFyh1QGe90y+r7vlDWyqQwr0mxMneY0QDGdnFAI2oFItc?=
 =?us-ascii?Q?SYObnMbe0LGP8EF3XZBZPf/fpOAGJMGyfhdipdb35/8oAf+99v36zsZR+4LM?=
 =?us-ascii?Q?HTezf12It4G3Y9aNbO8UcKfM1lNmRWWVZGFVEJXqiy7WYY2hQF7kX2iufCHi?=
 =?us-ascii?Q?4CTpNa2zYymLaxPNz+sw0ANQgnWHvm3DmjN1bc3hhhFec7HLTPfshxGQ1gSE?=
 =?us-ascii?Q?ARJB1rPAek0LpDakDGFWmr8JrzA4VD696c2BiK64abt+Qg4T/RqdfdkuXTdT?=
 =?us-ascii?Q?kiae2/Wa4ho2IQ0Cnx1QUaUtfH+KVZ2ro/UvSN+UOKxrTuTaSln85m5u/oFI?=
 =?us-ascii?Q?1t0qkERsO9aHWibY0Z4QYpp3I+EC?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(36860700004)(1800799015)(82310400017)(376005)(7416005);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2024 15:20:07.1110
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b4eb7448-8c23-4486-492c-08dc8572fb7e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B373.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7587

Requesting an attestation report from userspace involves providing the
VMPL level for the report. Currently any value from 0-3 is valid because
Linux enforces running at VMPL0.

When an SVSM is present, though, Linux will not be running at VMPL0 and
only VMPL values starting at the VMPL level Linux is running at to 3 are
valid. In order to allow userspace to determine the minimum VMPL value
that can be supplied to an attestation report, create a sysfs entry that
can be used to retrieve the current VMPL level of Linux.

Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
---
 .../ABI/testing/sysfs-devices-system-cpu      | 12 +++++
 arch/x86/kernel/sev.c                         | 44 +++++++++++++++++++
 2 files changed, 56 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-devices-system-cpu b/Documentation/ABI/testing/sysfs-devices-system-cpu
index e7e160954e79..8fd7ed9aee4e 100644
--- a/Documentation/ABI/testing/sysfs-devices-system-cpu
+++ b/Documentation/ABI/testing/sysfs-devices-system-cpu
@@ -605,6 +605,18 @@ Description:	Umwait control
 			  Note that a value of zero means there is no limit.
 			  Low order two bits must be zero.
 
+What:		/sys/devices/system/cpu/sev
+		/sys/devices/system/cpu/sev/vmpl
+Date:		May 2024
+Contact:	Linux kernel mailing list <linux-kernel@vger.kernel.org>
+Description:	Secure Encrypted Virtualization (SEV) information
+
+		This directory is only present when running as an SEV-SNP guest.
+
+		vmpl: Reports the Virtual Machine Privilege Level (VMPL) at which
+		      the SEV-SNP guest is running.
+
+
 What:		/sys/devices/system/cpu/svm
 Date:		August 2019
 Contact:	Linux kernel mailing list <linux-kernel@vger.kernel.org>
diff --git a/arch/x86/kernel/sev.c b/arch/x86/kernel/sev.c
index 5ba1c481b867..d09844db2361 100644
--- a/arch/x86/kernel/sev.c
+++ b/arch/x86/kernel/sev.c
@@ -2501,3 +2501,47 @@ void __init snp_remap_svsm_ca(void)
 	/* Update the CAA to a proper kernel address */
 	boot_svsm_caa = &boot_svsm_ca_page;
 }
+
+static ssize_t vmpl_show(struct kobject *kobj,
+			 struct kobj_attribute *attr, char *buf)
+{
+	return sysfs_emit(buf, "%d\n", snp_vmpl);
+}
+
+static struct kobj_attribute vmpl_attr = __ATTR_RO(vmpl);
+
+static struct attribute *vmpl_attrs[] = {
+	&vmpl_attr.attr,
+	NULL
+};
+
+static struct attribute_group sev_attr_group = {
+	.attrs = vmpl_attrs,
+};
+
+static int __init sev_sysfs_init(void)
+{
+	struct kobject *sev_kobj;
+	struct device *dev_root;
+	int ret;
+
+	if (!cc_platform_has(CC_ATTR_GUEST_SEV_SNP))
+		return -ENODEV;
+
+	dev_root = bus_get_dev_root(&cpu_subsys);
+	if (!dev_root)
+		return -ENODEV;
+
+	sev_kobj = kobject_create_and_add("sev", &dev_root->kobj);
+	put_device(dev_root);
+
+	if (!sev_kobj)
+		return -ENOMEM;
+
+	ret = sysfs_create_group(sev_kobj, &sev_attr_group);
+	if (ret)
+		kobject_put(sev_kobj);
+
+	return ret;
+}
+arch_initcall(sev_sysfs_init);
-- 
2.43.2


