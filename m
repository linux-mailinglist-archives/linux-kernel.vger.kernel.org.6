Return-Path: <linux-kernel+bounces-537473-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D84D5A48C5A
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 00:06:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9B7257A51B9
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 23:04:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 094EF23E34F;
	Thu, 27 Feb 2025 23:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="UEvpdET6"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2075.outbound.protection.outlook.com [40.107.93.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E64222576A
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 23:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740697549; cv=fail; b=dO3YPvcLeTRIR48MwfZRjWiFeU1smwU87SdhKzr05uhe8/rhv37UfgrG2E8deqj2vVWuXFb1rGBPWx0Phq6LLnXyKyIDIf0izIZP2daJ85Ygn+W1hCJZ9v/545MoJLIuOtzUxA/u+5vopWsIaKGKkpN14uCb4UwUyxZ87FRP6LM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740697549; c=relaxed/simple;
	bh=E/kT1mwqpsL9J/6rrj0x2ivVSXWiecf5eYNU6JWSxnw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=XinhUxwO1qEIe0f6FpmwCud7uRCoLMzvCMfl0mEUia2sdXEvHkzF41ptfZkr0km2WNgFi3L3SdzCcdpC6q4+Cryx5ITKSuMq3+E7N4VU+xgBo6xsprNX4Ybu/kpIj8U3bxjMD2qvBXW31FDi6iHci5EyIBUshB5uV7AwtXdgPx0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=UEvpdET6; arc=fail smtp.client-ip=40.107.93.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ck6Iy4nH8JM3LOy/xUBHAE9U+llzXO0Dnpds713BRFDPbJWCcgCWitnyV6LkylMEJxBn/NxIpBjzXca5DAGc5PQVflhyxOanb/FOpbCEAaS7YxKIvvn1aTVKuU0rC90HXqA/WFNLRFDjgstTgIBTUss2ejZTdPdWTNty6Cg1nsPcjDgTnNLRjIeEsqDm8LtH1IreCxXByQ8hYl6+Rnq4fqd/OP2qUP8jH69dnsPYhU9RBxHJbAZ6sU5Lmxa+qvgAGydZ+MRI/wiecER7hX6Ezo3Mp2t/JbPivoAiIM/KU/mgvDxBQLkza+6QOIInlCJmkfNcl1LlAcofYYJHY4smUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=28xS0ex9AdhV+QLNhw4aIkSQooTW0fKmLtZnwCGjznM=;
 b=ib5X71UykIRsGZeMm3tF/eZQV8yIHL+lAelJmblFmXcGZTvQ2w4zhTZX1T10WmOPUASDfPa90FtFUhe5sRnviEbf7xYWjNS+/lrgeBlIb5x5HG+ZXTrz6tr1cIrGIWlubwa9oK14eQghCnRXyZepfD/MSa8BjFxB/7KWM8AHWXEAGZe+OJDrONFmE1OCLrg1ZwitzvVTWvdGNxNCZcxNZK6iIJDUY/4rMWqk38N5HD6VAD8YT9L5xY38glfZKHQHu71rX58PGgCW2fQM/+MeinqF54suakNSlJ0R4KRz2kazyXUtQMR9Se/u4v0SOz0cIUKwYRUHeoB2Svj+fpvMgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=28xS0ex9AdhV+QLNhw4aIkSQooTW0fKmLtZnwCGjznM=;
 b=UEvpdET6CnAJY6jLqR50ODU/IqzOtjXPtGvRyjcSJQzNfP1l0tnvyl1WZKFPRpM3tmYfbkCEgUg7zQ0Ro6tCy1ozNBftq+DEATZxRZuKvsuSrnfdrY3cYuHzsOqZfylCHyYz+UxAQZuzc4WkTAPUfjPTsdxP6W27IbsNJ1WJm8Or8tzrMAfyS4dfsuusZJi+dq9yQQGJ3j7+zonRYr6xrqWGuQrlt5bErBOs4xcP23AI7V3I+jTvWg8qAfOetIYHk7MvYjYzHCQF+5RSXM/6dEwAhPqsdOVr0Rj6woFMCY5mJKKm/GN5/uQElIUSHyszBZYbURHJedeJLbsDU0DW3g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB2667.namprd12.prod.outlook.com (2603:10b6:5:42::28) by
 CH1PPF934D73F2C.namprd12.prod.outlook.com (2603:10b6:61f:fc00::61a) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.22; Thu, 27 Feb
 2025 23:05:45 +0000
Received: from DM6PR12MB2667.namprd12.prod.outlook.com
 ([fe80::bd88:b883:813d:54a2]) by DM6PR12MB2667.namprd12.prod.outlook.com
 ([fe80::bd88:b883:813d:54a2%5]) with mapi id 15.20.8489.021; Thu, 27 Feb 2025
 23:05:45 +0000
Message-ID: <d13235dd-fc27-43b1-af88-3a7fe49b476e@nvidia.com>
Date: Thu, 27 Feb 2025 15:05:42 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 30/42] x86/resctrl: Claim
 get_{mon,ctrl}_domain_from_cpu() helpers for resctrl
To: Reinette Chatre <reinette.chatre@intel.com>,
 James Morse <james.morse@arm.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
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
 <20250207181823.6378-31-james.morse@arm.com>
 <c735cf97-dc26-42be-82c9-cb37f96e896b@intel.com>
Content-Language: en-US
From: Fenghua Yu <fenghuay@nvidia.com>
In-Reply-To: <c735cf97-dc26-42be-82c9-cb37f96e896b@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR03CA0030.namprd03.prod.outlook.com
 (2603:10b6:a02:a8::43) To DM6PR12MB2667.namprd12.prod.outlook.com
 (2603:10b6:5:42::28)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB2667:EE_|CH1PPF934D73F2C:EE_
X-MS-Office365-Filtering-Correlation-Id: 6636cb5b-66a4-4a68-2ce3-08dd578343a5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?czBkVTZjL1hzb3Y0bkJLNmJNdS9KUkFvOVBCVEYxejIwdldrTStDVktiRHRl?=
 =?utf-8?B?MytkQzFLOGplZEYvRmREUHRncDA3bW1FNWV3QVpuakFqbHdhYUkvczRlcDZC?=
 =?utf-8?B?eUpUVi9Kc3JmRjExdUpnb1o4aUxXZ3hqejJmNGdTT1JlWjlxTVIxaFRxQ2Rm?=
 =?utf-8?B?SURUQ043RHRjNjloTExqYXEzTXpWMEZMemdTRkdPc2NGeXl3TDZtN21Pajc5?=
 =?utf-8?B?NXdVdFpVUysyVU1EanpLVWpiTlJ1aytRMUJ1VUV5eW5JQTQ2Z1F5dTBOWVRi?=
 =?utf-8?B?L2tzS1VrejQvOTBMRUw1ZGdsdS9JdENMelB1eGhvek1qaURKMy9FZVF1OXlW?=
 =?utf-8?B?UXlqQ1dRTy9BcnpFNmc4eEJNazNZYkpXSmxudFZSZGFqelVCTHRQaFJzRUVS?=
 =?utf-8?B?RFphRVhub2k1S1JGVHh3ZTBEeHZ5NnZwYUlObnRKYjRZZlRwYUlUKytjNVdH?=
 =?utf-8?B?R3puNXdIRDNCRkYyUWdhWEFJSnN0eWdCa3pqNTlsQmwydGVjMmdQZHpwNmg1?=
 =?utf-8?B?UWwwTXNiWUNuY3I1WUlBenByeHpuN1dRZzZZblZUeFdiQ0dKaWczcE5WR2w2?=
 =?utf-8?B?aXNUZjNTVFphejUreEE4QzlmNGgxUGZWbVhuTmd3RzVKRnpscUJvVUhJQ01T?=
 =?utf-8?B?SlNKcTdDK29LOGkzSG45TEtSSThiUkVnTDAyQjRuNGE2WmovWE5LZGs2MXVG?=
 =?utf-8?B?M1JMdlBPblZYRXZjTDVLby9TV2NrZjQ3ck00ZzVGalBzVXRaZDk4cEtmb1JO?=
 =?utf-8?B?SGZMQ3pSa0d3Z0Y4WThNMXNzNXU3Z1lQRStvUFJLUFRUQjYreVQvYUJjVnZr?=
 =?utf-8?B?YnhQRUwxbkdjK0ZzaE9kQmcyUldFbnExYVk3b0tsbjdidFVFWFZvUWFBS2VO?=
 =?utf-8?B?Q1Q3R3ZQVnppTWl2Q0s1eERWSE40VjBwYUg2cThQVTZpVGFuL284SC84dHRN?=
 =?utf-8?B?Y0xJSHNITUJmVHUxMUhGL09RaXFnVloxZENybnYxM1dFTTRJRXVNUFJIZjlm?=
 =?utf-8?B?ekxxREt3eW0wdGxRQVB1WlIwbUwxVk1JampZdm4zTjR1MVV1LzV1cTYxSlI5?=
 =?utf-8?B?MG13Sm5NS1JUZTY5WllKQUUxRDhZZk5nU1ZEQTVQbGk1MVRGY2hvUWVmMkNU?=
 =?utf-8?B?ZmdDdmdobEhMU0xyQVhqa0VHOHM5NG5Fc2lEanB2NzFzV1ZZeFVkM2FwVEo2?=
 =?utf-8?B?dVYxenJDaDdBL1NFQVdJeHJLQ2c4MFhVZFdzNkRMbEk3WEdDL3ErUW5Xd2Yw?=
 =?utf-8?B?Z29rWEJ4T1VmZ3JPblcrVjNKdC9qdk1XbUR0R1puOHhZd1Zta0o2dmJpVjhz?=
 =?utf-8?B?dFg1ZFBrWXdqdWdBSG1hSUVtVDdTaUkvMW0vZnNBK0ZMWGtTQy9OSHcvaVVR?=
 =?utf-8?B?N1o4SFlkNFc3cnVDbTN0VXNHUWw3SWlEalFNb04wMlBvVEVBWUNERjdMUlIy?=
 =?utf-8?B?UFhNYXRDSkp2RDRqMnN1WTZ6dFpTcW85WnJ2UEhnUTl1OW1UQUd2bFhzb3d3?=
 =?utf-8?B?cWJXS29SQkh2eTdRUXdFdVNUWSsvdzdHaEZqeUxSZGV1MVByb09UQ3hRNGR1?=
 =?utf-8?B?b3NyYXdMQm5KemdIRitzNC91Q2pRSHlyckJiZDFBVDZYbll3U1dVdloxd1Bw?=
 =?utf-8?B?bjd0a3A2UlFOanNwa0RkQUpJRWw1aHpxNDlUekdqN1lVM25Nak9MQVhndEhv?=
 =?utf-8?B?OFFKaVdGc0pOTHRaY1VNbUpIRnNsTTZKRVdGb09hMUFCdzVmNXhCYXM5N0RK?=
 =?utf-8?B?ajMzZnpKWWQ5N2JDTzN0SEJEVS82QkVQWkkxR1F3ejV1cDFuSWZSenRTc1dz?=
 =?utf-8?B?Mzk3ZDA5SFJIdEswNXRna1I0cWZqTXhTQjYyTlF3eWo4SEplaDBVNWt0Z0FM?=
 =?utf-8?Q?jzklaHoQTSH84?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB2667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Y3lkaXB2ME5Ga3ZlSzZSdWVkaWhJdGNSOGdTZHA1YmhLanNSRkVTL3k1emdY?=
 =?utf-8?B?ODNxSkJ3QTZPTk9jc09uREk4emoyOGpkVlIwOFN0RVdUdHN4c0p6OVBOWGJJ?=
 =?utf-8?B?KzA1VUhQeEYrVmlGaFdKSTVSb1FoTnFKc0F5ZUJybWs3VjVqWTVmVXFSSzQ5?=
 =?utf-8?B?MlA5MUFSU1dYREpNMHZLVkRvVXV6QU9mQ3M4bnF4QjI5ZEU2Z3Y2dnBVQlU3?=
 =?utf-8?B?Z2xnK2g1bEpvcVo3UjlWTDlnN21UY0ErT3pTdWdDVC95L3pTbXJiNUVxbVlT?=
 =?utf-8?B?TWpxZWtYci9EenQyQnp4NklhNUZiUW9MMDR1TytiUEtCQjJvOUdCbWVFR3BU?=
 =?utf-8?B?REY3WWNlMkV4dXdSazIvWHBKbEVrZk5pNjFEVnJGMW1VU1MrWGJYOW1HdWRu?=
 =?utf-8?B?cXZwN084dXZoQWxvR09oNTE4WHFKTVJuOUhNb2pTZ2hvcklHUm5WY3FvcXNE?=
 =?utf-8?B?TVllS25QYm1MSmpyOUdJaDNiT1FBbmNPU0g2b3g5d2wreFNUVUkxV2tXdFJY?=
 =?utf-8?B?S2pZNEUrYXQ3L0NHMHc4MEZ5dlJHQjdzMFAvQmVtRDdFVTN3SlZCRlU4YkFE?=
 =?utf-8?B?dmM5SHFiNjhXSWROdnIrSjhaSzgyV2VVNDkxeHR1eFd2SnhDc1RBWmhJUmhj?=
 =?utf-8?B?aFhIQjB5NXlTSkZuTXNCdUp2VUthNmErL1pmWXpZWndrYmFuRjhwWW5uRm8x?=
 =?utf-8?B?alAwc0t2VUoxQWR1SWMvNkRmZkpMU0ZwTkQ0Q2V2WVdQV2NYVHBQWG9sRWhG?=
 =?utf-8?B?N00xKzB4QVdocW1jbDJ0dG44ZkEwc0dPbmhuWlpxU0VWNm41WUpaS1IvQVA4?=
 =?utf-8?B?RW1GK3BMaWIyRGZaNGg1QzFweUJ6dTRyTG1EQTg5S0lOUnpUTk5TTjB3NVRW?=
 =?utf-8?B?b25vanJWMDdJQTdBMjU5OE4rUnhJREhCeitHRmpUTVNxSlhkYzhLZkJTQ0ZY?=
 =?utf-8?B?eXZpQnJJajJseERxNEUwUXRJNnh3bEUyRXNWL0tJZmJ6dCttUTNCNml2bXg5?=
 =?utf-8?B?bGw4QmhkM0JXbHpodFpsRzhZZ2hSekJieGplbkNySXpINGVSR21QRGJBVE9Y?=
 =?utf-8?B?YXBuS1lBNVhKaHErREZ6QzgzUlpONWRpblc5dWpUR3c3MzNMWFFoYnpqSzEz?=
 =?utf-8?B?ZGRab1JFamczcndlTjl2OStLNU9pbmoydnBFd2JJTHpUSjRvUDdpZGhSc2xj?=
 =?utf-8?B?QkNJbkU5QkZuVW1nOW05cTVjQzd3RlZLS2I1WEVCMTdoWmcyNXFQMzlNMDVQ?=
 =?utf-8?B?UUR0N1dqYk9vSXZlRjRmbFgxdExVa2MyNld0N28vdGdEcE1EaEcxNjIvQmNz?=
 =?utf-8?B?MERKUmRLRWFCb0xTZm5EeFQwbzY5TXlGVWxCVzc0VUtieFdOemc2dHRGVkVh?=
 =?utf-8?B?MmRQSitXQnY2ZXJmWEttSkZZNFM4THNEV3FhK2dDNkJnNExhZmVIYjg3RmlH?=
 =?utf-8?B?eHl1WGFQQnloZVpCY1ZxaE9BZm0xYlE3cEVlU1BNRWErQm0zVUtpK0YrTVpU?=
 =?utf-8?B?MjVycXM4dE4xVnozSkllZXRMOE5US3J1eHRRNjkwdEZuamxIaEljV3BhcnVD?=
 =?utf-8?B?UmMyL1hab3QzT1FnVkdQbFd0WlpzMmJaMys3TGhPR2diMTMxanZrc09Za3ZB?=
 =?utf-8?B?bFVLSWM3OC9GZzdpVGlxVTNka3M3aHlneCtNR2NzMDl0SXNhY3FpUzJOTU5N?=
 =?utf-8?B?VkZxaWZ1aHFad3hQaUZkenpNSjBKSzJTTGxqc2xpVVROY2NHYXZKNEJ0d0pa?=
 =?utf-8?B?ZmoxUTlvdThpZGkyRUZwOFFTNm9DV1U2YThWc1pCdHExWEtmMEVFOVhqZEw5?=
 =?utf-8?B?ZDhiN3JQcU1wQjVuOWFsN2NiMnZHMTNUMEQwM0cvY1JIUnd3WnVBMk0wTVpD?=
 =?utf-8?B?b1ExMmgyMERpRHJERWw5ay83OTIrblFkdFhodnJWS2xYNzlPZnNteU9PMlFM?=
 =?utf-8?B?OXQ3SnROWE9lSURPeit0N0JBR0xQOUNNNjZ3YmFJTnFqcHFnckNIUzJ2NSs3?=
 =?utf-8?B?VDNIbFV5ZW1rcXZDbWVQTVo4dE4xNjd0NTJMYmNrNGxjUzJoM09DbzVJU1kx?=
 =?utf-8?B?bHRJcU9oSS84R001WlBFc2VnQUdFZk1GYVo2bFFiOVRINlQyTEJFcVFpUTFP?=
 =?utf-8?Q?13UhaQpTVH7lWQ6CeCDRB4DL0?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6636cb5b-66a4-4a68-2ce3-08dd578343a5
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2025 23:05:44.8399
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UcgrLzZ0ogE1gplzarGsynwvExnYsCj2NgQQ9SVnmp6LuJF9jpLSg2xVy4x50b2AXkaf9X3bgHFDerrQnTFwWA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PPF934D73F2C

Hi, James and Reinette,

On 2/19/25 20:08, Reinette Chatre wrote:
> Hi James,
>
> On 2/7/25 10:18 AM, James Morse wrote:
>> get_{mon,ctrl}_domain_from_cpu() are handy helpers that both the arch
>> code and resctrl need to use. Rename them to have a resctrl_ prefix
>> and move them to a header file.
>>
>> Signed-off-by: James Morse <james.morse@arm.com>
>> Tested-by: Carl Worth <carl@os.amperecomputing.com> # arm64
>> Tested-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
>> Reviewed-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
>> Reviewed-by: Tony Luck <tony.luck@intel.com>
>> ---
>> Changes from v5:
>>   * Added the word from to a comment.
>> ---
>>   arch/x86/kernel/cpu/resctrl/core.c     | 30 ---------------------
>>   arch/x86/kernel/cpu/resctrl/internal.h |  2 --
>>   arch/x86/kernel/cpu/resctrl/monitor.c  |  2 +-
>>   arch/x86/kernel/cpu/resctrl/rdtgroup.c |  2 +-
>>   include/linux/resctrl.h                | 37 ++++++++++++++++++++++++++
>>   5 files changed, 39 insertions(+), 34 deletions(-)
>>
>> diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
>> index e4b676879227..921c351d57ae 100644
>> --- a/arch/x86/kernel/cpu/resctrl/core.c
>> +++ b/arch/x86/kernel/cpu/resctrl/core.c
>> @@ -348,36 +348,6 @@ static void cat_wrmsr(struct msr_param *m)
>>   		wrmsrl(hw_res->msr_base + i, hw_dom->ctrl_val[i]);
>>   }
>>   
>> -struct rdt_ctrl_domain *get_ctrl_domain_from_cpu(int cpu, struct rdt_resource *r)
>> -{
>> -	struct rdt_ctrl_domain *d;
>> -
>> -	lockdep_assert_cpus_held();
>> -
>> -	list_for_each_entry(d, &r->ctrl_domains, hdr.list) {
>> -		/* Find the domain that contains this CPU */
>> -		if (cpumask_test_cpu(cpu, &d->hdr.cpu_mask))
>> -			return d;
>> -	}
>> -
>> -	return NULL;
>> -}
>> -
>> -struct rdt_mon_domain *get_mon_domain_from_cpu(int cpu, struct rdt_resource *r)
>> -{
>> -	struct rdt_mon_domain *d;
>> -
>> -	lockdep_assert_cpus_held();
>> -
>> -	list_for_each_entry(d, &r->mon_domains, hdr.list) {
>> -		/* Find the domain that contains this CPU */
>> -		if (cpumask_test_cpu(cpu, &d->hdr.cpu_mask))
>> -			return d;
>> -	}
>> -
>> -	return NULL;
>> -}
>> -
>>   u32 resctrl_arch_get_num_closid(struct rdt_resource *r)
>>   {
>>   	return resctrl_to_arch_res(r)->num_closid;
>> diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
>> index 0d13006e920b..c44c5b496355 100644
>> --- a/arch/x86/kernel/cpu/resctrl/internal.h
>> +++ b/arch/x86/kernel/cpu/resctrl/internal.h
>> @@ -475,8 +475,6 @@ unsigned int rdtgroup_cbm_to_size(struct rdt_resource *r, struct rdt_ctrl_domain
>>   				  unsigned long cbm);
>>   enum rdtgrp_mode rdtgroup_mode_by_closid(int closid);
>>   int rdtgroup_tasks_assigned(struct rdtgroup *r);
>> -struct rdt_ctrl_domain *get_ctrl_domain_from_cpu(int cpu, struct rdt_resource *r);
>> -struct rdt_mon_domain *get_mon_domain_from_cpu(int cpu, struct rdt_resource *r);
>>   int closids_supported(void);
>>   void closid_free(int closid);
>>   int alloc_rmid(u32 closid);
>> diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
>> index d99a05fc1b44..470cf16f506e 100644
>> --- a/arch/x86/kernel/cpu/resctrl/monitor.c
>> +++ b/arch/x86/kernel/cpu/resctrl/monitor.c
>> @@ -773,7 +773,7 @@ static void update_mba_bw(struct rdtgroup *rgrp, struct rdt_mon_domain *dom_mbm)
>>   	if (WARN_ON_ONCE(!pmbm_data))
>>   		return;
>>   
>> -	dom_mba = get_ctrl_domain_from_cpu(smp_processor_id(), r_mba);
>> +	dom_mba = resctrl_get_ctrl_domain_from_cpu(smp_processor_id(), r_mba);
>>   	if (!dom_mba) {
>>   		pr_warn_once("Failure to get domain for MBA update\n");
>>   		return;
>> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> index 5fc60c9ce28f..08fec23a38bf 100644
>> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> @@ -4274,7 +4274,7 @@ void resctrl_offline_cpu(unsigned int cpu)
>>   	if (!l3->mon_capable)
>>   		goto out_unlock;
>>   
>> -	d = get_mon_domain_from_cpu(cpu, l3);
>> +	d = resctrl_get_mon_domain_from_cpu(cpu, l3);
>>   	if (d) {
>>   		if (resctrl_is_mbm_enabled() && cpu == d->mbm_work_cpu) {
>>   			cancel_delayed_work(&d->mbm_over);
>> diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
>> index 29415d023aab..511dab4ffcdc 100644
>> --- a/include/linux/resctrl.h
>> +++ b/include/linux/resctrl.h
>> @@ -3,6 +3,7 @@
>>   #define _RESCTRL_H
>>   
>>   #include <linux/cacheinfo.h>
>> +#include <linux/cpu.h>
>>   #include <linux/kernel.h>
>>   #include <linux/list.h>
>>   #include <linux/pid.h>
>> @@ -399,6 +400,42 @@ static inline u32 resctrl_get_config_index(u32 closid,
>>   	}
>>   }
>>   
>> +/*
>> + * Caller must hold the cpuhp read lock to prevent the struct rdt_domain from
> struct rdt_domain has since been split into struct rdt_ctrl_domain and struct rdt_mon_domain.
> I assume this comment covers both helpers so perhaps this can be "to prevent the domain
> from ..."?
>
>> + * being freed.
>> + */
>> +static inline struct rdt_ctrl_domain *
>> +resctrl_get_ctrl_domain_from_cpu(int cpu, struct rdt_resource *r)
>> +{
>> +	struct rdt_ctrl_domain *d;
>> +
>> +	lockdep_assert_cpus_held();
>> +
>> +	list_for_each_entry(d, &r->ctrl_domains, hdr.list) {
>> +		/* Find the domain that contains this CPU */
>> +		if (cpumask_test_cpu(cpu, &d->hdr.cpu_mask))
>> +			return d;
>> +	}
>> +
>> +	return NULL;
>> +}
>> +
>> +static inline struct rdt_mon_domain *
>> +resctrl_get_mon_domain_from_cpu(int cpu, struct rdt_resource *r)
>> +{
>> +	struct rdt_mon_domain *d;
>> +
>> +	lockdep_assert_cpus_held();
>> +
>> +	list_for_each_entry(d, &r->mon_domains, hdr.list) {
>> +		/* Find the domain that contains this CPU */
>> +		if (cpumask_test_cpu(cpu, &d->hdr.cpu_mask))
>> +			return d;
>> +	}
>> +
>> +	return NULL;
>> +}
>> +
> Similar to previous requests, could you please provide a motivation for
> the switch to inline?

These two functions are moved from x86 core.c to resctrl.h (same as 
restrl_find_domain()).

If motivation is to reduce one file (fs/resctrl/core.c), would it be 
better to create fs/resctrl/core.c and host the three functions in the 
.c file and remove "inline" in the .h file?

>>   /*
>>    * Update the ctrl_val and apply this config right now.
>>    * Must be called on one of the domain's CPUs.
> Reinette
>
Thanks.


-Fenghua


