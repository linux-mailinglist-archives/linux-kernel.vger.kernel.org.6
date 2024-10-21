Return-Path: <linux-kernel+bounces-373698-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35A9A9A5A6A
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 08:33:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3FF1C280A46
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 06:33:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48DD11D07BD;
	Mon, 21 Oct 2024 06:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ccvC3D+2"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2087.outbound.protection.outlook.com [40.107.237.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DC791CF7DE
	for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 06:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729492410; cv=fail; b=EQEkN7K2Wl+BMIdLdNw7M/a9fBhPzkHYknhLmpKqX6piXoeTXaVMhTuomNP252o8frgcTgBDZTUsiO8HVnwCaO/jAs27Gg7ORgWKRQmzhFeZ8kuIUKrt+tLHcB8tGT6cgy5rk10eh49GZswLsyPcw4qA53eWZMz52k61rSwTu1c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729492410; c=relaxed/simple;
	bh=CmHfsfamAqdP1lotk126+4k+dlN0Ks/yK9SNoNGvJag=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=GG1ViDSxyr183/zuD8mYOIH9aUT8tu9r/eMlSzuNPR47Lo1QNcD51LqOOMce4YOZisGv0keg8C54Xjim84XZSMMr1SY+MPRg6zokDqOWJfscJcann9M5PLlbg/gZpHL0k5ZnZHicrvXilMP4zVIR1ynuqcl8sKpoz/+3TF3mbek=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ccvC3D+2; arc=fail smtp.client-ip=40.107.237.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bvE9QgtqxgPphuZ+jg3ZBrGJJBsXAjAvEP5zgAZ4AKL/0vHvyY5lNnGTk9/HsNk49vynRiQobR557vtBhThrnlQMpYhFggSDKpnwKaltItUpp9D2OxMyXRCLcBvJHKe1NXq41fsCgXoq/0Zg0tMXr1UXZ6sZvzp2xFDzAr5hUGb+WjWAj4B78/02AtE49gdqGF4n2GBOrU37TaqHYL73CmkvQsUUNdqLv0YqsewIs2PalK2W1FsJvaJtpbU6Qt4WBQREWSyxWrCFMDyG5XFR14omHeiCtn5XPBr8yWO5fNGriWc8qftyU1R5ElQaqWoRUdp/SRe87BzwbhtH4Bzv6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n8ZcVFp8v9hz/m+C1DVhrWFoUvn7k+qWkbALnY4n11w=;
 b=h7J0ZvPkQ+GJaXlxRB7eQxZiUCJJb4obMt50555aO2eNsT3giAHYxcAG7wg7J6QXl8P9Io4LrjYIH//2Iv296iN54fzdwDtRWZL2V2vujRpGwVOFXwbzH5EcLX9r49S6pBclvwPCCiAcNS3LIZdQxbfVubWTFrGKasNXXVSdonl8A1SrtW52WvatImbg2wKSbjvNs2Y3RkOBBLlupSL111pUa1s5fGf6/1Q7bVVI3vumwLskM9SmM79Ipn3p/QG+3clnJthrjfb9HBnnDLOkqXuHbrRPkkwHJAmG+jHmv6GTFZ1fy8NPBHSCXk2QmlgWZjK7jTrWWT7b0KQ3Fabc/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n8ZcVFp8v9hz/m+C1DVhrWFoUvn7k+qWkbALnY4n11w=;
 b=ccvC3D+2ZUSy3KGezyGJU/L9CJk7L3nySgvNFXv/TGGS2Vyl0WyDqfEdpGJmkuYcJrG/AUsEAk34uh4aHFg36zRoKB1q6SZ7Hx+EVBfDTqM46KmypY/QnC8B2hyU/Gu9Ou94JCZ1W+3bfCoPaOkt1fc9YGZjFFDFeRykUerD+0D/38ZCwFUigbJjBPxkR47Ido2rUmtXC67TB+vuQU2j9UQTV5dKgtQr5jdiPlmXw3Ozldu6PEfwbWlXAp51SQvhLuSejbzl9SoJtlOKA8qknkO0hbk+4nAT5288G7/cbZSAvaz3hTo3JJduzzoeVdoI2y9k9D+hvXxi5GTc5uUgXQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ0PR12MB5469.namprd12.prod.outlook.com (2603:10b6:a03:37f::16)
 by DS0PR12MB6608.namprd12.prod.outlook.com (2603:10b6:8:d0::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.28; Mon, 21 Oct
 2024 06:33:25 +0000
Received: from SJ0PR12MB5469.namprd12.prod.outlook.com
 ([fe80::ff21:d180:55f2:d0c0]) by SJ0PR12MB5469.namprd12.prod.outlook.com
 ([fe80::ff21:d180:55f2:d0c0%6]) with mapi id 15.20.8069.027; Mon, 21 Oct 2024
 06:33:24 +0000
Message-ID: <fc42d9bf-3460-4d85-a09d-39b5634363d4@nvidia.com>
Date: Sun, 20 Oct 2024 23:33:24 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] mm/gup: stop leaking pinned pages in low memory
 conditions
To: Alistair Popple <apopple@nvidia.com>
Cc: David Hildenbrand <david@redhat.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
 Shigeru Yoshida <syoshida@redhat.com>, Jason Gunthorpe <jgg@nvidia.com>,
 Minchan Kim <minchan@kernel.org>, Pasha Tatashin <pasha.tatashin@soleen.com>
References: <20241018011711.183642-1-jhubbard@nvidia.com>
 <20241018011711.183642-2-jhubbard@nvidia.com>
 <cc9d692a-846d-4ae4-af4b-c8de8b724df6@redhat.com>
 <ceeb9dd7-bef9-40c8-aead-c1325f1e3a3d@nvidia.com>
 <8734kqcr5g.fsf@nvdebian.thelocal>
Content-Language: en-US
From: John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <8734kqcr5g.fsf@nvdebian.thelocal>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR07CA0050.namprd07.prod.outlook.com
 (2603:10b6:a03:60::27) To SJ0PR12MB5469.namprd12.prod.outlook.com
 (2603:10b6:a03:37f::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR12MB5469:EE_|DS0PR12MB6608:EE_
X-MS-Office365-Filtering-Correlation-Id: abc22011-8040-4b60-f0a1-08dcf19a4402
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|10070799003;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?S210cUozUnF1RUcvcSs1Z3N2OUhSYWxreFhtSzdnZXoreTZiNEFsOWVHUTl0?=
 =?utf-8?B?ZFAwM0JvYnBZc3hYNWJiZWowQmtCdTZJNXk3VWE1R0RCeU1QKzN0UmNudGxM?=
 =?utf-8?B?ZzBYbjViY05DZTNoNUx3N0ttN1RIRTVOTGh0S2hQS2pLY0tVRUlKa1grWGN2?=
 =?utf-8?B?ZHk1Z2tJNVFmQnl2U25kU05DYXRBRVlzWGVUVjVUdTNISjRacGRVNUk5MWlC?=
 =?utf-8?B?enpYT3MzYXVGa0pCcFowemxzQjllUUZxL0xOMDdoK292Z3JRMXdiYTBra2Vy?=
 =?utf-8?B?N2ZhaUk3ZUVvaVJhaUttTUNXUzN1TzhpOGkwWUJRakFXVGwyNXBaemN6ZEpX?=
 =?utf-8?B?K3YxWmpPWHFiZ2FFRnE5RnRnUkNnOW0wN2hiWUNzVmt5NFFYdlYvbnlvc25R?=
 =?utf-8?B?cDFHTk1yR1hITGkvcFRPRUxOdXJTZWUvVlhEMW96cXc3UGNCdzNWSDRuQ1Fx?=
 =?utf-8?B?TlVoc1ZqWlFxdzhZWTFPNWxlQjNtY21laitlQVlrTnR1NUJ0NUY3MWlYQ3Vz?=
 =?utf-8?B?aCtUWEFhbmpkd3V6WkkwQm9TSExmUU9vKzE3dlFQR21jTk0wZDF3THZHbUs2?=
 =?utf-8?B?TjIyQUNXZlhueVBVQmFoM0tGNDNjQVVFOU9ScW42em54RTZUMU56YjJrRkVs?=
 =?utf-8?B?VngwbmNEalJPZGRrVWFWM01lUVE3SVRXMG1rbFRkL1IzWVhFLzc0LzV2dHlF?=
 =?utf-8?B?bVdMRUhtUmtqMzdOeVRyNTQ1QmxucHBIVWRlUUQ3YUl1NnVibS9uaklIR1lH?=
 =?utf-8?B?NmRqTTZSOGNQZ2RhbHIyRlFvb1VOcWxtZGxHeWg3S1l1cHFpS3phOG1BM0sy?=
 =?utf-8?B?alV1cGJyNXhTdDgxcG1uQTgvUkYzbDNXU3lBK2w1SklkNkFzKzlGUVFKZkJB?=
 =?utf-8?B?ZStNS1o5RjNHL3YrUU13cDFFT3FJTDhLL2JVSGN3SFp2a3lScks2bzd4RTI3?=
 =?utf-8?B?Q3pjU0poNUZ1WkVjaVRTRWFuUjFDQTZDcnRHYlhNVUJhWWRMSmQ3b2ZWMkRo?=
 =?utf-8?B?SHlGVzFWZHhibUUyd0xUVXZmTmJtR2dGS2Y5d2Z5MEYxZTRRaFZBZ3A0RkRU?=
 =?utf-8?B?dGRWRUhHL1VnbG9OUG9lZFN5R2cxcjk2Q3VuTU5oeGt2R3ptcm1kdnZJRnM5?=
 =?utf-8?B?dUZ5eVI0ZUo5RDB5bWQ4ZVRXWEV4Q2xrZXhpcmtYVjRna1ZXQW5reitSd3g4?=
 =?utf-8?B?M0NXRnJtektxTjlZRlZkZ1ZLQVhrS3pRVkRqWEZoWVlwdkQ1cWZQQWZRMEdU?=
 =?utf-8?B?ek0zTXBDNmpiNkMrdHNWQ3Y3K0ZDVHB3QTcwc2xIYS9CWUt1dmdITTVBYjR2?=
 =?utf-8?B?dDhVWFBsa0lYaklRSjhHckwvKzB0MlVwMFVCSFYvZE42eDJaOURrbUdlYkdD?=
 =?utf-8?B?RnA2UGhuVmNwbUJUbVhhT2xOaGlzTERRK0l1RXR6eGFWVndBS245SWlVbjVX?=
 =?utf-8?B?TFk3MzNrMzZ2VHB1V2JNRlVoWUxYYnMxcTR0TFVRZGNJc3NqdE40TnhMaFJW?=
 =?utf-8?B?UTRER2Nmd0svSy82ZHZ4NzFueE1IK1FGRDlHRktpMHVUNTB1dVhzZG5OQTZi?=
 =?utf-8?B?b3JWUWNQU3lhS1NWN2cvMDV6Z2hmelhldjBTTkQ2MFowc1dLTzE2c09JbnlZ?=
 =?utf-8?B?SDJyanpML0tRT0dpMW1xNGx1UGl6K3gwZnBva3VGMW9DT0lwY2RGd2NRVjc3?=
 =?utf-8?B?STM1RVNHTVFnaUo2dkFZSGRLb2w4NGtvandrNmdWbmNubGhWVXh2MVNwOTJU?=
 =?utf-8?Q?/y6k78Vk8W1nz6gQrsUlKw08AoDLK93xZH4DDzf?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR12MB5469.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(10070799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WmRKdksyRlZHb2NJRzlnQmdtRkJ2c25DUE1uUlZXcHpyaXZvcDErY29qSmVI?=
 =?utf-8?B?YzFwNWxRMzVjQVNHcmwzWTJNNGpuZ3JzYS9IaHdRVHIxZmZ0RzVCNFliR1Bx?=
 =?utf-8?B?dkl0RTBmZDhJWkhYUWZ2bWxsTkFmZ25uSjJzNUtweE41RDR0a1EwMTl4WlZi?=
 =?utf-8?B?bS9IdExWUkowV0RDUkkrTDlLRkxUZzFMaFhvd2N2SmpIWWgxalJxSHY0U0V6?=
 =?utf-8?B?Vnl3UzkzTlZpMVlrdXZmbmxOZnkxSjlwbDc4cGNld0ExbXpXUzJEMXJ0MEVL?=
 =?utf-8?B?WnNUY2VmMFlhODQ4RXNhejNkZXRFNnZBQ09uVmtJZHBadHJwREdzK1hBMEN1?=
 =?utf-8?B?SjlkRllheVpTUWY0VlRvVTF1bDlXRWh3U002Z2Rtc3ZrS0htNCtPMVl4NjZH?=
 =?utf-8?B?dHZzamlPa3htSFZVSkhGNloxdDNDVTdwb2tIZWl2OTQwSGpscU9tK1dhNGtM?=
 =?utf-8?B?ZUVJaEx0V0VCbzZpbTJSOVMwdzE2ZWlseUMyQUtpZmFrZ2V4dUVpZUI5N1Ar?=
 =?utf-8?B?VnZ5czg0NzYzd0FrYVhrcG1tczAyOVNFNTBvTTFqbGxGYXJFdnFUTzFKcEJN?=
 =?utf-8?B?cm1Udk1GZVhDeTlYam5TMFhNSEJJeTBKd05kcVZsK2Ivb3ZXSzdXdjBnREJy?=
 =?utf-8?B?SEFBcUxHQ0phd3pGem0xUUpFaEF6bkxyazJmU284cWZPRGdLWDkvaDk2NUpt?=
 =?utf-8?B?TUtUQmFGbHREQ2R0WEIwSXpSZ2VyT09VTURGQ0F3c2JBV3lSMW01N1U3RUZw?=
 =?utf-8?B?Snk3R0ZaZEdmOHF5VXlNWGVOcGQ0S0tzemtBRlYyaFV3U2xXVzR3RDBsZEpR?=
 =?utf-8?B?N0VxRFRPOFNIbVc3SjRsNTBZUStQcFNialYvS3oydFFSOUNpNFZYcG1KbEFD?=
 =?utf-8?B?MTh0TEkvL2gxVFFJTHlHME4yc0dCdGY2bzhYdUcwVTZZMTFFSzJIa25XUC93?=
 =?utf-8?B?QXhCRVU1SW5YMEY4b1cweUcycDFpOG1zNUlkakd6c3VlYVEwODg0eDhlVG5y?=
 =?utf-8?B?ci9MMlhYSUJ6bEp0RExpWC9GcWdiWHUvTXNwNzJuYzEwRXFFNEEyNnZxR1Ev?=
 =?utf-8?B?Y0NTS05heG1ndmNUU29GSE53RVNlODFTTUpTMnF4bStIUXdtYmlTVHkyaW9r?=
 =?utf-8?B?aG53eW1aVkUzUkFTOGRVRm9TRW9ZQ2xYYWhKaG1pdEl2UlhRQ0cxSVE3eG9j?=
 =?utf-8?B?TGRITXlMRUpHTS9mbk4zK1lPYXFxcnVWZFJobUZmYlo4REQxUUg3clAzTXpH?=
 =?utf-8?B?dVArdjUvZHBSTnYydHlHSTdGTkY5QXBwVXhVaVBXOCt0c0NaZ2wveHREczFD?=
 =?utf-8?B?cStnd3l6dkFWNkt0QUZDMEFVVWM3dWxaOTRxcy9kNnJuT2Z5cVlDcEVDK2pF?=
 =?utf-8?B?WTNMK0ZYdXlKSFdpZ2Nrcm5zc0RYNmR3STd0alpXVWJOK1I1WTFoWUlyY2Uy?=
 =?utf-8?B?MnZGQjlheVJOME8yMGRIUkVMUHdHTXN6TTVGZDRSb3AyY0dwZFdlNmM1MEdh?=
 =?utf-8?B?RFJOK1N1Q0liSWl4cXVkL2hySkExcXdZdUpjTG5TbGFWdHp0dnA5aWZYTFU0?=
 =?utf-8?B?T00wdStnUWM2Yk5DajFYcjk4NDIvL2VPUjBhRjhYZzhpRldrZXRja3M1bWEx?=
 =?utf-8?B?STZkMWRmK3pFQXVVdVU4VVZGNU5CNGZxMWZ2MzJieWdwMmNhSVdOMGhkazFO?=
 =?utf-8?B?SWhtaENJbW1uTm8xOHF6NXdTU2s2Y1k3bytrbm50eGs5eUUzaFhuOGxPbnZZ?=
 =?utf-8?B?ZCs5QWpGUVNZaDRydUhJa2pUaVdFZ0s1eDRoa0wzQVlQQmdJK2NQRHlxa25z?=
 =?utf-8?B?OGFKMjNKT1FNUmRib0h3VEJlNDB0QWg3aS85VVcwTUVCQ1RSQW9McTRWeThZ?=
 =?utf-8?B?bFZUNjJvYXdLOXNNK3dPc21MRTkvWWRjc3owNEg4ZS9aNGxQd1dRQy9tOGFS?=
 =?utf-8?B?Wk1MWExSeitIK2grL0kwRExHcVAxOXI4a1lObmZvSWFFMTFTb0llR0NPcm5o?=
 =?utf-8?B?aklhc0NhcW1EdGlRKzFJdTNkU3kvQVVYQWlqdXU4UGtoZTRpQk56aDY3eWg2?=
 =?utf-8?B?V2VaU0tFSHZGYUtWbDNSUWN3MEhqMGlZTEswajV2dXh4K0hDd1F2V2lzS1BG?=
 =?utf-8?B?R2ZhbFRjRytrNDdnQWlsaUcyVUQrRmxUK1ZSNVozeGZNTk5lYVI1YndDNTRy?=
 =?utf-8?B?L3c9PQ==?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: abc22011-8040-4b60-f0a1-08dcf19a4402
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR12MB5469.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2024 06:33:24.9428
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +5z1uO6+wuFBkpinSMsBifWxv+CKJUp0LouorxiDSzSteu6fCeB5ouqZsvRr1BC2n/QWr5TY3T00UmwN8F9NAw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6608

On 10/20/24 3:59 PM, Alistair Popple wrote:
> John Hubbard <jhubbard@nvidia.com> writes:
>> On 10/18/24 12:47 AM, David Hildenbrand wrote:
>>> On 18.10.24 03:17, John Hubbard wrote:
> [...]
>> And actually this whole thing of "pin the pages, just for a short time, even
>> though you're not allowed to" is partly why this area is so entertaining.
> 
> I'm looking at your v3 but as an aside I disagree with this
> statement. AFAIK you're always allowed to pin the pages for a short time
> (ie. !FOLL_LONGTERM), or did I misunderstand your comment?

Sort of: short term pins are allowed, but at this point in the code,
here:

pin_user_pages(FOLL_PIN | FOLL_LONGTERM)
     __gup_longterm_locked()
          __get_user_pages_locked(FOLL_PIN | FOLL_LONGTERM)

, just before calling check_and_migrate_movable_pages(), we have already
filtered out any cases other than (FOLL_PIN | FOLL_LONGTERM).

And that means that code has taken a *longterm* pin of presumably short
duration (this incongruity bothers me), on pages that are not actually
allowed to be long term pinned. That also feels imperfect, even though
it is supposedly short duration...except that page migration is only
sort of short...hmmm.

I'm starting to think that migrating any ZONE_MOVABLE pages away first
might be better.

Since I'm already preparing that "wait for folio refcount" idea for
migration, which is almost related, I'll take a closer look at this
idea while I'm at it.


thanks,
-- 
John Hubbard


