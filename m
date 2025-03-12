Return-Path: <linux-kernel+bounces-557107-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BF55AA5D3C0
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 01:29:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 00AD6164DB6
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 00:29:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F32A3C47B;
	Wed, 12 Mar 2025 00:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="B/tjpbjE"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2049.outbound.protection.outlook.com [40.107.237.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FFC76136
	for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 00:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741739356; cv=fail; b=p976iOfxh8C4CZK+ur37mx5oRH85GlET1wG9XWcm265t5mqEbqK31BO5uMSXOOoXjTvNxVNToL7Vr9FbC3uHncL99YuUmL087GSLtazIs5zgzac3o3bYnwD1Tj4ZAF4M9cEVQWMxjLL+ryMvMlqr5CPtyyAwV4r90gS1kYtmFUY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741739356; c=relaxed/simple;
	bh=9mGDqoUF6kolczkZkIuxIhhVEXSEkD2edUB9av5jbXc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ogUB/KPcwI1DHZ/4ONHaIRa7WXq0jvxL+Limc9SlzSg6ch0haf/J4HxCbODRBtmcyPgNrqfPfYNKfd4dLG4MtVgYoL69GhjqOKwwp7ju51o3qnvGiaKXl84jnZF5ycG4GPfO/pzRmgdDLA/tAcIDAO5iHSSS61rqsqKwSqUV7w8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=B/tjpbjE; arc=fail smtp.client-ip=40.107.237.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kQVNhhtIUYYrrhWroL9w+S67YubCsOohbvH/NmXHEBg33SsoIwCu6G+JYjgnHTOTcMfPseTh4/UtdxV2EFyGqndK0RiCz690H9EwLXkCaN7V/031mw0OSUnWQEdIzYLM9pUrAe7oxQii1MgRWtQz0JkKo4qssrxwTPatV945/gfML9hLAXUDsI1z5fdWHlZc4t1uEH04NsvrV6QixffrYtJxcaGURN+zYhtI/V412T6R61/SKMszkjMsuGAI+iy7woO90Y1AoPkUKsm/ggwURjfn5DvOAtsCsIevQzKqurRmxTh0HERwFW6qQP32Oc6OvcF3aqnelV07e3wyH305dQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KJuAbMUCOXdgE1/L2x2sJafOFtctqek13eTwoVzqnHo=;
 b=cOcG3vn6hju+qOhYKJObGSBXdmdK5K3ibJlpF+VwJEioPoDQRHLGH/NepFnJR/K1pXucOEGDiJZj5Q0WWaey01y22XWMOgmn8BAx7HLfA2jHhyC624cSTY7LeBTsb3UKOVQu+xcmOtCvliZuD1QrltVbBuI8d1ymu8yLD5oQIs7QfqNUcWmlKJ3F1hkiZTcVHA+eBblnguwf5Fvkc7cTj+7fwjz7WacKsrYBo2SQJzHLgbiLV4esuZQ+vsfaK+a3HdfRJOd9wQdt2QGlcaTSpCANHNQ3papGLEMbvXrtSgYu3QbvcjHQwHvuUiYqiWHsOJSBuCToRNO1z1N9bFXkkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KJuAbMUCOXdgE1/L2x2sJafOFtctqek13eTwoVzqnHo=;
 b=B/tjpbjEh5+hZ77uybNMw9CoQkgx+efYr0c5ymwduEPfAVLUwEsUgdRzU9Ab69meoT00VqHR0vwCYYT4RYkpinmbtnqDFBU7QLKbBdCY7c1XsBo1tqyYURkXDOs2ZppCwSjyHdzucY3HKcH1dFmik/V6F6VILmVnQ5aXXtQk3Dw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by SN7PR12MB8148.namprd12.prod.outlook.com (2603:10b6:806:351::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Wed, 12 Mar
 2025 00:29:09 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87%4]) with mapi id 15.20.8511.026; Wed, 12 Mar 2025
 00:29:09 +0000
Message-ID: <822296ff-5b8f-4e26-ad87-ae3cf4fd2559@amd.com>
Date: Tue, 11 Mar 2025 19:29:04 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8:for-boris 00/30] x86/resctrl: Move the resctrl
 filesystem code to /fs/resctrl
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
 Shanker Donthineni <sdonthineni@nvidia.com>, fenghuay@nvidia.com
References: <20250311183715.16445-1-james.morse@arm.com>
Content-Language: en-US
From: "Moger, Babu" <bmoger@amd.com>
In-Reply-To: <20250311183715.16445-1-james.morse@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0421.namprd03.prod.outlook.com
 (2603:10b6:610:10e::26) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|SN7PR12MB8148:EE_
X-MS-Office365-Filtering-Correlation-Id: ffb1df9f-39f6-4ec0-e990-08dd60fce773
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UXBvTm4rbXpaZ1E0V0xFUG1rdTRhNFI2L0U1MnRVMDFDeUMyZG04bU5vWHpF?=
 =?utf-8?B?enA3SEV3MlBWRFVDTzFhL0tvNUhsMGxyR1BXT2FoanJic296Y3pQMEVyTk04?=
 =?utf-8?B?b2NSNlhxOGQ5aGtFc1N3KzhKUWZkUDBoSmxSc29MS1FydTlza1dLaTVDRDk1?=
 =?utf-8?B?bWRSU1ZTdXE5MlNoaFBjYU5hVmNjTGFtZnJ3SE1EWFZoOVc4ek5LeDFZRTV3?=
 =?utf-8?B?RmhYTEJJNDdKTU5PTW1VUGczQmxVMlpoeW9oVWcwWFRzanJzNjdtZGRSeUEy?=
 =?utf-8?B?WUY0czVBZkdTUGVKb3g1ZjllUk1neDZuaUNvc3huQ1ppNWM2T2JXSlNFZkVD?=
 =?utf-8?B?V2xYNkhjZTQzU0x4U29kMkdXbU02Nm5BVTdjT2VRUTBoWm5CcWJ2SWRzSXk2?=
 =?utf-8?B?OVkvWWJPV3hoNEZrakhaUGM1VGErUFhxK1EvdXh5ajZxeVVnVDFNdFBtQlZh?=
 =?utf-8?B?L3lIQWVua2RjZDAraWkwR1c0bnhjL1E4UDNrak5pNm0zTzVwSHZFaS9Qcmh5?=
 =?utf-8?B?TjRkR3lUbE5GNmcrRDQ5Tm9VbURyQ2EraXhObUdxSTBIMjZUMCsyK1hoQjRD?=
 =?utf-8?B?VndOM216ZHpwTm5MSWdsb0hHMm4wbkc4L3NTRnlCemR4LzVHRGdjejFVTzJ4?=
 =?utf-8?B?aFAwR1FIZUZDZUs4QTgyMHRwUHNqRlpXMHl6QWxzT09Qd0ZjYWJQSkZJWHJJ?=
 =?utf-8?B?RTNMTGFlcjk0QWhHZkp1L2xueUpSQ096TlpyN3Yzb3RyT0c0OFVKMkFoWjVB?=
 =?utf-8?B?TzhHdjV2cjl2MW5oTlBDUHFUK0o4NXhVSStOQmxWVmNoNnI0K2NyTktKMkM0?=
 =?utf-8?B?WXY3NjZqRS9hekU1ckJWMlN3cnRnZXFEenB0RDRiZXZjSnprVGlyTWYwY1Nj?=
 =?utf-8?B?MTNxdXN6azB1VUNWbjBBWkZSL3Y1U3hPNGRtb0Q0cXBTVGdVR3ovR0p4aTBw?=
 =?utf-8?B?bkJSd2RqbXVWWnM5eE5iMnZCakZpbDY5bHRHMzA3YXErUVozMGtiWUEvTzFr?=
 =?utf-8?B?TDl0MVpIVGpxcHRGYWJSUlFuNnE0ZzhnRlNkVU5aaTVPclFiLzdXbFhkWDd1?=
 =?utf-8?B?aTBNdFAxVnZvWm1ZYUpjeEkyaVhFVXlVQWZ1cGtsS0p5Q3RGNmtSeVgrWDlv?=
 =?utf-8?B?eDIwenVLUW5LLzJROW9KM3E5OWpVV014Qys5SVZDYnpncTU0eGV2SkpLZTN5?=
 =?utf-8?B?d0FocWtQV2RJenJRa2N6OFFoR0NtMnF6K0t0SHZ3YVV4emN2OW1CdTh2RUZx?=
 =?utf-8?B?VGVxM1Y0VFVQQzgyRFZWaVVmUGVqVHFnSEJFZ09jcjU0dXg3d2haTXpRUy9j?=
 =?utf-8?B?bDAzUVlMWlZxbWp0VWZWczZSZWxRUzlheDZaeXI4dytzb1ZFYitkNm5TZC81?=
 =?utf-8?B?N1RNVjZVaDVZckFQMFNUNTFuYk9KQWdwQ3p6RDFUL1l3a1c0L3BPVEF5R2t5?=
 =?utf-8?B?ZVBvZm1LOE1zYkdFdGs2L0w0MDFSbjNtcVVqL01NemlYRFBwUHlZWTFlTml0?=
 =?utf-8?B?NjdUT21vaDlSZGp2dFNGaGcxcVZicm9FSEMwUHg3OVJHZUFKdlpVYmdkRFhM?=
 =?utf-8?B?UVQzOHZUUndDM3E1dXRQUXIvWUUrZElyWXJrckUxcEdoRysvYnlpMWVpSFFy?=
 =?utf-8?B?eGhQWS9URmdwUTRubStCSVR3TmZPakp6Z055UmZ3R1Mvb0ZDQ0ROWEFBMlo0?=
 =?utf-8?B?U3poT1hDaVpvM0Z6NDFidXJQQ1BpbytxeS9tbVNpTE83eDN0U0ZWYXB0bUxI?=
 =?utf-8?B?S1VQUVAySFpyREVqY3NJRU5POWNiaTN3UWZZV2Q5M25ocTNBVDNFZ2R2VERK?=
 =?utf-8?B?VS9qZCtLM2NKNmJ1bjZnS0UwbGNGb2NVcnJjenlvbVozSXpLSDArUk8xMkJG?=
 =?utf-8?B?ek4zUjBwNE50eS9tT1pEdkl3VGliM0dOZFFvZVJUdU1YR1E9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cDQ1c0NZN1NtWXhJK3ROZVkrMkp1WXRIa1dLbHFKcnhjakN3YXlFTFd4QnE4?=
 =?utf-8?B?NW1naDMyRC9tMlF1Z3lPNFRWTGY3ZEZRWnVJa2lmajdoaDZCNnpkdTlrNnFa?=
 =?utf-8?B?TmFZcHpSZ2xMbGJHRG9aVzI4ZGVJcXM4K3BMVkxCOVMwdjQrVDlVZDRWbU5t?=
 =?utf-8?B?ODVvRFQrMWZmeXBzQTVwMklFRHd2dXVOWVo1dTFkYlpPUDZhdG5DT2ZHQ2NB?=
 =?utf-8?B?Ynk5eTRUMHFlSHVDcGRYMTh2V1JTdmY2OUt2eUdTNTROalIzVURGU0ZIZSt5?=
 =?utf-8?B?Uk5iVXg4ZmpPTFBGd3Btb3p6L2JYWnFoVFlKcDJ2MWYwMi93VDg4WTV0ekx1?=
 =?utf-8?B?bC9ERE8yc3N2YnVSNTU5bTFhVlRXYTIyRHEvbHlWYmE3WmlMdjZvVjFZRFRH?=
 =?utf-8?B?N1YvZkkxdmVQbWlvdGZkaWNPcDJBeEp6Rjc2aG4wMWhLd2F4L0p6UnRDazZh?=
 =?utf-8?B?M21Oa3ZWNStXQmUwNjYwSWYvRHNpdzl6aHBWcVR3OGVvRGVxMFBjTHAzblQ2?=
 =?utf-8?B?ckxDdnlxQnJURkg2cmN4QVRKTW9pcGp4NURVRHd3Um5KVFV6UGtTbEpxZy9H?=
 =?utf-8?B?bS9tc3ZVQ0NaN2JOemlCQzNUa3AzaVpzbHVJekszaDIyOTNPUUJ0OTBUbnV2?=
 =?utf-8?B?Z2Q5dlJzUVVwU2lINEJCS1pxcnhLemFJVVF1TVZhUVJGRkpCVm5HU0lKT2I0?=
 =?utf-8?B?OE9DTEhCeE1XNEs5dVkvYkpKVUNXMFR3aWFKRWJoTnQvNVdZZ2pGS2ZMT1E3?=
 =?utf-8?B?aEFPeWQxdzZpeWtGL0hkZzdXTWd4RmJIRm5nck9YbitkYm0wYWU1Y1hxZDU5?=
 =?utf-8?B?YXRWMVk2RUhoNU1nNUhlcWFGWHE5YVlVLzBPUG1PV0FDTmxlNC9aeXhUVGw2?=
 =?utf-8?B?N0E2STd3c0tnSjhuU09sVnM0Zm1YeTJoeldDUXZTQzFFNnFVRm1idTFzTVRW?=
 =?utf-8?B?ZjlsbWJyMWhpNHpOUnREK1VPRm1jNDRmT3h1V28vd0hoQTFCL0JzYUxrbzY2?=
 =?utf-8?B?TklrdmZzSzl4RFJIbTZpNzdqZ1N3eTRlYlR2TEEzVXZWRWxsNDZsZGtTV3RK?=
 =?utf-8?B?Q1ExOUUwdmg2d3ppeDJxZVNQeTFickx3SHlTZVlIRWRmc1NjWmQyYUNKcVRp?=
 =?utf-8?B?L2xvcEJ1cDI0cXBDMm1GUDJLVis0dklzekFHdG94OWdYNjQvbktlQUg5SjVx?=
 =?utf-8?B?cG1wbEI1TVpKTUJVZGdXWmhjQW9lVXllVU5sOTJHMHNmQmhVSXBxSnVESndo?=
 =?utf-8?B?b1lTSlZyNjlnZHVEYmlCZFNrY1BRaG1hR3IxU0k5eEU5ZWs5cFRTOHRzdmg5?=
 =?utf-8?B?QWZXT3hLNVV2Qm9kcjB4dVhlcmRtN3ZoUnRuVjA2UjFkZTFqSlltZVpYZkRh?=
 =?utf-8?B?cXVSNFNHNzhvTHNDSWpiM0hhMHY2aGZ4cG1VRXJ2R0N6UHZjRk00aFR1Uy9x?=
 =?utf-8?B?WkdVb3d2MHFWYkFFWVk3aHZ5djd1SG1BRWFESzFjS3QxUnhmdE9tdC8wV1hY?=
 =?utf-8?B?WGhBZEJnSVV4cnpPN05YRnVsNUVjV1dMRE1seGxiekNtdCtJK1BmU1laSFlT?=
 =?utf-8?B?TUZQTS90cS9tLzQwMEVNVmRJcGtFWXFSbnNaUU4yTUJsdUEzYWpwVEFXRkhO?=
 =?utf-8?B?SkFpVHJDRGxoK09DWFdqcnA1ZGxvWCtzWTJ2OWpkVVpjZWtQK2lvMEcxNmhl?=
 =?utf-8?B?VzZBVEVTRVRmbGVmcWJSZFp6NG1vWjZnanJjbjdaamNNRlFsNFo1SDEySVBk?=
 =?utf-8?B?SlVnc0RxVVRMZmE4WWJnYzlWWWcrcWViWHdBUXM2cGI0M1d4c0JFZGpmeitk?=
 =?utf-8?B?VEFMYjBvM2p5aDNicjBjTWhIWjBydFlYSzQvOCt2VWNWOEtUaUh0UmlzRncz?=
 =?utf-8?B?MXVJeE03NU9ENnAzRzZwN1NISmgxUFBYWHNLV0NRRmN3cytkYjRLMHV2MVZP?=
 =?utf-8?B?S0syWVduSEVTWkEvSEc4YnhjdHA5a3EycU5zRjJHdllwN0ozOVpObTBiVnVj?=
 =?utf-8?B?aVRtSllYOWRZMkp4WjJSSGJ2Q2pHdnRHcThOOGV0Z2d6cXJLTkFORXFmM3Jn?=
 =?utf-8?B?NTBxR3F5emc1M1hSMGVsVGJUYmZxV2tqZ3RQM1hxU2lYWUg0TjhqOTdmU01l?=
 =?utf-8?Q?8bU4=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ffb1df9f-39f6-4ec0-e990-08dd60fce773
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2025 00:29:08.9966
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PNDKriSHoBCG+ESoDVAb8oWa3KKZ1PsNDUlRx1/yAjje9+DSYmNasugHXPRhYwc9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8148

Hi All,

On 3/11/2025 1:36 PM, James Morse wrote:
> Changes since v7?:
>   * Series split to the first 30 patches, requested by Boris.
>   * Fixed stale function names, definitions/declartions and typos.
>   * Dropped the use of the default ctrlval helper in cache_alloc_hsw_probe()
> 
> As ever, changes are noted on each patch.
> ---
> This series renames functions and moves code around. With the
> exception of invalid configurations for the configurable-events, there should
> be no changes in behaviour caused by this series. It is now possible for
> throttle_mode to report 'undefined', but no known platform will do this.
> 
> The driving pattern is to make things like struct rdtgroup private to resctrl.
> Features like pseudo-lock aren't going to work on arm64, the ability to disable
> it at compile time is added.
> 
> All this is to allow the filesystem portions of resctrl to be moved to live in /fs/,
> which allows resctrl to be supported by other architecture, such as arm64's MPAM.
> (What's MPAM? See the cover letter of the first series. [1])
> 
> This series is based on v6.14-rc3 and can be retrieved from:
> https://git.kernel.org/pub/scm/linux/kernel/git/morse/linux.git mpam/move_to_fs/v8_for_boris
> 
> As ever - bugs welcome,
> Thanks,
> 
> James
> 
> [v7] https://lore.kernel.org/lkml/20250228195913.24895-1-james.morse@arm.com
> [v6] https://lore.kernel.org/lkml/20250207181823.6378-1-james.morse@arm.com/
> [v5] https://lore.kernel.org/r/20241004180347.19985-1-james.morse@arm.com
> [v4] https://lore.kernel.org/all/20240802172853.22529-1-james.morse@arm.com/
> [v3] https://lore.kernel.org/r/20240614150033.10454-1-james.morse@arm.com
> [v2] https://lore.kernel.org/r/20240426150537.8094-1-Dave.Martin@arm.com
> [v1] https://lore.kernel.org/r/20240321165106.31602-1-james.morse@arm.com
> [1] https://lore.kernel.org/lkml/20201030161120.227225-1-james.morse@arm.com/
> 
> James Morse (30):
>    x86/resctrl: Fix allocation of cleanest CLOSID on platforms with no
>      monitors
>    x86/resctrl: Add a helper to avoid reaching into the arch code
>      resource list
>    x86/resctrl: Remove fflags from struct rdt_resource
>    x86/resctrl: Use schema type to determine how to parse schema values
>    x86/resctrl: Use schema type to determine the schema format string
>    x86/resctrl: Remove data_width and the tabular format
>    x86/resctrl: Add max_bw to struct resctrl_membw
>    x86/resctrl: Generate default_ctrl instead of sharing it
>    x86/resctrl: Add helper for setting CPU default properties
>    x86/resctrl: Remove rdtgroup from update_cpu_closid_rmid()
>    x86/resctrl: Expose resctrl fs's init function to the rest of the
>      kernel
>    x86/resctrl: Move rdt_find_domain() to be visible to arch and fs code
>    x86/resctrl: Move resctrl types to a separate header
>    x86/resctrl: Add an arch helper to reset one resource
>    x86/resctrl: Move monitor exit work to a resctrl exit call
>    x86/resctrl: Move monitor init work to a resctrl init call
>    x86/resctrl: Rewrite and move the for_each_*_rdt_resource() walkers
>    x86/resctrl: Move the is_mbm_*_enabled() helpers to asm/resctrl.h
>    x86/resctrl: Add resctrl_arch_is_evt_configurable() to abstract BMEC
>    x86/resctrl: Change mon_event_config_{read,write}() to be arch helpers
>    x86/resctrl: Move mba_mbps_default_event init to filesystem code
>    x86/resctrl: Move mbm_cfg_mask to struct rdt_resource
>    x86/resctrl: Add resctrl_arch_ prefix to pseudo lock functions
>    x86/resctrl: Allow an architecture to disable pseudo lock
>    x86/resctrl: Make prefetch_disable_bits belong to the arch code
>    x86/resctrl: Make resctrl_arch_pseudo_lock_fn() take a plr
>    x86/resctrl: Move RFTYPE flags to be managed by resctrl
>    x86/resctrl: Handle throttle_mode for SMBA resources
>    x86/resctrl: Move get_config_index() to a header
>    x86/resctrl: Move get_{mon,ctrl}_domain_from_cpu() to live with their
>      callers
> 
>   MAINTAINERS                               |   1 +
>   arch/x86/Kconfig                          |   7 +
>   arch/x86/include/asm/resctrl.h            |  36 ++-
>   arch/x86/kernel/cpu/resctrl/Makefile      |   5 +-
>   arch/x86/kernel/cpu/resctrl/core.c        | 181 ++++----------
>   arch/x86/kernel/cpu/resctrl/ctrlmondata.c |  93 ++++---
>   arch/x86/kernel/cpu/resctrl/internal.h    | 201 ++++-----------
>   arch/x86/kernel/cpu/resctrl/monitor.c     | 119 ++++++---
>   arch/x86/kernel/cpu/resctrl/pseudo_lock.c |  55 +++--
>   arch/x86/kernel/cpu/resctrl/rdtgroup.c    | 284 ++++++++++++++++------
>   include/linux/resctrl.h                   | 212 ++++++++++++++--
>   include/linux/resctrl_types.h             |  54 ++++
>   12 files changed, 769 insertions(+), 479 deletions(-)
>   create mode 100644 include/linux/resctrl_types.h
> 

Tested the v8 series again and also already reviewed the patches.

Tested-by: Babu Moger <babu.moger@amd.com>
Reviewed-by: Babu Moger <babu.moger@amd.com>


