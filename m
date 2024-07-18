Return-Path: <linux-kernel+bounces-256202-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 46061934AA4
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 11:02:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 690801C20C75
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 09:02:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 799BE824AC;
	Thu, 18 Jul 2024 09:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="SyuzWawM"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2041.outbound.protection.outlook.com [40.107.94.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12E5E823CE
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2024 09:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721293363; cv=fail; b=AueDu9kUCAyF3AcHd94zaQbSS0+cSyacDMvFHRVcrAXqFZOR2CyoloSN/wSS+DZW77EQgiE02RZ6qrRQyLBWf2xEpbScRoQXWR5YSioH6LsHDVwuabbIdGo09r0g1yfTbw447G71zUvA8llO5ZQ/AtAqOS8k8J4dH/jJMGV93lE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721293363; c=relaxed/simple;
	bh=VADaagWXXVXVBZKK2yHnPe2zYvrNZbo9t4sVsVFzKwY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=nnTci8UBSi9rV3YXo6UAa4MU4/FW00uqYEetpguDT85T3k2ViW0og0DYK9/wIbX+sVY8ntyRoU3nopkYOpDYL6IaZj21XRfydN1NMYZqtEM6mAcE137XjqtGy06IOvUfYSrdcwj+HmQE4j5aXFfCsKbiGgfZ0KZybE85yBskJSE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=SyuzWawM; arc=fail smtp.client-ip=40.107.94.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QZNGc0uSOqtM/mnlYa6NXvXwdD5Kczl6RrUi1zzTBT5rUjteo/oW/Kswfk/uOX8VhItdCGKyGuqO8yuv8PiKvbETQBhpNUHeW4a9zlbs/EXW4/Bs5tk6TYGVywyvLqXGRK8BOoQAFkpg+phe+sRob4BjY/OAsOgIx7YfBOEsgS4IzB0tKz/tAyMv5skZ9+7qE/QPMX0b46+CvIGxwZCkA5Et9rthqaBuxzrzUI/D9676oXGNmButpMCd24ZqE5Pq1Iqkcm+GmXVsfP0eWl+6A8jqcZ5w/pKozIJ6Kg/0rgwuOsmbMMsXIWi/+Ac7eYN7Q0Wob3QfYTZ4AXedIB+SxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zRy0OrdU91Pazztn2s70VNeTapRZvJ0cMVyMwlZMpEw=;
 b=a2Vx38coedhvUZ1zFf8iNQ4ziRq0IuZJOzSjXwQzL2Ucu66anUaqTwb4tEM2+ah4u0Ti1HPg/+DCG2J+FOYeBpX6ir1AFE7yhau9abaVAswyr7Fodf5BjQBMmbj+IfZFmC6uM599kZXJHaOB6BWCKy2i4RmrqsgGP9TQEk/wWu6GoQug8bwf9d0wQx+Sj5EzOvhPjWCXPB8/LmfieG/0737Uj2hZJTYrJUU6Tw/dhCzyb5BiC/F9lQNnzrU8XrfGiBJUAnSxky5nV2lAoToW+IBHp1XbnlC9h1rX4jp5if3L7/S50wdWs26z4ROQowpQKoJ7+FrQbF0hxGfAkOZf8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zRy0OrdU91Pazztn2s70VNeTapRZvJ0cMVyMwlZMpEw=;
 b=SyuzWawM3ioWlHRUERIqmUsxA6LcN/a/6vPy/oC4fImWU10WarxdNZ3/8Wi69jA56/HtqN9CWF+XF1QPkEjX4Sc+PR1D+i2ZDriY2d/hOk1RMZq6O7G4cHQ0TOHQB4RtTsjkjREBg2JBl78cVobJgvo1fu+Irul303s9g3wZXMI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA1PR12MB6434.namprd12.prod.outlook.com (2603:10b6:208:3ae::10)
 by CH2PR12MB4231.namprd12.prod.outlook.com (2603:10b6:610:7d::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.19; Thu, 18 Jul
 2024 09:02:38 +0000
Received: from IA1PR12MB6434.namprd12.prod.outlook.com
 ([fe80::dbf7:e40c:4ae9:8134]) by IA1PR12MB6434.namprd12.prod.outlook.com
 ([fe80::dbf7:e40c:4ae9:8134%3]) with mapi id 15.20.7784.017; Thu, 18 Jul 2024
 09:02:37 +0000
Message-ID: <03f2114b-4feb-4387-981f-163d877034b2@amd.com>
Date: Thu, 18 Jul 2024 14:32:28 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: Hard and soft lockups with FIO and LTP runs on a large system
To: Hillf Danton <hdanton@sina.com>
Cc: Vlastimil Babka <vbabka@suse.cz>, Yu Zhao <yuzhao@google.com>,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, willy@infradead.org,
 Mel Gorman <mgorman@suse.de>, "Dadhania, Nikunj" <nikunj.dadhania@amd.com>,
 "Upadhyay, Neeraj" <Neeraj.Upadhyay@amd.com>
References: <20240717111510.1260-1-hdanton@sina.com>
Content-Language: en-US
From: Bharata B Rao <bharata@amd.com>
In-Reply-To: <20240717111510.1260-1-hdanton@sina.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI1PR02CA0052.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::20) To IA1PR12MB6434.namprd12.prod.outlook.com
 (2603:10b6:208:3ae::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB6434:EE_|CH2PR12MB4231:EE_
X-MS-Office365-Filtering-Correlation-Id: 812b5db8-e9b6-4b11-19e9-08dca7085f05
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?d0xhYlVyeVd4UUZpVTR0UW5BVjArVXNrZzdxN2laRDFBcmJJMy83NDd6M3RO?=
 =?utf-8?B?ZWRZWHVUdXFwU3hha2J0RDcyTkdCYkxXWTNma2RXdmxLYTYvWjVNcHRVcnZy?=
 =?utf-8?B?a1ZKc1ZMaW1NbEs4WFNkRHRIWkV0ZVBMMFF2ZGoyN1dXN3U1NUhyZk5tam10?=
 =?utf-8?B?RzNBV2UyTlpyWGs2TlFsUjV4U0EzTGVSaXNOSmExV1ZibkdZaWlGS1NTMnJM?=
 =?utf-8?B?alFLdVJ6TU5IdkRHY2k3RURWU2JDbXc0RUFRcHhNZmJQQml2bFR0MUtVMlhP?=
 =?utf-8?B?bjVqN2tXeml5ODRBY2hXNjArY29lajJTTUdYZStuY1BsTDhZdXB4SW1hQkNz?=
 =?utf-8?B?R2JYMktYZGlqdk1xWXpMTThtdXZVdVJoQjZXRVNFQjdlYzBkS08yVWxMUzRm?=
 =?utf-8?B?Z1BkN2cxL2tiQlJrdWFpOWE4aFRuSDBjTE11OFNpcmV4M2VuelZjVlVyR2Vm?=
 =?utf-8?B?UTJ3UzM4OHlVcFB0SEd2Y08reG41WUgvN2JkczQ4SVpHNTlNRnIxVHN2aHNa?=
 =?utf-8?B?YjllblR1dmRTZjNZNTdxZTJDTmx4M0lacXd1eTBkQVl1UCtycC9vSnFGb1F3?=
 =?utf-8?B?WVdRSFU4cXA5WFNyd0hON2FXaUFlUUNJd2lqWjhUeElidFF0Nk5yeFlsdEY5?=
 =?utf-8?B?d0FCaU83Y3NpUFF3bTFJTEJIbWMrcURwc2UwREthUENDOUxBdHM2QmNCbVdX?=
 =?utf-8?B?Q1lHYzJvUXJPU2JPMUZWT1R0Y1lFZkNoUWdFdmhqNTVmSzFNR2ZZSDZxeUkr?=
 =?utf-8?B?MHkxVDkxdDJHdEpJMDZSTnBlSXg0SDV1c0M0QXEzNG5pcmg5ZG1qYTdGM09N?=
 =?utf-8?B?QWw4Zmc4WCtqYk1FSzZrY3pIV2xmT2l0b3F5VngzKzdhNEZwMUVLQzNPZ2p4?=
 =?utf-8?B?MTFKek9KZnZuQjhGWVlCUnFtZys3NWFqK1p2bEF6a2h0RmZwQWgwM1Y4T3Zh?=
 =?utf-8?B?dmlvWjZSTUdQSy8wUHJpUzdRdWo5dFI2NnhXcXpQYnIzeEVEeS9MRmhtMHI1?=
 =?utf-8?B?aVlhTFgvaXJmQ1BneDlhVzhWNk5DZzc5QXZ5OC82dzMvQXloUkF2RGJyblc2?=
 =?utf-8?B?UXZVQnpRS2pNTWdYek9zZEgzRGMrbURFdWg0WmQ4K0x4Qk55QWZDK0RyNW5J?=
 =?utf-8?B?QVN0TTNUd3V3Tm5rcXBUcUhtRGlsdHhNMUQyQlFPaHJ6b1JwRHQwSHVSa1lR?=
 =?utf-8?B?cnNqbDJ1T0M4ZTFlaVJaR1pwUjcvRU1jdGJiWms2Nyt6d1FmWmtFeWVNMzBq?=
 =?utf-8?B?TG5jVXV5bkdXMnBQWG1RYlNWUGJRcS9ENjU4SDlrWE5OS21RYTY2a1R2S1lt?=
 =?utf-8?B?VUUxdXZqZXhZaTk2cnFHZGNkWmg3cHBZNXFyY0Q0YlpEbzdleWZpcloxQ2VZ?=
 =?utf-8?B?NE5OaEdIZS9VYXlpQmZNM21BNWxZcE84VjQvNEhKZGpxYU5henErT2UvSDda?=
 =?utf-8?B?RzU0NngzcVFKNEVxcXJqSDVPTVdYYWhoTU9ZSXlQbjdUWUVScld5Z1kzQkxn?=
 =?utf-8?B?UjcvRFJ3ZXNYVjF4QXkwajFhKzNJYlBlYktMRnBOWHVKOUt4RHlJRG5BUmcx?=
 =?utf-8?B?QzVaR3Z1MDBCU3k0eFdkWXB2S3BjZ1Boci9XMXpwdEhPdEpnc0Z5ZVlpNXZ4?=
 =?utf-8?B?RXJMTGJXNi9Td0xqZGk3QmNBUmY1OG5FUFRXUVFzUHNncGNkcE9XcHJFZXFE?=
 =?utf-8?B?OXF2NFc1RGRrNnIrV1QyRG1vdUZPN0hXQVVmZTNvOW5kaU1pMTJZdlBXcUpn?=
 =?utf-8?B?b2xWZVp0TnI3bk1SOFpyR1pzLzdOU1U1MzVVeTZEWklKK3VaQi9QZG16aTRi?=
 =?utf-8?B?SUd5NTBTN1RWdHlTN3l6dz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB6434.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Y2NvT1UxTEZ6UFl5Yzh6ZTl0R1paRnNQaCs1ZjIwdFo0cWJCYlc5VTV4ZTli?=
 =?utf-8?B?WmpMNS9KaXV0SFM1T251MCtaU1ZlcHJFODl5WDRnWjBOWGVKOXQ2bXMzdGp0?=
 =?utf-8?B?RDNqRENQVTBEMTBuck11VU05YjFUYTg3OUhvNGZQUHBxQXJvSHY5MHVCUG43?=
 =?utf-8?B?RkxMbTJKeDFBaG81RGk5L1JsS0VUT0NNc3ZwS2VZNTFIUFlJMDhEcGVqdnpS?=
 =?utf-8?B?RXg1QThUaXhsZ2d3RkZYcm5vQ0x0NzBIMXUwRmdNSTV1cDhtSjVuVEJXditj?=
 =?utf-8?B?Zzk1M2FqUVZ1MmtPcUxuSVpnYmhOQVgyRVgxOEVhU0hiWlhsQ2pqbFJucmZS?=
 =?utf-8?B?NXc3UHhUZCtkUlgxQnZyemZIWHJCcUVUVVVDU3BaOWR6SEEwZDh4ci9abTRB?=
 =?utf-8?B?SnYxY1p6N3VxdWlUWmx2Q3QraUdtenc0bGR2TWxHVVMwRlNnd2tibXdBVEZY?=
 =?utf-8?B?UU5xMTltUjRsYTN4SVl1YjRXT3c5bDVpM3V5R2VoUy8zTTU5VG9lZHVHZnYz?=
 =?utf-8?B?YzM2eW5pd3NvZlE2TXd2alcwSE9uOGl1Nm5laW5YeUwydEIxaHU4VmFGSFlD?=
 =?utf-8?B?bU9rWmQxUzd3bnVQVk1xMHorQnlTRndKaEwwelRVWGZhNkZrQ1Nyb2RxVkxo?=
 =?utf-8?B?ZkJ3ZXUrcUdTdjIya1VvUEtxeUNMUzIrWlIya2dzZWRGRkVRQ1E4T2EvbTI3?=
 =?utf-8?B?ckkyNVNrSXZFRDd0elA5ZGlXVzhBVy95YTNIeVEvY1VpME82MG9XZVlmQVAw?=
 =?utf-8?B?Y0ovRnB6ZFVoYmxTY25NSGRNK0xRRFhKMUxYQ04zSVZQTFZYLzFHajkxTkxS?=
 =?utf-8?B?OTV6M1Rka25wdXRwajFkREtENXRVMGJBMGNLN1U1MlZSaHF1SE1TU3MwNGhR?=
 =?utf-8?B?WjYyWVVEWkZPclRFZTNSbk1lakJqc0JiS2xOd3ZJNE5kSXR3S3lSTGt4Zkk5?=
 =?utf-8?B?eGJNeFladEtKTCtsR3Bna01ERUk1R01QMmk0WDJDQ1ZmaW1YS09KQVF1NHN2?=
 =?utf-8?B?SWFpL0lLMHE5TzMyM2NBVzhWVlNsUDZWcS80OThKN1UvNlJPcFB0TmM3OGlX?=
 =?utf-8?B?MENjU1NKZHpCOTM1TnVtU2YxcFN3RGJHRVNLN0lUbS9uWmZtRXg5WVBsVnMv?=
 =?utf-8?B?RUFBdkFBZXZZalZadkMrM1VDelNPeFVyS1ZmUFJaUWh5UXFrNUhNZ2tmOEx1?=
 =?utf-8?B?MFdZQ2d6eWpZOU96ZlFqUFBGMFBCRXl1RnBERXlBb2tUeVl4a1E2UGZEUHFG?=
 =?utf-8?B?b28vVFAxdG5ENnJUdXdZV2d4dnJPZ0ZESVBBcVUvOHBHdWhTWk1rSGdwa0xS?=
 =?utf-8?B?TW9aZ015Tk5ka0ZMNFR2dkxvNUw5WVlJdTJzVHZxWjByRTU5Y09xZ1pOWW9q?=
 =?utf-8?B?U25pYzJBSjhDVitwRllQSFllazVUcUVJb292czU2SXJJWDZ4bFI2RDkrUlNh?=
 =?utf-8?B?cWExdlBOMDR4M2JZd3laUTV0d2g4SDI2eHhrY0R5K2xpNzRSajJJNGtYVklr?=
 =?utf-8?B?cmdBRlBTTStQYUZUWENVRUlhU1MvdlFXYWg3bDFpcXlqZ2VIWC9EaHVSTHNu?=
 =?utf-8?B?bytWbHNsbmN2NTdpVE9leno5TEw3UkRPSkJ1MXk3T01MVGNJNUJpb0ZwS2l6?=
 =?utf-8?B?Y2QrNEo5cGFTM0x6eFFNKzJlRnFaMFlwTnhmS2cva3Bkd21wWGQ2ZklWcjAr?=
 =?utf-8?B?bW5jdzA0Z3pSVTR1S1JXTWE5VnB0QVVHS3M5bU1VY1NmcGloN05NYnlqb1Ny?=
 =?utf-8?B?Q3ZCb0dYZ00vZUwrMTM2bC9FTmZZY0FYUXBPVVNiUUVQR2xyMHVZRDNkbnI1?=
 =?utf-8?B?VEZSekpSN1hYT3NCMXpXYWNHNXIycVo5dDJhZ3JUNWQ0UWJKYjFVcnYxNm1k?=
 =?utf-8?B?RVRkdU01R285eWRmWXFRVDNId2pCVXNSOVhiSnNhd2U4cnRrdHhYUkdOVXZu?=
 =?utf-8?B?eHBGZ1JaNDk2QmNrNGtsdnUrdVpGWWJ5RWl4eTlNZWhtemlVVzRTejZmTS9W?=
 =?utf-8?B?eUFjeGR0RmlJbVQzWUVYZFFkOHJpanZDa0JFWitaREQvMEhwZ2RTUHNkOFhx?=
 =?utf-8?B?YWppei9Oa2FkYXcrSTBtQlhwUzNIcmlDcjhHbFcrcXNnWTFGYlMwbzA1S0hK?=
 =?utf-8?Q?0ZoP8HtOJzsV1CzaQOlQBD0H5?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 812b5db8-e9b6-4b11-19e9-08dca7085f05
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB6434.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2024 09:02:37.9091
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aki2ZhNhAOIFbuuJMiQPX8jINMNc109xPjOJnJ5i8rAveuKVVjJPyJt0sFh7NNzsbb3uu4iXGfgTQhpRHLN7fw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4231



On 17-Jul-24 4:45 PM, Hillf Danton wrote:
> On Wed, 17 Jul 2024 16:20:04 +0530 Bharata B Rao <bharata@amd.com>
>> On 17-Jul-24 3:07 PM, Vlastimil Babka wrote:
>>>
>>> It seems weird to me to see anything that would require ZONE_DMA allocation
>>> on a modern system. Do you know where it comes from?
>>
>> We measured the lruvec spinlock start, end and hold
>> time(htime) using sched_clock(), along with a BUG() if the hold time was
>> more than 10s. The below case shows that lruvec spin lock was held for ~25s.
>>
> What is more unusual could be observed perhaps with your hardware config but
> with 386MiB RAM assigned to each node, the so called tight memory but not
> extremely tight.

Hardware config is this:

Dual socket  AMD EPYC 128 Core processor (256 cores, 512 threads)
Memory: 1.5 TB
10 NVME - 3.5TB each
available: 2 nodes (0-1)
node 0 cpus: 0-127,256-383
node 0 size: 773727 MB
node 1 cpus: 128-255,384-511
node 1 size: 773966 MB

But I don't quite follow what you are hinting at, can you please 
rephrase or be more verbose?

Regards,
Bharata.

