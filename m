Return-Path: <linux-kernel+bounces-354481-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C48ED993E06
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 06:31:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 46ABF1F25654
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 04:31:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51D4B78276;
	Tue,  8 Oct 2024 04:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dell.com header.i=@dell.com header.b="YgdTZ95Z"
Received: from mx0a-00154904.pphosted.com (mx0a-00154904.pphosted.com [148.163.133.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 628ED2B9BB;
	Tue,  8 Oct 2024 04:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.133.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728361881; cv=fail; b=UfwcmYkgG9KwmcjHz9PhY/5/a0EdcYP8wjpnO4DGsDPbewZUfUR8MmrP9EVTEe+dxxMWmm/+9N2dtTy2o4sm0zUwUZnsRRqcMb7wESAIIP93Q3vOUAP+TaCew5sNyJY5C8ksFy9597S2c1mH830WQt1DEXe44huR2KCGP4juOsI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728361881; c=relaxed/simple;
	bh=h3t2v4CZbz2VmUQufD+eHRaYP0fEpbfR4BJB11uI/jw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Uc0taamXHJOL6/3/NSDviXx6gdTtatkqgBwWOCsVA5oRjY+WdTuvpWq5xz3bAoGuBEqe6JQMCdN8b2tCEc0RDj0HQkcCXxTogADRkY2LKiIuw+jGR4yyCRfvjGIGSQpilxgPsxGk4pBg4OrCEIxPUksdVe/RObD0Tkxbcu8OSK0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=dell.com; spf=pass smtp.mailfrom=dell.com; dkim=pass (2048-bit key) header.d=dell.com header.i=@dell.com header.b=YgdTZ95Z; arc=fail smtp.client-ip=148.163.133.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=dell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dell.com
Received: from pps.filterd (m0170393.ppops.net [127.0.0.1])
	by mx0a-00154904.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 497LaVab000830;
	Tue, 8 Oct 2024 00:31:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=smtpout1; bh=6
	uRDVnvRexhWXUfIRhlrhSUf5WKf3qhC6ijV66QT08Q=; b=YgdTZ95ZWgtEDf3Gx
	e19zAaNFYRSDwIZeTOeGZn7H8kEGrtnwMFXbJDfxUST//1xtNQEY2f6uS4so+tsi
	6rLEzxW2AENE/+KFxJS/YGoGI295Lc9wmWUTRmV/yBYV4F0tx4MzxtLuSZt1po5+
	LidogWPl4txOsdpMacfozb1R0FSoLJXtO90ChNy7epUyIcCYKDcEi+Kg5v2DkXyr
	ZduPaezL0ABmHjeclk1wePtZFKkOGaCTjKPCStqWLm/ULBzvWZ6FqgED046xRXKC
	+cq0Pc1d8O+agDkaFZdv/FMtUIKStiZCiv94tgx52/GdaOC6y+4Ja0Nsbyv+G9zz
	dNrvw==
Received: from mx0b-00154901.pphosted.com (mx0b-00154901.pphosted.com [67.231.157.37])
	by mx0a-00154904.pphosted.com (PPS) with ESMTPS id 4230sea554-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 08 Oct 2024 00:31:09 -0400 (EDT)
Received: from pps.filterd (m0089483.ppops.net [127.0.0.1])
	by mx0b-00154901.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4983Wtm3028653;
	Tue, 8 Oct 2024 00:31:08 -0400
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2041.outbound.protection.outlook.com [104.47.56.41])
	by mx0b-00154901.pphosted.com (PPS) with ESMTPS id 424vx6gk18-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 08 Oct 2024 00:31:07 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jp+186DhJnvHkJTvdGf9TNU7Ah0ZnBRIvUzcP/LaSzdVs9YUSHAawmFXNeMfj0NCtJGrIZ46DfslEWKDo8+5W5jyh/BNZUy8DJl9IpiqKdINcg2ioYdhcgGbYD8/qIeCaClCI10PFfA7lxHkxl5CgdO6Ha5VSMjbofG9IrpXbEDFQuQyXI+6LYL57uyDS0vj8eoccxUPwpqfF+iEnD4uPhrnK4Pr7GRP5TMVx28/k3g4mWafJVk49MF2bLzdq5pHcL33nte9/mBWqYhPiaSQruRI6T6QPIA7Eh4vrhHt7arWmIPII5I0ikyz26pXUYD4LbvZWHUWfNKGtDow+hRwzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6uRDVnvRexhWXUfIRhlrhSUf5WKf3qhC6ijV66QT08Q=;
 b=JYbx6o0mc+Kx2QhMBA1tbAU+kjVkUYsRvotWew1VHEYkvjBrNuRLm+bYhZ4VGu7NUcrWYt8U5p9SOCgPyJrKi1g67rkSlfUFV8i53x7EmGF3Vgl5rrIwgD/3rSfxFGxUuN2DLg/zucfbUMA7TWjShgFnFz1QcAnCr23e5OuB+r8hpHpBolJcf6Gqnix8van73mXxf5cbkhe2UASOPXxAIc+Z8s8osffA2JHDAt7sx/Q593sc5f8C1VEaUnnv0b6TfXqoCqTUJJrTdOW/WOV7s+GW+RtLqD5JE3Krsg91TJXwX3JWataXj2B53FJkXEdrPxi3I+aX0xSuKP3/MJ4w+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=dell.com; dmarc=pass action=none header.from=dell.com;
 dkim=pass header.d=dell.com; arc=none
Received: from CH4PR19MB8731.namprd19.prod.outlook.com (2603:10b6:610:22b::9)
 by BY5PR19MB3779.namprd19.prod.outlook.com (2603:10b6:a03:220::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.23; Tue, 8 Oct
 2024 04:31:02 +0000
Received: from CH4PR19MB8731.namprd19.prod.outlook.com
 ([fe80::db43:d59d:5051:33d2]) by CH4PR19MB8731.namprd19.prod.outlook.com
 ([fe80::db43:d59d:5051:33d2%6]) with mapi id 15.20.8026.020; Tue, 8 Oct 2024
 04:31:02 +0000
From: "Ksr, Prasanth" <Prasanth.Ksr@dell.com>
To: "Limonciello, Mario" <mario.limonciello@amd.com>,
        Crag Wang
	<crag0715@gmail.com>,
        "hdegoede@redhat.com" <hdegoede@redhat.com>,
        Dell
 Client Kernel <Dell.Client.Kernel@dell.com>
CC: LKML <linux-kernel@vger.kernel.org>,
        "platform-driver-x86@vger.kernel.org"
	<platform-driver-x86@vger.kernel.org>,
        "Wang, Crag" <Crag.Wang@dell.com>
Subject: RE: [PATCH] platform/x86: dell-sysman: add support for alienware
 products
Thread-Topic: [PATCH] platform/x86: dell-sysman: add support for alienware
 products
Thread-Index: AQHbDYMV8LuZmnBPwUaTZO34l2FJzLJlXY0AgBb70rA=
Date: Tue, 8 Oct 2024 04:31:01 +0000
Message-ID:
 <CH4PR19MB873165A6A20AA85AC907CE5B827E2@CH4PR19MB8731.namprd19.prod.outlook.com>
References: <20240923063658.411071-1-crag_wang@dell.com>
 <7c8b8824-2204-448b-92a4-33b27e3df834@amd.com>
In-Reply-To: <7c8b8824-2204-448b-92a4-33b27e3df834@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_ActionId=39b17920-ea6c-40ed-b497-b1dcd8728285;MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_ContentBits=0;MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_Enabled=true;MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_Method=Standard;MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_Name=No
 Protection (Label Only) - Internal
 Use;MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_SetDate=2024-10-08T04:26:09Z;MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_SiteId=945c199a-83a2-4e80-9f8c-5a91be5752dd;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH4PR19MB8731:EE_|BY5PR19MB3779:EE_
x-ms-office365-filtering-correlation-id: 1a3bb1d1-65e0-47b4-3169-08dce75203fc
x-ld-processed: 945c199a-83a2-4e80-9f8c-5a91be5752dd,ExtAddr
x-exotenant: 2khUwGVqB6N9v58KS13ncyUmMJd8q4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|1800799024|366016|10070799003|38070700018;
x-microsoft-antispam-message-info:
 =?utf-7?B?VWxrQTdNdGtKRVRuaEpVRDlZS3gwTWJ1aFFUVHNKOWNSdTRicUNlTG9jYkVD?=
 =?utf-7?B?OFpyeUg4cGYxZWR2TU1tS1JGUklkVmM5dVZyKy03bWcwWistM3gxV2VIY3ow?=
 =?utf-7?B?MHdlMG1rOVVjT1RRazU1Mk5WSEN3TXhwWFMxVDJSazRrU1E2czhUVkpxdXpn?=
 =?utf-7?B?WURFZDgxRk1SVm94QTBZbFNkUmRYV0FXNUV1UDhRSHh2ekFVSW5hWEpMS1ZB?=
 =?utf-7?B?S0xKd2pCbnBtL1ZtZkNMVld2Q3cxVVJRM2dKZSstMGpIUWFWQUJHOVI1Ky1L?=
 =?utf-7?B?anllanUxTUNLTmVqOG1QSUxFQjJuS1RPZEJXMDZSWk1WSlVKV09ESXBPN3E1?=
 =?utf-7?B?Z0oxSXBOdGZCZ0Zaa0hteFZueFlBYjNrYzJJZ1FkTlNuOU9VRWZyai9aSlRv?=
 =?utf-7?B?eFNPekFRVGdWRk1mNmFDWWVZWi9YRUE2Qy95MWJUWmdjZ2c5VjlvNUtGREs0?=
 =?utf-7?B?dWt3SU9iRzhteDkwdVRtQS8rLVExaElYTGNzQ1dpdDFJTkZkamNwOTYvdUs5?=
 =?utf-7?B?cE1sVy9XcXB3MktDb3QzSmZnMmc3T0FhRlNsdTBVUHlXaGpTZ0w1SGRqWjJr?=
 =?utf-7?B?d0g5RmNxb1RCNkhNTFFiZlBJeGF6Z2VtMmU1aVdRejAwQm50NXl6bm01RDk0?=
 =?utf-7?B?NXJ4SzhnR3NyQ2tOUzlhRkMvQ1BVanMyenhITWE4WTUrLWlNMkR4VlZlaHBu?=
 =?utf-7?B?TVVtRjQ3WTNHeWNxajdlRVJ6VTR0bjEzUWJUY2JrZXd1ejZ5TFp2SlhiZnhL?=
 =?utf-7?B?ZDk5NXRZdnhhQXhFN283UWpaUWJiRDNwSzBRRzJOdi9mcDZ4ZFFUbjVqTm5k?=
 =?utf-7?B?VDJHS0NBN0tlcUNpTlhWQkUvWEl2ZWVXb2psR2VXSEw4eHB5bVdPUW9DZkg3?=
 =?utf-7?B?bi83NnhpbVFNRi9PVUFtUS9MQ1JUZzlndm5oektWaWpXcE9Sb2pMMHpaUGVt?=
 =?utf-7?B?OW05Vkc3R1dRWkxwV1B5YkVMMmMzbW1hTmE5Y0h5RmpnU2NERHU0NEJUa2dy?=
 =?utf-7?B?ZTg3aGtFYWVrRistQ044OTErLXN4NkdvQ0NmblExQ0Z3NGlLRFJGQVkxcmlp?=
 =?utf-7?B?dk5WWXlyUTBXWnhCTjY5cUZKRzRUVjUvejdoZ2NCMWluSmpMeWdKNk4vN0Vm?=
 =?utf-7?B?SU00ZnZNSmN4dFMwRHh3elJTT1lYWVJDanRwWEVDRno5V2duOGR3RldMbzlT?=
 =?utf-7?B?Q1RoSWlpL0xsRDVkaXh0Tjl6bXBZQXIvVExOWW9STjBIbWNadUVFNkdDajU5?=
 =?utf-7?B?NnRxUE1qSmdRNGkyUUJ6Qm14M1BMaFc4SmlwamdOWDRNUGlKdDV3Nm8zOHc1?=
 =?utf-7?B?eC9zTmhGZUNPSExlOXpiQy8xZGpDcFFTVlBVZ0NocXlUTHNiNWh0NXVQa0dp?=
 =?utf-7?B?U1FQQXZpU0oxSHVBRWVKak9Zdkl5dFozQSstbmVBVXMrLUJEbVVJZ1JmMTVS?=
 =?utf-7?B?VEhWVEJDZUtwa0dpTGZOcTVFVGpTdlh6ZS9zajUwVGZtdTBFSDhiZ2pKV1Bh?=
 =?utf-7?B?MGVKeGszdzFsSHVITWNleVlYVU91Sy85UEJhT05wdlVJNG85Umxzc3JtY0ti?=
 =?utf-7?B?T1FqRHdUWmtDb2FRZystS1NzdG5UQWwrLVY1eGNZc0JwbXVhaTFaYVBMVklS?=
 =?utf-7?B?OTFld0VWek43ZUU4ZFdKQ3pUZm1tQVM3Q0MzNW0xOHdLZistM0JkQWJVb29H?=
 =?utf-7?B?dFAvNHBWTXp2UlF2TlduaElIclZCTkFsNGY4bzZaeFVpckZNQ3ZqOHkrLVJS?=
 =?utf-7?B?Q2tTQ3F5Y1lEelErQUQwQVBRLQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH4PR19MB8731.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(10070799003)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-7?B?ay8wdWNSQ09zY2JRdWU5anQrLXVHUkdDZUthQlN2NDk3WFdoNWRVVjNxYlBp?=
 =?utf-7?B?QTJIN2k4eXJ3ZE9NOW13Uktzbjk5TWd0clh5UGNpSFZmek9QZU5rUmh3U1lX?=
 =?utf-7?B?RTdGV1d0dDVQMkVPWDFHS0hzekhIZ1piMWFCUzZiKy0yZVJ4NUxlYkM3cEI=?=
 =?utf-7?B?WistRlN3R2xGeS9iNHFZSHExTU5BdnJySGhINXE0ZGs3MC9lUzFGazB4WWdh?=
 =?utf-7?B?UzJqTjlhNnFZSk5CRVE2UlN4dlhWRmQ3cEFsVkNyWEhRR0IrLUZpZTZGOFk0?=
 =?utf-7?B?TlkxT0ExMmZHQ2FMb2xTcXZWbUtCTlVTeGNSOWpGQTlibXBWYUpkaGZCdTRI?=
 =?utf-7?B?bm5DaWV4NUhhWkxzWWVoZVlNTjY5RmlhckRwTnFMUFJZV1k3bkFCbFcyMUx0?=
 =?utf-7?B?UjJETHVvR1VLUjVRMzJoa21iVlJ2bmdaamVCY0kwZDZ1RDUzVjJuT0Q0OEkz?=
 =?utf-7?B?dXQ1RVM5RUFSZEkyT0xlVEY3eGFjbnUxRXVnejFiaWoydGZrT3FKZXE1ajR2?=
 =?utf-7?B?N3QyazJzV2pWN0EyVWhqRUlIaUsvaCstdnhkcnVHL3JQQjNSVHFCcy9uRjdq?=
 =?utf-7?B?WkpaOFlJeVIweXYwcnpwOGNBT21RcWVZZFZhVUZCT2x5RC9hZTYxWnR3TlJu?=
 =?utf-7?B?TC9DUjVyZ3plcWxxajRtYjZNbDU5dy9lQVArLUdIUkgrLWdvb2xEd2lZMndJ?=
 =?utf-7?B?TEpQRnhKMTA4ZW1RN0kxUzFtcndSeDg0dXBFVWI0M2RXVDlvNmdUTUVJOGVM?=
 =?utf-7?B?NFJRMkdwbEZ2S3dYT1RLMzBFSWhqVXI4alZnZUdHaEYvNEN4VUdOOTNqdUtM?=
 =?utf-7?B?ODhuNEgzWistU3I2ZkplOW0zZC91U0pCVERFbDVIYTZ6bmpuU1BTMDVtTnBn?=
 =?utf-7?B?MDRPTWhkSXd1TjlhSUdYSENNV0tLVU1IZ05kdSstdXNpTExVOUJ3RzJaRmIw?=
 =?utf-7?B?V3dYaTRBT0xWSlVlNzNkMmUxaXZJMk5CR1Ywcnc1eDU3TVlXUk01cVorLUs1?=
 =?utf-7?B?Rzh5aEU3UHNGek9TMTIrLVBIelpBQjJnVnRMSXI2NlBGaDlVcEFFR2w0d0xv?=
 =?utf-7?B?WWp6R2JYOWlNbWZ2cGhUU01JckdvWmhZRzliRjdDV2dUNFFuSjRyNHBtOVdq?=
 =?utf-7?B?VHRPVTg5QmtWeDFMRzRwRTYwSnVlbU9sV2xqS3hlN3l3TWpDMkRPQlVRZGl5?=
 =?utf-7?B?QTcwam9qL3BybVc2bU5sd2lTVVFzQSstUGJYR2lSMHFVbjlrNTV6bkhIV0M0?=
 =?utf-7?B?ZURXblVCMU1iTzVIWHFPN1l5bXludFdLaystbnN5VDIvM3FzQ0VXSEQ4cDNX?=
 =?utf-7?B?LzFzYnZtTTd0TlBPMnZ5R21tKy05ejV0TnZlMGw4aUNKL2IyQzNqcEdydFNh?=
 =?utf-7?B?NjlHOFp3WTIzQWp2OVR0a0pEbHhNb0ZJL3JjbVYyQlREdm1yU3RpUUllWWhr?=
 =?utf-7?B?NE84UjJuMXV5TzdaVUx1eEk0YzB0bmVTMndZMm8vbWZlMnQ3T1pONmpQNHls?=
 =?utf-7?B?aUdVV2dMU0xlYUJPMW1QcHZXRHowcUxnV1FCNGQvTnIvVEdUYS9QTjNxT3ZB?=
 =?utf-7?B?VXZUOFNkZ1pnbHEya2ZmNE1SbHlhZU94WmhHaE5qeUU5RVcxMS9hOThneEVG?=
 =?utf-7?B?UDNHSXl2bHl6Ky1rMUVIZTdMKy14eU1LNjZjejhXOHJ0dGZLZTdPaDFzQWdy?=
 =?utf-7?B?Uk1EUlRydG1pbGdRTGFQVkxVdVYzU0ZzdkRaQWltOGpsdGFlOTkxTXE3TWho?=
 =?utf-7?B?dllhKy1jOE9wMFRtT0g2YVpFNTRFaEJ0bW1ncGx3R3lqSUxVbUUrLUtZSTND?=
 =?utf-7?B?UzY4RThSL3IwaHFWbUhDRHZKM3c4UjVYY0FRdmhCZERjOSstaE5TaURIb0NK?=
 =?utf-7?B?c2VweDd0Ky03QU96aDVjTGwrLWZVL0dGNFphcUpNVmgzWm1aa3BxN3ZRTlJo?=
 =?utf-7?B?OVRGUnVpWnVYKy1DY1hWZEcwU3ZkdHBKRHBhVEwxSS9kNnFPV0lHMnB6T3Qz?=
 =?utf-7?B?SHM2OHNDRVFIZE9sMGVZa3V4aE5xdFprTE1NNFhOMTZZNzdZcTYySUIwVnVi?=
 =?utf-7?B?TEVFWmd3MHhxSUtlTG0zQjRZKy13TTBRTnIzeVgyZktwOGdFdFNQR1BSWG01?=
 =?utf-7?B?WjgxWkdNNGl2WWJXbmJBKy1Fbmt1WXoyL01wcG40RXRxdXhCa3orLVVRcEFY?=
 =?utf-7?B?R1BMTU81ZG9UNlY2MHFVQ1NyUjZKWFUycjlpU2dRYzR6WVNQcE5wTDNFQ3pN?=
 =?utf-7?B?YmV0SkFvanFxWSstSCstb2dNT0NnMUdhOE54?=
Content-Type: text/plain; charset="utf-7"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Dell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH4PR19MB8731.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a3bb1d1-65e0-47b4-3169-08dce75203fc
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Oct 2024 04:31:01.9746
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 945c199a-83a2-4e80-9f8c-5a91be5752dd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HzhutUAETnadzPC7AVUgdAEJGHdqrx+hlaXAWCglmg87YD87El28GEudFwBvaOBvMJOcEMFNuYpE+h8mRAcQkA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR19MB3779
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-27_02,2024-09-26_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 mlxlogscore=999 lowpriorityscore=0 mlxscore=0 adultscore=0 spamscore=0
 impostorscore=0 bulkscore=0 phishscore=0 suspectscore=0 clxscore=1011
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410080027
X-Proofpoint-ORIG-GUID: Bi3lAI1kSY8Ue5zFxataNbFPhsGwsz0z
X-Proofpoint-GUID: Bi3lAI1kSY8Ue5zFxataNbFPhsGwsz0z
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 impostorscore=0
 priorityscore=1501 phishscore=0 spamscore=0 mlxlogscore=999 adultscore=0
 clxscore=1011 malwarescore=0 mlxscore=0 suspectscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2409260000
 definitions=main-2410080027

+AD4- +AFs-EXTERNAL EMAIL+AF0-


Internal Use - Confidential
On 9/23/2024 01:36, Crag Wang wrote:
+AD4- Use SMBIOS Type 1 manfacturer instead OEM strings to verify product
+AD4- compatibility. Also, add Alienware products to the support scope.

+AD4- Alienware systems don't use OEM string +ACI-Dell System+ACI-?  TIL.
If the system is Dell-developed, the string value is +IBw-Dell Inc.+IB0-. S=
ystem management software can identify a Dell system by checking for +IBw-D=
ell +IB0- as the first five characters of this string. Alienware systems sh=
ould show +IBw-Alienware+IB0-.
This is according to the Dell implementation of SMBIOS.

+AD4-
+AD4- Signed-off-by: Crag Wang +ADw-crag+AF8-wang+AEA-dell.com+AD4-
+AD4- ---
+AD4-   .../x86/dell/dell-wmi-sysman/sysman.c         +AHw- 19 +-+-+-+-+-+-=
+-+-+-+-+-+-+-+-+-+-+---
+AD4-   1 file changed, 17 insertions(+-), 2 deletions(-)
+AD4-
+AD4- diff --git a/drivers/platform/x86/dell/dell-wmi-sysman/sysman.c
+AD4- b/drivers/platform/x86/dell/dell-wmi-sysman/sysman.c
+AD4- index 9def7983d7d6..2f3f7e307b29 100644
+AD4- --- a/drivers/platform/x86/dell/dell-wmi-sysman/sysman.c
+AD4- +-+-+- b/drivers/platform/x86/dell/dell-wmi-sysman/sysman.c
+AD4- +AEAAQA- -516,12 +-516,27 +AEAAQA- static int init+AF8-bios+AF8-attri=
butes(int attr+AF8-type, const char +ACo-guid)
+AD4-       return retval+ADs-
+AD4-   +AH0-
+AD4-
+AD4- +-static const struct dmi+AF8-system+AF8-id sysman+AF8-dev+AF8-table+=
AFsAXQ- +AF8AXw-initconst +AD0- +AHs-
+AD4- +-     +AHs-
+AD4- +-             .ident +AD0- +ACI-Dell Inc.+ACI-,
+AD4- +-             .matches +AD0- +AHs-
+AD4- +-                     DMI+AF8-MATCH(DMI+AF8-SYS+AF8-VENDOR, +ACI-Del=
l Inc.+ACI-),
+AD4- +-             +AH0-,
+AD4- +-     +AH0-,
+AD4- +-     +AHs-
+AD4- +-             .ident +AD0- +ACI-Alienware+ACI-,
+AD4- +-             .matches +AD0- +AHs-
+AD4- +-                     DMI+AF8-MATCH(DMI+AF8-SYS+AF8-VENDOR, +ACI-Ali=
enware+ACI-),
+AD4- +-             +AH0-,
+AD4- +-     +AH0-,
+AD4- +-     +AHsAfQ-
+AD4- +-+AH0AOw-
+AD4- +-
+AD4-   static int +AF8AXw-init sysman+AF8-init(void)
+AD4-   +AHs-
+AD4-       int ret +AD0- 0+ADs-
+AD4-
+AD4- -     if (+ACE-dmi+AF8-find+AF8-device(DMI+AF8-DEV+AF8-TYPE+AF8-OEM+A=
F8-STRING, +ACI-Dell System+ACI-, NULL) +ACYAJg-
+AD4- -         +ACE-dmi+AF8-find+AF8-device(DMI+AF8-DEV+AF8-TYPE+AF8-OEM+A=
F8-STRING, +ACI-www.dell.com+ACI-, NULL)) +AHs-
+AD4- +-     if (+ACE-dmi+AF8-check+AF8-system(sysman+AF8-dev+AF8-table)) +=
AHs-

+AD4- Would it perhaps make sense to be an +ACYAJg- condition instead of re=
move the
+AD4- dmi+AF8-find+AF8-device() conditions?

Agreed on this.

+AD4- IE:

+AD4- if (+ACE-dmi+AF8-find+AF8-device() +ACYAJg- +ACE-dmi+AF8-find+AF8-dev=
ice() +ACYAJg- +ACE-dmi+AF8-check+AF8-system())

+AD4- Then you can continue to cover anything that has been rebranded too.

+AD4-               pr+AF8-err(+ACI-Unable to run on non-Dell system+AFw-n+=
ACI-)+ADs-
+AD4-               return -ENODEV+ADs-
+AD4-       +AH0-


