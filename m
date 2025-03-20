Return-Path: <linux-kernel+bounces-570419-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61038A6B01D
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 22:46:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4AA1517B2C6
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 21:46:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76C5F22A7E8;
	Thu, 20 Mar 2025 21:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Q2/XNyZf"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2075.outbound.protection.outlook.com [40.107.220.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 151AD22A1F1;
	Thu, 20 Mar 2025 21:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742507180; cv=fail; b=kSUvwUOaGI6Git8XolvgQ6FAJUHPKQaoqJYyISCLtMpsKcFY/gkxs9vaJgr6d3sZz4P3n63dTJ6hvEkkKVY0xuxO0rblZBDmqoSz7UoVp68+Lj2S91ydoIRg+PBn6sKWG9QmtTKdUVaEvLQejOiAQQcPgpYNTMi58+bpDmnhBfA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742507180; c=relaxed/simple;
	bh=k1zpudFlRRy5AErHv1BwBk6rRrlfNlpVde+HofJgiww=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ht+rooZf/K+wBUu6chQN/2y/Wu/Fb7mopM+NvPY45x+RO3OBxF8OG0F8QmtgANc9zGol/ABSgpuJCLvjV1Sgd766+iZ6TsgXslgwT2edPOpBFgnMl0Gal8LvtxSCUnsTD1wlfUdRVhEvgRNjjA2V6jnXJwVQc60NKyagJmNcsp8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Q2/XNyZf; arc=fail smtp.client-ip=40.107.220.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gmbMrl0o7au0AzWa0Zl2rEozDO7mra+Iv0Nc6OqlKmrKc/reMnfIDtZgHmhSKDLy95u7RhYybv1PWoCUP896qZnXq94iMhspzi23DwYR4NHhrj3sOhi2EmiqE1Q/70U0lfdKisZzRx2M8agCud8TsBnwxRn2tkyyxOqD79AoejEY1SxdAsegbnzscTbIZRiudHmmihziSv/UM6+yviZH3Z3gU/YhOVXROzgL0DN5sdM0HDbOs7ydo6GKBKAOAEiHca+MNSOa0ua/hco3zTV+Z9TCw/pFn3b0DKklk+8WamxZe91pyVdwMPN9+2o2N5SABmnZ6PcvjUdZdRMIpgbroA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IhRwWkR1USp5++bNSwfD03w8OFFI+KV/toY7h+an+qc=;
 b=cjFt3QD8dI3Wl6Tg4ul7KqTm7TOJzGkxCtqXQua0JuP16s2gOUikN/80MV/gBCUH/AStJ7qM80Agn2TvGAvOhWBy/YmaBE1vai2lXTAjOHf+SGC1dIY7UhSZuezKZvxbt2mM66lkoH/e+Pk1p08OGVrZhZGI16o7goMlPSZe91o/utqoFyiavtpsu4paonkUlJcIpNmc8mMRmaydHBgK3A6eaR9B4raCEIommrbJYkrEadL4fgfHv205yXu5jvlRKyYkPjjdDFduEtDBRB5uD3vt9S6HsSOXRtbObvWQbdyddC170Gqn2V4E8eLUeiKn+A2Fn6IGaqLenjhlDJsNxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IhRwWkR1USp5++bNSwfD03w8OFFI+KV/toY7h+an+qc=;
 b=Q2/XNyZfmH5WpKr40UIFreX8bLdFpnvlwIOCupg+B1yCGZEqeEF1qHUj6iLt2ntMhOm3ETx0zOU+xKO6sMAOWzjqgDVNsRjbjIr3C9GidmM78qvxAr7g7KuGJRP0WCc7P3zUw46XLoBcaZJ3BcrZmXus7GUZeNKKdBqVi1l1cmU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by SJ2PR12MB8689.namprd12.prod.outlook.com (2603:10b6:a03:53d::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Thu, 20 Mar
 2025 21:46:15 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%4]) with mapi id 15.20.8534.034; Thu, 20 Mar 2025
 21:46:14 +0000
Message-ID: <c7cbd33f-ec02-48f1-89f3-64182c19d89c@amd.com>
Date: Thu, 20 Mar 2025 16:46:13 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 6/8] platform/x86: asus-armoury: add screen
 auto-brightness toggle
To: Luke Jones <luke@ljones.dev>, linux-kernel@vger.kernel.org
Cc: hdegoede@redhat.com, ilpo.jarvinen@linux.intel.com,
 platform-driver-x86@vger.kernel.org
References: <20250319065827.53478-1-luke@ljones.dev>
 <20250319065827.53478-7-luke@ljones.dev>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20250319065827.53478-7-luke@ljones.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN4PR0501CA0066.namprd05.prod.outlook.com
 (2603:10b6:803:41::43) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|SJ2PR12MB8689:EE_
X-MS-Office365-Filtering-Correlation-Id: 394385dc-35c8-4932-6ab8-08dd67f8a36e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eUx1M2xEVkQ2U0VPTjA4U3dDb2Z6OGxrTFJWMVZxRGpmZE5zOW9UYkp2aUww?=
 =?utf-8?B?NGZ4d3lhOC9VbjJsWDdHeWpudkI3cmt3KzNJSmVLSEhkWUk3eFJUb2lxSVFh?=
 =?utf-8?B?SURYazJRV0ZMS1dqWkU3K3AwcUlwREowWFJNZlczMTRTWWgyd3BVd3g1OVZR?=
 =?utf-8?B?SkNzWnU0YXkvMDdqQUVaME9FTTBsYWErZXpKbnpCSW4rWFk4Y1l3Ujg4ZTJw?=
 =?utf-8?B?enZRQXl4QjlkNzlLYlh0L3M5NkVpR0hVeUZSTFdnc05YNUdKYkQrNUxneTBL?=
 =?utf-8?B?dnBEWUtHaFV2K1lNVlg5RXg5QXZkQXRSU1N2Z1BuUXhTMmlkQzF0VGZXTXhF?=
 =?utf-8?B?V3hwbzVBMzEwdXduNnlWK21kNjZQNnVnZDYraitCaUs3VzdUYXVvajBuUmRn?=
 =?utf-8?B?UHF1NStONjQyYXVQKzV6cENveTFvTjhyYjRBNEtlMGdRODdtUmpHSnVWcFR3?=
 =?utf-8?B?aS9pb1d5Rm1qNzJyWEdPSSsrK08xUmFlYXI3MjYzTCtOSTUwMEZFdklhc0lj?=
 =?utf-8?B?T2l6NEdJalB0M1JwNEdYL21WSFlkdC9BcGt4NGlCUnFwOWdOaVR3WGtwckx1?=
 =?utf-8?B?STYxa3JSQWJML3FuWXZoT2FYVWljcVRCRVpIMmZNdTM2RVdaMHRBTE9vdk5F?=
 =?utf-8?B?Y0RNTlExcVN4SkxidDFnV0J4RS9TOURGTi92TkhyY1NYVGpldFVRa1JMMkV3?=
 =?utf-8?B?MjFObjBYTTdDSE1tSHhLWXEwalp6RWRRZ0hFL0JOM3N1MXoySEd5MFhENkZB?=
 =?utf-8?B?eDZHQUxnNVY5cFFKbUZtMEdlc2VQTVlMVTlWUlVJVzJTenlQNzFGN2tCVzNj?=
 =?utf-8?B?T0lEbE11L0pIcDBiWGNuSWg2RVpiejg0bTZFY21sTWVvYWIraTYyanA5T21a?=
 =?utf-8?B?ZmxCbjljU3pEbGdkU0hGc3RQUDZEdk94R0hlaTUvc0ZhVERHbGw5QW40clp1?=
 =?utf-8?B?R095UE42R2IvZW5uUDhETUZWenVmMGJQV2xodldpVVhXRWZLOGRWN2VjZWxl?=
 =?utf-8?B?eFlUdllnMkNMeXVTNTl2bUhiMVVmK2gvZFZlUUpsWkJNRk1LL3ZPMUpCL1hy?=
 =?utf-8?B?eEl3REMzaXBkZ01tUmFmWU10di9ZSGp5VlJLV1RPeXY0RDhIbmFzVUo4TXNy?=
 =?utf-8?B?T1NQcS8xc0xnTVp4MmN0ZUcyOWxocjFjTTJVVHczdHpiUEtRdlFPVkgxQjlm?=
 =?utf-8?B?Zm5waGVtSzVSZWZYSWQvZjV5cWo4aVJEdExOTU5kWTVGWW12aVZBWnBYNW05?=
 =?utf-8?B?RGljSU9GcWVqclBGQ2d2djZwNHVuZnRpZjlQMndhcnRHN2d2UkFGQ2FrbFRR?=
 =?utf-8?B?ZS9yZXpkaEIySWlsNzNtdkRodnYxWFpnUW5UVkZ2TmdOREtsTGZkem1USG1O?=
 =?utf-8?B?aW9Oem80MmlOUGFnUDhKalIyN29wTjkrS1FNSlUwQk5OaThHeXNtRlJVZXNz?=
 =?utf-8?B?MGg5UEhGMHE2TisyWjB0bnhNUjRlK29ZQlBvM2J6YXdnOFljekdnZFFWMjhz?=
 =?utf-8?B?RytPazB6WmU2TTZ1eU5DVXlrNWJOOHNqL3IvT002K2prT2Q3VDZhaUJnL2xa?=
 =?utf-8?B?dFN1TE1xZTV0U29aZ0h0NUFhcDdtM3laTkZiekxXOTlHNExmNStTczcxWkFn?=
 =?utf-8?B?aVJEcjB0OXRwT1A4MnBXekFTOWsvbkhlbmRMMWFVaXNVNGR4K0J3VTRBZWNp?=
 =?utf-8?B?WStwTEZLekJFWEVhWVBRM0FZZUFaVDJuRGdLdXhYRTJEUVpsaWFnYmpSL3R5?=
 =?utf-8?B?MFVsbjdqZVFXR2RXRE8veXdYQmMyNnU5OG1Bbno3TXFVMnlyZ2pZSU1tby9p?=
 =?utf-8?B?aEpaRkZzK0ZsVmRxbXMzTmhoOEF4TjROdS85QnVFV2lZZjlsU0YreFRvS1R2?=
 =?utf-8?Q?i1FCj9FkMJ/yg?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MlZMT0l4VmJXRW41MDBsVHNya3IzSmR4MlFCTHlvbG9SKzFERFBKT0VLQVVH?=
 =?utf-8?B?NzkvZjltZmJnaThpTU5sUVpvUklxMWlOVE51czYvZ1hGbUJJQ0MwWDRxNnZT?=
 =?utf-8?B?NGJLUVBJTjhCM2NpcG9GQkN2ZjlwMVNXUVNzNHRlT2pEQjZWVmUvLysxV05n?=
 =?utf-8?B?bGNKd1I5R1FuTTY1aDZDL0pEaWN4eHdZZFl0MVdMUFY3T1MyOE9aWWRlQkRs?=
 =?utf-8?B?YkFIekVra0p5aGo0NzZtNkYwVkk5clEwUnQ5dkduMTNEWDNJNFdCSysxTTBq?=
 =?utf-8?B?UXlMMUoxdjhqazk1Tmd5MzRkZU9HUTV0Q09rY2lTcDZsTXlDdFBwYXNMeVRp?=
 =?utf-8?B?WDZXWlBvM04yUmtOT1hiakkwMlpGQzArU3lsMUtXNnlqNUNBTW9hTkFHdkNl?=
 =?utf-8?B?ZHZ2NkEzRkR3eGVRd0JiNktQM01EZzFxMjF5UytNRXlxOEJGcWZPVnZYRnhZ?=
 =?utf-8?B?QnNVMW9BcSt2WlZ4OXBod1d2Qy9rNFRsOWpVZXF5Z2JCdGUyL3FJdHNOZ3N2?=
 =?utf-8?B?K3hQK3ZmTlVpQ2xXS05CRFBuUU5HMHExVnRkSSt6dXkxcWcyQjc4SVcrMUpn?=
 =?utf-8?B?K3ZvSmtaZGdMZ3hJaVQ1WWtBSktQQUY3b0NTTTQyQ01DRlJwTDdlSEhmbjlP?=
 =?utf-8?B?SnJOczI1S00vMUNKTGM1ZkwyY3RJMWs1M2NySDhJeDVEeEs4bFNKYnNKRHhE?=
 =?utf-8?B?SDNjUkRpZk5YUzFNbUNBMlUzWDZZeFB4VXZ0OVhxUWpxYTBId2J6ZlR0bUNJ?=
 =?utf-8?B?Y3pTMXVDNzNLZGhLMFlXTElXSGZ1a1Y5RURZdHRzVHpvR1dKUkJlQTErYi9H?=
 =?utf-8?B?cTNVbTdERzhsanpSVmltSERpNVdGQ0J3Uzl1TlBDdmZmMENoT0M2MW16SUJ4?=
 =?utf-8?B?TjZ5cE1IRExKTldiRlg1UCtTT1FERVMxM09qdEpvWWo0bnkxYlJYaGVzZVIx?=
 =?utf-8?B?VDhKN3k3VVhwWUJWeVJ4RnAwYlFhcGVwQ0dLZjh2MC82OXpDUm9FTVBHaVFq?=
 =?utf-8?B?RWIzUDRhbURVWkxvNEpYSXo5ZkovWDc1WFFEUHQzSVJ3aWQyNzl1U1hYd1R5?=
 =?utf-8?B?UXJDTzhiNVJQZU9PTkhKTTBvYXUvczFtcHN6Wjk0aE1NVkJNL2NNdHpPZ2h1?=
 =?utf-8?B?b0l0ZG8rVXI2ZmJhRlJHMUFuUWxweFdqYW5rZjQwUDJLRWhwNHBhVE5ZeENa?=
 =?utf-8?B?dzBzbFpEMXVmYVBpTzNPYk12SG5WclJYR25TVDBZRVVQZWdUd2x4dUVKSGVj?=
 =?utf-8?B?aU5wZzk5YXZNYVFsempPS0xVQ1BmYzFtRTJYaG9nZmo5YW1pSHlpZk96WHBz?=
 =?utf-8?B?aHpzbGI5b0R3TUxoVTRjTjBrb0Z4V3FkWlJHZTQ3WHRJVWg2dGlXdHltajR3?=
 =?utf-8?B?VVVZRFNUWXBKSVJERFE3aGt3ZDF4V0lWclMwNElKa3dFcC9uVitpSnZZWk9o?=
 =?utf-8?B?dG05WEVpczY0Ylg2cHFWR2dpNFhyV0o2b1oyTGljUkdrL0JjckdRaFd3WldF?=
 =?utf-8?B?R0FqdkV2Zk95Yk1STWJxbGNld1M3aUo0Y292QmtjbTltM2Z2NlJiZUQ5MTlq?=
 =?utf-8?B?aXo1dWxYREw2bElTR2ZsSnpucDRzWWJZaFVVZEFSdDQzWGZFeU82QTRMbVBM?=
 =?utf-8?B?dWdoSFIzZTJDcGx5cklxdHgwbGIxQ2ZLUk1uR0k0b0xvdUpsdGp3OVZ6K0Vx?=
 =?utf-8?B?aXZOUUtWaC9MdkFZQ0ZQMEJJWGRzdWNHR0pLUEdHb1p4b3pha1BvbkxzYWFG?=
 =?utf-8?B?VHBuT3l2RVhZbEFpeVpsejIyeUpFbm5wT1NFNldOR2xkZUp1VXc4L3lRRnkv?=
 =?utf-8?B?Y1VRQ29wZGo4WXJPclY2ckpTYnR3bW54TWNZQkVtSldGM3YrU3lQb1hUYmg2?=
 =?utf-8?B?ZHhyZUlUQjFWemZvQmVjUC90SzlobGh2MXhrZEQwMFBlOEltSis2WktrWGpv?=
 =?utf-8?B?cXFEZEY1b215MnVsVFhiK01aVGlTODJwNGVVeHIrOU9Ta3NaUVpMRHRTYXRs?=
 =?utf-8?B?YnpUQXp1dDVWMmc0czkwWUxUajBUUmdKbHpGUTcrSEZIWHpXYWFTS1N5Q2Zs?=
 =?utf-8?B?VitST25kWlNMUTY5cmxmNzRZcENmbjhLQ09BaE80WFBnbHpRbEtXNExOZUxK?=
 =?utf-8?Q?8dZYuL6HdaCque7N5/mhQ293K?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 394385dc-35c8-4932-6ab8-08dd67f8a36e
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2025 21:46:14.9266
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UE/cWTQ4SwsAqf+czvoV5pKel0IBF9jn1JTGVCZFTggtRg02K7exZouxuXaVV1b/KuiRzZNoDpPXdexsyJKQXQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8689

On 3/19/2025 01:58, Luke Jones wrote:
> Add screen_auto_brightness toggle supported on some laptops.
> 
> Signed-off-by: Luke D. Jones <luke@ljones.dev>
Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>

> ---
>   drivers/platform/x86/asus-armoury.c        | 3 +++
>   include/linux/platform_data/x86/asus-wmi.h | 1 +
>   2 files changed, 4 insertions(+)
> 
> diff --git a/drivers/platform/x86/asus-armoury.c b/drivers/platform/x86/asus-armoury.c
> index b36e19b9d2bf..802c304e2ebc 100644
> --- a/drivers/platform/x86/asus-armoury.c
> +++ b/drivers/platform/x86/asus-armoury.c
> @@ -752,6 +752,9 @@ ATTR_GROUP_BOOL_RW(panel_od, "panel_overdrive", ASUS_WMI_DEVID_PANEL_OD,
>   		   "Set the panel refresh overdrive");
>   ATTR_GROUP_BOOL_RW(panel_hd_mode, "panel_hd_mode", ASUS_WMI_DEVID_PANEL_HD,
>   		   "Set the panel HD mode to UHD<0> or FHD<1>");
> +ATTR_GROUP_BOOL_RW(screen_auto_brightness, "screen_auto_brightness",
> +		   ASUS_WMI_DEVID_SCREEN_AUTO_BRIGHTNESS,
> +		   "Set the panel brightness to Off<0> or On<1>");
>   ATTR_GROUP_BOOL_RO(egpu_connected, "egpu_connected", ASUS_WMI_DEVID_EGPU_CONNECTED,
>   		   "Show the eGPU connection status");
>   
> diff --git a/include/linux/platform_data/x86/asus-wmi.h b/include/linux/platform_data/x86/asus-wmi.h
> index e735f35b423c..92fea0710ada 100644
> --- a/include/linux/platform_data/x86/asus-wmi.h
> +++ b/include/linux/platform_data/x86/asus-wmi.h
> @@ -83,6 +83,7 @@
>   #define ASUS_WMI_DEVID_LID_FLIP_ROG	0x00060077
>   #define ASUS_WMI_DEVID_MINI_LED_MODE	0x0005001E
>   #define ASUS_WMI_DEVID_MINI_LED_MODE2	0x0005002E
> +#define ASUS_WMI_DEVID_SCREEN_AUTO_BRIGHTNESS	0x0005002A
>   
>   /* Storage */
>   #define ASUS_WMI_DEVID_CARDREADER	0x00080013


