Return-Path: <linux-kernel+bounces-549881-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F1954A55822
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 22:04:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D529216E192
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 21:04:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E76C520E315;
	Thu,  6 Mar 2025 21:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="UM7p/s4W"
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2057.outbound.protection.outlook.com [40.107.243.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57BF2214A61
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 21:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741294977; cv=fail; b=Nqv1M1mNmADPfrTpPPx8sSLcAWaj+UMU+MYG6SMA0Wa5r/OA2VW4Ql7tkapjZtdGRJDZvAHkpSTaDXpy2e9TDZGg7EpHpkUTkemWEhDumpokxCf5rvTPRyKeqwPht/p+TxvBUAAtVpZSaXHG/NnJXCS0H0muFv/R7G8JFmBtdCY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741294977; c=relaxed/simple;
	bh=VehNn4QWjKP/NSzqIqmCdbqvFK+kczgJmG2qMlkJ+LA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=p6J6rstXslu1AAj6iyjiX00gCudPW5JcKndDn3KwEQlFviYl+QDHE9xME+gBgJltor9qLpf2JIhY4aBNEER2jwd7LbbksR+s12ypHuL6ZToLSLKyeYLeR05Hf7ucW+q+PfrtYfG/1bHvjlmNYJQ8EFjhnQ/5PQAB3yYhehOvY+o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=UM7p/s4W; arc=fail smtp.client-ip=40.107.243.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eF5u/u89YM0UEVAqQwgNm/DnyVZRlu+TcuB4nsdc5z7+fciAe0jdtyoje3WcQZgOiRj9m/PtscuXXqZ54RVyQmCu31gSUG2KJ9bFLB0sl0b/vUDnncldiYfVl1vESwsnE9ojoPIqkF5WgwQUmo9YbPK8oMKXJn69Edlum3LNIIs1aZiW5kqG/5YaECltb2pWjHsWTVvx0hH2PPxnAmtGGmcX9iduTloCeberLrkIQJmB731xaixEtJmg4oAmOB+Ve9oBCk+ZfahNp5Zzwuw9EqWddYxlWQKkVVhNQqcHo+8qA7LPbIgy8BsBNH7nZ5GIdSmqt1hHfuPbyXmBHuaLmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VehNn4QWjKP/NSzqIqmCdbqvFK+kczgJmG2qMlkJ+LA=;
 b=LfvmPOCjoaEthb1aTL40jrvobVPOQtTvGek52iGk4Lhakd8/IJyHFw/P3ThZQN6QDx18LDhScENg1L8uEkzt9RGb7Q1vJjD38ZEkMQ5aIpTj7GGKwB4b0WmTK4Uy0PJ4eZMFIltcpj0BLSEymmxwsaEIZ3EW46OsyEH+N1D7+Q2ATLwMlbLJlGCNAauj8kiAWP9jL5M0Sr9ETA6/ApS4un5woYTbs4+/uAErPU46hHyjfZfddqbhP5mESJLtwbEavahOn8h//A7mtR75TfH/JdldT2DuJCe8PFQyHy6xuK9U53FmoiBC5ldzK6BaYhvogYVZM3f/X2WhzysqxnFkyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VehNn4QWjKP/NSzqIqmCdbqvFK+kczgJmG2qMlkJ+LA=;
 b=UM7p/s4W+SM6mMqcSSHGKvldbocu+jM9wwlbdwjMQZbW/3qOrlXsbpMrbOYqdC/bHWTvk2+C5hXW1OxTADT+RrMpl9HcMEvARpDSJVTohhbVzPJW+Bw281F+QAXXsihpqzq9S66GM21qeiRXNBO+1f+fhXd7s5ZP9il5wbDl1A/H/IzB0SeqtaG0iz+DrZcsfzvvwbr2ajUzGiVfvizwpMAGMKj8qL0LGM8G+ifgqlC/IqIbCpzb7v2ibXf0ETE9TuqhK6vjSSX66YpdXejs1DT00bUz/r2Wt60UqcjxUwDbMfMBCxQloU3bmHhICjmOVGEwIyH1yqO/qlIQpiygVw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB2667.namprd12.prod.outlook.com (2603:10b6:5:42::28) by
 IA1PR12MB7662.namprd12.prod.outlook.com (2603:10b6:208:425::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.19; Thu, 6 Mar
 2025 21:02:45 +0000
Received: from DM6PR12MB2667.namprd12.prod.outlook.com
 ([fe80::bd88:b883:813d:54a2]) by DM6PR12MB2667.namprd12.prod.outlook.com
 ([fe80::bd88:b883:813d:54a2%5]) with mapi id 15.20.8511.017; Thu, 6 Mar 2025
 21:02:45 +0000
Message-ID: <8a0dcd23-2458-4b60-a90a-f9bfab00bc8e@nvidia.com>
Date: Thu, 6 Mar 2025 13:02:43 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 07/49] x86/resctrl: Add max_bw to struct resctrl_membw
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
 <20250228195913.24895-8-james.morse@arm.com>
Content-Language: en-US
From: Fenghua Yu <fenghuay@nvidia.com>
In-Reply-To: <20250228195913.24895-8-james.morse@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR05CA0042.namprd05.prod.outlook.com
 (2603:10b6:a03:74::19) To DM6PR12MB2667.namprd12.prod.outlook.com
 (2603:10b6:5:42::28)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB2667:EE_|IA1PR12MB7662:EE_
X-MS-Office365-Filtering-Correlation-Id: ee995662-97a4-4ad2-9be3-08dd5cf23e53
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TVhDOGVmRGpLT0UxN1BBUk5RbTkrKzJtbFpwL21haXFFVGlLU0c4Wk03ektU?=
 =?utf-8?B?WldNV24yWlIxaThSMWkyY3B5cDBvOHlCS01LQ3lmLzZ3Zm4vU2lNTkwrM3JI?=
 =?utf-8?B?d2R4WHR0U3pyYi8vSDE1aVBGZkRsVSs3MWo4VUtRZUxOQ0J3cnlKdlBLaTlK?=
 =?utf-8?B?c1NrSW5INmlaWjBQSjFPZGJiQmFLNldwRVdQckxGMHRHNVVtaUtqcUxYVzFY?=
 =?utf-8?B?NEx3MGV2OXRxZkNtOWpHbEZKL0c2YXQ5OU9XU3hGeGZaRkdTVUEvN0dKdk5N?=
 =?utf-8?B?N0NHcm9KSUVIY1VvK0ZtWEdjenRzQS9FSWtyblRobXVvdldtcUphUURHbXdX?=
 =?utf-8?B?cnFrTm8za04rNWFkaFFza1lpcGN4Z1VzUzRnb3Nwc2ZrRWxuZ3hwejlkRXFL?=
 =?utf-8?B?N0hVdlJkcHMyaUpweFRYTGlydGhiVnpBSHBuVStWSlZ2NVl5dFFkakQ4SThM?=
 =?utf-8?B?Tnh2a2dYVmRxZTY5SDQ2R00rN1UxTUpUeVduQWd6ekRUWEIzNmMrSjMxNVp2?=
 =?utf-8?B?NFhxeWFaTi9BL3lPdis0WVNYdFFzeVRBekU2ekNGdHRMcFF2eTQrQlc4ZUd3?=
 =?utf-8?B?VktEOHJuaEU0TXk5WVBkWFRjUVlHeWhXTm01NWhPWjdGU2MxR1lYZWV3UlBa?=
 =?utf-8?B?b3hWMEVaNWF3Z3IwUTFOc0UrWnVWMmVRdm5qL3d5bS9SK1RMTUl0aEZpM3N5?=
 =?utf-8?B?b2RLSW1LR0lxR2M2Q1BWZFBVQklXWTRPTVNBdnM3eFBXZDhoc2JDMWU3VWNk?=
 =?utf-8?B?d0VKSUhHVXJUNENIelRxb0NBaXIrMXlkQjVVYzcvL21uQk1qc1RTUFNMUE9v?=
 =?utf-8?B?TEdqVWxXSDJyWlhxTG9FNWdoTkRvMFlST0tIOGgrS3ZJNDdJeS9kOXg2WHh1?=
 =?utf-8?B?RzFvb25SWHVYUlU5dUpxYlVhNGs2SitWd0x6MW5wbVpxejZmL0w5eWxJbHNC?=
 =?utf-8?B?NUMzRW9CbnVKOXExalAvbzBpODRWK2c5RElLcTY5dlVFMVMyYXVKT1p1eUUw?=
 =?utf-8?B?eDFiY1FKdTUwYldZMzlwTnNjaXNBajFQNXJGVTZMSyt6RVJtSW0zeEo0TFZN?=
 =?utf-8?B?VUtFSHBPVDZ0K29rTVFzTTIvLzBTaE5vZ2hmanN2V0c5SVFLUnpYM25wQ3Vi?=
 =?utf-8?B?M3hjdkJFVTFlLzdBa28rZVpBMWFMS0JtZFJBbjFvRncxdEZ6ditubXpWTU5X?=
 =?utf-8?B?dHJNUm4xSUpJUXVSRkdaYWpmNVdJdm9ZVHV5TG02VHVKekt4Q2VDTStmTzBN?=
 =?utf-8?B?QWtDSXhCUzNPUGFaM3Q3SWFzT2JFSkp4ZWZPc1p5VUpGM05oQTNDS010ZFVV?=
 =?utf-8?B?ZkNsc3hwTEcveHp5dTRQUk40Y1I3NytFOURzTExmcCtTcjZUL2lTbEJsZzQ5?=
 =?utf-8?B?Z3hYYlJPQUY3MC9xZUp1OTJYRnJEcTN3NXNqSDltRnkxM3ZuNmJQTHNpaHky?=
 =?utf-8?B?WkNBM2gvNDVoZHZEckVtOFova213anYrazVTN1luUDJyaExBSEYrUGUzMENL?=
 =?utf-8?B?c09uMmQxYWdMVUtwd3dBOUcwMFRrRUN0cjQvRENROE1tTVd6aE02SVgvRDZC?=
 =?utf-8?B?YVJVdTlCRURUY0ZuMHh5VURHUmg4WkFxK3VGWlQ5MkRyN0ExYk05SUJIQnJy?=
 =?utf-8?B?dkV2U0N5bnlPTTFiT3gxM2Z0RkR3SENNTEQ1dGU3UTBWSVFhSEtUaDFyaTI4?=
 =?utf-8?B?aExBN25jVWFTT0FXSnV0OHlhTHp2MWIxVWJpVXNOa0lHYUlMM25YWXVQVzY4?=
 =?utf-8?B?RVcvOGRGdjdOQjBCOS9vN21DMW9SVjJieElYdmIxZktDQ0VNWmJXNG10bmtE?=
 =?utf-8?B?N20rNkN2T2ZnbGpUUEw4Y0YxNE9VKzBiaUIvLzJMdjdQYjczeHRwckg5ZkFI?=
 =?utf-8?Q?174nT/AwU9HJT?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB2667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MVBWdGd4VEQyOCtlTzdxVWpIeUsxSDVTZlAxNEZCREdRS3FDT2VjMnBqSGlx?=
 =?utf-8?B?aTgvRWhNWTUvak9ZeDRKdTZON3ZSTG42S2ZpdXBiY2x0NTIvTFZXeDhHMEZW?=
 =?utf-8?B?QlY1c082UEd0aC9xVzlCclRySmtyWDV6WDNxZ25lS2c1ODBUcDh5blBSVWJy?=
 =?utf-8?B?dzZTa0tTMi80Q0RnRzNNN1hWZ2RrWkNaMGNmTEVLSmUzeXhidlF1enNwRjFj?=
 =?utf-8?B?eUlmSEMzdkw2WjhsQnN5RWlzTTNNL0hBbm11MlZ0czdXaUg0eERnOENMOHdq?=
 =?utf-8?B?Y2UrSDcvRDJ1ZDZuVkJuQzlsdGZIM2VZS3N4V3dKdUM4RG90VE43d2Q2WCs0?=
 =?utf-8?B?ZGFBaUZvWGhiWWdPUzFhMkRzMlRFb1hPQ0ZINndzdjhjWVliRUtKUGMycUtm?=
 =?utf-8?B?eDFWWkVnQkhySHRqUTF1Ulg3dDd5anRzTDZwd1IrUG5vKytZK2hYeXhHY2Ny?=
 =?utf-8?B?MVpwcUdJcVlqT0plaXEzNGFSTVlXMVlmcFJOVnRhYjFrQ2RwckEzL3NWRWt3?=
 =?utf-8?B?UWNWTE9wRlJnNzhncDM2aFdjQU1ZazR2WGtBY1lvVDFhN1llUllSMVdwOGhq?=
 =?utf-8?B?K0dha3l4eXN5YzNma0JGbnFtODA0Z2QwR1IrajkyVkJja0Z3YnhqY0p5MnNZ?=
 =?utf-8?B?eXFMODB6OE1aeHErdjFCcnRaejZ0bTViRE5jUTRpUFh3U0FqL3F0OGZQbFJK?=
 =?utf-8?B?UWNDallXaC9OdnM3WkFuYlVVTHNhTkxPQjkyN1dOTmE2UW8zQ0ZyVHFrZVNv?=
 =?utf-8?B?WFhKYmdjT05GdlJLMllXWkVYZjB5L0RvNFdjcWdkTG55a1dGalc3NDVNWWRZ?=
 =?utf-8?B?MmJMQUZSMXp6aDF0NTdYTzdzR1NWRGJKdFoyVGFBWXJvTUhxT25wNjdhY2ZB?=
 =?utf-8?B?RFlwRFVndHkrSDg2MFBVR1BWSjE4Sm9sNnU5Mlg1NVQyanlWZkJaOGZkSWh0?=
 =?utf-8?B?N29LbjdFV0krVGwwQnV3a3FYM1hzV3dtNzJaU0ViczVSNmE4VktiK2hiZTA2?=
 =?utf-8?B?RUtEYUVBOG1OdjQva3ZzSnRCQVBqaXUzRExtcEZ6dkJrZFFQc2cvRG1MamhJ?=
 =?utf-8?B?MVlKd2puUCsxV1YrenBPZHVtNm5EREd2VjVsbm0rdHhBM2g2Wi9NNXVzWlh5?=
 =?utf-8?B?L0NpVklhdzFiL3hSU1R3empwYVJhTDJLRm1pY2szQXh2REpNMzNPQ095S3hn?=
 =?utf-8?B?QUlvcmZlL2lmVnB6T1JnZnBYNW1BZ0tJSDRYQXV6SWlLTWxUMis1M21aMGc5?=
 =?utf-8?B?MWVCTzFKVXZMVUR2YkxsbWlBWk5XYnlnZ0Joa1U0eWlOUkVrbFlwVWhTVWsv?=
 =?utf-8?B?Q0Q4ZmtXMFhFcTJENVAzZml5RzBER0phSEJHRkRkM0lnQjlBT3NqVXVTSGNR?=
 =?utf-8?B?UCtUZVJ4NDNyTXpCNUZ0RkhucG9GUGlQcjhqcWJFSVFLblIvcGx5WnBLWjFk?=
 =?utf-8?B?WG4vMWxIY2RDY2dtb21RNW1hY3dqaEozNjhQUFZiNER0MTVvSXNoUDBmd1Jl?=
 =?utf-8?B?Q2FoTmpKOUU0cC9vSk1TM2FrOEFOdS9YSkdvYVdRaENiN2IzeWRrUDdrUndp?=
 =?utf-8?B?VFQ0SHAzT3JkdjhDSjNodHhaSkFVVnZpdmM4VEQrc0o4Vmc4NzdBL2xyQ0U4?=
 =?utf-8?B?UnF6ZVVwMzVldjlmZE1PdFRsdTRFMjBVSzdSV283SDN5VS9jbEtGaGMwVFBh?=
 =?utf-8?B?dGVPMUV3aFBoSjBlUHd3bTg5WGtDN1doNFUwa2NEdWMyT2RlcEplQWE2UmpO?=
 =?utf-8?B?bHBSSENtb01jMlpLRlhPTXd4UG1ZRVY1eGgxNVhXaFZOWTFhaHpDNkE5eGNT?=
 =?utf-8?B?aWxpTHBXbjBtV0Q1dTZ5NmNjQisxVE9oN052STlvby9mVDlXTFZ3encwRDlp?=
 =?utf-8?B?YVRsY09zQmw0VG9FQVYyWE8vbVhRQ0NsZWxSMkhKMUMyRE1PczBWY2dqZEVZ?=
 =?utf-8?B?QnJPa3Q5VURLMmI4bmVMajlCb3AwNXRTM0dQSmtpM0pJVU5vZE5VYnN2em42?=
 =?utf-8?B?ei9MdUY2NE5nbStXQlNMNS83WjZ4VmUwOGFnY3lXS2ZPellycFU0MU5vS09P?=
 =?utf-8?B?T3dZOW5qZ1UxVk1SRU1teEYvS1pJQWpTdVVQcWwzdXRhVFlqUC91VEVYeWdC?=
 =?utf-8?Q?oAoKEWa3fiyfXtAC3tgbBdgHP?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ee995662-97a4-4ad2-9be3-08dd5cf23e53
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2025 21:02:45.5639
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dL7JTHqnv4+lnu5QiHjee3WvkVaN/siwVq/PlxYgEsAhvEoW2zdZND4ZC0bWaruiFTe6EnVcu57nTKsWD9xWAQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7662


On 2/28/25 11:58, James Morse wrote:
> __rdt_get_mem_config_amd() and __get_mem_config_intel() both use
> the default_ctrl property as a maximum value. This is because the
> MBA schema works differently between these platforms. Doing this
> complicates determining whether the default_ctrl property belongs
> to the arch code, or can be derived from the schema format.
>
> Deriving the maximum or default value from the schema format would
> avoid the architecture code having to tell resctrl such obvious
> things as the maximum percentage is 100, and the maximum bitmap
> is all ones.
>
> Maximum bandwidth is always going to vary per platform. Add
> max_bw as a special case. This is currently used for the maximum
> MBA percentage on Intel platforms, but can be removed from the
> architecture code if 'percentage' becomes a schema format resctrl
> supports directly.
>
> This value isn't needed for other schema formats.
>
> This will allow the default_ctrl to be generated from the schema
> properties when it is needed.
>
> Signed-off-by: James Morse <james.morse@arm.com>
> Tested-by: Carl Worth <carl@os.amperecomputing.com> # arm64
> Tested-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
> Reviewed-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
> Reviewed-by: Tony Luck <tony.luck@intel.com>
> Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>

Reviewed-by: Fenghua Yu <fenghuay@nvidia.com>


Thanks.


-Fenghua


