Return-Path: <linux-kernel+bounces-250380-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E6A5792F72B
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 10:44:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 74B9A1F23024
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 08:44:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C93314372E;
	Fri, 12 Jul 2024 08:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b="ZMdhj9XK"
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABC4113DDC2
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2024 08:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.148.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720773877; cv=fail; b=KJvcP2ImR6KajzWkTIUwU180+oZ28tyQOII2do3ptTdTmzf10J+dElY7Dytryg/Ke//ltTuphrjlVrRxcqGJ657shXiIaaCVBQBF78zbgfdF4pAqnvnBaQuzssoXGGx69sv5C/JD3h6NXoqFmL5OU+3so6SRrPU6VRKkuiH1SqM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720773877; c=relaxed/simple;
	bh=lli47K2Ro8YiC6CGXCIdoguuqS6EBbPymmGYethAPfQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=tiJ9RzddM5KZuPEAr02IqJZHVJINS2KXGgcWE/WKGAzDkzCT/a8FJyEvBM0LypcoG6WVJ5MVPb9DQ2B8QWLZvy0VbuWTESrBUR1bTc9sLhEC4OfJ80eppu1U+UixtRs6TnZab+DknJE8Ka2Fg5xiaW6VCMK3n69zr29AIqZQLuo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=ZMdhj9XK; arc=fail smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46BNuRPv000352;
	Fri, 12 Jul 2024 01:44:31 -0700
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2101.outbound.protection.outlook.com [104.47.58.101])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 40agvrkf3w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 12 Jul 2024 01:44:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l5KMw9HWTPVqPD5DdyOuX0LSxLHN5vjHyWb+z7NnCXbHTg+A12ZTJYCrPFStvHcbtEBhbxVqAnTiSSJsTXu0NwzJRqJZWbIdzNUgV7z7v6eCwKbfl9S2k2bdxt/exrAKbQvr6iwSNAuhmKHlBUuYlLDzZ17tzTtuEeMZYBm23v0cs54Yn7X0Q7mD2cQ2q7SfkQ6Dl4VHTw5vcM0kks1dqQ4EjI9pARCf+fMxMRV55f4kjz1TMlzii9Kmgk1Yo8dljH/HSdll6o/YEp4aE/MmNUL2ZPctb0eiMCD8V1VTv6mA4Z1RWkbfNy2+7A2IfqHaawtKdgqouhZH23kEpubAYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lli47K2Ro8YiC6CGXCIdoguuqS6EBbPymmGYethAPfQ=;
 b=PVxc8Ai52WA7jhEPIx5qbVqOcYa9sb+PKsDlSdsA22KwAMPWSoWmX3VCmSnxKXgYpqiaXSC1vvVUkUQDVMiFjVuVzm9HponpLQ+rMthf7z44jPJIQ5QwvxaASrPp+6VkuSkTG8Nft/FUxYM8W9VlOQP4W00X1EceBfhN+N93/PMPCsmem7GRQmE2rk1clJbEA2PLnS2hEnLJpywPkAc0+s0q1fYtlDiu7ZU8OQ4hkrA9Jv/tnuE+5Y4xdX0sO9HzQT/qCDYKYs7RIiwxUzzLXntR9yy5AOu2rUkd8Qdc5VVsP+2puIcXwfSDXUxG+e5vKdU1rLKDpMNeCHcFYmy6ng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lli47K2Ro8YiC6CGXCIdoguuqS6EBbPymmGYethAPfQ=;
 b=ZMdhj9XK9QTYU8NxM8TpYECtCZVTyORsVe3ElvsSfCYGL0gFTdCw2oDlLIeT47Omt4M2TmdGZbranPvzypHGhsQl/axzJCbKfbB8WH4s1KaNs714s9oT8I6EBBlKKY07LiZkHJvzvbr9SElzPRnW4Ic88unC5045AVvRWJnE9Po=
Received: from SJ0PR18MB5246.namprd18.prod.outlook.com (2603:10b6:a03:443::6)
 by SN4PR18MB5009.namprd18.prod.outlook.com (2603:10b6:806:219::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.23; Fri, 12 Jul
 2024 08:44:23 +0000
Received: from SJ0PR18MB5246.namprd18.prod.outlook.com
 ([fe80::5a7c:1cb2:fcc8:8966]) by SJ0PR18MB5246.namprd18.prod.outlook.com
 ([fe80::5a7c:1cb2:fcc8:8966%5]) with mapi id 15.20.7762.020; Fri, 12 Jul 2024
 08:44:22 +0000
From: Vamsi Krishna Attunuru <vattunuru@marvell.com>
To: Greg KH <gregkh@linuxfoundation.org>
CC: "arnd@arndb.de" <arnd@arndb.de>, Jerin Jacob <jerinj@marvell.com>,
        Srujana
 Challa <schalla@marvell.com>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [EXTERNAL] Re: [PATCH v10 1/1] misc: mrvl-cn10k-dpi: add Octeon
 CN10K DPI administrative driver
Thread-Topic: [EXTERNAL] Re: [PATCH v10 1/1] misc: mrvl-cn10k-dpi: add Octeon
 CN10K DPI administrative driver
Thread-Index: 
 AQHaz7lqd9hdRQGJJUKQ+mbdgUAE1bHv8iaAgAADgvCAAASeAIAAA6mggAAIyACAAseVMA==
Date: Fri, 12 Jul 2024 08:44:22 +0000
Message-ID: 
 <SJ0PR18MB52467C544972534F6DECDC48A6A62@SJ0PR18MB5246.namprd18.prod.outlook.com>
References: <2024070333-matchless-batch-57ec@gregkh>
 <20240706153009.3775333-1-vattunuru@marvell.com>
 <2024071026-squirt-trustful-5845@gregkh>
 <MW4PR18MB52442E363AE0BED30607F251A6A42@MW4PR18MB5244.namprd18.prod.outlook.com>
 <2024071053-mahogany-cavalier-6692@gregkh>
 <MW4PR18MB524491EEA2A628469595FE47A6A42@MW4PR18MB5244.namprd18.prod.outlook.com>
 <2024071012-backpedal-punctured-5d7b@gregkh>
In-Reply-To: <2024071012-backpedal-punctured-5d7b@gregkh>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR18MB5246:EE_|SN4PR18MB5009:EE_
x-ms-office365-filtering-correlation-id: 06e7a0fb-6de7-4012-2a81-08dca24ed3bf
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: 
 =?utf-8?B?SnZiQ2VERjk5L0RaUUhaeG9XRFc4Yk5LWG90UDRrZjYvQWo0SGlSSVQzeEM3?=
 =?utf-8?B?bHpBdmRtTDNhOXYxZnJRemYyeDlYRklmL1ZyaXVkRndSSEs4NHhPSVg1OFhQ?=
 =?utf-8?B?RVhpaXJjSVh6MG1ocXU0eVBUMG9RNDNIOXFObFlOcmNiNngzMjRFYXpldUtv?=
 =?utf-8?B?OWFsT1VZcEZGT0FieFpMVE9BSGpib3RTUG8vd0dLZW8yc29XcVF2b1BpUThy?=
 =?utf-8?B?eFBPRWtlekpBTVBKQU4zdE8xelpBeitsQktDNWVFUFFETDljRmJnZ3Jnb1Fo?=
 =?utf-8?B?bWh6Z1VUYTl2cXU1ZnRsN01rNjEra1dyTTBnNGZ0MTdJQ0o0dVdhWExHRkFu?=
 =?utf-8?B?UHBQNlRHRXpPa0RmRkJUdS9NdjJuMzhiblpGeUFiOGdLSTFRUmdIMFZreG1s?=
 =?utf-8?B?eTk4SEd0THFac3dJYTFOeGpLSFVGekhLdzVYa2hGK0FoQWpWRjFJMUdnQnNn?=
 =?utf-8?B?RFZNdS8yeW8rMUVkblZoYy8vR2ZtVHFYSC9SSUFQTC8wejFBWFZBV2IrVDlv?=
 =?utf-8?B?ZXZkZXBNVXd1bUNZSUtsZ05pRXZEZ0poL2c1Y2M1T04zSU1HVEwvcHRkT3hP?=
 =?utf-8?B?eFZNSnFxQnRkcWZldFl3eDR5c2lJS3NTUWFzQklGclk3a1hYeTZxMzNWYjZZ?=
 =?utf-8?B?Vnl5Q2RvZjRVdWN1VkQ4Y0tRMjJGZXU4cXlxbGo1bEozbFRnWUNldmNxN3dj?=
 =?utf-8?B?ZTFRU0hkdkUvNGlIekk5dGFXejNhYUtSMDlEVHJBZC9lVTg5a1R4Z3B3NkpW?=
 =?utf-8?B?L05hTXZTNEN6azNpd0tzZmxLenJpOElRYmJkTGlaRlJEeTJCSmt6dnNZWVly?=
 =?utf-8?B?Y0Vpb3R1RktNT1pncUM4WTI2UUlGRU1DV2JiZ2swRHJBWUljKzJoclEreUVD?=
 =?utf-8?B?N0RUamVMZkozaStuaFRXYTUwaDVtQXFibGMyVmwzYnF4QVQ3enRIaDFSQ3dx?=
 =?utf-8?B?emFFVjVWYWdpL045MTVBVm9reHA0NFZZYkVoYmtVc25tamY0YXd4V3RvRDJ6?=
 =?utf-8?B?S3RxZUdjY2U5bUdzNk5PY1hDWTdZSU1KQ2ZCT3p6TlYzSVZUY1ZwbGdIREc1?=
 =?utf-8?B?UGUvOFo4NmdsOVRZSXRXNmFwV2t6cWRYNzhLZXN2YnB5NWltczhmSGJGRlBV?=
 =?utf-8?B?S1VWdDBvUTFZS0hmaWVqUG81bzk0dVJwVUxsQjZ4bjQ2MVpPQk9scVNwYUZp?=
 =?utf-8?B?R0NZajQ4VWxjU0pLSGJCZkdMRjZ2d1ZZUDNINURCWmpNSVFkTzUwOTEyT2VR?=
 =?utf-8?B?TVZNUkFPSDZrREh0SzZLTmFVajVkR05QMThPWVB3emRSV1k3akxsSExrTmUv?=
 =?utf-8?B?ZDhReDZhbU9qSm13VUhrM1RtbXJXUUlWYytOVU1uZ1NnTWlJbThCc1ppWm9h?=
 =?utf-8?B?b3Era1REUUNHU3FyVXdlRFJLamZYeTlHNGxWcGhmdy9jUVpCQXUrcXV0ZGhj?=
 =?utf-8?B?azhUMnlCeUh5R1N6M3NORVc0VC9OTUtBaldURi8xZDVkVFlWK0h5ZUUyY3dR?=
 =?utf-8?B?SWsxWTR4cTl2QkZBWnFudnh6TjBFNHV1eCs5bVd1TlhkdjFpbjFxc0cwVXpY?=
 =?utf-8?B?Y0RpeEU2ZkpXRDBiVzJaWWJ4T09QdDZWMTkvdEllL0JnbW51YjJIYkxkVEJE?=
 =?utf-8?B?YVFtUU1Mb2VGSHdVT0I2Qzh2aWZsWktScUhlQW9oMU5jakdOaFlyYTg2QVZm?=
 =?utf-8?B?aHdXb3ZXZUxaazNJQmFCWCtBOUFwMjFldWhYS2RHMjdUQ2p3aFczcHBiVVBF?=
 =?utf-8?B?aWZ0TjdraG1mbVhuVUhLeENha2ZJNGwzc1JiYUpGS2Y3NmFMckdmVzBrZFBV?=
 =?utf-8?B?cVFwenhuYWE4U0ZQVi9sOE1FODVGTm9zTmVCOE9UTnRiQWYyd1BkMi9YZ3dp?=
 =?utf-8?B?T01QdjFKSi9oTHhsNHdDZkpUTkkyc3ZZSmxCeUxhVXN5UVE9PQ==?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR18MB5246.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?ZVlzQkVBNWVNaTRhd2pJRkhCczF5bCtGZ0ZyVDR2V2RCRndTRFcrMFlCUVFz?=
 =?utf-8?B?aWlyYlBZeSs2NWJIRlJ5bktSMDVjNXExTGU2Wk52R0FHYkpxSTBLMFVzUDJ2?=
 =?utf-8?B?ZnVSb0UvempEZ2F1Z0t4SFh0VG1jVEE0QkRpcHRuRGRIT1oyMXpxbVBwREFB?=
 =?utf-8?B?MnRESzBic3F2a1c4VGw5eVVHVVFzc2Jqd29CSGtvVEpjMWo4aDRrbGRrcnVI?=
 =?utf-8?B?UjdONHpKVE15M2VXNzFoV1V2cXdDQU5idk4xdGpiYW95VjB1T3NGS1JDUk9v?=
 =?utf-8?B?emR1MVhDWld4MUp1c0FaRFBpb1AzQ2htald3blhHSVNUVXliQXFzMkF4bEFs?=
 =?utf-8?B?cjZkSGg3Ti9QU1VUa2VPSmhQOXRLdlcwZlZoM0xyeXVrcWFHWXVqMXFRKzlR?=
 =?utf-8?B?RFdEdnFFZjBvcGxJaUFvR05wdTF4a3BHYkswNGJicGxNUlJ2d2k2cFR3N0do?=
 =?utf-8?B?S0d6RkoycXdLYk1rNW1ITTlqU29UZ283blVrK0c5cExqY3VqYmFQYi9BQ01R?=
 =?utf-8?B?VS9EamxFb0NGMG9ZaTNpOHdZWGYvaW5hbmRZUkFJeUdOTE1FblV4djZJQXlj?=
 =?utf-8?B?NTZWMGVEVXlzTERFWm5uYlUrQ0NNU0hleTBQYUhiNEw4cFFwUFBudDBCY3Zi?=
 =?utf-8?B?ZjVGNHJyVTV6K1M1NmF5eXFWSEdVdFVDbHZvVkdMa09sc3krR1d5NEo2UC9l?=
 =?utf-8?B?cWJLbWt2MW1lOFIrdi9mcDAxVG5lbHVuZE15T3A4ZVNPOXN3a2h1K3FNU2ZN?=
 =?utf-8?B?dklOZ0lFZkJOZ1gzSHhIZEs2Y0dWQjBNbHNURU84Mm9LQ2RKbDlwREthMVBp?=
 =?utf-8?B?ZWdjb094bDJJTWsrby9UMDRzeTQ4eTZndmhONjZCSEc1TFZCQjd0WEpwc3Bh?=
 =?utf-8?B?Z2pYSnBEOHZoaVFqTlZCenI4V3RWNGJoSTBYZkZBRkxyWFlMaENIb2ZmbGhG?=
 =?utf-8?B?bXNPWldXZERlMkhNWE9qc3FPaGxjWjhSSGEyaGF5NGhhbE1yVXpkZ1lvWVE3?=
 =?utf-8?B?UUFPdUkyVTAwUlJSbmNmVG5PQkovTkhGNWkyY2E1N2U0d2E0aWlxVjNLcFZu?=
 =?utf-8?B?eEljdU91Ujhsc2dKOGJ5cHoyQ2R6WUtRN241NnptellrdkdITms0cWpVZW4w?=
 =?utf-8?B?RGozaTZSY3JpdUVjbFhTNW15MmlUM2RrK1VlUDdpS0JTZW9UTVg3YjRkUWM2?=
 =?utf-8?B?d0hVVkVMc2IvU25pZjQ3MWkxcmxUUUVOU2hncDkzdEZKcmNnRmNyVnhMQWNy?=
 =?utf-8?B?YlgrbjdXWXlmT2hvRzJTdlVQa0t6OHNpK0haakxHaUMzdU92UmRyRThZR2ZU?=
 =?utf-8?B?Sm5VVDMzRUprRkV0d09RS2huSTZyTFlRVWx0amMrTjFZczhDREx6YTdWdnBV?=
 =?utf-8?B?QS9mYmlSNHNWdlRGcmJyWWJ4R3hQdUhkN0FVZDRBcHl5MnYvSDhBS1c5OUtE?=
 =?utf-8?B?QkJ5dkN0NkpMM2Q1bE1yT0UyUTdtelRaaHNsVEx2MmNTODkrNWNITGpJMGRV?=
 =?utf-8?B?MjhVVkp4Qm9rZk92dVg2QzNOQWxob0RydmprTVpuUWxtZ1Rhb3B2QmJjTmdI?=
 =?utf-8?B?QXFYSFI2cDJLaElQZ0lCajlTT3JNLzR5R2UrOGpMNzhkMkRPUTBoekgvQWJn?=
 =?utf-8?B?MVpFUTdCNTRXZTNJNVg1VHc4VEVlUGs0QmllZ2RoUlN6eWs2eG9XOXRGMHFx?=
 =?utf-8?B?VWFmeXFFT2VXazNXUFdUei9pZUFmaHB0WDlHQUVNWURNTDdnL204NmdYVVF5?=
 =?utf-8?B?ODZUR3JNR3pEUDluVHlyalIzQ2tQdnoyb0lRc3pRN1RNWDl3K3BLUzRFMkpB?=
 =?utf-8?B?ejBnY0d0VHNlVXIydlAwdXRKNjhzVGpKcDMraGpabFcvb3JJQWlHbVh0cnpP?=
 =?utf-8?B?eWZEWGZyRVQ4UDRiQ3B0V3hFTE43cGVHRzY1d2duT2cxOHJHWnExem9NaHh0?=
 =?utf-8?B?WHZKOHdaRjZnWGFEUzZUSjJCZ0Q1dHBqcVZPYkRlSUNhWnNVOEpNM3A1RjI4?=
 =?utf-8?B?bTVHdnowbEdWYk8vTno1a1FUK1RoRW1TY01kSjZ2TjdaMEJCaFU4TS8zN1NQ?=
 =?utf-8?B?elEyMUhWbVp6aTEyNzYvQVpqRm9FL3ZVaVo3TFlhQW40b0J5VUhOaTZIejNG?=
 =?utf-8?Q?fH5esHjGbL+C5A3M5jMfwvCXG?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR18MB5246.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 06e7a0fb-6de7-4012-2a81-08dca24ed3bf
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jul 2024 08:44:22.2900
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jGOgrvId8MOVwKiQDl9Lp3u6llh/+c9Du59PEJrwWAhCKWLnNUnsBYz/Z/pLr5mJtdRQoo5pjjGKdTYAVGe/wg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR18MB5009
X-Proofpoint-GUID: 1lNqB4hpWeogLWGXrC9lAzvHLndjZuIs
X-Proofpoint-ORIG-GUID: 1lNqB4hpWeogLWGXrC9lAzvHLndjZuIs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-12_06,2024-07-11_01,2024-05-17_01

DQo+PiA+PiA+Pg0KPj4gPj4gPj4gK2NvbmZpZyBNQVJWRUxMX0NOMTBLX0RQSQ0KPj4gPj4gPj4g
Kwl0cmlzdGF0ZSAiT2N0ZW9uIENOMTBLIERQSSBkcml2ZXIiDQo+PiA+PiA+PiArCWRlcGVuZHMg
b24gQVJNNjQgJiYgUENJDQo+PiA+PiA+DQo+PiA+PiA+V2h5IGRvZXMgQVJNNjQgbWF0dGVyIGhl
cmU/ICBJIGRvbid0IHNlZSBhbnkgZGVwZW5kZW5jeSByZXF1aXJlZA0KPm9mIGl0Lg0KPj4gPj4g
Pg0KPj4gPj4gVGhhbmtzLCBHcmVnLCBmb3IgeW91ciB0aW1lLiBUaGlzIERQSSBkZXZpY2UgaXMg
YW4gb24tY2hpcCBQQ0llDQo+PiA+PiBkZXZpY2UgYW5kIG9ubHkgcHJlc2VudCBvbiBNYXJ2ZWxs
J3MgQ04xMEsgcGxhdGZvcm1zKHdoaWNoIGFyZQ0KPj4gPj4gNjQtYml0IEFSTSBTb0MNCj4+ID5w
cm9jZXNzb3JzKSwgc28gYWRkZWQgdGhvc2UgZGVwZW5kZW5jeS4NCj4+ID4NCj4+ID5UaGVuIHBl
cmhhcHMga2VlcCB0aGUgQVJNNjQgYW5kIGFkZCBhIENPTVBJTEVfVEVTVCBvcHRpb24gYXMgd2Vs
bCBzbw0KPj4gPnRoYXQgd2UgY2FuIGJ1aWxkIHRoaXMgYXMgcGFydCBvZiBub3JtYWwgdGVzdGlu
Zz8NCj4+ID4NCj4+ID5TbyB0aGF0IHdvdWxkIGJlOg0KPj4gPglkZXBlbmRzIG9uIFBDSSAmJiAo
QVJNNjQgfHwgQ09NUElMRV9URVNUKSByaWdodD8NCj4+ID4NCj4+IFllcywgaXQgbWFrZXMgc2Vu
c2UgdG8gYWRkLiBDYW4gSSBzZW5kIHRoaXMgZml4IGFzIG5leHQgdmVyc2lvbiBub3cgc28NCj4+
IHRoYXQgaXQgd2lsbCBzaG93IHVwIGluIG5leHQgcmVsZWFzZSwgcGxlYXNlIHN1Z2dlc3QuDQo+
DQo+U2VuZCBpdCBhcyBhIGZvbGxvdy1vbiBwYXRjaCBvbiB0b3Agb2YgbXkgdHJlZSwgZG9pbmcg
d2hhdCBBcm5kIHN1Z2dlc3RlZC4NCg0KSGkgR3JlZywgSSBzdWJtaXR0ZWQgdGhlIGZvbGxvdy1v
biBwYXRjaCBvbiB0b3Agb2YgeW91ciBjaGFyLW1pc2MtdGVzdGluZy4NClBsZWFzZSBsZXQgbWUg
a25vdyBpZiB0aGVyZSBpcyBhbnkgYWRkaXRpb25hbCBhY3Rpb24gcmVxdWlyZWQgb24gbXkgcGFy
dC4NCg0KUmVnYXJkcw0KVmFtc2kNCj4NCj50aGFua3MsDQo+DQo+Z3JlZyBrLWgNCg==

