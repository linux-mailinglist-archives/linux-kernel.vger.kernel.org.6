Return-Path: <linux-kernel+bounces-549866-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7601BA557FB
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 22:01:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A77681896820
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 21:01:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 932812063EB;
	Thu,  6 Mar 2025 21:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="bS9XeDFG"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2075.outbound.protection.outlook.com [40.107.237.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A46D1FC7ED
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 21:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741294868; cv=fail; b=pq4D3xsaTR/GWahpS764zDic+zO6Eoy25ijW5d94Gzjg/n9uVN/yyPCNbIY2g7FkT3xw5/UxYRqD3RYKRFi/NZ3C/IfdU3TcuSGrbQxgwyVqe7uRu0j/47jnWX5ua4JHKr/+x6jEbjtH6+3/Dq7NxiP8QjFjYnWKdkexBhNXa4g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741294868; c=relaxed/simple;
	bh=ScdREdPyY3nA1U3Om4rXwW8eHWLP0LPYQLN7MyI8xGg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=X53E5llO9ONntLhIJSappI39LH8vtMtAw8gINqVFq+OuhF+M4ky3YNOiqHIsopNYIjrUDUa8wV5CeZ2zDHgHwErlS0JXjM+DF+CCqsSOCIwa0goDRXjPBNtppAjLClwfBrJQ/842yDFSpRedLJ31UrfdMFhF9NEmBUNFNG0zNwI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=bS9XeDFG; arc=fail smtp.client-ip=40.107.237.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ydEU9PJCe0mVa1HEznC5MFoHkBpG9rgQ7KXnWN6U7X1gytImKZ3X3VjgjfMP+4bJRPQ7BDVhYLRJ07+KT6rgPqLnGUS9kxjQRRA0+prz8wOT+Nyzzx6CLPFJTj24kTAEPTGaw7flY6N5tyyTHe2Vw2DFufZ1ymA5XjjS8XSnpJA8Os36kZc9Qvs+O0QRVg7pCsywWhsuj+y/ThjQ1B3ILFkz5dA1za4s4WUA00Icr92a+24bFkQwWbSZJoGgjrsptGiU846iqXNYoIflSRYw9kXwWOoSaEZtelwZ7P/FNY0M1G15f0a4HPTTYwEl/MrDHBhOZ9tp79WLfo2wiHxjHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ScdREdPyY3nA1U3Om4rXwW8eHWLP0LPYQLN7MyI8xGg=;
 b=FamXJm6LDKhueEkXwk4hxzQ/Xdlb9l/shtsq3DFw+CaaoSWh7uylorXm5K/zJgTSXtVDitbyy8uvHp8A+CZqekXhwiW6CCjd8ZYNQfAvSg7naSA8q3LNIwNqZcN7sVW8BP855NFjm4TDON1YjkEULiHZpx1TVgyHzr3pxPbkBHgWalI7tzocoze2FRD125wgPLNOXU3HrOo08zbPeIibGRFwnjp3WWq5liLunzJCQYdY91LFbEchB/nycvNgmW7aqYFirBPmZ4c0+WrgcWEd5hRiPngayl9OnggYOwd0oPbsHSQz0C207mSPFZx2LSRdYHnxr3K78ozHiQpyhNW9bA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ScdREdPyY3nA1U3Om4rXwW8eHWLP0LPYQLN7MyI8xGg=;
 b=bS9XeDFGEND9dNAamGk1jYhQL4SKZmXkP7+8BG7AVuaG0RO+94S9NsLGMViOD2jgDvhhZTvLfRmcBEc5KeF+dff+VIwRB/FvaFzUObZgn+UjylG8+b9Jc+MjzF1VCt9/LOMozwdUSOV3isqVbRwR6b5RlFECWkuv//LirXUYzjqnjr6TdMj0qbLs8WdRDc1675wZMqLZcgPReIW+tGsoWr2WpPpSB/zyxCfh+jE++N0PlotcQYFvFHIGBadqlrny83S3txoKEe7Q4vbva43yl64s0r5jVfZi1ea16lctgAYfdsrXXBD6V3eUQLVRE3NbEl/jLCv7IFYIVib0Ug/r0A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB2667.namprd12.prod.outlook.com (2603:10b6:5:42::28) by
 IA1PR12MB7662.namprd12.prod.outlook.com (2603:10b6:208:425::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.19; Thu, 6 Mar
 2025 21:01:04 +0000
Received: from DM6PR12MB2667.namprd12.prod.outlook.com
 ([fe80::bd88:b883:813d:54a2]) by DM6PR12MB2667.namprd12.prod.outlook.com
 ([fe80::bd88:b883:813d:54a2%5]) with mapi id 15.20.8511.017; Thu, 6 Mar 2025
 21:01:01 +0000
Message-ID: <bc9ad63c-186b-40ea-9427-ce6a78a1e5c1@nvidia.com>
Date: Thu, 6 Mar 2025 13:00:58 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 04/49] x86/resctrl: Use schema type to determine how to
 parse schema values
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
 <20250228195913.24895-5-james.morse@arm.com>
Content-Language: en-US
From: Fenghua Yu <fenghuay@nvidia.com>
In-Reply-To: <20250228195913.24895-5-james.morse@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR06CA0061.namprd06.prod.outlook.com
 (2603:10b6:a03:14b::38) To DM6PR12MB2667.namprd12.prod.outlook.com
 (2603:10b6:5:42::28)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB2667:EE_|IA1PR12MB7662:EE_
X-MS-Office365-Filtering-Correlation-Id: bf53cbdb-f28b-40be-b013-08dd5cf20047
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SjFoL0h3RUk2Y2pINmRRWTljSHhUMHJ0L0VxRkpYVmY0anhpMWQyU3hBaHVi?=
 =?utf-8?B?YkMza2NEdFp6a3FqL1RCdC9GUFZ1cnozL0VsM1dQU1VRQUlEcXVpdFZaWUc1?=
 =?utf-8?B?ckQ5WnN0Y1RXYVVoM0hKOUY1MVJ2RzBMRDB6Qk9xaVBnenNGdlRyODJhUlR6?=
 =?utf-8?B?K2h0V3BvcFdOZkVIOEt2OHhtdXFUMHBSejl5cjVTS2hxVWZUY3pKc1hvQ2pO?=
 =?utf-8?B?R3o0YmZ0a1U2bEIrcUZnOFlvVDdWVzFVcDBTbFVUeklBaXFENTZSL2hnVllo?=
 =?utf-8?B?K1NCTDBhVE8ydUZjUmswOXVuZ1hWa0Z2U2RhazduOG4rUS80REVxWkRqRVRP?=
 =?utf-8?B?cDd1a0hCL2U1c05nUnlSWUhlVXZsZ2U0VjRaMnJCbmZxWENFRWZhaEd2UzE4?=
 =?utf-8?B?eGIwN3hYY1poeTUrUUlRbmJnb3B5NVZXeFhwWFdFY3pyRXRVYy9UaStxRHZo?=
 =?utf-8?B?VFNNYVZSNFR6UGdYRnM0STgzd09lVlAzU0hGdlc5MElNaS9qL2xxVVM4KzVm?=
 =?utf-8?B?QmtyWUZiT2NwbjJ5Qy9MTnpnZjQzRjc5U1F5bWNteEZFRHJ3eHNUT290eHRD?=
 =?utf-8?B?QjlvNzFIdlJuWld2ZHBmZ25nNEoxR202N0xBTDdrcHNJemZSbzIxOWRaMURW?=
 =?utf-8?B?UUVaemc2NUFBS2RaS2gwVzkyaVhURDBtVUl5Q1RpZHVqQ0R0QVpabHp3aHll?=
 =?utf-8?B?VzZTY1lzclRTTXY5N3Y3ZWEyMERaVDc0Nk1jcTIxci9CWXZVVkF5OExXR3U2?=
 =?utf-8?B?RlpCOWNDaHJINzZGZW1qQlFDV3g4ZGVnV2xoclJpaVJVU0Uycnp0MEJ2ODZG?=
 =?utf-8?B?WFY0b3JsT3N5S1JrOWNXRTluOHJ5SGNpTVVuYjYwRHZpSmg5aFE0dVBvaXJV?=
 =?utf-8?B?UG9ybSs5RXE3am1vUzhaUFFTakgyQklXOWtVRWkxaDdjYUZHQy9idTRsVWtG?=
 =?utf-8?B?TTBVUVdLcjdhRHlhNEI4NDZ0bXBzNGhsSk12dFovYjdvQmNpQ1djRy9kSjdH?=
 =?utf-8?B?OTI2dXpDZWFUN0dVeWxyMFJoeVZjL1Zlb05tTjZGM0s2NEVaRStIZ0xJa1FG?=
 =?utf-8?B?NitxWWUzZVJCT0ZrL0RTVm9tb3hXVkszRnYxUmsrdWM3aWZOcmlLbld0aTUy?=
 =?utf-8?B?ai8yVGNwN1hIdUgza1lxeG51NzRBWGh5cHR4LzZIOVBLeTd4N1poT2wyZjUr?=
 =?utf-8?B?YmJwRnMvdUk5NkZxVURQZ0xDdW8vN2UzbmcwKy9ySDNhWHV6WnNoVHJiMnhn?=
 =?utf-8?B?cUlrUDl0SVFFUy9CUGpucGs5ZmFxSS9uc2lNSitXZXlmeE9tdUJYL1IvVExI?=
 =?utf-8?B?RVc1MEhVSjhwNitDTGkvQWFWVzBMRC9oeXJMbjV5OTJWdG1xS3pHYjNmMEJZ?=
 =?utf-8?B?cXZrcmQwQmcrZVhNODgwcTJsZjQ3WGc2d0FMeVpwV2pxTFptUjNRMS9GSGps?=
 =?utf-8?B?SGxTYVp4RzR6VDBFckFaUzNUNjU1THdpVE5jRDFBcWV1Y3o4QnZnL09kK1Vo?=
 =?utf-8?B?b1Vvell6RVVFMFdNMWZwektxYkJ3QWZ2M1VCc3NPN2kzTUNzd3lUeEhzN3Zx?=
 =?utf-8?B?VWRXRmhRVmtCT0lQM1lQMSthUmp3UkFkdEVMN09GY2wyTmVnOXdNWmxKOWFG?=
 =?utf-8?B?OG14N0h3cmZVdUVmb3J2UXJueU5LZmpOSnZzQm05V2NMcEd6QU54aHJJbUhT?=
 =?utf-8?B?NXNsSjN1Ullyd0ZCeDFmTW9VUU9TdnRVdHo4YnVWS1l4UHQzczV4UTJ0WDlS?=
 =?utf-8?B?RW9jTHY3cEN6NG9OL3ZVSDdVdG5rdTZTNVl6Ri9GeElaOWVpMUg4SmlGOUZS?=
 =?utf-8?B?Rk96eWVubFc3eHpPbkhsLzlhVVVNdklZK1d1aXRIck1uZnVPSitwbDR4bUcw?=
 =?utf-8?Q?zXhtwEmIDJ3Cq?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB2667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bVhKRmxPZlZrYlljbU83VUZoZlJOZ0xCc0FWUk5mQzdWY2E0U0NpZ2ZoWHlC?=
 =?utf-8?B?TVJXc1l4cVZQVjlOSmtmTVJrU2NGaWtYdFlHOFZXcGNpUS9UM2FVSmZWa2ZK?=
 =?utf-8?B?YS9RTkdiL3NqK0tDd291RS9kRHo1TFhxUjZreDV3QjVaVE9DbVordWZMSVlU?=
 =?utf-8?B?aGhmWXRaNU01LzM5NXl5Y2g2M3p2YTArSFA0OGloU05CYTh6NHphbjMvTXZm?=
 =?utf-8?B?VGdvekMvSzdmUDJhbG1HVndQUk9OWjVxb0xvdEh6WWpwdGdyQXQxK1N2OUx4?=
 =?utf-8?B?Qk1IQXVqb0pPWUYzd0hjM0d5dHZhRThjVmdBK3luQ2xwSkpYQ1M1NTdyQVFk?=
 =?utf-8?B?SU1xM3F3V1lHQlZtZHlveXNpeEV4YktSU0dSRTRTdTVRdVV4b3BtaE4xTWVm?=
 =?utf-8?B?TklIUzhoTm5CQW5BcnNrNm5wRWlDYWNPVVRvU3o0K0JJVHM0c2dBSllIaXR6?=
 =?utf-8?B?SnpwMUJTUm9XWTZ0NlBod1AvakU1Z2JzMXdxZW5RZ1RYOG5EcFpEVGFqVnhL?=
 =?utf-8?B?V3IzSnVuODREWXZneGd3T1pNbjlpa3YrVnp3L2J5amlSUUdXWHIyV01nRGg2?=
 =?utf-8?B?aGh4aEt4R25mamVvbWV0V0xRSHB0R1NqUk9RaWFMZFdsdXVxdlBucTl4QkpE?=
 =?utf-8?B?THNFZllqRlRFdXNDL01qTFZKSjMyTTFTRGJGNUJLbWsyTHZIUWhBY3lxMThP?=
 =?utf-8?B?d1FlWmpPMFdtYmYrNFhiUmNqb3R2N0VqN1NVZTZsc09WZUtnSWJIRkVGZHdP?=
 =?utf-8?B?c0w4TVZTNHp2WTNiZUppVUJGbnhPRERoakliemJqdFdIU1loODJrbnNyWVYz?=
 =?utf-8?B?L1pjSHQ2NGltbndBNWEwakU4NFg0QURuSkUvenRja1N5QXBtTWtJQWZteXpM?=
 =?utf-8?B?TGppZEtSWHhhSEpHbWdwYmlqT3ZGMkxCTVBOeUhTMUpGMzhZSkFtT3g0Rnhy?=
 =?utf-8?B?NEwzYUowek1QUzlSTU05ZDdDT0JZSXpPTkRLcWt4WE1RNGlrSWVUeDRRNExZ?=
 =?utf-8?B?SlhaR1Q5a28vZDNiTGlRcSswQjQydWFTdlNnVXR2VFA1QWQrYTltcDkrYUFT?=
 =?utf-8?B?QkRxZjB4dnFlazBDRjlrWDJjbVFXWTlLdmwyMVcyRUs5U2pObDl5Vk1UcllW?=
 =?utf-8?B?d2NsUkdlQlRzdlQ4YnZSc29zRG11bFF3R05ScHM5QkxmRGhERE1Gc0hwaCti?=
 =?utf-8?B?clJTTDVhY1BTc1VTWGpKRHNhWXZSbGdscGRCTkhCMldQQS96M0tNR2NHUkZn?=
 =?utf-8?B?ME9Rd0RSVkJIUVRRRlowaHJPVnhxWWkxZk9xV0o0R3FNWnU1ZVFSeGxlRUo4?=
 =?utf-8?B?K1duOSswZzhRZDNUOUhOekhnWEV2NkFxVkdzRWljMS9HbEliSjloQ1gwVHZN?=
 =?utf-8?B?ejFUK2gyVUFNMWtOSWcrSEw4R2ZUU0pBUTVVN0dMYzZLQTFPUTFEeEdXdlcz?=
 =?utf-8?B?eVdCTWFOcGd4Z095ZlFacXhjeXkvd1lpN3lwQWJSbkNtOFRlZ2pHRm5KZU15?=
 =?utf-8?B?aS9TT08yRXlaZitBeExuYkszMzFIMTlkdmJZL08razJqOHI3bGo0QkcwdG51?=
 =?utf-8?B?MzhPVm1rQWFsWWJLWm1Yc1pSUHhLanpWTEVlb0xuOU91M3FIK3ZDdTN6c0Va?=
 =?utf-8?B?czgrdnJ5cFhpcUUrZ09pMmlJUVd6VE9mMEhpazJwRFZGNzBqcU5ESTBFTWFE?=
 =?utf-8?B?cG9UNzFaZVBycE9HK3V6SVpwcFJaTGxCamZySWZTamVFaDQzaXVKS25ZeGc1?=
 =?utf-8?B?U0ZadHdwaGNQemM4eXJRYWs5dFlBYmhyTU5IQkU4QysvRWp1emQrSHJWTldi?=
 =?utf-8?B?S2VTSnVMWHNKdHV1WXFzc21jek9qU1FBU1VnTzhPNVVFY3RZOHZKNjN0U0p6?=
 =?utf-8?B?WXV5aDlVQXhlYmU2NmE1cUloT0twdEpBRXl1Vm5ZWVQ3QWdHTHAyWG1XL3pI?=
 =?utf-8?B?YzdjQk0vRkcrZzJhVStBVSt3WHlSSzAxVEY4L0FycXJBVmhYaEUvbTR6UjFE?=
 =?utf-8?B?THlvUzZjbTVqWVJuLzdCc1VJeklibmV2RG52aStudUR3Z05VYUxlTWxrRnRp?=
 =?utf-8?B?OVdOL29FbC84Ui9aaU9MS3RyeVNEY1VSSWRFUUt4c3R0ZlpOQXJZRy9vWE8v?=
 =?utf-8?Q?tk9Z8huuHN/Vh04dg2AeCcG/X?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf53cbdb-f28b-40be-b013-08dd5cf20047
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2025 21:01:01.4896
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uE71oKkSa+JLK7FP+4+KO5K1JCZ4t094H1FMc08EC3wWp7hu3byssgNCa605nDqXHAmLg0Rzjhkw2cN4iWYM+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7662


On 2/28/25 11:58, James Morse wrote:
> Resctrl's architecture code gets to specify a function pointer that is
> used when parsing schema entries. This is expected to be one of two
> helpers from the filesystem code.
>
> Setting this function pointer allows the architecture code to change
> the ABI resctrl presents to user-space, and forces resctrl to expose
> these helpers.
>
> Instead, add a schema format enum to choose which schema parser to
> use. This allows the helpers to be made static and the structs used
> for passing arguments moved out of shared headers.
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


