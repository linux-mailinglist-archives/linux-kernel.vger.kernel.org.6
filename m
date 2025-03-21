Return-Path: <linux-kernel+bounces-571761-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD856A6C1E0
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 18:51:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E56F3B9FB6
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 17:51:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D4DA22DF86;
	Fri, 21 Mar 2025 17:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="fZJNxrnb";
	dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b="hfWxaxLp"
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EF9622E3FD;
	Fri, 21 Mar 2025 17:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.149.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742579465; cv=fail; b=RjZZpy+Yh31xnwSLve78asOTL2xFA2PWL877zoKz+7e0XKVsOGrMR9UIEW5GJ0T8UzS8fLB96WXaMxWgTuDv2fFIAjLhN/WncEftDZM2VkVcidAnBrjgtc0rTo02PBy8A9WeOULRcfr3CIXziuciXheSjwGO8Bw3FD4rdZ/B0cA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742579465; c=relaxed/simple;
	bh=9hnX0S1g5yU+UQSYaYyClZ3iE+uTXodKNM+PKOGNmpA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=bbrk4CSP1uLjjAwzdZTv79Ec6hxLRogIaM1aM0uSzZjbLfNEv5pwJPPay8xa4XL/ZXEcy6XfUT3EbnxKHLBRXmNBdbN83JhlzwChFoQprcjNNsMnVY0AC6+L3d4HN3lR6+XZNS7+C8hEyOWlqXlVXd5PQAKZjGY5DDzxYIL8jyg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=fZJNxrnb; dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b=hfWxaxLp; arc=fail smtp.client-ip=67.231.149.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cirrus.com
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
	by mx0a-001ae601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52L4puSc019814;
	Fri, 21 Mar 2025 12:50:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=PODMain02222019; bh=0XnsUegQxa0xmQpu
	oLfV+FFdTaWdKPp2/v43sbp3WG4=; b=fZJNxrnbVaRoAP172Z12nHbYRkD87WAw
	5NRPdG0z7beW5VOOoahogvj4YiblhkyYQuRzTGrqlHIvLndPzQAkFouDdIZ8T4bg
	sh+j6oXOhu0gCr7mlLgK3K+mqlmx7M9rFmBWdFgm2nA1SP91G8ajqaPhaoQ9ma27
	5MgLunNsOZgd3ZzBHgZGJ5bhY5Kdvs+XR9sIcOLQuOX9nKSwlC96fW8mzl3DTn93
	MVss81v2gd9RVjC81A1Prk/Ze9hCn+nywanK6LUpCSgMclu4EK/3dkYJblQb/QRY
	pCmMGGuGUmkUcZwC3JQwxYZnZNmFyzWDdhQeTs7xVIHHC0s2bEIs6A==
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2040.outbound.protection.outlook.com [104.47.55.40])
	by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 45g9p6vbtq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 21 Mar 2025 12:50:52 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g5McWsJsNReh/WO4ryg2s2JAvpRIY2YIXhKldpGo8bWZltz/88WAhPpzEdq+ecc2VcUCINJMb5Uw8o8xoYypMHvyTJbctCqrkNQo1Uz0JTF/k6hHpnBvpIGTGcSXR9WdpGhqe541OvvUic8YkyI0yxQ3wvwjx57aNNBnSD9zVyouNLbkASwif53YfFKISrwrr909H9FUmNGP+F5vQWQnloOmT4ISyUBs2TDJZpcLR0cuoZZfKLeX7kcRqSSo3NEitX+To0eka8eac19QtI6sHL4nF0t6Y0RvUF1zMgg+7zYg146hk9nCKirTVcCE0W/B4tYGWedUmIRwIKc93EPYvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0XnsUegQxa0xmQpuoLfV+FFdTaWdKPp2/v43sbp3WG4=;
 b=x8H6ZJwZiIZmSUOCLCeWDEKfEBwyQcuLPyR65rOLwPBXr2kTUhQTInM8eC8OYvmBPshtY4gVJblo0fyvjoLp2BkbwuPG1/Y5RJgLKDeZvoxmgrm2oTrMsKqdlQsTTENuG9BbtXv9LyiosqRk531fn4xqqo7/Ik3gDXCunpVziKV4EWZL9YavDUFEKZ7KKYz2u3Wfyf1JE+R2u2Ys1nxw+v8EhnNOAEAH/e3+7rUST+TZPI1O0dB75Zep3gl0/AiBOF6awKllG+hTqOvwcuBXKHkqkGOpGnylUj5M9KdPIsRFoT50SqQEb7rN1M8eN3tTKJVz74oFnit5wSCWyYP1aA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=temperror (sender ip
 is 84.19.233.75) smtp.rcpttodomain=cirrus.com smtp.mailfrom=cirrus.com;
 dmarc=temperror action=none header.from=opensource.cirrus.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cirrus4.onmicrosoft.com; s=selector2-cirrus4-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0XnsUegQxa0xmQpuoLfV+FFdTaWdKPp2/v43sbp3WG4=;
 b=hfWxaxLpIFC2UMWpcCxFc2vyhYYrYUuAoHhBaeWUdeD1NRDox8p34GA6GFvlalah+AG+bmjgjP6N3IsfGr8V5h6XRx3qTL0jHm4tKMnal7ci1zNfVKv910lZUEsvqUU2sERcqZVF7LkfFu9HXVh4RXlZ8S/9NPLnsrkyXhrvFfw=
Received: from SA1P222CA0122.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:3c5::17)
 by DS0PR19MB8489.namprd19.prod.outlook.com (2603:10b6:8:1a1::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.36; Fri, 21 Mar
 2025 17:50:46 +0000
Received: from SA2PEPF00001505.namprd04.prod.outlook.com
 (2603:10b6:806:3c5:cafe::5f) by SA1P222CA0122.outlook.office365.com
 (2603:10b6:806:3c5::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.37 via Frontend Transport; Fri,
 21 Mar 2025 17:50:46 +0000
X-MS-Exchange-Authentication-Results: spf=temperror (sender IP is
 84.19.233.75) smtp.mailfrom=cirrus.com; dkim=none (message not signed)
 header.d=none;dmarc=temperror action=none header.from=opensource.cirrus.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of cirrus.com: DNS Timeout)
Received: from edirelay1.ad.cirrus.com (84.19.233.75) by
 SA2PEPF00001505.mail.protection.outlook.com (10.167.242.37) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.20
 via Frontend Transport; Fri, 21 Mar 2025 17:50:44 +0000
Received: from ediswmail9.ad.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by edirelay1.ad.cirrus.com (Postfix) with ESMTPS id 69AD8406540;
	Fri, 21 Mar 2025 17:50:43 +0000 (UTC)
Received: from lonswws02.ad.cirrus.com (lonswws02.ad.cirrus.com [198.90.188.42])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTP id 1D50E820244;
	Fri, 21 Mar 2025 17:50:43 +0000 (UTC)
From: Stefan Binding <sbinding@opensource.cirrus.com>
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc: linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@opensource.cirrus.com,
        Stefan Binding <sbinding@opensource.cirrus.com>
Subject: [PATCH v1] ALSA: hda/realtek: Add support for various HP Laptops using CS35L41 HDA
Date: Fri, 21 Mar 2025 17:50:06 +0000
Message-ID: <20250321175040.800963-1-sbinding@opensource.cirrus.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00001505:EE_|DS0PR19MB8489:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: a1596607-cfef-4073-c31d-08dd68a0e7df
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|61400799027|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?YY0Mbz8YHK4xtMAt/+gLZRqt3gnaDKxlX9vkStz2/gIFMZxFbA7Az+be/wyZ?=
 =?us-ascii?Q?kFcGgXBxKpsHrpSfWVL9+OusJPSxljonkMvWVqahI7f085UfCOVdZg0gPz07?=
 =?us-ascii?Q?muVGt0T447CMKJEzb9/IYZs9pJfM33tjmryqiK6nNi3cQxVFJlFMuZDO/q2p?=
 =?us-ascii?Q?LJRJdatofAcQsNIzL8vBT7x1fJbmOXNomj3T01He6nQ0r0K/3imoaYMP3tJb?=
 =?us-ascii?Q?MmuHHJGwrqP4AVvQPHvIvxd52bn/Nnp3ZYVaPhbBUaIBQkOscRuKIp4Rb9CI?=
 =?us-ascii?Q?PLr67hKAOeHRkfHXEmgCY91NNyMkpIbHIg/wD31GOnwXL678uE65o/w5Fo5U?=
 =?us-ascii?Q?MK7AeLAWxyhuipH054vyRNRhc/wIsA89buQbov70kyipAVGIx0EitbWYIpTt?=
 =?us-ascii?Q?bzS9mIUrXmST/F4E5M/zTxUB1EAiWnEd6GY8IKDEzo3XA/aiSf0XEioDCjMT?=
 =?us-ascii?Q?e1nkCApDz8aSBqYgWTwBpjV7wTHyoqZYqk9ZWAfGQsez1vmwErt/sWIr1Zuq?=
 =?us-ascii?Q?DHEXQxPvgxKpcPQCTbPbDKFU2XmkKdTCW8Aa0FZmjO+bVRQw8txTCh8ya0Tr?=
 =?us-ascii?Q?sTVh0xe4RN2Gz47WQgteFFC1wwRKWZEd55aKMvIxlce6DD3qhAkONBnieuO6?=
 =?us-ascii?Q?7ZI1KC40uAXLdrMXTIq1kUfnegeqx9Xi8BO32SBLu8yHXo0qm65R+SiCTJit?=
 =?us-ascii?Q?/T8muSzIrHjaCHjiXOnHK0Sb0Wr04i+TeVdxsegQF9G3CpJJZdW8YbA1gImX?=
 =?us-ascii?Q?FpY8ZG/LoZvMUuYOqUteyROmGP+pZXtcDSia9Imyh2eOECyc/sE4xFF2beIx?=
 =?us-ascii?Q?uvv6y9TPODtJfwwCHQRRSVTDx+f6Ea923bWRs46OaKcodE1trBnHbBMvsImD?=
 =?us-ascii?Q?6jTVdneenJlW2DuLvSARt9jUeJR9d3elzLa9PbkvPpCdMQjaBM5V/4Od/6e6?=
 =?us-ascii?Q?3o+3PSKxKoGoH6GeJC5lGnpOI9L3yBYns2MsbfDMaOK/8sSYdujTNqFc8WKP?=
 =?us-ascii?Q?aXrNMu6+lzhJl0WUVGUwjUW3SCtfsAjmDJnKxNhvqpEwWKpWtLaVszHyghRq?=
 =?us-ascii?Q?w3waX5W3MOur3y4B8YnncvRzWV/HdLeVx4KxYHHeD4pv+bKSOUA0e2SGU2m5?=
 =?us-ascii?Q?U/CWUbrefiak/8b2CHqqsKKHmU3dRjPw4KJ9TwpajW9cOOvLV7PUjM5tXx0C?=
 =?us-ascii?Q?eORaNSMaiaoEOQbhWusIA+baU1+vF9EJYYy2POS9ew6qSdp8h7CPg5/cBY7o?=
 =?us-ascii?Q?7e2Aa5CoxLMFar0MTM+fMh5dWVSPmjudZYIwaujr9RCX4BKmUmm4esvjklKj?=
 =?us-ascii?Q?1RywIyBCNMPuRJlK+1Sk6NQi2re/LTLJGhCLHAhf+6yZSbUY86jHU/n1ub6Y?=
 =?us-ascii?Q?kGdUWsxzP/gwPeNwAVdJRm6D2jSDC6RSkwqCV8JBUdCDGITZDJxQgmgeAhuF?=
 =?us-ascii?Q?f8+2ZXca1fZgtrpQI97uzD8A6wuf0FIOa+aQQs73VPIGQugXnd5CrFzX6M6r?=
 =?us-ascii?Q?jnokEuor5MVnyyI=3D?=
X-Forefront-Antispam-Report:
	CIP:84.19.233.75;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:edirelay1.ad.cirrus.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(82310400026)(376014)(61400799027)(36860700013);DIR:OUT;SFP:1102;
X-OriginatorOrg: opensource.cirrus.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2025 17:50:44.7923
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a1596607-cfef-4073-c31d-08dd68a0e7df
X-MS-Exchange-CrossTenant-Id: bec09025-e5bc-40d1-a355-8e955c307de8
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bec09025-e5bc-40d1-a355-8e955c307de8;Ip=[84.19.233.75];Helo=[edirelay1.ad.cirrus.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00001505.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR19MB8489
X-Authority-Analysis: v=2.4 cv=Vcz3PEp9 c=1 sm=1 tr=0 ts=67dda6fc cx=c_pps a=OemXRkCljtmPz/OzEC+nkg==:117 a=h1hSm8JtM9GN1ddwPAif2w==:17 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=Vs1iUdzkB0EA:10 a=RWc_ulEos4gA:10 a=w1d2syhTAAAA:8
 a=BaEw2aN_RTaRYA0e3hwA:9 a=BGLuxUZjE2igh1l4FkT-:22
X-Proofpoint-GUID: RUrQm4-GKwAoC4jEh6sl3xhvoXJbhNIH
X-Proofpoint-ORIG-GUID: RUrQm4-GKwAoC4jEh6sl3xhvoXJbhNIH
X-Proofpoint-Spam-Reason: safe

Add support for HP Cadet, Clipper OmniBook, Turbine OmniBook, Trekker,
Enstrom Onmibook, Piston Omnibook

Laptops use 2 CS35L41 Amps with HDA, using Internal boost, with I2C

Signed-off-by: Stefan Binding <sbinding@opensource.cirrus.com>
---
 sound/pci/hda/patch_realtek.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 1d8caf791dbc..8c90b87ec995 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -10725,11 +10725,28 @@ static const struct hda_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x103c, 0x8d84, "HP EliteBook X G1i", ALC285_FIXUP_HP_GPIO_LED),
 	SND_PCI_QUIRK(0x103c, 0x8d91, "HP ZBook Firefly 14 G12", ALC285_FIXUP_HP_GPIO_LED),
 	SND_PCI_QUIRK(0x103c, 0x8d92, "HP ZBook Firefly 16 G12", ALC285_FIXUP_HP_GPIO_LED),
+	SND_PCI_QUIRK(0x103c, 0x8d9b, "HP 17 Turbine OmniBook 7 UMA", ALC287_FIXUP_CS35L41_I2C_2),
+	SND_PCI_QUIRK(0x103c, 0x8d9c, "HP 17 Turbine OmniBook 7 DIS", ALC287_FIXUP_CS35L41_I2C_2),
+	SND_PCI_QUIRK(0x103c, 0x8d9d, "HP 17 Turbine OmniBook X UMA", ALC287_FIXUP_CS35L41_I2C_2),
+	SND_PCI_QUIRK(0x103c, 0x8d9e, "HP 17 Turbine OmniBook X DIS", ALC287_FIXUP_CS35L41_I2C_2),
+	SND_PCI_QUIRK(0x103c, 0x8d9f, "HP 14 Cadet (x360)", ALC287_FIXUP_CS35L41_I2C_2),
+	SND_PCI_QUIRK(0x103c, 0x8da0, "HP 16 Clipper OmniBook 7(X360)", ALC287_FIXUP_CS35L41_I2C_2),
+	SND_PCI_QUIRK(0x103c, 0x8da1, "HP 16 Clipper OmniBook X", ALC287_FIXUP_CS35L41_I2C_2),
+	SND_PCI_QUIRK(0x103c, 0x8da7, "HP 14 Enstrom OmniBook X", ALC287_FIXUP_CS35L41_I2C_2),
+	SND_PCI_QUIRK(0x103c, 0x8da8, "HP 16 Piston OmniBook X", ALC287_FIXUP_CS35L41_I2C_2),
 	SND_PCI_QUIRK(0x103c, 0x8de8, "HP Gemtree", ALC245_FIXUP_TAS2781_SPI_2),
 	SND_PCI_QUIRK(0x103c, 0x8de9, "HP Gemtree", ALC245_FIXUP_TAS2781_SPI_2),
+	SND_PCI_QUIRK(0x103c, 0x8e11, "HP Trekker", ALC287_FIXUP_CS35L41_I2C_2),
+	SND_PCI_QUIRK(0x103c, 0x8e12, "HP Trekker", ALC287_FIXUP_CS35L41_I2C_2),
+	SND_PCI_QUIRK(0x103c, 0x8e13, "HP Trekker", ALC287_FIXUP_CS35L41_I2C_2),
 	SND_PCI_QUIRK(0x103c, 0x8e18, "HP ZBook Firefly 14 G12A", ALC285_FIXUP_HP_GPIO_LED),
 	SND_PCI_QUIRK(0x103c, 0x8e19, "HP ZBook Firefly 14 G12A", ALC285_FIXUP_HP_GPIO_LED),
 	SND_PCI_QUIRK(0x103c, 0x8e1a, "HP ZBook Firefly 14 G12A", ALC285_FIXUP_HP_GPIO_LED),
+	SND_PCI_QUIRK(0x103c, 0x8e36, "HP 14 Enstrom OmniBook X", ALC287_FIXUP_CS35L41_I2C_2),
+	SND_PCI_QUIRK(0x103c, 0x8e37, "HP 16 Piston OmniBook X", ALC287_FIXUP_CS35L41_I2C_2),
+	SND_PCI_QUIRK(0x103c, 0x8e60, "HP Trekker ", ALC287_FIXUP_CS35L41_I2C_2),
+	SND_PCI_QUIRK(0x103c, 0x8e61, "HP Trekker ", ALC287_FIXUP_CS35L41_I2C_2),
+	SND_PCI_QUIRK(0x103c, 0x8e62, "HP Trekker ", ALC287_FIXUP_CS35L41_I2C_2),
 	SND_PCI_QUIRK(0x1043, 0x103e, "ASUS X540SA", ALC256_FIXUP_ASUS_MIC),
 	SND_PCI_QUIRK(0x1043, 0x103f, "ASUS TX300", ALC282_FIXUP_ASUS_TX300),
 	SND_PCI_QUIRK(0x1043, 0x1054, "ASUS G614FH/FM/FP", ALC287_FIXUP_CS35L41_I2C_2),
-- 
2.43.0


