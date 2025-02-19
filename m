Return-Path: <linux-kernel+bounces-522400-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 51EFEA3C9C9
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 21:31:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3232216E91D
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 20:29:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1700B23098D;
	Wed, 19 Feb 2025 20:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Rof/kGPI"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2073.outbound.protection.outlook.com [40.107.220.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D198D214A64
	for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 20:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739996973; cv=fail; b=gCO4YaPlgri5DyfwNsS3gTZLB1qUIsxj3/OK3bUSC1ISYqXFkaGSdsMzrCNsLQWPaBqJ/iyuG+cyyz4AgUqeRjMt8JRco18C5tUZAYEaLw3XfBowsGS6pyAVVZLaCwtGqZxm9D+5TLyyu4h/7o+5gdLSQHebFUsAFk3AucHjMI0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739996973; c=relaxed/simple;
	bh=P1aHWKTcnCr3ncIbC42AeMl6shFm9GbWHfvYF50ME9k=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=eu6DofqfpEjj8csmzUJkh8gCKQ1TtxX/NhSM4sJMHvuw/BRaxz2Ec0nk0wrwhl7cPNIrAhWAk9DxaugEq5Zxe9IT5WaiLeI8N19Jb18cCZhvSndFTpFBMODQRaSy9jsyeWONMc2ERucp//UD27t5NHGe5iss+9Xtw1kuAOPFlNc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Rof/kGPI; arc=fail smtp.client-ip=40.107.220.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wHuh2pF0TFRIak683hxOIYpbKmLlLkTLolXif67CkWdNk7aZcoFVytsPAy9XTEb4X+lFOVx/pDYKJYH1av2oD91gvTCv2F9CWXSCvH8ObGCrDGUkBMVN4VZeATiEqeVw+b2rKsWwLGyrFciLPSoLaFrJM5wv+u8Di+vhtaxUraHMepW9dQ6dv++f7psNWH2v+S2Uj4LTV3xC48LEW6bQ9gFXw6QN5OeO8GCu4ooFiVprwZFZzfcgs+8BbyIGjA8hf062GvN6Bi4akYEjjODFfc8eE55zsp24PrCxBLAuXOS6dYnWKKVaTPGQ7vEalSyrNon9EuNu2FucaGvKkkowFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dgqwa/tDVH/RMs608YWzbEnOMq7KmDX48En4Hdreezs=;
 b=iBUBJl9IfmPbWAa+lLGGt3IgPdl2egpGJEtOfR+nI3Os6X7DVyO8Y2nLVJd75T+wh3FfLHzUqxkjipilkT/20ZF/tWQUgGDDXdP9ntkALRy0Rmcl0MP4QZE4/7yOPepF8TKT1yCmr67zo79e0qaklPev7uvL7ECFT92MdE7xzQXZQEJ0ADCW3C0bFKg/k8FOKGvBgK0EAy39HQ3BjaIv/TM48GbuoVBJElMNGyV+IeB2MnJFiPyeGJoCHjzO+ocrBO+eqVb9wF3cj3UvpJb9YA2Vruz2KWCMy319zp+Tot3ZTb4AAk0aOq1qdlXDwaaAs04Ja/YtuJ+JHAUiiXLC2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dgqwa/tDVH/RMs608YWzbEnOMq7KmDX48En4Hdreezs=;
 b=Rof/kGPIBEjpfyJQHVKs3ukNPh50mtinKz3ZqfmhMV3Jf4kthHwVa7PDglTyKvhpJI25bugFyR25YGXlMyyK2On2Ybn8mN6ALgOBSSh6Ooxc5olnNqjvcxFm/lGBP+jyl3hiZMgXn+DBX0XF66SngALWDYnweYMX6VEPK8/4GOs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CO6PR12MB5427.namprd12.prod.outlook.com (2603:10b6:5:358::13)
 by SJ5PPFDDE56F72B.namprd12.prod.outlook.com (2603:10b6:a0f:fc02::9a5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.15; Wed, 19 Feb
 2025 20:29:29 +0000
Received: from CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::1c2f:5c82:2d9c:6062]) by CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::1c2f:5c82:2d9c:6062%4]) with mapi id 15.20.8466.015; Wed, 19 Feb 2025
 20:29:28 +0000
Message-ID: <7989d75a-2e3e-4262-8e70-21d4a13e0a27@amd.com>
Date: Wed, 19 Feb 2025 15:29:25 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] MAINTAINERS: Change my role from Maintainer to
 Reviewer
To: Rodrigo Siqueira <siqueira@igalia.com>,
 Alex Deucher <alexander.deucher@amd.com>, Leo Li <sunpeng.li@amd.com>
Cc: amd-gfx@lists.freedesktop.org, kernel-dev@igalia.com,
 linux-kernel@vger.kernel.org
References: <20250219184702.242924-1-siqueira@igalia.com>
 <20250219184702.242924-2-siqueira@igalia.com>
Content-Language: en-US
From: Harry Wentland <harry.wentland@amd.com>
In-Reply-To: <20250219184702.242924-2-siqueira@igalia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQZPR01CA0080.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:84::20) To CO6PR12MB5427.namprd12.prod.outlook.com
 (2603:10b6:5:358::13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR12MB5427:EE_|SJ5PPFDDE56F72B:EE_
X-MS-Office365-Filtering-Correlation-Id: e18f8c61-b48e-43b9-7dd5-08dd51241bdd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OUdOK2RWL1N1MkY3RzB5UGtMbXc4K3AwZ0ZkaVV2L1kwVFJFMXY2UlFaek9Q?=
 =?utf-8?B?R0lKeFpUVFRaa2FId0hKb2F4MkpFWkF4Rkc1bWtOQWl4dUllR1l1RWtSa21v?=
 =?utf-8?B?MmxFVGgrRTVNWUxvSmtwS0x1akNUT1VudFNnenFUQUR2VmVUdjRGQm0rNGtv?=
 =?utf-8?B?d1dPWHhleGlEWkZzSjZmM3lOZzErelo2WmhpUDFxM0Z5bmlzVHU1KzJxSm03?=
 =?utf-8?B?NytWQzZmS1N2SlRHK2VkRHg0ajl0YkUzdmFCZkJueWhpemFkRkVxSnJxTE5i?=
 =?utf-8?B?T3ZjZ3dqanNITTM4K0JwUGRwcExsRHZMcTFwWll2NXkzUDZPZjJGSTlkOWVD?=
 =?utf-8?B?RFd5bjlwcWJsajJ1dVdVMFN2UWlSMGxGVHdiYjNRSUZSQzR4R1M5anMvSERt?=
 =?utf-8?B?bW1nSk0waUZGeGdhQ29sdkU1U1BlaXluaVJ3U1RuYmFSWG1LSTlYV1NpM0dQ?=
 =?utf-8?B?eklvOUIzd2hodTZ2Um96Sm9JWEVaK3dXc0hWSU9ycURJTjZCeVpVTnpqZzhk?=
 =?utf-8?B?dnRxSEZhVFpNS0pVYSs4NFFuOFVGbmlRU0dycEV2YTNhVDFsZCtTcFVmaUhB?=
 =?utf-8?B?eWNudFh6UzZWYTlIUXlTOWlnVThpUUZWWGMrWXpCcHZjUEliT2tFNmx2WUU1?=
 =?utf-8?B?bjNMMGdad1JIL2JhQThHZmFpb21QOWlDWnVrcC9DSGt4RXlzVWpXUjRLTnI1?=
 =?utf-8?B?T0VaMW92Q3RoYitpTTcvZkVXUVUyNW1iMWpZdkpDSEduUXFYekk5c2o5QjhD?=
 =?utf-8?B?ZDlrdmVVbjZma0ZvOUNVei8vbDBaMWZQY2ZqQTRqQTBvS05UeTNuQ1NwMWRr?=
 =?utf-8?B?ZDBsRng0dEFGenpDVmtmUFFhVWpScmtUay9uaGdmQTFSOFVQb3hoc1dZUTEz?=
 =?utf-8?B?aXhMaldXRTlPR25FaVI1SXF4QXo1K3FZdG85V1pic0FOM1VTRXcxaHpzVFFs?=
 =?utf-8?B?TWRxRTFTVkd6UTU1WnBZbVR5TEZlWkludkRJMHo5T1VyQks1Z3lKWE5vY1JH?=
 =?utf-8?B?dUltK0Uyb08yMEhMMjdic1lWZ0lyQi9yL1VaZ2t0emNNNmxocnhwaTJLaENH?=
 =?utf-8?B?bldtR09JNlJ6N3R5SitNMjF0OUkraWV4TVhzd3FwcU1IeVF6WlQ2NWQrMm9l?=
 =?utf-8?B?dFZ5dG8wRkVOWlhpdHhjeHQxbmEvMml6bTF4akExd2dDMHg3TzV2WGRnYmoy?=
 =?utf-8?B?NGRLRnUxL1JQWEVWRm5UcU5NZ1dSMmtQcVp3ck5DRE1ZSVYzNEw1UDQ4N3hX?=
 =?utf-8?B?bHEwVVYrM0RONlA0U2VyZ1AvYjU0TXp2SEdHQUdyVXBzQjFINjNubERheHo4?=
 =?utf-8?B?c2RZZkNwc29ad0FmSzQ0N0VvYkJIc0Y0YW15MnMxV2pDZCtQaFNDVWRKb1BF?=
 =?utf-8?B?UUNKTEowVXV6QXI4YWpYdExqWHZ4MHZMTUowTVdRaE9UdEtGVlJEQ0xsRVF0?=
 =?utf-8?B?Um9FcTNiMVVkaCtJclluYWlxLy81RUIyU2JRTE9RcTcydEVvNVVNNlVQOEg2?=
 =?utf-8?B?WnRrK05Ua3VrOW4vbTA5WWJGeWtrN25RMkduWXdyN3ZUeTcxL2taQlF2azdD?=
 =?utf-8?B?ektvSGR1NlhZLzU5dlF5OFFwRC85UDZ5bnFnaHF6UTMwb2FQNE5iQVNmTTZ2?=
 =?utf-8?B?b0JZTnM4ZEQ2blVGb09ZNzFJajZpNXJYTkU5SGJVS2c2ZkVjVUV0MUJOQ0tP?=
 =?utf-8?B?V29GU1FmT3M4OWdXalMvOHIwZS9QVHRNcHppZUJFckdyOHF4UmNOOWRoZVd5?=
 =?utf-8?B?YkxYQVo5clBWaXhJdDdVdDRRaWVCeVI1SDNta21qN0J4ZnVYZHQzWFBuSjVu?=
 =?utf-8?B?Szc3SkNQM0dvVUFkeEtSUT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR12MB5427.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?b28xMnBxRjlJcXJFdHZmQThEZWlHWWFyVHVNVEk1cDVkbUVGTkdla3JKMm02?=
 =?utf-8?B?UHc4MG9iUTB6N3pkVEVnd2tzUXZyWFN6TXA1NGdqMTBMc05KREtraVExeGs5?=
 =?utf-8?B?bDlzb25JNEVGbnptQ3RsdkVpYmpaSS9OTGRDcW5MOVlKc0dybGgyNUxSSjNx?=
 =?utf-8?B?Ylh3c1pDb21oSjdiVWp3cjRvS2I4UWFMdGZXaTVGc25ZcFduV1NaT3NFeFkz?=
 =?utf-8?B?bG14dUM2c3FVUHdudEx4SzB6VXp3WVNMbUViUmg4VXA1UjM2cUlnN0wyS3pD?=
 =?utf-8?B?UWhWSnlxd3FQNGk1R0ZYa3Q3VDc0cTljeHIxTTljcTMybDVnMTIwM0dEd1BZ?=
 =?utf-8?B?aDczVDZQWXVTMDRJWmdqbUpHdVloekJ5NVpMVk5uVlpDTkRQbllRMndJN0xs?=
 =?utf-8?B?TW40d1hwcUdLVkk2OEhYT0NLanJZZk9UYTQ1enZOb0xPbXdGS2VtbVJQVGVn?=
 =?utf-8?B?QnJVcnV4WFQ2b2JPRlBpdXF6VncwQ1VkTStnS1Y3UkRNWStXeGdCU0lOa2g5?=
 =?utf-8?B?MHRObERaSkdKZit0d0dqVDhKcGVyNnFHancrV2RHRXpMUlhDMk43ZE5mdmxs?=
 =?utf-8?B?Mm1XZnBXNmNhdW43TFR1bWpmcnQzaVJlcTNELzRENnhyaFNQa2NIZVZISHNm?=
 =?utf-8?B?Y3RsUjRaTU5TemV1K1kzZGRJK1E1OWFZQm5QNmxVL1FjS1VkbmJkd1UzaHM5?=
 =?utf-8?B?M3U4QTdlRHcxZE5SL1JtQXVpQ0Fydm1zS01GQVlqVnNkcWphK1JRUStOUWh3?=
 =?utf-8?B?aGVmV1dFM0NQK29wUDBRY2RneWhnM2pyTHlLNStVMXF0OE9DWFhtZmpHQUs5?=
 =?utf-8?B?dTQ2dGhVU1c0bmJoclNYdjZhTW1qemZQRFZFU0Z5QWZYTnVjRzZnYStmOGlR?=
 =?utf-8?B?a1VDYUtJakZHb0dNQUR4K0prNkxwK3laY2dqMjlsT1Jkd0ZnMUxqR25XcmpC?=
 =?utf-8?B?UGVNQUFEdFUvK2xjZFc4bjNhQ3kvN2k0MHlqSmdMN3Z4NjNVWGMvSWJRS3ZQ?=
 =?utf-8?B?VXBsQ2tzR2pVR3RkK3JFS2h3S1haWWJhTlhKNFREWEVNbDVzRExDNnpQVzF3?=
 =?utf-8?B?RXNGRWo1YnNJOWw0OFZQSG9PN3FwYmxSM0RUaHNET0h0RTlJNlloakxFNURa?=
 =?utf-8?B?ZWs5VEdwUmFWR29USlNiWklsVHlxNnJ3Nit6d3lBSlhkalFZY3dlLzZ0UXpZ?=
 =?utf-8?B?NDNXbjZjcnVQVVRlWW1xaEYxQUJVNU9mcEZVNHBZQXRZVXY2MExlQXA4OHRF?=
 =?utf-8?B?YjhkVWxIK2s4UUFmZ2ZhRzN2TnF0cHJhSjl3d1BhZ3E3aEVWYzYwKzVadk4y?=
 =?utf-8?B?RVFBOHdoeEIyUlhVYnRKVXNRMlBCejNDUUlPdGQzWFJ6aSt2V1VUQ1JMK0RS?=
 =?utf-8?B?K1FIelBJT3ZrYWtlUElNZTQ0b0ZCZkFDQjg1V09OQmlNZmR1YWM4RnJwcXJY?=
 =?utf-8?B?VC92dFZpRWppYm9Zb3dQT2FsZDZWQktVOVNiUEVtazgweHNWRHREbkVoVFJv?=
 =?utf-8?B?aVF2dzd2TndIakovWjh2emVDRnlXUlV2TGVzcityKzhNbFpSSytCN3RWM1Rq?=
 =?utf-8?B?MkZPYUtYcXpYUk1adEo1ajlsNFk3SGwyT3h2clJYZy95K0hDU1k4a1Z0dmkr?=
 =?utf-8?B?L3ltQkpGUWpid0VKSit0Y3lmdWlObGI2V1FQVXgwN2xhUTk0aWcxeGJ6VnFI?=
 =?utf-8?B?L2h1dld2eUlLNm5pYnJBKzV2dHM5aVdpQmpoNjFxWTQ0QWlVTnR1eUYydGln?=
 =?utf-8?B?U0JKdTdCb1JOSE1ReGJuNW1PeU1Jdi9DSHhPT1dpYU41eUlrMjZXN0xQc0Y3?=
 =?utf-8?B?bkhTMVl2TE1WZW1xTS9ka2pFaTB1N21BVjFiZTFFTzlnUUpHalhVTm1JNkJN?=
 =?utf-8?B?eVFWeno2b0x2YTlmbGhGMndjRkRvMDg1QTFrTlZlVzkvYzRQL0toYk1teGha?=
 =?utf-8?B?WVptdUgrYWM5M25jbEk4c0w0S1N4dzQ0OGFlV1hMRnFyZGFNbkplZEdDRDlI?=
 =?utf-8?B?d3VnZXY0TUJMNVRlQ3daMVhpK1JNek9FeDVGQnk4ZW50SHdWalJqWC9jdGpm?=
 =?utf-8?B?T2NiVHpQaFJGdEtSRzlxdW1HVnhxSHNGZlpVTjYzQ0Q0VkM0dWY4Q2ZZRDhv?=
 =?utf-8?Q?G3lO7mV9MYOOsrgtjM1IUZ2io?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e18f8c61-b48e-43b9-7dd5-08dd51241bdd
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5427.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2025 20:29:28.7271
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jAs7NRfXX6fFE/5GIU3y0gdSrt2ww2/NZ5JcHCys3Aggw9lxG3ayfISQCTKUSGa0AQWkYUrPHsHZHvqnWEyk8g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPFDDE56F72B

On 2025-02-19 13:46, Rodrigo Siqueira wrote:
> Signed-off-by: Rodrigo Siqueira <siqueira@igalia.com>

Reviewed-by: Harry Wentland <harry.wentland@amd.com>

Harry

> ---
>  MAINTAINERS | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index c8b35ca294a0..a94abf72e117 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1024,7 +1024,7 @@ F:	drivers/crypto/ccp/hsti.*
>  AMD DISPLAY CORE
>  M:	Harry Wentland <harry.wentland@amd.com>
>  M:	Leo Li <sunpeng.li@amd.com>
> -M:	Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
> +R:	Rodrigo Siqueira <siqueira@igalia.com>
>  L:	amd-gfx@lists.freedesktop.org
>  S:	Supported
>  T:	git https://gitlab.freedesktop.org/agd5f/linux.git


