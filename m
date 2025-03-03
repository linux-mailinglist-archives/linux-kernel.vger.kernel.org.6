Return-Path: <linux-kernel+bounces-542349-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A24FA4C8E3
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 18:12:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 872FD3B3C4D
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 17:04:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B811B250C0A;
	Mon,  3 Mar 2025 16:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Ai17qirI"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2046.outbound.protection.outlook.com [40.107.94.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEFA0250C00;
	Mon,  3 Mar 2025 16:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741020398; cv=fail; b=d/QKNQASoIiOiC+0m2bP/akCdXRAgQEGUTY5aJG5ISlLUSvKsr8m+cUv1Cx6m5ozpQt6N6I79ealFX4dLGviBNZo0RznEd5E6XugOfPlga1WGbuabVQ+zLiTGp/F+bbImez4Rl72IKsEZePOnapE0mlWgU0I9OIkdULPjASjoeI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741020398; c=relaxed/simple;
	bh=nrcs9wJJmGWQq+mDqL7cZD/IPzovpZXp2/m8tcnUgeY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=MJXu3jKBLW4fnz0ByD/zmoCgbP4WdaDV9E1hftovV3bOZNiL56qMw7FqDzZCra2E7Xjjk6E8kkYTeZtrbD09TBMTjP1UdG6hNeu4u67V5dNPmwCs6j7IsaLWfgV0pBnhHgbqqBhLdSf+l1FEQxqnitiJCRUcNGZ7XjwJTc5EYCc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Ai17qirI; arc=fail smtp.client-ip=40.107.94.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LpZoPPu0R6hbuv1zv9o+eRzqJOxoHhjdUnp8p9RoFzI307nuD+tfFMxKjiLcpXibHlQpaiVL7dzgc/foRENNp3VizjP0k/4QRZMsKqYWPIufRpUxSbIQEKVVWZXC+Tb8oLPfACMomdlkB5dC7YK9LK+8dirIeudU6vPfHKuuYRuw8BUiOgD41ULDfjd7IPVok0LGMUh3DAyF5LK6f5ZtzP3v7pUIVIZxQQCPonEofIYeEek7GGz9chhubHLLygUJfC7oggjZ24SryMQDppoB0m8aJSsTBV1kMoHn71JRsRgos0y1a5MgKOtu+L8fsZM9z5ckU606CsPdruNffWguHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=73aZoLwisempMCQYIACR1TJtUp8gKeJF1zT0A/kDC/8=;
 b=ml2VwfKDiP0DiS1cuGe+rp3ftKfJ/l3V/viunRC07xc3UlZnRhxeycq7uoePIWBpjIuaObSymmSNZ9aoSRk82epV+sw2Qp/lhYUy7ENL6o41QT/ayd8J3+7QtSJmO+51/7F5pdPjLVvlE4BWwFbw47i6qr62LzqzmIoB3x8D4RDRMCQvGbL4NvC6WYbvrwvBVmuy7yBjOmf8yw4eUqIgUYCIgr29QQKDNuwzvMp1CtZBrTh0uL/Myw2/5oOga/voL1N4Nk7D3H/AtIRWzJrfSNyf/uc+kAapNEkbL0Juimzzt70LqxJfn9XNaHVAvCLVrBTRr3KhuKu4UaAoBPJ0og==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=73aZoLwisempMCQYIACR1TJtUp8gKeJF1zT0A/kDC/8=;
 b=Ai17qirIzf18UG55V7Zdzyd8OZkowBkViVYhxf6gnI/64Jy2DVBO0bZLvYcbaT7kTu/0JTA/u0JN9Pwa8jGM4M9ErMHbqc8e7qwV22qRI7I8S9/38HUX6pB77KI5qXJoUVSfcLIx4tM28W1IK5OrEwGe7f0csHtkA62joisCuTI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by DM4PR12MB5964.namprd12.prod.outlook.com (2603:10b6:8:6b::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8489.25; Mon, 3 Mar 2025 16:46:29 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%4]) with mapi id 15.20.8489.025; Mon, 3 Mar 2025
 16:46:27 +0000
Message-ID: <939e3b28-f11f-48ed-98b9-b5b5ef77eb0e@amd.com>
Date: Mon, 3 Mar 2025 10:46:26 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] Input: atkbd - Fix TUXEDO NB02 notebook keyboards
 FN-keys
To: Werner Sembach <wse@tuxedocomputers.com>,
 Hans de Goede <hdegoede@redhat.com>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org
References: <20250303161228.437604-1-wse@tuxedocomputers.com>
 <20250303161228.437604-2-wse@tuxedocomputers.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20250303161228.437604-2-wse@tuxedocomputers.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA1P222CA0069.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:2c1::29) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|DM4PR12MB5964:EE_
X-MS-Office365-Filtering-Correlation-Id: 555699cb-f239-4b36-80e4-08dd5a72f110
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SWxJZ3JnSkthYkxhcDZzMmx3US84UFk5aTRGajFvTlJVRmY4VmhDTTk1NzRH?=
 =?utf-8?B?SnFCaFFud2FJdGdPMEVWb2J5TzBLWFh6YWNsdzJkRjVQREd3bWJ2SUY0cXhw?=
 =?utf-8?B?UDc2clNJMUhqRGg0UHZKSzdodU1CeldqRUVlRjFhcDhiUHpkTVYrZEVUS1pG?=
 =?utf-8?B?RDEzK29pOHNvSGRBbEplSE1rUkZZY01vQ20zRnpLWG9HYXNlNlFaUjIrNHdv?=
 =?utf-8?B?aHh5V1JocWxRcFVia2lmSy9TdG1RS3IveEdodW5LWTY3cWFDZ04rQzczYkRm?=
 =?utf-8?B?bVpQU0xKbG11dHhDMjhYYURCaVRGODRPZmdkSTJVMCtOeHJHK3JZVDVJRUZ0?=
 =?utf-8?B?TFlhaVYyVjY0cUpzN1RlNXJXWXVxZkg3OW84WVhJMy9uU2NRcDBkTk8wRnk3?=
 =?utf-8?B?akRwaWZyYnZ2eWpaZ1pFUGxhSnpOcDVmNTFvQjAzQmQ0cW9KRUlNV3JrcmQ5?=
 =?utf-8?B?UEM3S0JMVzJ0bVhyRHFSNlo1d3Joc0t3M2hFZUpwajluZWxUMEdWdUVYRENi?=
 =?utf-8?B?OUNzK2I5ZzVQdzJsdUdhTStCMEtYcjh1UllqVGkwRmQrSE1qb2lMaE90a0o0?=
 =?utf-8?B?T0U4aGpTTElGYjFqRG0zZUxnYVRmYVVMbXRieEQ1eWJZazVwVzcrK3U2aWlF?=
 =?utf-8?B?ZWJiSGFMazBPQU5iK04ybnBMajYwYlNGNlNIZ2RteERySFdmRkZBYWVHREMz?=
 =?utf-8?B?TUNha01xc3R4dkhKdWU5UlVob2tVV3hNcUh5eUZFSC93ZFRTaEE4d1lvdjV2?=
 =?utf-8?B?SDYvNzBuQVdEMjZEZG1RaFpRUXZiSytBUlk5SldmUEdWbmk4NUVuUkNldTNn?=
 =?utf-8?B?ZGFJSmpOWWYxblVpZ0RRdFNqVXk4TnFjb2IvSnhxMVdpZ1VzODlYZTRIVk1P?=
 =?utf-8?B?djdzZ2FjL0U4Ym9FZG44S05uUmMrMDZXMXg0ckh1UmNpbjR1UDd6SU1VWVE4?=
 =?utf-8?B?NzczbU1TeWhhMnRGa2dHQXo3Z1lNZU1iVTU0NmFVZ3c0SGdtalFBT0gyWFlB?=
 =?utf-8?B?aHpCZ0JvZFdTK3ZJTlVVNFRqUkoxK3BVdkE0SlVzV3VnMFdGN0d2TFVvVXFF?=
 =?utf-8?B?U3MxZ3FLbC9zcUpIVWxkR2hNYWptdTVyS3ZRN0NpZTU4L2Q4ZnlyOUFFM3N0?=
 =?utf-8?B?WXQ2YitIWkt2Z20vcHFFWXZibVh4M2JIZFArNEp4VlNMQWUyOW0rSVhPclA5?=
 =?utf-8?B?VnVsR09GdnpjcUhqZWI2WndGM053bUdYMHpIck1jWlBiZnliSzdycHNZd2F6?=
 =?utf-8?B?SUlsWWxYUkk3WXdqU3NOZWVTNHc5ajJka0NIZGo0Z0ZIN2VTN1RFNmRIZUhR?=
 =?utf-8?B?NHNyRGpUbHNXNFArSFROU0pRZlRDUys4emRabjllb2JJK2Nja3BFVTU3emhC?=
 =?utf-8?B?R2FrQTAwVk1jblV1R2cwRjY1WXR0OCtRbFlxbXJGYzI1bDI0WVN0Ky9SR3li?=
 =?utf-8?B?VDI0dklIVm55d3BaL3pUekJ5SStIcVJIVXE3NEJlMXhwd01aWXZucjVFNkNw?=
 =?utf-8?B?Um91L0RBcXViTVJoNVFjTGRoWU8rMUkrVUU4c2RzOVkxU3M3b1BDam5CQ256?=
 =?utf-8?B?QkZpZnpJNUkxdlNUUGR4S3NMbWN1R3F6OURyS2VZN0dsdllncHoyQTBJeExV?=
 =?utf-8?B?QmUzSkxLRnlyblhwdVJaUEdseVhySE8rTXVjdUxBdEZwOGpiWEJDcEs0cHRK?=
 =?utf-8?B?N3I1UEVUVmk2cWljVGU1VFU2U1R5WXAwb1FLSXZqVE9xRFl5d1VQdERiMHJa?=
 =?utf-8?B?R3kyNHYxSmJnUXUrRXVUck9tRUsrRGt0ZDJOK2ppWDJDTUtyK0pnNTlSNXJV?=
 =?utf-8?B?U1l2WVV2anlaQS9WQTJQYmtxWksyT0RvMm53eUp3UUF1WW1qNEE3OVpOY29o?=
 =?utf-8?Q?KqtSe5VOg4G23?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TTVQcU9QU2dZRFJJUjVKV2VkakJVcGtiR2xWT3dVYVVDVGYrOFU0a0Y4bVBy?=
 =?utf-8?B?V1dHaUNCNTYvbjNlQUNXQlR0VU8xUlA5U1REdU5JU0VnY01VOVUxbXhrWFVx?=
 =?utf-8?B?Q2FJM3VKN3hiWGpFY0xqbytGL2JWODNjWlQ0aFVhOENSNk5MQWVNS2ovWlN1?=
 =?utf-8?B?WGdMeVF5MU9RcHVvRTZxWTdKMDQ4OGU2Z25tVGJjZnZHS3VlbStvLzUrWW1P?=
 =?utf-8?B?QVJWWWNjQXVJRFFGY1lHZWJkSHlCYjlLRW9VeHpSdXNGVERMNVJscStieGEv?=
 =?utf-8?B?dk11dkxUN29iZWxONTN6UUg1K1JxS2hOeHNXckFiTGJ1dktlcDVZaDJmMDU3?=
 =?utf-8?B?MnJjTFNsUllkUHh6TlI4UDlNSSthMVVzdGR5aENzMllTODFSMWMyMlIvcXVr?=
 =?utf-8?B?Y25VN2tkR1NqbllHdHR3aTlxS0ZlQ3BNTVV3Q2xIM205cHBuQXgxUEF2Wmxh?=
 =?utf-8?B?V2doaENDT1NRTytUMlVjYXNIOVljUVpQNHlZL05PcUxuK2NldmIvWDJjTGlq?=
 =?utf-8?B?YnFacVBsQnFNM0FvYVNKQjdQNnVQSWhzYVF1QjV6NWhpSGlaNHFWMDFpV2JF?=
 =?utf-8?B?aGlCQ3UzT3ZEUlZQbG1KWjNIb3ZmV1BieEtPTVUvRHBWQXRVTlBxUmduTTVD?=
 =?utf-8?B?T3FwTi9aUGZuemtHdWlkV1h5cldyWWpVTXBST3dZODB3SnJBMWJneDhQRERt?=
 =?utf-8?B?YytFOUd1OTVGVk4yTENOS0JrMXhYOWJWWGdJRkthS25JOUVLTEhuZHNMcDND?=
 =?utf-8?B?VUFYblRKUGZ1NEl4YlMxYXZ6amhNK2dMOFBYOXFGcXJNRDdGd1Z6SnJkVG5j?=
 =?utf-8?B?QUd5UlYwZnlaTFVSdFV5eGhCeTNteDhKZTNtaldGSTRaRE9pdVNkcndzOW44?=
 =?utf-8?B?VnJLYkRPZldlVlFrbGRQZmx5cnNERnd1OStITG5wWmdNVmtZMTFjUm1iSVZk?=
 =?utf-8?B?MmJWN0FteENKUllkdURsQ2xZNXYyQlRIWThMaHZsTDhnUjk2ZmJSbzRiQS95?=
 =?utf-8?B?MTZLVEd4VnFDVXlyNTYwOXlNQnNoRlhEN25aRnoyVkk2M0JEcW9JNUtPems5?=
 =?utf-8?B?Sis2SEdvRUxXaTgzWGNpVXM1VXFwU1lvTTg5ZXZWdkFadlliNVBPSW1xckZx?=
 =?utf-8?B?bksxdURWWjg4U1JXcVdLaE1YSUcwNmRvaXl5R2NpMXR4QlVaRHlSRzU5cG9w?=
 =?utf-8?B?eGJqVGZjZGh6T3ptTWdzVGZJNjgwR3RZcXV3MTVLRDNkd1ErdVM5K0dTMHNL?=
 =?utf-8?B?eGlEV1Bic2hEUnc1ZUMyMThHV3o5T1d4RXlNbjdrQVl1OHdReVU2eDhTeGxK?=
 =?utf-8?B?dnh5Z0VyVWdOZVVtYSthNll6QUhLVXA2QU1jR3VjWjVmN0ZRUG5MVVZ6WWtG?=
 =?utf-8?B?Y0pqS2ZCY1NSb2MwSlRxK2hMNTRBSGUzUzJtQkhtVnM5UG1sOVhFUW9JNVNi?=
 =?utf-8?B?Mk56V050YzlJL1ovWnV6TjlqZXFySmJQU2FEay9EeDEvdEtNb05HakwxTHVP?=
 =?utf-8?B?TVk2S0hPaUNyaWhuRVI4NExoemxNQVRkRXFFK2FCUVYreWVJMjVMUUZLOHcv?=
 =?utf-8?B?aEZFQUcyYkRPM3dsdkRJOWtmVTdma3R3dTE4N2tsV1lKMlE2Tk85aWdBWGFV?=
 =?utf-8?B?Nkh6aXVhZFdXK1Brall4UDRjMWNyMC83ditmQVRkeU95N0JFc3NpVEZRdlpi?=
 =?utf-8?B?VmcyM0tCQWV3ai93ZHpVcm10VjJWTVAvQnpvd0Vlb2hzNW8ybWxRclBnNDN1?=
 =?utf-8?B?UjB0bmxGN2Q2U09tREF2bE1YSU9jRVIrcnBFN0VUZktHbTEyRUNyQk5ManNG?=
 =?utf-8?B?bkhOZ3czeUxoeEZSL1ZTYVl0TEsyaEh0WU12eDJ3UTBHakZDbWk4eFFEZWxm?=
 =?utf-8?B?T0hRR2ZjNWxOZnU5OVhSbm9ZVzdDR2xVb3N5b0pSZlZVVGlkY3ZXTHVUQzM5?=
 =?utf-8?B?cGdQNjRuREVBTzhZbUhnM2Y4c25FWXBuRmZjVjlFMWNLK0VCNnRDYW5ISDV1?=
 =?utf-8?B?TThQL2c2RFVCOFhGa1hTT2NGTzRvM05JMkUvVGowWkpCbWlrVWFkaDliTVRm?=
 =?utf-8?B?SDlMMkQ4Q3BzVHRnTWw5RVMrYTlGaTcrUTlLYnIxeG1weVJ2b2tKbWcweklQ?=
 =?utf-8?Q?hLSU7W5waI1kpiPAYKwyDP8GB?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 555699cb-f239-4b36-80e4-08dd5a72f110
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2025 16:46:27.5251
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4v1Y+ucUzlS8JS/+rzBlpQicGsAI2CnnlytMIYN7ilYyxx+z3IvXZI0z/XMr5FPCW79BFVviyeHH0gnUce5mTQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5964

On 3/3/2025 10:11, Werner Sembach wrote:
> This small driver does 2 things:
> 
> It remaps the touchpad toggle key from Control + Super + Hangaku/Zenkaku to
> F21 to conform with established userspace defaults. Note that the
> Hangaku/Zenkaku scancode used here is usually unused, with real
> Hangaku/Zenkaku keys using the tilde scancode.
> 
> It suppresses the reserved scancode produced by pressing the FN-key on its
> own, which fixes a warning spamming the dmesg log otherwise.
> 
> Signed-off-by: Werner Sembach <wse@tuxedocomputers.com>
> ---
>   MAINTAINERS                                 |  6 ++
>   drivers/platform/x86/Kconfig                |  2 +
>   drivers/platform/x86/Makefile               |  3 +
>   drivers/platform/x86/tuxedo/Kbuild          |  6 ++
>   drivers/platform/x86/tuxedo/Kconfig         |  6 ++
>   drivers/platform/x86/tuxedo/nb02/Kbuild     |  7 ++
>   drivers/platform/x86/tuxedo/nb02/Kconfig    | 15 ++++
>   drivers/platform/x86/tuxedo/nb02/platform.c | 79 +++++++++++++++++++++
>   8 files changed, 124 insertions(+)
>   create mode 100644 drivers/platform/x86/tuxedo/Kbuild
>   create mode 100644 drivers/platform/x86/tuxedo/Kconfig
>   create mode 100644 drivers/platform/x86/tuxedo/nb02/Kbuild
>   create mode 100644 drivers/platform/x86/tuxedo/nb02/Kconfig
>   create mode 100644 drivers/platform/x86/tuxedo/nb02/platform.c
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 4ff26fa94895d..d3fbbcef813b0 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -24178,6 +24178,12 @@ T:	git git://git.kernel.org/pub/scm/linux/kernel/git/lenb/linux.git turbostat
>   F:	tools/power/x86/turbostat/
>   F:	tools/testing/selftests/turbostat/
>   
> +TUXEDO DRIVERS
> +M:	Werner Sembach <wse@tuxedocomputers.com>
> +L:	platform-driver-x86@vger.kernel.org
> +S:	Supported
> +F:	drivers/platform/x86/tuxedo/
> +
>   TW5864 VIDEO4LINUX DRIVER
>   M:	Bluecherry Maintainers <maintainers@bluecherrydvr.com>
>   M:	Andrey Utkin <andrey.utkin@corp.bluecherry.net>
> diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
> index 0258dd879d64b..9b78a1255c08e 100644
> --- a/drivers/platform/x86/Kconfig
> +++ b/drivers/platform/x86/Kconfig
> @@ -1199,3 +1199,5 @@ config P2SB
>   	  The main purpose of this library is to unhide P2SB device in case
>   	  firmware kept it hidden on some platforms in order to access devices
>   	  behind it.
> +
> +source "drivers/platform/x86/tuxedo/Kconfig"
> diff --git a/drivers/platform/x86/Makefile b/drivers/platform/x86/Makefile
> index e1b1429470674..1562dcd7ad9a5 100644
> --- a/drivers/platform/x86/Makefile
> +++ b/drivers/platform/x86/Makefile
> @@ -153,3 +153,6 @@ obj-$(CONFIG_WINMATE_FM07_KEYS)		+= winmate-fm07-keys.o
>   
>   # SEL
>   obj-$(CONFIG_SEL3350_PLATFORM)		+= sel3350-platform.o
> +
> +# TUXEDO
> +obj-y					+= tuxedo/
> diff --git a/drivers/platform/x86/tuxedo/Kbuild b/drivers/platform/x86/tuxedo/Kbuild
> new file mode 100644
> index 0000000000000..e9c4243d438ba
> --- /dev/null
> +++ b/drivers/platform/x86/tuxedo/Kbuild
> @@ -0,0 +1,6 @@
> +# SPDX-License-Identifier: GPL-2.0-or-later
> +#
> +# TUXEDO X86 Platform Specific Drivers
> +#
> +
> +obj-y	+= nb02/
> diff --git a/drivers/platform/x86/tuxedo/Kconfig b/drivers/platform/x86/tuxedo/Kconfig
> new file mode 100644
> index 0000000000000..e463f92135780
> --- /dev/null
> +++ b/drivers/platform/x86/tuxedo/Kconfig
> @@ -0,0 +1,6 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +#
> +# TUXEDO X86 Platform Specific Drivers
> +#
> +
> +source "drivers/platform/x86/tuxedo/nb02/Kconfig"
> diff --git a/drivers/platform/x86/tuxedo/nb02/Kbuild b/drivers/platform/x86/tuxedo/nb02/Kbuild
> new file mode 100644
> index 0000000000000..8624a012cd683
> --- /dev/null
> +++ b/drivers/platform/x86/tuxedo/nb02/Kbuild
> @@ -0,0 +1,7 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +#
> +# TUXEDO X86 Platform Specific Drivers
> +#
> +
> +tuxedo_nb02_platform-y			:= platform.o
> +obj-$(CONFIG_TUXEDO_NB02_PLATFORM)	+= tuxedo_nb02_platform.o
> diff --git a/drivers/platform/x86/tuxedo/nb02/Kconfig b/drivers/platform/x86/tuxedo/nb02/Kconfig
> new file mode 100644
> index 0000000000000..848ab61164404
> --- /dev/null
> +++ b/drivers/platform/x86/tuxedo/nb02/Kconfig
> @@ -0,0 +1,15 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +#
> +# TUXEDO X86 Platform Specific Drivers
> +#
> +
> +menuconfig TUXEDO_NB02_PLATFORM
> +	tristate "TUXEDO NB02 Platform Driver"
> +	default m

Don't most platform/x86 drivers default to 'n'?  It's up to distros and 
users to turn on I thought.

> +	help
> +	  This driver implements miscellaneous things found on TUXEDO Notebooks
> +	  with board vendor NB02. For the time being this is only remapping the
> +	  touchpad toggle key to something supported by most Linux distros
> +	  out-of-the-box and supressing an unsupported scancode from the FN-key.

suppressing

> +
> +	  When compiled as a module it will be called tuxedo_nb02_platform.
> diff --git a/drivers/platform/x86/tuxedo/nb02/platform.c b/drivers/platform/x86/tuxedo/nb02/platform.c
> new file mode 100644
> index 0000000000000..a6137c8b2d4aa
> --- /dev/null
> +++ b/drivers/platform/x86/tuxedo/nb02/platform.c
> @@ -0,0 +1,79 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (C) 2025 Werner Sembach wse@tuxedocomputers.com
> + */
> +
> +#include <linux/i8042.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/serio.h>
> +
> +static u8 tux_nb02_touchp_toggle_seq[] = {
> +	0xe0, 0x5b, // Super down
> +	0x1d,       // Control down
> +	0x76,       // Zenkaku/Hankaku down
> +	0xf6,       // Zenkaku/Hankaku up
> +	0x9d,       // Control up
> +	0xe0, 0xdb  // Super up
> +};
> +
> +static bool tux_nb02_i8042_filter(unsigned char data,
> +				  unsigned char str,
> +				  struct serio *port,
> +				  __always_unused void *context)
> +{
> +	static u8 seq_pos;
> +
> +	if (unlikely(str & I8042_STR_AUXDATA))
> +		return false;
> +
> +	pr_info("%#04x\n", data);

A bit too noisy for a filter, no?

> +
> +	// Replace touchpad toggle key sequence with a singular press of the
> +	// F21-key.

Multi-line comments are supposed to be /* */

> +	if (unlikely(data == tux_nb02_touchp_toggle_seq[seq_pos])) {
> +		++seq_pos;
> +		if (seq_pos == ARRAY_SIZE(tux_nb02_touchp_toggle_seq)) {
> +			seq_pos = 0;
> +			serio_interrupt(port, 0x6c, 0); // F21 down
> +			serio_interrupt(port, 0xec, 0); // F21 up
> +		}
> +		return true;
> +	}
> +
> +	// Ignore bogus scancode produced by the FN-key. Reuse seq_pos as first
> +	// byte of that is just the "extended"-byte.

Multi-line comments are supposed to be /* */

> +	if (unlikely(seq_pos == 1 && (data == 0x78 || data == 0xf8))) {
> +		seq_pos = 0;
> +		return true;
> +	}
> +
> +	// Replay skipped sequence bytes if it did not finish and it was not a
> +	// FN-key press.

Multi-line comments are supposed to be /* */

> +	if (unlikely(seq_pos)) {
> +		for (u8 i; i < seq_pos; ++i)
> +			serio_interrupt(port, tux_nb02_touchp_toggle_seq[i], 0);
> +		seq_pos = 0;
> +	}
> +
> +	return false;
> +}
> +
> +static int __init tux_nb02_plat_init(void)
> +{
> +	return i8042_install_filter(tux_nb02_i8042_filter, NULL);

The driver is tri-state.  If it was 'm' it wouldn't load on anything but 
the matching hardware.

But think about what happens if a user compiled a kernel with this 'y'.

The tux_nb02_plat_init() would install a filter even though they didn't 
have matching hardware.

I think you need some sort of assertion this driver matches the hardware 
and return -ENODEV if it doesn't.

> +}
> +
> +static void __exit tux_nb02_plat_exit(void)
> +{
> +	i8042_remove_filter(tux_nb02_i8042_filter);
> +}
> +
> +module_init(tux_nb02_plat_init);
> +module_exit(tux_nb02_plat_exit);
> +
> +MODULE_ALIAS("dmi:*:svnTUXEDO:*:rvnNB02:*");
> +
> +MODULE_DESCRIPTION("TUXEDO NB02 Platform");
> +MODULE_AUTHOR("Werner Sembach <wse@tuxedocomputers.com>");
> +MODULE_LICENSE("GPL");


