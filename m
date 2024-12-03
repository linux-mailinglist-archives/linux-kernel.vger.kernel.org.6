Return-Path: <linux-kernel+bounces-429616-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2061D9E1E97
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 15:03:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CDB1F285586
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 14:03:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C17C21EC01C;
	Tue,  3 Dec 2024 14:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="GenInENR";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="PLQ6QHuc"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC3891F426E
	for <linux-kernel@vger.kernel.org>; Tue,  3 Dec 2024 14:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733234567; cv=fail; b=EPgciO0VLGiO32YVMUJvfTvGSggA+IJKmg+LUdhNDMWDbYuxUUqUzl8TY/hTwD9UKHYC7AKAyUPv7Fv5nmjm4fp+fgt0u5gW2NWlig7895h2ooh9tQ18kor27ensxpqCfXP2zJMAFy80171VZPAV8JkKrSJKsI972IVJ+Gi8WvA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733234567; c=relaxed/simple;
	bh=9uZidO7dQkOFPjflsKcuviGAcfQ2f07FOBjltgWAJyg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=DLlvW+Q7KpCnkqD/65sR4XRS6KSU76o9GY6ZylzcrtfV8AIcoPuLPatZiq4S81XP6nGfKaMR4YV1NDDJIiXqkcMERQsF9J1eT+bbzgjW/gMku6IoRL8DY6LbAjAsMjAuUmkEAxPiALy3zXLcbYa0tz0kKUITIdWsPHXowrXsXkA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=GenInENR; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=PLQ6QHuc; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B37XgRP009902;
	Tue, 3 Dec 2024 14:02:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=HCC8I0fETaZRd+Wa7jFToDleQVV6bTDmRCO+XjqLLXE=; b=
	GenInENRdk8wwDGHgV5K0coXKn8//mILqJ8dPRGzJkWc1kF81URITxbPB6q7cM9t
	VE1w+iqyK09if6fr0+Cxn/w/ojJoIiTHUBP5vj0/K4Oc6DnZuwZetSKu837RrYEP
	iqDwenbdSxegVOlnYsBk3hdVxAt5rnvcja4Ea8Dd1UPpR98u7TfZBGuB6wCaDHzo
	lirqStaijPV3qWJgHtwHfgQIy4VPxTJFp60nQQPrir93PTUR6CCv27DK0Qxlnyre
	W2wm09QpYyCMEyomNfLnL97TnWpUsnhg3M3c8SSNs8v5mRMtdpcNdVDbNYB3G15S
	NVfCWcV8i8WJFoxP0K40EA==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 437trbp5ve-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 03 Dec 2024 14:02:22 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4B3C1Abq031377;
	Tue, 3 Dec 2024 14:02:21 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2175.outbound.protection.outlook.com [104.47.56.175])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 43836tyac9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 03 Dec 2024 14:02:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OmOnvSM3UrUrZIqGYZNRw8WjboFtlCSxV3UEYD5z7Q2wXKgxUzwv8pJfW7Pv/LQvjjWjpINiEu9LF+ZU0xk3ipTOMQPdfgoPwgjOUqq6FDCJby9YomiYnVyxow/r2IBYkGUjFxzb+uj/Mj6T0GijT/sNrEKAanFbmQVzwQYRhm5j5ZQZELx3x8uFCP3IXoBjhTPoSHwhSZOiPcLv4vFZklerDVhjrRBhwP2lSfxTdvOfP98mjyn2XNQOzatE/4bv+ktbvCA/Ipm9/V4uSkW+N9cxZLbuzr7kBUnkiHPc0Vf8rqIz/obsxDahqH3CFTJZg3+WwZDQJU5zfDleKlpCZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HCC8I0fETaZRd+Wa7jFToDleQVV6bTDmRCO+XjqLLXE=;
 b=TCjhbYeofQyfpXapfvQaZoAGa3yEI/6oAoOMeF5Ld6tlD5gUeuZq3R2aqZAnHW2lTrs44Flmfes5dQTAed3IJ7wmjAS8xY2YAnn9159nWN72pY7lZsCfIG2nswzV29rQ1Y/L+crRHmGe2X7WEwnEtyfmzd0jMEjIxGrVuepoG80T9BH+UJRVRoQNnMpA0se9YMG8//VEWB3+I2TMIUDXA3Eqm9cW3N+fD8zuJsZKQpTWNDDSPpCOny+LgrM7YGLKFKyCXGJ5/7aa7oLcS+V/cQitowI5Y9/o84/+yo4JE5yDUWizR8SBzjF8RdL1dGkOpCAnt6a5uMSF81p87aQIrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HCC8I0fETaZRd+Wa7jFToDleQVV6bTDmRCO+XjqLLXE=;
 b=PLQ6QHuc4oyAlHYl+3QxhcacTCKwz/HbqzqYBf5pRJJHtFU/Y13loKxJzGZrL17V/c3IO5vDbNxt1RJVowDpIgygm+vRhFVMRwYenTUHeLmrgJ9D3mTovqPs90i97NUmlxDc07O3XLVXSDm+vsLS0PMWpp4QEa61qQwVH8aow0I=
Received: from PH0PR10MB5893.namprd10.prod.outlook.com (2603:10b6:510:149::11)
 by CH0PR10MB5033.namprd10.prod.outlook.com (2603:10b6:610:c0::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.20; Tue, 3 Dec
 2024 14:02:18 +0000
Received: from PH0PR10MB5893.namprd10.prod.outlook.com
 ([fe80::79f1:d24f:94ea:2b53]) by PH0PR10MB5893.namprd10.prod.outlook.com
 ([fe80::79f1:d24f:94ea:2b53%6]) with mapi id 15.20.8207.017; Tue, 3 Dec 2024
 14:02:18 +0000
Message-ID: <4d5c9ad7-6898-4f14-8974-126306e62db7@oracle.com>
Date: Tue, 3 Dec 2024 14:02:08 +0000
Subject: Re: [PATCH] mm/hugetlb: optionally pre-zero hugetlb pages
To: Mateusz Guzik <mjguzik@gmail.com>, Frank van der Linden <fvdl@google.com>
Cc: linux-mm@kvack.org, akpm@linux-foundation.org,
        Muchun Song <muchun.song@linux.dev>, Miaohe Lin <linmiaohe@huawei.com>,
        Oscar Salvador <osalvador@suse.de>,
        David Hildenbrand <david@redhat.com>, Peter Xu <peterx@redhat.com>,
        linux-kernel@vger.kernel.org, Ankur Arora <ankur.a.arora@oracle.com>
References: <20241202202058.3249628-1-fvdl@google.com>
 <3tqmyo3qqaykszxmrmkaa3fo5hndc4ok6xrxozjvlmq5qjv4cs@2geqqedyfzcf>
Content-Language: en-US
From: Joao Martins <joao.m.martins@oracle.com>
In-Reply-To: <3tqmyo3qqaykszxmrmkaa3fo5hndc4ok6xrxozjvlmq5qjv4cs@2geqqedyfzcf>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS4P195CA0006.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:20b:5e2::11) To PH0PR10MB5893.namprd10.prod.outlook.com
 (2603:10b6:510:149::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5893:EE_|CH0PR10MB5033:EE_
X-MS-Office365-Filtering-Correlation-Id: 69ab54fc-7410-4fff-24dd-08dd13a31911
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ODM4czRBUGVQZXYxSDZNQ3N3MUlpcjlLYys3dTUrQ2ZrUzY4Vmg0WTVQVS92?=
 =?utf-8?B?KzdyZXRkSWgzVzYyd1hneC9CUmhOS2tIVXc1Z28xNEdKb3FOQkJuL05CNmVh?=
 =?utf-8?B?YmpkQUFzN1BoRnVnbHdYaXBhejB6NUFGR09LRUVDTitrTDhzdm9aQzBYSCtK?=
 =?utf-8?B?cjFaWTVxYzErWS9SV3lTNnhZUlpMZktqL21NMGlDRWpKZDk4U2tFdXJVV0pm?=
 =?utf-8?B?RWJkeFMrVkxhTitJQ1Mzdkl6b3M0ald2cEd0WjZlSDBrUkYrbmkrdHZoNkxq?=
 =?utf-8?B?anNkcnNJbjhZZy82aUxTYzN5VkJzWTlFdXcxdUtxaVNlWjJwQm5SWmxGbzhr?=
 =?utf-8?B?QzByWmprOXdhMWlqeWhkRytjd2k2cHFyaDdRNXRqaWx1WjM1S3BsUE1qdGZS?=
 =?utf-8?B?T3o2N1dLbUs2U2RJMlNGaHUvS0lnQll6YkRZK1RkUEhaMmV3WTJkeks3Yk0z?=
 =?utf-8?B?L3FLNzdCc2ZCQlRyTEZzUXpsT3U2bDZCU2FBcCtROGdjMlpKOVBOOS9rY2Vj?=
 =?utf-8?B?cmJlMnI5amVpQ3E4bDRveDR2cnVEdDl5QlUyTjZZMVlvV0tkTElLZEZpZ1Vk?=
 =?utf-8?B?N2lONU82b2FvejI4YW5mQ0MrcDRBQk5YMUgwZEdlV2ZUNUEwdWlKZUhETU5C?=
 =?utf-8?B?d2I5UVVLWXFSREQ2YjlxQ2pJUEZZeXBpWFptOUZBWDRHV3JoVnVSdUtmV0Fj?=
 =?utf-8?B?UXdOYnNPZGlaQWYxYndiSGYrcHpHa21uWVVhTXZ2ZmRURFNmK05PL1cwbFZW?=
 =?utf-8?B?Q1I0NVJ0elQ1T3pxL0JoaTZrUUFvVmtmYytUWk9GSVRLVkNZQVg4blo0eTkx?=
 =?utf-8?B?UUtnTVkzd0RaUUJQdDBXbUUwZWsvWTVBM0lkMWtNZ2VHZ3YwM2Q1YmYxZUtt?=
 =?utf-8?B?YU8xeVFDSUJaWE5IRUd4MUZmWVgwMFNUaXJsL0RueGVmUlRYbXkvV3JIWGFX?=
 =?utf-8?B?cnhnbGlBQkJkUUlDejU2MmxCSVNrRFlhZmVsZUw3REVVOXY1QndZT0QyZEgx?=
 =?utf-8?B?SVBOaE5NUkVwRlZNNWJRbHAwNHg4YWNUSldoUmh1cFFJQ2orNG5JL2ZEVnMy?=
 =?utf-8?B?WG5jQWovSVk1ZGlOVG50ZUhsZndCTVZnRTc3dTVORS9JSEpHdUZZdjd1TjNx?=
 =?utf-8?B?cEcrM1o5RVRzY3VuYzRJaVorSzA1aVJ3NXR4blErdml2YmNWZEZ4L2s1UGRW?=
 =?utf-8?B?anl4dlpnN0pWd0IrUlVCUVNRZDQ5OWQ3RTVmK3ZvcThhSmlNb0NFOWFWazRl?=
 =?utf-8?B?QVdHWkpWcVJ4U3JkSnNzWTJvbGRnRGw1eHZOQURwWXVwNUlUQkxSU2JYbDJi?=
 =?utf-8?B?SXNTQ29VbndUWUdvZjQ1Q1FBNkU4enhOMUZ2TUMwMktlYmUyNkdlNHQvZkhN?=
 =?utf-8?B?SXhUSUIzbm1zd3huYUprMnhxN2NuUGtXZ3pNczEzdVdQdGRMbzJ0Q2EvUGFB?=
 =?utf-8?B?RDRYTnhDRHFHdHVtRHhvL2RNU24zMXFwSmVpdWFrUlduS1o1UG1DTW5WL3lG?=
 =?utf-8?B?OE1UQ3ZYWTdCZnJNak1Uc2tWdTNxZk5oazA4UkxsblZOY24wNkF3OW5YUFBB?=
 =?utf-8?B?N0Q2dGVEcCttaXpEckZweEZBQ2FkZ2FyTzBxaHptdHFaWjFPTGJ1Rkg5K29J?=
 =?utf-8?B?eU5IUnBxZkh4Z3g5UjAvVGZwcS9UUTlVdW9VTCtQdEpIMWpJY2tYelZiaUtB?=
 =?utf-8?B?YlBvUFMxOHpSVGhTSERqblZwS1NEcHA5dmVhMlNaMzhEQ2lQQnRKTzVvZDJr?=
 =?utf-8?B?aVIwRURzcUJMS3ZENG9Jd1BIMFpoU1lnZnA2QTBEOWFNY1BWdDNjMHBTRHBJ?=
 =?utf-8?Q?VJVF5a2QAErn2fs5mRCk0jpGDwbByS2kLCE+4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5893.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UHhCd01SSjRNVUduTHBtWEhyb2RrQ0UwMUo5M3gvME5UQkFJVngrcTBOWnBk?=
 =?utf-8?B?UTFHeEFwU1M0UVc1RXZ0S3VONjdqbE1hVFFXR1p6OWFMUGZjMCtmUzEvMzF3?=
 =?utf-8?B?Rm1jMmIwUUNPZnZoR3AyZktaSU9BQlVXYXJpYnJnNFVEazg2dWxXb004SEYv?=
 =?utf-8?B?dmtyd2UvTGpBSlcxNFVmTi9vejE5UTRmRXcvUXlkVlFWVlpuSVZwTG5BTkZi?=
 =?utf-8?B?NmlqNENyTGRNVlhOY29lTHJ3cU5YMjV5alB5TkVZeHhPeDYveWxoeWtZMHpB?=
 =?utf-8?B?a0lpNk5jTm85OVVsN01QZE1Fc3RqRyswSzNoYmE1bzlUUGI4SnkwM21IYXdx?=
 =?utf-8?B?dTdxVVhBNVhUc2gwc2cwY1hOUGtsS0ZGRGlvVXVkemVwQ3N6N3VNZ1d5a1Ix?=
 =?utf-8?B?ejk4YlRIRWdqUVdUR2JQeTVCRlJiQXVqSUdDbXRid3VSK0t4b0xrQmU4R1Zm?=
 =?utf-8?B?emZNQk9tNllsWVMxT3lEalpYWElKQWsyQ0lwYWkzcThhNjVaeVBkNDRseDFW?=
 =?utf-8?B?ZlBpVGlOME5HZS9jMWFBU0RqS3JFV09JeXpSdSt3WVJEZXhPejNoUU9JNGkw?=
 =?utf-8?B?Z2w1ZkVncTNzZGpFbXNTdTJObXBMQmFpaEh2aTA0WW5uVDlhOHRrQTFuSTY0?=
 =?utf-8?B?eTI0cTRvWVdGc0VtaDBGUEVudHVDeHcwa3JIV0tOT0ViYkJZeUpNcnVEd3Vw?=
 =?utf-8?B?K3NqcFVhcFlLbkNiWU55YTJWOUt1YVgvSzI4bm40c3RCdUZHaXlyS1lLbHlM?=
 =?utf-8?B?TytJQlV1OXpjcGYxL2Rjd3F2c0w2VGIyV1JkdUVla3ZjRjBFMmQ4ZXR3Y2NX?=
 =?utf-8?B?czJNbUYxejI2L0x3bVJMZmQveWFGSlBEeW15aWJaWFk0V0ZYYVFkZURNb2s3?=
 =?utf-8?B?OStFa3doK3dKdzNFbmZOdGNVRm0yN0g4SDhhRUp5R3RUa01WekxGaUFWenRu?=
 =?utf-8?B?NXpVeVVZS2ZkUjVUT3dydlU1VDd3U2tQRVpRb1ZmUWxWeWkyck9xM0ZTcGxn?=
 =?utf-8?B?MjVheS9ocUFjbUxoVE0wME10aTdTNHlWdGhFZlJ5Y0s3QXBNNmdJdG85UGVh?=
 =?utf-8?B?VEVIWWJBMUY5WW9meklMNHRQSHpWZ1JqTDkzaWNvTlo3SE9BWXFXU2RYb05Q?=
 =?utf-8?B?K3VBVlR5Q001VUVTSTh5amxUSFhkdzY0RFdjeVZQY1N3czhIaHMrbGJWWGd3?=
 =?utf-8?B?QVJoSEpadGh0OG81NDlpc0YvM1FwTWNXUW5pTVpHaEY3TCtHSllTVVNQSEpy?=
 =?utf-8?B?dW5ScFZURmdqSGM2R3dUNFB3OUJXWFd1MEhWUVlGQ2pCYXQzV1EyRGxzZncx?=
 =?utf-8?B?bWhRWk9iS3BRN1lnRjdYYXFsd2JvdU1ibFd2aGxvV2F4bVU4RWkrZnRtS2hy?=
 =?utf-8?B?NkxWUlNPNlVGUnhpWkNqV3BSd2VqajlWMUpHRzZRMjNVbFRYY2M3SWNjeGFy?=
 =?utf-8?B?NTAzU0tJZHVranlheU5rTmEvcVNDME1IK0tFRkQrVjFYQ1Z2Y09aYXJLejRv?=
 =?utf-8?B?MkhMSS9XWkMvTFpQQm9wRDVSemhZdGlPckVUUmJrTDg0T0RuWTFIVzIrMXph?=
 =?utf-8?B?UDd2cVEwYnBLUmdSMXc3UC81ckNwcE83dHFzdjJkS2lRRlFFSGtHR1dOTUFw?=
 =?utf-8?B?MTZ0MjI0SktIeHZGRGIrc3ZENGpQb09zUGZ0VVBtNUhQSWkvU2c5cGZqOGN0?=
 =?utf-8?B?L2JsT3JYZ1NZa2VBRHd3c3RUaEkyQW05dEU2clV2aEZxbGNjWGRRakp0cXpT?=
 =?utf-8?B?NVQ1ZDdDcXhTZVVSMzdSdEZvd1dBMGJIUXFDaUZFeHljS3BiWkVURVF6NjVV?=
 =?utf-8?B?aHoycXU4cUZ4WXpyZ2hSQUpYYjZjUHNwRGtqald3YlhFSnBQNU9OL0RRTVdK?=
 =?utf-8?B?dHdlNitXV2Rhem01ajlZQi92c2FqL1dCcHZXSFpmNndkckZEeFJUR1krdW1L?=
 =?utf-8?B?b1lXcm1GeCtjSUp2dFJ6QzdqN1kzeXN3cTNNRHFCaU9IenRGYUMxZzIxS0o1?=
 =?utf-8?B?RnhzZHBub05DaW44OVkrS3dpK3NybUJIVTVTQytqL01xcndqdjFIMnVtN0xt?=
 =?utf-8?B?c014R0ZFaVc5ZWg0QXp1eC9qYVpIZmxoZUJxUTQyVHd2c1pUVDR3V0ZrUE5Y?=
 =?utf-8?B?UENJRFF2VUVHRjNYUk9ucjY1WkQ2bzJwV2JUUUhDWHVjUlNFSnQwQUtpN1Nw?=
 =?utf-8?B?UFE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	NMgRDC9k5yNfqFT5oQrWOcy4WfDiMPsa94L23ShSfEIgkDORhOaxsYg7ASY1GrTRvaTpEQ1q9NjzSJCW5yLv6ZWD7VnCjouv2UAXWKlvlrVBDnUcG5oh3vOQXd/iJJWJtAOcEx36AhFaZTPyjD6NEfuQ7WePhOiBHQTzepJzG/LQZnXYwcr/JlWQvy7j3JBnhkqFPbbYxsbUqKr73M7waFYhr60/zBNzKG3fnPOjBX8A7XIb2FH+z4HV6toF8JoTyKSzkYXw7LlAcoATW6j0vziaibGwElP9FN6HjvoRlBLQhPEGH835cL2LnwXdUADoB0NlN0I60qE4gK9RygqJiu0nqHBxq957zAQvKuPggXp+zRx6FHHywEv9Ux2N2PvFnGDNC2ERLn8W9lh55cCuw4sVFR1KW7o12T1gi5brHsUOU8+MO7/Bi9RFwJwpY7znLT1HLotM2CxBilDdVxtoIFyCWMR3rZuAnNs6dc+Zc0FqIm3XASaXv2+h3DdfvqJzAgOtyTAU85x0rOusp6g74uYmB6/WE6WmX+NSIhOSmhKkUzvy3jwiLF97uFbLf86Kyk8Qdfnf/SJ7pKjoO3tz7bvnoIkQfW9zhXLW172gHBo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 69ab54fc-7410-4fff-24dd-08dd13a31911
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5893.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2024 14:02:18.0505
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ghi2GE5rOaGqane3btD20C/B0H8fQGz6I0yrmFJvVC+OPM5lVOa7XnbNROvDLMm3bWzRAvz/hinMWUhFtHA2NyFLTSdMr3b/fUlP6VE7jW8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5033
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-03_03,2024-12-03_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 phishscore=0 suspectscore=0
 malwarescore=0 bulkscore=0 spamscore=0 mlxlogscore=850 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2412030120
X-Proofpoint-GUID: _uWpYr4pAiwy_HS74blJFxvoIlW0Fw2b
X-Proofpoint-ORIG-GUID: _uWpYr4pAiwy_HS74blJFxvoIlW0Fw2b

On 02/12/2024 21:58, Mateusz Guzik wrote:
> On Mon, Dec 02, 2024 at 08:20:58PM +0000, Frank van der Linden wrote:
>> Fresh hugetlb pages are zeroed out when they are faulted in,
>> just like with all other page types. This can take up a good
>> amount of time for larger page sizes (e.g. around 40
>> milliseconds for a 1G page on a recent AMD-based system).
>>
>> This normally isn't a problem, since hugetlb pages are typically
>> mapped by the application for a long time, and the initial
>> delay when touching them isn't much of an issue.
>>
>> However, there are some use cases where a large number of hugetlb
>> pages are touched when an application (such as a VM backed by these
>> pages) starts. For 256 1G pages and 40ms per page, this would take
>> 10 seconds, a noticeable delay.
> 
> The current huge page zeroing code is not that great to begin with.
> 
> There was a patchset posted some time ago to remedy at least some of it:
> https://lore.kernel.org/all/20230830184958.2333078-1-ankur.a.arora@oracle.com/
> 
> but it apparently fell through the cracks.
> 

It didn't fell through the cracks for sure

Just had a detour into preempt=auto before resuming the main work. But that
seems to be done in the last merge window with the lazy preempt stuff. I think
Ankur was planning on following that series above soon-ish.

Adding him here, such that he keeps me honest :)

