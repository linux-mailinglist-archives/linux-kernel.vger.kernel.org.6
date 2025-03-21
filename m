Return-Path: <linux-kernel+bounces-571222-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C466A6BA97
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 13:23:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D1CB3BDCE7
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 12:22:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAA05225A20;
	Fri, 21 Mar 2025 12:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="RryIk4wc";
	dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b="l+AdIAfP"
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D75F1EA7D3;
	Fri, 21 Mar 2025 12:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.152.168
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742559731; cv=fail; b=qGqPFMseqBKxYtQUHlEpCGf6qTd5trOS1zTzlqTiXDw2OouET0rnW6T+cAa6QoKmv5xeeiB4A5I9gJfnmG4AWyRNX2USQnMaKdN6eOQ5Vlago1uW5qBCJTOHwSW61/Wk9UMkOYVMLqEnyWg0cKNbcAiO3+VQrOH8euZ65H8q2XI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742559731; c=relaxed/simple;
	bh=OQSAx7YnWndX6ORYoL+ucXW+pV5kjDz7NlLVcvRNVFo=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=rk8E+1G+5ri1cukVjVncghVIcy6AO15iSZg+90qdWnhPejMQ0/66IrNYemmJ6lpOYyeirDheUkxBv11yFlzSISum9kSh5cZiaWxs3AXEEoATx9TwjfsaSfg6RsTyCrMU0gY9RulIsaIeOmxn/yJ4XcrJ38NBti8RUxPeSIxGGyc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=RryIk4wc; dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b=l+AdIAfP; arc=fail smtp.client-ip=67.231.152.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cirrus.com
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52L7m8JO023619;
	Fri, 21 Mar 2025 07:22:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	PODMain02222019; bh=OMqBvRSgZam1EU5sAH/Fd4weyCnl3qBcMry2aCnDiro=; b=
	RryIk4wc8L4t16KeLl/yDGcXgMU8oB/plRlLWZWN+CE8xuRl+ywLIH24DeCY6fN0
	CBs0cAKr7mLTvqNuQa8kmSV+MO37w9IBwjw0AtNzZz1uPsudGAZAKt0cqQfBQG9I
	h3/P/YYz9C4iDIL4uJw52qJjnYtsYyPLaXPY75d3T48S+BFInb6aVaX4W9q7FuCw
	py7yq5efWV6XMevdpCl1dTWtLaiBWSLg+Jio8pgzpkImVRN/bTOIieZaF2WpvVcy
	G5/LH1KHWQIbNKcILsONEBtrycrJFBwqvC+xaVrc76P43B0I86wngxxZ5/dz3mK0
	azqWY6OeaXtYfvaUBNttJA==
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2173.outbound.protection.outlook.com [104.47.55.173])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 45h40m0ffy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 21 Mar 2025 07:22:01 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rDLatmLfBQlMRkugMlwV2vKQT2yZY4srHiVfnSgnKV5iDJjZOWquaWAsQSJLk/rPHZhlCw1Bb+Emei/wPoWj46I/ytDy0od8Pn6XE0bztAb5jeNYJOnE/OFwCuDr2AUnx8ZoTSAc6WrlfbNvICnf0tl1NN+9iHwcH+VuDYKJyxZxjAEzqGvUec+ZR+Mpv32MRwxN5m7px2YBJLelatjVV3h2N36IyTpxFpx8gWZYVI67jISd/9vkaD8Qb8LXGEz52/4zpGMCSDKlLwTIJYpL5IrZJtJGdfBsF2Ti6ZLgef/4/Ho/qoBMkQ3BHA1pzXNA6nVeebBqF0Fgy9ThpkAm6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OMqBvRSgZam1EU5sAH/Fd4weyCnl3qBcMry2aCnDiro=;
 b=M9Znp80hgyjJm8/z1aqEve9zTrebgILlR2PmpBT9jH/JTTeEE848muvQPLBPXhwZ0oelJpc1GBQdJgOZor9bDdzBPDIYXACW8fKOGu+vAzrI/keXoUV55fTLHKjT4uYyTzTvqudU94yXZWaAG5WmBqNQWvK+/NrRhBcVpjYNRyr5/2qUsR75e3+nrJjbJvvJZeDBlsiI8DbtKJBlGkUVt5ge6RyXiyvwKk2oekvQouaS/U8jJE8+Hixa5C4HK1bsEOXS6ECFjdg/HdR7/ZlDkj+MH5FO9kNQgufNhN7+k7N8HnpkaUbqIxJJAWzW3nIX6t4nndSX74+EYSvTNZMXRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 84.19.233.75) smtp.rcpttodomain=canonical.com smtp.mailfrom=cirrus.com;
 dmarc=fail (p=reject sp=reject pct=100) action=oreject
 header.from=opensource.cirrus.com; dkim=none (message not signed); arc=none
 (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cirrus4.onmicrosoft.com; s=selector2-cirrus4-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OMqBvRSgZam1EU5sAH/Fd4weyCnl3qBcMry2aCnDiro=;
 b=l+AdIAfPi6Y5kUngyrvPnvlSfa3SMpAOHh20Y9zf9ntz6eoL5+KLMj2NDGZeiRY9TgO7Zqi6LZrtKv9HSoU8AskscoRoQD+DTI2lKKlw9N01c+7Vd9hcMNGe9OND9PHWfwetxwHBBIMqUi7xYiXxa/6Rv3gWBkhun6/r8YTSz0g=
Received: from MW2PR16CA0061.namprd16.prod.outlook.com (2603:10b6:907:1::38)
 by DM3PPFB61000D91.namprd19.prod.outlook.com (2603:10b6:f:fc00::752) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.36; Fri, 21 Mar
 2025 12:21:56 +0000
Received: from SJ5PEPF000001D5.namprd05.prod.outlook.com
 (2603:10b6:907:1:cafe::30) by MW2PR16CA0061.outlook.office365.com
 (2603:10b6:907:1::38) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.34 via Frontend Transport; Fri,
 21 Mar 2025 12:21:56 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 84.19.233.75)
 smtp.mailfrom=cirrus.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=opensource.cirrus.com;
Received-SPF: Fail (protection.outlook.com: domain of cirrus.com does not
 designate 84.19.233.75 as permitted sender) receiver=protection.outlook.com;
 client-ip=84.19.233.75; helo=edirelay1.ad.cirrus.com;
Received: from edirelay1.ad.cirrus.com (84.19.233.75) by
 SJ5PEPF000001D5.mail.protection.outlook.com (10.167.242.57) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.20
 via Frontend Transport; Fri, 21 Mar 2025 12:21:55 +0000
Received: from ediswmail9.ad.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by edirelay1.ad.cirrus.com (Postfix) with ESMTPS id EC021406540;
	Fri, 21 Mar 2025 12:21:53 +0000 (UTC)
Received: from EDIN6ZZ2FY3 (EDIN6ZZ2FY3.ad.cirrus.com [198.90.188.28])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTP id C1746820244;
	Fri, 21 Mar 2025 12:21:53 +0000 (UTC)
From: "Simon Trimmer" <simont@opensource.cirrus.com>
To: "'Chris Chiu'" <chris.chiu@canonical.com>, <tiwai@suse.com>,
        <perex@perex.cz>
Cc: <sbinding@opensource.cirrus.com>, <linux-sound@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20250321104914.544233-1-chris.chiu@canonical.com> <20250321104914.544233-2-chris.chiu@canonical.com>
In-Reply-To: <20250321104914.544233-2-chris.chiu@canonical.com>
Subject: RE: [PATCH v2 2/2] ALSA: hda/realtek: fix micmute LEDs on HP Laptops with ALC3247
Date: Fri, 21 Mar 2025 12:21:53 -0000
Message-ID: <001101db9a5b$d4bb7cc0$7e327640$@opensource.cirrus.com>
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
Thread-Index: AQInA7gw2D6OBt8zSf+61PVcPXbPpwGGZvjOstp81YA=
Content-Language: en-gb
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D5:EE_|DM3PPFB61000D91:EE_
X-MS-Office365-Filtering-Correlation-Id: ac552214-d766-4000-fd60-08dd6872f866
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|61400799027|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NXI5aDFMUlUrN0V2NkZMQ2QrYXlONVcvTzV4c1B4VDJxOGVONFhSTm0waHZO?=
 =?utf-8?B?OEI4bDIwbXNQZTAzaUVKcU1qeUoybzlZemtaRVhrTTl0M2p4NklaaGFoOXk1?=
 =?utf-8?B?aUNDTEduMklvSGFzdldvMHNqVHVkdXROQitaaVJQUHhRUEI5aUhmdVhMQmg5?=
 =?utf-8?B?T3hTN2pOVWtoSWFodGlLZUh3bmNMcHZqWk5SUCtubFpaZ1RMZThKTTV0YVEr?=
 =?utf-8?B?MXk0NXJabWxKTUVNT0l6YnF5ajBrK2kwUFU2d3VzYk1zS1p3K0RhZWZkbElD?=
 =?utf-8?B?YUx4TGNEVlJFNWdYVTJRWCtyM1pXN0QzRmUrMlUwVzR3YWJ3V3hLUGVPSzJ3?=
 =?utf-8?B?VnNtTTVJRjNtOEk4aEdpUzdrb2tWNFR0NUI3Y0dTVE5UYi9hdTdLVWJiNVBX?=
 =?utf-8?B?ekdOSUs1M09PU2NLWVoxMWZFcnNaTFlWWkNteUJ1WFEwMjMzODNKdTRlQzNm?=
 =?utf-8?B?eTZLNURXellKOXB2Y05zcFVIdmZDNDNZZWxQTk9sQ3g5cnNIVEZWY3BCSFNT?=
 =?utf-8?B?MUtqK0dvWS9JRmxaMnVZZk5UTE9mK2FsR2NRL0VOWFZXN3NwVVluaCt3YlVJ?=
 =?utf-8?B?TUg3Y2pBdjBhU1JKaStvelo5b1g2djRpZ3NZbExaaWRMd083djVrWUZLNXhU?=
 =?utf-8?B?am4xM29hWXQ2dGh4SlFjZGEvcjlGL1Y4bWVFNEpwQmZEcEV1NTNTWElER2lx?=
 =?utf-8?B?VE9zdEw4RHo0akFqZENWM2RDcngvRDcxZDRkU3FCb0R3MmJ2Z2ppelJMd2VD?=
 =?utf-8?B?NFJDSnA3Q3NEY3p1ZHY5aUNBRDhReUFRNWVCM28vUldaNERwUUw0Z1ZKZjJ0?=
 =?utf-8?B?NWR2TTM5NnE5azZQM21GUDh2YmRsQ0p6aFNrLzFzdCtoUnZrdjUxRWQxc2JQ?=
 =?utf-8?B?VVVBWlZiZ2hiZFgrK1BBclRQeXlmTTZCc3lDc3R0cXJkQk9qMmhhLzBWZnNk?=
 =?utf-8?B?R3BrTEYyQ2VuaDFqVERQWWxnSnhiNkN0bmxVdktoQ2JlbWV3ZytwTkJNYnBI?=
 =?utf-8?B?MkpsWG45ZndNRWVvMGNnQjdadEhRMUtiSXdQR1RqYlBHb3MyemNhWWdqNDN0?=
 =?utf-8?B?U1Ftd0ord0x1WFpiekJOblE5Znc5KzJSUHljemdSSGZtS1NpYXFrY3lHV3Ar?=
 =?utf-8?B?TzE1TjVmc2lGOWZQbFlKeVVlcSs5VnNnSFN2S1NNNVVrUXZmNklnM0p1Nisv?=
 =?utf-8?B?MGErWjRvcnpjcXZoRlYyWDlFUkFxS25zV0FnSGZqNlQ5eHNEUjZ0Z0N2YklG?=
 =?utf-8?B?VVFWMGJFYjlrbXc0QzVlRWJ0TTYrUjlhTmVXcVM4Q0FtcDJodHZ3bkJpTFhH?=
 =?utf-8?B?TTdzcGlFMmdoMnhWdjI3L0RUdkRYeFhrUTI5VjNTd1NmQzdXTVFQNFFobkNn?=
 =?utf-8?B?RzAvSmtJRUMwWCtYN0c0QisxRHV0RS9KZjNQYnI5aDhkblNpSUFsOEZ5Sk5p?=
 =?utf-8?B?aVhhaFU1VGgrQVlIcW5DR2Q4NmdVWlZoUW5YV1E3ejBBUnBoWXVuT2prNEZX?=
 =?utf-8?B?L0FuV21sc2Q2QVhUTXJIczFzVmJUdk8xZVdaWk5SRjJQZmJZMDAyZ1RHQzUz?=
 =?utf-8?B?VDRmQkNBbndrSWNGdFB6OER5MTFjWnVKajNKRU53cnppRGNtbUNqcFE4NWFE?=
 =?utf-8?B?NjM4VGpVd3QvMmhYeWJ1VjFKSCtzRHVsU2FGWG1oUFpjSE5EMWxBaDFIandB?=
 =?utf-8?B?U1RwdXFKeUFmS0c1VkV1eEVxYWdJazlVRlF1MnpPaCtieVczak9BTzV4S0sz?=
 =?utf-8?B?VTlIRFdlYW1SZUMvOE9pN1BhcDVaSFBMRnQvV2Y2Y29CY1laZDQrYlJhOXpi?=
 =?utf-8?B?YXp5UFB2THQzeHZiTUx2YlZTeDBtY3BZYTFMbnhRcUdaVFZqZFBvbjZRSER6?=
 =?utf-8?B?ZWtEcjVMTDRxbzFPU1U2dFVTOE9jZnd6NlZtOThUZTVhMk5sTnFDQ0dWSmRm?=
 =?utf-8?B?T3FjY1BEcHdDek5CMGJBZnI2UEJnbXkwT3pXYzY4ZjlIcVVBNmd3bzB1WU1D?=
 =?utf-8?Q?OPIhwllO08c4lkhJqakT6kOgDvWeBE=3D?=
X-Forefront-Antispam-Report:
	CIP:84.19.233.75;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:edirelay1.ad.cirrus.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(61400799027)(376014)(7053199007);DIR:OUT;SFP:1102;
X-OriginatorOrg: opensource.cirrus.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2025 12:21:55.6256
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ac552214-d766-4000-fd60-08dd6872f866
X-MS-Exchange-CrossTenant-Id: bec09025-e5bc-40d1-a355-8e955c307de8
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bec09025-e5bc-40d1-a355-8e955c307de8;Ip=[84.19.233.75];Helo=[edirelay1.ad.cirrus.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001D5.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PPFB61000D91
X-Proofpoint-GUID: Pd5al8iqi5Bmb3_r_beRikPJ_afDFGgV
X-Authority-Analysis: v=2.4 cv=DdkXqutW c=1 sm=1 tr=0 ts=67dd59e9 cx=c_pps a=ynuEE1Gfdg78pLiovR0MAg==:117 a=h1hSm8JtM9GN1ddwPAif2w==:17 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=IkcTkHD0fZMA:10 a=Vs1iUdzkB0EA:10
 a=s63m1ICgrNkA:10 a=RWc_ulEos4gA:10 a=DfNHnWVPAAAA:8 a=w1d2syhTAAAA:8 a=NHU5abs-bgiuSG24rwwA:9 a=QEXdDO2ut3YA:10 a=rjTVMONInIDnV1a_A2c_:22 a=BGLuxUZjE2igh1l4FkT-:22
X-Proofpoint-ORIG-GUID: Pd5al8iqi5Bmb3_r_beRikPJ_afDFGgV
X-Proofpoint-Spam-Reason: safe

On Fri, Mar 21, 2025 at 10:49=E2=80=AFAM Chris Chiu wrote
> More HP EliteBook with Realtek HDA codec ALC3247 with combined CS35L56
> Amplifiers need quirk ALC236_FIXUP_HP_GPIO_LED to fix the micmute LED.
>=20
> Signed-off-by: Chris Chiu <chris.chiu@canonical.com>
> ---
>=20
> v2: fix the quirk order by SSIDs
>=20
>  sound/pci/hda/patch_realtek.c | 5 +++++
>  1 file changed, 5 insertions(+)
>=20
> diff --git a/sound/pci/hda/patch_realtek.c =
b/sound/pci/hda/patch_realtek.c
> index 30d4cd93dae1..5bafa8817bad 100644
> --- a/sound/pci/hda/patch_realtek.c
> +++ b/sound/pci/hda/patch_realtek.c
> @@ -10734,6 +10734,11 @@ static const struct hda_quirk =
alc269_fixup_tbl[]
> =3D {
>  	SND_PCI_QUIRK(0x103c, 0x8d92, "HP ZBook Firefly 16 G12",
> ALC285_FIXUP_HP_GPIO_LED),
>  	SND_PCI_QUIRK(0x103c, 0x8de8, "HP Gemtree",
> ALC245_FIXUP_TAS2781_SPI_2),
>  	SND_PCI_QUIRK(0x103c, 0x8de9, "HP Gemtree",
> ALC245_FIXUP_TAS2781_SPI_2),
> +	SND_PCI_QUIRK(0x103c, 0x8dec, "HP EliteBook 640 G12",
> ALC236_FIXUP_HP_GPIO_LED),
> +	SND_PCI_QUIRK(0x103c, 0x8dee, "HP EliteBook 660 G12",
> ALC236_FIXUP_HP_GPIO_LED),
> +	SND_PCI_QUIRK(0x103c, 0x8df0, "HP EliteBook 630 G12",
> ALC236_FIXUP_HP_GPIO_LED),
> +	SND_PCI_QUIRK(0x103c, 0x8dfc, "HP EliteBook 645 G12",
> ALC236_FIXUP_HP_GPIO_LED),
> +	SND_PCI_QUIRK(0x103c, 0x8dfe, "HP EliteBook 665 G12",
> ALC236_FIXUP_HP_GPIO_LED),
>  	SND_PCI_QUIRK(0x103c, 0x8e14, "HP ZBook Firefly 14 G12",
> ALC285_FIXUP_HP_GPIO_LED),
>  	SND_PCI_QUIRK(0x103c, 0x8e15, "HP ZBook Firefly 14 G12",
> ALC285_FIXUP_HP_GPIO_LED),
>  	SND_PCI_QUIRK(0x103c, 0x8e16, "HP ZBook Firefly 14 G12",
> ALC285_FIXUP_HP_GPIO_LED),
> --
> 2.34.1
>=20

Looks fine to me

Reviewed-by: Simon Trimmer <simont@opensource.cirrus.com>

-Simon


