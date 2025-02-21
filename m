Return-Path: <linux-kernel+bounces-526710-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E1ACA40243
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 22:49:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 307CA19C1DE3
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 21:49:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05B0E2512D7;
	Fri, 21 Feb 2025 21:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="r1FgRa0h"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2085.outbound.protection.outlook.com [40.107.244.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A85A1482F2
	for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 21:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740174530; cv=fail; b=HZXf0UPbi9TlMyMHjrQF91PKSB013960Uf/j/S50ltvDzbGyh2MwTt4AEBPicM66ZnWdTbCwAoHrY3+UZWZ/M6czUwwhefs8UFFJowyLOuCVgf46ai0klzIiH+PMSnaFLcsfmZJtCfVqj22owN6/KteWq+QfJc0ddDNMY0c3JSw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740174530; c=relaxed/simple;
	bh=/R/vL8mHRGyascFcNYMS/6gcpPDE2xvaG8qmgvlyRI0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=nrJSWS4XRzoG9rKjJRYrAOTgdbyjWOIo6nr2amXvc4YGdWRCSBPyodr2o4ZJWDkGKLe6GDLlb7aOPO/LwO5wptJwvY7QtVN3/uSuUizJDyB7LuFYudPvLK+yK2/eRS5sFHtyXZXZm56cXMWlaiGd7bFsI9oLSp5sBz8HlgBcYM4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=r1FgRa0h; arc=fail smtp.client-ip=40.107.244.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RESAwJUajiFvOBwo+tGGpF4g+N1SBkwEM7DGZLuagyXzXa3SB6BXvCHOhgUQ/LdmnuqX8K6ehc4F4Se/ZEWLs27HsnH5gaUnaXgAx7vuEk4Yy5MNO5QBDVvT69SwSoGf95qBxsjUXGju8zyTN5mfrK8lH4mQRq7RVpLUXeHhMSWNmp1LIak2yPQ5HrVLWIa3dgFpNBuJN0aD5RsF9WPxNDf2Z56rlcr9Oq8ysx5rvZAitKao4UhxXqfxtrK7imUeTkeKIVdtUREhktLamFEm2etfRyGgohrdo/N+b4qJQ2fHb6IGSt0rM+dzs3rHQ9u1Lq720Uss8W/8whlm6l08jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/R/vL8mHRGyascFcNYMS/6gcpPDE2xvaG8qmgvlyRI0=;
 b=NHmsaIU10rz1254zTa8YOxmbaFmMeUC8eW3FFqOOI2zld2cwRJgSomGTNLaaBFlGAukma7C0ghuWy9lTKLUSG6lbMvklE1JRyAtYz1ptIyqAnW/Kin45Pcz9l++pd7sbFaC3yvHpS8Ry8jq1X3v8OsR8O2QIJjIMvkzASi0Njx2OklO72iCNL30DE3FdcalsCHc77i3gAQbCWID21EOMggnntB3/5stVN1P+3FfyDMambWkNeXlt2nx1EgwWLJiLEKmfeH+tJ0scKoP6DSbs+Zmp3skdzB/GGAf43mDWqaysdHSokUt0y1obotffVzXDyUKIH6bZV2ScLhodHuapmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/R/vL8mHRGyascFcNYMS/6gcpPDE2xvaG8qmgvlyRI0=;
 b=r1FgRa0h1PmJq79CB5VNPqU4yz6PQ4uGl5KTHXxnXZ8CKKrb/v0XoJJIrTIm0OfmJwLifbN7FeSmE7p2P0M1CebQxyiPUbIx8ypAbb2DS72y7ZTuem49RentuL84zIAjxswqO+ueP3+YQS27UAZqYwPvP/OlKw6LRq3r9FNLxV0=
Received: from LV3PR12MB9265.namprd12.prod.outlook.com (2603:10b6:408:215::14)
 by IA1PR12MB8237.namprd12.prod.outlook.com (2603:10b6:208:3f3::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.17; Fri, 21 Feb
 2025 21:48:45 +0000
Received: from LV3PR12MB9265.namprd12.prod.outlook.com
 ([fe80::cf78:fbc:4475:b427]) by LV3PR12MB9265.namprd12.prod.outlook.com
 ([fe80::cf78:fbc:4475:b427%4]) with mapi id 15.20.8466.015; Fri, 21 Feb 2025
 21:48:44 +0000
From: "Kaplan, David" <David.Kaplan@amd.com>
To: Borislav Petkov <bp@alien8.de>, Josh Poimboeuf <jpoimboe@kernel.org>
CC: Thomas Gleixner <tglx@linutronix.de>, Peter Zijlstra
	<peterz@infradead.org>, Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, Ingo
 Molnar <mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>,
	"x86@kernel.org" <x86@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v3 06/35] x86/bugs: Restructure mmio mitigation
Thread-Topic: [PATCH v3 06/35] x86/bugs: Restructure mmio mitigation
Thread-Index:
 AQHbfBOuckoYbW1FJkubQrZxxdetIrNChtuwgAA3joCAAS+HoIAAYkcAgAqtmICAA16TkA==
Date: Fri, 21 Feb 2025 21:48:44 +0000
Message-ID:
 <LV3PR12MB92652B0B616A192A117976B194C72@LV3PR12MB9265.namprd12.prod.outlook.com>
References: <20250108202515.385902-1-david.kaplan@amd.com>
 <20250108202515.385902-7-david.kaplan@amd.com>
 <20250210232951.x4mbmpjy57jpunb5@jpoimboe>
 <LV3PR12MB926503692B759DF39113626294FD2@LV3PR12MB9265.namprd12.prod.outlook.com>
 <20250211231839.bmcgj4vnvjyba74d@jpoimboe>
 <LV3PR12MB9265E88D27667AE6BAD9F7F394FC2@LV3PR12MB9265.namprd12.prod.outlook.com>
 <20250212231646.gyf4zbqlq7f6kqqf@jpoimboe>
 <20250219182041.GOZ7Yg-VlXLdgX7-3Z@fat_crate.local>
In-Reply-To: <20250219182041.GOZ7Yg-VlXLdgX7-3Z@fat_crate.local>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=33948e1c-b7a6-4e74-9651-5e9ac366cfc5;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-02-21T21:47:57Z;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9265:EE_|IA1PR12MB8237:EE_
x-ms-office365-filtering-correlation-id: b56e220f-5cc7-4a23-decf-08dd52c183c3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?amw0UEg3YzR5WnhwQmJMWFFPRXdDSklyellXVmE2d1lsdzJKc3JUS2hUbFMv?=
 =?utf-8?B?REpBU01rRmpOcHlFNFY5MjJTdFIvS1JZSVdIekYwZ1FDS09tVjFmY0h3N0wr?=
 =?utf-8?B?b2JRWUE0M2x5TnlaUHpHWGsvQVIweHJGNUJJc1ppRDR5TE1KRHd1VXlnb2x6?=
 =?utf-8?B?NWhST055UmJHVUFhRWpYVXpQYzFwNXNyUWZSdXA3b1hCMVVFTnFtVXRKNDdQ?=
 =?utf-8?B?WXBzdFd5dFdqSDBLZTJ2VndERUxXVFB3OWcvMkVrdEdNMUhWZ1V1YkVtSm5C?=
 =?utf-8?B?eVRPMVllMndhajJVT2NPcHRiUG1iZkNONnpXODdJUk5WWFoxVWR6T21WRmhH?=
 =?utf-8?B?cXNHc2s4NFV3NUVCaEVFRUdzbkZyaTdlOFliZ3BrN2FqWDFobjh0ajRoaldu?=
 =?utf-8?B?SHVITVRkV3ZLSDBiZjVRVEZTdVBTSDlFWlc5YWdRSGs4L2pKVk1nbERnd2lU?=
 =?utf-8?B?Tzc2S0VKeTQzOWppT081SE5Jb05DVjNJUGpLRUxtUzBTREpKL3JneHVGQkdH?=
 =?utf-8?B?aXVvbjJ4TUxxdXJxc3c5bjFPdEFlMm8xdGlvSzh4NXFrd1hNMkFQdXhiRVZB?=
 =?utf-8?B?TFVRTmpsTVRac2ZZZTBMY1R1VUhZeUswZjV0TXJpMzBnOTc2WTNwU2lrR3hQ?=
 =?utf-8?B?aXg4YVUxaExJU0hNVmRyWUZYZ0dBTjZBZGQzQ2ozOGhJcXg5eFYwS3V2Y1RH?=
 =?utf-8?B?dm16NUVZZW8ybkJXV0lTRk1rallrLy9xam1PZ0g0MWdKS2doSmh1d1dUMGpj?=
 =?utf-8?B?MzJpUi9KTEZwZUhoY3R6bjBIbVBockV4bFZSYit6Z05KZkc4RWlwSVVjbDlD?=
 =?utf-8?B?ZkpVNThCY1NTMjJCejg3V0FPRUtYS24zZHZjR1kxMmgxVm15RHlQdnhiMlE4?=
 =?utf-8?B?bU42bTVzT3BZT1B3OUVpL2o5ZkdZVzN2U1JSL21YK2Q0Z2tsSzl0VjJZOHZB?=
 =?utf-8?B?UGZOUUhQd0JodFA3N0szUmJheVdMVTd5ZGZYbENtTWhhOVJJcDJpeVl3WUp4?=
 =?utf-8?B?Q1Zab2QxSEY3L1ZCaGptR3ZPSUtyejNsZ2hlbDRUbDhUUHJkTHR3bkI5VU5k?=
 =?utf-8?B?R0cwOXhmdVA4TEh1K1ZUUTh6QlN2Q0MwQ3lkb1pVZk4rMDA1V0xnLzVSaU5M?=
 =?utf-8?B?MkpSQkg5dGlSa0lxK0JjZHFYbC9Vcm9RTWM4US95QjFHUFk5cmh5VzJvZFg5?=
 =?utf-8?B?Y0N6Wm9RbFpGR0kxNlI0U2R0aWpZL3pPNjlJWTcybmJCQk5QVU83OGpKbEpQ?=
 =?utf-8?B?eEJzWU1sRWJkcWhRVy8yZmhMOCsxOUloSXIyaDIwN1R0dHFFblNPWlpSRWE1?=
 =?utf-8?B?K1o0dEMvajBIdDJtSFFxUEQ0TWhTckR1REk4ZlgwYW42c3BwSnZscWh1NHd0?=
 =?utf-8?B?U0VGbW1wbkp0K0hobE1Hd0FFMkl4TkdWR1ZaYS85Skc3SUtQM1ViR3RVRVRs?=
 =?utf-8?B?Qm03MGtGU3BqYkJaM1I0UDlocXdLVVcrU2JwWXNhQnBWL2tlUjVkV1BKSklz?=
 =?utf-8?B?ZDRjbFNaSGEzc1BQcjlpVG9VRmM4bnFBeXdGY2d6UzVIVkFKQnkzVVRUcGVm?=
 =?utf-8?B?enFmY2dlMU5qdWtNK1Y0TjBGRGpLaEIrMXBEbTExVVR5QU1OVnB0cEE1N2Z6?=
 =?utf-8?B?bmpZa0VCY1FmdXA4TEFzdzYrci9zZW96b01UTXJtUWVmQnFlOFhLb2FOcmd2?=
 =?utf-8?B?V1V6MzJaQjlRK29vMDZjSnhUVjNvYlVNN2tBMWR4OUJVUGNQdTZKUkFCay9P?=
 =?utf-8?B?NzBiTndQUkZSWCtKVXR2MlA1WjcwQUhwcFB4UGRrcWFTLys3RWVLdVJuYWt5?=
 =?utf-8?B?SkUxUFFSb1BTUXpIM1JWNHBReGxjYmtDVUQ3R2NqWEpkU2J2bWFtUVBkUjV1?=
 =?utf-8?B?VnVITnJxQ3VlU0NHTmxSTGQra3VBSjcrQ3RqK1pHc1FySm1ZT3MwN3JwL3Vl?=
 =?utf-8?Q?2CjHEUaDOkaeelKmS9ZQ5AAIb5z0S01k?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9265.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?RkxqU0ZWY1Yrdm80ZUw0VXFDb3RjN0JxNVYrMVlvMk1EdVloZVN6Y3Nva0Fn?=
 =?utf-8?B?Skc1R3RQUUlYb3dCRUdldkd2dFFsSE9MYmlRVkQ1ZGpuZmw1Rng1UzZkcXla?=
 =?utf-8?B?dld1elJOaU5ZUVhwK2QxdVRCckpaQ0JKSEdRZnF3cHUrWlBUSU1sQkVKMEVS?=
 =?utf-8?B?ZGc0dVpUV2dpY1oxcTc0U0hoZlBURGJ1d0VZNlMvQXE1WGNGaFoxSlZQbGpw?=
 =?utf-8?B?QUJ2ajUxSDQ5QzZWVjJuUWQ4VEpXYXcreFlrWGc0Y2lVa1BRM1ZaZVovWE5y?=
 =?utf-8?B?czR3OXBCSVM2SlAzbmM3ZEliWlFUSk5USDAxdnBGUHhNQnRpeUJydVhMa3Rt?=
 =?utf-8?B?WEc0UElKOGlBNHZvR1dxcDVyQ0U2VmdIaTQrUDVacjlUK29XVm52NTNkMjIw?=
 =?utf-8?B?SlQ5K29xNE56SktUeERwT05GNEJFd25aNlFCNVdiMzZ4b3BySDFPOW5RZjNo?=
 =?utf-8?B?VWFxR0IyTVkyL2gwVFE5RXkwY3pCSFVpN00weU03VmlYcFYxZUd2azFhTVVt?=
 =?utf-8?B?TDVKSFNnOVN6ZTYwSDY5OWFxaVBVV3QrZXVwS3A0WlNZWjMyTm43VUFtSkxW?=
 =?utf-8?B?Uy9KQ0FCY1pPK2FOREVia1VhSGVIWWpwdjlYL1ljQzBRSlB3YzkrYjlvZjd6?=
 =?utf-8?B?V0Q2a2V6VkRYeXkyYXBLRm9CenNMZTJEK1F0YkRtT0t1V08vVENaQlU0WUV3?=
 =?utf-8?B?ei9BaElyRXVuNVZ5L09vNFNSR2RqQWZFL09qc1l4elIrNnhhWDBRcnF4Rm80?=
 =?utf-8?B?Sjh1cUM4U2tWM3ZPTG9xWk9tczlLYlRpOU5DdXhnL0lhQ2hUWUFBa2lKbFZM?=
 =?utf-8?B?MzB3MFdKNDdHREJGalQwU1NDcjEzZjNjV20yY1VXTkFTMGRKQXJiRXIvMnhB?=
 =?utf-8?B?Y29wY0NoeW9rMjBaY0lDSGkxeTF6bkhsa21oYkN5eSt0Yk40dzdBdDk5dVpU?=
 =?utf-8?B?Y3pwOUt2eGFVNkF3NnNDbjVtQlB2UkRJWXhFS21HNVBMWEdnMGRXWFM5U0FD?=
 =?utf-8?B?SW5DNnRwVmdYWENNdVhZZlNXK01ZK25ubVhCUUFWaEw3bnFVQzZnNS8zMkFJ?=
 =?utf-8?B?dEkrNEhkbTd4Z1FNWTJQb0VkWTNEdHR4QlVaRVF6aWR4SDlIelpzNS9sWEpz?=
 =?utf-8?B?U1gxNGtiK2E0cXA4MHlRZGY1Y2lMNll3MDlrbFlRd0NnemVkdHVSN0pUcEZJ?=
 =?utf-8?B?MHp1emJiWUZsdWxPdSttSXVyeUw0cVE0eXg5MzRwMlZPbURYQ3V5dHNiL1Bi?=
 =?utf-8?B?UC95eWxuSzd1YjA3cEdWN3RLenNrZ2svZlZBVnU1ckNpb3k4Qm51QWYwS0t6?=
 =?utf-8?B?SmNoZjd3UitkaXVSQUZ5UEVPR3MwUjg0cThURG03TEtQUFZEbmFub0JUM1JD?=
 =?utf-8?B?UmE2cldrSXU5YnBNb0VsZnlSTG5HZkR0akFDaC8yd281RW1jWm45aytHbW1i?=
 =?utf-8?B?VVB4N3IxQ0UvSzEvclJNeFEwdFBtcmJjeTZReGpoV3FoeEx0MlNYNXUwejJZ?=
 =?utf-8?B?TnVCWHBDUFhXTGkwdjdhMWVCM211Y1loa0FDaHdpcHUxNzhLVjJQZlA5ZjBG?=
 =?utf-8?B?VSsvUTZOMFplS2k2T0E1UzFLUzB2S2dzYm9BMnp3OTd2aEFnMC9aOVJRQ28r?=
 =?utf-8?B?TzhEdTJ3dFJXbGIySjk1TkhkZi94TW4yR0w1ZzY1dHJlb0t2bjd1bEh4ekIr?=
 =?utf-8?B?N0kvTzUydGlWOFFPNkRubXRoQTVWWDA5ekxTQXNhUnNCOGpIMnlqaVFlSjgr?=
 =?utf-8?B?dk5PRU94Q1FoV010ZFIwZkJYRnNDL2htbFgxenZDZEdsSDJXRmxJRFFHamFS?=
 =?utf-8?B?YlJneTZHQndudWxXSUY0SlR2TnZielc3bERoWkVQQUNxMEN2NWlKSGJnd0Jr?=
 =?utf-8?B?ZWRGSWJMOVViaHFhTFEwNThOeldob3Q5RGwySVJNd1AwcW55dUNiajZHYkhr?=
 =?utf-8?B?VVV2UTVyWFNxSnExamVKMWFtbjM5Sy9ucGJ4Z0k0MEdDQkRxUkg5dG9Gd1lp?=
 =?utf-8?B?T3FmbmxBVFpHZllyd0ZXNTh5SnJYTERkcGhQNzFxaXo4cU5ZejlXWTFQd1Yv?=
 =?utf-8?B?V3pubzIxNEhBRCtHa2hjZEd3Q2t0d1BEUVR6SGhXZTZlM05IbjlSaHE4cm9X?=
 =?utf-8?Q?L3g8=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9265.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b56e220f-5cc7-4a23-decf-08dd52c183c3
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Feb 2025 21:48:44.8760
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QLlG4ifLORV7xQDQrbA8LCDv+kcPTOx/rwsGGcqkuoTDhZJitGSUtpjm7uL+X5Si
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8237

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEFNRCBJbnRlcm5hbCBEaXN0cmlidXRpb24gT25seV0N
Cg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBCb3Jpc2xhdiBQZXRrb3Yg
PGJwQGFsaWVuOC5kZT4NCj4gU2VudDogV2VkbmVzZGF5LCBGZWJydWFyeSAxOSwgMjAyNSAxMjoy
MSBQTQ0KPiBUbzogSm9zaCBQb2ltYm9ldWYgPGpwb2ltYm9lQGtlcm5lbC5vcmc+DQo+IENjOiBL
YXBsYW4sIERhdmlkIDxEYXZpZC5LYXBsYW5AYW1kLmNvbT47IFRob21hcyBHbGVpeG5lcg0KPiA8
dGdseEBsaW51dHJvbml4LmRlPjsgUGV0ZXIgWmlqbHN0cmEgPHBldGVyekBpbmZyYWRlYWQub3Jn
PjsgUGF3YW4gR3VwdGENCj4gPHBhd2FuLmt1bWFyLmd1cHRhQGxpbnV4LmludGVsLmNvbT47IElu
Z28gTW9sbmFyIDxtaW5nb0ByZWRoYXQuY29tPjsgRGF2ZQ0KPiBIYW5zZW4gPGRhdmUuaGFuc2Vu
QGxpbnV4LmludGVsLmNvbT47IHg4NkBrZXJuZWwub3JnOyBIIC4gUGV0ZXIgQW52aW4NCj4gPGhw
YUB6eXRvci5jb20+OyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnDQo+IFN1YmplY3Q6IFJl
OiBbUEFUQ0ggdjMgMDYvMzVdIHg4Ni9idWdzOiBSZXN0cnVjdHVyZSBtbWlvIG1pdGlnYXRpb24N
Cj4NCj4gQ2F1dGlvbjogVGhpcyBtZXNzYWdlIG9yaWdpbmF0ZWQgZnJvbSBhbiBFeHRlcm5hbCBT
b3VyY2UuIFVzZSBwcm9wZXIgY2F1dGlvbg0KPiB3aGVuIG9wZW5pbmcgYXR0YWNobWVudHMsIGNs
aWNraW5nIGxpbmtzLCBvciByZXNwb25kaW5nLg0KPg0KPg0KPiBPbiBXZWQsIEZlYiAxMiwgMjAy
NSBhdCAwMzoxNjo0NlBNIC0wODAwLCBKb3NoIFBvaW1ib2V1ZiB3cm90ZToNCj4gPiBzdGF0aWMg
Ym9vbCBfX2luaXQgdmVyd19taXRpZ2F0aW9uX2VuYWJsZWQodm9pZCkgew0KPiA+ICAgICAgIHJl
dHVybiBtZHNfbWl0aWdhdGlvbiAhPSBNRFNfTUlUSUdBVElPTl9PRkYgfHwNCj4gPiAgICAgICAg
ICAgICAgICh0YWFfbWl0aWdhdGlvbiAhPSBUQUFfTUlUSUdBVElPTl9PRkYgJiYgdGFhX3Z1bG5l
cmFibGUoKSkgfHwNCj4gPiAgICAgICAgICAgICAgIChtbWlvX21pdGlnYXRpb24gIT0gTU1JT19N
SVRJR0FUSU9OX09GRiAmJiBtbWlvX25lZWRzX3ZlcncoKSk7DQo+ID4gICAgICAgICAgICAgICAo
cmZkc19taXRpZ2F0aW9uICE9IFJGRFNfTUlUSUdBVElPTl9PRkYgJiYNCj4gPiAhcmZkc19uZWVk
c191Y29kZSgpKTsgfQ0KPg0KPiBJbnN0ZWFkIG9mIHR1cm5pbmcgaXQgaW50byBhIGhlYWQtc2Ny
YXRjaGluZyBtYWRuZXNzLCBpdCBtaWdodCBiZSBhIGxvdCBlYXNpZXIgaWYgYWxsIHRoZQ0KPiBw
bGFjZXMgd2hpY2ggZW5hYmxlIFZFUlcgbWl0aWdhdGlvbiwgd291bGQgZG8NCj4NCj4gICAgICAg
ICB2ZXJ3X21pdGlnYXRpb25fZW5hYmxlZCA9IHRydWU7DQo+DQo+IGFuZCB0aGVuIHRoZSBjb2Rl
IGNhbiBzaW1wbHkgY2hlY2sgdGhhdCBzdGF0aWMgdmFyLi4uDQo+DQoNClllYWgsIGp1c3QgaW1w
bGVtZW50ZWQgdGhpcyBhbmQgaXQgZG9lcyBrZWVwIGl0IHByZXR0eSBjbGVhbi4NCg0KVGhhbmtz
ISAtLURhdmlkIEthcGxhbg0K

