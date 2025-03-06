Return-Path: <linux-kernel+bounces-549876-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CC0EA55814
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 22:03:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 53DA91657A5
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 21:03:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EA00205505;
	Thu,  6 Mar 2025 21:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="awJi6U/0"
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2087.outbound.protection.outlook.com [40.107.243.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22D312063EB
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 21:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741294910; cv=fail; b=lxNo7keztHeHHIDMCw66uXw4CNoHGA5M51H+SiMrUDqy8HKKOAcooc8bEN77qj4LWcQMPLb9Lsj+BOa0zp8TIE7M/lIW23W5pQ/Tf4QuzOrh3uqQQpJ3WgYH+6wuwf/FxxOT6sGCEdSKY/B/DuP2GSJ94PulhOwvW2yM5jLSPx0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741294910; c=relaxed/simple;
	bh=fTrDYygznr6uUJgXWo+f+Kzt+q6oavhHDNy4q4RueH0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=g9xH05kGzlYKIv03spLUDeEuoW4DAgkf0yK8dFmRh53D+5+G/i1a/Ase7lbuhDJH0aItq9qB/GyUohdMSpfdKGBEmDS7Cxc0PRppHENu8fsIsrgmk0Bo0//Z0zmz8+nJdRa/8oNXhe4nMIr+fqGIvRUE9E3ogeNWZSJxtrAFlSU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=awJi6U/0; arc=fail smtp.client-ip=40.107.243.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ni14vTgg3h43eWO9W787USZTdpK85yKmiNWQpk+tGuPPmYn19X4OM1uDU5ZbA+TxKZ0HOoqngVEOtUZyHtku2uvuxWpL9zTdUAcELhS7hX08LQrB17/VezPWff9UuBze30SRCGgdXQ16k2vJiINrmdHNoHhSV6do2T3IJfNr16neqxgIWbQoS8hr/NGPD1uBFB+50IC9BWelL9F3z8Msp9MM3V6LmXmP5ZPKBD1jiRqYi6xJVG+ph/o9vWwQWg2TntMbzJmqjTR6GIyuV2COJaUbSGhLeLRiHz+9gIAhvOS1ZILvCxV6xWTxRANwY7KXEp23MsvwURPYUgtTOMnFAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fTrDYygznr6uUJgXWo+f+Kzt+q6oavhHDNy4q4RueH0=;
 b=upbXI/f8w+TlITQXBvGdFrAFvujlevmk6jTF9uZ8bPkWV8B4DsVsYJjpfw5MH4i6aUAvN35D5HktooldP2NiKiHj4+Tu+9aYaMidlmhiauDWWpNvF5h8aWgp8sE4zGEAaCqDjA0XzMuxJA9W0jWZY4kmqVVNPP1nyhh3QL61xL4o/U2giaJ/i4y0sHSTlVIGzgNJNY3beyrYahL2tx2tgv40YWA8PQbBlGoDSaaeIeYZltZxZQhbUCcbppKXCr/2lqllkU37Dp4WmFvpQMyN6mFtJnCF5GjeLhOC4MrBF/QfyRkdybufbXAxNjhv5Awzr8vuBS/u/QUBKe9cePuwXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fTrDYygznr6uUJgXWo+f+Kzt+q6oavhHDNy4q4RueH0=;
 b=awJi6U/0y8rHUmvyqKQPiFdT/0YKm8nr0P0JIJvo631uBV8rcr+2O7KVcAvHa2wPSNl44VNg3oHyulQTpwZ1c8TF0XmWZbxXv0bSb1z4rkfqVXHth5yKGKktz44YvFcwwFwreYclSLDYoLELkb3/GW290D2pvSY9GMvACtZ9dLviTACsmwo2QuXJYfwp8slE4792f5Qwy0UcR9GQPtM8KefBLUT+K1fFhBXy8oq79q6qsBCP9vFH7IoHWMsTIqJcZNEGdJifKEMRNFwAwnLYdl/Z9ArFsISd3ZVTUkuQwHS45l7YxAEhhZPA70OULFQ94GrJvWcfuJNQfgHCU56Obw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB2667.namprd12.prod.outlook.com (2603:10b6:5:42::28) by
 IA1PR12MB7662.namprd12.prod.outlook.com (2603:10b6:208:425::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.19; Thu, 6 Mar
 2025 21:01:44 +0000
Received: from DM6PR12MB2667.namprd12.prod.outlook.com
 ([fe80::bd88:b883:813d:54a2]) by DM6PR12MB2667.namprd12.prod.outlook.com
 ([fe80::bd88:b883:813d:54a2%5]) with mapi id 15.20.8511.017; Thu, 6 Mar 2025
 21:01:44 +0000
Message-ID: <f36ad531-5289-4f0c-89d1-d1fbd30c1e29@nvidia.com>
Date: Thu, 6 Mar 2025 13:01:42 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 05/49] x86/resctrl: Use schema type to determine the
 schema format string
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
 <20250228195913.24895-6-james.morse@arm.com>
Content-Language: en-US
From: Fenghua Yu <fenghuay@nvidia.com>
In-Reply-To: <20250228195913.24895-6-james.morse@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR06CA0052.namprd06.prod.outlook.com
 (2603:10b6:a03:14b::29) To DM6PR12MB2667.namprd12.prod.outlook.com
 (2603:10b6:5:42::28)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB2667:EE_|IA1PR12MB7662:EE_
X-MS-Office365-Filtering-Correlation-Id: 6da3d182-cd95-4219-baa4-08dd5cf21a1c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UDlYekh4US9xTWFYUmh0K25HSGZqMHM5S3dSbVU2MzQvemo2RHlRUzVMWEpO?=
 =?utf-8?B?SjVoU29xM1I1UXVGbml3dUFHelVIb0dMMTllMDhuSnNpQXNaVmw0MC8zZ1Zv?=
 =?utf-8?B?Rm1jRkY5OXg0TFQzcHBydW9nSlNRWklZdzlEbmlyY2tWS29aNjRLV0tZRGQ0?=
 =?utf-8?B?cTV4UHVWOUtXQzBJWm0wVnh5U0ZPckJQekdjamdPZjd6aGZqMXliaUhiWkFY?=
 =?utf-8?B?ZUhtUnJsVVRnNjB1YWRRUmxoeGhhZitIOGhzZ0VrcXFic3JFS3ZDQkR6c2JB?=
 =?utf-8?B?S3N4SE1idGlISS9YNHJWVjhiZ0VvWWkxQy90SFBWcUNyZ3I5aXdtRjhTQXdG?=
 =?utf-8?B?SG5BdEFYdWd5SGtRRWViWVhWTnlxTkVXcCs3T3FlZzVmUzlSSzQ1aXhwdTA3?=
 =?utf-8?B?QytZSndpZ3NJcEpqZW4rY2JQNjZEaEo1akVUWHZlcXR4RWRnQno2WU51ZTJz?=
 =?utf-8?B?WituM2xjdFE2UjRLaTZ3eWJFTHRBQjdPcW5Kek80QVQvOUNGbXhBTWtrUmJv?=
 =?utf-8?B?MkVXOS8rT3VEWmVqMC9xeDZjZ1NWOHh1MklOdjkzSDhMUGZjT1QzVmxzV1Fl?=
 =?utf-8?B?b0RweWVvUkl0NlNkYzh1VHdFeGlyYUlpaEYrOWd0eE40UHd1QWU1RUZGZkdp?=
 =?utf-8?B?dHd2QkN2aWhjRkRxR2laUVZsU0NnWFk0VUhIUFNpZUpyRFRjYnlKeDhUZGZF?=
 =?utf-8?B?cFNEc3p0UnVVbVNJakV0WEkrcGgxY1FLMXgvSTJEaERPS0VHSEt0L0NNVXJv?=
 =?utf-8?B?VkNhNmFMbm4xSGpVbkpaV2psZ0tuUGdHMllkSWppR3V6VnRFd00xbjkvNXlN?=
 =?utf-8?B?dWxOQTlNUTkwOEc2Ni9ya0xOQ3FlQVZiQmVyRFZ4TlRRdUdXRlQ0R3EzMXNt?=
 =?utf-8?B?TjZJMUpFclJNWVdZdDNiOUhxNTN3NjhlaXFzeExObHpZUjduMDZIT0I4YlQ5?=
 =?utf-8?B?QUJhbVVKcWdPdXBRdGxYZjZUM3h0SUlFdjNuUUJKOHJ4bWFMZW56Z1FtdUpS?=
 =?utf-8?B?Tkl0ckVEdlBZVWR2S29WMTRxeStwU1hiYU9iOHJlcHZEeFlVbVFuT0NKczFB?=
 =?utf-8?B?ZHRCLzJORHZ0NlF5V25CTDdWZzhNT1pmMm9CNExhMW02UFB4NnlLOWJxaEFz?=
 =?utf-8?B?RUMxcUtoaGxNVCtDUU5TSS9wbGFqaXVKMStYOTZMNDR2L2k1c3o0eDJjNXhh?=
 =?utf-8?B?dUFMd0dzSG43YjZTQzIzemwrWThoc1o4OXc2YkFPZXVzMm84SXh2bU1TSkt1?=
 =?utf-8?B?b2JQSEt0b3FuRkM4ODlUTlhHaXJ2TGlNUXE1dUNoaTdodDlzOXM1TXl1Nmc4?=
 =?utf-8?B?RDhpbXRaUG9KejhaWFVTRnNOeFRTTkpwcXREMXVXUUxmM0pVVUN1Rm51MGJW?=
 =?utf-8?B?ZWpUR2NtbStBYkdzbFAwbUFxUVUwcU1nengrZzFZZDJiU0h5OGhxenNmZm96?=
 =?utf-8?B?N2hXZmNCUVRkaDQ1Wml1LzRXbG8wMmthQjVQNnZMSnQ0V3NySU1YOEhtNlpR?=
 =?utf-8?B?dk1Nc3ZHQW5kQVI3S2ZpVU56WVlsVFBVZUtYN0wxOEZGNFFEYWN5cThvUlE4?=
 =?utf-8?B?czdsUFF1ZlhQVEhWWm4rMnJUajJNbTV2RmRJQ0FHSHBJNjExdy9VT3ZCckNo?=
 =?utf-8?B?STErN1Z3aG4yc3Z3RC9Tcm9jbVQ5TmRNMnNyUDZUaXVtdGxYUXlPbFVIZTdE?=
 =?utf-8?B?ZkJBNUoxRWNGOFJ1OUhhS3dyd3RVdG5oZy92bDZoQ1ZHVktWMUdtYTBUY1JT?=
 =?utf-8?B?L29jS3JEeHJBTzNiSm1VRmRlcDdEZjNMVHdtV0lIYlRwcEJxVXVXRk1wYlRX?=
 =?utf-8?B?SHVIcHdnZS9oNHZ5L0hSVVRDL3hRM0RrZzc1S0REd1FQNmd2dURKcTFpdFR6?=
 =?utf-8?Q?zoqISIK95LQKw?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB2667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OU5xbEZSV05JQVZQSkRVQTM1MVVkc2tUaFlXM1hUNEp2Y2EySHhZVENhSmNZ?=
 =?utf-8?B?My9ONGxiMlhyaFFjUWcwbm9HZXhCM05BSUF5bEhtVVRvcEtjdUIydTFjc0ta?=
 =?utf-8?B?UHRZcUtwOUZQV3ZOWGJLemlIQkRZUlIyd0NIRjF6UVRhVTZpUytxZ2lFbnJO?=
 =?utf-8?B?RTAvYmtSVmM0YSttcC9MR3U4cHoxNFVIbExvOTdPVnVGdHhUU2JsU0tLQ25w?=
 =?utf-8?B?QytwRGZ4OWZ6cjFyQVFzT3NnVVRqaTd5bjZsV1RLVUh0WDdiUzdCVXAwbFMz?=
 =?utf-8?B?MGlCSmlDVlB5dzg2NjArbUhTK1BqN1dTNXpWWDFRU2paQ1JuajRHMEI0NnBp?=
 =?utf-8?B?V1duUmsxd096alNlN2xUQUgvUnZEME1MYVZmbExzT1lpUmpuSDUzYWpwRlpH?=
 =?utf-8?B?RGJHd0dQMjdtZEZvaXByWjJoTTY2NTNaL05rQk42ZUxIQ3hMNkQ4dmFGSTRw?=
 =?utf-8?B?ZVVmc1d3WTE2UmFWaEFyNFRneUVnMXhManRTN083N1lTaGRyTjlTUm02VTlG?=
 =?utf-8?B?Ynl4YnJwQ28zQWF1NFlhTVVzUDVmeUpKeWhaRE5sUHlIN3RkRkN6OXUzcGwr?=
 =?utf-8?B?dkZ4d0ZZeUdTbWxUL3JsSG9aWktiQmpGSHB6Q0NLV21YQTVJNEVyOW1nNDVK?=
 =?utf-8?B?SlNQN0xXeVJpb1dlS3I4Z3lIMTdCTlZmSFB5dVU2NUtDRDUrKzZxd1ZNNE1W?=
 =?utf-8?B?c0dBNS9aaHNJai9Vbld2a2tlNUpWWEM1Q3hIenREZjFxNXZrN1BNU3BEc2Yx?=
 =?utf-8?B?am5BS2lrdmNrU1E5Zmd6aUkzb3kzOGIxa3ZRTFpZSnZvTVZWdjR5RTdNeXhl?=
 =?utf-8?B?RmtvWENOUzZrdDZkcENkcmw2Nkg5K0NUWnozT2QrWnZVOC8xcVNGTXdLUFIz?=
 =?utf-8?B?MW4zcllxR3BZb1ZxNFJSeU5nMitxVW5QLzRZWHp0ODQ5N1FJb0lvbEpMaDlv?=
 =?utf-8?B?bndRQ1EybkhLWlIwOVRGczNWOHVhSWtyT0lHWjBEVmhKOGMrM2JlR3k0clY3?=
 =?utf-8?B?ZE4wQmJXZWV5SmJhY0psSVhRamtKamYxTnlOYUYyd3lxZjRnL25JZkpiY25E?=
 =?utf-8?B?VE5xTERzUk1LU2x5a1kzbjQwZkQrT3JRY2h2bGMrS0R4OUdmME8zb1JUZThF?=
 =?utf-8?B?TGdIMEFKRW02WGovR3ViTHJoWWJqNS90d1owb1dVa2tpbHlsTlNEZTROUVE2?=
 =?utf-8?B?MXdBelZUZjZFUjhJK1NCdXo0S2xLRzZHMDUvZ204bFpPMHlNdVNOTkJjOG94?=
 =?utf-8?B?Y0F1eDF6R3RJZS9pc2QzUlh6eHVzSVdKZWxhaHRKNU5uc1VUdXljaDVOcndX?=
 =?utf-8?B?VjJBTk9BakNJK1FHbFRqMTVUUmY1WFdSK0RRc1ZlaTdtQWw5MkJ4WnlUcTY5?=
 =?utf-8?B?RkMrR3hmRWszNW5HSUltYzFDNzJWRjRXa3pScCsvSlVVTzZrSDYxd1pMem1t?=
 =?utf-8?B?SVZaZTJvMmptOTA5QW1XWTh2WGVUV3pNTlRPelRWNU1zMWFMR08yKy9KU0d2?=
 =?utf-8?B?Q2hVNkIwS1BCSS9oOGwrUGU4QXhueXl2bkdYb0p4U3VOeEM1dVp2ejVGZ3Vn?=
 =?utf-8?B?bCt4K0VjZ0lWWS9kQ1JzNmVhT21SaWVEZXQySDZkRWV3N3FmOTdnVzJPNGF6?=
 =?utf-8?B?eXF3VDIwbEVHOEU5TUwwdlFrNExrMzlQeC9vSmRNM1kzbEhrVTNxckhBVFZG?=
 =?utf-8?B?eXVMSXlJTGdEUFZPOUprY0pyc3RhMEh1Mll3STkwV0tIbmg5am9BeGZSazZs?=
 =?utf-8?B?bTZRYUxaNU9zaUx1ejJYSkM4SW9qczEzc0VQQzAzTXZXTmtEN0xFVFE4RHd0?=
 =?utf-8?B?K3JYdGZrdDRMMVFGT05leTRrbWFxck5JSVVnbUdMTmFCOW5teStHb2hCdnh2?=
 =?utf-8?B?UDlxMERRUnB0RTlKTlgwZndnSnNWMnZZS2RZNUNFcHZzanpSTWN0VUJkWllu?=
 =?utf-8?B?bldPUnE0dCswajlBRWFzeW9NKzVCNXc3Y0NzVHNSd3JFTnBWMEwraU4vSDg5?=
 =?utf-8?B?VEUrNjlKZDdtTGREU1JmRWFzeTIzbmNtVndPeVRPMzZtdlFvMmp3NWFwOWpl?=
 =?utf-8?B?VUdkbmFBR0VxZ3M0VU5lYURiamVHZG50dmNWMDFBN0hCOVRpRDB1d0I0ejVR?=
 =?utf-8?Q?pVyXyu9J6GHAzrZ4jv0f8tINg?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6da3d182-cd95-4219-baa4-08dd5cf21a1c
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2025 21:01:44.8379
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: V8kiE4nzuDYvqVnwvk2Vzfm4nZq/d/peyJypQGsUx0AwlbzlFdran0UTZuc7Igr7vID7/GplYtE1WqgyRmLR8A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7662


On 2/28/25 11:58, James Morse wrote:
> Resctrl's architecture code gets to specify a format string that is
> used when printing schema entries. This is expected to be one of two
> values that the filesystem code supports.
>
> Setting this format string allows the architecture code to change
> the ABI resctrl presents to user-space.
>
> Instead, use the schema format enum to choose which format string to
> use.
>
> Signed-off-by: James Morse <james.morse@arm.com>
> Tested-by: Carl Worth <carl@os.amperecomputing.com> # arm64
> Tested-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
> Reviewed-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
> Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
> Reviewed-by: Tony Luck <tony.luck@intel.com>

Reviewed-by: Fenghua Yu <fenghuay@nvidia.com>


Thanks.


-Fenghua


