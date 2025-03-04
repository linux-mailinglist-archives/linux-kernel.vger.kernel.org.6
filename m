Return-Path: <linux-kernel+bounces-545160-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A108A4E9C5
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 18:48:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B248E16D7CC
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 17:43:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54E0F2D1F76;
	Tue,  4 Mar 2025 17:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ICZbZdF7"
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2073.outbound.protection.outlook.com [40.107.95.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86E0D259C95
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 17:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741108739; cv=fail; b=JrHr4mka54QG+Jk/PoneCFkvU55yacZG+NnMKJmNByO9k7vioe9dRc14OreptNaVxpHiQFbtk9Nz2O1j8K+cQSKfz/zGR0kynA6dc2hansg/wgiztm0+YhGcISnGlfBPDr0I/OxZio7q0hQ0AbnuuX/m4N83GN4vSUElVRSAtFk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741108739; c=relaxed/simple;
	bh=gI+IPiowxuECOcOy3nPF6v/CDR0CtdSSutNZtarw7o4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=mQmF7t+T/KbMyz+/akkRRxwZNCKOjL7n/jzbuGbO486vKIfOOf10LKiN9NRx4uKguf94hBpFJPWzqjCVnkq9nZ7XFAF1MK8fwek9w33HD/s5pRmWGUBKHd/tmzBRVl3fjRtWRAWUthzpjFk2/cfxC/6NKN/v+/fgmbmToseVNrc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ICZbZdF7; arc=fail smtp.client-ip=40.107.95.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dKI0aiC688HdBftzf5FYkmiVXV/Fq0tSsFyVC3kQ6BcZCVj7zQcLataqJpRSh6KvVHNE3FeiaH34Cd3gdsSvwpNFduinwy31n+PAJ820+ui0574HBsyKYyT2KJEAM+su1T5cWgGsi7gGMYqFiK1+NxMWdcFG/iKvQRwdaeW6GcPCk/6HfgwyaelC9U7iTy2KHfc/QlDWpvh8Ld9Pjyl+10BziYkNOwgXkQmMEIg0YwRUAx6Fj3EeNwd4wPZ7C6mRr5IdtSMF7MJgCdbjJey1I7bMIfWnCJ4otXF6yytXdtjU/dh326zHldPuXf3V2qUL9b19q9OvZiwwYWMX/PR9Wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bM+mkZxdzLUO5nxlVCoGCMYP9MSaF00Kp+bh2Ruv7Zw=;
 b=mtyGk2BvidNs07HSlAAD+WMDgX+WePUxMyZ4tAx6djvQCdhcwlUd/xb9VJphNhSgzLpJPzR9J7YNFHurGNQ5uhJVkp/wgJ7tkzUzFA6fAKTEis0ZuLvEwWIzFUHC/IzyBZHRXuztIasN2rhmv9veJxC6IKtIavz6e6KYO8sjxfjBm10tycTgCPweMnzFU8gLYAAdblEQ4XC5MOn37Pi0wGZGqBWZsPi7aYzDVHYeao+R1fC+5DUbW9U76skfpWgwLy18LVZhQWtvLI+F7/mfKZQkZ5EK6PZiJf4qDAiRKjWXvOR35HDBxEIOqyEUPv7I24IjfSi1HWfI/YAzl2Qo3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bM+mkZxdzLUO5nxlVCoGCMYP9MSaF00Kp+bh2Ruv7Zw=;
 b=ICZbZdF70cFWytBBtxerJwsVsoFMM9N/8DNKqsp2JfOmq0L/y1fME12ASmzqj0KnJ2PMlytu65loTi9k9vRLiTeGVWbDjBpZfMlpOKKKX5CLBppTekQaV1b8UpSNM5HoXLrMRELIawDZvZ+1yTpVBpJMcmVmiS4ZEOUFidPic+ymHGB/ooeElHo4dIxbefa6KYth/ZCgO61pth6KOfkp9Sjq6fwH5eAGRJjTGt+wjTT/Oo+iHdRmNiAs8XsgN2ahHM9FvnMToQd3BHxRAUjUfrf8hyxt6mZd47QwqfkJ7VN2GOHDZv7icryoWY4NHbCM9zK+KTSOdTEgkiDMHj8Ilw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 SN7PR12MB7226.namprd12.prod.outlook.com (2603:10b6:806:2a9::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.29; Tue, 4 Mar
 2025 17:18:54 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%5]) with mapi id 15.20.8489.025; Tue, 4 Mar 2025
 17:18:54 +0000
From: Zi Yan <ziy@nvidia.com>
To: Hugh Dickins <hughd@google.com>
Cc: Liu Shixin <liushixin2@huawei.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>, linux-mm@kvack.org,
 Andrew Morton <akpm@linux-foundation.org>, Barry Song <baohua@kernel.org>,
 David Hildenbrand <david@redhat.com>,
 Kefeng Wang <wangkefeng.wang@huawei.com>, Lance Yang <ioworker0@gmail.com>,
 Ryan Roberts <ryan.roberts@arm.com>, Matthew Wilcox <willy@infradead.org>,
 Charan Teja Kalla <quic_charante@quicinc.com>, linux-kernel@vger.kernel.org,
 Shivank Garg <shivankg@amd.com>
Subject: Re: [PATCH v2] mm/migrate: fix shmem xarray update during migration
Date: Tue, 04 Mar 2025 12:18:49 -0500
X-Mailer: MailMate (2.0r6233)
Message-ID: <0D97A437-56A9-4C1D-9759-EAF1F7DA5AE7@nvidia.com>
In-Reply-To: <23d65532-859a-e88f-9c24-06a6c7ff4006@google.com>
References: <20250228174953.2222831-1-ziy@nvidia.com>
 <23d65532-859a-e88f-9c24-06a6c7ff4006@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: BY5PR17CA0065.namprd17.prod.outlook.com
 (2603:10b6:a03:167::42) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|SN7PR12MB7226:EE_
X-MS-Office365-Filtering-Correlation-Id: 68f66d4a-943b-47ed-c281-08dd5b40a3dd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aDg1WFdpWExHaE85V3lUK3ZiWXlMWlM5UWNJQ0dwVU1uUTlZQ0RPVGxoQlhL?=
 =?utf-8?B?SkhYaG9DcFZpOU1KY28xcDZxZTRPRTJaNFZoRU43c0tQeGhEWVRTYkIrb1lX?=
 =?utf-8?B?YzFmM3VjQUFsNXpQRDRnZytiamV1MlJOeldyU1o3SVVBK3hyUG41VTQ1SjJZ?=
 =?utf-8?B?N2hrSGxrVmlNdjlib2ZhK1h5aEFzWXhFa2M1V1hraTR0OXNhcVZOWXdlQ2pE?=
 =?utf-8?B?YU1oVFAydlNjaDFJUFM3ZHJseGt2M1pQUjdoV09FMm12dEZIUEtnNTRSTEhL?=
 =?utf-8?B?ZnBkUUdRdnJ1b1NTSjlTYktUc0hTdTdLcW1TQmVERHo3S2lCSEJSZDloYk93?=
 =?utf-8?B?TmsxZXIwZlloZGU4QXM4YUszbGJCbVJHcXB6T3VDOFpYQkxuTXZqMDNmeDJa?=
 =?utf-8?B?N0k1enMvaFdmZ3hkeG1nRnJncXVGYk9NVEtTMzY3bG1HdjBMVFdhTHRVOStq?=
 =?utf-8?B?MkFGRks1K2hkZGIzcHNSeU1tWWhia2RrbmpWV1pVUE4wSHZ5T29Yc2xvQWpE?=
 =?utf-8?B?UmZIWExPS21xNGtDUFpFUmxzdDBIS3ZHV2pVQzE4M0lWY09INjlBTTBNRVlj?=
 =?utf-8?B?T2FwL21EM000WEt0eitCMXhXUndvWXVvUkxMcHMvY0owV3lKRVRzUHBSakZ6?=
 =?utf-8?B?ZE5leVAvc0RLTjhnNExZZEp2MVZ1ZzFNazNkTng0QTcwV1BOOEJraEU3NU1J?=
 =?utf-8?B?dDZkRTZXRnJ3YXZSMVlPcjJ0aU8yZW1yMHlqNFc0R1NuL3RqQUtUTFdoUEp3?=
 =?utf-8?B?cWgwUEE4U2pncWJZaVdTL0p1T1c0NHljYWRJQWRBN1UrQVRLS1hVMWhlNnRF?=
 =?utf-8?B?OGJLVW1ZdmtIWElwUnpRZlYrdkxFVUprOVZ0ejVxMGxYeTdOS1RUZkdNaGd4?=
 =?utf-8?B?REJuSjJJeVMzQ0xhcGE0aEtPYlBlWUt6L2xKVTZpOFpiNGN4NVlvRDh0cjhp?=
 =?utf-8?B?dzhTOCtrM0ltL29jSGpoMC9ROUF0dlp5ODYwaUlqZFc3b01LVFFlMDMrSTFx?=
 =?utf-8?B?RXB5RWRvVzljL3A4Rm9yd2tXSGM4WEVJZ01BSFZJWkE2b2FsYzYyUE1JSUxj?=
 =?utf-8?B?a0dmaENPNmtWUlhOalVlYk4xMjB3VjVrclA3a2E4RStYSWNpS3Izb2J0enFs?=
 =?utf-8?B?OUoyMlBFbmF4N2F6WHNqWk5TTGl3dFNEK3lTMkRBSjlhVUdRLzdGY2NaWTRY?=
 =?utf-8?B?NnVrUHRlYm92bUNheHljUTZCRS9zR3BTNzJFak5ObER1UkhLUVd5WkJyYUVX?=
 =?utf-8?B?OFFrV1ZmMGFZNjJ5ZGFkTDdheEVwK1V4VmNEdGpLQ1g3eTczQTVPaWgySTZy?=
 =?utf-8?B?dHhwRW8rSWQ4Z0p5V3Q4L0pyTHVYSGhqaHVHN0lHRmZqSSs3UkdzSktqa0Nr?=
 =?utf-8?B?Wnphc2tzWlE2UklXL1RodXBoTkRzN0hWbmlOL3I5M3htcHR2RFluRWVMV0hx?=
 =?utf-8?B?M3lUQ3BnWnEySjlWUTNzR0tuVDh1WUQxWmQ3ZlMwSCs1bjhDMlRsTGZIMzJs?=
 =?utf-8?B?MGdHYVNOZllwdkprY1pLOUQ3Z0hHWG9wR0dCNHY5K29ocm1LWk1iZXB2V1hB?=
 =?utf-8?B?WVJNWmZONnBFSjFseEZQRUdYYVpLN0d5dlBXK0VXNE9hYlpXTzZXSHNFaHdL?=
 =?utf-8?B?NndYMjZRT25SZXMzaUVJeUNYbTJNU0NIOEp1WDNYOEZOQk9xV2toUi9ZdDJu?=
 =?utf-8?B?ZEh5aWw3ZEswVG54eVVFMDNSbTVRVlUrajA3aU9KTnMwOWR5dGMydU4yNlpR?=
 =?utf-8?B?T05ZT0lvdUJSemxoZmZ2K2U1aW96S3l5UC9PUmQxQ1VtUEFCY3JNZDNLT2Ni?=
 =?utf-8?B?c0FxN3hEVlk5QzR3Q1NubmJKdzNHYTFCNDFFTE1tU0o0MkpVc1lBWGM2bk1k?=
 =?utf-8?Q?zJNbeWrRgr6gs?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RloyNXkwU2tocVhrcEJYZGN1UHFaZ1RRUkVlbW5BZkJsV1d5bzVVbmZzV2sx?=
 =?utf-8?B?c2l5OFVSM1hLdlkvTFFDenNXWjNNdkdMTllmSnhYcXF2NmxxMHhZZXg2V2Fo?=
 =?utf-8?B?eEFsengrdmIzTENJTTE5dDJwb0ZQZ05LcUxDMDBMZEx2NGc5bHR2UU1CSEs3?=
 =?utf-8?B?TSsrUXIydTZ1S2E0QTZFVDE4U3dCM0pNWlcxNFNHN1dVam5mZXllY3BqeCtX?=
 =?utf-8?B?MG4vT3hjY3ZSc3ZNczhnek8vL2JPTEpUc3NMZjFIcFI2UVFmS1pCamJiV2ov?=
 =?utf-8?B?YkpHb2xaL2g0RnBieWVzcEZydm5aSFRjWjlCZDJlbkpnT2tMTGNpYk5YbXFp?=
 =?utf-8?B?L0VaSE4zbDM3S3d1djBwQSt1TDVyTWJYcmNXMzlaQjE5bXJXdFlCZEJQN0U4?=
 =?utf-8?B?TVVPVFo3NnV0OWRHZXNpUTdmSTJFbTc1ZHEwa0hOREpQQWhkR1Z6UXdWTWtT?=
 =?utf-8?B?aG16RVNYcDFTbm5PTFIyTTZ2cHlFcVVsbXd3V3VxSXRNTWJQdHFQRi9yc2Jr?=
 =?utf-8?B?ZFdKaHk1WC9SSFZlMUVmRkUxZGVwbUVBWnAvMC9NRUVMZDlXQUlsMmVlM0RW?=
 =?utf-8?B?MXdHeWlOSDBrYmJaTlIzZTR1UzQvQzJxYkRmNGxRVEZQRkJOcGNPc3JQLy9G?=
 =?utf-8?B?RnBUdCszZDdhRTRvanhMM0FoTkdtZTZKRlYxaUpUNFFQWlIvWXhJZW5wVXhT?=
 =?utf-8?B?dnJ6Wm5JMzRGQXFzV0Y2clhLQUh3b2I1NEk2bFhxS2l1a1dJRXBzQ3FYSWV6?=
 =?utf-8?B?bUhDbTl4em8xNUdSV0pUZ1lFTkpOTGJ1T0NwY1JQQytPeWdHbUVtVUtzbzNj?=
 =?utf-8?B?eHA3RXBWclE0NmNDQThNeVV5ajhob0QrUDRJd1R2bHFoUlpwT0VsWkZDTHF1?=
 =?utf-8?B?REJYWnd1QkJOM00vNkR1a1VNRnkvTER1ZFFIajVqOVo4bkNQdFdOZFRYS0Nu?=
 =?utf-8?B?OUFySDhHcTZlbUtNYysvNFplckdiT24zbE5rZ1YzQ0VNdEwyVTBOc2s2cUdo?=
 =?utf-8?B?T3oycVoyc3hqejNESm1Jc3VpL3FBMXBxa2J4cDJZUmxBRStsVFdtSmlLUEVz?=
 =?utf-8?B?M2xyNXpXMXlaZGYzeGF1Ti94cXZGN0hsQmNUVjJkcUlTRXR3SG5GQ2hVbnJz?=
 =?utf-8?B?TFVNZFNwRTh5MlAwWFRvdW12cEd3cXFVa2kxUjQra0pTT21QQ1NQUWxWZ1cy?=
 =?utf-8?B?b0xST1huWW54ckdrcmVlc0VIQzZod3BrMWp2NS9Na0ZkbHp1WnBBcVNOUUlt?=
 =?utf-8?B?d2VUWGt1ZUI3dGhRL3pDb2xMRGIvL0R4UTdsYmdwMUtuR0pkcWtldkwrTmtx?=
 =?utf-8?B?Qjc5NUVlYVdjMXhCajJZb1hwaHhWWFlhOGlXSHE3Q2Q2MHMveWNud1JwK0x2?=
 =?utf-8?B?N253R3R2VzdUNkNwUGt0bmtKb0xud3d3YnpuUGhUMlJMR2pBbU9Idmo1RXJ1?=
 =?utf-8?B?ZWhRQ1JKRFhzNCsrd0FKWDFkajJCZXhJS01KVUI5cVRTOVFPUVBTaTJIRTFv?=
 =?utf-8?B?TGptR21mL2ZhaTFrZzhzdHJHUUwzS2VqY1Z3NTYwbzR0cHE4Z3BvOFlldkpr?=
 =?utf-8?B?MXYvRXNCeDdQUW9xRUxDMDJLemgyaEkxSnJud1JwVFFIcWh0RlFiL1lyQUFo?=
 =?utf-8?B?bVBQOGV6dmtqUDlQRnFMaVV2eWI5UmRqV3FoRk1CWml6V1k0dFlyTjMrSVFC?=
 =?utf-8?B?L3ZoUWR3WEYvcmVlajkwOXlHU3lpbjV3ZkU1amk4Q2wvWVJnWnZra3U3WStu?=
 =?utf-8?B?djRHZ3Z5VGs3Y01hWFJqT3JXRlltOWxpV2FnZ05JU1g5Y2poUWszMC91N1h4?=
 =?utf-8?B?OWRHZk5mSytqdHR2dmZPSURVcjkwL2k4UGJUT1IyQ3VKcG02T21VVXlJZVUy?=
 =?utf-8?B?QTRMMmZXa1NGZy96UkFsK2x0SjBHVzEraHoxNWphZi8rS3QwRzJjeFdOcU9D?=
 =?utf-8?B?WVlTenVPTXJGc004L0llSTJqV3ZkRnNoUlVRVUQxWEQ1Mmd1bXFDWnNlZlQ3?=
 =?utf-8?B?Y2kvRG5NNnRWRkxMSDBJZFhnZFhjZWwzRURva0V3TWFtL0dOVUdRbS80cEFz?=
 =?utf-8?B?TExSTlJwUFc0SWJpT285Sjlvb3hJNGhJbW5FTk9tMVNrdDFibXpYMWFNdFM2?=
 =?utf-8?Q?opPU=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 68f66d4a-943b-47ed-c281-08dd5b40a3dd
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2025 17:18:54.2932
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3QRDx8vMe0q1tKwxyKcLm+1YqhUlr5WmsLwNBkUJGi4y1Le1M12KvVUty+H41TmX
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7226

On 4 Mar 2025, at 4:47, Hugh Dickins wrote:

> On Fri, 28 Feb 2025, Zi Yan wrote:
>
>> Pagecache uses multi-index entries for large folio, so does shmem. Only
>> swap cache still stores multiple entries for a single large folio.
>> Commit fc346d0a70a1 ("mm: migrate high-order folios in swap cache correc=
tly")
>> fixed swap cache but got shmem wrong by storing multiple entries for
>> a large shmem folio. Fix it by storing a single entry for a shmem
>> folio.
>>
>> Fixes: fc346d0a70a1 ("mm: migrate high-order folios in swap cache correc=
tly")
>> Reported-by: Liu Shixin <liushixin2@huawei.com>
>> Closes: https://lore.kernel.org/all/28546fb4-5210-bf75-16d6-43e1f8646080=
@huawei.com/
>> Signed-off-by: Zi Yan <ziy@nvidia.com>
>> Reviewed-by: Shivank Garg <shivankg@amd.com>
>
> It's a great find (I think), and your commit message is okay:
> but unless I'm much mistaken, NAK to the patch itself.

Got it. Thank you for the review.

>
> First, I say "(I think)" there, because I don't actually know what the
> loop writing the same folio nr times to the multi-index entry does to
> the xarray: I can imagine it as being completely harmless, just nr
> times more work than was needed.
>
> But I guess it does something bad, since Matthew was horrified,
> and we have all found that your patch appears to improve behaviour
> (or at least improve behaviour in the context of your folio_split()
> series: none of us noticed a problem before that, but it may be
> that your new series is widening our exposure to existing bugs).
>
> Maybe your orginal patch, with the shmem_mapping(mapping) check there,
> was good, and it's only wrong when changed to !folio_test_anon(folio);
> but TBH I find it too confusing, with the conditionals the way they are.
> See my preferred alternative below.
>
> The vital point is that multi-index entries are not used in swap cache:
> whether the folio in question orginates from anon or from shmem.  And
> it's easier to understand once you remember that a shmem folio is never
> in both page cache and swap cache at the same time (well, there may be an
> instant of transition from one to other while that folio is held locked) =
-
> once it's in swap cache, folio->mapping is NULL and it's no longer
> recognizable as from a shmem mapping.

Got it. Now it all makes sense to me. Thank you for the explanation.

>
> The way I read your patch originally, I thought it meant that shmem
> folios go into the swap cache as multi-index, but anon folios do not;
> which seemed a worrying mixture to me.  But crashes on the
> VM_BUG_ON_PAGE(entry !=3D folio, entry) in __delete_from_swap_cache()
> yesterday (with your patch in) led me to see how add_to_swap_cache()
> inserts multiple non-multi-index entries, whether for anon or for shmem.

Thanks for the pointer.

>
> If this patch really is needed in old releases, then I suspect that
> mm/huge_memory.c needs correction there too; but let me explain in
> a response to your folio_split() series.
>
>> ---
>>  mm/migrate.c | 6 +++++-
>>  1 file changed, 5 insertions(+), 1 deletion(-)
>>
>> diff --git a/mm/migrate.c b/mm/migrate.c
>> index 365c6daa8d1b..2c9669135a38 100644
>> --- a/mm/migrate.c
>> +++ b/mm/migrate.c
>> @@ -524,7 +524,11 @@ static int __folio_migrate_mapping(struct address_s=
pace *mapping,
>>  			folio_set_swapcache(newfolio);
>>  			newfolio->private =3D folio_get_private(folio);
>>  		}
>> -		entries =3D nr;
>> +		/* shmem uses high-order entry */
>> +		if (!folio_test_anon(folio))
>> +			entries =3D 1;
>> +		else
>> +			entries =3D nr;
>>  	} else {
>>  		VM_BUG_ON_FOLIO(folio_test_swapcache(folio), folio);
>>  		entries =3D 1;
>> --=20
>> 2.47.2
>
> NAK to that patch above, here's how I think it should be:

OK. I will resend your fix with __split_huge_page() fixes against Linus=E2=
=80=99s tree.
My folio_split() will conflict with the fix, but the merge fix should be
simple, since the related patch just deletes __split_huge_page() entirely.

>
> Signed-off-by: Hugh Dickins <hughd@google.com>
> ---
>  mm/migrate.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/mm/migrate.c b/mm/migrate.c
> index fb19a18892c8..822776819ca6 100644
> --- a/mm/migrate.c
> +++ b/mm/migrate.c
> @@ -518,12 +518,12 @@ static int __folio_migrate_mapping(struct address_s=
pace *mapping,
>  	if (folio_test_anon(folio) && folio_test_large(folio))
>  		mod_mthp_stat(folio_order(folio), MTHP_STAT_NR_ANON, 1);
>  	folio_ref_add(newfolio, nr); /* add cache reference */
> -	if (folio_test_swapbacked(folio)) {
> +	if (folio_test_swapbacked(folio))
>  		__folio_set_swapbacked(newfolio);
> -		if (folio_test_swapcache(folio)) {
> -			folio_set_swapcache(newfolio);
> -			newfolio->private =3D folio_get_private(folio);
> -		}
> +
> +	if (folio_test_swapcache(folio)) {
> +		folio_set_swapcache(newfolio);
> +		newfolio->private =3D folio_get_private(folio);
>  		entries =3D nr;
>  	} else {
>  		VM_BUG_ON_FOLIO(folio_test_swapcache(folio), folio);
> --=20
> 2.43.0


Best Regards,
Yan, Zi

