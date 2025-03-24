Return-Path: <linux-kernel+bounces-573096-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34F72A6D302
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 03:22:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AFB177A64AE
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 02:21:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0954784D08;
	Mon, 24 Mar 2025 02:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="Fp8vded2"
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2053.outbound.protection.outlook.com [40.107.117.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87EC4EEB5
	for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 02:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.117.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742782954; cv=fail; b=JdEq4f2bjrBZfSBT8NwL68U3yBym2RBlxugMxScF7HMpkK3uNsqvoMIou2d6DkzLDWNcjXdgT7ImyXj4e5A/9x+6LDSfo9+yL4MsUnOdiY0UsI7V/GBZP5TBiwD50H1ThSxIE4eGdNjNgH5jB/NoERj0BdJ47xkhsonuw8CnS5Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742782954; c=relaxed/simple;
	bh=vVA0DISUxERzsv73aDDgngMTCC5tD0MUUmWKIthFAiY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=chMJL+pMWnA18dGfMzOUqe34xfq2DirAdRHBzYkRQgXkf5a37Oen0gtpvimeWqrHVJ2l6z95r50+zo4Pg/0r4akQ7h6znLLv73OozHNPUxyxJjQ/rXvnCRaRFIlxczLKhqQrrOhlHK22ZOQXdjxZbxm+J5tPI09S76pRAv+MKRA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=Fp8vded2; arc=fail smtp.client-ip=40.107.117.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T34Pw4yJ1CA/ybIXrBRELtxI/hXkTMWfrO3YddJnTyAUdi1h3ZNWFr7TJMiVrHztzNB1tm6toROgJw0WHzCHoJRR0S8H8ekpDAfRdmJ6kw3nS76qhSnQN35xYr3R4h72iRcJYwjm78lgjdivDXdD+xTt9EeJDks5iNjDVCv2w4BCqs9FLA8QRavyIVDG0xxpGP2/Lb3//7uP+6kPsV9SgjAelbBT6XgMmtxK+Ns8JDLYkZLVHe37j8w1/BM+lDr83BOt4Vb7sP2ajyjrEXKwJX+TKp9dRIDJjescAKi+RP6WQMIGNGNokKnsDDv3pB75A7RxV6/D9CLV6JrSgOVk2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vVA0DISUxERzsv73aDDgngMTCC5tD0MUUmWKIthFAiY=;
 b=qLpaMXK+CF8XafGjHUdp88VVUrEqMt+xjh0/lqESPYxKvzlK7zFrfTMTV4cULS/4P8WrQP72Wpc74+ClOJWtGIgqqCowzOG9SRl9wFmU5/DpINA5I1HssaSXBQdi31zPsvwIEqoO9dxFKGmpfSqiyGwOwsHm2tPUP8/WeTcOe+00pNw7xEQGAfjIVJ2DGe2TCYB3idOb9wDu2lnjHgbQPE+24xHr/govEw/+N1KV+H2GHDOX/MRVDlH9PyqrlIB0Q4SedSdatkBUDxjwOKGeXf1XYs3bzDHX+2ylKN0UM2xpSrdmd6p2M2FJ4yFMOs88BUzN795YiBSNeXXScXfaVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vVA0DISUxERzsv73aDDgngMTCC5tD0MUUmWKIthFAiY=;
 b=Fp8vded2Qi+qodDVtN/ibnNgmAyz97wXH34va3L+4Jl3XdhHEVmf/NbbUtF5sUg78LxD6N77htC3AG7iigJdMvGhx/adqsxF3Eq+xexmEypV2r6qKeogrWDi4vv0shv+8frx11QMLog9tiSXIIBw4xZif2KhqtnYzVyjmPqb0/dOJNennUEl6bqLEgj39w5Ts5tP19Y1LdrDLYQE5PA6gy52zLQ/0kW5C0l6RDEM6uFs13O+RxLkYQIRSkK6daTSTxNtPvjLj9NIpIdey7OOhNeAM7Buo0D4Fs5VIsiZV/hALpuy7cpCsecp9zbTJGQNY3KtiQ95e1Nw2ysB/TZnxw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from PUZPR06MB5676.apcprd06.prod.outlook.com (2603:1096:301:f8::10)
 by TYZPR06MB5733.apcprd06.prod.outlook.com (2603:1096:400:282::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.42; Mon, 24 Mar
 2025 02:22:28 +0000
Received: from PUZPR06MB5676.apcprd06.prod.outlook.com
 ([fe80::a00b:f422:ac44:636f]) by PUZPR06MB5676.apcprd06.prod.outlook.com
 ([fe80::a00b:f422:ac44:636f%3]) with mapi id 15.20.8534.040; Mon, 24 Mar 2025
 02:22:28 +0000
Message-ID: <4ea6e085-8c70-4e6c-a864-55c6c5fa8269@vivo.com>
Date: Mon, 24 Mar 2025 10:22:23 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/vmalloc: fix mischeck pfn valid in vmap_pfns
To: Christoph Hellwig <hch@lst.de>, Gao Xiang <hsiangkao@linux.alibaba.com>
Cc: akpm@linux-foundation.org, bingbu.cao@linux.intel.com,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 lorenzo.stoakes@oracle.com, opensource.kernel@vivo.com, rppt@kernel.org,
 ryan.roberts@arm.com, urezki@gmail.com, ziy@nvidia.com,
 vivek.kasireddy@intel.com
References: <20250317055304.GB26662@lst.de>
 <5a12454c-16a1-4400-a764-f49293d8dece@vivo.com>
 <20250318064805.GA16121@lst.de>
 <5229b24f-1984-4225-ae03-8b952de56e3b@vivo.com>
 <20250318083330.GB18902@lst.de>
 <bcbbc2e9-858f-46ed-909e-1d911dd614f0@vivo.com>
 <20250318084453.GB19274@lst.de>
 <64a43d16-606c-4255-8a8b-96d6e4e44729@linux.alibaba.com>
 <20250320053147.GB12560@lst.de>
From: Huan Yang <link@vivo.com>
In-Reply-To: <20250320053147.GB12560@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TY4P286CA0001.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:26d::9) To PUZPR06MB5676.apcprd06.prod.outlook.com
 (2603:1096:301:f8::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PUZPR06MB5676:EE_|TYZPR06MB5733:EE_
X-MS-Office365-Filtering-Correlation-Id: f2015c08-b580-422b-8a16-08dd6a7ab90d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|52116014|7416014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UFJiRVdXZ2g5SHlxWTlRdjNOdm1meGhFbVMzRFNvKzBtOE5kK3lmaldoS3pj?=
 =?utf-8?B?M1AwREdoUkVWcGluM2JGVDZEWlgrc2wwOTl4dCtlV1IzeDJKNjFTSkFKVUhE?=
 =?utf-8?B?TktnVG1YK2RtSUN4RFQ3d0ZvemNwWUtCRGhla0NTZS9uTWpvWlBsN1pINTdV?=
 =?utf-8?B?VEF3YmJZK1V1SXR6TXFFVUZkMW5mMlo1cCtsSytyR0pzK1h0djhZVHJSaXBB?=
 =?utf-8?B?eEZQcTY4c3pZcWhuQW1ET2VMNXdkbUhqOUJCakl1MTlCbkhFWG03QlZNVWJl?=
 =?utf-8?B?RWNuWkIxY0JnVU9jWndaQXRQb0hEMkJOUWZDQmVIa0F6d0N4RjFTYUtQSm5q?=
 =?utf-8?B?UHh4dGVEejJtREtXL2Mzb3hxeWxoZkdmYjc3cVdyK0RJWExzNXJ6WHhrNG5v?=
 =?utf-8?B?Wm5uNTNPVXV1TndhVzFTY0d6NzMxK1hSSHhoQXB2Y3Nackl0TkljYU1DeERY?=
 =?utf-8?B?TDV0ajJWRDRVTVIwWWFHcjZjSmFZa0hOak4vNndxSktJaHpPM1NTWEY1ZFJn?=
 =?utf-8?B?TThMMkFFUmJUNVhXNjA2SW1MRkM2VWl0WnRKOTdZbmxTdjFPTWkyWGttdjZV?=
 =?utf-8?B?NEFDcWtIdjRkQXFLaHh5Mytyc3hJd3hmZVdXSGNQYUExRXRON3ViNEY3ZDFE?=
 =?utf-8?B?Z1BFSE5TaU1iMXNJT2hoZ0YwSHJYaUh6dk5JUEprMEs3YjkyQ3dieWhzeUdT?=
 =?utf-8?B?bjViZHZMUVZjckR3cnRKdXNZNENkVkxWaWtUbDBQNkZyVDl0RWhKMU1XZ3RK?=
 =?utf-8?B?NlVvUjczTWY3S1dOQ3ZSb1BxQVovVVVDYjZ6Qm9GOEhsV0tjSHhkbU9kYXRS?=
 =?utf-8?B?dnhhbjNuS2hRZWxjUTVvb2dIanZXNTgxQjhKY3VKUUxDVDRNQWRlRVFmRFNP?=
 =?utf-8?B?Qm85cFQzV00zczFIdnJJMUplazF6MUhpa1dXRnJxa3FJVkdjNUtseHcyakJZ?=
 =?utf-8?B?NGdxTmJJTUtFY2lUMWNxM2ZPS2xaWm5mZzRKalE3UDAzVm9nM2szWnhXM2No?=
 =?utf-8?B?ajVzS1dsUHBFWWZ1ZzhYM0xvcFhBQ29tcS9qSVpaQTJUS1ozTE42TW5FYzB4?=
 =?utf-8?B?VHV5bnNXYkxONGR1Mlh2aGxLa1BWcTQ5aG9VRzJYTWNuSDdCVlNHZDl0dHor?=
 =?utf-8?B?aGhBWjRISmptOEk2bzk4QlN3bW1UamdGc0tYb3NXYkNiYUFYTE9rWjZQdzNH?=
 =?utf-8?B?dnVYdXFwZzUrU3k2eGxPUzIzaHY2b3M2S1V6akFyUmV6eHQ4NmM0ZDRKQXJH?=
 =?utf-8?B?Rk1FanZQSkRWNWV2cGdnYklIbmpBYlhKajdub20vVWVWMWNnVytWVFJaSUxi?=
 =?utf-8?B?UXRmbmRtb1lxRnZPYUs1NUt5Ry9Oa1FxSkJHNnlzaWxmVWI0clNEMlRGRnpD?=
 =?utf-8?B?REpwcHBNYURZT0M5VDVqT09rSzFnd25kcUtlUE9NcXFpWXNoNDdic1F4NVAw?=
 =?utf-8?B?MTVneDZqWkx0NDBhWVVtL0ZPZDJHV3ZnSnFjejlFL2dQZnFnV0dmcGdqQ0Qz?=
 =?utf-8?B?Q3hCWEQrVVkrbzQxWjlHQXh4T0tlTVc5d3VjV1JVdEV2K2dpQmVpVWdUWTlT?=
 =?utf-8?B?TTNaQ0NIc01hQldEU0FSM3lpbjdlcEZFRUVBdndUd05lR1dIUTJJMFNJKzZF?=
 =?utf-8?B?TzFha0M3MnlSODcxS2JqVHhhMVdmMFQyVkE1S2U4NlZxcEQvYXAyZ3VTY0dE?=
 =?utf-8?B?SWRib0NIMHdncmYxUlR4M3VIRTVFcUFNNzFzbXM3dlFaNmlZbHQ1YStyYU9x?=
 =?utf-8?B?OS9odkdaYkhYY3NWRmhHK3FMVHF2NHp5WEFMR0pvWkVCNk52eEF4RTl5SXdO?=
 =?utf-8?B?dFNvQ1I1STA0WGxnVzREZ3FOOVZkNUhodXdjbHNINytZQ1kzb2Y2elRLYXRH?=
 =?utf-8?Q?yrDfkS8GrJQtY?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR06MB5676.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(52116014)(7416014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZGZjOHFOcDU1eDZtbjNVaEc3NUJLSFQ5bGRMQVdJRldHdFd0WjluSTNlSUsx?=
 =?utf-8?B?c0thNS9EOUJ2TTZGc2FUTVJoRkpyK1lheGNYZFlhdlBLM2hrTnNuS1ZDdExs?=
 =?utf-8?B?U3NBYjAyZFI5SUEzNlhmbFpWSDBUUHd6ZzJXMmhvMmVUSVFMdngwcVErWlJx?=
 =?utf-8?B?UWRmYWtjMk5sNldsUE5tQkZ1N2hwQ0RJcStQWjlxR2t6alU2TWhFRTdhWTVB?=
 =?utf-8?B?QUFtSkx6WVBKSFFuSWMvNDhBRDFxQjljWHRVQjljQlBYRmQwbXJlcURPT2NX?=
 =?utf-8?B?RURkeFA2eU9oMFNFR2IyUDZiQ3BUVnhWcDJxbytMMFRNdHZoRmFQN05DT0hP?=
 =?utf-8?B?cW5BSldsYXV3RmxzUHFXQmVHUXdZMkFKcDd4QkNvTFFkVjQvRXMzcGRSNEFJ?=
 =?utf-8?B?Q29BbWxHNVcvRjFkN2Z4VE1MYnFqOXhicU1SQ0swc1dLa2JSQ2JnVmYxSnRq?=
 =?utf-8?B?UW5FeEJBNTMvRDB1Z0tmVVE0Y1pPek56K0UvMDNheGVPRHVHZGd2RVBXdWE1?=
 =?utf-8?B?S2t3WEJ3NlZnU0ZOS05FYnNyQTI2MTdLRWFCNS95bnArbVVmaEh0STZZVEV5?=
 =?utf-8?B?Y3VidWZaak03bS85UDVsSlBIWnprUjFmdVRJREdmdFkvT3JEeXRvcnhoUFo1?=
 =?utf-8?B?M3JpZXpjVmw0RitRcENpaVlNR2lxRkZTYXNkZmdSUldlYU4rM0xrWG8ydXJy?=
 =?utf-8?B?WFNhSVA1VHdPZlBxbkhHNkdFeEt2NW1ucjN4NmxHMmdKeUhUYjVWV2Zmb1Vx?=
 =?utf-8?B?OHhRUThCeDIveWRUdHJsaVFBSlR1MkNOcGp0SEpaSXhpbFp6UHptTThLYkxW?=
 =?utf-8?B?NmJseVViTjdHNjdJUkRpb2Vqci81KzZySmdjMnR0SzBuLzRvMGs5cXVpdlY0?=
 =?utf-8?B?dE5Dcjg2V09YdlVOcjFwaTdWRi9MUjg0YmU5WlRqQ24vSXlDL0hTcFFWMlow?=
 =?utf-8?B?dDNLN3MvRk92K0E3K1JJRUx6bnVPY2pDWnhwTlBESW1LUk0xdUtjMjFtWC9Q?=
 =?utf-8?B?dWtRK1FPVENHbXErUUV0VDBBSU5Wa1dmR001dGJoblNPU0F4dUFpcE9IZlV4?=
 =?utf-8?B?ZTQwWUtCdmN1ZXF5K3djcGNjWWx1RDB2WHg3aDE2TGZhK1hxQk1NVDMyQXpq?=
 =?utf-8?B?aWRoZzlCbXpwblJSL1JjcmMzNG82Z0p5cnBKcUZQcU5aeEkwNVppSm9xR2N1?=
 =?utf-8?B?THRKVjA5LzBRWGRtTEM5bXZMQVdyU2Yxd1UrYjVmZ09zWVZTK2ovUjZRdTFz?=
 =?utf-8?B?ZTRBcVRjMVhzMXhScE5mRzBpcis5L00yNGg3S1h6aWhuTGNDeitRSlBDUVF4?=
 =?utf-8?B?Ky82LzFIdXErZUhVK0lKSEU2U2FTY2pRSnJlcjBlb0c3SVJlUTZOMHJVNUFP?=
 =?utf-8?B?dWRuYkNpMmRLVkh0VEkzRkpiN2dUbGNLVXIrdDQyN0t5Z3lHRm9sU2xXdDJ2?=
 =?utf-8?B?eWlENFJQZytwQ09pYnJoemw1NENyZUVhWi9qSGRaTk50VFRRbnl0Nk1YQ3lj?=
 =?utf-8?B?enFOOFhPbCtGcStObWlxYmNhMGNHOFk5RVZzUDNQMHhIR0FRaVU0TkpQekUw?=
 =?utf-8?B?UVNXQ2h5eGRRZExUUTZSQk10YmJSWFcyODQxeThjZFdxWjhubnMyL2xKMitB?=
 =?utf-8?B?bHNkWVpwQnFRTUpJaGtEeTFWcGE2UUJINmMrdFpXWDhRTlQ3ZVN0NGJHbW90?=
 =?utf-8?B?RkpSVTFWalZVWHJtQWRWZnV1YXQ0QzJOQVB1dGRqNUt1ZnEwSEdzQmgzTGxY?=
 =?utf-8?B?OU5TRmZRSDFXeVRtM2swMDFUSng2N0hSK1Q0QVpYY0hVbnQ1elVTL0JLQ0Ni?=
 =?utf-8?B?SGkzYXFjcHpTV2lIRnl1OE1kN2RWaGZMMUJ3U0VtSVVDdm9zNzM1QXFsM0cz?=
 =?utf-8?B?WGcrWGNlYSt1WEdUdnhQdjlqYmR3TndyaDBzY2FJbDVQUndic2M2YkI0cGpE?=
 =?utf-8?B?WVo1Tllxcng3VzdIdHlwZ1pWS1pkKzJTOCtRQlJUbENWQmRqbXltZEY5U3hw?=
 =?utf-8?B?NFZoazFvNlNPSndMUWNoMVJyd1FpUVNOZUNLUnhBREg2UlhNMm9WOEswV1NO?=
 =?utf-8?B?WlBjMnNVN1dEcER0V2lwTjFPWVpPa2pqM2ViTlppMTJCVHVxdUNZeW0yaUFz?=
 =?utf-8?Q?SqZ8opOpExjD33fH4FcbXFfDH?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f2015c08-b580-422b-8a16-08dd6a7ab90d
X-MS-Exchange-CrossTenant-AuthSource: PUZPR06MB5676.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2025 02:22:28.1381
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nky3cFbBnHO6ALIiOQoN6eJOTL999StarY/+SmGmxr/wJKew0S0l1/loDLrOkGjoMvJu49m5jNk4u/0ES14lKA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB5733

HI Christoph

Sorry for the later reply.

在 2025/3/20 13:31, Christoph Hellwig 写道:
> As mentioned before udmabuf also has a grave bug in the dma mapping
> part, so just marking it broken would be another very sensible

Could you please provide a more detailed description of this?

I'm not the maintainer, but I see the udmabuf's begin patch mentioned as:

A driver to let userspace turn memfd regions into dma-bufs.

Use case:  Allows qemu create dmabufs for the vga framebuffer or
virtio-gpu ressources.  Then they can be passed around to display
those guest things on the host.  To spice client for classic full
framebuffer display, and hopefully some day to wayland server for
seamless guest window display.

https://patchwork.freedesktop.org/patch/246100/

Did it also mean to do it?

I'd like to learn your thinking

Thank you,

Huan Yang

> option.

