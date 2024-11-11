Return-Path: <linux-kernel+bounces-403868-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 647219C3BFF
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 11:32:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A08D280D57
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 10:32:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 570011581EE;
	Mon, 11 Nov 2024 10:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="C7T5XiGF"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2069.outbound.protection.outlook.com [40.107.93.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4D7314600D
	for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2024 10:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731321124; cv=fail; b=dlIdQitK/YG54GR4GhWmDmIxTijMjwllk63mFca22gjH1tz9awcDspFn7LHV56BX3dcwWtqUu73Tvk10K+NtL+z/ijrAt+wYbnQkOYUmbL1KbL0X8BsL1VumwMVL9QGGax9uWxYMP0DxqkL5Z1G5sCebDdluudQqqpNVAsjJJSY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731321124; c=relaxed/simple;
	bh=oBJevVYbm1wLZXjBGCYaCqXs6FhvPLw3+yF2+IAGLoI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=LCMcBXVKuJQjTG/rRAgF/3rbC03EjTVETklcD5anI/cDPQrWWNiwdkCZcqM5rra5hXmR4fALpyPbFs9yyvCU7pY0e6lzq7gEwDERrOJHHZ63giWOP/MBzR1U+l0cyLEIAoppbb3RUHVYXgj3nh+sf+P7nQymFf5Dkif8XAnhgL4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=C7T5XiGF; arc=fail smtp.client-ip=40.107.93.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ss3O5mKa2G59wtAbWBjtw6923tRjEdEwK/dH4TVhzcKIIYOacM7CmYkqtGNbENR4IwpjI67k4aTYtGeYoi7zgivLsRu7Gmdlz+shuYnoBIgErNYR/3fWbEme0GRux3pgnE8FBFs9VtfhUq6kfdYW+mcCnyy+2EEeVoVrjjMnQ0egZN/9ZRirwbuy/pdx/t2ePQpBphfDmPUUfvHrmF7qBPA+ewKNjrriFFuQsPy7luZngjqzXV/a9N/8C9acdc8Z6UXzd9QciVwD1HEIKN1gTeiMKfmx6SWV8u0WaWJUohhPCT+AYQ20JfXBABh1ViAUp3ok/5GRaXLSPyJ3v+F5Ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VWQjzTi6hi/Kuw5rHySkx7kk6g/197Mcl/pYmxJbQD8=;
 b=wyuO4mFlbm4nDpG7JedFVezvg7n8sJT20g8Z2DMdsP44uxyVNFy/sqcyTJvGuKHJFgOEZlUBipyYH2tjoWH7kT/6xnCvPlWRVPhR3tY7ngqxIZqQVLYngb0yW0vZ472bRIg2i8BUmNFoOKwBCudXWH1HAFiLr+lPKebCY7s1UJU5ECS/iy+WZE7mOU9Jy2rhD2m6eYRcQb2TwGDVFfrWRA/netr9cDOzprFm+1OrjZInExRDyY4/O0HyjBAXNtGvwFT9GLGQ3HCzPv/8UGRmyz6+SBbY3J1Y7Qf7eYiYsdV/WhH39sMvYUg276G6yj0hSUyF22+dSsukztDwmzvdWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VWQjzTi6hi/Kuw5rHySkx7kk6g/197Mcl/pYmxJbQD8=;
 b=C7T5XiGFRfiuBK5RStLY3QSQeJwN2jaztA5lIv0yH1dYNhoHkU8JhCIclqqPjZp5VEOXd7xYIYHKz8Ch3/tB84LBDIGQ24uoAgSFl/xka/WnRi1G041HjRJQa3pQc9MvtPDEhJLF99DJQ/d9c6x97ABzhoEQrENygbXr6Xexhsk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5805.namprd12.prod.outlook.com (2603:10b6:510:1d1::13)
 by DM4PR12MB7743.namprd12.prod.outlook.com (2603:10b6:8:101::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.27; Mon, 11 Nov
 2024 10:31:59 +0000
Received: from PH7PR12MB5805.namprd12.prod.outlook.com
 ([fe80::11c7:4914:62f4:f4a3]) by PH7PR12MB5805.namprd12.prod.outlook.com
 ([fe80::11c7:4914:62f4:f4a3%5]) with mapi id 15.20.8137.022; Mon, 11 Nov 2024
 10:31:59 +0000
Message-ID: <dff2a860-c92a-4371-8bf4-010a2b127bff@amd.com>
Date: Mon, 11 Nov 2024 16:01:49 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] sched/numa: Fix memory leak due to the overwritten
 vma->numab_state
To: Adrian Huang <adrianhuang0701@gmail.com>
Cc: ahuang12@lenovo.com, akpm@linux-foundation.org, bsegall@google.com,
 dietmar.eggemann@arm.com, juri.lelli@redhat.com,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, mgorman@suse.de,
 mingo@redhat.com, peterz@infradead.org, rostedt@goodmis.org,
 sunjw10@lenovo.com, vincent.guittot@linaro.org, vschneid@redhat.com
References: <1794be3c-358c-4cdc-a43d-a1f841d91ef7@amd.com>
 <20241111100809.20527-1-ahuang12@lenovo.com>
Content-Language: en-US
From: Raghavendra K T <raghavendra.kt@amd.com>
In-Reply-To: <20241111100809.20527-1-ahuang12@lenovo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0100.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:9b::22) To PH7PR12MB5805.namprd12.prod.outlook.com
 (2603:10b6:510:1d1::13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5805:EE_|DM4PR12MB7743:EE_
X-MS-Office365-Filtering-Correlation-Id: 8724d213-b97d-4974-2008-08dd023c1295
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cFA3R2RDcHFzTEduWGtGekJ3czRXaDhZMXZjbEV4MytWWm9ZSEVpSFc1NWVV?=
 =?utf-8?B?QlM5WHBzZFgraGNncVB1NS9RanRld3dvR1V6bGIrdVN4bGZlZzNFZ0c4VUpU?=
 =?utf-8?B?TW5uYnNTM2syK09NQUYzRSsrZ2hacU9Ic3EwNFV2SWxTL2RleEhWejB3NFEv?=
 =?utf-8?B?MmJhcGpTcm52V0dyOXR6cnV5dk1SdFRPUGRZc01nK1hqZC83SFZCVTZtL3hU?=
 =?utf-8?B?eTNCdUNlcUJvSTNTcUlIUWJXUHN6aFdScEZVTVpnbDkrVTA5WjVSd1pFM3V6?=
 =?utf-8?B?ZTJXK2lrdzlxSVNoMFVvVGlUV1pXcENlOTl3ZmlDcUVsS21KM0QvNGpkclh5?=
 =?utf-8?B?M01RbWVBQnZQeitINFVsQWdhMGZNNWFmYXZhYjZtQ3V2NDcrQXV0UjNDT3NS?=
 =?utf-8?B?RGdyZGR2MUxsUjQrTlZJUmp6Q2JxMktrQkcyQ0wxUThaamI4cTczUllaa0Nv?=
 =?utf-8?B?Z0p5Mmxid3lkUkNtSVBTWkQ1dzQ0NGNtN1VzQXpBQ0FhZ2Z5MWd3QUVtZmlM?=
 =?utf-8?B?L2l2RjYxd1p3TDVrVGRQMWowSUZMOENwV1pHK0FIZUE5K05UTDk1TEtMSHRw?=
 =?utf-8?B?Z28zMGl5MllpUnBxMEp5S2VuOFNGc2IvMEdvVExSRktPeTBUN3EybUZVSUdn?=
 =?utf-8?B?WWJLS2V5YjBpMUJJdFFadktjNm56UVdoMXVycmtYMllIa3JESDFPMnBmNkVp?=
 =?utf-8?B?VUJsYWNxTGhQV0luSHJTYm54K085WVp6V0ttS1AxVXRDQjVqRTBjdW9LbGJF?=
 =?utf-8?B?T1RnaExCWWlnTUc3MmRPY2VLUmJzZ2d0c243RHcrM1lLWlFadUFJRjM2TGxY?=
 =?utf-8?B?MnZiYWt3eVV3enNtenUzR3M1SGg3VnlhK1NrSkg1UlAwUW8xMFB6Q2hySjk0?=
 =?utf-8?B?MldmQzZpd1B3UWl4THJSQ2c3Y1RVNUdoUFhhNnFyeVFQWm11VXZPSXNJVmJ6?=
 =?utf-8?B?UFRhcWpRQWJJTndDVjdnVEhVWWpUdDk2K01ETUFhTzN2NW9LRUV5eGlIN1Fk?=
 =?utf-8?B?dGwzMkl2VnZmMlpYZGVNQytxckxiOXZPVmRlSnlBNkY1NG1kOUFFMkdDZ25E?=
 =?utf-8?B?VE1nL3orZlZYRk0zUmowTDhCZzgyejYrTkl2VXF2R3A4QmtLWGZ4SFBLMjR2?=
 =?utf-8?B?V3dYV1JCNnVqczgxOFYzN3dZMDlGbmlQUDJTQ21PL2YzcXpmTG1HQXhTMk84?=
 =?utf-8?B?Ly8ycUw4K1FyMlV1Rk4wSVdYZEdrSDBXZlNXTmVtWHJKSXA2bG1IdmJ2MjhI?=
 =?utf-8?B?TWhEWUdqbDlyUHRxT09ZM040V0NnQnUvcjE4a0xLZTFrZElPaVErcXR0SE9S?=
 =?utf-8?B?K1l2Ymc5MWFWTDQ4SytFejhLMmFrNWFSZVRaSUd1dFhoTHBUT0xuSVVUUFRh?=
 =?utf-8?B?ejFra3lqQkFhYnVtazVSd1o5WHJ5aGZuVGhEOGFCdHorK1ZSQ0FpRkFwMXZv?=
 =?utf-8?B?SGJIaGhlNCtFWnNQU2NWWG5TTFhWTEJjVU1WTHdyOTRYMnRoTEQxMlMwTzVB?=
 =?utf-8?B?K25ZSXgzeWJ5VkhRL1VYblI0aWdSZS8xUGJNZlZCdHVxRk00OEMvUnZwTGNY?=
 =?utf-8?B?OGsxZTFtSU9NdlBBSUJ4U0lZc0p2Tnd4eTQ4N25aeWdOU3JJaEdCRDBsbm1S?=
 =?utf-8?B?YUNzczJ0SHJSeVZzUVYxZjExQTBvSmJjdllwZFFteDRUM2JoZVBIUnhyeW1G?=
 =?utf-8?B?cFp0M1BROXB3akhqSWl1RmFaYmxUS1ZMSE55N0FpdFYxTVgzK0p5c01wcjhE?=
 =?utf-8?Q?HNgYlo/A54d7/5js1LFEYwxl+1c3+D92+3jqpgG?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5805.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UHBUMlNXSFIrTVNVTyttaEpRdk1EaUR6T0M5aHN0bkpKaEFqSCtPSTJFV29U?=
 =?utf-8?B?ZGtENmVNVUduRnZteS9xelg0dW9YckdsM0FoTkJsYVo2OG4zZW1xSlBEMjhK?=
 =?utf-8?B?UERmUDNLMWhQdVEyRmptOW9mUXJML2FERVlZUWkrbWNLRjB5OElBTzJRa1dP?=
 =?utf-8?B?d1B1RDJoZ3NqcWQzQS94WlpXQjRWQUxiRXluZDdxeUFYQnY2UXFQRXE3SXZx?=
 =?utf-8?B?Z3d4Tm5pYWt3REt5MGRDYWJoSUtzN29lc25CWmROK0xpUk9KdkcyNzgwbG45?=
 =?utf-8?B?Q3VibmxsYTYrTnpFUGNuSlA4QjlQZ3M0eXl3eXgya3NCdk9CUzJFUHdKZ1Vr?=
 =?utf-8?B?OUdYcGt6RncyMFBqdU1iMHVQNk5kaEhFUzNSVUZOZy8wZXJQbGllMEVmQ2Fi?=
 =?utf-8?B?N2ZkeHJOWlMvQ0l6amlzdDNmakhhK05NWDJzMDBCMWZJMXVzelVVVlFWOGxw?=
 =?utf-8?B?S25ZN1VqckhUc2tubnY1NHEveWlSRTAvcnBQb0doQk8wQlREY3JYU1I3ZGVH?=
 =?utf-8?B?ZGNRZXIrUGJONkE4dit4WjRHZGhYakM0NHhDakVpSStiRE1Yck1IS1F4NFJy?=
 =?utf-8?B?cFEyYWYyN3lNMGUxRUp6Nk1TNU9qbEs2ZnlpWjNHZ1BHY1ZIc2hOcklRaU9R?=
 =?utf-8?B?bi9GWFJlc3V2Z3NkQmR6djNjbEFDa3dKRGpkTjZ4d3BNMU1OVnN3QjhtenZH?=
 =?utf-8?B?TzVITElwTEtrT1c2blhNQkM3RDMrRWV6OWYrb1ByNVRsRzZLN2VZMyttR2d6?=
 =?utf-8?B?bDZoQ0R1TUdEZFluQ3d0M05HMW9wc2hKMjVMRUxQSXJWbW9MQmtQb3RFYzFK?=
 =?utf-8?B?djk1aFp5SEdEa1hWSzNIMEtjSVcyZmlOSDF0R2JPdS9jSEd1U3N4MnVtNXdD?=
 =?utf-8?B?dy9wak1SNHZmeEJ6NnNMVVZpOVZwR3RNVzBvQysyZzZuMkpVU0UyRkNYYnFk?=
 =?utf-8?B?RTRyRm5aV3JDOERiTU9tdzc0WDBOMU9XbmF5bVlVaFZhazhqdEFPSkZBVTMy?=
 =?utf-8?B?Q2J1bHBKMERlNjRnamZsbmp0TDJJbnh0aUFqdHNwbDdlQ2Irb1hxRlFDRHVX?=
 =?utf-8?B?RjJoZjhKaCtjVmNDTUdUKy9UTllNdkgrMEc5ZUlZOWJxb2V1aENEQVpjb1VR?=
 =?utf-8?B?bDlreVNrMWNBd3BqcmlhNmNFQWxsQ3RLV3FzSzQweWs1WmZ4TFpZZFFhK2sx?=
 =?utf-8?B?VUhMZ2tFNkJoeGhlN1F2UURNN0pXcFdPWnF6aFB5Vm56WTFmYldoYnFoRmUv?=
 =?utf-8?B?RWRJbm8rRWp4U1ZORGpxekNxRWdheU5yek9lZ0RpcmZaTmticE9YN2ZrUmRS?=
 =?utf-8?B?UTlFMHNaWGRJTDhIVXIyWGxzb3RBSnlmVEIvNmFVRGFKQmpGOFE1MnhwQ1pC?=
 =?utf-8?B?WkNaVGVrVmNnSGRqeStEM3IrQXQ4L293cUNBV0hYZ0xjRHg1MXlVdkgwVCtL?=
 =?utf-8?B?NkhxUE4zWWJOZjBMVzdlZ2R4Mmo0Y3ZEdXNOSWxXbU5FRGJnREVaZHV3VXNW?=
 =?utf-8?B?STN4dXczTm15T2w3eEg3aEpxTndQbXF5ekxhKzRKMEZ3ZFNYVFp2d1IreTF0?=
 =?utf-8?B?VW5EY2ZyMEZkUi9XMlQwQXh0QmpwVzIxaVJmSkFYTFlsNDV4M2xDeXU2UFdV?=
 =?utf-8?B?OW1xMlViTldRUFJSeXRLbTdZMU5uTFJVazFPQlhsRlZMN2FYS2E4VDVwaTJz?=
 =?utf-8?B?VHBRb1krVzFOMzVhcUI3QjNHR3JHUWU0ZXFYN051Q2RtYUpmcWN4ankxeVZH?=
 =?utf-8?B?dWVnUzloRDlLa1FqQlBKNlBUcVdTSFYzc1hKSnhBbGFsSzRJUnZwSmJxUDlL?=
 =?utf-8?B?S0E3cFZTNHl4L2ljZUtyV0FjZVZ3VlR6dk81OG9Na3MxOGNqM0tsNGVuQWtN?=
 =?utf-8?B?Ym1qT0NCV2dYYjQvOXZ5Ty91MUx5RDRkc2RCS0VBRWxDblB3eDRtZDBreFpR?=
 =?utf-8?B?Z1NSYjMzZkxGSVlOaEdyZWlVVlF3TGdmK1JIWjlMV09ZMGhjNkFsNnpaV2JW?=
 =?utf-8?B?WGxyQXZjejZaN0FoeFA4NTRPVmszaTNjb25yNDhlQmJTdmF3R2toS25KQ1hJ?=
 =?utf-8?B?Z1hGVjJHK29lNzJ4SDhCc291NS9mY3ZPYzJZeXEra1pXZElOTWd0UzBiSkUw?=
 =?utf-8?Q?q3QkEFzoDPHkQ3d0LTrMPla64?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8724d213-b97d-4974-2008-08dd023c1295
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5805.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2024 10:31:59.3264
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ICQgmjP1QGTca7skaoHqadMCSCSkU6pKmdjZOsVlqRNOHRuIqeozNHVbowErEmlD0NUOcIoz6ercr2k16bk3rA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7743



On 11/11/2024 3:38 PM, Adrian Huang wrote:
> <snip>
>> However since there are 800 threads, I see there might be an opportunity
>> for another thread to enter in the next 'numa_scan_period' while
>> we have not gotten till numab_state allocation.
>>
>> There should be simpler ways to overcome like Vlastimil already pointed
>> in the other thread, and having lock is an overkill.
>>
>> for e.g.,
>> numab_state = kzalloc(..)
>>
>> if we see that some other thread able to successfully assign
>> vma->numab_state with their allocation (with cmpxchg), simply
>> free your allocation.
>>
>> Can you please check if my understanding is correct?
> 
> Thanks for Vlastimil's and Raghu's reviews and comments.
> 
> Yes, your understanding is correct. Before submitting this patch,
> I had two internal proposals: lock and cmpxchg. Here is the my cmpxchg
> version (Test passed). If you're ok with this cmpxchg version, may I have
> your reviewed-by? I'll send a v2 then.
> 
> ---
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 3356315d7e64..7f99df294583 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -3399,10 +3399,16 @@ static void task_numa_work(struct callback_head *work)
>   
>   		/* Initialise new per-VMA NUMAB state. */
>   		if (!vma->numab_state) {
> -			vma->numab_state = kzalloc(sizeof(struct vma_numab_state),
> -				GFP_KERNEL);
> -			if (!vma->numab_state)
> +			struct vma_numab_state *ptr;
> +
> +			ptr = kzalloc(sizeof(*ptr), GFP_KERNEL);
> +			if (!ptr)
> +				continue;
> +
> +			if (cmpxchg(&vma->numab_state, NULL, ptr)) {
> +				kfree(ptr);
>   				continue;
> +			}
>   
>   			vma->numab_state->start_scan_seq = mm->numa_scan_seq;
> 

LGTM. Sure feel free to add

Reviewed-by: Raghavendra K T <raghavendra.kt@amd.com>

Since allocation for numab_state happen only once.. I hope there is not
much impact on the performance also.

Thanks and Regards
- Raghu

