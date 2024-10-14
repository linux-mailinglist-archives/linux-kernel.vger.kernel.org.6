Return-Path: <linux-kernel+bounces-363618-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CA8FB99C4BA
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 11:06:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4CD651F21095
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 09:06:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 054CB155725;
	Mon, 14 Oct 2024 09:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ZAITi7KG"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2075.outbound.protection.outlook.com [40.107.244.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8380A156678
	for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 09:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728896768; cv=fail; b=rgt+2OrLkJ0Y6nTho+GSnJna7UzoIH/wuhmq3ul99TdpaN7e1ibvWp3cuLxg8KAJpOL/l1GuNK/z2EFyrIhNjH5aE71qthN+N5jlI/AdgQI6Aoi+qQmiLbXSU0U2oxP4LAxVhYl/xOKYKm8lvrVu+x8TzGXwYa/PTswoNoVRNzc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728896768; c=relaxed/simple;
	bh=R7+nRUahrBD4bBgAcevzrlRasguwE8JpM1AOq4sal0E=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kf6qIFtl62c4ohXbV8gyRC5TXaOAMWj9I7NNla/wXMGqoHUPTBJGyFOtlcPB8lQFnAHRlYqbcxdkYE1D6CJzmT7tWsrr4hE6T1o7lRY5S6RM6PuaK7Up+oClBAdMX2bIoxbLPtIoJr39IZYGZP+0h1Qi2yOyS+YtjQsxbc/q7cQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ZAITi7KG; arc=fail smtp.client-ip=40.107.244.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KbuM6grMQPz3a7umC9hm+LCfPGgxwPB9By7n79tSC5tiVeNP81pTPLpBG9tb/6Qpg6SHGCHrPtCT+vpJG5pYjIWuBH9vrvQnbs8vsqMjMw1poskkte3NlPLoSVetmM4bBsV7pb1yQqrhz7UbmdO+GSb/1czDzshSxlhMiwHJ0EyvcDOFS1ZqUrmv+dBZdLLDBDr1UYRYnSn4UwyPAehcHuH02uOeGQL+F4mhIkjrIji3lsni5jUq7RkKy/Nydn1Q6uBCOPQWZl7MS0XwGCtk8NhOR9a0wNCFSdZ8VTbGpG1hLQtjvOpTckzVq7jLr+9BcSHKoll1fSkhfGYJs2OobQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J6h5i5pMa+w0iivB0qlD2WFylp3lL9ATtzHNSMFne8c=;
 b=jeLQxRw3MXmOFiTewbIM9oDgPwDzsofr5vvo/mxlLWB7PQCfPue5wNv/rvCEGaI97iq6uJYZAv+7Ae7GZhZjI7OfSikoEM8kIoiBpN61+NlpdxS761/UCd7kbEgkWBQXvipiF99xmus+apkjZRCPlZ0zl4KC76XV8eJEuB2/Ci5DjAJL9Ohdxlt6RVbAS0rj/bIam92OzrjjIwHgtF3e/nOf8B26lF+hqd9lfvO9Ov7sZboiwJr6yOchSpovyjEwPE95hNEVXbFe8MMVBE4Hzc+ogjjoEuiVwyJjXMbviQDGecFDXucVdohUZe+jSHu710QeivHiTSgTDpLBHT/5/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J6h5i5pMa+w0iivB0qlD2WFylp3lL9ATtzHNSMFne8c=;
 b=ZAITi7KGhqdQoOS36vC3UEG2IDUKjAqd+l2rbQw8xMAUv8UTtPqGi2IChcUAhuNMMCRiqFeEdI3MVk41yVcoNxaWkV2b0dAjo8dtgTm13B1HzML99eydhM6n+zo8gtBJW7+6AJoYGRd/wEsi8YDuKTlcL4Q02BHjbKR9VA74mEs=
Received: from PH7PR17CA0061.namprd17.prod.outlook.com (2603:10b6:510:325::11)
 by DS0PR12MB6656.namprd12.prod.outlook.com (2603:10b6:8:d2::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.25; Mon, 14 Oct
 2024 09:06:01 +0000
Received: from CY4PEPF0000EE3C.namprd03.prod.outlook.com
 (2603:10b6:510:325:cafe::94) by PH7PR17CA0061.outlook.office365.com
 (2603:10b6:510:325::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.26 via Frontend
 Transport; Mon, 14 Oct 2024 09:06:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE3C.mail.protection.outlook.com (10.167.242.13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8048.13 via Frontend Transport; Mon, 14 Oct 2024 09:06:00 +0000
Received: from BLRKPRNAYAK.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 14 Oct
 2024 04:05:52 -0500
From: K Prateek Nayak <kprateek.nayak@amd.com>
To: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot
	<vincent.guittot@linaro.org>, Thomas Gleixner <tglx@linutronix.de>,
	<linux-kernel@vger.kernel.org>, Sebastian Andrzej Siewior
	<bigeasy@linutronix.de>
CC: Dietmar Eggemann <dietmar.eggemann@arm.com>, Steven Rostedt
	<rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel Gorman
	<mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>, "Paul E.
 McKenney" <paulmck@kernel.org>, Rik van Riel <riel@surriel.com>, "Neeraj
 Upadhyay" <neeraj.upadhyay@kernel.org>, Leonardo Bras <leobras@redhat.com>,
	Thorsten Blum <thorsten.blum@toblux.com>, Zqiang <qiang.zhang1211@gmail.com>,
	Tejun Heo <tj@kernel.org>, NeilBrown <neilb@suse.de>, Caleb Sander Mateos
	<csander@purestorage.com>, "Gautham R . Shenoy" <gautham.shenoy@amd.com>,
	Chen Yu <yu.c.chen@intel.com>, Julia Lawall <Julia.Lawall@inria.fr>, "K
 Prateek Nayak" <kprateek.nayak@amd.com>
Subject: [PATCH v3 4/5] softirq: Unify should_wakeup_ksoftirqd()
Date: Mon, 14 Oct 2024 09:03:38 +0000
Message-ID: <20241014090339.2478-5-kprateek.nayak@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241014090339.2478-1-kprateek.nayak@amd.com>
References: <20241014090339.2478-1-kprateek.nayak@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3C:EE_|DS0PR12MB6656:EE_
X-MS-Office365-Filtering-Correlation-Id: 433099dc-0726-49f6-9bcf-08dcec2f6c5b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|7416014|376014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?8Q+fnqxWlFxUfZ0cJjedsRoQK6x1VpBaO9ks7M3dN6OAEy8RJairOhf2AwAD?=
 =?us-ascii?Q?PwIJiDlK2b4rFhL20LrT0nNAxm9jyckE37QK2UA2VF88++2silawTjwjc50l?=
 =?us-ascii?Q?ctDhcqmpWaiGksbENkYptrtSRhdApP8MiZCoVInjzvi/6ViS8L1GDWxgN957?=
 =?us-ascii?Q?UmIaPVq+qvStQG2pENFGYmprecDRY8qd2TBk8Y7MQIcFBWzQvnD25jXTxqaf?=
 =?us-ascii?Q?z61a11E5aLRDzsHoL1bM/Og0PacbFdC1W7QijOL5ocbB4TQdFGrALnGbVAXk?=
 =?us-ascii?Q?UxsfNIUczP7s82pRUi04CL78rndozT8Vw8sTuobbd/TVTmbgkrFZWq6UZYqu?=
 =?us-ascii?Q?rzgN21lS+DsRsjH3QhBMV03sE1KKWhZZzVgiorPgVOIIUIBzcPHFRYmHBxCn?=
 =?us-ascii?Q?AFIzrUeDj/9Vg+Qs1gn+avtBSm20rSZg6nKzpA4XUa3rgI7xwDGWz5nyO3WK?=
 =?us-ascii?Q?/Ik56G6V8vyOnuNFi8ixi6Nfj2ZxHIoGwandbMJEswoH5oVO+1TDundgvS9p?=
 =?us-ascii?Q?Y7vE4yPPcrfFYeL0YhmK2tHEzGXgWwlWmMDiOs6bAmEs6AsFX0CZuPHDA2Or?=
 =?us-ascii?Q?47GKLSBB7CqhJ9uNX1Vx6DT+8jf64QNufwO5knqOqOyhaTGirnk7ucAn79/q?=
 =?us-ascii?Q?DmIyLnpBJDaLg6LUFkRG8C8a3R8mMGH5hPgMuSy4mN4f4yONHhjUWykJEHs/?=
 =?us-ascii?Q?tysnNrQw6NxDJOLFuF3+10MGU8Sv0unFrZxIVTnctCm9UODP7eD2OhBuGQtL?=
 =?us-ascii?Q?d/JvUTFv8on4HJnJ0IJal696EUp9afX+zZCuJ5CGwDGe94DyrZQpoe3msg2I?=
 =?us-ascii?Q?lOcaIDJLyuhAfoWSOvEMHwJiF9C8hjnRnU2ZwXULxS0n1qAewn70IvcfGYAF?=
 =?us-ascii?Q?pJ0KrgSfYUXULt949ePlEoB69EViNFXc67SzVJQCZ158e3UMmCvdiyMhOTd9?=
 =?us-ascii?Q?VG9DdFK+gzyvihoxxyhuog8iODBFEqQ4o4Hp4TUMBkynFcxW+img92aS2yTz?=
 =?us-ascii?Q?djB9rjO2YRRHOZ+HLMrG3auNTb24rf6RRtkCQhslqtHrnVnZ4LN5lkP7F0X2?=
 =?us-ascii?Q?FIr40xqGInKGhrlL5R8T2KlaYEC/LIVeDOFRZ/MwKZVGLAFH/sfbVs3g1jkg?=
 =?us-ascii?Q?nFnRFc4wBxCm2yTkM0P/psEjCX54P0DHBCQijSArmuwIOWjK95ab4VcO8MxA?=
 =?us-ascii?Q?7SGXsjtu9ewtIzxyaWVST3WsliRDyHFZbQHJzrVcIpvgaafaLN/fvapuzji7?=
 =?us-ascii?Q?3yyKlULfu0TqCxfBQYeBZW1h9W8SV6x+99Cvw+liw5+8t7OyH5iKHjunJZJv?=
 =?us-ascii?Q?qrrmeVbvEmJoAZhuMymZ/emRQiBLw94HaqHbpUT+6iHyMMgWtyTXCUSXVFJZ?=
 =?us-ascii?Q?T74gBrk0hJZPnPYccj3uVfDjPKVW?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(7416014)(376014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2024 09:06:00.3610
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 433099dc-0726-49f6-9bcf-08dcec2f6c5b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE3C.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6656

Define softirq_ctrl::cnt for !PREEMPT_RT kernels too and unify
should_wakeup_ksoftirqd() to return based on softirq_ctrl::cnt.
Since these counts can change quite frequently when running interrupt
heavy benchmark, declare per-cpu softirq_ctrl as cacheline aligned.

No functional changes intended since !PREEMPT_RT kernels do not
increment the softirq_ctrl::cnt (yet) and should always return true
mimicking the current behavior.

Signed-off-by: K Prateek Nayak <kprateek.nayak@amd.com>
---
v2..v3:

o Removed ifdefs around local_lock_t. (Peter)
---
 kernel/softirq.c | 51 ++++++++++++++++++++++--------------------------
 1 file changed, 23 insertions(+), 28 deletions(-)

diff --git a/kernel/softirq.c b/kernel/softirq.c
index fc8c3a7dbe35..0730c2b43ae4 100644
--- a/kernel/softirq.c
+++ b/kernel/softirq.c
@@ -88,23 +88,6 @@ EXPORT_PER_CPU_SYMBOL_GPL(hardirqs_enabled);
 EXPORT_PER_CPU_SYMBOL_GPL(hardirq_context);
 #endif
 
-/*
- * SOFTIRQ_OFFSET usage:
- *
- * On !RT kernels 'count' is the preempt counter, on RT kernels this applies
- * to a per CPU counter and to task::softirqs_disabled_cnt.
- *
- * - count is changed by SOFTIRQ_OFFSET on entering or leaving softirq
- *   processing.
- *
- * - count is changed by SOFTIRQ_DISABLE_OFFSET (= 2 * SOFTIRQ_OFFSET)
- *   on local_bh_disable or local_bh_enable.
- *
- * This lets us distinguish between whether we are currently processing
- * softirq and whether we just have bh disabled.
- */
-#ifdef CONFIG_PREEMPT_RT
-
 /*
  * RT accounts for BH disabled sections in task::softirqs_disabled_cnt and
  * also in per CPU softirq_ctrl::cnt. This is necessary to allow tasks in a
@@ -122,10 +105,32 @@ struct softirq_ctrl {
 	int		cnt;
 };
 
-static DEFINE_PER_CPU(struct softirq_ctrl, softirq_ctrl) = {
+static DEFINE_PER_CPU_ALIGNED(struct softirq_ctrl, softirq_ctrl) = {
 	.lock	= INIT_LOCAL_LOCK(softirq_ctrl.lock),
 };
 
+static inline bool should_wake_ksoftirqd(void)
+{
+	return !this_cpu_read(softirq_ctrl.cnt);
+}
+
+/*
+ * SOFTIRQ_OFFSET usage:
+ *
+ * On !RT kernels 'count' is the preempt counter, on RT kernels this applies
+ * to a per CPU counter and to task::softirqs_disabled_cnt.
+ *
+ * - count is changed by SOFTIRQ_OFFSET on entering or leaving softirq
+ *   processing.
+ *
+ * - count is changed by SOFTIRQ_DISABLE_OFFSET (= 2 * SOFTIRQ_OFFSET)
+ *   on local_bh_disable or local_bh_enable.
+ *
+ * This lets us distinguish between whether we are currently processing
+ * softirq and whether we just have bh disabled.
+ */
+#ifdef CONFIG_PREEMPT_RT
+
 /**
  * local_bh_blocked() - Check for idle whether BH processing is blocked
  *
@@ -270,11 +275,6 @@ static inline void ksoftirqd_run_end(void)
 static inline void softirq_handle_begin(void) { }
 static inline void softirq_handle_end(void) { }
 
-static inline bool should_wake_ksoftirqd(void)
-{
-	return !this_cpu_read(softirq_ctrl.cnt);
-}
-
 static inline void invoke_softirq(void)
 {
 	if (should_wake_ksoftirqd())
@@ -419,11 +419,6 @@ static inline void ksoftirqd_run_end(void)
 	local_irq_enable();
 }
 
-static inline bool should_wake_ksoftirqd(void)
-{
-	return true;
-}
-
 static inline void invoke_softirq(void)
 {
 	if (!force_irqthreads() || !__this_cpu_read(ksoftirqd)) {
-- 
2.34.1


