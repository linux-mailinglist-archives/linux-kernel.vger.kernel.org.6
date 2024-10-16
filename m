Return-Path: <linux-kernel+bounces-368757-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 151EE9A1490
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 23:02:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 37F1B1C24884
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 21:02:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CED881C4A28;
	Wed, 16 Oct 2024 21:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="Gs7uEydO"
Received: from CY4PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11020082.outbound.protection.outlook.com [40.93.198.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CFCC125B9
	for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 21:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729112539; cv=fail; b=JA9ZhAasfqIxds62s5P/pPAUhmYTmbRwJecpDpLHuZSCwjgsvglK6GG7wJBXx06e09Dp7suwpv9jMZJ7xnHxKzA4uKY/orrN0Dln0+kTmciYrrjZE7KSTfBj5n29dAbefZiQ3wLMYqZIGIZaiPRCMJ7i4QeDZv1L94ccjdbcyKE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729112539; c=relaxed/simple;
	bh=+9JnFLX8Qy24fN40NkpVr6KVz17Pb8Equy4kQllNrUo=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=Sc62OZpcg0f4RG1FRd2PQOzzjJnNM67nvkpoXYYEzA7Jv+RGWwT5m+U3zB7blEme7AHSfUVApY4Gsg3gKf7eTUE+C+Lr1jMu8RoyeEPsrVF0HqDkEvaVaJ/R2OX8NV6ft0IlqUXyzV8a/AoVYn5wtEKgFpcU6UE9RUV3TKgaVSk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=Gs7uEydO; arc=fail smtp.client-ip=40.93.198.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=swHvSN4HeMq8IZk/acGmq2AY9fG2ZrtvyTC//8Io73nAQu8oZzJli4zsGikPux6jZOsSIDsxijVcSJy/Z/PDZw0aeKjk6HENNBja89kFf6ypXBRkN+vgKbZ4DOihTGC6khNq4N3CUTCNE+SMCmb6ekP7E0sNGU1Bd2mESWCtU/bAMJMztMCMNAWesobhOFL6O0V0A7AvR5GsBNfvWMyfNCCCyFtwAT0EV49VORQq5iFOvYdznR4LHrMg7GHkXEdyVpSuqg8nnNIUTgCC2ZmX7QkDxKgSnMHriLGkukvpleGqFIbrqCdvpkv2xFv+8h103d6/4lkl79dKm9+ky9vAyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pN9txQLKthGoeSTXu2dItqRQgavVQjKgc2fh5tvggGM=;
 b=GVAeINN6G7V70ZXZQriPgxr38YnjsBKWhyFfjpUtEsvnYqJ7FuWGOdVNR93rHTcbnwVHjE6w53NEwn4cQaWo97zNEY3scj6wpdm49EyzkkrvbfpAJJtyiN2wTsorpEYdiMoFJKWFXHfv+YKXlM2vY2TJc5nlk6vXzLZKjyzd83u8boWecuDq4YMORmFjKkJ/PGT7q1vdUwBK+vYguukoUm/yLEenaVVJRPLFIV2+2MejjGEGzlE8N4jwBxDUDHlDMIpNa4bQ85TGF+I35geUJ22Ba9FH1ETEq+85GuR5atuTdjo742SdYYwU8hexyeUnAbJl+QAudKknZr+NA9LQOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pN9txQLKthGoeSTXu2dItqRQgavVQjKgc2fh5tvggGM=;
 b=Gs7uEydO6YXN1ya5zSv6saCkgNZv+XdKmpo1jal7GGmOCB7x8Ag3jt992uOI3HJGn2bqoQTPNPEXjac3QU/dG4QC/hvV3Ok6wpGVgKibbEEf4WufyQxwbLkDFgWKq8N7QBoKcJs0Zixea0WLLvHBUgegTzgGYmkXG8bVq28VD5U=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from MW4PR01MB6228.prod.exchangelabs.com (2603:10b6:303:76::7) by
 BL3PR01MB6866.prod.exchangelabs.com (2603:10b6:208:351::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7982.34; Wed, 16 Oct 2024 21:02:14 +0000
Received: from MW4PR01MB6228.prod.exchangelabs.com
 ([fe80::13ba:df5b:8558:8bba]) by MW4PR01MB6228.prod.exchangelabs.com
 ([fe80::13ba:df5b:8558:8bba%7]) with mapi id 15.20.7982.033; Wed, 16 Oct 2024
 21:02:14 +0000
From: Ilkka Koskinen <ilkka@os.amperecomputing.com>
To: Shuai Xue <xueshuai@linux.alibaba.com>,
	Jing Zhang <renyu.zj@linux.alibaba.com>,
	Will Deacon <will@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>
Cc: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Ilkka Koskinen <ilkka@os.amperecomputing.com>
Subject: [PATCH] perf/dwc_pcie: Convert the events with mixed case to lowercase
Date: Wed, 16 Oct 2024 14:01:36 -0700
Message-Id: <20241016210136.65452-1-ilkka@os.amperecomputing.com>
X-Mailer: git-send-email 2.40.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CY8P220CA0009.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:930:46::16) To MW4PR01MB6228.prod.exchangelabs.com
 (2603:10b6:303:76::7)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR01MB6228:EE_|BL3PR01MB6866:EE_
X-MS-Office365-Filtering-Correlation-Id: 74530bce-817d-4499-8f09-08dcee25cf37
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|52116014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?0PnpvWe+b0X7YCiBx/CsN3pJ0kRYrtUUlo/D3/pEumVqJnQCz4b2plqHUmZC?=
 =?us-ascii?Q?4pl3Xcm628jhNCPPzraI/3M4Z5dbLuOIUXklN7XUPl9/oKparEHUzsVEwM5o?=
 =?us-ascii?Q?FGOIZy9q1xO2hKfMq7+SfuhaW5TjducJaPatb6If+LIXcGjProXV0gIvdcW9?=
 =?us-ascii?Q?8lkUaqwDyceYIAiwpbTN5CaZXew6cFm2RzD6dg0wulREYLPn4sP8o3kODV1H?=
 =?us-ascii?Q?b82JCsGXhtiq1qgyDGbZ7y7uFj01XIypR0CW0Pw8LH8NSVh1Q9ubr6faxMV3?=
 =?us-ascii?Q?y/I18VpVFq/H77ljwZNrV8/1N0slFrIgp9fVMU6iMb0N8Qj0hFMeROrB0p+5?=
 =?us-ascii?Q?EANZtDkAo8NA349Z5DNgZmuTdZtIY/mJmS/we4KcCHsNudMJhNRcK9JdTvT1?=
 =?us-ascii?Q?8RE7qtv6sFPzGhtjc9I62mWFkKyvCFAvJirM36BNpXYpw62PqeZbZPbgruy2?=
 =?us-ascii?Q?0N1wvvj+8Ab8JHmJL15maggC1rJ1N0n3Mnst7PQ18xY+q6NRZCYAVjubUOaC?=
 =?us-ascii?Q?SLgD9AsD7H1Gx/OQ/1+DPWuAn67abn9pYQYGmSBxkmW4PZFli+Ud40FEpSma?=
 =?us-ascii?Q?8BqPmZdcP1bQeEMTjkGE6oWq4U1hEia78DmPE0RwnDXtJUBE4OsvC3bzmxfL?=
 =?us-ascii?Q?j/93XkwuT7OxOK3YLMO902R8BJvGSfBGigiMfC+Pk+dmweAxgAWYqyjUalP6?=
 =?us-ascii?Q?5v2zeuZJIa+VVERg098pPBs1y2d6D34crzh/5zpRX4wlSepgQk+np/YkP5kp?=
 =?us-ascii?Q?vDUtdBwRZS0tYWLy6xPFWZaMNIaL9X99giI760bW1O8Xpl3tmBSlBEv6VFzV?=
 =?us-ascii?Q?5Ksbf0yOPlIwlTDqaPhX7j/G0EPAhqtD8ruGLPgIFyJdzFeSjeFQxe2rd5Sc?=
 =?us-ascii?Q?cbvXaVR8urwJck13rpZIeB9nPkg+s/Wz+f7tvPRz3QoqjEjnCUDH2NGEQSha?=
 =?us-ascii?Q?SwzbS7iJiNf9BRyLpEDSX2N8qd3A8knJIDu2NkU7tVtzkWphdlci2a+duQAf?=
 =?us-ascii?Q?8isDps3DvwuVWFBBE2wnQltiSOy7JzAZXAi4HDFhYjfL0pgXWUiP1JE47jrN?=
 =?us-ascii?Q?FMPqWyZcYTM/DkgTnVQd8rR1+wHjpzESsKU0X1JUgTF5yUklfkQztcb653wp?=
 =?us-ascii?Q?VerSz2o3JZu3ca7cSz/jXEpFKjIip6RT6es2KhOQemBy4G0BWxEtt9Fkgd5m?=
 =?us-ascii?Q?nzLEysFE1B8FJJ9EGe4KO291C5S4UvsBnFX9XenbhMrbQ+bdNzlwQLux3gjd?=
 =?us-ascii?Q?UUV8z3gq4tbGZblvvPq8dC/7tF7zWXh+seQ9cSkdT84wcGAnbMnMztju7Ihh?=
 =?us-ascii?Q?pu3qzGY19hk0AcMVKUzjNfCfOXBEV08vXJiqcMGISUpK8OmLztyCJ6LQfOBE?=
 =?us-ascii?Q?olM6gBc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR01MB6228.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(52116014)(366016)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?mjCvlymB2H3xdlksuzef6m5IetzErm8rPsE3HOIJaFtUF6gZWKT+qMHk/9HP?=
 =?us-ascii?Q?SJMULBdd2ldIkyVGGkRB+vllpQfEUqHL5R2cFAA+aYwGFdb/JEF/TnIp1CIa?=
 =?us-ascii?Q?/vmTtajSdqvrn7He2Cq4U/2QxLt4YOT0fyXmnXXI0AP80LUPDKRi0Umubcrw?=
 =?us-ascii?Q?87m+YX4zZK3xhUN4htHy80hsc2QrCingGKfQ1x7lJfMyPRJdqSrnhWvmNl2r?=
 =?us-ascii?Q?bCevbI0CN1EteOvt4SbK75FVxkfohau65KMwQtZIlgYV98BlgN/nhQlVkdqW?=
 =?us-ascii?Q?boueAlm00IdJ5R99EFdBowKs/pOkb0CKBnMhwLlF7ja8/6r2KBknvNOr1emi?=
 =?us-ascii?Q?AMEik5B3NBpUwr5MbbY+e6oc6f+bGiKVvL4DhI7XKwzaSYgwElEVO+5tFuh8?=
 =?us-ascii?Q?INVwjgZf+6BT1GrqeES0b3rPV+jKBhT82Qy1rozt7wc7UDXK6jSMb/Uhyd3D?=
 =?us-ascii?Q?i/2rHChtga0n5oVHgfXOCN4P65ZvzaIOoSvANfdFod8dDYv8jeX5MSTJYb2Z?=
 =?us-ascii?Q?eZ8s5f95hvGat3YpxuSYfmgxyp9trKTXvm38RhkUbK9E499CPybDw6OBdPkx?=
 =?us-ascii?Q?J/HD49FLsd82KuehLczHoFZ2klJrRHht8x8av3FYWMzfDu79IY745wTXtoPX?=
 =?us-ascii?Q?B6cGa16x/Xfxp+js8nNLU2kVwiymSP0uiFaykJqYwQrJFoROD1iURiBfwYXq?=
 =?us-ascii?Q?nrN2GUIbBNKBemMqh77GDHPv/jVUuxy+EZmlXxuf2zxUW/uO5+AV2WSY3GFp?=
 =?us-ascii?Q?NCWpQ/Ma++pMdcnqKMShsSzGOVmxjgu2+UBFHXmYkes09dgdugKXG0FPPRmS?=
 =?us-ascii?Q?arLu9v8aWGMwUHVxDQ9MMJfliTpyNA/hMdarS5ZFoGDFD7oozHPopbTU5uH5?=
 =?us-ascii?Q?OQwcxyhCYJg74PZEvw2U4KnkvkWH6CIxnTfHgbmmv67N7eEJY1GYwwJWXFOJ?=
 =?us-ascii?Q?DaRFfkr1n3pZnrm1C4kyyTyOVyoy4zvbTLWd9+lzJUIO+PY/xW+FljIT07/n?=
 =?us-ascii?Q?3/J60EyZFQBYnuvkFvORwEfe0AQ09u/XnxMoOcZ8hLojW7HUuHspZA1SFe/0?=
 =?us-ascii?Q?9RKk5fJ6HbOR+DXT6mcdf3Ef+SNBoYorEiaRpuvgjUjaUAV8Ml9hGJLKQBvZ?=
 =?us-ascii?Q?alcKUZm/ybLu9XSY0Ctu3Uc0yFRziOsCAa6wmjFlRSYPIkkftdJu/Ep0RB6A?=
 =?us-ascii?Q?2/r5FWZYSsQuacBvrTzDdL6toi9KY86ybY3vAchpfhlQyJqsF1olS1CuCtx3?=
 =?us-ascii?Q?Re+aJQ+JcVmitUg1qZbKjRcBYGjQxTnEi+dpCIqUWdKtzu806DKnKCk09hPr?=
 =?us-ascii?Q?PGVdrQhFT+2UPhWFyVH6XmLtYAQbuYNigKuSKjBJH511UtmWgj9MHy95qvCO?=
 =?us-ascii?Q?OgK82bWgE8MbbylnHobuZxAncGetELD33rxqTvA0uusQWxTz7YAlcResFRZg?=
 =?us-ascii?Q?HlfHs0/uTlDBYk4DOvSo+WjNZxj+Jyt1xkEuzxd+7KgaZyuR9xTwcBnFB40t?=
 =?us-ascii?Q?/zLM4txtA1/YigEZ40JV0OClSAmyZkF4Luw6PYEd9S2hxbO2xWkVmeKwrTiM?=
 =?us-ascii?Q?rK7c6TAm/P5u1tWoCjTcMNxGQYOWtEblwUTzkJj8/a11b458h4b5N7ZOCbnf?=
 =?us-ascii?Q?3W28CDa0l6HQX6LKPq0WD24=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 74530bce-817d-4499-8f09-08dcee25cf37
X-MS-Exchange-CrossTenant-AuthSource: MW4PR01MB6228.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2024 21:02:13.8833
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oCkvwhOFABahLiM92Q87001bvIk9/9csqaOYGZPgaaRX3RDPKuHrHKyoLMokpRffjXOTP18XDdiwvdstMLcjNNhgeUMaO0aI8TqvtvA1tOquivzJSdFWQ1o3Ec28vzTK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR01MB6866

Group #1 events had both upper and lower case characters in their names.
Trying to count such events with perf tool results in an error:

$ perf stat -e dwc_rootport_10008/Tx_PCIe_TLP_Data_Payload/ sleep 1
event syntax error: 'dwc_rootport_10008/Tx_PCIe_TLP_Data_Payload/'
                     \___ Bad event or PMU

Unable to find PMU or event on a PMU of 'dwc_rootport_10008'

event syntax error: '..port_10008/Tx_PCIe_TLP_Data_Payload/'
                                  \___ unknown term 'Tx_PCIe_TLP_Data_Payload' for pmu 'dwc_rootport_10008'

valid terms: eventid,type,lane,config,config1,config2,config3,name,period,percore,metric-id

Run 'perf list' for a list of valid events

 Usage: perf stat [<options>] [<command>]

    -e, --event <event>   event selector. use 'perf list' to list available events

Perf tool assumes the event names are either in lower or upper case. This
is also mentioned in
Documentation/ABI/testing/sysfs-bus-event_source-devices-events

  "As performance monitoring event names are case
   insensitive in the perf tool, the perf tool only looks
   for lower or upper case event names in sysfs to avoid
   scanning the directory. It is therefore required the
   name of the event here is either lower or upper case."

Change the Group #1 events names to lower case.

Signed-off-by: Ilkka Koskinen <ilkka@os.amperecomputing.com>
---
 drivers/perf/dwc_pcie_pmu.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/perf/dwc_pcie_pmu.c b/drivers/perf/dwc_pcie_pmu.c
index 59526a48499f..126d2c3516ad 100644
--- a/drivers/perf/dwc_pcie_pmu.c
+++ b/drivers/perf/dwc_pcie_pmu.c
@@ -202,10 +202,10 @@ static struct attribute *dwc_pcie_pmu_time_event_attrs[] = {
 	DWC_PCIE_PMU_TIME_BASE_EVENT_ATTR(L1_AUX, 0x09),
 
 	/* Group #1 */
-	DWC_PCIE_PMU_TIME_BASE_EVENT_ATTR(Tx_PCIe_TLP_Data_Payload, 0x20),
-	DWC_PCIE_PMU_TIME_BASE_EVENT_ATTR(Rx_PCIe_TLP_Data_Payload, 0x21),
-	DWC_PCIE_PMU_TIME_BASE_EVENT_ATTR(Tx_CCIX_TLP_Data_Payload, 0x22),
-	DWC_PCIE_PMU_TIME_BASE_EVENT_ATTR(Rx_CCIX_TLP_Data_Payload, 0x23),
+	DWC_PCIE_PMU_TIME_BASE_EVENT_ATTR(tx_pcie_tlp_data_payload, 0x20),
+	DWC_PCIE_PMU_TIME_BASE_EVENT_ATTR(rx_pcie_tlp_data_payload, 0x21),
+	DWC_PCIE_PMU_TIME_BASE_EVENT_ATTR(tx_ccix_tlp_data_payload, 0x22),
+	DWC_PCIE_PMU_TIME_BASE_EVENT_ATTR(rx_ccix_tlp_data_payload, 0x23),
 
 	/*
 	 * Leave it to the user to specify the lane ID to avoid generating
-- 
2.40.1


