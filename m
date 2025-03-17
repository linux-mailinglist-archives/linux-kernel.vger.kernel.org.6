Return-Path: <linux-kernel+bounces-563455-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B7F5EA64230
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 07:54:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A50273A657F
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 06:54:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA283219A71;
	Mon, 17 Mar 2025 06:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ZtbRyOVe"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2064.outbound.protection.outlook.com [40.107.93.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A841F1E1E0F
	for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 06:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742194471; cv=fail; b=FdFGAJ2yRQDWj32HGl1Bi6lgzsTPLtWRpY/iK3amFKDgJ7cH4m+GmXRRxIr5FSfxFY0PX1EDwR7yENgQIXYVS3rVJ/QByBolz47TXrFGipXcipshIRl8TP3z7IX9qG4jkeNShXkDVRfCemZ7kkGvv900b3cWK5CgeGvJWO/IroI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742194471; c=relaxed/simple;
	bh=g+j4hwLu/RENKv1D/RNbutRhSBw3rtDGK84ODT7AGU0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=N9hNNttyljLBXf6qkJJZoh/SiysaTeBz66IjrKISKbCdZ3dXKUJvnSTlGPNSXe0d7UFS5Dnb0ov6iruTnK9nyJ7STljTYYAZtUutAlA5KTIeLgokTtgQfBLbTwbuQuDwG8jT6Z8moRKAkcu8hKhORX2TV0tGktK5JKS36tUPvIE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ZtbRyOVe; arc=fail smtp.client-ip=40.107.93.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n38bOM3SElGJB3JI8tXH9q7zJEcRAPd+mHlWeofRp4Envwezg2EnKfg5M/kKywOYcrMAaTvheS5DAXfjzuMcVK6D0fnYknEm0RU3YuwBkXrIuSFqZBww7xYuZMqysV2e8mc+azIecLx9is89a4FDrXr6sENYPaYM3omkvJyeE7VRF+o2BrkCqhhenFjhgUh8vYCIXGsu25MG2m0oDhBT13aS5fuS6yKPXLMOB7B5SL/sXLVHjEQdLiqNcM02xbYjIn7nI8ZkA5Fe8OjEtU88x0HNW4USXfz4JccZXanRAbx5otfby1S9SRlAd0Eu/CnSlcSseEkbooBT8lHf2yfkOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d7WQ9jLOG/9RhCwVjTKIpqwZBgDRwuQpZ7/vf9O3dXE=;
 b=ea/PcbpGsZQzsOVBSs/Q9i2FkY0IhaGxCErDA7+DJmhvSs2IqnFW+53Ia4927rUyO1OoS3Bupql2iDWyVWRfpIXiNqzQs14oCFk8hGUK8MdhkxKP3nkbYXV+vYY5pezVUOcRVHw0FRq+mCUY3CVCYGcQC/pOZp7XnUcy1RjvCqSzr4FOq1+Qr6MsuELapthV8UHkYKSIvJXF8Ke4SjgMpGU8nyLXzljXmdb+jy0+Wa8UoMgK6YgR33v4vF2vCXkBg5jrpijROalmdpqNIsN7ngyVRt2dd9dY4bQMRkw7iOsK6qZulavP9gK8bTKyzK6N3zsPwZZalRqQbO6DUqZkNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d7WQ9jLOG/9RhCwVjTKIpqwZBgDRwuQpZ7/vf9O3dXE=;
 b=ZtbRyOVemHm/3e/Dj5C4NTpo3WjnEymO1MfanpGmlbDRL34v/DOWAm8NWxs4hpTbZkXKgLX49opcBlnlgAXf1eWWfis+QCZbaavP5KjpjiZHRjohbx00Z3z28fxAsN+hV+k4ft3VFZlgF2/kFPAE+Z9XZ13u+9TqY1wE2aLX5sM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB6588.namprd12.prod.outlook.com (2603:10b6:510:210::10)
 by CH2PR12MB4167.namprd12.prod.outlook.com (2603:10b6:610:7a::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Mon, 17 Mar
 2025 06:54:26 +0000
Received: from PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::5e9c:4117:b5e0:cf39]) by PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::5e9c:4117:b5e0:cf39%6]) with mapi id 15.20.8534.031; Mon, 17 Mar 2025
 06:54:26 +0000
Message-ID: <6feb2e1a-4e90-4bbd-86bd-7157432770ed@amd.com>
Date: Mon, 17 Mar 2025 12:24:17 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/7] perf: Make perf_pmu_unregister() usable
To: Peter Zijlstra <peterz@infradead.org>, mingo@kernel.org
Cc: lucas.demarchi@intel.com, linux-kernel@vger.kernel.org, acme@kernel.org,
 namhyung@kernel.org, mark.rutland@arm.com,
 alexander.shishkin@linux.intel.com, jolsa@kernel.org, irogers@google.com,
 adrian.hunter@intel.com, kan.liang@linux.intel.com,
 Ravi Bangoria <ravi.bangoria@amd.com>
References: <20250307193305.486326750@infradead.org>
Content-Language: en-US
From: Ravi Bangoria <ravi.bangoria@amd.com>
In-Reply-To: <20250307193305.486326750@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0216.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:ea::14) To PH7PR12MB6588.namprd12.prod.outlook.com
 (2603:10b6:510:210::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB6588:EE_|CH2PR12MB4167:EE_
X-MS-Office365-Filtering-Correlation-Id: 3cda1c7a-5a6a-4e34-65c0-08dd65208e88
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OERQZjN6VTk5M3k5WThmVENpTjVtT2orWkt0Nm5wUFE5L1dHOGc0UnpER2t1?=
 =?utf-8?B?QkxGZnVhM2YrY2dOQTlwMnY2SnE0b1MvdTdjRUIwdkVvTTV5SzRTYWIzdWti?=
 =?utf-8?B?RTFzWU1rcU01Q1pGKzNJOStLc1pEWlRSRjRwWXBTYnpkd3hhYVM1VG9xbURj?=
 =?utf-8?B?NUFLVnRyanZFK3Y5K1NNR0t2bFVtamRyT0cvV0xNRjMwRFFWd3RrR09wL0Fj?=
 =?utf-8?B?c0U2YkNXQW8zdjlmU2NRVU14alM5V21wRjJwbDFQeWdFeVF5SUFLam5OdlQz?=
 =?utf-8?B?ZzFWM2dTL0pWYkU2M1dxWTQrSHZUY2FwbFFkd0c5RVlSaEI2Z0ZYOVhsWmgy?=
 =?utf-8?B?MjB0V0NFYTQ1TjJCQWZoY1FFWnNUK0Fpb01na08rM25WRU53WFZlUTNxUlNq?=
 =?utf-8?B?eGpMNHJpNloxNzVjNDZ3QTRpSlZGdmhUcFpqeEEzWmw2MnhNYUlVK2FzRktm?=
 =?utf-8?B?NS9kVXc4a3EvZkVEaWRoSUZHM1NMM203eWM5VGJONXRUUDNXNW9lUEFGdGYy?=
 =?utf-8?B?UXpKeVArSjBDakoyU3dKblp5dFRvcC91ZmRXR1g5ajYzam4vM0Fxb3Z4U0dX?=
 =?utf-8?B?NDhYTGlhQUM2ejFlRUJGZnpEWk1peHQ4L2l3dG5lTnFZQ3VaQmtYNm1MUDhC?=
 =?utf-8?B?eWx5d05pOTFXNUhlWHE2VVQ1N3lhVlJxMUNJbWlCQllrUFB3OHQ0NVlUQU9h?=
 =?utf-8?B?aUdNYnpNQjdxYzBFZVljc1hvRFZWWm5lb3lYUmJydUFEWnUwNlZQK1VUQVNx?=
 =?utf-8?B?cEhuWUN0WEdUV1NGRDVHc0MxTmN6V0Vuajd2QVRmSU9JWjh2Q0wySUJ6bjNz?=
 =?utf-8?B?dUNOdDBJTnJ6ZXYxelZ1Q055QXRETlUxS25oMStzbGN3R3MwOUdBenA4Yk1S?=
 =?utf-8?B?UnU5dmUwSmdEQnBDZ3BkSVl2aXBGNXBUZHlELzE5WGNuZklTNGRxM0MxcjVY?=
 =?utf-8?B?TTNVRU51M3pDdUxIUmI0WGxRTk9wZ1F6U1VvNHRMUHhFTWRmTTZOZ0hCVDQ2?=
 =?utf-8?B?bTlYR1VWd0Nmb1R4R2U4SmRKRGhBUDFTcVU0U2RScEhwbVpPVDZjZUNiUklz?=
 =?utf-8?B?MDVXN1B3SXVGWG1OUm83NnlRN3dkTTUzRzZFelJtSkZLdzUrOUZ5R0lCUlpJ?=
 =?utf-8?B?Z3gxUVpMeVhuZEpiMlZ1czBvZE9ja1AxYWtnQlc5M1ZDY3FVckd6WGZieDFY?=
 =?utf-8?B?a3p3b1d6NHNiVGJzWFNydmpqcndKbHQ3K0lTVEZ5dGdpR1lhbEdEMmg5ZDMy?=
 =?utf-8?B?ajQ3clhIOXpyVGFiQUFrZ0V2UkQ1cVBxd3lCMUxXWUMwUTZhNU4zQ2piR1BT?=
 =?utf-8?B?c1gvdnhXeDZiZFYzUDk2STBQd0VpOFBvQnVQZEVrc3RjbmhNOXVGNkk5RUZx?=
 =?utf-8?B?dzdxZmtCNmx0R1UybStIa000NVRnWDdlTkx2V0VESnArQXJxOFI0cDhDTktU?=
 =?utf-8?B?bmNjTnhGbHcvRzViZE9qMWFMUzVRY0JOcEI1OTExTGV2WnRmRlV0dUlrcEZH?=
 =?utf-8?B?MTRuYS9CdGNXVHNNUld0bjdCUGxlcVhUQ1NXYnk5dENhTGw0SnJaNVFDbHd6?=
 =?utf-8?B?cEgwbnZ2aVBHTkxCQm9wOXhVdTU4QnFMMW90ZTE1bEk1MngxK24zWG9DWkd6?=
 =?utf-8?B?VmtrVTUrVXZOVDdoaStidVNkRmh4ZVY2b2JjK1lDV0c5bmpyT3hnWGxqRnYz?=
 =?utf-8?B?b1Q5bE5scm1iTFNoMGx5R2JJZlJRcml5QWtTS3pPUVNURlEyOURFaUVBYVBG?=
 =?utf-8?B?S2dTbUNkU04rQzdPVWIxNGEvU3U1d1MrRitlblJTVHgzYjFncnZldEM5RUMx?=
 =?utf-8?B?ZmJVd2VpRzNOTnE2MEcxQW1sdlRubWZNbExrUEErVW9WYUlqa1NWQ0JCcmNK?=
 =?utf-8?Q?yb/x2eC5zv2/9?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB6588.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bW93dWNDQTlaOHFNY1p6MVl2eUM4ZHdLdTZqcjR2SFpRK0FDbGRDZGIybzJk?=
 =?utf-8?B?c2JFUEhLZ1JxUGZ5ci9jZmVLMlZmeldyb0g3RFZDc0NVS2tWamtWa1dzbW8z?=
 =?utf-8?B?a3YvVnVmTnowaGRiSEtrVmkyWEtUNW1UdjAxYmM2OE9yQUVES0pwZzlqQzJS?=
 =?utf-8?B?dWdpNTZNZjlHbm92Z2s1Tlp6cWZkc3lmVjI4Q0dIVVlEOFVSb0l0Z3FhODBP?=
 =?utf-8?B?d3BGUnZBaUNXLzBWTDVyV0xtU0tWMjNrOXBEM3RLdEMyUHIwQUdsS3E2TERl?=
 =?utf-8?B?b3lUNkFId3Viais5Y3VodWhjWXcyQkIrS3hrby9UbXFPZW1TSUxMblQyR2VK?=
 =?utf-8?B?cmdWME93cFVKL3AwTHhVbHFWbVFTUldtQWl0Nm1XcUZVRVJOSGxKZnZTdThS?=
 =?utf-8?B?ZEZLd1lVZ1JRcnpPRU02TVZMdTJhN05QamRqd0pHQVVtWDdya1lPckhHcUxS?=
 =?utf-8?B?WHVGSGUyWW9QWmIyTnlJM3poak9udWhyT09yT2daajZmazUvRFVJeUU3NWxY?=
 =?utf-8?B?cGxPOTh6STdCVC9JQjFXdXRNcnRlNXJKNXNEZHB4Y1FmVitMeHA1cUJOR0ZB?=
 =?utf-8?B?R2ZsbTNTV2dKejFMVkhuc1pTS0pIRFNGQzBYMGd6TzV4d0FTeHNMWi9DWkI5?=
 =?utf-8?B?UkJKZlR1NGwrNjRFTXhQZGpySFpDWHBJeUpTek5IYU5nQ1lQQ0tnWmh6K1FX?=
 =?utf-8?B?bFRzTS9ZUGZ4OXZqR1BDakNCRTQ1NXRqWkZnVkQrK1F0SmFycWN1c2l6bFNC?=
 =?utf-8?B?dDJHRkpia1lBSWp6c0hhYXh2YS9qVmx3ZWxydWVaUjl4WHNEZUxBdTRjWWVD?=
 =?utf-8?B?Q2kyZnZlOVB0RVlxV3hMV2liUVowMkpXMkczaDlOYWpQZVdGOHdNQzVvN2ZF?=
 =?utf-8?B?MDFnZFIreDk3bXZIOFRUUW9JVGZNWWRNTzVzdUZEVm55SFMrNnFmb0JFVUxN?=
 =?utf-8?B?V2JUYTJLWGxYbHNqTU5NOXVjN2dHTE8rMkJLdERYd2JmNnFiT21PTGQxejBI?=
 =?utf-8?B?TlZLNFdQLzJmaHUvb1RBSlJsQU5zQkNyZ3hSVTM0emxRQ29JYldaZHl4SkJ0?=
 =?utf-8?B?NlpZRWdJMkRCOGI2MXNDbGFFVTIyK3MxOFR5ZWNEaW5LOU9sOURlY0NNN3Uz?=
 =?utf-8?B?N1JXQm9BbUtKWFBINFNhRnI1VjlWSzQwT3JJMGhiTWZOMVBSTHZ6QlpaOS8w?=
 =?utf-8?B?aWxmc2VoUWJoUWM2MDFqY2NYTjRwY3k5RURKVll5SE1ZZmhiOXJaY3RMcHBN?=
 =?utf-8?B?RGp4TzVIMDBQaC9CYXJsbDVpYlFVYzlhLy91YzBjN09GdkUwcnZpNHpxVGVZ?=
 =?utf-8?B?SzVvVjcvNDdGcW85VkJZQlNXNFdDWHExQnErenRvNUpBUVpIL2thUTFUMkNV?=
 =?utf-8?B?MU5Ra1JUT2FHOUkwSUF0QUE3WThUeWFJVmpNY1d1OVIzVnFaQVNpdXl3T3RO?=
 =?utf-8?B?UndLeHdKazE5aTJHR1U3Q1orNkhMWVUvRW0vMmpybnRiZUdJZE1wbXFIWDJq?=
 =?utf-8?B?MVo5M3c2Wld3NlRCYTMzUnU1dUZQRHhwWlhveFFoSzFldzFMczZuRmJDNmFo?=
 =?utf-8?B?SVBGemMwcm5aRHRUcnNSclpVanpNazZncTV4YkxITjBQK2VOOEt3M25qdkJY?=
 =?utf-8?B?MDF1Tmk2VE5IbEpMYzF5U2QzMldVNlFqdUpnL2Z4RDQrbGpmS2ZKTjJ4YTFn?=
 =?utf-8?B?QjFnMWNONktJRjFIdmF4c0x1M3JNcUtjalA3OE9FOW8zN01ObHpOYkJtMmk2?=
 =?utf-8?B?YS9lWUVTQXIzZmluVmVqa2RZK2pGTWF0NjF6UWVCNmRqOElUbGwzdzJ5d3h5?=
 =?utf-8?B?NlY1SmJHRHFnN3ZORDFHOVhweGM4R0gybVdJVHFQdVFuaWtWOUdRaUl4WERo?=
 =?utf-8?B?TkFBaEtoYm1SaW85cUd2cFl1a2RCS1lic0hycGUrSDVYUWdOdnNWa2oxQ1FP?=
 =?utf-8?B?cmZabEVRY2w1STBqaXExQ3AyM3Npdlh4dWFNU3p4RHhzd1RZYjlUL2RsNkt1?=
 =?utf-8?B?cWtWeDJPVk5MSGU3MEhkYWU4c1NVcVJlR0xWSFVjdXZlYmFST1Iyci9QTHJB?=
 =?utf-8?B?Ni9kRWpuanFZVEdXeXBGbFNHdmptcWVDZkZ0RnlELzlLeVJqb056RmRCY3lH?=
 =?utf-8?Q?xDgCn0o76bjA2q2Gz0rTlimFc?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3cda1c7a-5a6a-4e34-65c0-08dd65208e88
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB6588.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2025 06:54:26.4958
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: u8CUwSCzoj4WOOHeOE8y1exLPx8HBatV+NtYOc6CmoY2ro+8CGFANxlrYnEVb2Wz/Q4pYUk88xJGPUBVSX0xOA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4167

Hi Peter,

On 08-Mar-25 1:03 AM, Peter Zijlstra wrote:
> Hi!
> 
> Much smaller this time because Ingo merged a whole lot of the preperatory
> patches, thanks!
> 
> This appears to survive a few hours of perf_fuzzer combined with tinypmu testcase.
> 
> Patches also at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git perf/pmu-unregister
> 

With all the reported issues addressed, for the series:

Reviewed-by: Ravi Bangoria <ravi.bangoria@amd.com>

Thanks,
Ravi

