Return-Path: <linux-kernel+bounces-326859-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8226A976DC9
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 17:31:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A6F2C1C239DA
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 15:31:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CF7D1B9833;
	Thu, 12 Sep 2024 15:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="yzc4bnlQ"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2084.outbound.protection.outlook.com [40.107.237.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23C091B12F6;
	Thu, 12 Sep 2024 15:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726155061; cv=fail; b=emYWGUSsMLVKdpSURuMqFVK4mvSY8sG6soqpWa9SpS581L5D0JhbeEreviASiSx1fVApoaiNAGC+7l7uxkpcQWxyh/vQJ5mwXs16YjaZQah2PfnYfQBMSrFgD9JtVLYSduc8G90x2lUrJQBGln9uYuWGnnCsEQ/nOKPJlumumAU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726155061; c=relaxed/simple;
	bh=6dPSip1KxfMPGFf2Z9WNW0Hs4EJUKoHzXmcCOZn0w1g=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=FymS3bAWfNevwdMYn8P8PwmJTXRhj2y0zhYRKL6lrWC2TKQ2i6eQBBC0aMOSMUyZOIN6nzM78WcnZ0m8q9FD0yhOnDKlXixbY6g5vSSXWzqmaFsES/vAZLT2pxQ3h64bGSUaggyC1uD8xUWJCCMzvB9Oq4bAB5Tqmtt6jIupPJY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=yzc4bnlQ; arc=fail smtp.client-ip=40.107.237.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VjIM6fVaTmVQ1urC3MxteQsLV8MZ1rRmP1P9NvjA/UkCoHGeUYZ/5gbTOGadY68paxJcmikB806OMoyynmBxxwxl+08umOL5Jdo7/DdhP+EoWm3YdpxODXK/UJxnJTDQUDJIT1a1Xcw6zGyP2mcBAvlNLTFdhcPZWzAAGvoP4YJIZ7SNdzN5v550wqq+f5FzJneoBpx8ROJqJXhktovb1NmeQkl0z3aY2utRID97/ZX45r8pG3C60c3DxokRkN1JW8r8JG5W0l0oyRRY+LEABSPufH9TnkyvO8wr3WZDV4u1tIWnT6EUh04O+LX2jzQeAeO8N/crOtN/1FlWSAY4nQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zZUsym6SE1GhguGfItHdHa8XLBuSjeQEhPeYIpsvoO4=;
 b=tWK/0Qkm+eDSKOBm6TDCMtg4Fb+Kh5SqhWMpgEdmA9XUfpbDs/rqdsVdYAeUG94AYC8Ohg8mxT2VGyNTJPAIJO8ky4MKUigqz5HpKlnu+o8wZlQT0QUPsOOuwLCwUvDCLmgyqTaJUp04nJL+xyE74JRe3YB9XXtUbCMt+z/Ap0y/IqjYxUzAL+OGG8g62aqoB7g7l8Sr7bkBD+xQPpEn2AXNsm9NMSm3iwATeFihKOe729+wVaweaLpHKs8c0lbJruMOIE5VoguntXGPewyDlLr5zxGakUe3liYB/4Wtm9VU4SDIACtXTuD4da5A+5S+dfxYT+OTqAKNdZu1fRnpxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zZUsym6SE1GhguGfItHdHa8XLBuSjeQEhPeYIpsvoO4=;
 b=yzc4bnlQ5BRfqf/bvdRZoo2P6fhPWchuUvUhXI+L/V8OsiVHH7ddrHwxx6fIXWGIExq7nA6xzsIQJY/QtncaTs9qxacUQu3IwxD2JhRMg4CsFEPbu0t+XYMm4aWnz0lq2dhz+rxZQg+/5XiQFqznnLA4x9ACT5jAbey8nP7Xxj4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5176.namprd12.prod.outlook.com (2603:10b6:208:311::19)
 by DS0PR12MB6629.namprd12.prod.outlook.com (2603:10b6:8:d3::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.25; Thu, 12 Sep
 2024 15:30:57 +0000
Received: from BL1PR12MB5176.namprd12.prod.outlook.com
 ([fe80::ed5b:dd2f:995a:bcf4]) by BL1PR12MB5176.namprd12.prod.outlook.com
 ([fe80::ed5b:dd2f:995a:bcf4%7]) with mapi id 15.20.7939.022; Thu, 12 Sep 2024
 15:30:57 +0000
Message-ID: <b3ecf961-c399-43b2-a8b3-6b5ed664db27@amd.com>
Date: Thu, 12 Sep 2024 21:00:49 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] platform/x86/amd: pmf: Add quirk for TUF Gaming A14
Content-Language: en-US
To: aln8 <aln8un@gmail.com>
Cc: hdegoede@redhat.com, ilpo.jarvinen@linux.intel.com, luke@ljones.dev,
 platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240912073601.65656-1-aln8un@gmail.com>
From: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
In-Reply-To: <20240912073601.65656-1-aln8un@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0171.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:de::14) To BL1PR12MB5176.namprd12.prod.outlook.com
 (2603:10b6:208:311::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5176:EE_|DS0PR12MB6629:EE_
X-MS-Office365-Filtering-Correlation-Id: 896be18b-b327-4779-6f65-08dcd33fe56c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NzNzRTZMVE5ud3MzT1RuUi9PdjB5SjRhZGJPRUQ1cy84SlZsMmZGb2VaUWUw?=
 =?utf-8?B?MVVmdzArbVJQU3dVZHpsMGhPT25MTkpxaFpwR3NxQzAyOWJIYzk3aThpdG80?=
 =?utf-8?B?OVVGZXhqcVpsaGc5em1kMUYvZ0dLUWpCWnQ2TnpLcllBa1UvWmVHWEUvdjRE?=
 =?utf-8?B?dVdsbGJJN0tXNGd6cjJ2RUJIZGdSalVJdFRORCtzZ1d5akN5aG9oTHBvd3dY?=
 =?utf-8?B?M1VtYnpWQ1BxYTdjRThrU1ZjZ29xSmlFU095QVFhSFRhWVUyWnFWWmZlcHE4?=
 =?utf-8?B?REtuVDhraFNJUnRBR1JZUmM3emx0ZTRNYzAwd3JYeU9UVEM3NEpTcjJuRUVB?=
 =?utf-8?B?eG4wQnhyNWJYRWVTejE1aTVjdC8ycGh2Y0NPMlRyYUdPRVAvTjdyTEQ2QmFk?=
 =?utf-8?B?cHg1RXZwTTNXRUdibUdtNmZBNEF5dGYyUjVLRHVZQ0d6Uk4yYUx4bDRVVUt6?=
 =?utf-8?B?V0xUQzk4M3BNY21aY0EzT3BWbW5RNS9Nd3M1TW1xVy9CUEw1cDBaaG1VMm5k?=
 =?utf-8?B?SHBYSXNOYVh3T0h5UXFqNnRCUDdMWEQzY3JtV0k5S2M5WHcwYWxBSjVNRG5Q?=
 =?utf-8?B?YjVZVVZUbWp1UE9Qa0FYNGo4MXRwbmxVSVpTWlA2K1czajdoTXcxa3NDeGw5?=
 =?utf-8?B?Mm1sTGJRWU53blk5SUtYK1g2L1RqMERCRWFKMzJ5UE9Ld3pzaFdWNU5ldVhU?=
 =?utf-8?B?djlzd09MNjRuak8yT0pNRldlZ3h0Z3QzQnp0NDJ4eTNnNUFlaXM3VWM2YzFN?=
 =?utf-8?B?YjVPSXlHNHhzZnIwZm0xeXg5L0FTZFlsNzFMcVJDNTcvTVcvbkVWdkluYnJv?=
 =?utf-8?B?ZDlsaCsrMXRWd2ZsR1h1TFZRZEh0cUx3c0doMWtCTUZ3WTVLa01NQVBZRUo3?=
 =?utf-8?B?S0VYdkxMcEhNdGtMOXdqT1FqM3R1bEtvd2FRZk9ySEVBaklySWpENDluSXlo?=
 =?utf-8?B?QWJJeVJJbGhlcUJnbFhrRitQU0pSbElvTnhINWpSVW9CRE5TR0tDVXhRSkJs?=
 =?utf-8?B?MUNZcElOMng5MHBTNnV1cHR0cUpmSkdrZDJ5d0ZJeTVaYVVKMjV1QlFXQ2FI?=
 =?utf-8?B?blFTTy9JV3UzSjhFWFBGZ3o4WFVFY29yQzlwRkp6Q1BHS3pNaG9oWUVXam52?=
 =?utf-8?B?R1dxM3U3RlpwREhaTkJkWll4S2cyTld4b1VMajkzeVZrbTdzOC9adkFnVlpW?=
 =?utf-8?B?SEVpUStpN2VxMktSd29MVkNjd2prUmVDZHhpU09iUDdmQUV4SGtGbi9BWXlD?=
 =?utf-8?B?OHg1U3hZdUlOY0lySUk1cExza3dnR01DVlBIVjVIcWRpNzNaRmxJdlg5d2dP?=
 =?utf-8?B?Rk5qb0MrQ0pPeVY4ZWY4R3BuQlpuc0gvc2JLdGxRMU1URW15K0Y5ejVKbE5o?=
 =?utf-8?B?Z2drOHV6MXcvTTlNaGJjZ05PZXZPY2taanArZyt1Ui9HRlVaV0tMbkc4eWRr?=
 =?utf-8?B?ZHIvNENNZzRRbjZ2Ump2akhVV2I4OU42Z1hnUnlhSFF3WXByRU9oNE9wcU01?=
 =?utf-8?B?aXZmZzFiVVp1akZ2NjV0NlhFTFhiYXZuYy9DMmRpaDYzTENhVVUzdnRqOTgz?=
 =?utf-8?B?bWpDM0hQVlpJWUVZdkF6UmUzRUNqbVd4VXZWZG82Uk9xdHc0NC90ampVWnhh?=
 =?utf-8?B?dEtIK2NTNTF4YTdHUzdpSDEvYWRtbklFaitOeHlvTzNMeHZnREhlYy84NU00?=
 =?utf-8?B?cS8rL3JDTEE0dTBoWFMxK1F2dE9rQWE0NHhoRGFIc0ZFQ2pDNHhPanVNLzhn?=
 =?utf-8?B?UGMxdWU0TUFLd2huWW56VTNvZmdwOUF6Z1h4Zk9PR2FpTDltRlhCZ1J3Mkov?=
 =?utf-8?B?NUdVWG5hZDVSL0FWVStoQT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5176.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TXBFK0JZVHZIMnRQWTU2YUY3OHArRnVqYzlVV25ZaE5rQ1NUTnlFd21uSUQ2?=
 =?utf-8?B?NkYvanZlN3UzSzF3bkx6cEFVeC84VnpZMFhIR0hiT2hzTXRxNDFvS1QyTi9n?=
 =?utf-8?B?MVhqWjE0ak1vVm1vZTBTSS9hdS81aDM2akhkQWZuSExHM0Q2SHFNTU9PNVdk?=
 =?utf-8?B?ckdWalMraHRyVFBYQXAzcWUxM0tPQzlsc0FiMGM2anJHdGluaVZoV1BVSjd3?=
 =?utf-8?B?Z2Q3N0hDZlFZRThLdmkzTndEWnZ3aW5vK0VQQ2h4NHU1V2JLYVp2bUM0bEVn?=
 =?utf-8?B?ZjZFWjcwYXBWQzZveHV0UVA2Q05sOWpPek5zOEo5dStKdGZEcnkwWmJyV2tC?=
 =?utf-8?B?NmdwVTZmR1lBckNjU1NFQUwySnJPSEJvakhxOVZIV2FaM1hNZXVQd2lieW4x?=
 =?utf-8?B?K3ZMTkwwSkxhbkk1aHdRb1p4YlFsMXVKdmRPNTUzcDVkZzVNYytXVy9sUGVs?=
 =?utf-8?B?eksvbHJZZ1N1Z0d2L1BFZzIxcVl1ZWhMK09OYko1MlJWZDJ4YnVtOHg0dWhZ?=
 =?utf-8?B?Q1AyTXgzZmRzL2dBRVVQYnFIcGs4SlFWRTJJVnYwSkh0UWlMWjdIa0pCUllr?=
 =?utf-8?B?Lzl4NjF3N0VyNDhKdnhjbEZ1b3VBV2R4S1A3aEVoelFxNmYyejBGVUkxRDJN?=
 =?utf-8?B?cGJCNnJnRURsM2cwWjlPd3c5Yk9GU1lHc09DMmpmVmhUL0NEZlZsM3M4WDdx?=
 =?utf-8?B?S1VWZkdPU00zWXN4VTFoaVlSaDNycmRNY01OR3ExT25BK1BYVElzbGJXVmR3?=
 =?utf-8?B?SUp4QWNRd1BoMDhuMlF5Q1JvZWNvS1krenlwdGE2L3lXT3lGRVhMWEdqV0hW?=
 =?utf-8?B?c0o0cy9lQzYxQnZYWmNqZm1GUzhFUUswL2xyOFppY05JQnhlZEdocSt6dkxG?=
 =?utf-8?B?bFBzeUVKdGNTcmRoVmJnYUhXbFoycVpxN2dVZDJOUUR0NUxBTFowTysyUENL?=
 =?utf-8?B?amRuQlE5N3BtOEpmQXp0dk1tUDRFUHRhN0pWRmNwQXdncVhpdG8yVTd0U3hq?=
 =?utf-8?B?TWMyVDdyUEwyZjUyS1ZWc3dvYVJyOVBrYS8waUVSY2NsSXVERm83c0pqTEcv?=
 =?utf-8?B?YmVDR2pYV1h1OVhNaTlSSzh5ZTMyNmFiSTU1VS9LcWdUZHhDS1lUU1drT3ZL?=
 =?utf-8?B?cjJKeU4xSENYSHhxajBoYVF3dkpjWG5RMExURFprVDIxOERScHR5S0phSzQ1?=
 =?utf-8?B?Ulo5NGpLSEQrV2VMeitCZXJyTzUybXZQVjJkdXpGMG9HS29Ed3k4ZHoxQ283?=
 =?utf-8?B?aDZXZTBrTUpRdy9wU3F1b3pXRUU3RnZYL0dXdEJjOERYajBFZ0xkYW9pTXMw?=
 =?utf-8?B?S0hwY1hncVBtWHozUzFPZnNkSHUxVWYvN2hyUThKTndaZ3k4VVFldHEySy9N?=
 =?utf-8?B?VlAwR2RWdU53TjFJOEJaS2JCR2dQUnkxbmVEdzVpSG1TSkIyb2VpS1I3OGlI?=
 =?utf-8?B?WS9jY09CaFg2dlI5dUY2M09IZkZ4OWQyQkl2Tmh2blpseVlMUHBUZWhIdHcz?=
 =?utf-8?B?SGtSUzlPUWRFT3hKQk55L3IxRFZLSU9ld09UK1ZNK0k0K3plMndGaFRRb2s1?=
 =?utf-8?B?SFh0UXlEZFJnaTNxVW1LTHNjZGJRSytPRHY3elNGQTFmbDFXdG1GUy9sN0oy?=
 =?utf-8?B?YzJ6R1Rta1dZSVFjTXJiZWJ3S0NiNjQzTWoweGQxVmFzU0N1REp6MFFKVlBW?=
 =?utf-8?B?QzdaVFNMRytnUzVMei94VVNQVFRRbENScjk4dlN2KzlzcjduNXEvZ2VDelR2?=
 =?utf-8?B?ZThONERKT1dqQnY4ZUFhTExLNkgyUmlJZk5sMklTbEVlaVl2YVBqTWNEL3kv?=
 =?utf-8?B?N0ZzVzZKRVp3UlNBZlNZUGcrakZUYXdIK09Jejhtb3o2M3VrSFBLSTMrLzZl?=
 =?utf-8?B?MW1HM1QwdWpWZ2dQc04xR2hUejlsb0VvaGhSdERERHdyTVE2ZFFlS3JQcXFQ?=
 =?utf-8?B?Z05ZYzRQaCszWGlXSXFlYU5XUVh5NzVnU2M5c0x0UkpiMHNVR0g2anJhT2Rs?=
 =?utf-8?B?SmE1QXk4ZjZ1SVEvWDdVQkdCQzRFcS9XSHBXZEpUUkZkS3RWREtZUUw4RXBm?=
 =?utf-8?B?MkFjdGpMZ1FHa0xXNURWN1FWQ2E3ckJvMXU2Zm1ib2I5REl3Q3hpV1dFRzd3?=
 =?utf-8?Q?O69hOO0c9KYGpO1JlYS0JoTcX?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 896be18b-b327-4779-6f65-08dcd33fe56c
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5176.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2024 15:30:57.0770
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h8Bkwi+P2pHnX+BFROr8wnyKSXs1UbhJ1RoELmswcRbDvJYoYAdEgDgVZI12HU2JSgDJtFkiqQP6dihU8q2d6w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6629



On 9/12/2024 13:06, aln8 wrote:
> The ASUS TUF Gaming A14 has the same issue as the ROG Zephyrus G14
> where it advertises SPS support but doesn't use it.
> 
> Signed-off-by: aln8 <aln8un@gmail.com>

Thank you for the patch. Looks good to me.

Acked-by: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>

> ---
> v1 -> v2: Change to FA401W so full series models will get the fix.
> ---
>  drivers/platform/x86/amd/pmf/pmf-quirks.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/platform/x86/amd/pmf/pmf-quirks.c b/drivers/platform/x86/amd/pmf/pmf-quirks.c
> index 48870ca52..7cde5733b 100644
> --- a/drivers/platform/x86/amd/pmf/pmf-quirks.c
> +++ b/drivers/platform/x86/amd/pmf/pmf-quirks.c
> @@ -37,6 +37,14 @@ static const struct dmi_system_id fwbug_list[] = {
>  		},
>  		.driver_data = &quirk_no_sps_bug,
>  	},
> +	{
> +		.ident = "ASUS TUF Gaming A14",
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
> +			DMI_MATCH(DMI_PRODUCT_NAME, "FA401W"),
> +		},
> +		.driver_data = &quirk_no_sps_bug,
> +	},
>  	{}
>  };
>  

