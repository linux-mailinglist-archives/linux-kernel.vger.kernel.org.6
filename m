Return-Path: <linux-kernel+bounces-364743-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EE84A99D8C3
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 23:10:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5AB271F21AE6
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 21:10:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42B901D0940;
	Mon, 14 Oct 2024 21:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="V0Au+E1m"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2084.outbound.protection.outlook.com [40.107.93.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFA7F4683;
	Mon, 14 Oct 2024 21:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728940191; cv=fail; b=ZcZo0YbcCT+foy/Iz0pYw4sx+s/cpsHD6kQLOr+bglkpazMrSxK/OJf4pRaYehLSJhZPWpHwztNf5seg3VSaMTFYguarlfcetT90NZtKNIoXUCGY8+CyEuuE45hVNj9eEt+8R1BHR3VzhcG68ct1jl3cZkHlsEQ5ji0bJuV93l8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728940191; c=relaxed/simple;
	bh=GL3/lPC3+yBPbO45lZ/dHo9+tiGWC9VfsJL77uQ9VT4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=acu0C9UFheaoizW5Py4IAFoEX+0qJPiWqiD9JonvdG+/i/xaeZ+UbVWrGROg1xlsIyFqh3WOmbJvBiPe9C757LdIc7qF00Z2BLjuk8g0NhFfYQh21LhHqBWJbbCQIYplPluW+E7+8kWOZo8pC4RmB5zMtW88q5glMTyjh3T5cRQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=V0Au+E1m; arc=fail smtp.client-ip=40.107.93.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IngADNdsiXdcn4cvP28S/+cE71+Qv9Jyi8WIjA/N86UuOPNk0jJAa0IlRlcqpxzj50unsD7xRAjvKZiE2Cb5Z4WFB+rvOW35/Fnr5y2wff7KT9dAcT72Y//iZ2dllKZRl2Gid7Ilz9CNiH6000tI5hlhy7YK7cCbN08Bc51XB4HeObfvoxKdq3lAu0kIIhH9si12IyFP+A6IW3WqwfQKTkKZZVGorxVnMue/7aAWCnKIJ1N0Q2lmHZF4iLwHTAIi8EkykAvcgghMKFu1JWm7j+ji+4rFofL6W6WXAzU/ABkykau22M9j3H0lyJBzkD3tywgqiSUeOTpZFXKJTS7AHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HgTgl3qx/umXfGHayLIcA2aovQzddrYmWwWmwx2AHnQ=;
 b=GqPlsgRt1qY1SpCn+GfJwddUS+F8MQufhH73b/nyZGdQACH+VSwH2IU/1vhfq4lPVH1tXRvrHXOAOplla7CA2Wp1iA/LDiCY8n1kEURcqESgHGxHceGpSoUNUcKfeOrKzffEi/CPUXpvW0IoyyeEmWzPscUmHYu7HIioFgC3N+mZSUS8/+nRnJFfLt3TqSsk8QPVVNfyCtij1QTKz6uh2ltNHTYD6MX4XvAWvkw8lP3d//o6fqy9YDZjRu6btDmRDPaqDFlf5AOTGisKkoIMedSgOPslhVR1cy1HhpdTNBIkZ3GnkwgTH5gI+7h1hczR8jxv/NzuRsQ9EcAvSkX5JA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HgTgl3qx/umXfGHayLIcA2aovQzddrYmWwWmwx2AHnQ=;
 b=V0Au+E1mjAs0GdoPCX2bc4z+lCakX0ioLQ8cnr9+LYPzfuZY9Ciar7zjr5tYjivBsCaVj2vTQdTohTEmLfdg+mdg2RlcC1gG27Le90726BBz8Vt7fxU8YWydf7OHuBq0KjaP8Jw+Nzyok5bMR0j/okhWYqKQMQNpMQ0Kymqv79g=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB4447.namprd12.prod.outlook.com (2603:10b6:806:9b::23)
 by SJ0PR12MB6943.namprd12.prod.outlook.com (2603:10b6:a03:44b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.26; Mon, 14 Oct
 2024 21:09:47 +0000
Received: from SA0PR12MB4447.namprd12.prod.outlook.com
 ([fe80::b4ba:6991:ab76:86d2]) by SA0PR12MB4447.namprd12.prod.outlook.com
 ([fe80::b4ba:6991:ab76:86d2%5]) with mapi id 15.20.8048.020; Mon, 14 Oct 2024
 21:09:47 +0000
Message-ID: <5c3344b9-e896-e93b-6853-1bff83d6544c@amd.com>
Date: Mon, 14 Oct 2024 16:09:45 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v7 2/2] x86 KVM:SVM: Provide "nosnp" boot option for sev
 kernel command line
Content-Language: en-US
To: Borislav Petkov <bp@alien8.de>
Cc: linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-coco@lists.linux.dev, Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>,
 Eric Van Tassell <Eric.VanTassell@amd.com>,
 Tom Lendacky <thomas.lendacky@amd.com>, Ashish Kalra <ashish.kalra@amd.com>,
 Michael Roth <michael.roth@amd.com>, "H . Peter Anvin" <hpa@zytor.com>,
 Peter Zijlstra <peterz@infradead.org>, Dhaval Giani <dhaval.giani@amd.com>
References: <20241014130948.1476946-1-papaluri@amd.com>
 <20241014130948.1476946-3-papaluri@amd.com>
 <20241014154040.GBZw07eBVDJoLJZV0w@fat_crate.local>
From: "Paluri, PavanKumar" <papaluri@amd.com>
In-Reply-To: <20241014154040.GBZw07eBVDJoLJZV0w@fat_crate.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN7PR04CA0181.namprd04.prod.outlook.com
 (2603:10b6:806:126::6) To SA0PR12MB4447.namprd12.prod.outlook.com
 (2603:10b6:806:9b::23)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB4447:EE_|SJ0PR12MB6943:EE_
X-MS-Office365-Filtering-Correlation-Id: b18f4fd1-459e-42e2-959f-08dcec948881
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TXVseTNuT1d4dmFZcUo0VDExaXJsMVlPZWFvVDE1RzZHeWN2MW9ldVRGLzlj?=
 =?utf-8?B?NWV1V3pROERadVFwZEsveEwxMWdWUEFXem9OWmY5dG1wRkVnVUJMQmg5a0RU?=
 =?utf-8?B?UHlJNVdOMG5nNDd5Q2krdmZzcjIvWFZVYTltOVcrMkxBOEhBU3NCNFVJWU1W?=
 =?utf-8?B?dzBGT2JjTnEraE93MzVhRm5XcWdRNW42MXJza3dPV1FRQ2lJL1ozVnZkTFJF?=
 =?utf-8?B?SVE5TElOS2ZXcTMxbktPMTdPNzRIall1a1g0NDdSY3dTRHVBZFNIdTJJQ1Zm?=
 =?utf-8?B?eHFkMllDZmVaeWFwY0tNeTdiTFZpOHhtMXJXZjBubTdkQjl0bFdwRnZ4Ylpl?=
 =?utf-8?B?L2NKSUt5eXRLdERMcXViR2VEQUFpZ0V6L00vKzJ4V3JqRitpR1RKcUc2dTBK?=
 =?utf-8?B?RXJmNDFGeno0dDF1M1VLazM5ekZTbWNxRUN1cFUrUzlOc0xuOFZqY01hVmNp?=
 =?utf-8?B?ZXJINEJZZ0N5eUxLTW5MakZsY1VRU0hjaFJEb1B0YlFOVHZTNFNxZk5sUmpX?=
 =?utf-8?B?aWJsTmxFR3M1L0JlZEM3S0JxblovN0kxcUtHUFpLVEhiKzlnOExJbmhjVXNV?=
 =?utf-8?B?dGg3WlgwVTJWaGRsSUg4cFFjcU4rM0Zvc041bDlhd0thSkpiS2xEZ3BoNStl?=
 =?utf-8?B?NkU2WjRDRzFtYXZSWWVZM2ZsaVpyaTB3ZHRwSWQxNUJYclhRTnVzQmFSS0dw?=
 =?utf-8?B?YzVwMk4yOWRyTjdxT2FuMG56dTh2cXczdnhmdnZNbi90cTZzT1V0ZEhTZjlh?=
 =?utf-8?B?d2laeUhVSzVtS2xwK1BYU09uQ2UrY296NExZNFUxT1k5cjQrTit1OXkrR3lD?=
 =?utf-8?B?c1UvQlhmQ0Q1NWNSdDM4d1MzL0lvWmtSYkJmdzBQRzhtMDBwbVlQeFpjaC9R?=
 =?utf-8?B?dkRFbXdwd2hFQ2NCeFdLTTQ1N0NJS1htS0dEWFNJUlFwZ2R6U3RDbE1kTG5u?=
 =?utf-8?B?Q2NOekx3cVVYZnR0MXRoKzhveTYxZlFOdHd3M0VqNithemFWdWVwZlBXRXlz?=
 =?utf-8?B?KzlmUXk4aVMraUJYdzRJcmVWamtSUitoa0xSNi9Ua1QwTjlCVkdqK3JYZUM2?=
 =?utf-8?B?N3hSZkp6ZTZQRHBWU3Y4TUF2MFFhTTkveDNEdWJBSlRySmlkVC9nL2ViTk1k?=
 =?utf-8?B?SXo1Uk0vcU5pV245elJscmI5SlhyOHJyVWkvN0NleEVtV0cyb0psRUNYbG00?=
 =?utf-8?B?MXdBMWtnSkJ3bW96a3pWRzhOK3lLVktKWlMvZEh3bkN2QjRuTGROQ3VPYjJa?=
 =?utf-8?B?cVlrTkEvYkJRc1BRUXJiblVURnBnTHZFZ1FCeXJsK3pGZFljMDF3RVI0RlV1?=
 =?utf-8?B?MjNTRU1aRGNwL1VpOVNUTFZXUThTZExPM0RERnVkMU5JUzBYeFgraWlXbmc3?=
 =?utf-8?B?Rjdua1hlMVRZRE81LzNncHRCYXBBVkZSZ0FxY3B2YzJELytQS2tQTk9NYkFG?=
 =?utf-8?B?NWJFajlpaTViSkFRVytQSnFacDE2L0VKa3lqK0ZLc09rdUdMTSs3ZlIwc0VV?=
 =?utf-8?B?cjN4Vi9GWEdiQVZLckkzcFFCbENvUFo0Z1BkY09PanQxNytjQTlvdnZqZWps?=
 =?utf-8?B?QXVrcnBSTDhPYjFGWTJYWllKOEtKR1Z6cG5nMVYwNkVOS0tyeWJqOWoyS1lS?=
 =?utf-8?B?K3J5MWRIMStxYzloemxrNG5aZ0FDd3VQbTAvclAzc3JkcXJvbkxVWlZnWkQ1?=
 =?utf-8?B?UG9PRHJ0RHNITXBOenVDMXF4V0U3Yk5FQzA4T3RON0JhdkhuS3RCZlJnPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR12MB4447.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?U3FHbVlFS2dQVWN3aFpXaGl2UFNjMWFobURMdzcydkNNdHQxMU5uS2tFZ2J2?=
 =?utf-8?B?djFHMUVIZGlTZmNteFFKSXRvWnJNUTY0K1ZtdkkwTHl6RExOd1ZsMXhNQklX?=
 =?utf-8?B?V1Vlbk5UV1Y4SFFaZWJuZ1dYcDVKT0FIb0ViaWpjTTF6ZFJ4YWJyak1ocFVM?=
 =?utf-8?B?YWQ1SklDNnV2TlZnMHc0ZjR5MjAzazE0UTV1eEZkNWV4NFk2ZXlBOVI3MmYy?=
 =?utf-8?B?SGpvWEVqWTVQSHBSaVptajVKbjZCVUtybVRaQ2xhQ2Y3LzJ4TXBxMHFmQWNU?=
 =?utf-8?B?WmZJcVlveTYyWDdzT1hxRVpSRmZXa0NtbXZ0ek5VcjRpc2FkZk5mUW5CdmpR?=
 =?utf-8?B?by9INmZNSmtjMXI2aktOcjhqaXlHMFhUMHFPWmpMMFNiNlgvaFdUVnZ1bWNF?=
 =?utf-8?B?aURlam1XNndoSmhCVWZvWmFIZmV1eThaclBrTGg1V2tKM2J0VlZkSDZXZFNW?=
 =?utf-8?B?MjV2c3N4NCtLTzRXeWg3NEs4Z2Zmcmo4UExsWVFNOXpkRGZYYUJpUklOdFVK?=
 =?utf-8?B?T1VGbDVuNnd5ZUdkcVRGMGk1aE1hUGczZndOR1pBNmh4aEs4cWZnd3UwWjlz?=
 =?utf-8?B?YlJobDQ1M1JmclUyNGpBVFFEcjlNMzJaNFpSME5wK0gwU2MweUhjMkVXL2o3?=
 =?utf-8?B?dmNlcUtPdVVuVE1OaW1EYnRIOGk3c2E4SUtVc2lkOWNKbG5OZmNZeHdvcmJV?=
 =?utf-8?B?YkRhZ1hjU3piNGtkbWZHVWtjTGVzVnJneldOMDFidlA1ZWp1d05yWm1RYlB6?=
 =?utf-8?B?RTBmREs2cHhOeE1JZTNxRlo5OWpzbnRWUHB5WWJFZWZLTldHTW9NczUzY0lh?=
 =?utf-8?B?YUdPMTI0UXYxNEEvd0pDeHZpbVVnQUN1VUdKa2NwVEM5cURENHVSU2xVK1FC?=
 =?utf-8?B?NVp5RExCSDkyK3o0Wkt3UlhaMUJwT29YUnFYdVRBc2plZ2w2QjBLZ2tYanFM?=
 =?utf-8?B?TURCbXBZcUdwVTh0WnQrVHg1WmNRZXBwM0VZS0UxVEorMHlnMzBMLzNPODFo?=
 =?utf-8?B?blNxeTZZb1ljdi9Ga2RPLzIrS0lYK3o1UTlROUJKaTlBR3o5OVFiWHBtWUtW?=
 =?utf-8?B?TjVjdURsdDVaSGdXVVJNVWZmekwrdzhzaERMa3luSTFJRStwY3ppTmI4Wm1q?=
 =?utf-8?B?THMrMVZsMGZRZXFZaXJkcVg0NW5yOGNDMVVPTXVJbmVLWS9GVEZUQzF0L3R0?=
 =?utf-8?B?VUdXZ2JEdERYai9Hd2FBdHlJWTVoSXl0TktCTm1pRVMzejIyYmQ4ZENYbVNx?=
 =?utf-8?B?Q2VSWGpnR2J4V2x0ZlV2SStmaWRuMnBCRk5XcW5Ib3B3T2lkV21jaHkvV2Zp?=
 =?utf-8?B?TkRyclNPaDBpRmxEbEJhbC9qSk5XWUFmL2Vqb3NjOG90Tzd4Vjc4aHpkWVg3?=
 =?utf-8?B?alR2NGJwY1FaY1V6OXc1VWdlQU03NjlIZ0sxMklUUmtkZmF2SlZEUEZ5aXlv?=
 =?utf-8?B?Y2VBWWFLbmc3QUV2eWN0bmErZzliVEIvbUtZT2dVcmJKSEtJazdTMUlUeERu?=
 =?utf-8?B?S3lRMC9NRUNabmFPMDN0NDJRTnpoWDlmUXR6bU16c29CYVhZdEkyVDByQVNN?=
 =?utf-8?B?Nk52UjlkWFRzak5QNDRJZTRucmdFeGpNWlVZU1lvREtHbHhFY3NGNnF5TU52?=
 =?utf-8?B?V3ArVk83bUowV2Q5N0FuVURhYVF4SXZERXFBd1p4d3pkMVpUdGpJNmFYeHVF?=
 =?utf-8?B?TXJQRU1JOUlIZUpzRjRrNG1ZNW5nNnVwcWIrRlhKMzE5SVB1NllkRUZlSFVK?=
 =?utf-8?B?V2JLUURWcWh4RGxrdVJCRTZ3TlBMMFZZNTU5eU5jV29FUVZZSlowZUVMMHhZ?=
 =?utf-8?B?WG5OQU1lajBZTmhxRGx6UVlHam5MWSt5Y0thUzFCdUNFdncvMkFJd21CL3Rq?=
 =?utf-8?B?MlE2dWQrRmNvZGE4T0prR29qbzRVWFF0U0kxd2FDSFhxL1p5cUExQjFCSzhq?=
 =?utf-8?B?SE9VTHdJaGVXUHNPdTQvRUtranNHWk5jeGlWSFJwSEY4Q09jb3RtQXFRU3Bm?=
 =?utf-8?B?Yjl1WVJKQnppZkc5VmtHWllMeFBTdWRRd0pMZVU5V1FMeXJWVmJsVi9MMWha?=
 =?utf-8?B?UU1sUFdsK2JnZ2FlTUJZbHYwRCtINjBwdDJLR1d0UE5ncVdUNTFJd3JMU0tq?=
 =?utf-8?Q?sib6PdZT/2mCvVOLeVD/iuvJQ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b18f4fd1-459e-42e2-959f-08dcec948881
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB4447.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2024 21:09:47.0357
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WrYRfggot3WoYT/FonNECHBi1mu7epPJ6A/5Oi/FND3f8FUWoRkMeWnhbVInAB46hTl5d4/E4q24Sswo4JPfAg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6943

Hello Boris,

On 10/14/2024 10:40 AM, Borislav Petkov wrote:
> On Mon, Oct 14, 2024 at 08:09:48AM -0500, Pavan Kumar Paluri wrote:
>> @@ -25,6 +26,12 @@ static int __init init_sev_config(char *str)
>>  			continue;
>>  		}
>>  
>> +		if (!strcmp(s, "nosnp")) {
>> +			setup_clear_cpu_cap(X86_FEATURE_SEV_SNP);
>> +			cc_platform_clear(CC_ATTR_HOST_SEV_SNP);
>> +			continue;
>> +		}
> 
> Well, if it is a HV-only option, then it better be such:
> 
> @@ -25,6 +26,17 @@ static int __init init_sev_config(char *str)
>  			continue;
>  		}
>  
> +		if (!strcmp(s, "nosnp")) {
> +			if (!cpu_feature_enabled(X86_FEATURE_HYPERVISOR)) {

Sure, it does make sense to add this check since nosnp is only a HV option.

Thanks,
Pavan

> +				setup_clear_cpu_cap(X86_FEATURE_SEV_SNP);
> +				cc_platform_clear(CC_ATTR_HOST_SEV_SNP);
> +				continue;
> +			} else {
> +				goto warn;
> +			}
> +		}
> +
> +warn:
>  		pr_info("SEV command-line option '%s' was not recognized\n", s);
>  	}
>  
> 

