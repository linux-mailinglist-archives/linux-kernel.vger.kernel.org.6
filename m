Return-Path: <linux-kernel+bounces-550015-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D9AD1A559F7
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 23:41:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD5193B1C3D
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 22:41:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77BB227CB1E;
	Thu,  6 Mar 2025 22:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="TmOa5KS2"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2040.outbound.protection.outlook.com [40.107.220.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 269F21F4185
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 22:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741300879; cv=fail; b=IM4CRoZnBiVdVYeQThIXJ6Y3uKN3WTx9P4z4MqHgsLl55AxFO9IplQYPPTPFq5FHdfqZmAAJAJ7SrH2YngAku3v5rhBzSjp+MKLGD1EhmVSfBG71x3RXK/Bq2KCLIQO/ArjUG3+LDzJkhZ8IXgUurQM8TKFDGvPuS0J1xElRKtg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741300879; c=relaxed/simple;
	bh=FpobCDhSiGG/wljKDLdhgM5TbHsSqGAWwgR17ROIevc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=lbJdYJ6+kNRdYb8cWVmMIQ+RdRCXrF5cUasifJIfsoLHMHskPw991F+CSprx/q6m3/C3FlDZpyw9oBxf9SO8C9bTh16JMYddG7dPDWEOIiB9LIz2h68mY74kjl2gHFUBHF7S8EyyZz+n1Sc0qyOuPZ+s5IusNVf9LnMOAhTmDK8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=TmOa5KS2; arc=fail smtp.client-ip=40.107.220.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TsqiGU6ScS54CtDmBLn2oxEospWCQ5LQ8tgKh3nSM1vylwHg6utMRqw+37L/raZz98OgGnt8kqk1Hbkd/CiBi3Cqa5HFnBrAjy91aJZQJ5g9NE4I1CFz+2m2HuiHRWljjUxmUZZz1DKupW5aabblIkq9/9brcqJ7IusOqiktY9oWqwK1ThmOqrIJ6ozaqZ/QsoXFX6yPj2kPCWSGS3euhBci9TeuxmadWYkwb43eE2yTYBQiNzsFVEdbo3c1bKlY2/RFzXMqn/Ld/zoT5nAclN0VKxowZhAGdfIkd8r2qTLRjRLALBmYFgjnnI55Ce7r+KwDJQOvIKcIzMefyGVe8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FpobCDhSiGG/wljKDLdhgM5TbHsSqGAWwgR17ROIevc=;
 b=VapcG3zXRsSvAOrLKcEgRx9d/3NIPoeiRJNSzwgEGrVZkiFozEgnXfRKW+hVHSswGXIHu3kf5Qqla8jlaWVVz68SfcTy0IREwO40jURTO7M7gZ4FiSZFVmm70P9Ce+vF67Qd0hYkUwIYb+m93P4TSFG5PwnK5Uv8ur+J5YCE4i009aNBPBClUK0IqnnZtqUSWC3V854EXLXqktV9Rb/ifNBcNHM0phQ9QxKGj+lSKXQUFDWPxXKVECLhVXM3AHUYU7NGw2r7u4D5oSL71ybBSvQnddWXxzpIvN8/hg4Py2S+w/Q6No0qKDXEsqh6zulcd1lDScb/RpCBKJULv5Vhcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FpobCDhSiGG/wljKDLdhgM5TbHsSqGAWwgR17ROIevc=;
 b=TmOa5KS2XCLFWG4y/F+fqU/7X32DVrQ0Cqgmc1Q37gtuW9dEDyLpMN3cfpuz/0L14dBx7OsjwoigcSOGlPITVXBFFNhU0iPAjvo3ImZ7ob8DXaeEMZCZqCxStPrhN2VIClXGlFBDAboC3U4Lktr65XP+zuQvCy6nKyI1aLqAZOwGyXEAG0DaVs1geUyB7B3EBwjYsDSpnwH+efNQXFW17iUmDwEVEYOEKz4DakeV2STz1KEElbRRjP9nJl7LI/R/m0vqdcQ5pabLDSVqaWTljxPw4QbGb6VxdoFq8hwQNUKZvsCpOwcXu0WZN93BVAgHv9xEsPJkW7eROsdp/QcbWg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB2667.namprd12.prod.outlook.com (2603:10b6:5:42::28) by
 CY8PR12MB7564.namprd12.prod.outlook.com (2603:10b6:930:97::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8511.16; Thu, 6 Mar 2025 22:41:15 +0000
Received: from DM6PR12MB2667.namprd12.prod.outlook.com
 ([fe80::bd88:b883:813d:54a2]) by DM6PR12MB2667.namprd12.prod.outlook.com
 ([fe80::bd88:b883:813d:54a2%5]) with mapi id 15.20.8511.017; Thu, 6 Mar 2025
 22:41:15 +0000
Message-ID: <4d5f7cb6-03f7-4beb-a8cf-58bd4504b268@nvidia.com>
Date: Thu, 6 Mar 2025 14:41:13 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 38/49] x86/resctrl: Remove a newline to avoid confusing
 the code move script
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
 <20250228195913.24895-39-james.morse@arm.com>
Content-Language: en-US
From: Fenghua Yu <fenghuay@nvidia.com>
In-Reply-To: <20250228195913.24895-39-james.morse@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0101.namprd05.prod.outlook.com
 (2603:10b6:a03:334::16) To DM6PR12MB2667.namprd12.prod.outlook.com
 (2603:10b6:5:42::28)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB2667:EE_|CY8PR12MB7564:EE_
X-MS-Office365-Filtering-Correlation-Id: 76d58dc8-cb1a-47d9-8d15-08dd5d0000a5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MWVaV0NtdnZlU09RMGdHV0dGN3pCaS9nS3E3cXh2Y3FMODF2L0JtcE8rekk4?=
 =?utf-8?B?MmI2ZzhPUzRHTExOMWFaTTYvZk4yenJwdjd1VUYvSmtFcC9uRlNRL2xDTWdS?=
 =?utf-8?B?YWJ4R256NjBXSG4rSDF2TytYZ2hnTXBlUmNBcDM1Vy80MUE1WldEYTBIT3cw?=
 =?utf-8?B?MVBzU0VpZHU2d01BbXJremtVWEIySHNHb0p1SC9VWTJyTTNubjhiTEVINXFR?=
 =?utf-8?B?TmNlNDkxdG1oMlhVSkJueld0dHJ4Wk4yWVR3Vm1ZWjlIdnJqOHVDWm8rYWlo?=
 =?utf-8?B?MG9KWkdYejRsandXZFdHU0l2QnFZaEhXMzAzdmlZRDF3S0dYRmhWZ0o5eFY5?=
 =?utf-8?B?Ym1JMjJocDFOMk1XbkxSK3p6UWlscytwWWNIeXhRaEllS2R0TCs0S2tQT1Vl?=
 =?utf-8?B?UGVuTWU0bkc1d0U1TXc2RFFqMENOMit6SXJ5Qlp3ZERCU29BanRndGVjdGNy?=
 =?utf-8?B?SlNkZGxmZmtuYkRkNjRhNTN3MTJDWlF0YkdGdUl5NVYrMkxTMDhyU1lWZSsv?=
 =?utf-8?B?NUZaMkxTZUNpemJRRURKMk9BMXlGdWc4MldJb1VkNFlRejZ1NDJRdmYrQng0?=
 =?utf-8?B?VDhkQVZvRytLQTg3bTYzUy83WXdESHN1ekUvdldSeHFZUU1vQVZBT3dlMW9X?=
 =?utf-8?B?RXVPTnVha3l3ZGc1bm41YkVId3RZRmdHbkhjRDcyeVZGTkRrczIzZnpLNjJV?=
 =?utf-8?B?cDZmZXYvc3dtRFRydDRLSXFwQkdmRGNraXMwQ2NFSG9oY1FhV2FpM2JwYnE1?=
 =?utf-8?B?aUJwTnplUHhodkduZU1qYjl5MDJDTCtZem5obDl0MGpkam4rMHdNUVRmRGJR?=
 =?utf-8?B?eTFkRFJPMStxZXVENWNIZTRNNiszNTJoUlRqRk1PUTNabFRFM3o3L1Z3bjRt?=
 =?utf-8?B?K3JNTHd3YjFaTVVoOEVtQk5HSm9ENEJ0Zm1keVh1d3EzNDNKWXNJbDVqVHg2?=
 =?utf-8?B?cTlBVlRiZEVzWDZxM21iRHhLWXM5bVRmdXpWWjRVc1kybkJWZDNValFKek90?=
 =?utf-8?B?dmMyUHh2aElVOURDNG1ydTc3ZnFpZUt6SEtKNkcyVEsxVlhVbGFJMElqRGlU?=
 =?utf-8?B?MmNqT0hYdnV5bVZQano1Y044d3dwdXp3WCsvK3Q4MEdhSFRnYW5JcnlaZGlC?=
 =?utf-8?B?Z1VyK2Jmek9nWEozc0Z4MDBWQ2VQTkVnTkU5NFEycFB2cVh1cjBRL0RGUjVU?=
 =?utf-8?B?bEhJaFhBSHlTNjR3NUdBdlRSeG1mT2paRExVbHRkbHBVYWN6RnFoNHd3L2ZX?=
 =?utf-8?B?Q1J0K3dMZmY3R3dEREI4U1R2akZEK3ZwWXlySGxWNTV0RkdhZ01WWkdacGYz?=
 =?utf-8?B?SnVkS3VpVnFuVlVXYnpUSlJmWVI5MExIbkZ5K1FvZnptWlJEY2I4cnJGdlcw?=
 =?utf-8?B?MVNZSTdWWGdjMDN1S3FNV3FZOWd6cEhUdzlvZkpNQVNhdmlIc3NTNFk3RjVi?=
 =?utf-8?B?N3RjYzY2VG1ZNGJSWWlYMDJXN1B4T2M0SFd6RjREVEdNSmpGOVRoKytrUHlh?=
 =?utf-8?B?UUdra2xKMXdTK1YwQk1pRDJPVkxYUG4vTEVaUjcrUWlmL1k1eG1kTzBDaGQz?=
 =?utf-8?B?cDAzUFFManNUd2M3MUhHNitmSU1jVkprSTgwZ3dSeGFsTjFjVDhUYmxKTVVw?=
 =?utf-8?B?YU9BZXd3aGNyNzZDcWRuTVhlQWtXRkFQRGd1bWQxOEdCd01GRlIwQ21jMS9h?=
 =?utf-8?B?ZmVKZWt0VkRKdDdSYTRla2t5NlhHZnM4T2VDSzJMeWRINnFyVkxOYmltdlJM?=
 =?utf-8?B?MUFRektPNFdldHB0ZXRzZmdKbTNRUmFUa21yNmNQK1N0Umh5RzBFL2xQQUs0?=
 =?utf-8?B?cWM3Uk14SVF4SnZReUpIRXh0VjdTOTFMbFFhWTVXT0tzakdxRmhZbHhxRENR?=
 =?utf-8?Q?y+84T2OyiQQ/Y?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB2667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OU94Nm5Id0phdndGRzF0WnE5d3hoc1dZK0lDYk9pbnJpRXJyMXNqemVFNDlz?=
 =?utf-8?B?d29aVFNqK2hBRnpGN0x4SmNHWURyU3I3SDBQUkROTWF4K042cXE0em1QWnlZ?=
 =?utf-8?B?eTJOLzhKVW8wYnRNN0dDeVRHR2JueGdhei9jRHVNNGNicFRtNUQ4OHdRR3pM?=
 =?utf-8?B?M2llQi9GRlNrTFQra0NiMFRLbFhFR0oyLzBJaUZIWHV2V2ZWNlpzUlAvWThM?=
 =?utf-8?B?U0lPdEp3UlZNaThIL3BRNGF6NWN3Tk4wQ3RjQkR6TThyVnZwc21lZFhSZFpO?=
 =?utf-8?B?dHlZT1lGaVp1K0FyNlZjYitDK3kzdG42T1o2ZmlyQlA3VVRJOEFoTW1SbWhj?=
 =?utf-8?B?RjJqZDlONmlaNzVBcW5YRlFTeWtkdlpaOURTc2JnWExlb0h2dnN5NytqTHA5?=
 =?utf-8?B?VXdXbmc0V0txU3RYdXl3dkdUTjZjQjMxbjFDbGJqSEJnNE4zVUxMSFBYWVFW?=
 =?utf-8?B?WThjVFpKbmdkUk81SW9HY0duWk93Vnl0Tlplb0FGSzZqdmQwYU1kcW1KbXA3?=
 =?utf-8?B?UmRwVzFaaE1KNGVIQmlOcDhxbUVXbEp1NE0zdFYyVlpXN3hnWG9rRHo5WDhC?=
 =?utf-8?B?alc0OUpZSW9DL1hybXpyMTFvVkF0cDJSVE8rNzQzVk03UTdIOEVoalMvSFFs?=
 =?utf-8?B?K09MODdxUzVHVnJSdFYrMUNkN2tCNkFETmJkaVI5cXdzY04vRkVSY3JYR0ln?=
 =?utf-8?B?VGpsYmk0NVdXMVMvMWhWeFlBeHRlRS9OcGs5Ly9vU0dqaEZoNlB4cUtGVDY2?=
 =?utf-8?B?cEZVSlhTbDJ0K0xtSHVYMUdXTWo4U3ZjODNuRmE1V3N4Vkc2T25hZzNibjRC?=
 =?utf-8?B?L2J0WURYYUprdXFqTTJiZlpmNVJpQ05wTVd5T3B3VnRnT2FsUi9YRlFDSWZo?=
 =?utf-8?B?WEs3NGh5aU82K1dNdGF4NGo3WEVCK3FjNkpER1F2SXlEalA3QzYzby9VOHhB?=
 =?utf-8?B?WlBXUFNLNW5mc1dtN3EvenBqSWtQSnpmb3hVakdqODZ4ZUFEdGlMZ2toN29C?=
 =?utf-8?B?MEdOaHZ2cDNiNG9SSVhlY2gySThEZTRsVkRYM08zdFA0M2IzWWtSa2Y3SzNB?=
 =?utf-8?B?WkppT2FYUEtxTUpodHcyQk1QVU41QWVqeWhwUC8xdjFPL3FtTzRlTkd6M0Zs?=
 =?utf-8?B?TENqRGdtRTFzSHQzdFVidnluT25DOHdnTFJVdjNJODdVUGJLZGxvNnRCUFYr?=
 =?utf-8?B?bWdZak9ZTUtCaEFBNGdUejRJQmNuMjRwblRZZmZDTk5zU1dBYUwyZE9SQzFu?=
 =?utf-8?B?RWMxSFBsM2hmeGRTTUhtOEdHb2FkVmErdVRidlNKV25JeUQ1VXNNb3g5L2JQ?=
 =?utf-8?B?dnA3bldWT1NuV1AwWVJxU1FUelNVOTN1RHg1N2RFWm5MUEYrdjc2d2dUZEEv?=
 =?utf-8?B?NGN3V2xnMTJ3TFVCY2pONkxFa2VHN3JiTCtJWlVmUTVRYXNCS1VmTms3bWkr?=
 =?utf-8?B?dzY4NFA5SVEycXI0ZUI4bFM5MmVrOUpieEFJWnF2TE5qc2Z6U0N3SzNmZXl5?=
 =?utf-8?B?cGJZOEhNOXRzVlluZ014R3BXMjM2Z0hPdG5rM3NBMkNCOE5CZlUxbi81UFNQ?=
 =?utf-8?B?YVU5alptZzhuZ0pCYWhzRHYvRHVqbE5peTFrNk9WVzVHV3NrcUJqMVNiMDB4?=
 =?utf-8?B?T0FqS3FrdGo5K1owMFREdnpYOU5GdnhJMDErUzBqZEg4MmlDeUQvS28zcnVL?=
 =?utf-8?B?dCtENUtwRjc5alNVOWwvYXNwd2lKMFhiQm92MkUvREg1RFBsUktqT3J6bGdE?=
 =?utf-8?B?aERtV3A5Q1d5VGltSXp6UENCNXF0MXZiaWh0eTJjaGc0UjZuc20zODZEZjZq?=
 =?utf-8?B?OUhHd0VGSFp4UzVaMEFvR3VnVHlGMXNhOXMvaEdDQzlmS0JBdHU0RUtvR3FH?=
 =?utf-8?B?OUwxZ29ZNkFuOFNWWENGQzZLZ0NVZ2hKRTJBL3JmWmVxSFp2eElTWnhLWjBq?=
 =?utf-8?B?WXNTbzlHdHN6RnU3a09zMytkMVUxRXNBekJzWkNKWHZSMDBJRWdGWDEzL2I0?=
 =?utf-8?B?bnZSSHF5R2RmZ3lSaDk1cmJER0ordGRsUUNYYUZ0OEVDeWxzU3d3L3FYZ3R3?=
 =?utf-8?B?MW1Id1VQc2FQdVRJamhMVnhnSmZNL0lYWitwL3RoeGM3ZmFNd2ZMQ1Evd0tQ?=
 =?utf-8?Q?BeZE7gnXwJyhXScPsMDlwPg/F?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 76d58dc8-cb1a-47d9-8d15-08dd5d0000a5
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2025 22:41:15.0615
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aWuBJOACneCBtu7lWAzqw0UXjWIJ10P6Bb4fiurYnzVh7PUO+0c0Wg2y0GAfYr5lhmAI21MHiXBSLl4/AGoR8w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7564


On 2/28/25 11:59, James Morse wrote:
> The resctrl filesystem code will shortly be moved to /fs/. This involves
> splitting all the existing files, with some functions remaining under
> arch/x86, and others moving to fs/resctrl.
>
> To make this reproducible, a python script does the heavy lif^W
> copy-and-paste. This involves some clunky parsing of C code.
>
> The parser gets confused by the newline after this #ifdef.
> Just remove it.
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

