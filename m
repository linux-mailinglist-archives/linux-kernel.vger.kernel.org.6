Return-Path: <linux-kernel+bounces-549939-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C18EA558D3
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 22:33:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 610E53AD87E
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 21:32:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7753D207A34;
	Thu,  6 Mar 2025 21:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="e5cwQ10O"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2084.outbound.protection.outlook.com [40.107.244.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F4601863E
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 21:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741296779; cv=fail; b=OhBeHuGmDduCTW3Y/gGBaur+Q8ZH0gvhfPafnsPRsf3D/wSTi7S9DpL2M1LVh8u98AuTTTLOhyat+FIlIPfUtDBvcJ8H15DB6H2xLear7aUSRHoVd/VIo5JkFH0zcHi+QeWV/YEyGX07CF60/1ZvbQnojaPAL5FvwYa72JIabQM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741296779; c=relaxed/simple;
	bh=+E7xye4wBRGQ8Q5meguJAw9pxHedXEnkztld/N2DGTY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Yc/EKMcToAELrJfYeMPRm5zbaXI1v3YJjcSkrAKnOIVQD9xkcgQjo8chgL9jYOb1HDMs7rf4pgTmqYUqBVJ9Mn3S5KCH0+i11rv2LdQWPGUBSWEi3yOwXV3xrqvQG/cdY/T3057VXpq6na69wCdE3qRbx0NCG/RFNjrY4l1OSjE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=e5cwQ10O; arc=fail smtp.client-ip=40.107.244.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jTsuS9O3G6aNWxVdfTUFdLKpfwN9RINIg2E/O7tMwSW4f+0IrVu3xyXdkCZJ3SODFmbKg6X7FoLpIUD9GUnTZ8Qwap4b3CzOFMBXwycYb1XA20a6SpYQKU1gEOtX1RuBwF1aEofYElSsVLNI6otHXhwJGBVg8cqDmyQs5gLA0CuFKAcZLWcWVzNSlBPCTReiiEbLLRJ8NxV6sr+aC8pzK862h4q9vPVI6fEUhfSeqNNSGQd/tZqj9jJogo4NF2s11O2ajthmenF0t4yhqU5p08A6X+LzjwRFzu6VukskmRSPfsDNXf+mfgJ8mOOAqj3eD33V5HhNMXGVMNCdz17VMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/W2WUvbh/7eq516lU2+f5UOUERsiP+i/NdU5XPI44hY=;
 b=xPnjiJV1X/L+O0nc965R4qYm4sA46Xmz7Zdxn+UszbvRAlT5+KQOVxvsxmAN76AC7seciXehC2+34t1y7mCDIRYpDi6MZe/Ks+z1gYMxW2JjnGUt5lAN5ZuwUdq2B34a05YPgJwRhvbWyZbFgfyhiahTOCXsqeImqQcuq4S6/fZUPy7ZZ/eLuigGAA5Zu/D879HYmb13Xvgt+CcedDD7G7gtznBv+zzmI4nKuaRfojkCpGXri+LIHWJjryG7n5QDT3dY232QIWGIbp8Jh/LnBDZeugu5vM//oJUgZpHIsGQIDu9I6f2SD5kKjFXkIsls/Ms/vq0yGsezqzuzWgR8Hg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/W2WUvbh/7eq516lU2+f5UOUERsiP+i/NdU5XPI44hY=;
 b=e5cwQ10OFLVMicOlP01Wb7ty3pNd+/2ddilQTikO3k3WfpfyEbwDMF8rRnA4NDuaTGgDtycgkGMdZ+dR3iH1Ksg7iVgBZlsAad9orJhfcR2BBBwlUBxyW/SOeFFoSkksjy3U3PMoXk9HeFtyiqdqFvjmbASBXkuRqliv9Ok8gS2yL4yPHYuYNHiBwSZ4r+C9UkUhT7coDaJ1nCEjguLThoc3hazNTf8McV1PLXt5i+6YhRGG7rUrFH0KqjGysQPKxbPZU3K1g2HiZEOSUPNXPDmB2W85GX5kqDrjtpEeA4pJ+QYLoapzRei1j4OeuJr+HqbA60VVnSTRSdXpR317Sw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB2667.namprd12.prod.outlook.com (2603:10b6:5:42::28) by
 SJ2PR12MB7961.namprd12.prod.outlook.com (2603:10b6:a03:4c0::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.19; Thu, 6 Mar
 2025 21:32:56 +0000
Received: from DM6PR12MB2667.namprd12.prod.outlook.com
 ([fe80::bd88:b883:813d:54a2]) by DM6PR12MB2667.namprd12.prod.outlook.com
 ([fe80::bd88:b883:813d:54a2%5]) with mapi id 15.20.8511.017; Thu, 6 Mar 2025
 21:32:56 +0000
Message-ID: <f52a8144-4303-49b4-ae0c-991086a606e7@nvidia.com>
Date: Thu, 6 Mar 2025 13:32:53 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 20/49] x86/resctrl: Change
 mon_event_config_{read,write}() to be arch helpers
To: James Morse <james.morse@arm.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
Cc: Reinette Chatre <reinette.chatre@intel.com>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, H Peter Anvin <hpa@zytor.com>,
 Babu Moger <Babu.Moger@amd.com>, shameerali.kolothum.thodi@huawei.com,
 D Scott Phillips OS <scott@os.amperecomputing.com>,
 carl@os.amperecomputing.com, lcherian@marvell.com,
 bobo.shaobowang@huawei.com, tan.shaopeng@fujitsu.com,
 baolin.wang@linux.alibaba.com, Jamie Iles <quic_jiles@quicinc.com>,
 Xin Hao <xhao@linux.alibaba.com>, peternewman@google.com,
 dfustini@baylibre.com, amitsinght@marvell.com,
 David Hildenbrand <david@redhat.com>, Rex Nie <rex.nie@jaguarmicro.com>,
 Dave Martin <dave.martin@arm.com>, Koba Ko <kobak@nvidia.com>,
 Shanker Donthineni <sdonthineni@nvidia.com>,
 Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>, Tony Luck <tony.luck@intel.com>
References: <20250228195913.24895-1-james.morse@arm.com>
 <20250228195913.24895-21-james.morse@arm.com>
Content-Language: en-US
From: Fenghua Yu <fenghuay@nvidia.com>
In-Reply-To: <20250228195913.24895-21-james.morse@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0020.namprd13.prod.outlook.com
 (2603:10b6:a03:2c0::25) To DM6PR12MB2667.namprd12.prod.outlook.com
 (2603:10b6:5:42::28)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB2667:EE_|SJ2PR12MB7961:EE_
X-MS-Office365-Filtering-Correlation-Id: 919cee75-f0aa-4b34-94ba-08dd5cf6756f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MDhrODkvN0Z3S0V6L2JGN0tkUFFmcnZSa3FjTGhRZ1BnNXhSZnhFaHVDaWxu?=
 =?utf-8?B?eUlvanNicHA4VzR1eUs1dDh6R2FMWjRWbkVndEFFbHI3Yzhkd2tmSGZ4bEdr?=
 =?utf-8?B?ZlJPTTdwaVpDaG1oT2prbXM5SUJ5ZHg1RCtpN2NzZEU2S0VOajlDK2tSYXV0?=
 =?utf-8?B?bTRQNlJkYktqYk12TEJWclYwQnQwU2lsU0srY2JSUTB3KzE3UzA5QktOTTd4?=
 =?utf-8?B?cXJnalBLUG9EUTU5Z3RvL3FIVEVoMW52OXFwS2xmM01KVGpmc1phUnhvckEv?=
 =?utf-8?B?OUlhNVNjanp0dVJQbThqUjBXZkxaL1ZETnZOLzFoWTRaNUVtM2VWRlMyQ2JQ?=
 =?utf-8?B?YkxSRHcrWFh3UzlBYUpCMVNDWDFGL0swazExWUVBZzU2YXhXTVpVSmoxVHBS?=
 =?utf-8?B?QXhPcU1aSGZuQVR0NnMxckZpeFk0RGJPNFo0YnpIYnNBYmhCZjZ4M1QyRFN3?=
 =?utf-8?B?ckNwRFJEWWxoUDRPcFNiRkhGQUxRRW9WWmptUzRHekhlUHR6TXh5WmNMNDNJ?=
 =?utf-8?B?aFBQaTNMbTFtNUtaNkxLUHBUaGNWYnlPQ2pNYWZwOWV6aktreUlJNnBOUFMr?=
 =?utf-8?B?UUdWVlRJbThwWUNFTGU5dkdqdU9RTHBhaVNLeWVLQmFUUHB2L0UrNlVpdXh3?=
 =?utf-8?B?clVTaDVNYVl6QzU0VitiYTM5eldSaUdNL3RGN3orL1JtRmpucXZpVGIyUXJT?=
 =?utf-8?B?VEhqMWRNclN3VjNGM3RNTXJZMU8rdUZrdWFwcnBCY2hKZVFUUG5sQkovMGpw?=
 =?utf-8?B?MFVCNEtOU1hDajlLZW5sSUlUdUZWL3ZucU5qODFWaWNnQ1IrakFIaHFaVTdR?=
 =?utf-8?B?RXdSaXBGLzVmMnRSNXAzSmFydHc5VjIvMFFUTWZmaEErMDVBUzFZemE5cngw?=
 =?utf-8?B?S3I0MHlmOE41eTNGVkY3Wkd3eW1Dc05NVENLWk56N0RKSnZWeWFJcHhacDBW?=
 =?utf-8?B?cXRWTEx4UXFxZU1HWW9Delp6MVpwWGJiNkhrMVdsZVg1OUpac3JDYlp1QmlL?=
 =?utf-8?B?R0preVB1S3hHby9ldVBFREloem5hbnVTdUNiS2F1OGU2SGY1R2ZJb0VmVXl4?=
 =?utf-8?B?YlcwOVQ1WmcwYkNXd01jWDdkNGFsZVB6S2FGSVVISG9haGdFMEg2Y0t1NFp3?=
 =?utf-8?B?ZHVyQjV1V09hUHk3MHVvVEZKU3NvSkllY0RqZ0RHWUVKTTlsVW5pY0dKTmp2?=
 =?utf-8?B?Y1JrQ25IUFd1czgzRExEZGttaDNadzNiM3c1UmJxdURxQlQ0M20zeVNWT2lH?=
 =?utf-8?B?a3JlWE9reGtEb2lvRTh0MHUrZ1YxZkJwRjRWZnlzSndScDhrWEoyKy9ZZHVh?=
 =?utf-8?B?d2JzUmpXMENrNmJEK09wZ1QrMXg4OVR5LytkR3FVZzlpU1hqMEtmSzVvY1dv?=
 =?utf-8?B?Ui9OenZBd3kxVkp4QUdVQUxZSXNtRGxEcnowVnRBbGMyQlZWSVYxN0EvYUFJ?=
 =?utf-8?B?Q0E0NXF5czNxa0tBWmczelQzWnBQWmRpYk1JODhrQlNLUzNjM3oxWGk4MHJz?=
 =?utf-8?B?di94TmhXM1dzbzllY3JZWHZzb1gxV09vM0R1VUJYcmYwc3RYUWNYUXBsWDIw?=
 =?utf-8?B?MGRzd3IxRGRnVjNoN0tySDJkVWZFV25MOWtWUGpZd3RBSDJ5bm9QTTc3ai9n?=
 =?utf-8?B?Z2g0T3N2VTdBOGpnenJzdVdGbE9jWS9STWJqOTFPbW4yekw5VnhjT0w3NEtu?=
 =?utf-8?B?N1RRL21vTC96bW5nK1FjVEVmcWU1Snh1c2FseWxjQkJHYk5VTzFCMVMwYW1E?=
 =?utf-8?B?L2JJdFpkWUtnMnU3dktTa3BaVmZFOWhjUkkxTGQrdUVHVzlVQXBWSjBMbzg4?=
 =?utf-8?B?aGJYN0xBc1d0RTVxUmRPclNEb0MxN0d3ZWhocGVncEhKejJadnZoNDVxSlN1?=
 =?utf-8?Q?mp4T9PesJLX2O?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB2667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bUd3L3RINXFnQUFBQkp5VHNUVXFtQ09yOER6NTJnNldGSmkyeVBUVWZvNFJx?=
 =?utf-8?B?dnhHY3FKUmdxRWJDSWNIY2VoWlQwZ0xBdjVIbWI0UHNqbG0zcFlNYWNZaEg4?=
 =?utf-8?B?WnBqQWZmcFQrSmI3R1N1U3pYbGhFVG5OaFRZWS8wRG8yL3gyK0hIN3l0TUdK?=
 =?utf-8?B?M3BDVURDUFp5bHBaYnloaEFMMFMxQVVKS3p1aWpoc3d0YTB2Q1lNUjdvZk5o?=
 =?utf-8?B?WmQvRnYyc1JJNFc1dHdpOUFQVDlqcHhGWFRrRzNUWk5TdHVjdkR4SUFtSDI3?=
 =?utf-8?B?dUFIRk9sOU84TVg2enpQdzdzZTUxdVhDR3FreUQvaXhGMHhhSkIzNlBodngr?=
 =?utf-8?B?dmxCZ3RlMkZZTXFDYWxYaWNKV0pIVjZvYlVBNk9HYW1FdlQ4UnQ3emhwTXc2?=
 =?utf-8?B?M2l3aDd0NzJ0czZlVGVhT1d3elE2UUxqTjRNc2dTMWs4UDlvNEVEclNHU3R6?=
 =?utf-8?B?d1Y5amhGQnVqbUptWCtLUkRrbXc3dzQra3RmMFYxWnFtdXZwdVJ0UzlLbjN5?=
 =?utf-8?B?bjJ1NUYwenUvUGJZVWpxTkRFMnhuYjd1dTVHYlQwS3IzekxISmtJUXE3a3dV?=
 =?utf-8?B?UnlPSWNkV3g2TzdnVUg4by9CRWs4M3laVml5eG5wVDU1dDBUNGRxZnpUMkJE?=
 =?utf-8?B?OXI2NExkL1gxV0o2c3VPaVowMitUZTNMeFQvN0UvcVpEU3laSjZrQ1cyeWJ2?=
 =?utf-8?B?R1RvaGRzQTJvZGJ2QjRIS1NwK2hBRXJYbk9MaGVvbkVsOU1DVmF1QkpMelFQ?=
 =?utf-8?B?Mnl4M0NpbWN5MjhnbUtSTkdEU2V3VG5QN1krQXdyKzBtU2owcWI1QWY3Qnc0?=
 =?utf-8?B?Wkd3UDJWeUw0dFpRQ1B6WmJKVHl4OGl2UVdZRXcrcTQwemdjRU9XZmc3bjdF?=
 =?utf-8?B?TUFWWU5UazZSc281Z1BDN3IvU0RnNURqeUNNZE9hUlI4anE4Vy9rcXF4TU1P?=
 =?utf-8?B?L2pXc2RpUmZibkJSRGtyVGFldE9OTkEvMGhHRisrQnV6RHR1VmVuK3FUdzBS?=
 =?utf-8?B?QUQzVEpDMVVQK01UMklNVUR1bzZ3cDM4TXVhUEJWNFRtOEJxQlZ2QjlZbXVV?=
 =?utf-8?B?aWRab3NhSy9La0ZRZUZDOSsySkZySG1Jc2U0UHY5TnR6VVltNm43TGZmNHpD?=
 =?utf-8?B?U1JWNlpIb2VUUlpWRkhMblV2RFYydFB5Wk1IOWRwUngzcUF4eFZJL1JSbmx0?=
 =?utf-8?B?UGNCSGxVeUN4RGpxRDVMb0lHMzhqeUJ2Sy8zdG0vdUx3Z1JRMGlRVXBLWGxn?=
 =?utf-8?B?WVlzZW5OSkpkUENBV1AraHR6MDhXYnREVWJpNGdxU2JJM0ViNmZqaFcvMDlM?=
 =?utf-8?B?d1hDR21Sc3J1NjFUR3FxUEVjRG53ZkVlWFBOQUdBZUZySU1TOTlISi9Nb3hh?=
 =?utf-8?B?Y2sxNDJvenZwTlBtVWV1TFRIRHlWY0tUTXBvM2ZjRUQ2U0NsN1NsYzZqSFNF?=
 =?utf-8?B?czFpc1VvSkt3SVZGTHMwbityZVlQT2tSNnZoakI4a1JjMXdMRFIyYTBIZDBS?=
 =?utf-8?B?a2tLNzVpSjVERW9QUWpqaWJKMFdHdGEyS0NnQThOU0l6b2tOcEV6K3BjWEZE?=
 =?utf-8?B?LzJqTEtXVVQ5K3djM29pTnkyQnFZb2s1K0tkQ0xUVWFkZFpwUTY3L1lEMUdS?=
 =?utf-8?B?eGhNTHNaTU1QUVVLK3ZHM1hSTitDVUhUSlBqeE1FMllQSFZwb29ySHZzMzRv?=
 =?utf-8?B?MlZIUGdMMEJCd2FhTGZWRVdhSzBJbzhsRDFZdnpHMS8yTWI3Mm5wZlNaQU9x?=
 =?utf-8?B?blRaZW5YQkZjZ1NlOXg4QkF2d1Q2V2s2SlY3Q2JicW9WeFIyYkNGRFBxZ00x?=
 =?utf-8?B?STRTVEtwSm9kaHJ4c2NqcWlIbU5IMmp6OXNhQVZBbFFIRC9LY2lycXhDbHo4?=
 =?utf-8?B?TkYrcHljWUhCK0pweUYwdVU2YmFaREJtVWw5NG51dGt3Mk4ydGhRMlZmNzlv?=
 =?utf-8?B?dzRVWUQvam1xMStqTVE0NENmNEZyZjFUd0djdzhkTDJBY3QwZGZDQTdaeEo0?=
 =?utf-8?B?cDhURVRmd1UwMEhzMUxvN2RoYjREdzZUVWQ0aGE1aGYzQUR6R1pGeTBpWVBX?=
 =?utf-8?B?aDA1S2VTUGJieXhlelkyTnY5SkVwUGdDa3BJdWpGa3dMRXNnRkFFS3pVbEl0?=
 =?utf-8?Q?FLnawztJvLKVaLa8fwJ+l64XC?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 919cee75-f0aa-4b34-94ba-08dd5cf6756f
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2025 21:32:55.9932
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +VBYZV93atLB23IbwXXKLUkNW5fGquDGDbZ6dOzkD8tnXJmhwpBRlrTl2xBn3PEwU3BpyuVqx3oGsqNCmq4Odw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7961


On 2/28/25 11:58, James Morse wrote:
> mon_event_config_{read,write}() are called via IPI and access model
> specific registers to do their work.
>
> To support another architecture, this needs abstracting.
>
> Rename mon_event_config_{read,write}() to have a "resctrl_arch_"
> prefix, and move their struct mon_config_info parameter into
> <linux/resctrl.h>.  This allows another architecture to supply an
> implementation of these.
>
> As struct mon_config_info is now exposed globally, give it a 'resctrl_'
> prefix. MPAM systems need access to the domain to do this work, add
> the resource and domain to struct resctrl_mon_config_info.
>
> Co-developed-by: Dave Martin <Dave.Martin@arm.com>
> Signed-off-by: Dave Martin <Dave.Martin@arm.com>
> Signed-off-by: James Morse <james.morse@arm.com>
> Tested-by: Carl Worth <carl@os.amperecomputing.com> # arm64
> Tested-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
> Reviewed-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
> Reviewed-by: Tony Luck <tony.luck@intel.com>
> Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
Reviewed-by: Fenghua Yu <fenghuay@nvidia.com>


Thanks.


-Fenghua


