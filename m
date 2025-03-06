Return-Path: <linux-kernel+bounces-549946-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D95D9A558E0
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 22:35:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 06D99175917
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 21:35:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 123AA207A31;
	Thu,  6 Mar 2025 21:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="cZrHBO5A"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2088.outbound.protection.outlook.com [40.107.93.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B18721F63F0
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 21:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741296899; cv=fail; b=iHPv5D+RjwzqW0DVU8wRCdHU1vp9R+6CXxm678dT1jRKO6NKMR0zzA2YneVmg1xOhC/qhkxvccmPFuhtrvBjEaYf0udqe9OGdkSw0aAiP70Lxoy/8c2ufHb3nuRsO2SlA6uKFMtmbG8Q2+4wz/foei8VHlFyE2qIjN/8K0QKGBw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741296899; c=relaxed/simple;
	bh=1daGWIlUK4a2y82kGiRCqCPx3Ay0p9Vhi7U+bUtWH+E=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=lXNrszrhyN3PErobi2XQ5V5yySlFf+0gvYk+SGjJEjS21HHj7YsxeNkyu3X+7jANLiL9uh3Tp20OZU3bn+y2A36DmTgUmLJspqDnkTKEMBfd/IimCrXVHkGUEvHPAPUA5jQvw7xHADdrgdLomZ5eoIpMhwtAlAuwYvkzun/qs1k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=cZrHBO5A; arc=fail smtp.client-ip=40.107.93.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hWzSjLCGb6gIcSfQ4zVtsfemGutnwo6On0EVgVyVOHZTcKpdU+n0odBy2zKJpkdvzAFGLDjWWFcKuQ6ljVNrY48COObUvZl5tMBRo07pf58ex0IClOXWn/oC8z2NXgeEoCyDmj5no/qvMJutyXfid8hU4uCkY8XIRR8tj5DCkuIXk3mAsnuogDssWo01HjChfR3NX77D3al3B/4xWGgAnAXUTi8prL2jzjekYmI44JQmsxFS1Vd99QCA5uutSt1hTdoITP5mxMVDYZaJYyDl4MN4Kf//j35S2ZkC8L2YZXeisN3lZkQvaiJnwcyx6OclOWr0j9BH+RtpBn5Mr2SGBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1daGWIlUK4a2y82kGiRCqCPx3Ay0p9Vhi7U+bUtWH+E=;
 b=RZADQVIU3jZ9Lp8PMwYO9mRV4Y3AfzsRIYMn0OeS9hsqIK2RKnHtcHetntETAng7SxwdY4Jssr1cifAwolb5GpRBzPXEzijhxQoCH0u31tHaSXe4jfFU3oJyaeAmxaZRSVa1Vjd7jA7VVI+OpAyewybm6nBcV0d3tZQ/5RBAkwKy297H0yAw+RhXefrs4Ss5W6VIJj7Md9THRTqKtWuLNnW/KrsmSBjFK0KcT6wAwCK8AlV89O2mG42XT2RCnnjJBnCl/k0Gg+A0BT+TyymeB7yo6RkBwUP5ksKWE8brkEz1uhRiH5UovRDKptS3PJpzfQu6uo67tRuxUUxpyEbUcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1daGWIlUK4a2y82kGiRCqCPx3Ay0p9Vhi7U+bUtWH+E=;
 b=cZrHBO5AxZctvOy+OELrT3vYZV8nL/ape8C20KnFDear2SATWmtruCZsXePSgbx/Bi/Q18Tq3jXW4A6L30kmGDeWd/KcDpHIPNE9sTkqS29kBjTsHckvSynKlidhKzCxcj9xJS6hYCz0kbBKDO6wDijR0ByvLs5Oke/bhzi3cRxsiiQZ3nXrQ0rwysO887bNiWCDanBpT60BsYhzeH6MO7Mly6zPvSOZWhLdx7z8AHxmSKB2hSr+jtwZoRoMQPxllJLCqAQtUVREAF/tWaKiYpEO4z8Xci67JVMndff7cA71VSq5CK0Xa+iQu1fC5p3uGZRW/KimXqCHpDa5/xWz7Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB2667.namprd12.prod.outlook.com (2603:10b6:5:42::28) by
 SJ2PR12MB7961.namprd12.prod.outlook.com (2603:10b6:a03:4c0::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.19; Thu, 6 Mar
 2025 21:34:55 +0000
Received: from DM6PR12MB2667.namprd12.prod.outlook.com
 ([fe80::bd88:b883:813d:54a2]) by DM6PR12MB2667.namprd12.prod.outlook.com
 ([fe80::bd88:b883:813d:54a2%5]) with mapi id 15.20.8511.017; Thu, 6 Mar 2025
 21:34:54 +0000
Message-ID: <cd86ffc7-0bb4-4524-b8eb-9af39cba988f@nvidia.com>
Date: Thu, 6 Mar 2025 13:34:52 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 23/49] x86/resctrl: Add resctrl_arch_ prefix to pseudo
 lock functions
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
 <20250228195913.24895-24-james.morse@arm.com>
Content-Language: en-US
From: Fenghua Yu <fenghuay@nvidia.com>
In-Reply-To: <20250228195913.24895-24-james.morse@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR03CA0008.namprd03.prod.outlook.com
 (2603:10b6:a03:1e0::18) To DM6PR12MB2667.namprd12.prod.outlook.com
 (2603:10b6:5:42::28)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB2667:EE_|SJ2PR12MB7961:EE_
X-MS-Office365-Filtering-Correlation-Id: dd7f3e1d-7136-418b-16a2-08dd5cf6bc4f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?S1ZZUlJkbVhOZlhyMzdMd2dPNmZTUGEwODh3dUp4dTRKQitEUEZPWUlHWEkz?=
 =?utf-8?B?WVNRZXh5cWh0MitxOG5ZSzdIVnEwOXhJeVkvOExCcGdvOXVZMVJBdkpyckRz?=
 =?utf-8?B?cXg1S0NXVkJQa21kam5nZDN6K3MrR2VwNThISW5PNHJLcmM3SWdXNFJTaEF5?=
 =?utf-8?B?NTMvV3BwcG1zS0RkVEhkSXpidGF6cXEyVzUxZWhNSzdrdm5ZdjdTY1JVY0Q5?=
 =?utf-8?B?Y0NBN2dTKzhOUG0yMEF1eDZxc2RQdlh0VFhjcUhETlh6bS9ycS9IREZiQkZY?=
 =?utf-8?B?ZlRRMkV1NHY5SDZndzFmeDBId2VpbmZzV1d5YmFoUWlRL1V3NlZJL1o0Z3d2?=
 =?utf-8?B?NTRiMTlyeEZCSEw2cFlpYmRTT2NQbVlsSHVVTmV4bS9TYzhxVXNlbG5aNEo0?=
 =?utf-8?B?dklNL0JPbFBHeHBnd0RMNFo5Mll1ay9tVDRNTnZodG1vNzJZZTYvazE4TjNG?=
 =?utf-8?B?dzhQMHNrdjB6cXNPRUJOVHNnUVJqYlJoeWUwOHJJRW5jU2ttelVtbitvWjlV?=
 =?utf-8?B?MHBObzhyaWl2MGsySTFtY0JuT3M2ZlZsT2QzNnFxOGpUc2NPR3lHcjF5eTBH?=
 =?utf-8?B?RjhDZ2Q3SkZkWVJwcWJJdEZUL2c1d2t0QUxWWHVUSzllUStWZDYyMzVzUjZv?=
 =?utf-8?B?Q3Nna2hQZ05pbDNiWkVDa3Rvdk5DTkJ6MWY3c005bHRlSlpXQzBVRE0wbnAy?=
 =?utf-8?B?Y0VEK2N0ZFRoelpQejBON3JRNFlvMXE5UnJNZUVFTmJ0SG9xb0VJV2pmdXdi?=
 =?utf-8?B?aUZkYmtLOXMzcjdUSUd2R044cVJDMUlHSWhMVEdiVUtERGF4WWY3RW92b2VF?=
 =?utf-8?B?UjI3cjQ4dHNhU3Y2L3oyc0xHZm1aR051dFdzQi9DS2tQMEpoS0NrajBwRGxV?=
 =?utf-8?B?STVwdFl4QS9UTlZQUkJEZjRsck1lM0E3cXFnQlpuQ3gyN2hibFV3a01zWVo5?=
 =?utf-8?B?QVJsYkdQZnpzNGNSQmRSTE1CR0g0YWwwaytjc3lEZ0toOWcwbWtMSW1pczRh?=
 =?utf-8?B?YWxWZ3FvdUtDbHoyLzR3Q3lYelNpa1JyUGRtTDQzM204T0J6UzI2K3F2WUNW?=
 =?utf-8?B?U0habkRQYy83bGRZVGpENFN4aEdYRjYvWVV0eEdyWFpSdWFnTU5YakZaMGhH?=
 =?utf-8?B?Y2pwTndmaThMbjJLcGc2b2FFN1pSUnZ6QkhRdVZFK2pzUG10V0JaQUppajRU?=
 =?utf-8?B?eTg2WHUzekc5bllwemh3RThyRUo4ZWF5Ymt2QWN3VVhpemFySGNPSDQzaW9h?=
 =?utf-8?B?OXNaL3RsY28yMmFQRGQrZFU2amFFbzB3dVZYQURBclRxRVczNmhhOWc4S0VT?=
 =?utf-8?B?Nm56aHBtbGYrd2JFRytmSHdDNy8xNUdyRXFuVG9HOXJ6WFNkMGEzRWFTb2E1?=
 =?utf-8?B?MkQraVl6RzIvdWREWG9reC9GVGRrVFV3WE9pcGNxKzlOVEViaWtOWnEyT3lJ?=
 =?utf-8?B?K3IzK0x6THpmSStVYmd3U1hKN1FWK1VDZE5qWFZ2SzlHMEJxTFFBLzNBS3Qw?=
 =?utf-8?B?MmhDbUZIazF2SysxYzEyc2l4QXZUY3FQMk42VVc4YTMzNHNhUFlwdlc0Nkx6?=
 =?utf-8?B?YVRNYndrM2R2c3pHY0RabFlsQVdWN3lvOFdYZmh1NDQvU1VxdFN6YVdXWmlr?=
 =?utf-8?B?NU9hZytPTldRS2NsM2ZkZUxkczQ0NHhIVlVJWUxUMEpFY3AycXA0ZGFobFFX?=
 =?utf-8?B?RVpaN3NCVTVwSkczWDJZV2JkOU1MUGErNmYvSXF0STVGelBuSU54cnB6SnhL?=
 =?utf-8?B?NG1pSERHVEtMOXdZVzk5aU44TldtaDlrUHdLWVlqaEEzbmtiZzB3NzBTdWhn?=
 =?utf-8?B?b2RBWFhPMElqVUEwQkdZM1pjUVd0RllKUHlhVldzVXpNYm81WGR2SFRrcDNL?=
 =?utf-8?Q?VOsELczl3sIyq?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB2667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UmZuTTBkSVN1bC9WSGVVSkFCdU5KOEorM0dQeXQxSHdoaXAzdzE3KzM1YUQv?=
 =?utf-8?B?VVRHNEI5RWMvejJEREN6bTM2d2RFdlJpNW02TnRwMHRNYW1Ea0tJUHRVcWpj?=
 =?utf-8?B?N2lhaWhibTdMaGZUc3NGVmF2cUV6ajYzQ05UVXdEWWduajA3d3MvWExKODZS?=
 =?utf-8?B?TkNYN0xEbzc2aGZJbjBWU0N5YmtHQW5JYTloL0ZaMFpTdkJWaHFqU3ZpenNz?=
 =?utf-8?B?UzhqVG9lcW1ESjdDYVFDTlhrRW5wVGY3ZXNlc3BwbGRpNDcxd280WjNqVTFl?=
 =?utf-8?B?eGM0MDBWUFlqZ005aW5ZQStBU2huL2hBaUk4ZURxbXJETG1PNHRMRGxKTiti?=
 =?utf-8?B?OHREMGZJU3JyVDVFVmRJT3kvMWw1bDlVcjV6T1Z1MlpYUzRRbUlIWmlWc1Q3?=
 =?utf-8?B?Q1RtR1VKcmlHUkxxaG1vQktXVk1JZUIzTDdmU0xVdFZKY2dRNU90elVDMmJm?=
 =?utf-8?B?bnZ4ZGxnWXJ5UW1pY0hKSVFlUWF5NHcxcTdDNXJDUjFwWUFUaWZoMjhKVURV?=
 =?utf-8?B?YmpHTlplS0lteHhoc1NNLzE3a1UxR0NpN3Y0RjRxS0ZOdW9Ja29xMEh4cU1j?=
 =?utf-8?B?VVNNMVVvZDBxY01qbmk1c01wWUx1bUJ2ZUYvcHlzbVNtaFE4TEo0amxDdmlt?=
 =?utf-8?B?aThISVFURC9mWks1ZFFGeFphakg2ZU5SRGgzMEhJSjJGV2pHRHNsbkNVNUFu?=
 =?utf-8?B?MXVEUUVwRHNPbFZMV2Y5WE96UUo4Nkx3NGs2RDdyaFRTc2F2MUpqYW5yMHRn?=
 =?utf-8?B?WTZBYVBTVHlqd3U4WXBpeVlQY3VWTEJjT3hzT3pUeUVTK3MyTTE0NGZ4aVl6?=
 =?utf-8?B?WHZLc3NOVFhvZ05xek8zZDZpMjJtMXRBRERrNk9IeFk0c2szSEJHRHVBb1VN?=
 =?utf-8?B?NnB6VEU5Q1dGZjcvMm1vVlNwZmJ5SCtPMCtxS0RRQ2NvZ3VCYjlqV2xjRVQr?=
 =?utf-8?B?VS9vbXhEVE9lT3NjOWhLeUpoemZwNjRMbGdpczNSdlF3ZDZYM3hIb3ZaTEJp?=
 =?utf-8?B?NHpBU3RENzh1VWg0Z1Q2V3F6bFNKSnRKQWdvRkRRbWpHeElwN2lVc3VsMVV5?=
 =?utf-8?B?UytrbTY1MHJJUmFwVXpQNWQvbTdFcWoyUUMzYTQxOE1DbWk4R2NRSHlKZDRh?=
 =?utf-8?B?cGI5UzBjRDl2WEN6dXU0dXRpSHVZNTdjVVZMNWV3ZFFvZGVXejhlQlUrRk5r?=
 =?utf-8?B?ZkNETVdzWFpiZjZPSHYzTmpiREw1cERZQlp4NHRCYUZIcGRJaXhocWx1VUMz?=
 =?utf-8?B?UjlpbWtjRzN1Um8xZSt4M0RQWVVaQk5Ua01IQnl3amt4OWsxODNkRXp4VURm?=
 =?utf-8?B?Ly9mcjhhc2svNkNDSkZxUG5jZ09XLzV3aHBqMG52TjUwM2poaFNCSDkzZU85?=
 =?utf-8?B?V3c5cmlhcEp5c0w3b3kxMWs1eGFzK0tKcFV2bDdEVERTWHRIZThKUUZQYmVy?=
 =?utf-8?B?OUFmRXF5cUk3UVJ2elhRbXJuTTZpRndQLzJ4cURQMStzdnVwdXlXTlZVeFQz?=
 =?utf-8?B?UHgxRDA0OXVmMW15cHloa3BVLytCNWROQ0syWVJDMFVwZktCazNidmpwNFlE?=
 =?utf-8?B?d01mb2tZKzVIMU5IQ3F3VFBHZGF6VDJOTlZTTUp1Q25qSHJsMGFhU3dZcng2?=
 =?utf-8?B?ZVQvRzk0VGRXSG5PdngvemxNN3hVYTJ3RjZUYmpENHVzMjJ3cS80WkR4VUZB?=
 =?utf-8?B?YkRrVmFDYjhWUGpvdUg1bWJKSUJIMzJvdmx4NVVObk0xK1hTaHRzWnRxK25R?=
 =?utf-8?B?MWdvOE1oRkJzeHdhd1BIMjlXeDg3TEtuUzJVQXZTbWpjU0lDZ3BZVlBpZFVI?=
 =?utf-8?B?R0xZWjFja3dwalQrcFQvSVhyMS9PaXhGbEVTdE5rVEEwU2hJNWZnYmYzdEZT?=
 =?utf-8?B?NGthcHZYSzljY0RXV2JlMEYwanJrZVZMNTh1cCtMc1dVbDNTSWZNUzdva2lV?=
 =?utf-8?B?N0o5eEZnZXhjTEwzVyttSndaMWQ3bkZHR3NBT0dBeXRHWW9iY1lhMGpIRVFQ?=
 =?utf-8?B?YytPYmsrUzE0OVNUMUJNcjZUTXMxUUFIN1o4d3JwN3NQWSs5WUFGRUZQSXdq?=
 =?utf-8?B?MFhpTnh5SFJtbFdocndtRUU4YWxVZ001RGdkRkNIak5jRlFjNUhML1p5MVlF?=
 =?utf-8?Q?LD8G+pssVUB4rGxsb0gY8GdDe?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd7f3e1d-7136-418b-16a2-08dd5cf6bc4f
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2025 21:34:54.9335
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: E9LRo6xWMcED0KGCqarQ69FWQzuj3z+mUZYzXH+cd+573x2Elb4O4Q/vlmapAFd4RSChb5Bpx98UqbK5LGK21g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7961


On 2/28/25 11:58, James Morse wrote:
> resctrl's pseudo lock has some copy-to-cache and measurement
> functions that are micro-architecture specific.
>
> For example, pseudo_lock_fn() is not at all portable.
>
> Label these 'resctrl_arch_' so they stay under /arch/x86.
> To expose these functions to the filesystem code they need an entry
> in a header file, and can't be marked static.
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


