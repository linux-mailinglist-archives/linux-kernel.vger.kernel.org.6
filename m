Return-Path: <linux-kernel+bounces-173582-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EE918C0269
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 18:56:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D7E1C28143F
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 16:56:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FFBCDDB2;
	Wed,  8 May 2024 16:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="n+juEDN4";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="OnbF+KIy"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71733652
	for <linux-kernel@vger.kernel.org>; Wed,  8 May 2024 16:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715187392; cv=fail; b=dO5OS9x9zMYqssDA7gwaofAcXR4it27XN1jKFlSD9m15gO15DAgBMbzPNj14aY66/xHnJTFFjpzTyXOddE2YzKCDwuyAH86luWW28jILjibvKAgDkj+V0kY2cc5YiVM+u8WoWEybcOulsiLr6B4ut1VwOd9VYoTNMiIYoMTJoFw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715187392; c=relaxed/simple;
	bh=ytravFgnX9hNZ32k2TMG6B1HTCxQYCMhglcn/VmbeFI=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=i29XkF1CZCTQ4k9RpaIFUB0dgJ+4i+aR3ZVBnjsYClNJzTfePLC6AyARRUYLFcrB+mz927YSEpE5/owkMnXd6LzutYneeLn3tKkzlXe/YE1kWm6MzkS9DD0ttn8QO7WGrsVzV9RsqBTPyqjmcjui80MqQYf2owE2HABl5BTnlQ0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=n+juEDN4; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=OnbF+KIy; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 448CPGO3022275;
	Wed, 8 May 2024 16:56:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=suyCpYRuRuKG6GZaLv5Rc+V4lDSYgCfW3TqMvMfx0rk=;
 b=n+juEDN4yupLgXVQ4N2CosMExm0M9M6DZV/2zgcTEnyFHyYUMDrCS065TUcgxWvFwGiB
 Lb8s/ge+f9aWP4FOfniYT82IoBVjCof7qTY3pzgRA6iTxFfFboWlNFQ/qW+vm54q0Fu7
 0gVAad/1LM+bu0ZrnsbLk9z20oooeIcymiFlBDP+fuuGW60Oiu3XIcquE+CGEfsS+bHa
 3ZHBMdiHUG3FOJ99a0vFLttC1/kRnpMKB0Nt2Q5BL4eb0pcMHs4je6VL6wwht408pkYz
 OXvHgO1Cm/N/kSxarbTNF3KonB97wuoq+BJMkL9B4LLwKXX8Str0GPm3bOedry4ScN5H Qg== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xysfvj9px-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 08 May 2024 16:56:19 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 448Gs8pY035459;
	Wed, 8 May 2024 16:56:17 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2169.outbound.protection.outlook.com [104.47.55.169])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3xysfpkbs1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 08 May 2024 16:56:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jIQsFBGlW9gDge29go6Fl92TeJTK/o9zj8m19n//xpiE7jYM7AAfmVT9Kr04T1xnE9tnA4/LaKY7hfrX2auq1uHUF9aWUQyPTC8Lgi+G/LOeGajM4xYqXyosj0uYG24qZuzltcS1NCgLvZmr2U+pT/aIaL1hW8jy35Y/GpOqrNOMxQMr8R9JujJUUv2wDNxTIMs5sBHPdbSE9NnKGJpXHJbo7e+QNtXpsbXGrYuhRfguxNQzcqLc5UcS4ZH03n4eeJCx8g0lnRK7P+DYFCXgveiY/QrtJTMXgSpM+fU5f+RGfkr9YxfOC1P/k6bGN6HN0G1BzREMSCxHgY78MQNSYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=suyCpYRuRuKG6GZaLv5Rc+V4lDSYgCfW3TqMvMfx0rk=;
 b=ORzMx65uWmCotqq7/LZzfvotOFbaq16M3a2uFP2sqwj5fcwYvb5jvUBfG6WBzWOeB1OFL9TD15ED8ZVDobIya81aAUiqpmyy96odxMOhzxhgg0Tofa83TcSI3IgDj3LC5fGqeMkOZLmFnDCRtSbZ9VNUr5QlkJWRTsdDDEkQUb03Q8tIIpnIaF2UQ+aN38eotiWol/D7JaP4XAeb8Gd1fKO+Ol40H7uw/AZZuinhiinGCfXlq3Kt0BA5vIj5Nga0W8JStlc/JnMDZPUJafvp+2f3NJhLsSu5rjKVSZZstuh/NRrkKG/2xbuVVgYc6FJSXCHVRe5XkSYESQzjGeqhWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=suyCpYRuRuKG6GZaLv5Rc+V4lDSYgCfW3TqMvMfx0rk=;
 b=OnbF+KIyvOgltxxJ1K/YLY8v8K421idsNACrdqLKADdPaVkCjXslVSUnAfcDC4QTE0TFjYdbqgzeodyweS3P6H7TJmyuOe4S6dZfGKOW8YLay7oGV7JxQcMRtG1S+agURbcTQqoOc/k/Wl1WoSKstwQS/GK/kAEjC8x/Lylvd7M=
Received: from SJ0PR10MB4429.namprd10.prod.outlook.com (2603:10b6:a03:2d1::14)
 by PH0PR10MB4791.namprd10.prod.outlook.com (2603:10b6:510:3a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.43; Wed, 8 May
 2024 16:56:16 +0000
Received: from SJ0PR10MB4429.namprd10.prod.outlook.com
 ([fe80::f5b:648d:5d73:dd03]) by SJ0PR10MB4429.namprd10.prod.outlook.com
 ([fe80::f5b:648d:5d73:dd03%7]) with mapi id 15.20.7544.041; Wed, 8 May 2024
 16:56:15 +0000
Message-ID: <56448498-96e4-4350-a915-15b97294bc62@oracle.com>
Date: Wed, 8 May 2024 09:56:12 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] mm/memory-failure: send SIGBUS in the event of thp
 split fail
To: Miaohe Lin <linmiaohe@huawei.com>, nao.horiguchi@gmail.com,
        akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20240501232458.3919593-1-jane.chu@oracle.com>
 <20240501232458.3919593-4-jane.chu@oracle.com>
 <2e51deff-24ca-32d5-dbd2-9077f860723c@huawei.com>
Content-Language: en-US
From: Jane Chu <jane.chu@oracle.com>
In-Reply-To: <2e51deff-24ca-32d5-dbd2-9077f860723c@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR05CA0156.namprd05.prod.outlook.com
 (2603:10b6:a03:339::11) To SJ0PR10MB4429.namprd10.prod.outlook.com
 (2603:10b6:a03:2d1::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB4429:EE_|PH0PR10MB4791:EE_
X-MS-Office365-Filtering-Correlation-Id: d27c572f-ed06-41dd-22e7-08dc6f7fc62e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|376005|1800799015;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?TXY1TUJvOHk5L3c0T2tyWms2aGk5NDIzT2d4anowNURrNGxlNVhrdjJQdVNX?=
 =?utf-8?B?T0NQYVBBVndrUTlKVU9YRFNHOWhsdktQa05xMitjdXNuMHE3OTVTeE9ncEVa?=
 =?utf-8?B?QmJ6ZXpUYXZKQWJPTWhldVFqTXlBSXRubGoranhXNklZVy9INlBac2NyME5Z?=
 =?utf-8?B?RE9EbnV2R2pCQ3BFZG12WTdQSG5sSGVwTGxBU0p0UUFBSlVFLzB0d1RtUDlO?=
 =?utf-8?B?SXYyalFabWVXK24zNVV3SGt2bGdSc1pkTUwzTXBsTUtWb1hXdnFxcGVLMVdT?=
 =?utf-8?B?cGZLRDhmS2svSlZxQWRLeFJlYzRtWnpuTjdjYWVnTW5CZGl2TUozdi9CV3ZI?=
 =?utf-8?B?YjVVV1BZZTlJUDg0OFpiQUNqeGhJZ3k0djVrNXNQU1B6bGtVaDN6NHo4ZE9i?=
 =?utf-8?B?dERwQnEwbVcwRldjd3l0Ums1QnVLbjh5dzFsNkh5b1FEV0Z4cmQyMS9MVjRX?=
 =?utf-8?B?eTY1WWlqT3RjOHJrejhwR0tvbHlGTkNvT2JuSmFnMUFSNEpZWmNnbTBWWkZ2?=
 =?utf-8?B?dERtbTVqZDFLNEo1Y0ViOUZ1SllTUm45VG55WHk0ZDBhOVlnMWxuV1hiaXBG?=
 =?utf-8?B?cmxxTVVQS0twRnB4QVpRbXVGcEFyRlozNEhmZENRdXVHUUE4OThqNCtJc2Ns?=
 =?utf-8?B?Q3JGR3d3Y2hnZHdLMStuOUhobWd6dXFiZzNycnRnaXYwMkZ2YythT2NYRk1r?=
 =?utf-8?B?NXJDWXZ0UTYwVVlOZFJkMDRzOXdwejkxQTVZS1N1b080WVl3TnpwTys3Qldj?=
 =?utf-8?B?anNjdEp6eGVNNkcyVENNSXIzSC9jSVA0SGlYanpuejJlemdCWDR3N0xwUDJ3?=
 =?utf-8?B?RWJyVkE0dC9XdTJmdnNpUHlnRUhLZXBkRHRoMHVMeTR3V2dkb0pucXpvek9H?=
 =?utf-8?B?dkNqSHR1eExBS3BXR2ZYNEtUd2kvR1NvWlB2SVFqbEhDNVNwcWhoSkhsMVNU?=
 =?utf-8?B?VldGWXNaYzgxQmltdmNUR3pxSGdWSmd2eWlVYStFRkFpRWxmS0RWWnlFUDZG?=
 =?utf-8?B?QUVxdHFKSDdxdnRwaktUd21FcElRRW1wMVpEL3VNTlNKdXBqUm5jeHBBekJn?=
 =?utf-8?B?YVNpcHZpTVUyWVlJV2hCb2p6OENZRk1rMUowNUNFeUppUHZwTnZYMkVGQTdh?=
 =?utf-8?B?SDVzdjlVRURyaFV1UEp4dmVFeUtlN2l6MTFVRzRQNm04RUhsNmVPb3BOaEpR?=
 =?utf-8?B?Ly9wR1I4Y1l6L0ZDbWJ2NlRTVkl4T0VwYmo5NlRXT2JERThST2x4cVkreXll?=
 =?utf-8?B?RzBPREhFRC9oZCs5aGkyUlFJOTRWcWhUSER6YXFZR255dXlobWpGQSt6ZU91?=
 =?utf-8?B?cVJ3a0pKUzFhcEZ2R25zVDBYQW0zRjNUM0N1L1FUaXpEcEFaNURpKzNkOGNQ?=
 =?utf-8?B?bXlLU0FqcTgvVll3bHlRSHE5RWJnS09vYmpjbllrZEcrc2xZdEdncGIzRDEr?=
 =?utf-8?B?aEo0YW92TkJYSjlQaHBHK0hGOEhac1J2Yithc0tBSlRPUkVZUG45eTNvUUR0?=
 =?utf-8?B?V1RuaXhHR2dXaS9KWG9JMTlwM0NBOWpzR25Xbk5Ec1o3TlpmWnJRYWZnNVRO?=
 =?utf-8?B?aXp3VmpOTXBKUHk2c2NDem9nTTdJcUd0bVE5MGVNd3VnWUU4YmxvUmVhMTRU?=
 =?utf-8?B?L0ZPQzl5WklJK2hYZGRxVlMwVTZBZ0I5UDJOUENyekd0MkNNSEhIOW1CS2VF?=
 =?utf-8?B?RE5EOUtjTzU0SE01eWlBQUFndTNVQ0UyanlUdFcyY0t6aFliVUZ5S213PT0=?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4429.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?MUVjU1NGcVNZdjh4TmRwaEh4Y1NILzk1c1lwVjdEZ1VyRUk2a082S2NXSnZS?=
 =?utf-8?B?UUtZMHZhYkx6dGxFdGFFRDJNOHVnTDNtU3ovU3VnVklYS25pcTc2bHdtMTVT?=
 =?utf-8?B?TWVmY2N3cVYzdjFNeWxkdWdxTWZldzNpWjh6NWY4ckNKaHpsT3pBMEdxVzln?=
 =?utf-8?B?cGFXYkZLYjJPSFIvUXpCeitaYWRMeWRYTHZwRG8wN01Zd3BISjVnOFFGL0dS?=
 =?utf-8?B?QTJ3Q0ZvWTF5OWtUWEdsY3ZRN2hPNTBCQmRXdk5YbU1wanBVTkJJUzBhbGtG?=
 =?utf-8?B?aTcxemtqNUVxdnlhM0hlNGVUbm83SFZKcmNxRjk4S1J1YjBaajBGWGswV2I4?=
 =?utf-8?B?aE9PeVAwenhoWkU3aWpEcFpmdFllbFhJakxtNWZKb3RmWEE4TzhhaHI4WThW?=
 =?utf-8?B?NFIvVnJDVzV5cFpWWnpBaFlHblgvS3l1eGFsVDNOdzJBcXF1SGNQZ3M1RDl2?=
 =?utf-8?B?SGl2anU0aUlrdWh0TmNFR3VKclIzNmxMaEh3RUdCT0hmYkJSSjRhK2JiLzhn?=
 =?utf-8?B?d0xhTVozSXV2ZjF6MFQrN1pDVCtDNUtQU0dENlFhMlMxTndVQjlsd2JGaTZO?=
 =?utf-8?B?WVNEa0U1MEp1a3FwRDFrSjBFekxXZVNzMkVaaXhDVUl5NmI5ZEoxQmJyb0xy?=
 =?utf-8?B?OS9URmxvbnJIQVZYbCswWjZzT2h4UGs0WU0wYlk4RC9kbFpHalhhQXhvQncx?=
 =?utf-8?B?UHg3WFlwa3RZd25DdzhpVjdoMitySnNRcXhzc1BZR3I1ZTArRHEyWWZwUzhn?=
 =?utf-8?B?VkNKcVB3Rks2dFc2QWZIaEdZYkVIWG4rUVBJS2FkeVFiWUttdzEydW96b21u?=
 =?utf-8?B?VmVYY0F1RlgxNVpYUWpGdTdWVzVkemtQOGNRSE04TWNINVpwdEZOb1MrQmdJ?=
 =?utf-8?B?czcwN21FaExnWlh6RGlVM0lRVlNjZWNCRjR6MHVhNFplUW01a2M4SXdVdjNh?=
 =?utf-8?B?WmhIN3VkRWIydFJYY1o3dldTN3d0SU94WUxMeUt6Z0diVzdibmpCMTBqdnJw?=
 =?utf-8?B?VTF0dncvZmgzMkZYYzJoUWhhNHRnNHhkVDFjc2oycStycHhmeU5FY01VVDNu?=
 =?utf-8?B?ZCtwRFVUeHpYUzVjbi96aWFFZzlpdGhKcFBaUk53NXByWUZMd3lJUHJVaEJS?=
 =?utf-8?B?SDU1dGFhVDlTVitPMW5lYmZHcFk3MzlvYUhvcG4zNi9QN1ZVbmE3eUtLUEVL?=
 =?utf-8?B?Q05qT1dOZmJ4Y1B4SWl6b1Vvbm5CMGcxU2NpaUo4QnhaZkRkY29tbFVLS3VN?=
 =?utf-8?B?dXBCVU5MemNrU1UxdkhVZVVrMVpzUk5YamtrSUFJbldDM2c5VlJvR2FmVzBP?=
 =?utf-8?B?bXFmYTVLWi9pK05RZU1ZdndwSHBRWlhmNTNwLytuVjlrVVVIZGp0ZlU5aTgy?=
 =?utf-8?B?aXcrdTloaUVDNzc1MVhiT1AraEVlTUNsSjkxRVIxWTZTcFpSbjhscklXYW4x?=
 =?utf-8?B?QlU1N3pKd2NybW5jbE1haStWMU8zRUl1RzRMSXhxbTB4VlBTL2R6cExmREQ2?=
 =?utf-8?B?NkRRWWFiRGh4bjJDak9sQnRPaUhxSG90ZFlFSEdVRkQzcVFqYkFuZ3VranFy?=
 =?utf-8?B?MzRnUzhJQVExa2VBOHg0d0RYa0ZvcVNCU0VkckNBbktjMnBIRDlrZDV6bUFQ?=
 =?utf-8?B?aVMvQU9lVmtEZ0tZajFjWnpMS0cwRElFWk9zNVE3NUdzOG9qeFFkbGRZMWpN?=
 =?utf-8?B?RWtRVEw0UTA2a0VMeWY5N2NsYlY0OWtZM3hQbzlMK0RpcDFEMk1nUDhrSjNC?=
 =?utf-8?B?SHhYSXhBVVdwT0pTM3E2L3hpRXozK3JiTmxjVkQwdGQxT2Q2UDhXRnAzQjVy?=
 =?utf-8?B?WUlCNTRjNTZUVThFTUNZNkVkWXZkbEZrYU5QWHRuSkt5VGV6Yjl0WVppZ2Mw?=
 =?utf-8?B?aHZUdUlZdnYwYmpOTExyQ1FnUXJNaUJaMmtlLzZyUUszZGlOeDNYTTZEWjFr?=
 =?utf-8?B?dHlPaW1IRVprNGlWWURpWElqTEdlSmtqeUhUZXhwdWg5K1dYdjZ6ejlXKzI3?=
 =?utf-8?B?WXZOaGRyZUVUZ1FOTk4yQ0o2ZUtLOEozWXNqZGlpZCtsT3A3MXdDR201djd3?=
 =?utf-8?B?bDFMRWVtSmNzeFVFVHIyaE9GY1l0VEtmTitXanJjekh3V2pldklHQ0NBNGRx?=
 =?utf-8?Q?Qa1TleROTJ4b/cK7Ppkh782o3?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	LkCqqIqe1jRLIb0p+pFAEVYFsXEQ8UTiMHxwKB4SoRljWFGGSb7n4UI7Z2JitpkPT8dtq/zy57CtA9bmnjvdKCyuryAHI6wxrzv+zzOF5QgvGc4oZVrZxOGhV09RWjvbSjYGg09+aLC3LZCMqxNWFMJ46ags+IMPjF3MJDs6305pp6o3lmWaLTvpWWMCgHFgs6BVSGS12fqdsaScDFwc/bEH06fGnpaT/RMi0XyC0Q6qqwwmARn+mPz6fOajUmlTen5lk/OU+t19oLOaZdiCXuKx2U+RRqNgJwj0CPaxqu0SpUtgL8gTv39n6IfBGtRbS/uVRdXOHn0ltApq60bwlkoqQnTUF5Z+TM+P3EcZh5HhwD1BmEVG2WSrcuBonNI/kIpzLT+ClUvFHxATeVeJnaApLj7wIP5NWGcdyg5Al5W8oJ3CNPa9oPwDyEBqFQ0dU/iRDqGLAqIOuNNZN1HqZHGBzmeKSHFXso+Ia1wWjA1ay34gzdkpVU2M090VLGWcSzxrdIMAg24GedjmB1+cvX3dnTJos0y+WrnGIJHaaTk1QE7kPP+ezHGc2bmNpQBoL2JxI8tDASFqFqRe6AyXVwDcygatdvq2uw9db3pvwG8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d27c572f-ed06-41dd-22e7-08dc6f7fc62e
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4429.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2024 16:56:15.8896
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lsuzEGLMlsPMIaqCpYD6flXyXg5IwkTGIQpeY/+Dka9KExeBxwUmgu+H+fK8+xCQsQhq3lY9haH4JMJrahFnzA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4791
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-08_09,2024-05-08_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 suspectscore=0
 mlxscore=0 adultscore=0 mlxlogscore=845 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2405010000
 definitions=main-2405080122
X-Proofpoint-GUID: FkmPXyQJWyvVBeZaLPfnBFsAR46Yc0KQ
X-Proofpoint-ORIG-GUID: FkmPXyQJWyvVBeZaLPfnBFsAR46Yc0KQ

On 5/8/2024 2:03 AM, Miaohe Lin wrote:

> On 2024/5/2 7:24, Jane Chu wrote:
>> When handle hwpoison in a GUP longterm pin'ed thp page,
>> try_to_split_thp_page() will fail. And at this point, there is little else
>> the kernel could do except sending a SIGBUS to the user process, thus
>> give it a chance to recover.
> It seems the user process will still receive SIGBUS via kill_accessing_process()
> when (re-)access thp later. So they should have a chance to recover already.
> Or am I miss something?

The concern is about real UE consumption in which case, it's desirable 
to kill the process ASAP without having to relying on subsequent 
access.  Also to honor processes' MCE-early-kill request. 
kill_accessing_process() is very conservative in that, it doesn't check 
other processes that have the poisoned page mapped.

thanks,

-jane

>
> Thanks.
> .
>
>

