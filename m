Return-Path: <linux-kernel+bounces-549979-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9930EA5596D
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 23:11:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C334916B6DA
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 22:11:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B72C1276D16;
	Thu,  6 Mar 2025 22:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="rByEyJLS"
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2086.outbound.protection.outlook.com [40.107.243.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CCE2155342
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 22:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741299107; cv=fail; b=PYbtg9zFpFz7Gu8pjjKyuVKsYwnzn07ATTbt3Yre8UmdwemO0c+MIUVR+VgWzfifRRUK0NvoSqnYeOK0ka9kPjrah9ByYOGk9lxhY9jtlXRkmxsZqZhHdHhYO6vi9+Sx4rVyt/Di2CptghGnfcX7TRj1Ga581FHZQgF4oqRnyeU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741299107; c=relaxed/simple;
	bh=w2mpOcm59ePTlxGkxFe7z902DtxEK2m8VEiHqPjppxg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ZKh7qHo/k20HEdKnY9kqwNspOpCczZTflO/uDS89spMo1olqqT14UbXXDnfNFMCRt9WgxyoYHE/np98V07rbv1EKeqNmnJqyjIUCR2BCnIt+aE2idZZIm9+LqdMc2XuogcMODZHju9ahnWTfSWGCLJaqefhorisH6OInYrf4KQQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=rByEyJLS; arc=fail smtp.client-ip=40.107.243.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M7cDp5f3oVlR+CCoXePF5GPszMGMJHKeiW+HtUUL9boBk361ToMRSrEFH7p6SD00+EUXU0jxqCpUWjq5AZvtPY9CBvy08JBEHB2x8j5WRFUqZXxNmySCvkudlr2btOxPNMLa3s+eCCdoNibUge314y3xtMbX89AVczaMyHzy1BtO0CNd2WfbTUexitFT/zN1rSnZXYYGwqA66tJwmoTwCfFWcsWtjkkjNhc4jR3bx4UdKjK5D0HzqBufNypKy1PvJIYrpyMiM9u2648uPaeLvnjnKS+zgzS1ceGdPjtMnbrgISR/wNv60uG8Rri2A/szrrofeHyRiUrI9euTLxr2Fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w2mpOcm59ePTlxGkxFe7z902DtxEK2m8VEiHqPjppxg=;
 b=LEeKHxgc8SFQI5S04dDqg16oGtP6cRQ+acgD7y1k4AQhz50icw75h0wW55Hh89Qy9e9XZjW1F8LQClEregiuCZuuyvEmpARc0nhxFYA9ZSuK9stA4zaFTAF7c2IryytfKtCGckUTBVA9b+HJnAuWI5kCb+dIFK7CG/wFwuj+Ifie1CNNRPxYtEz6bLFO2oie8dg1r6RKSjcIS/5tSvXAqe13P/i0nOUztmxJAPZvchPeVFLC+MxJaeOxW39Wggb5Oc2Ffj8DaQmKQkZ9IK1dHeRDcbnZXWeFXmFrvYOlJeBuzzigBwt561UJBrlUySoiPnC9cNXEWEGu2nphVxt6yw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w2mpOcm59ePTlxGkxFe7z902DtxEK2m8VEiHqPjppxg=;
 b=rByEyJLS/DsroDwTp3RQyRDPOAaqs3avFyXh/1XprThPWLlpygeM9xh3ka1vwkos6/BFlF2enwzjw2QLpU9XetUqJNZVTOh1yD3q33QLtUEq6CBWQneyKEYUW9XYXX4uJO0EUhw1wTq5tQ8R46o4NPudQVLwGEiGiyU2ZrO5jN0a12Xt+kdq2j9yI+ConFItfQO43PmiaSCqMKObURFV4UQ/tOcUeQfY167/mPkBbm8/8Lf6/hdmwiYEVKWN87e7Wgx1kn2tGqVjSnnVJreSoJDpV3KKNjpA0kXu+teaZu+vZgtKMu5mTvmyUCYHTnarDskQhBHrqVj4qvuoZWQRrA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB2667.namprd12.prod.outlook.com (2603:10b6:5:42::28) by
 PH7PR12MB7455.namprd12.prod.outlook.com (2603:10b6:510:20e::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8511.19; Thu, 6 Mar 2025 22:11:42 +0000
Received: from DM6PR12MB2667.namprd12.prod.outlook.com
 ([fe80::bd88:b883:813d:54a2]) by DM6PR12MB2667.namprd12.prod.outlook.com
 ([fe80::bd88:b883:813d:54a2%5]) with mapi id 15.20.8511.017; Thu, 6 Mar 2025
 22:11:42 +0000
Message-ID: <068df454-dbc5-476a-b3eb-483827a7f5d2@nvidia.com>
Date: Thu, 6 Mar 2025 14:11:40 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 32/49] x86/resctrl: Rename resctrl_sched_in() to begin
 with "resctrl_arch_"
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
 <20250228195913.24895-33-james.morse@arm.com>
Content-Language: en-US
From: Fenghua Yu <fenghuay@nvidia.com>
In-Reply-To: <20250228195913.24895-33-james.morse@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0372.namprd03.prod.outlook.com
 (2603:10b6:a03:3a1::17) To DM6PR12MB2667.namprd12.prod.outlook.com
 (2603:10b6:5:42::28)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB2667:EE_|PH7PR12MB7455:EE_
X-MS-Office365-Filtering-Correlation-Id: 960314cf-f39b-4505-4a73-08dd5cfbe04f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?anJCZUtYTWhEYkJ4djFXTmwrb3h4VjI5Uk93dkRmanRJWDVMMXhYWDlSMGEv?=
 =?utf-8?B?MzVucGJDSzRURDFSTXorOS9NYkpCdmxUU1MwdlA3bEdQMG5qVWJZeG5oRHpW?=
 =?utf-8?B?LzY1RjhqK1I5TEJmWGZ0TkFEVlJVQWpQVFdyZENoZ011RGxuYU1XaldySzBH?=
 =?utf-8?B?MnFla29MTlhyV1VJckZNQU1jUUJTbWt3OFlTckFMMkVxOVBmNnhRTGVBajA2?=
 =?utf-8?B?RytuWnNaOWZ0QkdHbk5sYS9WRGlkS0QrSGhZRnJabm1kbXozVm5TNUYzc0Vp?=
 =?utf-8?B?VXRIem5Ed2E0dGloNlVEQnB3NGdwVkgyUWhjaS90TFZaSlJBRlJ5RlZjcE05?=
 =?utf-8?B?R3J6ZFNIZTZ0OWx4TUZjN3ArSWRPTVBweHFuZlZ2eURiUjRpM2pMWVc1WldG?=
 =?utf-8?B?a09mWDRrVXhxLzNUMEc4bFd2RU1GZGFoWWxHSjJJNUhEcGJhVTJtUjhIbzgv?=
 =?utf-8?B?aWNPVTFxTnRXQ0syMWhzVW5ESXBxendvYVVURGphUzgyY2ptd29xaWphMW1L?=
 =?utf-8?B?SXpabnRIVXZoNFd4blc3TlNmZk5qVTZYUmlCRXJWR1V2VmVUaGdNNVYrcEpv?=
 =?utf-8?B?KzV5d3FQYzEvMjFMNTVjbEk5NzRxRWJ1OXM4OHJhWjViaHBJWlUwdHoxaE9E?=
 =?utf-8?B?US94czdrSXNNZ1MwNGZCMW1pK2hwSDlLRXJ3SkZUNUxRUUV6QUR4OXpGbDhu?=
 =?utf-8?B?YXFpclc4Ymc4c0tIaHoxNXVmUXhWUURtcXlIMTNOelBxUkVXYk5jbkNqUUc3?=
 =?utf-8?B?bEhuMXJCRXNUYUVTa3hnVTkwVE15N0ZyZlJ1c3d1S05JVkFYeG5RalRnWmlT?=
 =?utf-8?B?eUcwcjhZSWJMVmlWbS9ld3FFRHU4Y1d3MFQ0d3JERHp4MUtSd0xXczZTY2tz?=
 =?utf-8?B?SGJnMUJCei9rK0JiOUpiS2pkTGp3TlYxS2M4NjdYaEVOVUpiY0Z0SHRRdjUx?=
 =?utf-8?B?Lzc3QVlLYi9TMS9uZzdsTnF2amMxQXdSUVBwSW1KaFZ4UnB1cXM0NDlLYUFl?=
 =?utf-8?B?WDNXOTA1UnlhNnBVTVBqaTl5QURKZzFUM0VzMVpxZHoyMHhhcDdsNHEwTGNJ?=
 =?utf-8?B?R0RIRlZTMHFYTnFVUkEzQjdzOGk1MDV0OUEyempmV3BJbGVIb20vQVpmRWJ5?=
 =?utf-8?B?SHlCZVVKR3BJdDNvUXAzMUhRUStKOWlDL2hwQjBlV1RHVG1hOWgrRHQrSHdU?=
 =?utf-8?B?eFlQcGpnRDFvK3Q4dWc0WUdocE5DWkRoMWVJbm83SktuZm5ISXRHeWs5K1NF?=
 =?utf-8?B?aEVhWWJBT1BSRVZqeWJCY1NQY2hNSjNGVU9ZVTN1dVBMSlNDOWJ6VWlFckRP?=
 =?utf-8?B?dUlkV2hrQmlSTTQrTmkzMUJpaVRZU3lqdnQvV3RWSERtdXhwSDJETjUwZVdu?=
 =?utf-8?B?RGYrNzRMeDAyZnhIYkRzKzBLMnUrK1Q3NXFFSjFpWUtqWnpxYTNINzI1SnpY?=
 =?utf-8?B?Z2lLWURjMFQ4TDZqRWxuUFVuS3BjUkJrWUdpNlNOME8wZFFkOW8wRng4MWJk?=
 =?utf-8?B?YUZTZURyRlR5OS9BZWJLMWtVdUxseTYxTk5PUmxrcDd3YTRheFhnL1BnRmp6?=
 =?utf-8?B?dG9tSEdNL25QWEo0T2hJWmRUM3RONHN2RjhBcVhiMldDWGRMNlVTcFZ6aXQ3?=
 =?utf-8?B?blFHNXZDNTZ1QXdxaUNES09QL0dreVpUbXgxbGZsNGZncW9LSjZENjRIc0dv?=
 =?utf-8?B?V0Zhc0pIQWJVNmNPWGFnZzZEbm9MVy83WjZDZ0c3aGY3QS94R3Q3U1AyT3dD?=
 =?utf-8?B?Qkp1WWUxU1JFdkR3OFE2VDlCRVdlL1JIZHc0bFBIejBtWWFSM0YvUFpscHhr?=
 =?utf-8?B?eFFsdzRLeEdDSUlVcTB5U040RXVKd2U5dHl4OGxtRGVtY2dCWDdkYmFKTlM4?=
 =?utf-8?Q?3HMQPHSmjIuwX?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB2667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TjErdjlkYmp1bm9kRGZOWW11RlNUYzhzUVFrUUUyaVJubk10dTN2NlZSUDhs?=
 =?utf-8?B?dmNOMStkamxPLy82MzZRaGR5YUw2RlRDdGI4V0svNWsvL05raWdiT1hoQ0dE?=
 =?utf-8?B?T0NpMWlGT09KM1pyOXVqaUVJMjFyWUVBQ0h3Y0NCeHVtY1ZsRVBnTzNoV0VK?=
 =?utf-8?B?R1RSaUYvM0VVY3FCbzloSkVZTmk4bmkxOHBiVS9lcUJhaW5BbmxrakZuWmQ3?=
 =?utf-8?B?WmFyVjk4UjM1MUh6S2paczNFRFRmYlNzWVhXK3praW1zYzUrOHp2U0REZkVp?=
 =?utf-8?B?a0lkczVVdEc2djIySEFtakhTVkVPQnppTEcvS0tZQnhyUFRQbU1RcVVOZTFs?=
 =?utf-8?B?U2Z3aUhGQVV3MzFmVHk0UVZ0cjdUdjJZeUd6bDdNNzBRL3B6RWxoblFsOEQy?=
 =?utf-8?B?c092TkxTaUNXQjd4Q3NHU1E3VkoyYXJlT2l0UzZJSVZOSnkyTXF5MkNTRCtB?=
 =?utf-8?B?dFNrRmlacTl0VUlyL0wxQmQ4WG5weUk4MzZuSnI4Smt4ZEc5dnByaE50YU5U?=
 =?utf-8?B?ajRhNnJ6akJ3aWJkZTY2bk1Vb3JKL2FQNUVYbmUzTkRXcGNzWW5KbE5PRXYv?=
 =?utf-8?B?dTVKTlNvc2dhOUtmVStuU2NlOE1GZDNQbkxGMjNpUEVKZ1cxemhDWGZBbEFW?=
 =?utf-8?B?c3NlWE5nV1Q5Si9jeXMrbGxoU25Mdm45TkFLalRqZ25xN05Nakkrcy8xa1Zt?=
 =?utf-8?B?RzJnQ1hmeTVCMzZKaXlvRTgzaUFuRTFZaTRUK1Jhcm1obGtVUEhLamF6VnZE?=
 =?utf-8?B?VjFwaUtWR2hZVDhIZ2ErU1N6T1d3THRZaXpESTJZOVZQdGR5bVBKUCtHcjlV?=
 =?utf-8?B?V0xkMytRdUNTbDBpUzUvVDRKOVh2WTYxRmk3R2RLZ00wNG5CbTRVTGx3MGtN?=
 =?utf-8?B?TllEcnpZM1VjZ3h2RTQrWlNVdEFxUEZHTk4rd0hCL2N3ZHFMeUYrZVE1b010?=
 =?utf-8?B?RldVQlZvQ04xN0U2dEtQbkdsdEw2MURvMnFNUHZOb2hPRGtyVU5kSnhRSmZw?=
 =?utf-8?B?VmRCeFNIU3A0ZFIyajJsNWtVVlRERUlpajFPMnVld1Mwc3BaY250ZHBGSXJF?=
 =?utf-8?B?dUc1ZWFPTXN1K0pTRmFaU3loZ0ZnaDJmbGt5YktSMG1iSGJEdTFHRlpnQXU4?=
 =?utf-8?B?eUoyaEFrSzhLUEVEcjdiTzNsOFZoNkZkM2syZW0xNDVWTnJXNjNSOHJlZVBr?=
 =?utf-8?B?VWFJWFNvcS9ETENFUk1saWcvMC9xT0xIL3BFczZQZ0g3TGZIYlhzNVVNMnUw?=
 =?utf-8?B?MlJjU2ZoODF3Rnc0S2hUenhRU1Qyb2VnQXZJLzM1NE5WQzFPZVhmTkpOelpN?=
 =?utf-8?B?YWtwSys0YkhZR2JQTUNKcWNDa1I4RzNKdVR1cWxRLzdFNFZCN1dQZERaNUxw?=
 =?utf-8?B?SU03UkFmeEFtZmRBdTZ0VUlnMWJrbWQzZkZYcFdEUVNaTUdvOENWc3RZWnJ6?=
 =?utf-8?B?cVBwYU55QzRINk42Wkh2VlBUaVBVTjNhYXpjRXl5UHpVU0FYUmExWFRWbXhM?=
 =?utf-8?B?dDBPMm9QejBxbUlTb2gvV1JYd01XWWt2K1lMUk5Cc2Fza0hiWWRDMU0rdk9r?=
 =?utf-8?B?ZXdGOTFiMWsyTnJZMDJWckFDT2NxdHRUQ29zYUZaeDVBcDd3MnVzSWM3Mjcw?=
 =?utf-8?B?ZE5jSXlhcjliejlEaFkwZFB0cmdzaGE3dmZwVDZ5RVRudXZJVmRzWkVGcDFl?=
 =?utf-8?B?aXliWk5jdWpwV2lQcW9RMW9pdXJrMmhLMzdsdWJYQlUyN2V1K010Rm9GOWRQ?=
 =?utf-8?B?NHZKQkxKT3BGb25BcSs5WTNGcDd1aGRvVTJqc3dtMjdGd2xlY1V1ZWhUanNh?=
 =?utf-8?B?RzJXUnVYdXlYRWo1UDA4WEpaUGtkTk12bDR0a0pOc2pYS0RKVktZZXdEUWN3?=
 =?utf-8?B?WmZsaVBCNEV0YUthZkthZXBRYWxnZnRFU1BTZ29kSjVPeVpJQUxmSjQzUmk3?=
 =?utf-8?B?dzNna2Mya0tTOVBuU2M5V20xcGFOSXR3RXAxSmhVaUFybjlCSy9YSGdmd2hX?=
 =?utf-8?B?WUZ5M0xCdnVWMnZXT0NTUnZCcGhnS043WWp4K0NKSEVpaGJxWHVPSTd5Zlhy?=
 =?utf-8?B?TTZBc2JVMTRuSnNweldLVDdvNEc2U21vcTVvRk1remtlaFpxQmp2N0I3cFc4?=
 =?utf-8?Q?fy45kamcxP2B7BjBAeVoUr+zJ?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 960314cf-f39b-4505-4a73-08dd5cfbe04f
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2025 22:11:42.8054
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YABCXvLw6dLmt5DOMCfLRHE4lGSKQAoJ5ZyG6vgF7M1ypoGwni6MvUkmFlyiZ6HREjX09nfv9nFp2Ie7A7eouw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7455


On 2/28/25 11:58, James Morse wrote:
> resctrl_sched_in() loads the architecture specific CPU MSRs with the
> CLOSID and RMID values. This function was named before resctrl was
> split to have architecture specific code, and generic filesystem code.
>
> This function is obviously architecture specific, but does not begin
> with 'resctrl_arch_', making it the odd one out in the functions an
> architecture needs to support to enable resctrl.
>
> Rename it for consistency. This is purely cosmetic.
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


