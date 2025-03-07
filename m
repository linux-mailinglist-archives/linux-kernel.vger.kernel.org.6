Return-Path: <linux-kernel+bounces-550320-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1513DA55DE2
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 03:51:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F1FE63A8F93
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 02:51:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F047C188904;
	Fri,  7 Mar 2025 02:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="IAwV5TMR"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2080.outbound.protection.outlook.com [40.107.93.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73F5E7E9
	for <linux-kernel@vger.kernel.org>; Fri,  7 Mar 2025 02:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741315872; cv=fail; b=GVbCo9k76UFhRIikvaT38agogikOlVIMnJ1YU1fUA8eLuxlAThAeU0iMIzOQzVPdnCpNCe7C4WLUOAm2nGbqLfZjbBmzFZCMYRcSpgK9JGNdzVLBLPUAsXg1fR7e03VsioeAUH+8qDGAPyPJZ5h2ig4JTeA1YDOQpjv4YqM6q1E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741315872; c=relaxed/simple;
	bh=Ju3ejI8YO6sgw0Q1M7n6M+rVjz7+ZRdF0IxUp1HyEB8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=lERQ7u4VBEW99RqUZfk/JKMvDPMYHxl/ZQTRcYjTWssicuCPtWKqte1Qm6BSZPsWfHHFvdNZBjRkNaSwBHuA/mqEU4qns3szfhfsizBeK7/J8zL9m/mj3KxbOabYbkX/MouMiQEND/LE+zQrxZmgglg85RFp9aM6DAPRNU3Q8xw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=IAwV5TMR; arc=fail smtp.client-ip=40.107.93.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F1n/33+N0rm0Q/UqteGXjd1ItPvN2QQ44QDzYYqXX5ze2p0Z14zdUAZymfoE0s+UJ77Tc9/4YHU/XRLHny5+3HVsWO6Fk8056OiFQlbF4va6ta7Areuw9q3vFwEz8AGy5SAflEcaVR4Ll4VhSFoUUo83c9TJJCLofaPAN6GcAHVEUaRwxeFeb+WiiClUcDH4GpuUEZvo/o8/6NjrB0+3hOFVNAbQovT9q3t9MgpXX7slsxXDitM20o3wVJSsTVCyghKJM4YOp/cujdn1f8Onl8awe74ca+3ztlqvLmG1Up9j4CBQH51K6gUtjD/5Hai9CiMcc90hyl8N8LEX2tEZsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ryyK2vVoP59iZzBzUNdihgEbo1Rls1ZtP3D5ASxOsy8=;
 b=OXooR2ia9rPm1sATfwyc12LzT7FhiOcMfoKi8+6wrDPTkh9mHbD2MifM7CCDjYjJz52LCTkFNdetVTIZyOYtNlMvCz0i/QC0m1qExcV0qcgeLKeETtRP6GRe90YVk0u334cStWgQs5dDDTfLkbB003eovSIP4qYfkNnRHNv69kDR+yvhnxsik2j4lmj10ZB7VLep7weUHrD/vKt2ZPN9dP+YWVwzoi5iM51uKkSHo+prQt0M8TE8vRaddiaohQz/p33IagzK99o9sCO4C98vTLW2GoykyU50pSyx436s9csoVhs6OKRzVIF2mYwQ9cGFSfp/OyyuU0qncYJfYiydwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ryyK2vVoP59iZzBzUNdihgEbo1Rls1ZtP3D5ASxOsy8=;
 b=IAwV5TMRVHlz17iAC6IRQhGIf8OIjFazQsnbj4iNiS2mbbjIxdAu6gmVI3fsum8rpyngD+CY+pMm0reEyJjG9CyruaT42T/UlkpUVYBX23wH+RuhJZMvC889tkGGaJU8Xq1Of0qEedDPSeYDAKd8hFYfuInVXQObNBAp+PsZVQfFsZ7cKd0cDZPrRX2bF76Qu0U7tnORu2eY2PaWxIJR9LHOnqe4KoAVZZeyjFw0THissxJD4bQKkPc6KlDhn9yiV4p0HGY6kx2EFx40d5BPSa+OVDeQGKzDsy1XlAvE8HkOTJ4BtAfb+ygevE/fioASa4Bb8huHKi4zs8Pf4fZHpA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB2667.namprd12.prod.outlook.com (2603:10b6:5:42::28) by
 LV3PR12MB9354.namprd12.prod.outlook.com (2603:10b6:408:211::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.19; Fri, 7 Mar
 2025 02:51:07 +0000
Received: from DM6PR12MB2667.namprd12.prod.outlook.com
 ([fe80::bd88:b883:813d:54a2]) by DM6PR12MB2667.namprd12.prod.outlook.com
 ([fe80::bd88:b883:813d:54a2%5]) with mapi id 15.20.8511.017; Fri, 7 Mar 2025
 02:51:07 +0000
Message-ID: <c22159a6-f41a-4205-8763-bfc6c948a019@nvidia.com>
Date: Thu, 6 Mar 2025 18:51:04 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 44/49] x86/resctrl: Relax some asm #includes
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
 <20250228195913.24895-45-james.morse@arm.com>
Content-Language: en-US
From: Fenghua Yu <fenghuay@nvidia.com>
In-Reply-To: <20250228195913.24895-45-james.morse@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PH8PR15CA0011.namprd15.prod.outlook.com
 (2603:10b6:510:2d2::28) To DM6PR12MB2667.namprd12.prod.outlook.com
 (2603:10b6:5:42::28)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB2667:EE_|LV3PR12MB9354:EE_
X-MS-Office365-Filtering-Correlation-Id: 60919177-2de6-44e5-e8d9-08dd5d22e87a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cjkzaFpFTHhZRmZTMjNCY0FseW5qamU5UVJxU0ZWQkVXc3JsaHh3TEVVaHp1?=
 =?utf-8?B?VGhjRTUvaFgzRjBCczRzelkrYWhaYW1nbkZIWDd5YkEyeE9ReXJJYTZBQVZF?=
 =?utf-8?B?aHFRWkJzbnlrTGdvckZNVEZaTHY0UzNLQUlOcXFkWUZNMmdoNFZIenBpdGwy?=
 =?utf-8?B?YnhiOXJJZ3Y2dmNUZVQvdDlWZ2xhL09BZzhVSkg3Z1pxTmJ5d0ZHNlJPRXB5?=
 =?utf-8?B?VXIwL0NVU0oxU0c1eWZXMDduOEhYZG9lbUZsTlhUQU13Y1pJSzJNczRqYUlq?=
 =?utf-8?B?a091RmlqQ3poK1FrZURUTWFKbm9DVCtqL010MHVOSEtuTnFmb3kzWm9SaUIr?=
 =?utf-8?B?VW1IdzFxMDMwREdZMVI0K2NJWVRKTkIraFdhTWZqRXBzWld1T3ZtZm1SY09K?=
 =?utf-8?B?ZFRCZ1dvcU1IaWZzQWc5azMxQ1dRRVB3cElHbDRnNktQRWJVWUlFQmVqTCtW?=
 =?utf-8?B?TkJ6eG9URExUYTdZRFJTTzNLYmpuZUhKeDhLb0ozQjhpYnRpYkZ5SHdOek9j?=
 =?utf-8?B?UVZ4RUlJN2FtSWZnVk5HY2dPaldRRFl1Q3dtZXpxaExpQTJNd0FVYnZLNmdX?=
 =?utf-8?B?Nks2ZTVPamdTdGQ2VFQzb2VaZ1pEdHlUSzlNNGMwSnZUY250d3NxcjhROTRo?=
 =?utf-8?B?ay9IRTdwSjhYRWxWckV1bTFkNnBwcUFyamMxRjRmWHIvQmszQnRFNmFRNi9w?=
 =?utf-8?B?NFFnckxCWC9jUnQ1MVlnNnJOZmdZOC9GRW5DNVBVQ3psRG5lMDhHbmE1SS9n?=
 =?utf-8?B?ZDN1MG9zZjQ4TzZiKzNZRW5CY0Q3NlRDR3R5OG9RZ0E5TWEzVnFSWFN1b1B4?=
 =?utf-8?B?MXBVRytOd25lVjlNR3RrODlmZEs3VzJCbkxIUjI5UVFtdG1lU1NaQXJ6Ym5K?=
 =?utf-8?B?QzZHYzZwbmN3UitxaC9YeGFhbEtacUN4ZDFna0hEcTJUNVJBbmNVUWtxVFZT?=
 =?utf-8?B?MDI2VFQzTE8yd0haRHlDN290dVhoc25CMncwa25UWkJVSEVSQ1hSNEk1N2lo?=
 =?utf-8?B?ODdHbkxZbXFWSDdYdFR1MVN5Q2VmdUp2dzR3aDY5dTlDWUgzMFRtaitmVUlv?=
 =?utf-8?B?ZzBvSU9HM29OMGF2NjhHWDJsd2p4bmdIRW50TGVIMXFGeW8weXFwTEY4eWFY?=
 =?utf-8?B?bFQzSHpvRUtTNkNJclVOZWNxR3pNakhMejJaU2tVWTRsY1FqanRoS0szV1Fw?=
 =?utf-8?B?VnNwQ1Byc3daVzhyeE5Vd2FNblJzeHFwWEZsYXA2N0plTHJoUVpucit6bFZ4?=
 =?utf-8?B?R3F1b2RMMXc2NEJGNFFZc25XZzJ3UEExb0grVXN3K0xaa3JTWnMyYWgyZ3RB?=
 =?utf-8?B?cFBFRmZyQklhY2thS2QwTnNnSkxIUG5vNlRMbUV0V2VDb0x3cEZNa0VsV2Jj?=
 =?utf-8?B?SllWYzNVY2RDK2w0bktMVzVUWXNCbmJzWmJNc2RlckQ4bFFpeGN4QlFRL3VN?=
 =?utf-8?B?eWc5ZGRWL1hVTjR4SjNrWllObTdOTmZrdGJtdVMxT0Zod3JpMzVqOGhVQ3lD?=
 =?utf-8?B?T3F1UFQzRk93cjM5U0JmZkpwejBnQm51d1RYV09Ec3pmMlJqR25uaGwwd1ph?=
 =?utf-8?B?RTE1SGlrNlBIMitkbnQzT2hKYTBiYmQ1aDdDZVRiM0xaZFBlUXZ1N0hVTXBq?=
 =?utf-8?B?NlI3aEFFTkw2VEMvUTcvckxQSmZBbkpLQlpUdE5CRFZOdTIzaDRxQmRadlNW?=
 =?utf-8?B?Zm16UnFlYzdDQ21McjdiRnJjcnFYMWtJclRpUUtBZVB5bTZuRUJmVm1MN0xj?=
 =?utf-8?B?SzdBY2xubnNyUXFENTVRTkVHTWtTR2hDeTBQZkxzT1RJR2R3YXVpMUZ6OEpU?=
 =?utf-8?B?RENTRk5HUTNwVVVWcWY3S09wcUVuZUdzOXR2T3VPRlBDcTRyUnVNSWhxN3VM?=
 =?utf-8?Q?fUC/EKX6JPCqT?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB2667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aW95ZHVxZjRCZVBFK2VWalpMcEZ2V1lNckxjcC8yNUhabi90dXZWNmN6Q3ZE?=
 =?utf-8?B?N0hkSkhxV1BrNHNHakIvbC9pdk1GNnFXWG8vbTN2L2NKM2lza1dPUmtmNTZn?=
 =?utf-8?B?V05ncm9jWENlSVFjUFhmdlBvYjFJWGhlYUtGNDk5Y2IvUUtOVWR5M3lzSkll?=
 =?utf-8?B?cktZRkhIQ3U2NVQwYUVsbnlnR3UzbVdIREZEQ2dkcTFNK2U5Rm9kQW05Qlgr?=
 =?utf-8?B?ZUgyRDU5L0FvY0tGMncxQ09jNDRhbTRmaFRPSjRqZS8yNHBPdTNyZkVJY0I4?=
 =?utf-8?B?NDFodzNmRHdONEFGelNBMzNWenpSekdCbkZHZUpPakhselJacjZPZ3hBUW43?=
 =?utf-8?B?ZUZBc2Z2c2Q2Ry9nU3pMNFZtMWh4djZldTQwcXdZYzI4eVlkOHRUdy9UUTRn?=
 =?utf-8?B?RmVLTUNDT0Y4aHFCcW1rY3A3T3E1b2J4WG5qMytPUUVZR3p2V1ZsV3QrRVln?=
 =?utf-8?B?SlN2cUxKVXpGMzFkMzhlem1ma2tMMk9HUjFrTm1nZ0Q2U3BZMHlLcThtWTNZ?=
 =?utf-8?B?T2lJbktXbW9VUTRyMysrS1NvSDVLd1g5NU9DL0FTdFdQdmJaQWJZUnloajBW?=
 =?utf-8?B?N3BoS2RpQ0xmeUxMMExQbDFLdXdXVVNLb1I1WXNrbVZYT0cwWjJmcm84QUdV?=
 =?utf-8?B?bDdZWEtYTWk1RnNJS0NYbmpJSitFLzUxV3M4Ti9pNGhpZ1BwbEdKdlJkMHFI?=
 =?utf-8?B?WkFmdVhtTFMvdE52NWhacEk4eFBtbWcwYUNPd3F5WjBKRUgxZUIwZWYrQXRn?=
 =?utf-8?B?cVAyODJoZEZvVkdPVCtjSmw3WXk5MVVKc3JzVHdzOVlKZ0VHYnZxLzR3MWlM?=
 =?utf-8?B?NmQvYXBwUStGQUtUYnlVUzUwaks5dmIyZEtpaG9XWDJZL3g5RTdRSVdmdGZx?=
 =?utf-8?B?VWxaRjFBYTI1NHBFa254MkNaUDJidG9SSWNLeTJDdFBhcm16MWJDK0Y4aUpy?=
 =?utf-8?B?Qk53Z3NoNVI2S3VBUVgzR2V1LzBHYUlwVWFWdWswNHo2RVJQa3FlNndCRFFl?=
 =?utf-8?B?SnpVTjdRQ0swR0ZCRHAzSm5EN1FjeVg3REVXU0Mxa0l0K0V4SkxsRS93K082?=
 =?utf-8?B?NUNhYXQxeGwxRWxVcTlqOXlKd0hCZ0R2OXBCMVAyOTRoWUZjSDByV2wrakd1?=
 =?utf-8?B?S1N6WFkyYTdsVEdWRXZTcmEvV2NTY3Z5empLMUhvcHFobUI1M2lPamptVUwx?=
 =?utf-8?B?SHp6alJwaVdTblJ3clBUTXlsTHdiWlA4RDBoSUtFRHdjZ0VFaTNJUHR4TnhO?=
 =?utf-8?B?UTZBMUFiMWxUWEpZMzRJTW0rMjlFanU5WENyVGZqZU55RitObFRBV0lKZjl4?=
 =?utf-8?B?b1lZeTB1bW91WEkyaXlsN09URGF2MXF6aEl0d01tVTNiZDQ4Wnd0UFEzSkhu?=
 =?utf-8?B?VjkvMkVmRUZKT3J6SnR5bDlibGg0QU9uNWZUc2REQmZHTlhnUHhiUDhTUHA1?=
 =?utf-8?B?aTBMUU9Jb0lhT040eWcvWmNOMnkzZU1UQ1ZMUlFyb3pjSmdLbnNLSWtmUzdv?=
 =?utf-8?B?RC9JWkQ3eHJaV1FnZGpmL3NtOHdIb0Rlak9wbkIxNVBZekNzVVFnUlhXNDNY?=
 =?utf-8?B?S2cvemZqaTlBZXlRVUVGcmswamd3OS9VWWgwZmN6dkJYcUhESmlVbjJ0azE3?=
 =?utf-8?B?WkEyaTRrcEJ5MHpINUtmOTd5MkxzbXFxQ3lSdlZOUGRSK0t1UG9Ia3VLaE1s?=
 =?utf-8?B?NEE4c2ZxNk0wZnh6bVFwNUlkMFliMlBLMWY0cW9MSENwaXdKMENqV1o1V3ZQ?=
 =?utf-8?B?M1ZFSVRiM09RcmtNZXBmNWw1bkdjUFhQN3ZLcmN3ZG5aSHBuQmF1SlJ2Nkpq?=
 =?utf-8?B?ZDNKYmZxVEpUcFI1QThuOXp6UmhSeGZWQUk3OTAyNXplMWwrMnFSVHFLTmNJ?=
 =?utf-8?B?ZHZnOVBTK3I0QTJMNUVQMDEzdWllRmdwRlk3NDEvK3paV0hXZEtKVVg1RHJp?=
 =?utf-8?B?RzFaSkEydVZwZTJYeHV5ZWR4MWZKQ0M0MmNkQmZ4VDROR1NEbU1UYXhpS0NY?=
 =?utf-8?B?M1h6ZFlRaktmZWVmYVBTajduTTdXVy8xRkZDRlFyVGdBKzM0RklwWi9CNjBz?=
 =?utf-8?B?bVRGUWRKL2pPdGRqVHFrUnJ1RnUwLzkwcjIwUjE5UDBDV2hSZGtybndHVG5F?=
 =?utf-8?Q?A4ZfMytQOrh30pyA17F0nQmBk?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 60919177-2de6-44e5-e8d9-08dd5d22e87a
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2025 02:51:06.9071
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3CUIyl6jzUZcYBM0947i1VB9VEfnuZfCiPnyDZeS2HdyFjFeGQ4vmL1PLMkJPdyuYVldZyLmN1czuBO3YjzffQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9354

Hi, James and Dave,

On 2/28/25 11:59, James Morse wrote:
> From: Dave Martin <Dave.Martin@arm.com>
>
> checkpatch.pl identifies some direct #includes of asm headers that
> can be satisfied by including the corresponding <linux/...> header
> instead.
>
> Fix them.
>
> No intentional functional change.

The commit message doesn't mention the rid code changes? Maybe add the 
message or remove the rid code changes (which are not essential in this 
patch set any way)?

> Signed-off-by: Dave Martin <Dave.Martin@arm.com>
> Signed-off-by: James Morse <james.morse@arm.com>
> ---
> Changes since v6:
>   * This patch is new.
>
> Changes since v2:
>   * asm->linux for resctrl.h moved into an earlier patch.
> ---
>   arch/x86/kernel/cpu/resctrl/core.c        | 10 +++++-----
>   arch/x86/kernel/cpu/resctrl/pseudo_lock.c |  3 ++-
>   2 files changed, 7 insertions(+), 6 deletions(-)
>
> diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
> index 93b51d522bc7..6ed0d4f5d6a3 100644
> --- a/arch/x86/kernel/cpu/resctrl/core.c
> +++ b/arch/x86/kernel/cpu/resctrl/core.c
> @@ -60,7 +60,6 @@ struct rdt_hw_resource rdt_resources_all[RDT_NUM_RESOURCES] = {
>   	[RDT_RESOURCE_L3] =
>   	{
>   		.r_resctrl = {
> -			.rid			= RDT_RESOURCE_L3,
>   			.name			= "L3",
>   			.ctrl_scope		= RESCTRL_L3_CACHE,
>   			.mon_scope		= RESCTRL_L3_CACHE,
> @@ -74,7 +73,6 @@ struct rdt_hw_resource rdt_resources_all[RDT_NUM_RESOURCES] = {
>   	[RDT_RESOURCE_L2] =
>   	{
>   		.r_resctrl = {
> -			.rid			= RDT_RESOURCE_L2,
>   			.name			= "L2",
>   			.ctrl_scope		= RESCTRL_L2_CACHE,
>   			.ctrl_domains		= ctrl_domain_init(RDT_RESOURCE_L2),
> @@ -86,7 +84,6 @@ struct rdt_hw_resource rdt_resources_all[RDT_NUM_RESOURCES] = {
>   	[RDT_RESOURCE_MBA] =
>   	{
>   		.r_resctrl = {
> -			.rid			= RDT_RESOURCE_MBA,
>   			.name			= "MB",
>   			.ctrl_scope		= RESCTRL_L3_CACHE,
>   			.ctrl_domains		= ctrl_domain_init(RDT_RESOURCE_MBA),
> @@ -96,7 +93,6 @@ struct rdt_hw_resource rdt_resources_all[RDT_NUM_RESOURCES] = {
>   	[RDT_RESOURCE_SMBA] =
>   	{
>   		.r_resctrl = {
> -			.rid			= RDT_RESOURCE_SMBA,
>   			.name			= "SMBA",
>   			.ctrl_scope		= RESCTRL_L3_CACHE,
>   			.ctrl_domains		= ctrl_domain_init(RDT_RESOURCE_SMBA),
> @@ -998,7 +994,11 @@ void resctrl_cpu_detect(struct cpuinfo_x86 *c)
>   static int __init resctrl_arch_late_init(void)
>   {
>   	struct rdt_resource *r;
> -	int state, ret;
> +	int state, ret, i;
> +
> +	/* Initialise all rid values for_each_rdt_resource() */
> +	for (i = 0; i < RDT_NUM_RESOURCES; i++)
> +		rdt_resources_all[i].r_resctrl.rid = i;
>   
>   	/*
>   	 * Initialize functions(or definitions) that are different
> diff --git a/arch/x86/kernel/cpu/resctrl/pseudo_lock.c b/arch/x86/kernel/cpu/resctrl/pseudo_lock.c
> index 69dff2bb2c09..5ed9ece12de0 100644
> --- a/arch/x86/kernel/cpu/resctrl/pseudo_lock.c
> +++ b/arch/x86/kernel/cpu/resctrl/pseudo_lock.c
> @@ -11,6 +11,8 @@
>   
>   #define pr_fmt(fmt)	KBUILD_MODNAME ": " fmt
>   
> +#include <linux/cacheflush.h>
> +#include <linux/cacheinfo.h>
>   #include <linux/cpu.h>
>   #include <linux/cpumask.h>
>   #include <linux/debugfs.h>
> @@ -22,7 +24,6 @@
>   #include <linux/slab.h>
>   #include <linux/uaccess.h>
>   
> -#include <asm/cacheflush.h>
>   #include <asm/cpu_device_id.h>
>   #include <asm/perf_event.h>
>   

Thanks.

-Fenghua


