Return-Path: <linux-kernel+bounces-356048-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 490A2995B7D
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 01:19:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 63CE41C214BA
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 23:19:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E234633986;
	Tue,  8 Oct 2024 23:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="kPWJNPJa"
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11020112.outbound.protection.outlook.com [52.101.56.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A49E1217900
	for <linux-kernel@vger.kernel.org>; Tue,  8 Oct 2024 23:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728429532; cv=fail; b=iMhqlN8NP3R/cOGQWdfy+NsbjOPUUmSxLvszDxuCNaR3QaxMjXmg91QylWCzldNuI1kFCI4PU/p/4bcUhFlpTn4LaEB/BLc6TScw9gJKiyO79NHpVCiUhTxJAyXDNgBLgHg600fTctWUulqx4VN+zua8GI0ImBSJryzj9skBGjs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728429532; c=relaxed/simple;
	bh=vA8cZRLzoBmsEN7oQfM3JvpYWQSs5VWFL+EcNDq+0Eo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=tuF1NnTx4sjMvm6K91L0VXKBMtL65502Rh5/oGzbrK1LT7ziUB9xSeZ3+oSuufLbqU59KIAgKpV6Vjg11xHBHKOyk+ksKy+cbO8VSWIy734crn8dnaAg3JnROYJ7gm1wX06bCwr0tjQaQfAK7iZPC6fi78xlPO1aYe3T6VnqX4I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=kPWJNPJa; arc=fail smtp.client-ip=52.101.56.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QO7k7o8iAVd/q4rLiu8ACQD4PcsoDd0wX5GB+RsLS9OCiGiqWDnCA8E2zPdvXeztH2dJZPKtTfa/pqT1p0H+dkjbjeBHdi91LQQ0txZ5fmwxZ2o8OFPOMOFePjA4FwD2/jLLFV3N6+Ear3UUu9aejJdyMY917mt+J97dguQL1yKDx5BU6FcokepX1c1ojYoPtEZv6aaSDCA7jKJtMN/qWMCAEaZhn7c0mFIJff0sKy2Aip85SdyPXdnLYMiB+FdkonIYyhr/QkWOWIeKDDytMbcGm/RP/0QXzokvQQzRxsPx/qTG9hkcrAepF/AOXlP6sE8zpsN2acm/8lF2TBH1gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x+OOidj88uL/R5SQ6fv26x8Tuc/FiDvVh1S3Uq5UsPc=;
 b=kGa9WnSbIjiXlFsvVC29YLfY03mn8p/Shl+FvEJwE0W+qdD2M25tUpwOD6HvqtgkyMUajiuQJ0WOqJ+nTopW+LAR6hy2gcLP19bl5B/mpn+uyMwM/cMXi/NjyzRP94SazXgT8XN4hoUdUuHFH+TuXnvwFxZsnFfe+ssJ2VSmO/gpKG0GJeG4ulk3KO3WEHD4PTLM4eRWFny1XopPH/yiwZpX2qPkQI22u5lUZIfUVFQo6XspVhJZc7ZYBSzB6X6E86WrbMagjsiebaOYSVCAE9ipAGkQfLmAd1Pvc3xMV7kxp7CorCTJVk4KSNSPeXW3p80IxFDWqjW3p60jU6RYdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x+OOidj88uL/R5SQ6fv26x8Tuc/FiDvVh1S3Uq5UsPc=;
 b=kPWJNPJa0mBE1sJzrp0NIBnbk/kdruZSEyioUuaTMRT4KV8FxxMHVEioFjlrvjfMQS2jNDosYwvzqKz2tf/96kvAem/w/pPoXPsSeLvoEQrAR5oMaRWOnp1p1ThOTj3+JZTBa98rH6dyPPziRlgGxvr13j3lbzBAGAFS8apPs34=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from MW4PR01MB6228.prod.exchangelabs.com (2603:10b6:303:76::7) by
 LV3PR01MB8463.prod.exchangelabs.com (2603:10b6:408:1a2::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7982.29; Tue, 8 Oct 2024 23:18:47 +0000
Received: from MW4PR01MB6228.prod.exchangelabs.com
 ([fe80::13ba:df5b:8558:8bba]) by MW4PR01MB6228.prod.exchangelabs.com
 ([fe80::13ba:df5b:8558:8bba%7]) with mapi id 15.20.7982.033; Tue, 8 Oct 2024
 23:18:47 +0000
From: Ilkka Koskinen <ilkka@os.amperecomputing.com>
To: Shuai Xue <xueshuai@linux.alibaba.com>,
	Jing Zhang <renyu.zj@linux.alibaba.com>,
	Will Deacon <will@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Ilkka Koskinen <ilkka@os.amperecomputing.com>
Subject: [PATCH 2/3] perf/dwc_pcie: Load DesignWare PCIe PMU driver automatically on Ampere SoCs
Date: Tue,  8 Oct 2024 23:18:23 +0000
Message-ID: <20241008231824.5102-3-ilkka@os.amperecomputing.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241008231824.5102-1-ilkka@os.amperecomputing.com>
References: <20241008231824.5102-1-ilkka@os.amperecomputing.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CYZPR19CA0023.namprd19.prod.outlook.com
 (2603:10b6:930:8e::29) To MW4PR01MB6228.prod.exchangelabs.com
 (2603:10b6:303:76::7)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR01MB6228:EE_|LV3PR01MB8463:EE_
X-MS-Office365-Filtering-Correlation-Id: c54889d9-98eb-4378-9636-08dce7ef8faf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|52116014|376014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?LH0SvkR6LPOyDXYlDjRTtegWNchq3EIx2IwuWtHHzs8GP8c+A40kcvIPHYx7?=
 =?us-ascii?Q?VkRz5BAc8l2/HGNeKKFvBgpZrEWDHoJBkkZ9LZsPLNqRHN+cxPpfwAOJG0E+?=
 =?us-ascii?Q?dcosLYqaoTe3U9RV7HPVq+fZB1cnEjhbi7PWgWLp2mpKMjPo+xmbp6ex/pzX?=
 =?us-ascii?Q?ddxDpSjoVEQOKLAUUGsS24jxGoBd6o7VkCl04NsoFKoxKYcAg5TvdsVWpYm6?=
 =?us-ascii?Q?cdPI8NAxtxW3ZdI1zrE8yzRbqZCWjnnJW1Ubg41XDyUG30CForubWKYzn7uV?=
 =?us-ascii?Q?ZfZjAJBBTa5bRyghOl1zALL/wCpLB5FaE3MCvGNYPuuJpIxbPpVX9T8iG+ma?=
 =?us-ascii?Q?iHXgIXq9nGhTP0XGZhuOg55m5FwfhCTYDSkLynVySMgdacBfNVmTVx2gL3oS?=
 =?us-ascii?Q?kyJ+atf1j4kgYZsJlbQjjLiM0dlehifGC/TAkGR6PWLqi3NCKOAwR0NMPnkW?=
 =?us-ascii?Q?fnu0Ea7PDXnfWsCBI8p6vGrZdZIElufSZWRiR4Sf0zfd0T4bPDieIolnNylq?=
 =?us-ascii?Q?xYAU2wyCYA5uwS+zRew4LqLH9N1pfXOo27e31QlLPqDfl3XBO+GQkNVIbIli?=
 =?us-ascii?Q?wQ3Kyq4jz41URNh5WqiWPtIMJSM1PQqd+q6aknPqIGIneMZAJWi0LcPDq8YR?=
 =?us-ascii?Q?4FllCcW9x1Q6M52FC1ojGP7fxSsau4z8vg2i5X0I2Og0a+dTjIDOWiTsosCs?=
 =?us-ascii?Q?k+eY+oa/bNe6g37nKU7/YVE6N93kx3EbMv8mUOILRJx9NYrulnv91WyJMldc?=
 =?us-ascii?Q?3q6NRacbBfIRPfCJ6EPba8ZuImJOhbKveHMMwZCdWM9a14c37ckyPC13K8oI?=
 =?us-ascii?Q?o4lNxyAXc5ITLjjvR4t6KHb711pfs3xrbKPHTrsCucS8xT8lWuhML5w5sLpq?=
 =?us-ascii?Q?IXlUBabdAo42GRmn3a4z9QztDE413K75pEikHyBgJmNOjjYW1L9O2+GRj7eZ?=
 =?us-ascii?Q?bN7wMR5BES6fSe51CZeTzr1lfbCLlrlU2Biy6BxcyjxOz/rZe4bsjGOvRWtL?=
 =?us-ascii?Q?stjN/glQH+JXvdWwoLhb8fvQmoztTyLjp4ZXDgJsdHREEoWmFkFQaEgLrBwj?=
 =?us-ascii?Q?vsxEAZv2ArKDt1oba5oEIRDSjQv+zB3AASXS3UuPm28LrIWrPh42hsjJT+Sa?=
 =?us-ascii?Q?GRYhiwEy8vWGN//4C86/A+xioHak31/0U7YLXVVcK1NTZ9yezzcVTV+q3jWQ?=
 =?us-ascii?Q?o/37GBiJQAJSQnjGSrRAXc7Ekc1cmTqePmvDICCo4COBcXFK7lZdBD6IAAn3?=
 =?us-ascii?Q?b8eOZR4ue0XxOqCNgRRwQcGTQASApcj8I/X5DNo6P7BvOOnYFLlTCCdYDg4t?=
 =?us-ascii?Q?ogX05hN66d5MPulyS3IwBdaeU+QyPd46W8ihGHRH6XXrCg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR01MB6228.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(376014)(1800799024)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?L3xOjJMq2SqOZiQ4CqjClaJML6fa17ZDDSa8MVCjQO9elLTw9q/cZSmqBxUy?=
 =?us-ascii?Q?9kx4iNKJetfgXpbqt7g4iP5f/zcPr0ragJlbVEjnxJC9tOpivhl4Epo9ls7f?=
 =?us-ascii?Q?63oFs72Kg8mFvtfabfygCi25H/DtrUczV7/PQMcHboogB1uSBcbmiJzjzNxg?=
 =?us-ascii?Q?5mH0ckA7oko3d2DjUlcNNgYtsTYLSaLcp1TANQddUzGjAFHVxYPBcdrqD3iF?=
 =?us-ascii?Q?dpir94D66LBw4YyyfCYuurzEecypE6U3EoDB5taQeqW9LSTsmBqDyN1NHbME?=
 =?us-ascii?Q?DjSXq3KrK2MoR2e3oortJJX79MbS75VWj5YDdMmEehJ1ZcWnwMX/8LSbrIXZ?=
 =?us-ascii?Q?n13GKYuMdlZ4npUS4FCmaf1pNuyEUiNQLg/uNwouyKGq8Kxp76jBSgio8w29?=
 =?us-ascii?Q?gjmwIhNuoE+4SDgplBw6R6wSrX7BrKC2Xl5lewkWba8NijYs7cINVmWG8H16?=
 =?us-ascii?Q?6lnYqHS25QmjpXQwqIl3dmbAytgzoO6zBLaulBQAkuqdquGQlVFBbcSUiPC9?=
 =?us-ascii?Q?WLMmkhbIR4WyUBkEKlJ87OK0OStA4uL8O0n0XYAWpnNHVGtzvI66aHAwHxop?=
 =?us-ascii?Q?+U31+yiMrSG7ZTnQTpTTBTK8lnoc6wMYbFfGjumGmT6BPtZFzfBerLhsbBnC?=
 =?us-ascii?Q?UQw5J6+FEaNttZQmpX+kWARnGZh8jEv5ad2OOw+GFotsBgoCp2zGDTk838Ev?=
 =?us-ascii?Q?VZJBDAqgabb2tI9OpYDrzWmpZOx2uEdHxoCI/Iwo5LDxogM+byqFzsuBsIlW?=
 =?us-ascii?Q?PhE4Ji+qUkXq3adiy8CyU0jCa2mIDN3C0jGi25etn10fYerOFZ3xc+ADjRgK?=
 =?us-ascii?Q?2Le9eoRSlDOC7+CdWYA/OWqhY9+rU2esUecT66v1CfXfaCM3dlxFh3zidtPE?=
 =?us-ascii?Q?WhKOlcRL5B+tZqABX7GLwicTf4CBoLXsdcWDWwnmqww5j7dqXNGPQnc8PCWX?=
 =?us-ascii?Q?qXU0NC4K+pip57o7FQ5/Yg7bhgh/NYNVa+AvjtQ6lVDxY0Hm49tcjyQ2uYuj?=
 =?us-ascii?Q?T1WBmCgw3OsX1ywwQttgbfe5TmZxY6m3u53bRlGn0ert52ionDfbyW4LlwaN?=
 =?us-ascii?Q?mEn2GzOgj2mYxuNPD+06ilIhwfdZqqzzMbgoWiMMmU+ai/Wyy5zlvZIGRn6o?=
 =?us-ascii?Q?nmlpq7OA/KOOLdMP4pL0/c4n9SrpCHLJfS3KH9ng7BSLhuxwcCAuhF0GbvNk?=
 =?us-ascii?Q?iV30p96qS9SqsK5MzenFmqevyEcp7Q1EVABYixx1g/b0/BnrwT6XXx5F+Ma6?=
 =?us-ascii?Q?XkW8gBGUrjVYddz3zEM9U0+3c9HaJjdWnItVOw54sHmivDjhM8CBbSkATU54?=
 =?us-ascii?Q?5PGAZLn4mN3VHTpoJrgBoSOp0e+decNpBlVg///JlCBVpGf2SstDJEMZ2Gav?=
 =?us-ascii?Q?x8YaV5PJECnnLqJtzdoFX8xIvN8rK3Bt3l5cRWcBALy9H+xqqK7U7WJqKx5e?=
 =?us-ascii?Q?sAw+GmQnBy10/epWw6RblKqHzaP4D32xmkFkSfb6wr0m22H50yyo9RecsPkD?=
 =?us-ascii?Q?3ofZECC6XgkzScQ6GlRtY1AGrM/L5IxTBj1EArGNWqX7abHJhNYUEhirAyHm?=
 =?us-ascii?Q?0EyqlaiTg4NmnMYKS39pTX2DHujukK4DyIeqhV+IZ59yA6OENqVcwfFyzjeN?=
 =?us-ascii?Q?DNaJxAglQUaRwRoD63gBDW0=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c54889d9-98eb-4378-9636-08dce7ef8faf
X-MS-Exchange-CrossTenant-AuthSource: MW4PR01MB6228.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2024 23:18:47.5457
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5NCNpDrDouh+vmc6B+kShbZkWuuEPC3HYpmSmkPJWtw+Dn2IBwDcQ6rZ5jNvCGOyNodl3Vzfz094IxEwrBEc3TDszgexSX1F7gx5on7HopaQB220WyJ2Yqv0B9Fd2PlE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR01MB8463

Load DesignWare PCIe PMU driver automatically if the system has a PCI
bridge by Ampere.

Signed-off-by: Ilkka Koskinen <ilkka@os.amperecomputing.com>
---
 drivers/perf/dwc_pcie_pmu.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/perf/dwc_pcie_pmu.c b/drivers/perf/dwc_pcie_pmu.c
index 3581d916d851..d752168733cf 100644
--- a/drivers/perf/dwc_pcie_pmu.c
+++ b/drivers/perf/dwc_pcie_pmu.c
@@ -782,6 +782,16 @@ static void __exit dwc_pcie_pmu_exit(void)
 module_init(dwc_pcie_pmu_init);
 module_exit(dwc_pcie_pmu_exit);
 
+static const struct pci_device_id dwc_pcie_pmu_table[] = {
+	{
+		PCI_DEVICE(PCI_VENDOR_ID_AMPERE, PCI_ANY_ID),
+		.class		= PCI_CLASS_BRIDGE_PCI_NORMAL,
+		.class_mask	= ~0,
+	},
+	{ }
+};
+MODULE_DEVICE_TABLE(pci, dwc_pcie_pmu_table);
+
 MODULE_DESCRIPTION("PMU driver for DesignWare Cores PCI Express Controller");
 MODULE_AUTHOR("Shuai Xue <xueshuai@linux.alibaba.com>");
 MODULE_LICENSE("GPL v2");
-- 
2.46.2


