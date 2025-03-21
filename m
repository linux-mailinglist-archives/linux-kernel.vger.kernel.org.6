Return-Path: <linux-kernel+bounces-571220-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7FCDA6BA91
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 13:21:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F6F846685A
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 12:21:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E9BC2253FE;
	Fri, 21 Mar 2025 12:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="VJYTYJRp";
	dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b="R5zk9b/K"
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 422891C2DB2;
	Fri, 21 Mar 2025 12:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.149.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742559699; cv=fail; b=n4oGGxoETGjpoFL+TiMvnMXbF4P+d3TGXci5Kq2cYCo9aUKqM9gij8Gdk4Ao2ebT79NcdTrWxuHusB4cUf5Z/BexyhSXGMfNd4mN8/XIsKp/r2YvwjFZ/vIcS6TWCUj1ZZj3ilJHPEbjYjyTzsMNt4LpCrlfV2F0ixMjwYU2HaA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742559699; c=relaxed/simple;
	bh=YFEmc+FhCdgfEN740J6QD1FKy28iUmqh8erxpH+IooI=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=d9t7ECRVfkvsrxEsqlqBYqziTQKKwxKmqiUnibWo+r8tgd8Wc0m8Himh+AhLPCpsiY4xhhuFEXQWSgfKBArZjozbDjfhe/CWeBrPGKfMniBxjLHxuZgbQGcZZVDLY1tSxVO6JYfk4pxcMJnMhlVgd8+JkfJDByJqyviLE4vgoCs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=VJYTYJRp; dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b=R5zk9b/K; arc=fail smtp.client-ip=67.231.149.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cirrus.com
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
	by mx0a-001ae601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52L4px0j019821;
	Fri, 21 Mar 2025 07:21:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	PODMain02222019; bh=zP5wtCkX9IYf+1Hp02TltGbXXRDF8Xlp/e1+8SZ4gyA=; b=
	VJYTYJRpyj9S3NgWUiK53cdgI2gK9u6EK7psqHJXhfoqh8e9DklLiqmsSJzakd24
	yrPXmrcxkqpPI3ylnHos53BYRRGPjU4hw2YchTPtLDOibciVUGJeYqEV9GjNq1gW
	ZkHJON7e0O1iIyXZhau9YuRUdqz6b6i/B/rpWFGCD6V0Zmu22elyTV5MfaATJ4Ux
	yFti6UoK4Qh4+PQvJKW42A2wjDe1UWIj48tnI9H9dMkFV8jFU8sNgoiofDDSjxXX
	NmNbMmMWm4+4Lvf5nwNxCuPHo1loKgx0JbAQfkqKdYMP1Ji8GLrBZ+kdlOQHRZuT
	ZrZK8sPvGXMnWOsZhWmX8g==
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2171.outbound.protection.outlook.com [104.47.55.171])
	by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 45g9p6up0w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 21 Mar 2025 07:21:18 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q8OSdEKviZ/iFh7S8SE3xHlj1+Qel8S2FAuFS2BNmYoNhtob7C+Ox9Zlxdauqu2D9jw9v3h2x8jrly2rVSyWvjaGhvvq5OzN8UbKRBLo+C4+bF52iC9b3aTUrsr9rTJTt4TYhoy/Sr4lrYZXDFEXPdSiA/Y5RYhICk+1CFMzXCR98kekrP4tXAkHLaLaxgh80FHiztOXGuGCVXSEAfa+U3tW89aZ7IOwTHKOua2wks5HzRt2HRPrQxRJx3CtkY9iXtRXReRhpPvJ3+cUenm1V3rLnVFaZ1nvoFDg1hZ2kwpgozciywidAlmtuV5gJ99ByFnYnLQXHvaYR2tiaCQLvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zP5wtCkX9IYf+1Hp02TltGbXXRDF8Xlp/e1+8SZ4gyA=;
 b=UEMHczeWKAezyPFN6lSwbb8tG71qZPzIh6RvoW1l7i6pTQMhRJdjX64FiTxWYXORChDq4uNIO+wdSkpnxEylFs3dDMrIPewTZXxswYSAMPd8iVXIqEEIqkt3OI8kjYKFR0ofLxFcl29AyyvdHIpmo+M4LHZgT+FhRGSJJrvk5aJT/24vB+tZBoUA5EdA0f1gXhcqZj56XE6emr5nYQKJmcGo4jkzLQGYkKgJSr0sI+MTef1/aTWQ3zWsgSnmaiu0ZZFd6FjKeipG1YUnpAd4VZy1o69b0zr3p4HtxMfcUUpuihPmF+/alDRg9p3SSm+NYut++G5MUch1cUCxvhtFgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 84.19.233.75) smtp.rcpttodomain=canonical.com smtp.mailfrom=cirrus.com;
 dmarc=fail (p=reject sp=reject pct=100) action=oreject
 header.from=opensource.cirrus.com; dkim=none (message not signed); arc=none
 (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cirrus4.onmicrosoft.com; s=selector2-cirrus4-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zP5wtCkX9IYf+1Hp02TltGbXXRDF8Xlp/e1+8SZ4gyA=;
 b=R5zk9b/Kh50Ly746xsRp1Wpq2I4HaKllKwIEuKir7rc418Bou1hywMzWcnYhQNBKIXOoy+5/LEcpjOwwrVV3OpioACQRBkT10HqYQwQcp+h84CIq7exdDnjGXyolg3SK5qmhrwG1kI2to2MqpVYN8IdpDqQ5mhrVPmrFBS9/xHs=
Received: from BN8PR07CA0023.namprd07.prod.outlook.com (2603:10b6:408:ac::36)
 by CY5PR19MB6520.namprd19.prod.outlook.com (2603:10b6:930:34::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.37; Fri, 21 Mar
 2025 12:21:13 +0000
Received: from BL02EPF00029927.namprd02.prod.outlook.com
 (2603:10b6:408:ac:cafe::aa) by BN8PR07CA0023.outlook.office365.com
 (2603:10b6:408:ac::36) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.34 via Frontend Transport; Fri,
 21 Mar 2025 12:21:11 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 84.19.233.75)
 smtp.mailfrom=cirrus.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=opensource.cirrus.com;
Received-SPF: Fail (protection.outlook.com: domain of cirrus.com does not
 designate 84.19.233.75 as permitted sender) receiver=protection.outlook.com;
 client-ip=84.19.233.75; helo=edirelay1.ad.cirrus.com;
Received: from edirelay1.ad.cirrus.com (84.19.233.75) by
 BL02EPF00029927.mail.protection.outlook.com (10.167.249.52) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.20
 via Frontend Transport; Fri, 21 Mar 2025 12:21:11 +0000
Received: from ediswmail9.ad.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by edirelay1.ad.cirrus.com (Postfix) with ESMTPS id B7008406540;
	Fri, 21 Mar 2025 12:21:09 +0000 (UTC)
Received: from EDIN6ZZ2FY3 (EDIN6ZZ2FY3.ad.cirrus.com [198.90.188.28])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTP id 794FA820244;
	Fri, 21 Mar 2025 12:21:09 +0000 (UTC)
From: "Simon Trimmer" <simont@opensource.cirrus.com>
To: "'Chris Chiu'" <chris.chiu@canonical.com>, <tiwai@suse.com>,
        <perex@perex.cz>
Cc: <sbinding@opensource.cirrus.com>, <linux-sound@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20250321104914.544233-1-chris.chiu@canonical.com>
In-Reply-To: <20250321104914.544233-1-chris.chiu@canonical.com>
Subject: RE: [PATCH v2 1/2] ALSA: hda/realtek: fix micmute LEDs on HP Laptops with ALC3315
Date: Fri, 21 Mar 2025 12:21:09 -0000
Message-ID: <000e01db9a5b$ba553790$2effa6b0$@opensource.cirrus.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQInA7gw2D6OBt8zSf+61PVcPXbPp7Lmrlqw
Content-Language: en-gb
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00029927:EE_|CY5PR19MB6520:EE_
X-MS-Office365-Filtering-Correlation-Id: c7b11677-4ce7-4416-2f8d-08dd6872ddc4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|376014|61400799027|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YzRvdDB2Ymo0NmUzY1VlOHJHRmRNYzFjYU8rNDZ6K09vKzhjdDhsRFY4RXJ5?=
 =?utf-8?B?S3NaMmlWRi9sT1V0RXdtVlBsMHM5UGsrWE9UcnRZRmhWT252Nk5RQlpkNDZ3?=
 =?utf-8?B?VTdwQVpuTHhOQjl0UDRjWG55b0JhZy8vZ0dXNS9OSDZKWGI4ekJOaUhQL1lp?=
 =?utf-8?B?UmE0cVErS0IrNjBJR1p5dVRFMEwwUjRkQ2ozRGllcm03TEJINHpxdkFCMXlY?=
 =?utf-8?B?Qzk0VG1kbGRHVkpzMm91SEp1b1lBQnNsUmY4RFVUNWh6OHIwUzRCSk1qcldZ?=
 =?utf-8?B?S29qTVp3SmdnekpCS1orNlg1VSswcDh2emJyUFFRamV1Z3hhTlY5N01WemlI?=
 =?utf-8?B?Z1ZGQVl3Z1ZWQWRaSmtDUkJ6MUJYWXFjcjJuM3hrTnhRazBQbW0rK1NNN2Nj?=
 =?utf-8?B?ODBNTnc1M2lBdDJSaGluWGQ5OStoOHZMMUFoWUw2RnlYeXdkUlpHSTJiM0dL?=
 =?utf-8?B?UVUyblA3OElRMHhwOGplWVk1Qk1lYXVEdEhVTHBOaDhUUjV2UnM0VWFnc08r?=
 =?utf-8?B?TXBLWmxYSHZDVmhzd2hSRnQwT01pZXN1WW9WMlNUZm55WlZCZUVTSGZJT09h?=
 =?utf-8?B?bFRZNjBMbmR6dEhydTFhWk1mNlR1Z3lwL21UeWVKUUxLdUlYVlA4elp1VHNr?=
 =?utf-8?B?R1RHSGhZQ3lFVmt3UThuNXRzWGdkTXA5ZG9uckNpajZiZHJITzRsRTErVmtp?=
 =?utf-8?B?Z2V2eTFNdE9QNkxRSlh3YWVuY1o1OWlvNHJsVmMyK2VPcWpOejRRa2EvZjlQ?=
 =?utf-8?B?OVFsOUIxTlhBbHdMTGxTVXQ0aDN3VitlZWJTT1dORnlsL0ZtQm1sb2lQQWtZ?=
 =?utf-8?B?N1ArYkVTOFpBWS9wd2lkMjNkVkNGM0tBV0d2L1ExSng5c0k5VitYZ29jb2FK?=
 =?utf-8?B?YWFMTEtIbVlJMmpEbGl1ZkVMYWV2cjJWV1FuMmdFY1B1VzQ5WURnajEvMFhS?=
 =?utf-8?B?YlA4R0llM09uaUkyRWJkWUNVMUtwTlJYYmFhN2N1RlNkemtuZGhQVG9BWFk5?=
 =?utf-8?B?Mk5lWWZZTDhhbFhCMlhhUGNKS0VnVm03QXFNQlBLYlF3cnNYYXo2Vjk1cndF?=
 =?utf-8?B?ajJycndVdy9wTVBlWDk5Z3pGTkZsYTBoZEIvRDBqMnd2Y0E1R1pHVHRzY0gr?=
 =?utf-8?B?L0NsbzVReUZoK0UzNmJDblBDSm5EQmoxclZWbmltbVNwblhpMS9LWVo3M2pR?=
 =?utf-8?B?WldWQ2hnWEMwSjZrUzd6N3FhanFuODJFQ1YxbmlUTXlHVk1xTTNEQnZCTUFu?=
 =?utf-8?B?MGFlQkM2eEErT21BSzlibDVwajRDVzJlaE9Kc2MwWVVJY1hDQ2h4SFBBTm9M?=
 =?utf-8?B?THNJZnRyMkRocGd4MXRmVThrOTRpZzBPM3JmOW15Z1QwR0U2ak1ZTEpES2V0?=
 =?utf-8?B?eWZKMnZmaU5mekpMTGh0SDdSYWVEVGRpblM0YW8rWUpqaFRNS2J5eWxFRDdv?=
 =?utf-8?B?ZUwvTHZYWk9nWC8yYm5QOE9NckRwZDYrWXEzY0trNWUvY0FjRTRBQmZaanZv?=
 =?utf-8?B?ckJIeGlKdSt5ZlRaakJVeHlvamFzVmxOZ1pPWU9hK1ZqNU0vbm5kWUVUL0lp?=
 =?utf-8?B?WUpkV3ZiWkpZY29kZWlrUWs1MDNRMTJzRXZENHR1ajgzV0xrcjltSUNLTUJL?=
 =?utf-8?B?WGxCMmR1SVdHTnVLTEFpQVVDcnVvTm00YjJhblRzZXJLbjFqNEdtYVNuOUxt?=
 =?utf-8?B?YVRkYnp3aGpjd0F2UHhZNitSQlpSZ0l5ODAxODJRWVIxNjI2bE5NSGFvd2k5?=
 =?utf-8?B?eHNXZ3o2dXFHZU10V1lneTdxZ3JydE9vZzhuTkRBa2dVUjJqRHQwSkdGYUNQ?=
 =?utf-8?B?VUxiRnJ1aWFqbVdsdzkxbFhSYUl5aEgxZjVvaEtRaFhxa1QvTDEvdFBra25R?=
 =?utf-8?B?dVRIdE5zZlhzVDZDWHJiR2FnYU0yTkRDU3NFamZJdTBsd1E5a1UrQ1ZxOFZm?=
 =?utf-8?B?bjJCZ2hORC9OWTZnNHUzZjltVzQ4OVJUYTFtWWNtQUVlYzhuZE8rRkF6Y3hj?=
 =?utf-8?Q?E1TCfwqIuEA3QmdeE+Zz8ClAZ6hC90=3D?=
X-Forefront-Antispam-Report:
	CIP:84.19.233.75;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:edirelay1.ad.cirrus.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(376014)(61400799027)(7053199007);DIR:OUT;SFP:1102;
X-OriginatorOrg: opensource.cirrus.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2025 12:21:11.0629
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c7b11677-4ce7-4416-2f8d-08dd6872ddc4
X-MS-Exchange-CrossTenant-Id: bec09025-e5bc-40d1-a355-8e955c307de8
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bec09025-e5bc-40d1-a355-8e955c307de8;Ip=[84.19.233.75];Helo=[edirelay1.ad.cirrus.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF00029927.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR19MB6520
X-Authority-Analysis: v=2.4 cv=Vcz3PEp9 c=1 sm=1 tr=0 ts=67dd59be cx=c_pps a=98TgpmV4a5moxWevO5qy4g==:117 a=h1hSm8JtM9GN1ddwPAif2w==:17 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=IkcTkHD0fZMA:10 a=Vs1iUdzkB0EA:10
 a=s63m1ICgrNkA:10 a=RWc_ulEos4gA:10 a=DfNHnWVPAAAA:8 a=w1d2syhTAAAA:8 a=5809KSv0kg3IaEw2gHkA:9 a=QEXdDO2ut3YA:10 a=rjTVMONInIDnV1a_A2c_:22 a=BGLuxUZjE2igh1l4FkT-:22
X-Proofpoint-GUID: 11Abrt0bf2GtBsSKiN0lvttCBpWKZykm
X-Proofpoint-ORIG-GUID: 11Abrt0bf2GtBsSKiN0lvttCBpWKZykm
X-Proofpoint-Spam-Reason: safe

On Fri, Mar 21, 2025 at 10:49=E2=80=AFAM Chris Chiu wrote
> More HP laptops with Realtek HDA codec ALC3315 with combined CS35L56
> Amplifiers need quirk ALC285_FIXUP_HP_GPIO_LED to fix the micmute LED.
>=20
> Signed-off-by: Chris Chiu <chris.chiu@canonical.com>
> ---
>  sound/pci/hda/patch_realtek.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
>=20
> diff --git a/sound/pci/hda/patch_realtek.c =
b/sound/pci/hda/patch_realtek.c
> index 1d8caf791dbc..30d4cd93dae1 100644
> --- a/sound/pci/hda/patch_realtek.c
> +++ b/sound/pci/hda/patch_realtek.c
> @@ -10723,13 +10723,27 @@ static const struct hda_quirk =
alc269_fixup_tbl[]
> =3D {
>  	SND_PCI_QUIRK(0x103c, 0x8cf5, "HP ZBook Studio 16",
> ALC245_FIXUP_CS35L41_SPI_4_HP_GPIO_LED),
>  	SND_PCI_QUIRK(0x103c, 0x8d01, "HP ZBook Power 14 G12",
> ALC285_FIXUP_HP_GPIO_LED),
>  	SND_PCI_QUIRK(0x103c, 0x8d84, "HP EliteBook X G1i",
> ALC285_FIXUP_HP_GPIO_LED),
> +	SND_PCI_QUIRK(0x103c, 0x8d85, "HP EliteBook 14 G12",
> ALC285_FIXUP_HP_GPIO_LED),
> +	SND_PCI_QUIRK(0x103c, 0x8d86, "HP Elite X360 14 G12",
> ALC285_FIXUP_HP_GPIO_LED),
> +	SND_PCI_QUIRK(0x103c, 0x8d8c, "HP EliteBook 13 G12",
> ALC285_FIXUP_HP_GPIO_LED),
> +	SND_PCI_QUIRK(0x103c, 0x8d8d, "HP Elite X360 13 G12",
> ALC285_FIXUP_HP_GPIO_LED),
> +	SND_PCI_QUIRK(0x103c, 0x8d8e, "HP EliteBook 14 G12",
> ALC285_FIXUP_HP_GPIO_LED),
> +	SND_PCI_QUIRK(0x103c, 0x8d8f, "HP EliteBook 14 G12",
> ALC285_FIXUP_HP_GPIO_LED),
> +	SND_PCI_QUIRK(0x103c, 0x8d90, "HP EliteBook 16 G12",
> ALC285_FIXUP_HP_GPIO_LED),
>  	SND_PCI_QUIRK(0x103c, 0x8d91, "HP ZBook Firefly 14 G12",
> ALC285_FIXUP_HP_GPIO_LED),
>  	SND_PCI_QUIRK(0x103c, 0x8d92, "HP ZBook Firefly 16 G12",
> ALC285_FIXUP_HP_GPIO_LED),
>  	SND_PCI_QUIRK(0x103c, 0x8de8, "HP Gemtree",
> ALC245_FIXUP_TAS2781_SPI_2),
>  	SND_PCI_QUIRK(0x103c, 0x8de9, "HP Gemtree",
> ALC245_FIXUP_TAS2781_SPI_2),
> +	SND_PCI_QUIRK(0x103c, 0x8e14, "HP ZBook Firefly 14 G12",
> ALC285_FIXUP_HP_GPIO_LED),
> +	SND_PCI_QUIRK(0x103c, 0x8e15, "HP ZBook Firefly 14 G12",
> ALC285_FIXUP_HP_GPIO_LED),
> +	SND_PCI_QUIRK(0x103c, 0x8e16, "HP ZBook Firefly 14 G12",
> ALC285_FIXUP_HP_GPIO_LED),
> +	SND_PCI_QUIRK(0x103c, 0x8e17, "HP ZBook Firefly 14 G12",
> ALC285_FIXUP_HP_GPIO_LED),
>  	SND_PCI_QUIRK(0x103c, 0x8e18, "HP ZBook Firefly 14 G12A",
> ALC285_FIXUP_HP_GPIO_LED),
>  	SND_PCI_QUIRK(0x103c, 0x8e19, "HP ZBook Firefly 14 G12A",
> ALC285_FIXUP_HP_GPIO_LED),
>  	SND_PCI_QUIRK(0x103c, 0x8e1a, "HP ZBook Firefly 14 G12A",
> ALC285_FIXUP_HP_GPIO_LED),
> +	SND_PCI_QUIRK(0x103c, 0x8e1b, "HP EliteBook G12",
> ALC285_FIXUP_HP_GPIO_LED),
> +	SND_PCI_QUIRK(0x103c, 0x8e1c, "HP EliteBook G12",
> ALC285_FIXUP_HP_GPIO_LED),
> +	SND_PCI_QUIRK(0x103c, 0x8e2c, "HP EliteBook 16 G12",
> ALC285_FIXUP_HP_GPIO_LED),
>  	SND_PCI_QUIRK(0x1043, 0x103e, "ASUS X540SA",
> ALC256_FIXUP_ASUS_MIC),
>  	SND_PCI_QUIRK(0x1043, 0x103f, "ASUS TX300",
> ALC282_FIXUP_ASUS_TX300),
>  	SND_PCI_QUIRK(0x1043, 0x1054, "ASUS G614FH/FM/FP",
> ALC287_FIXUP_CS35L41_I2C_2),
> --
> 2.34.1
>=20

Looks fine to me

Reviewed-by: Simon Trimmer <simont@opensource.cirrus.com>

-Simon


