Return-Path: <linux-kernel+bounces-550288-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DC1AA55D95
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 03:19:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 239581896C7B
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 02:19:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFFD918785D;
	Fri,  7 Mar 2025 02:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="A5I572XG"
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2085.outbound.protection.outlook.com [40.107.243.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 360D4183CA6
	for <linux-kernel@vger.kernel.org>; Fri,  7 Mar 2025 02:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741313966; cv=fail; b=R9DuzkLNuy97a8SpImscMk95wr0UCm06nB6kHkWdNbkUTHYbssLZfaigzqEkGEJ7asQvCovib7SYKuwIzz2jbVNkCvyHN7d90ahz1r5nI8I1q9WzaAqgMLi0kGFMG5QFbU2eEheJtX4S0UkZedsnhPG4qey/Y5aWAWs93OlxqmA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741313966; c=relaxed/simple;
	bh=8hcsA04RFB5Kmp3pRbzgoZO1xPTKf1808hkPI/flOm8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=HicIPpVvA2yS/WfwpBiNNZe5eXYyJGE3QoVHYW4lBHKHYbT8DxYaVW89fDACH2XMmlAvDuVPnEBfqwdVrqhV9wDnpW6r2Gwcb9cF+TEKl78dCy9ZEo81UkTyoUm4an/EmWJx0HMg1dwHZmrZXgOOUYOefiWWberVKpU/T4keNkU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=A5I572XG; arc=fail smtp.client-ip=40.107.243.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P1qD/Uu9stYfg3LL9QK1a5GBo25h2psuDD2jpIOcYC91/shJJVar648ccbkBGgzZBwD3uTE36gs/8ibMoCfeGCkCpHhrqRbglJlyHgGjly/Gt0UNzBMw+ett2TIYB4hIqm0iy6uWU9kPXkXKIGOgLnmhN8BwcWgZ7kw3G2PDmyv5CSOHE4QjpdqU6yjyEoP6j4FTsZ22b+0KFLlnZ08vhRJBmHJAL+6H3MNHJSx34qetQcjODqZzlbKKKnB63NStHoFlnjdxNIwXckbxO9jj1I/HTVkO8mALPvrVNnfImCgXZvM4ac+gkLMfUw4VbO5NSOsry6q4vMoMiiAs2UhGGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8hcsA04RFB5Kmp3pRbzgoZO1xPTKf1808hkPI/flOm8=;
 b=Umu4ywZhjwRk14HeBXfJP6Ht22E4rIXvjNkz7y+DxrLBAkhNcDO3csb3Tj52UrwMq4r+b3CJ0owxr8QRkk/PCxR+jM0DY6QCPz+7kEktFE4JzSrz0si2CNvcSdcDFp3Vbk48R9RfV2iWH4QJIdCvWFxNcgqfxKYvKQ0j6KTN4nbwmlsOQcpHepRyXuz+XkrzGOGTxo33rhmd4ZnGz8QfpZUu4NTRSSMFXHFKxAwlhQWPGMHC3WeQOALwX4PCHS3patyNCcaw84osm3fQpyyFaAxar1eRbTmbXP9mcN3f/qFV4hNXew5o79bmrTw6DD8E5Q0LXcGapJ3gjB8p/uETOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8hcsA04RFB5Kmp3pRbzgoZO1xPTKf1808hkPI/flOm8=;
 b=A5I572XG9YslMF2Or5qTCGZ5z87i1byqtAtFZhJTX4RXRNcFXGliNDSZPf8bM5SV2HCb2Se9MRZvQSB7y3TdcmHy86at8jnp0JGIM0lciqMrV3UPfKYSnI3s9qqq0lWL9tdrS6P8sNK2nRA7BuGYfsYbu3MiWdrg3JytFq+xkrknQ5Y6unQtLaK2soWBdHhZoGTfbP0Y0jUhKqkIediXbpemExMJ4k6hJ6hlmLl338oqwCNsdHtP0WlqdIi03S2JQrj4PH3wj64yZ41ej2x4Q5aQluhvhvA3YS5+Izxm1neO8zaFAQInR1SvW6d9AjAo/xqrBYa9Jwe6F3k29M1ryw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB2667.namprd12.prod.outlook.com (2603:10b6:5:42::28) by
 CY5PR12MB6084.namprd12.prod.outlook.com (2603:10b6:930:28::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8511.17; Fri, 7 Mar 2025 02:19:22 +0000
Received: from DM6PR12MB2667.namprd12.prod.outlook.com
 ([fe80::bd88:b883:813d:54a2]) by DM6PR12MB2667.namprd12.prod.outlook.com
 ([fe80::bd88:b883:813d:54a2%5]) with mapi id 15.20.8511.017; Fri, 7 Mar 2025
 02:19:22 +0000
Message-ID: <de0ad55d-3042-4bea-9b76-b74f0bdb45cd@nvidia.com>
Date: Thu, 6 Mar 2025 18:19:19 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 41/49] x86/resctrl: Move the filesystem bits to headers
 visible to fs/resctrl
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
 <20250228195913.24895-42-james.morse@arm.com>
Content-Language: en-US
From: Fenghua Yu <fenghuay@nvidia.com>
In-Reply-To: <20250228195913.24895-42-james.morse@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PH8PR22CA0012.namprd22.prod.outlook.com
 (2603:10b6:510:2d1::8) To DM6PR12MB2667.namprd12.prod.outlook.com
 (2603:10b6:5:42::28)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB2667:EE_|CY5PR12MB6084:EE_
X-MS-Office365-Filtering-Correlation-Id: 9efcb7b3-7045-4b06-90c3-08dd5d1e7977
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dDlZVituc1NjcU1mcWJPcWN5ZElUcmN2WXp2WU4vcEhTc3ZISVVmR2ZGNlEw?=
 =?utf-8?B?RzBwTStRM0VSMG03NmxXclYxWWtEdE5pMzU5bUU1Mm5CUGtHK3g4RlhRT3Ir?=
 =?utf-8?B?MVllLzlRVHY3dUlwU3lsdmlhcWRrZFBsOXdaNk0vQmM2a1pYdUl2U285NmJ4?=
 =?utf-8?B?RitwOEREaEpVQ1BpVGxEc3M4elpwM1Q1V2E0ZGJtSkhuWXdLQ2cwWCtDcC9N?=
 =?utf-8?B?ZWg3NUpjRWVBcVRNY2dNMVdKUnV1TG5Kblo1azRZMFBtYTRMLzQ0WVI3QXEv?=
 =?utf-8?B?VDlLV3IzRUFnZEZHMGI1OTdMcTJTWDAvald4K3hlRDcwQU1SYWR0ZTJCM0ho?=
 =?utf-8?B?d1BhdlJXS0hHaG45Qkw2TkZVWk5SZnZGQlVtNCtIWElnMGM2M2R3S1VHbWdN?=
 =?utf-8?B?aGc0YVJTd2RNdVQxNzZHb1J1bUFPY0tqbm9QL2d0MnRSY1Nqemg1QVUwMS90?=
 =?utf-8?B?WFpOclQvTi9RRDM5TVY3OFQ3VmVRTCtMN09TbU5LV3lxdVhraFIrM1ZFM1M4?=
 =?utf-8?B?SVI5K0NHSnRXcXRSMHdEb1NQdGQyaytNeFBPb0UvenRYU2Vsd0pxa1Flb01G?=
 =?utf-8?B?K1RQclBIbnF1UXBwbVBMTjVmd3R1RGhUT3RKaXRPbXdRUGdraFV4N2QxWEVX?=
 =?utf-8?B?TjRyZjhYTlNiYWRQVkl1V09Ra3FaYVlhMkhRbjRqM2ZuSTBoYTZQKzRRdnFG?=
 =?utf-8?B?RmtXRVJCRnRGYk4yVndrd3pGa0UyaTRTeWVtQkU5UFgzN0pPSCtiZjJtMDBJ?=
 =?utf-8?B?OFpUVHBpZXYyTFE1UG1xUTJ6Q0RTbm9UMjl3THlKS1R0WkQwZnJWNEo1bHhy?=
 =?utf-8?B?NG9udDFHTHNYaVV4VExQeXkyWDBwdTVXL3RYaTFsajBPUW5ibDVucDRLcHEr?=
 =?utf-8?B?aHVoQTR6UEMvQjlkOTJJL2tvZE5xakhLNTlkWldWZ29rODQzUWZPbzcrN0Jn?=
 =?utf-8?B?bUFKMzBPNTBUZ2RtQ2xua0hXMEI2Y1YvUWJsclZ4azRaSGhIM1NYNCtHUEVl?=
 =?utf-8?B?WHYyNzBtakVqT1orVkVrS21qaFhnNDNRdDBtMEFVd2UzN2lGVlllVmdnY1FU?=
 =?utf-8?B?OTU5aVNpTG1KL3BRV0VBcWRjaU5SM25qS3FtamxsaWJ1MVFhTlRVOGRGVkFX?=
 =?utf-8?B?MnBDemVhTkJDUC9sR1k0VFdnclFhaFE0VStsWDMxSDRRN090M2c4OFpkMkpJ?=
 =?utf-8?B?NDhNbURoQ3JEbjlScEJMd2pZbDl3SHdpVkJRdEtmWlhqclk1dXJaaXh3ZVpN?=
 =?utf-8?B?Tm9FUHJ2dUR0djV0am9zTVo0TnZLeWRMb0RuY2FWTUN5b1hzalB5cUxocE1K?=
 =?utf-8?B?aW1WUTQwcXJZNGJWQW1TdWV4dW9vY0RhcmNoTHF3NWRuT3dsdm4vU0E0YmM4?=
 =?utf-8?B?ZG1URWNKY0NKbjlUK25PKzhQRmMxYlpJTFhVTzMrU3c4OW40bVQzMDlVbzZ5?=
 =?utf-8?B?dEdBSy9tUnFuTjZlUnBwbkxCOXlaZWJYK2Zpam9HNENmOWJUSDlrTk54bDBx?=
 =?utf-8?B?ekF1N0hWY0daNGhaWGZzZStpVFJ2K3J5dnFDZUtHOEhPVll0VnVXYTRxL0Rn?=
 =?utf-8?B?K3RHL1pFak91SDZFejR1azF2WVpvUDNNVjRwWmhVTDlkOVd4bEpjVS9kcndr?=
 =?utf-8?B?MkJtbHFvOEFUZFJUL3ZhaTF6cmJOUzIyTXdheHdiNmJ4Z3VkUnhVQkhDY1Nx?=
 =?utf-8?B?c2xucE1MMmpYQk1FT2U2VVBCRzBsdG9CMHVkNitSdzViSkdCRWlIZE5lT3o5?=
 =?utf-8?B?d1FjWjZ4Z2JpZ3BuZ0JNOG5PczBKL3VNRXJKL2IzZk5NaldPMmhvbHIyVXBH?=
 =?utf-8?B?Tkl0WTBuSk5ETVUyMVN3cHMrMWw1UDNYUlpXNUF1L0FkU2txQzNNZkloVnMv?=
 =?utf-8?Q?wkIAYqTrQO2LC?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB2667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZlFXVnFJR25pNnlCbHBoZFcyeWRFV3FHUThJcC82bGFvSDZpTTFUajhuR0sy?=
 =?utf-8?B?emFrWVY1OG1HN0dDVkZOV21wN3AwZld5YnQ5djZtZHJnMG1RL1hsNnlLSXI1?=
 =?utf-8?B?SWMrUlZXdmFFdE9MMGlacE9TRlpJWE4vZ0grKzA3T1pQU3R2Zk1ETzNGL3dk?=
 =?utf-8?B?aTBPSFRzSytCTVh5ZEMrZGxZSFpxaVZGbXQyRXkxMDFwVmJCNU91ZlFGTHhY?=
 =?utf-8?B?V1JHK2UzL3FiUEdCcXRaSUFPUXNsQ0F2OW0wZUlxODZMay9mdW5HbHZXcGtF?=
 =?utf-8?B?Z29oMElyMTlEYk9HRUxveDRGN2VsdUtZZUxGSG1zWmRYZmdMLzVCRlhBWnd0?=
 =?utf-8?B?NCsxd0g4ZnhaYW5zUTVMVkxFOTNIVFV4WExsdEFaOXdsTUg1RXlFUjhKTHJG?=
 =?utf-8?B?Wk9SUWdtQzBKYytVbHVRaEozMy9nbkFaeEZUVWJ1UnNnWjF5SnhSQjlFZG14?=
 =?utf-8?B?K1BqUHR5c2NsMjlPbDUrRC82Y0FmRTFXWmxVbkErVEdrMS9uR1JUbDFRVEFV?=
 =?utf-8?B?SzN1eVN3YnhJVEd1MFl3eWM1dmdoajY3amFvK0JpeHRXa2VPTHZ3ZTE0YVM0?=
 =?utf-8?B?cjN3MVdyZmwydkY0Y3BCdXp6UEdWckxoSUdDTlExeWozc0R6bHBZRGo1NHBS?=
 =?utf-8?B?RHRqdWZtZzBJTHdreGFXZ1pvYW9qQUNzaHM3ZDVNRm9pVXNzWlBwRk9Fc0lR?=
 =?utf-8?B?Rk02WUx4SHozM09LeHhFNFFuYWlzSnhtODM5UlZTT2tJSDByMDJCSXlRY2p1?=
 =?utf-8?B?RElIc3FaMUQ3UkwvT292aDV3YWF3QTMzQ0NoOVNGL1F0V0FJSnM3TjIzKzR5?=
 =?utf-8?B?cTZ4c29nbDVUVVNpTjNyS21OWHNvVndObzE4N1hEMkNERDZBbkJUY2JYVkor?=
 =?utf-8?B?QVo1ME05TkI5TXdCbUJBM1NsNUF4MGw2ZUdrRUdua2l5aC9tcGU0Yk5JMita?=
 =?utf-8?B?SkJhQklEWmJpZ2czRkp6V2EyV1hab3dUYVlHNnNpc0dqSWhhMVNhWTk3Qlpq?=
 =?utf-8?B?TTBETHZwK1hhY3JVT1ZoTHhMcXJRTkZwRk9peTJxYjB6ZExmdTZSSUU4dGlJ?=
 =?utf-8?B?ZXZMV2dBbE9SanlHRzk2ZDZKTmhGNHBSQlo5R3BUSnozWjNyOUpmcHRGK3gw?=
 =?utf-8?B?ZFpVZGk0VFBmOUFEdCt5R1VSNW5JQkNHUmxCMllaeDdvMW1zeGEzT0dWNUZD?=
 =?utf-8?B?blBURm93N0o5eTE0Q3I2a3kwYnl6RzE2SkpKUjhVR2ZxZFlGR1RzbmVJc3pS?=
 =?utf-8?B?ZExEQUxoZ3ZUS3pjSGRZN1ExVm9OdWRuSEQxQkpnbHN5VzA1ZVVDN2FBL094?=
 =?utf-8?B?YTcwb2V5VnR4bzd2aFY2S0tYR0NYbGRQVUhJY055WDFMaVEzeGxCbTZwTE44?=
 =?utf-8?B?K21pOGF1MDIva0crNVhCcmw4UnVaZDNnbHVFUjl3aGVXRHBVck9YQUZMcU5K?=
 =?utf-8?B?UHd0VEplbzVxZWh2c2ZsSXB1Y2xlV1NXVTBqLzNIQTBLVU10YXVoUTZmeVY3?=
 =?utf-8?B?bjVSOG12V0w3NytnWE5XVmg5YjJSNWY3MmhQOFRvc3NWQThZdVpja1VhaVoy?=
 =?utf-8?B?MElLcCtBcWJTMTl6ZXI3MGtXazNjM3ZseXpKUEx2cm4wUllIM2NOK1MxMm9C?=
 =?utf-8?B?SGRPU2txWS80eVdjczVZVHBycTBLbmFZWG9oVTlUb01ISVVDQlZaRU9rUlVq?=
 =?utf-8?B?S01zOXJQdWsyR0hjTCtMemdQRm5DM1NMa0pEVzZTWnJHb3Z2NFhGaER5R0c2?=
 =?utf-8?B?ditwK3k5WVhhWkNQL29iYkRLZXoyUklZVWR2S1cvVmVkTWFyU2ttRVNDclgx?=
 =?utf-8?B?M1JUTlJ5TEdvTnEvclRMNUt6alN2TzN4T2cxVHdlYUx0QjU4V0JLd25JRXdy?=
 =?utf-8?B?dEJCalJHeGR2UG1aeDdPM3pQaXp4ZVJRUFFWcVJEUmRZczBiS0ZpRUxKMUt3?=
 =?utf-8?B?S1c5UGsvRkRacW1SVENJWHA4Q0xlRUpPWjJzQjRJck54SGVQMCtScWJVMjEy?=
 =?utf-8?B?UjU4UCtWTG52c1M2dlpCUDRpNE1oOTExRGxvUEFjTTQ3WXprZmpjL1YzNG1m?=
 =?utf-8?B?L2NVSGV6b2lVSFpKajN1TE5PbHA0RHRmODdQdlZKQzZCbkdkNjNzdytLM21z?=
 =?utf-8?Q?OjN2t6locYonKIzlcWODQYhcw?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9efcb7b3-7045-4b06-90c3-08dd5d1e7977
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2025 02:19:22.6426
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5N5Y7abC3gj4wdiCrnwuKtVS1zN/Ok1t6vF+QOPDxi3hcJW7Hj6DAXaLUVOajSWOny5kX9ntVhhTQYx0QEs+DA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6084


On 2/28/25 11:59, James Morse wrote:
> Once the filesystem parts of resctrl move to fs/resctrl, it cannot rely
> on definitions in x86's internal.h.
>
> Move definitions in internal.h that need to be shared between the
> filesystem and architecture code to header files that fs/resctrl can
> include.
>
> Doing this separately means the filesystem code only moves between files
> of the same name, instead of having these changes mixed in too.
>
> Co-developed-by: Dave Martin <Dave.Martin@arm.com>
> Signed-off-by: Dave Martin <Dave.Martin@arm.com>
> Signed-off-by: James Morse <james.morse@arm.com>
> Tested-by: Carl Worth <carl@os.amperecomputing.com> # arm64
> Tested-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
> Reviewed-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
> Reviewed-by: Tony Luck <tony.luck@intel.com>

Reviewed-by: Fenghua Yu <fenghuay@nvidia.com>

Thanks.

-Fenghua


