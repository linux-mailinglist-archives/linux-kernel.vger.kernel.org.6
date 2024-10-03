Return-Path: <linux-kernel+bounces-349218-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EC94C98F2A1
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 17:31:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9906A1F20F17
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 15:31:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0E2D19F470;
	Thu,  3 Oct 2024 15:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="XaEh89Vf"
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11020127.outbound.protection.outlook.com [52.101.61.127])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E877DDA8
	for <linux-kernel@vger.kernel.org>; Thu,  3 Oct 2024 15:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.127
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727969495; cv=fail; b=OPw+aSK6Fm+2kLnm6aWOYbm/xHqI+T6UOsd/OYAnWHwBxL9r4S1nBmakadMba2EwZ8CXF4+CLHVxGsp1e9taIKiicbePL3IYhHRwg84q3MhAxVpezkKw2bK5kULgDEvglx0RUvD0k8Nen/I8qjEJ5mB90JGj9P1YmmaE9z29IJo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727969495; c=relaxed/simple;
	bh=lfupeje3ZJ7Pzx83pWO1qDpFuEmhrQmiUSoWOGsrATQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=hraXdrk0DQWI2TQrUnTnFiZB5D9mjDom1qpza2Abq8X5S8pdbMPxI+LBdeir9LpLJN57tJy32IMQJVGdsgEc2ibek9Xn8vdWEqsVFYK3PqBSsMIqcARd/VxEu2TaYHZwYUa6y74u6m8ZC2c+uR2H6JPThzh1qyTTZe7Zzi0hOWw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=XaEh89Vf; arc=fail smtp.client-ip=52.101.61.127
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M+8induq1W/UANFhWLmErxKlCuGnzTjVPRlWtaB7FKg64NV3dmWR7cP73vPu1UcFODVVNZNdTLFYImGTo2aJ8adqiz6pNid+wiXvkWAuufGDEDIzl4a4TbsInZspYG42lQUsJz8N2h0uyxiYKrrkyl1dg1q/vFuGjXuWSh/eol7kCdt839rJy1lGIZk+Ho7/HL1JYdBTf1EN4gezEc/cV7AfAxHcQ0dHYybAQZeeN4aOC/9B4iAy2pJ2MjXwExH538r49soE+X4J7gbEXgDsQRk7FouZgLUsp5uxtnIuXG65XnjFFFnzDPAa7ohMbiq7RsxK6Tw+XR7TIsQQNp/YdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kFEviKT+ULNIcsf5ijMlAja+gjgLKnutWHTBC1x4OMc=;
 b=zWmt5sKuhk3w4LDusoMz08b+y2GRFC9CNyxzCEcHAN0B2VGcT8ZgL5yNepB487fGjbBdio+xEO+4hjNlLp7nw6lC7OBdQDTbmYhI/6CRraln/y6onoaVIxjJxkxE6JZa8wFODF5dBMPE1T1m3lk6/8HOr7uAK2J6xzIfCLGz+6KEckq4j2600I8q8cxljG/P1vWrnFVdVPQ77rIQTEnjGoVpJp3rM7bcmdVv9dpgZByGMumMrTMTWV2lUCbA4JeuwBzxYr3cV5tfh+Z5qIag9ZxzHR+xccahh+JuRwhpoT53a0paGDOjxctvoMgVvlxvfG2PZR9704aFSYxRC/UE6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kFEviKT+ULNIcsf5ijMlAja+gjgLKnutWHTBC1x4OMc=;
 b=XaEh89VfOXlyCjX3PlgPl1Bof6tt4iKVqOo0OK/dd/fH+0qX5We53QfTYitXAEh1SDgX2uWtV1epkQPMuIMkXDizW5AQuo271ZH6dXp2nn9GE5HWM3qvBb1E5+CVUfLbQYNdF+wMTOW4Ee/0z9CECnYl0Yx+hgsqdHtD1E9K9rU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from CH0PR01MB6873.prod.exchangelabs.com (2603:10b6:610:112::22) by
 CH0PR01MB7185.prod.exchangelabs.com (2603:10b6:610:fe::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7982.31; Thu, 3 Oct 2024 15:31:26 +0000
Received: from CH0PR01MB6873.prod.exchangelabs.com
 ([fe80::3850:9112:f3bf:6460]) by CH0PR01MB6873.prod.exchangelabs.com
 ([fe80::3850:9112:f3bf:6460%5]) with mapi id 15.20.7982.022; Thu, 3 Oct 2024
 15:31:26 +0000
Message-ID: <43c2227a-71c9-4cbf-bfec-5a2fbf698f27@os.amperecomputing.com>
Date: Thu, 3 Oct 2024 08:31:23 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [v2 PATCH] iommu/arm-smmu-v3: Fix L1 stream table index
 calculation for 32-bit sid size
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Nicolin Chen <nicolinc@nvidia.com>, james.morse@arm.com, will@kernel.org,
 robin.murphy@arm.com, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20241002175514.1165299-1-yang@os.amperecomputing.com>
 <Zv2ONA2b3+kMAizm@Asurada-Nvidia>
 <1c9767e1-4d05-4650-bc14-65a18fc63cc2@os.amperecomputing.com>
 <Zv2diJDU6v60hKtU@Asurada-Nvidia> <20241002194004.GT1369530@ziepe.ca>
 <f28cab76-8030-477a-84b1-461dc02451ff@os.amperecomputing.com>
 <20241003111603.GU1369530@ziepe.ca>
Content-Language: en-US
From: Yang Shi <yang@os.amperecomputing.com>
In-Reply-To: <20241003111603.GU1369530@ziepe.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BY1P220CA0013.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:59d::17) To CH0PR01MB6873.prod.exchangelabs.com
 (2603:10b6:610:112::22)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR01MB6873:EE_|CH0PR01MB7185:EE_
X-MS-Office365-Filtering-Correlation-Id: b0bb8bf3-a70c-4895-8e0e-08dce3c0719c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TVZnU1RUVjBsaHNjSVh1M09wOU5RSHhBTmtSZTNiZkRJbk5IM3o2djVJaTVT?=
 =?utf-8?B?aFhFeUJJQ1lSR2EvNExVR0VvU2ROMzlwV2RqUmhVWElIWVhKVmtNbmE2dk4z?=
 =?utf-8?B?UnFlN0lPdUVIcFUrQjdvTXF4d01qZmVpY0JzMkxXMnNIb3NrcEZBUytzY2lG?=
 =?utf-8?B?bXk3NWdudUtvb1hDbXRuVDlZck1MaE5WYXpQWFhzUWsvUU1RSnVJZGdEVk1U?=
 =?utf-8?B?K0Z3bXVxaGVsWk1hWFhwL3kxV3Fvb0N6bWRmcVpWN09hVmdUb1NlL2tyT2hn?=
 =?utf-8?B?UEplQXRzKy92ZTRYdDRzWkhia2lwY2JHWit4UU91QjAxWTFXb1BqVCtxK2Rn?=
 =?utf-8?B?b05vcGdHUTFMT0VFOFdOQ3NrN0Rhck5uaFZrWks5a0ZyM0piMy8zVHhUT2ZE?=
 =?utf-8?B?VVROaituMHJpWHltVnRCNDV1QWFjeTFvSG5TMC9kQTNtZVQ3ZTJhTDNEcFFq?=
 =?utf-8?B?UnJucXhmaGh6Y0pHT3N1M25KektFRkdLVjdXR21MQ016bk1qd2RPSHEybTFp?=
 =?utf-8?B?QXNBYVJ6ZmtRT1NtcStTUzZwc0RreERXSEEvVmtUajFhUEU4bTZZU0N1ZVpX?=
 =?utf-8?B?WnFJaEZuTG9TV29IeDlUclhJQzlwbDlMZ3NKWWQrZGNhVHNIRFdLTUx4N2g4?=
 =?utf-8?B?OXg4MU1SR1ZiNUZjNzh3V3NzQUI1NlVmN0VhRTJQYlExdVQ3Ym1nd1V1Wmtx?=
 =?utf-8?B?Tndla1Z3RHAyc2UwaXdoSG9MMDU0Y3dDVzdUZjhqRVMyZFJEREJvZWhOOTBW?=
 =?utf-8?B?akFjSlNZRkJoWEdSYmVjdCs1ZW1zb3MvYmxPaFN6REVHV3pIRWxTOWQrVjVm?=
 =?utf-8?B?dnBTTndNOEZFQ01rRW9FVFRYanhhMzZwMjVkTU44L2RyTFFnOFV0bWhNMFpD?=
 =?utf-8?B?ZTZYMURMQktraENoUlE5UVBSTGxqU1k1dTNVTUcydjZ5OE5UWjRVNHJiQ0V2?=
 =?utf-8?B?M2RrOFRvS3RkbDNFMGJKQXJPdzk1OGtYZFJ4SlhDbFZKcWVQSy8wTERhK0ZZ?=
 =?utf-8?B?R29SWXN5ZUczNE52S3dZSHNWVjRXZkVHNTZJUzkzYzFVeXpQZlBSS1Y2Snhl?=
 =?utf-8?B?cEpQZ3dPV1labEJEeGdDRHhhQUVVM3ZRb3MrdGE4T0lkandxYjgxNEpFYVI5?=
 =?utf-8?B?UFZkejhBenhMVW5DT3BZR3NwK3ZBWWUwYnpqSTFtczJHUGlNazNxUHdpRUhN?=
 =?utf-8?B?RWpqeWZIeWhjSjNTWjlmSlFOU2FuQjhQQUxEaEpOa2xLZ1B3cEVyU0pWb0RF?=
 =?utf-8?B?aEtpWk9LUDZTYmdBc0FiU1J4SFduV0FIV1F1dXZjQnZZS2pFTDRKNXdlNExm?=
 =?utf-8?B?WHBDK2svUlJ1aFZrUlkxUjRlMWpjOHZXRGo5VC9CWm9WQzg3Y3JMQWVIMXRQ?=
 =?utf-8?B?OWhkcWNaRmR2Y2NUSS9tODc2cC9Bei92Y3poZlB1SWVhSDV0OGJnVzcrZUFC?=
 =?utf-8?B?S2c0aU15RlpNM3B1Q2VacDRVeHV3b05vK2VEK2tzZmlLdGZla0c4Qmc3SlMx?=
 =?utf-8?B?ZVlLRi9qLzBXbFRlTEsvOTlreldhWUFzUGsrV1FkVGs0NlMzUGMzRENnNUdk?=
 =?utf-8?B?MmZUZ0pYODl5TkNYUXV1TVA0WVFjK2FJWCtIUTFLQndhSUt1VzdJWWZPYlpm?=
 =?utf-8?B?WVJRSGlCUU5tZEQ3T3NJRWkrN20wYmxHRUoyUzArT1F5SW96c0QwQ0cwUHdQ?=
 =?utf-8?B?dS8zM05ZVjhwWGdlMk5LWFJvejBjYnBlZ3IyUDNFajNVTnFwODlhZmh3PT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR01MB6873.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QWE0S2xhYmZSVTBhdGREbnpOUTlMNjU2dTNMTExoR0s4NVFOVklORWEzeGE5?=
 =?utf-8?B?RS9WSVJJNmVnOXEzTUlyL1MxNWtxOXNzWGdCMElXWTlYajVWWUNVOElTTGlx?=
 =?utf-8?B?UDVybHRoT29KNkx4YTJIdDJUMkZ2T2JabVhETUo1VFRlQk5OdWVCMEdOVGVu?=
 =?utf-8?B?dmZsWlJoenFSK2wwMndGYmxWZTEwWWlySEJVTDJaa3dKaldzYjc0SzJvZ1d3?=
 =?utf-8?B?YVg1Q3VGSEZqa1hGeFowWExLVVN0aGVyMTQ0SHFKWTRUVmNOTEgxSjJZOTU1?=
 =?utf-8?B?UzUwWWlhZEU1OEdZZ1lSbWo0UUp2OVAyNWlmcURybGw2MElEMkpkMHlqdGJV?=
 =?utf-8?B?MXFybUtKNUM0VlpWYXZpWUQyTnZwRm94UjBMQU9xbFdOM3BBSXVXekFrbmlQ?=
 =?utf-8?B?QzNWRDFLMGEyWUlJUlh0Mk1pTzUyditiVTJub2l3d09zZnZxeTIxbmlMTVV0?=
 =?utf-8?B?T3EycGZqd1ovNHpTR2VBNlRSd1E4eEtvRzd2ZWt2bFRwd2hPYW9RV0dnb1Jw?=
 =?utf-8?B?dCtIazkzUWg1Q0g0Q2VOWGtHcGFJSnp6d0pGVUFSQUpYQ3BiWlRWUzNGaWJy?=
 =?utf-8?B?a28waU5xcE1WRWJnZG9MVHpCelNkaHJhcmllOE5SN3JXcUNTM3hON0JDbHFn?=
 =?utf-8?B?UmROUGlaK0ZGakR0M3FLUDBZVFFUdWh3S21HSStkUEYrVG1zcXh2QU5QMUcy?=
 =?utf-8?B?VmgzSEVrbWs2VExmUWJWaU5lVXJFWlVkY3E3RkdlNUwyakZlWEFrNkNvZUVn?=
 =?utf-8?B?TEhoM1lUdXZ1SDlSSnlhN2IySXFUb3F1blk2WFVMY1pLb3ZvU09tNXpKeHVu?=
 =?utf-8?B?ZjI3UUhMcEQ1OGVsV3pPUUNKU25FNkVsZEdxTWV6OG1WakgzSEtST3VmQk1T?=
 =?utf-8?B?RVQwRW16aVFqUTVxWENYY3BJaURBRnFBODBOMzVDZXMrcVlISTMrZVV6OVk0?=
 =?utf-8?B?RTg2VnpUY3AyQVp3bzFvMTU4KzBoTTM2VE4yOXByaWFUL2lJZCtYL3RHOWdY?=
 =?utf-8?B?NTdVWFp5RHk5QWxNMm9SUUQraXloYnpWS2dmQ2g0Y1ZMSTZqc2o5aFEvSTlP?=
 =?utf-8?B?cGJ3MDVuOWdXd1ZCQXVhZUlDcE1yc0hrSnh6amVOK0NRakdTZDlNWWdGM3Zj?=
 =?utf-8?B?dnBZUkhkOFRRZTBjVWF4bG5Pdmo1aW04NzdNZW4rMTZXY2NWREVDVXViTHNm?=
 =?utf-8?B?VUF6M2xiQ1hEcU5wUklLMlVEKy9BSEZXenJNMlZJWS9jdzBPRE54RzVjVWgz?=
 =?utf-8?B?M2lTaXUvR0p5dVNDQi9XaEdDc1pYbDMzeEpwbzNZUXlWY1BzTmw2dlFnekFt?=
 =?utf-8?B?WUJqWHpHUjE3QkdvYXZETkh2WkxnNVZ0dVFQY0VYMUZzQytvUkRvSS9kVUhr?=
 =?utf-8?B?MU9mT0lxWitpbUhxMUFOb1lIbm9hL0dOeXJ2aEFqczNkSHRla2owbzJ1T0N6?=
 =?utf-8?B?Z2VOU2JwcldsMEt5c2d4OEVpS0lVeWVZenVNWVVmQVBpTnBRY1NIWnJmWE1t?=
 =?utf-8?B?MEhmbWtDS0N5TFVzcCtLaUdHcnNGd1o5R2RScjN5ZVJPVVc4b3hOVHYveTVN?=
 =?utf-8?B?S01uYk5Pb3FyaEdtYVhWYXFIcmJuK1Z0Y0xlVXh2L3VPRWdSWjcrR0ZDYlV4?=
 =?utf-8?B?YTBGUUdBb3dLRFVaa0NSN3dHeGtnOFN3S0k0ajk1a2dtUlhZLytzZW5xVmt3?=
 =?utf-8?B?Qk1ZTzd5STRuelZCVDNpTll2dzIyckZUNitTVEtUR25CZnhGVklaeXR4cWdx?=
 =?utf-8?B?NHloSUc3VE5POThZNjVGSGVHY0IzWHBRWjNqb1VpWFFKSTZJVGNmdk9Gano2?=
 =?utf-8?B?VzdwZlhUQmNIOGJSVWZqM0NTbFdJZXJpZ0lGcTRKOFhjLzdaSUR6VS9LVUxa?=
 =?utf-8?B?U2dWY3pqR0VQOS9NRkpuV0kzVmdMdk9DdFd1K3BsRjVDRkxENERLelZXMkhG?=
 =?utf-8?B?RkU0REphWFBUOHRrY3RrM3UxTFpMeU9rK1lRL3d1cjFkV09FUzgzY2k5TTNN?=
 =?utf-8?B?TUV1TmRDK0V2cXgxUzlDV0RNV0tGVlJmT1JwYUdacVN5T2ZvWUhSVy92aWk5?=
 =?utf-8?B?Rm93aTNGMUFMZVlBeUtySmo4WVhBQTIxRVVxL041OGRJaGhBSnhONXNoUzJa?=
 =?utf-8?B?eHdXMXJxUitMWm90UWNOWGlXUzZiOGVUQlVvUEtQcE1OZUFERGZpUm9vSmdY?=
 =?utf-8?Q?Jj39L0JuxQEhnWtzgML1Qbk=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b0bb8bf3-a70c-4895-8e0e-08dce3c0719c
X-MS-Exchange-CrossTenant-AuthSource: CH0PR01MB6873.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2024 15:31:26.0887
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NfrNNab5Fp2lT6leXIU+wiPATfGhtBp9xWBpMFWhNUnWAzyhUuKpBev3XAdqs9bKayoEqGPKywQ8D5uXNJt1d4u9+ysol3WhfWu1c3BSmYE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR01MB7185



On 10/3/24 4:16 AM, Jason Gunthorpe wrote:
> On Wed, Oct 02, 2024 at 01:05:08PM -0700, Yang Shi wrote:
>>> It would make some sense to have something like:
>>>
>>>    u64 size = arm_smmu_strtab_max_sid()
>>>
>>>    /* Would require too much memory */
>>>    if (size > SZ_512M)
>>>       return -EINVAL;
>> Why not just check smmu->sid_bits?
>>
>> For example,
>>
>> if (smmu->sid_bits > 28)
>>      return -EINVAL;
>>
>> The check can happen before the shift.
> Sure, but IMHO it reads a bit better to check the size computed from
> the helper
>
> MAX_PAGE_ORDER is often 10, so kmalloc will always fail before we
> reach 28 bits of sid space.

I'm wondering we may just use 31 instead of using some magic number:

if (smmu->sid_bits > 31)
     return -EINVAL;

If I understand correctly, the check is mainly used to avoid the u64 -> 
u32 overflow. This check guarantee no overflow. If some crazy hardware 
really requests that large memory, the allocation will fail.

>
> Jason


