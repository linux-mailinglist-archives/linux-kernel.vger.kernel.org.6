Return-Path: <linux-kernel+bounces-576073-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47A56A70AB5
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 20:48:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CFDE53AFD90
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 19:48:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C360F1F1519;
	Tue, 25 Mar 2025 19:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="jgC5zj/b";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="mSK2XF1t"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E1481F0E58
	for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 19:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742932097; cv=fail; b=NJRu0Rp2lnm+QrjCP/Ro7LV7rezyc1Ntt4kbSdJWLWjoz+1uuEDvji+1AxfW7xu7QTweVI/gFyM6GUXTRnOcBFsMGoX0kSb3ytHZqvar3+WBemuOY8+ovbCa5arsT87jKy5UShmCrHLko2Vj3ar+nVl+zbFB2ieWQaKA1qBaSbM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742932097; c=relaxed/simple;
	bh=0LqCQ7GZNUgaCN61UG/D+6Ts7YQtMqO6g29SurXWnFA=;
	h=Message-ID:Date:To:Cc:References:Subject:From:In-Reply-To:
	 Content-Type:MIME-Version; b=r6k/OCLFCNfas9dVhNRazOSC4/igFiPjwEEO4JCxZZF2elQ0QhxfdaKmPOrbgab3MviUUdJPdPyegVQMO0joUcv8OPpeUw9XcBP1lxv/aZKsS4F8QqA0KewvqDEkyd7FJ63C4N2TrFn3h34+fpTO/2F14dnN5nVfZCMkhIfMCFM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=jgC5zj/b; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=mSK2XF1t; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52PJXsO0028096;
	Tue, 25 Mar 2025 19:47:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=dfSH/kN3jKYr1nDGC3GE6aqfoEKDOnjT0AQ/SS5Hgr8=; b=
	jgC5zj/b+nu0eweJTiykIQz62iB2S4UcHO66tsuczxM3UqCaQ+7dUvgzWgvvi0c7
	wVmHOk4aQIsQ5GUQ9AWnk3rQvuoVlfCkS0n7WfX06L7utJK4/SFpI1POQuXN4Rpc
	W2nEEwOC6SZVQD1+ZATxPiuBRdldCCwWyP61dYJ5Q/81gUYEBgcPUFWLMVvQDGji
	04zHbGhf7zBplqisvBtO2R2dQk1obHRohCv3JD0qaxXEoCt6YAg7qCaouaeoEuGa
	1aFPxIo88i3V332z/M7FwK880ZjlT3kW2bQUNYNyplrBeCSnUi6NzdM19p3qlPcR
	pJSXeOXO/Iqdd9qwZ2ScFw==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 45hncrqyfg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 25 Mar 2025 19:47:54 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 52PJbOxE008223;
	Tue, 25 Mar 2025 19:47:53 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2042.outbound.protection.outlook.com [104.47.58.42])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 45jj6uky8r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 25 Mar 2025 19:47:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C5LB27ps9klweInUMwz9fftV55o+t5CsAsPa3lU4XsJO7FKkFSz7rqI9GFoXDeb6srGpdj60eu9/lwyKtl7HM+8xFOcrMApInKYII8oliEv48kVnujVZ7zg7rCW9TaUfVEc/ClixMOTm+VWQ6bNBl0YyuZyhvKati3jssBibKMOJjgrgqx38VKTVIK2NZ/kz3D+rU1O2hSXlIQ0eWBJDhyVr8R5MvNm1fF5CTFYVNGASpD3Gy3Bb/IkRotERgg8NqSaZ8Yo3xq2zB1sr5gH3ZNhFpNxvseBcJmuDB+8CuLwK9O329z6HZzyBldxZ/ElCkJVUkTJI+DKGRd/W2RiQhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dfSH/kN3jKYr1nDGC3GE6aqfoEKDOnjT0AQ/SS5Hgr8=;
 b=MgeWLaIMeAXldzDsc7eKCuHuu3ZSxWIAEt6TLFrSxbcOSreakfdNNDbN+tYaKwbEZeCQEClOgctr5c5NKmnQW4YAyMp5QDBlQuXLNegXFbNEi2okRU8FVr44VEbldDm/tzLH9NiouxBUOayJRAt8EsxHR6qv4TEnSOPPJX88kQPoPB+TVRGRIo4lNaPT/gM5nDClEGkJIqv88//ReXbnQ8+4Nal3ZeF+SEqmhvMP+fTTs/MFG6AVVrU2zPfOQeJHYVwvWq5SDzAnzg3hnm4+x8hJ3trL9Sy0K7Oayw9A7UYxLKP1W8ocbsrPxZXbuPIL2Y6hpe+azDfSeLJ61ORhzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dfSH/kN3jKYr1nDGC3GE6aqfoEKDOnjT0AQ/SS5Hgr8=;
 b=mSK2XF1tBrzZt8OTy14ZQ/HzJEuPX4p7ftPNPOkHpp5AbhmKsyFc3rtfCx4wSihoIL7mbrOZ8mBKoEgTsnr5QBmjruBRrA/m8GalTuSZHAVjW8TJBirCaRaOO0H+5GzLg7zHKbBbZoFebYBL1ZvWUukNUwwJrJZs+haUhAL13Gw=
Received: from CH0PR10MB5113.namprd10.prod.outlook.com (2603:10b6:610:c9::8)
 by DM6PR10MB4315.namprd10.prod.outlook.com (2603:10b6:5:219::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.42; Tue, 25 Mar
 2025 19:47:51 +0000
Received: from CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::eab6:6dcc:f05f:5cb2]) by CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::eab6:6dcc:f05f:5cb2%5]) with mapi id 15.20.8534.040; Tue, 25 Mar 2025
 19:47:51 +0000
Message-ID: <15dfa02d-de39-4c51-94e5-deb85eb6e82c@oracle.com>
Date: Tue, 25 Mar 2025 15:47:48 -0400
User-Agent: Mozilla Thunderbird
To: peterz@infradead.org, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>
Cc: acme@kernel.org, adrian.hunter@intel.com,
        alexander.shishkin@linux.intel.com, irogers@google.com,
        jolsa@kernel.org, kan.liang@linux.intel.com,
        linux-kernel@vger.kernel.org, lucas.demarchi@intel.com,
        mark.rutland@arm.com, mingo@kernel.org, namhyung@kernel.org,
        willy@infradead.org
References: <20241104135518.198937277@infradead.org>
Subject: Re: [PATCH 06/19] perf: Simplify perf_pmu_register()
Content-Language: en-US
From: Sidhartha Kumar <sidhartha.kumar@oracle.com>
In-Reply-To: <20241104135518.198937277@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN0P222CA0001.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:208:531::6) To CH0PR10MB5113.namprd10.prod.outlook.com
 (2603:10b6:610:c9::8)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR10MB5113:EE_|DM6PR10MB4315:EE_
X-MS-Office365-Filtering-Correlation-Id: 3caa9ab2-4522-4d41-6b7e-08dd6bd5ecdf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?djVpNmpaUjFyNW1iRERmZHcvd3YwbnVhQldlV2RvMUcxQ2Z0S3RmWk9Uanda?=
 =?utf-8?B?SHdTLytocktMRG13b0E2R1JFZGpiUk4vK2x2KzR0ekNqSHRuSVBNMjY0MWpR?=
 =?utf-8?B?dmRYZTdrL2x2bzB3SGJHcW5xVWFTWkxtYmRBVEo4bUt0NDJLeTQzbWpWMVRr?=
 =?utf-8?B?czVYT2M0eGR1QmI2Skw3MFlHN0dPSlVsVzhzaHpxNzdwUFZuS3hLY3UzSWRu?=
 =?utf-8?B?ZWVka1VjV2c0R0xkU2JrUEVyY2M0MmlLWElKMjVkcHhRQlJVaGIrVlV1alkw?=
 =?utf-8?B?VU80cjhJOXFTelI5eC80aFRUSzI5OXltRXhkL1RxeW9Nek9rcnErZ3h1TWlx?=
 =?utf-8?B?TlkxUHI1am83NmJVZ0xWY3NHa0tHakxGZVZ6ZDVqc2tqeXVSUUZ3Sjh6dGhZ?=
 =?utf-8?B?dWtlZmtCdmNMQjl5V01qMTE0eGNvUFVhTXNxOW5OWmN5QjFhQWdlWHVlQ0dy?=
 =?utf-8?B?RTBqTG5QZ2ZDKzA0L3h3c2owdGF4R2tlNGp6Sy9YRTk4Wks3ekdpWmgyOWll?=
 =?utf-8?B?RUh0L09LS2VQUVc3MHlkWjVobnV1SzNrK2ZxOUppMlN4dnRwbWpMZXNJRW1a?=
 =?utf-8?B?aXNhZ01IOGt2S0g1UmdsQ3VrelRWQ2xrVUhEcFZTQTBoVWNxNFdKMXNsdFg1?=
 =?utf-8?B?S1o0TFl4ZlkxZXdlUUF3ZVgwS3FwQzg0Y0dQS0lJS1lOeWl1OGxwNmZweXA1?=
 =?utf-8?B?VXhZdDg4c2JtY2ZaWnBGbmthQWRjNzQxeVdhb0RsNldSeU9WL0xSVGY0WDIz?=
 =?utf-8?B?OUlVa2xqbjVOMnNHallKMDRDWWdMTmVjTDc0cHBaVWNBeFgzVkNsbE1XWGlw?=
 =?utf-8?B?Q2N0OXZPZ1UwaWxvNnpFZ0lBY0NVUXFWeDVoTlNyVGxKamx3eVlnTHh2R2k3?=
 =?utf-8?B?K0dSRzE1TnU3ZnNSUC82dDJaT1JqZVFZUTd5NC8zVnVoS210TFRuNG9NcFpU?=
 =?utf-8?B?TytQa0FXZmJtdWJuOEI4M3JseCtLU2g2M29FYVRSUjNaSzdIRXRjdWFYeVFE?=
 =?utf-8?B?cjRQOFBjM2tPZVlKN1RRVHpld29tNVEwalhBM0R4UW51VWtzWklQdDlPL0RN?=
 =?utf-8?B?NGUrRFpmTU9ITTBDb2NEb2JJMkJxQW9zU1IyMmZGNkxaT043NUdXY0VFL0Zq?=
 =?utf-8?B?anVFcDBvMUpudVAwUHZXMnluVUFuSTFsVDNHRTZWRUZQem01bGU4NHZ1bzZ2?=
 =?utf-8?B?Zzd3Q3FjeWRqajA3eW1rcUFlSThxK2FWSFhENnpWek1kanZjZ0hUc2Q2bmtm?=
 =?utf-8?B?d3YzR000SnJPOUhvcWdjQnZuWVdPT0NZQWhDU01qSVdTK2FKUXYwM0E3b0xn?=
 =?utf-8?B?VzM2OGxZc2w3QUVPUWIxT3MvZUF1eDd3RTJoQ1VnZityQUQ3aVQ4cE1kNWt6?=
 =?utf-8?B?dXJVcFBXMFhjdldiZnFlWFJyZHlKTmswSmlseVptUy95SkFTUkExeENVWGxC?=
 =?utf-8?B?b2N4WllBZmVmNVZDb1F2eTdBclZPUGNQZC9EYkorSGxvOTh1KzkwVVB2UUJI?=
 =?utf-8?B?dkZHbUJYNmpaYzNGbUNEZ2JoOFU2cThqbHlsamdzSVZYblk3MWtjeitGejhO?=
 =?utf-8?B?djhZcGo4OEpZUy84WUlmTEpqT1hhekl0aFhjNS8rTWNQbWk4NWZkbkJqZERQ?=
 =?utf-8?B?a1p6RWpLNTVaajNOMnJ1bVB6UUgwTkRkY21oWXFwWnIxTG5mUWp0SFFJSVUy?=
 =?utf-8?B?Z20xbEMrT1V0cjI2SWl3UEFzdE5oTXVHOE4xWEx3dCtZbzdGcFh3REMwV1dS?=
 =?utf-8?B?Y3hmaW5yQjVDaVJySkZJRThLejBoRmlaN2hKRExhYmhodjJNWmtZRnNlUTF0?=
 =?utf-8?B?ZHFTV1c2eUFsNU9Ma0pPWVFtWlBWYVg2MU54dkw2SjdYSS9rY3BGOXRBRmg0?=
 =?utf-8?Q?g29yoEWXfKNeT?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB5113.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aEEyeHdkOGlDTnhVcmxieVgxZWZmOTFpL3JXRGJtK1h6dzRSTEhZZzlaVmht?=
 =?utf-8?B?MVp6UDIwZWNQZFhaZ0xQalpnN0hIcDhDSUJrVWMzMEM5Zmdzb3V2VzBDdnpY?=
 =?utf-8?B?MkVFb0dUanBoUjlNcXR6RitxdUVUcDIveUJSUDg0SmNoeHVaWHhKRlhuUzYx?=
 =?utf-8?B?S0hnOGhrbGRQQVpySVphVlVsZ1NYOU12WDc1d2FId25LUzZaSkd6bWExNW1K?=
 =?utf-8?B?czNMNGpRd3VLUkc2SmVVQUJKUXkzay9xd09TeTZRZ0RMdXhrVmxvVDI3anZD?=
 =?utf-8?B?VzRrTDJvWHQva2Jlb294aUUxL3FaLzh5RVRkQU5KQ296MWFidTBQN1dRaTNw?=
 =?utf-8?B?b01OOXhRL1FETEc3emxjL25lSVZSZHNMenJseC9mVjdtMFB6aGlUVzhoWjQv?=
 =?utf-8?B?eXlFd3Nmc0RGN2J3MnRkM0Q3V3U0SVJ0UTdjclVMajhFU1lSTmFYb2FxSlNW?=
 =?utf-8?B?SHhkc20vZjFwVEswMzJDMkc5YkJFckZ0Nld2UUZ0djJ1VTlIUFhDOFp0cHRi?=
 =?utf-8?B?Tm1Mb0NnQTNnYXBFTzVFVVRnejcxZXAvOFVzbGdNVENXMjVtUHVnT3ZEcmtv?=
 =?utf-8?B?Z3k5blIwaGJ4SmZZYTRPQjhNb0J1YWlzQWJkbTBIWlhEdURTKzhidVEzbWJU?=
 =?utf-8?B?c2FwWW5oS1NXNURJcVphUWplampCbWpnZ2lVTHpoOTE3RVAzL2pESHRLUWp0?=
 =?utf-8?B?MERBZjNWWDRuL3lxUXFTSCs1NU5RV0gyQmgrWll1OC9NeU5WdDdoYit3VmFK?=
 =?utf-8?B?WUUvVUROSDhZYWxnOXgxWktjdytHTE9Xa3JyZ0Rvc2plWVFHYkdrZUx3Ty82?=
 =?utf-8?B?Wm1zcEVQOTFtRUc3SjR5c1EwSjBRN3NSVlhlaklGWmlPNThhWVRIa3BSTjRF?=
 =?utf-8?B?elllMC9EL2JsdmV1SFRmNE05V2xLMjd6cVRQczVxZmhPVjlTb1QzZnFjZDJP?=
 =?utf-8?B?YnovUmhjbzQ1ZFlhQ0pYYVBrbFlmdXJ4TzdjMkRrazlLODZ3aThyQ09VcE8r?=
 =?utf-8?B?YVY4b2ljTWk2MHUrUzVoKzNpNWZOSFU0RVFiZDBUS2IzMEZUUjFBTXZXZEFC?=
 =?utf-8?B?OTg5bDRCdkJobjZNZW9OMk83VnpZTlFzWXE3a09FOWwxd1UzbEh1SEZRUkVI?=
 =?utf-8?B?NkxGVEFTblROUFVZYS85dURTcFBnbGFRYzNQNHVWenZ3SjY1OVpnMm8ySWlG?=
 =?utf-8?B?REZiYjRwMExsRDQvNjd5NmlRTXlVZTY3L0JNRHE5RUZ2R3VqNnVsUjFIQ0Jn?=
 =?utf-8?B?c1N5a3VRaitxZXd4dlZycStDVmJYZWdBVWx4dXFXcGpQL0xZVndQb29RSHdo?=
 =?utf-8?B?K1hkMVVESU16a3BuWFVHK0pKbTJrME9GeFdXeTREUmtYUjVHZm9ZOGh0NkNZ?=
 =?utf-8?B?RnFOcXlUc3MyZi9BWVJSbWF6ZGpURW5XOEwxd0RvNENDWDJOM1lxVmR6WEEy?=
 =?utf-8?B?cjByODRibmRSWWhqM0oxSnlkRnROeFNLQjN0MUNHaXVtTFg4eDdWMjZpU2sx?=
 =?utf-8?B?SGs1RTNCMmROa1BGYVVVMnlUSGFxV0ZoWkpCNElnMUMwUnV4STlKVUhveU1a?=
 =?utf-8?B?Y1FZMHVSZkxGTXRrb0VLU2JhVVhEZUVJRTlhTXlIRFc4NUhodnRkL0lHQkJG?=
 =?utf-8?B?Q3JnU0M2dExXc2laK3B0ajJmSXNYUWljcFZRRDlYZDhzTDhQcGs0SG01TnRT?=
 =?utf-8?B?Qmwxa0xiWFNoOW91cEFkMmVhYUlnTTVkUmtpQTE2eWN5eTExcXF4aHB4TVRV?=
 =?utf-8?B?M2lYcS96L09CZG1lemlHeXViYnB0WCs4UmZRYnRYRkpGRTFoYjg3Z3dRQmFz?=
 =?utf-8?B?WGVwK2FhWXFXZmVxaXNQVTlQVi9rSXFSZkFmUHFrMk0wWlQrMkxrU2EwdDhn?=
 =?utf-8?B?bjdlUGRlUVV0UGxXcmxDb05wVCtzdi9RSXdYUklqcTZ6SmhuSTA1QnBuTEhY?=
 =?utf-8?B?TldFYTBKY2dUN1FKanJodUV3NnF3Q2g0OXF6L29pcXg4a3hrd1VYYU5EcHYr?=
 =?utf-8?B?RDBBZ0xxTC9HWkdYdGcvQlVDQzlvaDRkTmxvT2FuU2k2K3RETyt2SkpVU25j?=
 =?utf-8?B?Z29kZ1VxM0RrNDNWazVsQ3lBVGVneGVYOGVoeUpSdGFZQTQwUEdlSzRsbm5Q?=
 =?utf-8?B?VHR5NTZMWnJPODAwZHNGOUtIa0I0UG1hWndPTmY2dUFuTzVpejBONFE0cUVz?=
 =?utf-8?B?QkE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	q/j72rYDonloUVhBo8pKGbiOiS+yLE7HmqpS03VRbiHwLa96nw0kRCI1YDYIvskeIkSVutaLQCpzs9/9gciXhXPn4sALkmvBvXRxotgc9Yq0jx9adMcJMQ4daLUszcZqg7P4ZO60kGwaSDpgNmMqdHaQ3kgBZLJFef7xbxqB1iBYxFysjlJK5pGLHOzSYjKnY7PishfeoSHkF1m+87LvSiwogOsiynlUtlnql8C58CmmIBtZK/DbkDfBcjbV8hW6kis1Tgtm0/MYTMruQl6jTfs/BmlCMOYeol+Lw8ElrE+u9slGCGjSeqc6QrlKUjjaoTPm8A2zFO7lHPAJW8gc3mnTm3zZeRHVaT2GmrrmeQr1gxfEqeXkBgcE6ztbhRihhFW34Im0t3eBusNmJsN+RwQbWXBmDVpOHqPWG8mn3Awjt+aqsp5860RQxfy3HJe1wURFgRPUI/OPVA4e3H5A+6mkTuSjWCgHFaZPTS+gX6ute/JbTetle307GOBzvPXFSDII0DqBgd1S0uWdKN2JLwzYNE/tcyBzjiHrzny616KoI7xVBP2VwXGd+eXJJiM7rDOsuAvHc1v/y//q4GMOV/Vs3BT8M3UzLLrZ3YkJYcA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3caa9ab2-4522-4d41-6b7e-08dd6bd5ecdf
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB5113.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2025 19:47:50.9909
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EZie6uJsJu1XGHKFaRdbaWXj+4+HMu7kV1uF5sYKXt4oOXbqmRciSVgLeGgjIZu7X8Mm/M1OCKhZK+tSnGcLn08SD4LRswZM4O7Avdo2zBg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4315
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-25_08,2025-03-25_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 mlxlogscore=988 adultscore=0
 phishscore=0 suspectscore=0 malwarescore=0 spamscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502280000
 definitions=main-2503250133
X-Proofpoint-GUID: HmW544WBF_esTat02_cA3nz5G7Wr2hco
X-Proofpoint-ORIG-GUID: HmW544WBF_esTat02_cA3nz5G7Wr2hco

Hello,

The inclusion of #include <linux/cleanup.h> in include/linux/idr.h 
breaks building the userspace radix-tree test suite with:

In file included from ../shared/linux/idr.h:1,
                  from radix-tree.c:18:
../shared/linux/../../../../include/linux/idr.h:18:10: fatal error: 
linux/cleanup.h: No such file or directory
    18 | #include <linux/cleanup.h>
       |          ^~~~~~~~~~~~~~~~~
compilation terminated.


Thanks,
Sid

