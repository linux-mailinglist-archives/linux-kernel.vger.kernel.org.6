Return-Path: <linux-kernel+bounces-441962-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 306189ED631
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 20:16:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 28D0B188A708
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 19:13:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03EB720A5F9;
	Wed, 11 Dec 2024 18:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="gVUE6/eq"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2071.outbound.protection.outlook.com [40.107.237.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1B7B20A5CF
	for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 18:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733943419; cv=fail; b=DMVUBApTm+uBki3C8I09saSFgOgkzk4gosUDi5xbwiep8HqQQNXfxvUW7i9mRb+/nvWMRpk18d0heqY6MUntzDYeuEFyPqBHJL6B7Rs4BjxtjY7VT2OIKVOZEOZsKt9Cm21ScROU2fSfe1layW7RERQEoIn29Q3ZDEmKEPmZG78=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733943419; c=relaxed/simple;
	bh=oCZxi9XQ9uIRRMKF52NZsTtbklkyWtIIRdUBT8vMGUQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ku699TS8v6+tiwNd5ImwNWrj7KHOlXxKnZLwdlz3jnaVthdmbBTeoVNzFNY5NztEQrqzg3RnHmEzvj+n2LUq/aaUgL2ckiqkXSH1f39xT1d14o7A5RgpY/MSkaYap3aMDAYaiCBQOu3z2R99jl8VSUnnjIbtWXJAARuwM4q6ESE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=gVUE6/eq; arc=fail smtp.client-ip=40.107.237.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LgX6UPTUDoBaJ/Io4kv37l5EreBCR4oTPvlJ+yWKjtjJHZPkjIUFjSHK/u4gi54upn3SS330Zs2cHACKCAgc0fwPgcnsTgRdrAmsaWhe3v9IrxgCnLwbx+iRMXAqvCx/aAi5KrUy/XpdD45kzxaL7cM1KMR9VKGBdS7WNRZJc8iW8x4Xdm11t2dQcyQawMVKjW1UIt9giYKv963Q94ricmwkXbjMfTu8SBO1FuWtqALWAy7CkCcuxsm4T5YrUD10/sRWi0kRyujkqTM2RBqocW1kAD0Ou79mGyzc3k4Srl/h6FQiltSjcWF9o58d5Rx5t9uoOzLEo/3/8x+BcFsTHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GgEV8Rli23FQjzDVZgnAq8bXtnae+/SnvmunJimgeYE=;
 b=TtO1gDzkhzo1isCKEd7xyOFI2m2giwXcMWiW/sP92rX2Pei+ghQb1NbRdixRu6Ff0HT+laGq5GUDeEEohCFDIe30NnKyfUFCA0s48bOvU0YaWdkqKoS7Huu+pjRe9yRspFPeElyhRqo4LvyIyuJpBgJX9D8cLbjHoMmUnPfuNQArsGaMTQ65Y79yE3pl8/Z/FTLWk434v8wMdElQlPHb9Q5HEz6B5uSkJZxZFgIwDvr9bCEaLJvj8KByXY0LpJ4cl9V4FHWDhfJBC9/hIuXdctD+XtLLF6IynKzIYK9hg4JxQy7zvpYdFgD1l3GDEXN1U1S8Mrjo9h29FY97YsM5ww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linutronix.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GgEV8Rli23FQjzDVZgnAq8bXtnae+/SnvmunJimgeYE=;
 b=gVUE6/eq2prsBCSn1BIlyh83qYb8435Sqo7dd6dfDJ+dn+7SgswbrxePCt07JvJE5Axto+MvFlS8XouHZ4lvRv2RQXzHR3ufKXhwTcWrKrxzhv3Xfprc2XJxBB2TYjpLkNkd+2mYEvpYJvnyGilbA5btN4pJMPWnrIdoabTYr1k=
Received: from PH0PR07CA0047.namprd07.prod.outlook.com (2603:10b6:510:e::22)
 by MW5PR12MB5684.namprd12.prod.outlook.com (2603:10b6:303:1a1::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.14; Wed, 11 Dec
 2024 18:56:46 +0000
Received: from SA2PEPF000015C6.namprd03.prod.outlook.com
 (2603:10b6:510:e:cafe::27) by PH0PR07CA0047.outlook.office365.com
 (2603:10b6:510:e::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8230.18 via Frontend Transport; Wed,
 11 Dec 2024 18:56:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF000015C6.mail.protection.outlook.com (10.167.241.196) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8251.15 via Frontend Transport; Wed, 11 Dec 2024 18:56:45 +0000
Received: from BLRKPRNAYAK.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 11 Dec
 2024 12:56:38 -0600
From: K Prateek Nayak <kprateek.nayak@amd.com>
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
	Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>, <x86@kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: "H. Peter Anvin" <hpa@zytor.com>, Dietmar Eggemann
	<dietmar.eggemann@arm.com>, Steven Rostedt <rostedt@goodmis.org>, Ben Segall
	<bsegall@google.com>, Mel Gorman <mgorman@suse.de>, Valentin Schneider
	<vschneid@redhat.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Ricardo Neri <ricardo.neri-calderon@linux.intel.com>, Tim Chen
	<tim.c.chen@linux.intel.com>, Mario Limonciello <mario.limonciello@amd.com>,
	Meng Li <li.meng@amd.com>, Huang Rui <ray.huang@amd.com>, "Gautham R. Shenoy"
	<gautham.shenoy@amd.com>, K Prateek Nayak <kprateek.nayak@amd.com>
Subject: [PATCH 2/8] x86/itmt: Use guard() for itmt_update_mutex
Date: Wed, 11 Dec 2024 18:55:45 +0000
Message-ID: <20241211185552.4553-3-kprateek.nayak@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241211185552.4553-1-kprateek.nayak@amd.com>
References: <20241211185552.4553-1-kprateek.nayak@amd.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF000015C6:EE_|MW5PR12MB5684:EE_
X-MS-Office365-Filtering-Correlation-Id: aa7614e7-dbc1-4015-ef40-08dd1a158f4e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|36860700013|7416014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?hBS7Cs+ryq2DzvVp4i/wia4alqTNmArvvvwM4s7b5RGn0Wyznf+OWOjDP+xK?=
 =?us-ascii?Q?44oJsec0W0jaCHLWYGez/nICVqC2farxmgiIfBGXy+bP0xFQy/O/sGLoUMp8?=
 =?us-ascii?Q?qNkJDHijLKxsVXU4bYdeIWsKXvJSdGc3K2QUPKbDbJYtZIIvtNl/AeAg2/ut?=
 =?us-ascii?Q?Xab1rJaywhDK0btwAP+gaBME08ZBQvtpTJjWrFFmTSRHVfS9satv4kBEHapi?=
 =?us-ascii?Q?2TXVKT/HFwJc+/1wuNtql30X3Fx/0+41V0D1wNBZUR3sUnE9b155NOxdufaw?=
 =?us-ascii?Q?aB0slGJr7VfFk7bdoE/7r6yMjqHVtYDlwznk1+GOdteMqB/gDNCQmdFA1arK?=
 =?us-ascii?Q?GXCph/9/P1fCGgzFpXaw3hvn3YsuHT6OvGGg2/Oie5qcl/aJ9PNf3qUuqxgL?=
 =?us-ascii?Q?0sm+jyDNQErWwoRIDshOwXk+v9wzdz720iqkduypyM7OMgWanjk3bqXCHN5T?=
 =?us-ascii?Q?aix+F/CZohPnp4N+RO2U20yMrhsHQA24dvdve5LSYSZkzRXQjzieq6Mi40VZ?=
 =?us-ascii?Q?5H1wvSrR5WpgCKmVXx+grF8A15bgFa6thiUKqRDpa9zY4/PzsvnNKiZZ605O?=
 =?us-ascii?Q?7Rh5dOJBNn2t6/+XSaJYfuRE2C/t+CnGh/ikGZeDpocDUk9jatLizdCTXafp?=
 =?us-ascii?Q?EWxDP6Y/TcbSHhq+VnvuCsAkOXQf5xTD8npV291s2Y78DRb7qvSEgV3XYcOf?=
 =?us-ascii?Q?DCQ5L6kLCYckrh2mtZZs+jUm1Jw1v06QRyA3V4ppFGEL3TzyqV36FxoM9uLk?=
 =?us-ascii?Q?KutpJ8g+1OgXxCWCdWOoeZA3qwl66ZpA9lTEi3ivGUdqFM+d8bAB1Kw7oREr?=
 =?us-ascii?Q?Pdecn8kAh0Hxlh6YL4jlUe12Gm9AVlgyDnvkMYNqdVhW7i/carj1WmhSTxIM?=
 =?us-ascii?Q?hU1Mvo5Mgms+9VkI8cx8jwjpnpbS9oeuJH/J59ruKi8FDz+lvwqTTZejD96d?=
 =?us-ascii?Q?yIb08mM0/JC1OXCa56UlLH+AiRiI7KmYmPZsJxRZNJuQkdqO3unEawpB958I?=
 =?us-ascii?Q?8n/sg3tDpchyjCYgRTx8yOMujClGOTQ2QEm+V2/y3voVy2Jy1fXNVdB9+amL?=
 =?us-ascii?Q?xen8xJveSMFxBOpK2OfkCQ5xTIIskgceAUhw0Zn2ilRRtK9pZHIly8U4ktdk?=
 =?us-ascii?Q?MaOVviVw3rPrUfREu/TPEckyE4YeXYddemuHIEvXc5lwW/YAji8OjT0AbNrY?=
 =?us-ascii?Q?pU5zvm2oPyYuvdYMeG3B4BdSMElk49RUiWQbW6jvXgDdPYPH49mKtXfb2vV8?=
 =?us-ascii?Q?tUTtj+/Vr1bRDg7ALRc0aFATxwgWdUk3AkGAPbTvtorXMs2uC3UAdVZWsCbr?=
 =?us-ascii?Q?OXI48jXoNEAWQMAcsKuZud6MaILkmpmbRqEL1V21EhKqdf0LtWTl6oDaU8A6?=
 =?us-ascii?Q?vmQrJ9tqIERUm5I+LQYwxSLTnDVgnMZmDI3731BZm+DoW9p+b35uPUG3L4bb?=
 =?us-ascii?Q?Pccm0XTmlridL1DnjZ5k7Nhb9+KesORU?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(36860700013)(7416014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2024 18:56:45.6491
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aa7614e7-dbc1-4015-ef40-08dd1a158f4e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF000015C6.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR12MB5684

Use guard() for itmt_update_mutex which avoids the extra mutex_unlock()
in the bailout and return paths.

Signed-off-by: K Prateek Nayak <kprateek.nayak@amd.com>
---
 arch/x86/kernel/itmt.c | 29 ++++++++---------------------
 1 file changed, 8 insertions(+), 21 deletions(-)

diff --git a/arch/x86/kernel/itmt.c b/arch/x86/kernel/itmt.c
index 28f449123d68..ee43d1bd41d0 100644
--- a/arch/x86/kernel/itmt.c
+++ b/arch/x86/kernel/itmt.c
@@ -44,12 +44,10 @@ static int sched_itmt_update_handler(const struct ctl_table *table, int write,
 	unsigned int old_sysctl;
 	int ret;
 
-	mutex_lock(&itmt_update_mutex);
+	guard(mutex)(&itmt_update_mutex);
 
-	if (!sched_itmt_capable) {
-		mutex_unlock(&itmt_update_mutex);
+	if (!sched_itmt_capable)
 		return -EINVAL;
-	}
 
 	old_sysctl = sysctl_sched_itmt_enabled;
 	ret = proc_dointvec_minmax(table, write, buffer, lenp, ppos);
@@ -59,8 +57,6 @@ static int sched_itmt_update_handler(const struct ctl_table *table, int write,
 		rebuild_sched_domains();
 	}
 
-	mutex_unlock(&itmt_update_mutex);
-
 	return ret;
 }
 
@@ -97,18 +93,14 @@ static struct ctl_table_header *itmt_sysctl_header;
  */
 int sched_set_itmt_support(void)
 {
-	mutex_lock(&itmt_update_mutex);
+	guard(mutex)(&itmt_update_mutex);
 
-	if (sched_itmt_capable) {
-		mutex_unlock(&itmt_update_mutex);
+	if (sched_itmt_capable)
 		return 0;
-	}
 
 	itmt_sysctl_header = register_sysctl("kernel", itmt_kern_table);
-	if (!itmt_sysctl_header) {
-		mutex_unlock(&itmt_update_mutex);
+	if (!itmt_sysctl_header)
 		return -ENOMEM;
-	}
 
 	sched_itmt_capable = true;
 
@@ -117,8 +109,6 @@ int sched_set_itmt_support(void)
 	x86_topology_update = true;
 	rebuild_sched_domains();
 
-	mutex_unlock(&itmt_update_mutex);
-
 	return 0;
 }
 
@@ -134,12 +124,11 @@ int sched_set_itmt_support(void)
  */
 void sched_clear_itmt_support(void)
 {
-	mutex_lock(&itmt_update_mutex);
+	guard(mutex)(&itmt_update_mutex);
 
-	if (!sched_itmt_capable) {
-		mutex_unlock(&itmt_update_mutex);
+	if (!sched_itmt_capable)
 		return;
-	}
+
 	sched_itmt_capable = false;
 
 	if (itmt_sysctl_header) {
@@ -153,8 +142,6 @@ void sched_clear_itmt_support(void)
 		x86_topology_update = true;
 		rebuild_sched_domains();
 	}
-
-	mutex_unlock(&itmt_update_mutex);
 }
 
 int arch_asym_cpu_priority(int cpu)
-- 
2.34.1


