Return-Path: <linux-kernel+bounces-550303-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1B3CA55DB7
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 03:32:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A2C5D3AEF61
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 02:32:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9058914B06C;
	Fri,  7 Mar 2025 02:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="JfVHpPm2"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2043.outbound.protection.outlook.com [40.107.94.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 369BE14F90
	for <linux-kernel@vger.kernel.org>; Fri,  7 Mar 2025 02:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741314759; cv=fail; b=bVZk0VGWrK/yCGj54pzdI2rutxiDCCBd3M6YQ1sRFOcnmzt/3OLuxeo8j1hE4OUoRCcowsOPOMx4g9/NyeVFwdFkvQBDbc67+OFwnk/DQbAUjQVPGPPA5O3RcbGdBDjlECUGQesMp0A6trTRFUJEE0sAbAD9HSqQKnslkgSvHS0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741314759; c=relaxed/simple;
	bh=G/CIICs95XjzTy2plcG2pyI3vlsLW9mWAG73/BYUG4w=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=RbCrpt1/hRstPlHO0wPzVQ/gBHX61TV343LD7vFnm3y558avqWykSMVji1OBXIeQ77FyDgVD+uo7SMMUMt898s7GtK89/w9UYKvNwG/nM8Pwd/UdhKzg9bZukmbciyjCK7tcjuYWkz4YIiztQP6AoYmqF906Rza6koKrWQOYDMI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=JfVHpPm2; arc=fail smtp.client-ip=40.107.94.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dZ2T9qoCivIQBATZsxp4yLtKVAuDQXSmwemnYzsX2Lmcc93nz8hVCsj7lR/+xOHeVWRfodZ+8OnCN3TdObTLv3cywdRKzLNsIVNcaMZ8avqCKCqb1XVg/qiMS8F+TImObW/naIcIuX7zNSS/MIGnMea5UMvzRnyPX3Ab1ePIrFgEUJY9y0xMc7v30H7xfo4LKwaKkY03HDL6Us/kLFRQPWVptO9nUak2FCA58+1FevsgPajp3WS4CwlR3SvnJGq/y1O38q9IyDNBXm9jLqlZ+wzjJ4UW6ts5IGtT/QiTyB9690JiVH23HRb7cl1ybJly5D3H/175Z9guSdXWTzvOdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=laGA2EUagAej6qjCJXYq6Ka1qiGvFjygytnmEEZmhA0=;
 b=ILTxwqJ9ELgfat5ZfQjXvdYMI0NRgz/w9U7T/Jjudzl6LcFkWrxOkFP+lSn6UJUUpbcsNr1Kyq3lrBScLt8B4oJL36oXq0cj5jMC+MCLng4CX5InSfmcd5+/W5fiwtAxSViVySPK/V79i9Cl4o4YV5osq73gfRSPnoqvfPbMPFU2UNlrJTr9ELXftnTaIzrmFSINY5H0pEYThexGD/RxmuDz6Hl7jv54Fkkcbl6aPchfRFDasIgCEJkyiM8eD5Q/uPixtX30dczy+4G3L+XfcQnXCwLADZLdyNrhJgfLaGMinZfsdXwpxHlKv4XBSFGxNNceUc1E1liRm26ksr4p/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=laGA2EUagAej6qjCJXYq6Ka1qiGvFjygytnmEEZmhA0=;
 b=JfVHpPm2t5YzrvI0bMF1Ay25E7/pyoR8DdlnJDvkBXyfGO+X2P6pycpsal/l6ERNE8wfSS9HdZlBHVkplwTkJdhyJJMjtnIF8vH7ESSgaQhCVzKanNzg9J6rOtCDtP3ku6BVS9sNaYiyfLxsp81MnJa86tZsmuMXZo28C5M0dnBQv3B4kY9cpAw8DIPqarjbaOVL0HZ4QBWG8FVpYk0TOMi4DVkkNIQmQzgYZ9HD4cqzPK6ou9nG/d59kkCEfVLCvHcnrvW+TmNFC6XhtGJVYtVK13Bh6Ba4OO8THngXdDLhTTMXOHKBOARv+y0TiwasN3ksAUniUsXZGSrYz/o4rA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB2667.namprd12.prod.outlook.com (2603:10b6:5:42::28) by
 SJ1PR12MB6073.namprd12.prod.outlook.com (2603:10b6:a03:488::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.18; Fri, 7 Mar
 2025 02:32:35 +0000
Received: from DM6PR12MB2667.namprd12.prod.outlook.com
 ([fe80::bd88:b883:813d:54a2]) by DM6PR12MB2667.namprd12.prod.outlook.com
 ([fe80::bd88:b883:813d:54a2%5]) with mapi id 15.20.8511.017; Fri, 7 Mar 2025
 02:32:35 +0000
Message-ID: <bea2a7d6-9f94-4e35-a85e-932bac0ec98a@nvidia.com>
Date: Thu, 6 Mar 2025 18:32:33 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 46/49] x86,fs/resctrl: Remove duplicated trace header
 files
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
 <20250228195913.24895-47-james.morse@arm.com>
Content-Language: en-US
From: Fenghua Yu <fenghuay@nvidia.com>
In-Reply-To: <20250228195913.24895-47-james.morse@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0278.namprd03.prod.outlook.com
 (2603:10b6:a03:39e::13) To DM6PR12MB2667.namprd12.prod.outlook.com
 (2603:10b6:5:42::28)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB2667:EE_|SJ1PR12MB6073:EE_
X-MS-Office365-Filtering-Correlation-Id: 9eb117f4-ad42-43a7-5903-08dd5d20522c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OHMzempaejhzT1doZ2Mvc1RvUkplR1RTdGFkUDdRSllwK2kxNENiTFJhQkJF?=
 =?utf-8?B?N29GSDVhaldrYzZDYzlOaVVLVUVFUEtWbWZhKzVCaUtVSG1qZmFqRnZhQmR3?=
 =?utf-8?B?U3dtUnNMbnpmQWtUamV2eUdMOEdQb1VIdDNYaStBOTdpS2tueHFtSkdiaEQv?=
 =?utf-8?B?TE93OENlcDVnRnNmbFFPSEJXT1N2TG1ZRmVPaWNucjlmWFVST2lKbyt0QW8v?=
 =?utf-8?B?d0VnZnJqNkZxcGxXUE9DSXVQVjJMZlZCYnNYUDBuTUp3UGJQMStPY1FxTHZi?=
 =?utf-8?B?cmIvSVZoWmx2YXdlVEF3K0E5SXlrYTdQSXBaTXNnZXI1VEhZdjZHeEtFTWgv?=
 =?utf-8?B?MkZLbTJuNSt2YTVJWUpYcGNNZURKdVVMdERYeUQ3bW1PU0hzMjY4Wk11RFZI?=
 =?utf-8?B?R2h0WFIyQjErSXgvM3JPSWN3aXVXV0ZBNC9zT2ozZWZvR2RzWFU0YW9oUkph?=
 =?utf-8?B?cEE0UFlzYzRBb2JlVEJ4bmtvaVM5cjlhT0w4b1N2QUhzTXVkTFpzZ2J4UFIr?=
 =?utf-8?B?Q05tTDg3SHBiOWlwNUxGUDc4OWV2RHZ3Vm5TaG5TUldlYUg0Z1QyQXE2K0Jl?=
 =?utf-8?B?YnBwY01UZ2RZakNRdjlaeWpGODlBZVFlaVl2MHFId29xZ0txZEcvTXFDZFlu?=
 =?utf-8?B?dTZqcmM5RFBSWFRnM08xUWpuYUUrS2NCSURNQnNhckRqOTBxZFA2OW1tUS9n?=
 =?utf-8?B?Q3hmaG9oU1dmOVpRZXR3allNVzE2SGFaVGM5NENzREhPV1pvcG5oQmVZM2FH?=
 =?utf-8?B?T2MzNEl5TjdJaDhBTjY5QW9QY3BsQS9CR3VLa280S2IycS9HVXJscGVLZ1di?=
 =?utf-8?B?V3dMNTkvMS9TZUpDM2pjMUZldGFqSVNTVUNIbW85MmZ6VHBtZERESE9QYVFS?=
 =?utf-8?B?eUpGb0p5M09lOGdBRldrVFNUeDZvYUZTaVZkZ3hnRmhBcmdVUitjbVZOY2p4?=
 =?utf-8?B?Zm5hUnF3NUxmcG9aUWJtR0NnQkE1dm1qYVRSZjM4OXdrd3IxNG1ZZXdoVVJj?=
 =?utf-8?B?U2hZOXZnQk9JSytvZm1iOXJndTNYT1cwM0FQR1QwY2FUUWlnWGxYV2UzOFNK?=
 =?utf-8?B?MmRrNHNTYTFYM0lybTBsTlFIUmk2NEY3T05iY0ZUMitlakxNZHIybGk4R2gy?=
 =?utf-8?B?VEJGNldhL3NtbDVmK3lqNHUwb3VxTnBCWTRKbFdLSnBMTU9jWkwrN0p1dmFs?=
 =?utf-8?B?a2dmWWhSWi9FbSttQnYveW1GOWEybGM2T0NkMno0T0U0SzhpeDFEdWllN2Vm?=
 =?utf-8?B?SnlGemxyNlJQT205amZpakNFNnFkdWhYSmh0UG1POGFWM0FTckREZnhycFJV?=
 =?utf-8?B?dklCL2p2ZFNUYURqSDlsTEtIaFZnVFNWUWt0bWlEbFZwNVBHeEpyQytLZDd1?=
 =?utf-8?B?bkJIZDR0L0U1UFhlMkxTbkhkTG5uYXB1YWN3MDVQTFp4eFhhRWdCQkZUM0kr?=
 =?utf-8?B?QlE3ejZMSG5raTZIZ2k3R0lqS2Vob1ZBQlhpNzJyQWRPcVlHSzFTcExpUThY?=
 =?utf-8?B?c1R6SzBTTlZSV3JtVlEwK21QSGpHcloxblF0OG11aU95eDNMZnE0bG9JU25r?=
 =?utf-8?B?QjVMWTZxQk1NeXMxRjVVcUo5ODdwU3oxdE9uaWpVZUdQMTd1RmRLVzRkbkxZ?=
 =?utf-8?B?bG5mdE80dkFMUTVwaEI5dmREalVlWk0zcFlPRkdKcGxVZzBwSDlSeW43VWc1?=
 =?utf-8?B?Z3czRnprRGs0NGhZaCszYWFXZk0zd1VURkhidnNkWTlIZ21OSkVoTzNCdzY3?=
 =?utf-8?B?UDVzeDJnU0VvRStrc0crK0s0MlE1VCtsMFZyeUtFTnlWNkFIZWErOUxVZEVx?=
 =?utf-8?B?V3hkWjBhOHQxMWw0MWhOOTJXeEtXZzZPdWJ0TFVFa2Y3K1BTNHNtSk9BYXNV?=
 =?utf-8?Q?OnGGAB6ST4G8R?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB2667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SEJkYVZ3eGZwbjFtanpIZlVHWkN3VS8ycnJ2REpIR2x2MlpNUU1WUGJsbzU2?=
 =?utf-8?B?aHlHZW1xeHlYbHlRcGVlTC96Y3VQZ0M2K2t2L0Y0dHpGcTVxNnhIUXNxS1NZ?=
 =?utf-8?B?V2lqM3ZmUkU1NkZsd3BFclFQN1pXWFJkeW5KM1JWN3pBamt4Vlc3Y2x0dDJI?=
 =?utf-8?B?YXUzZHRwL1VMcllpMXUybzhJMlFpTG90cDkzQlp4TVZMeW13Z2dhYlZmQUNo?=
 =?utf-8?B?N2tZb2Y4Y1lLWG9uTkpyYWk5ZjJPcHZCQUtMbDNWYlpwZGdGY2JXcWQyL1pQ?=
 =?utf-8?B?MGFtVWRrbmlXTkFDdTY3allZK25tc2tiS2wrSU5UUk1zQXdiNittMmZPREhJ?=
 =?utf-8?B?eUVOcFBlaVA3YXJpRjdKZFd2TkkzRytScGZtdFBzTHRXWTF4SUpXM0RibVVw?=
 =?utf-8?B?dzcraWNlYWE3VmJ0RkNwOTNhWk01MndhOTcydjQ3endPRkxBNGN2UXdtSjJl?=
 =?utf-8?B?bFR5N2JDczFIdzk2Z1pRRjd5RWdCUGowc0ZyWG9sZytucDBDMlNzcHhHUU5s?=
 =?utf-8?B?eHVlMldQb25qWmUxS1FPY1BvRDdseHhBUDBqR3ZvWDl2eHVBdkp1RjJKYUJF?=
 =?utf-8?B?YXZHNHhTV1ZrK1drakx5QnRZTU5KK3BVU2E3TVVDOEJLRm1ldmpONzNqcDIv?=
 =?utf-8?B?dy9HMTN2Q09GTHN3clNiR2lrUmdId2x5dTNGemRGWTlYZzVqUGZ5RXorR2dC?=
 =?utf-8?B?amVTVFVQUkVNa3ppYXhWNlV0U1BTeFJtNlVmTU5Gck1XZVJ3cVNlV0lieHBV?=
 =?utf-8?B?czZOTXlMTlVLbGs3WTlCUUhFeXo5V0JVM1ZlTjIxcVBRQ21hcjU0eG9EK2Q2?=
 =?utf-8?B?R2pncWJIUDRmRTl0UlhqKy9hODlkeEY2Z09uSnNkVk5SWHVJQjJ3RW43eXJn?=
 =?utf-8?B?VE9zL3Rrd3Y5YmRCMEJ4OURWYndiMlp1OHJoRjZOVzVrS2E2alY2ZG51NFhB?=
 =?utf-8?B?WmdVVEVNcXVVM000SnAvVnhEUFdXUG00WmxDWXVlQkVQKzE4SEdYcTVPcjd1?=
 =?utf-8?B?WFAycCtndEJjUUVnT1hjU3pzMmpQTDAzZXdRZVkydkg5RUVuTlBnNlFwdjRP?=
 =?utf-8?B?V3lUaWRpN0hkUkV1TXlSN1pIQ3FzbkI5NmU2YnJFNG9XVml5c1VRSzY1S1gx?=
 =?utf-8?B?djY0V0FnVnpwelVweUd3aCtXNG9XTC8wQ2FBeXV3UUJhcmZGUStaVmlsU3ND?=
 =?utf-8?B?VXFOQzRDNWxmTkRlRTlBeEJZVkhCRm9TZUtvTk5EME5yazc4ZUhUTnVOU0ky?=
 =?utf-8?B?S2RScHRFWkUwcFlqajZSRi96bDM2d21VRy8xMTUwdFNHL0h4Wk1aOWhJRHZ0?=
 =?utf-8?B?elRKQWhPMktFQWxWNXhSZnMwbndiOU1jaVA3aGhLY0svbWx5eFhjS0pzMnA5?=
 =?utf-8?B?V09IbS95R2xEckxoQTVIS2MwNVgvOU5sNi9pSGdPSk5RMlVaV1daNTRWV2NB?=
 =?utf-8?B?RFMwdUZaUW41R2J3My9aM1NYQTFpRXVEd1EzaVgrZEtCTGFQbXhWYWg4YXhp?=
 =?utf-8?B?QmRPemowL1BjZU1DeTAyb1hJSnpIUDZEVURVZXdoNGZnQ1dTdEczb2tDTUdM?=
 =?utf-8?B?MzIrUURYVnE0MjhVMTlEVHF1anRwalVjVTl6TGFNS1VKYit1aVJIemR0QkF6?=
 =?utf-8?B?NHQ2R3czMGRMVWJIejdhVjBqMTZFdHRWTlpGajQ5WTdCY2NSd1RaVklZb1Ew?=
 =?utf-8?B?SjNvNVpZYmErR2dGSHVYUm9hbnk1WHlHLzBNM3F1bzRYdG5RcWlGSHMrc3ZQ?=
 =?utf-8?B?VHN2c2ZGY3RrUG53dHhNT3p5QXNRczRsd3hqbUw4R2pvMFZqcGZuMWwva1Fp?=
 =?utf-8?B?MlhySUNDSWhBSk5hNlpVUVdKZytQa1V2U0RNaUlmeFVCYnMvT2hrNnU2TzZR?=
 =?utf-8?B?ZGZmaDdsMDluTzJQMGRSd0xnaVhrbVltNElENlFjNDJ5azUrSjJueDJlcFR6?=
 =?utf-8?B?Mml5T0RLZ3ZOQ1hxWGpQbklKdVVib2RkWHQ3UVU4MTQwOVF3QWJvNERrQVEr?=
 =?utf-8?B?WDY1NVZFREZXdEs1OGVnMTUrUTg2SlY0dndvTHM0NHBITEl1SUFWNlM0bEJT?=
 =?utf-8?B?blo0eUdjc3E0V1lJNWI0Mkx5dFY3cmJ0eWUvMTYvZ3RJaTlJSzVTM25CYWdO?=
 =?utf-8?Q?+EfvHlg55UIjgoUIqPLNgpWAY?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9eb117f4-ad42-43a7-5903-08dd5d20522c
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2025 02:32:35.7450
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9IqWU0y8r4WuVYoLBbZBTlS9gbzdTHs+sxo+Luh6s1wvuT9wOLpnAyu5jNAdbIFeF6wUlJSHMLDukZY0RC609g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6073

Hi, James,

On 2/28/25 11:59, James Morse wrote:
> The copy-pasting python script harmlessly creates some empty trace
> point header files. Remove them.
>
> Signed-off-by: James Morse <james.morse@arm.com>
> ---
> Changes since v6:
>   * This patch is new.
> ---
>   arch/x86/kernel/cpu/resctrl/monitor.c       |  4 ----
>   arch/x86/kernel/cpu/resctrl/monitor_trace.h | 17 -----------------
>   fs/resctrl/pseudo_lock.c                    |  4 ----
>   fs/resctrl/pseudo_lock_trace.h              | 17 -----------------
>   4 files changed, 42 deletions(-)
>   delete mode 100644 arch/x86/kernel/cpu/resctrl/monitor_trace.h
>   delete mode 100644 fs/resctrl/pseudo_lock_trace.h
>
> diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
> index 1809e3fe6ef3..800e52845b1d 100644
> --- a/arch/x86/kernel/cpu/resctrl/monitor.c
> +++ b/arch/x86/kernel/cpu/resctrl/monitor.c
> @@ -27,10 +27,6 @@
>   
>   #include "internal.h"
>   
> -#define CREATE_TRACE_POINTS
> -
> -#include "monitor_trace.h"
> -
>   /*
>    * Global boolean for rdt_monitor which is true if any
>    * resource monitoring is enabled.
> diff --git a/arch/x86/kernel/cpu/resctrl/monitor_trace.h b/arch/x86/kernel/cpu/resctrl/monitor_trace.h
> deleted file mode 100644
> index b5a142dd0f0e..000000000000
> --- a/arch/x86/kernel/cpu/resctrl/monitor_trace.h
> +++ /dev/null
> @@ -1,17 +0,0 @@
> -/* SPDX-License-Identifier: GPL-2.0 */
> -#undef TRACE_SYSTEM
> -#define TRACE_SYSTEM resctrl
> -
> -#if !defined(_FS_RESCTRL_MONITOR_TRACE_H) || defined(TRACE_HEADER_MULTI_READ)
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
> index 03243c2ad764..d26cc1a2a84a 100644
> --- a/fs/resctrl/pseudo_lock.c
> +++ b/fs/resctrl/pseudo_lock.c
> @@ -30,10 +30,6 @@
>   #include "../../events/perf_event.h" /* For X86_CONFIG() */
>   #include "internal.h"
>   
> -#define CREATE_TRACE_POINTS
> -
> -#include "pseudo_lock_trace.h"
> -
>   /*
>    * Major number assigned to and shared by all devices exposing
>    * pseudo-locked regions.
> diff --git a/fs/resctrl/pseudo_lock_trace.h b/fs/resctrl/pseudo_lock_trace.h
> deleted file mode 100644
> index 7a6a1983953a..000000000000
> --- a/fs/resctrl/pseudo_lock_trace.h
> +++ /dev/null
> @@ -1,17 +0,0 @@
> -/* SPDX-License-Identifier: GPL-2.0 */
> -#undef TRACE_SYSTEM
> -#define TRACE_SYSTEM resctrl
> -
> -#if !defined(_X86_RESCTRL_PSEUDO_LOCK_TRACE_H) || defined(TRACE_HEADER_MULTI_READ)
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

This patch may be merged into patch #45 to fix the compilation errors in 
patch #45?

Thanks.

-Fenghua


