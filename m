Return-Path: <linux-kernel+bounces-563004-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E9108A63599
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Mar 2025 13:20:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 057353AF97A
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Mar 2025 12:20:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 978911A5BA6;
	Sun, 16 Mar 2025 12:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="bjGbGwTN"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2062.outbound.protection.outlook.com [40.107.223.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CD661A0BE0;
	Sun, 16 Mar 2025 12:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742127620; cv=fail; b=PIeMVIspfox5DeK+1UhIf1vXFI64fBECtN+5QbphKAugj/xjceZaNcHkMIACx2ETCY3WIGu0MGbnH/x7fwtw+/grRnBNzncKR48uwbxlbGLHJj24hHCGh62WVGHMhthjQU5bghT779rBNTdEtMFhZUvmlrd5qcr8Vt1Q+Sf+sk4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742127620; c=relaxed/simple;
	bh=HhvFIosJQvoOEGZ45COK+2aRRFlR7E/mouzVr0xXgnU=;
	h=Content-Type:Date:Message-Id:Subject:From:To:Cc:References:
	 In-Reply-To:MIME-Version; b=Eghk08wcVmVPsJd10MkwzSpK2FyPPKHOJsqylzFJNAIdsNE+/1Tf1+SJoz77lAIFKmXKaVqV20pbRFWXd7PhrY4HYlNC7h1Cp7GaVQ3CCLpw4fhEn6oIz/6rqclfPZFFC8JL2ygFThuDfkAmVMrhVbde0GzW+EiwCjbtHptiIOs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=bjGbGwTN; arc=fail smtp.client-ip=40.107.223.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ynESOQ5/vb1FzvcTzEMp0t24klXfn4XOjzura1BLUji66FlWa9kUuAIj9GpYnVjg+QArWE0oedEwjLw2wQzBOEEG77maEpkrDxSKI1khygeSAH4znXEwMxoxp3ieTfmwZoB9A6KG/dDPqWicCc2RlNJeJBTmAZVeh15CjnXBamo8pjiXv6pyUnI0tUSXMLmpZ0Ro1RlDjAfE8ZqP3jll+F6JJqoCi2VttgAnUcBe8BgY1W8ndQSQgtgJw12wMBYwTbfdpAd3yOkfYdxa7qvVk2siihgHpPtgQwrBQk/x4/fcaXPgSLTKI25K08IKGB/CAve33L/lkJXYqDFrxXYWXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dOn2R4WMa+x5ubS+yFgHLBRKUnP68SVC1SDzlOU8+1A=;
 b=kLfpeLfjQ2oaCkI3KAXh16WZ0rCda7yzdArBhO9TDsh7XcD1svDWLrh+2boUPeUoKgh9bFfKbYbBpSKdUNWDibh0yliYZq7DMhu19LCVWlO7Ghiz3XKgPVI5Iz4mr00cTbmnL7suKUeCxTXEwVafSPJg1/FO5x2vnsAsHaq0El9hV0PTmcxceLzouTiHausWobMgEcDvTqHC5UeAIZU1kwFkX8mhJYIwdp6nRMX8aq/jasrd6gE/tnFDdSYf8sQnBsXTBBJ8AgOefppKzrN/XFOz1DK9MI7PyBvD9BdZrph4F7HrPCLto9BpwAG5tePSdeGcnh7ojPrjnlCVyw7aZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dOn2R4WMa+x5ubS+yFgHLBRKUnP68SVC1SDzlOU8+1A=;
 b=bjGbGwTNyp69EzpoTQkte5uMvP6tV3s2xgRhSmgkDiX60cNQzsEsHdyo9h75BC4J48nawldTnnWqVPeioUtxaKu087dG8wM+ocSGKxPWssPO2Nw4BRsn67mXFot0Apkdlira0xXq+03TDnzKGIi/EncSljZ/x/TV3PsPrNlkbEQmy/Rb+EhJB/yv3XfKiNK1xIQIe/BqPC2W4IiyoqC/cScuO7i8aOfGX7eR9qS//VheNO3NXcUQ3yADjrXmW21pDIlc0tKR75fizrfJ6ccklUR9Ps4eHbmkEjvqxedCEg8f3CyfcXJo9cYVC517/t8fN5gCLIPXJhwOqu4fMUb2mQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB3997.namprd12.prod.outlook.com (2603:10b6:208:161::11)
 by CH3PR12MB8756.namprd12.prod.outlook.com (2603:10b6:610:17f::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Sun, 16 Mar
 2025 12:20:14 +0000
Received: from MN2PR12MB3997.namprd12.prod.outlook.com
 ([fe80::d161:329:fdd3:e316]) by MN2PR12MB3997.namprd12.prod.outlook.com
 ([fe80::d161:329:fdd3:e316%6]) with mapi id 15.20.8534.031; Sun, 16 Mar 2025
 12:20:14 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sun, 16 Mar 2025 21:20:03 +0900
Message-Id: <D8HOP09FU367.2MVDRQ5G0OPV@nvidia.com>
Subject: Re: [PATCH] rust/revocable: add try_with() convenience method
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Benno Lossin" <benno.lossin@proton.me>, "Danilo Krummrich"
 <dakr@kernel.org>
Cc: "Miguel Ojeda" <ojeda@kernel.org>, "Alex Gaynor"
 <alex.gaynor@gmail.com>, "Boqun Feng" <boqun.feng@gmail.com>, "Gary Guo"
 <gary@garyguo.net>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Andreas Hindborg" <a.hindborg@kernel.org>,
 "Alice Ryhl" <aliceryhl@google.com>, "Trevor Gross" <tmgross@umich.edu>,
 <rust-for-linux@vger.kernel.org>, <linux-kernel@vger.kernel.org>
X-Mailer: aerc 0.20.1-0-g2ecb8770224a
References: <20250313-try_with-v1-1-adcae7ed98a9@nvidia.com>
 <D8F7D2RPRVAO.2EF39MZXM6FPR@proton.me>
 <D8F8E4PBHK7O.399Y83M1L3XK3@nvidia.com>
 <D8F91L51P2EA.2FBHGJYSV06HY@proton.me> <Z9L-Z4Aw64Hi5Lj8@pollux>
 <D8FBUHBNPIEL.5A8GOEMPJSEA@proton.me>
 <D8GWCWYM15WI.3II7R71LIAEI9@nvidia.com> <Z9WL-95sJ0DCpaPa@pollux>
 <D8GWQXK312SX.2RI3EOHM1QGG3@nvidia.com>
 <D8H11HOL93UD.31F853PYJA9U2@proton.me>
In-Reply-To: <D8H11HOL93UD.31F853PYJA9U2@proton.me>
X-ClientProxiedBy: OSTPR01CA0034.jpnprd01.prod.outlook.com
 (2603:1096:604:21b::8) To BY5PR12MB3986.namprd12.prod.outlook.com
 (2603:10b6:a03:195::27)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB3997:EE_|CH3PR12MB8756:EE_
X-MS-Office365-Filtering-Correlation-Id: aabd2865-b3c9-4476-b0e1-08dd6484e65c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|10070799003;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VUZTTmN3YmNPMkk2Vkk5Tit3cDl4SllSajVvM0RtOTdwM3llZWFjVnZ2K0FE?=
 =?utf-8?B?Wk95M0V4YXloMWFGanIvMW85Z1MyTW5VNFhwckhNb01PQTNpMkxpSkRBYi9y?=
 =?utf-8?B?WGJOWjdDWitWbnYwRHFUb2xHaW1QMWxzeXhOMWVSVU9UYlluZ2kvMHNiamQy?=
 =?utf-8?B?VmFienRERUZsUmI3bVdLYnNVVlpEOFdKeTNpREZ1M3FYZmVsaXpzTmttMDI3?=
 =?utf-8?B?ZWN3OGhZSjhtWmtyMlhEaUQ0SEJ5VTVlRVRSbTRGR01sY1FQRzRiN2hHZ2dS?=
 =?utf-8?B?ZDV4cVZub3liZHo5bUc4L3AwWnhuKzFlTXFraWJ1aFdTQm5KZmo3eTZLYVZ2?=
 =?utf-8?B?eVRybEZvVnJ1N3dDVUlVdzNySjVSTzBrYmsyRVJlQW9GSHNzZVFvdW9WWXcw?=
 =?utf-8?B?U0xkYnJjVmEwd3FyUTQ0ZXhQa1BlbFpnQTEzbjNKOUcvaHpVVy9nbytYd05L?=
 =?utf-8?B?RWxzTjZIZ0wwbkpqNWdQaDVGSmhjY0VIbjhtcDA5bjRCWEZPd0swb1RML0hn?=
 =?utf-8?B?NU9uZkxEUXo3dWxTOVJWNHJscmdYTDEyN2o4dCtsbHp2aUZmS2owMjRxemE4?=
 =?utf-8?B?c2hJRXo4aGY5NDhTOWdPNTJIWS81aXk4OXovc0QySENWM2hOTEplZEJMak00?=
 =?utf-8?B?VDlvZmdwOXViV1FPWSt4RkhzWXk3Y2tNRHl2Wm1xcWNLZmNHM2RvOGczTHVr?=
 =?utf-8?B?WkJTaU9tZkpRSUt3czU3Skx2WWZBRit0SXJCZlM3ZkdhVzNHT2htWEdFT2NH?=
 =?utf-8?B?SStTSVFTbHpoZDZKZXlWTVh3TWt1dTFlZU1CWmRtc1hmOU1qc1pFLzlQSWxw?=
 =?utf-8?B?b29UYXloam5KSjEvTWtGWmFCU0xUSWpHSGtSc2ZHUFdoZjE1NDJOSUR4a0dq?=
 =?utf-8?B?NGEvZUlGZ2M3eDRxNnhiNjNLK1c2V3B4MWNRbnRoRXJUYm4wdllnK1R5ekR4?=
 =?utf-8?B?UC9WeU96TnFtSkFSRlJWZ2ZFTWt1a0FpT0t1MVcvVmdmSmdkS3phSUloMXpa?=
 =?utf-8?B?cGJabWQvTzRySzg5Yy9zL3dPVldHTlo5dDVEUkxJU0l6WWdsQkdZWFlzajQ0?=
 =?utf-8?B?TUJVNGluNG9oZkVDUDdSQitJZnpSL3dlU0FXbzN4SUVRUkcrTHpPMGhkTm50?=
 =?utf-8?B?R3h1eW4vbk5kZUVUcXBEdVhkV2t1aUsycHpEWlNCUWRMRnF3cG1YZEg3V1NO?=
 =?utf-8?B?SmlLbVE3T3p5enhhZEo2U2plUTg4WkdDZ0ZZWEdRQy9uVXp6dVMxRFIwUUFi?=
 =?utf-8?B?Yitvem1SY0lhVEVKVGRkUW5lYllLOE9xaGZWTlBOaGFJYno5RWhRRjdFSmpi?=
 =?utf-8?B?S1J3RmVPcmJ0bWp1YlNyQkxUbkRtZUpUZWxqZVFCZms5WTBTTlZ2cXUzcGIr?=
 =?utf-8?B?c2V3eUdYQkJtVDA3M2tMNXFCeFBWc2ZPRktHcFRvd29kSG5vV2Q4M05CSUhC?=
 =?utf-8?B?MFB6cWhHUzNJZlpwaTVCRk1EM3ExaDhXOHl5c3hkTXlZTitreStkUzYvQTlR?=
 =?utf-8?B?cmdFVERNZ1EyUWJ4T1B6dk02K21KNkRkQ2FnTE4wSmZ2OEFhS3h4RlpRdXla?=
 =?utf-8?B?RWo3TldXLzQrK3BNamFENEx0aWE0ckRYY0d6YUluMmtvbURNdHYxYy9WL2tG?=
 =?utf-8?B?VklHZWNnN3VxOVhLL2Q2YnYvdEtuTThUU1hUcWgrdXpGNmhsL3lsMnFtSGdr?=
 =?utf-8?B?aDYwbGhwa0JhNUFNcnVYcHJ6bTltWEFRb2JBNUxtRjBmUUZYTUR0dFFmdVZk?=
 =?utf-8?B?dE1uQUZrWXNaRC90QnA2UWdrQWR3Uk56OGlWTG95bWNPR05KaEdMbEMwV0M5?=
 =?utf-8?B?Zi9xTU43WEVyMjN2WXhVK21RU2xDTnlYeWlsQzRiMHIyOE0xMXJGdEdUYzVj?=
 =?utf-8?Q?DKP4Tf025ZTJk?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3997.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(10070799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QXFPT2orL3RTQlZjMlBtK2Y1cXNReGZCZE1xZmNoS0M3b01qaTFnSEVMS0NV?=
 =?utf-8?B?WG54THkzWDBTMmdWU3lLNWRqQmJGVzRIdkk1K01LSmtRQ2JEaUpSMFBMZ0Ir?=
 =?utf-8?B?bUNKaDc1TGc1aVRsSmNmNDZJb3RSTHpYTVpTc3hFL1dIS0RhaXFFZ1N1VXNM?=
 =?utf-8?B?UXNQR2NWRVNEN0NMNnRZZEtia3BQRnMxdE9nZlJhYTRLbTZ5N3p0T3ltc2tY?=
 =?utf-8?B?STFMSllRRkRKVHFIQnhCcWd3WExSVXUyRlhpSm1UYkpZd2RnMGpVbkZvd04z?=
 =?utf-8?B?SjAzbUZWRnk3Z2NWK1Z6TXhRVFI3akJabG85dVp6VGlaMHJFNWJmd2FpOTEv?=
 =?utf-8?B?eXdjUW9CcUZhV0phdm1IOW9WTGxIWUZtWGNQYzdwTkJsYnVjUHdPQklSY0pD?=
 =?utf-8?B?YWltWm1XY2FYUVpRejFqMnJuaUczNFYrV3VGektMeVM5cFFKQUN6Y3gvMmxP?=
 =?utf-8?B?aGNHQVhvS1pGeTI2RXp5OVByNi9VeUZqeE9UN0ZqYnBoNklqSWdhbXpweTk0?=
 =?utf-8?B?anczckY4S1NnQ2p4cllET2J3T1NxUFFlTDVmdXdHQVIvNWFHR3VHdXcrbVRB?=
 =?utf-8?B?RncydWVBQzArNjh5cm9ra1NkOGpkNXA2emRrR29YTnpmd25SbDR1dkoxaUFz?=
 =?utf-8?B?OGcyTHQ5b05HUFNGTGt2OU5PY0w3WHE3MU5VYVRUbjJ1QkUzTk00bVozbkVD?=
 =?utf-8?B?WWovc0tweWJ1a09RdXJ1TW1oWEpNRUZmRVpCclBFWUxxTGdIOC9BdE94bWI1?=
 =?utf-8?B?TEE2ZDlFWkVDdXpmdGJpR2VFVHp1aUpYQVlUcnBWUldGRUQrbDRqUVZFTng2?=
 =?utf-8?B?YUlQUHR3UmR1SHhjRDYwY2pBNUIrVk1yYXV4ZGlEOTZ5L0RReVBGaXlQejlm?=
 =?utf-8?B?ZmU0RWhWdDVNckFKZ28yZFg3clV0bjZLL25tNVRaRzBCNVpSOGpxWXhqcjdI?=
 =?utf-8?B?OTVuMDd6YUtpL0VJcjhPODlmRDhoMGVhRnNuZ2ljQS9Tb1hYdmVOWC9HaE5k?=
 =?utf-8?B?M3AxSnFCSTlTdXoybldYYkFKa3lOSEZrY1pzOTRoN1pEczJqR3F1b1REZjRn?=
 =?utf-8?B?aDVsVEwyV1NDMnZHSGpHb3orSVliNk15OUpCZHVzSTlvZlZNcUhUZ1Y2MkJt?=
 =?utf-8?B?cEpCU0F5bzU1MVVVa3NxQUtQeWc5NjNnd09WcVhUWERSd0pxeVBtYTdoNHo3?=
 =?utf-8?B?SHJXMVYvVjlYd0RMTkxSUDRVd3dsblliNzdmYnNoc20rYzBpTFBSZDhTMUxj?=
 =?utf-8?B?M0JBamZRS1JONkJPQUtFL2F0cnNSY3Y1OVFXb29VaVpGS1ZJRjFSK1o3em1p?=
 =?utf-8?B?aWFsamJYSXBuR1hoeVZEbVZtdDRweXdTbVAzeHNJSEd3bVYxb29OR2F1dWhS?=
 =?utf-8?B?bHVCRkplWSthbVM2YkNkeGFGTERuRHI0dkNoR285QjNWWWlEd05lY2UwZHdL?=
 =?utf-8?B?cnBFY2puSkVhYXVwaGNUeFRxZGZyNlpTWGtmNWlKeHhjU3lod2cxUkp4WlN4?=
 =?utf-8?B?WlF0UmpGMk83alpBdUdvcEhRc3U3NXVoSldJMFhuTyt1a2FRbGJ2K0NVSGwr?=
 =?utf-8?B?OTFicGpSQzhTTXUxY0pBbUIrQXN3eXhJelFqRDM3ajBiaFZNUW1iV0xIOXBB?=
 =?utf-8?B?SUx4RldNN0JRMEM3RkJJdXNwRkZwSStOYnFpVWpTcWJDMkl6UndiWGVGUXVj?=
 =?utf-8?B?RlNSWlJpQlRxR3N1RHlhSU0zeTZrR2JlaGxTckcraURreWN2OG5lNjBvSmlj?=
 =?utf-8?B?LzBESm1HK2ZkR1J6ZndXUVNjbEUwSzlObjNYR0VJR1N1QnNJUmFnOGNMcUNH?=
 =?utf-8?B?c3VDTGM1cnBzUngwbDFZb3djUnVlbXNPWm9yVmllV2RmLytEcVBBcWs4OGph?=
 =?utf-8?B?ZDVOMVZCcmZXU0p5akxlV1ZsQk00R0RMTDZjN0t5SjFrZUl1VjVkaE1kZXgx?=
 =?utf-8?B?VGJDRUNETHVsOVNCVXpKQ282a1ZqcjIyMENSMm5XTGFDbTlmek52bWJ2VUJY?=
 =?utf-8?B?SkFhbnZjY3pQWHBKS0YwdUVxN0wwOXdxL2d1WTY4Y0MzRGVMbkVNQjNxdzNR?=
 =?utf-8?B?R3FxRkNxbmdrMzVSVzZyS3pCaW9RQ3dVL3NyMlBxdmFUYWhOQWNSbzI2Qmw5?=
 =?utf-8?B?TXZWN2F2aUdocXpIejFqNHVPbExnZ21iNGtseUdNU2xqQnZGZW5rd3ZwR2Vp?=
 =?utf-8?Q?BbU7HrVOfMZgiGgD3UNdbY+RL41+wGTFnR7Hpya9CRBl?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aabd2865-b3c9-4476-b0e1-08dd6484e65c
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB3986.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2025 12:20:14.1046
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xDZQdUkQoan+GKh5PIwOQ+LxjEhJLNS8ZLGXWyWKCMCu8jUUbrTK86lInQy7JnBKFDpf0fpIOb+E1GuA4mYZWw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8756

On Sun Mar 16, 2025 at 2:48 AM JST, Benno Lossin wrote:
> On Sat Mar 15, 2025 at 3:26 PM CET, Alexandre Courbot wrote:
>> On Sat Mar 15, 2025 at 11:17 PM JST, Danilo Krummrich wrote:
>>> On Sat, Mar 15, 2025 at 11:07:44PM +0900, Alexandre Courbot wrote:
>>>> I suppose drivers could add their own macros to do that automatically
>>>> and reduce code verbosity, at the cost of less cohesion across drivers=
.
>>>> Guess I'll go with that if I cannot come with anything better.
>>>
>>> Maybe we could do something more specific but yet generic on top (for t=
he
>>> use-case above), but we still can't assume the exact error code a drive=
r wants
>>> to derive from failing try_access(). So, maybe a driver specific wrappe=
r is
>>> indeed what you want on top of what this patch provides.
>>
>> So be it! It's not that bad and more flexible in the end.
>
> You could have the following signature:
>
>     fn try_access_with<R>(&self, on_vacant: Error, f: impl FnOnce(&T) -> =
Result<R>) -> Result<R>;
>
> That will use the `on_vacant` error instead of hard coding ENXIO. But
> maybe it's better to just have such a wrapper in drivers that actually
> need it (ie even with the concrete error specified and not a parameter).
> You'll know better through actually trying to write a driver.

Yeah, having the extra on_vacant parameter would require callers to
specify the error they need every time, where it is supposed to be
a per-driver constant. So I guess a per-driver macro or wrapper would be
more ergonomic in the end.

