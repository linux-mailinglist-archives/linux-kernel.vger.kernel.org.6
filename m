Return-Path: <linux-kernel+bounces-309280-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E9AB7966877
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 19:55:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6F3B31F23331
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 17:55:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE0CE1BBBC7;
	Fri, 30 Aug 2024 17:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="cCc9KVUA";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="PaaNX0OY"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C5FD1BB6AA
	for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 17:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725040538; cv=fail; b=tUGys4Z52Bxg5nM1z+Hq/ByB7pUZBjsJx5vMj9tPJX9RbVIzFxQ/SFIbJtZ6gzA/By2lsutvva1so4KVULGAcn7YjHCjan+CxHJTc2J+bZt2b8N3uzkXtNqJJ+BCRnctAFF0zBG3GfOfnqUX4ntxARbq4nAVfrDIlTbERdg8Qmo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725040538; c=relaxed/simple;
	bh=lmZhM5GVFwOtO4o0mlLHw7KRaViRCqzEgi9m85gn0GM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=JXphNSZN/ahSA92RvecOUVudacpXY0l9PTlbaUCL4kZ4BYrJrc14F68P9pPESw2QkW3XThvNm7hevGomWkNMDR8/GPiXEi9nPVpsT1QoAGutJwwNIVeksgVG9EO5NwSwPuKes/YCHBcv+H9mUhmCRm8IyUF6MR+5CEPjzdDYDkY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=cCc9KVUA; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=PaaNX0OY; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47UHfXZQ010998;
	Fri, 30 Aug 2024 17:55:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	message-id:date:subject:to:cc:references:from:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	corp-2023-11-20; bh=o3gW/zwvUz47z6CJibvxMvXVucFWI1GIenHTuDhd9xM=; b=
	cCc9KVUAAAKLH5pIl+eKqWj4QOM/mult/zsWuOFmGJq25v5MkL72Dws623nSLtH3
	RjWiq5xqjYNdHWw3V7MJPj09TA3l2XHle29z4gi79/0XvKlKQ/MbGKgjd0bAroqH
	AfuBtQU86p7KtB7b+CM7MtwB4yKO0ss7VHe9dhTDPKHPdBrCa75NXxuKZUNGQYIm
	CocI5fsKdHKk9F2nv/Thwqt8cv+UrNZQmEwisbKuu9KBn/785s9SPBsz+CsF3gXJ
	m5ODN+HWvUglUIe+k/WYxzifu5uohee97hFtnkpatXkm38BATa0K6uAObFqzPZ/s
	vz8K/NByuwRfoOxED5YZWQ==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41bh8t851f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 30 Aug 2024 17:55:21 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 47UHtDAP010593;
	Fri, 30 Aug 2024 17:55:20 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2040.outbound.protection.outlook.com [104.47.70.40])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 41894sbc6j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 30 Aug 2024 17:55:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BX8EvxG2NdupcIuBlacSyczsFZ1WEhcTywcvxbrhzJXP0hTsj3BuaCtTACEkn61rNMXIVpLBLL73VvoeLSjihfMO8tIK7rcUygCO9xo/pDp4MWOiY9wCOsHA681dPXCAbrkXUqCELP9Idb7lLOMlo/8sAvNIfbViZAebb5BUan1c1Rr7iQw+3WQlZYzm1aCp+dICWLbR96lMUEOJOO6Ur5aeI2XUWzWcHPEHZ3wYiknvGO4oUNNi8HNxSfU9qwQtjF5HAkmjITXHdeb6PFIRUfhBAB9mrHrpZC0A6KtynxohNMSNMg1s6g1XVoro2frDq5YCMDc+AEj8A7EaTU7itg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o3gW/zwvUz47z6CJibvxMvXVucFWI1GIenHTuDhd9xM=;
 b=cEa4mqZX2f5RpG9kPES45s/g83f/4noEweMxQb36AJMnxuz7c8rqoa6X2AcwqjZ+boKXLXB4w9yWdirz6pGxKKu5QIQewASMuGKVTm0uGSDOCPeMyeUZtcA9xiH+XVV12+Li7ceeXrNNrRCdAMKYwypbcS86UMY76pNkWwGBM8CFNPo8rkK/IacAkul5FQIDizpv/3djit3sLkTTDYagkAsygWQcu574JVtJzl+3mB5MprWGaSFtggwv3c4XjAaFsINpyJ7ja7D8NN5dXMYRs2HDejdX3ByjxHDj0JvWW9iB6L7iYby7Lz80UPsPGd7FJ4U+kVs+7wphd912EBXPyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o3gW/zwvUz47z6CJibvxMvXVucFWI1GIenHTuDhd9xM=;
 b=PaaNX0OYGyYMkk+ssGNFFNET17He0u3GgMyKDXUpXC5Q/wuH5Z3oh36UtNrezFJZikYhccgrBJh6imndw71CQ4fOeFunht8r+Pd0gugxXBFvB6Kl77kPaQkH2V9inytgUF3C1vBe7o4rWA6IokSNssPIAtZJVr7AQ+2gSuoXsGg=
Received: from SA2PR10MB4780.namprd10.prod.outlook.com (2603:10b6:806:118::5)
 by SJ0PR10MB5629.namprd10.prod.outlook.com (2603:10b6:a03:3e2::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.20; Fri, 30 Aug
 2024 17:55:14 +0000
Received: from SA2PR10MB4780.namprd10.prod.outlook.com
 ([fe80::b66:5132:4bd6:3acb]) by SA2PR10MB4780.namprd10.prod.outlook.com
 ([fe80::b66:5132:4bd6:3acb%4]) with mapi id 15.20.7918.019; Fri, 30 Aug 2024
 17:55:14 +0000
Message-ID: <b4cbb2e8-bc21-4af7-b092-081201302033@oracle.com>
Date: Fri, 30 Aug 2024 10:55:05 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH mm-unstable v2 0/3] mm/hugetlb: alloc/free gigantic folios
To: Yu Zhao <yuzhao@google.com>, Andrew Morton <akpm@linux-foundation.org>,
        Muchun Song <muchun.song@linux.dev>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>, Zi Yan <ziy@nvidia.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20240814035451.773331-1-yuzhao@google.com>
Content-Language: en-US
From: jane.chu@oracle.com
In-Reply-To: <20240814035451.773331-1-yuzhao@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0098.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2bc::15) To SA2PR10MB4780.namprd10.prod.outlook.com
 (2603:10b6:806:118::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PR10MB4780:EE_|SJ0PR10MB5629:EE_
X-MS-Office365-Filtering-Correlation-Id: b981ab0d-3d62-48e3-c2c3-08dcc91ce651
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZE1KNDJ5RGNYTU05TE9WSkdPTVlMbzIxR3F5OTFHL3VwTitDQ28vZnVneXJU?=
 =?utf-8?B?Mm9McmI0YmZzVjlYM3M2Y3lYelFrWnZPQWNhVVRDM201SGs3Y1hUQWJORWlo?=
 =?utf-8?B?VzZ4TGw0TFc5ZGh5QjZLbzVqeFlhcWc0N05VaGVaQm5kRlZKRGExV3MwSWd2?=
 =?utf-8?B?QXpydXVBaVFEdnBJM3Z4SUNHZUNrcTlaYjVYZFpLYzRzb1NNcE91M2o2YURL?=
 =?utf-8?B?NDRVTG1DOXo3eENDTWpha1A3eUEvdG1ObThCeldRS2l6b291M1ZGLzIxdEVh?=
 =?utf-8?B?RFJKeWhmYnhxUUp5YWlZNlNZY3Rua282aGh3RFpkOTJkOUQvWExjcll2VURE?=
 =?utf-8?B?TmZSMVQ0R3ZVc3lkUmZ2NEdmVkcvQU9ZRmZvcWxudk5LbU1yQmFXMWhkQnl6?=
 =?utf-8?B?ZHVweXlLUGJHRjBOdGNqZXdYVG1iSWFlaWQrZzdQc3VINVhaMm00TWVrS2JS?=
 =?utf-8?B?V0hNcElFTjZGbmxiajJkNFFtSVFWcXFsTk4rWGdUSXVxQUZzQnRuM1drdDR6?=
 =?utf-8?B?QWVTNzZYOXhON2VqSXdYdVpFT2NKZnlRNDdrcFNROXV6MzFTZkJwdTVlU0lN?=
 =?utf-8?B?dTBNV3dCQ1loT1Q0d2ZES1MvazZqUlloK3JoWjIzUkx0bXQ2cTZ5aDNQREJp?=
 =?utf-8?B?S2l5MkxBQTkydkc4TEN2K2hubitpVGplcmtVek4rYXA2aW82eWhlbXhqSWww?=
 =?utf-8?B?WXRMSmFFWERZRkRrN2czbXJWZ2RNemQ0cmVZMWhDcGlhRmpWbGZ5WXd4RVQw?=
 =?utf-8?B?eWJUTno3cGFUR2F4VFh0RW9hRmNtclMxV1p4VkducDdibkVkNzJnNWo1NERy?=
 =?utf-8?B?dXM5U253UUZ4TFpadnVlaW5nc1pqb2N2K0RibkJGWEZxL29YZSsrb1hNNERt?=
 =?utf-8?B?Z3pPS1g1R3V3Zjd2ZnRFcGM4YlpWVllwcncwbnF4UGtmd0tHZk9WMGZUM0NX?=
 =?utf-8?B?akpRa1QyVC81cW9FN3NTcHhSeTAvUjQ2WmlBdjh5NWhsQ2FmMkNnMG9xdVJB?=
 =?utf-8?B?LzFCQjFyMmFTTVRLbHZBV1RpbUdnRitZMHpGUDEzWlpqK0ttcHFGTWlGUS9i?=
 =?utf-8?B?RGZrZ1VrRzBrTHlVUVBUWnI3TExmcGgwUFExOTM0VElMNGh6b1FWYzlrTUFt?=
 =?utf-8?B?YkZ5dW1oM2RvNDZ3Q3RObXRBMHQvalk1cGl1UUtiSjUyWXNvSXgwNXNJbDRK?=
 =?utf-8?B?a3lRMGUvYWVBOW5zeGxsY084Q2NkSVBGdjRROHVSYlphVkprSTRFRllZNDRt?=
 =?utf-8?B?OHNVTGZERWs5dzh2WEpYSStDL3ladjIxVWhlaEJmTzNnaEtQeGlSdjEvWnFU?=
 =?utf-8?B?MnVoZ0NGQzk0c01sTzJHVVhkQnNhQjEyaGx2blNPMVMvZE80RytyOHZQMTEy?=
 =?utf-8?B?bGk0VjNrRkxuWEQxNEFYcGZabU1LN2J0Zm5ONDA3WTRobFdXKzBlZnVIUnVC?=
 =?utf-8?B?eVl4cjFxTTE3b2xHNFl5MlVtYWJiaWhMYXZ0cEZUc0hyeWdFcFNMSVM2aTlV?=
 =?utf-8?B?NWdJMmZhbDNpVnl0SVdhbGZVUVNaQ2lhSFAyTFJhUldzeUhBVXdoSzlHRFBr?=
 =?utf-8?B?dTdWMWxOM3pvZGZMNlJ0SDlXUFhZdGFpcjJRbWp0SWEyekkwODBzN2dodURK?=
 =?utf-8?B?ZnRZaVBiTWoxUzZCSkdnSlhXdDdwOHNxTXRydGFHVlVhWnJRK2VCeG82UGJ5?=
 =?utf-8?B?aTFEV0ttS2hxS2xDR3lJYUc3RTgyNUxmSXl4QkNqMVBZM3VpVkNSV2FDeEN0?=
 =?utf-8?B?WTcyR25XS3hWWHNRWjJ6RmVoZnpGdUMvMHB6MnQxZDVNc05LVUpHYzYrQWJZ?=
 =?utf-8?B?SGZGUitQRXduV3lQeW5odz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA2PR10MB4780.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MnFnS2s1VEdEOTJrYnhuL3ZtbzlaMzFaeXlsM3A3Y0wvZGx2R3FSSCtrdmRC?=
 =?utf-8?B?bU9rb2pxYmFFZy9EOFdlZlNGMndQZk5nMS9GUlRsYUl2aW5JNEtxY2owQnpv?=
 =?utf-8?B?cGI4Q0hXVjFrNDRRUTZ2aHJOZ0VFWjZIMUlSN0pLYzFMeUN3RWJZSVVnMCtN?=
 =?utf-8?B?clNqZ0tXTExJRUI5UmQ3WUNmNnhHcjZ3K09IdGg5bDRGZ1lPSUovRFNYMjR3?=
 =?utf-8?B?SlpGcFhsdUFpZURxektVc2FMOG80a2pIV1NRNzliWVAxU0FiMk9uM3p1NW44?=
 =?utf-8?B?azltOVJJUzZSd3RXUXBFNllCVGJ5b2V0MzVwRW5mdFpJNmhNQWszT1pTNGhX?=
 =?utf-8?B?eVNwMXlYUU1Demczd0ZVMFM3T0xndklnRjZzNGFkNndvZUFOMDBjTmFxNURE?=
 =?utf-8?B?ektWc1ZrVkJUQWU4d2FIWWVwMXp1ajZFRkJqM0p1UlEzWnRqWEZnWERTaU1x?=
 =?utf-8?B?OG9PTVlWWXhUYTV5elBnc3ZTMDQ4TUhRUnJVejJpVGdyVjRxVHlRMmJqSHB3?=
 =?utf-8?B?a3U4VjN6TGMxMnIwTmdxUnY2UEpqM29IblU1bEx6TUVLaDNNaU95QktaUFJE?=
 =?utf-8?B?ZTBBai8vZVFBTVByMmV1ZVlSL2lWZkVtZHdWVnBiWFlhSGdLM0plc2JqSWRG?=
 =?utf-8?B?dTlCM2pneXBwbkxnek9yQzgzS2htcGF5bzVPN0JTL25UdnFnZk5TT1BvWmd5?=
 =?utf-8?B?a1JpcU5PS3QyamtuKzBybzR3VngybXBUVEFpVWxVdkJueVQ2WG5KdXlORDBk?=
 =?utf-8?B?NHpvV0VCaTZwK05RSm0zSE1vRUJYRXZDRmNUZXA2R3haTGNzTTlJdWJXVG02?=
 =?utf-8?B?bUFBU2RmOGoxbTJSSXVVNmppY0tUQ2dKZE5xd2V4eExHdzFPRWY1Ry90bFZa?=
 =?utf-8?B?YzE2ZExlTzVXWWZnNTNvUmZXM2NsMWFXZitpb3RWV1h6TGUyWmZDUXZjYUxX?=
 =?utf-8?B?emt2Tyt5cEZTZUUrSVhiMDJ0cDVKdlBkdUtnZDRZWTd2aWtObUlVK2I2c1kw?=
 =?utf-8?B?UU4xU0lhZ1hHMkp2S1lMZVEyNklkczNYYS9PWHVMSEFvTGdqQm5obWVaSzFn?=
 =?utf-8?B?bW9haHRabnA5NnRZS2JpanpXWUpqWDEvQWFTWGpJN2lZVnhQcElYS2svZU1F?=
 =?utf-8?B?Ry8vODVXNUlkRjdsTXhmaGlVb3ZJQ3U4S080b1VYRVZwNDVVcFZwRnlxM0JZ?=
 =?utf-8?B?UyszNnplVk9YMHhBNjlQRjV3ZWE1ZmxrYU05aXRrc0JJRVY1VXJGelcrWmln?=
 =?utf-8?B?ZmlNemtnazJUQk9kS1lIY2dZZFRYMEgwb2JjVmVLWmYwUkJFSy9ZUUo3NDRw?=
 =?utf-8?B?WWFSMkxTWWhuQ0hQekdObnczVlVPMUJmUlpvYk5tTm5wZStWb3F0cmRqTnd1?=
 =?utf-8?B?K3lXcFgyWlRsSFcvS2t0cCtwRGd3V1dSYURHM3FFelkxYkJDRUJubGdqc1U0?=
 =?utf-8?B?MVZDekY1a2VPd0ZtMlMzS29mOFd4Y2ZjUXVrUUJoN0dqeVg4b2JwdmVra1lR?=
 =?utf-8?B?c1doM1BWeUE1OFk2dGxOSDBubGZPc05HL0h3a1BEK2lNdnE2bVN3WnF3c0ps?=
 =?utf-8?B?N3pzMWVwK2pUQUdMQzNEWEFEb3h2TURFNmlJdDI2eGNLMVpRSDFPZ09ibnY3?=
 =?utf-8?B?aHYwbk5LYTBhcUROQTNVdG05ZmJUWk5VT01iYjduMis4aFpMZHQ2QlBsSmZV?=
 =?utf-8?B?cTJ1ZDNEYWthUlRCSjVBZ1JVQXFWSVlkMzRNMy9hWnNtUzVIVWRlY0JHbU9w?=
 =?utf-8?B?aFYybW52TWVWZVhpRnpMQUgrV0lxcGxjM1k3WGdHZmdWbDdoam5sRUFvZnAv?=
 =?utf-8?B?bVJtR1Q3VGxIdzhnNkd6bGpqWnNncnlLVm9keWIyYlQzbUNiaTdlQnJraUpV?=
 =?utf-8?B?R2UzSVRoZmJEVUtPRHF1ZTJXSlpwb2hmUU1LS2x4VE02WFlTMzhBTFkxL1JP?=
 =?utf-8?B?bWV4cmlmNll6WFhUTGp1K1ZlamRsVkFxeE9MdlZoZ3R2L25FbStBYk1mUWdy?=
 =?utf-8?B?ZTNGVC81NG0ybGdNNGYxNzBOK3FjMldPcFBNMGRIN2tDdG5FQzJ3bXhUN0ZQ?=
 =?utf-8?B?UmtPWWd5T0Q1TTcyYnBSdVZyOEJreG5hVkZabGVhLzRCV1R4bHREVy9hY3d2?=
 =?utf-8?Q?gsRK2NGCP13N6Od6GS1vH69RS?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	2idqLRUuBkVkD3RGEn8hyazvjVxTbFgW733KzNcrhqGL5sbjxwW1Vblz5iolSaZ5QaHhhB5aqMGh//euZpKoQy8EZ2qHztK/ys0P6iK9GXaMivscxltdW3CqXTawEgfdpGEo8KkWVH3vtb7I08oGlvqsM1+VoOlzR7Sm1yvtS9CA2oaWVQS5ZsCvf4aVCrjOAJ+jgBNM+oYCrbDdYtqw7M7mh1QghILcmxxSOPpRwAr1oHI4mtdAqoxKAO/8seKFTyadUuHO/1XInjHHH4h1bc6/sZOVQQnLXDLpIIbS7WK2q1U5XavXdGYCN3xEQNKMn903UbxD/ED3IvDS/lKWY7SV9uwPO3ss8Ju7UD8afyfGjNxEJCxy792B63HPypkJAI1O12WN5V+Z5CVrFg8VyK+FQu9EpK8YRWtZlVkWqKqB+OSpccPko9LlP9KU6+yzYzwaw3+uyBWYVCP5VvDbhlTSUjiRNJJNOfQNF8GENfG92h26FVrVtxtB6FHzUx6v45Yd2SgTWJyUaU3m6W6Pa+VIfoMPRhMYhReFNleLRVvZE6hH9/RYwYgQhzIAz6tsoNWYRmr/0GmZVAXzxUWraiwsEwwTEJDy3hWMk+9pyEQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b981ab0d-3d62-48e3-c2c3-08dcc91ce651
X-MS-Exchange-CrossTenant-AuthSource: SA2PR10MB4780.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2024 17:55:14.5931
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8hBK/avSKVyLWWiyL8FKf6IshKCcPw1m6UpUPsfDQtJhRsP7k03ZSROloyD9YHLyGa1C4DjGOk8276GM/slfyw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5629
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-30_10,2024-08-30_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0 spamscore=0
 mlxlogscore=735 adultscore=0 suspectscore=0 phishscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2408300136
X-Proofpoint-GUID: OxHqtTbN47Z-tarv8cKKscQkrdzZ3-JB
X-Proofpoint-ORIG-GUID: OxHqtTbN47Z-tarv8cKKscQkrdzZ3-JB

On 8/13/2024 8:54 PM, Yu Zhao wrote:

> Use __GFP_COMP for gigantic folios can greatly reduce not only the
> amount of code but also the allocation and free time.
>
> Approximate LOC to mm/hugetlb.c: +60, -240
>
> Allocate and free 500 1GB hugeTLB memory without HVO by:

Do you also have numbers with HVO enabled ?

>    time echo 500 >/sys/kernel/mm/hugepages/hugepages-1048576kB/nr_hugepages
>    time echo 0 >/sys/kernel/mm/hugepages/hugepages-1048576kB/nr_hugepages
>
>         Before  After
> Alloc  ~13s    ~10s
> Free   ~15s    <1s
>
Thanks,

-jane


