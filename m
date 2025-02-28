Return-Path: <linux-kernel+bounces-539389-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B5B4BA4A39F
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 21:11:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BEE56881E13
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 20:11:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7968125D915;
	Fri, 28 Feb 2025 20:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="wSywJ6Nd"
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2088.outbound.protection.outlook.com [40.107.100.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACF041F4CA6
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 20:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740773222; cv=fail; b=ehoh0GbM372ck0BSf2PwVyiDZ11daMOvLSkf9r1WtUqsRGkkwH1gdnGTOhODUB7SLpT7b32l1xTjfP61fvMPJBF7y64foXjC8P3mvrgoO8d6IJWed6HGKTPiSzvig9iVQe+uKTAHkqAp1GdMs67uAIxMdzlmT68g1XXTgobGh5U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740773222; c=relaxed/simple;
	bh=R0WCpuQTxHsD4tdFQnv/o62tOaZkRlzlUis/1mzSyo0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=sjyllGcMpn7P27RTHS42SymhEOveiduJvHIHQYm7328aA4aSuqqotKlkPU80uPsMyL7sjO1TOmwoHRf5u5kacwOsKDT2RCV1TYpj4ZlAU8n66SLBi2UOOw1T6OpYo4Ea/dKx23a0xMzOriTmXXBziOuMMWirjxa96jPUacNYR4Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=wSywJ6Nd; arc=fail smtp.client-ip=40.107.100.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cs+vq5QBaX+g5MIlL+sqV0xAf1ClqGc8vlwpOVwdUh5xexAZUcePb8qFM9wb/f3RT8E2PpIL/wgY2vWAvXhwVAwyWJvkxwYBE8WYUHOIUbSvEBUWLLl4hBNMczDZ4BGFpMiHpP1UUglOPViB5XR7js7xqDT37yecbOsVnuTpUFrdwGAGBn62861pEO6hR38d2GtFMNt5faBUZCpz1N9w+INZTT0cSEAX5qXSxjpyrKcvsNjmOMrhobgsVf2DZ5pJpfpisGjikvETP/TURvBbZz9vaKtH09FFohgNT+A77cyXTfzuwQtiaTvgYqTXHi8iGSPLARSNk1S7nJazNtqHrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HimfKrm7MnQkzYHxj/CJKqZQRvOhOlIgmPKM0I9TV8Y=;
 b=XG33BzCb28VvBVH6nllV+wZCixd7p0XUfnLt7hvoMpJLWJJSk4K0M4neQnKxELggIIzvPKPNszWhuvVwdTR+Hc+RCyN0jAYh1kChtITTXWjG58qxfZZs6kT3QgUaD+peOTZZlnqoL9ISoRGpfhAZxFhmWtT8LhTEzbEnK9Lrh+UrWEB2ZWlUmFKOa1t3qADOHGCF26t0jk7zX0lkSYaUkV8684SGABFb2yVeeXs8H8EvHxw98nci5V4H4OQuudFHxY0czMsXniLze1KA8hxt+BUI7j3ncN18/C+3SsxrnPrb9BXL9sR0gpW9lDaB1cYExgPMjL2fW6hfoFIBMlp4tg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HimfKrm7MnQkzYHxj/CJKqZQRvOhOlIgmPKM0I9TV8Y=;
 b=wSywJ6NdOgM2Fgsg7yh/SbCtX1jGfeC2XFg8ngjIA+9B4SEv+WVSu16vRfk/PjOQd8s1FRLtj3pTpwoeRdowPzgds4t/ZDOJR7qM5UY96ZTqcGV3g6Em8clNi99N+VNPLcwqozhfYc+t/is71hSDqZMOtjchhE+oaoahUuinRWA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by SJ0PR12MB7460.namprd12.prod.outlook.com (2603:10b6:a03:48d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.18; Fri, 28 Feb
 2025 20:06:54 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87%4]) with mapi id 15.20.8466.015; Fri, 28 Feb 2025
 20:06:54 +0000
Message-ID: <7f276668-e69e-4208-8f04-2305778fffd0@amd.com>
Date: Fri, 28 Feb 2025 14:06:49 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 42/42] x86/resctrl: Add python script to move resctrl
 code to /fs/resctrl
To: Fenghua Yu <fenghuay@nvidia.com>, James Morse <james.morse@arm.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
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
References: <20250207181823.6378-1-james.morse@arm.com>
 <20250207181823.6378-43-james.morse@arm.com>
 <c86d773c-75c4-4f7a-96e0-5f36768c3981@nvidia.com>
Content-Language: en-US
From: "Moger, Babu" <bmoger@amd.com>
In-Reply-To: <c86d773c-75c4-4f7a-96e0-5f36768c3981@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA9PR10CA0024.namprd10.prod.outlook.com
 (2603:10b6:806:a7::29) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|SJ0PR12MB7460:EE_
X-MS-Office365-Filtering-Correlation-Id: 4c59693c-7665-46d8-ba59-08dd58337226
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZTU2Ym5tNnl5ZWxFb0pzSHgxTFBSbjlPODhyWjNucXpXcW43SElSUkxUSGN3?=
 =?utf-8?B?cm5zRnpkNUpKcE93djhNVk4zdHBLYm5WWGlnNHB0VFZVMjdFUndCOW9XOUVy?=
 =?utf-8?B?Sk5nbXkwNVZqaFBxcFh3WUFWSktDMHlndlhnZDRjeXlqZ0RYSGlGd1dkYmlj?=
 =?utf-8?B?eTBVeURicVh1cE5xOE43emZpemR1c2Z1RjU2RGR1ZG52Yk9MdWJMNjJyTDBi?=
 =?utf-8?B?ZTJMT28xTkNOMmRLUnhDL2cybTM1YVRtRVlSa2phVldwTlgxWEFxbjN0Z0FI?=
 =?utf-8?B?aG8rMHFIN2EwajljdkREVWQxOFF3OTVyN2FJQVV3U3lnWU5ZT2N1ZWdndDdp?=
 =?utf-8?B?ZFpaZ2VpdTBVU0tWUndjMnVwRjdBOXhDdkdCMi9MVU5Iakp1Q2hKOG9YWHpR?=
 =?utf-8?B?QXE0YXR0NUJSeDBxSmNraVBValIvaXlKZ1R6YXVqTEQ1VnN5N055MVlQRTRz?=
 =?utf-8?B?dEhYQXFocjhGR2J5NWJLMTNDblJrYmlONkltb0JiaTNobmQ2WnI2N0VUYWdN?=
 =?utf-8?B?bFNPSG9mM0NrcDVXaTRGVGtxS0d3UVlPM0hzQVZkWXZtd1IvZVRxL3hyZEF5?=
 =?utf-8?B?ZHlVSStuVHAyT1RHZDU0NzdjM1R6cDZaMFdFbUlYd2FTc2k0Rkp5QStSOW9u?=
 =?utf-8?B?TGpCd2pNQlJzZ1VSblkwc1NnaGloN2hGMzBYWXQ0L3d0ZjdTSzcvM3pxNkJT?=
 =?utf-8?B?bmtkbm9IUzMwdGV0ODFuNS9Qc2tIaEZwNVB0ZkJmc3N1M3MyVjZLbW1ZcEo4?=
 =?utf-8?B?QldPUSt6bUtsbWpMMmJSazM5ZEhlWHhTajcvT1ozZGQyd0lWMmFVVDBnekZG?=
 =?utf-8?B?OUphdDRiQlQ1Z0l4R3d6Z1QySHRNUzBmb1haendncXFxWURoc0FKbWpJb0pP?=
 =?utf-8?B?Rno4YU95Nk1hSzJPc241L2hUQ1dHU29IdnBjVVBaOXlKQzljUzZVRUkrZVVY?=
 =?utf-8?B?ZjBOQXIzMTJ4dWMwR2gyOWY2MWNBMy9WeC9RMXZmSjJlcVQ1NERhYmQ4Y0Vx?=
 =?utf-8?B?Z2J3NWZxOTZIWkNhUmZ2RElydjB2cHdVekZ4S3VFcC9ES3g0bmlRRjRwdXNz?=
 =?utf-8?B?QXVLaFBzVFkwdThGZjJOemlxSjNGb3B6ZklDUS91SzlpeHRkRjJtdHErdjRW?=
 =?utf-8?B?TDJSU1hNaktUV0FkbnU1eStxVUtDa2IzeDJBZllMVkJlckx2L3JHa2tYTDFu?=
 =?utf-8?B?bCt0eHUxc0M5RFFsVVd4bkxHbmpoNkNML0E4VmVtTVB1TVdpdWhIWGl6bHM1?=
 =?utf-8?B?QlgzSjl0RWNuOFYremVXbm9xay9SNmtMSm9lRklVcmxKVm1KQTVIQXRTcyt2?=
 =?utf-8?B?alJmZHBadnRlVHZPVmllWDMyODErbWpnM0NLOHJEVWd3eDFIaEpLc09jWW5P?=
 =?utf-8?B?K2RVQWxpL0VJUWNvSzV4TFAxaFQrQm94N2JUelFzSDhYa1dqZWdVckZkMDJs?=
 =?utf-8?B?S012T2p3YmUweFBCVTZqYTQ5UWNYT1hUUzJMWWFxSml1QUN5WWdpbjY5eFRl?=
 =?utf-8?B?SVZlcndlUVlsdDNUb3p3N2poUnk0RUZJcklOTEdlOGJPNE1xYnlxbnN2bWdy?=
 =?utf-8?B?WUhHZUpXN1QrOVEyUExlcXRFTGhRYkIyblkzMlBoRXZCZEc0NmxjZmtPOFJF?=
 =?utf-8?B?MEtxTEtjVVZkRHVxL0Fmd2xEV0ErMzRRaUR2ZmYwbGRPaUZwT0tJd1RpRzFZ?=
 =?utf-8?B?UTgzVTBBVXpaQ0pEWEo0OWgzcXlVbW5UQUdZNWhDTVNzZGIvRVVmcmtWODFC?=
 =?utf-8?B?VWZBSFJzdzNmS0ZtclFpUEJrR1lHNUs0OForRVNyS0RWZUttc2tpZ1BnbkJ4?=
 =?utf-8?B?WG5xWmZuazcxM2ZPWi9sZmhrb3FuNWt6VVl5cU5rWWJkeFRhbHkwZitxbERw?=
 =?utf-8?Q?L9gi+z0qw1GAx?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?V240Ym5YclVHa1BNT3dETWR3TDRmK2Q2bzE5Y3VrUzhtdHZUWlRZdk9YOGVy?=
 =?utf-8?B?UWRrZmlSVkNoUFI3dUR0Y3krNlgzTXJIMVZxdDdzU0Q0OUwxL0ZQaHNNU3d5?=
 =?utf-8?B?RWplWnpoS3BndnhxcHdkcytZVlBPM0NrcG9jam1QQXhUbDhtd3M1Yk4rTlZM?=
 =?utf-8?B?U0k4Z3BlTWU3R0FWZGZzQWZxeXpHLytzRTBsWVQ2WFJaenp2dUszZE5Majhl?=
 =?utf-8?B?VHRESHhCaDBpd3ZOMm8rMUNiVHhsZGZ6OGJOcHlLVlVPWUtQWURTRHc3UkVu?=
 =?utf-8?B?S3p1cm5WbnVUcTdiK0thWmVWanMxTTdQWmJXSFR6VEhab2U0RGNXdXVIMWU3?=
 =?utf-8?B?UTFJQkc5dVNQZWlGV05IQzZJNDlVNFhrLzZUQXNqSVZabjlDSHYzdWF3TkMz?=
 =?utf-8?B?d2FCaFh6WnUxQkp6U1NMQzZkQjU1ZWVGaUFaTWtjQU1zMFpickFjbURyakxo?=
 =?utf-8?B?YkIyWEllM3VTRCtMSExCSFpkZ2xQNkdVNSs2VlZKT1B5SklLM3gxYnM1aFk3?=
 =?utf-8?B?c3M3bnJaajI4eDFCeXVtLzUxVXVlZlBWajJpcFZucWNjVUp0azZYWUJ0Z0dO?=
 =?utf-8?B?clBHY0tDeDJXaXVyMFJ5K1o5dXFQSU10K1d3eUNjYTM2eW5ndnVVNVFYVHdZ?=
 =?utf-8?B?ejhFQjNBT2tPTDlXTENMaVZ4cEZkMDljbG9RekRYNUdUUS9zd2dMY1NJdDVJ?=
 =?utf-8?B?S0hqclFna3dRa2d4NVI5d01HRkNqU3lyNkEwRTRRZ1YzY1NhdlhxTE5rN2g1?=
 =?utf-8?B?VDZtVEVtT29ocjVmRUdhNGpORjJaYWJZQ0JhUDJVTFNYZUxZYVh5RDlZQ3lv?=
 =?utf-8?B?VVB3MWM2UFVJZUltdEdGU0dVYXhGeEpzRldSa1ZHWDFUbUhMUnZNSElNY09n?=
 =?utf-8?B?NHJKQ1ZKc0IyTVVIb1FXUmdjdjRjOHp0dUJwNmgya0hxeDVZaEgzTk5oVGFS?=
 =?utf-8?B?RjBic3FWUGxaa1pqTzBERlVyOFBoTmdub0NPeU5OUVdZYWtYUjFkd09SS0RD?=
 =?utf-8?B?TXI0Z3JYam8yRTRNSHJYQ3NISWhwcm9RNWhKMGd0WEY5cjAyTFo5VVFRQW9W?=
 =?utf-8?B?OUNVc1hZVmp0T1JhVXA3YW5LdStHRXhpRnNkWmZLZHAxSGtQbHFNaHBkSERm?=
 =?utf-8?B?WW1RYllQc2Y5Vm1mL0FCcnIwQkV0SkxIUmhPSXdCejNGRUoxenRXY21FdVRh?=
 =?utf-8?B?V0FwRnRsSGd2OHltMWEzeVZ2UnVaQmdvNjVQNFpsN1pWb1FEVzMvM3JxSWRX?=
 =?utf-8?B?Q2NZNmNTUEJWNkYvdTZINFk0THJ2SUQzWmhpRmRJdm5hOFJNQXl4N1JXankw?=
 =?utf-8?B?YTVIWFlaQmM5ZDIzY2o3WU9nekMvQTd0NE1MRDNzVTlVT3ZhNUtWbUR2bUlH?=
 =?utf-8?B?ZGNIZUlPMVlBVy85ZUVtT2laZEE3Ym54ekxUN08yL0FOYlhncFRoSHFLVmNM?=
 =?utf-8?B?S2FRUG1nTllOQ2RLVTVjNUlwaUlYUVVtK2pDcVFlTDIrSzZxRVdVaFBRUnF0?=
 =?utf-8?B?V2dqWGtUUUo2QTA4VlpUL2Z5dGh2YWRBUzN5QXI0bkxFQUxTRXJYOWd6QVE4?=
 =?utf-8?B?SjE2NzE3Z1d1RFdOUlJ0OUhsM0d3OERRRDExOGFxU2FyRHBqZnE1QTVMS1g0?=
 =?utf-8?B?MFRLeFlvL2RERkNPTk0xb2VpSDJOblZVcHB1V3h0dytDS3A5eWxKMGJSaW1a?=
 =?utf-8?B?NW5xc1BWQ3BnMG5udFdRVWUrUE1ObFBtZXBabS9DeWFrdGJJOTRqRktmanBj?=
 =?utf-8?B?bEIrUUYrb1JKZnQxajRISnpvQTYyd25xaGh0Qlg1bHovNllWWlpCL1E1SmhU?=
 =?utf-8?B?RXIxdHFPMWh3RFY1emM5TWlhLzR0QzFvV1IvT3pkMDI1ekZSUlA4NzFrNElt?=
 =?utf-8?B?RFRwZDZtd0ZHZnQ5amJrbWNvRHQvZXZIR3gvby9PcW84SjhBenFPczdLRFlq?=
 =?utf-8?B?d2NEUUxnbmtSQW1yaitJbytSeXpSNXgvemhINFdZVDIwVGFSdnJVWWgyYlUx?=
 =?utf-8?B?TU9pOHdRZE1aNEFqU3FKYUtlT2RZWkpYSXZzWEZ5TU9NOVlDOUphS05xQm1h?=
 =?utf-8?B?VUxZaUNoditzZU4rV1ZNaHU0YTFqS1QzSmVUQjBrZnNzNGw5NzZSNGxRQTdY?=
 =?utf-8?Q?OukY=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c59693c-7665-46d8-ba59-08dd58337226
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2025 20:06:54.1242
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nxA+ii9hZTCjnH3Dw+N0LuBNOA3v8sL2cMMqIKvknOBM09GaPaTvVbIQ1xPdFLJQ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB7460

Hi All,

On 2/24/2025 11:02 PM, Fenghua Yu wrote:
> Hi, James and Reinette,
> 
> On 2/7/25 10:18, James Morse wrote:
>> To support more than one architecture resctrl needs to move from arch/x86
>> to live under fs. Moving all the code breaks any series on the mailing
>> list, so needs scheduling carefully.
>>
>> Maintaining the patch that moves all this code has proved labour 
>> intensive.
>> It's also near-impossible to review that no inadvertent changes have
>> crept in.
>>
>> To solve these problems, temporarily add a hacky python program that
>> lists all the functions that should move, and those that should stay.
>>
>> No attempt to parse C code is made, this thing tries to name 'blocks'
>> based on hueristics about the kernel coding style. It's fragile, but
>> good enough for its single use here.
>>
>> This only exists to show I have nothing up my sleeve.
>> I don't suggested this gets merged.
>>
>> The patch this script generaets has the following corner cases:
>> * The original files are regenerated, which will add newlines that are
>>    not present in the original file.
>> * An trace-point header file the only contains boiler-plate is created
>>    in the arch and filesystem code. The parser doesn't know how to remove
>>    the includes for these - but its easy to 'keep' the file contents on
>>    the correct side. A follow-up patch will remove these files and their
>>    includes.
> 
> Due to no trace event defined in the _trace.h files, compilation errors 
> are reported when building kernel by W=1.
> 
> This patch seems the "follow-up" patch mentioned here? After this patch 
> is applied, no more errors reported when W=1.
> 
> diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/ 
> cpu/resctrl/monitor.c
> index 1809e3fe6ef3..800e52845b1d 100644
> --- a/arch/x86/kernel/cpu/resctrl/monitor.c
> +++ b/arch/x86/kernel/cpu/resctrl/monitor.c
> @@ -27,10 +27,6 @@
> 
>   #include "internal.h"
> 
> -#define CREATE_TRACE_POINTS
> -
> -#include "monitor_trace.h"
> -
>   /*
>    * Global boolean for rdt_monitor which is true if any
>    * resource monitoring is enabled.
> diff --git a/arch/x86/kernel/cpu/resctrl/monitor_trace.h b/arch/x86/ 
> kernel/cpu/resctrl/monitor_trace.h
> deleted file mode 100644
> index b5a142dd0f0e..000000000000
> --- a/arch/x86/kernel/cpu/resctrl/monitor_trace.h
> +++ /dev/null
> @@ -1,17 +0,0 @@
> -/* SPDX-License-Identifier: GPL-2.0 */
> -#undef TRACE_SYSTEM
> -#define TRACE_SYSTEM resctrl
> -
> -#if !defined(_FS_RESCTRL_MONITOR_TRACE_H) || 
> defined(TRACE_HEADER_MULTI_READ)
> -#define _FS_RESCTRL_MONITOR_TRACE_H
> -
> -#include <linux/tracepoint.h>
> -
> -#endif /* _FS_RESCTRL_MONITOR_TRACE_H */
> -
> -#undef TRACE_INCLUDE_PATH
> -#define TRACE_INCLUDE_PATH .
> -
> -#define TRACE_INCLUDE_FILE monitor_trace
> -
> -#include <trace/define_trace.h>
> diff --git a/fs/resctrl/pseudo_lock.c b/fs/resctrl/pseudo_lock.c
> index d8389779835d..6c49dd60174f 100644
> --- a/fs/resctrl/pseudo_lock.c
> +++ b/fs/resctrl/pseudo_lock.c
> @@ -29,10 +29,6 @@
>   #include "../../events/perf_event.h" /* For X86_CONFIG() */
>   #include "internal.h"
> 
> -#define CREATE_TRACE_POINTS
> -
> -#include "pseudo_lock_trace.h"
> -
>   /*
>    * Major number assigned to and shared by all devices exposing
>    * pseudo-locked regions.
> diff --git a/fs/resctrl/pseudo_lock_trace.h b/fs/resctrl/ 
> pseudo_lock_trace.h
> deleted file mode 100644
> index 7a6a1983953a..000000000000
> --- a/fs/resctrl/pseudo_lock_trace.h
> +++ /dev/null
> @@ -1,17 +0,0 @@
> -/* SPDX-License-Identifier: GPL-2.0 */
> -#undef TRACE_SYSTEM
> -#define TRACE_SYSTEM resctrl
> -
> -#if !defined(_X86_RESCTRL_PSEUDO_LOCK_TRACE_H) || 
> defined(TRACE_HEADER_MULTI_READ)
> -#define _X86_RESCTRL_PSEUDO_LOCK_TRACE_H
> -
> -#include <linux/tracepoint.h>
> -
> -#endif /* _X86_RESCTRL_PSEUDO_LOCK_TRACE_H */
> -
> -#undef TRACE_INCLUDE_PATH
> -#define TRACE_INCLUDE_PATH .
> -
> -#define TRACE_INCLUDE_FILE pseudo_lock_trace
> -
> -#include <trace/define_trace.h>
> 
> 

Just to confirm. I had the same build issues. This patch resolved the 
problem. Booted the system and ran basic resctrl tests and everything 
worked as expected.

Thanks
Babu

