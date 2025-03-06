Return-Path: <linux-kernel+bounces-549972-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C88DEA55935
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 23:00:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A2534188B821
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 22:00:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0CDC27C84F;
	Thu,  6 Mar 2025 22:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="PvWMRjGX"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2085.outbound.protection.outlook.com [40.107.94.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AD2C27C178
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 22:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741298439; cv=fail; b=R0trvSKUUhGZTOCyFqSDo+WWRkVqeqwN8e0cRg6gx2SlvdJtV4Q8UbC+oPZHkR6l+GoE8BZOyLg54jnBV5jgwkld2x8onakhsU56ta5czvua9oD61m7fyHBKQcEGMlipizlP3aduQ0yfmFHoXQBC2Hjh2YbuusS3eTUaRrheje8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741298439; c=relaxed/simple;
	bh=qDH76sd2vgX7z5FjCxIAGKhn3HRrSR49P/HFkS7KdGo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=GXuZ4Al4ujdRL+mVc7/2z2P2pQq4icUPnMHQ9weftA5mpDHok1vv8EHRRPMotJnhjPMklnxRIp9Mw5Px+cdoSddxNZGoSLeWh+elV0nzUU1yykRY4atRMtt06XUmg4ZahkLe1ur72vovRieTlz+ADwI49eZVg9RTSa2ECvdf7EA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=PvWMRjGX; arc=fail smtp.client-ip=40.107.94.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XmBJhe2HgzvhXkq62/qysUBR41VYgeETm759N05uea6bMSayJlc1kEWkgLj+wmGLFwjNz2SJa6XDP/7fPVpxA/qMpoMHAjj3Jx0ndpB4vyqEJ7WRBJdFw0rKwLjuYexaTQRiem15PKCopgI8qETc2+XVd64aHZHTTEByyFxtR6iEFct1urLIYHeQLUSdOO33MHWU+r7hmfnorhkIOHwjTVjCeEgDRUX487MwpV9RpsOLaKxAzrIEsmokz7xnSDhZehAv4M6UWmjSycGcRuvfEptThnBu0aexXlQpjfeDOAeHhU80e4+LEJtCb3Oi06N+RnR9w/DZvqqNLXPqZTRG6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qDH76sd2vgX7z5FjCxIAGKhn3HRrSR49P/HFkS7KdGo=;
 b=Y8Fw3gVNBo++4gHvNVnSONkYulSqTHd6FvdGIkDUUhQ3lotvtVhidRsNsIzCjxvvRXu4e8MyMSsJHEQ/Cu+xa1PZ/IfoFcc8EkeyeZ4bxHa0lxub8qbn9cMkGMQJof8U5nKwG4sbbqqJko8wVHs6AYfKl0bJxCfQ5X/D/BuuU/9qqgiQvQl6HWxQ2Gsm/K27ck3JbPbywutDGMmeugaK3M49OLRcUfNpvVOor0Ci8Id8w68Th6R1gMXLqGvmzEHG5Lquoa1ymGJSUhgt+2RO+VzVgi2z9vF5KwTFdUc3NJi86a22s2yaK9hmwWapH8RrbID9eQcI4mXSDO8tgiMX9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qDH76sd2vgX7z5FjCxIAGKhn3HRrSR49P/HFkS7KdGo=;
 b=PvWMRjGXMOQWUXRtFpAgGYnp77w0L5aOvXBtHH6aeuJhxoExtDhTjszceRKnX9PG6RgAAVXIfeoelFgzZy/s8T0gEgFRSK+4wzSYSZDHQ+RxwV0S+VCW47IY9jBPuORsB10nFgw8YNZC2iVwt4QVu2U095m7EvVxmSrYiV8WB+pw84WayTSF83QuBzPjmVVA9TNnrgKXttouJU9HBLLJtlbeHM1jXZ/Ht0ciZIR3rG3UpBr675x4+98l2uJ5VPfsXwCjAGPXbGzN8DF26xwSWpjY3djmc5zic1j1/7oRVUehmjQKDKXgOiysAlqOB+ZkU1wp85Z2baTTcLprsXb5bw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB2667.namprd12.prod.outlook.com (2603:10b6:5:42::28) by
 CH1PR12MB9598.namprd12.prod.outlook.com (2603:10b6:610:2ae::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.20; Thu, 6 Mar
 2025 22:00:35 +0000
Received: from DM6PR12MB2667.namprd12.prod.outlook.com
 ([fe80::bd88:b883:813d:54a2]) by DM6PR12MB2667.namprd12.prod.outlook.com
 ([fe80::bd88:b883:813d:54a2%5]) with mapi id 15.20.8511.017; Thu, 6 Mar 2025
 22:00:35 +0000
Message-ID: <166e0508-09af-4409-a4e5-5a22bfb8998f@nvidia.com>
Date: Thu, 6 Mar 2025 14:00:33 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 29/49] x86/resctrl: Move get_config_index() to a header
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
 <20250228195913.24895-30-james.morse@arm.com>
Content-Language: en-US
From: Fenghua Yu <fenghuay@nvidia.com>
In-Reply-To: <20250228195913.24895-30-james.morse@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0091.namprd05.prod.outlook.com
 (2603:10b6:a03:334::6) To DM6PR12MB2667.namprd12.prod.outlook.com
 (2603:10b6:5:42::28)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB2667:EE_|CH1PR12MB9598:EE_
X-MS-Office365-Filtering-Correlation-Id: f2f1a7fb-a99b-40bc-ece1-08dd5cfa527f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?elR6NmlpYWhWOHJadzVZWktYNVJIZmlLcGR2bjlJYnF5NnFZYm5jWXM2ZTcv?=
 =?utf-8?B?NkYwdDBJaS9ldmV5Y1VWejZFUWo1RTMvYnpCb3p3dzZTNzVZOW5zcHdWdEQy?=
 =?utf-8?B?bHc0Nk5lMlZFNWZaU3VnRDg5cms2RDBiT0VHYnkzSEoycWRWTkhNU2htQk1V?=
 =?utf-8?B?RUdIYzNwOFhXMzZBMmdGSStpYWVJR0lwSjhXTVY2cXBWallUb3hYaDhFODlM?=
 =?utf-8?B?c1JQbGlsNWErZjNvRkxjdW41UU5MU1FwQ3I4T1ppSmJWVldEUFZJWjJSUnY0?=
 =?utf-8?B?WEwrOVdTMjJ5NWxQc2VEY0UraDQyOGhOeHlMNWxYQnp5VkZVL244T2VzR1ND?=
 =?utf-8?B?a29EM3VGanFJM2FNY0swdmR1a1Zjb0lJdkhEbjhhTlhPcTVJRWVWM2tjcVd6?=
 =?utf-8?B?UXZDSE5ScHIrMU1xc05tazlMMzUyM2NheFZ3RGRzdGJDenI3VHYxTnRKbGxN?=
 =?utf-8?B?Z1ZMQ0hFSFl6R3BJTFN6N3N1Z25Qc3lKTWJGZzlsVFljeUVFUFhBNUtuNk52?=
 =?utf-8?B?aTdreHFwMGZxbk9TQVBPbEh0Zy9ZZEh6STRkN0RBcEtYdHNyaVpYeTFwSnVl?=
 =?utf-8?B?cEdvV0JEa3RtU1BXcXZvTjBVTVdZUnRrN3Qrb1dzOUROL3YvU0o4V1MzTnpX?=
 =?utf-8?B?MXArTU9OUE5UOGc3TWZpcHhIZTJGVDNCNUZiMnlMbU9YZHBMa1k3QmY4aEds?=
 =?utf-8?B?QjVVN1lSYVBXUzJhSENkcXBOV0d4TW5RaHpxNmxLYVNWMit0TjRTdm1pQ0Uv?=
 =?utf-8?B?NGNDTXdTN2x6SlVRRjBzMHJBNTdZS3JGbG1jZW9IKzM3bkJZWmRNeWVMd1hl?=
 =?utf-8?B?dW9CUUFTdEhwQjQ1dmMxZVVlZkxyWEhwSU5jUEtkaFlBbTJ3OHp4eUdLcXZX?=
 =?utf-8?B?UDYxaUxkTGJSRGFlV3FQcFhtSXpnYkpvZnkwODRadzlKZnlGZ2JEdmxHK2sy?=
 =?utf-8?B?L3VMWVlENWlzOEtLaVRpenVML2xicEdHT0NsOFNBSnhVeFd5M1Y0TFQ3cFBt?=
 =?utf-8?B?TTNPN2VVbWVBcWRVQWdIN2VYQlVJa2lsWHBlRVpZL3VwV0xZcDJjRm45MjN5?=
 =?utf-8?B?Y3NyYnNUYU4venVPalNuL0JLYUxuVHJKVG9aYis2NklQVFY4UWZYbXhhTElR?=
 =?utf-8?B?aG1uTkovMHliWEIwTHdoeVN6ekdScktReXdDYWl1Z2ZtT0ZWUFRmSWE5TUtk?=
 =?utf-8?B?TUdjc25RTWl4KzBDd3pPT2N2WnI1SEdmYTVScnhTdWVaWEl2UUYyWEgwVGhh?=
 =?utf-8?B?Y0R0cEtUU290dC81OE40NVFJUitxdFlyaTVlQXFWUHZZNW55bjl6aERYQlNY?=
 =?utf-8?B?WndlRTVRY1Q5QlNWam5uY0J3ODhCOE4zdEFGMG9jMTFnc2QyK2J2TnV3REd4?=
 =?utf-8?B?QXRGck0xZmZaa09JK3NOdXczd0ZHSnFhV1VmSGJucHE3czJ3ZE13ZzhVU29v?=
 =?utf-8?B?N1ZkbW0yTVRkd3QzYkxCTEV5bnl1blNTcTdqZnFqaEliNmZLKzRTOUx0R2d1?=
 =?utf-8?B?bm1ickV3QXVzb1hIVDBqK3Q5ZU4zY1U1SmJpU1NpUi95TXlYM0VCVUNxeFBI?=
 =?utf-8?B?Y25LS3dPNWpqbEFFTURCWTNFRW1mcHpGM0IyQ2o3ZHRTKzdDZW43UXNRbENj?=
 =?utf-8?B?L1ZtU2J5UlZiV3FjNVQxdDlrNDNHN3V4a0ZHMFlzTVpsZHJJeWFCTWhzZFY5?=
 =?utf-8?B?RVRNbURJQ2l5WGVwV2NleklDNXlydjQ3QXg5cUljYVA3ZFlCTEgvT25XSkpa?=
 =?utf-8?B?c3NBR2UrWlp2UDhYTy91SEhIUm1Ramc3VUhrblVCWGdYelBXNmw4SUpZQTQ1?=
 =?utf-8?B?K2VFVXYvUzc2U0lHZVNxeGZrSTg5Y01tSStlS0Uzck9aNGY2S2FkbWpuU1hL?=
 =?utf-8?Q?X/7qd0Ki3FJKz?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB2667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YXFXaGNCRDJtNDI4cGFBK2pVQ1daRVVIOERXb3Y2MHpBdGt0VmwvQVZVWWJW?=
 =?utf-8?B?NkVVb1g4QmhxVStTZzJlRWdhdm9pNUxPRXBST1FBSUdzK0tMODRpWjBHUmF0?=
 =?utf-8?B?SVRFQm5LV05pVTAyd1VpUVE1cXVTYUhGelRIZ0tWK0dTWGdscVpwcTE0SXZj?=
 =?utf-8?B?ditGZ2hPNlljMEVMRlRzRWRwZ1QrZGpZekNleXVjNW9USjFyZzJuZkN5TnRZ?=
 =?utf-8?B?YVZvOFZsc0ZlN0MrUmF4ejhiUVh4aXN1WFluZmdYK05lKzErOXRreGlvNTVl?=
 =?utf-8?B?K3F5UnYxMHpQc0VFb1Z1SnNCOW80ZCtoMStjakFoVnp2RmFIMVowejZUUDY5?=
 =?utf-8?B?NGQreXFvWTM0OFNlbk5qcG5UK3dGMlY1SktLV3ExamZmZHVBc1BSZHd6WUpZ?=
 =?utf-8?B?cVV3Y3NEeFJZNlFlc2pkVXpiNTBDL3IxUHBubXVFRnpyc0ZRMWlLTUx0c255?=
 =?utf-8?B?aTc3VW5aanFhT1Vpa3M2NUJDdENnRXFYbWJTTFVqbVk1bXhxU3EreCt2Z3Nw?=
 =?utf-8?B?eE9mMG03Z1NPU3gvUEtNWi9qblFVTnpHMXRvcVc2ZlJsKzRvWWhidHlXOXdQ?=
 =?utf-8?B?QmZjaWpHQU9FTFIwaHpLTG56TVozRzUyNzdRV1NLZHF2cUR6OFpFc0lvaXBt?=
 =?utf-8?B?VWxGTjRMTmdVNnhQaWVpOWppNVEvYXVleitodVRrUldCNjduMEphM2w4eHBh?=
 =?utf-8?B?LzJBNHFZY3ZidlNnc3B2S3NRb0RRWGpmcEFkZisxM3BTRm5kUlZ2ZXI3a3BX?=
 =?utf-8?B?aFBVM2VTR1krQlppVUFDTGVNYVVYNkVNY0E0ekUrRjljck02d0Vnb2hDODI3?=
 =?utf-8?B?b29EZ2tTRXBnOCtsU0NKeFE1MkVuMk02TEQ0bTFSSS9Ga0Juc2orV2ZmL1ph?=
 =?utf-8?B?U0xsZW9SdUtTYUcvZ04rWnlTQk04Q3RIazBWRVBvRWtqWmgwWlA5V1FJOVlD?=
 =?utf-8?B?UG1EdDVNUnZOMHdpd1ZoeCtraHUxT2U3ZlBROHFaZzVBa2NxY2pNelgreHhy?=
 =?utf-8?B?bEpkblhVQlNEUTEwaStPUVJDTFovWlpqQno2VUM4Q0pCd2ozckhrUG1xRXhx?=
 =?utf-8?B?OXFVWUhPM3Y0TWJNSExwUkxodlRmbXhYWHVjalNoVzBGM2VhM1psb3VPRzNW?=
 =?utf-8?B?bVJiNWtxQi9FZTN1NDd0QkZSRi8xV2cyWHNQMm1jaDJKWDJWbzlJYmdwRGg5?=
 =?utf-8?B?dEpqbDJwMVQ4YXVJVmF5OXlBMEJYbmkyTXRVdUJuRVo1UHRWM2lCZjRmZE9z?=
 =?utf-8?B?WURqYmE3a3FJRUtqdnBGUGEwMzZ5Q0lYeWtiZHJmQWJKRXVBdngydzBRSjBJ?=
 =?utf-8?B?VWR2RzhLTXVTOG1HY2ZwZWptS25kUnErdlBBa25CbXNQaUpmZ0ZlNlhWaTVQ?=
 =?utf-8?B?Q05UTkw3UmN0MC9iMzJpVzAySDlHTUNjQk9sZDh4NzEzcmF5Ym1waWU0dXYx?=
 =?utf-8?B?MGd2UzlVVGs3RHJYUkxoV3hKT0xOY0YxQXhrR1lkRml2UnZxUzNTTUZzdVVu?=
 =?utf-8?B?U0kxNVNhL3pFOG4zaVFWSUF3L0Z3UUhjYmJhblRybXdMZEE5MTVjYkUvL1Mv?=
 =?utf-8?B?Z1FTbHU0RmNrRHlZb0FCRTB1VlFMZlY1LzdRT0lKdWdzdlB1YkNyZmYrZjBF?=
 =?utf-8?B?blFWbWhjeS9oNkMvaUNKOVNFWEZpTkY0M09BTE5yMEtFREdLcS8vdGpkeFBj?=
 =?utf-8?B?bDJVWXQ0VGFMY3QzLzQzc0orcFBkRXFEZ291Y3YwVEFzOWNtQlFoQnR3RUt5?=
 =?utf-8?B?MjVRcnB2OThPZFRUdFhnV0pxcUNZQW50N2UvMEpLWkc0VDdubklGMUo2SEFO?=
 =?utf-8?B?WXFVNXRTblpTd3lpekhzRi9vUEhvbG9vV28wWU83dFNhbVNXS0RneUwyMEZr?=
 =?utf-8?B?RU5RY2ZlVjBPOEtwL1dBMkR4SStlZGQ2TVVFOU83aWVoT0F4MXdLR1RyTENp?=
 =?utf-8?B?OFc5cGNjL285aytDN1hMQW9nZHViL0hydzhzNkgzSTYyMElHNU1mWVI0VWl6?=
 =?utf-8?B?UGpMVEw0VmNjNGk4dDRRREVUU2E1dG9YV0VUNi8rOGhISisvRUNaUyttOXQv?=
 =?utf-8?B?cU5Nc0s4bTRDQ3RPME5Bd1ZlM1prVHVvbnRRZ0M4Q0MrdTJJenVrWmZkVkJo?=
 =?utf-8?Q?7/ceQlOx2AZMvJSLyK29bYYS7?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f2f1a7fb-a99b-40bc-ece1-08dd5cfa527f
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2025 22:00:35.3577
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zFZ6rXCX6VbjhVyzDsvcr7jjYc7Ns22xGHno8+IHay5B2kExOkcI4xIMvRShK6uyV/RpjpI/Wwhyl3NaPYb78A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PR12MB9598


On 2/28/25 11:58, James Morse wrote:
> get_config_index() is used by the architecture specific code to map a
> CLOSID+type pair to an index in the configuration arrays.
>
> MPAM needs to do this too to preserve the ABI to user-space, there is
> no reason to do it differently.
>
> Move the helper to a header file to allow all architectures that either
> use or emulate CDP to use the same pattern of CLOSID values. Moving
> this to a header file means it must be marked inline, which matches
> the existing compiler choice for this static function.
>
> Co-developed-by: Dave Martin <Dave.Martin@arm.com>
> Signed-off-by: Dave Martin <Dave.Martin@arm.com>
> Signed-off-by: James Morse <james.morse@arm.com>
> Tested-by: Carl Worth <carl@os.amperecomputing.com> # arm64
> Tested-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
> Reviewed-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
> Reviewed-by: Tony Luck <tony.luck@intel.com>
Reviewed-by: Fenghua Yu <fenghuay@nvidia.com>


Thanks.


-Fenghua

