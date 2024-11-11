Return-Path: <linux-kernel+bounces-404129-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D7FE19C3F79
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 14:22:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 681231F23332
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 13:22:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B10119D8A9;
	Mon, 11 Nov 2024 13:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ELHlIIGT";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="aBWSYdD8"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6884193092
	for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2024 13:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731331356; cv=fail; b=T/oyakVV3aUK8Xf1sYs8XkVa9FQ83d7NqqmZvbui+w4aAjZCRBXkI1Jgoyqx5W8/lq21AdQCxoWHvIF13nl1F6JOwZ4EwUxNMLX213gpvpZvTj1slY/dbiNC1R/uyRan2WgNNsA9ao+m0gmhVlI8g2u9UYKOsWnAVkAySCdljpk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731331356; c=relaxed/simple;
	bh=wvHLahzYm4C0A8fPKC83Szq5WlL0rMQHNOiqdiZtXuM=;
	h=Message-ID:Date:From:Subject:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=MRd3P2zt5KKFCOSLARKOzFcr60ThvLf9ru9H5zHBkwaTfOqn85rAwhX6YnuR+vY1aSJ+6aJ6oPKx8oRfdU2sVRtMo0DgkGYWUNeb0BP1WOGYgY3awlc1TgBLiyuDZiaU7OcucOIQb8Qp416hHTLFn4OgYz7jJE9F5e0lUAFxA64=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ELHlIIGT; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=aBWSYdD8; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AB9spJc016893;
	Mon, 11 Nov 2024 13:22:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=EhNs6FFRWl7wVWzvuQ7O+miJJ12x2CA8CmyTP3EAnBI=; b=
	ELHlIIGTh4axRaTyQfOkFt0gi6K+mcfRcC2i+QqZm0+9NylzC71QOcTYhqEaIpJo
	A5OcodTawCNHIjlmk8yeyxMNsrcLqusGKa2E0lHOKbG6Gf3PxY4+r7djbTzvcacu
	7F3zikMpI9z0on/cMZJ421H3wA+YqtV1MKdYgwpZAme/7ca4ZHW8YRN0iqBXijqF
	5lf9TQAHda9DuWBKNI2HfdOEKhC4lNp1krG8lnXpGjlY/BBTwEDsYbbdt3ClsWIq
	R/BC4NvUSc3SbWm7tslbDa2o4WE/gLYgqxhiNsDUGxbQh7U04YO0aki7K6vGKK1p
	LdjYUmEbljvV/rIqYKHcBQ==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42t0hnacnc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 11 Nov 2024 13:22:16 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4ABCafHE037193;
	Mon, 11 Nov 2024 13:22:15 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2047.outbound.protection.outlook.com [104.47.56.47])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 42sx671buk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 11 Nov 2024 13:22:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u1hIibd5rzSjiMjgaF9IDv5eBL8PjkQI2UyiBLa1vt2Sjt+PZAJkc73uaoVgvbSzj3VYM6yo1n6grAGj9fTwUhfF9skQQq3Rb+i9hGau6Z2KuH0DA4W4k0Z4NZZcMy//wX3dhyE179UmbMQ5seMOIh2phSjItNNS+Ksl6tYSpOUmG+ErqK7daZNm3zBei5h9CoA8Ug1/1JHeq6M9uWhfGZDJFQ3LiGMxyUF10lVR61LZbbA3BSo2VEtC2RLUm2nBylpWGQCJyZnre1a+eWip06G8IQpGpw+JoQr8EgaMvhhqM04Xo3aKqh53Qhk+Ru6patWUWZmDGqDxvt8C5MeHPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EhNs6FFRWl7wVWzvuQ7O+miJJ12x2CA8CmyTP3EAnBI=;
 b=HutC4ZbqSdXlsVJ2VgTLOob9hA5+okZfqsqfUAQNqTMQb+vrjoJCZMnwQUa2y13MTEc5ldIaykb8tGPu3iIAPX0WTqc9WGudzk/8hzY9UHRg/N4TIwbArl4x+Bw9NTWjWygZDfmVHGxylPb3HpR910U4Vgrq/WdBDn3FEXc+4HGh/sPItiMUrNEEexohTuQJ+aCmJuWv+N84FV6FC+i7XxfNYs6WHZe2AelkUZwTaElReO/f4M03lhZ9X9043G60NJfpga3rLOFIuRpwaxSowiL83v0OZd0tJop2vpTFiifAWCSGcYNR8hoVCrEdh0npEWLD+UjiSvdQhw/oS6vMHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EhNs6FFRWl7wVWzvuQ7O+miJJ12x2CA8CmyTP3EAnBI=;
 b=aBWSYdD8eC4wLIM+KR6Vl64W+XGgLd4/Hh1ALXqq6LM6tdZjn1ukme4vzzvz2cLOai4sNqnz/IB6kMFH7BMV5lZv8EEv9AuqYdVbZZ6vDGRt96tq7dLffxp4ERrx3koeOTBFvGzL7kI3JfIET1jqaTnCsmLTAgSYQD99KcE4jls=
Received: from CH2PR10MB4312.namprd10.prod.outlook.com (2603:10b6:610:7b::9)
 by DS7PR10MB5023.namprd10.prod.outlook.com (2603:10b6:5:38d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.28; Mon, 11 Nov
 2024 13:22:13 +0000
Received: from CH2PR10MB4312.namprd10.prod.outlook.com
 ([fe80::fd5e:682a:f1ac:d0a2]) by CH2PR10MB4312.namprd10.prod.outlook.com
 ([fe80::fd5e:682a:f1ac:d0a2%6]) with mapi id 15.20.8137.027; Mon, 11 Nov 2024
 13:22:12 +0000
Message-ID: <3a9bd52c-b0b7-4c6d-a7d7-2198289fab27@oracle.com>
Date: Mon, 11 Nov 2024 13:22:02 +0000
User-Agent: Mozilla Thunderbird
From: John Garry <john.g.garry@oracle.com>
Subject: Re: workqueue lockup debug
To: Peter Zijlstra <peterz@infradead.org>, Dave Chinner <david@fromorbit.com>
Cc: Thorsten Leemhuis <regressions@leemhuis.info>, tj@kernel.org,
        jiangshanlai@gmail.com, mingo@redhat.com, juri.lelli@redhat.com,
        jack@suse.cz, akpm@linux-foundation.org, linux-kernel@vger.kernel.org
References: <70cb224f-a468-40a0-82c7-735c590bdb43@oracle.com>
 <4e58d34a-ce45-437a-95a2-3ba21f35bbb5@leemhuis.info>
 <Zy1F4n9KoNybBmoD@dread.disaster.area>
 <20241108085419.GA6497@noisy.programming.kicks-ass.net>
Content-Language: en-US
Organization: Oracle Corporation
In-Reply-To: <20241108085419.GA6497@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI1PR02CA0015.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::18) To CH2PR10MB4312.namprd10.prod.outlook.com
 (2603:10b6:610:7b::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR10MB4312:EE_|DS7PR10MB5023:EE_
X-MS-Office365-Filtering-Correlation-Id: a1db8d68-c830-4702-cafa-08dd0253da35
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UGpGb2Y0Z3RtejNXN1E3dlY4MEF2b1I1T2cvdG9NeWljQ3JJa2NwaGl6MFZB?=
 =?utf-8?B?K25DbUNGWHFibFdOM1RCRjNmWjhoa3JoY29GWlQyQURRR1ZHNXRIRDR1bGIz?=
 =?utf-8?B?KzkwWXIwWUFsRTVKWmpsZEhFZHFQT3J3bE5xMnVOL1c1VC85Nzl5dHFwcDdN?=
 =?utf-8?B?TU5zK2s4V3Bjam1icUVMTUJEbnBreTJqQXYwN3hVMUd0SVREUmpxY3RpTnli?=
 =?utf-8?B?ejJTckUyU3l1VkN1enpyQ0ZQNUU3enBFckFFcFh1VjluT2d1TWZhNUs4VWJs?=
 =?utf-8?B?dDJSR2Y3azVQZ0ZXS3UrVVQ2L0poMDI3WDgvOGlZTXU2Zm03NnhYOS9wWCsr?=
 =?utf-8?B?QVRaRGgySDA5T3N6cUZiRWpWZG4ycmVJUjI5dUNRUFNpdUV5OHJjbjlTUnZB?=
 =?utf-8?B?Uk1lL09rYmkvVHJObUxPZ0kvMUUzcitsUC90UHlzUmROU0lWSDgvTXl4c3l2?=
 =?utf-8?B?VjNBaWhDMHhmcnV0TGIzVUtqbWNXbWVpMXI0SVFlOWdYTDcwRk5HQTVBNC9a?=
 =?utf-8?B?WVBkM0tldzZMVkpCVkQ1M0ZQNTBTQWhCZy9RdjRwTldaYVZIditWTGhBT2lv?=
 =?utf-8?B?M28wRDBrcWZITk1tRjdkN3RtN0kzdlJuWncwM1lsSk1yeWp4NDB2S25rN2FU?=
 =?utf-8?B?WXk4ckx6SUV6a2w1N2puWTU2ekJnOEpHcVN4Zk0wRC90Uk9aZkw3VmFEdjNW?=
 =?utf-8?B?KzlZdDNHYUY5VVkvd0FnOE4xRW9PRHpGWUJUTE5VNHF0NWdyUVhhZXVVM20v?=
 =?utf-8?B?QnpoMm5tbjlreFNpQjVhUzQxWVAyMnlqYnNmYnJSOW9uV0tXVGVyL3lyWDZY?=
 =?utf-8?B?bG0xN28zb3l3STNkMTJKR1N5ckhCSVhpR1M2aTRlR2hlbThIVG9zVUNNL0RK?=
 =?utf-8?B?MVRtU0hUN3crZzlCeHkzaVExaXZ1SENUNVRnMzE2QlFtTU0vcjBpL0FIV1R6?=
 =?utf-8?B?Y05KaGFYNHNYZ29rS3BubDB6Y2w2eEYwZnpYQzdrcU5yV25DYnpqYng5Vzlt?=
 =?utf-8?B?YS9DaXBsa0ZIaVlxelpaWFFxWjlHd0YxbElGd2F1cUpGOVcvZzBwTzVnUnJ3?=
 =?utf-8?B?ZEhBdGJSMnFaUmJSL2cxcTl2OEgyaU1VeGpPSGtDdjkyS0lxM1ROUWFiMVVp?=
 =?utf-8?B?OFdjRXFUUXFFTmtFYlp4VFZLamo0VnVxRTdxVTdxNVQ2aDBmUE5IWkxHKzBV?=
 =?utf-8?B?RnlPSDN1bmVjL1JYWE9zbGd2U0VvQkRaclVYRjY5c1Baek1WTnJkZTFKdUtm?=
 =?utf-8?B?YnZLcDhpN2JrbXRMdmtIMXBpV1VsSWlwbnN3WHlpVXNic2ZmMjVrSGdPVTdv?=
 =?utf-8?B?M2pFbU1YMlA5YXV5SXFhelFndHJCN2dDTE1PU1NnZ1lTMk5XY2ZRUFVFMi9F?=
 =?utf-8?B?eTV5L2gyVVpRbi80R2x1cGxpWFNJZmRRYkhPemlwVnF0VUlvenkrZlppU2h1?=
 =?utf-8?B?TzQ1RGpVOEFKOTlwM1hkNkxuR283ZjZ1NEhEeEpwVWZ1SUFQOXh4VGZVVklv?=
 =?utf-8?B?Qm52eGlZbnJuZ0VSWXpaWWo2YngrKzlBaU5yWldlZyt2eWdGdmhHMmNETXhN?=
 =?utf-8?B?UEgyekI3RW9mN1VrK1o3aWRZTEhaSCt6SUMvNXBPNXNGM1ZUdEdOZy9UTFAr?=
 =?utf-8?B?Q2t2SHhJRHZXc1U2YU5WWkFOcEY0K3l2aElVOXdUYUwrd2ZZOGQ4Z3J0QkNL?=
 =?utf-8?B?aDFQUzl0cHhtbVFyQnEzUjJFVUJMWHE1NTBNbTR5WlZKcUxQeGdDc21pNVJx?=
 =?utf-8?Q?tMSFlN0devtLNp7aeI021v2JeAwPw4RK3GADqgE?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4312.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?d1dGV2lvN1hjRlEyWGsxRUY2NEdsM2Q5QTBoWnhnR0x6QjZQSzhheHJkV0xD?=
 =?utf-8?B?V3F6dFJnYlFmMjZSbXYySW00eGR2cDdGYVhVZHlVK1NBSmdqNWVrdjEwRGMv?=
 =?utf-8?B?ZXFRc0wwVVVyRzQwb05yczJHWWxvZnRSRWdTNEozS0VoZUhvR0wvSUprRzhj?=
 =?utf-8?B?cnRpREFvNVBiZ01TRnF6TFFlalUraWg5NHdBK01DbVlOcGFJWEhMZWRZSU9l?=
 =?utf-8?B?VjRhOHFtNnZ4dUtRbGtuNVJJc0NPcEJFbStUU1RqREk2UjgycmpiczBIcTl0?=
 =?utf-8?B?eWpsajIvYUhRV2NjazA5cEF2Qm92Qlh1MWFSZ0E1VXZEa0x1VWhndUlUeTJX?=
 =?utf-8?B?c05oazJxQ2tkdkQzZzBrdHk4bUlTb0t0aDJKMHpwWUF6WXBiOTQwTVkxeTVp?=
 =?utf-8?B?cEcySUkycW1GaEVDRmpQOGwvaldvR0FhOFlGNTZsZEQrZnlmbys5aUFQekpZ?=
 =?utf-8?B?dkcwRHdyK1NIQjFUblZKQ3RrakZkbVlhUlNjWlNrOCtOL1B4ZlJXT3NLamRz?=
 =?utf-8?B?a0FWUmhHSWthRXhHZkhvdGhsSTIyME5Sd2NwRGN3UUpsSGFnVkFROXk2OG5n?=
 =?utf-8?B?WS9haFphS0M1OHBJUysxNEdTWmozMkxvNkNaWE9yekYwUkdtSFhyTDRpejh3?=
 =?utf-8?B?UkI1Q3U3QU9PQXo2c2h1QkJjeDdTZ2doUzRHaU5seERYYmphR2l0YnZxOXcy?=
 =?utf-8?B?UmpIYTI5Ym9zTnVIZlNsMXpCZitUUDVxNVNyOUt3WitldGM4QVdtSTVsUm8r?=
 =?utf-8?B?TjBiMG9pRXRFdE9kazJ5dVpoTjltVWlGTis0cStublVqM1B6ZVhPNE1kVGNI?=
 =?utf-8?B?Vis3RmZ2RnN3QVFKczZXeEJPVGI4S1NIRGhseFJPYXFQR0tINWdZRm45c0pF?=
 =?utf-8?B?a2JIWk1ONXZuUlJtWk96NmJoa1VSa3VjT2d4blovalBvalZnM1ZJN2xOQlNy?=
 =?utf-8?B?NTNLRVhqcUpaNnF4RS80U0VZVndwUm03NUxqR3dSVmZtMG1LNEpaU3hZSS9E?=
 =?utf-8?B?blVJVWtJdnBucW1WRWxETmptMGE3S2toSGJEbEc1K2k5S0tXYnVSQ1FaM1B4?=
 =?utf-8?B?b1VhSmdjRFdNYzdSQ09TTWxMRTdzc0tTSGJoUDRUWGo5U0M4c1RGakxlcElv?=
 =?utf-8?B?NXdiN2JXU2ZSLzZqdzFmSWJXTEQ3bVJ1dWpZTFVSZUczV0s5SHhENzBFeFVO?=
 =?utf-8?B?UGthSlowVGd2L05ScjdJN2szOUdiN1BMNElWL3ZRR3o1MG8rN3pGM3pvdkRk?=
 =?utf-8?B?U1N3NXhZd2h4cndRTk1TOGFNcHdOOTc4WEtsNXNudmVocEptMEl5QzZhODh6?=
 =?utf-8?B?UWd6WUtVUlhTdGJKbEhSTEVrSFVCbzJoZXlmRFJLeCtSbkxGTTMxNnF4ZHRq?=
 =?utf-8?B?WGRDdVlqZnFYQXZEdk9rRXFacDR0OC90QUxMTFNPS0Z3Y2xIbkZhdVZPSFdD?=
 =?utf-8?B?L1pDNDF3NE5tbHdNMjA0MmJ6MGhJTlpMYlE2YWdmRzdDdi9lRkVKUDNoSldt?=
 =?utf-8?B?aG9zTFUvN1BEUkJzNXRVWkZxZ0hoVWw2VDBPRFVDdDRlc2loY2p5SHBOUSs2?=
 =?utf-8?B?TVFRYUN1a21kMkpBUjlMUFc1ZEQxSmNEcGFSM0VldVRHWVY2SGZLL2JVcVNm?=
 =?utf-8?B?THBudmpkcXdTTmZQeWhlekJVSU0xTzgxS0c2NC9LUFBKR3p4RmpoQ3V1SkpQ?=
 =?utf-8?B?Um5XaHVleEtyRTh6MDNuMVk0UVl5cjhudzdHakYvdVlheEdsTnZrV2hoeFpi?=
 =?utf-8?B?ZzJLN3RLeCsvc3NNNExqYmFjaHB1UkVjRzlFZTRDZjJVaWdoMElzTDdnREZs?=
 =?utf-8?B?QmYwQVlGZWRzd3E3Zjl2NHFJVnpvdFBLRHpXL3pWeXVMay9EVFd5YTE4NGZH?=
 =?utf-8?B?WXVzdTk0T1NwZGF3OVY3cjRCUjVqcW53M3FqY3cwL0dKMEo1ZThYeFJFb3B2?=
 =?utf-8?B?bHo1bFhvZHVvME1mamFndHpkVCs3alZ1TnJPWXZFeXYvTTVxd1U0MHZOUGZN?=
 =?utf-8?B?R0x4ZWNwYUJDbnlpckd4OWk0L3BaWnJrU3JPRm40bEk5bXRlUEdvMUUyOVda?=
 =?utf-8?B?cUp2aHRId1JYc3RRZ2VvcFpEOXBCanA0b3RzNTY1NnMwVTdleExZRVhITTFK?=
 =?utf-8?B?dWZzT0JPL3ViTzlDZ2ppNThadFd0SGhxSlc5RHQzd3NKYzZiTWY2aGZGUTNS?=
 =?utf-8?B?V1E9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	w2mkTUX+HkeuX0VCVNYBn8CA7iTDjnOitPla2WRrucbxoE3O5nh2qppxVX5HLsHhPfccoTIF8HmVv9vgxfZgO8VfCybs3U5QovDwg/1BBGf7pGJ5NxOhhKy53nsAzxJ2fATV7sXWoQuQUO2pAHYjeplHj+L4kSvJ6iM2kMdzIRusEQj0CaK3wMlfAl1Qd4oyZb88cfneg4Dzf1aGTY5PS83YBEjLFm7Ig1iUyxguf02tU11sbPfFO13ivvp0TtuM7Ra5ou7AVlVc2uo5oyoBrnpcLZ9seU2POav3BTGNkITtfGqisA5eAE9xSq7JTrAbGkMQG/29sCYHZE6nr20tuRcqzmyOledjyY1J1Nl91SIraQENyrZQJeqZqT/eeNDy5qgrbT52u/YQn0A+biC0z2Qjxr7y3FJka8F1JjwGtqpAlg+DBStX1ZB/Juvd+oo9ar0L/Gnip7Ns1/DHuR0u2w9wV1Qc7wF6WhRRixggfUmTT9pDVznd2G9u2mPJxKFkJjyiT5xj4URT2gBKAZ3N4b3r7v/QJMr1pOvK7tLxF0/2LWQg0B0v4vOIslySLLZTnSZKRSOu1/X6JfC66C87gfD7M2BoRfYEokpY0JhTwuE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a1db8d68-c830-4702-cafa-08dd0253da35
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4312.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2024 13:22:12.7111
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HLN2vydEVo5RLIFKzzGlUWDbrJMbTFfz0NX90bxhSahddLOgBRjrOHaU5HAfRWwQ3kVSCQBAXCunIwI9oDiHtw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5023
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-11_08,2024-11-08_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 spamscore=0
 phishscore=0 bulkscore=0 malwarescore=0 suspectscore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2411110111
X-Proofpoint-GUID: YfFoD4GNzU4why6sdRGmhaosGSjr8_Ox
X-Proofpoint-ORIG-GUID: YfFoD4GNzU4why6sdRGmhaosGSjr8_Ox

On 08/11/2024 08:54, Peter Zijlstra wrote:
> On Fri, Nov 08, 2024 at 09:57:38AM +1100, Dave Chinner wrote:
>> On Thu, Nov 07, 2024 at 01:39:39PM +0100, Thorsten Leemhuis wrote:
>>> On 24.10.24 17:49, John Garry wrote:
>>>> Hi workqueue and scheduler maintainers,
>>>>
>>>> As reported in https://urldefense.com/v3/__https://lore.kernel.org/linux-fsdevel/df9db1ce-17d9-49f1-__;!!ACWV5N9M2RV99hQ!K-drGDW_XBDuFwUrnEBHKIab7gT2eumqlwIEviGOHbLBedwmMvP_yJGM98ikNAU5uTtes3Ig7Lk40CG3652p$
>>>> ab6d-7ed9a4f1f9c0@oracle.com/T/
>>>> #m506b9edb1340cdddd87c6d14d20222ca8d7e8796, I am experiencing a
>>>> workqueue lockup for v6.12-rcX.
>>>
>>> John, what this resolved in between? This and the other thread[1] look
>>> stalled, but I might be missing something. Asking, because I have this
>>> on my list of tracked regressions and wonder if this is something that
>>> better should be solved one way or another before 6.12.
>>>
>>> [1]
>>> https://urldefense.com/v3/__https://lore.kernel.org/lkml/63d6ceeb-a22f-4dee-bc9d-8687ce4c7355@oracle.com/__;!!ACWV5N9M2RV99hQ!K-drGDW_XBDuFwUrnEBHKIab7gT2eumqlwIEviGOHbLBedwmMvP_yJGM98ikNAU5uTtes3Ig7Lk40NodyRwu$
>>
>> I'm still seeing the scheduler bug in -rc6.
> 
> But that WARN you reported earlier isn't there anymore. So what exactly
> are you seeing now?

My problem reported in 
https://lore.kernel.org/lkml/63d6ceeb-a22f-4dee-bc9d-8687ce4c7355@oracle.com/ 
seems to be fixed after rc5. rc6 and rc7 look ok. But I will test more.

Any idea what could be that fix?






