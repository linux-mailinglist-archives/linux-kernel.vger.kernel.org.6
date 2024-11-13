Return-Path: <linux-kernel+bounces-408071-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 876299C7A17
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 18:41:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E6F1028505C
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 17:41:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49637201113;
	Wed, 13 Nov 2024 17:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="RJ9SIIuM";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="IockKrjJ"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EE0D200C8B
	for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 17:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731519673; cv=fail; b=l9Bpu2Vrn1y9ncLVrT/Yx16DiFAChWImEiciezxqSwfg0JY8+qpQkAjpGumqGeoHWKWOxNa6Z2jvPm53a0WymHJxLidSvPXT3bHwYdP7EDHxq+eR4qeoTPWI2iED1JK5Ap6+dgvuYySyf0FUEYJkZPZ3rm2WPB0hsDgVf/kBczQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731519673; c=relaxed/simple;
	bh=RP+BbPmUisM3xHNOwoyiW0F5bGy5RcY3DZu7MObfTN8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Mdt2aeJq4r+PXI+tYRNjl7JbRDl/T1f9ZdzwSke3tvGoRyAjgo42Afx+5Lo4FshMRuQrbyifOyIMcEK67v5RNlCda7/UhiaFle1VzuuuViFmWrL1VprjAtLv6QgaaSRA3naHGFX4ri4F30ZyFAH7EfUs2URAb1pQyV8Id1RGSFM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=RJ9SIIuM; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=IockKrjJ; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4ADGVjJH008276;
	Wed, 13 Nov 2024 17:41:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=RP+BbPmUisM3xHNOwoyiW0F5bGy5RcY3DZu7MObfTN8=; b=
	RJ9SIIuMqz94jXWop5RLEf9G963x5QadGzGxHeWfxpDAg5wcd//BrGAKloaH3E6b
	n1CwhhYDBpwRiCNCu3K5vN+k7gJMhwymMDzhbtj79ZyyWXn5N+Nt12ja69fT0H4S
	9p8VaB7L/W5+hiq4qh85JJuBTigoWPuIVDf8t3mM/9YGzGHthfJiTbq1qCKfGKO9
	Zyero/I0A0iQGXoHE/M58WheQQTtQDBRjIjq+kWiEw01Qa3pIfVDGGfTfcfqG3tN
	0KY+kwrRYRzf3PNrd1HYGHU0tJobBOMq2CFYY7c+pU4xXIhVWLurI/oUAWCUovvc
	kxpXiMejxSAaTQgUyYUqsQ==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42t0kbyha7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 13 Nov 2024 17:41:01 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4ADH6HSI005723;
	Wed, 13 Nov 2024 17:41:00 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2045.outbound.protection.outlook.com [104.47.55.45])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 42sx69y1a3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 13 Nov 2024 17:41:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O+CIuKOmdtIIYmTa6sam/jtZCdtbIhOAfHaH2FAGWMxQGustCG+ZFRjeCb7EdK+d0F+lgSjSnnh66lKYTO7H4Xw6u9soYMLBdznsZbGJSsajDFKUBLP9Wx3bYdD7qZVGnRPFMGNZnr08vhK0f/dfMKQ7T+QGXYFpfok/sIToAXN8wBaMnvlM+ctW5dgaVn7X1kppYGlQTPWLO6nTQWFiPJl6QMTOVpVM1cv/wEyO3miHmS78WPoXGCz9dq+P0l4KkTuNAIz3MyEiA1aNWNP6rumZeqVrNU3pNDQ1Hlo1mlYfPZibrppVIRoeUjsa2iUmsyTJRxaeG1Xp1n4luWaElA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RP+BbPmUisM3xHNOwoyiW0F5bGy5RcY3DZu7MObfTN8=;
 b=uah2nePhdEotAdSoEiVsTIH93KlF4EK+hle47T4nDl3+mI9284Ecw8ULiG+tUBtTWDyjVfDk1jHraEhJW0cLxhePYdXtM8hpxM/ZNtlq03WLFPcwdfFp5xqtsSEWpPOwciaw8mh3rYERPdIGaoTZl18RFUngdjsU3VGVGdC9IHqIdoH2Ox9ezqb3idiqsL7ePmdaQm9Sav9bp44LWUrYc2bfFxjUZZ7JpyAz+kWv08bM68+7PWxXOH/Gdrh8MtKoh+dxNwdRcf2hjaK/b5KZOlLqyxCGjv/nF6qKrOLnGsNj30ROahmYPa9LxDWI1FCKPONWb6KDEUx1xeOZ6gVJtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RP+BbPmUisM3xHNOwoyiW0F5bGy5RcY3DZu7MObfTN8=;
 b=IockKrjJYvzd5ZNkfBMgn+40apcnHIoCcPurNy1sVz/X+8tIgKnKJCRR5yHErd8GpkgIc3Qg+q6/E06wjA7skjWwRwM/+olOr7sSl+gN28y4BKD7c2EyWz6rKDNGicCQ1JgQ7iiFh4WOVjTt/fDm2/piSHnnPgSDmU0PVQlzRIA=
Received: from IA1PR10MB7309.namprd10.prod.outlook.com (2603:10b6:208:3fe::13)
 by MN2PR10MB4158.namprd10.prod.outlook.com (2603:10b6:208:198::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.18; Wed, 13 Nov
 2024 17:40:54 +0000
Received: from IA1PR10MB7309.namprd10.prod.outlook.com
 ([fe80::818c:4ed2:2a1a:757a]) by IA1PR10MB7309.namprd10.prod.outlook.com
 ([fe80::818c:4ed2:2a1a:757a%2]) with mapi id 15.20.8158.013; Wed, 13 Nov 2024
 17:40:54 +0000
From: Prakash Sangappa <prakash.sangappa@oracle.com>
To: K Prateek Nayak <kprateek.nayak@amd.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "peterz@infradead.org"
	<peterz@infradead.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        Daniel
 Jordan <daniel.m.jordan@oracle.com>
Subject: Re: [RFC PATCH 2/4] Scheduler time extention
Thread-Topic: [RFC PATCH 2/4] Scheduler time extention
Thread-Index: AQHbNV88IKELOfHwxE+G0dEmo3giTbK0layAgADl6IA=
Date: Wed, 13 Nov 2024 17:40:54 +0000
Message-ID: <92F18B23-0B35-486F-BF69-17A73FFB10FD@oracle.com>
References: <20241113000126.967713-1-prakash.sangappa@oracle.com>
 <20241113000126.967713-3-prakash.sangappa@oracle.com>
 <2d059175-cfc0-fee2-5bc1-fb750aa5acf9@amd.com>
In-Reply-To: <2d059175-cfc0-fee2-5bc1-fb750aa5acf9@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Apple Mail (2.3776.700.51.11.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR10MB7309:EE_|MN2PR10MB4158:EE_
x-ms-office365-filtering-correlation-id: c50a358e-db29-4aa3-e682-08dd040a5323
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?bm0yTGc5UWlPUjdVazVlMnB6LzZKbWV1Z3VvZFRBVC9sanRvd01sTHQzbVB6?=
 =?utf-8?B?UUpGTlNEMGhJSlZuc3dvZnNiMDA3RWdmWVgvOWI1MkZpSEVXTmowQXhEUE1B?=
 =?utf-8?B?VHRFVHZFbW40dnAxQW9zOVNnMHM0UmlzdWloNlRha1psZVlEcUpvTXMyTFpj?=
 =?utf-8?B?bTg1NGYwK0cvRjY3d1hpSXMvcHYwbisxUmNTZENTZ3BDd0cwSFJlRjFoNm5J?=
 =?utf-8?B?d2o1VVd5eGNSdjNZZ3pLS3VlMDhkLzk4TWcxNkNVNDZtem1heXNWRS81b2NE?=
 =?utf-8?B?eENFMkxKMVZ0ZG55TmlmYURwbEcyakgvSElLUTVuNytnM3dUaDNWcGxBZUll?=
 =?utf-8?B?VzIyNHFubjEwTnFQdUtCTCswbzdsNzNDYUFiSjVaSWtldHlCOGFxa1BsakJa?=
 =?utf-8?B?VFE3bFpMY2dHQ0M4bTY1VjYzV3lETHpEcUZLU2l3dno1a2Fyd281L3FyV1FK?=
 =?utf-8?B?OTlaTkpwNGNMUFgwTkJVUms4RjlydEpvR2FrTDRQMGhEK2xtUFdTVmM4elV2?=
 =?utf-8?B?WXgyUE56eVBvaTZSSTQzMHQ4RW5ybWMvQnNjYlRMeDQ4WjNtcklsMzByR0N0?=
 =?utf-8?B?ZXRveHpBRUFvRlRtMzhXRVJ1VVg3VEs3K295SXhYbFNZRDBVcUtUNFlVbkFC?=
 =?utf-8?B?OW5vTHR5RnphRHVENllONTNhdllsczlwM2JZMy90d1QwQkhVMHVWZTl3MUFP?=
 =?utf-8?B?YkMrRDhiaGhZTVN3czU5MFlBNkQyWmxwNkVJaGZEVTUxcUdhWk53cGhlSDdn?=
 =?utf-8?B?TEdualRyRnhoWUNiYmdJWHhyQnZPUjE0T2s2QU9TUWdzY2wwS0ttbWtWMkVQ?=
 =?utf-8?B?bHdOL1UxbG0xMFVvUTYvcGw4dXVPOVZOU3dQYWNiY0tXVGNoUkx6RkN0YUg2?=
 =?utf-8?B?TDBsalFOVVhNR1ZHam93K2JtMlVkWVVGS01tUG9VT1dURTJ3N3o5T1hSNXl0?=
 =?utf-8?B?QVl5Rm5YdkRFTHVNcnJRWTY1SHUrcW43UmUyYjEzOWZTaGR1ajRWY1h1UE9K?=
 =?utf-8?B?WWhlU3VqSzM5R0RWbW9sZVdTUjB5ejdZMDVBQ0JxVlhPYzNLUWJJd1g4c3Bz?=
 =?utf-8?B?MGd6amNtU09PZE85UlJ3TFljYWpqbzdlMWJIUDZ4cy8rZjZnazQvbFlmaitp?=
 =?utf-8?B?cVp2NVNselRhOHhLNnBLdkF0S05ZSGFsMktBTSt5aGlES0ZnOEg3TEpQMFBG?=
 =?utf-8?B?R3BuVUxYbWN0RVZVRUlxWDVDandwOTNmYlFyaW9SYkJ1WFdHL08zWGt3TzQz?=
 =?utf-8?B?cTlOQzJkeHBER295RmlVeDkvQjNLN1FjYzJEbGRkQm5yTkI3R1NMUXpUUFlG?=
 =?utf-8?B?WGxHdHZ1K2NzUklqVjZYbm9xa2I1alNRb21ibG9va0FWeFgyd3J6N3RsNGdu?=
 =?utf-8?B?Q0cxZmJFSTFQNUZmRkljVjJlYjFDbi9pZTFoRm5Da3dWOGp4UjVtbXExQkg0?=
 =?utf-8?B?TG1IMjA2dHcvaTZJMzdDZnYxbE8rSEpEdHRTQ2dEdnpPeURNdFZ3ak5CeEhm?=
 =?utf-8?B?Zkp0MU4yQ0FFbk1YUkNVZVNRSDEzQWp0UkorcDY1UGRHdE9WdnVYZ1RVdlNH?=
 =?utf-8?B?eG92WWFtZGlaSFFtS1pPNUprVC9pUHp0aWlvQ2NYWUpUOXZmSVZ4MEJLY0ky?=
 =?utf-8?Q?SN/A69pBOUIKkLhcG1MU8MED7Y/OoaCO1tbb3d2gavKw=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR10MB7309.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?anlsaitYM1RyUVQxTDZpRkhWMFVRZXllS1JPbE5jelRkOVFDVEc3ZE1vL2Jp?=
 =?utf-8?B?aWwzVmpIVERmQlpCSXk2eC90ZFl1SzdwY1ZCcy9uQjRTQ3k0YjN4MzNIQlpr?=
 =?utf-8?B?WXdUZ3pCNFFBZWplNTNqYnJvVGptTDY3V3RzQ1ZFRmJOTU83SzgrNlRCejJQ?=
 =?utf-8?B?SkJJMWQ4ZGdCZE05bnZjbWQwSXZDV2d4ZW9SOVRmUHdadEhXdi9wS2VnaXVL?=
 =?utf-8?B?L1VoN091WDhxNkhLVUc5Z1NUSWV0WmdDL3dTZGdqS25qTG1GRDA5Mk15MzZo?=
 =?utf-8?B?NkJFTWdkTzc2dXhsZ3YvMlhxV1p5blhhVm9YQTRsOVpUTXVSOEhBeFhOdEtp?=
 =?utf-8?B?aGFORmVIUi9qZXpuYmJuZmIzTFZCODlla1Q0N2EyRVJnd1dpdUZXYjZGdXZp?=
 =?utf-8?B?Mk04WUxnbGJHMEdNVFJaTy9KVHprbWdVYkJMeGdxVGR0ekpaam5FelJ5OWFR?=
 =?utf-8?B?VG9vTnlTOTJja1NCSmorRVBpbkxTU1pMZmlUMnFGcUxHU2JTRWtlZCtITEFo?=
 =?utf-8?B?cWxnSHd2blUvWUoyR0FTZWNub24vbkFTVEQ0UUpIUWlwMFh4WEhxTllON1Ev?=
 =?utf-8?B?SE9NRmgydTlMVjZ0eEhhNWd1U2V0R0FSTTZseHBlYlk0QzNLR29ZLzNsdHg4?=
 =?utf-8?B?NXEydjRoYlMva3k4bXlWdUp6K0tsck44U0tPTExOVzQ0Y0VZM2E4bnVHVFo5?=
 =?utf-8?B?VmtvMlBlM3RBRTZjd3hXeDZXT2JROS9FZWs3TzZmZVpHOGFOUUx6QUp0Kyt0?=
 =?utf-8?B?azFFMnlIampvZ1VHUjM5Wjh5VDJhYmJhY0czcUZxeUFrQU52b3pCSDdMNWg0?=
 =?utf-8?B?VkwxMlVxMXR0eXMwMFpQMTFXdzdWeFNhSkpTUnlCWG4wWGlib1hURnowRzBR?=
 =?utf-8?B?ZUhCMC9USVViQzd6UjNFSVN6Z1BuYmdaVHpTNmlLeUhCZWQ5bGJmZjVMYkxn?=
 =?utf-8?B?UjN0RkdRaVZ6SnpaNGFsNzVjNGx5dldCbVM0Uyt4bUUzQnhKTFN1K0paay9S?=
 =?utf-8?B?WlhmZVJaUFV2NUhOQjFMdEszRmNtNkRaekZ6VXc3M3lwVTJ3OW4weFNra0da?=
 =?utf-8?B?QXo3bDZUTDJEQmpOTXJlaEgyRDk4RDR0NW9vQVlzNzFpV3dJTHFUd0xZTitl?=
 =?utf-8?B?bUN2MFVvSVdRaE84T3Mzdm04RkFRS1h4bkthRHFGM3lONkNmTDRhbmQzcktt?=
 =?utf-8?B?eEtLRmkxVldlY28rd3ZsWExLY1p1ZnhBc1JzbGxXakovRmJwLzMrQU94NXZi?=
 =?utf-8?B?VkVCdGVaUHg0VUZaTE9ML1ZrWnJFY09SU3h6Z0FBelYyRWljcFhlQkgvNjhI?=
 =?utf-8?B?dUpOd2NnNitoT0tsYWY5cUUxL0ZLSDNqOE1hRTZiUm9wUHpvWUgyWHdmU2JR?=
 =?utf-8?B?dlNaU1JRY2hQbDNpQVVHaXo5RTFiQzBQS0wzQ3VuelVMUjNPMXZ5WlpqblhC?=
 =?utf-8?B?N1NlNjZtVG1Gd1h0d0d5RE81RE8zdFhKcjJyRW9YYnArYWh1Y01iMDh4M1hz?=
 =?utf-8?B?NEdjejVRZmtMVjZ1UlAvMzNTOGNkbjVER3paTlhkOVBpYXQzVmpNMStGK2Na?=
 =?utf-8?B?WWdLWDdVOGhqTmhxbUI1ZytVTTVtelNaM2NUUzlqRm80QStrWk1sZzRFcTFP?=
 =?utf-8?B?SjdEWFdrWDZ5Yy9USWtaZWRIRGUrVGxHKzZSbHBpclU3aHp1Wmt6ZWxvNFNr?=
 =?utf-8?B?Q1M5dmxDU1JqZHlVaXFnMTl2ajBRMGkrbDlyNGFZUCtkK3FQZ2wvSHVCQmxx?=
 =?utf-8?B?YW5Oa012MDBCSENnQWRtemQrZ29ReXhmb2FmNVRZTi83L0JzdEswaGNXblQ5?=
 =?utf-8?B?dGMwVGRiY1pwL1JDSUdkdE9nRFN4THQydTl0SG9yS2VyalZsMVU0SnoyTlFp?=
 =?utf-8?B?SFdzSUVFMy9GSTVnWWNuRHhuTTYyVk4xZlpUSjJ3TW9TQmpDcnAvMHJ6dHVw?=
 =?utf-8?B?cWtiUlcwMTI0WEFKWHlsY0ZOeVJwVlBOTmJlTy9MeGJzcUxaZ3A1cE40eXFN?=
 =?utf-8?B?TS8zQ1Z5RXVuaktGQU5IWlc5cElocFRTUnZyMHo5Q3FEdGhWbS85Nnd4QWJp?=
 =?utf-8?B?QkRkbXN0cXlhTHU1dGdrNElSOTE3WXM1VE9yQlZCTFVZQ3BoNG05S1psOXV0?=
 =?utf-8?B?b01nUEVER1FZT3VsekJOQ2JFZ0Yzd0R5T0d4dUpmMXZmdmhlbWVFUExxWnhZ?=
 =?utf-8?B?ZkE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <83D2D36C245A76448C177DACE12E916D@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	8tgRPanUeMRROd49kehCuUJ/Zc9lPnku/0QczHhsP6QP6yKT7M5n6ThYiMQwDunVRj5Wt8rwg6+roERx//m3w3OHNn6O0SLWGWeb/ROMVl8wK7g82CQBbVyXPkpFO3qTRLlIU/Sz2acnuOGMlT+OhFL5NfS4hHjxTg4gUSuYN0k5uJ/scYVO3bdqVsOiPfqZENuI/ugNME0XOeI3/qpSkJ6fmcafRVnIkAYjaT+l2Qu9MBxddqbCsoBT2hoPgUi6L/HKXkM6QNliv7KYj2WxaZq+alXssr4p78BDwTAZ8w9tthh+GSCSS18oHksLeZKeQFOoHCj2ya2ooNTtAZ4DXrcxk/qYBW9tW2AUAN99Bkez6Wp3/m2QssdY6NKfBuasOGRic9qwvXLjvqwW/p6eDrLW3T7EuoZayu3tDTBTlp+ERlxH4R6ck4n6ZEbj813Dc2EkmQfa6kKTouTZFAG072fcQVrkqwNaQmoQshhV5GFiC212o/TjvWcOw3zIxEXEMdOC0MHpm+FszV1m5G8KPLR3I9eJvMxaLLRquGdMwa/jaDxX1w0lnv1lYCxqGwX86OfdDYWxXv4tbJkJBxw81nt7wLGYx3RrkIXLxca1+Qs=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7309.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c50a358e-db29-4aa3-e682-08dd040a5323
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Nov 2024 17:40:54.6979
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TM6y6uPOsMkGsIBxANIOS1N6Gm2Xi2RGfRrRFmJpotQLmcDItwwJo0Rzn0WEjRNl+DaOVSbmOYiPMmFLXkcZe8xFx+P6DEULTmZ4T+uvsD4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4158
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-13_10,2024-11-13_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 spamscore=0 adultscore=0 mlxlogscore=999 mlxscore=0 bulkscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2411130147
X-Proofpoint-GUID: VJECXMZj0W8sFxNxJHFzsRTJ42VOZoFX
X-Proofpoint-ORIG-GUID: VJECXMZj0W8sFxNxJHFzsRTJ42VOZoFX

DQoNCj4gT24gTm92IDEyLCAyMDI0LCBhdCA3OjU34oCvUE0sIEsgUHJhdGVlayBOYXlhayA8a3By
YXRlZWsubmF5YWtAYW1kLmNvbT4gd3JvdGU6DQo+IA0KPiBIZWxsbyBQcmFrYXNoLA0KPiANCj4g
RnVsbCBkaXNjbGFpbWVyOiBJIGhhdmVuJ3QgbG9va2VkIGNsb3NlbHkgYXQgdGhlIGNvbXBsZXRl
IHNlcmllcyBidXQgLi4uDQo+IA0KPiBPbiAxMS8xMy8yMDI0IDU6MzEgQU0sIFByYWthc2ggU2Fu
Z2FwcGEgd3JvdGU6DQo+PiBbLi5zbmlwLi5dDQo+PiBAQCAtOTksOCArMTAwLDEyIEBAIF9fYWx3
YXlzX2lubGluZSB1bnNpZ25lZCBsb25nIGV4aXRfdG9fdXNlcl9tb2RlX2xvb3Aoc3RydWN0IHB0
X3JlZ3MgKnJlZ3MsDQo+PiAgICAgbG9jYWxfaXJxX2VuYWJsZV9leGl0X3RvX3VzZXIodGlfd29y
ayk7DQo+PiAgLSBpZiAodGlfd29yayAmIF9USUZfTkVFRF9SRVNDSEVEKQ0KPj4gLSBzY2hlZHVs
ZSgpOw0KPj4gKyBpZiAodGlfd29yayAmIF9USUZfTkVFRF9SRVNDSEVEKSB7DQo+PiArIGlmIChp
cnEgJiYgdGFza3NocmRfZGVsYXlfcmVzY2hlZCgpKQ0KPj4gKyBjbGVhcl90c2tfbmVlZF9yZXNj
aGVkKGN1cnJlbnQpOw0KPiANCj4gU3VwcG9zZSB0aGUgY3VycmVudCB0YXNrIGhhZCByZXF1ZXN0
ZWQgZm9yIGEgZGVsYXllZCByZXNjaGVkIGJ1dCBhbiBSVA0KPiB0YXNrJ3Mgd2FrZXVwIHNldHMg
dGhlIFRJRl9ORUVEX1JFU0NIRUQgZmxhZyB2aWEgYW4gSVBJLCBkb2Vzbid0IHRoaXMNCj4gY2xl
YXIgdGhlIGZsYWcgaW5kaXNjcmltaW5hdGVseSBhbmQgYWxsb3cgdGhlIHRhc2sgdG8gcnVuIGZv
ciBhbg0KPiBleHRlbmRlZCBhbW91bnQgb2YgdGltZT8gQW0gSSBtaXNzaW5nIHNvbWV0aGluZz8N
Cg0KSWYgdGhlIHNjaGVkdWxlciBleHRlbnNpb24gZGVsYXkgaGFzIGFscmVhZHkgYmVlbiBncmFu
dGVkIHdoZW4gdGhlIElQSSBmcm9tIHdha2V1cCBvY2N1cnMsIHRoZW4gaXQgd291bGQgbm90IGNs
ZWFyIHRoZSBUSUZfTkVFRF9SRVNDSEVEIGZsYWcgYW5kIHNvIHdvdWxkIHByZWVtcHQuDQoNClsu
Li5dDQoNCj4gDQo+PiAgfQ0KPj4gQEAgLTgzMCw2ICs4MzEsOCBAQCBzdGF0aWMgZW51bSBocnRp
bWVyX3Jlc3RhcnQgaHJ0aWNrKHN0cnVjdCBocnRpbWVyICp0aW1lcikNCj4+ICAgICBXQVJOX09O
X09OQ0UoY3B1X29mKHJxKSAhPSBzbXBfcHJvY2Vzc29yX2lkKCkpOw0KPj4gICsgdGFza3NocmRf
ZGVsYXlfcmVzY2hlZF90aWNrKCk7DQo+PiArDQo+PiAgIHJxX2xvY2socnEsICZyZik7DQo+PiAg
IHVwZGF0ZV9ycV9jbG9jayhycSk7DQo+PiAgIHJxLT5jdXJyLT5zY2hlZF9jbGFzcy0+dGFza190
aWNrKHJxLCBycS0+Y3VyciwgMSk7DQo+PiBAQCAtOTAzLDYgKzkwNiwxNiBAQCB2b2lkIGhydGlj
a19zdGFydChzdHJ1Y3QgcnEgKnJxLCB1NjQgZGVsYXkpDQo+PiAgICAjZW5kaWYgLyogQ09ORklH
X1NNUCAqLw0KPj4gICt2b2lkIGhydGlja19sb2NhbF9zdGFydCh1NjQgZGVsYXkpDQo+PiArew0K
Pj4gKyBzdHJ1Y3QgcnEgKnJxID0gdGhpc19ycSgpOw0KPj4gKyBzdHJ1Y3QgcnFfZmxhZ3MgcmY7
DQo+PiArDQo+PiArIHJxX2xvY2socnEsICZyZik7DQo+IA0KPiBZb3UgY2FuIHVzZSBndWFyZChy
cV9sb2NrKShycSkgYW5kIGF2b2lkIGRlY2xhcmluZyByZi4NCg0KV2lsbCB0YWtlIGEgbG9vayBh
bmQgYWRkcmVzcyBpdC4NCg0KWy4uLl0NCg0KPiANCj4+ICArYm9vbCB0YXNrc2hyZF9kZWxheV9y
ZXNjaGVkKHZvaWQpDQo+PiArew0KPj4gKyBzdHJ1Y3QgdGFza19zdHJ1Y3QgKnQgPSBjdXJyZW50
Ow0KPj4gKyBzdHJ1Y3QgdGFza191c2hyZF9zdHJ1Y3QgKnNocmRwID0gdC0+dGFza191c2hyZDsN
Cj4+ICsNCj4+ICsgaWYgKCFJU19FTkFCTEVEKENPTkZJR19TQ0hFRF9IUlRJQ0spKQ0KPj4gKyBy
ZXR1cm4gZmFsc2U7DQo+PiArDQo+PiArIGlmKHNocmRwID09IE5VTEwgfHwgc2hyZHAtPmthZGRy
ID09IE5VTEwpDQo+PiArIHJldHVybiBmYWxzZTsNCj4+ICsNCj4+ICsgaWYgKHQtPnRhc2tzaHJk
X3NjaGVkX2RlbGF5KQ0KPj4gKyByZXR1cm4gZmFsc2U7DQo+PiArDQo+PiArIGlmICghKHNocmRw
LT5rYWRkci0+dHMuc2NoZWRfZGVsYXkpKQ0KPj4gKyByZXR1cm4gZmFsc2U7DQo+PiArDQo+PiAr
IHNocmRwLT5rYWRkci0+dHMuc2NoZWRfZGVsYXkgPSAwOw0KPj4gKyB0LT50YXNrc2hyZF9zY2hl
ZF9kZWxheSA9IDE7DQo+PiArDQo+PiArIHJldHVybiB0cnVlOw0KPiANCj4gUGVyaGFwcyB0aGlz
IG5lZWRzIHRvIGFsc28gY2hlY2sNCj4gInJxLT5ucl9ydW5uaW5nID09IHJxLT5jZnMuaF9ucl9y
dW5uaW5nIiBzaW5jZSBJIGJlbGlldmUgaXQgb25seSBtYWtlcw0KPiBzZW5zZSBmb3IgZmFpciB0
YXNrcyB0byByZXF1ZXN0IHRoYXQgZXh0cmEgc2xpY2U/DQoNCkZyb20gdGhlIGRpc2N1c3Npb24g
aW4gDQpodHRwczovL2xvcmUua2VybmVsLm9yZy9sa21sLzIwMjMxMDI1MDU0MjE5LjFhY2FhM2Rk
QGdhbmRhbGYubG9jYWwuaG9tZS8NCg0KSXQgd2FzIG9rIHRvIGhhdmUgdGhpcyBiZWhhdmlvciBm
b3IgYWxsIHRhc2tzLiBJdCBjb3VsZCBiZSBjaGFuZ2VkIHRvIHdvcmsgb25seSBmb3IgZmFpciB0
YXNrcywgaWYgdGhlcmUgaXMgYWdyZWVtZW50Lg0KDQoNClRoYW5rcywNCi1QcmFrYXNoDQoNCj4g
DQo+IC0tIA0KPiBUaGFua3MgYW5kIFJlZ2FyZHMsDQo+IFByYXRlZWsNCj4gDQo+PiArfQ0KPj4g
Kw0KPj4gK3ZvaWQgdGFza3NocmRfZGVsYXlfcmVzY2hlZF9maW5pKHZvaWQpDQo+PiArew0KPj4g
KyNpZmRlZiBDT05GSUdfU0NIRURfSFJUSUNLDQo+PiArIHN0cnVjdCB0YXNrX3N0cnVjdCAqdCA9
IGN1cnJlbnQ7DQo+PiArIC8qDQo+PiArICogSVJRcyBvZmYsIGd1YXJhbnRlZWQgdG8gcmV0dXJu
IHRvIHVzZXJzcGFjZSwgc3RhcnQgdGltZXIgb24gdGhpcyBDUFUNCj4+ICsgKiB0byBsaW1pdCB0
aGUgcmVzY2hlZC1vdmVyZHJhZnQuDQo+PiArICoNCj4+ICsgKiBJZiB5b3VyIGNyaXRpY2FsIHNl
Y3Rpb24gaXMgbG9uZ2VyIHRoYW4gNTAgdXMgeW91IGdldCB0byBrZWVwIHRoZQ0KPj4gKyAqIHBp
ZWNlcy4NCj4+ICsgKi8NCj4+ICsgaWYgKHQtPnRhc2tzaHJkX3NjaGVkX2RlbGF5KQ0KPj4gKyBo
cnRpY2tfbG9jYWxfc3RhcnQoNTAgKiBOU0VDX1BFUl9VU0VDKTsNCj4+ICsjZW5kaWYNCj4+ICt9
DQo+PiArDQo+PiArdm9pZCB0YXNrc2hyZF9kZWxheV9yZXNjaGVkX3RpY2sodm9pZCkNCj4+ICt7
DQo+PiArI2lmZGVmIENPTkZJR19TQ0hFRF9IUlRJQ0sNCj4+ICsgc3RydWN0IHRhc2tfc3RydWN0
ICp0ID0gY3VycmVudDsNCj4+ICsNCj4+ICsgaWYgKHQtPnRhc2tzaHJkX3NjaGVkX2RlbGF5KSB7
DQo+PiArIHNldF90c2tfbmVlZF9yZXNjaGVkKHQpOw0KPj4gKyB9DQo+PiArI2VuZGlmDQo+PiAr
fQ0KPj4gKw0KPj4gICAgLyoNCj4+ICAgKiBHZXQgVGFzayBTaGFyZWQgc3RydWN0dXJlLCBhbGxv
Y2F0ZSBpZiBuZWVkZWQgYW5kIHJldHVybiBtYXBwZWQgdXNlciBhZGRyZXNzLg0KPiANCg0K

