Return-Path: <linux-kernel+bounces-559082-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08E91A5EF56
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 10:16:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 978703B3159
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 09:16:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8678325FA09;
	Thu, 13 Mar 2025 09:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="cshjX2qC"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2059.outbound.protection.outlook.com [40.107.223.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FDE21EA7F4
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 09:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741857386; cv=fail; b=BeNFDWG7dEKNkw2hN1HqQodhtpUQs8jDjlll7Q3U7z+2y/KmaHn5Qp/xPOiRN54u3eyMrb0nvmhWkpvV61XMk1aEfom0iLlO3tjQUVyvhxVYxQ86rhpFcjpFo+CtSTGV85l2m39LqXKXo3JeMA1fFl1iqnlw3lNWeApyUYPa4jg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741857386; c=relaxed/simple;
	bh=ZT3VWLBWsLnnutMQGdehehQBUKOVX0t1iAsjjwPbHOM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=oVrfvquPsrLBUMRKjxYbXq96JIzPJhmgNf62h5tnDm+rqsJagOLGAy90CQb3t9uQlj3/e1sPdDvhS3TGAsK6NkgMmp4AoIuFFZZr55Tx6wGgRGS9E6exEUq7Z6UzXdkLgJl5IRUJxWuWek6FvS3RkIxOilHzO2xfsSZ4jELTNTA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=cshjX2qC; arc=fail smtp.client-ip=40.107.223.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XpzeZHEmncPefOyCm/Ivw5LvQb6m4+eZFDjXfNaAtj24qyRe2wgmGOcr1uNOZhLrSJOOu56DIpoHgV2CQ3fBvCxacsJJ1cQFpiIQexZyd+NlpJNNPtNmsTjjIrnuxhWOknYSvwY92Mv/AH4XgSdMZV01SDynLecpynnLQVU2GzPqzJCXIVEu/bC9a27BJ8qXfw/L+s1zKLXCpAxSkxG+1ErVFVDogKp8rslAVQPJ06rVSyG0JerEmbOetF2Z2p8+Ge8YJfLBt8Cb/AMP9ieep/d1OffQg4eXLGbro3F80Ccd/tZbBo9aBhWztud4rMuPBKRc7vOKYkuMIpGDfa/uYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bCQaGiRdO7KmpLpbV3u9yKr0sTYG7XQMT/G7ttJDcL4=;
 b=OWUpIOy9DBN6WDqYS20LTJ35xpBeWUxn/vlXA+ZEGUpSdzzw3RiG881qHgTH7HdOBJrLPiKMhBSq+B+V7fpm/Wwqs0iJ9vDLz2V6tTWWs6Jy8DiJlk23kjDlOx0f5f/Ao7+s/lM2aUaZsJB5Ub5ow5ZoRJTtol5TtXiWTyHTUIkJQ+CLLrlBjDb6addOD7QO7cYop9+KLVsmo2pxKDr222EjYVJ1iKwh4kc7eA9L7AGezvEO7oX3jxVBRl1+QUHwUlrLJCfW3RpD4LcDiMAtheX+W+CZdKC8CDcDg2EhsoOMgmin96scZvMfteS7NiauXpw42jKIRAeqvrh8LG0N2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bCQaGiRdO7KmpLpbV3u9yKr0sTYG7XQMT/G7ttJDcL4=;
 b=cshjX2qCRbkf3Bujrk6BmNmfkc6ZRgSu1nQEZJ2HV/TIBs5cQfG+/1PL9x/VLeY38XfglkkFWZY0gwBeNxbce8NdpEgpbVoESMqWuBcGxz2C48D7ox2QTimNLTUDVJ2CjJAMZpBb8aXYR/o3JfpOc8zL9ECoplBso0qMbou0UVU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH3PR12MB9193.namprd12.prod.outlook.com (2603:10b6:610:195::14)
 by DS7PR12MB9528.namprd12.prod.outlook.com (2603:10b6:8:252::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.28; Thu, 13 Mar
 2025 09:16:21 +0000
Received: from CH3PR12MB9193.namprd12.prod.outlook.com
 ([fe80::7818:d337:2640:e6c7]) by CH3PR12MB9193.namprd12.prod.outlook.com
 ([fe80::7818:d337:2640:e6c7%6]) with mapi id 15.20.8511.026; Thu, 13 Mar 2025
 09:16:21 +0000
Message-ID: <b43b6051-238b-207f-f0c5-3071950c1a0f@amd.com>
Date: Thu, 13 Mar 2025 14:46:11 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [RFC PATCH 1/2] drivers/misc: add silex multipk driver
Content-Language: en-US
To: Greg KH <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, derek.kiernan@amd.com, dragan.cvetic@amd.com,
 arnd@arndb.de, praveen.jain@amd.com, harpreet.anand@amd.com,
 nikhil.agarwal@amd.com, srivatsa@csail.mit.edu, code@tyhicks.com,
 ptsm@linux.microsoft.com
References: <20250312095421.1839220-1-nipun.gupta@amd.com>
 <2025031256-accurate-tactics-1ff7@gregkh>
From: "Gupta, Nipun" <nipun.gupta@amd.com>
In-Reply-To: <2025031256-accurate-tactics-1ff7@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0162.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:c8::6) To CH3PR12MB9193.namprd12.prod.outlook.com
 (2603:10b6:610:195::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB9193:EE_|DS7PR12MB9528:EE_
X-MS-Office365-Filtering-Correlation-Id: f62bfa22-72ea-4835-4f2d-08dd620fb834
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dnI3ZDBvNTNSdmNaaFIxMmpYa1JPdlhlTi9GclZkTUUzeUFDQUpZMDBXUkUv?=
 =?utf-8?B?cE9nY25DUCs4SExSQ2RJaU5WU3o5RXl3RGg4ZVEzT2JURjJhSUNIU2RSY0J3?=
 =?utf-8?B?V1hWNUdpc0Q1WXFGdWpFeHFuUmNWRnRVVkNzWFJmV1ZBUzM0MEdlMDJVYXVu?=
 =?utf-8?B?YzNkVjB5Qi94dk1MZmc0VThLaGxZRWEwY1pNcDdRSFJ3MzJRRFdKWDBVMUM0?=
 =?utf-8?B?Qy8wZjlJdmc2c21nNGhIMUpuN3dIL2FVcmppdFN1M3l3L0M0b1htckJLYVpn?=
 =?utf-8?B?aHpPSElKVHhZa21vTTVPaElEZlZBWDBaeSsrQUsxdlBQVXZyT09TNHhhT0pl?=
 =?utf-8?B?UDZIMCszRlJiSVVZNjloY2Q4UkRyNDBQejMrc1g0bytwazRZUHpEK2IreHEy?=
 =?utf-8?B?bDYrRGs1bTY3U3BOY3hiWmpkK25NSC9PNjFKVm9VMkFDdHpsQVdxYTZQd1lU?=
 =?utf-8?B?M010T0tweXk1U1lHTVd2cVQwcmVkUjRlSTdPRFBEdjd2QnptM2FpMUpiSnpK?=
 =?utf-8?B?a2hNZjg2VFlGelZhRjlaWVJZY292MXk3MDRLTGJZVHBJa3JJM3l5NDM1bXdq?=
 =?utf-8?B?QnpuL3RBWjcxWDJwUjRLMXQ3cTZvODNSU3VKWG9ORkpGdWdCeW9GOEQzdUt5?=
 =?utf-8?B?SENYOTBrcmFzRnhlUW1KM3V0bGRSTm5qN1VJd0ZYYkk2MTk0VXF5UUFGL2l4?=
 =?utf-8?B?enYzNVlTUC9hU1FEV0trbU5USFhMSmszZDZhalJTdTY1Vmc5QUFZTVcxYlM1?=
 =?utf-8?B?N0VQZWRnQXNVSmFFYWJrOE53ZkhUTFY2N3BTSnNPWVJpWjhvTWQ1RUEzeU9O?=
 =?utf-8?B?UlltN25DYmNpeXNQckNiMkNZWStWS3hSQVBwZE9EV0hRYSsyekNrU0JDUkR5?=
 =?utf-8?B?emFEYll1K0pEdVE1MVJMTG1zWWt2U1FycUp0cmRSQWsyMlFpbmtwNGx2QTNl?=
 =?utf-8?B?ZHQyYXVDZ0FaVkQ4VElOQU9tM1FNZjJtMzhING5Ka1JjdVJPTEJqcjRiaVFQ?=
 =?utf-8?B?MVhSL2lvU1ptUTF6SFhUelpMV3JVdFNtbm55ZGRsYlc2alhDUkYyUEpiVkdh?=
 =?utf-8?B?bUhsVVFJNHUxeXNONEIreE5NWlBJY3FFZWVJVW9ESnRPZjZmRVl1RyswVytB?=
 =?utf-8?B?ZEYrd3VnZ05LdGJnMG9yUzloczhYS212Y3A2d3ljKy9XVkNGdXBMZ1hoa3hn?=
 =?utf-8?B?RTE4YTUwMk82ZEJjSUdYakE0TWliSDNFZ0dZc0FjSTluWGFMTEUvRkpOQnY5?=
 =?utf-8?B?aEFzZm9TdnZJRzFXaGJHbjlUR0NyZnRCUFl6d0FleHh0ZmYrRWd3RWNYNmo0?=
 =?utf-8?B?b0hKTzhlSXBIYy9ocDFWVzVjSXFKQlUxU01iQVlwaUJGN29ZT05ZYThkelNk?=
 =?utf-8?B?UDk2VldpcFE0R3ZqcmxlYk9tR1BoMzc1MzFNdVF0c0VTb1ROYXh1cy9DaWcv?=
 =?utf-8?B?TzZORldPaXRWeVk3U0tDb2dOQ0tLenBLYkRZQlpMYUJRUVRVNVo2MWZlV2tJ?=
 =?utf-8?B?b3hNaWs2MVBTZkN4YlRJbkU0Qm9ZZk9ldWZvWmdsdmY3WTBuMkJ4bzZmTjBZ?=
 =?utf-8?B?M1pkZXV0V2hEQ25ObmhCOXNCTm5CZGFNL2ZVb0ViQzBqaE1tYks3UWFZLzBY?=
 =?utf-8?B?c2lxeEhXWVVLSzFJcFJTL1Z5a2h6MEhOKzBIQ2xkVXQwa0NEcFZ3UXE4UHgz?=
 =?utf-8?B?L2VRbVdjWTRUREg4bFBwTXdKa085b0U5OVNjRzhiSk00b215WFpWZDYyU1Rv?=
 =?utf-8?B?V25udUpoZmlhMU9rTjl5b2ZSSGpVd0ZvWVRZSHkxbEdWSzBsTWZYMGRlaWNr?=
 =?utf-8?B?K1h1ZWpWc3BNK1NMY2tnek8wellXcUR5S2VJVEhhRGNTUk1EaE55SFZ0ZElO?=
 =?utf-8?Q?iiDqepsEaxbHK?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB9193.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cGhNMXBJejdmdktLZy9UQ3luNEk2YmtFY1RwbDZwZHpza1pHMkswd0FPZGZ0?=
 =?utf-8?B?cmZibUFUc0dEeEpxMXZTbVRQa1hwaHVRd0pJODZBWTR5Q2MxV0FSbHptQ0FB?=
 =?utf-8?B?aytTTWNUMTlTU3Q1ajZvNlBXUkVJYjN1Qm5waThVaDRZL2pEMFlROFU3Tlp6?=
 =?utf-8?B?a1g1R0ovUDQzb0JHV3FRTy9CQldPZzFqRjIzbUh1K043NUpwWmMzWDZ3dTQv?=
 =?utf-8?B?d21nUHVRMzIvSUVDT1NGMU9Dc2o2M0RtelNXV3RrcS82WjhubFFFZ0JzTDJB?=
 =?utf-8?B?OGhFWDNBUzg2OFdsWnJ3WGdramx4dHZrYlpnTWx0ZlFCSjYxeUxVNm9hRGZR?=
 =?utf-8?B?ZFV4NC9nb2pUbllsY3dsOGZadFhvU0p4Mm9BMlRaVzl4V09BbFZNbGlFcmta?=
 =?utf-8?B?U0x3SS8zUURHU2V5UmNkY3ZqYUQ0ZU1IajgranBPeVlOUGw0aW5rTWtLVUZX?=
 =?utf-8?B?bk1nYldnbmV1RUtmWlJ6YnVNb0dVeVByaFdsWk5HMDNOVTBVQW5UOUIrQ29L?=
 =?utf-8?B?SzVacVoxYTRVWWxENEM2VlJQd1hWNjYyNk9sRUlwaU1QZzVtanZBRjBGUUJl?=
 =?utf-8?B?SzNWYXB0SmIvQXF4NW90R21zSGdSMDVJaTVTNUdzcHhxN0ptU3ZmeHJjODdl?=
 =?utf-8?B?TUNvcUpqS0RhdURXSTl1RFBOdnEraVRCUnJiREtXQW1CRnBUb3NiQ2dxclNw?=
 =?utf-8?B?cC9TNFU3NDJXK3ZxWHdhRW00SGxYQ0NNeWFZbmZoYjNIcitvOWg2ZGlQd2FE?=
 =?utf-8?B?T2gxUzNEQUVqWFhDTXk1RUlwUkhRUU5UQjNoQ3c3dDU3NDcwVjNDZVRYeUtH?=
 =?utf-8?B?T2RaT09hekkvK3QwU3dsN1QxNzRFNWVCZlJtbkdoZ1RQUWpUM21tYmNNVEtr?=
 =?utf-8?B?aGpwVlVOL0M1STIzcUhWdit1VTNTQkdDcFUyZTQwOXRySktPaVVYTXB2bytC?=
 =?utf-8?B?VE9OOVZBR0hWK205Zk02S2tQQ3lVTGpIcjlmbU1CNy9udlhVWUMzS0h0Q2Y2?=
 =?utf-8?B?akk2K3VSNnN2QnhvK2E5SURaT2RZUC80ZW8vNnhvZGxJR1kvZENQNW5OWjRK?=
 =?utf-8?B?WUZGTm8wWG1TUCtLOWsxc25UUytIaUNYNkZmMXlvSlNMZTREM0hmemRGbkNF?=
 =?utf-8?B?WlVTeGdZS2h6N2l5UWNFN1MxQzg0bEVydzhLMUpVVDAyWW0zbWJ6QXJQdnBo?=
 =?utf-8?B?bS9VTFJieE9JeTdnc3RKM0hpQmw0VVFLMXg3VDliWTV4Smx5T2tCdVdTeE44?=
 =?utf-8?B?VWdtTXkvQlErY1U5dnFvNmNSSTVXb0MwUjI0ZHNQdHlxVThXUXlUUDl4RWl3?=
 =?utf-8?B?bXhKZ2V2ODFSNWlWOXFiSFA5SkgwcytmZFVtZDUvTUJqVlRSM1RaMjhuMWI0?=
 =?utf-8?B?TnhpbjNucE9DYkxpODl1VUd5SlFHeDd6UkRlSlMrN1NRQ3lNdm1ubDIzM0tW?=
 =?utf-8?B?Sk5rakxMQUxQQ2Y0YVQ0VFh4cWF6Y2M1MitmaFNueEF0cG96Y2xQdk5JdXJ6?=
 =?utf-8?B?U2s0QW5ZNksrdkxVQWErbGRuWGtSb3V4cVFXY2FXdmZMMElwUEpBR0hsRmty?=
 =?utf-8?B?N3RVT0RJYUJxU1RLUkJJb1AvcUpCd09MZUxJUmZqaHJia3dkdmFKa0p3NlBk?=
 =?utf-8?B?S1RMZFloRTRuWE1UTE10STVCUlhYRC9mMWlLcGw4UHJIQUJXUEh3ck4rZHBm?=
 =?utf-8?B?VEFGa2tnQXlKa3FodXNDNEc3NmJyRklWWXFwUVg1Qk1mZDgyNytJU0g0WTI3?=
 =?utf-8?B?K0VKck9MaVYrUHkrcjFWbmtPM1RiWnB2K211TlJDNCtTSkM4Y1hVb1ZJcjhz?=
 =?utf-8?B?RStxeFl3Z0RrNndoZ3JReVZETWN5QXRyMlVtQ0dWLzh2VDU3b0hvR1gvR1k0?=
 =?utf-8?B?WmJzRkN2OW9mWlZpUy9OY2ZzbHhEWHFNTXRMK293Mk5yb2hCSDdqaWsvcjA4?=
 =?utf-8?B?RUtnRWlHaFhNNlp6aHhyVlRtdFVpZFZDS1Z1bUZBWFUxRUJTa3B2YWpoWkgr?=
 =?utf-8?B?Q1JBTkMwb1phVVZjNlBvWEU5MzNxWk9kNVpTcXVKZW9QUlhiV3FLNVEycHFE?=
 =?utf-8?B?VWFrN2xVWWwwM3dONTc0OHBDT1RZbzRXVUM3ejVYWlM4STlBOEd5UDVIYnFF?=
 =?utf-8?Q?2Rl15HsDtT9VxhCYj3/S20BDD?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f62bfa22-72ea-4835-4f2d-08dd620fb834
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB9193.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2025 09:16:21.5216
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wPv2Ddoj9DfUP5CTsu34h4pj0jkjfFTLe7M1YaDCRLltNMLp307oUtesiw4TPa+A
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB9528



On 12-03-2025 15:48, Greg KH wrote:
> On Wed, Mar 12, 2025 at 03:24:20PM +0530, Nipun Gupta wrote:
>> Silex MultiPK device provides a char device interface to interact
>> with Silex device for offloading asymmetric crypto operations.
>>
>> Signed-off-by: Nipun Gupta <nipun.gupta@amd.com>
>> ---
>>
>> Silex MultiPK device is a PKI offload device, which has multiple PK engines to
>> perform asymmetric crypto operations like ECDSA, RSA, Point Multiplication etc.
>>
>> Following provides the brief overview of the device interface with the software:
>>
>>   +------------------+
>>   |    Software      |
>>   +------------------+
>>       |          |
>>       |          v
>>       |     +-----------------------------------------------------------+
>>       |     |                     RAM                                   |
>>       |     |  +----------------------------+   +---------------------+ |
>>       |     |  |           RQ pages         |   |       CQ pages      | |
>>       |     |  | +------------------------+ |   | +-----------------+ | |
>>       |     |  | |   START (cmd)          | |   | | req_id | status | | |
>>       |     |  | |   TFRI (addr, sz)---+  | |   | | req_id | status | | |
>>       |     |  | | +-TFRO (addr, sz)   |  | |   | | ...             | | |
>>       |     |  | | | NTFY (req_id)     |  | |   | +-----------------+ | |
>>       |     |  | +-|-------------------|--+ |   |                     | |
>>       |     |  |   |                   v    |   +---------------------+ |
>>       |     |  |   |         +-----------+  |                           |
>>       |     |  |   |         | input     |  |                           |
>>       |     |  |   |         | data      |  |                           |
>>       |     |  |   v         +-----------+  |                           |
>>       |     |  |  +----------------+        |                           |
>>       |     |  |  |  output data   |        |                           |
>>       |     |  |  +----------------+        |                           |
>>       |     |  +----------------------------+                           |
>>       |     |                                                           |
>>       |     +-----------------------------------------------------------+
>>       |
>>       |
>>   +---|----------------------------------------------------+
>>   |   v                Silex MultiPK device                |
>>   |  +-------------------+     +------------------------+  |
>>   |  | New request FIFO  | --> |       PK engines       |  |
>>   |  +-------------------+     +------------------------+  |
>>   +--------------------------------------------------------+
>>
>> To perform a crypto operation, the software writes a sequence of descriptors,
>> into the RQ memory. This includes input data and designated location for the
>> output data. After preparing the request, request offset (from the RQ memory
>> region) is written into the NEW_REQUEST register. Request is then stored in a
>> common hardware FIFO shared among all RQs. When a PK engine becomes available,
>> device pops the request from the FIFO and fetches the descriptors. It DMAs the
>> input data from RQ memory and executes the necessary computations. After
>> computation is complete, the device writes output data back to RAM via DMA.
>> Device then writes a new entry in CQ ring buffer in RAM, indicating completion
>> of the request. Device also generates an interrupt for notifying completion to
>> the software.
>>
>> As Crypto AF_ALG does not support offloading asymmetric operations from
>> user-space (which was attempted to be added earlier in Linux at:
>> https://lore.kernel.org/all/146672253157.23101.15291203749122389409.stgit@tstruk-mobl1.ra.intel.com/),
>> RQ memory is provided to the user-space via mmap, so that application can
>> directly write to the descriptors.
>>
>> P.S. Most of the above text is also added as part of silex driver file.
> 
> All of that should be in the changelog text, don't put it down here
> where it will never be seen again.

Sure will add it in the change log.

> 
>> +static ssize_t hardware_show(struct device *dev, struct device_attribute *attr,
>> +			     char *buf)
>> +{
> 
> Where is the Documentation/ABI/ entries for your new sysfs files?

Yes, will add documentation for ABI entry/ies

> 
>> +	int v, hwv, cnt, maxtotalreqs, rqmaxpending, mults;
>> +	struct multipk_dev *mpkdev = dev_get_drvdata(dev);
>> +
>> +	v = (int)sx_rdreg(mpkdev->regs, REG_SEMVER);
>> +	hwv = (int)sx_rdreg(mpkdev->regs, REG_HW_VERSION);
>> +	cnt = (int)sx_rdreg(mpkdev->regs, REQ_CFG_REQ_QUEUES_CNT);
>> +	maxtotalreqs = (int)sx_rdreg(mpkdev->regs, REQ_CFG_MAX_PENDING_REQ);
>> +	rqmaxpending = (int)sx_rdreg(mpkdev->regs, REQ_CFG_MAX_REQ_QUEUE_ENTRIES);
>> +	mults = (int)sx_rdreg(mpkdev->regs, REQ_CFG_PK_INST);
>> +
>> +	return sprintf(buf,
>> +		"Hardware interface version: %d.%d.%d\n"
>> +		"Hardware implementation version: %d.%d.%d\n"
>> +		"Count request queues: %d\n"
>> +		"Total max pending requests: %d\n"
>> +		"Max pending requests per request queue: %d\n"
>> +		"Pkcores 64 multipliers: %d\n"
>> +		"Pkcores 256 multipliers: %d\n",
>> +		MPK_SEMVER_MAJOR(v), MPK_SEMVER_MINOR(v), MPK_SEMVER_PATCH(v),
>> +		MPK_HWVER_MAJOR(hwv), MPK_HWVER_MINOR(hwv), MPK_HWVER_SVN(hwv),
>> +		cnt, maxtotalreqs, rqmaxpending,
>> +		mults >> 16, mults & 0xFFFF);
> 
> No!
> 
> sysfs is "one value per file", which this is not at all.

Will create separate entries for each.

> 
> Also, did you run checkpatch.pl?  It should have told you that you
> should not be calling sprintf() here either.

I did run checkpatch on patches (as well as separate files), but it did
not report it. Will use seq_printf instead.

> 
>> +static int __init multipk_init(void)
>> +{
>> +	dev_t devt;
>> +	int ret;
>> +
>> +	multipk_class = class_create("multipk");
> 
> Why do you need a whole new class?  Why not just use a misc device?

We will update to use misc device instead of creating new class.

> 
>> +	if (IS_ERR(multipk_class)) {
>> +		ret = PTR_ERR(multipk_class);
>> +		pr_err("can't register class\n");
>> +		goto err;
>> +	}
>> +	ret = alloc_chrdev_region(&devt, 0, MULTIPK_MAX_DEVICES, "multipk");
> 
> Again, why not a dynamic misc device per device in the system?
> 
> No need to make this harder than it is.
> 
> But again, this really should use the in-kernel apis we already have for
> this type of hardware, don't make a custom user/kernel api at all.
> That's not going to scale or be easy to maintain for any amount of time.

Agree to some extent, but as Crypto AF_ALG does not support offloading 
asymmetric operations, we added this driver as misc driver. This device 
is supported in AMD Versal series devices: 
https://www.amd.com/en/products/adaptive-socs-and-fpgas/versal/premium-series.html. 
We would maintain the driver with minimal possible user interface changes.

Thanks,
Nipun

> 
> thanks,
> 
> greg k-h

