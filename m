Return-Path: <linux-kernel+bounces-549931-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4470A558C3
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 22:29:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D89783A41C8
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 21:28:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6A572517A9;
	Thu,  6 Mar 2025 21:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="YPCcUoes"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2089.outbound.protection.outlook.com [40.107.244.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 255361EB48
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 21:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741296541; cv=fail; b=fPN1yVur1nEr6KyXT2KsX70IYFZy3ozoEf+hULgEfjRnoEprbCf1COGiRDJc4SMzcAUIpq0GDgFIHGpulkzelfc06phck7kEo2ZvkJiVrCMI4xNiwC36gT+otoCluLSstkQuGJiX4RouCPq2UoPs5YXl7tsWgYRln30wmkfLQYU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741296541; c=relaxed/simple;
	bh=reKplXFHpRthiDIGk2lB0k6CAsPsg5qqFXYAPOS4h6o=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=N8oyO7IdEHMlTP7SpfZ2M7cfAmJvkqtSxUFtoFu2zMdR5P88eeKaZ+E1fWaMPzPhy8qIigm8pMBVGjZGQBaWcLPQIBPiXqFxJvTwnLTA7QP+i8gWBG2CjxGAJw2B4Sz3iB/mI1nRRQuQnh/PsSEDJAxqVfUkQIYKi5MkWkJW1xA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=YPCcUoes; arc=fail smtp.client-ip=40.107.244.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pORvbxBMEVh1lYTVXyBKLTd/dAoLw7IiKRyoLMIXvCfB3QxE0pEMhU1PQ55WjZ17a4tbNaaQkv0WsGxiydU2jptgwvieynOfIAHzhE1lh9/iKjCq406PIhTYCaW48LQeepUHZf3jeldRyWtZ5ovIjEkdDyOV/jX+JVlm2y7q/Yb5TTrTeV2m4zct+cZKAbIe53lNP/GlFh5Z1tZMZNa37EMVkZgA7BBgnJwQTd6mZn/7xm+TCYWOVugC/K0MMsYhQGs4wD73/Rst4wsqJoz27TUkt4X6nHFKCTL2c7rJlmF53WlZSqs1JkHpcpMh+ixe298LzjxEnp7cLmNZI1ULSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=reKplXFHpRthiDIGk2lB0k6CAsPsg5qqFXYAPOS4h6o=;
 b=YqMWK+VJSf6MOOFjs/Ff3hDqF280bWDwd/e51Judrka1EVeJspwWh+U+jy+L0t4zLiTQLhbQGN7dPpxDk/pQbmb2VSVnIk6TLMvL7lenNQCjKEKGMscz0llspjwuBGISGRiCSI0587/10DMc0Lu9PO5q8g2qsuF2QKMnFKcsclpgHLp0qoLf1yHBVq6slcmdG6TAwrZI4njFITMQKlBEpRD5onb897LE2ppUJmvdSCBK1MUp5fCEKsXJIu04gHtYqdMJ2JbnhmfS8S6DYy4f4ix89Gpu9IFMb+0UPyG2/+rxVwMDMnB7yLuZwpKpt4am4aZBbvVn1t4Eq27/avcqng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=reKplXFHpRthiDIGk2lB0k6CAsPsg5qqFXYAPOS4h6o=;
 b=YPCcUoes/j5XAlMiu5Z/JqgFHnpz0+NhbaOQVbtH844Y4uSR/C3MdBevNQB0OxZZG79mQcqeaA8SunWlmIFkz7s8nkwt3Iix8fLtZbWDwrPrHSGT5dYh+8vFeo/iUtdV7iP2VUFK5mTNyaUHRrT8B83Mydy2gdvIMkvKEiIM3wQTDFrHzGikK6gxDf1Tdenc8aW7MvPubos42TcdgKA+tbjJ/UnJnonnWqgWJrnID+nLm76sGL0DFHI6rcKDLdP6bxO+ae4O8VJNGqUHgjE0+5lDA7bRHF/5zSKNB8EaLwYlR/ty7yXrW1XGw5M9oty35qeZPp3wJVZxLrxb7zje3g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB2667.namprd12.prod.outlook.com (2603:10b6:5:42::28) by
 SJ2PR12MB7961.namprd12.prod.outlook.com (2603:10b6:a03:4c0::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.19; Thu, 6 Mar
 2025 21:28:53 +0000
Received: from DM6PR12MB2667.namprd12.prod.outlook.com
 ([fe80::bd88:b883:813d:54a2]) by DM6PR12MB2667.namprd12.prod.outlook.com
 ([fe80::bd88:b883:813d:54a2%5]) with mapi id 15.20.8511.017; Thu, 6 Mar 2025
 21:28:52 +0000
Message-ID: <b8a22d03-e32c-4e7d-b35c-f5ab94995cae@nvidia.com>
Date: Thu, 6 Mar 2025 13:28:49 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 15/49] x86/resctrl: Move monitor exit work to a resctrl
 exit call
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
 <20250228195913.24895-16-james.morse@arm.com>
Content-Language: en-US
From: Fenghua Yu <fenghuay@nvidia.com>
In-Reply-To: <20250228195913.24895-16-james.morse@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR20CA0007.namprd20.prod.outlook.com
 (2603:10b6:a03:1f4::20) To DM6PR12MB2667.namprd12.prod.outlook.com
 (2603:10b6:5:42::28)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB2667:EE_|SJ2PR12MB7961:EE_
X-MS-Office365-Filtering-Correlation-Id: b848653c-3eae-4d9a-c8cc-08dd5cf5e3f9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MHVnTlJzUktRdEZVeWhzbmZwdEdGVGk5U3VibEVwbW12RlkyV1gwQXU3dzMy?=
 =?utf-8?B?VFNmQkR1U1RENE1ob1YzZktEekdGbnM3ZHo5d1lsWlRXaFZhSDVJRjJvbG8v?=
 =?utf-8?B?VTYvYTFUdlhIcS9zUzYzS2dKRlUzZ1pHaXFMT1UxYklSVEZMd2NzTDlnQXZM?=
 =?utf-8?B?UUtHMjl6RFlDOTF6Q1E0MC92RFArbUFublZBN0svSzEweTBhc3F3TjIzSWZs?=
 =?utf-8?B?d1hXUkhRd1A5WnZubWwyR1NKUGhORGpYaXlidlBiRXh2a3ZKaUM2TDhLM2Np?=
 =?utf-8?B?SXRLaDRsb1dWc0FMVUhGZFRTVjlCSFRuOGFYS3djTlFTcG5QcTBKSFBDRzg3?=
 =?utf-8?B?UnR5dVloTis4ZHA1WFp6VnVBTm53UTBsMkUwaXBocUZBN1kyaG94aXlBNkJG?=
 =?utf-8?B?c0lHOG9BVEJaRFpFV2JEUWhaclBrSjN0eTU3QXhnNUovd1pwUDgyZmQrY2M5?=
 =?utf-8?B?NTg0NUZQa1hvWUJteXo1M1VYa01ic1NqYlZVNXZrZnIxVEpYRHJvYlU3RkU5?=
 =?utf-8?B?QVpSSVpBYkMxaTZ5dHFqZ1pheE1NaFl4TWkxeHREbUpERHdJK0txODE2SUI2?=
 =?utf-8?B?UVRrck1hWTArWTlMbEorRUFWVTJGYjJLWTgxTG1nTXkxY2NtY0ZlSkdxWnA2?=
 =?utf-8?B?V045UVp6dmJIeHBvY01tYnRHaUZTSGEwREhDTGN0eUNSMGpnUHVpVEg5YTlV?=
 =?utf-8?B?Tk85SHIyaStMcUNNUXFIQXBRajdQUzVwRUdvcUJpRjhQeVZMQlAyeE4rd1hh?=
 =?utf-8?B?TWRqbkJySGN6eXhqRjJzSDJKVzcxeW5kc3JUNzRTa05LN21WMHVqcDNTRHg2?=
 =?utf-8?B?Z1VLbG01ZjBSSVA1bTU3Z1pzVjRXSEVzUHBrVEdtY00zYzFCSHZaNS9QVUNm?=
 =?utf-8?B?QW9PQXJmaE13U2tQeWZtWXg1Skl1ZndmTWwrQnd3QTh4c3ZHMkxCTEl6Z2FV?=
 =?utf-8?B?amwzOUIwc3BpQ1d3R0R1Nzl0SWtiaE8xUVVFMVVMZUJKakx5QmJpajBTbnJp?=
 =?utf-8?B?a3ZDSElkVWR6TEE1RzBlYUJTTmhGMFF0UHB0TE5VRFJkYWhPZ1VSMVo4NFl2?=
 =?utf-8?B?akRoUlYzUzhwNmpBYTlWbkI2NkhUR0pNc3R1K1d5M3lmYXU1d0tlbDRUcVZt?=
 =?utf-8?B?aVJMcUcwazhCTnk5cm9IZDR4cU9FZXdpMzUxWkEwbllCZ1Fkb2RRd2MrazV0?=
 =?utf-8?B?QzhxMTNmaFR3V3pMM01GRjlHKysrZldlMHZmR3hOZXVRd2ZVRmVFdmNyK1ZZ?=
 =?utf-8?B?Y3YrVDE5WUMxTUE5YStYaURrN1cyNlRESy8xNG9RWnIrWE93aFRGY3BWM2RH?=
 =?utf-8?B?MGhJcmluZ01pUmVFT283YU9ZVitTK0x4b25nbzhsUjkzQy9lNE9KdnhZdmdY?=
 =?utf-8?B?NmpIVCs4My9FZXFyWE8yNk9MQWUrKzd5Y2JiRUZxcWV1dkdnK2V1UDdVd0xy?=
 =?utf-8?B?azdYcE9PZGtCRHg5Z3V3WXlXS1ErckZuZkRNTGpKaGJuaHRaNk0wK21MYTRI?=
 =?utf-8?B?REx3YXlRakxUdDRQUktqeDhoa0pBTjhMeStyRE9PU0ErVUVQZnZRQXpRc2wx?=
 =?utf-8?B?bTZBMzVUMjNFR2V6L1BRTSt1QUUxTXAzd250aFc1U3hzS3dQdkFCcFMwd3FZ?=
 =?utf-8?B?VWhYSDc2NnBTM1NwK0kvYzU0a2tBRDYwZTZxenhYOUVYOU1mR0Jzb0tVbHZh?=
 =?utf-8?B?WU5NTDNnWm1ZMWl3Wm9mbGlRcm84MW0ycjFrVGR2R3ZqbTRVYWM1M0MxWU53?=
 =?utf-8?B?YlQzbnFzejJobWE0TldGaFN4SEZmcHpmY0twa1Q2blYzT2RHOGsrL0RiVi9h?=
 =?utf-8?B?NFN5MEEyQzJRdWVIeU0zcTF5Zk5JUUdpMzd2OFNzM1lyeXVXdmd1OWs1c3M4?=
 =?utf-8?Q?FtOS4RpBtzf5d?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB2667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VTkveGtGS08rR0pNZHNrZjZhUVhZQlQvbzN4REZOTm1nQjBJNjFCUVQzaE9j?=
 =?utf-8?B?ak9WTmZOU2ozeWV0eUNIRHVmL1MyeGloSFBKZ2krN0dER1RYSk9KVEJJUlU1?=
 =?utf-8?B?OEx0bnVPcjRPazBNT1JsaUkyVDcyenJXYXZmNk4yWC9mb3ZwTS9MT0x6dUFz?=
 =?utf-8?B?NGkyeHdJUHVFNmJyVUhoMVV5cEZVdk1xWjRUdGhxY0tTK1h5Tkg0QUVIbG4r?=
 =?utf-8?B?dUlFZmxKa3hTWFhMNU9xNTZaMTY3YWhqME1ZR083SVhIOXpHejU4QzY0azF1?=
 =?utf-8?B?QmFkS3RxUVBiaFZIdTE3V2pXZ1dNNXJiYjVBU3lsZGxtbllLL01jd1daTXpW?=
 =?utf-8?B?ZkJiZ3gxMXJ3OEpLNVFVbndlanM5RUdYYVdjeGQ3N3hiUzhqRWN5RTBPd3pv?=
 =?utf-8?B?NnU1TWkvU05WeWV0b0x4WlV3ZXJJV2hYa3k1ZTZsRm5ZYjA1QnN1S3dRcW1M?=
 =?utf-8?B?NDBlL2F6VW5VQ3pMQi82eHgvRFhTQzRtWEpxRFdaTEZDWkxDUHkvaENJVW01?=
 =?utf-8?B?R3lyWnJNSjYwc1hiSDdjcloxb3VzWUtWZDQwWEl6SEkwR0VRN3o0ajN5WFdk?=
 =?utf-8?B?Y1k0OE5uMDJLZjBSZWdmei9LTmxXbGJZMSs4ZXVtTUVkeUZwM0p0dUpqRnNT?=
 =?utf-8?B?aXNZWUNRNzNoQmdyTlJ3MFZmTTE0ZWJzTjN6eVA5ano5UVNuaC9KSCtleDEv?=
 =?utf-8?B?U0NvYkVrS1ZlOGYyTEhFT1Bmcmx2dTQrYS8vY3Awd3hod2JpZitTUTgveXdI?=
 =?utf-8?B?dGd3WFE1MXpzdWlsMU10S3l1ZEVXWnZGNmkySnlYR05WZTRnOERwcDJnUWtB?=
 =?utf-8?B?WTlGVDZpR2szN2l3QjhmTjQxTlhTWTBDUkFVUkNLcmF1QXNVTzU1MG9OZDJh?=
 =?utf-8?B?eHA0RnNmdGRNNTlBZ01uNmIxRjBMcGUxUFo5THF5c0pCcTBDdG9ROVEySGpM?=
 =?utf-8?B?NmM0VmNpMDFTMkNseGl1WWVqRjIxQXV2VGp0clVOQzA3WXRqeTN2dWNKL3A3?=
 =?utf-8?B?dzBVM2NUYlU0dFdmdFBoQ3g5RUJpdU9sSVJ4MUxSNzk2Y3NCVUs2VzgzTDJX?=
 =?utf-8?B?S0hsdmpiTSt0S0owbnl4cm5ULytzaFBpQ1pSSFNDSmtDa1pHaGF2a0RzUG9S?=
 =?utf-8?B?QWJFYm9pV3N6U2l0d1pLbDhqQlF0dHVFU01sOWRpM0Jna20yb0VCN0VmaDRv?=
 =?utf-8?B?UUNzMFB5TWhrWE5mdS9rL3FMLzliaXcrUEtqZDBEc1NlSjFaeU1Tc1VaR1py?=
 =?utf-8?B?UVJqSHd3ODVQbmZQME45cXNTbmhqSk92dVRLWmg2MnFWdVM2aVRmb29ISnFN?=
 =?utf-8?B?a3hzcVRIM3E5YzhzWkNnMzdHTTZub21RalQzVWRWcjJ6Z1ZNbDU4Ty9wUDZM?=
 =?utf-8?B?OHFLU0xrZ2wzYlZVU3N4VHJYUkd4SmFtVjdoYzJiakFBQTYxMjYxZ1lCTHR5?=
 =?utf-8?B?cUM0cGxnVFFlMElkZmhOMmVkZlAvdGVLVDFYS0hubkxpQ3o0VVRpK1VHVTl2?=
 =?utf-8?B?ZWU2R1hFU2EyQ1lVQlZsb0F1bHBqdVFFeVUwYVZpNGxJMmtqQkVLelRNTkZC?=
 =?utf-8?B?NER3YktQQkpLRnJESytickFnZERXNWVTOS9Dd1MyNHlja0FmcS8wVEptZ0Ew?=
 =?utf-8?B?OUJHUzFwSVdFTHY0WmdzMXpsTTFzTFIvVktCL212SlJkVC9WVysyVXdlL21k?=
 =?utf-8?B?QzRjZHZvUGRjZjV4SVkrL2FkbFlkL1p0MlpNSXVhWjMydW9kVzlmNThkMitP?=
 =?utf-8?B?M2JDVTRPMDBHa2JScDVxVklieFZ4MmpPU1hxZXlWMWNMMVVMcGtPUHhhVGV2?=
 =?utf-8?B?eThtdG13anlXRFY2ank2SE1zb1ZIZ1RwR0NRbnN5ZTZneHcrTVhSbVJGY3dk?=
 =?utf-8?B?OFlUYnpxRFpvNk1xcnFVb1RldXdlYkxLS1VnOU5ZN3dTQjh4LzFVVUdVYS82?=
 =?utf-8?B?Q2YxdjZwczByUEZRUzRrR0lyclRsa0ZaSnRhUUY3OEJybThBZHQwaElUZEJu?=
 =?utf-8?B?cTdrL1ZzVlZRNWZDUG1qWFZYcVMvRjNTM0tjekNLTWl0ZXlZQW8vKzdSREdW?=
 =?utf-8?B?cjhLTzBIRDY0U2FyaTRtMkZHbG1DVkJBSzRYeFljQXZkYlB0d0J6VU1ocTZW?=
 =?utf-8?Q?MMkpC409uNfTUHug6p4Nu5eI8?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b848653c-3eae-4d9a-c8cc-08dd5cf5e3f9
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2025 21:28:52.0152
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jR4e8GYt5L343DofNUxl2kT3l6FPxYr5xBEdE0sfc2tsqbbdeW84ERf7VBvT0Odsv0SH9WjTi9ebmAW7XnhNhA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7961


On 2/28/25 11:58, James Morse wrote:
> rdt_put_mon_l3_config() is called via the architecture's
> resctrl_arch_exit() call, and appears to free the rmid_ptrs[]
> and closid_num_dirty_rmid[] arrays. In reality this code is marked
> __exit, and is removed by the linker as resctrl can't be built
> as a module.
>
> To separate the filesystem and architecture parts of resctrl,
> this free()ing work needs to be triggered by the filesystem,
> as these structures belong to the filesystem code.
>
> Rename rdt_put_mon_l3_config() resctrl_mon_resource_exit()
> and call it from resctrl_exit(). The kfree() is currently
> dependent on r->mon_capable.
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


