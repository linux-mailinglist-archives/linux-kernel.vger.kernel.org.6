Return-Path: <linux-kernel+bounces-550314-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F590A55DD0
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 03:44:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 79D901893B12
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 02:44:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92743185920;
	Fri,  7 Mar 2025 02:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="FkV4Ziiu"
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2062.outbound.protection.outlook.com [40.107.101.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47515168B1
	for <linux-kernel@vger.kernel.org>; Fri,  7 Mar 2025 02:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741315463; cv=fail; b=exb/QKjwve/tjGxSjk+2QHreE11FZe7Pzn9AaPuBVtZirMeDCKMJvI7Tuzi9WMcxINLVJje89aOvO/2gXeEIN/6+UZrveF84jYwl3D0hDpXwhtqhrMzzRTzVYz8h2qHdYcDmV/kMpyMF43Q7t24UIqdWqKOvU+N65+UPlflQF4s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741315463; c=relaxed/simple;
	bh=QJU97G0nFEs4E59162hGZVtoZKItVqssdJfumQKEWws=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ttryph13I1wRadUStyb3tiYL/IzQAwyoAX4gWoUxUGmRMxJt+Fae/cf5J9/WWnCaT8zPtahIs/vj4O4OGxga/RSXTBtzXbpgrmbrB7+ZbQEw+CcxGRKy906v+dPW22EXTfDSBv87MgeMXQc2W0Di3X68ABOUliLLwAztzvG8Zzo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=FkV4Ziiu; arc=fail smtp.client-ip=40.107.101.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vzYeD9WlaQcw7QZ/i8iqyw5wq8XUGoo8Vo3B298tJ+yNB9yaUwmUzc8Xc5ghFyZ/+rgnDh5ChoeIPHC2ZqKHWS4agkqdTakn65MdwOlqgZNJtNhTzDdeWdAl6I6SHPCv6r8ikytkWIkTUbzPPIAwSEAtUM2NctcoctomRq/AxF1N7t6xercplhGZoNKojHwcLz87BFj95UzMHXEOeaZqzPST6D80cKB6qXXSoTRscpd4auEwbxn2PQbwyCBO/MpL5BbyElHs7cuMtniS0Q7XmejEBSfDIw5zYL3y8ptR65ufLDPeGIG00MGoWqA53XJpOxqzsSv52qmwW46+PzakzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Lyb0qMHJ3pC9cZtuP74Z7c+oEGj+Rngf2+M5leNjo9g=;
 b=QKkhHsraWxCigonggmw6FmVsz8Fju5aGsbK79/Xva62aVLegNkj+Kf4aYX1RrVlpN7RmPcXqOi+6BPri4zXDzn4WMyChhJ8oEkBcn2iQIO9xyX0pH3DawZdVgZ5MoH97lF2aFSY+q5S9NS/r2F2SnngXdKbfAbUY9K68+nmc5s7LybGFi8BcTFV/pcGJd0EsSUSetsy1ttqQJAeJX5VpE08p2wkkYB2XL90vEdYP7Ki/467C6/m5yxlYGdsxTIlN46lcnKyBdkYGpO8qD8CdN7EJ5YVuOVOz3xGVRCOemwSwkrrE3qoiQ3MKn/JdeWnCDHXPikiZXXXcNX5xYDDCBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Lyb0qMHJ3pC9cZtuP74Z7c+oEGj+Rngf2+M5leNjo9g=;
 b=FkV4ZiiumSbj+YEvW2Szg0D05z+gp70SmMFxYB1rmRfVxKbvjUBVQbZIRd0izBbeE+XuA5A7poE5sc1kxy+CZCJ445TRixbBo9CUxpTwn+KJc1qsblDflAljtiLms22xzzvZZKYEcWhg82jdNez6XjO8JV/FrF0IiY3oEYbN98s7d5zt25XTKy7X4XnEdW5TZvVfr9l3tOsm6+8uBBa0tS6ned2ZaalYV6vfBMbst4MVhbT2alUUlicC1ExnYkXZM224KMiSiETaBqPDTTroA8PEN0KrF9IXKrn5INRn0z4nbUgVBNusZrUQ++I/VvrjT1Ed+bmm16gDubJlsavkJQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB2667.namprd12.prod.outlook.com (2603:10b6:5:42::28) by
 DM4PR12MB6448.namprd12.prod.outlook.com (2603:10b6:8:8a::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8511.17; Fri, 7 Mar 2025 02:44:19 +0000
Received: from DM6PR12MB2667.namprd12.prod.outlook.com
 ([fe80::bd88:b883:813d:54a2]) by DM6PR12MB2667.namprd12.prod.outlook.com
 ([fe80::bd88:b883:813d:54a2%5]) with mapi id 15.20.8511.017; Fri, 7 Mar 2025
 02:44:19 +0000
Message-ID: <7367ec47-cc1b-4b5b-a406-90853a11774b@nvidia.com>
Date: Thu, 6 Mar 2025 18:44:17 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 48/49] fs/resctrl: Change internal.h's header guard
 macros
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
 <20250228195913.24895-49-james.morse@arm.com>
Content-Language: en-US
From: Fenghua Yu <fenghuay@nvidia.com>
In-Reply-To: <20250228195913.24895-49-james.morse@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0172.namprd13.prod.outlook.com
 (2603:10b6:a03:2c7::27) To DM6PR12MB2667.namprd12.prod.outlook.com
 (2603:10b6:5:42::28)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB2667:EE_|DM4PR12MB6448:EE_
X-MS-Office365-Filtering-Correlation-Id: 9cb21f25-a31a-4fd7-89c6-08dd5d21f59a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|7416014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dElzanJDcDlLVk1xV1d5c0Rya0RWRkZqZFRRWnJXcGl5Y052RWZwZkR6K0xz?=
 =?utf-8?B?elpIcmVRTEI0VTdlR1NYZzF2dGhzSkFSdm45d2dTZ3lhWko3UU9ydmZWOG5n?=
 =?utf-8?B?b3IzajFSQ0NuMHhHd3lIZXZOKzluYW9vMURRNEQ5c0VaQUNicklkRUtKOWl1?=
 =?utf-8?B?MXM5Z0VCaDkwcDZVMHkxeDF0RGpFVW5mWllxUUZ1eWw5VEtPaWcza3pUeTdk?=
 =?utf-8?B?bGNvbWJjSkR2QWNNVkhKaStWUWpSTDlKc0U1UDRrTnRLeFJNWnNPcVR5ZU8r?=
 =?utf-8?B?RlZiL1FaYTBmUUZYZkRPdWhTWUw3Z3ZHRVJIVDNSRjlwQWZuSFhJUGtVWmxu?=
 =?utf-8?B?QlFzeWo2WDZ2SlB4TTRZeTBvdURMVVV0cDFGUWZHbE05Z1dsdXRaU2lkU29R?=
 =?utf-8?B?aUxHMnhhcTRBQXZlZ00yb3E5cDczTCswVTlPSi8vMlAwaEF4S3pjM3FmcTlI?=
 =?utf-8?B?UVpZR3RPM25uak5NdkViSmYvckwxRmJSSkFpSmREVTJLbEtSS2dPczFpcHFa?=
 =?utf-8?B?d21ZTXVEWGJORkUzN05kaUNYWVhCVUc1MEZzOU1ONURTUms4V2NtSTZ5dXRL?=
 =?utf-8?B?UmJDWEFDQXJ3SVliMjZreFZlNkZjc0YxN05WU2phWkpua21oWG5wSmxFQjZz?=
 =?utf-8?B?bmFVT0F3TDQ2eEdSaVRtS0ZTU0x0bVQwYUl4aEZQK2RERXB2QllGVTFCdHdt?=
 =?utf-8?B?VnVXb0xjZVJEOEtzUnIxL3dlVys5VzczSjdSSWlodTRpdzlIMlRlaThzNUU0?=
 =?utf-8?B?eHg5WktydERFeFMxZEl6WjQ1QVpabTBDQ1pnRUh2OE82SXlnMXVHL0o5dXg4?=
 =?utf-8?B?eE9haFgrdFVCc3lqL1FmdDZRYjNLdHhSZytEVWZkZzhueDdyOWIrRjZ1d2ZT?=
 =?utf-8?B?SWtteVA4UHJmOGwrd1FURlVrbUhwL1Z1NU5LblQ0MmQwc0hRNVJXQTZNSCtC?=
 =?utf-8?B?dWdMM0NWdFl5cFYzL1ZwcEhoYmpQMUVnbE9xY3lZbmh5QXgyTkcrQVZJeUM4?=
 =?utf-8?B?ZmVnejJtTzBNcWxoeEFOUm5WU3oxTEYwbjBJcmhOVkV6emVzOHBvd2FaWW9v?=
 =?utf-8?B?YTV3eFlaZkFIQVRmdGozelZhVXVLSXdLRmtFUXRHL2RoR0hZNkZiUUdCaTVG?=
 =?utf-8?B?VWxJS2hNOEk5ZER0SGRtbTJsOER0QUYxSHp2YTFvNllHeW8xOXlvOTNXU3Qx?=
 =?utf-8?B?azQwaG9tcUxhL1ZJT011UVM4QmxlMHNzTFowZjVTZGJhN1lWSUFOdWlOOS9n?=
 =?utf-8?B?Umt5em1RVGx4TDlzNERJSyt1Q2pMbERlNVMycWFkSmZBd1dlSzdkSy9zS3dQ?=
 =?utf-8?B?L3ZDM2JvaUFJZVFMUFNXcWp4TFM1eEsxT2lnVFN1cERYZ2hJaXdUNTJLWFBJ?=
 =?utf-8?B?amFMUHg3V3U0NllxVnM3eTRzQ1VKZDFYRE1yRXlTU25oMkREaWdpcDdCWnIz?=
 =?utf-8?B?QlB4a0NZTkxyZ2JEbU1sNGNLdEgxc1pVSW1zS1orcFllRzd6QmZIeHRaem9h?=
 =?utf-8?B?NkhtMjFOZldtWVFML3M4SmN0K0s1VE9haENJM0szV2lRejN0QVVUNExKbHRG?=
 =?utf-8?B?NG93WWRjb2xGZFgwUHVkekg5VFZMazlsZFpsRk9Ud3JsZisraTdoeG1GU2Z4?=
 =?utf-8?B?Z2NaN3RPWUVZbzVxbjNsaFIvT3pGMmhVYkpTS2pwNkN6YmhzcnVVbmg5Z1g5?=
 =?utf-8?B?Z01DL2JKNm9QWnl0K3crc3NhaDN1UUdBcjBQdVBqbzE2RTU5a0VzZ1IvOHdI?=
 =?utf-8?B?R2U4bnQ2d3lkUDRIRllVVW9tMWpVMFBOVHVvZjdhcTF3dUl3b2xKM0Y2UzR2?=
 =?utf-8?B?MmhTZWI5RVRWZEFucVZsWEo2M1JwWVNMZHJUbzhsN1hsaFgzZThDQyt2S1p3?=
 =?utf-8?Q?0iYg7Bsxua4mM?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB2667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VWlrSk4zVHJqeUc4cWt4aDdTZUdCcnJYcEo0cFA1WGE3RWZSWkFFMlFPM3p5?=
 =?utf-8?B?dldGYURhb0xwYmhETEpTSXA2VmNoWXpPL0RnL24wdlNkY3lOMGV2M2JIU0p6?=
 =?utf-8?B?R1ZNMGpIekNLdnQzYUs5aHFKc3JVQ2tMMEp5M3RmVVJ0SGExRDlxM1BXMjQ5?=
 =?utf-8?B?NndlQXEwUTFPY3ErZlJqN2ZoandKVE9oM04vbnlYblQ0NWkxMkpvNXFoRDBN?=
 =?utf-8?B?Y0dKZHdIaDNxNVdCSGxvMEk2TUV0ZVBYUG8xVEpHT0hIVnZjU3JpeHNUdTlo?=
 =?utf-8?B?aFZQSDFRVnZkWWRUYlRwR2VWakZZSmZWeExaUDlXUk9TMFEzbXJQVm5kVGhq?=
 =?utf-8?B?dHRrS0VMWjR5ZGx5ZnBwN0VoUXZkU25CdnM1MFRLeE1PdklGTUNIa011Nlhk?=
 =?utf-8?B?SFhobGRvd2puZ2EzRlZKaXh4aURmQ043L1FJUE5uTFQxU29IbVMwbWhYcElM?=
 =?utf-8?B?VnI2YzFRKzBka3ZKNW53ZEJBdFRvd3lFTnY2VTVrQXBwdTlUaU15T1dWSXlB?=
 =?utf-8?B?OWdaTU1ZRG4vaWhFUVJHRWJCSmJpYXZtbDVlK0IyUnZZOTBOVGgyNFU3a0dS?=
 =?utf-8?B?Zld4aXdMRHZER2RGSFAwNU1HcG95RjRDZ2d6S1V1U1gwQlhZUHdsbDFFVUJP?=
 =?utf-8?B?ODJhWmF3d1U2SFpsVHFyZ0pMa284WGRXRHBGaFFMODRsSEdhTXNTcHlqbXZD?=
 =?utf-8?B?YVoraHB1OVVyMndYTDBTOWxsVWQ4Q3grejFmMjRYRFc4NTRUSFFvSFk3V2wr?=
 =?utf-8?B?YTNqSzdhcHJEeWNhdlRRZXJGdVhGYXFYaTNNdHdDWlJRYnVhMktHTlIrTzA0?=
 =?utf-8?B?YUxEbFo3dm1DTTdRaWNiRDJzZEJBVGljM1JxOEttalJEM2thQ0dyVjFqN0Fx?=
 =?utf-8?B?TGc1RjVIakJrYnhzNENoZ3VTY2lFcWpkM0t3RnllTlB5VzMvNDBZcGlQWGdX?=
 =?utf-8?B?NThLVER4NjJnbkgvdnc3Z2p0MUZkN3ExRDNwVFdka0QzaXEwdENmMUhIMkJS?=
 =?utf-8?B?VjRBRXdGczYrM2ZIZDdEa3BOZmRtYkhqc2UxK0sxNlRkbTFrTG5MZ2FDM09r?=
 =?utf-8?B?anNQWm91S3MwSWlwZ2JtVHpiWEtaNlNDb1ZzNjh2UlQwTjFxT0pCZ1FYSjQv?=
 =?utf-8?B?K3JDdEl4WlJ1eUxrQzJwSEtPU3Vjc3JMZVdkTEZ0YlNuSk1QWkkvbTRRVUhP?=
 =?utf-8?B?dzNOc095a0pleEdVMHVRZXR2WjRHazgrdExxdE9RT0UvaURZTUo5eks4dVE5?=
 =?utf-8?B?OUNneTZKa1l3eWVBY0s5VWlEOFhqQ1hZQUZRN0VIeFU4QU82WCtpY3Fnd2wr?=
 =?utf-8?B?a2cvMnFza2x6T0RuTW1xZHZ4bzFVV3lKZGF3RHdyWWtKVE9wb3JUQ2pCdzFx?=
 =?utf-8?B?RkdPSzN3SXl3ZjcxbTR5U1QzbjJLdTQ3ODdrbGJaTEpWUGp4WVZnTG5lZStz?=
 =?utf-8?B?S0pWektpQk43VkJhSHNOYndiV3QxaEFIUE5GUm1xbVZhVDdCSHc5dFRoYlBt?=
 =?utf-8?B?Y2hPeGxVNy8yc2NRbXpIWXRPKzRBQlJ5NEx0QWdoRnUzUGpkLzA5NElua01y?=
 =?utf-8?B?MXZmY1d5bS9ySzVxY1NZNE5kL1NQK24yWldDd0paeTlGdlBiRHlmNHlUcFBa?=
 =?utf-8?B?dVY4S2I0Unord1FVUW5CR3lhVVRXVjcvTmJTMEgzeTIrVkhjVUg2TDNkTkcr?=
 =?utf-8?B?OGI0UDI1YXN5UVdBK0ZMQjRHT0ZyZjNSM1dSUWdIMW80eG1BU0N4RWlSc3hm?=
 =?utf-8?B?VWtxTzE1TnlyaVNlYkJuTnlOOFVoYWtWRUNXZU5vbHRYT1U5WjdhVy9tUHI4?=
 =?utf-8?B?ZVFHNWFTR2laNGFnUHJUV2ZycmV0MEIzdXdLVmlBZGFqK1R3TGhjeGpVdlZj?=
 =?utf-8?B?cVEvWStZNmprK0s1MzE5L0hvc0FqcTNQdFNhZi9ESG1wZndndUVFdmJHbXY3?=
 =?utf-8?B?ckp4TnR1ME5jWUhzMUNoaVZSWVBLZVUyTE1oUTNkcUMwRmFKdXFDOFFaR0xY?=
 =?utf-8?B?MWttS3I1UThBV0tHT1pKVXdzcXlQVURJWUh4a1Noa0hDOVBKUVVGdzVjc3pZ?=
 =?utf-8?B?T0NDRFVaZWlCRGtQK0tGTGIva1FuVnQxYjU0WS9Wd3NTRXZ4dEhJK0UvRFBr?=
 =?utf-8?Q?ojaABo/1EqXcg2TfePgrBKjlm?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9cb21f25-a31a-4fd7-89c6-08dd5d21f59a
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2025 02:44:19.5206
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lluH+XpUQQkAcYLgwxinxsINwP8D3k5Bky5FJL/pgBUvgLsAJL20TWjpXHMD0hCfF0NL91ii3OlOwI9IIPlzTw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6448

Hi, James,

On 2/28/25 11:59, James Morse wrote:
> The code in internal.h was moved by a script. The script didn't know to
> change the header guard macros. Do that.

As for "The script ...", people may forget or don't know the context of 
the script in the future.

Is it better to merge this patch into patch #45 to avoid future confusion?

> Signed-off-by: James Morse <james.morse@arm.com>
> ---
> Changes since v6:
>   * This patch is new.
> ---
>   fs/resctrl/internal.h | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/fs/resctrl/internal.h b/fs/resctrl/internal.h
> index f1763a13715f..ec3863d18f68 100644
> --- a/fs/resctrl/internal.h
> +++ b/fs/resctrl/internal.h
> @@ -1,6 +1,6 @@
>   /* SPDX-License-Identifier: GPL-2.0 */
> -#ifndef _ASM_X86_RESCTRL_INTERNAL_H
> -#define _ASM_X86_RESCTRL_INTERNAL_H
> +#ifndef _FS_RESCTRL_INTERNAL_H
> +#define _FS_RESCTRL_INTERNAL_H
>   
>   #include <linux/resctrl.h>
>   #include <linux/sched.h>
> @@ -432,4 +432,4 @@ static inline int rdtgroup_pseudo_lock_create(struct rdtgroup *rdtgrp)
>   static inline void rdtgroup_pseudo_lock_remove(struct rdtgroup *rdtgrp) { }
>   #endif /* CONFIG_RESCTRL_FS_PSEUDO_LOCK */
>   
> -#endif /* _ASM_X86_RESCTRL_INTERNAL_H */
> +#endif /* _FS_RESCTRL_INTERNAL_H */

Thanks.

-Fenghua


