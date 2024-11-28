Return-Path: <linux-kernel+bounces-424988-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 427669DBC20
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 19:21:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ADF062829A1
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 18:21:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 460ED1B415C;
	Thu, 28 Nov 2024 18:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="GDOrKLNq";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="LMINqTZn"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22723537F8
	for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 18:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732818075; cv=fail; b=W0iRIQcwUYJ1pmB7C3ih+35FZTls8WuqMDWcIWvMj4RfoVBd/ctNXph1ODTlglVI7AqfcU29tFw+XJUDEk/g6R86XUqTOFdl5ebmZLXweMq+4c8hnxbOjoYJIV9ueGSrq3h8J+/NobAVFj3TligqxIfKcqL/i6peDAXBAaQAnv4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732818075; c=relaxed/simple;
	bh=j7ouiq73k+ahuhdgl6yVMDsjPlX2dOSmFP5rIxvKyz4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=skxPgs9nyjRS++eRKpFuGSfMVgtaFddUVJrJEn6gXLY2tTLmlkM5yAW13VDWVRSDsR9MvvDjHmqb8T/f823U5MWcfykIUGHd+66jdyimLTfbRwP8vBiYJ4Ah2GiQC+lVWZOygxZjK/784BZpbZy3q/UCBy89tkX/gzJwgZhDi18=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=GDOrKLNq; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=LMINqTZn; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4ASEHaMR015074;
	Thu, 28 Nov 2024 18:20:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=j7ouiq73k+ahuhdgl6yVMDsjPlX2dOSmFP5rIxvKyz4=; b=
	GDOrKLNqzC4ASamoit6cnRkEm+NzgpgOEmiPLBPpdfKyTroq9Cz8UD1GtmTbMrfN
	goW6M99m/tua0T7wt0QNxkHF8xexx7AIOBc6AjuN0HmL7mqiFZe/0cU1JHWlI8C6
	lgv180neZoRuEN3nVy97L2vWMcP5rCwgsDPLt/IgLZFYdw3fkQFEljhhyO1LhiuC
	YSNsE/CUZBrf8DKtCBq2rNzNHfr1Eoa2G7GJ3AjHEI2dkclbfd1KT29pJK8xUtWZ
	NpCLkyh5wK0UvI97AADraqzn6g7QZ1c50YSbyeJSnKtZKYXYqrB3Hx9tFAyp7NTI
	ydu34++0YkfoK5ifj0zR4w==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4366xx27sr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 28 Nov 2024 18:20:58 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4ASG9r47022488;
	Thu, 28 Nov 2024 18:20:58 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2048.outbound.protection.outlook.com [104.47.55.48])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 436708n4m4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 28 Nov 2024 18:20:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rtOay2OKFc1UHcg4ybTY/fzLeoTUzQzG2fNJq7fxjeoU9NFySB5k2v1WJTmXgiX0QPcifZthxZYJziEkUOXlQdcWsJcvDvnUMPBugG2cgEtz+ElRVhIpQG+kU1KKtyB19FXA2sRULMfF0LGifTKvzt35dPr38fmWEPDG1D2FOrfBur3hygOMCLFTwVENYCAsWCp34TLuXnDAtaV4IQlxOtzKXb3fiJ2lm35hIzLl5kSJW5I973EzWQzjdwWS9I6MxtWTY0+4v23eWWG9xyG9y65qwkXMh7XQ3uL2K2tiQAnOLlKr6PoibnyY4q8BD8sGI1upkDhwpYCXpO5s7iel7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j7ouiq73k+ahuhdgl6yVMDsjPlX2dOSmFP5rIxvKyz4=;
 b=vBBWu9HgbLE3RzIuVARu7q//XSopjIfDwNwj8m5hzBp+JDWvgMH5Cupc0t+6n2rtl0wkCcLb5oA1RvznXhmv08HDPDGA+fBJnQAo/yVsr4wREdgT7G2fVmTwL2odD07YSO3w7iGftEwJOiobNK4rZeMsc6ASvdQzf8UuWCPGCV9t1a+8yt/uNNXX8+kD4Ud99Ix5C8vFneiNdv1FF8n9ln4c+oeu5IDbLGGnjXekWiN1zAlLp7wjmFvj1Cdeq6dIjVTszh+gUPVaWwejKnwkWJxR90ouZErTYEWEfZ95tkUSWYE9IphwRPpZiA06G6WiPOLGhCWZstDip/UoE/Tvdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j7ouiq73k+ahuhdgl6yVMDsjPlX2dOSmFP5rIxvKyz4=;
 b=LMINqTZn0hdrwRVJt5V96jgFcAHrhy9SPZFpCmac08sVEI2uyEtatOjiwPdFkHSU5OEpfMWfh7P+eHT9x0bkFXyLfhMNlLcQL9Mu728ur69tfZ9hg4bd+sN3ZgVSXG05KIoRkk2akmyQK3l/voGcUwY2unx7YnoOERibEpJyJkI=
Received: from BYAPR10MB3366.namprd10.prod.outlook.com (2603:10b6:a03:14f::25)
 by DS0PR10MB7510.namprd10.prod.outlook.com (2603:10b6:8:166::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.13; Thu, 28 Nov
 2024 18:20:55 +0000
Received: from BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9]) by BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9%7]) with mapi id 15.20.8207.010; Thu, 28 Nov 2024
 18:20:55 +0000
Date: Thu, 28 Nov 2024 18:20:52 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Julian Orth <ju.orth@gmail.com>
Cc: Jann Horn <jannh@google.com>, Andrew Morton <akpm@linux-foundation.org>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Shuah Khan <shuah@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] mm: reinstate ability to map write-sealed memfd
 mappings read-only
Message-ID: <03678794-2e09-4b93-aacb-90ca6ab36682@lucifer.local>
References: <cover.1732804776.git.lorenzo.stoakes@oracle.com>
 <99fc35d2c62bd2e05571cf60d9f8b843c56069e0.1732804776.git.lorenzo.stoakes@oracle.com>
 <CAG48ez1OQWsaFGBs_EPz+9C=FwddyKG=r1PMbfDtwHNow2SYOA@mail.gmail.com>
 <CAHijbEV6wtTQy01djSfWBJksq4AEoZ=KYUsaKEKNSXbTTSM-Ww@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHijbEV6wtTQy01djSfWBJksq4AEoZ=KYUsaKEKNSXbTTSM-Ww@mail.gmail.com>
X-ClientProxiedBy: LO4P123CA0042.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:152::11) To BYAPR10MB3366.namprd10.prod.outlook.com
 (2603:10b6:a03:14f::25)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB3366:EE_|DS0PR10MB7510:EE_
X-MS-Office365-Filtering-Correlation-Id: 2909a760-82d4-4293-f8a2-08dd0fd96620
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cjFuUHd6b2VXdnhEYzJvbUdQRHZyMFBjdkFqUUYxMHRPUitVRXhWZzNSSkVJ?=
 =?utf-8?B?Y0JWMWNQbDA2VndwQWcvek1RZi9YVTBoUEFERmN1R1ZETFBTVlZlMnkvMmtk?=
 =?utf-8?B?czBpZ1Rraml2c3IybWRlNTZzTmdYMmxOTnlyaHVmeWFHaGhVR0F6WHk3QnFq?=
 =?utf-8?B?ZVNKVnFnTEFycDJtU1U5VVN0WEVNNmk2YzZQWm1LSENDdVVrcVM0Z0dObzVi?=
 =?utf-8?B?d2l3SzdpZzF5dzAzR1RiWHB3RGlXcUFWRTVvNXpLV3ZWMm5hang3SmhGOHl0?=
 =?utf-8?B?aHFURkNqTHJXNEtNYlZveFNZcmpmclNjbFNKc1FEMTVXbEtHajRLZFVFMW40?=
 =?utf-8?B?elN1R1lXbkxPbG54TmgxakRRQ2F1Q3ROTjAxZkxJU0dyY1k5cUNITUUycTgz?=
 =?utf-8?B?bjVYcGpPa0kzL1g2RCtycmtTOXdoZzQ1RUhVb254UFRrTG9HYjRiNkZFYXFP?=
 =?utf-8?B?c3EvZFpZajgwNjdxb1lTSlVZRzArSDhyUjhaTDg1ZFdwZEJEemxiT3laNm9W?=
 =?utf-8?B?eWNVOWRSQmE5UE1WSjNQRzl3bUdXdEhGVUoyTVJWZWVMVks4MGVRZVpJa25U?=
 =?utf-8?B?aXhNYnBteEdZVndSLzVGK2owS3FqRHlrVks5aXB5cHRUUWhTSHRaUGJwS0Vq?=
 =?utf-8?B?Y09DUGY2SjN2WWU1T3RpYmtjd2NrV0ZpeDZueVdSYlkyZHp4YTB6R1JGQ0VK?=
 =?utf-8?B?U0V6bVBtUUREWG9sQ21ZZlRSbkFlNHo4SG9QWnRvcHdGUWhDTG5CMXk0Rk81?=
 =?utf-8?B?cTBiU25pVmlXamcyblNvVWFXY3lOTHMrSWlZa2xQcFZ0ZTIzSnhYQjNHM0p4?=
 =?utf-8?B?TFhTMW0yd0U4SG5lTktEVktUOENqdXNERlBXVldmdFVDdXhuU2ZXTHU2aTFN?=
 =?utf-8?B?aDBpTzZtVCtxU09hZUtRUVlqdktGai9acHZINDIyWXFOVlhMbnVpV3R4dmEv?=
 =?utf-8?B?Z0oxaE9qdU8rbXhwM1did1BxUnNuZmZPY2J4eVVNUFJSZ2MwU1gxdDlIbnZV?=
 =?utf-8?B?QVdRR243aFFpbFdmTitpL1NQYzNKaktRK0xPbS9BbW5lM3Uwbnc3eDZmRGlW?=
 =?utf-8?B?SjZlZ3hvSjcvZUpNcjVLYVRTcHlHOWo2akF5dGFHN25NbVZXKzdjTm1vU3Fo?=
 =?utf-8?B?aDZlT2JsUGVOYi9ReTBlM29qWGNsTTNNMzFlcHRYd1BKb1Fjdmk1aFdIcXZm?=
 =?utf-8?B?T1MxdmMzLytoejVmZGY1TVRHQzdmblRzZGNqMWI4SVRHbDRISXUrdktvaDRt?=
 =?utf-8?B?SWgrWEJkVzZ3eDZLQmN4bXdvYkl1dkRsU2hEbVRORjBibS8wd2FTWWtpKzlN?=
 =?utf-8?B?dm4vQXFXT01OZ1Z1alRZNjUyOGRQNGgvOXp1TG85Q3pKSU1PU0hvU3dLYkF6?=
 =?utf-8?B?L1liQjB2VHpZZjN0VmV6OWxLaGVPdGdRR3c5enRlWVQyS3J4UzhmN1pTTktI?=
 =?utf-8?B?OHJ5L0FDckNPam0wRElsRDlQQ3Blb2Z4RG85TXdwMlNJTkZ6YTBTNm9TSmxC?=
 =?utf-8?B?Z00vRnZjSElkKzNPZWZHclQ5RGFLM0FKejdGNnM4TnZ5dmhCVGt0bkt0R2xW?=
 =?utf-8?B?a2tMblFQNk9aMmNTd0tRWHVHeG1uakVvclEvb0gvUjZmMWwxTVJ0cU5JYXZm?=
 =?utf-8?B?SFpYQmMxUENmZGUwL1oyekplODVta1grQXRyc3ZrZE5rMU5tZUF3WEdhbWw1?=
 =?utf-8?B?Wm1UeFB2QmhxZXFQS2RaVjBZK21nR3RWVm5zMkhzRXB1TlBVZHQwS05XeG8v?=
 =?utf-8?B?US9BU09ydVU4QnhUN2UvdWZsRG1uV3gxQUJORWcvOVF5UUFHcXNKMDJhWHBv?=
 =?utf-8?Q?okaEbYToDzM3x+mQmx79HnP7jUjwoz/TOxeOc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3366.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SkVPTmFKNkVSbDhHYnlXZmo2dDBaOFhFc2Z0VUVtTU5zcnYzL3d2NmtjbHpx?=
 =?utf-8?B?TFgvQ05OM3Z2cnBKRGJ3M1QyVWFMRi9EUUtYMVFQQnVsVnNpeFFDMFg3Tlo3?=
 =?utf-8?B?TXUzOUVZOGhLYlM2WEdMRWFYY3lPU3NSank4Z1MwNDZETTNXM3NrNHdEeVZn?=
 =?utf-8?B?bXFWdlpMYU45djZ2RnZuSGpaeHJLc0w1TlVvdWpxaFJwek1YRlNQTHFWanRz?=
 =?utf-8?B?NHl5S1JqR3FXek1nWTgvdkVKaGxkei9zSFdYTzVkSkk3MUtQbk1sR2lKanRz?=
 =?utf-8?B?aGN1VlZJUjFESUFaKzFCb2FaTzdoTHVmVVRJUGpRR1gyTUtCY2JWdURkcW94?=
 =?utf-8?B?dSsvSCtZTFQ2a3J4U0F5MGRka1JoNUJqcW01YWlaWDRJSUgzc1ZEQ0JTeGti?=
 =?utf-8?B?Z3Fua1R5VG51RWVZb3c4NDB1Y1BoU29OT2pXOEIzcVZKeml4aUZkc2Q4RUwr?=
 =?utf-8?B?a2RJQXJ6enVnckRVREdhY1VhanA1dXJSdjRZOVNqaGo3R29NKzVxQ083cjNB?=
 =?utf-8?B?ZkpNRHJQQWYxTTBOOThhd1krV1k1cHJDemI4TklnQ3E5V1NsK2Q1eks2a3J5?=
 =?utf-8?B?Q2pZWHlVTVZOejlzV2RDRS90WTZqZFJJeVVzM0tIYVlKNTBZNi9hcWJ6YjlV?=
 =?utf-8?B?RnV3N2ltQmxGUDMzemRjaU50T3pZSkU2YTJlcWNzaEtMY1QranVmWXpGUXNI?=
 =?utf-8?B?dGJOYjZVbTRpUldURWxjcjhOTTNqdnQ0NWFiM0FyZW42SEJYWEgvOUkrTXpw?=
 =?utf-8?B?K0w4TXcvVHRqaUVtbGU4TVBXT3c5NFRKZUg1QngxNEcyVlZ4QjRaTzBWSUg0?=
 =?utf-8?B?OCtkbWtmL0lQVGcxNHg2RmJWWEE2aWE3OUJja280VXhUMStHeCtoQjR1U016?=
 =?utf-8?B?R0s2NzBtNCs0OWVlYndiMG5OSUtRUzQ3R1VxSHppdjlJZ2Ezem1HaDRCRGNR?=
 =?utf-8?B?UEFvdFZkekFBUFRzZUdJY0UrUzZtNExzN0w2ajE0VVRhbTl0UVMzZlZQOS9F?=
 =?utf-8?B?WVkyb3F1TGpOTXM0clBLbjY4QkMrUVNEanNkMlN4ZkR6SHhNNnBaUmJBZzVO?=
 =?utf-8?B?a2pUZFJIVkM0QkF2bm5sZ1RZNURtbVdveTFDVWdVN2JjY216enBuWlk5ZHFR?=
 =?utf-8?B?T3o5eGFFTVU5Q3BNeUs0cWZMd3pJbmRJcncvTGdHNzl4WmgrWGpjTEkwdkVn?=
 =?utf-8?B?OTc1V2VmbHZMdm9HRXFHZmFCd3NkZ0lWZnRCMytaSGRoN2REMHM0L0c5bDJo?=
 =?utf-8?B?R1Z6ZGRTK0JvMWVwa2R5bURDQ3Y3U21nVFpMZjlVUWtHRTR4VWFrdWdTTWJJ?=
 =?utf-8?B?MlUwbjJsRjNWbFNsUWJ4MXArRnNoWlNZY2htYUFsVmwwbHE0bEFTWWkwMWdN?=
 =?utf-8?B?dHhXUEtYckZpSG5jNEpLZFpJT24zbkhQaG1KVW13THVzOU5JUU5ld2w3cE1m?=
 =?utf-8?B?Ym5zeUN2KzJLK1JzNHhYVEQrdW1LTXUxaVdqZSt3TExCU0JZM1hDK1VQS1dV?=
 =?utf-8?B?eEh4ZjR3d1lOakhpTVhzM3oyWk5lZE5mWXBQV2k0QkZyZ2tWdDdDcVJhYVhO?=
 =?utf-8?B?S2xqMW1VMjhHb1dXTFdvT0kyaVVFUzVqQXMydTdtWHUvOWVRVEFnV1VNekpt?=
 =?utf-8?B?YU9odTRlVjRXNXJhbStzVjlwL2NhdVQ1U3FRa0ZDYzk0ZnJVcXE2VEYyR0JG?=
 =?utf-8?B?UFlOVThqM2k4czZVaDh6RFJ2VmltMGVCbWZwNWlUTzBpVlNNZ3R0eHlCVHJz?=
 =?utf-8?B?WGZpb29tWXgwYy9MYnh2bkgyd0dYc01teExtNVJ2S3hSTld3ZG15Y1ZXLzBq?=
 =?utf-8?B?WkNTMDdTUHVjNDZVcVRDSk9oRk94U1hoSzNOS1JFOTVsaUlFS3kxWFlQNUwz?=
 =?utf-8?B?ZlNzaXh6MFMyNjk0cXhzZ3ZhbmQ3RzRPVkx4bGNSbG1wOUFjZVhaZFpLTmRC?=
 =?utf-8?B?dGhZbzlHQWNNY1BGcWVMMWJCWjV4bmFiUmRxRHlsR0JQVTNQRXZsSUU2RFlw?=
 =?utf-8?B?VDJrM0RFNVppSjNBK2UxQyt6MDZsM09IcWZ6Y2l4cnl4N3k5dDMvaGdqeVI4?=
 =?utf-8?B?OCtDdjdlc3FLVU5aeXhYZm1RR0hVWmsweWVqL1NTZEM4M0h0UEJycW1wbDNQ?=
 =?utf-8?B?OUFiZkV5SWtCWXVtQzlieVluditJK0tTc2JhV28zNndpaWtVdjVGZEFZQUp0?=
 =?utf-8?B?OVE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Nu7sZBhBvddWsFaQ0pBTc4WXbCNfWny1mI7kkFI1DGrB4Mja0g3HtZI7Bos3lvy08ba3poMf6fdRslQiCDCuPUeQPrE7TPX0G5KVo14Cw+TvLGl4PbL9xu5MOm4oxaXc45kLQNp4vZqTe5Axvv6g+Iyfq6rcdXdVJJTHEfXzPsdyhlts3eAIpgO445AxTgkCw6s5YUA++bEBqp8zuphl6iECxdv1VkiZNu+9WdXk9P7Q8Fn9xGRdUdOAQcy0XqJtcD6O0EX5W7yN5nBlYHApKTDpxF3D3zHUINz5gBvx+t7xTkXpCvJ7yE2KsvZ8XocRTlWOftYchZk+XSWRsha5Hs+rTSm89scWZXHDi6Ax+J0qnzz2VBM7mW+x3RHFpP5/yckp/8UIBCydg4FIiZ7VUZ7WnMC5VatphvKYJK2NUHbvDnS3qf+z0sKwYE9uQbTifCHvOy37L+wU+MY8Sw4zansUDWtlTp05WyFR0EIygou8rsTXDr6EpkLSib8npKycQPrwbcXxpipWExfBiWoaJlyKJrX8s2g3WZzljJKkUYGEcac6IL2Al7wU8V1bjGGuEnDQfSQqSKtZ67IQAKY7tnI5IIRC4RZ1c6Fx5BrnSRA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2909a760-82d4-4293-f8a2-08dd0fd96620
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3366.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2024 18:20:55.4520
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TA3YNWbbOx5YfH14r/a9IU+Y1kwmYpZx1muZDPHdA1dFBoDNpP23N7xH33H64qm1MjlUoeEVcD5SrFUPY4Q9tZSQ0Fk7RGY9WMZsaLNQ46s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7510
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-11-28_17,2024-11-28_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0 adultscore=0
 mlxlogscore=999 suspectscore=0 mlxscore=0 phishscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2411280145
X-Proofpoint-GUID: Gp6prmVt6Yq-syWMct1tztG_46ItFb6A
X-Proofpoint-ORIG-GUID: Gp6prmVt6Yq-syWMct1tztG_46ItFb6A

On Thu, Nov 28, 2024 at 06:58:21PM +0100, Julian Orth wrote:
> (Re-sending the message below since I forgot to reply-all)
>
> On Thu, Nov 28, 2024 at 6:46 PM Jann Horn <jannh@google.com> wrote:
> >
> > On Thu, Nov 28, 2024 at 4:06 PM Lorenzo Stoakes
> > <lorenzo.stoakes@oracle.com> wrote:
> > > In commit 158978945f31 ("mm: perform the mapping_map_writable() check after
> > > call_mmap()") (and preceding changes in the same series) it became possible
> > > to mmap() F_SEAL_WRITE sealed memfd mappings read-only.
> > >
> > > This was previously unnecessarily disallowed, despite the man page
> > > documentation indicating that it would be, thereby limiting the usefulness
> > > of F_SEAL_WRITE logic.
> > >
> > > We fixed this by adapting logic that existed for the F_SEAL_FUTURE_WRITE
> > > seal (one which disallows future writes to the memfd) to also be used for
> > > F_SEAL_WRITE.
> > >
> > > For background - the F_SEAL_FUTURE_WRITE seal clears VM_MAYWRITE for a
> > > read-only mapping to disallow mprotect() from overriding the seal - an
> > > operation performed by seal_check_write(), invoked from shmem_mmap(), the
> > > f_op->mmap() hook used by shmem mappings.
> > >
> > > By extending this to F_SEAL_WRITE and critically - checking
> > > mapping_map_writable() to determine if we may map the memfd AFTER we invoke
> > > shmem_mmap() - the desired logic becomes possible. This is because
> > > mapping_map_writable() explicitly checks for VM_MAYWRITE, which we will
> > > have cleared.
> > >
> > > Commit 5de195060b2e ("mm: resolve faulty mmap_region() error path
> > > behaviour") unintentionally undid this logic by moving the
> > > mapping_map_writable() check before the shmem_mmap() hook is invoked,
> > > thereby regressing this change.
> > >
> > > We reinstate this functionality by moving the check out of shmem_mmap() and
> > > instead performing it in do_mmap() at the point at which VMA flags are
> > > being determined, which seems in any case to be a more appropriate place in
> > > which to make this determination.
> > >
> > > In order to achieve this we rework memfd seal logic to allow us access to
> > > this information using existing logic and eliminate the clearing of
> > > VM_MAYWRITE from seal_check_write() which we are performing in do_mmap()
> > > instead.
> >
> > If we already check is_readonly_sealed() and strip VM_MAYWRITE in
> > do_mmap(), without holding any kind of lock or counter on the file
> > yet, then this check is clearly racy somehow, right? I think we have a
> > race where we intermittently reject shared-readonly mmap() calls?
>
> Apropos race, some time ago I reported a way to get a mutable mapping
> for a write-sealed memfd via a race:
>
> https://bugzilla.kernel.org/show_bug.cgi?id=219106

Kind of hard to read rust code, but it looks like you're intentionally
trying to race sealing on the assumption it's atomic when it's not? That
doesn't seem like a bug?

The intent of sealing memfds is you establish the memfd buffer, then seal
it and _only then_ expose it elsewhere.

I may be missing something here, however.

>
> >
> > Like:
> >
> > process 1: calls mmap(PROT_READ, MAP_PRIVATE), checks is_readonly_sealed()
> > process 2: adds a F_SEAL_WRITE seal
> > process 1: enters mmap_region(), is_shared_maywrite() is true,
> > mapping_map_writable() fails
> >
> > But even if we fix that, the same scenario would result in
> > F_SEAL_WRITE randomly failing depending on the ordering, so it's not
> > like we can actually do anything particularly sensible if these two
> > operations race. Taking a step back, read-only shared mappings of
> > F_SEAL_WRITE-sealed files are just kind of a bad idea because if
> > someone first creates a read-only shared mapping and *then* tries to
> > apply F_SEAL_WRITE, that won't work because the existing mapping will
> > be VM_MAYWRITE.
> >
> > And the manpage is just misleading on interaction with shared mappings
> > in general, it says "Using the F_ADD_SEALS operation to set the
> > F_SEAL_WRITE seal fails with EBUSY if any writable, shared mapping
> > exists" when actually, it more or less fails if any shared mapping
> > exists at all.
> >
> > @Julian Orth: Did you report this regression because this change
> > caused issues with existing userspace code?
>
> I noticed this because it broke one of my testcases. It would also
> affect production code but making that code work on pre-6.6 kernels is
> probably a good idea anyway.

Thanks for having that test case! I have added a test here to ensure we do
not regress this again.

This was a new feature introduced in 6.6, there is no reason to backport it
to any earlier kernels if this is what you mean :)

It's more a convenience thing like 'hm I can read() this but I can
mmap-read this even though the man page says I can'.

>
> >
> > > Reported-by: Julian Orth <ju.orth@gmail.com>
> > > Closes: https://lore.kernel.org/all/CAHijbEUMhvJTN9Xw1GmbM266FXXv=U7s4L_Jem5x3AaPZxrYpQ@mail.gmail.com/
> > > Fixes: 5de195060b2e ("mm: resolve faulty mmap_region() error path behaviour")
> > > Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

