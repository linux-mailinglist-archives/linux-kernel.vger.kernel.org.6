Return-Path: <linux-kernel+bounces-443900-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0709A9EFD45
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 21:20:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B648028BA50
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 20:20:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 098CB1D6182;
	Thu, 12 Dec 2024 20:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="NY7iSX77"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2086.outbound.protection.outlook.com [40.107.223.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ACB61D5AC0;
	Thu, 12 Dec 2024 20:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734034734; cv=fail; b=VKnkhavNElnaLC9i/QU3VvvM3IrmwhwqZ/FyJpcN7oYQ6GesjQWzISQNWtmGnkZFsI+mLHZ20ZA83xorOnNuFuBUFI7itkRiiA5I690nO+ge0A/2nwkLodXzLeDNDcFae4ppG29v56q9j5iq5oKUNe4OHYLM/x9aSBjkjh9MDYA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734034734; c=relaxed/simple;
	bh=3QmlNB6WttZ6E4GNMAsmYLPe56NFqdbX9SG+0pRPi7E=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LCjpdWjfWYwzkH8fQbf1Fz5L7UABMmFx6ihN/vRkPSoJu6MLLQPUyi8jaD5wyHB6gJSRLpVk2gkPMPFBNq8zYryKcU8S2DZ9jUhlBO7FxaujdIgTrU2RwkzuBisl9dkTl27VmF9sN6THry8N4sL+x/OnUarKSE8UZHdGf/5EmpU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=NY7iSX77; arc=fail smtp.client-ip=40.107.223.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g5q2hSiU2NsF6WIKJrtiZUUvAAfYw3avfWc2jKd/yYpY5euQX8TOHRR02ZpPxfLOYGFwsqv/iWDtDOXcuk/8WwR9hViCgosQl+d4hpf4hozBTgP2Z3Il+HXYwRy0OiGOESHLRv2B6iqpKm4nMV6qh9ep2LwxgGsaaW06xyjxUG9L8Tz5SQbpxUqHBPAhZMZ0MIQ7KnZkY/n/MQqhnh0IclRQAKL2R/hvH+d2J0+1kBjSA4JZsTIGTN3Z6u38NszA1QhsE7wBT8lxZ4E5hJERpdOOsq4qecUwqoCvC795zJaRgsOFFCkBY5hXzbpFCiGguJpzPHdjNpAhEJG/w/9YVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uNVlL1RH8UiNCMOcRyPKqcr9oW9zaIngxe+nddxnuxI=;
 b=HkzhRXfQKtgA8aXIYOTUx/hAKE6jmq/7o7pFxZRB8zHI6THeN35ZC/1mJ9q4/qed9QODPQndK02TA3AlvXON4poBzMs1amRsrQHgtOL2sMyO5UHh9pNMYTAJntO7JshMAq3U3+62dCG53Jqoe29hUwO54PmDlVLJ9IsoYXgqWzeZJVWLn4FR1yAGxmigx/oUQl91t8B/1LKVebUObjqHYp3vIMn0ieqj8Q7LlPqOAgcRtQQMC7DWMOERSyfXRjy8M7haLyfaX+cvjtEc8v/bNEv5QRCVmjFtNLOmjvSUuKotDs6gg6/wdlnA1+WfP/H1HpecVdBJXlNVwbiQr2DiyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uNVlL1RH8UiNCMOcRyPKqcr9oW9zaIngxe+nddxnuxI=;
 b=NY7iSX77JsofWUXIT2LxTKO+zUAJL8LvkP/4GxHa/SoY/zcVyWhs8VXPVNNdzIJFi08urasC9wcoBBAIQUxutBmRXVlYROnuCQ1v4fBS74kEJj1NXLoIve8fnNfPtkLBoW48uo7uKnHENovRQmXbGY+8wQuvhs4Gj/bqaENbzd8=
Received: from BN0PR02CA0035.namprd02.prod.outlook.com (2603:10b6:408:e5::10)
 by IA0PR12MB7752.namprd12.prod.outlook.com (2603:10b6:208:442::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.17; Thu, 12 Dec
 2024 20:18:43 +0000
Received: from BN3PEPF0000B072.namprd04.prod.outlook.com
 (2603:10b6:408:e5:cafe::3e) by BN0PR02CA0035.outlook.office365.com
 (2603:10b6:408:e5::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8251.16 via Frontend Transport; Thu,
 12 Dec 2024 20:18:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B072.mail.protection.outlook.com (10.167.243.117) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8251.15 via Frontend Transport; Thu, 12 Dec 2024 20:18:43 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 12 Dec
 2024 14:18:41 -0600
From: Babu Moger <babu.moger@amd.com>
To: <corbet@lwn.net>, <reinette.chatre@intel.com>, <tglx@linutronix.de>,
	<mingo@redhat.com>, <bp@alien8.de>, <dave.hansen@linux.intel.com>,
	<tony.luck@intel.com>, <peternewman@google.com>
CC: <fenghua.yu@intel.com>, <x86@kernel.org>, <hpa@zytor.com>,
	<paulmck@kernel.org>, <akpm@linux-foundation.org>, <thuth@redhat.com>,
	<rostedt@goodmis.org>, <xiongwei.song@windriver.com>,
	<pawan.kumar.gupta@linux.intel.com>, <daniel.sneddon@linux.intel.com>,
	<jpoimboe@kernel.org>, <perry.yuan@amd.com>, <andipan.das@amd.com>,
	<kai.huang@intel.com>, <xiaoyao.li@intel.com>, <seanjc@google.com>,
	<babu.moger@amd.com>, <xin3.li@intel.com>, <andrew.cooper3@citrix.com>,
	<ebiggers@google.com>, <mario.limonciello@amd.com>, <james.morse@arm.com>,
	<tan.shaopeng@fujitsu.com>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <maciej.wieczor-retman@intel.com>,
	<eranian@google.com>
Subject: [PATCH v10 20/24] x86/resctrl: Introduce the interface to switch between monitor modes
Date: Thu, 12 Dec 2024 14:15:23 -0600
Message-ID: <874347c318853ccaafc7efae79093f2a394bba77.1734034524.git.babu.moger@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1734034524.git.babu.moger@amd.com>
References: <cover.1734034524.git.babu.moger@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B072:EE_|IA0PR12MB7752:EE_
X-MS-Office365-Filtering-Correlation-Id: ed12f373-6ff8-4d4e-ed61-08dd1aea2cd8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|7416014|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?/OhASrY9TLaUdq98KVSblWMEhKxtGQgYgzt476GSojC6U349jGpyCCWOyo8e?=
 =?us-ascii?Q?NdEVBBX+xQ0nl26zIdNhDabbMiVnhSDUphVJE0IdXL57xD33OCRg6cK3rqsY?=
 =?us-ascii?Q?zGoKpiGozojpRT0kKOlq80/RL/nnuSSThhL2rZIUjcBWDuoGqSomag7mIILw?=
 =?us-ascii?Q?1YMjwXfvSRXeANyxDKgYaLKuAZH6u4bms4xFdaaGjsNk0eN5BRB3Va2BVQU1?=
 =?us-ascii?Q?UHXIfS44YEi/lsnAJolMW3AHC64DJIpq9Ot/S7eCTEozc6ygGgeqwdg82mkz?=
 =?us-ascii?Q?H4r9PodTx96VUMIJtR6WtwGrj9iZvFmJ8sepalF1RXC6UpU7ykJ91rOAPG2o?=
 =?us-ascii?Q?FblepMu6itz5Engw5TsjBOEFrd6XPA+74YxGcnI28jUuZJKk0CZUDLYL/qZ9?=
 =?us-ascii?Q?6HKAGMqD5JDXRiKW2LaDS2vpdgCRKJgT5hRltAFfq3aFy75REAm2HU8Lr6HB?=
 =?us-ascii?Q?ExM1M8c2ZS0NtqX7AOtCBjYW+7mCKqZ3LShM2m5l6iyOysmqGdZgINyVFNLu?=
 =?us-ascii?Q?tONyfx01cF0Tv1h5KwxA4nrSB5+ApVS4foZbRMm3RvIEK8XWh5+RBjNRspUN?=
 =?us-ascii?Q?b+T+0votB/+/Uuu5zjOwwHN9U5tCkgFlsiIBOe9l4SOnytYjZEGrwQ/n+eJS?=
 =?us-ascii?Q?5knBYoRipJFWHkNVv2bnzsn5YRTAnW3lvnVu2LGZzsvrVdY9kNLQvQleUc8s?=
 =?us-ascii?Q?KvlNvwI0nk3O6fMweKlbsGhvizH0VplercD4j/VXvzT1K0MhORbSy1WjDBAM?=
 =?us-ascii?Q?sbU3uqJi57hNmezjJxjjBLDvu55Z2+K+zA//L1x8llWZCsXZNU20GRLa+INk?=
 =?us-ascii?Q?aVwPF22Gztk+54zLALUNxj85Od4rtZ5M99z2TWbFpQ13Iip0k2Q7TDujOmqx?=
 =?us-ascii?Q?NO0Zu1ealdOdQcNItUZN/7Z6qQST65U/URfE5diV9owyreCCYmrk1EHR2iXx?=
 =?us-ascii?Q?HiRQBd37tgPjqjGL9RNIG1X+xjvm33iAPBVW1PAWJJsncmexxatMsxZ5PCh7?=
 =?us-ascii?Q?JiqnwnUE5gydSSX+Y7t4VsddRWaM7o86EP6IRd5Bo3boZ1RI+tw0RwXDawW5?=
 =?us-ascii?Q?xlV9mCEXScRjpLNPl+zhkZyFnSdgDMh1RLh3wxM6jH5X75yB/SMuS7kMAD0x?=
 =?us-ascii?Q?ot/CxMFikr+wZejwS4Vng8ah7LhgKrgps2ck/NI2OgQjaVfTKdHXTKaJRjJj?=
 =?us-ascii?Q?r77ZdjXOn13GxssOfNfHy+TNh72LWUQtRlS/yp+x9zSv9MFYRKrreXX9gMmU?=
 =?us-ascii?Q?Oh3WEeLEFqgk7WDjt56cY8+mcAHQPR0bIcbwNLfaZdm2PjIWfyxJLTz58QCG?=
 =?us-ascii?Q?MLQd+2L9nlkwMMSzE1aFUsHp/nO6X+C1EZHqra4jMPtWl4Oiy42VxMuxvapo?=
 =?us-ascii?Q?eLtV3xIKCohMoepUYUo061WOClvOdzeUqsZlVRxst7gH1mepTTlKmw2v+hgi?=
 =?us-ascii?Q?2Md4Fo50FeBFTR8aVbKJ+3SBWeWgauM30v2qbMiKTkWj//YDs/EayoIHqg7Q?=
 =?us-ascii?Q?igXZ62pxM8q0G60=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(7416014)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2024 20:18:43.2936
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ed12f373-6ff8-4d4e-ed61-08dd1aea2cd8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B072.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7752

Introduce interface to switch between mbm_cntr_assign and default modes.

$ cat /sys/fs/resctrl/info/L3_MON/mbm_assign_mode
[mbm_cntr_assign]
default

To enable the "mbm_cntr_assign" mode:
$ echo "mbm_cntr_assign" > /sys/fs/resctrl/info/L3_MON/mbm_assign_mode

To enable the default monitoring mode:
$ echo "default" > /sys/fs/resctrl/info/L3_MON/mbm_assign_mode

MBM event counters will reset when mbm_assign_mode is changed.

Signed-off-by: Babu Moger <babu.moger@amd.com>
---
v10: The call mbm_cntr_reset() has been moved to earlier patch.
     Minor documentation update.

v9: Fixed extra spaces in user documentation.
    Fixed problem changing the mode to mbm_cntr_assign mode when it is
    not supported. Added extra checks to detect if systems supports it.
    Used the rdtgroup_cntr_id_init to initialize cntr_id.

v8: Reset the internal counters after mbm_cntr_assign mode is changed.
    Renamed rdtgroup_mbm_cntr_reset() to mbm_cntr_reset()
    Updated the documentation to make text generic.

v7: Changed the interface name to mbm_assign_mode.
    Removed the references of ABMC.
    Added the changes to reset global and domain bitmaps.
    Added the changes to reset rmid.

v6: Changed the mode name to mbm_cntr_assign.
    Moved all the FS related code here.
    Added changes to reset mbm_cntr_map and resctrl group counters.

v5: Change log and mode description text correction.

v4: Minor commit text changes. Keep the default to ABMC when supported.
    Fixed comments to reflect changed interface "mbm_mode".

v3: New patch to address the review comments from upstream.
---
 Documentation/arch/x86/resctrl.rst     | 15 ++++++++
 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 50 +++++++++++++++++++++++++-
 2 files changed, 64 insertions(+), 1 deletion(-)

diff --git a/Documentation/arch/x86/resctrl.rst b/Documentation/arch/x86/resctrl.rst
index 3ec14c314606..d3a8a34cf629 100644
--- a/Documentation/arch/x86/resctrl.rst
+++ b/Documentation/arch/x86/resctrl.rst
@@ -290,6 +290,21 @@ with the following files:
 	"mbm_total_bytes" or "mbm_local_bytes" will report 'Unavailable' if
 	there is no counter associated with that event.
 
+	* To enable "mbm_cntr_assign" mode:
+	  ::
+
+	    # echo "mbm_cntr_assign" > /sys/fs/resctrl/info/L3_MON/mbm_assign_mode
+
+	* To enable default monitoring mode:
+	  ::
+
+	    # echo "default" > /sys/fs/resctrl/info/L3_MON/mbm_assign_mode
+
+	The MBM events (mbm_total_bytes and/or mbm_local_bytes) associated with
+	counters may reset when "mbm_assign_mode" is changed. Moving to
+	mbm_cntr_assign mode require users to assign the counters to the events.
+	Otherwise, the MBM event counters will return "Unassigned" when read.
+
 "num_mbm_cntrs":
 	The number of monitoring counters available for assignment when the
 	architecture supports mbm_cntr_assign mode.
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index 8d00b1689a80..eea534cce3d0 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -939,6 +939,53 @@ static void mbm_cntr_reset(struct rdt_resource *r)
 	}
 }
 
+static ssize_t rdtgroup_mbm_assign_mode_write(struct kernfs_open_file *of,
+					      char *buf, size_t nbytes, loff_t off)
+{
+	struct rdt_resource *r = of->kn->parent->priv;
+	int ret = 0;
+	bool enable;
+
+	/* Valid input requires a trailing newline */
+	if (nbytes == 0 || buf[nbytes - 1] != '\n')
+		return -EINVAL;
+
+	buf[nbytes - 1] = '\0';
+
+	cpus_read_lock();
+	mutex_lock(&rdtgroup_mutex);
+
+	rdt_last_cmd_clear();
+
+	if (!strcmp(buf, "default")) {
+		enable = 0;
+	} else if (!strcmp(buf, "mbm_cntr_assign")) {
+		if (r->mon.mbm_cntr_assignable) {
+			enable = 1;
+		} else {
+			ret = -EINVAL;
+			rdt_last_cmd_puts("mbm_cntr_assign mode is not supported\n");
+			goto write_exit;
+		}
+	} else {
+		ret = -EINVAL;
+		rdt_last_cmd_puts("Unsupported assign mode\n");
+		goto write_exit;
+	}
+
+	if (enable != resctrl_arch_mbm_cntr_assign_enabled(r)) {
+		ret = resctrl_arch_mbm_cntr_assign_set(r, enable);
+		if (!ret)
+			mbm_cntr_reset(r);
+	}
+
+write_exit:
+	mutex_unlock(&rdtgroup_mutex);
+	cpus_read_unlock();
+
+	return ret ?: nbytes;
+}
+
 #ifdef CONFIG_PROC_CPU_RESCTRL
 
 /*
@@ -2222,9 +2269,10 @@ static struct rftype res_common_files[] = {
 	},
 	{
 		.name		= "mbm_assign_mode",
-		.mode		= 0444,
+		.mode		= 0644,
 		.kf_ops		= &rdtgroup_kf_single_ops,
 		.seq_show	= rdtgroup_mbm_assign_mode_show,
+		.write		= rdtgroup_mbm_assign_mode_write,
 		.fflags		= RFTYPE_MON_INFO,
 	},
 	{
-- 
2.34.1


