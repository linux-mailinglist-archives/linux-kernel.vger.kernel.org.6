Return-Path: <linux-kernel+bounces-370665-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 991A09A307A
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 00:06:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 59B622832FC
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 22:06:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 474E71D63E3;
	Thu, 17 Oct 2024 22:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Ftrk37ak";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="CaoozNw2"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BEAB137C35
	for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 22:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729202774; cv=fail; b=iekbIztBFXISnX/4jiOJBC/Z5oWlN3DrZ8K3q/mquQC80BJxiC+qUdcmQkgNQDmImrG+Frp+ar4xKAO56v2eoT+tZGwqzfOsS5U8vXdG8nzFbmlXz/2QOSLilLltREX6ouQgzNylKBUPIqzDFsGKseTH0JARhgwDnrfIMUhSLEw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729202774; c=relaxed/simple;
	bh=IT0bCdQhjUbBrzrYRmLVU65X1/nT2nuoj1ZxgWDDm50=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=r8vxQswq47uHsV518r71nmCF3bpp0O8VzkkwGS8C6uek/YJGMDrcQGldgE1VLRQ2uZM0Hb1SNqYXh1CcHsdfnDqhYa80BQQhKyauvnPlRBDbXct3+UlLPXu2xtEB3qtv7YGtWhgLBpMgLl/PPs5RmWYQWpJf9p5YghKaQJVN7GI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Ftrk37ak; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=CaoozNw2; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49HKteFj023335;
	Thu, 17 Oct 2024 22:05:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=J2MeTSdOt5NDMaIZu0TwZz8mFHeqT8L41PUZXP9QOZA=; b=
	Ftrk37akisBUpXxQOg1zmxLYEwrD2ule/5bpKedIedIOJj9/d4lCEraEcCaz/bSe
	YE/5z0ml0p3RvkI1RlTWKjfOvo3wlG1HveLvM9TnqEiunZsjdE2iIUk9gQIuWr7M
	0veZtn0nTfTQZwz6PqrLX9UEEOiS+lOUTnCKoY6DrkiKSyjSkzzkdDvLKOQhfjls
	eTy/mrENlcLPBRZnwrxiLUw26AGwzVDEYPiLOr75PbCfdTY7S3ltMDVK0qN91iJK
	YYPJL5a/xVcY74f47kWwyA7pFIr5UJZXlURxizCwfuvXyx9pKomjhZrQqMCQjlj8
	anNgBnqSCnSTuJeSAJTqBw==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 427fhcq3p3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 17 Oct 2024 22:05:48 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49HL9tCq027250;
	Thu, 17 Oct 2024 22:05:47 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2045.outbound.protection.outlook.com [104.47.51.45])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 427fjhey9s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 17 Oct 2024 22:05:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QdD3px9apScs/0v8gO9byRsXNHt2e7cs8pi2b1q7Pbm4gliQtxhDhAPKZg+4XR4hxi1GMUpf3mUdrRNDyg6x754hPbi8EzRoJVVmByAe4BD+4BuE62/foTV3d6tWVtEuk4LynNLfS/Q/sWek2UWR7edoj8zsBre7yBgCgHGJYjf2nO3nasW9JxAm0ToRTUKFrGbpa2noge1dTEMK7tCgOJhFMrZuSMc1mFhGDiXtHW/3E+WpsrP8zkhv3VZmWRC8TIn1vtk/m0cRwUQAaabJfrvUh+NydYqOMVTB8POIm39z+HVq8GCpmsQuQsW/hj0apwalqW4mdPPXVJSV/YYN/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J2MeTSdOt5NDMaIZu0TwZz8mFHeqT8L41PUZXP9QOZA=;
 b=kIpjk7rI/G9uOZEIynDpWZi7OUIO2m7/mj+nPyGZmqYpQSTVrsqfyNgsFPh6ZulV0uQMbClbB+75rqxiPgLpcpZ3IeDOCcSgaTOcDke5HoIklDlNwIq0POWSg1u95biF1sI6q13KDWfd1BTYrDlmxDfL1udVoDxhzKHdxM6o3TAJeAuIq8gRgV9KNVVp9qlaSpjt7OHkU/dGsx3IjyqDDzTzl5juHZasHRP3uN/9oRthBVBjEEo3Ru8kzECY3AuShrNiBYHYsDR/Ufzqc5HMjubPKfqIlUQiZkGmke8wjjKYIuFfbHqLJkPaTC8bdsGeu6m7rOcpb5FhlxJfwqH/1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J2MeTSdOt5NDMaIZu0TwZz8mFHeqT8L41PUZXP9QOZA=;
 b=CaoozNw2bAv+j6m8Lnhr/OlrDdfTTR/UAQfwsbp6jHaqUANQlMK7L/8HHKq9hS50yc7iqmpBBAU8JfhB/dP2/BHiMBlXkzXbp0nyFT1F7SMv0r2vkcHCQqj0pmqGwG9FxdjGX/e/FagVQxlUfcYJm/vZrpBQca/s+wY2PMLDc68=
Received: from MW5PR10MB5738.namprd10.prod.outlook.com (2603:10b6:303:19b::14)
 by IA1PR10MB7386.namprd10.prod.outlook.com (2603:10b6:208:42e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.19; Thu, 17 Oct
 2024 22:05:44 +0000
Received: from MW5PR10MB5738.namprd10.prod.outlook.com
 ([fe80::187b:b241:398b:50eb]) by MW5PR10MB5738.namprd10.prod.outlook.com
 ([fe80::187b:b241:398b:50eb%5]) with mapi id 15.20.8048.020; Thu, 17 Oct 2024
 22:05:44 +0000
Message-ID: <9c996da7-19a8-4ca0-82c5-ee656d2ed8a7@oracle.com>
Date: Thu, 17 Oct 2024 17:05:40 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v1 00/57] Boot-time page size selection for arm64
To: Ryan Roberts <ryan.roberts@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        David Hildenbrand <david@redhat.com>,
        Greg Marsden
 <greg.marsden@oracle.com>,
        Ivan Ivanov <ivan.ivanov@suse.com>,
        Kalesh Singh <kaleshsingh@google.com>, Marc Zyngier <maz@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <mbrugger@suse.com>, Miroslav Benes <mbenes@suse.cz>,
        Will Deacon <will@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
References: <20241014105514.3206191-1-ryan.roberts@arm.com>
From: Dave Kleikamp <dave.kleikamp@oracle.com>
Content-Language: en-US
In-Reply-To: <20241014105514.3206191-1-ryan.roberts@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0312.namprd03.prod.outlook.com
 (2603:10b6:610:118::21) To MW5PR10MB5738.namprd10.prod.outlook.com
 (2603:10b6:303:19b::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW5PR10MB5738:EE_|IA1PR10MB7386:EE_
X-MS-Office365-Filtering-Correlation-Id: 423e3d2c-0c67-4f2c-69e6-08dceef7d8b3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|7416014|366016|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ODZ1aUVTa3lmR1JQclk1a2JkNjVhTjJWRyt0eXNsejNjczJ5NkcxRkMvTGR2?=
 =?utf-8?B?dUEzY21Yc1VmNGxOZ1ZRTW5jdVc1RENVNkp4dTVlVFFiU3k3L2JNa2Z5NVlz?=
 =?utf-8?B?Y1BVeG5HUnVMMk5JQ0xOcHljbVpUZnYxSUhXMDg5dmpKSHZzY1Z3ZndCWHJq?=
 =?utf-8?B?ZjdwNi9vOVBKNlZQKzdHZG5nT1dUcThsYjlXWXNHVFVvRXRPVjJoY2dSUUg4?=
 =?utf-8?B?cmE5UXhhYjhHV0Fack1hK0ZOQmhsem9wU2hwR0d1SDdRakJMTEVYMEtTOVNQ?=
 =?utf-8?B?eDFJZVV0MGNDYzVxbFc5Z3c5Unc3ZzRFYncxb2tiTEN6UldxeXlYVnhmdUdF?=
 =?utf-8?B?WXVXVVhmb01yTC9KemZkclNwMnFmL2hhbzBhOHBtb0NrSC9mWUVsTjBEVzFZ?=
 =?utf-8?B?eGx2N3lGbGxzNjNKemptNWlSU2FPQjJ0S1FjdFpYRC9FajhqZ0pvQlV1cnYz?=
 =?utf-8?B?NE41dmNQaWZpcXZiVnZ6Y1lXUzVQbW40R0RHUXJEaFV6ZHkxS0x0SythaDRD?=
 =?utf-8?B?d2s4N2lQbkNneVNYamN1a3NqUERrV2lMUDV3NDYvbmxZYzBVbFlHdURRNzQv?=
 =?utf-8?B?YXpCbURjNldoeGNYdHJRS1FOZVRWVWIzQmZoem9OOFIrVkVaSW9OSE9mT1hM?=
 =?utf-8?B?Y2RzeDlHVFY0d0xtSXJyQlpLNnZFbjFleHFWUGxXNUxKTHgyVWRFWEtBRGYw?=
 =?utf-8?B?bnA0bmlubVZZMXFKQVZRTEtJNEFLMWszdmtOUVNlOFBWRDNOUmdGNTJjT2ln?=
 =?utf-8?B?eTVrbzJ1M2pwKzVLMEFOT1g5RHpRNnF5Ulp2ZkFxMlRBSmM0MlRpR09oa0ox?=
 =?utf-8?B?bVJrR3puMDV2cTRzVE44a29qS3o3cm5iQ3BGMW5aQXY4U2hnVitVbTdTaGdO?=
 =?utf-8?B?a1hLVS96MzdCYVFqUTJRaTU2MUhaNVE0Wm5ZaHVRK05SUTNRQUhTMEVXdlYr?=
 =?utf-8?B?L1dBd2dsd1lrZXRVaUdVY1hTbzhnSXV6NU9zejZvZ0lIRWhrOFNyM0U4MEwv?=
 =?utf-8?B?RjMrQ253ZUFSamhsTjVwdXJhVklZc2pXckRmZ2hGUzBhdUlXN0pWOEFSKzcx?=
 =?utf-8?B?VHM4T3VRNjhQZmxVNk5sTTlMS3Ixam52K2RtRDRrVVpUOHZtdmtBcU5CS05s?=
 =?utf-8?B?aTVVaElhV2ZabnR6Q2ZDWWJsUWorZFFUOGJvZnZnb3kraDJWM3JOOXdVTVZv?=
 =?utf-8?B?ODFITnRDYlRjQyszMFY0dGEwSFA0MytCU1huM2tkVW1uWE5UbGdwQzhLZ01o?=
 =?utf-8?B?cXFkNzdaeGRIbGV1bkpjak9CQ09uZDFxTWYxM3Y5Nk04WTBjMXF3Y1ltUk9U?=
 =?utf-8?B?VWtjeU5nS0orOXZOOFVZYjJ3V3BqY3Q0N0VWRUpVc2JBeUljTWpuWmtBUndG?=
 =?utf-8?B?a1ZvOVVTanhGYlYwVDBtTjFpMjZVV3ROekpQZThhNlBWaGQ4QVhSczJQaENu?=
 =?utf-8?B?Mi9tMkE1N3dJQlV6cDVWdGVxenpoTnFGRmpKSS9DdEM3dWtWSVJLZmJPN3BE?=
 =?utf-8?B?c2pmbmtOUGpPVnF2RUd3YnVkTnN4bUJxWUx0ZXZ5N1BhTE56WDhETEZmcEx2?=
 =?utf-8?B?RVo4eDVjTzNlVDFuN0ZxcmFFMytjYm9qdVFwb1gwTkxONDRmVU5KNUtnRjNq?=
 =?utf-8?B?UkNWR0lnaWhnNndVR1lVR0Fsc1J1aDZYZFBsU0hxQWZ6akpXL0UwdUNxblk4?=
 =?utf-8?B?UjZ0dlFjQ2hLNlFMcGxHMkl1TGxob1o2VzdhdmhON2FsSEI0cUd3UTRrQkVU?=
 =?utf-8?B?V1ZOOWxYcEk1R21RaVMvcXVGRUI0NjJTU1hNNnNlbkREVjlxRkpXTjBDRU1Q?=
 =?utf-8?Q?kdx4dt3qHGPrGa3tNwV2iASpxmAa0XrxIv0eA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR10MB5738.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(366016)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?V0k5K0Fza29HOUxuV3BNZjZhZWFhOWpjUmZ5QWQ5RDhGazlBTk5wcDdLSWlR?=
 =?utf-8?B?UDhlK0VWSjhSSUwwRmlEcktOWlZtamlDY1Y0NEtMREFaaUhTQ3FvaytPN1Q5?=
 =?utf-8?B?MmErL2g5WXdtSWpzZEoweDZHcmpmbHQwYXhmdUE4M1ZhN2lYRm9UR3NOUVRQ?=
 =?utf-8?B?M2lHR0tIbjUycEhDS2Jqd1FuZ3g4WGhMSWFQSzVpeG8wVHZOVlNiYWpyWlVh?=
 =?utf-8?B?UnJhZ3Fhd0grSCtkSzNNRGRmVU1aY2c4aWJIcytZTmZUbzg4M3kvTmJYZkta?=
 =?utf-8?B?T2RGbzNqNXF4dFpJSHUzWGNCOUFnUW45WlNoejNvaklFWFNqMStQaTgraWwv?=
 =?utf-8?B?VEFzOExnVWc1bmlkVzRmVDdVUEN6VFRUOGNkSDJxVlNwQlFzUFIzWjViaVJt?=
 =?utf-8?B?K2pHaFpFaVdhQmk1V1Qvc3lIUU02clMxcE92TkZrWXNIcVArRDh0bVZwaUh4?=
 =?utf-8?B?RnNndjNENGp5QURoZEp2eWo5VVpaWnMvMldOWVdvOWpNZkZzdUw3ZmZTNmor?=
 =?utf-8?B?SWg0TXp3RVlPdU5CT3BCTVBYTVpDQjNBYlpodFhGWFMzS0hTdU80UVRIOHF0?=
 =?utf-8?B?aUVyN1V4ZElPU2JpZVlXN2JDVUNvK1hXSVB5aUFrZndYYSszdW1MRDBaRlVv?=
 =?utf-8?B?Wm4zak9LbU1TaVFQU2RMdTdmaWNrMklMVWRVNWpFdWNFVlNURkpBTmFUZENw?=
 =?utf-8?B?dThId0pEdjRveGc2UnBzRCtDR3VDUU1ES1ByL1lURjZOcnpOcmdERVY4dlZF?=
 =?utf-8?B?ZVIvWlFmcm1hNFpKbVEzSnRqVHlnckNKUlRpVm9IdWkrRGg4OHFEOU9WMC9U?=
 =?utf-8?B?cTdIZ0x3dWpUd2NwTEc3alRDN3RKNlNPMDVHVHdTZGRhejRCeldMSjhHTlho?=
 =?utf-8?B?dXlaSEVCc0pMUlJ0dHk2eTlRU2pnK2NaVGRqS3BIRkYxOHgzaEdGUzJPL20y?=
 =?utf-8?B?dmZNVzVoZmZHRzhBeU1zcmh4ZzErTWdKN0hhWVlHeDFPVkxId1lBYjUwdU0y?=
 =?utf-8?B?bHl5MmZXbHJWalVSRUQ3dnJhRW04alJwOXFNS1RNb2hLejdyY29mSStCUXA5?=
 =?utf-8?B?elRPcTRrRlhzYmx6djR5SmpDTzQ1Qi84T1ovbXh3cFN0L2IvcFA0UWFSWVVR?=
 =?utf-8?B?TDhBNFNQUjJNWjdnM0w3VjVoTWZqUHprSEIxMS9Xa05FbzFtZ1cwUjIvUmxi?=
 =?utf-8?B?SU5oU3B4ZzQ2R1RUaU9nTHM3NDluaDB0NmpZM0p6cDRsNzc2aE53Z0ZjbDBi?=
 =?utf-8?B?eHoxeDBUSmFKK09FY1ZValRzb2Vjc3dUekxTRkEzaFIxd0k1TmZ5LzNma21i?=
 =?utf-8?B?T3psUENmdjJweHFLTlJseDd5STBIMXMrNVVBYkcwOThZS2V1VCtMbGtCR1Z2?=
 =?utf-8?B?SWsvMDM0L1lpL29DTVh6UkRaYVpTcWFuNFdRVGZTb1cvVXJFcWs2NkFHVG8z?=
 =?utf-8?B?UTZQOUJndXRlYjFoWllGVnYraVN6aVZkZVdvOUQxMmYra2pLNWdYNUt3dXJz?=
 =?utf-8?B?NkQrSmVUd2lOWGs5M1NxS2ZEYmtzWm0zV2JFcmN4RmNiamUrL2twaUVoN1JY?=
 =?utf-8?B?NDM4NFR3blVZaTRnVUpFM2pzWVM0ZU9paGo3R0d0Z2s1WERKbTlBa3VRenY2?=
 =?utf-8?B?TXpqdnRBbGZvOEpxYkFKaGxndDBvR0d3K0JVSm1TaHZ1L1BsVEoxNXdEUGVP?=
 =?utf-8?B?UTZhMFNyLzJlbVZRV2l1S3lGR2RGUlZ4d0Y2K3k0bTVMWTNEeVZZNjJzMTJV?=
 =?utf-8?B?dGk1ZWFURzZtWDRRSU1nTCswSmEyZVFRV01IOE9uQ0hsVE4wam5wM0RVa0tj?=
 =?utf-8?B?NGVwZGVRdGNHTHlZUUtTcy9xVy9SRm56WWttK0F2OENybjJxckZucERjSzhk?=
 =?utf-8?B?c0VTWEFVMGkvTWdNUXY5MmFTQllDTlBvSCt4UHA1NnlPVHdmRGgwWnkzVjV1?=
 =?utf-8?B?REhzS2ZSVjlhenFzZVkvUko0czU2TlJRdDJLbURZc3NMQVN3eFlraktoUGJy?=
 =?utf-8?B?bG5oZzJRK0VJaE5tR2RnMW9uQTJaVG9VT3RVSXZZWDhMRzdINEVhMnR2TjdU?=
 =?utf-8?B?ckNJc0hJYlRlNDNNSHNmUTFnNGNTSENqMzlmVng1eUdYb2FPTnVPQzhYY2dx?=
 =?utf-8?B?WDRHcnVVNTVVYm9yODFQRTBJNk5oT2lQTXZIMW5ma1N5aUhIVG9rNzRyMHA3?=
 =?utf-8?B?Y3c9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	EqMW+xigL9pqXTKGqPVejwqaUZwafDovDvy5Boh5sBcxRD/jqv5cGExXE/LQa9IVbnj9Vqn8OKPsfvlWW0ae66kfDRpbmKDGG3uTBQP3dN50gqeGHvh62f33giYOKSoRextThIVkRn+08mnlI4AKuCRwJz4UfO6hern7TTLPVOsQ+BfKJJb3Zo2wURRzkEz/pwzvvSrO6hpTqlerqzK9NpI2IH2y7waXXti6KNfnCwkeu6WSdtd/b8FEfW5b5AlVVUal0x9QZBc5DZdlgfQlSyWplbRq1VJrvbsNXM1HdM/GjbNxJzyS0q/dSFTXg4KiVcYxfhF+iXyr+Tx9r8RKpU1wlweEQLLMewIkvzGzi2sY3t6pKrQCpe0V71gQGzupKI0CobeZXJxrizzpL7+ZMHF3OFzH26UjytIvoqpYkSa7VWyPfgZZMo/GA38HtHxRxhng1ajcFq8J558cvYoD+JLxPpTHdLwNqsoviGYKYnjiC97KXn2lytBo+11eOrY5cZ/HobLPIypEz7rozHfjmM9ZLlJuVrULpIgMogtxW6L7/6esvAQj73Z4bIBDwKjehu6vGc6FLRt0mxWZtbzFOCwgrPWbacsFNEC29DN4cic=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 423e3d2c-0c67-4f2c-69e6-08dceef7d8b3
X-MS-Exchange-CrossTenant-AuthSource: MW5PR10MB5738.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2024 22:05:44.3281
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OlmDzViIIV73rVwwnkU4ECbfWRqHnn3CoPlG/zVzFg0x8IXEas1XMdofYh2MMDBHrjt6d+iKtQkGTGnB+paWXCB032zcJIvwMSp9qZam0uQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB7386
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-17_24,2024-10-17_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 spamscore=0 malwarescore=0 bulkscore=0 suspectscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2410170149
X-Proofpoint-GUID: NV61U7JiGFe8QGpluZYSBiHalV_bP-Yl
X-Proofpoint-ORIG-GUID: NV61U7JiGFe8QGpluZYSBiHalV_bP-Yl

On 10/14/24 5:55AM, Ryan Roberts wrote:
> Hi All,
> 
> Patch bomb incoming... This covers many subsystems, so I've included a core set
> of people on the full series and additionally included maintainers on relevant
> patches. I haven't included those maintainers on this cover letter since the
> numbers were far too big for it to work. But I've included a link to this cover
> letter on each patch, so they can hopefully find their way here. For follow up
> submissions I'll break it up by subsystem, but for now thought it was important
> to show the full picture.
> 
> This RFC series implements support for boot-time page size selection within the
> arm64 kernel. arm64 supports 3 base page sizes (4K, 16K, 64K), but to date, page
> size has been selected at compile-time, meaning the size is baked into a given
> kernel image. As use of larger-than-4K page sizes become more prevalent this
> starts to present a problem for distributions. Boot-time page size selection
> enables the creation of a single kernel image, which can be told which page size
> to use on the kernel command line.

This looks really promising. Building and maintaining separate kernels 
is costly. Being able to build one kernel for three protential page 
sizes would not only cut down on the overhead of producing kernel 
packages and images, but also eases benchmarking and testing different 
page sizes without the need to build and install multiple kernels.

I'm also impressed that the patches are less intrusive than I would have 
expected. I'm looking forward to seeing this project move forward.

Thanks,
Shaggy

> 
> Why is having an image-per-page size problematic?
> =================================================
> 
> Many traditional distros are now supporting both 4K and 64K. And this means
> managing 2 kernel packages, along with drivers for each. For some, it means
> multiple installer flavours and multiple ISOs. All of this adds up to a
> less-than-ideal level of complexity. Additionally, Android now supports 4K and
> 16K kernels. I'm told having to explicitly manage their KABI for each kernel is
> painful, and the extra flash space required for both kernel images and the
> duplicated modules has been problematic. Boot-time page size selection solves
> all of this.
> 
> Additionally, in starting to think about the longer term deployment story for
> D128 page tables, which Arm architecture now supports, a lot of the same
> problems need to be solved, so this work sets us up nicely for that.
> 
> So what's the down side?
> ========================
> 
> Well nothing's free; Various static allocations in the kernel image must be
> sized for the worst case (largest supported page size), so image size is in line
> with size of 64K compile-time image. So if you're interested in 4K or 16K, there
> is a slight increase to the image size. But I expect that problem goes away if
> you're compressing the image - its just some extra zeros. At boot-time, I expect
> we could free the unused static storage once we know the page size - although
> that would be a follow up enhancement.
> 
> And then there is performance. Since PAGE_SIZE and friends are no longer
> compile-time constants, we must look up their values and do arithmetic at
> runtime instead of compile-time. My early perf testing suggests this is
> inperceptible for real-world workloads, and only has small impact on
> microbenchmarks - more on this below.
> 
> Approach
> ========
> 
> The basic idea is to rid the source of any assumptions that PAGE_SIZE and
> friends are compile-time constant, but in a way that allows the compiler to
> perform the same optimizations as was previously being done if they do turn out
> to be compile-time constant. Where constants are required, we use limits;
> PAGE_SIZE_MIN and PAGE_SIZE_MAX. See commit log in patch 1 for full description
> of all the classes of problems to solve.
> 
> By default PAGE_SIZE_MIN=PAGE_SIZE_MAX=PAGE_SIZE. But an arch may opt-in to
> boot-time page size selection by defining PAGE_SIZE_MIN & PAGE_SIZE_MAX. arm64
> does this if the user selects the CONFIG_ARM64_BOOT_TIME_PAGE_SIZE Kconfig,
> which is an alternative to selecting a compile-time page size.
> 
> When boot-time page size is active, the arch pgtable geometry macro definitions
> resolve to something that can be configured at boot. The arm64 implementation in
> this series mainly uses global, __ro_after_init variables. I've tried using
> alternatives patching, but that performs worse than loading from memory; I think
> due to code size bloat.
> 
> Status
> ======
> 
> When CONFIG_ARM64_BOOT_TIME_PAGE_SIZE is selected, I've only implemented enough
> to compile the kernel image itself with defconfig (and a few other bits and
> pieces). This is enough to build a kernel that can boot under QEMU or FVP. I'll
> happily do the rest of the work to enable all the extra drivers, but wanted to
> get feedback on the shape of this effort first. If anyone wants to do any
> testing, and has a must-have config, let me know and I'll prioritize enabling it
> first.
> 
> The series is arranged as follows:
> 
>    - patch 1:	   Add macros required for converting non-arch code to support
>    		   boot-time page size selection
>    - patches 2-36:  Remove PAGE_SIZE compile-time constant assumption from all
>    		   non-arch code
>    - patches 37-38: Some arm64 tidy ups
>    - patch 39:	   Add macros required for converting arm64 code to support
>    		   boot-time page size selection
>    - patches 40-56: arm64 changes to support boot-time page size selection
>    - patch 57:	   Add arm64 Kconfig option to enable boot-time page size
>    		   selection
> 
> Ideally, I'd like to get the basics merged (something like this series), then
> incrementally improve it over a handful of kernel releases until we can
> demonstrate that we have feature parity with the compile-time build and no
> performance blockers. Once at that point, ideally the compile-time build options
> would be removed and the code could be cleaned up further.
> 
> One of the bigger peices that I'd propose to add as a follow up, is to make
> va-size boot-time selectable too. That will greatly simplify LPA2 fallback
> handling.
> 
> Assuming people are ammenable to the rough shape, how would I go about getting
> the non-arch changes merged? Since they cover many subsystems, will each piece
> need to go independently to each relevant maintainer or could it all be merged
> together through the arm64 tree?
> 
> Image Size
> ==========
> 
> The below shows the size of a defconfig (+ xfs, squashfs, ftrace, kprobes)
> kernel image on disk for base (before any changes applied), compile (with
> changes, configured for compile-time page size) and boot (with changes,
> configured for boot-time page size).
> 
> You can see the that compile-16k and 64k configs are actually slightly smaller
> than the baselines; that's due to optimizing some buffer sizes which didn't need
> to depend on page size during the series. The boot-time image is ~1% bigger than
> the 64k compile-time image. I believe there is scope to improve this to make it
> equal to compile-64k if required:
> 
> | config      | size/KB | diff/KB |  diff/% |
> |-------------|---------|---------|---------|
> | base-4k     |   54895 |       0 |    0.0% |
> | base-16k    |   55161 |     266 |    0.5% |
> | base-64k    |   56775 |    1880 |    3.4% |
> | compile-4k  |   54895 |       0 |    0.0% |
> | compile-16k |   55097 |     202 |    0.4% |
> | compile-64k |   56391 |    1496 |    2.7% |
> | boot-4K     |   57045 |    2150 |    3.9% |
> 
> And below shows the size of the image in memory at run-time, separated for text
> and data costs. The boot image has ~1% text cost; most likely due to the fact
> that PAGE_SIZE and friends are not compile-time constants so need instructions
> to load the values and do arithmetic. I believe we could eventually get the data
> cost to match the cost for the compile image for the chosen page size by freeing
> the ends of the static buffers not needed for the selected page size:
> 
> |             |    text |    text |    text |    data |    data |    data |
> | config      | size/KB | diff/KB |  diff/% | size/KB | diff/KB |  diff/% |
> |-------------|---------|---------|---------|---------|---------|---------|
> | base-4k     |   20561 |       0 |    0.0% |   14314 |       0 |    0.0% |
> | base-16k    |   20439 |    -122 |   -0.6% |   14625 |     311 |    2.2% |
> | base-64k    |   20435 |    -126 |   -0.6% |   15673 |    1359 |    9.5% |
> | compile-4k  |   20565 |       4 |    0.0% |   14315 |       1 |    0.0% |
> | compile-16k |   20443 |    -118 |   -0.6% |   14517 |     204 |    1.4% |
> | compile-64k |   20439 |    -122 |   -0.6% |   15134 |     820 |    5.7% |
> | boot-4K     |   20811 |     250 |    1.2% |   15287 |     973 |    6.8% |
> 
> Functional Testing
> ==================
> 
> I've build-tested defconfig for all arches supported by tuxmake (which is most)
> without issue.
> 
> I've boot-tested arm64 with CONFIG_ARM64_BOOT_TIME_PAGE_SIZE for all page sizes
> and a few va-sizes, and additionally have run all the mm-selftests, with no
> regressions observed vs the equivalent compile-time page size build (although
> the mm-selftests have a few existing failures when run against 16K and 64K
> kernels - those should really be investigated and fixed independently).
> 
> Test coverage is lacking for many of the drivers that I've touched, but in many
> cases, I'm hoping the changes are simple enough that review might suffice?
> 
> Performance Testing
> ===================
> 
> I've run some limited performance benchmarks:
> 
> First, a real-world benchmark that causes a lot of page table manipulation (and
> therefore we would expect to see regression here if we are going to see it
> anywhere); kernel compilation. It barely registers a change. Values are times,
> so smaller is better. All relative to base-4k:
> 
> |             |    kern |    kern |    user |    user |    real |    real |
> | config      |    mean |   stdev |    mean |   stdev |    mean |   stdev |
> |-------------|---------|---------|---------|---------|---------|---------|
> | base-4k     |    0.0% |    1.1% |    0.0% |    0.3% |    0.0% |    0.3% |
> | compile-4k  |   -0.2% |    1.1% |   -0.2% |    0.3% |   -0.1% |    0.3% |
> | boot-4k     |    0.1% |    1.0% |   -0.3% |    0.2% |   -0.2% |    0.2% |
> 
> The Speedometer JavaScript benchmark also shows no change. Values are runs per
> min, so bigger is better. All relative to base-4k:
> 
> | config      |    mean |   stdev |
> |-------------|---------|---------|
> | base-4k     |    0.0% |    0.8% |
> | compile-4k  |    0.4% |    0.8% |
> | boot-4k     |    0.0% |    0.9% |
> 
> Finally, I've run some microbenchmarks known to stress page table manipulations
> (originally from David Hildenbrand). The fork test maps/allocs 1G of anon
> memory, then measures the cost of fork(). The munmap test maps/allocs 1G of anon
> memory then measures the cost of munmap()ing it. The fork test is known to be
> extremely sensitive to any changes that cause instructions to be aligned
> differently in cachelines. When using this test for other changes, I've seen
> double digit regressions for the slightest thing, so 12% regression on this test
> is actually fairly good. This likely represents the extreme worst case for
> regressions that will be observed across other microbenchmarks (famous last
> words). Values are times, so smaller is better. All relative to base-4k:
> 
> |             |    fork |    fork |  munmap |  munmap |
> | config      |    mean |   stdev |   stdev |   stdev |
> |-------------|---------|---------|---------|---------|
> | base-4k     |    0.0% |    1.3% |    0.0% |    0.3% |
> | compile-4k  |    0.1% |    1.3% |   -0.9% |    0.1% |
> | boot-4k     |   12.8% |    1.2% |    3.8% |    1.0% |
> 
> NOTE: The series applies on top of v6.11.
> 
> Thanks,
> Ryan
> 
> 
> Ryan Roberts (57):
>    mm: Add macros ahead of supporting boot-time page size selection
>    vmlinux: Align to PAGE_SIZE_MAX
>    mm/memcontrol: Fix seq_buf size to save memory when PAGE_SIZE is large
>    mm/page_alloc: Make page_frag_cache boot-time page size compatible
>    mm: Avoid split pmd ptl if pmd level is run-time folded
>    mm: Remove PAGE_SIZE compile-time constant assumption
>    fs: Introduce MAX_BUF_PER_PAGE_SIZE_MAX for array sizing
>    fs: Remove PAGE_SIZE compile-time constant assumption
>    fs/nfs: Remove PAGE_SIZE compile-time constant assumption
>    fs/ext4: Remove PAGE_SIZE compile-time constant assumption
>    fork: Permit boot-time THREAD_SIZE determination
>    cgroup: Remove PAGE_SIZE compile-time constant assumption
>    bpf: Remove PAGE_SIZE compile-time constant assumption
>    pm/hibernate: Remove PAGE_SIZE compile-time constant assumption
>    stackdepot: Remove PAGE_SIZE compile-time constant assumption
>    perf: Remove PAGE_SIZE compile-time constant assumption
>    kvm: Remove PAGE_SIZE compile-time constant assumption
>    trace: Remove PAGE_SIZE compile-time constant assumption
>    crash: Remove PAGE_SIZE compile-time constant assumption
>    crypto: Remove PAGE_SIZE compile-time constant assumption
>    sunrpc: Remove PAGE_SIZE compile-time constant assumption
>    sound: Remove PAGE_SIZE compile-time constant assumption
>    net: Remove PAGE_SIZE compile-time constant assumption
>    net: fec: Remove PAGE_SIZE compile-time constant assumption
>    net: marvell: Remove PAGE_SIZE compile-time constant assumption
>    net: hns3: Remove PAGE_SIZE compile-time constant assumption
>    net: e1000: Remove PAGE_SIZE compile-time constant assumption
>    net: igbvf: Remove PAGE_SIZE compile-time constant assumption
>    net: igb: Remove PAGE_SIZE compile-time constant assumption
>    drivers/base: Remove PAGE_SIZE compile-time constant assumption
>    edac: Remove PAGE_SIZE compile-time constant assumption
>    optee: Remove PAGE_SIZE compile-time constant assumption
>    random: Remove PAGE_SIZE compile-time constant assumption
>    sata_sil24: Remove PAGE_SIZE compile-time constant assumption
>    virtio: Remove PAGE_SIZE compile-time constant assumption
>    xen: Remove PAGE_SIZE compile-time constant assumption
>    arm64: Fix macros to work in C code in addition to the linker script
>    arm64: Track early pgtable allocation limit
>    arm64: Introduce macros required for boot-time page selection
>    arm64: Refactor early pgtable size calculation macros
>    arm64: Pass desired page size on command line
>    arm64: Divorce early init from PAGE_SIZE
>    arm64: Clean up simple cases of CONFIG_ARM64_*K_PAGES
>    arm64: Align sections to PAGE_SIZE_MAX
>    arm64: Rework trampoline rodata mapping
>    arm64: Generalize fixmap for boot-time page size
>    arm64: Statically allocate and align for worst-case page size
>    arm64: Convert switch to if for non-const comparison values
>    arm64: Convert BUILD_BUG_ON to VM_BUG_ON
>    arm64: Remove PAGE_SZ asm-offset
>    arm64: Introduce cpu features for page sizes
>    arm64: Remove PAGE_SIZE from assembly code
>    arm64: Runtime-fold pmd level
>    arm64: Support runtime folding in idmap_kpti_install_ng_mappings
>    arm64: TRAMP_VALIAS is no longer compile-time constant
>    arm64: Determine THREAD_SIZE at boot-time
>    arm64: Enable boot-time page size selection
> 
>   arch/alpha/include/asm/page.h                 |   1 +
>   arch/arc/include/asm/page.h                   |   1 +
>   arch/arm/include/asm/page.h                   |   1 +
>   arch/arm64/Kconfig                            |  26 ++-
>   arch/arm64/include/asm/assembler.h            |  78 ++++++-
>   arch/arm64/include/asm/cpufeature.h           |  44 +++-
>   arch/arm64/include/asm/efi.h                  |   2 +-
>   arch/arm64/include/asm/fixmap.h               |  28 ++-
>   arch/arm64/include/asm/kernel-pgtable.h       | 150 +++++++++----
>   arch/arm64/include/asm/kvm_arm.h              |  21 +-
>   arch/arm64/include/asm/kvm_hyp.h              |  11 +
>   arch/arm64/include/asm/kvm_pgtable.h          |   6 +-
>   arch/arm64/include/asm/memory.h               |  62 ++++--
>   arch/arm64/include/asm/page-def.h             |   3 +-
>   arch/arm64/include/asm/pgalloc.h              |  16 +-
>   arch/arm64/include/asm/pgtable-geometry.h     |  46 ++++
>   arch/arm64/include/asm/pgtable-hwdef.h        |  28 ++-
>   arch/arm64/include/asm/pgtable-prot.h         |   2 +-
>   arch/arm64/include/asm/pgtable.h              | 133 +++++++++---
>   arch/arm64/include/asm/processor.h            |  10 +-
>   arch/arm64/include/asm/sections.h             |   1 +
>   arch/arm64/include/asm/smp.h                  |   1 +
>   arch/arm64/include/asm/sparsemem.h            |  15 +-
>   arch/arm64/include/asm/sysreg.h               |  54 +++--
>   arch/arm64/include/asm/tlb.h                  |   3 +
>   arch/arm64/kernel/asm-offsets.c               |   4 +-
>   arch/arm64/kernel/cpufeature.c                |  93 ++++++--
>   arch/arm64/kernel/efi.c                       |   2 +-
>   arch/arm64/kernel/entry.S                     |  60 +++++-
>   arch/arm64/kernel/head.S                      |  46 +++-
>   arch/arm64/kernel/hibernate-asm.S             |   6 +-
>   arch/arm64/kernel/image-vars.h                |  14 ++
>   arch/arm64/kernel/image.h                     |   4 +
>   arch/arm64/kernel/pi/idreg-override.c         |  68 +++++-
>   arch/arm64/kernel/pi/map_kernel.c             | 165 ++++++++++----
>   arch/arm64/kernel/pi/map_range.c              | 201 ++++++++++++++++--
>   arch/arm64/kernel/pi/pi.h                     |  63 +++++-
>   arch/arm64/kernel/relocate_kernel.S           |  10 +-
>   arch/arm64/kernel/vdso-wrap.S                 |   4 +-
>   arch/arm64/kernel/vdso.c                      |   7 +-
>   arch/arm64/kernel/vdso/vdso.lds.S             |   4 +-
>   arch/arm64/kernel/vdso32-wrap.S               |   4 +-
>   arch/arm64/kernel/vdso32/vdso.lds.S           |   4 +-
>   arch/arm64/kernel/vmlinux.lds.S               |  48 +++--
>   arch/arm64/kvm/arm.c                          |  10 +
>   arch/arm64/kvm/hyp/nvhe/Makefile              |   1 +
>   arch/arm64/kvm/hyp/nvhe/host.S                |  10 +-
>   arch/arm64/kvm/hyp/nvhe/hyp.lds.S             |   4 +-
>   arch/arm64/kvm/hyp/nvhe/pgtable-geometry.c    |  16 ++
>   arch/arm64/kvm/mmu.c                          |  39 ++--
>   arch/arm64/lib/clear_page.S                   |   7 +-
>   arch/arm64/lib/copy_page.S                    |  33 ++-
>   arch/arm64/lib/mte.S                          |  27 ++-
>   arch/arm64/mm/Makefile                        |   1 +
>   arch/arm64/mm/fixmap.c                        |  38 ++--
>   arch/arm64/mm/hugetlbpage.c                   |  40 +---
>   arch/arm64/mm/init.c                          |  26 +--
>   arch/arm64/mm/kasan_init.c                    |   8 +-
>   arch/arm64/mm/mmu.c                           |  53 +++--
>   arch/arm64/mm/pgd.c                           |  12 +-
>   arch/arm64/mm/pgtable-geometry.c              |  24 +++
>   arch/arm64/mm/proc.S                          | 128 ++++++++---
>   arch/arm64/mm/ptdump.c                        |   3 +-
>   arch/arm64/tools/cpucaps                      |   3 +
>   arch/csky/include/asm/page.h                  |   3 +
>   arch/hexagon/include/asm/page.h               |   2 +
>   arch/loongarch/include/asm/page.h             |   2 +
>   arch/m68k/include/asm/page.h                  |   1 +
>   arch/microblaze/include/asm/page.h            |   1 +
>   arch/mips/include/asm/page.h                  |   1 +
>   arch/nios2/include/asm/page.h                 |   2 +
>   arch/openrisc/include/asm/page.h              |   1 +
>   arch/parisc/include/asm/page.h                |   1 +
>   arch/powerpc/include/asm/page.h               |   2 +
>   arch/riscv/include/asm/page.h                 |   1 +
>   arch/s390/include/asm/page.h                  |   1 +
>   arch/sh/include/asm/page.h                    |   1 +
>   arch/sparc/include/asm/page.h                 |   3 +
>   arch/um/include/asm/page.h                    |   2 +
>   arch/x86/include/asm/page_types.h             |   2 +
>   arch/xtensa/include/asm/page.h                |   1 +
>   crypto/lskcipher.c                            |   4 +-
>   drivers/ata/sata_sil24.c                      |  46 ++--
>   drivers/base/node.c                           |   6 +-
>   drivers/base/topology.c                       |  32 +--
>   drivers/block/virtio_blk.c                    |   2 +-
>   drivers/char/random.c                         |   4 +-
>   drivers/edac/edac_mc.h                        |  13 +-
>   drivers/firmware/efi/libstub/arm64.c          |   3 +-
>   drivers/irqchip/irq-gic-v3-its.c              |   2 +-
>   drivers/mtd/mtdswap.c                         |   4 +-
>   drivers/net/ethernet/freescale/fec.h          |   3 +-
>   drivers/net/ethernet/freescale/fec_main.c     |   5 +-
>   .../net/ethernet/hisilicon/hns3/hns3_enet.h   |   4 +-
>   drivers/net/ethernet/intel/e1000/e1000_main.c |   6 +-
>   drivers/net/ethernet/intel/igb/igb.h          |  25 +--
>   drivers/net/ethernet/intel/igb/igb_main.c     | 149 +++++++------
>   drivers/net/ethernet/intel/igbvf/netdev.c     |   6 +-
>   drivers/net/ethernet/marvell/mvneta.c         |   9 +-
>   drivers/net/ethernet/marvell/sky2.h           |   2 +-
>   drivers/tee/optee/call.c                      |   7 +-
>   drivers/tee/optee/smc_abi.c                   |   2 +-
>   drivers/virtio/virtio_balloon.c               |  10 +-
>   drivers/xen/balloon.c                         |  11 +-
>   drivers/xen/biomerge.c                        |  12 +-
>   drivers/xen/privcmd.c                         |   2 +-
>   drivers/xen/xenbus/xenbus_client.c            |   5 +-
>   drivers/xen/xlate_mmu.c                       |   6 +-
>   fs/binfmt_elf.c                               |  11 +-
>   fs/buffer.c                                   |   2 +-
>   fs/coredump.c                                 |   8 +-
>   fs/ext4/ext4.h                                |  36 ++--
>   fs/ext4/move_extent.c                         |   2 +-
>   fs/ext4/readpage.c                            |   2 +-
>   fs/fat/dir.c                                  |   4 +-
>   fs/fat/fatent.c                               |   4 +-
>   fs/nfs/nfs42proc.c                            |   2 +-
>   fs/nfs/nfs42xattr.c                           |   2 +-
>   fs/nfs/nfs4proc.c                             |   2 +-
>   include/asm-generic/pgtable-geometry.h        |  71 +++++++
>   include/asm-generic/vmlinux.lds.h             |  38 ++--
>   include/linux/buffer_head.h                   |   1 +
>   include/linux/cpumask.h                       |   5 +
>   include/linux/linkage.h                       |   4 +-
>   include/linux/mm.h                            |  17 +-
>   include/linux/mm_types.h                      |  15 +-
>   include/linux/mm_types_task.h                 |   2 +-
>   include/linux/mmzone.h                        |   3 +-
>   include/linux/netlink.h                       |   6 +-
>   include/linux/percpu-defs.h                   |   4 +-
>   include/linux/perf_event.h                    |   2 +-
>   include/linux/sched.h                         |   4 +-
>   include/linux/slab.h                          |   7 +-
>   include/linux/stackdepot.h                    |   6 +-
>   include/linux/sunrpc/svc.h                    |   8 +-
>   include/linux/sunrpc/svc_rdma.h               |   4 +-
>   include/linux/sunrpc/svcsock.h                |   2 +-
>   include/linux/swap.h                          |  17 +-
>   include/linux/swapops.h                       |   6 +-
>   include/linux/thread_info.h                   |  10 +-
>   include/xen/page.h                            |   2 +
>   init/main.c                                   |   7 +-
>   kernel/bpf/core.c                             |   9 +-
>   kernel/bpf/ringbuf.c                          |  54 ++---
>   kernel/cgroup/cgroup.c                        |   8 +-
>   kernel/crash_core.c                           |   2 +-
>   kernel/events/core.c                          |   2 +-
>   kernel/fork.c                                 |  71 +++----
>   kernel/power/power.h                          |   2 +-
>   kernel/power/snapshot.c                       |   2 +-
>   kernel/power/swap.c                           | 129 +++++++++--
>   kernel/trace/fgraph.c                         |   2 +-
>   kernel/trace/trace.c                          |   2 +-
>   lib/stackdepot.c                              |   6 +-
>   mm/kasan/report.c                             |   3 +-
>   mm/memcontrol.c                               |  11 +-
>   mm/memory.c                                   |   4 +-
>   mm/mmap.c                                     |   2 +-
>   mm/page-writeback.c                           |   2 +-
>   mm/page_alloc.c                               |  31 +--
>   mm/slub.c                                     |   2 +-
>   mm/sparse.c                                   |   2 +-
>   mm/swapfile.c                                 |   2 +-
>   mm/vmalloc.c                                  |   7 +-
>   net/9p/trans_virtio.c                         |   4 +-
>   net/core/hotdata.c                            |   4 +-
>   net/core/skbuff.c                             |   4 +-
>   net/core/sysctl_net_core.c                    |   2 +-
>   net/sunrpc/cache.c                            |   3 +-
>   net/unix/af_unix.c                            |   2 +-
>   sound/soc/soc-utils.c                         |   4 +-
>   virt/kvm/kvm_main.c                           |   2 +-
>   172 files changed, 2185 insertions(+), 951 deletions(-)
>   create mode 100644 arch/arm64/include/asm/pgtable-geometry.h
>   create mode 100644 arch/arm64/kvm/hyp/nvhe/pgtable-geometry.c
>   create mode 100644 arch/arm64/mm/pgtable-geometry.c
>   create mode 100644 include/asm-generic/pgtable-geometry.h
> 
> --
> 2.43.0
> 

