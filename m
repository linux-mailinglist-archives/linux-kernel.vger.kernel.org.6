Return-Path: <linux-kernel+bounces-348193-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6075198E3E8
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 22:05:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 205F728419D
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 20:05:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6D59216A0E;
	Wed,  2 Oct 2024 20:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="VvfT8uUP"
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11020103.outbound.protection.outlook.com [52.101.193.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 572112114
	for <linux-kernel@vger.kernel.org>; Wed,  2 Oct 2024 20:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.103
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727899519; cv=fail; b=XvUXvAoQtPv3h290uta/bvmtb8zBkBCTEq7o6eufVlPkk8JuCiL5FpYogMASBRfHFpVFsi0zbt6S4ZNG3KvWyZpt6hBABrWvFGMMPcKoBOIJs7I96W99cJfOe1KwHo8Sd+mrWsfOmoZlwSpSmnEdl6EgT70sUDjCP0LAY55kwZA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727899519; c=relaxed/simple;
	bh=Ggvlo11Sekr2c5OFO1YyXhe3prw8kt0maDhRtfX/CE0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=twwdqIPbWZERBodDgPD65ChbQlUqTj8ixjLpMNUT3niSNBY8vu4UPnA3f5HHeSzYkejYVWu0oJXPtI4R63WwwlWU9NzXe/NOg/TP1Xh+63BHPLVE2VsMZOwCiQbWvNHvmNJiBlyOU3m3+bvbbD5MDqHLkudm7RZwZjNuhnHJaRI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=VvfT8uUP; arc=fail smtp.client-ip=52.101.193.103
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nRVxF4IManWbzINMlgiue5EdqT28nq+JbcvaQ94M14cJrb1cMv9zcRrNTqvm2w5IiF1/CsknoVDI0Uyq9OtG9OpJ4LD1ndaAFUXcWaEeQXRzUYcyvpZl/ftE+MFAQOLBBDSZ9eCMxLpnsKntehRWNGcGGo3E0HE3xjHOYm/ssE/rhsDf2dXP8IjektFdnUB/2Z9D2n3MMhxMr73ziWIBF9Yb/0tNjdzWZv0RNMKOB7bVPYNlA+ABfenElqvr0KlGY+XRtI+ivt0w23uCr2tAy6tirrQCdu6GXAR3tEnz1JUFK24LaB3k7sZTEV2KFs9+wt8l+V+QKnLYvwVDujfC6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aEDVgnufoCtKnV59ZR9fbI7A7M+U6tfwkE8YbJW/dyI=;
 b=KZf0/jtfJSLFw3mEReUtcVqS8g6jQwRSz6P32J5f94hJT3ofz6Ty9TmW8QjP9Q37JWOnotEnjdrIYcY3AGZe+zYPLzPUAz1nseRmzwtG9UWAfty9xVlEyKwIsb35DSvDnutSnFEav8SRhSNtqskAmx+yUrPTyFwf7sDgEpEy1qmyVkbM9tROpTv0f1IS+s88PxTBnb2i61p6lr+t/3DjqqYBYPmx0HGBknrq5zfEejL0N6vZQoS2uyB3MvGEiMpLHy3Ku0tieecBbtY1lMqrdPGdnAeaOt2mftXJenZvWWEbEXLqYkI3b5cuttTSiXglORGuGCtaz88QJnJwovF3Ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aEDVgnufoCtKnV59ZR9fbI7A7M+U6tfwkE8YbJW/dyI=;
 b=VvfT8uUPWCMQ9SbLObskdiJiepkytSdkHOwlueRiuIysOQiw0/RCdPf2FbBsP/2zT2eRZJgzbIOXIHlh3rQtsHig8jdfhkTfIajerzvE3QKsIaGPu83Cs0EagRC1XVGCnlWxQ4dCWFdBwCWKoW73YmAI1jNOI4jwEib4tfxpGyo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from CH0PR01MB6873.prod.exchangelabs.com (2603:10b6:610:112::22) by
 PH0PR01MB7893.prod.exchangelabs.com (2603:10b6:510:286::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7982.32; Wed, 2 Oct 2024 20:05:12 +0000
Received: from CH0PR01MB6873.prod.exchangelabs.com
 ([fe80::3850:9112:f3bf:6460]) by CH0PR01MB6873.prod.exchangelabs.com
 ([fe80::3850:9112:f3bf:6460%5]) with mapi id 15.20.7982.022; Wed, 2 Oct 2024
 20:05:12 +0000
Message-ID: <f28cab76-8030-477a-84b1-461dc02451ff@os.amperecomputing.com>
Date: Wed, 2 Oct 2024 13:05:08 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [v2 PATCH] iommu/arm-smmu-v3: Fix L1 stream table index
 calculation for 32-bit sid size
To: Jason Gunthorpe <jgg@ziepe.ca>, Nicolin Chen <nicolinc@nvidia.com>
Cc: james.morse@arm.com, will@kernel.org, robin.murphy@arm.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20241002175514.1165299-1-yang@os.amperecomputing.com>
 <Zv2ONA2b3+kMAizm@Asurada-Nvidia>
 <1c9767e1-4d05-4650-bc14-65a18fc63cc2@os.amperecomputing.com>
 <Zv2diJDU6v60hKtU@Asurada-Nvidia> <20241002194004.GT1369530@ziepe.ca>
Content-Language: en-US
From: Yang Shi <yang@os.amperecomputing.com>
In-Reply-To: <20241002194004.GT1369530@ziepe.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DS7PR03CA0083.namprd03.prod.outlook.com
 (2603:10b6:5:3bb::28) To CH0PR01MB6873.prod.exchangelabs.com
 (2603:10b6:610:112::22)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR01MB6873:EE_|PH0PR01MB7893:EE_
X-MS-Office365-Filtering-Correlation-Id: f067bb4f-158b-4cdb-7e7f-08dce31d862b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aERnMDJoRmRBOTdEaHJBZ1hXUGJkNk1Yelllb0tFdGk4NEgya1liem05Rm5G?=
 =?utf-8?B?VUI2M2J5UFRuVGdqQ1MwMnplTkplaHliQmRKODVjOEtFM210Z3FvSE1NM0FJ?=
 =?utf-8?B?Z0h6elYzRG5pblpmRUZ3Skt1YlRNRFJVNDdvaCsrd3JFR0Y4YTR6U0E3a3BP?=
 =?utf-8?B?WjgreUJYSDdiZmZXMVRXZGpRYXlyaU9sOVFQL0VGMVpxZ25SWEJobEgybzRj?=
 =?utf-8?B?eUh5ZlR3MGx4Mm5sSnliMXdHcUh1TjJ4NHRHZ09nQ3Fqd0J3SnA2MHN5TnlL?=
 =?utf-8?B?cWQzRjNjRVd0TS9oc0E3NjN6VWZQZGltWlJ5S3g2ZjdJcHQ0QS9ZbThVbW83?=
 =?utf-8?B?K1RxZ3gzd3RsUHZtT0xiTTcyYjNFTFMrNmdyTEVLYWNXTWhxSFFsKzhZbVpU?=
 =?utf-8?B?NEt6WDgxNzVpKzR1RERsNHNRMG1YVVdKZHZUNVlBM3hYK2lBeDFZeUtEMlZ3?=
 =?utf-8?B?dVYrTzh6WGN1YjhXazhkaWJTMVlqeFFRckNLTGlBdDJBWFV0MWZlNUxraUJL?=
 =?utf-8?B?R0I2T3J5ZSsrd3E2bnltN29qVFFUUytyZW45TnF2WkljUTFVYkE5MXNTTUVs?=
 =?utf-8?B?dzdWN3pSdGQrTThTRVQzQk9wZUdnMVEvb2svOHlUNHA5VEFpclJhMXJqZzJs?=
 =?utf-8?B?TWxZUlZjKy9QMUM5UWwzbnI3RytJT3k4bTliTXJEejlSWXRRVjR4UE05SG05?=
 =?utf-8?B?eUMyL1BBTHMzMHkwQ0RpdlpmbkZ6RUxQN1c3YmEwMlpKOUYrVVZhei85MWZw?=
 =?utf-8?B?RENGUzRKNnFtbHhoV0VyNkFvQWNTVCtMaFREQ2JsWE82RVZsYThUK1F5R3RT?=
 =?utf-8?B?VDlOYWpwK3drcDRCZ2t5QWJWL2NBdEVWN3UrYXVzWEtDV0k4TnQvRmZ1WTRs?=
 =?utf-8?B?Vy81THhteXRrUXkwdXdlblUzdE95TTlJRk9xMEZhYW1TblpaQi80WWNBRDFK?=
 =?utf-8?B?Uk1lQW5TY0JKSnJPV3cwVFNibDF2QkNaa2FmdEsxWVRMalZ1aU56Wis0bnBl?=
 =?utf-8?B?akJkVnRzZkFhanpXVEdkazdwM0JzSHpLRGVyL2NvZGcwWFBCVm9HSUdIWnFr?=
 =?utf-8?B?MUYwY29CL0tHV0hhYjdXUjBYRVN2bFVheTZUSEI0V09HQmkybFZTdy9OOEh0?=
 =?utf-8?B?NW1HQU1jcndabW1vdFJmcjBxVTNKcm5iRGovMTJMd0JrNWRtbUpERGhwNXFo?=
 =?utf-8?B?U05wYVh5anRRa0Q0a1pvOTUwaGZaMWNHQ1FrTU9XMktoSXdmY1hha3ZPbENL?=
 =?utf-8?B?WnYrVTdOenhEZUNEUXB5Vk1iK24rc01YRUFtNVFjNnd4QTlFRk1yQ0hSd3Q5?=
 =?utf-8?B?bWFuODZtM1R1TGE4a28rN09KbzNxQWpmZGRhMVQyQXh4YWFiZk9MTlh4ZFFs?=
 =?utf-8?B?bEY4OXhiai9EWDE0RVdZLyt4UFV0NnY4T0RuWTVucGc5QmdId0tFLzVxU0Nn?=
 =?utf-8?B?SHFKOUlaQTJhR0FrdTRRMUxQVEd6NkZac0xsMzMrbXM0em15a3VMSFB5NlVM?=
 =?utf-8?B?QUhIKzBGTHNKUHF6L29FVDgreXNxRTlSaTV6L2lZWHdPN0lmK1hyanYxQlo5?=
 =?utf-8?B?blB0RUxIWEdlWWtXYlZUT09XQy9WM2k2eGZTZys4VDdiTS9ZTlhqdHZ4dTRI?=
 =?utf-8?B?TnN3eWlBUndlUHkxTGFTUEZPL3dpSU9hbUE5SG8rcUZSZk9INkU4WDZOcXkz?=
 =?utf-8?B?a0QveGpIdEJHY1c4ZGlublJSWm13TXJHYlprOFJvNUxZRSt2Q2U3K1dBPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR01MB6873.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TG13cFNDai8vVlprSGVUeVgvV1A2Z2VLOFJZU3FKK09Vcm5BSWpPQU54NWlh?=
 =?utf-8?B?UUM0cllzclFkOTRaTjMxalg3MlpVRTFWaDVqQ1JXdXNLOEpidmtaR1kxMStk?=
 =?utf-8?B?dEFSUEVxZHhWSGNkV0V6RnRybHkxS0VnVGJNMk5FaWhRL0crclcxek1UdTF2?=
 =?utf-8?B?TWlLU2xjYnUrU3krbWtLeDZCLytIVkxvQWZ2dWNpWjQyUHNDYUhFeW1rUnJO?=
 =?utf-8?B?dE1sTEt6WGhCaFoxbC8xbXlCVkhNVFFRbVFwYWxhL2krNE05QVIxUklxcEdW?=
 =?utf-8?B?UkZ6RXZYV3NvTFNxMmF5MXEwWWVhOFFTTzVodGVWc0hDMU5YdGUyajRXOXBw?=
 =?utf-8?B?eEFpb2FONFg4c252ZGIvL1lWNUh4QmNXbzNZdXhIMzJLSmxCNVlJcmFwRjJi?=
 =?utf-8?B?TWxNYS9kVHBZNmJqTU9xNUVHYXB5cDdEVnFIZmlmYkxPaHB3eDZldGxURVJI?=
 =?utf-8?B?ZXg3SmkyTmg2SGVCSUF2VTcvQ2xWdXFhVkp4Mm10blgwM0VNQXdjbW5NRFBR?=
 =?utf-8?B?V0hGMzBzNTVCN0dybGtwS0pFUGZ2ekZzbnFzQjFaWHNwOGwzQkIxZ2psQlhR?=
 =?utf-8?B?d3BRTXA0c1M4NHl2d0VUQjJrNU8rTGhpZEhDQUVlbmZvbGJTVW1Cc21Lb0hZ?=
 =?utf-8?B?WWV6NjROSW0xb0FBY25Scko1WUhiU1hEOVhyZS84eWNrbFJ2VGNxSjliU0wr?=
 =?utf-8?B?K2QwWE5XTTJkZ2tBV2w1bVhEMExURkJLdnR4aGt5LzJHVmptT2pzTFpmeHFK?=
 =?utf-8?B?aThvRWZlWXJkbXR1WmdpSFZrY09zU01aSVVGQ0I2djcwSHBCS0FxZCtzaCtq?=
 =?utf-8?B?NkpGR3c5TC9tZVppY1VBSlNpdWhGaUlFT0dPWEtNWmdza2VRWFpJZS9NVE5L?=
 =?utf-8?B?MGEzZUxYMHZMdjEwMU9KVzBLbEoyNTBrN0o3eEk2S2JDQk1YcWYveE9WNUJQ?=
 =?utf-8?B?S1V5RWhFekFvc29RWG1rMGlDL3M1NGVjcUZWQkJveW1VcE1lMUd2M0J1THFi?=
 =?utf-8?B?VXZRbVdHMVozRzVkemJUcDVMZlh2b3I5S3ZVeGJDcFVmU0dLNUlnUndTMVFz?=
 =?utf-8?B?ZjQ0TUV4ZE1HNHhob1NFdS9GcFZ4OGV4ZnNldm1HNDR2RlVBYTk2cUYvdTF1?=
 =?utf-8?B?VHhabGtpaEMvSjFzRjhqcitJeXNMYkxoMEtZQmlrL1BLR2RwY0N0UHJtT1N5?=
 =?utf-8?B?SVIxT3BUdUU2bHk0TVFnNGorbTJMSGJMcDF1UW1QazhhRFhDejUzMjlmTVdJ?=
 =?utf-8?B?TlVzMk5ZbmdqNjJCbjZacDlKdjBxUFduN3J5UU9VcjVvUTQ4cmMzL0FWZlFE?=
 =?utf-8?B?THpDbHlpRUFUVEJsbitUcG9ZeWVuQkVITTczdjVhV1NhVDhQNTMwdnpyWE1l?=
 =?utf-8?B?U0lPaXRBeVowaTNVR0RyT01VQjFKMWtuUlNSdnlwNUdqMW5HbEJpM24xdk0y?=
 =?utf-8?B?eHJ1NkVVQ3F4MmRYUVc3VFk4Wml4RHpHSm5FVlNFckRkc1VaU3MxZHhPcHBY?=
 =?utf-8?B?VUw2RXgxR3Z3aDdvMnpZMm5wZm8yUXpCTG5maVJmUGMwWFNCNGJpMi9aZ1FC?=
 =?utf-8?B?cC8zTHVoZXRWOUExN1dzdE5LTzJ2MXZNUHFmUXA4YjhOOXFjNUlRMXZZdnRC?=
 =?utf-8?B?VFdIbmt1WjgwVDEwSEY2WDVHOUwxWGxZVmY3SXUzZHNBaE5YYnZGbHo5VTVI?=
 =?utf-8?B?WVVCMnNRRVI5aEZlTlAxQVR5aGJDb3lSWjArTVVSVmZFVUhjVklvaFdOTWVl?=
 =?utf-8?B?MVdBeXhiZWN0RldBaE96Y2lqRmVNU25rYnU5dm43dEVkclJRL09ZaWNZQTlP?=
 =?utf-8?B?b1BDSDJndVU4SlZhN3BSeGpwSUVXejMzMjVCRFRlTzBlVW9DM3laWTZLNEEx?=
 =?utf-8?B?cXJSUEJZM3BmV2ZoTTQ3eTRNSWdiYmZ5cUVMUXZZdVNZMkY3RER4aTBPcmlw?=
 =?utf-8?B?YXRBM1lqREdHWDgvcDJoUk1jd3pVaHRka2dhTU1YUmhWVnBaakc4ZkJXRCsx?=
 =?utf-8?B?REM5YmQ1enU3dlcySUhCZzZMTStKaWo0V2YxeGo5RlZSVGRrb2NqZjk2YytF?=
 =?utf-8?B?cTY3c3JINC9tL2pRVlRtZHZUa2ZEOVB3bWtPTVZiL21ac3p5ektVMXBrbjVn?=
 =?utf-8?B?ZXJ6Sm95eXQ0eTVHVHR5bHpaNTNUOVFWV0kzQmg1N1VieGg3Rjc5dHpmaXY2?=
 =?utf-8?Q?5s5Vqi0KQC45b+9MK23e/Mc=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f067bb4f-158b-4cdb-7e7f-08dce31d862b
X-MS-Exchange-CrossTenant-AuthSource: CH0PR01MB6873.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2024 20:05:12.5314
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0pCTjvx9fbMGLXH6aQ9IdrJY0S8AwdCquoh085pBwnnw1ALlXnB0EkpqQ4hsmNvyFubQ2NIekeILcZPnLOCU5LK9BwE5EfJZvE7wNPz6gd4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR01MB7893



On 10/2/24 12:40 PM, Jason Gunthorpe wrote:
> On Wed, Oct 02, 2024 at 12:22:48PM -0700, Nicolin Chen wrote:
>> On Wed, Oct 02, 2024 at 12:04:32PM -0700, Yang Shi wrote:
>>>> On Wed, Oct 02, 2024 at 10:55:14AM -0700, Yang Shi wrote:
>>>>> +static inline unsigned int arm_smmu_strtab_max_sid(struct arm_smmu_device *smmu)
>>>>> +{
>>>>> +       return (1ULL << smmu->sid_bits);
>>>>> +}
>>>>> +
>>>> Hmm, why ULL gets truncated to unsigned int here?
>>> No particular reason, but it should be better to not truncate here. Will
>>> fix it.
>> Yea, and looks like we are going to do with:
>> static inline u64 arm_smmu_strtab_num_sids(struct arm_smmu_device *smmu);
>>
>> Then let's be careful at those return-value holders too:
>> -----------------------------------------------------------
>> static int arm_smmu_init_strtab_linear(struct arm_smmu_device *smmu)
>> {
>> 	u32 size;
>> 	struct arm_smmu_strtab_cfg *cfg = &smmu->strtab_cfg;
>>
>> 	size = (1 << smmu->sid_bits) * sizeof(struct arm_smmu_ste);
>>          ^^^^
>>          overflow?
>> [...]
>> 	cfg->linear.num_ents = 1 << smmu->sid_bits;
>>                      ^^^^^^^^
>>                      This is u32
>> -----------------------------------------------------------
> It would make some sense to have something like:
>
>   u64 size = arm_smmu_strtab_max_sid()
>
>   /* Would require too much memory */
>   if (size > SZ_512M)
>      return -EINVAL;

Why not just check smmu->sid_bits?

For example,

if (smmu->sid_bits > 28)
     return -EINVAL;

The check can happen before the shift.

>
> Just to reject bad configuration rather than truncate the allocation
> and overflow STE array memory or something. Having drivers be robust
> to this kind of stuff is a confidential compute topic :\
>
> Jason


