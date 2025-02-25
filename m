Return-Path: <linux-kernel+bounces-530508-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C103A43463
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 06:03:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 38E413A5C58
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 05:02:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 666752AE72;
	Tue, 25 Feb 2025 05:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="jkniRn2A"
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2087.outbound.protection.outlook.com [40.107.92.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C651436D
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 05:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740459741; cv=fail; b=t1f98nqhJkF2SMN2DvemcEq/MA66EXpEyumO8XZxSw4Bd9u4OhJVPgn9n1cIn9OP9V4dOtjyx9qzz/kg5zvSd2AHcK+ACsq9g9esO2fLnjMLyE0QKPZJw9ZIGDkCL01jMVB3jeJl3uetz3pBWQZeXkKvsbpqVHxau8QtmkRK4OY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740459741; c=relaxed/simple;
	bh=3uCl/s1utn+pkygwmqKlgAbDrQ+pqypBCwY6MqC8fWY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=R7x4uuIJ/G4h0j88QASDUpXlfeC/6VuFprw3VHg0B2yCjFw7o/PEznENwz5ufMIDewa1Ww8cL7tofZc3DEIJlFhaxEHC9A40XrZUNii/QpLqI6J7R+7XcunirVoDuBf7w6G6I4GUcMfswpzDgXzl3zkMzaVgHiT0zNOQ2rShnME=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=jkniRn2A; arc=fail smtp.client-ip=40.107.92.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ujhnHuQqV+hlu1euVFMEHio2iX9czBCsbnt5PZJVdVnQu9fWbWoH2uu++Pan/83Vfs4oYv+NsVAwW3cOXKfxikoVPwf4xT9lUSknpDuMQggwYBuHo8mnCbiQUR22/d4yDYXH6QM/D2TMFQzjTRTulxW1rxOhZlUnVhm1+i4CVBdyoo5fxF0IRYBTk3TGoQc/o01F5OEFLtZVydufoVwiDdOfHYHz04acAM29Mjwzr8dmaoiMOnBIjWQp5HXllmvwobvn72eCgoMxAzwoz5qAdCZtFLd82rDHIluGCvUu5lu/FozRPHAbD9ACEoejhmslU+rNzRvR5xfP+newNb3Nwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xqiRF4yuVepwx9nloS4/+tVrlubwEwhNOhS4mmsm2TE=;
 b=Jvr3/mtCG3E5i4Qh6K9N21BZse0gJDeLrSRKKMjYwRue5K9NVvsy3sywdgYqzezCAF7QTCfneUS+x3DLl9ep3PSDXMq7tIa9bOarr8Rz+duiO2+ZNVI8EAf07x9DD5A4gQF/MfFZ2RSbzGdwHkWt4WfdW3aygf6KO1W77X/y7E1IFaqK2ZkNv8CelEf6cH/RbZiZYPE8v0KllgZK2rC+NKJ1J46tB/j0339lM5AyPJfKHmYcTiair8fau4nHHs5HKcFXRn51AUIhMsURpPAlnaN7IDjA+MGN3mRha+EhHB4tVWNErhilkkdsv2WIrBycOzJOi0AMu6rX73O9RWVbRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xqiRF4yuVepwx9nloS4/+tVrlubwEwhNOhS4mmsm2TE=;
 b=jkniRn2ANT/6Oa6eEdaUXf6D4ScL2BaJPnizM+macyKra1hhhHUMlinVSa+vncAqb7ebj8+76Xp/2KsX05n5kHngUsljhPxIwC4lYZmuIqqjt1hwouVGMErznCMIcQ0NAhFMUk/tHz/cMcKr8mjFFEuoGBcQ46PlqHNIC4FBYxnpVGiUhlKwFHdyISHdnyA2+lVb7vK08DCb5GShcPTj/5PnyQmws/cAku13Dy0hhG7TXS21dYQGPAbJyqQ8HUizzyhJURsVhn28t8y36oK6PJaLHjERVrnjD4DfN/BEAwufIuPHhRbxED/KE5m8F2W9yPl66ZF3bPVlirGuysjyRg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB2667.namprd12.prod.outlook.com (2603:10b6:5:42::28) by
 PH0PR12MB7079.namprd12.prod.outlook.com (2603:10b6:510:21d::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8466.20; Tue, 25 Feb 2025 05:02:14 +0000
Received: from DM6PR12MB2667.namprd12.prod.outlook.com
 ([fe80::bd88:b883:813d:54a2]) by DM6PR12MB2667.namprd12.prod.outlook.com
 ([fe80::bd88:b883:813d:54a2%5]) with mapi id 15.20.8466.020; Tue, 25 Feb 2025
 05:02:14 +0000
Message-ID: <c86d773c-75c4-4f7a-96e0-5f36768c3981@nvidia.com>
Date: Mon, 24 Feb 2025 21:02:11 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 42/42] x86/resctrl: Add python script to move resctrl
 code to /fs/resctrl
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
References: <20250207181823.6378-1-james.morse@arm.com>
 <20250207181823.6378-43-james.morse@arm.com>
Content-Language: en-US
From: Fenghua Yu <fenghuay@nvidia.com>
In-Reply-To: <20250207181823.6378-43-james.morse@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ2PR07CA0019.namprd07.prod.outlook.com
 (2603:10b6:a03:505::21) To DM6PR12MB2667.namprd12.prod.outlook.com
 (2603:10b6:5:42::28)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB2667:EE_|PH0PR12MB7079:EE_
X-MS-Office365-Filtering-Correlation-Id: e7de91ba-65d3-463b-8938-08dd555991c7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?K09iTUdNanFvbDBmS0U3S0s5S3Z6U2hKNmNLR3Y4NUpJditLc0FMb3g4eGNa?=
 =?utf-8?B?aWUvVXB2M09mUGV3ci8xSGZFWjlCVHBNQmZUdEZML1RueXQ5MmJFMk1sVzlV?=
 =?utf-8?B?MGxnRlp4ZEVCalI1bjJRRW5PV3lmSktaQi9zSjRHVUtWTkhUS3JCTVJtU2dW?=
 =?utf-8?B?V2xYTm5UWmFsTmpkLy9IUVV0SG5uUHd6c3FpcDVxblZFVGo2bGdLb0RORzJS?=
 =?utf-8?B?NkFhWXh0SmhHL1RlZDVNbjN0YjBycEFXcHI5RVJnMFNLeEdKcmZzWXRSZTZp?=
 =?utf-8?B?ZGFTWjkyZ3grcHpUWDh4c0Zhc1dKdVFKMnJ0dDJpS0xWNVFvSVBUbG9HdXZR?=
 =?utf-8?B?WlhtWW8rblJJdWdhRy9hUWUyMUwwL3JRVEN3bGNBQ3lWZVN1b01COVAzMm9v?=
 =?utf-8?B?eWpobWNRNFVUdll1WmdyaXJQWFh2a0haUzQvZGZEbzJVRDJ2Tmt1V1NRZWw4?=
 =?utf-8?B?UFBETFc5Nyt1NzNSU25GRTVJbFRuRHJJN0NBME5BcGJUSndhK0hwa3IvVXll?=
 =?utf-8?B?Q0tQb3h5bVQrRU5zUDVmclEwanFzZ1ozOW5EOVdTenlJWVlubUxzbXVmQXc2?=
 =?utf-8?B?cmxQeTZlYnIrY3lHZDMwMUhVd0I0eEoxcXYzMEtTSk9EME9XTURzVjlMSFJX?=
 =?utf-8?B?WEhWQWM1YWRoYXF1RFNpS3JRSWlrZm1xNWM2VHFLVWJZK3dpVTMvNDV1MnJM?=
 =?utf-8?B?di90eS9ocCsraUlzaDlqMHZLTVFZdmE0cnRFQUpDK3g2ejQ4UjdMdHJKNXRL?=
 =?utf-8?B?TWFlejYyUWkxRzZMTHpVcVoxbXFLaEhLT3l3dTRwR0tPSGJMM0dzS3VYeVlk?=
 =?utf-8?B?bGZzS2NkNnFNSXEvV0NvbDZVZEZLdEE5ejNrRkRDTmJYN1hVZWtXNW56RjBL?=
 =?utf-8?B?Q0ZWSC82Zmk4dkxEWUNsc0NLbWxGWEU3UXNRM2NISGVqcUdIY1duVEthSWJm?=
 =?utf-8?B?S1Rxa0Z6UzZGYkdWcUcwK3lWa1VLZXlSSVl1citvQmRlaHlZVFFJbmVPTUJs?=
 =?utf-8?B?ZFpoL1RPY0FOYmhlNEdFTmFxelh3WGxzVWZvM3lJc05yb3B2V2FGb0VDRzFW?=
 =?utf-8?B?ZkRDdnFFMlFCaTZ6cjd3SWhZVjZpTkdLQXFweS9GOVpCS214cmlXNTJnNVIr?=
 =?utf-8?B?TWxKWllBZUtwNHlOelJmY2JGd3VxNkN6ZmRYSVBWZkRkdWlqbEFRVi8zMlJ4?=
 =?utf-8?B?QllaTWlqMmxrK1hGa3FBN3Y2eEJCd1hTUkJWYjJsZWcvaExRejQxQlFBamhZ?=
 =?utf-8?B?Q0R5aFIwd2RjUUVTTUU3alV5VXBBdGRaMTJQS2JDbVFMVDFXcVVMU0FHQ3VZ?=
 =?utf-8?B?eWtoR2NpRDZXZlVjbE1BUXhDOVY2TzhNOTF0WUZ4UTlFaE9IYmIxcXRjRmRn?=
 =?utf-8?B?MkNiTzlRQVIzV1dpVzVIZWFDcTYzRnRUYlQvYUtYSk9TK29PQkJ4aHFEM1Bm?=
 =?utf-8?B?V3VBNEdvMmZpZEdDYkhmM0h4WUg0MmhTVHRZMlBZakF1MVJKTHd4WXdwYUVH?=
 =?utf-8?B?VmFhbFpqWER5UHVOMWZSTGJqbS9VOVRhbWUvK1JaL0xhUjQ3ZnJVekpqK2Nj?=
 =?utf-8?B?SFJlSDdaMCs1UWF2T2oxZnprS0pDYTV3V0Rsam1tclV1M3llNkd6Z0dlMHhQ?=
 =?utf-8?B?aTU1WnI0RGVVbUU2Y0Z0YnhSczY3VmxWRlMvUXRPWmI2MCtBcVA5emlJU1lX?=
 =?utf-8?B?c0J2K01TOVNmUGxIdGZzQlFQVUlsQXpJbU5nSWFnc1FsWDBZbndoYkF4THgr?=
 =?utf-8?B?NEZrc3VFRXVFZzdlaTNwbDlNcWovZGxkc1NzbmczL3d1RjFDQWJDbFp0cWY4?=
 =?utf-8?B?bXN0cnZ1L0RjQnFTSytlRTl4UTloR2taQjk3TUhOVDR1dS9hb0pzVmtBRzM3?=
 =?utf-8?Q?B6vdtyO6qEXfc?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB2667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dG5LOWQwWGxWUTBLVFE2MmhFb0V3aXdwMHhSQ1JucXJhQi9aN3UwaTROTmdi?=
 =?utf-8?B?NGtqSlVDVG5ia1RKMk11UzVaSXpsa1JIWnV0SWhDNFY1MmNBOTdlSko2VmVn?=
 =?utf-8?B?MGxINmtneVV5Z2xTbGxNUHBqaDRxTUpLWmtlMFdnUHoxc0NGR0MwMnlSbUND?=
 =?utf-8?B?TDA1MTdPdG9vc1dOcFlUaUZ4VnBpckFuNFNGTHJ5RnJwUGxpS3hzcjUyaTJ0?=
 =?utf-8?B?SXk1aGc0a01va1RwSXpudm9JZ0lrYzUvdUE1RkZJWWpTRXJxTG1ESVhRK29L?=
 =?utf-8?B?WSt2b0h4TXV3Zk40M2h4K2hpVWdLZWZNZ0piU3N2eFBYOFYzNmNzZnluNGRu?=
 =?utf-8?B?MXJtL1duMUhUbUVNZmczcUhDQnFIOWoyT2pIQzRTZW0waEFsbGtqeGU0cTVE?=
 =?utf-8?B?a200QUdUaXBNSzVBTkN0M2E2eEQrbUFTakdkQ2ljWnVHUnExZ3JaSDRyZFYw?=
 =?utf-8?B?ckdzSFlvUzU3RjR0ZlZPSGh0QXkwTHB3Z0pQeGl0eWo4OWt4T1RaOUdha0VS?=
 =?utf-8?B?K1VUdUxMWVU2Y29ORjl6MjExVnJlZi9pQjRmKzljdWIvNy9KeGxJRzVqbkJk?=
 =?utf-8?B?SmJpQyt6RXZGTDFzVndGTFdQMllMN3ZvdGF0TjQzdDBJY2JRSk1JUWhMYldC?=
 =?utf-8?B?Zk1Qd2J4UEZrSFVEelNobXh3TDMzc1lkdUVBaWpFempldXRWK25Gc3FkeFhJ?=
 =?utf-8?B?bWtnRDdvVzUvQUIxMllZcURPOGprV3crVXhwUW5GSmp4L0NkeW1iazBmbEp3?=
 =?utf-8?B?bC84YklxQnpyM1pCUUJuMUlBZ2dnUVlWY1VmUCtlL2txVktvd1hQSmpCYzRC?=
 =?utf-8?B?UEl4bHV2SlpLQkd3Tk12ejJySDZMZTVUZzd4VmhSRmhCRU1kUldvMHVndm5Q?=
 =?utf-8?B?Rkx5U3d3Z3JpdW1TSnZ4WTQ1Y3kvb1dtOGNuTmlxRTNNYWdGUnFnb25vazJS?=
 =?utf-8?B?QjVUVmpJVklSOFBReEpZdHFEbEdHZ1ViL0xDV1kyMWZXbExtdGdtaWE5VzJi?=
 =?utf-8?B?NFRyS05MaXRZYWtLSFBUZGJrL3hIc01rZEcvRVhtUElLbU1qK2cwSlpxT2FE?=
 =?utf-8?B?MmR1QjlQQnBaYXlPK3Z1MlE4Y0hQUmtMUE5taXZCR3hGN2xkVW9NQ1Y0cVRt?=
 =?utf-8?B?akpXbSs3TlN3WmZ5OVFCNDZsdVloSTczSEw3bnp6OXZjZ2FYU0dUN2ovSzhQ?=
 =?utf-8?B?cDlRZU9oa3RmWHl1ZEErSkNGVnQvNHJBQnhnOWwvL2VDTUN1QWdaR1pKL1Iy?=
 =?utf-8?B?WXVWR3NTdjhySVFQZnZSZm1UaTdXMVkzVnpYUDl1Rm1QQWVzTUE3blNUR0F2?=
 =?utf-8?B?enljWlhTMUs5aTZ3SXVuaHVwNmJnRzY5UDJZSGRzemdIYWNWbEV2MVYzV1Q5?=
 =?utf-8?B?bWllKzR2ODhwdmpuVjRGR1VPQ1FUZVFLSzVKRmtHVDN3d2N4TTVwbWkvRjhT?=
 =?utf-8?B?RXhjTDdPcjFtbXZSTFZMSkJPVVl6N1ZaNmRRY0VoMkZQZm5mSzk2Nm1QU0ZX?=
 =?utf-8?B?SzlMdTFCKzZCNVpVbGFqczN3MXhjbExLSHkwYVFGOXI2NG9JOW5zYUpldlpJ?=
 =?utf-8?B?dWFVd0RHcFpJNEF4UkNCZHJuVXB4dnA4QVJMYVhUcWRhWHFFRUd5WlVMOWZh?=
 =?utf-8?B?aTdrc0VEWEJ1bGE4TnFaK2ptVFlUQzd4cGV6Z0dNNXMzNVNSa3ZZcGVpVFlR?=
 =?utf-8?B?Q2hEVEJHTEtGM1pXaks5d3EvbjhXUE1XVGxNWERVbEhTbXFyVXZhbzFHZW05?=
 =?utf-8?B?VEVkRjVWZkZSMnk3V3lZdDB5WWZYTVBkMGt3M01RNGdJUk5zSkgwWURrcWE2?=
 =?utf-8?B?TWt6QkExVGc0VmVSdFRiQjZCSlcvdkZEU29oU0FLWVJSU250cFgrNC9CUGtK?=
 =?utf-8?B?RjNPM2c0WUdMeDhINk54bzJRQ1NwWUFaNjY5U25XTXlxcm8yUXJ4MDJac3hn?=
 =?utf-8?B?M3VyeFA3UW1OempWVDRUbURveEVaU2VoUFRnblVOSmYrYWNLSERlcklDc0lp?=
 =?utf-8?B?L0xiSTVjTEpCR3B4V2lpQXRzQmFkN1ZhUzJUNlpLcU5CSnJNaXdOdSs2ZG5m?=
 =?utf-8?B?b2ZGbjNUSktrL1crUVZRRFBYanlNRUZuRWs0Q2h0N0c0MEwxekVJSmJqaGpX?=
 =?utf-8?Q?ovUB3qA5zEnl/R2wixrxSquyA?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e7de91ba-65d3-463b-8938-08dd555991c7
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2025 05:02:14.4378
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7+L+HkvCKXUwB1yzI3ioB5BYDTeAkA+wrR4HqSBBQEh78JPiNjwldDjzwPBlJtwJ5CTXNix/84R59/qFdEeGeQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7079

Hi, James and Reinette,

On 2/7/25 10:18, James Morse wrote:
> To support more than one architecture resctrl needs to move from arch/x86
> to live under fs. Moving all the code breaks any series on the mailing
> list, so needs scheduling carefully.
>
> Maintaining the patch that moves all this code has proved labour intensive.
> It's also near-impossible to review that no inadvertent changes have
> crept in.
>
> To solve these problems, temporarily add a hacky python program that
> lists all the functions that should move, and those that should stay.
>
> No attempt to parse C code is made, this thing tries to name 'blocks'
> based on hueristics about the kernel coding style. It's fragile, but
> good enough for its single use here.
>
> This only exists to show I have nothing up my sleeve.
> I don't suggested this gets merged.
>
> The patch this script generaets has the following corner cases:
> * The original files are regenerated, which will add newlines that are
>    not present in the original file.
> * An trace-point header file the only contains boiler-plate is created
>    in the arch and filesystem code. The parser doesn't know how to remove
>    the includes for these - but its easy to 'keep' the file contents on
>    the correct side. A follow-up patch will remove these files and their
>    includes.

Due to no trace event defined in the _trace.h files, compilation errors 
are reported when building kernel by W=1.

This patch seems the "follow-up" patch mentioned here? After this patch 
is applied, no more errors reported when W=1.

diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c 
b/arch/x86/kernel/cpu/resctrl/monitor.c
index 1809e3fe6ef3..800e52845b1d 100644
--- a/arch/x86/kernel/cpu/resctrl/monitor.c
+++ b/arch/x86/kernel/cpu/resctrl/monitor.c
@@ -27,10 +27,6 @@

  #include "internal.h"

-#define CREATE_TRACE_POINTS
-
-#include "monitor_trace.h"
-
  /*
   * Global boolean for rdt_monitor which is true if any
   * resource monitoring is enabled.
diff --git a/arch/x86/kernel/cpu/resctrl/monitor_trace.h 
b/arch/x86/kernel/cpu/resctrl/monitor_trace.h
deleted file mode 100644
index b5a142dd0f0e..000000000000
--- a/arch/x86/kernel/cpu/resctrl/monitor_trace.h
+++ /dev/null
@@ -1,17 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#undef TRACE_SYSTEM
-#define TRACE_SYSTEM resctrl
-
-#if !defined(_FS_RESCTRL_MONITOR_TRACE_H) || 
defined(TRACE_HEADER_MULTI_READ)
-#define _FS_RESCTRL_MONITOR_TRACE_H
-
-#include <linux/tracepoint.h>
-
-#endif /* _FS_RESCTRL_MONITOR_TRACE_H */
-
-#undef TRACE_INCLUDE_PATH
-#define TRACE_INCLUDE_PATH .
-
-#define TRACE_INCLUDE_FILE monitor_trace
-
-#include <trace/define_trace.h>
diff --git a/fs/resctrl/pseudo_lock.c b/fs/resctrl/pseudo_lock.c
index d8389779835d..6c49dd60174f 100644
--- a/fs/resctrl/pseudo_lock.c
+++ b/fs/resctrl/pseudo_lock.c
@@ -29,10 +29,6 @@
  #include "../../events/perf_event.h" /* For X86_CONFIG() */
  #include "internal.h"

-#define CREATE_TRACE_POINTS
-
-#include "pseudo_lock_trace.h"
-
  /*
   * Major number assigned to and shared by all devices exposing
   * pseudo-locked regions.
diff --git a/fs/resctrl/pseudo_lock_trace.h b/fs/resctrl/pseudo_lock_trace.h
deleted file mode 100644
index 7a6a1983953a..000000000000
--- a/fs/resctrl/pseudo_lock_trace.h
+++ /dev/null
@@ -1,17 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#undef TRACE_SYSTEM
-#define TRACE_SYSTEM resctrl
-
-#if !defined(_X86_RESCTRL_PSEUDO_LOCK_TRACE_H) || 
defined(TRACE_HEADER_MULTI_READ)
-#define _X86_RESCTRL_PSEUDO_LOCK_TRACE_H
-
-#include <linux/tracepoint.h>
-
-#endif /* _X86_RESCTRL_PSEUDO_LOCK_TRACE_H */
-
-#undef TRACE_INCLUDE_PATH
-#define TRACE_INCLUDE_PATH .
-
-#define TRACE_INCLUDE_FILE pseudo_lock_trace
-
-#include <trace/define_trace.h>


