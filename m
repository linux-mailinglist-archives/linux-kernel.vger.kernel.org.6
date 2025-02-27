Return-Path: <linux-kernel+bounces-537444-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6195A48BE8
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 23:44:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE6223A41E0
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 22:44:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31A8522B5BC;
	Thu, 27 Feb 2025 22:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="tg4UT1rG"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2062.outbound.protection.outlook.com [40.107.237.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BEA227781A
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 22:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740696286; cv=fail; b=YSZIxL/OdH4UjOu4WRYE/7Ys0nWb58CEkZJukmJcqaWnPUeeLwMA5Xuiznfmf4SL0g+CZlLT43yKgxE0I961evZrAG0+M399FbPnAKGltO3M6SgokcwZwduqjWu19OI0G2S1BcDFIDCVIFLWgxAl6KSMqz8ZzPaYJLdvxMc2kzc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740696286; c=relaxed/simple;
	bh=31K0cO5DuTt5CXOwhxwS4eJ65Z1baAao1nBHD/RmPtI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=LUi4qcqyKLwe3imHcRdZmxrsenovQ4agCrvn2fC3q2uXQADkKoUHdGoVI28URbhfoc2UuUdfOeu3MrQNmDOF64z06E1OZe7yYG1qW/wJyEXdH36sZWXDSpncI9dTlDaX0nbdTfmUNna4ENQ8ZBeek/q8LycrbHLcfIzdjQ0Rccw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=tg4UT1rG; arc=fail smtp.client-ip=40.107.237.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nMC6q0oFTCsGfudm+9j+dXqLWbcBGZGZMTH/vZ06FFG5fZ+QvzNmSUDgDW5adKxaEpWYHOOpF+QQp8W/jplkSu1Iy12FGWxbK9YAKV7qm87wSFCRv9AnQafbse6SkKYndIz/br7kba4YK/K+/BymbFoebLmO6pO6sw+XqF7r3+AhEP/ACHKDJJJBmmZj9f4QJ3PUdtZjZeDzHND+p3tBa6zFDCCFmmktkRjc5COZLO3jMTnwNzs/eDn9KvqEd4daSf2GX1eCSfqYtP60ddmJPx2vTz6bZtiCKXP4lHmLIqMneHkWeBexGendgKdy0A+Qz6ykeQyOvrdosXXO3Cge+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2Ynnt1DrD8u8kp5TPoQVS4PseVNckG3PMRGJ3D/dlMw=;
 b=FE+uC9/ssVjb8+RwUCTNMfVXlACcDE7OR3SwR+3rifIYJhXYb+lkmaDw8onyKCwGc9+SoEjb454I/ebWP/7XdRqm5hrZm1uryV238Gz0C0A/ox+wUkdYTm2Nvo7oJ72ADmKFdtDdDZVUtUYUp2ZqCPfsOZBs24uIaVKxKBK6pwP2iz3NefgNC9jd/QisiofTi2EtNdpJqZLZyLK9GP+rmwkrMWYBGpltxs8htZMW5Dv69aotLMtJAQoLdFaeEFJyH4YEeXBJlRX2DZM31mrWXOcwCuoNf4vb8vr9BDoPBdWcXaUUD4DgaG/YGyFG438eDNIV33S8PBe13i3LmenjDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2Ynnt1DrD8u8kp5TPoQVS4PseVNckG3PMRGJ3D/dlMw=;
 b=tg4UT1rGLLltybOSOFxsWRwunEWx8/jmNBbFY38pXa3KgSu6hbccHrxpGy1mblIeTAMs8PKLESdqYlJ/XPC66R2NmGz20rRrsdyYaoebzLTnMPBVJuVXNV74ah8v4hDPYCzp7v7v9uhcHNLqY+M4T6rgID5FjG9hwJAap2Yv4R0BdubVQyOQhv9YcQszL2qOOA8+8TLP8JtuG+J6Feekj+2bI8WdQw08hC8EIf4S6pl6/rx3tGTlL9rURCOfV22DvwiMlQ7hKlgoi1MvlHukuzWDtqXYrdAw1Dh7A8hj1DF9vExqt7bmw1+Fg4eJt/AbLaMoQFlPGuduB87vWYtiTA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BYAPR12MB2661.namprd12.prod.outlook.com (2603:10b6:a03:67::13)
 by PH8PR12MB7159.namprd12.prod.outlook.com (2603:10b6:510:229::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.21; Thu, 27 Feb
 2025 22:44:41 +0000
Received: from BYAPR12MB2661.namprd12.prod.outlook.com
 ([fe80::f4fa:1948:9ea6:1ee2]) by BYAPR12MB2661.namprd12.prod.outlook.com
 ([fe80::f4fa:1948:9ea6:1ee2%7]) with mapi id 15.20.8466.016; Thu, 27 Feb 2025
 22:44:40 +0000
Message-ID: <d46cdf05-828c-4089-a418-3fb1b47f78e9@nvidia.com>
Date: Thu, 27 Feb 2025 14:44:40 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 12/42] x86/resctrl: Move rdt_find_domain() to be
 visible to arch and fs code
To: Reinette Chatre <reinette.chatre@intel.com>,
 Catalin Marinas <catalin.marinas@arm.com>
Cc: James Morse <james.morse@arm.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 H Peter Anvin <hpa@zytor.com>, Babu Moger <Babu.Moger@amd.com>,
 shameerali.kolothum.thodi@huawei.com,
 D Scott Phillips OS <scott@os.amperecomputing.com>,
 carl@os.amperecomputing.com, lcherian@marvell.com,
 bobo.shaobowang@huawei.com, tan.shaopeng@fujitsu.com,
 baolin.wang@linux.alibaba.com, Jamie Iles <quic_jiles@quicinc.com>,
 Xin Hao <xhao@linux.alibaba.com>, peternewman@google.com,
 dfustini@baylibre.com, amitsinght@marvell.com,
 David Hildenbrand <david@redhat.com>, Rex Nie <rex.nie@jaguarmicro.com>,
 Dave Martin <dave.martin@arm.com>, Koba Ko <kobak@nvidia.com>,
 Shanker Donthineni <sdonthineni@nvidia.com>
References: <20250207181823.6378-1-james.morse@arm.com>
 <20250207181823.6378-13-james.morse@arm.com>
 <acdfa4ee-e293-49f3-8e53-900b9db63ddb@intel.com> <Z7cK1FpQCgBVSGHq@arm.com>
 <0672ad74-782e-48b9-8591-7e0bdec84845@intel.com>
Content-Language: en-US
From: Fenghua Yu <fenghuay@nvidia.com>
In-Reply-To: <0672ad74-782e-48b9-8591-7e0bdec84845@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0088.namprd13.prod.outlook.com
 (2603:10b6:a03:2c4::33) To BYAPR12MB2661.namprd12.prod.outlook.com
 (2603:10b6:a03:67::13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB2661:EE_|PH8PR12MB7159:EE_
X-MS-Office365-Filtering-Correlation-Id: 4ba155d9-2fda-486f-deb4-08dd57805215
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Q0hrWCtvNG4rSTVINFBhNWJkMkpyblBMOWZXWTNWUU1qSG1TZ2NiRHpxQmFx?=
 =?utf-8?B?YVhaV0lFdk9HNnFmbVU1bE4rUSs4S3lra2dRR0hNY01YL0p5dWhVOVYwU2hD?=
 =?utf-8?B?U2hmakFLejErQVNyZFhnbUhFTTIrb3ZrTktGR0hNN0hoUzFnajBvaFFpcitF?=
 =?utf-8?B?SjU2UXdBc3ErZ1BXcE56M1VuYU1yVFdSNHRwNWxLQ1VGU1UySW5zM1NyanZy?=
 =?utf-8?B?NVBoYUFxZFhaeHM1enVvbGY0ZnRLMFdteThjU3lqUFJ3NlBURENjU3poWURw?=
 =?utf-8?B?MndVbnQzbGt1NER1cGNpSTZYZGptL0VBdTJiWlNJTUJwMHZYSlpBeUM2bEVi?=
 =?utf-8?B?emY3RG9aU3E0cWJLaFhlbEFlVFJXN2dSVklBd1pja3Vjdno2RFdRRHF2WTE3?=
 =?utf-8?B?a0RLNU93MWN5RDZXQUEwbXhJcVVLU0FXTEt4L1RmR3VjbTlYWXF6ZHYwTyti?=
 =?utf-8?B?ZHpRR3pOaWpHanp5UDVvUWtYcVRVVGQyay9pNUVPc00xTWNWaHhOczBrWm5o?=
 =?utf-8?B?dWV6eG90T2FlK2ZSU1dqOVlDeVNFZ01JQUcrYy92L0tOTkJVWWpRVm4vdWY2?=
 =?utf-8?B?RlUyYXR1NHhLSEkxVWdxUlFwREFMcGhIcVpuT1VBbWVzZFlwTytPdWJNaFZy?=
 =?utf-8?B?ZW80UlhqRDA1dXp6RittTWJ0djNHaHRIdS9oc0dQeUl5VGY5d3dtTmV1am94?=
 =?utf-8?B?ZXJhZ3hIaVREMkV5cXc3Z0RYZzZuTnpuMWcwZ1FaNlREcytESm9mY0dIQmRv?=
 =?utf-8?B?ZWs0a054UFlwUUlScEl5WHFjNXpLU2xabFJtVEtHeTlkUHZwRm91NXA0cVVn?=
 =?utf-8?B?OEpaZlAwMG9pcy8yZVBlSnU3Vk1DRDJOaDg5QlUwU3NpQklEbEl5dXpDNU9J?=
 =?utf-8?B?VC9MelFuMWJSb2FsRkQ2TlhHWUdPVW5xa1k4ajh1L2krSXJPOVU4UnZKOGVE?=
 =?utf-8?B?VE1SZHI0Z0phcTcwYXVQYkp5TDk1ay9yYWV1cHdPNk1HUENCZmtJMFA0d2E4?=
 =?utf-8?B?cE8rbUlmNlI0NmZDOTZNVTB4WFZ2am5wSkpsNXV1d0NrMkVUdGNXd0NmZjQ2?=
 =?utf-8?B?OU1hbW1qQ2tCR3ZsZGFZb0tDc2lici9JK0JXdERGY2NGQmFoeFJFc0ZNcGJB?=
 =?utf-8?B?VlZPUEZTZWJrcjN0bUNia1RPZ0FvMEh6NFRSdUxlaFN5bmQ1SUZhNTQ5bktC?=
 =?utf-8?B?VkkvOERWL3cveVhoc2c1R0lpb2NJcUNoUnR1UVdIckRpSmJCK1FGVzFiQjQz?=
 =?utf-8?B?YklXUFphL3NiZ1pTYXpWQ1pENXJzNlBDbENiaVFTQWYyYnc2aVF4YmtKNWZq?=
 =?utf-8?B?WTVYNDRnN1l2aVUyOWJYWlZjVXJKaE9yVzZBU3Bic1Z3VkhNUFU1ZEdCQU5u?=
 =?utf-8?B?eXc4Q2lWUzM3OVJRNSsvYml0TTA3YTdGTzh0TG9rbHRQWVpoZGIyKzhMSzdT?=
 =?utf-8?B?bFBZMXpYVkZTTlA0MU5ZUFFVM0tFMndpMFdJNWxMbFR6L2Z1aGFPNFFER1dH?=
 =?utf-8?B?VEdKeGsrRlBtd3BXRHRqVU1rRHVLenJZUDV4cmtNWjhKYTQ4d3B1NmpXdklt?=
 =?utf-8?B?THNWNUNzQm1lQ2drVG9ycitwVndrWkR2WFlMTjRodExpUWVYWHdKNmxQLzBv?=
 =?utf-8?B?TkVKY1lCNVQ4aHIvZmlvM0ZiSVlyZDRiYjBWejBrcjVoeWM3ZHMveU1TMkh5?=
 =?utf-8?B?UXpwNDZGUzl4QnZEZWZHQmxKV2V4aFdobkNUb1R0WHk4ZHhSdHdsUnlMcWpY?=
 =?utf-8?B?cy9LWSszZDMrS3l2TmUvYk1NanUvakdjd2MvbVhSemp6eG55TzdsSWJieTNH?=
 =?utf-8?B?TEQyRnB5OFFJVWZSdURqYVkxVkhIc3pFekFRa0M2QnZwblpFNDVoMnN0eEhm?=
 =?utf-8?Q?LInord/m3Utgx?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB2661.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TGw0UnI5WlAxbHpTcU1lWGVva1l0L2NNR0tjTXZENDFYZlZzaEozTTdQVlpy?=
 =?utf-8?B?NkVRRytmMWwzSXE5azZhWEt2UkZnb09MWU1RbkhKakUxejhTSDhTaHZBemZH?=
 =?utf-8?B?VXBZN0hLcWlwVEg3dDRlbk1hNzYyMU5MM2JzTVNFQWhwUy81bzRmcXU3YnBW?=
 =?utf-8?B?bXpkc1ZjcE9ocXdabUlWd3hpSjNKcUErWDN5Q2xpRXNuK2NnWUFYV3JhMjhq?=
 =?utf-8?B?cWV1QzlKejVGOUdVQXRqdG5HSWhPcmt0Z0RqaEh2UVlHU2o1OHBMK01VRXRr?=
 =?utf-8?B?Uyt0ZUZjMzRiNVBnMFFiYjJpTUM4WTZJdGJjNFpXZVpmMGxpL3F6czVWMXJW?=
 =?utf-8?B?akxxRjBaeVpFREszRlBrZENZemV0SUgySnVDNnZ4YjUzQnF4dlluTEZCU3R3?=
 =?utf-8?B?ZHJwQ0tWY004RHFDazB6OHNVeFhtUWtkT01PREM5cVZyK240ZGhyWEprMWJq?=
 =?utf-8?B?ei9ZbDQ4STlUUGdUaDhLQ080b2dGNkxlbnRaanppdXd4OEVnS1ZaTDc1R1lE?=
 =?utf-8?B?WjRvaEp6Nm9YL0N3YitZWG1KcjJ0ZVJNNEJNOXp3dHFhQXlaUG1pMnRiY0JQ?=
 =?utf-8?B?UmEvN0l2clNOVlVZYTJ0aUZ0VkVwNlB4NTREZUgxd1AvbVdGeVoxR21kSWpS?=
 =?utf-8?B?TGNUNDRyWGVOaWRHY1BxQ0ZwZ2JMODRVZWswT0ExTGQ3ZC85TXBUeXF0alJp?=
 =?utf-8?B?K24yZUNab0lxbkpNZW5IeVV2SjVSSzhqTFhqelA4MGxMNzZJQ3VRT1NDYStZ?=
 =?utf-8?B?QXNsSnZudWZqNFRuRGtueFVrZnQzbkhyb1U3NmcvdjNtZjEyMU45K25BOHVy?=
 =?utf-8?B?UWVwNlorbEo0ZWhaUkhlTUxxcDhZQXFvKzFWM21qaWZkY3JZTmQyTXBndXBD?=
 =?utf-8?B?YmUyQUIrMDdyM2Q4Nzd6ZVIzZ1oxUFQ5aDJWUVJwR1JKdCszRVNrL1hhYXdy?=
 =?utf-8?B?Q2N0cFlKUzdxUFV6cnpxWjNIT21XTDFHTUlTbkNNa29SMHVMVUdhdHRNQ3VV?=
 =?utf-8?B?cGw1VnhDeU9yREwxRUpNZndoRk10QW5zWUpMK2Q2eU5zVU55NG5GdUV6VGZG?=
 =?utf-8?B?ZTl0c3o1Q1BYbEpTZTNTbVk0RnNUd2hVVThvYzdVV0F1T01ocFlRbHcwdkRh?=
 =?utf-8?B?TGZaZUUvNk9oeGp2NXJOelpIb1RKZFhIV1hYR0VybVFkUVRkQ0hCcGVFYzFU?=
 =?utf-8?B?YzhXVXA3NmVUQm95WDhlMU9PZnVkOUNEWmFOcTM1enNyOUliZUZXcmVtcWZj?=
 =?utf-8?B?aEJPRW90TW00ZVFnSjVhSDY2RDJsL1NQWGxyeUxVUS9mMVp3Z0Y3RUFiWUJU?=
 =?utf-8?B?cEkwMWJhRkV5VjhWZVJaSDZwTWp4RWU0VXBpK0ZtVzlZNHdNUmhZK1NNWU1N?=
 =?utf-8?B?bE1kR2RRYkozN2tMSjFSWGhWNkpKdWpHNFdURjZlcndxNDdIUmtoUDZHTVM5?=
 =?utf-8?B?Szc5RXlPTnFHckk1YnhuSDVLM0h5Ull6NHZkWHJrL0Y0MGgzR0twUTFnT25r?=
 =?utf-8?B?dDdBRnpMSGljQmcvdUpNVU5pR3VMcmlpQlVXNlZMbnc4VU5lbGRaaWVNdjRK?=
 =?utf-8?B?bGFUQ3lrYmdaNUZERUl2bS9hMWw4RWFqd1N1QzF1bXRXcTVkVmppZnFwVC9X?=
 =?utf-8?B?REphY0NGNWczMmFOOXJvd3VHMUx6bStwYTdFVzhBVm1OZzVPdFd5dFJzYnhY?=
 =?utf-8?B?bnlDMEF0NWlXakpmamJoeE40TDBIK0pOcC9iREVKWnZsSTQ4OXB3RHh0VWFR?=
 =?utf-8?B?ZXJXbWhyRzN3N0xsL0pIYk50WTBLSUxTMThhaXhGUUgyNkJxd2dEMS9PT2FQ?=
 =?utf-8?B?WEZMenpoaVlNSWVyS0U3Yk4wbzIyQlhvMzBWOCtHYlhaR0tVYjdFRHVMMjVE?=
 =?utf-8?B?b3ZqaTlsSmphUm5xQnhFV0lUb2Rocy9abWN0bkx5L1FlcE44YnM4U3I1ZnFF?=
 =?utf-8?B?SnlJOWs1QnhyUGlYTEVid3hoSzVIRDVZdHhBZEI3V05PVUZQMmhReHdFWjB4?=
 =?utf-8?B?eGphemJ5R25tRmMwdU5mSDZzRGtIY0M5YWsxWGdSamVySVdDUUdkYUlObXEr?=
 =?utf-8?B?enlDbkR5eFFsdXhlUFgrZEttcGZkWExaNmNIRytSZXp2b0szQ3dWUnFveGZl?=
 =?utf-8?Q?dc4mWZ5WMbZciFRfpykXwv1nG?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ba155d9-2fda-486f-deb4-08dd57805215
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2661.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2025 22:44:40.5021
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JK7NMl5YLnQImWaUyIWgmB6cIqn4PcMETHhfQIhRQFPK4VxczAzG70rbTL9WR/fQlMtIdlGWnkSYFXZ9kR80bA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7159

Hi, James, Reinette,

On 2/20/25 08:01, Reinette Chatre wrote:
> Hi Catalin,
>
> On 2/20/25 2:58 AM, Catalin Marinas wrote:
>> On Wed, Feb 19, 2025 at 03:24:06PM -0800, Reinette Chatre wrote:
>>> On 2/7/25 10:17 AM, James Morse wrote:
>>>> rdt_find_domain() finds a domain given a resource and a cache-id.
>>>> This is used by both the architecture code and the filesystem code.
>>>>
>>>> After the filesystem code moves to live in /fs/, this helper will no
>>>> longer be visible.
>>>>
>>>> Move it to the global header file. As its now globally visible, and
>>>> has only a handful of callers, swap the 'rdt' for 'resctrl'.
>> [...]
>>>> --- a/include/linux/resctrl.h
>>>> +++ b/include/linux/resctrl.h
>>>> @@ -372,6 +372,40 @@ static inline void resctrl_arch_rmid_read_context_check(void)
>>>>   		might_sleep();
>>>>   }
>>>>   
>>>> +/**
>>>> + * resctrl_find_domain() - Search for a domain id in a resource domain list.
>>>> + * @h:		The domain list to search.
>>>> + * @id:		The domain id to search for.
>>>> + * @pos:	A pointer to position in the list id should be inserted.
>>>> + *
>>>> + * Search the domain list to find the domain id. If the domain id is
>>>> + * found, return the domain. NULL otherwise.  If the domain id is not
>>>> + * found (and NULL returned) then the first domain with id bigger than
>>>> + * the input id can be returned to the caller via @pos.
>>>> + */
>>>> +static inline struct rdt_domain_hdr *resctrl_find_domain(struct list_head *h,
>>>> +							 int id,
>>>> +							 struct list_head **pos)
>>> Could you please provide a motivation for why this needs to be inline now?
>> It's in a header now, to avoid the compiler complaining about unused
>> static functions wherever this file is included. The alternative is a
>> prototype declaration and the actual implementation in a .c file.
> resctrl_find_domain() is currently in a .c file (arch/x86/kernel/cpu/resctrl/core.c)
> with a prototype declaration (in arch/x86/kernel/cpu/resctrl/internal.h). This patch
> switches resctrl_find_domain() to be inline without a motivation.
>
> After a fresh reading of "The inline disease" in Documentation/process/coding-style.rst
> I do see a few red flags related to making this function inline. The function is certainly
> larger than the rule of thumb of "3 lines" and considering the number of call sites I do
> not see how bloating the kernel is justified.

Agree with Reinette.


Plus, resctrl_find_domain() is only called during setup and CPU hot plug 
which are not run time paths and won't impact run time performance. 
inline doesn't help the performance but makes the kernel bigger.

I can see the function is moved from arch/x86/kernel/cpu/resctrl/core.c 
and there is no corresponding fs/resctrl/core.c.

If your motivation is to avoid fs/resctrl/core.c (which is much small) 
to have one less file and just host the function in .h, please consider 
to create fs/resctrl/core.c and put the function in it and declare it in 
the .h file. So there won't be inline issue any more.

>> (drive-by comment, I don't really understand this subsystem to make a
>> meaningful contribution)
>>
> Thanks for taking a look. The idea is not unique to resctrl.
>
> Reinette
>
Thanks.


-Fenghua


