Return-Path: <linux-kernel+bounces-550003-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AA58A559C9
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 23:31:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 482DD3B1ED7
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 22:31:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DE6A27932F;
	Thu,  6 Mar 2025 22:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="FVy7ZUeo"
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2048.outbound.protection.outlook.com [40.107.102.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 129811311AC
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 22:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741300266; cv=fail; b=Ca+27p0QnixqbEB1GQKzDpVNWNV6lFr7QohDhHvAtQFmDGUlMfaNb0V7HtZWshuWAFMfOt7zuF/VLP1DG7JfChUuEagMwLSyU2lkbhuk/LUHvuQQSXZPgB2f9OCuAGIKiamjNk3c2Jt4WJcJj9iwIYiuXc5UVYTVW1C9dmW+UQA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741300266; c=relaxed/simple;
	bh=sqccrVi8Wzxo9r6qrd65XFhCa1dVRwwTwNVaNu6Noeo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=kSFUp2Ln8gs7jc6sxhmFGmMZiVHmsvqqhZJ0JrXFTWgx6+tdqagy3hnYxE3B6T/ebsjX03CUZDlQEHr4P2Efj37Hxxbr91OGpjU82xlEifmHPFGQZES6dUQApSSH/uSkj5LpbpWrlgueKuKm8iSs9c8KY0gSTv+5GmInMfI39Cw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=FVy7ZUeo; arc=fail smtp.client-ip=40.107.102.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QjI+udR96e5ZJF1fM6043iCFGrz+HEB/IOoSx4FOYVGqRHQgiJm33n1cJxp9NXFNbDpX2DrTWq5E39vHBPK9zHcOHjTbOvUz7aGkOKoivvmO7qrjxzDrH0kh42KR+rVxV+P2pnlFW65sW2Ke0x0RwGNI3nadf93yjLQEiJjDb923RNJKVdwArs4QMPoyKQP+g1xz03I3xQI4ALhYI5qLGDQ72lO5/pV2k2mOuMOLtm6Z2iyZjQw5NmyXKq6l1MGNFuSZkChsv8lBK0dQ7ddr4Lel2KDrak8AtpSZxVPhvEU1ww7n0JSfOqtSR7RZQh5AZoQ/YWXV8yoDbSNguLW2Fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sqccrVi8Wzxo9r6qrd65XFhCa1dVRwwTwNVaNu6Noeo=;
 b=xAFLuLQJYkmJkDsbWX7BmKzWToYPCZvUx4IBB3UX0bdBZdVCnBXtQrN5AfrO9NwCDu7Kihv2ZYTGl+qiASVsJjcN5dJjgLD7okRM1nWkIjkbjqe6vM9371zq5HsMMEENde9CaI/jX3DN7bzj2q20o5qBnYNXUZUQ9LyOwY6IBem/KFPHI0vLOMbr1YKYqrm4hHKvz4A2+48B+yF38FLEy2AgBSBWeKsIljC/J/s0Ly5IFJEhszlPbZiFaIBIogN0fc4df6OoIvqIi66EmnU58xBXc30tGu1m7oljgFygvKjKMFWo/ddiPP4czohic0s1OALI9eEksqhoy7PqreEjKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sqccrVi8Wzxo9r6qrd65XFhCa1dVRwwTwNVaNu6Noeo=;
 b=FVy7ZUeoWcUYny0G76DoUOAPuOOmoYr7G6YE0GkRYepwMZaRMhX9shSLjBs0Loixpp1hJYN9SxbFlbK7jY1DG1ez5S+h/Cik4KS9O0nP9HDd3rV9jQjn2wJBL2fssqyOIJBU1Fspn2Y+soJ99B5bX453085syBcAhRR+wxsyKF4qGDnR7hdC9eSGAlyZFNFc3go3rb8z7rcNdil7jPylUg2KFP8LY8aYZq6A/eyPOPtTKVZWuXVm46rK285LojKQEiA9BPJ64RlxTRdo4ARxETzXReubFBjO9seP+IbOlybIe/9BTKIwZywU9uo1Ln3u9DYf1GsS90iZ8a1so1fSjw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB2667.namprd12.prod.outlook.com (2603:10b6:5:42::28) by
 SJ0PR12MB7474.namprd12.prod.outlook.com (2603:10b6:a03:48d::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8511.19; Thu, 6 Mar 2025 22:31:00 +0000
Received: from DM6PR12MB2667.namprd12.prod.outlook.com
 ([fe80::bd88:b883:813d:54a2]) by DM6PR12MB2667.namprd12.prod.outlook.com
 ([fe80::bd88:b883:813d:54a2%5]) with mapi id 15.20.8511.017; Thu, 6 Mar 2025
 22:30:59 +0000
Message-ID: <d94c3def-f995-4282-bb1e-5638f93b07fd@nvidia.com>
Date: Thu, 6 Mar 2025 14:30:57 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 34/49] x86/resctrl: Drop __init/__exit on assorted
 symbols
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
 <20250228195913.24895-35-james.morse@arm.com>
Content-Language: en-US
From: Fenghua Yu <fenghuay@nvidia.com>
In-Reply-To: <20250228195913.24895-35-james.morse@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY3PR03CA0012.namprd03.prod.outlook.com
 (2603:10b6:a03:39a::17) To DM6PR12MB2667.namprd12.prod.outlook.com
 (2603:10b6:5:42::28)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB2667:EE_|SJ0PR12MB7474:EE_
X-MS-Office365-Filtering-Correlation-Id: d0420819-e376-4d18-d3ed-08dd5cfe91e8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Smc4M0pNYXltUGtWZTJHVjl4bTRuV0kzNXJKWEV4c2tIb2VyL1BVT2xKZlpT?=
 =?utf-8?B?RGozeVpoOC90TnoxeWcyYXNMRFZTS1BkcXgwMnJkTERpTEE3SGN0L04wcUF2?=
 =?utf-8?B?c05EbnJibVplU1RDNFRHajd2T3F4cDJZczZOenhFMmtHRlo2elJ1dGtILy9N?=
 =?utf-8?B?TVFUUFBLcDcxdEdSZG82STd0RjlHQkd1STJZZVFtY3J3WkV3MUNVSDNVRDBq?=
 =?utf-8?B?UkpHT0toTDJTMC9TaEhTK2xVcGtIbVVMYWJ5RWJXWjY2anBZd3dZVCtiNDZ4?=
 =?utf-8?B?ZHJDQkYzeTNEWEdjTTNaU0xIblBSMkVmU0NnS2d1TVRSWVAvcFZnY016UVc3?=
 =?utf-8?B?SXNKZVp4NVhtc0EyYnNjRzVWVWFEN1A2aEJLRldBWFcwaWFiMmlSL1lWNnZ0?=
 =?utf-8?B?b001akNjWjdGNm8vTGFDNGwxaFdTVFg2OUpVVld5Nlh2S016bnVqdUdQUW9r?=
 =?utf-8?B?THU4V3kzTS9Qbm9DUjl0UFNDb29mNFFHS211dGxJQzlnRjkzbVY1OExVQnpa?=
 =?utf-8?B?OEgyRHU0RjNaUjdJUE52SjFkWjVoWUtCK01peWwrWkJkdDgraWRKZnpGUVpp?=
 =?utf-8?B?dFo4SmxCRml0YjNKSFZFNHhUUFY4aXc2bll3anh1T2tVSWFvaDBqM2pWMksw?=
 =?utf-8?B?UUtYUGI1SENuUkdmMTBRazhLTFo2dWFlTTRhYlNtMWQ1bUt3VjNYRHo0OUZK?=
 =?utf-8?B?aTRGT2dzRGJ2WUFMa2NEM0V6M1RqZkxHR0xEMC9IQ213RHVEMU5NaDF6ZDlE?=
 =?utf-8?B?OTZlQUlxUFIzZmhaNWtMUDYrN0VlTDI0ZnovSEg5WWU4bWFvWTNiTUV1OHRS?=
 =?utf-8?B?ZGlDL0t6b0xNUHg1N2lxOFhoZHlVNStrZzlvcjFuWDhMZUJ4TlUxYy9acldZ?=
 =?utf-8?B?Y2pPRktPazBFdE9Cc2dZek9vUFZsVGxnU2lnK01XaDBnQ2hKdmdXOVVUekZ2?=
 =?utf-8?B?K3Y1c3VVWElwaDQ3R1pQNU5Zd3RxL1cwQW9RUzhhME13SHlBcVJLclN2eG1a?=
 =?utf-8?B?ZjlldjR0dWgrem9JbjM2eVYvSFhxTXJVY29tTDFjVHRvV0NYMmxPRkZWMEtD?=
 =?utf-8?B?ekgyS2JKWjJ0Q0xJS3BtRFRkMDZObWJjNDdtVzJ0d0t1VE5zRlAzL1RiQ2xG?=
 =?utf-8?B?cWljRlNjbzV6ZUlSZlc2ZDdodU5KMHBvQk00WG5uWHEyYlk1MkxjWWlOTTlL?=
 =?utf-8?B?aDhIZmlRODdqOE5SbUd6S3NZREhmV0pkZFlxVFovSGZiUUFVNnNJb0w5cm05?=
 =?utf-8?B?ZkJGQ0Z0aVFsNDJtbzQvVEk3OVk1QWZoL0pEOWMyVy92RUdIbDJRRjN2RWtX?=
 =?utf-8?B?UkVmOHVoMk9HT2RiYU0yWnFQWGpzWW8rMk1oaE9UZGtaYU5SRkwyOTRyTXpa?=
 =?utf-8?B?eWpmK2JBL3kxUWhUSkh4Q1EwUC9TME5pUGxROUppbUM1VmhORnA0RFNTTllN?=
 =?utf-8?B?OExtSDVsd1QzREV6d3lWcHNjdjJpM212aWd2Wmh3VEdIdWMramx0MDZIMXFk?=
 =?utf-8?B?b0lPT242dVdjQndLYkw5ZlMzZVRGdkQwMlVQRTZpNVNvUUs1QndoZXhrcU9y?=
 =?utf-8?B?NzRWR2p1UU40SzhxZnRCYUpIZkt1Q3YvQVRaMkZSci8vRllObjVRSGphaHZ5?=
 =?utf-8?B?M2tEWk5GYXpudXM0VkR1c1Rnc2RPT0laQVpCUEt4UEtrY0h2RkpvN2RKMjNp?=
 =?utf-8?B?T05IUktONU95RTVzT2xGY0VuRFRXREF0eHFUQlpiWE5mOVk2MUp3K3dLU05N?=
 =?utf-8?B?dVV3WGlaMHJhSXlZOERBUW9wcEtzTGhBcURZdFA4Z0M3eVFUdnlBZW1Ud0Q2?=
 =?utf-8?B?ZzRXYlZNNUYrUGlpSVRRUUVaQjFpS3dHWVZIeTY5N0xieFA3SU5yWWluTjNM?=
 =?utf-8?Q?qgdtBPgX36MzA?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB2667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?K2hDbkx6UTA3eVY3czhodFkveTlBK3pjVXI2UGxpNjJCc0Y4ZHAzQUYyaC9w?=
 =?utf-8?B?VFgvSVJGZWIxMlZvblVkYmduVnVmNWRmNGR4RERjcDZCMExIZ2RLalJVM01v?=
 =?utf-8?B?T0QzellFTzI5bktuaE1tSTNETURzVWVUdDc1QzQwUnBJNDJWSTVJcnFyRGVP?=
 =?utf-8?B?cFZYMXRkRXFPM1kzVVVJSTZDRm1uMU9TNVdGQityLzlLZWowVWFPUDBxck15?=
 =?utf-8?B?eWc1UXozUFQxV3FtS3FqTmZkSGx6b0QxZ0FDUjgxZU4ra2RjdklRTmgrOXVW?=
 =?utf-8?B?TGo2QXo5Y2NicXQvcnN1WlY3VXg1dnEzcTNSSXNoNVBUeU1uanZidDdNNmdt?=
 =?utf-8?B?d0hwdWxhSG1BUHN3bTQ4TE9SQTRTYlJzVlRtdk1HUllhYzhVNlBYT3JYdFNz?=
 =?utf-8?B?cHBITnFUeGhyQkk3anh2WWpBbG9lK0Q0aHVYODRwTWtUcERCRThzQnJvTi9F?=
 =?utf-8?B?KzlEODUybWlZRG5sMzhRYXVDeVUranlMWUJWTjROV3R4WXNicTd6WTExSXJq?=
 =?utf-8?B?MkR2elZwb3o3eWdLZ0NkY2kybmczamEzaFpJVUlTczJ2WFA1N0ZObVAyRDR6?=
 =?utf-8?B?N3dNSEUyYkZDVStkUlNLSEZ3MUcrQ29UeGdtK293MFlvQnZZWktkZ3FCSXVa?=
 =?utf-8?B?WklqSlhxMjVYY3l3cWI2ejNLTXM5bmJkQ051K3RnZS92bVNOeEhpaGE5Nkt2?=
 =?utf-8?B?RE9IakZ4Wkxod3Z5aGljSlZFUFl4Tm9NNnVJWi93RjdFdVB3ZDJqWWJIelpX?=
 =?utf-8?B?dUlodWN5TktWdy9rMm5wV0V0UjIwL1pTR1Z1aXdTY2QzQXkySzNzVURSUFdz?=
 =?utf-8?B?cDJBZ2thT3lIaCtzdG9kQUR1ekczenBla1lvNE5lK2N6NXJwZ09xY1FqaDA2?=
 =?utf-8?B?L1ErSzJwYXF4Y2ZGWEo0Yllid3BpZTd1bTNvbmFqRVRyMVJ1U0FPK1pYUHph?=
 =?utf-8?B?cXRhOXh1VUE2SXlaajlZb2dJOTdvZG1xZUI4ZTJscjdmdk9nekd4dzBPU1Ra?=
 =?utf-8?B?aG5TQUU2Q2xUSHcwR21SZU9Od1M5eUhOa1VRcWRBeXZkL01wc0xVQXUycUJ3?=
 =?utf-8?B?eWdoUHVPTU45T3NLY2p2b2RqcWROQnBFb0w3ZzhIVXVJSmVsZmNtMVh5UTBX?=
 =?utf-8?B?Skc1UHlOZUdyMmZzYjFjRHBHdVhIeUlNK2pUcllYT1k1OXkwazE3eUhieXRD?=
 =?utf-8?B?ci85N2ZodkRGUE1wV2Z5ZG1rVTFvWXlpd3hxVXY2dFF3NGJBN04zalZCV0JC?=
 =?utf-8?B?bEdsaVBOalVIQXVaTFNBMGo5MVdqc0RKYkR3WGhrZUQyNEhLNVpNWDJUWWFG?=
 =?utf-8?B?czRPN1g1K0Q2R1hvS1BJaktMelQzNFFUR1kzMVE1MzkxYVhUZmZySUdPMjlC?=
 =?utf-8?B?YTNaekRpdXNYSk95ZWZDWDZtaHVHMEVPSmIybEZRTVMwbnhnd0hWWFdoVlZB?=
 =?utf-8?B?NXBrS3ZOWW1JUHlwRE1rU25xZGZFTXlWNUpDWmdva1ZUQWV4MFNYN3NxVGZK?=
 =?utf-8?B?YU9kdW5xV3M2WWdKNGNvN3FjMXlrUHVpTFR4NVUvY0FRV2Z0QmhzZ212SkNP?=
 =?utf-8?B?Zy9HbE44Z0Nwd0YrdVhyN050bkQrOHN3ZWRxK1cxdkZpVU1tbXQ5N2ZBRCsx?=
 =?utf-8?B?dFNDaEd3Qlk3T2JOOXRWYWk4M1phQTkrcWhoTEVnUE5mOWphbWxPbHZ5b1gv?=
 =?utf-8?B?UVZualJnTGEyZkVweWVsNHoyaXI5dWE1MDltbnh5V0o5UEZWRExkNVpnMFAx?=
 =?utf-8?B?ZkI4cDJNQ0pXbEcwOHoyeDdVRngwR2ZmMmZyVGRRM2k1VjlqWUkwK0xVRDU0?=
 =?utf-8?B?UmRISHRRdDZzeHN4d0hPTkZ1TldHSWpUeXlQbXovaTljdnNiWElERkMreE5C?=
 =?utf-8?B?bzgyaG1WZCtRREVWOUN4VDZldGo4R1pOUng5MWRLeGhUS1FkRW1RNlEzMExO?=
 =?utf-8?B?M2VnM25IYkdjbG5DN29Fc1FKOHl5RjYwR2Vicm45bzRLUlB6QjYrbnd5Smgv?=
 =?utf-8?B?Q2FzdUNHdDFDZjQwTnRQdHpwNWZXS3d6VERic3Q2SElha0w2UXZMVDhCRUFV?=
 =?utf-8?B?RHE4dnlGTFROdmozVTUwNTMrdUN0bFlJeDluSEpGUEhIM055dFJUZzJxMDhC?=
 =?utf-8?Q?ENq4u6UfVa/9hM4enSc3cZ4Vo?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d0420819-e376-4d18-d3ed-08dd5cfe91e8
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2025 22:30:59.8362
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: o4YR6Vg0Zz6DeFo2GqKmZqkJgLPiwGDFw7F/ZCGVO+AROaSCm+FeevyVepP+8HDPSa+mMJrwfkEnyJG+LCU4dA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB7474


On 2/28/25 11:58, James Morse wrote:
> Because ARM's MPAM controls are probed using MMIO, resctrl can't be
> initialised until enough CPUs are online to have determined the
> system-wide supported num_closid. Arm64 also supports 'late onlined
> secondaries', where only a subset of CPUs are online during boot.
>
> These two combine to mean the MPAM driver may not be able to initialise
> resctrl until user-space has brought 'enough' CPUs online.
>
> To allow MPAM to initialise resctrl after __init text has been free'd,
> remove all the __init markings from resctrl.
>
> The existing __exit markings cause these functions to be removed by the
> linker as it has never been possible to build resctrl as a module. MPAM
> has an error interrupt which causes the driver to reset and disable
> itself. Remove the __exit markings to allow the MPAM driver to tear down
> resctrl when an error occurs.
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

