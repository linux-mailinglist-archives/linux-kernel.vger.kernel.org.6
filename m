Return-Path: <linux-kernel+bounces-437826-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5D319E993D
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 15:45:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 859F51675F6
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 14:45:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 149BF1B0428;
	Mon,  9 Dec 2024 14:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="NsbQ7FIN";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="k9FDIjqK"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C44DA3594A
	for <linux-kernel@vger.kernel.org>; Mon,  9 Dec 2024 14:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733755547; cv=fail; b=Vaf4e9e2L2cZIpSQMWo0KJcBlUx3uwRdxzleSwCQ/xv+ix78PgY1JpQSuP/OiUTkGhhqBsS4AaVwe7NfhSZVoksnWt76GZpnmoYeDpHSiIoBD91NZD+rfrkoZYB42iiXIvKJN5DY1FNuwwrcXJKDupN8zvRvJeRX+TTLda4L0HQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733755547; c=relaxed/simple;
	bh=BFM5iMxhP5PcQG3U73qVSEwuR2OvbbXoZQ2gHSVf05Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=VeCLl2xKanqew08+O0SRnXs/aC/9g75UfJnqsJD1Eh+UAr/wgr1eBN8Z8vg/iQaIdQjAWa3g5sivBMl4LpCKInyYx7gkYa73bVzFWxfSXGFDYaHXXkrOWxHGPm7AN/ZQ22szzzuNZnhbHrWIHQat8j+jikRGhKwTyOEGUh9bbsc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=NsbQ7FIN; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=k9FDIjqK; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B98fsF4019838;
	Mon, 9 Dec 2024 14:45:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=uF4LF12weFS1C/Z9/byAP7r+Fs0czjJg20P3k6OKjFc=; b=
	NsbQ7FIN1ZtBxyBmyAEAfqhicUmZKNUgalYSwcHD1gmlp4CMf10rF5et7eHCwua9
	jaP9XFZ9AwCLTBO9EiPiYWoNj7EzvaQHhtLwsfyy9CyxFpCozMYBsyBTULkP5WOx
	GdhEREBKLdlnjQ7HENTYbC9k0zk2STs3AcDut4+id0fxU1pow/BsrNFEOrhEtgUd
	S1Dvx5jrvFl5twSJMXldlSM3NmHyoFsWLo6d5rl4GC6sZA2YzxSTlBFtZpQIS2Ji
	T5U6jFT/rhebxx2+Q0dgc69tgFaArYIyKU0k694uCtUyoJ/BIcWbqW/VFGw7uDtZ
	yx2QO2iaz5ji8QVpZq34zQ==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 43cdysucrf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 09 Dec 2024 14:45:34 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4B9EVaGs034928;
	Mon, 9 Dec 2024 14:45:34 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2046.outbound.protection.outlook.com [104.47.58.46])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 43ccteep94-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 09 Dec 2024 14:45:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BlH7uan1EyLAGPyXIBrP+/c8/iTDXNcxzhVKxuOJy/zhbPw+ZaRDZ5cLT3Cd4VEGa11oxpEbooA/azGGibfYPQ9xTp7TOWWtE9bbSIhX9w9gQpCmBxY/VpmkwwAXTYWqdKtkkRW1xArmOcmf2/zirbNFeNqoR9OLDTEXUh7kzpeg4C+HTLVl1Ngnj8BNxW1UPTeefRQhpiBp10c6dBXr/eUO4c/vap3xu8cWCn+RvjnH+1FvSow1oHlBZkBYMyQpmY29ss8UwmhZhLqpYEctJsnTzrP7w8e6aQ9QdxMRIFctGYNwknjftoSblEP+guoOveCPynSLJKXmQACDlBIZzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uF4LF12weFS1C/Z9/byAP7r+Fs0czjJg20P3k6OKjFc=;
 b=WX0L7cDVaLqo+o4QqY906fqQp+5IuZkDCBzMzWP/EhNxHN4WRkJqC7ehPtOxnfi5xhkmRqs5IL6PjP8Jh2fSAVmRfBtqjX/ngZqF9v/xW4JLDykUx18Aw+SJi3kHiRANlfDdwXAlWp9cGiZunTUSHypbUmmEsZaVdYfyyaMEaKIZhPicSU3x09JAh2V9FKocucnNFNrk7rBIQAQUN9N0BYVaB+9URqPwQD1mvVuA10aBhA8OzePDBnyyi53SGq8OEpunx1ytGvER+E+a+grKtkOt7a86ZElIMUVe/8Y94fih9SFDTsIPjvm1c1JXh2wkWdlQ2C8LPGMBZthn1FjjQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uF4LF12weFS1C/Z9/byAP7r+Fs0czjJg20P3k6OKjFc=;
 b=k9FDIjqKt7WETLjb78c570ZEtO2wShUcPPYlYH+JmRQG/wstI1ywUb3rT+nhNi1AhiJVCGV9w0QgHqEYG6cdAHWZcUb7w9x6ZJ9a4YoUa76XegpxNmBmUgylqlZtA41yMHdUX3lG5S5JLkUW8vTgy0GstACtmh3WVSo3+omHdIM=
Received: from BYAPR10MB3366.namprd10.prod.outlook.com (2603:10b6:a03:14f::25)
 by SJ0PR10MB4816.namprd10.prod.outlook.com (2603:10b6:a03:2d3::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.12; Mon, 9 Dec
 2024 14:45:31 +0000
Received: from BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9]) by BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9%7]) with mapi id 15.20.8230.010; Mon, 9 Dec 2024
 14:45:31 +0000
Date: Mon, 9 Dec 2024 14:45:29 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Jann Horn <jannh@google.com>
Cc: David Hildenbrand <david@redhat.com>, Vlastimil Babka <vbabka@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: group all VMA-related files into the VMA
 section
Message-ID: <81fc4cd1-55f4-4569-aef7-0b0da9684fdf@lucifer.local>
References: <20241206191600.45119-1-lorenzo.stoakes@oracle.com>
 <23d3d7f6-d6d1-430e-8ea0-ccae76b253fd@redhat.com>
 <41a14051-75ee-4de3-863c-d0532aa7e3aa@suse.cz>
 <1e4c3e31-ea9a-4af4-83f9-15a882732e69@redhat.com>
 <71beb3d1-21ac-4037-8363-6484c0c333b8@lucifer.local>
 <CAG48ez2s2mY83uce9mGUgc61_50nOp9VPJKLHMtyRYTTeKpo=A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAG48ez2s2mY83uce9mGUgc61_50nOp9VPJKLHMtyRYTTeKpo=A@mail.gmail.com>
X-ClientProxiedBy: LO4P123CA0604.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:314::13) To BYAPR10MB3366.namprd10.prod.outlook.com
 (2603:10b6:a03:14f::25)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB3366:EE_|SJ0PR10MB4816:EE_
X-MS-Office365-Filtering-Correlation-Id: 79149187-a504-477a-b255-08dd186021a0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RVQ0TTZwd0ZEUXhQWDhsZVR3MTJUUUs0RHArcXhlOGJJMEFFdVBOY0hOM2NK?=
 =?utf-8?B?YjF3d1grUSt3Z0Zlcm1XazRaVVNQNXEyMHNORWRzWTFLUy9RY0toMlY5R2Ju?=
 =?utf-8?B?ZlVUOXJ4SnZyeHZtWGEzUEpTZDdhTy9VTkN0ZWE5OHVuNFJnUDd2M0RiVnRH?=
 =?utf-8?B?WXNvbm1LajMrSGY0Si93V05mUkh3dk81TWVTSXhvK3Z6MmoxYmJIK25jZWZw?=
 =?utf-8?B?eGFLZ0I5WlI5QnU2bTNaYkRuTUFGaFcxQVBZbGthTDJUZ0VwWXdLVmxtK0pJ?=
 =?utf-8?B?MXBxTGNtZVI1UVhiR2NiS2Nvc3BaTjIzdkkxaXdOVHdxMmRMN096WUxjRWMx?=
 =?utf-8?B?Qm9lT2NkeURqSFY0alZjajNnNjdGNGFtZFNYOVB2MDVCd1F4NXVJVUxqcm1G?=
 =?utf-8?B?c3BmaWp3eHJleFJOL3Yvd2l6YUR4dmFsVU1YYVg1M1p3UGZwcjRRKzNmeXNF?=
 =?utf-8?B?c0U2NWNtTFQ1VWtvOGp5U3F0RW1yYVFFNXFDeUlrK2V2bTE3R1BnT2dmaCta?=
 =?utf-8?B?ZWRCbmhIQmc5MGdFb0FPR0RzZWV1c0Uya0JSN05vQWR2U3IwSzQ0UWZKaDdV?=
 =?utf-8?B?R0xuaGNvTEV0YVVENzBIaW5qREE3dDRmdzhhUVBIY1dYOTlWR0ZTaTF6N1V1?=
 =?utf-8?B?SzEweXpuTHArOXg0MGpqZ2wyalQ5VkRWWEtRc2QzcnhRRU1wZDZ0SStUZXI1?=
 =?utf-8?B?cjNCd29VK1lmVU0yYmtsSkVwSmFmZkRNSVhBMTh0Nm9HTmQxbHJEM0xFeFB6?=
 =?utf-8?B?YiszcG11T1VIL3lhMWlwZkp3VGVXOGdNbDBPZmI4R09meXR5UnRHem14eEZE?=
 =?utf-8?B?bUtLbkRwMXZMVTJMZDM1LzBXZjlpTWoyc2R4cjBZZGcrUzdaR0NESWl6MnB5?=
 =?utf-8?B?dDJHWWhhdlJSbUZsTU9lOVBlUEVpYi85Z2hBY2FlYzg4bDhFK0FnWFhacTVM?=
 =?utf-8?B?TnVHSVhsS2luRzJ4d0M3bk1lUmVSVCt5eHZBdHpjWFlobURCQXZqUFZhV1JD?=
 =?utf-8?B?Qzd5a29wZWk4MDAzWVhwVmZObDdUT3ZrMngwSXpKTkRNUlFyK0xiYVU0RHNo?=
 =?utf-8?B?K3lKcGpZWnFpUCtyOU5SS1dZZFBBRnRJbFVNTVBJelVSc1FNelpZNFA4U3Ni?=
 =?utf-8?B?bEhTMHd4dUFWazJpMVhTWGlmVlZsUFBzWGtyOGExRS82Z0M1elIwNGVORjRY?=
 =?utf-8?B?UW1wNVNRdytuWGtNbHZJaW5OcUxDczhqdU5KcjMxd3NOY2xwNmVLeG44OFN4?=
 =?utf-8?B?WDlmTG9JQ0ZmdGNneUM3NzZTRG1nRktHWEtFaEVTL0NhM000c1RkOW9oQTNP?=
 =?utf-8?B?SlNzS2pnaGUwTitwYUg5MEhzTVpmcnhlaDcyL0ZtdHBHdDgwQmtzajdHU2Z0?=
 =?utf-8?B?elRjVFpCaE9NRS9GZnRyYkQyS0svUHc1Rm1XeUZWWlBEWTR5K05jWjd1c1Rw?=
 =?utf-8?B?TGNDMy82Y0FMSEp4dWpiWDBkWTBkdXAvNkxGbExPbVVBa1V6YUFaSHA5OW10?=
 =?utf-8?B?SlprY3VYODdRZ3BTOS9VL2F0RmFrTSszeDB6ZGwyWE5GSHlmS2xHRy84NnlK?=
 =?utf-8?B?UUZqZE92eU9ELzRoTHZEWVVaVzNtTVFCNVZENVNheS8zRjBnMnhxZzdNQitQ?=
 =?utf-8?B?bDBNWUFjb1pCTnIrVHo1bG94dFpJSUFXUVhGU3FRc1JHRGpXN0p2dDVxeW1m?=
 =?utf-8?B?K0NmUmJKdTBrUk5MeUMvM3NOZTJNUklLOUxrQVNOMUxKUFhTa28xM05NeEF0?=
 =?utf-8?Q?LfZ3bE+nNOicmgzVOk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3366.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?U2JCTGttQTYyMnF5Q1hncnF3YlR4QnVoSnB5d1FjK3lJTk1wZkgvVXlWZnZ4?=
 =?utf-8?B?UC8xcHBFUWF1L05FcUE1aW90Sk5WTHdKclB6QUx5S0xPaHUyTm5obDVrc0Nz?=
 =?utf-8?B?MW1kZ01maTZSRWZMYm5LRTUyVlNJK1BHd2ZGOTR2UnlpeSs5TEZiQ0oyZFNi?=
 =?utf-8?B?RVpEWmVuTXU0dndKKy9EZFYwaUI0RHpGdkQreFh1YkVBM2JtZ2lWMWdKVCt5?=
 =?utf-8?B?bmFsZy9qUE5MVHBrV1NvdXp0QWRscjZsU0lnNlBnQm9TbFVta1B4bW9IdWhl?=
 =?utf-8?B?SEF1MUtTU1JRRlRGUmlUTUZRSEZGK1kzanJFUHJjZXFDaXFiQjJRVUNmZmtI?=
 =?utf-8?B?YmNTL1BBY3pHVVVkaGNmWXdEV1Buanc4MWdDNnZ3c1VxNkNlSFVuOG9BT010?=
 =?utf-8?B?UWNCRUYyL3JTV2pvTWoreG9KMWhwcngya3pqZlFSeUM2Y01uWEszV0FQTjlI?=
 =?utf-8?B?Smp1ZDBzekUydTBWZlJIcE9QZmd4M3RuYnBZRnRiNEE5RzU1dWd6ZjIybGwr?=
 =?utf-8?B?T1kzcWROL2U0RFhlUThQT0czcTVGTHBBbjdFbS9BYThlY2RQcUF6SzczLzhF?=
 =?utf-8?B?aElabDJmNXI5YVZVUlphM1lQeThDTE5Gd3drTUc1RnNOUGZveUZ3ZHFOcFZU?=
 =?utf-8?B?eEgrdEE1UkowaTdNU0VnYzEzYkxUVldIS2VIeldsWTVkSjRUaEd5N3lIM1gr?=
 =?utf-8?B?VmxUUHB6SFZvUEpqc1ZxQ2tpYXV6TW9QMVQ1VXhvRU11dGc3MGM3V0JoOHR3?=
 =?utf-8?B?Wk5yYTZ6OTlZMG1hUnk0ZkpIMHo4THBJdE9ld1QwTW9Ca284c3NjUjZCdFBH?=
 =?utf-8?B?Qm03ZmtxazdSMWlwdzQ4WnVIUFVIMWFjeVE0L1hMODd0NExsamlLWkdvcXdo?=
 =?utf-8?B?VDlGMkVxZ0RzR2ErU0JMVXlEM255aWV5d2YrTWQra0FLYjhveE9iWTlmN2oz?=
 =?utf-8?B?ZUNuTkx1Q0FEajF2bkRzc0Q2RnJ1OVlnM2R1dFFNVlZuOGhhUmJkZVlUbHAr?=
 =?utf-8?B?KzYrR1JNbzNnNkdORHZyOE5Yamh4dzZoMjdhTzlsdVVjYXY2S29ndXZrZmNo?=
 =?utf-8?B?NFNHcWZTVHNONE1vWXdZd3lUem5LUDBMYkY2Q0FzVEU4NjMrRGdmTGtCVGtY?=
 =?utf-8?B?Z2xlWGhyeXRsUy9iaXY3M1YzNnFqL0JHcjVFWnlDTm1kMnlRbWpLcFVQNm13?=
 =?utf-8?B?Y3FmL1N5YStuNnpGTXBJOXNuNEVQMVRHdVJnVHgrNVhzZVZvbi9XQzMrWkdR?=
 =?utf-8?B?TUtkdnlCd3VrWVI0NGl6cGs2UFVtTGc4R1RKYTQreWxGclQ5d3pXdVFNQjR1?=
 =?utf-8?B?cWIvWVV6UVhLc1gwb0o2eWU5YkM4TUhGcTUzaGJNV284cmhhUFQxUTVVSVdW?=
 =?utf-8?B?YmpxSTI4b1MwaXIrQnEvSmszY1hKVXJ5dS95ckFEUW5kWkhDVVlpQUNqN2tT?=
 =?utf-8?B?cDNCcE1wNHhKWGFKYXkzbCs2eE10WC9kTi9PSGZKYlBtTTFmeUtDM3NwRjly?=
 =?utf-8?B?UitSOWc2eUZsQ3JEYVRsdnZVdERpNDV3QXQ0VWxmR2ZSeXF6SEJvV0lycTIv?=
 =?utf-8?B?MStSTS9XWDZreWxYNzNpMHlMMFo0YlhFWkg2emk5RWtPWTFYMDkwVGtUeVBW?=
 =?utf-8?B?aCtSTkFMWVQ5dldHMGZxMlJPWVpGSmRDeTZCVkl6U0RPdlRVaWVlZ2oxZFBI?=
 =?utf-8?B?bm5XV3NvR09zMWtOZENhaXh0bTlZTDJoV0QvSXUyRldUYlFYU0ZQUTZ4UUg3?=
 =?utf-8?B?R0J5cUFWb21UYUhQdGd0QkhXRDhMQ0dkSGtzMWovUTdraGVvb3dFWTRqWXF5?=
 =?utf-8?B?M1dzak9sR2FlT2VYODZyN0hvNVpvVUFIZllrUWNidHliM2pWT3pQbng0eWl3?=
 =?utf-8?B?WG5ZRkViMWUycDNidUZaWG5XT2UyVWZwWEdhWWFHS2JDTnJqa29Zb0hpSGdJ?=
 =?utf-8?B?bDNKRVhXdEtqL2pGa2UyTlcvMHMzbkFYMDUrTUxIU0xrQUgrK1NPcDVsSnZa?=
 =?utf-8?B?L0E1R0VXTi9ZeUFlY2Z6T0tLUXB3Q0JWTmZsUWF6RVdmV0Vpa2FpeENTK2p1?=
 =?utf-8?B?bkpEMkFUOExHTWs5MDIraFc1bnRJdU1RZjFaaGZ2VFpTV0ZKN2EwWGJ4eTBp?=
 =?utf-8?B?akVXRWt6cm9CeVlzd2tvQjdKeSsxMGkycFhSem51aGFFbS82a0grT2VQSTNv?=
 =?utf-8?B?clE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	M+N/R2hRrbHKUwBkyogHqKicbbKWDHR5eDpAnxHqwXCQ0Dch/hp+w/4MYDQrhAgbzlj7pvTZw1mFXSFu3Mz3dKJ3qlsT4lSvnSL55qRL0rLeDex23GH/y7ERQrTQcWoS5zFjDlIrHZ7lhebs792mUQI9Hf/0hpHXJaFRFs7OE6Lxji/zqFz3Lvl2XqLjmJPnfFepW2mJv8/udNv/iRpx6Z8e5u+Spz/JcFqNnX9LkNEsI+wWCcfKwCxuSqyPr4SS4LrSQmnrBVNC4z3KedGc7JicCr7Xssrs163xhIbaqgQX1lsFm5PjpgJAQbpqlf0osc2M+jGE6AKhrexpOw7YiFUpgIhnpc9/HbYtei0KFropduGSeWRc6ziSGcWeEPOb9VAVHlfNDw8iCATGMhGwHyTBHNJTRIIVoxBARE3D8JFuUDE8726PqQno0ADj9lrY/KW2dEYA278IkO8mvzpxHligV8NHi5RvLPmxQFHCGx89mI4CPytgndcqGHcvAFWV8CpRqsYNWrywAFRJqmK0qXfbVs2LQB+IQCL2pr6uLX7qQ4jEWiYY6NqOgdxM2ROOV7j+QvbBeP7JMkt6OZX7hc3GMVRWp+fAASJ3NIwQo7Q=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 79149187-a504-477a-b255-08dd186021a0
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3366.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2024 14:45:31.8724
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LO4RHJvO3xgP8YLylQel58hItk5a1IjOX6NInkPSNdASW2LSFaHMcBPl5gWMvhOfZjyqNK3vEnrXNZc+GwQnPuX4ckZvOw2qKGzUDKHklH8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4816
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-09_11,2024-12-09_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 phishscore=0 malwarescore=0 suspectscore=0 spamscore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2411120000 definitions=main-2412090115
X-Proofpoint-ORIG-GUID: qwrmxcTp2jbGCas0GuEj5ym4i9UEmmFN
X-Proofpoint-GUID: qwrmxcTp2jbGCas0GuEj5ym4i9UEmmFN

On Mon, Dec 09, 2024 at 03:38:28PM +0100, Jann Horn wrote:
> On Mon, Dec 9, 2024 at 3:11 PM Lorenzo Stoakes
> <lorenzo.stoakes@oracle.com> wrote:
> > On Mon, Dec 09, 2024 at 03:00:08PM +0100, David Hildenbrand wrote:
> > > On 09.12.24 14:25, Vlastimil Babka wrote:
> > > > On 12/9/24 10:16, David Hildenbrand wrote:
> > > > > On 06.12.24 20:16, Lorenzo Stoakes wrote:
> > > > > > There are a number of means of interacting with VMA operations within mm,
> > > > > > and we have on occasion not been made aware of impactful changes due to
> > > > > > these sitting in different files, most recently in [0].
> > > > > >
> > > > > > Correct this by bringing all VMA operations under the same section in
> > > > > > MAINTAINERS. Additionally take the opportunity to combine MEMORY MAPPING
> > > > > > with VMA as there needn't be two entries as they amount to the same thing.
> > > > > >
> > > > > > [0]:https://lore.kernel.org/linux-mm/CAG48ez0siYGB8GP5+Szgj2ovBZAkL6Zi4n6GUAjzzjFV9LTkRQ@mail.gmail.com/
> > > > > >
> > > > > > Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> > > > > > ---
> > > > > >    MAINTAINERS | 19 +++++++------------
> > > > > >    1 file changed, 7 insertions(+), 12 deletions(-)
> > > > > >
> > > > > > diff --git a/MAINTAINERS b/MAINTAINERS
> > > > > > index 1e930c7a58b1..95db20c26f5f 100644
> > > > > > --- a/MAINTAINERS
> > > > > > +++ b/MAINTAINERS
> > > > > > @@ -15060,18 +15060,6 @@ F:     tools/mm/
> > > > > >    F:   tools/testing/selftests/mm/
> > > > > >    N:   include/linux/page[-_]*
> > > > > >
> > > > > > -MEMORY MAPPING
> > > > > > -M:     Andrew Morton <akpm@linux-foundation.org>
> > > > > > -M:     Liam R. Howlett <Liam.Howlett@oracle.com>
> > > > > > -M:     Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> > > > > > -R:     Vlastimil Babka <vbabka@suse.cz>
> > > > > > -R:     Jann Horn <jannh@google.com>
> > > > > > -L:     linux-mm@kvack.org
> > > > > > -S:     Maintained
> > > > > > -W:     http://www.linux-mm.org
> > > > > > -T:     git git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm
> > > > > > -F:     mm/mmap.c
> > > > > > -
> > > > > >    MEMORY TECHNOLOGY DEVICES (MTD)
> > > > > >    M:   Miquel Raynal <miquel.raynal@bootlin.com>
> > > > > >    M:   Richard Weinberger <richard@nod.at>
> > > > > > @@ -25028,6 +25016,13 @@ L:     linux-mm@kvack.org
> > > > > >    S:   Maintained
> > > > > >    W:   https://www.linux-mm.org
> > > > > >    T:   git git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm
> > > > > > +F:     mm/madvise.c
> > > > > > +F:     mm/mlock.c
> > > > > > +F:     mm/mmap.c
> > > > > > +F:     mm/mprotect.c
> > > > > > +F:     mm/mremap.c
> > > > > > +F:     mm/mseal.c
> > > > > > +F:     mm/msync.c
> > > > >
> > > > > Not sure about mprotect.c, mlock.c and madvise.c, though. I'd claim that
> > > > > the real "magic" they perform is in page table handling and not
> > > > > primarily VMA handling (yes, both do VMA changes, but they are the
> > > > > "easy" part ;) ).
> > > >
> > > > I'd think that moving vma files into MEMORY MAPPING (and not the other way)
> > > > would result in a better overal name, that would be a better fit for the
> > > > newly added files too?
> > >
> > > Maybe. I think vma.c should likely have a different set of maintainers than
> > > madvise.c and mprotect.c. (again, the magic is in page table modifications)
> >
> > The bulk of the logic in mremap.c is related to page tables so by this
> > logic then, that is out too, right?
>
> FWIW, I think technically you can have multiple entries in MAINTAINERS
> that cover the same file, maybe that would make sense for files that
> belong to multiple parts of the kernel? Or maybe I'm making things too
> complicated and it'd be simpler to have some kind of more generic
> "core MM for userspace mappings" entry or such.

I think it's faintly ludicrous to separate things on the basis of whether
they explicitly manipulate one part of the kernel or another, and it'd be
an odd thing to be trusted with one 'portion' of a file based on some fuzzy
sense of which bits are 'magic' and therefore out of bounds and which are
presumably not...

I don't think it makes sense to separate the 'VMA' bits from these files
other than perhaps refactoring things a bit (badly needed actually).

The page table manipulation very sorely needs improvement and
de-duplication, I am somewhat taken aback that it is thought that I might
not be able to do so given I had already paid serious consideration to
doing work in this area based on guard page work (not sure if that work
would now be welcome?)

To me I politely disagree with the assessment made here, but if a senior
member of the kernel objects of course I'll withdraw it.

But yeah I don't think that's workable. We will just have to hope that we
notice mremap changes that might be problematic going forward, I might
therefore update my lei settings accordingly...

