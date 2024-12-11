Return-Path: <linux-kernel+bounces-441810-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2ED369ED452
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 19:02:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 376E5280E5D
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 18:02:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDDF71FF1B9;
	Wed, 11 Dec 2024 18:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="GFS2GDz5"
Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11021093.outbound.protection.outlook.com [52.101.57.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD46D246344;
	Wed, 11 Dec 2024 18:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.93
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733940111; cv=fail; b=TJwtSnELfK/LGunrwE05/i38urnYhM4puCvBWSMF+xKnlG8D7HBm8qOMwUtcg8FGYGA5/cvvJzCcL+xvjhMCAUyPwX23FnUAth5qHQM1FXSx2FlN4RcYG6fjbrtQlWGkQUSagshcmp3PYcBZGWRCJiN2Qm4MvwSlhAyQBgaNaXA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733940111; c=relaxed/simple;
	bh=NePhZTK5SxE23RI1XApCsmeMfVubdKwHrk3SmI78mb4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=AjaJDuA3MMWtxrwj3JNpQoVODGr6trZK1JOziqUiwz4l7qiHx8HALvH7k3yhwRRXHMgVfCgG6O5n/VpBJW0O0cdzqLOh4vSAVUUerPOBIQlbwikNJgu5vH/figJ4yZJT8RRFsR5USg+F0jyFe2VmuK3vUoIJzXkrHEIiZCljxu8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=GFS2GDz5; arc=fail smtp.client-ip=52.101.57.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mF291+OIt14/JcwhCV0MM5niG/692zFY9GRCy0xujB9Ey6APOrFuNBnVlV1n2RUskwVaF4aKIX1DY7BX7wfTX8dFhb0RVz+atvx4/K3DGvEHO8n4dYtm1arUbHisl88ToSnFeZQLYr2YR2e2IIzHHhHWxOtns5h+I4/ZZyqF4fOkN2kmeuOTZhmfK+Hrdz2n9e2vKK/txjrOgcdfUqTDoNtId9XKF055PbT3b3C96PnZbc8Y1ILEz2fgTJxaRo96l+dfMZKhPc8/xdTY94g9LSPwz4QieOdC/Oy0M++RS46iftdI1+dCqJrF08O6CUia/1mESGIzXX5Wpi39UMGILw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NDC1AMSMl7Kbn/Bds8swgMMX3BmzyjXNzphofVPSfX8=;
 b=xcLJq5UgCFBgQ0qMiXoSDu+blO1agD7BzCRUAj0RENpfNtbb7XvWB+hSeR8I9qyLqYf6YZAI5RWvMRD/VMgIdhAJtvD9LqWH15Wq3Cb1WOhpFn57/8JOkgbhCx6WSfZtcrldKTuTaXuZo5QKnt8KoUM8WOIuVR6yZcYra2I/+tD7FscLkQB3fMhtfosgXLOlH3oEzQ+J/l1FnUpDiwRevSiuXm4wzEvzTu8hDqR+Ds4wwaqM5yYvmx7T71JZ1JTGPkk+rv+gHc9yyFMJnwtafkziZe8SUu3nhY3N4S5E3vkiAzRowwbf4Qf+EH5oAfpGX6uR9DDoF/7BeJr1XPVsPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NDC1AMSMl7Kbn/Bds8swgMMX3BmzyjXNzphofVPSfX8=;
 b=GFS2GDz5V4oHHt3CflfRT3ylIMaWIe87xU/caB331PQqFWd6HnhI3TKbXx6Jen99yEQoq+BUQ51q6CZzaMfq4d/UpZ5ajPYx/hyiLOdM66nsRw0l6rF6ZqcSKKFlWbBHRfx0ENF3tcAgHVsU+seFHYN/+dxTTf52MMdRpLzIv5k=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from PH7PR01MB8146.prod.exchangelabs.com (2603:10b6:510:2bd::18) by
 CO1PR01MB8962.prod.exchangelabs.com (2603:10b6:303:276::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8251.16; Wed, 11 Dec 2024 18:01:46 +0000
Received: from PH7PR01MB8146.prod.exchangelabs.com
 ([fe80::2972:642:93d1:e9d4]) by PH7PR01MB8146.prod.exchangelabs.com
 ([fe80::2972:642:93d1:e9d4%5]) with mapi id 15.20.8251.008; Wed, 11 Dec 2024
 18:01:45 +0000
Message-ID: <9e53f5b9-d8a9-46b8-8ff1-7f018e2d9c06@os.amperecomputing.com>
Date: Wed, 11 Dec 2024 10:01:41 -0800
User-Agent: Mozilla Thunderbird
Reply-To: scclevenger@os.amperecomputing.com
Subject: Re: [PATCH] coresight: docs: Remove target sink from examples
To: James Clark <james.clark@linaro.org>, coresight@lists.linaro.org
Cc: yeoreum.yun@arm.com, Mike Leach <mike.leach@linaro.org>,
 Jonathan Corbet <corbet@lwn.net>, Leo Yan <leo.yan@linux.dev>,
 Namhyung Kim <namhyung@kernel.org>, linux-arm-kernel@lists.infradead.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20241210144933.295798-1-james.clark@linaro.org>
Content-Language: en-US
From: Steve Clevenger <scclevenger@os.amperecomputing.com>
Organization: Ampere Computing
In-Reply-To: <20241210144933.295798-1-james.clark@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ2PR07CA0017.namprd07.prod.outlook.com
 (2603:10b6:a03:505::17) To PH7PR01MB8146.prod.exchangelabs.com
 (2603:10b6:510:2bd::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR01MB8146:EE_|CO1PR01MB8962:EE_
X-MS-Office365-Filtering-Correlation-Id: a0a3cc23-d7a5-44b7-1639-08dd1a0de011
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZFdhblY5OFNBbWJqV2t6NjFDSHhyQmVnVGkvc2J1VGFOc1NJTHlGRGYvU1ZS?=
 =?utf-8?B?WDM4STVzUHl1TlgzbTJ0c3BOVHUyTXI1WWd1Z1JQeHQ3THlXdStvQlErTFpV?=
 =?utf-8?B?MnQwYzBKNmtTWW1BWVlEWXRDcTN6dHdlVkRxUHl5TDRCQ04zaHhjWHMvV1NX?=
 =?utf-8?B?SHJsYzNPeUxWOFVoSGk5eUs0SUNGM0FTcEtBRjc2cnpPakFtSWVyZEpMUlZk?=
 =?utf-8?B?Z3l6MDZuUDg1ZjRaU2dkTWduU2RjRjRtTG9mcG9SWHBNQ3FVUFhSYXZNSkdy?=
 =?utf-8?B?ZU1hSms2eUUycXZiQUw2NVBZcVNMQWNaQ21qV2FqQ3VKM056d3BJamNtZ05s?=
 =?utf-8?B?MHkxTVlSYjh0WUhDR21PbjVJU05Jc3BnakltWDBFdENwMTRscEl0aTArOUlS?=
 =?utf-8?B?QlIvamhKUDBsM21rVUJoUUFyeTlnZ1IxL0N4WEhQbUVoODcwc054TzQ4ZCta?=
 =?utf-8?B?SGdVZVNBWm5FcmcxSkZ3OWxxSWk1R1hIL0w3UHY2Yzl5NGg5Y1U0djViOVZn?=
 =?utf-8?B?OHhXTmxDSFNrRUFPaXNkZnZPZ0FWY29nUGw4Yy94bFIxTUpKNHB5eEttQnFH?=
 =?utf-8?B?ZDA1N0RtS1I2K0plMFAwQTN4T0kwZThROVVCeEE4Zm5mTkRDdS9EVVFxblVk?=
 =?utf-8?B?MzhxNmtKVHA4TXQ5NXpEejlKUnNEL2FxeXZFME9sYnlCUlF2dFZwNG9pUUg5?=
 =?utf-8?B?L21VMEpNaGhoUks5ck1IUGVZdGRRUTFyQlVCT1czb2EwcGc2NHVjT1hyaVB6?=
 =?utf-8?B?bnFhR040ejlXdzM4Q0RaWnd2Q21GSVpxMjYyMWFsN0dJcEtjMlJqZll2cFZr?=
 =?utf-8?B?NDE0TUJSS1J1MjJ3RlliTFdnRFl5VS8vRFRsOHhqbUNLbXc4QUZNWTZGSEM0?=
 =?utf-8?B?OUpwL2RNbllVZ1cvNWo5ZjZwY1FNSXZxMFluYnJPd2prcFAwMFBJYmVrTWdo?=
 =?utf-8?B?NnRUdkxjUmhHN1lWdnIzQjBlQ3BsK2dWK3FtMUlPK0VhUzUzT0pLVXR1UEVV?=
 =?utf-8?B?aERHTzVwOVFwY2dmV3RtS1pVaDNCYVM1MXZ2d0pkMHVGeGdHeU9ZZWRTcmtU?=
 =?utf-8?B?UHg4L0cwTE1QVjNHY0ZrYi9VSjZPdzNnSXBzTVZncWZ2a3dhZXVQUTc5UTgy?=
 =?utf-8?B?YnphbGJaNXBCYWxPQnRHdkN5bkY0aVppdW5waEJmRTRHZnA4N1VkczgzUzhJ?=
 =?utf-8?B?aVRUQnZLcGhnd1ErR1ZETGpETmpJSWtpZHRkdHRsRXJrUis3SS9EYWNrZXli?=
 =?utf-8?B?YVF5UlQ3bnpCOUxQOE0rMmVCY3JKcjdEeHZoQVdrWm1WbEd3eFNzbUFWSVp0?=
 =?utf-8?B?V3RRTllNOHcwS08rVHpsd1hibW96aHViT1l4VHlHSWJxSC9ZTURBSXBGSUJp?=
 =?utf-8?B?enlDRDFsRG1MUlBKUDNseE9IK0FVS3FNdEFKQ0Vya2VZbXRvMk9nYnZpNmJl?=
 =?utf-8?B?aW9rQVBRUWhuNEdFUnA1QXVtRzBlUFpzZlFDZWZaYUNPMFQ4M1F5L3FxNDUy?=
 =?utf-8?B?VU53OE9BTndpQ0NZNHdHNkNmYXVQWkVMdktyYnBuN3kwbGcvYk1ZQ3dXWTg0?=
 =?utf-8?B?bGR6TTY2bWRFWHpzT04zbmYxZlZnSDkrcmFyZ1UraHZXQjR1bzJtcmlwMkpR?=
 =?utf-8?B?NFh5ckhHcUdFQTFVRlRQZWlyN1IwblBmV2svSTFpQ0UvRnRsWjhvdEJGTnIy?=
 =?utf-8?B?bVp2SHY1VXF4WElhakVlbE90NlRWajQ0aUx3NGhTam1CRFBVRTNpVi8wSStk?=
 =?utf-8?B?TnBuTEh6R0VNamkyRTJsU24vREdobEF2bHdNU1BEVG1YMncvK0pVcmoveER1?=
 =?utf-8?Q?z+CGZ8dDr2wFrD5TK7ETf26JFKJOdeNV8qIZ0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR01MB8146.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?LzVRbjRwOVNXb1lnaGphOGpqUVRKY0E0MnltM0U4Y0szRVdWQVMxa2dQdFJt?=
 =?utf-8?B?SSs4dFZVMTBvYm10b0hlVVhHUjBlWHJJWHBTOW05dW95OE5yekFKYU5rT1Ry?=
 =?utf-8?B?QkFXWGp5WklxZThvckJUUjJmZFd2Y1NZVmZlNlNoeitXWUgrY0lSa0RUN0tY?=
 =?utf-8?B?amVqT2U0NXNCLzYrRU5Demo0MUljd2JSWDZrbUhrVmhyOFFVTnFqVFdQeFlB?=
 =?utf-8?B?ZUVnQWNvZndSSDBwWkl6Q25iN1hwaUhKRWplZmdzTTcwaHhCenhuSHlPNnJm?=
 =?utf-8?B?R2hreVN2MThrNTFZYVgwVFIyd0ZMd05Rb2I2Y3EvbHlFZFJOZnE2VWdVUEdz?=
 =?utf-8?B?bCtYRVdNZUlpZGZia1k0TC9hM1IxMlJjVEdPS2hreEhnekxCVE5IVERKZnor?=
 =?utf-8?B?RGtLL2FZek9seTRPUEUzL3hiWDhaLzUycXV3RWVGZEhZRXNZZkgyMkhzZ1Iz?=
 =?utf-8?B?QlNFRFptV2VRY3dlc0pCS2x1bEpscjhoaERZMk9nQ1c1Ymc0a3llaFFhZkRu?=
 =?utf-8?B?cEFYSnFQblJGUXJHMVl2WHZaSnhFaXExdXVjZGdGbUJxSzBJRld5MEU0bW5M?=
 =?utf-8?B?MkVSay9UQ2cydm5GY1NUVFozeVhnbWozSzdyOFJ5d0k3azUveDdsYk11MUd0?=
 =?utf-8?B?aGRKeklrMU9BblJmWDBzT2ZqcWtmeUFGc0tEMVM2V0M0bXRVd2VodlZIcEdR?=
 =?utf-8?B?cHF0eUFyRTRzcG9uWXFjYXZzVE5heC9RZnVsNmJ6M3g0UjgyM013TVhXZlBK?=
 =?utf-8?B?NHZrSlo5bHkrWFVhRzJmUlpBbWhVcExtTDVNLzZ2TE5DdlJzU1FRZjFHbUJI?=
 =?utf-8?B?UkR5VXJoK280N1NvdU51K1dMZlU1S0M1NTlZT3A4SHRTOXpyenZkYUp3T2tn?=
 =?utf-8?B?dFppTS9aKzBkZXB3cEVxQUVIUHhuOGpzU1MzTXZleUNyQTB1aWU4ckppSTgv?=
 =?utf-8?B?Y0hiaFdnV00yS3RvTUhnaHdMZXgramt1VkdESU5LVE5GUkRDWUJyRXZ3cG9z?=
 =?utf-8?B?TnBMU3l4azlwWDRHMG1KaDFJSHdBbmVvMFhLNUVZU1hGc0FVelZjemdnWStT?=
 =?utf-8?B?TjBYUnBLWk5JZloyUFZHa1dnb3I5STJXOGk1N2dvTHRkZHpnanNwUm95YXFa?=
 =?utf-8?B?dDJYd0xxbEtEVmF1ZWMyRVlYdnFxQUh6MDlSZWFnTmk4QXhObkVuQ3g4Zm1j?=
 =?utf-8?B?bUFBam5MOVlFWFU1VS82UG1uSGZ4V20rbXU2cWxOZXFzMmVtVFdFNUFWbXox?=
 =?utf-8?B?cTdPU2ZSSTZzU0lyVGs4d1VYYnM2SU91cCttNVFnVHNpYlhmZjJwVGxNQ2cw?=
 =?utf-8?B?aEkrSk45QWF5ZmY1T2l3K1QzMUc2U2FhNEVTeGU3UTdJR3pWVUpCckRLeUpw?=
 =?utf-8?B?aTFWM2g0dzdLMVp0WEJGbHA4Y1BmajYrM2UvQlpoYXYrdVRNZnJYQ3RKRmRQ?=
 =?utf-8?B?ZkNrdXV5OXlmaVppWC9TYnNuY0VSbXB3WmZ4V0xkMFNDV0hHUlpXTFRMUTcx?=
 =?utf-8?B?QU5XODIySXlJRXM0cVRPSDkyZC9rQjBkTXRPZ0wyOVNhWkQ3MWdsR2hsNnE4?=
 =?utf-8?B?MEFXQzFZVlFCTGRMS0V6dDBqcFpNbHp3ZkVrOE9zZ09OVWc0eFF1Nk5kTlpE?=
 =?utf-8?B?RTFkT1FEU09LUjAzb2xJV0Foclp4RkRYV2hrMW43V0d0RzlRM24zSE9SVU94?=
 =?utf-8?B?bHNQMXdmUERXTGtNRjNta0R2WUw5WTF2TzN4ZkxTV2tQMGxOUGxYeDJIemRC?=
 =?utf-8?B?QThaWFFCdEJOcU5NdmFUWWlFL3h4MmR0TStrMkN5V0w4WlFaSjNlVFNDUmNu?=
 =?utf-8?B?R25XczR0dmdwcW05d1RsMVA2Yi82SUFXdWExVGtLTm1vRFdubkJVdmxSWVZk?=
 =?utf-8?B?UHNpa0tqMk5na3R4YjFlYzFKVHk2a29FZ3M0VkxKNTRGbnY1dlI2aGhWQjVP?=
 =?utf-8?B?WEY4Qy9LUGpzb1NqMmQ1cyszZnNKQitJaFJFUHAzSTIwUVVBcFQ2Wm9nNStI?=
 =?utf-8?B?ZnRGbEtCQUZmM3M2RzJlNkxpWUFudTM4b28vTElpVm5IeXVlMW5VbGJVeWJM?=
 =?utf-8?B?UzZzTmJSSUllRVQ5MXJJcktFU0JWNW5oK2lLZXlxWXp4ak11TXBlUUZTSHJS?=
 =?utf-8?B?emw5ODRFWTg1VFJkNlBIcUV0bnI5dU5TR091YUlGbnJkQUpzUkVVTmVYbzc1?=
 =?utf-8?Q?FesuZfJjGOS4ZD+7K3J32Ck=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a0a3cc23-d7a5-44b7-1639-08dd1a0de011
X-MS-Exchange-CrossTenant-AuthSource: PH7PR01MB8146.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2024 18:01:45.7282
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cZECKRkKA3G1v/32OX/Z4ZUPBx3eu+OgWVbNCPpoGEhvgkv2T8FSu401I+B7o921sOX2WQecVS+LcUQrFCGh5hoK3nw2ngDBoTqn3g6Dii8cReD7VqadorN810JS5oie
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR01MB8962


Hi James,

I thought I'd mention this issue with multicore self-hosted trace. The
perf command line syntax does not allow a sink "type" to be specified
(e.g. @tmc_etf or @tmc_etr). For multicore, it doesn't make sense to
specify a processor mapped sink as would be the case for single core
trace. A sink "type" should be allowed to avoid the auto select default.
In our case, the default is the ETF sink.

Thanks,
Steve C.

On 12/10/2024 6:49 AM, James Clark wrote:
> Previously the sink had to be specified, but now it auto selects one by
> default. Including a sink in the examples causes issues when copy
> pasting the command because it might not work if that sink isn't
> present. Remove the sink from all the basic examples and create a new
> section specifically about overriding the default one.
> 
> Make the text a but more concise now that it's in the advanced section,
> and similarly for removing the old kernel advice.
> 
> Signed-off-by: James Clark <james.clark@linaro.org>
> ---
>  Documentation/trace/coresight/coresight.rst   | 41 ++++++++-----------
>  .../userspace-api/perf_ring_buffer.rst        |  4 +-
>  2 files changed, 18 insertions(+), 27 deletions(-)
> 
> diff --git a/Documentation/trace/coresight/coresight.rst b/Documentation/trace/coresight/coresight.rst
> index d4f93d6a2d63..806699871b80 100644
> --- a/Documentation/trace/coresight/coresight.rst
> +++ b/Documentation/trace/coresight/coresight.rst
> @@ -462,44 +462,35 @@ queried by the perf command line tool:
>  
>  		cs_etm//                                    [Kernel PMU event]
>  
> -	linaro@linaro-nano:~$
> -
>  Regardless of the number of tracers available in a system (usually equal to the
>  amount of processor cores), the "cs_etm" PMU will be listed only once.
>  
>  A Coresight PMU works the same way as any other PMU, i.e the name of the PMU is
> -listed along with configuration options within forward slashes '/'.  Since a
> -Coresight system will typically have more than one sink, the name of the sink to
> -work with needs to be specified as an event option.
> -On newer kernels the available sinks are listed in sysFS under
> +provided along with configuration options within forward slashes '/' (see
> +`Config option formats`_).
> +
> +Advanced Perf framework usage
> +-----------------------------
> +
> +Sink selection
> +~~~~~~~~~~~~~~
> +
> +An appropriate sink will be selected automatically for use with Perf, but since
> +there will typically be more than one sink, the name of the sink to use may be
> +specified as a special config option prefixed with '@'.
> +
> +The available sinks are listed in sysFS under
>  ($SYSFS)/bus/event_source/devices/cs_etm/sinks/::
>  
>  	root@localhost:/sys/bus/event_source/devices/cs_etm/sinks# ls
>  	tmc_etf0  tmc_etr0  tpiu0
>  
> -On older kernels, this may need to be found from the list of coresight devices,
> -available under ($SYSFS)/bus/coresight/devices/::
> -
> -	root:~# ls /sys/bus/coresight/devices/
> -	 etm0     etm1     etm2         etm3  etm4      etm5      funnel0
> -	 funnel1  funnel2  replicator0  stm0  tmc_etf0  tmc_etr0  tpiu0
>  	root@linaro-nano:~# perf record -e cs_etm/@tmc_etr0/u --per-thread program
>  
> -As mentioned above in section "Device Naming scheme", the names of the devices could
> -look different from what is used in the example above. One must use the device names
> -as it appears under the sysFS.
> -
> -The syntax within the forward slashes '/' is important.  The '@' character
> -tells the parser that a sink is about to be specified and that this is the sink
> -to use for the trace session.
> -
>  More information on the above and other example on how to use Coresight with
>  the perf tools can be found in the "HOWTO.md" file of the openCSD gitHub
>  repository [#third]_.
>  
> -Advanced perf framework usage
> ------------------------------
> -
>  AutoFDO analysis using the perf tools
>  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>  
> @@ -508,7 +499,7 @@ perf can be used to record and analyze trace of programs.
>  Execution can be recorded using 'perf record' with the cs_etm event,
>  specifying the name of the sink to record to, e.g::
>  
> -    perf record -e cs_etm/@tmc_etr0/u --per-thread
> +    perf record -e cs_etm//u --per-thread
>  
>  The 'perf report' and 'perf script' commands can be used to analyze execution,
>  synthesizing instruction and branch events from the instruction trace.
> @@ -572,7 +563,7 @@ sort example is from the AutoFDO tutorial (https://gcc.gnu.org/wiki/AutoFDO/Tuto
>  	Bubble sorting array of 30000 elements
>  	5910 ms
>  
> -	$ perf record -e cs_etm/@tmc_etr0/u --per-thread taskset -c 2 ./sort
> +	$ perf record -e cs_etm//u --per-thread taskset -c 2 ./sort
>  	Bubble sorting array of 30000 elements
>  	12543 ms
>  	[ perf record: Woken up 35 times to write data ]
> diff --git a/Documentation/userspace-api/perf_ring_buffer.rst b/Documentation/userspace-api/perf_ring_buffer.rst
> index bde9d8cbc106..dc71544532ce 100644
> --- a/Documentation/userspace-api/perf_ring_buffer.rst
> +++ b/Documentation/userspace-api/perf_ring_buffer.rst
> @@ -627,7 +627,7 @@ regular ring buffer.
>  AUX events and AUX trace data are two different things.  Let's see an
>  example::
>  
> -        perf record -a -e cycles -e cs_etm/@tmc_etr0/ -- sleep 2
> +        perf record -a -e cycles -e cs_etm// -- sleep 2
>  
>  The above command enables two events: one is the event *cycles* from PMU
>  and another is the AUX event *cs_etm* from Arm CoreSight, both are saved
> @@ -766,7 +766,7 @@ only record AUX trace data at a specific time point which users are
>  interested in.  E.g. below gives an example of how to take snapshots
>  with 1 second interval with Arm CoreSight::
>  
> -  perf record -e cs_etm/@tmc_etr0/u -S -a program &
> +  perf record -e cs_etm//u -S -a program &
>    PERFPID=$!
>    while true; do
>        kill -USR2 $PERFPID


