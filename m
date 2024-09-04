Return-Path: <linux-kernel+bounces-315692-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BDA5496C5D9
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 19:57:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 414F41F2202D
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 17:57:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C6A21E1A10;
	Wed,  4 Sep 2024 17:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="MCqK0Y+k"
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2132.outbound.protection.outlook.com [40.107.95.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FC6A2AE9F
	for <linux-kernel@vger.kernel.org>; Wed,  4 Sep 2024 17:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.132
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725472633; cv=fail; b=SNaj6RXcyLn+A+SFC1pd4VpaXLuZfDDNBgd62vZlF/jwDXrDpLBKo02buyRldXtigSK1DvPFK1GVv84FHj6jN6y06WG45+clS9l4MTfSDnZF/pKDvey+H3HfJAi1sHEiYcnka+s71NVEggadWwZn17t7tn4uOrQLth0nK+3d5s4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725472633; c=relaxed/simple;
	bh=4RdICBS0wmxdmjrTeSXD4LtIY3tjnzf4LV8MjtyS7Zw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ZNoEaiNukUYb/W27P950UyWbcvPLhTySqBYGHAwZ77qW0Uc/YDLXFfQYKfRQA5873vEy4Crrg4fEl0KP9xaYJWD98gfolPDqO+xERqbM2kWK+CaUQJaN+nwfXubieJClfGYTh0/s8XMdceRf/QuMVVfxmNzF27ghLtoYFHRknzI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=MCqK0Y+k; arc=fail smtp.client-ip=40.107.95.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KRcAnz/BC+UIrRigqkuP/9nXGvMzCMbEX6zX/otI6OBnd3oJXwOXUISJIdmdpl6065W0AfZ4fWZiUL0JC6jdARMyGCldTuC9EzT7ZzAWcHT89jeX0ZUaHFUu8PWi0UXKkCuqywh/+vWNF6fBf6PWGBriXXgnZz503UL37Bzr+fL5S8twc5IIvqkPoDUZzYmUvjB7UFt0eWRDFn3zY2v1VQJJfDm65o8bW8tVnbneon8eEDqC8f6O19zNFG499qM67Aalg5Te37OG4V577bGP/xzXwRZwY2Cu9vx4aFEdxBz/5DCR1BWX3Dc5AFCpnXRMSeZt4t3QKoZYMeX5HmKkuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4pDxrOaWnT/awer4soMilCFZwiit+hjXlZd/n5jLF0A=;
 b=wTXvd//5YSwhAPWtf3T87B0Y0/y/UQ4XmyNiMrfOucyu/d4zd8qmY4UvajbSj00dx3qb9ttOO0QdCWu/wl9tlvXqnVWUcpVuKqk3m1h1F8v7B87doYyykbV7UVV7ssFKTsX5+LbPJCvAPopep7PaRN1fpyJlvZVs9FYlKVldJ/1UUy3FPvV9hQ/VIKOZSmDcqgIUs6bJo2gVGJUGdeFw75KZrliHTKYtT0CCCoIdhmhJB9fVKBPQ1bABrAkC9Vf0arriBkw3/79Py6m7mtGEDCgzziR8o+MSpcsTMjhqFPSyj63IqJtH7wilQa2u+xiepBIe+aVm1EuY80dLIVqVBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4pDxrOaWnT/awer4soMilCFZwiit+hjXlZd/n5jLF0A=;
 b=MCqK0Y+kkFBwWcxE8WEibvDuhS80SSSdHkhby2PXOwpe+r0tR/j1vUYGPAT/02JoR2uisOlWMpANbCDRxCQYs8eAnE/ukzoyZSKi+zo0Iepr1kgtE+sDSFo1YgVWEoO9WrbLQp3MF+TPn7qNcElJBYpAMQk5MaZnh2Jy7vieRDI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from CH0PR01MB6873.prod.exchangelabs.com (2603:10b6:610:112::22) by
 BL1PR01MB7675.prod.exchangelabs.com (2603:10b6:208:396::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7918.22; Wed, 4 Sep 2024 17:57:05 +0000
Received: from CH0PR01MB6873.prod.exchangelabs.com
 ([fe80::3850:9112:f3bf:6460]) by CH0PR01MB6873.prod.exchangelabs.com
 ([fe80::3850:9112:f3bf:6460%4]) with mapi id 15.20.7918.024; Wed, 4 Sep 2024
 17:57:05 +0000
Message-ID: <3ba2cc44-811b-44ff-b376-50c31b7717c3@os.amperecomputing.com>
Date: Wed, 4 Sep 2024 10:57:01 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [v2 PATCH 1/2] hugetlb: arm64: add mte support
To: David Hildenbrand <david@redhat.com>, catalin.marinas@arm.com,
 will@kernel.org, muchun.song@linux.dev, akpm@linux-foundation.org
Cc: linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
References: <20240821184752.3535276-1-yang@os.amperecomputing.com>
 <034f3269-7290-4599-8f12-72b63bf75195@redhat.com>
 <fee7218b-19c6-48d6-aa35-bd76e3473047@os.amperecomputing.com>
 <cd172334-d1d1-4ace-b4b5-a7dd42c6e58f@redhat.com>
Content-Language: en-US
From: Yang Shi <yang@os.amperecomputing.com>
In-Reply-To: <cd172334-d1d1-4ace-b4b5-a7dd42c6e58f@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH2PR14CA0033.namprd14.prod.outlook.com
 (2603:10b6:610:56::13) To CH0PR01MB6873.prod.exchangelabs.com
 (2603:10b6:610:112::22)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR01MB6873:EE_|BL1PR01MB7675:EE_
X-MS-Office365-Filtering-Correlation-Id: 5cd63f71-2d6d-4084-57b8-08dccd0afca3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VXprR3IxSWZtSUlpUWRGS09jNFl5R243c01zNEhEWXF0Yjh5b1A3YVkvNDBk?=
 =?utf-8?B?SnVxTHExdVdOTWdRb0kxdHBmdkdvQmZGcCtZdVNacnJWcXVQU1pPZkpmc1JZ?=
 =?utf-8?B?cjVES0FYSzlNUVkxd0xGUmVPM24rMFRydzlRSjAxSVE1LytaeTB3aWh0Qk84?=
 =?utf-8?B?SHB1ZnZDRkdVTTcrL1ZYUlkvYVN5cVA1UU5ZN2xIbHYzcjdOTG5oWkdXQk9R?=
 =?utf-8?B?cDV6K2tDSVNScFpoK1pNK0pIeVU5WGFtY1BWdVNIWVNuTnREY041N1lrdWgx?=
 =?utf-8?B?K0dWeTltK0FMaCtmL0pGYWRhdkJ1N3lFbXVkR0pWSUMveWRCMGlBVVFXLzhZ?=
 =?utf-8?B?cnFTZUhtM0N0OUNNVEZrTnZ5VUtPSHVHZFd3TzlWQ01TREhPTTJZdjFBTmph?=
 =?utf-8?B?UExUZWVoRWs3M1Q5WXdrTFhNRHRRVllWVk1SaDM0cWova296dHBYTDRicndz?=
 =?utf-8?B?RDdoai9YZGtxVzJTY05aMytVN0VTRmJvb2w5Ylc1cyt6WFBzOUlOUEp5RkhN?=
 =?utf-8?B?M2V0S1JIai9hQU42b2NKdS9ZM0crZHpnYzRzUG82S3NVNEtVTHVjQms2K0Nk?=
 =?utf-8?B?ZHpRd3VmZ3ZueVdkNXdCY0tuQk9OZGJpVnZkS1NBL3FVb09NRm9ZdHlwUVRN?=
 =?utf-8?B?aUs5NlA0SHJVK3hZZUNhcWNYWmxVN1JNZ2d5UlJZdDVLSW4xREtKK3h2c2VF?=
 =?utf-8?B?clVWNmtJRENpS0FCcW8rVEZ4VmVvNkNJYnhaRldxTjlXYWd4ekVCQ294aFp4?=
 =?utf-8?B?VDloZUo2V09xWUxDY3pNcG9rQlNCd2pCdU9FVHVJSFh2RC9Nb2lLYXhvOWtt?=
 =?utf-8?B?MFRSV2Zhc0k5dE80cnl2VDlBUVVtdHJVc2ZWaUlFeVBqZ3F2WmRhMUtpTlZj?=
 =?utf-8?B?YUVUZnRqTVAzQm5qb3VldFpKSVJMTWx5QWh4NENzblZRUUYyNG9iL21sdmk4?=
 =?utf-8?B?OXRDdzRmM1NuR1FrcmJzN0dNMkVrMnNFUkxaL2haTGNFNElnZFBzVUFKeW0w?=
 =?utf-8?B?V2EvcmxVNUVjclVENFYvWjBsTXJLb0Y4bHVScFk4UzJyVmtGVE5pbEczQWJq?=
 =?utf-8?B?bkFOaEtBMEMrRnF4Y3NReGthYllDN1hQeU9sNzRBUUdmQVROa3JKaHRUN3Jr?=
 =?utf-8?B?QXQ2OURkNkgrb0hBNGhNeUxKbDI0TWk4dVkxc0xYL25wRnlSR1BQUDFpUDN4?=
 =?utf-8?B?Qk1FSnhML3hvWldBVnlvZ25FcHlSMjVGVlp3YmRaMnN6SDRUSXAyN2FvMEQx?=
 =?utf-8?B?NXpIUEFKdkpWcjFYMnN1bDRFSCt1VHkvcUdhTmY5aklCUEhXOU5WSjNFUnlR?=
 =?utf-8?B?b1J5U3J6SGNrZytXR0x6V1FZNC9JTmRqMjE1bFhoUWV2WTVqQ2lYVjhzT2Yw?=
 =?utf-8?B?a3ZCUGhrRGpRTE1TRXJLZlZwVFFEZnBqZDFoZzJhMFdrbncyTER4M3Bma1pW?=
 =?utf-8?B?NDJmM0VMZklwaHhLYjZiQVhCSWFuN3NlYTh3NUhQT0NxQXQ1MW1nMEFvUU9W?=
 =?utf-8?B?SjZ1RURrQ1ZxQ2cwbHVVVzNSNm12aWpPblMwUFlQaEpqSGZKYXh6NGhxYlZD?=
 =?utf-8?B?REd4RlEyZDZJNkRrNkgvd0ZMSXJVWXV4azRZeCtNaDdGcmRiTnBzNWtFck5q?=
 =?utf-8?B?cWxLdGdmZXVwY08vR3hVVlp0WW92YTZYbUNDaHo3QUR1NGNNMFdrUVhTdWty?=
 =?utf-8?B?Qm9VVUxwUjJOa3BsSmZBWXVkRFVTd01LdVl6MnprZlU1MmprSThhTkhzUVM4?=
 =?utf-8?B?SitTSndwemdxT3M1d3Y0YVhlb2swbzhNN2NkTjFKc3A0alZyQ2NZdndSbFhE?=
 =?utf-8?B?R0pHRGFpQUFUclZhRWFFdz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR01MB6873.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SGVqUFAydE9NRTJ3NGVlUWlSRS9rZGt3d1FTTEYveENRRUVkRTYvSkp4SmpL?=
 =?utf-8?B?aW1Wbzc5Qms3MC91QlA0RmpPSGx4TjBGK1FjZHVHa2ZFdko3TXArLy9kK0t4?=
 =?utf-8?B?dWpQaWU4WnRRRFJBRzZzbE1FSW5TdTE4RTJXeXZCKzdTMzlEa0pCQnZVaHZ0?=
 =?utf-8?B?Qm1QbG16Y3pEbitPUUFZVmVoYk1jSHhRa0ZYdHZMQ29TQjN1QXFvVUpHcW8r?=
 =?utf-8?B?NTljNStmUjJNVnFJR2pBV1ZqZW9lbHoyZDNTWTIzL255eU1RZmRzbzVxQiti?=
 =?utf-8?B?eHF3QzE5dU5aOXlZVmxGNUkwd2ljQlpyZzZZb2l4WmoyamF3VlMwcEdSQnZw?=
 =?utf-8?B?aVRsU25tODRwZ1V2NysxcHRkVkFNQU0vUUhta3dnaTVxMVdMSEtNeW5sc3N2?=
 =?utf-8?B?U1ZKWUN2VnpPUjFHbE1wZDUrN0xjZVpTUTd6RjNteHExY3U5ZDdaQy9VWG1y?=
 =?utf-8?B?cFhQY25jMFl1OE40ZElUd2RHdmVMRnVlRnN3c1dpRGljQnU4QVRUdGxXbWpC?=
 =?utf-8?B?aFBrR05EbUNHNXErVk5TZWRFMHZyNlZWY0YwVzI0cnJqMHR4NEs2Z2xXNUlz?=
 =?utf-8?B?cmp5V1pmT1lESU80V21GcjNnTUtyRllVMWZxZzd3WjF6VUM2QkgzTXRKbjE4?=
 =?utf-8?B?U25adzVXTlpoYlNaLzZNOHhORzA0U1pic0xYK3pQYVdmN0IySXpzMjQxVGo2?=
 =?utf-8?B?WFFkSXZMdWpraFdtZGdiZjBWTTJPRGIwVGlIUUl0NlF6ZmpHaFBySVJuREdL?=
 =?utf-8?B?UHJDQTd3RUs4NWpIVXlDaFV1aEpadjRSSldxZlJqYmw3VVB1RzB5YlErZ1Rw?=
 =?utf-8?B?WDlFdGVoZXhacE8yZ2Ntbm4vM1Vad1ZkOVFyQ3J4QzhmNFFtYWFocHFhd2RB?=
 =?utf-8?B?V2l3RUJid2FjT0xPcXhaQjlQektYanVJcnQzZ0NIaElTRXh2ZWM3SU1mQmtq?=
 =?utf-8?B?QVBxRk03WnV1S2hZYWVCRUtoZncvdWRxNDY4dXlXY01taXlwNTlPcUNOYVZr?=
 =?utf-8?B?YTQzeGtpaWlKajQ0SXpmdmxjekZjMGlTMHRrY1VJQlVoQVRqM1drQml4Y2Ez?=
 =?utf-8?B?akxhS0pUeTFVbkdVMXp1V3VlbmJPemFDMi9FOHdLMWlub043dXZTeXpkNkZo?=
 =?utf-8?B?SjZ0MUcxUUNyQ0gveXVhYkw3cTZKay84ZEdqVGN5cnVZS1VQL3NST1Q2Skxy?=
 =?utf-8?B?dnlhMjVtOGw3T0RoTWtmOEtncmoyRmtxUXdWMEppQm1DemF5dzVSN3l2RlJF?=
 =?utf-8?B?dnY1TzFEL24ydDR1SnNVVllqNFRUS1ltcFVFYnFWTHJMdTNEaTVQNk1LcE1G?=
 =?utf-8?B?dDlYbnFjSldZTHc2SUQ2U2p5TUJFSGgzTE1HdUF5ajJONmpFSlp2UUZ5YVVB?=
 =?utf-8?B?V0ZCQ2lKUDZ2YTNkOUI5aTAzUEkvUFVwUzZ4U2ZHcnIrVG95SEN3ZFlJbjht?=
 =?utf-8?B?YXZsaWFmWmhXaXFTRXUvYlpDT1JVVDY1R1MyemhWbzh0Z256aEd4bFVCSmpK?=
 =?utf-8?B?cE1VYTdFRWEwTWNhL2ZxU0pDTHdaR2lPdXdLY0NPRjhuT1BRcDFnK0RZeXVF?=
 =?utf-8?B?SzJXWGp6Q2R6VlBaL2pRcjJrenl3WUdnb3NIUUpQN2dyRmNJb1c4eTAvQzNv?=
 =?utf-8?B?cHRBa2NGRElQSG9tVGY3cU85NzFhNG80SE5ueGFkcDJPdUVheHFtN2FwQ1Nh?=
 =?utf-8?B?NEJYVjlyclJmUWVGM1g2dEdJckVDSTNhdFVBN3J2ako2N1JoQjYvQ2o2ajZu?=
 =?utf-8?B?MERTRmJrVFA2V0lDWVBSVVZPMWFQbndOQkdXSVBGcnNLTG1jVTUrK3R6R2Y2?=
 =?utf-8?B?Y1hPOFArQXAyV0tjQ1RMeElCaERaR2VoT3NjazJXNDJlUm9GaXk1dEduK3lq?=
 =?utf-8?B?akRNR25lVExmMmF0alM0QnJCZDBsdUdxY2dPRFZ6Mm03LzFYSzBWTlFaZXo0?=
 =?utf-8?B?RVNrcXNVZ1MyRjZ5dERWSmNyQjJURkJFVjlFMEF6MTIzaFd2bHI2a2lTRExL?=
 =?utf-8?B?UDl0QXBIOUVrWlZFd2gwbUF3OHNFUEs0M0oxbjdrUlNZNGdIMUJ5RDRSTm5q?=
 =?utf-8?B?c1VMMU91YndsNk95VFd3MS9zTnRqYUxOMnNzLzBtNFRzT2ZmMjhUM1FHMDNm?=
 =?utf-8?B?bzdjMWxDanRSQkQyYVQ2UVFLMWVhUjZMM1ZSWURKOFFLK2hLU2VxZVFlOGRi?=
 =?utf-8?Q?JTD+p/3Eq+b4xZ4Bhfh0/hI=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5cd63f71-2d6d-4084-57b8-08dccd0afca3
X-MS-Exchange-CrossTenant-AuthSource: CH0PR01MB6873.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2024 17:57:05.3054
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rQCiapyJJvYFha8PPCXl5ZoV/LuQNkYMmVRYUJNjPbN2iHGtvqDSS0g3dusGRboMQbX8LPe/UXCqZltX7Lbzta7qASE/gMYVGFPuL2BHsR4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR01MB7675



On 9/3/24 2:35 PM, David Hildenbrand wrote:
> On 03.09.24 18:46, Yang Shi wrote:
>>
>>
>> On 9/2/24 7:33 AM, David Hildenbrand wrote:
>>> On 21.08.24 20:47, Yang Shi wrote:
>>>> Enable MTE support for hugetlb.
>>>>
>>>> The MTE page flags will be set on the head page only.  When copying
>>>> hugetlb folio, the tags for all tail pages will be copied when copying
>>>> head page.
>>>>
>>>> When freeing hugetlb folio, the MTE flags will be cleared.
>>>>
>>>> Signed-off-by: Yang Shi <yang@os.amperecomputing.com>
>>>> ---
>>>>    arch/arm64/include/asm/hugetlb.h | 11 ++++++++++-
>>>>    arch/arm64/include/asm/mman.h    |  3 ++-
>>>>    arch/arm64/kernel/hibernate.c    |  7 +++++++
>>>>    arch/arm64/kernel/mte.c          | 25 +++++++++++++++++++++++--
>>>>    arch/arm64/kvm/guest.c           | 16 +++++++++++++---
>>>>    arch/arm64/kvm/mmu.c             | 11 +++++++++++
>>>>    arch/arm64/mm/copypage.c         | 25 +++++++++++++++++++++++--
>>>>    fs/hugetlbfs/inode.c             |  2 +-
>>>>    8 files changed, 90 insertions(+), 10 deletions(-)
>>>>
>>>> v2: * Reimplemented the patch to fix the comments from Catalin.
>>>>       * Added test cases (patch #2) per Catalin.
>>>>
>>>> diff --git a/arch/arm64/include/asm/hugetlb.h
>>>> b/arch/arm64/include/asm/hugetlb.h
>>>> index 293f880865e8..00a1f75d40ee 100644
>>>> --- a/arch/arm64/include/asm/hugetlb.h
>>>> +++ b/arch/arm64/include/asm/hugetlb.h
>>>> @@ -11,6 +11,7 @@
>>>>    #define __ASM_HUGETLB_H
>>>>      #include <asm/cacheflush.h>
>>>> +#include <asm/mte.h>
>>>>    #include <asm/page.h>
>>>>      #ifdef CONFIG_ARCH_ENABLE_HUGEPAGE_MIGRATION
>>>> @@ -20,7 +21,15 @@ extern bool
>>>> arch_hugetlb_migration_supported(struct hstate *h);
>>>>      static inline void arch_clear_hugetlb_flags(struct folio *folio)
>>>>    {
>>>> -    clear_bit(PG_dcache_clean, &folio->flags);
>>>> +    const unsigned long clear_flags = BIT(PG_dcache_clean) |
>>>> +        BIT(PG_mte_tagged) | BIT(PG_mte_lock);
>>>> +
>>>> +    if (!system_supports_mte()) {
>>>> +        clear_bit(PG_dcache_clean, &folio->flags);
>>>> +        return;
>>>> +    }
>>>> +
>>>> +    folio->flags &= ~clear_flags;
>>>>    }
>>>>    #define arch_clear_hugetlb_flags arch_clear_hugetlb_flags
>>>>    diff --git a/arch/arm64/include/asm/mman.h
>>>> b/arch/arm64/include/asm/mman.h
>>>> index 5966ee4a6154..304dfc499e68 100644
>>>> --- a/arch/arm64/include/asm/mman.h
>>>> +++ b/arch/arm64/include/asm/mman.h
>>>> @@ -28,7 +28,8 @@ static inline unsigned long
>>>> arch_calc_vm_flag_bits(unsigned long flags)
>>>>         * backed by tags-capable memory. The vm_flags may be
>>>> overridden by a
>>>>         * filesystem supporting MTE (RAM-based).
>>>>         */
>>>> -    if (system_supports_mte() && (flags & MAP_ANONYMOUS))
>>>> +    if (system_supports_mte() &&
>>>> +        (flags & (MAP_ANONYMOUS | MAP_HUGETLB)))
>>>>            return VM_MTE_ALLOWED;
>>>>          return 0;
>>>> diff --git a/arch/arm64/kernel/hibernate.c
>>>> b/arch/arm64/kernel/hibernate.c
>>>> index 02870beb271e..722e76f29141 100644
>>>> --- a/arch/arm64/kernel/hibernate.c
>>>> +++ b/arch/arm64/kernel/hibernate.c
>>>> @@ -266,10 +266,17 @@ static int swsusp_mte_save_tags(void)
>>>>            max_zone_pfn = zone_end_pfn(zone);
>>>>            for (pfn = zone->zone_start_pfn; pfn < max_zone_pfn; 
>>>> pfn++) {
>>>>                struct page *page = pfn_to_online_page(pfn);
>>>> +            struct folio *folio;
>>>>                  if (!page)
>>>>                    continue;
>>>>    +            folio = page_folio(page);
>>>> +
>>>> +            if (folio_test_hugetlb(folio) &&
>>>> +                !page_mte_tagged(&folio->page))
>>>> +                continue;
>>>
>>> Can we have folio_test_mte_tagged() whereby you make sure that only
>>> folio_test_hugetlb() uses it for now (VM_WARN_ON_ONCE) and then make
>>> sure that nobody uses page_mte_tagged() on hugetlb folios
>>> (VM_WARN_ON_ONCE)?
>>
>>
>> IIUC, you mean something like the below?
>>
>> bool folio_test_mte_tagged(struct folio *folio)
>> {
>>       VM_WARN_ON_ONCE(!folio_test_hugetlb(folio));
>>
>>       return test_bit(PG_mte_tagged, &folio->page->flags);
>
> folio->flags
>
>> }
>>
>> bool page_mte_tagged(struct page *page)
>> {
>>       struct folio *folio = page_folio(page);
>>
>>       VM_WARN_ON_ONCE(folio_test_hugetlb(folio));
>
> Yes, but better as
>
> VM_WARN_ON_ONCE(folio_test_hugetlb(page_folio(page)));

I see. But I think all the call sites for folio_test_mte_tagged() 
actually need have folio_test_hugetlb() before it. So the warn seems not 
very useful other than warning on some misuse.

>
>>
>>       return test_bit(PG_mte_tagged, &pge->flags);
>> }
>>
>>>
>>> Same for folio_set_mte_tagged() and other functions. We could slap a
>>> "hugetlb" into the function names, but maybe in the future we'll be
>>> able to use a single flag per folio (I know, it's complicated ...).
>>
>> A single flag per folio should be the future direction, but I haven't
>> done the research so can't tell how complicated it will be.
>
> There were some discussions on it, and it's tricky. So maybe we should 
> really just have folio_test_hugetlb_mte_tagged() etc. for now

Either w/ hugetlb or w/o hugetlb is fine, I don't have strong opinion on 
the naming.


