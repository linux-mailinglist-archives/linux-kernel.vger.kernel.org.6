Return-Path: <linux-kernel+bounces-549951-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CC90BA558E8
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 22:38:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 14DA3188BAF0
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 21:38:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90F08207DE0;
	Thu,  6 Mar 2025 21:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="gKqi3nj0"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2085.outbound.protection.outlook.com [40.107.237.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 584BE1F63F0
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 21:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741297083; cv=fail; b=b4wlunkQONZKdSDfMG5fIy6jvvGzQdT3o8gW3DFe9s1XlSbPCg0z9eF8ZA8jQ157SV9ItQGHVSCdGlQdMCqrC0y/LLD3swF3d9iR8BXxy8zN2ML6Uw2XH/3bLLNrPuFpd7e8eJwf0WlBl8ETj+GiALOt2dFqGBZAxU5xITU4wMk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741297083; c=relaxed/simple;
	bh=X9zeRrqJpFarCrKqSMzq9tsfuA4NzVkRBKfkTsKduMo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=uXKBTGZxuw7/DnodqMSp40m1tERKdW4urYE4EhuBSLmI5djw+pItzcj6Pj7WrUuiUvQeOiydDWh9fwx1B7TVxiurOsd6wcoCafXyeEJBBvdxT86lHytAuI4Qeh9GdMn3fjqbbbdTFNi+Abo0J/pLJkALt4JHYSm12YBrN+wKNKM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=gKqi3nj0; arc=fail smtp.client-ip=40.107.237.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eFml8h6FhYY0SDlK40yo6hFjJ/F4Vt6yrjsBafyGFbV6tWcVuQCI24MEPx26yQd+CD6W0sOWYvpwnZEetbwwKAyN7XXcePO+jH5zirKRAN4imUseceCFsgAYRv/wtntR7a3sYc1yGEmc6a28ifSi6j6Igh/SThtFhAO+y7+SnMzow5ppg8WeUxwdgyCl/nGCIskeTwdBEoGqGqHu7nlPRSZSoJySSVril6Xzl5C/8ggIJvV6QjuO+dCLs3dvZ61/Ld6aexzJDajL8+s/cO9Kr0CBfaGHPH9CzvteEV/23UWtde55HetMUDEtz8lyH/+qX/RX6OAnIRVsYA5z2Iw2YQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X9zeRrqJpFarCrKqSMzq9tsfuA4NzVkRBKfkTsKduMo=;
 b=N5APYxcnsfGs3EmIFSqIC6JmB67+2oStGFetFuJrNHk60opGdDnpv3w9OGxIJHo4unmQIg6Xe7sk7EbW4TxgobwhQik8KzwZiw5jFeFeIFLPwdCSft6DUAJNDq886pz6JvWSV/zhM/c4SsYObaU/adWpVOTa5be2BHEd3TojycoF4BuRFIJWiILcRKrjR2Vm19G0hqCqFpjkLQ5GXTO+wYQGpyhAFROLUtM8DONignAz66DmbasUhngHyhtK3/KXq/44IfpnWcCPsE/8gVJir+gWFt3Hnf8Z9m/EMRI8hh9jvdVWaEPu6O2kg+7nSZttwB0WVyhDh0N/ga2+E0eMTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X9zeRrqJpFarCrKqSMzq9tsfuA4NzVkRBKfkTsKduMo=;
 b=gKqi3nj0jpmIewECOo9nr+NpeZpFd1cT3czrl/GOsjVw2Sl6uVlU7/a/gPbv99liuGt79DkSb7H9qmZAI+1UYCdh+Np36YVSCQ1K2AHJSugKAhOxGN0rVVbHbBesyDVHkDHR5ZEHUk3Yq8N3eN6F95YLhU5Fbmzvw22jgBJjQYu7Fp7tgB7dJRaS2rRw7rTaTN9BFbHNkdOaepF6MTG6a8Fps32wxMzou23qT1zd2J4cy00o1yFgdER4cG7ST+ZGI9TMt205mI3wzmVnhmLOlJ8GX3GEcKY0AD6hOcKfBCBZQfVNFIuasOcTYL0ApEEw4bj1FDJo2sOHV2ETh00xzg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB2667.namprd12.prod.outlook.com (2603:10b6:5:42::28) by
 SJ2PR12MB7961.namprd12.prod.outlook.com (2603:10b6:a03:4c0::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.19; Thu, 6 Mar
 2025 21:37:54 +0000
Received: from DM6PR12MB2667.namprd12.prod.outlook.com
 ([fe80::bd88:b883:813d:54a2]) by DM6PR12MB2667.namprd12.prod.outlook.com
 ([fe80::bd88:b883:813d:54a2%5]) with mapi id 15.20.8511.017; Thu, 6 Mar 2025
 21:37:54 +0000
Message-ID: <e08ded42-0a94-4cc7-8042-7b893aef274f@nvidia.com>
Date: Thu, 6 Mar 2025 13:37:52 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 28/49] x86/resctrl: Handle throttle_mode for SMBA
 resources
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
 Shanker Donthineni <sdonthineni@nvidia.com>
References: <20250228195913.24895-1-james.morse@arm.com>
 <20250228195913.24895-29-james.morse@arm.com>
Content-Language: en-US
From: Fenghua Yu <fenghuay@nvidia.com>
In-Reply-To: <20250228195913.24895-29-james.morse@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR06CA0018.namprd06.prod.outlook.com
 (2603:10b6:a03:d4::31) To DM6PR12MB2667.namprd12.prod.outlook.com
 (2603:10b6:5:42::28)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB2667:EE_|SJ2PR12MB7961:EE_
X-MS-Office365-Filtering-Correlation-Id: be10a9c5-d27e-4c9d-5162-08dd5cf72767
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WGxpT1lEVHd5Q0Rlb1ZpTnErMHlWdkNUNUtVbkFZWDFhTWdTWWRGeENjSVc3?=
 =?utf-8?B?bVJUWWtlWWYwdzBRb0poZStodXJFUWRHb1lwL2hjMmtSWXVZZ2s3UHB0cmVV?=
 =?utf-8?B?bGY4d3lJZ3dKVjl2ZTVjRllxNDVUSFpPTU9EOUhFMm1Vdk1Sa0FINTRMOCtB?=
 =?utf-8?B?ZUJNU04xbUN0Q2NnbGpkZ2IxTnZNMUxzVUhLbXBQb243OHpZY1pnMGg2VVpk?=
 =?utf-8?B?cjJOTGpWRm5wTDkwNlVDVW1DUFNkQi9sM28wb2p2NWdSWTFYbU5HMnNjZ3VC?=
 =?utf-8?B?TFJraGM0NzN0WHlBcWE5WTE2Z3FFMU9pSVZ6OWQrYjN2OU91LytFaXRGMzlx?=
 =?utf-8?B?ZXcrcXl3Z1FFay9VSStSYjBTU2JWU3ZmOStRbmxpR04rdE45dHFtYXZUelBs?=
 =?utf-8?B?aHFpVmZ5amtjdGRZT2xFbmlzUkhmb09PNHlDY3NVZk5qUUZBeG1WWlgveHNG?=
 =?utf-8?B?SjJLVStONUp5djJvMjVPcWJEenl4VkhhaitKbTlIRE85M1hOdnpnWm5aaVFx?=
 =?utf-8?B?U012RlErT0tlZzcxVHRzZlY5SUtzMXFVQjVFK0ZCOVl0eGZVRHZEOTJEbmFO?=
 =?utf-8?B?OTNxSkFNQUFlcUtwcVc3QmxqK2hNMmVoN3l1MzZGOUdEUk5QbXFXNFRyRWY2?=
 =?utf-8?B?aVZGNmgwcG9jc1NidjhvTUI0OEdGcGpTaG5YRFl1WXU4aDIxU1llZERnUlhU?=
 =?utf-8?B?K25BNUljODBLeGkzeWJQWmlmSEJJampIcCtaL3BkbkFJWTI0OCtxMmRNb3pU?=
 =?utf-8?B?Wnk5TnpBeklWU203WStmUFhjQVY3Tk9WREo1NVhWTUZKVFdzSk5JVEdseUI0?=
 =?utf-8?B?TlorUmx6cTJsYnB6US9FUHJDaTJCVUEvelZqSnRKVlRVM0IyUlNtS0pXZXd6?=
 =?utf-8?B?b1dYZ1NRTkY0Skc2aWhBMTc3Wk95Y2pwK05WMzVWZUNDL3VpbVZkTGYzckI5?=
 =?utf-8?B?T1ZtL3NjaFQrVXkxR0I2UXJEWWUvOUsxdUc4WndOS20yTkxrUUo3RFN5Q3Nz?=
 =?utf-8?B?WFBhS2xHczhiSDBCcDhIUFlacFBNVEZGNHFNaHdmNWdyajF2NE1aRlUzdXBT?=
 =?utf-8?B?UStLY2xXYkJuOWtSWHFEZkdROUdubUJnSGtxU1NySVVrZ0NzWTRTV0dTWU9n?=
 =?utf-8?B?N2tTcWNpRVRKV2tLYTRPY1JpTmRFRUlkdW1qQmVYZzRYWXBIQXRGWnA0K0s5?=
 =?utf-8?B?OXpIcmlNdTZVMTVFcGU4S3IreVkyTnhaa3pRM254c1lYL1dHNUh6dDNZbVlT?=
 =?utf-8?B?VlN2bS81Vitqa1R2YTVXM3JwaTdyZzdFZzlMemUzRHYzdHh0SE1jRUlkYVkw?=
 =?utf-8?B?cUpqbVdEUUFqQWNPUnFTWFVjKzZZMVdQNFJaNFd6clB3dVZ4cmNJcVg1RHFt?=
 =?utf-8?B?eWFrNkNRMlFob2tnMGl3RjVwQTFrNjBMaC8wbGZGaXhxMlUyL05DaVVtRHBr?=
 =?utf-8?B?MHNtRFhNWVVXOTlpb2lGZWVCMUNKbEh3a1AzOHdpWHd4eFNKTmJENHVxVm5a?=
 =?utf-8?B?UkZmWkJodG05TTlIMHdwUWhIWEdOTGZMemRzVzRTTW52Y3hDTzk4YzVpYUtC?=
 =?utf-8?B?RmZVcGc0dTBscEtZWlM4QWc1K2JNaForZk1GZzhDR2ZWcG9YUmwwZ2hEeHd6?=
 =?utf-8?B?cVA1dzFXYUlQUUhKNkNTZ0NETmd1Q0xVVjBSOVNMVzRaMmVhZE9OL2hURC9M?=
 =?utf-8?B?d2c4SG5Eak1saWtXaVFBa3o1TGVuMkIvOVZGTjhiYXdUcmxDclQ4NXVPd0ZO?=
 =?utf-8?B?ZW1SeFJ4Tkx4a0k5MVhDMXRkcmt1em8rb1UxRExIVHRUMW4zcVNTdjhUT2Yv?=
 =?utf-8?B?RFpobHgzYVoxUHF3UUdyQmE5THNjMUowd0NDU3NGQ2dVWFpoVE16NndhQjIr?=
 =?utf-8?Q?ZvOPXkREsMWqs?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB2667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bTZEUkJQZGVTS0cwMmVMcFIreFB4cWQxOEtNREQvNHkyVWhiZjBLK0JPSUJw?=
 =?utf-8?B?a3J6bFphamE3YVFkMVFhNU1SbHJtWkNnT0pIU08wbW4wK1hhZVlKUW51R04w?=
 =?utf-8?B?ZGg4Tm9rdmVFN2dyaGR0WWxKMFY3OHBtcXZLYXJpb3huYnV3enlMNHluZTky?=
 =?utf-8?B?V0VXWWRaaFRQdTBJY2VWZG9STXptNk1QdWtSQXZzOTRSN3A1bFdXK21oT1lB?=
 =?utf-8?B?RXp4cDFTSE9BTmNwckVaSSt5WDhMVnpYVGF2M05SZThvSHpHNWxwMmdWV3FH?=
 =?utf-8?B?RlJ5SjRoS0pNV3FrMEFYV3JDakQ0d2d5d1kzNXl2WmFTdzJ4OU9pbDg1T0dC?=
 =?utf-8?B?a0dMOEswbFpMUWJRUFIyNE93U3lpR2Q1Z3dVU1oyOHE2alFobklFWW5Td1ZL?=
 =?utf-8?B?ZE8zR3NmckU0RlZKelRMRVUvNVRFWkJVQ3F2Z2U1TWVIRFBoSWNoaWswV2Fk?=
 =?utf-8?B?TmpWYXV5UFZySGx6K0hhMysxZnovNFBWQkVjOGVBaUZlVWJrUzljaTAwbW9q?=
 =?utf-8?B?cmRWemlGditNem1hSTA1aEsxR1VaL3R2TWZoSDVWSDVHY0R6SUY4MUhreFRl?=
 =?utf-8?B?R3NUY0VIbDI4MWxDUTU5YVhmNU9mcFRTZktxak5hTlNOY2NrcGRrVHFxSEgv?=
 =?utf-8?B?M1V5U202UTFUSkZVUTBhOHRFR0FETjNUa1IvTVhvNFFQN245OVN1MllUaGl5?=
 =?utf-8?B?NkRHTjMwRTNGb2RZeFZKNjAvTzJGbmdLM2pKZzVNZ1VDNnFaSys5ZTlTakRs?=
 =?utf-8?B?TjhVYjRUbzBSbmJwcGY5bW9yTmJpb2lDejArSEp4a0JTZ3RuQTlmOUtaTUM5?=
 =?utf-8?B?dXNVUlZIUTdvN0xSYmNibzIrMWt4SVlkUlRGVk5Cb0JJVnVsazltVzdrRnd6?=
 =?utf-8?B?eDlZNUVSdzMyeWFsaDRWNE1lK25nb3B5RnNiek5TTE1xZlNWSU45b2RBZEZj?=
 =?utf-8?B?eFRnc1ZOektHRjIvQmxZT09NK3RKTE5mVHh5RERZTWdjRE5JTUk3MWNKdUkx?=
 =?utf-8?B?RFgrSG9mOUlaRFM2V1UrZVJWZDhmcS84UnBqcFlETWdzOS9xV2RRK1N3MkV3?=
 =?utf-8?B?Q1k2MGs4bW5rYW5SS2dWQkQvbjJsbGZEbGNWRS9wOGE5cVVmb1VuR3JKcG9T?=
 =?utf-8?B?Ti9IUlZNQWkyODh0ZlNjRXdVK3FRaFpuV29oY0xVZFp6d3ovekZaMWo3L2U2?=
 =?utf-8?B?TVdWYm9wT3dScjZjcE9Rc0tWb25INFRpYU9XdnRWbFdhU3pZbTJ4TFFWem84?=
 =?utf-8?B?WDVsTnNJRU16RjdEVkZjeE5oWERBY2NBSWRuWjVqTU9LSno1TlpUdTdTc1F5?=
 =?utf-8?B?Rjd6b0xGVDcyZ1lpcHZWbGk4ekc0c2NvZWpSclVtTHBGUEJmdTJyZVBlMkJS?=
 =?utf-8?B?VXRvM1krV2VTbXdvRDlmRjkrbjF1UWtQYUdpbUNXTGtqRHNyOVpOMDBxZ2w0?=
 =?utf-8?B?SkIyTDA5ZkxqOVg4RFN2WVBNQ0hGNUQ5OUp6aWFFSmdib2VlVFUydWZHYkpj?=
 =?utf-8?B?T0F6aXVUQVlnYmlmNkRNaTVya3NRRllQaEdaTkJrSjBzVEVXa0FJMG5NbWU2?=
 =?utf-8?B?YmJYSWFRWnBrL3JybUxXWHJlcWdLWjJLQWJjM3RYeE1ZNGlEMDJ1UzVmdERC?=
 =?utf-8?B?KzJUUUVOTVliWi9BM0Ntc3FvS08wTW1uNDZ2ajBqRDRTVC9zbTBaZXR6T2Nh?=
 =?utf-8?B?NG1ZTFM0N1JYZjVMQmgwWjZGZzZZSFQ3WXVpaVhNRlF1cXo3VStQd0hLOGNN?=
 =?utf-8?B?enZXU0pnd2dPWDdCWS9ZOTBJYTZEd2RneklsTk9OTnI2NTF6MTBKQlZNTCt2?=
 =?utf-8?B?WGY3SWlDaTZIaTA4WjJHQno4elVtbVlTR2ptSGl1MG5JTXhudUVSNWdVTFVI?=
 =?utf-8?B?OEgzYnFta2w1UFJDOENHdzhBNElMN0NKM1NYTXpLSzhKdndVMzVHVStaOUds?=
 =?utf-8?B?SEZYR0M1ZHJGRVVSc0F2MzNoejA0cUJXZTkzYzVTaEs0MHo3WGtuZmZEWHVQ?=
 =?utf-8?B?KzFLZmZtdHZ4Uk16eFFFSGhTOXRTYTRkWWF1SlpyMXI4aTZHQnJ6YVlTT3BR?=
 =?utf-8?B?bjZobHRCV2tJbzdISmJXeGZmckptalNEUE5rNTNrOXFrRU1XQkI0eGZxamNP?=
 =?utf-8?Q?Ft17yeg4mwBm1+fpzLDRH0kUo?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be10a9c5-d27e-4c9d-5162-08dd5cf72767
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2025 21:37:54.6219
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tCcyFgK3FHb8Lbgl4dJ6dYS9TEEVoPLIVi/pDkXsl9aChx3UNoN2XPOUg1PtWnh0OVd+hyPek1S81pGPr6ll2A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7961


On 2/28/25 11:58, James Morse wrote:
> Now that the visibility of throttle_mode is being managed by resctrl, it
> should consider resources other than MBA that may have a throttle_mode.
> SMBA is one such resource.
>
> Extend thread_throttle_mode_init() to check SMBA for a throttle_mode.
>
> Adding support for multiple resources means it is possible for a platform
> with both MBA and SMBA, but an undefined throttle_mode on one of them
> to make the file visible.
>
> Add the 'undefined' case to rdt_thread_throttle_mode_show().
>
> Signed-off-by: James Morse <james.morse@arm.com>
> Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
Reviewed-by: Fenghua Yu <fenghuay@nvidia.com>


Thanks.


-Fenghua


