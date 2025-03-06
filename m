Return-Path: <linux-kernel+bounces-549948-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E91AA558E4
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 22:36:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 56EEB1759E9
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 21:36:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 893C3207A31;
	Thu,  6 Mar 2025 21:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="S5C1E+Lu"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2062.outbound.protection.outlook.com [40.107.94.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 588D7151990
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 21:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741296994; cv=fail; b=uAXeNLLQq16F7YeZTHpIHVDlategehmn8ev66hwCX/NTmxJjp49Gi0GXa1fz40IgbvolSu7sLMw5UECSif6/tnSY7RZiXPj3TFiIXJVFmw6+498gKMzv3/2gE1gm1VuVTIfbMB/pY7tt+2njsua/mfZISojC96CvOB3girvVC/4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741296994; c=relaxed/simple;
	bh=T9rGbmCwy+8Vi3HEOrNo9jN3qndWgnFdkY5vQjopLSY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=dPQYD2blFnVnWIqcE8ax6JivROuvTGqcgT29zWdqt7ICUWLW+U3FPh+KFaBo02oG6kJv9C5pfmMcJB4nyAJpTkImvTPhEDsEsBnnh65JhjGf8eD1epymLCMOb8ELtMaxV/7WrYR/0jdfHD+/yoxHnEEjVUQiHb5E7uQHx0ajF1M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=S5C1E+Lu; arc=fail smtp.client-ip=40.107.94.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KF5/XjtEPFbT235SaZWS/x/ZLBR/jG1oqIRszDcH/1gCQ7ss+m4yJfqgSIHHAQO9FLWnl7S9oo/0NN31KrI+7XbeMN0rZPnNCX4jSa6UzkES8oBhbCvU8yr3VWFELQ5sADVM6jA6jAcq6bVNU5Uly7w/deMl4M47RNIfZpGXfN+aROgUAiAp6qdB2Q24b8gstud8oK48SIgkez7yYOvnrhCu+/cEI6/FOjlLGAMpSnV5O7ERQxmWoNskWGu1hlwX9vrGXvCHk71jWAjwcMy3hLnMf1hkYuDnozi0sczrh7uVEwwsRKUGHnFoOWYBGXkgqz8h2dgoJPlh9UYq4mvKdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T9rGbmCwy+8Vi3HEOrNo9jN3qndWgnFdkY5vQjopLSY=;
 b=WoHn+WrbqK1eMW34iprwXfMtc4i/BBFrN8ZmATJR+81ZLxFHvpx/VxiadWPHXWwXJ2KRIiswkYCnzhrSKHWGpxj09cTmu+Ss84x3qvX2ERM4Rq33Sf8dMCwqLhBCEVc+FQwzWJavSkvqsqnuZuEgyernIF8jgSWZRpZhvHnBgWC2B8M2CpLVLUDUzQz7evIikd2+/s2cLRVgi43XhTa5dC1fBsCFzJVguJv5AYYQ7PZHGcuZdm8BbjYCshammb/RfX3QFrIooP0kz01nptdHDEOJbP+k65Cz/zqzNKlUgVHZX/icAJRf4HBbWf2zMLauNM9aMch8ZWDRBEIkyQf0FA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T9rGbmCwy+8Vi3HEOrNo9jN3qndWgnFdkY5vQjopLSY=;
 b=S5C1E+Lu0tDMjazW8YnyyuFO+3NDQ5bvpJxWtVXp3eXxTGlzT4tDqzJK0Pl14NJo4H14wq2U1kz7N1Yo9VevRxl0+aFj3fV6W0hWBBRSxic9YehaC/CoymS0rtTbDd8SqFzwUEzaKn8rqIkcAsqHK3M9YSLPz/TCMGZ+IqPtl8OdzVkXhejZ4HrpawVuxzafY37eA773AqvwxUaKso/O9GW/bBLqdtkE1smDIUXebue23mKerDt+dmqaQtzmsKdCDG7vDZmjtPO6oI3PHmrs551T6QKcWTEpXVRG7Z9eJ2OrK/NPCQGoOF995gKRvLaJUWT4t27dEuASg/evfVMRiA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB2667.namprd12.prod.outlook.com (2603:10b6:5:42::28) by
 SJ2PR12MB7961.namprd12.prod.outlook.com (2603:10b6:a03:4c0::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.19; Thu, 6 Mar
 2025 21:36:29 +0000
Received: from DM6PR12MB2667.namprd12.prod.outlook.com
 ([fe80::bd88:b883:813d:54a2]) by DM6PR12MB2667.namprd12.prod.outlook.com
 ([fe80::bd88:b883:813d:54a2%5]) with mapi id 15.20.8511.017; Thu, 6 Mar 2025
 21:36:28 +0000
Message-ID: <dc8f39e8-4ef3-4cc4-80de-c5113749c241@nvidia.com>
Date: Thu, 6 Mar 2025 13:36:26 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 25/49] x86/resctrl: Make prefetch_disable_bits belong
 to the arch code
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
 <20250228195913.24895-26-james.morse@arm.com>
Content-Language: en-US
From: Fenghua Yu <fenghuay@nvidia.com>
In-Reply-To: <20250228195913.24895-26-james.morse@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR02CA0068.namprd02.prod.outlook.com
 (2603:10b6:a03:54::45) To DM6PR12MB2667.namprd12.prod.outlook.com
 (2603:10b6:5:42::28)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB2667:EE_|SJ2PR12MB7961:EE_
X-MS-Office365-Filtering-Correlation-Id: a00ae510-1cb9-45c8-b40e-08dd5cf6f444
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MWF0QmFjaTJWTFpxSUdySEFQQXI4ZzZCMlU1aFEvZ1NTYy9jeVdDRXlsQkNE?=
 =?utf-8?B?QU84aTVYSWM3QkxaQ2tvTkN2T0tDSDV0OWIwUWJUOEEzZW5vRkNwQjN1cnhJ?=
 =?utf-8?B?Wm5jUTlBNE1aS0FseEUvVXh4Si8rZVJiZUZxU1A4SU5MUUJuTXlvZkJOTEFM?=
 =?utf-8?B?aThURVJ3ZUhRMmZaa1FjOFN1bytQVEVGZHRDMEpWUGtGdy9wOXRZVkhVWk5O?=
 =?utf-8?B?TERNYkhEbFhLZDlSZ1ZRVHZ1SEpuVGNtdEJ1bVFNeEMvcURYckkzaGYzalNF?=
 =?utf-8?B?M2FkWDVIM1FyY2VCNUJqZEtzWlk4RThnbGZ6ODJUWE54M3NlQVlySE11WEhO?=
 =?utf-8?B?bWZDS0pRd1pybGd2Vzk3S0NUb3hMMEkxN1BHNGZDSmtRUGpQWjk3bGZFcHVR?=
 =?utf-8?B?dm10TStLY1BiUFg0NTV0YlAxUTVkVGJMb1RuQnlXazV6dmRxaUJKSVFDYWFq?=
 =?utf-8?B?NzU3eEdiRjdvbFZaQVVpVEFLalE0VUhzbHNWMG1oVlZmVDI0SnYxR1ZWUWEz?=
 =?utf-8?B?NmxnNE1UUlQ1cjJWdEJCZWx0V2RUN2xOK2FrQ0FoblF2S2xVN0FURWR0YjNF?=
 =?utf-8?B?cXB6K3pkcVdoUjB1Q2JtaWcwbUhkT09BRlhocDRQcUUwTUNSZWZRWUQwL0dL?=
 =?utf-8?B?ZDE5QlRGZERTVU12UCszWmM3UFVyZE5vdDI0V3JaMldXTEdVNUlsNkc5dDVh?=
 =?utf-8?B?K2NHUWc4anU0UzV2VjdwOXZZdlF3L1h5ZndMZ21vNmhGTlB3REV2M1p5aFJK?=
 =?utf-8?B?NDRYandYUGxFK1MzOWhJMW1QZzJuaHV3N3BjbkIzYVB6bVNSZDI0Y0p2RnU2?=
 =?utf-8?B?c1BxVEFsMEZMRS94Z2RzOXUwZ0xQV0JTSXArbDM3S0dSR0NEai9WWldmUytL?=
 =?utf-8?B?dkdHTTdtMWdlbTdnRFJHai9YY3BZVkgrSW1Mak5ZUkhESWxUMnFjc0YvbWM2?=
 =?utf-8?B?cWk0emU2RUF6SS9VMk1HRzliZ1Bta0RLei9OcVZIUHlvejc0MWRycjBzWjJs?=
 =?utf-8?B?TTZITlQvSkovbVpDYkNEbkc5SmxZS0VwZVRRQTBBQkZ5ZXFKTy9NcGNtWEVF?=
 =?utf-8?B?cXliTWhtZkFPdkNDbHRaUzN0UW9HN3VSUFBCcUZLenQwUWtIM1NtRm1xSEh5?=
 =?utf-8?B?eUl2YW9tR0Z3c0JLYm43NTlxTXV2d2FUSUMyTVpMcUpKTzJGOFVNNkIydUNM?=
 =?utf-8?B?ZzAxL2l1UlRlbXdWU1d4eVRCTkZXOC9uVTZxSDU3UytpSzBrVzdaZU50VWZj?=
 =?utf-8?B?bVFNU0NLWHFpazV4N2NuRWJkbzRHUGwzZ2R2bmgrclRZSERnY0dKVDNQUFBN?=
 =?utf-8?B?WUd2a2xMZzEwL2R3MjlDQS84UWJJc21yZVNjQUVqNEZqeThZdGNQMysyaVgy?=
 =?utf-8?B?WVRzRG9CYktiTDBEQmJKNW9hUDQ4aW9DNDZYVTRQd3FrWEFxSDFyMVBsSlR5?=
 =?utf-8?B?aTJNM2w3S1p2NWFZMk1hSTR1NGZNK3ZXdGVhY2VhZWlDazVVSXMwdUFyUUxK?=
 =?utf-8?B?TTFTbGNqQ1dnOWR2bEk5SStUZjJNL1JVSXUzazUweGpQSU8xRWZsbUQzK1g3?=
 =?utf-8?B?RHZsbVEyR1lCd1grTWUra3h5UDZOS2xIeFJBcVFvSkVocXZMTmUyTGd2enRu?=
 =?utf-8?B?WFlXSGVoMlUvZXpna3R0cHZ3a2VSeVZZbTVHYmU3c3AxdE1Iclg4KzY2OTRN?=
 =?utf-8?B?K2xZV1hWaWhyV1lvMm9CZ1pBNWk3cVFQVS9zMndvU2kzNDQ1dEhXSWRGL2dU?=
 =?utf-8?B?eFhYVUdpSE92azl0SE5hTTNPemdqWTNXeUE4ekFtaDFYNzVGTzlpT1RPdVNz?=
 =?utf-8?B?M0hJS3hLWndaT3lpMDhVWFVkblMyMTNZYksxQ0dhdFRVZTMwUXl1VjZDS3ph?=
 =?utf-8?Q?8qPhiiYLTsZxW?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB2667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?U0drLytFcm8zUlVKRW9uVE1PWDdQbGRlS2x2NWt1ODJWNUluMXdVeXV3TzZt?=
 =?utf-8?B?dXhBb3FWM243QWg2U0xHdW83cHF0U3BWemFKUWp2S25VbVhuWWErSkJaN25m?=
 =?utf-8?B?ODJZQXBzd3lHV1REdC9YcHhpODlVcG9vV29OZ2lrQ0FJeEllSnhoSkRSZWpG?=
 =?utf-8?B?WDhTbklPTzFxeTNDMnpkaVh0VnRBNG11SUVLV1p4NVk5cUZyUnYxUlU0TnRN?=
 =?utf-8?B?VEZVQkZQYlRCcVNieUppWjdzZGtzWndieDQ2Q1VYSUFXVjdCQTZnYXZWbjBD?=
 =?utf-8?B?Nldzbml3clNDRDBZbURLNVdGQk5EWWRhSmQ2NlFyZ2ZLOGpEZGRWdzFQbm4y?=
 =?utf-8?B?Slk5aFlWa3FSbnBnZTd1alQwa2NDRzNQQjQ4YmllNStDbSt3SDMxa3FoaUtt?=
 =?utf-8?B?N2pjRVN3N29tRW9ROE4vbXJUUEFqUDZCV0Q5elFjZGhuVGYrQWdTdUlIeWJl?=
 =?utf-8?B?OG5tZE9rT0ZscXFVOTVucW8rSjkvaFV1VENkUFpkMHE5eG5ObEYrU201QUlE?=
 =?utf-8?B?ZjhKMUtqQUlGYnRYTUtUWEhvWnMwZStCRzZTZmtaejdId1F1dHNmSDVPdFV6?=
 =?utf-8?B?bmFsYWNML3VqUHZQTTQydit2ZTNQeVFZU2NGcVR0TjhrdlNKbk4yVThraXZM?=
 =?utf-8?B?V1JHRWVEOGw4alJyTXhoQjVjaXUyL3dRa1hCa0J5LytLaU5CVVp1QllyY3kr?=
 =?utf-8?B?UFVxQWhFM0ZNMFhVNHhBUE5mdEhYZnB1MUdrM01qU2NGVkVqcERDQS80QktY?=
 =?utf-8?B?dUFyaTJmOHVtWm12amJudW53M1c4U1BsVVlkSWxoeFdyMldQTUwzd0llVVp0?=
 =?utf-8?B?UWpMd0ROV09LOVJyVGR5YWZHU2tiZVlCWW8yRTZhWUN5VEgzZ0MydCtNVUxI?=
 =?utf-8?B?c25PTjZEVU9RazJJY1p5U2V4aDNSNjh2enIwNkRYSXVJY3Q4UUN4MjVsUHNR?=
 =?utf-8?B?MGxvejJYc1Y5bWxIYXBiNlJjY2phWjl4RUdGQnVDYU1nTDdHeFRrYkJVZDM1?=
 =?utf-8?B?QTA2eUo5MEtsaDNvT1lMZ2pVMS9FeWpFL0ZxRWlLbGJSRUJ0RE1TeXp1bUZ3?=
 =?utf-8?B?WlQzaVp3eVo4SG9IZVlZQzhqVDM0d2laQzRFMk41MEtGK0FPVTRYQ3BOenNs?=
 =?utf-8?B?UnhHbzcwRWpPQWN2UzVtblp1SS9nMUM5UW0rZk9aNVVFMzVRMjBrZUZnMXFw?=
 =?utf-8?B?QnBmZUYyQmY3aVF6UzVYN1RrWlJ5Zm44S29KcXQ4aStKRGQrTmZXWmZiaWcx?=
 =?utf-8?B?WmxSU3ZtcU9OSkxyNFlrczl4SU9oTHRRZUUvTkt1ajJ2a2llbG5RdHVNS0Rz?=
 =?utf-8?B?SldDNUg2Y0djYWFkSSsraVVOWVU5bTNLb1dKWTJiSjY2RFRDWEJzQlZnQTlL?=
 =?utf-8?B?RVFlZk9VMlp5SzhSZWpPZnFxcDhGNjdNVlc3UElheFRzQ0V0Z3diRVdrSTVz?=
 =?utf-8?B?T1ZwWVNFbjVFLzdZSDFtRTE2OWF5TFdlRjkxeGEwZDV0WUVJVG1DdXU5ZEV4?=
 =?utf-8?B?U2pZRkJVcSsrNWRXRDJzVFN5WHpkbjJzYXhvOXNWUWxlaHdwdXNDaENoSGwr?=
 =?utf-8?B?eGQ5VDlLRDJIRzFYQjFXTVpOODhCbVprcU9WMjBPYi8xWG5hUHg3M0lieTFo?=
 =?utf-8?B?eEFmaCtZWksrUWw2TGtCMHdoTHd0ZExMa1JCcTZqVUkwMytPZFQ1Y0tBdzBL?=
 =?utf-8?B?TTBwakI0bjI0OHJCZitKUnY4VUR1aG1CTlQzdFJ3M0wyUjM3bDM1RmlScUZY?=
 =?utf-8?B?aGNycnN6b244ZXVaWHljTWN0VEZBZ2NUYXV2Q3ZvM2FoSE45SFAwTnFVK1hk?=
 =?utf-8?B?TWhIM2g4Y3JYOTI0T1k3eFBmVDBTb1FpY3g0MFIvUFVKWFhkYVV1S0pLM28r?=
 =?utf-8?B?VHRyb0pqQitvYzQwRGVxd2NqOG1ZOUJoRWNJVkk2U1F6WXc0dlA0SGQ2RGdF?=
 =?utf-8?B?YWpENUdxZnZuTWlTR1hkbDB1UkxFSDFJWFBWb2N4Z0VTVjdKWTFzbHhvdnFV?=
 =?utf-8?B?Rkw3RHpnWnhmRHowWnZRY2twMXB1aDdQK05IUGE5Z0pSSndTR1lTUnBLMlNP?=
 =?utf-8?B?dEFObzNPdzhxYTNvM2VvU2hhL1R0VG96RFJwVk1BM1lHcDRITmIrUExvdWJQ?=
 =?utf-8?Q?NYoVOcgN0qiHhFHaUpCDNj9Az?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a00ae510-1cb9-45c8-b40e-08dd5cf6f444
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2025 21:36:28.7918
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3xWpcZK0jVCtUctjdOuEaRF1Z8sJQt6c8M5BjBwzUGIT7Asqj2uirDRPC26MjR7LVscyJh//JZ2o2xPgeS10AA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7961


On 2/28/25 11:58, James Morse wrote:
> prefetch_disable_bits is set by rdtgroup_locksetup_enter() from a
> value provided by the architecture, but is largely read by other
> architecture helpers.
>
> Make resctrl_arch_get_prefetch_disable_bits() set prefetch_disable_bits
> so that it can be isolated to arch-code from where the other arch-code
> helpers can use its cached-value.
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


