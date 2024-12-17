Return-Path: <linux-kernel+bounces-448334-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E442E9F3EA5
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 01:05:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 65AF016A206
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 00:05:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A9261361;
	Tue, 17 Dec 2024 00:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="XisuASAR";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="uYOSI+aM"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 638428BF8
	for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 00:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734393919; cv=fail; b=OldoAA3azL72JENDqb3Nzzef22nYxtto0zayI+CU3w7TuCYK6w/WR6Wam7Yeg8WTu7LOqoqrJt9bJ5RSw0k4sJg7gRMgxtLB0jsUsPNJlkxdZxYErhx1+xgmWvR2Q7sEHygJYoMFrEyTaLOX2fF3vhToc9xAshV7ZtampSwRqAg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734393919; c=relaxed/simple;
	bh=rnm2n+Q4FN8Jsz9wUhfy0/pal9VtmeP3NueWq9rSLWo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=UkfC5hNxbL09BIjnmzgRTcwl6FjITugChD1xt33EEwu0RT/dOiy9YkhoUuAAwwzqaxfwvfo6EWKWrLnaHWjROgE0CB3CCLcO/suKpQQtkY3Hz9AnUmjXJZEw8KDEUD4VT0Koc4WQq3H8gLLSkMJJOelTNrq0lP94V4tUmHBpMGU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=XisuASAR; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=uYOSI+aM; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BGMjVWa032036;
	Tue, 17 Dec 2024 00:04:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=nQoxZRNR7B6ECCVKVIPeejtL4i0An8AAfQMGvg4rN10=; b=
	XisuASARJS/uxYj6Vfv1GQB+iUhWGqgGtG+NXfgDKhhcge1eVRsFpSZn/sHUSP/x
	QZTTuANnS9o7UWl7ms77HwAijbO3ZB4K6SP0U3BAcG0fvHsh9j2Xtf4SFfGWJuhu
	WxfXPA8kCCrsaSooOYMZTP6vLL1jps9so9XqelR/XMvv4jeogOB76pIoVcon2Y//
	30W6Cu86MadiKmQ2YVpTXQUXyhzjfhE0exyG+rsogBLteaMxRHdy3nNiO6jg+5b0
	LI7lRtj2VBBLgjTWn7udhhDUplThp6X7jwUfIyIhICA+m6bZ5cjJib3iQ4afb/TE
	uf2v1bwwBQk5meSLyQvjqw==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 43jaj5ajce-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 17 Dec 2024 00:04:54 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4BGMkadD000614;
	Tue, 17 Dec 2024 00:04:53 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2046.outbound.protection.outlook.com [104.47.70.46])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 43h0f7y9qt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 17 Dec 2024 00:04:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Liq3j6jueAh6OS/+SFb349EWcI4s8tdo7ImaKhn+fB/KRby3BOmUsKtSCYzl4WHhc0JuYZcNZOwQhPc4djU85/9hD0OB7mKd6xOvI8dLs87akbMnyQq+XKPkiMWELatAy0f+Wh9tiOSgB7yJZ1woTYHt4YzRYuotxYIGx105cZmdlKsMEOpVVA95H2Xz9owQw0A6Oegt7cnVP4YUhGbQOGF8hd7X9LegLXQ9gJtWR3cZg27uqFWtDx2lvp2SkUIFtNIsyVq3IViKVl+9ZWoXCzHYLJOQ/unlsPFxiJjDFTVUD3CMe5LLidyL0fTqbmL+iFEIKcVL2BC4wLPbVKoWGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nQoxZRNR7B6ECCVKVIPeejtL4i0An8AAfQMGvg4rN10=;
 b=lYM8KGwptSidZJHdSmyubniB/QhikB9yIwu/PLXpDCP8r/aHFqQYMOuWVWZB8Egn4VTZdkfZ49nCFr3TO4IOxbk+VKfyM3ZNwIWBH87RXCa47MbyRFT59gsPgTYFxzdg6+FBDBs76zMVmpi7LNxCY4qQlrosGvfrgJw1mZKO0rPw126GMQYGiqVZsL5828izIdHW3kQAe9QUBkn9wJIvrrN25hoTcoJ5sFnQhNiRpWJzhpK1HGkZ9n4htl+J8Ofj6cZZ8cFez3QFVR/swxfwGWK1Gjqi3ZQKpqt5DIqnzrqTMZIWdaBEXIjk1mfxupcqk81CVtPp69at63TLaVyZKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nQoxZRNR7B6ECCVKVIPeejtL4i0An8AAfQMGvg4rN10=;
 b=uYOSI+aMK+POL85z/Y0oG+GQKDlOX/dI80xw3awn3oQ5f1IRcsRW4aY4v6iJM4pWB/iXP2D9M235K/FDS5vIlz3sMW2WqceWSy36DVefN0FwcjGE3C0LdrAvAihIb1BW5LzcV17LsaVfyCwg3gCTyn2VV6B6fB0M4rKdh/0lmgE=
Received: from SA2PR10MB4780.namprd10.prod.outlook.com (2603:10b6:806:118::5)
 by DS0PR10MB6728.namprd10.prod.outlook.com (2603:10b6:8:11c::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.22; Tue, 17 Dec
 2024 00:04:50 +0000
Received: from SA2PR10MB4780.namprd10.prod.outlook.com
 ([fe80::b66:5132:4bd6:3acb]) by SA2PR10MB4780.namprd10.prod.outlook.com
 ([fe80::b66:5132:4bd6:3acb%6]) with mapi id 15.20.8251.015; Tue, 17 Dec 2024
 00:04:50 +0000
Message-ID: <b2c4af25-3213-407e-a366-8c5a0511c30c@oracle.com>
Date: Mon, 16 Dec 2024 16:04:46 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] mm: hugetlb: independent PMD page table shared count
To: Liu Shixin <liushixin2@huawei.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Muchun Song <muchun.song@linux.dev>,
        Kenneth W Chen <kenneth.w.chen@intel.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Nanyong Sun <sunnanyong@huawei.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20241216071147.3984217-1-liushixin2@huawei.com>
Content-Language: en-US
From: jane.chu@oracle.com
In-Reply-To: <20241216071147.3984217-1-liushixin2@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR13CA0034.namprd13.prod.outlook.com
 (2603:10b6:a03:2c2::9) To SA2PR10MB4780.namprd10.prod.outlook.com
 (2603:10b6:806:118::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PR10MB4780:EE_|DS0PR10MB6728:EE_
X-MS-Office365-Filtering-Correlation-Id: 8a63b731-0bdb-4c5f-eed3-08dd1e2e6d00
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dG5Qemt2N3NoU0lMZnVRSlB3SE9qK2w3Ujg1NVpGc3luUk53ZCtyZmtKMFNa?=
 =?utf-8?B?ZFNXa3ZBeHRuc1RzV05vQVRQQnRBNmtlQ1FaNGpvUjVrVGFhU1IzQ2t3OVIr?=
 =?utf-8?B?SjgvRDZ4OTBsOEh3ZmxBT2RnVHJCY1RSZlRjWms0ZWtETnpwRDRkUnMremdX?=
 =?utf-8?B?NXNXK3JiVWZIbFY3b1p2SStVTkRkalc1Ri9JeHNTa2RWMWY2Rld4cHU1MDlI?=
 =?utf-8?B?Q1J5MWFFNFdZUGFjWXJnY2NFd3lnb2hzdWxEN2JYeDhBUkU2azkxODNzNXdj?=
 =?utf-8?B?ODFFdlBrOUZ3Y2czVEFlZXFrWjRSMnpmWHZtZ29ZMjhtTTRicGtaUTU0cnQ0?=
 =?utf-8?B?dnExbVMzdjRpUnVFWlFsZHN1bmlIMmUrTUJYdUF2aitXUXpZVWhNb1ZSL0NN?=
 =?utf-8?B?OUo0SkVjdDMvcmNsUkZyMEY0ZkkvN0tOc1FmWmxNTFp6UUVwRy9DV0xOYnFR?=
 =?utf-8?B?S1lPeWt3eWhYb3VwNWNiWEF5Ni9iRzdXK1JFQTAzZHpOcy85ajdrVGRiY0Yx?=
 =?utf-8?B?bzZBbHZOUHVLL0pxSDVzeGtQMkw2c0pQMkJ0cllONGViK3dIM3g5NHZBRW1F?=
 =?utf-8?B?SXNHczdNYXJjTE1FTFEvUmtFYWI1cm5FMCtvNUhTREF2RzRrMi9ub3J2eFRN?=
 =?utf-8?B?T2JwdGNTdmltRVJyOHdvUWhoYXppT2crMkErZFNQMEpJWmdWMWg5bnp0NCtj?=
 =?utf-8?B?R3NjU2xkQ1JydVJpOGpobGdZR1NTMEhWYTNxNXF2d1NBZC9iMjlaOVMvREVV?=
 =?utf-8?B?b3ZkRjdDL1NhTXpJb2JNckR0SU1HQ29Uc09scVprZWtBSitTUHlqMnFNZUhn?=
 =?utf-8?B?a2JyVGI3UDR2TjdyYkJ3WFVhek5NaFVkVUgvT25yblViMUZOZzl5eHhjZVQy?=
 =?utf-8?B?YnNoQXZqTmUrbm5zUTZ3ekp0U3VqZnQwc2FaM0JGWkdGSkNsZTVZc1hvd3hP?=
 =?utf-8?B?TDd0NnVjS2xYZVpPT2FlMDdWU1hkbXp3N2hLcjZXQ1VvMkx1NnNuRzRzaHlE?=
 =?utf-8?B?K2JDUmFVWkVxU2tBVkowQ2grbjUxeE5ucUxHdXVUWlZuR2FzOVMzN3Jka2RJ?=
 =?utf-8?B?SEs0UXR1ZnpZZUk0TU9JaU1uWE9naVZhVlNKVk54L2ZLdGZDdXhsYzdpRVJr?=
 =?utf-8?B?Q0xDemZ0aXRsdTUwd1Y1UytNSzJKTnVWb3ZqeTg2MlJidXFQRy80ZlN1ODlm?=
 =?utf-8?B?NFJ5Rm52ZGk0YkVFeXJBc2RYaTRiUTcwSUNRS0tmaVR5RElGdWthMitwMkZr?=
 =?utf-8?B?Nk9POGtFdEZiS0NlenVlN3RXUTFPMTk0L1VSY0JhZUYxdVkxQjhpck9aTlVC?=
 =?utf-8?B?aDVhQlgzaE9JeitFdkE5MkNvRW1IeEUrcyt2cHJQOFNzTnVJR1hmNXA3Z29p?=
 =?utf-8?B?cmVuNVpJbmpqNVEvM3JkbEQ4WTZ1Y1lQNWhkTXNZN0dXUE1yVExPNng0UHhr?=
 =?utf-8?B?bzcxb2hSbWdnbHN2czgwL216QStNRnpsSDVSMjV4K0w1SjJFb3g0QWNrRDdt?=
 =?utf-8?B?YXg1bFVzaDZsNmlPbzBFeUJpb25EeE00SlJVVXNDTi8vQlo2SFEzUVJuTnlQ?=
 =?utf-8?B?eXBtLzhhdUtNM2FQVTlyUTMzZklEKzhiaVROdUhkQUN4MmRtL011eERRUUlB?=
 =?utf-8?B?RUZEUGdFMk5yQVBWbng5OG9hc1RONUxNMnJTS2ZyZDU1bHFXdHZBMzJGZnpZ?=
 =?utf-8?B?TXZKeEtHS0JqY1VLTFVTTVMyZDd3YUszRVJnT21VNXlOK2N0UFB0YU5NODV2?=
 =?utf-8?B?bXdDYlRzNUVDSW9ucHlhanFzWGRwcG1xNHdIWUd0SlNYUzJpUE9JYVVoMHVM?=
 =?utf-8?B?UTR4ZGpzRHlodGlFajIzZz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA2PR10MB4780.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NEpFZndNc0JvSVU0N1BEWEpkR284RW1zV05MQ0IzQnJlaUE0WjRoclpwNHJX?=
 =?utf-8?B?ak1BVmh1U2hnd1dPTXpGcjRrUFQyMGd2M01UNG5WNHdQNWhVZ1BrdWV4S29n?=
 =?utf-8?B?N0MySDZCZGFFeWFYZkU5aVZYUjNRQk55Tm5pckgwZldLUjJhVVJiZlB4MTR3?=
 =?utf-8?B?a3FUQll5NjNqVFkyUnE0M1pxTlNlVk5uVjVZRXZoQmVYNmRsU0lKY3FJblM3?=
 =?utf-8?B?SExRcWlOdUx4Y2gxbWNFTXI2MVZnVnR1eUJGOFFpMC81QnZXK2IwUDMrNk9U?=
 =?utf-8?B?Rk9KVmsvQ2RhZHR5K3BERXp5enJRMTRqN3l6V0RVZFRuUnZtd3o2bVNUQjh0?=
 =?utf-8?B?UHlSYUNHWW5SanVGWG9FU1ErbVR0SWo5ZGRoTmNDQWcwYVRWb0Z4dUdnTHZy?=
 =?utf-8?B?ZG9uTW9HNSt0L2Qrb0ZRN2NFOFZWbmloSVVlZDN3b2V5M1hITkg3SlRvWjlq?=
 =?utf-8?B?ekdrdm9SeTlMWUlzRWcyY1NtZVdmN3ZmWmMxTTBtaXBmTWZQVzcrQTZsYUVW?=
 =?utf-8?B?dGl3Z2l2OVBmdm04NlJaNkxnMEVxQ1luR3RhU0xCT2hmampEZ0ZYaVhVQWZw?=
 =?utf-8?B?WEJ3a3VkWWt4TjQ5TXpIMWoxLzNEWGp2ajhFajFTY1FIVFNxNzVSUDg5aGI3?=
 =?utf-8?B?M3RTZUx1c1Q3aFMzeWV5bUUvYkVDUkNpZXFsV1A0Vk9hVWVWQVRCU3pDN3po?=
 =?utf-8?B?VE1WbVMzcmtWa0x5eDA5NThrZzhxWFhUSkdYSWVxa0g3RVVycmdXZFNIZUFS?=
 =?utf-8?B?Wk5XVjB1S2JxcHg0Rk9hdURaL2phNmFFZTNuTXBRTENCUTBETWRDKytjMGpY?=
 =?utf-8?B?RVdEbU5ORENoKzVFYjk1YWJwTmRDY2t4ZzcwaVhVaFZqcUMvVCswQVpPdXh2?=
 =?utf-8?B?d05wVmNTNmVnU05NRWJuNGJZQlFhbVlUOXRVYWlrRG52NTBTOUl2QnVvUDln?=
 =?utf-8?B?WjZsVWd3NlBzeW50YmJYQW9NTHdVckg0ekVxNXhvRGdLZFN1YlA2Rk9Vb3V2?=
 =?utf-8?B?dEkrR200Q1BjSTRuTTd4dTRNczJXak4vd0FRZ09wTmlNcW9HNnhTTDlqd0Qz?=
 =?utf-8?B?RThLMWV1Rjl5bjZOWWpsbWZFYmdXSlpTSnM3a3JFYWtyWXRhN3NNK1d6Qkds?=
 =?utf-8?B?OUtIR1U5d0VwaXpTSlRZbUtZd3BYMEZtZEo0Ujgxd2VGV00zYjltNEYweW42?=
 =?utf-8?B?OE9QV0tuNGpNaVZpVmNCb093aE5mNzgwTllsZjdMQ2JZWWNKNGl2NFNGelhL?=
 =?utf-8?B?Y21RdjBGZVQ2MGdJMTh3clQxdDltekJMZjBqKytjQkt5cTc1NEFjdVBjR3Bt?=
 =?utf-8?B?N1pHL0RzVXNGYmZLWkUvSDVla0VBQk85T2toamJoYmsyMWs1dkhTUW14azlE?=
 =?utf-8?B?SjVBd2NZbUIvcDFNVDY2ZVVlMkhSVlRTdzhJeFU0OFZYeFJpYU5BYTNTNGM4?=
 =?utf-8?B?cDFMdWYrTGlnR0ZBeXVla29nSzhHR0tSay9nVUxldVZ1YzNuNUtuQkQyUTNE?=
 =?utf-8?B?cEk0bFFCa01mWEIwdERvc1lXYVJOV0I2R1lFaVk2WHBZaU51WWxUeU8wTDBI?=
 =?utf-8?B?TndCLzQ0RFVqTDRQeFhHRzlST0JJWllsTVFzRHBCcEJ4dTZ3S2l0V2hsV3p5?=
 =?utf-8?B?RHpiNTJ6ZDE4Z1ZWOWlpK2hLSU56TkJsU2VHcStXVmVJMjU5TU50TXpXTGhL?=
 =?utf-8?B?cnB6Ukc2VDhFQXlrV0FOQkN1dVVpSkNJeTZSTkFubWp5dFFpcnloQUNSOC9O?=
 =?utf-8?B?T3h0Vi8vQkVGS3ZEY2JOdXdaOFNia2MweDIwNGxLTW85NWxDbmtSbmMvVk5G?=
 =?utf-8?B?Vzd2alJ6S1BWTmxYY3JHR2ZiRHoveUVkR0VqUks4UE51S0ZUOE01ODZBdDgv?=
 =?utf-8?B?SWNoREI1VEJCVHphL2Q1NGZTZjg0R0VRcWpzVjRaMzJJVjBma2tEWFY2c0dx?=
 =?utf-8?B?U1ZWbWxVRURFTVhBUy8xSHF3R0UyU0RLamlvWm5oeTN2M1lmQ1Zoazg1Ujdu?=
 =?utf-8?B?cCs4ZXdhejFOYTg5WjhzTkRGU3AwNzV5NDg1b0V4RUNScS9iM2ljWHlPSEtJ?=
 =?utf-8?B?cFpPa3RhUkxOUHZRNGY3Yjc5WENMMjkxejdZMDVnWUQ0U3VZbTB6WXZnK2pI?=
 =?utf-8?Q?scnaxoiU5645G6a+UQvO6csgh?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	636ORaJKFxN7rFzvRj/exYeMrmNV9mg38sjsMXGd8kWi0pL+PHmwH/Wm8qvDhFHGfEUZ4ga5+Nr5fgT5vwp006jl0r58oR1MDrlN9GJqEQbSgayLoCkYo2TWdNcxnXbi1kIh9QJCsV92S/GGC6anqVlPs3sGXEoKp1wCz0aaUwQsXkiPQaHxx4d/HLNDZ4Drqyu6g1rOApHZP7OYdvKx2Oc3dOhI/Xe6Pu9Mo/sK5CUuNdPG+1t2VvnBTnlepBFLJlZyL/sFVbQWqnTPZvfxeUUimawn0tjxgfGZXOPzn/gjiPOaVPzIJibiIZ60hlPrgb6noIV8R+zqwRRwPyH2IoLE9FSvsMfRep2dPyhmh48ABVA6m46YARm2s6WuA4qsUc7mnBwIVYlbc3zCoyzwzGFNQgmK0P8bq+prsoie2t56sNOYEM6Kr1zgIuUoAJdpfoK6EA77WF5Si2wpib+x0EIxCxtoAafJ6pAhYCdfNcWLEr+QUuC1jDRZTk7BsYAidzs2gxnW0RFGluvWHqp6o9oUFS7VV1GNsxFDCOZWpaU9YAgtR3ADGYdGpFZ171uZULI4OQ3OdhB1b7YDkGb9QE/X58x9lOX3J3OwY5HxN8c=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a63b731-0bdb-4c5f-eed3-08dd1e2e6d00
X-MS-Exchange-CrossTenant-AuthSource: SA2PR10MB4780.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2024 00:04:50.3933
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PN3D/wLbjRGo1gJfK924pRKogfp4AfL37iPjek3WwXlDaIbyTiut6lkTrf915J+1aVWI/7orS2lwqHTKlHRhyA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6728
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-16_10,2024-12-16_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 spamscore=0 bulkscore=0
 suspectscore=0 malwarescore=0 phishscore=0 mlxscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2412160197
X-Proofpoint-GUID: 72LlWP1LLNLHn1KONKxVVwiRrVFqcKtm
X-Proofpoint-ORIG-GUID: 72LlWP1LLNLHn1KONKxVVwiRrVFqcKtm

On 12/15/2024 11:11 PM, Liu Shixin wrote:

> The folio refcount may be increased unexpectly through try_get_folio() by
> caller such as split_huge_pages. In huge_pmd_unshare(), we use refcount to
> check whether a pmd page table is shared. The check is incorrect if the
> refcount is increased by the above caller, and this can cause the page
> table leaked:
>
>   BUG: Bad page state in process sh  pfn:109324
>   page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x66 pfn:0x109324
>   flags: 0x17ffff800000000(node=0|zone=2|lastcpupid=0xfffff)
>   page_type: f2(table)
>   raw: 017ffff800000000 0000000000000000 0000000000000000 0000000000000000
>   raw: 0000000000000066 0000000000000000 00000000f2000000 0000000000000000
>   page dumped because: nonzero mapcount
>   ...
>   CPU: 31 UID: 0 PID: 7515 Comm: sh Kdump: loaded Tainted: G    B              6.13.0-rc2master+ #7
>   Tainted: [B]=BAD_PAGE
>   Hardware name: QEMU KVM Virtual Machine, BIOS 0.0.0 02/06/2015
>   Call trace:
>    show_stack+0x20/0x38 (C)
>    dump_stack_lvl+0x80/0xf8
>    dump_stack+0x18/0x28
>    bad_page+0x8c/0x130
>    free_page_is_bad_report+0xa4/0xb0
>    free_unref_page+0x3cc/0x620
>    __folio_put+0xf4/0x158
>    split_huge_pages_all+0x1e0/0x3e8
>    split_huge_pages_write+0x25c/0x2d8
>    full_proxy_write+0x64/0xd8
>    vfs_write+0xcc/0x280
>    ksys_write+0x70/0x110
>    __arm64_sys_write+0x24/0x38
>    invoke_syscall+0x50/0x120
>    el0_svc_common.constprop.0+0xc8/0xf0
>    do_el0_svc+0x24/0x38
>    el0_svc+0x34/0x128
>    el0t_64_sync_handler+0xc8/0xd0
>    el0t_64_sync+0x190/0x198
>
> The issue may be triggered by damon, offline_page, page_idle, etc, which
> will increase the refcount of page table.
>
> Fix it by introducing independent PMD page table shared count.
> As described by comment, pt_index/pt_mm/pt_frag_refcount are used for
> s390 gmap, x86 pgds and powerpc, pt_share_count is used for x86/arm64/riscv
> pmds, so we can reuse the field as pt_share_count.
>
> Fixes: 39dde65c9940 ("[PATCH] shared page table for hugetlb page")
> Signed-off-by: Liu Shixin <liushixin2@huawei.com>
> ---
> v1->v2: Fix build error when !CONFIG_HUGETLB_PMD_PAGE_TABLE_SHARING and
> 	modify the changelog.

Sorry for having missed v2 when I responded,  the same  question remains -

https://lore.kernel.org/linux-mm/202412151541.SQEZStgy-lkp@intel.com/T/#m90c26215594e494f5c65c3fa71979b519f0c8481

thanks,

-jane

>
>   include/linux/mm.h       |  1 +
>   include/linux/mm_types.h | 30 ++++++++++++++++++++++++++++++
>   mm/hugetlb.c             | 16 +++++++---------
>   3 files changed, 38 insertions(+), 9 deletions(-)
>
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index c39c4945946c..50fbf2a1b0ad 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -3115,6 +3115,7 @@ static inline bool pagetable_pmd_ctor(struct ptdesc *ptdesc)
>   	if (!pmd_ptlock_init(ptdesc))
>   		return false;
>   	__folio_set_pgtable(folio);
> +	ptdesc_pmd_pts_init(ptdesc);
>   	lruvec_stat_add_folio(folio, NR_PAGETABLE);
>   	return true;
>   }
> diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
> index 7361a8f3ab68..332cee285662 100644
> --- a/include/linux/mm_types.h
> +++ b/include/linux/mm_types.h
> @@ -445,6 +445,7 @@ FOLIO_MATCH(compound_head, _head_2a);
>    * @pt_index:         Used for s390 gmap.
>    * @pt_mm:            Used for x86 pgds.
>    * @pt_frag_refcount: For fragmented page table tracking. Powerpc only.
> + * @pt_share_count:   Used for HugeTLB PMD page table share count.
>    * @_pt_pad_2:        Padding to ensure proper alignment.
>    * @ptl:              Lock for the page table.
>    * @__page_type:      Same as page->page_type. Unused for page tables.
> @@ -471,6 +472,9 @@ struct ptdesc {
>   		pgoff_t pt_index;
>   		struct mm_struct *pt_mm;
>   		atomic_t pt_frag_refcount;
> +#ifdef CONFIG_HUGETLB_PMD_PAGE_TABLE_SHARING
> +		atomic_t pt_share_count;
> +#endif
>   	};
>   
>   	union {
> @@ -516,6 +520,32 @@ static_assert(sizeof(struct ptdesc) <= sizeof(struct page));
>   	const struct page *:		(const struct ptdesc *)(p),	\
>   	struct page *:			(struct ptdesc *)(p)))
>   
> +#ifdef CONFIG_HUGETLB_PMD_PAGE_TABLE_SHARING
> +static inline void ptdesc_pmd_pts_init(struct ptdesc *ptdesc)
> +{
> +	atomic_set(&ptdesc->pt_share_count, 0);
> +}
> +
> +static inline void ptdesc_pmd_pts_inc(struct ptdesc *ptdesc)
> +{
> +	atomic_inc(&ptdesc->pt_share_count);
> +}
> +
> +static inline void ptdesc_pmd_pts_dec(struct ptdesc *ptdesc)
> +{
> +	atomic_dec(&ptdesc->pt_share_count);
> +}
> +
> +static inline int ptdesc_pmd_pts_count(struct ptdesc *ptdesc)
> +{
> +	return atomic_read(&ptdesc->pt_share_count);
> +}
> +#else
> +static inline void ptdesc_pmd_pts_init(struct ptdesc *ptdesc)
> +{
> +}
> +#endif
> +
>   /*
>    * Used for sizing the vmemmap region on some architectures
>    */
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index ea2ed8e301ef..60846b060b87 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -7212,7 +7212,7 @@ pte_t *huge_pmd_share(struct mm_struct *mm, struct vm_area_struct *vma,
>   			spte = hugetlb_walk(svma, saddr,
>   					    vma_mmu_pagesize(svma));
>   			if (spte) {
> -				get_page(virt_to_page(spte));
> +				ptdesc_pmd_pts_inc(virt_to_ptdesc(spte));
>   				break;
>   			}
>   		}
> @@ -7227,7 +7227,7 @@ pte_t *huge_pmd_share(struct mm_struct *mm, struct vm_area_struct *vma,
>   				(pmd_t *)((unsigned long)spte & PAGE_MASK));
>   		mm_inc_nr_pmds(mm);
>   	} else {
> -		put_page(virt_to_page(spte));
> +		ptdesc_pmd_pts_dec(virt_to_ptdesc(spte));
>   	}
>   	spin_unlock(&mm->page_table_lock);
>   out:
> @@ -7239,10 +7239,6 @@ pte_t *huge_pmd_share(struct mm_struct *mm, struct vm_area_struct *vma,
>   /*
>    * unmap huge page backed by shared pte.
>    *
> - * Hugetlb pte page is ref counted at the time of mapping.  If pte is shared
> - * indicated by page_count > 1, unmap is achieved by clearing pud and
> - * decrementing the ref count. If count == 1, the pte page is not shared.
> - *
>    * Called with page table lock held.
>    *
>    * returns: 1 successfully unmapped a shared pte page
> @@ -7251,18 +7247,20 @@ pte_t *huge_pmd_share(struct mm_struct *mm, struct vm_area_struct *vma,
>   int huge_pmd_unshare(struct mm_struct *mm, struct vm_area_struct *vma,
>   					unsigned long addr, pte_t *ptep)
>   {
> +	unsigned long sz = huge_page_size(hstate_vma(vma));
>   	pgd_t *pgd = pgd_offset(mm, addr);
>   	p4d_t *p4d = p4d_offset(pgd, addr);
>   	pud_t *pud = pud_offset(p4d, addr);
>   
>   	i_mmap_assert_write_locked(vma->vm_file->f_mapping);
>   	hugetlb_vma_assert_locked(vma);
> -	BUG_ON(page_count(virt_to_page(ptep)) == 0);
> -	if (page_count(virt_to_page(ptep)) == 1)
> +	if (sz != PMD_SIZE)
> +		return 0;
> +	if (!ptdesc_pmd_pts_count(virt_to_ptdesc(ptep)))
>   		return 0;
>   
>   	pud_clear(pud);
> -	put_page(virt_to_page(ptep));
> +	ptdesc_pmd_pts_dec(virt_to_ptdesc(ptep));
>   	mm_dec_nr_pmds(mm);
>   	return 1;
>   }

