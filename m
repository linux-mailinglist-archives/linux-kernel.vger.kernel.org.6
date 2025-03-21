Return-Path: <linux-kernel+bounces-572091-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E863BA6C665
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Mar 2025 00:20:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9599A7A9C62
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 23:18:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1761421D3D4;
	Fri, 21 Mar 2025 23:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="IAde/YHg";
	dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b="YkkBQkB6"
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 040961D54D8;
	Fri, 21 Mar 2025 23:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.149.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742599061; cv=fail; b=uEChJQgoCeV8ejFUwejxJN9iA1aXYsHiuIPJ23C7rjNxg4pFSlscaaxi8slHyqqsFgQYvhDR1UT/siBNcmhsf+yF8LYgyRR2QnRqNxy1H+l5Tu0xglUbgV9rX68syeYwhCSFIC18NPByJz4xTXvqFXF27k9f9CwmUtj48lRqJtQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742599061; c=relaxed/simple;
	bh=blgl9gW8MXeyETXe2ED+sDHIT5mTVJ6IkMJqNp12N4I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=KGaWrKb+rFd/xswV5EyaMbeCjJFgVtSeliyVussPoTrQ0sgzw5TBT9/fISfnG6iKHcE7nbTFkNvHc2dEXbozbhVqjQZf32vzgQ956DZOHAdsL48Ti+dDVs3FwWNDXOR2CQH02z13PmPuEgNUvUjN7ER9yOiKffqzJ6k8GgOYs5g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=IAde/YHg; dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b=YkkBQkB6; arc=fail smtp.client-ip=67.231.149.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cirrus.com
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
	by mx0a-001ae601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52L4pugX019814;
	Fri, 21 Mar 2025 18:17:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=PODMain02222019; bh=Dac2Byf4wZOup+6w
	omVZ3kvLZST5quJGC0mpGH4hDH0=; b=IAde/YHg9SV5aWoMGp+BI1/DjjIWtb5f
	yVN6p4NE9yN6HwFiogAq+FvVpEjNUQckzZ5Gt+zWgMKFhtV1xnuzY/niHcJrei3s
	EoLHTbf5UGEhAqTUrraeFaVqQYRht4pWJsxqJ9gI6UUhKT0oa9DWo4GI4JJPoVOE
	9bvCKW77iKaNmakKV01miTqfGUhBvEqkPWNLNviz5usRgK9cBomIIqkN2oMfQ0xy
	ijc4PU1sofs3qXgBxzfqX42BQHC+L7sCqs1ufkunL2vLNjRqVLlzn23IA3iqIUfE
	OOFaa2/u7cTST4rQCdhm8S7j7lFi7sTDXIeE2SmNNyQYmqJrabGRIw==
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2049.outbound.protection.outlook.com [104.47.57.49])
	by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 45g9p6vxnx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 21 Mar 2025 18:17:28 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IEgbUYVWWuIHGRvuCGqguVtEIVr5mWIkVkDE87c2LIBXFcOHIxeY0elp9yYMAx0hRxxifM8u+0xyTCDkIo0odu2X/GZliMJ9WV1fX0UojogiF40gt53HQUfbH3DreBtV5bEiQDVQSSoLF0AbWpEa8oQqabF8Ja7tGb2FC0TS7G1/cMbfRQaz/2uUnUXSrFYLgGX1KQoyGqE0COadOZV9XPgBICqPA+nkFz2E4a0Eikg/Eyx1aTm6voNuPswUKe29QkiMgpim4+PNt7eIkddSOGCd7EzRah48+HwQ5sXwnjMrWDNWXDfBBkDLZutw8PICNGtYMtZCmGLSkF21wr0wSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Dac2Byf4wZOup+6womVZ3kvLZST5quJGC0mpGH4hDH0=;
 b=WRR5treq4j1hcoYIyP2vPQKK5uP/y1xfnmi54DMnF6hO9QHv/CtckuaP4Y7HcF7eDz/ZDmjl74+XJwTAsnj4jQTH1xm07GVnjXLaaTqCdYTQ+/QfY4CPTO6gDttbUlsfH2oKtcHeUWaoMruNnFoEkL2AsOHv7o1b4ZUv5YImB3UZO9LhYadmAbsSOV1xSmRHilGTO3Ei6R0YBYba13oNhD71oE/O428rZ/usrnHIfS1T4nP6nkKqqgcHzIjsexWHchokXgOT2PrQcozNzMsF53cUgJikIdk8cKsF+EAIzkHU6SayJIo/7u7w/Jhob9yUfrHtdWMDq76iPUMJeOyq6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 84.19.233.75) smtp.rcpttodomain=cirrus.com smtp.mailfrom=cirrus.com;
 dmarc=fail (p=reject sp=reject pct=100) action=oreject
 header.from=opensource.cirrus.com; dkim=none (message not signed); arc=none
 (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cirrus4.onmicrosoft.com; s=selector2-cirrus4-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dac2Byf4wZOup+6womVZ3kvLZST5quJGC0mpGH4hDH0=;
 b=YkkBQkB6HjfcIKfy8HGxhtJKbVJxAvNgdi+mU37OrttQ3ZC/CQERNkR+L92p1AD6BpFJSybAI5ob7x3ud7iUoJZcxyhNPvEqe0Du7vzosKyAo95QqU3Go+cX7q62Mefk1gisSO7hylNChdIEa0lfNgFd/D0WtnkCsrZi+1TYkwY=
Received: from SJ0PR13CA0007.namprd13.prod.outlook.com (2603:10b6:a03:2c0::12)
 by SA1PR19MB5667.namprd19.prod.outlook.com (2603:10b6:806:23c::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.36; Fri, 21 Mar
 2025 23:17:23 +0000
Received: from SJ1PEPF00002323.namprd03.prod.outlook.com
 (2603:10b6:a03:2c0:cafe::3) by SJ0PR13CA0007.outlook.office365.com
 (2603:10b6:a03:2c0::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.36 via Frontend Transport; Fri,
 21 Mar 2025 23:17:23 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 84.19.233.75)
 smtp.mailfrom=cirrus.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=opensource.cirrus.com;
Received-SPF: Fail (protection.outlook.com: domain of cirrus.com does not
 designate 84.19.233.75 as permitted sender) receiver=protection.outlook.com;
 client-ip=84.19.233.75; helo=edirelay1.ad.cirrus.com;
Received: from edirelay1.ad.cirrus.com (84.19.233.75) by
 SJ1PEPF00002323.mail.protection.outlook.com (10.167.242.85) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.20
 via Frontend Transport; Fri, 21 Mar 2025 23:17:22 +0000
Received: from ediswmail9.ad.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by edirelay1.ad.cirrus.com (Postfix) with ESMTPS id 72D7F406540;
	Fri, 21 Mar 2025 23:17:20 +0000 (UTC)
Received: from lonswws02.ad.cirrus.com (lonswws02.ad.cirrus.com [198.90.188.42])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTP id 2E436820248;
	Fri, 21 Mar 2025 23:17:20 +0000 (UTC)
From: Stefan Binding <sbinding@opensource.cirrus.com>
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc: linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@opensource.cirrus.com,
        Stefan Binding <sbinding@opensource.cirrus.com>
Subject: [PATCH v2] ALSA: hda/realtek: Add support for various HP Laptops using CS35L41 HDA
Date: Fri, 21 Mar 2025 23:16:36 +0000
Message-ID: <20250321231717.1232792-1-sbinding@opensource.cirrus.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002323:EE_|SA1PR19MB5667:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 7dfd6be5-a2fc-4f5b-7d77-08dd68ce88ea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|61400799027|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?tMO43mKGD7hC6jsZt2Nb7Dhes7D2YaFM6lnMKK5u1V77ZPsISBzw7+/ETU/0?=
 =?us-ascii?Q?WqbUbPOIHwJikZlILBEyHYQJinHGtBLM+W5LZcFyJ95H0hsqdVDQuJ1kuR6f?=
 =?us-ascii?Q?wtt3DLhjHhUzYuYOV2loUuDdgYpHDI2WevpKbidN2rZYT14wbcKe+KAw8+t0?=
 =?us-ascii?Q?YQhAx3iAnSw4sJY8dG1cZ70QjeWB4NlgVQIUIh4HHTiIXIpssAB8kBJTxIJt?=
 =?us-ascii?Q?6VFf384skd9GnliRvtDGt7PFuNcs3a/J6vMlHWM8wH9xZTCqtVO9ZRQMdVKN?=
 =?us-ascii?Q?JqIh0USI5P+01lYFUypq+CmERpPAE+i7+4DDKeShPTpj7WnlbrvL54QEqbu3?=
 =?us-ascii?Q?kIV21MTWFZQ7s3vzZS4HncU3WNgbi3giF/S15xVp4BroQrfGO6p9btq4aCy4?=
 =?us-ascii?Q?bOsNnQcx5jI0McRHWRyj0t97eoL0LJGURunWmGS8FROm8ucZPoaL9w4StTE+?=
 =?us-ascii?Q?QFLKfla+rezGNBDZGIK/Xmjqb3nMHN/6uQktAZi7Z7jCLSC87htsSA4PYA07?=
 =?us-ascii?Q?nj6rUzosfpXAXQNSVqT8Jj8GSXxQxdyNdQjVEpoMi/8q1/g/LJNVzPeZf2UA?=
 =?us-ascii?Q?yb9TspbseSqEF4TPSUNzaIFM5Cf7cPGjGXODguUv29AsYwoM+JhYoUkvzKq3?=
 =?us-ascii?Q?T+qSNUKY1BTZ+7GuNyxtznXcTbZCDmP5PwwSSwuK5ylconjkm1rF7nMjtHv0?=
 =?us-ascii?Q?YTqV2qz+bPbEwqHKGJvhpcVtpPwyNpS5+rCj1QFdkYTwtkW5TeyJnBrox2+u?=
 =?us-ascii?Q?TXA/ZFiC2XPX+RPVuQ+G+LAGdBD0Vk82FCZNRsJ+P/6ijhbFFlazGiWOMUIV?=
 =?us-ascii?Q?otE3uGl06tLCLvnQCsRhh6sZBB9oVVdrGbQKwneHWGZS1w3Q9jy6kgq+jnqQ?=
 =?us-ascii?Q?qV3FiUAjBzaT1pcnNCRFs1/YQUp0KIBghdIrFvsHge1Tlbza8IF3Bc9pMfd+?=
 =?us-ascii?Q?ve1pZY6rBXg/00l85VxJWhIMH0TOraocGyOtgMB+FN/Xq9yq+9Kko1zRZ3BD?=
 =?us-ascii?Q?TasQrRoNkMkxkVDSVNgPWmGjKx1gCM6Fos5qwLlAoomtLw+bCkg6DUp87GS2?=
 =?us-ascii?Q?4zQjh6SphlUD1i/I7IcO+SV6Dxemh6oYH6na6oeAuJsD1CotTU+irhEPeEAB?=
 =?us-ascii?Q?qz27Kkq8FA+zvEBBJi+d+J+n6S9tGtPGFdK+4n4AC2ArcceNu5w4I5RLqTIK?=
 =?us-ascii?Q?j8iah9Bt6SaDwv6ezswb8q1wDHKXfPDZEE07QxeG8RQ+0xNoPXMMESCoTsGV?=
 =?us-ascii?Q?4heh1xze0p0/cfuHnQxtm5B2SGlVhb0K5Y4Eijmz6Jr9fFp1BEwcZfqNEdUp?=
 =?us-ascii?Q?7VDuJyMgLEDYXPV477E8Z90gbhxyes64JdX4iRJq1UQhxO2fJJcywCfR6KKM?=
 =?us-ascii?Q?n+alLJO2KUHvFCAVSYifNlSfo4DYXoXXe7Oy3S6eQpktRrxN05XAznMA9tk3?=
 =?us-ascii?Q?uf5MMQyMu0pQqDBBHtSqoi7vbdb19AadlggdWfRAVTpk0WHTNQ8TUjQt6kOD?=
 =?us-ascii?Q?5Eg+dBvDgeMhQqI=3D?=
X-Forefront-Antispam-Report:
	CIP:84.19.233.75;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:edirelay1.ad.cirrus.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(61400799027)(36860700013);DIR:OUT;SFP:1102;
X-OriginatorOrg: opensource.cirrus.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2025 23:17:22.2661
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7dfd6be5-a2fc-4f5b-7d77-08dd68ce88ea
X-MS-Exchange-CrossTenant-Id: bec09025-e5bc-40d1-a355-8e955c307de8
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bec09025-e5bc-40d1-a355-8e955c307de8;Ip=[84.19.233.75];Helo=[edirelay1.ad.cirrus.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002323.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR19MB5667
X-Authority-Analysis: v=2.4 cv=Vcz3PEp9 c=1 sm=1 tr=0 ts=67ddf388 cx=c_pps a=HKd0dofMVZNDIjQNdCpHRg==:117 a=h1hSm8JtM9GN1ddwPAif2w==:17 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=Vs1iUdzkB0EA:10 a=s63m1ICgrNkA:10
 a=RWc_ulEos4gA:10 a=w1d2syhTAAAA:8 a=HWLqE-iJ1nUeUiCOBTwA:9 a=BGLuxUZjE2igh1l4FkT-:22
X-Proofpoint-GUID: aA263bPJVBm-Jn0x29pKnwIaNsgF8Tk6
X-Proofpoint-ORIG-GUID: aA263bPJVBm-Jn0x29pKnwIaNsgF8Tk6
X-Proofpoint-Spam-Reason: safe

Add support for HP Cadet, Clipper OmniBook, Turbine OmniBook, Trekker,
Enstrom Onmibook, Piston Omnibook

Laptops use 2 CS35L41 Amps with HDA, using Internal boost, with I2C

Signed-off-by: Stefan Binding <sbinding@opensource.cirrus.com>
---
 sound/pci/hda/patch_realtek.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 50e1c947a77c..1acf0783c0f8 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -10700,6 +10700,15 @@ static const struct hda_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x103c, 0x8d90, "HP EliteBook 16 G12", ALC285_FIXUP_HP_GPIO_LED),
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
 	SND_PCI_QUIRK(0x103c, 0x8dec, "HP EliteBook 640 G12", ALC236_FIXUP_HP_GPIO_LED),
@@ -10707,6 +10716,9 @@ static const struct hda_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x103c, 0x8df0, "HP EliteBook 630 G12", ALC236_FIXUP_HP_GPIO_LED),
 	SND_PCI_QUIRK(0x103c, 0x8dfc, "HP EliteBook 645 G12", ALC236_FIXUP_HP_GPIO_LED),
 	SND_PCI_QUIRK(0x103c, 0x8dfe, "HP EliteBook 665 G12", ALC236_FIXUP_HP_GPIO_LED),
+	SND_PCI_QUIRK(0x103c, 0x8e11, "HP Trekker", ALC287_FIXUP_CS35L41_I2C_2),
+	SND_PCI_QUIRK(0x103c, 0x8e12, "HP Trekker", ALC287_FIXUP_CS35L41_I2C_2),
+	SND_PCI_QUIRK(0x103c, 0x8e13, "HP Trekker", ALC287_FIXUP_CS35L41_I2C_2),
 	SND_PCI_QUIRK(0x103c, 0x8e14, "HP ZBook Firefly 14 G12", ALC285_FIXUP_HP_GPIO_LED),
 	SND_PCI_QUIRK(0x103c, 0x8e15, "HP ZBook Firefly 14 G12", ALC285_FIXUP_HP_GPIO_LED),
 	SND_PCI_QUIRK(0x103c, 0x8e16, "HP ZBook Firefly 14 G12", ALC285_FIXUP_HP_GPIO_LED),
@@ -10717,6 +10729,11 @@ static const struct hda_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x103c, 0x8e1b, "HP EliteBook G12", ALC285_FIXUP_HP_GPIO_LED),
 	SND_PCI_QUIRK(0x103c, 0x8e1c, "HP EliteBook G12", ALC285_FIXUP_HP_GPIO_LED),
 	SND_PCI_QUIRK(0x103c, 0x8e2c, "HP EliteBook 16 G12", ALC285_FIXUP_HP_GPIO_LED),
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


